Attribute VB_Name = "CommonScroll"
'common scroller routines


Public scrollerCanvas As Long
Public scrollerMaskCanvas As Long
Private sSizeX As Long
Private sSizeY As Long  'size of scrollercache in pixels

Private sTopX, sTopY        'scroller top x and y   (-1, -1 means nothing in the cache)
Sub scrollerDrawBoard(ByRef theBoard As boardDoc, ByVal hdc As Long, ByVal maskhdc As Long, ByVal layer As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long)
    'replaces all calls to gfxdrawboard
    'this draws the destried stuff to the screen, but it also sets up the scroller.
    On Error Resume Next
    
    scwidth = sSizeX / 32
    scheight = sSizeY / 32
    
    If theBoard.topY Mod 2 = 0 Then
        eo = 1
    Else
        eo = 0
    End If
    aa = GFXdrawboard(CanvasHDC(scrollerCanvas), CanvasHDC(scrollerMaskCanvas), layer, theBoard.topX, theBoard.topY, scwidth, scheight, theBoard.theData.Bsizex, theBoard.theData.Bsizey, theBoard.theData.Bsizel, ar, ag, ab, theBoard.theData.isIsometric, eo)
    
    sTopX = theBoard.topX
    sTopY = theBoard.topY
    
    'now blt the desired part onto the screen
    If hdc <> -1 Then
        Call CanvasBlt2(scrollerCanvas, 0, 0, 0, 0, theBoard.tilesX * 32, theBoard.tilesY * 32, hdc)
    End If
    
    If maskhdc <> -1 Then
        Call CanvasBlt2(scrollerMaskCanvas, 0, 0, 0, 0, theBoard.tilesX * 32, theBoard.tilesY * 32, maskhdc)
    End If
End Sub


Sub ScrollerInit()
    On Error Resume Next
    
    sTopX = -1
    sTopY = -1
    
    sSizeX = Screen.width / Screen.TwipsPerPixelX
    sSizeY = Screen.height / Screen.TwipsPerPixelY
    
    sSizeX = 800
    sSizeY = 600
    scrollerCanvas = CreateCanvas(sSizeX, sSizeY)
    scrollerMaskCanvas = CreateCanvas(sSizeX, sSizeY)
    
End Sub


Sub scrollerUp(ByRef theBoard As boardDoc, ByVal hdc As Long, ByVal maskhdc As Long, ByVal layer As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long, Optional ByVal pixels As Double = 8)
    On Error Resume Next
    
    scrTopX = sTopX * 32
    scrTopY = sTopY * 32
    
    scrSizeX = sSizeX
    scrSizeY = sSizeY
    
    brdTopX = theBoard.topX * 32
    brdTopY = theBoard.topY * 32
    
    brdsizex = theBoard.tilesX * 32
    brdsizey = theBoard.tilesY * 32
    
        
    brdTopY = brdTopY + pixels
    
    If brdTopY + brdsizey <= scrTopY + scrSizeY Then
        'it is on the scroll cache
        brdTopY = brdTopY + pixels
        diff = brdTopY - scrTopY
        
        If hdc <> -1 Then
            Call CanvasBlt2(scrollerCanvas, 0, 0, 0, diff, brdsizex, brdsizey, hdc)
        End If
        
        If maskhdc <> -1 Then
            Call CanvasBlt2(scrollerMaskCanvas, 0, 0, 0, diff, brdsizex, brdsizey, maskhdc)
        End If
        theBoard.topY = theBoard.topY + (pixels / 32)
    Else
        'it is not on the scroll cache
        theBoard.topY = theBoard.topY + (pixels / 32)
        Call scrollerDrawBoard(theBoard, hdc, maskhdc, layer, ar, ag, ab)
    End If
End Sub

Sub ScrollerShutdown()
    On Error Resume Next
    Call DestroyCanvas(scrollerCanvas)
    Call DestroyCanvas(scrollerMaskCanvas)
End Sub


