Attribute VB_Name = "CommonMainFile"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGToolkit project file format (*.gam)
'=========================================================================

Option Explicit

'=========================================================================
' Public constants
'=========================================================================
Public Const MAX_GAMESPEED = 4        'highest gamespeed settings

'=========================================================================
' Public variables
'=========================================================================
Public mainFile As String             'main filename (redundant?)
Public mainNeedUpdate As Boolean      'main file needs update?
Public loadedMainFile As String       'main file that is loaded

'=========================================================================
' A project file
'=========================================================================
Public Type TKMain
    gameTitle As String               'title of game
    mainScreenType As Integer         'screen type 2=windowed (GDI), 1=DirectX, 0- DirectX (not used)
    extendToFullScreen As Integer     'extend screen to maximum extents  (0=no, 1=yes)
    mainResolution As Integer         'resolution to use for optimal res 0=640x480, 1=800x600, 2=1024x768
    mainDisableProtectReg As Integer  'disable protect registered files (0=no, 1=yes)
    startupPrg As String              'start up program
    initBoard As String               'initial board
    initChar As String                'initial character
    runTime As String                 'run time program
    runKey As Integer                 'ascii code of run time key
    menuKey As Integer                'ascii code of menu key
    Key As Integer                    'ascii code of general run key
    runTimeKeys(50) As Integer        '50 extended run time keys
    runTimePrg(50) As String          '50 extended run time programs
    menuPlugin As String              'the main menu plugin
    fightPlugin As String             'the fighting plugin
    fightgameYN As Integer            'fighting in game? 0-yes, 1-no
    enemy(500) As String              'list of 500 enemy files 0-500
    skill(500) As Integer             'list of enemy skill levels
    fightType As Integer              'fight type: 0-random, 1- planned
    chances As Long                   'chances of getting in fight (1 in x ) OR number of steps to take
    fprgYN As Integer                 'use alt fight program YN 0-no, 1-yes
    fightPrg As String                'program to run for fighting.
    gameOverPrg As String             'game over program
    skinButton As String              'skin's button graphic
    skinWindow As String              'skin's window graphic
    plugins() As String               'plugin list to use
    mainUseDayNight As Integer        'game is affected by day and night 0=no, 1=yes
    mainDayNightType As Integer       'day/night type: 0=real world, 1=set time
    mainDayLength As Long             'day length, in minutes
    cursorMoveSound As String         'sound played when cursor moves
    cursorSelectSound As String       'sound played when cursor selects
    cursorCancelSound As String       'sound played when cursor cancels
    useJoystick As Byte               'allow joystick input? 0- no 1- yes
    colordepth As Byte                'color depth
    gameSpeed As Byte                 'speed which game runs at
    pixelMovement As Byte             'pixel movement (1 / 0)
    mouseCursor As String             'mouse cursor to use
    hotSpotX As Byte                  'x hot spot on mouse
    hotSpotY As Byte                  'y hot spot on mouse
    transpcolor As Long               'transparent color on cursor
    resX As Long                      'custom x resolution
    resY As Long                      'custom y resolution
End Type

'=========================================================================
' Color detail levels
'=========================================================================
Public Const COLOR16 As Byte = 0      '16-bit color
Public Const COLOR24 As Byte = 1      '24-bit color
Public Const COLOR32 As Byte = 2      '32-bit color

'=========================================================================
' Constants for MainMem.PixelMovement (see PixelMovementRPG)
'=========================================================================
Public Const TILE_MOVEMENT = 0
Public Const PIXEL_MOVEMENT_TILE_PUSH = 1
Public Const PIXEL_MOVEMENT_PIXEL_PUSH = 2

'=========================================================================
' Store a gamespeed value between -127 and +127 in the mainMem byte.
'=========================================================================
Public Sub setGameSpeed(ByRef gameSpeed As Byte, ByVal value As Long)
    On Error Resume Next
    value = inBounds(value, -127, 127)
    gameSpeed = value + 128
End Sub

'=========================================================================
' Read a gamespeed value between -127 and +127 from the mainMem byte.
'=========================================================================
Public Function getGameSpeed(ByVal gameSpeed As Byte) As Long
    On Error Resume Next
    getGameSpeed = gameSpeed - 128
End Function

