Attribute VB_Name = "boardRoutines"
'now the stuff for the layered graphics engine...
Global LayerBackground As Integer      'background image
Global LayerBoard As Integer           'board
Global LayerBoardMask As Integer       'mask for board
Global LayerSprites As Integer         'sprites
Global LayerFade As Integer             'fade / day night layer

Global LayerSpritesMask As Integer     'sprite mask
Global LayerSpriteCol As Integer       'next column of sprites
Global LayerSpriteColMask As Integer   'next column of sprites (mask)
Global LayerSpriteRow As Integer       'next row of sprites
Global LayerSpriteRowMask As Integer   'next row of sprites (mask)

Global TranspColor As Long
Global TranspColorMask As Long
Global SolidColorMask As Long

Global LastLaidPlayerGfx As Integer     'last 'walking position' of the player laid

Global topx2, topy2                     'topx and y as decimal fractions.  updated by player walking.

Global ScreenZoomFactor As Double       'zooming factor for draws onto the screen.

Global useSpriteLayer As Boolean    'use sprite layer?
Global useParallaxLayer As Boolean   'use parallax layer?  you can turn both of these off to speed up drawing
Sub playerSprite(ByVal x As Double, ByVal y As Double, ByVal lay As Double, ByVal playernum As Long, ByVal position As Long, ByVal hdc As Long)
    'Puts the mainForm character at x, y, layer of the current board
    'num is the player number
    'position is the graphic position:
    '   1-16, walking gfx
    '   17-20, fight
    '   21-24, special move
    '   25-28, defense
    '   29-32, die
    '   33-42, custom postures
    '   43, fight at rest graphic
    On Error GoTo errorhandler
    
    LastLaidPlayerGfx = position
    
    Select Case boardList(activeBoardIndex).theData.ambienteffect
         Case 0
             addonr = 0
             addong = 0
             addonb = 0
         Case 1
             addonr = 75
             addong = 75
             addonb = 75
         Case 2
             addonr = -75
             addong = -75
             addonb = -75
         Case 3
             addonr = 0
             addong = 0
             addonb = 75
    End Select
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shader)
    a = GetVariable("AmbientGreen!", l$, shadeg)
    a = GetVariable("AmbientBlue!", l$, shadeb)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightshade = DetermineLightLevel()
        shader = shader + lightshade
        shadeg = shadeg + lightshade
        shadeb = shadeb + lightshade
    End If
    addonr = addonr + shader
    addong = addong + shadeg
    addonb = addonb + shadeb

    Call vbPicAutoRedraw(mainForm.boardform, True)
    xx = (x - topX) * 32 - 32
    yy = (y - topY) * 32 - 32
    '64x32 gfx
    If position = 43 Then
        'at rest gfx
        For u = 0 To 1
            For v = 0 To 1
                ofx = intNot(u)
                ofy = intNot(v)
                Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).fightRestGfx$(u, v), x - topX - ofx, y - topY - ofy, 0, 0, 0, False)
            Next v
        Next u
    End If
    res = within(position, 1, 16)
    If res = 1 Then
        'walking gfx
        Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).walkGfx$(position - 1, 1), x - topX, y - topY, addonr, addong, addonb, False)
        Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).walkGfx$(position - 1, 0), x - topX, y - topY - 1, addonr, addong, addonb, False)
    Else
        res = within(position, 17, 20)
        If res = 1 Then
            'fight gfx -17
            For u = 0 To 1
                For v = 0 To 1
                    ofx = intNot(u)
                    ofy = intNot(v)
                    Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).fightingGfx$(position - 17, u, v), x - topX - ofx, y - topY - ofy, 0, 0, 0, False)
                Next v
            Next u
        End If
        res = within(position, 21, 24)
        If res = 1 Then
            'sm gfx -21
            For u = 0 To 1
                For v = 0 To 1
                    ofx = intNot(u)
                    ofy = intNot(v)
                    Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).specialGfx$(position - 21, u, v), x - topX - ofx, y - topY - ofy, 0, 0, 0, False)
                Next v
            Next u
        End If
        res = within(position, 25, 28)
        If res = 1 Then
            'def gfx -25
            For u = 0 To 1
                For v = 0 To 1
                    ofx = intNot(u)
                    ofy = intNot(v)
                    Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).defenseGfx$(position - 25, u, v), x - topX - ofx, y - topY - ofy, 0, 0, 0, False)
                Next v
            Next u
        End If
        res = within(position, 29, 32)
        If res = 1 Then
            'dead -29
            For u = 0 To 1
                For v = 0 To 1
                    ofx = intNot(u)
                    ofy = intNot(v)
                    Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).deathGfx$(position - 29, u, v), x - topX - ofx, y - topY - ofy, 0, 0, 0, False)
                Next v
            Next u
        End If
        res = within(position, 33, 42)
        If res = 1 Then
            'custom -33
            For u = 0 To 1
                Call drawtile(hdc, projectPath$ + tilepath$ + playerMem(num).customisedGfx$(position - 33, u), x - topX, y - topY + u - 1, addonr, addong, addonb, False)
            Next u
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub drawprograms(layer)
    'draws all programs on specified layer.
    On Error GoTo errorhandler
    Select Case boardList(activeBoardIndex).theData.ambienteffect
        Case 0
            addonr = 0
            addong = 0
            addonb = 0
        Case 1
            addonr = 75
            addong = 75
            addonb = 75
        Case 2
            addonr = -75
            addong = -75
            addonb = -75
        Case 3
            addonr = 0
            addong = 0
            addonb = 75
    End Select
    'internal engine drawing routines
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shader)
    a = GetVariable("AmbientGreen!", l$, shadeg)
    a = GetVariable("AmbientBlue!", l$, shadeb)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightshade = DetermineLightLevel()
        shader = shader + lightshade
        shadeg = shadeg + lightshade
        shadeb = shadeb + lightshade
    End If
    
    addonr = addonr + shader
    addong = addong + shadeg
    addonb = addonb + shadeb
    
    'first things first- what prgs are on this layer?
    Call vbPicAutoRedraw(mainForm.boardform, True)
    For prgnum = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        'MsgBox programname$(prgnum) + " " + proggraphic$(prgnum) + Str$(prgnum)
        If boardList(activeBoardIndex).theData.programName$(prgnum) <> "" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "" Then
            'check if it's activated
            runit = 1
            If boardList(activeBoardIndex).theData.progActivate(prgnum) = 1 Then
                runit = 0
                checkit = GetVariable(boardList(activeBoardIndex).theData.progVarActivate$(prgnum), lit$, num)
                If checkit = 0 Then
                    'it's a numerical variable
                    valuetest = num
                    If valuetest = val(boardList(activeBoardIndex).theData.activateInitNum$(prgnum)) Then runit = 1
                End If
                If checkit = 1 Then
                    'it's a literal variable
                    valuetes$ = lit$
                    If valuetes$ = boardList(activeBoardIndex).theData.activateInitNum$(prgnum) Then runit = 1
                End If
            End If
            If runit = 1 And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" Then
                layat = boardList(activeBoardIndex).theData.progLayer(prgnum)
                If layat = layer Then
                    'yes!  it's on this layer!
                    x = boardList(activeBoardIndex).theData.progX(prgnum)
                    y = boardList(activeBoardIndex).theData.progY(prgnum)
                    
                    aa = fileExist(projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum))
                    aa = 1
                    If aa = 1 Then
                        If useSpriteLayer = False And useParallaxLayer = False Then
                            Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), (x - topX), (y - topY), addonr, addong, addonb, False)
                        Else
                            If useSpriteLayer Then
                                Call drawtile(CanvasHDC(LayerSprites), projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), (x - topX), (y - topY), addonr, addong, addonb, False)
                                Call drawtile(CanvasHDC(LayerSpritesMask), projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), (x - topX), (y - topY), addonr, addong, addonb, True, False)
                            Else
                                Call drawtile(CanvasHDC(LayerBoard), projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), (x - topX), (y - topY), addonr, addong, addonb, False)
                                Call drawtile(CanvasHDC(LayerBoardMask), projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum), (x - topX), (y - topY), addonr, addong, addonb, True, False)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    Next prgnum
    'Call vbPicRefresh(mainForm.boardform)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub drawitems(layer, Optional ByVal bCopyUnderneath As Boolean = True)
    'draws all items on specified layer.
    'first things first- what items are on this layer?
    On Error GoTo errorhandler
   Select Case boardList(activeBoardIndex).theData.ambienteffect
        Case 0
            addonr = 0
            addong = 0
            addonb = 0
        Case 1
            addonr = 75
            addong = 75
            addonb = 75
        Case 2
            addonr = -75
            addong = -75
            addonb = -75
        Case 3
            addonr = 0
            addong = 0
            addonb = 75
   End Select
    'internal engine drawing routines
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shader)
    a = GetVariable("AmbientGreen!", l$, shadeg)
    a = GetVariable("AmbientBlue!", l$, shadeb)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightshade = DetermineLightLevel()
        shader = shader + lightshade
        shadeg = shadeg + lightshade
        shadeb = shadeb + lightshade
    End If
    
    addonr = addonr + shader
    addong = addong + shadeg
    addonb = addonb + shadeb

    Call vbPicAutoRedraw(mainForm.boardform, True)
    For itemnum = 0 To 10
        If boardList(activeBoardIndex).theData.itmName$(itemnum) <> "" Then
            'now check if it's still active...
            If boardList(activeBoardIndex).theData.itmActivate(itemnum) = 0 Then
                runit = 1
            Else
                runit = 0
                checkit = GetVariable(boardList(activeBoardIndex).theData.itmVarActivate$(itemnum), lit$, num)
                If checkit = 0 Then
                    'it's a numerical variable
                    valuetest = num
                    If valuetest = val(boardList(activeBoardIndex).theData.itmActivateInitNum$(itemnum)) Then runit = 1
                End If
                If checkit = 1 Then
                    'it's a literal variable
                    valuetes$ = lit$
                    If valuetes$ = boardList(activeBoardIndex).theData.itmActivateInitNum$(itemnum) Then runit = 1
                End If
            End If
            
            If runit = 1 Then
            
                layat = boardList(activeBoardIndex).theData.itmLayer(itemnum)
                layat = layer
                If layat = layer Then
                    'yes!  it's on this layer!
                    'if it has a program to run on the board,
                    'we add it to the multitask list
                    If itemMem(itemnum).BoardYN = 1 Then
                        If boardList(activeBoardIndex).theData.itemMulti$(itemnum) <> "" And UCase$(boardList(activeBoardIndex).theData.itemMulti$(itemnum)) <> "NONE" Then
                            multilist$(itemnum) = boardList(activeBoardIndex).theData.itemMulti$(itemnum)
                        Else
                            'MsgBox itmPrgOnBoard$(itemnum) + "$"
                            multilist$(itemnum) = itemMem(itemnum).itmPrgOnBoard$
                        End If
                    End If
                    x = boardList(activeBoardIndex).theData.itmX(itemnum)
                    y = boardList(activeBoardIndex).theData.itmY(itemnum)
                    If useSpriteLayer = False And useParallaxLayer = False Then
                        If bCopyUnderneath Then
                            Call CopyToBuffer(x - topX, y - topY, lay, itemnum + 5, 0, vbPicHDC(mainForm.boardform), -1) 'copies tile under item into buffer
                        End If
                    Else
                        If bCopyUnderneath Then
                            Call CopyToBuffer(x - topX, y - topY, lay, itemnum + 5, 0, CanvasHDC(LayerBoard), CanvasHDC(LayerBoardMask)) 'copies tile under item into buffer
                        End If
                    End If
                    xx = (x - topX) * 32 - 32
                    yy = (y - topY) * 32 - 32
                    If itemMem(itemnum).itmSizeType = 0 Then
                    Else
                        If useSpriteLayer = False And useParallaxLayer = False Then
                            Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), x - topX, y - topY - 1, addonr, addong, addonb, False)
                            Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), x - topX, y - topY, addonr, addong, addonb, False)
                        Else
                            If useSpriteLayer Then
                                Call drawtile(CanvasHDC(LayerSprites), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), x - topX, y - topY - 1, addonr, addong, addonb, False)
                                Call drawtile(CanvasHDC(LayerSprites), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), x - topX, y - topY, addonr, addong, addonb, False)
                                
                                Call drawtile(CanvasHDC(LayerSpritesMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), x - topX, y - topY - 1, addonr, addong, addonb, True, False)
                                Call drawtile(CanvasHDC(LayerSpritesMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), x - topX, y - topY, addonr, addong, addonb, True, False)
                            Else
                                Call drawtile(CanvasHDC(LayerBoard), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), x - topX, y - topY - 1, addonr, addong, addonb, False)
                                Call drawtile(CanvasHDC(LayerBoard), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), x - topX, y - topY, addonr, addong, addonb, False)
                                
                                Call drawtile(CanvasHDC(LayerBoardMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), x - topX, y - topY - 1, addonr, addong, addonb, True, False)
                                Call drawtile(CanvasHDC(LayerBoardMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), x - topX, y - topY, addonr, addong, addonb, True, False)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    Next itemnum
    'call vbpicrefresh(mainForm.boardform)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub DrawBoardBackgroundLayer()
    'draw background images
