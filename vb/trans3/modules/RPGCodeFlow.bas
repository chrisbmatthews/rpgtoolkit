Attribute VB_Name = "RPGCodeFlow"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures that control the flow of rpgcode
' Status: B-
'=========================================================================

Option Explicit

'=========================================================================
' Integral rpgcode variables
'=========================================================================

Public program() As RPGCodeProgram      'item multitask programs
Public gbMultiTasking As Boolean        'the the current set of commands runing under mutlitasking?
Public nextProgram As String            'program to run after current one finishes
Public lineNum As Long                  'line number of message window
Public mwinLines As Long                'number of lines in the message window
Public pointer(100) As String           'list of 100 pointer variable names
Public correspPointer(100) As String    'corresponding pointers
Public textX As Double, textY As Double 'current x and y coords of text
Public endCausesStop As Boolean         'end action swapped for stop action?
Public buttons(50) As activeButton      '51 buttons on screen
Public runningProgram As Boolean        'is a program running?
Public wentToNewBoard As Boolean        'did we go to a new board in the program?
Public methodReturn As RPGCODE_RETURN   'return value for method calls
Public errorKeep As RPGCodeProgram      'program kept as a backup for error handling
Public preErrorPos As Long              'position before an error occured

Public Enum RPGC_DT                     'rpgcode data type enum
    DT_VOID = -1                        '  can't tell
    DT_NUM = 0                          '  numerical variable
    DT_LIT = 1                          '  literal variable
    DT_STRING = 2                       '  string
    DT_NUMBER = 3                       '  number
    DT_COMMAND = 4                      '  command (function)
    DT_EQUATION = 5                     '  equation
End Enum

Public Type RPGCODE_RETURN              'rpgcode return structure
    dataType As RPGC_DT                 '  data type (out)
    num As Double                       '  data as numerical (out)
    lit As String                       '  data as string (out)
    usingReturnData As Boolean          '  is the return data being used? (in)
End Type

Public Type activeButton                'setButton() structure
    x1 As Integer                       '  x1
    x2 As Integer                       '  x2
    y1 As Integer                       '  y1
    y2 As Integer                       '  y2
    face As String                      '  image on button
End Type

'=========================================================================
' Read-only pointer to gbMultiTasking
'=========================================================================
Public Property Get isMultiTasking() As Boolean
    isMultiTasking = gbMultiTasking
End Property

'=========================================================================
' Pops up the rpgcode debugger
'=========================================================================
Public Sub debugger(ByVal Text As String)

    On Error Resume Next

    If Not checkErrorHandling() Then
        If debugYN = 1 Then
            Call debugwin.Show
            debugwin.buglist.Text = debugwin.buglist.Text & Text & vbCrLf
            Call processEvent
        Else
            Call Unload(debugwin)
        End If
    End If

End Sub

'=========================================================================
' Checks if the user has error handling in place
'=========================================================================
Private Function checkErrorHandling() As Boolean
    If Not errorBranch = "" Then
        checkErrorHandling = True
        errorKeep.program(0) = errorKeep.program(0) & "*ERROR CHECKING FLAG"
        If Not errorBranch = "Resume Next" Then
            Call Branch("Branch(" & errorBranch & ")", errorKeep)
        Else
            preErrorPos = errorKeep.programPos
            Call resumeNextRPG("ResumeNext()", errorKeep)
        End If
    End If
End Function

'=========================================================================
' Increment the program position
'=========================================================================
Public Function increment(ByRef theProgram As RPGCodeProgram) As Long
    On Error Resume Next
    theProgram.programPos = theProgram.programPos + 1
    If theProgram.programPos > UBound(theProgram.program) + 1 Then
        theProgram.programPos = -1
    End If
    increment = theProgram.programPos
End Function

'=========================================================================
' Handle a custom method call
'=========================================================================
Public Sub MethodCallRPG(ByVal Text As String, ByVal commandName As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)

    On Error GoTo errorhandler

    Dim parameterList(100) As String
    Dim destList(100) As String

    Dim mName As String, includeFile As String, methodName As String, oldPos As Long, foundIt As Long
    Dim t As Long, test As String, itis As String, canDoIt As Boolean
    
    If commandName$ = "" Then
        mName = GetCommandName(Text, theProgram)   'get command name without extra info
    Else
        mName = commandName
    End If

    includeFile = ParseBefore(mName, ".")
    methodName = ParseAfter(mName, ".")

    If Not InClass.DoNotCheckForClass Then
        If Not methodName = "" Then
            If IsClassRPG(includeFile, methodName, Text, theProgram, retval) Then
                Exit Sub
            End If
        End If
    End If
    
    InClass.DoNotCheckForClass = False
    
    If methodName <> "" Then
        'include file...
        includeFile = addExt(includeFile, ".prg")
        Call IncludeRPG("include(" + Chr$(34) + includeFile$ + Chr$(34) + ")", theProgram)
        mName = methodName
    End If

    oldPos = theProgram.programPos
    'Now to find that method name
    foundIt = -1
    For t = 0 To theProgram.Length
        test$ = GetCommandName$(theProgram.program$(t), theProgram)  'get command name without extra info
        If UCase$(test$) = "METHOD" Then
            itis$ = GetMethodName(theProgram.program$(t), theProgram)
            If UCase$(itis$) = UCase$(mName$) Then
                foundIt = t
                Exit For
            End If
        End If
    Next t
    InClass.MethodWasFound = True
    If foundIt = -1 Then
        'didn't find it in prg code, but it may exist in a plugin...
        canDoIt = QueryPlugins(mName$, Text$, retval)
        If canDoIt = False Then
            'InClass.MethodWasFound = False
            If InClass.PopupMethodNotFound Then
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
        theProgram.programPos = foundIt
        
        Dim dataUse As String, number As Long, pList As Long, number2 As Long
        
        'Get parameters from calling line
        dataUse$ = GetBrackets(Text$)    'Get text inside brackets (parameter list)
        number = CountData(dataUse$)        'how many data elements are there?
        For pList = 1 To number
            parameterList$(pList) = GetElement(dataUse$, pList)
        Next pList
    
        'Get parameters from method line
        dataUse$ = GetBrackets(theProgram.program$(foundIt))   'Get text inside brackets (parameter list)
        number2 = CountData(dataUse$)        'how many data elements are there?
        For pList = 1 To number2
            destList$(pList) = GetElement(dataUse$, pList)
        Next pList

        'create a new local scope for this method...
        Call AddHeapToStack(theProgram)

        Dim lit As String, num As Double
        Dim dataG As Long, dUse As String
        'Now to correspond the two lists
        For pList = 1 To number
            'get the value from the previous stack...
            theProgram.currentHeapFrame = theProgram.currentHeapFrame - 1
            dataG = getValue(parameterList$(pList), lit$, num, theProgram)
            'restore stack...
            theProgram.currentHeapFrame = theProgram.currentHeapFrame + 1
            
            If dataG = 0 Then
                dUse$ = str$(num)
            Else
                dUse$ = lit$
            End If
            'make sure the variable becomes local to the method...
            Dim dummyRet As RPGCODE_RETURN
            Call LocalRPG("#local(" + destList$(pList) + ")", theProgram, dummyRet)
            Call SetVariable(destList$(pList), dUse$, theProgram)
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
                    pointer$(se) = removeChar(destList$(t), " ")
                    correspPointer$(se) = removeChar(parameterList$(t), " ")
                    topList = se
                    Exit For
                End If
            Next se
        Next t

        
        'set up method return value...
        methodReturn = retval
        
        Dim aa As Long
        'OK- data is passed.  Now run the method:
        theProgram.programPos = increment(theProgram)
        
        Dim ogbm As Boolean
        ogbm = isMultiTasking()
        gbMultiTasking = False
        aa = runBlock(theProgram.program$(foundIt), 1, theProgram)
        gbMultiTasking = ogbm

        theProgram.programPos = oldPos
    
        'set up return value...
        retval = methodReturn
    
        'Clear our variables from pointer list
        For t = 1 To number
            For se = theOne To topList
                If UCase$(pointer$(se)) = UCase$(destList$(t)) Then
                    pointer$(se) = ""
                    correspPointer$(se) = ""
                    se = 100
                End If
            Next se
        Next t
        
        'kill the local scope...
        Call RemoveHeapFromStack(theProgram)
        
        'decrement call depth
        DBCallDepth = DBCallDepth - 1

    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'=========================================================================
' Run a line from item programs and threads
'=========================================================================
Public Sub multiTaskNow()

    On Error Resume Next

    'Flag we're multitasking
    gbMultiTasking = True

    Call openMulti
    Call ExecuteAllThreads

    Dim t As Long
    For t = 0 To UBound(multilist)
        If multilist(t) <> "" Then
            'OK, run this multitask program.
            target = t
            targetType = TYPE_ITEM
            Source = t
            sourceType = TYPE_ITEM
            If Not ExecuteThread(program(t + 1)) Then
                multilist(t) = ""
            End If
        End If
    Next t

    If (gGameState <> GS_PAUSE) And (GS_LOOPING) Then Call handleThreadLooping

    'Flag we're no longer multitasking
    gbMultiTasking = False

End Sub

'=========================================================================
' Make sure all item programs are open
'=========================================================================
Public Sub openMulti()
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(multilist)
        If multilist(t) <> "" Then
            If multiopen(t) = 0 Then
                program(t + 1) = openProgram(projectPath & prgPath & multilist(t))
                multiopen(t) = 1
            End If
        End If
    Next t
End Sub

'=========================================================================
' Tests if a program is to be run and returns whether it was
'=========================================================================
Public Function programTest(ByRef passPos As PLAYER_POSITION) As Boolean

    On Error Resume Next

    Dim xx As Double
    Dim yy As Double
    Dim runIt As Long
    Dim t As Long

    Dim toRet As Boolean

    'Copy structure as contents may change
    Dim pos As PLAYER_POSITION
    pos = passPos

    If usingPixelMovement() Then
        'If we're using pixel movement then round the coordinates
        pos = roundCoords(pos, pendingPlayerMovement(selectedPlayer).direction)
    End If

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
                
            ElseIf boardList(activeBoardIndex).theData.activationType(t) = 1 Then
            
                'ah! we press the activation key!
                xx = pos.x
                yy = pos.y
                
                'Check if we're facing in the right direction, and we're one step
                'away from the tile. For pixel movement, this corresponds to standing
                'the minimum fraction away, or on.
                'No cases for diagonals, or isometrics! Use pending.direction?
                
                'Edit: now using passPos rather than the pos from RoundCoords()
                Select Case UCase(pos.stance)
                    Case "WALK_N"
                        xx = pos.x
                        If usingPixelMovement Then
                            yy = Round(passPos.y)
                        Else
                            yy = passPos.y - 1
                        End If
                        
                    Case "WALK_S"
                        xx = pos.x
                        yy = Int(passPos.y) + 1
                        
                    Case "WALK_E"
                        xx = Int(passPos.x) + 1
                        yy = -Int(-passPos.y)
                        
                    Case "WALK_W"
                        xx = -Int(-passPos.x) - 1
                        yy = -Int(-passPos.y)
                End Select
                
                If ( _
                        boardList(activeBoardIndex).theData.progX(t) = xx _
                    And boardList(activeBoardIndex).theData.progY(t) = yy _
                    And boardList(activeBoardIndex).theData.progLayer(t) = pos.l) _
                Or ( _
                        boardList(activeBoardIndex).theData.progX(t) = pos.x _
                    And boardList(activeBoardIndex).theData.progY(t) = pos.y _
                    ) Then
                    
                    'If [Next to] Or [On] tile.
                        
                    If keyWaitState = mainMem.Key Then
                        'yes, we pressed the right key
                        toRet = runprgYN(t)
                    End If
                End If
                
            End If '(.activationType(t) = 0)
        End If '(.programName$(t) <> "")
    Next t

    If usingPixelMovement() Then
        'If we're using pixel movement then round item
        'coordinates and backup the old ones
        ReDim tempItems(maxItem) As PLAYER_POSITION
        For t = 0 To maxItem
            tempItems(t) = roundCoords(itmPos(t), pendingItemMovement(t).direction)
        Next t
    End If

    'Ouch.  Now test for items:
    For t = 0 To maxItem
        If itemMem(t).BoardYN = 1 Then  'yeah, it's a board item
            If boardList(activeBoardIndex).theData.itmName$(t) <> "" Then
                runIt = 1
                'OK, how is it activated?
                If boardList(activeBoardIndex).theData.itmActivationType(t) = 0 Then
                    'we step on it.
                    
                    If Not (usingPixelMovement) Then
                        If _
                                itmPos(t).x = Int(passPos.x) _
                            And itmPos(t).y = Int(passPos.y) _
                            And itmPos(t).l = passPos.l Then
                            
                            toRet = runItmYN(t)
                        End If
                    Else
                        If _
                                Abs(itmPos(t).x - passPos.x) < 1 _
                            And Abs(itmPos(t).y - passPos.y) <= movementSize _
                            And itmPos(t).l = passPos.l Then
                        
                            toRet = runItmYN(t)
                        End If
                    End If
                    
                    'If _
                    '        tempitems(t).x = pos.x _
                    '    And tempitems(t).y = pos.y _
                    '    And tempitems(t).l = pos.l Then
                    '
                    '    'all right! we stepped on it!
                    '    toRet = runItmYN(t)
                    '
                    'End If
                    
                ElseIf boardList(activeBoardIndex).theData.itmActivationType(t) = 1 Then
                
                    'ah! we press the actiavtion key!
                    xx = pos.x: yy = pos.y
                    
                    'Edit: now using passPos rather than the pos from RoundCoords()
                    Select Case UCase(pos.stance)
                        Case "WALK_N"
                            xx = pos.x
                            If usingPixelMovement Then
                                yy = Round(passPos.y)
                            Else
                                yy = passPos.y - 1
                            End If
                            
                        Case "WALK_S"
                            xx = pos.x
                            yy = Int(passPos.y) + 1
                            
                        Case "WALK_E"
                            xx = Int(passPos.x) + 1
                            yy = -Int(-passPos.y)
                            
                        Case "WALK_W"
                            xx = -Int(-passPos.x) - 1
                            yy = -Int(-passPos.y)
                            
                        End Select
                    
                    If tempItems(t).x = xx And tempItems(t).y = yy And tempItems(t).l = pos.l Then
                        If keyWaitState = mainMem.Key Then
                            'yes, we pressed the right key
                            toRet = runItmYN(t)
                        End If
                    End If
                    
                End If '(.itmActivationType(t) = 0)
            End If '(.itmName$(t) <> "")
        End If '(.BoardYN = 1)
    Next t

    'If usingPixelMovement() Then
    '    'If we're using pixel movement then restore the old item positions
    '    For t = 0 To MAXITEM
    '        itmPos(t) = tempitems(t)
    '    Next t
    'End If

    programTest = toRet

End Function

'=========================================================================
' Advances until a { is found
'=========================================================================
Public Sub moveToStartOfBlock(ByRef prg As RPGCodeProgram)

    '=========================================================================
    ' prg - the rpgcode program (in & out)
    '=========================================================================

    Dim done As Boolean
    Do Until done
        Select Case LCase(GetCommandName(prg.program(prg.programPos), prg))
            
            Case "openblock"
                done = True
                Exit Do
            
        End Select
        Call processEvent
        prg.programPos = increment(prg)
    Loop
    
End Sub

'=========================================================================
' Runs a block of code (or skips it if res = 0)
'=========================================================================
Public Function runBlock( _
                            ByVal Text As String, _
                            ByVal res As Long, _
                            ByRef prg As RPGCodeProgram _
                                                          ) As Long

    Dim retval As RPGCODE_RETURN
    Dim done As Boolean
    Dim depth As Long
    
    Call moveToStartOfBlock(prg)
    
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
                    runningProgram = False
                End If
                
            Case Else
           
                If res = 1 Then
                    Call DoCommand(prg, retval)
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
       Call processEvent

    Loop

    runBlock = prg.programPos

End Function

'=========================================================================
' Returns if the item num passed in can be run
'=========================================================================
Public Function runItmYN(ByVal itmNum As Long) As Boolean
    'Tests if conditions are right to run an item.
    'If so, it will be run.
    'return true if it was run
    On Error GoTo errorhandler
    
    Dim toRet As Boolean
    toRet = False
    
    Dim t As Long, runIt As Long, checkIt As Long, lit As String, num As Double, valueTest As Double
    Dim valueTes As String
    
    t = itmNum
    If boardList(activeBoardIndex).theData.itmActivate(t) = 0 Then
        'always active
        runIt = 1
    ElseIf boardList(activeBoardIndex).theData.itmActivate(t) = 1 Then
        'conditional activation
        runIt = 0
        checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate$(t), lit$, num)
        If checkIt = 0 Then
            'it's a numerical variable
            valueTest = num
            If valueTest = val(boardList(activeBoardIndex).theData.itmActivateInitNum$(t)) Then runIt = 1
        ElseIf checkIt = 1 Then
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
            checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate$(t), lit$, num)
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
                itemMem(itmNum).bIsActive = False
                multilist$(itmNum) = ""
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

'=========================================================================
' Returns if the program passed in can be run
'=========================================================================
Public Function runprgYN(ByVal prgnum As Long) As Boolean

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
        checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(t), lit$, num)
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
                checkIt = getIndependentVariable(boardList(activeBoardIndex).theData.progVarActivate$(t), lit$, num)
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

'=========================================================================
' Run the rpgcode program passed in
'=========================================================================
Public Sub runProgram( _
                         ByVal file As String, _
                         Optional ByVal boardNum As Long = -1, _
                         Optional ByVal setSourceAndTarget As Boolean = True, _
                         Optional ByVal startupProgram As Boolean _
                                                                    )

    On Error GoTo runPrgErr
    
    If Trim(Right(file, 1)) = "\" Then Exit Sub
    
    runningProgram = True
    DBCallDepth = 0
    DBWinFilled = False
    DBWinLength = 0
    
    Call hideMsgBox
    Call setconstants
    Call clearButtons

    If setSourceAndTarget Then
        target = selectedPlayer
        targetType = TYPE_PLAYER
        Source = selectedPlayer
        sourceType = TYPE_PLAYER
    End If

    Dim theProgram As RPGCodeProgram
    theProgram = openProgram(file)
    lineNum = 1
    theProgram.threadID = -1

    Call FlushKB
    Dim retval As RPGCODE_RETURN

    If startupProgram Then
        Call CanvasFill(cnvRPGCodeScreen, 0)
    Else
        Call CanvasGetScreen(cnvRPGCodeScreen)
    End If

    Call renderRPGCodeScreen

    Dim prgPos As Long, errorsA As Long
       
    theProgram.programPos = 0
    theProgram.boardNum = boardNum

    Dim mainRetVal As RPGCODE_RETURN
    mainRetVal.usingReturnData = True
    Call DoSingleCommand("Main()", theProgram, mainRetVal)
    If Not mainRetVal.num = 1 Then
        theProgram.programPos = 0
        Do While _
                   ((theProgram.programPos >= 0) _
                   And (theProgram.programPos <= theProgram.Length) _
                   And (runningProgram))

            prgPos = theProgram.programPos
            theProgram.programPos = DoCommand(theProgram, retval)

            If errorsA = 1 Then
                errorsA = 0
                theProgram.programPos = -1
            End If

            Call processEvent
        Loop
    Else
        theProgram.programPos = -1
    End If

    Call hideMsgBox
    
    If theProgram.programPos = -1 Then
        Call renderNow
    End If
    
    Call hideMsgBox
    Call FlushKB
    Call ClearRPGCodeProcess(theProgram)
    runningProgram = False
    bWaitingForInput = False

    If nextProgram <> "" Then
        Dim oldNextProgram As String
        oldNextProgram = nextProgram
        nextProgram = ""
        Call runProgram(oldNextProgram, theProgram.boardNum, setSourceAndTarget)
    End If

    Exit Sub

