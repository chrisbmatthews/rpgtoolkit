Attribute VB_Name = "tkvisuals"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'Declare Function StretchBlt& Lib "gdi32" _
'    (ByVal hdc&, ByVal x&, ByVal y&, ByVal nwidth&, ByVal nheight&, _
'     ByVal hSrcDC&, ByVal xSrc&, ByVal ySrc&, ByVal SrcWidth&, ByVal SrcHeight&, _
'     ByVal dwrop&)

'Declare Function BitBlt Lib "gdi32" (ByVal hDestDC&, ByVal x&, ByVal y&, ByVal nwidth&, ByVal nheight&, ByVal hSrcDC&, ByVal xSrc&, ByVal ySrc&, ByVal dwrop&) As Long

'Constants for use with BitBlt()
'Global Const SRCCOPY = &HCC0020 ' (DWORD) dest = source
'Global Const SRCPAINT = &HEE0086        ' (DWORD) dest = source OR dest
'Global Const SRCAND = &H8800C6  ' (DWORD) dest = source AND dest
'Global Const SRCINVERT = &H660046       ' (DWORD) dest = source XOR dest
'Global Const SRCERASE = &H440328        ' (DWORD) dest = source AND (NOT dest )
'Global Const NOTSRCCOPY = &H330008      ' (DWORD) dest = (NOT source)
'Global Const NOTSRCERASE = &H1100A6     ' (DWORD) dest = (NOT src) AND (NOT dest)
'Global Const MERGECOPY = &HC000CA       ' (DWORD) dest = (source AND pattern)
'Global Const MERGEPAINT = &HBB0226      ' (DWORD) dest = (NOT source) OR dest
'Global Const PATCOPY = &HF00021 ' (DWORD) dest = pattern
'Global Const PATPAINT = &HFB0A09        ' (DWORD) dest = DPSnoo
'Global Const PATINVERT = &H5A0049       ' (DWORD) dest = pattern XOR dest
'Global Const DSTINVERT = &H550009       ' (DWORD) dest = (NOT dest)
'Global Const BLACKNESS = &H42&  ' (DWORD) dest = BLACK
'Global Const WHITENESS = &HFF0062       ' (DWORD) dest = WHITE


'Function round(v As Double) As Integer
'    'rounds the number off.
'    Dim dec As Double
'    Dim inte As Integer
'
'    inte = Int(v)
'    dec = v - inte
'    If dec < 0.5 Then
'        round = inte
'    Else
'        round = inte + 1
'    End If
'End Function


