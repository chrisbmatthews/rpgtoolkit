VERSION 5.00
Begin VB.Form tutorialask 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPG Toolkit Tutorial"
   ClientHeight    =   1455
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4455
   Icon            =   "tutorialask.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   4455
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1855"
   Begin VB.CommandButton Command3 
      Caption         =   "Don't Ask Again"
      Height          =   375
      Left            =   3000
      TabIndex        =   3
      Top             =   960
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "No"
      Height          =   375
      Left            =   1560
      TabIndex        =   2
      Top             =   960
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Yes"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   1335
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "It seems as if you've never run the tutorial.  Would you like to run it now?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   3855
   End
End
Attribute VB_Name = "tutorialask"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Command1_Click()
    On Error Resume Next
    Call Unload(Me)
    Call tkMainForm.tutorialmnu_Click
End Sub

Private Sub Command2_Click()
    Call Unload(Me)
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    Call Unload(Me)
    tutCurrentLesson = 1
    Call MsgBox(LoadStringLoc(993, "You can always run the tutorial by selecting Tutorial from the Help menu."))
End Sub

Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub
