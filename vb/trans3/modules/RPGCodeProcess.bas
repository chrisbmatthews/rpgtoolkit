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
' Add a local heap to a program
'=========================================================================
Public Sub AddHeapToStack(ByRef thePrg As RPGCodeProgram)
    On Error Resume Next
    thePrg.currentHeapFrame = thePrg.currentHeapFrame + 1
    If (thePrg.currentHeapFrame + 1 > UBound(thePrg.heapStack)) Then
        ' Resize heap stack
        ReDim Preserve thePrg.heapStack(thePrg.currentHeapFrame * 2)
    End If
    thePrg.heapStack(thePrg.currentHeapFrame) = RPGCCreateHeap()
End Sub

'=========================================================================
' Add a value to a stack
'=========================================================================
Public Sub PushCompileStack(ByRef thePrg As RPGCodeProgram, ByVal value As String)
    On Error Resume Next
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx + 1
    If (thePrg.currentCompileStackIdx + 1 > UBound(thePrg.compilerStack)) Then
        ' Resize stack
        ReDim Preserve thePrg.compilerStack(thePrg.currentCompileStackIdx * 2)
    End If
    thePrg.compilerStack(thePrg.currentCompileStackIdx) = value
End Sub

'=========================================================================
' Pop a value from a stack
'=========================================================================
Public Function PopCompileStack(ByRef thePrg As RPGCodeProgram) As String
    On Error Resume Next
    If (thePrg.currentCompileStackIdx = -1) Then
        Exit Function
    End If
    PopCompileStack = thePrg.compilerStack(thePrg.currentCompileStackIdx)
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx - 1
End Function

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
' Remove all heaps from a program
'=========================================================================
Public Sub ClearRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    On Error GoTo skipheap
    ' Clear the stack
    ReDim thePrg.methods(0)
    Dim t As Long
    For t = 0 To UBound(thePrg.heapStack)
        Call RPGCDestroyHeap(thePrg.heapStack(t))
        thePrg.heapStack(t) = 0
    Next t
    For t = 0 To UBound(thePrg.included)
        thePrg.included(t) = vbNullString
    Next t
