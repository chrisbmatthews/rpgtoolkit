Attribute VB_Name = "RPGCodeProcess"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'define stuff for rpgcode processes
Option Explicit

Type RPGCodeProgram
    program() As String 'the program text
    programPos As Long  'current position in program
    included(50) As String  'included files
    Length As Long  'length of program
    autoCommand As Boolean  'is autocommand tunred on? (if so, # is not required in statements)
    
    heapStack() As Long 'stack of local heaps
    currentHeapFrame As Long    'current heap frame
    
    boardNum As Long    'the corresponding board index of the program (default to 0)
    threadID As Long    'the thread id (-1 if not a thread)
    
    compilerStack() As String   'stack used by 'compiled' programs
    currentCompileStackIdx As Long  'current index of compilerStack
    
    ' ! ADDED BY KSNiloc...
    looping As Boolean
    autoLocal As Boolean
    
End Type

'Added by KSNiloc...
Public errorBranch As String

Sub AddHeapToStack(ByRef thePrg As RPGCodeProgram)
    'add a new local heap to the rpgcode stack
    On Error Resume Next
    
    thePrg.currentHeapFrame = thePrg.currentHeapFrame + 1
    If (thePrg.currentHeapFrame + 1 > UBound(thePrg.heapStack)) Then
        'resize heap stack
        ReDim Preserve thePrg.heapStack(thePrg.currentHeapFrame * 2)
    End If
    
    thePrg.heapStack(thePrg.currentHeapFrame) = RPGCCreateHeap()
End Sub

Sub PushCompileStack(ByRef thePrg As RPGCodeProgram, ByVal value As String)
    'add a new value to the compile stack
    On Error Resume Next
    
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx + 1
    If (thePrg.currentCompileStackIdx + 1 > UBound(thePrg.compilerStack)) Then
        'resize stack
        ReDim Preserve thePrg.compilerStack(thePrg.currentCompileStackIdx * 2)
    End If
    
    thePrg.compilerStack(thePrg.currentCompileStackIdx) = value
End Sub

Function PopCompileStack(ByRef thePrg As RPGCodeProgram) As String
    'add a new value to the compile stack
    On Error Resume Next
    
    If (thePrg.currentCompileStackIdx = -1) Then
        Exit Function
    End If
    
    PopCompileStack = thePrg.compilerStack(thePrg.currentCompileStackIdx)
    
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx - 1
End Function

Sub InitRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    'initialize a process
    On Error Resume Next
    
    Call ClearRPGCodeProcess(thePrg)
    
    'Enable AutoCommand()...
    thePrg.autoCommand = True
    
    'clear the current program data...
    ReDim thePrg.program(10)
    'ReDim thePrg.included(50)
    thePrg.programPos = 0
    thePrg.Length = 0
    thePrg.currentHeapFrame = -1
    errorBranch = ""
    preErrorPos = 0
        
    ReDim thePrg.heapStack(1)
    
    'create local heap...
    Call AddHeapToStack(thePrg)

    ReDim thePrg.compilerStack(1)
    thePrg.currentCompileStackIdx = -1
End Sub

Sub ClearRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    'cleanup a process
    On Error GoTo skipheap
    
    'clear the stack...
    Dim t As Long
    For t = 0 To UBound(thePrg.heapStack)
        Call RPGCDestroyHeap(thePrg.heapStack(t))
        thePrg.heapStack(t) = 0
    Next t
skipheap:
    thePrg.currentHeapFrame = -1
    thePrg.currentCompileStackIdx = -1
End Sub

