Attribute VB_Name = "Routines"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
' Routines
'
' Contains various misc procedures. Some are possibly
' better off in different places.
'=======================================================

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
' + Option Explicit added
' + Obsolete prodecures removed
' + ByVal or ByRef added to parameters
' + Purpose of procedures added
'
' --What needs to be done
' + Check usage of all procedures to prevent boxing
' + Some procedures need serious help; help them
'
'=======================================================

Option Explicit

Public Sub createFileAssociations()
    '=======================================================
    'Creates all file associations
    '=======================================================
    On Error Resume Next
    Call CreateAssociation("prg", "RPGCode Program", App.path & "\" & App.EXEName & ".exe")
End Sub

Public Sub hideAllTools(): On Error Resume Next
    '=======================================================
    'Hides all toolbars
    '=======================================================
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
    '=======================================================
    'Localizes a tab strip
    '=======================================================
    On Error GoTo tabErr
    Dim done As Boolean
    Dim t As Long
    Do Until done
        t = t + 1
        TabStrip1.Tabs.Item(t).Caption = LoadStringLoc(TabStrip1.Tabs.Item(t).tag, TabStrip1.Tabs.Item(t).Caption)
    Loop
    Exit Sub
tabErr:
    done = True
    Resume Next
End Sub

Public Function absNoPath(ByVal file As String) As String
    '=======================================================
    'Returns only a filename without its path
    '=======================================================
    On Error Resume Next
    Dim withoutPath As String
    withoutPath = noPath(file)
    withoutPath = Mid(withoutPath, 2, Len(withoutPath) - 1)
    absNoPath = withoutPath
End Function

Public Sub clearGame()
    '=======================================================
    'Clears all open main file data
    '=======================================================
    On Error Resume Next
    projectPath = ""
    editmainfile.clearAll
    Unload editmainfile
End Sub

Public Sub makeFolders(ByVal theProjectPath As String)
    '=======================================================
    'Creates all project folders
    '=======================================================
    On Error Resume Next
    MkDir Mid(theProjectPath & tilePath, 1, Len(theProjectPath & tilePath) - 1)
    MkDir Mid(theProjectPath & brdPath, 1, Len(theProjectPath & brdPath) - 1)
    MkDir Mid(theProjectPath & temPath, 1, Len(theProjectPath & temPath) - 1)
    MkDir Mid(theProjectPath & spcPath, 1, Len(theProjectPath & spcPath) - 1)
    MkDir Mid(theProjectPath & bkgPath, 1, Len(theProjectPath & bkgPath) - 1)
    MkDir Mid(theProjectPath & mediaPath, 1, Len(theProjectPath & mediaPath) - 1)
    MkDir Mid(theProjectPath & prgPath, 1, Len(theProjectPath & prgPath) - 1)
    MkDir Mid(theProjectPath & fontPath, 1, Len(theProjectPath & fontPath) - 1)
    MkDir Mid(theProjectPath & itmPath, 1, Len(theProjectPath & itmPath) - 1)
    MkDir Mid(theProjectPath & enePath, 1, Len(theProjectPath & enePath) - 1)
    MkDir Mid(theProjectPath & bmpPath, 1, Len(theProjectPath & bmpPath) - 1)
    MkDir Mid(theProjectPath & statusPath, 1, Len(theProjectPath & statusPath) - 1)
    MkDir Mid(theProjectPath & miscPath, 1, Len(theProjectPath & miscPath) - 1)
    MkDir Mid(theProjectPath & pluginPath, 1, Len(theProjectPath & pluginPath) - 1)
End Sub

Public Function resolve(ByVal theDirectory As String) As String
    '=======================================================
    'Makes sure a directory ends with a \
    '=======================================================
    On Error Resume Next
    resolve = theDirectory
    If Right(resolve, 1) <> "\" Then
        resolve = resolve & "\"
    End If
End Function

Public Function addUnderscore(ByVal Text As String) As String
    '=======================================================
    'Replaces spaces with underscores
    '=======================================================
    On Error Resume Next
    addUnderscore = Replace(Text, " ", "_")
End Function

Public Function all(ByVal longcolor As Long, ByVal requestedColor As Integer) As Long
    '=======================================================
    'Returns red, green, or blue from the color passed in
    '=======================================================
    Select Case requestedColor
        Case 1: all = red(longcolor)
        Case 2: all = green(longcolor)
        Case 3: all = blue(longcolor)
    End Select
End Function

Public Function blue(ByVal longcolor As Long) As Long
    '=======================================================
    'Returns blue from the color passed in
    '=======================================================
    On Error Resume Next
    blue = Int(longcolor / 65536)
End Function

Public Sub color_16million()

    '=======================================================
    'Upgrades current tile to 16 million colors
    '=======================================================

    On Error Resume Next

    Dim x As Single, y As Single

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

Public Function extention(ByVal file As String) As String: On Error Resume Next

    '=======================================================
    'Returns only the extension of a file
    '=======================================================

    Dim strArray() As String
    'Split the file.
    strArray() = Split(file, ".")
    'Last element will be the extension. Take the first 3 letters.
    extention = Left(strArray(UBound(strArray)), 3)

End Function

Public Function FileExist(ByVal theFile As String) As Byte
    '=======================================================
    'Returns whether a file exists as 1/0
    '=======================================================
    If FileExists(theFile) Then FileExist = 1
End Function

Public Function getTipCount(ByVal file As String) As Long
    '=======================================================
    'Returns number of tips in tip file
    '=======================================================
    On Error Resume Next
    Dim num As Long
    num = FreeFile()
    Open file For Input As num
        Input #num, getTipCount
    Close num
End Function

Public Function getTipNum(ByVal file As String, ByVal tipNum As Long) As String
    '=======================================================
    'Reads tip tipNum from the tip file
    '=======================================================
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

Public Function green(ByVal longcolor As Long) As Long
    '=======================================================
    'Returns green from the color passed in
    '=======================================================
    On Error Resume Next
    green = Int(longcolor - blue(longcolor) / 256)
End Function

Public Sub highredrawLIGHT()
    '=======================================================
    'Redraws a tile's light source (high-quality)
    '=======================================================

    On Error Resume Next

    Dim x As Long, y As Long, xx As Long, yy As Long
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    For x = 1 To 32
        For y = 1 To 32
            xx = (x * 10) - 9
            yy = (y * 10) - 9
            If tilemem(x, y) <> -1 Then
                If detail = 1 Then
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, tilemem(x, y))
                End If
                If detail = 3 Or detail = 5 Then
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, GFXGetDOSColor(tilemem(x, y)))
                End If
            End If
        Next y
    Next x
    publicTile.grid = 0

