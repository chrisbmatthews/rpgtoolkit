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

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' --What is done
' + Many variables declared
' + Obsolete prodecures removed
' + ByVal or ByRef added to parameters
'
' --What needs to be done
' + Finish declaring variables and add Option Explicit
' + Check usage of all procedures to prevent boxing
' + Some procedures need serious help; help them
'
'=======================================================

Public Sub hideAllTools(): On Error Resume Next
     With tkMainForm
             .animationExtras.Visible = False
             .bottomFrame.Visible = False
             .tileExtras.Visible = False
             .bBar.Visible = False
             .tileBmpExtras.Visible = False
             .tilebmpTools.Visible = False
             .animationTools.Visible = False
             .rpgcodeTools.Visible = False
             .tileTools.Visible = False
             .boardTools.Visible = False
     End With
End Sub

Public Sub LocalizeTabStrip(ByRef TabStrip1 As TabStrip)

    On Error GoTo tabErr

    Dim t As Long
    
    t = 1
    Do Until done
        TabStrip1.Tabs.Item(t).Caption = LoadStringLoc(TabStrip1.Tabs.Item(t).tag, TabStrip1.Tabs.Item(t).Caption)
        t = t + 1
    Loop

    Exit Sub

tabErr:
    done = True
    Resume Next

End Sub

Public Sub TestGraphicsMode()
    'tsts the graphics mode.
    'if it cannot use the hi-speed dll, it will revert back to brddraw.exe
    On Error GoTo dllerr
    
    If targetPlatform = 1 Then
        'internal gfx engine-will work
        Exit Sub
    End If

    GFXInitScreen 640, 480
    'if we made it here, it worked, so we'll use the dll
    targetPlatform = 0
    'MsgBox "using dll"
    Exit Sub

dllerr:
    'if we made it here, it didn't work, so we'll use brrdaw
    targetPlatform = 2
    'MsgBox "using brddraw"
End Sub

Public Function absNoPath(ByVal file As String) As String

    On Error Resume Next

    Dim withoutPath As String
    withoutPath = noPath(file)
    withoutPath = Mid(withoutPath, 2, Len(withoutPath) - 1)
    absNoPath = withoutPath

End Function

Public Sub clearGame()
    'clears all game data
    On Error Resume Next
    projectPath = ""
    editmainfile.clearAll
    Unload editmainfile
End Sub

Public Sub makeFolders(ByVal theProjectPath As String)
    'creates all folders for a game, under projectpath ppath$
    On Error Resume Next
    MkDir Mid(theProjectPath & tilepath, 1, Len(theProjectPath & tilepath) - 1)
    MkDir Mid(theProjectPath & brdpath, 1, Len(theProjectPath & brdpath) - 1)
    MkDir Mid(theProjectPath & tempath, 1, Len(theProjectPath & tempath) - 1)
    MkDir Mid(theProjectPath & spcpath, 1, Len(theProjectPath & spcpath) - 1)
    MkDir Mid(theProjectPath & bkgpath, 1, Len(theProjectPath & bkgpath) - 1)
    MkDir Mid(theProjectPath & mediapath, 1, Len(theProjectPath & mediapath) - 1)
    MkDir Mid(theProjectPath & prgpath, 1, Len(theProjectPath & prgpath) - 1)
    MkDir Mid(theProjectPath & fontpath, 1, Len(theProjectPath & fontpath) - 1)
    MkDir Mid(theProjectPath & itmpath, 1, Len(theProjectPath & itmpath) - 1)
    MkDir Mid(theProjectPath & enepath, 1, Len(theProjectPath & enepath) - 1)
    MkDir Mid(theProjectPath & bmppath, 1, Len(theProjectPath & bmppath) - 1)
    MkDir Mid(theProjectPath & statuspath, 1, Len(theProjectPath & statuspath) - 1)
    MkDir Mid(theProjectPath & miscPath, 1, Len(theProjectPath & miscPath) - 1)
    MkDir Mid(theProjectPath & pluginPath, 1, Len(theProjectPath & pluginPath) - 1)
End Sub

Public Function resolve(ByVal theDirectory As String) As String
    On Error Resume Next
    resolve = theDirectory
    If Right(reslove, 1) <> "\" Then
        resolve = resolve & "\"
    End If
