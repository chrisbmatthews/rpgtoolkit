VERSION 5.00
Begin VB.Form editstatus 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Status Effect Editor (Untitled)"
   ClientHeight    =   5550
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   5715
   Icon            =   "editstatus.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5550
   ScaleWidth      =   5715
   Tag             =   "9"
   Begin VB.Frame mainFrame 
      Height          =   5295
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5415
      Begin VB.Frame Frame1 
         Caption         =   "General Info"
         Height          =   1575
         Left            =   120
         TabIndex        =   15
         Tag             =   "1484"
         Top             =   240
         Width           =   5175
         Begin VB.TextBox statusnamebox 
            Height          =   285
            Left            =   2160
            TabIndex        =   17
            Top             =   360
            Width           =   2655
         End
         Begin VB.TextBox roundsbox 
            Height          =   285
            Left            =   2160
            TabIndex        =   16
            Text            =   "0"
            Top             =   840
            Width           =   2655
         End
         Begin VB.Label Label1 
            Caption         =   "Status Effect Name:"
            Height          =   375
            Left            =   120
            TabIndex        =   19
            Tag             =   "1486"
            Top             =   360
            Width           =   2055
         End
         Begin VB.Label Label5 
            Caption         =   "Number of Rounds Until Effect is Removed:"
            Height          =   615
            Left            =   120
            TabIndex        =   18
            Tag             =   "1485"
            Top             =   840
            Width           =   2055
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Effects"
         Height          =   3015
         Left            =   120
         TabIndex        =   2
         Tag             =   "1475"
         Top             =   2040
         Width           =   5175
         Begin VB.CheckBox speedupbox 
            Caption         =   "Speed Target Charge Time"
            Height          =   255
            Left            =   240
            TabIndex        =   12
            Tag             =   "1481"
            Top             =   360
            Width           =   3975
         End
         Begin VB.CheckBox slowdownbox 
            Caption         =   "Slow Target Charge Time"
            Height          =   255
            Left            =   240
            TabIndex        =   11
            Tag             =   "1480"
            Top             =   720
            Width           =   4095
         End
         Begin VB.CheckBox removehpbox 
            Caption         =   "Remove HP"
            Height          =   255
            Left            =   240
            TabIndex        =   10
            Tag             =   "1479"
            Top             =   1440
            Width           =   1575
         End
         Begin VB.CheckBox removesmpbox 
            Caption         =   "Remove SMP"
            Height          =   255
            Left            =   240
            TabIndex        =   9
            Tag             =   "1478"
            Top             =   1800
            Width           =   1695
         End
         Begin VB.CheckBox disablebox 
            Caption         =   "Disable Target"
            Height          =   255
            Left            =   240
            TabIndex        =   8
            Tag             =   "1477"
            Top             =   1080
            Width           =   3975
         End
         Begin VB.CheckBox runrpgcodebox 
            Caption         =   "Run RPGCode Program"
            Height          =   495
            Left            =   240
            TabIndex        =   7
            Tag             =   "1476"
            Top             =   2160
            Width           =   2295
         End
         Begin VB.TextBox removehpamountbox 
            Height          =   285
            Left            =   4320
            TabIndex        =   6
            Text            =   "0"
            Top             =   1440
            Width           =   615
         End
         Begin VB.TextBox removesmpamountbox 
            Height          =   285
            Left            =   4320
            TabIndex        =   5
            Text            =   "0"
            Top             =   1800
            Width           =   615
         End
         Begin VB.TextBox rpgcodebox 
            Height          =   285
            Left            =   2530
            TabIndex        =   4
            Top             =   2160
            Width           =   2400
         End
         Begin VB.CommandButton Command14 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   3840
            TabIndex        =   3
            Tag             =   "1021"
            Top             =   2520
            Width           =   1095
         End
         Begin VB.Label Label3 
            Caption         =   "Amount (neg values give hp)"
            Height          =   375
            Left            =   2040
            TabIndex        =   14
            Tag             =   "1483"
            Top             =   1440
            Width           =   2055
         End
         Begin VB.Label Label4 
            Caption         =   "Amount (neg values give smp)"
            Height          =   375
            Left            =   2040
            TabIndex        =   13
            Tag             =   "1482"
            Top             =   1800
            Width           =   2175
         End
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Until End of Fight"
         Height          =   255
         Left            =   2280
         TabIndex        =   1
         Tag             =   "1474"
         Top             =   1440
         Width           =   2535
      End
   End
   Begin VB.Menu fmnu 
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
         Begin VB.Menu mnunewRPGCodeProgram 
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
         Begin VB.Menu mnuNewTileBitmap 
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
      End
      Begin VB.Menu savemnu 
         Caption         =   "Save Effect"
         Shortcut        =   ^S
         Tag             =   "1490"
      End
      Begin VB.Menu saveasmnu 
         Caption         =   "Save Effect As"
         Shortcut        =   ^A
         Tag             =   "1491"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu closemnu 
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
      Begin VB.Menu sub5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTileHorizontally 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu mnuTileVertically 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu mnuCascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuArrangeIcons 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu helpmnu 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuUsersGuide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuRPGCodePrimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnuRPGCodeReference 
         Caption         =   "RPGCode Reference"
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
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRegistrationInfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "editstatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public dataIndex As Long    'index into the vector of ste maintained in commonenemy


Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_STATUS
End Function


