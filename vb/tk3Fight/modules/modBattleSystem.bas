Attribute VB_Name = "modBattleSystem"
'====================================================================================
'RPGToolkit3 Default Battle System
'====================================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'====================================================================================
'YOU MAY NOT REMOVE THIS NOTICE!
'====================================================================================

Option Explicit

'====================================================================================
'Variable Declarations
'====================================================================================

Private inMainMenu As Boolean

Private Type Fighter
    handle As String
    idx As Long
    animations(4) As String
    restCurrentFrame As Double
    restMaxFrame As Long
    x As Double
    y As Double
    width As Double
    height As Double
    isPlayer As Boolean
End Type

Private Type SpcMove
    filename As String
    handle As String
    mp As Long
End Type

'Parties
Private Players() As Fighter
Private Enemies() As Fighter

Private Type Charged
    playerCharged(4) As Long
End Type

'Queues
Private chargeQueue As Charged
Private enemyQueue As Charged

'Resolution
Public resX As Long
Public resY As Long

'Canvases
Private cnvParty As Long
Private cnvBackground As Long

Private ENEMY_FRAMES_TO_DELAY() As Double
Private PLAYER_FRAMES_TO_DELAY() As Double

Private ranAway As Boolean
Private canRunAway As Boolean

Private noNewDeaths As Boolean

Private menuGraphic As String

Public Function Fight( _
                         ByVal enemyCount As Long, _
                         ByVal skillLevel As Long, _
                         ByVal backgroundFile As String, _
                         ByVal canrun As Long _
                                                ) As Long

    '====================================================================================
    'Fight entry point
    '====================================================================================

    ranAway = False
    If canrun = 1 Then
        canRunAway = True
    Else
        canRunAway = False
    End If

    noNewDeaths = False

    'Setup enemies
    ReDim Enemies(enemyCount - 1)
    ReDim ENEMY_FRAMES_TO_DELAY(enemyCount - 1)
    Call loadEnemySprites
    Call positionEnemies

    'Walking speed
    Dim a As Long
    For a = 0 To UBound(Enemies)
        ENEMY_FRAMES_TO_DELAY(a) = 1
    Next a
    ReDim PLAYER_FRAMES_TO_DELAY(CBGetPartySize(PLAYER_PARTY))
    For a = 0 To CBGetPartySize(PLAYER_PARTY)
        PLAYER_FRAMES_TO_DELAY(a) = 1
    Next a

    'Setup players
    ReDim Players(CBGetPartySize(PLAYER_PARTY) - 1)
    Call loadPlayerSprites
    Call positionPlayers

    'Any dead players?
    For a = 0 To UBound(Players)
        If CBGetFighterHP(PLAYER_PARTY, a) <= 0 Then
            chargeQueue.playerCharged(a) = -3
        End If
    Next a

    'Load bkg image
    cnvBackground = CBCreateCanvas(resX, resY - 100)
    Call CBCanvasFill(cnvBackground, 0)
    Call CBCanvasDrawBackground(cnvBackground, backgroundFile, 0, 0, resX, resY - 100)

    'Load the bottom bar thingy
    cnvParty = CBCreateCanvas(resX, 100)
    menuGraphic = CBGetGeneralString(GEN_FIGHTMENUGRAPHIC, 0, 0)
    Call CBCanvasLoadSizedImage(cnvParty, menuGraphic)

    'Run the fight
    Fight = mainLoop()

    'Clean up
    Call CBDestroyCanvas(cnvParty)
    Call CBDestroyCanvas(cnvBackground)

End Function

Private Function mainLoop() As Long

    '====================================================================================
    'Main fight execution loop
    '====================================================================================

    Do

        'See if the fight is over
        If fightHasEnded(mainLoop) Then
            'The fight has ended!
            Exit Do
        End If

        'See if we ran away
        If (ranAway) Then
            mainLoop = FIGHT_RUN_AUTO
            Exit Do
        End If

        'Draw a frame
        Call renderScene

        'Check if anyone has been revived
        Call checkRevivals

        'Increment speed bars
        Call CBFightTick

        'Don't let us lock up
        Call CBDoEvents

    Loop

    'Render the final scene
    Call renderScene

End Function

Private Sub checkRevivals()

    '====================================================================================
    'Check if anyone has been revived
    '====================================================================================

    Dim a As Long

    'Players
    For a = 0 To UBound(Players)
        If chargeQueue.playerCharged(a) = -3 Then
            If CBGetFighterHP(PLAYER_PARTY, a) > 0 Then
                chargeQueue.playerCharged(a) = 0
            End If
        End If
    Next a

    'Enemies
    For a = 0 To UBound(Enemies)
        If enemyQueue.playerCharged(a) = -3 Then
            If CBGetFighterHP(ENEMY_PARTY, a) > 0 Then
                enemyQueue.playerCharged(a) = 0
            End If
        End If
    Next a

End Sub

Private Function fightHasEnded(ByRef endType As Long) As Boolean

    '====================================================================================
    'Check if a party is dead
    '====================================================================================

    Dim a As Long
    Dim enemyWin As Boolean
    Dim playerWin As Boolean
    
    enemyWin = True
    playerWin = True
    
    For a = 0 To UBound(Enemies)
        If CBGetFighterHP(ENEMY_PARTY, a) > 0 Then
            playerWin = False
            Exit For
        End If
    Next a
    
    For a = 0 To UBound(Players)
        If CBGetFighterHP(PLAYER_PARTY, a) > 0 Then
            enemyWin = False
            Exit For
        End If
    Next a
    
    If enemyWin Then

        fightHasEnded = True
        endType = FIGHT_LOST
    
    ElseIf playerWin Then

        fightHasEnded = True
        endType = FIGHT_WON_AUTO

    End If

End Function

Private Sub positionPlayers()

    '====================================================================================
    'Calculate where to place players
    '====================================================================================

    On Error Resume Next

    Dim total As Double
    Dim divy As Double
    Dim a As Long

    For a = 0 To UBound(Players)
        total = total + Players(a).height
    Next a

    divy = ((resY - 100) - total) / (UBound(Players) + 2)
    
    Dim curPos As Long
    For a = 0 To UBound(Players)
        curPos = curPos + divy
        Players(a).y = curPos
        Players(a).x = resX - 110
        curPos = curPos + Players(a).height
    Next a

End Sub

Private Sub loadPlayerSprites()

    '====================================================================================
    'Load the player sprites
    '====================================================================================

    'For each player
    Dim a As Long
    For a = 0 To UBound(Players)
    
        Dim b As Long
        'For each animation
        For b = 0 To 4

            Dim theAnim As String
      
            Select Case b
                Case 0
                    theAnim = CBGetFighterAnimation(PLAYER_PARTY, a, "REST")
                Case 1
                    theAnim = CBGetFighterAnimation(PLAYER_PARTY, a, "ATTACK")
                Case 2
                    theAnim = CBGetFighterAnimation(PLAYER_PARTY, a, "DEFEND")
                Case 3
                    theAnim = CBGetFighterAnimation(PLAYER_PARTY, a, "SPECIAL MOVE")
                Case 4
                    theAnim = CBGetFighterAnimation(PLAYER_PARTY, a, "DIE")
            End Select

            If theAnim <> "" Then

                Dim anim As Long
                anim = CBCreateAnimation(theAnim)
                If b = 0 Then
                    Players(a).width = CBAnimationSizeX(anim)
                    Players(a).height = CBAnimationSizeY(anim)
                End If
                Players(a).animations(b) = theAnim

            End If
        
        Next b

        Players(a).handle = CBGetPlayerString(PLAYER_NAME, 0, a)
        Players(a).restMaxFrame = CBAnimationMaxFrames(anim)
        Players(a).isPlayer = True
        Players(a).idx = a
        Call CBDestroyAnimation(anim)

    Next a