End Sub

Public Function inBounds(ByVal num As Double, ByVal low As Double, ByVal high As Double)
    '=======================================================
    'Returns num in bounds of low and high
    '=======================================================
    On Error Resume Next
    If num < low Then num = low
    If num > high Then num = high
    inBounds = num
End Function

Public Sub increaseDetail()
    '=======================================================
    'Upgrades a 16x16 tile to 32x32
    '=======================================================

    Dim bufferTile(32, 32) As Long

    If detail = 2 Then detail = 1
    If detail = 4 Then detail = 3
    If detail = 6 Then detail = 5

    Dim x As Long, y As Long
    Dim xx As Long, yy As Long

    For x = 1 To 16
        For y = 1 To 16
            bufferTile(x, y) = tilemem(x, y)
            tilemem(x, y) = -1
        Next y
    Next x

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

End Sub

Public Sub lowredrawLIGHT()
    '=======================================================
    'Redraws a tile's light source (low-quality)
    '=======================================================

    On Error Resume Next

    Dim x As Long, y As Long, xx As Long, yy As Long
    
    Call vbPicFillRect(light.tileform, 0, 0, 1000, 1000, vbQBColor(1))
    For x = 1 To 16
        For y = 1 To 16
            xx = (x * 20) - 19
            yy = (y * 20) - 19
            If tilemem(x, y) <> -1 Then
                If detail = 2 Then
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, tilemem(x, y))
                End If
                If detail = 4 Or detail = 6 Then
                    Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, GFXGetDOSColor(tilemem(x, y)))
                End If
            End If
        Next y
    Next x
    publicTile.grid = 0

End Sub

Public Function NoExtention(ByVal file As String) As String
    '=======================================================
    'Returns the file passed in without its extension
    '=======================================================
    On Error Resume Next
    Dim workOn As String, running As String, col As Long, length As Long, part As String
    workOn = file
    running = ""
    col = 1
    length = Len(file)
    Do While part <> "." And col <= length + 1
        running = running & part
        part = Mid(workOn, col, 1)
        col = col + 1
    Loop
    NoExtention = running