On Error Resume Next
    'fill with background color...
    
    If useSpriteLayer = False And useParallaxLayer = False Then
        Call vbPicFillRect(mainForm.boardform, 0, 0, tilesX * 32, tilesY * 32, boardList(activeBoardIndex).theData.brdColor)
    Else
        If useParallaxLayer Then
            Call CanvasFill(LayerBackground, boardList(activeBoardIndex).theData.brdColor)
        Else
            Call CanvasFill(LayerBoard, boardList(activeBoardIndex).theData.brdColor)
        End If
    End If
    
    mainForm.BackColor = boardList(activeBoardIndex).theData.borderColor
    
    'now load the border image, if any...
    If boardList(activeBoardIndex).theData.borderBack$ <> "" Then
        temp$ = projectPath$ + bmppath$ + boardList(activeBoardIndex).theData.borderBack$
        file$ = temp$
        Call vbFrmAutoRedraw(mainForm, True)
        If PakFileRunning Then
            F$ = PakLocate(file$)
            'mainForm.PicClip1.Picture = LoadPicture(F$)
            Call DrawSizedImage(F$, 0, 0, mainForm.width / Screen.TwipsPerPixelX, mainForm.height / Screen.TwipsPerPixelY, vbFrmHDC(mainForm))
        Else
            'mainForm.PicClip1.Picture = LoadPicture(file$)
            Call DrawSizedImage(file$, 0, 0, mainForm.width / Screen.TwipsPerPixelX, mainForm.height / Screen.TwipsPerPixelY, vbFrmHDC(mainForm))
        End If
        'mainForm.PicClip1.ClipX = 0
        'mainForm.PicClip1.ClipY = 0
        'mainForm.PicClip1.ClipHeight = mainForm.PicClip1.height
        'mainForm.PicClip1.ClipWidth = mainForm.PicClip1.width
        'mainForm.PicClip1.StretchX = mainForm.width / Screen.TwipsPerPixelX
        'mainForm.PicClip1.StretchY = mainForm.height / Screen.TwipsPerPixelY
        'mainForm.AutoRedraw = True
        'mainForm.Picture = LoadPicture("")
        'mainForm.Picture = mainForm.PicClip1.Clip
        Call vbFrmRefresh(mainForm)
        'Call LoadSizedPicture(temp$, mainForm.Picture)
        'mainForm.Picture = LoadPicture(temp$)
        'Kill temp$
    End If
    
    'now load the background image, if any...
    If boardList(activeBoardIndex).theData.brdBack$ <> "" Then
        temp$ = projectPath$ + bmppath$ + boardList(activeBoardIndex).theData.brdBack$
        file$ = temp$
        If useParallaxLayer Then
            If PakFileRunning Then
                F$ = PakLocate(file$)
                If Not (bUsingGDICanvas) Then
                    mainForm.parallax.Picture = LoadPicture(F$)
                Else
                    Call CanvasLoadFullPicture(LayerBackground, F$, tilesX * 32, tilesY * 32)
                End If
            Else
                If Not (bUsingGDICanvas) Then
                    mainForm.parallax.Picture = LoadPicture(file$)
                Else
                    Call CanvasLoadFullPicture(LayerBackground, file$, tilesX * 32, tilesY * 32)
                End If
            End If
        Else
            If PakFileRunning Then
                F$ = PakLocate(file$)
                If useSpriteLayer = False And useParallaxLayer = False Then
                    Call LoadSizedPicture(F$, mainForm.boardform)
                Else
                    Call CanvasLoadSizedPicture(LayerBoard, F$)
                End If
            Else
                If useSpriteLayer = False And useParallaxLayer = False Then
                    Call LoadSizedPicture(file$, mainForm.boardform)
                Else
                    Call CanvasLoadSizedPicture(LayerBoard, file$)
                End If
            End If
        End If
    End If
    
    'Call CanvasBlt(LayerBoard, 0, 0, vbpichdc(mainForm.boardform))
