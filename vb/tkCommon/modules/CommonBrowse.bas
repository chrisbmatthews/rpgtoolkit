Attribute VB_Name = "CommonBrowse"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
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

Option Explicit

Public BrowseUseExternal As Boolean 'use external web browser? (if false, use tkbrowse.exe)

Sub BrowseFile(ByVal file As String)
    'browse to a file (relative location ok)
    If currentDir$ = "" Then
        Call BrowseLocation(App.path + "\" + file)
    Else
        Call BrowseLocation(currentDir$ + "\" + file)
    End If
End Sub


Public Sub BrowseLocation(ByVal url As String)
    'open browser to specific location
    On Error GoTo ErrorHandler
    
    If Not (fileExists("tkbrowse.exe")) Then
        BrowseUseExternal = True
    End If
    
    Dim a As Long
    If BrowseUseExternal Then
        a = Shell("start " + url, vbNormalFocus)
    Else
        a = Shell("tkbrowse " + url, vbNormalFocus)
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    a = Shell("tkbrowse " + chr$(34) + url + chr$(34))
    Resume Next
End Sub


