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

Sub DrawTileBitmap(ByVal hdc As Long, ByVal maskhdc As Long, ByVal X As Long, ByVal Y As Long, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'draw a tile bitmap
    
    Dim oldX As Long, oldY As Long, xx As Long, yy As Long
    oldX = X
    oldY = Y
    
    xx = X / 32 + 1
    yy = Y / 32 + 1
    For X = 0 To theTileBmp.sizex - 1
        For Y = 0 To theTileBmp.sizey - 1
            If theTileBmp.tiles(X, Y) <> "" Then
                If hdc <> -1 Then
                    Call drawTile(hdc, tilePath & theTileBmp.tiles(X, Y), X + xx, Y + yy, theTileBmp.redS(X, Y), theTileBmp.greenS(X, Y), theTileBmp.blueS(X, Y), False, True, False, False)
                End If
                If maskhdc <> -1 Then
                    Call drawTile(maskhdc, tilePath & theTileBmp.tiles(X, Y), X + xx, Y + yy, theTileBmp.redS(X, Y), theTileBmp.greenS(X, Y), theTileBmp.blueS(X, Y), True, True)
                End If
            Else
                If hdc <> -1 And maskhdc <> -1 Then
                    Call vbHdcFillRect(hdc, oldX + X * 32, oldY + Y * 32, oldX + 32 + X * 32, oldY + 32 + Y * 32, RGB(0, 0, 0))
                    Call vbHdcFillRect(maskhdc, oldX + X * 32, oldY + Y * 32, oldX + 32 + X * 32, oldY + 32 + Y * 32, RGB(255, 255, 255))
                End If
            End If
        Next Y
    Next X
End Sub


Sub DrawTileBitmapCNV(ByVal cnv As Long, ByVal cnvMask As Long, ByVal X As Long, ByVal Y As Long, ByRef theTileBmp As TKTileBitmap): On Error Resume Next
'====================================
'Draw a tile bitmap, including tst.
'Called when rendering sprite frames.
'Edited by Delano.
'====================================
    
    Dim oldX As Long, oldY As Long, xx As Long, yy As Long
    oldX = X
    oldY = Y
    
    xx = X / 32 + 1
    yy = Y / 32 + 1
    For X = 0 To theTileBmp.sizex - 1
        For Y = 0 To theTileBmp.sizey - 1
            If theTileBmp.tiles(X, Y) <> "" Then
                If cnv <> -1 Then
                
                    'Ambient levels determined in renderAnimationFrame *before*
                    'opening DC.

                    #If (isToolkit = 1) Then
                        'Declare variables defined in transRender if running
                        'in toolkit3.exe project
                        Dim addOnR As Double, addOnG As Double, addOnB As Double
                    #End If

                    Call drawTileCNV(cnv, _
                                    tilePath$ & theTileBmp.tiles(X, Y), _
                                    X + xx, _
                                    Y + yy, _
                                    theTileBmp.redS(X, Y) + addOnR, _
                                    theTileBmp.greenS(X, Y) + addOnG, _
                                    theTileBmp.blueS(X, Y) + addOnB, _
                                    False, _
                                    True, _
                                    False, _
                                    False)
                                    
                End If
                
                If cnvMask <> -1 Then
                
                    Call drawTileCNV(cnvMask, _
                        tilePath$ & theTileBmp.tiles(X, Y), _
                        X + xx, _
                        Y + yy, _
                        theTileBmp.redS(X, Y), _
                        theTileBmp.greenS(X, Y), _
                        theTileBmp.blueS(X, Y), _
                        True, _
                        True)
                        
                End If
            Else
                If cnv <> -1 And cnvMask <> -1 Then
                    Call CanvasFillBox(cnv, oldX + X * 32, oldY + Y * 32, oldX + 32 + X * 32, oldY + 32 + Y * 32, RGB(0, 0, 0))
                    Call CanvasFillBox(cnvMask, oldX + X * 32, oldY + Y * 32, oldX + 32 + X * 32, oldY + 32 + Y * 32, RGB(255, 255, 255))
                End If
            End If
        Next Y
    Next X
End Sub

Sub OpenTileBitmap(ByVal file As String, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'open tile bitmap
    
    'only call this when you haven't called CanvasOpenHDC in DX mode!
    '(Since it'll crash win 98)
    
    Call TileBitmapClear(theTileBmp)
    
    file = PakLocate(file)
    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, X As Long, Y As Long
    
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
        For X = 0 To theTileBmp.sizex
            For Y = 0 To theTileBmp.sizey
                theTileBmp.tiles(X, Y) = BinReadString(num)
                theTileBmp.redS(X, Y) = BinReadInt(num)
                theTileBmp.greenS(X, Y) = BinReadInt(num)
                theTileBmp.blueS(X, Y) = BinReadInt(num)
            Next Y
        Next X
    Close #num
End Sub


Sub DrawSizedTileBitmap(ByRef tbm As TKTileBitmap, ByVal X As Long, ByVal Y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long)
    'load and draw an image
    On Error Resume Next
    
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
    Call CanvasMaskBltStretch(cnv, cnvMask, X, Y, sizex, sizey, hdc)
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(cnvMask)
End Sub



Sub SaveTileBitmap(ByVal file As String, ByRef theTileBmp As TKTileBitmap)
    On Error Resume Next
    'save tile bitmap
    Dim num As Long, X As Long, Y As Long
    num = FreeFile
    
    Kill file
    
    Open file For Binary As #num
        Call BinWriteString(num, "TK3 TILEBITMAP")    'Filetype
        Call BinWriteInt(num, 3)
        Call BinWriteInt(num, 0)
        
        'first is the size...
        Call BinWriteInt(num, theTileBmp.sizex)
        Call BinWriteInt(num, theTileBmp.sizey)
        For X = 0 To theTileBmp.sizex
            For Y = 0 To theTileBmp.sizey
                Call BinWriteString(num, theTileBmp.tiles(X, Y))
                Call BinWriteInt(num, theTileBmp.redS(X, Y))
                Call BinWriteInt(num, theTileBmp.greenS(X, Y))
                Call BinWriteInt(num, theTileBmp.blueS(X, Y))
            Next Y
        Next X
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
    
    Dim X As Long, Y As Long, xx As Long, yy As Long
    For X = 0 To theTileBmp.sizex
        For Y = 0 To theTileBmp.sizey
            t(X, Y) = theTileBmp.tiles(X, Y)
            r(X, Y) = theTileBmp.redS(X, Y)
            g(X, Y) = theTileBmp.greenS(X, Y)
            b(X, Y) = theTileBmp.blueS(X, Y)
        Next Y
    Next X
    
    'resize...
    ReDim theTileBmp.tiles(sizex, sizey)
    ReDim theTileBmp.redS(sizex, sizey)
    ReDim theTileBmp.greenS(sizex, sizey)
    ReDim theTileBmp.blueS(sizex, sizey)
    
    If sizex < theTileBmp.sizex Then xx = sizex Else xx = theTileBmp.sizex
    If sizey < theTileBmp.sizey Then yy = sizey Else yy = theTileBmp.sizey
    
    'now fill it in with the old info...
    For X = 0 To xx
        For Y = 0 To yy
            theTileBmp.tiles(X, Y) = t(X, Y)
            theTileBmp.redS(X, Y) = r(X, Y)
            theTileBmp.greenS(X, Y) = g(X, Y)
            theTileBmp.blueS(X, Y) = b(X, Y)
        Next Y
    Next X
    
    theTileBmp.sizex = sizex
    theTileBmp.sizey = sizey
End Sub

