Attribute VB_Name = "CommonBrowse"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'common module for popping up the web browser
'either tkbrowse.exe or the user's default browser
Option Explicit

Public BrowseUseExternal As Boolean 'use external web browser? (if false, use tkbrowse.exe)

Sub BrowseFile(ByVal file As String)
    'browse to a file (relative location ok)
    If currentdir$ = "" Then
        Call BrowseLocation(App.path + "\" + file)
    Else
        Call BrowseLocation(currentdir$ + "\" + file)
    End If
End Sub


Public Sub BrowseLocation(ByVal url As String)
    'open browser to specific location
    On Error GoTo errorhandler
    
    If Not (FileExists("tkbrowse.exe")) Then
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
errorhandler:
    a = Shell("tkbrowse " + Chr$(34) + url + Chr$(34))
    Resume Next
End Sub