End Function

Public Function addUnderscore(ByVal text As String) As String
    On Error Resume Next
    addUnderscore = replace(text, " ", "_")
End Function

Public Function all(ByVal longColor As Long, ByVal requestedColor As Integer)
    Select Case requestedColor
        Case 1: all = red(longColor)
        Case 2: all = green(longColor)
        Case 3: all = blue(longColor)
    End Select
End Function

Public Function blue(ByVal longColor As Long) As Long
    On Error Resume Next
    blue = Int(longColor / 65536)
End Function

Public Sub color_16()

    On Error Resume Next

    Call winColor

    colorDepth.Show

    Dim x As Integer, y As Integer, qb As Long

    If detail = 2 Or detail = 4 Or detail = 6 Then
        For x = 1 To 16
            For y = 1 To 16
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    qb = toColor(tilemem(x, y), "16")
                    tilemem(x, y) = qb
                    qbtile(x, y) = qb
                End If
            Next y
            'colordepth.status.Line (0, 0)-((x / 16) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (x / 16) * 100, 10, vbQBColor(9))
        Next x
    End If
    If detail = 1 Or detail = 3 Or detail = 5 Then
        For x = 1 To 32
            For y = 1 To 32
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    qb = toColor(tilemem(x, y), "16")
                    tilemem(x, y) = qb
                    qbtile(x, y) = qb
                End If
            Next y
            Call vbPicFillRect(colorDepth.status, 0, 0, (x / 32) * 100, 10, vbQBColor(9))
            'colordepth.status.Line (0, 0)-((x / 32) * 100, 10), vbqbcolor(9), BF
        Next x
    End If

    Unload colorDepth

End Sub

Sub color_16million()

    On Error Resume Next

    If detail = 2 Or detail = 4 Or detail = 6 Then
        For x = 1 To 16
            For y = 1 To 16
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    tilemem(x, y) = GFXGetDOSColor(tilemem(x, y))
                End If
            Next y
        Next x
    End If
    If detail = 3 Or detail = 5 Then
        For x = 1 To 32
            For y = 1 To 32
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    tilemem(x, y) = GFXGetDOSColor(tilemem(x, y))
                End If
            Next y
            Call vbPicFillRect(colorDepth.status, 0, 0, (x / 32) * 100, 10, vbQBColor(9))
        Next x
        detail = 1
    End If

End Sub

Sub color_256()
    On Error GoTo ErrorHandler
    Call winColor
    colorDepth.Show
    If detail = 2 Or detail = 4 Or detail = 6 Then
        For x = 1 To 16
            For y = 1 To 16
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    qb = toColor(tilemem(x, y), "256")
                    tilemem(x, y) = qb
                    qbtile(x, y) = qb
                End If
            Next y
            'colordepth.status.Line (0, 0)-((x / 16) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (x / 16) * 100, 10, vbQBColor(9))
        Next x
    End If
    If detail = 1 Or detail = 3 Or detail = 5 Then
        For x = 1 To 32
            For y = 1 To 32
                If tilemem(x, y) = -1 Then
                    tilemem(x, y) = -1
                Else
                    qb = toColor(tilemem(x, y), "256")
                    tilemem(x, y) = qb
                    qbtile(x, y) = qb
                End If
            Next y
            'colordepth.status.Line (0, 0)-((x / 32) * 100, 10), vbqbcolor(9), BF
            Call vbPicFillRect(colorDepth.status, 0, 0, (x / 32) * 100, 10, vbQBColor(9))
        Next x
    End If
    Unload colorDepth

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Function extention(ByVal file As String) As String: On Error Resume Next
    '==================================================
    'Edited by Delano: rewritten!
    '==================================================

    Dim strArray() As String
    'Split the file.
    strArray() = Split(file, ".")
    'Last element will be the extension. Take the first 3 letters.
    extention = Left(strArray(UBound(strArray)), 3)

End Function

Public Function fileExist(ByVal theFile As String) As Byte
    If FileExists(theFile) Then fileExist = 1
End Function

Public Function getTipCount(ByVal file As String) As Long
    On Error Resume Next
    Dim num As Long
    num = FreeFile()
    Open file For Input As num
        Input #num, getTipCount
    Close num
End Function

