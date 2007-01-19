VERSION 5.00
Begin VB.UserControl ctlBrdLighting 
   ClientHeight    =   6195
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3555
   DefaultCancel   =   -1  'True
   ScaleHeight     =   6195
   ScaleWidth      =   3555
   Begin VB.Frame fraProperties 
      Caption         =   "Lighting"
      Height          =   2655
      Index           =   1
      Left            =   0
      TabIndex        =   22
      Top             =   1440
      Width           =   3375
      Begin VB.PictureBox picLights 
         BorderStyle     =   0  'None
         Height          =   2295
         Index           =   0
         Left            =   240
         ScaleHeight     =   2295
         ScaleWidth      =   3015
         TabIndex        =   23
         Top             =   240
         Width           =   3015
         Begin VB.ComboBox cmbLights 
            Height          =   315
            Left            =   240
            Style           =   2  'Dropdown List
            TabIndex        =   4
            ToolTipText     =   "Light list"
            Top             =   0
            Width           =   2415
         End
         Begin VB.ComboBox cmbLightType 
            Height          =   315
            Left            =   480
            Style           =   2  'Dropdown List
            TabIndex        =   5
            ToolTipText     =   "Lighting effect"
            Top             =   360
            Width           =   1935
         End
         Begin VB.PictureBox picLightColor 
            Height          =   375
            Index           =   0
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   315
            TabIndex        =   25
            ToolTipText     =   "Color equivalent"
            Top             =   840
            Width           =   375
         End
         Begin VB.PictureBox picLightColor 
            Height          =   375
            Index           =   1
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   315
            TabIndex        =   24
            ToolTipText     =   "Color equivalent"
            Top             =   1320
            Width           =   375
         End
         Begin VB.CommandButton cmdLightDelete 
            Caption         =   "Delete"
            Height          =   375
            Left            =   1440
            TabIndex        =   9
            ToolTipText     =   "Delete light"
            Top             =   1920
            Width           =   975
         End
         Begin VB.CommandButton cmdLightConvert 
            Caption         =   "Convert"
            Height          =   375
            Left            =   480
            TabIndex        =   8
            ToolTipText     =   "Render dynamic lighting to layer permanently and delete dynamic light"
            Top             =   1920
            Width           =   975
         End
         Begin VB.CommandButton cmdLightColor 
            Caption         =   "..."
            Height          =   375
            Index           =   0
            Left            =   480
            TabIndex        =   6
            ToolTipText     =   "Use current shade"
            Top             =   840
            Width           =   375
         End
         Begin VB.CommandButton cmdLightColor 
            Caption         =   "..."
            Height          =   375
            Index           =   1
            Left            =   480
            TabIndex        =   7
            ToolTipText     =   "Use current shade"
            Top             =   1320
            Width           =   375
         End
         Begin VB.Label lblLightRgb 
            Caption         =   "[+255, +255, +255]"
            Height          =   255
            Index           =   1
            Left            =   960
            TabIndex        =   29
            ToolTipText     =   "RGB Value of the second shade"
            Top             =   1560
            Width           =   1815
         End
         Begin VB.Label lblLightRgb 
            Caption         =   "[+255, +255, +255]"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   28
            ToolTipText     =   "RGB value of the first shade"
            Top             =   1080
            Width           =   1815
         End
         Begin VB.Label lblLightColor 
            Caption         =   "Object color one:"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   27
            Top             =   840
            Width           =   1935
         End
         Begin VB.Label lblLightColor 
            Caption         =   "Object color two:"
            Height          =   255
            Index           =   1
            Left            =   960
            TabIndex        =   26
            Top             =   1320
            Width           =   1935
         End
      End
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Ok"
      Default         =   -1  'True
      Height          =   375
      Left            =   3000
      TabIndex        =   0
      ToolTipText     =   "Confirmation button"
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CheckBox chkDrawLighting 
      Caption         =   "Draw lighting"
      Height          =   375
      Left            =   1680
      TabIndex        =   2
      ToolTipText     =   "Show/hide lights on this board"
      Top             =   120
      Width           =   1815
   End
   Begin VB.Frame fraShade 
      Caption         =   "Current shade"
      Height          =   1935
      Left            =   0
      TabIndex        =   17
      Top             =   4200
      Width           =   3375
      Begin VB.PictureBox pic 
         BorderStyle     =   0  'None
         Height          =   1575
         Left            =   120
         ScaleHeight     =   1575
         ScaleWidth      =   3135
         TabIndex        =   18
         Top             =   240
         Width           =   3135
         Begin VB.CommandButton cmdShadeZero 
            Caption         =   "Zero RGB"
            Height          =   375
            Left            =   240
            TabIndex        =   14
            ToolTipText     =   "Set R = 0, G = 0, B = 0"
            Top             =   1080
            Width           =   975
         End
         Begin VB.PictureBox picShade 
            Height          =   375
            Left            =   240
            ScaleHeight     =   315
            ScaleWidth      =   315
            TabIndex        =   19
            ToolTipText     =   "Current shade color equivalent"
            Top             =   120
            Width           =   375
         End
         Begin VB.TextBox txtShade 
            Alignment       =   2  'Center
            Height          =   285
            Index           =   0
            Left            =   960
            TabIndex        =   10
            Text            =   "0"
            Top             =   240
            Width           =   615
         End
         Begin VB.TextBox txtShade 
            Alignment       =   2  'Center
            Height          =   285
            Index           =   1
            Left            =   1560
            TabIndex        =   11
            Text            =   "0"
            Top             =   240
            Width           =   615
         End
         Begin VB.TextBox txtShade 
            Alignment       =   2  'Center
            Height          =   285
            Index           =   2
            Left            =   2160
            TabIndex        =   12
            Text            =   "0"
            Top             =   240
            Width           =   615
         End
         Begin VB.HScrollBar hsbShade 
            Height          =   255
            LargeChange     =   15
            Left            =   240
            Max             =   255
            Min             =   -255
            SmallChange     =   5
            TabIndex        =   13
            Top             =   600
            Width           =   2535
         End
         Begin VB.Label lbl 
            Caption         =   "Values are valid in the range -255 to +255"
            Height          =   615
            Index           =   2
            Left            =   1440
            TabIndex        =   21
            Top             =   1080
            Width           =   1695
         End
         Begin VB.Label lbl 
            Caption         =   "R           G          B"
            Height          =   255
            Index           =   1
            Left            =   1200
            TabIndex        =   20
            Top             =   0
            Width           =   1335
         End
      End
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Lighting and shading properties"
      Height          =   735
      Index           =   0
      Left            =   0
      TabIndex        =   15
      Top             =   600
      Width           =   3375
      Begin VB.TextBox txtLayer 
         Height          =   285
         Left            =   1800
         TabIndex        =   3
         Text            =   "1"
         Top             =   320
         Width           =   615
      End
      Begin VB.Label lblLayer 
         Caption         =   "Cast onto tiles on layer                 and below"
         Height          =   255
         Left            =   120
         TabIndex        =   16
         ToolTipText     =   "The lighting and shading layer is situated above the given layer and casts onto the given layer and all layers below"
         Top             =   360
         Width           =   3135
      End
   End
   Begin VB.CheckBox chkDrawShading 
      Caption         =   "Draw tile shading"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      ToolTipText     =   "Show/hide tile shading for this board"
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "ctlBrdLighting"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private Const TS_MAX = 255
Private Const TS_MIN = -255

