Attribute VB_Name = "transRender"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Trans3 rendering engine
' Status: B+
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================

Public Const RENDER_FPS = 60    'Super-duper important constant; frames per
                                'second to render

Public screenWidth As Integer   'width, in twips
Public screenHeight As Integer  'height, in twips
Public resX As Long
Public resY As Long             'x and y resolutions

Private Const HAND_RESOURCE_ID = 101    'Location of cursor hand
Private Const ENDFORM_RESOURCE_ID = 102 'Location of end form background

Public handHDC As Long                  'HDC to the cursor hand
Public handBackupHDC As Long            'HDC to an unaltered cursor hand
Public endFormBackgroundHDC As Long     'HDC to end form background

Public globalCanvasHeight As Long
Public globalCanvasWidth As Long

Public isoTilesX As Double  'Edit: added to fix iso scrolling. Number of isometric tiles
Public isoTilesY As Double  'the screen can fit. Assigned in showScreen

Public topX As Double       'the top x and y tile co-ords, (offset) of the scrolled board
Public topY As Double

Public scTopX As Double     'top x and y tile co-ords of scroll cache
Public scTopY As Double
Public scTilesX As Long     'size of scrollcache in tiles
Public scTilesY As Long

Public cnvBackground As Long        'canvas id of background image
Public cnvScrollCache As Long       'scroll cache canvas
Public cnvScrollCacheMask As Long   'mask for scroll cache (only used in gdi mode)

Public cnvPlayer(4) As Long         'canvas id of player canvas (for 5 players)
Public showPlayer(4) As Boolean     'show each player?
Public cnvSprites() As Long         'sprite (item) canvases

Public cnvAllPurpose As Long        'allpurpose canvas, size of screen
Public allPurposeCanvas As Long     'allpurpose canvas-- points to cnvAllPurpose

'rpgcode canvas stuff...
Public cnvRPGCodeScreen As Long     'screen that gets drawn to in RPGCode operations
Public cnvMsgBox As Long            'canvas id of message box (for rpgcode) :)
Private gbShowMsgBox As Boolean     'show the message box?
Public cnvRPGCodeBuffers(10) As Long    'canvas buffers for rpgcode (32x32) scan and mem commands
Public cnvRPGCodeAccess As Long     'rpgcode access canvas (version 2 buffer for #savescreen)
Public cnvRPGCode() As Long

Public Const TRANSP_COLOR = 16777215    'transparent color (white)
Public Const TRANSP_COLOR_ALT = 0       'alternate transparent color (black)

Private Const inDXMode As Boolean = True
Private inFullScreenMode As Boolean

Public lastRender As BoardRender

Private Type PlayerRender
    canvas As Long
    stance As String
    frame As Long
End Type

Public lastPlayerRender(4) As PlayerRender 'stats for last player render
Public lastItemRender() As PlayerRender
Public lastRenderedBackground As String   'last background image rendered
Public lastTimestamp As Long 'last time that the animated tile stuff was run (should be run every 5 ms)

'canvas popup types...
Public Const POPUP_NOFX = 0         'just put the thing on the screen
Public Const POPUP_VERTICAL = 1     'vertical scroll from centre
Public Const POPUP_HORIZONTAL = 2   'horiz scroll from centre

Public addOnR As Long           'red to add
Public addOnG As Long           'green to add
Public addOnB As Long           'blue to add

Public cnvRenderNow As Long     'Allows drawing onto renderNow canvas at last step.
                                'This *finally* makes HP bars and the like possible.

Public renderRenderNowCanvas As Boolean     'Should we render cnvRenderNow?
Public renderRenderNowCanvasTranslucent As Boolean  'Render it translucently?

'=========================================================================
' Returns number of items loaded
'=========================================================================
Public Property Get maxItem()
    maxItem = UBound(boardList(activeBoardIndex).theData.itmActivate)
End Property

'=========================================================================
' Check if board can scroll
'=========================================================================
Public Sub checkScrollBounds()
    
    On Error Resume Next
    
    If boardIso() Then

        If topX + isoTilesX + 0.5 >= boardList(activeBoardIndex).theData.bSizeX Then
            topX = boardList(activeBoardIndex).theData.bSizeX - isoTilesX - 0.5
        End If

        If (topY * 2 + 1) + isoTilesY >= boardList(activeBoardIndex).theData.bSizeY Then
            topY = (boardList(activeBoardIndex).theData.bSizeY - isoTilesY - 1) / 2
        End If

    Else
        'Original code
        If topX + tilesX > boardList(activeBoardIndex).theData.bSizeX Then
            topX = boardList(activeBoardIndex).theData.bSizeX - tilesX
        End If

        If topY + tilesY > boardList(activeBoardIndex).theData.bSizeY Then
            topY = boardList(activeBoardIndex).theData.bSizeY - tilesY
        End If
    
    End If
    
    If topX < 0 Then topX = 0
    If topY < 0 Then topY = 0
    
End Sub

'=========================================================================
' Randomly return one of two values
'=========================================================================
Private Function quickSortRnd(ByVal Left As Long, ByVal Right As Long) As Long
    On Error Resume Next
    If (Rnd(1) * 2) = 1 Then
        quickSortRnd = Left
    Else
        quickSortRnd = Right
    End If
End Function

'=========================================================================
' Sort sprites in best drawing order
'=========================================================================
Private Sub quickSortSprites(ByRef toSort() As Long, ByRef indicies() As Long, ByVal Left As Long, ByVal Right As Long)

    On Error Resume Next

    Dim last As Long
    last = Left

    If (Left > Right) Then
        Exit Sub
    End If
    
    Dim theRnd As Long
    theRnd = quickSortRnd(Left, Right)
    Call quickSortSwap(toSort, Left, theRnd)
    Call quickSortSwap(indicies, Left, theRnd)

    Dim i As Long
    For i = Left + 1 To Right
        If (toSort(i) < toSort(Left)) Then
            Call quickSortSwap(toSort, last + 1, i)
            Call quickSortSwap(indicies, last + 1, i)
            last = last + 1
        End If
    Next i
    
    Call quickSortSwap(toSort, Left, last)
    Call quickSortSwap(indicies, Left, last)
    
    Call quickSortSprites(toSort, indicies, Left, last - 1)
    Call quickSortSprites(toSort, indicies, last + 1, Right)
End Sub

'=========================================================================
' Swap two values in an array
'=========================================================================
Private Sub quickSortSwap(ByRef toSort() As Long, ByVal Left As Long, ByVal Right As Long)
    On Error Resume Next
    Dim Temp As Long
    Temp = toSort(Left)
    toSort(Left) = toSort(Right)
    toSort(Right) = Temp
End Sub