Public Function getTipNum(ByVal file As String, ByVal tipNum As Long) As String
    'gets tip number from file.
    'returns it as string.
    Dim a As Long
    Dim ff As Long
    ff = FreeFile()
    Open file For Input As ff
        For a = 1 To getTipCount(file)
            Dim readData As String
            readData = fread(ff)
            If a = tipNum Then
                getTipNum = readData
                Exit Function
            End If
        Next a
    Close ff
End Function

Public Function green(ByVal longColor As Long) As Long
    On Error Resume Next
    green = Int(longColor - blue(longColor) / 256)
End Function

Sub highredrawLIGHT()
    On Error GoTo ErrorHandler
    'light.tileform.Line (0, 0)-(1000, 1000), vbqbcolor(1), BF
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    didthat = 0
    For x = 1 To 32
        For y = 1 To 32
            xx = (x * 10) - 9
            yy = (y * 10) - 9
            'If didthat = 0 Then MsgBox detail: didthat = 1
            If tilemem(x, y) <> -1 Then
                If detail = 1 Then
                    'light.tileform.Line (xx, yy)-((xx + 8), (yy + 8)), tilemem(x, y), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, tilemem(x, y))
                End If
                If detail = 3 Or detail = 5 Then
                    'MsgBox "hi"
                    'MsgBox tilemem(x, y)
                    'light.tileform.Line (xx, yy)-((xx + 8), (yy + 8)), gfxgetdoscolor(tilemem(x, y)), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, GFXGetDOSColor(tilemem(x, y)))
                End If
            End If
        Next y
    Next x
    publicTile.grid = 0
    'If publictile.grid = 1 Then publictile.grid = 0: activetile.gridonoff_click Else publictile.grid = 1: activetile.gridonoff_click

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Function inBounds(ByVal num As Double, ByVal low As Double, ByVal high As Double)
    On Error Resume Next
    If num < low Then num = low
    If num > high Then num = high
    inBounds = num
End Function

Sub increasedetail()
    On Error GoTo ErrorHandler
