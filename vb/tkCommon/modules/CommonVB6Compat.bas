Attribute VB_Name = "CommonVB6Compat"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'visual basic 6 compatibility functions
'for working under the .NET framework
Option Explicit

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What needs to be done
' + Re-write these procedures using GDI
'
'=======================================================

'Constants for use with BitBlt()
Global Const SRCCOPY = &HCC0020 ' (DWORD) dest = source
Global Const SRCPAINT = &HEE0086        ' (DWORD) dest = source OR dest
Global Const SRCAND = &H8800C6  ' (DWORD) dest = source AND dest
Global Const SRCINVERT = &H660046       ' (DWORD) dest = source XOR dest
Global Const SRCERASE = &H440328        ' (DWORD) dest = source AND (NOT dest )
Global Const NOTSRCCOPY = &H330008      ' (DWORD) dest = (NOT source)
Global Const NOTSRCERASE = &H1100A6     ' (DWORD) dest = (NOT src) AND (NOT dest)
Global Const MERGECOPY = &HC000CA       ' (DWORD) dest = (source AND pattern)
Global Const MERGEPAINT = &HBB0226      ' (DWORD) dest = (NOT source) OR dest
Global Const PATCOPY = &HF00021 ' (DWORD) dest = pattern
Global Const PATPAINT = &HFB0A09        ' (DWORD) dest = DPSnoo
Global Const PATINVERT = &H5A0049       ' (DWORD) dest = pattern XOR dest
Global Const DSTINVERT = &H550009       ' (DWORD) dest = (NOT dest)
Global Const BLACKNESS = &H42&  ' (DWORD) dest = BLACK
Global Const WHITENESS = &HFF0062       ' (DWORD) dest = WHITE

Declare Function BitBlt Lib "gdi32" (ByVal hDestDC&, ByVal X&, ByVal Y&, ByVal nWidth&, ByVal nHeight&, ByVal hSrcDC&, ByVal xsrc&, ByVal ysrc&, ByVal dwrop&) As Long
Declare Function SetPixelV& Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long)
Public Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function FillRgn Lib "gdi32" (ByVal hdc As Long, ByVal hRgn As Long, ByVal hBrush As Long) As Long
Public Declare Function CreateRectRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Public Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Public Declare Function CreateEllipticRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Public Declare Function PaintRgn Lib "gdi32" (ByVal hdc As Long, ByVal hRgn As Long) As Long
'Declare Function SetPixel& Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal crcolor As Long)

Declare Function StretchBlt& Lib "gdi32" _
    (ByVal hdc&, ByVal X&, ByVal Y&, ByVal nWidth&, ByVal nHeight&, _
     ByVal hSrcDC&, ByVal xsrc&, ByVal ysrc&, ByVal SrcWidth&, ByVal SrcHeight&, _
     ByVal dwrop&)

Public Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long

Public Type POINTAPI
    X As Long
    Y As Long
End Type

Public Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Public Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long