'=========================================================================
' Redraw all layers at x, y *on the board*
'=========================================================================
Public Sub redrawAllLayersAt(ByVal xBoardCoord As Integer, ByVal yBoardCoord As Integer): On Error Resume Next

    Dim shadeR As Long, shadeB As Long, shadeG As Long
    Call getAmbientLevel(shadeR, shadeB, shadeG)
    
    'now redraw the layers...
    Dim xx As Long, yy As Long, X As Long, Y As Long, layer As Long
    
    X = xBoardCoord
    Y = yBoardCoord

    xx = X - scTopX
    yy = Y - scTopY
    
    For layer = 1 To boardList(activeBoardIndex).theData.bSizeL
        If BoardGetTile(X, Y, layer, boardList(activeBoardIndex).theData) <> "" Then
            'If there is a tile here.
        
            Call drawTileCNV(cnvScrollCache, _
                          projectPath & tilePath & BoardGetTile(X, Y, layer, boardList(activeBoardIndex).theData), _
                          xx, _
                          yy, _
                          boardList(activeBoardIndex).theData.ambientRed(X, Y, layer) + shadeR, _
                          boardList(activeBoardIndex).theData.ambientGreen(X, Y, layer) + shadeG, _
                          boardList(activeBoardIndex).theData.ambientBlue(X, Y, layer) + shadeB, False)
            
            If cnvScrollCacheMask <> -1 Then
                
                Call drawTileCNV(cnvScrollCacheMask, _
                              projectPath & tilePath & BoardGetTile(X, Y, layer, boardList(activeBoardIndex).theData), _
                              xx, _
                              yy, _
                              boardList(activeBoardIndex).theData.ambientRed(X, Y, layer) + shadeR, _
                              boardList(activeBoardIndex).theData.ambientGreen(X, Y, layer) + shadeG, _
                              boardList(activeBoardIndex).theData.ambientBlue(X, Y, layer) + shadeB, True, False)
            
            End If
        End If
    Next layer
    
End Sub

'=========================================================================
' Load pictures from resources
'=========================================================================
Private Sub loadResPictures()
    handHDC = CreateCompatibleDC(0)
    handBackupHDC = CreateCompatibleDC(0)
    endFormBackgroundHDC = CreateCompatibleDC(0)
    Call SelectObject(handHDC, LoadResPicture(HAND_RESOURCE_ID, vbResBitmap).handle)
    Call SelectObject(handBackupHDC, LoadResPicture(HAND_RESOURCE_ID, vbResBitmap).handle)
    Call SelectObject(endFormBackgroundHDC, LoadResPicture(ENDFORM_RESOURCE_ID, vbResBitmap).handle)
End Sub

'=========================================================================
' Kill pictures that were loaded from resources
'=========================================================================
Private Sub killResPictures()
    Call DeleteDC(handHDC)
    Call DeleteDC(handBackupHDC)
    'NOTE:  endFormBackgroundHDC is killed in showendform()
End Sub

'=========================================================================
' Draw all programs on a layer
'=========================================================================
Private Sub drawPrograms(ByVal layer As Long, ByVal cnv As Long, ByVal cnvMask As Long)

    On Error Resume Next
    
    Dim shadeR As Long, shadeB As Long, shadeG As Long
    Call getAmbientLevel(shadeR, shadeB, shadeG)
    
    'first things first- what prgs are on this layer?
    Dim prgNum As Long
    For prgNum = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(prgNum) <> "" And boardList(activeBoardIndex).theData.progGraphic$(prgNum) <> "None" And boardList(activeBoardIndex).theData.progGraphic$(prgNum) <> "" Then
            'check if it's activated
            Dim runIt As Boolean, checkIt As Long
            Dim valueTest As Double, num As Double
            Dim lit As String, valueTes As String
            If boardList(activeBoardIndex).theData.progActivate(prgNum) = 1 Then
                runIt = False
                checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(prgNum), lit$, num)
                If checkIt = 0 Then
                    'it's a numerical variable
                    valueTest = num
                    If valueTest = val(boardList(activeBoardIndex).theData.activateInitNum$(prgNum)) Then
                        runIt = True
                    End If
                End If
                If checkIt = 1 Then
                    'it's a literal variable
                    valueTes$ = lit$
                    If valueTes$ = boardList(activeBoardIndex).theData.activateInitNum$(prgNum) Then
                        runIt = True
                    End If
                End If
            Else
                runIt = True
            End If
            If (runIt) And (boardList(activeBoardIndex).theData.progGraphic$(prgNum) <> "None") Then
                Dim layAt As Long, X As Long, Y As Long
                layAt = boardList(activeBoardIndex).theData.progLayer(prgNum)
                If layAt = layer Then
                    'yes!  it's on this layer!
                    X = boardList(activeBoardIndex).theData.progX(prgNum)
                    Y = boardList(activeBoardIndex).theData.progY(prgNum)
                    
                    If cnv <> -1 Then
                        Call drawTileCNV(cnv, _
                                        projectPath & tilePath & boardList(activeBoardIndex).theData.progGraphic$(prgNum), _
                                        X - scTopX, _
                                        Y - scTopY, _
                                        boardList(activeBoardIndex).theData.ambientRed(X, Y, layer) + shadeR, _
                                        boardList(activeBoardIndex).theData.ambientGreen(X, Y, layer) + shadeG, _
                                        boardList(activeBoardIndex).theData.ambientBlue(X, Y, layer) + shadeB, False)
                    End If
                        
                    If cnvMask <> -1 Then
                        Call drawTileCNV(cnvMask, _
                                        projectPath & tilePath & boardList(activeBoardIndex).theData.progGraphic$(prgNum), _
                                        X - scTopX, _
                                        Y - scTopY, _
                                        boardList(activeBoardIndex).theData.ambientRed(X, Y, layer) + shadeR, _
                                        boardList(activeBoardIndex).theData.ambientGreen(X, Y, layer) + shadeG, _
                                        boardList(activeBoardIndex).theData.ambientBlue(X, Y, layer) + shadeB, True, False)
                    End If
                End If
            End If
        End If
    Next prgNum
End Sub

'=========================================================================
' Render the background of a board
'=========================================================================
Private Sub DXDrawBackground(Optional ByVal cnv As Long = -1)
    
    On Error Resume Next
    
    If boardList(activeBoardIndex).theData.brdBack <> "" Then
        'If there is a background.
        
        Dim pixelTopX As Long, pixelTopY As Long
        Dim pixelTilesX As Long, pixelTilesY As Long
        
        pixelTopX = 0 'topX,topY for the image (in pixels)
        pixelTopY = 0
        pixelTilesX = tilesX * 32 'Screen tiles width and height in pixels
        pixelTilesY = tilesY * 32
      
        Dim imageWidth As Long
        Dim imageHeight As Long
        
        'Dimensions of image, stored in canvas. Background image loaded into canvas when board loaded.
        imageWidth = GetCanvasWidth(cnvBackground)
        imageHeight = GetCanvasHeight(cnvBackground)
        
        Dim percentScrollX As Double, percentScrollY As Double
        Dim maxScrollX As Double, maxScrollY As Double
        Dim tilesXTemp As Double
        
        If boardIso() Then
            tilesXTemp = isoTilesX
        Else
            tilesXTemp = tilesX
        End If
        
        If imageWidth > pixelTilesX Then
            'If image wider than screen
            
            percentScrollX = topX / (boardList(activeBoardIndex).theData.bSizeX - tilesXTemp)
            maxScrollX = imageWidth - pixelTilesX
            pixelTopX = Int(maxScrollX * percentScrollX)
        End If
        
        'Slightly different for Y
        
        If imageHeight > pixelTilesY Then
            If boardIso() Then
                'If image taller than screen. Isometric version:
                
                percentScrollY = topY * 2 / (boardList(activeBoardIndex).theData.bSizeY - 1 - isoTilesY)
                maxScrollY = imageHeight - pixelTilesY
                pixelTopY = Int(maxScrollY * percentScrollY)
                
            Else
                'If image taller than screen. Normal version.
                
                percentScrollY = topY / (boardList(activeBoardIndex).theData.bSizeY - tilesY)
                maxScrollY = imageHeight - pixelTilesY
                pixelTopY = Int(maxScrollY * percentScrollY)
            End If
        End If
        
        If cnv = -1 Then
            Call DXDrawCanvasPartial(cnvBackground, 0, 0, pixelTopX, pixelTopY, pixelTilesX, pixelTilesY)
        Else
            Call Canvas2CanvasBltPartial(cnvBackground, cnv, 0, 0, pixelTopX, pixelTopY, pixelTilesX, pixelTilesY)
        End If
    End If

