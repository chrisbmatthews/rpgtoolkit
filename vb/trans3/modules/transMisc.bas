Attribute VB_Name = "transMisc"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Misc trans supporting functions
' Status: B+
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Public target As Long             'targeted player number
Public targetType As TARGET_TYPE  'targetted type
Public Source As Long             'source player number
Public sourceType As TARGET_TYPE  'source type

Public Enum TARGET_TYPE           'targetted type
    TYPE_PLAYER = 0               '  player
    TYPE_ITEM = 1                 '  item
    TYPE_ENEMY = 2                '  enemy
End Enum

'=========================================================================
' Determine a player's special moves
'=========================================================================
Public Function determineSpecialMoves(ByVal handle As String, ByRef fileList() As String) As Long
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
            a = getIndependentVariable(playerMem(cnum).experienceVar$, l$, expl)
            If expl >= playerMem(cnum).spcMinExp(t) Then
                theMove = theMove + 1
                ignore = 1
                fileList$(cnt) = playerMem(cnum).smlist$(t)
                cnt = cnt + 1
            End If
            
            Dim lev As Double, txt As String, nn As Double
            If ignore <> 1 Then
                'now check level
                a = getIndependentVariable(playerMem(cnum).leVar$, l$, lev)
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
                    a = getIndependentVariable(playerMem(cnum).spcVar$(t), txt$, nn)
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

'=========================================================================
' Returns if a number is within low and high
'=========================================================================
Public Function within(ByVal num As Double, ByVal low As Double, ByVal high As Double) As Long
    On Error Resume Next
    If num <= high And num >= low Then within = 1: Exit Function
    within = 0
End Function

'=========================================================================
' Centers the board on playerX, playerY
'=========================================================================
Public Sub alignBoard(ByVal playerX As Double, ByVal playerY As Double)
    
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

'=========================================================================
' Opens all the items on the board
'=========================================================================
Public Sub openItems()

    On Error Resume Next

    Dim runIt As Boolean                'run item activation program?
    Dim itemNum As Long                 'item loop control variables
    Dim lit As String                   'literal variable
    Dim num As Double                   'numerical variables
    Dim checkIt As RPGC_DT              'data type of conditional variable
    Dim valueTestNum As Double          'numerical test value
    Dim valueTestLit As String          'literal test value

    ReDim pendingItemMovement(maxItem)  'pending item movements
    ReDim lastItemRender(maxItem)       'last item renders
    ReDim itmPos(maxItem)               'position of items
    ReDim itemMem(maxItem)              'item data
    ReDim cnvSprites(maxItem)           'item sprites

    'Destroy old item canvases
    For itemNum = 0 To maxItem
        Call DestroyCanvas(cnvSprites(itemNum))
    Next itemNum
    'Create new item canvases
    For itemNum = 0 To maxItem
        cnvSprites(itemNum) = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Next itemNum

    'Loop over each item
    For itemNum = 0 To maxItem

        'With the active board
        With boardList(activeBoardIndex).theData

            'Copy item values to itmPos() array
            itmPos(itemNum).frame = 0
            itmPos(itemNum).x = .itmX(itemNum)
            itmPos(itemNum).y = .itmY(itemNum)
            itmPos(itemNum).l = .itmLayer(itemNum)
            itmPos(itemNum).stance = "REST"

            'Indicate that there was no last render
            lastItemRender(itemNum).canvas = -1

            'Copy values to pending item movements
            With pendingItemMovement(itemNum)
                .xOrig = itmPos(itemNum).x
                .xTarg = itmPos(itemNum).x
                .yOrig = itmPos(itemNum).y
                .yTarg = itmPos(itemNum).y
            End With

            'Check if we should run this item
            If boardList(activeBoardIndex).theData.itmActivate(itemNum) = 1 Then
                runIt = False
                checkIt = getIndependentVariable(.itmVarActivate(itemNum), lit, num)
                If checkIt = DT_NUM Then
                    valueTestNum = num
                    If valueTestNum = .itmActivateInitNum(itemNum) Then
                        runIt = True
                    End If
                ElseIf checkIt = DT_LIT Then
                    valueTestLit = lit
                    If valueTestLit = .itmActivateInitNum(itemNum) Then
                        runIt = True
                    End If
                End If
            Else
                runIt = True
            End If

            'If we should and there is a program then open it!
            If (runIt) And (.itmName(itemNum) <> "") Then
                itemMem(itemNum) = openItem(projectPath & itmPath & .itmName(itemNum))
                itemMem(itemNum).bIsActive = True
                If boardList(activeBoardIndex).theData.itemMulti(itemNum) <> "" Then
                    multiList(itemNum) = .itemMulti(itemNum)
                Else
                    multiList(itemNum) = itemMem(itemNum).itmPrgOnBoard
                End If
            Else
                itemMem(itemNum).bIsActive = False
                multiList(itemNum) = ""
            End If

        End With

    Next itemNum