End Function

Public Function noPath(ByVal Text As String) As String

    '=======================================================
    'Returns the file passed in without its path
    '=======================================================

    On Error Resume Next

    Dim a As String, t As Long, length As Long, aPath As Long, ll As Long, part _
    As String, pathUse As String, path As String, term As String, lastOne As Long

    a = Text
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

Public Function noSpaces(ByVal Text As String) As String
    '=======================================================
    'Remove spaces from the text passed in
    '=======================================================
    On Error Resume Next
    noSpaces = Replace(Text, " ", "")
End Function

Public Sub openConfig(ByVal file As String)
    '=======================================================
    'Opens the config file passed in
    '=======================================================
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    m_LangFile = ""
    Open file For Input As num
        fread num
        Input #num, tipsOnOff            'tip window on/off (0=off, 1=on)
        Input #num, tipFile             'tipfilename
        Input #num, tipNum               'tip number
        Call fread(num)       'target platform 0=win9x, 1-winNT
        Input #num, commandsDocked       'command buttons docked (hidden) 0=no, 1=yes
        Input #num, filesDocked          'file dialog docked?
        Input #num, lastProject
        Input #num, mp3Path            'path of mp3 files
        Input #num, wallpaper          'wallpaper file
        Dim t As Long
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
    '=======================================================
    'Opens the main file passed in
    '=======================================================
    On Error Resume Next
    projectPath = ""
    If file = "" Then Exit Sub
    openMain file, mainMem
    oldpath = currentDir & "\" & projectPath
    Call tkMainForm.fillTree("", projectPath)
    tkMainForm.Caption = "RPG Toolkit Development System, Version 2.2 (" + absNoPath(file) + ")"
End Sub

