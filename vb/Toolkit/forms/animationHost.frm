VERSION 5.00
Begin VB.Form animationHost 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Animation"
   ClientHeight    =   3540
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4455
   Icon            =   "animationHost.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3540
   ScaleWidth      =   4455
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox Command8 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   442
      Left            =   240
      MousePointer    =   99  'Custom
      Picture         =   "animationHost.frx":0CCA
      ScaleHeight     =   405
      ScaleWidth      =   435
      TabIndex        =   2
      Top             =   2640
      Width           =   465
   End
   Begin Toolkit.TKTopBar topBar 
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   847
      Object.Width           =   3885
      Caption         =   "Animation"
   End
   Begin VB.PictureBox arena 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2655
      Left            =   120
      ScaleHeight     =   175
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   279
      TabIndex        =   0
      Top             =   480
      Width           =   4215
   End
   Begin VB.Shape shape 
      Height          =   3255
      Left            =   0
      Top             =   0
      Width           =   4455
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
       
    arena.width = anm.animSizeX * Screen.TwipsPerPixelX
    arena.height = anm.animSizeY * Screen.TwipsPerPixelY
    
    Command8.Top = arena.Top + arena.height + 30
    Command8.Left = arena.Left
    
    Me.width = arena.width + 700
    If Me.width < 2000 Then Me.width = 2000
    Me.height = arena.height + Command8.height + 830
       
    shape.width = Me.width
    shape.height = Me.height
    
    TopBar.width = Me.width - 50
    
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

Private Sub Form_Load()
    Set TopBar.theForm = Me
    Command8.MouseIcon = Images.MouseLink()
End Sub
