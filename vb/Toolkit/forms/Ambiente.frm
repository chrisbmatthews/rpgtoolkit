VERSION 5.00
Begin VB.Form ambienteffectform 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ambient Effects"
   ClientHeight    =   1710
   ClientLeft      =   5160
   ClientTop       =   1890
   ClientWidth     =   4290
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
   ScaleHeight     =   1710
   ScaleWidth      =   4290
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1290"
   Begin VB.Frame Frame1 
      Caption         =   "Ambient Effects Menu"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   120
      TabIndex        =   2
      Tag             =   "1886"
      Top             =   120
      Width           =   2655
      Begin VB.OptionButton none 
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
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Tag             =   "1010"
         Top             =   240
         Width           =   2175
      End
      Begin VB.OptionButton fog 
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
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Tag             =   "1883"
         Top             =   480
         Width           =   2295
      End
      Begin VB.OptionButton darkness 
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
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Tag             =   "1884"
         Top             =   720
         Width           =   2415
      End
      Begin VB.OptionButton Watery 
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
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Tag             =   "1885"
         Top             =   960
         Width           =   2415
      End
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
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
      Height          =   345
      Left            =   3000
      TabIndex        =   1
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
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
      Height          =   345
      Left            =   3000
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
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
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command1_Click()
    On Error GoTo errorhandler
    If none.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 0
    If fog.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 1
    If darkness.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 2
    If Watery.value = -1 Then boardList(activeBoardIndex).theData.ambienteffect = 3
    Unload ambienteffectform

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    Unload ambienteffectform

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
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


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

