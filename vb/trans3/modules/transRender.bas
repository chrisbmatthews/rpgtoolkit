Attribute VB_Name = "transRender"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'All rendering functions
Option Explicit

'screen dimensions  calculate upon the first resizing of the screen (these are in twips!)...
Public screenWidth As Integer   'width, in twips
Public screenHeight As Integer  'height, in twips
Public resX As Long
Public resY As Long             'x and y resolutions

'added by KSNiloc
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

'Added by KSNiloc...
Public cnvRPGCode() As Long

Public gTranspColor As Long 'transparent color used for bltting
Public gTranspColorAlt As Long  'color to use if you need to draw int he transparent color

Private inDXMode As Boolean
Private inFullScreenMode As Boolean

Private Type BoardRender
    file As String
    canvas As Long
    canvasMask As Long
    topX As Double
    topY As Double
    tilesX As Long
    tilesY As Long
    shadeR As Long
    shadeG As Long
    shadeB As Long
    isometric As Long
End Type
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

Public addonR As Long           'red to add
Public addonG As Long           'green to add
Public addonB As Long           'blue to add

' MODIFIED BY KSNiloc...
'Public Const MAXITEM = 10 'MAXIMUM NUMBER OF ITEMS IS SET HERE.
Public Property Get MAXITEM()
    MAXITEM = UBound(boardList(activeBoardIndex).theData.itmActivate)
End Property

Sub checkScrollBounds()
    'EDITED: [Isometrics - Delano - 29/03/04]
    'Added isometric version.
    
    'Make sure the scrolling is wihtin the bounds of the board.
    'Called by the scrollUp etc. Subs.
    
    On Error Resume Next
    
    'Addition:
    If boardIso() Then

        If topX + isoTilesX + 0.5 >= boardList(activeBoardIndex).theData.Bsizex Then
            topX = boardList(activeBoardIndex).theData.Bsizex - isoTilesX - 0.5
        End If

        If (topY * 2 + 1) + isoTilesY >= boardList(activeBoardIndex).theData.Bsizey Then
            topY = (boardList(activeBoardIndex).theData.Bsizey - isoTilesY - 1) / 2
        End If
    
        If topX < 0 Then topX = 0
    
        If topY < 0 Then topY = 0
    Else
        'Original code
        If topX + tilesX > boardList(activeBoardIndex).theData.Bsizex Then
            topX = boardList(activeBoardIndex).theData.Bsizex - tilesX
        End If

        If topY + tilesY > boardList(activeBoardIndex).theData.Bsizey Then
            topY = boardList(activeBoardIndex).theData.Bsizey - tilesY
        End If
    
        If topX < 0 Then topX = 0
    
        If topY < 0 Then topY = 0
    End If
End Sub


Sub determineTransparentColor()
    On Error Resume Next
    'determine the transparent color used for bltting
    gTranspColor = RGB(255, 255, 255)
    Exit Sub
    
    Dim r As Long, g As Long, b As Long
    Dim col As Long
    
    Dim done As Boolean
    Dim cnv As Long, cnv2 As Long
    
    done = False
    
    cnv = CreateCanvas(3, 3)
    cnv2 = CreateCanvas(3, 3)
    Call CanvasFill(cnv, 0)
    Call CanvasFill(cnv2, 0)
    
    Do While (Not (done))
        r = Int(Rnd(1) * 255)
        g = Int(Rnd(1) * 255)
        b = Int(Rnd(1) * 255)
        
        'try this combination...
        Call CanvasSetPixel(cnv, 0, 0, RGB(r, g, b))
        
        Call Canvas2CanvasBltTransparent(cnv, cnv2, 0, 0, RGB(r, g, b))
        
        'now see if it worked...
        col = CanvasGetPixel(cnv2, 0, 0)
        If (col = 0) Then
            'found a good transparent color!
            gTranspColor = RGB(r, g, b)
            
            Call CanvasFill(cnv, 0)
            Call CanvasFill(cnv2, 0)
            
            'now find an alternative color...
            Dim done2 As Boolean
            done2 = False
            
            Dim r2 As Long, g2 As Long, b2 As Long
            r2 = r
            g2 = g
            b2 = b
            Do While (Not (done2))
                Dim whichOne As Integer
                whichOne = Int(Rnd(1) * 3)
                Dim whichDir As Integer
                whichDir = Int(Rnd(1) * 2)
                Dim toadd As Integer
                
                If whichDir = 0 Then
                    toadd = 1
                Else
                    toadd = -1
                End If
                
                If whichOne = 0 Then
                    r2 = r2 + toadd
                    If r2 > 255 Then r2 = 255
                ElseIf whichOne = 1 Then
                    g2 = g2 + toadd
                    If g2 > 255 Then g2 = 255
                ElseIf whichOne = 2 Then
                    b2 = b2 + toadd
                    If b2 > 255 Then b2 = 255
                End If
            
                'try this combination...
                Call CanvasSetPixel(cnv, 0, 0, RGB(r, g, b))
                
                Call Canvas2CanvasBltTransparent(cnv, cnv2, 0, 0, RGB(r, g, b))
                
                'now see if it worked...
                col = CanvasGetPixel(cnv2, 0, 0)
                If (col = 0) Then
                    'found a good transparent color!
                    gTranspColorAlt = RGB(r2, g2, b2)
                    'all done
                    done2 = True
                    done = True
                End If
            Loop
        End If
    Loop
    
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(cnv2)
End Sub


Function quickSortRnd(ByVal Left As Long, ByVal Right As Long) As Long
    'randomly return one of two values for quicsort
    On Error Resume Next
    
    If (Rnd(1) * 2) = 1 Then
        quickSortRnd = Left
    Else
        quickSortRnd = Right
    End If
End Function

Sub quickSortSprites(ByRef toSort() As Long, ByRef indicies() As Long, ByVal Left As Long, ByVal Right As Long)
    'quick sort the sprites
    'toSort - actual values worth sorting
    'indicies - the indicies of the corresponding sprites, which will be sorted along with the values
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

Sub quickSortSwap(ByRef toSort() As Long, ByVal Left, ByVal Right)
    'swap two values in an array
    On Error Resume Next
    Dim Temp As Long
    Temp = toSort(Left)
    toSort(Left) = toSort(Right)
    toSort(Right) = Temp
End Sub


