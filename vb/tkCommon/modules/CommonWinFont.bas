Attribute VB_Name = "CommonWinFont"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Shao Xiang
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'=========================================================================
' Interface with windows API :: fonts
'=========================================================================

Option Explicit

'=========================================================================
' Declarations for windows API exports
'=========================================================================
Public Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Public Declare Function DrawTextEx Lib "user32" Alias "DrawTextExA" (ByVal hdc As Long, ByVal lpsz As String, ByVal n As Long, lpRect As RECT, ByVal un As Long, lpDrawTextParams As DRAWTEXTPARAMS) As Long
Public Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal lpString As String, ByVal nCount As Long) As Long
Public Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function CreateFont Lib "gdi32" Alias "CreateFontA" (ByVal h As Long, ByVal w As Long, ByVal e As Long, ByVal O As Long, ByVal w As Long, ByVal i As Long, ByVal u As Long, ByVal S As Long, ByVal c As Long, ByVal op As Long, ByVal cp As Long, ByVal Q As Long, ByVal PAF As Long, ByVal f As String) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function AddFontResource Lib "gdi32" Alias "AddFontResourceA" (ByVal lpFileName As String) As Long
Public Declare Function RemoveFontResource Lib "gdi32" Alias "RemoveFontResourceA" (ByVal lpFileName As String) As Long
Public Declare Function SetTextAlign Lib "gdi32" (ByVal hdc As Long, ByVal wFlags As Long) As Long
Public Declare Function GetTextExtentPoint32 Lib "gdi32" Alias "GetTextExtentPoint32A" (ByVal hdc As Long, ByVal lpsz As String, ByVal cbString As Long, lpSize As size) As Long

'=========================================================================
' Text alignments
'=========================================================================
Public Const TA_BASELINE = 24
Public Const TA_BOTTOM = 8
Public Const TA_CENTER = 6
Public Const TA_LEFT = 0
Public Const TA_NOUPDATECP = 0
Public Const TA_RIGHT = 2
Public Const TA_TOP = 0
Public Const TA_UPDATECP = 1
Public Const DT_BOTTOM = &H8
Public Const DT_CALCRECT = &H400
Public Const DT_CENTER = &H1
Public Const DT_EXPANDTABS = &H40
Public Const DT_EXTERNALLEADING = &H200
Public Const DT_INTERNAL = &H1000
Public Const DT_LEFT = &H0
Public Const DT_NOCLIP = &H100
Public Const DT_NOPREFIX = &H800
Public Const DT_RIGHT = &H2
Public Const DT_SINGLELINE = &H20
Public Const DT_TOP = &H0
Public Const DT_VCENTER = &H4
Public Const DT_TABSTOP = &H80
Public Const DT_WORDBREAK = &H10

'=========================================================================
' Required structures
'=========================================================================
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Public Type DRAWTEXTPARAMS
    cbSize As Long
    iTabLength As Long
    iLeftMargin As Long
    iRightMargin As Long
    uiLengthDrawn As Long
End Type
Public Type size
    cx As Long
    cy As Long
End Type

'=========================================================================
' Character sets
'=========================================================================
Public Const ANSI_CHARSET = 0
Public Const BALTIC_CHARSET = 186
Public Const CHINESEBIG5_CHARSET = 136
Public Const DEFAULT_CHARSET = 1
Public Const EASTEUROPE_CHARSET = 238
Public Const GREEK_CHARSET = 161
Public Const HANGEUL_CHARSET = 129
Public Const MAC_CHARSET = 77
Public Const OEM_CHARSET = 255
Public Const RUSSIAN_CHARSET = 204
Public Const SHIFTJIS_CHARSET = 128
Public Const SYMBOL_CHARSET = 2
Public Const TURKISH_CHARSET = 162
Public Const JOHAB_CHARSET = 130
Public Const HEBREW_CHARSET = 177
Public Const ARABIC_CHARSET = 178
Public Const THAI_CHARSET = 222

'=========================================================================
' Font weights
'=========================================================================
Public Const FW_DONTCARE = 0
Public Const FW_THIN = 100
Public Const FW_EXTRALIGHT = 200
Public Const FW_ULTRALIGHT = 200
Public Const FW_LIGHT = 300
Public Const FW_NORMAL = 400
Public Const FW_REGULAR = 400
Public Const FW_MEDIUM = 500
Public Const FW_SEMIBOLD = 600
Public Const FW_DEMIBOLD = 600
Public Const FW_BOLD = 700
Public Const FW_EXTRABOLD = 800
Public Const FW_ULTRABOLD = 800
Public Const FW_HEAVY = 900
Public Const FW_BLACK = 900

