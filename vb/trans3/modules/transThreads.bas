Attribute VB_Name = "transThreads"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'stuff to control multi-threaded rpgcode programs
Option Explicit

Public Type RPGCODE_THREAD
    filename As String  'name of program
    bPersistent As Boolean  'true if this thread should persist after leaving this board
    thread As RPGCodeProgram    'the actual program
    
    bIsSleeping As Boolean  'is thread sleeping?
    sleepStartTime As Long  'time when thread was put to sleep
    sleepDuration As Double 'duration of sleep
       
End Type

Public Enum THREAD_LOOP_TYPE
    TYPE_IF = 1
    TYPE_WHILE = 2
    TYPE_UNTIL = 3
    TYPE_FOR = 4
End Enum
Private loopStart() As Long
Private loopDepth() As Long
Private loopType() As THREAD_LOOP_TYPE
Public loopPRG() As RPGCodeProgram
Public loopEnd() As Boolean
Private loopOver() As Boolean
Private loopCondition() As String
Private loopIncrement() As String
Public GS_LOOPING As Boolean
Private currentlyLooping As Long

Public threads() As RPGCODE_THREAD     'threads

Sub ClearNonPersistentThreads()
    'clear all the non-persistent threads
    On Error Resume Next
    
    Dim c As Long
    
    For c = 0 To UBound(threads)
        If (threads(c).bPersistent = False) Then
            threads(c).filename = ""
            threads(c).thread.programPos = -1
            threads(c).thread.threadID = -1
            ReDim threads(c).thread.program(10)
            threads(c).bIsSleeping = False
        
            'clear the program
            Call ClearRPGCodeProcess(threads(c).thread)
        End If
    Next c

    For c = 0 To UBound(multitaskAnimations)
        If Not multitaskAnimationPersistent(c) Then
            Call ceaseMultitaskAnimation(c)
        End If
    Next c
    For c = 0 To UBound(loopPRG)
        If Not threads(loopPRG(c).threadID).bPersistent Then
            Call endThreadLoop(c)
        End If
    Next c

End Sub

Public Sub ClearAllThreads()

    On Error Resume Next
    
    Dim c As Long
    
    ReDim threads(10)
    
    For c = 0 To UBound(threads)
        threads(c).filename = ""
        threads(c).thread.programPos = -1
        threads(c).thread.threadID = -1
        ReDim threads(c).thread.program(10)
    
        threads(c).bIsSleeping = False
    
        'clear the program
        Call ClearRPGCodeProcess(threads(c).thread)
    Next c
    
    Call ceaseAllMultitaskingAnimations
    Call endAllThreadLoops

End Sub

Public Function CreateThread(ByVal file As String, ByVal bPersistent As Boolean) As Long

    Dim c As Long
    Dim size As Long
    
    'search for a free persistent thread slot
    For c = 0 To UBound(threads)
        If (threads(c).filename = "") Then
            'this is a thread that has been halted, thus it's slot is free
            Call openProgram(file, threads(c).thread)
            threads(c).filename = file
            threads(c).bPersistent = bPersistent
            threads(c).thread.threadID = c
            threads(c).bIsSleeping = False
            CreateThread = c
            Exit Function
        End If
    Next c
    
    'need a free slot...
    size = UBound(threads)
    ReDim Preserve threads(size * 2)
    
    Call openProgram(file, threads(size).thread)
    threads(size).filename = file
    threads(size).bPersistent = bPersistent
    threads(size).thread.threadID = c
    threads(size).bIsSleeping = False
    CreateThread = size
End Function

Public Sub ExecuteAllThreads()
    'execute all threads
    On Error Resume Next
    
    'persistent threads...
    Dim c As Long
    For c = 0 To UBound(threads)
        If threads(c).filename <> "" Then
            If threads(c).bIsSleeping Then
                'thread is asleep
                'time to wake up?
                If threads(c).sleepStartTime + threads(c).sleepDuration <= Timer Then
                    'wake up!
                    threads(c).bIsSleeping = False
                    Call ExecuteThread(threads(c).thread)
                End If
            Else
                Call ExecuteThread(threads(c).thread)
            End If
        End If
    Next c
End Sub

