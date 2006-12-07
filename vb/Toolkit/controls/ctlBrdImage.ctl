VERSION 5.00
Begin VB.UserControl ctlBrdImage 
   ClientHeight    =   4740
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3555
   DefaultCancel   =   -1  'True
   ScaleHeight     =   4740
   ScaleWidth      =   3555
   Begin VB.CheckBox chkDraw 
      Caption         =   "Draw images"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1575
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Ok"
      Default         =   -1  'True
      Height          =   375
      Left            =   2160
      TabIndex        =   21
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   3375
      Left            =   0
      TabIndex        =   12
      Top             =   960
      Width           =   3375
      Begin VB.CheckBox chkTransp 
         Caption         =   "Select"
         Height          =   255
         Left            =   1800
         Style           =   1  'Graphical
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   1800
         Width           =   1095
      End
      Begin VB.PictureBox picTrans 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   1800
         ScaleHeight     =   255
         ScaleWidth      =   1095
         TabIndex        =   19
         ToolTipText     =   "Current transparent color on the image"
         Top             =   2160
         Width           =   1095
      End
      Begin VB.PictureBox picOpt 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   855
         Left            =   360
         ScaleHeight     =   855
         ScaleWidth      =   2295
         TabIndex        =   20
         Top             =   2640
         Visible         =   0   'False
         Width           =   2295
         Begin VB.OptionButton optType 
            Caption         =   "Parallax"
            Height          =   255
            Index           =   2
            Left            =   0
            TabIndex        =   11
            Top             =   480
            Width           =   2295
         End
         Begin VB.OptionButton optType 
            Caption         =   "Stretch"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   10
            Top             =   240
            Width           =   2295
         End
         Begin VB.OptionButton optType 
            Caption         =   "Normal"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   9
            Top             =   0
            Value           =   -1  'True
            Width           =   2295
         End
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   1
         Left            =   1380
         TabIndex        =   6
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   2
         Left            =   2400
         TabIndex        =   7
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   0
         Left            =   480
         TabIndex        =   5
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   2535
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2760
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   13
         Top             =   480
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Left            =   0
            TabIndex        =   4
            ToolTipText     =   "Browse for image file"
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Label lblTrans 
         Caption         =   "RGB (255, 255, 255)"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   18
         ToolTipText     =   "The RGB values of the transparent color"
         Top             =   2160
         Width           =   1575
      End
      Begin VB.Label lblTrans 
         Caption         =   "Transparent color"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   17
         ToolTipText     =   "Click 'Select' and the click the color on the image (on the board) that you wish to be transparent"
         Top             =   1800
         Width           =   1575
      End
      Begin VB.Label lblLoc 
         Caption         =   "X                  Y              Layer"
         Height          =   255
         Index           =   1
         Left            =   300
         TabIndex        =   16
         Top             =   1365
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "Location (top left corner)"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   15
         Top             =   960
         Width           =   1935
      End
      Begin VB.Label lblFilename 
         Caption         =   "Image filename"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.ComboBox cmbImage 
      Height          =   315
      Left            =   0
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   600
      Width           =   3375
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   2520
      TabIndex        =   1
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "ctlBrdImage"
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

Private Sub apply(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.imageApply(cmbImage.ListIndex)
End Sub

Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    Call activeBoard.toolbarSetCurrent(BTAB_IMAGE, -1)
    cmbImage.Enabled = True
End Sub
Public Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
    chkDraw.value = Abs(activeBoard.toolbarDrawObject(BS_IMAGE))
End Sub
Public Sub moveCurrentTo(ByRef sel As CBoardSelection) ':on error resume next
    Call activeBoard.setUndo
    txtLoc(0).Text = str(sel.x1)
    txtLoc(1).Text = str(sel.y1)
    Call activeBoard.imageApply(cmbImage.ListIndex)
    Call activeBoard.drawAll
End Sub

Public Property Get ActiveControl() As Control ': On Error Resume Next
    Set ActiveControl = UserControl.ActiveControl
End Property
Public Property Get getCombo() As ComboBox: On Error Resume Next
    Set getCombo = cmbImage
End Property
Public Property Get getOptType(ByVal Index As Integer) As OptionButton: On Error Resume Next
    Set getOptType = optType(Index)
End Property
Public Property Get getTxtFilename() As TextBox: On Error Resume Next
    Set getTxtFilename = txtFilename
End Property
Public Property Get getTxtLoc(ByVal Index As Long) As TextBox: On Error Resume Next
    Set getTxtLoc = txtLoc(Index)
End Property
Public Property Get getChkTransp() As CheckBox: On Error Resume Next
    Set getChkTransp = chkTransp
End Property
Public Property Let transpcolor(ByVal color As Long): On Error Resume Next
    lblTrans(1).Caption = "RGB (" & red(color) & ", " & green(color) & ", " & blue(color) & ")"
    picTrans.backColor = color
End Property
Public Property Get transpcolor() As Long: On Error Resume Next
    transpcolor = picTrans.backColor
End Property

Private Sub chkDraw_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    activeBoard.toolbarDrawObject(BS_IMAGE) = chkDraw.value
End Sub
Private Sub chkTransp_Click(): On Error Resume Next
    If chkTransp.value Then
        tkMainForm.brdOptSetting(BS_SCROLL).value = True
        Call activeBoard.mdiOptTool(BT_IMG_TRANSP)
    End If
End Sub
Private Sub cmbImage_Click(): On Error Resume Next
    If cmbImage.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbImage.ListIndex, BS_IMAGE)
End Sub
Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String
    If browseFileDialog(tkMainForm.hwnd, projectPath & bmpPath, "Board image", "jpg", strFileDialogFilterGfx, file) Then
        txtFilename.Text = file
        Call cmdDefault_Click
    End If
End Sub
Private Sub cmdDefault_Click(): On Error Resume Next
    'Default button on form: hitting the Enter key calls this function.
    Call apply
    Call activeBoard.drawAll
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.imageDeleteCurrent(cmbImage.ListIndex)
    Call activeBoard.drawAll
End Sub
Private Sub picTrans_Click(): On Error Resume Next
    transpcolor = ColorDialog()
    Call activeBoard.drawAll
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



