Attribute VB_Name = "transInput"
'=====================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=====================================================

'Process keyboard input (and eventually tcp/ip input).
Option Explicit


Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
    'GetAsyncKeyState is the user32.lib function which function determines whether the key is
    'up or down at the time the function is called, and whether the key was pressed after a
    'previous call to GetAsyncKeyState.
    'Returns: If the most significant bit is set (if return is negative), the key is down, and if the least
    'significant bit is set, the key was pressed after the previous call to GetAsyncKeyState.

    'Win32 virtual ANSI keycodes
Public Const VK_ADD = &H6B
Public Const VK_ATTN = &HF6
Public Const VK_BACK = &H8
Public Const VK_CANCEL = &H3
Public Const VK_CAPITAL = &H14
Public Const VK_CLEAR = &HC
Public Const VK_CONTROL = &H11
Public Const VK_CRSEL = &HF7
Public Const VK_DECIMAL = &H6E
Public Const VK_DELETE = &H2E
Public Const VK_DIVIDE = &H6F
Public Const VK_DOWN = &H28
Public Const VK_END = &H23
Public Const VK_EREOF = &HF9
Public Const VK_ESCAPE = &H1B
Public Const VK_EXECUTE = &H2B
Public Const VK_EXSEL = &HF8
Public Const VK_F1 = &H70
Public Const VK_F10 = &H79
Public Const VK_F11 = &H7A
Public Const VK_F12 = &H7B
Public Const VK_F13 = &H7C
Public Const VK_F14 = &H7D
Public Const VK_F15 = &H7E
Public Const VK_F16 = &H7F
Public Const VK_F17 = &H80
Public Const VK_F18 = &H81
Public Const VK_F19 = &H82
Public Const VK_F2 = &H71
Public Const VK_F20 = &H83
Public Const VK_F21 = &H84
Public Const VK_F22 = &H85
Public Const VK_F23 = &H86
Public Const VK_F24 = &H87
Public Const VK_F3 = &H72
Public Const VK_F4 = &H73
Public Const VK_F5 = &H74
Public Const VK_F6 = &H75
Public Const VK_F7 = &H76
Public Const VK_F8 = &H77
Public Const VK_F9 = &H78
Public Const VK_HELP = &H2F
Public Const VK_HOME = &H24
Public Const VK_INSERT = &H2D
Public Const VK_LBUTTON = &H1
Public Const VK_LCONTROL = &HA2
Public Const VK_LEFT = &H25
Public Const VK_LMENU = &HA4
Public Const VK_LSHIFT = &HA0
Public Const VK_MBUTTON = &H4             '  NOT contiguous with L RBUTTON
Public Const VK_MENU = &H12
Public Const VK_MULTIPLY = &H6A
Public Const VK_NEXT = &H22
Public Const VK_NONAME = &HFC
Public Const VK_NUMLOCK = &H90
Public Const VK_NUMPAD0 = &H60
Public Const VK_NUMPAD1 = &H61
Public Const VK_NUMPAD2 = &H62
Public Const VK_NUMPAD3 = &H63
Public Const VK_NUMPAD4 = &H64
Public Const VK_NUMPAD5 = &H65
Public Const VK_NUMPAD6 = &H66
Public Const VK_NUMPAD7 = &H67
Public Const VK_NUMPAD8 = &H68
Public Const VK_NUMPAD9 = &H69
Public Const VK_OEM_CLEAR = &HFE
Public Const VK_PA1 = &HFD
Public Const VK_PAUSE = &H13
Public Const VK_PLAY = &HFA
Public Const VK_PRINT = &H2A
Public Const VK_PRIOR = &H21
Public Const VK_PROCESSKEY = &HE5
Public Const VK_RBUTTON = &H2
Public Const VK_RCONTROL = &HA3
Public Const VK_RETURN = &HD
Public Const VK_RIGHT = &H27
Public Const VK_RMENU = &HA5
Public Const VK_RSHIFT = &HA1
Public Const VK_SCROLL = &H91
Public Const VK_SELECT = &H29
Public Const VK_SEPARATOR = &H6C
Public Const VK_SHIFT = &H10
Public Const VK_SNAPSHOT = &H2C
Public Const VK_SPACE = &H20
Public Const VK_SUBTRACT = &H6D
Public Const VK_TAB = &H9
Public Const VK_UP = &H26
Public Const VK_ZOOM = &HFB


