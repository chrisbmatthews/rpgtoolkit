Attribute VB_Name = "MODULE11"
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long

'for supporting libraries...
Public CurrentVersion As String
Public gGameState As Long
Public gPrevGameState As Long
Public m_LangFile As String
Public Const GS_IDLE = 0    'just re-renders the screen
Public Const GS_QUIT = 1    'shutdown sequence
Public Const GS_MOVEMENT = 2    'movement is occurring (players or items)
Public Const GS_DONEMOVE = 3    'movement is finished
Public Const GS_PAUSE = 4   'pause game

'global Const registered = 1
Global registered
Global Const Major = 2
Global Const minor = 0

Global winsys$      'windows system directory
Global destdir$     'destination dir
Global defaultdir$
Global sideBarImage As String   'sidebar image
Global modified

Global currentdir$  'currentdirectory

Global temppath$            'temporary path
Global zippath$             'pkzip path
Global tilepath$            'Tile dir path
Global brdpath$             'board dir path
Global tempath$             'character dir path
Global arcpath$             'archive dir path
Global spcpath$             'special move dir
Global bkgpath$             'board background dir
Global mediapath$           'media files
Global prgpath$             'prg files
Global fontpath$            'font files
Global itmpath$             'item path
Global enepath$             'enemy path
Global gampath$             'main file path
Global bmppath$             'bmp files
Global statuspath$          'status effect path
Global miscpath$            'misc files
Global savpath$             'saved games
Global pluginPath$          'plugins
Global resourcePath$        'lang files

Global fileChosen$  'file of the game (main file or other)

Global mainMem As TKMain    'main file

'Main File editor
Global projectPath$

Function toString(val) As String
    On Error Resume Next
    toString = str$(val)
    toString = removechar(toString, " ")
End Function


Sub EndGame()

End Sub

Sub HandleError()

End Sub


Function PakLocate(file$) As String
    PakLocate = file$
End Function


Sub testZIPdll()
    On Error GoTo badness
    a = ZIPTest()
    Exit Sub
    
badness:
    MsgBox "Error:  Could not initialize tkzip.dll!  Quitting..."
    End
End Sub

Sub copyDirs()
    'copy all directories into temp
    On Error Resume Next
    src$ = destdir$

    'bitmaps in root
    'aa$ = src$
    'bb$ = temppath$
    'vv$ = Dir$(aa$ + "*.bmp")
    'FileCopy aa$ + vv$, bb$ + vv$
    'Do While vv$ <> ""
    '    vv$ = Dir$
    '    FileCopy aa$ + vv$, bb$ + vv$
    'Loop

    ex$ = GetExt(fileChosen$)

    If UCase$(ex$) = "GAM" Then
        '\tiles\
        aa$ = src$ + tilepath$
        bb$ = temppath$ + tilepath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\board\
        aa$ = src$ + brdpath$
        bb$ = temppath$ + brdpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\chars\
        aa$ = src$ + tempath$
        bb$ = temppath$ + tempath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\archives\
        'aa$ = src$ + arcpath$
        'bb$ = temppath$ + arcpath$
        'vv$ = Dir$(aa$ + "*.*")
        'FileCopy aa$ + vv$, bb$ + vv$
        'Do While vv$ <> ""
        '    vv$ = Dir$
        '    FileCopy aa$ + vv$, bb$ + vv$
        'Loop
    
        '\spc\
        aa$ = src$ + spcpath$
        bb$ = temppath$ + spcpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\bkg\
        aa$ = src$ + bkgpath$
        bb$ = temppath$ + bkgpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\media\
        aa$ = src$ + mediapath$
        bb$ = temppath$ + mediapath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\prg\
        aa$ = src$ + prgpath$
        bb$ = temppath$ + prgpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\font\
        aa$ = src$ + fontpath$
        bb$ = temppath$ + fontpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\items\
        aa$ = src$ + itmpath$
        bb$ = temppath$ + itmpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\enemies\
        aa$ = src$ + enepath$
        bb$ = temppath$ + enepath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\main\
        aa$ = src$ + gampath$
        bb$ = temppath$ + gampath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\bitmap\
        aa$ = src$ + bmppath$
        bb$ = temppath$ + bmppath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\statusE\
        aa$ = src$ + statuspath$
        bb$ = temppath$ + statuspath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\Misc\
        aa$ = src$ + miscpath$
        bb$ = temppath$ + miscpath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    
        '\Plugin\
        aa$ = src$ + pluginPath$
        bb$ = temppath$ + pluginPath$
        vv$ = Dir$(aa$ + "*.*")
        FileCopy aa$ + vv$, bb$ + vv$
        Do While vv$ <> ""
            vv$ = Dir$
            FileCopy aa$ + vv$, bb$ + vv$
        Loop
    Else
        If UCase$(ex$) = "EXE" Then
            FileCopy fileChosen$, temppath$ + RemovePath(fileChosen$)
        Else
            'tpk
            FileCopy fileChosen$, temppath$ + gampath$ + RemovePath(fileChosen$)
        End If
    End If
        
    '\Resources\
    aa$ = src$ + resourcePath$
    bb$ = temppath$ + resourcePath$
    vv$ = Dir$(aa$ + "*.lng")
    FileCopy aa$ + vv$, bb$ + vv$
    Do While vv$ <> ""
        vv$ = Dir$
        FileCopy aa$ + vv$, bb$ + vv$
    Loop

