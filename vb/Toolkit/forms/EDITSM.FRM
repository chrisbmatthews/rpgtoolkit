VERSION 5.00
Begin VB.Form editsm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Special Move Editor (Untitled)"
   ClientHeight    =   4545
   ClientLeft      =   1860
   ClientTop       =   1860
   ClientWidth     =   7470
   ControlBox      =   0   'False
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
   Icon            =   "EDITSM.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4545
   ScaleWidth      =   7470
   Tag             =   "8"
   WindowState     =   2  'Maximized
   Begin VB.Frame mainFrame 
      Height          =   4215
      Left            =   120
      TabIndex        =   13
      Top             =   120
      Width           =   7215
      Begin VB.TextBox namebox 
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
         Left            =   3240
         TabIndex        =   0
         Text            =   "None"
         Top             =   360
         Width           =   2535
      End
      Begin VB.TextBox fpbox 
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
         Left            =   3240
         TabIndex        =   1
         Text            =   "0"
         Top             =   720
         Width           =   2535
      End
      Begin VB.TextBox smbox 
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
         Left            =   3240
         TabIndex        =   3
         Text            =   "0"
         Top             =   1440
         Width           =   2535
      End
      Begin VB.TextBox rpgcodebox 
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
         Left            =   3240
         TabIndex        =   5
         Text            =   "None"
         Top             =   2160
         Width           =   2535
      End
      Begin VB.TextBox targSMPbox 
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
         Left            =   3240
         TabIndex        =   2
         Text            =   "0"
         Top             =   1080
         Width           =   2535
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Battle-Driven"
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
         Left            =   240
         TabIndex        =   11
         Tag             =   "1353"
         Top             =   3360
         Width           =   2295
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Board-Driven"
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
         Left            =   240
         TabIndex        =   12
         Tag             =   "1352"
         Top             =   3720
         Width           =   2295
      End
      Begin VB.TextBox statuse 
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
         Left            =   3240
         TabIndex        =   7
         Text            =   "None"
         Top             =   2520
         Width           =   2535
      End
      Begin VB.TextBox effectanim 
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
         Left            =   3240
         TabIndex        =   9
         Text            =   "None"
         Top             =   2880
         Width           =   2535
      End
      Begin VB.TextBox description 
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
         Left            =   3240
         TabIndex        =   4
         Text            =   "None"
         Top             =   1800
         Width           =   2535
      End
      Begin VB.CommandButton Command14 
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
         Left            =   5880
         TabIndex        =   6
         Tag             =   "1021"
         Top             =   2160
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
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
         Left            =   5880
         TabIndex        =   8
         Tag             =   "1021"
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command2 
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
         Left            =   5880
         TabIndex        =   10
         Tag             =   "1021"
         Top             =   2880
         Width           =   1095
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
         Left            =   240
         TabIndex        =   21
         Tag             =   "1112"
         Top             =   360
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "Fight Power:"
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
         Left            =   240
         TabIndex        =   20
         Tag             =   "1362"
         Top             =   720
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "Special Move Power Consumption:"
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
         Left            =   240
         TabIndex        =   19
         Tag             =   "1361"
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "RPGCode Program:"
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
         Left            =   240
         TabIndex        =   18
         Tag             =   "1360"
         Top             =   2160
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "Amount of SMP Removed From Target:"
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
         Left            =   240
         TabIndex        =   17
         Tag             =   "1359"
         Top             =   1080
         Width           =   3015
      End
      Begin VB.Label Label2 
         Caption         =   "Status Effect:"
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
         Index           =   5
         Left            =   240
         TabIndex        =   16
         Tag             =   "1358"
         Top             =   2520
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "Effect Animation:"
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
         Index           =   6
         Left            =   240
         TabIndex        =   15
         Tag             =   "1357"
         Top             =   2880
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "Description:"
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
         Index           =   7
         Left            =   240
         TabIndex        =   14
         Tag             =   "1354"
         Top             =   1800
         Width           =   2895
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
         Caption         =   "Save"
         Shortcut        =   ^S
         Tag             =   "1233"
      End
      Begin VB.Menu saveasmnu 
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
      Begin VB.Menu mnushowprojectlist 
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
   Begin VB.Menu h 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuusersguide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
         Tag             =   "1207"
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
Attribute VB_Name = "editsm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public dataIndex As Long    'index into the vector of items maintained in commonenemy


Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_SM
End Function


Public Sub saveAsFile()
    'saves the file.
    On Error GoTo ErrorHandler
    If specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True Then
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
    'check if the file has changed an it needs to be saved...
    On Error GoTo ErrorHandler
    If specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True Then
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
    'saves the file.
    On Error GoTo ErrorHandler
    'If specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True Then
        filename$(2) = specialMoveList(activeSpecialMoveIndex).smFile$
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
        If filename$(2) = "" Then
            Me.Show
            Call saveasmnu_Click
            Exit Sub
        End If
        Call saveSpecialMove(projectPath$ + spcPath$ + filename$(2), specialMoveList(activeSpecialMoveIndex).theData)
    'End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
