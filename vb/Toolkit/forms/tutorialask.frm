VERSION 5.00
Begin VB.Form tutorialask 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "RPG Toolkit Tutorial"
   ClientHeight    =   1935
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4815
   Icon            =   "tutorialask.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   4815
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1855"
   Begin Toolkit.TKButton command3 
      Height          =   375
      Left            =   3000
      TabIndex        =   4
      Top             =   1320
      Width           =   1215
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "Never"
   End
   Begin Toolkit.TKButton command2 
      Height          =   375
      Left            =   1800
      TabIndex        =   3
      Top             =   1320
      Width           =   975
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "No"
   End
   Begin Toolkit.TKButton command1 
      Height          =   375
      Left            =   600
      TabIndex        =   2
      Top             =   1320
      Width           =   975
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "Yes"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   847
      Object.Width           =   3255
      Caption         =   "View the Tutorial"
   End
   Begin VB.Shape Shape1 
      Height          =   1935
      Left            =   0
      Top             =   0
      Width           =   4815
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
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
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   480
      TabIndex        =   0
      Top             =   480
      Width           =   3855
   End
End
Attribute VB_Name = "tutorialask"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

'========================================================================
' Yes
'========================================================================
Private Sub Command1_Click()
    On Error Resume Next
    Call Unload(Me)
    configfile.tutCurrentLesson = 1
    Call tkMainForm.tutorialmnu_Click
End Sub

'========================================================================
' No
'========================================================================
Private Sub Command2_Click()
    Call Unload(Me)
End Sub

'========================================================================
' Never
'========================================================================
Private Sub Command3_Click()
    On Error Resume Next
    Call Unload(Me)
    configfile.tutCurrentLesson = 1
    Call MsgBox(LoadStringLoc(993, "You can always run the tutorial by selecting Tutorial from the Help menu."))
End Sub

'========================================================================
' Form loaded
'========================================================================
Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    Set TopBar.theForm = Me
End Sub
