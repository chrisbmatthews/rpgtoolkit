Attribute VB_Name = "transMain"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'=======================================================================
' Trans engine entry procedures
' Status: A-
'=======================================================================

Option Explicit

'=======================================================================
' Declarations
'=======================================================================

Public gGameState As GAME_LOGIC_STATE   'current state of logic

Public Enum GAME_LOGIC_STATE            'state of gameLogic() procedure
    GS_IDLE = 0                         '  just re-renders the screen
    GS_QUIT = 1                         '  shutdown sequence
    GS_MOVEMENT = 2                     '  movement is occurring (players or items)
    GS_DONEMOVE = 3                     '  movement is finished
    GS_PAUSE = 4                        '  pause game (do nothing)
End Enum

Public movementCounter As Long          'number of times GS_MOVEMENT has been run (should be 4 before moving onto GS_DONEMOVE)
Public saveFileLoaded As Boolean        'was the game loaded from start menu?
Public runningAsEXE As Boolean          'are we running as an exe file?
Public gShuttingDown As Boolean         'Has the shutdown process been initiated?
Public slackTime As Double              'cpu speed estimate
Public host As New clsDirectXHost       'DirectX host window

'=======================================================================
' Main entry point
'=======================================================================
Public Sub Main()

    On Error Resume Next

    'Init some misc stuff
    Call initDefaults

    'Get a main filename
    Dim mainfile As String
    mainfile = getMainFilename()

    'If we got one
    If mainfile <> "" Then

        'Open the main file
        Call openMain(mainfile, mainMem)

        'Startup
        Call openSystems

        'Run game
        Call host.mainEventLoop

    End If

End Sub

'=======================================================================
' Close systems
'=======================================================================
Public Sub closeSystems()
    On Error Resume Next
    gShuttingDown = True
    Call stopMedia
    Call stopMenuPlugin
    Call stopFightPlugin
    Call EndPlugins
    Call ShutdownVarSystem
    Call AnimationShutdown
    Call destroyGraphics
    Call UnLoadFontsFromFolder(projectPath & fontPath)
    Call ClearAllThreads
    Call killMedia
    Call DeletePakTemp
    Call CloseWindow(host.hwnd)
    Call DestroyWindow(host.hwnd)
    Call UnregisterClass(host.className, App.hInstance)
    Call Unload(debugwin)
End Sub

'=======================================================================
' Get a main filename
'=======================================================================
Private Function getMainFilename() As String

    'Precedurence is as follows:
    ' + Command line
    ' + Main.gam
    ' + File dialog

    On Error Resume Next
   
    If Command <> "" Then

        Dim args() As String
        args() = Split(Command, " ", , vbTextCompare)

        If UBound(args) = 0 Then

            If LCase(GetExt(Command)) = "tpk" Then

                Call setupPakSystem(TempDir & Command)
                Call Kill(PakFileMounted)
                Call ChDir(currentDir)
                getMainFilename = "main.gam"
                projectPath = ""
                errorBranch = "Resume Next"
                savPath = GetSetting("TK3 EXE HOST", "Settings", "Save Path", "")
                Call DeleteSetting("TK3 EXE HOST", "Settings", "Save Path")
                If savPath = "" Then
                    savPath = "Saved\"
                Else
                    runningAsEXE = True
                End If

            Else

                getMainFilename = gamPath & Command

            End If

        ElseIf UBound(args) = 1 Then

            'run program
            mainfile = gamPath & args(0)
            Call openMain(mainfile, mainMem)
            Call openSystems(True)
            Call runProgram(projectPath & prgPath & args(1))
            Call closeSystems
            End

        End If

    Else

        If fileExists(gamPath & "main.gam") Then

            'main.gam exists.
            getMainFilename = gamPath & "main.gam"

        Else

            Call ChDir(currentDir)

            Dim dlg As FileDialogInfo
            With dlg
                .strDefaultFolder = gamPath$
                .strSelectedFile = ""
                .strTitle = "Open Main File"
                .strDefaultExt = "gam"
                .strFileTypes = "Supported Files|*.gam;*.tpk|RPG Toolkit Main File (*.gam)|*.gam|RPG Toolkit PakFile (*.tpk)|*.tpk|All files(*.*)|*.*"
                If Not (OpenFileDialog(dlg)) Then 'user pressed cancel
                    Exit Function
                End If
                loadedMainFile = .strSelectedFile
            End With

            Call ChDir(currentDir)

            Dim whichType As String
            whichType = GetExt(loadedMainFile)

            If UCase(whichType) = "TPK" Then
                Call setupPakSystem(loadedMainFile)
                getMainFilename = "main.gam"
                projectPath = ""
            Else
                getMainFilename = loadedMainFile
            End If
        
        End If

    End If

    'If we're running from a single file, the project is in this directory
    If runningAsEXE Or pakFileRunning Then
        projectPath = ""
    End If