End Sub

'=========================================================================
' Render the board
'=========================================================================
Private Sub DXDrawBoard(Optional ByVal cnvTarget As Long = -1)

    On Error Resume Next

    'Now blt the contents of the scrollcache over to the screen...

    Dim x1 As Long
    Dim y1 As Long

    x1 = (topX - scTopX) * 32
    y1 = (topY - scTopY) * 32

    'Isometric scrolling fix: forces board to scroll twice the distance.
    If boardIso() Then x1 = (topX - scTopX) * 64

    If cnvTarget = -1 Then 'Render to screen (to the scrollcache).

        If usingDX() Then
            Call DXDrawCanvasTransparentPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR)
        Else
            Call DXDrawCanvasPartial(cnvScrollCacheMask, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
            Call DXDrawCanvasPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        End If

    Else 'Render to canvas

        If usingDX() Then
            Call Canvas2CanvasBltTransparentPartial(cnvScrollCache, _
                                                    cnvTarget, _
                                                    0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR)
        Else
            Call Canvas2CanvasBltPartial(cnvScrollCacheMask, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
            Call Canvas2CanvasBltPartial(cnvScrollCache, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        End If
    End If

End Sub

'=========================================================================
' Render a canvas in a certain way (called only by CBPopupCanvas)
'=========================================================================
Public Sub PopupCanvas(ByVal cnv As Long, ByVal X As Long, ByVal Y As Long, ByVal stepSize As Long, ByVal popupType As Long)

    On Error Resume Next

    Dim W As Long
    Dim h As Long
    Dim c As Long
    Dim cnt As Long
    If CanvasOccupied(cnv) Then
        W = GetCanvasWidth(cnv)
        h = GetCanvasHeight(cnv)
        Call CanvasGetScreen(cnvAllPurpose)
        Select Case popupType
            Case POPUP_NOFX:
                'just put it on the screen
                Call DXDrawCanvas(cnv, X, Y)
                Call DXRefresh
                
            Case POPUP_VERTICAL:
                stepSize = -stepSize
                For c = h / 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, X, Y + c, 0, 0, W, h / 2 - c)
                    Call DXDrawCanvasPartial(cnv, X, Y + h / 2, 0, h - cnt, W, h / 2 - c)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(walkDelay)
                Next c
                Call DXDrawCanvas(cnv, X, Y)
                Call DXRefresh
        
            Case POPUP_HORIZONTAL:
                stepSize = -stepSize
                For c = W / 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, X + c, Y, 0, 0, W / 2 - c, h)
                    Call DXDrawCanvasPartial(cnv, X + W / 2, Y, W - cnt, 0, W / 2 - c, h)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(walkDelay)
                Next c
                Call DXDrawCanvas(cnv, X, Y)
                Call DXRefresh
        End Select
    End If
End Sub

'=========================================================================
' Render animated tiles (requires 5ms clock sync)
'=========================================================================
Private Function renderAnimatedTiles(ByVal cnv As Long, ByVal cnvMask As Long) As Boolean

    On Error Resume Next
    
    Dim toRet As Boolean
    Dim hdc As Long
    Dim hdcMask As Long
    Dim t As Long
    Dim lightShade As Long
    Dim X As Double
    Dim Y As Double
    Dim xx As Double
    Dim yy As Double
    Dim lll As Long
    Dim ext As String
    
    If boardList(activeBoardIndex).theData.hasAnmTiles Then
        'there are animated tiles on this board...
        'cycle thru them...
        
        For t = 0 To boardList(activeBoardIndex).theData.anmTileInsertIdx - 1
            If TileAnmShouldDrawFrame(boardList(activeBoardIndex).theData.animatedTile(t).theTile) Then
                toRet = True
                
                Dim shadeR As Long, shadeB As Long, shadeG As Long
                Call getAmbientLevel(shadeR, shadeB, shadeG)
                
                'now redraw the layers...
                X = boardList(activeBoardIndex).theData.animatedTile(t).X
                Y = boardList(activeBoardIndex).theData.animatedTile(t).Y
                xx = boardList(activeBoardIndex).theData.animatedTile(t).X - scTopX
                yy = boardList(activeBoardIndex).theData.animatedTile(t).Y - scTopY
                
                For lll = 1 To boardList(activeBoardIndex).theData.bSizeL
                    If BoardGetTile(X, Y, lll, boardList(activeBoardIndex).theData) <> "" Then
                        ext$ = GetExt(BoardGetTile(X, Y, lll, boardList(activeBoardIndex).theData))
                        If UCase$(ext$) <> "TAN" Then
                            'not the animated part
                            If cnv <> -1 Then
                                Call drawTileCNV(cnv, _
                                              projectPath & tilePath & BoardGetTile(X, Y, lll, boardList(activeBoardIndex).theData), _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientRed(X, Y, lll) + shadeR, _
                                              boardList(activeBoardIndex).theData.ambientGreen(X, Y, lll) + shadeG, _
                                              boardList(activeBoardIndex).theData.ambientBlue(X, Y, lll) + shadeB, False)
                            End If
                            
                            If cnvMask <> -1 Then
                                Call drawTileCNV(cnvMask, _
                                              projectPath & tilePath & BoardGetTile(X, Y, lll, boardList(activeBoardIndex).theData), _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientRed(X, Y, lll) + shadeR, _
                                              boardList(activeBoardIndex).theData.ambientGreen(X, Y, lll) + shadeG, _
                                              boardList(activeBoardIndex).theData.ambientBlue(X, Y, lll) + shadeB, True, False)
                            End If
                        Else
                            If cnv <> -1 Then
                                If cnvMask <> -1 Then
                                    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                                cnv, _
                                                                xx, _
                                                                yy, _
                                                                boardList(activeBoardIndex).theData.ambientRed(X, Y, lll) + shadeR, _
                                                                boardList(activeBoardIndex).theData.ambientGreen(X, Y, lll) + shadeG, _
                                                                boardList(activeBoardIndex).theData.ambientBlue(X, Y, lll) + shadeB, False)
                                Else
                                    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                                cnv, _
                                                                xx, _
                                                                yy, _
                                                                boardList(activeBoardIndex).theData.ambientRed(X, Y, lll) + shadeR, _
                                                                boardList(activeBoardIndex).theData.ambientGreen(X, Y, lll) + shadeG, _
                                                                boardList(activeBoardIndex).theData.ambientBlue(X, Y, lll) + shadeB, True, True, False)
                                End If
                            End If
                            If cnvMask <> -1 Then
                                Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                            cnvMask, _
                                                            xx, _
                                                            yy, _
                                                            boardList(activeBoardIndex).theData.ambientRed(X, Y, lll) + shadeR, _
                                                            boardList(activeBoardIndex).theData.ambientGreen(X, Y, lll) + shadeG, _
                                                            boardList(activeBoardIndex).theData.ambientBlue(X, Y, lll) + shadeB, True, True, True)
                            End If
                        End If
                    End If
                Next lll
            End If 'end of should i draw this frame check
        Next t
    End If

    renderAnimatedTiles = toRet
