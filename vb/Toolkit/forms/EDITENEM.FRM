VERSION 5.00
Begin VB.Form editenemy 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Untitled enemy"
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
   Begin VB.Frame fraHolder 
      Caption         =   "Enemy Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4455
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8295
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   4095
         Index           =   0
         Left            =   120
         ScaleHeight     =   4095
         ScaleWidth      =   8055
         TabIndex        =   1
         Top             =   240
         Width           =   8055
         Begin VB.Frame Frame2 
            Caption         =   "Basic Info"
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
            Left            =   0
            TabIndex        =   19
            Tag             =   "1343"
            Top             =   0
            Width           =   6135
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
               TabIndex        =   24
               Text            =   "None"
               Top             =   360
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
               TabIndex        =   23
               Text            =   "0"
               Top             =   720
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
               TabIndex        =   22
               Text            =   "0"
               Top             =   1080
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
               TabIndex        =   21
               Text            =   "0"
               Top             =   1440
               Width           =   2655
            End
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
               TabIndex        =   20
               Text            =   "0"
               Top             =   1800
               Width           =   2655
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
               TabIndex        =   29
               Tag             =   "1112"
               Top             =   360
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
               TabIndex        =   28
               Tag             =   "1347"
               Top             =   720
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
               TabIndex        =   27
               Tag             =   "1346"
               Top             =   1080
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
               TabIndex        =   26
               Tag             =   "1345"
               Top             =   1440
               Width           =   1935
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
               TabIndex        =   25
               Tag             =   "1344"
               Top             =   1800
               Width           =   1935
            End
         End
         Begin VB.Frame Frame1 
            Caption         =   "Fighting Conditions"
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
            TabIndex        =   9
            Tag             =   "1338"
            Top             =   2280
            Width           =   6135
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
               TabIndex        =   15
               Text            =   "100"
               Top             =   1320
               Width           =   735
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
               TabIndex        =   14
               Text            =   "100"
               Top             =   960
               Width           =   735
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
               TabIndex        =   13
               Tag             =   "1339"
               Top             =   240
               Value           =   1  'Checked
               Width           =   2535
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
               Left            =   2880
               TabIndex        =   12
               Text            =   "None"
               Top             =   600
               Width           =   1935
            End
            Begin VB.PictureBox Picture3 
               BorderStyle     =   0  'None
               Height          =   495
               Left            =   4920
               ScaleHeight     =   495
               ScaleWidth      =   1095
               TabIndex        =   10
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
                  TabIndex        =   11
                  Tag             =   "1021"
                  Top             =   120
                  Width           =   1095
               End
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
               Height          =   255
               Left            =   360
               TabIndex        =   18
               Tag             =   "1340"
               Top             =   600
               Width           =   2415
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
               TabIndex        =   17
               Tag             =   "1341"
               Top             =   1320
               Width           =   3855
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
               TabIndex        =   16
               Tag             =   "1342"
               Top             =   960
               Width           =   3495
            End
         End
         Begin VB.PictureBox Picture1 
            BorderStyle     =   0  'None
            Height          =   1695
            Index           =   1
            Left            =   6240
            ScaleHeight     =   1695
            ScaleWidth      =   1815
            TabIndex        =   4
            Top             =   120
            Width           =   1815
            Begin VB.CommandButton Command4 
               Appearance      =   0  'Flat
               Caption         =   "Rewards..."
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
               TabIndex        =   8
               Tag             =   "1335"
               Top             =   1080
               Width           =   1815
            End
            Begin VB.CommandButton Command3 
               Appearance      =   0  'Flat
               Caption         =   "Tactics..."
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
               TabIndex        =   7
               Tag             =   "1336"
               Top             =   720
               Width           =   1815
            End
            Begin VB.CommandButton Command2 
               Appearance      =   0  'Flat
               Caption         =   "Special Moves..."
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
               TabIndex        =   6
               Tag             =   "1337"
               Top             =   360
               Width           =   1815
            End
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
               TabIndex        =   5
               Tag             =   "1300"
               Top             =   0
               Width           =   1815
            End
         End
         Begin VB.PictureBox Picture2 
            BorderStyle     =   0  'None
            Height          =   495
            Left            =   6120
            ScaleHeight     =   495
            ScaleWidth      =   1935
            TabIndex        =   2
            Top             =   3600
            Width           =   1935
            Begin VB.CommandButton Command6 
               Caption         =   "Add Enemy To Game..."
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
               Left            =   120
               TabIndex        =   3
               Tag             =   "1333"
               Top             =   120
               Width           =   1815
            End
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
Attribute VB_Name = "editenemy"
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

Public dataIndex As Long    'index into the vector of enemies maintained in commonenemy

Public Function formType() As Long: On Error Resume Next
    'identify type of form
    formType = FT_ENEMY
End Function

Public Sub saveAsFile(): On Error Resume Next
    'saves the file.
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        Me.Show
        mnusaveas_Click
    End If
End Sub

Public Sub checkSave(): On Error Resume Next
    'check if the file has changed an it needs to be saved...
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        If MsgBox("Save your changes to " & Me.Caption & "?", vbYesNo) = vbYes Then
            Call saveFile
        End If
    End If