End Sub


Sub DrawBoardLayer(Optional ByVal refreshNow As Boolean = True)
    'draw the board onto the board layer
    On Error Resume Next
    
    'force music check...
    bWaitingForInput = False
    Call checkMusic

    'Ambient effects:
    Select Case boardList(activeBoardIndex).theData.ambienteffect
         Case 0
             addonr = 0
             addong = 0
             addonb = 0
         Case 1
             addonr = 75
             addong = 75
             addonb = 75
         Case 2
             addonr = -75
             addong = -75
             addonb = -75
         Case 3
             addonr = 0
             addong = 0
             addonb = 75
    End Select

    scrollCacheTopy = -1
    scrollCacheTopx = -1
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shader)
    a = GetVariable("AmbientGreen!", l$, shadeg)
    a = GetVariable("AmbientBlue!", l$, shadeb)
    
    shader = shader + addonr
    shadeg = shadeg + addong
    shadeb = shadeb + addonb
    
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightshade = DetermineLightLevel()
        shader = shader + lightshade
        shadeg = shadeg + lightshade
        shadeb = shadeb + lightshade
    End If
    
    FillStyle = 1
    'loading...
    
    fn$ = currentboard$
    fn$ = nopath(fn$)
    fn$ = brdpath$ + fn$
    
    If useParallaxLayer Then
        'put transparent color on the board canvas...
        Call CanvasFill(LayerBoard, RGB(0, 0, 0))
        Call CanvasFill(LayerBoardMask, RGB(255, 255, 255))
    End If
    If PakFileRunning Then
        Call ChangeDir(PakTempPath$)
        If useSpriteLayer = False And useParallaxLayer = False Then
            a = GFXdrawboard(vbPicHDC(mainForm.boardform), -1, 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
        Else
            If useParallaxLayer Then
                a = GFXdrawboard(CanvasHDC(LayerBoard), CanvasHDC(LayerBoardMask), 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
            Else
                a = GFXdrawboard(CanvasHDC(LayerBoard), -1, 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
            End If
        End If
        Call ChangeDir(currentdir$)
    Else
        ChDir (projectPath$)
        'qq = Timer
        If useSpriteLayer = False And useParallaxLayer = False Then
            a = GFXdrawboard(vbPicHDC(mainForm.boardform), -1, 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
        Else
            If useParallaxLayer Then
                a = GFXdrawboard(CanvasHDC(LayerBoard), CanvasHDC(LayerBoardMask), 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
            Else
                a = GFXdrawboard(CanvasHDC(LayerBoard), -1, 0, topX, topY, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shader, shadeg, shadeb, 0, 0)
            End If
        End If
        'MsgBox Str$(Timer - qq)
        ChDir (currentdir$)
    End If
    'a = Timer
    ChDir (currentdir$)
    If refreshNow Then
        If useSpriteLayer = False And useParallaxLayer = False Then
            Call vbPicRefresh(mainForm.boardform)
        Else
            Call CanvasRefresh(LayerBoard)
        End If
    End If
End Sub

Sub drawboardtile(x, y, layer)
    On Error GoTo errorhandler
amatch = checkmatch(x, y, layer, matchx, matchy)
If amatch = 0 Then
    'This tile has already been laid down
    'Now to bitblt it.
    copyx = (matchx - topX) * 32 - 32
    copyy = (matchy - topY) * 32 - 32
    newX = (x - topX) * 32 - 32
    newY = (y - topY) * 32 - 32
    Call copyimg(copyx, copyy, copyx + 32, copyy + 32, newX, newY)
    Exit Sub
End If
If amatch = -1 Then
    amatch = checkbuffermatch(x, y, layer, matchx, matchy)
End If
If amatch = 1 Then
    'Hey! it was in the buffer!
    'This tile has already been laid down
    'Now to bitblt it.
    copyx = (matchx) * 32 - 32
    copyy = (matchy) * 32 - 32
    newX = (x - topX) * 32 - 32
    newY = (y - topY) * 32 - 32
    Call copyimgBuf(copyx, copyy, copyx + 32, copyy + 32, newX, newY)
    Exit Sub
End If
If amatch = -1 Then
    'This tile must be drawn right now.
    'First, see if it's in an archive
    tileopen$ = projectPath$ + tilepath$ + BoardGetTile(x, y, layer, boardList(activeBoardIndex).theData)
    Call openwintile(tileopen$)
    If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
    xx = (x - topX) * 32 - 32
    yy = (y - topY) * 32 - 32
    oldyy = yy
    For dx = 1 To 32
        For dy = 1 To 32
            If tilemem(dx, dy) <> -1 Then
                colordraw = tilemem(dx, dy)
                tilered = red(tilemem(dx, dy))
                tilegreen = green(tilemem(dx, dy))
                tileblue = blue(tilemem(dx, dy))
                tilered = tilered + boardList(activeBoardIndex).theData.ambientred(x, y, layer) + addonr
                If tilered > 255 Then tilered = 255
                If tilered < 0 Then tilered = 0
                tilegreen = tilegreen + boardList(activeBoardIndex).theData.ambientgreen(x, y, layer) + addong
                If tilegreen > 255 Then tilegreen = 255
                If tilegreen < 0 Then tilegreen = 0
                tileblue = tileblue + boardList(activeBoardIndex).theData.ambientblue(x, y, layer) + addonb
                If tileblue > 255 Then tileblue = 255
                If tileblue < 0 Then tileblue = 0
                colordraw = RGB(tilered, tilegreen, tileblue)
                'aa = setPixel(vbpichdc(mainForm.boardform), xx, yy, colordraw)
                Call drawPixel(mainForm.boardform, xx, yy, colordraw)
                'mainForm.boardform.PSet (xx, yy), colordraw
            End If
            yy = yy + 1
        Next dy
        xx = xx + 1
        yy = oldyy
    Next dx
    'Now to copy this into the tile buffer:
    If y <> 11 Then Call copytoTileBuf(x, y, layer)
End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub DrawBoard(Optional ByVal refreshNow As Boolean = True)
    'Draws the board currently in memory
    On Error Resume Next
    'Call CanvasShow(LayerBackground)
    'Call CanvasShow(LayerBoard)
    
    If boardList(activeBoardIndex).theData.hasAnmTiles Then
        mainForm.animTimer.Enabled = True
    Else
        mainForm.animTimer.Enabled = False
    End If
    
    Call DrawBoardBackgroundLayer
    
    Call DrawBoardLayer(refreshNow)
    
    Call DrawSprites
    
    Call MergeLayersTo(mainForm.boardform)
    
    If refreshNow Then
        Call vbPicRefresh(mainForm.boardform)
    End If
End Sub


Sub DrawAllSprites()
    'draw all sprites onto the screen...
    On Error Resume Next
    
    Call playerSprite(curx(selectedPlayer), cury(selectedPlayer), curlayer(selectedPlayer), selectedPlayer, LastLaidPlayerGfx, vbPicHDC(mainForm.boardform))
    'For t = 0 To Len(boardlist(activeboardindex).thedata.itmX)
    'Next t
End Sub

Sub DrawSprites()
    'draw sprites (player, items and programs)
    On Error Resume Next
    
    Call CanvasFill(LayerSprites, RGB(0, 0, 0))
    Call CanvasFill(LayerSpritesMask, RGB(255, 255, 255))
    
    Call drawitems(1)
    Call drawprograms(1)
    
    'Call putplayer(curx(selectedplayer), cury(selectedplayer), curlayer(selectedplayer), 1, 1)
End Sub

Sub InitLayerSystem()
    'initialise layer system
    On Error Resume Next
    TranspColor = RGB(0, 0, 0)
    TranspColorMask = RGB(255, 255, 255)
    SolidColorMask = RGB(0, 0, 0)
    
    ScreenZoomFactor = 1
    
    LayerBackground = CreateCanvas(tilesX * 32, tilesY * 32)
    LayerBoard = CreateCanvas(tilesX * 32, tilesY * 32)
    LayerBoardMask = CreateCanvas(tilesX * 32, tilesY * 32)
    
    
    'sprites...
    LayerSprites = CreateCanvas(tilesX * 32, tilesY * 32)
    LayerSpritesMask = CreateCanvas(tilesX * 32, tilesY * 32)

    LayerSpriteCol = CreateCanvas(32, tilesY * 32)
    LayerSpriteColMask = CreateCanvas(32, tilesY * 32)
    Call CanvasFill(LayerSpriteCol, RGB(0, 0, 0))
    Call CanvasFill(LayerSpriteColMask, RGB(255, 255, 255))

    LayerSpriteRow = CreateCanvas(tilesX * 32, 32)
    LayerSpriteRowMask = CreateCanvas(tilesX * 32, 32)
    Call CanvasFill(LayerSpriteRow, RGB(0, 0, 0))
    Call CanvasFill(LayerSpriteRowMask, RGB(255, 255, 255))
    
    
    'fade layer...
    'LayerFade = CreateCanvas(tilesX * 32, tilesY * 32)
    'Call CanvasFill(LayerFade, RGB(255, 255, 255))
End Sub

Sub MergeLayersTo(pic As PictureBox)
    'merge the layers onto the boardform...
    On Error Resume Next
    
    If useSpriteLayer = False And useParallaxLayer = False Then
        Exit Sub
    End If
    
    Call vbPicAutoRedraw(pic, True)
    pic.Picture = LoadPicture("")
    
    'Call CanvasRefresh(LayerBackground)
    'Call CanvasRefresh(LayerBoard)
    'Call CanvasRefresh(LayerBoardMask)
    
    If boardList(activeBoardIndex).theData.brdBack <> "" Then
        'blt the background parallax image.
        'we may have to 'scroll' it...
        tpX = 0
        tpY = 0
        tW = tilesX * 32
        tH = tilesY * 32
        
        bsX = boardList(activeBoardIndex).theData.Bsizex * 32
        bsY = boardList(activeBoardIndex).theData.Bsizey * 32
        
        
        If Not (bUsingGDICanvas) Then
            cW = mainForm.parallax.width '/ Screen.TwipsPerPixelX
            cH = mainForm.parallax.height '/ Screen.TwipsPerPixelY
        Else
            cH = GetCanvasHeight(LayerBackground)
            cW = GetCanvasWidth(LayerBackground)
        End If
        If cW > tW Then
            percentScrollX = topx2 / (boardList(activeBoardIndex).theData.Bsizex - tilesX)
            maxScrollX = cW - tW
            tpX = Int(maxScrollX * percentScrollX)
        End If
        
        If cH > tH Then
            percentScrollY = topy2 / (boardList(activeBoardIndex).theData.Bsizey - tilesY)
            maxScrollY = cH - tH
            tpY = Int(maxScrollY * percentScrollY)
        End If
        If Not (bUsingGDICanvas) Then
            mainForm.parallax.ClipX = tpX
            mainForm.parallax.ClipY = tpY
            mainForm.parallax.ClipHeight = tH
            mainForm.parallax.ClipWidth = tW
            
            If mainForm.parallax.width < pic.width Then
                mainForm.parallax.StretchX = pic.width / Screen.TwipsPerPixelX
            End If
            If mainForm.parallax.height < pic.height Then
                mainForm.parallax.StretchY = pic.height / Screen.TwipsPerPixelY
            End If
                    
            Call CanvasSetPicture(LayerBackground, mainForm.parallax)
        End If
    End If
    
    If ScreenZoomFactor = 1 Then
        If useParallaxLayer Then
            If boardList(activeBoardIndex).theData.brdBack <> "" Then
                If bUsingGDICanvas Then
                    Call CanvasBlt2(LayerBackground, 0, 0, tpX, tpY, tW, tH, vbPicHDC(pic))
                Else
                    Call CanvasBlt(LayerBackground, 0, 0, vbPicHDC(pic))
                End If
            Else
                Call vbPicFillRect(pic, 0, 0, tilesX * 32, tilesY * 32, boardList(activeBoardIndex).theData.brdColor)
            End If
            Call CanvasMaskBlt(LayerBoard, LayerBoardMask, 0, 0, vbPicHDC(pic))
        Else
            Call CanvasBlt(LayerBoard, 0, 0, vbPicHDC(pic))
        End If
        If useSpriteLayer Then
            Call CanvasMaskBlt(LayerSprites, LayerSpritesMask, 0, 0, vbPicHDC(pic))
        Else
        End If
        'Call CanvasBltAnd(LayerFade, 0, 0, vbPicHDC(pic))
    Else
        'need to zoom the screen!
        'get screen dimensions...
        W = GetCanvasWidth(LayerBoard)
        H = GetCanvasHeight(LayerBoard)
        
        'calculate new width and height...
        w2 = W * ScreenZoomFactor
        h2 = H * ScreenZoomFactor
        
        'centre it...
        x = (W - w2) / 2
        y = (H - h2) / 2
    
        'blt them...
        If boardList(activeBoardIndex).theData.brdBack <> "" Then
            Call CanvasStretchBlt2(LayerBackground, w2, h2, x, y, 0, 0, tW, tH, vbPicHDC(pic))
        Else
            Call vbPicFillRect(pic, 0, 0, tilesX * 32, tilesY * 32, boardList(activeBoardIndex).theData.brdColor)
        End If
        If useParallaxLayer Then
            Call CanvasMaskBltStretch(LayerBoard, LayerBoardMask, x, y, w2, h2, vbPicHDC(pic))
        Else
            'Call CanvasStretchBlt(LayerBoard, x, y, w2, h2, vbPicHDC(pic))
        End If
        If useSpriteLayer Then
            Call CanvasMaskBltStretch(LayerSprites, LayerSpritesMask, x, y, w2, h2, vbPicHDC(pic))
        End If
    End If
End Sub


