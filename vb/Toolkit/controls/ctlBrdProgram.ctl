VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.UserControl ctlBrdProgram 
   ClientHeight    =   5640
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3105
   DefaultCancel   =   -1  'True
   ScaleHeight     =   5640
   ScaleWidth      =   3105
   Begin VB.CheckBox chkDraw 
      Caption         =   "Drarw programs"
      Height          =   375
      Left            =   120
      TabIndex        =   18
      Top             =   120
      Width           =   1455
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Ok"
      Default         =   -1  'True
      Height          =   375
      Left            =   1800
      TabIndex        =   17
      ToolTipText     =   "Confirmation button"
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   120
      Width           =   855
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   4455
      Left            =   0
      TabIndex        =   1
      Top             =   960
      Width           =   3015
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   14
         Top             =   480
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Left            =   0
            TabIndex        =   15
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Frame fraActivationType 
         BorderStyle     =   0  'None
         Caption         =   "Activation mechanism            "
         Height          =   1695
         Left            =   120
         TabIndex        =   7
         Top             =   1320
         Width           =   2775
         Begin VB.CheckBox chkRunOnce 
            Caption         =   "Run once"
            Height          =   255
            Left            =   120
            TabIndex        =   19
            ToolTipText     =   "Allow this program to be run only once during the game"
            Top             =   1320
            Width           =   2415
         End
         Begin VB.TextBox txtRepeatTrigger 
            Height          =   285
            Left            =   1440
            TabIndex        =   12
            Text            =   "32"
            Top             =   720
            Width           =   495
         End
         Begin VB.CheckBox chkActivationStopsMove 
            Caption         =   "Activation stops movement"
            Height          =   255
            Left            =   120
            TabIndex        =   13
            Top             =   960
            Width           =   2415
         End
         Begin VB.CheckBox chkRepeatTrigger 
            Caption         =   "Trigger every                 pixels"
            Height          =   255
            Left            =   120
            TabIndex        =   11
            Top             =   720
            Width           =   2415
         End
         Begin VB.PictureBox picActivationType 
            Appearance      =   0  'Flat
            BorderStyle     =   0  'None
            ForeColor       =   &H80000008&
            Height          =   495
            Left            =   120
            ScaleHeight     =   495
            ScaleWidth      =   2415
            TabIndex        =   8
            Top             =   120
            Width           =   2415
            Begin VB.OptionButton optActivationType 
               Caption         =   "Activation by key press"
               Height          =   255
               Index           =   1
               Left            =   0
               TabIndex        =   10
               Top             =   240
               Width           =   2055
            End
            Begin VB.OptionButton optActivationType 
               Caption         =   "Activation by step-on"
               Height          =   255
               Index           =   0
               Left            =   0
               TabIndex        =   9
               Top             =   0
               Width           =   2055
            End
         End
      End
      Begin VB.TextBox txtLayer 
         Height          =   285
         Left            =   120
         TabIndex        =   5
         Text            =   "1"
         Top             =   960
         Width           =   615
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   2055
      End
      Begin MSComctlLib.ListView lvPoints 
         Height          =   1095
         Left            =   480
         TabIndex        =   16
         Top             =   3120
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
      Begin VB.Label lblLayer 
         Caption         =   "Layer"
         Height          =   255
         Left            =   840
         TabIndex        =   6
         Top             =   1020
         Width           =   615
      End
      Begin VB.Label lblFilename 
         Caption         =   "Program filename / inline RPGCode"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.ComboBox cmbPrg 
      Height          =   315
      Left            =   0
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   600
      Width           =   3015
   End
End
Attribute VB_Name = "ctlBrdProgram"
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
Private Sub apply() ': On Error Resume Next
    Dim prg As CBoardProgram
    'Set undo before getting current program because undo creates new objects.
    Call activeBoard.setUndo
    Set prg = activeBoard.toolbarGetCurrent(BS_PROGRAM)
    If Not prg Is Nothing Then
        With prg
            .filename = txtFilename.Text
            .layer = Abs(val(txtLayer.Text))
            .activate = IIf(chkRunOnce.value, PRG_CONDITIONAL, PRG_ACTIVE)
            
            'Assign a Guid as a unique variable name.
            .initialVar = vbNullString
            If .activate = PRG_CONDITIONAL Then .initialVar = modBoard.createGuid()
            .initialValue = vbNullString            'Uninitialised variables set to "".
            .finalVar = .initialVar
            .finalValue = "1"
            
            .activationType = Abs(optActivationType(PRG_KEYPRESS).value)
            If chkRepeatTrigger.value Then .activationType = .activationType Or PRG_REPEAT
            If chkActivationStopsMove.value Then .activationType = .activationType Or PRG_STOPS_MOVEMENT
            .distanceRepeat = val(txtRepeatTrigger.Text)
            Call .vBase.lvApply(lvPoints)
        End With
        Call populate(cmbPrg.ListIndex, prg)
    End If
