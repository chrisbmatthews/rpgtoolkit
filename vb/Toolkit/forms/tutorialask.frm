VERSION 5.00
Begin VB.Form tutorialask 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "RPGToolkit, Version 3.05 Tutorial"
   ClientHeight    =   1650
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   4815
   Icon            =   "tutorialask.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1650
   ScaleWidth      =   4815
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1855"
   Begin VB.CommandButton Command3 
      Caption         =   "Never"
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   1080
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "No"
      Height          =   375
      Left            =   1920
      TabIndex        =   2
      Top             =   1080
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Yes"
      Default         =   -1  'True
      Height          =   375
      Left            =   600
      TabIndex        =   1
      Top             =   1080
      Width           =   1095
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "It seems as if you've never run the tutorial.  Would you like to run it now?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   480
      TabIndex        =   0
      Top             =   240
      Width           =   3855
   End
End
Attribute VB_Name = "tutorialask"
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

'========================================================================
' Yes
'========================================================================
Private Sub Command1_Click()
    On Error Resume Next
    Call Unload(Me)
    configfile.tutCurrentLesson = 1
    Call tkMainForm.tutorialmnu_Click
End Sub

'========================================================================
' No
'========================================================================
Private Sub Command2_Click()
    Call Unload(Me)
End Sub

'========================================================================
' Never
'========================================================================
Private Sub Command3_Click()
    On Error Resume Next
    Call Unload(Me)
    configfile.tutCurrentLesson = 1
    Call MsgBox(LoadStringLoc(993, "You can always run the tutorial by selecting Tutorial from the Help menu."))
End Sub
