Attribute VB_Name = "transMain"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'=======================================================================
' Trans engine entry (and exit) procedures
' Status: A-
'=======================================================================

Option Explicit

'=======================================================================
' Declarations
'=======================================================================
Private Declare Sub mainEventLoop Lib "actkrt3.dll" (ByVal gameLogicAddress As Long)

'=======================================================================
' Game state enumeration
'=======================================================================
Public Enum GAME_LOGIC_STATE
    GS_IDLE = 0                         ' Just re-renders the screen
    GS_QUIT = 1                         ' Shutdown sequence
    GS_MOVEMENT = 2                     ' Movement is occurring (players or items)
    GS_DONEMOVE = 3                     ' Movement is occurring (players or items)
    GS_PAUSE = 4                        ' Pause game (do nothing)
End Enum

'=======================================================================
' Globals
'=======================================================================
Public gGameState As GAME_LOGIC_STATE   ' Current game state
Public saveFileLoaded As Boolean        ' Was the game loaded from start menu?
Public runningAsEXE As Boolean          ' Are we running as an exe file?
Public gShuttingDown As Boolean         ' Has the shutdown process been initiated?
Public host As CDirectXHost             ' DirectX host window

'=======================================================================
' Members
'=======================================================================
Private m_renderCount As Long           ' Count of GS_MOVEMENT state loops
Private m_renderTime As Double          ' Cumulative GS_MOVEMENT state loop time

Private m_testingPRG As Boolean         'Are we testing a program?

'=======================================================================
' Average time for one loop in the GS_MOVEMENT gamestate
'=======================================================================
Public Property Get gAvgTime() As Double
    gAvgTime = m_renderTime / m_renderCount
End Property
Public Property Let gAvgTime(ByVal newVal As Double)
    m_renderTime = newVal
    m_renderCount = 1
End Property

'=======================================================================
' Main entry point
'=======================================================================
Public Sub Main()

    On Error Resume Next

    ' Init some misc stuff
    Call initDefaults

    ' Get a main filename
    Dim mainFile As String
    mainFile = getMainFilename()

    ' If we got one
    If (LenB(mainFile)) Then

        ' Open the main file
        Call openMain(mainFile, mainMem)

        ' Startup
        Call openSystems

        ' Run game
        Call mainEventLoop(AddressOf gameLogic)

    End If

End Sub

'=======================================================================
' Close systems
'=======================================================================
Public Sub closeSystems()
    On Error Resume Next
    gShuttingDown = True
    Call saveSettings
    Call ClearAllThreads
    Call stopMedia
    Call stopMenuPlugin
    Call stopFightPlugin
    Call EndPlugins
    Call ShutdownVarSystem
    Call AnimationShutdown
    Call destroyGraphics
    Call UnLoadFontsFromFolder(projectPath & fontPath)
    Call killMedia
    Call DeletePakTemp
    Call setupCOM(False)
    Call host.Destroy
    Call Unload(debugWin)
    Set host = Nothing
    Set inv = Nothing
    Call showEndForm(True)  ' Ends program
End Sub

'=======================================================================
' Get a main filename
'=======================================================================
Private Function getMainFilename() As String

    ' Precedence is as follows:
    '  + Command line
    '  + Main.gam
    '  + File dialog

    On Error Resume Next

    If (LenB(Command$())) Then

        Dim args() As String
        args() = Split(Command$(), " ")

        If (UBound(args) = 0) Then

            If (LCase$(GetExt(Command$())) = "tpk") Then

                Call setupPakSystem(TempDir & Command$())
                Call Kill(PakFileMounted)
                Call ChDir(currentDir)
                getMainFilename = "main.gam"
                projectPath = vbNullString
                errorBranch = "Resume Next"
                savPath = GetSetting("TK3 EXE HOST", "Settings", "Save Path", vbNullString)
                Call DeleteSetting("TK3 EXE HOST", "Settings", "Save Path")
                If (LenB(savPath) = 0) Then
                    savPath = "Saved\"
                Else
                    runningAsEXE = True
                End If

            Else

                getMainFilename = gamPath & Command$()

            End If

        ElseIf (UBound(args) = 1) Then

            ' Run program
            m_testingPRG = True
            mainFile = gamPath & args(0)
            Call openMain(mainFile, mainMem)
            Call openSystems
            Call DXClearScreen(0)
            Call DXRefresh
            Call runProgram(projectPath & prgPath & args(1), , , True)
            Call closeSystems

        End If

    Else

        If (fileExists(gamPath & "main.gam")) Then

            ' Main.gam exists.
            getMainFilename = gamPath & "main.gam"

        Else

            Call ChDir(currentDir)

            Dim dlg As FileDialogInfo
            With dlg
                .strDefaultFolder = gamPath
                .strSelectedFile = vbNullString
                .strTitle = "Open Main File"
                .strDefaultExt = "gam"
                .strFileTypes = "Supported Files|*.gam;*.tpk|RPG Toolkit Main File (*.gam)|*.gam|RPG Toolkit PakFile (*.tpk)|*.tpk|All files(*.*)|*.*"
                If Not (OpenFileDialog(dlg)) Then ' User pressed cancel
                    Exit Function
                End If
                loadedMainFile = .strSelectedFile
            End With

            Call ChDir(currentDir)

            Dim whichType As String
            whichType = GetExt(loadedMainFile)

            If (UCase$(whichType) = "TPK") Then
                Call setupPakSystem(loadedMainFile)
                getMainFilename = "main.gam"
                projectPath = vbNullString
            Else
                getMainFilename = loadedMainFile
            End If

        End If

    End If

    Call correctPaths