Private Sub apply(): On Error Resume Next
    Dim light As CBoardLight
    
    'Set undo before getting current light because undo creates new objects.
    Call activeBoard.setUndo
    
    Set light = activeBoard.toolbarGetCurrent(BS_LIGHTING)
    If Not light Is Nothing Then
    
        '3.0.7: place all lights on the single tile shade layer.
        light.layer = Abs(val(txtLayer.Text))
        light.eType = cmbLightType.ListIndex
        Call populate(cmbLights.ListIndex, light)
        
        'Force a rerender of all layers to update lighting.
        Call activeBoard.reRenderAllLayers(False)
        Call activeBoard.drawAll
    End If
End Sub

Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        If i.Container Is picLights Then
            i.Enabled = False
            i.Text = "0"
        End If
    Next i
    Call activeBoard.toolbarSetCurrent(BTAB_LIGHTING, -1)
    cmbLights.Enabled = True
    chkDrawLighting.value = Abs(activeBoard.toolbarDrawObject(BS_LIGHTING))
    chkDrawShading.value = Abs(activeBoard.toolbarDrawObject(BS_SHADING))
End Sub
Public Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
    chkDrawLighting.value = Abs(activeBoard.toolbarDrawObject(BS_LIGHTING))
    chkDrawShading.value = Abs(activeBoard.toolbarDrawObject(BS_SHADING))
