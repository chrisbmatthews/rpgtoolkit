Attribute VB_Name = "transFightAI"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Artificial intelligence fight tactical procedures
'=========================================================================

'=========================================================================
' NOTE: Needs work!!
'=========================================================================

Option Explicit

'=========================================================================
' Randomly choose a living player to hit
'=========================================================================
Public Function chooseHit(Optional ByVal enemyNum As Long) As Long
    On Error Resume Next
    Dim hit As Long
    Do
        hit = Int(Rnd(1) * 5)
        If (LenB(playerListAr(hit))) Then
            If getPlayerHP(playerMem(hit)) > 0 Then
                chooseHit = hit
                Exit Function
            End If
        End If
    Loop
End Function

'=========================================================================
' Preform AI of the level passed in
'=========================================================================
Public Sub preformFightAI(ByVal level As Integer, ByVal targetParty As Long, ByVal targetFighter As Long)
    On Error Resume Next
    Select Case level
        Case 0: Call AIZero(targetParty, targetFighter)
        Case 1: Call AIOne(targetParty, targetFighter)
        Case 2: Call AITwo(targetParty, targetFighter)
        Case 3: Call AIThree(targetParty, targetFighter)
    End Select
End Sub

'=========================================================================
' Use AI - level 0
'=========================================================================
Private Sub AIZero(ByVal partyIdx As Long, ByVal fighterIdx As Long)

    On Error Resume Next
    
    Dim playerHit As Long
    'choose the player to attack...
    Dim done As Boolean
    Do Until done
        playerHit = Int(Rnd(1) * UBound(parties(PLAYER_PARTY).fighterList))
        done = (getPartyMemberHP(PLAYER_PARTY, playerHit) > 0)
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
        ReDim moveScanDo(500) As String
        Dim count As Long
        count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, moveScanDo())
        If count = 0 Then
            'can't do any moves- revert to phys attack
            Call doAttack(partyIdx, fighterIdx, _
                          PLAYER_PARTY, playerHit, _
                          getPartyMemberFP(partyIdx, fighterIdx), False)
        Else
            Dim moveToDo As Long
            
            Dim move As TKSpecialMove
            moveToDo = Int(Rnd(1) * count + 1) - 1
            
            Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, moveScanDo(moveToDo))
        End If
    End If
End Sub

'=========================================================================
' Use AI - level 1
'=========================================================================
Private Sub AIOne(ByVal partyIdx As Long, ByVal fighterIdx As Long)

    On Error Resume Next
    
    Dim playerHit As Long
    'choose the player to attack...
    Dim done As Boolean
    Do Until done
        playerHit = Int(Rnd(1) * UBound(parties(PLAYER_PARTY).fighterList))
        done = (getPartyMemberHP(PLAYER_PARTY, playerHit) > 0)
    Loop
    
    'try to do special move
    ReDim moveScanDo(500) As String
    Dim count As Long
    count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, moveScanDo())
    If count = 0 Then
        'can't do any moves- revert to phys attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        Dim moveToDo As Long
        
        Dim move As TKSpecialMove
        moveToDo = Int(Rnd(1) * count + 1) - 1
        
        Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, moveScanDo(moveToDo))
    End If
End Sub

'=========================================================================
' Use AI - level 2
'=========================================================================
Private Sub AITwo(ByVal partyIdx As Long, ByVal fighterIdx As Long)

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
        ReDim moveScanDo(500) As String
        Dim count As Long
        count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, moveScanDo())
        If count = 0 Then
            'can't do any moves- revert to phys attack
            Call doAttack(partyIdx, fighterIdx, _
                          PLAYER_PARTY, playerHit, _
                          getPartyMemberFP(partyIdx, fighterIdx), False)
        Else
            Dim moveToDo As Long
            
            Dim move As TKSpecialMove
            moveToDo = Int(Rnd(1) * count + 1) - 1
            
            Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, moveScanDo(moveToDo))
        End If
    End If
End Sub

'=========================================================================
' Use AI - level 3
'=========================================================================
Private Sub AIThree(ByVal partyIdx As Long, ByVal fighterIdx As Long)

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
    Dim moveScanDo(500) As String
    Dim count As Long
    count = enemyCanDoSM(parties(partyIdx).fighterList(fighterIdx).enemy, moveScanDo())
    If count = 0 Then
        'can't do any moves- revert to phys attack
        Call doAttack(partyIdx, fighterIdx, _
                      PLAYER_PARTY, playerHit, _
                      getPartyMemberFP(partyIdx, fighterIdx), False)
    Else
        Dim moveToDo As Long
        
        Dim move As TKSpecialMove
        moveToDo = Int(Rnd(1) * count + 1) - 1
        
        Call doUseSpecialMove(partyIdx, fighterIdx, PLAYER_PARTY, playerHit, moveScanDo(moveToDo))
    End If
End Sub

'=========================================================================
' Determine which special moves an enemy can preform
'=========================================================================
Private Function enemyCanDoSM(ByRef theEnemy As TKEnemy, ByRef moveArray() As String) As Long

    On Error Resume Next

    Dim t As Long
    Dim idx As Long
    Dim move As TKSpecialMove
    
    For t = 0 To UBound(theEnemy.eneSpecialMove)
        If (LenB(theEnemy.eneSpecialMove(t))) Then
            move = openSpecialMove(projectPath$ & spcPath$ & theEnemy.eneSpecialMove(t))
            If move.smSMP <= getEnemySMP(theEnemy) Then
                'we can do it...
                moveArray(idx) = theEnemy.eneSpecialMove(t)
                idx = idx + 1
            End If
        End If
    Next t
    
    enemyCanDoSM = idx
End Function
