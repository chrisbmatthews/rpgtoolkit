Attribute VB_Name = "CommonTileBitmap"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'tile bitmap
'invented for version 3.0 (July, 2002)
Option Explicit

Public Type TKTileBitmap
    sizex As Integer    'width in tiles
    sizey As Integer    'height in tiles
    tiles() As String   '2x2 array of strings
    redS() As Integer   '2x2 array of red shades
    greenS() As Integer   '2x2 array of red shades
    blueS() As Integer   '2x2 array of red shades
End Type


Public Type tileBitmapDoc
    needUpdate As Boolean
    filename As String
    topX As Integer 'topx coord in scroll
    topY As Integer 'topy in scroll
    selectedTile As String  'currently selected tile
    ambientR As Integer 'current ambient red shade
    ambientG As Integer 'current ambient red shade
    ambientB As Integer 'current ambient red shade
    drawState As Integer            'drawstate.  0- draw lock, 1-eraser
    grid As Integer     'grid state 0=off, 1=on
    
    theData As TKTileBitmap
End Type

'array of tile anms used in the MDI children
Public tileBmpList() As tileBitmapDoc
Public tileBmpListOccupied() As Boolean

Sub TileBitmapSize(ByRef theTileBmp As TKTileBitmap, ByVal sizex As Integer, ByVal sizey As Integer)
    On Error Resume Next
    'resize the tile bitmap killing old data
    
    'resize...
    ReDim theTileBmp.tiles(sizex, sizey)
    ReDim theTileBmp.redS(sizex, sizey)
    ReDim theTileBmp.greenS(sizex, sizey)
    ReDim theTileBmp.blueS(sizex, sizey)
    
    theTileBmp.sizex = sizex
    theTileBmp.sizey = sizey
End Sub



Sub VectTileBmpKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the tile bmp list vector
    tileBmpListOccupied(idx) = False
End Sub

