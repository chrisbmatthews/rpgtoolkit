VERSION 5.00
Begin VB.Form editBackground 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Background"
   ClientHeight    =   4890
   ClientLeft      =   2520
   ClientTop       =   1530
   ClientWidth     =   6435
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
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4890
   ScaleWidth      =   6435
   Tag             =   "1435"
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
      Left            =   120
      TabIndex        =   18
      Top             =   120
      Width           =   6135
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
         Left            =   4800
         TabIndex        =   20
         Tag             =   "1021"
         Top             =   360
         Width           =   1095
      End
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
         TabIndex        =   19
         Top             =   360
         Width           =   4335
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
      Height          =   2295
      Left            =   120
      TabIndex        =   5
      Tag             =   "1028"
      Top             =   2400
      Width           =   6135
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
         Left            =   4800
         TabIndex        =   17
         Tag             =   "1021"
         Top             =   360
         Width           =   1095
      End
      Begin VB.CommandButton Command3 
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
         Left            =   4800
         TabIndex        =   16
         Tag             =   "1021"
         Top             =   720
         Width           =   1095
      End
      Begin VB.CommandButton Command4 
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
         Left            =   4800
         TabIndex        =   15
         Tag             =   "1021"
         Top             =   1440
         Width           =   1095
      End
      Begin VB.CommandButton Command5 
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
         Left            =   4800
         TabIndex        =   14
         Tag             =   "1021"
         Top             =   1080
         Width           =   1095
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
         TabIndex        =   13
         Text            =   "None"
         Top             =   360
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
         TabIndex        =   12
         Text            =   "None"
         Top             =   1080
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
         TabIndex        =   11
         Text            =   "None"
         Top             =   720
         Width           =   1935
      End
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
         TabIndex        =   10
         Text            =   "None"
         Top             =   1440
         Width           =   1935
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
         TabIndex        =   9
         Tag             =   "1031"
         Top             =   360
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
         TabIndex        =   8
         Tag             =   "1030"
         Top             =   720
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
         TabIndex        =   7
         Tag             =   "1029"
         Top             =   1080
         Width           =   2175
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
         TabIndex        =   6
         Tag             =   "1027"
         Top             =   1440
         Width           =   2175
      End
   End
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
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Tag             =   "1033"
      Top             =   1080
      Width           =   6135
      Begin VB.CommandButton Command9 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   600
         Picture         =   "editBackground.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   720
         Width           =   375
      End
      Begin VB.CommandButton Command8 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         Picture         =   "editBackground.frx":1994
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   720
         Width           =   375
      End
      Begin VB.CommandButton Command6 
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
         Left            =   4800
         TabIndex        =   2
         Tag             =   "1021"
         Top             =   360
         Width           =   1095
      End
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
         TabIndex        =   1
         Top             =   360
         Width           =   4335
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
Attribute VB_Name = "editBackground"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public dataIndex As Long    'index into the vector of enemies maintained in commonBackground

Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_BACKGROUND
End Function


Public Sub saveFile()
    'saves the file.
    On Error GoTo errorhandler
    Dim file As String
    'If bkgList(activeBkgIndex).needUpdate = True Then
        file = bkgList(activeBkgIndex).filename
        bkgList(activeBkgIndex).needUpdate = False
        If file = "" Then
            Me.Show
            Call mnusaveas_Click
            Exit Sub
        End If
        Call saveBackground(projectPath$ + enepath$ + filename$(2), bkgList(activeBkgIndex).theData)
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Public Sub saveAsFile()
    'saves the file.
    On Error GoTo errorhandler
    If bkgList(activeBkgIndex).needUpdate = True Then
        Me.Show
        mnusaveas_Click
    End If
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub




Public Sub checkSave()
    'check if the file has changed an it needs to be saved...
    On Error GoTo errorhandler
    If bkgList(activeBkgIndex).needUpdate = True Then
        Dim aa As Long
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Public Sub openFile(filename$)
    'open an effect
    On Error Resume Next
    Dim antiPath As String
    Call checkSave
    activeBackground.Show
    If filename$ = "" Then Exit Sub
    Call openBackground(filename$, bkgList(activeBkgIndex).theData)
    antiPath$ = absNoPath(filename$)
    bkgList(activeBkgIndex).filename = antiPath$
    Me.caption = LoadStringLoc(1435, "Edit Background") + "  (" + antiPath$ + ")"
    
    Call infofill
    
    bkgList(activeBkgIndex).needUpdate = False
End Sub

Private Sub clickbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgSelWav$ = clickbox.text
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim antiPath As String
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmppath$
    dlg.strTitle = "Open Bitmap"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmppath$ + antiPath$
    bkgList(activeBkgIndex).theData.image = antiPath$
    Text2.text = antiPath$
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgSelWav$ = antiPath$
    clickbox.text = antiPath$
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgChooseWav$ = antiPath$
    selectbox.text = antiPath$
End Sub

Private Sub Command4_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgCantDoWav$ = antiPath$
    illegalbox.text = antiPath$
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgReadyWav$ = antiPath$
    readybox.text = antiPath$
End Sub

Private Sub Command6_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Background Battle Music"
    dlg.strDefaultExt = "mid"
    dlg.strFileTypes = strFileDialogFilterMedia
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgList(activeBkgIndex).needUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgMusic$ = antiPath$
    Text1.text = antiPath$
