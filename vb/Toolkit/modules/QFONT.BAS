Attribute VB_Name = "QFONT"

Sub antialias()
    'antialiases font
    On Error GoTo errorhandler
    For x = 1 To currentx
        For y = 1 To currenty
            If currentfont(x, y) = 0 Then
                If currentfont(x, y + 1) = 1 And _
                   currentfont(x + 1, y) = 1 Then
                    currentfont(x, y) = 2
                End If
                If currentfont(x - 1, y) = 1 And _
                    currentfont(x, y + 1) = 1 Then
                    currentfont(x, y) = 2
                End If
                If currentfont(x, y - 1) = 1 And _
                    currentfont(x + 1, y) = 1 Then
                    currentfont(x, y) = 2
                End If
                If currentfont(x, y + 1) = 1 And _
                    currentfont(x - 1, y) = 1 Then
                    currentfont(x, y) = 2
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


Function toBinary$(decimala)
    On Error GoTo errorhandler
    binnum$ = ""
    For t = 1 To 8
        remain = decimala Mod 2
        decimala = Int(decimala / 2)
        binnum$ = str$(remain) + binnum$
    Next t
    Length = Len(binnum$)
    newnum$ = ""
    For t = 1 To Length
        part$ = Mid$(binnum$, t, 1)
        If part$ <> " " Then newnum$ = newnum$ + part$
    Next t
    toBinary$ = newnum$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub puttext(stringin$, x, y, coltxt, sizex, sizey, place$)
    On Error GoTo errorhandler
    Length = Len(stringin$)
    For t = 1 To Length
        part$ = Mid$(stringin$, t, 1)
        Call putchar(part$, x + ((t - 1) * sizex), (y - 1) * sizey, coltxt, sizex, sizey, place$)
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub resize(charnum, x, y)
    On Error GoTo errorhandler
ReDim fbuff(8, 8)
If x > 100 Then x = 100: If y > 100 Then y = 100
currentx = x: currenty = y
For yy = 1 To 8
    For xx = 1 To 8
        colb$ = Mid$(char$(yy - 1, charnum), xx, 1)
        v = val(colb$)
        fbuff(xx, yy) = v
        'If v = 1 Then v = 15
        'fontedit.fontmap.PSet (xx + 100, yy), vbqbcolor(v)
    Next xx
Next yy

For xx = 1 To x
    For yy = 1 To y
        corx = Int((8 / x) * xx)
        cory = Int((8 / y) * yy)
        currentfont(xx, yy) = fbuff(corx, cory)
        'If currentfont(xx, yy) = 1 Then fontedit.fontmap.PSet (xx, yy) Else fontedit.fontmap.PSet (xx, yy), vbqbcolor(15)
    Next yy
Next xx
        
Call antialias

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub saveFont(filename$)
    On Error Resume Next
    loadingfont.Show
    loadingfont.caption = LoadStringLoc(2022, "Saving Font...")
    num = FreeFile
    Open filename$ For Output As #num
        Print #num, "RPGTLKIT FONT"
        Print #num, "2" 'Version
        Print #num, "0" 'Subver
    For t = 0 To 255
        For numi = 0 To 7
            decnum = toDecimal(char$(numi, t))
            Print #num, decnum
        Next numi
        'loadingfont.progress.Line (0, 0)-(t, 300), vbqbcolor(9), BF
        Call vbPicFillRect(loadingfont.progress, 0, 0, t, 300, vbQBColor(9))
    Next t
    Close #num
    Unload loadingfont
End Sub

Sub fontbold()
    On Error GoTo errorhandler
ReDim fbuff(100, 100)
For x = 1 To currentx
    For y = 1 To currenty
        fbuff(x, y) = currentfont(x, y)
        If fbuff(x, y) = 0 Then
            If currentfont(x - 1, y) = 1 Then fbuff(x, y) = 1
        End If
    Next y
