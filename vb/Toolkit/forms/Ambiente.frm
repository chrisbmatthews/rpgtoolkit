VERSION 5.00
Begin VB.Form ambienteffectform 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Ambient Effects"
   ClientHeight    =   1935
   ClientLeft      =   5115
   ClientTop       =   1560
   ClientWidth     =   3870
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
   ScaleHeight     =   1935
   ScaleWidth      =   3870
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1290"
   Begin Toolkit.TKButton Command1 
      Height          =   375
      Left            =   2880
      TabIndex        =   6
      Top             =   600
      Width           =   735
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   847
      Object.Width           =   2775
      Caption         =   "Ambient Effects"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
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
      Height          =   1335
      Left            =   120
      TabIndex        =   0
      Tag             =   "1886"
      Top             =   480
      Width           =   2655
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
         TabIndex        =   4
         Tag             =   "1010"
         Top             =   240
         Width           =   2175
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
         TabIndex        =   3
         Tag             =   "1883"
         Top             =   480
         Width           =   2295
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
         TabIndex        =   2
         Tag             =   "1884"
         Top             =   720
         Width           =   2415
      End
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
         TabIndex        =   1
         Tag             =   "1885"
         Top             =   960
         Width           =   2415
      End
   End
   Begin VB.Shape Shape1 
      Height          =   1935
      Left            =   0
      Top             =   0
      Width           =   3855
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

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Option Explicit added
'
'=======================================================

Option Explicit

Private Sub Command1_Click()
    On Error Resume Next
    If none.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 0
    If fog.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 1
    If darkness.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 2
    If Watery.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 3
    Call Unload(Me)
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    Call Unload(Me)
End Sub

Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
    Set TopBar.theForm = Me
    Select Case boardList(activeBoardIndex).theData.ambienteffect
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
