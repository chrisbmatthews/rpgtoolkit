VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsScrollBoard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Scrolling procedures for the board editor
'=========================================================================

'=========================================================================
' VB option settings
'=========================================================================
Option Compare Binary
Option Explicit
Option Base 0

'=========================================================================
' Win32 API declarations
'=========================================================================
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal dwrop As Long) As Long

'=========================================================================
' Public interface methods
'=========================================================================
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

'=========================================================================
' Scroll down
'=========================================================================
Private Sub scrollDown(ByVal isIsometric As Long)

    On Error Resume Next
   
    Call vbPicAutoRedraw(activeBoard.boardform, True)
    Call vbPicAutoRedraw(activeBoard.rowstrip, True)

    Dim tX As Long, tY As Long
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    If iso Then
    
        'shift board down...
        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            0, 16, tX * 64 - 32, tY * 16 - 16, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tX * 64 - 32, 16 - 1, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else

        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            0, 32, tX * 32, tY * 32, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)

        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, tX * 32, 32 - 1, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim cnt As Long, t As Long, eo As Boolean
    Dim X As Long, Y As Long, xx As Long
    Dim tName As String, ar As Long, ag As Long, ab As Long, lay As Long

    If iso Then
        'must redraw the row of tiles just below the top, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
            xx = boardList(activeBoardIndex).topX + cnt
            Y = boardList(activeBoardIndex).topY + 2
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            If Y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, t - boardList(activeBoardIndex).topX, 2, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff above...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
        xx = boardList(activeBoardIndex).topX + cnt
        Y = boardList(activeBoardIndex).topY + 1
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        If Y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, t - boardList(activeBoardIndex).topX, 1, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub

'=========================================================================
' Scroll left
'=========================================================================
Private Sub scrollLeft(ByVal isIsometric As Long)

    On Error Resume Next

    Dim tX As Long, tY As Long
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    If iso Then
    
        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            -64, 0, tX * 64 - 32, tY * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            tX * 64 - 96, 0, tX * 64 - 32, tX * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)


    Else
        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            -32, 0, tX * 32, tY * 32, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
            
        Call vbPicFillRect(activeBoard.boardform, _
            tX * 32 - 32, 0, tX * 32, tX * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim eo As Boolean
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If

    Dim cnt As Long, t As Long, xx As Long, Y As Long, lay As Long, tName As String
    Dim ar As Long, ag As Long, ab As Long

    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
            xx = boardList(activeBoardIndex).topX + tX - 1
            Y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer

            tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName$, tX - 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
        xx = boardList(activeBoardIndex).topX + tX
        Y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, tX, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t
    
End Sub

'=========================================================================
' Scroll right
'=========================================================================
Private Sub scrollRight(ByVal isIsometric As Long)

    On Error Resume Next

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    Dim tX As Long, tY As Long
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY

    If iso Then
    
        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            64, 0, tX * 64 - 32, tY * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 64 - 1, tX * 64 - 32, _
            boardList(activeBoardIndex).theData.brdColor)
        
    Else
        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            32, 0, tX * 32, tY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)

        Call vbPicFillRect(activeBoard.boardform, _
            0, 0, 32 - 1, tX * 32, _
            boardList(activeBoardIndex).theData.brdColor)

    End If

    Dim eo As Boolean
    If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        eo = False
    Else
        eo = True
    End If
    
    Dim cnt As Long, t As Long, xx As Long, Y As Long, lay As Long, tName As String
    Dim ar As Long, ag As Long, ab As Long
    
    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
            xx = boardList(activeBoardIndex).topX + 2
            Y = boardList(activeBoardIndex).topY + cnt
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName$, 2, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If
    
    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topY + 1 To boardList(activeBoardIndex).topY + tY
        xx = boardList(activeBoardIndex).topX + 1
        Y = boardList(activeBoardIndex).topY + cnt
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, 1, t - boardList(activeBoardIndex).topY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub

'=========================================================================
' Scroll up
'=========================================================================
Private Sub scrollUp(ByVal isIsometric As Long)

    On Error Resume Next

    Dim iso As Boolean
    If isIsometric = 1 Then
        iso = True
    End If

    Call vbPicAutoRedraw(activeBoard.boardform, True)

    Dim tX As Long, tY As Long
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY

    If iso Then

        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            0, -16, tX * 64 - 32, tY * 16 - 16, _
            vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
        
        Call vbPicFillRect(activeBoard.boardform, _
            0, tY * 16 - 32, tX * 64 - 32, tY * 16 - 16, _
            boardList(activeBoardIndex).theData.brdColor)
    Else

        Call BitBlt(vbPicHDC(activeBoard.boardform), _
            0, -32, tX * 32, tY * 32, _
        vbPicHDC(activeBoard.boardform), 0, 0, SRCCOPY)
    
        Call vbPicFillRect(activeBoard.boardform, _
            0, tY * 32 - 32, tX * 32, tY * 32, _
            boardList(activeBoardIndex).theData.brdColor)
    End If
    
    Dim cnt As Long, t As Long, xx As Long, Y As Long, lay As Long
    Dim tName As String, ar As Long, ag As Long, ab As Long, eo As Boolean
    
    If iso Then
        'must redraw the row of tiles just above the bottom, cos they are cut off
        cnt = 1
        For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
            xx = boardList(activeBoardIndex).topX + cnt
            Y = boardList(activeBoardIndex).topY + tY - 1
            lay = boardList(activeBoardIndex).currentLayer
    
            tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
            ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
            ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
            ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
            If Y Mod 2 = 0 Then
                eo = False
            Else
                eo = True
            End If
            Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, t - boardList(activeBoardIndex).topX, tY - 1, ar, ag, ab, False, True, iso, eo)
            cnt = cnt + 1
        Next t
    End If

    'draw stuff below...
    cnt = 1
    For t = boardList(activeBoardIndex).topX + 1 To boardList(activeBoardIndex).topX + tX
        xx = boardList(activeBoardIndex).topX + cnt
        Y = boardList(activeBoardIndex).topY + tY
        lay = boardList(activeBoardIndex).currentLayer

        tName = BoardGetTile(xx, Y, lay, boardList(activeBoardIndex).theData)
        ar = boardList(activeBoardIndex).theData.ambientred(xx, Y, lay)
        ag = boardList(activeBoardIndex).theData.ambientgreen(xx, Y, lay)
        ab = boardList(activeBoardIndex).theData.ambientblue(xx, Y, lay)
        If Y Mod 2 = 0 Then
            eo = True
        Else
            eo = False
        End If
        Call drawTile(vbPicHDC(activeBoard.boardform), projectPath & tilePath & tName, t - boardList(activeBoardIndex).topX, tY, ar, ag, ab, False, True, iso, eo)
        cnt = cnt + 1
    Next t

End Sub