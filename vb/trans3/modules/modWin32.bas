Attribute VB_Name = "transGUI"
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Trans3 GUI systems
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Window class structure
'=========================================================================
Public Type WNDCLASSEX
    cbSize As Long
    style As Long
    lpfnwndproc As Long
    cbClsextra As Long
    cbWndExtra As Long
    hInstance As Long
    hIcon As Long
    hCursor As Long
    hbrBackground As Long
    lpszMenuName As String
    lpszClassName As String
    hIconSm As Long
End Type

'=========================================================================
' Older window class structure
'=========================================================================
Public Type WNDCLASS
    style As Long
    lpfnwndproc As Long
    cbClsextra As Long
    cbWndExtra2 As Long
    hInstance As Long
    hIcon As Long
    hCursor As Long
    hbrBackground As Long
    lpszMenuName As String
    lpszClassName As String
End Type

'=========================================================================
' Window creation structure
'=========================================================================
Public Type CREATESTRUCT
    lpCreateParams As Long
    hInstance As Long
    hMenu As Long
    hwndParent As Long
    cy As Long
    cx As Long
    y As Long
    x As Long
    style As Long
    lpszName As String
    lpszClass As String
    ExStyle As Long
End Type

'=========================================================================
' Win32 APIs
'=========================================================================
Public Declare Function RegisterClassEx Lib "user32" Alias "RegisterClassExA" (ByRef pcWndClassEx As WNDCLASSEX) As Integer
Public Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hwndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, ByRef lpParam As Any) As Long
Public Declare Function GetStockObject Lib "gdi32" (ByVal nIndex As Long) As Long
Public Declare Function LoadIcon Lib "user32" Alias "LoadIconA" (ByVal hInstance As Long, ByVal lpIconName As String) As Long
Public Declare Function LoadCursor Lib "user32" Alias "LoadCursorA" (ByVal hInstance As Long, ByVal lpCursorName As String) As Long
Public Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Public Declare Function UnregisterClass Lib "user32" Alias "UnregisterClassA" (ByVal lpClassName As String, ByVal hInstance As Long) As Long
Public Declare Function DestroyWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function UpdateWindow Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function RegisterClass Lib "user32" Alias "RegisterClassA" (ByRef Class As WNDCLASS) As Long
Public Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Public Declare Function SetFocus Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long

'=========================================================================
' Win32 Constants
'=========================================================================
Public Const CS_BYTEALIGNCLIENT = &H1000
Public Const CS_BYTEALIGNWINDOW = &H2000
Public Const CS_CLASSDC = &H40
Public Const CS_DBLCLKS = &H8
Public Const CS_HREDRAW = &H2
Public Const CS_INSERTCHAR = &H2000
Public Const CS_KEYCVTWINDOW = &H4
Public Const CS_NOCLOSE = &H200
Public Const CS_NOKEYCVT = &H100
Public Const CS_NOMOVECARET = &H4000
Public Const CS_OWNDC = &H20
Public Const CS_PARENTDC = &H80
Public Const CS_PUBLICCLASS = &H4000
Public Const CS_SAVEBITS = &H800
Public Const CS_VREDRAW = &H1
Public Const WS_VISIBLE = &H10000000
Public Const WS_OVERLAPPED = &H0&
Public Const WS_CAPTION = &HC00000
Public Const WS_SYSMENU = &H80000
Public Const WS_THICKFRAME = &H40000
Public Const WS_MINIMIZEBOX = &H20000
Public Const WS_MAXIMIZEBOX = &H10000
Public Const WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED Or WS_CAPTION Or WS_SYSMENU)
Public Const IDI_APPLICATION = 32512&
Public Const IDC_ARROW = 32512&
Public Const BLACK_BRUSH = 4
Public Const WS_POPUP = &H80000000
Public Const IDC_NO = 32648&
Public Const WS_CHILD = &H40000000
Public Const BS_PUSHBUTTON = &H0&
Public Const PM_NOREMOVE = &H0
Public Const GRAY_BRUSH = 2
Public Const NULL_BRUSH = 5
Public Const LTGRAY_BRUSH = 1
Public Const BS_DEFPUSHBUTTON = &H1&
Public Const WM_COMMAND = &H111

'=========================================================================
' Member variables
'=========================================================================
Private m_exitDo As Boolean
Private m_isActive As Boolean

'=========================================================================
' Public variables
'=========================================================================
Public bShowEndForm As Boolean

'=========================================================================
' Used to retrieve address of a procedure
'=========================================================================
Public Function getAddress(ByVal address As Long) As Long
    getAddress = address
End Function

'=========================================================================
' Create a window
'=========================================================================
Public Function vbCreateWindow(ByVal dwExStyleFlags As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyleFlags As Long, ByVal xPos As Long, ByVal yPos As Long, ByVal xWidth As Long, ByVal yHeight As Long, ByVal hwndParent As Long, ByVal hMenu As Long, ByVal hInst As Long, ByRef lpParam As CREATESTRUCT) As Long
    vbCreateWindow = CreateWindowEx(dwExStyleFlags, lpClassName, lpWindowName, dwStyleFlags, xPos, yPos, xWidth, yHeight, hwndParent, hMenu, hInst, lpParam)