End Function

'=========================================================================
' Determine if the board's background needs to be rendered
'=========================================================================
Private Function renderBackground() As Boolean

    On Error Resume Next
    
    If lastRenderedBackground <> boardList(activeBoardIndex).theData.brdBack Then
        Call CanvasFill(cnvBackground, 0)
        If boardList(activeBoardIndex).theData.brdBack <> "" Then
            Call CanvasLoadFullPicture(cnvBackground, projectPath & bmpPath & boardList(activeBoardIndex).theData.brdBack, resX, resY)
        End If
        renderBackground = True
        lastRenderedBackground = boardList(activeBoardIndex).theData.brdBack
    Else
        renderBackground = False
    End If

End Function

'=========================================================================
' Render a canvas (full-screen)
'=========================================================================
Public Sub renderCanvas(ByVal cnv As Long)
    On Error Resume Next
    Call DXClearScreen(0)
    Call DXDrawCanvas(cnv, 0, 0)
    Call DXRefresh
End Sub

'=========================================================================
' Render the board's scroll cache
'=========================================================================
Private Sub renderScrollCache(ByVal cnv As Long, ByVal cnvMask As Long, ByVal tX As Long, ByVal tY As Long)

    On Error Resume Next

    Dim currentRender As New BoardRender
    With currentRender
        .canvas = cnv
        .canvasMask = cnvMask
        .topX = tX
        .topY = tY
        Call .Render
    End With

    Set lastRender = currentRender

    Call Unload(currentRender)
    Set currentRender = Nothing

End Sub

'=========================================================================
' Determine if two PlayerRender structures are equal
'=========================================================================
Private Function PlayerRenderEqual(ByRef rend1 As PlayerRender, ByRef rend2 As PlayerRender) As Boolean
    On Error Resume Next
    If rend1.canvas = rend2.canvas And _
        rend1.stance = rend2.stance And _
        rend1.frame = rend2.frame Then
        PlayerRenderEqual = True
    End If
End Function

'=========================================================================
' Draw a sprite
'=========================================================================
Private Sub putSpriteAt(ByVal cnvFrameID As Long, ByVal boardX As Double, ByVal boardY As Double, ByVal boardL As Long, _
                ByRef pending As PENDING_MOVEMENT, Optional ByVal cnvTarget As Long = -1, Optional ByVal bAccountForUnderTiles As Boolean = True)
    
    '==========================================
    'REWRITTEN: [Isometrics - Delano - 3/05/04]
    'FIXED: Edge of screen problems.
    'ADDED: a new argument: "pending". Using pending movements to fix iso transluscent problems.
    '"pending" is also passed to getBottomCentreX - this is an isometric fix.
    'MISSING: Partial transluscency functions do not seem to have been written yet... needed for
    'transluscent sprites at edge of board, etc.
    '===========================================
    
    'Draw the sprite in canvas cnv at boardx, boardy, boardlayer [playerPosition]
    'The bottom of the sprite will touch the centre of boardx, boardy
    'It will be centred horiztonally about this point.
    'If cnvTarget=-1 then render to screen, else render to canvas
    'Can also set the opacity of sprites in this function.
    
    'Called by DXDrawSprites only. New arguments added in these calls.

    On Error Resume Next
  
    'Using local varibles as the values may change. Or could pass the co-ords as ByVal arguments instead.
    Dim xOrig As Double, yOrig As Double, xTarg As Double, yTarg As Double
    
    xOrig = pending.xOrig
    yOrig = pending.yOrig
    xTarg = pending.xTarg
    yTarg = pending.yTarg
    
    If xOrig > boardList(activeBoardIndex).theData.bSizeX Or xOrig < 0 Then xOrig = Round(boardX)
    If yOrig > boardList(activeBoardIndex).theData.bSizeY Or yOrig < 0 Then yOrig = Round(boardY)
    If xTarg > boardList(activeBoardIndex).theData.bSizeX Or xTarg < 0 Then xTarg = Round(boardX)
    If yTarg > boardList(activeBoardIndex).theData.bSizeY Or yTarg < 0 Then yTarg = Round(boardY)
    
    Dim targetTile As Double, originTile As Double
    
    targetTile = boardList(activeBoardIndex).theData.tiletype(xTarg, yTarg, Int(boardL))
    originTile = boardList(activeBoardIndex).theData.tiletype(xOrig, yOrig, Int(boardL))
       
    Dim centreX As Long, centreY As Long
    
    'Determine the centrepoint of the tile in pixels.
    centreX = getBottomCentreX(boardX, boardY, pending) 'Note: new arguments!
    centreY = getBottomCentreY(boardY)
       
    Dim spriteWidth As Long, spriteHeight As Long, cornerX As Long, cornerY As Long
    
    'The dimensions of the sprite frame, in pixels.
    spriteWidth = GetCanvasWidth(cnvFrameID)
    spriteHeight = GetCanvasHeight(cnvFrameID)
        
    'Will place the top left corner of the sprite frame at cornerX, cornerY:
    cornerX = centreX - (spriteWidth / 2)
    cornerY = centreY - spriteHeight
       
    Dim offsetX As Long, offsetY As Long
    'Offset on the sprite's frame from the top left corner (cornerX, cornerY)
    
    Dim renderWidth As Long, renderHeight As Long
    'Portion of frame to be drawn, after offset considerations.
       
    If cornerX < 0 Or cornerY < 0 Or _
        (cornerX + spriteWidth > resX) Or (cornerY + spriteHeight > resY) Then
        'If sprite frame will lie outside the bounds of the screen resolution.
                
        If cornerX < 0 Then
            'Frame off left side. cornerX must never be less than zero! (will crash)
            offsetX = Abs(cornerX)
            renderWidth = spriteWidth - offsetX
            cornerX = 0
            
            'Temporary fix. Until partial transparent function is written.
            bAccountForUnderTiles = False
            
        ElseIf cornerX + spriteWidth > resX Then 'Must never be greater than resX!!
            'Frame off right side.
            offsetX = 0
            renderWidth = resX - cornerX
            
            'Temporary fix. Until partial transparent function is written.
            bAccountForUnderTiles = False
            
        Else
            offsetX = 0
            renderWidth = spriteWidth
        End If
        
        If cornerY < 0 Then
            'Frame off top. cornerY must never be less than zero!
            offsetY = Abs(cornerY)
            renderHeight = spriteHeight - offsetY
            cornerY = 0
            
            'Temporary fix. Until partial transparent function is written.
            bAccountForUnderTiles = False
            
            
        ElseIf cornerY + spriteHeight > resY Then
            'Frame off bottom.
            offsetY = 0
            renderHeight = resY - cornerY
            
            'Temporary fix. Until partial transparent function is written.
            bAccountForUnderTiles = False
            
        Else
            offsetY = 0
            renderHeight = spriteHeight
        End If
        
        'We now have the position and area of the sprite to draw.
        'Check if we need to draw the sprite transluscently:
        
        'ORIGINAL statement:
        'If bAccountForUnderTiles And (checkAbove(boardx, boardy, boardL) = 1 Or boardList(activeBoardIndex).theData.tiletype(Int(boardx), Int(boardy), Int(boardL)) = 2) Then
        
        'NEW statement: note "Round" instead of "Int":
        
        If bAccountForUnderTiles And (checkAbove(boardX, boardY, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardX) = xTarg And Round(boardY) = yTarg) _
            Or (originTile = UNDER And Round(boardX) = xOrig And Round(boardY) = yOrig) _
            Or (targetTile = UNDER And originTile = UNDER)) Then
            
            'If bAccountForUnderTiles AND [tiles on layers above
            '    OR [Moving *to* "under" tile (target)]
            '    OR [Moving *from* "under" tile (origin)]
            '    OR [Moving between "under" tiles]]
            
            'If on "under" tiles, make sprite transluscent.
            '4th argument controls opacity of sprite.
            
            If cnvTarget = -1 Then 'Draw to screen
            
               'BUG: This should be a Draw-Partial function! But there is none for transluscent!!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, TRANSP_COLOR)
                
            Else 'Draw to canvas.
            
                'BUG: This should be Partial AND Canvas2CanvasBlt AND transluscent!! No such function!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, TRANSP_COLOR)
                
            End If
            
        Else
            'Draw solid. Transparent refers to the transparent colour (alpha) on the frame.
            
            If cnvTarget = -1 Then 'Draw to screen
                Call DXDrawCanvasTransparentPartial(cnvFrameID, cornerX, cornerY, offsetX, offsetY, renderWidth, renderHeight, TRANSP_COLOR)
                
            Else 'Draw to canvas
                Call Canvas2CanvasBltTransparentPartial(cnvFrameID, cnvTarget, cornerX, cornerY, offsetX, offsetY, renderWidth, renderHeight, TRANSP_COLOR)
                
            End If
        End If
        
        
    Else 'Sprite is entirely on the board.
    
        'Check if we need to draw the sprite transluscent.
    
        'ORIGINAL statement:
        'If bAccountForUnderTiles And (checkAbove(boardx, boardy, boardL) = 1 Or boardList(activeBoardIndex).theData.tiletype(Int(boardx), Int(boardy), Int(boardL)) = 2) Then
        
        'NEW: should be identical to above statement.
        
        If bAccountForUnderTiles And (checkAbove(boardX, boardY, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardX) = xTarg And Round(boardY) = yTarg) _
            Or (originTile = UNDER And Round(boardX) = xOrig And Round(boardY) = yOrig) _
            Or (targetTile = UNDER And originTile = UNDER)) Then
            
            'If bAccountForUnderTiles AND [tiles on layers above
            '    OR [Moving *to* "under" tile (target)]
            '    OR [Moving *from* "under" tile (origin)]
            '    OR [Moving between "under" tiles]]
            
            'If on "under" tiles, make sprite transluscent.
            
            If cnvTarget = -1 Then 'Draw to screen
               Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, TRANSP_COLOR)
               
            Else 'Draw to canvas
                'This should be Canvas2CanvasBlt transluscent!!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, TRANSP_COLOR)
                
            End If
            
        Else
            If cnvTarget = -1 Then 'Draw to screen
                Call DXDrawCanvasTransparent(cnvFrameID, cornerX, cornerY, TRANSP_COLOR)
            Else 'Draw to canvas
                Call Canvas2CanvasBltTransparent(cnvFrameID, cnvTarget, cornerX, cornerY, TRANSP_COLOR)
            End If
        End If
    End If
        
