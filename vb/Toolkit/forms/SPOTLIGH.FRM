VERSION 5.00
Begin VB.Form spotlighting 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Spot Lighting"
   ClientHeight    =   2505
   ClientLeft      =   3225
   ClientTop       =   2700
   ClientWidth     =   5460
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
   Icon            =   "SPOTLIGH.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2505
   ScaleWidth      =   5460
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1755"
   Begin VB.Frame Frame1 
      Caption         =   "Spot Lighting"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2175
      Left            =   120
      TabIndex        =   2
      Tag             =   "1755"
      Top             =   120
      Width           =   3975
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   735
         Left            =   240
         ScaleHeight     =   735
         ScaleWidth      =   3615
         TabIndex        =   8
         Top             =   360
         Width           =   3615
         Begin VB.OptionButton slightoff 
            Caption         =   "Turn Spot Lighting Off"
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
            Left            =   0
            TabIndex        =   10
            Tag             =   "1756"
            Top             =   240
            Value           =   -1  'True
            Width           =   2295
         End
         Begin VB.OptionButton slighton 
            Caption         =   "Turn Spot Lighting On"
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
            TabIndex        =   9
            Tag             =   "1757"
            Top             =   0
            Width           =   2415
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Spot Light Options"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   120
         TabIndex        =   3
         Tag             =   "1760"
         Top             =   1200
         Width           =   3735
         Begin VB.TextBox lightradius 
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
            Left            =   840
            TabIndex        =   5
            Text            =   "2"
            Top             =   360
            Width           =   375
         End
         Begin VB.TextBox fadepercent 
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
            Left            =   2880
            TabIndex        =   4
            Text            =   "100"
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label3 
            Caption         =   "Radius"
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
            TabIndex        =   7
            Tag             =   "1759"
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label4 
            Alignment       =   1  'Right Justify
            Caption         =   "Fade (%)"
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
            Left            =   1320
            TabIndex        =   6
            Tag             =   "1758"
            Top             =   360
            Width           =   1335
         End
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
      Left            =   4200
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
      Left            =   4200
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "spotlighting"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    If slighton.value = -1 Then boardList(activeBoardIndex).spotLight = 1
    If slightoff.value = -1 Then boardList(activeBoardIndex).spotLight = 0
    boardList(activeBoardIndex).spotLightRadius = val(lightradius.Text)
    boardList(activeBoardIndex).percentFade = val(fadepercent.Text)
    Unload spotlighting

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    Unload spotlighting

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    If boardList(activeBoardIndex).spotLight = 1 Then slighton.value = -1: slightoff.value = 0
    If boardList(activeBoardIndex).spotLight = 0 Then slightoff.value = -1: slighton.value = 0
    lightradius.Text = str$(boardList(activeBoardIndex).spotLightRadius)
    fadepercent.Text = str$(boardList(activeBoardIndex).percentFade)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    If boardList(activeBoardIndex).spotLight = 1 Then slighton.value = -1: slightoff.value = 0
    If boardList(activeBoardIndex).spotLight = 0 Then slightoff.value = -1: slighton.value = 0
    lightradius.Text = str$(boardList(activeBoardIndex).spotLightRadius)
    fadepercent.Text = str$(boardList(activeBoardIndex).percentFade)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

