VERSION 5.00
Begin VB.Form endform 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPG Toolkit Development System"
   ClientHeight    =   1530
   ClientLeft      =   2940
   ClientTop       =   3225
   ClientWidth     =   5490
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "END.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1530
   ScaleWidth      =   5490
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1908"
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "More Info"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   3
      Tag             =   "1909"
      Top             =   600
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label unreg 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "-Open-Source Community Edition-"
      ForeColor       =   &H00808080&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Tag             =   "1910"
      Top             =   1200
      Width           =   3255
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   $"END.frx":0CCA
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1095
      Left            =   120
      TabIndex        =   1
      Tag             =   "1911"
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "endform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Command1_Click()
    Unload Me
    DoEvents
    End
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    moreinfo.Show 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub Timer1_Timer()
    On Error GoTo errorhandler
    End

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

