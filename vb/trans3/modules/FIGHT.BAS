Attribute VB_Name = "FIGHT"
Global numEne   'number of enemies
Global enemies$(3)  'filenames of each of the 4 enemies
Global canrun   'can we run? 0-no, 1-yes
Global currentc 'current character 0-4
Global notch    'color shade of blinking text
Global updown   'color blink current going down(0) or up(1)
Global meenumode 'fight menu mode.
                '0-outermost, 1-fight person, 2- unused, 3- item, 4- selected person with item, 5- special move menu, 6- which person to hit with special move
Global eneCharge(3) 'current charge of enemies 0-3.  100 means let's make a move
Global playerCharge(4)  'current charge of players
Global queue(30)    'queue of players waiting to make their moves.
Global eneX(3)  'x location of enemy.
Global eneY(3)  'y location

Global battleOver   'is battle over? 0- no, 1-yes

Global ignoreit     'ignore menu selection? 1- yes, 0-no.
Global cselecteditem 'which item is selected.
Global cselectedmove 'which move is selected.

Global oldmusic$    'music that was playing before fight

Global programsWin$(3)  'programs to run when you win
Global expWin       'total experience you get when you win
Global gpWin        'total gp you get when you win

Global oldtopX, oldtopY     'old x and y top coords.


'''''''''''''status effect info...
'for enemies...
Global enemyStatus$(10, 3) 'filenames of status effects for each enemy (up to 11 per)
Global enemyStatusRound(10, 3) As Integer 'round of each enemy status
Global enemyChargeIncr(3) As Integer   'increment for enemy charge (defines speed)
Global enemyStop(3) As Boolean      'stopped YN
'for players...
Global playerStatus$(10, 4) 'filenames of statuses for each player (up to 11 per)
Global playerStatusRound(10, 4) As Integer 'round of each enemy status
Global playerChargeIncr(4) As Integer   'increment for enemy charge (defines speed)
Global playerStop(4) As Boolean     'stopped YN

Global fromProgram  'battle intitated from program YN (0=no, 1=yes)

Global fwOffsetX    'fight window x offset
Global fwOffsetY    'fight window offset y

Global bGaveReward As Boolean   'have we given the players their reward at the end of the battle for this fight yet?

Sub animateOverEnemy(file$, eenum)
    'open animation file$, and animate over top of
    'enemy number eenum
    'figure out x and y coords of enemy...
    On Error GoTo errorhandler
    Call openAnimation(projectPath$ + miscPath$ + file$, animationMem)
    x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
    y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
    x1 = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
    y1 = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
    xc = (Abs(x2 - x1) / 2) + x1
    yc = (Abs(y2 - y1) / 2) + y1
    xx = xc - (animationMem.animSizeX / 2)
    yy = yc - (animationMem.animSizeY / 2)
    
    Call TransAnimateAt(xx, yy)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub animateOverPlayer(file$, num)
    'animate over player graphic
    'open animation file$, and animate over top of
    'player number num
    'figure out x and y coords of player...
    On Error GoTo errorhandler
    Call openAnimation(projectPath$ + miscPath$ + file$, animationMem)
    
    'Now display the Hit text
    If mainMem.fightStyle = 0 Then
        y = num + 3 + fwOffsetY
        If num Mod 2 = 1 Then x = 19 + fwOffsetX Else x = 18 + fwOffsetX
    End If
    If mainMem.fightStyle = 1 Then
        y = 11 + fwOffsetY
        x = 3 * num + 4 + fwOffsetX
    End If
    xx = x * 32 - 32
    yy = y * 32 - 32
    xc = xx + 16
    yc = yy + 16
    
    xx = xc - (animationMem.animSizeX / 2)
    yy = yc - (animationMem.animSizeY / 2)
    Call TransAnimateAt(xx, yy)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub animateTopCornerEnemy(file$, eenum)
    'open animation file$, and animate over top corner of
    'enemy number eenum
    'figure out x and y coords of enemy...
    On Error GoTo errorhandler
    Call openAnimation(projectPath$ + miscPath$ + file$, animationMem)
    'x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
    'y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
    'x1 = (eneX(eenum) + fwOffsetX - eneSizeX(eenum)) * 32 - 32
    'y1 = (eneY(eenum) + fwOffsetY - eneSizeY(eenum)) * 32 - 32
    'xc = (Abs(x2 - x1) / 2) + x1
    'yc = (Abs(y2 - y1) / 2) + y1
    'xx = xc - (animSizeX / 2)
    'yy = yc - (animSizeY / 2)
    
    xx = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
    yy = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
    Call TransAnimateAt(xx, yy)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub CacheScreenFrom(pic As PictureBox)
    'cache entire screen from cache defined by pic
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    'a = BitBlt(vbpichdc(mainForm.boardform), _
             0, _
             0, _
             tilesX * 32 * ddx, _
             tilesY * 32 * ddy, _
             vbPicHDC(pic), _
             0, _
             0, _
             &HCC0020)
    a = BitBlt(vbPicHDC(mainForm.boardform), _
             0, _
             0, _
             tilesX * 32, _
             tilesY * 32, _
             vbPicHDC(pic), _
             0, _
             0, _
             &HCC0020)
    Call vbPicRefresh(mainForm.boardform)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CacheScreenTo(dc As Long)
    'cache entire screen into cache defined by pic
    On Error GoTo errorhandler
    'pic.AutoRedraw = True
    'a = BitBlt(vbPicHDC(pic), _
             0, _
             0, _
             tilesX * 32 * ddx, _
             tilesY * 32 * ddy, _
             vbpichdc(mainForm.boardform), _
             0, _
             0, _
             &HCC0020)
    a = BitBlt(dc, _
             0, _
             0, _
             tilesX * 32, _
             tilesY * 32, _
             vbPicHDC(mainForm.boardform), _
             0, _
             0, _
             &HCC0020)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub calcFightWindowOffset()
    'calculate the fighting window offsets.
    'fight window is always 19x11
    On Error GoTo errorhandler
    fwOffsetX = Int((tilesX - 19) / 2)
    fwOffsetY = Int((tilesY - 11) / 2)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub determineSpecialMoves(handle$, filelist$())
    'determines which special moves this player can do.
    'this fills up the array passed in with the filenames of the moves you can do.
    On Error Resume Next
    cnum = -1
    'figure out which char it is:
    For t = 0 To 4
        If UCase$(playerListAr$(t)) = UCase$(handle$) Then cnum = t
    Next t
    If cnum = -1 Then Exit Sub
    'Now figure out which move it is:
    theMove = -1
    cnt = 0
    For t = 0 To 200
        Ignore = 0
        If playerMem(cnum).smlist$(t) <> "" Then
            'Now check if the player can use it yet:
            'First check exp.
            a = GetVariable(playerMem(cnum).experienceVar$, l$, expl)
            If expl >= playerMem(cnum).spcMinExp(t) Then
                theMove = theMove + 1
                Ignore = 1
                'If themove = num Then
                    filelist$(cnt) = playerMem(cnum).smlist$(t)
                    cnt = cnt + 1
                'End If
            End If
            
            If Ignore <> 1 Then
                'now check level
                a = GetVariable(playerMem(cnum).leVar$, l$, lev)
                If lev >= playerMem(cnum).spcMinLevel(t) Then
                    theMove = theMove + 1
                    Ignore = 1
                    'If themove = num Then
                        filelist$(cnt) = playerMem(cnum).smlist$(t)
                        cnt = cnt + 1
                    'End If
                End If
            End If
            
            If Ignore <> 1 Then
                'now check conditioned var
                If playerMem(cnum).spcVar$(t) <> "" Then
                    a = GetVariable(playerMem(cnum).spcVar$(t), txt$, nn)
                    If a = 0 Then
                        'numerical
                        If nn = val(playerMem(cnum).spcEquals$(t)) Then
                            theMove = theMove + 1
                            'If themove = num Then
                                filelist$(cnt) = playerMem(cnum).smlist$(t)
                                cnt = cnt + 1
                            'End If
                        End If
                    End If
                    If a = 1 Then
                        'literal
                        If txt$ = playerMem(cnum).spcEquals$(t) Then
                            theMove = theMove + 1
                            'If themove = num Then
                                filelist$(cnt) = playerMem(cnum).smlist$(t)
                                cnt = cnt + 1
                            'End If
                        End If
                    End If
                End If
            End If
        End If
    Next t
End Sub

