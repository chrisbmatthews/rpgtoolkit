VERSION 5.00
Begin VB.Form frmMain 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "RPG Toolkit Development System Version 2.0"
   ClientHeight    =   3720
   ClientLeft      =   2355
   ClientTop       =   840
   ClientWidth     =   5955
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
   Icon            =   "TITLE.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   Picture         =   "TITLE.frx":0CCA
   ScaleHeight     =   3720
   ScaleWidth      =   5955
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1092"
   Begin VB.Timer Timer1 
      Interval        =   1800
      Left            =   1080
      Top             =   2160
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Release 3.0.4 (August 2004)"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   2880
      Width           =   2775
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Professional Edition [Registered]"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Tag             =   "1093"
      Top             =   3120
      Width           =   2415
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright 2003, 2004 By Christopher B. Matthews And Contibutors"
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2520
      TabIndex        =   0
      Tag             =   "1094"
      Top             =   3240
      Width           =   3495
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Option Explicit added
' + Removed obsolete code
' + Organized startup code more effectively
' + Made some things constants
' + Added option to disable splash screen
' + Purpose of procedure noted
'
'=======================================================

Option Explicit

Public Sub Form_Click()
    '=======================================================
    'Start the main program
    '=======================================================
    On Error Resume Next
    Call Unload(Me)
    Call tkMainForm.Show
    Call displayTip
    Call askTutorial
End Sub

Private Sub Form_Load()
    '=======================================================
    'Initialize everything
    '=======================================================
    On Error Resume Next
    Call initRuntimes
    Call openConfig("toolkit.cfg")
    Call initTimer
    Call createFileAssociations
    Call StartTracing("tktrace.txt")
    Call Randomize(Timer)
    Call BoardInit(boardList(activeBoardIndex).theData)
    Call TileAnmClear(tileAnmList(activeTileAnmIndex).theData)
    Call InitTkGfx
    Call InitCanvasEngine
    Call initDirectories
    Call initBoardAndTileEditor
    Call initLocalization
End Sub

Private Sub initDirectories()
    '=======================================================
    'Create "resource", "game", and "help" folders
    '=======================================================
    On Error Resume Next
    currentDir = CurDir
    Call MkDir(Mid(resourcePath, 1, Len(resourcePath) - 1))
    Call MkDir(Mid(gamPath, 1, Len(gamPath) - 1))
    Call MkDir(Mid(helpPath, 1, Len(helpPath) - 1))
End Sub

Private Sub initPlayers()
    '=======================================================
    'Initiates player structure
    '=======================================================
    On Error Resume Next
    Dim a As Long
    For a = 1 To 6
        playerList(activePlayerIndex).theData.armorType(a) = 1
    Next a
    playerList(activePlayerIndex).theData.maxLevel = 99
    playerList(activePlayerIndex).theData.experienceIncrease = 2
End Sub

Private Sub initRuntimes()
    '=======================================================
    'Initiate runtimes
    '=======================================================
    On Error Resume Next
    If Not InitRuntime() Then
        Call MsgBox("Could not initialize actkrt3.dll.  Do you have actkrt3.dll and freeimage.dll in the working directory?")
        End
    End If
    mainMem.mainResolution = 0
End Sub

Private Sub initTimer()
    '=======================================================
    'Initiate splash screen timer
    '=======================================================
    On Error Resume Next
    Timer1.interval = 1
    If Command <> "" Then
        'Do nothing
    ElseIf GetSetting("RPGToolkit3", "Settings", "Splash", "1") = "0" Then
        Me.Visible = False
    Else
        Timer1.interval = 1000
    End If
End Sub

Private Sub initEnemyEditor()
    '=======================================================
    'Initiate the enemy editor
    '=======================================================
    On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneSizeX = 1
    enemylist(activeEnemyIndex).theData.eneSizeY = 1
End Sub

Private Sub initBoardAndTileEditor()
    '=======================================================
    'Initiate the board and tile editors
    '=======================================================
    On Error Resume Next
    Dim x As Long, y As Long
    boardList(activeBoardIndex).spotLightRadius = 2
    boardList(activeBoardIndex).percentFade = 100
    detail = 1
    For x = 1 To 32
        For y = 1 To 32
            tilemem(x, y) = -1
            publicTile.Undotile(x, y) = -1
            boardList(activeBoardIndex).BoardTile(x, y) = -1
        Next y
    Next x
    boardList(activeBoardIndex).theData.brdColor = vbQBColor(15)
    boardList(activeBoardIndex).theData.Bsizex = 19
    boardList(activeBoardIndex).theData.Bsizey = 11
End Sub

Private Sub initLocalization()
    '=======================================================
    'Initiate the localization system
    '=======================================================
    On Error Resume Next
    If m_LangFile = "" Then
        Call selectLanguage.Show(vbModal)
    Else
        Call ChangeLanguage(resourcePath & m_LangFile)
    End If
    Call InitLocalizeSystem
    Call LocalizeForm(Me)
End Sub

Private Sub displayTip()
    '=======================================================
    'Display a tip if they are enabled
    '=======================================================
    On Error Resume Next
    If tipsOnOff = 1 Then
        Call tips.Show(vbModal)
    End If
End Sub

Private Sub askTutorial()
    '=======================================================
    'Ask to show the tutorial if we haven't before
    '=======================================================
    On Error Resume Next
    If tutCurrentLesson = 0 Then
        Call tutorialask.Show(vbModal)
    End If
End Sub

Private Sub Timer1_Timer()
    '=======================================================
    'Close the splash screen
    '=======================================================
    On Error Resume Next
    Call Form_Click
End Sub
