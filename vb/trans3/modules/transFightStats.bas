Attribute VB_Name = "transFightStats"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Sub addEnemyHP(ByVal amount As Long, ByRef theEnemy As TKEnemy)
    'add hp to an enemy
    On Error Resume Next
    Call setEnemyHP(getEnemyHP(theEnemy) + amount, theEnemy)
End Sub

Sub addEnemySMP(ByVal amount As Long, ByRef theEnemy As TKEnemy)
    'add smp to an enemy
    On Error Resume Next
    Call setEnemySMP(getEnemySMP(theEnemy) + amount, theEnemy)
End Sub

Sub setEnemyHP(ByVal amount As Long, ByRef theEnemy As TKEnemy)
    'set hp of an enemy
    On Error Resume Next
    
    Dim max As Long
    max = getEnemyMaxHP(theEnemy)
    If amount > max Then
        amount = max
    End If
    If amount < 0 Then
        amount = 0
    End If
    theEnemy.eneHP = amount
End Sub

Sub setEnemySMP(ByVal amount As Long, ByRef theEnemy As TKEnemy)
    'set smp of an enemy
    On Error Resume Next
    
    Dim max As Long
    max = getEnemyMaxSMP(theEnemy)
    If amount > max Then
        amount = max
    End If
    If amount < 0 Then
        amount = 0
    End If
    theEnemy.eneSMP = amount
End Sub

Function getEnemyHP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's hp
    On Error Resume Next
    getEnemyHP = theEnemy.eneHP
End Function

Function getEnemyFP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's fp
    On Error Resume Next
    getEnemyFP = theEnemy.eneFP
End Function

Function getEnemyDP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's dp
    On Error Resume Next
    getEnemyDP = theEnemy.eneDP
End Function

Function getEnemyMaxHP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's max hp
    On Error Resume Next
    getEnemyMaxHP = theEnemy.eneMaxHP
End Function

Function getEnemySMP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's smp
    On Error Resume Next
    getEnemySMP = theEnemy.eneSMP
End Function

Function getEnemyMaxSMP(ByRef theEnemy As TKEnemy) As Long
    'get enemy's max smp
    On Error Resume Next
    getEnemyMaxSMP = theEnemy.eneMaxSMP
End Function



Function getPlayerFP(ByRef thePlayer As TKPlayer) As Double
    'gets the FP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.fightVar$, l$, stat)
    getPlayerFP = stat
End Function

Function getPlayerName(ByRef thePlayer As TKPlayer) As String
    'gets the name of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.nameVar$, l$, stat)
    getPlayerName = l
End Function

Function getPlayerDP(ByRef thePlayer As TKPlayer) As Double
    'gets the DP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.defenseVar$, l$, stat)
    getPlayerDP = stat
End Function

Function getPlayerMaxSMP(ByRef thePlayer As TKPlayer) As Double
    'gets the max SMP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.smMaxVar$, l$, stat)
    getPlayerMaxSMP = stat
End Function

Function getPlayerHP(ByRef thePlayer As TKPlayer) As Double
    'gets the HP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.healthVar$, l$, stat)
    getPlayerHP = stat
End Function

Sub giveExperience(ByVal amount As Long, thePlayer As TKPlayer)
    'gives the player experience (amount)
    On Error Resume Next
    Dim expr As Double
    Dim aa As Long
    Dim l As String
    aa = getIndependentVariable(thePlayer.experienceVar$, l$, expr)
    expr = expr + amount
    Call setIndependentVariable(thePlayer.experienceVar$, CStr(expr))
    thePlayer.nextLevel = thePlayer.nextLevel - amount
    
    Dim nxtLev As Integer
    nxtLev = thePlayer.nextLevel
    Do While thePlayer.nextLevel <= 0
        'level up!!!
        Call increaseLevel(thePlayer)
        thePlayer.nextLevel = thePlayer.nextLevel - Abs(nxtLev)
    Loop
End Sub