End Sub

Private Sub loadEnemySprites()

    '====================================================================================
    'Load the enemy sprites
    '====================================================================================

    'For each enemy
    Dim a As Long
    For a = 0 To UBound(Enemies)
    
        Dim b As Long
        'For each animation
        For b = 0 To 4

            Dim theAnim As String
      
            Select Case b
                Case 0
                    theAnim = CBGetFighterAnimation(ENEMY_PARTY, a, "REST")
                Case 1
                    theAnim = CBGetFighterAnimation(ENEMY_PARTY, a, "ATTACK")
                Case 2
                    theAnim = CBGetFighterAnimation(ENEMY_PARTY, a, "DEFEND")
                Case 3
                    theAnim = CBGetFighterAnimation(ENEMY_PARTY, a, "SPECIAL MOVE")
                Case 4
                    theAnim = CBGetFighterAnimation(ENEMY_PARTY, a, "DIE")
            End Select

            If theAnim <> "" Then

                Dim anim As Long
                Enemies(a).animations(b) = theAnim
                anim = CBCreateAnimation(theAnim)
                If b = 0 Then
                    Enemies(a).width = CBAnimationSizeX(anim)
                    Enemies(a).height = CBAnimationSizeY(anim)
                End If

            End If
        
        Next b

        Enemies(a).handle = CBGetEnemyString(ENE_NAME, a)
        Enemies(a).restMaxFrame = CBAnimationMaxFrames(anim)
        Enemies(a).idx = a
        Call CBDestroyAnimation(anim)
    
    Next a

End Sub

Private Sub positionEnemies()

    '====================================================================================
    'Calculate where to position the enemies
    '====================================================================================

    On Error Resume Next

    Dim a As Long
    For a = 0 To UBound(Enemies)
        Select Case a
            Case 0
                Enemies(a).x = 30
                Enemies(a).y = 30
            Case 1
                Enemies(a).x = 30 + (Enemies(a - 1).width + 30)
                Enemies(a).y = 30
            Case 2
                Enemies(a).x = 30
                Enemies(a).y = 30 + (Enemies(a - 2).height + 30)
            Case 3
                Enemies(a).x = 30 + (Enemies(a - 1).width + 30)
                Enemies(a).y = 30 + (Enemies(a - 3).height + 30)
        End Select
    Next a

End Sub

Private Sub renderScene(Optional ByVal pRefreshStats As Long = 0)

    '====================================================================================
    'Renders a frame
    '====================================================================================

    Dim cnvScene As Long
    Dim cnvFieldState As Long
    Dim cnvPartyStats As Long
    Dim refreshStats As Boolean

    If (pRefreshStats = 0) And (Not noNewDeaths) Then
        refreshStats = True
    ElseIf pRefreshStats = 1 Then
        refreshStats = False
    End If

    cnvScene = CBCreateCanvas(resX, resY)
    cnvPartyStats = CBCreateCanvas(resX, 100)
    cnvFieldState = CBCreateCanvas(resX, resY - 100)

    Call CBCanvas2CanvasBlt(cnvBackground, cnvScene, 0, 0)
    Call renderState(cnvFieldState)
    Call CBCanvas2CanvasBltTransparent(cnvFieldState, cnvScene, 0, 0, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))

    If refreshStats Then
        Call renderParty(cnvPartyStats)
    Else
        Dim cnvTemp As Long
        cnvTemp = CBCreateCanvas(resX, resY)
        Call CBCanvasGetScreen(cnvTemp)
        Call CBCanvas2CanvasBltPartial( _
                                          cnvTemp, _
                                          cnvPartyStats, _
                                          0, 0, 0, _
                                          resY - 100, resX, resY - 100)
        Call CBDestroyCanvas(cnvTemp)
    End If
    Call CBCanvas2CanvasBlt(cnvPartyStats, cnvScene, 0, resY - 100)

    Call CBDrawCanvas(cnvScene, 0, 0)
    Call CBRefreshScreen

    'Any players dead?
    Dim a As Long
    For a = 0 To UBound(Players)
        If chargeQueue.playerCharged(a) = -2 Then
            chargeQueue.playerCharged(a) = -3
            Call playAnimation(Players(a), 4)
        End If
    Next a
    'Enemies?
    For a = 0 To UBound(Enemies)
        If enemyQueue.playerCharged(a) = -2 Then
            enemyQueue.playerCharged(a) = -3
            Call playAnimation(Enemies(a), 4)
        End If
    Next a

    Call CBDestroyCanvas(cnvScene)
    Call CBDestroyCanvas(cnvFieldState)
    Call CBDestroyCanvas(cnvPartyStats)

End Sub

