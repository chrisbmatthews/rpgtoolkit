Attribute VB_Name = "DebuggerCode"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'debugger stuff...
Option Explicit

Global debugging As Boolean     'currently debugging?
Global DBbreakpoints(50) As Integer   'breakpoints
Global DBcurBP As Integer             'current breakpoint array index.
Global DBCallDepth As Integer   'number of method calls currently on the stack
Global DBOldCallDepth As Long          'call depth before 'stepping over'
Global DBWinFilled As Boolean   'was the code filled in the window?
Global DBWinLength As Integer   'number of lines of code in db window
Global DBMethodStep As Boolean  'step into methods Y/N
Global DBWatchVars(100) As String        '101 vars we are watching
Sub DBAddWatch(watch$)
    'adds a variable to the watch...
    On Error GoTo errorhandler
    
    'find empty slot...
    Dim t As Long, abc As Long
    For t = 0 To 100
        If DBWatchVars$(t) = "" Then
            'found it!
            DBWatchVars$(t) = watch$
            Exit Sub
        End If
    Next t
    
    abc = MBox(LoadStringLoc(867, "Could not add any more varibales to the Watch"), LoadStringLoc(860, "Add Watch"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
    'MsgBox "Could not add any more variables to the Watch"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub DBFillCodeWindow()
    'fills the window with code
    On Error GoTo errorhandler
    Dim prognum As Long, t As Long
    If DBWinFilled = False Or program(prognum).Length <> DBWinLength Then
        dbwin.codewin.Clear
        For t = 0 To program(prognum).Length
            dbwin.codewin.AddItem (program(prognum).program$(t))
        Next t
        DBWinLength = program(prognum).Length
        DBWinFilled = True
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DBFillWatchWindow()
    'fills watch window with values...
    On Error GoTo errorhandler
    
    dbwin.watchlist.Clear
    Dim t As Long, l As String, n As Double, a As Long, valu As String
    For t = 0 To 100
        If DBWatchVars$(t) <> "" Then
            a = GetIndependentVariable(DBWatchVars$(t), l$, n)
            If a = 0 Then
                'numerical
                valu$ = str$(n)
            Else
                'literal
                valu$ = l$
            End If
            dbwin.watchlist.AddItem (DBWatchVars$(t) + "     " + valu$)
        Else
            dbwin.watchlist.AddItem ("")
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DBInsertLine(ByVal lnum As Long, ByVal prognum As Long)
    'inserts a blank line into the program prognum
    'at position linenum (counting from zero)
    'also does not update all method return addresses to accomodate the new position.
    'so return positions may be screwy!
    On Error GoTo errorhandler
    
    Dim abc As Long, t As Long
    If program(prognum).Length >= UBound(program(prognum).program) Then
        abc = MBox(LoadStringLoc(868, "Cannot add more lines to this program."), LoadStringLoc(869, "Program size limit reached"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Cannot add more lines to this program.", , "Program size limit reached"
    Else
        For t = program(prognum).Length To lnum Step -1
            program(prognum).program$(t + 1) = program(prognum).program$(t)
        Next t
        program(prognum).Length = program(prognum).Length + 1
        program(prognum).program$(lnum) = ""
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DBInsertPrgLine(ByVal Text As String, ByVal lnum As Long, ByVal prognum As Long)
    'inserts a line of code into the program.
    On Error GoTo errorhandler
    Call DBInsertLine(lnum, prognum)
    program(prognum).program$(lnum) = Text$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DBRemoveLine(ByVal lnum As Long, ByVal prognum As Long)
    'removes a line of code from the program at lnum
    On Error GoTo errorhandler
    Dim abc As Long, t As Long
    If program(prognum).Length <= 0 Then
        abc = MBox(LoadStringLoc(870, "Cannot delete more lines from this program."), LoadStringLoc(869, "Size limit reached"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Cannot delete more lines from this program.", , "Program size limit reached"
    Else
        For t = lnum To program(prognum).Length
            program(prognum).program$(t) = program(prognum).program$(t + 1)
        Next t
        program(prognum).Length = program(prognum).Length - 1
        'program$(lnum, prognum) = ""
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DBSaveProgram(ByVal file As String, ByVal pnum As Long)
    'save the current program pnum in file$
    On Error Resume Next
    Dim num As Long, t As Long
    num = FreeFile
    Open file$ For Output As #num
        For t = 0 To program(pnum).Length
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, program(pnum).program$(t)
        Next t
    Close #num
End Sub

Sub DebugBox(ByRef theProgram As RPGCodeProgram)
    'opens the debugger window.
    On Error GoTo errorhandler
    
    Dim theCommand As String
    Dim lineNum As Long
    theCommand = theProgram.program(theProgram.programPos)
    lineNum = theProgram.programPos
    
    Dim bDone As Boolean, a As String
    If debugging Then
        bDone = False
        dbwin.Show
        Call DBFillCodeWindow
        Call DBFillWatchWindow
        If DBMethodStep = True Then
            'step into
            If DBOldCallDepth >= DBCallDepth Then
                DBOldCallDepth = DBCallDepth
            End If
            dbwin.codewin.ListIndex = lineNum
            a$ = WaitForKey()
        End If
        If DBMethodStep = False Then
            'step over
            If DBOldCallDepth = DBCallDepth Then
                dbwin.codewin.ListIndex = lineNum
                a$ = WaitForKey()
            End If
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

