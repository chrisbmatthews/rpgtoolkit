Attribute VB_Name = "Scroll"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' --What is done
' + Option Explicit added
' + 'As Any' fixed
' + Proper scope applied to procedures
' + Replaced type declaration characters with 'as such'
' + Fixed various subtle isometric bugs
' + Swapped +s for &s where appropriate
'
'=======================================================

Option Explicit

Private miSavedBitmaps(3) As Long
Private Declare Function bitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal dwrop As Long) As Long
Private Declare Function createCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function createBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, ByVal lpBits As Double) As Long
Private Declare Function createCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function selectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function deleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function deleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function setPixelV Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long

Private Sub scrollDown(ByVal isIsometric As Long)

    On Error Resume Next

    '=========================================
    'Edited for 3.0.4 by Delano for isometrics
    
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board up...
    
    Call vbPicAutoRedraw(activeBoard.boardform, True)
    Call vbPicAutoRedraw(activeBoard.rowstrip, True)

    Dim tx As Long, ty As Long
    tx = boardList(activeBoardIndex).tilesX
    ty = boardList(activeBoardIndex).tilesY

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    If iso Then
    
        'shift board down...
        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            0, 16, tx * 64 - 32, ty * 16 - 16, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tx * 64 - 32, 16 - 1, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else

        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            0, 32, tx * 32, ty * 32, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tx * 32, 32 - 1, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim cnt As Long, t As Long, eo As Boolean
    Dim x As Long, y As Long, xx As Long
    Dim tName As String, ar As Long, ag As Long, ab As Long, lay As Long

    If iso Then
        'must redraw the row of tiles just below the top, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tx
            xx = boardList(activeBoardIndex).topX + cnt
            y = boardList(activeBoardIndex).topY + 2
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
            If y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, t - boardList(activeBoardIndex).topX, 2, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff above...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tx
        xx = boardList(activeBoardIndex).topX + cnt
        y = boardList(activeBoardIndex).topY + 1
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
        If y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, t - boardList(activeBoardIndex).topX, 1, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub

Private Sub scrollLeft(ByVal isIsometric As Long)
    'assumes that the column is already
    'saved onto the colstrip.
    'now scroll the board left...

    On Error Resume Next

    Dim tx As Long, ty As Long
    tx = boardList(activeBoardIndex).tilesX
    ty = boardList(activeBoardIndex).tilesY

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    If iso Then
    
        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            -64, 0, tx * 64 - 32, ty * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            tx * 64 - 96, 0, tx * 64 - 32, tx * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)


    Else
        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            -32, 0, tx * 32, ty * 32, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
            
        Call vbPicFillRect(activeBoard.boardform, _
            tx * 32 - 32, 0, tx * 32, tx * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim eo As Boolean
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If

    Dim cnt As Long, t As Long, xx As Long, y As Long, lay As Long, tName As String
    Dim ar As Long, ag As Long, ab As Long

    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + ty
            xx = boardList(activeBoardIndex).topX + tx - 1
            y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer

            tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName$, tx - 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + ty
        xx = boardList(activeBoardIndex).topX + tx
        y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, tx, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    
End Sub

Private Sub scrollRight(ByVal isIsometric As Long)
    'assumes that the column is already
    'saved onto the colstrip.
    'now scroll the board right...
    On Error Resume Next

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    Dim tx As Long, ty As Long
    tx = boardList(activeBoardIndex).tilesX
    ty = boardList(activeBoardIndex).tilesY

    If iso Then
    
        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            64, 0, tx * 64 - 32, ty * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 64 - 1, tx * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else
        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            32, 0, tx * 32, ty * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)

        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 32 - 1, tx * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim eo As Boolean
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If
    
    Dim cnt As Long, t As Long, xx As Long, y As Long, lay As Long, tName As String
    Dim ar As Long, ag As Long, ab As Long
    
    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + ty
            xx = boardList(activeBoardIndex).topX + 2
            y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName$, 2, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + ty
        xx = boardList(activeBoardIndex).topX + 1
        y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub

Private Sub scrollUp(ByVal isIsometric As Long)
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board up...

    On Error Resume Next

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    Call vbPicAutoRedraw(activeBoard.boardform, True)

    Dim tx As Long, ty As Long
    tx = boardList(activeBoardIndex).tilesX
    ty = boardList(activeBoardIndex).tilesY

    If iso Then

        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            0, -16, tx * 64 - 32, ty * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, ty * 16 - 32, tx * 64 - 32, ty * 16 - 16, _
            boardList(activeBoardIndex).theData.brdColor)
    Else

        Call bitBlt(vbPicHDC(activeBoard.boardform), _
            0, -32, tx * 32, ty * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, ty * 32 - 32, tx * 32, ty * 32, _
            boardList(activeBoardIndex).theData.brdColor)
    End If
    
    Dim cnt As Long, t As Long, xx As Long, y As Long, lay As Long
    Dim tName As String, ar As Long, ag As Long, ab As Long, eo As Boolean
    
    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tx
            xx = boardList(activeBoardIndex).topX + cnt
            y = boardList(activeBoardIndex).topY + ty - 1
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
            If y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, t - boardList(activeBoardIndex).topX, ty - 1, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If

    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tx
        xx = boardList(activeBoardIndex).topX + cnt
        y = boardList(activeBoardIndex).topY + ty
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
        If y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawtile(vbPicHDC(activeBoard.boardform), projectPath & tilepath & tName, t - boardList(activeBoardIndex).topX, ty, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub

Public Sub shiftDown()
    On Error Resume Next
    If boardList(activeBoardIndex).topY < 0 Then Exit Sub
    Call scrollDown(boardList(activeBoardIndex).theData.isIsometric)
End Sub

Public Sub shiftLeft()
    On Error Resume Next
    If boardList(activeBoardIndex).topY = 50 - boardList(activeBoardIndex).tilesX Then Exit Sub
    Call scrollLeft(boardList(activeBoardIndex).theData.isIsometric)
End Sub

Public Sub shiftRight()
    On Error Resume Next
    If boardList(activeBoardIndex).topX < 0 Then Exit Sub
    Call scrollRight(boardList(activeBoardIndex).theData.isIsometric)
End Sub

Public Sub shiftUp()
    On Error Resume Next
    If boardList(activeBoardIndex).topY = 50 - boardList(activeBoardIndex).tilesX Then Exit Sub
    Call scrollUp(boardList(activeBoardIndex).theData.isIsometric)
End Sub