'=========================================================================
' Add a plugin to a project
'=========================================================================
Public Sub MainAddPlugin(ByRef theMain As TKMain, ByVal file As String)
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(theMain.plugins)
        If (LenB(theMain.plugins(t)) = 0) Then
            theMain.plugins(t) = file
            Exit Sub
        End If
    Next t
    Dim newSize As Long
    Dim oldSize As Long
    oldSize = UBound(theMain.plugins)
    newSize = oldSize * 2
    ReDim Preserve theMain.plugins(newSize)
    theMain.plugins(oldSize + 1) = file
End Sub

'=========================================================================
' Get the idx-th plugin in a project
'=========================================================================
Public Function MainGetNthPlugin(ByRef theMain As TKMain, ByVal idx As Long) As String
    On Error Resume Next
    Dim t As Long, cnt As Long
    For t = 0 To UBound(theMain.plugins)
        If (LenB(theMain.plugins(t))) Then
            If cnt = idx Then
                MainGetNthPlugin = theMain.plugins(t)
                Exit Function
            End If
            cnt = cnt + 1
        End If
    Next t
End Function

'=========================================================================
' Remove a plugin from a project
'=========================================================================
Public Sub MainRemovePlugin(ByRef theMain As TKMain, ByVal file As String)
    On Error Resume Next
    Dim t As Long, a As Long
    For t = 0 To UBound(theMain.plugins)
        If UCase$(theMain.plugins(t)) = UCase$(file) Then
            If t = UBound(theMain.plugins) Then
                'If isComPlugin(projectPath & plugPath & theMain.plugins(t)) Then
                '    For a = 0 To UBound(vbPlugins)
                '        If comPlugins(a).filename = projectPath & plugPath & theMain.plugins(t) Then
                '            comPlugins(a).filename = vbNullString
                '        End If
                '    Next a
                'End If
                theMain.plugins(t) = vbNullString
                Exit Sub
            Else
                Dim l As Long
                For l = t To UBound(theMain.plugins)
                    ' If isComPlugin(projectPath & plugPath & theMain.plugins(l)) Then
                    '     For a = 0 To UBound(vbPlugins)
                    '         If comPlugins(a).filename = projectPath & plugPath & theMain.plugins(l) Then
                    '             comPlugins(a).filename = vbNullString
                    '         End If
                    '     Next a
                    ' End If
                    theMain.plugins(l - 1) = theMain.plugins(l)
                Next l
                theMain.plugins(UBound(theMain.plugins)) = vbNullString
                Exit Sub
            End If
        End If
    Next t
End Sub

'=========================================================================
' Upgrade v3 beta BS --> 3.04 BS
'=========================================================================
Private Sub upgradeBattleSystem()

    On Error Resume Next

    If (mainMem.fightPlugin = "tk3fight.dll") Then

        Dim fullPath As String
        fullPath = projectPath & plugPath & "tk3fight.dll"

        Dim theVersion As Long
        theVersion = pluginVersion(fullPath)

        If (theVersion = 30) Then

            'Initial version 3 battle system-- needs updating

            Const newDLL As String = "Game\Basic\Plugin\tk3fight.dll"
            If fileExists(newDLL) Then

                'Backup old fight DLL
                Dim destPath As String
                destPath = projectPath & plugPath & "tk3fight_old.dll"
                Call FileCopy(fullPath, destPath)

                'Put the new DLL in place
                Call Kill(fullPath)
                Call FileCopy(newDLL, fullPath)

