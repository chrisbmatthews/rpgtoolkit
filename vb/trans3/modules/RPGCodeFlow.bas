Attribute VB_Name = "RPGCodeFlow"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public program(11) As RPGCodeProgram
Public gbMultiTasking As Boolean    'the the current set of commands runing under mutlitasking?

' ADDED BY KSNiloc...
Public nextProgram As String

Public lineNum As Long             'line number of message window
Global mwinLines As Long            'number of lines in the message window

Global pointer$(100)        'list of 100 pointer variable names
Global corresppointer$(100) 'corresponding pointers

Public textx As Double, texty As Double     'current x and y coords of text

' ADDED BY KSNiloc...
Public endCausesStop As Boolean

Type activebutton
    x1 As Integer
    x2 As Integer
    y1 As Integer
    y2 As Integer
    face As String
End Type

Global buttons(50) As activebutton

Global runningProgram As Boolean    'is a program runing?

Global wentToNewBoard As Boolean    'did we go to a new board in the program?


'carry return values from rpgcode commands

Type RPGCODE_RETURN
    dataType As Long    'data type 0-num, 1-string
    num As Double       'data as numerical
    lit As String       'data as string
    
    ' ! ADDED BY KSNiloc...
    usingReturnData As Boolean

End Type

Public methodReturn As RPGCODE_RETURN   'return value from custom method calls

Public Const DT_VOID As Integer = -1
Public Const DT_NUM As Integer = 0
Public Const DT_LIT As Integer = 1
Public Const DT_COMMAND As Integer = 4

'KSNiloc adds...
Public Const DT_EQUATION As Integer = 5
Public errorKeep As RPGCodeProgram
Public preErrorPos As Long

Function isMultiTasking() As Boolean
    'check if we're multitasking...
    isMultiTasking = gbMultiTasking
End Function