Function VectTileBmpNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(tileBmpList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(tileBmpList)
        If tileBmpListOccupied(t) = False Then
            tileBmpListOccupied(t) = True
            VectTileBmpNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(tileBmpList)
    newSize = UBound(tileBmpList) * 2
    ReDim Preserve tileBmpList(newSize)
    ReDim Preserve tileBmpListOccupied(newSize)
    
    tileBmpListOccupied(oldSize + 1) = True
    VectTileBmpNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim tileBmpList(1)
    ReDim tileBmpListOccupied(1)
    Resume Next
    
End Function

Sub DrawTileBitmap(ByVal hdc As Long, ByVal maskhdc As Long, ByVal x As Long, ByVal y As Long, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'draw a tile bitmap
    
    Dim oldX As Long, oldY As Long, xx As Long, yy As Long
    oldX = x
    oldY = y
    
    xx = x / 32 + 1
    yy = y / 32 + 1
    For x = 0 To theTileBmp.sizex - 1
        For y = 0 To theTileBmp.sizey - 1
            If theTileBmp.tiles(x, y) <> "" Then
                If hdc <> -1 Then
                    Call drawtile(hdc, tilePath$ + theTileBmp.tiles(x, y), x + xx, y + yy, theTileBmp.redS(x, y), theTileBmp.greenS(x, y), theTileBmp.blueS(x, y), False, True, False, False)
                End If
                If maskhdc <> -1 Then
                    Call drawtile(maskhdc, tilePath$ + theTileBmp.tiles(x, y), x + xx, y + yy, theTileBmp.redS(x, y), theTileBmp.greenS(x, y), theTileBmp.blueS(x, y), True, True)
                End If
            Else
                If hdc <> -1 And maskhdc <> -1 Then
                    Call VBHdcFillRect(hdc, oldX + x * 32, oldY + y * 32, oldX + 32 + x * 32, oldY + 32 + y * 32, RGB(0, 0, 0))
                    Call VBHdcFillRect(maskhdc, oldX + x * 32, oldY + y * 32, oldX + 32 + x * 32, oldY + 32 + y * 32, RGB(255, 255, 255))
                End If
            End If
        Next y
    Next x
End Sub


Sub DrawTileBitmapCNV(ByVal cnv As Long, ByVal cnvMask As Long, ByVal x As Long, ByVal y As Long, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'draw a tile bitmap
    
    Dim oldX As Long, oldY As Long, xx As Long, yy As Long
    oldX = x
    oldY = y
    
    xx = x / 32 + 1
    yy = y / 32 + 1
    For x = 0 To theTileBmp.sizex - 1
        For y = 0 To theTileBmp.sizey - 1
            If theTileBmp.tiles(x, y) <> "" Then
                If cnv <> -1 Then
                    Call drawtileCNV(cnv, tilePath$ + theTileBmp.tiles(x, y), x + xx, y + yy, theTileBmp.redS(x, y), theTileBmp.greenS(x, y), theTileBmp.blueS(x, y), False, True, False, False)
                End If
                If cnvMask <> -1 Then
                    Call drawtileCNV(cnvMask, tilePath$ + theTileBmp.tiles(x, y), x + xx, y + yy, theTileBmp.redS(x, y), theTileBmp.greenS(x, y), theTileBmp.blueS(x, y), True, True)
                End If
            Else
                If cnv <> -1 And cnvMask <> -1 Then
                    Call CanvasFillBox(cnv, oldX + x * 32, oldY + y * 32, oldX + 32 + x * 32, oldY + 32 + y * 32, RGB(0, 0, 0))
                    Call CanvasFillBox(cnvMask, oldX + x * 32, oldY + y * 32, oldX + 32 + x * 32, oldY + 32 + y * 32, RGB(255, 255, 255))
                End If
            End If
        Next y
    Next x
End Sub

Sub OpenTileBitmap(ByVal file As String, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'open tile bitmap
    
    'only call this when you haven't called CanvasOpenHDC in DX mode!
    '(Since it'll crash win 98)
    
    Call TileBitmapClear(theTileBmp)
    
    file = PakLocate(file)
    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, x As Long, y As Long
    
    num = FreeFile
    Open file For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "TK3 TILEBITMAP" Then
            Close #num
            MsgBox "Invalid tile bitmap " + file
            Exit Sub
        End If
        majorVer = BinReadInt(num)       'Version
        minorVer = BinReadInt(num)      'Minor version (ie 2.0)
        If majorVer <> 3 Then MsgBox "This tile bitmap was created with an unrecognised version of the Toolkit " + file, , "Unable to open tile bitmap": Exit Sub
        
        'first is the size...
        theTileBmp.sizex = BinReadInt(num)
        theTileBmp.sizey = BinReadInt(num)
        
        Call TileBitmapSize(theTileBmp, theTileBmp.sizex, theTileBmp.sizey)
        For x = 0 To theTileBmp.sizex
            For y = 0 To theTileBmp.sizey
                theTileBmp.tiles(x, y) = BinReadString(num)
                theTileBmp.redS(x, y) = BinReadInt(num)
                theTileBmp.greenS(x, y) = BinReadInt(num)
                theTileBmp.blueS(x, y) = BinReadInt(num)
            Next y
        Next x
    Close #num
End Sub


Sub DrawSizedTileBitmap(ByRef tbm As TKTileBitmap, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long)
    'load and draw an image
    On Error Resume Next
    'MsgBox "drawsized image: " + filename + str$(x) + str$(y) + str$(sizex) + str$(sizey) + str$(hdc)
    
    If screenWidth = 0 Then screenWidth = 4000 * Screen.TwipsPerPixelX
    If screenHeight = 0 Then screenHeight = 4000 * Screen.TwipsPerPixelY
    
    Dim ext As String
    Dim frm As Form
    Dim imgfrm As Form
    Dim a As Long
    
    'also draws tilebitmaps!
    
    Dim cnv As Long, cnvHdc As Long
    Dim cnvMask As Long, cnvmaskHdc As Long
    Dim ww As Long
    
    'MsgBox "create canvases"
    cnv = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
    cnvMask = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
    'MsgBox "done create canvases"
    
    'MsgBox "draw"
    Call DrawTileBitmapCNV(cnv, cnvMask, 0, 0, tbm)
    'MsgBox "done draw"
    
    ww = GetCanvasWidth(cnv)
    Call CanvasMaskBltStretch(cnv, cnvMask, x, y, sizex, sizey, hdc)
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(cnvMask)
End Sub



Sub SaveTileBitmap(ByVal file As String, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'save tile bitmap
    Dim num As Long, x As Long, y As Long
    num = FreeFile
    
    Kill file
    
    Open file For Binary As #num
        Call BinWriteString(num, "TK3 TILEBITMAP")    'Filetype
        Call BinWriteInt(num, 3)
        Call BinWriteInt(num, 0)
        
        'first is the size...
        Call BinWriteInt(num, theTileBmp.sizex)
        Call BinWriteInt(num, theTileBmp.sizey)
        For x = 0 To theTileBmp.sizex
            For y = 0 To theTileBmp.sizey
                Call BinWriteString(num, theTileBmp.tiles(x, y))
                Call BinWriteInt(num, theTileBmp.redS(x, y))
                Call BinWriteInt(num, theTileBmp.greenS(x, y))
                Call BinWriteInt(num, theTileBmp.blueS(x, y))
            Next y
        Next x
    Close #num
End Sub


Sub TileBitmapClear(ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    
    ReDim theTileBmp.tiles(1, 1)
    ReDim theTileBmp.redS(1, 1)
    ReDim theTileBmp.greenS(1, 1)
    ReDim theTileBmp.blueS(1, 1)
    theTileBmp.sizex = 1
    theTileBmp.sizey = 1
End Sub


Sub TileBitmapResize(ByRef theTileBmp As TKTileBitmap, ByVal sizex As Integer, ByVal sizey As Integer)
    On Error Resume Next
    'resize the tile bitmap retaining the current data
    
    'create backup...
    ReDim t(theTileBmp.sizex, theTileBmp.sizey) As String
    ReDim r(theTileBmp.sizex, theTileBmp.sizey) As Integer
    ReDim g(theTileBmp.sizex, theTileBmp.sizey) As Integer
    ReDim b(theTileBmp.sizex, theTileBmp.sizey) As Integer
    
    Dim x As Long, y As Long, xx As Long, yy As Long
    For x = 0 To theTileBmp.sizex
        For y = 0 To theTileBmp.sizey
            t(x, y) = theTileBmp.tiles(x, y)
            r(x, y) = theTileBmp.redS(x, y)
            g(x, y) = theTileBmp.greenS(x, y)
            b(x, y) = theTileBmp.blueS(x, y)
        Next y
    Next x
    
    'resize...
    ReDim theTileBmp.tiles(sizex, sizey)
    ReDim theTileBmp.redS(sizex, sizey)
    ReDim theTileBmp.greenS(sizex, sizey)
    ReDim theTileBmp.blueS(sizex, sizey)
    
    If sizex < theTileBmp.sizex Then xx = sizex Else xx = theTileBmp.sizex
    If sizey < theTileBmp.sizey Then yy = sizey Else yy = theTileBmp.sizey
    
    'now fill it in with the old info...
    For x = 0 To xx
        For y = 0 To yy
            theTileBmp.tiles(x, y) = t(x, y)
            theTileBmp.redS(x, y) = r(x, y)
            theTileBmp.greenS(x, y) = g(x, y)
            theTileBmp.blueS(x, y) = b(x, y)
        Next y
    Next x
    
    theTileBmp.sizex = sizex
    theTileBmp.sizey = sizey
End Sub


