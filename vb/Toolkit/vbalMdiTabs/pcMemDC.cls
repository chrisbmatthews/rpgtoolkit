VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "pcMemDC"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


' ======================================================================================
' Name:     cMemDC.cls
' Author:   Steve McMahon (steve@vbaccelerator.com)
' Date:     20 October 1999
'
' Requires: -
'
' Copyright © 1999 Steve McMahon for vbAccelerator
' --------------------------------------------------------------------------------------
' Visit vbAccelerator - advanced free source code for VB programmers
'    http://vbaccelerator.com
' --------------------------------------------------------------------------------------
'
' Memory DC for flicker free drawing.
'
' FREE SOURCE CODE - ENJOY!
' Do not sell this code.  Credit vbAccelerator.
' ======================================================================================
Private Declare Function CreateDCAsNull Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, lpDeviceName As Any, lpOutput As Any, lpInitData As Any) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Long, ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Type BITMAP '24 bytes
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type
Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long

Private m_hDC As Long
Private m_hBmpOld As Long
Private m_hBmp As Long
Private m_lWidth As Long
Private m_lheight As Long

Public Sub CreateFromPicture(sPic As IPicture)
Dim tB As BITMAP
Dim lhDCC As Long, lHDC As Long
Dim lhBmpOld As Long
   GetObjectAPI sPic.Handle, Len(tB), tB
   Width = tB.bmWidth
   Height = tB.bmHeight
   lhDCC = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
   lHDC = CreateCompatibleDC(lhDCC)
   lhBmpOld = SelectObject(lHDC, sPic.Handle)
   BitBlt hdc, 0, 0, tB.bmWidth, tB.bmHeight, lHDC, 0, 0, vbSrcCopy
   SelectObject lHDC, lhBmpOld
   DeleteDC lHDC
   DeleteDC lhDCC
End Sub

Public Property Get hdc() As Long
   hdc = m_hDC
End Property
Public Property Let Width(ByVal lW As Long)
   If lW > m_lWidth Then
      pCreate lW, m_lheight
   End If
End Property
Public Property Get Width() As Long
   Width = m_lWidth
End Property
Public Property Let Height(ByVal lH As Long)
   If lH > m_lheight Then
      pCreate m_lWidth, lH
   End If
End Property
Public Property Get Height() As Long
   Height = m_lheight
End Property
Private Sub pCreate(ByVal lW As Long, ByVal lH As Long)
Dim lHDC As Long
   pDestroy
   lHDC = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
   m_hDC = CreateCompatibleDC(lHDC)
   m_hBmp = CreateCompatibleBitmap(lHDC, lW, lH)
   m_hBmpOld = SelectObject(m_hDC, m_hBmp)
   If m_hBmpOld = 0 Then
      pDestroy
   Else
      m_lWidth = lW
      m_lheight = lH
   End If
   DeleteDC lHDC
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
   m_lWidth = 0
   m_lheight = 0
   If Not m_hDC = 0 Then
      DeleteDC m_hDC
      m_hDC = 0
   End If
End Sub

Private Sub Class_Terminate()
   pDestroy
End Sub





