VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form tiletexturize 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Texturize"
   ClientHeight    =   2175
   ClientLeft      =   45
   ClientTop       =   2445
   ClientWidth     =   2775
   ForeColor       =   &H80000008&
   Icon            =   "texturize.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2175
   ScaleWidth      =   2775
   StartUpPosition =   3  'Windows Default
   Tag             =   "1673"
   Begin VB.CheckBox chkPreview 
      Caption         =   "Preview"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1200
      Width           =   975
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1440
      TabIndex        =   3
      Top             =   1680
      Width           =   1215
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1440
      TabIndex        =   2
      Top             =   1200
      Width           =   1215
   End
   Begin MSComctlLib.Slider sldTexturize 
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   873
      _Version        =   393216
      LargeChange     =   1
      Min             =   1
      Max             =   3
      SelStart        =   1
      Value           =   1
   End
   Begin VB.Label lblStatus 
      Caption         =   "Texturize Light"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1575
   End
End
Attribute VB_Name = "tiletexturize"
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

Private x As Integer, y As Integer

'========================================================================
' sldTexturize_Scroll
'========================================================================
Private Sub sldTexturize_Scroll()
    With lblStatus
        Select Case sldTexturize.value
            Case 1
                .Caption = "Texturize Light"
            Case 2
                .Caption = "Texturize Medium"
            Case 3
                .Caption = "Texturize High"
        End Select
    End With
    
    If chkPreview.value = 1 Then Call Preview(sldTexturize.value)
End Sub

'========================================================================
' The preview checkbox
'========================================================================
Private Sub chkPreview_Click()
    'If they uncheck it, we should turn the tile back to how it was at the start
    If chkPreview.value = 0 Then
        For x = 1 To xRange
            For y = 1 To 32
                If tileMem(x, y) <> -1 Then
                    tileMem(x, y) = tilePreview(x, y)
                End If
            Next y
        Next x
    activeTile.tileRedraw
    'If they check it, preview the tile!
    Else
        Call Preview(sldTexturize.value)
    End If
End Sub

'========================================================================
' The OK button
'========================================================================
Private Sub cmdOK_Click()
    On Error GoTo ErrorHandler
    
    'We only want to redraw the tile again is preview is NOT checked... why? The
    'tile is made with random numbers, so if the user likes the tile he just made (
    'using preview) and then clicks on OK, the tile is texturized again, so it looks
    'different again. We don't want this, so I added the If here.
    If chkPreview.value = 0 Then
        Call Preview(sldTexturize.value)
        activeTile.tileRedraw
    End If
    
    'The user wants to save the changes
    saveChanges = True
    
    Unload Me
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' The cancel button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
    Unload Me
End Sub

'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    'Used to store the current tile for when the "preview" function is used
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                tilePreview(x, y) = tileMem(x, y)
            End If
        Next y
    Next x
    
    'Set the variable to False at the start
    saveChanges = False
    
    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
    'If the user has pressed the X in the form, he doesn't wants to add the changes

    If Not saveChanges Then
    'Use new undo
    Call activeTile.setUndo
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            End If
        Next y
    Next x
    activeTile.tileRedraw
    End If
End Sub

'========================================================================
' Preview the tile
'========================================================================
Sub Preview(level As Integer)
    'Variable declaration:
    Dim aa, redd, greenn, bluee, sr, sg, sb As Long
    
    'Level: 1 - heavy, 2- mid, 3- light
    'Since I'm using a slidebar now, the levels are the other way around (1 is
    'light, 2 is mid, 3 is heavy). Because of this, we'll first change the variables
    If level = 1 Then
        level = 3
    ElseIf level = 3 Then
        level = 1
    End If
    
    'First we need to to set the tile back to how it was at the start
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            End If
        Next y
    Next x

    'Ok that's done, let's preview!
    For x = 1 To xRange Step level
        For y = 1 To 32 Step level
            If tileMem(x, y) <> -1 Then
                aa = tileMem(x, y)
                redd = red(aa)
                aa = tileMem(x, y)
                greenn = green(aa)
                aa = tileMem(x, y)
                bluee = blue(aa)
                sr = Int(Rnd(1) * 80) - 40
                sg = Int(Rnd(1) * 60) - 30
                sb = Int(Rnd(1) * 60) - 30
                redd = redd + sr
                greenn = greenn + sr
                bluee = bluee + sr
                If redd > 255 Then redd = 255
                If redd < 0 Then redd = 0
                If greenn > 255 Then greenn = 255
                If greenn < 0 Then greenn = 0
                If bluee > 255 Then bluee = 255
                If bluee < 0 Then bluee = 0
                tileMem(x, y) = RGB(redd, greenn, bluee)
            End If
        Next y
    Next x
    'Redraw
    Call activeTile.tileRedraw
End Sub
