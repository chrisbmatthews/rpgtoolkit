VERSION 5.00
Begin VB.Form animationHost 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Animation"
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4950
   Icon            =   "animationHost.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3360
   ScaleWidth      =   4950
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton Command8 
      Appearance      =   0  'Flat
      Caption         =   ">"
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   2400
      Width           =   495
   End
   Begin VB.PictureBox arena 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2655
      Left            =   240
      ScaleHeight     =   175
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   279
      TabIndex        =   0
      Top             =   240
      Width           =   4215
   End
End
Attribute VB_Name = "animationHost"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public file As String
Public repeats As Long

Public Sub playAnimation(ByVal file As String)
    'play an animation
    On Error Resume Next
    Dim anm As TKAnimation
    Call openAnimation(file, anm)
    arena.Width = anm.animSizeX * Screen.TwipsPerPixelX
    arena.Height = anm.animSizeY * Screen.TwipsPerPixelY
    Command8.Top = arena.Top + arena.Height + 30
    Command8.Left = arena.Left
    Me.Width = arena.Width + 700
    If Me.Width < 2000 Then Me.Width = 2000
    Me.Height = arena.Height + Command8.Height + 830
    DoEvents
    Call AnimateAt(anm, 0, 0, anm.animSizeX, anm.animSizeY, arena)
End Sub

Private Sub Command8_Click()
    On Error Resume Next
    If file <> "" Then
        Command8.Enabled = False
        Dim t As Long
        For t = 0 To repeats
            Call playAnimation(file)
        Next t
        Command8.Enabled = True
    End If
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    If file <> "" Then
        Command8.Enabled = False
        Dim t As Long
        For t = 0 To repeats
            Call playAnimation(file)
        Next t
        Command8.Enabled = True
    End If
End Sub
