VERSION 5.00
Begin VB.Form itmmenu 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Menu-Driven Properties"
   ClientHeight    =   1965
   ClientLeft      =   2160
   ClientTop       =   2550
   ClientWidth     =   7665
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
   Icon            =   "ITMMENU.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1965
   ScaleWidth      =   7665
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1539"
   Begin VB.CommandButton cmdOK 
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
      Height          =   345
      Left            =   6480
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Effects of using item"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   120
      TabIndex        =   1
      Tag             =   "1542"
      Top             =   120
      Width           =   6255
      Begin VB.TextBox equipped 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2880
         TabIndex        =   11
         Text            =   "None"
         Top             =   1200
         Width           =   2055
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   5040
         ScaleHeight     =   375
         ScaleWidth      =   1095
         TabIndex        =   9
         Top             =   1200
         Width           =   1095
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   0
            TabIndex        =   10
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox hpup 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2280
         TabIndex        =   3
         Text            =   "0"
         Top             =   360
         Width           =   495
      End
      Begin VB.TextBox smup 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2280
         TabIndex        =   2
         Text            =   "0"
         Top             =   720
         Width           =   495
      End
      Begin VB.Label Label7 
         Caption         =   "Program To Run When Item Is Used:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   12
         Tag             =   "1533"
         Top             =   1200
         Width           =   2895
      End
      Begin VB.Label Label3 
         Caption         =   "Negative values decrease health/SM Power!"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   495
         Left            =   3600
         TabIndex        =   8
         Tag             =   "1537"
         Top             =   480
         Width           =   2055
      End
      Begin VB.Label Label5 
         Caption         =   "Health Increases By"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Tag             =   "1540"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label Label6 
         Caption         =   "Points"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   2880
         TabIndex        =   6
         Tag             =   "1504"
         Top             =   360
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "SMP Increases By"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   5
         Tag             =   "1541"
         Top             =   720
         Width           =   1935
      End
      Begin VB.Label Label6 
         Caption         =   "Points"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   2880
         TabIndex        =   4
         Tag             =   "1504"
         Top             =   720
         Width           =   615
      End
   End
End
Attribute VB_Name = "itmmenu"
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

Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        equipped.Text = file
        itemList(activeItemIndex).theData.mnuUse = file
    End If
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub equipped_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.mnuUse = equipped.Text
End Sub

Private Sub Form_Load(): On Error Resume Next
    hpup.Text = CStr(itemList(activeItemIndex).theData.mnuHPup)
    smup.Text = CStr(itemList(activeItemIndex).theData.mnuSMup)
    If LenB(itemList(activeItemIndex).theData.mnuUse) Then
        equipped.Text = itemList(activeItemIndex).theData.mnuUse
    End If
End Sub

Private Sub hpup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.mnuHPup = val(hpup.Text)
End Sub

Private Sub smup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.mnuSMup = val(smup.Text)
End Sub

