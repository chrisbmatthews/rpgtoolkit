Attribute VB_Name = "RPGCodeProcess"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures for processing rpgcode
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

' Label to branch to on error
Public errorBranch As String

' Program kept as a backup for error handling
Public errorKeep As RPGCodeProgram

'=========================================================================
' Get the line a method begins on
'=========================================================================
Public Function getMethodLine(ByVal name As String, ByRef prg As RPGCodeProgram)

    On Error Resume Next

    Dim idx As Long                 ' For for loops

    ' Make name all caps
    name = Trim$(UCase$(name))

    ' Cycle through all methods in the program
    For idx = 0 To UBound(prg.methods)
        If (prg.methods(idx).name = name) Then
            ' Found it!
            getMethodLine = prg.methods(idx).line
            Exit Function
        ElseIf (idx = UBound(prg.methods)) Then
            ' Method not in program
            getMethodLine = -1
            Exit Function
        End If
    Next idx

End Function

'=========================================================================
' Add a method to a program
'=========================================================================
Public Sub addMethodToPrg(ByVal name As String, ByVal line As Long, ByRef prg As RPGCodeProgram)

    On Error Resume Next

    Dim idx As Long                 ' For for loops
    Dim space As Long               ' Space for entry

    ' Make name all caps
    name = Trim$(UCase$(name))

    ' Make space invalid
    space = -1

    ' Cycle through all methods already in the program
    For idx = 0 To UBound(prg.methods)
        If (prg.methods(idx).name = name) Then
            ' Already in program
            Exit Sub
        ElseIf (LenB(prg.methods(idx).name) = 0) Then
            ' If we haven't found a space
            If (space = -1) Then
                ' This is an empty space
                space = idx
            End If
        End If
    Next idx

    If (space = -1) Then
        ' If we get here, then there wasn't an empty space
        ReDim Preserve prg.methods(UBound(prg.methods) + 1)
        space = UBound(prg.methods)
    End If

    ' Now record the method
    prg.methods(space).name = name
    prg.methods(space).line = line

End Sub

'=========================================================================
' Clear an rpgcode program structure
'=========================================================================
Public Sub InitRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    On Error Resume Next
    ReDim thePrg.methods(0)
    Call ClearRPGCodeProcess(thePrg)
    thePrg.programPos = 0
    thePrg.Length = 0
    thePrg.currentHeapFrame = -1
    preErrorPos = 0
    ReDim thePrg.heapStack(1)
    ' Create local heap...
    Call AddHeapToStack(thePrg)
    ReDim thePrg.compilerStack(1)
    thePrg.currentCompileStackIdx = -1
    ' Init the classes array
    ReDim thePrg.classes.classes(0)
    ReDim thePrg.classes.nestle(0)
End Sub