ReDim bufferTile(32, 32)
    If detail = 2 Then detail = 1
    If detail = 4 Then detail = 3
    If detail = 6 Then detail = 5
    For x = 1 To 16
        For y = 1 To 16
            bufferTile(x, y) = tilemem(x, y)
            tilemem(x, y) = -1
        Next y
    Next x
    
    interpolate = 0
    
    If interpolate = 1 Then
        'Increase detail
        xx = 1: yy = 1
        For x = 1 To 16
            For y = 1 To 16
                If x = 16 Then
                    If bufferTile(1, y) <> -1 And bufferTile(x, y) <> -1 Then
                        nextcolor = 0
                        r1 = red(bufferTile(x, y))
                        g1 = green(bufferTile(x, y))
                        b1 = blue(bufferTile(x, y))
                        r2 = red(bufferTile(1, y))
                        g2 = green(bufferTile(1, y))
                        b2 = blue(bufferTile(1, y))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        
                        tilemem(xx, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy) = nextcolor
                        tilemem(xx + 1, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy + 1) = bufferTile(x, y)
                    End If
                Else
                    If bufferTile(x + 1, y) <> -1 And bufferTile(x, y) <> -1 Then
                        nextcolor = 0
                        r1 = red(bufferTile(x, y))
                        g1 = green(bufferTile(x, y))
                        b1 = blue(bufferTile(x, y))
                        r2 = red(bufferTile(x + 1, y))
                        g2 = green(bufferTile(x + 1, y))
                        b2 = blue(bufferTile(x + 1, y))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        
                        tilemem(xx, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy) = nextcolor
                        tilemem(xx + 1, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy) = bufferTile(x, y)
                        tilemem(xx + 1, yy + 1) = bufferTile(x, y)
                    End If
                End If
                If y = 16 Then
                    If bufferTile(x, 1) <> -1 And bufferTile(x, y) <> -1 Then
                        nextcolor = 0
                        r1 = red(bufferTile(x, y))
                        g1 = green(bufferTile(x, y))
                        b1 = blue(bufferTile(x, y))
                        r2 = red(bufferTile(x, 1))
                        g2 = green(bufferTile(x, 1))
                        b2 = blue(bufferTile(x, 1))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        tilemem(xx, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy + 1) = bufferTile(x, y)
                    End If
                Else
                    If bufferTile(x, y + 1) <> -1 And bufferTile(x, y) <> -1 Then
                        nextcolor = 0
                        r1 = red(bufferTile(x, y))
                        g1 = green(bufferTile(x, y))
                        b1 = blue(bufferTile(x, y))
                        r2 = red(bufferTile(x, y + 1))
                        g2 = green(bufferTile(x, y + 1))
                        b2 = blue(bufferTile(x, y + 1))
                        
                        nextcolor = RGB((r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2)
                        tilemem(xx, yy + 1) = nextcolor
                    Else
                        tilemem(xx, yy + 1) = bufferTile(x, y)
                    End If
                End If
                yy = yy + 2
            Next y
            yy = 1
            xx = xx + 2
        Next x
    Else
        'Increase detail
        xx = 1: yy = 1
        For x = 1 To 16
            For y = 1 To 16
                tilemem(xx, yy) = bufferTile(x, y)
                tilemem(xx, yy + 1) = bufferTile(x, y)
                tilemem(xx + 1, yy) = bufferTile(x, y)
                tilemem(xx + 1, yy + 1) = bufferTile(x, y)
                yy = yy + 2
            Next y
            yy = 1
            xx = xx + 2
        Next x
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub lowRedrawLight()
    On Error GoTo ErrorHandler
    'light.tileform.Line (0, 0)-(1000, 1000), vbqbcolor(1), BF
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    For x = 1 To 16
        For y = 1 To 16
            xx = (x * 20) - 19
            yy = (y * 20) - 19
            If tilemem(x, y) <> -1 Then
                If detail = 2 Then
                    'light.tileform.Line (xx, yy)-(xx + 18, yy + 18), tilemem(x, y), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, tilemem(x, y))
                End If
                If detail = 4 Or detail = 6 Then
                    'light.tileform.Line (xx, yy)-(xx + 18, yy + 18), gfxgetdoscolor(tilemem(x, y)), BF
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, GFXGetDOSColor(tilemem(x, y)))
                End If
            End If
        Next y
    Next x
    publicTile.grid = 0
    'If publictile.grid = 1 Then publictile.grid = 0: activetile.gridonoff_click Else publictile.grid = 1: activetile.gridonoff_click

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Function NoExtention(ByVal file As String) As String
    On Error Resume Next
    Dim workOn As String, running As String, col As Long, length As Long, part As String
    workOn = file
    running = ""
    col = 1
    length = Len(file)
    Do While part <> "." And col <= length + 1
        running = running & part$
        part = Mid(workOn, col, 1)
        col = col + 1
    Loop
    NoExtention = running
End Function

Public Function noPath(ByVal text As String) As String

    On Error Resume Next

    Dim a As String, t As Long, length As Long, aPath As Long, ll As Long, part _
    As String, pathUse As String, path As String, term As String, lastOne As Long

    a = text
    length = Len(a)
    'first, see if there IS a path:
    For t = 1 To length
        part = Mid(a, t, 1)
        If part = ":" Or part = "\" Then aPath = 1
    Next t
    If aPath = 0 Then noPath = a$: Exit Function
    'Now see if the path terminates with a \ or a :
    For t = 1 To length
        part = Mid(a, t, 1)
        If part = ":" Or part = "\" Then term = part
    Next t
    If term = ":" Then
        'if it terminates with a :, then the filename is right after :
        For t = 1 To length
            part = Mid(a, t, 1)
            pathUse = pathUse & part
            If part = ":" Then
                path = ""
                For ll = t To length
                    part = Mid(a, ll, 1)
                    path = path & part
                Next ll
                noPath = path
                Exit Function
            End If
        Next t
    ElseIf term = "\" Then
        lastOne = 1
        'If it terminates with a "\" then we've got problems.  where is the last one at?
        For t = 1 To length
            part = Mid(a, t, 1)
            If part = "\" Then lastOne = t
        Next t
        'Now let's scoop out the path"
        pathUse = ""
        For t = lastOne To length
            part = Mid(a, t, 1)
            pathUse = pathUse & part
        Next t
        noPath = pathUse
    End If

End Function