runPrgErr:
    errorsA = 1
    Resume Next

End Sub

'=========================================================================
' Do a command from the program passed in and return its value
'=========================================================================
Public Function DoCommand(ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN) As Long
    On Error GoTo error
    DoCommand = DoSingleCommand(theProgram.program(theProgram.programPos), theProgram, retval)
    Exit Function
error:
    theProgram.programPos = -1
    DoCommand = -1
End Function

'=========================================================================
' Do any single command - unattached to a program
'=========================================================================
Public Function DoIndependentCommand(ByVal rpgcodeCommand As String, ByRef retval As RPGCODE_RETURN) As Long
    On Error Resume Next
    rpgcodeCommand = ParseRPGCodeCommand(rpgcodeCommand, errorKeep)
    Dim oPP As Long
    oPP = errorKeep.programPos
    DoSingleCommand rpgcodeCommand, errorKeep, retval
    errorKeep.programPos = oPP
End Function

'=========================================================================
' Do any single command - attached to a program
'=========================================================================
Public Function DoSingleCommand(ByVal rpgcodeCommand As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN) As Long
    'Performs a command, and returns the new line number
    'afterwards.  If it returns -1, then the program is done.
    On Error GoTo errorhandler
   
    Dim checkIt As String
    checkIt = replace(replace(replace _
        (LCase(rpgcodeCommand), " ", "" _
        ), vbTab, ""), "#", "")

    If checkIt = "onerrorresumenext" Then ' On Error Resume Next
        onError "#OnError(Resume Next)", theProgram
        DoSingleCommand = increment(theProgram)
        Exit Function

    ElseIf checkIt = "resumenext" Then ' Resume Next
        resumeNextRPG "#ResumeNext()", theProgram
        DoSingleCommand = increment(theProgram)
        Exit Function

    ElseIf Left(checkIt, 11) = "onerrorgoto" Then ' On Error Goto :label
        onError "#OnError(" & Right(checkIt, Len(checkIt) - InStr(1, _
            LCase(rpgcodeCommand), "goto", vbTextCompare) - 1) & ")", theProgram
        DoSingleCommand = increment(theProgram)
        Exit Function

    End If
    
    If theProgram.program(0) & _
        "*ERROR CHECKING FLAG" = errorKeep.program(0) Then
        preErrorPos = theProgram.programPos
        theProgram.programPos = errorKeep.programPos
    End If
    errorKeep = theProgram

    'Threading... [KSNiloc]
    If isMultiTasking() And theProgram.looping Then Exit Function

    'Parse this line like it has never been parsed before... [KSNiloc]
    rpgcodeCommand = ParseRPGCodeCommand(rpgcodeCommand, theProgram)

    Dim cLine As String 'current line
    cLine = rpgcodeCommand
    
    retval.dataType = DT_VOID
    
    'call tracestring("Execute: " + cline$)
    
    If debugYN = 1 Then
        Call DebugBox(theProgram)
    End If
    
    Dim splice As String, cType As String, testText As String

    splice$ = cLine$
    cType$ = GetCommandName$(splice$, theProgram)   'get command name without extra info
    testText$ = UCase$(cType$)

    'check for redirects...
    If redirectExists(testText) Then
        testText = getRedirect(testText)
    End If

    If Left(testText, 1) = "." Then testText = UCase(GetWithPrefix() & testText)

    If testText <> "MWIN" Then
        'if the command is not a MWin command, then
        'check if we have just finished puttin text
        'int the message window
        'if so, show the message window :)
        If bFillingMsgBox Then
            bFillingMsgBox = False
            Call renderRPGCodeScreen
        End If
    End If

    Select Case testText

        Case "VAR":
            Call VariableManip(splice$, theProgram)  'manipulate var
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "MWIN":
            Call MWinRPG(splice$, theProgram)  'put text in mwin.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WAIT":
            Call WaitRPG(splice$, theProgram, retval) 'wait
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "MWINCLS":
            Call MWinClsRPG(splice$, theProgram)  'clear mwin.
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "IF", "ELSE", "ELSEIF"
            DoSingleCommand = IfThen(splice$, theProgram) 'if then
            Exit Function
    
        Case "WHILE", "UNTIL"
            DoSingleCommand = WhileRPG(splice$, theProgram) 'while
            Exit Function
    
        Case "FOR":
            DoSingleCommand = ForRPG(splice$, theProgram) 'for
            Exit Function
    
        Case "SEND":
            Call Send(splice$, theProgram) 'send
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TEXT", "PIXELTEXT"
            Call TextRPG(splice$, theProgram) 'text
            DoSingleCommand = increment(theProgram)
            Exit Function
               
        Case "LABEL":
            'Just a label- ignore it!
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "*", "OPENBLOCK", "CLOSEBLOCK":
            'Just a comment- ignore it!
            DoSingleCommand = increment(theProgram)
            Exit Function
               
        Case "":
            'Just a blank line- ignore it!
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MBOX":
            Call AddToMsgBox(splice$, theProgram)  'Message box
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "@":
            Call AddToMsgBox("", theProgram)  'Message box
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "BRANCH":
            Call Branch(splice$, theProgram) 'Branch command
            DoSingleCommand = theProgram.programPos
            Exit Function
    
        'undocumented
        Case "COM_POP_PILER":
            Call CompilerPopRPG(splice$, theProgram, retval) 'compiler pop var
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'undocumented
        Case "COM_PUSH_PILER":
            Call CompilerPushRPG(splice$, theProgram, retval) 'compiler push var
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'undocumented
        Case "COM_ENTERLOCAL_PILER":
            Call CompilerEnterLocalRPG(splice$, theProgram, retval) 'compiler enter local
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'undocumented
        Case "COM_EXITLOCAL_PILER":
            Call CompilerExitLocalRPG(splice$, theProgram, retval) 'compiler exit local
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CHANGE":
            Call Change(splice$, theProgram) 'Change command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CLEAR":
            Call ClearRPG(splice$, theProgram) 'Clear command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DONE" ' [KSNiloc]
            runningProgram = False
            'Call done(splice$, theProgram) 'Done command
            'DoSingleCommand = -2
            Exit Function
    
        Case "DOS", "WINDOWS":
            Call Dos(splice$, theProgram) 'Dos command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "EMPTY":
            Call EmptyRPG(splice$, theProgram) 'Empty command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "END":
            Call EndRPG(splice$, theProgram) 'End Command
            DoSingleCommand = -1
            Exit Function
    
        Case "FONT":
            Call FontRPG(splice$, theProgram) 'Font command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FONTSIZE":
            Call FontSizeRPG(splice$, theProgram) 'Fontsize command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: speed up 4
        Case "FADE":
            Call Fade(splice$, theProgram) 'Fade command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FBRANCH":
            DoSingleCommand = Fbranch(splice$, theProgram) 'Fbranch multicommand
            Exit Function
    
        Case "FIGHT":
            Call FightRPG(splice$, theProgram) 'Fight command
            DoSingleCommand = -2
            Exit Function
    
        Case "GET":
            Call GetRPG(splice$, theProgram, retval) 'Get command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GONE":
            Call Gone(splice$, theProgram) 'gone
            DoSingleCommand = -1
            Exit Function
        
        Case "VIEWBRD":
            Call ViewBrd(splice$, theProgram) 'viewbrd
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "BOLD":
            Call BoldRPG(splice$, theProgram) 'Bold On/off command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ITALICS":
            Call ItalicsRPG(splice$, theProgram) 'Italics On/off command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "UNDERLINE":
            Call UnderlineRPG(splice$, theProgram) 'Underline On/off command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WINGRAPHIC":
            Call WinGraphic(splice$, theProgram)  'Message box graphic
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WINCOLOR":
            Call WinColorRPG(splice$, theProgram)  'Message box color (dos)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WINCOLORRGB":
            Call WinColorRGB(splice$, theProgram)  'Message box color (rgb)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "COLOR":
            Call ColorRPG(splice$, theProgram)  'Font color (dos)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "COLORRGB":
            Call ColorRGB(splice$, theProgram)  'Font color (rgb)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MOVE":
            Call MoveRPG(splice$, theProgram) 'move
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "NEWPLYR":
            Call NewPlyr(splice$, theProgram) 'NewPlyr
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "OVER":
            Call Over(theProgram)   'Game Over
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "PRG":
            Call prg(splice$, theProgram)  'Prg
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: prompt
        Case "PROMPT":
            Call Prompt(splice$, theProgram, retval)  'Prompt
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PUT":
            Call PutRPG(splice$, theProgram)  'Put
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "RESET":
            Call ResetRPG(theProgram)  'reset
            DoSingleCommand = -1
            Exit Function
            
        Case "RETURN":
            Call ReturnRPG(theProgram)  'refresh screen
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "RUN":
            Call RunRPG(splice$, theProgram)  'run prg
            DoSingleCommand = -1 ' [ KSNiloc ]
            runningProgram = False
            Exit Function
    
        Case "SHOW":
            Call ShowRPG(splice$, theProgram)  'show var
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SOUND":
            Call SoundRPG(splice$, theProgram)  'sound
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WIN":
            Call WinRPG(splice$, theProgram)  'win game
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "HP":
            Call HPRPG(splice$, theProgram)  'set player HP
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GIVEHP":
            Call GiveHPRPG(splice$, theProgram)  'add player HP
            DoSingleCommand = increment(theProgram)
            Exit Function
      
        Case "GETHP":
            Call GetHPRPG(splice$, theProgram, retval)  'get player HP
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MAXHP":
            Call MaxHPRPG(splice$, theProgram)  'set player max HP
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETMAXHP":
            Call GetMaxHPRPG(splice$, theProgram, retval) 'get player max HP
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SMP":
            Call SmpRPG(splice$, theProgram)  'set player Sp'l Move power
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GIVESMP":
            Call GiveSmpRPG(splice$, theProgram)  'give SMP
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETSMP":
            Call GetSmpRPG(splice$, theProgram, retval) 'get player smp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MAXSMP":
            Call MaxSmpRPG(splice$, theProgram)  'set player Max smp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETMAXSMP":
            Call GetMaxSmpRPG(splice$, theProgram, retval) 'get player Max smp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "START":
            Call StartRPG(splice$, theProgram)  'Windows START file
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GIVEITEM":
            Call GiveItemRPG(splice$, theProgram)  'Give player an item
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TAKEITEM":
            Call TakeItemRPG(splice$, theProgram)  'Take item
            DoSingleCommand = increment(theProgram)
            Exit Function
       
        Case "WAV":
            Call WavRPG(splice$, theProgram)  'Play wav
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "DELAY":
            Call DelayRPG(splice$, theProgram)  'delay
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "RANDOM":
            Call RandomRPG(splice$, theProgram, retval) 'random
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PUSH":
            Call PushRPG(splice$, theProgram)  'random
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TILETYPE":
            Call TileTypeRPG(splice$, theProgram)  'tiletype
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MIDIPLAY":
            Call MidiPlayRPG(splice$, theProgram)  'midiplay
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PLAYMIDI":
            Call MidiPlayRPG(splice$, theProgram)  'midiplay
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MEDIAPLAY":
            Call MidiPlayRPG(splice$, theProgram)  'midiplay
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MEDIASTOP", "MEDIAREST":
            Call MidiRestRPG(splice$, theProgram)  'midirest
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MIDIREST":
            Call MidiRestRPG(splice$, theProgram)  'midirest
            DoSingleCommand = increment(theProgram)
            Exit Function
                      
        Case "GODOS":
            Call GoDosRPG(splice$, theProgram)  'goDos
            DoSingleCommand = increment(theProgram)
            Exit Function
                      
        Case "ADDPLAYER":
            Call AddPlayerRPG(splice$, theProgram)  'add player
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "REMOVEPLAYER":
            Call RemovePlayerRPG(splice$, theProgram)  'remove player
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "METHOD":
            DoSingleCommand = SkipMethodRPG(splice$, theProgram) 'skip this method.
            Exit Function
    
        Case "RETURNMETHOD":
            Call ReturnMethodRPG(splice$, theProgram)  'return value from method
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SETPIXEL":
            Call SetPixelRPG(splice$, theProgram)  'set pixel
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DRAWLINE":
            Call DrawLineRPG(splice$, theProgram)  'draw line
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DRAWRECT"
            Call DrawRectRPG(splice$, theProgram)  'draw rect
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FILLRECT":
            Call FillRectRPG(splice$, theProgram)  'fill rect
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DEBUG":
            Call DebugRPG(splice$, theProgram)  'debug on/off
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CASTNUM":
            Call CastNumRPG(splice$, theProgram, retval) 'cast num
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CASTLIT":
            Call CastLitRPG(splice$, theProgram, retval) 'cast lit
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CASTINT":
            Call CastIntRPG(splice$, theProgram, retval) 'cast int
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PUSHITEM":
            Call PushItemRPG(splice$, theProgram)  'push item
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WANDER":
            Call WanderRPG(splice$, theProgram)  'push item(random)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "BITMAP":
            Call BitmapRPG(splice$, theProgram)  'show bmp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MAINFILE":
            Call MainFileRPG(splice$, theProgram)  'run mainForm file
            DoSingleCommand = -1
            Exit Function
    
        Case "DIRSAV":
            Call DirSavRPG(splice$, theProgram, retval) 'dir saved games.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SAVE":
            Call SaveRPG(splice$, theProgram)  'save game.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "LOAD":
            Call LoadRPG(splice$, theProgram)  'load game.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SCAN":
            Call ScanRPG(splice$, theProgram)  'scan.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MEM":
            Call MemRPG(splice$, theProgram)  'mem.
            DoSingleCommand = increment(theProgram)
            Exit Function
       
        Case "PRINT":
            Call PrintRPG(splice$, theProgram)  'print out text at current pos.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "RPGCODE":
            Call RPGCodeRPG(splice$, theProgram, retval) 'perform rpgcode command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CHARAT":
            Call CharAtRPG(splice$, theProgram, retval) 'mid$
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "EQUIP":
            Call EquipRPG(splice$, theProgram)  'equip player
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "REMOVE":
            Call RemoveRPG(splice$, theProgram)  'remove equip
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PUTPLAYER":
            Call PutPlayerRPG(splice$, theProgram)  'put player somewhere
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ERASEPLAYER":
            Call ErasePlayerRPG(splice$, theProgram)  'erase player from board
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "INCLUDE":
            Call IncludeRPG(splice$, theProgram) 'include file
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "KILL":
            Call KillRPG(splice$, theProgram) 'kill variable
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GIVEGP":
            Call giveGpRPG(splice$, theProgram) 'give gp variable
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TAKEGP":
            Call TakeGPRPG(splice$, theProgram) 'take gp variable
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETGP":
            Call GetGPRPG(splice$, theProgram, retval) 'get gp value
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'undocumented 4/30/99
        Case "WAVSTOP":
            Call WavStopRPG(splice$, theProgram) 'stop wav sound
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "BORDERCOLOR":
            'obsolete
            Call BorderColorRPG(splice$, theProgram) 'chnage border color
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FIGHTENEMY":
            Call FightEnemyRPG(splice$, theProgram) 'fight enemy
            DoSingleCommand = -2
            Exit Function
    
        Case "RESTOREPLAYER":
            Call RestorePlayerRPG(splice$, theProgram) 'restore player
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: callshop
        Case "CALLSHOP":
            Call callShopRPG(splice$, theProgram) 'call shop window
            DoSingleCommand = -1
            Exit Function
    
        Case "CLEARBUFFER":
            Call clearBufferRPG(splice$, theProgram) 'clear keyboard buffer
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ATTACKALL":
            Call attackAllRPG(splice$, theProgram) 'attack all party or enemy (for battles)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DRAINALL":
            Call drainAllRPG(splice$, theProgram) 'attack all party or enemy (smp for battles)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "INN":
            Call innRPG(splice$, theProgram) 'stay at inn.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TARGETLOCATION":
            Call TargetLocationRPG(splice$, theProgram) 'get x location of traget
            DoSingleCommand = increment(theProgram)
            Exit Function
           
        'after beta 03
        Case "ERASEITEM":
            Call EraseItemRPG(splice$, theProgram) 'remove item from screen
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PUTITEM":
            Call PutItemRPG(splice$, theProgram) 'place item from screen
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CREATEITEM":
            Call CreateItemRPG(splice$, theProgram) 'load item into memory
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DESTROYITEM":
            Call DestroyItemRPG(splice$, theProgram) 'remove item from memory
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'player graphics commands 6/23/99
        Case "WALKSPEED":
            'obsolete
            Call WalkSpeedRPG(splice$, theProgram) 'player walkspeed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ITEMWALKSPEED":
            'obsolete
            Call ItemWalkSpeedRPG(splice$, theProgram) 'item walkspeed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "POSTURE":
            Call PostureRPG(splice$, theProgram) 'player posture
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'button commands 9/14/99
        Case "SETBUTTON":
            Call setbuttonRPG(splice$, theProgram) 'set button
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CHECKBUTTON":
            Call checkButtonRPG(splice$, theProgram, retval) 'check if a button was pressed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CLEARBUTTONS":
            Call clearbuttonsRPG(splice$, theProgram) 'clear button buffer
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MOUSECLICK":
            Call mouseClickRPG(splice$, theProgram) 'tell where the mouse was clicked.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MOUSEMOVE":
            Call mouseMoveRPG(splice$, theProgram) 'tell where the mouse was moved.
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ZOOM":
            Call zoomInRPG(splice$, theProgram) 'zoom screen in
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "EARTHQUAKE":
            Call earthquakeRPG(splice$, theProgram) 'earthquake
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'Above commands are now all documented.
        Case "ITEMCOUNT":
            Call itemCountRPG(splice$, theProgram, retval) 'item count
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DESTROYPLAYER":
            Call DestroyPlayerRPG(splice$, theProgram) 'destroy player
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: player swap screen
        Case "CALLPLAYERSWAP":
            Call CallPlayerSwapRPG(splice$, theProgram) 'player swap window
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: AVI
        Case "PLAYAVI":
            Call PlayAviRPG(splice$, theProgram) 'play avi file
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PLAYAVISMALL":
            Call PlayAviSmallRPG(splice$, theProgram) 'play avi file (windowed)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETCORNER":
            Call GetCornerRPG(splice$, theProgram) 'get corner command
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        '2.05b
        Case "UNDERARROW":
            'obsolete
            Call UnderArrowRPG(splice$, theProgram) 'turn under arrow on/off
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'patch 8
        Case "GETLEVEL":
            Call getLevelRPG(splice$, theProgram, retval) 'get player level
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "AI":
            Call aiRPG(splice$, theProgram) 'enemy ai
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "MENUGRAPHIC":
            Call menuGraphicRPG(splice$, theProgram) 'edit menu background graphic
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FIGHTMENUGRAPHIC":
            Call fightMenuGraphicRPG(splice$, theProgram) 'fight menu background graphic
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'OBSOLETE
        Case "FIGHTSTYLE":
            Call fightStyleRPG(splice$, theProgram) 'change fight style menu background graphic
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: another stance command
        'deprecate #stance
        Case "STANCE":
            Call StanceRPG(splice$, theProgram) 'change stance
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        '12/23/99
        'TBD: determine if battle speed should be obsolete
        Case "BATTLESPEED":
            Call BattleSpeedRPG(splice$, theProgram) 'change battle speed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TEXTSPEED":
            'obsolete
            Call TextSpeedRPG(splice$, theProgram) 'change text speed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CHARACTERSPEED":
            'CharacterSpeed Deprecated (use GameSpeed instead)
            Call CharacterSpeedRPG(splice$, theProgram) 'change char speed
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        'TBD: deprecate MWinSize-- replace with Mwin size and position commands
        Case "MWINSIZE":
            Call MWinSizeRPG(splice$, theProgram) 'change mwin size
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'dec 28.99
        Case "GETDP":
            Call getDPRPG(splice$, theProgram, retval) 'get dp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETFP":
            Call getFPRPG(splice$, theProgram, retval) 'get fp
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'march 6, 2000
        'TBD: internalmenu
        Case "INTERNALMENU":
            Call internalMenuRPG(splice$, theProgram) 'internal menu
            DoSingleCommand = -1
            Exit Function
    
        'april 3, 2000
        Case "APPLYSTATUS":
            Call applyStatusRPG(splice$, theProgram) 'apply status effect
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "REMOVESTATUS":
            Call removeStatusRPG(splice$, theProgram) 'remove status effect
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'april 11, 2000
        Case "SETIMAGE":
            Call setImageRPG(splice$, theProgram) 'set an image
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DRAWCIRCLE":
            Call DrawCircleRPG(splice$, theProgram) 'draw circle
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FILLCIRCLE":
            Call FillCircleRPG(splice$, theProgram) 'fill circle
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SAVESCREEN":
            Call SaveScreenRPG(splice$, theProgram) 'buffer the screen
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "RESTORESCREEN":
            Call RestoreScreenRPG(splice$, theProgram) 'restor from buffer
            DoSingleCommand = increment(theProgram)
            Exit Function
       
        Case "SIN":
            Call SinRPG(splice$, theProgram, retval) 'sin function
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "COS":
            Call CosRPG(splice$, theProgram, retval) 'cos function
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TAN":
            Call TanRPG(splice$, theProgram, retval) 'tan function
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETPIXEL":
            Call GetPixelRPG(splice$, theProgram) 'get pixel function
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETCOLOR":
            Call GetColorRPG(splice$, theProgram) 'get current color
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETFONTSIZE":
            Call GetFontSizeRPG(splice$, theProgram, retval) 'get font size
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        '04/24/00 (patch 10)
        Case "SETIMAGETRANSPARENT":
            Call SetImageTransparentRPG(splice$, theProgram) 'set transparentized image
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SETIMAGETRANSLUCENT":
            Call SetImageTranslucentRPG(splice$, theProgram) 'set transparentized image
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        'may 15/00
        Case "MP3":
            Call WavRPG(splice$, theProgram) 'MP3 command (calls wav)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SOURCELOCATION":
            Call SourceLocationRPG(splice$, theProgram) 'get x,y location of source
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TARGETHANDLE":
            Call TargetHandleRPG(splice$, theProgram, retval) 'get handle of target
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SOURCEHANDLE":
            Call SourceHandleRPG(splice$, theProgram, retval) 'get handle of source
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "DRAWENEMY":
            Call DrawEnemyRPG(splice$, theProgram) 'draw enemy graphics
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'above commands are all documented (5/24/00)
    
        'ver 2.11 (june/00)
        Case "MP3PAUSE":
            Call Mp3PauseRPG(splice$, theProgram) 'play mp3 file
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "BREAK":
            Call BreakRPG(splice$, theProgram) 'debug breakpoint
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'TBD: layerput (iso)
        Case "LAYERPUT":
            Call LayerPutRPG(splice$, theProgram)   'put tile on a layer
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETBOARDTILE", "BOARDGETTILE":
            Call GetBoardTileRPG(splice$, theProgram, retval)  'get the board tile name
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SQRT":
            Call SqrtRPG(splice$, theProgram, retval)  'get the squareroot
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETBOARDTILETYPE":
            Call GetBoardTileTypeRPG(splice$, theProgram, retval)  'get the tile type
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'ver 2.12 aug/00
        Case "SETIMAGEADDITIVE":
            Call SetImageAdditiveRPG(splice$, theProgram)   'set image with addivite translucency
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        'ver 2.13 sept/00
        Case "ANIMATION":
            Call AnimationRPG(splice$, theProgram)   'run animation
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SIZEDANIMATION":
            Call SizedAnimationRPG(splice$, theProgram)   'run sized animation
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FORCEREDRAW":
            Call ForceRedrawRPG(splice$, theProgram)   'force board redraw
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ITEMLOCATION":
            Call ItemLocationRPG(splice$, theProgram)   'get item location
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "WIPE":
            Call WipeRPG(splice$, theProgram)   'do wipe effect
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETRES":
            Call GetResRPG(splice$, theProgram)   'get resolution
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "XYZZY":
            Call AddToMsgBox("Nothing happens...", theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "STATICTEXT":
            'obsolete
            Call StaticTextRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        'v.2.18 (july, 2001)
        Case "PATHFIND":
            Call PathFindRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "ITEMSTEP":
            Call ItemStepRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "PLAYERSTEP":
            Call PlayerStepRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "REDIRECT"
            Call RedirectRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "KILLREDIRECT":
            Call KillRedirectRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "KILLALLREDIRECTS":
            Call KillAllRedirectsRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "PARALLAX"
            'obsolete
            Call ParallaxRPG(splice$, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        '2.19b (march, 2002)
        Case "GIVEEXP":
            Call GiveExpRPG(splice$, theProgram)  'add player EXP
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        '2.20 (may, 2002)
        Case "ANIMATEDTILES":
            'obsolete
            Call AnimatedTilesRPG(splice$, theProgram)  'animated tiles
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "SMARTSTEP":
            'obsolete
            Call SmartStepRPG(splice$, theProgram)  'animated tiles
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        '3.0 (nov, 2002)
        Case "GAMESPEED":
            'Replaces CharacterSpeed
            Call GameSpeedRPG(splice$, theProgram) 'change game speed
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "THREAD":
            Call ThreadRPG(splice$, theProgram, retval) 'create a thread
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "KILLTHREAD":
            Call KillThreadRPG(splice$, theProgram) 'kill a thread
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GETTHREADID":
            Call GetThreadIDRPG(splice$, theProgram, retval) 'get thread id
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "THREADSLEEP":
            Call ThreadSleepRPG(splice$, theProgram) 'put a thread to sleep
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "TELLTHREAD":
            Call TellThreadRPG(splice$, theProgram, retval) 'call #ThreadListener in the thread
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "THREADWAKE":
            Call ThreadWakeRPG(splice$, theProgram) 'wake sleeping thread
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "THREADSLEEPREMAINING":
            Call ThreadSleepRemainingRPG(splice$, theProgram, retval) 'find remaining sleep time for thread
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "LOCAL":
            Call LocalRPG(splice$, theProgram, retval) 'init a local variable
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "GLOBAL":
            Call GlobalRPG(splice$, theProgram, retval) 'init a global variable
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "AUTOCOMMAND":
            Call AutoCommandRPG(splice$, theProgram, retval) 'turn autocommand on or off
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CREATECURSORMAP":
            Call CreateCursorMapRPG(splice$, theProgram, retval) 'create cursor map
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "KILLCURSORMAP":
            Call KillCursorMapRPG(splice$, theProgram, retval) 'kill cursor map
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "CURSORMAPADD":
            Call CursorMapAddRPG(splice$, theProgram, retval) 'add element to cursor map
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "CURSORMAPRUN":
            Call CursorMapRunRPG(splice$, theProgram, retval) 'run cursor map
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "CREATECANVAS":
            Call CreateCanvasRPG(splice$, theProgram, retval) 'create canvas
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "KILLCANVAS":
            Call KillCanvasRPG(splice$, theProgram, retval) 'destroy canvas
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "DRAWCANVAS":
            Call DrawCanvasRPG(splice$, theProgram, retval) 'draw canvas
            DoSingleCommand = increment(theProgram)
            Exit Function
        
    
        '''KSNiloc's Commands
        
        Case "OPENFILEINPUT"
            OpenFileInputRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "OPENFILEOUTPUT"
            OpenFileOutputRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "OPENFILEAPPEND"
            OpenFileAppendRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "OPENFILEBINARY"
            OpenFileBinaryRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "CLOSEFILE"
            CloseFileRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FILEINPUT"
            FileInputRPG splice$, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "FILEPRINT"
            FilePrintRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
    
        Case "FILEGET"
            FileGetRPG splice$, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "FILEPUT"
            FilePutRPG splice$, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "FILEEOF"
            FileEOFRPG splice$, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "SCRIPT"
            'DoSingleCommand = ScriptRPG(splice$, theProgram)
            Exit Function

        '''End KSNiloc's Commands
        
        'Euix's Commands
        Case "LENGTH", "LEN" 'Len added by KSNiloc
            Call StringLenRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "INSTR"
            Call InStrRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETITEMNAME"
            Call GetItemNameRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETITEMDESC"
            Call GetItemDescRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETITEMCOST"
            Call GetItemCostRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETITEMSELLPRICE"
            Call GetItemSellRPG(splice$, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        'End of Euix's Commands
        
        'Some more commands by KSNiloc...
        
        Case "WITH" 'Direct object manipulation
            DoSingleCommand = WithRPG(splice, theProgram)
            Exit Function

        Case "STOP" 'Halt execution of a program
            runningProgram = False
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "RESTORESCREENARRAY", "RESTOREARRAYSCREEN" 'Restore arrayed screen
            RestoreScreenArrayRPG splice, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "SWITCH", "CASE" 'Switch case
            SwitchCase splice, theProgram
            DoSingleCommand = theProgram.programPos
            Exit Function

        Case "SPLICEVARIABLES" 'Splice Variables
            spliceVariables splice, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "SPLIT" 'Split string
            SplitRPG splice, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "ASC", "CHR" 'ASCII commands
            asciiToChr splice, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "TRIM"
            trimRPG splice, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "RIGHT", "LEFT"
            rightLeft splice, theProgram, retval
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "CURSORMAPHAND"
            cursorMapHand splice, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "MOUSEPOINTER"
            mousePointer splice, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "DEBUGGER"
            debuggerRPG splice, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "ONERROR"
            onError splice, theProgram
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "RESUMENEXT"
            Call resumeNextRPG(splice, theProgram)
            DoSingleCommand = theProgram.programPos
            Exit Function

        Case "MSGBOX"
            Call MBoxRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "ANIMATIONDELAY"
            Call animationDelayRPG(splice, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "SETCONSTANTS"
            Call setConstantsRPG(splice)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "ENDCAUSESSTOP"
            endCausesStop = True
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "LOG"
            Call logRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "ONBOARD"
            Call onBoardRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "AUTOLOCAL"
            Call autoLocalRPG(splice, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
            
        Case "GETBOARDNAME"
            Call getBoardNameRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function

        'End more of KSNiloc's commands
        
        'CBM:
        Case "PIXELMOVEMENT"
            Call pixelMovementRPG(splice, theProgram)
            DoSingleCommand = increment(theProgram)
            Exit Function
        
        Case "LCASE"
            Call LCaseRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "UCASE"
            Call UCaseRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "APPPATH"
            Call appPathRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "MID"
            Call midRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function

        Case "REPLACE"
            Call replaceRPG(splice, theProgram, retval)
            DoSingleCommand = increment(theProgram)
            Exit Function
       
        Case Else
            'If we got this far, it's an unrecognised command and
            'is probably a method call
            Call MethodCallRPG(splice, testText, theProgram, retval) 'method called
            DoSingleCommand = increment(theProgram)
            Exit Function

    End Select

    Exit Function

'Begin error handling code:
errorhandler:
      Call HandleError
    Resume Next
End Function
