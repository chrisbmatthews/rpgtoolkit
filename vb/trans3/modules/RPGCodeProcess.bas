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

Public Type RPGCodeProgram           'rpgcode program structure
    program() As String              '  the program text
    programPos As Long               '  current position in program
    included(50) As String           '  included files
    Length As Long                   '  length of program
    heapStack() As Long              '  stack of local heaps
    currentHeapFrame As Long         '  current heap frame
    boardNum As Long                 '  the corresponding board index of the program (default to 0)
    threadID As Long                 '  the thread id (-1 if not a thread)
    compilerStack() As String        '  stack used by 'compiled' programs
    currentCompileStackIdx As Long   '  current index of compilerStack
    looping As Boolean               '  is a multitask program looping?
    autoLocal As Boolean             '  force implicitly created variables to the local scope?
End Type

Public errorBranch As String         'label to branch to on error

'=========================================================================
' Add a local heap to a program
'=========================================================================
Public Sub AddHeapToStack(ByRef thePrg As RPGCodeProgram)
    On Error Resume Next
    thePrg.currentHeapFrame = thePrg.currentHeapFrame + 1
    If (thePrg.currentHeapFrame + 1 > UBound(thePrg.heapStack)) Then
        'resize heap stack
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
        'resize stack
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
    Call ClearRPGCodeProcess(thePrg)
    thePrg.programPos = 0
    thePrg.Length = 0
    thePrg.currentHeapFrame = -1
    preErrorPos = 0
    ReDim thePrg.heapStack(1)
    'create local heap...
    Call AddHeapToStack(thePrg)
    ReDim thePrg.compilerStack(1)
    thePrg.currentCompileStackIdx = -1
End Sub

'=========================================================================
' Remove all heaps from a program
'=========================================================================
Public Sub ClearRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    On Error GoTo skipheap
    'clear the stack...
    Dim t As Long
    For t = 0 To UBound(thePrg.heapStack)
        Call RPGCDestroyHeap(thePrg.heapStack(t))
        thePrg.heapStack(t) = 0
    Next t
    For t = 0 To UBound(thePrg.included)
        thePrg.included(t) = ""
    Next t
skipheap:
    thePrg.currentHeapFrame = -1
    thePrg.currentCompileStackIdx = -1
End Sub

'=========================================================================
' Return a compiled object of the program passed in
'=========================================================================
Public Function openProgram(ByVal file As String) As RPGCodeProgram

    'This sub-routine processes the file passed in and makes it readable. It returns
    'the compiled PRG.

    On Error Resume Next

    If Not fileExists(file) Then
        'File doesn't exist-- bail!
        Exit Function
    End If

    Dim p As Long                   'Ongoing length of program
    Dim num As Long                 'File number
    Dim theLine As String           'Line read from file
    Dim thePrg As RPGCodeProgram    'Return value
    Dim c(2) As String              'Delimiter array
    Dim lines() As String           'Array of lines
    Dim uD() As String              'Delimters used
    Dim a As Long                   'Loop control variables
    Dim buildLine As String         'Whole line we're building
    Dim buildTemp As String         'To add to the whole line
    Dim done As Boolean             'Done?

    'Init the PRG
    Call InitRPGCodeProcess(thePrg)

    'Get the location in the PAK file
    file = PakLocate(file)

    'Get a free file number
    num = FreeFile()

    'Fix the problem with commands on the same line as an if(),
    'method(), etc
    c(0) = "{"
    c(1) = "}"

    'Allow multiple commands on one line:
    'MWin("TEST") # System.Pause()
    c(2) = "#"

    'Open the file
    Open file For Input Access Read As num

        'Dimension the .program() array...
        ReDim thePrg.program(0)

        Do Until EOF(num)

            'Read a line
            theLine = stripComments(fread(num))

            'Trim up that line...
            theLine = replaceOutsideQuotes(Trim(theLine), vbTab, "")

            If Right(theLine, 1) = "_" Then
                'This line is actually only part of a line, let's get the
                'whole line...

                buildLine = Trim(Mid(theLine, 1, Len(theLine) - 1))

                done = False
                Do Until done
                    If Not EOF(num) Then
                        buildTemp = replace(Trim(fread(num)), vbTab, "")
                        Select Case Right(buildTemp, 1)
                            Case "_"
                                buildTemp = _
                                    Mid(buildTemp, 1, Len(buildTemp) - 1)
                            Case Else: done = True
                        End Select
                        buildLine = buildLine & " " & buildTemp
                    Else
                        done = True
                    End If
                Loop

                theLine = buildLine

            End If

            'Remove prefixed #
            If (Left(theLine, 1) = "#") Then theLine = Right(theLine, Len(theLine) - 1)

            'Read line if not comment
            If (Not Left(theLine, 1) = "*") And Not (Left(theLine, 2) = "//") Then

                'Split that sucker like it has NEVER been split before!
                lines() = multiSplit(theLine, c, uD, True)

                'Now we're going to have some fun with the .program() array so
                'make sure it'll enlarge itself...
                On Error GoTo enlargeProgram

                'Add each line to the program...
                For a = 0 To (UBound(lines) + 1)

                    If (a = UBound(lines) + 1) Then
                        If Not uD(UBound(lines)) = "" Then
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
                                If Left(lines(a), 1) = " " Then
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

                'Update p
                p = UBound(thePrg.program) + 1

            End If

            'Update length of program
            thePrg.Length = p

        Loop '(until end of file)

    Close num

    'Now remove all #s because they are evil...
    For a = 0 To UBound(thePrg.program)
        thePrg.program(a) = replaceOutsideQuotes(thePrg.program(a), "#", "")
    Next a

    'Return the result
    openProgram = thePrg

    Exit Function

enlargeProgram:
    'Uh-oh! The array is too small. We can fix that...
    ReDim Preserve thePrg.program(UBound(thePrg.program) + 1)
    Resume

End Function

'=========================================================================
' Strip comments off a line
'=========================================================================
Public Function stripComments(ByVal text As String) As String
    Dim a As Long, char As String, ignore As Boolean
    For a = 1 To Len(text)
        char = Mid(text, a, 2)
        If (Left(char, 1) = Chr(34)) Then
            If (ignore) Then
                ignore = False
            Else
                ignore = True
            End If
        ElseIf (char = "//") And (Not ignore) Then
            stripComments = Mid(text, 1, a - 1)
            Exit Function
        End If
    Next a
    stripComments = text
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