Private Sub renderParty(ByVal cnv As Long)

    '====================================================================================
    'Renders the party stats to the canvas passed in
    '====================================================================================

    On Error Resume Next

    Const PLAYER_WIDTH As Single = 132
    Const FONT_SIZE As Single = 17

    'Draw background
    Call CBCanvas2CanvasBlt(cnvParty, cnv, 0, 0)
    
    Dim members As Long
    members = UBound(Players) + 1
    
    Dim pixelsUsed As Long
    pixelsUsed = members * PLAYER_WIDTH
    
    Dim pixelsNotUsed As Long
    pixelsNotUsed = resX - pixelsUsed
    
    Dim divy As Double
    divy = pixelsNotUsed / (members + 1)

    Dim a As Long
    Dim curX As Long
    For a = 0 To UBound(Players)
        If (members <> 5) Or (a <> 0) Then curX = curX + divy _
        Else: curX = 3
        Call drawImageTransparent( _
                                     cnv, _
                                     CBGetPlayerString(PLAYER_PROFILE, 0, a), _
                                     curX, 12.5, 75, 75, 0, 0, 0, 0)
        Call CBCanvasDrawText( _
                                 cnv, _
                                 CBGetPlayerString(PLAYER_NAME, 0, a), _
                                 "Comic Sans MS", _
                                 23, _
                                 (curX + 75 + 2) / 23 + 1, (9) / 23 + 1, _
                                 RGB(255, 255, 255), _
                                 0, 0, 0, 0)
        Call CBCanvasDrawText( _
                                 cnv, _
                                 CStr(CBGetFighterHP(PLAYER_PARTY, a) & " / " & CBGetFighterMaxHP(PLAYER_PARTY, a) & " HP"), _
                                 "Comic Sans MS", _
                                 FONT_SIZE, _
                                 (curX + 75 + 2) / FONT_SIZE + 1, (11) / FONT_SIZE + 2, _
                                 RGB(255, 255, 255), _
                                 0, 0, 0, 0)
        Call CBCanvasDrawText( _
                                 cnv, _
                                 CStr(CBGetFighterSMP(PLAYER_PARTY, a) & " / " & CBGetFighterMaxSMP(PLAYER_PARTY, a) & " SMP"), _
                                 "Comic Sans MS", _
                                 FONT_SIZE, _
                                 (curX + 75 + 2) / FONT_SIZE + 1, (11) / FONT_SIZE + 3, _
                                 RGB(255, 255, 255), _
                                 0, 0, 0, 0)
        Call CBCanvasDrawRect( _
                                 cnv, _
                                 curX + 75 + 2, 11 * 4 + FONT_SIZE + 7, _
                                 curX + 75 + 2 + 63, 11 * 4 + FONT_SIZE + 15 + 7, _
                                 RGB(255, 255, 255))
        Dim width As Long
        Dim charge As Long
        charge = CBGetFighterChargePercent(PLAYER_PARTY, a)
        width = charge * 63 / 100
        If CBGetFighterHP(PLAYER_PARTY, a) <= 0 Then
            Call CBCanvasFillRect( _
                                     cnv, _
                                     curX + 75 + 2, 11 * 4 + FONT_SIZE + 7, _
                                     curX + 75 + 2 + width, 11 * 4 + FONT_SIZE + 15 + 7, _
                                     RGB(192, 192, 192))
        ElseIf charge <= 100 Then
            Call CBCanvasFillRect( _
                                     cnv, _
                                     curX + 75 + 2, 11 * 4 + FONT_SIZE + 7, _
                                     curX + 75 + 2 + width, 11 * 4 + FONT_SIZE + 15 + 7, _
                                     RGB(255, 255, 255))
        Else
            Call CBCanvasFillRect( _
                                     cnv, _
                                     curX + 75 + 2, 11 * 4 + FONT_SIZE + 7, _
                                     curX + 75 + 2 + width, 11 * 4 + FONT_SIZE + 15 + 7, _
                                     RGB(255, 0, 0))
        End If
        curX = curX + PLAYER_WIDTH
    Next a

End Sub

Private Sub renderPlayers(ByVal retCnv As Long, Optional ByVal a As Long = -1)

    '====================================================================================
    'Render player sprites on the canvas passed in
    '====================================================================================

    If a = -1 Then
        Dim cnv() As Long
        Dim b As Long
        For b = 0 To UBound(Players)
            ReDim Preserve cnv(b)
            cnv(b) = CBCreateCanvas(resX, resY - 100)
            Call renderPlayers(cnv(b), b)
            Call CBCanvas2CanvasBltTransparent(cnv(b), retCnv, 0, 0, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))
            Call CBDestroyCanvas(cnv(b))
        Next b
        Exit Sub
    End If

    Call CBCanvasFill(retCnv, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))

    If chargeQueue.playerCharged(a) = -5 Then
        'Don't draw this player
        Exit Sub
    End If

    Dim theAnim As Long
    Dim theFile As String
    If (CBGetFighterHP(PLAYER_PARTY, a) > 0) Or (noNewDeaths And chargeQueue.playerCharged(a) <> -3) Then
        theFile = Players(a).animations(0)
        If theFile <> "" Then
            theAnim = CBCreateAnimation(theFile)

            Call CBCanvasDrawAnimationFrame( _
                                               retCnv, _
                                               theAnim, _
                                               Round(Players(a).restCurrentFrame), _
                                               Players(a).x, _
                                               Players(a).y, _
                                               1)

            Players(a).restCurrentFrame = Players(a).restCurrentFrame + PLAYER_FRAMES_TO_DELAY(a)
            If Players(a).restCurrentFrame > Players(a).restMaxFrame Then
                Players(a).restCurrentFrame = 0
            End If
        End If
    ElseIf chargeQueue.playerCharged(a) = -3 Then
        'Long since dead...
        theFile = Players(a).animations(4)
        If theFile <> "" Then
            theAnim = CBCreateAnimation(theFile)
            Call CBCanvasDrawAnimationFrame( _
                                               retCnv, _
                                               theAnim, _
                                               CBAnimationMaxFrames(theAnim), _
                                               Players(a).x, _
                                               Players(a).y, _
                                               1)
        End If
    Else
        'We've got a dead one!
        chargeQueue.playerCharged(a) = -2
    End If

    Call CBDestroyAnimation(theAnim)

End Sub

Private Sub renderEnemies(ByVal retCnv As Long, Optional ByVal a As Long = -1)

    '====================================================================================
    'Render enemy sprites to the canvas passed in
    '====================================================================================

    If a = -1 Then
        Dim cnv() As Long
        Dim b As Long
        For b = 0 To UBound(Enemies)
            ReDim Preserve cnv(b)
            cnv(b) = CBCreateCanvas(resX, resY - 100)
            Call renderEnemies(cnv(b), b)
            Call CBCanvas2CanvasBltTransparent(cnv(b), retCnv, 0, 0, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))
            Call CBDestroyCanvas(cnv(b))
        Next b
        Exit Sub
    End If

    Call CBCanvasFill(retCnv, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))

    If enemyQueue.playerCharged(a) = -5 Then
        'Don't draw this enemy
        Exit Sub
    End If

    Dim theAnim As Long
    Dim theFile As String
    If (CBGetFighterHP(ENEMY_PARTY, a) > 0) Or (noNewDeaths And enemyQueue.playerCharged(a) <> -3) Then
        theFile = Enemies(a).animations(0)
        If theFile <> "" Then
            theAnim = CBCreateAnimation(theFile)
    
            Call CBCanvasDrawAnimationFrame( _
                                               retCnv, _
                                               theAnim, _
                                               Round(Enemies(a).restCurrentFrame), _
                                               Enemies(a).x, _
                                               Enemies(a).y, _
                                               1)

            Call CBDestroyAnimation(theAnim)

            Enemies(a).restCurrentFrame = Enemies(a).restCurrentFrame + ENEMY_FRAMES_TO_DELAY(a)
            If Enemies(a).restCurrentFrame > Enemies(a).restMaxFrame Then
                Enemies(a).restCurrentFrame = 0
            End If
        End If
    ElseIf enemyQueue.playerCharged(a) = -3 Then
        theFile = Enemies(a).animations(4)
        If theFile <> "" Then
            theAnim = CBCreateAnimation(theFile)
            Call CBCanvasDrawAnimationFrame( _
                                               retCnv, _
                                               theAnim, _
                                               CBAnimationMaxFrames(theAnim), _
                                               Enemies(a).x, _
                                               Enemies(a).y, _
                                               1)
            Call CBDestroyAnimation(theAnim)
        End If
    Else
        'Flag that this enemy is dead
        enemyQueue.playerCharged(a) = -2
    End If

End Sub

