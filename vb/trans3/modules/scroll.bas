Attribute VB_Name = "SCROLL"
'scroll- the crap that makes the board scroll
'5/25/99

'scrollcache info...
Global scrollCacheTopx, scrollCacheTopy 'current coords of scrollcache (-1,-1 means no image is there)


'Module array to store bitmap handles selected out of DCs
Dim miSavedBitmaps(3) As Long        'Used in resources example

Public Const scrollCacheWidth = 35      'x size  in tiles of scroll cache
Public Const scrollCacheHeight = 35     'y size

'Windows resources functions
Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, ByVal lpBits As Any) As Long
Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
'Windows resources functions for VB 4 users
'Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
'Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
'Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
'Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
'Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
'Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
'Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
'Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
'Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

Sub pScrollDownLeft(part)
    'assumes that the row and column is already
    'saved onto the rowstrip and colstrip.
    'now scroll the board down,left...
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    c = 4
    t = part
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            (-32 / c), (32 / c), tilesX * 32, tilesY * 32, _
            vbPicHDC(mainForm.boardform), 0, 0, SRCCOPY)
        
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)

        a = BitBlt(vbPicHDC(mainForm.boardform), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub drawPixela(pic As PictureBox, x, y, color)
'Draws a 'pixel' of proper scale
'If ddx = 1 And ddy = 1 Then
    On Error GoTo errorhandler
    a = SetPixel(vbPicHDC(pic), x, y, color)
    'pic.PSet (x, y), color
'    Exit Sub
'End If

'pic.Line (x * ddx, y * ddy)-(x * ddx + ddx, y * ddy + ddy), color, BF

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub columnBlt(x, y)
    'blts the column from the scrollcache into the strip.
    On Error GoTo errorhandler
    xx = x - scrollCacheTopx
    yy = y - scrollCacheTopy
    xx = xx * 32 '- 32
    yy = yy * 32 '- 32
    Call CanvasFill(colStripCanvas, TranspColor)
    a = BitBlt(CanvasHDC(colStripCanvas), 0, 0, 32, 32 * tilesY, CanvasHDC(scrollCacheCanvas), xx, yy, SRCCOPY)
    Call CanvasRefresh(colStripCanvas)

    a = BitBlt(CanvasHDC(colStripMask), 0, 0, 32, 32 * tilesY, CanvasHDC(scrollCacheMask), xx, yy, SRCCOPY)
    Call CanvasRefresh(colStripMask)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub drawColumnPrograms(x, y)
    'draws all programs on specified layer.
    'first things first- what prgs are on this layer?
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
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonr = addonr + shadeR
    addong = addong + shadeG
    addonb = addonb + shadeB
    
    For prgnum = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        'MsgBox programname$(prgnum) + " " + proggraphic$(prgnum) + Str$(prgnum)
        If boardList(activeBoardIndex).theData.programName$(prgnum) <> "" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "" Then
            'check if it's activated
            runit = 1
            If boardList(activeBoardIndex).theData.progY(prgnum) >= y And boardList(activeBoardIndex).theData.progY(prgnum) <= y + tilesY Then
                If boardList(activeBoardIndex).theData.progX(prgnum) = x Then
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
                        'xxx = progx(prgnum)
                        yyy = boardList(activeBoardIndex).theData.progY(prgnum)
                        'aa = fileExist(projectPath$ + tilepath$ + boardlist(activeboardindex).thedata.progGraphic$(prgnum))
                        aa = 1
                        If aa = 1 Then
                            Call openwintile(projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum))
                            If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
                            'xx = (xxx - topx) * 32 - 32
                            xx = 0
                            yy = (yyy - topY) * 32 - 32
                            'yy = 0
                            For dy = 1 To 32
                                For dx = 1 To 32
                                    If tilemem(dx, dy) <> -1 Then
                                        rr = red(tilemem(dx, dy)) + addonr
                                        gg = green(tilemem(dx, dy)) + addong
                                        bb = blue(tilemem(dx, dy)) + addonb
                                        vvv = CanvasSetPixel(colStripCanvas, xx, yy, myRGB(rr, gg, bb))
                                    End If
                                    xx = xx + 1
                                Next dx
                                yy = yy + 1
                                xx = 0
                                'xx = (xxx - topx) * 32 - 32
                            Next dy
                        End If
                    End If
                End If
            End If
        End If
    Next prgnum
    Call CanvasRefresh(colStripCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CopyToColBuffer(x, y, lay, bufnum)
    On Error GoTo errorhandler
    x1 = x * 32 - 32
    y1 = y * 32 - 32
    Call vbPicAutoRedraw(mainForm.bufferform(bufnum), True)
    If Not (bUseSpriteBufferCanvas) Then
        a = BitBlt(vbPicHDC(mainForm.bufferform(bufnum)), 0, 0, 38, 38, CanvasHDC(colStripCanvas), x1, y1, &HCC0020)
        a = BitBlt(vbPicHDC(mainForm.buffermaskform(bufnum)), 0, 0, 38, 38, CanvasHDC(colStripMask), x1, y1, &HCC0020)
    Else
        a = BitBlt(CanvasHDC(spriteBuffer(bufnum)), 0, 0, 38, 38, CanvasHDC(colStripCanvas), x1, y1, &HCC0020)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Colcopyimg(x1, y1, x2, y2, xDest, yDest)
    'xs = xmax / 608
    'ys = ymax / 352
    'xd = round(xdest * xs)
    'yd = round(ydest * ys)
    On Error GoTo errorhandler
    xd = xDest
    yd = yDest
    a = BitBlt(CanvasHDC(colStripCanvas), xd, yd, (x2 - x1), (y2 - y1), CanvasHDC(colStripCanvas), x1, y1, &HCC0020)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub copyToBottomRowBuffer(x, y, lay, bufnum, ByVal sourceDC As Long, ByVal maskDC As Long)
    On Error GoTo errorhandler
    x1 = x * 32 - 32
    y1 = y * 32 - 32
    Call vbPicAutoRedraw(mainForm.bufferform(bufnum), True)
    If Not (bUseSpriteBufferCanvas) Then
        a = BitBlt(vbPicHDC(mainForm.bufferform(bufnum)), 0, 32, 38, 38, sourceDC, x1, y1, &HCC0020)
        If (maskDC <> -1) Then
            a = BitBlt(vbPicHDC(mainForm.buffermaskform(bufnum)), 0, 32, 38, 38, maskDC, x1, y1, &HCC0020)
        End If
    Else
        a = BitBlt(CanvasHDC(spriteBuffer(bufnum)), 0, 32, 38, 38, sourceDC, x1, y1, &HCC0020)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub copyToTopRowBuffer(x, y, lay, bufnum, ByVal sourceDC As Long, ByVal maskDC As Long)
    On Error GoTo errorhandler
    x1 = x * 32 - 32
    y1 = y * 32 - 32
    Call vbPicAutoRedraw(mainForm.bufferform(bufnum), True)
    If Not (bUseSpriteBufferCanvas) Then
        a = BitBlt(vbPicHDC(mainForm.bufferform(bufnum)), 0, 0, 38, 38, sourceDC, x1, y1, &HCC0020)
        If maskDC <> -1 Then
            a = BitBlt(vbPicHDC(mainForm.buffermaskform(bufnum)), 0, 0, 38, 38, maskDC, x1, y1, &HCC0020)
        End If
    Else
        a = BitBlt(CanvasHDC(spriteBuffer(bufnum)), 0, 32, 38, 38, sourceDC, x1, y1, &HCC0020)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub drawColumnItems(x, y)
    'draws items in the colstrip column
    'before being placed on screen.
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
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonr = addonr + shadeR
    addong = addong + shadeG
    addonb = addonb + shadeB
    
    Call CanvasFill(LayerSpriteCol, RGB(0, 0, 0))
    Call CanvasFill(LayerSpriteColMask, RGB(255, 255, 255))
    
    For itemnum = 0 To 10
        If boardList(activeBoardIndex).theData.itmName$(itemnum) <> "" Then
            If itemMem(itemnum).BoardYN = 1 Then
                If boardList(activeBoardIndex).theData.itemMulti$(itemnum) <> "" Then
                    multilist$(itemnum) = boardList(activeBoardIndex).theData.itemMulti$(itemnum)
                Else
                    multilist$(itemnum) = itemMem(itemnum).itmPrgOnBoard$
                End If
            End If
            xxx = boardList(activeBoardIndex).theData.itmX(itemnum)
            yyy = boardList(activeBoardIndex).theData.itmY(itemnum)
            If xxx = x And yyy >= y And yyy <= y + tilesY Then
                If useSpriteLayer Then
                    Call drawtile(CanvasHDC(LayerSpriteCol), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), 1, yyy - topY - 1, addonr, addong, addonb, False)
                    Call drawtile(CanvasHDC(LayerSpriteCol), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), 1, yyy - topY, addonr, addong, addonb, False)
                
                    'mask
                    Call drawtile(CanvasHDC(LayerSpriteColMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), 1, yyy - topY - 1, addonr, addong, addonb, True, False)
                    Call drawtile(CanvasHDC(LayerSpriteColMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), 1, yyy - topY, addonr, addong, addonb, True, False)
                Else
                    Call CopyToColBuffer(1, yyy - topY, lay, itemnum + 5) 'copies tile under item into buffer
                    Call drawtile(CanvasHDC(colStripCanvas), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), 1, yyy - topY - 1, addonr, addong, addonb, False)
                    Call drawtile(CanvasHDC(colStripCanvas), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), 1, yyy - topY, addonr, addong, addonb, False)
                
                    'mask
                    Call drawtile(CanvasHDC(colStripMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), 1, yyy - topY - 1, addonr, addong, addonb, True, False)
                    Call drawtile(CanvasHDC(colStripMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), 1, yyy - topY, addonr, addong, addonb, True, False)
                End If
            End If
        End If
    Next itemnum
    Call CanvasRefresh(colStripCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawColumnTile(x, y, lay)
    'quickly draw a tile for a col
    On Error GoTo errorhandler
    fname$ = BoardGetTile(x, y, lay, boardList(activeBoardIndex).theData)
    If fname$ = "" Then Exit Sub
    r = boardList(activeBoardIndex).theData.ambientred(x, y, lay)
    g = boardList(activeBoardIndex).theData.ambientgreen(x, y, lay)
    b = boardList(activeBoardIndex).theData.ambientblue(x, y, lay)
    For yy = topY + 1 To y
        If BoardGetTile(x, yy, lay, boardList(activeBoardIndex).theData) = fname$ And yy <> y Then
            'found matching filename.
            'check colors...
            If boardList(activeBoardIndex).theData.ambientred(x, yy, lay) = r And _
                boardList(activeBoardIndex).theData.ambientgreen(x, yy, lay) = g And _
                boardList(activeBoardIndex).theData.ambientblue(x, yy, lay) = b Then
                'we found a match!!!
                'now copy it...
                'MsgBox "here"
                Call Colcopyimg(0, (yy - topY) * 32 - 32, 32, (yy - topY) * 32, 0, (y - topY) * 32 - 32)
                Exit Sub
            End If
        End If
    Next yy
    'if we've come here, then we must draw the image...
    'MsgBox "here"
    'internal engine drawing routines
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    r = r + shadeR
    g = g + shadeG
    b = b + shadeB
    Call drawtile(CanvasHDC(colStripCanvas), projectPath$ + tilepath$ + fname$, 1, y - topY, r, g, b, False)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub drawRowItems(x, y)
    'draws items in the rowstrip row
    'before being placed on screen.
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
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonr = addonr + shadeR
    addong = addong + shadeG
    addonb = addonb + shadeB
    
    Call CanvasFill(LayerSpriteRow, RGB(0, 0, 0))
    Call CanvasFill(LayerSpriteRowMask, RGB(255, 255, 255))
    
    For itemnum = 0 To 10
        If boardList(activeBoardIndex).theData.itmName$(itemnum) <> "" Then
            If itemMem(itemnum).BoardYN = 1 Then
                If boardList(activeBoardIndex).theData.itemMulti$(itemnum) <> "" Then
                    multilist$(itemnum) = boardList(activeBoardIndex).theData.itemMulti$(itemnum)
                Else
                    multilist$(itemnum) = itemMem(itemnum).itmPrgOnBoard$
                End If
            End If
            xxx = boardList(activeBoardIndex).theData.itmX(itemnum)
            yyy = boardList(activeBoardIndex).theData.itmY(itemnum)
            'bottom of 64x32 item
            If yyy = y And xxx >= x And xxx <= x + tilesX Then
                If useSpriteLayer Then
                    Call drawtile(CanvasHDC(LayerSpriteRow), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), xxx - topX, 1, addonr, addong, addonb, False)
                    'mask
                    Call drawtile(CanvasHDC(LayerSpriteRowMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), xxx - topX, 1, addonr, addong, addonb, True)
                Else
                    If y = tilesY + topY + 1 Then
                        'bottom
                        If useParallaxLayer Then
                            Call copyToTopRowBuffer(xxx - topX, tilesY, lay, itemnum + 5, CanvasHDC(LayerBoard), CanvasHDC(LayerBoardMask)) 'copies tile under item into buffer
                        Else
                            Call copyToTopRowBuffer(xxx - topX, tilesY, lay, itemnum + 5, vbPicHDC(mainForm.boardform), -1) 'copies tile under item into buffer
                        End If
                        Call copyToBottomRowBuffer(xxx - topX, 1, lay, itemnum + 5, CanvasHDC(rowStripCanvas), CanvasHDC(rowStripMask)) 'copies tile under item into buffer
                    Else
                        'top
                        Call copyToTopRowBuffer(xxx - topX, tilesY, lay, itemnum + 5, CanvasHDC(rowStripCanvas), CanvasHDC(rowStripMask)) 'copies tile under item into buffer
                        If useParallaxLayer Then
                            Call copyToBottomRowBuffer(xxx - topX, 1, lay, itemnum + 5, CanvasHDC(LayerBoard), CanvasHDC(LayerBoardMask)) 'copies tile under item into buffer
                        Else
                            Call copyToBottomRowBuffer(xxx - topX, 1, lay, itemnum + 5, vbPicHDC(mainForm.boardform), -1) 'copies tile under item into buffer
                        End If
                    End If
                    Call drawtile(CanvasHDC(rowStripCanvas), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), xxx - topX, 1, addonr, addong, addonb, False)
                    'mask
                    Call drawtile(CanvasHDC(rowStripMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(1), xxx - topX, 1, addonr, addong, addonb, True, False)
                    
                    If y = tilesY + topY + 1 Then
                        'bottom
                        If useParallaxLayer Then
                            Call drawtile(CanvasHDC(LayerBoard), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, y - topY - 1, addonr, addong, addonb, False)
                            'mask
                            Call drawtile(CanvasHDC(LayerBoardMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, y - topY - 1, addonr, addong, addonb, True, False)
                        Else
                            Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, y - topY - 1, addonr, addong, addonb, False)
                        End If
                    Else
                        'top
                        If useParallaxLayer Then
                            Call drawtile(CanvasHDC(LayerBoard), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, 1, addonr, addong, addonb, False)
                            'mask
                            Call drawtile(CanvasHDC(LayerBoardMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, 1, addonr, addong, addonb, True, False)
                        Else
                            Call drawtile(vbPicHDC(mainForm.boardform), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topX, 1, addonr, addong, addonb, False)
                        End If
                    End If
                End If
            End If
            'top of 64x32 item
            'UNCOMMENT WHEN YOU AREN'T SO LAZY AND CAN FIX THIS, CHRIS!
            'If yyy = y + 1 And xxx >= x And xxx <= x + tilesX Then
            '    If useSpriteLayer Then
            '        Call drawtile(CanvasHDC(LayerSpriteRow), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topx, 1, addonr, addong, addonb, False)
            '        'mask
            '        Call drawtile(CanvasHDC(LayerSpriteRowMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topx, 1, addonr, addong, addonb, True)
            '    Else
            '        Call copyToTopRowBuffer(xxx - topx, tilesY, lay, itemnum + 5) 'copies tile under item into buffer
            '        Call drawtile(CanvasHDC(rowStripCanvas), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topx, 1, addonr, addong, addonb, False)
            '        'mask
            '        Call drawtile(CanvasHDC(rowStripMask), projectPath$ + tilepath$ + itemMem(itemnum).itmrestGfx$(0), xxx - topx, 1, addonr, addong, addonb, True, False)
            '    End If
            'End If
        End If
    Next itemnum
    Call CanvasRefresh(rowStripCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawRowPrograms(x, y)
    'draws all programs on specified layer.
    'first things first- what prgs are on this layer?
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
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    addonr = addonr + shadeR
    addong = addong + shadeG
    addonb = addonb + shadeB
    
    For prgnum = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        'MsgBox programname$(prgnum) + " " + proggraphic$(prgnum) + Str$(prgnum)
        If boardList(activeBoardIndex).theData.programName$(prgnum) <> "" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "None" And boardList(activeBoardIndex).theData.progGraphic$(prgnum) <> "" Then
            'check if it's activated
            runit = 1
            If boardList(activeBoardIndex).theData.progX(prgnum) >= x And boardList(activeBoardIndex).theData.progX(prgnum) <= x + tilesX Then
                If boardList(activeBoardIndex).theData.progY(prgnum) = y Then
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
                        xxx = boardList(activeBoardIndex).theData.progX(prgnum)
                        'aa = fileExist(projectPath$ + tilepath$ + boardlist(activeboardindex).thedata.progGraphic$(prgnum))
                        aa = 1
                        If aa = 1 Then
                            Call openwintile(projectPath$ + tilepath$ + boardList(activeBoardIndex).theData.progGraphic$(prgnum))
                            If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
                            xx = (xxx - topX) * 32 - 32
                            'yy = (y - topy) * 32 - 32
                            yy = 0
                            For dy = 1 To 32
                                For dx = 1 To 32
                                    If tilemem(dx, dy) <> -1 Then
                                        rr = red(tilemem(dx, dy)) + addonr
                                        gg = green(tilemem(dx, dy)) + addong
                                        bb = blue(tilemem(dx, dy)) + addonb
                                        vvv = CanvasSetPixel(rowStripCanvas, xx, yy, myRGB(rr, gg, bb))
                                    End If
                                    xx = xx + 1
                                Next dx
                                yy = yy + 1
                                xx = (xxx - topX) * 32 - 32
                            Next dy
                        End If
                    End If
                End If
            End If
        End If
    Next prgnum
    Call CanvasRefresh(rowStripCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drawRowTile(x, y, lay)
    'quickly draw a tile for a row
    On Error GoTo errorhandler
    fname$ = BoardGetTile(x, y, lay, boardList(activeBoardIndex).theData)
    If fname$ = "" Then Exit Sub
    r = boardList(activeBoardIndex).theData.ambientred(x, y, lay)
    g = boardList(activeBoardIndex).theData.ambientgreen(x, y, lay)
    b = boardList(activeBoardIndex).theData.ambientblue(x, y, lay)
    For xx = topX + 1 To x
        If BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData) = fname$ And xx <> x Then
            'found matching filename.
            'check colors...
            If boardList(activeBoardIndex).theData.ambientred(xx, y, lay) = r And _
                boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay) = g And _
                boardList(activeBoardIndex).theData.ambientblue(xx, y, lay) = b Then
                'we found a match!!!
                'now copy it...
                'MsgBox "here"
                Call RowcopyImg((xx - topX) * 32 - 32, 0, (xx - topX) * 32, 32, (x - topX) * 32 - 32, 0)
                Exit Sub
            End If
        End If
    Next xx
    'if we've come here, then we must draw the image...
    'MsgBox "here"
    'first, get the shade color of the board...
    a = GetVariable("AmbientRed!", l$, shadeR)
    a = GetVariable("AmbientGreen!", l$, shadeG)
    a = GetVariable("AmbientBlue!", l$, shadeB)
    'now check day and night info...
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        lightShade = DetermineLightLevel()
        shadeR = shadeR + lightShade
        shadeG = shadeG + lightShade
        shadeB = shadeB + lightShade
    End If
    
    r = r + shadeR
    g = g + shadeG
    b = b + shadeB
    Call drawtile(CanvasHDC(rowStripCanvas), projectPath$ + tilepath$ + fname$, x - topX, 1, r, g, b, False)



    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub inSetupColumnScroll(x, y)
    'internal column scroll draw routine
    On Error GoTo errorhandler
    For lay = 1 To 8
        For yy = y To y + tilesY - 1
            If BoardGetTile(x, yy, lay, boardList(activeBoardIndex).theData) <> "" Then
                Call drawColumnTile(x, yy, lay)
            End If
        Next yy
    Next lay
    Call CanvasRefresh(colStripCanvas)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub inSetupRowScroll(x, y)
    'internal column scroll draw routine
    On Error GoTo errorhandler
    For lay = 1 To 8
        For xx = x To x + tilesX - 1
            If BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData) <> "" Then
                Call drawRowTile(xx, y, lay)
            End If
        Next xx
    Next lay

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub pScrollDown(part, ByVal mergenow As Boolean)
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board down...
    On Error GoTo errorhandler
    c = 4
    t = part
    'shift board down...
    If useSpriteLayer = False And useParallaxLayer = False Then
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            0, (32 / c), tilesX * 32, tilesY * 32, _
            vbPicHDC(mainForm.boardform), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)
    Else
        a = BitBlt(CanvasHDC(LayerBoard), _
            0, (32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoard), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            0, (32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoardMask), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(CanvasHDC(LayerBoard), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripMask), 0, 0, SRCCOPY)
        
        'scroll the sprites layer...
        a = BitBlt(CanvasHDC(LayerSprites), _
            0, (32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSprites), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            0, (32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSpritesMask), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(CanvasHDC(LayerSprites), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(LayerSpriteRow), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            0, -32 + (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(LayerSpriteRowMask), 0, 0, SRCCOPY)
    
        If mergenow Then Call MergeLayersTo(mainForm.boardform)
    End If

    'shift board down...
    'a = BitBlt(vbpichdc(mainForm.boardform), _
        0, (32 / c), tilesX * 32, tilesY * 32, _
        vbpichdc(mainForm.boardform), 0, 0, SRCCOPY)
    'add part of rowstrip...
    'a = BitBlt(vbpichdc(mainForm.boardform), _
        0, -32 + (32 / c * t), tilesX * 32, 32, _
        CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub pScrollLeft(part, ByVal mergenow As Boolean)
    'scrolls left.
    'assumes graphic is already drawn in colstrip.
    'part determines what step we are at in scrolling.
    'part=1 =1/4
    '2=2/4
    '3=3/4
    '4=4/4
    'You must call it in order 1,2,3,4
    'it assumes the others have already shifted it.
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    c = 4
    t = part
    If useSpriteLayer = False And useParallaxLayer = False Then
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            (-32 / c), 0, tilesX * 32, tilesY * 32, _
            vbPicHDC(mainForm.boardform), 0, 0, SRCCOPY)
        'add part of colstrip...
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
    Else
        a = BitBlt(CanvasHDC(LayerBoard), _
            (-32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoard), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            (-32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoardMask), 0, 0, SRCCOPY)
        'add part of colstrip...
        a = BitBlt(CanvasHDC(LayerBoard), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripMask), 0, 0, SRCCOPY)
    
        'scroll the sprites layer...
        a = BitBlt(CanvasHDC(LayerSprites), _
            (-32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSprites), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            (-32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSpritesMask), 0, 0, SRCCOPY)
        'add part of colstrip...
        a = BitBlt(CanvasHDC(LayerSprites), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(LayerSpriteCol), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
            CanvasHDC(LayerSpriteColMask), 0, 0, SRCCOPY)
    
        If mergenow Then Call MergeLayersTo(mainForm.boardform)
    End If

    'Call MergeLayersTo(mainForm.boardform)

    'a = BitBlt(vbpichdc(mainForm.boardform), _
        (-32 / c), 0, tilesX * 32, tilesY * 32, _
        vbpichdc(mainForm.boardform), 0, 0, SRCCOPY)
    'add part of colstrip...
    'a = BitBlt(vbpichdc(mainForm.boardform), _
        tilesX * 32 - (32 / c * t), 0, 32, tilesY * 32, _
        CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub pScrollRight(part, ByVal mergenow As Boolean)
    'scrolls right.
    'assumes graphic is already drawn in colstrip.
    'part determines what step we are at in scrolling.
    'part=1 =1/4
    '2=2/4
    '3=3/4
    '4=4/4
    'You must call it in order 1,2,3,4
    'it assumes the others have already shifted it.
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    c = 4
    t = part
    If useSpriteLayer = False And useParallaxLayer = False Then
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            (32 / c), 0, tilesX * 32, tilesY * 32, _
            vbPicHDC(mainForm.boardform), 0, 0, SRCCOPY)
        'scroll colstrip
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
    Else
        a = BitBlt(CanvasHDC(LayerBoard), _
            (32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoard), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            (32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoardMask), 0, 0, SRCCOPY)
        'scroll colstrip
        a = BitBlt(CanvasHDC(LayerBoard), _
            -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
            CanvasHDC(colStripMask), 0, 0, SRCCOPY)
        
        'scroll the sprites layer...
        a = BitBlt(CanvasHDC(LayerSprites), _
            (32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSprites), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            (32 / c), 0, tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSpritesMask), 0, 0, SRCCOPY)
        'scroll colstrip
        a = BitBlt(CanvasHDC(LayerSprites), _
            -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
            CanvasHDC(LayerSpriteCol), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
            CanvasHDC(LayerSpriteColMask), 0, 0, SRCCOPY)
    
        If mergenow Then Call MergeLayersTo(mainForm.boardform)
    End If
    'Call MergeLayersTo(mainForm.boardform)

    'a = BitBlt(vbpichdc(mainForm.boardform), _
        (32 / c), 0, tilesX * 32, tilesY * 32, _
        vbpichdc(mainForm.boardform), 0, 0, SRCCOPY)
    'a = BitBlt(vbpichdc(mainForm.boardform), _
        -32 + ((32 / c) * t), 0, 32, tilesY * 32, _
        CanvasHDC(colStripCanvas), 0, 0, SRCCOPY)
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub pScrollUp(part, ByVal mergenow As Boolean)
    'assumes that the row is already
    'saved onto the rowstrip.
    'now scroll the board up...
    On Error GoTo errorhandler
    Call vbPicAutoRedraw(mainForm.boardform, True)
    c = 4
    t = part
    If useSpriteLayer = False And useParallaxLayer = False Then
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            0, (-32 / c), tilesX * 32, tilesY * 32, _
            vbPicHDC(mainForm.boardform), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(vbPicHDC(mainForm.boardform), _
            0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)
    Else
        a = BitBlt(CanvasHDC(LayerBoard), _
            0, (-32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoard), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            0, (-32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerBoardMask), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(CanvasHDC(LayerBoard), _
            0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerBoardMask), _
            0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(rowStripMask), 0, 0, SRCCOPY)
        
        'scroll the sprites layer...
        a = BitBlt(CanvasHDC(LayerSprites), _
            0, (-32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSprites), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            0, (-32 / c), tilesX * 32, tilesY * 32, _
            CanvasHDC(LayerSpritesMask), 0, 0, SRCCOPY)
        'add part of rowstrip...
        a = BitBlt(CanvasHDC(LayerSprites), _
            0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(LayerSpriteRow), 0, 0, SRCCOPY)
        a = BitBlt(CanvasHDC(LayerSpritesMask), _
            0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
            CanvasHDC(LayerSpriteRowMask), 0, 0, SRCCOPY)
        
        If mergenow Then Call MergeLayersTo(mainForm.boardform)
    End If
    
    'Call MergeLayersTo(mainForm.boardform)

    'a = BitBlt(vbpichdc(mainForm.boardform), _
        0, (-32 / c), tilesX * 32, tilesY * 32, _
        vbpichdc(mainForm.boardform), 0, 0, SRCCOPY)
    'add part of rowstrip...
    'a = BitBlt(vbpichdc(mainForm.boardform), _
        0, tilesY * 32 - (32 / c * t), tilesX * 32, 32, _
        CanvasHDC(rowStripCanvas), 0, 0, SRCCOPY)
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub pShiftDown(part)
    'shifts the board down (scroll north)
    On Error GoTo errorhandler
    If topY < 0 Then Exit Sub
    Call setupRowScroll(topX + 1, topY + 1)
    Call pScrollDown(part, True)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub pShiftLeft(part)
    'shifts the board left by only a part
    'part=1 =1/4
    '2=2/4
    '3=3/4
    '4=4/4
    'You must call it in order 1,2,3,4
    'it assumes the others have already shifted it.
    On Error GoTo errorhandler
    If topX = 50 - tilesX Then Exit Sub
    Call setupColumnScroll(topX + tilesX, topY + 1)
    Call pScrollLeft(part, True)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub pShiftRight(part)
    'shifts the board right by only a part
    'part=1 =1/4
    '2=2/4
    '3=3/4
    '4=4/4
    'You must call it in order 1,2,3,4
    'it assumes the others have already shifted it.
    On Error GoTo errorhandler
    If topX < 0 Then Exit Sub
    Call setupColumnScroll(topX + 1, topY + 1)
    Call pScrollRight(part, True)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub pShiftUp(part)
    'shifts the board up (scroll south)
    On Error GoTo errorhandler
    If topY = 50 - tilesY Then Exit Sub
    'If topy = 50 - tilesx Then Exit Sub
    Call setupRowScroll(topX + 1, topY + tilesY)
    Call pScrollUp(part, True)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub





Sub rowBlt(x, y)
    'blts the row from the scrollcache into the strip.
    On Error GoTo errorhandler
    xx = x - scrollCacheTopx
    yy = y - scrollCacheTopy
    xx = xx * 32 '- 32
    yy = yy * 32 '- 32
    Call CanvasFill(rowStripCanvas, TranspColor)
    a = BitBlt(CanvasHDC(rowStripCanvas), 0, 0, 32 * tilesX, 32, CanvasHDC(scrollCacheCanvas), xx, yy, SRCCOPY)
    Call CanvasRefresh(rowStripCanvas)

    a = BitBlt(CanvasHDC(rowStripMask), 0, 0, 32 * tilesX, 32, CanvasHDC(scrollCacheMask), xx, yy, SRCCOPY)
    Call CanvasRefresh(rowStripMask)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub RowcopyImg(x1, y1, x2, y2, xDest, yDest)
    'xs = xmax / 608
    'ys = ymax / 352
    'xd = round(xdest * xs)
    'yd = round(ydest * ys)
    On Error GoTo errorhandler
    xd = xDest
    yd = yDest
    a = BitBlt(CanvasHDC(rowStripCanvas), xd, yd, (x2 - x1), (y2 - y1), CanvasHDC(rowStripCanvas), x1, y1, &HCC0020)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub setupRowScroll(x, y)
    'sets up scrolling on a row
    'copies the next row into the rowstrip box
    On Error Resume Next
    
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
    
    If useFastDraw = 1 Then
        If mainMem.mainScreenType = 1 Or mainMem.mainScreenType = 2 Or (screenWidth) = 640 * Screen.TwipsPerPixelX Then
            'If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or x < scrollCacheTopx Or x > scrollCacheTopx + tilesX - 1 _
                Or y < scrollCacheTopy Or y > scrollCacheTopy + tilesY - 2 Then
            If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or y < scrollCacheTopy Or y > scrollCacheTopy + tilesY - 2 Then
            'If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or y < scrollCacheTopy Or y > scrollCacheTopy + scrollCacheHeight - 2 Then
                '    MsgBox Str$(x) + Str$(y)
                xx = x
                yy = y - Int(tilesY / 2)
                If xx < 0 Then xx = 0
                If yy < 0 Then yy = 0
                ChDir (projectPath$)
                fn$ = currentboard$
                fn$ = nopath(fn$)
                fn$ = brdpath$ + fn$
                'first, get the shade color of the board...
                a = GetVariable("AmbientRed!", l$, shadeR)
                a = GetVariable("AmbientGreen!", l$, shadeG)
                a = GetVariable("AmbientBlue!", l$, shadeB)
                shadeR = shadeR + addonr
                shadeG = shadeG + addong
                shadeB = shadeB + addonb
                'now check day and night info...
                If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
                    lightShade = DetermineLightLevel()
                    shadeR = shadeR + lightShade
                    shadeG = shadeG + lightShade
                    shadeB = shadeB + lightShade
                End If
                If PakFileRunning Then
                    Call ChangeDir(PakTempPath)
                    Call CanvasFill(scrollCacheCanvas, TranspColor)
                    Call CanvasFill(scrollCacheMask, RGB(255, 255, 255))
                    If useParallaxLayer Then
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    Else
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    End If
                    'a = GFXdrawboardmask(fn$, 0, xx - 1, yy - 1, shader, shadeg, shadeb, tilesX, tilesY, CanvasHDC(scrollCacheMask))
                    Call ChangeDir(currentdir$)
                Else
                    Call CanvasFill(scrollCacheCanvas, TranspColor)
                    Call CanvasFill(scrollCacheMask, RGB(255, 255, 255))
                    If useParallaxLayer Then
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    Else
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    End If
                    'a = GFXdrawboardmask(fn$, 0, xx - 1, yy - 1, shader, shadeg, shadeb, tilesX, tilesY, CanvasHDC(scrollCacheMask))
                End If
                
                ChDir (currentdir$)
                scrollCacheTopx = xx
                scrollCacheTopy = yy
                Call CanvasRefresh(scrollCacheCanvas)
                Call CanvasRefresh(scrollCacheMask)
            End If
            'Call CanvasFill(rowStripCanvas, brdcolor)
            Call CanvasFill(rowStripCanvas, TranspColor)
            Call rowBlt(x, y)
            Call drawRowItems(x, y)
            Call drawRowPrograms(x, y)
        Else
            Call CanvasFill(rowStripCanvas, TranspColor)
            'Call CanvasFill(rowStripCanvas, brdcolor)
            Call saveBoardRow(x, y)
            ChDir (projectPath$)
            a = GFXdrawRow(brdpath$ + "temp.___", 1, 0, CanvasHDC(rowStripCanvas))
            ChDir (currentdir$)
            Call drawRowItems(x, y)
            Call drawRowPrograms(x, y)
        End If
    Else
        'use internal routines (slow draw)
        Call inSetupRowScroll(x, y)
    End If

