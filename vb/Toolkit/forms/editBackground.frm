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
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4890
   ScaleWidth      =   6435
   Tag             =   "4"
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
      TabIndex        =   13
      Top             =   120
      Width           =   6135
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   4800
         ScaleHeight     =   375
         ScaleWidth      =   1215
         TabIndex        =   15
         Top             =   360
         Width           =   1215
         Begin VB.CommandButton Command1 
            Caption         =   "Browse"
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
            TabIndex        =   16
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
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
         TabIndex        =   14
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
      TabIndex        =   4
      Tag             =   "1028"
      Top             =   2400
      Width           =   6135
      Begin VB.PictureBox Picture3 
         BorderStyle     =   0  'None
         Height          =   1695
         Left            =   4680
         ScaleHeight     =   1695
         ScaleWidth      =   1335
         TabIndex        =   19
         Top             =   360
         Width           =   1335
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
            Left            =   0
            TabIndex        =   23
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
            Left            =   0
            TabIndex        =   22
            Tag             =   "1021"
            Top             =   1080
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
            Left            =   0
            TabIndex        =   21
            Tag             =   "1021"
            Top             =   360
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
            Left            =   0
            TabIndex        =   20
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
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
         TabIndex        =   11
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
         TabIndex        =   10
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
         TabIndex        =   9
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
         TabIndex        =   8
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
         TabIndex        =   7
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
         TabIndex        =   6
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
         TabIndex        =   5
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
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   615
         Left            =   4680
         ScaleHeight     =   615
         ScaleWidth      =   1215
         TabIndex        =   17
         Top             =   360
         Width           =   1215
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
            Left            =   0
            TabIndex        =   18
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
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
         TabIndex        =   3
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
         TabIndex        =   2
         Top             =   720
         Width           =   375
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
Attribute VB_Name = "editBackground"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Background editor
'=========================================================================

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
Public Sub saveFile()

#If (False) Then

    On Error Resume Next
    Dim file As String
    file = bkgList(activeBkgIndex).filename
    bkgList(activeBkgIndex).needUpdate = False
    If file = "" Then
        Call Me.Show
        Call mnusaveas_Click
        Exit Sub
    End If
    Call saveBackground(projectPath$ + enePath$ + filename$(2), bkgList(activeBkgIndex).theData)

#Else

    Call Show
    Call mnusave_Click

#End If

End Sub

'=========================================================================
' Save file as
'=========================================================================
Public Sub saveAsFile()
    On Error Resume Next
    If bkgList(activeBkgIndex).needUpdate = True Then
        Call Me.Show
        Call mnusaveas_Click
    End If
End Sub

'=========================================================================
' Open a file
'=========================================================================
Public Sub openFile(ByVal filename As String)
    On Error Resume Next
    Dim antiPath As String
    activeBackground.Show
    If filename$ = "" Then Exit Sub
    Call openBackground(filename$, bkgList(activeBkgIndex).theData)
    antiPath$ = absNoPath(filename$)
    bkgList(activeBkgIndex).filename = antiPath$
    Me.Caption = LoadStringLoc(1435, "Edit Background") + "  (" + antiPath$ + ")"
    Call infofill
    bkgList(activeBkgIndex).needUpdate = False
End Sub

'=========================================================================
' Fields on the form
'=========================================================================
Private Sub clickbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgSelWav$ = clickbox.Text
End Sub
Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim antiPath As String
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmpPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
    bkgList(activeBkgIndex).theData.image = antiPath$
    Text2.Text = antiPath$
End Sub
Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediaPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgSelWav$ = antiPath$
    clickbox.Text = antiPath$
End Sub
Private Sub Command3_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediaPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgChooseWav$ = antiPath$
    selectbox.Text = antiPath$
End Sub
Private Sub Command4_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediaPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgCantDoWav$ = antiPath$
    illegalbox.Text = antiPath$
End Sub
Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediaPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgReadyWav$ = antiPath$
    readybox.Text = antiPath$
End Sub
Private Sub Command6_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + mediaPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    bkgList(activeBkgIndex).theData.bkgMusic$ = antiPath$
    Text1.Text = antiPath$
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
errmid2:

End Sub
Private Sub Command9_Click()
    On Error GoTo ErrorHandler
    
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
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
Private Sub illegalbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgCantDoWav$ = illegalbox.Text
End Sub
Private Sub readybox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgReadyWav$ = readybox.Text
End Sub
Private Sub selectbox_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.bkgChooseWav$ = selectbox.Text
End Sub
Private Sub Text1_Change()
    bkgList(activeBkgIndex).theData.bkgMusic$ = Text1.Text
End Sub
Private Sub Text2_Change()
    On Error Resume Next
    bkgList(activeBkgIndex).theData.image = Text2.Text
End Sub

'=========================================================================
' Form activate
'=========================================================================
Private Sub Form_Activate()
    On Error Resume Next
    Set activeBackground = Me
    Set activeForm = Me
    activeBkgIndex = dataIndex
    Call hideAllTools
End Sub

'=========================================================================
' Form load
'=========================================================================
Private Sub Form_Load()
    On Error Resume Next
    ' Call LocalizeForm(Me)
    Set activeBackground = Me
    dataIndex = VectBackgroundNewSlot()
    activeBkgIndex = dataIndex
    Call BackgroundClear(bkgList(dataIndex).theData)
End Sub

'=========================================================================
' Form unload
'=========================================================================
Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
    Call tkMainForm.refreshTabs
End Sub

'=========================================================================
' Fill in this form
'=========================================================================
Private Sub infofill()
    On Error Resume Next
    If bkgList(activeBkgIndex).theData.image <> "" Then
        Text2.Text = bkgList(activeBkgIndex).theData.image
    End If
    If bkgList(activeBkgIndex).theData.bkgMusic$ <> "" Then
        Text1.Text = bkgList(activeBkgIndex).theData.bkgMusic
    End If
    If bkgList(activeBkgIndex).theData.bkgSelWav$ <> "" Then
        clickbox.Text = bkgList(activeBkgIndex).theData.bkgSelWav
    End If
    If bkgList(activeBkgIndex).theData.bkgChooseWav$ <> "" Then
        selectbox.Text = bkgList(activeBkgIndex).theData.bkgChooseWav
    End If
    If bkgList(activeBkgIndex).theData.bkgReadyWav$ <> "" Then
        readybox.Text = bkgList(activeBkgIndex).theData.bkgReadyWav
    End If
    If bkgList(activeBkgIndex).theData.bkgCantDoWav$ <> "" Then
        illegalbox.Text = bkgList(activeBkgIndex).theData.bkgCantDoWav
    End If
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
Private Sub mnusave_Click()
    On Error Resume Next
    Dim file As String
    file = bkgList(activeBkgIndex).filename
    If (LenB(file) = 0) Then Call mnusaveas_Click: Exit Sub
    file = projectPath & bkgPath & file
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
Private Sub mnusaveas_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String, aa As Long, bb As Long
    dlg.strDefaultFolder = projectPath$ + bkgPath$
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub

    bkgList(activeBkgIndex).filename = antiPath$
    ' Call saveBackground(filename$(1), bkgList(activeBkgIndex).theData)
    Call mnusave_Click
    activeBackground.Caption = LoadStringLoc(1435, "Edit Background") + " (" + antiPath$ + ")"
    ' bkgList(activeBkgIndex).needUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
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
