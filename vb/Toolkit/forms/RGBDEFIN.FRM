VERSION 5.00
Begin VB.Form RGBDefine 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Shade Tile"
   ClientHeight    =   2175
   ClientLeft      =   2010
   ClientTop       =   2445
   ClientWidth     =   5535
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
   Icon            =   "RGBDEFIN.frx":0000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2175
   ScaleWidth      =   5535
   Tag             =   "1673"
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
      Left            =   4080
      TabIndex        =   12
      Top             =   1200
      Width           =   1335
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
      Left            =   4080
      TabIndex        =   11
      Top             =   1680
      Width           =   1335
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
      Left            =   960
      TabIndex        =   10
      Top             =   1440
      Width           =   1575
   End
   Begin VB.PictureBox rgbcol 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   120
      ScaleHeight     =   39
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   39
      TabIndex        =   9
      Top             =   1380
      Width           =   615
   End
   Begin VB.TextBox BlueVal 
      Height          =   285
      Left            =   4920
      TabIndex        =   8
      Top             =   840
      Width           =   495
   End
   Begin VB.TextBox GreenVal 
      Height          =   285
      Left            =   4920
      TabIndex        =   7
      Top             =   480
      Width           =   495
   End
   Begin VB.TextBox RedVal 
      Height          =   285
      Left            =   4920
      TabIndex        =   6
      Top             =   120
      Width           =   495
   End
   Begin VB.HScrollBar BlueScroll 
      Height          =   255
      Left            =   600
      TabIndex        =   2
      Top             =   840
      Width           =   4215
   End
   Begin VB.HScrollBar GreenScroll 
      Height          =   255
      Left            =   600
      TabIndex        =   1
      Top             =   480
      Width           =   4215
   End
   Begin VB.HScrollBar RedScroll 
      Height          =   255
      Left            =   600
      TabIndex        =   0
      Top             =   120
      Width           =   4215
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "Blue"
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
      Left            =   120
      TabIndex        =   5
      Tag             =   "1076"
      Top             =   840
      Width           =   375
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Green"
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
      Left            =   0
      TabIndex        =   4
      Tag             =   "1077"
      Top             =   480
      Width           =   495
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Red"
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
      Left            =   120
      TabIndex        =   3
      Tag             =   "1078"
      Top             =   120
      Width           =   375
   End
End
Attribute VB_Name = "RGBDefine"
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
'    - Sander Knape
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
Dim rr As Integer, gg As Integer, bb As Integer

'========================================================================
' RedScroll_Change
'========================================================================
Private Sub RedScroll_Change()
    On Error GoTo ErrorHandler
    'Change the text of the textbox
    RedVal.Text = str$(RedScroll.value)
    'Change the color of the picturebox
    Call vbPicFillRect(rgbcol, 0, 0, 100, 100, RGB(Abs(RedScroll.value), Abs(GreenScroll.value), Abs(BlueScroll.value)))
    
    '!NEW! If the checkbox is checked, let's preview the tile
    If chkPreview.value = 1 Then Call Preview

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' RedVal_Change (The textbox behind the red scroll)
'========================================================================
Private Sub RedVal_Change()
    On Error GoTo ErrorHandler
    'Change the textbox values when needed
    If val(RedVal.Text) > 255 Then RedVal.Text = 255
    If val(RedVal.Text) < -255 Then RedVal.Text = -255
    'Change the value of the scroll
    RedScroll.value = val(RedVal.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' GreenScroll_Change
'========================================================================
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub GreenScroll_Change()
    On Error GoTo ErrorHandler
    'Change the text of the textbox
    GreenVal.Text = str$(GreenScroll.value)
    'Change the color of the picturebox
    Call vbPicFillRect(rgbcol, 0, 0, 100, 100, RGB(Abs(RedScroll.value), Abs(GreenScroll.value), Abs(BlueScroll.value)))

    '!NEW! If the checkbox is checked, let's preview the tile
    If chkPreview.value = 1 Then Call Preview

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' GreenVal_Change (The textbox behind the green scroll)
'========================================================================
Private Sub GreenVal_Change()
    On Error GoTo ErrorHandler
    'Change the textbox values when needed
    If val(GreenVal.Text) > 255 Then GreenVal.Text = 255
    If val(GreenVal.Text) < -255 Then GreenVal.Text = -255
    'Change the value of the scroll
    GreenScroll.value = val(GreenVal.Text)

    '!NEW! If the checkbox is checked, let's preview the tile
    If chkPreview.value = 1 Then
        Call Preview
    End If
    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' BlueScroll_Change
'========================================================================
Private Sub BlueScroll_Change()
    On Error GoTo ErrorHandler
    'Change the text of the textbox
    BlueVal.Text = str$(BlueScroll.value)
    'Change the color of the picturebox
    Call vbPicFillRect(rgbcol, 0, 0, 100, 100, RGB(Abs(RedScroll.value), Abs(GreenScroll.value), Abs(BlueScroll.value)))
    
    '!NEW! If the checkbox is checked, let's preview the tile
    If chkPreview.value = 1 Then Call Preview
    
    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' BlueVal_Change (The textbox behind the blue scroll)
'========================================================================
Private Sub BlueVal_Change()
    On Error GoTo ErrorHandler
    'Change the textbox values when needed
    If val(BlueVal.Text) > 255 Then BlueVal.Text = 255
    If val(BlueVal.Text) < -255 Then BlueVal.Text = 255
    'Change the value of the scroll
    BlueScroll.value = val(BlueVal.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' !NEW! The preview checkbox
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
        'Redraw tile
        activeTile.tileRedraw
    'If they check it, preview the tile!
    Else
        Call Preview
    End If
End Sub

'========================================================================
' !Edited! First was the "Shade Tile" button, it's the OK button now
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
' !NEW! The cancel button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
    activeTile.tileRedraw
    Unload Me
End Sub
'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    RedScroll.max = 255
    RedScroll.min = -255
    GreenScroll.max = 255
    GreenScroll.min = -255
    BlueScroll.max = 255
    BlueScroll.min = -255
    RedVal.Text = "0"
    GreenVal.Text = "0"
    BlueVal.Text = "0"
    Call vbPicFillRect(rgbcol, 0, 0, 100, 100, RGB(0, 0, 0))
    
    '!NEW! Used to store the current tile for when the "preview" function is used
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                tilePreview(x, y) = tileMem(x, y)
            End If
        Next y
    Next x
    
     '!NEW! Set the variable to False at the start
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
' !NEW! Previews the tile
'========================================================================
Private Sub Preview()
    'First we need to to set the tile back to how it was at the start
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            End If
        Next y
    Next x
    
    'Ok, let's preview it now!
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                rr = red(tileMem(x, y))
                gg = green(tileMem(x, y))
                bb = blue(tileMem(x, y))
                rr = rr + RedScroll.value
                gg = gg + GreenScroll.value
                bb = bb + BlueScroll.value
                If rr > 255 Then rr = 255
                If rr < 0 Then rr = 0
                If gg > 255 Then gg = 255
                If gg < 0 Then gg = 0
                If bb > 255 Then bb = 255
                If bb < 0 Then bb = 0
                tileMem(x, y) = RGB(rr, gg, bb)
            End If
        Next y
    Next x
    'Redraw
    activeTile.tileRedraw
End Sub