End Sub

'=========================================================================
' Gets a spaced element ignoring quotes
'=========================================================================
Public Function GetSpacedElement(ByVal Text As String, ByVal eleeNum As Long) As String

    On Error Resume Next

    Dim Length As Long, element As Long, p As Long, part As String, ignore As Long
    Dim returnVal As String
    
    Length = Len(Text$)
    element = 0
    For p = 1 To Length + 1
        part$ = Mid$(Text$, p, 1)
        If part$ = Chr$(34) Then
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

'=========================================================================
' Delay for the number of seconds passed in
'=========================================================================
Public Sub delay(ByVal sec As Double)
    On Error Resume Next
    Dim millis As Long
    millis = sec * 1000
    Call Sleep(millis)
End Sub

'=========================================================================
' Load a character into the slot passed in
'=========================================================================
Public Sub CreateCharacter(ByVal file As String, ByVal number As Long)
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

'=========================================================================
' Dertermines if a player is able to use an item
'=========================================================================
Public Function CanPlayerUse(ByVal file As String, ByVal num As Long) As Boolean

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

'=========================================================================
' Remove an equippable item
'=========================================================================
Public Sub removeEquip(ByVal equipNum As Long, ByVal playerNum As Long)

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
    a = getIndependentVariable(playerMem(playerNum).maxHealthVar$, lit$, maxHP)
    a = getIndependentVariable(playerMem(playerNum).smMaxVar$, lit$, maxSM)
    a = getIndependentVariable(playerMem(playerNum).healthVar$, lit$, hp)
    a = getIndependentVariable(playerMem(playerNum).smVar$, lit$, sm)
    a = getIndependentVariable(playerMem(playerNum).defenseVar$, lit$, dp)
    a = getIndependentVariable(playerMem(playerNum).fightVar$, lit$, fp)
    
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

'=========================================================================
' Equip an item to a player
'=========================================================================
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

    Call getIndependentVariable(playerMem(playerNum).defenseVar, lit, dp)
    Call getIndependentVariable(playerMem(playerNum).fightVar, lit, fp)
    Call getIndependentVariable(playerMem(playerNum).maxHealthVar, lit, maxHP)
    Call getIndependentVariable(playerMem(playerNum).smMaxVar, lit, maxSM)

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

'=========================================================================
' Set the game speed (0 - 4)
'=========================================================================
Public Sub gameSpeed(ByVal speed As Integer)
    Select Case speed
        Case 0: walkDelay = 0.09
        Case 1: walkDelay = 0.06
        Case 2: walkDelay = 0.03
        Case 3: walkDelay = 0.01
        Case 4: walkDelay = 0.005
    End Select
End Sub

'=========================================================================
' Returns radians from degrees
'=========================================================================
Public Function radians(ByVal degrees As Double) As Double
    On Error Resume Next
    Const PI = 3.14159265358979
    radians = degrees / 180 * PI
End Function
