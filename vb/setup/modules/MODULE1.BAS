Attribute VB_Name = "MODULE11"
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Global winsys$      'windows system director
Global destdir$     'destination dir
Global modified

'stuff in setup.inf
Global title$           'title of project
Global defaultdir$      'default install dir
Global smallImage As String 'image to put in panel
Global runtime$(50)     'run time files.
Global countRT      '#of run time

'stuff in setup2.inf
'this file holds info about creating shortcuts
Global startMenuGroup As String         'group for start menu icons
Global shortCutTargets(50) As String    'targets of files
Global shortCutLabels(50) As String     'labels for the shortcuts
Global shortCutArgs(50) As String     'command line args for shortcuts
Global countSC As Long          '# of shortcuts


Global yes          'clicked yes
Global yestoall     'yes to all (1 is affirm)
Global no           'clicked no
Global notoall      'clicked no to all
Global prompttext$

'Global registered   'registered y/n

Global mypath$





Sub CreateDir(ByVal newdir$)
    On Error Resume Next
    l = Len(newdir$)
    For t = 1 To l
        part$ = Mid$(newdir$, t, 1)
        sofar$ = sofar$ + part$
        If part$ = "/" Or part$ = "\" Then
            MkDir (sofar$)
        End If
    Next t
    MkDir (newdir$)
End Sub


Sub createTkr(tcode$, tname$)
    'creats tkr.tkr file in c:\windows\system and c:\toolkit2
    On Error GoTo ern
    num = FreeFile
    Open SystemDir + "tkr.tkr" For Output As #num
        Print #num, tcode$
        Print #num, tname$
    Close #num

    Open destdir$ + "tkr.tkr" For Output As #num
        Print #num, tcode$
        Print #num, tname$
    Close #num

    Exit Sub
ern:
    MsgBox "An error writing tkr.tkr occurred."
    End
End Sub


Function fileExist(filename$)
    'Function checks if a file exists.
    'First see if it's in an archive:
On Error GoTo errcatch
    anerror = 0
    File$ = filename$
    num = FreeFile
    Open File$ For Input As #num
    Close #num
    If anerror = 1 Then fileExist = 0 Else fileExist = 1
    Exit Function

errcatch:
anerror = 1
Resume Next
End Function

