Attribute VB_Name = "transThreads"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGCode threading procedures
' Status: B
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Public Type RPGCODE_THREAD                         'RPGCode thread data structure
    filename As String                             '  Name of program
    bPersistent As Boolean                         '  True if this thread should persist after leaving this board
    thread As RPGCodeProgram                       '  The actual program
    bIsSleeping As Boolean                         '  Is thread sleeping?
    sleepStartTime As Long                         '  Time when thread was put to sleep
    sleepDuration As Double                        '  Duration of sleep
End Type

Public Enum THREAD_LOOP_TYPE                       'Thread loop enumeration
    TYPE_IF = 1                                    '  If()
    TYPE_WHILE = 2                                 '  While()
    TYPE_UNTIL = 3                                 '  Until()
    TYPE_FOR = 4                                   '  For()
End Enum

Private loopStart() As Long                        'Line loop starts on
Private loopDepth() As Long                        'Depth in loop
Private loopOver() As Boolean                      'Loop over?
Private loopCondition() As String                  'Condition to end loop
Private loopIncrement() As String                  'Incrementation equation
Private loopType() As THREAD_LOOP_TYPE             'Type of thread loop
Private currentlyLooping As Long                   'Thread that is current looping
Private loopPRG() As RPGCodeProgram                'PRG hosting the loop
Private loopEnd() As Boolean                       'Loop ended?

Private multitaskAnimations() As TKAnimation       'loaded animations
Private multitaskAnimationX() As Long              'x position of these animations
Private multitaskAnimationY() As Long              'y position of these animations
Private multitaskAnimationFrame() As Long          'current frame of these animations
Private multitaskCurrentlyAnimating As Long        'current index in array
Private multitaskAnimationPersistent() As Boolean  'are these animations persistent?

Public GS_LOOPING As Boolean                       'Are we looping?
Public GS_ANIMATING As Boolean                     'Are we animating?

Public threads() As RPGCODE_THREAD                 'Running threads

'=========================================================================
' Clear all non-presistent threads
'=========================================================================
Public Sub ClearNonPersistentThreads()

    On Error Resume Next
    
    Dim c As Long
    
    For c = 0 To UBound(threads)
        If (threads(c).bPersistent = False) Then
            threads(c).filename = ""
            threads(c).thread.programPos = -1
            threads(c).thread.threadID = -1
            ReDim threads(c).thread.program(10)
            threads(c).bIsSleeping = False
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

'=========================================================================
' Clear *all* threads
'=========================================================================
Public Sub ClearAllThreads()

    On Error Resume Next
    
    Dim c As Long
    
    ReDim threads(10)
    
    For c = 0 To UBound(threads)
        threads(c).filename = ""
        threads(c).thread.programPos = -1
        threads(c).thread.threadID = -1
        ReDim threads(c).thread.program(0)
        threads(c).bIsSleeping = False
        Call ClearRPGCodeProcess(threads(c).thread)
    Next c
    
    Call ceaseAllMultitaskingAnimations
    Call endAllThreadLoops

End Sub

'=========================================================================
' Create a thread
'=========================================================================
Public Function CreateThread(ByVal file As String, ByVal bPersistent As Boolean) As Long

    Dim c As Long
    Dim size As Long
    
    'search for a free persistent thread slot
    For c = 0 To UBound(threads)
        If (threads(c).filename = "") Then
            'this is a thread that has been halted, thus it's slot is free
            threads(c).thread = openProgram(file)
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
    
    threads(size).thread = openProgram(file)
    threads(size).filename = file
    threads(size).bPersistent = bPersistent
    threads(size).thread.threadID = c
    threads(size).bIsSleeping = False
    CreateThread = size
End Function

'=========================================================================
' Execute all threads
'=========================================================================
Public Sub ExecuteAllThreads()

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

'=========================================================================
' Execute a thread
'=========================================================================
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

'=========================================================================
' Initiate threads
'=========================================================================
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

'=========================================================================
' Kill a thread
'=========================================================================
Public Sub KillThread(ByVal threadID As Long)
    On Error Resume Next
    threads(threadID).filename = ""
    threads(threadID).thread.programPos = -1
    threads(threadID).thread.threadID = -1
    ReDim threads(threadID).thread.program(10)
    Call ClearRPGCodeProcess(threads(threadID).thread)
End Sub

'=========================================================================
' Call a method from a thread
'=========================================================================
Public Sub TellThread(ByVal threadID As Long, ByVal rpgcodeCommand As String, ByRef retval As RPGCODE_RETURN)
    On Error Resume Next
    Dim shortName As String
    shortName = UCase(GetCommandName(rpgcodeCommand, threads(threadID).thread))
    Call MethodCallRPG(rpgcodeCommand, shortName, threads(threadID).thread, retval)
End Sub

'=========================================================================
' Put a thread to sleep
'=========================================================================
Public Sub ThreadSleep(ByVal threadID As Long, ByVal durationInSeconds As Double)
    On Error Resume Next
    threads(threadID).bIsSleeping = True
    threads(threadID).sleepStartTime = Timer
    threads(threadID).sleepDuration = durationInSeconds
End Sub

'=========================================================================
' Check time until wake up
'=========================================================================
Public Function ThreadSleepRemaining(ByVal threadID As Long) As Double
    On Error Resume Next
    Dim dRet As Double
    If threads(threadID).bIsSleeping Then
        dRet = threads(threadID).sleepDuration - (Timer - threads(threadID).sleepStartTime)
    End If
    ThreadSleepRemaining = dRet
End Function

'=========================================================================
' Wake up a thread
'=========================================================================
Public Sub ThreadWake(ByVal threadID As Long)
    On Error Resume Next
    threads(threadID).bIsSleeping = False
End Sub

'=========================================================================
' Launch a board's threads
'=========================================================================
Public Sub launchBoardThreads(ByRef board As TKBoard)
    On Error GoTo skip
    Dim a As Long, id As Long
    For a = 0 To UBound(board.threads)
        id = CreateThread(projectPath & prgPath & board.threads(a), False)
        Call CBSetNumerical("Threads[" & CStr(a) & "]!", id)
    Next a
skip:
    On Error GoTo skipAgain
    'Alert persistent threads
    Dim retval As RPGCODE_RETURN
    For a = 0 To UBound(threads)
        If threads(a).bPersistent Then
            Call TellThread(a, "EnterNewBoard()", retval)
        End If
    Next a
skipAgain:
End Sub

'=========================================================================
' End all thread loops
'=========================================================================
Public Sub endAllThreadLoops()
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

'=========================================================================
' Enter a loop from within a thread
'=========================================================================
Public Sub startThreadLoop( _
                              ByRef prg As RPGCodeProgram, _
                              ByVal tType As THREAD_LOOP_TYPE, _
                              Optional ByVal condition As String, _
                              Optional ByVal increment As String _
                                                                   )

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
    loopType(ub) = tType
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

'=========================================================================
' End a thread loop
'=========================================================================
Private Sub endThreadLoop(ByVal num As Long)

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

'=========================================================================
' Handle thread looping
'=========================================================================
Public Sub handleThreadLooping()

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

    Dim oGbm As Boolean
    oGbm = isMultiTasking()
    gbMultiTasking = True
    Call incrementThreadLoop(currentlyLooping)
    gbMultiTasking = oGbm

End Sub

'=========================================================================
' Increment a thread loop
'=========================================================================
Private Sub incrementThreadLoop(ByVal num As Long)

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
    Call processEvent

    loopPRG(num) = prg
    If loopDepth(num) = 0 Then Call endThreadLoop(num)

End Sub

'=========================================================================
' Init an animation for multitasking
'=========================================================================
Public Function startMultitaskAnimation(ByVal x As Long, ByVal y As Long, ByRef prg As RPGCodeProgram) As Double

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

'=========================================================================
' End the multitasking animation is position pos
'=========================================================================
Public Sub ceaseMultitaskAnimation(ByVal pos As Long)
   
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

'=========================================================================
' End all multitasking animations
'=========================================================================
Public Sub ceaseAllMultitaskingAnimations()
    ReDim multitaskAnimations(0)
    ReDim multitaskAnimationFrame(0)
    ReDim multitaskAnimationX(0)
    ReDim multitaskAnimationY(0)
    ReDim multitaskAnimationPersistent(0)
    GS_ANIMATING = False
End Sub

'=========================================================================
' Handle multitasking animations
'=========================================================================
Public Sub handleMultitaskingAnimations(Optional ByVal cnv As Long = 1)

    If Not GS_ANIMATING Then Exit Sub

    'Declarations...
    Dim frame As Long
    Dim num As Long
    Dim anim As TKAnimation
    Dim x As Long
    Dim y As Long

    'First see what we are to do...
    num = multitaskCurrentlyAnimating
    frame = multitaskAnimationFrame(num)
    anim = multitaskAnimations(num)
    x = multitaskAnimationX(num)
    y = multitaskAnimationY(num)

    'Draw that frame!
    If cnv <> -1 Then
        Call AnimDrawFrameCanvas(anim, frame, x, y, cnv, True)
    Else
        Call AnimDrawFrame(anim, frame, x, y, host.hdc, True)
    End If

    'Increment the frame...
    frame = frame + 1
    If frame > animGetMaxFrame(anim) Then
        'It's the end of this animation!
        Call ceaseMultitaskAnimation(num)
    Else
        'This animation has had its turn...
        multitaskAnimationFrame(num) = frame
        num = num + 1
    End If

    If num > UBound(multitaskAnimations) Then num = 0
    multitaskCurrentlyAnimating = num
    
End Sub
