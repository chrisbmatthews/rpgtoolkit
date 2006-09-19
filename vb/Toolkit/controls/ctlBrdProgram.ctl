VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.UserControl ctlBrdProgram 
   ClientHeight    =   6405
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3645
   DefaultCancel   =   -1  'True
   ScaleHeight     =   6405
   ScaleWidth      =   3645
   Begin VB.CheckBox chkDraw 
      Caption         =   "Draw programs"
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
      Left            =   2160
      TabIndex        =   17
      ToolTipText     =   "Confirmation button"
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   120
      Width           =   855
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   5295
      Left            =   0
      TabIndex        =   1
      Top             =   960
      Width           =   3375
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1215
         Left            =   240
         ScaleHeight     =   1215
         ScaleWidth      =   3015
         TabIndex        =   20
         Top             =   2760
         Width           =   3015
         Begin VB.TextBox txtVar 
            Height          =   285
            Index           =   0
            Left            =   0
            TabIndex        =   24
            ToolTipText     =   "Enter the name of an RPGCode variable"
            Top             =   240
            Width           =   1815
         End
         Begin VB.TextBox txtValue 
            Height          =   285
            Index           =   0
            Left            =   2160
            TabIndex        =   23
            ToolTipText     =   "Enter the value the variable must be to run the program. Note: Leave blank if the variable is uninitialised"
            Top             =   240
            Width           =   855
         End
         Begin VB.TextBox txtVar 
            Height          =   285
            Index           =   1
            Left            =   0
            TabIndex        =   22
            ToolTipText     =   "Enter the name of a variable to set when the program ends (may be the same as above)"
            Top             =   840
            Width           =   1815
         End
         Begin VB.TextBox txtValue 
            Height          =   285
            Index           =   1
            Left            =   2160
            TabIndex        =   21
            ToolTipText     =   "Enter the value to set the variable to"
            Top             =   840
            Width           =   855
         End
         Begin VB.Label lbl 
            Caption         =   "="
            Height          =   255
            Index           =   5
            Left            =   1920
            TabIndex        =   25
            Top             =   840
            Width           =   135
         End
         Begin VB.Label lblVar 
            Caption         =   "Run program if variable"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   28
            Top             =   0
            Width           =   3015
         End
         Begin VB.Label lbl 
            Caption         =   "="
            Height          =   255
            Index           =   3
            Left            =   1920
            TabIndex        =   27
            Top             =   240
            Width           =   135
         End
         Begin VB.Label lblVar 
            Caption         =   "After program finishes, set variable"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   26
            Top             =   600
            Width           =   3015
         End
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2760
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
            ToolTipText     =   "Browse for program"
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Frame fraActivationType 
         BorderStyle     =   0  'None
         Caption         =   "Activation mechanism            "
         Height          =   1575
         Left            =   120
         TabIndex        =   7
         Top             =   1200
         Width           =   2775
         Begin VB.CheckBox chkRunOnce 
            Caption         =   "Run once"
            Height          =   255
            Left            =   120
            TabIndex        =   19
            ToolTipText     =   "Allow this program to be run only once during the game"
            Top             =   1200
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
            ToolTipText     =   "Pending movements (e.g., the destination set in mouse movement) are cleared when the program runs"
            Top             =   960
            Width           =   2415
         End
         Begin VB.CheckBox chkRepeatTrigger 
            Caption         =   "Trigger every                 pixels"
            Height          =   255
            Left            =   120
            TabIndex        =   11
            ToolTipText     =   "Cause the program to run repeatedly when a user walks around in a program's vector"
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
               ToolTipText     =   "Users must press the Main File Activation Key whilst standing on the program to run the program"
               Top             =   240
               Width           =   2055
            End
            Begin VB.OptionButton optActivationType 
               Caption         =   "Activation by step-on"
               Height          =   255
               Index           =   0
               Left            =   0
               TabIndex        =   9
               ToolTipText     =   "Users must stand on or in a program's vector to run the program"
               Top             =   0
               Width           =   2055
            End
         End
      End
      Begin VB.TextBox txtLayer 
         Height          =   285
         Left            =   240
         TabIndex        =   5
         Text            =   "1"
         ToolTipText     =   "The layer the program is located on. Users must be on this layer to run the program"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   2535
      End
      Begin MSComctlLib.ListView lvPoints 
         Height          =   1095
         Left            =   720
         TabIndex        =   16
         ToolTipText     =   "Program vector's points. Click a number and press the Delete key to enter a new pixel coordinate"
         Top             =   4080
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
         Left            =   960
         TabIndex        =   6
         Top             =   900
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
      Width           =   3375
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

Private Const GUID_VAR As String = "_guid"

Private Sub apply() ': On Error Resume Next
    Dim prg As CBoardProgram
    'Set undo before getting current program because undo creates new objects.
    Call activeBoard.setUndo
    Set prg = activeBoard.toolbarGetCurrent(BS_PROGRAM)
    If Not prg Is Nothing Then
        With prg
            .filename = txtFilename.Text
            .layer = Abs(val(txtLayer.Text))
            
            'Assign a Guid as a unique variable name.
            If chkRunOnce.value Then
                .initialVar = modBoard.createGuid()
                .initialValue = vbNullString            'Uninitialised variables set to "".
                .finalVar = .initialVar
                .finalValue = GUID_VAR                  'Allow the board editor to recognise
                                                        'when Run Once is selected, rather
                                                        'than adding a PRG_RUNONCE.
            Else
                .initialVar = txtVar(0).Text
                .initialValue = txtValue(0).Text
                .finalVar = txtVar(1).Text
                .finalValue = txtValue(1).Text
            End If
            .activate = IIf(LenB(.initialVar), PRG_CONDITIONAL, PRG_ACTIVE)
            
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
    UserControl.width = fraProperties.width
    lvPoints.Height = fraProperties.Height - lvPoints.Top - 64
    
    If prg Is Nothing Then
        Call disableAll
        Exit Sub
    End If
    
    Call activeBoard.toolbarSetCurrent(BTAB_PROGRAM, Index)
    Call enableAll
    
    If cmbPrg.ListIndex <> Index Then cmbPrg.ListIndex = Index
    cmbPrg.list(Index) = CStr(Index) & ": " & IIf(LenB(prg.filename), prg.filename, "<program>")
    txtFilename.Text = prg.filename
    txtLayer.Text = str(prg.layer)
    
    chkRunOnce.value = IIf(prg.finalValue = GUID_VAR, 1, 0)
    For i = 0 To 1
        txtVar(i).Text = IIf(chkRunOnce.value, vbNullString, IIf(i = 0, prg.initialVar, prg.finalVar))
        txtVar(i).Enabled = (chkRunOnce.value = 0)
        txtValue(i).Text = IIf(chkRunOnce.value, vbNullString, IIf(i = 0, prg.initialValue, prg.finalValue))
        txtValue(i).Enabled = (chkRunOnce.value = 0)
        lblVar(i).Enabled = (chkRunOnce.value = 0)
    Next i
    
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
    If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Board program", "prg", fileTypes, file) Then
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
Private Sub txtValue_LostFocus(Index As Integer): On Error Resume Next
    Call apply
End Sub
Private Sub txtValue_Validate(Index As Integer, Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtVar_LostFocus(Index As Integer): On Error Resume Next
    Call apply
End Sub
Private Sub txtVar_Validate(Index As Integer, Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