#If (isToolkit = 0) Then

                'It's trans3 and the DLL is supposed to already be registered
                'but it's not-- make it happen
                Call ExecCmd("regsvr32 /s """ & fullPath & """")

                'Now setup the plugin for usage
                Call setupComPlugin(fullPath)

#End If

            End If

        Else

#If (isToolkit = 1) Then
            ' Close the plugin
            Call releaseComPlugins
#End If

        End If

    End If

End Sub

'=========================================================================
' Open a project file
'=========================================================================
Public Sub openMain(ByVal file As String, ByRef theMain As TKMain)

    On Error Resume Next

    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, t As Long
    If (LenB(file) = 0) Then Exit Sub

    num = FreeFile()

    Call MainClear(theMain)

    mainNeedUpdate = False
    
    With theMain
    
        .mainResolution = 0
   
        file = PakLocate(file)
    
        num = FreeFile()
        Open file For Binary As num
            Dim b As Byte
            Get num, 14, b
            If (b) Then
                Close num
                GoTo ver2oldMain
            End If
        Close num

        loadedMainFile = file
   
        Open file For Binary As num

            fileHeader = BinReadString(num)      'Filetype
            If fileHeader <> "RPGTLKIT MAIN" Then
                Close num
                MsgBox "Unrecognised File Format! " & file, , "Open mainForm File"
                Exit Sub
            End If
    
            majorVer = BinReadInt(num)         'Version
            minorVer = BinReadInt(num)         'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This Project was created with an unrecognised version of the Toolkit": Close #num: Exit Sub

            Call BinReadInt(num)
            Call BinReadString(num)

            projectPath = BinReadString(num)
            .gameTitle = BinReadString(num)
            .mainScreenType = BinReadInt(num)
            .extendToFullScreen = BinReadInt(num)
            .mainResolution = BinReadInt(num)
        
            If minorVer < 3 Then
                Call BinReadInt(num)    'old patallax value
            End If
        
            .mainDisableProtectReg = BinReadInt(num)
            m_LangFile = BinReadString(num)
        
            .startupPrg = BinReadString(num)
            .initBoard = BinReadString(num)
            .initChar = BinReadString(num)
        
            .runTime = BinReadString(num)
            .runKey = BinReadInt(num)
            .menuKey = BinReadInt(num)
            .Key = BinReadInt(num)

            'extended run time keys...
            Dim cnt As Long
            cnt = BinReadInt(num)
            For t = 0 To cnt
                .runTimeKeys(t) = BinReadInt(num)
                .runTimePrg(t) = BinReadString(num)
            Next t
        
            If minorVer >= 3 Then
                .menuPlugin = BinReadString(num)
                .fightPlugin = BinReadString(num)
            Else
                Call BinReadInt(num)
                .menuPlugin = "tk3menu.dll"
                .fightPlugin = "tk3fight.dll"
            End If

            If minorVer <= 2 Then
                Call BinReadLong(num)   'was multitask speed
                Call BinReadInt(num)    'was v 1.4 memory protection
            End If

            .fightgameYN = BinReadInt(num)
        
            cnt = BinReadInt(num)
            For t = 0 To cnt
                .enemy(t) = BinReadString(num)
                .skill(t) = BinReadInt(num)
            Next t
        
            .fightType = BinReadInt(num)
            .chances = BinReadLong(num)
            .fprgYN = BinReadInt(num)
            .fightPrg = BinReadString(num)
        
            If minorVer < 3 Then
                Call BinReadInt(num)    'old fight style option
            End If
        
            .gameOverPrg = BinReadString(num)

            'skin stuff...
            .skinButton = BinReadString(num)
            .skinWindow = BinReadString(num)
        
            'plugin stuff...
            If minorVer <= 2 Then
                cnt = BinReadInt(num)
                Dim readin As Integer
                For t = 0 To cnt
                    readin = BinReadInt(num)
                    If readin = 1 Then
                        Call MainAddPlugin(theMain, "tkplug" & CStr(t) & ".dll")
                    End If
                Next t
            Else
                cnt = BinReadInt(num)
                For t = 0 To cnt
                    Call MainAddPlugin(theMain, BinReadString(num))
                Next t
            End If

            'day/night stuff...
            .mainUseDayNight = BinReadInt(num)
            .mainDayNightType = BinReadInt(num)
            .mainDayLength = BinReadLong(num)
    
            If minorVer >= 3 Then
                .cursorMoveSound = BinReadString(num)
                .cursorSelectSound = BinReadString(num)
                .cursorCancelSound = BinReadString(num)
                .useJoystick = BinReadByte(num)
                .colordepth = BinReadByte(num)
            End If

            If (minorVer >= 4) Then
                .gameSpeed = BinReadByte(num)
                .pixelMovement = BinReadByte(num)
            Else
                .gameSpeed = 2
            End If

            If (minorVer < 6) Then
                If (minorVer = 5) Then
                    If (BinReadByte(num) = 1) Then
                        .mouseCursor = "TK DEFAULT"
                    Else
                        .mouseCursor = vbNullString
                    End If
                Else
                    .mouseCursor = "TK DEFAULT"
                End If
                .hotSpotX = 0
                .hotSpotY = 0
            Else
                .mouseCursor = BinReadString(num)
                .hotSpotX = BinReadByte(num)
                .hotSpotY = BinReadByte(num)
                .transpcolor = BinReadLong(num)
            End If

            If (.mouseCursor = "TK DEFAULT") Then
                .transpcolor = RGB(255, 0, 0)
            End If

            If (minorVer >= 7) Then
                mainMem.resX = BinReadLong(num)
                mainMem.resY = BinReadLong(num)
            End If

        Close num

        If minorVer <= 2 Then
            'old version 2 mainfile
            'move plugins into the project folder...
            MkDir Mid$(projectPath & plugPath, 1, Len(projectPath & plugPath) - 1)
            Dim pdir As String
            Dim pfile As String
            pfile = Dir(plugPath & "*.*")
            Do While (LenB(pfile))
                Call FileCopy(plugPath & pfile, projectPath & plugPath & pfile)
                pfile = Dir
            Loop
        End If
    
        Call upgradeBattleSystem

        Exit Sub

ver2oldMain:

        Open file For Input As num
            Input #num, fileHeader        'Filetype
            If fileHeader <> "RPGTLKIT mainForm" Then Close #num: GoTo openVersion1Main
            Input #num, majorVer           'Version
            Input #num, minorVer           'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Sub
            If minorVer <> minor Then
                Dim user As VbMsgBoxResult
                user = MsgBox("This file was created using Version " & CStr(majorVer) & "." & CStr(minorVer) & ".  You have version " & currentVersion & ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then Close #num: Exit Sub      'selected no
            End If
            Call fread(num)          'registeredYN
            .startupPrg = fread(num)      'start up program
            .runTime = fread(num)          'run time program
            Call fread(num)     'use built in menu? 0-yes, 1-no
            mainMem.menuPlugin = "tk3menu.dll"
            .runKey = fread(num)            'ascii code of run time key
            .menuKey = fread(num)           'ascii code of menu key
            .Key = fread(num)               'ascii code of general run key
            .initBoard = fread(num)        'initial board
            .initChar = fread(num)         'initial character
            .fightgameYN = fread(num)       'fighting in game? 0-yes, 1-no
            Call fread(num)         'multitask speed (ms)
            Call fread(num)     '1.4 memory protection 0- off, 1- on
            For t = 0 To 500
                .enemy(t) = fread(num)       'list of 500 enemy files 0-500
                .skill(t) = fread(num)        'list of enemy skill levels
            Next t
            .fightType = fread(num)
            .chances = fread(num)
            .fprgYN = fread(num)                 'use alt fight program YN 0-no, 1-yes
            .fightPrg = fread(num)             'program to run for fighting.
            Call fread(num)
            .gameTitle = fread(num)
            .mainScreenType = fread(num)    'screen mode 0=win, 1=full
            Call fread(num)             'fighting style 0-default (ff style) 1-frontal view
            .gameOverPrg = fread(num)           'game over program
            projectPath = fread(num)
            .skinButton = fread(num)      'skin's button graphic
            .skinWindow = fread(num)      'skin's window graphic
            Call fread(num)               'target platform- 0=Win9x, 1=WinNT
            For t = 0 To 50
                .runTimeKeys(t) = fread(num) 'extended run time key
                .runTimePrg(t) = fread(num) 'extended run time programs
            Next t
            Call fread(num)            'reg code
            .extendToFullScreen = fread(num)
            .mainResolution = fread(num)         'resoltion
            Dim numberOfPlugins As Long
            numberOfPlugins = fread(num)   'number of plugins following.
            If numberOfPlugins Then
                For t = 0 To numberOfPlugins - 1
                    Dim inr As Integer
                    inr = fread(num)      'use plugin yn?
                    If inr = 1 Then
                        Call MainAddPlugin(theMain, "tkplug" & CStr(t) & ".dll")
                    End If
                Next t
            End If
            .mainUseDayNight = fread(num)  'game is affected by day and night 0=no, 1=yes
            .mainDayNightType = fread(num) 'day/night type: 0=real world, 1=set time
            .mainDayLength = fread(num)              'day length, in minutes
            .mainDisableProtectReg = fread(num)   'disable protect registered files (0=no, 1=yes)
            Call fread(num) 'old parallax value
            m_LangFile = fread(num)
        Close num

        If minorVer <= 2 Then
            'old version 2 mainfile
            'move plugins into the project folder...
            MkDir Mid$(projectPath & plugPath, 1, Len(projectPath & plugPath) - 1)
            Dim pdir2 As String
            Dim pfile2 As String
            pfile2 = Dir(plugPath & "*.*")
            Do While (LenB(pfile2))
                Call FileCopy(plugPath & pfile2, projectPath & plugPath & pfile2)
                pfile2 = Dir
            Loop
        End If

        Call upgradeBattleSystem

        Exit Sub

openVersion1Main:

        'OK, apparently we have a version 1 mainForm file.

        .fprgYN = 0
        Dim pth As String
    
        pth = GetPath(file)
        .menuPlugin = "tk3menu.dll"
        Open file For Input As num
            Call fread(num)
            .startupPrg = fread(num)
            .runTime = fread(num)
            .runKey = Asc(fread(num))
            .initBoard = fread(num)
            Call fread(num)
            Call fread(num)
            .fightType = fread(num)
            .chances = fread(num)
            Dim fgtMain As String
            fgtMain = fread(num)
        Close num

        'and now we go after the mainForm fight file
        Open pth & fgtMain For Input As num
            For t = 0 To 250
                .enemy(t) = fread(num)             ' FIRST 500 STATEMENTS ARE ALTERNATING
                .skill(t) = fread(num)             ' ENEMY FILENAMES AND SKILLS
            Next
        Close num

        Call upgradeBattleSystem
    
    End With
    
End Sub

'=========================================================================
' Save a project file
'=========================================================================
Public Sub saveMain(ByVal file As String, ByRef theMain As TKMain)

    On Error Resume Next
    
    Dim num As Long, t As Long
    num = FreeFile
    If (LenB(file$) = 0) Then Exit Sub
    
    Call Kill(file)
    
    Open file For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT MAIN")    'Filetype
        Call BinWriteInt(num, major)
        Call BinWriteInt(num, 7)    'Minor version (1= ie 2.1 (ascii) 2= 2.19 (binary), 3- 3.0, interim)
        Call BinWriteInt(num, 1)    'registered
        Call BinWriteString(num, "NOCODE")            'No reg code
    
        Call BinWriteString(num, projectPath$)
        Call BinWriteString(num, theMain.gameTitle)
        Call BinWriteInt(num, theMain.mainScreenType)
        Call BinWriteInt(num, theMain.extendToFullScreen)
        Call BinWriteInt(num, theMain.mainResolution)
        Call BinWriteInt(num, theMain.mainDisableProtectReg)
        Call BinWriteString(num, m_LangFile)
        
        Call BinWriteString(num, theMain.startupPrg)
        Call BinWriteString(num, theMain.initBoard)
        Call BinWriteString(num, theMain.initChar)
        
        Call BinWriteString(num, theMain.runTime)
        Call BinWriteInt(num, theMain.runKey)
        Call BinWriteInt(num, theMain.menuKey)
        Call BinWriteInt(num, theMain.Key)
        'extended run time keys...
        Call BinWriteInt(num, UBound(theMain.runTimeKeys))
        For t = 0 To UBound(theMain.runTimeKeys)
            Call BinWriteInt(num, theMain.runTimeKeys(t))
            Call BinWriteString(num, theMain.runTimePrg(t))
        Next t
        
        Call BinWriteString(num, theMain.menuPlugin)
        Call BinWriteString(num, theMain.fightPlugin)
        Call BinWriteInt(num, theMain.fightgameYN)
        
        Call BinWriteInt(num, UBound(theMain.enemy))
        For t = 0 To UBound(theMain.enemy)
            Call BinWriteString(num, theMain.enemy(t))
            Call BinWriteInt(num, theMain.skill(t))
        Next t
        
        Call BinWriteInt(num, theMain.fightType)
        Call BinWriteLong(num, theMain.chances)
        Call BinWriteInt(num, theMain.fprgYN)
        Call BinWriteString(num, theMain.fightPrg)
        Call BinWriteString(num, theMain.gameOverPrg)
        'skin stuff...
        Call BinWriteString(num, theMain.skinButton)
        Call BinWriteString(num, theMain.skinWindow)
        'plugin stuff...
        Call BinWriteInt(num, UBound(theMain.plugins))
        For t = 0 To UBound(theMain.plugins)
            Call BinWriteString(num, theMain.plugins(t))
        Next t
        'day/night stuff...
        Call BinWriteInt(num, theMain.mainUseDayNight)
        Call BinWriteInt(num, theMain.mainDayNightType)
        Call BinWriteLong(num, theMain.mainDayLength)
    
        Call BinWriteString(num, theMain.cursorMoveSound)
        Call BinWriteString(num, theMain.cursorSelectSound)
        Call BinWriteString(num, theMain.cursorCancelSound)
    
        Call BinWriteByte(num, theMain.useJoystick)
        Call BinWriteByte(num, theMain.colordepth)
        
        Call BinWriteByte(num, theMain.gameSpeed)
        Call BinWriteByte(num, theMain.pixelMovement)
        Call BinWriteString(num, theMain.mouseCursor)
        Call BinWriteByte(num, theMain.hotSpotX)
        Call BinWriteByte(num, theMain.hotSpotY)
        Call BinWriteLong(num, theMain.transpcolor)
        Call BinWriteLong(num, theMain.resX)
        Call BinWriteLong(num, theMain.resY)
        
    Close num

End Sub

'=========================================================================
' Clear a project
'=========================================================================
Public Sub MainClear(ByRef theMain As TKMain)
    On Error Resume Next
    With theMain
        .resX = 0
        .resY = 0
        .gameTitle = vbNullString              'title of game
        .mainScreenType = 0        'screen type 2=windowed, 1=optimal resolution (640x480), 0- actual window
        .extendToFullScreen = 0    'extend screen to maximum extents (0=no, 1=yes)
        .mainResolution = 0        'resolution to use for optimal res 0=640x480, 1=800x600, 2=1024x768
        .mainDisableProtectReg = 0 'disable protect registered files (0=no, 1=yes)
        .startupPrg = vbNullString            'start up program
        .initBoard = vbNullString              'initial board
        .initChar = vbNullString               'initial character
        .runTime = vbNullString                'run time program
        .runKey = 0                'ascii code of run time key
        .menuKey = 0               'ascii code of menu key
        .Key = 0                   'ascii code of general run key
        Dim t As Long
        For t = 0 To UBound(.runTimeKeys)
            .runTimeKeys(t) = 0      '50 extended run time keys
            .runTimePrg(t) = vbNullString        '50 extended run time programs
        Next t
        .menuPlugin = vbNullString
        .fightPlugin = vbNullString
        .fightgameYN = 0           'fighting in game? 0-yes, 1-no
        For t = 0 To UBound(.enemy)
            .enemy(t) = vbNullString             'list of 500 enemy files 0-500
            .skill(t) = 0           'list of enemy skill levels
        Next t
        .fightType = 0             'fight type: 0-random, 1- planned
        .chances = 0                  'chances of getting in fight (1 in x ) OR number of steps to take
        .fprgYN = 0                'use alt fight program YN 0-no, 1-yes
        .fightPrg = vbNullString               'program to run for fighting.
        .gameOverPrg = vbNullString            'game over program
        .skinButton = vbNullString             'skin's button graphic
        .skinWindow = vbNullString             'skin's window graphic
        ReDim .plugins(4)
        For t = 0 To UBound(.plugins)
            .plugins(t) = vbNullString
        Next t
        .mainUseDayNight = 0       'game is affected by day and night 0=no, 1=yes
        .mainDayNightType = 0      'day/night type: 0=real world, 1=set time
        .mainDayLength = 0            'day length, in minutes
        .cursorMoveSound = vbNullString
        .cursorSelectSound = vbNullString
        .cursorCancelSound = vbNullString
        .useJoystick = 1
        .mouseCursor = "TK DEFAULT"
        .pixelMovement = 0
        .gameSpeed = 2
        .hotSpotX = 0
        .hotSpotY = 0
        .transpcolor = RGB(255, 0, 0)
    End With
End Sub
