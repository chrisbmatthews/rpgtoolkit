Attribute VB_Name = "paths"
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Function GetShortPathName Lib "kernel32" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long

Declare Function fCreateShellLink Lib "VB5STKIT.DLL" (ByVal lpstrFolderName As String, ByVal lpstrLinkName As String, ByVal lpstrLinkPath As String, ByVal lpstrLinkArgs As String) As Long


Private Type STARTUPINFO
   cb As Long
   lpReserved As String
   lpDesktop As String
   lpTitle As String
   dwX As Long
   dwY As Long
   dwXSize As Long
   dwYSize As Long
   dwXCountChars As Long
   dwYCountChars As Long
   dwFillAttribute As Long
   dwflags As Long
   wShowWindow As Integer
   cbReserved2 As Integer
   lpReserved2 As Long
   hStdInput As Long
   hStdOutput As Long
   hStdError As Long
End Type

Private Type PROCESS_INFORMATION
   hProcess As Long
   hThread As Long
   dwProcessID As Long
   dwThreadID As Long
End Type

Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal _
   hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Declare Function CreateProcessA Lib "kernel32" (ByVal _
   lpApplicationName As Long, ByVal lpCommandLine As String, ByVal _
   lpProcessAttributes As Long, ByVal lpThreadAttributes As Long, _
   ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, _
   ByVal lpEnvironment As Long, ByVal lpCurrentDirectory As Long, _
   lpStartupInfo As STARTUPINFO, lpProcessInformation As _
   PROCESS_INFORMATION) As Long

Private Declare Function CloseHandle Lib "kernel32" _
   (ByVal hObject As Long) As Long

Private Declare Function GetExitCodeProcess Lib "kernel32" _
   (ByVal hProcess As Long, lpExitCode As Long) As Long

Private Const NORMAL_PRIORITY_CLASS = &H20&
Private Const INFINITE = -1&




'Module Code
Public Enum CSIDL_FOLDERS
    CSIDL_DESKTOP = &H0 '// The Desktop - virtual folder
    CSIDL_programs = 2 '// Program Files
    CSIDL_CONTROLS = 3 '// Control Panel - virtual folder
    CSIDL_PRINTERS = 4 '// Printers - virtual folder
    CSIDL_DOCUMENTS = 5 '// My Documents
    CSIDL_FAVORITES = 6 '// Favourites
    CSIDL_STARTUP = 7 '// Startup Folder
    CSIDL_RECENT = 8 '// Recent Documents
    CSIDL_SENDTO = 9 '// Send To Folder
    CSIDL_BITBUCKET = 10 '// Recycle Bin - virtual folder
    CSIDL_STARTMENU = 11 '// Start Menu
    CSIDL_DESKTOPFOLDER = 16 '// Desktop folder
    CSIDL_DRIVES = 17 '// My Computer - virtual folder
    CSIDL_NETWORK = 18 '// Network Neighbourhood - virtual folder
    CSIDL_NETHOOD = 19 '// NetHood Folder
    CSIDL_FONTS = 20 '// Fonts folder
    CSIDL_SHELLNEW = 21 '// ShellNew folder
End Enum
Private Const FO_MOVE = &H1
Private Const FO_RENAME = &H4
Private Const FOF_SILENT = &H4
Private Const FOF_NOCONFIRMATION = &H10
Private Const FOF_RENAMEONCOLLISION = &H8
Private Const MAX_PATH As Integer = 260
Private Const SHARD_PATH = &H2&
Private Const SHCNF_IDLIST = &H0
Private Const SHCNE_ALLEVENTS = &H7FFFFFFF

Private Type SHFILEOPSTRUCT
    hwnd   As Long
    wFunc As Long
    pFrom As String
    pTo     As String
    fFlags  As Integer
    fAborted       As Boolean
    hNameMaps As Long
    sProgress      As String
End Type

Private Type SHITEMID
    cb As Long
    abID As Byte
End Type

Private Type ITEMIDLIST
    mkid As SHITEMID
