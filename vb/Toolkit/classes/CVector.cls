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
    x As Long
    y As Long
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
Public Property Let tiletype(ByVal tt As eTileType): On Error Resume Next
    m_tiletype = tt
End Property
Public Property Get layer() As Long: On Error Resume Next
    layer = m_layer
End Property
Public Property Let layer(ByVal l As Long): On Error Resume Next
    m_layer = l
End Property
Public Property Get attributes() As Long: On Error Resume Next
    attributes = m_attributes
End Property
Public Property Let attributes(ByVal attr As Long): On Error Resume Next
    m_attributes = attr
End Property
Public Property Get bClosed() As Boolean: On Error Resume Next
    bClosed = m_bClosed
End Property
Public Property Let bClosed(ByVal bC As Boolean): On Error Resume Next
    m_bClosed = bC
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
        'Prevent setting two points at the same coordinate.
        If m_pts(UBound(m_pts)).x = xPxBrd And m_pts(UBound(m_pts)).y = yPxBrd Then Exit Sub
        i = UBound(m_pts) + 1
    End If
    ReDim Preserve m_pts(i)
    m_pts(i).x = xPxBrd
    m_pts(i).y = yPxBrd
End Sub

'=========================================================================
' Draw to a picture box
'=========================================================================
Public Sub draw( _
    ByRef pic As PictureBox, _
    ByRef pCEd As CBoardEditor, _
    ByVal color As Long, _
    ByVal bShowIndices As Boolean, _
    Optional ByVal bCurrentVector As Boolean = False): 'on error resume next
    
    Dim oldColor As Long, i As Long, pt1 As POINTAPI, pt2 As POINTAPI
    If m_tiletype = TT_NULL Or UBound(m_pts) = 0 Then Exit Sub
    
    oldColor = pic.ForeColor
    pic.ForeColor = color
    pic.DrawWidth = IIf(bCurrentVector, 2, 1)
    
    'Straight onto the hdc.
    For i = 0 To UBound(m_pts) - 1
        pt1.x = m_pts(i).x: pt1.y = m_pts(i).y
        pt2.x = m_pts(i + 1).x: pt2.y = m_pts(i + 1).y
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        Call pCEd.boardPixelToScreen(pt2.x, pt2.y)
        pic.Line (pt1.x, pt1.y)-(pt2.x, pt2.y)
        pic.currentX = pt1.x
        pic.currentY = pt1.y
        If bShowIndices Then pic.Print str(i)
    Next i
    pic.currentX = pt2.x
    pic.currentY = pt2.y
    If bShowIndices Then pic.Print str(i)
    If m_bClosed Then
        pt1.x = m_pts(0).x: pt1.y = m_pts(0).y
        Call pCEd.boardPixelToScreen(pt1.x, pt1.y)
        pic.Line (pt1.x, pt1.y)-(pt2.x, pt2.y)
    End If
    pic.ForeColor = oldColor
    pic.DrawWidth = 1
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
' Delete one or all points by index
'=========================================================================
Public Sub deletePoints(Optional ByVal p As Long = -1) ':on error resume next
    If p < 0 Then
    
        ReDim m_pts(0)
        m_tiletype = TT_NULL
        
    ElseIf p <= UBound(m_pts) Then
    
        Dim i As Long, pts() As TKVectorPoint
        ReDim pts(0)
        
        For i = 0 To UBound(m_pts)
            If p <> i Then
                pts(UBound(pts)) = m_pts(i)
                ReDim Preserve pts(UBound(pts) + 1)
            End If
        Next i
    End If
End Sub

'=========================================================================
' Delete points in a selection
'=========================================================================
Public Sub deleteSelection(ByRef sel As CBoardSelection) ':on error resume next
    Dim i As Long, pts() As TKVectorPoint
    If m_tiletype = TT_NULL Then Exit Sub

    ReDim pts(0)
    For i = 0 To UBound(m_pts)
        If Not sel.containsPoint(m_pts(i).x, m_pts(i).y) Then
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
Public Function extendSelection(ByRef sel As CBoardSelection, ByRef x As Long, ByRef y As Long) As Boolean ':on error resume next
    'Extend the first endpoint found.
    Dim i As Long, j As Long, ub As Long, bEx As Boolean, pts() As TKVectorPoint
    
    If m_bClosed Then Exit Function
    
    'Only allow extension of open vectors from the back or front.
    ub = UBound(m_pts)
    
    If sel.containsPoint(m_pts(0).x, m_pts(0).y) Then
        'Reverse the array to append from the end.
        ReDim pts(ub)
        For j = 0 To ub
            pts(j) = m_pts(ub - j)
        Next j
        m_pts = pts
        extendSelection = True
    End If
    
    If sel.containsPoint(m_pts(ub).x, m_pts(ub).y) Then
        extendSelection = True
    End If
    
    If extendSelection Then
        'Return the start-point of the new vector.
        x = m_pts(ub).x
        y = m_pts(ub).y
    End If
        
End Function

'=========================================================================
' Get the bounding box
'=========================================================================
Public Sub getBounds(ByRef x1 As Long, ByRef y1 As Long, ByRef x2 As Long, ByRef y2 As Long) ':on error resume next
    Dim i As Long
    For i = 0 To UBound(m_pts)
        If m_pts(i).x > x2 Or i = 0 Then x2 = m_pts(i).x
        If m_pts(i).y > y2 Or i = 0 Then y2 = m_pts(i).y
        If m_pts(i).x < x1 Or i = 0 Then x1 = m_pts(i).x
        If m_pts(i).y < y1 Or i = 0 Then y1 = m_pts(i).y
    Next i
