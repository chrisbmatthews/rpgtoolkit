VERSION 5.00
Begin VB.Form ambienteffectform 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ambient Effects"
   ClientHeight    =   1425
   ClientLeft      =   5160
   ClientTop       =   1995
   ClientWidth     =   4440
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
   Icon            =   "Ambiente.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1425
   ScaleWidth      =   4440
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1290"
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   3000
      TabIndex        =   5
      Top             =   480
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1215
      Left            =   120
      ScaleHeight     =   1185
      ScaleWidth      =   2625
      TabIndex        =   0
      Top             =   120
      Width           =   2655
      Begin VB.OptionButton Watery 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Watery"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Tag             =   "1885"
         Top             =   840
         Width           =   1575
      End
      Begin VB.OptionButton darkness 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Darkness"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Tag             =   "1884"
         Top             =   600
         Width           =   1335
      End
      Begin VB.OptionButton fog 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Fog/Mist"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Tag             =   "1883"
         Top             =   360
         Width           =   1575
      End
      Begin VB.OptionButton none 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "None"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Tag             =   "1010"
         Top             =   120
         Width           =   1695
      End
   End
End
Attribute VB_Name = "ambienteffectform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Command1_Click()
    On Error Resume Next
    If none.value = -1 Then boardList(activeBoardIndex).theData.ambientEffect = 0
    If fog.value = -1 Then boardList(activeBoardIndex).theData.ambientEffect = 1
    If darkness.value = -1 Then boardList(activeBoardIndex).theData.ambientEffect = 2
    If Watery.value = -1 Then boardList(activeBoardIndex).theData.ambientEffect = 3
    Call Unload(Me)
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    Call Unload(Me)
End Sub

Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
    Select Case boardList(activeBoardIndex).theData.ambientEffect
        Case 0
            none.value = -1
        Case 1
            fog.value = -1
        Case 2
            darkness.value = -1
        Case 3
            Watery.value = -1
    End Select
End Sub
