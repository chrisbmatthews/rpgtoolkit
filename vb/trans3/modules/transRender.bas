Attribute VB_Name = "transRender"
'=========================================================================
' All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Trans3 rendering engine
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Public Declare Function DXInitGfxMode Lib "actkrt3.dll" (ByVal hwnd As Long, ByVal nScreenX As Long, ByVal nScreenY As Long, ByVal nUseDirectX As Long, ByVal nColorDepth As Long, ByVal nFullScreen As Long) As Long
Public Declare Function DXKillGfxMode Lib "actkrt3.dll" () As Long
Public Declare Function DXRefresh Lib "actkrt3.dll" () As Long
Public Declare Function DXLockScreen Lib "actkrt3.dll" () As Long
Public Declare Function DXUnlockScreen Lib "actkrt3.dll" () As Long
Public Declare Function DXDrawPixel Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long
Public Declare Function DXClearScreen Lib "actkrt3.dll" (ByVal crColor As Long) As Long
Public Declare Function DXDrawText Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal strText As String, ByVal strTypeFace As String, ByVal size As Long, ByVal clr As Long, ByVal Bold As Long, ByVal Italics As Long, ByVal Underline As Long, ByVal centred As Long, ByVal outlined As Long) As Long
Public Declare Function DXDrawCanvas Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function DXDrawCanvasTransparent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTranspColor As Long) As Long
Public Declare Function DXDrawCanvasTranslucent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
Public Declare Function DXDrawCanvasPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function DXDrawCanvasTransparentPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTranspColor As Long) As Long
Public Declare Function DXCopyScreenToCanvas Lib "actkrt3.dll" (ByVal canvasID As Long) As Long
Public Declare Function DXDrawCanvasTranslucentPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long

'=========================================================================
' Constants
'=========================================================================
Public Const HAND_RESOURCE_ID = 101         ' Cursor hand resource ID
Public Const ENDFORM_RESOURCE_ID = 102      ' End form resource ID
Public Const DEFAULT_MOUSE_ID = 103         ' Default mouse resource ID
Public Const TRANSP_COLOR = 16711935        ' Transparent color (magic pink)
Public Const TRANSP_COLOR_ALT = 0           ' Alternate transparent color (black)
Public Const POPUP_NOFX = 0                 ' Popup without an effect
Public Const POPUP_VERTICAL = 1             ' Popup vertically
Public Const POPUP_HORIZONTAL = 2           ' Popup horizontally

'=========================================================================
' Globals
'=========================================================================
Public screenWidth As Integer               ' Screen width, in twips
Public screenHeight As Integer              ' Screen height, in twips
Public resX As Long                         ' Screen width, in pixels
Public resY As Long                         ' Screen height, in pixels
Public handHdc As Long                      ' HDC of a cursor hand
Public handBackupHdc As Long                ' HDC of a backup cursor hand
Public endFormBackgroundHdc As Long         ' HDC of the end form
Public isoTilesX As Double                  ' Number of iso tiles on width
Public isoTilesY As Double                  ' Number of iso tiles on height
Public topX As Double                       ' Horizontal offset of a scrolled board
Public topY As Double                       ' Vertical offset of a scrolled board
Public scTopX As Double                     ' Horizonal offset of the scroll cache
Public scTopY As Double                     ' Vertical offset of the scroll cache
Public scTilesX As Long                     ' Maximum scroll cache capacity, on width
Public scTilesY As Long                     ' Maximum scroll cache capacity, on height
Public cnvBackground As Long                ' Canvas holding background image
Public cnvScrollCache As Long               ' Canvas holding the scroll cache
Public cnvPlayer(4) As Long                 ' Canvases for player sprites
Public showPlayer(4) As Boolean             ' Show this player?
Public cnvSprites() As Long                 ' Canvases for item sprites
Public cnvAllPurpose As Long                ' An all purpose canvas
Public cnvRpgCodeScreen As Long             ' Canvas used for RPGCode drawing
Public cnvMsgBox As Long                    ' Canvas for the message box
Public cnvRPGCodeBuffers(10) As Long        ' Canvases for scan() and mem()
Public cnvRPGCodeAccess As Long             ' saveScreen() / restoreScreen() canvas
Public cnvRPGCode() As Long                 ' Canvases for multiple save screens
Public lastPlayerRender(4) As PlayerRender  ' Last player renders
Public lastItemRender() As PlayerRender     ' Last item renders
Public lastRenderedBackground As String     ' Last rendered background image
Public addOnR As Long                       ' Red to add on
Public addOnG As Long                       ' Green to add on
Public addOnB As Long                       ' Blue to add on
Public cnvRenderNow As Long                 ' RPGCode renderNow() canvas
Public renderRenderNowCanvas As Boolean     ' Render said canvas?
Public g_dblWinIntensity As Double          ' Message window intensity

'=========================================================================
' Members
'=========================================================================
Private bShowMsgBox As Boolean              ' Show the message box?
Private inFullScreenMode As Boolean         ' Using full screen?

'=========================================================================
' A player render
'=========================================================================
Private Type PlayerRender
    canvas As Long                          ' Canvas used for this render
    stance As String                        ' Stance player was rendered in
    frame As Long                           ' Frame of this stance
    x As Double                             ' X position the render occured in
    y As Double                             ' Y position the render occured in
End Type

'=========================================================================
' Randomly return one of two values
'=========================================================================
Private Function quickSortRnd(ByVal Left As Long, ByVal Right As Long) As Long
    On Error Resume Next
    ' Randomize from 1 - 2
    If ((Rnd(1) * 2) = 1) Then
        ' Take the left number
        quickSortRnd = Left
    Else
        ' Take the right number
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
    Dim xx As Long, yy As Long, x As Long, y As Long, layer As Long

    x = xBoardCoord
    y = yBoardCoord
    xx = x - scTopX
    yy = y - scTopY

    For layer = 1 To boardList(activeBoardIndex).theData.bSizeL
        Dim bgt As String
        bgt = BoardGetTile(x, y, layer, boardList(activeBoardIndex).theData)
        If LenB(bgt) Then
            'If there is a tile here.

            Call drawTileCnv(cnvScrollCache, _
                          projectPath & tilePath & bgt, _
                          xx, _
                          yy, _
                          boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
                          boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
                          boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, False)

        End If
    Next layer