Private Sub renderState(ByVal cnv As Long)

    '====================================================================================
    'Renders the fighting 'field' to the canvas passed in
    '====================================================================================

    Dim retCnv As Long
    retCnv = CBCreateCanvas(resX, resY - 100)

    Call CBCanvasFill(retCnv, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))

    'Render players and enemies
    Call renderPlayers(retCnv)
    Call renderEnemies(retCnv)

    'Canvas2CanvasBlt
    Call CBCanvas2CanvasBlt(retCnv, cnv, 0, 0)

    'Cleanup
    Call CBDestroyCanvas(retCnv)

End Sub

Public Function fightInform( _
                               ByVal sourcePartyIndex As Long, _
                               ByVal sourceFighterIndex As Long, _
                               ByVal targetPartyIndex As Long, _
                               ByVal targetFighterIndex As Long, _
                               ByVal sourceHPLost As Long, _
                               ByVal sourceSMPLost As Long, _
                               ByVal targetHPLost As Long, _
                               ByVal targetSMPLost As Long, _
                               ByVal strMessage As String, _
                               ByVal attackCode As Long _
                                                          ) As Long

    '====================================================================================
    'Handles fight events
    '====================================================================================

    On Error Resume Next

    If ranAway Then Exit Function

    Dim oldCnv As Long

    Dim source As Fighter
    Dim target As Fighter
    If sourcePartyIndex <> -1 Then
        If sourcePartyIndex = PLAYER_PARTY Then
            source = Players(sourceFighterIndex)
        Else
            source = Enemies(sourceFighterIndex)
        End If
    End If
    If targetPartyIndex <> -1 Then
        If targetPartyIndex = PLAYER_PARTY Then
            target = Players(targetFighterIndex)
        Else
            target = Enemies(targetFighterIndex)
        End If
    End If

    Select Case attackCode

        Case INFORM_REMOVE_HP, INFORM_REMOVE_SMP
            noNewDeaths = True
            If targetHPLost > 0 Or targetSMPLost > 0 Then
                Call playAnimation(target, 2)  'defend ani
            End If
            Call showDamage(targetHPLost, targetSMPLost, target)
            noNewDeaths = False

        Case INFORM_SOURCE_ATTACK   'FIGHT
            noNewDeaths = True
            If sourcePartyIndex <> -1 Then playAnimation source, 1 'fight ani
            Call playAnimation(target, 2)  'defend ani
            Call showDamage(targetHPLost, targetSMPLost, target)
            noNewDeaths = False

        Case INFORM_SOURCE_SMP      'SPECIAL MOVE
            noNewDeaths = True
            oldCnv = CBCreateCanvas(resX, resY)
            Call playAnimation(source, 3)  'spc move ani
            Call CBCanvasGetScreen(oldCnv)
            Call showDamage(0, sourceSMPLost, source)
            Call CBLoadSpecialMove(strMessage)     'load spc move
            Call playAnimation(target, , CBGetSpecialMoveString(SPC_ANIMATION), True)   'move ani
            Call CBRunProgram(CBGetSpecialMoveString(SPC_PRG_FILE))    'rpgcode prg
            'Apply status effect
            If CBGetSpecialMoveString(SPC_STATUSFX) <> "" Then
                Call CBFighterAddStatusEffect( _
                                                 targetPartyIndex, _
                                                 targetFighterIndex, _
                                                 CBGetSpecialMoveString(SPC_STATUSFX))
            End If
            If targetHPLost <> 0 Or targetSMPLost <> 0 Then
                If targetHPLost > 0 Or targetSMPLost > 0 Then
                    Call playAnimation(target, 2)  'defend ani
                End If
                Call CBDrawCanvas(oldCnv, 0, 0)
                Call CBDestroyCanvas(oldCnv)
                Call CBRefreshScreen
                Call showDamage(targetHPLost, targetSMPLost, target)
            End If
            noNewDeaths = False
            Call renderScene

        Case INFORM_SOURCE_ITEM     'USING ITEM
            noNewDeaths = True
            oldCnv = CBCreateCanvas(resX, resY)
            Call playAnimation(source, 3)  'spc move ani
            Call CBCanvasGetScreen(oldCnv)
            Call CBLoadItem(strMessage, -1)    'load the itm
            Call playAnimation(target, , CBGetItemString(ITM_ANIMATION, 0, -1), True)   'itm ani
            Call CBDrawCanvas(oldCnv, 0, 0)
            Call CBRefreshScreen
            Call CBDestroyCanvas(oldCnv)
            Call CBRunProgram(CBGetItemString(ITM_FIGHT_PRG, 0, -1))   'rpgcode prg
            Call showDamage(targetHPLost, targetSMPLost, target)
            noNewDeaths = False
            Call renderScene

        Case INFORM_SOURCE_CHARGED  'PLAYER TURN
            If Not inMainMenu Then
                If sourcePartyIndex = PLAYER_PARTY Then
                    Call mainMenuScanKeys(source)
                    Call CBReleaseFighterCharge(PLAYER_PARTY, sourceFighterIndex)
                End If
            End If

    End Select

    Call renderScene

End Function

Private Sub playAnimation( _
                             ByRef target As Fighter, _
                             Optional ByVal num As Long, _
                             Optional ByVal file As String, _
                             Optional ByVal transparent As Boolean _
                                                                     )

    '====================================================================================
    'Plays a player animation
    '====================================================================================

    Dim cnvSave As Long
    Dim cnvFrame As Long
    Dim cnvScene As Long
    cnvSave = CBCreateCanvas(resX, resY)
    cnvFrame = CBCreateCanvas(resX, resY)
    cnvScene = CBCreateCanvas(resX, resY)

    Call CBCanvasFill(cnvFrame, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))
    Call CBCanvasFill(cnvScene, CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))

    Dim oldQueue As Long

    If Not transparent Then
        If target.isPlayer Then
            oldQueue = chargeQueue.playerCharged(target.idx)
            chargeQueue.playerCharged(target.idx) = -5
        Else
            oldQueue = enemyQueue.playerCharged(target.idx)
            enemyQueue.playerCharged(target.idx) = -5
        End If
    End If

    If noNewDeaths Then
        Call renderScene(0)
    Else
        Call renderScene(1)
    End If

    Call CBCanvasGetScreen(cnvSave)
    Call CBCanvasGetScreen(cnvScene)

    Dim theFile As String
    If file = "" Then
        theFile = target.animations(num)
    Else
        theFile = file
    End If
    If theFile <> "" Then
        Dim theAnim As Long
        theAnim = CBCreateAnimation(theFile)
        
        Dim aniX As Double, aniY As Double
        If transparent Then
            aniX = (target.x + target.width) - (target.width / 2) - (CBAnimationSizeX(theAnim) / 2)
            aniY = (target.y + target.height) - (target.height / 2) - (CBAnimationSizeY(theAnim) / 2)
        Else
            aniX = target.x
            aniY = target.y
        End If

        Dim b As Long
        For b = 0 To CBAnimationMaxFrames(theAnim)
            Call CBCanvasDrawAnimationFrame( _
                                               cnvFrame, _
                                               theAnim, b, _
                                               aniX, _
                                               aniY, _
                                               1)
            Call CBCanvas2CanvasBltTransparent( _
                                                  cnvFrame, _
                                                  cnvScene, _
                                                  0, 0, _
                                                  CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0))
            Call CBDrawCanvas(cnvScene, 0, 0)
            Call CBRefreshScreen
            Call CBCanvas2CanvasBlt(cnvSave, cnvScene, 0, 0)
            Call CBRpgCode("Delay(0.11)")
        Next b
        Call CBDestroyAnimation(theAnim)
    End If

    If Not transparent Then
        If target.isPlayer Then
            chargeQueue.playerCharged(target.idx) = oldQueue
        Else
            enemyQueue.playerCharged(target.idx) = oldQueue
        End If
    End If

    Call CBDestroyCanvas(cnvSave)
    Call CBDestroyCanvas(cnvFrame)
    Call CBDestroyCanvas(cnvScene)

    If noNewDeaths Then
        Call renderScene(0)
    Else
        Call renderScene(1)
    End If

