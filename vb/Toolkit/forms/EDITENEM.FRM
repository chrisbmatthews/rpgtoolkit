VERSION 5.00
Begin VB.Form editenemy 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Enemy (Untitled)"
   ClientHeight    =   5280
   ClientLeft      =   1035
   ClientTop       =   1695
   ClientWidth     =   8580
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
   Icon            =   "EDITENEM.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5280
   ScaleWidth      =   8580
   Tag             =   "5"
   Begin VB.Frame mainFrame 
      Height          =   4935
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8295
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   6000
         ScaleHeight     =   375
         ScaleWidth      =   2175
         TabIndex        =   25
         Top             =   4440
         Width           =   2175
         Begin VB.CommandButton Command6 
            Caption         =   "Add Enemy To Game"
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
            TabIndex        =   26
            Tag             =   "1333"
            Top             =   0
            Width           =   1935
         End
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1695
         Left            =   6360
         ScaleHeight     =   1695
         ScaleWidth      =   1815
         TabIndex        =   20
         Top             =   360
         Width           =   1815
         Begin VB.CommandButton Command1 
            Appearance      =   0  'Flat
            Caption         =   "Graphics..."
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
            TabIndex        =   24
            Tag             =   "1300"
            Top             =   0
            Width           =   1575
         End
         Begin VB.CommandButton Command2 
            Appearance      =   0  'Flat
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
            Height          =   375
            Left            =   0
            TabIndex        =   23
            Tag             =   "1337"
            Top             =   360
            Width           =   1575
         End
         Begin VB.CommandButton Command3 
            Appearance      =   0  'Flat
            Caption         =   "Tactics"
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
            TabIndex        =   22
            Tag             =   "1336"
            Top             =   720
            Width           =   1575
         End
         Begin VB.CommandButton Command4 
            Appearance      =   0  'Flat
            Caption         =   "Rewards"
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
            TabIndex        =   21
            Tag             =   "1335"
            Top             =   1080
            Width           =   1575
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Fighting Conditions                "
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
         TabIndex        =   12
         Tag             =   "1338"
         Top             =   2520
         Width           =   6135
         Begin VB.PictureBox Picture3 
            BorderStyle     =   0  'None
            Height          =   495
            Left            =   4920
            ScaleHeight     =   495
            ScaleWidth      =   1095
            TabIndex        =   27
            Top             =   480
            Width           =   1095
            Begin VB.CommandButton Command7 
               Caption         =   "Browse..."
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
               Left            =   0
               TabIndex        =   28
               Tag             =   "1021"
               Top             =   0
               Width           =   1095
            End
         End
         Begin VB.TextBox rprg 
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
            Left            =   3360
            TabIndex        =   13
            Text            =   "None"
            Top             =   480
            Width           =   1455
         End
         Begin VB.CheckBox Check1 
            Caption         =   "Player can run from this enemy"
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
            TabIndex        =   16
            Tag             =   "1339"
            Top             =   240
            Value           =   1  'Checked
            Width           =   4455
         End
         Begin VB.TextBox eSneak 
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
            Left            =   4080
            TabIndex        =   15
            Text            =   "100"
            Top             =   960
            Width           =   735
         End
         Begin VB.TextBox eSneakYou 
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
            Left            =   4080
            TabIndex        =   14
            Text            =   "100"
            Top             =   1320
            Width           =   735
         End
         Begin VB.Label Label4 
            Caption         =   "Chances of a critical hit on the enemy: (1 in)"
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
            TabIndex        =   19
            Tag             =   "1342"
            Top             =   960
            Width           =   3495
         End
         Begin VB.Label Label5 
            Caption         =   "Chances of a critical hit on the player: (1 in)"
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
            TabIndex        =   18
            Tag             =   "1341"
            Top             =   1320
            Width           =   3855
         End
         Begin VB.Label Label6 
            Caption         =   "Program to run when player runs:"
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
            Left            =   480
            TabIndex        =   17
            Tag             =   "1340"
            Top             =   480
            Width           =   2775
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Basic Info               "
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
         TabIndex        =   1
         Tag             =   "1343"
         Top             =   240
         Width           =   6135
         Begin VB.TextBox edp 
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
            Left            =   2160
            TabIndex        =   6
            Text            =   "0"
            Top             =   1800
            Width           =   2655
         End
         Begin VB.TextBox efp 
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
            Left            =   2160
            TabIndex        =   5
            Text            =   "0"
            Top             =   1440
            Width           =   2655
         End
         Begin VB.TextBox esmp 
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
            Left            =   2160
            TabIndex        =   4
            Text            =   "0"
            Top             =   1080
            Width           =   2655
         End
         Begin VB.TextBox ehp 
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
            Left            =   2160
            TabIndex        =   3
            Text            =   "0"
            Top             =   720
            Width           =   2655
         End
         Begin VB.TextBox ename 
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
            Left            =   2160
            TabIndex        =   2
            Text            =   "None"
            Top             =   360
            Width           =   2655
         End
         Begin VB.Label Label2 
            Caption         =   "Defence Power:"
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
            Index           =   4
            Left            =   120
            TabIndex        =   11
            Tag             =   "1344"
            Top             =   1800
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Fighting Power:"
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
            Left            =   120
            TabIndex        =   10
            Tag             =   "1345"
            Top             =   1440
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Special Move Power:"
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
            Index           =   2
            Left            =   120
            TabIndex        =   9
            Tag             =   "1346"
            Top             =   1080
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Max Health Points:"
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
            TabIndex        =   8
            Tag             =   "1347"
            Top             =   720
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Name:"
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
            TabIndex        =   7
            Tag             =   "1112"
            Top             =   360
            Width           =   1935
         End
      End
   End
   Begin VB.Menu filemnu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu mnuNewProject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuNew 
         Caption         =   "New..."
         Begin VB.Menu mnuNewTile 
            Caption         =   "Tile"
         End
         Begin VB.Menu mnuNewAnimatedTile 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu mnuNewBoard 
            Caption         =   "Board"
         End
         Begin VB.Menu mnuNewPlayer 
            Caption         =   "Player"
         End
         Begin VB.Menu mnuNewItem 
            Caption         =   "Item"
         End
         Begin VB.Menu mnuNewEnemy 
            Caption         =   "Enemy"
         End
         Begin VB.Menu mnuNewRPGCodeProgram 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu mnuNewSpecialMove 
            Caption         =   "Special Move"
         End
         Begin VB.Menu mnuNewStatusEffect 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu mnuNewAnimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnunewTileBitmap 
            Caption         =   "Tile Bitmap"
         End
      End
      Begin VB.Menu sub1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "Open"
         Shortcut        =   ^O
         Tag             =   "1350"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save"
         Shortcut        =   ^S
         Tag             =   "1233"
      End
      Begin VB.Menu mnusaveas 
         Caption         =   "Save As"
         Shortcut        =   ^A
         Tag             =   "1234"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuclose 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnuTestGame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuSelectLanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInstallUpgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnuBuild 
      Caption         =   "Build"
      Begin VB.Menu mnuCreatePakFile 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu mnuMakeEXE 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCreateSetup 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu mnuShowTools 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu mnuShowProjectList 
         Caption         =   "Show/Hide Project List"
      End
   End
   Begin VB.Menu h 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuusersguide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
         Tag             =   "1207"
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuregistrationinfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "editenemy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public dataIndex As Long    'index into the vector of enemies maintained in commonenemy

Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_ENEMY
End Function