End Sub

Sub copyProgramFiles()
    'required program files...
    On Error Resume Next
    ChDir (App.Path)
    'ChDir (destdir$)
    src$ = destdir$

    ex$ = GetExt(fileChosen$)
    If UCase$(ex$) <> "EXE" Then
        'trans2.exe
        aa$ = src$ + "trans3.exe"
        bb$ = temppath$ + "trans3.exe"
        FileCopy aa$, bb$
    End If

    'actkrt3.dll
    aa$ = src$ + "actkrt3.dll"
    bb$ = temppath$ + "actkrt3.dll"
    FileCopy aa$, bb$
    
    'freeimage.dll
    aa$ = src$ + "freeimage.dll"
    bb$ = temppath$ + "freeimage.dll"
    FileCopy aa$, bb$

    'audiere.dll
    aa$ = src$ + "audiere.dll"
    bb$ = temppath$ + "audiere.dll"
    FileCopy aa$, bb$
    
    'eula.txt
    aa$ = src$ + "eula.txt"
    bb$ = temppath$ + "eula.txt"
    FileCopy aa$, bb$

    'base.fnt
    aa$ = src$ + "base.fnt"
    bb$ = temppath$ + "base.fnt"
    FileCopy aa$, bb$

    'ver.ver
    aa$ = src$ + "ver.ver"
    bb$ = temppath$ + "ver.ver"
    FileCopy aa$, bb$
    
    'reg.reg
    aa$ = src$ + "reg.reg"
    bb$ = temppath$ + "reg.reg"
    FileCopy aa$, bb$
    
    'msimg32.dll
    aa$ = src$ + "msimg32.dll"
    bb$ = temppath$ + "msimg32.dll"
    FileCopy aa$, bb$

    'mscomctl.ocx
    aa$ = src$ + "mscomctl.ocx"
    bb$ = temppath$ + "mscomctl.ocx"
    FileCopy aa$, bb$

    'tabctl32.ocx
    aa$ = src$ + "tabctl32.ocx"
    bb$ = temppath$ + "tabctl32.ocx"
    FileCopy aa$, bb$

End Sub

Sub copyRunTime()
    'Installs run time files into temp
