Attribute VB_Name = "CommonFont"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public currentFontName As String         'current font filename
'Font Editor
Public char(7, 255) As String
Public fontMem(8, 8) As Long
Public currentFont(100, 100) As Long
Public currentX As Long, currentY As Long
Public whichChar As Long
Public bold As Long
Public italics As Long
Public underline As Long
Public fName As String


'last used font attribs...
Type fontAttribs
    name As String  'font name
    size As Long    'size
    bold As Boolean 'bold?
    italics As Boolean  'italicized?
    underline As Boolean    'underlined?
End Type

Public MsgBoxAttribs As fontAttribs   'current font set to the message box
Private ScreenAttribs As fontAttribs   'current font set to the display area

Public Declare Function BeginPath Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function EndPath Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function StrokePath Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function StrokeAndFillPath Lib "gdi32" (ByVal hdc As Long) As Long

Public Declare Function GetStockObject Lib "gdi32" (ByVal nIndex As Long) As Long
'stock objects
Public Const BLACK_BRUSH = 4
Public Const BLACK_PEN = 7
Public Const DKGRAY_BRUSH = 3
Public Const GRAY_BRUSH = 2
Public Const WHITE_PEN = 6
Public Const SYSTEM_FONT = 13


Public Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Public Const TRANSPARENT = 1
Public Const OPAQUE = 2

Sub drawGDIText(ByVal stringin As String, ByVal x As Double, ByVal y As Double, ByVal coltxt As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal fontFace As String, ByVal bold As Boolean, ByVal italics As Boolean, ByVal underline As Boolean, ByVal hdc As Long, Optional ByVal centred As Boolean = False, Optional ByVal outlined As Boolean = False)
    On Error Resume Next
               
    Dim Length As String
    Length = Len(stringin$)
    
    Dim theAttrib As fontAttribs
    theAttrib.name = fontFace
    theAttrib.size = sizey
    theAttrib.italics = italics
    theAttrib.bold = bold
    theAttrib.underline = underline
        
    Call SetBkMode(hdc, TRANSPARENT)
    Dim hFontNew As Long
    Dim hFontOld As Long
    hFontOld = SetDeviceFont(hdc, theAttrib, hFontNew, centred)
    Call SetTextColor(hdc, coltxt)
        
    Dim xx As Long
    Dim yy As Long
    xx = (x * sizex) - sizex
    yy = (y - 1) * sizey
    
    Dim hOldBrush As Long
    Dim hNewBrush As Long
    hNewBrush = CreateSolidBrush(coltxt)
    hOldBrush = SelectObject(hdc, hNewBrush)
       
    If outlined Then
        Call BeginPath(hdc)
        Call TextOut(hdc, xx, yy, stringin$, Length)
        Call EndPath(hdc)
        
        Call SetBkColor(hdc, coltxt)
        Call SetBkMode(hdc, OPAQUE)
        Call StrokeAndFillPath(hdc)
    Else
        Call TextOut(hdc, xx, yy, stringin$, Length)
    End If
    
    Call SelectObject(hdc, hOldBrush)
    Call DeleteObject(hNewBrush)
    
    'now select the old font back onto this surface
    Call SelectObject(hdc, hFontOld)
    Call DeleteObject(hFontNew)
End Sub