Sub redrawAllLayersAt(ByVal xBoardCoord As Integer, ByVal yBoardCoord As Integer)
    'redraw all the tiled layers at x, y
    'x,y are board coordianteds, not view coords
    
    On Error Resume Next
    Dim x As Long, y As Long
    x = xBoardCoord
    y = yBoardCoord
    
    Select Case boardList(activeBoardIndex).theData.ambienteffect
        Case 0
            addonR = 0
            addonG = 0
            addonB = 0
        Case 1
            addonR = 75
            addonG = 75
            addonB = 75
        Case 2
            addonR = -75
            addonG = -75
            addonB = -75
        Case 3
            addonR = 0
            addonG = 0
            addonB = 75
    End Select
    'internal engine drawing routines
    'first, get the shade color of the board...
    Dim shadeR As Double, shadeG As Double, shadeB As Double
    Dim a As Long, l As String, lightShade As Double
    a = getIndependentVariable("AmbientRed!", l$, shadeR)
    a = getIndependentVariable("AmbientGreen!", l$, shadeG)
    a = getIndependentVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonR = addonR + shadeR
    addonG = addonG + shadeG
    addonB = addonB + shadeB
    
    'now redraw the layers...
    Dim xx As Long, yy As Long
    xx = x - scTopX
    yy = y - scTopY
    Dim lll As Long
    Dim hdc As Long
    Dim hdcMask As Long
    For lll = 1 To boardList(activeBoardIndex).theData.Bsizel
        If BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData) <> "" Then
            Call drawTileCNV(cnvScrollCache, _
                          projectPath$ + tilePath$ + BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData), _
                          xx, _
                          yy, _
                          boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                          boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                          boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, False)
            If cnvScrollCacheMask <> -1 Then
                Call drawTileCNV(cnvScrollCacheMask, _
                              projectPath$ + tilePath$ + BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData), _
                              xx, _
                              yy, _
                              boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                              boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                              boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, True, False)
            End If
        End If
    Next lll
End Sub



Sub drawPrograms(ByVal layer As Long, ByVal cnv As Long, ByVal cnvMask As Long)
    'draws all programs on specified layer.
    On Error Resume Next
    Select Case boardList(activeBoardIndex).theData.ambienteffect
        Case 0
            addonR = 0
            addonG = 0
            addonB = 0
        Case 1
            addonR = 75
            addonG = 75
            addonB = 75
        Case 2
            addonR = -75
            addonG = -75
            addonB = -75
        Case 3
            addonR = 0
            addonG = 0
            addonB = 75
    End Select
    'internal engine drawing routines
    'first, get the shade color of the board...
    Dim a As Long, l As String, shadeR As Double, shadeG As Double, shadeB As Double
    a = getIndependentVariable("AmbientRed!", l$, shadeR)
    a = getIndependentVariable("AmbientGreen!", l$, shadeG)
    a = getIndependentVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    Dim lightShade As Long
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonR = addonR + shadeR
    addonG = addonG + shadeG
    addonB = addonB + shadeB
    
    'first things first- what prgs are on this layer?
    Dim prgnum As Long
    For prgnum = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(prgnum) <> "" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "" Then
            'check if it's activated
            Dim runIt As Long, checkIt As Long
            Dim valueTest As Double, num As Double
            Dim lit As String, valueTes As String
            runIt = 1
            If boardList(activeBoardIndex).theData.progActivate(prgnum) = 1 Then
                runIt = 0
                checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(prgnum), lit$, num)
                If checkIt = 0 Then
                    'it's a numerical variable
                    valueTest = num
                    If valueTest = val(boardList(activeBoardIndex).theData.activateInitNum$(prgnum)) Then runIt = 1
                End If
                If checkIt = 1 Then
                    'it's a literal variable
                    valueTes$ = lit$
                    If valueTes$ = boardList(activeBoardIndex).theData.activateInitNum$(prgnum) Then runIt = 1
                End If
            End If
            If runIt = 1 And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" Then
                Dim layAt As Long, x As Long, y As Long
                layAt = boardList(activeBoardIndex).theData.progLayer(prgnum)
                If layAt = layer Then
                    'yes!  it's on this layer!
                    x = boardList(activeBoardIndex).theData.progX(prgnum)
                    y = boardList(activeBoardIndex).theData.progY(prgnum)
                    
                    'If FileExists(projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgNum)) Then
                        If cnv <> -1 Then
                            Call drawTileCNV(cnv, _
                                          projectPath$ + tilePath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), _
                                          x - scTopX, _
                                          y - scTopY, _
                                          boardList(activeBoardIndex).theData.ambientred(x, y, layer) + addonR, _
                                          boardList(activeBoardIndex).theData.ambientgreen(x, y, layer) + addonG, _
                                          boardList(activeBoardIndex).theData.ambientblue(x, y, layer) + addonB, False)
                        End If
                        
                        If cnvMask <> -1 Then
                            Call drawTileCNV(cnvMask, _
                                          projectPath$ + tilePath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), _
                                          x - scTopX, _
                                          y - scTopY, _
                                          boardList(activeBoardIndex).theData.ambientred(x, y, layer) + addonR, _
                                          boardList(activeBoardIndex).theData.ambientgreen(x, y, layer) + addonG, _
                                          boardList(activeBoardIndex).theData.ambientblue(x, y, layer) + addonB, True, False)
                        End If
                    'End If
                End If
            End If
        End If
    Next prgnum
End Sub



Sub DXDrawBackground(Optional ByVal cnv As Long = -1)
    'EDITED: [Isometrics - Delano - 23/04/04]
    'Renamed variables: tW,tH >> pixelTilesX,pixelTilesY
    '                   cW,cH >> imageWidth,imageHeight
    '                   tpX,tpY >> pixelTopX,pixelTopY
    'Background images subject to parallax.
    
    'Draw the background image to the screen, if one exists...
    'If cnv = -1 then draw to scren, else draw to canvas...
    
    'Called by RenderNow only.
    
    On Error Resume Next
    
    If boardList(activeBoardIndex).theData.brdBack <> "" Then
        'If there is a background.
        
        Dim pixelTopX As Long, pixelTopY As Long
        Dim pixelTilesX As Long, pixelTilesY As Long
        
        pixelTopX = 0 'topX,topY for the image (in pixels)
        pixelTopY = 0
        pixelTilesX = tilesX * 32 'Screen tiles width and height in pixels
        pixelTilesY = tilesY * 32
        
        'Board width in pixels. Not used in project!
        'Dim bsX As Long
        'Dim bsY As Long
        '
        'bsX = boardList(activeBoardIndex).theData.Bsizex * 32
        'bsY = boardList(activeBoardIndex).theData.Bsizey * 32
        
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
            
            percentScrollX = topX / (boardList(activeBoardIndex).theData.Bsizex - tilesXTemp)
            maxScrollX = imageWidth - pixelTilesX
            pixelTopX = Int(maxScrollX * percentScrollX)
        End If
        
        'Slightly different for Y
        
        If imageHeight > pixelTilesY Then
            If boardIso() Then
                'If image taller than screen. Isometric version:
                
                percentScrollY = topY * 2 / (boardList(activeBoardIndex).theData.Bsizey - 1 - isoTilesY)
                maxScrollY = imageHeight - pixelTilesY
                pixelTopY = Int(maxScrollY * percentScrollY)
                
            Else
                'If image taller than screen. Normal version.
                
                percentScrollY = topY / (boardList(activeBoardIndex).theData.Bsizey - tilesY)
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


