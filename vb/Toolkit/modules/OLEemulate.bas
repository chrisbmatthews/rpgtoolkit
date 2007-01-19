Attribute VB_Name = "oleEmulate"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
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

Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpszOp As String, ByVal lpszFile As String, ByVal lpszParams As String, ByVal LpszDir As String, ByVal FsShowCmd As Long) As Long
Public Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetWindow Lib "user32" (ByVal hwnd As Long, ByVal wCmd As Long) As Long
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Public Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function IsWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function FindExecutable Lib "shell32.dll" Alias "FindExecutableA" (ByVal lpFile As String, ByVal lpDirectory As String, ByVal lpResult As String) As Long
Public Declare Function GetDesktopWindow Lib "user32" () As Long
Private Const SW_SHOWNORMAL = 1
Private Const WM_CLOSE = &H10
Private Const INFINITE = &HFFFFFFFF
Private Const GW_HWNDNEXT = 2
Private Const SE_ERR_FNF = 2&
Private Const SE_ERR_PNF = 3&
Private Const SE_ERR_ACCESSDENIED = 5&
Private Const SE_ERR_OOM = 8&
Private Const SE_ERR_DLLNOTFOUND = 32&
Private Const SE_ERR_SHARE = 26&
Private Const SE_ERR_ASSOCINCOMPLETE = 27&
Private Const SE_ERR_DDETIMEOUT = 28&
Private Const SE_ERR_DDEFAIL = 29&
Private Const SE_ERR_DDEBUSY = 30&
Private Const SE_ERR_NOASSOC = 31&
Private Const ERROR_BAD_FORMAT = 11&

Public Function determineDefaultApp(ByVal file As String) As String
    On Error Resume Next
    Dim dummy As String
    Dim appExec As String ' * 255
    appExec = String$(255, vbNullChar)
    Call FindExecutable(file, dummy, appExec)
    determineDefaultApp = Left$(appExec, InStr(1, appExec, vbNullChar) - 1)
End Function

Public Function procIDFromWnd(ByVal hwnd As Long) As Long
    On Error Resume Next
    Dim idProc As Long
    GetWindowThreadProcessId hwnd, idProc
    procIDFromWnd = idProc
End Function
      
Public Function getWinHandle(ByVal hInstance As Long) As Long
   Dim tempHwnd As Long
   tempHwnd = FindWindow(vbNullString, vbNullString)
   Do Until tempHwnd = 0
      If GetParent(tempHwnd) = 0 Then
         If hInstance = procIDFromWnd(tempHwnd) Then
            getWinHandle = tempHwnd
            Exit Do
         End If
      End If
      tempHwnd = GetWindow(tempHwnd, GW_HWNDNEXT)
   Loop
End Function