End Function

'=========================================================================
' Show the end form
'=========================================================================
Public Sub showEndForm(Optional ByVal endProgram As Boolean = True)

    '=========================================================================
    ' YOU MAY NOT REMOVE THIS NOTICE !!!!!!
    '=========================================================================

    On Error Resume Next

    If bShowEndForm Then

        Const WINDOW_CLASS = "ENDFORM"

        'Create a windows class and fill it in
        Dim wnd As WNDCLASSEX
        With wnd
            .cbSize = Len(wnd) 'callback size == length of the structure
            .style = CS_DBLCLKS Or CS_OWNDC Or CS_VREDRAW Or CS_HREDRAW 'style of window
            .lpfnwndproc = getAddress(AddressOf endFormWndProc) 'Address of WinProc
            .hInstance = App.hInstance 'instance of owning application
            .lpszClassName = WINDOW_CLASS 'name of this class
            .hbrBackground = GetStockObject(BLACK_BRUSH)
            .hIcon = statusbar.Icon.handle  'grab the icon from the status bar form
                                            '(only until I figure out why VB doesn't
                                            'like CBM's sword icon)
        End With

        'Register the class so windows knows of its existence
        Call RegisterClassEx(wnd)

        'Create a window
        Dim cs As CREATESTRUCT, endFormHwnd As Long
        endFormHwnd = vbCreateWindow( _
                                        0, _
                                        WINDOW_CLASS, _
                                        "RPGToolkit Development System", _
                                        WS_OVERLAPPEDWINDOW Or WS_VISIBLE, _
                                        ((Screen.Width - (340 * Screen.TwipsPerPixelX)) / 2) / Screen.TwipsPerPixelX, _
                                        ((Screen.height - (140 * Screen.TwipsPerPixelY)) / 2) / Screen.TwipsPerPixelY, _
                                        340, _
                                        142, _
                                        0, 0, App.hInstance, _
                                        cs _
                                             )

        Dim okHwnd As Long, moreInfoHwnd As Long
        okHwnd = CreateWindowEx(0, "button", "OK", WS_VISIBLE Or WS_CHILD Or BS_DEFPUSHBUTTON, 253, 10, 70, 22, endFormHwnd, 100, App.hInstance, 0)
        moreInfoHwnd = CreateWindowEx(0, "button", "More Info", WS_VISIBLE Or WS_CHILD Or BS_PUSHBUTTON, 253, 40, 70, 22, endFormHwnd, 101, App.hInstance, 0)

        Call SetFocus(okHwnd)
        Call FlushKB

        Dim message As msg
        Do
            If m_exitDo Then
                Exit Do
            ElseIf PeekMessage(message, endFormHwnd, 0, 0, PM_REMOVE) Then
                Call TranslateMessage(message)
                Call DispatchMessage(message)
            ElseIf isPressed("ENTER") And m_isActive Then
                Call DestroyWindow(endFormHwnd)
                Exit Do
            End If
        Loop

        m_exitDo = False

        Call UnregisterClass(WINDOW_CLASS, App.hInstance)

    End If

    If endProgram Then
        'End the program!
        Call DeleteDC(endFormBackgroundHDC)
        End
    End If

End Sub

'=========================================================================
' End form event handler
'=========================================================================
Public Function endFormWndProc( _
                                  ByVal hwnd As Long, _
                                  ByVal msg As Long, _
                                  ByVal wParam As Long, _
                                  ByVal lParam As Long _
                                                         ) As Long

    Select Case msg

        Case WM_PAINT
            'Window needs to be repainted
            Dim ps As PAINTSTRUCT, hdc As Long
            Call BeginPaint(hwnd, ps)
            hdc = GetDC(hwnd)
            Call BitBlt(hdc, 1, 1, 372, 126, endFormBackgroundHDC, 0, 0, SRCPAINT)
            Call ReleaseDC(hwnd, hdc)
            Call EndPaint(hwnd, ps)

        Case WM_DESTROY
            'Window was closed-- bail!
            m_exitDo = True

        Case WM_COMMAND
            Select Case LoWord(wParam)

                Case 100
                    'OK button pressed
                    Call DestroyWindow(hwnd)
                    m_exitDo = True

                Case 101
                    'More info button pressed
                    Call Shell("start http://toolkitzone.com")
                    Call DestroyWindow(hwnd)
                    m_exitDo = True

            End Select

        Case WM_ACTIVATE
            If wParam <> WA_INACTIVE Then
                'Window is being *activated*
                m_isActive = True
            Else
                'Window is being *deactivated*
                m_isActive = False
            End If

        Case Else
            'Let windows deal with the rest
            endFormWndProc = DefWindowProc(hwnd, msg, wParam, lParam)

    End Select

End Function