End Sub

'=========================================================================
' Load pictures from resources
'=========================================================================
Private Sub loadResPictures()
    handHdc = CreateCompatibleDC(0)
    handBackupHdc = CreateCompatibleDC(0)
    endFormBackgroundHdc = CreateCompatibleDC(0)
    Call SelectObject(handHdc, LoadResPicture(HAND_RESOURCE_ID, vbResBitmap).handle)
    Call SelectObject(handBackupHdc, LoadResPicture(HAND_RESOURCE_ID, vbResBitmap).handle)
    Call SelectObject(endFormBackgroundHdc, LoadResPicture(ENDFORM_RESOURCE_ID, vbResBitmap).handle)
End Sub

'=========================================================================
' Kill pictures that were loaded from resources
'=========================================================================
Private Sub killResPictures()
    Call DeleteDC(handHdc)
    Call DeleteDC(handBackupHdc)
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
        If (LenB(boardList(activeBoardIndex).theData.programName$(prgNum)) <> 0) And boardList(activeBoardIndex).theData.progGraphic$(prgNum) <> "None" And (LenB(boardList(activeBoardIndex).theData.progGraphic$(prgNum)) <> 0) Then
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
                Dim layAt As Long, x As Long, y As Long
                layAt = boardList(activeBoardIndex).theData.progLayer(prgNum)
                If layAt = layer Then
                    'yes!  it's on this layer!
                    x = boardList(activeBoardIndex).theData.progX(prgNum)
                    y = boardList(activeBoardIndex).theData.progY(prgNum)
                    
                    If cnv <> -1 Then
                        Call drawTileCnv(cnv, _
                                        projectPath & tilePath & boardList(activeBoardIndex).theData.progGraphic$(prgNum), _
                                        x - scTopX, _
                                        y - scTopY, _
                                        boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
                                        boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
                                        boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, False)
                    End If

                End If
            End If
        End If
    Next prgNum
End Sub

'=========================================================================
' Render the background of a board
'=========================================================================
Private Sub DXDrawBackground(Optional ByVal cnv As Long = -1): On Error Resume Next
    
    #If False Then
        'If parallaxing is disabled - to be done.
        
        Dim xDest As Long, yDest As Long, xsrc As Long, ysrc As Long, width As Long, height As Long
        If topX < 0 Then
            xDest = -topX * 32: width = getCanvasWidth(cnvBackground)
        Else
            xsrc = topX * 32: width = tilesX * 32
        End If
        If topY < 0 Then
            yDest = -topY * 32: height = getCanvasHeight(cnvBackground)
        Else
            ysrc = topY * 32: height = tilesY * 32
        End If
        
        If cnv = -1 Then
            Call DXDrawCanvasPartial(cnvBackground, xDest, yDest, xsrc, ysrc, width, height)
        Else
            Call canvas2CanvasBltPartial(cnvBackground, cnv, xDest, yDest, xsrc, ysrc, width, height)
        End If
        
    #End If

    If LenB(boardList(activeBoardIndex).theData.brdBack) Then
        'If there is a background.
        
        Dim destX As Long, destY As Long
    
        Dim pixelTopX As Long, pixelTopY As Long
        Dim pixelTilesX As Long, pixelTilesY As Long

        pixelTilesX = tilesX * 32
        pixelTilesY = tilesY * 32

        Dim imageWidth As Long, imageHeight As Long
        
        'Dimensions of image, stored in canvas. Background image loaded into canvas when board loaded.
        imageWidth = getCanvasWidth(cnvBackground)
        imageHeight = getCanvasHeight(cnvBackground)
        
        Dim percentScrollX As Double, percentScrollY As Double
        Dim maxScrollX As Double, maxScrollY As Double
        Dim tilesXTemp As Double
        
        tilesXTemp = IIf(boardList(activeBoardIndex).theData.isIsometric = 1, isoTilesX + 0.5, tilesX)
        
        If imageWidth >= pixelTilesX Then
            'If image wider than screen
            
            percentScrollX = topX / (boardList(activeBoardIndex).theData.bSizeX - tilesXTemp)
            maxScrollX = imageWidth - pixelTilesX
            pixelTopX = Int(maxScrollX * percentScrollX)
        Else
            'Centre image.
            pixelTilesX = imageWidth
            destX = IIf(boardList(activeBoardIndex).theData.isIsometric = 1, -topX * 64 - 32, -topX * 32)
            If destX < 0 Then destX = 0
        End If

        'Slightly different for Y
        If imageHeight >= pixelTilesY Then
            If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
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
        Else
            'Centre image.
            pixelTilesY = imageHeight
            destY = IIf(boardList(activeBoardIndex).theData.isIsometric = 1, -topY * 16 - 16, -topY * 32)
            If destY < 0 Then destY = 0
        End If

        If cnv = -1 Then
            Call DXDrawCanvasPartial(cnvBackground, destX, destY, pixelTopX, pixelTopY, pixelTilesX, pixelTilesY)
        Else
            Call canvas2CanvasBltPartial(cnvBackground, cnv, destX, destY, pixelTopX, pixelTopY, pixelTilesX, pixelTilesY)
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
    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then x1 = (topX - scTopX) * 64

    If cnvTarget = -1 Then 'Render to screen (to the scrollcache).
        Call DXDrawCanvasTransparentPartial(cnvScrollCache, _
            0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR _
        )

    Else 'Render to canvas
        Call canvas2CanvasBltTransparentPartial(cnvScrollCache, _
            cnvTarget, _
            0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR _
        )
    End If

