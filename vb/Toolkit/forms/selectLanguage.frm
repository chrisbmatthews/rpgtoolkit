VERSION 5.00
Begin VB.Form selectLanguage 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Language"
   ClientHeight    =   3210
   ClientLeft      =   45
   ClientTop       =   210
   ClientWidth     =   4665
   Icon            =   "selectLanguage.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3210
   ScaleWidth      =   4665
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1891"
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   345
      Left            =   3360
      TabIndex        =   3
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Languages:"
      Height          =   2895
      Left            =   240
      TabIndex        =   1
      Tag             =   "1892"
      Top             =   120
      Width           =   3015
      Begin VB.ListBox langlist 
         Height          =   2010
         Left            =   240
         TabIndex        =   2
         Top             =   480
         Width           =   2535
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   345
      Left            =   3360
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "selectLanguage"
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

Sub infofill()
    'fill in available languages...
    langlist.clear
    'langlist.AddItem ("English (no DB Access, Faster)")
    Dim a As String
    a$ = Dir$(resourcePath$ + "*.lng")
    Do While a$ <> ""
        Call langlist.AddItem(ObtainLanguageName(resourcePath$ + a$))
        a$ = Dir$
    Loop
End Sub


Private Sub Command1_Click()
    On Error Resume Next
    
    Dim idx As Long
    Dim a As String
    Dim cnt As Long
    
    idx = langlist.ListIndex
    If idx = -1 Then
        'default to english
        Call traceString("Change lang to english")
        
        Call ChangeLanguage(resourcePath$ + "0english.lng")
        
        Call traceString("Done change lang to english")
        Unload selectLanguage
        Exit Sub
    Else
        'If idx = 0 Then
        '    'use all default english!
        '    Call ChangeLanguage("default")
        '    Unload selectLanguage
        '    Exit Sub
        'Else
            idx = idx '- 1
            cnt = 0
            a$ = Dir$(resourcePath$ + "*.lng")
            Do While a$ <> ""
                If cnt = idx Then
                    Call traceString("Change lang to " + resourcePath$ + a$)
                    
                    Call ChangeLanguage(resourcePath$ + a$)
                    
                    Call traceString("Done change lang to " + resourcePath$ + a$)
                    Unload selectLanguage
                    Exit Sub
                Else
                    a$ = Dir$
                    cnt = cnt + 1
                End If
            Loop
        'End If
    End If
    Call ChangeLanguage(resourcePath$ + "0english.lng")
    Unload selectLanguage
End Sub

Private Sub Command2_Click()
    Call traceString("Lang selection cancelled")
    Unload selectLanguage
End Sub

Private Sub Form_Load()
    On Error Resume Next
    ' Call LocalizeForm(Me)
    
    Call traceString("About to fill in language box")
    Call infofill
    Call traceString("Done About to fill in language box")
End Sub


Private Sub Label1_Click()

End Sub

Private Sub langlist_DblClick()
    Call Command1_Click
End Sub


