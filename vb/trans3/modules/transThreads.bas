Attribute VB_Name = "transThreads"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Threading procedures
'=========================================================================

'=========================================================================
' Handles user started threads (through the Thread() command), threads
' set on a board, and item multitask programs
'=========================================================================

Option Explicit

'=========================================================================
' Structure definitions
'=========================================================================

Private Type RPGCODE_THREAD                        'RPGCode thread data structure
    filename As String                             '  Name of program
    bPersistent As Boolean                         '  True if this thread should persist after leaving this board
    thread As RPGCodeProgram                       '  The actual program
    bIsSleeping As Boolean                         '  Is thread sleeping?
    sleepStartTime As Long                         '  Time when thread was put to sleep
    sleepDuration As Double                        '  Duration of sleep
    itemNum As Long                                '  Item number (-1 if not an item)
End Type

Public Enum THREAD_LOOP_TYPE                       'Thread loop enumeration
    TYPE_IF = 1                                    '  If()
    TYPE_WHILE = 2                                 '  While()
    TYPE_UNTIL = 3                                 '  Until()
    TYPE_FOR = 4                                   '  For()
End Enum

Private Type threadLoop                            'Thread loop structure
    start As Long                                  '  Line loop starts on
    depth As Long                                  '  Depth in loop
    Over As Boolean                                '  Loop over?
    condition As String                            '  Condition to end loop
    increment As String                            '  Incrementation equation
    type As THREAD_LOOP_TYPE                       '  Type of thread loop
    prg As RPGCodeProgram                          '  PRG hosting the loop
    end As Boolean                                 '  Loop ended?
End Type

Private Type THREAD_STACK                          'Thread stack structure
    stack() As threadLoop                          '  Stack of thread loops
    pos As Long                                    '  Position in stack
End Type

Private Type threadAnimation                       'Thread animation structure
    anm As TKAnimation                             '  Loaded animations
    x As Long                                      '  X position of these animations
    y As Long                                      '  Y position of these animations
    frame As Long                                  '  Current frame of these animations
    persistent As Boolean                          '  Animation run from a persistent thread?
End Type

'=========================================================================
' Thread looping declarations
'=========================================================================
Private threadLoops() As THREAD_STACK               'All thread loops

'=========================================================================
' Animation declarations
'=========================================================================
Private threadAnimations() As threadAnimation      'All thread animations
Private multitaskCurrentlyAnimating As Long        'Current index in array
Private lastAnimRender As Long                     'Last animation render

'=========================================================================
' Thread action declarations
'=========================================================================
Private threadLooping As Boolean                   'Are we looping?
Private threadAnimating As Boolean                 'Are we animating?

'=========================================================================
' All threads
'=========================================================================
Public Threads() As RPGCODE_THREAD                 'All running threads
Private m_multiTasking As Boolean                  'Multitasking now?

'=========================================================================
' Access to m_multiTasking
'=========================================================================
Public Property Get isMultiTasking() As Boolean
    isMultiTasking = m_multiTasking
End Property
Public Property Let isMultiTasking(ByVal newVal As Boolean)
    m_multiTasking = newVal
End Property

'=========================================================================
' Run a line from threads
'=========================================================================
Public Sub multiTaskNow()

    On Error Resume Next

    ' Flag we're multitasking
    m_multiTasking = True

    If Not (runningProgram) Then
        ' Update the RPGCode canvas if not in a prg
        Call canvasGetScreen(cnvRPGCodeScreen)
    End If

    ' Run all threads
    Call ExecuteAllThreads

    ' Flag we're no longer multitasking
    m_multiTasking = False

End Sub