'=========================================================================
' Return a compiled object of the program passed in
'=========================================================================
Public Function openProgram(ByVal file As String) As RPGCodeProgram

    ' This sub-routine processes the file passed in and makes it readable. It returns
    ' the compiled PRG.

    On Error Resume Next

    ' Get the location in the PAK file
    file = PakLocate(file)

    If Not (fileExists(file)) Then
        ' File doesn't exist-- bail!
        Exit Function
    End If

    Dim p As Long                   ' Ongoing length of program
    Dim num As Long                 ' File number
    Dim theLine As String           ' Line read from file
    Dim c(2) As String              ' Delimiter array
    Dim lines() As String           ' Array of lines
    Dim uD() As String              ' Delimters used
    Dim a As Long                   ' Loop control variables
    Dim buildLine As String         ' Whole line we're building
    Dim buildTemp As String         ' To add to the whole line
    Dim done As Boolean             ' Done?
    Dim toInclude() As String       ' Files to include
    Dim includeIdx As Long          ' Include index

    ' Init the PRG
    Call InitRPGCodeProcess(openProgram)

    ' Get a free file number
    num = FreeFile()

    ' Fix the problem with commands on the same line as an if(),
    ' method(), etc
    c(0) = "{"
    c(1) = "}"

    ' Allow multiple commands on one line:
    ' MWin("TEST") # System.Pause()
    c(2) = "#"

    ' Dimension the inclusion array
    includeIdx = -1
    ReDim toInclude(0)

    ' Open the file
    Open file For Input Access Read As num

        ' Dimension the .program() array
        ReDim openProgram.program(0)

        Do Until EOF(num)

            ' Read a line
            theLine = stripComments(fread(num))

            ' Trim up that line...
            theLine = replaceOutsideQuotes(Trim$(theLine), vbTab, vbNullString)

            If (Right$(theLine, 1) = "_") Then
                ' This line is actually only part of a line, let's get the
                ' whole line...

                buildLine = Trim$(Mid$(theLine, 1, Len(theLine) - 1))

                done = False
                Do Until done
                    If Not (EOF(num)) Then
                        buildTemp = replace(Trim$(stripComments(fread(num))), vbTab, vbNullString)
                        Select Case RightB$(buildTemp, 2)
                            Case "_"
                                buildTemp = _
                                    Mid$(buildTemp, 1, Len(buildTemp) - 1)
                            Case Else: done = True
                        End Select
                        buildLine = buildLine & " " & buildTemp
                    Else
                        done = True
                    End If
                Loop

                theLine = buildLine

            End If

            ' Check for inclusions
            If (LCase$(LeftB$(theLine, 16)) = "#include") Then

                ' Make sure it's not the include command
                If (InStrB(1, theLine, "(") = 0) Then

                    ' Increase the index
                    includeIdx = includeIdx + 1
                    ReDim Preserve toInclude(includeIdx)

                    ' Add the file to the list
                    toInclude(includeIdx) = replace(Trim$(Mid$(theLine, 9)), """", vbNullString)

                    ' Remove this line
                    theLine = vbNullString

                End If

            ElseIf (LCase$(LeftB$(theLine, 20)) = "#autolocal") Then

                ' Put auto localization in effect
                openProgram.autoLocal = True

                ' Remove this line
                theLine = vbNullString

            ElseIf (LCase$(LeftB$(theLine, 14)) = "#strict") Then

                ' Put strictness in effect
                openProgram.strict = True

                ' Remove this line
                theLine = vbNullString

            End If

            ' Remove prefixed #
            If (LeftB$(theLine, 2) = "#") Then theLine = Mid$(theLine, 2)

            ' Read line if not comment
            If ((LeftB$(theLine, 2) <> "*") And (LeftB$(theLine, 2) <> "//")) Then

                ' Split that sucker like it has NEVER been split before!
                lines() = multiSplit(theLine, c, uD, True)

                ' Now we're going to have some fun with the .program() array so
                ' make sure it'll enlarge itself...
                On Error GoTo enlargeProgram

                ' Add each line to the program...
                For a = 0 To (UBound(lines) + 1)

                    If (a = UBound(lines) + 1) Then
                        If (LenB(uD(UBound(lines)))) Then
                            openProgram.program(p + a) = uD(UBound(lines))
                        End If

                    ElseIf (a = 0) Then
                        openProgram.program(p + a) = lines(a)

                    Else

                        Select Case uD(a - 1)

                            Case "{", "}"
                                openProgram.program(p + a) = uD(a - 1)
                                openProgram.program(p + a + 1) = lines(a)
                                p = p + 1

                            Case "#"
                                If Left$(lines(a), 1) = " " Then
                                    openProgram.program(p + a) = uD(a - 1) & lines(a)
                                Else
                                    openProgram.program(p + a - 1) = _
                                        openProgram.program(p + a - 1) & uD(a - 1) & lines(a)
                                End If

                            Case Else
                                openProgram.program(p + a) = lines(a)

                        End Select

                    End If

                Next a

                ' Update p
                p = UBound(openProgram.program) + 1

            End If

            ' Update length of program
            openProgram.Length = p

        Loop ' (until end of file)

    Close num

    ' Now cycle over each line
    Dim strClass As String, depth As Long
    For a = 0 To UBound(openProgram.program)
        openProgram.program(a) = Trim$(replaceOutsideQuotes(openProgram.program(a), "#", vbNullString))
        Dim ucl As String
        ucl = UCase$(openProgram.program(a))
        If (LeftB$(ucl, 12) = "METHOD") Then
            ' It's a method
            If (StrPtr(strClass)) Then
                ' Check if the implementation is here
                Dim moveLine As Long
                moveLine = a
                Do
                    ' Check the next line
                    moveLine = moveLine + 1
                    If (LenB(openProgram.program(moveLine))) Then
                        ' There's a line here
                        If (openProgram.program(moveLine) = "{") Then
                            ' Implementation is here
                            Call addMethodToPrg(strClass & "::" & GetMethodName(openProgram.program(a)), a, openProgram)
                        End If
                        ' Either way, exit this loop
                        Exit Do
                    End If
                Loop
            Else
                Call addMethodToPrg(GetMethodName(openProgram.program(a)), a, openProgram)
            End If
        ElseIf (ucl = "{") Then
            If (StrPtr(strClass)) Then
                depth = depth + 1
            End If
        ElseIf (ucl = "}") Then
            If (StrPtr(strClass)) Then
                depth = depth - 1
                If (depth = 0) Then
                    strClass = vbNullString
                End If
            End If
        ElseIf (LeftB$(ucl, 10) = "CLASS") Then
            ' It's a class
            Dim istr As Long
            istr = InStr(1, openProgram.program(a), ":")
            If (istr) Then
                strClass = Trim$(replace(Left$(openProgram.program(a), istr - 1), "class", vbNullString, , 1, vbTextCompare))
            Else
                strClass = GetMethodName(openProgram.program(a))
            End If
        End If
    Next a

    ' Include all attached files
    For a = 0 To includeIdx

        ' Get the filename
        Dim theFile As String
        theFile = projectPath & prgPath & toInclude(a)

        If (fileExists(theFile)) Then
            ' It exists - include!
            Call includeProgram(openProgram, theFile)
        End If

    Next a

    ' Splice up the classes
    Call spliceUpClasses(openProgram)

    Exit Function

enlargeProgram:
    ' Uh-oh! The array is too small. We can fix that...
    ReDim Preserve openProgram.program(UBound(openProgram.program) + 1)
    Resume

End Function

'=========================================================================
' Include the contents of a file in a program
'=========================================================================
Public Sub includeProgram(ByRef prg As RPGCodeProgram, ByRef strFile As String)

    '// Passing string(s) ByRef for preformance reasons

    ' Open the program
    Dim toInclude As RPGCodeProgram
    toInclude = openProgram(strFile)

    ' A little trick to workaround a VB bug
    Dim ub As Long, backupPrg As RPGCodeProgram
    ub = UBound(prg.program)
    backupPrg = prg
    ReDim Preserve backupPrg.program(ub + 2 + toInclude.Length)
    ReDim Preserve backupPrg.strCommands(ub + 2 + toInclude.Length)
    prg = backupPrg

    ' Index variable
    Dim idx As Long

    ' Add all of the other program's methods
    For idx = 0 To UBound(toInclude.methods)
        If (LenB(toInclude.methods(idx).name)) Then
            Call addMethodToPrg( _
                                    toInclude.methods(idx).name, _
                                    toInclude.methods(idx).line + prg.Length + 2, _
                                    prg)
        End If
    Next idx

    ' Add all of its classes
    For idx = 0 To UBound(toInclude.classes.classes)
        Call addClassToProgram(toInclude.classes.classes(idx), prg)
    Next idx

    ' Prevent running of loose code
    prg.program(prg.Length + 1) = "stop()"

    ' Add its code to the program
    For idx = 0 To UBound(toInclude.program)
        prg.program(prg.Length + 2 + idx) = toInclude.program(idx)
        prg.strCommands(prg.Length + 2 + idx) = toInclude.strCommands(idx)
    Next idx

    ' Update the length of the program
    prg.Length = prg.Length + 2 + UBound(toInclude.program)

End Sub

'=========================================================================
' Strip comments off a line
'=========================================================================
Public Function stripComments(ByVal Text As String) As String
    Dim a As Long, char As String, ignore As Boolean
    For a = 1 To Len(Text)
        char = Mid$(Text, a, 2)
        If (Left$(char, 1) = ("""")) Then
            ignore = Not (ignore)
        ElseIf (char = "//") And (Not (ignore)) Then
            stripComments = Mid$(Text, 1, a - 1)
            Exit Function
        End If
    Next a
    stripComments = Text
End Function