On Error Resume Next
    ChDir (App.Path)
    
    If FileExists(destdir$ + "ctl3d32.dll") Then
        res = InstallFile(destdir$ + "ctl3d32.dll", temppath$ + "ctl3d32.dll")
    Else
        res = InstallFile(winsys$ + "ctl3d32.dll", temppath$ + "ctl3d32.dll")
    End If
    
    If FileExists(destdir$ + "picclp32.ocx") Then
        res = InstallFile(destdir$ + "picclp32.ocx", temppath$ + "picclp32.ocx")
    Else
        res = InstallFile(winsys$ + "picclp32.ocx", temppath$ + "picclp32.ocx")
    End If
    
    'If FileExists(destdir$ + "bw6mp24b.ocx") Then
    '    res = InstallFile(destdir$ + "bw6mp24b.ocx", temppath$ + "bw6mp24b.ocx")
    'Else
    '    res = InstallFile(winsys$ + "bw6mp24b.ocx", temppath$ + "bw6mp24b.ocx")
    'End If
    
    '2.20
    If FileExists(destdir$ + "mci32.ocx") Then
        res = InstallFile(destdir$ + "mci32.ocx", temppath$ + "mci32.ocx")
    Else
        res = InstallFile(winsys$ + "mci32.ocx", temppath$ + "mci32.ocx")
    End If
    
    If FileExists(destdir$ + "VBRun60sp5.exe") Then
        res = InstallFile(destdir$ + "VBRun60sp5.exe", temppath$ + "VBRun60sp5.exe")
    Else
        res = InstallFile(winsys$ + "VBRun60sp5.exe", temppath$ + "VBRun60sp5.exe")
    End If
    
    If FileExists(destdir$ + "vb5stkit.dll") Then
        res = InstallFile(destdir$ + "vb5stkit.dll", temppath$ + "vb5stkit.dll")
    Else
        res = InstallFile(winsys$ + "vb5stkit.dll", temppath$ + "vb5stkit.dll")
    End If
    
    '3.0
   
End Sub

Sub copyToTemp()
    'copies all required files to temp dir.

    Call copyProgramFiles
    Call copyDirs
End Sub

Sub createInfoFile()
    'creats setup info file.
    num = FreeFile
    Open temppath$ + "setup.inf" For Output As #num
        Print #num, mainMem.gameTitle$
        Print #num, defaultdir$
        Print #num, RemovePath(sideBarImage)
        'Print #num, "msvbvm60.dll"
        'Print #num, "oleaut32.dll"
        'Print #num, "olepro32.dll"
        'Print #num, "asycfilt.dll"
        Print #num, "ctl3d32.dll"
        'Print #num, "comcat.dll"
        
        '2.20
        'Print #num, "comdlg32.ocx"
        
        Print #num, "picclp32.ocx"
        'Print #num, "dialog.ocx"
        'Print #num, "npmod32.dll"
        'Print #num, "bw6mp24b.ocx"
        Print #num, "mci32.ocx"
    Close #num

    Open temppath$ + "setup2.inf" For Output As #num
        Print #num, mainMem.gameTitle$
        If UCase$(GetExt(fileChosen$)) = "EXE" Then
            Print #num, RemovePath(fileChosen$)
        Else
            Print #num, "trans3.exe" '+ RemovePath(fileChosen$)
        End If
        Print #num, mainMem.gameTitle$
        Print #num, RemovePath(fileChosen$)
    Close #num
End Sub

Sub createNewTemp()
On Error Resume Next
'create temporary directories...
currentdir$ = CurDir$

temppath$ = destdir$ + "Temp\"
aa$ = temppath$
MkDir Mid$(aa$, 1, Len(aa$) - 1)

'copy the zip.exe program to temp...
FileCopy App.Path + "\" + "zip.zip", temppath$ + "zip.zip"
'FileCopy destdir$ + "\" + "zip.exe", temppath$ + "zip.exe"

'delete zip.exe from the app path...
Kill App.Path + "\" + "zip.zip"
'Kill destdir$ + "\" + "zip.exe"

