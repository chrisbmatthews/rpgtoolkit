VERSION 5.00
Begin VB.Form runtimeprograms 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Extended Run Time Keys"
   ClientHeight    =   1920
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5520
   Icon            =   "runtimeprograms.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1920
   ScaleWidth      =   5520
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1729"
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   345
      Left            =   4320
      TabIndex        =   9
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Extended Run Time Keys"
      Height          =   1695
      Left            =   120
      TabIndex        =   0
      Tag             =   "1729"
      Top             =   120
      Width           =   4095
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1440
         Left            =   2880
         ScaleHeight     =   1440
         ScaleWidth      =   1095
         TabIndex        =   7
         Top             =   240
         Width           =   1095
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   8
            Tag             =   "1021"
            Top             =   1060
            Width           =   1095
         End
      End
      Begin VB.ComboBox keynum 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox activationkey 
         Height          =   285
         Left            =   1680
         TabIndex        =   2
         Top             =   620
         Width           =   1095
      End
      Begin VB.TextBox runtimep 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   1320
         Width           =   2655
      End
      Begin VB.Label Label2 
         Caption         =   "Activation Key"
         Height          =   375
         Left            =   1680
         TabIndex        =   5
         Tag             =   "1731"
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Key Number"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Tag             =   "1732"
         Top             =   360
         Width           =   1575
      End
      Begin VB.Label Label3 
         Caption         =   "Run Time Program"
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Tag             =   "1730"
         Top             =   1080
         Width           =   1695
      End
   End
End
Attribute VB_Name = "runtimeprograms"
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

Public Property Get formType() As Long: On Error Resume Next
    formType = FT_RUNTIME
End Property

Private Sub activationkey_KeyPress(KeyAscii As Integer): On Error Resume Next
    Dim li As Long, a As String
    
    mainNeedUpdate = True
    li = keynum.ListIndex
    If li = -1 Then li = 0
    
    mainMem.runTimeKeys(li) = KeyAscii
    a = UCase$(chr$(KeyAscii))
    
    Select Case KeyAscii
        Case 32: a = "SPC"
        Case 27: a = "ESC"
        Case 13: a = "ENTR"
    End Select
    
    activationkey.Text = a
    KeyAscii = 0
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload runtimeprograms
End Sub

Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select extended runtime program", "prg", fileTypes, file) Then
        mainMem.runTimePrg(IIf(keynum.ListIndex < 0, 0, keynum.ListIndex)) = file
        runtimep.Text = file
    End If
End Sub

Private Sub Form_Load(): On Error Resume Next
    Dim i As Long, a As String
    
    keynum.clear
    For i = 0 To 50
        keynum.AddItem ("Key " + CStr(i))
    Next i
    
    keynum.ListIndex = 0
    a = UCase$(chr$(mainMem.runTimeKeys(0)))
    
    Select Case mainMem.runTimeKeys(0)
        Case 32: a = "SPC"
        Case 27: a = "ESC"
        Case 13: a = "ENTR"
    End Select
    
    activationkey.Text = a
    runtimep.Text = mainMem.runTimePrg(0)
End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call tkMainForm.refreshTabs
End Sub

Private Sub keynum_Click(): On Error Resume Next
    Dim li As Long, a As String
    
    li = keynum.ListIndex
    If li = -1 Then li = 0
    a = UCase$(chr$(mainMem.runTimeKeys(li)))
    
    Select Case mainMem.runTimeKeys(li)
        Case 32: a = "SPC"
        Case 27: a = "ESC"
        Case 13: a = "ENTR"
    End Select
    
    activationkey.Text = a
    runtimep.Text = mainMem.runTimePrg(li)
End Sub

Private Sub runtimep_Change(): On Error Resume Next
    mainMem.runTimePrg(IIf(keynum.ListIndex < 0, 0, keynum.ListIndex)) = runtimep.Text
End Sub

