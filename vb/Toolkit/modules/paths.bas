Attribute VB_Name = "paths"
Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
'Declare Function GetShortPathName Lib "kernel32" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
Declare Function GetShortPathName Lib "kernel32" _
    Alias "GetShortPathNameA" (ByVal lpszLongPath As String, _
    ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long

Public Function SystemDir() As String
    'returns path of windows\system dir
    ''returns path with the ending '\' on it
    On Error Goto errorhandler
    Dim ret As String * 400
    le = GetSystemDirectory(ret, 400)
    SystemDir = Mid$(ret, 1, le) + "\"

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Public Function WindowsDir() As String
    'returns path of windows dir
    ''returns path with the ending '\' on it
    On Error Goto errorhandler
    Dim ret As String * 400
    le = GetWindowsDirectory(ret, 400)
    WindowsDir = Mid$(ret, 1, le) + "\"

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Public Function TempDir() As String
    'returns path of temp dir
    ''returns path with the ending '\' on it
    On Error Goto errorhandler
    Dim ret As String * 400
    le = GetTempPath(400, ret)
    TempDir = Mid$(ret, 1, le)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function


Public Function GetShortName(inFile As String) As String
    'returns filename in old dos 8.3 format
    On Error Goto errorhandler
    Dim ret As String * 400
    le = GetShortPathName(inFile, ret, 400)
    GetShortName = Mid$(ret, 1, le)
    
    'Dim SLongFileName As String
    'SLongFileName = inFile
    
    'Dim lretval As Long, sshortpathname As String, ilen As Integer
    'sshortpathname = Space(255)
    'ilen = Len(sshortpathname)

    'lretval = GetShortPathName(SLongFileName, sshortpathname, ilen)

    'GetShortName = Left(sshortpathname, lretval)



    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Public Function GetExt(inFile As String) As String
    'returns the extention of a filename
    On Error Goto errorhandler
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

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Public Function GetPath(inFile As String) As String
    'returns the path of a filename
    'note: returns path *with* the '\' at end
    On Error Goto errorhandler
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

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Public Function GetPathNoSlash(inFile As String) As String
    'returns the path of a filename
    'note: returns path *without* the '\' at end
    On Error Goto errorhandler
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

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function


Public Function RemovePath(inFile As String) As String
    'returns the filename without it's path
    On Error Goto errorhandler
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
        RemovePath = ""
        Exit Function
    End If
    
    'step 3: extract filename after the '/' or '\'
    thefn$ = ""
    For t = theloc + 1 To Len(inFile)
        part$ = Mid$(inFile, t, 1)
        thefn$ = thefn$ + part$
    Next t
    
    RemovePath = thefn$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function


Public Function FileExists(inFile As String) As Boolean
    'checks if a file exists.
    'returns t/f
    On Error GoTo feerr
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
