Attribute VB_Name = "transRender"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Trans3 rendering engine
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================

' Initiate DirectX
Public Declare Function DXInitGfxMode Lib "actkrt3.dll" (ByVal hwnd As Long, ByVal nScreenX As Long, ByVal nScreenY As Long, ByVal nUseDirectX As Long, ByVal nColorDepth As Long, ByVal nFullScreen As Long) As Long

' Deinitiate DirectX
Public Declare Function DXKillGfxMode Lib "actkrt3.dll" () As Long

' Flip the back buffer onto the screen
Public Declare Function DXFlip Lib "actkrt3.dll" Alias "DXRefresh" () As Long

' Lock the screen, obtaining its HDC
Public Declare Function DXLockScreen Lib "actkrt3.dll" () As Long

' Unlock the screen, releasing its DC
Public Declare Function DXUnlockScreen Lib "actkrt3.dll" () As Long

' Plot a pixel on the screen
Public Declare Function DXDrawPixel Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long

' Render a canvas to the screen
Public Declare Function DXDrawCanvas Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

' Draw a canavs transparently onto the screen
Public Declare Function DXDrawCanvasTransparent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTranspColor As Long) As Long

' Draw a canavs translucently onto the screen
Public Declare Function DXDrawCanvasTranslucent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long

' Black out the screen
Public Declare Function DXClearScreen Lib "actkrt3.dll" (ByVal crColor As Long) As Long

' Draw text onto the screen
Public Declare Function DXDrawText Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal strText As String, ByVal strTypeFace As String, ByVal size As Long, ByVal clr As Long, ByVal Bold As Long, ByVal Italics As Long, ByVal Underline As Long, ByVal centred As Long, ByVal outlined As Long) As Long

' Draw part of a canvas on the screen
Public Declare Function DXDrawCanvasPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

' Draw part of a canvas onto the screen using transparency
Public Declare Function DXDrawCanvasTransparentPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTranspColor As Long) As Long

' Copy the screen to a canvas
Public Declare Function DXCopyScreenToCanvas Lib "actkrt3.dll" (ByVal canvasID As Long) As Long

' Convert a client window's coords to the screen coords
Private Declare Function ClientToScreen Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long

' Set a rect
Private Declare Function SetRect Lib "user32" (lpRect As RECT, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long

' Offset a rect
Private Declare Function OffsetRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long

' Move memory around
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)

'=========================================================================
' Globals
'=========================================================================

' FPS to *try* and render
Public Const RENDER_FPS = 60

' Screen width and height in twips
Public screenWidth As Integer, screenHeight As Integer

' Screen width and height in pixels
Public resX As Long, resY As Long

' Location of cursor hand
Private Const HAND_RESOURCE_ID = 101

' Location of end form background
Private Const ENDFORM_RESOURCE_ID = 102

' Location of default mouse pointer
Private Const DEFAULT_MOUSE_ID = 103

' HDC to the cursor hand
Public handHDC As Long

' HDC to an unaltered cursor hand
Public handBackupHDC As Long

' HDC to end form background
Public endFormBackgroundHDC As Long

' Height and width of global canvases
Public globalCanvasHeight As Long, globalCanvasWidth As Long

' Number of isometric tiles the screen can hold
Public isoTilesX As Double, isoTilesY As Double

' Offset of a scrolled board
Public topX As Double, topY As Double

' Top x, y of the scroll cache
Public scTopX As Double, scTopY As Double

' Size of the scroll cache in tiles
Public scTilesX As Long, scTilesY As Long

' Canvas holding background image
Public cnvBackground As Long

' Canvas holding scroll cache
Public cnvScrollCache As Long

' Mask for the scroll cache
Public cnvScrollCacheMask As Long

' Five canvases for player sprites
Public cnvPlayer(4) As Long

' Show this player?
Public showPlayer(4) As Boolean

' Canvases for item sprites
Public cnvSprites() As Long

' The all-purpose canvas
Public cnvAllPurpose As Long, allPurposeCanvas As Long

