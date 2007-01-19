VERSION 5.00
Begin VB.Form cutcorner 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cut Corner"
   ClientHeight    =   2025
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3780
   Icon            =   "cutcorner.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   3780
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1215"
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   1215
      Left            =   360
      ScaleHeight     =   1215
      ScaleWidth      =   1815
      TabIndex        =   4
      Top             =   480
      Width           =   1815
      Begin VB.OptionButton Option1 
         Caption         =   "North-East Corner"
         Height          =   255
         Left            =   0
         TabIndex        =   8
         Tag             =   "1220"
         Top             =   0
         Value           =   -1  'True
         Width           =   1935
      End
      Begin VB.OptionButton Option2 
         Caption         =   "North-West Corner"
         Height          =   375
         Left            =   0
         TabIndex        =   7
         Tag             =   "1219"
         Top             =   240
         Width           =   1935
      End
      Begin VB.OptionButton Option3 
         Caption         =   "South-East Corner"
         Height          =   255
         Left            =   0
         TabIndex        =   6
         Tag             =   "1218"
         Top             =   600
         Width           =   1935
      End
      Begin VB.OptionButton Option4 
         Caption         =   "South-West Corner"
         Height          =   375
         Left            =   0
         TabIndex        =   5
         Tag             =   "1217"
         Top             =   840
         Width           =   1935
      End
   End
   Begin VB.CheckBox chkPreview 
      Caption         =   "Preview"
      Height          =   255
      Left            =   2520
      TabIndex        =   3
      Top             =   1200
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   2520
      TabIndex        =   2
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   345
      Left            =   2520
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Cut Corner"
      Height          =   1695
      Left            =   120
      TabIndex        =   1
      Tag             =   "1216"
      Top             =   120
      Width           =   2295
   End
End
Attribute VB_Name = "cutcorner"
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

Dim x As Integer, y As Integer

'========================================================================
' !NEW! The OK button, this was first the command1 button
'========================================================================
Private Sub cmdOK_Click()
    On Error GoTo ErrorHandler
    
    'Since I wrote the preview sub, why not use it here too?
    Call Preview
    
    '!NEW! The user wants to save the changes
    saveChanges = True
    
    Unload Me
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' !NEW! The Cancel button, this was first the command2 button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
    activeTile.tileRedraw
    Unload Me
End Sub

'========================================================================
' !NEW! The preview checkbox
'========================================================================
Private Sub chkPreview_Click()
    'If they uncheck it, we should turn the tile back to how it was at the start
    If chkPreview.value = 0 Then
        For x = 1 To 32
            For y = 1 To 32
                'If tilemem(x, y) <> -1 Then
                    tileMem(x, y) = tilePreview(x, y)
                'End If
            Next y
        Next x
    activeTile.tileRedraw
    'If they check it, preview the tile!
    Else
        Call Preview
    End If
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    
    '!NEW! Used to store the current tile for when the "preview" function is used
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tilePreview(x, y) = tileMem(x, y)
            'End If
        Next y
    Next x
    
    '!NEW! Set the variable to False at the start
    saveChanges = False
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
    'If the user has pressed the X in the form, he doesn't wants to add the changes

    If Not saveChanges Then
    'Use new undo
    Call activeTile.setUndo
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            'End If
        Next y
    Next x
    activeTile.tileRedraw
    End If
End Sub

'========================================================================
' When you click on another option, the tile should be previewed again
'========================================================================
Private Sub Option1_Click()
    If chkPreview.value = 1 Then Call Preview
End Sub

Private Sub Option2_Click()
    If chkPreview.value = 1 Then Call Preview
End Sub

Private Sub Option3_Click()
    If chkPreview.value = 1 Then Call Preview
End Sub

Private Sub Option4_Click()
    If chkPreview.value = 1 Then Call Preview
End Sub

'========================================================================
' !NEW! Previews the tile
'========================================================================
Private Sub Preview()
    'Declare Variables
    Dim xin As Integer
    'First we need to to set the tile back to how it was at the start
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            'End If
        Next y
    Next x
    
    'Now we need to check which option is checked, and then preview the tile
    If Option1.value = True Then
        'North-East
        xin = 2
        For y = 1 To 32
            For x = xin To 32
                tileMem(x, y) = -1
            Next x
            xin = xin + 1
        Next y
    End If
    
    If Option2.value = True Then
        'North-West
        xin = 31
        For y = 1 To 32
            For x = xin To 1 Step -1
                tileMem(x, y) = -1
            Next x
            xin = xin - 1
        Next y
    End If
    
    If Option3.value = True Then
        'South-East
        xin = 2
        For y = 32 To 1 Step -1
            For x = xin To 32
                tileMem(x, y) = -1
            Next x
            xin = xin + 1
        Next y
    End If
    
    If Option4.value = True Then
        'South-West
        xin = 31
        For y = 32 To 1 Step -1
            For x = xin To 1 Step -1
                tileMem(x, y) = -1
            Next x
            xin = xin - 1
        Next y
    End If
    'Redraw
    tkMainForm.isoMirror.Cls
    activeTile.tileRedraw
End Sub




