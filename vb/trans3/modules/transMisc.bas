Attribute VB_Name = "transMisc"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'miscellaneous supporting functions

Option Explicit

Public target As Long           'targeted player number
Public targetType As Long       'Targetted type:0-player, 1- item, 2- enemy
Public source As Long           'source player number
Public sourceType As Long       'source type:0-player, 1-item, 2-enemy

Public Const TYPE_PLAYER = 0
Public Const TYPE_ITEM = 1
Public Const TYPE_ENEMY = 2

Function determineSpecialMoves(ByVal handle As String, ByRef fileList() As String) As Long
    'determines which special moves this player can do.
    'this fills up the array passed in with the filenames of the moves you can do.
    'returns the number of moves discovered
    
    On Error Resume Next
    Dim cnum As Long, t As Long, theMove As Long, cnt As Long, a As Long, l As String, expl As Double
    cnum = -1
    'figure out which char it is:
    For t = 0 To UBound(playerListAr)
        If UCase$(playerListAr(t)) = UCase$(handle$) Then cnum = t
    Next t
    If cnum = -1 Then Exit Function
    'Now figure out which move it is:
    theMove = -1
    cnt = 0
    For t = 0 To UBound(playerMem(cnum).smlist)
        Dim ignore As Long
        ignore = 0
        If playerMem(cnum).smlist$(t) <> "" Then
            'Now check if the player can use it yet:
            'First check exp.
            a = GetIndependentVariable(playerMem(cnum).experienceVar$, l$, expl)
            If expl >= playerMem(cnum).spcMinExp(t) Then
                theMove = theMove + 1
                ignore = 1
                fileList$(cnt) = playerMem(cnum).smlist$(t)
                cnt = cnt + 1
            End If
            
            Dim lev As Double, txt As String, nn As Double
            If ignore <> 1 Then
                'now check level
                a = GetIndependentVariable(playerMem(cnum).leVar$, l$, lev)
                If lev >= playerMem(cnum).spcMinLevel(t) Then
                    theMove = theMove + 1
                    ignore = 1
                    fileList$(cnt) = playerMem(cnum).smlist$(t)
                    cnt = cnt + 1
                End If
            End If
            
            If ignore <> 1 Then
                'now check conditioned var
                If playerMem(cnum).spcVar$(t) <> "" Then
                    a = GetIndependentVariable(playerMem(cnum).spcVar$(t), txt$, nn)
                    If a = 0 Then
                        'numerical
                        If nn = val(playerMem(cnum).spcEquals$(t)) Then
                            theMove = theMove + 1
                            fileList$(cnt) = playerMem(cnum).smlist$(t)
                            cnt = cnt + 1
                        End If
                    End If
                    If a = 1 Then
                        'literal
                        If txt$ = playerMem(cnum).spcEquals$(t) Then
                            theMove = theMove + 1
                            fileList$(cnt) = playerMem(cnum).smlist$(t)
                            cnt = cnt + 1
                        End If
                    End If
                End If
            End If
        End If
    Next t
    determineSpecialMoves = cnt
End Function

Function blue(ByVal longColor As Long) As Long
    On Error Resume Next
    Dim jj As Long, bluecomp As Long
    jj = longColor
    bluecomp = Int(jj / 65536)
    blue = bluecomp
End Function

Function red(ByVal longColor As Long) As Long
    On Error Resume Next
    Dim jj As Long, bluecomp As Long, takeaway As Long, greencomp As Long, redcomp As Long
    jj = longColor
    bluecomp = Int(jj / 65536)
    takeaway = bluecomp * 256 * 256
    jj = jj - takeaway
    
    greencomp = Int(jj / 256)
    takeaway = greencomp * 256
    
    redcomp = jj - takeaway
    red = redcomp
End Function


Function green(ByVal longColor As Long) As Long
    On Error Resume Next
    Dim jj As Long, takeaway As Long, bluecomp As Long, greencomp As Long
    jj = longColor
    bluecomp = Int(jj / 65536)
    takeaway = bluecomp * 256 * 256
    jj = jj - takeaway
    
    greencomp = Int(jj / 256)
    green = greencomp

