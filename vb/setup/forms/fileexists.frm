VERSION 5.00
Begin VB.Form fileexists 
   Caption         =   "File Exists"
   ClientHeight    =   2490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6360
   Icon            =   "fileexists.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2490
   ScaleWidth      =   6360
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command4 
      Caption         =   "No to All"
      Height          =   375
      Left            =   4800
      TabIndex        =   5
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "No"
      Height          =   375
      Left            =   3240
      TabIndex        =   4
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Yes to All"
      Height          =   375
      Left            =   1680
      TabIndex        =   3
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Yes"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   1920
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "Do you wish to overwrite it?"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      TabIndex        =   1
      Top             =   1440
      Width           =   2775
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   $"fileexists.frx":0CCA
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   960
      TabIndex        =   0
      Top             =   120
      Width           =   4575
   End
End
Attribute VB_Name = "fileexists"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub Command1_Click()
    yes = 1
    no = 0
    Unload fileexists
End Sub


Private Sub Command2_Click()
    yestoall = 1
    yes = 1
    no = 0
    Unload fileexists
End Sub


Private Sub Command3_Click()
    no = 1
    yes = 0
    Unload fileexists
End Sub


Private Sub Command4_Click()
    notoall = 1
    yes = 0
    yestoall = 0
    Unload fileexists
End Sub

Private Sub Form_Load()
    Label1.Caption = prompttext$
End Sub