Public Function noSpaces(ByVal text As String) As String
    On Error Resume Next
    noSpaces = replace(text, " ", "")
End Function

Public Sub openConfig(ByVal file As String)
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    m_LangFile = ""
    Open file For Input As num
        Input #num, v
        Input #num, tipsOnOff            'tip window on/off (0=off, 1=on)
        Input #num, tipFile             'tipfilename
        Input #num, tipNum               'tip number
        Input #num, targetPlatform       'target platform 0=win9x, 1-winNT
        Input #num, commandsDocked       'command buttons docked (hidden) 0=no, 1=yes
        Input #num, filesDocked          'file dialog docked?
        Input #num, lastProject
        Input #num, mp3Path            'path of mp3 files
        Input #num, wallpaper          'wallpaper file
        For t = 0 To 4
            Input #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
            Input #num, quickTarget(t) 'quick launch targets
            Input #num, quickIcon(t)   'quick launch icons
        Next t
        Input #num, tutCurrentLesson
        Input #num, m_LangFile
        If wallpaper = "" Then
            wallpaper = "bkg.jpg"
        End If
        If wallpaper = "NONE" Then
            wallpaper = ""
        End If
    Close num
End Sub

Public Sub openMainFile(ByVal file As String)
    On Error Resume Next
    projectPath = ""
    If file = "" Then Exit Sub
    openMain file, mainMem
    oldpath = currentDir & "\" & projectPath$
    Call mainoption.TreeView1.Nodes.Clear
    Call tkMainForm.fillTree("", projectPath)
    mainoption.Caption = "RPG Toolkit Development System, Version 2.2 (" + absNoPath(file) + ")"
    'set up gfx mode...
    Call TestGraphicsMode
End Sub

Public Sub doOpenTile(ByVal file As String, ByVal doWinColor As Boolean)

    On Error GoTo loadtileerr

    Dim filenm As String
    filenm = file
    filename$(1) = filenm$
    ex$ = extention(filenm$)
    
    If UCase$(ex$) = "TST" Or UCase$(ex$) = "ISO" Then          'Added.

        Call openFromTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        
        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increasedetail
        End If
        If doWinColor Then
            Call winColor
        Else
            Call color_16million
        End If
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
                For x = 1 To 32
                    For y = 1 To 32
                        Input #num, tilemem(x, y) 'Pixel by pixel
                    Next y
                Next x
'                call activetile.highredraw
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For x = 1 To 16
                    For y = 1 To 16
                        Input #num, tilemem(x, y)
                    Next y
                Next x
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
    If doWinColor Then
        Call winColor
    Else
        Call color_16million
    End If
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
    If doWinColor Then
        Call winColor
    Else
        Call color_16million
    End If
    If tileError = 1 Then MsgBox "Unable to open selected filename": tileError = 0 'Else call activetile.lowredraw
    Exit Sub

loadtileerr:
tileError = 1
Resume Next

End Sub

Public Sub openTile2(ByVal filenm As String)
    doOpenTile filenm, False
End Sub

Public Sub openWinTile(ByVal filenm As String)
    doOpenTile filenm, True
End Sub

Public Function pathOf(ByVal text As String) As String
    'Determines path of filename
    
    On Error Resume Next

    Dim length As Long, aPath As Byte, part As String, t As Long
    Dim pathUse As String, term As String, lastOne As Long, path As String

    length = Len(text)
    'first, see if there IS a path:
    For t = 1 To length
        part = Mid(text, t, 1)
        If part = ":" Or part = "\" Then aPath = 1
    Next t
    If aPath = 0 Then pathOf = ""
    'Now see if the path terminates with a \ or a :
    For t = 1 To length
        part = Mid(text, t, 1)
        If part = ":" Or part = "\" Then term = part
    Next t
    pathUse = ""
    If term = ":" Then
        'if it terminates with a :, then the filename is right after :
        For t = 1 To length
            part = Mid(text, t, 1)
            pathUse = pathUse & part
            If part = ":" Then pathOf = pathUse
        Next t
    ElseIf term = "\" Then
        lastOne = 1
        'If it terminates with a "\" then we've got problems.  where is the last one at?
        For t = 1 To length
            part = Mid(text, t, 1)
            If part = "\" Then lastOne = t
        Next t
        'Now let's scoop out the path
        pathUse = ""
        For t = 1 To lastOne
            part = Mid(text, t, 1)
            pathUse = pathUse & part
        Next t
        pathOf = pathUse
    End If