'=========================================================================
' Clear all non-presistent threads
'=========================================================================
Public Sub ClearNonPersistentThreads()

    On Error Resume Next

    Dim c As Long                   'for loop control variable
    Dim retval As RPGCODE_RETURN    'unused rpgcode return value

    For c = 0 To UBound(Threads)
        If (Not Threads(c).bPersistent) Then
            Call TellThread(c, "Unload()", retval, True)
            Threads(c).filename = vbNullString
            Threads(c).thread.programPos = -1
            Threads(c).thread.threadID = -1
            ReDim Threads(c).thread.program(10)
            Threads(c).bIsSleeping = False
            Call ClearRPGCodeProcess(Threads(c).thread)
        End If
    Next c

    For c = 0 To UBound(threadAnimations)
        If Not threadAnimations(c).persistent Then
            Call ceaseMultitaskAnimation(c)
        End If
    Next c

    For c = 0 To UBound(threadLoops)
        If Not Threads(threadLoops(c).stack(threadLoops(c).pos).prg.threadID).bPersistent Then
            Call endThreadLoop(c, False)
        End If
    Next c

End Sub

'=========================================================================
' Clear *all* threads
'=========================================================================
Public Sub ClearAllThreads()

    On Error Resume Next

    Dim c As Long                   'for loop control variable
    Dim retval As RPGCODE_RETURN    'unused rpgcode return value

    For c = 0 To UBound(Threads)
        Call TellThread(c, "Unload()", retval, True)
        Threads(c).filename = vbNullString
        Threads(c).thread.programPos = -1
        Threads(c).thread.threadID = -1
        ReDim Threads(c).thread.program(0)
        Threads(c).bIsSleeping = False
        Call ClearRPGCodeProcess(Threads(c).thread)
    Next c

    ReDim Threads(0)

    Call ceaseAllMultitaskingAnimations
    Call endAllThreadLoops

End Sub

'=========================================================================
' Create a thread
'=========================================================================
Public Function createThread(ByVal file As String, ByVal bPersistent As Boolean, Optional ByVal itemNum As Long = -1) As Long

    Dim c As Long       'for loop control variables
    Dim size As Long    'size of threads() array

    'search for a free persistent thread slot
    For c = 0 To UBound(Threads)
        With Threads(c)
            If (LenB(.filename) = 0) Then
                'this is a thread that has been halted, thus it's slot is free
                .thread = openProgram(file)
                .filename = file
                .bPersistent = bPersistent
                .thread.threadID = c
                .bIsSleeping = False
                .itemNum = itemNum
                createThread = c
                Exit Function
            End If
        End With
    Next c

    'need a free slot...
    size = UBound(Threads)
    ReDim Preserve Threads(size * 2)
    With Threads(size)
        .thread = openProgram(file)
        .filename = file
        .bPersistent = bPersistent
        .thread.threadID = c
        .bIsSleeping = False
        .itemNum = itemNum
    End With
    createThread = size

End Function

'=========================================================================
' Execute all threads
'=========================================================================
Private Sub ExecuteAllThreads()

    On Error Resume Next

    'Run threads without loops (maybe using Branch)
    Dim c As Long
    For c = 0 To UBound(Threads)
        If (LenB(Threads(c).filename)) Then
            If Threads(c).bIsSleeping Then
                'thread is asleep
                'time to wake up?
                If Threads(c).sleepStartTime + Threads(c).sleepDuration <= Timer() Then
                    'wake up!
                    Threads(c).bIsSleeping = False
                    Call ExecuteThread(Threads(c).thread)
                End If
            Else
                Call ExecuteThread(Threads(c).thread)
            End If
        End If
        Call processEvent
    Next c

    'Run threads that use loops (like While)
    Call handleThreadLooping

End Sub

'=========================================================================
' Execute a thread
'=========================================================================
Private Function ExecuteThread(ByRef theProgram As RPGCodeProgram) As Boolean
    If (Not ((theProgram.programPos = -1) Or (theProgram.programPos = -2))) Then
        Dim itemNum As Long
        itemNum = Threads(theProgram.threadID).itemNum
        If (itemNum <> -1) Then
            If (Not itemMem(itemNum).bIsActive) Then
                'Item is not active
                Exit Function
            End If
            'Since it's an item program, set target and source
            target = itemNum
            Source = itemNum
            targetType = TYPE_ITEM
            sourceType = TYPE_ITEM
        End If
        Dim retval As RPGCODE_RETURN
        theProgram.programPos = DoSingleCommand(theProgram.program(theProgram.programPos), theProgram, retval)
        If (theProgram.programPos = -1) Or (theProgram.programPos = -2) Then
            'clear the program
            Call ClearRPGCodeProcess(theProgram)
        Else
            'Complete success!
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
    ReDim Threads(10)
    Dim c As Long
    For c = 0 To UBound(Threads)
        Threads(c).filename = vbNullString
        Threads(c).thread.programPos = -1
        Threads(c).thread.boardNum = -1
        Threads(c).bIsSleeping = False
        Call InitRPGCodeProcess(Threads(c).thread)
        Call ClearRPGCodeProcess(Threads(c).thread)
    Next c