Sub DXDrawBoard(Optional ByVal cnvTarget As Long = -1)
    'EDITED: [Isometrics - Delano - 30/03/04]
    'Horizontal scrolling only moved the board half the required distance for iso.
    
    'If cnvTaret= -1 then render the board to screen, else render to canvas.
    
    'Called by RenderNow only.
    
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
            Call DXDrawCanvasTransparentPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, gTranspColor)
        Else
            Call DXDrawCanvasPartial(cnvScrollCacheMask, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
            Call DXDrawCanvasPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        End If
    
    Else 'Render to canvas
        
        If usingDX() Then
            Call Canvas2CanvasBltTransparentPartial(cnvScrollCache, _
                                                    cnvTarget, _
                                                    0, 0, x1, y1, tilesX * 32, tilesY * 32, gTranspColor)
        Else
            Call Canvas2CanvasBltPartial(cnvScrollCacheMask, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
            Call Canvas2CanvasBltPartial(cnvScrollCache, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        End If
    End If

End Sub

Sub PopupCanvas(ByVal cnv As Long, ByVal x As Long, ByVal y As Long, ByVal stepSize As Long, ByVal popupType As Long)
    'pop up at canvas at x, y
    'popup type is one of the POPUP_ consts
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
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
                
            Case POPUP_VERTICAL:
                stepSize = -stepSize
                For c = h / 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, x, y + c, 0, 0, W, h / 2 - c)
                    Call DXDrawCanvasPartial(cnv, x, y + h / 2, 0, h - cnt, W, h / 2 - c)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(walkDelay)
                Next c
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
        
            Case POPUP_HORIZONTAL:
                stepSize = -stepSize
                For c = W / 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, x + c, y, 0, 0, W / 2 - c, h)
                    Call DXDrawCanvasPartial(cnv, x + W / 2, y, W - cnt, 0, W / 2 - c, h)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(walkDelay)
                Next c
                Call DXDrawCanvas(cnv, x, y)
                Call DXRefresh
        End Select
    End If
End Sub

Function renderAnimatedTiles(ByVal cnv As Long, ByVal cnvMask As Long) As Boolean
    'call this function every 5ms
    'will draw new tile frames to cnv and cnvMask
    On Error Resume Next
    
    Dim toRet As Boolean
    toRet = False
    
    Dim hdc As Long
    Dim hdcMask As Long
    
    Dim t As Long
    Dim l As String
    Dim a As Long
    Dim lightShade As Long
    Dim x As Double
    Dim y As Double
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
                Select Case boardList(activeBoardIndex).theData.ambienteffect
                    Case 0
                        addonR = 0
                        addonG = 0
                        addonB = 0
                    Case 1
                        addonR = 75
                        addonG = 75
                        addonB = 75
                    Case 2
                        addonR = -75
                        addonG = -75
                        addonB = -75
                    Case 3
                        addonR = 0
                        addonG = 0
                        addonB = 75
                End Select
                'internal engine drawing routines
                'first, get the shade color of the board...
                Dim shadeR As Double, shadeG As Double, shadeB As Double
                a = getIndependentVariable("AmbientRed!", l$, shadeR)
                a = getIndependentVariable("AmbientGreen!", l$, shadeG)
                a = getIndependentVariable("AmbientBlue!", l$, shadeB)
                'now check day and night info...
                If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
                    lightShade = DetermineLightLevel()
                    shadeR = shadeR + lightShade
                    shadeG = shadeG + lightShade
                    shadeB = shadeB + lightShade
                End If
                
                addonR = addonR + shadeR
                addonG = addonG + shadeG
                addonB = addonB + shadeB
                
                'now redraw the layers...
                x = boardList(activeBoardIndex).theData.animatedTile(t).x
                y = boardList(activeBoardIndex).theData.animatedTile(t).y
                xx = boardList(activeBoardIndex).theData.animatedTile(t).x - scTopX
                yy = boardList(activeBoardIndex).theData.animatedTile(t).y - scTopY
                
                For lll = 1 To boardList(activeBoardIndex).theData.Bsizel
                    If BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData) <> "" Then
                        ext$ = GetExt(BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData))
                        If UCase$(ext$) <> "TAN" Then
                            'not the animated part
                            If cnv <> -1 Then
                                Call drawTileCNV(cnv, _
                                              projectPath$ + tilePath$ + BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData), _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                                              boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                                              boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, False)
                            End If
                            
                            If cnvMask <> -1 Then
                                Call drawTileCNV(cnvMask, _
                                              projectPath$ + tilePath$ + BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData), _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                                              boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                                              boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, True, False)
                            End If
                        Else
                            If cnv <> -1 Then
                                If cnvMask <> -1 Then
                                    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                                cnv, _
                                                                xx, _
                                                                yy, _
                                                                boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                                                                boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                                                                boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, False)
                                Else
                                    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                                cnv, _
                                                                xx, _
                                                                yy, _
                                                                boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                                                                boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                                                                boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, True, True, False)
                                End If
                            End If
                            If cnvMask <> -1 Then
                                Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                            cnvMask, _
                                                            xx, _
                                                            yy, _
                                                            boardList(activeBoardIndex).theData.ambientred(x, y, lll) + addonR, _
                                                            boardList(activeBoardIndex).theData.ambientgreen(x, y, lll) + addonG, _
                                                            boardList(activeBoardIndex).theData.ambientblue(x, y, lll) + addonB, True, True, True)
                            End If
                        End If
                    End If
                Next lll
            End If 'end of should i draw this frame check
        Next t
    End If

    renderAnimatedTiles = toRet
End Function