End Sub

'=========================================================================
' Render a plyer (remove string stances!!!!)
'=========================================================================
Private Function renderPlayer(ByVal cnv As Long, ByRef thePlayer As TKPlayer, ByVal stance As String, ByVal frame As Long, ByVal idx As Long) As Boolean

    'thePlayer is the player
    'stance is the player animation to use
    'frame is the frame of the stance to use
    
    'built-in stances:
    'WALK_S
    'WALK_N
    'WALK_E
    'WALK_W
    'WALK_NW
    'WALK_NE
    'WALK_SW
    'WALK_SE
    'FIGHT
    'DEFEND
    'SPC
    'DIE
    'REST
    On Error Resume Next
    
    Dim toRet As Boolean
    toRet = True
    
    'set up render...
    Dim currentRender As PlayerRender
    currentRender.canvas = cnv
    currentRender.stance = stance
    currentRender.frame = frame
    
    If PlayerRenderEqual(currentRender, lastPlayerRender(idx)) Then
        'don't have to re-render!
        toRet = False
        renderPlayer = toRet
        Exit Function
    End If
    
    lastPlayerRender(idx) = currentRender
   
    Dim stanceAnm As String
    stanceAnm = playerGetStanceAnm(stance, thePlayer)
    
    Call renderSpriteFrame(cnv, stanceAnm, frame)
    renderPlayer = toRet

End Function

'=========================================================================
' Render an item
'=========================================================================
Private Function renderItem(ByVal cnvFrameID As Long, ByRef theItem As TKItem, ByRef itemPosition As PLAYER_POSITION, ByVal idx As Long) As Boolean

    'EDITED: [Isometrics - Delano - 11/04/04]
    'Added code to check if the item is in the viewable area for an isometric board.

    'theItem is the current item
    'stance is the item animation to use
    'frame is the frame of the stance to use
    
    'Called by RenderNow only.
    
    'built-in stances:
    'WALK_S
    'WALK_N
    'WALK_E
    'WALK_W
    'WALK_NW
    'WALK_NE
    'WALK_SW
    'WALK_SE
    'FIGHT
    'DEFEND
    'SPC
    'DIE
    'REST
    
    On Error Resume Next
    
    renderItem = True
    
    'check if item is in viewable area...
    'Isometric addition:
    If boardIso() Then
        'Substituting for isoTopY = topY * 2 + 1
        'might need to substitute topx for topx + 1
        If itmPos(idx).X < topX - 1 Or _
            itmPos(idx).X > topX + isoTilesX + 1 Or _
            itmPos(idx).Y < (topY * 2 + 1) - 1 Or _
            itmPos(idx).Y > (topY * 2 + 1) + isoTilesY + 1 Then
            renderItem = False
            Exit Function
        End If
    Else
        If itmPos(idx).X < topX - 1 Or _
            itmPos(idx).X > topX + tilesX + 1 Or _
            itmPos(idx).Y < topY - 1 Or _
            itmPos(idx).Y > topY + tilesY + 1 Then
            renderItem = False
            Exit Function
        End If
    End If
    
    'set up render...
    Dim currentRender As PlayerRender
    currentRender.canvas = cnvFrameID
    currentRender.stance = itemPosition.stance
    currentRender.frame = itemPosition.frame
    
    If PlayerRenderEqual(currentRender, lastItemRender(idx)) Then
        'don't have to re-render!
        renderItem = False
        Exit Function
    End If
    
    lastItemRender(idx) = currentRender
    
    Dim stanceAnm As String
    stanceAnm = itemGetStanceAnm(itemPosition.stance, theItem)
    
    Call renderSpriteFrame(cnvFrameID, stanceAnm, itemPosition.frame)