' Canvas used for rpgcode
Public cnvRPGCodeScreen As Long

' Canvas for message box
Public cnvMsgBox As Long

' Show the message box>
Private bShowMsgBox As Boolean

' Canvases for Mem() / Scan()
Public cnvRPGCodeBuffers(10) As Long

' Canvas used in version 2 for SaveScreen() / RestoreScreen()
Public cnvRPGCodeAccess As Long

' Canvases for the said purpose in version 3
Public cnvRPGCode() As Long

' Transparent color (white)
Public Const TRANSP_COLOR = 16777215

' Alternate transparent color (black)
Public Const TRANSP_COLOR_ALT = 0

' In DirectX mode? (yes, always :P)
Private Const inDXMode As Boolean = True

' In full-screen mode?
Private inFullScreenMode As Boolean

' Last board rendered
Public lastRender As CBoardRender

' Last player renders
Public lastPlayerRender(4) As PlayerRender

' Last item renders
Public lastItemRender() As PlayerRender

' Filename of last background image rendered
Public lastRenderedBackground As String

' Types CBCanvasPopup() can popup a canvas
Public Const POPUP_NOFX = 0, POPUP_VERTICAL = 1, POPUP_HORIZONTAL = 2

' Silly variables which shouldn't exist
Public addOnR As Long, addOnG As Long, addOnB As Long

' RPGCode 'render now' canvas
Public cnvRenderNow As Long

' Should we render cnvRenderNow?
Public renderRenderNowCanvas As Boolean

' Should it be rendered translucently?
Public renderRenderNowCanvasTranslucent As Boolean

' Canvas used for the mouse pointer
Public cnvMousePointer As Long

'=========================================================================
' A player render
'=========================================================================
Private Type PlayerRender
    canvas As Long              ' Canvas used for this render
    stance As String            ' Stance player was rendered in
    frame As Long               ' Frame of this stance
    x As Double                 ' X position the render occured in
    y As Double                 ' Y position the render occured in
End Type

'=========================================================================
' A rectangle
'=========================================================================
Private Type RECT
    Left As Long                ' Left coord
    Top As Long                 ' Top coord
    Right As Long               ' Right coord
    Bottom As Long              ' Bottom coord
End Type

'=========================================================================
' A point
'=========================================================================
Private Type POINTAPI
    x As Long                   ' X coord
    y As Long                   ' Y coord
End Type

'=========================================================================
' Flip the back buffer onto the screen
'=========================================================================
Public Sub DXRefresh()
    ' Create a var to hold a pointer to a canvas
    Dim cnv As Long
    ' Create a canvas
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    ' Copy the screen to that canvas
    Call CanvasGetScreen(cnv)
    ' Draw the mouse cursor
    Call DXDrawCanvasTransparent(cnvMousePointer, mouseMoveX - host.cursorHotSpotX, mouseMoveY - host.cursorHotSpotY, mainMem.transpcolor)
    ' Actually make the flip
    Call DXFlip
    ' Render the screen sans mouse cursor to the back buffer
    Call DXDrawCanvas(cnv, 0, 0)
    ' Destroy the said canvas
    Call DestroyCanvas(cnv)
End Sub

'=========================================================================
' Check if board can scroll
'=========================================================================
Private Sub checkScrollBounds()

    On Error Resume Next

    ' Is the board isometric?
    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then

        ' Check topX
        If (topX + isoTilesX + 0.5 >= boardList(activeBoardIndex).theData.bSizeX) Then _
            topX = boardList(activeBoardIndex).theData.bSizeX - isoTilesX - 0.5

        ' Check topY
        If ((topY * 2 + 1) + isoTilesY >= boardList(activeBoardIndex).theData.bSizeY) Then _
            topY = (boardList(activeBoardIndex).theData.bSizeY - isoTilesY - 1) / 2

    Else

        ' Check topX
        If (topX + tilesX > boardList(activeBoardIndex).theData.bSizeX) Then _
            topX = boardList(activeBoardIndex).theData.bSizeX - tilesX

        ' Check topY
        If (topY + tilesY > boardList(activeBoardIndex).theData.bSizeY) Then _
            topY = boardList(activeBoardIndex).theData.bSizeY - tilesY

    End If

    ' Can't have x as less than 0
    If (topX < 0) Then topX = 0

    ' Can't have y as less than 0
    If (topY < 0) Then topY = 0