End Sub

Private Function showDamage(ByVal hp As Long, ByVal mp As Long, ByRef target As Fighter)

    '====================================================================================
    'Shows the damage that was dealt to the fighter passed in
    '====================================================================================

    Dim cnv As Long
    Dim work As Long
    cnv = CBCreateCanvas(resX, resY)
    work = CBCreateCanvas(resX, resY)
 
    Call CBCanvasGetScreen(cnv)
    Call CBCanvasGetScreen(work)

    mp = Abs(mp)

    If mp <> 0 Then
    
        Call CBCanvasDrawText( _
                                 work, CStr(mp), _
                                 "Comic Sans MS", _
                                 25, target.x / 25 + 1, _
                                 target.y / 25 + 1, _
                                 RGB(0, 255, 255), _
                                 0, 0, 0, 0)

        Call CBDrawCanvas(work, 0, 0)
        Call CBRefreshScreen
        Call CBCanvas2CanvasBlt(cnv, work, 0, 0)
        Call CBRpgCode("Delay(1)")
        Call CBDrawCanvas(cnv, 0, 0)
    
    End If

    If hp > 0 Then

        Call CBCanvasDrawText( _
                                 work, CStr(hp), _
                                 "Comic Sans MS", _
                                 25, target.x / 25 + 1, _
                                 target.y / 25 + 1, _
                                 RGB(255, 0, 0), _
                                 0, 0, 0, 0)

        Call CBDrawCanvas(work, 0, 0)
        Call CBRefreshScreen
        Call CBCanvas2CanvasBlt(cnv, work, 0, 0)
        Call CBRpgCode("Delay(1)")
        Call CBDrawCanvas(cnv, 0, 0)

    End If
    
    If hp < 0 Then

        hp = Abs(hp)

        Call CBCanvasDrawText( _
                                 work, CStr(hp), _
                                 "Comic Sans MS", _
                                 25, target.x / 25 + 1, _
                                 target.y / 25 + 1, _
                                 RGB(0, 255, 0), _
                                 0, 0, 0, 0)

        Call CBDrawCanvas(work, 0, 0)
        Call CBRefreshScreen
        Call CBCanvas2CanvasBlt(cnv, work, 0, 0)
        Call CBRpgCode("Delay(1)")
        Call CBDrawCanvas(cnv, 0, 0)

    End If

    Call CBDestroyCanvas(cnv)
    Call CBDestroyCanvas(work)

End Function

Private Sub drawImageTransparent( _
                                    ByVal destCnv As Long, _
                                    ByVal image As String, _
                                    ByVal x As Double, _
                                    ByVal y As Double, _
                                    ByVal width As Double, _
                                    ByVal height As Double, _
                                    ByVal transR As Long, _
                                    ByVal transG As Long, _
                                    ByVal transB As Long, _
                                    Optional ByVal lngColor As Long = -1 _
                                                                           )

    '====================================================================================
    'Draws an image transparently on the canvas passed in
    '====================================================================================

    Dim cnv As Long
    cnv = CBCreateCanvas(width, height)
    Call CBCanvasLoadSizedImage(cnv, image)
    If lngColor = -1 Then
        Call CBCanvas2CanvasBltTransparent(cnv, destCnv, x, y, RGB(transR, transG, transB))
    Else
        Call CBCanvas2CanvasBltTransparent(cnv, destCnv, x, y, lngColor)
    End If
    Call CBDestroyCanvas(cnv)

End Sub

Private Sub drawImageTranslucent( _
                                   ByVal destCnv As Long, _
                                   ByVal image As String, _
                                   ByVal x As Double, _
                                   ByVal y As Double, _
                                   ByVal width As Double, _
                                   ByVal height As Double _
                                                            )

    '====================================================================================
    'Draws an image translucently on the canvas passed in
    '====================================================================================

    Dim cnv As Long
    cnv = CBCreateCanvas(width, height)
    Call CBCanvasLoadSizedImage(cnv, image)
    Call CBCanvas2CanvasBltTranslucent(cnv, destCnv, x, y, 0.5, -1, -1)
    Call CBDestroyCanvas(cnv)

End Sub

Private Sub drawImage( _
                        ByVal destCnv As Long, _
                        ByVal image As String, _
                        ByVal x As Double, _
                        ByVal y As Double, _
                        ByVal width As Double, _
                        ByVal height As Double _
                                                 )
    
    '====================================================================================
    'Draws an image on the canvas passed in
    '====================================================================================

    Dim cnv As Long
    cnv = CBCreateCanvas(width, height)
    Call CBCanvasLoadSizedImage(cnv, image)
    Call CBCanvas2CanvasBlt(cnv, destCnv, x, y)
    Call CBDestroyCanvas(cnv)

End Sub

