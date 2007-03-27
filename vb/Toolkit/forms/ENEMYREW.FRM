VERSION 5.00
Begin VB.Form enemyrewards 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Rewards"
   ClientHeight    =   2265
   ClientLeft      =   3015
   ClientTop       =   2850
   ClientWidth     =   6315
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
   Icon            =   "ENEMYREW.frx":0000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2265
   ScaleWidth      =   6315
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1386"
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
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
      Left            =   5160
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Rewards For Defeating Enemy"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   120
      TabIndex        =   1
      Tag             =   "1390"
      Top             =   120
      Width           =   4935
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   3720
         ScaleHeight     =   495
         ScaleWidth      =   1095
         TabIndex        =   8
         Top             =   1440
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
            TabIndex        =   9
            Tag             =   "1021"
            Top             =   120
            Width           =   1095
         End
      End
      Begin VB.TextBox Text1 
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
         Left            =   1920
         TabIndex        =   4
         Text            =   "0"
         Top             =   360
         Width           =   1695
      End
      Begin VB.TextBox Text2 
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
         Left            =   1920
         TabIndex        =   3
         Text            =   "0"
         Top             =   720
         Width           =   1695
      End
      Begin VB.TextBox Text3 
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
         Left            =   120
         TabIndex        =   2
         Text            =   "None"
         Top             =   1560
         Width           =   3495
      End
      Begin VB.Label Label2 
         Caption         =   "Experience Gained:"
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
         Left            =   120
         TabIndex        =   7
         Tag             =   "1389"
         Top             =   360
         Width           =   1695
      End
      Begin VB.Label Label3 
         Caption         =   "GP Earned:"
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
         Left            =   120
         TabIndex        =   6
         Tag             =   "1388"
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label Label4 
         Caption         =   "Program to run upon defeating enemy:"
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
         Left            =   120
         TabIndex        =   5
         Tag             =   "1387"
         Top             =   1200
         Width           =   4215
      End
   End
End
Attribute VB_Name = "enemyrewards"
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

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        Text3.Text = file
        enemylist(activeEnemyIndex).theData.eneWinPrg = file
    End If
End Sub

Private Sub Form_Load(): On Error Resume Next
    Call infofill
End Sub

Private Sub infofill(): On Error Resume Next
    Text1.Text = CStr(enemylist(activeEnemyIndex).theData.eneExp)
    Text2.Text = CStr(enemylist(activeEnemyIndex).theData.eneGP)
    Text3.Text = enemylist(activeEnemyIndex).theData.eneWinPrg
End Sub

Private Sub Text1_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneExp = val(Text1.Text)
End Sub

Private Sub Text2_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneGP = val(Text2.Text)
End Sub

Private Sub Text3_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneWinPrg = Text3.Text
End Sub