End Sub

Public Sub saveFile(): On Error Resume Next
    Call Show
    Call mnusave_Click
End Sub

Public Sub openFile(ByVal file As String): On Error Resume Next
    'Call checkSave
    activeEnemy.Show
    enemylist(activeEnemyIndex).theData = openEnemy(file)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & enePath, enemylist(activeEnemyIndex).eneFile, False)
    activeEnemy.Caption = enemylist(activeEnemyIndex).eneFile
    
    Call infofill
    enemylist(activeEnemyIndex).eneNeedUpdate = False
End Sub

Private Sub Check1_Click(): On Error Resume Next
    
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

End Sub

Private Sub Command1_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyGfx.Show vbModal ', me
End Sub

Private Sub Command2_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyspecialmoves.Show vbModal ', me
End Sub

Private Sub Command3_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemytactics.Show vbModal ', me
End Sub

Private Sub Command4_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemyrewards.Show vbModal ', me
End Sub

Private Sub Command6_Click(): On Error Resume Next
    If enemylist(activeEnemyIndex).eneNeedUpdate = True Then
        MsgBox LoadStringLoc(995, "Make sure you save your enemy first!")
        Exit Sub
    End If
    editmainfile.Show
    mainfight.Show
End Sub

Private Sub Command7_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        rprg.Text = file
        enemylist(activeEnemyIndex).theData.eneRunPrg = file
    End If
End Sub

Private Sub edp_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneDP = val(edp.Text)
End Sub

Private Sub efp_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneFP = val(efp.Text)
End Sub

Private Sub ehp_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneHP = val(ehp.Text)
End Sub

Private Sub ename_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneName$ = ename.Text
End Sub

Private Sub esmp_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSMP = val(esmp.Text)
End Sub

Private Sub eSneak_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSneakChances = val(eSneak.Text)

End Sub

Private Sub eSneakYou_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).eneNeedUpdate = True
    enemylist(activeEnemyIndex).theData.eneSneakUp = val(eSneakYou.Text)
End Sub

Private Sub Form_Activate(): On Error Resume Next
    
    Set activeEnemy = Me
    Set activeForm = Me
    activeEnemyIndex = dataIndex

    hideAllTools
End Sub

Private Sub Form_Load(): On Error Resume Next
    
    Set activeEnemy = Me
    dataIndex = VectEnemyNewSlot()
    activeEnemyIndex = dataIndex
    Call EnemyClear(enemylist(dataIndex).theData)
    
    Call infofill
End Sub

Private Sub Form_Resize(): On Error Resume Next
    fraHolder.Left = (Me.width - fraHolder.width) / 2
    fraHolder.Top = (Me.Height - fraHolder.Height - 500) / 2
End Sub

Private Sub infofill(): On Error Resume Next
    Dim use As String
    
    If LenB(enemylist(activeEnemyIndex).eneFile) Then Me.Caption = enemylist(activeEnemyIndex).eneFile
    
    ename.Text = IIf(LenB(enemylist(activeEnemyIndex).theData.eneName), enemylist(activeEnemyIndex).theData.eneName, "None")

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
End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

Private Sub mnuCLose_Click()
    Unload Me
End Sub

Private Sub mnusave_Click(): On Error Resume Next

    If LenB(enemylist(activeEnemyIndex).eneFile) = 0 Then
        Call mnusaveas_Click
        Exit Sub
    End If
    
    Dim strFile As String
    strFile = projectPath & enePath & enemylist(activeEnemyIndex).eneFile
    If (fileExists(strFile)) Then
        If (GetAttr(strFile) And vbReadOnly) Then
            Call MsgBox("This file is read-only; please choose a different file.")
            Call mnusaveas_Click
            Exit Sub
        End If
    End If
    
    Call saveEnemy(strFile, enemylist(activeEnemyIndex).theData)
    enemylist(activeEnemyIndex).eneNeedUpdate = False
End Sub

Private Sub mnusaveas_Click(): On Error Resume Next
    
    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & enePath
    dlg.strTitle = "Save Enemy As"
    dlg.strDefaultExt = "ene"
    dlg.strFileTypes = "RPG Toolkit Enemy (*.ene)|*.ene|All files(*.*)|*.*"
    
    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub

    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, enemylist(activeEnemyIndex).eneFile, True) Then Exit Sub

    Call saveEnemy(dlg.strDefaultFolder & enemylist(activeEnemyIndex).eneFile, enemylist(activeEnemyIndex).theData)
    activeEnemy.Caption = enemylist(activeEnemyIndex).eneFile
    
    enemylist(activeEnemyIndex).eneNeedUpdate = False
    Call tkMainForm.tvAddFile(dlg.strDefaultFolder & enemylist(activeEnemyIndex).eneFile)
End Sub

Private Sub newEnemy(): On Error Resume Next
    Call EnemyClear(enemylist(activeEnemyIndex).theData)
End Sub

Private Sub toc_Click(): On Error Resume Next
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))
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