Sub displayfighttext2(text$, x, y, col)
    'displays text on the fight screen for
    On Error GoTo errorhandler

    'First, copy existing image into buffer:
    'allPurposeCanvas = CreateCanvas(tilesX * 32, tilesY * 32)
        Call SetCanvasSize(allPurposeCanvas, tilesX * 32, tilesY * 32)
    a = BitBlt(CanvasHDC(allPurposeCanvas), 0, 0, 100, 100, vbPicHDC(mainForm.boardform), (x * 16 - 16), (y * 16 - 16), &HCC0020)
    Call CanvasRefresh(allPurposeCanvas)
    
    'Now, display text:
    Call vbPicAutoRedraw(mainForm.boardform, True)
    oldbold = bold
    bold = 1
    Call puttext(text$, x, y, col, 16, 16, vbPicHDC(mainForm.boardform))
    Call vbPicRefresh(mainForm.boardform)
    bold = oldbold
    'DoEvents

    Call vbPicAutoRedraw(mainForm.boardform, True)
    'Now remove text:
    a = BitBlt(vbPicHDC(mainForm.boardform), (x * 16 - 16), (y * 16 - 16), 100, 100, CanvasHDC(allPurposeCanvas), 0, 0, &HCC0020)
    Call vbPicRefresh(mainForm.boardform)
    
    'Call DestroyCanvas(allPurposeCanvas)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function didIWin() As Boolean
    'check if the players have won.
    On Error GoTo errorhandler
    total = 0
    For t = 0 To numEne - 1
        If enemyMem(t).eneHP <= 0 Then total = total + 1
    Next t
    If total = numEne Then
        didIWin = True
        Exit Function
    End If
    didIWin = False
    Exit Function

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub fightfade()
    'fades screen out for fight.
    On Error GoTo errorhandler
    Call Fade("#Fade(2)")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fightMnu(nn)
    'select who to fight
    On Error Resume Next
    If ignoreit = 1 Then ignoreit = 0: Exit Sub
    If nn = 0 Then
        '<-back
        meenumode = 0
        fightmenu.action.Clear
        fightmenu.action.AddItem LoadStringLoc(902, "Fight")
        fightmenu.action.AddItem LoadStringLoc(903, "Item")
        If playerMem(currentc).smYN = 0 Then
            fightmenu.action.AddItem playerMem(currentc).specialMoveName$
        End If
        If canrun = 1 Then
            fightmenu.action.AddItem LoadStringLoc(904, "Run")
        End If
        fightmenu.action.ListIndex = 0
        Exit Sub
    End If
    'Now figure out *who* was selected.
    If nn <> 0 Then
        'First, swipe that sword!!!
        Call swipeSword(currentc)
        Call standErect(currentc)
        theone = nn
        If theone <= aliveEnemies() Then
            'it was an enemy
            theone = theone - 1
            theone = livingEnemy(theone)
            
            'check left hand
            If playerEquip$(3, currentc) <> "" Then
                Call openitem(projectPath$ + itmpath$ + playerEquip$(3, currentc), itemMem(11))
                'run animation if it is there...
                If (itemMem(11).itmAnimation$ <> "") Then
                    Call animateOverEnemy(itemMem(11).itmAnimation$, theone)
                End If
            End If
            'check right hand
            If playerEquip$(4, currentc) <> "" Then
                Call openitem(projectPath$ + itmpath$ + playerEquip$(4, currentc), itemMem(11))
                'run animation if it is there...
                If (itemMem(11).itmAnimation$ <> "") Then
                    Call animateOverEnemy(itemMem(11).itmAnimation$, theone)
                End If
            End If
            
            'calculate hit points:
            pFP = getFP(playerListAr$(currentc))
            'check if we got lucky
            r = Int(Rnd(1) * enemyMem(theone).eneSneakChances) + 1
            If r <> Int(enemyMem(theone).eneSneakChances / 2) Then
                eDP = enemyMem(theone).eneDP
            End If
            If eDP > pFP Then eDP = pFP - 1
            pFP = pFP - eDP
            Call removeEnemyHP(theone, pFP)
            'also... if the character has an item equipped,
            'maybe it has a program to go along with it...
            
            'check left hand
            If playerEquip$(3, currentc) <> "" Then
                Call openitem(projectPath$ + itmpath$ + playerEquip$(3, currentc), itemMem(11))
                If itemMem(11).FightYN = 1 Then
                    'it is a fight item
                    If itemMem(11).fgtUse$ <> "" Then
                        'run program:
                        target = theone
                        targetType = 2
                        Source = currentc
                        sourceType = 0
                        Call runfightprogram(projectPath$ + prgpath$ + itemMem(11).fgtUse$, 0, 0)
                    End If
                    'calculate hit points:
                    pFP = itemMem(11).fgtHPup * -1
                    Call removeEnemyHP(theone, pFP)
                    pSM = itemMem(11).fgtSMup * -1
                    If pSM <> 0 Then Call removeEnemySMP(theone, pSM)
                    'end of turn
                End If
            End If
            'check right hand
            If playerEquip$(4, currentc) <> "" Then
                Call openitem(projectPath$ + itmpath$ + playerEquip$(4, currentc), itemMem(11))
                If itemMem(11).FightYN = 1 Then
                    'run animation if it is there...
                    If (itemMem(11).itmAnimation$ <> "") Then
                        Call animateOverEnemy(itemMem(11).itmAnimation$, theone)
                    End If
                    'it is a fight item
                    If itemMem(11).fgtUse$ <> "" Then
                        'run program:
                        target = theone
                        targetType = 2
                        Source = currentc
                        sourceType = 0
                        Call runfightprogram(projectPath$ + prgpath$ + itemMem(11).fgtUse$, 0, 0)
                    End If
                    'calculate hit points:
                    pFP = itemMem(11).fgtHPup * -1
                    Call removeEnemyHP(theone, pFP)
                    pSM = itemMem(11).fgtSMup * -1
                    If pSM <> 0 Then Call removeEnemySMP(theone, pSM)
                    'end of turn
                End If
            End If
            'end of turn
            Call endOfTurn
        Else
            'it was a character (stupid!!!)
            theone = theone - aliveEnemies() - 1
            'calculate hit points:
            pFP = getFP(playerListAr$(currentc))
            eDP = getDP(playerListAr$(theone))
            If eDP > pFP Then eDP = pFP - 1
            pFP = pFP - eDP
            Call removePlayerHP(theone, pFP)
            'end of turn
            Call endOfTurn
        End If
    End If
End Sub

Sub fillActionItems()
    'fill action window with items you can use.
    On Error GoTo errorhandler

    fightmenu.action.Clear
    'fightmenu.action.AddItem ("")
    fightmenu.action.AddItem (LoadStringLoc(905, "<-Back"))
    num = 0
    For t = 0 To 500
        ItemMap(t) = 0
        If inventory$(t) <> "" And NumberItem(t) > 0 Then
            hand$ = itemListAr$(t)
            hand$ = hand$ + " x" + str$(NumberItem(t))
            fightmenu.action.AddItem (hand$)
            ItemMap(num) = t
            num = num + 1
        End If
    Next t
    fightmenu.action.ListIndex = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fillActionMoves()
    'fill action window with special moves you can use.
    'screenNum is the 'screen number' to fill
    'the toolkit will fill the selecteion box 20 special moves at a time.
    'if screenNum=0, it will fill from 0 to 20.  If 1, it fills 21 to 40, etc...
    On Error GoTo errorhandler
    fightmenu.action.Clear
    fightmenu.action.AddItem (LoadStringLoc(905, "<-Back"))
    ReDim namelist$(400)
    Call determineSpecialMoves(playerListAr$(currentc), namelist$)
    For t = 0 To 200
        't = 2
        F$ = namelist$(t)
        If F$ <> "" Then
            Call openspecialmove(projectPath$ + spcpath$ + F$, specialMoveMem)
            hand$ = specialMoveMem.smname$
            hand$ = hand$ + " -" + str$(specialMoveMem.smSMP)
            namelist$(cnt) = hand$
            fightmenu.action.AddItem (namelist$(t))
            cnt = cnt + 1
            'a = DoEvents
        Else
            Exit Sub
            fightmenu.action.ListIndex = 0
        End If
        F$ = ""
    Next t
    Exit Sub
    fightmenu.action.ListIndex = 0
    
    'cnt = 0
    'For t = 0 To 200
    '    't = 2
    '    f$ = getMoveenumber(playerListAr$(currentc), t)
    '    'MsgBox f$ + Str$(t)
    '    If f$ <> "" Then
    '        Call openSpecialMove(projectPath$ + spcpath$ + f$)
    '        hand$ = smName$
    '        hand$ = hand$ + " -" + Str$(smSMP)
    '        namelist$(cnt) = hand$
    '        fightmenu.action.AddItem (namelist$(t))
    '        cnt = cnt + 1
    '        'a = DoEvents
    '    End If
    '    f$ = ""
    'Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fillActionToHit()
    'fills action window with players to hit.
    On Error GoTo errorhandler
        fightmenu.action.Clear
        'fightmenu.action.AddItem ("")
        fightmenu.action.AddItem (LoadStringLoc(905, "<-Back"))
        For t = 0 To numEne - 1
            If enemyMem(t).eneHP > 0 Then
                fightmenu.action.AddItem (enemyMem(t).eneName$)
            End If
        Next t
        For t = 0 To 4
            If playerListAr$(t) <> "" Then
                n$ = getName(playerListAr$(t))
                fightmenu.action.AddItem (n$)
            End If
        Next t
        fightmenu.action.ListIndex = 0


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fillActionToMove()
    'fills action window with players to hit.
    On Error GoTo errorhandler
        fightmenu.action.Clear
        'fightmenu.action.AddItem ("")
        fightmenu.action.AddItem (LoadStringLoc(905, "<-Back"))
        For t = 0 To numEne - 1
            If enemyMem(t).eneHP > 0 Then
                fightmenu.action.AddItem (enemyMem(t).eneName$)
            End If
        Next t
        For t = 0 To 4
            If playerListAr$(t) <> "" Then
                n$ = getName(playerListAr$(t))
                fightmenu.action.AddItem (n$)
            End If
        Next t
        fightmenu.action.ListIndex = 0


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function findWeakestPlayer()
    'returns the number of the weakest player.
    'here's how it works:
    'take hp of each player and add dp to that number
    'then divide that number by max HP.
    'the lowest is the weakest.
    On Error GoTo errorhandler

    ReDim Values(4)

    For t = 0 To 4
        Values(t) = 0
        If playerListAr$(t) <> "" Then
            hp = getHP(playerListAr$(t))
            'ignore the dead:
            If hp > 0 Then
                dp = getDP(playerListAr$(t))
                hp = hp + dp
                maxhp = getMaxHP(playerListAr$(t))
                Percent = (hp / maxhp) * 100
                Values(t) = Int(Percent)
            End If
        End If
    Next t

    'now check the values array to see which is the lowest.
    Lowesta = 1000000000000#
    lowestperson = 0
    For t = 0 To 4
        'ignore the dead.
        If Values(t) <> 0 Then
            If Values(t) <= Lowesta Then
                lowestperson = t
                Lowesta = Values(t)
            End If
        End If
    Next t
    findWeakestPlayer = lowestperson

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub fitV14Enemy(eenum)
    'fits a version 1.4 enemy into the proper size.
    On Error GoTo errorhandler
    ReDim eneback$(19, 7)
    For x = 1 To 19
        For y = 1 To 7
            eneback$(x, y) = enemyMem(eenum).enemyGraphic$(x, y)
            enemyMem(eenum).enemyGraphic$(x, y) = ""
        Next y
    Next x
    'count leading x whitespace.
    x1 = 1
    For x = 1 To 19
        For y = 1 To 7
            If eneback$(x, y) <> "" Then
                y = 7
                x = 19
            End If
        Next y
        If x <> 19 Then x1 = x1 + 1
    Next x
    'count trailing x whitespace.
    x2 = 19
    For x = 19 To 1 Step -1
        For y = 1 To 7
            If eneback$(x, y) <> "" Then
                y = 7
                x = 1
            End If
        Next y
        If x <> 1 Then x2 = x2 - 1
    Next x
    'count leading y whitespace.
    y1 = 1
    For y = 1 To 7
        For x = 1 To 19
            If eneback$(x, y) <> "" Then
                y = 7
                x = 19
            End If
        Next x
        If y <> 7 Then y1 = y1 + 1
    Next y
    'count trailing y whitespace.
    y2 = 7
    For y = 7 To 1 Step -1
        For x = 1 To 19
            If eneback$(x, y) <> "" Then
                y = 1
                x = 19
            End If
        Next x
        If y <> 1 Then y2 = y2 - 1
    Next y
    'MsgBox Str$(x1) + "," + Str$(y1) + " x " + Str$(x2) + "," + Str$(y2)
    enemyMem(eenum).eneSizeX = x2 - x1
    enemyMem(eenum).eneSizeY = y2 - y1
    xx = 1: yy = 1
    For x = x1 + 1 To x2 + 1
        For y = y1 To y2
            enemyMem(eenum).enemyGraphic$(xx, yy) = eneback$(x, y)
            yy = yy + 1
        Next y
        yy = 1
        xx = xx + 1
    Next x

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub flashEnemy(eenum)
    'causes selected enemy to flash, showing
    'that he is making a move.
    On Error Resume Next
    
    'quick draw the enemy by flashing it...
    ChDir (projectPath$)
    fn$ = enemyMem(eenum).eneFileName$
    fn$ = nopath(fn$)
    fn$ = enepath$ + fn$
    
    xx = eneX(eenum)
    yy = eneY(eenum)
    
    xx = xx - enemyMem(eenum).eneSizeX
    yy = yy - enemyMem(eenum).eneSizeY
    Call vbPicAutoRedraw(mainForm.boardform, True)
    For tt = 40 To 200 Step 40
        If PakFileRunning Then
            Call ChangeDir(PakTempPath)
            a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, 0, 0, vbPicHDC(mainForm.boardform))
            Call vbPicRefresh(mainForm.boardform)
            Call ChangeDir(currentdir$)
        Else
            a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, 0, 0, vbPicHDC(mainForm.boardform))
            Call vbPicRefresh(mainForm.boardform)
        End If
        'DoEvents
    Next tt
    For tt = 160 To 0 Step -40
        If PakFileRunning Then
            Call ChangeDir(PakTempPath)
            a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, 0, 0, vbPicHDC(mainForm.boardform))
            Call vbPicRefresh(mainForm.boardform)
            Call ChangeDir(currentdir$)
        Else
            a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, 0, 0, vbPicHDC(mainForm.boardform))
            Call vbPicRefresh(mainForm.boardform)
        End If
        'DoEvents
    Next tt
        
        'theCommand$ = "brddraw.exe " + Str$(vbpichdc(mainForm.boardform)) + " " + getshortname(fn$) + " " + Str$(x) + Str$(y) + Str$(resx) + Str$(resy)
        'a = Shell(theCommand$)
    ChDir (currentdir$)

    'Now wait for some time
    ti = 1
    aa = Timer
    te = 0
    Do While te < ti
        'DoEvents
        bb = Timer
        te = bb - aa
    Loop