End Sub

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
        If LenB(bgt) <> 0 Then
            'If there is a tile here.

            Call drawTileCNV(cnvScrollCache, _
                          projectPath & tilePath & bgt, _
                          xx, _
                          yy, _
                          boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
                          boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
                          boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, False)

            'If cnvScrollCacheMask <> -1 Then
            '
            '    Call drawTileCNV(cnvScrollCacheMask, _
            '                  projectPath & tilePath & BoardGetTile(x, y, layer, boardList(activeBoardIndex).theData), _
            '                  xx, _
            '                  yy, _
            '                  boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
            '                  boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
            '                  boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, True, False)
            '
            'End If
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
                        Call drawTileCNV(cnv, _
                                        projectPath & tilePath & boardList(activeBoardIndex).theData.progGraphic$(prgNum), _
                                        x - scTopX, _
                                        y - scTopY, _
                                        boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
                                        boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
                                        boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, False)
                    End If

                    'If cnvMask <> -1 Then
                    '    Call drawTileCNV(cnvMask, _
                    '                    projectPath & tilePath & boardList(activeBoardIndex).theData.progGraphic$(prgNum), _
                    '                    x - scTopX, _
                    '                    y - scTopY, _
                    '                    boardList(activeBoardIndex).theData.ambientRed(x, y, layer) + shadeR, _
                    '                    boardList(activeBoardIndex).theData.ambientGreen(x, y, layer) + shadeG, _
                    '                    boardList(activeBoardIndex).theData.ambientBlue(x, y, layer) + shadeB, True, False)
                    'End If
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

    If LenB(boardList(activeBoardIndex).theData.brdBack) <> 0 Then
        'If there is a background.
    
        Dim pixelTopX As Long, pixelTopY As Long
        Dim pixelTilesX As Long, pixelTilesY As Long

        pixelTopX = 0
        pixelTopY = 0
        pixelTilesX = tilesX * 32
        pixelTilesY = tilesY * 32

        Dim imageWidth As Long
        Dim imageHeight As Long
        
        'Dimensions of image, stored in canvas. Background image loaded into canvas when board loaded.
        imageWidth = GetCanvasWidth(cnvBackground)
        imageHeight = GetCanvasHeight(cnvBackground)
        
        Dim percentScrollX As Double, percentScrollY As Double
        Dim maxScrollX As Double, maxScrollY As Double
        Dim tilesXTemp As Double
        
        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
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
    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then x1 = (topX - scTopX) * 64

    If cnvTarget = -1 Then 'Render to screen (to the scrollcache).

        'If usingDX() Then
            Call DXDrawCanvasTransparentPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR)
        'Else
        '    Call DXDrawCanvasPartial(cnvScrollCacheMask, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
        '    Call DXDrawCanvasPartial(cnvScrollCache, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        'End If

    Else 'Render to canvas

        'If usingDX() Then
            Call Canvas2CanvasBltTransparentPartial(cnvScrollCache, _
                                                    cnvTarget, _
                                                    0, 0, x1, y1, tilesX * 32, tilesY * 32, TRANSP_COLOR)
        'Else
        '    Call Canvas2CanvasBltPartial(cnvScrollCacheMask, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCAND)
        '    Call Canvas2CanvasBltPartial(cnvScrollCache, cnvTarget, 0, 0, x1, y1, tilesX * 32, tilesY * 32, SRCPAINT)
        'End If
    End If

End Sub

