VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cMDITabs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'
' http://vbAccelerator.com
'
' Filename:
' cMDITabs.cls
' Author:
' Steve McMahon (steve@vbaccelerator.com)
' Date:
' 13 December 2002
'
' Description
' A partial implementation of the VisualStudio.NET style tabs in an MDI form.
' Docking and multiple panes are not (and probably cannot be) supported.
'
' Tooltips for tabs and dragging to a different position aren't supported
' either yet.
'

Private Type POINTAPI
   x As Long
   y As Long
End Type
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Type WINDOWPOS
   hwnd As Long
   hWndInsertAfter As Long
   x As Long
   y As Long
   cx As Long
   cy As Long
   flags As Long
End Type
Private Type NCCALCSIZE_PARAMS
   rgrc(0 To 2) As RECT
   lppos As Long 'WINDOWPOS
End Type

Private Declare Function GetVersion Lib "kernel32" () As Long

Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, lpsz2 As Any) As Long
Private Declare Function EnumChildWindows Lib "user32" (ByVal hwndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long

Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Enum ESetWindowPosFlags
   HWND_TOPMOST = -1
   HWND_DESKTOP = 0
   SWP_NOSIZE = &H1
   SWP_NOMOVE = &H2
   SWP_NOREDRAW = &H8
   SWP_SHOWWINDOW = &H40
   SWP_FRAMECHANGED = &H20        '  The frame changed: send WM_NCCALCSIZE
   SWP_DRAWFRAME = SWP_FRAMECHANGED
   SWP_HIDEWINDOW = &H80
   SWP_NOACTIVATE = &H10
   SWP_NOCOPYBITS = &H100
   SWP_NOOWNERZORDER = &H200      '  Don't do owner Z ordering
   SWP_NOREPOSITION = SWP_NOOWNERZORDER
   SWP_NOZORDER = &H4
End Enum
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Enum EWindowLongIndexes
    GWL_EXSTYLE = (-20)
    GWL_HINSTANCE = (-6)
    GWL_HWNDPARENT = (-8)
    GWL_ID = (-12)
    GWL_STYLE = (-16)
    GWL_USERDATA = (-21)
    GWL_WNDPROC = (-4)
End Enum
' General window styles:
Private Enum EExWindowStyles
     WS_EX_DLGMODALFRAME = &H1
     WS_EX_NOPARENTNOTIFY = &H4
     WS_EX_TOPMOST = &H8
     WS_EX_ACCEPTFILES = &H10
     WS_EX_TRANSPARENT = &H20
     WS_EX_MDICHILD = &H40
     WS_EX_TOOLWINDOW = &H80
     WS_EX_WINDOWEDGE = &H100
     WS_EX_CLIENTEDGE = &H200
     WS_EX_CONTEXTHELP = &H400
     WS_EX_RIGHT = &H1000
     WS_EX_LEFT = &H0
     WS_EX_RTLREADING = &H2000
     WS_EX_LTRREADING = &H0
     WS_EX_LEFTSCROLLBAR = &H4000
     WS_EX_RIGHTSCROLLBAR = &H0
     WS_EX_CONTROLPARENT = &H10000
     WS_EX_STATICEDGE = &H20000
     WS_EX_APPWINDOW = &H40000
     WS_EX_OVERLAPPEDWINDOW = (WS_EX_WINDOWEDGE Or WS_EX_CLIENTEDGE)
     WS_EX_PALETTEWINDOW = (WS_EX_WINDOWEDGE Or WS_EX_TOOLWINDOW Or WS_EX_TOPMOST)
End Enum

Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function PostMessageLong Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Const WM_DESTROY = &H2
Private Const WM_SETCURSOR = &H20
Private Const WM_NCCALCSIZE = &H83
Private Const WM_NCPAINT = &H85
Private Const WM_SYSCOMMAND = &H112
Private Const WM_MOUSEMOVE = &H200
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202
Private Const WM_LBUTTONDBLCLK = &H203
Private Const WM_RBUTTONDOWN = &H204
Private Const WM_RBUTTONUP = &H205
Private Const WM_RBUTTONDBLCLK = &H206
Private Const SC_CLOSE = &HF060&
Private Const WM_ACTIVATE = &H6
Private Const WA_INACTIVE = 0

' Hittest
Private Const HTNOWHERE = 0


Private Enum E_WM_NCCALCSIZE_Return_Values
   ' WM_NCCALCSIZE return values;
   WVR_ALIGNBOTTOM = &H40
   WVR_ALIGNLEFT = &H20
   WVR_ALIGNRIGHT = &H80
   WVR_ALIGNTOP = &H10
   WVR_HREDRAW = &H100
   WVR_VALIDRECTS = &H400
   WVR_VREDRAW = &H200
   WVR_REDRAW = (WVR_HREDRAW Or WVR_VREDRAW)
End Enum
Private Enum EMDIMessages
   WM_MDIACTIVATE = &H222
   WM_MDICASCADE = &H227
   WM_MDICREATE = &H220
   WM_MDIDESTROY = &H221
   WM_MDIGETACTIVE = &H229
   WM_MDIICONARRANGE = &H228
   WM_MDIMAXIMIZE = &H225
   WM_MDINEXT = &H224
   WM_MDIREFRESHMENU = &H234
   WM_MDIRESTORE = &H223
   WM_MDISETMENU = &H230
   WM_MDITILE = &H226
End Enum

Private Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetWindowTextW Lib "user32" (ByVal hwnd As Long, ByVal lpString As Long, ByVal cch As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Private Declare Function GetWindowTextLengthW Lib "user32" (ByVal hwnd As Long) As Long

Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function PtInRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long

Private Declare Function CreateDCAsNull Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, _
           lpDeviceName As Any, lpOutput As Any, lpInitData As Any) As Long
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
    Private Const BITSPIXEL = 12
    Private Const LOGPIXELSX = 88    '  Logical pixels/inch in X
    Private Const LOGPIXELSY = 90    '  Logical pixels/inch in Y
Private Declare Function GetWindowDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetDCEx Lib "user32" (ByVal hwnd As Long, ByVal hrgnclip As Long, ByVal fdwOptions As Long) As Long
Private Const DCX_WINDOW = &H1&
Private Const DCX_INTERSECTRGN = &H80&
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long

Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, lpPoint As POINTAPI) As Long
Private Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Private Const PS_SOLID = 0
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function GetSysColorBrush Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Private Declare Function DrawTextW Lib "user32" (ByVal hdc As Long, ByVal lpStr As Long, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
' DrawText
Private Enum EDrawTextFormat
   DT_BOTTOM = &H8
   DT_CALCRECT = &H400
   DT_CENTER = &H1
   DT_EXPANDTABS = &H40
   DT_EXTERNALLEADING = &H200
   DT_INTERNAL = &H1000
   DT_LEFT = &H0
   DT_NOCLIP = &H100
   DT_NOPREFIX = &H800
   DT_RIGHT = &H2
   DT_SINGLELINE = &H20
   DT_TABSTOP = &H80
   DT_TOP = &H0
   DT_VCENTER = &H4
   DT_WORDBREAK = &H10
   DT_EDITCONTROL = &H2000&
   DT_PATH_ELLIPSIS = &H4000&
   DT_END_ELLIPSIS = &H8000&
   DT_MODIFYSTRING = &H10000
   DT_RTLREADING = &H20000
   DT_WORD_ELLIPSIS = &H40000
End Enum

Private Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Private Const OPAQUE = 2
Private Const TRANSPARENT = 1

Private Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long

Private Declare Function InflateRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function OffsetRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long

Private Declare Function OleTranslateColor Lib "OLEPRO32.DLL" (ByVal OLE_COLOR As Long, ByVal HPALETTE As Long, pccolorref As Long) As Long
Private Const CLR_INVALID = -1

Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseCapture Lib "user32" () As Long


Private m_hWndMdiClient As Long

Public Enum EMDITabAlign
   TabAlignTop
   TabAlignBottom
End Enum

Private m_bIsNt As Boolean

Private m_bJustReplaced As Boolean
Private m_tJustReplacedPoint As POINTAPI
Private m_iDraggingTab As Long
Private m_iTrackButton As Long
Private m_iPressButton As Long

Private m_eTabAlign As EMDITabAlign
Private m_bAllowScroll As Boolean
Private m_lTabHeight As Long
Private m_lButtonSize As Long
Private m_font As Ifont
Private m_fontSelected As Ifont
Private m_bShowTabs As Boolean
Private m_lOffsetX As Long

Private m_tTabR() As RECT
Private m_tButtonR As RECT

Private m_hWndTempChild As Collection
Private m_hWndChild As Collection
Private m_hWndSelected As Long

Private m_cMemDC As pcMemDC
Private WithEvents m_tmr As CTimer
Attribute m_tmr.VB_VarHelpID = -1

Public Event CloseWindow(ByVal hwnd As Long)
Attribute CloseWindow.VB_Description = "Raised whenever the user clicks the close button in the tab control."
Public Event WindowChanged(ByVal hwnd As Long)
Attribute WindowChanged.VB_Description = "Raised whenever the active MDI window changes."
Public Event TabClick(ByVal iButton As MouseButtonConstants, ByVal hwnd As Long, ByVal screenX As Long, ByVal screenY As Long)
Attribute TabClick.VB_Description = "Raised whenever the user clicks on a tab."
Public Event TabBarClick(ByVal iButton As MouseButtonConstants, ByVal screenX As Long, ByVal screenY As Long)
Attribute TabBarClick.VB_Description = "Raised whenever the user clicks on the tab bar (not on a tab)."

Implements ISubclass

Friend Sub addChildWindow(ByVal hwnd As Long)
   m_hWndTempChild.Add hwnd, "H" & hwnd
End Sub
Public Property Get SelectedFont() As Ifont
Attribute SelectedFont.VB_Description = "Gets/sets the font used to draw the caption of a selected window tab."
Dim iFnt As Ifont
Dim iFntC As Ifont
   Set iFnt = m_fontSelected
   iFnt.Clone iFntC
   Set SelectedFont = iFntC
End Property
Public Property Let SelectedFont(iFnt As Ifont)
   pSetSelectedFont iFnt
End Property
Public Property Set SelectedFont(iFnt As Ifont)
   pSetSelectedFont iFnt
End Property
Private Sub pSetSelectedFont(iFnt As Ifont)
Dim iFntC As Ifont
   iFnt.Clone iFntC
   Set m_fontSelected = iFntC
End Sub
Private Function getTypicalScrollDistance() As Long
Dim tR As RECT
Dim lDist As Long
Dim i As Long
Dim lTabAvg As Long
   If (m_hWndChild.count > 0) Then
      For i = 1 To m_hWndChild.count
         lTabAvg = lTabAvg + (m_tTabR(i).Right - m_tTabR(i).Left)
      Next i
      lTabAvg = lTabAvg \ m_hWndChild.count
      GetWindowRect m_hWndMdiClient, tR
      lDist = (tR.Right - tR.Left)
      If (lDist > lTabAvg * 2) Then
         lDist = lDist - lTabAvg
      End If
      If (lDist < 0) Then
         lDist = lTabAvg \ 2
      End If
      If (lDist < 0) Then
         lDist = 32
      End If
      getTypicalScrollDistance = lDist
   End If
End Function

Public Sub scrollLeft()
Attribute scrollLeft.VB_Description = "Scrolls the tab display to the left as if the user had clicked the left scroll button."
Dim lDist As Long
   ' determine how far to go:
   lDist = getTypicalScrollDistance()
   m_lOffsetX = m_lOffsetX - lDist
   If (m_lOffsetX < 0) Then
      m_lOffsetX = 0
   End If
   ForceRefresh
End Sub
Public Sub scrollRight()
Attribute scrollRight.VB_Description = "Scrolls the tab display to the right as if the user had clicked the right scroll button."
Dim lDist As Long
   ' determine how far to go:
   lDist = getTypicalScrollDistance()
   m_lOffsetX = m_lOffsetX + lDist
   ' We only go as far so the rightmost tab is visible:
   ensureEndTabOffset
   
   If (m_lOffsetX < 0) Then
      m_lOffsetX = 0
   End If
   ForceRefresh
End Sub
Private Function ensureEndTabOffset()
Dim lMaxRight As Long
Dim lSize As Long
Dim tR As RECT
   If (m_hWndChild.count > 0) Then
      GetWindowRect m_hWndMdiClient, tR
      
      lMaxRight = m_tTabR(m_hWndChild.count).Right
      lSize = tR.Right - tR.Left
      If (m_bAllowScroll) Then
         lSize = lSize - m_lButtonSize * 2
      End If
      lSize = lSize - m_lButtonSize
      
      If (lMaxRight > lSize) Then
         If (lMaxRight - m_lOffsetX < lSize) Then
            m_lOffsetX = lMaxRight - lSize + 4
         End If
      ElseIf (lSize > lMaxRight) Then
         If (m_lOffsetX > 0) Then
            m_lOffsetX = 0
         End If
      End If
   End If
End Function

Public Property Get font() As Ifont
Attribute font.VB_Description = "Gets/sets the font used to draw the tab captions."
Dim iFnt As Ifont
Dim iFntC As Ifont
   Set iFnt = m_font
   iFnt.Clone iFntC
   Set font = iFntC
End Property
Public Property Let font(iFnt As Ifont)
   pSetFont iFnt
End Property
Public Property Set font(iFnt As Ifont)
   pSetFont iFnt
End Property
Private Sub pSetFont(iFnt As Ifont)
Dim iFntC As Ifont
   iFnt.Clone iFntC
   Set m_font = iFntC
End Sub
Public Property Get AllowScroll() As Boolean
Attribute AllowScroll.VB_Description = "Gets/sets whether scroll buttons are shown in the MDI Tabs"
   AllowScroll = m_bAllowScroll
End Property
Public Property Let AllowScroll(ByVal value As Boolean)
   m_bAllowScroll = value
   ForceRefresh
End Property

Public Property Get TabAlign() As EMDITabAlign
Attribute TabAlign.VB_Description = "Gets/sets whether the tabs are shown above or below the windows."
   TabAlign = m_eTabAlign
End Property
Public Property Let TabAlign(ByVal value As EMDITabAlign)
   m_eTabAlign = value
   ForceRefresh
End Property

Public Property Get ShowTabs() As Boolean
Attribute ShowTabs.VB_Description = "Gets/sets whether tabs are shown for the MDI window."
   ShowTabs = m_bShowTabs
End Property
Public Property Let ShowTabs(ByVal value As Boolean)
   If Not (m_bShowTabs = value) Then
      m_bShowTabs = value
      ForceRefresh
   End If
End Property

Public Sub ForceRefresh()
Attribute ForceRefresh.VB_Description = "Forces the tab display to refresh.  Call whenever you close or change the caption of a child window."
   ensureEndTabOffset
   SetWindowPos m_hWndMdiClient, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOZORDER Or SWP_NOOWNERZORDER Or SWP_FRAMECHANGED
End Sub

Public Sub Attach(ByVal hWndMdi As Long)
Attribute Attach.VB_Description = "Attaches the MDI Tab component to the specified MDI Window handle."
   Detach
   m_hWndMdiClient = FindWindowEx(hWndMdi, 0, "MDIClient", ByVal 0&)
   If Not (m_hWndMdiClient = 0) Then
      Dim lStyle As Long
      lStyle = GetWindowLong(m_hWndMdiClient, GWL_EXSTYLE)
      lStyle = lStyle And Not WS_EX_CLIENTEDGE
      SetWindowLong m_hWndMdiClient, GWL_EXSTYLE, lStyle
      SetWindowPos m_hWndMdiClient, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOZORDER Or SWP_NOOWNERZORDER Or SWP_FRAMECHANGED
      AttachMessage Me, m_hWndMdiClient, WM_MDIACTIVATE
      AttachMessage Me, m_hWndMdiClient, WM_NCPAINT
      AttachMessage Me, m_hWndMdiClient, WM_NCCALCSIZE
      AttachMessage Me, m_hWndMdiClient, WM_SETCURSOR
      AttachMessage Me, m_hWndMdiClient, WM_LBUTTONDOWN
      AttachMessage Me, m_hWndMdiClient, WM_LBUTTONUP
      AttachMessage Me, m_hWndMdiClient, WM_RBUTTONUP
      AttachMessage Me, m_hWndMdiClient, WM_MOUSEMOVE
      AttachMessage Me, m_hWndMdiClient, WM_DESTROY
   End If
End Sub
Public Sub Detach()
Attribute Detach.VB_Description = "Detaches the MDI Tab component from an MDI Window it has previously been Attached to."
   If (m_hWndMdiClient <> 0) Then
      DetachMessage Me, m_hWndMdiClient, WM_MDIACTIVATE
      DetachMessage Me, m_hWndMdiClient, WM_NCPAINT
      DetachMessage Me, m_hWndMdiClient, WM_NCCALCSIZE
      DetachMessage Me, m_hWndMdiClient, WM_SETCURSOR
      DetachMessage Me, m_hWndMdiClient, WM_LBUTTONDOWN
      DetachMessage Me, m_hWndMdiClient, WM_LBUTTONUP
      DetachMessage Me, m_hWndMdiClient, WM_RBUTTONUP
      DetachMessage Me, m_hWndMdiClient, WM_MOUSEMOVE
      DetachMessage Me, m_hWndMdiClient, WM_DESTROY
      Dim lStyle As Long
      lStyle = GetWindowLong(m_hWndMdiClient, GWL_EXSTYLE)
      lStyle = lStyle Or WS_EX_CLIENTEDGE
      SetWindowLong m_hWndMdiClient, GWL_EXSTYLE, lStyle
   End If
   m_hWndMdiClient = 0
End Sub


Private Sub Class_Initialize()
   m_lTabHeight = 24
   m_lButtonSize = 16
   m_bShowTabs = True
   Dim S As New StdFont
   S.name = "Tahoma"
   S.size = 8.25
   Set font = S
   Set S = New StdFont
   S.name = "Tahoma"
   S.size = 8.25
   S.Bold = True
   Set SelectedFont = S
   Set m_hWndChild = New Collection
   m_bAllowScroll = True
   
   Dim lVer As Long
   lVer = GetVersion()
   m_bIsNt = ((lVer And &H80000000) = 0)
   
   Set m_cMemDC = New pcMemDC
   Set m_tmr = New CTimer

End Sub

Private Sub determineWindows()
   Set m_hWndTempChild = New Collection
   Dim lR As Long
   lR = EnumChildWindows(m_hWndMdiClient, AddressOf enumChildWindowProc, ObjPtr(Me))
   
   Dim hWndNow As Variant
   For Each hWndNow In m_hWndTempChild
      If Not (KeyExists(m_hWndChild, "H" & hWndNow)) Then
         'Debug.Print "Adding: " & hWndNow
         m_hWndChild.Add hWndNow, "H" & hWndNow
      End If
   Next
   Dim i As Long
   For i = m_hWndChild.count To 1 Step -1
      If Not (KeyExists(m_hWndTempChild, "H" & m_hWndChild(i))) Then
         'Debug.Print "Removing: " & m_hWndChild(i)
         m_hWndChild.Remove i
      End If
   Next
   
End Sub

Private Function KeyExists(ByVal c As Collection, ByVal Key As String) As Boolean
   On Error Resume Next
   Dim oItem As Variant
   oItem = c(Key)
   If (Err.number = 0) Then
      KeyExists = True
   End If
End Function

Private Function hitTestButton() As Long
Dim tR As RECT
Dim tP As POINTAPI
   GetCursorPos tP
   ScreenToClient m_hWndMdiClient, tP
   If (m_eTabAlign = TabAlignBottom) Then
   Else
      tP.y = tP.y + m_lTabHeight
   End If
   If (m_bAllowScroll) Then
      If IsLeftButtonEnabled() Then
         getLeftButtonRect tR
         If Not (PtInRect(tR, tP.x, tP.y) = 0) Then
            hitTestButton = 1
            Exit Function
         End If
      End If
      If IsRightButtonEnabled() Then
         getRightButtonRect tR
         If Not (PtInRect(tR, tP.x, tP.y) = 0) Then
            hitTestButton = 2
            Exit Function
         End If
      End If
   End If
   If IsCloseButtonEnabled() Then
      getCloseButtonRect tR
      If Not (PtInRect(tR, tP.x, tP.y) = 0) Then
         hitTestButton = 3
      End If
   End If
End Function

Private Function hitTestTab() As Long
Dim tP As POINTAPI
   GetCursorPos tP
   ScreenToClient m_hWndMdiClient, tP
   tP.x = tP.x + m_lOffsetX
   If (m_eTabAlign = TabAlignBottom) Then
   Else
      tP.y = tP.y + m_lTabHeight
   End If
Dim i As Long
   For i = 1 To m_hWndChild.count
      If Not (PtInRect(m_tTabR(i), tP.x, tP.y) = 0) Then
         If (PtInRect(m_tButtonR, tP.x, tP.y) = 0) Then
            hitTestTab = i
            Exit For
         End If
      End If
   Next i
End Function

Private Sub drawTabs(ByVal lhWnd As Long, ByVal wParam As Long)

   If (m_bShowTabs And (Not (tkMainForm.g_bNoTabRefresh))) Then
      determineWindows
         
      Dim lHDCW As Long
      lHDCW = GetWindowDC(lhWnd)
      
      Dim tR As RECT
      GetWindowRect lhWnd, tR
      OffsetRect tR, -tR.Left, -tR.Top
      m_cMemDC.width = Abs(tR.Right - tR.Left)
      m_cMemDC.Height = Abs(tR.Bottom - tR.Top) + 1
      Dim lHDC As Long
      lHDC = m_cMemDC.hdc
      
      ' Draw all the borders:
      Dim hPenOld As Long
      Dim hPen As Long
      Dim tJunk As POINTAPI
      
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DShadow And &H1F&))
      hPenOld = SelectObject(lHDCW, hPen)
      
      MoveToEx lHDCW, tR.Left, tR.Top, tJunk
      LineTo lHDCW, tR.Right - 1, tR.Top
      LineTo lHDCW, tR.Right - 1, tR.Bottom - 1
      LineTo lHDCW, tR.Left, tR.Bottom - 1
      LineTo lHDCW, tR.Left, tR.Top
      
      SelectObject lHDCW, hPenOld
      DeleteObject hPen
      
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vbButtonFace And &H1F&))
      hPenOld = SelectObject(lHDCW, hPen)
      
      MoveToEx lHDCW, tR.Left + 1, tR.Top + 1, tJunk
      LineTo lHDCW, tR.Left + 1, tR.Bottom - 2
      MoveToEx lHDCW, tR.Right - 2, tR.Top + 1, tJunk
      LineTo lHDCW, tR.Right - 2, tR.Bottom - 2
      If (m_eTabAlign = TabAlignBottom) Then
         MoveToEx lHDCW, tR.Left + 1, tR.Top + 1, tJunk
         LineTo lHDCW, tR.Right - 1, tR.Top + 1
      Else
         MoveToEx lHDCW, tR.Left + 1, tR.Bottom - 2, tJunk
         LineTo lHDCW, tR.Right - 1, tR.Bottom - 2
      End If
      
      SelectObject lHDCW, hPenOld
      hPenOld = SelectObject(lHDC, hPen)
            
      
      Dim tTabR As RECT
      LSet tTabR = tR
      tTabR.Left = tTabR.Left + 1
      tTabR.Right = tTabR.Right - 1
      If (m_eTabAlign = TabAlignBottom) Then
         tTabR.Top = tR.Bottom - m_lTabHeight
         tTabR.Bottom = tTabR.Bottom - 1
         MoveToEx lHDC, tTabR.Left, tTabR.Top, tJunk
         LineTo lHDC, tTabR.Right - 1, tTabR.Top
         MoveToEx lHDC, tTabR.Left, tTabR.Top + 1, tJunk
         LineTo lHDC, tTabR.Right - 1, tTabR.Top + 1
         tTabR.Top = tTabR.Top + 2
      Else
         tTabR.Bottom = tR.Top + m_lTabHeight
         tTabR.Top = tTabR.Top + 1
         MoveToEx lHDC, tTabR.Left, tTabR.Bottom - 1, tJunk
         LineTo lHDC, tTabR.Right, tTabR.Bottom - 1
         MoveToEx lHDC, tTabR.Left, tTabR.Bottom - 2, tJunk
         LineTo lHDC, tTabR.Right, tTabR.Bottom - 2
         tTabR.Bottom = tTabR.Bottom - 2
      End If
      
      SelectObject lHDC, hPenOld
      DeleteObject hPen
      
      ' Fill with generic back colour:
      Dim hBr As Long
      hBr = CreateSolidBrush(BlendColor(vbButtonFace, vbWindowBackground, 80))
      If (m_eTabAlign = TabAlignBottom) Then
         tTabR.Top = tTabR.Top - 2
         tTabR.Bottom = tTabR.Bottom + 1
      End If
      FillRect lHDC, tTabR, hBr
      If (m_eTabAlign = TabAlignBottom) Then
         tTabR.Top = tTabR.Top + 2
         tTabR.Bottom = tTabR.Bottom - 1
      End If
      DeleteObject hBr
      
      ' Now evaluate the positioning of the tabs (calculate
      ' using left to right layout, then when we draw we can
      ' subtract the width of the layout).
      
      ' If the tab is set to have allow scroll then we will draw
      ' in these positions until we get to the scroll point,
      ' otherwise we will need to squeeze them up until they
      ' fit.
      
      If (m_hWndChild.count > 0) Then
      
         Dim hWndSelected As Long
         hWndSelected = SendMessageLong(m_hWndMdiClient, WM_MDIGETACTIVE, 0, 0)
         'Debug.Print "drawTabs: hWndSelected=" & hWndSelected
      
         Dim hFontOld As Long
         hFontOld = SelectObject(lHDC, m_font.hFont)
      
         ReDim m_tTabR(1 To m_hWndChild.count) As RECT
         Dim hWndChild As Variant
         Dim lLen As Long
         Dim sBuf As String
         ReDim sTitle(1 To m_hWndChild.count) As String
         Dim ic As Long
         Dim iSelIndex As Long
         Dim tCalcR As RECT
                  
         For Each hWndChild In m_hWndChild
            ic = ic + 1
            If (ic = 1) Then
               m_tTabR(ic).Left = tTabR.Left + 2
            Else
               m_tTabR(ic).Left = m_tTabR(ic - 1).Right
            End If
            m_tTabR(ic).Right = m_tTabR(ic).Left + 8 ' min tab size
            If (m_eTabAlign = TabAlignBottom) Then
               m_tTabR(ic).Top = tTabR.Top
               m_tTabR(ic).Bottom = tTabR.Bottom - 2
            Else
               m_tTabR(ic).Top = tTabR.Top + 2
               m_tTabR(ic).Bottom = tTabR.Bottom
            End If
            If m_bIsNt Then
               lLen = GetWindowTextLengthW(hWndChild)
            Else
               lLen = GetWindowTextLength(hWndChild)
            End If
            If (lLen > 0) Then
               sBuf = String$(lLen + 1, 0)
               If m_bIsNt Then
                  GetWindowTextW hWndChild, StrPtr(sBuf), lLen
               Else
                  GetWindowText hWndChild, sBuf, lLen + 1
               End If
               lLen = InStr(sBuf, vbNullChar)
               sTitle(ic) = ""
               If lLen > 1 Then
                  If m_bIsNt Then
                     sTitle(ic) = sBuf
                  Else
                     sTitle(ic) = Left$(sBuf, lLen - 1)
                  End If
                  If (hWndChild = hWndSelected) Then
                     iSelIndex = ic
                     SelectObject lHDC, hFontOld
                     hFontOld = SelectObject(lHDC, m_fontSelected.hFont)
                  End If
                  'Debug.Print sTitle(iC)
                  If (m_bIsNt) Then
                     DrawTextW lHDC, StrPtr(sTitle(ic)), -1, tCalcR, DT_CALCRECT Or DT_LEFT Or DT_SINGLELINE
                  Else
                     DrawText lHDC, sTitle(ic), -1, tCalcR, DT_CALCRECT Or DT_LEFT Or DT_SINGLELINE
                  End If
                  m_tTabR(ic).Right = m_tTabR(ic).Left + 16 + tCalcR.Right - tCalcR.Left
                  If (hWndChild = hWndSelected) Then
                     SelectObject lHDC, hFontOld
                     hFontOld = SelectObject(lHDC, m_font.hFont)
                  End If
               End If
            End If
         Next
                  
         Dim bDoesNotFit As Boolean
      
         If Not (m_bAllowScroll) Then
            If (m_tTabR(m_hWndChild.count).Right > (tTabR.Right - m_lButtonSize)) Then
               bDoesNotFit = True
               ' we don't fit, need to squash all the tabs up
               Dim lActualSize As Long
               lActualSize = (tTabR.Right - tTabR.Left - 4 - m_lButtonSize) \ m_hWndChild.count
               m_tTabR(1).Right = m_tTabR(1).Left + lActualSize
               For ic = 2 To m_hWndChild.count
                  m_tTabR(ic).Left = m_tTabR(ic - 1).Right
                  m_tTabR(ic).Right = m_tTabR(ic).Left + lActualSize
               Next ic
            End If
         End If
         
         Dim bChangedWindow As Boolean
         
         If (hWndSelected <> m_hWndSelected) Then
            If (iSelIndex > 0) Then
               m_hWndSelected = hWndSelected
               bChangedWindow = True
               
               ' ensure that a newly selected tab is scrolled into view
               If (m_bAllowScroll) Then
                  If (m_tTabR(iSelIndex).Right - m_lOffsetX) > (tTabR.Right - m_lButtonSize * 3) Then
                     m_lOffsetX = m_tTabR(iSelIndex).Left - 16
                  ElseIf (m_tTabR(iSelIndex).Left - m_lOffsetX < tTabR.Left) Then
                     m_lOffsetX = m_tTabR(iSelIndex).Left - 16
                  End If
                  If (m_lOffsetX <= 16) Then
                     m_lOffsetX = 0
                  End If
               End If
            
            End If
         End If
            
         Dim wFormat As Long
         Dim tTextR As RECT
         wFormat = DT_LEFT Or DT_VCENTER Or DT_SINGLELINE
         If (bDoesNotFit) Then
            wFormat = wFormat Or DT_END_ELLIPSIS
         End If
         SetBkMode lHDC, TRANSPARENT
         
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DShadow And &H1F&))
         hPenOld = SelectObject(lHDC, hPen)
         
         ensureEndTabOffset
   
         ' Actually do the drawing:
         Dim tActualR As RECT
         Dim tFillR As RECT
         Dim bClippedLeft As Boolean
         Dim bClippedRight As Boolean
         Dim lMaxRight As Long
         Dim bTabOffscreen As Boolean

         
         lMaxRight = tTabR.Right - m_lButtonSize
         If (m_bAllowScroll) Then
            lMaxRight = lMaxRight - m_lButtonSize * 2
         End If
         
         bTabOffscreen = True
         For ic = 1 To m_hWndChild.count
            
            LSet tActualR = m_tTabR(ic)
            OffsetRect tActualR, -m_lOffsetX, 0
            
            If (tActualR.Right > lMaxRight) Then
               tActualR.Right = lMaxRight
               bClippedRight = True
            Else
               bClippedRight = False
            End If
            If (tActualR.Left < 0) Then
               bClippedLeft = True
            Else
               bClippedLeft = False
            End If
            If (tActualR.Left > lMaxRight) Then
               ' nothing to do
               Exit For
            End If
         
            If (ic = iSelIndex) Then
               If (tActualR.Right < 0) Or (tActualR.Left > lMaxRight) Then
                  bTabOffscreen = True
               Else
                  bTabOffscreen = False
               End If
            
               SelectObject lHDC, hFontOld
               hFontOld = SelectObject(lHDC, m_fontSelected.hFont)
               hBr = GetSysColorBrush(vbButtonFace And &H1F&)
               LSet tFillR = tActualR
               If bClippedLeft Then
                  'Debug.Print tFillR.Left
                  tFillR.Left = 1
               End If
               FillRect lHDC, tFillR, hBr
               DeleteObject hBr
                  
               SelectObject lHDC, hPenOld
               DeleteObject hPen
               
               ' replace pen:
               If (m_eTabAlign = TabAlignBottom) Then
                  ' darkest 3d pen:
                  hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
               Else
                  ' lightest 3d pen:
                  hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
               End If
               hPenOld = SelectObject(lHDC, hPen)
               
               If (m_eTabAlign = TabAlignBottom) Then
                  MoveToEx lHDC, tTabR.Left, tActualR.Top, tJunk
                  LineTo lHDC, tActualR.Left, tActualR.Top
                  MoveToEx lHDC, tActualR.Left, tActualR.Bottom - 1, tJunk
                  LineTo lHDC, tActualR.Right - 1, tActualR.Bottom - 1
                  If Not (bClippedRight) Then
                     LineTo lHDC, tActualR.Right - 1, tActualR.Top
                  End If
               Else
                  MoveToEx lHDC, tTabR.Left, tActualR.Bottom - 1, tJunk
                  LineTo lHDC, tActualR.Left, tActualR.Bottom - 1
                  LineTo lHDC, tActualR.Left, tActualR.Top
                  LineTo lHDC, tActualR.Right - 1, tActualR.Top
               End If
               
               If Not bClippedRight Then
                  If (m_eTabAlign = TabAlignBottom) Then
                     MoveToEx lHDC, tActualR.Right - 1, tActualR.Top, tJunk
                     LineTo lHDC, tTabR.Right - 1, tActualR.Top
                  Else
                     MoveToEx lHDC, tActualR.Right - 1, tActualR.Bottom - 1, tJunk
                     LineTo lHDC, tTabR.Right - 1, tActualR.Bottom - 1
                  End If
               End If
               
               SelectObject lHDC, hPenOld
               DeleteObject hPen
               
               If (m_eTabAlign = TabAlignBottom) Then
                  ' lightest 3d pen:
                  hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
                  hPenOld = SelectObject(lHDC, hPen)
                  
                  MoveToEx lHDC, tActualR.Left, tActualR.Top, tJunk
                  LineTo lHDC, tActualR.Left, tActualR.Bottom - 1
                  
                  SelectObject lHDC, hPenOld
                  DeleteObject hPen
               Else
                  If Not bClippedRight Then
                     ' darkest 3d pen:
                     hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
                     hPenOld = SelectObject(lHDC, hPen)
                     
                     MoveToEx lHDC, tActualR.Right - 1, tActualR.Top + 1, tJunk
                     LineTo lHDC, tActualR.Right - 1, tActualR.Bottom
                     
                     SelectObject lHDC, hPenOld
                     DeleteObject hPen
                  End If
               End If
               
               hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DShadow And &H1F&))
               hPenOld = SelectObject(lHDC, hPen)
               
            ElseIf Not ((ic + 1) = iSelIndex) Then
            
               If Not bClippedRight Then
                  MoveToEx lHDC, tActualR.Right - 1, tActualR.Top + 3, tJunk
                  LineTo lHDC, tActualR.Right - 1, tActualR.Bottom - 2
               End If
               
            End If
            
            LSet tTextR = tActualR
            tTextR.Left = tTextR.Left + 8
            tTextR.Right = tTextR.Right - 8
            If (ic = iSelIndex) Then
               SetTextColor lHDC, GetSysColor(vbWindowText And &H1F&)
            Else
               SetTextColor lHDC, GetSysColor(vb3DDKShadow And &H1F&)
            End If
            If m_bIsNt Then
               DrawTextW lHDC, StrPtr(sTitle(ic)), -1, tTextR, wFormat
            Else
               DrawText lHDC, sTitle(ic), -1, tTextR, wFormat
            End If
            If (ic = iSelIndex) Then
               SelectObject lHDC, hFontOld
               hFontOld = SelectObject(lHDC, m_font.hFont)
            End If
            
         Next ic
         
         ' Clear up
         SelectObject lHDC, hPenOld
         DeleteObject hPen
         
         If (m_eTabAlign = TabAlignBottom) Then
            ' darkest 3d pen:
            hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
            hPenOld = SelectObject(lHDC, hPen)
         Else
            ' lightest 3d pen:
            hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
            hPenOld = SelectObject(lHDC, hPen)
         End If
         
         If (bTabOffscreen) Then
            If (m_eTabAlign = TabAlignBottom) Then
               MoveToEx lHDC, tTabR.Left, tTabR.Top, tJunk
               LineTo lHDC, tTabR.Right, tTabR.Top
            Else
               MoveToEx lHDC, tTabR.Left, tTabR.Bottom - 1, tJunk
               LineTo lHDC, tTabR.Right, tTabR.Bottom - 1
            End If
         End If
         
         ' The buttons always have a line above them:
         If (tTabR.Right > lMaxRight) Then
            If (m_eTabAlign = TabAlignBottom) Then
               MoveToEx lHDC, lMaxRight, tTabR.Top, tJunk
               LineTo lHDC, tTabR.Right, tTabR.Top
            Else
               MoveToEx lHDC, lMaxRight, tTabR.Bottom - 1, tJunk
               LineTo lHDC, tTabR.Right, tTabR.Bottom - 1
            End If
         End If
         
         SelectObject lHDC, hPenOld
         DeleteObject hPen

         
         SelectObject lHDC, hFontOld
         
         ' Now draw the buttons
         LSet m_tButtonR = tTabR
         m_tButtonR.Left = lMaxRight
         OffsetRect m_tButtonR, 0, 3
         drawButtons lHDC
            
      End If
      
      If (m_eTabAlign = TabAlignBottom) Then
         BitBlt lHDCW, tTabR.Left, tTabR.Top - 2, tTabR.Right - tTabR.Left, tTabR.Bottom - tTabR.Top + 2, lHDC, tTabR.Left, tTabR.Top - 1, vbSrcCopy
      Else
         BitBlt lHDCW, tTabR.Left, tTabR.Top, tTabR.Right - tTabR.Left, tTabR.Bottom - tTabR.Top + 2, lHDC, tTabR.Left, tTabR.Top, vbSrcCopy
      End If
      ReleaseDC lhWnd, lHDCW
   
      If (m_hWndSelected <> 0) And (m_hWndChild.count = 0) Then
         bChangedWindow = True
         m_hWndSelected = 0
      End If
   
      If (bChangedWindow) Then
         RaiseEvent WindowChanged(m_hWndSelected)
      End If
   
   End If
   