End Function

Function within(ByVal num As Double, ByVal low As Double, ByVal high As Double) As Long
    'tests if a num is within the range low-high.
    'returns 0- false, 1-true
    On Error Resume Next
    If num <= high And num >= low Then within = 1: Exit Function
    within = 0
End Function


Sub alignBoard(ByVal playerX As Double, ByVal playerY As Double)
    '===========================================================
    'REWRITTEN: [Isometrics - Delano 1/04/04]
    'Renamed variables: tX,tY >> tempX,tempY
    '                   pX,pY >> playerX, playerY
    'Attempts to centre the screen on the player.
    'Calculates the required topX,topY for player position playerX,playerY.
    'Called by TestLink, setupmain, Send, LoadRPG when loading a new board or warping.
    'EDITED: [Delano - 12/05/04
    '===========================================================
    
    On Error Resume Next
    
    'Clear the current screen co-ordinates.
    topX = -100: topY = -100
    
    Dim effectiveSizeX As Long
    Dim effectiveSizeY As Long
    Dim effectiveTilesX As Long
    Dim effectiveTilesY As Long
    
    If boardIso() Then
        effectiveSizeX = boardList(activeBoardIndex).theData.Bsizex
        effectiveSizeY = boardList(activeBoardIndex).theData.Bsizey
        effectiveTilesX = tilesX / 2 '= isoTilesX
        effectiveTilesY = tilesY * 2
    Else
        effectiveSizeX = boardList(activeBoardIndex).theData.Bsizex
        effectiveSizeY = boardList(activeBoardIndex).theData.Bsizey
        effectiveTilesX = tilesX
        effectiveTilesY = tilesY
    End If
    
    If effectiveSizeX <= effectiveTilesX Then
        'If board is smaller or equal to the screen size horizontally
        topX = -1 * Int((effectiveTilesX - effectiveSizeX) / 2)
    End If
    
    If effectiveSizeY <= effectiveTilesY Then
        'If board smaller or equal to the screen size vertically
        
        'NOTE: Bug in iso board drawing where negative topYs are not properly placed!!
        topY = -1 * Int((effectiveTilesY - effectiveSizeY) / 2)
        If boardIso() Then topY = 0 'Take this line out when bug fixed!!
    End If
    
    
    
    Dim tempx As Double
    Dim tempy As Double
    'Player position - half screen size
    'This will centre the screen on the player, unless this is off the edges.
    tempx = playerX - effectiveTilesX / 2
    tempy = playerY - effectiveTilesY / 2


    If tempx < 0 Then 'If player on left of board less than half a screen from the edge.
        tempx = 0
    End If
    '[board]sizeX - [screen]tilesX = amount board is wider than screen
    ' ">=" sign important for isometrics!
    If tempx >= effectiveSizeX - effectiveTilesX Then
        'If player is on right more than half a screen from the edge.
        tempx = effectiveSizeX - effectiveTilesX
        'Isometric fix:
        If boardIso() Then tempx = tempx - 0.5 - (tilesX Mod 2) / 2
    End If
    
    If tempy < 0 Then 'If player at top of board less than half a screen from the edge.
        tempy = 0
    End If
    
    'If player is at bottom more than half a screen from the edge.
    'Isometric fix:
    If boardIso() Then
        '[board]sizeY - [screen]tilesY = amount board is taller than screen
        If tempy + 1 >= effectiveSizeY - effectiveTilesY Then
            tempy = effectiveSizeY - effectiveTilesY - 1
        End If
        tempy = tempy / 2
    Else
        If tempy > effectiveSizeY - effectiveTilesY Then
            tempy = effectiveSizeY - effectiveTilesY
        End If
    End If
    
    'If board is larger than screen.
    If topX = -100 Then
        topX = tempx
    End If
    If topY = -100 Then
        topY = tempy
    End If
End Sub


