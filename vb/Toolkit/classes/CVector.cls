VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVector"
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

Private Type TKVectorPoint
    X As Long
    Y As Long
    bSel As Boolean                     'Editor data: Is the point in a selection?
End Type

Private m_tiletype As eTileType
Private m_layer As Long
Private m_attributes As Long
Private m_bClosed As Boolean
Private m_pts() As TKVectorPoint

'=========================================================================
' Constructor
'=========================================================================
Private Sub Class_Initialize()
    ReDim m_pts(0)
    m_tiletype = TT_NULL
End Sub
Public Property Get tiletype() As eTileType: On Error Resume Next
    tiletype = m_tiletype
End Property
Public Property Get layer() As Long: On Error Resume Next
    layer = m_layer
End Property

'=========================================================================
' Add a point to the vector
'=========================================================================
Public Sub addPoint(ByVal xPxBrd As Long, ByVal yPxBrd As Long) ': on error resume next
    Dim i As Long
    i = 0
    If m_tiletype = TT_NULL Then
        ' No points defined.
        m_tiletype = TT_SOLID
    Else
        i = UBound(m_pts) + 1
    End If
    ReDim Preserve m_pts(i)
    m_pts(i).X = xPxBrd
    m_pts(i).Y = yPxBrd
End Sub

'=========================================================================
' Draw to a picture box
'=========================================================================
Public Sub draw(ByRef pic As PictureBox, ByRef pCEd As CBoardEditor, ByVal color As Long): 'on error resume next
    Dim oldColor As Long
    If m_tiletype = TT_NULL Or UBound(m_pts) = 0 Then Exit Sub
    oldColor = pic.ForeColor
    pic.ForeColor = color
    Dim i As Long, pt1 As POINTAPI, pt2 As POINTAPI
    'Straight onto the hdc.
    For i = 0 To UBound(m_pts) - 1
        pt1.X = m_pts(i).X: pt1.Y = m_pts(i).Y
        pt2.X = m_pts(i + 1).X: pt2.Y = m_pts(i + 1).Y
        Call pCEd.boardPixelToScreen(pt1.X, pt1.Y)
        Call pCEd.boardPixelToScreen(pt2.X, pt2.Y)
        pic.Line (pt1.X, pt1.Y)-(pt2.X, pt2.Y)
        pic.currentX = pt1.X
        pic.currentY = pt1.Y
        pic.Print str(i)
    Next i
    pic.currentX = pt2.X
    pic.currentY = pt2.Y
    pic.Print str(i)
    If m_bClosed Then
        pt1.X = m_pts(0).X: pt1.Y = m_pts(0).Y
        Call pCEd.boardPixelToScreen(pt1.X, pt1.Y)
        pic.Line (pt1.X, pt1.Y)-(pt2.X, pt2.Y)
    End If
    pic.ForeColor = oldColor
End Sub

'=========================================================================
' Close the vector (to make a polygon)
'=========================================================================
Public Sub closeVector(ByVal shiftState As Integer, ByVal layer As Long) ':on error resume next
    If UBound(m_pts) = 0 Then
        'Delete vectors with only one point (create a free slot).
        m_tiletype = TT_NULL
        Exit Sub
    End If
    
    'Keep the vector open if a shift* key is down or there are only two points.
    m_bClosed = ((shiftState = 0) And (UBound(m_pts) > 1))
    m_layer = layer
End Sub

'=========================================================================
' Delete points in a selection
'=========================================================================
Public Sub deleteSelection(ByRef sel As CBoardSelection) ':on error resume next
    Dim i As Long, pts() As TKVectorPoint
    If m_tiletype = TT_NULL Then Exit Sub

    ReDim pts(0)
    For i = 0 To UBound(m_pts)
        If Not sel.containsPoint(m_pts(i).X, m_pts(i).Y) Then
            pts(UBound(pts)) = m_pts(i)
            ReDim Preserve pts(UBound(pts) + 1)
        End If
    Next i
    
    If UBound(pts) <= 1 Then
        'Zero or one point - delete.
        m_tiletype = TT_NULL
        m_bClosed = False
        ReDim m_pts(0)
    Else
        ReDim Preserve pts(UBound(pts) - 1)
        m_pts = pts
        'Two points - open vector.
        If UBound(pts) = 1 Then m_bClosed = False
    End If
        
End Sub

'=========================================================================
' Extend a point in a selection. Point must be an open start/endpoint
'=========================================================================
Public Function extendSelection(ByRef sel As CBoardSelection, ByRef X As Long, ByRef Y As Long) As Boolean ':on error resume next
    'Extend the first endpoint found.
    Dim i As Long, j As Long, ub As Long, bEx As Boolean, pts() As TKVectorPoint
    
    If m_bClosed Then Exit Function
    
    'Only allow extension of open vectors from the back or front.
    ub = UBound(m_pts)
    
    If sel.containsPoint(m_pts(0).X, m_pts(0).Y) Then
        'Reverse the array to append from the end.
        ReDim pts(ub)
        For j = 0 To ub
            pts(j) = m_pts(ub - j)
        Next j
        m_pts = pts
        extendSelection = True
    End If
    
    If sel.containsPoint(m_pts(ub).X, m_pts(ub).Y) Then
        extendSelection = True
    End If
    
    If extendSelection Then
        'Return the start-point of the new vector.
        X = m_pts(ub).X
        Y = m_pts(ub).Y
    End If
        
End Function

'=========================================================================
' Move points a selection
'=========================================================================
Public Sub moveSelection(ByVal dx As Long, ByVal dy As Long) ':on error resume next
    Dim i As Long
    If m_tiletype = TT_NULL Then Exit Sub
    
    For i = 0 To UBound(m_pts)
        If m_pts(i).bSel Then
            ' Don't do a CBoardSelection.containsPoint() test because this may pick up new points on the move.
            m_pts(i).X = m_pts(i).X + dx
            m_pts(i).Y = m_pts(i).Y + dy
        End If
    Next i
End Sub

'=========================================================================
' Assign bools to points in a selection
'=========================================================================
Public Sub setSelection(ByRef sel As CBoardSelection) ': on error resume next
    Dim i As Long
    If m_tiletype = TT_NULL Then Exit Sub
    For i = 0 To UBound(m_pts)
        m_pts(i).bSel = sel.containsPoint(m_pts(i).X, m_pts(i).Y)
    Next i
End Sub

'=========================================================================
' Subdivide selected lines (if start and end points selected)
'=========================================================================
Public Sub subdivideSelection(ByRef sel As CBoardSelection) ':on error resume next
    Dim i As Long, j As Long, pts() As TKVectorPoint
    If m_tiletype = TT_NULL Then Exit Sub
    
    ReDim pts(0)
    i = UBound(m_pts)
    For j = 0 To UBound(m_pts)
        
        If sel.containsPoint(m_pts(i).X, m_pts(i).Y) And _
            sel.containsPoint(m_pts(j).X, m_pts(j).Y) And _
            ((i > j And m_bClosed) Or i < j) Then
            
            'Add an extra point in between.
            pts(UBound(pts)).X = Round((m_pts(i).X + m_pts(j).X) / 2)
            pts(UBound(pts)).Y = Round((m_pts(i).Y + m_pts(j).Y) / 2)
            ReDim Preserve pts(UBound(pts) + 1)
        End If
        
        'Add original point.
        pts(UBound(pts)) = m_pts(j)
        ReDim Preserve pts(UBound(pts) + 1)
        i = j
    Next j

    ReDim Preserve pts(UBound(pts) - 1)
    m_pts = pts
        
End Sub
