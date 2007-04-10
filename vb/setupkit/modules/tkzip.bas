Attribute VB_Name = "tkzip"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher B. Matthews
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

'========================================================================
' Game publisher helper program (non-pak/exe)
'========================================================================

'interface with tkzip.dll

'zip file subsystem
'may 17, 2001
Declare Function ZIPTest Lib "tkzip.dll" () As Long

Declare Function ZIPCreate Lib "tkzip.dll" (ByVal fileCreate As String, ByVal TackOntoEndYN As Long) As Long

Declare Function ZIPCloseNew Lib "tkzip.dll" () As Long

Declare Function ZIPAdd Lib "tkzip.dll" (ByVal fileToAdd As String, ByVal fileAddAs As String) As Long

Declare Function ZIPOpen Lib "tkzip.dll" (ByVal fileOpen As String) As Long

Declare Function ZIPClose Lib "tkzip.dll" () As Long

Declare Function ZIPExtract Lib "tkzip.dll" (ByVal fileToExtract As String, ByVal saveAs As String) As Long

Declare Function ZIPGetFileCount Lib "tkzip.dll" () As Long

Declare Function ZIPGetFile Lib "tkzip.dll" (ByVal fileNum As Long, ByVal fileout As String) As Long

Declare Function ZIPFileExist Lib "tkzip.dll" (ByVal fileToCheck As String) As Long

Sub AddDir(zipFilename$, ByVal recurseYN As Boolean, ByVal AppendToExistingEXE As Boolean)
    'add all files and subdirs into this dir
    On Error Resume Next
    If AppendToExistingEXE Then
        a = ZIPCreate(zipFilename$, 1)
    Else
        a = ZIPCreate(zipFilename$, 0)
    End If
    statusbar.Show
    Call statusbar.setStatus(0, "")
    numfiles = DirCount(recurseYN)
    Call AddDirRecurse(zipFilename$, "", recurseYN, numfiles, 0)
    Unload statusbar
    a = ZIPCloseNew()
    
End Sub


Sub AddDirRecurse(exclusion$, ByVal dirprefix$, ByVal recurseYN As Boolean, ByVal totalfiles, ByRef filesadded)
    'add all files in the dir and subdirs
    'to zip file
    'exclusion - file to exclude
    'dirprefix - prefix to add to file as it goes into zip (for recursing)
    'recurseYN - should we recurse into subdirs?
    'totalfiles - total number of files we expect to add (for status bar)
    'addedSoFar - files added so far (for recursing)
    On Error Resume Next
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



Function DirCount(ByVal recurseYN As Boolean) As Integer
    'count all files in the dir
    On Error Resume Next
    
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
                theCount = theCount + DirCount(recurseYN)
                ChDir (c$)
            End If
        Next t
    End If
    
    DirCount = theCount
End Function

Sub ExtractDir(zipfile$, extractInto$)
    'extract a zip file into a specified dir.
    'extractinto$ must have '\' at end
    On Error Resume Next
    a = ZIPOpen(zipfile$)
    cnt = ZIPGetFileCount()
    statusbar.Show
    For t = 0 To cnt - 1
        perc = Int(((t + 1) / cnt) * 100)
        Call statusbar.setStatus(perc, "Extracting " + GetZipFilename(t))
        a = ZIPExtract(GetZipFilename(t), extractInto$ + GetZipFilename(t))
    Next t
    a = ZIPClose()
    Unload statusbar
End Sub

Function GetZipFilename(fileNum) As String
    'get the filenum-th entry in the zipfile
    On Error Resume Next
    Dim ret As String * 400
    le = ZIPGetFile(fileNum, ret)
    GetZipFilename = Mid$(ret, 1, le)
End Function

Function IsDir(ByVal thedir) As Boolean
    'checks if string thedir is a directory
    On Error GoTo theerr
    c$ = CurDir$
    ChDir (thedir)
    ChDir (c$)
    IsDir = True
    Exit Function
    
theerr:
    ChDir (c$)
    IsDir = False
End Function