Private Sub mainMenuScanKeys(ByRef player As Fighter)

    '====================================================================================
    'Open the main menu for the player passed in
    '====================================================================================

    On Error Resume Next

    inMainMenu = True

    Dim oldCnv As Long
    oldCnv = CBCreateCanvas(resX, resY)

    Dim cnv As Long
    cnv = CBCreateCanvas(resX, resY)

    'Flush KB buffer
    Call CBRpgCode("ClearBuffer()")

    'Backup screen
    Call CBCanvasGetScreen(oldCnv)
    Call CBCanvasGetScreen(cnv)

    Dim menuPos As Long

    Dim tarParty As Long
    Dim tarMember As Long
    Dim theMove As String

    Dim done As Boolean
    Do Until done

        Call CBCanvas2CanvasBlt(oldCnv, cnv, 0, 0)
        Call drawImageTranslucent( _
                                     cnv, _
                                     menuGraphic, _
                                     (resX / 2) - (100 / 2), _
                                     (resY / 2) - (150 / 2), _
                                     100, 150)

        Call CBCanvasDrawHand( _
                                 cnv, _
                                 (resX / 2) - (100 / 2), _
                                 (resY / 2) - (150 / 2) + 25 * (menuPos) + 10)

        Call CBCanvasDrawText( _
                                 cnv, _
                                 "Fight", "Comic Sans MS", _
                                 25, _
                                 ((resX / 2) - (100 / 2)) / 25 + 1, _
                                 ((resY / 2) - (150 / 2)) / 25 + 1, _
                                 RGB(255, 255, 255), _
                                 0, 0, 0, 0)

        If CBGetPlayerNum(PLAYER_DOES_SM, 0, player.idx) = 1 Then
            Call CBCanvasDrawText( _
                                     cnv, _
                                     CBGetPlayerString(PLAYER_SM_NAME, 0, player.idx), _
                                     "Comic Sans MS", _
                                     25, _
                                     ((resX / 2) - (100 / 2)) / 25 + 1, _
                                     ((resY / 2) - (150 / 2)) / 25 + 2, _
                                     RGB(255, 255, 255), _
                                     0, 0, 0, 0)
        End If

        Call CBCanvasDrawText( _
                                 cnv, _
                                 "Items", "Comic Sans MS", _
                                 25, _
                                 ((resX / 2) - (100 / 2)) / 25 + 1, _
                                 ((resY / 2) - (150 / 2)) / 25 + 3, _
                                 RGB(255, 255, 255), _
                                 0, 0, 0, 0)

        If canRunAway Then
            Call CBCanvasDrawText( _
                                     cnv, _
                                     "Run", "Comic Sans MS", _
                                     25, _
                                     ((resX / 2) - (100 / 2)) / 25 + 1, _
                                     ((resY / 2) - (150 / 2)) / 25 + 4, _
                                     RGB(255, 255, 255), _
                                     0, 0, 0, 0)
        Else
            Call CBCanvasDrawText( _
                                     cnv, _
                                     "Run", "Comic Sans MS", _
                                     25, _
                                     ((resX / 2) - (100 / 2)) / 25 + 1, _
                                     ((resY / 2) - (150 / 2)) / 25 + 4, _
                                     RGB(192, 192, 192), _
                                     0, 0, 0, 0)
        End If

        Call CBDrawCanvas(cnv, 0, 0)
        Call CBRefreshScreen

        If isPressed("UP") Then
            If menuPos <> 0 Then
                menuPos = menuPos - 1
                Call cursorMoveSound
            End If

        ElseIf isPressed("DOWN") Then
            If menuPos <> 3 Then
                menuPos = menuPos + 1
                Call cursorMoveSound
            End If

        ElseIf isPressed("ENTER", "SPACE") Then

            Call cursorSelSound

            Select Case menuPos

                Case 0 'Fight
                    Call characterSelect(tarParty, tarMember, ENEMY_PARTY)
                    If tarMember <> -1 Then
                        Call CBFightDoAttack( _
                                                PLAYER_PARTY, player.idx, _
                                                tarParty, tarMember, _
                                                CBGetFighterFP(PLAYER_PARTY, player.idx), 0)
                        done = True
                    Else
                        Call cursorCancelSound
                    End If

                Case 1 'Special
                    Call CBDrawCanvas(oldCnv, 0, 0)
                    Call CBRefreshScreen
                    If CBGetPlayerNum(PLAYER_DOES_SM, 0, player.idx) = 1 Then
                        If specialMoveMenuScanKeys(player) Then
                            done = True
                        End If
                    Else
                        Call cursorCancelSound
                    End If

                Case 2 'Item
                    Call CBDrawCanvas(oldCnv, 0, 0)
                    Call CBRefreshScreen
                    If itemMenuScanKeys(player) Then
                        done = True
                    Else
                        Call cursorCancelSound
                    End If

                Case 3 'Run
                    If canRunAway Then
                        Dim rand As Long
                        Call Randomize(Timer())
                        rand = Int(Rnd(1) * 5) + 1
                        If rand > 3 Then
                            Call CBRpgCode("MWin(""Ran away successfully!"")")
                            ranAway = True
                        Else
                            Call CBRpgCode("MWin(""Couldn't get away!"")")
                        End If
                        Call CBRpgCode("Delay(.5)")
                        Call CBRpgCode("MWinCls()")
                        done = True
                    Else
                        Call cursorCancelSound
                    End If

            End Select

        End If

        Call CBDoEvents

    Loop

    'Clean up
    Call CBDestroyCanvas(cnv)
    Call CBDestroyCanvas(oldCnv)
    inMainMenu = False

End Sub

Private Sub characterSelect( _
                               ByRef chosenParty As Long, _
                               ByRef chosenFighter As Long, _
                               ByVal startOnParty As Long _
                                                            )

    '====================================================================================
    'Allows user to choose a fighter using a cursor
    '====================================================================================

    Dim oldCnv As Long
    oldCnv = CBCreateCanvas(resX, resY)

    Dim cnv As Long
    cnv = CBCreateCanvas(resX, resY)

    'Flush KB buffer
    Call CBRpgCode("ClearBuffer()")

    'Backup screen
    Call CBCanvasGetScreen(oldCnv)
    Call CBCanvasGetScreen(cnv)

    chosenParty = -1
    chosenFighter = -1
    
    Dim party As Long
    Dim pos As Long
    Dim a As Long

    party = startOnParty
    For a = 0 To CBGetPartySize(party) - 1
        If CBGetFighterHP(party, a) > 0 Then
            pos = a
            Exit For
        End If
    Next a

    Dim done As Boolean
    Do Until done

        Dim target As Fighter
        If party = PLAYER_PARTY Then
            target = Players(pos)
        Else
            target = Enemies(pos)
        End If

        Dim cursorY As Double
        cursorY = target.y + 10
        If target.isPlayer Then cursorY = cursorY + 10

        Call CBCanvas2CanvasBlt(oldCnv, cnv, 0, 0)
        Call CBCanvasDrawHand( _
                                 cnv, _
                                 target.x + 10, _
                                 cursorY)

        Call CBDrawCanvas(cnv, 0, 0)
        Call CBRefreshScreen

        If isPressed("LEFT") Then
            If party = ENEMY_PARTY Then
                If (pos = 0) _
                    Or (pos = 1 And CBGetFighterHP(ENEMY_PARTY, 0) <= 0) _
                    Or (pos = 3 And CBGetFighterHP(ENEMY_PARTY, 2) <= 0) _
                    Or (pos = 2) Then
                    party = PLAYER_PARTY
                    For a = 0 To UBound(Players)
                        If CBGetFighterHP(PLAYER_PARTY, a) > 0 Then
                            pos = a
                            Exit For
                        End If
                    Next a
                ElseIf pos = 1 Then
                    If CBGetFighterHP(ENEMY_PARTY, 0) > 0 Then
                        pos = 0
                    ElseIf CBGetFighterHP(ENEMY_PARTY, 2) > 0 Then
                        pos = 2
                    End If
                ElseIf pos = 3 Then
                    If CBGetFighterHP(ENEMY_PARTY, 2) > 0 Then
                        pos = 2
                    ElseIf CBGetFighterHP(ENEMY_PARTY, 1) > 0 Then
                        pos = 1
                    ElseIf CBGetFighterHP(ENEMY_PARTY, 0) > 0 Then
                        pos = 0
                    End If
                End If
            Else
                party = ENEMY_PARTY
                For a = 0 To UBound(Enemies)
                    If CBGetFighterHP(ENEMY_PARTY, a) > 0 Then
                        pos = a
                        Exit For
                    End If
                Next a
            End If
            Call cursorMoveSound
                
        ElseIf isPressed("RIGHT") Then
            If party = ENEMY_PARTY Then
                If (pos = 1) _
                    Or (pos = 0 And CBGetFighterHP(ENEMY_PARTY, 1) <= 0) _
                    Or (pos = 2 And CBGetFighterHP(ENEMY_PARTY, 3) <= 0) _
                    Or (pos = 3) Then
                    party = PLAYER_PARTY
                    For a = 0 To UBound(Players)
                        If CBGetFighterHP(PLAYER_PARTY, a) > 0 Then
                            pos = a
                            Exit For
                        End If
                    Next a
                ElseIf (pos = 0) Then
                    pos = 1
                ElseIf (pos = 2) Then
                    pos = 3
                End If
            Else
                party = ENEMY_PARTY
                For a = 0 To UBound(Enemies)
                    If CBGetFighterHP(ENEMY_PARTY, a) > 0 Then
                        pos = a
                        Exit For
                    End If
                Next a
            End If
            Call cursorMoveSound

        ElseIf isPressed("UP") Then
            If party = ENEMY_PARTY Then
                Select Case pos
                    Case 2
                        If CBGetFighterHP(ENEMY_PARTY, 0) > 0 Then
                            pos = 0
                        End If
                    Case 3
                        If CBGetFighterHP(ENEMY_PARTY, 1) > 0 Then
                            pos = 1
                        End If
                End Select
            Else
                If pos <> 0 Then
                    pos = pos - 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("DOWN") Then
            If party = ENEMY_PARTY Then
                Select Case pos
                    Case 0
                        If CBGetFighterHP(ENEMY_PARTY, 2) > 0 Then
                            pos = 2
                        End If
                    Case 1
                        If CBGetFighterHP(ENEMY_PARTY, 3) > 0 Then
                            pos = 3
                        End If
                End Select
            Else
                If pos <> UBound(Players) Then
                    pos = pos + 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("ESC", "B", "Q") Then
            Call cursorCancelSound
            done = True

        ElseIf isPressed("ENTER", "SPACE") Then
            Call cursorSelSound
            chosenFighter = pos
            chosenParty = party
            done = True

        End If

        Call CBDoEvents

    Loop

    'Clean up
    Call CBDestroyCanvas(cnv)
    Call CBDestroyCanvas(oldCnv)

