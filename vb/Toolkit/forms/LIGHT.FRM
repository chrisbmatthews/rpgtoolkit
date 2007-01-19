VERSION 5.00
Begin VB.Form light 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Define Light Source"
   ClientHeight    =   5115
   ClientLeft      =   1830
   ClientTop       =   1650
   ClientWidth     =   6495
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
   Icon            =   "LIGHT.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5115
   ScaleWidth      =   6495
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1784"
   Begin VB.CommandButton cmdOK 
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
      Height          =   375
      Left            =   5040
      TabIndex        =   7
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CheckBox chkPreview 
      Caption         =   "Preview"
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
      Left            =   5040
      TabIndex        =   6
      Top             =   1920
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
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
      Left            =   5040
      TabIndex        =   5
      Top             =   2880
      Width           =   1215
   End
   Begin VB.PictureBox ldir 
      AutoRedraw      =   -1  'True
      Height          =   1140
      Left            =   5040
      ScaleHeight     =   101.408
      ScaleMode       =   0  'User
      ScaleWidth      =   97.468
      TabIndex        =   1
      Top             =   360
      Width           =   1215
   End
   Begin VB.PictureBox tileform 
      AutoRedraw      =   -1  'True
      Height          =   4880
      Left            =   120
      MousePointer    =   2  'Cross
      ScaleHeight     =   321
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   309
      TabIndex        =   0
      Top             =   120
      Width           =   4695
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Click on the picture to define where obstructions to light are, then click on Apply Light"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   2760
      TabIndex        =   4
      Tag             =   "1786"
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Light Direction:"
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
      Left            =   5040
      TabIndex        =   3
      Tag             =   "1787"
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label angtext 
      Caption         =   "0-- 25"
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
      Left            =   5040
      TabIndex        =   2
      Tag             =   "1788"
      Top             =   1560
      Width           =   1215
   End
End
Attribute VB_Name = "light"
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

Dim x As Integer, y As Integer, t As Integer, xx As Integer, yy As Integer

'========================================================================
' The OK button, this was first Command3.
'========================================================================
Private Sub cmdOK_Click()
On Error Resume Next
    'Since I added the Preview sub, why not use it here too?
    Call Preview
    
    '!NEW! The user wants to save the changes
    saveChanges = True
    
    Unload Me
End Sub

'========================================================================
' !NEW! The cancel button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
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
                If tileMem(x, y) <> -1 Then
                    tileMem(x, y) = tilePreview(x, y)
                End If
            Next y
        Next x
    activeTile.tileRedraw
    'If they check it, preview the tile!
    Else
        Call Preview
    End If
End Sub

'========================================================================
' Drawbox
'========================================================================
Private Sub drawbox(x, y)
    On Error GoTo ErrorHandler
    If detail = 1 Or detail = 3 Or detail = 4 Then
        For t = 1 To 8 Step 2
            Call vbPicLine(tileform, x + t, y, x + t, y + 8, vbQBColor(9))
        Next t
    Else
        For t = 1 To 16 Step 2
            Call vbPicLine(tileform, x + t, y, x + t, y + 16, vbQBColor(9))
        Next t
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Drawright
'========================================================================
Private Sub drawright(x, y, sx, sy)
    On Error GoTo ErrorHandler
    
    '!NEW! Declared variable
    Dim col As Long
    
    col = tilePreview(x, y)
    
    If col = -1 Then col = vbQBColor(1)
    If detail = 1 Or detail = 3 Or detail = 4 Then
        Call vbPicFillRect(tileform, sx, sy, sx + 8, sy + 8, col)
    Else
        Call vbPicFillRect(tileform, sx, sy, sx + 16, sy + 16, col)
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Load()
'========================================================================
Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    '!NEW! Set the variable to False at the start...
    saveChanges = False
    If detail = 1 Or detail = 3 Or detail = 5 Then Call highRedrawLight
    If detail = 2 Or detail = 3 Or detail = 5 Then Call lowRedrawLight
    
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = 0
        Next y
    Next x
    
    For t = 1 To 10
        Call vbPicCircle(ldir, 50, 50, 35 + t, RGB(0, 0, 100 + t * 10))
    Next t
    
    Call vbPicCircle(ldir, 50, 50, 3, 0)
    openTileEditorDocs(activeTile.indice).angle = 0
    openTileEditorDocs(activeTile.indice).lightLength = 25
    Call vbPicLine(ldir, 50, 50, 75, 50, 0)
    
    '!NEW! Used to store the current tile for when the "preview" function is used
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tilePreview(x, y) = tileMem(x, y)
            'End If
        Next y
    Next x
    
    '!NEW! Set the variable to False at the start...
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
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
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
    'Redraw
    activeTile.tileRedraw
    End If