End Sub

'=========================================================================
' Render a canvas in a certain way (called only by CBPopupCanvas)
'=========================================================================
Public Sub PopupCanvas(ByVal cnv As Long, ByVal x As Long, ByVal y As Long, ByVal stepSize As Long, ByVal popupType As Long)

    On Error Resume Next

    Dim w As Long
    Dim h As Long
    Dim c As Long
    Dim cnt As Long
    If canvasOccupied(cnv) Then
        w = getCanvasWidth(cnv)
        h = getCanvasHeight(cnv)
        Call canvasGetScreen(cnvAllPurpose)
        Select Case popupType
            Case POPUP_NOFX:
                'just put it on the screen
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
                
            Case POPUP_VERTICAL:
                stepSize = -stepSize
                For c = h \ 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, x, y + c, 0, 0, w, h / 2 - c)
                    Call DXDrawCanvasPartial(cnv, x, y + h / 2, 0, h - cnt, w, h / 2 - c)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(MISC_DELAY)
                Next c
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
        
            Case POPUP_HORIZONTAL:
                stepSize = -stepSize
                For c = w \ 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, x + c, y, 0, 0, w \ 2 - c, h)
                    Call DXDrawCanvasPartial(cnv, x + w \ 2, y, w - cnt, 0, w \ 2 - c, h)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(MISC_DELAY)
                Next c
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
        End Select
    End If
End Sub

'=========================================================================
' Render animated tiles
'=========================================================================
Private Function renderAnimatedTiles(ByVal cnv As Long, ByVal cnvMask As Long) As Boolean

    On Error Resume Next

    Dim toRet As Boolean
    Dim hdc As Long
    Dim hdcMask As Long
    Dim t As Long
    Dim lightShade As Long
    Dim x As Double
    Dim y As Double
    Dim xx As Double
    Dim yy As Double
    Dim lll As Long
    Dim ext As String

    Static timeStamp As Double
    If ((Timer() - timeStamp) > (5 \ 1000)) Then
        ' Update the time stamp and render
        timeStamp = Timer()
    Else
        ' Skip the render
        Exit Function
    End If

    If (boardList(activeBoardIndex).theData.hasAnmTiles) Then
        'there are animated tiles on this board...
        'cycle thru them...

        Dim shadeR As Long, shadeB As Long, shadeG As Long
        Call getAmbientLevel(shadeR, shadeB, shadeG)

        For t = 0 To boardList(activeBoardIndex).theData.anmTileInsertIdx - 1
            If TileAnmShouldDrawFrame(boardList(activeBoardIndex).theData.animatedTile(t).theTile) Then
                toRet = True
                
                'now redraw the layers...
                x = boardList(activeBoardIndex).theData.animatedTile(t).x
                y = boardList(activeBoardIndex).theData.animatedTile(t).y
                xx = boardList(activeBoardIndex).theData.animatedTile(t).x - scTopX
                yy = boardList(activeBoardIndex).theData.animatedTile(t).y - scTopY
                
                For lll = 1 To boardList(activeBoardIndex).theData.bSizeL
                    Dim bgt As String
                    bgt = BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData)
                    If LenB(bgt) Then
                        ext$ = GetExt(bgt)
                        If UCase$(ext$) <> "TAN" Then
                            'not the animated part
                            If (cnv <> -1) Then
                                Call drawTileCnv(cnv, _
                                              projectPath & tilePath & bgt, _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                                              boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                                              boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, False)
                            End If
                            
                        Else
                            If (cnv <> -1) Then
                                Call TileAnmDrawNextFrameCNV( _
                                    boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                    cnv, _
                                    xx, _
                                    yy, _
                                    boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                                    boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                                    boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, True, True, False _
                                )
                            End If
                        End If
                    End If
                Next lll
            End If
        Next t
    End If

    renderAnimatedTiles = toRet
End Function

'=========================================================================
' Determine if the board's background needs to be rendered
'=========================================================================
Private Function renderBackground() As Boolean: On Error Resume Next
    
    With boardList(activeBoardIndex).theData
    
        ' If we need to render the background.
        If (lastRenderedBackground <> .brdBack) Then
        
            ' Fill bkg will black.
            Call canvasFill(cnvBackground, 0)
            
            ' If there's an image set.
            If LenB(.brdBack) Then
                
                ' Load the full image, resize the canvas (for parallaxing).
                Call canvasLoadFullPicture(cnvBackground, projectPath & bmpPath & .brdBack, -1, -1)
                
                ' Load the image, sized to the board dimensions (no parallax).
                'If .isIsometric Then
                '    Call setCanvasSize(cnvBackground, .bSizeX * 64 - 32, .bSizeY * 16 - 16)
                'Else
                '    Call setCanvasSize(cnvBackground, .bSizeX * 32, .bSizeY * 32)
                'End If
                'Call canvasLoadSizedPicture(cnvBackground, projectPath & bmpPath & .brdBack)
                
            End If
            
            ' Update the last rendered background.
            lastRenderedBackground = .brdBack
            ' Flag we rendered the backgrond.
            renderBackground = True
        End If
        
    End With
    
End Function

'=========================================================================
' Render a canvas (full-screen)
'=========================================================================
Public Sub renderCanvas(ByVal cnv As Long)
    On Error Resume Next
    ' Black out screen
    Call DXClearScreen(0)
    ' Render the canvas
    Call DXDrawCanvas(cnv, 0, 0)
    ' Page flip
    Call DXRefresh
End Sub