End Sub

Sub GameOver()
    '#Over()
    'Game over
    On Error GoTo errorhandler
    Call Over
    'Unload fightmenu
    'oldsize = fontsize
    'oldcol = fontcolor
    'fontsize = 25
    'fontcolor = vbqbcolor(15)
    'Call Fade("#Fade(1)")    'Fadeout
    'Call TextRPG("#Text(1, 1, " + Chr$(34) + "      -Game Over-" + Chr$(34))
    'fontsize = oldsize
    'fontcolor = oldcol
    'aa$ = WaitForKey()
    'Call ResetRPG

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function getDP(handle$)
    'gets the DP of player 'handle'
    On Error GoTo errorhandler
    theone = -1
    For t = 0 To 4
        If UCase$(playerListAr$(t)) = UCase$(handle) Then theone = t
    Next t
    If theone = -1 Then
        getDP = 0
        Exit Function
    End If
    hp = GetVariable(playerMem(theone).defenseVar$, l$, hishp)
    getDP = hishp

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function getEnemy(eSkill)
    'randomly selects an enemy of skill *skill*
    'and returns a filename.
    'Returns NO ENEMIES if not found.
    On Error GoTo errorhandler
    
    'count the possibilities:
    total = 0
    For t = 0 To 500
        If mainMem.skill(t) = eSkill Then total = total + 1
    Next t
    If total = 0 Then
        getEnemy = "NO ENEMIES"
        Exit Function
    End If
    
    'Now get the nth enemy of that skill:
    whichone = Int(Rnd(1) * total) + 1
    thisone = 0
    For t = 0 To 500
        If mainMem.skill(t) = eSkill Then
            thisone = thisone + 1
            If thisone = whichone Then
                a$ = mainMem.enemy$(t)
                b$ = FindFile(projectPath$ + enepath$ + a$)
                b$ = PakLocate(b$)
                res = fileExist(b$)
                If res = 1 Then
                    getEnemy = mainMem.enemy$(t)
                    Exit Function
                End If
            End If
        End If
    Next t
    getEnemy = "NO ENEMIES"

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function getMoveenumber(handle$, num)
    'returns filename of the num th special move (starting at 0)
    'the player can do.
    On Error GoTo errorhandler
    getMoveenumber = ""
    If num > 200 Then Exit Function
    cnum = -1
    'figure out which char it is:
    For t = 0 To 4
        If UCase$(playerListAr$(t)) = UCase$(handle$) Then cnum = t
    Next t
    If cnum = -1 Then Exit Function
    'Now figure out which move it is:
    theMove = -1
    For t = 0 To 200
        Ignore = 0
        If playerMem(cnum).smlist$(t) <> "" Then
            'Now check if the player can use it yet:
            'First check exp.
            a = GetVariable(playerMem(cnum).experienceVar$, l$, expl)
            If expl >= playerMem(cnum).spcMinExp(t) Then
                theMove = theMove + 1
                Ignore = 1
                If theMove = num Then
                    getMoveenumber = playerMem(cnum).smlist$(t)
                    Exit Function
                End If
            End If
            
            If Ignore <> 1 Then
                'now check level
                a = GetVariable(playerMem(cnum).leVar$, l$, lev)
                If lev >= playerMem(cnum).spcMinLevel(t) Then
                    theMove = theMove + 1
                    Ignore = 1
                    If theMove = num Then
                        getMoveenumber = playerMem(cnum).smlist$(t)
                        Exit Function
                    End If
                End If
            End If
            
            If Ignore <> 1 Then
                'now check conditioned var
                If playerMem(cnum).spcVar$(t) <> "" Then
                    a = GetVariable(playerMem(cnum).spcVar$(t), txt$, nn)
                    If a = 0 Then
                        'numerical
                        If nn = val(playerMem(cnum).spcEquals$(t)) Then
                            theMove = theMove + 1
                            If theMove = num Then
                                getMoveenumber = playerMem(cnum).smlist$(t)
                                Exit Function
                            End If
                        End If
                    End If
                    If a = 1 Then
                        'literal
                        If txt$ = playerMem(cnum).spcEquals$(t) Then
                            theMove = theMove + 1
                            If theMove = num Then
                                getMoveenumber = playerMem(cnum).smlist$(t)
                                Exit Function
                            End If
                        End If
                    End If
                End If
            End If
        End If
    Next t

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub givePlayersExp(amount)
    On Error GoTo errorhandler
    For t = 0 To 4
        If playerListAr$(t) <> "" Then
            If getHP(playerListAr$(t)) <> 0 Then
                Call giveExperience(t, amount)
            End If
        End If
    Next t
    Dim retval As RPGCODE_RETURN
    vv = DoCommand("#Mwincls()", 0, 0, 0, retval)
    'Call MWinClsRPG("")
    text$ = "#Mwin(" + Chr$(34) + LoadStringLoc(2045, "Players gained") + str$(amount) + " " + LoadStringLoc(1604, "Experience") + "!" + Chr$(34) + ")"
    vv = DoCommand(text$, 0, 0, 0, retval)
    'Call AddToMsgBox(text$)
    a$ = WaitForKey()
    vv = DoCommand("#Mwincls()", 0, 0, 0, retval)
    'Call MWinClsRPG("")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub givePlayersGP(amount)
    'give them gp
    On Error GoTo errorhandler
    
    Dim retval As RPGCODE_RETURN
    vv = DoCommand("#Mwincls()", 0, 0, 0, retval)
    'Call MWinClsRPG("")
    
    text$ = "#Mwin(" + Chr$(34) + LoadStringLoc(2045, "Players gained") + str$(amount) + LoadStringLoc(2046, " GP!") + Chr$(34) + ")"
    vv = DoCommand(text$, 0, 0, 0, retval)
    
    'text$ = "Players gained" + Str$(amount) + " GP!"
    'Call AddToMsgBox(text$)
    a$ = WaitForKey()
    vv = DoCommand("#Mwincls()", 0, 0, 0, retval)
    'Call MWinClsRPG("")
    GPCount = GPCount + amount

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function haveEnemyStatus(pnum, han$)
    'scan enemy statuses and checks if we have status han$('handle')
    On Error GoTo errorhandler
    For t = 0 To 10
        If enemyStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + enemyStatus$(t, pnum), statusMem)
            If UCase$(han$) = UCase$(statusMem.statusName$) Then
                haveEnemyStatus = True
                Exit Function
            End If
        End If
    Next t
    haveEnemyStatus = False

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function havePlayerStatus(pnum, han$) As Boolean
    'scan player statuses and checks if we have status han$('handle')
    On Error GoTo errorhandler
    For t = 0 To 10
        If playerStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + playerStatus$(t, pnum), statusMem)
            If UCase$(han$) = UCase$(statusMem.statusName$) Then
                havePlayerStatus = True
                Exit Function
            End If
        End If
    Next t
    havePlayerStatus = False

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function is14Enemy(eenum) As Boolean
    'returns t/f if enemy is 1.4 or not
    On Error Resume Next
    num = FreeFile
    file$ = enemyMem(eenum).eneFileName$
    If file$ = "" Then
        is14Enemy = False
        Exit Function
    End If
    file$ = FindFile(file$)
    'file$ = PakLocate(file$)
    Open file$ For Input As #num
        Input #1, fileheader$        'Filetype
    Close #num
    If UCase$(fileheader$) <> "RPGTLKIT ENEMY" Then
        is14Enemy = True
        Exit Function
    End If
    is14Enemy = False
End Function

