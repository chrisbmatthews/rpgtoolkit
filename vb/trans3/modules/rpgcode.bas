Attribute VB_Name = "RPGCode"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'rpgcode execution module
Option Explicit

Public bFillingMsgBox As Boolean   'set to true while we're still filling the message box

'Added by KSNiloc...
Public inWith() As String
Public RPGCodeSwitchCase As New Collection
Public foundSwitch() As Boolean
Public doneIf() As Boolean

Sub CompilerPopRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#dest$ = #com_pop_piler()
    'pop a var off the compiler stack (undocumented command-- only used by internal compiler)
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long

    retval.dataType = DT_VOID
    retval.num = -1
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 0 Then
        Call debugger("Error: Com_Pop_Piler must have 0 data elements!-- " + Text$)
        Exit Sub
    End If
    
    Dim value As String
    value = PopCompileStack(theProgram)
    
    retval.dataType = DT_LIT
    retval.lit = value
End Sub


Sub CompilerEnterLocalRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#com_enterlocal_piler()
    'enter a new local scope -- undocumented -- only called by internal compiler
    
    On Error Resume Next
    'create a new local scope...
    Call AddHeapToStack(theProgram)
End Sub

Sub AutoCommandRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#AutoCommand()
    'tuns autocommand on for this program (means you dont' have to use #'s)
    
    'debugger "AutoCommand() is not required anymore-- " & text
    
    'theprogram.autoCommand = True
End Sub


Sub CompilerExitLocalRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#com_exitlocal_piler()
    'exit a new local scope -- undocumented -- only called by internal compiler
    
    On Error Resume Next
    'leave local scope...
    Call RemoveHeapFromStack(theProgram)
End Sub



Sub CompilerPushRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#com_push_piler(a$!)
    'push a var onto the compiler stack (undocumented command-- only used by internal compiler)
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long
    
    retval.dataType = DT_VOID
    retval.num = -1
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 1 Then
        Call debugger("Error: Com_Push_Piler must have 1 data elements!-- " + Text$)
        Exit Sub
    End If
    
    Dim useIt1 As String
    useIt1 = GetElement(dataUse, 1)
    
    Dim dType As Long
    Dim lit As String, num As Double
    dType = getValue(useIt1, lit, num, theProgram)
    
    Dim toUse As String
    If dType = DT_NUM Then
        toUse = toString(num)
    Else
        toUse = lit
    End If
    
    Call PushCompileStack(theProgram, toUse)
End Sub



Private Function formatDirectionString(directions As String) As String
    'This function will take a direction string like this:
    'NNSEWW
    'and turn it into this: N,N,S,E,W,W
    'If there are already comma delimited directions, they will be retained
    'ie: NW,E,SWW will become: NW,E,SW,W
    On Error Resume Next
    
    Dim toRet As String
    Dim directionArray() As String
    Dim element As Long
    Dim direction As String
    
    directionArray = Split(directions, ",")
    
    'Loop over each comma delimed direction.
    For element = 0 To UBound(directionArray)
    
        'Trim any white space off the letters.
        direction = UCase(Trim(directionArray(element)))
        
        'Now, determine if this string needs to be split up into comma delimed directions...
        Dim directionString As String
        directionString = ""
        Dim c As Long
        For c = 0 To Len(direction)
            Dim part As String
            Dim nextPart As String
            
            part = ""
            nextPart = ""
            
            part = Mid(direction, c, 1)
            If (c + 1 <= Len(direction)) Then
                nextPart = Mid(direction, c + 1, 1)
            End If
            
            Dim delimiter As String
            If (directionString = "") Then
                'first time thru the loop...
                delimiter = ""
            Else
                delimiter = ","
            End If
            
            Select Case part
                Case "N", "S":
                    'determine if the next char is 'E' or 'W':
                    If (nextPart <> "") Then
                        If (nextPart = "E" Or nextPart = "W") Then
                            'ok, this is a valid diagonal direction...
                            directionString = directionString + delimiter + part + nextPart
                            c = c + 1
                        Else
                            'this is not a diagonal direction-- break it up
                            directionString = directionString + delimiter + part + "," + nextPart
                            c = c + 1
                        End If
                    Else
                        directionString = directionString + delimiter + part
                    End If
                Case Else:
                    directionString = directionString + delimiter + part
            End Select
        Next c
        
        If toRet = "" Then
            toRet = directionString
        Else
            toRet = toRet + "," + directionString
        End If
    Next element
    
    formatDirectionString = toRet
End Function

Sub GetThreadIDRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#threadID! = #GetThreadID([dest!])
    'return the threadID of the currently running prtogram.
    'if -1, then it is not a thread.
    'optionally stores the thread id in dest!
    
    On Error Resume Next
    
    'return -1 if error
    retval.dataType = DT_NUM
    retval.num = -1
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String
    Dim a As Long, b As Long
    Dim lit1 As String, lit2 As String
    Dim num1 As Double, num2 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 0 And number <> 1 Then
        Call debugger("Error: GetThreadID has must have 0 or 1 data elements!-- " + Text$)
        Exit Sub
    End If
    
    If number = 1 Then
        useIt1 = GetElement(dataUse$, 1)
    End If
    
    Dim theID As Long
    theID = theProgram.threadID
        
    If number = 1 Then
        'save value in destination var...
        Call SetVariable(useIt1, str$(theID), theProgram)
    End If
        
    retval.dataType = DT_NUM
    retval.num = theID
End Sub



Sub ThreadWakeRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)
    '#ThreadWake(threadID!)
    'wake up a thread
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String
    Dim a As Long, b As Long
    Dim lit1 As String
    Dim num1 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 1 Then
        Call debugger("Error: ThreadWake must 1 data element!-- " + Text$)
        Exit Sub
    End If
    
    useIt1 = GetElement(dataUse$, 1)
    a = getValue(useIt1, lit1, num1, theProgram)
    If a <> 0 Then
        Call debugger("Error: ThreadWake data type must be numerical!-- " + Text$)
        Exit Sub
    Else
        Call ThreadWake(num1)
    End If
    
End Sub