'=========================================================================
' Render a canvas in a certain way (called only by CBPopupCanvas)
'=========================================================================
Public Sub PopupCanvas(ByVal cnv As Long, ByVal x As Long, ByVal y As Long, ByVal stepSize As Long, ByVal popupType As Long)

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
                For c = h \ 2 To 0 Step stepSize
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
                For c = W \ 2 To 0 Step stepSize
                    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
                    Call DXDrawCanvasPartial(cnv, x + c, y, 0, 0, W \ 2 - c, h)
                    Call DXDrawCanvasPartial(cnv, x + W \ 2, y, W - cnt, 0, W \ 2 - c, h)
                    Call DXRefresh
                    cnt = cnt - stepSize
                    Call delay(walkDelay)
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
        
        For t = 0 To boardList(activeBoardIndex).theData.anmTileInsertIdx - 1
            If TileAnmShouldDrawFrame(boardList(activeBoardIndex).theData.animatedTile(t).theTile) Then
                toRet = True
                
                Dim shadeR As Long, shadeB As Long, shadeG As Long
                Call getAmbientLevel(shadeR, shadeB, shadeG)
                
                'now redraw the layers...
                x = boardList(activeBoardIndex).theData.animatedTile(t).x
                y = boardList(activeBoardIndex).theData.animatedTile(t).y
                xx = boardList(activeBoardIndex).theData.animatedTile(t).x - scTopX
                yy = boardList(activeBoardIndex).theData.animatedTile(t).y - scTopY
                
                For lll = 1 To boardList(activeBoardIndex).theData.bSizeL
                    Dim bgt As String
                    bgt = BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData)
                    If LenB(bgt) <> 0 Then
                        ext$ = GetExt(bgt)
                        If UCase$(ext$) <> "TAN" Then
                            'not the animated part
                            If cnv <> -1 Then
                                Call drawTileCNV(cnv, _
                                              projectPath & tilePath & bgt, _
                                              xx, _
                                              yy, _
                                              boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                                              boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                                              boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, False)
                            End If
                            
                            'If cnvMask <> -1 Then
                            '    Call drawTileCNV(cnvMask, _
                            '                  projectPath & tilePath & BoardGetTile(x, y, lll, boardList(activeBoardIndex).theData), _
                            '                  xx, _
                            '                  yy, _
                            '                  boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                            '                  boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                            '                  boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, True, False)
                            'End If
                        Else
                            If cnv <> -1 Then
                                'If cnvMask <> -1 Then
                                '    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                '                                cnv, _
                                '                                xx, _
                                '                                yy, _
                                '                                boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                                '                                boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                                '                                boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, False)
                                'Else
                                    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                                                                cnv, _
                                                                xx, _
                                                                yy, _
                                                                boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                                                                boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                                                                boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, True, True, False)
                                'End If
                            End If
                            'If cnvMask <> -1 Then
                            '    Call TileAnmDrawNextFrameCNV(boardList(activeBoardIndex).theData.animatedTile(t).theTile, _
                            '                                cnvMask, _
                            '                                xx, _
                            '                                yy, _
                            '                                boardList(activeBoardIndex).theData.ambientRed(x, y, lll) + shadeR, _
                            '                                boardList(activeBoardIndex).theData.ambientGreen(x, y, lll) + shadeG, _
                            '                                boardList(activeBoardIndex).theData.ambientBlue(x, y, lll) + shadeB, True, True, True)
                            'End If
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
    ' If we need to render the background
    If (lastRenderedBackground <> boardList(activeBoardIndex).theData.brdBack) Then
        ' Fill bkg will black
        Call CanvasFill(cnvBackground, 0)
        ' If there's an image set
        If (LenB(boardList(activeBoardIndex).theData.brdBack) <> 0) Then
            ' Load the image, stretching to fit the board
            Call CanvasLoadFullPicture(cnvBackground, projectPath & bmpPath & boardList(activeBoardIndex).theData.brdBack, resX, resY)
        End If
        ' Update the last rendered background
        lastRenderedBackground = boardList(activeBoardIndex).theData.brdBack
        ' Flag we rendered the backgrond
        renderBackground = True
    End If
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
Private Sub renderScrollCache(ByVal cnv As Long, ByVal cnvMask As Long, ByVal tX As Long, ByVal tY As Long)
    On Error Resume Next
    ' Create a new CBoardRender object
    Dim currentRender As New CBoardRender
    ' With that object
    With currentRender
        ' Set in the canvas
        .canvas = cnv
        ' Set in the mask (should be -1)
        .canvasMask = cnvMask
        ' Set in topX
        .topX = tX
        ' Set in topY
        .topY = tY
        ' Render the board
        Call .Render
    End With
    ' Update the last render
    Set lastRender = currentRender
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
    'Problems occur if the sprites are partially off the screen and transluscent,
    'since no actkrt functions have been written (yet) to do this.
    '============================================================================
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
    
    Dim targetTile As Byte, originTile As Byte
    
    targetTile = boardList(activeBoardIndex).theData.tiletype(Round(xTarg), -Int(-yTarg), Int(boardL))
    originTile = boardList(activeBoardIndex).theData.tiletype(Round(xOrig), -Int(-yOrig), Int(boardL))
       
    'Do some tiletype checks now instead of later.
    Dim drawTransluscently As Boolean
    
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
                drawTransluscently = True
        End If
    Else
        If _
            checkAbove(boardX, boardY, boardL) = 1 _
            Or (targetTile = UNDER And Round(boardX) = Round(xTarg) And -Int(-boardY) = -Int(-yTarg)) _
            Or (originTile = UNDER And Round(boardX) = Round(xOrig) And -Int(-boardY) = -Int(-yOrig)) _
            Or (targetTile = UNDER And originTile = UNDER) Then
                drawTransluscently = True
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
    spriteWidth = GetCanvasWidth(cnvFrameID)
    spriteHeight = GetCanvasHeight(cnvFrameID)
        
    'Will place the top left corner of the sprite frame at cornerX, cornerY:
    cornerX = centreX - spriteWidth \ 2
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
        
        If drawTransluscently And bAccountForUnderTiles Then
        'If bAccountForUnderTiles And (checkAbove(boardX, boardY, boardL) = 1 _
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
    
        'Check if we need to draw the sprite transluscently.
        
        If drawTransluscently And bAccountForUnderTiles Then
        'If bAccountForUnderTiles And (checkAbove(boardX, boardY, boardL) = 1 _
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

            If Timer() - .idleTime >= thePlayer.idleTime And Left$(UCase$(.stance), 5) <> "STAND" Then
                'Push into idle graphics if not already.

                'Check that a standing graphic for this direction exists.

                Dim direction As Long
                Select Case UCase$(.stance)
                    Case "WALK_N": direction = 1        'See CommonPlayer
                    Case "WALK_S": direction = 0
                    Case "WALK_E": direction = 3
                    Case "WALK_W": direction = 2
                    Case "WALK_NW": direction = 4
                    Case "WALK_NE": direction = 5
                    Case "WALK_SW": direction = 6
                    Case "WALK_SE": direction = 7
                    Case Else: direction = -1
                End Select

                If direction <> -1 Then
                    If LenB(thePlayer.standingGfx(direction)) <> 0 Then
                        'If so, change the stance to STANDing.
                        .stance = "stand" & Right$(.stance, Len(.stance) - 4)

                        'Start the loop counter for idleness.
                        .loopFrame = -1

                    End If
                End If

            End If

            If Left$(UCase$(.stance), 5) = "STAND" Then
                'We're standing!

                If .loopFrame Mod (((thePlayer.loopSpeed + loopOffset) * 8) / movementSize) = 0 Then
                    'Only increment the frame if we're on a multiple of .speed.
                    'Include a scaling factor (8) to slow down this animation.
                    '/ movementSize to handle pixel movement.
                    .frame = .frame + 1
                    .loopFrame = 0
                End If

                'Let's make use of those negative numbers.
                .loopFrame = .loopFrame - 1

                'Force a draw even though there's nothing new.
                'renderPlayer = True

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

        'lastPlayerRender(idx) = currentRender
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
        
        'Directional standing graphics for 3.0.5
        '===========================================
        'Check idleness.
        If pendingItemMovement(idx).direction = MV_IDLE Then
            'We're idle.
            
            If Timer() - .idleTime >= theItem.idleTime And Left$(UCase$(.stance), 5) <> "STAND" Then
                'Push into idle graphics if not already.
                
                Dim direction As Long
                Select Case UCase$(.stance)
                    Case "WALK_N": direction = 1        'See CommonItem
                    Case "WALK_S": direction = 0
                    Case "WALK_E": direction = 3
                    Case "WALK_W": direction = 2
                    Case "WALK_NW": direction = 4
                    Case "WALK_NE": direction = 5
                    Case "WALK_SW": direction = 6
                    Case "WALK_SE": direction = 7
                    Case Else: direction = -1
                End Select
                
                'Check that a standing graphic for this direction exists.
                If direction <> -1 Then
                    If LenB(theItem.standingGfx(direction)) <> 0 Then
                        'If so, change the stance to STANDing.
                        .stance = "stand" & Right$(.stance, Len(.stance) - 4)
                        
                        'Start the loop counter for idleness.
                        .loopFrame = -1
                    End If
                End If
                
            End If
            
            If Left$(UCase$(.stance), 5) = "STAND" Then
                'We're standing!
                
                If .loopFrame Mod (((theItem.loopSpeed + loopOffset) * 8) / movementSize) = 0 Then
                    'Only increment the frame if we're on a multiple of .speed.
                    'Include a scaling factor (8) to slow down this animation.
                    '/ movementSize to handle pixel movement.
                    .frame = .frame + 1
                    .loopFrame = 0
                End If
                
                'Let's make use of those negative numbers.
                .loopFrame = .loopFrame - 1
                
                'Force a draw even though there's nothing new.
                'renderItem = True
                    
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
               
            'lastItemRender(idx) = currentRender
            .canvas = cnv
            .frame = itemPosition.frame
            .stance = itemPosition.stance
            .x = itemPosition.x
            .y = itemPosition.y
                
        End With
        
        Call renderAnimationFrame(cnv, itemGetStanceAnm(.stance, theItem), .frame, 0, 0)
        
    End With
    
    renderItem = True