Sub openItems()
    'EDITED: [Isometrics - Delano 11/04/04]
    'Added code to clear the pending movements of the items (caused items to jump when moving to new boards).
    
    'Opens all items on the board.
    On Error Resume Next
    Dim runIt As Long, itemNum As Long, lit As String, num As Double, checkIt As Long
    Dim valueTest As Double, valueTes As String
    runIt = 1

    ' ! ADDED BY KSNiloc...
    ReDim pendingItemMovement(MAXITEM)
    ReDim itmPos(MAXITEM)
    ReDim itemMem(MAXITEM)
    ReDim cnvSprites(MAXITEM)
    Dim a As Long
    For a = 0 To MAXITEM
        'Create item canvases...
        cnvSprites(a) = CreateCanvas(32, 32)
    Next a
    
    ReDim lastItemRender(MAXITEM)

    For itemNum = 0 To MAXITEM '? If the item has a position?
        itmPos(itemNum).frame = 0
        itmPos(itemNum).x = boardList(activeBoardIndex).theData.itmX(itemNum)
        itmPos(itemNum).y = boardList(activeBoardIndex).theData.itmY(itemNum)
        itmPos(itemNum).l = boardList(activeBoardIndex).theData.itmLayer(itemNum)
        itmPos(itemNum).stance = "REST"
        lastItemRender(itemNum).canvas = -1
        
        'Isometric addition: jumping fix for moving to new boards
        pendingItemMovement(itemNum).xOrig = itmPos(itemNum).x
        pendingItemMovement(itemNum).xTarg = itmPos(itemNum).x
        pendingItemMovement(itemNum).yOrig = itmPos(itemNum).y
        pendingItemMovement(itemNum).yTarg = itmPos(itemNum).y

        If boardList(activeBoardIndex).theData.itmActivate(itemNum) = 1 Then
            runIt = 0
            'conditional activation
            checkIt = GetIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate$(itemNum), lit$, num)
            If checkIt = 0 Then
                'it's a numerical variable
                valueTest = num
                If valueTest = val(boardList(activeBoardIndex).theData.itmActivateInitNum$(itemNum)) Then runIt = 1
            End If
            If checkIt = 1 Then
                'it's a literal variable
                valueTes$ = lit$
                If valueTes$ = boardList(activeBoardIndex).theData.itmActivateInitNum$(itemNum) Then runIt = 1
            End If
        End If
        'OK, if runit=1 then we activate it!
        If runIt = 1 And boardList(activeBoardIndex).theData.itmName$(itemNum) <> "" Then
            itemMem(itemNum) = openItem(projectPath$ + itmPath$ + boardList(activeBoardIndex).theData.itmName$(itemNum))
            itemMem(itemNum).bIsActive = True
            'multilist(itemnum) = CreateThread(projectPath$ + prgpath$ + boardList(activeBoardIndex).theData.itemMulti$(itemnum), False)
            If boardList(activeBoardIndex).theData.itemMulti$(itemNum) <> "" Then
                multilist$(itemNum) = boardList(activeBoardIndex).theData.itemMulti$(itemNum)
            Else
                multilist$(itemNum) = itemMem(itemNum).itmPrgOnBoard
            End If
        Else
            itemMem(itemNum).bIsActive = False
            multilist$(itemNum) = ""
        End If
    Next itemNum
    
End Sub

Function GetSpacedElement(ByVal Text As String, ByVal eleeNum As Long) As String
    'gets element number from struing (seperated by spaces)
    On Error Resume Next
    Dim Length As Long, element As Long, p As Long, part As String, ignore As Long
    Dim returnVal As String
    
    Length = Len(Text$)
    element = 0
    For p = 1 To Length + 1
        part$ = Mid$(Text$, p, 1)
        If part$ = chr$(34) Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
        End If
        If part$ = "," Then
            If ignore = 0 Then
                element = element + 1
                If element = eleeNum Then
                    GetSpacedElement = returnVal$
                    Exit Function
                Else
                    returnVal$ = ""
                End If
            Else
                returnVal$ = returnVal$ + part$
            End If
        Else
            returnVal$ = returnVal$ + part$
        End If
    Next p
