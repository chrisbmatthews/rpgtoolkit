VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDirectXHost"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' DirectX host class
' Status: A-
'=========================================================================

'=========================================================================
' This class replaces the host form with more more correct and rebust
' code. It also harbours the engine's main loop (mainEventLoop). Keyboard
' and mouse input are now picked up in transEvents.
'=========================================================================

Option Explicit

'=========================================================================
' Win32 Structures
'=========================================================================

'Window class structure (Ex)
Private Type WNDCLASSEX
    cbSize As Long
    style As Long
    lpfnWndProc As Long
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

'Window creation structure
Private Type CREATESTRUCT
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
Private Declare Function RegisterClassEx Lib "user32" Alias "RegisterClassExA" (pcWndClassEx As WNDCLASSEX) As Integer
Private Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hwndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, lpParam As Any) As Long
Private Declare Function GetStockObject Lib "gdi32" (ByVal nIndex As Long) As Long
Private Declare Function LoadIcon Lib "user32" Alias "LoadIconA" (ByVal hInstance As Long, ByVal lpIconName As String) As Long
Private Declare Function LoadCursor Lib "user32" Alias "LoadCursorA" (ByVal hInstance As Long, ByVal lpCursorName As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function UnregisterClass Lib "user32" Alias "UnregisterClassA" (ByVal lpClassName As String, ByVal hInstance As Long) As Long
Private Declare Function DestroyWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long

'=========================================================================
' Win32 Constants
'=========================================================================
Private Const CS_BYTEALIGNCLIENT = &H1000
Private Const CS_BYTEALIGNWINDOW = &H2000
Private Const CS_CLASSDC = &H40
Private Const CS_DBLCLKS = &H8
Private Const CS_HREDRAW = &H2
Private Const CS_INSERTCHAR = &H2000
Private Const CS_KEYCVTWINDOW = &H4
Private Const CS_NOCLOSE = &H200
Private Const CS_NOKEYCVT = &H100
Private Const CS_NOMOVECARET = &H4000
Private Const CS_OWNDC = &H20
Private Const CS_PARENTDC = &H80
Private Const CS_PUBLICCLASS = &H4000
Private Const CS_SAVEBITS = &H800
Private Const CS_VREDRAW = &H1
Private Const WS_VISIBLE = &H10000000
Private Const WS_OVERLAPPED = &H0&
Private Const WS_CAPTION = &HC00000
Private Const WS_SYSMENU = &H80000
Private Const WS_THICKFRAME = &H40000
Private Const WS_MINIMIZEBOX = &H20000
Private Const WS_MAXIMIZEBOX = &H10000
Private Const WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED Or WS_CAPTION Or WS_SYSMENU)
Private Const IDI_APPLICATION = 32512&
Private Const IDC_ARROW = 32512&
Private Const BLACK_BRUSH = 4
Private Const WINDOWS_CLASS = "DirectXHost"
Private Const WS_POPUP = &H80000000
Private Const IDC_NO = 32648&
Private Const WS_CHILD = &H40000000
Private Const BS_PUSHBUTTON = &H0&

'=========================================================================
' Member variables
'=========================================================================
Private m_created As Boolean
Private m_hwnd As Long
Private m_createHeight As Long
Private m_createWidth As Long
Private m_createCaption As String
Private m_createStyle As Long
Private m_createX As Long
Private m_createY As Long
Private m_buttonHwnd As Long

'=========================================================================
' Window's handle
'=========================================================================
Public Property Get hwnd() As Long
    hwnd = m_hwnd
End Property

'=========================================================================
' Window's device context
'=========================================================================
Public Property Get hdc() As Long
    hdc = GetDC(m_hwnd)
End Property

'=========================================================================
' Style: 0 - fullscreen; 1 - windowed
'=========================================================================
Public Property Let style(ByVal newValue As Long)
    If newValue = 0 Then
        m_createStyle = WS_POPUP
    ElseIf newValue = 1 Then
        m_createStyle = WS_OVERLAPPEDWINDOW Or WS_MINIMIZEBOX
    End If
End Property

'=========================================================================
' Window's caption
'=========================================================================
Public Property Let Caption(ByVal newValue As String)
    If Not m_created Then
        m_createCaption = newValue
    Else
        Call SetWindowText(m_hwnd, newValue)
    End If
End Property

'=========================================================================
' Window's class
'=========================================================================
Public Property Get className() As String
    className = WINDOWS_CLASS
End Property

'=========================================================================
' Window's mouse pointer (TBD)
'=========================================================================
Public Property Let mousePointer(ByVal newValue As Long)
    'TBD
End Property

'=========================================================================
' Window's mouse icon (TBD)
'=========================================================================
Public Property Let mouseIcon(ByVal newValue As Long)
    'TBD
