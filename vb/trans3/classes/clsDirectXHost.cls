VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CDirectXHost"
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
' Interface with actkrt3.dll :: host window
' Status: A-
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
' Public variables
'=========================================================================
Public cursorHotSpotX As Long       'x hot spot of cursor
Public cursorHotSpotY As Long       'y hot spot of cursor

'=========================================================================
' Member declarations
'=========================================================================
Private Declare Function createHostWindow Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long, ByVal style As Long, ByVal Caption As String, ByVal instance As Long, ByVal className As String, ByVal hCursor As Long) As Long
Private Declare Sub killHostWindow Lib "actkrt3.dll" (ByVal className As String, ByVal hInstance As Long)
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long

'=========================================================================
' Member Win32 APIs
'=========================================================================
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long

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
' Destroy the window
'=========================================================================
Public Sub Destroy()
    On Error Resume Next
    Call killHostWindow(WINDOWS_CLASS, App.hInstance)
End Sub

'=========================================================================
' Style of window
'=========================================================================
Public Property Let style(ByVal newValue As STYLE_ENUM)
    If newValue = FullScreenMode Then
        m_createStyle = &H80000000
    ElseIf newValue = windowed Then
        m_createStyle = &H0& Or &HC00000 Or &H80000 Or &H20000
    End If
End Property

'=========================================================================
' Window's caption
'=========================================================================
Public Property Let Caption(ByVal newValue As String)
    If (Not m_created) Then
        m_createCaption = newValue
    Else
        Call SetWindowText(hwnd, newValue)
    End If
End Property

'=========================================================================
' Window's mouse pointer
'=========================================================================
Public Property Let mousePointer(ByVal newValue As String)
    On Error Resume Next
    Dim hdc As Long, theFile As String
    Call CanvasFill(cnvMousePointer, mainMem.transpcolor)
    If (newValue = "TK DEFAULT") Then
        theFile = TempDir() & "pointer"
        Call Kill(theFile)
        Call SavePicture(LoadResPicture(103, vbResBitmap), theFile)
        newValue = theFile
    ElseIf (LenB(newValue) = 0) Then
        Exit Property
    Else
        newValue = projectPath & bmpPath & newValue
    End If
    hdc = CanvasOpenHDC(cnvMousePointer)
    Call DrawSizedImage(newValue, 0, 0, 32, 32, hdc)
    Call CanvasCloseHDC(cnvMousePointer, hdc)
    If (LenB(theFile) <> 0) Then Call Kill(theFile)
End Property

'=========================================================================
' Window's width
'=========================================================================
Public Property Get width() As Long
    width = m_createWidth
End Property
Public Property Let width(ByVal newVal As Long)
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

    hwnd = createHostWindow( _
                               m_createX / Screen.TwipsPerPixelX, _
                               m_createY / Screen.TwipsPerPixelY, _
                               m_createWidth / Screen.TwipsPerPixelX, _
                               m_createHeight / Screen.TwipsPerPixelY, _
                               m_createStyle, _
                               m_createCaption, _
                               App.hInstance, _
                               WINDOWS_CLASS, _
                               LoadResPicture(101, vbResCursor).handle _
                                                                         )

    'Flag the window has been created
    m_created = True

End Sub
