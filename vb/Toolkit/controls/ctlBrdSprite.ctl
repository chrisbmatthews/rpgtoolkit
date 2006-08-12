VERSION 5.00
Begin VB.UserControl ctlBrdSprite 
   ClientHeight    =   5745
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3135
   DefaultCancel   =   -1  'True
   ScaleHeight     =   5745
   ScaleWidth      =   3135
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
      Left            =   1800
      TabIndex        =   25
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   4575
      Left            =   0
      TabIndex        =   2
      Top             =   960
      Width           =   3015
      Begin VB.CheckBox chkRunOnce 
         Caption         =   "Run once"
         Height          =   255
         Left            =   240
         TabIndex        =   27
         ToolTipText     =   "Allow this program to be run only once during the game"
         Top             =   4080
         Width           =   2415
      End
      Begin VB.HScrollBar hsbSlot 
         Height          =   255
         Left            =   1260
         Max             =   2
         TabIndex        =   24
         Top             =   1680
         Value           =   1
         Width           =   495
      End
      Begin VB.TextBox txtMultitask 
         Height          =   285
         Left            =   120
         TabIndex        =   20
         Top             =   3000
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   2
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   18
         Top             =   3000
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   2
            Left            =   0
            TabIndex        =   19
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
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   16
         Top             =   2400
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   17
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.TextBox txtActivate 
         Height          =   285
         Left            =   120
         TabIndex        =   15
         Top             =   2400
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
         Top             =   3480
         Width           =   2415
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by step-on"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   14
            Top             =   0
            Width           =   2055
         End
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by key press"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   13
            Top             =   240
            Width           =   2055
         End
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   1
         Left            =   1260
         TabIndex        =   9
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   2
         Left            =   2280
         TabIndex        =   8
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   0
         Left            =   360
         TabIndex        =   7
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   0
         Left            =   2280
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
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Label lblSlot 
         Caption         =   "Slot index: 0"
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   1740
         Width           =   1215
      End
      Begin VB.Label lblMultitask 
         Caption         =   "Override multitasking program"
         Height          =   375
         Left            =   120
         TabIndex        =   22
         Top             =   2760
         Width           =   2655
      End
      Begin VB.Label lblActivate 
         Caption         =   "Override program to run on activation"
         Height          =   375
         Left            =   120
         TabIndex        =   21
         Top             =   2160
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "X                  Y              Layer"
         Height          =   255
         Index           =   1
         Left            =   180
         TabIndex        =   11
         Top             =   1245
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "Location"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   10
         Top             =   960
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
      Width           =   3015
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   2160
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
            .activate = IIf(chkRunOnce.value, SPR_CONDITIONAL, SPR_ACTIVE)
            
            'Assign a Guid as a unique variable name.
            .initialVar = vbNullString
            If .activate = SPR_CONDITIONAL Then .initialVar = modBoard.createGuid()
            .initialValue = vbNullString            'Uninitialised variables set to "".
            .finalVar = .initialVar
            .finalValue = "1"
                        
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
    chkRunOnce.value = spr.activate
    optActivationType(spr.activationType And SPR_KEYPRESS).value = True

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
            If browseFileDialog(tkMainForm.hwnd, projectPath & itmPath, "Board sprite", ".itm", fileTypes, file) Then
                txtFilename.Text = file
                Call cmdDefault_Click
            End If
        Case 1:
            fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Activation program", ".prg", fileTypes, file) Then
                txtActivate.Text = file
                Call apply
            End If
        Case 2:
            fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(tkMainForm.hwnd, projectPath & prgPath, "Multitasking program", ".prg", fileTypes, file) Then
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