End Function

'=========================================================================
' Create global canvases
'=========================================================================
Private Sub createCanvases(ByVal width As Long, ByVal height As Long)
    On Error Resume Next
    cnvScrollCache = CreateCanvas(width * 2, height * 2)
    scTilesX = width * 2 \ 32
    scTilesY = height * 2 \ 32
    'If Not usingDX() Then
    '    cnvScrollCacheMask = CreateCanvas(width * 2, height * 2)
    'Else
        cnvScrollCacheMask = -1
    'End If
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
    cnvMousePointer = CreateCanvas(32, 32)
    Call CanvasFill(cnvMousePointer, 0)
    globalCanvasHeight = height
    globalCanvasWidth = width
End Sub

'=========================================================================
' Destroy global canvases
'=========================================================================
Private Sub destroyCanvases()
    On Error Resume Next
    Call DestroyCanvas(cnvScrollCache)
    'If Not usingDX() Then
    '    Call DestroyCanvas(cnvScrollCacheMask)
    'End If
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
    Call DestroyCanvas(cnvMousePointer)
End Sub

'========================================================================='
' Kill and unload the graphics system
'=========================================================================
Public Sub destroyGraphics()

    ' Empty int
    Dim newValue As Long

    ' Destroy global canvases
    Call destroyCanvases

    ' Shut down the canvas engine
    Call CloseCanvasEngine

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

        renderBoard = True

    End If