Function renderBackground() As Boolean
    'render the board background image
    'return true if it was re-rendered...
    On Error Resume Next
    
    If lastRenderedBackground <> boardList(activeBoardIndex).theData.brdBack Then
        Call CanvasFill(cnvBackground, 0)
        If boardList(activeBoardIndex).theData.brdBack <> "" Then
            Call CanvasLoadFullPicture(cnvBackground, projectPath$ + bmpPath$ + boardList(activeBoardIndex).theData.brdBack, resX, resY)
        End If
        renderBackground = True
        lastRenderedBackground = boardList(activeBoardIndex).theData.brdBack
    Else
        renderBackground = False
    End If
End Function

Sub renderCanvas(ByVal cnv As Long)
    'render any canvas to the screen (fullscreen)
    On Error Resume Next
    
    Dim cv As Long
    Call DXClearScreen(0)
        
    Call DXDrawCanvas(cnv, 0, 0)
    
    Call DXRefresh
    
End Sub

Sub renderScrollCache(ByVal cnv As Long, ByVal cnvMask As Long, ByVal tX As Long, ByVal tY As Long)
    '=======================================
    'EDITED: [Isometrics - Delano - 3/05/04]
    'The vertical scroll cache only contained a screen's worth for iso boards, should be doubled.
    'Fixed vertical redraw bug for tall boards.
    '=======================================
    
    
    'Render the scrollcache to canvas cnv, and the mask onto canvas cnvMask
    'Set cnvMask to -1 if you don't want the mask drawn
    'tx and ty are the topx and y value to use
    
    'Called by renderBoard only, when a new scrollcache of that board is needed.
    
    On Error Resume Next
    
    Dim addonR As Long
    Dim addonG As Long
    Dim addonB As Long
    Dim shadeR As Double, shadeG As Double, shadeB As Double
    Dim a As Long
    Dim l As String
    
    Dim hdc As Long
    Dim hdcMask As Long
    
    'Ambient effects:
    Select Case boardList(activeBoardIndex).theData.ambienteffect
         Case 0
             addonR = 0
             addonG = 0
             addonB = 0
         Case 1
             addonR = 75
             addonG = 75
             addonB = 75
         Case 2
             addonR = -75
             addonG = -75
             addonB = -75
         Case 3
             addonR = 0
             addonG = 0
             addonB = 75
    End Select

    'first, get the shade color of the board...
    a = getIndependentVariable("AmbientRed!", l$, shadeR)
    a = getIndependentVariable("AmbientGreen!", l$, shadeG)
    a = getIndependentVariable("AmbientBlue!", l$, shadeB)
    
    shadeR = shadeR + addonR
    shadeG = shadeG + addonG
    shadeB = shadeB + addonB
       
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Dim lightShade As Long
        
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    Dim fn As String
    
    fn$ = currentBoard$
    fn$ = RemovePath(fn$)
    fn$ = brdPath$ + fn$
    
    'set up render...
    Dim currentRender As BoardRender
    currentRender.file = fn
    currentRender.canvas = cnv
    currentRender.canvasMask = cnvMask
    currentRender.isometric = Int(boardList(activeBoardIndex).theData.isIsometric)
    currentRender.shadeR = shadeR
    currentRender.shadeG = shadeG
    currentRender.shadeB = shadeB
    currentRender.tilesX = scTilesX
    currentRender.tilesY = scTilesY
    currentRender.topX = tX 'scTopX
    currentRender.topY = tY 'scTopY
            
    'put transparent color on the board canvas...
    If cnvMask <> -1 Then
        Call CanvasFill(cnv, RGB(0, 0, 0))
    Else
        Call CanvasFill(cnv, gTranspColor)
    End If
    If cnvMask <> -1 Then
        Call CanvasFill(cnvMask, RGB(255, 255, 255))
    End If
    
    'Isometric fix for undrawn rows.
    'Doubling the vertical cache *should* work! Number of tiles held in cache doubled.
    If boardIso() Then
        currentRender.tilesY = scTilesY * 2
        currentRender.topY = tY * 2
    End If
    
    If pakFileRunning Then
        Call ChangeDir(PakTempPath$)
        If cnvMask = -1 Then
            Call GFXDrawBoardCNV(cnv, -1, 0, _
                                currentRender.topX, _
                                currentRender.topY, _
                                currentRender.tilesX, _
                                currentRender.tilesY, _
                                boardList(activeBoardIndex).theData.Bsizex, _
                                boardList(activeBoardIndex).theData.Bsizey, _
                                boardList(activeBoardIndex).theData.Bsizel, _
                                currentRender.shadeR, _
                                currentRender.shadeG, _
                                currentRender.shadeB, _
                                currentRender.isometric)
        Else
            Call GFXDrawBoardCNV(cnv, cnvMask, 0, _
                                currentRender.topX, _
                                currentRender.topY, _
                                currentRender.tilesX, _
                                currentRender.tilesY, _
                                boardList(activeBoardIndex).theData.Bsizex, _
                                boardList(activeBoardIndex).theData.Bsizey, _
                                boardList(activeBoardIndex).theData.Bsizel, _
                                currentRender.shadeR, _
                                currentRender.shadeG, _
                                currentRender.shadeB, _
                                currentRender.isometric)
        End If
        Call ChangeDir(currentDir$)
    Else
        ChDir (projectPath$)
        If cnvMask = -1 Then
            Call GFXDrawBoardCNV(cnv, -1, 0, _
                                currentRender.topX, _
                                currentRender.topY, _
                                currentRender.tilesX, _
                                currentRender.tilesY, _
                                boardList(activeBoardIndex).theData.Bsizex, _
                                boardList(activeBoardIndex).theData.Bsizey, _
                                boardList(activeBoardIndex).theData.Bsizel, _
                                currentRender.shadeR, _
                                currentRender.shadeG, _
                                currentRender.shadeB, _
                                currentRender.isometric)
        Else
            Call GFXDrawBoardCNV(cnv, cnvMask, 0, _
                                currentRender.topX, _
                                currentRender.topY, _
                                currentRender.tilesX, _
                                currentRender.tilesY, _
                                boardList(activeBoardIndex).theData.Bsizex, _
                                boardList(activeBoardIndex).theData.Bsizey, _
                                boardList(activeBoardIndex).theData.Bsizel, _
                                currentRender.shadeR, _
                                currentRender.shadeG, _
                                currentRender.shadeB, _
                                currentRender.isometric)
        End If
        ChDir (currentDir$)
    End If
End Sub


Function PlayerRenderEqual(ByRef rend1 As PlayerRender, ByRef rend2 As PlayerRender) As Boolean
    On Error Resume Next
    'determine if rend1 == rend2
    Dim toRet As Boolean
    
    toRet = False
    
    If rend1.canvas = rend2.canvas And _
        rend1.stance = rend2.stance And _
        rend1.frame = rend2.frame Then
        toRet = True
    End If
    
    PlayerRenderEqual = toRet