Public Sub openFile(ByVal file$)
    On Error Resume Next
    'Call checkSave
    activeSpecialMove.Show
    filename$(1) = file$
    antiPath$ = absNoPath(file$)
    FileCopy filename$(1), projectPath$ + spcPath$ + antiPath$
    specialMoveList(activeSpecialMoveIndex).theData = openSpecialMove(filename$(1))
    spfile$ = antiPath$
    activeSpecialMove.Caption = LoadStringLoc(808, "Special Move Editor") + "  (" + antiPath$ + ")"
    Call infofill
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
End Sub


Private Sub Check1_Click()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    If Check1.value = 0 Then specialMoveList(activeSpecialMoveIndex).theData.smBattle = 1 Else specialMoveList(activeSpecialMoveIndex).theData.smBattle = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check2_Click()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    If Check2.value = 0 Then specialMoveList(activeSpecialMoveIndex).theData.smMenu = 1 Else specialMoveList(activeSpecialMoveIndex).theData.smMenu = 0


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub closemnu_Click()
    On Error GoTo ErrorHandler
    Unload editsm

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + statusPath$
    
    dlg.strTitle = "Select Status Effect"
    dlg.strDefaultExt = "ste"
    dlg.strFileTypes = "RPG Toolkit Status Effect (*.ste)|*.ste|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + statusPath$ + antiPath$
    statuse.Text = antiPath$
    specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect$ = antiPath$
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
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    rpgcodebox.Text = antiPath$
    specialMoveList(activeSpecialMoveIndex).theData.smPrg$ = antiPath$
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + miscPath$
    
    dlg.strTitle = "Select Animation"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + miscPath$ + antiPath$
    effectanim.Text = antiPath$
    specialMoveList(activeSpecialMoveIndex).theData.smAnimation$ = antiPath$
End Sub

Private Sub description_Change()
    specialMoveList(activeSpecialMoveIndex).theData.smDescription$ = description.Text
End Sub

Private Sub effectanim_Change()
    On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).theData.smAnimation$ = effectanim.Text
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    Set activeSpecialMove = Me
    Set activeForm = Me
    activeSpecialMoveIndex = dataIndex
    Call hideAllTools
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    Set activeSpecialMove = Me
    dataIndex = VectSpecialMoveNewSlot()
    activeSpecialMoveIndex = dataIndex
    Call SpecialMoveClear(specialMoveList(dataIndex).theData)
    
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
    Call tkMainForm.refreshTabs
End Sub

Private Sub fpbox_Change()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smFP = val(fpbox.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo ErrorHandler
    namebox.Text = specialMoveList(activeSpecialMoveIndex).theData.smname$
    fpbox.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smFP)
    smbox.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smSMP)
    targSMPbox.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smtargSMP)
    rpgcodebox.Text = specialMoveList(activeSpecialMoveIndex).theData.smPrg$
    If specialMoveList(activeSpecialMoveIndex).theData.smBattle = 0 Then Check1.value = 1 Else Check1.value = 0
    If specialMoveList(activeSpecialMoveIndex).theData.smMenu = 0 Then Check2.value = 1 Else Check2.value = 0
    statuse.Text = specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect$ 'status effect cast
    effectanim.Text = specialMoveList(activeSpecialMoveIndex).theData.smAnimation$
    description.Text = specialMoveList(activeSpecialMoveIndex).theData.smDescription$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label3_Click()
    On Error GoTo ErrorHandler
    activeStatusEffect.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label4_Click()
    On Error GoTo ErrorHandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub link1_Click()
    On Error GoTo ErrorHandler
    activeAnimation.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub namebox_Change()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smname$ = namebox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub newsm()
    On Error GoTo ErrorHandler
        
    Call SpecialMoveClear(specialMoveList(activeSpecialMoveIndex).theData)
    activeSpecialMove.Caption = LoadStringLoc(1351, "Special Move Editor (Untitled)")
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: rpgcodebox_Change event has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
Private Sub rpgcodebox_Change()
    On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).theData.smPrg$ = rpgcodebox.Text
End Sub

Private Sub saveasmnu_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + spcPath$
    
    dlg.strTitle = "Save Special Move As"
    dlg.strDefaultExt = "spc"
    dlg.strFileTypes = "RPG Toolkit Special Move (*.spc)|*.spc|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    Call saveSpecialMove(filename$(1), specialMoveList(activeSpecialMoveIndex).theData)
    specialMoveList(activeSpecialMoveIndex).smFile$ = antiPath$
    activeSpecialMove.Caption = LoadStringLoc(808, "Special Move Editor") + " (" + antiPath$ + ")"
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub

Private Sub savemnu_Click()
    On Error GoTo ErrorHandler
    filename$(2) = specialMoveList(activeSpecialMoveIndex).smFile$
    If filename$(2) = "" Then saveasmnu_Click: Exit Sub
    Call saveSpecialMove(projectPath$ + spcPath$ + filename$(2), specialMoveList(activeSpecialMoveIndex).theData)
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smbox_Change()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smSMP = val(smbox.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub statuse_Change()
    On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect$ = statuse.Text
End Sub

Private Sub targSMPbox_Change()
    On Error GoTo ErrorHandler
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smtargSMP = val(targSMPbox.Text)

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