Public mouseX As Integer, mouseY As Integer         'Mouse x and y position.
Public mouseMoveX As Integer, mouseMoveY As Integer 'Co-ords of mouse movement.
Public bWaitingForInput As Boolean                  'Are we currently waiting for input? (i.e. joystick or keyboard?)

Public keyWaitState As Long         'Key pressed on last event.
Public keyShiftState As Long        'Key pressed shift value on last event.
                                    '1 = shift 2 = ctrl 4 = alt.
Public keyAsciiState As Long        'Key pressed on last event (ascii).

Private ignoreKeyDown As Boolean    'Ignore key down events?

Public useJoystick As Boolean       'Using joystick.

'===========================================
'Temporary movement control booleans. Added by Delano. 4/05/04
'Used in scanKeys to allow the use of the arrow keys and numberpad for movement.
'Will mirror with variables in the mainFile for next release (3.0.4)
'Assigned True in scankeys until otherwise.
'===========================================
Public useArrowKeys As Boolean
Public useNumberPad As Boolean


Sub FlushKB()
    '=============================
    'Flush the keyboard buffer.
    '=============================
    'Waits until no key is being pressed.
    
    'Called by runFight, clearBufferRPG, ShowPromptDialog, ShowFileDialog, CursorMapRun, selectionBox, runProgram
    
    On Error Resume Next
    Dim aa As String
    
    aa$ = "a"
    Do While aa$ <> ""
        aa$ = getKey()
    Loop
End Sub

Public Sub DoEventsFor(ByVal milliSeconds As Long)

    '================================================
    'Do events for a certain period of time [KSNiloc]
    '================================================

    Dim startTime As Long
    Dim done As Boolean

    startTime = Timer()
    Do Until done
        Call processEvent
        If Timer() - startTime >= milliSeconds / 1000 Then
            done = True
        End If
    Loop

End Sub

Public Function getKey(Optional ByVal milliSeconds As Long = 15) As String

    '=============================
    'EDITED: Delano - 18/05/04
    'Fixed error in Get command where LEFT and RIGHT are inversed.
    'Added recognition for SPACE.
    'Renamed variables: t >> repeat
    'Removed: ll: call processevent does not need to return a value.
    '=============================
    'Gets the contents of the keyboard or joystick buffer.
    
    'Called by FlushKB and GetRPG only.
    
    On Error GoTo errorhandler

    'Clear the last pressed key.
    keyWaitState = -1

    'call processevent so we can get a key...
    Call DoEventsFor(milliSeconds)

    'Check the joystick.
    Dim jButton(4) As Boolean
    Dim theDir As Long
    
    'Get a movement direction and see any buttons that were pressed.
    theDir = joyDirection(jButton)
    
    If jButton(0) Then
        'If the primary button was pressed.
        
        getKey = "BUTTON"
        jButton(0) = False
        Exit Function
        
    End If
    
    If keyWaitState = -1 Then
        'If a button has still not been pressed, return nothing.
        getKey = ""
        Exit Function
    End If
    
    Dim returnVal As String
    'Get a string of the key number.
    returnVal$ = Chr$(keyWaitState)
    
    'Check the key for common keys.
    If keyWaitState = 13 Then returnVal$ = "ENTER"
    If keyWaitState = 32 Then returnVal$ = "SPACE"
    If keyWaitState = 38 Then returnVal$ = "UP"
    If keyWaitState = 40 Then returnVal$ = "DOWN"
    If keyWaitState = 37 Then returnVal$ = "LEFT"
    If keyWaitState = 39 Then returnVal$ = "RIGHT"
    If keyShiftState = 1 Then returnVal$ = UCase$(returnVal$) 'If shift was pressed, return an upper-case letter.
    'Might want to add numberpad here too.
    
    getKey = returnVal$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function