Sub icons()
    'create shortcuts...
    On Error Resume Next
    If startMenuGroup <> "" Then
        startmnu = StartMenuDir()
        Call CreateDir(startmnu + startMenuGroup)
        
        'now create icons...
        For t = 0 To countSC
            Call MakeShortcut(destdir$ + shortCutTargets(t), shortCutArgs(t), startMenuGroup + "\" + shortCutLabels(t))
        Next t
    End If
End Sub

Function InstallFile(src$, dest$)
    'Copies a file if it doesn't exist
    On Error Resume Next
    
    'force 'no to all'
    'relocates all system files into toolkit2
    FileCopy mypath$ + src$, destdir$ + src$
    
    'register ocx files
    If UCase$(GetExt(src$)) = "OCX" Then
        Call ExecCmd("regsvr32 /s " + Chr$(34) + destdir$ + src$ + Chr$(34))
    End If
    
    InstallFile = 0
    Exit Function
    
    
    ex = fileExist(dest$)
    If ex = 0 Then
       'File doesn't exist- copy it!
       FileCopy mypath$ + src$, dest$
    Else
        If yestoall = 1 Then
            FileCopy mypath$ + src$, dest$
            InstallFile = 0
            Exit Function
        End If
        
        If notoall = 1 Then
            'user clicked no to all...
            'relocate the file into c:\toolkit2...
            FileCopy mypath$ + src$, destdir$ + src$
            InstallFile = 0
            Exit Function
        End If
        
        'it exists- prompt user
        yes = 0: no = 0: yestoall = 0
        prompttext$ = "The file " + src$ + " already exists on your system.  It may be an outdated version.  You may choose not to re-install the file.  If you do not re-install, and the software produces strange errors, run setup again and choose to overwrite this file.  Setup will automatically reloacte the file into your installation folder if you select No."
        fileexists.Show 1   'show form modal
        If yes = 1 Or yestoall = 1 Then
            FileCopy mypath$ + src$, dest$
            InstallFile = 0
            Exit Function
        Else
            'user clicked no or no to all...
            'relocate the file into c:\toolkit2...
            FileCopy mypath$ + src$, destdir$ + src$
            InstallFile = 0
            Exit Function
        End If
    End If
    InstallFile = 0
End Function

Sub installFiles()
    'runs the self-extracting exe
    td$ = TempDir
    'a = Shell(App.Path + "\zip " + destdir$ + " -directories -overwrite", 1)
    'a = ExecCmd(CurDir$ + "zip " + destdir$ + " -directories -overwrite")
    'MsgBox mypath$ + "zip.exe " + destdir$ + " -directories -overwrite"
    'a = ExecCmd(mypath$ + "zip.exe " + destdir$ + " -directories -overwrite")
    
    Call ExtractDir("zip.zip", destdir$)
    setup.ZOrder
    setupform.ZOrder
End Sub

Sub installRunTime()
    'Installs run time files.
    For t = 0 To countRT
        If UCase$(runtime$(t)) = "VBRUN60.EXE" Then
            Call FileCopy(mypath$ + "VBRun60.exe", destdir$ + "VBRun60.exe")
        Else
            res = InstallFile(runtime$(t), winsys$ + runtime$(t))
        End If
    Next t
    'res = InstallFile("msvbvm50.dll", winsys$ + "msvbvm50.dll")
    'res = InstallFile("stdole2.tlb", winsys$ + "stdole2.tlb")
    'res = InstallFile("oleaut32.dll", winsys$ + "oleaut32.dll")
    'res = InstallFile("olepro32.dll", winsys$ + "olepro32.dll")
    'res = InstallFile("asycfilt.dll", winsys$ + "asycfilt.dll")
    'res = InstallFile("ctl3d32.dll", winsys$ + "ctl3d32.dll")
    'res = InstallFile("comcat.dll", winsys$ + "comcat.dll")
    'res = InstallFile("comdlg32.ocx", winsys$ + "comdlg32.ocx")
    'res = InstallFile("picclp32.ocx", winsys$ + "picclp32.ocx")
End Sub

Sub openInf()
    'opens info file for info
    countRT = 0
    countSC = 0
    On Error GoTo infer
    num = FreeFile
    'MsgBox mypath$
    'Open CurDir$ + "setup.inf" For Input As #num
    'SETUP.INF
    Open mypath$ + "setup.inf" For Input As #num
        Line Input #num, title$
        Line Input #num, defaultdir$
        Line Input #num, smallImage
        Do While Not EOF(num)
            Line Input #num, runtime$(countRT)
            countRT = countRT + 1
        Loop
        countRT = countRT - 1
    Close #num
    destdir$ = defaultdir$
    
    'SETUP2.INF
    Open mypath$ + "setup2.inf" For Input As #num
        Line Input #num, startMenuGroup
        Do While Not EOF(num)
            Line Input #num, shortCutTargets(countSC)
            Line Input #num, shortCutLabels(countSC)
            Line Input #num, shortCutArgs(countSC)
            countSC = countSC + 1
        Loop
        countSC = countSC - 1
    Close #num
    
    Exit Sub
infer:
    MsgBox "Could not open setup.inf or setup2.inf!!!"
    End
End Sub

Function removechar(text$, char$)
'remove char from text
length = Len(text$)
For p = 1 To length
    part$ = Mid$(text$, p, 1)
    If part$ <> char$ Then ret$ = ret$ + part$
Next p
removechar = ret$
End Function

Function resolve(dfile$)
    'Resolves a directory (puts it in order)
    d$ = dfile$
    'd$ = removechar(d$, " ")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ <> "\" Then d$ = d$ + "\"
    resolve = d$
End Function

Sub runSetup()
    'run the setup procedure
    Call installRunTime
    Call installFiles
    Call icons
    'If modified = 0 Or UCase$(destdir$) = UCase$(defaultdir$) Then Call icons
    MsgBox "Setup Complete!!!", , "Setup:"
    End
End Sub

Sub testZIPdll()
    On Error GoTo badness
    
    a = ZIPTest()
    Exit Sub

badness:
    MsgBox "Could not initialise tkzip.dll.  Try opening zip.zip and install manually"
    End
End Sub

Function unresolve(dfile$)
    'Resolves a directory (puts it in order)
    d$ = dfile$
    d$ = removechar(d$, " ")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ = "\" Then d$ = Mid$(d$, 1, length - 1)
    unresolve = d$
End Function

