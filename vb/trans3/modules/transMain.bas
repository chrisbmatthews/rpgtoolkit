Attribute VB_Name = "transMain"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'mainForm entry point for trans3
Option Explicit

Public gGameState As Long
Public gPrevGameState As Long

'Game states...
Public Const GS_IDLE = 0    'just re-renders the screen
Public Const GS_QUIT = 1    'shutdown sequence
Public Const GS_MOVEMENT = 2    'movement is occurring (players or items)
Public Const GS_DONEMOVE = 3    'movement is finished
Public Const GS_PAUSE = 4   'pause game

Private framesDrawn As Long

Public movementCounter As Long 'number of times GS_MOVEMENT has been run (should be 4 before moving onto GS_DONEMOVE)

Public loaded As Long           'was the game loaded from start menu? 0-no, 1-yes

Public runningAsEXE As Boolean  'are we running as an exe file?

Public gShuttingDown As Boolean 'Has the shutdown process been initiated?
Sub closeSystems()
    On Error Resume Next

    ' ! MODIFIED BY KSNiloc...
    
    'This flag added by cbm for 3.0.4
    gShuttingDown = True
    
    Call StopMedia
    Call stopMenuPlugin
    Call stopFightPlugin
    Call EndPlugins
    Call ShutdownVarSystem
    Call AnimationShutdown
    Call destroyGraphics
    Call UnLoadFontsFromFolder(projectPath$ + fontPath$)
    Call ClearAllThreads
    Call KillMedia
    Call DeletePakTemp

    Kill TempDir & "actkrt3.dll"
    Kill TempDir & "freeImage.dll"
    Kill TempDir & "temp.tpk"
    
End Sub


Function getMainFilename() As String
    'prompt user for a main file, or get one off the command line
    On Error Resume Next
    Dim toRet As String
    Dim exeFile As String
    Dim antiPath As String
    
    'before we do *anything*, let's see if we are a standalone exe file!
    exeFile$ = currentdir$ + "\" + App.EXEName + ".exe"
    'MsgBox exefile$
    If IsAPakFile(exeFile$) Then
        Call setupPakSystem(exeFile$)
        'load 'mainForm' from the pakfile...
        'call tracestring("Loading mainForm.gam")

        ' KSNiloc says: no gamPath$ required
        toRet = "main.gam"
        'toRet = gamPath$ + "main.gam"
        
        runningAsEXE = True
        getMainFilename = toRet
        Exit Function
    Else
        'do nothing--proceed as usual!
    End If

    Dim ex As String
    If Command$ <> "" Then
        Dim args() As String

        args() = Split(Command, " ", , vbTextCompare)
        
        If UBound(args) = 0 Then
            'run game
            'Call traceString("Loading " + gamPath$ + Command$)

            ' ! MODIFIED BY KSNiloc...
            If LCase(GetExt(Command)) = "tpk" Then
                setupPakSystem TempDir & Command
                ChDir (currentdir)
                toRet = "main.gam"
                projectPath = ""
                getMainFilename = toRet
                Kill PakFileMounted
                errorBranch = "Resume Next"
                savPath = GetSetting("TK3 EXE HOST", "Settings", _
                    "Save Path", "Saved")

            Else
            
                toRet = gamPath$ + Command$
                getMainFilename = toRet
                
            End If
            
            Exit Function

        ElseIf UBound(args) = 1 Then
            'run program
            mainfile = gamPath$ + args(0)
            Call openMain(mainfile, mainMem)
            Call openSystems(True)

            ' ! MODIFIED BY KSNiloc...
            runProgram App.path & "\" & projectPath & prgPath & args(1)
            Call closeSystems
            gGameState = GS_QUIT
            End
            Exit Function
        End If
    End If
    Dim aa As Long
    If FileExists(gamPath$ + "main.gam") Then
        'mainForm.gam exists.
        toRet = gamPath$ + "main.gam"
        getMainFilename = toRet
        Exit Function
    End If
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gamPath$
    dlg.strSelectedFile = ""
    dlg.strTitle = "Open Main File"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "Supported Files|*.gam;*.tpk|RPG Toolkit Main File (*.gam)|*.gam|RPG Toolkit PakFile (*.tpk)|*.tpk|All files(*.*)|*.*"
    If Not (OpenFileDialog(dlg)) Then 'user pressed cancel
        'uncomment!!!!!!!!!!!!!!!
        End
        getMainFilename = toRet
        Exit Function
    End If
    loadedMainFile$ = dlg.strSelectedFile
    antiPath$ = dlg.strSelectedFileNoPath
    'currentdir$ = CurDir$
    ChDir (currentdir$)
    If loadedMainFile$ = "" Then Exit Function: End
    
    Dim whichType As String
    whichType$ = GetExt(loadedMainFile$)
    If UCase$(whichType$) = "TPK" Then      'Yipes! we've selected a pakfile!
        'setup the pakfile system
        'call tracestring("Loading " + loadedMainFile$)
        Call setupPakSystem(loadedMainFile$)
        'toRet = gamPath$ + "main.gam"
        toRet = "main.gam"
        'load 'mainForm' from the pakfile...
        projectPath$ = ""
    Else
        'call tracestring("Loading " + loadedMainFile$)
        toRet = loadedMainFile$
    End If
    
    getMainFilename = toRet