Public Sub saveAsFile()
    'saves the file.
    On Error GoTo ErrorHandler
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        Me.Show
        mnusaveas_Click
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub checkSave()
    'check if the file has changed an it needs to be saved...
    On Error GoTo ErrorHandler
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        Dim aa As Long
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub saveFile()

#If (False) Then

    'saves the file.
    On Error GoTo ErrorHandler
    'If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        filename$(2) = enemylist(activeEnemyIndex).eneFile$
        enemylist(activeEnemyIndex).eneNeedUpdate = False
        If filename$(2) = "" Then
            Me.Show
            Call mnusaveas_Click
            Exit Sub
        End If
        Call saveEnemy(projectPath$ + enePath$ + filename$(2), enemylist(activeEnemyIndex).theData)
    'End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next

#Else

    Call Show
    Call mnusave_Click

#End If

End Sub

Public Sub openFile(ByVal file$)
    On Error Resume Next
    'Call checkSave
    activeEnemy.Show
    filename$(1) = file$
    Dim antiPath As String
    antiPath$ = absNoPath(file$)
    FileCopy filename$(1), projectPath$ + enePath$ + antiPath$
    enemylist(activeEnemyIndex).theData = openEnemy(filename$(1))
    enemylist(activeEnemyIndex).eneFile$ = antiPath$
    activeEnemy.Caption = LoadStringLoc(806, "Edit Enemy") + " (" + antiPath$ + ")"
    Call infofill
    enemylist(activeEnemyIndex).eneNeedUpdate = False