Public Sub saveAsFile()
    'saves the file.
    On Error GoTo ErrorHandler
    If statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True Then
        Me.Show
        saveasmnu_Click
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub





Public Sub checkSave()
    'check if the status effect has changed an it needs to be saved...
    On Error GoTo ErrorHandler
    If statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True Then
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current effect?"), vbYesNo)
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

Public Sub infofill()
    'fills in data
    On Error GoTo ErrorHandler
    If statusEffectList(activeStatusEffectIndex).statusFile$ <> "" Then
        activeStatusEffect.Caption = LoadStringLoc(809, "Status Effect Editor") + " (" + statusEffectList(activeStatusEffectIndex).statusFile$ + ")"
    Else
        activeStatusEffect.Caption = LoadStringLoc(1473, "Status Effect Editor (Untitled)")
    End If
    statusnamebox = statusEffectList(activeStatusEffectIndex).theData.statusName$
    roundsbox.Text = str$(statusEffectList(activeStatusEffectIndex).theData.statusRounds)
    speedupbox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusSpeed
    slowdownbox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusSlow
    disablebox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusDisable
    removehpbox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusHP
    removehpamountbox.Text = str$(statusEffectList(activeStatusEffectIndex).theData.nStatusHPAmount)
    removesmpbox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusSMP
    removesmpamountbox.Text = str$(statusEffectList(activeStatusEffectIndex).theData.nStatusSMPAmount)
    runrpgcodebox.value = statusEffectList(activeStatusEffectIndex).theData.nStatusRPGCode
    rpgcodebox.Text = statusEffectList(activeStatusEffectIndex).theData.sStatusRPGCode$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub newfile()
    'clears data for a new file
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
    Call StatusClear(statusEffectList(activeStatusEffectIndex).theData)
    statusEffectList(activeStatusEffectIndex).statusFile$ = ""

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub saveFile()
    'saves the file.
    On Error GoTo ErrorHandler
    'If statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True Then
        filename$(2) = statusEffectList(activeStatusEffectIndex).statusFile$
        boardNeedUpdate = False
        If filename$(2) = "" Then
            Me.Show
            saveasmnu_Click
            statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
            Exit Sub
        End If
        Call saveStatus(projectPath$ + statusPath$ + statusEffectList(activeStatusEffectIndex).statusFile$, statusEffectList(activeStatusEffectIndex).theData)
        activeStatusEffect.Caption = LoadStringLoc(809, "Status Effect Editor") + " (" + statusEffectList(activeStatusEffectIndex).statusFile$ + ")"
        statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
    'End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub openFile(filename$)
    'open an effect
    On Error Resume Next
    'Call checkSave
    activeStatusEffect.Show
    If filename$ = "" Then Exit Sub
    Call openStatus(filename$, statusEffectList(activeStatusEffectIndex).theData)
    antiPath$ = absNoPath(filename$)
    statusEffectList(activeStatusEffectIndex).statusFile$ = antiPath$
    activeStatusEffect.Caption = LoadStringLoc(809, "Status Effect Editor") + "  (" + antiPath$ + ")"
    Call infofill
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
End Sub


