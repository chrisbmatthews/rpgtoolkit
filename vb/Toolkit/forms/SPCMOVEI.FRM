VERSION 5.00
Begin VB.Form spcmoveinfo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Special Move Info"
   ClientHeight    =   2490
   ClientLeft      =   1935
   ClientTop       =   1995
   ClientWidth     =   6750
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
   Icon            =   "SPCMOVEI.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2490
   ScaleWidth      =   6750
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1097"
   Begin VB.Frame Frame1 
      Caption         =   "The Player Can Use This Special Move If:"
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
      Tag             =   "1210"
      Top             =   120
      Width           =   5295
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   840
         ScaleHeight     =   375
         ScaleWidth      =   3855
         TabIndex        =   11
         Top             =   1560
         Width           =   3855
         Begin VB.CommandButton Command1 
            Appearance      =   0  'Flat
            Caption         =   "The Player Can Always Use This Move"
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
            TabIndex        =   12
            Tag             =   "1209"
            Top             =   0
            Width           =   3495
         End
      End
      Begin VB.TextBox minexp 
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
         Left            =   2400
         TabIndex        =   6
         Top             =   360
         Width           =   615
      End
      Begin VB.TextBox minlevel 
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
         Left            =   2400
         TabIndex        =   5
         Top             =   720
         Width           =   615
      End
      Begin VB.TextBox varname 
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
         Left            =   1200
         TabIndex        =   4
         Top             =   1080
         Width           =   1815
      End
      Begin VB.TextBox varequals 
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
         Left            =   3960
         TabIndex        =   3
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Experience Is At Least:"
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
         Index           =   0
         Left            =   120
         TabIndex        =   10
         Tag             =   "1214"
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label2 
         Caption         =   "Or Level Is At Least:"
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
         Index           =   1
         Left            =   120
         TabIndex        =   9
         Tag             =   "1213"
         Top             =   720
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Or Variable:"
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
         Index           =   2
         Left            =   120
         TabIndex        =   8
         Tag             =   "1212"
         Top             =   1080
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Equals:"
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
         Index           =   3
         Left            =   3120
         TabIndex        =   7
         Tag             =   "1211"
         Top             =   1080
         Width           =   615
      End
   End
   Begin VB.CommandButton Command3 
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
      Left            =   5520
      TabIndex        =   1
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
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
      Left            =   5520
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "spcmoveinfo"
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
    minexp.Text = "0"
    minlevel.Text = "0"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.spcMinExp(playerList(activePlayerIndex).specialMoveNumber) = val(minexp.Text)     'minimum experience for each move
    playerList(activePlayerIndex).theData.spcMinLevel(playerList(activePlayerIndex).specialMoveNumber) = val(minlevel.Text)   'min level for each move
    playerList(activePlayerIndex).theData.spcVar$(playerList(activePlayerIndex).specialMoveNumber) = varname.Text       'conditional variable for each special move
    playerList(activePlayerIndex).theData.spcEquals$(playerList(activePlayerIndex).specialMoveNumber) = varequals.Text    'condition of variable for each special move.
    Unload spcmoveinfo

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
Unload spcmoveinfo

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Label1.Caption = LoadStringLoc(2023, "Special Move Info (Move") + str$(playerList(activePlayerIndex).specialMoveNumber) + ")"
    minexp.Text = str$(playerList(activePlayerIndex).theData.spcMinExp(playerList(activePlayerIndex).specialMoveNumber))
    minlevel.Text = str$(playerList(activePlayerIndex).theData.spcMinLevel(playerList(activePlayerIndex).specialMoveNumber))
    varname.Text = playerList(activePlayerIndex).theData.spcVar$(playerList(activePlayerIndex).specialMoveNumber)
    varequals.Text = playerList(activePlayerIndex).theData.spcEquals$(playerList(activePlayerIndex).specialMoveNumber)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

