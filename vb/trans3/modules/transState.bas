Attribute VB_Name = "transState"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Game saving/loading routines
' Status: C+
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================
Public playerListAr(4) As String          '"Handles" of 5 (0-4) characters on team.
Public playerFile(4) As String            'Filenames of 5 chars
Public otherPlayers(25) As String         'filenames of 25 other players that used to be equipped (0-25)
Public otherPlayersHandle(25) As String   'handles of 25 other players that used to be equipped (0-25)
Public inv As New CInventory              'global inventory
Public playerEquip(16, 4) As String       'What is equipped on each player (filename)
Public equipList(16, 4) As String         'What is equipped on each player (handle)
Public equipHPadd(4) As Long              'amount of HP added because of equipment.
Public equipSMadd(4) As Long              'amt of smp added by equipment.
Public equipDPadd(4) As Long              'amt of dp added by equipment.
Public equipFPadd(4) As Long              'amt of fp added by equipment.
Public menuColor As Long                  'main menu color
Public GPCount As Long                    'Gp carried by player
Public MWinBkg As Long                    'Message window background color (rgb): -1 if a graphic
Public MWinPic As String                  'picture in message window
Public MWinSize As Long                   'size of mwin,. in percentage of screen
Public debugYN As Long                    'debug window available? 0- No, 1-Yes
Public fontColor As Long                  'color of font (rgb)
Public fontName As String                 'filename of font
Public fontSize As Long                   'font size (pixels)
Public boldYN As Long                     'bold on/off 0-off, 1-on
Public underlineYN As Long                'uline on/off 0-off, 1-on
Public italicsYN As Long                  'ital on/off 0-off 1-on
Public gameTime As Long                   'length of game, in seconds
Public stepsTaken As Long                 'number of steps taken
Public walkDelay As Double                'delay to insert between walking moves.  Also used for general pausing in loops (like #Zoom)
Public menuGraphic As String              'graphic of main menu
Public fightMenuGraphic As String         'graphic of fight menu
Public newPlyrName As String              'what newplyr has done

