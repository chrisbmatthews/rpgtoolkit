Attribute VB_Name = "toolkitTKZip"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: zip files :: compressing
'=========================================================================

Option Explicit

'=========================================================================
' ZIP file declarations
'=========================================================================
Private Declare Function ZIPCreate Lib "actkrt3.dll" (ByVal fileCreate As String, ByVal TackOntoEndYN As Long) As Long
Private Declare Function ZIPCloseNew Lib "actkrt3.dll" () As Long
Private Declare Function ZIPAdd Lib "actkrt3.dll" (ByVal fileToAdd As String, ByVal fileAddAs As String) As Long

'=========================================================================
' Returns if the path passed in is a directory
'=========================================================================
Private Function IsDir(ByVal theDir As String) As Boolean

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

'========================================================================='
' Count the files in a directory
'=========================================================================
Private Function DirCount(ByVal recurseYN As Boolean, Optional ByVal theDir As String, Optional ByVal theOldDir) As Integer

    On Error Resume Next
   
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

'=========================================================================
' Add a directory to a ZIP
'=========================================================================
Public Sub AddDir(ByVal zipFilename As String, ByVal recurseYN As Boolean, ByVal AppendToExistingEXE As Boolean)
    On Error Resume Next
    Dim numFiles As Long
    If AppendToExistingEXE Then
        Call ZIPCreate(zipFilename$, 1)
    Else
        Call ZIPCreate(zipFilename$, 0)
    End If
    Call statusbar.Show
    Call statusbar.setStatus(0, "")
    numFiles = DirCount(recurseYN)
    Call AddDirRecurse(zipFilename$, "", recurseYN, numFiles, 0)
    Call Unload(statusbar)
    Call ZIPCloseNew
End Sub

'=========================================================================
' Recursively add a directory to a ZIP
'=========================================================================
Public Sub AddDirRecurse(ByVal exclusion As String, ByVal dirprefix As String, ByVal recurseYN As Boolean, ByVal totalfiles As Long, ByRef filesadded As Long)

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
                    Call statusbar.setStatus(perc, "Adding " + dirprefix & f$)
                    Call ZIPAdd(f$, dirprefix & f$)
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
                Call AddDirRecurse(exclusion$, dirprefix & subdirlist$(t) + "\", recurseYN, totalfiles, filesadded)
                ChDir (c$)
            End If
        Next t
    End If
End Sub

'=========================================================================
' Create a PAK file
'=========================================================================
Public Sub CreatePakFile(ByVal file As String)
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
        Call ZIPCreate(file, 1)
    Else
        'create tpk file (really just a zip file...)
        Call ZIPCreate(file, 0)
    End If

    'now add the files to the pakfile...

    'first add the mainForm file...
    l = ZIPAdd(gamPath & mainFile$, "main.gam")
    count = count + 1
    p = Int(count / numFiles * 100)
    Call statusbar.setStatus(p, "Adding main.gam")

    'tile dir...
    a$ = Dir$(projectPath & tilePath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & tilePath & a$, tilePath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'board dir...
    a$ = Dir$(projectPath & brdPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & brdPath & a$, brdPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
   
    'char dir...
    a$ = Dir$(projectPath & temPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & temPath & a$, temPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
   
    'spc dir...
    a$ = Dir$(projectPath & spcPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & spcPath & a$, spcPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'bkg dir...
    a$ = Dir$(projectPath & bkgPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & bkgPath & a$, bkgPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'media dir...
    a$ = Dir$(projectPath & mediaPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & mediaPath & a$, mediaPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'prg dir...
    a$ = Dir$(projectPath & prgPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & prgPath & a$, prgPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'font dir...
    a$ = Dir$(projectPath & fontPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & fontPath & a$, fontPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'item dir...
    a$ = Dir$(projectPath & itmPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & itmPath & a$, itmPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'ene dir...
    a$ = Dir$(projectPath & enePath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & enePath & a$, enePath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'bmp dir...
    a$ = Dir$(projectPath & bmpPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & bmpPath & a$, bmpPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop

    'status dir...
    a$ = Dir$(projectPath & statusPath & "*.*")
    Do While a$ <> ""
        l = ZIPAdd(projectPath & statusPath & a$, statusPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
    
    'misc dir...
    a$ = Dir$(projectPath & miscPath & "*.*")
    Do While a$ <> ""
        Call ZIPAdd(projectPath & miscPath & a$, miscPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
     
    'plugin dir...
    a$ = Dir$(projectPath & plugPath & "*.*")
    Do While a$ <> ""
        Call ZIPAdd(projectPath & plugPath & a$, plugPath & a$)
        count = count + 1
        p = Int(count / numFiles * 100)
        Call statusbar.setStatus(p, "Adding " + a$)
        a$ = Dir$
    Loop
     
    Call ZIPCloseNew
    Unload statusbar
End Sub

'=========================================================================
' Return the number of files this project consists of
'=========================================================================
Public Function CountProjectFiles() As Integer
    On Error GoTo ErrorHandler
    'returns the total number of files in the project
    Dim count As Long, a As String
    count = 1 'the mainForm file counts as 1
    
    'count stuff in tiles dir...
    a$ = Dir$(projectPath & tilePath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in board dir...
    a$ = Dir$(projectPath & brdPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in character dir...
    a$ = Dir$(projectPath & temPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in spc dir...
    a$ = Dir$(projectPath & spcPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bkg dir...
    a$ = Dir$(projectPath & bkgPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in media dir...
    a$ = Dir$(projectPath & mediaPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in prg dir...
    a$ = Dir$(projectPath & prgPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in font dir...
    a$ = Dir$(projectPath & fontPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in item dir...
    a$ = Dir$(projectPath & itmPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in enemy dir...
    a$ = Dir$(projectPath & enePath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bmp dir...
    a$ = Dir$(projectPath & bmpPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in ststuas dir...
    a$ = Dir$(projectPath & statusPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in misc dir...
    a$ = Dir$(projectPath & miscPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in plugindir...
    a$ = Dir$(projectPath & plugPath & "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    CountProjectFiles = count

    Exit Function
'Begin error handling code:
ErrorHandler:
    
    Resume Next

End Function