End Sub

Private Function IsLeftButtonEnabled() As Boolean
   IsLeftButtonEnabled = (m_lOffsetX > 0)
End Function
Private Function IsRightButtonEnabled() As Boolean
   If (m_hWndChild.count > 0) Then
      IsRightButtonEnabled = ((m_tTabR(m_hWndChild.count).Right - m_lOffsetX) > m_tButtonR.Left)
   End If
End Function
Private Function IsCloseButtonEnabled() As Boolean
   IsCloseButtonEnabled = (m_hWndChild.count > 0)
End Function
Private Sub getLeftButtonRect(tRLeft As RECT)
   LSet tRLeft = m_tButtonR
   tRLeft.Top = tRLeft.Top '+ ((m_tButtonR.Bottom - m_tButtonR.Top) - m_lButtonSize) \ 2
   tRLeft.Bottom = tRLeft.Top + m_lButtonSize
   tRLeft.Right = tRLeft.Left + m_lButtonSize
End Sub
Private Sub getRightButtonRect(tRRight As RECT)
   LSet tRRight = m_tButtonR
   tRRight.Top = tRRight.Top '+ ((m_tButtonR.Bottom - m_tButtonR.Top) - m_lButtonSize) \ 2
   tRRight.Bottom = tRRight.Top + m_lButtonSize
   tRRight.Left = tRRight.Left + m_lButtonSize
   tRRight.Right = tRRight.Left + m_lButtonSize
