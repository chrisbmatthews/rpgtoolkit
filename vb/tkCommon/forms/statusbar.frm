VERSION 5.00
Begin VB.Form statusBar 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPGToolkit Development System"
   ClientHeight    =   1650
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4425
   ControlBox      =   0   'False
   Icon            =   "statusbar.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1650
   ScaleWidth      =   4425
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame fraHolder 
      Height          =   1575
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   4215
      Begin VB.PictureBox picFrame 
         AutoRedraw      =   -1  'True
         Height          =   495
         Left            =   120
         ScaleHeight     =   435
         ScaleWidth      =   3795
         TabIndex        =   3
         Top             =   960
         Width           =   3855
         Begin VB.Image imgBlue 
            Height          =   240
            Left            =   120
            Picture         =   "statusbar.frx":0CCA
            Top             =   120
            Width           =   3600
         End
         Begin VB.Image imgGrey 
            Height          =   240
            Left            =   120
            Picture         =   "statusbar.frx":3A0C
            Top             =   120
            Width           =   3600
         End
      End
      Begin VB.Label lblDetails 
         Caption         =   "Adding file..."
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   720
         Width           =   3975
      End
      Begin VB.Label lblBuilding 
         Caption         =   "Building game..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   2895
      End
   End
End
Attribute VB_Name = "statusBar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
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

'=========================================================================
' Set status on bar
'=========================================================================
Public Sub setStatus(ByVal sPercent As Long, ByVal Text As String): On Error Resume Next
    imgBlue.width = sPercent * imgGrey.width / 100
    lblDetails.Caption = Text
End Sub

'=========================================================================
' Load bar
'=========================================================================
Private Sub Form_Load(): On Error Resume Next
    imgBlue.width = 0
End Sub