Sub itemMenu(nn)
    'item menu selection.
    On Error GoTo errorhandler
    If ignoreit = 1 Then ignoreit = 0: Exit Sub
    If nn = 0 Then
        '<-back
        meenumode = 0
        fightmenu.action.Clear
        fightmenu.action.AddItem LoadStringLoc(902, "Fight")
        fightmenu.action.AddItem LoadStringLoc(903, "Item")
        If playerMem(currentc).smYN = 0 Then
            fightmenu.action.AddItem playerMem(currentc).specialMoveName$
        End If
        If canrun = 1 Then
            fightmenu.action.AddItem LoadStringLoc(904, "Run")
        End If
        fightmenu.action.ListIndex = 0
        Exit Sub
    End If
    'Now figure out *what* was selected.
    If nn > 0 Then
        theone = nn - 1
        theone = ItemMap(theone)
        file$ = inventory$(theone)
        If file$ <> "" Then
            Call openitem(projectPath$ + itmpath$ + file$, itemMem(11))
            If itemMem(11).FightYN = 1 Then
                'Now check if the player can use the item
                useIt = 0
                If itemMem(11).usedBy = 0 Then
                    useIt = 1
                Else
                    For tt = 0 To 50
                        If UCase$(itemMem(11).itmChars$(tt)) = UCase$(playerListAr$(currentc)) Then useIt = 1
                    Next tt
                End If
                If useIt = 1 Then
                    meenumode = 4
                    ignoreit = 1
                    cselecteditem = theone
                    Call fillActionToHit
                    Exit Sub
                Else
                    playWav (projectPath$ + mediapath$ + bkgCantDoWav$)
                    Call stopTimers
                    abc = MBox(LoadStringLoc(823, "This player cannot use this item!"), LoadStringLoc(824, "Use Item"), mb_ok, RGB(255, 255, 255), menuColor, projectPath$ + bmppath$ + mainMem.skinWindow$)
                    'MsgBox "This player cannot use this item!", , "Use Item"
                    Call startTimers
                End If
            Else
                playWav (projectPath$ + mediapath$ + bkgCantDoWav$)
                Call stopTimers
                abc = MBox(LoadStringLoc(825, "You cannot use this item during a fight!"), LoadStringLoc(824, "Use Item"), mb_ok, RGB(255, 255, 255), menuColor, projectPath$ + bmppath$ + mainMem.skinWindow$)
                'MsgBox "You cannot use this item during a fight!", , "Use Item"
                Call startTimers
            End If
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function livingEnemy(num)
    'returns the numth living enemy
    '(his number)
    On Error GoTo errorhandler
    eenum = -1
    For t = 0 To numEne - 1
        If enemyMem(t).eneHP > 0 Then eenum = eenum + 1
        If eenum = num Then
            livingEnemy = t
            Exit Function
        End If
    Next t

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub moveMenu(nn)
    'use special move
    On Error GoTo errorhandler
    If ignoreit = 1 Then ignoreit = 0: Exit Sub
    If nn = 0 Then
        '<-back
        meenumode = 0
        fightmenu.action.Clear
        fightmenu.action.AddItem LoadStringLoc(902, "Fight")
        fightmenu.action.AddItem LoadStringLoc(903, "Item")
        If playerMem(currentc).smYN = 0 Then
            fightmenu.action.AddItem playerMem(currentc).specialMoveName$
        End If
        If canrun = 1 Then
            fightmenu.action.AddItem LoadStringLoc(904, "Run")
        End If
        fightmenu.action.ListIndex = 0
        Exit Sub
    End If
    'Now figure out *what* was selected.
    If nn > 0 Then
        theone = nn - 1
        F$ = getMoveenumber(playerListAr$(currentc), theone)
        If F$ <> "" Then
            Call openspecialmove(projectPath$ + spcpath$ + F$, specialMoveMem)
            csm = getSMP(playerListAr$(currentc))
            If csm < specialMoveMem.smSMP Then
                playWav (projectPath$ + mediapath$ + bkgCantDoWav$)
                Call stopTimers
                abc = MBox(LoadStringLoc(826, "You don't have enough SMP to do that move!"), LoadStringLoc(827, "Special Move"), mb_ok, RGB(255, 255, 255), menuColor, projectPath$ + bmppath$ + mainMem.skinWindow$)
                'MsgBox "You don't have enough SMP to do that move!", , "Special Move"
                Call startTimers
                Exit Sub
            End If
            If specialMoveMem.smBattle = 1 Then
                playWav (projectPath$ + mediapath$ + bkgCantDoWav$)
                Call stopTimers
                abc = MBox(LoadStringLoc(828, "You can't use that item from a battle!"), LoadStringLoc(827, "Special Move"), mb_ok, RGB(255, 255, 255), menuColor, projectPath$ + bmppath$ + mainMem.skinWindow$)
                'MsgBox "You can't use that item from a battle!", , "Special Move"
                Call startTimers
                Exit Sub
            End If
            meenumode = 6
            ignoreit = 1
            cselectedmove = theone
            Call fillActionToMove
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function moveOrPhys()
    'decides whether to do a special move or physical
    'attack.
    '0- move, 1-phys
    On Error GoTo errorhandler
    a = Int(Rnd(1) * 3) + 1
    moveOrPhys = a - 1

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub outMenu(nn)
    'The outermost menu is selected.
    'nn is the item selected.
    On Error GoTo errorhandler
    If nn = 0 Then
        'fight!
        meenumode = 1    'select person for fight mode.
        ignoreit = 1
        Call fillActionToHit
        Exit Sub
    End If
    If nn = 1 Then
        'Item
        meenumode = 3
        ignoreit = 1
        Call fillActionItems
        Exit Sub
    End If
    If nn = 2 Then
        If playerMem(currentc).smYN = 0 Then
            'Special move
            meenumode = 5
            ignoreit = 1
            Call fillActionMoves
            Exit Sub
        Else
            Call tryRun
            Call endOfTurn
        End If
    End If
    If nn = 3 Then
        Call tryRun
        Call endOfTurn
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub playerFight(num)
    'lets player 'num' fight
    On Error GoTo errorhandler
    If battleOver = 1 Then Exit Sub
    hp = getHP(playerListAr$(num))
    If hp = 0 Then Call endOfTurn: Exit Sub
       
    fightmenu.characterscan.Enabled = False
    fightmenu.action.Enabled = True
    fightmenu.Command1.Enabled = True
    currentc = num
    'MsgBox Str$(num) + "la"
    fightmenu.playerbox(num).ForeColor = RGB(0, 255, 255)
    notch = 250
    updown = 0
    fightmenu.Timer1.Enabled = True
    fightmenu.action.Clear
    fightmenu.action.AddItem LoadStringLoc(902, "Fight")
    fightmenu.action.AddItem LoadStringLoc(903, "Item")
    If playerMem(num).smYN = 0 Then
        fightmenu.action.AddItem playerMem(num).specialMoveName$
    End If
    If canrun = 1 Then
        fightmenu.action.AddItem LoadStringLoc(904, "Run")
    End If
    fightmenu.action.ListIndex = 0
    'fightmenu.playerbox(num).ForeColor = RGB(0, 0, 0)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub playerQueue(num)
    'adds a player to the order queue.
    On Error GoTo errorhandler
    todo = -1
    For t = 0 To 30
        If queue(t) = -1 Then todo = t: t = 30
    Next t
    If todo = -1 Then Exit Sub
    queue(todo) = num
    playWav (projectPath$ + mediapath$ + bkgReadyWav$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub playWav(file$)
    'plays a wav file
    On Error GoTo errorhandler
    'file$ = FindFile(file$)
    file$ = PakLocate(file$)
    a = fileExist(file$)
    If a = 0 Then Exit Sub
    Dim iReturn As Integer
    
    'Make sure something was passed to the Play Function
    'If file$ <> "" Then
        'Make sure a WAV filename was passed
    '    iReturn = sndPlaySound(file$, 0)
    'End If
    'Wav file play successful
    
    ext$ = extention(file$)
    If UCase$(ext$) = "MP3" Then
        'Call PlaySoundFX(file$)
        
        Call ModPlugStop
        mp3.mp3.CloseMP3    'close mp3 file
        mp3.mp3.OpenMP3 (file$)
        mp3.mp3.PlayMP3
        Do While mp3.mp3.IsPlaying
            a = DoEvents
        Loop
        mp3.mp3.CloseMP3
    Else
        'iReturn = sndPlaySound(file$, 0)
        wFlags% = SND_ASYNC Or SND_NODEFAULT
        'xa = sndPlaySound(file$, wFlags%)
        'file$ = PakLocate(file$)
        
        'xa = sndPlaySound(file$, 0)
        Call PlaySoundFX(file$)
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub redrawEnemy(eenum)
    'redraw the enemy
    'causes selected enemy to flash, showing
    'that he is making a move.
    On Error Resume Next
    
    xx = eneX(eenum)
    yy = eneY(eenum)
    
    xx = xx - enemyMem(eenum).eneSizeX
    yy = yy - enemyMem(eenum).eneSizeY
    xx = xx + fwOffsetX
    yy = yy + fwOffsetY
    
    Call drawEnemy(xx, yy, eenum)
End Sub

Sub removeEnemy(eenum)
    'remove enemy from screen.
    On Error Resume Next
   
    If enemyMem(eenum).eneDieAnm$ = "" Then
        'just flash the enemy if no animation is used...
        'show enemy dying...
        ChDir (projectPath$)
        fn$ = enemyMem(eenum).eneFileName$
        fn$ = nopath(fn$)
        fn$ = enepath$ + fn$
        
        xx = eneX(eenum)
        yy = eneY(eenum)
        
        xx = xx - enemyMem(eenum).eneSizeX
        yy = yy - enemyMem(eenum).eneSizeY
        Call vbPicAutoRedraw(mainForm.boardform, True)
        For tt = 0 To -200 Step -40
            If PakFileRunning Then
                Call ChangeDir(PakTempPath)
                a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, tt, tt, vbPicHDC(mainForm.boardform))
                Call vbPicRefresh(mainForm.boardform)
                Call ChangeDir(currentdir$)
            Else
                a = GFXdrawEnemy(fn$, xx + fwOffsetX, yy + fwOffsetY, tt, tt, tt, vbPicHDC(mainForm.boardform))
                Call vbPicRefresh(mainForm.boardform)
            End If
        Next tt
        ChDir (currentdir$)
    Else
        'there's an animation!
        'first, remove the enemy from the screen...
        x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
        y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
        x1 = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
        y1 = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
        Call vbPicAutoRedraw(mainForm.boardform, True)
        Call copyFromBkgBuf(x1, y1, x2, y2, True)
    
        'now run the animation...
        Call animateTopCornerEnemy(enemyMem(eenum).eneDieAnm$, eenum)
        
        'now put the enemy back...
        'Call redrawEnemy(eenum)
    End If
    
    Call playWav(projectPath$ + mediapath$ + enemyMem(eenum).eneDieSound$)
    x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
    y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
    x1 = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
    y1 = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
    Call vbPicAutoRedraw(mainForm.boardform, True)
    Call copyFromBkgBuf(x1, y1, x2, y2, True)
    'mainForm.boardform.Line (x1 * ddx, y1 * ddy)-(x2 * ddx, y2 * ddy), vbqbcolor(0), BF

End Sub




Sub restoreBuffers()
    'puts player buffers back to normal
    On Error GoTo errorhandler
    For bufnum = 0 To 4
        Call vbPicAutoRedraw(mainForm.bufferform(bufnum), True)
        Call vbPicAutoRedraw(mainForm.bufferform(bufnum + 26), True)
        
        Call vbPicAutoRedraw(mainForm.buffermaskform(bufnum), True)
        Call vbPicAutoRedraw(mainForm.buffermaskform(bufnum + 26), True)
        If Not (bUseSpriteBufferCanvas) Then
            a = BitBlt(vbPicHDC(mainForm.bufferform(bufnum)), 0, 0, 64, 64, vbPicHDC(mainForm.bufferform(bufnum + 26)), x1, y1, &HCC0020)
            a = BitBlt(vbPicHDC(mainForm.buffermaskform(bufnum)), 0, 0, 64, 64, vbPicHDC(mainForm.buffermaskform(bufnum + 26)), x1, y1, &HCC0020)
        Else
            a = BitBlt(CanvasHDC(spriteBuffer(bufnum)), 0, 0, 64, 64, CanvasHDC(spriteBuffer(bufnum + 26)), x1, y1, &HCC0020)
        End If
    Next bufnum

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub restorecache()
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    'a = BitBlt(vbpichdc(mainForm.boardform), 0, 0, tilesX * 32 * ddx, tilesY * 32 * ddy, mainForm.cache.hdc, 0, 0, &HCC0020)
    a = BitBlt(vbPicHDC(mainForm.boardform), 0, 0, tilesX * 32, tilesY * 32, CanvasHDC(fightCacheCanvas), 0, 0, &HCC0020)
    Call CanvasRefresh(fightCacheCanvas)
    Call vbPicRefresh(mainForm.boardform)
    If Not (wentToNewBoard) Then
        topX = oldtopX: topY = oldtopY
    End If
    fightInProgress = False
    mainForm.Timer1.Enabled = True
    mainForm.animTimer.Enabled = True
    'call vbPicAutoRedraw(mainForm.boardform, true)
    'a = BitBlt(vbpichdc(mainForm.boardform), 0, 0, 19 * 32, 11 * 32, mainForm.cache.hdc, 0, 0, &HCC0020)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub runAway()
    'run away
    'first play the runaway programs...
    'plays program from enemy 0 only
    On Error GoTo errorhandler
    If enemyMem(0).eneRunPrg$ <> "" Then
        Call runfightprogram(projectPath$ + prgpath$ + enemyMem(0).eneRunPrg$, 0, 0)
    End If
    Call restoreBuffers
    boardList(activeBoardIndex).theData.boardMusic$ = oldmusic$
    battleOver = 1
    Unload fightmenu
    For t = 0 To 30
        queue(t) = -1
    Next t
    Call restorecache
    'force music check...
    Call checkMusic

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub runWinProgram()
    'runs the winning programs
    On Error GoTo errorhandler
    For t = 0 To 3
        If programsWin$(t) <> "" Then
            Call runfightprogram(projectPath$ + prgpath$ + programsWin$(t), 0, 0)
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function searchForMatch(file$, x, y, myx, myy, eenum)
    'Searches for a matching tile above x,y
    'returns -1 if not found, else 0.
    'changes myx, myy to new coords
    On Error GoTo errorhandler
