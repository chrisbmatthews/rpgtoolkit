Attribute VB_Name = "CommonTkCanvas"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'canvas system access routines

Option Explicit

Public Declare Function CNVInit Lib "actkrt3.dll" () As Long
Public Declare Function CNVShutdown Lib "actkrt3.dll" () As Long
Public Declare Function CNVCreate Lib "actkrt3.dll" (ByVal hdcCompatable As Long, ByVal Width As Long, ByVal height As Long, Optional ByVal useDX As Long = 1) As Long
Public Declare Function CNVDestroy Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVOpenHDC Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVCloseHDC Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdc As Long) As Long
Public Declare Function CNVLock Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVUnlock Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVGetWidth Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVGetHeight Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVGetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function CNVSetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Public Declare Function CNVExists Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Function CNVBltCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal X As Long, ByVal Y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function CNVBltCanvasTransparent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal X As Long, ByVal Y As Long, Optional ByVal crColor As Long) As Long
Public Declare Function CNVBltCanvasTranslucent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal X As Long, ByVal Y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
Public Declare Function CNVGetRGBColor Lib "actkrt3.dll" (ByVal handle As Long, ByVal crColor As Long) As Long
Public Declare Function CNVResize Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdcCompatible As Long, ByVal Width As Long, ByVal height As Long) As Long
Public Declare Function CNVShiftLeft Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Public Declare Function CNVShiftRight Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Public Declare Function CNVShiftUp Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Public Declare Function CNVShiftDown Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Public Declare Function CNVBltPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal X As Long, ByVal Y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Public Declare Function CNVBltTransparentPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal X As Long, ByVal Y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal crColor As Long) As Long

Public Property Get CanvasOccupied(ByVal handle As Long) As Boolean
    'determine if a canvas exists
    On Error Resume Next
    If Not (CNVExists(handle) = 0) Then
        CanvasOccupied = True
    End If
End Property