End Function


Private Sub initgame()
    On Error Resume Next
    Randomize Timer
    
    currentdir$ = CurDir$
    
    Call InitThreads
    Call InitVarSystem
    Call InitInventory(inv)
    
    'menucolor = RGB(75, 75, 75)
    menuColor = RGB(0, 0, 0)
    'menucolor = RGB(50, 100, 150)
    
    MWinSize = 90
    
    mainMem.mainScreenType = 2      'default to windowed
    
    
    Major = 2   'Version 2
    Minor = 0   ' version 2.0
    CurrentVersion$ = "2.0"
    compression = 1 'compression is used
    filename$(2) = ""
    projectPath$ = ""              'project path
    tilePath$ = "Tiles\"          'Tile dir path
    'MkDir Mid$(tilepath$, 1, Len(tilepath$) - 1)
    brdPath$ = "Boards\"           'board dir path
    'MkDir Mid$(brdpath$, 1, Len(brdpath$) - 1)
    temPath$ = "Chrs\"           'character dir path
    'MkDir Mid$(tempath$, 1, Len(tempath$) - 1)
    arcPath$ = "Archives\"           'archive dir path
    'MkDir Mid$(arcpath$, 1, Len(arcpath$) - 1)
    spcPath$ = "SpcMove\"       'spc move path
    'MkDir Mid$(spcpath$, 1, Len(spcpath$) - 1)
    bkgPath$ = "Bkrounds\"       'bkg path
    'MkDir Mid$(bkgpath$, 1, Len(bkgpath$) - 1)
    mediaPath$ = "Media\"       'media path
    'MkDir Mid$(mediapath$, 1, Len(mediapath$) - 1)
    prgPath$ = "Prg\"       'prg path
    'MkDir Mid$(prgpath$, 1, Len(prgpath$) - 1)
    fontPath$ = "Font\"     'Font path
    'MkDir Mid$(fontpath$, 1, Len(fontpath$) - 1)
    itmPath$ = "Item\"     'Item path
    'MkDir Mid$(itmpath$, 1, Len(itmpath$) - 1)
    enePath$ = "Enemy\"     'enemy path
    'MkDir Mid$(enepath$, 1, Len(enepath$) - 1)
    gamPath$ = "Main\"     'mainForm file path
    'MkDir Mid$(gampath$, 1, Len(gampath$) - 1)
    bmpPath$ = "Bitmap\"
    statusPath$ = "StatusE\"
    miscPath$ = "Misc\"
    pluginPath$ = "Plugin\"
    savPath$ = "Saved\"     'saved games
    MkDir Mid$(savPath$, 1, Len(savPath$) - 1)
    resourcePath$ = "Resources\"
    
    Call InitLocalizeSystem
    
    'init data...
    activeBoardIndex = VectBoardNewSlot()
    
    
    Exit Sub
    
End Sub


Sub initDefaults()
    'initialise defaults
    On Error Resume Next
    
    initTime = Timer
    
    Call StartTracing("trace.txt")
    
    'ChDir App.path & "\"
    
    If Not (InitRuntime()) Then
        MsgBox "Could not initialize actkrt3.dll.  Do you have actkrt3.dll and freeimage.dll in the working directory?"
        End
    End If
    
    'call tracestring("About to init game")
    
    Call initgame
    
    'call tracestring("Done init game")
    'call tracestring("About to load mainForm")
End Sub

Public Sub Main()
    On Error Resume Next
    'main entry point for trans
       
    Dim mainfile As String
    Call initDefaults
    
    mainfile = getMainFilename()
    If mainfile <> "" Then
        Call openMain(mainfile, mainMem)
        If runningAsEXE Or PakFileRunning Then
            projectPath$ = ""
        End If
        
        Call openSystems
        'renderNow
        
        'run start program...
        'Dim oldMusic As String
        'oldMusic = boardList(activeBoardIndex).theData.boardMusic
        'Call runProgram(projectPath$ + prgPath$ + mainMem.startupPrg)
        'boardList(activeBoardIndex).theData.boardMusic = oldMusic
        
        Dim tt As Long
        tt = Timer
        
        gGameState = GS_IDLE
        Call mainLoop
        
        tt = Timer - tt
        
        Call closeSystems
        'MsgBox str$(framesDrawn)
        'MsgBox str$(framesDrawn / tt)
        
        endform.Show 1
        End
    End If
    
    'End
End Sub