Sub debugger(Text$)
    On Error GoTo errorhandler

    'KSNiloc adds..
    If Not errorBranch = "" Then
        errorKeep.program(0) = errorKeep.program(0) & "*ERROR CHECKING FLAG"
        If Not errorBranch = "Resume Next" Then
            Branch "#Branch(" & errorBranch & ")", errorKeep
        Else
            preErrorPos = errorKeep.programPos
            resumeNextRPG "#ResumeNext()", errorKeep
        End If
        Exit Sub
    End If

    If debugYN = 1 Then
        debugwin.Show
        debugwin.buglist.Text = debugwin.buglist.Text + Text$ + chr$(13) + chr$(10)
        DoEvents
    Else
        Unload debugwin
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function increment(ByRef theprogram As RPGCodeProgram) As Long
    'Increments the program
    On Error GoTo errorhandler
    theprogram.programPos = theprogram.programPos + 1
    If theprogram.programPos > theprogram.Length Then
        theprogram.programPos = -1
    End If
    increment = theprogram.programPos

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub MethodCallRPG(Text$, commandName$, ByRef theprogram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    'A method was called.
    '#ret!$ = #method()

    ''''''''''''''''''''''''''''''''''
    'Modified in a big way by KSNiloc'
    ''''''''''''''''''''''''''''''''''
    
    'What's the name of the method?
    On Error GoTo errorhandler
    ReDim parameterlist$(100)
    ReDim destlist$(100)

    Dim mName As String, includeFile As String, methodName As String, oldPos As Long, foundIt As Long
    Dim t As Long, test As String, itis As String, canDoIt As Boolean
    
    If commandName$ = "" Then
        mName$ = GetCommandName$(Text$, theprogram)   'get command name without extra info
    Else
        mName$ = commandName$
    End If

    includeFile$ = ParseBefore(mName$, ".")
    methodName$ = ParseAfter(mName$, ".")
    
    If Not InClass.DoNotCheckForClass Then
     If Not methodName$ = "" Then
      If IsClassRPG(includeFile$, methodName$, Text$, theprogram, retval) Then
       Exit Sub
      End If
     End If
    End If
    
    InClass.DoNotCheckForClass = False
    
    If methodName$ <> "" Then
        'include file...
        includeFile$ = addext(includeFile$, ".prg")
        Call IncludeRPG("#include(" + chr$(34) + includeFile$ + chr$(34) + ")", theprogram)
        mName$ = methodName$
    End If

    oldPos = theprogram.programPos
    'Now to find that method name
    foundIt = -1
    For t = 0 To theprogram.Length
        test$ = GetCommandName$(theprogram.program$(t), theprogram)  'get command name without extra info
        If UCase$(test$) = "METHOD" Then
            itis$ = GetMethodName(theprogram.program$(t), theprogram)
            If UCase$(itis$) = UCase$(mName$) Then
                foundIt = t
                'Exit For
            End If
        End If
    Next t
    InClass.MethodWasFound = True
    If foundIt = -1 Then
        'didn't find it in prg code, but it may exist in a plugin...
        canDoIt = QueryPlugins(mName$, Text$, retval)
        If canDoIt = False Then
            'InClass.MethodWasFound = False
            If InClass.PopupMethodNotFound = True Then
                Call debugger("Error: Method not found!-- " + Text$)
            End If
        Else
            Exit Sub
        End If
    Else
        'Alright! we found this method!
        'increment calldepth(total number of calls)
        DBCallDepth = DBCallDepth + 1
        
        'Now pass variables.
        theprogram.programPos = foundIt
        
        Dim dataUse As String, number As Long, pList As Long, number2 As Long
        
        'Get parameters from calling line
        dataUse$ = GetBrackets(Text$)    'Get text inside brackets (parameter list)
        number = CountData(dataUse$)        'how many data elements are there?
        For pList = 1 To number
            parameterlist$(pList) = GetElement(dataUse$, pList)
        Next pList
    
        'Get parameters from method line
        dataUse$ = GetBrackets(theprogram.program$(foundIt))   'Get text inside brackets (parameter list)
        number2 = CountData(dataUse$)        'how many data elements are there?
        'If number <> number2 Then
        '    Call debugger("Error: Cannot call method- parameters don't match!--" + Text$)
        '    theProgram.programPos = oldPos
        '    Exit Sub
        'End If
        For pList = 1 To number2
            destlist$(pList) = GetElement(dataUse$, pList)
        Next pList

        'create a new local scope for this method...
        Call AddHeapToStack(theprogram)

        Dim lit As String, num As Double
        Dim dataG As Long, dUse As String
        'Now to correspond the two lists
        For pList = 1 To number
            'get the value from the previous stack...
            theprogram.currentHeapFrame = theprogram.currentHeapFrame - 1
            dataG = GetValue(parameterlist$(pList), lit$, num, theprogram)
            'restore stack...
            theprogram.currentHeapFrame = theprogram.currentHeapFrame + 1
            
            If dataG = 0 Then
                dUse$ = str$(num)
            Else
                dUse$ = lit$
            End If
            'make sure the variable becomes local to the method...
            Dim dummyRet As RPGCODE_RETURN
            Call LocalRPG("#local(" + destlist$(pList) + ")", theprogram, dummyRet)
            Call SetVariable(destlist$(pList), dUse$, theprogram)
        Next pList
        
        Dim theOne As Long, se As Long
        'find the spot where the pointer list is first empty...
        theOne = 1
        For se = 1 To 100
            If pointer$(se) = "" Then
                theOne = se
                Exit For
            End If
        Next se
        
        Dim topList As Long
        'Put the variables in global pointer list
        topList = theOne
        For t = 1 To number
            For se = theOne To 100
                If pointer$(se) = "" Then
                    pointer$(se) = removeChar(destlist$(t), " ")
                    corresppointer$(se) = removeChar(parameterlist$(t), " ")
                    topList = se
                    Exit For
                End If
            Next se
        Next t

        
        'set up method return value...
        methodReturn = retval
        
        Dim aa As Long
        'OK- data is passed.  Now run the method:
        theprogram.programPos = increment(theprogram)
        
        ' ! MODIFIED BY KSNiloc
        Dim ogbm As Boolean
        ogbm = isMultiTasking()
        gbMultiTasking = False
        aa = runBlock(theprogram.program$(foundIt), 1, theprogram)
        gbMultiTasking = ogbm

        theprogram.programPos = oldPos
    
        'set up return value...
        retval = methodReturn
    
        'Clear our variables from pointer list
        For t = 1 To number
            For se = theOne To topList
                If UCase$(pointer$(se)) = UCase$(destlist$(t)) Then
                    pointer$(se) = ""
                    corresppointer$(se) = ""
                    se = 100
                End If
            Next se
        Next t
        
        'kill the local scope...
        Call RemoveHeapFromStack(theprogram)
        
        'decrement call depth
        DBCallDepth = DBCallDepth - 1

    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub MultiTaskNow()
    'Multitasks item programs.
    On Error GoTo errorhandler
    'On Error Resume Next
    Call openMulti  'Open up multi if not already done
    
    gbMultiTasking = True
    
    Call ExecuteAllThreads
    
    Dim t As Long
    ' ! MODIFIED BY KSNiloc...
    For t = 0 To UBound(multilist)
        If multilist$(t) <> "" Then
            'OK, run this multitask program.
            target = t
            targetType = 1
            source = t
            sourceType = 1
            If Not (ExecuteThread(program(t + 1))) Then
                multilist$(t) = ""
            End If
        End If
    Next t
    gbMultiTasking = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub openMulti()
    'Open multitask programs if they're not already open.
    On Error Resume Next
    Dim t As Long
    ' ! MODIFIED BY KSNiloc...
    For t = 0 To UBound(multilist)
        If multilist$(t) <> "" Then
            If multiopen(t) = 0 Then
            'MsgBox multilist$(t)
                Call openProgram(projectPath$ + prgPath$ + multilist$(t), program(t + 1))
                multiopen(t) = 1
            End If
        End If
    Next t
End Sub

Public Function programTest(ByRef passPos As PLAYER_POSITION) As Boolean

    '========================================
    'Modified by KSNiloc
    '
    'NOTES: Now works with pixel movement
    '========================================

    'This sub tests if the player has stepped/pressed activation key on a program.
    'If so, the program will run (only if the program's conditions
    'tell it to run).
    'return true if the program was run
    
    'On Error GoTo errorhandler
    On Error Resume Next

    Dim xx As Double
    Dim yy As Double
    Dim runIt As Long
    Dim t As Long
    
    Dim toRet As Boolean
    toRet = False

    Dim pos As PLAYER_POSITION
    pos = passPos
    If usingPixelMovement() Then pos = roundCoords(pos)

    'First, test for programs:
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(t) <> "" Then
            runIt = 1
            'OK, how is it activated?
            If boardList(activeBoardIndex).theData.activationType(t) = 0 Then
                'we step on it.
                If val(boardList(activeBoardIndex).theData.progX(t)) = pos.x And _
                    val(boardList(activeBoardIndex).theData.progY(t)) = pos.y And _
                    val(boardList(activeBoardIndex).theData.progLayer(t)) = pos.l Then
                    'all right! we stepped on it!
                    toRet = runprgYN(t)
                End If
            End If
            If boardList(activeBoardIndex).theData.activationType(t) = 1 Then
                'ah! we press the actiavtion key!
                xx = pos.x: yy = pos.y
                Select Case UCase$(pos.stance)
                    Case "WALK_S":
                        yy = pos.y + 1
                    Case "WALK_W":
                        xx = pos.x - 1
                    Case "WALK_N":
                        yy = pos.y - 1
                    Case "WALK_E":
                        xx = pos.x + 1
                End Select
                If (boardList(activeBoardIndex).theData.progX(t) = xx And boardList(activeBoardIndex).theData.progY(t) = yy And boardList(activeBoardIndex).theData.progLayer(t) = pos.l) _
                   Or (boardList(activeBoardIndex).theData.progX(t) = pos.x And boardList(activeBoardIndex).theData.progY(t) = pos.y) Then
                    If keyWaitState = mainMem.Key Then
                        'yes, we pressed the right key
                        toRet = runprgYN(t)
                    End If
                End If
            End If
        End If
    Next t

    Dim tempItems() As PLAYER_POSITION
    ReDim tempItems(MAXITEM)
    For t = 0 To MAXITEM
        tempItems(t) = itmPos(t)
        itmPos(t) = roundCoords(itmPos(t))
    Next t
    
    'Ouch.  Now test for items:
    For t = 0 To MAXITEM
        If itemMem(t).BoardYN = 1 Then  'yeah, it's a board item
            If boardList(activeBoardIndex).theData.itmName$(t) <> "" Then
                runIt = 1
                'OK, how is it activated?
                If boardList(activeBoardIndex).theData.itmActivationType(t) = 0 Then
                    'we step on it.
                    If itmPos(t).x = pos.x _
                        And itmPos(t).y = pos.y And _
                        itmPos(t).l = pos.l Then
                        'all right! we stepped on it!
                        toRet = runItmYN(t)
                    End If
                End If
                If boardList(activeBoardIndex).theData.itmActivationType(t) = 1 Then
                    'ah! we press the actiavtion key!
                    xx = pos.x: yy = pos.y
                    Select Case UCase$(pos.stance)
                        Case "WALK_S":
                            yy = pos.y + 1
                        Case "WALK_W":
                            xx = pos.x - 1
                        Case "WALK_N":
                            yy = pos.y - 1
                        Case "WALK_E":
                            xx = pos.x + 1
                    End Select
                    If itmPos(t).x = xx And itmPos(t).y = yy And itmPos(t).l = pos.l Then
                        If keyWaitState = mainMem.Key Then
                            'yes, we pressed the right key
                            toRet = runItmYN(t)
                        End If
                    End If
                End If
            End If
        End If
    Next t

    For t = 0 To MAXITEM
        itmPos(t) = tempItems(t)
    Next t

    programTest = toRet

    Exit Function
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Private Sub changePerOccurence(ByVal txt As String, _
 ByVal chr As String, ByRef toChange As Long, ByVal Change As Long)

 Dim a As Long
 For a = 1 To Len(txt)
  If LCase(Mid(txt, a, 1)) = LCase(chr) Then _
   toChange = toChange + Change
 Next a

End Sub

Public Sub moveToStartOfBlock(ByRef prg As RPGCodeProgram)

    ' ! ADDED BY KSNiloc...

    Dim done As Boolean

    Do Until done
        Select Case LCase(GetCommandName(prg.program(prg.programPos), prg))
            
            Case "openblock"
                done = True
                Exit Do
            
        End Select
        DoEvents
        prg.programPos = increment(prg)
    Loop
    
End Sub

Public Function runBlock( _
                            ByVal Text As String, _
                            ByVal res As Long, _
                            ByRef prg As RPGCodeProgram _
                                                          ) As Long

    '=========================================================================
    'Bug fix by KSNiloc
    '=========================================================================
    'Runs a block of code (or skips it if res = 0)
    '=========================================================================
    
    'NOTE:  The text passed in no longer matters.

    Dim retval As RPGCODE_RETURN
    Dim done As Boolean
    Dim depth As Long
    
    moveToStartOfBlock prg
    
    Do Until done
               
        Select Case LCase(GetCommandName(prg.program(prg.programPos), prg))

            Case "openblock"
                depth = depth + 1
                prg.programPos = increment(prg)
                
            Case "closeblock"
                depth = depth - 1
                prg.programPos = increment(prg)
                
            Case "end"
                If Not endCausesStop Then
                    res = 0
                    prg.programPos = increment(prg)
                Else
                    DoSingleCommand "Stop()", prg, retval
                End If
                
            Case Else
           
                If res = 1 Then
                    DoCommand prg, retval
                Else
                    prg.programPos = increment(prg)
                End If
            
        End Select
        
        If depth = 0 _
                       Or prg.programPos = -1 _
                       Or prg.programPos = -2 _
                       Or (Not runningProgram) _
                                                 Then done = True
       
       'Prevent lockup...
       DoEvents
       
    Loop

    runBlock = prg.programPos
    
End Function


Function runItmYN(ByVal itmnum As Long) As Boolean
    'Tests if conditions are right to run an item.
    'If so, it will be run.
    'return true if it was run
    On Error GoTo errorhandler
    
    Dim toRet As Boolean
    toRet = False
    
    Dim t As Long, runIt As Long, checkIt As Long, lit As String, num As Double, valueTest As Double
    Dim valueTes As String
    
    t = itmnum
    If boardList(activeBoardIndex).theData.itmActivate(t) = 0 Then
        'always active
        runIt = 1
    End If
    If boardList(activeBoardIndex).theData.itmActivate(t) = 1 Then
        'conditional activation
        runIt = 0
        checkIt = GetIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate$(t), lit$, num)
        If checkIt = 0 Then
            'it's a numerical variable
            valueTest = num
            If valueTest = val(boardList(activeBoardIndex).theData.itmActivateInitNum$(t)) Then runIt = 1
        End If
        If checkIt = 1 Then
            'it's a literal variable
            valueTes$ = lit$
            If valueTes$ = boardList(activeBoardIndex).theData.itmActivateInitNum$(t) Then runIt = 1
        End If
    End If
    If runIt = 1 Then
        If boardList(activeBoardIndex).theData.itemProgram$(t) <> "" And UCase$(boardList(activeBoardIndex).theData.itemProgram$(t)) <> "NONE" Then
            Call runProgram(projectPath$ + prgPath$ + boardList(activeBoardIndex).theData.itemProgram$(t))
            toRet = True
        Else
            Call runProgram(projectPath$ + prgPath$ + itemMem(t).itmPrgPickUp)
            toRet = True
        End If
        'Now see if we have to set the conditional variable to something
        If boardList(activeBoardIndex).theData.itmActivate(t) = 1 Then
            'it was a conditional activation-- reset the condition.
            Call setIndependentVariable(boardList(activeBoardIndex).theData.itmDoneVarActivate$(t), boardList(activeBoardIndex).theData.itmActivateDoneNum$(t))
            
            'now check if it's still active...
            runIt = 0
            checkIt = GetIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate$(t), lit$, num)
            If checkIt = 0 Then
                'it's a numerical variable
                valueTest = num
                If valueTest = val(boardList(activeBoardIndex).theData.itmActivateInitNum$(t)) Then runIt = 1
            End If
            If checkIt = 1 Then
                'it's a literal variable
                valueTes$ = lit$
                If valueTes$ = boardList(activeBoardIndex).theData.itmActivateInitNum$(t) Then runIt = 1
            End If
            
            If runIt = 0 Then
                'it is no longer active-- remove it
                itemMem(itmnum).bIsActive = False
                multilist$(itmnum) = ""
            End If
        End If
    End If

    runItmYN = toRet

    Exit Function
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function runprgYN(ByVal prgnum As Long) As Boolean
    'Tests if conditions are right to run a program (program prgNum)
    'If so, it will be run.
    'return true if it was run
    On Error GoTo errorhandler
    
    Dim toRet As Boolean
    toRet = False
    
    Dim t As Long
    Dim runIt As Long
    Dim checkIt As Long
    Dim lit As String
    Dim num As Double
    Dim valueTest As Double
    Dim valueTes As String
    
    t = prgnum
    If boardList(activeBoardIndex).theData.progActivate(t) = 0 Then
        'always active
        runIt = 1
    End If
    If boardList(activeBoardIndex).theData.progActivate(t) = 1 Then
        'conditional activation
        runIt = 0
        checkIt = GetIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(t), lit$, num)
        If checkIt = 0 Then
            'it's a numerical variable
            valueTest = num
            If valueTest = val(boardList(activeBoardIndex).theData.activateInitNum$(t)) Then runIt = 1
        End If
        If checkIt = 1 Then
            'it's a literal variable
            valueTes$ = lit$
            If valueTes$ = boardList(activeBoardIndex).theData.activateInitNum$(t) Then runIt = 1
        End If
    End If
    If runIt = 1 Then
        Call runProgram(projectPath$ + prgPath$ + boardList(activeBoardIndex).theData.programName$(t), t)
        toRet = True
        'Now see if we have to set the conditional variable to something
        If wentToNewBoard Then
            wentToNewBoard = False
        Else
            If boardList(activeBoardIndex).theData.progActivate(t) = 1 Then
                'we must change the actiabtion variable
                'to show that the program should no longer
                'be used.
                Call setIndependentVariable(boardList(activeBoardIndex).theData.progDoneVarActivate$(t), boardList(activeBoardIndex).theData.activateDoneNum$(t))
            
                'now check if the program is still active...
                runIt = 0
                checkIt = GetIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(t), lit$, num)
                If checkIt = 0 Then
                    'it's a numerical variable
                    valueTest = num
                    If valueTest = val(boardList(activeBoardIndex).theData.activateInitNum$(t)) Then runIt = 1
                End If
                If checkIt = 1 Then
                    'it's a literal variable
                    valueTes$ = lit$
                    If valueTes$ = boardList(activeBoardIndex).theData.activateInitNum$(t) Then runIt = 1
                End If
                
                If runIt = 0 Then
                    'the program is no longer active-- it should be erased
                    'from the screen.
                    Call redrawAllLayersAt(boardList(activeBoardIndex).theData.progX(t), boardList(activeBoardIndex).theData.progY(t))
                End If
            End If
        End If
    End If
    
    runprgYN = toRet

    Exit Function
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub runProgram(ByVal file As String, Optional ByVal boardNum As Long = -1, Optional ByVal setSourceAndTarget As Boolean = True)
       
    On Error GoTo runprgerr
    'Run a program from the BOARD
    'file is filename
    'number is multitask number (?)
    'boardnum is the index on the board of the program
    
    If Trim(Right(file, 1)) = "\" Then Exit Sub
    
    runningProgram = True
    'set call depth to zero
    DBCallDepth = 0
    DBWinFilled = False
    DBWinLength = 0
    
    'hide mwin
    Call hideMsgBox
    Call setconstants   'set variable constants
    Call clearButtons
    
    If setSourceAndTarget Then
        target = selectedPlayer
        targetType = 0
        source = selectedPlayer
        sourceType = 0
    End If
    
    Dim theprogram As RPGCodeProgram
    'MsgBox "here :: runProgram :: " & file
    Call openProgram(file, theprogram)
    'MsgBox "here out :: runProgram :: " & file
    lineNum = 1
    theprogram.threadID = -1
        
    Call FlushKB
    Dim retval As RPGCODE_RETURN
       
    'copy the screen to the rpgcode canvas for drawing onto...
    Call CanvasGetScreen(cnvRPGCodeScreen)
       
    Dim prgPos As Long, errorsA As Long
       
    theprogram.programPos = 0
    theprogram.boardNum = boardNum

    ' ! MODIFIED BY KSNiloc
    Dim mainRetVal As RPGCODE_RETURN
    mainRetVal.usingReturnData = True
    DoSingleCommand "#Main()", theprogram, mainRetVal
    If Not mainRetVal.num = 1 Then
        theprogram.programPos = 0
        Do While _
                   (theprogram.programPos >= 0) _
                   And (theprogram.programPos <= theprogram.Length) _
                   And (runningProgram)

            prgPos = theprogram.programPos
            theprogram.programPos = DoCommand(theprogram, retval)

            If errorsA = 1 Then
                errorsA = 0
                theprogram.programPos = -1
            End If

        Loop
    Else
        theprogram.programPos = -1
    End If

    Call hideMsgBox
    
    If theprogram.programPos = -1 Then
        'program ended with #end
        'restore previous view...
        Call renderNow
    Else
        'program ended with #done
        'leave junk on the screen...
    End If
    
    Dim t As Long
    For t = 0 To 50
        theprogram.included$(t) = ""
    Next t
    Call hideMsgBox
    runningProgram = False
    bWaitingForInput = False

    Call FlushKB

    'clear the program
    Call ClearRPGCodeProcess(theprogram)
    
    If nextProgram <> "" Then
        Dim oldNextProgram As String
        oldNextProgram = nextProgram
        nextProgram = ""
        runProgram oldNextProgram, theprogram.boardNum
    End If

    Exit Sub