End Sub

'=========================================================================
' Kill a thread
'=========================================================================
Public Sub KillThread(ByVal threadID As Long)
    On Error Resume Next
    Dim retval As RPGCODE_RETURN
    Call TellThread(threadID, "Unload()", retval, True)
    Threads(threadID).filename = vbNullString
    Threads(threadID).thread.programPos = -1
    Threads(threadID).thread.threadID = -1
    ReDim Threads(threadID).thread.program(10)
    Call ClearRPGCodeProcess(Threads(threadID).thread)
End Sub

'=========================================================================
' Call a method from a thread
'=========================================================================
Public Sub TellThread(ByVal threadID As Long, ByVal rpgcodeCommand As String, ByRef retval As RPGCODE_RETURN, Optional ByVal noMethodNotFound As Boolean)
    On Error Resume Next
    Dim shortName As String
    shortName = UCase$(GetCommandName(rpgcodeCommand))
    Call MethodCallRPG(rpgcodeCommand, shortName, Threads(threadID).thread, retval, noMethodNotFound)
End Sub

'=========================================================================
' Put a thread to sleep
'=========================================================================
Public Sub ThreadSleep(ByVal threadID As Long, ByVal durationInSeconds As Double)
    On Error Resume Next
    Threads(threadID).bIsSleeping = True
    Threads(threadID).sleepStartTime = Timer
    Threads(threadID).sleepDuration = durationInSeconds
End Sub

'=========================================================================
' Check time until wake up
'=========================================================================
Public Function ThreadSleepRemaining(ByVal threadID As Long) As Double
    On Error Resume Next
    Dim dRet As Double
    If Threads(threadID).bIsSleeping Then
        dRet = Threads(threadID).sleepDuration - (Timer - Threads(threadID).sleepStartTime)
    End If
    ThreadSleepRemaining = dRet
End Function

'=========================================================================
' Wake up a thread
'=========================================================================
Public Sub ThreadWake(ByVal threadID As Long)
    On Error Resume Next
    Threads(threadID).bIsSleeping = False
End Sub

'=========================================================================
' Launch a board's threads
'=========================================================================
Public Sub launchBoardThreads(ByRef board As TKBoard)
    On Error Resume Next
    Dim retval As RPGCODE_RETURN, a As Long, id As Long
    For a = 0 To UBound(Threads)
        If (Threads(a).bPersistent) And (LenB(Threads(a).filename) <> 0) Then
            Call TellThread(a, "EnterNewBoard()", retval, True)
        End If
    Next a
    For a = 0 To UBound(board.Threads)
        If (LenB(board.Threads(a))) Then
            id = createThread(projectPath & prgPath & board.Threads(a), False)
            Call CBSetNumerical("Threads[" & CStr(a) & "]!", id)
        End If
    Next a
End Sub

'=========================================================================
' End all thread loops
'=========================================================================
Private Sub endAllThreadLoops()
    ReDim threadLoops(0)
    threadLooping = False
End Sub