'copy the setup program into temp...
FileCopy App.Path + "\setup.exe", temppath$ + "setup.exe"
'FileCopy destdir$ + "\setup.exe", temppath$ + "setup.exe"
'copy the setup program into temp...
FileCopy App.Path + "\phase2.exe", temppath$ + "phase2.exe"
'FileCopy destdir$ + "\phase2.exe", temppath$ + "phase2.exe"

'copy the zip dll into temp...
FileCopy App.Path + "\tkzip.dll", temppath$ + "tkzip.dll"

'copy the sidebar image into temp...
FileCopy sideBarImage, temppath$ + RemovePath(sideBarImage)

Call createInfoFile

'copy eula.txt...
FileCopy App.Path + "\eula.txt", temppath$ + "eula.txt"
'FileCopy destdir$ + "\eula.txt", temppath$ + "eula.txt"

'now copy system files into temp:
Call copyRunTime
End Sub

Sub createTemp()
On Error Resume Next
'create temporary directories...
currentdir$ = CurDir$

zippath$ = "Zip\"

temppath$ = destdir$ + "Temp\"
aa$ = temppath$
MkDir Mid$(aa$, 1, Len(aa$) - 1)

ex$ = GetExt(fileChosen$)

If UCase$(ex$) = "GAM" Then
    gamepath$ = "Game\"        'Tile dir path
    aa$ = temppath$ + gamepath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    aa$ = temppath$ + projectPath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    tilepath$ = projectPath$ + "Tiles\"        'Tile dir path
    aa$ = temppath$ + tilepath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    brdpath$ = projectPath$ + "Boards\"          'board dir path
    aa$ = temppath$ + brdpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    tempath$ = projectPath$ + "Chrs\"          'character dir path
    aa$ = temppath$ + tempath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    'arcpath$ = "Archives\"           'archive dir path
    'aa$ = temppath$ + arcpath$
    'MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    spcpath$ = projectPath$ + "SpcMove\"      'spc move path
    aa$ = temppath$ + spcpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    bkgpath$ = projectPath$ + "Bkrounds\"      'bkg path
    aa$ = temppath$ + bkgpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    mediapath$ = projectPath$ + "Media\"      'media path
    aa$ = temppath$ + mediapath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    prgpath$ = projectPath$ + "Prg\"      'prg path
    aa$ = temppath$ + prgpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    fontpath$ = projectPath$ + "Font\"    'Font path
    aa$ = temppath$ + fontpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    itmpath$ = projectPath$ + "Item\"    'Item path
    aa$ = temppath$ + itmpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    enepath$ = projectPath$ + "Enemy\"    'enemy path
    aa$ = temppath$ + enepath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
       
    bmppath$ = projectPath$ + "Bitmap\"    'bmp file path
    aa$ = temppath$ + bmppath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    statuspath$ = projectPath$ + "StatusE\"    'status file path
    aa$ = temppath$ + statuspath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
    
    miscpath$ = projectPath$ + "Misc\"    'status file path
    aa$ = temppath$ + miscpath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)

    pluginPath$ = projectPath$ + "Plugin\"    'status file path
    aa$ = temppath$ + pluginPath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
End If

If UCase$(ex$) = "GAM" Or UCase$(ex$) = "TPK" Then
    gampath$ = "Main\"    'main file path
    aa$ = temppath$ + gampath$
    MkDir Mid$(aa$, 1, Len(aa$) - 1)
End If

resourcePath$ = "Resources\"    'lang files
aa$ = temppath$ + resourcePath$
MkDir Mid$(aa$, 1, Len(aa$) - 1)

End Sub

Sub createZip(destfile$)
    'create a zip file from the temp dir.
    'comm$ = zippath$ + "pkzip25 -add -max " + destfile$ + " " + App.Path + "\" + temppath$ + "*.*"
    'a = Shell(comm$, 1)
    'MsgBox "Please Wait for the MS-DOS window to be finished before hitting OK!"
    cd$ = CurDir$()
    ChDir (temppath$)
    Call AddDir(destfile$, True, False)
    ChDir (cd$)
End Sub