Function getAsciiKey() As String
    '=============================
    'Renamed variables: t >> repeat
    'Removed: ll: call processevent does not need to return a value.
    '=============================
    'Gets whatever is in keyboard buffer (ASCII values!)
    
    'Called by ShowPromptDialog and ShowFileDialog only.
    
    On Error GoTo errorhandler
    
    'Clear the last pressed key (ascii)
    keyAsciiState = -1
    
    Dim repeat As Integer
    
    'Call call processevent 10 times(!). Give enough time for an input.
    For repeat = 0 To 10
        Call processEvent
    Next repeat
    
    If keyAsciiState = -1 Then
        'If a button has still not been pressed, return nothing.
        getAsciiKey = ""
        Exit Function
    End If
    
    Dim returnVal As String
   'Get a string of the key number.
    returnVal$ = Chr$(keyAsciiState)
    
    getAsciiKey = returnVal$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub haltKeyDownScanning()
    '=============================
    'Causes the keyDownEvent to be ignored (i.e. key presses in the main form.)
    '=============================
    'Called by ShowPromptDialog, ShowFileDialog only.
    
    ignoreKeyDown = True
End Sub


Sub startKeyDownScanning()
    '=============================
    'Causes the keyDownEvent to begin (i.e. key presses in the main form.)
    '=============================
    'Called by ShowPromptDialog, ShowFileDialog only.
    
    ignoreKeyDown = False
End Sub


Function WaitForKey() As String
    '=============================
    'EDITED: Delano - 18/05/04
    'Added recognition for SPACE.
    'Waits for key to be pressed.
    'Renamed variables: t >> jButtonNum
    '=============================
    
    'Called by rewardPlayers, gameOver, showMenu, increaseLevel, WaitRPG, WinRPG, AddToMsgBox, DebugBox

    On Error GoTo errorhandler
       
    'Clear the last pressed key.
    keyWaitState = 0
    bWaitingForInput = True
    
    'Check the joystick.
    Dim jButton(4) As Boolean
    Dim theDir As Long
    
    Do While keyWaitState = 0 And jButton(0) = False
        Call processEvent
        'Get a movement direction and see any buttons that were pressed.
        theDir = joyDirection(jButton)
    Loop
    
    bWaitingForInput = False
    
    If jButton(0) Then
        'If the primary button was pressed.

        keyWaitState = 0
        WaitForKey = "BUTTON"
        jButton(0) = False
        Exit Function
        
    End If
    
    Dim jButtonNum As Integer
    For jButtonNum = 1 To UBound(jButton)
        'Check the other buttons.
    
        If jButton(jButtonNum) Then
            WaitForKey = "BUTTON" + toString(jButtonNum + 1)
        End If
    Next jButtonNum
    
    If keyWaitState = 88 And keyShiftState = 4 Then
        'User pressed ALT-X: Force exit.
        gGameState = GS_QUIT
    End If
    
    Dim returnVal As String
    'Get a string of the key number.
    returnVal$ = Chr$(keyWaitState)
    
    'Check the key for common keys.
    If keyWaitState = 13 Then returnVal$ = "ENTER"
    If keyWaitState = 32 Then returnVal$ = "SPACE"
    If keyWaitState = 38 Then returnVal$ = "UP"
    If keyWaitState = 40 Then returnVal$ = "DOWN"
    If keyWaitState = 37 Then returnVal$ = "LEFT"
    If keyWaitState = 39 Then returnVal$ = "RIGHT"
    If keyShiftState = 1 Then returnVal$ = UCase$(returnVal$)
    'Might want to add numberpad here too.
    
    WaitForKey = returnVal$
    
    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub getMouseMove(ByRef x As Long, ByRef y As Long)
    '=============================================
    'Waits for user to move mouse on mainFormform.
    'Returns x and y.
    '=============================================
    'Called by MoveMouseRPG only.
    
    On Error GoTo errorhandler
    
    mouseMoveX = -1
    
    bWaitingForInput = True
    
    Do While mouseMoveX = -1
        Call processEvent
    Loop
    
    bWaitingForInput = False
    x = Int(mouseMoveX)
    y = Int(mouseMoveY)

    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub getMouse(ByRef x As Long, ByRef y As Long)
    '=========================================
    'Waits for user to click mouse on mainForm.
    'Returns x and y.
    '=========================================
    'Called by MouseClickRPG only.
    
    On Error GoTo errorhandler
    
    mouseX = -1
    bWaitingForInput = True
    
    Do While mouseX = -1
        Call processEvent
    Loop
    
    bWaitingForInput = False
    
    x = Int(mouseX)
    y = Int(mouseY)

    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub getMouseNoWait(ByRef x As Long, ByRef y As Long)

    '======================================================
    'Waits only 15 milliseconds for the mouse to be clicked
    '======================================================
    '[KSNiloc]

    On Error Resume Next
    
    bWaitingForInput = True
    Call DoEventsFor(15)
    bWaitingForInput = False

    x = Round(mouseX)
    y = Round(mouseY)