End Sub
Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    cmbPrg.Enabled = True
    Call activeBoard.toolbarSetCurrent(BTAB_PROGRAM, -1)
    lvPoints.ListItems.clear
End Sub
Private Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
    chkDraw.value = Abs(activeBoard.toolbarDrawObject(BS_PROGRAM))
End Sub

Public Sub populate(ByVal Index As Long, ByRef prg As CBoardProgram) ': On Error Resume Next
    Dim i As Long
    tkMainForm.bTools_Tabs.Height = tkMainForm.pTools.Height - tkMainForm.bTools_Tabs.Top
    UserControl.Height = tkMainForm.bTools_Tabs.Height - tkMainForm.bTools_ctlPrg.Top - 128
    fraProperties.Height = UserControl.Height - fraProperties.Top - 32
    lvPoints.Height = fraProperties.Height - lvPoints.Top - 64
    
    If prg Is Nothing Then
        Call disableAll
        Exit Sub
    End If
    
    Call activeBoard.toolbarSetCurrent(BTAB_PROGRAM, Index)
    Call enableAll
    
    If cmbPrg.ListIndex <> Index Then cmbPrg.ListIndex = Index
    cmbPrg.list(Index) = str(Index) & ": " & IIf(LenB(prg.filename), prg.filename, "<program>")
    txtFilename.Text = prg.filename
    txtLayer.Text = str(prg.layer)
    chkRunOnce.value = prg.activate
    optActivationType(prg.activationType And PRG_KEYPRESS).value = True
    If optActivationType(PRG_STEP).value Then
        chkRepeatTrigger.value = IIf(prg.activationType And PRG_REPEAT, 1, 0)
        txtRepeatTrigger.Enabled = (chkRepeatTrigger.value <> 0)
        chkActivationStopsMove.value = IIf(prg.activationType And PRG_STOPS_MOVEMENT, 1, 0)
    Else
        chkRepeatTrigger.Enabled = False
        txtRepeatTrigger.Enabled = False
        chkActivationStopsMove.Enabled = False
    End If
    
    Call prg.vBase.lvPopulate(lvPoints)
    
End Sub

Public Property Get ActiveControl() As Control ': On Error Resume Next
    Set ActiveControl = UserControl.ActiveControl
End Property
Public Property Get getCombo() As ComboBox: On Error Resume Next
    Set getCombo = cmbPrg
End Property

Private Sub chkActivationStopsMove_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub chkDraw_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    activeBoard.toolbarDrawObject(BS_PROGRAM) = chkDraw.value
End Sub
Private Sub chkRepeatTrigger_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub chkRunOnce_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub cmbPrg_Click(): On Error Resume Next
    If cmbPrg.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbPrg.ListIndex, BS_PROGRAM)
End Sub
Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Board program", ".prg", fileTypes, file) Then
        txtFilename.Text = file
        Call cmdDefault_Click
    End If
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.vectorDeleteCurrent(BS_PROGRAM)
    Call activeBoard.drawAll
End Sub
Private Sub cmdDefault_Click(): On Error Resume Next
    'Default button on form: hitting the Enter key calls this function.
    Call apply
    Call activeBoard.drawAll
End Sub

Private Sub lvPoints_LostFocus(): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub lvPoints_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call modBoard.vectorLvColumn(lvPoints, x)
End Sub
Private Sub lvPoints_KeyDown(keyCode As Integer, Shift As Integer): On Error Resume Next
    If modBoard.vectorLvKeyDown(lvPoints, keyCode) Then Call cmdDefault_Click
End Sub
Private Sub lvPoints_Validate(Cancel As Boolean): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub optActivationType_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub txtFilename_LostFocus(): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtFilename_Validate(Cancel As Boolean): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtLayer_LostFocus(): On Error Resume Next
    Call apply
End Sub
Private Sub txtLayer_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtRepeatTrigger_LostFocus(): On Error Resume Next
    Call apply
End Sub
Private Sub txtRepeatTrigger_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
