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

' Main loop procedure
Private Declare Sub mainEventLoop Lib "actkrt3.dll" (ByVal gameLogicAddress As Long)

' Current state of logic
Public gGameState As GAME_LOGIC_STATE

' Average loop time in GS_MOVEMENT state
Public gAvgTime As Double

' State of gameLogic() procedure
Public Enum GAME_LOGIC_STATE

    ' Just re-renders the screen
    GS_IDLE = 0

    ' Shutdown sequence
    GS_QUIT = 1

    ' Movement is occurring (players or items)
    GS_MOVEMENT = 2

    ' Movement is finished
    GS_DONEMOVE = 3

    ' Pause game (do nothing)
    GS_PAUSE = 4

End Enum

' Was the game loaded from start menu?
Public saveFileLoaded As Boolean

' Are we running as an exe file?
Public runningAsEXE As Boolean

' Has the shutdown process been initiated?
Public gShuttingDown As Boolean

' DirectX host window
Public host As New CDirectXHost

'=======================================================================
' Main entry point
'=======================================================================
Public Sub Main()

    On Error Resume Next

    'Init some misc stuff
    Call initDefaults

    'Get a main filename
    Dim mainFile As String
    mainFile = getMainFilename()

    'If we got one
    If (mainFile <> "") Then

        'Open the main file
        Call openMain(mainFile, mainMem)

        'Startup
        Call openSystems

        'Run game
        Call mainEventLoop(AddressOf gameLogic)

    End If

End Sub

'=======================================================================
' Close systems
'=======================================================================
Public Sub closeSystems()
    On Error Resume Next
    gShuttingDown = True
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
    Call host.Destroy
    Call Unload(debugwin)
    Call closeActiveX
    Call showEndForm
End Sub

'=======================================================================
' Get a main filename
'=======================================================================
Private Function getMainFilename() As String

    ' Precedurence is as follows:
    '  + Command line
    '  + Main.gam
    '  + File dialog

    On Error Resume Next

    If (Command <> "") Then

        Dim args() As String
        args() = Split(Command, " ")

        If (UBound(args) = 0) Then

            If (LCase(GetExt(Command)) = "tpk") Then

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

        ElseIf (UBound(args) = 1) Then

            ' Run program
            mainFile = gamPath & args(0)
            Call openMain(mainFile, mainMem)
            Call openSystems(True)
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
                .strDefaultFolder = gamPath$
                .strSelectedFile = ""
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

            If (UCase(whichType) = "TPK") Then
                Call setupPakSystem(loadedMainFile)
                getMainFilename = "main.gam"
                projectPath = ""
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
        projectPath = ""
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

    On Local Error Resume Next

    ' This procedure contains all of the engine's logic. It is constantly
    ' called until gGameState == GS_QUIT, the user closes the window, or
    ' a few other things.

    Static renderTime As Double, renderCount As Long, renderPile As Double
    renderTime = Timer()

    Static checkFight As Long   ' Used to track number of times fighting
                                ' *would* have been checked for if not
                                ' in pixel movement. In pixel movement,
                                ' only check every four steps (one tile).

    Select Case gGameState

        Case GS_IDLE            'IDLE STATE
                                '----------
            Call checkMusic         ' Keep the music looping
            Call scanKeys           ' Scan for important keys
            Call updateGameTime     ' Update time game has been running for
            
            'C heck the player's queue to see if movement is about to start.
            If LenB(pendingPlayerMovement(selectedPlayer).queue) <> 0 Then
                ' There is a queue.
                gGameState = GS_MOVEMENT
            End If

            If gGameState <> GS_MOVEMENT Then
                ' Check we're not about to start moving again.
                Call multiTaskNow
                Call moveItems
            End If

            Call renderNow          ' Render the scene

        Case GS_PAUSE           'PAUSE STATE
                                '-----------
            Call checkMusic         ' Just keep the music looping

        Case GS_MOVEMENT        'MOVEMENT STATE
                                '--------------

            ' Make sure this runs for the duration of the player's move.
            ' Run this before movePlayers since .loopFrame will be reset by it.
            If (pPos(selectedPlayer).loopFrame + 1 < FRAMESPERMOVE * (playerMem(selectedPlayer).loopSpeed + loopOffset)) Then
                ' We're still moving
                gGameState = GS_MOVEMENT
            Else
                ' We're done movement
                gGameState = GS_DONEMOVE
            End If

            Call multiTaskNow       ' Run rpgcode multitasking
            Call movePlayers        ' Move players
            Call moveItems          ' Move items

            ' Re-render the scene
            Call renderNow(-1, True)

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
                Case "WALK_S": facing = South
                Case "WALK_W": facing = West
                Case "WALK_N": facing = North
                Case "WALK_E": facing = East
            End Select

            ' Back to idle state
            gGameState = GS_IDLE

        Case GS_QUIT            'QUIT STATE
                                '----------
            ' End the program
            Call endProgram

    End Select

    ' Time a render.
    If (gGameState = GS_MOVEMENT) Then
        renderTime = Timer() - renderTime
        renderPile = renderPile + renderTime
        renderCount = renderCount + 1
        gAvgTime = renderPile / renderCount
    End If

End Sub