End Sub

Function isPressed(ByVal theKey As String) As Boolean
    '=============================
    'EDITED: [Delano - 4/05/04]
    'Added recognition of numberpad keys.
    '=============================
    'Checks if the supplied key has been pressed.
    'Special keys: LEFT, RIGHT, UP, DOWN, SPACE, ESC, ENTER
    'Numberpad keys: NUMPAD0 to NUMPAD9
    'Joystick buttons: BUTTON, BUTTON1, BUTTON2, BUTTON3, BUTTON4
    
    'Called by scanKeys when checking for movement.
    'Called by ShowPromptDialog, ShowFileDialog, SelectionBox to move around Windows dialog boxes (i.e. PromptRPG)
    'Called by CursorMapRun to move around the menu's cursor system.
    'Called by CBCheckKey as the callback function to dlls to check for user-defined keys.
    
    'GetAsyncKeyState is the user32.lib function which function determines whether the key is
    'up or down at the time the function is called, and whether the key was pressed after a
    'previous call to GetAsyncKeyState.
    'Returns: If the most significant bit is set (if return is negative), the key is down, and if the least
    'significant bit is set, the key was pressed after the previous call to GetAsyncKeyState.
    
    On Error Resume Next
    
    isPressed = False
    
    'First check the joystick...
    Dim but(4) As Boolean
    Dim theDir As Long
    If mainMem.useJoystick = 1 Then
        theDir = joyDirection(but)
    End If
    
    Select Case UCase$(theKey)
    
        Case "LEFT":
            If GetAsyncKeyState(VK_LEFT) < 0 Then isPressed = True
            'If the left arrow key was pressed.
            Exit Function
            
        Case "RIGHT":
            If GetAsyncKeyState(VK_RIGHT) < 0 Then isPressed = True
            Exit Function
            
        Case "UP":
            If GetAsyncKeyState(VK_UP) < 0 Then isPressed = True
            Exit Function
            
        Case "DOWN":
            If GetAsyncKeyState(VK_DOWN) < 0 Then isPressed = True
            Exit Function
            
        Case "JOYLEFT":
            If theDir = 5 Or theDir = 6 Or theDir = 4 Then isPressed = True
            'If the joystick was moved left.
            Exit Function
        
        Case "JOYRIGHT":
            If theDir = 1 Or theDir = 2 Or theDir = 8 Then isPressed = True
            Exit Function
            
        Case "JOYUP":
            If theDir = 3 Or theDir = 4 Or theDir = 2 Then isPressed = True
            Exit Function
            
        Case "JOYDOWN":
            If theDir = 7 Or theDir = 8 Or theDir = 6 Then isPressed = True
            Exit Function
            
        Case "SPACE":
            If GetAsyncKeyState(VK_SPACE) < 0 Then isPressed = True
            Exit Function
        
        Case "ESC", "ESCAPE":
            If GetAsyncKeyState(VK_ESCAPE) < 0 Then isPressed = True
            Exit Function
        
        Case "ENTER":
            If GetAsyncKeyState(VK_RETURN) < 0 Then isPressed = True
            Exit Function
            
        'Added cases for the numberpad keys. Keeping them separate from directions for the moment.
        Case "NUMPAD0":
            If GetAsyncKeyState(VK_NUMPAD0) < 0 Then isPressed = True
            Exit Function
        
        Case "NUMPAD1":
            If GetAsyncKeyState(VK_NUMPAD1) < 0 Then isPressed = True
            Exit Function
            
        Case "NUMPAD2":
            If GetAsyncKeyState(VK_NUMPAD2) < 0 Then isPressed = True
            Exit Function
        
        Case "NUMPAD3":
            If GetAsyncKeyState(VK_NUMPAD3) < 0 Then isPressed = True
            Exit Function
        
        Case "NUMPAD4":
            If GetAsyncKeyState(VK_NUMPAD4) < 0 Then isPressed = True
            Exit Function
        
        Case "NUMPAD5":
            If GetAsyncKeyState(VK_NUMPAD5) < 0 Then isPressed = True
            Exit Function
                
        Case "NUMPAD6":
            If GetAsyncKeyState(VK_NUMPAD6) < 0 Then isPressed = True
            Exit Function
            
        Case "NUMPAD7":
            If GetAsyncKeyState(VK_NUMPAD7) < 0 Then isPressed = True
            Exit Function
            
        Case "NUMPAD8":
            If GetAsyncKeyState(VK_NUMPAD8) < 0 Then isPressed = True
            Exit Function
        
        Case "NUMPAD9":
            If GetAsyncKeyState(VK_NUMPAD9) < 0 Then isPressed = True
            Exit Function
            
        'Joystick buttons.
        Case "BUTTON", "BUTTON1":
            isPressed = but(0)
            Exit Function
        Case "BUTTON2":
            isPressed = but(1)
            Exit Function
        Case "BUTTON3":
            isPressed = but(2)
            Exit Function
        Case "BUTTON4":
            isPressed = but(3)
            Exit Function
        
        Case Else:
            'Not a reserved key.
            
            theKey = UCase$(theKey)
            
            'Asc function returns the the ANSI code of the character.
            Dim code As Long
            code = Asc(Mid$(theKey, 1, 1))
            
            If GetAsyncKeyState(code) < 0 Then
                isPressed = True
            End If
    End Select
    
    Call processEvent
    
