Attribute VB_Name = "Commontkzip"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'requires statusbar.frm

'interface with tkzip.dll
Option Explicit

'zip file subsystem
'may 17, 2001
Declare Function ZIPTest Lib "actkrt3.dll" () As Long

Declare Function ZIPCreate Lib "actkrt3.dll" (ByVal fileCreate As String, ByVal TackOntoEndYN As Long) As Long

Declare Function ZIPCloseNew Lib "actkrt3.dll" () As Long

Declare Function ZIPAdd Lib "actkrt3.dll" (ByVal fileToAdd As String, ByVal fileAddAs As String) As Long

Declare Function ZIPOpen Lib "actkrt3.dll" (ByVal fileOpen As String) As Long

Declare Function ZIPClose Lib "actkrt3.dll" () As Long

Declare Function ZIPExtract Lib "actkrt3.dll" (ByVal fileToExtract As String, ByVal SaveAs As String) As Long

Declare Function ZIPGetFileCount Lib "actkrt3.dll" () As Long

Declare Function ZIPGetFile Lib "actkrt3.dll" (ByVal fileNum As Long, ByVal fileout As String) As Long

Declare Function ZIPFileExist Lib "actkrt3.dll" (ByVal fileToCheck As String) As Long

Declare Function ZIPCreateCompoundFile Lib "actkrt3.dll" (ByVal originalFile As String, ByVal extendFile As String) As Long

Declare Function ZIPIsCompoundFile Lib "actkrt3.dll" (ByVal file As String) As Long

Declare Function ZIPExtractCompoundFile Lib "actkrt3.dll" (ByVal pstrOrigFile As String, ByVal pstrSaveTo As String) As Long

Global PakFileMounted As String     'filename of the pakfile we have mounted.
Global PakFileRunning As Boolean    'have we mounted a pakfile?  is the game running from the pakfile?
Global PakTempPath As String        'temp file path