Sub increaseLevel(ByRef thePlayer As TKPlayer)
    'increase level of player
    On Error Resume Next
    
    Dim num As Long
    Dim t As Long
    For t = 0 To UBound(playerMem)
        If thePlayer.nameVar = playerMem(t).nameVar Then
            num = t
            Exit For
        End If
    Next t
    
    'rpgcode program:
    If thePlayer.charLevelUpRPGCode$ <> "" Then
        target = num
        targetType = 0
        Source = num
        sourceType = 0
        Call runProgram(projectPath & prgPath & thePlayer.charLevelUpRPGCode$)
    End If
    
    'level up:
    Dim lev As Double
    Dim aa As Long
    Dim l As String
    aa = getIndependentVariable(thePlayer.leVar$, l$, lev)
    If lev >= thePlayer.maxLevel Then Exit Sub
    lev = lev + 1
    Call setIndependentVariable(thePlayer.leVar$, CStr(lev))
    If thePlayer.charLevelUpType = 0 Then
        thePlayer.levelProgression = thePlayer.levelProgression + Int(thePlayer.levelProgression * (thePlayer.experienceIncrease / 100))
    Else
        thePlayer.levelProgression = thePlayer.levelProgression + thePlayer.experienceIncrease
    End If
    thePlayer.nextLevel = thePlayer.levelProgression
    
    'hp up:
    Dim hp As Double
    aa = getIndependentVariable(thePlayer.maxHealthVar$, l$, hp)
    If thePlayer.charLevelUpType = 0 Then
        hp = hp + ((hp - equipHPadd(num)) * thePlayer.levelHp / 100)
    Else
        hp = hp + thePlayer.levelHp
    End If
    hp = Int(hp)
    Call setIndependentVariable(thePlayer.maxHealthVar$, CStr(hp))
    
    'dp up:
    aa = getIndependentVariable(thePlayer.defenseVar$, l$, hp)
    If thePlayer.charLevelUpType = 0 Then
        hp = hp + ((hp - equipDPadd(num)) * thePlayer.levelDp / 100)
    Else
        hp = hp + thePlayer.levelDp
    End If
    hp = Int(hp)
    Call setIndependentVariable(thePlayer.defenseVar$, CStr(hp))
    
    'fp up:
    aa = getIndependentVariable(thePlayer.fightVar$, l$, hp)
    If thePlayer.charLevelUpType = 0 Then
        hp = hp + ((hp - equipFPadd(num)) * thePlayer.levelFp / 100)
    Else
        hp = hp + thePlayer.levelFp
    End If
    hp = Int(hp)
    Call setIndependentVariable(thePlayer.fightVar$, CStr(hp))

    'smp up:
    aa = getIndependentVariable(thePlayer.smMaxVar$, l$, hp)
    If thePlayer.charLevelUpType = 0 Then
        hp = hp + ((hp - equipSMadd(num)) * thePlayer.levelSm / 100)
    Else
        hp = hp + thePlayer.levelSm
    End If
    hp = Int(hp)
    Call setIndependentVariable(thePlayer.smMaxVar$, CStr(hp))

    Dim h As String
    h$ = getPlayerName(thePlayer) + ": "
    
    Dim retval As RPGCODE_RETURN
    Dim thePrg As RPGCodeProgram
    Call InitRPGCodeProcess(thePrg)
    thePrg.boardNum = -1     'not attached to the board
    
    Call CanvasGetScreen(cnvRPGCodeScreen)
    lineNum = 1
    Call AddToMsgBox(h & " " + LoadStringLoc(2047, "Level Up!"), thePrg)
    Call renderRPGCodeScreen
    Call WaitForKey
End Sub

Function getPlayerMaxHP(ByRef thePlayer As TKPlayer) As Double
    'gets the max HP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.maxHealthVar$, l$, stat)
    getPlayerMaxHP = stat
End Function

Function getPlayerSMP(ByRef thePlayer As TKPlayer) As Double
    'gets the SMP of player
    On Error Resume Next

    Dim stat As Double, l As String, a As Long
    a = getIndependentVariable(thePlayer.smVar$, l$, stat)
    getPlayerSMP = stat
End Function

Function getPlayerIndex(ByVal handle As String) As Long
    'convert a player handle to a player index into playerListAr
    'returns -1 if not found
    On Error Resume Next
    Dim theOne As Long, t As Long
    theOne = -1
    For t = 0 To 4
        If UCase$(playerListAr$(t)) = UCase$(handle) Then
            theOne = t
            Exit For
        End If
    Next t
    getPlayerIndex = theOne
End Function

Sub addPlayerHP(ByVal amount As Double, ByRef thePlayer As TKPlayer)
    'add to player's hp
    On Error Resume Next
    
    Dim hp As Double, maxHP As Double
    hp = getPlayerHP(thePlayer)
    
    hp = hp + amount
    Call setPlayerHP(hp, thePlayer)
End Sub

Sub addPlayerSMP(ByVal amount As Double, ByRef thePlayer As TKPlayer)
    'add to player's smp
    On Error Resume Next
    
    Dim smp As Double, maxSMP As Double
    smp = getPlayerSMP(thePlayer)
    
    smp = smp + amount
    Call setPlayerSMP(smp, thePlayer)
End Sub

Sub setPlayerHP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's hp
    On Error Resume Next
    
    Dim max As Double
    max = getPlayerMaxHP(thePlayer)
    If stat > max Then
        stat = max
    End If
    If stat < 0 Then
        stat = 0
    End If
    
    Call setIndependentVariable(thePlayer.healthVar$, CStr(stat))
End Sub

Sub setPlayerSMP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's smp
    On Error Resume Next
    
    Dim max As Double
    max = getPlayerMaxSMP(thePlayer)
    If stat > max Then
        stat = max
    End If
    If stat < 0 Then
        stat = 0
    End If
    
    Call setIndependentVariable(thePlayer.smVar$, CStr(stat))
End Sub

Sub setPlayerDP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's dp
    On Error Resume Next
    
    Call setIndependentVariable(thePlayer.defenseVar$, CStr(stat))
End Sub

Sub setPlayerFP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's fp
    On Error Resume Next
    
    Call setIndependentVariable(thePlayer.fightVar$, CStr(stat))
End Sub

Sub setPlayerMaxHP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's max hp
    On Error Resume Next
    
    Call setIndependentVariable(thePlayer.maxHealthVar$, CStr(stat))
End Sub

Sub setPlayerMaxSMP(ByVal stat As Double, ByRef thePlayer As TKPlayer)
    'set player's max smp
    On Error Resume Next
    
    Call setIndependentVariable(thePlayer.smMaxVar$, CStr(stat))
End Sub