End Sub
Private Sub getCloseButtonRect(tRClose As RECT)
   LSet tRClose = m_tButtonR
   tRClose.Top = tRClose.Top '+ ((m_tButtonR.Bottom - m_tButtonR.Top) - m_lButtonSize) \ 2
   tRClose.Bottom = tRClose.Top + m_lButtonSize
   If (m_bAllowScroll) Then
      OffsetRect tRClose, m_lButtonSize * 2, 0
      tRClose.Right = tRClose.Left + m_lButtonSize
   End If
End Sub
Private Sub drawOneButton( _
      ByVal lHDC As Long, _
      ByVal lGlyph As Long _
   )
Dim tR As RECT
Dim bEnabled As Boolean
Dim bPressed As Boolean
   Select Case lGlyph
   Case 1
      getLeftButtonRect tR
      bEnabled = IsLeftButtonEnabled()
   Case 2
      getRightButtonRect tR
      bEnabled = IsRightButtonEnabled()
   Case 3
      bEnabled = IsCloseButtonEnabled()
      getCloseButtonRect tR
   End Select
   bPressed = ((m_iPressButton = lGlyph) And (m_iTrackButton = lGlyph))

Dim tTextR As RECT
Dim hPen As Long
Dim hPenOld As Long
Dim tJunk As POINTAPI

   LSet tTextR = tR
   InflateRect tTextR, -2, -2
   
   If bEnabled Then
      If bPressed Then
         
         ' draw down border:
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
         hPenOld = SelectObject(lHDC, hPen)
         MoveToEx lHDC, tR.Left, tR.Bottom - 1, tJunk
         LineTo lHDC, tR.Left, tR.Top
         LineTo lHDC, tR.Right - 1, tR.Top
         SelectObject lHDC, hPenOld
         DeleteObject hPen
         
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
         hPenOld = SelectObject(lHDC, hPen)
         MoveToEx lHDC, tR.Right - 1, tR.Top + 1, tJunk
         LineTo lHDC, tR.Right - 1, tR.Bottom - 1
         LineTo lHDC, tR.Left + 1, tR.Bottom - 1
         SelectObject lHDC, hPenOld
         DeleteObject hPen
         
         ' Move text down
         OffsetRect tTextR, 1, 1
         
      ElseIf (m_iTrackButton = lGlyph) Then
         
         ' draw up border:
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
         hPenOld = SelectObject(lHDC, hPen)
         MoveToEx lHDC, tR.Left, tR.Bottom - 1, tJunk
         LineTo lHDC, tR.Left, tR.Top
         LineTo lHDC, tR.Right - 1, tR.Top
         SelectObject lHDC, hPenOld
         DeleteObject hPen
         
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
         hPenOld = SelectObject(lHDC, hPen)
         MoveToEx lHDC, tR.Right - 1, tR.Top + 1, tJunk
         LineTo lHDC, tR.Right - 1, tR.Bottom - 1
         LineTo lHDC, tR.Left + 1, tR.Bottom - 1
         SelectObject lHDC, hPenOld
         DeleteObject hPen
         
      End If
   End If
   
   Dim sFont As New StdFont
   sFont.name = "Marlett"
   If (lGlyph = 3) Then
      sFont.size = 8
   Else
      sFont.size = 10
   End If
   Dim Ifont As Ifont
   Set Ifont = sFont
   Dim hFontOld As Long
   
   hFontOld = SelectObject(lHDC, Ifont.hFont)
   If (bEnabled) Then
      SetTextColor lHDC, GetSysColor(vb3DDKShadow And &H1F&)
   Else
      SetTextColor lHDC, BlendColor(vbButtonFace, vb3DDKShadow, 192)
   End If
   ' Draw the glyph:
   Select Case lGlyph
   Case 1 ' left
      DrawText lHDC, "3", -1, tTextR, DT_CENTER Or DT_VCENTER
   Case 2 ' right
      DrawText lHDC, "4", -1, tTextR, DT_CENTER Or DT_VCENTER
   Case 3 ' close
      DrawText lHDC, "r", -1, tTextR, DT_CENTER Or DT_VCENTER
   End Select
   
   SelectObject lHDC, hFontOld
   
