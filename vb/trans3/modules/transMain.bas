Attribute VB_Name = "transMain"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'mainForm entry point for trans3

Option Explicit

Public gGameState As Long
Public gPrevGameState As Long

'Game states...
Public Const GS_IDLE = 0        'just re-renders the screen
Public Const GS_QUIT = 1        'shutdown sequence
Public Const GS_MOVEMENT = 2    'movement is occurring (players or items)
Public Const GS_DONEMOVE = 3    'movement is finished
Public Const GS_PAUSE = 4       'pause game

Public movementCounter As Long  'number of times GS_MOVEMENT has been run (should be 4 before moving onto GS_DONEMOVE)
Public loaded As Long           'was the game loaded from start menu? 0-no, 1-yes
Public runningAsEXE As Boolean  'are we running as an exe file?
Public gShuttingDown As Boolean 'Has the shutdown process been initiated?

Public slackTime As Double

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

    If runningAsEXE Then
        Call Kill(TempDir & "actkrt3.dll")
        Call Kill(TempDir & "freeImage.dll")
        Call Kill(TempDir & "temp.tpk")
    End If

End Sub

Public Function getMainFilename() As String

    'Get a main filename
    'Precedurence is as follows:
    ' + Command line
    ' + Main.gam
    ' + File dialog

    On Error Resume Next

    Dim toRet As String
    Dim antiPath As String
    
    Dim ex As String
    If Command <> "" Then

        Dim args() As String
        args() = Split(Command, " ", , vbTextCompare)

        If UBound(args) = 0 Then

            If LCase(GetExt(Command)) = "tpk" Then

                Call setupPakSystem(TempDir & Command)
                Call Kill(PakFileMounted)
                ChDir (currentDir)
                toRet = "main.gam"
                projectPath = ""
                getMainFilename = toRet
                errorBranch = "Resume Next"
                savPath = GetSetting("TK3 EXE HOST", "Settings", "Save Path", "")
                Call SaveSetting("TK3 EXE HOST", "Settings", "Save Path", "")
                If savPath = "" Then
                    savPath = "Saved\"
                Else
                    runningAsEXE = True
                End If

            Else

                toRet = gamPath & Command
                getMainFilename = toRet

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

            'mainForm.gam exists.
            toRet = gamPath & "main.gam"
            getMainFilename = toRet

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
                antiPath = .strSelectedFileNoPath
            End With

            Call ChDir(currentDir)

            Dim whichType As String
            whichType = GetExt(loadedMainFile)

            If UCase(whichType) = "TPK" Then
                Call setupPakSystem(loadedMainFile)
                toRet = "main.gam"
                projectPath = ""
            Else
                toRet = loadedMainFile
            End If

            getMainFilename = toRet

        End If

    End If

End Function

Private Sub initgame()
    On Error Resume Next
    Call Randomize(Timer)
    currentDir = CurDir()
    Call InitThreads
    Call initVarSystem
    Call InitInventory(inv)
    menuColor = RGB(0, 0, 0)
    MWinSize = 90
    mainMem.mainScreenType = 2
    savPath = "Saved\"
    Call MkDir(Mid(savPath, 1, Len(savPath) - 1))
    activeBoardIndex = VectBoardNewSlot()
    Call InitLocalizeSystem
End Sub

Sub initDefaults()
    'initialise defaults
    On Error Resume Next
    initTime = Timer()
    Call StartTracing("trace.txt")
    If Not (InitRuntime()) Then
        Call MsgBox("Could not initialize actkrt3.dll.  Do you have actkrt3.dll, freeimage.dll, and audiere.dll in the working directory?")
        End
    End If
    Call initgame
End Sub

Public Sub Main()

    On Error Resume Next

    Call initDefaults

    Dim mainfile As String
    mainfile = getMainFilename()

    If mainfile <> "" Then

        Call openMain(mainfile, mainMem)

        If runningAsEXE Or pakFileRunning Then
            projectPath = ""
        End If
        
        'Startup
        Call openSystems

        'Run game
        Call mainLoop

        'Shut down
        Call closeSystems
        Call endform.Show(vbModal)

    End If

End Sub