Public Function ExecuteThread(ByRef theProgram As RPGCodeProgram) As Boolean

    If theProgram.programPos = -1 Or theProgram.programPos = -2 Then
        ExecuteThread = False
    Else
        Dim retval As RPGCODE_RETURN
        theProgram.programPos = DoSingleCommand(theProgram.program(theProgram.programPos), theProgram, retval)
        If theProgram.programPos = -1 Or theProgram.programPos = -2 Then
            'clear the program
            Call ClearRPGCodeProcess(theProgram)
            ExecuteThread = False
        Else
            ExecuteThread = True
        End If
    End If
End Function

Public Sub InitThreads()

    On Error Resume Next
    
    'init persistent threads...
    ReDim threads(10)
    Dim c As Long
    For c = 0 To UBound(threads)
        threads(c).filename = ""
        threads(c).thread.programPos = -1
        threads(c).thread.boardNum = -1
        threads(c).bIsSleeping = False
        Call InitRPGCodeProcess(threads(c).thread)
        Call ClearRPGCodeProcess(threads(c).thread)
    Next c

End Sub

Public Sub KillThread(ByVal threadID As Long)
    'kill a thread
    On Error Resume Next
    threads(threadID).filename = ""
    threads(threadID).thread.programPos = -1
    threads(threadID).thread.threadID = -1
    ReDim threads(threadID).thread.program(10)
    'clear the program
       
    Call ClearRPGCodeProcess(threads(threadID).thread)
End Sub

Public Sub TellThread(ByVal threadID As Long, ByVal rpgcodeCommand As String, ByRef retval As RPGCODE_RETURN)
    'force a thread to call rpgcodeCommand
    On Error Resume Next
    Dim shortName As String
    shortName = UCase$(GetCommandName$(rpgcodeCommand, threads(threadID).thread))   'get command name without extra info
        
    'call the method...
    Call MethodCallRPG(rpgcodeCommand, shortName, threads(threadID).thread, retval)
End Sub

Public Sub ThreadSleep(ByVal threadID As Long, ByVal durationInSeconds As Double)
    'put a thread to sleep
    On Error Resume Next
    threads(threadID).bIsSleeping = True
    threads(threadID).sleepStartTime = Timer
    threads(threadID).sleepDuration = durationInSeconds
End Sub

Public Function ThreadSleepRemaining(ByVal threadID As Long) As Double
    'return sleep time remaining for a thread...
    On Error Resume Next
    Dim dRet As Double
    dRet = 0
    If threads(threadID).bIsSleeping Then
        dRet = threads(threadID).sleepDuration - (Timer - threads(threadID).sleepStartTime)
    End If
    ThreadSleepRemaining = dRet
End Function

Public Sub ThreadWake(ByVal threadID As Long)
    'wake a sleeping thread...
    On Error Resume Next
    threads(threadID).bIsSleeping = False
End Sub

Public Sub launchBoardThreads(ByRef board As TKBoard)

    '==========================
    'Launches a board's threads
    '==========================
    'Added by KSNiloc
    
    On Error GoTo skip

    Dim a As Long
    Dim id As Long
    For a = 0 To UBound(board.threads)
        id = CreateThread(projectPath & prgPath & board.threads(a), False)
        CBSetNumerical "Threads[" & CStr(a) & "]!", id
    Next a
skip:

    On Error GoTo skipAgain

    'Alert persistent threads
    Dim retval As RPGCODE_RETURN
    For a = 0 To UBound(threads)
        If threads(a).bPersistent Then
            TellThread a, "EnterNewBoard()", retval
        End If
    Next a

skipAgain:
End Sub

Public Sub endAllThreadLoops()

    '=====================
    'Ends all thread loops
    '=====================
    'Added by KSNiloc

    ReDim loopStart(0)
    ReDim loopDepth(0)
    ReDim loopType(0)
    ReDim loopPRG(0)
    ReDim loopEnd(0)
    ReDim loopOver(0)
    ReDim loopCondition(0)
    ReDim loopIncrement(0)
    GS_LOOPING = False

End Sub

Public Sub startThreadLoop( _
                              ByRef prg As RPGCodeProgram, _
                              ByVal ttype As THREAD_LOOP_TYPE, _
                              Optional ByVal condition As String, _
                              Optional ByVal increment As String _
                                                                   )

    '==================================
    'Starts a loop from within a thread
    '==================================
    'Added by KSNiloc

    'Make sure our array is dimensioned...
    On Error GoTo error
    Dim ub As Long
    ub = UBound(loopStart)
    ub = ub + 1

    'Enlarge the arrays...
    ReDim Preserve loopStart(ub)
    ReDim Preserve loopDepth(ub)
    ReDim Preserve loopType(ub)
    ReDim Preserve loopPRG(ub)
    ReDim Preserve loopEnd(ub)
    ReDim Preserve loopOver(ub)
    ReDim Preserve loopCondition(ub)
    ReDim Preserve loopIncrement(ub)

    'Setup the loop...
    moveToStartOfBlock prg
    loopStart(ub) = prg.programPos
    loopType(ub) = ttype
    loopPRG(ub) = prg
    loopCondition(ub) = condition
    loopIncrement(ub) = increment

    'Flag we're looping...
    GS_LOOPING = True
    loopPRG(ub).looping = True
    
    Exit Sub
    
error:
    ReDim loopStart(0)
    Resume

End Sub

Public Sub endThreadLoop(ByVal num As Long)

    '==================
    'Ends a thread loop
    '==================
    'Added by KSNiloc

    loopEnd(num) = True
    If loopOver(num) Then
        loopPRG(num).looping = False
        Exit Sub
    End If

    Select Case loopType(num)

        Case TYPE_IF
            loopPRG(num).looping = False

        Case TYPE_WHILE
            If Evaluate(loopCondition(num), loopPRG(num)) = 1 Then
                loopPRG(num).programPos = loopStart(num)
                loopEnd(num) = False
            Else
                loopPRG(num).looping = False
            End If
            
        Case TYPE_UNTIL
            If Evaluate(loopCondition(num), loopPRG(num)) = 0 Then
                loopPRG(num).programPos = loopStart(num)
                loopEnd(num) = False
            Else
                loopPRG(num).looping = False
            End If

        Case TYPE_FOR
            Dim oPP As Long
            Dim rV As RPGCODE_RETURN
            oPP = loopPRG(num).programPos
            loopPRG(num).programPos = DoSingleCommand(loopIncrement(num), loopPRG(num), rV)
            loopPRG(num).programPos = oPP
            If Evaluate(loopCondition(num), loopPRG(num)) = 1 Then
                loopPRG(num).programPos = loopStart(num)
                loopEnd(num) = False
            Else
                loopPRG(num).looping = False
            End If

    End Select

End Sub

Public Sub handleThreadLooping()

    '=========================
    'Handles thread looping
    'Called ONLY by mainLoop()
    '=========================
    'Added by KSNiloc

    On Error Resume Next
    
    Dim a As Long
    For a = 1 To UBound(loopPRG)
        If Not loopEnd(a) Then Exit For
        
        If a = UBound(loopPRG) Then
            GS_LOOPING = False
            Exit Sub
        End If
        
    Next a

    Dim done As Boolean
    Do Until done
    
        currentlyLooping = currentlyLooping + 1
        If Not currentlyLooping > UBound(loopPRG) Then
            If Not loopEnd(currentlyLooping) Then
                done = True
            End If
        Else
            currentlyLooping = 0
        End If
        
    Loop

    Dim ogbm As Boolean
    ogbm = isMultiTasking()
    gbMultiTasking = True
    incrementThreadLoop currentlyLooping
    gbMultiTasking = ogbm

End Sub

Public Sub incrementThreadLoop(ByVal num As Long)

    '======================================
    'Increments a loop from within a thread
    '======================================
    'Added by KSNiloc

    Dim prg As RPGCodeProgram
    Dim rV As RPGCODE_RETURN
    prg = loopPRG(num)

    Select Case LCase(GetCommandName(prg.program(prg.programPos), prg))

        Case "openblock"
            loopDepth(num) = loopDepth(num) + 1
            prg.programPos = increment(prg)
            
        Case "closeblock"
            loopDepth(num) = loopDepth(num) - 1
            prg.programPos = increment(prg)

        Case "end"
            loopOver(num) = True
            prg.programPos = increment(prg)
            
        Case Else

            If Not loopOver(num) Then
                prg.looping = False
                prg.programPos = DoCommand(prg, rV)
                prg.looping = True
            Else
                prg.programPos = increment(prg)
            End If


    End Select

    'Don't let us lock up...
    DoEvents

    loopPRG(num) = prg
    If loopDepth(num) = 0 Then endThreadLoop num

End Sub