'=========================================================================
' Render the board's scroll cache
'=========================================================================
Private Sub renderScrollCache(ByVal cnv As Long, ByVal tX As Long, ByVal tY As Long)

    On Error Resume Next

    ' First, get the shade color of the board
    Dim r As Long, g As Long, b As Long
    Call getAmbientLevel(r, b, g)

    ' Fill with transparent color
    Call canvasFill(cnv, TRANSP_COLOR)

    ' Change directory
    Call ChangeDir(IIf(pakFileRunning, PakTempPath, projectPath))

    ' Draw the board
    Call GFXDrawBoardCNV( _
        VarPtr(boardList(activeBoardIndex).theData), _
        cnv, _
        0, tX, IIf(boardList(activeBoardIndex).theData.isIsometric = 1, tY * 2, tY), _
        scTilesX, IIf(boardList(activeBoardIndex).theData.isIsometric = 1, scTilesY * 2, scTilesY), _
        boardList(activeBoardIndex).theData.bSizeX, _
        boardList(activeBoardIndex).theData.bSizeY, _
        boardList(activeBoardIndex).theData.bSizeL, _
        r, g, b, _
        boardList(activeBoardIndex).theData.isIsometric _
    )

    ' Return to old directory
    Call ChangeDir(currentDir)

End Sub

'=========================================================================
' Draw a sprite
'=========================================================================
Private Sub putSpriteAt(ByVal cnvFrameID As Long, ByVal boardX As Double, ByVal boardY As Double, ByVal boardL As Long, _
                ByRef pending As PENDING_MOVEMENT, Optional ByVal cnvTarget As Long = -1, Optional ByVal bAccountForUnderTiles As Boolean = True)
    
    '============================================================================
    'Draw the sprite in canvas cnv at boardx, boardy, boardlayer [playerPosition]
    'The bottom of the sprite will touch the centre of boardx, boardy
    'and will be centred horiztonally about this point.
    'If cnvTarget= -1 then render to screen, else render to canvas
    'Can also set the opacity of sprites in this function.
    '============================================================================
    'Called by DXDrawSprites only. New arguments added in these calls.

    On Error Resume Next

    Dim xOrig As Double, yOrig As Double, xTarg As Double, yTarg As Double

    xOrig = pending.xOrig
    yOrig = pending.yOrig
    xTarg = pending.xTarg
    yTarg = pending.yTarg
    
    If xOrig > boardList(activeBoardIndex).theData.bSizeX Or xOrig < 0 Then xOrig = Round(boardX)
    If yOrig > boardList(activeBoardIndex).theData.bSizeY Or yOrig < 0 Then yOrig = Round(boardY)
    If xTarg > boardList(activeBoardIndex).theData.bSizeX Or xTarg < 0 Then xTarg = Round(boardX)
    If yTarg > boardList(activeBoardIndex).theData.bSizeY Or yTarg < 0 Then yTarg = Round(boardY)
    
    Dim targetTile As Byte, originTile As Byte
    
    targetTile = boardList(activeBoardIndex).theData.tiletype(Round(xTarg), -Int(-yTarg), Int(boardL))
    originTile = boardList(activeBoardIndex).theData.tiletype(Round(xOrig), -Int(-yOrig), Int(boardL))
       
    'Do some tiletype checks now instead of later.
    Dim drawTranslucently As Boolean
    
    '    If [tiles on layers above]
    '    OR [Moving *to* "under" tile (target)]
    '    OR [Moving *from* "under" tile (origin)]
    '    OR [Moving between "under" tiles]
    
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        If _
            checkAbove(boardX, boardY, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardX) = xTarg And Round(boardY) = yTarg) _
            Or (originTile = UNDER And Round(boardX) = xOrig And Round(boardY) = yOrig) _
            Or (targetTile = UNDER And originTile = UNDER) Then
                drawTranslucently = True
        End If
    Else
        If _
            checkAbove(boardX, boardY, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardX) = Round(xTarg) And -Int(-boardY) = -Int(-yTarg)) _
            Or (originTile = UNDER And Round(boardX) = Round(xOrig) And -Int(-boardY) = -Int(-yOrig)) _
            Or (targetTile = UNDER And originTile = UNDER) Then
                drawTranslucently = True
        End If
    End If

    Dim centreX As Long, centreY As Long
    
    'Determine the centrepoint of the tile in pixels.
    centreX = getBottomCentreX(boardX, boardY)
    centreY = getBottomCentreY(boardX, boardY)
    
    ' + 8 offsets the sprite 3/4 of way down tile rather than 1/2 for isometrics.
    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then centreY = centreY + 8
       
    Dim spriteWidth As Long, spriteHeight As Long, cornerX As Long, cornerY As Long
    
    'The dimensions of the sprite frame, in pixels.
    spriteWidth = getCanvasWidth(cnvFrameID)
    spriteHeight = getCanvasHeight(cnvFrameID)

    'Will place the top left corner of the sprite frame at cornerX, cornerY:
    cornerX = centreX - spriteWidth \ 2
    cornerY = centreY - spriteHeight
           
    'Exit if sprite is off the board.
    If cornerX > resX Or cornerY > resY Or _
        cornerX + spriteWidth < 0 Or cornerY + spriteHeight < 0 Then Exit Sub
       
    Dim offsetX As Long, offsetY As Long
    'Offset on the sprite's frame from the top left corner (cornerX, cornerY)
    
    Dim renderWidth As Long, renderHeight As Long
    'Portion of frame to be drawn, after offset considerations.
       
    'Calculate locations and areas to draw.
    If cornerX < 0 Then
        offsetX = -cornerX
        If cornerX + spriteWidth > resX Then
            renderWidth = resX                      'Both.
        Else
            renderWidth = spriteWidth - offsetX     'Left.
        End If
        cornerX = 0
    Else
        If cornerX + spriteWidth > resX Then
            renderWidth = resX - cornerX            'Right.
        Else
            renderWidth = spriteWidth               'None.
        End If
    End If
    
    If cornerY < 0 Then
        offsetY = -cornerY
        If cornerY + spriteHeight > resY Then
            renderHeight = resY                      'Both.
        Else
            renderHeight = spriteHeight - offsetY    'Left.
        End If
        cornerY = 0
    Else
        If cornerY + spriteHeight > resY Then
            renderHeight = resY - cornerY            'Right.
        Else
            renderHeight = spriteHeight              'None.
        End If
    End If
    
    'We now have the position and area of the sprite to draw.
    'Check if we need to draw the sprite transluscently:
    
    If drawTranslucently And bAccountForUnderTiles Then
        'If on "under" tiles, make sprite translucent.
        
        If cnvTarget = -1 Then 'Draw to screen
        
            Call DXDrawCanvasTranslucentPartial(cnvFrameID, _
                                                cornerX, _
                                                cornerY, _
                                                offsetX, _
                                                offsetY, _
                                                renderWidth, _
                                                renderHeight, _
                                                0.25, -1, _
                                                TRANSP_COLOR)
        Else 'Draw to canvas.
        
            Call canvas2canvasBltTranslucentPartial(cnvFrameID, _
                                                    cnvTarget, _
                                                    cornerX, _
                                                    cornerY, _
                                                    offsetX, _
                                                    offsetY, _
                                                    renderWidth, _
                                                    renderHeight, _
                                                    0.25, -1, _
                                                    TRANSP_COLOR)
        End If
        
    Else
        'Draw solid. Transparent refers to the transparent colour (alpha) on the frame.
        
        If cnvTarget = -1 Then 'Draw to screen
            
            Call DXDrawCanvasTransparentPartial(cnvFrameID, _
                                                cornerX, _
                                                cornerY, _
                                                offsetX, _
                                                offsetY, _
                                                renderWidth, _
                                                renderHeight, _
                                                TRANSP_COLOR)
        Else 'Draw to canvas

            Call canvas2CanvasBltTransparentPartial(cnvFrameID, _
                                                    cnvTarget, _
                                                    cornerX, _
                                                    cornerY, _
                                                    offsetX, _
                                                    offsetY, _
                                                    renderWidth, _
                                                    renderHeight, _
                                                    TRANSP_COLOR)
        End If
        
    End If 'drawTranslucently And bAccountForUnderTiles
        
