Global winsys$      'windows system director
Global destdir$     'destination dir
Global modified

Function fileExist (filename$)
    'Function checks if a file exists.
    'First see if it's in an archive:
    On Error GoTo errcatch
    file$ = filename$
    num = FreeFile
    Open file$ For Input As #num
    Close #num
    If anerror = 1 Then fileExist = 0 Else fileExist = 1
    Exit Function

errcatch:
anerror = 1
Resume Next
End Function

Sub icons ()
    'put icons on desktop
    res = InstallFile("rpgtoo~1.lnk", "c:\windows\desktop\Toolkit2.lnk")
    res = InstallFile("rpgtoo~2.lnk", "c:\windows\desktop\Trans2.lnk")
End Sub

Function InstallFile (src$, dest$)
    'Copies a file if it doesn't exist
    ex = fileExist(dest$)
    If ex = 0 Then
        'File doesn't exist- copy it!
        FileCopy src$, dest$
    End If
    InstallFile = 0
End Function

Sub installFiles ()
    'runs the self-extracting exe
    a = Shell("tktzip " + destdir$ + " -d -o")
End Sub

Sub installRunTime ()
    'Installs run time files.
    res = InstallFile("vbrun300.dll", winsys$ + "vbrun300.dll")
    res = InstallFile("cmdialog.vbx", winsys$ + "cmdialog.vbx")
    res = InstallFile("compobj.dll", winsys$ + "compobj.dll")
    res = InstallFile("msole2.vbx", winsys$ + "msole2.vbx")
    res = InstallFile("msolevbx.dll", winsys$ + "msolevbx.dll")
    res = InstallFile("ole2.reg", winsys$ + "ole2.reg")
    res = InstallFile("ole2.dll", winsys$ + "ole2.dll")
    res = InstallFile("ole2conv.dll", winsys$ + "ole2conv.dll")
    res = InstallFile("ole2disp.dll", winsys$ + "ole2disp.dll")
    res = InstallFile("ole2nls.dll", winsys$ + "ole2nls.dll")
    res = InstallFile("ole2prox.dll", winsys$ + "ole2prox.dll")
    res = InstallFile("storage.dll", winsys$ + "storage.dll")
    res = InstallFile("vboa300.dll", winsys$ + "vboa300.dll")
End Sub

Function removechar (Text$, char$)
'remove char from text
length = Len(Text$)
For p = 1 To length
    part$ = Mid$(Text$, p, 1)
    If part$ <> char$ Then ret$ = ret$ + part$
Next p
removechar = ret$
End Function

Function resolve (dfile$)
    'Resolves a directory (puts it in order)
    d$ = dfile$
    d$ = removechar(d$, " ")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ <> "\" Then d$ = d$ + "\"
    resolve = d$
End Function

Function unresolve (dfile$)
    'Resolves a directory (puts it in order)
    d$ = dfile$
    d$ = removechar(d$, " ")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ = "\" Then d$ = Mid$(d$, 1, length - 1)
    unresolve = d$
End Function

