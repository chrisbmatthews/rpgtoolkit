VERSION 5.00
Begin VB.Form editstatus 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Untitled status effect"
   ClientHeight    =   5040
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   5655
   Icon            =   "editstatus.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5040
   ScaleWidth      =   5655
   Tag             =   "9"
   Begin VB.Frame mainFrame 
      Caption         =   "Status Effect Editor"
      Height          =   4815
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5415
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   4455
         Index           =   0
         Left            =   120
         ScaleHeight     =   4455
         ScaleWidth      =   5175
         TabIndex        =   1
         Top             =   240
         Width           =   5175
         Begin VB.Frame Frame2 
            Caption         =   "Effects"
            Height          =   3015
            Left            =   0
            TabIndex        =   7
            Tag             =   "1475"
            Top             =   1440
            Width           =   5175
            Begin VB.TextBox rpgcodebox 
               Height          =   285
               Left            =   2530
               TabIndex        =   18
               Top             =   2160
               Width           =   2400
            End
            Begin VB.TextBox removesmpamountbox 
               Height          =   285
               Left            =   4320
               TabIndex        =   17
               Text            =   "0"
               Top             =   1800
               Width           =   615
            End
            Begin VB.TextBox removehpamountbox 
               Height          =   285
               Left            =   4320
               TabIndex        =   16
               Text            =   "0"
               Top             =   1440
               Width           =   615
            End
            Begin VB.CheckBox runrpgcodebox 
               Caption         =   "Run RPGCode Program"
               Height          =   495
               Left            =   240
               TabIndex        =   15
               Tag             =   "1476"
               Top             =   2040
               Width           =   2295
            End
            Begin VB.CheckBox disablebox 
               Caption         =   "Disable Target"
               Height          =   255
               Left            =   240
               TabIndex        =   14
               Tag             =   "1477"
               Top             =   1080
               Width           =   3975
            End
            Begin VB.CheckBox removesmpbox 
               Caption         =   "Remove SMP"
               Height          =   255
               Left            =   240
               TabIndex        =   13
               Tag             =   "1478"
               Top             =   1800
               Width           =   1695
            End
            Begin VB.CheckBox removehpbox 
               Caption         =   "Remove HP"
               Height          =   255
               Left            =   240
               TabIndex        =   12
               Tag             =   "1479"
               Top             =   1440
               Width           =   1575
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
            Begin VB.CheckBox speedupbox 
               Caption         =   "Speed Target Charge Time"
               Height          =   255
               Left            =   240
               TabIndex        =   10
               Tag             =   "1481"
               Top             =   360
               Width           =   3975
            End
            Begin VB.PictureBox Picture1 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   1
               Left            =   3240
               ScaleHeight     =   375
               ScaleWidth      =   1695
               TabIndex        =   8
               Top             =   2520
               Width           =   1695
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "Browse..."
                  Height          =   345
                  Left            =   600
                  TabIndex        =   9
                  Tag             =   "1021"
                  Top             =   0
                  Width           =   1095
               End
            End
            Begin VB.Label lblRemoveSMP 
               Caption         =   "Amount (neg values give smp)"
               Height          =   375
               Left            =   2040
               TabIndex        =   20
               Tag             =   "1482"
               Top             =   1800
               Width           =   2175
            End
            Begin VB.Label lblRemoveHP 
               Caption         =   "Amount (neg values give hp)"
               Height          =   375
               Left            =   2040
               TabIndex        =   19
               Tag             =   "1483"
               Top             =   1440
               Width           =   2055
            End
         End
         Begin VB.Frame Frame1 
            Caption         =   "General Info"
            Height          =   1335
            Left            =   0
            TabIndex        =   2
            Tag             =   "1484"
            Top             =   0
            Width           =   5175
            Begin VB.TextBox roundsbox 
               Height          =   285
               Left            =   2160
               TabIndex        =   4
               Text            =   "0"
               Top             =   840
               Width           =   2655
            End
            Begin VB.TextBox statusnamebox 
               Height          =   285
               Left            =   2160
               TabIndex        =   3
               Top             =   360
               Width           =   2655
            End
            Begin VB.Label Label5 
               Caption         =   "Number of Rounds Until Effect is Removed:"
               Height          =   375
               Left            =   120
               TabIndex        =   6
               Tag             =   "1485"
               Top             =   840
               Width           =   2055
            End
            Begin VB.Label Label1 
               Caption         =   "Status Effect Name:"
               Height          =   375
               Left            =   120
               TabIndex        =   5
               Tag             =   "1486"
               Top             =   360
               Width           =   2055
            End
         End
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
         Visible         =   0   'False
      End
      Begin VB.Menu mnuInstallUpgrade 
         Caption         =   "Install Upgrade"
         Visible         =   0   'False
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
   Begin VB.Menu helpmnu 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuUsersGuide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRegistrationInfo 
         Caption         =   "Registration Info"
         Visible         =   0   'False
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
'==============================================================================
'All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

Option Explicit

Public dataIndex As Long    'index into the vector of ste

Public Function formType() As Long: On Error Resume Next
    formType = FT_STATUS
End Function

Public Sub saveAsFile(): On Error Resume Next
    If statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True Then
        Me.Show
        saveAsMnu_Click
    End If
End Sub

Public Sub checkSave(): On Error Resume Next
    If statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True Then
        If MsgBox("Save changes to " & Me.Caption & "?", vbYesNo) = vbYes Then
            Call saveFile
        End If
    End If