End Sub

'=========================================================================
' Render a player (remove string stances!!!!)
'=========================================================================
Private Function renderPlayer(ByVal cnv As Long, _
                              ByRef thePlayer As TKPlayer, _
                              ByRef playerPosition As PLAYER_POSITION, _
                              ByVal idx As Long) As Boolean
    On Error Resume Next

    'Directional standing graphics for 3.0.5
    '===========================================
    With playerPosition

        'Check idleness.
        If pendingPlayerMovement(idx).direction = MV_IDLE And gGameState <> GS_MOVEMENT Then
            'We're idle, and we're not about to start moving.
            
            Dim direction As Long
            Select Case LCase$(.stance)
                Case "walk_n", "stand_n": direction = 1        'See CommonPlayer
                Case "walk_s", "stand_s": direction = 0
                Case "walk_e", "stand_e": direction = 3
                Case "walk_w", "stand_w": direction = 2
                Case "walk_nw", "stand_nw": direction = 4
                Case "walk_ne", "stand_ne": direction = 5
                Case "walk_sw", "stand_sw": direction = 6
                Case "walk_se", "stand_se": direction = 7
                Case Else: direction = -1
            End Select

            Dim bIdleGfx As Boolean
            bIdleGfx = (LeftB$(LCase$(.stance), 10) = "stand")

            If Timer() - .idle.time >= thePlayer.idleTime And (Not (bIdleGfx)) Then
                'Push into idle graphics if not already.

                'Check that a standing graphic for this direction exists.
                If direction <> -1 Then
                    If LenB(thePlayer.standingGfx(direction)) Then
                        'If so, change the stance to STANDing.
                        .stance = "stand" & RightB$(.stance, LenB(.stance) - 8)

                        bIdleGfx = True

                        'Set the loop counter and timer for idleness.
                        .loopFrame = -1
                        .idle.frameTime = Timer()
                        
                        'Load the frame delay for the idle animation.
                        Dim idleAnim As TKAnimation
                        Call openAnimation(projectPath & miscPath & thePlayer.standingGfx(direction), idleAnim)
                        .idle.frameDelay = idleAnim.animPause
                        
                    End If
                End If

            End If
            
            If (bIdleGfx) And LenB(thePlayer.standingGfx(direction)) <> 0 Then
                'We're standing!
                
                If Timer() - .idle.frameTime >= .idle.frameDelay Then
                    'Increment the animation frame when the delay is up.
                    .frame = .frame + 1
                    
                    'Start the timer for this frame.
                    .idle.frameTime = Timer()
                    
                End If
            End If
        End If '.direction <> MV_IDLE

    End With

    '===============================

    With lastPlayerRender(idx)

        If .canvas = cnv And _
           .frame = playerPosition.frame And _
           .stance = playerPosition.stance And _
           .x = playerPosition.x And _
           .y = playerPosition.y Then
           'We've just rendered this frame so we don't need to again.
            Exit Function
        End If

        'Update the last render.
        .canvas = cnv
        .frame = playerPosition.frame
        .stance = playerPosition.stance
        .x = playerPosition.x
        .y = playerPosition.y

        Call renderAnimationFrame(cnv, playerGetStanceAnm(.stance, thePlayer), .frame, 0, 0)

    End With

    renderPlayer = True

End Function

'=========================================================================
' Render an item
'=========================================================================
Private Function renderItem(ByVal cnv As Long, _
                            ByRef theItem As TKItem, _
                            ByRef itemPosition As PLAYER_POSITION, _
                            ByVal idx As Long) As Boolean
    
    On Error Resume Next
    
    With itemPosition
    