End Function


Sub putSpriteAt(ByVal cnvFrameID As Long, ByVal boardx As Double, ByVal boardy As Double, ByVal boardL As Long, _
                ByRef pending As PENDING_MOVEMENT, Optional ByVal cnvTarget As Long = -1, Optional ByVal bAccountForUnderTiles As Boolean = True)
    
    '==========================================
    'REWRITTEN: [Isometrics - Delano - 3/05/04]
    'FIXED: Edge of screen problems.
    'ADDED: a new argument: "pending". Using pending movements to fix iso transluscent problems.
    '"pending" is also passed to getBottomCentreX - this is an isometric fix.
    'Substituted tile type constants.
    'Renamed variables: cnv >> cnvFrameID
    '                   x,y >> centreX,centreY
    '                   sx,sy >> cornerX, cornerY
    '                   srcX,srcY >> offsetX, offsetY
    '                   W, h >> renderWidth, renderHeight
    'New variables:     spriteWidth = getCanvasWidth(), spriteHeight = getCanvasHeight()
    '                   targetTile, originTile (target and origin tile types)
    
    'MISSING: Partial transluscency functions do not seem to have been written yet... needed for
    'transluscent sprites at edge of board, etc.
    '===========================================
    
    'Draw the sprite in canvas cnv at boardx, boardy, boardlayer [playerPosition]
    'The bottom of the sprite will touch the centre of boardx, boardy
    'It will be centred horiztonally about this point.
    'If cnvTarget=-1 then render to screen, else render to canvas
    'Can also set the opacity of sprites in this function.
    
    'Called by DXDrawSprites only. New arguments added in these calls.
    
    ' ! MODIFIED BY KSNiloc...
    
    On Error Resume Next
  
    'Using local varibles as the values may change. Or could pass the co-ords as ByVal arguments instead.
    Dim xOrig As Double, yOrig As Double, xTarg As Double, yTarg As Double
    
    xOrig = pending.xOrig
    yOrig = pending.yOrig
    xTarg = pending.xTarg
    yTarg = pending.yTarg
    
    If xOrig > boardList(activeBoardIndex).theData.Bsizex Or xOrig < 0 Then xOrig = Round(boardx)
    If yOrig > boardList(activeBoardIndex).theData.Bsizey Or yOrig < 0 Then yOrig = Round(boardy)
    If xTarg > boardList(activeBoardIndex).theData.Bsizex Or xTarg < 0 Then xTarg = Round(boardx)
    If yTarg > boardList(activeBoardIndex).theData.Bsizey Or yTarg < 0 Then yTarg = Round(boardy)
    
    Dim targetTile As Double, originTile As Double
    
    targetTile = boardList(activeBoardIndex).theData.tiletype(xTarg, yTarg, Int(boardL))
    originTile = boardList(activeBoardIndex).theData.tiletype(xOrig, yOrig, Int(boardL))
       
    Dim centreX As Long, centreY As Long
    
    'Determine the centrepoint of the tile in pixels.
    centreX = getBottomCentreX(boardx, boardy, pending) 'Note: new arguments!
    centreY = getBottomCentreY(boardy)
       
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
        
        If bAccountForUnderTiles And (checkAbove(boardx, boardy, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardx) = xTarg And Round(boardy) = yTarg) _
            Or (originTile = UNDER And Round(boardx) = xOrig And Round(boardy) = yOrig) _
            Or (targetTile = UNDER And originTile = UNDER)) Then
            
            'If bAccountForUnderTiles AND [tiles on layers above
            '    OR [Moving *to* "under" tile (target)]
            '    OR [Moving *from* "under" tile (origin)]
            '    OR [Moving between "under" tiles]]
            
            'If on "under" tiles, make sprite transluscent.
            '4th argument controls opacity of sprite.
            
            If cnvTarget = -1 Then 'Draw to screen
            
               'BUG: This should be a Draw-Partial function! But there is none for transluscent!!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, gTranspColor)
                
            Else 'Draw to canvas.
            
                'BUG: This should be Partial AND Canvas2CanvasBlt AND transluscent!! No such function!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, gTranspColor)
                
            End If
            
        Else
            'Draw solid. Transparent refers to the transparent colour (alpha) on the frame.
            
            If cnvTarget = -1 Then 'Draw to screen
                Call DXDrawCanvasTransparentPartial(cnvFrameID, cornerX, cornerY, offsetX, offsetY, renderWidth, renderHeight, gTranspColor)
                
            Else 'Draw to canvas
                Call Canvas2CanvasBltTransparentPartial(cnvFrameID, cnvTarget, cornerX, cornerY, offsetX, offsetY, renderWidth, renderHeight, gTranspColor)
                
            End If
        End If
        
        
    Else 'Sprite is entirely on the board.
    
        'Check if we need to draw the sprite transluscent.
    
        'ORIGINAL statement:
        'If bAccountForUnderTiles And (checkAbove(boardx, boardy, boardL) = 1 Or boardList(activeBoardIndex).theData.tiletype(Int(boardx), Int(boardy), Int(boardL)) = 2) Then
        
        'NEW: should be identical to above statement.
        
        If bAccountForUnderTiles And (checkAbove(boardx, boardy, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardx) = xTarg And Round(boardy) = yTarg) _
            Or (originTile = UNDER And Round(boardx) = xOrig And Round(boardy) = yOrig) _
            Or (targetTile = UNDER And originTile = UNDER)) Then
            
            'If bAccountForUnderTiles AND [tiles on layers above
            '    OR [Moving *to* "under" tile (target)]
            '    OR [Moving *from* "under" tile (origin)]
            '    OR [Moving between "under" tiles]]
            
            'If on "under" tiles, make sprite transluscent.
            
            If cnvTarget = -1 Then 'Draw to screen
               Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, gTranspColor)
               
            Else 'Draw to canvas
                'This should be Canvas2CanvasBlt transluscent!!
                Call DXDrawCanvasTranslucent(cnvFrameID, cornerX, cornerY, 0.25, -1, gTranspColor)
                
            End If
            
        Else
            If cnvTarget = -1 Then 'Draw to screen
                Call DXDrawCanvasTransparent(cnvFrameID, cornerX, cornerY, gTranspColor)
                
            Else 'Draw to canvas
                Call Canvas2CanvasBltTransparent(cnvFrameID, cnvTarget, cornerX, cornerY, gTranspColor)
                
            End If
        End If
    End If
        
End Sub


