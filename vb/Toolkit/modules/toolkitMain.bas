Attribute VB_Name = "toolkitMain"
'=======================================================================
' All contents copyright 2003, 2004, Christopher Matthews or Contributors
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=======================================================================

'=======================================================================
' Toolkit3 Entry Point
'=======================================================================

Option Explicit

'=======================================================================
' Declarations
'=======================================================================
Private Declare Function InitCommonControlsEx Lib "comctl32.dll" (ByRef iccex As tagInitCommonControlsEx) As Boolean

'=======================================================================
' Common controls structure
'=======================================================================
Private Type tagInitCommonControlsEx
   lngSize As Long
   lngICC As Long
End Type

'=======================================================================
' Constants
'=======================================================================
Private Const ICC_USEREX_CLASSES = &H200

'=======================================================================
' Initiate the common controls
'=======================================================================
Public Function initCommonControls() As Boolean
    On Error Resume Next
    Dim iccex As tagInitCommonControlsEx
    iccex.lngSize = LenB(iccex)
    iccex.lngICC = ICC_USEREX_CLASSES
    Call InitCommonControlsEx(iccex)
    initCommonControls = (Err.number = 0)
End Function

'=======================================================================
' Toolkit main entry point
'=======================================================================
Public Sub Main()
    On Error Resume Next
    Call initCommonControls ' Applys XP visual styles, if avaliable
    Set configfile = New CConfig
    Call initRuntimes
    Call createFileAssociations
    Call StartTracing("tktrace.txt")
    Call Randomize(timer)
    Call BoardInit(boardList(activeBoardIndex).theData)
    Call TileAnmClear(tileAnmList(activeTileAnmIndex).theData)
    Call initCanvasEngine
    Call initDirectories
    Call initBoardAndTileEditor
    Call initPlayers
    Call initLocalization
    Call initTimer
    Call tkMainForm.Show
    Call displayTip
    Call askTutorial
End Sub

'=======================================================================
' Create "resource", "game", and "help" folders
'=======================================================================
Private Sub initDirectories()
    On Error Resume Next
    currentDir = CurDir$()
    Call MkDir(Mid(resourcePath, 1, Len(resourcePath) - 1))
    Call MkDir(Mid(gamPath, 1, Len(gamPath) - 1))
    Call MkDir(Mid(helpPath, 1, Len(helpPath) - 1))
End Sub

'=======================================================================
' Initiates player structure
'=======================================================================
Private Sub initPlayers()
    On Error Resume Next
    Dim i As Long
    For i = 1 To 6
        playerList(activePlayerIndex).theData.armorType(i) = 1
    Next i
    playerList(activePlayerIndex).theData.maxLevel = 99
    playerList(activePlayerIndex).theData.experienceIncrease = 2
End Sub

'=======================================================================
' Initiate runtimes
'=======================================================================
Private Sub initRuntimes()
    On Error Resume Next
    If Command$() <> "" Then Call ChDir(App.path)
    If Not (initRuntime()) Then
        Call ChDir("C:\Program Files\Toolkit3\")
        currentDir = CurDir()
        If Not initRuntime() Then
            Call MsgBox("Could not initialize actkrt3.dll.  Do you have actkrt3.dll, freeimage.dll, and audiere.dll in the working directory?")
            End
        End If
    End If
End Sub

'=======================================================================
' Initiate splash screen timer
'=======================================================================
Private Sub initTimer()
    On Error Resume Next
    frmMain.Timer1.Interval = 1
    If (Command$() <> "") Then
        'Do nothing
    ElseIf GetSetting("RPGToolkit3", "Settings", "Splash", "1") = "0" Then
        'Do nothing
    Else
        frmMain.Timer1.Interval = 3800
        Call frmMain.Show(vbModal)
    End If
End Sub

'=======================================================================
' Initiate the enemy editor
'=======================================================================
Private Sub initEnemyEditor()
    On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneSizeX = 1
    enemylist(activeEnemyIndex).theData.eneSizeY = 1
End Sub

'=======================================================================
' Initiate the board and tile editors
'=======================================================================
Private Sub initBoardAndTileEditor()
    On Error Resume Next
    Dim x As Long, y As Long
    boardList(activeBoardIndex).spotLightRadius = 2
    boardList(activeBoardIndex).percentFade = 100
    detail = 1
    For x = 1 To 19
        For y = 1 To 11
            boardList(activeBoardIndex).BoardTile(x, y) = -1
        Next y
    Next x
    boardList(activeBoardIndex).theData.brdColor = vbQBColor(15)
    boardList(activeBoardIndex).theData.bSizeX = 19
    boardList(activeBoardIndex).theData.bSizeY = 11
    Call setupAutoTiler ' initialize autotiler tilemorphs
    
    ' Initiate a first tile editor doc (for tilemem use elsewhere - bug fix).
    tileedit.indice = newTileEditIndice()
    Call clearTileDoc(openTileEditorDocs(tileedit.indice))
    
End Sub

'=======================================================================
' Initiate the localization system
'=======================================================================
Private Sub initLocalization()
    On Error Resume Next
    If m_LangFile = "" Then
        m_LangFile = "0english.lng"
    End If
    Call ChangeLanguage(resourcePath & m_LangFile)
    Call InitLocalizeSystem
    ' Call LocalizeForm(frmMain)
End Sub

'=======================================================================
' Display a tip if they are enabled
'=======================================================================
Private Sub displayTip()
    On Error Resume Next
    If configfile.tipsOnOff = 1 Then
        Call tips.Show(vbModal)
    End If
End Sub

'=======================================================================
' Ask to show the tutorial if we haven't before
'=======================================================================
Private Sub askTutorial()
    On Error Resume Next
    If configfile.tutCurrentLesson = 0 Then
        Call tutorialask.Show(vbModal)
    End If
End Sub