End Sub

'========================================================================
' Populate BTAB_LIGHTING with selected light (no shading)
'========================================================================
Public Sub populate(ByVal Index As Long, ByRef light As CBoardLight) ':on error resume next
    
    'Ctl contains lighting and shading elements.
    
    tkMainForm.bTools_Tabs.Height = tkMainForm.pTools.Height - tkMainForm.bTools_Tabs.Top
    UserControl.Height = tkMainForm.bTools_Tabs.Height - tkMainForm.bTools_ctlVector.Top - 256
    
    'Populate shading elements elsewhere.
    
    'Populate lighting elements.
    If light Is Nothing Then
        Call disableAll
        Exit Sub
    End If
    
    'Index of selected lighting object.
    'Use m_ed.currentObject to hold selected object rather than selected layer (see note in toolbarPopulateLighting).
    Call activeBoard.toolbarSetCurrent(BTAB_LIGHTING, Index)
    Call enableAll
    
    If cmbLights.ListIndex <> Index Then cmbLights.ListIndex = Index
    cmbLights.List(cmbLights.ListIndex) = CStr(Index) & ": " & lightName(light.eType)
    
    cmbLightType.ListIndex = light.eType
    
    Dim ts As TKTileShade, cap(1) As String, i As Integer
    
    Select Case light.eType
        Case BL_ELLIPSE
            lblLightColor(0).Caption = "Shade at ellipse edge: "
            lblLightColor(1).Caption = "Shade at ellipse centre: "
        Case BL_GRADIENT, BL_GRADIENT_CLIPPED
            lblLightColor(0).Caption = "Gradient start shade: "
            lblLightColor(1).Caption = "Gradient end shade: "
    End Select
            
    For i = 0 To 1
        Call light.getColor(i, ts.r, ts.g, ts.b)
        picLightColor(i).backColor = shadeToRGB(ts.r, ts.g, ts.b)
        lblLightRgb(i).Caption = "[" & CStr(ts.r) & " " & CStr(ts.g) & " " & CStr(ts.b) & "]"
    Next i

End Sub

Public Property Get ActiveControl() As Control: On Error Resume Next
    Set ActiveControl = UserControl.ActiveControl
End Property
Public Property Get getLightCombo() As ComboBox: On Error Resume Next
    Set getLightCombo = cmbLights
End Property
Public Property Get getTxtLayer() As TextBox: On Error Resume Next
    Set getTxtLayer = txtLayer
End Property

Private Sub chkDrawLighting_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    activeBoard.toolbarDrawObject(BS_LIGHTING) = chkDrawLighting.value
    Call activeBoard.reRenderAllLayers(False)
    Call activeBoard.drawAll
End Sub
Private Sub chkDrawShading_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    activeBoard.toolbarDrawObject(BS_SHADING) = chkDrawShading.value
    Call activeBoard.reRenderAllLayers(False)
    Call activeBoard.drawAll
End Sub
Private Sub cmbLights_Click(): On Error Resume Next
    If cmbLights.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbLights.ListIndex, BS_LIGHTING)
End Sub
Private Sub cmblightType_Click(): On Error Resume Next
    If cmbLightType.ListIndex <> activeBoard.toolbarGetCurrent(BS_LIGHTING).eType Then Call apply