Function renderPlayer(ByVal cnv As Long, ByRef thePlayer As TKPlayer, ByVal stance As String, ByVal frame As Long, ByVal idx As Long) As Boolean
    'renders the current player frame into canvas cnv
    'with background color gTranspColor for transparent bltting
    
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

Public Function renderItem(ByVal cnvFrameID As Long, ByRef theItem As TKItem, ByRef itemPosition As PLAYER_POSITION, ByVal idx As Long) As Boolean

    'EDITED: [Isometrics - Delano - 11/04/04]
    'Added code to check if the item is in the viewable area for an isometric board.
    'Renamed variables: ipos >> itemPosition
    '                   cnv >> cnvFrameID
    'Removed "toRet" variable - uses renderItem instead.
    
    'Renders the current Item frame into canvas cnv
    'with background color gTranspColor for transparent bltting
    
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
        If itmPos(idx).x < topX - 1 Or _
            itmPos(idx).x > topX + isoTilesX + 1 Or _
            itmPos(idx).y < (topY * 2 + 1) - 1 Or _
            itmPos(idx).y > (topY * 2 + 1) + isoTilesY + 1 Then
            renderItem = False
            Exit Function
        End If
    Else
        If itmPos(idx).x < topX - 1 Or _
            itmPos(idx).x > topX + tilesX + 1 Or _
            itmPos(idx).y < topY - 1 Or _
            itmPos(idx).y > topY + tilesY + 1 Then
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




Sub createCanvases(ByVal Width As Long, ByVal height As Long)
    On Error Resume Next
    'create all global canvases
    'width and height define the screen extents
    
    'scroll cache is 2x size of screen
    cnvScrollCache = CreateCanvas(Width * 2, height * 2)
    scTilesX = Width * 2 / 32
    scTilesY = height * 2 / 32
    
    If Not (usingDX()) Then
        cnvScrollCacheMask = CreateCanvas(Width * 2, height * 2)
    Else
        cnvScrollCacheMask = -1
    End If
    scTopX = -1: scTopY = -1

    Dim t As Long
    For t = 0 To UBound(cnvPlayer)
        cnvPlayer(t) = CreateCanvas(32, 32)
    Next t
    
    For t = 0 To UBound(cnvSprites)
        cnvSprites(t) = CreateCanvas(32, 32)
    Next t

    cnvBackground = CreateCanvas(Width, height)
    
    cnvRPGCodeScreen = CreateCanvas(Width, height)
       
    'allpurpose canvas
    cnvAllPurpose = CreateCanvas(Width, height)
    allPurposeCanvas = cnvAllPurpose

    'create message box...
    cnvMsgBox = CreateCanvas(600, 100)
    
    'rpgcode scan and mem buffers...
    For t = 0 To UBound(cnvRPGCodeBuffers)
        cnvRPGCodeBuffers(t) = CreateCanvas(32, 32)
    Next t
    
    cnvRPGCodeAccess = CreateCanvas(Width, height)
    
    'Added by KSNiloc...
    globalCanvasHeight = height
    globalCanvasWidth = Width
End Sub


Sub destroyCanvases()
    'destroy global canvases
    On Error Resume Next

    Call DestroyCanvas(cnvScrollCache)
    
    If Not (usingDX()) Then
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

    'rpgcode scan and mem buffers...
    For t = 0 To UBound(cnvRPGCodeBuffers)
        Call DestroyCanvas(cnvRPGCodeBuffers(t))
    Next t

    Call DestroyCanvas(cnvRPGCodeAccess)
    
    For t = 0 To UBound(cnvRPGCode)
        Call DestroyCanvas(cnvRPGCode(t))
    Next t
End Sub

Sub destroyGraphics()
    'kill graphics system
    On Error Resume Next
    
    Call destroyCanvases
    Call CloseCanvasEngine
    Call GFXKill
    Call DXKillGfxMode
    
    Unload host
End Sub

Function BoardRenderEqual(ByRef rend1 As BoardRender, ByRef rend2 As BoardRender) As Boolean
    'determine if two board rendering syructs are equal
    On Error Resume Next
    Dim toRet As Boolean
    
    toRet = False
    
    If rend1.file = rend2.file And _
        rend1.canvas = rend2.canvas And _
        rend1.canvasMask = rend2.canvasMask And _
        rend1.topX = rend2.topX And _
        rend1.topY = rend2.topY And _
        rend1.tilesX = rend2.tilesX And _
        rend1.tilesY = rend2.tilesY And _
        rend1.shadeR = rend2.shadeR And _
        rend1.shadeG = rend2.shadeG And _
        rend1.shadeB = rend2.shadeB And _
        rend1.isometric = rend2.isometric Then
        toRet = True
    End If
    
    BoardRenderEqual = toRet
End Function

Function renderBoard() As Boolean
    '=======================================
    'EDITED: [Isometrics - Delano - 3/05/04]
    'Fixed disappearing columns. Scroll cache wasn't being redrawn early enough.
    '=======================================
    
    
    'Render the board to canvas cnv, and the mask onto canvas cnvMask
    'Set cnvMask to -1 if you don't want the mask drawn
    'Does not re-render if it doesn't have to.
    'Returns true if it did re-render
    
    'Called by renderNow only.
    
    On Error Resume Next
    
    Dim toRet As Boolean
    toRet = True
    
    Dim addonR As Long
    Dim addonG As Long
    Dim addonB As Long
    Dim shadeR As Double, shadeG As Double, shadeB As Double
    Dim a As Long
    Dim l As String
    
    Dim hdc As Long
    Dim hdcMask As Long
    
    'Ambient effects:
    Select Case boardList(activeBoardIndex).theData.ambienteffect
         Case 0
             addonR = 0
             addonG = 0
             addonB = 0
         Case 1
             addonR = 75
             addonG = 75
             addonB = 75
         Case 2
             addonR = -75
             addonG = -75
             addonB = -75
         Case 3
             addonR = 0
             addonG = 0
             addonB = 75
    End Select

    'first, get the shade color of the board...
    a = getIndependentVariable("AmbientRed!", l$, shadeR)
    a = getIndependentVariable("AmbientGreen!", l$, shadeG)
    a = getIndependentVariable("AmbientBlue!", l$, shadeB)
    
    shadeR = shadeR + addonR
    shadeG = shadeG + addonG
    shadeB = shadeB + addonB
       
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Dim lightShade As Long
        
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    Dim fn As String
    
    fn$ = currentBoard$
    fn$ = RemovePath(fn$)
    fn$ = brdPath$ + fn$
          
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
    
    If topX >= scTopX And _
        topY >= scTopY And _
        (topX + tilesXTemp) <= (scTopX + scTilesXTemp) And _
        (topY + tilesY) <= (scTopY + scTilesY - 1) And _
        (scTopX <> -1 And scTopY <> -1) Then
    
        'If current screen is in the scroll cache, don't need to redraw.
    Else
        'we need to re-draw the scrollcache to obtain our screen.
        
        scTopX = Int(topX - (tilesXTemp / 2))
        scTopY = Int(topY - (tilesY / 2))
        If scTopX < 0 And topX >= 0 Then scTopX = 0
        If scTopY < 0 And topY >= 0 Then scTopY = 0
        Call renderScrollCache(cnvScrollCache, cnvScrollCacheMask, scTopX, scTopY)
        Call drawPrograms(1, cnvScrollCache, cnvScrollCacheMask)
    
        'MsgBox "scroll cache redrawn.scTopX=" & scTopX & "scTopY=" & scTopY & "topX=" & topX & "topY=" & topY
        
    End If
    
    renderBoard = toRet
    