End Sub

Sub setupColumnScroll(x, y)
    'sets up scrolling on a column
    'copies the next column into the colstrip box
    'aa = Timer
    'useFastDraw = 0
    On Error Resume Next
    
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

   
    If useFastDraw = 1 Then
        If mainMem.mainScreenType = 1 Or mainMem.mainScreenType = 2 Or (screenWidth) = 640 * Screen.TwipsPerPixelX Then
            'If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or x < scrollCacheTopx Or x > scrollCacheTopx + tilesX - 1 _
                Or y < scrollCacheTopy Or y > scrollCacheTopy + tilesY - 2 Then
            If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or x < scrollCacheTopx Or x > scrollCacheTopx + tilesX - 1 Then
            'If scrollCacheTopx = -1 Or scrollCacheTopy = -1 _
                Or x < scrollCacheTopx Or x > scrollCacheTopx + scrollCacheWidth - 1 Then
                xx = x - Int(tilesX / 2)
                'xx = x - 5
                yy = y
                If xx < 0 Then xx = 0
                If yy < 0 Then yy = 0
                ChDir (projectPath$)
                fn$ = currentboard$
                fn$ = nopath(fn$)
                fn$ = brdpath$ + fn$
                'first, get the shade color of the board...
                a = GetVariable("AmbientRed!", l$, shadeR)
                a = GetVariable("AmbientGreen!", l$, shadeG)
                a = GetVariable("AmbientBlue!", l$, shadeB)
                shadeR = shadeR + addonr
                shadeG = shadeG + addong
                shadeB = shadeB + addonb
                'now check day and night info...
                If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
                    lightShade = DetermineLightLevel()
                    shadeR = shadeR + lightShade
                    shadeG = shadeG + lightShade
                    shadeB = shadeB + lightShade
                End If
                If PakFileRunning Then
                    Call ChangeDir(PakTempPath)
                    Call CanvasFill(scrollCacheCanvas, TranspColor)
                    Call CanvasFill(scrollCacheMask, RGB(255, 255, 255))
                    If useParallaxLayer Then
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    Else
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    End If
                    'a = GFXdrawboardmask(fn$, 0, xx - 1, yy - 1, shader, shadeg, shadeb, tilesX, tilesY, CanvasHDC(scrollCacheMask))
                    Call ChangeDir(currentdir$)
                Else
                    Call CanvasFill(scrollCacheCanvas, TranspColor)
                    Call CanvasFill(scrollCacheMask, RGB(255, 255, 255))
                    If useParallaxLayer Then
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), CanvasHDC(scrollCacheMask), 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    Else
                        a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, shadeR, shadeG, shadeB, 0)
                        'a = GFXdrawboard(CanvasHDC(scrollCacheCanvas), -1, 0, xx - 1, yy - 1, scrollCacheWidth, scrollCacheHeight, boardlist(activeboardindex).thedata.Bsizex, boardlist(activeboardindex).thedata.Bsizey, boardlist(activeboardindex).thedata.Bsizel, shader, shadeg, shadeb)
                    End If
                    'a = GFXdrawboardmask(fn$, 0, xx - 1, yy - 1, shader, shadeg, shadeb, tilesX, tilesY, CanvasHDC(scrollCacheMask))
                End If
                ChDir (currentdir$)
                scrollCacheTopx = xx
                scrollCacheTopy = yy
                Call CanvasRefresh(scrollCacheCanvas)
                Call CanvasRefresh(scrollCacheMask)
            End If
        
            'Call CanvasFill(colStripCanvas, brdcolor)
            Call CanvasFill(colStripCanvas, TranspColor)
            'call vbpicrefresh(mainForm.boardform)
            'now blt it from the cache into the strip...
            Call columnBlt(x, y)
            Call drawColumnItems(x, y)
            Call drawColumnPrograms(x, y)
            ''MsgBox Str$(Timer - aa)
        Else
            Call CanvasFill(colStripCanvas, TranspColor)
            'Call CanvasFill(colStripCanvas, brdcolor)
            Call saveBoardCol(x, y)
            'call vbpicrefresh(mainForm.boardform)
            ChDir (projectPath$)
            a = GFXdrawColumn(brdpath$ + "temp.___", 1, 0, CanvasHDC(colStripCanvas))
            ChDir (currentdir$)
            Call drawColumnItems(x, y)
            Call drawColumnPrograms(x, y)
            'MsgBox Str$(Timer - aa)
        End If
    Else
        'use internal routines (slow draw)
        Call inSetupColumnScroll(x, y)
    End If

End Sub


Function toString(val) As String
    'returns sting-- no spaces!
    On Error GoTo errorhandler
    t$ = str$(val)
    t$ = nospace(t$)
    toString = t$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub saveBoardCol(x, y)
    'saves a column of tiles from the board
    'row starting at x,y
On Error Resume Next
    num = FreeFile
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
    
    Open projectPath$ + brdpath$ + "temp.___" For Output As #num
        Print #num, addonr
        Print #num, addong
        Print #num, addonb
        Print #num, tilesX
        Print #num, tilesY
        For lay = 1 To 8
            For yy = y To y + tilesY - 1
                tname$ = ""
                ar = 0
                ag = 0
                ab = 0
                If yy <= 50 Then
                    tname$ = BoardGetTile(x, yy, lay, boardList(activeBoardIndex).theData)
                    'MsgBox tname$ + Str$(X) + Str$(yy)
                    ar = boardList(activeBoardIndex).theData.ambientred(x, yy, lay)
                    ag = boardList(activeBoardIndex).theData.ambientgreen(x, yy, lay)
                    ab = boardList(activeBoardIndex).theData.ambientblue(x, yy, lay)
                End If
                ex$ = extention(tname$)
                If UCase$(ex$) = "TST" Then
                    numof = getTileNum(tname$)
                    fn$ = tilesetFilename(tname$)
                    fn$ = projectPath$ + tilepath$ + fn$
                    fn$ = GetShortName(fn$)
                    fn$ = nopath$(fn$)
                    'fn$ = Mid$(fn$, 2, Len(fn$) - 1)
                    fn$ = fn$ + toString(numof)
                    'fn$ = nospace(fn$)
                    tname$ = fn$
                    'MsgBox temp$
                Else
                    tname$ = projectPath$ + tilepath$ + tname$
                    tname$ = GetShortName(tname$)
                    tname$ = nopath$(tname$)
                    'tname$ = Mid$(tname$, 2, Len(tname$) - 1)
                End If
                'MsgBox tname$
                If BoardGetTile(x, yy, lay, boardList(activeBoardIndex).theData) = "" Then tname$ = ""
                Print #num, tname$
                Print #num, ar
                Print #num, ag
                Print #num, ab
            Next yy
        Next lay
    Close #num
End Sub

Sub saveBoardRow(x, y)
    'saves a row of tiles from the board
    'row starting at x,y
On Error Resume Next
    num = FreeFile
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
    Open projectPath$ + brdpath$ + "temp.___" For Output As #num
        Print #num, addonr
        Print #num, addong
        Print #num, addonb
        Print #num, tilesX
        Print #num, tilesY
        For lay = 1 To 8
            For xx = x To x + tilesX - 1
                tname$ = ""
                ar = 0
                ag = 0
                ab = 0
                If xx <= 50 Then
                    tname$ = BoardGetTile(xx, y, lay, boardList(activeBoardIndex).theData)
                    ar = boardList(activeBoardIndex).theData.ambientred(xx, y, lay)
                    ag = boardList(activeBoardIndex).theData.ambientgreen(xx, y, lay)
                    ab = boardList(activeBoardIndex).theData.ambientblue(xx, y, lay)
                End If
                ex$ = extention(tname$)
                If UCase$(ex$) = "TST" Then
                    numof = getTileNum(tname$)
                    fn$ = tilesetFilename(tname$)
                    fn$ = projectPath$ + tilepath$ + fn$
                    fn$ = GetShortName(fn$)
                    fn$ = nopath$(fn$)
                    'fn$ = Mid$(fn$, 2, Len(fn$) - 1)
                    fn$ = fn$ + toString(numof)
                    'fn$ = nospace(fn$)
                    tname$ = fn$
                    'MsgBox temp$
                Else
                    tname$ = projectPath$ + tilepath$ + tname$
                    tname$ = GetShortName(tname$)
                    tname$ = nopath$(tname$)
                    'tname$ = Mid$(tname$, 2, Len(tname$) - 1)
                End If
                Print #num, tname$
                Print #num, ar
                Print #num, ag
                Print #num, ab
            Next xx
        Next lay
    Close #num