'=======================================================================
' Open systems
'=======================================================================
Private Sub openSystems(Optional ByVal testingPRG As Boolean)
    On Error Resume Next
    Call initActiveX
    Call initEventProcessor
    Call initGraphics(testingPRG)
    Call correctPaths
    Call InitPlugins
    Call BeginPlugins
    Call startMenuPlugin
    Call startFightPlugin
    Call initMedia
    Call DXClearScreen(0)
    Call DXRefresh
    Call setupMain(testingPRG)
End Sub

'=======================================================================
' Register ActiveX components
'=======================================================================
Private Sub initActiveX()
    On Error Resume Next
    Dim a As Long
    For a = 0 To UBound(mainMem.plugins)
        If (mainMem.plugins(a) <> "") Then
            Dim fullPath As String
            fullPath = projectPath & plugPath & mainMem.plugins(a)
            Call ExecCmd("regsvr32 /s " & Chr(34) & fullPath & Chr(34))
        End If
    Next a
    fullPath = projectPath & plugPath & mainMem.menuPlugin
    Call ExecCmd("regsvr32 /s " & Chr(34) & fullPath & Chr(34))
    fullPath = projectPath & plugPath & mainMem.fightPlugin
    Call ExecCmd("regsvr32 /s " & Chr(34) & fullPath & Chr(34))
End Sub

'=======================================================================
' Unregister ActiveX components
'=======================================================================
Private Sub closeActiveX()
    On Error Resume Next
    Dim a As Long
    For a = 0 To UBound(mainMem.plugins)
        If (mainMem.plugins(a) <> "") Then
            Dim fullPath As String
            fullPath = projectPath & plugPath & mainMem.plugins(a)
            Call ExecCmd("regsvr32 /s /u " & Chr(34) & fullPath & Chr(34))
        End If
    Next a
    fullPath = projectPath & plugPath & mainMem.menuPlugin
    Call ExecCmd("regsvr32 /s /u " & Chr(34) & fullPath & Chr(34))
    fullPath = projectPath & plugPath & mainMem.fightPlugin
    Call ExecCmd("regsvr32 /s /u " & Chr(34) & fullPath & Chr(34))
End Sub

'=======================================================================
' Set some things based on the main file
'=======================================================================
Public Sub setupMain(Optional ByVal testingPRG As Boolean)

    On Error Resume Next

    ' Setup the cursor
    host.cursorHotSpotX = mainMem.hotSpotX
    host.cursorHotSpotY = mainMem.hotSpotY
    host.mousePointer = mainMem.mouseCursor

    ' Nulify top x/y vars
    topX = 0
    topY = 0

    ' Set default shop colors
    shopColors(0) = -1

    ' If we're running as an exe, don't show the debug window!
    If (Not runningAsEXE) Then
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
    If (mainMem.pixelMovement = 1) Then
        movementSize = 0.25
    Else
        movementSize = 1
    End If

    ' Set initial game speed
    Call gameSpeed(mainMem.gameSpeed)

    ' Register all fonts
    Call LoadFontsFromFolder(projectPath & fontPath)

    ' Change the DirectX host's caption to the game's title (for windowed mode)
    If (mainMem.gameTitle <> "") Then
        host.Caption = mainMem.gameTitle
    End If

    If (mainMem.initChar <> "") Then
        ' If a main character has been specified, load it
        Call CreateCharacter(projectPath & temPath & mainMem.initChar, 0)
    End If

    ' Unless we're testing a program from the PRG editor, run the
    ' startup program
    If (Not testingPRG) Then
        Call runProgram(projectPath & prgPath & mainMem.startupPrg, , , True)
    End If

    ' Unless we loaded a game (using Load()) or we're testing a PRG from
    ' the program editor, send the player to the initial board
    If (Not saveFileLoaded) And (Not testingPRG) Then

        ' Nullify some variables
        scTopX = -1000
        scTopY = -1000
        lastRender.canvas = -1

        ' Open up the starting board
        Call ClearNonPersistentThreads
        Call openBoard(projectPath & brdPath & mainMem.initBoard, boardList(activeBoardIndex).theData)
        Call alignBoard(boardList(activeBoardIndex).theData.playerX, boardList(activeBoardIndex).theData.playerY)
        Call openItems
        Call launchBoardThreads(boardList(activeBoardIndex).theData)
        
        ' Set to use player 0 as walking graphics
        selectedPlayer = 0

        ' Setup player position
        With pPos(selectedPlayer)
            .x = boardList(activeBoardIndex).theData.playerX
            .y = boardList(activeBoardIndex).theData.playerY
            .l = boardList(activeBoardIndex).theData.playerLayer
            .stance = "WALK_S"
            .frame = 0
            pendingPlayerMovement(selectedPlayer).xOrig = .x
            pendingPlayerMovement(selectedPlayer).yOrig = .y
            pendingPlayerMovement(selectedPlayer).lOrig = .l
            .loopFrame = -1
            playerMem(selectedPlayer).loopSpeed = 1
        End With


        ' Hide all players except the walking graphic one
        Dim pNum As Long
        For pNum = 0 To UBound(showPlayer)
            showPlayer(pNum) = (pNum = selectedPlayer)
        Next pNum

        ' Start him facing south
        facing = South

    End If

End Sub
