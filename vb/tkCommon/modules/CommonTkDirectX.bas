Attribute VB_Name = "CommonTkDirectX"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'DirectX accessor functions
'requires DX 7 or better
'Designed for version 3.0
Option Explicit

Declare Function DXInitGfxMode Lib "actkrt3.dll" (ByVal hWndHost As Long, _
                                                  ByVal nScreenX As Long, _
                                                  ByVal nScreenY As Long, _
                                                  ByVal nUseDirectX As Long, _
                                                  ByVal nColorDepth As Long, _
                                                  ByVal nFullScreen As Long) As Long

Declare Function DXKillGfxMode Lib "actkrt3.dll" () As Long

Declare Function DXRefresh Lib "actkrt3.dll" () As Long

Declare Function DXLockScreen Lib "actkrt3.dll" () As Long

Declare Function DXUnlockScreen Lib "actkrt3.dll" () As Long

Declare Function DXDrawPixel Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long

Declare Function DXDrawCanvas Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

Declare Function DXDrawCanvasTransparent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTranspColor As Long) As Long

Declare Function DXDrawCanvasTranslucent Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long

Declare Function DXClearScreen Lib "actkrt3.dll" (ByVal crColor As Long) As Long

Declare Function DXDrawText Lib "actkrt3.dll" (ByVal x As Long, ByVal y As Long, ByVal strText As String, ByVal strTypeFace As String, ByVal size As Long, ByVal clr As Long, ByVal bold As Long, ByVal italics As Long, ByVal underline As Long, ByVal centred As Long, ByVal outlined As Long) As Long

Declare Function DXDrawCanvasPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal Width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

Declare Function DXDrawCanvasTransparentPartial Lib "actkrt3.dll" (ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal Width As Long, ByVal height As Long, ByVal crTranspColor As Long) As Long

Declare Function DXCopyScreenToCanvas Lib "actkrt3.dll" (ByVal canvasID As Long) As Long