skipheap:
    thePrg.currentHeapFrame = -1
    thePrg.currentCompileStackIdx = -1
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

    If (Not fileExists(file)) Then
        ' File doesn't exist-- bail!
        Exit Function
    End If

    Dim p As Long                   ' Ongoing length of program
    Dim num As Long                 ' File number
    Dim theLine As String           ' Line read from file
    Dim thePrg As RPGCodeProgram    ' Return value
    Dim c(2) As String              ' Delimiter array
    Dim lines() As String           ' Array of lines
    Dim uD() As String              ' Delimters used
    Dim a As Long                   ' Loop control variables
    Dim buildLine As String         ' Whole line we're building
    Dim buildTemp As String         ' To add to the whole line
    Dim done As Boolean             ' Done?

    ' Init the PRG
    Call InitRPGCodeProcess(thePrg)

    ' Get a free file number
    num = FreeFile()

    ' Fix the problem with commands on the same line as an if(),
    ' method(), etc
    c(0) = "{"
    c(1) = "}"

    ' Allow multiple commands on one line:
    ' MWin("TEST") # System.Pause()
    c(2) = "#"

    ' Open the file
    Open file For Input Access Read As num

        ' Dimension the .program() array...
        ReDim thePrg.program(0)

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
                    If Not EOF(num) Then
                        buildTemp = replace(Trim$(stripComments(fread(num))), vbTab, vbNullString)
                        Select Case Right$(buildTemp, 1)
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

            ' Remove prefixed #
            If (Left$(theLine, 1) = "#") Then theLine = Right$(theLine, Len(theLine) - 1)

            ' Read line if not comment
            If (Not Left$(theLine, 1) = "*") And (Not Left$(theLine, 2) = "//") Then

                ' Split that sucker like it has NEVER been split before!
                lines() = multiSplit(theLine, c, uD, True)

                ' Now we're going to have some fun with the .program() array so
                ' make sure it'll enlarge itself...
                On Error GoTo enlargeProgram

                ' Add each line to the program...
                For a = 0 To (UBound(lines) + 1)

                    If (a = UBound(lines) + 1) Then
                        If (LenB(uD(UBound(lines))) <> 0) Then
                            thePrg.program(p + a) = uD(UBound(lines))
                        End If

                    ElseIf (a = 0) Then
                        thePrg.program(p + a) = lines(a)

                    Else

                        Select Case uD(a - 1)

                            Case "{", "}"
                                thePrg.program(p + a) = uD(a - 1)
                                thePrg.program(p + a + 1) = lines(a)
                                p = p + 1

                            Case "#"
                                If Left$(lines(a), 1) = " " Then
                                    thePrg.program(p + a) = uD(a - 1) & lines(a)
                                Else
                                    thePrg.program(p + a - 1) = _
                                        thePrg.program(p + a - 1) & uD(a - 1) & lines(a)
                                End If

                            Case Else
                                thePrg.program(p + a) = lines(a)

                        End Select

                    End If

                Next a

                ' Update p
                p = UBound(thePrg.program) + 1

            End If

            ' Update length of program
            thePrg.Length = p

        Loop ' (until end of file)

    Close num

    ' Now cycle over each line
    Dim strClass As String, depth As Long
    For a = 0 To UBound(thePrg.program)
        thePrg.program(a) = Trim$(replaceOutsideQuotes(thePrg.program(a), "#", vbNullString))
        Dim ucl As String
        ucl = UCase$(thePrg.program(a))
        If (LeftB$(ucl, 12) = "METHOD") Then
            ' It's a method
            If (StrPtr(strClass)) Then
                ' Check if the implementation is here
                Dim moveLine As Long
                moveLine = a
                Do
                    ' Check the next line
                    moveLine = moveLine + 1
                    If (LenB(thePrg.program(moveLine)) <> 0) Then
                        ' There's a line here
                        If (thePrg.program(moveLine) = "{") Then
                            ' Implementation is here
                            Call addMethodToPrg(strClass & "::" & GetMethodName(thePrg.program(a)), a, thePrg)
                        End If
                        ' Either way, exit this loop
                        Exit Do
                    End If
                Loop
            Else
                Call addMethodToPrg(GetMethodName(thePrg.program(a)), a, thePrg)
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
            istr = InStr(1, thePrg.program(a), ":")
            If (istr) Then
                strClass = Trim$(replace(Left$(thePrg.program(a), istr - 1), "class", vbNullString, , 1, vbTextCompare))
            Else
                strClass = GetMethodName(thePrg.program(a))
            End If
        End If
    Next a

    ' Splice up the classes
    Call spliceUpClasses(thePrg)

    ' Return the result
    openProgram = thePrg

    Exit Function

enlargeProgram:
    ' Uh-oh! The array is too small. We can fix that...
    ReDim Preserve thePrg.program(UBound(thePrg.program) + 1)
    Resume

End Function

'=========================================================================
' Strip comments off a line
'=========================================================================
Public Function stripComments(ByVal Text As String) As String
    Dim a As Long, char As String, ignore As Boolean
    For a = 1 To Len(Text)
        char = Mid$(Text, a, 2)
        If (Left$(char, 1) = ("""")) Then
            ignore = (Not ignore)
        ElseIf (char = "//") And (Not ignore) Then
            stripComments = Mid$(Text, 1, a - 1)
            Exit Function
        End If
    Next a
    stripComments = Text
End Function

'=========================================================================
' Remove a heap from a stack
'=========================================================================
Public Function RemoveHeapFromStack(ByRef thePrg As RPGCodeProgram) As Boolean
    On Error Resume Next
    If thePrg.currentHeapFrame >= 0 Then
        Call RPGCDestroyHeap(thePrg.heapStack(thePrg.currentHeapFrame))
        thePrg.currentHeapFrame = thePrg.currentHeapFrame - 1
        RemoveHeapFromStack = True
        Exit Function
    End If
    RemoveHeapFromStack = False
End Function