If y > 1 Then
    For yy = 1 To y - 1
        For xx = 1 To enemyMem(eenum).eneSizeX
            If UCase$(enemyMem(eenum).enemyGraphic$(xx, yy)) = UCase$(file$) Then
                myx = xx
                myy = yy
                searchForMatch = 0
                Exit Function
            End If
        Next xx
    Next yy
End If
For xx = 1 To x - 1
    If UCase$(enemyMem(eenum).enemyGraphic$(xx, y)) = UCase$(file$) Then
        myx = xx
        myy = y
        searchForMatch = 0
        Exit Function
    End If
Next xx
searchForMatch = -1

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub showBackground(file$)
    'shows bkg file
    On Error GoTo errorhandler
    Call openBackground(file$)
    oldmusic$ = boardList(activeBoardIndex).theData.boardMusic$
    boardList(activeBoardIndex).theData.boardMusic$ = bkgMusic$
    If boardList(activeBoardIndex).theData.boardMusic$ = "" Then mediaContainer.OLE1.action = 10 'stop playing
    bWaitingForInput = False
    Call checkMusic
    Call drawBackground
    Call copyToBkgBuf

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub showEnemies()
    'draw enemies on screen.
    'assumes that they are already loaded into memory
    On Error GoTo errorhandler
    If mainMem.fightStyle = 0 Then
        'side view display
        num = 1: x = 2: y = 3
        For t = 0 To numEne - 1
            Call drawEnemy(x + fwOffsetX, y + fwOffsetY, t)
            eneX(t) = x + enemyMem(t).eneSizeX
            eneY(t) = y + enemyMem(t).eneSizeY
            If num Mod 2 = 1 Then
                x = x + enemyMem(t).eneSizeX + 2
            Else
                x = 2
                y = y + enemyMem(t).eneSizeY + 1
            End If
            num = num + 1
        Next t
    End If
    If mainMem.fightStyle = 1 Then
        'front view display
        num = 1: x = 5: y = 3
        For t = 0 To numEne - 1
            Call drawEnemy(x + fwOffsetX, y + fwOffsetY, t)
            eneX(t) = x + enemyMem(t).eneSizeX
            eneY(t) = y + enemyMem(t).eneSizeY
            If num Mod 2 = 1 Then
                x = x + enemyMem(t).eneSizeX + 3
            Else
                x = 5
                y = y + enemyMem(t).eneSizeY + 1
            End If
            num = num + 1
        Next t
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub showPlayers()
    'shows the players on the fight screen.
    On Error GoTo errorhandler
    If mainMem.fightStyle = 0 Then
        'side view
        For t = 0 To 4
            If playerListAr$(t) <> "" Then
                aa = (t + 1) Mod 2
                If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
                'Call CopyFromBuffer(xx, t + 3, t)
                hp = getHP(playerListAr$(t))
                If hp > 0 Then
                    Call putplayer(xx, (t + 3) + fwOffsetY, 1, t, 43)
                Else
                    'Player is dead.
                    Call putplayer(xx, (t + 3) + fwOffsetY, 1, t, 32)
                End If
            End If
        Next t
    End If
    If mainMem.fightStyle = 1 Then
        'side view
        For t = 0 To 4
            If playerListAr$(t) <> "" Then
                aa = (t + 1) Mod 2
                If aa = 1 Then yy = 9 + fwOffsetY Else yy = 9 + fwOffsetY
                xx = 3 * t + 4 + fwOffsetX
                'Call CopyFromBuffer(xx, t + 3, t)
                hp = getHP(playerListAr$(t))
                If hp > 0 Then
                    Call putplayer(xx, yy, 1, t, 43)
                    'not using at rest gfx.  just using posture.
                    'Call putplayer(xx, yy, 1, t, 9)
                Else
                    'Player is dead.
                    Call putplayer(xx, yy, 1, t, 32)
                End If
            End If
        Next t
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub showSM(num)
    'shows player num doing special move.
    On Error GoTo errorhandler
        Call vbPicAutoRedraw(mainForm.boardform, True)
        playWav (projectPath$ + mediapath$ + playerMem(num).smWav$)
        If mainMem.fightStyle = 0 Then
            'side
            aa = (num + 1) Mod 2
            If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
            yy = currentc + 3 + fwOffsetY
        End If
        If mainMem.fightStyle = 1 Then
            'front
            yy = 9 + fwOffsetY
            xx = 3 * num + 4 + fwOffsetX
        End If
        For tt = 21 To 24
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub showstats(Optional ByVal bCheckGameOver As Boolean = True)
    'Updates stats bar
    On Error GoTo errorhandler
    fightmenu.Show
    fightmenu.Timer1.Enabled = True
    fightmenu.Timer2.Enabled = True
    fightmenu.Timer3.Enabled = True
    fightmenu.enemybox.caption = ""
    For t = 0 To numEne - 1
        If enemyMem(t).eneHP > 0 Then
            fightmenu.enemybox.caption = fightmenu.enemybox.caption + enemyMem(t).eneName$ + Chr$(13)
        End If
    Next t

    For t = 0 To 4
        Call vbPicFillRect(fightmenu.hpbox(t), 0, 0, 100, 300, RGB(100, 100, 100))
        If playerListAr$(t) <> "" Then
            total$ = ""
            na = GetVariable(playerMem(t).nameVar$, hisname$, num)
            text$ = hisname$
            total$ = total$ + text$ + "    "
            'Hp
            hp = GetVariable(playerMem(t).healthVar$, l$, hishp)
            mhp = GetVariable(playerMem(t).maxHealthVar$, l$, hismaxhp)
            hpnow$ = removeChar(str$(hishp), " ")
            maxhpnow$ = removeChar(str$(hismaxhp), " ")
            text$ = "HP: " + hpnow$ + "/" + maxhpnow$
            total$ = total$ + text$ + "    "
            If val(maxhpnow$) <= 0 Then
                frac1 = 0
            Else
                frac1 = Int((val(hpnow$) / val(maxhpnow$)) * 100)
            End If
            If frac1 <> 0 Then
                For ll = 0 To frac1
                    Call vbPicLine(fightmenu.hpbox(t), ll, 0, ll, 100, RGB(255 - ll * 2.5, ll * 2.5, ll * 2.5))
                Next ll
            End If

            'Mp
            hp = GetVariable(playerMem(t).smVar$, l$, hissmp)
            mhp = GetVariable(playerMem(t).smMaxVar$, l$, hismaxsmp)
            smpnow$ = removeChar(str$(hissmp), " ")
            maxsmpnow$ = removeChar(str$(hismaxsmp), " ")
            text$ = "SMP: " + smpnow$ + "/" + maxsmpnow$
            If val(maxsmpnow$) <= 0 Then
                frac2 = 0
            Else
                frac2 = Int((val(smpnow$) / val(maxsmpnow$)) * 100)
            End If
            If frac2 <> 0 Then
                For ll = 0 To frac2
                    Call vbPicLine(fightmenu.hpbox(t), ll, 100, ll, 174, RGB(255 - ll * 2.5, ll * 2.5, 255))
                Next ll
            End If

            'charge:
            If playerCharge(t) <= 0 Then
                frac = 0
            Else
                frac = Int(playerCharge(t) / 100)
            End If
            If frac <> 0 Then
                For ll = 0 To frac
                    Call vbPicLine(fightmenu.hpbox(t), ll, 175, 11, 200, RGB(0, ll * 2.5, 255))
                Next ll
            End If
            
            
            total$ = total$ + text$ + Chr$(13)
            fightmenu.playerbox(t).caption = total$
        End If
    Next t
    Call checkWin
    If bCheckGameOver Then
        Call checkGameOver
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub standErect(num)
    'make player stand erect:
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    If mainMem.fightStyle = 0 Then
        'side view
        aa = (num + 1) Mod 2
        If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
        yy = num + 3 + fwOffsetY
    End If
    If mainMem.fightStyle = 1 Then
        'front view
        yy = 9 + fwOffsetY
        xx = 3 * num + 4 + fwOffsetX
    End If
    Call CopyFromBuffer(xx, yy, num, 43, vbPicHDC(mainForm.boardform), -1, False)
    Call putplayer(xx, yy, 1, num, 43)
    Call vbPicRefresh(mainForm.boardform)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub startFight()
    'The fight all takes place in here.
    'Assumes everything is initialized- enemy and players
    'are loaded and drawn onto screen.
    On Error GoTo errorhandler
    
    'starts the character scanner, which picks up on
    'a fighter who is ready.
    fightmenu.characterscan.Enabled = True
    fightmenu.action.Enabled = False
    fightmenu.Command1.Enabled = False
    Exit Sub

    'Done = 0
    For t = 0 To 4
        If playerListAr$(t) <> "" Then
            hp = getHP(playerListAr$(t))
            If hp > 0 Then
                Call playerFight(t)
                t = 4
            End If
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub startTimers()
    'start all fight timers.
    On Error GoTo errorhandler
    fightmenu.Timer1.Enabled = True
    fightmenu.Timer2.Enabled = True
    fightmenu.Timer3.Enabled = True
    fightmenu.Timer4.Enabled = True
    fightmenu.characterscan.Enabled = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub stopTimers()
    'stops all fight timers.
    On Error GoTo errorhandler
    fightmenu.Timer1.Enabled = False
    fightmenu.Timer2.Enabled = False
    fightmenu.Timer3.Enabled = False
    fightmenu.Timer4.Enabled = False
    fightmenu.characterscan.Enabled = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub swipeSword(num)
