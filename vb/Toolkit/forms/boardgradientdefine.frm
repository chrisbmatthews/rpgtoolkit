VERSION 5.00
Begin VB.Form boardGradientDefine 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Define Board Gradient"
   ClientHeight    =   2655
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6255
   Icon            =   "boardgradientdefine.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2655
   ScaleWidth      =   6255
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1034"
   Begin Toolkit.TKTopBar topbar 
      Height          =   480
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   847
      Object.Width           =   3855
      Caption         =   "Define a Board Gradient"
   End
   Begin Toolkit.TKButton Command2 
      Height          =   495
      Left            =   4920
      TabIndex        =   11
      Top             =   1200
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   873
      Object.Width           =   360
      Caption         =   "Cancel"
   End
   Begin Toolkit.TKButton Command1 
      Height          =   495
      Left            =   4920
      TabIndex        =   10
      Top             =   600
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   873
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Define Lighting Gradient"
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   120
      TabIndex        =   0
      Tag             =   "1038"
      Top             =   480
      Width           =   4695
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   120
         Picture         =   "boardgradientdefine.frx":0CCA
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   7
         Top             =   360
         Width           =   495
      End
      Begin VB.PictureBox Picture2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   840
         Picture         =   "boardgradientdefine.frx":1594
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   6
         Top             =   360
         Width           =   495
      End
      Begin VB.OptionButton Option1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   840
         Value           =   -1  'True
         Width           =   255
      End
      Begin VB.OptionButton Option2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   960
         TabIndex        =   4
         Top             =   840
         Width           =   255
      End
      Begin VB.PictureBox c1 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   2040
         ScaleHeight     =   31
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   31
         TabIndex        =   3
         Top             =   360
         Width           =   495
      End
      Begin VB.PictureBox c2 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   3240
         ScaleHeight     =   31
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   31
         TabIndex        =   2
         Top             =   360
         Width           =   495
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Retain original shades"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Tag             =   "1035"
         Top             =   1440
         Width           =   2655
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Light Color 1"
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2040
         TabIndex        =   9
         Tag             =   "1037"
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Light Color 2"
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   3240
         TabIndex        =   8
         Tag             =   "1036"
         Top             =   960
         Width           =   1335
      End
   End
   Begin VB.Shape Shape1 
      Height          =   2655
      Left            =   0
      Top             =   0
      Width           =   6255
   End
End
Attribute VB_Name = "boardgradientdefine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub c1_Click()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).boardGradientColor1 = ColorDialog()
    Call vbPicFillRect(c1, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor1)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub c2_Click()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).boardGradientColor2 = ColorDialog()
    Call vbPicFillRect(c2, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor2)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Check1_Click()
    On Error GoTo ErrorHandler
    If value = 1 Then
        boardList(activeBoardIndex).boardGradMaintainPrev = True
    Else
        boardList(activeBoardIndex).boardGradMaintainPrev = True
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    Unload boardgradientdefine
    boardList(activeBoardIndex).boardAboutToDefineGradient = True  'about to define a gradient?
    boardList(activeBoardIndex).boardGradTop = -1
    boardList(activeBoardIndex).boardGradBottom = -1
    boardList(activeBoardIndex).boardGradLeft = -1
    boardList(activeBoardIndex).boardGradRight = -1
    MsgBox LoadStringLoc(988, "Click the top left location of the gradient shade.")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    Unload boardgradientdefine

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
    Set topbar.theForm = Me
    If boardList(activeBoardIndex).ambientR < 0 Then boardList(activeBoardIndex).ambientR = 0
    If boardList(activeBoardIndex).ambientG < 0 Then boardList(activeBoardIndex).ambientG = 0
    If boardList(activeBoardIndex).ambientB < 0 Then boardList(activeBoardIndex).ambientB = 0
    boardList(activeBoardIndex).boardGradientColor1 = RGB(boardList(activeBoardIndex).ambientR, boardList(activeBoardIndex).ambientG, boardList(activeBoardIndex).ambientB) ' As Long           'grad color1
    boardList(activeBoardIndex).boardGradientColor2 = 0 'As Long           'grad color2
    boardList(activeBoardIndex).boardGradMaintainPrev = False
    Call vbPicFillRect(c1, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor1)
    Call vbPicFillRect(c2, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor2)
End Sub

Private Sub Option1_Click()
    On Error GoTo ErrorHandler
    boardGradientType = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option2_Click()
    On Error GoTo ErrorHandler
    boardGradientType = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option3_Click()
    On Error GoTo ErrorHandler
    boardGradientType = 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option4_Click()
    On Error GoTo ErrorHandler
    boardGradientType = 3

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