#If False Then
        'check if item is in viewable area...
        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
            'Substituting for isoTopY = topY * 2 + 1
            'might need to substitute topx for topx + 1
            If .x < topX - 1 Or _
                .x > topX + isoTilesX + 1 Or _
                .y < (topY * 2 + 1) - 1 Or _
                .y > (topY * 2 + 1) + isoTilesY + 1 Then
                Exit Function
            End If
        Else
            If .x < topX - 1 Or _
                .x > topX + tilesX + 1 Or _
                .y < topY - 1 Or _
                .y > topY + tilesY + 1 Then
                Exit Function
            End If
        End If
#End If
        
        'Directional standing graphics for 3.0.5
        '===========================================
        'Check idleness.
        If pendingItemMovement(idx).direction = MV_IDLE Then
            'We're idle.
            
            Dim direction As Long
            Select Case LCase$(.stance)
                Case "walk_n", "stand_n": direction = 1        'See CommonItem
                Case "walk_s", "stand_s": direction = 0
                Case "walk_e", "stand_e": direction = 3
                Case "walk_w", "stand_w": direction = 2
                Case "walk_nw", "stand_nw": direction = 4
                Case "walk_ne", "stand_ne": direction = 5
                Case "walk_sw", "stand_sw": direction = 6
                Case "walk_se", "stand_se": direction = 7
                Case Else: direction = -1
            End Select
            
            Dim bIdleGfx As Boolean
            bIdleGfx = (LeftB$(LCase$(.stance), 10) = "stand")
            
            If Timer() - .idle.time >= theItem.idleTime And (Not (bIdleGfx)) Then
                'Push into idle graphics if not already.
                
                'Check that a standing graphic for this direction exists.
                If direction <> -1 Then
                    If LenB(theItem.standingGfx(direction)) Then
                        'If so, change the stance to STANDing.
                        .stance = "stand" & RightB$(.stance, LenB(.stance) - 8)

                        bIdleGfx = True

                        'Start the loop counter for idleness.
                        .loopFrame = -1
                        .idle.frameTime = Timer()
                        
                        'Load the frame delay for the idle animation.
                        Dim idleAnim As TKAnimation
                        Call openAnimation(projectPath & miscPath & theItem.standingGfx(direction), idleAnim)
                        .idle.frameDelay = idleAnim.animPause
                        
                    End If
                End If
                
            End If
            
            If (bIdleGfx) And LenB(theItem.standingGfx(direction)) <> 0 Then
                'We're standing and we have idling graphics.
                
                If Timer() - .idle.frameTime >= .idle.frameDelay Then
                    'Increment the animation frame when the delay is up.
                    .frame = .frame + 1
                    
                    'Start the timer for this frame.
                    .idle.frameTime = Timer()
                    
                End If
            End If
        End If '.direction <> MV_IDLE
        '===============================
        
        With lastItemRender(idx)
        
            If .canvas = cnv And _
               .frame = itemPosition.frame And _
               .stance = itemPosition.stance And _
               .x = itemPosition.x And _
               .y = itemPosition.y Then
               'We've just rendered this frame so we don't need to again.
               Exit Function
            End If
               
            'Update the last render.
            .canvas = cnv
            .frame = itemPosition.frame
            .stance = itemPosition.stance
            .x = itemPosition.x
            .y = itemPosition.y
                
        End With
        
        Call renderAnimationFrame(cnv, itemGetStanceAnm(.stance, theItem), .frame, 0, 0)
        
    End With 'itemPosition
    
    renderItem = True

End Function

'=========================================================================
' Create global canvases
'=========================================================================
Private Sub createCanvases(ByVal width As Long, ByVal height As Long)
    On Error Resume Next
    cnvScrollCache = createCanvas(width * 2, height * 2)
    scTilesX = width * 2 \ 32
    scTilesY = height * 2 \ 32
    scTopX = -1
    scTopY = -1
    Dim t As Long
    For t = 0 To UBound(cnvPlayer)
        cnvPlayer(t) = createCanvas(32, 32)
    Next t
    cnvBackground = createCanvas(width, height)
    cnvRpgCodeScreen = createCanvas(width, height)
    cnvAllPurpose = createCanvas(width, height)
    cnvMsgBox = createCanvas(600, 100)
    For t = 0 To UBound(cnvRPGCodeBuffers)
        cnvRPGCodeBuffers(t) = createCanvas(32, 32)
    Next t
    cnvRPGCodeAccess = createCanvas(width, height)
    cnvRenderNow = createCanvas(width, height)
    Call canvasFill(cnvRpgCodeScreen, 0)
    Call canvasFill(cnvRenderNow, TRANSP_COLOR_ALT)
End Sub

'=========================================================================
' Destroy global canvases
'=========================================================================
Private Sub destroyCanvases()
    On Error Resume Next
    Call destroyCanvas(cnvScrollCache)
    Call destroyCanvas(cnvBackground)
    Dim t As Long
    For t = 0 To UBound(cnvPlayer)
        Call destroyCanvas(cnvPlayer(t))
    Next t
    Call destroyCanvas(cnvRpgCodeScreen)
    Call destroyCanvas(cnvMsgBox)
    For t = 0 To UBound(cnvSprites)
        Call destroyCanvas(cnvSprites(t))
    Next t
    Call destroyCanvas(cnvAllPurpose)
    For t = 0 To UBound(cnvRPGCodeBuffers)
        Call destroyCanvas(cnvRPGCodeBuffers(t))
    Next t
    Call destroyCanvas(cnvRPGCodeAccess)
    For t = 0 To UBound(cnvRPGCode)
        Call destroyCanvas(cnvRPGCode(t))
    Next t
    Call destroyCanvas(cnvRenderNow)
End Sub

