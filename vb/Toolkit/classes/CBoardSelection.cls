VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardSelection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Public status As eBrdSelectStatus            'Status of selection.
Public x1 As Long                            'Area.
Public y1 As Long
Public x2 As Long
Public y2 As Long
Public xDrag As Long                         'Mouse point when dragging (board px).
Public yDrag As Long

Public Sub assign(ByVal px1 As Long, ByVal py1 As Long, ByVal px2 As Long, ByVal py2 As Long): On Error Resume Next
    x1 = px1: y1 = py1: x2 = px2: y2 = py2
    status = SS_FINISHED
End Sub

'=========================================================================
'=========================================================================
Public Sub draw(ByRef edfrm As frmBoardEdit, ByRef pCEd As CBoardEditor) ':on error resume next
    If status <> SS_NONE Then
        'Call vbPicRect(picBoard, sel.area.Left, sel.area.Top, sel.area.Right, sel.area.Bottom, m_ed.sel.Color)
        
        Dim pt1 As POINTAPI, pt2 As POINTAPI, i As Integer
        pt1.x = x1: pt1.y = y1: pt2.x = x2: pt2.y = y2
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        Call pCEd.boardPixelToScreen(pt2.x, pt2.y)
        
        edfrm.lineSelection(0).x1 = pt1.x: edfrm.lineSelection(0).x2 = pt2.x: edfrm.lineSelection(0).y1 = pt1.y: edfrm.lineSelection(0).y2 = pt1.y
        edfrm.lineSelection(1).x1 = pt1.x: edfrm.lineSelection(1).x2 = pt2.x: edfrm.lineSelection(1).y1 = pt2.y: edfrm.lineSelection(1).y2 = pt2.y
        edfrm.lineSelection(2).x1 = pt1.x: edfrm.lineSelection(2).x2 = pt1.x: edfrm.lineSelection(2).y1 = pt1.y: edfrm.lineSelection(2).y2 = pt2.y
        edfrm.lineSelection(3).x1 = pt2.x: edfrm.lineSelection(3).x2 = pt2.x: edfrm.lineSelection(3).y1 = pt1.y: edfrm.lineSelection(3).y2 = pt2.y
    
        For i = 0 To 3
            edfrm.lineSelection(i).Visible = True
        Next i
    End If
End Sub
Public Sub drawLine(ByRef edfrm As frmBoardEdit, ByRef pCEd As CBoardEditor) ':on error resume next
    If status <> SS_NONE Then
        Dim pt1 As POINTAPI, pt2 As POINTAPI
        pt1.x = x1: pt1.y = y1: pt2.x = x2: pt2.y = y2
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        Call pCEd.boardPixelToScreen(pt2.x, pt2.y)
        
        edfrm.lineSelection(0).x1 = pt1.x
        edfrm.lineSelection(0).x2 = pt2.x
        edfrm.lineSelection(0).y1 = pt1.y
        edfrm.lineSelection(0).y2 = pt2.y
        edfrm.lineSelection(0).Visible = True
    End If
End Sub

'=========================================================================
'Draw the selection as a rectangular projection onto the coordinate system
'=========================================================================
Public Sub drawProjectedRect(ByRef edfrm As frmBoardEdit, ByRef pCEd As CBoardEditor, ByVal coordType As Integer) ':on error resume next
    
    Dim i As Long, j As Long, pts() As POINTAPI
    If status = SS_NONE Then Exit Sub
    
    If isIsometric(coordType) Then
        
        pts = modBoard.rectProjectIsometric(Me)

        For i = 0 To 3
            Call pCEd.boardPixelToScreen(pts(i).x, pts(i).y)
            edfrm.lineSelection(i).x1 = pts(i).x: edfrm.lineSelection(i).y1 = pts(i).y

            j = (i + 1) Mod 4
            Call pCEd.boardPixelToScreen(pts(j).x, pts(j).y)
            edfrm.lineSelection(i).x2 = pts(j).x: edfrm.lineSelection(i).y2 = pts(j).y
            
            edfrm.lineSelection(i).Visible = True
        Next i

    Else
        Call draw(edfrm, pCEd)
    End If
End Sub

Public Function isEmpty() As Boolean: On Error Resume Next
    isEmpty = (x1 = x2) And (y1 = y2)
End Function

Public Sub expandToGrid(ByVal coordType As Long, ByVal brdSizeX As Long) ':on error resume next
    Dim pt As POINTAPI
    Call Me.reorientate
    If isIsometric(coordType) Then
        pt = boardPixelToTile(x1, y1, coordType, False, brdSizeX)
        pt = tileToBoardPixel(pt.x, pt.y, coordType, False, brdSizeX, True)
        x1 = pt.x: y1 = pt.y
        
        'Round to nearest 32nd or 16th.
        x2 = x2 - ((x2 + 16) Mod 32) + 16
        y2 = y2 - ((y2 + 8) Mod 16) + 8
        
        'Minimum size.
        If x2 - x1 < 64 Then x2 = x1 + 64
        If y2 - y1 < 32 Then y2 = y1 + 32
    Else
        pt = boardPixelToTile(x1, y1, coordType, False, brdSizeX)
        pt = tileToBoardPixel(pt.x, pt.y, coordType, False, brdSizeX)
        x1 = pt.x: y1 = pt.y
        
        pt = boardPixelToTile(x2, y2, coordType, False, brdSizeX)
        pt = tileToBoardPixel(pt.x + 1, pt.y + 1, coordType, False, brdSizeX)
        x2 = pt.x: y2 = pt.y
    End If
End Sub
Public Sub clear(ByRef edfrm As frmBoardEdit): On Error Resume Next
    Dim i As Long
    status = SS_NONE
    For i = 0 To edfrm.lineSelection.count - 1
        edfrm.lineSelection(i).Visible = False
    Next i
End Sub
Public Function containsPoint(ByVal x As Long, ByVal y As Long) As Boolean: On Error Resume Next
    containsPoint = (x >= x1 And x <= x2 And y >= y1 And y <= y2)
End Function
Public Sub move(ByVal dx As Long, ByVal dy As Long): On Error Resume Next
    x1 = x1 + dx: x2 = x2 + dx
    y1 = y1 + dy: y2 = y2 + dy
End Sub
Public Sub restart(ByVal x As Long, ByVal y As Long): On Error Resume Next
    status = SS_DRAWING
    x1 = x:    y1 = y
    x2 = x:    y2 = y
End Sub
Public Sub reorientate(): On Error Resume Next
    Dim dx As Long, dy As Long
    'Reorientate.
    dx = x1: dy = y1
    If x1 > x2 Then x1 = x2: x2 = dx
    If y1 > y2 Then y1 = y2: y2 = dy
End Sub