End Sub

'=========================================================================
' Get the number of points in the vector
'=========================================================================
Public Function getPoints() As Long: On Error Resume Next
    getPoints = UBound(m_pts)
End Function

'=========================================================================
' Get a point by index
'=========================================================================
Public Sub getPoint(ByVal p As Long, ByRef x As Long, ByRef y As Long) ':on error resume next
    If p <= UBound(m_pts) Then
        x = m_pts(p).x
        y = m_pts(p).y
    End If
End Sub

'=========================================================================
' Move points a selection
'=========================================================================
Public Sub moveSelectionBy(ByVal dx As Long, ByVal dy As Long) ':on error resume next
    Dim i As Long
    If m_tiletype = TT_NULL Then Exit Sub
    
    For i = 0 To UBound(m_pts)
        If m_pts(i).bSel Then
            ' Don't do a CBoardSelection.containsPoint() test because this may pick up new points on the move.
            m_pts(i).x = m_pts(i).x + dx
            m_pts(i).y = m_pts(i).y + dy
        End If
    Next i
End Sub

'=========================================================================
' Move points a selection
'=========================================================================
Public Sub moveSelectionTo(ByVal x As Long, ByVal y As Long) ':on error resume next
    Dim i As Long
    If m_tiletype = TT_NULL Then Exit Sub
    For i = UBound(m_pts) To 0 Step -1
        If m_pts(i).bSel Then
            ' Don't do a CBoardSelection.containsPoint() test because this may pick up new points on the move.
            m_pts(i).x = x - (m_pts(0).x - m_pts(i).x)
            m_pts(i).y = y - (m_pts(0).y - m_pts(i).y)
        End If
    Next i
End Sub

'=========================================================================
' Get the nearest point to a given point
'=========================================================================
Public Sub nearestPoint(ByVal x As Long, ByVal y As Long, ByRef px As Long, ByRef py As Long, ByRef distance As Long) ': on error resume next
    Dim i As Long, j As Long, best As Long, d As Long
    If m_tiletype = TT_NULL Then Exit Sub
    distance = -1
    For i = 0 To UBound(m_pts)
        d = Sqr((x - m_pts(i).x) ^ 2 + (y - m_pts(i).y) ^ 2)
        If d < distance Or distance = -1 Then
            j = i: distance = d
        End If
    Next i
    px = m_pts(j).x
    py = m_pts(j).y
End Sub

'=========================================================================
' Assign bools to points in a selection
'=========================================================================
Public Sub setSelection(ByRef sel As CBoardSelection) ': on error resume next
    Dim i As Long
    If m_tiletype = TT_NULL Then Exit Sub
    For i = 0 To UBound(m_pts)
        m_pts(i).bSel = sel.containsPoint(m_pts(i).x, m_pts(i).y)
    Next i
End Sub
'=========================================================================
' Set a point by index
'=========================================================================
Public Sub setPoint(ByVal p As Long, ByVal x As Long, ByVal y As Long, ByVal bSel As Boolean) ':on error resume next
    If p > UBound(m_pts) Then ReDim Preserve m_pts(p)
    m_pts(p).x = x
    m_pts(p).y = y
    m_pts(p).bSel = bSel
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
        
        If sel.containsPoint(m_pts(i).x, m_pts(i).y) And _
            sel.containsPoint(m_pts(j).x, m_pts(j).y) And _
            ((i > j And m_bClosed) Or i < j) Then
            
            'Add an extra point in between.
            pts(UBound(pts)).x = Round((m_pts(i).x + m_pts(j).x) / 2)
            pts(UBound(pts)).y = Round((m_pts(i).y + m_pts(j).y) / 2)
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

Public Sub lvPopulate(ByRef lv As ListView) ':on error resume next
    Dim i As Long, j As Long
    lv.ListItems.clear
    If Not lv.SelectedItem Is Nothing Then j = lv.SelectedItem.index
    For i = 0 To UBound(m_pts)
        Call lv.ListItems.Add(i + 1, , str(i))
        lv.ListItems(i + 1).SubItems(1) = str(m_pts(i).x)
        lv.ListItems(i + 1).SubItems(2) = str(m_pts(i).y)
    Next i
    If j <> 0 Then Set lv.SelectedItem = lv.ListItems(j)
    lv.SelectedItem.EnsureVisible
End Sub

Public Sub lvApply(ByRef lv As ListView) ':on error resume next
    Dim i As Long
    ReDim m_pts(lv.ListItems.count - 1)
    For i = 0 To lv.ListItems.count - 1
        m_pts(i).x = Abs(val(lv.ListItems(i + 1).SubItems(1)))
        m_pts(i).y = Abs(val(lv.ListItems(i + 1).SubItems(2)))
    Next i
End Sub

'=========================================================================
' Copy "constructor"
'=========================================================================
Public Sub copy(ByRef rhs As CVector) ':on error resume next
    Dim i As Long
    rhs.tiletype = m_tiletype
    rhs.layer = m_layer
    rhs.attributes = m_attributes
    rhs.bClosed = m_bClosed
    For i = 0 To UBound(m_pts)
        Call rhs.setPoint(i, m_pts(i).x, m_pts(i).y, False)
    Next i
End Sub
