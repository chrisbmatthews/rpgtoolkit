VERSION 5.00
Begin VB.Form skew 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Skew"
   ClientHeight    =   1935
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3735
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   3735
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Caption         =   "Skew"
      Height          =   1695
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2295
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1335
         Left            =   120
         ScaleHeight     =   1335
         ScaleWidth      =   2055
         TabIndex        =   4
         Top             =   240
         Width           =   2055
         Begin VB.OptionButton Option4 
            Caption         =   "Sinusodial Continuous"
            Height          =   195
            Left            =   0
            TabIndex        =   8
            Top             =   600
            Width           =   1935
         End
         Begin VB.OptionButton Option3 
            Caption         =   "Sinusodial Broken"
            Height          =   315
            Left            =   0
            TabIndex        =   7
            Top             =   840
            Width           =   1695
         End
         Begin VB.OptionButton Option2 
            Caption         =   "Linear Broken"
            Height          =   315
            Left            =   0
            TabIndex        =   6
            Top             =   240
            Width           =   1695
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Linear Continuous"
            Height          =   195
            Left            =   0
            TabIndex        =   5
            Top             =   0
            Value           =   -1  'True
            Width           =   1815
         End
      End
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   345
      Left            =   2520
      TabIndex        =   2
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   2520
      TabIndex        =   1
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.CheckBox chkPreview 
      Caption         =   "Preview"
      Height          =   255
      Left            =   2520
      TabIndex        =   0
      Top             =   1200
      Width           =   1095
   End
End
Attribute VB_Name = "skew"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
'!NEW! Declared variables
Option Explicit

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
        Dim x As Integer, y As Integer
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
    Dim x As Integer, y As Integer
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
    Dim x As Integer, y As Integer
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
    Dim xin As Integer, incr As Integer, xx As Integer, yy As Integer, ninety As Integer, disp As Integer, d As Integer
    'First we need to to set the tile back to how it was at the start
    Dim x As Integer, y As Integer
    For x = 1 To 32
        For y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tileMem(x, y) = tilePreview(x, y)
            'End If
        Next y
    Next x

    'Now we need to check which option is checked, and then preview the tile
    If Option1.value = True Then
        'Linear Continuous
        'Buff it
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
            Next y
        Next x
        'Start changing the tile
        incr = 1
        For y = 1 To 32
            For x = 1 To 32
                xx = x + incr: yy = y
                If xx > 32 Then xx = (xx - 32)
                tileMem(xx, yy) = bufTile(x, y)
            Next x
            incr = incr + 1
        Next y
    End If
    
    If Option2.value = True Then
        'Linear Broken
        'Buff it
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
                tileMem(x, y) = -1
            Next y
        Next x
        'Start changing the tile
        incr = 1
        For y = 1 To 32
            For x = 1 To 32
                xx = x + incr: yy = y
                If xx > 32 Then
                Else
                    tileMem(xx, yy) = bufTile(x, y)
                End If
            Next x
            incr = incr + 1
        Next y
    End If
    
    If Option3.value = True Then
        'Sinusodial Continuous
        'Buff it
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
            Next y
        Next x
        'Start changing the tile
        incr = 1
        ninety = 3.14 / 2
        For x = 1 To 32
            d = x * ninety / 32
            disp = Sin(d)
            disp = Int(disp * 32)
            yy = 32
            For y = disp To 32
                tileMem(x, yy) = bufTile(x, y)
                yy = yy - 1
            Next y
            For y = 1 To disp - 1
                tileMem(x, yy) = bufTile(x, y)
                yy = yy - 1
            Next y
        Next x
    End If
    
    If Option4.value = True Then
        'Sinusodial Broken
        'Buff it
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
                tileMem(x, y) = -1
            Next y
        Next x
        'Start changing the tile
        incr = 1
        ninety = 3.14 / 2
        For x = 1 To 32
            d = x * ninety / 32
            disp = Sin(d)
            disp = Int(disp * 32)
            yy = 32
            For y = disp To 32
                yy = yy - 1
            Next y
            For y = 1 To disp - 1
                tileMem(x, yy) = bufTile(x, y)
                yy = yy - 1
            Next y
        Next x
    End If
    'Redraw
    tkMainForm.isoMirror.cls
    activeTile.tileRedraw
End Sub
