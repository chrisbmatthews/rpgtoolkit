Attribute VB_Name = "Scroll"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'scroll- the crap that makes the board scroll
'5/25/99

'Global boardlist(activeboardindex).topx, boardlist(activeboardindex).topy   'the top x and y coords. (offset)



'Module array to store bitmap handles selected out of DCs
Dim miSavedBitmaps(3) As Long        'Used in resources example


'Windows resources functions
Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal dwrop As Long) As Long
Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
'FIXIT: As Any is not supported in Visual Basic .NET. Use a specific type.                 FixIT90210ae-R5608-H1984
Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, ByVal lpBits As Any) As Long
Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Declare Function SetPixelV& Lib "gdi32" (ByVal hdc&, ByVal X&, ByVal Y&, ByVal crColor&)
'Windows resources functions for VB 4 users
'Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
'Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
'Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
'Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
'Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
'Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
'Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
'Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
'Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

Sub scrollDown(ByVal isIsometric As Long): On Error GoTo ErrorHandler
    '=========================================
    'Edited for 3.0.4 by Delano for isometrics
    
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board up...
    
    Call vbPicAutoRedraw(activeBoard.boardform, True)
    Call vbPicAutoRedraw(activeBoard.rowstrip, True)
    
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    'Added.
    If isIsometric Then
    
        'shift board down...
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            0, 16, tX * 64 - 32, tY * 16 - 16, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tX * 64 - 32, 16 - 1, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else
    
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            0, 32, tX * 32, tY * 32, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tX * 32, 32 - 1, _
            boardList(activeBoardIndex).theData.brdColor)

    End If
    
    'c = 1
    'For t = 1 To c
    '    'shift board down...
    '    a = BitBlt(vbPicHDC(activeBoard.boardform), _
    '    0, (tall / c), boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, _
    '    vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    'Next t
    'Call vbPicFillRect(activeBoard.boardform, 0, 0, boardList(activeBoardIndex).tilesX * 32, (tall / c) - 1, boardList(activeBoardIndex).theData.brdColor)
    

    iso = False
    If isIsometric = 1 Then
    '    'different number of tiles to draw if isometric
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
        iso = True
    End If
    
    If isIsometric = 1 Then
        'must redraw the row of tiles just below the top, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
            xx = boardList(activeBoardIndex).topX + cnt
            Y = boardList(activeBoardIndex).topY + 2
            lay = boardList(activeBoardIndex).currentLayer
    
            tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            If Y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, t - boardList(activeBoardIndex).topX, 2, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff above...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
        xx = boardList(activeBoardIndex).topX + cnt
        Y = boardList(activeBoardIndex).topY + 1
        lay = boardList(activeBoardIndex).currentLayer

        tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        If Y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, t - boardList(activeBoardIndex).topX, 1, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    'Call vbPicRefresh(activeBoard.boardform)
    

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Sub scrollLeft(ByVal isIsometric As Long)
    'assumes that the column is already
    'saved onto the colstrip.
    'now scroll the board left...
    On Error GoTo ErrorHandler
    
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
   
    If isIsometric Then
    
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            -64, 0, tX * 64 - 32, tY * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            tX * 64 - 96, 0, tX * 64 - 32, tX * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)


    Else
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            -32, 0, tX * 32, tY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
            
        Call vbPicFillRect(activeBoard.boardform, _
            tX * 32 - 32, 0, tX * 32, tX * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If
    
    'c = 1
    'For t = 1 To c
    '    'shift board up...
    '    a = BitBlt(vbPicHDC(activeBoard.boardform), _
    '    (-tall / c), 0, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, _
    '    vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    'Next t
    'Call vbPicFillRect(activeBoard.boardform, boardList(activeBoardIndex).tilesX * 32 - (tall / c), 0, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).theData.brdColor)
    
    'activeBoard.boardform.Line (0, 0)-(1000, 1000), 0, BF
    
    iso = False
    If isIsometric = 1 Then
    '    'different number of tiles to draw if isometric
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
        iso = True
    End If
    
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If
    
    If isIsometric = 1 Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
            xx = boardList(activeBoardIndex).topX + tX - 1
            Y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer
    
            tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, tX - 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
        xx = boardList(activeBoardIndex).topX + tX
        Y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, tX, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    'Call vbPicRefresh(activeBoard.boardform)
    
    Exit Sub
    
    Call vbPicAutoRedraw(activeBoard.boardform, True)
    Call vbPicAutoRedraw(activeBoard.colstrip, True)
    c = 4
    For t = 1 To c
        'shift board left...
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
        (-32 / c), 0, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        'add part of colstrip...
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
        boardList(activeBoardIndex).tilesX * 32 - (32 / c * t), 0, 32, boardList(activeBoardIndex).tilesY * 32, _
        vbPicHDC(activeBoard.colstrip), 0, 0, SRCCOPY)
        'refresh
        'Call vbPicRefresh(activeBoard.boardform)
    Next t

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Sub scrollRight(ByVal isIsometric As Long)
    'assumes that the column is already
    'saved onto the colstrip.
    'now scroll the board right...
    On Error GoTo ErrorHandler
    
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    If isIsometric Then
    
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            64, 0, tX * 64 - 32, yy * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 64 - 1, tX * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            32, 0, yX * 32, tY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)

        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 32 - 1, tX * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If
    
    'c = 1
    'For t = 1 To c
    '    'shift board up...
    '    a = BitBlt(vbPicHDC(activeBoard.boardform), _
    '    (tall / c), 0, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, _
    '    vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    'Next t
    'Call vbPicFillRect(activeBoard.boardform, 0, 0, (tall / c) - 1, boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).theData.brdColor)
    
    'activeBoard.boardform.Line (0, 0)-(1000, 1000), 0, BF
    
    iso = False
    If isIsometric = 1 Then
        'different number of tiles to draw if isometric
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
        iso = True
    End If
    
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If
    
    If isIsometric = 1 Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
            xx = boardList(activeBoardIndex).topX + 2
            Y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer
    
            tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, 2, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
        xx = boardList(activeBoardIndex).topX + 1
        Y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    'Call vbPicRefresh(activeBoard.boardform)
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub scrollUp(ByVal isIsometric As Long)
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board up...
    On Error GoTo ErrorHandler
    Call vbPicAutoRedraw(activeBoard.boardform, True)
    
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    If isIsometric Then
        'tall = 16
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            0, -16, tX * 64 - 32, tY * 16 - 16, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, tY * 16 - 32, tX * 64 - 32, tY * 16 - 16, _
            boardList(activeBoardIndex).theData.brdColor)
    Else
        'tall = 32
        a = BitBlt(vbPicHDC(activeBoard.boardform), _
            0, -32, tX * 32, tY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, tY * 32 - 32, tX * 32, tY * 32, _
            boardList(activeBoardIndex).theData.brdColor)
    End If
    
    'c = 1
    'For t = 1 To c
    '    'shift board up...
    '    a = BitBlt(vbPicHDC(activeBoard.boardform), _
    '    0, (-tall / c), boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, _
    '    vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    'Next t
    'Call vbPicFillRect(activeBoard.boardform, 0, boardList(activeBoardIndex).tilesY * 32 - (tall / c), boardList(activeBoardIndex).tilesX * 32, boardList(activeBoardIndex).tilesY * 32, boardList(activeBoardIndex).theData.brdColor)
    
    iso = False
    If isIsometric = 1 Then
        'different number of tiles to draw if isometric
        'tX = Int(tX / 2) + 1
        'tY = tY * 2 + 1
        iso = True
    End If
    
    If isIsometric = 1 Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
            xx = boardList(activeBoardIndex).topX + cnt
            Y = boardList(activeBoardIndex).topY + tY - 1
            lay = boardList(activeBoardIndex).currentLayer
    
            tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            If Y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, t - boardList(activeBoardIndex).topX, tY - 1, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
        xx = boardList(activeBoardIndex).topX + cnt
        Y = boardList(activeBoardIndex).topY + tY
        lay = boardList(activeBoardIndex).currentLayer

        tname$ = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        If Y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath$ + tilepath$ + tname$, t - boardList(activeBoardIndex).topX, tY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    'Call vbPicRefresh(activeBoard.boardform)
    

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Public Function toString(val) As String
'    'returns sting-- no spaces!
'    t$ = Str$(val)
'    t$ = nospace(t$)
'    toString = t$
'End Function

