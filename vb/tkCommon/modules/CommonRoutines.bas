Attribute VB_Name = "commonRoutines"
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
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' --What is done
' + Option Explicit added
' + Obsolete prodecures removed
' + ByVal or ByRef added to parameters
' + Purpose of procedures added
' + Trans & Toolkit routines files merged
'
' --What needs to be done
' + Check usage of all procedures to prevent boxing
' + Some procedures need serious help; help them
'
'=======================================================

Option Explicit

#If isToolkit = 1 Then

    '=======================================================
    'Toolkit routines
    '=======================================================

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
            TabStrip1.Tabs.item(t).caption = LoadStringLoc(TabStrip1.Tabs.item(t).Tag, TabStrip1.Tabs.item(t).caption)
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
        absNoPath = Mid(withoutPath, 2, Len(withoutPath) - 1)
    End Function

    Public Sub clearGame()
        '=======================================================
        'Clears all open main file data
        '=======================================================
        On Error Resume Next
        projectPath = ""
        editmainfile.clearAll
        Call Unload(editmainfile)
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
        MkDir Mid(theProjectPath & plugPath, 1, Len(theProjectPath & plugPath) - 1)
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
        addUnderscore = replace(Text, " ", "_")
    End Function

    Public Function all(ByVal longColor As Long, ByVal requestedColor As Integer) As Long
        '=======================================================
        'Returns red, green, or blue from the color passed in
        '=======================================================
        Select Case requestedColor
            Case 1: all = red(longColor)
            Case 2: all = green(longColor)
            Case 3: all = blue(longColor)
        End Select
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
                    If tileMem(x, y) = -1 Then
                        tileMem(x, y) = -1
                    Else
                        tileMem(x, y) = GFXGetDOSColor(tileMem(x, y))
                    End If
                Next y
            Next x
        ElseIf detail = 3 Or detail = 5 Then
            For x = 1 To 32
                For y = 1 To 32
                    If tileMem(x, y) = -1 Then
                        tileMem(x, y) = -1
                    Else
                        tileMem(x, y) = GFXGetDOSColor(tileMem(x, y))
                    End If
                Next y
                Call vbPicFillRect(colordepth.status, 0, 0, (x / 32) * 100, 10, vbQBColor(9))
            Next x
            detail = 1
        End If

    End Sub

    Public Function getTipCount(ByVal file As String) As Long
        '=======================================================
        'Returns number of tips in tip file
        '=======================================================
        On Error Resume Next
        Dim num As Long
        num = FreeFile()
        Open file For Input As num
            Do Until EOF(num)
                Call fread(num)
                getTipCount = getTipCount + 1
            Loop
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
            Do While True
                Dim readData As String
                readData = fread(ff)
                a = a + 1
                If a = tipNum Then
                    getTipNum = readData
                    Exit Function
                End If
            Loop
        Close ff
    End Function

    Public Sub highRedrawLight()
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
                If tileMem(x, y) <> -1 Then
                    If detail = 1 Then
                        Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, tileMem(x, y))
                    ElseIf detail = 3 Or detail = 5 Then
                        Call vbPicFillRect(light.tileform, xx, yy, xx + 8, yy + 8, GFXGetDOSColor(tileMem(x, y)))
                    End If
                End If
            Next y
        Next x
        openTileEditorDocs(activeTile.indice).grid = 0

    End Sub

    Public Function inBounds(ByVal num As Double, ByVal low As Double, ByVal high As Double) As Double
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
                bufferTile(x, y) = tileMem(x, y)
                tileMem(x, y) = -1
            Next y
        Next x

        'Increase detail
        xx = 1: yy = 1
        For x = 1 To 16
            For y = 1 To 16
                tileMem(xx, yy) = bufferTile(x, y)
                tileMem(xx, yy + 1) = bufferTile(x, y)
                tileMem(xx + 1, yy) = bufferTile(x, y)
                tileMem(xx + 1, yy + 1) = bufferTile(x, y)
                yy = yy + 2
            Next y
            yy = 1
            xx = xx + 2
        Next x

    End Sub

    Public Sub lowRedrawLight()
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
                If tileMem(x, y) <> -1 Then
                    If detail = 2 Then
                        Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, tileMem(x, y))
                    ElseIf detail = 4 Or detail = 6 Then
                        Call vbPicFillRect(light.tileform, xx, yy, xx + 18, yy + 18, GFXGetDOSColor(tileMem(x, y)))
                    End If
                End If
            Next y
        Next x
        openTileEditorDocs(activeTile.indice).grid = 0

    End Sub

    Public Function noExtention(ByVal file As String) As String
        '=======================================================
        'Returns the file passed in without its extension
        '=======================================================
        On Error Resume Next
        Dim workOn As String, running As String, col As Long, Length As Long, part As String
        workOn = file
        running = ""
        col = 1
        Length = Len(file)
        Do While part <> "." And col <= Length + 1
            running = running & part
            part = Mid(workOn, col, 1)
            col = col + 1
        Loop
        noExtention = running
    End Function

    Public Function noPath(ByVal Text As String) As String

        '=======================================================
        'Returns the file passed in without its path
        '=======================================================

        On Error Resume Next

        Dim a As String, t As Long, Length As Long, aPath As Long, ll As Long, part _
        As String, pathUse As String, path As String, term As String, lastOne As Long

        a = Text
        Length = Len(a)
        'first, see if there IS a path:
        For t = 1 To Length
            part = Mid(a, t, 1)
            If part = ":" Or part = "\" Then aPath = 1
        Next t
        If aPath = 0 Then noPath = a$: Exit Function
        'Now see if the path terminates with a \ or a :
        For t = 1 To Length
            part = Mid(a, t, 1)
            If part = ":" Or part = "\" Then term = part
        Next t
        If term = ":" Then
            'if it terminates with a :, then the filename is right after :
            For t = 1 To Length
                part = Mid(a, t, 1)
                pathUse = pathUse & part
                If part = ":" Then
                    path = ""
                    For ll = t To Length
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
            For t = 1 To Length
                part = Mid(a, t, 1)
                If part = "\" Then lastOne = t
            Next t
            'Now let's scoop out the path"
            pathUse = ""
            For t = lastOne To Length
                part = Mid(a, t, 1)
                pathUse = pathUse & part
            Next t
            noPath = pathUse
        End If

    End Function

    Public Sub openMainFile(ByVal file As String)
        '=======================================================
        'Opens the main file passed in
        '=======================================================
        On Error Resume Next
        projectPath = ""
        If file = "" Then Exit Sub
        Call openMain(file, mainMem)
        oldpath = currentDir & "\" & projectPath
        'Call tkMainForm.fillTree("", projectPath)
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

            Call openFromTileSet(tilesetFilename(filenm), getTileNum(filenm))
        
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
        openTileEditorDocs(activeTile.indice).tileNeedUpdate = False
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
                user = MsgBox("This tile was created using Version " & str(majorVer) & "." & str(minorVer) & ".  You have version " & currentVersion & ". Opening this file may not work.  Continue?", vbYesNo, "Different Version")
                If user = vbNo Then
                    Close num
                    Exit Sub
                End If
            End If
            detail = fread(num)
            Dim comp As Byte
            comp = fread(num)

            If comp = 0 Then 'super-old gph
                If detail = 1 Or detail = 3 Or detail = 5 Then
                    For x = 1 To 32
                        For y = 1 To 32
                            openTileEditorDocs(activeTile.indice).tileMem(x, y) = fread(num) 'Pixel by pixel
                        Next y
                    Next x
                ElseIf detail = 2 Or detail = 4 Or detail = 6 Then
                    For x = 1 To 16
                        For y = 1 To 16
                            openTileEditorDocs(activeTile.indice).tileMem(x, y) = fread(num)
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
                            openTileEditorDocs(activeTile.indice).tileMem(xx, yy) = colorTime
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
                            openTileEditorDocs(activeTile.indice).tileMem(xx, yy) = colorTime
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
                        openTileEditorDocs(activeTile.indice).tileMem(xx, yy) = GFXGetDOSColor(theValue)
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

    Public Sub openTile2(ByVal file As String)
        '=======================================================
        'Opens a tile in 16-million color mode
        '=======================================================
        Call doOpenTile(file, False)
    End Sub

    Public Sub openWinTile(ByVal file As String)
        '=======================================================
        'Opens a file in win-color mode
        '=======================================================
        Call doOpenTile(file, True)
    End Sub

    Public Function pathOf(ByVal Text As String) As String

        '=======================================================
        'Returns the path of the file passed in
        '=======================================================

        On Error Resume Next

        Dim Length As Long, aPath As Byte, part As String, t As Long
        Dim pathUse As String, term As String, lastOne As Long, path As String

        Length = Len(Text)
        'first, see if there IS a path:
        For t = 1 To Length
            part = Mid(Text, t, 1)
            If part = ":" Or part = "\" Then aPath = 1
        Next t
        If aPath = 0 Then pathOf = ""
        'Now see if the path terminates with a \ or a :
        For t = 1 To Length
            part = Mid(Text, t, 1)
            If part = ":" Or part = "\" Then term = part
        Next t
        pathUse = ""
        If term = ":" Then
            'if it terminates with a :, then the filename is right after :
            For t = 1 To Length
                part = Mid(Text, t, 1)
                pathUse = pathUse & part
                If part = ":" Then pathOf = pathUse
            Next t
        ElseIf term = "\" Then
            lastOne = 1
            'If it terminates with a "\" then we've got problems.  where is the last one at?
            For t = 1 To Length
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

    Public Sub saveProgram(ByVal file As String)
        '=======================================================
        'Saves the text in the open prg editor to the file
        'passed in
        '=======================================================
        On Error Resume Next
        Dim num As Long
        num = FreeFile
        Open file For Output As num
            Print #num, activeRPGCode.CodeForm.Text
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
            Call insertIntoTileSet(tilesetFilename(filenm), getTileNum(filenm$))
            Exit Sub
        End If

        Dim num As Long
        num = FreeFile()
        Open filename(1) For Output As num
            Print #num, "RPGTLKIT TILE"    'Filetype
            Print #num, major               'Version
            Print #num, minor                'Minor version (ie 2.0)
            Print #num, detail             'Detail level- 1 is 32x32, 2 is 16x16

            Dim x As Integer, y As Integer
            Dim occurances As Long, older As Long
            Dim starting As Byte

            #If compression = 0 Then         'If no compression was usd, save it normally, pixel by pixel.
                Print #num, 0
                If detail = 1 Or detail = 3 Or detail = 5 Then
                    For x = 1 To 32
                        For y = 1 To 32
                            Print #num, tileMem(x, y) 'Pixel by pixel
                        Next y
                    Next x
                ElseIf detail = 2 Or detail = 4 Or detail = 6 Then
                    For x = 1 To 16
                        For y = 1 To 16
                            Print #num, tileMem(x, y)
                        Next y
                    Next x
                End If

            #ElseIf compression = 1 Then         'If there is compression, save it in bundles, count how many times pixels occur together, and write #of times, color of pixel
                Print #num, 1
                occurances = 1
                older = tileMem(1, 1)
                If detail = 1 Or detail = 3 Or detail = 5 Then
                    For x = 1 To 32
                        For y = 1 To 32
                            If Not (x = 1 And y = 1) Then
                                If tileMem(x, y) = older Then
                                    occurances = occurances + 1
                                Else
                                    Print #num, occurances    'how many times it occurred.
                                    Print #num, older         'what color it is
                                    older = tileMem(x, y)
                                    occurances = 1
                                End If
                            End If
                        Next y
                    Next x
                    Print #num, occurances
                    Print #num, older
                ElseIf detail = 2 Or detail = 4 Or detail = 6 Then
                    For x = 1 To 16
                        For y = 1 To 16
                            If Not (x = 1 And y = 1) Then
                                If tileMem(x, y) = older Then
                                    occurances = occurances + 1
                                Else
                                    Print #num, occurances    'how many times it occurred.
                                    Print #num, older         'what color it is
                                    older = tileMem(x, y)
                                    occurances = 1
                                    starting = 0
                                End If
                            End If
                        Next y
                    Next x
                    Print #num, occurances
                    Print #num, older
                End If
            #End If
        Close num

    End Sub

    Public Sub saveConfigAndEnd(ByVal file As String)
        '=======================================================
        'Saves configuration to the file passed in and exit
        '=======================================================
        On Error Resume Next
        Call StopTracing
        Call CloseCanvasEngine
        Call GFXKill
        Call Unload(configfile)
        Set configfile = Nothing
    End Sub

    Public Function toColor(ByVal longColor As Long, ByVal level As Long) As Long

        '=======================================================
        'Returns the color passed in in a specific detail level
        '=======================================================

        On Error Resume Next

        Dim theseColors() As Long

        Dim loops As Long
        If level = 16 Then loops = 15
        If level = 256 Then loops = 255

        Dim getIt As Long
        getIt = longColor

        Dim redcomp As Long, greenComp As Long, blueComp As Long
        redcomp = all(getIt, 1)
        greenComp = all(getIt, 2)
        blueComp = all(getIt, 3)

        Dim t As Long
        For t = 0 To loops

            Dim qb As Long, qbRed As Long, qbGreen As Long, qbBlue As Long
            qb = GFXGetDOSColor(t)
            qbRed = all(qb, 1)
            qbGreen = all(qb, 2)
            qbBlue = all(qb, 3)
    
            If qbRed = redcomp And qbGreen = greenComp And qbBlue = blueComp Then
                toColor = t
                Exit Function
            End If

            Dim deltaRed As Long, deltaGreen As Long, deltaBlue As Long
            deltaRed = redcomp - qbRed
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

        '=======================================================
        'Converts the current tile to win-color mode
        '=======================================================

        On Error Resume Next

        Dim x As Integer, y As Integer
    
        If openTileEditorDocs(activeTile.indice).oldDetail = 4 Or openTileEditorDocs(activeTile.indice).oldDetail = 6 Then
            For x = 1 To 16
                For y = 1 To 16
                    If tileMem(x, y) = -1 Then tileMem(x, y) = vbQBColor(15)
                    tileMem(x, y) = GFXGetDOSColor(tileMem(x, y))
                Next y
            Next x
        ElseIf openTileEditorDocs(activeTile.indice).oldDetail = 3 Or openTileEditorDocs(activeTile.indice).oldDetail = 5 Then
            For x = 1 To 32
                For y = 1 To 32
                    If tileMem(x, y) = -1 Then tileMem(x, y) = vbQBColor(15)
                    tileMem(x, y) = GFXGetDOSColor(tileMem(x, y))
                Next y
            Next x
        End If

    End Sub

    Public Function integerToBoolean(ByVal inte As Integer) As Boolean
        '=======================================================
        'Return a boolean for 1/0
        '=======================================================
        If inte = 1 Then integerToBoolean = True
    End Function