End Function

Sub keyDownEvent(ByVal keyCode As Integer, ByVal Shift As Integer)
    On Error Resume Next
    '=============================
    'Called when a key down event is discovered in the MainForm.
    'Renamed: t >> index
    '=============================
    'Called by Form_KeyDown only.
    
    'Save old keycodes.
    keyWaitState = keyCode
    keyShiftState = Shift
    
    'When a dialog window is called, either ShowFileDialog or ShowPromptDialog.
    'Control is returned when the dialog is closed.
    If ignoreKeyDown Then Exit Sub

    'Inform plugins...
    Dim strKey As String
    Dim Index As Integer
    
    'Check some common codes.
    Select Case keyCode
        Case 13:
            strKey = "ENTER"
        Case 27:
            strKey = "ESC"
        Case 32:
            strKey = "SPACE"
        Case 37:
            strKey = "LEFT"
        Case 38:
            strKey = "UP"
        Case 39:
            strKey = "RIGHT"
        Case 40:
            strKey = "DOWN"
        Case Else:
            strKey = Chr$(keyCode)
    End Select
    
    Debug.Print strKey
    
    'Check custom plugins to see if they request an input.
    Dim plugName As String
    For Index = 0 To UBound(mainMem.plugins)
        If mainMem.plugins(Index) <> "" Then
            'If there is a plugin in this slot, get the name.
            plugName = PakLocate(projectPath$ + plugPath$ + mainMem.plugins(Index))
            
            If PLUGInputRequested(plugName, INPUT_KB) = 1 Then
                'If an input is requested, return that input to the plugin.
                Call PLUGEventInform(plugName, keyCode, -1, -1, -1, Shift, strKey, INPUT_KB)
            End If
        End If
    Next Index
    
    'Check the menu plugin.
    If mainMem.menuPlugin <> "" Then
        plugName = PakLocate(projectPath$ + plugPath$ + mainMem.menuPlugin)
        
        If PLUGInputRequested(plugName, INPUT_KB) = 1 Then
            Call PLUGEventInform(plugName, keyCode, -1, -1, -1, Shift, strKey, INPUT_KB)
        End If
    End If
    
    'Check the fight plugin.
    If mainMem.fightPlugin <> "" Then
        plugName = PakLocate(projectPath$ + plugPath$ + mainMem.fightPlugin)
        
        If PLUGInputRequested(plugName, INPUT_KB) = 1 Then
            Call PLUGEventInform(plugName, keyCode, -1, -1, -1, Shift, strKey, INPUT_KB)
        End If
    End If


    If (Not runningProgram) And (Not bInMenu) And (Not fightInProgress) Then
        'Scan for special keys.
        
        If keyCode = 88 And Shift = 4 Then
            'user pressed ALT-X: Force exit.
            gGameState = GS_QUIT
            Exit Sub
        End If
        
        If keyCode = 68 And Shift = 4 Then
            'User pressed ALT-D (toggle debugging).
            debugging = Not (debugging)
        End If
        
        If UCase$(str$(mainMem.Key)) = UCase$(str$(keyCode)) Then
            'User pressed the activation key.
            'Check to see if there is a program to be activated at this location.
            Call programTest(ppos(selectedPlayer))
        End If
        
        'Check primary runtime key: run its associated program if so.
        If UCase$(str$(keyCode)) = UCase$(str$(mainMem.runKey)) Then
            Call runProgram(projectPath$ + prgPath$ + mainMem.runTime$)
            Exit Sub
        End If
        
        'Check extended runtime keys...
        For Index = 0 To 50
            If UCase$(Chr$(keyCode)) = UCase$(Chr$(mainMem.runTimeKeys(Index))) Then
                If mainMem.runTimePrg$(Index) <> "" Then
                
                    Call runProgram(projectPath$ + prgPath$ + mainMem.runTimePrg$(Index))
                    Exit Sub
                
                End If
            End If
        Next Index
        
        'Check the menu key.
        If UCase$(str$(keyCode)) = UCase$(str$(mainMem.menuKey)) Then
            Call showMenu
            Exit Sub
        End If
        
    End If 'End if not (programRunning)
    