End Function

'=========================================================================
' Create global canvases
'=========================================================================
Private Sub createCanvases(ByVal width As Long, ByVal height As Long)
    On Error Resume Next
    cnvScrollCache = CreateCanvas(width * 2, height * 2)
    scTilesX = width * 2 / 32
    scTilesY = height * 2 / 32
    If Not usingDX() Then
        cnvScrollCacheMask = CreateCanvas(width * 2, height * 2)
    Else
        cnvScrollCacheMask = -1
    End If
    scTopX = -1
    scTopY = -1
    Dim t As Long
    For t = 0 To UBound(cnvPlayer)
        cnvPlayer(t) = CreateCanvas(32, 32)
    Next t
    cnvBackground = CreateCanvas(width, height)
    cnvRPGCodeScreen = CreateCanvas(width, height)
    cnvAllPurpose = CreateCanvas(width, height)
    allPurposeCanvas = cnvAllPurpose
    cnvMsgBox = CreateCanvas(600, 100)
    For t = 0 To UBound(cnvRPGCodeBuffers)
        cnvRPGCodeBuffers(t) = CreateCanvas(32, 32)
    Next t
    cnvRPGCodeAccess = CreateCanvas(width, height)
    cnvRenderNow = CreateCanvas(width, height)
    Call CanvasFill(cnvRenderNow, 0)
    globalCanvasHeight = height
    globalCanvasWidth = width
End Sub

'=========================================================================
' Destroy global canvases
'=========================================================================
Private Sub destroyCanvases()
    On Error Resume Next
    Call DestroyCanvas(cnvScrollCache)
    If Not usingDX() Then
        Call DestroyCanvas(cnvScrollCacheMask)
    End If
    Call DestroyCanvas(cnvBackground)
    Dim t As Long
    For t = 0 To UBound(cnvPlayer)
        Call DestroyCanvas(cnvPlayer(t))
    Next t
    Call DestroyCanvas(cnvRPGCodeScreen)
    Call DestroyCanvas(cnvMsgBox)
    For t = 0 To UBound(cnvSprites)
        Call DestroyCanvas(cnvSprites(t))
    Next t
    Call DestroyCanvas(cnvAllPurpose)
    For t = 0 To UBound(cnvRPGCodeBuffers)
        Call DestroyCanvas(cnvRPGCodeBuffers(t))
    Next t
    Call DestroyCanvas(cnvRPGCodeAccess)
    For t = 0 To UBound(cnvRPGCode)
        Call DestroyCanvas(cnvRPGCode(t))
    Next t
    Call DestroyCanvas(cnvRenderNow)
End Sub

'========================================================================='
' Kill and unload the graphics system
'=========================================================================
Public Sub destroyGraphics()
    On Error Resume Next
    Call destroyCanvases
    Call CloseCanvasEngine
    Call GFXKill
    Call DXKillGfxMode
    Call killResPictures
End Sub

'=========================================================================
' Determine if the board needs to be rendered
'=========================================================================
Private Function renderBoard() As Boolean

    '=========================================================================
    'EDITED [KSNiloc] [September 2, 2004]
    '------------------------------------
    ' + Remove unused code
    ' + Now correctly returns if board needs rendering (previously always
    '   returned true!!!)
    '=========================================================================
    
    'Called by renderNow only.
    
    On Error Resume Next
    
    'check if scroll cache already contains the area we want...

    'Needs correcting for isometric boards! scroll cache holds two screens' worth
    'but this only contains half the number of isometric tiles horizontally!
    'Rewriting following code:
    'Definig temporary local variables.
    'Y is unaffected.
    
    Dim tilesXTemp As Single, scTilesXTemp As Single
   
    If boardIso() Then
        scTilesXTemp = scTilesX / 2     '= 20 (640res) = 25 (800res)
            '= IsoScTilesX = scroll cache width in iso-tiles.
        tilesXTemp = tilesX / 2         '= 10          = 12.5
            '=isoTilesX. could use in following code but code is the same.
    Else
         scTilesXTemp = scTilesX        '= 40 (640res) = 50 (800res)
         tilesXTemp = tilesX            '= 20          = 25
    End If
    
    'Same code *should* be valid for both board types...
    'Added a "- 1" to the 4th check, since in 800res scTilesY = 37.5 which gets rounded up when
    'the scrollcache is made, and should be rounded down (easiest way to correct it here!)
    
    If Not (topX >= scTopX And _
        topY >= scTopY And _
        (topX + tilesXTemp) <= (scTopX + scTilesXTemp) And _
        (topY + tilesY) <= (scTopY + scTilesY - 1) And _
        (scTopX <> -1 And scTopY <> -1)) Then
        scTopX = Int(topX - (tilesXTemp / 2))
        scTopY = Int(topY - (tilesY / 2))
        If scTopX < 0 And topX >= 0 Then scTopX = 0
        If scTopY < 0 And topY >= 0 Then scTopY = 0
        Call renderScrollCache(cnvScrollCache, cnvScrollCacheMask, scTopX, scTopY)
        Call drawPrograms(1, cnvScrollCache, cnvScrollCacheMask)
        renderBoard = True  'Board needs to be rendered!
    End If

End Function

'=========================================================================
' Render the scene now!
'=========================================================================
Public Sub renderNow(Optional ByVal cnvTarget As Long = -1, Optional ByVal forceRender As Boolean)

    On Error Resume Next

    Dim newBoard As Boolean         'update board?
    Dim newSprites As Boolean       'update sprites?
    Dim newTileAnm As Boolean       'update tile animations?
    Dim newItem As Boolean          'update items?
    Dim newBackground As Boolean    'update background?
    Dim newMultiAnim As Boolean     'update multitasking animations?
    Dim t As Long                   'for loop control variable

    'Check if we need to render the background
    newBackground = renderBackground()

    'Check if we need to render the board
    newBoard = renderBoard()

    'Check if we need to render multitasking animations
    newMultiAnim = multiAnimRender()

    'Check if we need to render the player sprites
    For t = 0 To UBound(cnvPlayer)
        If showPlayer(t) Then
            Call isPlayerIdle(t)
            If playerShouldDrawFrame(t) Then
                If renderPlayer(cnvPlayer(t), playerMem(t), pPos(t).stance, pPos(t).frame, t) Then
                    newSprites = True
                End If
            End If
        End If
    Next t

    'Check if we need to render the item sprites
    For t = 0 To maxItem
        If itemMem(t).bIsActive Then
            If renderItem(cnvSprites(t), itemMem(t), itmPos(t), t) Then
                newItem = True
            End If
        End If
    Next t

    'Check if we need to render animated tiles
    lastTimestamp = Timer()
    newTileAnm = renderAnimatedTiles(cnvScrollCache, cnvScrollCacheMask)

    'If *anything* is new, render it all
    If newBoard Or newSprites Or newTileAnm Or newItem Or newMultiAnim Or renderRenderNowCanvas Or forceRender Then

        'Fill the target with the board's color
        If cnvTarget = -1 Then
            'To the screen
            Call DXClearScreen(boardList(activeBoardIndex).theData.brdColor)
        Else
            'To a canvas
            Call CanvasFill(cnvTarget, boardList(activeBoardIndex).theData.brdColor)
        End If

        'Render background
        Call DXDrawBackground(cnvTarget)

        'Render board
        Call DXDrawBoard(cnvTarget)

        'Render sprites
        Call DXDrawSprites(cnvTarget)

        'Render multitasking animations
        Call DXDrawAnimations(cnvTarget)

        'Render the rpgcode renderNow canvas
        If renderRenderNowCanvas Then
            If cnvTarget = -1 Then
                'To the screen
                If Not renderRenderNowCanvasTranslucent Then
                    Call DXDrawCanvasTransparent(cnvRenderNow, 0, 0, 0)
                Else
                    Call DXDrawCanvasTranslucent(cnvRenderNow, 0, 0)
                End If
            Else
                'To a canvas
                If Not renderRenderNowCanvasTranslucent Then
                    Call Canvas2CanvasBltTransparent(cnvRenderNow, cnvTarget, 0, 0, 0)
                Else
                    Call Canvas2CanvasBltTranslucent(cnvRenderNow, cnvTarget, 0, 0)
                End If
            End If
        End If

        'Refresh the screen if we're rendering to it
        If cnvTarget = -1 Then
            Call DXRefresh
        End If

    End If