'========================================================================='
' Kill and unload the graphics system
'=========================================================================
Public Sub destroyGraphics()

    ' Destroy global canvases
    Call destroyCanvases

    ' Shut down the canvas engine
    Call closeCanvasEngine

    ' Kill the gfx system
    Call GFXKill

    ' Kill DirectX
    Call DXKillGfxMode

    ' Kill pictures loaded from resources
    Call killResPictures

End Sub

'=========================================================================
' Determine if the board needs to be rendered
'=========================================================================
Private Function renderBoard() As Boolean

    On Error Resume Next
    
    Dim tilesXTemp As Single, scTilesXTemp As Single

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        scTilesXTemp = scTilesX / 2     '= 20 (640res) = 25 (800res)
            '= IsoScTilesX = scroll cache width in iso-tiles.
        tilesXTemp = tilesX / 2         '= 10          = 12.5
            '=isoTilesX. could use in following code but code is the same.
    Else
         scTilesXTemp = scTilesX        '= 40 (640res) = 50 (800res)
         tilesXTemp = tilesX            '= 20          = 25
    End If

    ' Same code *should* be valid for both board types...
    ' Added a "- 1" to the 4th check, since in 800res scTilesY = 37.5 which gets rounded up when
    ' the scrollcache is made, and should be rounded down (easiest way to correct it here!)

    If Not (topX >= scTopX And _
        topY >= scTopY And _
        (topX + tilesXTemp) <= (scTopX + scTilesXTemp) And _
        (topY + tilesY) <= (scTopY + scTilesY - 1) And _
        (scTopX <> -1 And scTopY <> -1)) Then

        scTopX = Int(topX - (tilesXTemp / 2))
        scTopY = Int(topY - (tilesY / 2))
        If scTopX < 0 And topX >= 0 Then scTopX = 0
        If scTopY < 0 And topY >= 0 Then scTopY = 0

        Call renderScrollCache(cnvScrollCache, scTopX, scTopY)

        ' Call drawPrograms(1, cnvScrollCache, cnvScrollCacheMask)
        Call drawPrograms(1, cnvScrollCache, -1)

        renderBoard = True

    End If

End Function

'=========================================================================
' Render the scene now! Returns whether a redraw occured or not.
'=========================================================================
Public Function renderNow(Optional ByVal cnvTarget As Long = -1, _
                          Optional ByVal forceRender As Boolean) As Boolean

    On Error Resume Next

    Dim newBoard As Boolean         ' update board?
    Dim newSprites As Boolean       ' update sprites?
    Dim newTileAnm As Boolean       ' update tile animations?
    Dim newItem As Boolean          ' update items?
    Dim newBackground As Boolean    ' update background?
    Dim newMultiAnim As Boolean     ' update multitasking animations?
    Dim t As Long                   ' for loop control variable

    ' Check if we need to render the background
    newBackground = renderBackground()

    ' Check if we need to render the board
    newBoard = renderBoard()

    ' Check if we need to render multitasking animations
    newMultiAnim = multiAnimRender()

    ' Check if we need to render the player sprites
    For t = 0 To UBound(cnvPlayer)
        If (showPlayer(t)) Then
            If (renderPlayer(cnvPlayer(t), playerMem(t), pPos(t), t)) Then
                ' If we get here, something has changed since the last
                ' render and we have to re-render the player sprites.
                newSprites = True
            End If
        End If
    Next t

    ' Check if we need to render the item sprites
    For t = 0 To (UBound(boardList(activeBoardIndex).theData.itmActivate))
        If (itemMem(t).bIsActive) Then
            If (renderItem(cnvSprites(t), itemMem(t), itmPos(t), t)) Then
                ' If we get here, something has changed since the last
                ' render and we have to re-render the item sprites.
                newItem = True
            End If
        End If
    Next t

    ' Check if we need to render animated tiles
    ' newTileAnm = renderAnimatedTiles(cnvScrollCache, cnvScrollCacheMask)
    newTileAnm = renderAnimatedTiles(cnvScrollCache, -1)

    ' If *anything* is new, render it all
    If (newBoard Or newSprites Or newTileAnm Or newItem Or newMultiAnim Or renderRenderNowCanvas Or forceRender) Then

        ' Fill the target with the board's color
        If (cnvTarget = -1) Then
            ' To the screen
            Call DXClearScreen(boardList(activeBoardIndex).theData.brdColor)
        Else
            ' To a canvas
            Call canvasFill(cnvTarget, boardList(activeBoardIndex).theData.brdColor)
        End If

        ' Render background
        Call DXDrawBackground(cnvTarget)

        ' Render board
        Call DXDrawBoard(cnvTarget)

        ' Render sprites
        Call DXDrawSprites(cnvTarget)

        ' Render multitasking animations
        Call renderMultiAnimations(cnvTarget)

        ' Render the rpgcode renderNow canvas
        If (renderRenderNowCanvas) Then
            If (cnvTarget = -1) Then
                ' To the screen
                Call DXDrawCanvasTransparent(cnvRenderNow, 0, 0, TRANSP_COLOR_ALT)
            Else
                ' To a canvas
                Call canvas2CanvasBltTransparent(cnvRenderNow, cnvTarget, 0, 0, TRANSP_COLOR_ALT)
            End If
        End If

        If (cnvTarget = -1) Then

            ' Flip the back buffer onto the screen
            Call DXRefresh

        End If

        renderNow = True

    End If

End Function

