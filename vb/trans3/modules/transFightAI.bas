Attribute VB_Name = "transFightAI"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'enemy ai for fights
Option Explicit

Function chooseHit(ByVal enemyNum As Long) As Long
    'chooses a good guy to hit based upon the enemy's
    'ai.
    'Returns NUMBER of good guy to hit.
    'If eneAI(eenum) = 0 Then
        'No ai- random choice.
    On Error Resume Next
    Dim hit As Long
    Do While (True)
        hit = Int(Rnd(1) * 5)
        If playerListAr$(hit) <> "" And getPlayerHP(playerMem(hit)) > 0 Then
            chooseHit = hit
            Exit Function
        End If
    Loop
End Function

Sub AIOne(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    'Enemy ai- level 1
    'will use special moves until power is spent.
    'then will use physical attacks (equivalent of version 1 ai)
    On Error Resume Next
    
    Dim playerHit As Long
    'choose the player to attack...
    Dim done As Boolean
    Do While Not (done)
        playerHit = Int(Rnd(1) * UBound(parties(PLAYER_PARTY).fighterList))
        If getPartyMemberHP(PLAYER_PARTY, playerHit) > 0 Then
            done = True
        End If
    Loop
    
    'try to do special move
    ReDim movescando(500) As String
    Dim count As Long
    count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, movescando())
    If count = 0 Then
        'can't do any moves- revert to phys attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        Dim moveToDo As Long
        
        Dim move As TKSpecialMove
        moveToDo = Int(Rnd(1) * count + 1) - 1
        
        Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, movescando(moveToDo))
    End If
End Sub

Sub AIThree(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    'the third and higest level of enemy ai.
    'the enemy first checks if he needs
    'health (it's down to 10%), and will use a curative special move
    'if need be.
    'the enemy seeks out the weakest player and will blast him with
    'special moves until running out of smp.
    'then revert to physical attacks.
    On Error Resume Next
    
    Dim playerHit As Long
    'choose weakest player to attack...
    Dim t As Long
    Dim lowest As Long
    lowest = getPartyMemberHP(PLAYER_PARTY, 0) + 1
    For t = 0 To getPartySize(PLAYER_PARTY) - 1
        If getPartyMemberHP(PLAYER_PARTY, t) < lowest Then
            lowest = getPartyMemberHP(PLAYER_PARTY, t)
            playerHit = t
        End If
    Next t
    
    'try to do special move
    ReDim movescando(500) As String
    Dim count As Long
    count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, movescando())
    If count = 0 Then
        'can't do any moves- revert to phys attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        Dim moveToDo As Long
        
        Dim move As TKSpecialMove
        moveToDo = Int(Rnd(1) * count + 1) - 1
        
        Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, movescando(moveToDo))
    End If
End Sub

Sub AITwo(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    'AI level 2.
    'finds the weakest person and continuously hits
    'him/her. (thus, to hitgets ignored, because we get a ne tohit).
    'will hit mostly with physical attacks, but will use some special moves.
    On Error Resume Next
    
    Dim playerHit As Long
    'choose weakest player to attack...
    Dim t As Long
    Dim lowest As Long
    lowest = getPartyMemberHP(PLAYER_PARTY, 0) + 1
    For t = 0 To getPartySize(PLAYER_PARTY) - 1
        If getPartyMemberHP(PLAYER_PARTY, t) < lowest Then
            lowest = getPartyMemberHP(PLAYER_PARTY, t)
            playerHit = t
        End If
    Next t
    
    Dim res As Long
    res = Int(Rnd(1) * 2) + 1
    If res = 1 Then
        'do physical attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        'do special move
        ReDim movescando(500) As String
        Dim count As Long
        count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, movescando())
        If count = 0 Then
            'can't do any moves- revert to phys attack
            Call doAttack(partyIdx, fighterIdx, _
                          PLAYER_PARTY, playerHit, _
                          getPartyMemberFP(partyIdx, fighterIdx), False)
        Else
            Dim moveToDo As Long
            
            Dim move As TKSpecialMove
            moveToDo = Int(Rnd(1) * count + 1) - 1
            
            Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, movescando(moveToDo))
        End If
    End If
End Sub

Sub AIZero(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    'ai for level 0 (fairly random)
    On Error Resume Next
    
    Dim playerHit As Long
    'choose the player to attack...
    Dim done As Boolean
    Do While Not (done)
        playerHit = Int(Rnd(1) * UBound(parties(PLAYER_PARTY).fighterList))
        If getPartyMemberHP(PLAYER_PARTY, playerHit) > 0 Then
            done = True
        End If
    Loop
    
    Dim res As Long
    res = Int(Rnd(1) * 2) + 1
    If res = 1 Then
        'do physical attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        'do special move
        ReDim movescando(500) As String
        Dim count As Long
        count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, movescando())
        If count = 0 Then
            'can't do any moves- revert to phys attack
            Call doAttack(partyIdx, fighterIdx, _
                          PLAYER_PARTY, playerHit, _
                          getPartyMemberFP(partyIdx, fighterIdx), False)
        Else
            Dim moveToDo As Long
            
            Dim move As TKSpecialMove
            moveToDo = Int(Rnd(1) * count + 1) - 1
            
            Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, movescando(moveToDo))
        End If
    End If
End Sub

Function enemyCanDoSM(ByRef theEnemy As TKEnemy, ByRef moveArray() As String) As Long
    'fill array with moves the enemy can do
    'return number of moves in array
    On Error Resume Next
    Dim t As Long
    Dim idx As Long
    Dim move As TKSpecialMove
    
    For t = 0 To UBound(theEnemy.eneSpecialMove)
        If theEnemy.eneSpecialMove(t) <> "" Then
            Call openSpecialMove(projectPath$ + spcPath$ + theEnemy.eneSpecialMove(t), move)
            If move.smSMP <= getEnemySMP(theEnemy) Then
                'we can do it...
                moveArray(idx) = theEnemy.eneSpecialMove(t)
                idx = idx + 1
            End If
        End If
    Next t
    
    enemyCanDoSM = idx
End Function