End Function

'=======================================================================
' Init some common stuff
'=======================================================================
Private Sub initGame()
    On Error Resume Next
    Call Randomize(Timer)
    currentDir = CurDir()
    Call InitThreads
    Call initVarSystem
    Call Load(inv)
    menuColor = RGB(0, 0, 0)
    MWinSize = 90
    mainMem.mainScreenType = 2
    savPath = "Saved\"
    Call MkDir(Mid(savPath, 1, Len(savPath) - 1))
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
    If Not (InitRuntime()) Then
        Call ChDir("C:\Program Files\Toolkit3\")
        currentDir = CurDir()
        If Not InitRuntime() Then
            Call MsgBox("Could not initialize actkrt3.dll. Do you have actkrt3.dll, freeimage.dll, and audiere.dll in the working directory?")
            End
        End If
    End If
    Call initGame
End Sub

'=======================================================================
' Runs one 'frame' of the game logic
'=======================================================================
Public Sub gameLogic()

    'NOTE: This is no longer the main loop. The main
    '      loop is now in clsDirectXHost and is called
    '      mainEventLoop().

    On Error Resume Next

    Static checkFight As Long   'Used to track number of times fighting
                                '*would* have been checked for if not
                                'in pixel movement. In pixel movement,
                                'only check every four steps (one tile).

    Select Case gGameState

        Case GS_IDLE
            Call renderNow          'render the scene
            Call checkMusic         'keep the music looping
            Call multiTaskNow       'run rpgcode multitasking
            Call scanKeys           'scan for important keys
            Call updateGameTime     'update time game has been running for

        Case GS_PAUSE
            Call checkMusic         'just keep the music looping

        Case GS_MOVEMENT

            Call moveItems
            Call movePlayers

            'this should be called framesPerMove times
            movementCounter = movementCounter + 1

            'Re-render the scene
            Call renderNow

            'Make sure this is run four times
            If movementCounter < framesPerMove Then
                gGameState = GS_MOVEMENT
                If (Not GS_ANIMATING) And (Not GS_LOOPING) Then
                    Call delay(walkDelay / ((framesPerMove * movementSize) / 2))
                End If
            Else
                'We're done movement
                gGameState = GS_DONEMOVE
                movementCounter = 0
            End If

        Case GS_DONEMOVE

            'clear pending item movements...
            Dim cnt As Long
            For cnt = 0 To UBound(pendingItemMovement)
                pendingItemMovement(cnt).direction = MV_IDLE
                pendingItemMovement(cnt).xOrig = itmPos(cnt).x
                pendingItemMovement(cnt).yOrig = itmPos(cnt).y
            Next cnt

            'The pending movements have to be cleared *before* any programs are run,
            'whereas the movement direction can only be cleared afterwards.
            For cnt = 0 To UBound(pendingPlayerMovement)
                pendingPlayerMovement(cnt).xOrig = pPos(cnt).x
                pendingPlayerMovement(cnt).yOrig = pPos(cnt).y
            Next cnt

            'check if player moved...
            If pendingPlayerMovement(selectedPlayer).direction <> MV_IDLE Then
                'will create a temporary player position which is based on
                'the target location for that players' movement.
                'lets us test solid tiles, etc
                Dim tempPos As PLAYER_POSITION
                tempPos = pPos(selectedPlayer)

                tempPos.l = pendingPlayerMovement(selectedPlayer).lTarg
                tempPos.x = pendingPlayerMovement(selectedPlayer).xTarg
                tempPos.y = pendingPlayerMovement(selectedPlayer).yTarg

                'Test for a program
                Call programTest(tempPos)
                
                'Flag player is no longer moving
                pendingPlayerMovement(selectedPlayer).direction = MV_IDLE

                'Test for a fight
                If usingPixelMovement() Then
                    checkFight = checkFight + 1
                    If checkFight = 4 Then
                        Call fightTest
                        checkFight = 0
                    End If
                Else
                    Call fightTest
                End If

            End If

            'clear player movements
            For cnt = 0 To UBound(pendingPlayerMovement)
                pendingPlayerMovement(cnt).direction = MV_IDLE
            Next cnt

            'Convert *STUPID* string positions to numerical
            If UCase(pPos(selectedPlayer).stance) = "WALK_S" Then facing = South
            If UCase(pPos(selectedPlayer).stance) = "WALK_W" Then facing = West
            If UCase(pPos(selectedPlayer).stance) = "WALK_N" Then facing = North
            If UCase(pPos(selectedPlayer).stance) = "WALK_E" Then facing = East

            'Back to idle state
            gGameState = GS_IDLE

        Case GS_QUIT
            'Post quit message to break out of main event loop
            Call PostQuitMessage(0)

    End Select

End Sub

'=======================================================================
' Open systems
'=======================================================================
Private Sub openSystems(Optional ByVal testingPRG As Boolean)
    On Error Resume Next
    Call initActiveX
    Call initGraphics(testingPRG)
    Call DXClearScreen(0)
    Call DXRefresh
    Call InitPlugins
    Call BeginPlugins
    Call startMenuPlugin
    Call startFightPlugin
    Call initMedia
    Call setupMain(testingPRG)
    Call DXRefresh
    Call calculateSlackTime
End Sub

'=======================================================================
' Get an estimate speed of this CPU
'=======================================================================
Private Sub calculateSlackTime(Optional ByVal recurse As Boolean = True)

    Dim a As Long

    If recurse Then

        Dim running As Double
        For a = 1 To 10
            Call calculateSlackTime(False)
            running = running + slackTime
        Next a
        slackTime = running / 10

    Else

        'Get the current tick count
        Dim startTime As Double
        startTime = Timer()

        'Do events ten times
        For a = 1 To 10
            Call processEvent
        Next a

        'Get tick count again
        Dim endTime As Double
        endTime = Timer()

        'Calculate the slack
        slackTime = ((endTime - startTime) / 5) + 1

    End If

    'We now have an approximate idea of this CPU's speed

End Sub

'=======================================================================
' Register ActiveX components
'=======================================================================
Private Sub initActiveX()
    On Error Resume Next
    Dim a As Long
    For a = 0 To UBound(mainMem.plugins)
        If mainMem.plugins(a) <> "" Then
            Dim fullPath As String
            fullPath = projectPath & plugPath & mainMem.plugins(a)
            Call ExecCmd("regsvr32 /s " & Chr(34) & fullPath & Chr(34))
        End If
    Next a
End Sub

'=======================================================================
' Set some things based on the main file
'=======================================================================
Public Sub setupMain(Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    topX = 0
    topY = 0

    'If we're running as an exe, don't show the debug window!
    If Not runningAsEXE Then
        debugYN = 1
    End If

    fontName = "Arial"              'Default true type font
    fontSize = 20                   'Default font ize
    fontColor = vbQBColor(15)       'White
    MWinBkg = vbQBColor(0)          'Black
    mwinLines = 4                   'Lines MWin can hold
    textX = 1                       'Text location X
    textY = 1                       'Text location Y
    saveFileLoaded = False          'Starting new game

    'Set initial game speed
    Call gameSpeed(mainMem.gameSpeed)

    'Set initial pixel movement value
    If mainMem.pixelMovement = 1 Then
        movementSize = 0.25
    Else
        movementSize = 1
    End If

    'Register all fonts
    Call LoadFontsFromFolder(projectPath & fontPath)

    'Change the DirectX host's caption to the game's title (for windowed mode)
    If mainMem.gameTitle <> "" Then
        host.Caption = mainMem.gameTitle
    End If

    If mainMem.initChar <> "" Then
        'If a main character has been specified, load it
        Call CreateCharacter(projectPath & temPath & mainMem.initChar, 0)
    End If

    'Unless we're testing a program from the PRG editor, run the
    'startup program
    If Not testingPRG Then
        Call runProgram(projectPath & prgPath & mainMem.startupPrg, , , True)
    End If

    'Unless we loaded a game (using Load()) or we're testing a PRG from
    'the program editor, send the player to the initial board
    If (Not saveFileLoaded) And (Not testingPRG) Then

        'Nullify some variables
        scTopX = -1000
        scTopY = -1000
        lastRender.canvas = -1

        'Open up the starting board
        Call ClearNonPersistentThreads
        Call openBoard(projectPath & brdPath & mainMem.initBoard, boardList(activeBoardIndex).theData)
        Call alignBoard(boardList(activeBoardIndex).theData.playerX, boardList(activeBoardIndex).theData.playerY)
        Call openItems
        Call launchBoardThreads(boardList(activeBoardIndex).theData)

        'Setup player position
        With pPos(0)
            .x = boardList(activeBoardIndex).theData.playerX
            .y = boardList(activeBoardIndex).theData.playerY
            .l = boardList(activeBoardIndex).theData.playerLayer
            .stance = "WALK_S"
            .frame = 0
        End With
    
        'Set to use player 0 as walking graphics
        selectedPlayer = 0

        'Hide all players except the walking graphic one
        Dim pNum As Long
        For pNum = 0 To UBound(showPlayer)
            If pNum <> selectedPlayer Then
                showPlayer(pNum) = False
            Else
                showPlayer(pNum) = True
            End If
        Next pNum

        'Start him facing south
        facing = South

    End If

End Sub
