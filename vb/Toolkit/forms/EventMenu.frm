VERSION 5.00
Begin VB.Form EventMenu 
   Caption         =   "Game Events"
   ClientHeight    =   3990
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7515
   Icon            =   "EventMenu.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   3990
   ScaleWidth      =   7515
   StartUpPosition =   3  'Windows Default
   Tag             =   "1863"
   Begin VB.Frame Frame1 
      Caption         =   "Events Generated For Game"
      Height          =   3615
      Left            =   120
      TabIndex        =   1
      Tag             =   "1866"
      Top             =   120
      Width           =   4815
      Begin VB.ListBox eventlist 
         Height          =   2010
         Left            =   240
         TabIndex        =   2
         Top             =   360
         Width           =   4335
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Caption         =   $"EventMenu.frx":0CCA
         ForeColor       =   &H00808080&
         Height          =   615
         Left            =   240
         TabIndex        =   3
         Tag             =   "1865"
         Top             =   2640
         Width           =   4335
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Create New"
      Height          =   375
      Left            =   5160
      TabIndex        =   0
      Tag             =   "1864"
      Top             =   240
      Width           =   2175
   End
End
Attribute VB_Name = "EventMenu"
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

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Sub FillEventList()
    'fill the event list with the events as indicated in the
    'misc\event.evt file
    'this file doesn't actually do anything except tell us which rpgcode programs
    'have been generated for each event
    'it also keeps track of which conditions have been set by the event system.
    'conditions are numerical variables.
    On Error Resume Next

    Call OpenEventList(projectPath$ + miscPath$ + "event.evt", eventlist)
End Sub


Sub infofill()
    'fill in info for this form
    Call FillEventList
End Sub


Private Sub Command1_Click()
    EventEdit.Show
End Sub

Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    Call infofill
End Sub


