Attribute VB_Name = "toolkitMain"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

Option Explicit

Public Sub Main()
    '=======================================================
    'Toolkit main entry point
    '=======================================================
    On Error Resume Next
    Call Load(configfile)
    Call initRuntimes
    Call initTimer
    Call createFileAssociations
    Call StartTracing("tktrace.txt")
    Call Randomize(Timer)
    Call BoardInit(boardList(activeBoardIndex).theData)
    Call TileAnmClear(tileAnmList(activeTileAnmIndex).theData)
    Call InitTkGfx
    Call initCanvasEngine
    Call initDirectories
    Call initBoardAndTileEditor
    Call initPlayers
    Call initLocalization
    Call ExecCmd("regsvr32 /s TABCTL32.OCX")
    Call frmMain.Show(vbModal)
    Call tkMainForm.Show
    Call displayTip
    Call askTutorial
End Sub

Private Sub initDirectories()
    '=======================================================
    'Create "resource", "game", and "help" folders
    '=======================================================
    On Error Resume Next
    currentDir = CurDir()
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
    If Command <> "" Then Call ChDir(App.path)
    If Not (InitRuntime()) Then
        Call ChDir("C:\Program Files\Toolkit3\")
        currentDir = CurDir()
        If Not InitRuntime() Then
            Call MsgBox("Could not initialize actkrt3.dll.  Do you have actkrt3.dll, freeimage.dll, and audiere.dll in the working directory?")
            End
        End If
    End If
End Sub

Private Sub initTimer()
    '=======================================================
    'Initiate splash screen timer
    '=======================================================
    On Error Resume Next
    frmMain.Timer1.interval = 1
    If Command <> "" Then
        'Do nothing
    ElseIf GetSetting("RPGToolkit3", "Settings", "Splash", "1") = "0" Then
        frmMain.Visible = False
    Else
        frmMain.Timer1.interval = 3800
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
    Dim X As Long, Y As Long
    boardList(activeBoardIndex).spotLightRadius = 2
    boardList(activeBoardIndex).percentFade = 100
    detail = 1
    For X = 1 To 19
        For Y = 1 To 11
            boardList(activeBoardIndex).BoardTile(X, Y) = -1
        Next Y
    Next X
    boardList(activeBoardIndex).theData.brdColor = vbQBColor(15)
    boardList(activeBoardIndex).theData.bSizeX = 19
    boardList(activeBoardIndex).theData.bSizeY = 11
End Sub

Private Sub initLocalization()
    '=======================================================
    'Initiate the localization system
    '=======================================================
    On Error Resume Next
    If m_LangFile = "" Then
        m_LangFile = "0english.lng"
    End If
    Call ChangeLanguage(resourcePath & m_LangFile)
    Call InitLocalizeSystem
    Call LocalizeForm(frmMain)
End Sub

Private Sub displayTip()
    '=======================================================
    'Display a tip if they are enabled
    '=======================================================
    On Error Resume Next
    If configfile.tipsOnOff = 1 Then
        Call tips.Show
    End If
End Sub

Private Sub askTutorial()
    '=======================================================
    'Ask to show the tutorial if we haven't before
    '=======================================================
    On Error Resume Next
    If configfile.tutCurrentLesson = 0 Then
        Call tutorialask.Show(vbModal)
    End If
End Sub