Public Sub mainLoop()

    ' ! MODIFIED BY KSNiloc...

    'EDITED: [Isometrics - Delano 28/04/04]
    'Code added to fix diagonal "jumping". No alterations.

    'main execution loop
        
    On Error Resume Next
    
    Dim bDone As Boolean
    Dim a As Long
    
    Dim tt As Long
    tt = Timer

    Dim checkFight As Long

    Do Until bDone
    
        Select Case gGameState
        
            Case GS_IDLE

                checkMusic
                renderNow
                MultiTaskNow
                scanKeys
                updateGameTime
                DoEvents
                framesDrawn = framesDrawn + 1

            Case GS_MOVEMENT:
                'movement has occurred...

                moveItems
                movePlayers

                framesDrawn = framesDrawn + 1
                
                'this should be called 4 times (moving 0.25 each time)
                movementCounter = movementCounter + 1

                renderNow

                If movementCounter < 4 Then
                    gGameState = GS_MOVEMENT
                    If (Not GS_ANIMATING) And (Not GS_LOOPING) Then delay walkDelay
                Else
                    gGameState = GS_DONEMOVE
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

                    ' !MODIFIED BY KSNiloc...
                    tempPos.l = Round(pendingPlayerMovement(selectedPlayer).lTarg)
                    tempPos.x = Round(pendingPlayerMovement(selectedPlayer).xTarg)
                    tempPos.y = Round(pendingPlayerMovement(selectedPlayer).yTarg)
                                   
                    pendingPlayerMovement(selectedPlayer).direction = MV_IDLE
                    Call programTest(tempPos)
                    
                    ' KSNiloc...
                    checkFight = checkFight + 1
                    If checkFight = 4 Then
                        fightTest
                        checkFight = 0
                    End If
                End If
                'Call MBox("test", "title", MBT_OK, RGB(255, 255, 255), 0, "")
                
                'clear player movements
                For cnt = 0 To UBound(pendingPlayerMovement)
                    pendingPlayerMovement(cnt).direction = MV_IDLE
                Next cnt
                
                If UCase$(ppos(selectedPlayer).stance) = "WALK_S" Then facing = 1
                If UCase$(ppos(selectedPlayer).stance) = "WALK_W" Then facing = 2
                If UCase$(ppos(selectedPlayer).stance) = "WALK_N" Then facing = 3
                If UCase$(ppos(selectedPlayer).stance) = "WALK_E" Then facing = 4
                
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
                handleMultitaskingAnimations
            End If

            If GS_LOOPING Then
                'We're in a loop!
                handleThreadLooping
                movementCounter = 5
            End If

        End If
        
    Loop
    
End Sub

Sub openSystems(Optional ByVal testingPRG As Boolean)
    On Error Resume Next
    
    ' ! MODIFIED BY KSNiloc...
    
    Call initGraphics(testingPRG)
    Call DXClearScreen(0)
    Call DXRefresh

    Call InitPlugins
    Call BeginPlugins
    Call startMenuPlugin
    Call startFightPlugin
    Call AnimationInit
    Call InitMedia
    
    Call setupmain(testingPRG)
    Call DXRefresh

End Sub

Sub setupmain(Optional ByVal testingPRG As Boolean)
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
    debugYN = 1
    
    fontName$ = "Arial"             'Default true type font; or "base.fnt"
    fontSize = 20
    fontColor = vbQBColor(15)       'White
    MWinBkg = vbQBColor(0)          'Black
    mwinLines = 4
    textx = 1                       'Text location
    texty = 1
    
    loaded = 0
    
    'Setting an initial value for #Gamespeed, = 2.
    walkDelay = 0.06
    
    Call LoadFontsFromFolder(projectPath$ + fontPath$)
    
    If mainMem.gameTitle$ <> "" Then
        host.caption = mainMem.gameTitle$
    End If
    
    'OK, deal with the character first:
    
    Dim charFile As String
    charFile$ = mainMem.initChar$
    
    'Call tracestring("creating character " + projectPath$ + tempath$ + charFile$)
    If charFile$ <> "" Then
        'If a main character has been specified, load it. Else?
        Call CreateCharacter(projectPath$ + temPath$ + charFile$, 0)
    End If
    
    'call tracestring("beginning plugins")
    'call tracestring("done plugins")
    
    'Initial program
    'call tracestring("Running startup program " + projectPath$ + prgpath$ + mainMem.startupPrg$)
    
    ' ! KSNiloc: Uncommented
    If Not testingPRG Then Call runProgram(projectPath$ + prgPath$ + mainMem.startupPrg)
    'call tracestring("Done running startup program")
    
    'Initial board
    If loaded = 0 And (Not testingPRG) Then
    
        ' ! FIX BY KSNiloc....
    
        scTopX = -1000
        scTopY = -1000
        lastRender.canvas = -1
        'Clear non-persistent threads...
        Call ClearNonPersistentThreads

        Call openboard(projectPath$ + brdPath$ + mainMem.initBoard$, boardList(activeBoardIndex).theData)
        Call alignBoard(boardList(activeBoardIndex).theData.playerX, boardList(activeBoardIndex).theData.playerY)
        Call openItems

        ' ! ADDED BY KSNiloc...
        launchBoardThreads boardList(activeBoardIndex).theData

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


