Attribute VB_Name = "CommonPaths"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Path related routines
'=========================================================================

Option Explicit

'=========================================================================
' Win32 APIs
'=========================================================================
Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Private Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long

'=========================================================================
' Change current directory
'=========================================================================
Public Sub ChangeDir(ByVal newDir As String)
    On Error Resume Next
    Dim p As String
    Dim dr As String
    p = GetPath(newDir)
    dr = Mid(p, 1, 2)
    If Mid(dr, 2, 1) = ":" Then
        dr = Mid(p, 1, 3)
        Call ChDrive(dr$)
    End If
    Call ChDir(newDir)
End Sub

'=========================================================================
' Return the path to the system directory
'=========================================================================
Public Function SystemDir() As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetSystemDirectory(ret, 400)
    SystemDir = Mid$(ret, 1, le) & "\"
End Function

'=========================================================================
' Return the path to the windows directory
'=========================================================================
Public Function WindowsDir() As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetWindowsDirectory(ret, 400)
    WindowsDir = Mid$(ret, 1, le) & "\"
End Function

'=========================================================================
' Return the path to the temp directory
'=========================================================================
Public Function TempDir() As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = GetTempPath(400, ret)
    TempDir = Mid$(ret, 1, le)
End Function

'=========================================================================
' Get extension of a file (gotta be fifteen functions like this!)
'=========================================================================
Public Function GetExt(ByVal inFile As String) As String
    On Error Resume Next
    Dim theloc As Long, t As Long, part As String, theext As String
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
        theext$ = theext & part$
    Next t
    GetExt = theext$
End Function

'=========================================================================
' Get path of a file
'=========================================================================
Public Function GetPath(ByVal inFile As String) As String
    On Error Resume Next
    Dim theloc As Long, part As String, thept As String, t As Long
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
        thept$ = thept & part$
    Next t
    GetPath = thept$
End Function

'=========================================================================
' Get path of a file minus the \
'=========================================================================
Public Function GetPathNoSlash(ByVal inFile As String) As String

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
        thept$ = thept & part$
    Next t
    
    GetPathNoSlash = thept$
End Function

'=========================================================================
' Remove path from a file
'=========================================================================
Public Function RemovePath(ByVal inFile As String) As String

    On Error Resume Next

    Dim theloc As Long, t As Long, part As String, thefn As String
    
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
        thefn$ = thefn & part$
    Next t
    
    RemovePath = thefn$
End Function

'=========================================================================
' Determine if a file exists
'=========================================================================
Public Function fileExists(ByVal file As String) As Boolean

On Local Error Resume Next

    fileExists = (GetAttr(file) And vbDirectory) = 0
    
End Function