'causes player to swipe sword.
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    If mainMem.fightStyle = 0 Then
        'side view
        playWav (projectPath$ + mediapath$ + playerMem(num).swipeWav$)
        aa = (num + 1) Mod 2
        If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
        yy = currentc + 3 + fwOffsetY
        For tt = 17 To 20
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If
    If mainMem.fightStyle = 1 Then
        'front view
        playWav (projectPath$ + mediapath$ + playerMem(num).swipeWav$)
        yy = 9 + fwOffsetY
        xx = 3 * num + 4 + fwOffsetX
        For tt = 17 To 20
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If

    'playWav (mediapath$ + "swipe.wav")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub tryRun()
    On Error GoTo errorhandler
    t = Int(Rnd(1) * 4) + 1
    If t <> 2 Then Call runAway: Exit Sub
    playWav (projectPath$ + mediapath$ + bkgCantDoWav$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub updateEnemyStatuses(pnum)
    'update enemy status effects (increases current round).
    'if we've gone beyond the max round, we clear the status effect.
    On Error GoTo errorhandler
    For t = 0 To 10
        If enemyStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + enemyStatus$(t, pnum), statusMem)
            enemyStatusRound(t, pnum) = enemyStatusRound(t, pnum) + 1
            If statusMem.statusRounds <> 0 Then
                If enemyStatusRound(t, pnum) > statusMem.statusRounds Then
                    'clear the status effect...
                    enemyStatus$(t, pnum) = ""
                    enemyStatusRound(t, pnum) = 0
                    enemyChargeIncr(pnum) = 2
                    enemyStop(pnum) = False
                End If
            End If
            Exit Sub
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub updatePlayerStatuses(pnum)
    'update player status effects (increases current round).
    'if we've gone beyond the max round, we clear the status effect.
    On Error GoTo errorhandler
    For t = 0 To 10
        If playerStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + playerStatus$(t, pnum), statusMem)
            playerStatusRound(t, pnum) = playerStatusRound(t, pnum) + 1
            If statusMem.statusRounds <> 0 Then
                If playerStatusRound(t, pnum) > statusMem.statusRounds Then
                    'clear the status effect...
                    playerStatus$(t, pnum) = ""
                    playerStatusRound(t, pnum) = 0
                    playerChargeIncr(pnum) = 3
                    playerStop(pnum) = False
                End If
            End If
            Exit Sub
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub useEnemyStatuses(pnum)
    'run all status effects the current enemy has...
    On Error GoTo errorhandler
    For t = 0 To 10
        If enemyStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + enemyStatus$(t, pnum), statusMem)
            If statusMem.nStatusSpeed = 1 Then
                'speed
                enemyChargeIncr(pnum) = 4
            End If
            If statusMem.nStatusSlow = 1 Then
                'speed
                enemyChargeIncr(pnum) = 1
            End If
            If statusMem.nStatusDisable = 1 Then
                'speed
                enemyStop(pnum) = True
            End If
            If statusMem.nStatusHP = 1 Then
                'remove hp
                If statusMem.nStatusHPAmount <> 0 Then
                    Call removeEnemyHP(pnum, statusMem.nStatusHPAmount)
                End If
            End If
            If statusMem.nStatusSMP = 1 Then
                'remove smp
                If statusMem.nStatusSMPAmount <> 0 Then
                    Call removeEnemySMP(pnum, statusMem.nStatusSMPAmount)
                End If
            End If
            If statusMem.nStatusRPGCode = 1 Then
                'run rpgcode
                If statusMem.sStatusRPGCode$ <> "" Then
                    target = pnum
                    targetType = 2
                    Source = pnum
                    sourceType = 2
                    Call runfightprogram(projectPath$ + prgpath$ + statusMem.sStatusRPGCode$, 0, 0)
                End If
            End If
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub useItemMenu(nn)
    'item has been selected, now use it.
    On Error GoTo errorhandler
    If ignoreit = 1 Then ignoreit = 0: Exit Sub
    If nn = 0 Then
        '<-back
        meenumode = 0
        fightmenu.action.Clear
        fightmenu.action.AddItem LoadStringLoc(902, "Fight")
        fightmenu.action.AddItem LoadStringLoc(903, "Item")
        If playerMem(currentc).smYN = 0 Then
            fightmenu.action.AddItem playerMem(currentc).specialMoveName$
        End If
        If canrun = 1 Then
            fightmenu.action.AddItem LoadStringLoc(904, "Run")
        End If
        fightmenu.action.ListIndex = 0
        Exit Sub
    End If
    'Now figure out *who* was selected.
    If nn <> 0 Then
        'First, swipe that sword!!!
        Call showSM(currentc)
        Call standErect(currentc)
        'Remove item from inventory:
        NumberItem(cselecteditem) = NumberItem(cselecteditem) - 1
        If NumberItem(cselecteditem) <= 0 Then
            NumberItem(cselecteditem) = 0
            inventory$(cselecteditem) = ""
            itemListAr$(cselecteditem) = ""
        End If
        
        theone = nn
        If theone <= aliveEnemies() Then
            'it was an enemy
            theone = theone - 1
            theone = livingEnemy(theone)
            If itemMem(11).fgtUse$ <> "" Then
                'run program:
                target = theone
                targetType = 2
                Source = currentc
                sourceType = 0
                Call runfightprogram(projectPath$ + prgpath$ + itemMem(11).fgtUse$, 0, 0)
            End If
            'calculate hit points:
            pFP = itemMem(11).fgtHPup * -1
            Call removeEnemyHP(theone, pFP)
            pSM = itemMem(11).fgtSMup * -1
            If pSM <> 0 Then Call removeEnemySMP(theone, pSM)
            'end of turn
            Call endOfTurn
        Else
            'it was a character (stupid!!!)
            theone = theone - aliveEnemies() - 1
            If itemMem(11).fgtUse$ <> "" Then
                'run program:
                target = theone
                targetType = 0
                Source = currentc
                sourceType = 0
                Call runfightprogram(projectPath$ + prgpath$ + itemMem(11).fgtUse$, 0, 0)
            End If
            'calculate hit points:
            pFP = itemMem(11).fgtHPup * -1
            If pFP <> 0 Then Call removePlayerHP(theone, pFP)
            pSM = itemMem(11).fgtSMup * -1
            If pSM <> 0 Then Call removePlayerSMP(theone, pSM)
            'end of turn
            Call endOfTurn
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub useMoveMenu(nn)
    'use special move(it was previously selected and opened)
    On Error GoTo errorhandler
    If ignoreit = 1 Then ignoreit = 0: Exit Sub
    If nn = 0 Then
        '<-back
        meenumode = 0
        fightmenu.action.Clear
        fightmenu.action.AddItem LoadStringLoc(902, "Fight")
        fightmenu.action.AddItem LoadStringLoc(903, "Item")
        If playerMem(currentc).smYN = 0 Then
            fightmenu.action.AddItem playerMem(currentc).specialMoveName$
        End If
        If canrun = 1 Then
            fightmenu.action.AddItem LoadStringLoc(904, "Run")
        End If
        fightmenu.action.ListIndex = 0
        Exit Sub
    End If
    'Now figure out *who* was selected.
    If nn <> 0 Then
        'First, swipe that sword!!!
        Call showSM(currentc)
        Call standErect(currentc)
        'Remove smp:
        Call removePlayerSMP(currentc, specialMoveMem.smSMP)
        theone = nn
        If theone <= aliveEnemies() Then
            'it was an enemy
            theone = theone - 1
            theone = livingEnemy(theone)
            'before running the rpgcode program, run the special move animation...
            If specialMoveMem.smAnimation$ <> "" Then
                Call animateOverEnemy(specialMoveMem.smAnimation$, theone)
            End If
            If specialMoveMem.smPrg$ <> "" Then
                'run program:
                target = theone
                targetType = 2
                Source = currentc
                sourceType = 0
                Call runfightprogram(projectPath$ + prgpath$ + specialMoveMem.smPrg$, 0, 0)
                If didIWin() Then
                    Call checkWin
                    Call checkGameOver
                    Call endOfTurn
                    Exit Sub
                End If
            End If
            'calculate hit points:
            pFP = specialMoveMem.smFP
            pDP = enemyMem(theone).eneDP
            pFP = pFP - pDP
            If pFP <= 0 Then pFP = 1
            For t = 0 To 100
                If enemyMem(theone).eneWeakness$(t) <> "" Then
                    If UCase$(enemyMem(theone).eneWeakness$(t)) = UCase$(playerMem(currentc).smlist$(cselectedmove)) Then
                        'the enemy is weak against this move...
                        pFP = pFP * 2
                    End If
                End If
            Next t
            
            Call removeEnemyHP(theone, pFP)
            pSM = specialMoveMem.smtargSMP
            If pSM <> 0 Then Call removeEnemySMP(theone, pSM)
            
            'apply status effect...
            If specialMoveMem.smStatusEffect$ <> "" Then 'status effect cast
                Call applyEnemyStatus(theone, specialMoveMem.smStatusEffect$)
            End If
            'end of turn
            Call endOfTurn
        Else
            'it was a character (stupid!!!)
            theone = theone - aliveEnemies() - 1
            
            'before running the rpgcode program, run the special move animation...
            If specialMoveMem.smAnimation$ <> "" Then
                Call animateOverPlayer(specialMoveMem.smAnimation$, theone)
            End If
            If specialMoveMem.smPrg$ <> "" Then
                'run program:
                target = theone
                targetType = 0
                Source = currentc
                sourceType = 0
                Call runfightprogram(projectPath$ + prgpath$ + specialMoveMem.smPrg$, 0, 0)
            End If
            'calculate hit points:
            pFP = specialMoveMem.smFP
            If pFP <> 0 Then Call removePlayerHP(theone, pFP)
            pSM = specialMoveMem.smtargSMP
            If pSM <> 0 Then Call removePlayerSMP(theone, pSM)
            'apply status effect...
            If specialMoveMem.smStatusEffect$ <> "" Then 'status effect cast
                Call applyPlayerStatus(theone, specialMoveMem.smStatusEffect$)
            End If
            
            'end of turn
            Call endOfTurn
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Function aliveEnemies()
    'return number of living enemies.
    On Error GoTo errorhandler
    dead = 0
    For t = 0 To numEne - 1
        If enemyMem(t).eneHP <= 0 Then dead = dead + 1
    Next t
    aliveEnemies = (numEne - dead)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub backUpBuffers()
    'copies the player buffers to other buffers.
    On Error GoTo errorhandler
    For bufnum = 0 To 4
        Call vbPicAutoRedraw(mainForm.bufferform(bufnum), True)
        Call vbPicAutoRedraw(mainForm.bufferform(bufnum + 26), True)
        
        Call vbPicAutoRedraw(mainForm.buffermaskform(bufnum), True)
        Call vbPicAutoRedraw(mainForm.buffermaskform(bufnum + 26), True)
        If Not (bUseSpriteBufferCanvas) Then
            a = BitBlt(vbPicHDC(mainForm.bufferform(bufnum + 26)), 0, 0, 64, 64, vbPicHDC(mainForm.bufferform(bufnum)), x1, y1, &HCC0020)
            a = BitBlt(vbPicHDC(mainForm.buffermaskform(bufnum + 26)), 0, 0, 64, 64, vbPicHDC(mainForm.buffermaskform(bufnum)), x1, y1, &HCC0020)
        Else
            a = BitBlt(CanvasHDC(spriteBuffer(bufnum + 26)), 0, 0, 64, 64, CanvasHDC(spriteBuffer(bufnum)), x1, y1, &HCC0020)
        End If
    Next bufnum

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub boardcache()
    'puts board into a cache
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    If fromProgram = 0 Then
        'a = BitBlt(mainForm.cache.hdc, 0, 0, tilesX * 32 * ddx, tilesY * 32 * ddy, vbpichdc(mainForm.boardform), 0, 0, &HCC0020)
        a = BitBlt(CanvasHDC(fightCacheCanvas), 0, 0, tilesX * 32, tilesY * 32, vbPicHDC(mainForm.boardform), 0, 0, &HCC0020)
    End If
    'call vbPicAutoRedraw(mainForm.boardform,false)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function canDoSM(eenum, movesCanDo())
    'determines if enemy has enough SMP to do a move.
    'Puts 0 for no, 1 for yes(attack) or 2(curative) into slots of movesCanDo
    'also returns number of moves
    On Error GoTo errorhandler
    num = 0
    Dim eMove As TKSpecialMove
    
    For t = 0 To 100
        movesCanDo(t) = 0
        If enemyMem(eenum).eneSpecialMove$(t) <> "" Then
            Call openspecialmove(projectPath$ + spcpath$ + enemyMem(eenum).eneSpecialMove$(t), eMove)
            If eMove.smSMP <= enemyMem(eenum).eneSMP Then
                num = num + 1
                If eMove.smFP > 0 Then movesCanDo(t) = 1
                If eMove.smFP <= 0 Then movesCanDo(t) = 2
            End If
        End If
    Next t
    canDoSM = num

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function checkbkgmatch(x, y, xmatch, ymatch)
    On Error GoTo errorhandler