#Else

    '=======================================================
    'Trans routines
    '=======================================================

    Public Function multiSplit( _
                                  ByVal txt As String, _
                                  ByRef chars() As String, _
                                  ByRef usedDelimiters() As String, _
                                  Optional ByVal ignoreQuotes As Boolean _
                                                                           ) As String()

        '=======================================================
        'Splits a string at multiple characters
        '=======================================================

        On Error Resume Next

        'Declarations...
        Dim ignore As Boolean
        Dim ret() As String
        Dim uD() As String
        Dim a As Long
        Dim b As Long
        Dim c As String
 
        'Make one space in the arrays...
        ReDim ret(0)
        ReDim uD(0)
 
        'For each character in the string...
        For a = 1 To Len(txt)

            c = Mid(txt, a, 1) 'Get the charater
            ret(UBound(ret)) = ret(UBound(ret)) & c

            If c = """" Then
                If ignoreQuotes Then
                    If Not ignore Then
                        ignore = True
                    Else
                        ignore = False
                    End If
                End If
            End If
  
            If Not ignore Then
                'For each delimiter...
                For b = 0 To UBound(chars)
                    'It's a delimiter...
                    If c = chars(b) Then
                        'Take it off the ret() array...
                        ret(UBound(ret)) = left(ret(UBound(ret)), _
                        Len(ret(UBound(ret))) - 1)
                        'Put it in the ud() array...
                        uD(UBound(ret)) = c
                        'Enlarge the ret() array
                        ReDim Preserve ret(UBound(ret) + 1)
                        'Enlarge the ud() array...
                        ReDim Preserve uD(UBound(uD) + 1)
                    End If
                Next b
            End If

        Next a 'Onto the next character
 
        'Make sure the last array element isn't empty...
        If ret(UBound(ret)) = "" Then ReDim Preserve ret(UBound(ret) - 1)
 
        'Pass back the data...
        multiSplit = ret()
        usedDelimiters = uD()

    End Function

    Public Sub openMainFile(ByVal file As String)

        '=======================================================
        'Opens a main file
        '=======================================================

        On Error Resume Next

        projectPath = ""
        mainMem.mainResolution = 0

        Call openMain(file, mainMem)
        Call ChangeLanguage(resourcePath & m_LangFile)
    
        'set gfx mode...
        If resX = 0 Then
            resX = (screenWidth) / screen.TwipsPerPixelX
            resY = screenHeight / screen.TwipsPerPixelY
        End If

    End Sub

#End If

'=======================================================
'Common Routines
'=======================================================

Public Function booleanToLong(ByVal bol As Boolean) As Long
    '=======================================================
    'Return a boolean as 1/0
    '=======================================================
    If bol Then booleanToLong = 1
End Function

Public Function toString(ByVal val As String) As String
     '=======================================================
     'Returns the value passed in without spaces
     '=======================================================
     On Error Resume Next
     toString = str(noSpaces(val))
End Function

Public Function noSpaces(ByVal Text As String) As String
    '=======================================================
    'Remove spaces from the text passed in
    '=======================================================
    On Error Resume Next
    noSpaces = replace(Text, " ", "")
End Function

Public Function blue(ByVal longColor As Long) As Long
    '=======================================================
    'Returns blue from the color passed in
    '=======================================================
    On Error Resume Next
    blue = Int(longColor / 65536)
End Function

Public Function green(ByVal longColor As Long) As Long
    '=======================================================
    'Returns green from the color passed in
    '=======================================================
    On Error Resume Next
    Dim working As Long, blueComp As Long, takeAway As Long
    working = longColor
    blueComp = Int(working / 65536)
    takeAway = blueComp * 256 * 256
    working = working - takeAway
    green = Int(working / 256)
End Function

Public Function red(ByVal longColor As Long) As Long
    '=======================================================
    'Returns red from the color passed in
    '=======================================================
    On Error Resume Next
    Dim working As Long, blueComp As Long, takeAway As Long, greenComp As Long
    working = longColor
    blueComp = Int(working / 65536)
    takeAway = blueComp * 256 * 256
    working = working - takeAway
    greenComp = Int(working / 256)
    takeAway = greenComp * 256
    red = working - takeAway
End Function

'Currently running version
Public Property Get currentVersion() As String
    currentVersion = App.major & "." & App.minor & "." & App.Revision
End Property

Public Function extention(ByVal file As String) As String: On Error Resume Next
    '=======================================================
    'Returns only the extension of a file
    '=======================================================
    Dim strArray() As String
    'Split the file.
    strArray() = Split(file, ".")
    'Last element will be the extension. Take the first 3 letters.
    extention = left(strArray(UBound(strArray)), 3)
End Function