End Function

Sub delay(ByVal sec As Double)
    'delays for sec number of seconds
    On Error Resume Next
    Dim millis As Long
    millis = sec * 1000
    Call Sleep(millis)
End Sub

Sub CreateCharacter(ByVal file As String, ByVal number As Long)
    'loads a character into slot #num & initializes him
    On Error Resume Next
    If number < 0 Or number > 4 Then Exit Sub
    Call openchar(file$, playerMem(number))
    'Initialize this character:
    playerListAr$(number) = playerMem(number).charname 'Save player handle
    
    playerFile$(number) = file$
    Call setIndependentVariable(playerMem(number).experienceVar$, str$(playerMem(number).initExperience))
    Call setIndependentVariable(playerMem(number).defenseVar$, str$(playerMem(number).initDefense))
    Call setIndependentVariable(playerMem(number).fightVar$, str$(playerMem(number).initFight))
    Call setIndependentVariable(playerMem(number).healthVar$, str$(playerMem(number).initHealth))
    Call setIndependentVariable(playerMem(number).maxHealthVar$, str$(playerMem(number).initMaxHealth))
    Call setIndependentVariable(playerMem(number).nameVar$, playerMem(number).charname$)
    Call setIndependentVariable(playerMem(number).smVar$, str$(playerMem(number).initSm))
    Call setIndependentVariable(playerMem(number).smMaxVar$, str$(playerMem(number).initSmMax))
    Call setIndependentVariable(playerMem(number).leVar$, str$(playerMem(number).initLevel))
    playerMem(number).nextLevel = playerMem(number).levelType
    playerMem(number).levelProgression = playerMem(number).levelType
End Sub

Function CanPlayerUse(ByVal file As String, ByVal num As Long) As Boolean
    'Checks if a player can use a specific item.
    'file is item file, num is player num
    On Error Resume Next
    Dim anItem As TKItem
    anItem = openItem(file$)
    
    Dim okAll As Long
    okAll = 0
    If anItem.usedBy = 0 Then
        okAll = 1
    Else
        Dim ll As Long
        For ll = 0 To UBound(anItem.itmChars)
            If anItem.itmChars$(ll) <> "" Then
                If UCase$(anItem.itmChars$(ll)) = UCase$(playerListAr$(num)) Then
                    okAll = 1
                End If
            End If
        Next ll
    End If
    If okAll = 1 Then
        CanPlayerUse = True
    Else
        CanPlayerUse = False
    End If
End Function

