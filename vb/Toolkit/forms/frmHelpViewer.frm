VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Begin VB.Form frmHelpViewer 
   ClientHeight    =   5130
   ClientLeft      =   3060
   ClientTop       =   3345
   ClientWidth     =   6540
   Icon            =   "frmHelpViewer.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5130
   ScaleWidth      =   6540
   WindowState     =   2  'Maximized
   Begin SHDocVwCtl.WebBrowser brwWebBrowser 
      Height          =   3735
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5400
      ExtentX         =   9525
      ExtentY         =   6588
      ViewMode        =   1
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   0
      AutoArrange     =   -1  'True
      NoClientEdge    =   -1  'True
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
End
Attribute VB_Name = "frmHelpViewer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
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

'=========================================================================
' TK3 Online Help Viewer
'=========================================================================

Option Explicit

'=========================================================================
' Get type of form
'=========================================================================
Public Property Get formType() As Long
    formType = FT_HELP
End Property

'=========================================================================
' Title bar change
'=========================================================================
Private Sub brwWebBrowser_TitleChange(ByVal Text As String)
    Dim i As Long
    i = InStr(1, Text, "—")
    If (i) Then
        Me.Caption = "Help" & Mid$(Text, i - 1)
    End If
End Sub

'=========================================================================
' Form load
'=========================================================================
Private Sub Form_Load()
    Call brwWebBrowser.Navigate(App.path() & "\help\index.htm")
    Call Show
End Sub

'=========================================================================
' Form resize
'=========================================================================
Private Sub Form_Resize()
    brwWebBrowser.width = Me.ScaleWidth
    brwWebBrowser.Height = Me.ScaleHeight
End Sub