End Sub

Sub mouseDownEvent(ByVal x As Integer, ByVal y As Integer, ByVal Shift As Integer, ByVal button As Integer)
    '======================================================
    'Called when mouse down event detected on the MainForm.
    'Renamed variables: t >> index
    '======================================================
    'Called by Form_MouseDown only.
    
    On Error Resume Next
    
    'Returned values from the form.
    mouseX = x
    mouseY = y
    
    'Inform plugins...
    Dim Index As Integer
    Dim plugName As String
    
    'Check custom plugins to see if they request an input.
    For Index = 0 To UBound(mainMem.plugins)
        If mainMem.plugins(Index) <> "" Then
            'If there is a plugin in this slot, get the name.
            plugName = PakLocate(projectPath$ + plugPath$ + mainMem.plugins(Index))
            
            If PLUGInputRequested(plugName, INPUT_MOUSEDOWN) = 1 Then
                'If an input is requested, return that input to the plugin.
                Call PLUGEventInform(plugName, -1, x, y, button, Shift, "", INPUT_MOUSEDOWN)
            End If
        End If
    Next Index
    
    'Check the menu plugin.
    If mainMem.menuPlugin <> "" Then
        plugName = PakLocate(projectPath$ + plugPath$ + mainMem.menuPlugin)
        
        If PLUGInputRequested(plugName, INPUT_MOUSEDOWN) = 1 Then
            Call PLUGEventInform(plugName, -1, x, y, button, Shift, "", INPUT_MOUSEDOWN)
        End If
    End If
    
    'Check the fight plugin.
    If mainMem.fightPlugin <> "" Then
        plugName = PakLocate(projectPath$ + plugPath$ + mainMem.fightPlugin)
        
        If PLUGInputRequested(plugName, INPUT_MOUSEDOWN) = 1 Then
            Call PLUGEventInform(plugName, -1, x, y, button, Shift, "", INPUT_MOUSEDOWN)
        End If
    End If
    
End Sub

Sub mouseMoveEvent(ByVal x As Integer, ByVal y As Integer)
    '=====================================================
    'Called when mouse move event detected on the MainForm
    'Called by Form_MoveMouse only.
    '=====================================================
    On Error Resume Next
    
    'Returned values from the form.
    mouseMoveX = x
    mouseMoveY = y
    
End Sub