Sub antialias()
    'antialiases font
    On Error GoTo errorhandler
    Dim x As Long, y As Long
    For x = 1 To currentX - 1
        For y = 1 To currentY - 1
            If currentFont(x, y) = 0 Then
                If currentFont(x, y + 1) = 1 And _
                   currentFont(x + 1, y) = 1 Then
                    currentFont(x, y) = 2
                End If
                If currentFont(x - 1, y) = 1 And _
                    currentFont(x, y + 1) = 1 Then
                    currentFont(x, y) = 2
                End If
                If currentFont(x, y - 1) = 1 And _
                    currentFont(x + 1, y) = 1 Then
                    currentFont(x, y) = 2
                End If
                If currentFont(x, y + 1) = 1 And _
                    currentFont(x - 1, y) = 1 Then
                    currentFont(x, y) = 2
                End If
            End If
        Next y
    Next x

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fontbold()
    On Error Resume Next
    ReDim fbuff(100, 100)
    Dim x As Long, y As Long
    For x = 1 To currentX
        For y = 1 To currentY
            fbuff(x, y) = currentFont(x, y)
            If fbuff(x, y) = 0 Then
                If currentFont(x - 1, y) = 1 Then fbuff(x, y) = 1
            End If
        Next y
    Next x
    For x = 1 To currentX
        For y = 1 To currentY
            currentFont(x, y) = fbuff(x, y)
        Next y
    Next x
    currentX = currentX + 1
End Sub

Sub fontitalics()
    On Error Resume Next
    ReDim fbuff(100, 100) As Long
    Dim x As Long, y As Long
    For x = 1 To currentX
        For y = 1 To currentY
            If y <= Int(currentY / 2) Then
                fbuff(x + 1, y) = currentFont(x, y)
            Else
                fbuff(x, y) = currentFont(x, y)
            End If
        Next y
    Next x
    For x = 1 To currentX
        For y = 1 To currentY
            currentFont(x, y) = fbuff(x, y)
        Next y
    Next x
    currentX = currentX + 1
End Sub

Sub fontunderline()
    On Error Resume Next
    Dim x As Long
    For x = 1 To currentX
        currentFont(x, currentY + 2) = 1
    Next x
    currentY = currentY + 2
End Sub

Sub loadFont(filename$)
    On Error Resume Next
    'loadingfont.Show
    Dim num As Long, f As String, a As String, t As Long, numi As Long
    num = FreeFile
    f$ = PakLocate(filename$)
    Open f$ For Input As #num
        Input #num, a$
        If UCase$(a$) <> "RPGTLKIT FONT" Then MsgBox "Unrecognised file format!", , "Open Font": Close #num:  Exit Sub
        Input #num, a$    'Version
        Input #num, a$    'Subver
        For t = 0 To 255
            For numi = 0 To 7
                Input #num, a$
                char$(numi, t) = toBinary(val(a$))
            Next numi
            'loadingfont.progress.Line (0, 0)-(t, 300), vbqbcolor(9), BF
        Next t
    Close #num
End Sub

