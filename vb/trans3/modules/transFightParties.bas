Attribute VB_Name = "transFightParties"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit
'fighting parties
'manages stats for managed battles

Public Type Fighter
    isPlayer As Boolean 'is this a player (if no, then it's an enemy)
    enemy As TKEnemy    'enemy
    player As TKPlayer  'player
    
    chargeCounter As Long   'charge counter
    maxChargeTime As Long   'what the counter must reach before charged.
    
    freezeCharge As Boolean 'if true, then charging is frozen until unforzen
End Type

Public Type FighterParty
    isPlayerControlled As Boolean   'is it controlled by a player (if not, then controlled by cpu)
    fighterList() As Fighter        'list of fighters in party
    
    'rewards...
    gp As Long      'gp to win
    fightInventory As TKInventory 'inventory of this party
    winProgram As String    'rpgcode program to run when you beat them
End Type

Public parties(2) As FighterParty   'fighting parties -- 0 is enemy, 1 is player

Public Const ENEMY_PARTY = 0
Public Const PLAYER_PARTY = 1

Private Function AttackFighter(ByRef theFighter As Fighter, ByVal amount As Long, ByVal toSMP As Boolean) As Long
    'attack a fighter
    'amount is the amount of FP to attack with (use a negative number to *give* hp or SMP)
    'if toSMP is true, then we remove (or add) amount to SMP
    'adjust FP to the figher's DP
    'Does not call into the fight plugin to tell the plugin that the member was attacked
    'return amount (adjusted to DP)
    On Error Resume Next
    
    Dim dp As Double
    Dim randomHit As Long
    
    If theFighter.isPlayer Then
        'hitting a player...
        dp = getPlayerDP(theFighter.player)
        'randomly +/- 10%
        If amount > 0 Then
            'only if we're not *adding* hp/smp
            randomHit = Int(Rnd(1) * 20) - 10
            amount = Int(amount + (randomHit / 100# * amount))
        End If
        
        'randomly do a critical hit (1 in 20 chance)
        randomHit = Int(Rnd(1) * 20)
        If randomHit <> 10 And amount > 0 Then
            amount = amount - dp
        End If
        
        If amount <= 0 Then amount = 1
        
        'adjust the hp or smp accordingly...
        If toSMP Then
            Call addPlayerSMP(-1 * amount, theFighter.player)
        Else
            Call addPlayerHP(-1 * amount, theFighter.player)
        End If
    Else
        'hitting an enemy...
        dp = getEnemyDP(theFighter.enemy)
        'randomly +/- 10%
        If amount > 0 Then
            'only if we're not *adding* hp/smp
            randomHit = Int(Rnd(1) * 20) - 10
            amount = Int(amount + (randomHit / 100# * amount))
        End If
        
        'randomly do a critical hit (1 in 20 chance)
        randomHit = Int(Rnd(1) * 20)
        If randomHit <> 10 And amount > 0 Then
            amount = amount - dp
        End If
        
        If amount <= 0 Then amount = 1
        
        'adjust the hp or smp accordingly...
        If toSMP Then
            Call addEnemySMP(-1 * amount, theFighter.enemy)
        Else
            Call addEnemyHP(-1 * amount, theFighter.enemy)
        End If
    End If
    
    AttackFighter = amount
End Function


Function AttackPartyMember(ByVal partyIndex As Long, ByVal fighterIndex As Long, ByVal amount As Long, ByVal toSMP As Boolean) As Long
    'attack a fighter in the parties() array
    'if amount < 0, it *adds* to the player/emeny
    'return actual amount
    'call into the plugin to inform the system that the player/enemy was attacked
    On Error Resume Next
    
    Dim toRet As Long
    toRet = AttackFighter(parties(partyIndex).fighterList(fighterIndex), amount, toSMP)
       
    AttackPartyMember = toRet
End Function

Sub CreateEnemyParty(ByRef party As FighterParty, ByRef enemies() As TKEnemy)
    'create an enemy party (in party) from an array of enemies
    On Error Resume Next
    Call CreateParty(party, UBound(enemies), True)
    
    party.isPlayerControlled = False
    
    Dim t As Long
    Dim u As Long
    
    'calculate gp reward level
    Dim gp As Long
    For t = 0 To UBound(enemies)
        gp = gp + enemies(t).eneGP
    Next t
    party.gp = gp
    
    'determine win program...
    For t = 0 To UBound(enemies)
        If enemies(t).eneRPGCode <> "" Then
            party.winProgram = enemies(t).eneRPGCode
        End If
    Next t
    
    For t = 0 To UBound(enemies)
        party.fighterList(t).isPlayer = False
        party.fighterList(t).enemy = enemies(t)
        party.fighterList(t).maxChargeTime = 130
        party.fighterList(t).chargeCounter = Int(Rnd(1) * party.fighterList(t).maxChargeTime)
        Call EnemyClearAllStatus(party.fighterList(t).enemy)
        Call EnemyClearAllStatus(enemies(t))
    Next t
End Sub


Sub CreateParty(ByRef party As FighterParty, ByVal members As Long, ByVal asEnemies As Boolean)
    'initialize party
    'with members # of fighters
    'if asEnemies is true, it sets them as enemies
    On Error Resume Next
    
    ReDim party.fighterList(members)
    party.isPlayerControlled = Not (asEnemies)
    
    Dim t As Long
    Dim u As Long
    If asEnemies Then
        'create enemies...
        For t = 0 To members - 1
            party.fighterList(t).isPlayer = False
            Call EnemyClear(party.fighterList(t).enemy)
        Next t
    Else
        'create players...
        For t = 0 To members - 1
            party.fighterList(t).isPlayer = True
            Call PlayerClear(party.fighterList(t).player)
        Next t
    End If
End Sub


Sub CreatePlayerParty(ByRef party As FighterParty, ByRef players() As TKPlayer, ByRef inventory As TKInventory, ByVal gp As Long)
    'create a player party (in party) from an array of players
    On Error Resume Next
    Call CreateParty(party, UBound(players), False)
    
    party.fightInventory = inventory
    party.gp = gp
    party.isPlayerControlled = True
    party.winProgram = ""
    
    Dim t As Long
    Dim u As Long
    For t = 0 To UBound(players)
        party.fighterList(t).isPlayer = True
        party.fighterList(t).player = players(t)
        party.fighterList(t).maxChargeTime = 80
        party.fighterList(t).chargeCounter = Int(Rnd(1) * party.fighterList(t).maxChargeTime)
        Call PlayerClearAllStatus(party.fighterList(t).player)
        Call PlayerClearAllStatus(players(t))
    Next t
End Sub


Function getPartyMemberCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'determine the charge percent for a fighter
    On Error Resume Next
    If parties(partyIdx).fighterList(fighterIdx).maxChargeTime <> 0 Then
        getPartyMemberCharge = parties(partyIdx).fighterList(fighterIdx).chargeCounter / _
                               parties(partyIdx).fighterList(fighterIdx).maxChargeTime * 100
    End If
End Function

Function doAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Boolean) As Long
    'cause one figher to attack another
    On Error Resume Next
    
    'only do the attack if the source has HP left...
    If (getPartyMemberHP(sourcePartyIdx, sourceFightIdx) <= 0) Then
        doAttack = 0
        Exit Function
    End If
    
    'now do the attack...
    Dim actualAmount As Long
    actualAmount = AttackPartyMember(targetPartyIdx, targetFightIdx, amount, toSMP)
    
    Dim hp As Long, smp As Long
    If toSMP Then
        smp = actualAmount
    Else
        hp = actualAmount
    End If
    
    'report that this took place...
    Call fightInformAttack(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, hp, smp)
    doAttack = actualAmount
End Function

Sub doUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
    'cause one figher to use an item on another
    On Error Resume Next
    
    'only do the attack if the source has HP left...
    If (getPartyMemberHP(sourcePartyIdx, sourceFightIdx) <= 0) Then
        Exit Sub
    End If
       
    'now use the item...
    Dim theItem As TKItem
    theItem = openItem(projectPath & itmPath & itemFile)
    
    Dim hp As Double, smp As Double
    
    hp = theItem.fgtHPup
    smp = theItem.fgtSMup
    
    'now give the target the hp and smp...
    If parties(targetPartyIdx).fighterList(targetFightIdx).isPlayer Then
        'target is player
        Call addPlayerHP(hp, parties(targetPartyIdx).fighterList(targetFightIdx).player)
        Call addPlayerSMP(smp, parties(targetPartyIdx).fighterList(targetFightIdx).player)
    Else
        'target is enemy
        Call addEnemyHP(hp, parties(targetPartyIdx).fighterList(targetFightIdx).enemy)
        Call addEnemySMP(smp, parties(targetPartyIdx).fighterList(targetFightIdx).enemy)
    End If
    
    'set source and target...
    source = sourceFightIdx
    If sourcePartyIdx = PLAYER_PARTY Then
        sourceType = TYPE_PLAYER
    Else
        sourceType = TYPE_ENEMY
    End If
    
    'set target...
    target = targetFightIdx
    If targetPartyIdx = PLAYER_PARTY Then
        targetType = TYPE_PLAYER
    Else
        targetType = TYPE_ENEMY
    End If
       
    'remove this item from inventory...
    Dim theOne As Long, t As Long
    theOne = -1
    For t = 0 To UBound(inv.item)
        If UCase$(inv.item(t).file) = UCase$(itemFile) Then theOne = t
    Next t
    If theOne <> -1 Then
        inv.item(theOne).number = inv.item(theOne).number - 1
        If inv.item(theOne).number <= 0 Then
            inv.item(theOne).number = 0
            inv.item(theOne).file = ""
            inv.item(theOne).handle = ""
        End If
    End If
        
    'the plugin will run rpgcode if required
    'and it will run an animation if required
    
    'report that this took place...
    Call fightInformItemUse(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, -hp, -smp, itemFile)
End Sub


Sub doUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
    'cause one figher to use a special move on another
    On Error Resume Next
    
    'only do the attack if the source has HP left...
    If (getPartyMemberHP(sourcePartyIdx, sourceFightIdx) <= 0) Then
        Exit Sub
    End If
       
    'now use the move...
    Dim theMove As TKSpecialMove
    Call openSpecialMove(projectPath$ + spcPath$ + moveFile, theMove)
    
    Dim hp As Double, smp As Double, sourceSMP As Double
    
    hp = theMove.smFP
    smp = theMove.smtargSMP
    sourceSMP = theMove.smSMP
    
    'now remove the target hp and smp...
    If parties(targetPartyIdx).fighterList(targetFightIdx).isPlayer Then
        'target is player
        Call addPlayerHP(-hp, parties(targetPartyIdx).fighterList(targetFightIdx).player)
        Call addPlayerSMP(-smp, parties(targetPartyIdx).fighterList(targetFightIdx).player)
    Else
        'target is enemy
        Call addEnemyHP(-hp, parties(targetPartyIdx).fighterList(targetFightIdx).enemy)
        Call addEnemySMP(-smp, parties(targetPartyIdx).fighterList(targetFightIdx).enemy)
    End If
    
    'remove smp from source
    If parties(sourcePartyIdx).fighterList(sourceFightIdx).isPlayer Then
        'source is player
        Call addPlayerSMP(-sourceSMP, parties(sourcePartyIdx).fighterList(sourceFightIdx).player)
    Else
        'source is enemy
        Call addEnemySMP(-sourceSMP, parties(sourcePartyIdx).fighterList(sourceFightIdx).enemy)
    End If
    
    'set source and target...
    source = sourceFightIdx
    If sourcePartyIdx = PLAYER_PARTY Then
        sourceType = TYPE_PLAYER
    Else
        sourceType = TYPE_ENEMY
    End If
    
    'set target...
    target = targetFightIdx
    If targetPartyIdx = PLAYER_PARTY Then
        targetType = TYPE_PLAYER
    Else
        targetType = TYPE_ENEMY
    End If
       
    'the plugin will run rpgcode if required
    'and it will run an animation if required
    
    'report that this took place...
    Call fightInformSpecialMove(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, sourceSMP, hp, smp, moveFile)
End Sub



Sub invokeStatus(ByVal partyIdx As Long, ByVal fightIdx As Long, ByRef theEffect As TKStatusEffect, Optional ByVal statusFile As String = "")
    'apply effects of status effect to a fighter...
    On Error Resume Next
    If theEffect.nStatusHP = 1 Then
        If parties(partyIdx).fighterList(fightIdx).isPlayer Then
            Call addPlayerHP(-1 * theEffect.nStatusHPAmount, parties(partyIdx).fighterList(fightIdx).player)
        Else
            Call addEnemyHP(-1 * theEffect.nStatusHPAmount, parties(partyIdx).fighterList(fightIdx).enemy)
        End If
        Call fightInformRemoveStat(partyIdx, fightIdx, theEffect.nStatusHPAmount, False, statusFile)
    End If

    If theEffect.nStatusSMP = 1 Then
        If parties(partyIdx).fighterList(fightIdx).isPlayer Then
            Call addPlayerSMP(-1 * theEffect.nStatusSMPAmount, parties(partyIdx).fighterList(fightIdx).player)
        Else
            Call addEnemySMP(-1 * theEffect.nStatusSMPAmount, parties(partyIdx).fighterList(fightIdx).enemy)
        End If
        Call fightInformRemoveStat(partyIdx, fightIdx, theEffect.nStatusSMPAmount, True, statusFile)
    End If

    If theEffect.nStatusRPGCode = 1 Then
        If parties(partyIdx).fighterList(fightIdx).isPlayer Then
            source = fightIdx
            sourceType = TYPE_PLAYER
            target = fightIdx
            targetType = TYPE_PLAYER
            Call runProgram(theEffect.sStatusRPGCode, -1, False)
        Else
            source = fightIdx
            sourceType = TYPE_ENEMY
            target = fightIdx
            targetType = TYPE_ENEMY
            Call runProgram(theEffect.sStatusRPGCode, -1, False)
        End If
    End If
End Sub

Function isPartyDefeated(ByVal partyIdx As Long) As Boolean
    On Error Resume Next
    'determine if a party is defeated
    Dim bRet As Boolean
    Dim max As Long
    Dim t As Long
    
    bRet = True
    
    max = getPartySize(partyIdx)
    For t = 0 To max
        If getPartyMemberHP(partyIdx, t) > 0 Then
            bRet = False
            Exit For
        End If
    Next t
    
    isPartyDefeated = bRet
End Function

Sub partyMemberAddStatus(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    'add a status effect to a fighter
    On Error Resume Next
    
    
    If parties(partyIdx).fighterList(fightIdx).isPlayer Then
        Call PlayerAddStatus(statusFile, parties(partyIdx).fighterList(fightIdx).player)
    Else
        Call EnemyAddStatus(statusFile, parties(partyIdx).fighterList(fightIdx).enemy)
    End If
End Sub

Sub partyMemberRemoveStatus(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    'add a status effect to a fighter
    On Error Resume Next
    
    Dim t As Long
    'check if the fighter already has this status effect...
    If parties(partyIdx).fighterList(fightIdx).isPlayer Then
        Call PlayerRemoveStatus(statusFile, parties(partyIdx).fighterList(fightIdx).player)
    Else
        Call EnemyRemoveStatus(statusFile, parties(partyIdx).fighterList(fightIdx).enemy)
    End If
End Sub


Sub setPartyMemberMaxCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal ticks As Long)
    'determine the charge percent for a fighter
    On Error Resume Next
    parties(partyIdx).fighterList(fighterIdx).maxChargeTime = ticks
End Sub

Function getPartyMemberHP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the hp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberHP = getPlayerHP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberHP = getEnemyHP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function

Function getPartyMemberMaxHP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the max hp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberMaxHP = getPlayerMaxHP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberMaxHP = getEnemyMaxHP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function

Function getPartyMemberSMP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the smp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberSMP = getPlayerSMP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberSMP = getEnemySMP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function

Function getPartyMemberMaxSMP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the max smp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberMaxSMP = getPlayerMaxSMP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberMaxSMP = getEnemyMaxSMP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function

Function getPartyMemberFP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the hp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberFP = getPlayerFP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberFP = getEnemyFP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function

Function getPartyMemberDP(ByVal partyIdx, ByVal fighterIdx) As Long
    'get the hp of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberDP = getPlayerDP(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberDP = getEnemyDP(parties(partyIdx).fighterList(fighterIdx).enemy)
    End If
End Function


Function getPartyMemberName(ByVal partyIdx, ByVal fighterIdx) As String
    'get the name of a fighter in the party
    On Error Resume Next
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        getPartyMemberName = getPlayerName(parties(partyIdx).fighterList(fighterIdx).player)
    Else
        getPartyMemberName = parties(partyIdx).fighterList(fighterIdx).enemy.eneName
    End If
End Function



Function getPartyMemberAnimation(ByVal partyIdx, ByVal fighterIdx, ByVal animationName) As String
    'get the filename for an animation of a fighter in the party
    'animationName can be:
    'rest, attack, defend, special move, die, or any custom name
    On Error Resume Next
    animationName = UCase(animationName)
        
    If parties(partyIdx).fighterList(fighterIdx).isPlayer Then
        'hitting a player...
        Select Case animationName
            Case "REST":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).player.gfx(PLYR_REST)
            Case "ATTACK":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).player.gfx(PLYR_FIGHT)
            Case "DEFEND":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).player.gfx(PLYR_DEFEND)
            Case "SPECIAL MOVE":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).player.gfx(PLYR_SPC)
            Case "DIE":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).player.gfx(PLYR_DIE)
            Case Else:
                getPartyMemberAnimation = playerGetStanceAnm(animationName, parties(partyIdx).fighterList(fighterIdx).player)
        End Select
    Else
        Select Case animationName
            Case "REST":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).enemy.gfx(ENE_REST)
            Case "ATTACK":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).enemy.gfx(ENE_FIGHT)
            Case "DEFEND":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).enemy.gfx(ENE_DEFEND)
            Case "SPECIAL MOVE":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).enemy.gfx(ENE_SPC)
            Case "DIE":
                getPartyMemberAnimation = parties(partyIdx).fighterList(fighterIdx).enemy.gfx(ENE_DIE)
            Case Else:
                getPartyMemberAnimation = enemyGetStanceAnm(animationName, parties(partyIdx).fighterList(fighterIdx).enemy)
        End Select
    End If
End Function


Function getPartySize(ByVal partyIdx As Long) As Long
    'get the number of fighters in a party
    On Error Resume Next
    
    getPartySize = UBound(parties(partyIdx).fighterList)
End Function


