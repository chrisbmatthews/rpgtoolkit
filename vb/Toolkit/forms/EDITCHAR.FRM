VERSION 5.00
Begin VB.Form editcharsm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Special Moves"
   ClientHeight    =   3660
   ClientLeft      =   1080
   ClientTop       =   1650
   ClientWidth     =   7365
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
   ScaleHeight     =   3660
   ScaleWidth      =   7365
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1095"
   Begin VB.CommandButton Command2 
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
      Height          =   345
      Left            =   120
      TabIndex        =   8
      Tag             =   "1096"
      Top             =   3120
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Special Move Info"
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
      Left            =   5040
      TabIndex        =   7
      Tag             =   "1097"
      Top             =   1680
      Width           =   2175
   End
   Begin VB.CommandButton changemove 
      Appearance      =   0  'Flat
      Caption         =   "Change Special Move"
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
      Left            =   5040
      TabIndex        =   6
      Tag             =   "1098"
      Top             =   1200
      Width           =   2175
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
      Left            =   120
      TabIndex        =   5
      Top             =   1200
      Width           =   4815
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
      Left            =   2880
      TabIndex        =   4
      Text            =   "Sp'l Move"
      Top             =   840
      Width           =   2055
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
      Left            =   3720
      TabIndex        =   2
      Tag             =   "1099"
      Top             =   360
      Width           =   735
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
      Left            =   3720
      TabIndex        =   1
      Tag             =   "1100"
      Top             =   120
      Value           =   -1  'True
      Width           =   735
   End
   Begin VB.Label link1 
      Caption         =   "Also see Special Move Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   735
      Left            =   5160
      MouseIcon       =   "EDITCHAR.frx":0CCA
      MousePointer    =   99  'Custom
      TabIndex        =   9
      Tag             =   "1101"
      Top             =   2760
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label Label3 
      Caption         =   "Official Name Of Special Moves:"
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
      TabIndex        =   3
      Tag             =   "1102"
      Top             =   840
      Width           =   2655
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
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Tag             =   "1103"
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "editcharsm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub changemove_Click()
On Error Resume Next
    If smovelist.ListIndex = -1 Then
        MsgBox LoadStringLoc(953, "Please select a Special Move from the list first!"), 0, LoadStringLoc(954, "Change Special Move")
        Exit Sub
    End If
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1 'Which special move is selected?
    
    'open OPEN box
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + spcPath$
    dlg.strTitle = "Select Special Move"
    dlg.strDefaultExt = "spc"
    dlg.strFileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    If filename$(1) = "" Then Exit Sub
    ChDir (currentDir$)
    
    '!NEW! The variable which holds the currently selected item
    Dim currentcharsm As Integer
    
    '!NEW! Check what the current selected item is
    currentcharsm = smovelist.ListIndex
    
    playerList(activePlayerIndex).theData.smlist$(playerList(activePlayerIndex).specialMoveNumber) = antiPath$
    smovelist.Clear
    FileCopy filename$(1), projectPath$ + spcPath$ + antiPath$
    For listthru = 1 To 200
        smnameit$ = playerList(activePlayerIndex).theData.smlist$(listthru)
        If smnameit$ = "" Then smnameit$ = LoadStringLoc(1010, "None")
        total$ = str$(listthru) + "- " + smnameit$
        smovelist.AddItem (total$)
    Next listthru
    ChDir (currentDir$)
    
    '!NEW! The selected item is now the same as it was before the refresh
    smovelist.ListIndex = currentcharsm
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    If smovelist.ListIndex = -1 Then
        MsgBox LoadStringLoc(953, "Please select a Special Move from the list first!"), 0, LoadStringLoc(954, "Change Special Move")
        Exit Sub
    End If
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1 'Which special move is selected?
    spcmoveinfo.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
On Error Resume Next
    If smovelist.ListIndex = -1 Then
        MsgBox LoadStringLoc(953, "Please select a Special Move from the list first!"), 0, LoadStringLoc(954, "Change Special Move")
        Exit Sub
    End If
    playerList(activePlayerIndex).specialMoveNumber = smovelist.ListIndex + 1 'Which special move is selected?
    playerList(activePlayerIndex).theData.smlist$(playerList(activePlayerIndex).specialMoveNumber) = ""
    smovelist.Clear
    For listthru = 1 To 200
        smnameit$ = playerList(activePlayerIndex).theData.smlist$(listthru)
        If smnameit$ = "" Then smnameit$ = LoadStringLoc(1010, "None")
        total$ = "Special Move" + str$(listthru) + "- " + smnameit$
        smovelist.AddItem (total$)
    Next listthru
End Sub

Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    smovelist.Clear
    For listthru = 1 To 200
        smnameit$ = playerList(activePlayerIndex).theData.smlist$(listthru)
        If smnameit$ = "" Then smnameit$ = LoadStringLoc(1010, "None")
        total$ = str$(listthru) + "- " + smnameit$
        smovelist.AddItem (total$)
    Next listthru


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    smovelist.Clear
    For listthru = 1 To 200
        smnameit$ = playerList(activePlayerIndex).theData.smlist$(listthru)
        If smnameit$ = "" Then smnameit$ = LoadStringLoc(1010, "None")
        total$ = str$(listthru) + "- " + smnameit$
        smovelist.AddItem (total$)
    Next listthru
    smno.value = playerList(activePlayerIndex).theData.smYN
    smname.Text = playerList(activePlayerIndex).theData.specialMoveName$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub link1_Click()
    On Error GoTo ErrorHandler
    activeSpecialMove.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smname_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.specialMoveName$ = smname.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smno_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.smYN = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'!NEW! Makes it easier to edit the special moves
Private Sub smovelist_DblClick()
    Call changemove_Click
End Sub

Private Sub smyes_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.smYN = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

