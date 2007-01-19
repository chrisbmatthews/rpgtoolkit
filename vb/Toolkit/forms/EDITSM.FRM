VERSION 5.00
Begin VB.Form editsm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Untitled special move"
   ClientHeight    =   4545
   ClientLeft      =   1860
   ClientTop       =   1860
   ClientWidth     =   7470
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
   Begin VB.Frame mainFrame 
      Caption         =   "Special Move Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4215
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   7215
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1215
         Left            =   5880
         ScaleHeight     =   1215
         ScaleWidth      =   1215
         TabIndex        =   19
         Top             =   2160
         Width           =   1215
         Begin VB.CommandButton cmdAnimation 
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
            TabIndex        =   22
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
         End
         Begin VB.CommandButton cmdStatusEffect 
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
            TabIndex        =   21
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.CommandButton cmdProgram 
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
            TabIndex        =   20
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox txtName 
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
      Begin VB.TextBox txtFightPower 
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
      Begin VB.TextBox txtSMP 
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
      Begin VB.TextBox txtProgram 
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
      Begin VB.TextBox txtTargetSMP 
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
      Begin VB.CheckBox chkBattleDriven 
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
         TabIndex        =   8
         Tag             =   "1353"
         Top             =   3360
         Width           =   2295
      End
      Begin VB.CheckBox chkBoardDriven 
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
         TabIndex        =   9
         Tag             =   "1352"
         Top             =   3720
         Width           =   2295
      End
      Begin VB.TextBox txtStatusEffect 
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
         TabIndex        =   6
         Text            =   "None"
         Top             =   2520
         Width           =   2535
      End
      Begin VB.TextBox txtAnimation 
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
         Top             =   2880
         Width           =   2535
      End
      Begin VB.TextBox txtDescription 
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
         TabIndex        =   18
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
         TabIndex        =   17
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
         TabIndex        =   16
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
         TabIndex        =   15
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
         TabIndex        =   14
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
         TabIndex        =   13
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
         TabIndex        =   12
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
         TabIndex        =   11
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
      Begin VB.Menu mnushowprojectlist 
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
         Visible         =   0   'False
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuregistrationinfo 
         Caption         =   "Registration Info"
         Visible         =   0   'False
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
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Public dataIndex As Long

'==============================================================================
'Identify type of form
'==============================================================================
Public Function formType() As Long: On Error Resume Next
    formType = FT_SM
End Function

'==============================================================================
'Saves the file
'==============================================================================
Public Sub saveAsFile(): On Error Resume Next
    If specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True Then
        Me.Show
        saveAsMnu_Click
    End If
End Sub

'==============================================================================
'check if the file has changed an it needs to be saved...
'==============================================================================
Public Sub checkSave(): On Error Resume Next
    If specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True Then
        If MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo) = vbYes Then
            Call saveFile
        End If
    End If
End Sub

'==============================================================================
'saves the file.
'==============================================================================
Public Sub saveFile(): On Error Resume Next
    Call Show
    Call savemnu_Click
End Sub

'==============================================================================
'Open file
'==============================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next
    
    activeSpecialMove.Show
    specialMoveList(activeSpecialMoveIndex).theData = openSpecialMove(file)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & spcPath, specialMoveList(activeSpecialMoveIndex).smFile, False)
    activeSpecialMove.Caption = specialMoveList(activeSpecialMoveIndex).smFile
    
    Call infofill
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
End Sub

'==============================================================================
'File > Save As
'==============================================================================
Private Sub saveAsMnu_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & spcPath
    dlg.strTitle = "Save Special Move As"
    dlg.strDefaultExt = "spc"
    dlg.strFileTypes = "RPG Toolkit Special Move (*.spc)|*.spc|All files(*.*)|*.*"
    
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub
    If LenB(dlg.strSelectedFileNoPath) = 0 Then Exit Sub
    
    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, specialMoveList(activeSpecialMoveIndex).smFile, True) Then Exit Sub
    
    Call saveSpecialMove(dlg.strDefaultFolder & specialMoveList(activeSpecialMoveIndex).smFile, specialMoveList(activeSpecialMoveIndex).theData)
    activeSpecialMove.Caption = specialMoveList(activeSpecialMoveIndex).smFile
    
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
    Call tkMainForm.tvAddFile(dlg.strDefaultFolder & specialMoveList(activeSpecialMoveIndex).smFile)
End Sub

'==============================================================================
'File > Save
'==============================================================================
Private Sub savemnu_Click(): On Error Resume Next

    If LenB(specialMoveList(activeSpecialMoveIndex).smFile) = 0 Then
        saveAsMnu_Click
        Exit Sub
    End If
    
    Dim strFile As String
    strFile = projectPath & spcPath & specialMoveList(activeSpecialMoveIndex).smFile
    If (fileExists(strFile)) Then
        If (GetAttr(strFile) And vbReadOnly) Then
            Call MsgBox("This file is read-only; please choose a different file.")
            Call saveAsMnu_Click
            Exit Sub
        End If
    End If
    
    Call saveSpecialMove(strFile, specialMoveList(activeSpecialMoveIndex).theData)
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
End Sub

'==============================================================================
'Battle Driven check box
'==============================================================================
Private Sub chkBattleDriven_Click(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smBattle = Abs(chkBattleDriven.value - 1)
End Sub

'==============================================================================
'Board Driven check box
'==============================================================================
Private Sub chkBoardDriven_Click(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smMenu = Abs(chkBoardDriven.value - 1)
End Sub

'==============================================================================
'Browse > Status Effect
'==============================================================================
Private Sub cmdStatusEffect_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Status Effect (*.ste)|*.ste|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & statusPath, "Select status effect", "ste", fileTypes, file) Then
        txtStatusEffect.Text = file
        specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect = file
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    End If
End Sub

'==============================================================================
'Browse > Program
'==============================================================================
Private Sub cmdProgram_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        txtProgram.Text = file
        specialMoveList(activeSpecialMoveIndex).theData.smPrg = file
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    End If
End Sub

'==============================================================================
'Browse > Animation
'==============================================================================
Private Sub cmdAnimation_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & miscPath, "Select animation", "anm", fileTypes, file) Then
        txtAnimation.Text = file
        specialMoveList(activeSpecialMoveIndex).theData.smAnimation = file
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    End If
End Sub

