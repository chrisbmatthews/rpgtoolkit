Attribute VB_Name = "transEvents"
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Event handler
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Win32 structures
'=========================================================================

'Rectangle
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

'Region to re-paint
Private Type PAINTSTRUCT
    hdc As Long
    fErase As Long
    rcPaint As RECT
    fRestore As Long
    fIncUpdate As Long
    rgbReserved(32) As Byte
End Type

'Any x/y position
Private Type POINTAPI
    x As Long
    y As Long
End Type

'WinProc message
Public Type msg
    hwnd As Long
    message As Long
    wParam As Long
    lParam As Long
    time As Long
    pt As POINTAPI
End Type

'=========================================================================
' Win32 constants
'=========================================================================
Public Const WM_QUIT = &H12
Public Const WM_PAINT = &HF
Public Const WM_DESTROY = &H2
Public Const WM_CREATE = &H1
Public Const WM_CHAR = &H102
Public Const WM_KEYDOWN = &H100
Public Const WM_MOUSEMOVE = &H200
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_ACTIVATE = &H6
Public Const WA_INACTIVE = 0
Public Const PM_REMOVE = &H1

'=========================================================================
' Win32 APIs
'=========================================================================
Public Declare Function DefWindowProc Lib "user32" Alias "DefWindowProcA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function ValidateRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long) As Long
Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Public Declare Function BeginPaint Lib "user32" (ByVal hwnd As Long, lpPaint As PAINTSTRUCT) As Long
Public Declare Function EndPaint Lib "user32" (ByVal hwnd As Long, lpPaint As PAINTSTRUCT) As Long
Public Declare Function PeekMessage Lib "user32" Alias "PeekMessageA" (lpMsg As msg, ByVal hwnd As Long, ByVal wMsgFilterMin As Long, ByVal wMsgFilterMax As Long, ByVal wRemoveMsg As Long) As Long
Public Declare Function TranslateMessage Lib "user32" (lpMsg As msg) As Long
Public Declare Function DispatchMessage Lib "user32" Alias "DispatchMessageA" (lpMsg As msg) As Long
Public Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function UnregisterClass Lib "user32" Alias "UnregisterClassA" (ByVal lpClassName As String, ByVal hInstance As Long) As Long
Public Declare Function DestroyWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Sub PostQuitMessage Lib "user32" (ByVal nExitCode As Long)

'=========================================================================
' Event handler
'=========================================================================
Public Function WndProc( _
                           ByVal hwnd As Long, _
                           ByVal msg As Long, _
                           ByVal wParam As Long, _
                           ByVal lParam As Long _
                                                  ) As Long

    'This procecure handles events in the DirectX host window

    Static prevGameState As GAME_LOGIC_STATE    'Previous game state

    Select Case msg

        Case WM_PAINT
            'Window needs to be repainted
            Dim ps As PAINTSTRUCT
            Call BeginPaint(hwnd, ps)
            If (Not runningProgram) And (Not fightInProgress) And (Not bInMenu) Then
                Call renderNow
            ElseIf runningProgram Then
                Call renderRPGCodeScreen
            End If
            Call EndPaint(hwnd, ps)

        Case WM_DESTROY
            'Window was closed-- bail!
            If Not gShuttingDown Then
                Call closeSystems
                Call endform.Show(vbModal)
                End
            End If

        Case WM_CHAR
            'Key was pressed
            keyAsciiState = wParam

        Case WM_KEYDOWN
            'Key down
            Call keyDownEvent(wParam, 0)

        Case WM_MOUSEMOVE
            'Mouse was moved
            Call mouseMoveEvent(LoWord(lParam), HiWord(lParam))

        Case WM_LBUTTONDOWN
            'Left mouse button pressed
            Call mouseDownEvent(LoWord(lParam), HiWord(lParam), LoWord(wParam), 1)

        Case WM_ACTIVATE
            If wParam <> WA_INACTIVE Then
                'Window is being *activated*
                gGameState = prevGameState
            Else
                'Window is being *deactivated*
                prevGameState = gGameState
                gGameState = GS_PAUSE
            End If

        Case Else
            'Let windows deal with the rest
            WndProc = DefWindowProc(hwnd, msg, wParam, lParam)

    End Select

End Function

'=========================================================================
' Get low word
'=========================================================================
Private Function LoWord(ByRef LongIn As Long) As Integer
   Call CopyMemory(LoWord, LongIn, 2)
End Function

'=========================================================================
' Get high word
'=========================================================================
Private Function HiWord(ByRef LongIn As Long) As Integer
   Call CopyMemory(HiWord, ByVal (VarPtr(LongIn) + 2), 2)
End Function

'=========================================================================
' Process events
'=========================================================================
Public Sub processEvent()

    'This procedure is pretty much a replacement for DoEvents.
    'It will process a message from the queue *if there is one*
    'and then be done with.

    If host.hwnd = 0 Then Exit Sub

    Dim message As msg
    If PeekMessage(message, host.hwnd, 0, 0, PM_REMOVE) Then
        'There was a message, check if it's WinProc asking
        'to leave this loop...
        If message.message = WM_QUIT Then
            'It was-- quit
            Call closeSystems
            Call endform.Show(vbModal)
            End
        Else
            'It wasn't, send the message to WinProc
            Call TranslateMessage(message)
            Call DispatchMessage(message)
        End If
    End If
    DoEvents

End Sub