Sub shiftDown()
    'shifts the board down (scroll north)
    On Error GoTo ErrorHandler
    If boardList(activeBoardIndex).topY < 0 Then Exit Sub
    
    'Call activeBoard.boardRedraw
    Call scrollDown(boardList(activeBoardIndex).theData.isIsometric)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftLeft()
    'shifts the board left (scroll east)
    On Error GoTo ErrorHandler
    
    If boardList(activeBoardIndex).topY = 50 - boardList(activeBoardIndex).tilesX Then Exit Sub
    
    'Call activeBoard.boardRedraw
    Call scrollLeft(boardList(activeBoardIndex).theData.isIsometric)
    

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftRight()
    'scrolls the board right (west)
    On Error GoTo ErrorHandler
    If boardList(activeBoardIndex).topX < 0 Then Exit Sub
    'Call setupColumnScroll(boardList(activeBoardIndex).topX + 1, boardList(activeBoardIndex).topY + 1)
    Call scrollRight(boardList(activeBoardIndex).theData.isIsometric)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftUp()
    'shifts the board up (scroll south)
    On Error GoTo ErrorHandler
    If boardList(activeBoardIndex).topY = 50 - boardList(activeBoardIndex).tilesX Then Exit Sub
    
    'Call activeBoard.boardRedraw
    Call scrollUp(boardList(activeBoardIndex).theData.isIsometric)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