amatch = 0
goahead = 0
For ytest = 1 To y
    For xtest = 1 To 19
        If amatch <> 1 Then
            If UCase$(background$(xtest, ytest)) = UCase$(background$(x, y)) And _
                bkgred(xtest, ytest) = bkgred(x, y) And _
                bkggreen(xtest, ytest) = bkggreen(x, y) And _
                bkgblue(xtest, ytest) = bkgblue(x, y) Then
                'Might have found a match.  First check bounds.
                goahead = 1
                If ytest = y Then
                    If x > xtest Then
                        goahead = 1
                    End If
                    If x <= xtest Then goahead = 0
                End If
                'ok, if goahead=1, then we are in bounds.
                If goahead = 1 Then
                    xmatch = xtest
                    ymatch = ytest
                    checkbkgmatch = 0: Exit Function
                End If
            End If
        End If
    Next xtest
Next ytest
checkbkgmatch = -1


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub checkGameOver()
    'checks if there is a game over.
    'if there is, the game will be reset.
    On Error GoTo errorhandler
    p = 0
    d = 0
    For t = 0 To 4
        If playerListAr$(t) <> "" Then
            p = p + 1
            hp = getHP(playerListAr$(t))
            If hp <= 0 Then d = d + 1
        End If
    Next t
    If d = p Then
        'how sad- game over.
        battleOver = 1
        fightInProgress = False
        runningProgram = False
        fightmenu.characterscan.Enabled = False
        fightmenu.Timer1.Enabled = False
        fightmenu.Timer2.Enabled = False
        fightmenu.Timer3.Enabled = False
        fightmenu.Timer4.Enabled = False
        Unload fightmenu
        Call vbPicAutoRedraw(mainForm.boardform, False)
               
        Call GameOver
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub checkWin()
    'check if the players have won.
    On Error GoTo errorhandler
       
    total = 0
    For t = 0 To numEne - 1
        If enemyMem(t).eneHP <= 0 Then total = total + 1
    Next t
    If total = numEne Then Call wonBattle

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub copyFromBkgBuf(x1, y1, x2, y2, ByVal refreshYN As Boolean)
    'copy part of the background buffer to the board
    On Error GoTo errorhandler
    dx = x2 - x1: dy = y2 - y1
    Call vbPicAutoRedraw(mainForm.boardform, True)
    a = BitBlt(vbPicHDC(mainForm.boardform), x1, y1, dx, dy, CanvasHDC(fightBkgBufferCanvas), x1, y1, &HCC0020)
    If refreshYN Then
        Call vbPicRefresh(mainForm.boardform)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub copyToBkgBuf()
    'copies the background image into the background buffer
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    a = BitBlt(CanvasHDC(fightBkgBufferCanvas), 0, 0, tilesX * 32, tilesY * 32, vbPicHDC(mainForm.boardform), 0, 0, &HCC0020)
    Call CanvasRefresh(fightBkgBufferCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub defend(num)
    'causes player to defend
    'Show player being hit:
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    If mainMem.fightStyle = 0 Then
        'side view
        playWav (projectPath$ + mediapath$ + playerMem(num).defendWav$)
        aa = (num + 1) Mod 2
        If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
        yy = num + 3 + fwOffsetY
        For tt = 25 To 28
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If
    If mainMem.fightStyle = 1 Then
        'front view
        playWav (projectPath$ + mediapath$ + playerMem(num).defendWav$)
        yy = 9 + fwOffsetY
        xx = 3 * num + 4 + fwOffsetX
        For tt = 25 To 28
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub die(num)
    'causes player to die
    On Error GoTo errorhandler
    playWav (projectPath$ + mediapath$ + playerMem(num).deadWav$)
    Call vbPicAutoRedraw(mainForm.boardform, True)
    If mainMem.fightStyle = 0 Then
        'side view
        aa = (num + 1) Mod 2
        If aa = 1 Then xx = 18 + fwOffsetX Else xx = 19 + fwOffsetX
        yy = num + 3 + fwOffsetY
        For tt = 29 To 32
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If
    If mainMem.fightStyle = 1 Then
        'front view
        yy = 9 + fwOffsetY
        xx = 3 * num + 4 + fwOffsetX
        For tt = 29 To 32
            Call CopyFromBuffer(xx, yy, num, tt, vbPicHDC(mainForm.boardform), -1, False)
            Call putplayer(xx, yy, 1, num, tt)
            Call vbPicRefresh(mainForm.boardform)
            'DoEvents
            Select Case CharacterSpeed
                Case 0:
                    delay (0.09)
                Case 1:
                    delay (0.06)
                Case 2:
                    delay (0.03)
                Case 3:
                    'no delay
            End Select
        Next tt
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub displayFightText(text$, x, y, col)
    'displays text on the fight screen for
    'a few seconds, then removes it.
    On Error GoTo errorhandler

    'First, copy existing image into buffer:
    'allPurposeCanvas = CreateCanvas(tilesX * 32, tilesY * 32)
        Call SetCanvasSize(allPurposeCanvas, tilesX * 32, tilesY * 32)
    a = BitBlt(CanvasHDC(allPurposeCanvas), 0, 0, 100, 100, vbPicHDC(mainForm.boardform), (x * 16 - 16), (y * 16 - 16), &HCC0020)
    Call CanvasRefresh(allPurposeCanvas)
    
    'Now, display text:
    Call vbPicAutoRedraw(mainForm.boardform, True)
    oldbold = bold
    bold = 1
    Call puttext(text$, x, y, col, 16, 16, vbPicHDC(mainForm.boardform))
    Call vbPicRefresh(mainForm.boardform)
    bold = oldbold
    'DoEvents

    'Now wait for some time
    ti = 1
    aa = Timer
    te = 0
    Do While te < ti
        'DoEvents
        bb = Timer
        te = bb - aa
    Loop

    Call vbPicAutoRedraw(mainForm.boardform, True)
    'Now remove text:
    a = BitBlt(vbPicHDC(mainForm.boardform), (x * 16 - 16), (y * 16 - 16), 100, 100, CanvasHDC(allPurposeCanvas), 0, 0, &HCC0020)
    Call vbPicRefresh(mainForm.boardform)
    'Call DestroyCanvas(allPurposeCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawBackground()
    'redraws the background
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    Call vbPicFillRect(mainForm.boardform, 0, 0, 2000, 2000, 0)
    Call vbPicRefresh(mainForm.boardform)
    If bkgImage$ <> "" Then
        Call LoadSizedPicture(projectPath$ + bmppath$ + bkgImage$, mainForm.boardform)
        'mainForm.boardform.Picture = LoadPicture(bmppath$ + bkgImage$)
    End If
    For y = 1 To 11
        For x = 1 To 19
            If background$(x, y) <> "" Then
                Call drawBkgTile(x, y)
            End If
        Next x
    Next y
    'call vbpicrefresh(mainForm.boardform)
    'boardform.AutoRedraw = -1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawBkgTile(x, y)
    On Error GoTo errorhandler
    Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + background$(x, y), x + fwOffsetX, y + fwOffsetY, bkgred(x, y), bkggreen(x, y), bkgblue(x, y), False)
    Exit Sub
    
    amatch = checkbkgmatch(x, y, matchx, matchy)
    If amatch = 0 Then
        'This tile has already been laid down
        'Now to bitblt it.
        copyx = (matchx + fwOffsetX) * 32 - 32
        copyy = (matchy + fwOffsetY) * 32 - 32
        newX = (x + fwOffsetX) * 32 - 32
        newY = (y + fwOffsetY) * 32 - 32
        Call copyimg(copyx, copyy, copyx + 32, copyy + 32, newX, newY)
        Exit Sub
    End If
    If amatch = -1 Then
        'This tile must be drawn right now.
        'First, see if it's in an archive
        tileopen$ = projectPath$ + tilepath$ + background$(x, y)
        Call openwintile(tileopen$)
        If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
        xx = (x + fwOffsetX) * 32 - 32
        yy = (y + fwOffsetY) * 32 - 32
        oldyy = yy
        For dx = 1 To 32
            For dy = 1 To 32
                If tilemem(dx, dy) <> -1 Then
                    colordraw = tilemem(dx, dy)
                    rr = red(colordraw)
                    gg = green(colordraw)
                    bb = blue(colordraw)
                    rr = rr + bkgred(x, y)
                    gg = gg + bkggreen(x, y)
                    bb = bb + bkgblue(x, y)
                    If rr > 255 Then rr = 255
                    If rr < 0 Then rr = 0
                    If gg > 255 Then gg = 255
                    If gg < 0 Then gg = 0
                    If bb > 255 Then bb = 255
                    If bb < 0 Then bb = 0
                    Call drawPixel(mainForm.boardform, xx, yy, RGB(rr, gg, bb))
                    'Call drawPixel(mainForm.boardform, xx, yy, colordraw)
                    'boardform.PSet (xx, yy), colordraw
                End If
                yy = yy + 1
            Next dy
            xx = xx + 1
            yy = oldyy
        Next dx
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawEnemy(x, y, eenum)
    'draws enemy eenum at x, y
    On Error Resume Next
    'If useFastDraw = 1 And Not (is14Enemy(eenum)) Then
        'quick draw the enemy
        ChDir (projectPath$)
        fn$ = enemyMem(eenum).eneFileName$
        fn$ = nopath(fn$)
        fn$ = enepath$ + fn$
        If PakFileRunning Then
            Call ChangeDir(PakTempPath)
            a = GFXdrawEnemy(fn$, x, y, 0, 0, 0, vbPicHDC(mainForm.boardform))
            Call ChangeDir(currentdir$)
        Else
            a = GFXdrawEnemy(fn$, x, y, 0, 0, 0, vbPicHDC(mainForm.boardform))
        End If
        ChDir (currentdir$)
        Exit Sub
    'End If
    'xxx = 1: yyy = 1
    'For yy = y To enemyMem(eenum).eneSizeY + y - 1
    '    For xx = x To enemyMem(eenum).eneSizeX + x - 1
    '        Call drawEnemyTile(xxx, yyy, xx, yy, x, y, eenum)
    '        xxx = xxx + 1
    '    Next xx
    '    yyy = yyy + 1
    '    xxx = 1
    'Next yy