Sub removeEquip(ByVal equipNum As Long, ByVal playerNum As Long)
    'Removes equipment at position equipnum
    'from player playernum.
    'Restores HP/DP/SMP/FP to what it was before the equipment was there.
    On Error Resume Next
    
    Dim anItem As TKItem
    
    If playerEquip$(equipNum, playerNum) = "" Then Exit Sub
    
    anItem = openItem(projectPath$ + itmPath$ + playerEquip$(equipNum, playerNum))
    If anItem.prgRemove$ <> "" Then
        Call runProgram(projectPath$ + prgPath$ + anItem.prgRemove$)
    End If
    
    'Put the equipment back in the item list:
    Call AddItemToList(playerEquip$(equipNum, playerNum), inv)
    playerEquip$(equipNum, playerNum) = ""
    equipList$(equipNum, playerNum) = "" 'What is equipped on each player (handle)
    
    'Now to set HP/DP, etc back to normal:
    'HPa = equipHPadd(playernum)     'amount of HP added because of equipment.
    'SMa = equipSMadd(playernum)     'amt of smp added by equipment.
    'DPa = equipDPadd(playernum)     'amt of dp added by equipment.
    'FPa = equipFPadd(playernum)     'amt of fp added by equipment.
    Dim HPa As Long
    Dim SMa As Long
    Dim DPa As Long
    Dim FPa As Long
    Dim a As Long
    Dim lit As String
    Dim maxHP As Double
    Dim maxSM As Double
    Dim hp As Double
    Dim sm As Double
    Dim dp As Double
    Dim fp As Double
    
    HPa = anItem.equipHP     'amount of HP added because of equipment.
    SMa = anItem.equipSM     'amt of smp added by equipment.
    DPa = anItem.equipDP     'amt of dp added by equipment.
    FPa = anItem.equipFP     'amt of fp added by equipment.
    a = GetIndependentVariable(playerMem(playerNum).maxHealthVar$, lit$, maxHP)
    a = GetIndependentVariable(playerMem(playerNum).smMaxVar$, lit$, maxSM)
    a = GetIndependentVariable(playerMem(playerNum).healthVar$, lit$, hp)
    a = GetIndependentVariable(playerMem(playerNum).smVar$, lit$, sm)
    a = GetIndependentVariable(playerMem(playerNum).defenseVar$, lit$, dp)
    a = GetIndependentVariable(playerMem(playerNum).fightVar$, lit$, fp)
    
    maxHP = maxHP - HPa
    If hp > maxHP Then hp = maxHP
    maxSM = maxSM - SMa
    If sm > maxSM Then sm = maxSM
    dp = dp - DPa
    fp = fp - FPa

    Call setIndependentVariable(playerMem(playerNum).defenseVar$, str$(dp))
    Call setIndependentVariable(playerMem(playerNum).fightVar$, str$(fp))
    Call setIndependentVariable(playerMem(playerNum).healthVar$, str$(hp))
    Call setIndependentVariable(playerMem(playerNum).maxHealthVar$, str$(maxHP))
    Call setIndependentVariable(playerMem(playerNum).smVar$, str$(sm))
    Call setIndependentVariable(playerMem(playerNum).smMaxVar$, str$(maxSM))
End Sub

Public Sub addEquip(ByVal equipNum As Long, ByVal playerNum As Long, ByVal file As String)
    'Add equipment to equipnum on playernum
    On Error Resume Next
    
    Dim aFile As String
    Dim anItem As TKItem
    
    aFile = projectPath & itmPath & file
    anItem = openItem(aFile)

    Call RemoveItemfromList(file$, inv)
    playerEquip(equipNum, playerNum) = file
    equipList(equipNum, playerNum) = anItem.itemName

    'Modify HP,DP,etc
    equipHPadd(playerNum) = anItem.equipHP     'amount of HP added because of equipment.
    equipSMadd(playerNum) = anItem.equipSM     'amt of smp added by equipment.
    equipDPadd(playerNum) = anItem.equipDP     'amt of dp added by equipment.
    equipFPadd(playerNum) = anItem.equipFP     'amt of fp added by equipment.

    Dim a As Long
    Dim lit As String
    Dim maxHP As Double
    Dim maxSM As Double
    Dim hp As Double
    Dim sm As Double
    Dim dp As Double
    Dim fp As Double

    Call GetIndependentVariable(playerMem(playerNum).defenseVar, lit, dp)
    Call GetIndependentVariable(playerMem(playerNum).fightVar, lit, fp)
    Call GetIndependentVariable(playerMem(playerNum).maxHealthVar, lit, maxHP)
    Call GetIndependentVariable(playerMem(playerNum).smMaxVar, lit, maxSM)

    dp = dp + anItem.equipDP
    fp = fp + anItem.equipFP
    maxHP = maxHP + anItem.equipHP
    maxSM = maxSM + anItem.equipSM

    Call setIndependentVariable(playerMem(playerNum).defenseVar, CStr(dp))
    Call setIndependentVariable(playerMem(playerNum).fightVar, CStr(fp))
    Call setIndependentVariable(playerMem(playerNum).maxHealthVar, CStr(maxHP))
    Call setIndependentVariable(playerMem(playerNum).smMaxVar, CStr(maxSM))

    'Run equip program:
    targetType = TYPE_PLAYER
    target = playerNum
    If anItem.prgEquip <> "" Then
        Call runProgram(projectPath & prgPath & anItem.prgEquip)
    End If

End Sub
