VERSION 5.00
Begin VB.Form loadingfont 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Loading Font..."
   ClientHeight    =   480
   ClientLeft      =   2715
   ClientTop       =   2745
   ClientWidth     =   4215
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
   Icon            =   "LOADINGF.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   480
   ScaleWidth      =   4215
   Tag             =   "1789"
   Begin VB.PictureBox progress 
      BackColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   240
      ScaleHeight     =   195
      ScaleMode       =   0  'User
      ScaleWidth      =   252.935
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "loadingfont"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub


