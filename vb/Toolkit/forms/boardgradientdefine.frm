VERSION 5.00
Begin VB.Form boardGradientDefine 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Define Board Gradient"
   ClientHeight    =   2520
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6255
   Icon            =   "boardgradientdefine.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2520
   ScaleWidth      =   6255
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1034"
   Begin VB.PictureBox Picture3 
      BorderStyle     =   0  'None
      Height          =   1695
      Left            =   240
      ScaleHeight     =   1695
      ScaleWidth      =   4455
      TabIndex        =   3
      Top             =   480
      Width           =   4455
      Begin VB.CheckBox Check1 
         Caption         =   "Retain original shades"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Tag             =   "1035"
         Top             =   1080
         Width           =   2655
      End
      Begin VB.PictureBox c2 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   3120
         ScaleHeight     =   31
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   31
         TabIndex        =   9
         Top             =   0
         Width           =   495
      End
      Begin VB.PictureBox c1 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   1920
         ScaleHeight     =   31
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   31
         TabIndex        =   8
         Top             =   0
         Width           =   495
      End
      Begin VB.OptionButton Option2 
         Height          =   255
         Left            =   840
         TabIndex        =   7
         Top             =   480
         Width           =   255
      End
      Begin VB.OptionButton Option1 
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Value           =   -1  'True
         Width           =   255
      End
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   720
         Picture         =   "boardgradientdefine.frx":0CCA
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   5
         Top             =   0
         Width           =   495
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   0
         Picture         =   "boardgradientdefine.frx":1594
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   4
         Top             =   0
         Width           =   495
      End
      Begin VB.Label Label3 
         Caption         =   "Light Color 2"
         Height          =   375
         Left            =   3120
         TabIndex        =   12
         Tag             =   "1036"
         Top             =   600
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Light Color 1"
         Height          =   375
         Left            =   1920
         TabIndex        =   11
         Tag             =   "1037"
         Top             =   600
         Width           =   1215
      End
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5040
      TabIndex        =   2
      Top             =   960
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   5040
      TabIndex        =   1
      Top             =   480
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Define Lighting Gradient"
      Height          =   2055
      Left            =   120
      TabIndex        =   0
      Tag             =   "1038"
      Top             =   240
      Width           =   4695
   End
End
Attribute VB_Name = "boardGradientDefine"
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
    Unload boardGradientDefine
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
    Unload boardGradientDefine

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
    Set TopBar.theForm = Me
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


