VERSION 5.00
Begin VB.Form onemoment 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "One Moment Please..."
   ClientHeight    =   30
   ClientLeft      =   3390
   ClientTop       =   3885
   ClientWidth     =   2985
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
   Icon            =   "ONEMOMEN.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   30
   ScaleWidth      =   2985
   Tag             =   "1808"
End
Attribute VB_Name = "onemoment"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub


