Attribute VB_Name = "Routines"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Alterations for isometrics, 3.0.4 by Delano
'Support for .iso isomteric tilesets has been added to
'the following subs:
'
'   opentile2, openwintile, savetile
'=======================================================

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

'Sub drawtile(file$, x, y, pic As PictureBox)
'    'opens a tile and draws it into a picturebox
'    'x,y are x,y in pixels
'    On Error GoTo errorhandler
'    publictile.oldDetail = detail
'    For xx = 0 To 32
'        For yy = 0 To 32
'            buftile(xx, yy) = tilemem(xx, yy)
'        Next yy
'    Next xx
'
'    Call openwintile(file$)
'    For xx = 1 To 32
'        For yy = 1 To 32
'            If tilemem(xx, yy) <> -1 Then
'                Call setpixelV(vbPicHDC(pic), xx, yy, tilemem(xx, yy))
'            End If
'        Next yy
'    Next xx
'
'    detail = publictile.oldDetail
'    For xx = 0 To 32
'        For yy = 0 To 32
'            tilemem(xx, yy) = buftile(xx, yy)
'        Next yy
'    Next xx
'
'    Exit Sub
''Begin error handling code:
'errorhandler:
'    Call HandleError
'    Resume Next
'End Sub

Public Sub hideAllTools()
    'hide all tool menus
    On Error Resume Next
    'extras
    tkMainForm.animationExtras.Visible = False
    tkMainForm.bottomFrame.Visible = False
    tkMainForm.tileExtras.Visible = False
    ''tkMainForm.boardExtras.Visible = False
    tkMainForm.tileBmpExtras.Visible = False
    
    'tools
    tkMainForm.tilebmpTools.Visible = False
    tkMainForm.animationTools.Visible = False
    tkMainForm.rpgcodeTools.Visible = False
    tkMainForm.tileTools.Visible = False
    tkMainForm.boardTools.Visible = False
End Sub


Sub LocalizeTabStrip(ByRef TabStrip1 As TabStrip)
    On Error GoTo taberr
    done = False
    t = 1
    Do While Not (done)
        TabStrip1.Tabs.Item(t).Caption = LoadStringLoc(TabStrip1.Tabs.Item(t).tag, TabStrip1.Tabs.Item(t).Caption)
        t = t + 1
    Loop
    
    Exit Sub
taberr:
    done = True
    Resume Next
End Sub

Sub EndGame()
    'end program
    Call saveConfigAndEnd("toolkit.cfg")
End Sub
Sub TestGraphicsMode()
    'tsts the graphics mode.
    'if it cannot use the hi-speed dll, it will revert back to brddraw.exe
    On Error GoTo dllerr
    
    If targetPlatform = 1 Then
        'internal gfx engine-will work
        Exit Sub
    End If

    a = GFXInitScreen(640, 480)
    'if we made it here, it worked, so we'll use the dll
    targetPlatform = 0
    'MsgBox "using dll"
    Exit Sub

dllerr:
    'if we made it here, it didn't work, so we'll use brrdaw
    targetPlatform = 2
    'MsgBox "using brddraw"
End Sub
Function absNoPath(file$) As String
    On Error GoTo errorhandler
    f$ = nopath(file$)
    f$ = Mid$(f$, 2, Len(f$) - 1)
    absNoPath = f$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function



Sub clearGame()
    'clears all game data
    On Error GoTo errorhandler
    projectPath$ = ""
    editmainfile.clearAll
    Unload editmainfile

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub makeFolders(ppath$)
    'creates all folders for a game, under projectpath ppath$
    On Error GoTo errorhandler
    MkDir Mid$(ppath$ + tilepath$, 1, Len(ppath$ + tilepath$) - 1)
    MkDir Mid$(ppath$ + brdpath$, 1, Len(ppath$ + brdpath$) - 1)
    MkDir Mid$(ppath$ + tempath$, 1, Len(ppath$ + tempath$) - 1)
    MkDir Mid$(ppath$ + spcpath$, 1, Len(ppath$ + spcpath$) - 1)
    MkDir Mid$(ppath$ + bkgpath$, 1, Len(ppath$ + bkgpath$) - 1)
    MkDir Mid$(ppath$ + mediapath$, 1, Len(ppath$ + mediapath$) - 1)
    MkDir Mid$(ppath$ + prgpath$, 1, Len(ppath$ + prgpath$) - 1)
    MkDir Mid$(ppath$ + fontpath$, 1, Len(ppath$ + fontpath$) - 1)
    MkDir Mid$(ppath$ + itmpath$, 1, Len(ppath$ + itmpath$) - 1)
    MkDir Mid$(ppath$ + enepath$, 1, Len(ppath$ + enepath$) - 1)
    MkDir Mid$(ppath$ + bmppath$, 1, Len(ppath$ + bmppath$) - 1)
    MkDir Mid$(ppath$ + statuspath$, 1, Len(ppath$ + statuspath$) - 1)
    MkDir Mid$(ppath$ + miscPath$, 1, Len(ppath$ + miscPath$) - 1)
    MkDir Mid$(ppath$ + pluginPath$, 1, Len(ppath$ + pluginPath$) - 1)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'resolve' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Function resolve(dfile$)
    'Resolves a directory (puts it in order)
    On Error GoTo errorhandler
    d$ = dfile$
    d$ = replaceChar(d$, " ", "")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ <> "\" Then d$ = d$ + "\"
    resolve = d$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'AddUnderscore' with an early-bound data type                              FixIT90210ae-R1672-R1B8ZE
Function AddUnderscore(text$)
    On Error GoTo errorhandler
manip$ = text$
lengthof = Len(manip$)
newtext$ = ""
For Position = 1 To lengthof
    part$ = Mid$(manip$, Position, 1)
    If part$ = " " Then part$ = "_"
    newtext$ = newtext$ + part$
Next Position
AddUnderscore = newtext$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'all' and 'longcolorin' and 'whichone' with an early-bound data type       FixIT90210ae-R1672-R1B8ZE
Function all(longcolorin, whichone)
    On Error GoTo errorhandler
longcolor = longcolorin
bluecomp = Int(longcolor / 65536)
bb = bluecomp
'MsgBox bluecomp
takeaway = bluecomp * 256 * 256
longcolor = longcolor - takeaway

greencomp = Int(longcolor / 256)
gg = greencomp
takeaway = greencomp * 256

redcomp = longcolor - takeaway
rr = redcomp
longcolor = 0
If whichone = 1 Then all = rr
If whichone = 2 Then all = gg
If whichone = 3 Then all = bb


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'blue' and 'longcolor' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
Function blue(longcolor)
    On Error GoTo errorhandler
jj = longcolor
bluecomp = Int(jj / 65536)
blue = bluecomp

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub color_16()
    On Error GoTo errorhandler
    Call wincolor
    colorDepth.Show
    If detail = 2 Or detail = 4 Or detail = 6 Then
        For X = 1 To 16
            For Y = 1 To 16
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    qb = tocolor(tilemem(X, Y), "16")
                    tilemem(X, Y) = qb
                    qbtile(X, Y) = qb
                End If
            Next Y
            'colordepth.status.Line (0, 0)-((x / 16) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 16) * 100, 10, vbQBColor(9))
        Next X
    End If
    If detail = 1 Or detail = 3 Or detail = 5 Then
        For X = 1 To 32
            For Y = 1 To 32
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    qb = tocolor(tilemem(X, Y), "16")
                    tilemem(X, Y) = qb
                    qbtile(X, Y) = qb
                End If
            Next Y
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 32) * 100, 10, vbQBColor(9))
            'colordepth.status.Line (0, 0)-((x / 32) * 100, 10), vbqbcolor(9), BF
        Next X
    End If
    Unload colorDepth

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub color_16million()
    On Error GoTo errorhandler
    'colordepth.Show
    If detail = 2 Or detail = 4 Or detail = 6 Then
        For X = 1 To 16
            For Y = 1 To 16
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    'tilemem(x, y) = gfxgetdoscolor(tilemem(x, y))
                    tilemem(X, Y) = GFXGetDOSColor(tilemem(X, Y))
                End If
            Next Y
            'colordepth.status.Line (0, 0)-((x / 16) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 16) * 100, 10, vbQBColor(9))
        
        Next X
    End If
    If detail = 3 Or detail = 5 Then
        For X = 1 To 32
            For Y = 1 To 32
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    'tilemem(x, y) = gfxgetdoscolor(tilemem(x, y))
                    tilemem(X, Y) = GFXGetDOSColor(tilemem(X, Y))
                End If
            Next Y
            'colordepth.status.Line (0, 0)-((x / 32) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 32) * 100, 10, vbQBColor(9))
        Next X
        detail = 1
    End If
    'Unload colordepth

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub color_256()
    On Error GoTo errorhandler
    Call wincolor
    colorDepth.Show
    If detail = 2 Or detail = 4 Or detail = 6 Then
        For X = 1 To 16
            For Y = 1 To 16
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    qb = tocolor(tilemem(X, Y), "256")
                    tilemem(X, Y) = qb
                    qbtile(X, Y) = qb
                End If
            Next Y
            'colordepth.status.Line (0, 0)-((x / 16) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 16) * 100, 10, vbQBColor(9))
        Next X
    End If
    If detail = 1 Or detail = 3 Or detail = 5 Then
        For X = 1 To 32
            For Y = 1 To 32
                If tilemem(X, Y) = -1 Then
                    tilemem(X, Y) = -1
                Else
                    qb = tocolor(tilemem(X, Y), "256")
                    tilemem(X, Y) = qb
                    qbtile(X, Y) = qb
                End If
            Next Y
            'colordepth.status.Line (0, 0)-((x / 32) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (X / 32) * 100, 10, vbQBColor(9))
        Next X
    End If
    Unload colorDepth

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function extention(ByVal file As String) As String: On Error Resume Next
'==================================================
'Edited by Delano: rewritten!
'==================================================
    Dim strArray() As String
    
    'Split the file.
    strArray$ = Split(file$, ".")
    'Last element will be the extension. Take the first 3 letters.
    extention$ = Left$(strArray$(UBound(strArray$)), 3)

End Function

'FIXIT: Declare 'fileExist' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Function fileExist(filename$)
    '0=no, 1-yes
    'Function checks if a file exists.
    'First see if it's in an archive:
    On Error GoTo errcatch
    file$ = filename$
    pth$ = pathof$(filename$)
    'Not in an archive:
    num = FreeFile
    Open file$ For Input As #num
    Close #num
    If anError = 1 Then fileExist = 0 Else fileExist = 1
    Exit Function

errcatch:
anError = 1
Resume Next
End Function

'FIXIT: Declare 'getTipCount' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Function getTipCount(file$)
    On Error Resume Next
    num = FreeFile
    Open file$ For Input As #num
        Input #num, temp
    Close #num
    getTipCount = val(temp)
End Function

'FIXIT: Declare 'tnum' with an early-bound data type                                       FixIT90210ae-R1672-R1B8ZE
Function getTipNum(file$, tnum) As String
    'gets tip number from file.
    'returns it as string.
    On Error Resume Next
    num = FreeFile
    Open file$ For Input As #num
        Input #num, t$
        For tt = 1 To tnum
            Line Input #num, tip$
        Next tt
    Close #num
    getTipNum = tip$
End Function

'FIXIT: Declare 'green' and 'longcolor' with an early-bound data type                      FixIT90210ae-R1672-R1B8ZE
Function green(longcolor)
    On Error GoTo errorhandler
jj = longcolor
bluecomp = Int(jj / 65536)
takeaway = bluecomp * 256 * 256
jj = jj - takeaway

greencomp = Int(jj / 256)
green = greencomp


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub highredrawLIGHT()
    On Error GoTo errorhandler
    'light.tileform.Line (0, 0)-(1000, 1000), vbqbcolor(1), BF
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    didthat = 0
    For X = 1 To 32
        For Y = 1 To 32
            xx = (X * 10) - 9
            yy = (Y * 10) - 9
            'If didthat = 0 Then MsgBox detail: didthat = 1
            If tilemem(X, Y) <> -1 Then
                If detail = 1 Then
                    'light.tileform.Line (xx, yy)-((xx + 8), (yy + 8)), tilemem(x, y), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, tilemem(X, Y))
                End If
                If detail = 3 Or detail = 5 Then
                    'MsgBox "hi"
                    'MsgBox tilemem(x, y)
                    'light.tileform.Line (xx, yy)-((xx + 8), (yy + 8)), gfxgetdoscolor(tilemem(x, y)), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, GFXGetDOSColor(tilemem(X, Y)))
                End If
            End If
        Next Y
    Next X
    publicTile.grid = 0
    'If publictile.grid = 1 Then publictile.grid = 0: activetile.gridonoff_click Else publictile.grid = 1: activetile.gridonoff_click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'inbounds' and 'num' and 'low' and 'high' with an early-bound data type     FixIT90210ae-R1672-R1B8ZE
Function inbounds(num, low, high)
    On Error GoTo errorhandler
    l = num
    If l < low Then l = low
    If l > high Then l = high
    inbounds = l

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub increasedetail()
    On Error GoTo errorhandler
ReDim buffertile(32, 32)
    If detail = 2 Then detail = 1
    If detail = 4 Then detail = 3
    If detail = 6 Then detail = 5
    For X = 1 To 16
        For Y = 1 To 16
            buffertile(X, Y) = tilemem(X, Y)
            tilemem(X, Y) = -1
        Next Y
    Next X
    
    interpolate = 0
    
    If interpolate = 1 Then
        'Increase detail
        xx = 1: yy = 1
        For X = 1 To 16
            For Y = 1 To 16
                If X = 16 Then
                    If buffertile(1, Y) <> -1 And buffertile(X, Y) <> -1 Then
                        nextcolor = 0
                        r1 = red(buffertile(X, Y))
                        g1 = green(buffertile(X, Y))
                        b1 = blue(buffertile(X, Y))
                        r2 = red(buffertile(1, Y))
                        g2 = green(buffertile(1, Y))
                        b2 = blue(buffertile(1, Y))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        
                        tilemem(xx, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy) = nextcolor
                        tilemem(xx + 1, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy + 1) = buffertile(X, Y)
                    End If
                Else
                    If buffertile(X + 1, Y) <> -1 And buffertile(X, Y) <> -1 Then
                        nextcolor = 0
                        r1 = red(buffertile(X, Y))
                        g1 = green(buffertile(X, Y))
                        b1 = blue(buffertile(X, Y))
                        r2 = red(buffertile(X + 1, Y))
                        g2 = green(buffertile(X + 1, Y))
                        b2 = blue(buffertile(X + 1, Y))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        
                        tilemem(xx, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy) = nextcolor
                        tilemem(xx + 1, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy) = buffertile(X, Y)
                        tilemem(xx + 1, yy + 1) = buffertile(X, Y)
                    End If
                End If
                If Y = 16 Then
                    If buffertile(X, 1) <> -1 And buffertile(X, Y) <> -1 Then
                        nextcolor = 0
                        r1 = red(buffertile(X, Y))
                        g1 = green(buffertile(X, Y))
                        b1 = blue(buffertile(X, Y))
                        r2 = red(buffertile(X, 1))
                        g2 = green(buffertile(X, 1))
                        b2 = blue(buffertile(X, 1))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        tilemem(xx, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy + 1) = buffertile(X, Y)
                    End If
                Else
                    If buffertile(X, Y + 1) <> -1 And buffertile(X, Y) <> -1 Then
                        nextcolor = 0
                        r1 = red(buffertile(X, Y))
                        g1 = green(buffertile(X, Y))
                        b1 = blue(buffertile(X, Y))
                        r2 = red(buffertile(X, Y + 1))
                        g2 = green(buffertile(X, Y + 1))
                        b2 = blue(buffertile(X, Y + 1))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        tilemem(xx, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy + 1) = buffertile(X, Y)
                    End If
                End If
                yy = yy + 2
            Next Y
            yy = 1
            xx = xx + 2
        Next X
    Else
        'Increase detail
        xx = 1: yy = 1
        For X = 1 To 16
            For Y = 1 To 16
                tilemem(xx, yy) = buffertile(X, Y)
                tilemem(xx, yy + 1) = buffertile(X, Y)
                tilemem(xx + 1, yy) = buffertile(X, Y)
                tilemem(xx + 1, yy + 1) = buffertile(X, Y)
                yy = yy + 2
            Next Y
            yy = 1
            xx = xx + 2
        Next X
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub lowredrawLIGHT()
    On Error GoTo errorhandler
    'light.tileform.Line (0, 0)-(1000, 1000), vbqbcolor(1), BF
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    For X = 1 To 16
        For Y = 1 To 16
            xx = (X * 20) - 19
            yy = (Y * 20) - 19
            If tilemem(X, Y) <> -1 Then
                If detail = 2 Then
                    'light.tileform.Line (xx, yy)-(xx + 18, yy + 18), tilemem(x, y), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, tilemem(X, Y))
                End If
                If detail = 4 Or detail = 6 Then
                    'light.tileform.Line (xx, yy)-(xx + 18, yy + 18), gfxgetdoscolor(tilemem(x, y)), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, GFXGetDOSColor(tilemem(X, Y)))
                End If
            End If
        Next Y
    Next X
    publicTile.grid = 0
    'If publictile.grid = 1 Then publictile.grid = 0: activetile.gridonoff_click Else publictile.grid = 1: activetile.gridonoff_click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'NoExtention' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Function NoExtention(file$)
    On Error GoTo errorhandler
workon$ = file$
running$ = ""
col = 1
length = Len(file$)
Do While part$ <> "." And col <= length + 1
    running$ = running$ + part$
    part$ = Mid$(workon$, col, 1)
    col = col + 1
Loop
NoExtention = running$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function nopath$(text$)
    'removes path of filename
    On Error GoTo errorhandler
    a$ = text$
    length = Len(a$)
    'first, see if there IS a path:
    apath = 0
    For t = 1 To length
        part$ = Mid$(a$, t, 1)
        If part$ = ":" Or part$ = "\" Then apath = 1
    Next t
    If apath = 0 Then nopath = a$: Exit Function
    'Now see if the path terminates with a \ or a :
    For t = 1 To length
        part$ = Mid$(a$, t, 1)
        If part$ = ":" Or part$ = "\" Then term$ = part$
    Next t
    pathuse$ = ""
    If term$ = ":" Then
        'if it terminates with a :, then the filename is right after :
        For t = 1 To length
            part$ = Mid$(a$, t, 1)
            pathuse$ = pathuse$ + part$
            If part$ = ":" Then
                path$ = ""
                For ll = t To length
                    part$ = Mid$(a$, ll, 1)
                    path$ = path$ + part$
                Next ll
                nopath = path$: Exit Function
            End If
        Next t
    End If
    If term$ = "\" Then
        lastone = 1
        'If it terminates with a "\" then we've got problems.  where is the last one at?
        For t = 1 To length
            part$ = Mid$(a$, t, 1)
            If part$ = "\" Then lastone = t
        Next t
        'Now let's scoop out the path"
        pathuse$ = ""
        For t = lastone To length
            part$ = Mid$(a$, t, 1)
            pathuse$ = pathuse$ + part$
        Next t
        nopath$ = pathuse$
    End If


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'NoSpaces' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Function NoSpaces(text$)
    On Error GoTo errorhandler
manip$ = text$
lengthof = Len(manip$)
newtext$ = ""
For Position = 1 To lengthof
    part$ = Mid$(manip$, Position, 1)
    If part$ = " " Then part$ = ""
    newtext$ = newtext$ + part$
Next Position
NoSpaces = newtext$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub openConfig(file$)
    'opens up config file
    On Error Resume Next
    num = FreeFile
    m_LangFile = ""
    Open file$ For Input As #num
        Input #num, v$
        Input #num, tipsOnOff            'tip window on/off (0=off, 1=on)
        Input #num, tipFile$             'tipfilename
        Input #num, tipNum               'tip number
        Input #num, targetPlatform       'target platform 0=win9x, 1-winNT
        Input #num, commandsDocked       'command buttons docked (hidden) 0=no, 1=yes
        Input #num, filesDocked          'file dialog docked?
        Input #num, lastProject$
        Input #num, mp3Path$            'path of mp3 files
        Input #num, wallpaper$          'wallpaper file
        For t = 0 To 4
            Input #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
            Input #num, quickTarget$(t) 'quick launch targets
            Input #num, quickIcon$(t)   'quick launch icons
        Next t
        Input #num, tutCurrentLesson
        Input #num, m_LangFile
        
        If wallpaper$ = "" Then
            wallpaper$ = "bkg.jpg"
        End If
        If wallpaper$ = "NONE" Then
            wallpaper$ = ""
        End If
    Close #num
End Sub

Sub openMainFile(file$)
'opens main file
On Error Resume Next
    num = FreeFile
    projectPath$ = ""
    If file$ = "" Then Exit Sub
    'mainoption.fileTree1.setPath (projectPath$)
    'mainoption.fileTree1.pathRefresh
    
    reg = openMain(file, mainMem)
    oldpath$ = currentdir$ + "\" + projectPath$
    'mainoption.Dir1.path = currentdir$ + "\" + projectPath$
    
    Call mainoption.TreeView1.Nodes.Clear
    Call tkMainForm.fillTree("", projectPath$)
    'FileCopy "brddraw.exe", projectPath$ + "brddraw.exe"
    'FileCopy "tkgfx.dll", projectPath$ + "tkgfx.dll"
    'FileCopy "256rgb.pal", projectPath$ + "256rgb.pal"
    
    mainoption.Caption = "RPG Toolkit Development System, Version 2.2 (" + absNoPath(file$) + ")"
    
    'set up gfx mode...
    Call TestGraphicsMode
    
   
End Sub


Sub opentile2(ByVal filenm As String)
'====================================
'Alterations for isometrics - 3.0.4
'Added recognition for .iso - Delano

On Error GoTo loadtileerr
    filename$(1) = filenm$
    ex$ = extention(filenm$)
    
    If UCase$(ex$) = "TST" Or UCase$(ex$) = "ISO" Then          'Added.

        Call openFromTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        
        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increasedetail
        End If
        Call color_16million
        Exit Sub
    End If
    
    num = FreeFile
    publicTile.tileneedupdate = False
    Open filename$(1) For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT TILE" Then Close #num: GoTo Version1Tile
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> Major Then MsgBox "This tile was created with an unrecognised version of the Toolkit", , "Unable to open tile": Exit Sub
        If minorVer <> Minor Then
            user = MsgBox("This tile was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + CurrentVersion$ + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        Input #num, detail             'Detail level- 1 is 32x32, 2 is 16x16
        Input #num, comp              'Compression used? 1- yes, 0-no
        If comp = 0 Then     'If compression was not used, the tile is stored with each value representing a pixel.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For X = 1 To 32
                    For Y = 1 To 32
                        Input #num, tilemem(X, Y) 'Pixel by pixel
                    Next Y
                Next X
'                call activetile.highredraw
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For X = 1 To 16
                    For Y = 1 To 16
                        Input #num, tilemem(X, Y)
                    Next Y
                Next X
'                call activetile.lowredraw
            End If
        End If
        If comp = 1 Then    'If compression is used, pixel 'bundles' come in pairs of two.
                            'The first number is how many times in a row that pixel appears, and the second number
                            'is the pixel itself.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 33
                    Input #num, times
                    Input #num, colortime
                    For loopit = 1 To times
                        tilemem(xx, yy) = colortime
                        yy = yy + 1
                        If yy > 32 Then yy = 1: xx = xx + 1
                    Next loopit
                Loop
'                call activetile.highredraw
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 17
                    Input #num, times
                    Input #num, colortime
                    For loopit = 1 To times
                        tilemem(xx, yy) = colortime
                        yy = yy + 1
                        If yy > 16 Then yy = 1: xx = xx + 1
                    Next loopit
                Loop
'                call activetile.lowredraw
            End If
        End If
        'That's all
    Close #num
    If detail = 2 Or detail = 4 Or detail = 6 Then
        'only 32x32 tiles allowed
        Call increasedetail
    End If
    Call color_16million
    If tileError = 1 Then MsgBox "Unable to open selected filename": tileError = 0
    Exit Sub

Version1Tile:
    'We come here if the tile is (probably) made with version 1
    Open filename$(1) For Input As #num
        detail = 2
        For yy = 1 To 16
            Line Input #num, tile$
                For xx = 1 To 16
                    part$ = Mid$(tile$, xx, 1)
                    thevalue = Asc(part$)
                    thevalue = thevalue - 33
                    tilemem(xx, yy) = GFXGetDOSColor(thevalue)
                Next xx
        Next yy
    Close #num
    If detail = 2 Or detail = 4 Or detail = 6 Then
        'only 32x32 tiles allowed
        Call increasedetail
    End If
    Call color_16million
    If tileError = 1 Then MsgBox "Unable to open selected filename": tileError = 0 'Else call activetile.lowredraw
    Exit Sub

loadtileerr:
tileError = 1
Resume Next

End Sub

Sub openwintile(ByVal filenm As String)
'====================================
'Alterations for isometrics - 3.0.4
'Added recognition for .iso - Delano
'How does this differ from opentile2?

On Error GoTo loadtileerr2
    filename$(1) = filenm$
    ex$ = extention(filenm$)
   
    If UCase$(ex$) = "TST" Or UCase$(ex$) = "ISO" Then  'Added.
    
        Call openFromTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        Exit Sub
    End If
    
    num = FreeFile
    Open filename$(1) For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT TILE" Then Close #num: GoTo Version1Tile2
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> Major Then MsgBox "This tile was created with an unrecognised version of the Toolkit", , "Unable to open tile": Exit Sub
        If minorVer <> Minor Then
            user = MsgBox("This tile was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + CurrentVersion$ + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        Input #num, detail             'Detail level- 1 is 32x32, 2 is 16x16
        Input #num, comp              'Compression used? 1- yes, 0-no
        If comp = 0 Then     'If compression was not used, the tile is stored with each value representing a pixel.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For X = 1 To 32
                    For Y = 1 To 32
                        Input #num, tilemem(X, Y) 'Pixel by pixel
                    Next Y
                Next X
'                call activetile.highredraw
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For X = 1 To 16
                    For Y = 1 To 16
                        Input #num, tilemem(X, Y)
                    Next Y
                Next X
'                call activetile.lowredraw
            End If
        End If
        If comp = 1 Then    'If compression is used, pixel 'bundles' come in pairs of two.
                            'The first number is how many times in a row that pixel appears, and the second number
                            'is the pixel itself.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 33
                    Input #num, times
                    Input #num, colortime
                    For loopit = 1 To times
                        tilemem(xx, yy) = colortime
                        yy = yy + 1
                        If yy > 32 Then yy = 1: xx = xx + 1
                    Next loopit
                Loop
'                call activetile.highredraw
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 17
                    Input #num, times
                    Input #num, colortime
                    For loopit = 1 To times
                        tilemem(xx, yy) = colortime
                        yy = yy + 1
                        If yy > 16 Then yy = 1: xx = xx + 1
                    Next loopit
                Loop
'                call activetile.lowredraw
            End If
        End If
        'That's all
    Close #num
    If tileError = 1 Then MsgBox "Unable to open selected filename": tileError = 0
    publicTile.oldDetail = detail
    Call wincolor
    Exit Sub

Version1Tile2:
    'We come here if the tile is (probably) made with version 1
    Open filename$(1) For Input As #num
        detail = 2
        For yy = 1 To 16
            Line Input #num, tile$
                For xx = 1 To 16
                    part$ = Mid$(tile$, xx, 1)
                    thevalue = Asc(part$)
                    thevalue = thevalue - 33
                    tilemem(xx, yy) = GFXGetDOSColor(thevalue)
                Next xx
        Next yy
    Close #num
    If tileError = 1 Then MsgBox "Unable to open selected filename": tileError = 0 'Else call activetile.lowredraw
    Exit Sub

loadtileerr2:
tileError = 1
Resume Next

End Sub


Function pathof$(text$)
    'Determines path of filename
    On Error GoTo errorhandler
    a$ = text$
    length = Len(a$)
    'first, see if there IS a path:
    apath = 0
    For t = 1 To length
        part$ = Mid$(a$, t, 1)
        If part$ = ":" Or part$ = "\" Then apath = 1
    Next t
    If apath = 0 Then pathof$ = ""
    'Now see if the path terminates with a \ or a :
    For t = 1 To length
        part$ = Mid$(a$, t, 1)
        If part$ = ":" Or part$ = "\" Then term$ = part$
    Next t
    pathuse$ = ""
    If term$ = ":" Then
        'if it terminates with a :, then the filename is right after :
        For t = 1 To length
            part$ = Mid$(a$, t, 1)
            pathuse$ = pathuse$ + part$
            If part$ = ":" Then pathof$ = pathuse$
        Next t
    End If
    If term$ = "\" Then
        lastone = 1
        'If it terminates with a "\" then we've got problems.  where is the last one at?
        For t = 1 To length
            part$ = Mid$(a$, t, 1)
            If part$ = "\" Then lastone = t
        Next t
        'Now let's scoop out the path"
        pathuse$ = ""
        For t = 1 To lastone
            part$ = Mid$(a$, t, 1)
            pathuse$ = pathuse$ + part$
        Next t
        pathof$ = pathuse$
    End If


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'red' and 'longcolor' with an early-bound data type                        FixIT90210ae-R1672-R1B8ZE
Function red(longcolor)
    On Error GoTo errorhandler
jj = longcolor
bluecomp = Int(jj / 65536)
takeaway = bluecomp * 256 * 256
jj = jj - takeaway

greencomp = Int(jj / 256)
takeaway = greencomp * 256

redcomp = jj - takeaway
red = redcomp


    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub reducedetail()
    On Error GoTo errorhandler
ReDim buffertile(32, 32)
    If detail = 1 Then detail = 2
    If detail = 3 Then detail = 4
    If detail = 5 Then detail = 6

    For X = 1 To 32
        For Y = 1 To 32
            buffertile(X, Y) = tilemem(X, Y)
            tilemem(X, Y) = -1
        Next Y
    Next X
    
    'Reduce detail
    xx = 1: yy = 1
    For X = 1 To 32 Step 2
        For Y = 1 To 32 Step 2
            tilemem(xx, yy) = buffertile(X, Y)
            yy = yy + 1
        Next Y
        yy = 1
        xx = xx + 1
    Next X


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub RemoveArchiveFile(archivefile$, Remove$)
    On Error Resume Next
    If archivefile$ = "" Then Exit Sub
    If Remove$ = "" Then Exit Sub
    newarch$ = archivefile$
    gofile$ = Remove$
    FileCopy newarch$, "rpgsrtch.arc"
    archiveit = FreeFile
    Open "rpgsrtch.arc" For Input As #archiveit
    newnew = FreeFile
    Open newarch$ For Output As #newnew
    Do While Not EOF(archiveit)
        Line Input #archiveit, testwater$   'test the water
        If UCase$(testwater$) = "::START::" Then
            Line Input #archiveit, testname$ 'test filename
            If UCase$(testname$) = UCase$(gofile$) Then
                    donethis = 0
                    Do While donethis = 0
                        Line Input #num, dummy$       'ignore the removed file
                        If UCase$(dummy$) = "::END::" Then donethis = 1
                    Loop
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Else: Print #newnew, testwater$
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #newnew, testname$
            End If
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Else: Print #newnew, testwater$
        End If
    Loop
    Close #archiveit
    Close #newnew
    Kill "rpgsrtch.arc"
End Sub

Sub renameFile(f$)
    On Error GoTo errorhandler
    fileToRename$ = f$
    rename.Show vbModal


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function replaceChar(text$, char$, rep$) As String
    'replaces the characters in text$ with rep$
    On Error GoTo errorhandler
    ret$ = ""
    For l = 1 To Len(text$)
        part$ = Mid$(text$, l, 1)
        If part$ = char$ Then part$ = rep$
        ret$ = ret$ + part$
    Next l
    replaceChar = ret$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'roundoff' and 'number' with an early-bound data type                      FixIT90210ae-R1672-R1B8ZE
Function roundoff(number)
    On Error GoTo errorhandler
    toround = number
    lower = Int(toround)
    upper = lower + 1
    diffupper = (toround - upper) * -1
    difflower = toround - lower
    If diffupper < difflower Then theNum = upper Else theNum = lower
    roundoff = theNum

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub saveConfig(file$)
    'opens up config file
    On Error Resume Next
    num = FreeFile
    If wallpaper$ = "" Then
        wallpaper$ = "NONE"
    End If
    Open file$ For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "RPGTOOLKIT 2 CONFIG"
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipsOnOff        'tip window on/off (0=off, 1=on)
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipFile$         'tipfilename
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipNum           'tip number
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, targetPlatform   'target platform 0=win9x, 1-winNT
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, commandsDocked   'command buttons docked (hidden) 0=no, 1=yes
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, filesDocked      'file dialog docked?
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, lastProject$
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, mp3Path$       'path of mp3 files
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, wallpaper$      'wallpaper file
        For t = 0 To 4
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickTarget$(t) 'quick launch targets
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickIcon$(t)   'quick launch icons
        Next t
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tutCurrentLesson
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, m_LangFile
    Close #num
End Sub

Sub saveprogram(file$)
    'Save program
    On Error Resume Next
    num = FreeFile
    Open file$ For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, activeRPGCode.codeform.text
    Close #num
End Sub


Sub savetile(ByVal filenm As String): On Error Resume Next
'====================================
'Alterations for isometrics - 3.0.4
'Added recognition for .iso - Delano

    filename$(1) = filenm$
    ex$ = GetExt(filenm$)
    
    If UCase$(ex$) = "TST" Or UCase$(ex$) = "ISO" Then      'Added.
    
        Call insertIntoTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        Exit Sub
    End If
    
    num = FreeFile
    Open filename$(1) For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "RPGTLKIT TILE"    'Filetype
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, Major               'Version
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, Minor                'Minor version (ie 2.0)
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, detail             'Detail level- 1 is 32x32, 2 is 16x16
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, compression        'Compression 1-on, 0-off
        If compression = 0 Then         'If no compression was usd, save it normally, pixel by pixel.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For X = 1 To 32
                    For Y = 1 To 32
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                        Print #num, tilemem(X, Y) 'Pixel by pixel
                    Next Y
                Next X
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For X = 1 To 16
                    For Y = 1 To 16
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                        Print #num, tilemem(X, Y)
                    Next Y
                Next X
            End If
        End If
        If compression = 1 Then         'If there is compression, save it in bundles, count how many times pixels occur together, and write #of times, color of pixel
            occurances = 1
            older = tilemem(1, 1)
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For X = 1 To 32
                    For Y = 1 To 32
                        If X = 1 And Y = 1 Then
                            'nothing
                        Else
                            If tilemem(X, Y) = older Then
                                occurances = occurances + 1
                            Else
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                                Print #num, occurances    'how many times it occurred.
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                                Print #num, older         'what color it is
                                older = tilemem(X, Y)
                                occurances = 1
                            End If
                        End If
                    Next Y
                Next X
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num, occurances
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num, older
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For X = 1 To 16
                    For Y = 1 To 16
                        If X = 1 And Y = 1 Then
                            'nothing
                        Else
                            If tilemem(X, Y) = older Then
                                occurances = occurances + 1
                            Else
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                                Print #num, occurances    'how many times it occurred.
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                                Print #num, older         'what color it is
                                older = tilemem(X, Y)
                                occurances = 1
                                starting = 0
                            End If
                        End If
                    Next Y
                Next X
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num, occurances
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num, older
            End If
        End If
        'That's all
    Close #num

End Sub


Sub saveConfigAndEnd(file$)
    'opens up config file
    On Error Resume Next
    Call StopTracing
    num = FreeFile
    If wallpaper$ = "" Then
        wallpaper$ = "NONE"
    End If
    Open file$ For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "RPGTOOLKIT 2 CONFIG"
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipsOnOff        'tip window on/off (0=off, 1=on)
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipFile$         'tipfilename
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tipNum           'tip number
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, targetPlatform   'target platform 0=win9x, 1-winNT
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, commandsDocked   'command buttons docked (hidden) 0=no, 1=yes
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, filesDocked      'file dialog docked?
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, lastProject$
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, mp3Path$       'path of mp3 files
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, wallpaper$
        For t = 0 To 4
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickTarget$(t) 'quick launch targets
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, quickIcon$(t)   'quick launch icons
        Next t
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tutCurrentLesson
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, m_LangFile
    Close #num
    
    'Call ShutdownDBEngine
    
    Unload tutorial
    Unload config
    Unload ambienteffectform
    Unload bkgImageForm
    Unload bkgMusicForm
    Unload boardedit
    Unload boardinformation
    Unload boardlighting
    Unload brdbackground
    Unload characteredit
    Unload charequip
    Unload chargfx
    Unload charlevels
    Unload colorDepth
    Unload commandref
    Unload compoptions
    Unload cutcorner
    Unload editBackground
    Unload editcharsm
    Unload editenemy
    Unload activeItem
    Unload editmainfile
    Unload editsm
    Unload enemygraphics
    Unload enemyrewards
    Unload enemysound
    Unload enemyspecialmoves
    Unload enemytactics
    Unload fontedit
    Unload Form1
    Unload grab
    Unload helpabout
    Unload import
    Unload itemmenu
    Unload itemset
    Unload itmboard
    Unload itmequip
    Unload itmfight
    Unload itmgfx
    Unload itmmenu
    Unload layertile
    Unload light
    Unload loadingfont
    Unload mainfight
    Unload mainoption
    Unload newGame
    Unload onemoment
    Unload programmenu
    Unload programset
    Unload rename
    Unload RGBDefine
    Unload rpgcodeedit
    Unload skinedit
    Unload spcmoveinfo
    Unload spotlighting
    Unload testprefs
    Unload tilebox
    Unload tileedit
    Unload tileinfo
    Unload tileselect
    Unload tilesetadd
    Unload tilesetedit
    Unload tilesetform
    Unload tips
    Unload upgradeform
    Unload Version1Palette
    Unload VSPform
    Unload warpset
    Unload editstatus
    Unload mp3player
    Unload modplugdummy
    Unload tkvisual
    Unload activeAnimation
    Unload BoardDayNightForm
    Call CloseCanvasEngine
    Call GFXKill
    End
End Sub

'FIXIT: Declare 'val' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
Function toString(val) As String
    'returns sting-- no spaces!
    On Error GoTo errorhandler
    t$ = str$(val)
    t$ = NoSpaces(t$)
    toString = t$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'tocolor' and 'getit' with an early-bound data type                        FixIT90210ae-R1672-R1B8ZE
Function tocolor(getit, level$)
    On Error GoTo errorhandler
ReDim thesecolors(255)
If level$ = "16" Then loops = 15
If level$ = "256" Then loops = 255
redcomp = all(getit, 1)

greencomp = all(getit, 2)

bluecomp = all(getit, 3)
       msgtext$ = ""
lesser = 100000000
For t = 0 To loops
    qb = GFXGetDOSColor(t)
    qbred = all(qb, 1)
    qbgreen = all(qb, 2)
    qbblue = all(qb, 3)
    
    If qbred = redcomp And qbgreen = greencomp And qbblue = bluecomp Then
        tocolor = t
        Exit Function
    End If
    
    DeltaRed = redcomp - qbred
    DeltaGreen = greencomp - qbgreen
    DeltaBlue = bluecomp - qbblue

    pythag = (DeltaRed ^ 2) + (DeltaGreen ^ 2) + (DeltaBlue ^ 2)
    'msgtext$ = msgtext$ + " " + Str$(pythag)
    thesecolors(t) = pythag
    If thesecolors(t) < lesser Then lesser = thesecolors(t): qblesser = t
Next t
tocolor = qblesser

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub wincolor()
    On Error GoTo errorhandler
    If publicTile.oldDetail = 4 Or publicTile.oldDetail = 6 Then
        For X = 1 To 16
            For Y = 1 To 16
                If tilemem(X, Y) = -1 Then tilemem(X, Y) = vbQBColor(15)
                tilemem(X, Y) = GFXGetDOSColor(tilemem(X, Y))
            Next Y
        
        Next X
    End If
    If publicTile.oldDetail = 3 Or publicTile.oldDetail = 5 Then
        For X = 1 To 32
            For Y = 1 To 32
                If tilemem(X, Y) = -1 Then tilemem(X, Y) = vbQBColor(15)
                tilemem(X, Y) = GFXGetDOSColor(tilemem(X, Y))
            Next Y
        Next X
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

