Attribute VB_Name = "CommonPaths"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
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
    dr = Mid$(p, 1, 2)
    If Mid$(dr, 2, 1) = ":" Then
        dr = Mid$(p, 1, 3)
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
Public Function GetExt(ByVal InFile As String) As String
    On Error Resume Next
    Dim theloc As Long, t As Long, part As String, theext As String
    'step 1: search backwars for '.'
    For t = Len(InFile) To 1 Step -1
        part$ = Mid$(InFile, t, 1)
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
        GetExt = vbNullString
        Exit Function
    End If
    'step 3: extract extention after the '.'
    theext$ = vbNullString
    For t = theloc + 1 To Len(InFile)
        part$ = Mid$(InFile, t, 1)
        theext$ = theext & part$
    Next t
    GetExt = theext$
End Function

'=========================================================================
' Get path of a file
'=========================================================================
Public Function GetPath(ByVal InFile As String) As String
    On Error Resume Next
    Dim theloc As Long, part As String, thept As String, t As Long
    'step 1: search backwars for '\' or '/'
    For t = Len(InFile) To 1 Step -1
        part$ = Mid$(InFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    'step 2: check if path wasn't found...
    If theloc = 0 Then
        GetPath = vbNullString
        Exit Function
    End If
    'step 3: extract path before the '/' or '\'
    thept$ = vbNullString
    For t = 1 To theloc
        part$ = Mid$(InFile, t, 1)
        thept$ = thept & part$
    Next t
    GetPath = thept$
End Function

'=========================================================================
' Get path of a file minus the \
'=========================================================================
Public Function GetPathNoSlash(ByVal InFile As String) As String

    On Error Resume Next

    Dim theloc As Long, t As Long, part As String, thept As String
    theloc = 0
    
    'step 1: search backwars for '\' or '/'
    For t = Len(InFile) To 1 Step -1
        part$ = Mid$(InFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    
    'step 2: check if path wasn't found...
    If theloc = 0 Then
        GetPathNoSlash = vbNullString
        Exit Function
    End If
    
    'step 3: extract path before the '/' or '\'
    thept$ = vbNullString
    For t = 1 To theloc - 1
        part$ = Mid$(InFile, t, 1)
        thept$ = thept & part$
    Next t
    
    GetPathNoSlash = thept$
End Function

'=========================================================================
' Remove path from a file
'=========================================================================
Public Function RemovePath(ByVal InFile As String) As String

    On Error Resume Next

    Dim theloc As Long, t As Long, part As String, thefn As String
    
    'step 1: search backwars for '\' or '/'
    For t = Len(InFile) To 1 Step -1
        part$ = Mid$(InFile, t, 1)
        If part$ = "\" Or part$ = "/" Then
            'found it.
            theloc = t
            Exit For
        End If
    Next t
    
    'step 2: check if filename wasn't found...
    If theloc = 0 Then
        RemovePath = InFile
        Exit Function
    End If
    
    'step 3: extract filename after the '/' or '\'
    thefn$ = vbNullString
    For t = theloc + 1 To Len(InFile)
        part$ = Mid$(InFile, t, 1)
        thefn$ = thefn & part$
    Next t
    
    RemovePath = thefn$
End Function

'=========================================================================
' Determine if a file exists
'=========================================================================
Public Function fileExists(ByVal file As String) As Boolean
    On Local Error Resume Next
    fileExists = ((GetAttr(file) And vbDirectory) = 0)
End Function

'=========================================================================
' Determine if a directory exists
'=========================================================================
Public Function dirExists(ByVal path As String) As Boolean
    On Local Error Resume Next
    dirExists = (GetAttr(path) And vbDirectory)
End Function

'=========================================================================
' Preserve files saved in subfolders of default directories;
' do not allow files outside the default directories
'=========================================================================
Public Function getValidPath(ByVal currentPath As String, ByVal defaultPath As String, ByRef returnPath As String, ByVal showWarning As Boolean) As Boolean  ':on error resume next
    Dim start As Long
    start = InStr(1, currentPath, defaultPath, vbTextCompare)
    If start > 0 Then
        'The default path is contained in the current path, remove the default folders.
        returnPath = Mid$(currentPath, start + Len(defaultPath))
    Else
        'The current path is outside the default, remove the current path.
        If showWarning Then
            If MsgBox( _
                "Files must reside within the game's default folder or sub-folders. " & vbCrLf & _
                "Do you wish to save this file in the default folder " & defaultPath & "?", _
                vbOKCancel Or vbInformation) = vbCancel Then
                getValidPath = False
                Exit Function
            End If
        End If
        returnPath = RemovePath(currentPath)
    End If
    getValidPath = True
End Function

