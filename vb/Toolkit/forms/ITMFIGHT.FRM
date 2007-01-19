VERSION 5.00
Begin VB.Form itmfight 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Battle-Driven Properties"
   ClientHeight    =   2400
   ClientLeft      =   2160
   ClientTop       =   2565
   ClientWidth     =   7785
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
   Icon            =   "ITMFIGHT.frx":0000
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2400
   ScaleWidth      =   7785
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1532"
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
      Left            =   6600
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Battle Driven Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2175
      Left            =   120
      TabIndex        =   1
      Tag             =   "1538"
      Top             =   120
      Width           =   6375
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
         Left            =   3000
         TabIndex        =   13
         Text            =   "None"
         Top             =   1320
         Width           =   2055
      End
      Begin VB.TextBox animation 
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
         Left            =   3000
         TabIndex        =   12
         Text            =   "None"
         Top             =   1680
         Width           =   2055
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   855
         Left            =   5160
         ScaleHeight     =   855
         ScaleWidth      =   1095
         TabIndex        =   9
         Top             =   1200
         Width           =   1095
         Begin VB.CommandButton cmdAnimation 
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
            TabIndex        =   11
            Tag             =   "1021"
            Top             =   480
            Width           =   1095
         End
         Begin VB.CommandButton cmdPrg 
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
            Top             =   120
            Width           =   1095
         End
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
         Left            =   2400
         TabIndex        =   3
         Text            =   "0"
         Top             =   720
         Width           =   495
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
         Left            =   2400
         TabIndex        =   2
         Text            =   "0"
         Top             =   360
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
         TabIndex        =   15
         Tag             =   "1533"
         Top             =   1320
         Width           =   2775
      End
      Begin VB.Label Label7 
         Caption         =   "Animation To Use During Battle: (if item is on right or left hand)"
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
         Index           =   2
         Left            =   480
         TabIndex        =   14
         Tag             =   "1499"
         Top             =   1680
         Width           =   2295
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
         Left            =   3000
         TabIndex        =   8
         Tag             =   "1504"
         Top             =   720
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "SMP of Target Increases By"
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
         Index           =   3
         Left            =   120
         TabIndex        =   7
         Tag             =   "1535"
         Top             =   720
         Width           =   2295
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
         Left            =   3000
         TabIndex        =   6
         Tag             =   "1504"
         Top             =   360
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "Health of Target Increases By"
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
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Tag             =   "1536"
         Top             =   360
         Width           =   2295
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
         Left            =   3840
         TabIndex        =   4
         Tag             =   "1537"
         Top             =   480
         Width           =   1935
      End
   End
End
Attribute VB_Name = "itmfight"
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

Private Sub animation_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.itmAnimation = animation.Text
End Sub

Private Sub cmdPrg_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        equipped.Text = file
        itemList(activeItemIndex).theData.fgtUse = file
    End If
End Sub

Private Sub cmdAnimation_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & miscPath, "Select animation", "anm", fileTypes, file) Then
        animation.Text = file
        itemList(activeItemIndex).theData.itmAnimation = file
    End If
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub equipped_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.fgtUse = equipped.Text
End Sub

Private Sub Form_Load(): On Error Resume Next
    hpup.Text = str$(itemList(activeItemIndex).theData.fgtHPup)
    smup.Text = str$(itemList(activeItemIndex).theData.fgtSMup)
    If LenB(itemList(activeItemIndex).theData.fgtUse) Then equipped.Text = itemList(activeItemIndex).theData.fgtUse
    If LenB(itemList(activeItemIndex).theData.itmAnimation) Then animation.Text = itemList(activeItemIndex).theData.itmAnimation
End Sub

Private Sub hpup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.fgtHPup = val(hpup.Text)
End Sub

Private Sub smup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.fgtSMup = val(smup.Text)
End Sub