End Sub

'=========================================================================
' Same as renderNow, but used while running RPGCode
'=========================================================================
Public Sub renderRPGCodeScreen()

    On Error Resume Next

    'Render the rpgcode canvas
    Call DXClearScreen(0)
    Call DXDrawCanvas(cnvRPGCodeScreen, 0, 0)

    'Render the message box if it's being shown
    If gbShowMsgBox Then
        Call DXDrawCanvasTranslucent(cnvMsgBox, (tilesX * 32 - GetCanvasWidth(cnvMsgBox)) / 2, 0, 0.75, fontColor, -1)
    End If

    'Refresh the screen
    Call DXRefresh

    'Don't starve the system
    Call processEvent

End Sub

'=========================================================================
' Render a sprite
'=========================================================================
Private Sub renderSpriteFrame(ByVal cnv As Long, ByVal stanceAnm As String, ByVal frame As Long)
    Call renderAnimationFrame(cnv, stanceAnm, frame, 0, 0)
End Sub

'=========================================================================
' Render all sprites
'=========================================================================
Private Sub DXDrawSprites(ByVal cnvTarget As Long)

    'Render sprites (players and items)
    'Called by RenderNow only.
    'Calls putSpriteAt.

    On Error Resume Next

    'build some arrays for quick sorting the order we will display the sprites in...
    ReDim indicies(UBound(cnvPlayer) + maxItem) As Long
    ReDim locationValues(UBound(cnvPlayer) + maxItem) As Long
    Dim t As Long, ns As Boolean, ni As Boolean
    Dim theValue As Long
    Dim curIdx As Long

    'set up location values for players
    For t = 0 To UBound(cnvPlayer)
        If showPlayer(t) Then
            'determine a location value...
            theValue = (pPos(t).Y * boardList(activeBoardIndex).theData.bSizeY) + pPos(t).X
            'playes will have a negative index so we can differentiate them
            indicies(curIdx) = -(t + 1)
            locationValues(curIdx) = theValue
            curIdx = curIdx + 1
        End If
    Next t

    'set up location values for items...
    For t = 0 To maxItem
        If itemMem(t).bIsActive Then
            'determine a location value...
            theValue = (itmPos(t).Y * boardList(activeBoardIndex).theData.bSizeY) + itmPos(t).X
            'items will have a positive index so we can differentiate them
            indicies(curIdx) = t
            locationValues(curIdx) = theValue
            curIdx = curIdx + 1
        End If
    Next t

    'ok, now sort these to determine which order we should draw them in!
    Call quickSortSprites(locationValues, indicies, 0, curIdx - 1)

    Dim curNum As Long
    For t = 0 To curIdx - 1
        If (indicies(t) < 0) Then
            'this is a player
            curNum = (-indicies(t)) - 1
            Call putSpriteAt(cnvPlayer(curNum), _
                    pPos(curNum).X, _
                    pPos(curNum).Y, _
                    pPos(curNum).l, _
                    pendingPlayerMovement(curNum), _
                    cnvTarget)
        Else
            'this is an item
            curNum = indicies(t)
            Call putSpriteAt(cnvSprites(curNum), _
                    itmPos(curNum).X, _
                    itmPos(curNum).Y, _
                    itmPos(curNum).l, _
                    pendingItemMovement(curNum), _
                    cnvTarget)

        End If
    Next t

End Sub

'=========================================================================
' Scroll the board left
'=========================================================================
Public Sub scrollLeft(ByVal movementFraction As Double)
    On Error Resume Next
    topX = topX + movementFraction
    Call checkScrollBounds
End Sub

'=========================================================================
' Scroll the board down
'=========================================================================
Public Sub scrollDown(ByVal movementFraction As Double)
    On Error Resume Next
    topY = topY - movementFraction
    Call checkScrollBounds
End Sub

'=========================================================================
' Scroll the board down and left
'=========================================================================
Public Sub scrollDownLeft(ByVal movementFraction As Double, ByVal scrollEast As Boolean, ByVal scrollNorth As Boolean)
    'REWRITTEN: [Isometrics - Delano - 30/03/04]
    'ADDED: Receives two more arguments from pushPlayerNorthEast.
    'Scrolling directions are now independent from each other.
    'Scrolls the rendered board North and/or East (by movementFraction tiles)
    'Called by pushPlayerNorthEast only.
    
    On Error Resume Next
    
    'Correction for isometrics.
    'Correction for independent directions.
    If boardIso() Then
        'Div 2 since the sprite travels half as far for each direction compared to horizontal/vertical
        If scrollEast Then topX = topX + movementFraction / 2
        If scrollNorth Then topY = topY - movementFraction / 2
    Else
        If scrollEast Then topX = topX + movementFraction
        If scrollNorth Then topY = topY - movementFraction
    End If
    
    'check if scroll is in the bounds of the board.
    Call checkScrollBounds

End Sub

'=========================================================================
' Scroll the board down and right
'=========================================================================
Public Sub scrollDownRight(ByVal movementFraction As Double, ByVal scrollWest As Boolean, ByVal scrollNorth As Boolean)
    'REWRITTEN: [Isometrics - Delano - 31/03/04]
    'ADDED: Receives two more arguments from pushPlayerNorthWest.
    'Scrolling directions are now independent from each other.
    'Scrolls the rendered board North and/or West (by movementFraction tiles)
    'Called by pushPlayerNorthWest only.
    
    On Error Resume Next
    
    'Correction for isometrics.
    'Correction for independent directions
    If boardIso() Then
        'Div 2 since the sprite travels half as far for each direction compared to horizontal/vertical
        If scrollWest Then topX = topX - movementFraction / 2
        If scrollNorth Then topY = topY - movementFraction / 2
    Else
        If scrollWest Then topX = topX - movementFraction
        If scrollNorth Then topY = topY - movementFraction
    End If
    
    'check if in bounds...
    Call checkScrollBounds