Sub CreatePakFile(file As String)
    'creates a pakfile from the currently loaded project.
    
    Dim numFiles As Integer
    
    numFiles = CountProjectFiles()
    If numFiles = 0 Then Exit Sub
    
    statusbar.Show

    'determine iof we're adding to end of a file...
    Dim v As Long, count As Long, l As Long, p As Long, a As String

    If fileExists(file) Then Kill file

    If fileExists(file) Then
        'create tpk file (really just a zip file...)
        v = ZIPCreate(file, 1)
    Else
        'create tpk file (really just a zip file...)
        v = ZIPCreate(file, 0)
    End If

    'now add the files to the pakfile...

    count = 0
    'first add the mainForm file...
    l = ZIPAdd(gamPath$ + mainfile$, "main.gam")
    count = count + 1
    p = Int(count / numFiles * 100)
    Call statusbar.setStatus(p, "Adding main.gam")

    'Dim ocd As String
    'ocd = CurDir
    'ChDir projectPath
    'AddDirRecurse "", "", True, numFiles, 0
    'ChDir ocd

    'tile dir...
    a$ = Dir$(projectPath$ + tilePath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + tilePath$ + a$, tilePath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'board dir...
    a$ = Dir$(projectPath$ + brdPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + brdPath$ + a$, brdPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
   
    'char dir...
    a$ = Dir$(projectPath$ + temPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + temPath$ + a$, temPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
   
    'spc dir...
    a$ = Dir$(projectPath$ + spcPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + spcPath$ + a$, spcPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'bkg dir...
    a$ = Dir$(projectPath$ + bkgPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + bkgPath$ + a$, bkgPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'media dir...
    a$ = Dir$(projectPath$ + mediaPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + mediaPath$ + a$, mediaPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'prg dir...
    a$ = Dir$(projectPath$ + prgPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + prgPath$ + a$, prgPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'font dir...
    a$ = Dir$(projectPath$ + fontPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + fontPath$ + a$, fontPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'item dir...
    a$ = Dir$(projectPath$ + itmPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + itmPath$ + a$, itmPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'ene dir...
    a$ = Dir$(projectPath$ + enePath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + enePath$ + a$, enePath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'bmp dir...
    a$ = Dir$(projectPath$ + bmpPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + bmpPath$ + a$, bmpPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'status dir...
    a$ = Dir$(projectPath$ + statusPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + statusPath$ + a$, statusPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'misc dir...
    a$ = Dir$(projectPath$ + miscPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + miscPath$ + a$, miscPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
     
    'plugin dir...
    a$ = Dir$(projectPath$ + plugPath$ + "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath$ + plugPath$ + a$, plugPath$ + a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
     
    a = ZIPCloseNew()
    Unload statusbar
End Sub

Function PAKTestSystem() As Boolean
    'test pakfile system
    On Error GoTo pakerr
    
    Dim a As Long
    a = ZIPTest()
    PAKTestSystem = True
    Exit Function
    
pakerr:
    MsgBox "The file tkzip.dll could not be initialised.  You likely need to download the MFC runtimes.  You can get then at http://rpgtoolkit.com"
    PAKTestSystem = False
End Function

Function CountProjectFiles() As Integer
    On Error GoTo ErrorHandler
    'returns the total number of files in the project
    Dim count As Long, a As String
    count = 1 'the mainForm file counts as 1
    
    'count stuff in tiles dir...
    a$ = Dir$(projectPath$ + tilePath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in board dir...
    a$ = Dir$(projectPath$ + brdPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in character dir...
    a$ = Dir$(projectPath$ + temPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in spc dir...
    a$ = Dir$(projectPath$ + spcPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bkg dir...
    a$ = Dir$(projectPath$ + bkgPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in media dir...
    a$ = Dir$(projectPath$ + mediaPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in prg dir...
    a$ = Dir$(projectPath$ + prgPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in font dir...
    a$ = Dir$(projectPath$ + fontPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in item dir...
    a$ = Dir$(projectPath$ + itmPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in enemy dir...
    a$ = Dir$(projectPath$ + enePath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bmp dir...
    a$ = Dir$(projectPath$ + bmpPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in ststuas dir...
    a$ = Dir$(projectPath$ + statusPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in misc dir...
    a$ = Dir$(projectPath$ + miscPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in plugindir...
    a$ = Dir$(projectPath$ + plugPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    CountProjectFiles = count

    Exit Function
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next

End Function


Sub CreatePakTemp()
    On Error Resume Next
    'create a temp dir for the cached pak file files...
    Dim wintemp As String
    wintemp$ = TempDir()
    PakTempPath$ = wintemp$ + "TKCACHE\"
    projectPath$ = "" 'PakTempPath$
    
    'create the temp folder...
    MkDir (PakTempPath$)
    'now create the game subfolders...

    MkDir PakTempPath$ + tilePath$
    MkDir PakTempPath$ + brdPath$
    MkDir PakTempPath$ + temPath$
    MkDir PakTempPath$ + spcPath$
    MkDir PakTempPath$ + bkgPath$
    MkDir PakTempPath$ + mediaPath$
    MkDir PakTempPath$ + prgPath$
    MkDir PakTempPath$ + fontPath$
    MkDir PakTempPath$ + itmPath$
    MkDir PakTempPath$ + enePath$
    MkDir PakTempPath$ + statusPath$
    MkDir PakTempPath$ + bmpPath$
    MkDir PakTempPath$ + miscPath$
    MkDir PakTempPath$ + plugPath$

End Sub


Sub DeletePakTemp()
    On Error Resume Next
    
    Dim wintemp As String
    'delete the pak temp file...
    If PakTempPath$ = "" Then
        wintemp$ = TempDir()
        PakTempPath$ = wintemp$ + "TKCACHE\"
        projectPath$ = PakTempPath$
    End If

    'create the temp folder...
    'MkDir (PakTempPath$)
    'now create the game subfolders...

    Call deletePath(PakTempPath$ + tilePath$)
    Call deletePath(PakTempPath$ + brdPath$)
    Call deletePath(PakTempPath$ + temPath$)
    Call deletePath(PakTempPath$ + spcPath$)
    Call deletePath(PakTempPath$ + bkgPath$)
    Call deletePath(PakTempPath$ + mediaPath$)
    Call deletePath(PakTempPath$ + prgPath$)
    Call deletePath(PakTempPath$ + fontPath$)
    Call deletePath(PakTempPath$ + itmPath$)
    Call deletePath(PakTempPath$ + enePath$)
    Call deletePath(PakTempPath$ + statusPath$)
    Call deletePath(PakTempPath$ + bmpPath$)
    Call deletePath(PakTempPath$ + miscPath$)
    Call deletePath(PakTempPath$ + plugPath$)

    Call deletePath(PakTempPath$)
    PakTempPath$ = ""
End Sub

Sub deletePath(path As String)
    'deletes all files in a path and then kills the path.
    On Error Resume Next
    
    'count stuff in tiles dir...
    Dim a As String
    a$ = Dir$(path + "*.*")
    Do While a$ <> ""
        Kill path + a$
        a$ = Dir$
    Loop
    
    RmDir path
End Sub

Function IsAPakFile(file As String) As Boolean
    'determines if a passed in file (particularly an exe)
    'contains a pakfile at the tail end of it...
    On Error Resume Next
    
    Dim a As Long
    a = ZIPIsCompoundFile(file)
    
    If a = 1 Then
        IsAPakFile = True
    Else
        IsAPakFile = False
    End If
End Function

Function PakLocate(file As String) As String
    On Error GoTo ErrorHandler
    
    If Not (PakFileRunning) Then
        'hup!  we're not even mounted onto a pakfile!
        '(we're running straight off the disk)
        PakLocate = file
        Exit Function
    End If
            
    'first, look for the file in the cache.
    'if it;s found in the cache, return it's location.
    'else, obtain it from the pakfile, put it in the cache and
    'return its location
    
    If fileExists(PakTempPath + file) Then
        PakLocate = PakTempPath + file
    Else
        'a = PAKFileExist(file, PakFileMounted)
        'If a = 1 Then
            Dim b As Long
            b = ZIPExtract(file, PakTempPath + file)
            'MsgBox "extracting " + file + " to " + PakTempPath + file + Str$(aa)
            PakLocate = PakTempPath + file
        'Else
        '    PakLocate = file
        'End If
    End If
    
    Exit Function
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function

Sub setupPakSystem(pakfile As String)
    On Error GoTo ErrorHandler
    
    Dim aa As Long
    aa = PAKTestSystem()
    If aa = False Then
        gGameState = GS_QUIT
        Exit Sub
    End If
    
    'setup the pakfile system using the pakfile...
    PakFileMounted = pakfile     'filename of the pakfile we have mounted.
    PakFileRunning = True        'have we mounted a pakfile?  is the game running from the pakfile?
    Call DeletePakTemp
    Call CreatePakTemp
    
    Dim wTemp As String
    'mount pakfile...
    If (ZIPIsCompoundFile(pakfile) = 1) Then
        wTemp$ = TempDir()
        aa = ZIPExtractCompoundFile(pakfile, wTemp$ + "tkcache\temp.tpk")
        PakFileMounted = wTemp$ + "tkcache\temp.tpk"
    End If

    'Let's make this a lot less 'painful'... extract the files now... [KSNiloc]
    ExtractDir PakFileMounted, wTemp & "tkcache\"

    'Now open it 'normally'...
    aa = ZIPOpen(PakFileMounted)
    
    'c'est tout!
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next

End Sub


Sub shutdownPakSystem()
    On Error GoTo ErrorHandler
    'unmount pakfile...
    Dim aa As Long
    aa = ZIPClose()
    
    'kill remains of cache
    Call DeletePakTemp
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub



Sub AddDir(zipFilename$, ByVal recurseYN As Boolean, ByVal AppendToExistingEXE As Boolean)
    'add all files and subdirs into this dir
    On Error Resume Next
    Dim a As Long, numFiles As Long
    
    If AppendToExistingEXE Then
        a = ZIPCreate(zipFilename$, 1)
    Else
        a = ZIPCreate(zipFilename$, 0)
    End If
    statusbar.Show
    Call statusbar.setStatus(0, "")
    numFiles = DirCount(recurseYN)
    Call AddDirRecurse(zipFilename$, "", recurseYN, numFiles, 0)
    Unload statusbar
    a = ZIPCloseNew()
    
End Sub


Sub AddDirRecurse(ByVal exclusion As String, ByVal dirprefix As String, ByVal recurseYN As Boolean, ByVal totalfiles As Long, ByRef filesadded As Long)
     'add all files in the dir and subdirs
    'to zip file
    'exclusion - file to exclude
    'dirprefix - prefix to add to file as it goes into zip (for recursing)
    'recurseYN - should we recurse into subdirs?
    'totalfiles - total number of files we expect to add (for status bar)
    'addedSoFar - files added so far (for recursing)
    On Error Resume Next
    'first count number of subdirs...
    Dim subDirs As Long, f As String, subdirpos As Long, perc As Long, a As Long
    
    subDirs = 0
    f$ = Dir$("*.*", vbDirectory)
    Do While f$ <> ""
        If f$ <> "." And f$ <> ".." Then
            If UCase$(f$) <> UCase$(exclusion$) Then
                If IsDir(f$) Then
                    subDirs = subDirs + 1
                End If
            End If
        End If
        f$ = Dir$()
    Loop
    
    'create array to hold subdirs...
    ReDim subdirlist$(subDirs)
    subdirpos = 0
    
    f$ = Dir$("*.*", vbDirectory)
    Do While f$ <> ""
        If f$ <> "." And f$ <> ".." Then
            If UCase$(f$) <> UCase$(exclusion$) Then
                If IsDir(f$) Then
                    subdirlist$(subdirpos) = f$
                    subdirpos = subdirpos + 1
                Else
                    'it's a file...
                    filesadded = filesadded + 1
                    perc = Int((filesadded / totalfiles) * 100)
                    Call statusbar.setStatus(perc, "Adding " + dirprefix$ + f$)
                    a = ZIPAdd(f$, dirprefix$ + f$)
                End If
            End If
        End If
        f$ = Dir$()
    Loop
    
    'now add subdirs...
    Dim t As Long, c As String
    If recurseYN Then
        For t = 0 To subdirpos
            If subdirlist$(t) <> "" Then
                c$ = CurDir$
                ChDir (subdirlist$(t))
                Call AddDirRecurse(exclusion$, dirprefix$ + subdirlist$(t) + "\", recurseYN, totalfiles, filesadded)
                ChDir (c$)
            End If
        Next t
    End If
End Sub

Function DirCount(ByVal recurseYN As Boolean, Optional ByVal theDir As String, Optional ByVal theOldDir) As Integer
    'count all files in the dir
    On Error Resume Next

    ' ! MODIFIED BY KSNiloc...
    
    If theDir <> "" Then
        If theOldDir = "" Then
            theOldDir = CurDir
        End If
        ChDir theDir
    End If
    
    Dim theCount As Long, subDirs As Long, subdirpos As Long, f As String, t As Long, c As String, exclusion As String
    theCount = 0
    
    'first count number of subdirs...
    subDirs = 0
    f$ = Dir$("*.*", vbDirectory)
    Do While f$ <> ""
        If f$ <> "." And f$ <> ".." Then
            If UCase$(f$) <> UCase$(exclusion$) Then
                If IsDir(f$) Then
                    subDirs = subDirs + 1
                End If
            End If
        End If
        f$ = Dir$()
    Loop
    
    'create array to hold subdirs...
    ReDim subdirlist$(subDirs)
    subdirpos = 0
    
    f$ = Dir$("*.*", vbDirectory)
    Do While f$ <> ""
        If f$ <> "." And f$ <> ".." Then
            If UCase$(f$) <> UCase$(exclusion$) Then
                If IsDir(f$) Then
                    subdirlist$(subdirpos) = f$
                    subdirpos = subdirpos + 1
                Else
                    'it's a file...
                    theCount = theCount + 1
                End If
            End If
        End If
        f$ = Dir$()
    Loop
    
    'now add subdirs...
    If recurseYN Then
        For t = 0 To subdirpos
            If subdirlist$(t) <> "" Then
                c$ = CurDir$
                ChDir (subdirlist$(t))
                theCount = theCount + DirCount(recurseYN, theDir, theOldDir)
                ChDir (c$)
            End If
        Next t
    End If
    
    DirCount = theCount
End Function

Public Sub ExtractDir( _
                         ByVal zipFile As String, _
                         ByVal extractInto As String _
                                                       )

    'extract a zip file into a specified dir.
    'extractinto must have '\' at end
    On Error Resume Next
    Dim a As Long, t As Long, cnt As Long, perc As Long
    a = ZIPOpen(zipFile)
    cnt = ZIPGetFileCount()
    statusbar.Show
    For t = 0 To cnt - 1
        perc = Int(((t + 1) / cnt) * 100)
        Call statusbar.setStatus(perc, "Extracting " + GetZipFilename(t))
        a = ZIPExtract(GetZipFilename(t), extractInto + GetZipFilename(t))
    Next t
    a = ZIPClose()
    Unload statusbar
End Sub

Function GetZipFilename(ByVal fileNum As Long) As String
    'get the filenum-th entry in the zipfile
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = ZIPGetFile(fileNum, ret)
    GetZipFilename = Mid$(ret, 1, le)
End Function

Function IsDir(ByVal theDir As String) As Boolean
    'checks if string thedir is a directory
    On Error GoTo theerr
    Dim c As String
    c$ = CurDir$
    ChDir (theDir)
    ChDir (c$)
    IsDir = True
    Exit Function
    
theerr:
    ChDir (c$)
    IsDir = False
End Function