'=========================================================================
' Enter a loop from within a thread
'=========================================================================
Public Sub startThreadLoop( _
                              ByRef prg As RPGCodeProgram, _
                              ByVal ttype As THREAD_LOOP_TYPE, _
                              Optional ByVal condition As String, _
                              Optional ByVal increment As String _
                                                                   )

    ' Make sure our array is dimensioned
    On Error GoTo error
    Dim ub As Long
    ub = UBound(threadLoops)

    ' If the program is already looping
    If (prg.looping) Then

        ' Find a thread loop with its ID
        On Error GoTo tidError
        Dim i As Long
        For i = 0 To ub
            Dim tid As Long
            tid = threadLoops(i).stack(threadLoops(i).pos).prg.threadID
            If (tid = prg.threadID) Then
                ' Here it is!
                ub = i
                Exit For
            End If
        Next i

    Else

        ' Enlarge the array
        ub = ub + 1
        ReDim Preserve threadLoops(ub)

    End If

    On Error Resume Next

    ' Setup the loop
    Call moveToStartOfBlock(prg)
    threadLoops(ub).pos = threadLoops(ub).pos + 1
    ReDim Preserve threadLoops(ub).stack(threadLoops(ub).pos + 50)
    With threadLoops(ub).stack(threadLoops(ub).pos)
        .start = prg.programPos
        .type = ttype
        .prg = prg
        .condition = condition
        .increment = increment
        .prg.looping = True
    End With

    ' Flag we're looping
    threadLooping = True

    Exit Sub

error:
    ReDim threadLoops(0)
    Resume

tidError:
    tid = -1
    Resume Next

End Sub

'=========================================================================
' End a thread loop
'=========================================================================
Private Sub endThreadLoop(ByVal num As Long, ByVal force As Boolean)

    With threadLoops(num).stack(threadLoops(num).pos)

        'Flag we've reached the end
        .end = True

        'If the loop is over or we should force its end
        If (.Over) Or (force) Then
            If (threadLoops(num).pos = 1) Then
                .prg.looping = False
            End If
            threadLoops(num).pos = threadLoops(num).pos - 1
            Exit Sub
        End If

        'Check if it's an item program
        Dim itmNum As Long
        itmNum = Threads(.prg.threadID).itemNum
        If (itmNum <> -1) Then
            Source = itmNum
            target = itmNum
            sourceType = TYPE_ITEM
            targetType = TYPE_ITEM
        End If

        'Switch on the type of loop
        Select Case .type

            Case TYPE_IF                'IF STATEMENT
                                        '------------
                .prg.looping = False

            Case TYPE_WHILE             'WHILE LOOP
                                        '----------
                If evaluate(.condition, .prg) Then
                    .prg.programPos = .start
                    .end = False
                Else
                    If (threadLoops(num).pos = 1) Then
                        .prg.looping = False
                    End If
                    threadLoops(num).pos = threadLoops(num).pos - 1
                End If

            Case TYPE_UNTIL             'UNTIL LOOP
                                        '----------
                If evaluate(.condition, .prg) = 0 Then
                    .prg.programPos = .start
                    .end = False
                Else
                    If (threadLoops(num).pos = 1) Then
                        .prg.looping = False
                    End If
                    threadLoops(num).pos = threadLoops(num).pos - 1
                End If

            Case TYPE_FOR               'FOR LOOP
                                        '--------
                Dim oPP As Long
                Dim rV As RPGCODE_RETURN
                oPP = .prg.programPos
                .prg.programPos = DoSingleCommand(.increment, .prg, rV)
                .prg.programPos = oPP
                If evaluate(.condition, .prg) Then
                    .prg.programPos = .start
                    .end = False
                Else
                    If (threadLoops(num).pos = 1) Then
                        .prg.looping = False
                    End If
                    threadLoops(num).pos = threadLoops(num).pos - 1
                End If

        End Select '(.type)

    End With '(threadLoops(num))

End Sub

'=========================================================================
' Handle thread looping
'=========================================================================
Private Sub handleThreadLooping(Optional ByVal runAll As Boolean = True)

    On Error Resume Next

    Dim threadIdx As Long               'Thread index
    Static currentlyLooping As Long     'Last run thread

    If (Not threadLooping) Then
        'Blah, there aren't even any looping threads!
        Exit Sub
    End If

    If (runAll) Then
        'Run all the threads
        For threadIdx = 1 To UBound(threadLoops)
            Call handleThreadLooping(False)
            Call processEvent
        Next threadIdx
        Exit Sub
    End If

    'See if there are threads to run
    For threadIdx = 1 To UBound(threadLoops)
        If Not (threadLoops(threadIdx).stack(threadLoops(threadIdx).pos).end) Then
            'This thread is alive and kicking!
            Exit For
        End If
        If (threadIdx = UBound(threadLoops)) Then
            'No running threads!
            threadLooping = False
            Exit Sub
        End If
    Next threadIdx

    'Find a thread to run
    Do
        currentlyLooping = currentlyLooping + 1
        If Not (currentlyLooping > UBound(threadLoops)) Then
            If Not (threadLoops(currentlyLooping).stack(threadLoops(currentlyLooping).pos).end) Then
                'Found a thread to run
                Exit Do
            End If
        Else
            currentlyLooping = 0
        End If
    Loop

    If Not (Threads(threadLoops(currentlyLooping).stack(threadLoops(currentlyLooping).pos).prg.threadID).bIsSleeping) Then
        'This thread is awake, execute it
        Call incrementThreadLoop(currentlyLooping)
    End If

End Sub

'=========================================================================
' Increment a thread loop
'=========================================================================
Private Sub incrementThreadLoop(ByVal num As Long)

    Dim bExec As Boolean
    bExec = True

    With threadLoops(num).stack(threadLoops(num).pos)

        Dim prg As RPGCodeProgram
        prg = .prg

        Select Case prg.strCommands(prg.programPos)

            Case "OPENBLOCK"
                .depth = .depth + 1
                prg.programPos = increment(prg)

            Case "CLOSEBLOCK"
                .depth = .depth - 1
                prg.programPos = increment(prg)

            Case "END"
                .Over = True
                prg.programPos = increment(prg)

            Case Else

                If Not (.Over) Then
                    Dim bRunning As Boolean
                    bRunning = runningProgram
                    runningProgram = True
                    bExec = ExecuteThread(prg)
                    runningProgram = bRunning
                Else
                    prg.programPos = increment(prg)
                End If

        End Select

        'Don't let us lock up
        Call processEvent

        .prg = prg

        If (.depth = 0) Then
            'We're at the end of the loop
            Call endThreadLoop(num, False)
        End If

        If (prg.programPos = -1) Or (prg.programPos = -2) Or (Not (bExec)) Then
            'We're at the end of the program
            Call endThreadLoop(num, True)
        End If

    End With

End Sub

'=========================================================================
' Init an animation for multitasking
'=========================================================================
Public Function startMultitaskAnimation(ByVal x As Long, ByVal y As Long, ByRef prg As RPGCodeProgram) As Double

    'Make sure our array is dimensioned
    On Error GoTo dimensionArray
    Dim ub As Long
    ub = UBound(threadAnimations)

    'Next make sure this same animation isn't already multitasking
    Dim a As Long
    For a = 1 To ub
        If threadAnimations(a).anm.animFile = animationMem.animFile Then
            If threadAnimations(a).x = x Then
                If threadAnimations(a).y = y Then
                    'Already loaded!
                    Exit Function
                End If
            End If
        End If
    Next a

    'Enlarge the array
    ReDim Preserve threadAnimations(ub + 1)

    'Setup the animation
    With threadAnimations(ub + 1)
        .persistent = Threads(prg.threadID).bPersistent
        .anm = animationMem
        .x = x
        .y = y
    End With

    'Flag we're animating
    threadAnimating = True

    'Return animation ID
    startMultitaskAnimation = ub + 1

    Exit Function

dimensionArray:
    ReDim threadAnimations(0)
    Resume

End Function

'=========================================================================
' End the multitasking animation in position pos
'=========================================================================
Public Sub ceaseMultitaskAnimation(ByVal pos As Long)

    On Error GoTo error

    Dim a As Long

    If UBound(threadAnimations) <> pos Then
        For a = pos To UBound(threadAnimations) - 1
            threadAnimations(a).anm = threadAnimations(a + 1).anm
            threadAnimations(a).frame = threadAnimations(a + 1).frame
            threadAnimations(a).x = threadAnimations(a + 1).x
            threadAnimations(a).y = threadAnimations(a + 1).y
        Next a
    End If

    'Shrink the array
    ReDim Preserve threadAnimations(UBound(threadAnimations) - 1)

    If UBound(threadAnimations) = 0 Then
        'We're no longer animating
        threadAnimating = False

    ElseIf multitaskCurrentlyAnimating = pos Then
        'The one we removed was queued up!
        multitaskCurrentlyAnimating = multitaskCurrentlyAnimating + 1
        If multitaskCurrentlyAnimating >= UBound(threadAnimations) Then
            multitaskCurrentlyAnimating = 1
        End If

    End If
    