Public Sub openProgram(ByVal file As String, ByRef thePrg As RPGCodeProgram)
    On Error GoTo errorhandler

    '======================================================================================
    'RPGCode 'Compiler'
    '======================================================================================
    'This sub-routine processes the file passed in and makes it readable. It places the
    'readable ('compiled') program in thePrg.

    'init the process...
    Call InitRPGCodeProcess(thePrg)

    Dim filen As String, p As Long, errorsA As Long, num As Long, theLine As String, sz As Long

    file = PakLocate(file)
    p = 0
    errorsA = 0
    num = FreeFile()

    If Trim(Right(file, 1)) = "\" Then Exit Sub
    If Not FileExists(file) Then Exit Sub
    filen = file

    Open filen For Input As num

        '=====================================================================
        'Bug fix by KSNiloc
        '=====================================================================

        'Dimension the .program() array...
        ReDim thePrg.program(0)

        '=====================================================================
        'End bug fix by KSNiloc
        '=====================================================================

        Do While Not EOF(num)
            Line Input #num, theLine

            '=================================================================
            'Bug fix and feature addition by KSNiloc
            '=================================================================
            
            'Let's parse up theLine before we just pump it into the array!

            'Declarations...
            Dim c(2) As String
            Dim lines() As String
            Dim ud() As String
            Dim a As Long

            'Trim up that line...
            theLine = replaceOutsideQuotes(Trim(theLine), vbTab, "")
           
            If Right(theLine, 1) = "_" Then
                'This line is actually only part of a line, let's get the
                'whole line...
                
                Dim buildLine As String
                Dim buildTemp As String
                buildLine = Trim(Mid(theLine, 1, Len(theLine) - 1))

                Dim done As Boolean
                Do Until done
                    If Not EOF(num) Then
                        Line Input #num, buildTemp
                        buildTemp = replace(Trim(buildTemp), vbTab, "")
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

            'Make sure we have something worth our while...
            If Left(theLine, 1) = "#" Then theLine = _
                Right(theLine, Len(theLine) - 1)
            If (Not Left(theLine, 1) = "*") And Not (Left(theLine, 2) = "//") Then

                'Fix the problem with commands on the same line as an if(),
                'method(), etc...
                c(0) = "{"
                c(1) = "}"

                'Allow multiple commands on one line:
                'MWin("TEST") # System.Pause()
                c(2) = "#"

                'Split that sucker like it has NEVER been split before!
                lines() = multiSplit(theLine, c, ud, True)

                'Now we're going to have some fun with the .program() array so
                'make sure it'll enlarge itself...
                On Error GoTo enlargeProgram

                'Add each line to the program...
                For a = 0 To (UBound(lines) + 1)
                        
                    If (a = UBound(lines) + 1) Then
                        If Not ud(UBound(lines)) = "" Then
                            thePrg.program(p + a) = ud(UBound(lines))
                        End If
                
                    ElseIf a = 0 Then
                        thePrg.program(p + a) = lines(a)
                
                    Else
                  
                        Select Case ud(a - 1)
                
                            Case "{", "}"
                                thePrg.program(p + a) = ud(a - 1)
                                thePrg.program(p + a + 1) = lines(a)
                                p = p + 1
                  
                            Case "#"
                                If Left(lines(a), 1) = " " Then
                                    thePrg.program(p + a) = ud(a - 1) & lines(a)
                                Else
                                    thePrg.program(p + a - 1) = _
                                        thePrg.program(p + a - 1) & ud(a - 1) & lines(a)
                                End If
                  
                            Case Else
                                thePrg.program(p + a) = lines(a)

                        End Select
                        
                    End If
                    
                Next a

                p = UBound(thePrg.program) + 1
                
            End If
                
            thePrg.Length = p
            
            'Set back to the old error handler...
            On Error GoTo erropenprg
            
            '=================================================================
            'End bug fix and feature addition by KSNiloc
            '=================================================================
            
        Loop
    Close num

    ' Now remove all #s because they are evil...
    For a = 0 To UBound(thePrg.program)
        thePrg.program(a) = replaceOutsideQuotes(thePrg.program(a), "#", "")
    Next a
    
erropenprg:
    errorsA = 1
    Resume Next

'=============================================================================
'Error handling added by KSNiloc
'=============================================================================

enlargeProgram:
    'Uh-oh! The array's too small. We can fix that...
    ReDim Preserve thePrg.program(UBound(thePrg.program) + 1)
    Resume

'=============================================================================
'End errror handling added by KSNiloc
'=============================================================================

    Exit Sub
'Begin error handling code:
errorhandler:
    'Call HandleError
    Resume Next
End Sub

Public Function AddNumberSignIfNeeded(ByVal txt As String, _
    ByRef prg As RPGCodeProgram) As String
    
 Dim build As String
 build = txt
 Select Case GetCommandName(txt, prg)
  'Make sure it's not something that isn't suppposed to have a
  'number sign...
  Case "LABEL"
  Case "MBOX"
  Case "*"
  Case "OPENCLOCK"
  Case "CLOSEBLOCK"
  Case Else
   'It's not...
   Dim a As Long
   build = "" 'We aren't passing the same text back to empty this
   For a = 1 To Len(txt) 'For each character...
    If a = " " Or a = vbTab Then    'Check for indentation in the code,
     build = build & Mid(txt, a, 1) 'we don't want to touch this.
    Else
     'This is where the indentation ends!
     If a = "#" Then
      'It already has a number sign.
      build = txt 'Pass back what was passed in.
      Exit For 'Exit the loop to save time.
     End If
     'Stick on the number sign... AND the rest of the text...
     build = build & "#" & Mid(txt, a, Len(txt) - a + 1)
     'Our job here is done; exit the loop...
     Exit For
    End If
   Next a 'Onto the next character
 End Select
 'Pass back the data...
 AddNumberSignIfNeeded = build
End Function


Function RemoveHeapFromStack(ByRef thePrg As RPGCodeProgram) As Boolean
    'remove a heap frame from the heap stack
    'returns false when no more left to remove
    On Error Resume Next
    
    If thePrg.currentHeapFrame >= 0 Then
        Call RPGCDestroyHeap(thePrg.heapStack(thePrg.currentHeapFrame))
        thePrg.currentHeapFrame = thePrg.currentHeapFrame - 1
        RemoveHeapFromStack = True
        Exit Function
    End If
    
    RemoveHeapFromStack = False
End Function

Public Sub traceProgram(ByRef prg As RPGCodeProgram, ByVal file As String, ByVal silent As Boolean)

    '=========================================================================
    'Save data in prg for analizing [KSNiloc]
    '=========================================================================

    Dim line As String
    Dim ff As Long
    Dim a As Long
    
    ff = FreeFile
    Open file For Output As ff
        For a = 0 To UBound(prg.program)
            line = prg.program(a)
            If a = prg.programPos Then line = line & "  ** Current Line"
            Print #ff, line
        Next a
        Print #ff, ""
        Print #ff, prg.programPos
    Close ff

    If Not silent Then MsgBox "Program traced successfully saved in " & file & "."
    
End Sub