Function fileExist(Filename$)
    'Function checks if a file exists.
    'First see if it's in an archive:
    On Error GoTo errcatch
    file$ = Filename$
    num = FreeFile
    Open file$ For Input As #num
    Close #num
    If anerror = 1 Then fileExist = 0 Else fileExist = 1
    Exit Function

errcatch:
anerror = 1
Resume Next
End Function

Sub findZip()
    a = fileExist(CurDir$ + "\" + zippath$ + "pkzip25.exe")
    If a = 0 Then
        MsgBox "Error:  The file 'pkzip25.exe' could not be found.  For legal reasons, this file cannot be distributed directly with the Toolkit.  However, you may download pkzip at Awesome Software Online (http://www.rpgtoolkit.com).  Install the files into your \Toolkit2\Zip\ directory."
        End
    End If
End Sub

Function getDest()
    'get a filename
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strSelectedFile = ""
    dlg.strTitle = "File to save"
    dlg.strDefaultFolder = currentdir$
    dlg.strDefaultExt = "zip"
    dlg.strFileTypes = "Zip Compressed (*.zip)|*.zip|All files(*.*)|*.*"
    If SaveFileDialog(dlg) Then
        Filename$ = dlg.strSelectedFile
        antipath$ = dlg.strSelectedFileNoPath
    Else
        Filename$ = ""
    End If
    ChDir (currentdir$)
    
    'If Filename$ = "" Then Exit Function
    getDest = Filename$
End Function

Sub icons()
    'put icons on desktop
    res = InstallFile("rpgtoo~1.lnk", "c:\windows\desktop\Toolkit2.lnk")
    res = InstallFile("rpgtoo~2.lnk", "c:\windows\desktop\Trans2.lnk")
End Sub

Function InstallFile(src$, dest$)
    'Copies a file if it doesn't exist
    ex = fileExist(dest$)
    If ex = 0 Then
        'File doesn't exist- copy it!
        FileCopy src$, dest$
    End If
    InstallFile = 0
End Function

Sub installFiles()
    'runs the self-extracting exe
    a = Shell("tktzip " + destdir$ + " -d -o")
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

Sub removeTemp()
    'removes temp directory.
    'kill subdirectories:
    On Error Resume Next
    
    aa$ = temppath$ + tilepath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + brdpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + tempath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + arcpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + spcpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + bkgpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + mediapath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + fontpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + prgpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + itmpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + enepath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + gampath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + bmppath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + savpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + statuspath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + miscpath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + pluginPath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    aa$ = temppath$ + resourcePath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)

    RmDir (temppath$ + projectPath$)
    RmDir (temppath$ + "game\")

    aa$ = temppath$
    Kill aa$ + "*.*"
    aa$ = Mid$(aa$, 1, Len(aa$) - 1)
    RmDir (aa$)
    
End Sub

Function resolve(dfile$)
    'Resolves a directory (puts it in order)
    d$ = dfile$
    'd$ = removechar(d$, " ")
    length = Len(d$)
    part$ = Mid$(d$, length, 1)
    If part$ <> "\" Then d$ = d$ + "\"
    resolve = d$
End Function

Sub setup(destfile$)
    'set up the file.
    MsgBox "Setup will now copy and compress your files.  This may take a few minutes."
    Call createTemp
    'MsgBox "temp created"
    Call copyToTemp
    'MsgBox "copied to temp"
    'a = Shell(App.Path + "\zipup.bat", 1)
    'MsgBox "Please wait until the MS-DOS window reads 'Finished', and then hit OK to continue"
    
    cd$ = CurDir$()
    ChDir ("temp\")
    Call AddDir("..\zip.zip", True, False)
    ChDir (cd$)
    
    Call removeTemp
    Call createNewTemp  'create the new temp dir with system files.
    'Finally... now zip up and make our final file.
    Call createZip(destfile$)
    Call removeTemp
    MsgBox "All Done!!!"
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

