VERSION 5.00
Begin VB.UserControl ctlBrdImage 
   ClientHeight    =   4740
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3135
   ScaleHeight     =   4740
   ScaleWidth      =   3135
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   3615
      Left            =   0
      TabIndex        =   3
      Top             =   960
      Width           =   3015
      Begin VB.PictureBox picTrans 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   1680
         ScaleHeight     =   255
         ScaleWidth      =   1095
         TabIndex        =   15
         Top             =   2160
         Width           =   1095
      End
      Begin VB.PictureBox picOpt 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   855
         Left            =   240
         ScaleHeight     =   855
         ScaleWidth      =   2295
         TabIndex        =   18
         Top             =   2640
         Visible         =   0   'False
         Width           =   2295
         Begin VB.OptionButton optType 
            Caption         =   "Parallax"
            Height          =   255
            Index           =   2
            Left            =   0
            TabIndex        =   21
            Top             =   480
            Width           =   2295
         End
         Begin VB.OptionButton optType 
            Caption         =   "Stretch"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   20
            Top             =   240
            Width           =   2295
         End
         Begin VB.OptionButton optType 
            Caption         =   "Normal"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   19
            Top             =   0
            Value           =   -1  'True
            Width           =   2295
         End
      End
      Begin VB.PictureBox picSelect 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   1680
         ScaleHeight     =   375
         ScaleWidth      =   1095
         TabIndex        =   16
         Top             =   1800
         Width           =   1095
         Begin VB.CommandButton cmdTrans 
            Caption         =   "Select"
            Height          =   255
            Left            =   0
            TabIndex        =   17
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   1
         Left            =   1260
         TabIndex        =   10
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   2
         Left            =   2280
         TabIndex        =   9
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   0
         Left            =   360
         TabIndex        =   8
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   4
         Top             =   480
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Left            =   0
            TabIndex        =   5
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Label lblTrans 
         Caption         =   "RGB (255,255,255)"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   2160
         Width           =   1455
      End
      Begin VB.Label lblTrans 
         Caption         =   "Transparent colour"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   13
         Top             =   1800
         Width           =   1575
      End
      Begin VB.Label lblLoc 
         Caption         =   "X                  Y              Layer"
         Height          =   255
         Index           =   1
         Left            =   180
         TabIndex        =   12
         Top             =   1360
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "Location (top left corner)"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   11
         Top             =   960
         Width           =   1935
      End
      Begin VB.Label lblFilename 
         Caption         =   "Image filename"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.ComboBox cmbImage 
      Height          =   315
      Left            =   0
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   120
      Width           =   3015
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   855
   End
   Begin VB.CommandButton cmdDuplicate 
      Caption         =   "Duplicate"
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   480
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
    Call activeBoard.imageApply(cmbImage.ListIndex)
End Sub

Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    cmbImage.Enabled = True
End Sub
Public Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
End Sub
Public Function setCurrentImage(ByVal index As Long) As Boolean ':on error resume next
    'index is the entry in m_ed.board(m_ed.undoIndex).images()
    'corresponding to cmbImage.itemData(i)
    Dim i As Long
    For i = 0 To cmbImage.ListCount - 1
        If cmbImage.ItemData(i) = index Then
            cmbImage.ListIndex = i
            setCurrentImage = True
            Exit Function
        End If
    Next i
End Function

Public Property Get getCombo() As ComboBox: On Error Resume Next
    Set getCombo = cmbImage
End Property
Public Property Get getOptType(ByVal index As Integer) As OptionButton: On Error Resume Next
    Set getOptType = optType(index)
End Property
Public Property Get getTxtFilename() As TextBox: On Error Resume Next
    Set getTxtFilename = txtFilename
End Property
Public Property Get getTxtLoc(ByVal index As Long) As TextBox: On Error Resume Next
    Set getTxtLoc = txtLoc(index)
End Property
Public Property Let transpcolor(ByVal color As Long): On Error Resume Next
    lblTrans(1).Caption = "RGB (" & red(color) & ", " & green(color) & ", " & blue(color) & ")"
    picTrans.backColor = color
End Property
Public Property Get transpcolor() As Long: On Error Resume Next
    transpcolor = picTrans.backColor
End Property

Private Sub cmbImage_Click(): On Error Resume Next
    If cmbImage.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbImage.ItemData(cmbImage.ListIndex), BS_IMAGE)
End Sub
Private Sub cmdBrowse_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.imageDeleteCurrent
    Call activeBoard.drawAll
End Sub
Private Sub cmdDuplicate_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub cmdTrans_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub picTrans_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub txtLoc_Validate(index As Integer, Cancel As Boolean): On Error Resume Next
    Call apply
    Call activeBoard.drawAll
End Sub
Private Sub txtFilename_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
    Call activeBoard.drawAll
End Sub


