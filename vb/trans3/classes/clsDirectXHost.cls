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
' Member constants
'=========================================================================
Private Const WINDOWS_CLASS = "DirectXHost"

'=========================================================================
' Member variables
'=========================================================================
Private m_created As Boolean        'window created?
Private m_createHeight As Long      'height to create window with
Private m_createWidth As Long       'width to create window with
Private m_createCaption As String   'caption to create window with
Private m_createStyle As Long       'style to create window with
Private m_createX As Long           'x position window should start at
Private m_createY As Long           'y position window should start at

'=========================================================================
' Member enumerations
'=========================================================================
Public Enum STYLE_ENUM
    FullScreenMode = 0
    windowed = 1
End Enum

'=========================================================================
' Window's handle
'=========================================================================
Public hwnd As Long

'=========================================================================
' Window's device context
'=========================================================================
Public Property Get hdc() As Long
    hdc = GetDC(hwnd)
End Property

'=========================================================================
' Style of window
'=========================================================================
Public Property Let style(ByVal newValue As STYLE_ENUM)
    If newValue = FullScreenMode Then
        m_createStyle = WS_POPUP
    ElseIf newValue = windowed Then
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
        Call SetWindowText(hwnd, newValue)
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
    Call ShowWindow(hwnd, 10)
End Sub

'=========================================================================
' Hide the console
'=========================================================================
Public Sub Hide()
    Call CloseWindow(hwnd)
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
        .lpfnwndproc = getAddress(AddressOf WndProc) 'Address of WinProc
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
    hwnd = vbCreateWindow( _
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
        If PeekMessage(message, host.hwnd, 0, 0, PM_REMOVE) Then
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
    Call showEndForm(True)

End Sub