End Property

'=========================================================================
' Window's width
'=========================================================================
Public Property Get Width() As Long
    Width = m_createWidth
End Property
Public Property Let Width(ByVal newVal As Long)
     m_createWidth = newVal
End Property

'=========================================================================
' Window's height
'=========================================================================
Public Property Get height() As Long
    height = m_createHeight
End Property
Public Property Let height(ByVal newVal As Long)
     m_createHeight = newVal
End Property

'=========================================================================
' Window's X coord
'=========================================================================
Public Property Get Left() As Long
    Left = m_createX
End Property
Public Property Let Left(ByVal newVal As Long)
     m_createX = newVal
End Property

'=========================================================================
' Window's Y coord
'=========================================================================
Public Property Get Top() As Long
    Top = m_createY
End Property
Public Property Let Top(ByVal newVal As Long)
     m_createY = newVal
End Property

'=========================================================================
' Show the console
'=========================================================================
Public Sub Show()
    Call ShowWindow(m_hwnd, 10)
End Sub

'=========================================================================
' Create the console
'=========================================================================
Public Sub Create()

    On Error Resume Next

    'Create a windows class and fill it in
    Dim wnd As WNDCLASSEX
    With wnd
        .cbSize = Len(wnd) 'callback size == length of the structure
        .style = CS_DBLCLKS Or CS_OWNDC Or CS_VREDRAW Or CS_HREDRAW 'style of window
        .lpfnWndProc = getAddress(AddressOf WndProc) 'Address of WinProc
        .hInstance = App.hInstance 'instance of owning application
        If fileExists("icon.ico") Then
            .hIcon = LoadIcon(0, "icon.ico")
            .hIconSm = LoadIcon(0, "icon.ico")
        End If
        .hbrBackground = GetStockObject(BLACK_BRUSH) 'black background
        .lpszClassName = WINDOWS_CLASS 'name of this class
        If mainMem.mouseCursor = 1 Then
            .hCursor = LoadCursor(0, IDC_ARROW) 'generic cursor
        Else
            .hCursor = LoadCursor(0, IDC_NO) 'no cursor
        End If
    End With

    'Register the class so windows knows of its existence
    Call RegisterClassEx(wnd)

    'Make sure we have a caption
    If m_createCaption = "" Then
        m_createCaption = "RPGToolkit3 Translator"
    End If

    'Create window ex shows the window we just made
    Dim cs As CREATESTRUCT
    m_hwnd = vbCreateWindow( _
                               0, _
                               WINDOWS_CLASS, _
                               m_createCaption, _
                               m_createStyle, _
                               m_createX / Screen.TwipsPerPixelX, _
                               m_createY / Screen.TwipsPerPixelY, _
                               m_createWidth / Screen.TwipsPerPixelX, _
                               m_createHeight / Screen.TwipsPerPixelY, _
                               0, 0, App.hInstance, _
                               cs _
                                    )

    'Flag the window has been created
    m_created = True

End Sub

'=========================================================================
' Main loop
'=========================================================================
Public Sub mainEventLoop()

    'This is the main event loop of the whole trans3 engine.
    'It will process events in the DirectX host window and
    'send them to WndProc() (in transEvents). It also
    'continually calls gameLogic() (in transMain). The only
    'to break out of this loop is to call PostQuitMessage().

    Dim message As msg
    Do While True
        If PeekMessage(message, m_hwnd, 0, 0, PM_REMOVE) Then
            'There was a message, check if it's WinProc asking
            'to leave this loop...
            If message.message = WM_QUIT Then
                'It was-- quit
                Exit Do
            Else
                'It wasn't, send the message to WinProc
                Call TranslateMessage(message)
                Call DispatchMessage(message)
            End If
        End If
        Call gameLogic
    Loop

    'Clean up
    Call closeSystems
    Call endform.Show(vbModal)

End Sub

'=========================================================================
' Used to retrieve address of a procedure
'=========================================================================
Private Function getAddress(ByVal address As Long) As Long
    getAddress = address
End Function

'=========================================================================
' Create a window
'=========================================================================
Private Function vbCreateWindow(ByVal dwExStyleFlags As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyleFlags As Long, ByVal xPos As Long, ByVal yPos As Long, ByVal xWidth As Long, ByVal yHeight As Long, ByVal hwndParent As Long, ByVal hMenu As Long, ByVal hInst As Long, ByRef lpParam As CREATESTRUCT) As Long
    vbCreateWindow = CreateWindowEx(dwExStyleFlags, lpClassName, lpWindowName, dwStyleFlags, xPos, yPos, xWidth, yHeight, hwndParent, hMenu, hInst, lpParam)
End Function