Sub scanKeys()
    '=============================
    'EDITED: [Delano - 4/05/04]
    'Added support for the numberpad for moving on the boards,
    'and controls to turn the arrow keys off.
    '=============================
    
    'Called by the mainLoop only, when in the GS_IDLE state, and scans for any pressed keys.
    'Initiates player movement via insertTarget; only updates the pending movements, all other
    'movements handled independently in the GS_MOVEMENT state in the mainLoop.
    
    On Error Resume Next
    
    'Temporarily defining these true always. Defined at top of this module.
    useArrowKeys = True
    useNumberPad = True
    'useJoyStick = false
    
    If (isPressed("RIGHT") And isPressed("UP") And useArrowKeys) Or (isPressed("NUMPAD9") And useNumberPad) Then
        'Move NorthEast
        
        'If [UP and RIGHT are pressed and using arrow keys is enabled] or
        '   [NUMPAD9 is pressed and the numberpad is enabled]
        
        'Update the origin location to the current location (however this is already done
        'by the isometric "jump" correction in the mainLoop).
        pendingPlayerMovement(selectedPlayer).direction = MV_NE
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        
        'Insert the target co-ordinates based on the movement direction.
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        'Set the frame count for the move to zero (i.e. next frame will be the first).
        movementCounter = 0
        
        'Set the mainLoop state to movement. The mainLoop will repeat until the required number of
        'frames are drawn.
        gGameState = GS_MOVEMENT
        
        Exit Sub
    End If
    
    If (isPressed("LEFT") And isPressed("UP") And useArrowKeys) Or (isPressed("NUMPAD7") And useNumberPad) Then
        'Move NorthWest
        
        pendingPlayerMovement(selectedPlayer).direction = MV_NW
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("RIGHT") And isPressed("DOWN") And useArrowKeys) Or (isPressed("NUMPAD3") And useNumberPad) Then
        'Move SouthEast
        
        pendingPlayerMovement(selectedPlayer).direction = MV_SE
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("LEFT") And isPressed("DOWN") And useArrowKeys) Or (isPressed("NUMPAD1") And useNumberPad) Then
        'Move SouthWest
        
        pendingPlayerMovement(selectedPlayer).direction = MV_SW
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("UP") And useArrowKeys) Or _
        (isPressed("NUMPAD8") And useNumberPad) Or (isPressed("JOYUP") And useJoystick) Then
        'Move North
        
        pendingPlayerMovement(selectedPlayer).direction = MV_NORTH
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("DOWN") And useArrowKeys) Or _
        (isPressed("NUMPAD2") And useNumberPad) Or (isPressed("JOYDOWN") And useJoystick) Then
        'Move South
        
        pendingPlayerMovement(selectedPlayer).direction = MV_SOUTH
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("RIGHT") And useArrowKeys) Or _
        (isPressed("NUMPAD6") And useNumberPad) Or (isPressed("JOYRIGHT") And useJoystick) Then
        'Move East
        
        pendingPlayerMovement(selectedPlayer).direction = MV_EAST
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If
    
    If (isPressed("LEFT") And useArrowKeys) Or _
        (isPressed("NUMPAD4") And useNumberPad) Or (isPressed("JOYLEFT") And useJoystick) Then
        'Move West
        
        pendingPlayerMovement(selectedPlayer).direction = MV_WEST
        pendingPlayerMovement(selectedPlayer).xOrig = ppos(selectedPlayer).x
        pendingPlayerMovement(selectedPlayer).yOrig = ppos(selectedPlayer).y
        pendingPlayerMovement(selectedPlayer).lOrig = ppos(selectedPlayer).l
        Call insertTarget(pendingPlayerMovement(selectedPlayer))
        
        movementCounter = 0
        gGameState = GS_MOVEMENT
        Exit Sub
    End If

    If isPressed("BUTTON1") Then
        'Let joystick button 1 act as the activation key.
        
        keyWaitState = mainMem.Key
        Call programTest(ppos(selectedPlayer))
        Exit Sub
    End If
    
    If isPressed("BUTTON2") Then
        'Bring up the menu when the user presses joystick button 2.
        
        Call showMenu
        Exit Sub
    End If
    
End Sub