End Sub

Sub FreeDC(riDC As Long, riId As Integer)
    On Error GoTo errorhandler


'Purpose    To free resources used by a created DC
'Entry      riDC -- handle of the DC to delete
'           riId -- index of the DC

Dim iDC As Integer
Dim iBitmap As Integer

'Only proceed if a valis DC passed
If riDC Then

    'Select bitmap out of DC and original one back in
    iBitmap = SelectObject(riDC, miSavedBitmaps(riId))

    'Delete the Bitmap
    iBitmap = DeleteObject(iBitmap)

    'Delete the DC
    iDC = DeleteDC(riDC)

End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function iBuildDC(pic As PictureBox, riId As Integer) As Long
    On Error GoTo errorhandler

'Purpose    Create a DC and associated Bitmap to hold gfx from a PictureBox
'           and copy gfx into it.
'Entry      pic -- Picture Box that holds gfx to copy into created DC.
'           riId -- Index of this DC, used when releasing resources
'Exit       Returns handle to DC on success, 0 on failure
'Notes      On failure, all resources are released.

Dim I As Long
Dim iDC As Long
Dim iBitmap As Long

'Create a DC
iDC = CreateCompatibleDC(vbPicHDC(pic))

If iDC Then
    'Only proceed if we have a DC
    iBitmap = CreateCompatibleBitmap(vbPicHDC(pic), pic.width \ Screen.TwipsPerPixelX, pic.height \ Screen.TwipsPerPixelY)

    'Only proceed if we have a Bitmap
    If iBitmap Then
        'Select Bitmap into the DC
        iBitmap = SelectObject(iDC, iBitmap)

        'Save handle of Bitmap swapped out
        miSavedBitmaps(riId) = iBitmap

        'Copy gfx into our new DC
        I = BitBlt(iDC, 0, 0, 50, 50, vbPicHDC(pic), 0, 0, SRCCOPY)
    
    Else
        'Free resources
        iDC = DeleteDC(iDC)
        iDC = 0
    End If