End Function

'=========================================================================
' Render the scene now! Returns whether a redraw occured or not.
'=========================================================================
Public Function renderNow(Optional ByVal cnvTarget As Long = -1, _
                          Optional ByVal forceRender As Boolean) As Boolean

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
        If (showPlayer(t)) Then
            If (renderPlayer(cnvPlayer(t), playerMem(t), pPos(t), t)) Then
                'If we get here, something has changed since the last
                'render and we have to re-render the player sprites.
                newSprites = True
            End If
        End If
    Next t

    'Check if we need to render the item sprites
    For t = 0 To (UBound(boardList(activeBoardIndex).theData.itmActivate))
        If (itemMem(t).bIsActive) Then
            If (renderItem(cnvSprites(t), itemMem(t), itmPos(t), t)) Then
                'If we get here, something has changed since the last
                'render and we have to re-render the item sprites.
                newItem = True
            End If
        End If
    Next t

    'Check if we need to render animated tiles
    newTileAnm = renderAnimatedTiles(cnvScrollCache, cnvScrollCacheMask)

    'If *anything* is new, render it all
    If (newBoard Or newSprites Or newTileAnm Or newItem Or newMultiAnim Or renderRenderNowCanvas Or forceRender) Then

        'Fill the target with the board's color
        If (cnvTarget = -1) Then
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
        Call renderMultiAnimations(cnvTarget)

        'Render the rpgcode renderNow canvas
        If (renderRenderNowCanvas) Then
            If (cnvTarget = -1) Then
                'To the screen
                If (Not renderRenderNowCanvasTranslucent) Then
                    Call DXDrawCanvasTransparent(cnvRenderNow, 0, 0, 0)
                Else
                    Call DXDrawCanvasTranslucent(cnvRenderNow, 0, 0)
                End If
            Else
                'To a canvas
                If (Not renderRenderNowCanvasTranslucent) Then
                    Call Canvas2CanvasBltTransparent(cnvRenderNow, cnvTarget, 0, 0, 0)
                Else
                    Call Canvas2CanvasBltTranslucent(cnvRenderNow, cnvTarget, 0, 0)
                End If
            End If
        End If

        If (cnvTarget = -1) Then

            ' --- COPIED TO SAVE OVERHEAD ---

            ' Create a var to hold a pointer to a canvas
            Dim cnv As Long
            ' Create a canvas
            cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
            ' Copy the screen to that canvas
            Call CanvasGetScreen(cnv)
            ' Draw the mouse cursor
            Call DXDrawCanvasTransparent(cnvMousePointer, mouseMoveX - host.cursorHotSpotX, mouseMoveY - host.cursorHotSpotY, mainMem.transpcolor)
            ' Actually make the flip
            Call DXFlip
            ' Render the screen sans mouse cursor to the back buffer
            Call DXDrawCanvas(cnv, 0, 0)
            ' Destroy the said canvas
            Call DestroyCanvas(cnv)

            ' --- END COPY ---

        End If
        
        renderNow = True
        
    End If