End Sub

'========================================================================
' ldir_MouseDown
'========================================================================
Private Sub ldir_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    'now find openTileEditorDocs(activeTile.indice).angle
    'Hypotenuse length
    '!NEW! Declared variables
    Dim Length, adj, inv, ang, a As Integer
    
    On Error GoTo ErrorHandler
    If x = 50 Or y = 50 Then Exit Sub
    Length = Sqr((x - 50) ^ 2 + (y - 50) ^ 2)
    openTileEditorDocs(activeTile.indice).lightLength = Int(Length)
    adj = x - 50
    inv = adj / Length
    'This mess is the arccos:
    ang = Atn(-inv / Sqr(-inv * inv + 1)) + 1.5708
    'convert to degrees
    openTileEditorDocs(activeTile.indice).angle = Int((ang * 180) / 3.14)
    If y > 50 Then
        a = 180 - openTileEditorDocs(activeTile.indice).angle
        openTileEditorDocs(activeTile.indice).angle = 180 + a
    End If
    angtext.Caption = str$(openTileEditorDocs(activeTile.indice).angle) + "--" + str$(openTileEditorDocs(activeTile.indice).lightLength)
    Call vbPicFillRect(ldir, 0, 0, 1000, 1000, vbQBColor(15))
    For t = 1 To 10
        Call vbPicCircle(ldir, 50, 50, 35 + t, RGB(0, 0, 100 + t * 10))
    Next t
    Call vbPicCircle(ldir, 50, 50, 3, 0)
    Call vbPicLine(ldir, 50, 50, x, y, 0)
    
    '!NEW! If preview is checked, preview the tile
    If chkPreview.value = 1 Then Call Preview
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' tileform_MouseDown
'========================================================================
Private Sub tileform_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo ErrorHandler
    '!NEW! Declared variables
    Dim newX, newY As Integer
    
    xx = Int(x / 10)
    yy = Int(y / 10)
    If xx > (xRange - 1) Or yy > 31 Then Exit Sub
    newX = (xx * 10) + 1
    newY = (yy * 10) + 1

    xx = xx + 1: yy = yy + 1
    If bufTile(xx, yy) = 0 Then
        bufTile(xx, yy) = 1
        Call drawbox(newX, newY)
    Else
        bufTile(xx, yy) = 0
        Call drawright(xx, yy, newX, newY)
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' tileform_MouseMove
'========================================================================
Private Sub tileform_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo ErrorHandler
    If Button = 1 Then
        Call tileform_MouseDown(Button, Shift, x, y)
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' !NEW! tileform_MouseUp
'========================================================================
Private Sub tileform_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    'If preview is checked, preview the tile
    If chkPreview.value = 1 Then Call Preview
End Sub

'========================================================================
' !NEW! Previews the tile
'========================================================================
Sub Preview()
    '!NEW! Declared variables
    Dim max, st, rad, a, r, g, b, darken As Long
    
    'These 2 variables are giving me problems... whatever variable I change
    'them too, they always give me an error.
    Dim newX, newY As Variant
    
    'First we need to to set the tile back to how it was at the start
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            'End If
        Next y
    Next x

    'The code which adds the light effects to the tile
    For x = 1 To 32
        For y = 1 To 32
            If bufTile(x, y) = 1 Then
                max = 0.32 * openTileEditorDocs(activeTile.indice).lightLength
                st = max
                For t = 1 To max
                    rad = (openTileEditorDocs(activeTile.indice).angle * 3.14) / 180
                    xx = Cos(rad) * t
                    yy = Sin(rad) * t
                    newX = x + xx
                    newY = y + yy
                    If newX > xRange Then
                        newX = newX - xRange
                    End If
                    If newY > xRange Then
                        newY = newY - xRange
                    End If
                    'Debug.Print "newX: " & newX & ". newY: " & newY
                    a = tileMem(newX, newY)
                    
                    '!EDIT! Edited these lines here, check the documentation for my reason
                    If a <> -1 Then
                        r = red(a)
                        a = tileMem(newX, newY)
                    End If
                    
                    If a <> -1 Then
                        g = green(a)
                        a = tileMem(newX, newY)
                    End If
                    
                    If a <> -1 Then
                        b = blue(a)
                        darken = st * 10
                        st = st - 1
                        r = inBounds(r - darken, 0, 255)
                        g = inBounds(g - darken, 0, 255)
                        b = inBounds(b - darken, 0, 255)
                    
                        tileMem(newX, newY) = RGB(r, g, b)
                    End If
                    'Edit until here
                    
                Next t
            End If
        Next y
    Next x
    'Redraw
    activeTile.tileRedraw
End Sub