'=========================================================================
' Restore a character
'=========================================================================
Public Sub RestoreCharacter(ByVal file As String, ByVal number As Long, ByVal restoreLev As Boolean)

    On Error Resume Next

    If number < 0 Or number > 4 Then Exit Sub

    Call openChar(file$, playerMem(number))

    'Initialize this character:
    playerListAr$(number) = playerMem(number).charname$
    playerFile$(number) = file$

    'change player graphics...
    Dim aProgram As RPGCodeProgram
    ReDim aProgram.program(10)
    aProgram.boardNum = -1
    If (number = selectedPlayer) And (LenB(newPlyrName$) <> 0) Then
        Call NewPlyr("NewPlyr(""" & newPlyrName & """)", aProgram)
    End If
    
    'now calculate level up stuff:
    Dim hislev As Double
    Dim hisexp As Double
    Dim l As String
    Dim aa As Long
    If restoreLev Then
        aa = getIndependentVariable(playerMem(number).leVar$, l$, hislev)
        aa = getIndependentVariable(playerMem(number).experienceVar$, l$, hisexp)
        If hislev = playerMem(number).initLevel Then
            playerMem(number).nextLevel = playerMem(number).levelType
            playerMem(number).levelProgression = playerMem(number).levelType
        Else
            'ok, now for some calculations:
            Dim levup As Long
            Dim total As Long
            levup = playerMem(number).levelType
            total = levup
            
            Dim ll As Long
            Dim incr As Double
            
            For ll = playerMem(number).initLevel To hislev
                If playerMem(number).charLevelUpType = 0 Then
                    incr = levup * (playerMem(number).experienceIncrease / 100)
                    levup = Int(levup + incr)
                    total = total + levup
                Else
                    incr = playerMem(number).experienceIncrease
                    levup = Int(levup + incr)
                    total = total + levup
                End If
            Next ll
            playerMem(number).nextLevel = total - hisexp
            playerMem(number).levelProgression = levup
        End If
    End If

    Call calcLevels(playerMem(number), False)

End Sub

'=========================================================================
' Load game state from a file
'=========================================================================
Public Sub LoadState(ByVal file As String)
    On Error Resume Next
    If (LenB(file$) = 0) Then Exit Sub
    Dim num As Long
    num = FreeFile
    Call clearRedirects
    newPlyrName$ = vbNullString
    
    Dim nCount As Long
    Dim t As Long, z As Long
    Dim fn As String
    Dim minorVer As Integer

    'Clear some aesthetic settings:
    facing = South
    For t = 0 To 4
        showPlayer(t) = False           'Hide the players. Individually shown in restorePlayer
    Next t

    Open file For Input Access Read As #num
        If fread(num) = "RPGTLKIT SAVE" Then
        
            'It's a version two old save state
            
            Dim vName As String
            Dim Temp As String
            
            Dim majorVer As Variant
            Input #num, majorVer
            Input #num, minorVer
            Call clearVars(globalHeap)
            If minorVer = 0 Then
                'old style...
                'Now, all the numerical variables:
                For t = 0 To 8000
                    Line Input #num, vName$
                    vName$ = vName & "!"
                    Line Input #num, Temp$
                    'internationalisation-- convert ',' to '.'
                    Temp$ = replace(Temp$, ",", ".")
                    If LenB(vName$) <> 0 Then
                        Call SetNumVar(vName$, val(Temp$), globalHeap)
                    End If
                Next t
                'Now all the lit vars:
                For t = 0 To 3000
                    Line Input #num, vName$
                    vName$ = vName & "$"
                    Line Input #num, Temp$
                    'internationalisation-- convert ',' to '.'
                    If LenB(vName$) <> 0 Then
                        Call SetLitVar(vName$, Temp$, globalHeap)
                    End If
                Next t
            Else
                'first get the numerical vars...
                Input #num, nCount
                For t = 1 To nCount
                    Line Input #num, vName$
                    Line Input #num, Temp$
                    'internationalisation-- convert ',' to '.'
                    Temp$ = replace(Temp$, ",", ".")
                    If LenB(vName$) <> 0 Then
                        Call SetNumVar(vName$, val(Temp$), globalHeap)
                    End If
                Next t
                'now get the lit vars...
                Input #num, nCount
                For t = 1 To nCount
                    Line Input #num, vName$
                    Line Input #num, Temp$
                    If LenB(vName$) <> 0 Then
                        Call SetLitVar(vName$, Temp$, globalHeap)
                    End If
                Next t
                'now get the redirect...
                Input #num, nCount
                For t = 1 To nCount
                    Line Input #num, vName$
                    Line Input #num, Temp$
                    If LenB(vName$) <> 0 Then
                        Call SetRedirect(vName$, Temp$)
                    End If
                Next t
            End If
            'Player/team info:
            For t = 0 To 4
                playerListAr$(t) = fread(num)  '"Handles" of 5 (0-4) characters on team.
                playerFile$(t) = fread(num)
            Next t
            Call inv.clear
            For t = 0 To 500
                inv.fileNames(t) = fread(num)
                inv.handles(t) = fread(num)
                inv.quantities(t) = fread(num)
            Next t
            For t = 1 To 16
                For z = 0 To 4
                    Line Input #num, playerEquip$(t, z) 'What is equipped on each player (filename)
                    Line Input #num, equipList$(t, z) 'What is equipped on each player (handle)
                Next z
            Next t
            For t = 0 To 4
                Input #num, equipHPadd(t) 'amount of HP added because of equipment.
                Input #num, equipSMadd(t)  'amt of smp added by equipment.
                Input #num, equipDPadd(t)  'amt of dp added by equipment.
                Input #num, equipFPadd(t)  'amt of fp added by equipment.
            Next t

            Input #num, menuColor   'main menu color

            'Reverse compatibility stuff:
            Call fread(num)
            Call fread(num)
            Call fread(num)

            'Constants:
            Input #num, selectedPlayer 'number of player graphic
            Input #num, GPCount         'Gp carried by player
            Input #num, MWinBkg         'Message window background color (rgb): -1 if a graphic
            Input #num, MWinPic$        'picture in message window
            Input #num, debugYN         'debug window available? 0- No, 1-Yes
            Input #num, fontColor       'color of font (rgb)
            Input #num, fontName$
            Input #num, fontSize 'font size (pixels)
            Input #num, boldYN  'bold on/off 0-off, 1-on
            Input #num, underlineYN 'uline on/off 0-off, 1-on
            Input #num, italicsYN 'ital on/off 0-off 1-on
            Line Input #num, Temp$
            'internationalisation-- convert ',' to '.'
            Temp$ = replace(Temp$, ",", ".")
            gameTime = val(Temp$)  'length of game, in seconds
            Input #num, stepsTaken  'number of steps taken
            'Filename of main file:
            Input #num, loadedMainFile$
            'Filename of current board:
            Input #num, currentBoard$
            fn$ = currentBoard$
            fn$ = RemovePath(currentBoard$)
            currentBoard$ = projectPath & brdPath & fn$
            'Current x, y and layer:
            For t = 0 To 4
                pPos(t).x = fread(num)
                pPos(t).y = fread(num)
                pPos(t).l = fread(num)
            Next t
            For t = 0 To 4
                Input #num, playerMem(t).nextLevel 'next level for players
                Input #num, playerMem(t).levelProgression
            Next t
            Call fread(num)
            Call fread(num)
            Call fread(num)
            For t = 0 To 25
                Line Input #num, otherPlayers$(t)    'filenames of 25 other players that used to be equipped (0-25)
                Line Input #num, otherPlayersHandle$(t) 'handles of 25 other players that used to be equipped (0-25)
            Next t
            Call fread(num)
            Call fread(num)
            Call fread(num)
            Input #num, menuGraphic$     'graphic of main menu
            Input #num, fightMenuGraphic$     'graphic of main menu
            Call fread(num)
            Input #num, MWinSize
            Call fread(num)
            Input #num, newPlyrName
            initTime = Timer()
            addTime = gameTime
            showPlayer(selectedPlayer) = True
            Exit Sub
        
        End If
    Close num

    Open file For Binary Access Read As num
        Dim header As String
        header = BinReadString(num)
        If header$ <> "RPGTLKIT SAVE" Then
            If (LenB(errorBranch) = 0) Or (errorBranch = "Resume Next") Then
                Call MBox("Invalid Save Format")
            Else
                Call debugger("Branch!")
            End If
            Exit Sub
        End If
        Call BinReadInt(num)    'majorver 3
        minorVer = BinReadInt(num)   'minorver 0
        Call clearVars(globalHeap)
        
        'get num vars...
        nCount = BinReadLong(num)
        
        Dim varname As String
        Dim varValue As Double
        Dim varString As String
        
        For t = 1 To nCount
            varname = BinReadString(num)
            varValue = BinReadDouble(num)
            If LenB(varname) <> 0 Then
                Call SetNumVar(varname, varValue, globalHeap)
            End If
        Next t
        
        nCount = BinReadLong(num)
        For t = 1 To nCount
            varname = BinReadString(num)
            varString = BinReadString(num)
            If LenB(varname) <> 0 Then
                Call SetLitVar(varname, varString, globalHeap)
            End If
        Next t
        
        'get redirects...
        nCount = BinReadLong(num)
        For t = 1 To nCount
            varname = BinReadString(num)
            varString = BinReadString(num)
            If LenB(varname) <> 0 Then
                Call SetRedirect(varname, varString)
            End If
        Next t
        
        'Player/team info:
        For t = 0 To 4
            playerListAr$(t) = BinReadString(num)  '"Handles" of 5 (0-4) characters on team.
            playerFile$(t) = BinReadString(num)
        Next t
        Dim sz As Integer
        sz = BinReadInt(num)
        For t = 0 To sz
            inv.fileNames(t) = BinReadString(num)   'Filenames of 500 items in inventory
            inv.handles(t) = BinReadString(num)   'Handles of 500 items in inventory
            inv.quantities(t) = BinReadLong(num)   'Number of each item in inventory
        Next t
        For t = 1 To 16
            For z = 0 To 4
                playerEquip$(t, z) = BinReadString(num)   'What is equipped on each player (filename)
                equipList$(t, z) = BinReadString(num)   'What is equipped on each player (handle)
            Next z
        Next t
        For t = 0 To 4
            equipHPadd(t) = BinReadLong(num)   'amount of HP added because of equipment.
            equipSMadd(t) = BinReadLong(num)  'amt of smp added by equipment.
            equipDPadd(t) = BinReadLong(num)  'amt of dp added by equipment.
            equipFPadd(t) = BinReadLong(num)  'amt of fp added by equipment.
        Next t

        menuColor = BinReadLong(num)   'mainForm menu color

        'Constants:
        selectedPlayer = BinReadLong(num) 'number of player graphic
        GPCount = BinReadLong(num)         'Gp carried by player
        MWinBkg = BinReadLong(num)         'Message window background color (rgb): -1 if a graphic
        MWinPic$ = BinReadString(num)        'picture in message window
        debugYN = BinReadLong(num)         'debug window available? 0- No, 1-Yes
        fontColor = BinReadLong(num)       'color of font (rgb)
        fontName$ = BinReadString(num)
        fontSize = BinReadLong(num) 'font size (pixels)
        boldYN = BinReadLong(num)  'bold on/off 0-off, 1-on
        underlineYN = BinReadLong(num) 'uline on/off 0-off, 1-on
        italicsYN = BinReadLong(num) 'ital on/off 0-off 1-on
        gameTime = BinReadLong(num)    'length of game, in seconds
        stepsTaken = BinReadLong(num)  'number of steps taken

        'Filename of mainForm file:
        loadedMainFile$ = BinReadString(num)
        'Filename of current board:
        currentBoard$ = BinReadString(num)
        fn$ = currentBoard$
        fn$ = RemovePath(currentBoard$)
        currentBoard$ = projectPath & brdPath & fn$
        
        'Current x, y and layer:
        For t = 0 To 4
            pPos(t).x = BinReadDouble(num)
            pPos(t).y = BinReadDouble(num)
            pPos(t).l = BinReadLong(num)
        Next t
        For t = 0 To 4
            playerMem(t).nextLevel = BinReadLong(num) 'next level for players
            playerMem(t).levelProgression = BinReadLong(num)
        Next t
        For t = 0 To 25
            otherPlayers$(t) = BinReadString(num) 'filenames of 25 other players that used to be equipped (0-25)
            otherPlayersHandle$(t) = BinReadString(num) 'handles of 25 other players that used to be equipped (0-25)
        Next t
        menuGraphic$ = BinReadString(num) 'graphic of mainForm menu
        fightMenuGraphic$ = BinReadString(num) 'graphic of mainForm menu
        MWinSize = BinReadLong(num)
        newPlyrName = BinReadString(num)
    
        'restore active threads...
        Call InitThreads
        nCount = BinReadLong(num)
        For t = 0 To nCount
            Dim f As String
            f = BinReadString(num)
            
            Dim bPersist As Boolean
            If BinReadLong(num) = 1 Then
                bPersist = True
            Else
                bPersist = False
            End If
            
            Dim pos As Long
            pos = BinReadLong(num)
            
            'read sleep info...
            Dim bSleep As Boolean
            If BinReadLong(num) = 1 Then
                bSleep = True
            Else
                bSleep = False
            End If
            Dim dSleepDuration As Double
            dSleepDuration = BinReadDouble(num)
            
            Dim tID As Long
            If (LenB(f) <> 0) Then
                tID = CreateThread(f, bPersist)
                Threads(tID).thread.programPos = pos
                If (bSleep) Then
                    Call ThreadSleep(tID, dSleepDuration)
                End If
            End If

            'read local variables...
            Dim heaps As Long
            heaps = BinReadLong(num)
            Dim tt As Long
            For tt = 0 To heaps
                If tt <> 0 Then
                    Call AddHeapToStack(Threads(t).thread)
                End If
                'read num vars...
                nCount = BinReadLong(num)

                Dim ttt As Long
                For ttt = 1 To nCount
                    varname = BinReadString(num)
                    varValue = BinReadDouble(num)
                    If ((LenB(varname) <> 0) And (LenB(f) <> 0)) Then
                        Call SetNumVar(varname, varValue, Threads(t).thread.heapStack(tt))
                    End If
                Next ttt

                'read lit vars...
                nCount = BinReadLong(num)

                For ttt = 1 To nCount
                    varname = BinReadString(num)
                    varString = BinReadString(num)
                    If ((LenB(varname) <> 0) And (LenB(f) <> 0)) Then
                        Call SetLitVar(varname, varString, Threads(t).thread.heapStack(tt))
                    End If
                Next ttt
            Next tt
        Next t

        'Movement size...
        transLocate.movementSize = BinReadDouble(num)

        'Read rpgcode object stuffs
        If (minorVer >= 1) Then
            ReDim classes(BinReadLong(num))
            For t = 0 To UBound(classes)
                classes(t).hClass = BinReadLong(num)
                classes(t).strInstancedFrom = BinReadString(num)
            Next t
            ReDim objHandleUsed(BinReadLong(num))
            For t = 0 To UBound(objHandleUsed)
                objHandleUsed(t) = (BinReadByte(num) = 1)
            Next t
        End If

        showPlayer(selectedPlayer) = True

    Close num
    initTime = Timer()
    addTime = gameTime
End Sub

'=========================================================================
' Save game state to a file
'=========================================================================
Public Sub SaveState(ByVal file As String)
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    Open file$ For Binary As #num
        Call BinWriteString(num, "RPGTLKIT SAVE")
        Call BinWriteInt(num, 3)    'majorver
        Call BinWriteInt(num, 1)    'minorver
                   
        'print num vars...
        Dim nCount As Long
        nCount = RPGCCountNum(globalHeap)
        
        Call BinWriteLong(num, nCount)
        
        Dim t As Long
        For t = 1 To nCount
            Call BinWriteString(num, GetNumName(t - 1, globalHeap))
            Call BinWriteDouble(num, GetNumVar(GetNumName(t - 1, globalHeap), globalHeap))
        Next t
        
        'print lit vars...
        nCount = RPGCCountLit(globalHeap)
        
        Call BinWriteLong(num, nCount)
        
        For t = 1 To nCount
            Call BinWriteString(num, GetLitName(t - 1, globalHeap))
            Call BinWriteString(num, GetLitVar(GetLitName(t - 1, globalHeap), globalHeap))
        Next t
        
        'print redirects...
        nCount = RPGCCountRedirects()
        
        Call BinWriteLong(num, nCount)
        
        For t = 1 To nCount
            Call BinWriteString(num, getRedirectName(t - 1))
            Call BinWriteString(num, getRedirect(getRedirectName(t - 1)))
        Next t
        
        'Player/team info:
        For t = 0 To 4
            Call BinWriteString(num, playerListAr$(t))  '"Handles" of 5 (0-4) characters on team.
            Call BinWriteString(num, playerFile$(t))
        Next t
        Call BinWriteInt(num, inv.upperBound())
        For t = 0 To inv.upperBound()
            Call BinWriteString(num, inv.fileNames(t))  'Filenames of 500 items in inventory
            Call BinWriteString(num, inv.handles(t))  'Handles of 500 items in inventory
            Call BinWriteLong(num, inv.quantities(t))  'Number of each item in inventory
        Next t
        For t = 1 To 16
            Dim z As Long
            For z = 0 To 4
                Call BinWriteString(num, playerEquip$(t, z))  'What is equipped on each player (filename)
                Call BinWriteString(num, equipList$(t, z))  'What is equipped on each player (handle)
            Next z
        Next t
        For t = 0 To 4
            Call BinWriteLong(num, equipHPadd(t))  'amount of HP added because of equipment.
            Call BinWriteLong(num, equipSMadd(t))  'amt of smp added by equipment.
            Call BinWriteLong(num, equipDPadd(t))  'amt of dp added by equipment.
            Call BinWriteLong(num, equipFPadd(t))  'amt of fp added by equipment.
        Next t

        Call BinWriteLong(num, menuColor)   'mainForm menu color

        'Constants:
        Call BinWriteLong(num, selectedPlayer) 'number of player graphic
        Call BinWriteLong(num, GPCount)         'Gp carried by player
        Call BinWriteLong(num, MWinBkg)         'Message window background color (rgb): -1 if a graphic
        Call BinWriteString(num, MWinPic$)        'picture in message window
        Call BinWriteLong(num, debugYN)         'debug window available? 0- No, 1-Yes
        Call BinWriteLong(num, fontColor)       'color of font (rgb)
        Call BinWriteString(num, fontName$)
        Call BinWriteLong(num, fontSize) 'font size (pixels)
        Call BinWriteLong(num, boldYN)  'bold on/off 0-off, 1-on
        Call BinWriteLong(num, underlineYN) 'uline on/off 0-off, 1-on
        Call BinWriteLong(num, italicsYN) 'ital on/off 0-off 1-on
        Call BinWriteLong(num, gameTime)    'length of game, in seconds
        Call BinWriteLong(num, stepsTaken)  'number of steps taken

        'Filename of mainForm file:
        Call BinWriteString(num, loadedMainFile$)
        'Filename of current board:
        Call BinWriteString(num, currentBoard$)
        'Current x, y and layer:
        For t = 0 To 4
            Call BinWriteDouble(num, pPos(t).x)
            Call BinWriteDouble(num, pPos(t).y)
            Call BinWriteLong(num, pPos(t).l)
        Next t
        For t = 0 To 4
            Call BinWriteLong(num, playerMem(t).nextLevel) 'next level for players
            Call BinWriteLong(num, playerMem(t).levelProgression)
        Next t
        For t = 0 To 25
            Call BinWriteString(num, otherPlayers$(t)) 'filenames of 25 other players that used to be equipped (0-25)
            Call BinWriteString(num, otherPlayersHandle$(t)) 'handles of 25 other players that used to be equipped (0-25)
        Next t
        Call BinWriteString(num, menuGraphic$) 'graphic of mainForm menu
        Call BinWriteString(num, fightMenuGraphic$) 'graphic of mainForm menu
        Call BinWriteLong(num, MWinSize)
        Call BinWriteString(num, newPlyrName)
        
        'save active threads...
        Call BinWriteLong(num, UBound(Threads))
        For t = 0 To UBound(Threads)
            Call BinWriteString(num, Threads(t).filename)
            If Threads(t).bPersistent Then
                Call BinWriteLong(num, 1)
            Else
                Call BinWriteLong(num, 0)
            End If
            Call BinWriteLong(num, Threads(t).thread.programPos)
            If Threads(t).bIsSleeping Then
                Call BinWriteLong(num, 1)
            Else
                Call BinWriteLong(num, 0)
            End If
            Dim dDuration As Double
            dDuration = ThreadSleepRemaining(t)
            Call BinWriteDouble(num, dDuration)
            
            'write local variables...
            Call BinWriteLong(num, Threads(t).thread.currentHeapFrame)
            Dim tt As Long
            For tt = 0 To Threads(t).thread.currentHeapFrame
                'print num vars...
                nCount = RPGCCountNum(Threads(t).thread.heapStack(tt))
                Call BinWriteLong(num, nCount)
                
                Dim ttt As Long
                For ttt = 1 To nCount
                    Call BinWriteString(num, GetNumName(ttt - 1, Threads(t).thread.heapStack(tt)))
                    Call BinWriteDouble(num, GetNumVar(GetNumName(ttt - 1, Threads(t).thread.heapStack(tt)), Threads(t).thread.heapStack(tt)))
                Next ttt
                
                'print lit vars...
                nCount = RPGCCountLit(Threads(t).thread.heapStack(tt))
                Call BinWriteLong(num, nCount)
                
                For ttt = 1 To nCount
                    Call BinWriteString(num, GetLitName(ttt - 1, Threads(t).thread.heapStack(tt)))
                    Call BinWriteString(num, GetLitVar(GetLitName(ttt - 1, Threads(t).thread.heapStack(tt)), Threads(t).thread.heapStack(tt)))
                Next ttt
            Next tt
        Next t
        
        'Movement size...
        Call BinWriteDouble(num, transLocate.movementSize)
        
        'Write rpgcode object stuffs
        Call BinWriteLong(num, UBound(classes))
        For t = 0 To UBound(classes)
            Call BinWriteLong(num, classes(t).hClass)
            Call BinWriteString(num, classes(t).strInstancedFrom)
        Next t
        Call BinWriteLong(num, UBound(objHandleUsed))
        For t = 0 To UBound(objHandleUsed)
            If (objHandleUsed(t)) Then
                Call BinWriteByte(num, 1)
            Else
                Call BinWriteByte(num, 0)
            End If
        Next t

    Close #num
End Sub