End If

'Return handle of DC or 0 on error
iBuildDC = iDC


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function







Sub loadTile(file$, r, g, b)
    'loads a tile and shades it to rgb
    On Error GoTo errorhandler
    For x = 1 To 32
        For y = 1 To 32
            buftile(x, y) = tilemem(x, y)
        Next y
    Next x
    Call openwintile(file$)
    If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail

    For x = 1 To 32
        For y = 1 To 32
            rr = red(tilemem(x, y))
            gg = green(tilemem(x, y))
            bb = blue(tilemem(x, y))
            rr = rr + r
            gg = gg + g
            bb = bb + b
            If rr > 255 Then rr = 255
            If rr < 0 Then rr = 0
            If gg > 255 Then gg = 255
            If gg < 0 Then gg = 0
            If bb > 255 Then bb = 255
            If bb < 0 Then bb = 0
            tilemem(x, y) = RGB(rr, gg, bb)
        Next y
    Next x


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub






Sub shiftDown()
    'shifts the board down (scroll north)
    On Error GoTo errorhandler
    If topY < 0 Then Exit Sub
    Call setupRowScroll(topX + 1, topY + 1)
    For t = 1 To 4
        Call pScrollDown(t, True)
        Call vbPicRefresh(mainForm.boardform)
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftLeft()
    'shifts the board left (scroll east)
    On Error GoTo errorhandler
    If topX = 50 - tilesX Then Exit Sub
    Call setupColumnScroll(topX + tilesX, topY + 1)
    For t = 1 To 4
        Call pScrollLeft(t, True)
        Call vbPicRefresh(mainForm.boardform)
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftRight()
    'scrolls the board right (west)
    On Error GoTo errorhandler
    If topX < 0 Then Exit Sub
    Call setupColumnScroll(topX + 1, topY + 1)
    For t = 1 To 4
        Call pScrollRight(t, True)
        Call vbPicRefresh(mainForm.boardform)
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub shiftUp()
    'shifts the board up (scroll south)
    On Error GoTo errorhandler
    If topY = 50 - tilesX Then Exit Sub
    Call setupRowScroll(topX + 1, topY + tilesY)
    For t = 1 To 4
        Call pScrollUp(t, True)
        Call vbPicRefresh(mainForm.boardform)
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