error:
End Sub

'=========================================================================
' End all multitasking animations
'=========================================================================
Private Sub ceaseAllMultitaskingAnimations()
    ReDim threadAnimations(0)
    threadAnimating = False
End Sub

'=========================================================================
' Handle multitasking animations
'=========================================================================
Public Sub renderMultiAnimations( _
                                    Optional ByVal cnvTarget As Long = -1, _
                                    Optional ByVal renderAll As Boolean = True, _
                                    Optional ByVal ignoreTimestamp As Boolean = True, _
                                    Optional ByVal noFrameChange As Boolean = True _
                                                                                     )

    'If we're not animating, just exit
    If (Not threadAnimating) Then
        Exit Sub
    End If

    If (renderAll) Then

        'Check if we should increment frames
        Dim incrementFrame As Boolean
        incrementFrame = multiAnimRender()

        'Set to first anim
        multitaskCurrentlyAnimating = 1

        'Recurse for each loaded anim
        Dim thisAnim As Long
        For thisAnim = 1 To UBound(threadAnimations)
            Call renderMultiAnimations(cnvTarget, False, True, Not incrementFrame)
            Call processEvent
        Next thisAnim

        'Update last render
        lastAnimRender = Timer()

    Else

        Dim frame As Long           'frame to render
        Dim num As Long             'slot in arrays
        Dim anim As TKAnimation     'the animation
        Dim x As Long               'x screen coord
        Dim y As Long               'y screen coord

        'First see what we are to do
        num = multitaskCurrentlyAnimating
        frame = threadAnimations(num).frame
        anim = threadAnimations(num).anm
        x = threadAnimations(num).x
        y = threadAnimations(num).y

        'Draw the frame onto a canvas
        Dim cnv As Long
        cnv = createCanvas(anim.animSizeX, anim.animSizeY)
        Call canvasFill(cnv, TRANSP_COLOR)
        Call AnimDrawFrameCanvas(anim, frame, 0, 0, cnv, True)

        'Render the frame
        If cnvTarget <> -1 Then
            'To a canvas
            Call canvas2CanvasBltTransparent(cnv, cnvTarget, x, y, TRANSP_COLOR)
        Else
            'To the screen
            Call DXDrawCanvasTransparent(cnv, x, y, TRANSP_COLOR)
        End If

        'Destroy that canvas
        Call destroyCanvas(cnv)

        'If it's been 5ms
        If _
             (multiAnimRender()) Or _
             (ignoreTimestamp) And (Not noFrameChange) _
                                                         Then

            'Increment frame
            frame = frame + 1

            'Get the max frame
            Dim maxFrame As Long
            maxFrame = animGetMaxFrame(anim)

            If (frame > maxFrame) And (Not anim.loop) Then
                'It's the end of this animation!
                Call ceaseMultitaskAnimation(num)
            Else
                If (frame > maxFrame) And (anim.loop) Then
                    'Set this animation back to the first frame
                    frame = 0
                End If
                'This animation has had its turn
                threadAnimations(num).frame = frame
                num = num + 1
            End If

            'Make sure the next animation isn't greater than the total animations
            If num > UBound(threadAnimations) Then num = 1
            multitaskCurrentlyAnimating = num

            'Update last render time stamp
            lastAnimRender = Timer()

        End If

    End If

End Sub

'=========================================================================
' Returns if we need to render multitasking animations
'=========================================================================
Public Property Get multiAnimRender() As Boolean
    multiAnimRender = (Not ((Not (Timer() - lastAnimRender >= (50 \ 1000))) Or (Not threadAnimating)))
End Property