Sub putchar(ByVal stringin$, ByVal x As Double, ByVal y As Double, ByVal coltxt As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long)
    On Error Resume Next
    Dim chari As Long
    
    chari = Asc(stringin$)
    Call resize(chari, sizex, sizey)
    If bold = 1 Then Call fontbold
    If italics = 1 Then Call fontitalics
    If underline = 1 Then Call fontunderline
    Dim xx As Long, yy As Long, v As Long, aa As Long
    For xx = 1 To currentX
        For yy = 1 To currentY
            v = currentFont(xx, yy)
            If v = 1 Then v = 15
            If v = 2 Then v = 8
            'If UCase$(place$) = "MWIN" Then
                If v = 15 Then
                    'aa = setpixelV(vbpichdc(messagewindow.win), xx + xx - 1, y + yy - 1, coltxt)
                    'pic.PSet (x + xx - 1, y + yy - 1), coltxt
                    aa = SetPixelV(hdc, x + xx - 1, y + yy - 1, coltxt)
                End If
                If v = 8 Then
                    Dim rd As Long, gn As Long, bl As Long
                    rd = red(coltxt)
                    gn = green(coltxt)
                    bl = blue(coltxt)
                    rd = rd - 128
                    gn = gn - 128
                    bl = bl - 128
                    'If vbPicHDC(pic) = vbpichdc(messagewindow.win) Then
                    '    messagewindow.win.PSet (x + xx - 1, y + yy - 1), RGB(rd, bn, bl)
                    'Else
                    '    pic.PSet (x + xx - 1, y + yy - 1), RGB(rd, bn, bl)
                    'End If
                    aa = SetPixelV(hdc, x + xx - 1, y + yy - 1, RGB(rd, gn, bl))
                End If
            'End If
            'If UCase$(place$) = "BOARD" Then
            '    'call vbPicAutoRedraw(mainForm.boardform,false)
            '    If v = 15 Then
            '        'call vbPicAutoRedraw(mainForm.boardform, true)
            '        Call drawPixel(mainForm.boardform, (x + xx - 1), (y + yy - 1), coltxt)
            '        'aa = setpixelV(vbpichdc(mainForm.boardform), x + xx - 1, y + yy - 1, coltxt)
            '        'mainForm.boardform.PSet (x + xx - 1, y + yy - 1), coltxt
            '    End If
            '    If v = 8 Then
            '        rd = red(coltxt)
            '        gn = green(coltxt)
            '        bl = blue(coltxt)
            '        rd = rd - 128
            '        gb = gn - 128
            '        bl = bl - 128
            '        Call drawPixel(mainForm.boardform, (x + xx - 1), (y + yy - 1), RGB(rd, gn, bl))
            '    End If
            '    'call vbPicAutoRedraw(mainForm.boardform, true)
            'End If
            'If UCase$(place$) = "MWIN" Then If v = 15 Then mainForm.boardform.PSet (x + xx - 1, y + yy - 1), vbqbcolor(0)
            'If UCase$(place$) = "PREVIEW" Then If v = 15 Then fontedit.preview.PSet (x + xx - 1, y + yy - 1), coltxt
        Next yy
    Next xx
    
End Sub

Sub putText(ByVal stringin As String, ByVal x As Double, ByVal y As Double, ByVal coltxt As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long)
    On Error Resume Next
            
    Call SetBkMode(hdc, TRANSPARENT)
      
    Dim Length As Long
    Length = Len(stringin$)
    Dim dx As Double
    dx = x
    'If staticText = 1 Then
    '    pic.AutoRedraw = True
    'Else
    '    If vbPicHDC(pic) <> vbpichdc(mainForm.boardform) Then
    '        pic.AutoRedraw = False
    '    End If
    'End If
    
    Dim useTTFont As Boolean
    If UCase$(GetExt(fontName$)) = "FNT" Then
        useTTFont = False
    Else
        useTTFont = True
    End If
    If useTTFont Then
        'using a true type font!
        'pic.AutoRedraw = True
        Dim bold As Boolean, italic As Boolean, underline As Boolean
        If bold = 1 Then bold = True
        If italics = 1 Then italic = True
        If underline = 1 Then underline = True
        
        Dim theAttrib As fontAttribs
        theAttrib.name = fontName$
        theAttrib.size = sizey
        theAttrib.italics = italic
        theAttrib.bold = bold
        theAttrib.underline = underline
        
        Dim hFontNew As Long, hFontOld As Long
        hFontOld = SetDeviceFont(hdc, theAttrib, hFontNew)
        Dim a As Long
        a = SetTextColor(hdc, coltxt)
        
        Dim xx As Long, yy As Long
        xx = (dx * sizex) - sizex
        yy = (y - 1) * sizey
        a = TextOut(hdc, xx, yy, stringin$, Len(stringin$))
        Call SelectObject(hdc, hFontOld)
        Call DeleteObject(hFontNew)
    Else
        'If vbPicHDC(pic) <> vbpichdc(mainForm.boardform) Then
        '    pic.AutoRedraw = False
        'End If
        Dim t As Long, part As String
        For t = 1 To Length
            xx = (dx * sizex) - sizex
            part$ = Mid$(stringin$, t, 1)
            Call putchar(part$, xx, (y - 1) * sizey, coltxt, sizex, sizey, hdc)
            'If staticText = 1 Then
            '    pic.Refresh
            'End If
            'If UCase$(place$) = "MWIN" Then messagewindow.win.Refresh
            dx = dx + 1
        Next t
    End If
    
