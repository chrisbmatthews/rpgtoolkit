VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.UserControl ctlBrdVector 
   ClientHeight    =   4965
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3120
   ScaleHeight     =   4965
   ScaleWidth      =   3120
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   4215
      Left            =   0
      TabIndex        =   2
      Top             =   600
      Width           =   3015
      Begin MSComctlLib.ListView lvPoints 
         Height          =   1095
         Left            =   360
         TabIndex        =   16
         Top             =   2880
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   1931
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   -1  'True
         HideSelection   =   -1  'True
         HideColumnHeaders=   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         Appearance      =   1
         NumItems        =   3
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Text            =   "index"
            Object.Width           =   564
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Text            =   "x-coord"
            Object.Width           =   1058
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Text            =   "y-coord"
            Object.Width           =   1058
         EndProperty
      End
      Begin VB.PictureBox picOpt 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   735
         Left            =   120
         ScaleHeight     =   735
         ScaleWidth      =   2655
         TabIndex        =   9
         Top             =   240
         Width           =   2655
         Begin VB.OptionButton optType 
            Caption         =   "Solid"
            Height          =   375
            Index           =   1
            Left            =   0
            TabIndex        =   13
            Top             =   0
            Value           =   -1  'True
            Width           =   855
         End
         Begin VB.OptionButton optType 
            Caption         =   "Under"
            Height          =   375
            Index           =   2
            Left            =   0
            TabIndex        =   12
            Top             =   360
            Width           =   855
         End
         Begin VB.OptionButton optType 
            Caption         =   "Stairs"
            Height          =   375
            Index           =   8
            Left            =   1320
            TabIndex        =   11
            Top             =   0
            Width           =   855
         End
         Begin VB.OptionButton optType 
            Caption         =   "Unidirectional"
            Height          =   375
            Index           =   4
            Left            =   1320
            TabIndex        =   10
            Top             =   360
            Visible         =   0   'False
            Width           =   1335
         End
      End
      Begin VB.CheckBox chkUnder 
         Caption         =   "Include background"
         Height          =   255
         Index           =   0
         Left            =   360
         TabIndex        =   8
         Top             =   1200
         Width           =   2295
      End
      Begin VB.CheckBox chkUnder 
         Caption         =   "Include all layers below"
         Height          =   255
         Index           =   1
         Left            =   360
         TabIndex        =   7
         Top             =   1440
         Width           =   2295
      End
      Begin VB.CheckBox chkUnder 
         Caption         =   "Trigger on bounding box"
         Height          =   255
         Index           =   2
         Left            =   360
         TabIndex        =   6
         Top             =   1680
         Width           =   2295
      End
      Begin VB.TextBox txtStairs 
         Height          =   285
         Left            =   360
         TabIndex        =   5
         Text            =   "1"
         Top             =   2400
         Width           =   495
      End
      Begin VB.CheckBox chkClosed 
         Caption         =   "Closed vector"
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   960
         Width           =   1815
      End
      Begin VB.TextBox txtLayer 
         Height          =   285
         Left            =   360
         TabIndex        =   3
         Text            =   "1"
         Top             =   2085
         Width           =   495
      End
      Begin VB.Label lblStairs 
         Caption         =   "Stairs to layer"
         Height          =   255
         Left            =   960
         TabIndex        =   15
         Top             =   2445
         Width           =   975
      End
      Begin VB.Label lblLayer 
         Caption         =   "Layer"
         Height          =   255
         Left            =   960
         TabIndex        =   14
         Top             =   2145
         Width           =   975
      End
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton cmdDuplicate 
      Caption         =   "Duplicate"
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "ctlBrdVector"
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

'Currently selected vector on board c.f. combo (board switching problems!)
Public vectorIndex As Long
Private m_currentVector As CVector

Private Sub apply(): On Error Resume Next
    If Not m_currentVector Is Nothing Then Call m_currentVector.tbApply(Me)
    Call activeBoard.drawAll
    Call populate(vectorIndex, m_currentVector)
End Sub
Private Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    Call lvPoints.ListItems.clear
End Sub
Private Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
End Sub

Public Sub populate(ByVal index As Long, ByRef vector As CVector)  ':on error resume next
    Dim i As Long, j As Long
    
    tkMainForm.bTools_Tabs.Height = tkMainForm.pTools.Height - tkMainForm.bTools_Tabs.Top
    UserControl.Height = tkMainForm.bTools_Tabs.Height - tkMainForm.bTools_ctlVector.Top - 256
    fraProperties.Height = UserControl.Height - fraProperties.Top
    lvPoints.Height = fraProperties.Height - lvPoints.Top - 256
    
    vectorIndex = index
    Set m_currentVector = vector
    
    If vector Is Nothing Then
        Call disableAll
        Exit Sub
    End If
    
    'Option buttons have been assigned TT_ values as indices.
    Call enableAll
    If vector.tiletype <> TT_NULL Then optType(vector.tiletype).value = True
    chkClosed.value = Abs(vector.bClosed)
    txtLayer.Text = str(vector.layer)
    txtStairs.Enabled = (vector.tiletype = TT_STAIRS)
    lblStairs.Enabled = (vector.tiletype = TT_STAIRS)
    chkClosed.Enabled = (vector.tiletype <> TT_UNDER)
    
    For i = 0 To chkUnder.count - 1
        chkUnder(i).Enabled = (vector.tiletype = TT_UNDER)
        chkUnder(i).value = 0
    Next i
    
    If vector.tiletype = TT_UNDER Then
        chkUnder(0).value = Abs((vector.attributes And TA_BRD_BACKGROUND) <> 0)
        chkUnder(1).value = Abs((vector.attributes And TA_ALL_LAYERS_BELOW) <> 0)
        chkUnder(2).value = Abs((vector.attributes And TA_RECT_INTERSECT) <> 0)
        chkClosed.value = 1
    ElseIf vector.tiletype = TT_STAIRS Then
        txtStairs.Text = str(vector.attributes)
    End If
    
    If vector.tiletype = TT_NULL Then Exit Sub
        
    Call vector.lvPopulate(lvPoints)

End Sub

Public Property Get getChkUnder(ByVal index As Integer) As CheckBox: On Error Resume Next
    Set getChkUnder = chkUnder(index)
End Property
Public Property Get getChkClosed() As CheckBox: On Error Resume Next
    Set getChkClosed = chkClosed
End Property
Public Property Get getLvPoints() As ListView: On Error Resume Next
    Set getLvPoints = lvPoints
End Property
Public Property Get getOptType(ByVal index As Integer) As OptionButton: On Error Resume Next
    Set getOptType = optType(index)
End Property
Public Property Get getTxtLayer() As TextBox: On Error Resume Next
    Set getTxtLayer = txtLayer
End Property
Public Property Get getTxtStairs() As TextBox: On Error Resume Next
    Set getTxtStairs = txtStairs
End Property

Private Sub chkUnder_MouseUp(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub chkClosed_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub optType_MouseUp(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub txtLayer_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtStairs_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub lvPoints_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call modBoard.vectorLvColumn(lvPoints, x)
End Sub
Private Sub lvPoints_KeyDown(keyCode As Integer, Shift As Integer): On Error Resume Next
    If modBoard.vectorLvKeyDown(lvPoints, keyCode) Then Call apply
End Sub
Private Sub lvPoints_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.vectorDeleteCurrentVector(BS_VECTOR)
    Call activeBoard.drawAll
End Sub
Private Sub cmdDuplicate_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub

Private Sub UserControl_Initialize(): On Error Resume Next
    vectorIndex = -1      'c.f. combo
End Sub