End Function

Public Function red(ByVal longColor As Long) As Long
    On Error Resume Next
    Dim takeAway As Long
    takeAway = blue(longColor) * 256 * 256
    longColor = longColor - takeAway
    takeAway = green(longColor) * 256
    red = longColor - takeAway
End Function

Public Sub reduceDetail()
    On Error Resume Next
    Dim bufferTile(32, 32) As Long
    If detail = 1 Then detail = 2
    If detail = 3 Then detail = 4
    If detail = 5 Then detail = 6
    Dim x As Long, y As Long, xx As Long, yy As Long
    For x = 1 To 32
        For y = 1 To 32
            bufferTile(x, y) = tilemem(x, y)
            tilemem(x, y) = -1
        Next y
    Next x
    xx = 1
    yy = 1
    For x = 1 To 32 Step 2
        For y = 1 To 32 Step 2
            tilemem(xx, yy) = bufferTile(x, y)
            yy = yy + 1
        Next y
        yy = 1
        xx = xx + 1
    Next x
End Sub

Public Function replaceChar(ByVal text As String, ByVal find As String, ByVal replaceWith As String) As String
    replaceChar = replace(text, find, replaceWith)
End Function

Public Function roundOff(ByVal number As Double) As Long
    roundOff = Round(number)
End Function

Public Sub saveConfig(ByVal file As String)
    'opens up config file

    On Error Resume Next

    Dim num As Long
    num = FreeFile()
    
    If wallpaper = "" Then
        wallpaper = "NONE"
    End If

    Open file For Output As num
        Print #num, "RPGTOOLKIT 2 CONFIG"
        Print #num, tipsOnOff        'tip window on/off (0=off, 1=on)
        Print #num, tipFile         'tipfilename
        Print #num, tipNum           'tip number
        Print #num, targetPlatform   'target platform 0=win9x, 1-winNT
        Print #num, commandsDocked   'command buttons docked (hidden) 0=no, 1=yes
        Print #num, filesDocked      'file dialog docked?
        Print #num, lastProject
        Print #num, mp3Path       'path of mp3 files
        Print #num, wallpaper      'wallpaper file
        For t = 0 To 4
            Print #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
            Print #num, quickTarget(t) 'quick launch targets
            Print #num, quickIcon(t)   'quick launch icons
        Next t
        Print #num, tutCurrentLesson
        Print #num, m_LangFile
    Close num

End Sub

Public Sub saveprogram(ByVal file As String)
    'Save program
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    Open file For Output As num
        Print #num, activeRPGCode.codeForm.text
    Close num
End Sub

Public Sub savetile(ByVal filenm As String): On Error Resume Next
'====================================
'Alterations for isometrics - 3.0.4
'Added recognition for .iso - Delano

    filename(1) = filenm

    Dim extension As String
    extension = UCase(GetExt(filename(1)))
    
    If extension = "TST" Or extension = "ISO" Then      'Added.
        Call insertIntoTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        Exit Sub
    End If

    Dim num As Long
    num = FreeFile()
    Open filename(1) For Output As num
        Print #num, "RPGTLKIT TILE"    'Filetype
        Print #num, Major               'Version
        Print #num, Minor                'Minor version (ie 2.0)
        Print #num, detail             'Detail level- 1 is 32x32, 2 is 16x16
        Print #num, compression        'Compression 1-on, 0-off

        Dim x As Integer, y As Integer
        Dim occurances As Long, older As Long
        Dim starting As Byte

        If compression = 0 Then         'If no compression was usd, save it normally, pixel by pixel.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For x = 1 To 32
                    For y = 1 To 32
                        Print #num, tilemem(x, y) 'Pixel by pixel
                    Next y
                Next x
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For x = 1 To 16
                    For y = 1 To 16
                        Print #num, tilemem(x, y)
                    Next y
                Next x
            End If

        ElseIf compression = 1 Then         'If there is compression, save it in bundles, count how many times pixels occur together, and write #of times, color of pixel
            occurances = 1
            older = tilemem(1, 1)
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For x = 1 To 32
                    For y = 1 To 32
                        If Not (x = 1 And y = 1) Then
                            If tilemem(x, y) = older Then
                                occurances = occurances + 1
                            Else
                                Print #num, occurances    'how many times it occurred.
                                Print #num, older         'what color it is
                                older = tilemem(x, y)
                                occurances = 1
                            End If
                        End If
                    Next y
                Next x
                Print #num, occurances
                Print #num, older
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For x = 1 To 16
                    For y = 1 To 16
                        If Not (x = 1 And y = 1) Then
                            If tilemem(x, y) = older Then
                                occurances = occurances + 1
                            Else
                                Print #num, occurances    'how many times it occurred.
                                Print #num, older         'what color it is
                                older = tilemem(x, y)
                                occurances = 1
                                starting = 0
                            End If
                        End If
                    Next y
                Next x
                Print #num, occurances
                Print #num, older
            End If
        End If
    Close num

