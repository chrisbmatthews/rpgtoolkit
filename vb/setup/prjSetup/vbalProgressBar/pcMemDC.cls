VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "pcMemDC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


' cMemDC - flicker free drawing

Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function CreateDC Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, ByVal lpDeviceName As String, ByVal lpOutput As String, lpInitData As Any) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long

Private m_hDC As Long
Private m_hBmp As Long
Private m_hBmpOld As Long
Private m_lWidth As Long
Private m_lHeight As Long

Public Property Get hdc(Width As Long, Height As Long) As Long
   If m_hDC = 0 Then
      pCreate Width, Height
   Else
      If Width > m_lWidth Or Height > m_lHeight Then
         pCreate Width, Height
      End If
   End If
   hdc = m_hDC
End Property
Public Sub Draw( _
      ByVal hdc As Long, _
      Optional ByVal xSrc As Long = 0, Optional ByVal ySrc As Long = 0, _
      Optional ByVal WidthSrc As Long = 0, Optional ByVal HeightSrc As Long = 0, _
      Optional ByVal xDst As Long = 0, Optional ByVal yDst As Long = 0 _
   )
   If WidthSrc <= 0 Then WidthSrc = m_lWidth
   If HeightSrc <= 0 Then HeightSrc = m_lHeight
   BitBlt hdc, xDst, yDst, WidthSrc, HeightSrc, m_hDC, xSrc, ySrc, vbSrcCopy
End Sub

Private Sub pCreate(ByVal Width As Long, ByVal Height As Long)
Dim lhDCC As Long
   pDestroy
   lhDCC = CreateDC("DISPLAY", "", "", ByVal 0&)
   If Not (lhDCC = 0) Then
      m_hDC = CreateCompatibleDC(lhDCC)
      If Not (m_hDC = 0) Then
         m_hBmp = CreateCompatibleBitmap(lhDCC, Width, Height)
         If Not (m_hBmp = 0) Then
            m_hBmpOld = SelectObject(m_hDC, m_hBmp)
            If Not (m_hBmpOld = 0) Then
               m_lWidth = Width
               m_lHeight = Height
               DeleteDC lhDCC
               Exit Sub
            End If
         End If
      End If
      DeleteDC lhDCC
      pDestroy
   End If
End Sub
Private Sub pDestroy()
   If Not m_hBmpOld = 0 Then
      SelectObject m_hDC, m_hBmpOld
      m_hBmpOld = 0
   End If
   If Not m_hBmp = 0 Then
      DeleteObject m_hBmp
      m_hBmp = 0
   End If
   If Not m_hDC = 0 Then
      DeleteDC m_hDC
      m_hDC = 0
   End If
   m_lWidth = 0
   m_lHeight = 0
End Sub

Private Sub Class_Terminate()
   pDestroy
End Sub