End Function

Sub renderNow(Optional ByVal cnvTarget As Long = -1)
    'render the scene now!
    'if cnvTarget <> -1, then render to that canvas.
    'otherwise, render to the screen
    
    On Error Resume Next
    
    Dim cv As Long
       
    'setup offscreen canvases...
    Dim newboard As Boolean
    Dim newSprites As Boolean
    Dim newTileAnm As Boolean
    Dim newItem As Boolean
    Dim newBackground As Boolean
    Dim t As Long
        
    newBackground = renderBackground()
    
    newboard = renderBoard()
    
    Dim ns As Boolean
    For t = 0 To UBound(cnvPlayer)
        If showPlayer(t) Then
            ns = renderPlayer(cnvPlayer(t), playerMem(t), ppos(t).stance, ppos(t).frame, t)
            If ns Then
                newSprites = True
            End If
        End If
    Next t
      
    ' !MODIFIED BY KSNiloc...
    Dim ni As Boolean
    For t = 0 To MAXITEM
        If itemMem(t).bIsActive Then
            ni = renderItem(cnvSprites(t), itemMem(t), itmPos(t), t)
            If ni Then
                newSprites = True
            End If
        End If
    Next t
    
    'check if it's time to check animated tiles
    
    'If lastTimestamp + 5 < Timer Then
    'make sure we're not scrolling right now...
    'If topX = Int(topX) And topY = Int(topY) Then
        lastTimestamp = Timer
        newTileAnm = renderAnimatedTiles(cnvScrollCache, cnvScrollCacheMask)
    'End If
    
    'merge to screen...
    If newboard Or newSprites Or newTileAnm Or newItem Then
        If cnvTarget = -1 Then
            Call DXClearScreen(boardList(activeBoardIndex).theData.brdColor)
            
        Else
            Call CanvasFill(cnvTarget, boardList(activeBoardIndex).theData.brdColor)
        End If
        
        'lay down background, if one exists...
        Call DXDrawBackground(cnvTarget)
        
        'Lay down board...
        Call DXDrawBoard(cnvTarget)

        'lay down sprites...
        Call DXDrawSprites(cnvTarget)
        
        If cnvTarget = -1 Then
            Call DXRefresh
        End If

        'handle multitasking animations
        Call handleMultitaskingAnimations(cnvTarget)
        
    End If
End Sub

Public Sub renderRPGCodeScreen()
    'render the rpgcode canvas to the screen
    'if bShowMsgBox is true, show the message box

    On Error Resume Next

    Dim cv As Long
    Call DXClearScreen(0)
    
    Call DXDrawCanvas(cnvRPGCodeScreen, 0, 0)
    
        
    If gbShowMsgBox Then
        'show the message box!!!
        Dim wd As Long
        wd = GetCanvasWidth(cnvMsgBox)
        'Call PopupCanvas(cnvMsgBox, 0, 0)
        'Call DXDrawCanvas(cnvMsgBox, (tilesX * 32 - wd) / 2, 0)
        Call DXDrawCanvasTranslucent(cnvMsgBox, (tilesX * 32 - wd) / 2, 0, 0.75, fontColor, -1)
    End If

    Call DXRefresh
    Call processEvent '[KSNiloc]
End Sub


Sub renderSpriteFrame(ByVal cnv As Long, ByVal stanceAnm As String, ByVal frame As Long)
    'render a sprite frame at canvas cnv
    'stanceAnm is the animation filename
    'frame is the frame
    
    'checks through the sprite cache for previous renderings
    'of this frame
    
    'if not found, it is rendered here and copied to the sprite cache.
    
    Call renderAnimationFrame(cnv, stanceAnm, frame, 0, 0)
End Sub

