VERSION 5.00
Begin VB.Form editBackground 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Background"
   ClientHeight    =   4545
   ClientLeft      =   2520
   ClientTop       =   1530
   ClientWidth     =   6615
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
   Icon            =   "editBackground.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4545
   ScaleWidth      =   6615
   Tag             =   "4"
   Begin VB.Frame fraHolder 
      Caption         =   "Background Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4335
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6375
      Begin VB.PictureBox picHolder 
         BorderStyle     =   0  'None
         Height          =   3975
         Left            =   120
         ScaleHeight     =   3975
         ScaleWidth      =   6135
         TabIndex        =   1
         Top             =   240
         Width           =   6135
         Begin VB.Frame Frame1 
            Caption         =   "Background Fight Music"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   855
            Left            =   0
            TabIndex        =   20
            Tag             =   "1033"
            Top             =   960
            Width           =   6135
            Begin VB.TextBox Text1 
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
               Left            =   240
               TabIndex        =   23
               Top             =   360
               Width           =   4335
            End
            Begin VB.PictureBox Picture2 
               BorderStyle     =   0  'None
               Height          =   375
               Left            =   4680
               ScaleHeight     =   375
               ScaleWidth      =   1215
               TabIndex        =   21
               Top             =   360
               Width           =   1215
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   1
                  Left            =   0
                  TabIndex        =   22
                  Tag             =   "1021"
                  Top             =   0
                  Width           =   1095
               End
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "Menu Sounds:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2055
            Left            =   0
            TabIndex        =   6
            Tag             =   "1028"
            Top             =   1920
            Width           =   6135
            Begin VB.TextBox illegalbox 
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
               Left            =   2640
               TabIndex        =   15
               Text            =   "None"
               Top             =   1440
               Width           =   1935
            End
            Begin VB.TextBox selectbox 
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
               Left            =   2640
               TabIndex        =   14
               Text            =   "None"
               Top             =   720
               Width           =   1935
            End
            Begin VB.TextBox readybox 
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
               Left            =   2640
               TabIndex        =   13
               Text            =   "None"
               Top             =   1080
               Width           =   1935
            End
            Begin VB.TextBox clickbox 
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
               Left            =   2640
               TabIndex        =   12
               Text            =   "None"
               Top             =   360
               Width           =   1935
            End
            Begin VB.PictureBox Picture3 
               BorderStyle     =   0  'None
               Height          =   1575
               Left            =   4680
               ScaleHeight     =   1575
               ScaleWidth      =   1335
               TabIndex        =   7
               Top             =   360
               Width           =   1335
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   2
                  Left            =   0
                  TabIndex        =   11
                  Tag             =   "1021"
                  Top             =   0
                  Width           =   1095
               End
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   3
                  Left            =   0
                  TabIndex        =   10
                  Tag             =   "1021"
                  Top             =   360
                  Width           =   1095
               End
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   5
                  Left            =   0
                  TabIndex        =   9
                  Tag             =   "1021"
                  Top             =   1080
                  Width           =   1095
               End
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   4
                  Left            =   0
                  TabIndex        =   8
                  Tag             =   "1021"
                  Top             =   720
                  Width           =   1095
               End
            End
            Begin VB.Label Label2 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Illegal Action Command:"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   255
               Index           =   3
               Left            =   240
               TabIndex        =   19
               Tag             =   "1027"
               Top             =   1440
               Width           =   2175
            End
            Begin VB.Label Label2 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Player is Ready Sound:"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   255
               Index           =   2
               Left            =   240
               TabIndex        =   18
               Tag             =   "1029"
               Top             =   1080
               Width           =   2175
            End
            Begin VB.Label Label2 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Select from Menu Sound:"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   255
               Index           =   1
               Left            =   240
               TabIndex        =   17
               Tag             =   "1030"
               Top             =   720
               Width           =   2175
            End
            Begin VB.Label Label2 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Click in Menu Sound:"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   255
               Index           =   0
               Left            =   240
               TabIndex        =   16
               Tag             =   "1031"
               Top             =   360
               Width           =   2175
            End
         End
         Begin VB.Frame Frame3 
            Caption         =   "Image"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   855
            Left            =   0
            TabIndex        =   2
            Top             =   0
            Width           =   6135
            Begin VB.TextBox Text2 
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
               Left            =   240
               TabIndex        =   5
               Top             =   360
               Width           =   4335
            End
            Begin VB.PictureBox Picture1 
               BorderStyle     =   0  'None
               Height          =   375
               Left            =   4680
               ScaleHeight     =   375
               ScaleWidth      =   1215
               TabIndex        =   3
               Top             =   360
               Width           =   1215
               Begin VB.CommandButton cmdBrowse 
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
                  Index           =   0
                  Left            =   0
                  TabIndex        =   4
                  Tag             =   "1021"
                  Top             =   0
                  Width           =   1095
               End
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
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "editBackground"
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

'=========================================================================
' Integral variables
'=========================================================================

Public dataIndex As Long    'index into the vector of backgrounds

'=========================================================================
' Property identifying this form
'=========================================================================
Public Property Get formType() As Long
    On Error Resume Next
    formType = FT_BACKGROUND
End Property

'=========================================================================
' Save the file
'=========================================================================
Public Sub saveFile(): On Error Resume Next
    Call Show
    Call mnusave_Click
End Sub

'=========================================================================
' Save file as
'=========================================================================
Public Sub saveAsFile(): On Error Resume Next
    If bkgList(activeBkgIndex).needUpdate = True Then
        Call Me.Show
        Call mnusaveas_Click
    End If
