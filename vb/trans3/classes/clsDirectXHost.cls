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
' All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Host window
'=========================================================================

Option Explicit

'=========================================================================
' Members
'=========================================================================
Private m_created As Boolean        ' Window created?
Private m_createHeight As Long      ' Height to create window with
Private m_createWidth As Long       ' Width to create window with
Private m_createCaption As String   ' Caption to create window with
Private m_createStyle As Long       ' Style to create window with
Private m_createX As Long           ' X position window should start at
Private m_createY As Long           ' Y position window should start at
Private m_class As String           ' The windows class
Private m_hCursor As Long           ' The window's cursor

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function createHostWindow Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long, ByVal style As Long, ByVal Caption As String, ByVal instance As Long, ByVal className As String, ByVal hCursor As Long) As Long
Private Declare Sub killHostWindow Lib "actkrt3.dll" (ByVal className As String, ByVal hInstance As Long)
Private Declare Sub IMGCreateIcon Lib "actkrt3.dll" (ByVal cnv As Long, ByVal strFilename As String)
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpFileName As String) As Long
Private Declare Function DestroyCursor Lib "user32" (ByVal hCursor As Long) As Long
Private Declare Function SetClassWord Lib "user32" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal wNewWord As Long) As Long

'=========================================================================
' Member enumerations
'=========================================================================
Public Enum STYLE_ENUM
    FullScreenMode
    windowed
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
    Call killHostWindow(m_class, App.hInstance)
End Sub

'=========================================================================
' Style of window
'=========================================================================
Public Property Let style(ByVal newValue As STYLE_ENUM)
    If (newValue = FullScreenMode) Then
        m_createStyle = &H80000000
    ElseIf (newValue = windowed) Then
        m_createStyle = &H0& Or &HC00000 Or &H80000 Or &H20000
    End If
End Property

'=========================================================================
' Window's caption
'=========================================================================
Public Property Let Caption(ByVal newValue As String)
    If Not (m_created) Then
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

    ' Destroy any existing cursor
    If (m_hCursor) Then
        Call DestroyCursor(m_hCursor)
        m_hCursor = 0
    End If

    ' Create a canvas
    Dim cnv As Long
    cnv = createCanvas(32, 32)

    ' Fill with transp color
    Call canvasFill(cnv, mainMem.transpcolor)

    ' Save the cursor path
    Dim strCursorFileName As String
    strCursorFileName = TempDir() & "tkCur.cur"

    ' If it's the default cursor
    If (newValue = "TK DEFAULT") Then

        ' Save from resource file
        Call Kill(strCursorFileName)
        Call SavePicture(LoadResPicture(103, vbResBitmap), strCursorFileName)
        newValue = strCursorFileName

    ElseIf (LenB(newValue) = 0) Then

        ' No image passed in
        Exit Property

    Else

        ' Alter the path
        newValue = projectPath & bmpPath & newValue

    End If

    ' Draw to a canvas
    Call drawSizedImageCNV(newValue, 0, 0, 32, 32, cnv)

    ' Draw to a *.ico file
    Call IMGCreateIcon(cnv, strCursorFileName)

    ' Destroy the canvas
    Call destroyCanvas(cnv)

    ' Load the cursor
    m_hCursor = LoadCursorFromFile(strCursorFileName)

    ' If the window is open
    If (hwnd) Then

        ' Switch in this new cursor
        Call SetClassWord(hwnd, -12, m_hCursor)

    End If

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
Public Sub Create(ByRef strClass As String)

    On Error Resume Next

    hwnd = createHostWindow( _
        m_createX \ Screen.TwipsPerPixelX, _
        m_createY \ Screen.TwipsPerPixelY, _
        m_createWidth \ Screen.TwipsPerPixelX, _
        m_createHeight \ Screen.TwipsPerPixelY, _
        m_createStyle, _
        m_createCaption, _
        App.hInstance, _
        strClass, _
        IIf(m_hCursor, m_hCursor, LoadResPicture(101, vbResCursor).handle) _
    )

    ' Flag the window has been created
    m_created = True

    ' Record the class
    m_class = strClass

End Sub

'========================================================================='
' Deconstructor
'=========================================================================
Private Sub Class_Terminate()

    ' Kill any loaded cursor
    Call DestroyCursor(m_hCursor)

End Sub