End Sub

Sub resize(ByVal charnum As Long, ByVal x As Long, ByVal y As Long)
    On Error Resume Next
    ReDim fbuff(8, 8) As Long
    
    If x > 100 Then x = 100: If y > 100 Then y = 100
    currentX = x: currentY = y
    Dim xx As Long, yy As Long, colb As String, v As Long
    
    For yy = 1 To 8
        For xx = 1 To 8
            colb$ = Mid$(char$(yy - 1, charnum), xx, 1)
            v = val(colb$)
            fbuff(xx, yy) = v
            'If v = 1 Then v = 15
            'fontedit.fontmap.PSet (xx + 100, yy), vbqbcolor(v)
        Next xx
    Next yy
    
    Dim corx As Long, cory As Long
    For xx = 1 To x
        For yy = 1 To y
            corx = Int((8 / x) * xx)
            cory = Int((8 / y) * yy)
            currentFont(xx, yy) = fbuff(corx, cory)
            'If currentfont(xx, yy) = 1 Then fontedit.fontmap.PSet (xx, yy) Else fontedit.fontmap.PSet (xx, yy), vbqbcolor(15)
        Next yy
    Next xx
            
    'Call antialias
End Sub

Sub saveFont(filename$)
    On Error Resume Next
    'loadingfont.Show
    'loadingfont.Caption = "Saving Font..."
    Dim num As Long, t As Long, numi As Long, decnum As Long
    num = FreeFile
    Open filename$ For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "RPGTLKIT FONT"
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "2" 'Version
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, "0" 'Subver
        For t = 0 To 255
            For numi = 0 To 7
                decnum = toDecimal(char$(numi, t))
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num, decnum
            Next numi
            'loadingfont.progress.Line (0, 0)-(t, 300), vbqbcolor(9), BF
        Next t
    Close #num
    'Unload loadingfont
End Sub

Function SetDeviceFont(ByVal hdc As Long, ByRef theAttribs As fontAttribs, ByRef hFontNew As Long, Optional ByVal centred As Boolean = False) As Long
    'set the font for a device
    'returns a handle to the old font.
    'also returns handle of new font in hFontNew
    On Error Resume Next
    
    Call SetBkMode(hdc, TRANSPARENT)
    
    Dim fnt As Long
    Dim newFnt As Long
    fnt = SelectFontToDevice(theAttribs.name, hdc, theAttribs.size, newFnt, theAttribs.italics, theAttribs.bold, theAttribs.underline, centred)
    hFontNew = newFnt
    SetDeviceFont = fnt
End Function

Function toBinary(ByVal decimala As Long) As String
    On Error GoTo errorhandler
    Dim binNum As String, t As Long, Length As Long, newNum As String, part As String
    Dim remain As Long
    binNum$ = ""
    For t = 1 To 8
        remain = decimala Mod 2
        decimala = Int(decimala / 2)
        binNum$ = str$(remain) + binNum$
    Next t
    Length = Len(binNum$)
    newNum$ = ""
    For t = 1 To Length
        part$ = Mid$(binNum$, t, 1)
        If part$ <> " " Then newNum$ = newNum$ + part$
    Next t
    toBinary$ = newNum$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function toDecimal(ByVal bin As String) As Long
    On Error Resume Next
    Dim Length As Long, toadd As Long, addon As String, t As Long, dec As Long, part As String
    Length = Len(bin$)
    If Length < 8 Then
        toadd = 8 - Length
        For t = 1 To toadd
            addon$ = addon$ + "0"
        Next t
        bin$ = addon$ + bin$
    End If
    dec = 0
    For t = 1 To 8
        part$ = Mid$(bin$, t, 1)
        dec = dec * 2 + val(part$)
    Next t
    toDecimal = dec
End Function