End Sub

'=========================================================================
' Open a file
'=========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next
    activeBackground.Show
    Call openBackground(file, bkgList(activeBkgIndex).theData)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & bkgPath, bkgList(activeBkgIndex).filename, False)
    Me.Caption = bkgList(activeBkgIndex).filename
    
    Call infofill
    bkgList(activeBkgIndex).needUpdate = False
End Sub

'=========================================================================
' Fields on the form
'=========================================================================
Private Sub clickbox_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgSelWav = clickbox.Text
End Sub

Private Sub cmdBrowse_Click(Index As Integer): On Error Resume Next
    Dim file As String, fileTypes As String, i As Long
    Select Case Index
         Case 0:
            If browseFileDialog(Me.hwnd, projectPath & bmpPath, "Background image", "jpg", strFileDialogFilterGfx, file) Then
                bkgList(activeBkgIndex).theData.image = file
                Text2.Text = file
            End If
        Case 1:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Background music", "mid", strFileDialogFilterMedia, file) Then
                bkgList(activeBkgIndex).theData.bkgMusic = file
                Text1.Text = file
            End If
        Case 2:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Menu click sound", "wav", strFileDialogFilterMedia, file) Then
                bkgList(activeBkgIndex).theData.bkgSelWav = file
                clickbox.Text = file
            End If
        Case 3:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Menu select sound", "wav", strFileDialogFilterMedia, file) Then
                bkgList(activeBkgIndex).theData.bkgChooseWav = file
                selectbox.Text = file
            End If
        Case 4:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Player ready sound", "wav", strFileDialogFilterMedia, file) Then
                bkgList(activeBkgIndex).theData.bkgReadyWav = file
                readybox.Text = file
            End If
        Case 5:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Illegal action sound", "wav", strFileDialogFilterMedia, file) Then
                bkgList(activeBkgIndex).theData.bkgCantDoWav = file
                illegalbox.Text = file
            End If
    End Select
    bkgList(activeBkgIndex).needUpdate = True
End Sub

Private Sub Form_Resize(): On Error Resume Next
    fraHolder.Left = (Me.width - fraHolder.width) / 2
    fraHolder.Top = (Me.Height - fraHolder.Height) / 2 - 200
End Sub

Private Sub illegalbox_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgCantDoWav = illegalbox.Text
End Sub
Private Sub readybox_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgReadyWav = readybox.Text
End Sub
Private Sub selectbox_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgChooseWav = selectbox.Text
End Sub
Private Sub Text1_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgMusic = Text1.Text
End Sub
Private Sub Text2_Change(): On Error Resume Next
    bkgList(activeBkgIndex).theData.image = Text2.Text
End Sub

'=========================================================================
' Form activate
'=========================================================================
Private Sub Form_Activate(): On Error Resume Next
    Set activeBackground = Me
    Set activeForm = Me
    activeBkgIndex = dataIndex
    Call hideAllTools
End Sub

'=========================================================================
' Form load
'=========================================================================
Private Sub Form_Load(): On Error Resume Next
    Set activeBackground = Me
    dataIndex = VectBackgroundNewSlot()
    activeBkgIndex = dataIndex
    Call BackgroundClear(bkgList(dataIndex).theData)
End Sub

'=========================================================================
' Form unload
'=========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

'=========================================================================
' Fill in this form
'=========================================================================
Private Sub infofill(): On Error Resume Next
    With bkgList(activeBkgIndex).theData
        If LenB(.image) Then Text2.Text = .image
        If LenB(.bkgMusic) Then Text1.Text = .bkgMusic
        If LenB(.bkgSelWav) Then clickbox.Text = .bkgSelWav
        If LenB(.bkgChooseWav) Then selectbox.Text = .bkgChooseWav
        If LenB(.bkgReadyWav) Then readybox.Text = .bkgReadyWav
        If LenB(.bkgCantDoWav) Then illegalbox.Text = .bkgCantDoWav
    End With
End Sub

'=========================================================================
' Close this form
'=========================================================================
Private Sub mnuCLose_Click()
    Call Unload(Me)
End Sub

'========================================================================='
' Save menu
'=========================================================================
Private Sub mnusave_Click(): On Error Resume Next
    Dim file As String
    
    If (LenB(bkgList(activeBkgIndex).filename) = 0) Then
        Call mnusaveas_Click
        Exit Sub
    End If
    
    file = projectPath & bkgPath & bkgList(activeBkgIndex).filename
    If (fileExists(file)) Then
        If (GetAttr(file) And vbReadOnly) Then
            Call MsgBox("This file is read-only; please choose a different file.")
            Call mnusaveas_Click
            Exit Sub
        End If
    End If
    
    Call saveBackground(file, bkgList(activeBkgIndex).theData)
    bkgList(activeBkgIndex).needUpdate = False
End Sub

'=========================================================================
' Save as
'=========================================================================
Private Sub mnusaveas_Click(): On Error Resume Next
    
    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & bkgPath
    dlg.strTitle = "Save Background As"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    
    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
    
    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, bkgList(activeBkgIndex).filename, True) Then Exit Sub
        
    Call saveBackground(dlg.strDefaultFolder & bkgList(activeBkgIndex).filename, bkgList(activeBkgIndex).theData)
    activeBackground.Caption = bkgList(activeBkgIndex).filename
    
    bkgList(activeBkgIndex).needUpdate = False
    Call tkMainForm.tvAddFile(dlg.strDefaultFolder & bkgList(activeBkgIndex).filename)
End Sub

'=========================================================================
' Common menus
'=========================================================================
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