End Sub

Private Sub Check1_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneRun = Check1.value
    If enemylist(activeEnemyIndex).theData.eneRun = 0 Then
        Label6.Enabled = False
        rprg.Enabled = False
        Command7.Enabled = False
    Else
        Label6.Enabled = True
        rprg.Enabled = True
        Command7.Enabled = True
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyGfx.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyspecialmoves.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemytactics.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyrewards.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    On Error GoTo ErrorHandler
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        MsgBox LoadStringLoc(995, "Make sure you save your enemy first!")
        Exit Sub
    End If
    editmainfile.Show
    mainfight.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command7_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim antiPath As String
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "Supported Files|*.prg|RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    rprg.Text = antiPath$
    enemylist(activeEnemyIndex).theData.eneRunPrg$ = antiPath$
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub edp_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneDP = val(edp.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub efp_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneFP = val(efp.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub ehp_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneHP = val(ehp.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub ename_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneName$ = ename.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub esmp_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSMP = val(esmp.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub eSneak_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSneakChances = val(eSneak.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub eSneakYou_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSneakUp = val(eSneakYou.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    
    Set activeEnemy = Me
    Set activeForm = Me
    activeEnemyIndex = dataIndex

    hideAllTools

    'extras
    'tkMainForm.animationExtras.Visible = False
    'tkMainForm.bottomFrame.Visible = False
    'tkMainForm.tileExtras.Visible = False
    'tkMainForm.tileBmpExtras.Visible = False
    
    'tools
    'tkMainForm.tilebmpTools.Visible = False
    'tkMainForm.animationTools.Visible = False
    'tkMainForm.rpgcodeTools.Visible = False
    'tkMainForm.tileTools.Visible = False
    'tkMainForm.tileTools.Top = tkMainForm.toolTop
    'tkMainForm.boardTools.Visible = False
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Set activeEnemy = Me
    dataIndex = VectEnemyNewSlot()
    activeEnemyIndex = dataIndex
    Call EnemyClear(enemylist(dataIndex).theData)
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Resize(): On Error Resume Next

    mainFrame.Left = (Me.width - mainFrame.width) / 2
    mainFrame.Top = (Me.Height - mainFrame.Height - 500) / 2

End Sub

Private Sub infofill()
    'Fills in info
    On Error GoTo ErrorHandler
    Dim use As String
    
    If enemylist(activeEnemyIndex).eneFile$ = "" Then use$ = "Untitled" Else use$ = enemylist(activeEnemyIndex).eneFile$
    activeEnemy.Caption = LoadStringLoc(806, "Edit Enemy") + " (" + use$ + ")"
    
    If enemylist(activeEnemyIndex).theData.eneName$ = "" Then
        use$ = LoadStringLoc(1010, "None")
    Else
        use$ = enemylist(activeEnemyIndex).theData.eneName$
    End If
    ename.Text = use$

    ehp.Text = str$(enemylist(activeEnemyIndex).theData.eneHP)
    esmp.Text = str$(enemylist(activeEnemyIndex).theData.eneSMP)
    efp.Text = str$(enemylist(activeEnemyIndex).theData.eneFP)
    edp.Text = str$(enemylist(activeEnemyIndex).theData.eneDP)

    Check1.value = enemylist(activeEnemyIndex).theData.eneRun
    If enemylist(activeEnemyIndex).theData.eneRun = 1 Then
        Label6.Enabled = True
        rprg.Enabled = True
        Command7.Enabled = True
    Else
        Label6.Enabled = False
        rprg.Enabled = False
        Command7.Enabled = False
    End If
    eSneak.Text = str$(enemylist(activeEnemyIndex).theData.eneSneakChances)
    eSneakYou.Text = str$(enemylist(activeEnemyIndex).theData.eneSneakUp)
    
    rprg.Text = enemylist(activeEnemyIndex).theData.eneRunPrg$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

Private Sub mnuCLose_Click()
    On Error GoTo ErrorHandler
    Unload editenemy

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnusave_Click()
    On Error GoTo ErrorHandler
    filename$(2) = enemylist(activeEnemyIndex).eneFile$
    If filename$(2) = "" Then Call mnusaveas_Click: Exit Sub
    Dim strFile As String
    strFile = projectPath & enePath & filename(2)
    If (fileExists(strFile)) Then
        If (GetAttr(strFile) And vbReadOnly) Then
            Call MsgBox("This file is read-only; please choose a different file.")
            Call mnusaveas_Click
            Exit Sub
        End If
    End If
    Call saveEnemy(strFile, enemylist(activeEnemyIndex).theData)
    enemylist(activeEnemyIndex).eneNeedUpdate = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnusaveas_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String, aa As Long, bb As Long
    
    dlg.strDefaultFolder = projectPath$ + enePath$
    
    dlg.strTitle = "Save Enemy As"
    dlg.strDefaultExt = "ene"
    dlg.strFileTypes = "RPG Toolkit Enemy (*.ene)|*.ene|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub

    enemylist(activeEnemyIndex).eneFile$ = antiPath$
    Call mnusave_Click
    ' Call saveEnemy(filename$(1), enemylist(activeEnemyIndex).theData)
    activeEnemy.Caption = LoadStringLoc(806, "Edit Enemy") + " (" + antiPath$ + ")"
    ' enemylist(activeEnemyIndex).eneNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub

Private Sub newEnemy()
    On Error GoTo ErrorHandler
    
    Call EnemyClear(enemylist(activeEnemyIndex).theData)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub toc_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub mnutilehorizontally_Click()
    On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub

Private Sub mnutilevertically_Click()
    On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub


Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

Private Sub mnuAbout_Click()
    On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub

Private Sub mnuArrangeIcons_Click()
    On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub

Private Sub mnuCascade_Click()
    On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub

Private Sub mnucreatepakfile_Click()
    On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub

Private Sub mnucreatesetup_Click()
    On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub

Private Sub mnuexit_Click()
    On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub

Private Sub mnuHistorytxt_Click()
    On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub

Private Sub mnuinstallupgrade_Click()
    On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub

Private Sub mnumakeexe_Click()
    On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub

Private Sub mnunewanimatedtile_Click()
    On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub

Private Sub mnunewanimation_Click()
    On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub

Private Sub mnunewboard_Click()
    On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub

Private Sub mnunewenemy_Click()
    On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub

Private Sub mnunewitem_Click()
    On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub

Private Sub mnunewplayer_Click()
    On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub


Private Sub mnunewproject_Click()
    On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub

Private Sub mnunewrpgcodeprogram_Click()
    On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub

Private Sub mnunewspecialmove_Click()
    On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub


Private Sub mnunewstatuseffect_Click()
    On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub


Private Sub mnunewtile_Click()
    On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub


Private Sub mnunewtilebitmap_Click()
    On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub

Private Sub mnuopen_Click()
    On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub


Private Sub mnuRegistrationInfo_Click()
    On Error Resume Next
    Call tkMainForm.registrationinfomnu_Click
End Sub

Private Sub mnuRPGCodePrimer_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub

Private Sub mnurpgcodereference_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub

Private Sub mnusaveall_Click()
    On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub

Private Sub mnuselectlanguage_Click()
    On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub

Private Sub mnushowprojectlist_Click()
    On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub

Private Sub mnushowtools_Click()
    On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub

Private Sub mnutestgame_Click()
    On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub

Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub

Private Sub rprg_Change()
    On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneRunPrg = rprg.Text
End Sub