Public Sub mainLoop()

    'main execution loop
        
    On Error Resume Next

    Dim bDone As Boolean
  
    #Const isRelease = 1

    #If Not isRelease = 1 Then
        Dim framesDrawn As Long
        Dim tt As Long
        tt = Timer()
    #End If

    Dim checkFight As Long

    Do Until bDone
    
        Select Case gGameState
        
            Case GS_IDLE

                Call checkMusic
                Call renderNow
                Call multiTaskNow
                Call scanKeys
                Call updateGameTime
                DoEvents
                
                #If Not isRelease = 1 Then
                    framesDrawn = framesDrawn + 1
                #End If

            Case GS_MOVEMENT:
                'movement has occurred...

                Call moveItems
                Call movePlayers

                #If Not isRelease = 1 Then
                    framesDrawn = framesDrawn + 1
                #End If

                'this should be called framesPerMove times (moving 1/framesPerMove each time)
                movementCounter = movementCounter + 1

                Call renderNow

                If movementCounter < framesPerMove Then
                    gGameState = GS_MOVEMENT
                    If (Not GS_ANIMATING) And (Not GS_LOOPING) Then
                        Call delay(walkDelay / ((framesPerMove * movementSize) / 2))
                    End If
                Else
                    gGameState = GS_DONEMOVE
                    movementCounter = 0
                End If

            Case GS_DONEMOVE:
                'movement is done...
                'check rpgcode programs, etc...

                'clear pending item movements...
                Dim cnt As Long
                For cnt = 0 To UBound(pendingItemMovement)
                    pendingItemMovement(cnt).direction = MV_IDLE
                    
                    'Isometric fix:
                    pendingItemMovement(cnt).xOrig = itmPos(cnt).x
                    pendingItemMovement(cnt).yOrig = itmPos(cnt).y
                Next cnt
                
                'The pending movements have to be cleared *before* any programs are run,
                'whereas the movement direction can only be cleared afterwards.
                For cnt = 0 To UBound(pendingPlayerMovement)
                    pendingPlayerMovement(cnt).xOrig = ppos(cnt).x
                    pendingPlayerMovement(cnt).yOrig = ppos(cnt).y
                Next cnt
                
                'check if player moved...
                If pendingPlayerMovement(selectedPlayer).direction <> MV_IDLE Then
                    'will create a temporary player position which is based on
                    'the target location for that players' movement.
                    'lets us test solid tiles, etc
                    Dim tempPos As PLAYER_POSITION
                    tempPos = ppos(selectedPlayer)

                    tempPos.l = pendingPlayerMovement(selectedPlayer).lTarg
                    tempPos.x = pendingPlayerMovement(selectedPlayer).xTarg
                    tempPos.y = pendingPlayerMovement(selectedPlayer).yTarg

                    Call programTest(tempPos)
                    pendingPlayerMovement(selectedPlayer).direction = MV_IDLE

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

                If UCase(ppos(selectedPlayer).stance) = "WALK_S" Then facing = 1
                If UCase(ppos(selectedPlayer).stance) = "WALK_W" Then facing = 2
                If UCase(ppos(selectedPlayer).stance) = "WALK_N" Then facing = 3
                If UCase(ppos(selectedPlayer).stance) = "WALK_E" Then facing = 4

                gGameState = GS_IDLE
                
            Case GS_QUIT:
                bDone = True
                
            Case GS_PAUSE:
                'do nothing!
                DoEvents

        End Select
        
        If Not gGameState = GS_PAUSE Then
        
            If GS_ANIMATING Then
                'We're running multi-task animations here!
                Call handleMultitaskingAnimations
            End If

            If GS_LOOPING Then
                'We're in a loop!
                Call handleThreadLooping
                movementCounter = 5
            End If

        End If
        
    Loop
    
End Sub

Sub openSystems(Optional ByVal testingPRG As Boolean)
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

    host.Visible = True
    Call host.Show
    DoEvents
    
End Sub

Private Sub calculateSlackTime(Optional ByVal recurse As Boolean = True)

    '==================================
    'Calculate this CPU's slack time
    '==================================

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
            DoEvents
        Next a

        'Get tick count again
        Dim endTime As Double
        endTime = Timer()

        'Calculate the slack
        slackTime = ((endTime - startTime) / 5) + 1

    End If

    'We now have an approximate idea of this CPU's speed

End Sub

Private Sub initActiveX()

    '==================================
    'Registers plugin\ folder
    '==================================

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

Public Sub setupMain(Optional ByVal testingPRG As Boolean)
'==================================
'EDITED: [Delano - 20/05/04]
'Initialized #Gamespeed delay and cursor speed delay.
'Renamed variables: t >> pNum, a >> charFile
'==================================
'This sub sets up the game based upon the mainForm file info.
'Called by opensystems only.

    On Error GoTo errorhandler

    topX = 0
    topY = 0
    If Not runningAsEXE Then
        debugYN = 1
    End If
    
    fontName$ = "Arial"             'Default true type font; or "base.fnt"
    fontSize = 20
    fontColor = vbQBColor(15)       'White
    MWinBkg = vbQBColor(0)          'Black
    mwinLines = 4
    textX = 1                       'Text location
    textY = 1
    loaded = 0
    
    Call gameSpeed(mainMem.gameSpeed)
    
    If mainMem.pixelMovement = 1 Then
        movementSize = 0.25
    Else
        movementSize = 1
    End If
    
    Call LoadFontsFromFolder(projectPath & fontPath)
    
    If mainMem.gameTitle$ <> "" Then
        host.Caption = mainMem.gameTitle$
    End If
    
    'OK, deal with the character first:
    
    Dim charFile As String
    charFile$ = mainMem.initChar$
    
    If charFile$ <> "" Then
        'If a main character has been specified, load it. Else?
        Call CreateCharacter(projectPath$ + temPath$ + charFile$, 0)
    End If
    
    If Not testingPRG Then
        Call runProgram(projectPath & prgPath & mainMem.startupPrg)
    End If
    
    'Initial board
    If loaded = 0 And (Not testingPRG) Then

        scTopX = -1000
        scTopY = -1000
        lastRender.canvas = -1
        'Clear non-persistent threads...
        Call ClearNonPersistentThreads

        Call openboard(projectPath$ + brdPath$ + mainMem.initBoard$, boardList(activeBoardIndex).theData)
        Call alignBoard(boardList(activeBoardIndex).theData.playerX, boardList(activeBoardIndex).theData.playerY)
        Call openItems

        Call launchBoardThreads(boardList(activeBoardIndex).theData)

        'Setup player position.
        ppos(0).x = boardList(activeBoardIndex).theData.playerX
        ppos(0).y = boardList(activeBoardIndex).theData.playerY
        ppos(0).l = boardList(activeBoardIndex).theData.playerLayer
        ppos(0).stance = "WALK_S"
        ppos(0).frame = 0
        selectedPlayer = 0

        Dim pnum As Long
        For pnum = 0 To UBound(showPlayer)
            showPlayer(pnum) = False
        Next pnum
        showPlayer(selectedPlayer) = True
        facing = 1                      'Facing South.
        
    End If

    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
    
End Sub


