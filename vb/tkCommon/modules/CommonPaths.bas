Attribute VB_Name = "CommonPaths"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
'Declare Function GetShortPathName Lib "kernel32" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
Declare Function GetShortPathName Lib "kernel32" _
    Alias "GetShortPathNameA" (ByVal lpszLongPath As String, _
    ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long

Sub ChangeDir(newdir As String)
    On Error Resume Next
    
    'changes current diirectory (and drive) if it has to.
    Dim p As String
    Dim dr As String
    p$ = GetPath(newdir)
    'now get first few chars to see if we need to change drive...
    dr$ = Mid$(p$, 1, 2)
    
    If Mid$(dr$, 2, 1) = ":" Then
        'yup-- the dirive is there.  let's change the drive!
        dr$ = Mid$(p$, 1, 3)
        ChDrive (dr$)
    End If
    
    ChDir (newdir)
    Exit Sub

End Sub


Function GetShortName(file As String) As String
    GetShortName = getshortername(file)
End Function

Function isShortName(ByVal file$) As Boolean
    'determines if a filename is the short filename
    On Error Resume Next
    Dim f As String
    f$ = getshortername(file$)
    If UCase$(f$) = UCase$(file$) Then
        isShortName = True
    Else
        isShortName = False
    End If
End Function
Public Function SystemDir() As String
    'returns path of windows\system dir
    ''returns path with the ending '\' on it
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetSystemDirectory(ret, 400)
    SystemDir = Mid$(ret, 1, le) + "\"

    Exit Function
End Function

Public Function WindowsDir() As String
    'returns path of windows dir
    ''returns path with the ending '\' on it
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetWindowsDirectory(ret, 400)
    WindowsDir = Mid$(ret, 1, le) + "\"

End Function

Public Function TempDir() As String
    'returns path of temp dir
    ''returns path with the ending '\' on it
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetTempPath(400, ret)
    TempDir = Mid$(ret, 1, le)

End Function


Public Function getshortername(inFile As String) As String
    'returns filename in old dos 8.3 format
    On Error GoTo errsn
    Dim ret As String * 400
    Dim le As Long
    le = GetShortPathName(inFile, ret, 400)
    getshortername = Mid$(ret, 1, le)
    Exit Function
    
errsn:
    Resume Next
End Function

Public Function GetExt(inFile As String) As String
    'returns the extention of a filename
    On Error Resume Next
    Dim theloc As Long, t As Long, part As String, theext As String
    theloc = 0
    
    'step 1: search backwars for '.'
    For t = Len(inFile) To 1 Step -1
        part$ = Mid$(inFile, t, 1)
        If part$ = "." Then
            theloc = t
            Exit For
        End If
        If part$ = "\" Or part$ = "/" Then
            'hmmm.  the path wasn't found before
            'we skipped into another dir.
            'assume no path
            theloc = 0
            Exit For
        End If
    Next t
    
    'step 2: check if extention wasn't found...
    If theloc = 0 Then
        GetExt = ""
        Exit Function
    End If
    
    'step 3: extract extention after the '.'
    theext$ = ""
    For t = theloc + 1 To Len(inFile)
        part$ = Mid$(inFile, t, 1)
        theext$ = theext$ + part$
    Next t
    
    GetExt = theext$
End Function

Public Function GetPath(inFile As String) As String
    'returns the path of a filename
    'note: returns path *with* the '\' at end
    On Error Resume Next
    Dim theloc As Long, part As String, thept As String, t As Long
    theloc = 0
    
    'step 1: search backwars for '\' or '/'
    For t = Len(inFile) To 1 Step -1
        part$ = Mid$(inFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    
    'step 2: check if path wasn't found...
    If theloc = 0 Then
        GetPath = ""
        Exit Function
    End If
    
    'step 3: extract path before the '/' or '\'
    thept$ = ""
    For t = 1 To theloc
        part$ = Mid$(inFile, t, 1)
        thept$ = thept$ + part$
    Next t
    
    GetPath = thept$
End Function

Public Function GetPathNoSlash(inFile As String) As String
    'returns the path of a filename
    'note: returns path *without* the '\' at end
    On Error Resume Next
    Dim theloc As Long, t As Long, part As String, thept As String
    theloc = 0
    
    'step 1: search backwars for '\' or '/'
    For t = Len(inFile) To 1 Step -1
        part$ = Mid$(inFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    
    'step 2: check if path wasn't found...
    If theloc = 0 Then
        GetPathNoSlash = ""
        Exit Function
    End If
    
    'step 3: extract path before the '/' or '\'
    thept$ = ""
    For t = 1 To theloc - 1
        part$ = Mid$(inFile, t, 1)
        thept$ = thept$ + part$
    Next t
    
    GetPathNoSlash = thept$
End Function


Public Function RemovePath(inFile As String) As String
    'returns the filename without it's path
    On Error Resume Next
    Dim theloc As Long, t As Long, part As String, thefn As String
    theloc = 0
    
    'step 1: search backwars for '\' or '/'
    For t = Len(inFile) To 1 Step -1
        part$ = Mid$(inFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    
    'step 2: check if filename wasn't found...
    If theloc = 0 Then
        RemovePath = inFile
        Exit Function
    End If
    
    'step 3: extract filename after the '/' or '\'
    thefn$ = ""
    For t = theloc + 1 To Len(inFile)
        part$ = Mid$(inFile, t, 1)
        thefn$ = thefn$ + part$
    Next t
    
    RemovePath = thefn$
End Function


Public Function FileExists(inFile As String) As Boolean
    'checks if a file exists.
    'returns t/f
    On Error GoTo feerr
    Dim num As Long, retval As Boolean
    num = FreeFile
    retval = True
    Open inFile For Input As #num
    Close #num
    FileExists = retval
    Exit Function
    
feerr:
    retval = False
    Resume Next
End Function