Sub DXDrawSprites(ByVal cnvTarget As Long)
    'EDITED: [Isometrics - Delano - 6/04/04]
    'Altered the parameters for putSpriteAt to include the pending movements of the player/items.
    
    'Render sprites (players and items)
    'Called by RenderNow only.
    'Calls putSpriteAt.
    
    On Error Resume Next
    
    Dim ns As Boolean, ni As Boolean
    
    'build some arrays for quick sorting the order we will display the sprites in...

    ' ! MODIFIED BY KSNiloc...
    ReDim indicies(UBound(cnvPlayer) + MAXITEM) As Long
    ReDim locationValues(UBound(cnvPlayer) + MAXITEM) As Long
    Dim t As Long
    Dim theValue As Long
    Dim curIdx As Long
    
    curIdx = 0
    
    'set up location values for players
    For t = 0 To UBound(cnvPlayer)
        If showPlayer(t) Then
            'determine a location value...
            theValue = (ppos(t).y * boardList(activeBoardIndex).theData.Bsizey) + ppos(t).x
            
            'playes will have a negative index so we can differentiate them
            indicies(curIdx) = -1 * (t + 1)
            locationValues(curIdx) = theValue

            curIdx = curIdx + 1
        End If
    Next t

    'set up location values for items...
    
    ' ! MODIFIED BY KSNiloc...
    For t = 0 To MAXITEM
        If itemMem(t).bIsActive Then
        
            'determine a location value...
            theValue = (itmPos(t).y * boardList(activeBoardIndex).theData.Bsizey) + itmPos(t).x
            
            'items will have a positive index so we can differentiate them
            indicies(curIdx) = t
            locationValues(curIdx) = theValue
            
            curIdx = curIdx + 1
        End If
    Next t
    
    'ok, now sort these to determine which order we should draw them in!
    Call quickSortSprites(locationValues, indicies, 0, curIdx - 1)
       
    Dim curNum As Long
    'now draw them...
    For t = 0 To curIdx - 1
        If (indicies(t) < 0) Then
            'this is a player
            curNum = (-1 * indicies(t)) - 1
            Call putSpriteAt(cnvPlayer(curNum), _
                    ppos(curNum).x, _
                    ppos(curNum).y, _
                    ppos(curNum).l, _
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

Sub scrollLeft(ByVal movementFraction As Double)
    'scroll the rendered board left (by movementFraction tiles)
    On Error Resume Next
    
    topX = topX + movementFraction
    
    Call checkScrollBounds

End Sub

Sub scrollDown(ByVal movementFraction As Double)
    'scroll the rendered board down (by movementFraction tiles)
    On Error Resume Next
    
    topY = topY - movementFraction
    
    Call checkScrollBounds
End Sub

Sub scrollDownLeft(ByVal movementFraction As Double, ByVal scrollEast As Boolean, ByVal scrollNorth As Boolean)
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

Sub scrollDownRight(ByVal movementFraction As Double, ByVal scrollWest As Boolean, ByVal scrollNorth As Boolean)
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

Sub scrollUpLeft(ByVal movementFraction As Double, ByVal scrollEast As Boolean, ByVal scrollsouth As Boolean)
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

Sub scrollUpRight(ByVal movementFraction As Double, ByVal scrollWest As Boolean, ByVal scrollsouth As Boolean)
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

Sub scrollUp(ByVal movementFraction As Double)
    'scroll the rendered board down (by movementFraction tiles)
    On Error Resume Next
    
    topY = topY + movementFraction

    Call checkScrollBounds
End Sub

Sub scrollRight(ByVal movementFraction As Double)
    'scroll the rendered board right (by movementFraction tiles)
    On Error Resume Next
    topX = topX - movementFraction

    Call checkScrollBounds
End Sub

Sub showMsgBox()
    'show the message box on the next rpgcode render
    gbShowMsgBox = True
End Sub

Sub hideMsgBox()
    'show the message box on the next rpgcode render
    gbShowMsgBox = False
End Sub

Sub showScreen(ByVal Width As Long, ByVal height As Long, Optional ByVal testingPRG As Boolean)
    'EDITED: [Isometrics - Delano 29/03/04]
    'Added the assignment of isoTilesX,Y - dimensions of screen in iso-tiles.
    'Can take decimal value: x.5 or x.0
    
    'Init DX or GDI screen
    
    'Called by InitGraphics only.
    
    On Error Resume Next
    
    Dim useDX As Long
    Dim a As Long
    resX = Width: resY = height
    
    tilesX = Int(Width / 32)
    tilesY = Int(height / 32)
    
    'Dimensions of screen in isometric tiles.
    isoTilesX = tilesX / 2 '= 10.0 (640res) = 12.5 (800res)
    isoTilesY = tilesY * 2 '= 30 (640res) = 36 (800res)
   
    If mainMem.mainScreenType = 2 Then
        useDX = 0
    Else
        useDX = 1
    End If
    useDX = 1
    
    If useDX = 1 Then
        inDXMode = True
    End If
    
    Dim fullScreen As Long
    If Not testingPRG Then
        fullScreen = mainMem.extendToFullScreen
    Else
        fullScreen = 0
        endform.Tag = 1
    End If
    
    If fullScreen = 0 Then
        inFullScreenMode = False
        host.style = 1
    Else
        inFullScreenMode = True
        host.style = 0
    End If

    With host
        .Width = Width * screen.TwipsPerPixelX
        .height = height * screen.TwipsPerPixelY
        .Top = (screen.height - .height) / 2
        .Left = (screen.Width - .Width) / 2
        If Not inFullScreenMode Then
            .Width = .Width + 6 * screen.TwipsPerPixelX
            .height = .height + 24 * screen.TwipsPerPixelY
        End If
    End With

    Dim depth As Long
    Select Case mainMem.colordepth
        Case COLOR16:
            depth = 16
        Case COLOR24:
            depth = 24
        Case COLOR32:
            depth = 32
    End Select
    
    Call host.Show
    
    Dim done As Boolean
    Do Until done
        'enter Graphics mode...
        a = DXInitGfxMode(host.hwnd, Width, height, useDX, depth, fullScreen)
        If a = 0 Then
            'tried to init gfx, but failed.
            'try a different color depth...
            If depth = 16 And fullScreen = 0 Then
                'tried everything...
                Call Unload(host)
                Call MsgBox("Error initializing graphics mode.  Make sure you have DirectX 8 or higher installed.")
                End
            End If
            If depth = 32 Then
                depth = 24
            ElseIf depth = 24 Then
                depth = 16
            ElseIf depth = 16 Then
                fullScreen = 0
                inFullScreenMode = False
            End If
        Else
            done = True
        End If
    Loop
    
    Call DXClearScreen(0)
    
    'find transparent color...
    Call determineTransparentColor
    
    'Now set up offscreen canvases
    Call createCanvases(Width, height)
End Sub

Sub initGraphics(Optional ByVal testingPRG As Boolean) ' [KSNiloc]
    'initialise the playing window based upon the data in the main file
    On Error Resume Next
    Dim a As Long
    
    Call InitTkGfx
    
    'call tracestring("in Form_Load... abouit to init canvas system")
    Call InitCanvasEngine
    'call tracestring("done canvas system")
    
    'Call InitLayerSystem
    
    'call tracestring("about to test joystick")
    useJoystick = JoyTest()
    'call tracestring("done joystick")
    
    screenWidth = screen.height * (1 / 0.75)
    screenHeight = screen.height
   
    resX = (screenWidth) / screen.TwipsPerPixelX
    resY = screenHeight / screen.TwipsPerPixelY
    
    If mainMem.mainResolution = 0 Then
        Call showScreen(640, 480, testingPRG)
        screenWidth = 640 * screen.TwipsPerPixelX
        screenHeight = 480 * screen.TwipsPerPixelY
    ElseIf mainMem.mainResolution = 1 Then
        Call showScreen(800, 600, testingPRG)
        screenWidth = 800 * screen.TwipsPerPixelX
        screenHeight = 600 * screen.TwipsPerPixelY
    ElseIf mainMem.mainResolution = 2 Then
        Call showScreen(1024, 768, testingPRG)
        screenWidth = 1024 * screen.TwipsPerPixelX
        screenHeight = 768 * screen.TwipsPerPixelY
    End If
    
End Sub

Function usingDX() As Boolean
    usingDX = inDXMode
End Function

Function usingFullScreen() As Boolean
    usingFullScreen = inFullScreenMode
End Function
