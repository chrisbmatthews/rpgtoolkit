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
' Globals
'=========================================================================
Public hwnd As Long                 ' Handle to this window
Public cursorHotSpotX As Long       ' Cursor HotSpot X
Public cursorHotSpotY As Long       ' Cursor HotSpot Y

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

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function createHostWindow Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long, ByVal style As Long, ByVal Caption As String, ByVal instance As Long, ByVal className As String, ByVal hCursor As Long) As Long
Private Declare Sub killHostWindow Lib "actkrt3.dll" (ByVal className As String, ByVal hInstance As Long)
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpFileName As String) As Long
Private Declare Function SetClassLong Lib "user32" Alias "SetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal dwrop As Long) As Long
Private Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
Private Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DestroyIcon Lib "user32" (ByVal hIcon As Long) As Long
Private Declare Function CreateIconIndirect Lib "user32" (ByRef pIconInfo As ICONINFO) As Long
Private Declare Function SetStretchBltMode Lib "gdi32" (ByVal hdc As Long, ByVal nStretchMode As Long) As Long

'=========================================================================
' Information on an icon
'=========================================================================
Private Type ICONINFO
    fIcon As Long
    xHotspot As Long
    yHotspot As Long
    hbmMask As Long
    hbmColor As Long
End Type

'=========================================================================
' Constants
'=========================================================================
Private Const GCL_HCURSOR = (-12)
Private Const COLORONCOLOR = 3

'=========================================================================
' Member enumerations
'=========================================================================
Public Enum STYLE_ENUM
    FullScreenMode
    windowed
End Enum

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
Public Property Let mousePointer(ByRef newValue As String)

    ' Bail on invalid file
    If (LenB(newValue) = 0) Then Exit Property

    ' Obtain a compatible DC
    Dim hCompatibleDc As Long
    hCompatibleDc = hdc()

    ' Declarations for the color bitmap
    Dim hColorDc As Long, hColorBmp As Long
    hColorDc = CreateCompatibleDC(hCompatibleDc)

    ' If it's the default cursor
    If (newValue = "TK DEFAULT") Then

        ' Obtain the bitmap from the resource file
        Dim objBitmap As Object
        Set objBitmap = LoadResPicture(103, vbResBitmap)
        hColorBmp = objBitmap.handle()
        Call SelectObject(hColorDc, hColorBmp)

        ' Cursor HotSpot is 1, 1
        cursorHotSpotX = 1
        cursorHotSpotY = 1

    Else

        ' Create a bitmap for the color cursor
        hColorBmp = CreateCompatibleBitmap(hCompatibleDc, 32, 32)

        ' Select the bitmap into the DC
        Call SelectObject(hColorDc, hColorBmp)

        ' Draw the image to the DC (and ultimately, the bitmap)
        Call SetStretchBltMode(hColorDc, COLORONCOLOR)
        Call DrawSizedImage(projectPath & bmpPath & newValue, 0, 0, 32, 32, hColorDc)

    End If

    ' Create a DC and bitmap for the mask
    Dim hMaskDc As Long, hMaskBmp As Long
    hMaskDc = CreateCompatibleDC(hCompatibleDc)
    hMaskBmp = CreateBitmap(32, 32, 1, 1, Null)

    ' Select the mask bitmap into the DC
    Call SelectObject(hMaskDc, hMaskBmp)

    ' Set the background color to the cursor transp color
    Call SetBkColor(hColorDc, mainMem.transpcolor)

    ' Blt the cursor onto the mask, ignoring the transp color
    Call BitBlt(hMaskDc, 0, 0, 32, 32, hColorDc, 0, 0, vbSrcCopy)

    ' Blt back over to the cursor
    Call BitBlt(hColorDc, 0, 0, 32, 32, hMaskDc, 0, 0, vbSrcInvert)

    ' Delete the DCs
    Call DeleteDC(hMaskDc)
    Call DeleteDC(hColorDc)
    Call ReleaseDC(hwnd, hCompatibleDc)

    ' Setup some icon information
    Dim theCursor As ICONINFO
    theCursor.hbmColor = hColorBmp
    theCursor.hbmMask = hMaskBmp
    theCursor.xHotspot = cursorHotSpotX
    theCursor.yHotspot = cursorHotSpotY

    ' Create the cursor
    Dim hCursor As Long
    hCursor = CreateIconIndirect(theCursor)

    ' Select in the new cursor
    Call SetClassLong(hwnd, GCL_HCURSOR, hCursor)

    ' Delete the cursor
    Call DestroyIcon(hCursor)

    ' Delete the bitmaps
    Call DeleteObject(hColorBmp)
    Call DeleteObject(hMaskBmp)

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
        LoadResPicture(101, vbResCursor).handle _
    )

    ' Flag the window has been created
    m_created = True

    ' Record the class
    m_class = strClass

End Sub