End Sub

Private Sub infofill(): On Error Resume Next
    With statusEffectList(activeStatusEffectIndex)
        If LenB(.statusFile) Then Me.Caption = statusEffectList(activeStatusEffectIndex).statusFile
        
        statusnamebox = .theData.statusName
        roundsbox.Text = CStr(.theData.statusRounds)
        speedupbox.value = .theData.nStatusSpeed
        slowdownbox.value = .theData.nStatusSlow
        disablebox.value = .theData.nStatusDisable
        
        removehpbox.value = .theData.nStatusHP
        removehpamountbox.Text = CStr(.theData.nStatusHPAmount)
        removehpamountbox.Enabled = .theData.nStatusHP
        lblRemoveHP.Enabled = removehpamountbox.Enabled
        
        removesmpbox.value = .theData.nStatusSMP
        removesmpamountbox.Text = CStr(.theData.nStatusSMPAmount)
        removesmpamountbox.Enabled = .theData.nStatusSMP
        lblRemoveSMP.Enabled = removesmpamountbox.Enabled
       
        runrpgcodebox.value = .theData.nStatusRPGCode
        rpgcodebox.Text = .theData.sStatusRPGCode
        rpgcodebox.Enabled = .theData.nStatusRPGCode
        cmdBrowse.Enabled = rpgcodebox.Enabled
    End With
End Sub

Public Sub saveFile(): On Error Resume Next
    Call Show
    Call savemnu_Click
End Sub

Public Sub openFile(ByVal file As String): On Error Resume Next
    
    activeStatusEffect.Show
    Call openStatus(file, statusEffectList(activeStatusEffectIndex).theData)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & statusPath, statusEffectList(activeStatusEffectIndex).statusFile, False)
    activeStatusEffect.Caption = statusEffectList(activeStatusEffectIndex).statusFile
    
    Call infofill
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
End Sub

Private Sub closemnu_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        rpgcodebox.Text = file
        statusEffectList(activeStatusEffectIndex).theData.sStatusRPGCode = file
        statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
    End If
End Sub

Private Sub disablebox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusDisable = disablebox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub Form_Activate(): On Error Resume Next
    Set activeStatusEffect = Me
    Set activeForm = Me
    activeStatusEffectIndex = dataIndex
    Call hideAllTools
End Sub

Private Sub Form_Load(): On Error Resume Next
    Set activeStatusEffect = Me
    dataIndex = VectStatusEffectNewSlot()
    activeStatusEffectIndex = dataIndex
    Call StatusClear(statusEffectList(dataIndex).theData)
    
    Call infofill
End Sub

Private Sub Form_Resize(): On Error Resume Next
    mainFrame.Left = (Me.width - mainFrame.width) / 2
    mainFrame.Top = (Me.Height - mainFrame.Height) / 2 - 200
End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

Private Sub removehpamountbox_Change(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusHPAmount = val(removehpamountbox.Text)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub removehpbox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusHP = removehpbox.value
    Call infofill
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub removesmpamountbox_Change(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusSMPAmount = val(removesmpamountbox.Text)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub removesmpbox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusSMP = removesmpbox.value
    Call infofill
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub roundsbox_Change(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.statusRounds = Abs(val(roundsbox.Text))
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub rpgcodebox_Change(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.sStatusRPGCode = rpgcodebox.Text
End Sub

Private Sub runrpgcodebox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusRPGCode = runrpgcodebox.value
    Call infofill
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub saveAsMnu_Click(): On Error Resume Next
    
    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & statusPath
    dlg.strTitle = "Save Effect As"
    dlg.strDefaultExt = "ste"
    dlg.strFileTypes = "RPG Toolkit Status Effect (*.ste)|*.ste|All files(*.*)|*.*"
    
    If Not SaveFileDialog(dlg, Me.hwnd) Then Exit Sub
    If LenB(dlg.strSelectedFileNoPath) = 0 Then Exit Sub
    
    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, statusEffectList(activeStatusEffectIndex).statusFile, True) Then Exit Sub
    
    Call saveStatus(dlg.strDefaultFolder & statusEffectList(activeStatusEffectIndex).statusFile, statusEffectList(activeStatusEffectIndex).theData)
    activeStatusEffect.Caption = statusEffectList(activeStatusEffectIndex).statusFile
    
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
    Call tkMainForm.fillTree(vbNullString, projectPath)
End Sub

Private Sub savemnu_Click(): On Error Resume Next
    If LenB(statusEffectList(activeStatusEffectIndex).statusFile) = 0 Then
        saveAsMnu_Click
        Exit Sub
    End If
        
    Dim strFile As String
    strFile = projectPath & statusPath & statusEffectList(activeStatusEffectIndex).statusFile
    If (fileExists(strFile)) Then
        If (GetAttr(strFile) And vbReadOnly) Then
            Call MsgBox("This file is read-only; please choose a different file.")
            Call saveAsMnu_Click
            Exit Sub
        End If
    End If
    Call saveStatus(strFile, statusEffectList(activeStatusEffectIndex).theData)
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
End Sub

Private Sub slowdownbox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusSlow = slowdownbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub speedupbox_Click(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).theData.nStatusSpeed = speedupbox.value
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
End Sub

Private Sub statusnamebox_Change(): On Error Resume Next
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = True
    statusEffectList(activeStatusEffectIndex).theData.statusName = statusnamebox.Text
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