End Sub

'=========================================================================
' Scroll the board up and left
'=========================================================================
Public Sub scrollUpLeft(ByVal movementFraction As Double, ByVal scrollEast As Boolean, ByVal scrollsouth As Boolean)
    'REWRITTEN: [Isometrics - Delano - 31/03/04]
    'ADDED: Receives two more arguments from pushPlayerSouthEast.
    'Scrolling directions are now independent from each other.
    'Scrolls the rendered board South and/or East (by movementFraction tiles)
    'Called by pushPlayerSouthEast only.
    
    On Error Resume Next
    
    'Trial correction for isometrics.
    'Trial correction for independent directions
    If boardIso() Then
        'Div 2 since the sprite travels half as far for each direction compared to horizontal/vertical
        If scrollEast Then topX = topX + movementFraction / 2
        If scrollsouth Then topY = topY + movementFraction / 2
    Else
        If scrollEast Then topX = topX + movementFraction
        If scrollsouth Then topY = topY + movementFraction
    End If
    
    'check if in bounds...
    Call checkScrollBounds
        
End Sub

'=========================================================================
' Scroll the board up and right
'=========================================================================
Public Sub scrollUpRight(ByVal movementFraction As Double, ByVal scrollWest As Boolean, ByVal scrollsouth As Boolean)
    'REWRITTEN: [Isometrics - Delano - 31/03/04]
    'ADDED: Receives two more arguments from pushPlayerSouthWest.
    'Scrolling directions are now independent from each other.
    'Scrolls the rendered board South and/or West (by movementFraction tiles)
    'Called by pushPlayerSouthWest only.
    
    On Error Resume Next
    
    'Correction for isometrics.
    'Correction for independent directions
    If boardIso() Then
        'Div 2 since the sprite travels half as far for each direction compared to horizontal/vertical
        If scrollWest Then topX = topX - movementFraction / 2
        If scrollsouth Then topY = topY + movementFraction / 2
    Else
        If scrollWest Then topX = topX - movementFraction
        If scrollsouth Then topY = topY + movementFraction
    End If
    
    'check if in bounds...
    Call checkScrollBounds
     
End Sub

'=========================================================================
' Scroll the board up
'=========================================================================
Public Sub scrollUp(ByVal movementFraction As Double)
    On Error Resume Next
    topY = topY + movementFraction
    Call checkScrollBounds
End Sub

'=========================================================================
' Scroll the board right
'=========================================================================
Public Sub scrollRight(ByVal movementFraction As Double)
    On Error Resume Next
    topX = topX - movementFraction
    Call checkScrollBounds
End Sub

'=========================================================================
' Show the message box
'=========================================================================
Public Sub showMsgBox()
    gbShowMsgBox = True
End Sub

'=========================================================================
' Hide the message box
'=========================================================================
Public Sub hideMsgBox()
    gbShowMsgBox = False
End Sub

'=========================================================================
' Init the DirectX window
'=========================================================================
Private Sub showScreen(ByVal width As Long, ByVal height As Long, Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    'Use DirectX
    Const useDX = 1

    'Update resolution
    resX = width
    resY = height

    'Number of tiles screen can hold
    tilesX = Int(width / 32)
    tilesY = Int(height / 32)

    'Dimensions of screen in isometric tiles.
    isoTilesX = tilesX / 2 '= 10.0 (640res) = 12.5 (800res)
    isoTilesY = tilesY * 2 '= 30 (640res) = 36 (800res)

    'Get fullscreen setting from main file (unless we're testing
    'a PRG, then it's always windowed)
    Dim fullScreen As Long
    If (Not testingPRG) Then
        fullScreen = mainMem.extendToFullScreen
        bShowEndForm = True
    Else
        fullScreen = 0
        bShowEndForm = False
    End If

    If fullScreen = 0 Then
        inFullScreenMode = False
        host.style = windowed
    Else
        inFullScreenMode = True
        host.style = FullScreenMode
    End If

    'Set the dimensions the host window will be created with
    With host
        .width = width * Screen.TwipsPerPixelX
        .height = height * Screen.TwipsPerPixelY
        .Top = (Screen.height - .height) / 2
        .Left = (Screen.width - .width) / 2
        If Not inFullScreenMode Then
            .width = .width + 6 * Screen.TwipsPerPixelX
            .height = .height + 24 * Screen.TwipsPerPixelY
        End If
    End With

    'Get screen depth from the main file
    Dim depth As Long
    Select Case mainMem.colordepth
        Case COLOR16: depth = 16
        Case COLOR24: depth = 24
        Case COLOR32: depth = 32
    End Select

    'Create the DirectX host window
    Call host.Create

    Do

        'enter Graphics mode...
        If DXInitGfxMode(host.hwnd, width, height, useDX, depth, fullScreen) = 0 Then
            'tried to init gfx, but failed.
            'try a different color depth...
            If (depth = 16) And (fullScreen = 0) Then
                'tried everything...
                Call Unload(host)
                Call MsgBox("Error initializing graphics mode. Make sure you have DirectX 8 or higher installed.")
                Call showEndForm(True)
            ElseIf depth = 32 Then
                depth = 24
            ElseIf depth = 24 Then
                depth = 16
            ElseIf depth = 16 Then
                fullScreen = 0
                inFullScreenMode = False
            End If
        Else
            Exit Do
        End If

    Loop

    'Now set up offscreen canvases
    Call createCanvases(width, height)

    'Clear the screen (remove backbuffer garbage)
    Call DXClearScreen(0)
    Call DXRefresh

    'Show the DirectX host window
    Call host.Show

End Sub

'=========================================================================
' Init the graphics engine
'=========================================================================
Public Sub initGraphics(Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    'Init the engine
    Call InitTkGfx
    Call initCanvasEngine

    'Load resource images
    Call loadResPictures

    'Test for joystick
    useJoystick = JoyTest()

    'Get screen width and height (in twips)
    screenWidth = Screen.height * (1 / 0.75)
    screenHeight = Screen.height

    'Get resolution x/y
    resX = (screenWidth) / Screen.TwipsPerPixelX
    resY = screenHeight / Screen.TwipsPerPixelY

    'Get res from main file
    If mainMem.mainResolution = 0 Then
        screenWidth = 640
        screenHeight = 480
    ElseIf mainMem.mainResolution = 1 Then
        screenWidth = 800
        screenHeight = 600
    ElseIf mainMem.mainResolution = 2 Then
        screenWidth = 1024
        screenHeight = 768
    End If

    'Show the screen
    Call showScreen(screenWidth, screenHeight, testingPRG)

    'Update screen width and height
    screenWidth = screenWidth * Screen.TwipsPerPixelX
    screenHeight = screenHeight * Screen.TwipsPerPixelY

End Sub

'=========================================================================
' Render animations to the target passed in
'=========================================================================
Private Sub DXDrawAnimations(Optional ByVal cnvTarget As Long = -1)
    Call renderMultiAnimations(cnvTarget)
End Sub

'=========================================================================
' Using DirectX?
'=========================================================================
Public Property Get usingDX() As Boolean
    usingDX = inDXMode
End Property

'=========================================================================
' In full-screen mode?
'=========================================================================
Public Property Get usingFullScreen() As Boolean
    usingFullScreen = inFullScreenMode
End Property