End Sub

Sub drawEnemyTile(x, y, posx, posy, cx, cy, eenum)
    'draws enemy tile at posx,posy
    'it draws the  x,y th tile of enemy eenum
    'cx and cy are the top left corner of the enemy graphic.
    On Error GoTo errorhandler
    If enemyMem(eenum).enemyGraphic$(x, y) <> "" Then
        result = searchForMatch(enemyMem(eenum).enemyGraphic$(x, y), x, y, myx, myy, eenum)
        result = 1
        If result = 0 Then
            'call vbPicAutoRedraw(mainForm.boardform,false)
            oldx = (myx) * 32 - 32
            oldy = (myy) * 32 - 32
            oldx = oldx + cx
            oldy = oldy + cy
            thisx = (posx) * 32 - 32
            thisy = (posy) * 32 - 32
            'Suc = BitBlt(vbpichdc(mainForm.boardform), thisx * ddx, thisy * ddy, 32 * ddx, 32 * ddy, vbpichdc(mainForm.boardform), oldx * ddx, oldy * ddy, &HCC0020)
            Suc = BitBlt(vbPicHDC(mainForm.boardform), thisx, thisy, 32, 32, vbPicHDC(mainForm.boardform), oldx, oldy, &HCC0020)
        Else
            a$ = FindFile(projectPath$ + tilepath$ + enemyMem(eenum).enemyGraphic$(x, y))
            Call openwintile(a$)
            'call vbPicAutoRedraw(mainForm.boardform,false)
            If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
            xx = (posx) * 32 - 32
            yy = (posy) * 32 - 32
            fx = 1: fy = 1
            For dx = xx To xx + 31
                For dy = yy To yy + 31
                    curcol = tilemem(fx, fy)
                    If curcol <> -1 Then
                        Call drawPixel(mainForm.boardform, dx, dy, curcol)
                    End If
                    fy = fy + 1
                Next dy
                fx = fx + 1
                fy = 1
            Next dx
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawScene(bkg$)
    'draws the fighting scene
    'assumes enemies are already loaded.
    On Error GoTo errorhandler

    Call boardcache
    Call fightfade
    Call vbPicAutoRedraw(mainForm.boardform, True)
    Call showBackground(projectPath$ + bkgpath$ + bkg$)
    Call vbPicAutoRedraw(mainForm.boardform, True)
    Call showEnemies    'draw enemies
    Call showPlayers    'draw players
    Call showstats      'draw stats box
    'call vbpicrefresh(mainForm.boardform)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub endOfTurn()
    On Error GoTo errorhandler
    fightmenu.characterscan.Enabled = True
    fightmenu.action.Enabled = False
    fightmenu.Command1.Enabled = False
    meenumode = 0
    currentc = -1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub enemyMove(eenum)
    'MsgBox "here"
    On Error GoTo errorhandler
    If battleOver = 1 Then Exit Sub
    
    tohit = chooseHit(eenum)
    If enemyMem(eenum).eneUseRPGCode = 1 Then
        'use rpgcode ai routine
        targetType = 0
        target = eenum
        Source = eenum
        sourceType = 2
        Call runfightprogram(projectPath$ + prgpath$ + enemyMem(eenum).eneRPGCode$, 0, 0)
        Exit Sub
    End If
    If enemyMem(eenum).eneAI = 0 Then
        Call AIZero(eenum, tohit)
    End If
    If enemyMem(eenum).eneAI = 1 Then
        Call AIOne(eenum, tohit)
    End If
    If enemyMem(eenum).eneAI = 2 Then
        Call AITwo(eenum, tohit)
    End If
    If enemyMem(eenum).eneAI = 3 Then
        Call AIThree(eenum, tohit)
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub enemyPhysicalAttack(eenum, tohit)
    'causes enemy to use physical attack.
    On Error GoTo errorhandler
    Call playWav(projectPath$ + mediapath$ + enemyMem(eenum).eneSwipeSound$)
    If enemyMem(eenum).eneFightAnm$ = "" Then
        'just flash the enemy if no fight animation is used...
        Call flashEnemy(eenum)
    Else
        'there's a fight animation!
        'first, remove the enemy from the screen...
        x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
        y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
        x1 = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
        y1 = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
        Call vbPicAutoRedraw(mainForm.boardform, True)
        Call copyFromBkgBuf(x1, y1, x2, y2, False)
    
        'now run the animation...
        Call animateTopCornerEnemy(enemyMem(eenum).eneFightAnm$, eenum)
        
        'now put the enemy back...
        Call redrawEnemy(eenum)
    End If
    fp = enemyMem(eenum).eneFP
    'check if we got lucky
    r = Int(Rnd(1) * enemyMem(eenum).eneSneakUp) + 1
    If r <> Int(enemyMem(eenum).eneSneakUp / 2) Then
        dp = getDP(playerListAr$(tohit))
    End If
    hitp = fp - dp
    If hitp <= 0 Then hitp = 1
    Call removePlayerHP(tohit, hitp)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub enemyUseSM(eenum, num, tohit)
    'this will use a special move.
    'with enemy eenum
    'using move number num
    'hitting player tohit
    On Error GoTo errorhandler
    Call playWav(projectPath$ + mediapath$ + enemyMem(eenum).eneSMSound$)
    If enemyMem(eenum).eneSPCAnm$ = "" Then
        'just flash the enemy if no animation is used...
        Call flashEnemy(eenum)
    Else
        'there's an animation!
        'first, remove the enemy from the screen...
        x2 = (eneX(eenum) + fwOffsetX) * 32 - 32
        y2 = (eneY(eenum) + fwOffsetY) * 32 - 2
        x1 = (eneX(eenum) + fwOffsetX - enemyMem(eenum).eneSizeX) * 32 - 32
        y1 = (eneY(eenum) + fwOffsetY - enemyMem(eenum).eneSizeY) * 32 - 32
        Call vbPicAutoRedraw(mainForm.boardform, True)
        Call copyFromBkgBuf(x1, y1, x2, y2, False)
    
        'now run the animation...
        Call animateTopCornerEnemy(enemyMem(eenum).eneSPCAnm$, eenum)
        
        'now put the enemy back...
        Call redrawEnemy(eenum)
    End If
    Dim eMove As TKSpecialMove
    Call openspecialmove(projectPath$ + spcpath$ + enemyMem(eenum).eneSpecialMove$(num), eMove)
    targetType = 0  'players targeted.
    Source = eenum
    sourceType = 2
    If eMove.smPrg$ <> "" Then
        Call runfightprogram(projectPath$ + prgpath$ + eMove.smPrg$, 0, 0)
    End If
    Call removeEnemySMP(eenum, eMove.smSMP)
    If eMove.smFP < 0 Then
        'it's curative, so we use it on ourself
        If eMove.smAnimation <> "" Then
            Call animateTopCornerEnemy(eMove.smAnimation, eenum)
        End If
        
        Call removeEnemyHP(eenum, eMove.smFP)
        Call removeEnemySMP(eenum, eMove.smtargSMP)
        Exit Sub
    End If
    
    'animate over player...
    If eMove.smAnimation <> "" Then
        Call animateOverPlayer(eMove.smAnimation$, tohit)
    End If
    
    pDP = getDP(playerListAr$(tohit))
    eMove.smFP = eMove.smFP - pDP
    If eMove.smFP <= 0 Then eMove.smFP = 1
    If eMove.smFP <> 0 Then Call removePlayerHP(tohit, eMove.smFP)
    If eMove.smtargSMP <> 0 Then Call removePlayerSMP(tohit, eMove.smtargSMP)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ffight(eSkill, bkg$)
    'initiate a board fight
    On Error GoTo errorhandler
    numEne = Int(Rnd(1) * 4) + 1
    For t = 0 To numEne - 1
        enemies$(t) = getEnemy(eSkill)
        If enemies$(t) = "NO ENEMIES" Then
            Call stopTimers
            'MsgBox "No Enemies of skill" + Str$(eskill) + " found!!!", , "Can't fight"
            abc = MBox(LoadStringLoc(829, "No Enemies of skill ") + str$(eSkill) + LoadStringLoc(830, " found!!!"), LoadStringLoc(831, "Can't Fight"), mb_ok, RGB(255, 255, 255), menuColor, projectPath$ + bmppath$ + mainMem.skinWindow$)
            Call startTimers
            Exit Sub
        End If
    Next t
    Call runFight(enemies$(), numEne, bkg$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub usePlayerStatuses(pnum)
    'run all status effects the current player has...
    On Error GoTo errorhandler
    For t = 0 To 10
        If playerStatus$(t, pnum) <> "" Then
            Call openStatus(projectPath$ + statuspath$ + playerStatus$(t, pnum), statusMem)
            If statusMem.nStatusSpeed = 1 Then
                'speed
                playerChargeIncr(pnum) = 5
            End If
            If statusMem.nStatusSlow = 1 Then
                'speed
                playerChargeIncr(pnum) = 1
            End If
            If statusMem.nStatusDisable = 1 Then
                'speed
                playerStop(pnum) = True
            End If
            If statusMem.nStatusHP = 1 Then
                'remove hp
                If statusMem.nStatusHPAmount <> 0 Then
                    Call removePlayerHP(pnum, statusMem.nStatusHPAmount)
                End If
            End If
            If statusMem.nStatusSMP = 1 Then
                'remove smp
                If statusMem.nStatusSMPAmount <> 0 Then
                    Call removePlayerSMP(pnum, statusMem.nStatusSMPAmount)
                End If
            End If
            If statusMem.nStatusRPGCode = 1 Then
                'run rpgcode
                If statusMem.sStatusRPGCode$ <> "" Then
                    target = pnum
                    targetType = 0
                    Source = pnum
                    sourceType = 0
                    Call runfightprogram(projectPath$ + prgpath$ + statusMem.sStatusRPGCode$, 0, 0)
                End If
            End If
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub wonBattle()
    'Yay, we won the battle
    On Error GoTo errorhandler
    Call restoreBuffers
    boardList(activeBoardIndex).theData.boardMusic$ = oldmusic$
    For t = 0 To 30
        queue(t) = -1
    Next t
    Call stopTimers
    Unload fightmenu
    If battleOver <> 1 And Not (bGaveReward) Then
        bGaveReward = True
        Call givePlayersExp(expWin)
        Call givePlayersGP(gpWin)
        Call runWinProgram
    End If
    battleOver = 1
    Call restorecache
    If wentToNewBoard Then
        'redraw player
        If (Not (useParallaxLayer)) Then
            Call putplayer(curx(selectedPlayer), cury(selectedPlayer), curlayer(selectedPlayer), playernum, 1)
        End If
    End If
    'force music check...
    Call checkMusic

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