End Function

'=========================================================================
' Same as renderNow, but used while running RPGCode
'=========================================================================
Public Sub renderRPGCodeScreen()

    On Error Resume Next

    ' Create a var to hold a pointer to a canvas
    Dim cnv As Long

    ' Create a canvas
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)

    ' Copy the screen to that canvas
    Call CanvasGetScreen(cnv)

    ' Draw the mouse cursor
    Call DXDrawCanvasTransparent(cnvMousePointer, mouseMoveX - host.cursorHotSpotX, mouseMoveY - host.cursorHotSpotY, mainMem.transpcolor)

    ' Draw the message box if it's being shown
    If (bShowMsgBox) Then
        Call DXDrawCanvasTranslucent(cnvMsgBox, (tilesX * 32 - 600) * 0.5, 0, 0.75, fontColor, -1)
    End If

    ' Actually make the flip
    Call DXFlip

    ' Render the screen sans mouse cursor to the back buffer
    Call DXDrawCanvas(cnv, 0, 0)

    ' Destroy the said canvas
    Call DestroyCanvas(cnv)

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

    Dim depth As Long               ' Color depth
    Dim pPrimarySurface As Long     ' Pointer to the primary surface
    Dim pSecondarySurface As Long   ' Pointer to the secondary surface

    ' Use DirectX
    Const useDX = 1

    ' Update resolution
    resX = width
    resY = height

    ' Number of tiles screen can hold
    tilesX = width \ 32
    tilesY = height \ 32

    ' Dimensions of screen in isometric tiles
    isoTilesX = tilesX / 2 ' = 10.0 (640res) = 12.5 (800res)
    isoTilesY = tilesY * 2 ' = 30 (640res) = 36 (800res)

    ' Get fullscreen setting from main file (unless we're testing
    ' a PRG, then it's always windowed)
    Dim fullScreen As Long
    If (Not testingPRG) Then
        ' Check main file
        fullScreen = mainMem.extendToFullScreen
        ' Show the end form
        bShowEndForm = True
    Else
        ' Not in full screen
        fullScreen = 0
        ' Do not show the end form
        bShowEndForm = False
    End If

    If (fullScreen = 0) Then
        ' We are not in full screen mode
        inFullScreenMode = False
        ' Show the host windowed
        host.style = windowed
    Else
        ' We are in full screen mode
        inFullScreenMode = True
        ' Show the host full screen
        host.style = FullScreenMode
    End If

    ' Set the dimensions the host window will be created with
    With host
        .width = width * Screen.TwipsPerPixelX
        .height = height * Screen.TwipsPerPixelY
        .Top = (Screen.height - .height) \ 2
        .Left = (Screen.width - .width) \ 2
        If (Not inFullScreenMode) Then
            ' If not in full screen mode, increase to account for window border
            .width = .width + 6 * Screen.TwipsPerPixelX
            .height = .height + 24 * Screen.TwipsPerPixelY
        End If
    End With

    ' Get screen depth from the main file
    Select Case mainMem.colordepth
        Case COLOR16: depth = 16    ' 16 bit
        Case COLOR24: depth = 24    ' 24 bit
        Case COLOR32: depth = 32    ' 32 bit
    End Select

    ' Create the host window
    Call host.Create

    ' Enter the gfx initialization loop
    Do

        ' Attempt to initiate DirectX
        If (DXInitGfxMode(host.hwnd, width, height, useDX, depth, fullScreen) = 0) Then
            If ((depth = 16) And (fullScreen = 0)) Then
                ' Destroy the host window
                Call Unload(host)
                ' Inform the user
                Call MsgBox("Error initializing graphics mode. Make sure you have DirectX 8 or higher installed.")
                ' Show the end form
                Call showEndForm(True)
            ElseIf (depth = 32) Then
                ' Decrease color depth to 24 bit
                depth = 24
            ElseIf (depth = 24) Then
                ' Decrease color depth to 16 bit
                depth = 16
            ElseIf (depth = 16) Then
                ' Try windowed mode
                fullScreen = 0
                inFullScreenMode = False
            End If
        Else
            ' Exit the initiating loop
            Exit Do
        End If

    Loop

    ' Now set up offscreen canvases
    Call createCanvases(width, height)

    ' Clear the screen (remove backbuffer garbage)
    Call DXClearScreen(0)

    ' Render the screen
    Call DXRefresh

    ' Show the DirectX host window
    Call host.Show

End Sub

'=========================================================================
' Initiate the graphics engine
'=========================================================================
Public Sub initGraphics(Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    ' Init the gfx engine
    Call InitTkGfx

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

    'Get res from main file
    If (mainMem.mainResolution = 0) Then
        screenWidth = 640
        screenHeight = 480
    ElseIf (mainMem.mainResolution = 1) Then
        screenWidth = 800
        screenHeight = 600
    ElseIf (mainMem.mainResolution = 2) Then
        screenWidth = 1024
        screenHeight = 768
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
