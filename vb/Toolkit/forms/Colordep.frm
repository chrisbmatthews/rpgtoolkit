VERSION 5.00
Begin VB.Form colordepth 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Changing Color Depth..."
   ClientHeight    =   540
   ClientLeft      =   2850
   ClientTop       =   3360
   ClientWidth     =   4110
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
   Icon            =   "Colordep.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   540
   ScaleWidth      =   4110
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1850"
   Begin VB.PictureBox status 
      BackColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   600
      ScaleHeight     =   8.667
      ScaleMode       =   0  'User
      ScaleWidth      =   98.953
      TabIndex        =   0
      Top             =   120
      Width           =   2895
   End
End
Attribute VB_Name = "colordepth"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Form_Load()
    ' Call LocalizeForm(Me)
End Sub