runprgerr:
errorsA = 1
Resume Next
End Sub

'program flow routines for rpgcode.
Function DoCommand(ByRef theprogram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN) As Long
    'do a command as specified by the program passed in...
    On Error GoTo error
    
    DoCommand = DoSingleCommand(theprogram.program(theprogram.programPos), theprogram, retval)
    
    Exit Function
error:
    theprogram.programPos = -1
    DoCommand = -1
End Function

Function DoIndependentCommand(ByVal rpgcodeCommand As String, ByRef retval As RPGCODE_RETURN) As Long
    'do a single command, unattached to a program
    On Error Resume Next
    
    ' ! MODIFIED BY KSNiloc...
    
    rpgcodeCommand = ParseRPGCodeCommand(rpgcodeCommand, errorKeep)
    
    Dim oPP As Long
    oPP = errorKeep.programPos
    DoSingleCommand rpgcodeCommand, errorKeep, retval
    errorKeep.programPos = oPP
   
End Function

Function DoSingleCommand(ByVal rpgcodeCommand As String, ByRef theprogram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN) As Long
    'Performs a command, and returns the new line number
    'afterwards.  If it returns -1, then the program is done.
    On Error GoTo errorhandler
   
    'Error checking... [KSNiloc]
    Dim checkIt As String
    checkIt = replace(replace(replace _
        (LCase(rpgcodeCommand), " ", "" _
        ), vbTab, ""), "#", "")

    If checkIt = "onerrorresumenext" Then ' On Error Resume Next
        onError "#OnError(Resume Next)", theprogram
        DoSingleCommand = increment(theprogram)
        Exit Function

    ElseIf checkIt = "resumenext" Then ' Resume Next
        resumeNextRPG "#ResumeNext()", theprogram
        DoSingleCommand = increment(theprogram)
        Exit Function

    ElseIf Left(checkIt, 11) = "onerrorgoto" Then ' On Error Goto :label
        onError "#OnError(" & Right(checkIt, Len(checkIt) - InStr(1, _
            LCase(rpgcodeCommand), "goto", vbTextCompare) - 1) & ")", theprogram
        DoSingleCommand = increment(theprogram)
        Exit Function

    End If
    
    If theprogram.program(0) & _
        "*ERROR CHECKING FLAG" = errorKeep.program(0) Then
        preErrorPos = theprogram.programPos
        theprogram.programPos = errorKeep.programPos
    End If
    errorKeep = theprogram

    'Threading... [KSNiloc]
    If isMultiTasking() And theprogram.looping Then Exit Function

    'Parse this line like it has never been parsed before... [KSNiloc]
    rpgcodeCommand = ParseRPGCodeCommand(rpgcodeCommand, theprogram)
       
    Dim cLine As String 'current line
    cLine = rpgcodeCommand
    
    retval.dataType = DT_VOID
    
    'call tracestring("Execute: " + cline$)
    
    If debugYN = 1 Then
        Call DebugBox(theprogram)
    End If
    
    Dim splice As String, cType As String, testText As String
    
    splice$ = cLine$
    cType$ = GetCommandName$(splice$, theprogram)   'get command name without extra info
    testText$ = UCase$(cType$)
    
    'check for redirects...
    'If RedirectExists(testText$) Then
        Dim oTT As String
        oTT = testText
        testText$ = GetRedirect(testText$)
        If testText = "" Then testText = oTT
    'End If

    '''''''''''''''''''''''''''
    '   Modified by KSNiloc   '
    '''''''''''''''''''''''''''
    '[6/18/04]
    
    If Left(testText, 1) = "." Then testText = _
     UCase(GetWithPrefix() & testText)
    
    '''''''''''''''''''''''''''
    '    Modification Over    '
    '''''''''''''''''''''''''''

    If testText$ <> "MWIN" Then
        'if the command is not a MWin command, then
        'check if we have just finished puttin text
        'int the message window
        'if so, show the message window :)
        If bFillingMsgBox Then
            bFillingMsgBox = False
            Call renderRPGCodeScreen
        End If
    End If
    
    Select Case testText$
        Case "VAR":
            Call VariableManip(splice$, theprogram)  'manipulate var
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "MWIN":
            Call MWinRPG(splice$, theprogram)  'put text in mwin.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WAIT":
            Call WaitRPG(splice$, theprogram, retval) 'wait
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "MWINCLS":
            Call MWinClsRPG(splice$, theprogram)  'clear mwin.
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        ' !MODIFIED BY KSNILOC!
        Case "IF", "ELSE", "ELSEIF"
            DoSingleCommand = IfThen(splice$, theprogram) 'if then
            Exit Function
    
        Case "WHILE", "UNTIL" ' [KSNiloc]
            DoSingleCommand = WhileRPG(splice$, theprogram) 'while
            Exit Function
    
        Case "FOR":
            DoSingleCommand = ForRPG(splice$, theprogram) 'for
            Exit Function
    
        Case "SEND":
            Call Send(splice$, theprogram) 'send
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '! MODIFICATION BY KSNiloc
        Case "TEXT", "PIXELTEXT"
            Call TextRPG(splice$, theprogram) 'text
            DoSingleCommand = increment(theprogram)
            Exit Function
               
        Case "LABEL":
            'Just a label- ignore it!
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "*", "OPENBLOCK", "CLOSEBLOCK":
            'Just a comment- ignore it!
            DoSingleCommand = increment(theprogram)
            Exit Function
               
        Case "":
            'Just a blank line- ignore it!
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MBOX":
            Call AddToMsgBox(splice$, theprogram)  'Message box
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "@":
            Call AddToMsgBox("", theprogram)  'Message box
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "BRANCH":
            Call Branch(splice$, theprogram) 'Branch command
            DoSingleCommand = theprogram.programPos
            Exit Function
    
        'undocumented
        Case "COM_POP_PILER":
            Call CompilerPopRPG(splice$, theprogram, retval) 'compiler pop var
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'undocumented
        Case "COM_PUSH_PILER":
            Call CompilerPushRPG(splice$, theprogram, retval) 'compiler push var
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'undocumented
        Case "COM_ENTERLOCAL_PILER":
            Call CompilerEnterLocalRPG(splice$, theprogram, retval) 'compiler enter local
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'undocumented
        Case "COM_EXITLOCAL_PILER":
            Call CompilerExitLocalRPG(splice$, theprogram, retval) 'compiler exit local
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CHANGE":
            Call Change(splice$, theprogram) 'Change command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CLEAR":
            Call ClearRPG(splice$, theprogram) 'Clear command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DONE" ' [KSNiloc]
            runningProgram = False
            'Call done(splice$, theProgram) 'Done command
            'DoSingleCommand = -2
            Exit Function
    
        Case "DOS", "WINDOWS":
            Call Dos(splice$, theprogram) 'Dos command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "EMPTY":
            Call EmptyRPG(splice$, theprogram) 'Empty command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "END":
            Call EndRPG(splice$, theprogram) 'End Command
            DoSingleCommand = -1
            Exit Function
    
        Case "FONT":
            Call FontRPG(splice$, theprogram) 'Font command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FONTSIZE":
            Call FontSizeRPG(splice$, theprogram) 'Fontsize command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: speed up 4
        Case "FADE":
            Call Fade(splice$, theprogram) 'Fade command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FBRANCH":
            DoSingleCommand = Fbranch(splice$, theprogram) 'Fbranch multicommand
            Exit Function
    
        Case "FIGHT":
            Call FightRPG(splice$, theprogram) 'Fight command
            DoSingleCommand = -2
            Exit Function
    
        Case "GET":
            Call GetRPG(splice$, theprogram, retval) 'Get command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GONE":
            Call Gone(splice$, theprogram) 'gone
            DoSingleCommand = -1
            Exit Function
        
        Case "VIEWBRD":
            Call ViewBrd(splice$, theprogram) 'viewbrd
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "BOLD":
            Call BoldRPG(splice$, theprogram) 'Bold On/off command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ITALICS":
            Call ItalicsRPG(splice$, theprogram) 'Italics On/off command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "UNDERLINE":
            Call UnderlineRPG(splice$, theprogram) 'Underline On/off command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WINGRAPHIC":
            Call WinGraphic(splice$, theprogram)  'Message box graphic
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WINCOLOR":
            Call WinColorRPG(splice$, theprogram)  'Message box color (dos)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WINCOLORRGB":
            Call WinColorRGB(splice$, theprogram)  'Message box color (rgb)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "COLOR":
            Call ColorRPG(splice$, theprogram)  'Font color (dos)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "COLORRGB":
            Call ColorRGB(splice$, theprogram)  'Font color (rgb)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MOVE":
            Call MoveRPG(splice$, theprogram) 'move
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "NEWPLYR":
            Call NewPlyr(splice$, theprogram) 'NewPlyr
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "OVER":
            Call Over(theprogram)   'Game Over
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "PRG":
            Call prg(splice$, theprogram)  'Prg
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: prompt
        Case "PROMPT":
            Call Prompt(splice$, theprogram, retval)  'Prompt
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PUT":
            Call PutRPG(splice$, theprogram)  'Put
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "RESET":
            Call ResetRPG(theprogram)  'reset
            DoSingleCommand = -1
            Exit Function
            
        Case "RETURN":
            Call ReturnRPG(theprogram)  'refresh screen
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "RUN":
            Call RunRPG(splice$, theprogram)  'run prg
            DoSingleCommand = -1 ' [ KSNiloc ]
            runningProgram = False
            Exit Function
    
        Case "SHOW":
            Call ShowRPG(splice$, theprogram)  'show var
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SOUND":
            Call SoundRPG(splice$, theprogram)  'sound
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WIN":
            Call WinRPG(splice$, theprogram)  'win game
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "HP":
            Call HPRPG(splice$, theprogram)  'set player HP
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GIVEHP":
            Call GiveHPRPG(splice$, theprogram)  'add player HP
            DoSingleCommand = increment(theprogram)
            Exit Function
      
        Case "GETHP":
            Call GetHPRPG(splice$, theprogram, retval)  'get player HP
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MAXHP":
            Call MaxHPRPG(splice$, theprogram)  'set player max HP
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETMAXHP":
            Call GetMaxHPRPG(splice$, theprogram, retval) 'get player max HP
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SMP":
            Call SmpRPG(splice$, theprogram)  'set player Sp'l Move power
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GIVESMP":
            Call GiveSmpRPG(splice$, theprogram)  'give SMP
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETSMP":
            Call GetSmpRPG(splice$, theprogram, retval) 'get player smp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MAXSMP":
            Call MaxSmpRPG(splice$, theprogram)  'set player Max smp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETMAXSMP":
            Call GetMaxSmpRPG(splice$, theprogram, retval) 'get player Max smp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "START":
            Call StartRPG(splice$, theprogram)  'Windows START file
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GIVEITEM":
            Call GiveItemRPG(splice$, theprogram)  'Give player an item
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TAKEITEM":
            Call TakeItemRPG(splice$, theprogram)  'Take item
            DoSingleCommand = increment(theprogram)
            Exit Function
       
        Case "WAV":
            Call WavRPG(splice$, theprogram)  'Play wav
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "DELAY":
            Call DelayRPG(splice$, theprogram)  'delay
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "RANDOM":
            Call RandomRPG(splice$, theprogram, retval) 'random
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PUSH":
            Call PushRPG(splice$, theprogram)  'random
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TILETYPE":
            Call TileTypeRPG(splice$, theprogram)  'tiletype
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MIDIPLAY":
            Call MidiPlayRPG(splice$, theprogram)  'midiplay
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PLAYMIDI":
            Call MidiPlayRPG(splice$, theprogram)  'midiplay
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MEDIAPLAY":
            Call MidiPlayRPG(splice$, theprogram)  'midiplay
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MEDIASTOP", "MEDIAREST":
            Call MidiRestRPG(splice$, theprogram)  'midirest
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MIDIREST":
            Call MidiRestRPG(splice$, theprogram)  'midirest
            DoSingleCommand = increment(theprogram)
            Exit Function
                      
        Case "GODOS":
            Call GoDosRPG(splice$, theprogram)  'goDos
            DoSingleCommand = increment(theprogram)
            Exit Function
                      
        Case "ADDPLAYER":
            Call AddPlayerRPG(splice$, theprogram)  'add player
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "REMOVEPLAYER":
            Call RemovePlayerRPG(splice$, theprogram)  'remove player
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "METHOD":
            DoSingleCommand = SkipMethodRPG(splice$, theprogram) 'skip this method.
            Exit Function
    
        Case "RETURNMETHOD":
            Call ReturnMethodRPG(splice$, theprogram)  'return value from method
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SETPIXEL":
            Call SetPixelRPG(splice$, theprogram)  'set pixel
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DRAWLINE":
            Call DrawLineRPG(splice$, theprogram)  'draw line
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DRAWRECT"
            Call DrawRectRPG(splice$, theprogram)  'draw rect
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FILLRECT":
            Call FillRectRPG(splice$, theprogram)  'fill rect
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DEBUG":
            Call DebugRPG(splice$, theprogram)  'debug on/off
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CASTNUM":
            Call CastNumRPG(splice$, theprogram, retval) 'cast num
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CASTLIT":
            Call CastLitRPG(splice$, theprogram, retval) 'cast lit
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CASTINT":
            Call CastIntRPG(splice$, theprogram, retval) 'cast int
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PUSHITEM":
            Call PushItemRPG(splice$, theprogram)  'push item
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WANDER":
            Call WanderRPG(splice$, theprogram)  'push item(random)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "BITMAP":
            Call BitmapRPG(splice$, theprogram)  'show bmp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MAINFILE":
            Call MainFileRPG(splice$, theprogram)  'run mainForm file
            DoSingleCommand = -1
            Exit Function
    
        Case "DIRSAV":
            Call DirSavRPG(splice$, theprogram, retval) 'dir saved games.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SAVE":
            Call SaveRPG(splice$, theprogram)  'save game.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "LOAD":
            Call LoadRPG(splice$, theprogram)  'load game.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SCAN":
            Call ScanRPG(splice$, theprogram)  'scan.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MEM":
            Call MemRPG(splice$, theprogram)  'mem.
            DoSingleCommand = increment(theprogram)
            Exit Function
       
        Case "PRINT":
            Call PrintRPG(splice$, theprogram)  'print out text at current pos.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "RPGCODE":
            Call RPGCodeRPG(splice$, theprogram, retval) 'perform rpgcode command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CHARAT":
            Call CharAtRPG(splice$, theprogram, retval) 'mid$
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "EQUIP":
            Call EquipRPG(splice$, theprogram)  'equip player
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "REMOVE":
            Call RemoveRPG(splice$, theprogram)  'remove equip
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PUTPLAYER":
            Call PutPlayerRPG(splice$, theprogram)  'put player somewhere
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ERASEPLAYER":
            Call ErasePlayerRPG(splice$, theprogram)  'erase player from board
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "INCLUDE":
            Call IncludeRPG(splice$, theprogram) 'include file
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "KILL":
            Call KillRPG(splice$, theprogram) 'kill variable
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GIVEGP":
            Call giveGpRPG(splice$, theprogram) 'give gp variable
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TAKEGP":
            Call TakeGPRPG(splice$, theprogram) 'take gp variable
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETGP":
            Call GetGPRPG(splice$, theprogram, retval) 'get gp value
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'undocumented 4/30/99
        Case "WAVSTOP":
            Call WavStopRPG(splice$, theprogram) 'stop wav sound
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "BORDERCOLOR":
            'obsolete
            Call BorderColorRPG(splice$, theprogram) 'chnage border color
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FIGHTENEMY":
            Call FightEnemyRPG(splice$, theprogram) 'fight enemy
            DoSingleCommand = -2
            Exit Function
    
        Case "RESTOREPLAYER":
            Call RestorePlayerRPG(splice$, theprogram) 'restore player
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: callshop
        Case "CALLSHOP":
            Call callShopRPG(splice$, theprogram) 'call shop window
            DoSingleCommand = -1
            Exit Function
    
        Case "CLEARBUFFER":
            Call clearBufferRPG(splice$, theprogram) 'clear keyboard buffer
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ATTACKALL":
            Call attackAllRPG(splice$, theprogram) 'attack all party or enemy (for battles)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DRAINALL":
            Call drainAllRPG(splice$, theprogram) 'attack all party or enemy (smp for battles)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "INN":
            Call innRPG(splice$, theprogram) 'stay at inn.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TARGETLOCATION":
            Call TargetLocationRPG(splice$, theprogram) 'get x location of traget
            DoSingleCommand = increment(theprogram)
            Exit Function
           
        'after beta 03
        Case "ERASEITEM":
            Call EraseItemRPG(splice$, theprogram) 'remove item from screen
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PUTITEM":
            Call PutItemRPG(splice$, theprogram) 'place item from screen
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CREATEITEM":
            Call CreateItemRPG(splice$, theprogram) 'load item into memory
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DESTROYITEM":
            Call DestroyItemRPG(splice$, theprogram) 'remove item from memory
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'player graphics commands 6/23/99
        Case "WALKSPEED":
            'obsolete
            Call WalkSpeedRPG(splice$, theprogram) 'player walkspeed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ITEMWALKSPEED":
            'obsolete
            Call ItemWalkSpeedRPG(splice$, theprogram) 'item walkspeed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "POSTURE":
            Call PostureRPG(splice$, theprogram) 'player posture
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'button commands 9/14/99
        Case "SETBUTTON":
            Call setbuttonRPG(splice$, theprogram) 'set button
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CHECKBUTTON":
            Call checkButtonRPG(splice$, theprogram, retval) 'check if a button was pressed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CLEARBUTTONS":
            Call clearbuttonsRPG(splice$, theprogram) 'clear button buffer
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MOUSECLICK":
            Call mouseClickRPG(splice$, theprogram) 'tell where the mouse was clicked.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MOUSEMOVE":
            Call mouseMoveRPG(splice$, theprogram) 'tell where the mouse was moved.
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ZOOM":
            Call zoomInRPG(splice$, theprogram) 'zoom screen in
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "EARTHQUAKE":
            Call earthquakeRPG(splice$, theprogram) 'earthquake
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'Above commands are now all documented.
        Case "ITEMCOUNT":
            Call itemCountRPG(splice$, theprogram, retval) 'item count
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DESTROYPLAYER":
            Call DestroyPlayerRPG(splice$, theprogram) 'destroy player
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: player swap screen
        Case "CALLPLAYERSWAP":
            Call CallPlayerSwapRPG(splice$, theprogram) 'player swap window
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: AVI
        Case "PLAYAVI":
            Call PlayAviRPG(splice$, theprogram) 'play avi file
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PLAYAVISMALL":
            Call PlayAviSmallRPG(splice$, theprogram) 'play avi file (windowed)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETCORNER":
            Call GetCornerRPG(splice$, theprogram) 'get corner command
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '2.05b
        Case "UNDERARROW":
            'obsolete
            Call UnderArrowRPG(splice$, theprogram) 'turn under arrow on/off
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'patch 8
        Case "GETLEVEL":
            Call getLevelRPG(splice$, theprogram, retval) 'get player level
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "AI":
            Call aiRPG(splice$, theprogram) 'enemy ai
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "MENUGRAPHIC":
            Call menuGraphicRPG(splice$, theprogram) 'edit menu background graphic
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FIGHTMENUGRAPHIC":
            Call fightMenuGraphicRPG(splice$, theprogram) 'fight menu background graphic
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'OBSOLETE
        Case "FIGHTSTYLE":
            Call fightStyleRPG(splice$, theprogram) 'change fight style menu background graphic
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: another stance command
        'deprecate #stance
        Case "STANCE":
            Call StanceRPG(splice$, theprogram) 'change stance
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '12/23/99
        'TBD: determine if battle speed should be obsolete
        Case "BATTLESPEED":
            Call BattleSpeedRPG(splice$, theprogram) 'change battle speed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TEXTSPEED":
            'obsolete
            Call TextSpeedRPG(splice$, theprogram) 'change text speed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CHARACTERSPEED":
            'CharacterSpeed Deprecated (use GameSpeed instead)
            Call CharacterSpeedRPG(splice$, theprogram) 'change char speed
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        'TBD: deprecate MWinSize-- replace with Mwin size and position commands
        Case "MWINSIZE":
            Call MWinSizeRPG(splice$, theprogram) 'change mwin size
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'dec 28.99
        Case "GETDP":
            Call getDPRPG(splice$, theprogram, retval) 'get dp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETFP":
            Call getFPRPG(splice$, theprogram, retval) 'get fp
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'march 6, 2000
        'TBD: internalmenu
        Case "INTERNALMENU":
            Call internalMenuRPG(splice$, theprogram) 'internal menu
            DoSingleCommand = -1
            Exit Function
    
        'april 3, 2000
        Case "APPLYSTATUS":
            Call applyStatusRPG(splice$, theprogram) 'apply status effect
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "REMOVESTATUS":
            Call removeStatusRPG(splice$, theprogram) 'remove status effect
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'april 11, 2000
        Case "SETIMAGE":
            Call setImageRPG(splice$, theprogram) 'set an image
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DRAWCIRCLE":
            Call DrawCircleRPG(splice$, theprogram) 'draw circle
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FILLCIRCLE":
            Call FillCircleRPG(splice$, theprogram) 'fill circle
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SAVESCREEN":
            Call SaveScreenRPG(splice$, theprogram) 'buffer the screen
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "RESTORESCREEN":
            Call RestoreScreenRPG(splice$, theprogram) 'restor from buffer
            DoSingleCommand = increment(theprogram)
            Exit Function
       
        Case "SIN":
            Call SinRPG(splice$, theprogram, retval) 'sin function
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "COS":
            Call CosRPG(splice$, theprogram, retval) 'cos function
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TAN":
            Call TanRPG(splice$, theprogram, retval) 'tan function
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETPIXEL":
            Call GetPixelRPG(splice$, theprogram) 'get pixel function
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETCOLOR":
            Call GetColorRPG(splice$, theprogram) 'get current color
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETFONTSIZE":
            Call GetFontSizeRPG(splice$, theprogram, retval) 'get font size
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '04/24/00 (patch 10)
        Case "SETIMAGETRANSPARENT":
            Call SetImageTransparentRPG(splice$, theprogram) 'set transparentized image
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SETIMAGETRANSLUCENT":
            Call SetImageTranslucentRPG(splice$, theprogram) 'set transparentized image
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        'may 15/00
        Case "MP3":
            Call WavRPG(splice$, theprogram) 'MP3 command (calls wav)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SOURCELOCATION":
            Call SourceLocationRPG(splice$, theprogram) 'get x,y location of source
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TARGETHANDLE":
            Call TargetHandleRPG(splice$, theprogram, retval) 'get handle of target
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SOURCEHANDLE":
            Call SourceHandleRPG(splice$, theprogram, retval) 'get handle of source
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "DRAWENEMY":
            Call DrawEnemyRPG(splice$, theprogram) 'draw enemy graphics
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'above commands are all documented (5/24/00)
    
        'ver 2.11 (june/00)
        Case "MP3PAUSE":
            Call Mp3PauseRPG(splice$, theprogram) 'play mp3 file
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "BREAK":
            Call BreakRPG(splice$, theprogram) 'debug breakpoint
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'TBD: layerput (iso)
        Case "LAYERPUT":
            Call LayerPutRPG(splice$, theprogram)   'put tile on a layer
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETBOARDTILE", "BOARDGETTILE":
            Call GetBoardTileRPG(splice$, theprogram, retval)  'get the board tile name
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SQRT":
            Call SqrtRPG(splice$, theprogram, retval)  'get the squareroot
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETBOARDTILETYPE":
            Call GetBoardTileTypeRPG(splice$, theprogram, retval)  'get the tile type
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'ver 2.12 aug/00
        Case "SETIMAGEADDITIVE":
            Call SetImageAdditiveRPG(splice$, theprogram)   'set image with addivite translucency
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        'ver 2.13 sept/00
        Case "ANIMATION":
            Call AnimationRPG(splice$, theprogram)   'run animation
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SIZEDANIMATION":
            Call SizedAnimationRPG(splice$, theprogram)   'run sized animation
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FORCEREDRAW":
            Call ForceRedrawRPG(splice$, theprogram)   'force board redraw
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ITEMLOCATION":
            Call ItemLocationRPG(splice$, theprogram)   'get item location
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "WIPE":
            Call WipeRPG(splice$, theprogram)   'do wipe effect
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETRES":
            Call GetResRPG(splice$, theprogram)   'get resolution
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "XYZZY":
            Call AddToMsgBox("Nothing happens...", theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "STATICTEXT":
            'obsolete
            Call StaticTextRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        'v.2.18 (july, 2001)
        Case "PATHFIND":
            Call PathFindRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "ITEMSTEP":
            Call ItemStepRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "PLAYERSTEP":
            Call PlayerStepRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "REDIRECT"
            Call RedirectRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "KILLREDIRECT":
            Call KillRedirectRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "KILLALLREDIRECTS":
            Call KillAllRedirectsRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "PARALLAX"
            'obsolete
            Call ParallaxRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '2.19b (march, 2002)
        Case "GIVEEXP":
            Call GiveExpRPG(splice$, theprogram)  'add player EXP
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        '2.20 (may, 2002)
        Case "ANIMATEDTILES":
            'obsolete
            Call AnimatedTilesRPG(splice$, theprogram)  'animated tiles
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "SMARTSTEP":
            'obsolete
            Call SmartStepRPG(splice$, theprogram)  'animated tiles
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        '3.0 (nov, 2002)
        Case "GAMESPEED":
            'Replaces CharacterSpeed
            Call GameSpeedRPG(splice$, theprogram) 'change game speed
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "THREAD":
            Call ThreadRPG(splice$, theprogram, retval) 'create a thread
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "KILLTHREAD":
            Call KillThreadRPG(splice$, theprogram) 'kill a thread
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GETTHREADID":
            Call GetThreadIDRPG(splice$, theprogram, retval) 'get thread id
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "THREADSLEEP":
            Call ThreadSleepRPG(splice$, theprogram) 'put a thread to sleep
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "TELLTHREAD":
            Call TellThreadRPG(splice$, theprogram, retval) 'call #ThreadListener in the thread
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "THREADWAKE":
            Call ThreadWakeRPG(splice$, theprogram) 'wake sleeping thread
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "THREADSLEEPREMAINING":
            Call ThreadSleepRemainingRPG(splice$, theprogram, retval) 'find remaining sleep time for thread
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "LOCAL":
            Call LocalRPG(splice$, theprogram, retval) 'init a local variable
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "GLOBAL":
            Call GlobalRPG(splice$, theprogram, retval) 'init a global variable
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "AUTOCOMMAND":
            Call AutoCommandRPG(splice$, theprogram, retval) 'turn autocommand on or off
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CREATECURSORMAP":
            Call CreateCursorMapRPG(splice$, theprogram, retval) 'create cursor map
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "KILLCURSORMAP":
            Call KillCursorMapRPG(splice$, theprogram, retval) 'kill cursor map
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "CURSORMAPADD":
            Call CursorMapAddRPG(splice$, theprogram, retval) 'add element to cursor map
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "CURSORMAPRUN":
            Call CursorMapRunRPG(splice$, theprogram, retval) 'run cursor map
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "CREATECANVAS":
            Call CreateCanvasRPG(splice$, theprogram, retval) 'create canvas
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "KILLCANVAS":
            Call KillCanvasRPG(splice$, theprogram, retval) 'destroy canvas
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "DRAWCANVAS":
            Call DrawCanvasRPG(splice$, theprogram, retval) 'draw canvas
            DoSingleCommand = increment(theprogram)
            Exit Function
        
    
        '''KSNiloc's Commands
        
        Case "OPENFILEINPUT"
            OpenFileInputRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "OPENFILEOUTPUT"
            OpenFileOutputRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "OPENFILEAPPEND"
            OpenFileAppendRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "OPENFILEBINARY"
            OpenFileBinaryRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "CLOSEFILE"
            CloseFileRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FILEINPUT"
            FileInputRPG splice$, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function

        Case "FILEPRINT"
            FilePrintRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
    
        Case "FILEGET"
            FileGetRPG splice$, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "FILEPUT"
            FilePutRPG splice$, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function

        Case "FILEEOF"
            FileEOFRPG splice$, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function

        Case "SCRIPT"
            'DoSingleCommand = ScriptRPG(splice$, theProgram)
            Exit Function

        '''End KSNiloc's Commands
        
        'Euix's Commands
        Case "LENGTH", "LEN" 'Len added by KSNiloc
            Call StringLenRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "INSTR"
            Call InStrRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETITEMNAME"
            Call GetItemNameRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETITEMDESC"
            Call GetItemDescRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETITEMCOST"
            Call GetItemCostRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETITEMSELLPRICE"
            Call GetItemSellRPG(splice$, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        'End of Euix's Commands
        
        'Some more commands by KSNiloc...
        
        Case "WITH" 'Direct object manipulation
            DoSingleCommand = WithRPG(splice, theprogram)
            Exit Function

        Case "STOP" 'Halt execution of a program
            runningProgram = False
            DoSingleCommand = increment(theprogram)
            Exit Function

        Case "RESTORESCREENARRAY", "RESTOREARRAYSCREEN" 'Restore arrayed screen
            RestoreScreenArrayRPG splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "SWITCH", "CASE" 'Switch case
            SwitchCase splice, theprogram
            DoSingleCommand = theprogram.programPos
            Exit Function

        Case "SPLICEVARIABLES" 'Splice Variables
            spliceVariables splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "SPLIT" 'Split string
            SplitRPG splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function

        Case "ASC", "CHR" 'ASCII commands
            asciiToChr splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "TRIM"
            trimRPG splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "RIGHT", "LEFT"
            rightLeft splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "CURSORMAPHAND"
            cursorMapHand splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "MOUSEPOINTER"
            mousePointer splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "DEBUGGER"
            debuggerRPG splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "ONERROR"
            onError splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "RESUMENEXT"
            resumeNextRPG splice, theprogram
            DoSingleCommand = theprogram.programPos
            Exit Function

        Case "MSGBOX"
            MBoxRPG splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        Case "ANIMATIONDELAY"
            animationDelayRPG splice, theprogram
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "SETCONSTANTS"
            setConstantsRPG splice
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "ENDCAUSESSTOP"
            endCausesStop = True
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "LOG"
            logRPG splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "ONBOARD"
            onBoardRPG splice, theprogram, retval
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "AUTOLOCAL"
            Call autoLocalRPG(splice, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
            
        Case "GETBOARDNAME"
            Call getBoardNameRPG(splice, theprogram, retval)
            DoSingleCommand = increment(theprogram)
            Exit Function

        'End more of KSNiloc's commands
        
        'CBM:
        Case "PIXELMOVEMENT"
            Call PixelMovementRPG(splice, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        
        'Computerdude800's Commands
        Case "LCASE"
            Call LCaseRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        Case "UCASE"
            Call UCaseRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        Case "APPPATH"
            Call AppPathRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        Case "MID"
            Call MidRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        Case "REPLACE"
            Call ReplaceRPG(splice$, theprogram)
            DoSingleCommand = increment(theprogram)
            Exit Function
        'End of Computerdude800's Commands
        
        Case Else
            'If we got this far, it's an unrecognised command and
            'is probably a method call
            Call MethodCallRPG(splice$, testText$, theprogram, retval) 'method called
            DoSingleCommand = increment(theprogram)
            Exit Function

    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


