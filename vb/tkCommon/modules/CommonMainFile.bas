Attribute VB_Name = "CommonMainFile"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'mainForm file Editor:
Option Explicit

Global mainfile$                'filename
Global mainNeedUpdate As Boolean

''''''''''''''''''''''project data'''''''''''''''''''''''''
Global loadedMainFile$

Type TKMain
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
    'extended run time keys...
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
    'skin stuff...
    skinButton As String              'skin's button graphic
    skinWindow As String              'skin's window graphic
    'plugin stuff...
    plugins() As String               'plugin list to use
    'day/night stuff...
    mainUseDayNight As Integer        'game is affected by day and night 0=no, 1=yes
    mainDayNightType As Integer       'day/night type: 0=real world, 1=set time
    mainDayLength As Long             'day length, in minutes
    'sound stuff...
    cursorMoveSound As String         'sound played when cursor moves
    cursorSelectSound As String       'sound played when cursor selects
    cursorCancelSound As String       'sound played when cursor cancels
    'added for beta
    useJoystick As Byte               'allow joystick input? 0- no 1- yes
    colordepth As Byte                'color depth
End Type


Public Const COLOR16 As Byte = 0        '16-bit bolor
Public Const COLOR24 As Byte = 1        '24-bit bolor
Public Const COLOR32 As Byte = 2        '32-bit bolor

Sub MainAddPlugin(ByRef theMain As TKMain, ByVal file As String)
    'add a filename to the list of plugins...
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(theMain.plugins)
        If theMain.plugins(t) = "" Then
            theMain.plugins(t) = file
            Exit Sub
        End If
    Next t
    
    'if we make it here, we need to resize plugin list
    Dim newSize As Long
    Dim oldSize As Long
    oldSize = UBound(theMain.plugins)
    newSize = oldSize * 2
    ReDim Preserve theMain.plugins(newSize)
    theMain.plugins(oldSize + 1) = file
End Sub

Function MainGetNthPlugin(ByRef theMain As TKMain, ByVal idx As Long) As String
    'get the n-th plugin in the list
    On Error Resume Next
    Dim t As Long
    Dim cnt As Long
    
    cnt = 0
    For t = 0 To UBound(theMain.plugins)
        If theMain.plugins(t) <> "" Then
            If cnt = idx Then
                MainGetNthPlugin = theMain.plugins(t)
                Exit Function
            End If
            cnt = cnt + 1
        End If
    Next t
End Function

Sub MainRemovePlugin(ByRef theMain As TKMain, ByVal file As String)
    'add a filename to the list of plugins...
    On Error Resume Next
    Dim t As Long, a As Long
    For t = 0 To UBound(theMain.plugins)
        If UCase$(theMain.plugins(t)) = UCase$(file) Then
            'found it...
            If t = UBound(theMain.plugins) Then
                If isVBPlugin(projectPath & plugPath & theMain.plugins(t)) Then
                    For a = 0 To UBound(vbPlugins)
                        If vbPlugins(a).filename = projectPath & plugPath & theMain.plugins(t) Then
                            vbPlugins(a).filename = ""
                        End If
                    Next a
                End If
                theMain.plugins(t) = ""
                Exit Sub
            Else
                Dim l As Long
                For l = t To UBound(theMain.plugins)
                If isVBPlugin(projectPath & plugPath & theMain.plugins(l)) Then
                    For a = 0 To UBound(vbPlugins)
                        If vbPlugins(a).filename = projectPath & plugPath & theMain.plugins(l) Then
                            vbPlugins(a).filename = ""
                        End If
                    Next a
                End If
                    theMain.plugins(l - 1) = theMain.plugins(l)
                Next l
                theMain.plugins(UBound(theMain.plugins)) = ""
                Exit Sub
            End If
        End If
    Next t
End Sub

Function openMain(ByVal file As String, ByRef theMain As TKMain) As Integer
    On Error Resume Next
    'returns 1 or 0 if this file was marked registered
    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, t As Long
    num = FreeFile
    If file$ = "" Then Exit Function
    
    Call MainClear(theMain)
    
    Dim toRet As Long
    toRet = 0
    
    mainNeedUpdate = False
    theMain.mainResolution = 0
   
    file$ = PakLocate(file$)
    
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 14, b
        If b <> 0 Then
            Close #num
            GoTo ver2oldmain
        End If
    Close #num
    
    loadedMainFile$ = file$
    
    Dim reg As Long, regCode As String
    
    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT MAIN" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open mainForm File": Exit Function
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Project was created with an unrecognised version of the Toolkit": Close #num: Exit Function
        reg = BinReadInt(num)
        toRet = reg
        regCode$ = BinReadString(num)
    
        projectPath$ = BinReadString(num)
        theMain.gameTitle = BinReadString(num)
        theMain.mainScreenType = BinReadInt(num)
        theMain.extendToFullScreen = BinReadInt(num)
        theMain.mainResolution = BinReadInt(num)
        
        If minorVer < 3 Then
            Call BinReadInt(num)    'old patallax value
        End If
        
        theMain.mainDisableProtectReg = BinReadInt(num)
        m_LangFile = BinReadString(num)
        
        theMain.startupPrg = BinReadString(num)
        theMain.initBoard = BinReadString(num)
        theMain.initChar = BinReadString(num)
        
        theMain.runTime = BinReadString(num)
        theMain.runKey = BinReadInt(num)
        theMain.menuKey = BinReadInt(num)
        theMain.Key = BinReadInt(num)
        'extended run time keys...
        Dim cnt As Long
        cnt = BinReadInt(num)
        For t = 0 To cnt
            theMain.runTimeKeys(t) = BinReadInt(num)
            theMain.runTimePrg(t) = BinReadString(num)
        Next t
        
        If minorVer >= 3 Then
            theMain.menuPlugin = BinReadString(num)
            theMain.fightPlugin = BinReadString(num)
        Else
            Call BinReadInt(num)
            theMain.menuPlugin = "tk3menu.dll"
            theMain.fightPlugin = "tk3fight.dll"
        End If
               
        If minorVer <= 2 Then
            Call BinReadLong(num)   'was multitask speed
            Call BinReadInt(num)    'was v 1.4 memory protection
        End If
        theMain.fightgameYN = BinReadInt(num)
        
        cnt = BinReadInt(num)
        For t = 0 To cnt
            theMain.enemy(t) = BinReadString(num)
            theMain.skill(t) = BinReadInt(num)
        Next t
        
        theMain.fightType = BinReadInt(num)
        theMain.chances = BinReadLong(num)
        theMain.fprgYN = BinReadInt(num)
        theMain.fightPrg = BinReadString(num)
        
        If minorVer < 3 Then
            Call BinReadInt(num)    'old fight style option
        End If
        
        theMain.gameOverPrg = BinReadString(num)
        'skin stuff...
        theMain.skinButton = BinReadString(num)
        theMain.skinWindow = BinReadString(num)
        
        'plugin stuff...
        If minorVer <= 2 Then
            cnt = BinReadInt(num)
            Dim readin As Integer
            For t = 0 To cnt
                readin = BinReadInt(num)
                If readin = 1 Then
                    Call MainAddPlugin(theMain, "tkplug" + toString(t) + ".dll")
                End If
            Next t
        Else
            cnt = BinReadInt(num)
            For t = 0 To cnt
                Call MainAddPlugin(theMain, BinReadString(num))
            Next t
        End If
        
        'day/night stuff...
        theMain.mainUseDayNight = BinReadInt(num)
        theMain.mainDayNightType = BinReadInt(num)
        theMain.mainDayLength = BinReadLong(num)
    
        If minorVer >= 3 Then
            theMain.cursorMoveSound = BinReadString(num)
            theMain.cursorSelectSound = BinReadString(num)
            theMain.cursorCancelSound = BinReadString(num)
        
            theMain.useJoystick = BinReadByte(num)
            theMain.colordepth = BinReadByte(num)
        End If
    Close #num
    
    If minorVer <= 2 Then
        'old version 2 mainfile
        'move plugins into the project folder...
        MkDir Mid$(projectPath$ + plugPath$, 1, Len(projectPath$ + plugPath$) - 1)
        Dim pdir As String
        Dim pfile As String
        pfile = Dir$(plugPath$ + "*.*")
        Do While pfile <> ""
            Call FileCopy(plugPath$ + pfile, projectPath$ + plugPath$ + pfile)
            pfile = Dir$
        Loop
    End If
    
    
    openMain = toRet
    Exit Function
ver2oldmain:
    Open file$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT mainForm" Then Close #num: GoTo openversion1main
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Function
        If minorVer <> minor Then
            Dim user As Long
            user = MsgBox("This file was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " & currentVersion & ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Function 'selected no
        End If
        Input #num, reg          'registeredYN
        toRet = reg
        theMain.startupPrg$ = fread(num)      'start up program
        theMain.runTime$ = fread(num)          'run time program
        Call fread(num)     'use built in menu? 0-yes, 1-no
        mainMem.menuPlugin = "tk3menu.dll"
        theMain.runKey = fread(num)            'ascii code of run time key
        theMain.menuKey = fread(num)           'ascii code of menu key
        theMain.Key = fread(num)               'ascii code of general run key
        theMain.initBoard$ = fread(num)        'initial board
        theMain.initChar$ = fread(num)         'initial character
        theMain.fightgameYN = fread(num)       'fighting in game? 0-yes, 1-no
        Call fread(num)         'multitask speed (ms)
        Call fread(num)     '1.4 memory protection 0- off, 1- on
        For t = 0 To 500
            theMain.enemy$(t) = fread(num)       'list of 500 enemy files 0-500
            theMain.skill(t) = fread(num)        'list of enemy skill levels
        Next t
        theMain.fightType = fread(num)
        theMain.chances = fread(num)
        theMain.fprgYN = fread(num)                 'use alt fight program YN 0-no, 1-yes
        theMain.fightPrg$ = fread(num)             'program to run for fighting.
        Dim updatetype As Long
        updatetype = fread(num)
        theMain.gameTitle$ = fread(num)
        theMain.mainScreenType = fread(num)    'screen mode 0=win, 1=full
        Call fread(num)             'fighting style 0-default (ff style) 1-frontal view
        theMain.gameOverPrg$ = fread(num)           'game over program
        projectPath$ = fread(num)
        theMain.skinButton$ = fread(num)      'skin's button graphic
        theMain.skinWindow$ = fread(num)      'skin's window graphic
        Dim targetPlatform As Long
        targetPlatform = fread(num)    'target platform- 0=Win9x, 1=WinNT
        targetPlatform = 0
        For t = 0 To 50
            theMain.runTimeKeys(t) = fread(num) 'extended run time key
            theMain.runTimePrg$(t) = fread(num) 'extended run time programs
        Next t
        regCode$ = fread(num)            'reg code
        theMain.extendToFullScreen = fread(num)
        theMain.mainResolution = fread(num)         'resoltion
        Dim numberOfPlugins As Long
        numberOfPlugins = fread(num)   'number of plugins following.
        If numberOfPlugins <> 0 Then
            For t = 0 To numberOfPlugins - 1
                Dim inr As Integer
                inr = fread(num)      'use plugin yn?
                If inr = 1 Then
                    Call MainAddPlugin(theMain, "tkplug" + toString(t) + ".dll")
                End If
            Next t
        End If
        theMain.mainUseDayNight = fread(num)  'game is affected by day and night 0=no, 1=yes
        theMain.mainDayNightType = fread(num) 'day/night type: 0=real world, 1=set time
        theMain.mainDayLength = fread(num)              'day length, in minutes
        theMain.mainDisableProtectReg = fread(num)   'disable protect registered files (0=no, 1=yes)
        Call fread(num) 'old parallax value
        m_LangFile = fread(num)
    Close #num
    openMain = toRet

    If minorVer <= 2 Then
        'old version 2 mainfile
        'move plugins into the project folder...
        MkDir Mid$(projectPath$ + plugPath$, 1, Len(projectPath$ + plugPath$) - 1)
        Dim pdir2 As String
        Dim pfile2 As String
        pfile2 = Dir$(plugPath$ + "*.*")
        Do While pfile2 <> ""
            Call FileCopy(plugPath$ + pfile2, projectPath$ + plugPath$ + pfile2)
            pfile2 = Dir$
        Loop
    End If

    Exit Function
openversion1main:
    'OK, apparently we have a version 1 mainForm file.
    updatetype = 2
    theMain.fprgYN = 0
    Dim pth As String, dummy As String, runky As String, gamfgt As String, fgtmain As String
    
    pth$ = GetPath(file$)
    theMain.menuPlugin = "tk3menu.dll"
    Open file$ For Input As #num
        Input #num, dummy$
        theMain.startupPrg$ = fread(num)
        theMain.runTime$ = fread(num)
        runky$ = fread(num)
        theMain.runKey = Asc(runky$)
        theMain.initBoard$ = fread(num)
        Input #num, dummy$
        gamfgt$ = fread(num)
        theMain.fightType = fread(num)
        theMain.chances = fread(num)
        fgtmain$ = fread(num)
    Close #num
    'and now we go after the mainForm fight file
    Open pth$ + fgtmain$ For Input As #num
        For t = 0 To 250
            theMain.enemy$(t) = fread(num)             ' FIRST 500 STATEMENTS ARE ALTERNATING
            theMain.skill(t) = fread(num)           ' ENEMY FILENAMES AND SKILLS
        Next
    Close #num
    openMain = 0
End Function


Sub saveMain(ByVal file As String, ByRef theMain As TKMain)
    'saves mainForm file
    On Error Resume Next
    
    Dim num As Long, t As Long
    num = FreeFile
    If file$ = "" Then Exit Sub
    
    Kill file$
    
    Open file$ For Binary As #num
        Call BinWriteString(num, "RPGTLKIT MAIN")    'Filetype
        Call BinWriteInt(num, major)
        Call BinWriteInt(num, 3)    'Minor version (1= ie 2.1 (ascii) 2= 2.19 (binary), 3- 3.0, interim)
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
    Close #num
End Sub


Sub MainClear(ByRef theMain As TKMain)
    On Error Resume Next
    theMain.gameTitle = ""              'title of game
    theMain.mainScreenType = 0        'screen type 2=windowed, 1=optimal resolution (640x480), 0- actual window
    theMain.extendToFullScreen = 0    'extend screen to maximum extents (0=no, 1=yes)
    theMain.mainResolution = 0        'resolution to use for optimal res 0=640x480, 1=800x600, 2=1024x768
    theMain.mainDisableProtectReg = 0 'disable protect registered files (0=no, 1=yes)
    
    theMain.startupPrg = ""            'start up program
    theMain.initBoard = ""              'initial board
    theMain.initChar = ""               'initial character
    
    theMain.runTime = ""                'run time program
    theMain.runKey = 0                'ascii code of run time key
    theMain.menuKey = 0               'ascii code of menu key
    theMain.Key = 0                   'ascii code of general run key
    'extended run time keys...
    Dim t As Long
    For t = 0 To UBound(theMain.runTimeKeys)
        theMain.runTimeKeys(t) = 0      '50 extended run time keys
        theMain.runTimePrg(t) = ""        '50 extended run time programs
    Next t
    
    theMain.menuPlugin = ""
    theMain.fightPlugin = ""
    
    theMain.fightgameYN = 0           'fighting in game? 0-yes, 1-no
    For t = 0 To UBound(theMain.enemy)
        theMain.enemy(t) = ""             'list of 500 enemy files 0-500
        theMain.skill(t) = 0           'list of enemy skill levels
    Next t
    theMain.fightType = 0             'fight type: 0-random, 1- planned
    theMain.chances = 0                  'chances of getting in fight (1 in x ) OR number of steps to take
    theMain.fprgYN = 0                'use alt fight program YN 0-no, 1-yes
    theMain.fightPrg = ""               'program to run for fighting.
    theMain.gameOverPrg = ""            'game over program
    'skin stuff...
    theMain.skinButton = ""             'skin's button graphic
    theMain.skinWindow = ""             'skin's window graphic
    'plugin stuff...
    ReDim theMain.plugins(4)
    For t = 0 To UBound(theMain.plugins)
        theMain.plugins(t) = ""
    Next t
    'day/night stuff...
    theMain.mainUseDayNight = 0       'game is affected by day and night 0=no, 1=yes
    theMain.mainDayNightType = 0      'day/night type: 0=real world, 1=set time
    theMain.mainDayLength = 0            'day length, in minutes
    
    theMain.cursorMoveSound = ""
    theMain.cursorSelectSound = ""
    theMain.cursorCancelSound = ""
    
    theMain.useJoystick = 1
End Sub