Private Sub closemnu_Click()
    On Error GoTo ErrorHandler
    Unload editstatus

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    roundsbox.Text = "0"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    rpgcodebox.Text = antiPath$
    statusEffectList(activeStatusEffectIndex).theData.sStatusRPGCode$ = antiPath$
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    roundsbox.Text = "0"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub disablebox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusDisable = disablebox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    Set activeStatusEffect = Me
    Set activeForm = Me
    activeStatusEffectIndex = dataIndex
    Call hideAllTools
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    Set activeStatusEffect = Me
    dataIndex = VectStatusEffectNewSlot()
    activeStatusEffectIndex = dataIndex
    Call StatusClear(statusEffectList(dataIndex).theData)
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub removehpamountbox_Change()
'Global bStatusSpeed As Boolean  'speed charge time y/n
'Global bStatusSlow As Boolean   'slow charge time y/n
'Global bStatusDisable As Boolean 'disbale target y/n
'Global bStatusHP As Boolean     'remove hp y/n
'    Global nStatusHPAmount As Integer   'amount of hp
'Global bStatusSMP As Boolean    'remove smp y/n
'    Global nStatusSMPAmount As Integer   'amount of smp
'Global bStatusRPGCode As Boolean 'run rpgcode y/n
'    Global sStatusRPGCode$      'rpgcode program to run
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusHPAmount = val(removehpamountbox.Text)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub removehpbox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusHP = removehpbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub removesmpamountbox_Change()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusSMPAmount = val(removesmpamountbox.Text)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub removesmpbox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusSMP = removesmpbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub roundsbox_Change()
    On Error GoTo ErrorHandler
    rd = val(roundsbox.Text)
    If rd < 0 Then rd = 0
    statusEffectList(activeStatusEffectIndex).theData.statusRounds = rd
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: rpgcodebox_Change event has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
Private Sub rpgcodebox_Change()
    On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.sStatusRPGCode$ = rpgcodebox.Text
End Sub

Private Sub runrpgcodebox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusRPGCode = runrpgcodebox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub saveasmnu_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + statusPath$
    
    dlg.strTitle = "Save Effect As"
    dlg.strDefaultExt = "ste"
    dlg.strFileTypes = "RPG Toolkit Status Effect (*.ste)|*.ste|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
    
    If filename$(1) = "" Then Exit Sub

    Call saveStatus(filename$(1), statusEffectList(activeStatusEffectIndex).theData)
    statusEffectList(activeStatusEffectIndex).statusFile$ = antiPath$
    activeStatusEffect.Caption = LoadStringLoc(809, "Status Effect Editor") + " (" + antiPath$ + ")"
    Call tkMainForm.fillTree("", projectPath$)
End Sub

Private Sub savemnu_Click()
    On Error GoTo ErrorHandler
    filename$(2) = statusEffectList(activeStatusEffectIndex).statusFile$
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
    If filename$(2) = "" Then
        saveasmnu_Click
        Exit Sub
    End If
    Call saveStatus(projectPath$ + statusPath$ + statusEffectList(activeStatusEffectIndex).statusFile$, statusEffectList(activeStatusEffectIndex).theData)
    activeStatusEffect.Caption = LoadStringLoc(809, "Status Effect Editor") + " (" + statusEffectList(activeStatusEffectIndex).statusFile$ + ")"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub slowdownbox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusSlow = slowdownbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub speedupbox_Click()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).theData.nStatusSpeed = speedupbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub statusnamebox_Change()
    On Error GoTo ErrorHandler
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
    statusEffectList(activeStatusEffectIndex).theData.statusName$ = statusnamebox.Text

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