End Sub


Private Sub Command8_Click()
    On Error GoTo errmid2
    If bkgList(activeBkgIndex).theData.bkgMusic$ = "" Then MsgBox LoadStringLoc(957, "Please Select A Filename!"), , LoadStringLoc(958, "Music Player"): Exit Sub
    Dim ext As String
    ext$ = extention(bkgList(activeBkgIndex).theData.bkgMusic$)
    If UCase$(ext$) = "WAV" Then
        'wFlags% = SND_ASYNC Or SND_NODEFAULT
        'x% = sndPlaySound(projectPath$ + mediapath$ + bkgList(activeBkgIndex).theData.bkgMusic$, wFlags%)
    Else
        'If UCase$(ext$) = "MID" Then
        '    OLE1.SourceDoc = projectPath$ + mediapath$ + bkgMusic$
        '    OLE1.Action = 1
        '    OLE1.Action = 7
        'Else
            'mp3player.Show
            'mp3player.playSong (projectPath$ + mediapath$ + bkgList(activeBkgIndex).theData.bkgMusic$)
        'End If
    End If
    Exit Sub
errmid2:
Exit Sub

End Sub

Private Sub Command9_Click()
    On Error GoTo errorhandler
    
    Dim ext As String
    ext$ = extention(bkgList(activeBkgIndex).theData.bkgMusic$)
    If UCase$(ext$) = "WAV" Then
        'wFlags% = SND_ASYNC
        'x% = sndPlaySound("stop.wav", wFlags%)
    Else
        'OLE1.Action = 10
        'Call mp3player.stopMusic
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    
    Set activeBackground = Me
    Set activeForm = Me
    activeBkgIndex = dataIndex
    
    'extras
    tkMainForm.bottomFrame.Visible = False
    tkMainForm.tileBmpExtras.Visible = False
    tkMainForm.animationExtras.Visible = False
    tkMainForm.tileExtras.Visible = False
    
    'tools
    tkMainForm.tilebmpTools.Visible = False
    tkMainForm.animationTools.Visible = False
    tkMainForm.rpgcodeTools.Visible = False
    tkMainForm.tileTools.Visible = False
    tkMainForm.boardTools.Visible = False
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Set activeBackground = Me
    dataIndex = VectBackgroundNewSlot()
    activeBkgIndex = dataIndex
    Call BackgroundClear(bkgList(dataIndex).theData)
    
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub illegalbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgCantDoWav$ = illegalbox.text
End Sub

Private Sub infofill()
    On Error GoTo errorhandler
    If bkgList(activeBkgIndex).theData.image <> "" Then
        Text2.text = bkgList(activeBkgIndex).theData.image
    End If
    If bkgList(activeBkgIndex).theData.bkgMusic$ <> "" Then
        Text1.text = bkgList(activeBkgIndex).theData.bkgMusic$
    End If
    If bkgList(activeBkgIndex).theData.bkgSelWav$ <> "" Then
        clickbox.text = bkgList(activeBkgIndex).theData.bkgSelWav$
    End If
    If bkgList(activeBkgIndex).theData.bkgChooseWav$ <> "" Then
        selectbox.text = bkgList(activeBkgIndex).theData.bkgChooseWav$
    End If
    If bkgList(activeBkgIndex).theData.bkgReadyWav$ <> "" Then
        readybox.text = bkgList(activeBkgIndex).theData.bkgReadyWav$
    End If
    If bkgList(activeBkgIndex).theData.bkgCantDoWav$ <> "" Then
        illegalbox.text = bkgList(activeBkgIndex).theData.bkgCantDoWav$
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub readybox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgReadyWav$ = readybox.text
End Sub

Private Sub selectbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgChooseWav$ = selectbox.text
End Sub

Private Sub Text1_Change()
    bkgList(activeBkgIndex).theData.bkgMusic$ = Text1.text
End Sub


Private Sub mnuCLose_Click()
    On Error GoTo errorhandler
    Unload Me
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnusave_Click()
    On Error GoTo errorhandler
    Dim file As String
    file = bkgList(activeBkgIndex).filename
    If file = "" Then Call mnusaveas_Click: Exit Sub
    Call saveBackground(projectPath$ + bkgpath$ + file, bkgList(activeBkgIndex).theData)
    bkgList(activeBkgIndex).needUpdate = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnusaveas_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String, aa As Long, bb As Long
    
    dlg.strDefaultFolder = projectPath$ + bkgpath$
    
    dlg.strTitle = "Save Background As"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    
    If filename$(1) = "" Then Exit Sub
    aa = fileExist(filename$(1))
    If aa = 1 Then
        bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
        If bb = 7 Then Exit Sub
    End If
    bkgList(activeBkgIndex).filename = antiPath$
    Call saveBackground(filename$(1), bkgList(activeBkgIndex).theData)
    activeBackground.caption = LoadStringLoc(1435, "Edit Background") + " (" + antiPath$ + ")"
    bkgList(activeBkgIndex).needUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub


Private Sub toc_Click()
    On Error GoTo errorhandler
    Call BrowseFile(helppath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
errorhandler:
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

Private Sub Text2_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.image = Text2.text
End Sub