End Type

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function SHGetSpecialFolderLocation Lib "Shell32.dll" _
        (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
Private Declare Function SHGetSpecialFolderLocationD Lib "Shell32.dll" Alias _
        "SHGetSpecialFolderLocation" (ByVal hwndOwner As Long, ByVal nFolder As Long, _
        ByRef ppidl As Long) As Long
Private Declare Function SHAddToRecentDocs Lib "Shell32.dll" (ByVal dwflags As Long, _
        ByVal dwdata As String) As Long
Private Declare Function SHFileOperation Lib "Shell32.dll" Alias "SHFileOperationA" _
        (lpFileOp As SHFILEOPSTRUCT) As Long
Private Declare Function SHChangeNotify Lib "Shell32.dll" (ByVal wEventID As Long, _
        ByVal uFlags As Long, ByVal dwItem1 As Long, ByVal dwItem2 As Long) As Long
Private Declare Function SHGetPathFromIDList Lib "Shell32.dll" Alias "SHGetPathFromIDListA" _
        (ByVal pidl As Long, ByVal pszPath As String) As Long


Function fGetSpecialFolder(CSIDL As Long) As String
    Dim sPath As String
    Dim IDL As ITEMIDLIST
    '
    ' Retrieve info about system folders such as the "Recent Documents" folder.
    ' Info is stored in the IDL structure.
    '
    fGetSpecialFolder = ""
    If SHGetSpecialFolderLocation(setup.hwnd, CSIDL, IDL) = 0 Then
        '
        ' Get the path from the ID list, and return the folder.
        '
        sPath = Space$(MAX_PATH)
        If SHGetPathFromIDList(ByVal IDL.mkid.cb, ByVal sPath) Then
            fGetSpecialFolder = Left$(sPath, InStr(sPath, vbNullChar) - 1) & "\"
        End If
    End If
End Function
Sub MakeShortcut(ByVal targetFile As String, ByVal theArgs As String, ByVal shortcutFile As String)
    On Error Resume Next
    'Dim wShortcut As IWshShortcut_Class
    'Dim wShell As IWshShell_Class
    'Set wShell = New IWshShell_Class
    
    'Set wShortcut = wShell.CreateShortcut(shortcutFile)
    'wShortcut.TargetPath = targetFile
    'wShortcut.WorkingDirectory = GetPath(targetFile)
    'wShortcut.Arguments = theArgs   'command line
    'wShortcut.Save
    
    'Call MakeShortcut(destdir$ + shortCutTargets(t), shortCutArgs(t), startMenuGroup + "\" + shortCutLabels(t))
    
    a = fCreateShellLink(GetPath(shortcutFile), RemovePath(shortcutFile), targetFile, theArgs)
    
    If a = 0 Then
        pt$ = GetPathNoSlash(shortcutFile)
        a = fCreateShellLink(pt$, RemovePath(shortcutFile), targetFile, theArgs)
    End If

End Sub
Public Function ExecCmd(cmdline$)
   Dim proc As PROCESS_INFORMATION
   Dim start As STARTUPINFO

   ' Initialize the STARTUPINFO structure:
   start.cb = Len(start)

   ' Start the shelled application:
   ret& = CreateProcessA(0&, cmdline$, 0&, 0&, 1&, _
      NORMAL_PRIORITY_CLASS, 0&, 0&, start, proc)

   ' Wait for the shelled application to finish:
      ret& = WaitForSingleObject(proc.hProcess, INFINITE)
      Call GetExitCodeProcess(proc.hProcess, ret&)
      Call CloseHandle(proc.hThread)
      Call CloseHandle(proc.hProcess)
      ExecCmd = ret&
End Function

Function StartMenuDir() As String
    'find dir of start menu
    ''returns path with the ending '\' on it
    On Error Resume Next
    'Dim temp
    'Dim wShell As IWshShell_Class
    'Set wShell = New IWshShell_Class
    
    'Dim toRet As String
    
    'For Each temp In wShell.SpecialFolders
    '    If InStr(temp, "Start Menu") <> 0 Then
    '        toRet = temp
    '    End If
    'Next
     
    'If toRet <> "" Then
    '    toRet = toRet + "\"
    'End If
     
    'StartMenuDir = toRet
    
    StartMenuDir = fGetSpecialFolder(CSIDL_programs)
End Function

Public Function SystemDir() As String
    'returns path of windows\system dir
    ''returns path with the ending '\' on it
    Dim ret As String * 400
    le = GetSystemDirectory(ret, 400)
    SystemDir = Mid$(ret, 1, le) + "\"
End Function

Public Function WindowsDir() As String
    'returns path of windows dir
    ''returns path with the ending '\' on it
    Dim ret As String * 400
    le = GetWindowsDirectory(ret, 400)
    WindowsDir = Mid$(ret, 1, le) + "\"
End Function

Public Function TempDir() As String
    'returns path of temp dir
    ''returns path with the ending '\' on it
    Dim ret As String * 400
    le = GetTempPath(400, ret)
    TempDir = Mid$(ret, 1, le)
End Function


Public Function GetShortName(inFile As String) As String
    'returns filename in old dos 8.3 format
    Dim ret As String * 400
    le = GetShortPathName(inFile, ret, 400)
    GetShortName = Mid$(ret, 1, le)
End Function

Public Function GetExt(inFile As String) As String
    'returns the extention of a filename
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


Public Function RemovePath(ByVal inFile As String) As String
    'returns the filename without it's path
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
End Function


Public Function fileexists(inFile As String) As Boolean
    'checks if a file exists.
    'returns t/f
    On Error GoTo feerr
    num = FreeFile
    retval = True
    Open inFile For Input As #num
    Close #num
    fileexists = retval
    Exit Function
    
feerr:
    retval = False
    Resume Next
End Function
