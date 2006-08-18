VERSION 5.00
Begin VB.Form editcharsm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Special Moves"
   ClientHeight    =   3585
   ClientLeft      =   1080
   ClientTop       =   1650
   ClientWidth     =   6855
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
   Icon            =   "EDITCHAR.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3585
   ScaleWidth      =   6855
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1095"
   Begin VB.Frame fraHolder 
      Caption         =   "Special Moves"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6615
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         ScaleHeight     =   3015
         ScaleWidth      =   6375
         TabIndex        =   1
         Top             =   240
         Width           =   6375
         Begin VB.CommandButton cmdOK 
            Caption         =   "OK"
            Default         =   -1  'True
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
            Left            =   4920
            TabIndex        =   11
            Top             =   2520
            Width           =   1335
         End
         Begin VB.OptionButton smyes 
            Caption         =   "Yes"
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
            Left            =   3480
            TabIndex        =   8
            Tag             =   "1100"
            Top             =   0
            Value           =   -1  'True
            Width           =   735
         End
         Begin VB.OptionButton smno 
            Caption         =   "No"
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
            Left            =   4320
            TabIndex        =   7
            Tag             =   "1099"
            Top             =   0
            Width           =   735
         End
         Begin VB.TextBox smname 
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
            Text            =   "Sp'l Move"
            Top             =   600
            Width           =   2415
         End
         Begin VB.ListBox smovelist 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1815
            Left            =   0
            TabIndex        =   5
            Top             =   1080
            Width           =   4815
         End
         Begin VB.CommandButton cmdSelect 
            Caption         =   "Select file..."
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
            Left            =   4920
            TabIndex        =   4
            Tag             =   "1098"
            Top             =   1080
            Width           =   1335
         End
         Begin VB.CommandButton cmdDetails 
            Caption         =   "Details..."
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
            Left            =   4920
            TabIndex        =   3
            Tag             =   "1097"
            Top             =   1560
            Width           =   1335
         End
         Begin VB.CommandButton cmdRemove 
            Caption         =   "Remove"
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
            Left            =   4920
            TabIndex        =   2
            Tag             =   "1096"
            Top             =   2040
            Width           =   1335
         End
         Begin VB.Label Label1 
            Caption         =   "Does this character use Special Moves?"
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
            TabIndex        =   10
            Tag             =   "1103"
            Top             =   0
            Width           =   3495
         End
         Begin VB.Label Label3 
            Caption         =   "In-game name of special moves (displayed in the default systems)"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   0
            TabIndex        =   9
            Tag             =   "1102"
            Top             =   480
            Width           =   2415
         End
      End
   End
End
Attribute VB_Name = "editcharsm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

Option Explicit

Private Sub infofill(): On Error Resume Next
    Dim i As Long, idx As Long
    idx = IIf(smovelist.ListIndex < 0, 0, smovelist.ListIndex)
    smovelist.clear
    
    For i = 1 To 200
        smovelist.AddItem (CStr(i) & ": " & IIf(LenB(playerList(activePlayerIndex).theData.smlist(i)), playerList(activePlayerIndex).theData.smlist(i), "None"))
    Next i
    
    smovelist.ListIndex = idx
End Sub
    
Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub cmdSelect_Click(): On Error Resume Next
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1
    
    Dim file As String, fileTypes As String
    fileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & spcPath, "Select special move", "spc", fileTypes, file) Then
        playerList(activePlayerIndex).theData.smlist(playerList(activePlayerIndex).specialMoveNumber) = file
        Call infofill
    End If
End Sub

Private Sub cmdDetails_Click(): On Error Resume Next
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1
    spcmoveinfo.Show vbModal
End Sub

Private Sub cmdRemove_Click(): On Error Resume Next
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1
    playerList(activePlayerIndex).theData.smlist(playerList(activePlayerIndex).specialMoveNumber) = vbNullString
    Call infofill
End Sub

Private Sub Form_Activate(): On Error Resume Next
    Call infofill
End Sub

Private Sub Form_Load(): On Error Resume Next
    Call infofill
    smno.value = playerList(activePlayerIndex).theData.smYN
    smname.Text = playerList(activePlayerIndex).theData.specialMoveName
End Sub

Private Sub smname_Change(): On Error Resume Next
    playerList(activePlayerIndex).theData.specialMoveName = smname.Text
End Sub

Private Sub smno_Click(): On Error Resume Next
    playerList(activePlayerIndex).theData.smYN = 1
End Sub

Private Sub smovelist_DblClick(): On Error Resume Next
    Call cmdSelect_Click
End Sub

Private Sub smyes_Click(): On Error Resume Next
    playerList(activePlayerIndex).theData.smYN = 0
End Sub