End Sub

Public Sub saveConfigAndEnd(ByVal file As String)
    'opens up config file
    On Error Resume Next
    Call saveConfig(file)
    Call StopTracing
    Call CloseCanvasEngine
    Call GFXKill
    End
End Sub

Public Function toString(ByVal val As String) As String
    On Error Resume Next
    toString = str(noSpaces(val))
End Function

Public Function toColor(ByVal longColor As Long, ByVal level As Long) As Long

    On Error Resume Next

    Dim theseColors() As Long

    Dim loops As Long
    If level = 16 Then loops = 15
    If level = 256 Then loops = 255

    Dim redComp As Long, greenComp As Long, blueComp As Long
    redComp = all(getit, 1)
    greenComp = all(getit, 2)
    blueComp = all(getit, 3)

    Dim t As Long
    For t = 0 To loops

        Dim gb As Long, qbRed As Long, qbGreen As Long, qbBlue As Long
        qb = GFXGetDOSColor(t)
        qbRed = all(qb, 1)
        qbGreen = all(qb, 2)
        qbBlue = all(qb, 3)
    
        If qbRed = redComp And qbGreen = greenComp And qbBlue = blueComp Then
            toColor = t
            Exit Function
        End If

        Dim deltaRed As Long, deltaGreen As Long, deltaBlue As Long
        deltaRed = redComp - qbRed
        deltaGreen = greenComp - qbGreen
        deltaBlue = blueComp - qbBlue

        Dim pythag As Long
        pythag = (deltaRed ^ 2) + (deltaGreen ^ 2) + (deltaBlue ^ 2)
        ReDim Preserve theseColors(t)
        theseColors(t) = pythag
        Dim lesser As Long, qbLesser As Long
        If theseColors(t) < lesser Then
            lesser = theseColors(t)
            qbLesser = t
        End If

    Next t
    
    toColor = qbLesser

End Function

Public Sub winColor()

    On Error Resume Next

    Dim x As Integer, y As Integer
    
    If publicTile.oldDetail = 4 Or publicTile.oldDetail = 6 Then
        For x = 1 To 16
            For y = 1 To 16
                If tilemem(x, y) = -1 Then tilemem(x, y) = vbQBColor(15)
                tilemem(x, y) = GFXGetDOSColor(tilemem(x, y))
            Next y
        Next x
    End If

    If publicTile.oldDetail = 3 Or publicTile.oldDetail = 5 Then
        For x = 1 To 32
            For y = 1 To 32
                If tilemem(x, y) = -1 Then tilemem(x, y) = vbQBColor(15)
                tilemem(x, y) = GFXGetDOSColor(tilemem(x, y))
            Next y
        Next x
    End If

End Sub

Public Sub ChangeBoolean(ByRef bol As Boolean)
 bol = Not bol
End Sub

Public Function BooleanToLong(ByVal bol As Boolean) As Long
 If bol = True Then BooleanToLong = 1
 If bol = False Then BooleanToLong = 0
End Function

Public Function integerToBoolean(ByVal inte As Integer) As Boolean
 If inte = 1 Then integerToBoolean = True
 If inte = 0 Then integerToBoolean = False
End Function

Public Function leftBit(ByVal str1 As String, ByVal str2 As String) As Boolean
 If Left(str1, Len(str2)) = str2 Then leftBit = True
End Function