'=========================================================================
' Output precision
'=========================================================================
Public Const OUT_CHARACTER_PRECIS = 2
Public Const OUT_DEFAULT_PRECIS = 0
Public Const OUT_DEVICE_PRECIS = 5
Public Const OUT_OUTLINE_PRECIS = 8
Public Const OUT_RASTER_PRECIS = 6
Public Const OUT_STRING_PRECIS = 1
Public Const OUT_STROKE_PRECIS = 3
Public Const OUT_TT_ONLY_PRECIS = 7
Public Const OUT_TT_PRECIS = 4

'=========================================================================
' Clip precision
'=========================================================================
Public Const CLIP_CHARACTER_PRECIS = 1
Public Const CLIP_DEFAULT_PRECIS = 0
Public Const CLIP_EMBEDDED = 128
Public Const CLIP_LH_ANGLES = 16

'=========================================================================
' Font quality
'=========================================================================
Public Const DEFAULT_QUALITY = 0
Public Const DRAFT_QUALITY = 1
Public Const PROOF_QUALITY = 2

'=========================================================================
' Font pitch and family
'=========================================================================
Public Const DEFAULT_PITCH = 0   ' default pitch
Public Const FIXED_PITCH = 1     ' fixed pitch (cannot change)
Public Const VARIABLE_PITCH = 2  ' variable pitch (able to change)
Public Const FF_DECORATIVE = 80  ' Old English, etc.
Public Const FF_DONTCARE = 0     ' Don't care or don't know.
Public Const FF_MODERN = 48      ' Constant stroke width, serifed or sans-serifed.
Public Const FF_ROMAN = 16       ' Variable stroke width, serifed.
Public Const FF_SCRIPT = 64      ' Cursive, etc.
Public Const FF_SWISS = 32       ' Variable stroke width, sans-serifed.

'=========================================================================
' Determines if a font is a toolkit font
'=========================================================================
Public Function isToolkitFont(ByVal filename As String) As Boolean
    On Error Resume Next
    Dim num As Long
    num = FreeFile()
    filename = PakLocate(filename)
    Open filename For Input As num
        If UCase$(fread(num)) = "RPGTLKIT FONT" Then
            isToolkitFont = True
        End If
    Close num
End Function

'=========================================================================
' Load fonts from the folder passed in
'=========================================================================
Public Sub LoadFontsFromFolder(ByVal folderName As String)
    On Error Resume Next
    Dim a As String
    a = Dir(folderName & "*.*")
    Do Until (LenB(a) = 0)
        If Not isToolkitFont(folderName + a) Then
            Call AddFontResource(folderName & a)
        End If
        a = Dir()
    Loop
End Sub

'=========================================================================
' Unload fonts from the folder passed in
'=========================================================================
Public Sub UnLoadFontsFromFolder(ByVal folderName As String)
    On Error Resume Next
    Dim a As String
    a = Dir(folderName & "*.*")
    Do Until (LenB(a) = 0)
        If Not isToolkitFont(folderName + a) Then
            Call RemoveFontResource(folderName & a)
        End If
        a = Dir()
    Loop
End Sub

'=========================================================================
' Assign a font to a device
'=========================================================================
Public Function SelectFontToDevice(ByVal fontName As String, ByVal hdc As Long, ByVal size As Long, ByRef hFontNew As Long, Optional ByVal italic As Boolean, Optional ByVal Bold As Boolean, Optional ByVal Underline As Boolean, Optional ByVal centred As Boolean = False) As Long
    On Error Resume Next
    Dim weight As Long
    If Bold Then
        weight = FW_BOLD
    Else
        weight = FW_NORMAL
    End If
    Dim hFont As Long
    hFont = CreateFont(size, 0, 0, 0, weight, italic, Underline, False, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, fontName)
    If hFont Then
        Dim a As Long
        a = SelectObject(hdc, hFont)
        SelectFontToDevice = a
    End If
    If centred Then
        Call SetTextAlign(hdc, TA_CENTER)
    Else
        Call SetTextAlign(hdc, TA_LEFT)
    End If
    hFontNew = hFont
End Function