End Sub

Private Sub drawButtons(ByVal lHDC As Long)
Dim tR As RECT

   If (m_bAllowScroll) Then
      ' Left & Right Buttons
      drawOneButton lHDC, 1
      
      drawOneButton lHDC, 2
   
   End If
   
   ' Close Button
   drawOneButton lHDC, 3
   
End Sub

Private Sub Class_Terminate()
   Detach
   Set m_cMemDC = Nothing
   m_tmr.Interval = 0
   Set m_tmr = Nothing
End Sub

Private Property Let ISubclass_MsgResponse(ByVal RHS As EMsgResponse)
   '
End Property

Private Property Get ISubclass_MsgResponse() As EMsgResponse
   '
   Select Case CurrentMessage
   Case WM_NCCALCSIZE, WM_SETCURSOR, WM_NCPAINT, WM_MDIACTIVATE
      ISubclass_MsgResponse = emrConsume
   Case WM_LBUTTONUP, WM_RBUTTONUP, WM_LBUTTONDOWN, WM_MOUSEMOVE
      ISubclass_MsgResponse = emrConsume
   Case WM_DESTROY
      ISubclass_MsgResponse = emrPostProcess
   End Select
   '
End Property

Private Function ISubclass_WindowProc(ByVal hwnd As Long, ByVal iMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   Dim tP As POINTAPI
   
   '
   Select Case iMsg
   Case WM_MDIACTIVATE
      'Debug.Print "WM_MDIACTIVATE"
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      ForceRefresh
      
   Case WM_NCCALCSIZE
      'Debug.Print "WM_NCCALCSIZE"
      Dim tNCR As NCCALCSIZE_PARAMS
      Dim tWP As WINDOWPOS
      
      If wParam <> 0 Then
         CopyMemory tNCR, ByVal lParam, Len(tNCR)
         CopyMemory tWP, ByVal tNCR.lppos, Len(tWP)
         With tNCR.rgrc(0)
            .Left = tWP.x
            .Top = tWP.y
            .Right = tWP.x + tWP.cx
            .Bottom = tWP.y + tWP.cy
         End With
         If (m_bShowTabs) Then
            tNCR.rgrc(0).Left = tNCR.rgrc(0).Left + 2
            tNCR.rgrc(0).Right = tNCR.rgrc(0).Right - 2
            If (m_eTabAlign = TabAlignBottom) Then
               tNCR.rgrc(0).Top = tNCR.rgrc(0).Top + 2
               tNCR.rgrc(0).Bottom = tNCR.rgrc(0).Bottom - m_lTabHeight
            Else
               tNCR.rgrc(0).Top = tNCR.rgrc(0).Top + m_lTabHeight
               tNCR.rgrc(0).Bottom = tNCR.rgrc(0).Bottom - 2
            End If
         End If
         LSet tNCR.rgrc(1) = tNCR.rgrc(0)
         CopyMemory ByVal lParam, tNCR, Len(tNCR)
         ISubclass_WindowProc = WVR_VALIDRECTS
      Else
         ' lParam points to a rectangle
         ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      End If
      
   Case WM_NCPAINT
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      drawTabs hwnd, wParam
   
   Case WM_MOUSEMOVE
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      
      If (m_iDraggingTab > 0) Then
         GetCursorPos tP
         If (m_bJustReplaced) Then
            If m_iDraggingTab <> hitTestTab() Then
               If Abs(tP.x - m_tJustReplacedPoint.x) > (m_tTabR(m_iDraggingTab).Right - m_tTabR(m_iDraggingTab).Left) / 2 Then
                  m_bJustReplaced = False
               Else
                  Exit Function
               End If
            Else
               m_bJustReplaced = False
            End If
         End If
         
         ScreenToClient m_hWndMdiClient, tP
         tP.x = tP.x + m_lOffsetX
         If (m_eTabAlign = TabAlignTop) Then
            tP.y = tP.y - m_lTabHeight
         End If
         If (tP.y > m_tTabR(1).Top - 64) And (tP.y < m_tTabR(1).Bottom + 64) Then
            ' potential to place:
            Dim i As Long
            Dim replaceCandidate As Long
            If (tP.x < m_tTabR(1).Left) Then
               ' replace the first one
               replaceCandidate = 1
            ElseIf (tP.x > m_tTabR(m_hWndChild.count).Right) Then
               ' replace the last one:
               replaceCandidate = m_hWndChild.count
            Else
               For i = 1 To m_hWndChild.count
                  If (tP.x >= m_tTabR(i).Left) And (tP.x <= m_tTabR(i).Right) Then
                     ' replacement a central item:
                     replaceCandidate = i
                     Exit For
                  End If
               Next i
            End If
            If (replaceCandidate > 0) Then
               If (replaceCandidate <> m_iDraggingTab) Then
                  'Debug.Print "Replacement Candidate:", replaceCandidate
                  replaceWithCandidate m_iDraggingTab, replaceCandidate
               End If
            End If
         End If
      End If
      
      If (m_iTrackButton > 0) Then
         i = hitTestButton()
         If Not (i = m_iTrackButton) Then
            If (i = 0) Then
               If (m_iPressButton = 0) Then
                  ' end of capture
                  ReleaseCapture
               End If
               m_iTrackButton = 0
               ForceRefresh
            Else
               ' change of capture
               m_iTrackButton = i
               ForceRefresh
            End If
         End If
      End If
   
   Case WM_LBUTTONDOWN
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      i = hitTestButton()
      If (i > 0) Then
         SetCapture m_hWndMdiClient
         m_iTrackButton = i
         m_iPressButton = i
         Select Case i
         Case 1
            ' left scroll:
            If IsLeftButtonEnabled Then
               scrollLeft
               m_tmr.Interval = 150
            End If
         Case 2
            ' right scroll:
            If IsRightButtonEnabled Then
               scrollRight
               m_tmr.Interval = 150
            End If
         End Select
         ForceRefresh
      End If

   Case WM_LBUTTONUP, WM_RBUTTONUP
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      ReleaseCapture
      m_tmr.Interval = 0
      
      If (m_iDraggingTab > 0) Then
         i = hitTestTab()

        ' Check for double click
        Static lngLastButton As Long, lngLastTime As Double
        If (i = lngLastButton) Then
            If ((timer() - lngLastTime) < 0.3) Then
                Dim hWndChildInQuestion As Long, frm As Form
                hWndChildInQuestion = m_hWndChild(lngLastButton)
                For Each frm In Forms
                    If (frm.hwnd = hWndChildInQuestion) Then
                        frm.WindowState = IIf(frm.WindowState <> 0, 0, 2)
                        Exit For
                    End If
                Next frm
            End If
        End If
        lngLastButton = i
        lngLastTime = timer()

         'If (i <> m_iDraggingTab) Then
            ' We've dragged somewhere else:
            'Debug.Print "Drag:", m_iDraggingTab, i
         'End If
         
         ' Determine which hWnd we've clicked:
         Dim eButton As MouseButtonConstants
         If (iMsg = WM_LBUTTONUP) Then
            eButton = vbLeftButton
         ElseIf (iMsg = WM_RBUTTONUP) Then
            eButton = vbRightButton
         End If
         If (SendMessageLong(m_hWndMdiClient, WM_MDIGETACTIVE, 0, 0) <> m_hWndChild(m_iDraggingTab)) Then
            SendMessageLong m_hWndMdiClient, WM_MDIACTIVATE, m_hWndChild(m_iDraggingTab), 0
         End If
         ReleaseCapture
         GetCursorPos tP
         ScreenToClient m_hWndMdiClient, tP
         RaiseEvent TabClick(eButton, m_hWndChild(m_iDraggingTab), tP.x, tP.y)
         m_iDraggingTab = 0
      
      End If
            
      If (m_iPressButton > 0) Then
         i = hitTestButton()
         If (i = m_iPressButton) Then
            m_iTrackButton = 0
            m_iPressButton = 0
            ReleaseCapture
            ForceRefresh
            Select Case i
            Case 1
               ' left scroll:
               If IsLeftButtonEnabled Then
                  'ScrollLeft
               End If
            Case 2
               ' right scroll:
               If IsRightButtonEnabled Then
                  'ScrollRight
               End If
            Case 3
               ' close window:
               RaiseEvent CloseWindow(m_hWndSelected)
            End Select
         Else
            ' not a press:
            m_iTrackButton = 0
            m_iPressButton = 0
            ReleaseCapture
            ForceRefresh
         End If
      End If
   
   Case WM_SETCURSOR
      
      ISubclass_WindowProc = CallOldWindowProc(hwnd, iMsg, wParam, lParam)
      If (lParam And &HFFFF&) = HTNOWHERE Then ' loword = Hittest code
         
         Dim lMsg As Long
         
         lMsg = (lParam And &H7FFF0000) \ &H10000 ' hiword = mouse message
         Select Case lMsg

         Case WM_LBUTTONDOWN
            ' in drag
            i = hitTestTab()
            If (i > 0) Then
               m_iDraggingTab = i
               m_bJustReplaced = True
               GetCursorPos m_tJustReplacedPoint
               
               SetCapture m_hWndMdiClient
               If (SendMessageLong(m_hWndMdiClient, WM_MDIGETACTIVE, 0, 0) <> m_hWndChild(m_iDraggingTab)) Then
                  SendMessageLong m_hWndMdiClient, WM_MDIACTIVATE, m_hWndChild(m_iDraggingTab), 0
               End If
               ForceRefresh
            Else
               i = hitTestButton()
               If (i > 0) Then
                  'Debug.Print "Pressing button:"; i
                  m_iPressButton = i
                  If (m_iTrackButton = 0) Then
                     SetCapture m_hWndMdiClient
                  End If
                  m_iTrackButton = m_iPressButton
                  ForceRefresh
               End If
            End If
            
         Case WM_LBUTTONUP, WM_RBUTTONUP
            
            If (m_iDraggingTab = 0) Then
            
               If (lMsg = WM_LBUTTONUP) Then
                  eButton = vbLeftButton
               ElseIf (lMsg = WM_RBUTTONUP) Then
                  eButton = vbRightButton
               End If
            
               GetCursorPos tP
               'Debug.Print "WM_SETCURSOR:", GetParent(m_hWndMdiClient), tP.x, tP.y
               ScreenToClient m_hWndMdiClient, tP
               'Debug.Print "WM_SETCURSOR:", GetParent(m_hWndMdiClient), tP.x, tP.y
               If (eButton = vbRightButton) Then
                  i = hitTestTab()
                  If (i > 0) Then
                     If (SendMessageLong(m_hWndMdiClient, WM_MDIGETACTIVE, 0, 0) <> m_hWndChild(i)) Then
                        SendMessageLong m_hWndMdiClient, WM_MDIACTIVATE, m_hWndChild(i), 0
                     End If
                     RaiseEvent TabClick(eButton, m_hWndChild(i), tP.x, tP.y)
                  Else
                     RaiseEvent TabBarClick(eButton, tP.x, tP.y)
                  End If
               Else
                  RaiseEvent TabBarClick(eButton, tP.x, tP.y)
               End If
            
            End If
            
            
         Case WM_MOUSEMOVE
            ' We get this if we're not currently tracking:
            i = hitTestButton()
            If Not (i = m_iTrackButton) Then
               ' change of capture:
               If (m_iTrackButton = 0) Then
                  SetCapture m_hWndMdiClient
               End If
               m_iTrackButton = i
               'Debug.Print "TRACK BUTTON"
               ForceRefresh
            End If
            
         End Select
         
      End If
      
   Case WM_DESTROY
      Detach
   End Select
   '
End Function

Private Function replaceWithCandidate(ByVal iDragging As Long, ByVal iCandidate As Long)
   Dim tCol As New Collection
   Dim i As Long
   
   If (iCandidate < iDragging) Then
      For i = 1 To iCandidate - 1
         If (i <> iDragging) Then
            tCol.Add m_hWndChild(i), "H" & m_hWndChild(i)
         End If
      Next i
      tCol.Add m_hWndChild(iDragging), "H" & m_hWndChild(iDragging)
      m_iDraggingTab = tCol.count
      For i = iCandidate To m_hWndChild.count
         If (i <> iDragging) Then
            tCol.Add m_hWndChild(i), "H" & m_hWndChild(i)
         End If
      Next i
      Set m_hWndChild = tCol
      ForceRefresh
      'Debug.Print "Replaced:"; iDragging; " with"; iCandidate; " Dragging now at:"; m_iDraggingTab
   Else
      For i = 1 To iCandidate
         If (i <> iDragging) Then
            tCol.Add m_hWndChild(i), "H" & m_hWndChild(i)
         End If
      Next i
      tCol.Add m_hWndChild(iDragging), "H" & m_hWndChild(iDragging)
      m_iDraggingTab = tCol.count
      For i = iCandidate + 1 To m_hWndChild.count
         If (i <> iDragging) Then
            tCol.Add m_hWndChild(i), "H" & m_hWndChild(i)
         End If
      Next i
      Set m_hWndChild = tCol
      ForceRefresh
      'Debug.Print "Replaced:"; iDragging; " with"; iCandidate; " Dragging now at:"; m_iDraggingTab
      
   End If
   
   m_bJustReplaced = True
   GetCursorPos m_tJustReplacedPoint
   
End Function

Private Function TranslateColor(ByVal oClr As OLE_COLOR, _
                        Optional hPal As Long = 0) As Long
    ' Convert Automation color to Windows color
    If OleTranslateColor(oClr, hPal, TranslateColor) Then
        TranslateColor = CLR_INVALID
    End If
End Function

Private Property Get BlendColor( _
      ByVal oColorFrom As OLE_COLOR, _
      ByVal oColorTo As OLE_COLOR, _
      Optional ByVal alpha As Long = 128 _
   ) As Long
Dim lCFrom As Long
Dim lCTo As Long
   lCFrom = TranslateColor(oColorFrom)
   lCTo = TranslateColor(oColorTo)
Dim lSrcR As Long
Dim lSrcG As Long
Dim lSrcB As Long
Dim lDstR As Long
Dim lDstG As Long
Dim lDstB As Long
   lSrcR = lCFrom And &HFF
   lSrcG = (lCFrom And &HFF00&) \ &H100&
   lSrcB = (lCFrom And &HFF0000) \ &H10000
   lDstR = lCTo And &HFF
   lDstG = (lCTo And &HFF00&) \ &H100&
   lDstB = (lCTo And &HFF0000) \ &H10000
     
   
   BlendColor = RGB( _
      ((lSrcR * alpha) / 255) + ((lDstR * (255 - alpha)) / 255), _
      ((lSrcG * alpha) / 255) + ((lDstG * (255 - alpha)) / 255), _
      ((lSrcB * alpha) / 255) + ((lDstB * (255 - alpha)) / 255) _
      )
      
End Property

Private Property Get NoPalette(Optional ByVal bForce As Boolean = False) As Boolean
Static bOnce As Boolean
Static bNoPalette As Boolean
Dim lHDC As Long
Dim lBits As Long
   If (bForce) Then
      bOnce = False
   End If
   If Not (bOnce) Then
      lHDC = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
      If (lHDC <> 0) Then
         lBits = GetDeviceCaps(lHDC, BITSPIXEL)
         If (lBits <> 0) Then
            bOnce = True
         End If
         bNoPalette = (lBits > 8)
         DeleteDC lHDC
      End If
   End If
   NoPalette = bNoPalette
End Property


Private Sub m_tmr_ThatTime()
   '
   If (m_iTrackButton = 1) And (IsLeftButtonEnabled) Then
      scrollLeft
      ForceRefresh
   ElseIf (m_iTrackButton = 2) And (IsRightButtonEnabled) Then
      scrollRight
      ForceRefresh
   End If

   '
End Sub
