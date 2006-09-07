VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardLight"
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

Private Declare Function VarPtrArray Lib "msvbvm60.dll" Alias "VarPtr" (Var() As Any) As Long

Private m_nodes As CVector                  'Nodes defining radius/range of shading.
Private m_colors() As TKTileShade           'Color attached to each node.
Private m_type As eBoardLight
Private m_layer As Long

'=========================================================================
' Constructor
'=========================================================================
Private Sub Class_Initialize()
    Set m_nodes = New CVector
    m_type = BL_ELLIPSE
    m_layer = 1
    Call setType(0, 0)
    Call setColor(1, 128, 128, 128)
End Sub

'=========================================================================
' Copy "constructor"
'=========================================================================
Public Sub copy(ByRef rhs As CBoardLight) ':on error resume next
    Dim i As Long
    rhs.eType = m_type
    rhs.layer = m_layer
    rhs.nodes = New CVector
    Call nodes.copy(rhs.nodes)
    For i = 0 To UBound(m_colors)
        Call rhs.setColor(i, m_colors(i).r, m_colors(i).g, m_colors(i).b)
    Next i
End Sub

Public Property Get nodes() As CVector: On Error Resume Next
    Set nodes = m_nodes
End Property
Public Property Let nodes(p As CVector): On Error Resume Next
    Set m_nodes = p
End Property
Public Property Get layer() As Long: On Error Resume Next
    layer = m_layer
End Property
Public Property Let layer(ByVal l As Long): On Error Resume Next
    m_layer = l
End Property
Public Property Get eType() As eBoardLight: On Error Resume Next
    eType = m_type
End Property
Public Property Let eType(ByVal bl As eBoardLight): On Error Resume Next
    Dim x As Long, y As Long
    
    'Resize the light, except when changing between unclipped and clipped gradients.
    If m_type = bl Then Exit Property
    If m_type = BL_GRADIENT And bl = BL_GRADIENT_CLIPPED Or m_type = BL_GRADIENT_CLIPPED And bl = BL_GRADIENT Then
        m_type = bl
    Else
        m_type = bl
        Call nodes.getPoint(1, x, y)
        Call setType(x, y)
    End If
    
End Property

'=========================================================================
' Get a pointer to the color array (for dll use) - returns a SAFEARRAY**
'=========================================================================
Public Property Get ptrColors() As Long: On Error Resume Next
    ptrColors = VarPtrArray(m_colors())
End Property
Public Function getColors() As Long: On Error Resume Next
    getColors = UBound(m_colors)
End Function
Public Sub getColor(ByVal Index As Long, ByRef r As Integer, ByRef g As Integer, ByRef b As Integer): On Error Resume Next
    If Index <= UBound(m_colors) Then
        r = m_colors(Index).r
        g = m_colors(Index).g
        b = m_colors(Index).b
    End If
End Sub
Public Sub setColor(ByVal Index As Long, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer): On Error Resume Next
    If Index > UBound(m_colors) Then ReDim Preserve m_colors(Index)
    m_colors(Index).r = r
    m_colors(Index).g = g
    m_colors(Index).b = b
End Sub
Public Sub setType(ByVal x As Long, ByVal y As Long): On Error Resume Next
    Select Case m_type
        Case BL_ELLIPSE
            ReDim Preserve m_colors(1)             '3 points, 2 colours.
            nodes.deletePoints
            nodes.addPoint x, IIf(y < 160, 0, y - 160)
            nodes.addPoint x, y
            nodes.addPoint IIf(x < 160, 0, x - 160), y
        Case BL_GRADIENT, BL_GRADIENT_CLIPPED
            ReDim Preserve m_colors(1)             '2 points, 2 colours.
            nodes.deletePoints
            nodes.addPoint IIf(x < 160, 0, x - 160), IIf(y < 160, 0, y - 160)
            nodes.addPoint x, y
    End Select
End Sub
