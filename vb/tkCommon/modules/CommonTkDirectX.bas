Attribute VB_Name = "CommonTkDirectX"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'DirectX accessor functions
'requires DX 7 or better
'Designed for version 3.0

Option Explicit

Public Declare Function DXInitGfxMode Lib "actkrt3.dll" (ByVal hWndHost As Long, ByVal nScreenX As Long, ByVal nScreenY As Long, ByVal nUseDirectX As Long, ByVal nColorDepth As Long, ByVal nFullScreen As Long) As Long
Public Declare Function DXKillGfxMode Lib "actkrt3.dll" () As Long
Public Declare Function DXRefresh Lib "actkrt3.dll" () As Long
Public Declare Function DXLockScreen Lib "actkrt3.dll" () As Long
Public Declare Function DXUnlockScreen Lib "actkrt3.dll" () As Long
Public Declare Function DXDrawPixel Lib "actkrt3.dll" (ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Public Declare Function DXDrawCanvas Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function DXDrawCanvasTransparent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, ByVal crTranspColor As Long) As Long
Public Declare Function DXDrawCanvasTranslucent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
Public Declare Function DXClearScreen Lib "actkrt3.dll" (ByVal crColor As Long) As Long
Public Declare Function DXDrawText Lib "actkrt3.dll" (ByVal X As Long, ByVal Y As Long, ByVal strText As String, ByVal strTypeFace As String, ByVal size As Long, ByVal clr As Long, ByVal Bold As Long, ByVal Italics As Long, ByVal Underline As Long, ByVal centred As Long, ByVal outlined As Long) As Long
Public Declare Function DXDrawCanvasPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal Width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function DXDrawCanvasTransparentPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal Width As Long, ByVal height As Long, ByVal crTranspColor As Long) As Long
Public Declare Function DXCopyScreenToCanvas Lib "actkrt3.dll" (ByVal canvasID As Long) As Long