End Sub

Private Function specialMoveMenuScanKeys(ByRef player As Fighter) As Boolean

    '====================================================================================
    'Opens the special move menu for the player passed in
    '====================================================================================

    On Error Resume Next

    Const MOVE_BOX_WIDTH As Single = 250

    Dim a As Long, b As Long

    'First, build list of special moves
    Dim moves() As SpcMove
    For a = 0 To CBDetermineSpecialMoves(player.handle)
        Dim filename As String
        filename = CBGetSpecialMoveListEntry(a)
        If filename <> "" Then
            Call CBLoadSpecialMove(filename)
            If CBGetSpecialMoveNum(SPC_BATTLEDRIVEN) = 0 Then
                ReDim Preserve moves(b)
                moves(b).filename = filename
                moves(b).handle = CBGetSpecialMoveString(SPC_NAME)
                moves(b).mp = CBGetSpecialMoveNum(SPC_SMP)
                If moves(b).mp > 0 Then
                    moves(b).handle = moves(b).handle & " - " & CStr(moves(b).mp) & " SMP"
                End If
                b = b + 1
            End If
        End If
    Next a

    Dim cnv As Long
    Dim oldCnv As Long
    cnv = CBCreateCanvas(resX, resY)
    oldCnv = CBCreateCanvas(resX, resY)

    Call CBCanvasGetScreen(cnv)
    Call CBCanvasGetScreen(oldCnv)

    Dim menuPos As Long
    Dim startGrab As Long

    Dim done As Boolean
    Do Until done

        Call CBCanvas2CanvasBlt(oldCnv, cnv, 0, 0)
        Call drawImageTranslucent( _
                                     cnv, _
                                     menuGraphic, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2), _
                                     (resY / 2) - (150 / 2), _
                                     MOVE_BOX_WIDTH, 150)

        Call CBCanvasDrawHand( _
                                 cnv, _
                                (resX / 2) - (MOVE_BOX_WIDTH / 2), _
                                (resY / 2) - (150 / 2) + 25 * (menuPos) + 10)

        If b <> 0 Then
            'Write names of special moves

            Dim scrollBarHeight As Double
            Dim scrollBarPos As Double
            Dim overAndAbove As Double
            Dim endGrab As Long
            Dim line As Long
            line = 0
            endGrab = startGrab + 5
            If endGrab > UBound(moves) Then endGrab = UBound(moves)

            For a = startGrab To endGrab
                line = line + 1
                Call CBCanvasDrawText( _
                                         cnv, _
                                         moves(a).handle, "Comic Sans MS", _
                                         25, _
                                         ((resX / 2) - (MOVE_BOX_WIDTH / 2)) / 25 + 1, _
                                         ((resY / 2) - (150 / 2)) / 25 + line, _
                                         RGB(255, 255, 255), _
                                         0, 0, 0, 0)
            Next a

            'Calculate scroll bar position
            overAndAbove = (b - 6) / 6
            If overAndAbove < 1 Then overAndAbove = 1
            scrollBarHeight = 150 * 1 / overAndAbove
            scrollBarPos = 0
            For a = 1 To startGrab
                scrollBarPos = (scrollBarPos + (((150 - 10) - scrollBarHeight) / 6))
            Next a

            'Draw the scroll bar
            Call CBCanvasFillRect( _
                                     cnv, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH, _
                                     (resY / 2) - (150 / 2), _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 20, _
                                     (resY / 2) - (150 / 2) + 148, _
                                     RGB(255, 255, 255))
            Call CBCanvasFillRect( _
                                     cnv, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 2, _
                                     (resY / 2) - (150 / 2) + scrollBarPos + 4, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 20 - 2, _
                                     (resY / 2) - (150 / 2) + scrollBarPos + scrollBarHeight - 4, _
                                     0)

        End If

        Call CBDrawCanvas(cnv, 0, 0)
        Call CBRefreshScreen

        If isPressed("DOWN") Then
            If (startGrab + 6) < b Then
                startGrab = startGrab + 1
            Else
                If menuPos <> 5 Then
                    menuPos = menuPos + 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("UP") Then
            If (startGrab) > 0 Then
                startGrab = startGrab - 1
            Else
                If menuPos <> 0 Then
                    menuPos = menuPos - 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("ENTER", "SPACE") Then
            Dim theMove As String
            theMove = moves(startGrab + menuPos).filename
            If theMove <> "" Then
                If CBGetFighterSMP(PLAYER_PARTY, player.idx) >= moves(startGrab + menuPos).mp Then
                    Dim tarParty As Long, tarMember As Long
                    Call characterSelect(tarParty, tarMember, ENEMY_PARTY)
                    If tarMember <> -1 Then
                        Call cursorSelSound
                        Call CBFightUseSpecialMove( _
                                                      PLAYER_PARTY, _
                                                      player.idx, _
                                                      tarParty, _
                                                      tarMember, _
                                                      theMove)
                        done = True
                        specialMoveMenuScanKeys = True
                    Else
                        Call cursorCancelSound
                    End If
                Else
                    Call cursorCancelSound
                    Call CBRpgCode("MWin(""Not enough SMP!"")")
                    Call CBRpgCode("Delay(0.5)")
                    Call CBRpgCode("MWinCls()")
                End If
            Else
                Call cursorCancelSound
            End If

        ElseIf isPressed("ESC", "B", "Q") Then
            Call cursorCancelSound
            done = True
            
        End If

        Call CBDoEvents

    Loop

    'Clean up
    Call CBDestroyCanvas(cnv)
    Call CBDestroyCanvas(oldCnv)