End Function

'=========================================================================
' Correct game paths
'=========================================================================
Private Sub correctPaths()

    On Error Resume Next

    ' If we're running from a single file, the project is in this directory
    If ((runningAsEXE) Or (pakFileRunning)) Then
        projectPath = vbNullString
        currentDir = TempDir() & "TKCache\"
    End If

    ' Make sure we're still in the right directory
    Call ChDir(currentDir)

End Sub

'=======================================================================
' Init some common stuff
'=======================================================================
Private Sub initGame()
    On Error Resume Next
    Call Randomize(Timer)
    currentDir = CurDir$()
    Call InitThreads
    Call initVarSystem
    Set inv = New CInventory
    Set host = New CDirectXHost
    menuColor = RGB(0, 0, 0)
    MWinSize = 90
    mainMem.mainScreenType = 2
    savPath = "Saved\"
    Call MkDir(Mid$(savPath, 1, Len(savPath) - 1))
    ReDim boardList(0)
    ReDim boardListOccupied(0)
    boardListOccupied(0) = True
    Call InitLocalizeSystem
End Sub

'=======================================================================
' Set the defaults
'=======================================================================
Private Sub initDefaults()
    On Error Resume Next
    initTime = Timer()
    Call StartTracing("trace.txt")
    If Not (initRuntime()) Then
        Call ChDir("C:\Program Files\Toolkit3\")
        currentDir = CurDir$()
        If Not initRuntime() Then
            Call MsgBox("Could not initialize actkrt3.dll. Do you have actkrt3.dll, " & _
                        "freeimage.dll, and audiere.dll in the working directory, " & _
                        "and do you have DirectX version 8 or above installed?")
            End
        End If
    End If
    Call initGame
End Sub

'=======================================================================
' Runs one 'frame' of the game logic
'=======================================================================
Private Sub gameLogic()

    On Local Error Resume Next

    ' This procedure contains all of the engine's logic. It is constantly
    ' called until gGameState == GS_QUIT, the user closes the window, or
    ' a few other things.

    Dim renderOccured As Boolean
    Static loopTime As Double
    loopTime = Timer()

    Static checkFight As Long   ' Used to track number of times fighting
                                ' *would* have been checked for if not
                                ' in pixel movement. In pixel movement,
                                ' only check every four steps (one tile).

    Select Case gGameState

        Case GS_IDLE            'IDLE STATE
                                '----------

            ' Keep the music looping
            Call checkMusic

            ' Scan for important keys
            Call scanKeys

            ' Update time game has been running for
            gameTime = (Timer() - initTime) + addTime

            ' Check the player's queue to see if movement is about to start.
            If (pendingPlayerMovement(selectedPlayer).queue.lngSize) Then
                ' There is a queue.
                gGameState = GS_MOVEMENT
            End If

            If (gGameState <> GS_MOVEMENT) Then
                ' Check we're not about to start moving again.
                Call multiTaskNow
                Call moveItems
            End If

            ' Render the scene
            renderOccured = renderNow()

        Case GS_PAUSE           'PAUSE STATE
                                '-----------

            ' Just keep the music looping
            Call checkMusic

        Case GS_MOVEMENT        'MOVEMENT STATE
                                '--------------

            ' Make sure this runs for the duration of the player's move.
            ' Run this before movePlayers since .loopFrame will be reset by it.
            If (pPos(selectedPlayer).loopFrame + 1 < framesPerMove * playerMem(selectedPlayer).loopSpeed) Then
                ' We're still moving
                gGameState = GS_MOVEMENT
            Else
                ' We're done movement
                gGameState = GS_DONEMOVE
            End If

            Call multiTaskNow
            Call movePlayers
            Call moveItems

            ' Re-render the scene
            renderOccured = renderNow(-1, True)

        Case GS_DONEMOVE        'DONE MOVEMENT STATE
                                '-------------------

            With pendingPlayerMovement(selectedPlayer)

                ' Check if player moved
                If (.direction <> MV_IDLE) Then
                    ' We'll create a temporary player position which is based on
                    ' the target location for that players' movement.
                    ' lets us test solid tiles, etc.

                    Dim tempPos As PLAYER_POSITION
                    tempPos = pPos(selectedPlayer)
                    tempPos.l = .lTarg
                    tempPos.x = .xTarg
                    tempPos.y = .yTarg

                    ' Test for a program
                    Call programTest(tempPos)

                    ' Flag player is no longer moving
                    .direction = MV_IDLE

                    ' Test for a fight
                    checkFight = checkFight + 1
                    If (checkFight = (1 / movementSize)) Then
                        Call fightTest
                        checkFight = 0
                    End If

                End If

            End With

            ' Clear player movements
            Dim i As Long
            For i = 0 To UBound(pendingPlayerMovement)
                pendingPlayerMovement(i).direction = MV_IDLE
            Next i

            ' Convert *STUPID* string positions to numerical
            Select Case UCase$(pPos(selectedPlayer).stance)
                Case "WALK_S": facing = SOUTH
                Case "WALK_W": facing = WEST
                Case "WALK_N": facing = NORTH
                Case "WALK_E": facing = EAST
            End Select

            ' Back to idle state
            gGameState = GS_IDLE

        Case GS_QUIT            'QUIT STATE
                                '----------
            ' End the program
            Call endProgram

    End Select

    ' Time a render
    If renderOccured Then
        loopTime = Timer() - loopTime
        If loopTime < 1 / 4 Then
            ' No machine should render slower than this, so > 1/4 would be anomalous, and
            ' would unbalance the average (at least early on).
            m_renderTime = m_renderTime + loopTime
            m_renderCount = m_renderCount + 1
        End If
    End If

    ' Show FPS in title bar if enabled
    If (mainMem.bFpsInTitleBar) Then

        ' Build the string
        host.Caption = mainMem.gameTitle & " [" & CStr(Round(m_renderCount / m_renderTime, 1)) & " fps]"

    End If

End Sub

'=======================================================================
' Open systems
'=======================================================================
Private Sub openSystems()
    On Error Resume Next
    Call initEventProcessor
    Call initSprites
    Call initGraphics(m_testingPRG) ' Creates host window
    Call setupCOM(True)
    Call correctPaths
    Call InitPlugins
    Call BeginPlugins
    Call startMenuPlugin
    Call startFightPlugin
    Call initMedia
    Call DXClearScreen(0)
    Call DXRefresh
    Call setupMain
End Sub

'=======================================================================
' Register or unregister COM components
'=======================================================================
Private Sub setupCOM(ByVal bInitiate As Boolean)

    On Error Resume Next

    Dim i As Long, ub As Long
    ub = UBound(mainMem.plugins)

    ' Loop over every plugin
    For i = 0 To ub
        If (LenB(mainMem.plugins(i))) Then
            Call registerServer(projectPath & plugPath & mainMem.plugins(i), host.hwnd, bInitiate)
        End If
    Next i

    ' Finally, the menu and battle plugins
    Call registerServer(projectPath & plugPath & mainMem.menuPlugin, host.hwnd, bInitiate)
    Call registerServer(projectPath & plugPath & mainMem.fightPlugin, host.hwnd, bInitiate)

End Sub

'=======================================================================
' Set some things based on the main file
'=======================================================================
Public Sub setupMain(): On Error Resume Next

    ' Setup the cursor
    host.cursorHotSpotX = mainMem.hotSpotX
    host.cursorHotSpotY = mainMem.hotSpotY
    host.mousePointer = mainMem.mouseCursor

    ' Set default shop colors
    shopColors(0) = -1

    ' If we're running as an exe, don't show the debug window!
    If Not (runningAsEXE) Then
        debugYN = 1
    Else
        debugYN = 0
    End If

    fontName = "Arial"              ' Default true type font
    fontSize = 20                   ' Default font ize
    fontColor = vbQBColor(15)       ' White
    MWinBkg = vbQBColor(0)          ' Black
    mwinLines = 4                   ' Lines MWin can hold
    textX = 1                       ' Text location X
    textY = 1                       ' Text location Y
    lineNum = 1                     ' First line in MWin
    saveFileLoaded = False          ' Starting new game

    ' Set initial pixel movement value
    If (mainMem.pixelMovement) Then
        movementSize = 0.25
    Else
        movementSize = 1
    End If

    ' Set initial game speed
    Call gameSpeed(getGameSpeed(mainMem.gameSpeed))

    'Get the last gAvgTime from the registry.
    m_renderCount = 10
    m_renderTime = CDbl(GetSetting("RPGToolkit3", "Trans3", "gAvgTime", -1)) * m_renderCount

    If m_renderTime <= 0 Then
        ' Do a bad estimate of the fps.
        m_renderTime = Timer()
        Dim i As Long
        For i = 0 To 20
            Call DXFlip
        Next i
        m_renderTime = Timer() - m_renderTime
        m_renderCount = 15     ' Account for extra routine time in the movement loop
    End If

    ' Register all fonts
    Call LoadFontsFromFolder(projectPath & fontPath)

    ' Change the DirectX host's caption to the game's title (for windowed mode)
    If (LenB(mainMem.gameTitle)) Then
        host.Caption = mainMem.gameTitle
    End If

    If (LenB(mainMem.initChar)) Then
        ' If a main character has been specified, load it
        Call createCharacter(projectPath & temPath & mainMem.initChar, 0)
    End If

    ' Set up these before the start program runs, in case movement occurs before the
    ' start board loads
    selectedPlayer = 0          'Set to use player 0 as walking graphics
    facing = SOUTH              'Start him facing south

    ' Hide all players except the walking graphic one
    For i = 0 To UBound(showPlayer)
        showPlayer(i) = (i = selectedPlayer)
        pPos(i).stance = "WALK_S"
        pPos(i).loopFrame = -1
        ReDim pendingPlayerMovement(i).queue.lngMovements(16)
    Next i

    ' Unless we're testing a program from the PRG editor, run the startup program.
    If Not (m_testingPRG) Then
        Call runProgram(projectPath & prgPath & mainMem.startupPrg, , , True)
    End If

    ' Unless we loaded a game (using Load()) or we're testing a PRG from
    ' the program editor, send the player to the initial board
    If ((Not (saveFileLoaded)) And (Not (m_testingPRG))) Then

        ' Nullify some variables
        scTopX = -1000
        scTopY = -1000
        ' lastRender.canvas = -1

        ' Open up the starting board
        Call ClearNonPersistentThreads
        If (LenB(mainMem.initBoard)) Then
            Call destroyItemSprites
            Call openBoard(projectPath & brdPath & mainMem.initBoard, boardList(activeBoardIndex).theData)
            Call checkMusic(True)
            If (LenB(boardList(activeBoardIndex).theData.enterPrg)) Then
                Call runProgram(projectPath & prgPath & boardList(activeBoardIndex).theData.enterPrg)
            End If
        End If
        Call alignBoard(boardList(activeBoardIndex).theData.playerX, boardList(activeBoardIndex).theData.playerY)
        Call openItems
        Call launchBoardThreads(boardList(activeBoardIndex).theData)

        ' Setup player position, only if an initial board has been specified.
        If (LenB(mainMem.initBoard)) Then
            With pPos(selectedPlayer)
                .x = boardList(activeBoardIndex).theData.playerX
                .y = boardList(activeBoardIndex).theData.playerY
                .l = boardList(activeBoardIndex).theData.playerLayer
                pendingPlayerMovement(selectedPlayer).xOrig = .x
                pendingPlayerMovement(selectedPlayer).yOrig = .y
                pendingPlayerMovement(selectedPlayer).lOrig = .l
            End With
        End If
    End If

End Sub

'=======================================================================
' Save settings
'=======================================================================
Private Sub saveSettings(): On Error Resume Next

    'The average GS_MOVEMENT gamestate loop time.
    If (Not m_testingPRG) And (gAvgTime > 0) Then
        Call SaveSetting("RPGToolkit3", "Trans3", "gAvgTime", CStr(Round(gAvgTime, 5)))
    End If

End Sub
