VERSION 5.00
Begin VB.Form newGame 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Create New Game"
   ClientHeight    =   4410
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6945
   Icon            =   "newGame.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4410
   ScaleWidth      =   6945
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1800"
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1080
      TabIndex        =   10
      Tag             =   "1008"
      Top             =   3840
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Setup My Game!"
      Height          =   375
      Left            =   3600
      TabIndex        =   9
      Tag             =   "1801"
      Top             =   3840
      Width           =   2055
   End
   Begin VB.Frame Frame3 
      Caption         =   "Resources"
      Height          =   615
      Left            =   3000
      TabIndex        =   7
      Tag             =   "1802"
      Top             =   2400
      Width           =   3735
      Begin VB.CheckBox Check1 
         Caption         =   "Copy the default files into game"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Tag             =   "1803"
         Top             =   240
         Value           =   1  'Checked
         Width           =   3375
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Game Settings"
      Height          =   975
      Left            =   3000
      TabIndex        =   2
      Tag             =   "1804"
      Top             =   1080
      Width           =   3735
      Begin VB.TextBox folder 
         Height          =   285
         Left            =   1440
         TabIndex        =   6
         Text            =   "You should leave the default!"
         Top             =   600
         Width           =   2175
      End
      Begin VB.TextBox gamett 
         Height          =   285
         Left            =   1440
         TabIndex        =   4
         Text            =   "Enter a title here."
         Top             =   240
         Width           =   2175
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Caption         =   "Game Folder"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Tag             =   "1805"
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label4 
         Alignment       =   1  'Right Justify
         Caption         =   "Game Title"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Tag             =   "1806"
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      Height          =   3375
      Left            =   120
      Picture         =   "newGame.frx":0CCA
      ScaleHeight     =   3315
      ScaleWidth      =   2475
      TabIndex        =   0
      Top             =   240
      Width           =   2535
   End
   Begin VB.Label Label1 
      Caption         =   "This will setup a new game that you can work on.  Please fill out the options below..."
      Height          =   615
      Left            =   3000
      TabIndex        =   1
      Tag             =   "1807"
      Top             =   240
      Width           =   3735
   End
End
Attribute VB_Name = "newGame"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Sub copyDefaults(thepath$)
    'copies basic files into new project...
    On Error Resume Next
    basicdir$ = gamePath$ + "Basic\"
    Call CopyDir(basicdir$ + tilePath$, thepath$ + tilePath$)
    Call CopyDir(basicdir$ + brdPath$, thepath$ + brdPath$)
    Call CopyDir(basicdir$ + temPath$, thepath$ + temPath$)
    Call CopyDir(basicdir$ + spcPath$, thepath$ + spcPath$)
    Call CopyDir(basicdir$ + bkgPath$, thepath$ + bkgPath$)
    Call CopyDir(basicdir$ + mediaPath$, thepath$ + mediaPath$)
    Call CopyDir(basicdir$ + prgPath$, thepath$ + prgPath$)
    Call CopyDir(basicdir$ + fontPath$, thepath$ + fontPath$)
    Call CopyDir(basicdir$ + itmPath$, thepath$ + itmPath$)
    Call CopyDir(basicdir$ + enePath$, thepath$ + enePath$)
    Call CopyDir(basicdir$ + bmpPath$, thepath$ + bmpPath$)
    Call CopyDir(basicdir$ + statusPath$, thepath$ + statusPath$)
    Call CopyDir(basicdir$ + miscPath$, thepath$ + miscPath$)
    Call CopyDir(basicdir$ + pluginPath$, thepath$ + pluginPath$)
End Sub


Private Sub Label2_Click()
    On Error GoTo ErrorHandler


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    On Error GoTo setuperr
    'a = MsgBox("Creating a new game will delete all data currently in memory.  Are you sure?", vbYesNo, "New game")
    a = 6
    If a = 6 Then
        If gamett.Text = "Enter a title here." Or gamett.Text = "" Then
            MsgBox LoadStringLoc(985, "Please give your game a title!")
            Exit Sub
        End If
        Call clearGame    'clear all data
        pt$ = resolve(folder.Text)
        MkDir pt$
        projectPath$ = pt$
        Call makeFolders(projectPath$)
        'mainoption.fileTree1.setPath (projectPath$)
        'mainoption.fileTree1.pathRefresh
        
        oldpath$ = currentDir$ + "\" + projectPath$
        'mainoption.Dir1.path = currentdir$ + "\" + projectPath$
        Call mainoption.TreeView1.Nodes.Clear
        Call tkMainForm.fillTree("", projectPath$)
        
        mainMem.gameTitle$ = gamett.Text             'title of game
        mainoption.Caption = "RPG Toolkit Development System, Version 2.2 (" + gamett.Text + ")"
        tt$ = gamett.Text
        tt$ = replace(tt$, "\", "")
        tt$ = replace(tt$, "/", "")
        tt$ = replace(tt$, ":", "")
        tt$ = replace(tt$, " ", "")
        tt$ = replace(tt$, ".", "")
        tt$ = tt$ + ".gam"
        mainMem.mainScreenType = 1
        Call saveMain(gamPath$ + tt$, mainMem)
        mainfile$ = tt$
        lastProject$ = mainfile$
        Call CopyDir(gamePath$ + "Basic\" + fontPath$, projectPath$ + fontPath$)
        If Check1.value = 1 Then
            'copy default files
            Call copyDefaults(projectPath$)
            ' also set initial board and stuff if defaults are used...
            mainMem.startupPrg$ = "start.prg"              'start up program
            mainMem.menuPlugin = "tk3menu.dll"
            mainMem.fightPlugin = "tk3fight.dll"
            mainMem.menuKey = 13                  'ascii code of menu key
            mainMem.initBoard$ = "start.brd"             'initial board
            mainMem.initChar$ = "start.tem"                'initial character
            mainMem.mainScreenType = 1
            saveMain gamPath$ + tt$, mainMem
        End If
        editmainfile.Show
        Unload newGame
    End If
    Exit Sub
    
setuperr:
    'MsgBox LoadStringLoc(986, "There was a problem creating the game.  Probably, you specified an invalid folder.")
    Resume Next
    Exit Sub
End Sub




Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    Unload newGame

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub

Private Sub gamett_Change()
    On Error GoTo ErrorHandler
    tt$ = gamett.Text
    tt$ = replace(tt$, "\", "")
    tt$ = replace(tt$, "/", "")
    tt$ = replace(tt$, ":", "")
    tt$ = replace(tt$, " ", "")
    tt$ = replace(tt$, ".", "")
    folder.Text = gamePath$ + tt$ + "\"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