End Function

Private Function itemMenuScanKeys(ByRef player As Fighter) As Boolean

    '====================================================================================
    'Opens the item menu for the player passed in
    '====================================================================================

    On Error Resume Next

    Const MOVE_BOX_WIDTH As Single = 250

    'First, build a list of items
    Dim items() As SpcMove
    Dim a As Long, b As Long
    For a = 0 To 500
        Dim theFile As String
        theFile = CBGetGeneralString(GEN_INVENTORY_FILES, a, player.idx)
        If theFile <> "" Then
            Call CBLoadItem(theFile, -1)
            If CBGetItemNum(ITM_FIGHT_YN, 0, -1) = 1 Then
                ReDim Preserve items(b)
                items(b).filename = theFile
                items(b).handle = CBGetGeneralString(GEN_INVENTORY_HANDLES, a, _
                    player.idx) & " x " & CStr(CBGetGeneralNum(GEN_INVENTORY_NUM, a, player.idx))
                b = b + 1
            End If
        End If
    Next a

    Dim cnv As Long
    Dim oldCnv As Long
    cnv = CBCreateCanvas(resX, resY)
    oldCnv = CBCreateCanvas(resX, resY)

    Call CBCanvasGetScreen(cnv)
    Call CBCanvasGetScreen(oldCnv)

    Dim menuPos As Long
    Dim startGrab As Long

    Dim done As Boolean
    Do Until done

        Call CBCanvas2CanvasBlt(oldCnv, cnv, 0, 0)
        Call drawImageTranslucent( _
                                     cnv, _
                                     menuGraphic, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2), _
                                     (resY / 2) - (150 / 2), _
                                     MOVE_BOX_WIDTH, 150)

        Call CBCanvasDrawHand( _
                                 cnv, _
                                 (resX / 2) - (MOVE_BOX_WIDTH / 2), _
                                 (resY / 2) - (150 / 2) + 25 * (menuPos) + 10)

        If b <> 0 Then
            'Write down the items

            Dim scrollBarHeight As Double
            Dim scrollBarPos As Double
            Dim overAndAbove As Double
            Dim endGrab As Long
            Dim line As Long
            line = 0
            endGrab = startGrab + 5
            If endGrab > UBound(items) Then endGrab = UBound(items)

            For a = startGrab To endGrab
                line = line + 1
                Call CBCanvasDrawText( _
                                         cnv, _
                                         items(a).handle, "Comic Sans MS", _
                                         25, _
                                         ((resX / 2) - (MOVE_BOX_WIDTH / 2)) / 25 + 1, _
                                         ((resY / 2) - (150 / 2)) / 25 + line, _
                                         RGB(255, 255, 255), _
                                         0, 0, 0, 0)
            Next a

            'Calculate scroll bar position
            overAndAbove = (b - 6) / 6
            If overAndAbove < 1 Then overAndAbove = 1
            scrollBarHeight = 150 * 1 / overAndAbove
            scrollBarPos = 0
            For a = 1 To startGrab
                scrollBarPos = (scrollBarPos + (((150 - 10) - scrollBarHeight) / 6))
            Next a

            'Draw the scroll bar
            Call CBCanvasFillRect( _
                                     cnv, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH, _
                                     (resY / 2) - (150 / 2), _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 20, _
                                     (resY / 2) - (150 / 2) + 148, _
                                     RGB(255, 255, 255))
            Call CBCanvasFillRect( _
                                     cnv, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 2, _
                                     (resY / 2) - (150 / 2) + scrollBarPos + 3, _
                                     (resX / 2) - (MOVE_BOX_WIDTH / 2) + MOVE_BOX_WIDTH + 20 - 2, _
                                     (resY / 2) - (150 / 2) + scrollBarPos + scrollBarHeight - 4, _
                                     0)

        End If

        Call CBDrawCanvas(cnv, 0, 0)
        Call CBRefreshScreen

        If isPressed("DOWN") Then
            If (startGrab + 6) < b Then
                startGrab = startGrab + 1
            Else
                If menuPos <> 5 Then
                    menuPos = menuPos + 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("UP") Then
            If (startGrab) > 0 Then
                startGrab = startGrab - 1
            Else
                If menuPos <> 0 Then
                    menuPos = menuPos - 1
                End If
            End If
            Call cursorMoveSound

        ElseIf isPressed("ENTER", "SPACE") Then
            Dim theItem As String
            theItem = items(startGrab + menuPos).filename
            If theItem <> "" Then
                Dim tarParty As Long, tarMember As Long
                Call characterSelect(tarParty, tarMember, PLAYER_PARTY)
                If tarMember <> -1 Then
                    Call cursorSelSound
                    Call CBFightUseItem( _
                                           PLAYER_PARTY, _
                                           player.idx, _
                                           tarParty, _
                                           tarMember, _
                                           theItem)
                    done = True
                    itemMenuScanKeys = True
                Else
                    Call cursorCancelSound
                End If
            Else
                Call cursorCancelSound
            End If

        ElseIf isPressed("ESC", "B", "Q") Then
            Call cursorCancelSound
            done = True

        End If

        Call CBDoEvents

    Loop

    'Clean up
    Call CBDestroyCanvas(cnv)
    Call CBDestroyCanvas(oldCnv)

End Function

'====================================================================================
'Cursor sound effects
'====================================================================================

Private Sub cursorMoveSound()
    Dim theSound As String
    theSound = CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0)
    If theSound <> "" Then
        Call CBRpgCode("Wav(""" & theSound & """)")
    End If
    Call CBRpgCode("Delay(0.1)")
End Sub

Private Sub cursorCancelSound()
    Dim theSound As String
    theSound = CBGetGeneralString(GEN_CURSOR_CANCELSOUND, 0, 0)
    If theSound <> "" Then
        Call CBRpgCode("Wav(""" & theSound & """)")
    End If
    Call CBRpgCode("Delay(0.1)")
End Sub

Private Sub cursorSelSound()
    Dim theSound As String
    theSound = CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0)
    If theSound <> "" Then
        Call CBRpgCode("Wav(""" & theSound & """)")
    End If
    Call CBRpgCode("Delay(0.1)")
End Sub

'====================================================================================
' Check if a key is pressed
'====================================================================================
Private Function isPressed(ParamArray keys() As Variant) As Boolean
    On Error Resume Next
    Dim keyIdx As Long
    For keyIdx = LBound(keys) To UBound(keys)
        If CBCheckKey(keys(keyIdx)) = 1 Then
            isPressed = True
            Exit Function
        End If
    Next keyIdx
End Function
