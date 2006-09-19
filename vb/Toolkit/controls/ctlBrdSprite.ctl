VERSION 5.00
Begin VB.UserControl ctlBrdSprite 
   ClientHeight    =   6960
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3615
   DefaultCancel   =   -1  'True
   ScaleHeight     =   6960
   ScaleWidth      =   3615
   Begin VB.CheckBox chkDraw 
      Caption         =   "Draw sprites"
      Height          =   375
      Left            =   120
      TabIndex        =   26
      Top             =   120
      Width           =   1575
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Ok"
      Default         =   -1  'True
      Height          =   375
      Left            =   2160
      TabIndex        =   25
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   5535
      Left            =   0
      TabIndex        =   2
      Top             =   960
      Width           =   3375
      Begin VB.TextBox txtValue 
         Height          =   285
         Index           =   2
         Left            =   2400
         TabIndex        =   37
         ToolTipText     =   "Enter the value to set the variable to"
         Top             =   5160
         Width           =   855
      End
      Begin VB.TextBox txtVar 
         Height          =   285
         Index           =   2
         Left            =   240
         TabIndex        =   35
         ToolTipText     =   "Enter the name of a variable to set when the program ends (may be the same as above)"
         Top             =   5160
         Width           =   1815
      End
      Begin VB.TextBox txtValue 
         Height          =   285
         Index           =   1
         Left            =   2400
         TabIndex        =   33
         ToolTipText     =   "Enter the value the variable must be to run the activation program. Note: Leave blank if the variable is uninitialised"
         Top             =   4560
         Width           =   855
      End
      Begin VB.TextBox txtVar 
         Height          =   285
         Index           =   1
         Left            =   240
         TabIndex        =   31
         ToolTipText     =   "Enter the name of an RPGCode variable"
         Top             =   4560
         Width           =   1815
      End
      Begin VB.TextBox txtValue 
         Height          =   285
         Index           =   0
         Left            =   2400
         TabIndex        =   29
         ToolTipText     =   "Enter the value the variable must be to show the sprite. Note: Leave blank if the variable is uninitialised"
         Top             =   3960
         Width           =   855
      End
      Begin VB.TextBox txtVar 
         Height          =   285
         Index           =   0
         Left            =   240
         TabIndex        =   27
         ToolTipText     =   "Enter the name of an RPGCode variable"
         Top             =   3960
         Width           =   1815
      End
      Begin VB.HScrollBar hsbSlot 
         Height          =   255
         Left            =   1380
         Max             =   2
         TabIndex        =   24
         Top             =   1440
         Value           =   1
         Width           =   495
      End
      Begin VB.TextBox txtMultitask 
         Height          =   285
         Left            =   240
         TabIndex        =   20
         ToolTipText     =   "Specify the program that controls the item during gameplay (run as a thread)"
         Top             =   2760
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   2
         Left            =   2400
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   18
         Top             =   2760
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   2
            Left            =   0
            TabIndex        =   19
            ToolTipText     =   "Browse for program"
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   1
         Left            =   2400
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   16
         Top             =   2160
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   17
            ToolTipText     =   "Browse for program"
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.TextBox txtActivate 
         Height          =   285
         Left            =   240
         TabIndex        =   15
         ToolTipText     =   "Specify the program to run when the user interacts with the item"
         Top             =   2160
         Width           =   2055
      End
      Begin VB.PictureBox picActivationType 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   240
         ScaleHeight     =   495
         ScaleWidth      =   2415
         TabIndex        =   12
         Top             =   3120
         Width           =   2415
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by step-on"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   14
            ToolTipText     =   "Users must stand on or in a sprite's activation base to run the activation program"
            Top             =   0
            Width           =   2055
         End
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by key press"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   13
            ToolTipText     =   "Users must press the Main File Activation Key whilst standing on or in the sprite's activation base to run the activation program"
            Top             =   240
            Width           =   2055
         End
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   1
         Left            =   1380
         TabIndex        =   9
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   2
         Left            =   2400
         TabIndex        =   8
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   0
         Left            =   480
         TabIndex        =   7
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   2535
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   0
         Left            =   2760
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   3
         Top             =   480
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   4
            ToolTipText     =   "Browse for sprite"
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Label lbl 
         Caption         =   "="
         Height          =   255
         Index           =   5
         Left            =   2160
         TabIndex        =   38
         Top             =   5160
         Width           =   135
      End
      Begin VB.Label lbl 
         Caption         =   "After activation program finishes, variable"
         Height          =   375
         Index           =   4
         Left            =   240
         TabIndex        =   36
         Top             =   4920
         Width           =   3015
      End
      Begin VB.Label lbl 
         Caption         =   "="
         Height          =   255
         Index           =   3
         Left            =   2160
         TabIndex        =   34
         Top             =   4560
         Width           =   135
      End
      Begin VB.Label lbl 
         Caption         =   "Run activation program if variable"
         Height          =   375
         Index           =   2
         Left            =   240
         TabIndex        =   32
         Top             =   4320
         Width           =   3015
      End
      Begin VB.Label lbl 
         Caption         =   "="
         Height          =   255
         Index           =   1
         Left            =   2160
         TabIndex        =   30
         Top             =   3960
         Width           =   135
      End
      Begin VB.Label lbl 
         Caption         =   "Show sprite when board loads if variable"
         Height          =   375
         Index           =   0
         Left            =   240
         TabIndex        =   28
         Top             =   3720
         Width           =   3015
      End
      Begin VB.Label lblSlot 
         Caption         =   "Slot index: 0"
         Height          =   255
         Left            =   240
         TabIndex        =   23
         ToolTipText     =   "Identifying index for use with RPGCode functions. Use the scroll arrows to move the sprite up or down the list"
         Top             =   1500
         Width           =   1215
      End
      Begin VB.Label lblMultitask 
         Caption         =   "Override multitasking program"
         Height          =   375
         Left            =   240
         TabIndex        =   22
         Top             =   2520
         Width           =   2655
      End
      Begin VB.Label lblActivate 
         Caption         =   "Override program to run on activation"
         Height          =   375
         Left            =   240
         TabIndex        =   21
         Top             =   1920
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "X                  Y              Layer"
         Height          =   255
         Index           =   1
         Left            =   300
         TabIndex        =   11
         Top             =   1125
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "Location"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   10
         Top             =   840
         Width           =   975
      End
      Begin VB.Label lblFilename 
         Caption         =   "Sprite filename"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.ComboBox cmbSprite 
      Height          =   315
      Left            =   0
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   600
      Width           =   3375
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   2520
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "ctlBrdSprite"
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
    Dim x As Long, y As Long, spr As CBoardSprite
    Call activeBoard.setUndo
    Set spr = activeBoard.toolbarGetCurrent(BS_SPRITE)
    If Not spr Is Nothing Then
        With spr
            x = val(txtLoc(0).Text)
            y = val(txtLoc(1).Text)
            Call activeBoard.tileToBoardPixel(x, y, True, False)
            .x = x
            .y = y
            .layer = Abs(val(txtLoc(2).Text))
            
            .loadingVar = txtVar(0).Text
            .loadingValue = txtValue(0).Text
            .initialVar = txtVar(1).Text
            .initialValue = txtValue(1).Text
            .finalVar = txtVar(2).Text
            .finalValue = txtValue(2).Text
            
            .activate = IIf(LenB(.initialVar), SPR_CONDITIONAL, SPR_ACTIVE)
                        
            .activationType = Abs(optActivationType(SPR_KEYPRESS).value)
            .prgActivate = txtActivate.Text
            .prgMultitask = txtMultitask.Text
       
            'Free the canvas of the current image if changing filename.
            Call activeBoard.spriteUpdateImageData(spr, txtFilename.Text, False)
        End With
    End If
    Call populate(cmbSprite.ListIndex, spr)