Sub ThreadSleepRemainingRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#dest! = #ThreadSleepRemaining(threadID! [, dest!])
    'how much time is left in the thread sleep?
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String
    Dim a As Long, b As Long
    Dim lit1 As String, lit2 As String
    Dim num1 As Double, num2 As Double
    
    retval.dataType = DT_VOID
    retval.num = -1
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 1 And number <> 2 Then
        Call debugger("Error: ThreadSleepRemaining must have 1 or 2 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1 = GetElement(dataUse$, 1)
    If number = 2 Then
        useIt2 = GetElement(dataUse$, 1)
    End If
    
    a = getValue(useIt1, lit1, num1, theProgram)
    If a <> 0 Then
        Call debugger("Error: ThreadSleepRemaining data type must be numerical!-- " + Text$)
        Exit Sub
    Else
        Dim dRemain As Double
        retval.dataType = DT_NUM
        retval.num = ThreadSleepRemaining(num1)
        If number = 2 Then
            Call SetVariable(useIt2, str$(retval.num), theProgram)
        End If
    End If
End Sub

Sub LocalRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#dest!$ = #Local(varname!$ [, dest!$])
    'declare a variable as local
    'also returns cuirrent value of variable
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String
    Dim a As Long, b As Long
    Dim lit1 As String, lit2 As String
    Dim num1 As Double, num2 As Double
    
    retval.dataType = DT_VOID
    retval.num = -1
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 1 And number <> 2 Then
        Call debugger("Error: Local must have 1 or 2 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1 = GetElement(dataUse$, 1)
    If number = 2 Then
        useIt2 = GetElement(dataUse$, 1)
    End If
    
    '! MODIFIED BY KSNiloc...
    
    Dim vtype As Long
    vtype = variType(useIt1, globalHeap)
    If vtype = DT_NUM Then
        'numerical variable...
        'first check if it's in the local scope...
        If Not (numVarExists(useIt1, theProgram.heapStack(theProgram.currentHeapFrame))) Then
            'the numerical var doesn't exist in the local scope-- add it...
            Call SetNumVar(useIt1, 0, theProgram.heapStack(theProgram.currentHeapFrame))
        End If
        'get value...
        a = getValue(useIt1, lit1, num1, theProgram)
        retval.dataType = DT_NUM
        retval.num = num1
    
        If number = 2 Then
            Call SetVariable(useIt2, str$(retval.num), theProgram)
        End If
    Else
        'literal variable...
        'first check if it's in the local scope...
        If Not (litVarExists(useIt1, theProgram.heapStack(theProgram.currentHeapFrame))) Then
            'the numerical var doesn't exist in the local scope-- add it...
            Call SetLitVar(useIt1, "", theProgram.heapStack(theProgram.currentHeapFrame))
        End If
        'get value...
        a = getValue(useIt1, lit1, num1, theProgram)
        retval.dataType = DT_LIT
        retval.lit = lit1
    
        If number = 2 Then
            Call SetVariable(useIt2, str$(retval.lit), theProgram)
        End If
    End If
End Sub

Sub GlobalRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#dest!$ = #Global(varname!$ [, dest!$])
    'declare a variable as global
    'also returns cuirrent value of variable
    
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String
    Dim a As Long, b As Long
    Dim lit1 As String, lit2 As String
    Dim num1 As Double, num2 As Double
    
    retval.dataType = DT_VOID
    retval.num = -1
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 1 And number <> 2 Then
        Call debugger("Error: Global must have 1 or 2 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1 = GetElement(dataUse$, 1)
    If number = 2 Then
        useIt2 = GetElement(dataUse$, 1)
    End If
    
    Dim oldHeap As Long
    Dim vtype As Long
    vtype = variType(useIt1, globalHeap)
    If vtype = DT_NUM Then
        'numerical variable...
        'first check if it's in the local scope...
        If Not (numVarExists(useIt1, globalHeap)) Then
            'the numerical var doesn't exist in the scope-- add it...
            Call SetNumVar(useIt1, 0, globalHeap)
        End If
        'get value (only in the gloabl heap)...
        oldHeap = theProgram.currentHeapFrame
        'force us to look only in global heap
        theProgram.currentHeapFrame = -1
        a = getValue(useIt1, lit1, num1, theProgram)
        theProgram.currentHeapFrame = oldHeap
        
        retval.dataType = DT_NUM
        retval.num = num1
    
        If number = 2 Then
            Call SetVariable(useIt2, str$(retval.num), theProgram)
        End If
    Else
        'literal variable...
        'first check if it's in the local scope...
        If Not (litVarExists(useIt1, globalHeap)) Then
            'the numerical var doesn't exist in the local scope-- add it...
            Call SetLitVar(useIt1, 0, globalHeap)
        End If
        'get value (only in the gloabl heap)...
        oldHeap = theProgram.currentHeapFrame
        'force us to look only in global heap
        theProgram.currentHeapFrame = -1
        a = getValue(useIt1, lit1, num1, theProgram)
        theProgram.currentHeapFrame = oldHeap
        
        retval.dataType = DT_LIT
        retval.lit = lit1
    
        If number = 2 Then
            Call SetVariable(useIt2, str$(retval.lit), theProgram)
        End If
    End If
End Sub


Sub TellThreadRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '[#ret!$ =] #TellThread(threadID!, command$ [, dest$!])
    'call command defined by command$ in a running thread
    'optionally returns a value to dest!$
    
    On Error Resume Next
    
    'return -1 if error
    retval.dataType = DT_NUM
    retval.num = -1
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String, useIt3 As String
    Dim a As Long, b As Long, c As Long
    Dim lit1 As String, lit2 As String, lit3 As String
    Dim num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)    'how many data elements are there?
    If number <> 2 And number <> 3 Then
        Call debugger("Error: TellThread has must have 2 or 3 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1 = GetElement(dataUse$, 1)
    useIt2 = GetElement(dataUse$, 2)
    
    If number = 3 Then
        useIt3 = GetElement(dataUse$, 3)
    End If
    
    a = getValue(useIt1$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
        
    Call TellThread(num1, lit2$, retval)
        
    If number = 3 Then
        'save value in destination var...
        If retval.dataType = DT_LIT Then
            Call SetVariable(useIt3, str$(retval.lit), theProgram)
        Else
            Call SetVariable(useIt3, str$(retval.num), theProgram)
        End If
    End If
End Sub




'Private part As String  'partial section of a string
Sub SmartStepRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#SmartSTep(ON/OFF)
    'Turn smart stepping on or off
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: SmartStep is obsolete!-- " + Text$)
    
    'On Error GoTo errorhandler
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: SmartStep has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'If useIt$ = "" Then
    '    Call debugger("Error: SmartStep has no data element!-- " + text$)
    '    Exit Sub
    'End If
    'a = GetValue(useIt$, lit$, num, theprogram)
    'If a = 0 Then
    '    Call debugger("Error: SmartStep data type must be literal!-- " + text$)
    'Else
    '    If UCase$(lit$) = "ON" Then
    '        smartStep = True
    '    Else
    '        smartStep = False
    '    End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub AnimatedTilesRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#AnimatedTiles(ON/OFF)
    'Turn animated tiles on/off
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: AnimatedTiles is obsolete!-- " + Text$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub GiveExpRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GiveExp("handle",Exp_to_add!)
    'Give player experience-- raise level if required.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: GiveExp must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, lev As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: GiveExp data type must be literal and numeric!-- " + Text$)
    Else
        Dim theOne As Long, t As Long
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player targeted.
                theOne = target
                Call giveExperience(theOne, playerMem(num2))
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                'Call removeEnemyHP(theone, -1 * num2)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                Call giveExperience(theOne, playerMem(num2))
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                'Call removeEnemyHP(theone, -1 * num2)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        Call giveExperience(num2, playerMem(theOne))
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub KillAllRedirectsRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#KillAllRedirects()
    'clears all redirects
    On Error GoTo errorhandler
    Call clearRedirects

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub KillRedirectRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#KillRedirect("#Mwin")
    'kill a redirect redirect
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Error: Redirect must have 1 data element!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    a = getValue(useIt1$, lit1$, num1, theProgram)
    If a = 0 Then
        Call debugger("Error: Redirect data type must be literal!-- " + Text$)
    Else
        Call killRedirect(lit1$)
    End If
End Sub

Sub ParallaxRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Parallax ([012])
    'Changes prallax type'
    '0-full system
    '1-sprite layer off
    '2-parallax off
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: Parallax is obsolete!-- " + Text$)
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PlayerStepRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#PlayerStep(handle$, x!, y!)
    'Push player in the direction of the x!, y! (pathfind)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: ItemStep must have 3 data elements!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    
    Dim b As Long, c As Long, theOne As Long
    
    a = getValue(useIt$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    c = getValue(useIt3$, lit3$, num3, theProgram)
    If a = 0 Or b = 1 Or c = 1 Then
        Call debugger("Error: ItemStep data type must be lit, num, num!-- " + Text$)
        Exit Sub
    End If
    
    Dim t As Long, p As String, tt As String, h As String
    theOne = -1
    For t = 0 To 4
        If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
    Next t
    If UCase$(lit1$) = "TARGET" Then
        If targetType = 0 Then
            theOne = target
        End If
    End If
    If UCase$(lit1$) = "SOURCE" Then
        If sourceType = 0 Then
            theOne = Source
        End If
    End If
    If theOne = -1 Then Exit Sub 'Player handle not found
    
    p$ = PathFind(ppos(theOne).x, ppos(theOne).y, num2, num3, ppos(theOne).l, False, True)
        
    tt$ = p$
    h$ = Mid$(tt$, 1, 1)
    Select Case h$
        Case "N":
            pendingPlayerMovement(theOne).direction = MV_NORTH
            pendingPlayerMovement(theOne).xOrig = ppos(theOne).x
            pendingPlayerMovement(theOne).yOrig = ppos(theOne).y
            pendingPlayerMovement(theOne).lOrig = ppos(theOne).l
            Call insertTarget(pendingPlayerMovement(theOne))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "S":
            pendingPlayerMovement(theOne).direction = MV_SOUTH
            pendingPlayerMovement(theOne).xOrig = ppos(theOne).x
            pendingPlayerMovement(theOne).yOrig = ppos(theOne).y
            pendingPlayerMovement(theOne).lOrig = ppos(theOne).l
            Call insertTarget(pendingPlayerMovement(theOne))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "E":
            pendingPlayerMovement(theOne).direction = MV_EAST
            pendingPlayerMovement(theOne).xOrig = ppos(theOne).x
            pendingPlayerMovement(theOne).yOrig = ppos(theOne).y
            pendingPlayerMovement(theOne).lOrig = ppos(theOne).l
            Call insertTarget(pendingPlayerMovement(theOne))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "W":
            pendingPlayerMovement(theOne).direction = MV_WEST
            pendingPlayerMovement(theOne).xOrig = ppos(theOne).x
            pendingPlayerMovement(theOne).yOrig = ppos(theOne).y
            pendingPlayerMovement(theOne).lOrig = ppos(theOne).l
            Call insertTarget(pendingPlayerMovement(theOne))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub ItemStepRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ItemStep(itemnum!, x!, y!)
    'Push item in the direction of the x!, y! (pathfind)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: ItemStep must have 3 data elements!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    
    Dim b As Long, c As Long
    a = getValue(useIt$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    c = getValue(useIt3$, lit3$, num3, theProgram)
    Dim inum As Long
    inum = num1
    If b = 1 Or c = 1 Then
        Call debugger("Error: ItemStep data type must be num, num, num!-- " + Text$)
        Exit Sub
    End If
    If a = 1 Then
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 1 Then inum = target
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 1 Then inum = Source
        End If
    End If

    Dim p As String, t As String, h As String
    p$ = PathFind(boardList(activeBoardIndex).theData.itmX(inum), boardList(activeBoardIndex).theData.itmY(inum), num2, num3, boardList(activeBoardIndex).theData.itmLayer(inum), False, True)
        
    t$ = p$
    h$ = Mid$(t$, 1, 1)
    Select Case h$
        Case "N":
            pendingItemMovement(inum).direction = MV_NORTH
            pendingItemMovement(inum).xOrig = itmPos(inum).x
            pendingItemMovement(inum).yOrig = itmPos(inum).y
            pendingItemMovement(inum).lOrig = itmPos(inum).l
            Call insertTarget(pendingItemMovement(inum))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "S":
            pendingItemMovement(inum).direction = MV_SOUTH
            pendingItemMovement(inum).xOrig = itmPos(inum).x
            pendingItemMovement(inum).yOrig = itmPos(inum).y
            pendingItemMovement(inum).lOrig = itmPos(inum).l
            Call insertTarget(pendingItemMovement(inum))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "E":
            pendingItemMovement(inum).direction = MV_EAST
            pendingItemMovement(inum).xOrig = itmPos(inum).x
            pendingItemMovement(inum).yOrig = itmPos(inum).y
            pendingItemMovement(inum).lOrig = itmPos(inum).l
            Call insertTarget(pendingItemMovement(inum))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
        Case "W":
            pendingItemMovement(inum).direction = MV_WEST
            pendingItemMovement(inum).xOrig = itmPos(inum).x
            pendingItemMovement(inum).yOrig = itmPos(inum).y
            pendingItemMovement(inum).lOrig = itmPos(inum).l
            Call insertTarget(pendingItemMovement(inum))
            
            movementCounter = 0
            If isMultiTasking() Then
                'if multitasking, let the mainloop take care of this
                gGameState = GS_MOVEMENT
            Else
                'if running a regular program, move the sprite now
                Call runQueuedMovements
            End If
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub AddPlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#AddPlayer("file.tem")
    'Add player to party.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: AddPlayer has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: AddPlayer has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: AddPlayer data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".tem")
        'find empty slot:
        Dim slot As Long, t As Long
        slot = -1
        For t = 0 To 4
            If playerListAr$(t) = "" Then slot = t: t = 4
        Next t
        If slot = -1 Then
            Call debugger("Error: AddPlayer cannot add another member- Party is full!-- " + Text$)
            Exit Sub
        End If
        Call CreateCharacter(projectPath$ + temPath$ + lit$, slot)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub aiRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#AI(level!)
    'causes enemy to use internal ai
    'of specified level
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: AI has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = RPGC_DT.DT_LIT Then
        Call debugger("Error: AI data type must be numerical!-- " + Text$)
    Else
        If targetType = TYPE_PLAYER Then
            'players targeted.
            Dim theOne As Long, tohit As Long
            num = inBounds(num, 0, 3)
            theOne = target
            tohit = chooseHit(theOne)
            Call preformFightAI(num, theOne, tohit)
        ElseIf targetType = TYPE_ENEMY Then
            'enemies targeted.
            'cannot be done.
            Call debugger("Error: AI can only be used by enemy AI programs!-- " + Text$)
        End If
    End If

End Sub

Sub AnimationRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Animation("file.anm", x!, y!)
    'run animation at x!, y!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: Animation must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim file As String, xx As Double, yy As Double, aa As Long, bb As Long, cc As Long
    
    aa = getValue(useIt1$, file$, num1, theProgram)
    bb = getValue(useIt2$, lit$, xx, theProgram)
    cc = getValue(useIt3$, lit$, yy, theProgram)
    'If aa = 0 Or xx = 1 Or yy = 1 Then
    '    Call debugger("Error: Animation data type must be lit, num, num!-- " + text$)
    'Else
        file$ = addExt(file$, ".anm")
        Call openAnimation(projectPath$ + miscPath$ + file$, animationMem)
        
        ' MODIFIED BY KSNiloc...
               
        If Not isMultiTasking() Then
        
            Call renderCanvas(cnvRPGCodeScreen)
            Call TransAnimateAt(xx, yy)
            
        Else
        
            'We're multi-tasking...
            startMultitaskAnimation xx, yy, theProgram
        
        End If
        
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub applyStatusRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ApplyStatus("handle", "filename.ste")
    'apply status effect to a player, or the target handle
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: ApplyStatus must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    
    Dim hand As Long, filen As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    filen = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or filen = 0 Then
        Call debugger("Error: ApplyStatus requires lit, lit!-- " + Text$)
    Else
        Dim theOne As Long, t As Long
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player was targeted
                theOne = target
                Call PlayerAddStatus(lit2, playerMem(theOne))
                Call PlayerAddStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                Call EnemyAddStatus(lit2, enemyMem(theOne))
                Call EnemyAddStatus(lit2, parties(ENEMY_PARTY).fighterList(theOne).enemy)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                'player was targeted
                theOne = Source
                Call PlayerAddStatus(lit2, playerMem(theOne))
                Call PlayerAddStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                Call EnemyAddStatus(lit2, enemyMem(theOne))
                Call EnemyAddStatus(lit2, parties(ENEMY_PARTY).fighterList(theOne).enemy)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        Call PlayerAddStatus(lit2, playerMem(theOne))
        Call PlayerAddStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub BattleSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#BattleSpeed(speed!)
    'changes battle speed, like in the customize menu
    'speed! is 0-7
    On Error Resume Next
    Call debugger("Warning: BattleSpeed is obsolete!-- " + Text$)
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: BattleSpeed has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'a = GetValue(useIt$, lit$, num, theProgram)
    'If a = 1 Then
    '    Call debugger("Error: BattleSpeed data type must be numerical!-- " + text$)
    'Else
    '    num = inbounds(num, 0, 7)
    '    BattleSpeed = num
    'End If
End Sub

Sub BreakRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Break()
    'opens debugger and breaks.
    On Error GoTo errorhandler
    debugging = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CallPlayerSwapRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#CallPlayerSwap()
    'calls player swap window.
    On Error GoTo errorhandler
    pswap.Show 1    'shows swap modally.

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CharacterSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#CharacterSpeed(speed!)
    'changes char speed, like in the customize menu
    'speed! is 0-3
    'Deprecated (Nov 5, 2002) use GameSpeed instead
    On Error GoTo errorhandler
    
    Call debugger("Warning: CharacterSpeed is deprecated, use GameSpeed instead!-- " + Text$)
    Call GameSpeedRPG(Text$, theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GameSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '==========================
    'EDITED: [Delano - 3/05/04]
    'Altered delay for speed! = 3; runs too fast on some machines.
    'Added the assignment of cursorDelayTime, which is called between cursor movements.
    'Renamed variables: num >> speed
    '                   a >> parameter1Type
    'Removed unneeded variables.
    '==========================
    
    'Changes game speed, like in the customize menu.
    'speed! is 0 (slowest) to 3 (fastest)
    'Also controls the speed of the cursor on the menus - see Mod transDialogs Sub cursordelay
    
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long, useIt As String
    Dim lit As String, speed As Double, parameter1Type As Long
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)        'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    If number <> 1 Then
        Call debugger("Warning: GameSpeed has only 1 data element!-- " + Text$)
    End If
    
    useIt$ = GetElement(dataUse$, 1)
    
    parameter1Type = getValue(useIt$, lit$, speed, theProgram)
    
    If parameter1Type = 1 Then
        'If parameter is literal.
        Call debugger("Error: GameSpeed data type must be numerical!-- " + Text$)
    Else
        'Parameter is numerical.
        speed = inBounds(speed, 0, MAX_GAMESPEED)
        Call gameSpeed(speed)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub checkButtonRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #CheckButton(x!,y![,button_num!])
    'checks if a click at x!,y! is in a button
    'if it is, the button number is returned.
    'if it isn't, returns -1
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 2 Then
        Call debugger("Error: CheckButton must have three numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String, var3 As String
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    var3$ = GetElement(dataUse$, 3)
    
    Dim xx As Long, yy As Long, x As Double, y As Double
    xx = getValue(var1$, lit$, x, theProgram)
    yy = getValue(var2$, lit$, y, theProgram)
        
    Dim theOne As Long, t As Long, b As Long
    theOne = -1
    For t = 0 To 50
        a = within(x, buttons(t).x1, buttons(t).x2)
        b = within(y, buttons(t).y1, buttons(t).y2)
        If a = 1 And b = 1 Then
            theOne = t
            Exit For
        End If
    Next t
    
    If number = 3 Then
        Call SetVariable(var3$, str$(theOne), theProgram)
    End If
    retval.dataType = DT_NUM
    retval.num = theOne

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub clearButtons()
    'clears button buffer
    On Error GoTo errorhandler
    
    Dim t As Long
    
    For t = 0 To 50
        buttons(t).x1 = -1
        buttons(t).x2 = -1
        buttons(t).y1 = -1
        buttons(t).y2 = -1
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub clearbuttonsRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ClearButtons()
    'clears all buttons from memory
    On Error GoTo errorhandler
    Call clearButtons

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CosRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)

    On Error Resume Next
    
    'Re-written by KSNiloc
    
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    Select Case CountData(Text)
    
        Case 1
            If Not paras(0).dataType = DT_NUM Then
                debugger "Cos() requires a numerical data element-- " & Text
                Exit Sub
            End If
            retval.dataType = DT_NUM
            retval.num = Cos(paras(0).num)
        
        Case 2
            If Not paras(0).dataType = DT_NUM Then
                debugger "Cos() requires a numerical data element-- " & Text
                Exit Sub
            End If
            SetVariable paras(1).dat, Cos(paras(0).num), theProgram
        
        Case Else
            debugger "Cos() requires one or two data elements-- " & Text
    
    End Select

End Sub

Public Sub CreateItemRPG( _
                            ByVal Text As String, _
                            ByRef theProgram As RPGCodeProgram _
                                                                 )

    '===================
    'IMPROVED BY KSNiloc
    '===================
    'Improved to work with unlimited item positions

    'CreateItem(filename$,pos!)
    'Creates an item in position pos!

    On Error Resume Next

    If CountData(Text) <> 2 Then
        debugger "Error: CreateItem must have 2 data elements!-- " & Text
        Exit Sub
    End If

    'Declarations
    Dim theOne As Long
    Dim lit As String
    Dim paras() As parameters

    'Get the parameters
    paras() = GetParameters(Text, theProgram)
    lit = paras(0).lit
    theOne = paras(1).num

    'Make sure they're the right type
    If paras(0).dataType <> DT_LIT And paras(1).dataType <> DT_NUM Then
        debugger "CreateItem()'s parameters are lit,num-- " & Text
        Exit Sub
    End If

    'See if the arrays are large enough
    Do While MAXITEM < theOne
        'Enlarge the arrays
        dimensionItemArrays
    Loop

    'Put it on the board
    boardList(activeBoardIndex).theData.itmName(theOne) = lit
    lit = projectPath & itmPath & lit

    'Load the item
    itemMem(theOne) = openItem(lit)

End Sub

Sub DestroyItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'EDITED: [Delano - 20/04/04]
    'Bug: Tile was still solid to players after the item had been removed.
    
    '#DestroyItem(itemnum!)
    'remove item from board.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: DestroyItem has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    Dim aa As Long
    aa = getValue(useIt$, lit$, num, theProgram)
    If aa = 1 Then
        Call debugger("Error: DestroyItem data element must be numerical!-- " + Text$)
        Exit Sub
    End If
    'remove from board memory...
    boardList(activeBoardIndex).theData.itmName$(num) = ""
    
    'Fix: also need to remove locations, because item is still "solid" after removal:
    itmPos(num).x = 0
    itmPos(num).y = 0
    itmPos(num).l = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DestroyPlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#DestroyPlayer("file" or handle)
    'Remove player from party.
    'does not puts player in available list.
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: DestroyPlayer has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: DestroyPlayer has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: DestroyPlayer data type must be literal!-- " + Text$)
    Else
        Dim ext As String, file As String, t As Long
        ext$ = GetExt(lit$)
        Select Case UCase$(ext$)
            Case "":
                'find slot:
                For t = 0 To 4
                    If UCase$(playerListAr$(t)) = UCase$(lit$) Then
                        playerListAr$(t) = ""
                        playerFile$(t) = ""
                        t = 4
                    End If
                Next t
            Case "TEM":
                num = FreeFile
                file$ = projectPath$ + temPath$ + lit$
                'file$ = PakLocate(file$)
                'Open file$ For Input As #num
                '    Input #num, fileheader$        'Filetype
                '    If fileheader$ <> "RPGTLKIT CHAR" Then Close #num: Exit Sub
                '    Input #num, majorver           'Version
                '    Input #num, minorver           'Minor version (ie 2.0)
                '    If majorver <> Major Then Close #num: Exit Sub
                '    Line Input #num, hand$      'Charactername
                'Close #num
                Dim plyr As TKPlayer
                Call openchar(file$, plyr)
                Dim hand As String
                hand$ = plyr.charname
                'find slot:
                For t = 0 To 4
                    If UCase$(playerListAr$(t)) = UCase$(hand$) Then
                        playerListAr$(t) = ""
                        playerFile$(t) = ""
                        t = 4
                    End If
                Next t
        End Select
    End If
End Sub

Sub DrawCircleRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#DrawCircle(x!, y!, radius! [,startangle!, endangle!, [cnvId!]])
    'draw a circle or arc.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 5 And number <> 6 Then
        Call debugger("Error: DrawCircle must have 3 or 5 or 6 data elements!-- " + Text$)
        Exit Sub
    End If
    
    Dim useIt4 As String, useIt5 As String, useIt6 As String
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    If number = 5 Then
        useIt4$ = GetElement(dataUse$, 4)
        useIt5$ = GetElement(dataUse$, 5)
    Else
        useIt4$ = ""
        useIt5$ = ""
    End If
    If number = 6 Then
        useIt6$ = GetElement(dataUse$, 6)
    Else
        useIt6 = ""
    End If
    Dim xx1 As Long, yy1 As Long, rr As Long, sa As Long, ea As Long
    Dim x1 As Double, y1 As Double, radius As Double, st As Double, en As Double
    Dim cnv As Double
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    rr = getValue(useIt3$, lit$, radius, theProgram)
    sa = getValue(useIt4$, lit$, st, theProgram)
    ea = getValue(useIt5$, lit$, en, theProgram)
    a = getValue(useIt6$, lit$, cnv, theProgram)

    'Commenting by KSNiloc...
    
    'If xx1 = DT_LIT Or yy1 = DT_LIT Or rr = DT_LIT Or sa = DT_LIT Or ea = DT_LIT Or a = DT_LIT Then
    '    Call debugger("Error: DrawCircle data types must be numerical!-- " + text$)
    
        Dim startangle As Double, endangle As Double
        startangle = st * 3.14159 / 180     'conv to radians
        endangle = en * 3.14159 / 180     'conv to radians
        'TBD: start and end angles
        If number <> 6 Then
            Call CanvasDrawEllipse(cnvRPGCodeScreen, x1 - radius, y1 - radius, x1 + radius, y1 + radius, fontColor)
            'Call renderRPGCodeScreen
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, x1, y1, _
                                x1 + radius * 2, y1 + radius * 2
            DXRefresh
        Else
            Call CanvasDrawEllipse(cnv, x1 - radius, y1 - radius, x1 + radius, y1 + radius, fontColor)
        End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DrawEnemyRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    '#DrawEnemy(file$, x!, y! [,cnv!])
    'draws an enemy at x, y
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 4 Then
        Call debugger("Error: DrawEnemy must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim useIt4 As String
    useIt4 = GetElement(dataUse, 4)
    
    Dim b As Long, c As Long
    
    a = getValue(useIt$, lit$, num, theProgram)
    b = getValue(useIt2$, lit$, num2, theProgram)
    c = getValue(useIt3$, lit$, num3, theProgram)
    Dim cnv As Double
    getValue useIt4, lit, cnv, theProgram
    
    If cnv = 0 Then cnv = cnvRPGCodeScreen
    
    If a = 0 Or b = 1 Or c = 1 Then
        Call debugger("Error: DrawEnemy data type must be literal, num, num!-- " + Text$)
    Else
        Dim x As Double, y As Double, en As String, fn As String, hdc As Long, eenum As Long
        x = num2
        y = num3
        en$ = addExt(lit$, ".ene")
        enemyMem(4).eneFileName$ = projectPath$ + enePath$ + en$
        'Call openEnemy(projectPath$ + enepath$ + en$, 4)
        eenum = 4
        'quick draw the enemy
        ChDir (projectPath$)
        fn$ = enemyMem(eenum).eneFileName$
        fn$ = RemovePath(fn$)
        fn$ = enePath$ + fn$
        hdc = CanvasOpenHDC(cnv)
        'TBD: draw enemy...
        'a = GFXdrawEnemy(fn$, x, y, 0, 0, 0, hdc)
        Call CanvasCloseHDC(cnv, hdc)
        ChDir (currentDir$)
        If cnv = cnvRPGCodeScreen Then Call renderRPGCodeScreen
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub EraseItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#EraseItem(itemnum!)
    'removes an item from the screen.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: EraseItem has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    Dim aa As Long
    aa = getValue(useIt$, lit$, num, theProgram)
    If aa = 1 Then
        Call debugger("Error: EraseItem data element must be numerical!-- " + Text$)
        Exit Sub
    End If
    itemMem(num).bIsActive = False
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fightMenuGraphicRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#FightMenuGraphic("file.gif")
    'internal fight menu background graphic.
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: FightMenuGraphic has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: FightMenuGraphic data type must be literal!-- " + Text$)
    Else
        fightMenuGraphic$ = lit$
    End If
End Sub

Sub fightStyleRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#FightStyle(0/1)
    'change fighitng style
    '0-side view, 1-front view
    'obsolete...
    On Error Resume Next
    Call debugger("Warning: FightStyle is obsolete!-- " + Text$)
    'On Error GoTo errorhandler
    'Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: FightStyle has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'a = GetValue(useIt$, lit$, num, theProgram)
    'If a = 1 Then
    '    Call debugger("Error: FightStyle data type must be numerical!-- " + text$)
    'Else
    '    num = inbounds(num, 0, 1)
    '    mainMem.fightStyle = num
    'End If

End Sub

Sub FillCircleRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#FillCircle(x!,y!,radius!, [cnvId!])
    'draw a filled circle
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 4 Then
        Call debugger("Error: FillCircle must have 3 or 4 data elements!-- " + Text$)
        Exit Sub
    End If
    
    Dim useIt4 As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4 = GetElement(dataUse$, 4)
    
    Dim x1 As Double, y1 As Double, radius As Double
    Dim xx1 As Long, yy1 As Long, rr As Long
    Dim cnv As Double
    
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    rr = getValue(useIt3$, lit$, radius, theProgram)

    ' KSNiloc says: ... ... ...
    a = getValue(useIt4, lit, cnv, theProgram)
    'a = GetValue(useIt3$, lit$, cnv, theProgram)
    
    'If xx1 = DT_LIT Or yy1 = DT_LIT Or rr = DT_LIT Or a = DT_LIT Then
    '    Call debugger("Error: FillCircle data types must be numerical!-- " + text$)
    'Else
        If number = 3 Then
            Call CanvasDrawFilledEllipse(cnvRPGCodeScreen, x1 - radius, y1 - radius, x1 + radius, y1 + radius, fontColor)
            'Call renderRPGCodeScreen
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1 - radius * 2, y1 - radius * 2, x1 - radius * 2, y1 - radius * 2, _
                                x1 + radius * 2, y1 + radius * 2
            DXRefresh
        Else
            Call CanvasDrawFilledEllipse(cnv, x1 - radius, y1 - radius, x1 + radius, y1 + radius, fontColor)
        End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub FillRectRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#fillrect(x1,y1,x2,y2, [cnvId!])
    'fill a rect
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 And number <> 5 Then
        Call debugger("Error: FillRect must have 4 or 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, xx1 As Long, yy1 As Long, xx2 As Long, yy2 As Long
    Dim x1 As Double, y1 As Double, x2 As Double, y2 As Double
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5 = GetElement(dataUse$, 5)
    
    Dim cnv As Double
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    xx2 = getValue(useIt3$, lit$, x2, theProgram)
    yy2 = getValue(useIt4$, lit$, y2, theProgram)
    
    ' CMB, you're just nasty with those typos, heh.
    'a = GetValue(useIt4$, lit$, cnv, theProgram)
    a = getValue(useIt5, lit, cnv, theProgram)
    
    'Commenting by KSNiloc...

    'If xx1 = DT_LIT Or yy1 = DT_LIT Or xx2 = DT_LIT Or yy2 = DT_LIT Or a = DT_LIT Then
    '    Call debugger("Error: FillRect data type must be numerical!-- " + text$)
    'Else
        If number = 4 Then
            Call CanvasFillBox(cnvRPGCodeScreen, x1, y1, x2, y2, fontColor)
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, x1, y1, _
                                x2 - x1 + 10, y2 - y1 + 10
        Else
            Call CanvasFillBox(cnv, x1, y1, x2, y2, fontColor)
        End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub FontRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Font ("font.fnt")
    'Changes font.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Font has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Font has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Font data type must be literal!-- " + Text$)
    Else
        'lit$ = addext(lit$, ".fnt")
        fontName$ = lit$
        If UCase$(GetExt(lit$)) = "FNT" Then
            'tk font
            Call loadFont(projectPath$ + fontPath$ + lit$)
        Else
            'true type font
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub FontSizeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#FontSize(size)
    'change font size
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: FontSize has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: FontSize data type must be numerical!-- " + Text$)
    Else
        num = inBounds(num, 0, 255)
        fontSize = num
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ForceRedrawRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ForceRedraw()
    'redraws screen.
    On Error GoTo errorhandler
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Function ForRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long
'#For(a!=0;a!<=8;a!=a!+1)
'{
'   ...
'   ...
'}
'For loop

    ' ! MODIFIED BY KSNiloc...

    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    Dim res As Long
    If number <> 3 Then
        Call debugger("Error: For must have 3 data elements!-- " + Text$)
        res = 0
        theProgram.programPos = increment(theProgram)
        ForRPG = runBlock(Text$, res, theProgram)
        Exit Function
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    'Perform command 1:
    'useIt1$ = "#" + useIt1$
    'useIt3$ = "#" + useIt3$
    
    Dim oldPos As Long
    oldPos = theProgram.programPos
    
    Dim retval As RPGCODE_RETURN

    ' ! MODIFIED BY KSNiloc...
    DoSingleCommand useIt1, theProgram, retval
    'a = DoIndependentCommand(useIt1$, retval)
    theProgram.programPos = oldPos
    
    'Now evaluate condition:
    Dim u As String
    Dim u2 As String
    Dim u3 As String
    
    u = use
    u2 = useIt2
    u3 = useIt3
    
    theProgram.programPos = increment(theProgram)
    res = Evaluate(u2, theProgram)
    
    If res = 1 Then

        If Not (isMultiTasking() And (Not theProgram.looping)) Then
    
            Do While res = 1
                res = Evaluate(u2, theProgram)
                Dim oldLine As Long, newPos As Long, curLine As Long
        
                oldLine = theProgram.programPos
                newPos = runBlock(u, res, theProgram)
                a = DoSingleCommand(u3, theProgram, retval)
                curLine = oldLine
                theProgram.programPos = oldLine
            Loop

        Else

            'We're multitasking- let the main loop handle this...
            startThreadLoop theProgram, TYPE_FOR, u2, u3
            ForRPG = theProgram.programPos
            Exit Function

        End If
        
    Else
    
        'If isMultiTasking() Then
        '
        '    theProgram.looping = False
        '    loopEnd(num) = True
        '
        'End If
    
    End If

    'If i'm here, then res=0, and we must run through once more.
    ForRPG = runBlock(Text$, res, theProgram)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub GetBoardTileRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #boardgettile(x!, y!, layer![, dest$])
    'get the filename of the tile
    'at a specific board position
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 And number <> 3 Then
        Call debugger("Error: boardgettile must have 4 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, ax As Long, ay As Long, al As Long
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    ax = getValue(useIt1$, lit$, num1, theProgram)
    ay = getValue(useIt2$, lit$, num2, theProgram)
    al = getValue(useIt3$, lit$, num3, theProgram)
    If ax = 1 Or ay = 1 Or al = 1 Then
        Call debugger("Error: boardgettile data must be numeric, numeric, numeric, literal!-- " + Text$)
    Else
        Dim f As String
        
        num1 = inBounds(num1, 1, boardList(activeBoardIndex).theData.Bsizex)
        num2 = inBounds(num2, 1, boardList(activeBoardIndex).theData.Bsizey)
        num3 = inBounds(num3, 1, boardList(activeBoardIndex).theData.Bsizel)
        f$ = BoardGetTile(num1, num2, num3, boardList(activeBoardIndex).theData)
        If number = 4 Then
            Call SetVariable(useIt4$, f$, theProgram)
        End If
        retval.dataType = DT_LIT
        retval.lit = f$
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetBoardTileTypeRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #GetBoardTileType(x!, y!, layer![, type$])
    'get the tiletype of the tile
    'at a specific board position
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 And number <> 3 Then
        Call debugger("Error: GetBoardTileType must have 4 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, ax As Long, ay As Long, al As Long, ll As Long, t As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    ax = getValue(useIt1$, lit$, num1, theProgram)
    ay = getValue(useIt2$, lit$, num2, theProgram)
    al = getValue(useIt3$, lit$, num3, theProgram)
    If ax = 1 Or ay = 1 Or al = 1 Then
        Call debugger("Error: GetBoardTileType data must be numeric, numeric, numeric, literal!-- " + Text$)
    Else
        num1 = inBounds(num1, 1, boardList(activeBoardIndex).theData.Bsizex)
        num2 = inBounds(num2, 1, boardList(activeBoardIndex).theData.Bsizey)
        num3 = inBounds(num3, 1, boardList(activeBoardIndex).theData.Bsizel)
        ll = boardList(activeBoardIndex).theData.tiletype(num1, num2, num3)
        Select Case ll
            Case 0:
                t$ = "NORMAL"
            Case 1:
                t$ = "SOLID"
            Case 2:
                t$ = "UNDER"
            Case 3:
                t$ = "NS"
            Case 4:
                t$ = "EW"
            Case 11:
                t$ = "STAIRS1"
            Case 12:
                t$ = "STAIRS2"
            Case 13:
                t$ = "STAIRS3"
            Case 14:
                t$ = "STAIRS4"
            Case 15:
                t$ = "STAIRS5"
            Case 16:
                t$ = "STAIRS6"
            Case 17:
                t$ = "STAIRS7"
            Case 18:
                t$ = "STAIRS8"
        End Select
        If number = 4 Then
            Call SetVariable(useIt4$, t$, theProgram)
        End If
        retval.dataType = DT_LIT
        retval.lit = t$
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub GetColorRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GetColor(r!, g!, b!)
    'gets current font color
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: GetColor must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim rr As Long, gg As Long, bb As Long
    rr = red(fontColor)
    gg = green(fontColor)
    bb = blue(fontColor)
    Call SetVariable(useIt1$, str$(rr), theProgram)
    Call SetVariable(useIt2$, str$(gg), theProgram)
    Call SetVariable(useIt3$, str$(bb), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetCornerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GetCorner(topx!,topy!)
    'returns topx, topy
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: GetCorner must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    Call SetVariable(var1$, str$(topX), theProgram)
    Call SetVariable(var2$, str$(topY), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub getDPRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetDP(handle$[,dest!])
    'get dp of player
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetDP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetDP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player was targeted
                theOne = target
                aa = getVariable(playerMem(theOne).defenseVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneDP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneDP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                'player was targeted
                theOne = Source
                aa = getVariable(playerMem(theOne).defenseVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneDP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneDP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).defenseVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetFontSizeRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetFontSize([dest!])
    'get the current size of the font
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 And number <> 0 Then
        Call debugger("Error: GetFontSize must have 1 data element!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    If number = 1 Then
        Call SetVariable(useIt1$, str$(fontSize), theProgram)
    End If
    retval.dataType = DT_NUM
    retval.num = fontSize

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub getFPRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetFP(handle$[,dest!])
    'get fp of player
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetFP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetFP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player was targeted
                theOne = target
                aa = getVariable(playerMem(theOne).fightVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneFP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneFP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                'player was targeted
                theOne = Source
                aa = getVariable(playerMem(theOne).fightVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneFP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneFP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).fightVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetGPRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetGP([dest!])
    'Get current GP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 And number <> 0 Then
        Call debugger("Warning: GetGP has more than 1 data element!-- " + Text$)
        Exit Sub
    End If
    If number = 1 Then
        Call SetVariable(dataUse$, str$(GPCount), theProgram)
    End If
    retval.dataType = DT_NUM
    retval.num = GPCount

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetHPRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetHP("handle"[,dest!])
    'Get current Player HP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetHP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetHP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player was targeted
                theOne = target
                aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                    retval.dataType = DT_NUM
                    retval.num = curhp
                Else
                    retval.dataType = DT_NUM
                    retval.num = curhp
                End If
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneHP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneHP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                'player was targeted
                theOne = Source
                aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneHP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneHP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub getLevelRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetLevel("handle"[,dest!])
    'get player's level
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetLevel must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetLevel handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).leVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted (level 0)
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(0), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = 0
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).leVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted (level 0)
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(0), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = 0
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).leVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetMaxHPRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetMaxHP("handle"[,dest!])
    'Get character's MAX HP level
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetMaxHP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetMaxHP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneMaxHP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneMaxHP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneMaxHP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneMaxHP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub GetMaxSmpRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetMaxSMP("handle"[,dest!])
    'Get max SMP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetMaxSMP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetMaxSMP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneMaxSMP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneMaxSMP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneMaxSMP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneMaxSMP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).smMaxVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub GetPixelRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    '#GetPixel(x!,y!, r!, g!, b! [,cnv!])
    'get the pixel at x!, y! and put it's value in r!, g!, b!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 5 And number <> 6 Then
        Call debugger("Error: GetPixel must have 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, xx As Long, yy As Long, x As Double, y As Double
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    Dim useIt6 As String
    useIt6 = GetElement(dataUse, 6)
    
    xx = getValue(useIt1$, lit$, x, theProgram)
    yy = getValue(useIt2$, lit$, y, theProgram)
    Dim cnv As Double
    getValue useIt6, lit, cnv, theProgram
    
    If cnv = 0 Then cnv = cnvRPGCodeScreen
    
    If xx = 1 Or yy = 1 Then
        Call debugger("Error: GetPixel data type must be numerical!-- " + Text$)
    Else
        Dim p As Long, rr As Long, gg As Long, bb As Long
        p = CanvasGetPixel(cnv, x, y)
        rr = red(p)
        gg = green(p)
        bb = blue(p)
        Call SetVariable(useIt3$, str$(rr), theProgram)
        Call SetVariable(useIt4$, str$(gg), theProgram)
        Call SetVariable(useIt5$, str$(bb), theProgram)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GetResRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GetRes(destx!, desty!)
    'get x and y resolution (of mainForm form), in pixels.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: GetRes must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String, xx As Long, yy As Long
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    
    xx = resX
    yy = resY
    
    Call SetVariable(var1$, str$(xx), theProgram)
    Call SetVariable(var2$, str$(yy), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub GetRPG( _
                     ByVal Text As String, _
                     ByRef theProgram As RPGCodeProgram, _
                     ByRef retval As RPGCODE_RETURN _
                                                      )
    
    On Error Resume Next
    
    'RE-WRITTEN BY KSNiloc

    'a$ = Get( [milliSeconds!] )
    'Get(a$ [,milliSeconds!])
    
    Dim number As Long
    number = CountData(Text)
    If number <> 0 And number <> 1 And number <> 2 Then
        debugger "Get() requires 0-2 data elements-- " & Text
        Exit Sub
    End If

    'Get out parameters...
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)

    retval.dataType = DT_LIT
    
    Select Case number

        Case 0
            'Just get a key and return it...
            retval.lit = getKey()

        Case 1
            'Could be returning with milliSecond specification or
            'it could be an olden style Get(a$).

            If retval.usingReturnData Then
                
                'We're using the return data. That means that it's
                'specifying the number of milliSeconds to doEvents for.
                
                If Not paras(0).dataType = DT_NUM Then
                    debugger "Get()'s millisecond specification must be numerical-- " & Text
                    Exit Sub
                End If

                retval.lit = getKey(paras(0).num)
                
            Else
                
                'We're not returning anything. It's simply an old style
                'Get(a$) call.

                SetVariable paras(0).dat, getKey(), theProgram

            End If

        Case 2
            'It's Get(dest$,milliSeconds!)...
            
            If Not paras(1).dataType = DT_NUM Then
                debugger "Get()'s millisecond specification must be numerical-- " & Text
                Exit Sub
            End If
            
            SetVariable paras(0).dat, getKey(paras(1).num), theProgram
    
    End Select
    
End Sub

Sub GetSmpRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #GetSMP("handle"[,dest!])
    'get player's SMP level
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: GetSMP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, curhp As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    If hand = 0 Then
        Call debugger("Error: GetSMP handle must be literal!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneSMP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneSMP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(curhp), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = curhp
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                If number = 2 Then
                    Call SetVariable(useIt2$, str$(enemyMem(theOne).eneSMP), theProgram)
                End If
                retval.dataType = DT_NUM
                retval.num = enemyMem(theOne).eneSMP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(curhp), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = curhp
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub giveGpRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GiveGP(100)
    'give gp
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: GiveGP has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: GiveGP data type must be numerical!-- " + Text$)
    Else
        GPCount = GPCount + num
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GiveHPRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GiveHP("handle",HP_to_add!)
    'Give player HP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: GiveHP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, lev As Long, curhp As Double, tooBig As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: GiveHP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
                curhp = curhp + num2
        
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
                If curhp > tooBig Then curhp = tooBig
                If curhp < 0 Then curhp = 0
        
                Call SetVariable(playerMem(theOne).healthVar$, str$(curhp), theProgram)
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                Call addEnemyHP(num2, enemyMem(theOne))
                Call doAttack(-1, -1, ENEMY_PARTY, theOne, -1 * num2, False)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
                curhp = curhp + num2
        
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
                If curhp > tooBig Then curhp = tooBig
                If curhp < 0 Then curhp = 0
        
                Call SetVariable(playerMem(theOne).healthVar$, str$(curhp), theProgram)
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                Call addEnemyHP(num2, enemyMem(theOne))
                Call doAttack(-1, -1, ENEMY_PARTY, theOne, -1 * num2, False)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).healthVar$, lit$, curhp, theProgram)
        curhp = curhp + num2
        
        aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
        If curhp > tooBig Then curhp = tooBig
        
        If curhp < 0 Then curhp = 0
        
        Call SetVariable(playerMem(theOne).healthVar$, str$(curhp), theProgram)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GiveItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    On Error Resume Next
    '#GiveItem("filename")
    'Give player the item defined in the filename file.
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: GiveItem has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: GiveItem data type must be literal!-- " + Text$)
    Else
        'Scan inventory for this item
        lit$ = addExt(lit$, ".itm")
        Call AddItemToList(lit$, inv)
    End If
End Sub

Sub GiveSmpRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GiveSMP("handle", smp_to_add!)
    'Give player SMP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: GiveSMP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, lev As Long, curhp As Double, tooBig As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: GiveSMP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
                curhp = curhp + num2
        
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
                If curhp > tooBig Then curhp = tooBig
        
                If curhp < 0 Then curhp = 0
        
                Call SetVariable(playerMem(theOne).smVar$, str$(curhp), theProgram)
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                Call addEnemySMP(num2, enemyMem(theOne))
                Call doAttack(-1, -1, ENEMY_PARTY, theOne, -1 * num2, True)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
                curhp = curhp + num2
        
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
                If curhp > tooBig Then curhp = tooBig
        
                If curhp < 0 Then curhp = 0
        
                Call SetVariable(playerMem(theOne).smVar$, str$(curhp), theProgram)
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                Call addEnemySMP(num2, enemyMem(theOne))
                Call doAttack(-1, -1, ENEMY_PARTY, theOne, -1 * num2, True)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).smVar$, lit$, curhp, theProgram)
        curhp = curhp + num2
        
        aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
        If curhp > tooBig Then curhp = tooBig
        
        If curhp < 0 Then curhp = 0
        
        Call SetVariable(playerMem(theOne).smVar$, str$(curhp), theProgram)
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub GoDosRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#GoDos("command")
    'Perform dos command
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    'disabled october 5/99 due to possible
    'security issues.
    Call debugger("Error: GoDos has been disabled due to posible security issues!-- " + Text$)
    Exit Sub
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: GoDos has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: GoDos data type must be literal!-- " + Text$)
    Else
        Dim comm As String, dum As Long
        comm$ = lit$
        dum = Shell(comm$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Gone(Text$, ByRef theProgram As RPGCodeProgram)
    '#Gone()
    'Removes program filename
    On Error GoTo errorhandler
    If theProgram.boardNum >= 0 Then
        boardList(activeBoardIndex).theData.programName$(theProgram.boardNum) = ""
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub HPRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#HP ("Handle", new_HP_level!)
    'Set player's HP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: HP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, aa As Long, lev As Long, curhp As Double, tooBig As Double
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: HP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
                If num2 > tooBig Then num2 = tooBig
                Call SetVariable(playerMem(theOne).healthVar$, str$(num2), theProgram)
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                enemyMem(theOne).eneHP = num2
                If enemyMem(theOne).eneHP > enemyMem(theOne).eneMaxHP Then enemyMem(theOne).eneHP = enemyMem(theOne).eneMaxHP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
                If num2 > tooBig Then num2 = tooBig
                Call SetVariable(playerMem(theOne).healthVar$, str$(num2), theProgram)
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                enemyMem(theOne).eneHP = num2
                If enemyMem(theOne).eneHP > enemyMem(theOne).eneMaxHP Then enemyMem(theOne).eneHP = enemyMem(theOne).eneMaxHP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).maxHealthVar$, lit$, tooBig, theProgram)
        If num2 > tooBig Then num2 = tooBig
        Call SetVariable(playerMem(theOne).healthVar$, str$(num2), theProgram)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Function IfThen( _
                          ByVal Text As String, _
                          ByRef prg As RPGCodeProgram _
                                                        ) As Long
                                                        
    '==========================================================================
    'Re-written by KSNiloc
    '==========================================================================

    'If(this!=that!)
    '{
    '   ...
    '   ...
    '}
    'ElseIf(this!=floomy!)
    '{
    '   ...
    '   ...
    '}
    'Else()
    '{
    '   ...
    '   ...
    '}


    'First make sure that the doneIf() array is dimensioned...
    On Error GoTo dimDoneIf
    Dim ub As Long
    ub = UBound(doneIf)
    
    'Allow the array to enlarge itself...
    On Error GoTo enlargeDoneIf
    
    Select Case LCase(GetCommandName(Text, prg))

        Case "else"
            If Not doneIf(ub) Then
            
                If isMultiTasking() Then

                    'Let the main loop make our job easy...
                    startThreadLoop prg, TYPE_IF
                    IfThen = prg.programPos
                    Exit Function
                
                Else
            
                    IfThen = runBlock(Text, 1, prg)
                
                End If
                
            Else
                IfThen = runBlock(Text, 0, prg)
            End If
            'Our work here is done...
            Exit Function
        
        Case "elseif"
            'Only use this is it truly is 'else'...
            If doneIf(ub) Then Exit Function
        
        Case "if"
            'Move onto the next place in the array...
            doneIf(ub + 1) = False
        
    End Select

    Dim res As Long
    res = Evaluate(GetBrackets(Text), prg)

    If res = 1 Then
    
        doneIf(UBound(doneIf)) = True

        If isMultiTasking() And (Not prg.looping) Then

            'Main loop time...
            startThreadLoop prg, TYPE_IF
            IfThen = prg.programPos
            Exit Function
        
        End If
    
    End If

    IfThen = runBlock(Text, res, prg)
    
Exit Function
    
dimDoneIf:
    ReDim doneIf(0)
    Resume

enlargeDoneIf:
    ReDim Preserve doneIf(UBound(doneIf) + 1)
    Resume

End Function

Function inBounds(ByVal value As Long, ByVal low As Long, ByVal up As Long) As Long
    On Error GoTo errorhandler
    Dim ret As Long
    
    ret = value
    If value < low Then ret = low
    If value > up Then ret = up
    inBounds = ret

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub IncludeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Include("file.prg")
    'include file in program
    On Error GoTo erropenprginclude
    
    Dim errorsA As Long
    Dim theLine As String

    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Include has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Include has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Include data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".prg")
        'check if it's already included...
        Dim foundIt As Boolean
        Dim t As Long
        
        foundIt = False
        For t = 0 To 50
            If UCase$(theProgram.included$(t)) = UCase$(lit$) Then
                foundIt = True
            End If
        Next t
        
        If foundIt = True Then
            'already included...
            Exit Sub
        End If
        
        For t = 0 To 50
            If theProgram.included$(t) = "" Then
                theProgram.included$(t) = lit$
                Exit For
            End If
        Next t
        
        '====================================================================
        'Bug fix by KSNiloc
        '====================================================================
        
        'Declarations...
        Dim tempPRG As RPGCodeProgram
        Dim filen As String
        Dim count As Long

        'Get a location for the tricky file...
        If Not pakFileRunning Then
            filen = projectPath & prgPath & lit
        Else
            filen = PakLocate(prgPath & lit)
        End If
        
        If Not fileExists(filen) Then
            debugger "Error: File " & filen & " does not exist!"
            Exit Sub
        End If
        
        'Retrieve the code from the program...
        openProgram filen, tempPRG
        
        With theProgram
        
            'Make the program large enough for the code we're adding...
            ReDim Preserve .program(UBound(.program) + 2 + tempPRG.Length)
            
            'Don't let any loose code in the .prg file be run...
            .program(.Length + 1) = "End()"
            
            'Add each line from the included file to the main file...
            For count = 0 To UBound(tempPRG.program)
                .program(.Length + 2 + count) = tempPRG.program(count)
            Next count
            
            'Update the length of the program...
            .Length = .Length + 2 + UBound(tempPRG.program)
            
        End With
        
        '====================================================================
        'End bug fix by KSNiloc
        '====================================================================
        
    End If
Exit Sub

erropenprginclude:
errorsA = 1
Resume Next

End Sub


Sub innRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Inn()
    'Restores party's hp/smp
    On Error GoTo errorhandler
    Dim t As Long, nHP As Double, nSMP As Double
    For t = 0 To 4
        If playerListAr$(t) <> "" Then
            nHP = getPlayerMaxHP(playerMem(t))
            nSMP = getPlayerMaxSMP(playerMem(t))
            Call SetVariable(playerMem(t).healthVar$, str$(nHP), theProgram)
            Call SetVariable(playerMem(t).smVar$, str$(nSMP), theProgram)
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub internalMenuRPG( _
                              ByVal Text As String, _
                              ByRef theProgram As RPGCodeProgram _
                                                                   )

    '========================================================================
    'Re-written by KSNiloc
    'Now works :)
    '========================================================================

    'InternalMenu(num!)
    'Call the menu plugin...
    '   0- mainForm menu
    '   1- item menu
    '   2- equip menu
    '   3- details menu //OBSOLETE
    '   4- abilities menu
    '   5- customize menu //OBSOLETE

    On Error Resume Next

    If Not CountData(Text) = 1 Then
        debugger "InternalMenu() must have one data type-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)

    If Not paras(0).dataType = DT_NUM Then
        debugger "InternalMenu() must have a numerical data element-- " & Text
        Exit Sub
    End If

    Select Case paras(0).num

        Case 0: showMenu MNU_MAIN
        Case 1: showMenu MNU_INVENTORY
        Case 2: showMenu MNU_EQUIP
        Case 3: debugger "Error: Details menu is obsolete!-- " & Text
        Case 4: showMenu MNU_ABILITIES
        Case 5: debugger "Error: Customize menu is obsolete!-- " & Text
        Case Else: debugger "Error: Not valid InternalMenu() value!-- " & Text

    End Select

End Sub

Sub ItalicsRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Italics(ON/OFF)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Italics has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Italics has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Italics data type must be literal!-- " + Text$)
    Else
    
        ' ! MODIFIED BY KSNiloc...
    
        If UCase$(lit$) = "ON" Then
            Italics = True
        Else
            Italics = False
        End If
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub itemCountRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #ItemCount("handle or filename"[,number!])
    'count # of items carried by player
    'returns to number!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: ItemCount has more than 1 data element!-- " + Text$)
        Exit Sub
    End If
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: ItemCount data type must be literal!-- " + Text$)
    Else
        'Scan inventory for this item
        Dim ex As String, theOne As Long, t As Long, retNum As Long
        ex$ = GetExt(lit$)
        If UCase$(ex$) = "ITM" Then
            'MsgBox lit$
            theOne = -1
            For t = 0 To UBound(inv.item)
                If UCase$(inv.item(t).file) = UCase$(lit$) Then theOne = t
            Next t
        Else
            theOne = -1
            For t = 0 To UBound(inv.item)
                If UCase$(inv.item(t).handle) = UCase$(lit$) Then theOne = t
            Next t
        End If
        retNum = 0
        If theOne <> -1 Then
            retNum = inv.item(theOne).number
        End If
        If number = 2 Then
            Call SetVariable(useIt2$, str$(retNum), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = retNum
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ItemLocationRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ItemLocation("Item 1", x!, y!, layer!)
    'or
    '#ItemLocation(itemnum!, x!, y!, layer!)
    'returns position of an item and stores in x!, y!, layer!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 Then
        Call debugger("Error: ItemLocation must have 4 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, xx As Long, x As Double, theOne As Long, testIt As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    xx = getValue(useIt1$, lit$, x, theProgram)
    theOne = 0
    If xx = 1 Then
        'string
        testIt$ = UCase$(lit$)

        ' MODIFIED BY KSNiloc...
        If Not Left(testIt, 4) = "ITEM" Then
            debugger "ItemLocation()'s literal parameter must be in form: ITEM x --" & Text
            Exit Sub
        Else
            theOne = Mid(testIt, 6, 1)
        End If
              
    Else
        'numeral
        theOne = x
    End If
    theOne = inBounds(theOne, 0, MAXITEM)
    Call SetVariable(useIt2$, str$(boardList(activeBoardIndex).theData.itmX(theOne)), theProgram)
    Call SetVariable(useIt3$, str$(boardList(activeBoardIndex).theData.itmY(theOne)), theProgram)
    Call SetVariable(useIt4$, str$(boardList(activeBoardIndex).theData.itmLayer(theOne)), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ItemWalkSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ItemWalkSpeed("fast/slow")
    'change item walk speed.
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: ItemWalkSpeed is obsolete!-- " + Text$)
    
    'On Error GoTo errorhandler
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: ItemWalkSpeed has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'If useIt$ = "" Then
    '    Call debugger("Error: ItemWalkSpeed has no data element!-- " + text$)
    '    Exit Sub
    'End If
    'a = GetValue(useIt$, lit$, num, theprogram)
    'If a = 0 Then
    '    Call debugger("Error: ItemWalkSpeed data type must be literal!-- " + text$)
    'Else
    '    If UCase$(lit$) = "FAST" Then
    '        ItemWalkSpeed = 0
    '    Else
    '        ItemWalkSpeed = 1
    '    End If
    'End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub KillRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)
    '#Kill(var!$,var!$,etc.)
    'deletes one or more variables
    On Error GoTo errorhandler
    
    '========================================================================
    'Feature addition by KSNiloc
    '========================================================================
    
    Dim a As Long
    
    If CountData(Text) > 1 Then
        For a = 0 To CountData(Text) - 1
            'Ooo... I love recursing... =P
            KillRPG "Kill(" & GetElement(Text, a + 1) & ")", theProgram
        Next a
        Exit Sub
    End If

    '========================================================================
    'End feature addition by KSNiloc
    '========================================================================
    
    Dim typeVar As Long
    
    'NOTE: 'a' removed from this list...
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Kill has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Kill has no data element!-- " + Text$)
        Exit Sub
    End If
    typeVar = variType(useIt$, globalHeap)
    If typeVar = -1 Then
        Call debugger("Error: Kill cannot determine variable type!-- " + Text$)
        Exit Sub
    End If
    If typeVar = 0 Then
        'numerical
        Call killNum(useIt$, globalHeap)
    End If
    If typeVar = 1 Then
        'literal
        Call KillLit(useIt$, globalHeap)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub LayerPutRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#LayerPut(x!, y!, layer!, "tile.gph")
    'put a tile on a specific position
    'coords are actual board coords (ie, not screen coords)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 Then
        Call debugger("Error: LayerPut must have 4 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, ax As Long, ay As Long, al As Long, ag As Long, num4 As Double
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    ax = getValue(useIt1$, lit$, num1, theProgram)
    ay = getValue(useIt2$, lit$, num2, theProgram)
    al = getValue(useIt3$, lit$, num3, theProgram)
    ag = getValue(useIt4$, lit1$, num4, theProgram)
    If ax = 1 Or ay = 1 Or al = 1 Or ag = 0 Then
        Call debugger("Error: LayerPut data must be numeric, numeric, numeric, literal!-- " + Text$)
    Else
        Select Case boardList(activeBoardIndex).theData.ambienteffect
            Case 0
                addonR = 0
                addonG = 0
                addonB = 0
            Case 1
                addonR = 75
                addonG = 75
                addonB = 75
            Case 2
                addonR = -75
                addonG = -75
                addonB = -75
            Case 3
                addonR = 0
                addonG = 0
                addonB = 75
        End Select
        'internal engine drawing routines
        'first, get the shade color of the board...
        Dim l As String, shadeR As Double, shadeG As Double, shadeB As Double, lightShade As Long
        a = getVariable("AmbientRed!", l$, shadeR, theProgram)
        a = getVariable("AmbientGreen!", l$, shadeG, theProgram)
        a = getVariable("AmbientBlue!", l$, shadeB, theProgram)
        'now check day and night info...
        If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
            lightShade = DetermineLightLevel()
            shadeR = shadeR + lightShade
            shadeG = shadeG + lightShade
            shadeB = shadeB + lightShade
        End If
        
        addonR = addonR + shadeR
        addonG = addonG + shadeG
        addonB = addonB + shadeB
        
        'now redraw the layers...
        Dim file As String
        file$ = lit1$
        num1 = inBounds(num1, 1, boardList(activeBoardIndex).theData.Bsizex)
        num2 = inBounds(num2, 1, boardList(activeBoardIndex).theData.Bsizey)
        num3 = inBounds(num3, 1, boardList(activeBoardIndex).theData.Bsizel)
        Call BoardSetTile(num1, num2, num3, file$, boardList(activeBoardIndex).theData)
        Dim xx As Double, yy As Double, lll As Long, hdc As Long, hdcMask As Long
        xx = num1 - scTopX
        yy = num2 - scTopY
        For lll = 1 To 8
            If BoardGetTile(num1, num2, lll, boardList(activeBoardIndex).theData) <> "" Then
                If Not (usingDX()) Then
                    
                    Call drawTileCNV(cnvScrollCache, _
                                  projectPath$ + tilePath$ + BoardGetTile(num1, num2, lll, boardList(activeBoardIndex).theData), _
                                  xx, _
                                  yy, _
                                  boardList(activeBoardIndex).theData.ambientred(num1, num2, lll) + addonR, _
                                  boardList(activeBoardIndex).theData.ambientgreen(num1, num2, lll) + addonG, _
                                  boardList(activeBoardIndex).theData.ambientblue(num1, num2, lll) + addonB, False)
                    Call drawTileCNV(cnvScrollCacheMask, _
                                  projectPath$ + tilePath$ + BoardGetTile(num1, num2, lll, boardList(activeBoardIndex).theData), _
                                  xx, _
                                  yy, _
                                  boardList(activeBoardIndex).theData.ambientred(num1, num2, lll) + addonR, _
                                  boardList(activeBoardIndex).theData.ambientgreen(num1, num2, lll) + addonG, _
                                  boardList(activeBoardIndex).theData.ambientblue(num1, num2, lll) + addonB, True)
                Else
                    Call drawTileCNV(cnvScrollCache, _
                                  projectPath$ + tilePath$ + BoardGetTile(num1, num2, lll, boardList(activeBoardIndex).theData), _
                                  xx, _
                                  yy, _
                                  boardList(activeBoardIndex).theData.ambientred(num1, num2, lll) + addonR, _
                                  boardList(activeBoardIndex).theData.ambientgreen(num1, num2, lll) + addonG, _
                                  boardList(activeBoardIndex).theData.ambientblue(num1, num2, lll) + addonB, False)
                End If
            End If
        Next lll
        Call renderNow
        
        'Call renderNow(cnvRPGCodeScreen)

        ' ! MODIFIED BY KSNiloc...
        
        Dim x As Long: x = num1
        Dim y As Long: y = num2
        DXDrawCanvasPartial cnvRPGCodeScreen, _
                            x * 32 - 32, y * 32 - 32, _
                            x * 32 - 32, y * 32 - 32, _
                            32, 32
        DXRefresh
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub LoadRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Load("filename")
    'Load saved game
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Load has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Load has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Load data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".sav")
        Call LoadState(savPath$ + lit$)
        'Now to place the character where it should be:
        'Create characters:
        Dim t As Long
        For t = 0 To 4
            If playerFile$(t) <> "" Then
                Call RestoreCharacter(playerFile$(t), t, False)
            End If
        Next t
        Call openboard(currentBoard$, boardList(activeBoardIndex).theData)
        'clear non-persistent threads...
        Call ClearNonPersistentThreads
        lastRender.canvas = -1
        scTopX = -1
        scTopY = -1
        Call alignBoard(ppos(0).x, ppos(0).y)
        Call openItems
        Call renderNow
        Call renderNow(cnvRPGCodeScreen)
        
        ' ! ADDED BY KSNiloc...
        launchBoardThreads boardList(activeBoardIndex).theData
        
        loaded = 1
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub MainFileRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MainFile("mainForm.gam")
    'Run specified mainForm file.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: MainFile has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: MainFile has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: MainFile data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".gam")
        lit$ = gamPath$ + lit$
        Call EmptyRPG("", theProgram)
        For num = 0 To 11
            Dim t As Long
            For t = 0 To UBound(program(num).program)
                program(num).program$(t) = ""
            Next t
        Next num
        Call setupMain
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub MaxHPRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MaxHP("handle",new_MaxHP_level!)
    'Set new max HP level
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: MaxHP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, lev As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: MaxHP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                Call SetVariable(playerMem(theOne).maxHealthVar$, str$(num2), theProgram)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                Call SetVariable(playerMem(theOne).maxHealthVar$, str$(num2), theProgram)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        Call SetVariable(playerMem(theOne).maxHealthVar$, str$(num2), theProgram)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub MaxSmpRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MaxSMP("Handle",new_Max_sm_level!)
    'Set max SMP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: MaxSMP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, theOne As Long, t As Long, lev As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: MaxSMP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                Call SetVariable(playerMem(theOne).smMaxVar$, str$(num2), theProgram)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                Call SetVariable(playerMem(theOne).smMaxVar$, str$(num2), theProgram)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        Call SetVariable(playerMem(theOne).smMaxVar$, str$(num2), theProgram)
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub MemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Mem (x,y,memloc)
    'scan tile from memory
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: Mem must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim redc As Long, greenc As Long, bluec As Long
    redc = getValue(useIt$, lit$, num1, theProgram)
    greenc = getValue(useIt2$, lit$, num2, theProgram)
    bluec = getValue(useIt3$, lit$, num3, theProgram)
    'If redc = 1 Or greenc = 1 Or bluec = 1 Then
    '    Call debugger("Error: Mem data type must be numerical!-- " + text$)
    'Else
        Dim x As Double, y As Double, memLoc As Long
        x = num1
        y = num2
        memLoc = num3
        memLoc = inBounds(memLoc, 0, UBound(cnvRPGCodeBuffers))
        Call Canvas2CanvasBltPartial(cnvRPGCodeBuffers(memLoc), cnvRPGCodeScreen, _
                                    x * 32 - 32, y * 32 - 32, _
                                    0, 0, _
                                    32, 32, SRCCOPY)
        'Call renderRPGCodeScreen
        DXDrawCanvasPartial cnvRPGCodeScreen, _
                            x * 32 - 32, y * 32 - 32, _
                            x * 32 - 32, y * 32 - 32, _
                            32, 32
        DXRefresh
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub menuGraphicRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MenuGraphic("file.gif")
    'internal menu background graphic.
    On Error Resume Next
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: MenuGraphic has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: MenuGraphic data type must be literal!-- " + Text$)
    Else
        menuGraphic$ = lit$
    End If
End Sub

Sub MidiPlayRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MidiPlay("filename.mid")
    'or
    '#PlayMidi("filename.mid")
    'or
    '#MediaPlay("media")
    'Play multimedia
    On Error GoTo errorhandler

    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: MediaPlay has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: MediaPlay has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: MediaPlay data type must be literal!-- " + Text$)
    Else
        boardList(activeBoardIndex).theData.boardMusic$ = lit$
        DoEvents
        Dim oi As Boolean
        oi = bWaitingForInput
        bWaitingForInput = False
        Call checkMusic
        bWaitingForInput = oi
        DoEvents
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub MidiRestRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MidiRest()
    'or
    '#MediaStop
    'Stops media
    On Error GoTo errorhandler
    boardList(activeBoardIndex).theData.boardMusic$ = ""
    DoEvents
    Dim oi As Boolean
    oi = bWaitingForInput
    bWaitingForInput = False
    Call checkMusic
    bWaitingForInput = oi
    DoEvents

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub mouseClickRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'MouseClick(x!,y!, [noWait!])
    'waits for mouse click and returns
    'coords

    ' ! MODIFIED BY KSNiloc
    
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 3 Then
        Call debugger("Error: MouseClick must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String
    'var1$ = GetElement(dataUse$, 1)
    'var2$ = GetElement(dataUse$, 2)
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    var1 = paras(0).dat
    var2 = paras(1).dat
    
    Dim mx As Long
    Dim my As Long
    
    If paras(2).num <> 1 Then
        getMouse mx, my
    Else
        getMouseNoWait mx, my
    End If
    
    Call SetVariable(var1$, str$(mx), theProgram)
    Call SetVariable(var2$, str$(my), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub mouseMoveRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MouseMove(x!,y!)
    'waits for mouse movement and returns
    'coords
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: MouseMove must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    
    Dim mx As Long
    Dim my As Long
    Call getMouseMove(mx, my)
    
    Call SetVariable(var1$, str$(mx), theProgram)
    Call SetVariable(var2$, str$(my), theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub MoveRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Move(x,y)
    'Moves current program to x,y
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    
    Dim useitX As String, useitY As String, useitL As String
    useitX$ = GetElement(dataUse$, 1)
    useitY$ = GetElement(dataUse$, 2)
    useitL$ = GetElement(dataUse$, 3)

    If num < 3 Then useitL$ = "1"
    
    If useitX$ = "" Or useitY$ = "" Or useitL$ = "" Then
        Call debugger("Error: Move has no data element!-- " + Text$)
        Exit Sub
    End If
    Dim ax As Long, ay As Long, al As Long, numx As Double, numy As Double, numl As Double
    Dim litx As String, lity As String, litl As String
    ax = getValue(useitX$, litx$, numx, theProgram)
    ay = getValue(useitY$, lity$, numy, theProgram)
    al = getValue(useitL$, litl$, numl, theProgram)
    If ax = 1 Or ay = 1 Or al = 1 Then
        Call debugger("Error: Move data type must be numerical!-- " + Text$)
    Else
        If theProgram.boardNum >= 0 Then
            boardList(activeBoardIndex).theData.progX(theProgram.boardNum) = numx
            boardList(activeBoardIndex).theData.progY(theProgram.boardNum) = numy
            boardList(activeBoardIndex).theData.progLayer(theProgram.boardNum) = numl
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Mp3PauseRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Mp3Pause ("filename.wav/mp3")
    'Play wav or mp3 file (pauses game while playing mp3)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Mp3Pause has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Mp3Pause data type must be literal!-- " + Text$)
    Else
        Dim ext As String
        ext$ = GetExt(lit$)
        dataUse$ = projectPath$ & mediaPath$ & lit$
        dataUse$ = PakLocate(dataUse$)
        Call playSoundFX(dataUse$)
        Do While (TKAudiereIsPlaying(fgDevice) = 1)
            DoEvents
        Loop
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub MWinClsRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MWinCls()
    'Clear message win.
    On Error GoTo errorhandler
    lineNum = 1
    
    Call hideMsgBox
    Call renderRPGCodeScreen
    
    DoEvents

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Function MWinPrepare(ByVal Text As String, ByRef prg As RPGCodeProgram) As String
    'Replace variables in <>s with their respective values
    On Error Resume Next
    Dim firstLocation As Long
    firstLocation = InStr(1, Text, "<")
    If firstLocation > 0 Then
        Dim secondLocation As Long
        secondLocation = InStr(1, Text, ">")
        If secondLocation > 0 Then
            Dim theVar As String
            theVar = Mid(Text, firstLocation + 1, secondLocation - firstLocation - 1)
            Dim cLine As String
            cLine = "(" & theVar & ")"
            Dim value() As parameters
            value() = GetParameters(cLine, prg)
            Dim theValue As String
            If value(0).dataType <> DT_NUM Then
                theValue = value(0).lit
            Else
                theValue = CStr(value(0).num)
            End If
            Text = replace(Text, "<" & theVar & ">", theValue)
            MWinPrepare = MWinPrepare(Text, prg)
            Exit Function
        End If
    End If
    MWinPrepare = Text
End Function

Public Sub MWinRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)
    'MWin(text$)
    'Add to the message box
    If CountData(Text) <> 1 Then
        Call debugger(" MWin() requires one data element-- " & Text)
    End If
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    paras(0).dat = replaceOutsideQuotes(paras(0).dat, Chr(34), "")
    Call AddToMsgBox(MWinPrepare(paras(0).dat, theProgram), theProgram)
End Sub

Sub MWinSizeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#MWinSize(size!)
    'changes message window size.
    'size! is a percentage of the screen width
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: CharacterSpeed has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: CharacterSpeed data type must be numerical!-- " + Text$)
    Else
        num = inBounds(num, 10, 100)
        MWinSize = num
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub NewPlyr(Text$, ByRef theProgram As RPGCodeProgram)
    On Error Resume Next
    '#Newplyr("name.cha/gph/tem")
    'Change active player graphic
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: NewPlyr has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: NewPlyr has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: NewPlyr data type must be literal!-- " + Text$)
    Else
        Dim ee As String
        lit$ = addExt(lit$, ".tem")
        newPlyrName = lit$
        ee$ = GetExt(lit$)
        Dim anm As TKAnimation
        Dim tbm As TKTileBitmap
        Select Case UCase$(ee$)
            Case "GPH":
                'Get graphics from a GPH file
                'REST GFX
                Call TileBitmapClear(tbm)
                Call TileBitmapResize(tbm, 1, 1)
                Call AnimationClear(anm)
                anm.animSizeX = 32: anm.animSizeY = 32
                tbm.tiles(0, 0) = lit$
                
                Dim tbmName As String, anmName As String, file As String
                tbmName$ = replace(RemovePath(lit$), ".", "_") + "_newplyr" + ".tbm"
                Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbm)
                anm.animFrame(0) = tbmName$
                anmName$ = replace(RemovePath(file$), ".", "_") + "_newplyr" + ".anm"
                Call saveAnimation(projectPath$ + miscPath$ + anmName$, anm)
                playerMem(selectedPlayer).gfx(PLYR_WALK_N) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_S) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_E) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_W) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_NE) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_NW) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_SE) = anmName$
                playerMem(selectedPlayer).gfx(PLYR_WALK_SW) = anmName$
            
            Case "TEM":
                'Get graphics from TEM file
                num = FreeFile
                file$ = projectPath$ & temPath$ & lit$
                file$ = PakLocate(file$)
                Dim tempPlyr As TKPlayer
                Call openchar(file$, tempPlyr)
                Dim t As Long, sz As Long
                For t = 0 To UBound(tempPlyr.gfx)
                    playerMem(selectedPlayer).gfx(t) = tempPlyr.gfx(t)
                Next t
                
                sz = UBound(tempPlyr.customGfx)
                ReDim playerMem(selectedPlayer).customGfx(sz)
                ReDim playerMem(selectedPlayer).customGfxNames(sz)
                For t = 0 To UBound(tempPlyr.customGfx)
                    playerMem(selectedPlayer).customGfx(t) = tempPlyr.customGfx(t)
                    playerMem(selectedPlayer).customGfxNames(t) = tempPlyr.customGfxNames(t)
                Next t
        End Select
    End If
End Sub


Sub Over(ByRef theProgram As RPGCodeProgram)
    '#Over()
    'Game over
    On Error GoTo errorhandler
    Call gameOver

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PathFindRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #PathFind (x1!, y1!, x2!, y2!, dest$ [, layer!])
    'find the shortest walkable path between two points on the board, and return it
    'as a string in dest$
    'if no layer specified, the player's current layer is assumed.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 5 And number <> 6 Then
        Call debugger("Error: PathFind must have 5 or 6 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, useIt6 As String, num4 As Double, num5 As Double, num6 As Double
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    If number = 6 Then useIt6$ = GetElement(dataUse$, 6) Else useIt6$ = toString(ppos(selectedPlayer).l)
    
    Dim e1 As Long, e2 As Long, e3 As Long, e4 As Long, e5 As Long, e6 As Long
    Dim lit4 As String, lit5 As String, lit6 As String
    e1 = getValue(useIt1$, lit1$, num1, theProgram)
    e2 = getValue(useIt2$, lit2$, num2, theProgram)
    e3 = getValue(useIt3$, lit3$, num3, theProgram)
    e4 = getValue(useIt4$, lit4$, num4, theProgram)
    e5 = getValue(useIt5$, lit5$, num5, theProgram)
    e6 = getValue(useIt6$, lit6$, num6, theProgram)
    If e1 = 1 Or e2 = 1 Or e3 = 1 Or e4 = 1 Or e5 = 0 Or e6 = 1 Then
        Call debugger("Error: PathFind data type must be num, num, num, num, lit [, num]!-- " + Text$)
        Exit Sub
    End If
    
    num1 = inBounds(num1, 1, boardList(activeBoardIndex).theData.Bsizex)
    num2 = inBounds(num2, 1, boardList(activeBoardIndex).theData.Bsizey)
    num3 = inBounds(num3, 1, boardList(activeBoardIndex).theData.Bsizex)
    num4 = inBounds(num4, 1, boardList(activeBoardIndex).theData.Bsizey)
    num6 = inBounds(num6, 1, boardList(activeBoardIndex).theData.Bsizel)

    Dim p As String
    p$ = PathFind(num1, num2, num3, num4, num6, False, True)
    Call SetVariable(useIt5$, p$, theProgram)
    retval.dataType = DT_LIT
    retval.lit = p$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PlayAviRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#PlayAvi(file$)
    'plays avi (full screen)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: PlayAvi has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: PlayAvi has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: PlayAvi data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".avi")
        lit$ = projectPath$ + mediaPath$ + lit$
        lit$ = PakLocate(lit$)
        'KSNiloc...
        Dim oldMusic As String
        oldMusic = musicPlaying
        boardList(activeBoardIndex).theData.boardMusic = ""
        Call checkMusic(True)
        Call playVideo(lit)
        boardList(activeBoardIndex).theData.boardMusic = oldMusic
        Call checkMusic(True)
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PlayAviSmallRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#PlayAviSmall(file$)
    'plays avi (windowed)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: PlayAviSmall has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: PlayAviSmall has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: PlayAviSmall data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".avi")
        lit$ = projectPath$ + mediaPath$ + lit$
        lit$ = PakLocate(lit$)
        Call playVideo(lit, True)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PostureRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Posture(0-9[,handle$])
    'show player posture, assumed to be
    'default if not specified.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    If number = 1 Then useIt2$ = playerListAr$(selectedPlayer)
    Dim b As Long, theOne As Long, t As Long
    a = getValue(useIt$, lit$, num, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = 1 Or b = 0 Then
        Call debugger("Error: Posture data type must be num, lit!-- " + Text$)
    Else
        theOne = -1
        lit2$ = FindPlayerHandle(lit2$)
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit2$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = target
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'MsgBox Str$(theone)
        'MsgBox Str$(num) + text$
        num = inBounds(num, 0, 9)
        ppos(theOne).stance = "Custom " + toString(num)
        Call renderNow
        Call CanvasGetScreen(cnvRPGCodeScreen)
        Call renderRPGCodeScreen
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub prg(Text$, ByRef theProgram As RPGCodeProgram)
    '#Prg(prgnum!,x!,y!,layer!)
    'or #Prg(prgname$,x!,y!,layer!)
    'Move program
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?

    Dim useIt4 As String, num4 As Double, pnum As Long, ax As Long, ay As Long, al As Long
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    If number = 3 Then useIt4$ = "1"

    pnum = getValue(useIt1$, lit1$, num1, theProgram)
    ax = getValue(useIt2$, lit$, num2, theProgram)
    ay = getValue(useIt3$, lit$, num3, theProgram)
    al = getValue(useIt4$, lit$, num4, theProgram)
    Dim theOne As Long, t As Long
    If pnum = 1 Then
        'user inputted a filename.
        theOne = -1
        lit1$ = addExt(lit1$, ".prg")
        For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
            If UCase$(boardList(activeBoardIndex).theData.programName$(t)) = UCase$(lit1$) Then
                theOne = t
                t = UBound(boardList(activeBoardIndex).theData.programName)
            End If
        Next t
        If theOne = -1 Then
            Call debugger("Error: Prg filename not found!-- " + Text$)
            Exit Sub
        End If
        num1 = theOne
    End If
    If ax = 1 Or ay = 1 Or al = 1 Then
        Call debugger("Error: Prg data type must be numerical!-- " + Text$)
    Else
        boardList(activeBoardIndex).theData.progX(num1) = num2
        boardList(activeBoardIndex).theData.progY(num1) = num3
        boardList(activeBoardIndex).theData.progLayer(num1) = num3
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PrintRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Print("text")
    'puts text at current x and y pos.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Print has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Print has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        lit$ = str$(num)
    End If
    'replace <> w/vars
    lit$ = MWinPrepare(lit$, theProgram)
    Dim hdc As Long
    hdc = CanvasOpenHDC(cnvRPGCodeScreen)
    Call putText(lit$, textX, textY, fontColor, fontSize, fontSize, hdc)
    Call CNVCloseHDC(cnvRPGCodeScreen, hdc)
    'Call renderRPGCodeScreen
    DXDrawCanvasPartial cnvRPGCodeScreen, _
                        textX, textY, textX, textY, _
                        GetCanvasWidth(cnvRPGCodeScreen) - textX, fontSize * (Len(lit) * 2 + 10)
    DXRefresh
    textY = textY + 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Prompt(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #Prompt("Question>"[,var!$])
    'Prompts user
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number > 2 Then
        Call debugger("Error: Prompt must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    If number = 2 Then
        Dim aa As Long, ans As String
        useIt2$ = GetElement(dataUse$, 2)
        aa = getValue(useIt1$, lit$, num1, theProgram)
        'ans$ = InputBox$(lit$, LoadStringLoc(871, "Please Enter an Answer"))
        ans$ = ShowPromptDialog(LoadStringLoc(871, "Please Enter an Answer"), lit$)
        Call SetVariable(useIt2$, ans$, theProgram)
        retval.dataType = DT_LIT
        retval.lit = ans$
    Else
        useIt2$ = GetElement(dataUse$, 2)
        aa = getValue(useIt1$, lit$, num1, theProgram)
        'ans$ = InputBox$(lit$, LoadStringLoc(871, "Please Enter an Answer"))
        ans$ = ShowPromptDialog(LoadStringLoc(871, "Please Enter an Answer"), lit$)
        retval.dataType = DT_LIT
        retval.lit = ans$
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PushItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'REWRITTEN: [Isometrics - Delano - 18/04/04]
    'Rewritten to accept diagonal directions (for both board types).
    'Renamed variables: inum >> itemNum
    '                   b,a >> parameter1Type,parameter2Type
    '                   dirpush$ >> directionString$
    'Removed variables: t
    
    'NEW SYNTAX:
        'All directions should be separated by a comma, but we can recover if they are not.
        'Direction types can be mixed, e.g. "N,SOUTH,2,NE" will work.
        'White space is allowed, and capitalisation is not required, e.g. " n, w , east " will work.
        'Debugger is called for old syntax, e.g. "NESW" will NOT work.
    '#PushItem(itemnum!,"N,S,E,W,NE,NW,SE,SW")
    '#PushItem(itemnum!,"NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST")
    '#PushItem(itemnum!,"1,2,3,4,5,6,7,8")
    
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)        'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    If number <> 2 Then
        Call debugger("Error: PushItem must have 2 data elements!-- " + Text$)
    End If
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    
    Dim parameter1Type As Long, parameter2Type As Long, itemNum As Long
    
    'Get the variable types of the two parameters, and their values.
    parameter1Type = getValue(useIt1$, lit1$, num1, theProgram)
    parameter2Type = getValue(useIt2$, lit2$, num2, theProgram)
    
    If parameter1Type = 1 Then
        'If 1st parameter [itemnum!] is literal...
        
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 1 Then itemNum = target
            
        ElseIf UCase$(lit1$) = "SOURCE" Then
            If sourceType = 1 Then itemNum = Source
            
        Else
            'Not something we want.
            Call debugger("Error: PushItem data type must be num, lit!-- " + Text$)
            Exit Sub
        End If
        
    End If
   
    If parameter2Type = 0 Then
        'If 2nd parameter [directionString$] is numerical.
        
        Call debugger("Error: PushItem data type must be num, lit!-- " + Text$)
        Exit Sub
    End If
   
    Dim direction As Integer, directionArray() As String, directionString As String, element As Integer
    
    itemNum = num1 '[itemNum!]
    directionString$ = UCase$(lit2$) '[directionString$]
    
    'cbm: Do not require comma delimited inputs (for backwards compatibility)
    directionString$ = formatDirectionString(directionString$)
    
    'Split the string into an array of directions, using "," as the delimiter.
    directionArray = Split(directionString$, ",")
    
    'Loop over each direction.
    For element = 0 To UBound(directionArray)
    
        'Trim any white space off the letters.
        directionArray(element) = Trim(directionArray(element))
    
        Select Case directionArray(element)
        
            Case "NORTH", "N", "1": direction = 1
            Case "SOUTH", "S", "2": direction = 2
            Case "EAST", "E", "3": direction = 3
            Case "WEST", "W", "4": direction = 4
            Case "NORTHEAST", "NE", "5": direction = 5
            Case "NORTHWEST", "NW", "6": direction = 6
            Case "SOUTHEAST", "SE", "7": direction = 7
            Case "SOUTHWEST", "SW", "8": direction = 8
            Case Else:
                'Could be a string like "NESWNESW", or just another character
                direction = 0 'Idle
                Call debugger("Error: PushItem has been updated, use the form ""N,E,S,W,NE,NW,SE,SW""!-- " + directionString$)
                        
        End Select
            
        pendingItemMovement(itemNum).direction = direction
        pendingItemMovement(itemNum).xOrig = itmPos(itemNum).x
        pendingItemMovement(itemNum).yOrig = itmPos(itemNum).y
        pendingItemMovement(itemNum).lOrig = itmPos(itemNum).l
        Call insertTarget(pendingItemMovement(itemNum))
        
        movementCounter = 0
        If isMultiTasking() Then
            'if multitasking, let the mainloop take care of this
            gGameState = GS_MOVEMENT
        Else
            'if running a regular program, move the sprite now

            ' ! MODIFIED BY KSNiloc...
            Dim oMS As Long
            oMS = movementSize
            movementSize = 1
            Call runQueuedMovements
            movementSize = oMS
        End If
    
    Next element
            
    Exit Sub

'Begin error handling code:
errorhandler:

    Call HandleError
    Resume Next
    
End Sub

Sub PushRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '=================================================
    'REWRITTEN: [Isometrics - Delano - 30/04/04]
    'Rewritten to accept diagonal directions (for both board types).
    'Renamed variables: a,b >> parameter1Type,parameter2Type
    '                   dirpush$ >> directionString$
    '                   t >> playerNum
    '                   theOne >> handleNum
    '                   lit1,lit2 >> dirInput, handleName
    'Removed excess variables.
    '=================================================
    
    'NEW SYNTAX:
        'All directions should be separated by a comma, but we can recover if they are not.
        'Direction types can be mixed, e.g. "N,SOUTH,2,NE" will work.
        'White space is allowed, and capitalisation is not required, e.g. " n, w , east " will work.
        'Debugger is called for old syntax, e.g. "NESW" will NOT work.
    '#Push("N,S,E,W,NE,NW,SE,SW" [,handle$])
    '#Push("NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST" [,handle$])
    '#Push("1,2,3,4,5,6,7,8" [,handle$])

    
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String, dirInput As String, handleName As String, num1 As Double, num2 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)        'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    
    'If optional player handle omitted, use the selected player.
    If number = 1 Then useIt2$ = playerListAr$(selectedPlayer)
    
    Dim handleNum As Long, parameter1Type As Long, parameter2Type As Long, playerNum As Long
    
    'Get the variable types of the two parameters, and their values.
    parameter1Type = getValue(useIt1$, dirInput$, num1, theProgram)
    parameter2Type = getValue(useIt2$, handleName$, num2, theProgram)
    
    If parameter1Type = 0 Or parameter2Type = 0 Then
        'If either parameter is numerical.
        Call debugger("Error: Push data type must be literal!-- " + Text$)
        Exit Sub
    End If
    
    'Test that the text handle (handleName$) is a valid player name, and get the corresponding
    'player number and put it in handle number.
    handleNum = -1
    
    For playerNum = 0 To 4
        
        'Loop over the valid player handles and check if they exist.
        If UCase$(playerListAr$(playerNum)) = UCase$(handleName$) Then handleNum = playerNum
        
    Next playerNum
    
    If UCase$(handleName$) = "TARGET" Then
        If targetType = 0 Then handleNum = target

    End If
    If UCase$(handleName$) = "SOURCE" Then
        If sourceType = 0 Then handleNum = Source

    End If
    
    If handleNum = -1 Then
        'If handleNum has not changed up til now, player handle not found.
        Exit Sub
    End If
    
    Dim direction As Integer, directionArray() As String, directionString As String, element As Integer
    
    directionString$ = UCase$(dirInput$) '[directionString$]
    
    'cbm: Do not require comma delimited inputs (for backwards compatibility)
    directionString$ = formatDirectionString(directionString$)
        
    'Split the string into an array of directions, using "," as the delimiter.
    directionArray = Split(directionString$, ",")
    
    ' ! ADDED BY KSNiloc...
    Dim oMS As Long
    oMS = movementSize
    movementSize = 1
    
    'Loop over each direction.
    For element = 0 To UBound(directionArray)
    
        'Trim any white space off the letters.
        directionArray(element) = Trim(directionArray(element))
    
        Select Case directionArray(element)
        
            Case "NORTH", "N", "1": direction = 1
            Case "SOUTH", "S", "2": direction = 2
            Case "EAST", "E", "3": direction = 3
            Case "WEST", "W", "4": direction = 4
            Case "NORTHEAST", "NE", "5": direction = 5
            Case "NORTHWEST", "NW", "6": direction = 6
            Case "SOUTHEAST", "SE", "7": direction = 7
            Case "SOUTHWEST", "SW", "8": direction = 8
            Case Else:
                'Could be a string like "NESWNESW", or just another character
                direction = 0 'Idle
                Call debugger("Error: Push has been updated, use the form ""N,E,S,W,NE,NW,SE,SW""!-- " + directionString$)
                        
        End Select
        
        pendingPlayerMovement(handleNum).direction = direction
        pendingPlayerMovement(handleNum).xOrig = ppos(handleNum).x
        pendingPlayerMovement(handleNum).yOrig = ppos(handleNum).y
        pendingPlayerMovement(handleNum).lOrig = ppos(handleNum).l
        Call insertTarget(pendingPlayerMovement(handleNum))
        
        movementCounter = 0
        If isMultiTasking() Then
            'if multitasking, let the mainloop take care of this
            gGameState = GS_MOVEMENT
        Else
            'if running a regular program, move the sprite now
            Call runQueuedMovements
        End If
    
    Next element

    ' ! ADDED BY KSNiloc...
    movementSize = oMS
    
    Exit Sub
    
'Begin error handling code:
errorhandler:

    Call HandleError
    Resume Next
    
End Sub

Sub PutItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'EDITED: [Isometrics - Delano - 28/04/04]
    'Added code to update the pendingPlayer movements when the player is placed - prevents jumping.

    '#PutItem(number!,x,y,layer)
    'puts an item on the screen.
    
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim useIt4 As String, num4 As Double, ah As Long, ax As Long, ay As Long, al As Long, theOne As Long, lit4 As String
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    
    'If layer not supplied, then use the current player's layer.
    If number = 3 Then useIt4$ = str$(ppos(selectedPlayer).l)
    
    ah = getValue(useIt1$, lit1$, num1, theProgram)
    ax = getValue(useIt2$, lit2$, num2, theProgram)
    ay = getValue(useIt3$, lit3$, num3, theProgram)
    al = getValue(useIt4$, lit4$, num4, theProgram)
    
    If ah = 1 Or ax = 1 Or ay = 1 Or al = 1 Then
        Call debugger("Error: PutItem data must be num,num,num,num!-- " + Text$)
        Exit Sub
    End If
    
    'This assumes the supplied item number is valid!
    theOne = num1
    
    itmPos(theOne).x = num2
    itmPos(theOne).y = num3
    itmPos(theOne).l = num4
    itmPos(theOne).stance = "WALK_S"
    itmPos(theOne).frame = 0
    itemMem(theOne).bIsActive = True
    
    'Isometric addition: jumping fix for moving to new boards
    pendingItemMovement(theOne).xOrig = itmPos(theOne).x
    pendingItemMovement(theOne).yOrig = itmPos(theOne).y
    pendingItemMovement(theOne).xTarg = itmPos(theOne).x
    pendingItemMovement(theOne).yTarg = itmPos(theOne).y
    
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PutPlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '======================================
    'EDITED: [Isometrics - Delano 3/05/04]
    'Added code to update the pendingPlayer movements when the player is placed - prevents jumping.
    'Added code to align board to new co-ordinates.
    'Renamed variables: t >> playerNum
    '                   lit1$ >> handleName
    '                   num2,num3,num4 >> targetX,targetY,targetL
    'Removed unneeded variables.
    '======================================
        
    '#PutPlayer(handle$, x!, y!, layer!)
    'Put a player somewhere on the current board.
    'Doesn't check if target tile is solid!
        
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String, useIt3 As String, useIt4 As String
    Dim handeName As String, lit As String, num1 As Double, targetX As Double, targetY As Double, targetL As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)        'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim parameter1Type As Long, parameter2Type As Long, parameter3Type As Long, parameter4Type As Long
    Dim theOne As Long 'Handle number.
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    
    'If layer not supplied, then use the current player's layer.
    If number = 3 Then useIt4$ = str$(ppos(selectedPlayer).l)
    
    'Literals not needed for 2-4:
    parameter1Type = getValue(useIt1$, handeName$, num1, theProgram)
    parameter2Type = getValue(useIt2$, lit$, targetX, theProgram)
    parameter3Type = getValue(useIt3$, lit$, targetY, theProgram)
    parameter4Type = getValue(useIt4$, lit$, targetL, theProgram)
    
    If parameter1Type = 0 Or parameter2Type = 1 Or parameter3Type = 1 Or parameter4Type = 1 Then
        'Check the RPG variable types.
        Call debugger("Error: PutPlayer data must be lit,num,num,num!-- " + Text$)
        Exit Sub
    End If
        
    'Test that the text handle (handeName$) is a valid player name, and get the corresponding
    'player number and put it in handle.
    theOne = -1
    
    Dim playerNum As Integer
    
    For playerNum = 0 To 4
    
        'Loop over the valid player handles and check if they exist.
        If UCase$(playerListAr$(playerNum)) = UCase$(handeName$) Then theOne = playerNum
    
    Next playerNum
    
    If UCase$(handeName$) = "TARGET" Then
        If targetType = 0 Then
            theOne = target
        End If
    End If
    If UCase$(handeName$) = "SOURCE" Then
        If sourceType = 0 Then
            theOne = Source
        End If
    End If
    
    If theOne = -1 Then
        'If handle has not changed up til now, player handle not found.
        Exit Sub
    End If
    
    'Else, the player exists and we can place him:
    
    ppos(theOne).x = targetX
    ppos(theOne).y = targetY
    ppos(theOne).l = targetL
    showPlayer(theOne) = True
    
    'Isometric fix:
    pendingPlayerMovement(theOne).xOrig = ppos(theOne).x
    pendingPlayerMovement(theOne).yOrig = ppos(theOne).y
    pendingPlayerMovement(theOne).xTarg = ppos(theOne).x
    pendingPlayerMovement(theOne).yTarg = ppos(theOne).y
    
    Call alignBoard(targetX, targetY)
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    Call renderRPGCodeScreen


    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub PutRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Put(x!,y!,"graphic.gph")
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: Put must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim ax As Long, ay As Long, ag As Long
    ax = getValue(useIt1$, lit$, num1, theProgram)
    ay = getValue(useIt2$, lit$, num2, theProgram)
    ag = getValue(useIt3$, lit1$, num3, theProgram)
    If ax = 1 Or ay = 1 Or ag = 0 Then
        Call debugger("Error: Put data must be numeric, numeric, literal!-- " + Text$)
    Else
        Select Case boardList(activeBoardIndex).theData.ambienteffect
            Case 0
                addonR = 0
                addonG = 0
                addonB = 0
            Case 1
                addonR = 75
                addonG = 75
                addonB = 75
            Case 2
                addonR = -75
                addonG = -75
                addonB = -75
            Case 3
                addonR = 0
                addonG = 0
                addonB = 75
        End Select
        'internal engine drawing routines
        'first, get the shade color of the board...
        Dim l As String, shadeR As Double, shadeG As Double, shadeB As Double, lightShade As Long
        a = getVariable("AmbientRed!", l$, shadeR, theProgram)
        a = getVariable("AmbientGreen!", l$, shadeG, theProgram)
        a = getVariable("AmbientBlue!", l$, shadeB, theProgram)
        'now check day and night info...
        If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
            lightShade = DetermineLightLevel()
            shadeR = shadeR + lightShade
            shadeG = shadeG + lightShade
            shadeB = shadeB + lightShade
        End If
        
        addonR = addonR + shadeR
        addonG = addonG + shadeG
        addonB = addonB + shadeB
        
        Dim file As String, hdc As Long
        file$ = addExt(lit1$, ".gph")
        file$ = projectPath$ & tilePath$ & file$
        Call drawTileCNV(cnvRPGCodeScreen, file$, num1, num2, addonR, addonG, addonB, False)
        'Call renderRPGCodeScreen
        
        ' ! MODIFIED BY KSNiloc...
        
        Dim x As Long: x = num1
        Dim y As Long: y = num2
        DXDrawCanvasPartial cnvRPGCodeScreen, _
                            x * 32 - 32, y * 32 - 32, _
                            x * 32 - 32, y * 32 - 32, _
                            32, 32
        DXRefresh
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub RandomRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #Random(1200[,dest!])
    'Put a random number in dest!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: Random requires 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim ceiling As Double, Top As Long, aa As Long
    Top = getValue(useIt1$, lit$, ceiling, theProgram)
    If Top = 1 Then
        Call debugger("Error: Random data type must be numerical!-- " + Text$)
    Else

        'Use the timer... [KSNiloc]
        Randomize Timer
    
        aa = Int(Rnd(1) * ceiling) + 1
        If number = 2 Then
            Call SetVariable(useIt2$, str$(aa), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = aa
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub RedirectRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Redirect("#Mwin", "#MyMwin")
    'redirect all input from one command into another
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 2 Then
        Call debugger("Error: Redirect must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim b As Long
    a = getValue(useIt1$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = 0 Or b = 0 Then
        Call debugger("Error: Redirect data type must be lit, lit!-- " + Text$)
    Else
        Call SetRedirect(lit1$, lit2$)
    End If
End Sub

Sub RemovePlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#RemovePlayer("file" or handle)
    'Remove player from party.
    'puts player in available list.
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: RemovePlayer has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: RemovePlayer has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: RemovePlayer data type must be literal!-- " + Text$)
    Else
        'ext$ = getext(lit$)
        lit$ = FindPlayerHandle(lit$)
        'find slot:
        Dim t As Long, oldHan As String, oldFile As String
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit$) Then
                oldHan$ = playerListAr$(t)
                oldFile$ = playerFile$(t)
                playerListAr$(t) = ""
                playerFile$(t) = ""
                t = 4
            End If
        Next t
        'now put this chacter in the old list...
        For t = 0 To 25
            If otherPlayersHandle$(t) = "" Then
                otherPlayersHandle$(t) = oldHan$
                otherPlayers$(t) = RemovePath(oldFile$)
                Exit Sub
            End If
        Next t
    End If
End Sub

Sub RemoveRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Remove("handle",body_location!)
    'Remove item from specified body location.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: Remove must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, bloc As Long, t As Long, theOne As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    bloc = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or bloc = 1 Then
        Call debugger("Error: Remove data type must be lit, num!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'OK, theone is the player to equip to.
        num2 = inBounds(num2, 1, 16)
        
        'Let's remove equip!
        Call removeEquip(num2, theOne)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub removeStatusRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#RemoveStatus("handle", "handle/filename.ste")
    'removes status effect to a player, or the target handle
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: RemoveStatus must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, filen As Long, ex As String, theHandle As String, theOne As Long, t As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    filen = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or filen = 0 Then
        Call debugger("Error: RemoveStatus requires lit, lit!-- " + Text$)
    Else
        theHandle$ = ""
        ex$ = GetExt(lit2$)
        If UCase$(ex$) = "STE" Then
            Call openStatus(projectPath$ + lit2$, statusMem)
            theHandle$ = statusMem.statusName$
        Else
            theHandle$ = lit2$
        End If
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                'player was targeted
                theOne = target
                Call PlayerRemoveStatus(lit2, playerMem(theOne))
                Call PlayerRemoveStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                Call EnemyRemoveStatus(lit2, enemyMem(theOne))
                Call EnemyRemoveStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).enemy)
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                'player was targeted
                theOne = Source
                Call PlayerRemoveStatus(lit2, playerMem(theOne))
                Call PlayerRemoveStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                Call EnemyRemoveStatus(lit2, enemyMem(theOne))
                Call EnemyRemoveStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).enemy)
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        Call PlayerRemoveStatus(lit2, playerMem(theOne))
        Call PlayerRemoveStatus(lit2, parties(PLAYER_PARTY).fighterList(theOne).player)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ResetRPG(ByRef theProgram As RPGCodeProgram)
    '#Reset
    'Resets the game
    On Error GoTo errorhandler
    Call DXClearScreen(0)
    Call DXRefresh
    
    Call EmptyRPG("", theProgram)
    Dim num As Long
    For num = 0 To 11
        ReDim program(num).program(100)
    Next num
    For num = 0 To 4
        playerListAr$(num) = ""
        playerFile$(num) = ""
    Next num
    For num = 0 To UBound(inv.item)
        inv.item(num).file = ""
        inv.item(num).handle = ""
        inv.item(num).number = 0
    Next num
    fightInProgress = False
    runningProgram = False
    'Call openMainFile(loadedMainFile$)
    Call setupMain
    Call runProgram(projectPath$ + prgPath$ + mainMem.startupPrg)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub RestorePlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#RestorePlayer("player.tem")
    'restores a player who was previously on the team.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: RestorePlayer has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: RestorePlayer has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: RestorePlayer data type must be literal!-- " + Text$)
    Else
        Dim slot As Long, t As Long
        lit$ = addExt(lit$, ".tem")
        'find empty slot:
        slot = -1
        For t = 0 To 4
            If playerListAr$(t) = "" Then slot = t: t = 4
        Next t
        If slot = -1 Then
            Call debugger("Error: RestorePlayer cannot add another member- Party is full!-- " + Text$)
            Exit Sub
        End If
        Call RestoreCharacter(projectPath$ + temPath$ + lit$, slot, True)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub RestoreScreenArrayRPG(ByVal Text As String, _
    ByRef theProgram As RPGCodeProgram)

    'RestoreScreenArray(pos!,[x1!, y1!, x2!, y2!, xdest!, ydest!])
    'Restores a screen saved into the array

    'Added by KSNiloc

    'Make sure the array is at least dimensioned!
    On Error GoTo notDimensioned
    Dim testArray As Long
    testArray = UBound(cnvRPGCode)

    'Get the parameters...
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    'Are they numerical?
    Dim a As Long
    For a = 0 To UBound(paras)
        If Not paras(a).dataType = DT_NUM Then
            debugger "RestoreScreenArray() requires numerical data element" _
                & "s-- " & Text
            Exit Sub
        End If
    Next a
    
    Select Case CountData(Text)
    
        Case 1, 7
        
            'Is there a screen saved in the specified position?
            On Error GoTo noArrayElement
            If cnvRPGCode(paras(0).num) = 0 Then Err.Raise 0
            
            'Backup what may be in the non-array slot...
            Dim backupRPGCodeAccess As Long
            backupRPGCodeAccess = cnvRPGCodeAccess
            
            'Put the 'new' data in...
            cnvRPGCodeAccess = cnvRPGCode(paras(0).num)
            
            'Create parameters for RestoreScreen()...
            Dim createParas As String
            For a = 1 To UBound(paras)
                createParas = createParas & CStr(paras(a).num)
                If Not a = UBound(paras) Then
                    createParas = createParas & ","
                End If
            Next a

            'Restore the screen!
            RestoreScreenRPG "#RestoreScreen(" & createParas & ")", theProgram
            
            'Restore from the backup...
            cnvRPGCodeAccess = backupRPGCodeAccess
        
        Case Else
            debugger "RestoreScreenArray() requires either one or seven dat" _
            & "a elements-- " & Text
            Exit Sub
    
    End Select

Exit Sub

notDimensioned:
    debugger "RestoreScreenArray()- no arrayed screens saved"
    Exit Sub

noArrayElement:
    debugger "No screen saved in position " & CStr(paras(0).num) & "-- " & Text
    Exit Sub
    
End Sub

Sub RestoreScreenRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#RestoreScreen([x1!, y1!, x2!, y2!, xdest!, ydest!])
    'restore the screen from the rpgcodebuffer buffer
    'optionally specify source and dest coords
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num > 6 Then
        Call debugger("Error: RestoreScreen needs 0 or 6 data element!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, useIt6 As String, x1 As Double, y1 As Double, x2 As Double, y2 As Double, xd As Double, yd As Double
    Dim xx1 As Long, yy1 As Long, xx2 As Long, yy2 As Long, sx As Long, sy As Long
    If num = 6 Then
        useIt1$ = GetElement(dataUse$, 1)
        useIt2$ = GetElement(dataUse$, 2)
        useIt3$ = GetElement(dataUse$, 3)
        useIt4$ = GetElement(dataUse$, 4)
        useIt5$ = GetElement(dataUse$, 5)
        useIt6$ = GetElement(dataUse$, 6)
    Else
        useIt1$ = "0"
        useIt2$ = "0"
        useIt3$ = str$(tilesX * 32)
        useIt4$ = str$(tilesY * 32)
        useIt5$ = "0"
        useIt6$ = "0"
    End If
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    xx2 = getValue(useIt3$, lit$, x2, theProgram)
    yy2 = getValue(useIt4$, lit$, y2, theProgram)
    sx = getValue(useIt5$, lit$, xd, theProgram)
    sy = getValue(useIt6$, lit$, yd, theProgram)
    If xx1 = 1 Or yy1 = 1 Or xx2 = 1 Or yy2 = 1 Or sx = 1 Or sy = 1 Then
        Call debugger("Error: RestoreScreen requires numeriacal elements!-- " + Text$)
        Exit Sub
    End If
        
    Call Canvas2CanvasBltPartial(cnvRPGCodeAccess, cnvRPGCodeScreen, _
                                xd, yd, _
                                x1, y1, _
                                (x2 - x1), (y2 - y1))

    Call renderRPGCodeScreen
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ReturnMethodRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ReturnMethod(var!)
    'Returns value from method.
    'if var! is not referenced in the argument list
    'then the value becomes the return value for the current
    'method
    
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    dataUse$ = GetBrackets(Text$)
    'Now look for this variable in the pointer list
    Dim foundIt As Long, t As Long, aa As Long, datu As String
    foundIt = -1
    For t = 1 To 100
        If UCase$(pointer$(t)) = UCase$(dataUse$) Then
            foundIt = 1
            aa = getVariable(pointer$(t), lit$, num, theProgram)
            If aa = 0 Then
                datu$ = str$(num)
            
                methodReturn.dataType = DT_NUM
                methodReturn.num = num
            
            Else
                datu$ = lit$
            
                methodReturn.dataType = DT_LIT
                methodReturn.lit = lit$
            
            End If
            'go to previous stack...
            theProgram.currentHeapFrame = theProgram.currentHeapFrame - 1
            Call SetVariable(correspPointer$(t), datu$, theProgram)
            theProgram.currentHeapFrame = theProgram.currentHeapFrame + 1
        End If
    Next t
    If foundIt = -1 Then
        'it wasn't found in the argument list
        'thus, put it in the return value
        'Call debugger("Error: ReturnMethod variable not found!--" + text$)
        
        aa = getValue(dataUse$, lit$, num, theProgram)
        If aa = 0 Then
            methodReturn.dataType = DT_NUM
            methodReturn.num = num
        Else
            methodReturn.dataType = DT_LIT
            methodReturn.lit = lit$
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ReturnRPG(ByRef theProgram As RPGCodeProgram)
    '#Return()
    'Refresh screen
    On Error GoTo errorhandler
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub RPGCodeRPG(ByVal Text As String, _
    ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)

    'RPGCode(command$)
    'Runs an RPGCode command

    '========================================================================
    'Bug fix by KSNiloc
    '========================================================================

    If Not CountData(Text) = 1 Then
        debugger "RPGCode() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    If Not paras(0).dataType = DT_LIT Then
        debugger "RPGCode() requires a literal data element-- " & Text
        Exit Sub
    End If
    
    Dim tempPRG As RPGCodeProgram
    Dim ff As Long
    Dim a As Long

    Dim line As String
    line = paras(0).lit

    'Maybe it doesn't need parsing...
    If _
         (Not stringContains(line, "{")) _
         And (Not stringContains(line, "}")) _
         And (Not stringContains(line, "# ")) _
                                                Then
                                                
        Dim oPP As Long
        oPP = theProgram.programPos
        DoSingleCommand line, theProgram, retval
        theProgram.programPos = oPP
        Exit Sub
             
    End If

    'It needs parsing...
    ff = FreeFile
    Open App.path & "\tempPRG" For Output As #ff
        Print #ff, line
    Close #ff
    openProgram App.path & "\tempPRG", tempPRG
    Kill App.path & "\tempPRG"
    
    'Enlarge the program...
    ReDim Preserve theProgram.program _
        (UBound(theProgram.program) + UBound(tempPRG.program) + 1)
    
    'Knock all lines past the current position forward...
    For a = UBound(theProgram.program) - UBound(tempPRG.program) - 1 To _
        theProgram.programPos - 1 Step -1
        theProgram.program(a + UBound(tempPRG.program) + 1) = _
            theProgram.program(a)
    Next a
    
    'Pump in the line sent to this command...
    For a = 0 To UBound(tempPRG.program)
        theProgram.program(theProgram.programPos + 1 + a) = _
            tempPRG.program(a)
    Next a
    
    '========================================================================
    'End bug fix by KSNiloc
    '========================================================================

    '========================================================================
    'Commenting by KSNiloc
    '========================================================================

    'On Error GoTo errorhandler
    'Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: RPGCode has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'If useIt$ = "" Then
    '    Call debugger("Error: RPGCode has no data element!-- " + text$)
    '    Exit Sub
    'End If
    'a = GetValue(useIt$, lit$, num, theProgram)
    'If a = 0 Then
    '    lit$ = str$(num)
    'End If
    
    'Dim retval As RPGCODE_RETURN
    'Dim vv As Long
    'vv = DoIndependentCommand(lit$, retval)

    'Exit Sub
'Begin error handling code:
'errorhandler:
'    Call HandleError
'    Resume Next

    '========================================================================
    'End commenting by KSNiloc
    '========================================================================

End Sub


Sub RunRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)
    '#Run("prgram.prg")
    'Run a program
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Run has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Run has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Run data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".prg")

        theProgram.programPos = -1
        ReDim theProgram.program(0)
        nextProgram = projectPath & prgPath & lit
        runningProgram = False

    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ThreadRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#threadID! = #Thread("prgram.prg", persistent! [, dest!])
    'launch a thread
    'return an id we can use to refer to the thread again
    'if persistent! is 1 then it is a persistent thread
    'if 0, then it is a board thread.
    'optionally stores the thread id in dest!
    
    On Error Resume Next
    
    'return -1 if error
    retval.dataType = DT_NUM
    retval.num = -1
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 3 Then
        Call debugger("Error: Thread has must have 2 or 3 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    
    Dim b As Long
    a = getValue(useIt1$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = 0 Or b = 1 Then
        Call debugger("Error: Thread data type must be literal, num!-- " + Text$)
    Else
        Dim bPersist As Boolean
        If num2 = 0 Then
            bPersist = False
        Else
            bPersist = True
        End If
        
        Dim tID As Long
        lit1$ = addExt(lit1$, ".prg")
        tID = CreateThread(projectPath$ + prgPath$ + lit1$, bPersist)
        
        If number = 3 Then
            'save value in destination var...
            Call SetVariable(useIt3$, str$(tID), theProgram)
        End If
        
        retval.dataType = DT_NUM
        retval.num = tID
        Exit Sub
    End If
End Sub


Sub SaveRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Save (filename$)
    'Save progress.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Save has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Save has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Save data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".sav")
        Call SaveState(savPath$ + lit$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub SaveScreenRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'SaveScreen([pos!])
    'Save the screen into the rpgcodebuffer buffer

    '========================================================================
    'Modified by KSNiloc
    '========================================================================

    Dim countDat As String
    countDat = CountData(Text)
    If GetBrackets(Text) = "" Then countDat = 0
       
    Select Case countDat
    
        Case 0
            Canvas2CanvasBlt cnvRPGCodeScreen, cnvRPGCodeAccess, 0, 0
            
        Case 1
            Dim paras() As parameters
            paras = GetParameters(Text, theProgram)
            
            If paras(0).dataType = DT_NUM Then
            
                'Make sure the array is dimensioned...
                On Error GoTo createArray
                Dim testArray As Long
                testArray = UBound(cnvRPGCode)

                'Enlarge the array if required...
                On Error GoTo enlargeArray
                testArray = cnvRPGCode(paras(0).num)
                
                'Save the screen!
                Canvas2CanvasBlt _
                    cnvRPGCodeScreen, cnvRPGCode(paras(0).num), 0, 0

            Else
                debugger "SaveScreen() requires either no data elements or" _
                    & " one numerical data element-- " & Text
                Exit Sub
                
            End If
            
        Case Else
            debugger "SaveScreen() requires either one or two data elements" _
                & "-- " & Text
            Exit Sub
            
    End Select

    Exit Sub
    
createArray:
    ReDim cnvRPGCode(0)
    cnvRPGCode(0) = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Resume
    
enlargeArray:
    ReDim Preserve cnvRPGCode(UBound(cnvRPGCode) + 1)
    cnvRPGCode(UBound(cnvRPGCode)) = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Resume
    
End Sub

Sub ScanRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Scan (x,y,memloc)
    'scan tile into memory
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: Scan must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)

    Dim redc As Long, greenc As Long, bluec As Long, x As Double, y As Double, memLoc As Long
    redc = getValue(useIt$, lit$, num1, theProgram)
    greenc = getValue(useIt2$, lit$, num2, theProgram)
    bluec = getValue(useIt3$, lit$, num3, theProgram)
    'If redc = 1 Or greenc = 1 Or bluec = 1 Then
    '    Call debugger("Error: Scan data type must be numerical!-- " + Text$)
    'Else
        x = num1
        y = num2
        memLoc = num3
        memLoc = inBounds(memLoc, 0, UBound(cnvRPGCodeBuffers))
        Call Canvas2CanvasBltPartial(cnvRPGCodeScreen, cnvRPGCodeBuffers(memLoc), _
                                    0, 0, _
                                    x * 32 - 32, y * 32 - 32, _
                                    32, 32, SRCCOPY)
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Send(Text$, ByRef theProgram As RPGCodeProgram)
    '========================================
    'EDITED: [Isometrics - Delano - 3/05/04]
    'Added code to update the pendingPlayer movements when the player is placed - prevents jumping.
    'Renamed variables: canwego >> targetTileType
    '                   newboarda >> targetBoardName
    '                   xxx,yyy >> targetBoardWidth,targetBoardHeight
    '                   xx,yy,ll >> targetX,targetY,targetL
    '                   boardto,xto,yto,lto >> parameter1Type,parameter2Type,parameter3Type,parameter4Type
    'New variables:     topXtemp = topX, topYtemp = topY
    'Removed unneeded variables.
    '========================================
    
    '#Send (board$, x!, y!, layer!)
    'If layer is omitted, it is assumed to be 1.
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String, useIt3 As String, useIt4 As String
    Dim lit As String, lit1 As String, num1 As Double, num2 As Double, num3 As Double, num4 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)            'Get text inside brackets
    number = CountData(dataUse$)            'how many data elements are there?
    
    If number <> 3 And number <> 4 Then
        Call debugger("Error: Send must have 3 or 4 data elements!-- " + Text$)
        Exit Sub
    End If
    
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    
    'If layer! is included, use that else use Layer 1 as the default.
    If number = 4 Then
        useIt4$ = GetElement(dataUse$, 4)
    Else
        useIt4$ = "1"
    End If
    
    Dim parameter1Type As Long, parameter2Type As Long, parameter3Type As Long, parameter4Type As Long
    
    'lit$ can be overwritten each time since we don't need it. Could replace with Null?
    parameter1Type = getValue(useIt1$, lit1$, num1, theProgram)
    parameter2Type = getValue(useIt2$, lit$, num2, theProgram)
    parameter3Type = getValue(useIt3$, lit$, num3, theProgram)
    parameter4Type = getValue(useIt4$, lit$, num4, theProgram)
    
    If parameter1Type = 0 Then
        'Type 0 corresponds to numerical.
        Call debugger("Error: Send board data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If parameter2Type = 1 Or parameter3Type = 1 Or parameter4Type = 1 Then
        'Type 1 corresponds to literal.
        Call debugger("Error: Send location data type must be numerical!-- " + Text$)
        Exit Sub
    End If
        
    Dim targetBoardName As String
    Dim targetTileType As Long
    Dim targetBoardWidth As Long, targetBoardHeight As Long
    Dim targetX As Long, targetY As Long, targetL As Long
    Dim topXtemp As Single, topYtemp As Single
    
    'Add an extension if there isn't one:
    targetBoardName$ = addExt(lit1$, ".brd")
    
    'Put the dimensions of the target board into targetBoardWidth, targetBoardHeight
    Call boardSize(projectPath$ + brdPath$ + targetBoardName$, targetBoardWidth, targetBoardHeight)
    
    'Check the target is valid.
    targetX = inBounds(num2, 1, targetBoardWidth)
    targetY = inBounds(num3, 1, targetBoardHeight)
    targetL = inBounds(num4, 1, 8)
    
    'TestBoard clears the screen co-ords (topX,topY) via openBoard so these need to be held incase sending fails.
    topXtemp = topX
    topYtemp = topY
    
    'Original test... what's it checking?!
    'targetTileType = TestBoard(projectPath$ + brdPath$ + targetBoardName$, ppos(selectedPlayer).x, 1, ppos(selectedPlayer).l)
    
    targetTileType = TestBoard(projectPath$ + brdPath$ + targetBoardName$, targetX, targetY, targetL)

    'If targetTileType = -1 Or targetTileType = SOLID Then
    If targetTileType = -1 Then
        'If the board doesn't exist (-1) or the target tile is solid (SOLID = 1; new tiletype constant)
        
        'Need to re-insert old topX,topY since TestBoard has cleared them via openBoard.
        topX = topXtemp
        topY = topYtemp
    
        'Call debugger("Error: Cannot send to specified board!-- " + text$)
        Exit Sub
    End If
    
    'aa = Timer 'Measure the time it takes to open a board.
    
    Call openboard(projectPath$ + brdPath$ + targetBoardName$, boardList(activeBoardIndex).theData)
    
    'Clear non-persistent threads...
    Call ClearNonPersistentThreads
    
    lastRender.canvas = -1
    scTopX = -1000
    scTopY = -1000
    
    'MsgBox Str$(Timer - aa)
    
    Call alignBoard(targetX, targetY)
    Call openItems
    
    ' ! ADDED BY KSNiloc...
    launchBoardThreads boardList(activeBoardIndex).theData
    
    ppos(selectedPlayer).x = targetX
    ppos(selectedPlayer).y = targetY
    ppos(selectedPlayer).l = targetL
    
    'Isometric fix:
    pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
    pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
    pendingPlayerMovement(selectedPlayer).xTarg = ppos(selectedPlayer).x
    pendingPlayerMovement(selectedPlayer).yTarg = ppos(selectedPlayer).y
    
    Call renderNow
    Call CanvasGetScreen(cnvRPGCodeScreen)
    
    facing = 1              'Facing south
    wentToNewBoard = True
    Call setconstants

    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub setbuttonRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#SetButton("face.bmp",buttonnum,x1,y1,dx,dy)
    'Sets a button on the screen.
    'dx and dy are displacement
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number < 6 Then
        Call debugger("Error: SetButton must have 6 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, useIt6 As String, destBut As Double, x1 As Double, y1 As Double, dx As Double, dy As Double
    Dim theFace As Long, butTo As Long, x1to As Long, y1to As Long, x2to As Long, y2to As Long, fface As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    useIt6$ = GetElement(dataUse$, 6)
    
    theFace = getValue(useIt1$, fface$, num1, theProgram)
    butTo = getValue(useIt2$, lit$, destBut, theProgram)
    x1to = getValue(useIt3$, lit$, x1, theProgram)
    y1to = getValue(useIt4$, lit$, y1, theProgram)
    x2to = getValue(useIt5$, lit$, dx, theProgram)
    y2to = getValue(useIt6$, lit$, dy, theProgram)
    
    If theFace = 0 Then
        Call debugger("Error: SetButton face data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If butTo = 1 Or x1to = 1 Or y1to = 1 Or x2to = 1 Or y2to = 1 Then
        Call debugger("Error: SetButton coords must be numerical!-- " + Text$)
    Else
        destBut = inBounds(destBut, 0, 50)
        x1 = inBounds(x1, 0, tilesX * 32)
        y1 = inBounds(y1, 0, tilesY * 32)
        
        ' ! MODIFIED BY KSNiloc...
        
        buttons(destBut).x1 = x1 - 20
        buttons(destBut).x2 = x1 + dx - 20
        buttons(destBut).y1 = y1
        buttons(destBut).y2 = y1 + dy
        buttons(destBut).face = fface$
        
        fface$ = projectPath$ & bmpPath$ & fface$
        
        Dim cnv As Long
        cnv = CreateCanvas(dx, dy)
        
        Dim bLoaded As Boolean, f As String
        bLoaded = False
        If pakFileRunning Then
            f$ = PakLocate(fface$)
            If fileExists(f$) Then
                bLoaded = True
                Call CanvasLoadSizedPicture(cnv, f$)
            End If
        Else
            If fileExists(fface$) Then
                bLoaded = True
                Call CanvasLoadSizedPicture(cnv, fface$)
            End If
        End If
        If bLoaded Then
            Call Canvas2CanvasBlt(cnv, cnvRPGCodeScreen, x1, y1)
        End If
        Call DestroyCanvas(cnv)
        'Call renderRPGCodeScreen
        DXDrawCanvasPartial cnvRPGCodeScreen, _
                            x1, y1, x1, y1, _
                            dx, dy
        DXRefresh
    End If
    
End Sub

Sub setconstants()
'Sets all RPGCode variable constants.
    On Error GoTo errorhandler
    Dim t As Long
    Dim xx As String
    Dim yy As String
    Dim ll As String
    Dim hh As String
    Dim cc As String
    
    Call setIndependentVariable("GameTime!", str$(gameTime))
    Call setIndependentVariable("Music$", musicPlaying$)
    For t = 0 To 4
        xx$ = removeChar("playerX[" + str$(t) + "]!", " ")
        yy$ = removeChar("playerY[" + str$(t) + "]!", " ")
        ll$ = removeChar("playerLayer[" + str$(t) + "]!", " ")
        hh$ = removeChar("playerHandle[" + str$(t) + "]$", " ")
        Call setIndependentVariable(xx$, str$(ppos(t).x))
        Call setIndependentVariable(yy$, str$(ppos(t).y))
        Call setIndependentVariable(ll$, str$(ppos(t).l))
        Call setIndependentVariable(hh$, playerListAr$(t))
    Next t
    For t = 0 To 10
        cc$ = removeChar("Constant[" + str$(t) + "]!", " ")
        Call setIndependentVariable(cc$, str$(boardList(activeBoardIndex).theData.brdConst(t)))
    Next t
    For t = 1 To 8
        cc$ = removeChar("BoardTitle[" + str$(t) + "]$", " ")
        Call setIndependentVariable(cc$, boardList(activeBoardIndex).theData.boardTitle$(t))
    Next t
    'board skill and background
    If mainMem.mainUseDayNight = 1 And boardList(activeBoardIndex).theData.BoardDayNight = 1 And boardList(activeBoardIndex).theData.BoardNightBattleOverride = 1 Then
        If IsNight() Then
            Call setIndependentVariable("BoardSkill!", str$(boardList(activeBoardIndex).theData.BoardSkillNight))
            Call setIndependentVariable("BoardBackground$", boardList(activeBoardIndex).theData.BoardBackgroundNight$)
        Else
            Call setIndependentVariable("BoardSkill!", str$(boardList(activeBoardIndex).theData.boardskill))
            Call setIndependentVariable("BoardBackground$", boardList(activeBoardIndex).theData.boardBackground$)
        End If
    Else
        Call setIndependentVariable("BoardSkill!", str$(boardList(activeBoardIndex).theData.boardskill))
        Call setIndependentVariable("BoardBackground$", boardList(activeBoardIndex).theData.boardBackground$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub SetImageAdditiveRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    'SetImageAdditive(file$, x1!, y1!, width!, height!, percent!,[cnv!])
    'draws an image at x1, y1, with the specified width
    'blends image into background (percent! can be from -100 to 100)
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 6 And number <> 7 Then
        Call debugger("Error: SetImageAdditive must have 6 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, useIt6 As String, x1 As Double, y1 As Double, dx As Double, dy As Double, perc As Double
    Dim theFace As Long, x1to As Long, y1to As Long, x2to As Long, y2to As Long, pp As Long, fface As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    useIt6$ = GetElement(dataUse$, 6)
    Dim useIt7 As String
    useIt7 = GetElement(dataUse, 7)
    
    theFace = getValue(useIt1$, fface$, num1, theProgram)
    x1to = getValue(useIt2$, lit$, x1, theProgram)
    y1to = getValue(useIt3$, lit$, y1, theProgram)
    x2to = getValue(useIt4$, lit$, dx, theProgram)
    y2to = getValue(useIt5$, lit$, dy, theProgram)
    pp = getValue(useIt6$, lit$, perc, theProgram)
    Dim cnvToUse As Double
    getValue useIt7, lit, cnvToUse, theProgram
    If cnvToUse = 0 Then cnvToUse = cnvRPGCodeScreen
    
    If theFace = 0 Then
        Call debugger("Error: SetImageAdditive face data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If x1to = 1 Or y1to = 1 Or x2to = 1 Or y2to = 1 Or pp = 1 Then
        Call debugger("Error: SetImageAdditive coords must be numerical!-- " + Text$)
    Else
        x1 = inBounds(x1, 0, tilesX * 32)
        y1 = inBounds(y1, 0, tilesY * 32)
        
        fface$ = projectPath$ & bmpPath$ & fface$
        
        Dim cnv As Long
        cnv = CreateCanvas(dx, dy)
        
        Dim f As String
        If pakFileRunning Then
            f$ = PakLocate(fface$)
            Call CanvasLoadSizedPicture(cnv, f$)
        Else
            Call CanvasLoadSizedPicture(cnv, fface$)
        End If
        
        Dim hdc As Long, hdc2 As Long
        hdc = CanvasOpenHDC(cnvToUse)
        hdc2 = CanvasOpenHDC(cnv)
        
        'now manually copy the image over...
        'use hi-speed engine....
        a = GFXBitBltAdditive(hdc, _
                                x1, _
                                y1, _
                                dx - 1, _
                                dy - 1, _
                                hdc2, _
                                0, _
                                0, _
                                perc)
        Call CanvasCloseHDC(cnvToUse, hdc)
        Call CanvasCloseHDC(cnv, hdc2)
        Call DestroyCanvas(cnv)
        If cnvToUse = cnvRPGCodeScreen Then
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, _
                                x1, y1, _
                                dx, dy
            DXRefresh
        End If
    End If
End Sub

Sub setImageRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    'SetImage(filename$,x1!,y1!,dx!,dy!,cnv!)
    'set a sized image onto the screen
    'dx and dy are displacement
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 5 And number <> 6 Then
        Call debugger("Error: SetImage must have 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, x1 As Double, y1 As Double, dx As Double, dy As Double
    Dim theFace As Long, x1to As Long, y1to As Long, x2to As Long, y2to As Long, fface As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    Dim useIt6 As String
    useIt6 = GetElement(dataUse, 6)
    
    theFace = getValue(useIt1$, fface$, num1, theProgram)
    x1to = getValue(useIt2$, lit$, x1, theProgram)
    y1to = getValue(useIt3$, lit$, y1, theProgram)
    x2to = getValue(useIt4$, lit$, dx, theProgram)
    y2to = getValue(useIt5$, lit$, dy, theProgram)
    Dim cnv2 As Double
    getValue useIt6, lit, cnv2, theProgram

    If cnv2 = 0 Then cnv2 = cnvRPGCodeScreen
    
    If theFace = 0 Then
        Call debugger("Error: SetImage face data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If x1to = 1 Or y1to = 1 Or x2to = 1 Or y2to = 1 Then
        Call debugger("Error: SetImage coords must be numerical!-- " + Text$)
    Else
        x1 = inBounds(x1, 0, tilesX * 32)
        y1 = inBounds(y1, 0, tilesY * 32)
        
        fface$ = projectPath$ & bmpPath$ & fface$

        Dim cnv As Long
        cnv = CreateCanvas(dx, dy)
        
        Dim f As String
        If pakFileRunning Then
            f$ = PakLocate(fface$)
            Call CanvasLoadSizedPicture(cnv, f$)
        Else
            Call CanvasLoadSizedPicture(cnv, fface$)
        End If
        
        Call Canvas2CanvasBlt(cnv, cnv2, x1, y1)
        If cnv2 = cnvRPGCodeScreen Then
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, _
                                x1, y1, _
                                dx, dy
            DXRefresh
        End If

        Call DestroyCanvas(cnv)
    End If
    
End Sub

Sub SetImageTranslucentRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    '#SetImageTranslucent(file$, x1!, y1!, width!, height! [,cnv!])
    'draws an image at x1, y1, with the specified width
    'blends image into background.
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 5 And number <> 6 Then
        Call debugger("Error: SetImageTranslucent must have 8 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, x1 As Double, y1 As Double, dx As Double, dy As Double
    Dim theFace As Long, x1to As Long, y1to As Long, x2to As Long, y2to As Long, fface As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    Dim useIt6 As String
    useIt6 = GetElement(dataUse, 6)
    
    theFace = getValue(useIt1$, fface$, num1, theProgram)
    x1to = getValue(useIt2$, lit$, x1, theProgram)
    y1to = getValue(useIt3$, lit$, y1, theProgram)
    x2to = getValue(useIt4$, lit$, dx, theProgram)
    y2to = getValue(useIt5$, lit$, dy, theProgram)
    Dim cnv2 As Double
    getValue useIt6, lit, cnv2, theProgram
    
    If cnv2 = 0 Then cnv2 = cnvRPGCodeScreen
    
    If theFace = 0 Then
        Call debugger("Error: SetImageTranslucent face data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If x1to = 1 Or y1to = 1 Or x2to = 1 Or y2to = 1 Then
        Call debugger("Error: SetImageTranslucent coords must be numerical!-- " + Text$)
    Else
        x1 = inBounds(x1, 0, tilesX * 32)
        y1 = inBounds(y1, 0, tilesY * 32)
        
        fface$ = projectPath$ & bmpPath$ & fface$
        
        Dim cnv As Long
        cnv = CreateCanvas(dx, dy)
        
        Dim f As String
        If pakFileRunning Then
            f$ = PakLocate(fface$)
            Call CanvasLoadSizedPicture(cnv, f$)
        Else
            Call CanvasLoadSizedPicture(cnv, fface$)
        End If
        
        Call Canvas2CanvasBltTranslucent(cnv, cnv2, _
                                    x1, y1)
        Call DestroyCanvas(cnv)
        If cnv2 = cnvRPGCodeScreen Then
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, _
                                x1, y1, _
                                dx, dy
            DXRefresh
        End If
    End If
End Sub

Sub SetImageTransparentRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    'SetImageTransparent(filename$, x1!, y1!, width!, height!, r!, g!, b! [,cnv!])
    'load an image and size it and then set it at a location.
    'consider r!, g!, b! color to be transparent
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 8 And number <> 9 Then
        Call debugger("Error: SetImageTransparent must have 8 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, useIt6 As String, useIt7 As String, useIt8 As String, x1 As Double, y1 As Double, dx As Double, dy As Double
    Dim rr As Double, gg As Double, bb As Double, rt As Long, gt As Long, bT As Long
    Dim theFace As Long, x1to As Long, y1to As Long, x2to As Long, y2to As Long, fface As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    useIt6$ = GetElement(dataUse$, 6)
    useIt7$ = GetElement(dataUse$, 7)
    useIt8$ = GetElement(dataUse$, 8)
    Dim useIt9 As String
    useIt9 = GetElement(dataUse, 9)
    
    theFace = getValue(useIt1$, fface$, num1, theProgram)
    x1to = getValue(useIt2$, lit$, x1, theProgram)
    y1to = getValue(useIt3$, lit$, y1, theProgram)
    x2to = getValue(useIt4$, lit$, dx, theProgram)
    y2to = getValue(useIt5$, lit$, dy, theProgram)
    rt = getValue(useIt6$, lit$, rr, theProgram)
    gt = getValue(useIt7$, lit$, gg, theProgram)
    bT = getValue(useIt8$, lit$, bb, theProgram)
    Dim cnv2 As Double
    getValue useIt9, lit, cnv2, theProgram
    
    If cnv2 = 0 Then cnv2 = cnvRPGCodeScreen
    
    If theFace = 0 Then
        Call debugger("Error: SetImageTransparent face data type must be literal!-- " + Text$)
        Exit Sub
    End If
    If x1to = 1 Or y1to = 1 Or x2to = 1 Or y2to = 1 Or rt = 1 Or gt = 1 Or bT = 1 Then
        Call debugger("Error: SetImageTransparent coords must be numerical!-- " + Text$)
    Else
        x1 = inBounds(x1, 0, tilesX * 32)
        y1 = inBounds(y1, 0, tilesY * 32)
        
        fface$ = projectPath$ & bmpPath$ & fface$
        
        Dim cnv As Long
        cnv = CreateCanvas(dx, dy)
        
        Dim f As String
        If pakFileRunning Then
            f$ = PakLocate(fface$)
            Call CanvasLoadSizedPicture(cnv, f$)
        Else
            Call CanvasLoadSizedPicture(cnv, fface$)
        End If
        
        Call Canvas2CanvasBltTransparent(cnv, cnv2, _
                                    x1, y1, RGB(rr, gg, bb))
        Call DestroyCanvas(cnv)
        If cnv2 = cnvRPGCodeScreen Then
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, _
                                x1, y1, _
                                dx, dy
            DXRefresh
        End If
    End If
End Sub

Sub SetPixelRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    'SetPixel(x,y [,cnv!])
    'set pixel at x, y of selected color.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 3 Then
        Call debugger("Error: SetPixel must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    'Dim useIt3 As String
    useIt3 = GetElement(dataUse, 3)
    
    Dim x As Double, y As Double, xx As Long, yy As Long
    xx = getValue(useIt1$, lit$, x, theProgram)
    yy = getValue(useIt2$, lit$, y, theProgram)
    Dim cnv As Double
    getValue useIt3, lit, cnv, theProgram
    
    If cnv = 0 Then cnv = cnvRPGCodeScreen
    
    If xx = 1 Or yy = 1 Then
        Call debugger("Error: SetPixel data type must be numerical!-- " + Text$)
    Else
        Call CanvasSetPixel(cnv, x, y, fontColor)
        If cnv = cnvRPGCodeScreen Then
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x, y, x, y, 1, 1
            DXRefresh
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ShowRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Show (var!$)
    'Show var in mwin
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Show has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    Dim inWin As String
    If a = 1 Then
        inWin$ = lit$
    Else
        inWin$ = str$(num)
    End If
    Call AddToMsgBox(inWin$, theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub SinRPG(Text As String, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)

    On Error Resume Next
    
    'Re-written by KSNiloc
    
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    Select Case CountData(Text)
    
        Case 1
            If Not paras(0).dataType = DT_NUM Then
                debugger "Sin() requires a numerical data element-- " & Text
                Exit Sub
            End If
            retval.dataType = DT_NUM
            retval.num = Sin(paras(0).num)
        
        Case 2
            If Not paras(0).dataType = DT_NUM Then
                debugger "Sin() requires a numerical data element-- " & Text
                Exit Sub
            End If
            SetVariable paras(1).dat, Sin(paras(0).num), theProgram
        
        Case Else
            debugger "Sin() requires one or two data elements-- " & Text
    
    End Select

End Sub

Sub SizedAnimationRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#SizedAnimation(file$, x!, y!, xsize!, ysize!)
    'run animation at x!, y!, with a particular size.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 5 Then
        Call debugger("Error: SizedAnimation must have 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, useIt5 As String, xx As Double, yy As Double, xs As Double, ys As Double
    Dim aa As Long, bb As Long, cc As Long, dd As Long, ee As Long, file As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5$ = GetElement(dataUse$, 5)
    aa = getValue(useIt1$, file$, num1, theProgram)
    bb = getValue(useIt2$, lit$, xx, theProgram)
    cc = getValue(useIt3$, lit$, yy, theProgram)
    dd = getValue(useIt4$, lit$, xs, theProgram)
    ee = getValue(useIt5$, lit$, ys, theProgram)
    If aa = 0 Or xx = 1 Or yy = 1 Or xs = 1 Or ys = 1 Then
        Call debugger("Error: SizedAnimation data type must be lit, num, num, num, num!-- " + Text$)
    Else
        file$ = addExt(file$, ".anm")
        Call openAnimation(projectPath$ + miscPath$ + file$, animationMem)
        animationMem.animSizeX = Abs(xs)
        animationMem.animSizeY = Abs(ys)
        
        ' ! MODIFIED BY KSNiloc...
        
        If Not isMultiTasking() Then
        
            Call TransAnimateAt(xx, yy)
            
        Else
        
            'We're multitasking...
            startMultitaskAnimation xx, yy, theProgram
        
        End If
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function SkipMethodRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long
    '#Method methodname (parameter!, parameter2$, etc)
    'Skip over a method.
    On Error GoTo errorhandler
    
    ' !FIX! by KSNiloc
    theProgram.programPos = increment(theProgram)
    SkipMethodRPG = runBlock(Text, 0, theProgram)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub SmpRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#SMP("handle", new_SM_level!)
    'Set player SMP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: SMP must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim hand As Long, lev As Long, theOne As Long, t As Long, tooBig As Double, aa As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    lev = getValue(useIt2$, lit2$, num2, theProgram)
    If hand = 0 Or lev = 1 Then
        Call debugger("Error: SMP data type must be literal and numeric!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
                If num2 > tooBig Then num2 = tooBig
                Call SetVariable(playerMem(theOne).smVar$, str$(num2), theProgram)
                Exit Sub
            End If
            If targetType = 2 Then
                'enemy was targeted.
                theOne = target
                enemyMem(theOne).eneSMP = num2
                If enemyMem(theOne).eneSMP > enemyMem(theOne).eneMaxSMP Then enemyMem(theOne).eneSMP = enemyMem(theOne).eneMaxSMP
                Exit Sub
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
                aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
                If num2 > tooBig Then num2 = tooBig
                Call SetVariable(playerMem(theOne).smVar$, str$(num2), theProgram)
                Exit Sub
            End If
            If sourceType = 2 Then
                'enemy was targeted.
                theOne = Source
                enemyMem(theOne).eneSMP = num2
                If enemyMem(theOne).eneSMP > enemyMem(theOne).eneMaxSMP Then enemyMem(theOne).eneSMP = enemyMem(theOne).eneMaxSMP
                Exit Sub
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'Set the health level:
        
        aa = getVariable(playerMem(theOne).smMaxVar$, lit$, tooBig, theProgram)
        If num2 > tooBig Then num2 = tooBig
        Call SetVariable(playerMem(theOne).smVar$, str$(num2), theProgram)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub SoundRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Sound(..)
    'Discontinued ver 1 function
    On Error GoTo errorhandler
    Call debugger("Warning: Version 1 #Sound Command No Longer Supported- Use Media Commands!-- " + Text$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub SourceHandleRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #SourceHandle([dest$])
    'get source handle
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 And number <> 0 Then
        Call debugger("Error: SourceHandle must have one literal variable! " + Text$)
    End If
    Dim var1 As String, tar As String
    var1$ = GetElement(dataUse$, 1)
    If sourceType = 0 Then
        'player
        tar$ = playerListAr$(Source)
    End If
    If sourceType = 1 Then
        'item
        tar$ = "ITEM" + str$(Source)
    End If
    If sourceType = 2 Then
        'enemy
        tar$ = "ENEMY" + str$(Source)
    End If
    If number = 1 Then
        Call SetVariable(var1$, tar$, theProgram)
    End If
    retval.dataType = DT_LIT
    retval.lit = tar$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub SourceLocationRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#SourceLocation(x!,y!)
    'get the coords of source.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: SourceLocation must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String, tarX As String, tarY As String
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    If sourceType = 0 Then
        'player
        tarX$ = str$(ppos(Source).x)
        tarY$ = str$(ppos(Source).y)
    End If
    If sourceType = 1 Then
        'item
        'MsgBox Str$(itmx(target)) + Str$(itmy(target))
        tarX$ = str$(boardList(activeBoardIndex).theData.itmX(Source))
        tarY$ = str$(boardList(activeBoardIndex).theData.itmY(Source))
    End If
    If sourceType = 2 Then
        'enemy
        tarX$ = str$(enemyMem(Source).x)
        tarY$ = str$(enemyMem(Source).y)
    End If
    'MsgBox tarx$ + "," + tary$ + "   " + Str$(curx(0)) + Str$(cury(0))
    Call SetVariable(var1$, tarX$, theProgram)
    Call SetVariable(var2$, tarY$, theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub SqrtRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #Sqrt(9[, dest!])
    'calc squareroot
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: Sqrt must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim aa As Long
    aa = getValue(useIt$, lit$, num1, theProgram)
    If aa = 1 Then
        Call debugger("Error: Sqrt must have a numerical element!-- " + Text$)
        Exit Sub
    End If
    Dim calcu As Double
    calcu = Sqr(num1)
    If number = 2 Then
        Call SetVariable(useIt2$, str$(calcu), theProgram)
    End If
    retval.dataType = DT_NUM
    retval.num = calcu

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub StanceRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Stance(0-43[,handle$])
    'show player stance, assumed to be
    'default if not specified.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    If number = 1 Then useIt2$ = playerListAr$(selectedPlayer)
    Dim b As Long, theOne As Long, t As Long
    a = getValue(useIt$, lit$, num, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = 1 Or b = 0 Then
        Call debugger("Error: Stance data type must be num, lit!-- " + Text$)
    Else
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit2$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'MsgBox Str$(theone)
        'MsgBox Str$(num) + text$
        num = inBounds(num, 1, 43)
        
        If within(num, 1, 4) = 1 Then
            'facing south
            ppos(theOne).frame = num - 1
            ppos(theOne).stance = "WALK_S"
        End If
        If within(num, 5, 8) = 1 Then
            'facing south
            ppos(theOne).frame = num - 5
            ppos(theOne).stance = "WALK_E"
        End If
        If within(num, 9, 12) = 1 Then
            'facing south
            ppos(theOne).frame = num - 9
            ppos(theOne).stance = "WALK_N"
        End If
        If within(num, 13, 16) = 1 Then
            'facing south
            ppos(theOne).frame = num - 13
            ppos(theOne).stance = "WALK_W"
        End If
        If within(num, 17, 20) = 1 Then
            'facing south
            ppos(theOne).frame = num - 17
            ppos(theOne).stance = "FIGHT"
        End If
        If within(num, 21, 24) = 1 Then
            'facing south
            ppos(theOne).frame = num - 21
            ppos(theOne).stance = "SPC"
        End If
        If within(num, 25, 28) = 1 Then
            'facing south
            ppos(theOne).frame = num - 25
            ppos(theOne).stance = "DEFEND"
        End If
        If within(num, 29, 32) = 1 Then
            'facing south
            ppos(theOne).frame = num - 29
            ppos(theOne).stance = "DIE"
        End If
        If within(num, 33, 42) = 1 Then
            'facing south
            ppos(theOne).frame = 0
            ppos(theOne).stance = "CUSTOM " + toString(num - 33)
        End If
        If num = 43 Then
            ppos(theOne).frame = 0
            ppos(theOne).stance = "REST"
        End If
        
        Call renderNow
        Call CanvasGetScreen(cnvRPGCodeScreen)
        Call renderRPGCodeScreen
        
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub StartRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Start("filename")
    'Invokes the Windows9x START command, which runs
    '*any* file.
    On Error GoTo errorhandler
    
    'October 5/99:
    'disabled the ability to #start .exe, .com, .pif and .bat .lnk files
    'also disabled starting a file with no extention
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Start has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Start data type must be literal!-- " + Text$)
    Else
        Dim ex As String, skipIt As Long, comm As String, dum As Long
        ex$ = GetExt(lit$)
        skipIt = -1
        If UCase$(Mid$(lit$, 1, 7)) = "HTTP://" Then
            skipIt = 0
        End If
        If UCase$(Mid$(lit$, 1, 6)) = "FTP://" Then
            skipIt = 0
        End If
        If skipIt = -1 Then
            If UCase$(ex$) = "EXE" Or UCase$(ex$) = "COM" Or UCase$(ex$) = "BAT" Or UCase$(ex$) = "PIF" Or UCase$(ex$) = "LNK" Then
                Call debugger("Error: Start cannot run .exe, .com, .bat, .lnk or .pif files!--- " + Text$)
                Exit Sub
            End If
            If ex$ = "" Then
                Call debugger("Error: Start cannot run files with no extention!--- " + Text$)
                Exit Sub
            End If
        End If
        comm$ = "Start " + lit$
        dum = Shell(comm$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub StaticTextRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#StaticText(ON/OFF)
    'Turn static text on/off
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: StaticText is obsolete!-- " + Text$)
    
    'On Error GoTo errorhandler
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: StaticText has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'If useIt$ = "" Then
    '    Call debugger("Error: StaticText has no data element!-- " + text$)
    '    Exit Sub
    'End If
    'a = GetValue(useIt$, lit$, num, theprogram)
    'If a = 0 Then
    '    Call debugger("Error: StaticText data type must be literal!-- " + text$)
    'Else
    '    If UCase$(lit$) = "ON" Then
    '        staticText = 1
    '    Else
    '        staticText = 0
    '    End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TakeGPRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#TakeGP(100)
    'take GP
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: TakeGP has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: TakeGP data type must be numerical!-- " + Text$)
    Else
        GPCount = GPCount - num
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TakeItemRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#TakeItem("filename/handle")
    'Remove item from inventory
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: TakeItem has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: TakeItem data type must be literal!-- " + Text$)
    Else
        Dim ext As String, theOne As Long, t As Long
        'Scan inventory for this item
        ext$ = GetExt(lit$)
        
        If UCase$(ext$) = "ITM" Then
            theOne = -1
            For t = 0 To UBound(inv.item)
                If UCase$(inv.item(t).file) = UCase$(lit$) Then theOne = t
            Next t
        Else
            theOne = -1
            For t = 0 To UBound(inv.item)
                If UCase$(inv.item(t).handle) = UCase$(lit$) Then theOne = t
            Next t
        End If
        If theOne <> -1 Then
            inv.item(theOne).number = inv.item(theOne).number - 1
            If inv.item(theOne).number <= 0 Then
                inv.item(theOne).number = 0
                inv.item(theOne).file = ""
                inv.item(theOne).handle = ""
            End If
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TanRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)

    On Error Resume Next
    
    'Re-written by KSNiloc
    
    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    Select Case CountData(Text)
    
        Case 1
            If Not paras(0).dataType = DT_NUM Then
                debugger "Tan() requires a numerical data element-- " & Text
                Exit Sub
            End If
            retval.dataType = DT_NUM
            retval.num = Tan(paras(0).num)
        
        Case 2
            If Not paras(0).dataType = DT_NUM Then
                debugger "Tan() requires a numerical data element-- " & Text
                Exit Sub
            End If
            SetVariable paras(1).dat, Tan(paras(0).num), theProgram

        Case Else
            debugger "Tan() requires one or two data elements-- " & Text
    
    End Select

End Sub

Sub TargetHandleRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #TargetHandle([dest$])
    'get handle of the TARGET handle.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 And number <> 0 Then
        Call debugger("Error: TargetHandle must have one literal variable! " + Text$)
    End If
    Dim var1 As String, tar As String
    var1$ = GetElement(dataUse$, 1)
    If targetType = 0 Then
        'player
        tar$ = playerListAr$(target)
    End If
    If targetType = 1 Then
        'item
        tar$ = "ITEM" + str$(target)
    End If
    If targetType = 2 Then
        'enemy
        tar$ = "ENEMY" + str$(target)
    End If
    If number = 1 Then
        Call SetVariable(var1$, tar$, theProgram)
    End If
    retval.dataType = DT_LIT
    retval.lit = tar$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TargetLocationRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#TargetLocation(x!,y!)
    'get the coords of target.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: TargetLocation must have two numerical variables! " + Text$)
    End If
    Dim var1 As String, var2 As String, aa As Double, xx As Double, yy As Double, tarX As String, tarY As String
    var1$ = GetElement(dataUse$, 1)
    var2$ = GetElement(dataUse$, 2)
    If targetType = 0 Then
        'player
        If fightInProgress Then
            'there's a fight going on.
            'answer regarding where the character is standing in
            'the fight...
            'side view
            'TBD: get this info from the plugin...
            aa = (target + 1) Mod 2
            If aa = 1 Then xx = 18 Else xx = 19
            yy = target + 3
        
            tarX$ = str$(xx)
            tarY$ = str$(yy)
        Else
            tarX$ = str$(ppos(target).x)
            tarY$ = str$(ppos(target).y)
        End If
    End If
    If targetType = 1 Then
        'item
        'MsgBox Str$(itmx(target)) + Str$(itmy(target))
        tarX$ = str$(boardList(activeBoardIndex).theData.itmX(target))
        tarY$ = str$(boardList(activeBoardIndex).theData.itmY(target))
    End If
    If targetType = 2 Then
        'enemy
        tarX$ = str$(enemyMem(target).x)
        tarY$ = str$(enemyMem(target).y)
    End If
    'MsgBox tarx$ + "," + tary$ + "   " + Str$(curx(0)) + Str$(cury(0))
    Call SetVariable(var1$, tarX$, theProgram)
    Call SetVariable(var2$, tarY$, theProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub TextRPG(Text$, ByRef theProgram As RPGCodeProgram)

    ' ! MODIFIED BY KSNiloc...

    'Text(x!,y!,"text" [,cnv!])
    'puts text at x y
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 4 Then
        Call debugger("Error: Text must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim useIt4 As String
    useIt4 = GetElement(dataUse, 4)

    Dim xto As Long, yto As Long, txtto As Long
    xto = getValue(useIt1$, lit$, num1, theProgram)
    yto = getValue(useIt2$, lit$, num2, theProgram)
    txtto = getValue(useIt3$, lit1$, num3, theProgram)
    Dim cnv As Double
    getValue useIt4, lit, cnv, theProgram

    If cnv = 0 Then cnv = cnvRPGCodeScreen
    
    If txtto = 0 Then
        lit1$ = str$(num3)
    End If
    If xto = 1 Or yto = 1 Then
        Call debugger("Error: Text location data type must be numerical!-- " + Text$)
    Else
        textX = num1
        textY = num2 + 1
        'replace <> w/vars
        lit1$ = MWinPrepare(lit1$, theProgram)
        Dim hdc As Long
        hdc = CanvasOpenHDC(cnv)

        '! ADDITION BY KSNiloc
        Select Case LCase(GetCommandName(Text, theProgram))
            Case "text": putText lit1$, num1, num2, fontColor, fontSize, fontSize, hdc
            Case "pixeltext"
                putText lit1, (num1 / fontSize) + 1, _
                              (num2 / fontSize) + 1, _
                                                       fontColor, fontSize, fontSize, hdc
        End Select

        Call CNVCloseHDC(cnv, hdc)
        If cnv = cnvRPGCodeScreen Then
            renderRPGCodeScreen
            'If LCase(GetCommandName(Text, theProgram)) = "text" Then
            '    DXDrawCanvasPartial cnvRPGCodeScreen, _
            '                        num1, num2, _
            '                        num1, num2, _
            '                        GetCanvasWidth(cnvRPGCodeScreen) - num1, fontSize
            'Else
            '    DXDrawCanvasPartial cnvRPGCodeScreen, _
            '                        (num1 / fontSize), (num2 / fontSize), _
            '                        (num1 / fontSize), (num2 / fontSize), _
            '                        GetCanvasWidth(cnvRPGCodeScreen) - num1, fontSize
            'End If
            'DXRefresh
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TextSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#TextSpeed(speed!)
    'changes text speed, like in the customize menu
    'speed! is 0-3
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: TextSpeed is obsolete!-- " + Text$)
    
    'On Error GoTo errorhandler
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: TextSpeed has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'a = GetValue(useIt$, lit$, num, theprogram)
    'If a = 1 Then
    '    Call debugger("Error: TextSpeed data type must be numerical!-- " + text$)
    'Else
    '    num = inbounds(num, 0, 3)
    '    TextSpeed = num
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub TileTypeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#TileType(1,2,"type",layer)
    'Set tile type.
    'Layer is assumed to be 1
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    Dim useIt4 As String, num4 As Double, xx As Long, yy As Long, typea As Long, lay As Long, theX As Long, theY As Long, theLay As Long, lie As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    If number < 4 Then useIt4$ = "1"

    xx = getValue(useIt$, lit$, num1, theProgram)
    yy = getValue(useIt2$, lit$, num2, theProgram)
    typea = getValue(useIt3$, lit1$, num3, theProgram)
    lay = getValue(useIt4$, lie$, num4, theProgram)
    If xx = 1 Or yy = 1 Or lay = 1 Or typea = 0 Then
        Call debugger("Error: TileType data type must be num, num, lit, num!-- " + Text$)
    Else
        theX = inBounds(num1, 1, boardList(activeBoardIndex).theData.Bsizex)
        theY = inBounds(num2, 1, boardList(activeBoardIndex).theData.Bsizey)
        theLay = inBounds(num4, 1, boardList(activeBoardIndex).theData.Bsizel)
        Select Case UCase$(lit1$)
            Case "NORMAL":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 0
            Case "SOLID":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 1
            Case "UNDER":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 2
            Case "NS":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 3
            Case "EW":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 4
            Case "STAIRS1":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 11
            Case "STAIRS2":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 12
            Case "STAIRS3":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 13
            Case "STAIRS4":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 14
            Case "STAIRS5":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 15
            Case "STAIRS6":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 16
            Case "STAIRS7":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 17
            Case "STAIRS8":
                boardList(activeBoardIndex).theData.tiletype(theX, theY, theLay) = 18
        End Select
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub UnderArrowRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#UnderArrow("on/off")
    'turn under arrow on or off.
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: UnderArrow is obsolete!-- " + Text$)
End Sub

Sub UnderlineRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Underline(ON/OFF)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Underline has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Underline has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Underline data type must be literal!-- " + Text$)
    Else
    
        ' ! MODIFIED BY KSNiloc...
    
        If UCase$(lit$) = "ON" Then
            Underline = True
        Else
            Underline = False
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Public Sub VariableManip(ByVal Text As String, ByRef theProgram As RPGCodeProgram, Optional ByVal noErrors As Boolean = False)
 
    '#Variable!$=value+value
    'Variable manipulator

    On Error Resume Next
    
    Dim valueList(100) As String
    
    Dim textTst As String
    Dim Destination As String
    Dim t As Long
    Dim dType As Long
    Dim tst As Long
    Dim equal As String
    Dim fType As String
    Dim number As Long, lit As String
    
    textTst$ = Text$ + "+0+0"
    number = ValueNumber(textTst$)     'How many elements do we have?
    
    'Changed to 0... [KSNiloc]
    If number <= 0 Then
        Call debugger("Error: Variable expresion requires more data!-- " + Text$)
        Exit Sub
    End If
    Destination$ = GetVarList(textTst$, 1) 'get first var (dest)
    Destination$ = removeChar(Destination$, "#")
    Destination$ = removeChar(Destination$, " ")
    Destination$ = removeChar(Destination$, Chr$(9))    'remove tabs
    For t = 2 To number
        valueList$(t) = GetVarList(textTst$, t) 'get values on other side of equals
        If Not (stringContains(valueList$(t), Chr$(34))) Then
            valueList$(t) = removeChar(valueList$(t), " ")  'remove spaces if not a lit var
        End If
    Next t
    dType = dataType(Destination$)
    Select Case dType
        Case 0:
            'destination is numerical var
            Dim numberUse(100) As Double
            For t = 2 To number
                tst = getValue(valueList$(t), lit$, numberUse(t), theProgram)
                'If tst = 1 Then
                '    Call debugger("Error: Values on right must be numerical!-- " + text$)
                '    Exit Sub
                'End If
            Next t
            'Now to perform math on values
            
            'Allow for some other cool stuff [KSNiloc]...
            equal = MathFunction(Text, 1)
            If equal = "++" Or equal = "--" Then
                'If Not number = 1 Then
                '    debugger "Error: ++ and -- equations should have nothin" _
                '        & "g on the right side-- " & text
                '    Exit Sub
                'End If
            End If
            Select Case equal
                Case "++"
                    SetVariable Destination, _
                        CBGetNumerical(Destination) + 1, theProgram
                    Exit Sub
                Case "--"
                    SetVariable Destination, _
                        CBGetNumerical(Destination) - 1, theProgram
                    Exit Sub
                Case "+=", "=+"
                Case "-=", "=-"
                Case "*=", "=*"
                Case "/=", "=/"
                Case "="
                Case Else
                    debugger "Error: Invalid conjunction-- " & equal
                    Exit Sub
            End Select

            'Evaluate the equation
            Dim build As String
            For t = 2 To number
                build = build & numberUse(t) & MathFunction(textTst, t)
            Next t
            build = Mid(build, 1, Len(build) - 2)
            numberUse(number) = RPGCEvaluate(build)

            If equal = "-=" Or equal = "=-" Then
                SetVariable Destination, _
                    str(CBGetNumerical(Destination) - _
                    numberUse(number)), theProgram
            ElseIf equal = "+=" Or equal = "=+" Then
                SetVariable Destination, _
                    str(numberUse(number) + CBGetNumerical(Destination)), theProgram
            ElseIf equal = "=*" Or equal = "*=" Then
                SetVariable Destination, _
                    str(numberUse(number) * CBGetNumerical(Destination)), theProgram
            ElseIf equal = "/=" Or equal = "=/" Then
                SetVariable Destination, _
                    str(CBGetNumerical(Destination) / numberUse(number)), theProgram
            Else
                Call SetVariable(Destination$, str$(numberUse(number)), theProgram)
            End If

        Case 1:
            ReDim Lituse$(100)
            For t = 2 To number
                Dim num As Double
                tst = getValue(valueList$(t), Lituse$(t), num, theProgram)
                'If tst = 0 Then
                '    Call debugger("Error: Values on right must be literal!-- " + Text$)
                '    Exit Sub
                'End If
                'MsgBox lituse$(t)
            Next t
            'Now to perform "math" on values
            equal$ = MathFunction(Text$, 1)
            'Select Case equal
            'If equal$ <> "=" Then
            '    If Not noErrors Then Call debugger("Error: No equal sign!-- " + text$)
            '    Exit Sub
            'End If
            For t = 2 To number - 1
                fType$ = MathFunction(Text$, t)
                'Select Case ftype$
                '    Case "+":
                        Lituse$(t + 1) = Lituse$(t) + Lituse$(t + 1)
                'End Select
            Next t
            
            If equal = "+=" Or equal = "=+" Then
                SetVariable Destination, _
                    CBGetString(Destination) & Lituse(number), theProgram
            Else
                SetVariable Destination$, Lituse$(number), theProgram
            End If
            
        Case 2, 3:
            If Not noErrors Then Call debugger("Error: Value on left must be a valid variable!-- " + Text$)
            Exit Sub
    End Select
End Sub


Sub ViewBrd(Text$, ByRef theProgram As RPGCodeProgram)
    '#ViewBrd("board.brd", [topx!, topy!])
    'View a board
    'Backup board graphics:
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    Dim oldtX As Double, oldtY As Double
    oldtX = topX: oldtY = topY
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If Not (number = 1 Or number = 3) Then
        Call debugger("Warning: ViewBrd has must have 1 or 3 data elements!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If number = 3 Then
        useIt2$ = GetElement(dataUse$, 2)
        useIt3$ = GetElement(dataUse$, 3)
    Else
        useIt2$ = "1"
        useIt3$ = "1"
    End If
    
    Dim b As Long, c As Long, brd As String, hdc As Long
    a = getValue(useIt$, lit$, num, theProgram)
    b = getValue(useIt2$, lit$, num2, theProgram)
    c = getValue(useIt3$, lit$, num3, theProgram)
    If a = 0 Or b = 1 Or c = 1 Then
        Call debugger("Error: ViewBrd data type must be literal, num, num!-- " + Text$)
    Else
        brd$ = addExt(lit$, ".brd")
        Dim boardTemp As TKBoard
        boardTemp = boardList(activeBoardIndex).theData
        Call openboard(projectPath$ + brdPath$ + brd$, boardList(activeBoardIndex).theData)
        lastRender.canvas = -1
        ChDir (projectPath$)
        If pakFileRunning Then
            Call ChangeDir(PakTempPath$)
            a = GFXDrawBoardCNV(cnvRPGCodeScreen, -1, 0, num2 - 1, num3 - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, 0, 0, 0, 0)
            Call ChangeDir(currentDir$)
        Else
            a = GFXDrawBoardCNV(cnvRPGCodeScreen, -1, 0, num2 - 1, num3 - 1, tilesX, tilesY, boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, 0, 0, 0, 0)
            'a = GFXdrawboard(brdpath$ + brd$, 0, num2 - 1, num3 - 1, 0, 0, 0, tilesX, tilesY, vbpichdc(mainForm.boardform))
        End If
        boardList(activeBoardIndex).theData = boardTemp
        ChDir (currentDir$)
        Call renderRPGCodeScreen
        topX = oldtX: topY = oldtY
    End If
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WaitRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#Wait (var$)
    'Puts key press in var$
    On Error GoTo errorhandler
    
    Dim var As String
    Dim keyP As String
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number = 1 Then
        var$ = GetElement(dataUse$, 1)
        'messagewindow.show
        keyP$ = WaitForKey()
        Call SetVariable(var$, keyP$, theProgram)
    Else
        keyP$ = WaitForKey()
    End If
    
    retval.dataType = DT_LIT
    retval.lit = keyP$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CreateCursorMapRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    'dest! = #CreateCursorMap([dest!])
    'create a new cursor map, and return it's index
    On Error Resume Next
    
    Dim var As String
    Dim keyP As String
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number = 1 Then
        var$ = GetElement(dataUse$, 1)
        
        idx = CreateCursorMapTable()
        Call SetVariable(var$, str$(idx), theProgram)
    Else
        idx = CreateCursorMapTable()
    End If
    
    retval.dataType = DT_NUM
    retval.num = idx
End Sub


Sub KillCursorMapRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#KillCursorMap(idx!)
    'destroy the cursor map at index idx
    On Error Resume Next
    
    Dim var As String
    Dim keyP As String
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 1 Then
        Call debugger("Error: KillCursorMap must have 1 data element!-- " + Text$)
    Else
        useIt1$ = GetElement(dataUse$, 1)
        a = getValue(useIt1$, lit1$, num1, theProgram)
        If a <> DT_NUM Then
            Call debugger("Error: KillCursorMap data type must be numerical!-- " + Text$)
        Else
            Call DeleteCursorMapTable(num1)
        End If
    End If
End Sub

Sub CursorMapAddRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#CursorMapAdd(x!, y!, mapidx!)
    'add a hotspot to the cursor map mapidx! at coord x!, y! (pixels)
    On Error Resume Next
    
    Dim var As String
    Dim keyP As String
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 3 Then
        Call debugger("Error: CursorMapAdd must have 3 data elements!-- " + Text$)
    Else
        useIt1$ = GetElement(dataUse$, 1)
        useIt2$ = GetElement(dataUse$, 2)
        useIt3$ = GetElement(dataUse$, 3)
        a = getValue(useIt1$, lit1$, num1, theProgram)
        Dim b As Long, c As Long
        b = getValue(useIt2$, lit2$, num2, theProgram)
        c = getValue(useIt3$, lit3$, num3, theProgram)
        If a <> DT_NUM Or b <> DT_NUM Or c <> DT_NUM Then
            Call debugger("Error: CursorMapAdd data type must be num, num num!-- " + Text$)
        Else
            Dim cm As CURSOR_MAP
            cm.x = num1
            cm.y = num2
            cm.downLink = -1
            cm.leftLink = -1
            cm.rightLink = -1
            cm.upLink = -1
            Call CursorMapAdd(cm, cursorMapTables(num3))
        End If
    End If
End Sub


Sub CreateCanvasRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#cnvId! = CreateCanvas(sizex!, sizey!, [cnvId!])
    'create an offscreen canvas
    On Error Resume Next
    
    Dim use As String
    Dim dataUse As String
    Dim number As Long
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 2 And number <> 3 Then
        Call debugger("Error: CreateCanvas must have 2 or 3 data elements!-- " + Text$)
    Else
        Dim useIt1 As String, useIt2 As String, useIt3 As String
        useIt1 = GetElement(dataUse$, 1)
        useIt2 = GetElement(dataUse$, 2)
        useIt3 = GetElement(dataUse$, 3)
        
        Dim a As Long, b As Long
        Dim lit1 As String, lit2 As String
        Dim num1 As Double, num2 As Double
        
        a = getValue(useIt1$, lit1$, num1, theProgram)
        b = getValue(useIt2$, lit2$, num2, theProgram)
        
        If a <> DT_NUM Or b <> DT_NUM Then
            Call debugger("Error: CreateCanvas data type must be num, num!-- " + Text$)
        Else
            Dim cnv As Long
            cnv = CreateCanvas(num1, num2)
            Call CanvasFill(cnv, 0)
            
            retval.num = cnv
            retval.dataType = DT_NUM
            
            If number = 3 Then
                Call SetVariable(useIt3, str$(cnv), theProgram)
            End If
        End If
    End If
End Sub


Sub DrawCanvasRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#DrawCanvas(cnvId!, x!, y!, [sizex!, sizey!, [destcnvId!]])
    'draw a canvas to the screen
    'optionally resize it
    On Error Resume Next

    Dim use As String
    Dim dataUse As String
    Dim number As Long
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 3 And number <> 5 And number <> 6 Then
        Call debugger("Error: DrawCanvas must have 3 or 5 or 6 data elements!-- " + Text$)
    Else
        Dim useIt1 As String, useIt2 As String, useIt3 As String, useIt4 As String, useIt5 As String, useIt6 As String
        useIt1 = GetElement(dataUse$, 1)
        useIt2 = GetElement(dataUse$, 2)
        useIt3 = GetElement(dataUse$, 3)
        useIt4 = GetElement(dataUse$, 4)
        useIt5 = GetElement(dataUse$, 5)
        useIt6 = GetElement(dataUse$, 6)
        
        Dim a As Long, b As Long, c As Long, d As Long, e As Long, f As Long
        Dim lit1 As String, lit2 As String, lit3 As String, lit4 As String, lit5 As String, lit6 As String
        Dim num1 As Double, num2 As Double, num3 As Double, num4 As Double, num5 As Double, num6 As Double
        a = getValue(useIt1$, lit1$, num1, theProgram)
        b = getValue(useIt2$, lit2$, num2, theProgram)
        c = getValue(useIt3$, lit3$, num3, theProgram)
        d = getValue(useIt4$, lit4$, num4, theProgram)
        e = getValue(useIt5$, lit5$, num5, theProgram)
        f = getValue(useIt5$, lit6$, num6, theProgram)
        
        'If a <> DT_NUM Or b <> DT_NUM Or c <> DT_NUM Or d <> DT_NUM Or E <> DT_NUM Or f <> DT_NUM Then
        '    Call debugger("Error: DrawCanvas data type must be num, num, num, num, num!-- " + text$)
        'Else
            Dim cnv As Long
            cnv = num1
            If number = 3 Then
                'straight blt
                Call Canvas2CanvasBlt(cnv, cnvRPGCodeScreen, num2, num3)
                Call renderRPGCodeScreen
            Else
                'resize blt
                Dim cnvDest As Long
                cnvDest = cnvRPGCodeScreen
                If number = 6 Then
                    cnvDest = num6
                End If
                
                Dim hdcDest As Long
                hdcDest = CanvasOpenHDC(cnvDest)
                
                Call CanvasStretchBlt(cnv, num4, num5, num2, num3, hdcDest)
                
                Call CanvasCloseHDC(cnvDest, hdcDest)
                
                If number = 5 Then
                    Call renderRPGCodeScreen
                End If
            End If
        'End If
    End If
End Sub



Sub KillCanvasRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#KillCanvas(cnvId!)
    'kill an offscreen canvas
    On Error Resume Next
    
    Dim use As String
    Dim dataUse As String
    Dim number As Long
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 1 Then
        Call debugger("Error: KillCanvas must have 1 data element!-- " + Text$)
    Else
        Dim useIt1 As String
        useIt1 = GetElement(dataUse$, 1)
        
        Dim a As Long
        Dim lit1 As String
        Dim num1 As Double

        a = getValue(useIt1$, lit1$, num1, theProgram)
        
        If a <> DT_NUM Then
            Call debugger("Error: KillCanvas data type must be num!-- " + Text$)
        Else
            Call DestroyCanvas(num1)

            retval.dataType = DT_VOID
        End If
    End If
End Sub




Sub CursorMapRunRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#selected! = #CursorMapRun(mapidx!, [selected!])
    'run the cursor map at mapidx!
    'return the index of the selection
    On Error Resume Next
    
    Dim var As String
    Dim keyP As String
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    Dim idx As Long
    If number <> 1 And number <> 2 Then
        Call debugger("Error: CursorMapRun must have 1 or 2 data elements!-- " + Text$)
    Else
        useIt1$ = GetElement(dataUse$, 1)
        useIt2$ = GetElement(dataUse$, 2)
        a = getValue(useIt1$, lit1$, num1, theProgram)
        If a <> DT_NUM Then
            Call debugger("Error: CursorMapAdd data type must be numerical!-- " + Text$)
        Else
            Dim res As Long
            res = CursorMapRun(cursorMapTables(num1))
            retval.dataType = DT_NUM
            retval.num = res
            If number = 2 Then
                Call SetVariable(useIt2$, str$(res), theProgram)
            End If
        End If
    End If
End Sub



Sub WalkSpeedRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#WalkSpeed("fast/slow")
    'change chr walk speed.
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: WalkSpeed is obsolete!-- " + Text$)
    
    'On Error GoTo errorhandler
    'use$ = text$
    'dataUse$ = GetBrackets(use$)    'Get text inside brackets
    'number = CountData(dataUse$)        'how many data elements are there?
    'If number <> 1 Then
    '    Call debugger("Warning: WalkSpeed has more than 1 data element!-- " + text$)
    'End If
    'useIt$ = GetElement(dataUse$, 1)
    'If useIt$ = "" Then
    '    Call debugger("Error: WalkSpeed has no data element!-- " + text$)
    '    Exit Sub
    'End If
    'a = GetValue(useIt$, lit$, num, theprogram)
    'If a = 0 Then
    '    Call debugger("Error: WalkSpeed data type must be literal!-- " + text$)
    'Else
    '    If UCase$(lit$) = "FAST" Then
    '        walkspeed = 0
    '    Else
    '        walkspeed = 1
    '    End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WanderRPG(Text$, ByRef theProgram As RPGCodeProgram)

    'REWRITTEN: [Isometrics - Delano - 18/04/04]
    'Added diagonal wandering, optional restricting of directions.
    'Renamed variables: b >> parameter1Type
    '                   inum >> itemNum
    
    'Now: #Wander(itemNum! [, restrict!])
    'Previously: #Wander(itemnum!)
    'Causes an item to wander (target OK)
    
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)        'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    
    If number <> 1 And number <> 2 Then
        Call debugger("Warning: Wander should have 1 or 2 data elements!-- " + Text$)
    End If
    
    useIt1$ = GetElement(dataUse$, 1)
   
    Dim parameter1Type As Long, itemNum As Long
    
    parameter1Type = getValue(useIt1$, lit1$, num1, theProgram)
    itemNum = num1
    
    If parameter1Type = 1 Then
        'If 1st parameter [itemnum!] is literal...
        
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 1 Then itemNum = target
            
        ElseIf UCase$(lit1$) = "SOURCE" Then
            If sourceType = 1 Then itemNum = Source
            
        Else
            'Not something we want.
            Call debugger("Error: Wander data type must be lit, num!-- " + Text$)
            Exit Sub
        End If
    End If
    
    'Isometric adaption:
    'Enabling all directions and allowing sets to be chosen (needs new argument)
    
    Dim direction As Long, lowest As Long, highest As Long, restrict As Long, restrictString As String
    'direction, lowest, highest take values corresponding to direction constants as defined in transMovement.
    'restrict is direction restrict code, see below for definitions.
    restrict = 0
  
    If number = 2 Then 'There is a second element.
        restrictString$ = GetElement(dataUse$, 2)
        
        Dim parameter2Type As Long
        parameter2Type = getValue(restrictString$, lit2$, num2, theProgram)
        
        If parameter2Type = 1 Then
            'If variable is literal, will use the defaults
            Call debugger("Error: Wander data type must be lit, num!-- " + Text$)
        Else
            restrict = num2
        End If
    End If

    
    'Defaults. Might want to change.
    If boardIso() Then
        lowest = 5: highest = 8 'Diagonals
    Else
        lowest = 1: highest = 4 'Axes
    End If
        
    'Make sure restrict is in the required range: inbounds will put it in range.
    restrict = inBounds(restrict, 0, 3)
       
    Select Case restrict
        Case 0:
            'Defaults
        Case 1:
            lowest = 1: highest = 4 'Only vertical, horizontal
        Case 2:
            lowest = 5: highest = 8 'Only diagonals
        Case 3:
            lowest = 1: highest = 8 'All
    End Select
        
    'Has been seeded by Randomize Timer in Mod transMain Sub initgame
    direction = Int((highest - lowest + 1) * Rnd + lowest)
        
    If direction > highest Or direction < lowest Then
        'This shouldn't occur, but just in case:
        MsgBox "Invalid wander direction number! Please report this. Blame Delano."
        Exit Sub
    End If
    
    pendingItemMovement(itemNum).direction = direction
    pendingItemMovement(itemNum).xOrig = itmPos(itemNum).x
    pendingItemMovement(itemNum).yOrig = itmPos(itemNum).y
    pendingItemMovement(itemNum).lOrig = itmPos(itemNum).l
    Call insertTarget(pendingItemMovement(itemNum))
    
    If isMultiTasking() Then
        'if multitasking, let the mainloop take care of this
        movementCounter = 0
        gGameState = GS_MOVEMENT
    Else
        'if running a regular program, move the sprite now
        Call runQueuedMovements
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WavRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Wav ("filename.wav/mp3")
    'Play wav or mp3 file
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Wav has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Wav data type must be literal!-- " + Text$)
    Else
        Dim ext As String
        ext$ = GetExt(lit$)
        dataUse$ = projectPath$ & mediaPath$ & lit$
        dataUse$ = PakLocate(dataUse$)
        Call playSoundFX(dataUse$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WavStopRPG(Text$, ByRef theProgram As RPGCodeProgram)
    'WavStop()
    'Stop wav
    On Error GoTo errorhandler
    
    Call TKAudiereStop(fgDevice)
    
    mediaContainer.soundfx.Command = "stop"
    mediaContainer.soundfx.Command = "close"
    'Call StopMCI("soundfx")
    
    'wFlags% = SND_ASYNC
    'x% = sndPlaySound("stop__.wav", wFlags%)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function WhileRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long
'While(condition)
'{
'   ...
'   ...
'}
'While loop

    On Error GoTo errorhandler
    
     ' ! MODIFIED BY KSNiloc...
    
    Dim use As String
    use$ = Text$
    Dim dataUseWhile As String
    dataUseWhile$ = GetBrackets(use$)    'Get text inside brackets
    'Now evaluate condition:
    
    Dim res As Long
    Dim oldLine As Long
    Dim newPos As Long
    Dim u As String
    Dim curLine As Long
    u = use
    
    theProgram.programPos = increment(theProgram)
    res = Evaluate(dataUseWhile$, theProgram)
    
    Dim okToRun As Boolean
    If LCase(GetCommandName(Text, theProgram)) = "until" Then
        If res = 0 Then okToRun = True
    Else
        If res = 1 Then okToRun = True
    End If

    If okToRun Then
    
        If isMultiTasking() And (Not theProgram.looping) Then

            'Let the main loop handle this...
            If Not LCase(GetCommandName(Text, theProgram)) = "until" Then
                startThreadLoop theProgram, TYPE_WHILE, dataUseWhile
            Else
                startThreadLoop theProgram, TYPE_UNTIL, dataUseWhile
            End If
            WhileRPG = theProgram.programPos
            Exit Function

        Else

            Dim done As Boolean
            Do Until done
                res = Evaluate(dataUseWhile$, theProgram)
                
                If LCase(GetCommandName(Text, theProgram)) = "until" Then
                    If res = 0 Then
                        res = 1
                    ElseIf res = 1 Then
                        done = True
                        res = 0
                    End If
                Else
                    If res = 0 Then done = True
                End If
                
                oldLine = theProgram.programPos
                newPos = runBlock(u, res, theProgram)
                curLine = oldLine
                theProgram.programPos = oldLine

                DoEvents 'Let windows do events so we don't lock up.
            Loop
            
        End If

    Else
    
        'If isMultiTasking() Then
        '
        '    theProgram.looping = False
        '    loopEnd(num) = True
        '
        'End If
    
    End If

    'If I'm here, then res=0, and we must run through once more.
    WhileRPG = runBlock(Text$, res, theProgram)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub BitmapRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Bitmap("file.bmp", [cnvId!])
    'Show bmp
    On Error GoTo errorhandler

    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 And number <> 2 Then
        Call debugger("Error: Bitmap must have 1 or 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    If useIt1$ = "" Then
        Call debugger("Error: Bitmap has no data element!-- " + Text$)
        Exit Sub
    End If
    Dim b As Long
    a = getValue(useIt1$, lit1$, num1, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = DT_NUM Then
        Call debugger("Error: Bitmap data type must be literal!-- " + Text$)
    Else
        lit1$ = addExt(lit1$, ".bmp")
        lit1$ = projectPath$ & bmpPath$ & lit1$
        
        Dim cnvDest As Long
        cnvDest = cnvRPGCodeScreen
        
        If number = 2 Then
            cnvDest = num2
        End If
        Call CanvasLoadSizedPicture(cnvDest, lit1$)
        
        If number = 1 Then
            Call renderRPGCodeScreen
        End If
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub BoldRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Bold(ON/OFF)
    'Turn bold on/off
    On Error GoTo errorhandler
    Dim use As String, a As Long, lit As String, dataUse As String, number As Long, num As Double, useIt As String
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Bold has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Bold has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Bold data type must be literal!-- " + Text$)
    Else
        
        ' ! MODIFIED BY KSNiloc...
    
        If UCase$(lit$) = "ON" Then
            Bold = True
        Else
            Bold = False
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub BorderColorRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#BorderColor(rr!,gg!,bb!)
    'set border color.
    'OBSOLETE (Nov 5, 2002)
    On Error Resume Next
    Call debugger("Warning: BorderColor is obsolete!-- " + Text$)
End Sub

Sub Branch(Text$, ByRef theProgram As RPGCodeProgram)
    '#Branch (:label name)
    'Branches to :label name
    'label can also be a string var
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Branch has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    
    Dim dType As Long
    dType = getValue(useIt, lit, num, theProgram)
    useIt = lit
    
    If useIt$ = "" Then
        Call debugger("Error: Branch has no label element!-- " + Text$)
        Exit Sub
    End If
    
    'Now to find where this is at:
    Dim foundIt As Long, t As Long, test As String
    foundIt = -1
    For t = 0 To theProgram.Length
        test$ = theProgram.program$(t)
        If UCase$(test$) = UCase$(useIt$) Then
            foundIt = t
            Exit For
        End If
    Next t
    If foundIt = -1 Then
        Call debugger("Error: Branch label not found!-- " + Text$)
    Else
        theProgram.programPos = foundIt
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub callShopRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#CallShop("item1.itm","item2.item",...,"itemn.itm")
    'opens shop window to sell items.
    On Error GoTo errorhandler
    Dim t As Long  'These variables are for For loops
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    For t = 1 To number
        itemsForSale$(t) = ""           'initializes the array to "" so we don't get any barfs
        useIt1$ = GetElement(dataUse$, t)   'Gets an element out of the brackets
        Dim cst As Long
        cst = getValue(useIt1$, lit$, num1, theProgram) 'Not so sure what this does yet but I know the cst is a bool that is 0 if it didn't cast "which is never" and 1 if it does
        If (lit$ = "") Then                             'If there is not any items in the command to put in the shop then it causes a debug message
            Call debugger("Error: CallShop data type must be literal!-- " + Text$)
        Else                                            ' Else it carries on its marry way to add the item to the shop.
        lit$ = addExt(lit$, ".itm")
        itemsForSale$(t) = lit$
        End If
    Next t
    'only show the shop if not in fullscreen mode or no debug messages...
    If Not (usingFullScreen() Or lit$ = "") Then
        shopwindow.Show 1  'show the shop
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CastIntRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #CastInt(source![,dest!])
    'Changes floating point to int.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: CastInt must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim cst As Long
    cst = getValue(useIt1$, lit$, num1, theProgram)
    If cst = 1 Then
        Call debugger("Error: CastInt data type must be numerical!-- " + Text$)
    Else
        Dim value As Long
        value = Int(num1)
        If number = 2 Then
            Call SetVariable(useIt2$, str$(value), theProgram)
        End If
        retval.dataType = DT_NUM
        retval.num = value
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CastLitRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #CastLit(source![,dest$])
    'Casts a num to a string
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: CastLit must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim cst As Long, value As String
    cst = getValue(useIt1$, lit$, num1, theProgram)
    If cst = 1 Then
        Call debugger("Error: CastLit data type must be numerical!-- " + Text$)
    Else
        value$ = str$(num1)
        value$ = removeChar(value$, " ")
        ' ! MODIFIED BY KSNiloc
        If number = 2 Then
            Call SetVariable(useIt2$, value, theProgram)
        End If
        retval.dataType = DT_LIT
        retval.lit = value
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CastNumRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a! = #CastNum(source$![,dest!])
    'Casts a string to a num
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 And number <> 1 Then
        Call debugger("Error: CastNum must have 2 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim cst As Long, value As Double
    cst = getValue(useIt1$, lit$, num1, theProgram)
    If cst = DT_NUM Then
        'silently recover...
        lit = toString(num1)
    End If
    value = val(lit$)
    If number = 2 Then
        Call SetVariable(useIt2$, str$(value), theProgram)
    End If
    retval.dataType = DT_NUM
    retval.num = value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Change(Text$, ByRef theProgram As RPGCodeProgram)
    '#Change ("program.prg")
    'Changes program filename
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    num = CountData(dataUse$)        'how many data elements are there?
    If num <> 1 Then
        Call debugger("Warning: Change has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Change has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Change data type must be literal!-- " + Text$)
    Else
        lit$ = addExt(lit$, ".prg")
        If theProgram.boardNum >= 0 Then
            boardList(activeBoardIndex).theData.programName$(theProgram.boardNum) = lit$
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub CharAtRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #CharAt("text",loc![,dest$])
    'gets character at location loc!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 And number <> 2 Then
        Call debugger("Error: CharAt must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim redc As Long, greenc As Long
    redc = getValue(useIt1$, lit1$, num1, theProgram)
    greenc = getValue(useIt2$, lit2$, num2, theProgram)
    If redc = 0 Or greenc = 1 Then
        Call debugger("Error: CharAt data type must be lit, num, lit!-- " + Text$)
    Else
        Dim Length As Long, cH As String
        Length = Len(lit1$)
        'num2 = inbounds(num2, 1, length)
        cH$ = Mid$(lit1$, num2, 1)
        If number = 3 Then
            Call SetVariable(useIt3$, cH$, theProgram)
        End If
        retval.dataType = DT_LIT
        retval.lit = cH$
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub clearBufferRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ClearBuffer()
    'clears keyboard buffer.
    On Error GoTo errorhandler
    Call FlushKB

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ClearRPG(Text$, ByRef theProgram As RPGCodeProgram)

    '#Clear()
    'Clears the screen to black
    On Error GoTo errorhandler

    Call CanvasFill(cnvRPGCodeScreen, 0)
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ColorRGB(Text$, ByRef theProgram As RPGCodeProgram)
    '#ColorRGB (red!, green!, blue!)
    'Changes Font color. (RGB color code)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: ColorRGB must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim redc As Long, greenc As Long, bluec As Long
    redc = getValue(useIt1$, lit$, num1, theProgram)
    greenc = getValue(useIt2$, lit$, num2, theProgram)
    bluec = getValue(useIt3$, lit$, num3, theProgram)
    If redc = 1 Or greenc = 1 Or bluec = 1 Then
        Call debugger("Error: Color data type must be numerical!-- " + Text$)
    Else
        num1 = inBounds(num1, 0, 255)
        num2 = inBounds(num2, 0, 255)
        num3 = inBounds(num3, 0, 255)
        fontColor = RGB(num1, num2, num3)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ColorRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Color (color_code!)
    'Changes Font color (dos)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Color has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: Color data type must be numerical!-- " + Text$)
    Else
        num = inBounds(num, 0, 255)
        fontColor = GFXGetDOSColor(num)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub KillThreadRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#KillThread(threadID!)
    'kill a thread that is running
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: KillThread has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: KillThread data type must be numerical!-- " + Text$)
    Else
        Call KillThread(num)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ThreadSleepRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)
    '#ThreadSleep(threadID!, duration!)
    'put a thread to sleep for duration! seconds.
    On Error GoTo errorhandler
    
    Dim use As String, dataUse As String, number As Long
    Dim useIt1 As String, useIt2 As String
    Dim a As Long, b As Long
    Dim lit1 As String, lit2 As String
    Dim num1 As Double, num2 As Double
    
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Warning: ThreadSleep must have 2 data elements!-- " + Text$)
    End If
    useIt1 = GetElement(dataUse$, 1)
    useIt2 = GetElement(dataUse$, 2)
    a = getValue(useIt1, lit1, num1, theProgram)
    b = getValue(useIt2, lit2, num2, theProgram)
    If a = 1 Or b = 1 Then
        Call debugger("Error: KillThread data type must be num, num!-- " + Text$)
    Else
        Call ThreadSleep(num1, num2)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DebugRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Debug(ON/OFF)
    'Turn debugger on/off
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Debug has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        Call debugger("Error: Debug has no data element!-- " + Text$)
        Exit Sub
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: Debug data type must be literal!-- " + Text$)
    Else
        If UCase$(lit$) = "ON" Then
            debugYN = 1
        Else
            debugYN = 0
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DelayRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Delay(1.4)
    'Delay for a number of seconds.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Delay has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: Delay data type must be numerical!-- " + Text$)
    Else
        Dim delayLength As Double, t1 As Long, c As Double, t2 As Long
        delayLength = num
        
        Dim millis As Long
        millis = delayLength * 1000
        Call Sleep(millis)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DirSavRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
    '#a$ = #DirSav([dest$])
    'get dir of saved games, put
    'selected file in dest$
    'puts CANCEL in dest if cancelled.
    On Error Resume Next
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    useIt$ = GetElement(dataUse$, 1)
    If number = 0 Then useIt$ = ""
    
    Dim r As String
    r = ShowFileDialog(savPath$, "*.sav")
    
    Dim file As String
    file = r
    If file = "" Then file = "CANCEL"
    
    If number = 1 Then
        Call SetVariable(useIt$, file$, theProgram)
    End If
    retval.dataType = DT_LIT
    retval.lit = file$
End Sub

Sub done(Text$, ByRef theProgram As RPGCodeProgram)
    '#Done()
    'Ends program without redrawing screen.
    'Do nothing
    On Error GoTo errorhandler
    Unload dbwin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Dos(Text$, ByRef theProgram As RPGCodeProgram)
    '#Dos()
    'Return to OS (Windows)
    On Error GoTo errorhandler
    gGameState = GS_QUIT
    
    Call closeSystems
   
    endform.Show 1
    End

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub drainAllRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#DrainAll(100)
    'attacks all enemy or players (drains SMP)
    'uses whatever is targeted.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: DrainAll has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: DrainAll data type must be numerical!-- " + Text$)
    Else
        If targetType = 0 Then
            'players targeted.
            Dim t As Long
            For t = 0 To 4
                If playerListAr$(t) <> "" Then
                    Call doAttack(-1, -1, PLAYER_PARTY, 1, num, True)
                End If
            Next t
        End If
        If targetType = 2 Then
            'enemies targeted.
            For t = 0 To numEne - 1
                Call addEnemySMP(-1 * num, enemyMem(t))
                Call doAttack(-1, -1, ENEMY_PARTY, t, num, True)
            Next t
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DrawLineRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#drawLine(x1,y1,x2,y2, [cnvId!])
    'draws a line
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 And number <> 5 Then
        Call debugger("Error: DrawLine must have 4 or 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, x1 As Double, y1 As Double, x2 As Double, y2 As Double, xx1 As Long, yy1 As Long, xx2 As Long, yy2 As Long
    Dim useIt5 As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5 = GetElement(dataUse$, 5)
    
    Dim cnv As Double
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    xx2 = getValue(useIt3$, lit$, x2, theProgram)
    yy2 = getValue(useIt4$, lit$, y2, theProgram)

    ' KSNiloc says: ... ... ... ... ...
    a = getValue(useIt5, lit, cnv, theProgram)
    'a = GetValue(useIt4$, lit$, cnv, theProgram)
    
    'If xx1 = DT_LIT Or yy1 = DT_LIT Or xx2 = DT_LIT Or yy2 = DT_LIT Or a = DT_LIT Then
    '    Call debugger("Error: DrawLine data type must be numerical!-- " + text$)
    'Else
        If number = 4 Then
            Call CanvasDrawLine(cnvRPGCodeScreen, x1, y1, x2, y2, fontColor)
            Call renderRPGCodeScreen
            'DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1 - 10, y1 - 10, x1 - 10, y1 - 10, _
                                x2 - x1 + 10, y2 - y1 + 10
            'DXRefresh
        Else
            Call CanvasDrawLine(cnv, x1, y1, x2, y2, fontColor)
        End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub DrawRectRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#drawRect(x1,y1,x2,y2, [cnvId!])
    'draw rect
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 4 And number <> 5 Then
        Call debugger("Error: DrawRect must have 4 or 5 data elements!-- " + Text$)
        Exit Sub
    End If
    Dim useIt4 As String, x1 As Double, y1 As Double, x2 As Double, y2 As Double, xx1 As Long, yy1 As Long, xx2 As Long, yy2 As Long
    Dim useIt5 As String
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    useIt4$ = GetElement(dataUse$, 4)
    useIt5 = GetElement(dataUse$, 5)
    
    Dim cnv As Double
    xx1 = getValue(useIt1$, lit$, x1, theProgram)
    yy1 = getValue(useIt2$, lit$, y1, theProgram)
    xx2 = getValue(useIt3$, lit$, x2, theProgram)
    yy2 = getValue(useIt4$, lit$, y2, theProgram)

    ' ! MODIFIED BY KSNiloc...
    
    'Uh-huh. Looks like you made a typo, CMB. =P
    'a = GetValue(useIt4$, lit$, cnv, theProgram)
    a = getValue(useIt5, lit, cnv, theProgram)

    'If xx1 = DT_LIT Or yy1 = DT_LIT Or xx2 = DT_LIT Or yy2 = DT_LIT Or a = DT_LIT Then
    '    Call debugger("Error: DrawRect data type must be numerical!-- " + Text$)
    'Else
        If number = 4 Then
            Call CanvasBox(cnvRPGCodeScreen, x1, y1, x2, y2, fontColor)
            'Call renderRPGCodeScreen
            DXDrawCanvasPartial cnvRPGCodeScreen, _
                                x1, y1, x1, y1, _
                                x2 - x1 + 10, y2 - y1 + 10
            DXRefresh
        Else
            Call CanvasBox(cnv, x1, y1, x2, y2, fontColor)
        End If
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub EmptyRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Empty()
    'clears all variables
    On Error GoTo errorhandler
    Call clearVars(globalHeap)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub EndRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#End()
    'End prg or function block.
    'Do nothing.
    On Error GoTo errorhandler
    Unload dbwin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub EquipRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Equip("handle",bodylocation!,"item name")
    'Equips something from the items into a body
    'location.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: Equip must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim hand As Long, bloc As Long, theOne As Long, t As Long, iname As Long
    hand = getValue(useIt1$, lit1$, num1, theProgram)
    bloc = getValue(useIt2$, lit2$, num2, theProgram)
    iname = getValue(useIt3$, lit3$, num1, theProgram)
    If hand = 0 Or bloc = 1 Or iname = 0 Then
        Call debugger("Error: Equip data type must be lit, num, lit!-- " + Text$)
    Else
        theOne = -1
        lit1$ = FindPlayerHandle(lit1$)
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit1$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        'OK, theone is the player to equip to.
        'Now, do we actually have this item?
        Dim theItem As Long
        theItem = -1
        For t = 0 To UBound(inv.item)
            If UCase$(lit3$) = UCase$(inv.item(t).handle) Then
                If inv.item(t).number > 0 Then theItem = t
                Exit For
            End If
            If UCase$(lit3$) = UCase$(inv.item(t).file) Then
                If inv.item(t).number > 0 Then theItem = t
                Exit For
            End If
        Next t
        If theItem = -1 Then
            Call debugger("Error: Player is not carrying specified item!-- " + Text$)
            Exit Sub
        End If
        
        If Not (canItemEquip(projectPath$ + itmPath$ + inv.item(theItem).file)) Then
            Call debugger("Error: Specified Item is Not Equipable!-- " + Text$)
            Exit Sub
        End If

        If Not (CanPlayerUse(projectPath$ + itmPath$ + inv.item(theItem).file, theOne)) Then
            Call debugger("Error: Player cannot use specified item!-- " + Text$)
            Exit Sub
        End If
        
        num2 = inBounds(num2, 1, 16)
        
        'Let's equip!
        Call removeEquip(num2, theOne)
        Call addEquip(num2, theOne, inv.item(theItem).file)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub ErasePlayerRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ErasePlayer("handle")
    'Erase player from board.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Erase has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    Dim aa As Long, theOne As Long, t As Long
    aa = getValue(useIt$, lit$, num, theProgram)
    If lit$ = "" Then
        lit$ = "TARGET"
    End If
        theOne = -1
        For t = 0 To 4
            If UCase$(playerListAr$(t)) = UCase$(lit$) Then theOne = t
        Next t
        If UCase$(lit1$) = "TARGET" Then
            If targetType = 0 Then
                theOne = target
            End If
        End If
        If UCase$(lit1$) = "SOURCE" Then
            If sourceType = 0 Then
                theOne = Source
            End If
        End If
        If theOne = -1 Then Exit Sub 'Player handle not found
        showPlayer(theOne) = False
        Call renderNow
        Call CanvasGetScreen(cnvRPGCodeScreen)
        Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub Fade(Text$, ByRef theProgram As RPGCodeProgram)
    '#Fade(fadetype)
    'Fadesout with specified type
    '0 is 1.4 fadeout and is default
    '1 is a vert line fade
    '2 is a true fade (but not really)
    '3 is a side wipe
    '4 circle down to player
    '5 fade to black
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Fade has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    If useIt$ = "" Then
        useIt$ = "0"
    End If
    a = getValue(useIt$, lit$, num, theProgram)
    
    Dim stepSize As Long
    
    If a = 1 Then
        Call debugger("Error: Fade data type must be numerical!-- " + Text$)
    Else
        Dim xx1 As Double, xx2 As Double, yy1 As Double, yy2 As Double, size As Long
        Select Case num
            Case 0:
                stepSize = 5
                xx1 = (tilesX * 32) / 2
                xx2 = xx1
                yy1 = (tilesY * 32) / 2
                yy2 = yy1
                'Call CanvasLock(cnvRPGCodeScreen)
                For size = 0 To (tilesX * 32) / 2 Step stepSize
                    Call CanvasFillBox(cnvRPGCodeScreen, xx1, yy1, xx2, yy2, fontColor)
                    DXDrawCanvasPartial cnvRPGCodeScreen, _
                                        xx1, yy1, xx1, yy1, _
                                        xx2, yy2
                    DXRefresh
                    xx1 = xx1 - stepSize
                    yy1 = yy1 - stepSize
                    xx2 = xx2 + stepSize
                    yy2 = yy2 + stepSize
                Next size
                For size = 0 To (tilesX * 32) / 2 Step stepSize
                    Call CanvasFill(cnvRPGCodeScreen, 0)
                    Call CanvasFillBox(cnvRPGCodeScreen, xx1, yy1, xx2, yy2, fontColor)
                    'Call renderRPGCodeScreen
                    DXDrawCanvasPartial cnvRPGCodeScreen, _
                                        xx1, yy1, xx1, yy1, _
                                        xx2, yy2
                    DXRefresh
                    xx1 = xx1 + stepSize
                    yy1 = yy1 + stepSize
                    xx2 = xx2 - stepSize
                    yy2 = yy2 - stepSize
                Next size
                Call CanvasFill(cnvRPGCodeScreen, 0)
                'Call CanvasUnlock(cnvRPGCodeScreen)
                Call renderRPGCodeScreen
            Case 1:
                stepSize = 5
                For size = 0 To (tilesX * 32) / 2 Step stepSize * 2
                    Call CanvasFillBox(cnvRPGCodeScreen, size, 0, size + stepSize, 2000, fontColor)
                    Call CanvasFillBox(cnvRPGCodeScreen, size + (tilesX * 32) / 2, 0, size + (tilesX * 32) / 2 + stepSize, 2000, fontColor)
                    Call renderRPGCodeScreen
                Next size
                For size = stepSize To (tilesX * 32) / 2 Step stepSize * 2
                    Call CanvasFillBox(cnvRPGCodeScreen, size, 0, size + stepSize, 2000, fontColor)
                    Call CanvasFillBox(cnvRPGCodeScreen, size + (tilesX * 32) / 2, 0, size + (tilesX * 32) / 2 + stepSize, 2000, fontColor)
                    Call renderRPGCodeScreen
                Next size
                Call CanvasFill(cnvRPGCodeScreen, fontColor)
                For size = 0 To (tilesX * 32) / 2 Step stepSize * 2
                    Call CanvasFillBox(cnvRPGCodeScreen, size, 0, size + stepSize, 2000, 0)
                    Call CanvasFillBox(cnvRPGCodeScreen, size + (tilesX * 32) / 2, 0, size + (tilesX * 32) / 2 + stepSize, 2000, 0)
                    Call renderRPGCodeScreen
                Next size
                For size = stepSize To (tilesX * 32) / 2 Step stepSize * 2
                    Call CanvasFillBox(cnvRPGCodeScreen, size, 0, size + stepSize, 2000, 0)
                    Call CanvasFillBox(cnvRPGCodeScreen, size + (tilesX * 32) / 2, 0, size + (tilesX * 32) / 2 + stepSize, 2000, 0)
                    Call renderRPGCodeScreen
                Next size
                Call CanvasFill(cnvRPGCodeScreen, fontColor)
                Call renderRPGCodeScreen
            Case 2:
                stepSize = -5
                Dim col As Long
                For col = 125 To 0 Step stepSize
                    Call CanvasFill(cnvRPGCodeScreen, RGB(col, col, col))
                    Call renderRPGCodeScreen
                Next col
            Case 3:
                stepSize = 4
                Dim x As Long, skip As Long
                For x = 0 To (tilesX * 32) + 125 Step stepSize
                    Call CanvasFillBox(cnvRPGCodeScreen, 0, 0, x, tilesY * 32, 0)
                    skip = 0
                    For col = 125 To 0 Step stepSize * -2
                        Call CanvasFillBox(cnvRPGCodeScreen, x - skip, 0, x - skip + stepSize, tilesY * 32, RGB(col, col, col))
                        'Call CanvasDrawLine(cnvRPGCodeScreen, x - skip, 0, x - skip, 2000, RGB(col, col, col))
                        skip = skip + stepSize
                    Next col
                    Call renderRPGCodeScreen
                Next x
            Case 4:
                'circle down to player
                stepSize = -2
                Dim pX As Long, pY As Long, wi As Long, radius As Long
                pX = ((ppos(selectedPlayer).x - topX) * 32) - 16
                pY = ((ppos(selectedPlayer).y - topY) * 32) - 16
                'wi = (mainForm.boardform.width / Screen.TwipsPerPixelX) + 100 * ddx
                wi = tilesX * 32 + 200
                'MsgBox Str$(cury(selectedplayer))
                For radius = wi To 0 Step stepSize
                    'mainForm.boardform.Circle (px * ddx, py * ddy), radius, 0
                    Call CanvasDrawEllipse(cnvRPGCodeScreen, pX - radius / 2, pY - radius / 2, pX + radius / 2, pY + radius / 2, 0)
                    Call renderRPGCodeScreen
                Next radius
            Case 5:
                'fade to black...
                Call CanvasFill(cnvAllPurpose, 0)
                Dim cnvTemp As Long
                cnvTemp = CreateCanvas(GetCanvasWidth(cnvRPGCodeScreen), GetCanvasHeight(cnvRPGCodeScreen))
                Call Canvas2CanvasBlt(cnvRPGCodeScreen, cnvTemp, 0, 0)
                stepSize = 25
                Dim t As Long, perc As Double
                For t = 0 To 100 Step stepSize
                    perc = t / 100
                    Call Canvas2CanvasBlt(cnvTemp, cnvRPGCodeScreen, 0, 0)
                    Call Canvas2CanvasBltTranslucent(cnvAllPurpose, cnvRPGCodeScreen, 0, 0, perc, -1, -1)
                    Call renderRPGCodeScreen
                Next t
                Call DestroyCanvas(cnvTemp)
        End Select
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Function Fbranch(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long

    '#FBranch (:label name)
    'Function branch to specified location and execute group of commands.
    
    '=========================================================================
    'Now redirects to Branch() by KSNiloc
    '=========================================================================

    On Error Resume Next
    Call debugger("FBranch() has deprecated into Branch()-- " & Text)
    Call Branch(Text, theProgram)
    Fbranch = theProgram.programPos
    
    'NOTE:  I understand the difference between Branch() and FBranch().
    '       Many community members, however, use FBranch() when they mean for
    '       branch.
    
End Function

Sub FightEnemyRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#FightEnemy("enemy.ene","background.bkg")
    'fight enemy against background.
    On Error GoTo errorhandler
    ReDim en$(4)
    ReDim dat$(5)
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number < 2 Or number > 5 Then
        Call debugger("Error: FightEnemy must have two to five data elements!-- " + Text$)
        Exit Sub
    End If
    Dim t As Long, b As Long, bk As String
    For t = 1 To number
        dat$(t) = GetElement(dataUse$, t)
    Next t
    For t = 1 To number - 1
        a = getValue(dat$(t), en$(t - 1), num, theProgram)
    Next t
    b = getValue(dat$(number), bk$, num2, theProgram)
    If a = 0 Or b = 0 Then
        Call debugger("Error: FightEnemy data must be lit, lit!-- " + Text$)
        Exit Sub
    End If
    For t = 0 To 3
        en$(t) = addExt(en$(t), ".ene")
    Next t
    bk$ = addExt(bk$, ".bkg")
    Call runFight(en$(), number - 1, bk$)
    Do While fightInProgress = True
        a = DoEvents
    Loop

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub FightRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Fight(skill!, bkg$)
    'fight some enemies of skill skill!
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 2 Then
        Call debugger("Error: Fight must have two data elements!-- " + Text$)
        Exit Sub
    End If
    useIt$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    Dim b As Long
    a = getValue(useIt$, lit$, num, theProgram)
    b = getValue(useIt2$, lit2$, num2, theProgram)
    If a = 1 Or b = 0 Then
        Call debugger("Error: Fight data must be num, lit!-- " + Text$)
        Exit Sub
    End If
    lit2$ = addExt(lit2$, ".bkg")
    Call skilledFight(num, lit2$)
    Do While fightInProgress = True
        a = DoEvents
    Loop

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WinColorRGB(Text$, ByRef theProgram As RPGCodeProgram)
    '#WinColorRGB (red!, green!, blue!)
    'Changes Message Window background color. (RGB color code)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 3 Then
        Call debugger("Error: WinColorRGB must have 3 data elements!-- " + Text$)
        Exit Sub
    End If
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    useIt3$ = GetElement(dataUse$, 3)
    Dim redc As Long, greenc As Long, bluec As Long
    redc = getValue(useIt$, lit$, num1, theProgram)
    greenc = getValue(useIt2$, lit$, num2, theProgram)
    bluec = getValue(useIt3$, lit$, num3, theProgram)
    If redc = 1 Or greenc = 1 Or bluec = 1 Then
        Call debugger("Error: WinColor data type must be numerical!-- " + Text$)
    Else
        MWinPic$ = ""
        num1 = inBounds(num1, 0, 255)
        num2 = inBounds(num2, 0, 255)
        num3 = inBounds(num3, 0, 255)
        MWinBkg = RGB(num1, num2, num3)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WinColorRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#WinColor (color_code!)
    'Changes Message Window background color. (Dos color code)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: WinColor has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: WinColor data type must be numerical!-- " + Text$)
    Else
        MWinPic$ = ""
        num = inBounds(num, 0, 255)
        MWinBkg = GFXGetDOSColor(num)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WinGraphic(Text$, ByRef theProgram As RPGCodeProgram)
    '#WinGraphic ("graphic.bmp")
    'Changes Message Window background graphic.
    'The data "NONE" removes the graphic and sets the color to black
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: WinGraphic has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 0 Then
        Call debugger("Error: WinGraphic data type must be literal!-- " + Text$)
    Else
        MWinPic$ = lit$
        MWinBkg = -1
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub WinRPG(ByVal Text As String, ByRef theProgram As RPGCodeProgram)

    '=========================================================================
    'Obsolete
    '=========================================================================

    Call debugger("Win() is obsolete-- " & Text)

End Sub

Public Function addExt(ByVal Text As String, ByVal ext As String) As String

    '=========================================================================
    'Adds the extension passed in a filename if it does not contain one
    '=========================================================================

    On Error Resume Next
    
    Dim txt As String
    Dim theext As String
    
    theext = GetExt(Text)
    If theext = "" Then
        Text = Text & ext
    End If
    addExt = Text

End Function

Public Sub AddToMsgBox(ByVal Text As String, ByRef theProgram As RPGCodeProgram)

    'Adds selected text to message window at line lineNum
    'Should resize mwin.
    
    On Error Resume Next
    
    'size mwin:
    
    bFillingMsgBox = True
    
    Call showMsgBox
    
    Dim pPic As String
    Dim f As String
    
    DoEvents
    If lineNum = 1 Then
        If MWinBkg <> -1 Then
            Call CanvasFill(cnvMsgBox, MWinBkg)
        Else
            pPic$ = projectPath$ & bmpPath$ & MWinPic$
            If pakFileRunning Then
                f$ = PakLocate(bmpPath$ + MWinPic$)
                Call CanvasLoadSizedPicture(cnvMsgBox, f$)
            Else
                Call CanvasLoadSizedPicture(cnvMsgBox, pPic$)
            End If
        End If
    End If
    'DoEvents

    Dim yHeight As Long
    Dim xHeight As Long
    Dim totalLines As Long
    Dim oth As String

    yHeight = GetCanvasHeight(cnvMsgBox)
    xHeight = GetCanvasWidth(cnvMsgBox)
    totalLines = Int(yHeight / fontSize)
    
    totalLines = 10
    
    oth$ = ""
    
    Dim leng As Long
    Dim tot As Long
    
    leng = Len(Text$)
    leng = leng * fontSize
    If leng / 2 > xHeight Then
        tot = Int((xHeight) / fontSize)
        If tot <> 0 Then
            oth$ = Mid$(Text$, tot + 1, Len(Text$) - tot)
            Text$ = Mid$(Text$, 1, tot)
        End If
    End If
    
    Dim hdc As Long
    hdc = CanvasOpenHDC(cnvMsgBox)
    
    Call putText(Text$, _
                    1, _
                    lineNum, _
                    fontColor, _
                    fontSize, _
                    fontSize, _
                    hdc)
    
    Call CanvasCloseHDC(cnvMsgBox, hdc)
    
    Dim doneIt As Long
    Dim l As String
    
    lineNum = lineNum + 1
    If lineNum > totalLines Then
        'here's a tough one.  we have to wait for a key press!
        'first, set line position back to rights.
        'now set flag for keypress:
        'MsgBox "Wait"
        bFillingMsgBox = False
        Call renderRPGCodeScreen
        doneIt = 0
        Do While (doneIt = 0)
            l$ = WaitForKey()
            If l$ <> "UP" Or l$ <> "DOWN" Or l$ <> "LEFT" Or l$ <> "RIGHT" Then
                doneIt = 1
            End If
        Loop
        If MWinBkg <> -1 Then
            Call CanvasFill(cnvMsgBox, MWinBkg)
        Else
            pPic$ = projectPath$ & bmpPath$ & MWinPic$
            If pakFileRunning Then
                f$ = PakLocate(bmpPath$ + MWinPic$)
                Call CanvasLoadSizedPicture(cnvMsgBox, f$)
            Else
                Call CanvasLoadSizedPicture(cnvMsgBox, pPic$)
            End If
        End If
        lineNum = 1
    End If
    If oth$ <> "" Then
        Call AddToMsgBox(oth$, theProgram)
    End If
End Sub

Sub attackAllRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#AttackAll(100)
    'attacks all enemy or players.
    'uses whatever is targeted.
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: AttackAll has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: AttackAll data type must be numerical!-- " + Text$)
    Else
        If targetType = 0 Then
            'players targeted.
            Dim t As Long
            For t = 0 To 4
                If playerListAr$(t) <> "" Then
                    Call doAttack(-1, -1, PLAYER_PARTY, 1, num, False)
                End If
            Next t
        End If
        If targetType = 2 Then
            'enemies targeted.
            For t = 0 To numEne - 1
                If enemyMem(t).eneHP > 0 Then
                    Call addEnemyHP(-1 * num, enemyMem(t))
                    Call doAttack(-1, -1, ENEMY_PARTY, t, num, False)
                End If
            Next t
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub WipeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Wipe("gfx.bmp", type!, [speed!])
    'wipe to a graphic.
    'if the filename is "", then the #savescreen canvas is used
    'type! is the wipe type:
    '1-Wipe right
    '2-Wipe left
    '3-Wipe down
    '4-Wipe up
    '5- wipe from nw to se
    '6- wipe from ne to sw
    '7- wipe from sw to ne
    '8- wipe from se to nw
    '9- wipe right, zelda style
    '10-wipe left, zelda style
    '11-wipe down, zelda style
    '12-wipe up, zelda style
    'speed! is the speed (defaults to 1-- higher == faster)
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    useIt1$ = GetElement(dataUse$, 1)
    useIt2$ = GetElement(dataUse$, 2)
    If number < 2 Then
        Call debugger("Error: Wipe requires 2-3 data elements!-- " + Text$)
        Exit Sub
    End If

    Dim file As String, xx As Long, yy As Long, ttype As Double, zz As Long, speed As Double
    xx = getValue(useIt1$, file$, num1, theProgram)
    yy = getValue(useIt2$, lit$, ttype, theProgram)
    If number = 3 Then
        useIt3$ = GetElement(dataUse$, 3)
        zz = getValue(useIt3$, lit$, speed, theProgram)
    Else
        speed = 1
        zz = 0
    End If
    If xx = 0 Or yy = 1 Or zz = 1 Then
        Call debugger("Error: Wipe data type must be lit, num!, num!-- " + Text$)
    Else
        'load the image...
        If file$ <> "" Then
            file$ = addExt(file$, ".bmp")
            file$ = projectPath$ & bmpPath$ & file$
        End If
        
        Dim cnv As Long
        cnv = CreateCanvas(tilesX * 32, tilesY * 32)
        
        If pakFileRunning Then
            file$ = PakLocate(file$)
        End If
        
        If file$ <> "" Then
            Call CanvasLoadSizedPicture(cnv, file$)
        End If
        
        'copy current screen into other buffer...
        Dim allPurposeC2 As Long
        allPurposeC2 = CreateCanvas(tilesX * 32, tilesY * 32)
        Call Canvas2CanvasBlt(cnvRPGCodeScreen, allPurposeC2, 0, 0)
        
        Dim cv1 As Long, cv2 As Long
        cv1 = cnv
        cv2 = allPurposeC2
        
        If file$ = "" Then
            cv1 = cnvRPGCodeAccess
        End If
               
        Select Case ttype
            Case 1:
                'wipe right...
                For xx = 0 To 32 * tilesX Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, xx, 0)
                    Call renderRPGCodeScreen
                Next xx
        
            Case 2:
                'wipe left...
                For xx = 0 To -32 * tilesX Step -speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, xx, 0)
                    Call renderRPGCodeScreen
                Next xx
        
            Case 3:
                'wipe down...
                For yy = 0 To 32 * tilesY Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, 0, yy)
                    Call renderRPGCodeScreen
                Next yy
        
            Case 4:
                'wipe up...
                For yy = 0 To -32 * tilesY Step -speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, 0, yy)
                    Call renderRPGCodeScreen
                Next yy
        
            Case 5:
                '5- wipe from nw to se
                For yy = 0 To 702 Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    Dim nx As Long, ny As Long
                    nx = Int(0.866 * yy)
                    ny = Int(0.5 * yy)
                    
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, nx, ny)
                    Call renderRPGCodeScreen
                Next yy
            
            Case 6:
                '6- wipe from ne to sw
                For yy = 0 To 702 Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    nx = -Int(0.866 * yy)
                    ny = Int(0.5 * yy)
                    
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, nx, ny)
                    Call renderRPGCodeScreen
                Next yy
            
            Case 7:
                '7- wipe from sw to ne
                For yy = 0 To 702 Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    nx = Int(0.866 * yy)
                    ny = -Int(0.5 * yy)
                    
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, nx, ny)
                    Call renderRPGCodeScreen
                Next yy
                        
            Case 8:
                '8- wipe from se to nw
                For yy = 0 To -702 Step -speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 0)
                    
                    'bitblt old gfx onto screen...
                    nx = Int(0.866 * yy)
                    ny = Int(0.5 * yy)
                    
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, nx, ny)
                    Call renderRPGCodeScreen
                Next yy
        
            Case 9:
                '9- wipe right, zelda style
                For xx = 0 To 32 * tilesX Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, -32 * tilesX + xx, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, xx, 0)
                    Call renderRPGCodeScreen
                Next xx
        
            Case 10:
                '10- wipe left, zelda style
                For xx = 0 To -32 * tilesX Step -speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 32 * tilesX + xx, 0)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, xx, 0)
                    Call renderRPGCodeScreen
                Next xx
        
            Case 11:
                'wipe down, zelda style...
                For yy = 0 To 32 * tilesY Step speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, -32 * tilesY + yy)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, 0, yy)
                    Call renderRPGCodeScreen
                Next yy
        
            Case 12:
                'wipe up, zelda style...
                For yy = 0 To -32 * tilesY Step -speed
                    'bitblt new gfx onto screen...
                    Call Canvas2CanvasBlt(cv1, cnvRPGCodeScreen, 0, 32 * tilesY + yy)
                    
                    'bitblt old gfx onto screen...
                    Call Canvas2CanvasBlt(cv2, cnvRPGCodeScreen, 0, yy)
                    Call renderRPGCodeScreen
                Next yy
        
        End Select
    End If
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(allPurposeC2)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub zoomInRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#ZoomIn(percent!)
    'zooms in the screen by specified percent
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: ZoomIn has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: ZoomIn data type must be numerical!-- " + Text$)
    Else
        'copy current view to cache...
        Dim zoomPerc As Double, tt As Long, newWidth As Long, newHeight As Long
        Dim offx As Long, offy As Long, hdc As Long, hdc2 As Long, zz As Double
        zoomPerc = num
        Dim cnv As Long
        cnv = CreateCanvas(tilesX * 32, tilesY * 32)
        Call Canvas2CanvasBlt(cnvRPGCodeScreen, cnv, 0, 0)
        For tt = 1 To zoomPerc
            'tt = zoomperc
            newWidth = Int(32 * tilesX)
            newHeight = Int(32 * tilesY)
            zz = 1 + (tt / 100)
            
            newWidth = Int(newWidth * zz)
            newHeight = Int(newHeight * zz)
                
            offx = -1 * Int((newWidth - (32 * tilesX)) / 2)
            offy = -1 * Int((newHeight - (32 * tilesY)) / 2)
            
            hdc = CanvasOpenHDC(cnvRPGCodeScreen)
            hdc2 = CanvasOpenHDC(cnv)
            
            a = StretchBlt(hdc, offx, offy, _
                newWidth, newHeight, hdc2, _
                0, 0, Int(tilesX * 32), Int(tilesY * 32), &HCC0020)
            
            Call CanvasCloseHDC(cnvRPGCodeScreen, hdc)
            Call CanvasCloseHDC(cnv, hdc2)
            Call renderRPGCodeScreen
            Call delay(walkDelay)
        Next tt
        Call DestroyCanvas(cnv)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub earthquakeRPG(Text$, ByRef theProgram As RPGCodeProgram)
    '#Earthquake(intensity!)
    'causes earthquake
    On Error GoTo errorhandler
    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    use$ = Text$
    dataUse$ = GetBrackets(use$)    'Get text inside brackets
    number = CountData(dataUse$)        'how many data elements are there?
    If number <> 1 Then
        Call debugger("Warning: Earthquake has more than 1 data element!-- " + Text$)
    End If
    useIt$ = GetElement(dataUse$, 1)
    a = getValue(useIt$, lit$, num, theProgram)
    If a = 1 Then
        Call debugger("Error: Earthquake data type must be numerical!-- " + Text$)
    Else
        'copy current view to cache...
        'allPurposeCanvas = CreateCanvas(tilesX * 32, tilesY * 32)
        Dim zoomPerc As Double, tt As Long, newWidth As Long, newHeight As Long, zz As Double
        Dim offx As Long, offy As Long
        zoomPerc = num
        
        Dim cnv As Long
        cnv = CreateCanvas(tilesX * 32, tilesY * 32)
        Call Canvas2CanvasBlt(cnvRPGCodeScreen, cnv, 0, 0)
        For tt = 1 To num
            newWidth = Int(32 * tilesX)
            newHeight = Int(32 * tilesY)
            
            zz = 1 + (tt / 100)
            newWidth = Int(newWidth * zz)
            newHeight = Int(newHeight * zz)
        
        
            offx = Int((newWidth - (32 * tilesX)) / 2)
            offy = Int((newHeight - (32 * tilesY)) / 2)
            offx = num
            offy = num
            
            Call CanvasFill(cnvRPGCodeScreen, boardList(activeBoardIndex).theData.brdColor)
            Call Canvas2CanvasBltPartial(cnv, cnvRPGCodeScreen, 0, 0, offx, offy, tilesX * 32 - offx, tilesY * 32 - offy)
            Call renderRPGCodeScreen
            Call delay(walkDelay)
        
            Call CanvasFill(cnvRPGCodeScreen, boardList(activeBoardIndex).theData.brdColor)
            Call Canvas2CanvasBltPartial(cnv, cnvRPGCodeScreen, offx, 0, 0, offy, tilesX * 32 - offx, tilesY * 32 - offy)
            Call renderRPGCodeScreen
            Call delay(walkDelay)
        
            Call CanvasFill(cnvRPGCodeScreen, boardList(activeBoardIndex).theData.brdColor)
            Call Canvas2CanvasBltPartial(cnv, cnvRPGCodeScreen, 0, offy, offx, 0, tilesX * 32 - offx, tilesY * 32 - offy)
            Call renderRPGCodeScreen
            Call delay(walkDelay)
        
            Call CanvasFill(cnvRPGCodeScreen, boardList(activeBoardIndex).theData.brdColor)
            Call Canvas2CanvasBltPartial(cnv, cnvRPGCodeScreen, offx, offy, 0, 0, tilesX * 32 - offx, tilesY * 32 - offy)
            Call renderRPGCodeScreen
            Call delay(walkDelay)
        Next tt
        Call Canvas2CanvasBlt(cnv, cnvRPGCodeScreen, 0, 0)
        Call DestroyCanvas(cnv)
        Call renderRPGCodeScreen
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'''Commands by KSNiloc'''

'File manipulation

Sub OpenFileInputRPG(Text$, ByRef theProgram As RPGCodeProgram)

 '#OpenFileInput(filename$,folder$)
 'Opens a file in input mode.

 Dim file As Integer
 file = DoOpenFile(Text$, theProgram)
 If Not file = 0 Then Open openFullFile(file) For Input As #file
End Sub

Sub OpenFileOutputRPG(Text$, ByRef theProgram As RPGCodeProgram)

 '#OpenFileOutput(filename$,folder$)
 'Opens a file in output mode.

 Dim file As Integer
 file = DoOpenFile(Text$, theProgram)
 If Not file = 0 Then Open openFullFile(file) For Output As #file
End Sub

Sub OpenFileAppendRPG(Text$, ByRef theProgram As RPGCodeProgram)

 '#OpenFileAppend(filename$,folder$)
 'Opens a file in append mode.

 Dim file As Integer
 file = DoOpenFile(Text$, theProgram)
 If Not file = 0 Then Open openFullFile(file) For Append As #file
End Sub

Sub OpenFileBinaryRPG(Text$, ByRef theProgram As RPGCodeProgram)

 '#OpenFileInput(filename$,folder$)
 'Opens a file in binary mode.

 Dim file As Integer
 file = DoOpenFile(Text$, theProgram)
 If Not file = 0 Then Open openFullFile(file) For Binary As #file
End Sub

Function DoOpenFile(Text$, ByRef theProgram As RPGCodeProgram) As Integer

 On Error GoTo error

 Dim file As String 'the file to be opened
 Dim folder As String 'the path to the file
 Dim fullfolder As String 'the "full" path of the file
 Dim ff As Integer 'the file spot to be used
 Dim Temp As Variant 'temp variable
 Dim temp2 As Double
 Dim a As Long
 
 Temp = CountData(Text$)
 If Not Temp = 2 Then
  debugger "OpenFile needs two data elements-- " & Text$
  Exit Function
 End If
 
 file = GetElement(GetBrackets(Text$), 1)   'get the parameters that
 temp2 = 0: a = getValue(file, file, temp2, theProgram)
 If Not temp2 = 0 Then
  debugger "OpenFile needs literal data elements-- " & Text$
  Exit Function
 End If
 folder = GetElement(GetBrackets(Text$), 2) 'were passed to the command
 temp2 = 0: a = getValue(folder, folder, temp2, theProgram)
 If Not temp2 = 0 Then
  debugger "OpenFile needs literal data elements-- " & Text$
  Exit Function
 End If
 Select Case LCase(folder) 'retrieve the full path of the folder
  Case "bitmap"
   fullfolder = bmpPath$
  Case "bkrounds"
   fullfolder = bkgPath$
  Case "boards"
   fullfolder = brdPath$
  Case "chrs"
   fullfolder = temPath$
  Case "enemy"
   fullfolder = enePath$
  Case "font"
   fullfolder = fontPath$
  Case "item"
   fullfolder = itmPath$
  Case "media"
   fullfolder = mediaPath$
  Case "misc"
   fullfolder = miscPath$
  Case "prg"
   fullfolder = prgPath$
  Case "spcmove"
   fullfolder = spcPath$
  Case "statuse"
   fullfolder = statusPath$
  Case "tiles"
   fullfolder = tilePath$
  Case "saved"
   fullfolder = savPath$
  Case Else
   debugger "Invalid folder for OpenFile-- " & folder
   Exit Function
 End Select
 
 ff = FreeFile 'check the first free file spot

 ' ! MODIFIED BY KSNiloc...
 If LCase(folder) <> "saved" Then fullfolder = projectPath & fullfolder

 ' ! ADDED BY KSNiloc...
 On Error GoTo dimOpenFile
 If ff > UBound(openFile) Then
    ReDim Preserve openFile(ff)
    ReDim Preserve openFullFile(ff)
 End If
 On Error GoTo error

 ' ! ADDED BY KSNiloc...
 If LCase(GetCommandName(Text, theProgram)) = "openfileinput" Then
    If Not fileExists(App.path & "\" & fullfolder & file) Then
        debugger "Error: " & App.path & "\" & fullfolder & file & " does not exist!"
        Exit Function
    End If
 End If

 openFile(ff) = file 'record the filename
 openFullFile(ff) = App.path & "\" & fullfolder & file

 Open App.path & "\" & fullfolder & file For Append As #ff: Close #ff
 DoOpenFile = ff

 Exit Function
error:
 debugger "Unexpected error with OpenFile-- " & error
 Exit Function
 
' ! ADDED BY KSNiloc...
dimOpenFile:
    ReDim openFile(0)
    ReDim openFullFile(0)
    Resume
End Function

Sub CloseFileRPG(Text$, ByRef theProgram As RPGCodeProgram)
 
 '#CloseFile(filename$)
 'Closes an open file.
 
 On Error GoTo error
 
 ' ! MODIFIED BY KSNiloc...
 
 Dim file As String 'file to close
 Dim Temp As Variant 'temp variable
 Dim a As Long 'used for loops
 Dim temp2 As Double
 
 Temp = CountData(Text$)
 If Not Temp = 1 Then
  debugger "CloseFile needs one data element-- " & Text$
  Exit Sub
 End If
 
 file = GetElement(GetBrackets(Text$), 1) 'get the filename
 temp2 = 0: a = getValue(file, file, temp2, theProgram)
 If Not temp2 = 0 Then
  debugger "CloseFile needs a literal data element-- " & Text$
  Exit Sub
 End If
 For a = 1 To UBound(openFile)
  If openFile(a) = file Then
   openFile(a) = ""
   Exit For
  End If
  If a = UBound(openFile) Then debugger "File is not open-- " & file: Exit Sub
 Next a

 ' ! FIX BY KSNiloc...
 Close #a
 
 Exit Sub
error:
 debugger "Unexpected error with CloseFile-- " & error
End Sub

Public Sub FileInputRPG( _
                           ByVal Text As String, _
                           ByRef theProgram As RPGCodeProgram, _
                           ByRef retval As RPGCODE_RETURN _
                                                            )
 
    'FileInput(filename$)
    'Reads a line from a file
 
    On Error GoTo error
 
    '====================================================================================
    'Re-written by a _much_ more experienced KSNiloc
    '====================================================================================

    If Not CountData(Text) = 1 Then
        debugger "FileInput() requires two data elements-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    If paras(0).dataType <> DT_LIT Then
        debugger "FileInput() must have a literal data element-- " & Text
        Exit Sub
    End If
    
    Dim a As Long
    Dim fileNum As Long
    fileNum = -1
    For a = 1 To UBound(openFile)
        If LCase(paras(0).lit) = LCase(openFile(a)) Then
            fileNum = a
            Exit For
        End If
    Next a
    If fileNum = -1 Then
        debugger "Error: File " & paras(0).lit & " is not open!"
        Exit Sub
    End If

    retval.dataType = DT_LIT
    retval.lit = CStr(fread(fileNum))

    Exit Sub

error:
    debugger "Unexpected error with FileInput()-- " & error
End Sub

Public Sub FilePrintRPG( _
                           ByVal Text As String, _
                           ByRef theProgram As RPGCodeProgram _
                                                                )
 
    'FilePrint(filename$,data$)
    'Prints data to an open file.
 
    On Error GoTo error
 
    '====================================================================================
    'Re-written by a _much_ more experienced KSNiloc
    '====================================================================================

    If Not CountData(Text) = 2 Then
        debugger "FilePrint() requires two data elements-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    If paras(0).dataType <> DT_LIT Or paras(1).dataType <> DT_LIT Then
        debugger "FilePrint() must have literal data elements-- " & Text
        Exit Sub
    End If
    
    Dim a As Long
    Dim fileNum As Long
    fileNum = -1
    For a = 1 To UBound(openFile)
        If LCase(paras(0).lit) = LCase(openFile(a)) Then
            fileNum = a
            Exit For
        End If
    Next a
    If fileNum = -1 Then
        debugger "Error: File " & paras(0).lit & " is not open!"
        Exit Sub
    End If

    Print #fileNum, paras(1).lit

    Exit Sub
    
error:
    debugger "Unexpected error with FilePrint()-- " & error
End Sub

Public Sub FileGetRPG( _
                         ByVal Text As String, _
                         ByRef theProgram As RPGCodeProgram, _
                         ByRef retval As RPGCODE_RETURN _
                                                          )
 
    'FileGet(filename$)
    'Gets data from a file
 
    On Error GoTo error
 
    '====================================================================================
    'Re-written by a _much_ more experienced KSNiloc
    '====================================================================================

    If Not CountData(Text) = 1 Then
        debugger "FileGet() requires two data elements-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    If paras(0).dataType <> DT_LIT Then
        debugger "FileGet() must have a literal data element-- " & Text
        Exit Sub
    End If
    
    Dim a As Long
    Dim fileNum As Long
    fileNum = -1
    For a = 1 To UBound(openFile)
        If LCase(paras(0).lit) = LCase(openFile(a)) Then
            fileNum = a
            Exit For
        End If
    Next a
    If fileNum = -1 Then
        debugger "Error: File " & paras(0).lit & " is not open!"
        Exit Sub
    End If

    retval.dataType = DT_LIT
    Dim binData As String * 1
    Get #fileNum, , binData
    retval.lit = CStr(binData)

    Exit Sub
    
error:
    debugger "Unexpected error with FileGet()-- " & error
End Sub

Public Sub FilePutRPG( _
                         ByVal Text As String, _
                         ByRef theProgram As RPGCodeProgram _
                                                              )
 
    'FilePut(filename$,data$)
    'Puts data into an open file.
 
    On Error GoTo error
 
    '====================================================================================
    'Re-written by a _much_ more experienced KSNiloc
    '====================================================================================

    If Not CountData(Text) = 2 Then
        debugger "FilePut() requires two data elements-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, theProgram)
    
    If paras(0).dataType <> DT_LIT Or paras(1).dataType <> DT_LIT Then
        debugger "FilePut() must have literal data elements-- " & Text
        Exit Sub
    End If
    
    Dim a As Long
    Dim fileNum As Long
    fileNum = -1
    For a = 1 To UBound(openFile)
        If LCase(paras(0).lit) = LCase(openFile(a)) Then
            fileNum = a
            Exit For
        End If
    Next a
    If fileNum = -1 Then
        debugger "Error: File " & paras(0).lit & " is not open!"
        Exit Sub
    End If
    
    Dim binData As String * 1
    binData = paras(1).lit
    Put #fileNum, , binData

    Exit Sub
    
error:
    debugger "Unexpected error with FilePut()-- " & error
End Sub

Sub FileEOFRPG(Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN)
 
 '#a! = #FileEOF(filename$)
 'Has the end of the file been reached?
 'Returns 1 or 0.
 
 On Error GoTo error

 ' ! MODIFIED BY KSNiloc...
 
 Dim file As String 'file to get input from
 Dim Temp As Variant 'temp variable
 Dim a As Long 'used for loops
 Dim temp2 As Double

 Temp = CountData(Text$)
 If Not Temp = 1 Then
  debugger "FileEOF needs one data element-- " & Text$
  Exit Sub
 End If

 file = GetElement(GetBrackets(Text$), 1) 'get the filename
 temp2 = 0: a = getValue(file, file, temp2, theProgram)
 If Not temp2 = 0 Then
  debugger "FileEOF element must be literal-- " & Text$
  Exit Sub
 End If
 For a = 1 To UBound(openFile)
  If openFile(a) = file Then Exit For
  If a = UBound(openFile) Then debugger "File is not open-- " & file: Exit Sub
 Next a

 With retval
  .dataType = DT_NUM
  If EOF(a) = False Then .num = 0 Else .num = 1
 End With

 Exit Sub
error:
 debugger "Unexpected error with FileEOF-- " & error
End Sub

Sub StringLenRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
'a! = Length (string$)
'Get's the length of a string.
'ADDED May 15, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketType As Long
Dim StringElement As String, StringData As String, Temp As Double

'Get bracket data
brackets = GetBrackets(Text)
BracketCount = CountData(brackets)

    'Check if we have enough data elements
    If BracketCount <> 1 Then
        Call debugger("Error: Length requires one data element!-- " & Text)
        Exit Sub
    End If

StringElement = GetElement(brackets, 1) 'Get string element
'Get bracket type (Numerical or Literal)
BracketType = getValue(StringElement, StringData, Temp, theProgram)

If BracketType = DT_NUM Then
    Call debugger("Error: Length element must be literal!-- " & Text): Exit Sub
End If

retval.dataType = DT_NUM
retval.num = Len(StringData)
End Sub

Sub GetItemNameRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
'#a$ = #GetItemName (filename$)
'Gets the handle of an item.
'ADDED May 18, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketElement As String
Dim BracketType As Long, itemFile As String, Temp As Double

brackets = GetBrackets(Text) 'Get brackets
BracketCount = CountData(brackets) 'Get bracket count
        
    'Check if we have enough elements
    If BracketCount <> 1 Then
        MsgBox "Error: GetItemName requires 1 data element!-- " & Text: Exit Sub
    End If
    
BracketElement = GetElement(brackets, 1) 'Get the filename
BracketType = getValue(BracketElement, itemFile, Temp, theProgram)

    If BracketType = DT_NUM Then
        Call debugger("Error: GetItemName element must be literal!-- " & Text): Exit Sub
    End If
    
        retval.dataType = DT_LIT
        retval.lit = getItemName(App.path & "\" & projectPath$ & itmPath$ & itemFile)
        Exit Sub
End Sub

Sub GetItemDescRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
On Error GoTo errorhandler
'#a$ = #GetItemDesc (filename$)
'Gets the one-line description of an item.
'ADDED May 18, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketElement As String
Dim BracketType As Long, itemFile As String, ItemData As TKItem, Temp As Double

'Get bracket data and bracket element count
brackets = GetBrackets(Text)
BracketCount = CountData(brackets)
    
    'Check if we have enough elements
    If BracketCount <> 1 Then Call debugger("Error: GetItemDesc requires 1 data element!-- " & Text): Exit Sub

'Get bracket elements, and values
BracketElement = GetElement(brackets, 1)
BracketType = getValue(BracketElement, itemFile, Temp, theProgram)
    
    'Check if the data type is correct
    If BracketType = DT_NUM Then Call debugger("Error: GetItemDesc element is literal-- " & Text)

'Open item and get desc.
ItemData = openItem(App.path & "\" & projectPath$ & itmPath$ & itemFile)

'Return data
retval.dataType = DT_LIT
retval.lit = ItemData.ITMDescription
Exit Sub

errorhandler:
    Call debugger("Error: GetItemDesc-- Item couldn't be opened, or an other error has occured!-- " & Text): Exit Sub
End Sub

Sub InStrRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
'#a! = #Instr (string$,string2$)
'Returns 1 if string$ exists within string2$
'Returns 0 if string$ doesn't exist within string2$
'ADDED May 19, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketType As Long
Dim BracketElement(1) As String, BracketValue(1) As String, Temp As Double
Dim ret As Integer

'Get brackets, and bracket count
brackets = GetBrackets(Text)
BracketCount = CountData(brackets)

    If BracketCount <> 2 Then
        Call debugger("Error: InStr requires two data elements!-- " & Text): Exit Sub
    End If
    
'Get values...
BracketElement(0) = GetElement(brackets, 1)
BracketElement(1) = GetElement(brackets, 2)

BracketType = getValue(BracketElement(0), BracketValue(0), Temp, theProgram)

    If BracketType <> DT_LIT Then
        Call debugger("Error: InStr elements are literal,literal-- " & Text): Exit Sub
    End If
    
BracketType = getValue(BracketElement(1), BracketValue(1), Temp, theProgram)
    
    If BracketType <> DT_LIT Then
        Call debugger("Error: InStr elements are literal,literal-- " & Text): Exit Sub
    End If
    
'Set return value
ret = InStr(1, BracketValue(0), BracketValue(1))
retval.dataType = DT_NUM

If ret > 0 Then
    retval.num = 1
    Exit Sub
ElseIf ret <= 0 Then
    retval.num = 0
    Exit Sub
End If

End Sub

Sub GetItemCostRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
On Error GoTo errorhandler:

'#a! = #GetItemCost (filename$)
'Get's the cost of an item.
'ADDED May 19th, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketElement As String
Dim BracketType As Long, itemFile As String, ItemData As TKItem, Temp As Double

brackets = GetBrackets(Text) 'Get brackets
BracketCount = CountData(brackets) 'Get bracket count
        
    'Check if we have enough elements
    If BracketCount <> 1 Then
        MsgBox "Error: GetItemCost requires 1 data element!-- " & Text: Exit Sub
    End If
    
BracketElement = GetElement(brackets, 1) 'Get the filename
BracketType = getValue(BracketElement, itemFile, Temp, theProgram)

    If BracketType = DT_NUM Then
        Call debugger("Error: GetItemCost element must be literal!-- " & Text): Exit Sub
    End If
    
'Open item and get the cost.
ItemData = openItem(App.path & "\" & projectPath$ & itmPath$ & itemFile)

'Return data
retval.dataType = DT_NUM
retval.num = ItemData.buyPrice
Exit Sub

errorhandler:
    Call debugger("Error: GetItemCost-- Item couldn't be opened, or an other error has occured!-- " & Text): Exit Sub
End Sub

Sub GetItemSellRPG(Text As String, theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)
On Error GoTo errorhandler
'#a! = #GetItemSellPrice (filename$)
'Get's the selling price of an item.
'ADDED May 19th, 2004 (Euix)

Dim brackets As String, BracketCount As Integer, BracketElement As String
Dim BracketType As Long, itemFile As String, ItemData As TKItem, Temp As Double

brackets = GetBrackets(Text) 'Get brackets
BracketCount = CountData(brackets) 'Get bracket count
        
    'Check if we have enough elements
    If BracketCount <> 1 Then
        MsgBox "Error: GetItemSellPrice requires 1 data element!-- " & Text: Exit Sub
    End If
    
BracketElement = GetElement(brackets, 1) 'Get the filename
BracketType = getValue(BracketElement, itemFile, Temp, theProgram)

    If BracketType = DT_NUM Then
        Call debugger("Error: GetItemSellPrice element must be literal!-- " & Text): Exit Sub
    End If
    
'Open item and get the selling price.
ItemData = openItem(App.path & "\" & projectPath$ & itmPath$ & itemFile)

'Return data
retval.dataType = DT_NUM
retval.num = ItemData.sellPrice
Exit Sub

errorhandler:
    Call debugger("Error: GetItemSellPrice-- Item couldn't be opened, or an other error has occured!-- " & Text): Exit Sub
End Sub

'=============================================================================
'More commands by KSNiloc...
'=============================================================================

Public Function WithRPG(ByVal cLine As String, ByRef prg As RPGCodeProgram) As Long

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[6/18/04]

 ''''''''''''''''
 'RPGCode Syntax'
 ''''''''''''''''
 'With(MyStack)
 '{
 ' test$ = .Pop()
 ' .Push("Test")
 '}
 'Allows manipulation of a particular object
 
 On Error GoTo error
 
 Dim paras() As parameters
 paras() = GetParameters(cLine, prg)

 If Not CountData(cLine) = 1 Then
  debugger "With only needs one parameter-- " & cLine
  Exit Function
 End If
 
 If Not paras(0).dataType = DT_LIT Then
  debugger "With requires a literal data element-- " & cLine
  Exit Function
 End If
 
 On Error GoTo arrayError
 ReDim Preserve inWith(UBound(inWith) + 1)
 inWith(UBound(inWith)) = paras(0).lit
 prg.programPos = increment(prg)
 WithRPG = runBlock(cLine, 1, prg)
 ReDim Preserve inWith(UBound(inWith) - 1)
 
 Exit Function
error:
 debugger "Unexpected error with With-- " & error
 Exit Function
arrayError:
 ReDim inWith(0)
 Resume Next
End Function

Public Function SwitchCase( _
                              ByVal Text As String, _
                              ByRef prg As RPGCodeProgram _
                                                            ) As Long

    '=========================================================================
    'Switch case 'structure' added by KSNiloc
    '=========================================================================

    'Switch(var!)
    '{
    '   Case(1,2,etc.)
    '   {
    '       *var! = 1 or 2, etc
    '   }
    '   Case(var2!)
    '   {
    '       *var! = var2!
    '   }
    '}

    'Make sure the foundSwitch() array is dimensioned...
    On Error GoTo dimensionFoundSwitch
    Dim testArray As Long
    testArray = UBound(foundSwitch)

    'Error handling
    On Error Resume Next
    handleErrors = False

    With RPGCodeSwitchCase
        
        'Get our parameters...
        Dim paras() As parameters
        paras() = GetParameters(Text, prg)

        Select Case LCase(GetCommandName(Text, prg))

            Case "switch"
                If Not CountData(Text) = 1 Then
                    debugger "Switch() can only have one data element-- " & Text
                    On Error GoTo skipBlock: Err.Raise 0
                End If
                Select Case paras(0).dataType
                    Case DT_LIT: .Add """" & paras(0).lit & """", CStr(.count + 1)
                    Case DT_NUM: .Add CStr(paras(0).num), CStr(.count + 1)
                End Select

                If isMultiTasking() Then
                    'Let the main loop take care of this...
                    startThreadLoop prg, TYPE_IF
                Else
                    runBlock Text, 1, prg
                End If
                
                foundSwitch(.count) = False
                .Remove CStr(.count)

            Case "case"
            
                If GetBrackets(Text) = "" Then
                    debugger "Case() needs at least one data element-- " & Text
                    On Error GoTo skipBlock: Err.Raise 0
                End If
                
                Dim run As Boolean
                
                If .count > UBound(foundSwitch) Then
                    ReDim Preserve foundSwitch(.count)
                End If
                
                On Error Resume Next
                
                If Not LCase(paras(0).lit) = "else" Then
            
                    Dim vtype As Long
                    Dim a As Long

                    'Determine type of variable in Switch()...
                    Dim equ As RPGC_DT
                    vtype = dataType(.item(.count), equ)
                    Select Case vtype
                        Case 0, 3: vtype = DT_NUM
                        Case 1, 2: vtype = DT_LIT
                        Case 5: vtype = equ
                    End Select

                    'Make sure all the passed variables are that type...
                    For a = 0 To UBound(paras)
                        If Not paras(a).dataType = vtype Then
                            debugger "All variables in Case() must be the sam" _
                                & "e type as the Switch()-- " & Text
                            On Error GoTo skipBlock: Err.Raise 0
                        End If
                    Next a

                    'For each of the variables...
                    Dim u As String
                    Dim eval As Long
                    Dim useMath As Boolean
                    For a = 0 To UBound(paras)
                        On Error Resume Next
                        If paras(a).dataType = DT_LIT Then u = paras(a).lit
                        If paras(a).dataType = DT_NUM Then u = CStr(paras(a).num)

                        'See if the they're trying to use their own comparison
                        'operator...
                        Select Case MathFunction(u, 1, True)
                            Case "=", "~=", "<", ">": useMath = True
                            Case Else: useMath = False
                        End Select

                        If Not useMath Then
                            eval = Evaluate(.item(.count) & " = " & u, prg)
                        Else
                            eval = Evaluate(.item(.count) & u, prg)
                        End If

                        If eval = 1 Then
                                                           
                            If Not foundSwitch(.count) Then
                                run = True
                                foundSwitch(.count) = True
                                Exit For
                            End If
                                
                        End If
                    Next a
                    
                Else
                    
                    'Use of 'else' keyword...
                    If Not foundSwitch(.count) Then
                        run = True
                        foundSwitch(.count) = True
                    End If

                End If
                
                If run = 1 Then
                    If isMultiTasking() Then

                        'Let the main loop take care of this...
                        startThreadLoop prg, TYPE_IF
                        SwitchCase = prg.programPos
                        Exit Function
                    
                    End If
                End If
                
                prg.programPos = runBlock(Text, booleanToLong(run), prg)
                SwitchCase = prg.programPos
      
        End Select
    
    End With

resumeErrorHandling:
    handleErrors = True

'=============================================================================
'Error handling
'=============================================================================
Exit Function

skipBlock:
    prg.programPos = increment(prg)
    prg.programPos = runBlock(Text, 0, prg)
    prg.programPos = increment(prg)
    SwitchCase = prg.programPos
    Resume resumeErrorHandling
    
dimensionFoundSwitch:
    ReDim foundSwitch(0)
    Resume Next
    
enlargeFoundSwitch:
    ReDim Preserve foundSwitch(UBound(foundSwitch) + 1)
    Resume

End Function

Public Sub spliceVariables( _
                              ByVal Text As String, _
                              ByRef prg As RPGCodeProgram, _
                              ByRef retval As RPGCODE_RETURN _
                                                               )
    
    '=========================================================================
    'Replaces <var!$> with text [KSNiloc]
    '=========================================================================
    'splice$ = spliceVariables("Var: <var!>")
    
    If Not CountData(Text) = 1 Then
        debugger "SpliceVariables() requires one data element-- " & Text
        Exit Sub
    End If
    
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
    
    If Not paras(0).dataType = DT_LIT Then
        debugger "SpliceVariables() requires a literal data element-- " & Text
        Exit Sub
    End If
    
    retval.dataType = DT_LIT
    retval.lit = MWinPrepare(paras(0).lit, prg)
    
End Sub

Public Sub SplitRPG( _
                       ByVal Text As String, _
                       ByRef prg As RPGCodeProgram, _
                       ByRef retval As RPGCODE_RETURN _
                                                        )

    '=========================================================================
    'Split up a string [KSNiloc]
    '=========================================================================
    'Split(text$,delimiter$,array$)

    On Error Resume Next

    If Not CountData(Text) = 3 Then
        debugger "Split() requires three data elements-- " & Text
        Exit Sub
    End If
    
    'Declarations...
    Dim paras() As parameters
    Dim splitIt() As String
    Dim postFix As String
    Dim a As Long
    
    paras() = GetParameters(Text, prg)
    
    For a = 0 To UBound(paras)
        If Not paras(a).dataType = DT_LIT Then
            debugger "Split() requires literal data elements-- " & Text
            Exit Sub
        End If
    Next a

    postFix = Right(paras(2).lit, 1)
    paras(2).lit = replace(paras(2).lit, "[]", "", , , vbTextCompare)
    paras(2).lit = Mid(paras(2).lit, 1, Len(paras(2).lit) - 1)
       
    splitIt = Split(paras(0).lit, paras(1).lit, , vbTextCompare)
    For a = 0 To UBound(splitIt)
        CBSetString paras(2).lit & "[" & CStr(a) & "]" & postFix, splitIt(a)
    Next a
    
    retval.dataType = DT_NUM
    retval.num = UBound(splitIt)

End Sub

Public Sub asciiToChr( _
                         ByVal Text As String, _
                         ByRef prg As RPGCodeProgram, _
                         ByRef retval As RPGCODE_RETURN _
                                                          )
                                                              
    '=========================================================================
    'Converts characters to and from ASCII [KSNiloc]
    '=========================================================================
    'c! = Asc(char$)
    'c$ = Chr(char!)
    
    If Not CountData(Text) = 1 Then
        debugger GetCommandName(Text, prg) & _
            " requires one data element-- " & Text
        Exit Sub
    End If
    
    Dim paras() As parameters
    paras = GetParameters(Text, prg)
    
    Select Case LCase(GetCommandName(Text, prg))
        Case "asc"
            If Not paras(0).dataType = DT_LIT Then
                debugger "Asc() requires a literal data element-- " & Text
                Exit Sub
            End If
            retval.dataType = DT_NUM
            retval.num = Asc(paras(0).lit)
        Case "chr"
            If Not paras(0).dataType = DT_NUM Then
                debugger "Chr() requires a numerical data element-- " & Text
                Exit Sub
            End If
            retval.dataType = DT_LIT
            retval.lit = Chr(paras(0).num)
    End Select

End Sub

Public Sub trimRPG( _
                      ByVal Text As String, _
                      ByRef prg As RPGCodeProgram, _
                      ByRef retval As RPGCODE_RETURN _
                                                       )

    '=========================================================================
    'Trims a line of spaces and tabs [KSNiloc]
    '=========================================================================
    'trim$ = Trim(text$)

    If Not CountData(Text) = 1 Then
        debugger "Trim() requires one data element-- " & Text
        Exit Sub
    End If
    
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)

    If Not paras(0).dataType = DT_LIT Then
        debugger "Trim() requires a literal data element-- " & Text
        Exit Sub
    End If

    retval.dataType = DT_LIT
    retval.lit = replace(Trim(paras(0).lit), vbTab, "")

End Sub

Public Sub rightLeft( _
                        ByVal Text As String, _
                        ByRef prg As RPGCodeProgram, _
                        ByRef retval As RPGCODE_RETURN _
                                                         )
                                                         
    '=========================================================================
    'Take characters from the right or left of a string [KSNiloc]
    '=========================================================================
    'right$ = right(str$,amount!)
    'left$ = left(str$,amount!)
    
    On Error Resume Next
    
    If Not CountData(Text) = 2 Then
        debugger GetCommandName(Text, prg) & _
            " requires two data elements-- " & Text
        Exit Sub
    End If
    
    Dim paras() As parameters
    paras = GetParameters(Text, prg)

    If Not ((paras(0).dataType = DT_LIT) And (paras(1).dataType = DT_NUM)) Then
        debugger GetCommandName(Text, prg) & _
            " 's elements are literal, numerical-- " & Text
        Exit Sub
    End If
    
    retval.dataType = DT_LIT
    Select Case LCase(GetCommandName(Text, prg))
        Case "right"
            retval.lit = Right(paras(0).lit, paras(1).num)
        Case "left"
            retval.lit = Left(paras(0).lit, paras(1).num)
    End Select

End Sub

Public Sub cursorMapHand( _
                            ByVal Text As String, _
                            ByRef prg As RPGCodeProgram _
                                                          )

    '=========================================================================
    'Changes the cursor hand graphics [KSNiloc]
    '=========================================================================
    'CursorMapHand(file$,stretch!)

    Dim cd As Long
    cd = CountData(Text)
    If GetBrackets(Text) = "" Then cd = 0

    If cd > 2 Then
        debugger "CursorMapHand() requires 0-2 data element(s)-- " & Text
        Exit Sub
    End If

    If cd = 0 Then
        canvas_host.hand.Picture = canvas_host.handBackup.Picture
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
    
    If Not paras(0).dataType = DT_LIT Then
        debugger "CursorMapHand()'s first data element must be literal-- " & Text
        Exit Sub
    End If

    If cd = 2 Then
        If Not paras(1).dataType = DT_NUM Then
            debugger "CursorMapHand()'s second data element must be numerical-- " & Text
            Exit Sub
        End If
    End If

    If LCase(paras(0).lit) = "default" Then
        canvas_host.hand.Picture = canvas_host.handBackup.Picture
        Exit Sub
    End If

    Dim fface As String
    fface = paras(0).lit
    fface = projectPath & bmpPath & fface

    If cd = 2 Then
        If paras(1).num = 1 Then
            DrawSizedImage fface, 0, 0, 32, 32, canvas_host.hand.hdc
        ElseIf paras(1).num = 0 Then
            DrawImage fface, 0, 0, canvas_host.hand.hdc
        Else
            debugger "CursorMapHand()'s second data element must be 1 or 0-- " & Text
        End If
    Else
        DrawSizedImage fface, 0, 0, 32, 32, canvas_host.hand.hdc
    End If

End Sub

Public Sub mousePointer( _
                           ByVal Text As String, _
                           ByRef prg As RPGCodeProgram _
                                                         )

    '=========================================================================
    'Changes mouse pointer [KSNiloc]
    '=========================================================================
    'MousePointer("file.cur")
    'MousePointer(0-15)
    'MousePointer(Default)
    'MousePointer(None)

    On Error Resume Next

    Dim countDat As Long
    countDat = CountData(Text)
    If GetBrackets(Text) = "" Then countDat = 0

    Select Case countDat
    
        Case 0
            host.mousePointer = 0
        
        Case 1
            Dim paras() As parameters
            paras() = GetParameters(Text, prg)

            If paras(0).dataType = DT_NUM Then
                host.mousePointer = paras(0).num
                Exit Sub
            End If
            
            'If Not paras(0).dataType = DT_LIT Then
            '    debugger "MousePointer()'s data element must be literal-- " _
            '        & text
            '    Exit Sub
            'End If

            If LCase(paras(0).lit) = "default" Then
                host.mousePointer = 0
                Exit Sub
            ElseIf LCase(paras(0).lit) = "none" Then
                host.mousePointer = 99
                host.MouseIcon = canvas_host.noCursor.Picture
                Exit Sub
            End If
            
            Select Case LCase(Right(paras(0).lit, 4))
            
                Case ".ico"
                Case ".cur"
                
                Case Else
                    debugger "Error: Mouse pointers must be .ico or .cur-- " _
                        & Text
                    Exit Sub

            End Select
        
            Dim fface As String
            fface = paras(0).lit
            fface = projectPath & bmpPath & fface
            
            host.mousePointer = 99
            host.MouseIcon = LoadPicture(fface)

        Case Else
            debugger "MousePointer() can have either zero or one data elements--" & Text

    End Select

End Sub

Public Sub debuggerRPG( _
                          ByVal Text As String, _
                          ByRef prg As RPGCodeProgram _
                                                        )

    '=========================================================================
    'Pops up the debugger [KSNiloc]
    '=========================================================================
    
    If Not CountData(Text) = 1 Then
        debugger "Debugger() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
    
    If Not paras(0).dataType = DT_LIT Then
        debugger "Debugger()'s data element must be literal-- " & Text
        Exit Sub
    End If

    debugger paras(0).lit

End Sub

Public Sub onError( _
                      ByVal Text As String, _
                      ByRef prg As RPGCodeProgram _
                                                    )

    '=========================================================================
    'Branches to a label when an error occurs [KSNiloc]
    '=========================================================================
    'OnError(:error)

    If GetBrackets(Text) = "" Then
        errorBranch = ""
        Exit Sub
    End If

    If Not CountData(Text) = 1 Then
        debugger "OnError() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras = GetParameters(Text, prg)

    If LCase(paras(0).dat) = "resume next" Or LCase(paras(0).dat) = "resumenext" Then
        errorBranch = "Resume Next"
        Exit Sub
    End If
    
    If Not paras(0).dataType = DT_LIT Then
        debugger "OnError() requires a literal data element-- " & Text
        Exit Sub
    End If
    
    errorBranch = paras(0).lit

End Sub

Public Sub resumeNextRPG( _
                            ByVal Text As String, _
                            ByRef prg As RPGCodeProgram _
                                                          )

    '=========================================================================
    'Returns to the line after the line where the error occured [KSNiloc]
    '=========================================================================
    'ResumeNext()

    On Error Resume Next
    
    If preErrorPos = 0 Then
        Dim oErrorBranch As String
        oErrorBranch = errorBranch
        errorBranch = ""
        debugger "No error has occured!"
        errorBranch = oErrorBranch
        Exit Sub
    End If
    
    prg.programPos = preErrorPos
    prg.programPos = increment(prg)
    preErrorPos = 0

End Sub

Public Sub MBoxRPG( _
                      ByVal Text As String, _
                      ByRef prg As RPGCodeProgram, _
                      ByRef retval As RPGCODE_RETURN _
                                                       )

    '=========================================================================
    'Pops up a message box [KSNiloc]
    '=========================================================================
    'ret! = MsgBox(text$,[title$],[type!],[textColor!],[bgColor!],[bgPic$])

    On Error Resume Next

    Dim cd As Long
    cd = CountData(Text)

    If cd < 1 And cd > 6 Then
        debugger "MsgBox() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)

    On Error GoTo error
    If cd > 0 Then If Not paras(0).dataType = DT_LIT Then Err.Raise 0
    If cd > 1 Then If Not paras(1).dataType = DT_LIT Then Err.Raise 0
    If cd > 2 Then If Not paras(2).dataType = DT_NUM Then Err.Raise 0
    If cd > 3 Then If Not paras(3).dataType = DT_NUM Then Err.Raise 0
    If cd > 4 Then If Not paras(4).dataType = DT_NUM Then Err.Raise 0
    If cd > 5 Then If Not paras(5).dataType = DT_LIT Then Err.Raise 0
    
    Dim fface As String
    If cd = 6 Then
        fface = paras(5).lit
        fface = projectPath & bmpPath & fface
    End If

    If cd >= 4 Then If paras(3).num = 0 Then paras(3).num = 16777215

    retval.dataType = DT_NUM
    Dim num As Double
    Select Case cd
        Case 1: num = MBox(MWinPrepare(paras(0).lit, prg))
        Case 2: num = MBox(MWinPrepare(paras(0).lit, prg), paras(1).lit)
        Case 3: num = MBox(MWinPrepare(paras(0).lit, prg), paras(1).lit, paras(2).num)
        Case 4: num = MBox(MWinPrepare(paras(0).lit, prg), paras(1).lit, paras(2).num, _
            paras(3).num)
        Case 5: num = MBox(MWinPrepare(paras(0).lit, prg), paras(1).lit, paras(2).num, _
            paras(3).num, paras(4).num)
        Case 5: num = MBox(MWinPrepare(paras(0).lit, prg), paras(1).lit, paras(2).num, _
            paras(3).num, paras(4).num, fface)
    End Select

    retval.num = num

    Exit Sub
error:
    debugger "MsgBox()'s parameters are lit,lit,num,num,num,lit--" & Text
End Sub

Public Sub animationDelayRPG( _
                                ByVal Text As String, _
                                ByRef prg As RPGCodeProgram _
                                                              )
                                                              
    '======================================================================================
    'Sets animation delay [KSNiloc]
    '======================================================================================
    'KEEP THIS COMMAND UNDOCUMENTED
    '======================================================================================
    'AnimationDelay(3)

    On Error Resume Next

    If Not CountData(Text) = 1 Then
        debugger "AnimationDelay() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
    
    If Not paras(0).dataType = DT_NUM Then
        debugger "AnimationDelay() requires a numerical data element-- " & Text
        Exit Sub
    End If

    If paras(0).num < 0 Then
        debugger "AnimationDelay() requires a positive number-- " & Text
        Exit Sub
    End If

    animationDelay = paras(0).num

End Sub

Public Sub setConstantsRPG( _
                              ByVal Text As String _
                                                     )

    '======================================================================================
    'Updates the constants [KSNiloc]
    '======================================================================================
    'SetConstants()

    On Error Resume Next

    If Not GetBrackets(Text) = "" Then
        debugger "SetConstants() requires no data elements-- " & Text
        Exit Sub
    End If

    setconstants

End Sub

Public Sub logRPG( _
                     ByVal Text As String, _
                     ByRef prg As RPGCodeProgram, _
                     ByRef retval As RPGCODE_RETURN _
                                                      )

    '======================================================================================
    'Logarithims [KSNiloc]
    '======================================================================================
    'log! = Log(number!)

    On Error Resume Next

    If Not CountData(Text) = 1 Then
        debugger "Log() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)

    If Not paras(0).dataType = DT_NUM Then
        debugger "Log() must have a numerical data element-- " & Text
        Exit Sub
    End If

    retval.dataType = DT_NUM
    retval.num = Log(paras(0).num)

End Sub

Public Sub onBoardRPG( _
                         ByVal Text As String, _
                         ByRef prg As RPGCodeProgram, _
                         ByRef retval As RPGCODE_RETURN _
                                                          )
                                                          
    '======================================================================================
    'Detects if a player is being shown on the board [KSNiloc]
    '======================================================================================
    'onBoard! = onBoard(pNum!)

    On Error Resume Next

    If Not CountData(Text) = 1 Then
        debugger "onBoard() requires one data element-- " & Text
        Exit Sub
    End If

    Dim paras() As parameters
    paras() = GetParameters(Text, prg)

    If Not paras(0).dataType = DT_NUM Then
        debugger "onBoard() must have a numerical data element-- " & Text
        Exit Sub
    End If
    
    retval.dataType = DT_NUM
    If showPlayer(paras(0).num) Then
        retval.num = 1
    Else
        retval.num = 0
    End If

End Sub

Public Sub autoLocalRPG(ByVal Text As String, ByRef prg As RPGCodeProgram)

    '=========================================================================
    'Forces implicitly created variables to be locally scoped
    'Added by KSNiloc
    '=========================================================================
    'AutoLocal()

    If Not CountData(Text) = 0 Then
        debugger "AutoLocal() requires no data elements-- " & Text
        Exit Sub
    End If

    prg.autoLocal = True

End Sub

Public Sub getBoardNameRPG( _
                              ByVal Text As String, _
                              ByRef prg As RPGCodeProgram, _
                              ByRef retval As RPGCODE_RETURN _
                                                               )

    '=========================================================================
    'Returns the board's filename
    '=========================================================================
    'fileName$ = GetBoardName()

    If Not CountData(Text) = 0 Then
        debugger "GetBoardName() requires no data elements-- " & Text
        Exit Sub
    End If

    retval.dataType = DT_LIT
    retval.lit = boardList(activeBoardIndex).boardName

End Sub

Public Sub LCaseRPG( _
                       ByVal Text As String, _
                       ByRef prg As RPGCodeProgram, _
                       ByRef retval As RPGCODE_RETURN _
                                                        )

    '=========================================================================
    'Rewritten by KSNiloc
    '=========================================================================
    'ucase$ = LCase(text$ [,dest$])
   
    Dim cd As Integer
    cd = CountData(Text)
   
    If cd <> 1 And cd <> 2 Then
        debugger "LCase() requires one or two data elements-- " & Text
        Exit Sub
    End If
   
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
   
    If paras(0).dataType <> DT_LIT Then
        debugger "LCase() requires a literal data element-- " & Text
        Exit Sub
    End If
   
    Dim toRet As String
    toRet = LCase(paras(0).lit)
   
    If retval.usingReturnData Then
        retval.dataType = DT_LIT
        retval.lit = toRet
    ElseIf cd = 2 Then
        SetVariable paras(1).dat, toRet, prg
    End If

End Sub

Public Sub UCaseRPG( _
                       ByVal Text As String, _
                       ByRef prg As RPGCodeProgram, _
                       ByRef retval As RPGCODE_RETURN _
                                                        )

    '=========================================================================
    'Rewritten by KSNiloc
    '=========================================================================
    'ucase$ = UCase(text$ [,dest$])
   
    Dim cd As Integer
    cd = CountData(Text)
   
    If cd <> 1 And cd <> 2 Then
        debugger "UCase() requires one or two data elements-- " & Text
        Exit Sub
    End If
   
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
   
    If paras(0).dataType <> DT_LIT Then
        debugger "UCase() requires a literal data element-- " & Text
        Exit Sub
    End If
   
    Dim toRet As String
    toRet = UCase(paras(0).lit)
   
    If retval.usingReturnData Then
        retval.dataType = DT_LIT
        retval.lit = toRet
    ElseIf cd = 2 Then
        SetVariable paras(1).dat, toRet, prg
    End If

End Sub

Public Sub appPathRPG( _
                         ByVal Text As String, _
                         ByRef prg As RPGCodeProgram, _
                         ByRef retval As RPGCODE_RETURN _
                                                          )

    '=========================================================================
    'Rewritten by KSNiloc
    '=========================================================================
    'path$ = AppPath([dest$])
   
    Dim cd As Long
    cd = CountData(Text)
   
    If cd <> 0 And cd <> 1 Then
        debugger "AppPath() requires zero or one data elements-- " & Text
        Exit Sub
    End If
   
    Dim thePath As String
    thePath = App.path
   
    If retval.usingReturnData Then
        retval.dataType = DT_LIT
        retval.lit = thePath
    ElseIf cd = 1 Then
        Dim paras() As parameters
        paras() = GetParameters(Text, prg)
        SetVariable paras(0).dat, thePath, prg
    End If

End Sub

Public Sub midRPG( _
                     ByVal Text As String, _
                     ByRef prg As RPGCodeProgram, _
                     ByRef retval As RPGCODE_RETURN _
                                                      )

    '=========================================================================
    'Rewritten by KSNiloc
    '=========================================================================
    'mid$ = Mid(string$,start!,length! [,dest$])
   
    Dim cd As Long
    cd = CountData(Text)
   
    If cd <> 3 And cd <> 4 Then
        debugger "Mid() requires three or four data elements-- " & Text
        Exit Sub
    End If
   
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
   
    If _
         paras(0).dataType <> DT_LIT _
         Or paras(1).dataType <> DT_NUM _
         Or paras(2).dataType <> DT_NUM _
                                         Then
                                         
        debugger "Mid()'s data elements are lit, num, num-- " & Text
        Exit Sub
       
    End If
   
    Dim toRet As String
    toRet = Mid(paras(0).lit, paras(1).num, paras(2).num)
   
    If retval.usingReturnData Then
        retval.dataType = DT_LIT
        retval.lit = toRet
    ElseIf cd = 4 Then
        SetVariable paras(3).dat, toRet, prg
    End If
   
End Sub

Public Sub replaceRPG( _
                         ByVal Text As String, _
                         ByRef prg As RPGCodeProgram, _
                         ByRef retval As RPGCODE_RETURN _
                                                          )

    '=========================================================================
    'Re-written by KSNiloc
    '=========================================================================
    'replace$ = Replace(str$,find$,replace$ [,dest$])

    On Error Resume Next

    Dim cd As Long
    cd = CountData(Text)
   
    If cd <> 3 And cd <> 4 Then
        debugger "Replace() requires three or four data elements-- " & Text
        Exit Sub
    End If
   
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)

    Dim a As Long
    For a = 0 To UBound(paras)
        If Not paras(a).dataType = DT_LIT Then
            debugger "Replace() requires literal data elements-- " & Text
            Exit Sub
        End If
    Next a
   
    Dim theResult As String
    theResult = replace(paras(0).lit, paras(1).lit, paras(2).lit)
   
    If retval.usingReturnData Then
        retval.dataType = DT_LIT
        retval.lit = theResult
    ElseIf cd = 4 Then
        SetVariable paras(3).dat, theResult, prg
    End If

End Sub

Public Sub pixelMovementRPG(ByVal Text As String, ByRef prg As RPGCodeProgram)
    '#PixelMovement(ON/OFF)

    If CountData(Text) <> 1 Then
        debugger "PixelMovement() requires one data element-- " & Text
        Exit Sub
    End If
   
    Dim paras() As parameters
    paras() = GetParameters(Text, prg)
   
    If paras(0).dataType <> DT_LIT Then
        debugger "PixelMovement() requires a literal data element-- " & Text
        Exit Sub
    End If

    Select Case Trim(LCase(paras(0).lit))
   
        Case "on"
            movementSize = 8 / 32
           
        Case "off"
            movementSize = 1

        Case Else
            debugger "PixelMovement()'s data element must be ON or OFF-- " & Text
   
    End Select

End Sub