Private Sub doOpenTile(ByVal file As String, ByVal doWinColor As Boolean)

    '=======================================================
    'Privately handles opening of a tile
    '=======================================================

    On Error GoTo loadtileerr

    Dim filenm As String
    filenm = file
    filename(1) = filenm
    Dim ex As String
    ex = UCase(extention(filenm$))
    
    If ex = "TST" Or ex = "ISO" Then

        Call openFromTileSet(tilesetFilename(filenm$), getTileNum(filenm$))
        
        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increaseDetail
        End If
        If doWinColor Then
            Call winColor
        Else
            Call color_16million
        End If
        Exit Sub
    End If
    
    Dim x As Long, y As Long, xx As Long, yy As Long
    Dim loopIt As Long, times As Long, tileerror As Integer

    Dim num As Long
    num = FreeFile()
    publicTile.tileneedupdate = False
    Open filename(1) For Input As num
        Dim fileHeader As String
        Input #num, fileHeader        'Filetype
        If fileHeader <> "RPGTLKIT TILE" Then Close #num: GoTo Version1Tile
        Dim majorVer As Integer, minorVer As Integer
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This tile was created with an unrecognised version of the Toolkit", , "Unable to open tile": Exit Sub
        If minorVer <> minor Then
            Dim user As VbMsgBoxResult
            user = MsgBox("This tile was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = vbNo Then Close num: Exit Sub     'selected no
        End If
        Input #num, detail             'Detail level- 1 is 32x32, 2 is 16x16
        Dim comp As Byte
        Input #num, comp              'Compression used? 1- yes, 0-no
        If comp = 0 Then     'If compression was not used, the tile is stored with each value representing a pixel.
            If detail = 1 Or detail = 3 Or detail = 5 Then
                For x = 1 To 32
                    For y = 1 To 32
                        Input #num, tilemem(x, y) 'Pixel by pixel
                    Next y
                Next x
            End If
            If detail = 2 Or detail = 4 Or detail = 6 Then
                For x = 1 To 16
                    For y = 1 To 16
                        Input #num, tilemem(x, y)
                    Next y
                Next x
            End If
        ElseIf comp = 1 Then    'If compression is used, pixel 'bundles' come in pairs of two.
                                'The first number is how many times in a row that pixel appears, and the second number
                                'is the pixel itself.
            Dim colorTime As Long
            If detail = 1 Or detail = 3 Or detail = 5 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 33
                    Input #num, times
                    Input #num, colorTime
                    For loopIt = 1 To times
                        tilemem(xx, yy) = colorTime
                        yy = yy + 1
                        If yy > 32 Then yy = 1: xx = xx + 1
                    Next loopIt
                Loop
            ElseIf detail = 2 Or detail = 4 Or detail = 6 Then
                'Uncompress
                xx = 1: yy = 1
                Do While xx < 17
                    Input #num, times
                    Input #num, colorTime
                    For loopIt = 1 To times
                        tilemem(xx, yy) = colorTime
                        yy = yy + 1
                        If yy > 16 Then yy = 1: xx = xx + 1
                    Next loopIt
                Loop
            End If
        End If
        'That's all
    Close num
    If detail = 2 Or detail = 4 Or detail = 6 Then
        'only 32x32 tiles allowed
        Call increaseDetail
    End If
    If doWinColor Then
        Call winColor
    Else
        Call color_16million
    End If
    If tileerror = 1 Then MsgBox "Unable to open selected filename": tileerror = 0
    Exit Sub

Version1Tile:
    'We come here if the tile is (probably) made with version 1
    Open filename(1) For Input As num
        detail = 2
        For yy = 1 To 16
            Dim tile As String
            Line Input #num, tile
                For xx = 1 To 16
                    Dim part As String
                    part = Mid(tile, xx, 1)
                    Dim theValue As Long
                    theValue = Asc(part)
                    theValue = theValue - 33
                    tilemem(xx, yy) = GFXGetDOSColor(theValue)
                Next xx
        Next yy
    Close num
    If detail = 2 Or detail = 4 Or detail = 6 Then
        'only 32x32 tiles allowed
        Call increaseDetail
    End If
    If doWinColor Then
        Call winColor
    Else
        Call color_16million
    End If
    If tileerror = 1 Then MsgBox "Unable to open selected filename": tileerror = 0 'Else call activetile.lowredraw
    Exit Sub

loadtileerr:
tileerror = 1
Resume Next

End Sub

Public Sub openTile2(ByVal filenm As String)
    '=======================================================
    'Opens a tile in 16-million color mode
    '=======================================================
    doOpenTile filenm, False
End Sub

Public Sub openWinTile(ByVal filenm As String)
    '=======================================================
    'Opens a file in win-color mode
    '=======================================================
    doOpenTile filenm, True
End Sub

Public Function pathOf(ByVal Text As String) As String

    '=======================================================
    'Returns the path of the file passed in
    '=======================================================

    On Error Resume Next

    Dim length As Long, aPath As Byte, part As String, t As Long
    Dim pathUse As String, term As String, lastOne As Long, path As String

    length = Len(Text)
    'first, see if there IS a path:
    For t = 1 To length
        part = Mid(Text, t, 1)
        If part = ":" Or part = "\" Then aPath = 1
    Next t
    If aPath = 0 Then pathOf = ""
    'Now see if the path terminates with a \ or a :
    For t = 1 To length
        part = Mid(Text, t, 1)
        If part = ":" Or part = "\" Then term = part
    Next t
    pathUse = ""
    If term = ":" Then
        'if it terminates with a :, then the filename is right after :
        For t = 1 To length
            part = Mid(Text, t, 1)
            pathUse = pathUse & part
            If part = ":" Then pathOf = pathUse
        Next t
    ElseIf term = "\" Then
        lastOne = 1
        'If it terminates with a "\" then we've got problems.  where is the last one at?
        For t = 1 To length
            part = Mid(Text, t, 1)
            If part = "\" Then lastOne = t
        Next t
        'Now let's scoop out the path
        pathUse = ""
        For t = 1 To lastOne
            part = Mid(Text, t, 1)
            pathUse = pathUse & part
        Next t
        pathOf = pathUse
    End If

End Function

Public Function red(ByVal longcolor As Long) As Long
    '=======================================================
    'Returns red from the color passed in
    '=======================================================
    On Error Resume Next
    Dim takeaway As Long
    takeaway = blue(longcolor) * 256 * 256
    longcolor = longcolor - takeaway
    takeaway = green(longcolor) * 256
    red = longcolor - takeaway
End Function

Public Function replaceChar(ByVal Text As String, ByVal find As String, ByVal replaceWith As String) As String
    '=======================================================
    'Replaces instances of find with replaceWith in text
    '=======================================================
    replaceChar = Replace(Text, find, replaceWith)
End Function

Public Function roundOff(ByVal number As Double) As Long
    '=======================================================
    'Returns the number passed in rounded
    '=======================================================
    roundOff = Round(number)
End Function

Public Sub saveConfig(ByVal file As String)
    '=======================================================
    'Save configuration to the file passed in
    '=======================================================

    On Error Resume Next

    Dim num As Long
    num = FreeFile()
    
    If wallpaper = "" Then
        wallpaper = "NONE"
    End If

    Open file For Output As num
        Print #num, 0
        Print #num, tipsOnOff        'tip window on/off (0=off, 1=on)
        Print #num, tipFile         'tipfilename
        Print #num, tipNum           'tip number
        Print #num, 0
        Print #num, commandsDocked   'command buttons docked (hidden) 0=no, 1=yes
        Print #num, filesDocked      'file dialog docked?
        Print #num, lastProject
        Print #num, mp3Path       'path of mp3 files
        Print #num, wallpaper      'wallpaper file
        Dim t As Long
        For t = 0 To 4
            Print #num, quickEnabled(t) 'As Integer   'quick launch enabled 1-yes, 0-no
            Print #num, quickTarget(t) 'quick launch targets
            Print #num, quickIcon(t)   'quick launch icons
        Next t
        Print #num, tutCurrentLesson
        Print #num, m_LangFile
    Close num

End Sub

Public Sub saveProgram(ByVal file As String)
    '=======================================================
    'Saves the text in the open prg editor to the file
    'passed in
    '=======================================================
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    Open file For Output As num
        Print #num, activeRPGCode.codeForm.Text
    Close num
End Sub

Public Sub saveTile(ByVal filenm As String): On Error Resume Next
    '=======================================================
    'Saves the current tile to the file passed in
    '=======================================================

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
        Print #num, major               'Version
        Print #num, minor                'Minor version (ie 2.0)
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
    '=======================================================
    'Saves configuration to the file passed in and exit
    '=======================================================
    On Error Resume Next
    Call saveConfig(file)
    Call StopTracing
    Call CloseCanvasEngine
    Call GFXKill
    End
End Sub

Public Function toString(ByVal val As String) As String
    '=======================================================
    'Returns the value passed in without spaces
    '=======================================================
    On Error Resume Next
    toString = str(noSpaces(val))
End Function

Public Function toColor(ByVal longcolor As Long, ByVal level As Long) As Long

    '=======================================================
    'Returns the color passed in in either in a specific
    'detail level
    '=======================================================

    On Error Resume Next

    Dim theseColors() As Long

    Dim loops As Long
    If level = 16 Then loops = 15
    If level = 256 Then loops = 255

    Dim getIt As Long
    getIt = longcolor

    Dim redcomp As Long, greencomp As Long, bluecomp As Long
    redcomp = all(getIt, 1)
    greencomp = all(getIt, 2)
    bluecomp = all(getIt, 3)

    Dim t As Long
    For t = 0 To loops

        Dim qb As Long, qbRed As Long, qbGreen As Long, qbBlue As Long
        qb = GFXGetDOSColor(t)
        qbRed = all(qb, 1)
        qbGreen = all(qb, 2)
        qbBlue = all(qb, 3)
    
        If qbRed = redcomp And qbGreen = greencomp And qbBlue = bluecomp Then
            toColor = t
            Exit Function
        End If

        Dim deltaRed As Long, deltaGreen As Long, deltaBlue As Long
        deltaRed = redcomp - qbRed
        deltaGreen = greencomp - qbGreen
        deltaBlue = bluecomp - qbBlue

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

    '=======================================================
    'Converts the current tile to win-color mode
    '=======================================================

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

Public Function BooleanToLong(ByVal bol As Boolean) As Long
    '=======================================================
    'Return a boolean as 1/0
    '=======================================================
    If bol = True Then BooleanToLong = 1
    If bol = False Then BooleanToLong = 0
End Function

Public Function integerToBoolean(ByVal inte As Integer) As Boolean
    '=======================================================
    'Return a boolean for 1/0
    '=======================================================
    If inte = 1 Then integerToBoolean = True
    If inte = 0 Then integerToBoolean = False
End Function