Public Declare Function Ellipse Lib "gdi32" (ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Public Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Public Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long

Public Const FLOODFILLBORDER = 0
Public Const FLOODFILLSURFACE = 1

Public Type RECT
        Left As Long
        Top As Long
        Right As Long
        Bottom As Long
End Type

Public Declare Function FrameRgn Lib "gdi32" (ByVal hdc As Long, ByVal hRgn As Long, ByVal hBrush As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long

Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hwndParent&, ByVal hWndChildAfter&, ByVal lpClassName$, ByVal lpWindowName$) As Long

Public Sub VBHdcFillRect(ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    Dim pen As Long, l As Long, brush As Long, m As Long
    pen = CreatePen(0, 1, crColor)
    l = SelectObject(hdc, pen)
    brush = CreateSolidBrush(crColor)
    m = SelectObject(hdc, brush)
    
    Dim r As RECT
    r.Bottom = y2 + 1
    r.Right = x2 + 1
    r.Left = x1
    r.Top = y1
    Call FillRect(hdc, r, brush)
    
    Call SelectObject(hdc, m)
    Call SelectObject(hdc, l)
    Call DeleteObject(brush)
    Call DeleteObject(pen)
End Sub

Sub vbPicLine(ByRef pic As PictureBox, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw line on a picturebox
    pic.Line (x1, y1)-(x2, y2), crColor
End Sub

Sub vbFrmLine(ByRef pic As Form, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw line on a form
    pic.Line (x1, y1)-(x2, y2), crColor
End Sub

Function vbPicPoint(ByRef pic As PictureBox, ByVal X As Long, ByVal Y As Long) As Long
    'get point
    vbPicPoint = pic.point(X, Y)
End Function

Function vbFrmPoint(ByRef pic As PictureBox, ByVal X As Long, ByVal Y As Long) As Long
    'get point
    vbFrmPoint = pic.point(X, Y)
End Function

Sub vbPicPSet(ByRef pic As PictureBox, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long)
    'pset
    pic.PSet (X, Y), crColor
End Sub

Sub vbFrmPSet(ByRef pic As Form, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long)
    'pset
    pic.PSet (X, Y), crColor
End Sub

Sub vbPicRect(ByRef pic As PictureBox, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw a recy on a picturebox
    pic.Line (x1, y1)-(x2, y2), crColor, B
End Sub

Sub vbFrmRect(ByRef pic As Form, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw a rect on a form
    pic.Line (x1, y1)-(x2, y2), crColor, B
End Sub

Sub vbPicFillRect(ByRef pic As PictureBox, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw a filled rect on a picturebox
    pic.Line (x1, y1)-(x2, y2), crColor, BF
End Sub

Sub vbFrmFillRect(ByRef pic As Form, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw a filled rect on a form
    pic.Line (x1, y1)-(x2, y2), crColor, BF
End Sub

Function vbQBColor(ByVal crColor As Long) As Long
    'return vbqbcolor
    On Error Resume Next
    Select Case crColor
        Case 0:
            vbQBColor = 0
        Case 1:
            vbQBColor = 8388608
        Case 2:
            vbQBColor = 32768
        Case 3:
            vbQBColor = 8421376
        Case 4:
            vbQBColor = 128
        Case 5:
            vbQBColor = 8388736
        Case 6:
            vbQBColor = 32896
        Case 7:
            vbQBColor = 12632256
        Case 8:
            vbQBColor = 8421504
        Case 9:
            vbQBColor = 16711680
        Case 10:
            vbQBColor = 65280
        Case 11:
            vbQBColor = 16776960
        Case 12:
            vbQBColor = 255
        Case 13:
            vbQBColor = 16711935
        Case 14:
            vbQBColor = 65535
        Case 15:
            vbQBColor = 16777215
    End Select
End Function

Function vbPicHDC(ByRef pic As PictureBox) As Long
    'get hdc
    vbPicHDC = pic.hdc
End Function

Function vbFrmHDC(ByRef pic As Form) As Long
    'get hdc
    vbFrmHDC = pic.hdc
End Function

Sub vbPicAutoRedraw(ByRef pic As PictureBox, ByVal val As Boolean)
    'set autoredraw
    pic.AutoRedraw = val
End Sub

Sub vbFrmAutoRedraw(ByRef pic As Form, ByVal val As Boolean)
    'set autoredraw
    pic.AutoRedraw = val
End Sub

Sub vbPicCls(ByRef pic As PictureBox)
    'cls
    Call pic.cls
End Sub

Sub vbFrmCls(ByRef pic As Form)
    'cls
    Call pic.cls
End Sub

Sub vbPicCircle(ByRef pic As PictureBox, ByVal X As Long, ByVal Y As Long, ByVal radius As Long, ByVal crColor As Long, Optional ByVal startangle As Double = -1, Optional ByVal endangle As Double = -1, Optional ByVal aspect As Double = -1)
    'draw circle
    If startangle = -1 And endangle = -1 Then
        If aspect = -1 Then
            pic.Circle (X, Y), radius, crColor
        Else
            pic.Circle (X, Y), radius, crColor, , , aspect
        End If
    Else
        If aspect = -1 Then
            pic.Circle (X, Y), radius, crColor, startangle, endangle
        Else
            pic.Circle (X, Y), radius, crColor, startangle, endangle, aspect
        End If
    End If
End Sub

Sub vbPicRefresh(ByRef pic As PictureBox)
    'refresh
    Call pic.Refresh
End Sub

Sub vbFrmRefresh(ByRef pic As Form)
    'refresh
    Call pic.Refresh
End Sub