'==============================================================================
'Name textbox
'==============================================================================
Private Sub txtName_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smname = txtName.Text
End Sub

'==============================================================================
'Fight Power textbox
'==============================================================================
Private Sub txtFightPower_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smFP = val(txtFightPower.Text)
End Sub

'==============================================================================
'Target Special Move Power Drain textbox
'==============================================================================
Private Sub txtTargetSMP_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smtargSMP = val(txtTargetSMP.Text)
End Sub

'==============================================================================
'Special Move Power Consumption textbox
'==============================================================================
Private Sub txtSMP_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smSMP = val(txtSMP.Text)
End Sub

'==============================================================================
'Description textbox
'==============================================================================
Private Sub txtDescription_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smDescription = txtDescription.Text
End Sub

'==============================================================================
'Program textbox
'==============================================================================
Private Sub txtProgram_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smPrg = txtProgram.Text
End Sub

'==============================================================================
'Status effect textbox
'==============================================================================
Private Sub txtStatusEffect_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect = txtStatusEffect.Text
End Sub

'==============================================================================
'Animation textbox
'==============================================================================
Private Sub txtAnimation_Change(): On Error Resume Next
    specialMoveList(activeSpecialMoveIndex).smNeedUpdate = True
    specialMoveList(activeSpecialMoveIndex).theData.smAnimation = txtAnimation.Text
End Sub

'==============================================================================
'Form Activate
'==============================================================================
Private Sub Form_Activate(): On Error Resume Next
    Set activeSpecialMove = Me
    Set activeForm = Me
    activeSpecialMoveIndex = dataIndex
    Call hideAllTools
End Sub

'==============================================================================
'Form Load
'==============================================================================
Private Sub Form_Load(): On Error Resume Next
    
    ' Call LocalizeForm(Me)
    Set activeSpecialMove = Me
    dataIndex = VectSpecialMoveNewSlot()
    activeSpecialMoveIndex = dataIndex
    Call SpecialMoveClear(specialMoveList(dataIndex).theData)
    
    Call infofill
End Sub

'==============================================================================
'Form Resize
'==============================================================================
Private Sub Form_Resize(): On Error Resume Next
    mainFrame.Left = (Me.width - mainFrame.width) \ 2
    mainFrame.Top = (Me.Height - mainFrame.Height) \ 2 - 200
End Sub

'==============================================================================
'Form Unload
'==============================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

'==============================================================================
'Insert info on load
'==============================================================================
Private Sub infofill(): On Error Resume Next
    txtName.Text = specialMoveList(activeSpecialMoveIndex).theData.smname
    txtFightPower.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smFP)
    txtSMP.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smSMP)
    txtTargetSMP.Text = CStr(specialMoveList(activeSpecialMoveIndex).theData.smtargSMP)
    txtProgram.Text = specialMoveList(activeSpecialMoveIndex).theData.smPrg
    chkBattleDriven.value = specialMoveList(activeSpecialMoveIndex).theData.smBattle
    chkBoardDriven.value = specialMoveList(activeSpecialMoveIndex).theData.smMenu
    txtStatusEffect.Text = specialMoveList(activeSpecialMoveIndex).theData.smStatusEffect
    txtAnimation.Text = specialMoveList(activeSpecialMoveIndex).theData.smAnimation
    txtDescription.Text = specialMoveList(activeSpecialMoveIndex).theData.smDescription
End Sub

'==============================================================================
'File > Close
'==============================================================================
Private Sub closemnu_Click(): On Error Resume Next
    Unload editsm
End Sub

'==============================================================================
Private Sub mnuTutorial_Click(): On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

Private Sub mnuusersguide_Click(): On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

Private Sub mnuAbout_Click(): On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub

Private Sub mnucreatepakfile_Click(): On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub

Private Sub mnucreatesetup_Click(): On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub

Private Sub mnuexit_Click(): On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub

Private Sub mnuHistorytxt_Click(): On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub

Private Sub mnuinstallupgrade_Click(): On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub

Private Sub mnumakeexe_Click(): On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub

Private Sub mnunewanimatedtile_Click(): On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub

Private Sub mnunewanimation_Click(): On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub

Private Sub mnunewboard_Click(): On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub

Private Sub mnunewenemy_Click(): On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub

Private Sub mnunewitem_Click(): On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub

Private Sub mnunewplayer_Click(): On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub

Private Sub mnunewproject_Click(): On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub

Private Sub mnunewrpgcodeprogram_Click(): On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub

Private Sub mnunewspecialmove_Click(): On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub

Private Sub mnunewstatuseffect_Click(): On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub

Private Sub mnunewtile_Click(): On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub

Private Sub mnunewtilebitmap_Click(): On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub

Private Sub mnuopen_Click(): On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub

Private Sub mnuRPGCodePrimer_Click(): On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub

Private Sub mnurpgcodereference_Click(): On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub

Private Sub mnusaveall_Click(): On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub

Private Sub mnuselectlanguage_Click(): On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub

Private Sub mnushowprojectlist_Click(): On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub

Private Sub mnushowtools_Click(): On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub

Private Sub mnutestgame_Click(): On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub

Private Sub mnuOpenProject_Click(): On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

Private Sub mnuNewFightBackground_Click(): On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub
