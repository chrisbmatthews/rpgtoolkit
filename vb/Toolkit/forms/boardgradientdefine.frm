VERSION 5.00
Begin VB.Form boardgradientdefine 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Define Board Gradient"
   ClientHeight    =   2535
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6360
   Icon            =   "boardgradientdefine.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2535
   ScaleWidth      =   6360
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1034"
   Begin VB.Frame Frame1 
      Caption         =   "Define Lighting Gradient"
      Height          =   2055
      Left            =   120
      TabIndex        =   2
      Tag             =   "1038"
      Top             =   240
      Width           =   4695
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   120
         Picture         =   "boardgradientdefine.frx":0CCA
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   9
         Top             =   360
         Width           =   495
      End
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   840
         Picture         =   "boardgradientdefine.frx":1594
         ScaleHeight     =   495
         ScaleWidth      =   495
         TabIndex        =   8
         Top             =   360
         Width           =   495
      End
      Begin VB.OptionButton Option1 
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   840
         Value           =   -1  'True
         Width           =   255
      End
      Begin VB.OptionButton Option2 
         Height          =   255
         Left            =   960
         TabIndex        =   6
         Top             =   840
         Width           =   255
      End
      Begin VB.PictureBox c1 
         AutoRedraw      =   -1  'True
         Height          =   495
         Left            =   2040
         ScaleHeight     =   29
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   29
         TabIndex        =   5
         Top             =   360
         Width           =   495
      End
      Begin VB.PictureBox c2 
         AutoRedraw      =   -1  'True
         Height          =   495
         Left            =   3240
         ScaleHeight     =   29
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   29
         TabIndex        =   4
         Top             =   360
         Width           =   495
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Retain original shades"
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Tag             =   "1035"
         Top             =   1440
         Width           =   2655
      End
      Begin VB.Label Label2 
         Caption         =   "Light Color 1"
         Height          =   375
         Left            =   2040
         TabIndex        =   11
         Tag             =   "1037"
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label3 
         Caption         =   "Light Color 2"
         Height          =   375
         Left            =   3240
         TabIndex        =   10
         Tag             =   "1036"
         Top             =   960
         Width           =   1335
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   5040
      TabIndex        =   1
      Tag             =   "1008"
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   345
      Left            =   5040
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   360
      Width           =   1095
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
    On Error GoTo errorhandler
    boardList(activeBoardIndex).boardGradientColor1 = ColorDialog()
    Call vbPicFillRect(c1, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor1)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub c2_Click()
    On Error GoTo errorhandler
    boardList(activeBoardIndex).boardGradientColor2 = ColorDialog()
    Call vbPicFillRect(c2, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor2)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Check1_Click()
    On Error GoTo errorhandler
    If value = 1 Then
        boardList(activeBoardIndex).boardGradMaintainPrev = True
    Else
        boardList(activeBoardIndex).boardGradMaintainPrev = True
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo errorhandler
    Unload boardgradientdefine
    boardList(activeBoardIndex).boardAboutToDefineGradient = True  'about to define a gradient?
    boardList(activeBoardIndex).boardGradTop = -1
    boardList(activeBoardIndex).boardGradBottom = -1
    boardList(activeBoardIndex).boardGradLeft = -1
    boardList(activeBoardIndex).boardGradRight = -1
    MsgBox LoadStringLoc(988, "Click the top left location of the gradient shade.")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    Unload boardgradientdefine

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    If boardList(activeBoardIndex).ambientR < 0 Then boardList(activeBoardIndex).ambientR = 0
    If boardList(activeBoardIndex).ambientG < 0 Then boardList(activeBoardIndex).ambientG = 0
    If boardList(activeBoardIndex).ambientB < 0 Then boardList(activeBoardIndex).ambientB = 0
    boardList(activeBoardIndex).boardGradientColor1 = RGB(boardList(activeBoardIndex).ambientR, boardList(activeBoardIndex).ambientG, boardList(activeBoardIndex).ambientB) ' As Long           'grad color1
    boardList(activeBoardIndex).boardGradientColor2 = 0 'As Long           'grad color2
    boardList(activeBoardIndex).boardGradMaintainPrev = False
    Call vbPicFillRect(c1, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor1)
    Call vbPicFillRect(c2, 0, 0, 1000, 1000, boardList(activeBoardIndex).boardGradientColor2)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option1_Click()
    On Error GoTo errorhandler
    boardGradientType = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option2_Click()
    On Error GoTo errorhandler
    boardGradientType = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option3_Click()
    On Error GoTo errorhandler
    boardGradientType = 2

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Option4_Click()
    On Error GoTo errorhandler
    boardGradientType = 3

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


