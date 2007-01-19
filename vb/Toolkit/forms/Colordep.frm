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
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private Sub Form_Load()
    ' Call LocalizeForm(Me)
End Sub