End Sub
Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    Call activeBoard.toolbarSetCurrent(BTAB_SPRITE, -1)
    cmbSprite.Enabled = True
End Sub
Public Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
    chkDraw.value = Abs(activeBoard.toolbarDrawObject(BS_SPRITE))
End Sub
Public Sub moveCurrentTo(ByRef sel As CBoardSelection) ':on error resume next
    Dim x As Long, y As Long
    'Selection holds the frame bounds. Derive the base point.
    x = (sel.x1 + sel.x2) / 2
    y = sel.y2
    Call activeBoard.boardPixelToTile(x, y, True, False)
    txtLoc(0).Text = str(x)
    txtLoc(1).Text = str(y)
    Call apply
    Call activeBoard.drawAll
End Sub

Public Sub populate(ByVal Index As Long, ByRef spr As CBoardSprite) ':on error resume next
    Dim i As Long, x As Long, y As Long
    
    If spr Is Nothing Then
        Call disableAll
        Exit Sub
    End If
    
    Call activeBoard.toolbarSetCurrent(BTAB_SPRITE, Index)
    Call enableAll
    
    If cmbSprite.ListIndex <> Index Then cmbSprite.ListIndex = Index
    cmbSprite.list(Index) = str(Index) & ": " & IIf(LenB(spr.filename), spr.filename, "<sprite>")
    txtFilename.Text = spr.filename
    x = spr.x
    y = spr.y
    Call activeBoard.boardPixelToTile(x, y, True, False)
    txtLoc(0).Text = str(x)
    txtLoc(1).Text = str(y)
    txtLoc(2).Text = str(spr.layer)
    txtActivate = spr.prgActivate
    txtMultitask = spr.prgMultitask
    lblSlot.Caption = "Slot index: " & CStr(Index)
    optActivationType(spr.activationType And SPR_KEYPRESS).value = True
    txtVar(0).Text = spr.loadingVar
    txtValue(0).Text = spr.loadingValue
    txtVar(1).Text = spr.initialVar
    txtValue(1).Text = spr.initialValue
    txtVar(2).Text = spr.finalVar
    txtValue(2).Text = spr.finalValue