Public Function startMultitaskAnimation(ByVal x As Long, ByVal y As Long, ByRef prg As RPGCodeProgram) As Double

    '=======================================
    'Initiates an animation for multitasking
    '=======================================
    'Added by KSNiloc

    'Make sure our array is dimensioned...
    On Error GoTo dimensionArray
    Dim ub As Long
    ub = UBound(multitaskAnimations)

    'Next make sure this same animation isn't already multitasking...
    Dim a As Long
    For a = 1 To ub
        If multitaskAnimations(a).animFile = animationMem.animFile Then
            If multitaskAnimationX(a) = x Then
                If multitaskAnimationY(a) = y Then
                    'Already loaded!
                    Exit Function
                End If
            End If
        End If
    Next a

    ReDim Preserve multitaskAnimations(ub + 1)
    ReDim Preserve multitaskAnimationFrame(ub + 1)
    ReDim Preserve multitaskAnimationX(ub + 1)
    ReDim Preserve multitaskAnimationY(ub + 1)
    ReDim Preserve multitaskAnimationPersistent(ub + 1)

    multitaskAnimationPersistent(ub + 1) = threads(prg.threadID).bPersistent
    multitaskAnimations(ub + 1) = animationMem
    multitaskAnimationX(ub + 1) = x
    multitaskAnimationY(ub + 1) = y

    GS_ANIMATING = True
    startMultitaskAnimation = ub + 1

    Exit Function

dimensionArray:
    ReDim multitaskAnimations(0)
    Resume

End Function

Public Sub ceaseMultitaskAnimation(ByVal pos As Long)

    '=================================================
    'Ceases the multitasking animation in position pos
    '=================================================
    'Added by KSNiloc
    
    If Not UBound(multitaskAnimations) = pos Then
        Dim a As Long
        For a = pos To UBound(multitaskAnimations) - 1
            multitaskAnimations(a) = multitaskAnimations(a + 1)
            multitaskAnimationFrame(a) = multitaskAnimationFrame(a + 1)
            multitaskAnimationX(a) = multitaskAnimationX(a + 1)
            multitaskAnimationY(a) = multitaskAnimationY(a + 1)
        Next a
    End If

    ReDim Preserve multitaskAnimationFrame(UBound(multitaskAnimations) - 1)
    ReDim Preserve multitaskAnimationX(UBound(multitaskAnimations) - 1)
    ReDim Preserve multitaskAnimationY(UBound(multitaskAnimations) - 1)
    ReDim Preserve multitaskAnimationPersistent(UBound(multitaskAnimations) - 1)
    ReDim Preserve multitaskAnimations(UBound(multitaskAnimations) - 1)

    If UBound(multitaskAnimations) = 0 Then
        'We're no longer animating...
        GS_ANIMATING = False
    End If

End Sub

Public Sub ceaseAllMultitaskingAnimations()

    '==================================
    'Ceases all multitasking animations
    '==================================
    'Added by KSNiloc
    
    ReDim multitaskAnimations(0)
    ReDim multitaskAnimationFrame(0)
    ReDim multitaskAnimationX(0)
    ReDim multitaskAnimationY(0)
    ReDim multitaskAnimationPersistent(0)
    GS_ANIMATING = False

End Sub

Public Sub handleMultitaskingAnimations()

    '========================================
    'This sub handles multitasking animations
    'Called ONLY by mainLoop()
    '========================================
    'Added by KSNiloc

    'Declarations...
    Dim frame As Long
    Dim num As Long
    Dim anim As TKAnimation
    Dim screen As Long
    Dim x As Long
    Dim y As Long

    'Make us a canvas...
    screen = CreateCanvas(globalCanvasWidth, globalCanvasHeight, True)
    CanvasGetScreen screen

    'First see what we are to do...
    num = multitaskCurrentlyAnimating
    frame = multitaskAnimationFrame(num)
    anim = multitaskAnimations(num)
    x = multitaskAnimationX(num)
    y = multitaskAnimationY(num)

    'Draw that frame!
    AnimDrawFrameCanvas anim, frame, x, y, screen, True

    'Render the screen...
    renderCanvas screen

    'Destroy our canvas...
    DestroyCanvas screen

    'Increment the frame...
    frame = frame + 1
    If frame > animGetMaxFrame(anim) Then
        'It's the end of this animation!
        ceaseMultitaskAnimation num
    Else
        'This animation has had its turn...
        multitaskAnimationFrame(num) = frame
        num = num + 1
    End If

    If num > UBound(multitaskAnimations) Then num = 0
    multitaskCurrentlyAnimating = num
    
End Sub