Next x
For x = 1 To currentx
    For y = 1 To currenty
        currentfont(x, y) = fbuff(x, y)
    Next y
Next x
currentx = currentx + 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fontitalics()
    On Error GoTo errorhandler
ReDim fbuff(100, 100)
For x = 1 To currentx
    For y = 1 To currenty
        If y <= Int(currenty / 2) Then
            fbuff(x + 1, y) = currentfont(x, y)
        Else
            fbuff(x, y) = currentfont(x, y)
        End If
    Next y
Next x
For x = 1 To currentx
    For y = 1 To currenty
        currentfont(x, y) = fbuff(x, y)
    Next y
Next x
currentx = currentx + 1


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub fontunderline()
    On Error GoTo errorhandler
For x = 1 To currentx
    currentfont(x, currenty + 2) = 1
Next x
currenty = currenty + 2


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub loadFont(filename$)
    On Error GoTo fontloaderr:
    loadingfont.Show
    num = FreeFile
    Open filename$ For Input As #num
        Input #num, a$
        If UCase$(a$) <> "RPGTLKIT FONT" Then MsgBox "Unrecognised file format!", , "Open Font": Close #num: Unload loadingfont: Exit Sub
        Input #num, a$    'Version
        Input #num, a$    'Subver
        For t = 0 To 255
            For numi = 0 To 7
                Input #num, a$
                char$(numi, t) = toBinary(val(a$))
            Next numi
            'loadingfont.progress.Line (0, 0)-(t, 300), vbqbcolor(9), BF
        Call vbPicFillRect(loadingfont.progress, 0, 0, t, 300, vbQBColor(9))
        Next t
    Close #num
    Unload loadingfont
    Exit Sub
    
fontloaderr:
    Resume Next


End Sub

Function nospace(text$)
    On Error GoTo errorhandler
a$ = text$
Length = Len(a$)
thenew$ = ""
For t = 1 To Length
    part$ = Mid$(a$, t, 1)
    If part$ <> " " Then thenew$ = thenew$ + part$
Next t
nospace = thenew$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub putchar(stringin$, x, y, coltxt, sizex, sizey, place$)
    On Error GoTo errorhandler
chari = Asc(stringin$)
Call resize(chari, sizex, sizey)
If bold = 1 Then Call fontbold
If italics = 1 Then Call fontitalics
If underline = 1 Then Call fontunderline
For xx = 1 To currentx
    For yy = 1 To currenty
        v = currentfont(xx, yy)
        If v = 1 Then v = 15
        If v = 2 Then v = 8
        If UCase$(place$) = "MAP" Then
            If v = 15 Then
                Call vbPicPSet(fontedit.fontmap, x + xx - 1, y + yy - 1, coltxt)
            End If
        End If
        If UCase$(place$) = "PREVIEW" Then
            If v = 15 Then
                Call vbPicPSet(fontedit.preview, x + xx - 1, y + yy - 1, coltxt)
            End If
            If v = 8 Then
                rr = red(coltxt) + 150
                gg = green(coltxt) + 150
                bb = blue(coltxt) + 150
                Call vbPicPSet(fontedit.preview, x + xx - 1, y + yy - 1, RGB(rr, gg, bb))
            End If
        End If
        If UCase$(place$) = "TKVISUAL" Then
            If v = 15 Then
                Call vbPicPSet(tkvisual.boardform, x + xx - 1, y + yy - 1, coltxt)
            End If
            If v = 8 Then
                rr = red(coltxt) + 150
                gg = green(coltxt) + 150
                bb = blue(coltxt) + 150
                Call vbPicPSet(tkvisual.boardform, x + xx - 1, y + yy - 1, RGB(rr, gg, bb))
                'tkvisual.boardform.PSet (x + xx - 1, y + yy - 1), RGB(255, 0, 0)
            End If
        End If
    Next yy
Next xx

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Function toDecimal(bin$)
    On Error GoTo errorhandler
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

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