End Sub

Public Property Get ActiveControl() As Control ': On Error Resume Next
    Set ActiveControl = UserControl.ActiveControl
End Property
Public Property Get getCombo() As ComboBox: On Error Resume Next
    Set getCombo = cmbSprite
End Property

Private Sub chkDraw_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    activeBoard.toolbarDrawObject(BS_SPRITE) = chkDraw.value
End Sub

Private Sub chkRunOnce_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub

Private Sub cmbSprite_Click(): On Error Resume Next
    If cmbSprite.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbSprite.ListIndex, BS_SPRITE)
End Sub
Private Sub cmdBrowse_Click(Index As Integer): On Error Resume Next
    Dim file As String, fileTypes As String
    Select Case Index
        Case 0:
            fileTypes = "Item (*.itm)|*.itm|All files(*.*)|*.*"
            If browseFileDialog(tkMainForm.hwnd, projectPath & itmPath, "Board sprite", "itm", fileTypes, file) Then
                txtFilename.Text = file
                Call cmdDefault_Click
            End If
        Case 1:
            fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Activation program", "prg", fileTypes, file) Then
                txtActivate.Text = file
                Call apply
            End If
        Case 2:
            fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Multitasking program", "prg", fileTypes, file) Then
                txtMultitask.Text = file
                Call apply
            End If
    End Select
End Sub
Private Sub cmdDefault_Click(): On Error Resume Next
    'Default button on form: hitting the Enter key calls this function.
    Call apply
    Call activeBoard.drawAll
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.spriteDeleteCurrent(cmbSprite.ListIndex)
    Call activeBoard.drawAll
End Sub
Private Sub hsbSlot_Change(): On Error Resume Next
    If hsbSlot.value <> 1 Then
        Call activeBoard.spriteSwapSlots(cmbSprite.ListIndex, cmbSprite.ListIndex + hsbSlot.value - 1)
    End If
    hsbSlot.value = 1
End Sub
Private Sub optActivationType_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub txtActivate_LostFocus(): On Error Resume Next
    Call apply
End Sub
Private Sub txtActivate_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtFilename_LostFocus(): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtFilename_Validate(Cancel As Boolean): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtLoc_LostFocus(Index As Integer): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtLoc_Validate(Index As Integer, Cancel As Boolean): On Error Resume Next
    Call cmdDefault_Click
End Sub
Private Sub txtMultitask_LostFocus(): On Error Resume Next
    Call apply
End Sub
Private Sub txtMultitask_Validate(Cancel As Boolean): On Error Resume Next
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