'=========================================================================
' Same as renderNow, but used while running RPGCode
'=========================================================================
Public Sub renderRPGCodeScreen()

    ' Lay down the RPGCode screen
    Call DXDrawCanvas(cnvRpgCodeScreen, 0, 0)

    ' Draw the message box if it's being shown
    If (bShowMsgBox) Then

        If (g_dblWinIntensity <> 1) Then

            ' Draw the messsage window, using translucency
            Call DXDrawCanvasTranslucent(cnvMsgBox, (tilesX * 32 - 600) * 0.5, 0, g_dblWinIntensity, fontColor)

        Else

            ' Draw the messsage window opaquely
            Call DXDrawCanvas(cnvMsgBox, (tilesX * 32 - 600) * 0.5, 0)

        End If

    End If

    ' Make the flip
    Call DXRefresh

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
    ReDim indicies(UBound(cnvPlayer) + (UBound(boardList(activeBoardIndex).theData.itmActivate))) As Long
    ReDim locationValues(UBound(cnvPlayer) + (UBound(boardList(activeBoardIndex).theData.itmActivate))) As Long
    Dim t As Long, ns As Boolean, ni As Boolean
    Dim theValue As Long
    Dim curIdx As Long

    'set up location values for players
    For t = 0 To UBound(cnvPlayer)
        If showPlayer(t) Then
            'determine a location value...
            theValue = (pPos(t).y * boardList(activeBoardIndex).theData.bSizeY) + pPos(t).x
            'playes will have a negative index so we can differentiate them
            indicies(curIdx) = -(t + 1)
            locationValues(curIdx) = theValue
            curIdx = curIdx + 1
        End If
    Next t

    'set up location values for items...
    For t = 0 To (UBound(boardList(activeBoardIndex).theData.itmActivate))
        If itemMem(t).bIsActive Then
            'determine a location value...
            theValue = (itmPos(t).y * boardList(activeBoardIndex).theData.bSizeY) + itmPos(t).x
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
                    pPos(curNum).x, _
                    pPos(curNum).y, _
                    pPos(curNum).l, _
                    pendingPlayerMovement(curNum), _
                    cnvTarget)
        Else
            'this is an item
            curNum = indicies(t)
            Call putSpriteAt(cnvSprites(curNum), _
                    itmPos(curNum).x, _
                    itmPos(curNum).y, _
                    itmPos(curNum).l, _
                    pendingItemMovement(curNum), _
                    cnvTarget)

        End If
    Next t

End Sub

'=========================================================================
' Show the message box
'=========================================================================
Public Sub showMsgBox()
    bShowMsgBox = True
End Sub

'=========================================================================
' Hide the message box
'=========================================================================
Public Sub hideMsgBox()
    bShowMsgBox = False
End Sub

'=========================================================================
' Initiate the DirectX window
'=========================================================================
Private Sub showScreen(ByVal width As Long, ByVal height As Long, Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    ' Set up resolution
    resX = width
    resY = height
    tilesX = width / 32
    tilesY = height / 32
    isoTilesX = tilesX / 2 ' = 10.0 (640res) = 12.5 (800res)
    isoTilesY = tilesY * 2 ' = 30 (640res) = 36 (800res)

    ' Set up the host window
    inFullScreenMode = ((mainMem.extendToFullScreen <> 0) And (Not (testingPRG)))
    bShowEndForm = Not (testingPRG)
    host.style = IIf(inFullScreenMode, WS_FULL_SCREEN, WS_WINDOWED)
    host.width = width
    host.height = height
    host.Top = ((Screen.height - height * Screen.TwipsPerPixelX) \ 2) \ Screen.TwipsPerPixelX
    host.Left = ((Screen.width - width * Screen.TwipsPerPixelY) \ 2) \ Screen.TwipsPerPixelY
    Call host.Create("DirectXHost")

    ' Colour depth
    Dim depth As Long
    Select Case mainMem.colordepth
        Case COLOR16: depth = 16
        Case COLOR24: depth = 24
        Case COLOR32: depth = 32
    End Select

    ' Initialize DirectDraw
    Do While (DXInitGfxMode(host.hwnd, width, height, 1, depth, IIf(inFullScreenMode, 1, 0)) = 0)
        If ((depth = 16) And (Not (inFullScreenMode))) Then
            Set host = Nothing
            Call MsgBox("Error initializing graphics mode. Make sure you have DirectX 8 or higher installed.")
            Call showEndForm(True)
        ElseIf (depth = 32) Then
            depth = 24
        ElseIf (depth = 24) Then
            depth = 16
        ElseIf (depth = 16) Then
            inFullScreenMode = False
        End If
    Loop

    ' Finalize
    Call createCanvases(width, height)
    Call DXClearScreen(0)
    Call DXRefresh
    Call host.Show

End Sub

'=========================================================================
' Initiate the graphics engine
'=========================================================================
Public Sub initGraphics(Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    ' Init the canvas engine
    Call initCanvasEngine

    ' Load resource images
    Call loadResPictures

    ' Test for joystick
    useJoystick = JoyTest()

    ' Get screen width
    screenWidth = Screen.height * (1 \ 0.75) ' (Colin: Is this a mistake!?)
    screenHeight = Screen.height

    ' Get resolution x / y
    resX = screenWidth \ Screen.TwipsPerPixelX
    resY = screenHeight \ Screen.TwipsPerPixelY

    ' Start the message window with a "normal" translucency value
    g_dblWinIntensity = 0.5

    ' Get res from main file
    If (mainMem.mainResolution = 0) Then
        screenWidth = 640
        screenHeight = 480
    ElseIf (mainMem.mainResolution = 1) Then
        screenWidth = 800
        screenHeight = 600
    ElseIf (mainMem.mainResolution = 2) Then
        screenWidth = 1024
        screenHeight = 768
    Else
        ' Custom resolution
        screenHeight = mainMem.resY
        screenWidth = mainMem.resX
    End If

    ' Show the screen
    Call showScreen(screenWidth, screenHeight, testingPRG)

    ' Update screen width and height
    screenWidth = screenWidth * Screen.TwipsPerPixelX
    screenHeight = screenHeight * Screen.TwipsPerPixelY

End Sub

'=========================================================================
' In full-screen mode?
'=========================================================================
Public Property Get usingFullScreen() As Boolean
    ' Return whether we're in full screen mode
    usingFullScreen = inFullScreenMode
End Property
