VERSION 5.00
Begin VB.Form Version1Palette 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "DOS Color Palette (16 Colors)"
   ClientHeight    =   2400
   ClientLeft      =   2775
   ClientTop       =   2430
   ClientWidth     =   4320
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
   Icon            =   "VERSION1.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2400
   ScaleWidth      =   4320
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1842"
   Begin VB.TextBox colCode 
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
      Left            =   2640
      TabIndex        =   3
      Top             =   1200
      Width           =   1455
   End
   Begin VB.CommandButton selectDosCol 
      Appearance      =   0  'Flat
      Caption         =   "Close"
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
      Left            =   3120
      TabIndex        =   0
      Tag             =   "1088"
      Top             =   120
      Width           =   1095
   End
   Begin VB.PictureBox dosCurrentCol 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   3480
      ScaleHeight     =   39
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   39
      TabIndex        =   2
      Top             =   1680
      Width           =   615
   End
   Begin VB.PictureBox dosPal 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   2415
      Left            =   0
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   159
      TabIndex        =   1
      Top             =   0
      Width           =   2415
   End
   Begin VB.Label Label1 
      Caption         =   "Color Code:"
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
      Left            =   2640
      TabIndex        =   4
      Tag             =   "1843"
      Top             =   960
      Width           =   1455
   End
End
Attribute VB_Name = "Version1Palette"
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

Private Sub colcode_Change()
    On Error Resume Next
    If val(colCode.Text) > 255 Then colCode.Text = "255"
    If val(colCode.Text) < 0 Then colCode.Text = "0"
    Call vbPicFillRect(dosCurrentCol, 0, 0, 100, 100, GFXGetDOSColor(val(colCode.Text)))
    openTileEditorDocs(activeTile.indice).currentColor = GFXGetDOSColor(val(colCode.Text))
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(activeTile.indice).currentColor)
End Sub

Private Sub dospal_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error Resume Next
    Dim xx As Long, yy As Long, theColor As Long
    xx = Int((x / 10))
    yy = Int((y / 10))
    theColor = yy * 16 + xx
    Call vbPicFillRect(dosCurrentCol, 0, 0, 100, 100, GFXGetDOSColor(theColor))
    colCode.Text = str(theColor)
    openTileEditorDocs(activeTile.indice).currentColor = GFXGetDOSColor(theColor)
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(activeTile.indice).currentColor)
    If detail <> 1 And detail <> 2 Then
        If detail = 3 Or detail = 4 Then
            openTileEditorDocs(activeTile.indice).currentColor = theColor
        ElseIf detail = 5 Or detail = 6 Then
            openTileEditorDocs(activeTile.indice).currentColor = toColor(openTileEditorDocs(activeTile.indice).currentColor, 16)
        End If
        Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, GFXGetDOSColor(openTileEditorDocs(activeTile.indice).currentColor))
    End If
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    Dim x As Long, y As Long
    Dim xx As Long, yy As Long
    Dim color As Long
    For yy = 0 To 15
        For xx = 0 To 15
            Call vbPicFillRect(dosPal, xx * 10, yy * 10, xx * 10 + 8, yy * 10 + 8, GFXGetDOSColor(color))
            color = color + 1
        Next xx
    Next yy
    Call vbPicRefresh(dosPal)
End Sub

Private Sub Form_Load()
    On Error Resume Next
    ' Call LocalizeForm(Me)
End Sub

Private Sub selectdoscol_Click()
    On Error Resume Next
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(activeTile.indice).currentColor)
    Unload Me
End Sub