End Sub
Private Sub cmdDefault_Click(): On Error Resume Next
    'Default button on form: hitting the Enter key calls this function.
    'Call apply
    'Call activeBoard.drawAll
End Sub

Private Sub cmdLightConvert_Click(): On Error Resume Next
    Call activeBoard.lightingConvert
End Sub

Private Sub cmdLightColor_Click(Index As Integer): On Error Resume Next
    Dim r As Integer, g As Integer, b As Integer
    r = val(txtShade(0).Text)
    g = val(txtShade(1).Text)
    b = val(txtShade(2).Text)
    
    If Not activeBoard.toolbarGetCurrent(BS_LIGHTING) Is Nothing Then
        picLightColor(Index).backColor = shadeToRGB(r, g, b)
        Call activeBoard.toolbarGetCurrent(BS_LIGHTING).setColor(Index, r, g, b)
        Call apply
    End If
End Sub
Private Sub cmdLightDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.lightingDeleteCurrent
    Call activeBoard.reRenderAllLayers(False)
    Call activeBoard.drawAll
End Sub
Private Sub cmdShadeZero_Click(): On Error Resume Next
    hsbShade.value = 0
End Sub
Private Sub hsbShade_Change(): On Error Resume Next
    txtShade(0).Text = CStr(hsbShade.value)
    txtShade(1).Text = CStr(hsbShade.value)
    txtShade(2).Text = CStr(hsbShade.value)
    Call updateShade
End Sub
Private Sub txtLayer_LostFocus(): On Error Resume Next
    Call activeBoard.shadingApply
End Sub
Private Sub txtLayer_Validate(Cancel As Boolean): On Error Resume Next
    Call activeBoard.shadingApply
End Sub
Private Sub txtShade_LostFocus(Index As Integer): On Error Resume Next
    Dim i As Integer
    i = val(txtShade(Index).Text)
    txtShade(Index).Text = CStr(IIf(i < TS_MIN, TS_MIN, IIf(i > TS_MAX, TS_MAX, i)))
    Call updateShade
End Sub
Private Sub txtShade_Validate(Index As Integer, Cancel As Boolean): On Error Resume Next
    Call txtShade_LostFocus(Index)
End Sub

Public Sub currentShade(ByVal r As Integer, ByVal g As Integer, ByVal b As Integer): On Error Resume Next
    txtShade(0).Text = CStr(r)
    txtShade(1).Text = CStr(g)
    txtShade(2).Text = CStr(b)
    picShade.backColor = shadeToRGB(r, g, b)
End Sub
Private Sub updateShade(): On Error Resume Next
    Dim r As Integer, g As Integer, b As Integer
    r = val(txtShade(0).Text)
    g = val(txtShade(1).Text)
    b = val(txtShade(2).Text)
    picShade.backColor = shadeToRGB(r, g, b)
    Call activeBoard.currentShade(r, g, b)
End Sub
Public Function shadeToRGB(ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Long: On Error Resume Next
    shadeToRGB = RGB((r + TS_MAX) / 2, (g + TS_MAX) / 2, (b + TS_MAX) / 2)
End Function

Public Property Get lightName(ByVal eType As eBoardLight) As String: On Error Resume Next
    Select Case eType
        Case BL_ELLIPSE: lightName = "Elliptic spotlight"
        Case BL_GRADIENT: lightName = "Gradient"
        Case BL_GRADIENT_CLIPPED: lightName = "Clipped gradient"
    End Select
End Property

Private Sub UserControl_Initialize(): On Error Resume Next
    cmbLightType.clear
    cmbLightType.AddItem lightName(BL_ELLIPSE), BL_ELLIPSE
    cmbLightType.AddItem lightName(BL_GRADIENT), BL_GRADIENT
    cmbLightType.AddItem lightName(BL_GRADIENT_CLIPPED), BL_GRADIENT_CLIPPED
    cmbLightType.ListIndex = BL_ELLIPSE
End Sub
