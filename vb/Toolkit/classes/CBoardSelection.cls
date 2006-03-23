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

'=========================================================================
'=========================================================================
Public Sub draw(ByRef edFrm As frmBoardEdit, ByRef pCEd As CBoardEditor) ':on error resume next
    If status <> SS_NONE Then
        'Call vbPicRect(picBoard, sel.area.Left, sel.area.Top, sel.area.Right, sel.area.Bottom, m_ed.sel.Color)
        
        Dim pt1 As POINTAPI, pt2 As POINTAPI, i As Integer
        pt1.x = x1: pt1.y = y1: pt2.x = x2: pt2.y = y2
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        Call pCEd.boardPixelToScreen(pt2.x, pt2.y)
        
        edFrm.lineSelection(0).x1 = pt1.x: edFrm.lineSelection(0).x2 = pt2.x: edFrm.lineSelection(0).y1 = pt1.y: edFrm.lineSelection(0).y2 = pt1.y
        edFrm.lineSelection(1).x1 = pt1.x: edFrm.lineSelection(1).x2 = pt2.x: edFrm.lineSelection(1).y1 = pt2.y: edFrm.lineSelection(1).y2 = pt2.y
        edFrm.lineSelection(2).x1 = pt1.x: edFrm.lineSelection(2).x2 = pt1.x: edFrm.lineSelection(2).y1 = pt1.y: edFrm.lineSelection(2).y2 = pt2.y
        edFrm.lineSelection(3).x1 = pt2.x: edFrm.lineSelection(3).x2 = pt2.x: edFrm.lineSelection(3).y1 = pt1.y: edFrm.lineSelection(3).y2 = pt2.y
    
        For i = 0 To 3
            edFrm.lineSelection(i).Visible = True
        Next i
    End If
End Sub
Public Sub drawLine(ByRef edFrm As frmBoardEdit, ByRef pCEd As CBoardEditor) ':on error resume next
    If status <> SS_NONE Then
        Dim pt1 As POINTAPI, pt2 As POINTAPI
        pt1.x = x1: pt1.y = y1: pt2.x = x2: pt2.y = y2
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        Call pCEd.boardPixelToScreen(pt2.x, pt2.y)
        
        edFrm.lineSelection(0).x1 = pt1.x
        edFrm.lineSelection(0).x2 = pt2.x
        edFrm.lineSelection(0).y1 = pt1.y
        edFrm.lineSelection(0).y2 = pt2.y
        edFrm.lineSelection(0).Visible = True
    End If
End Sub
Public Sub expandToGrid(ByVal coordType As Long, ByVal brdSizeX As Long) ':on error resume next
    Dim dx As Integer, dy As Integer, pt As POINTAPI
    'Is the end point in front of the start point? tbd: isometrics!
    If isIsometric(coordType) Then
        'Reorientate.
        dx = x1: dy = y1
        If x1 > x2 Then x1 = x2: x2 = dx
        If y1 > y2 Then y1 = y2: y2 = dy
        
        pt = boardPixelToTile(x1, y1, coordType, brdSizeX)
        pt = tileToBoardPixel(pt.x, pt.y, coordType, brdSizeX, True)
        x1 = pt.x: y1 = pt.y
        
        'Round to nearest 32nd or 16th.
        x2 = x2 - ((x2 + 16) Mod 32) + 16
        y2 = y2 - ((y2 + 8) Mod 16) + 8
        
        'Minimum size.
        If x2 - x1 < 64 Then x2 = x1 + 64
        If y2 - y1 < 32 Then y2 = y1 + 32
    Else
        If x1 > x2 Then dx = 1
        If y1 > y2 Then dy = 1
        
        pt = boardPixelToTile(x1, y1, coordType, brdSizeX)
        pt = tileToBoardPixel(pt.x + dx, pt.y + dy, coordType, brdSizeX)
        x1 = pt.x: y1 = pt.y
        
        pt = boardPixelToTile(x2, y2, coordType, brdSizeX)
        pt = tileToBoardPixel(pt.x + Abs(dx - 1), pt.y + Abs(dy - 1), coordType, brdSizeX)
        x2 = pt.x: y2 = pt.y
    End If
End Sub
Public Sub clear(ByRef edFrm As frmBoardEdit) ':on error resume next
    Dim i As Integer
    status = SS_NONE
    For i = 0 To edFrm.lineSelection.count - 1
        edFrm.lineSelection(i).Visible = False
    Next i
End Sub
Public Function containsPoint(ByVal x As Long, ByVal y As Long) As Boolean ':on error resume next
    'Check for an inverted selection.
    Dim r As Long, l As Long, b As Long, t As Long
    r = IIf(x1 > x2, x1, x2): l = IIf(x1 > x2, x2, x1)
    b = IIf(y1 > y2, y1, y2): t = IIf(y1 > y2, y2, y1)
    containsPoint = (x >= l And x <= r And y >= t And y <= b)
End Function
Public Sub move(ByVal dx As Long, ByVal dy As Long)  ':on error resume next
    x1 = x1 + dx: x2 = x2 + dx
    y1 = y1 + dy: y2 = y2 + dy
End Sub
Public Sub restart(ByVal x As Long, ByVal y As Long) ':on error resume next
    status = SS_DRAWING
    x1 = x:    y1 = y
    x2 = x:    y2 = y
End Sub