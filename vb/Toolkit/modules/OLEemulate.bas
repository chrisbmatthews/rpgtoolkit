Attribute VB_Name = "oleEmulate"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'OLE Emulation routines.

Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
                   (ByVal hwnd As Long, ByVal lpszOp As String, _
                    ByVal lpszFile As String, ByVal lpszParams As String, _
                    ByVal LpszDir As String, ByVal FsShowCmd As Long) _
                    As Long
Public Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetWindow Lib "user32" (ByVal hwnd As Long, _
  ByVal wCmd As Long) As Long
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" _
  (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" _
  (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function GetWindowThreadProcessId Lib "user32" _
  (ByVal hwnd As Long, lpdwprocessid As Long) As Long

'New API added by KSNiloc...
Public Declare Function SetParent Lib "user32" _
                (ByVal hWndChild As Long, _
                ByVal hWndNewParent As Long) As Long

Private Declare Function WaitForSingleObject Lib "kernel32" _
   (ByVal hHandle As Long, _
   ByVal dwMilliseconds As Long) As Long

Private Declare Function PostMessage Lib "user32" _
   Alias "PostMessageA" _
   (ByVal hwnd As Long, _
   ByVal wMsg As Long, _
   ByVal wParam As Long, _
   ByVal lParam As Long) As Long

'Made public by KSNiloc...
Public Declare Function IsWindow Lib "user32" _
   (ByVal hwnd As Long) As Long


'determine default executable...
Private Declare Function FindExecutable Lib "shell32.dll" Alias _
         "FindExecutableA" (ByVal lpFile As String, ByVal lpDirectory As _
         String, ByVal lpResult As String) As Long

'Constants used by the API functions
Const WM_CLOSE = &H10
Const INFINITE = &HFFFFFFFF
Public Const GW_HWNDNEXT = 2

' ! MADE PUBLIC [KSNiloc]
Public Declare Function GetDesktopWindow Lib "user32" () As Long

Const SW_SHOWNORMAL = 1

Const SE_ERR_FNF = 2&
Const SE_ERR_PNF = 3&
Const SE_ERR_ACCESSDENIED = 5&
Const SE_ERR_OOM = 8&
Const SE_ERR_DLLNOTFOUND = 32&
Const SE_ERR_SHARE = 26&
Const SE_ERR_ASSOCINCOMPLETE = 27&
Const SE_ERR_DDETIMEOUT = 28&
Const SE_ERR_DDEFAIL = 29&
Const SE_ERR_DDEBUSY = 30&
Const SE_ERR_NOASSOC = 31&
Const ERROR_BAD_FORMAT = 11&


Global OLEOpenedFile As String
Global OLEhInstance As Long

Function DetermineDefaultApp(file As String) As String
    'determines what the default app is to open
    'file 'file'
    Dim dummy As String
    Dim appExec As String * 255
    appExec = Space(255)
    retval = FindExecutable(file, dummy, appExec)
    DetermineDefaultApp = appExec
End Function


Sub OLEClose()
    'kill the OLE app, if it's running
    Dim hWindow As Long
    Dim lngResult As Long
    Dim lngReturnValue As Long
    
    Dim Scr_hDC As Long
    Scr_hDC = GetDesktopWindow()
    'OLEhInstance = ShellExecute(Scr_hDC, "Open", file, "", "C:\", SW_SHOWNORMAL)

    Dim appToPlay As String
    Dim fileToPlay As String
    
    appToPlay = DetermineDefaultApp(OLEOpenedFile)
    If appToPlay <> "" Then
        OLEOpenedFile = file
        OLEhInstance = ShellExecute(Scr_hDC, "Open", appToPlay, "", dummy, SW_SHOWNORMAL)
        'OLEhInstance = Shell(appToPlay + " " + file)
    End If
    
    'If OLEIsPlaying() Then
        'hWndApp = GetWinHandle(OLEhInstance)
        
        'If hWndApp <> 0 Then
            ' Init buffer
            'buffer = Space$(128)
            
            ' Get caption of window
            'numchars = GetWindowText(hWndApp, buffer, Len(buffer))
            
            'wincapt$ = Left$(buffer, numchars)
        
            'find that window...
            'hWindow = FindWindow(vbNullString, wincapt$)
            'lngReturnValue = PostMessage(hWndApp, WM_CLOSE, vbNull, vbNull)
            'lngResult = WaitForSingleObject(hWndApp, INFINITE)
        'End If
    'End If
End Sub


Function OLEIsPlaying() As Boolean
    'determine if the OLE player is playing
    If OLEhInstance = 0 Then
        OLEIsPlaying = False
        Exit Function
    End If
    
    b = GetWinHandle(OLEhInstance)
    If b <> 0 Then
        OLEIsPlaying = True
    Else
        OLEIsPlaying = False
        OLEhInstance = 0
        OLEOpenedFile = ""
    End If
End Function


Function ProcIDFromWnd(ByVal hwnd As Long) As Long
   Dim idProc As Long
   
   ' Get PID for this HWnd
   GetWindowThreadProcessId hwnd, idProc
   
   ' Return PID
   ProcIDFromWnd = idProc
End Function
      
Function GetWinHandle(hInstance As Long) As Long
   Dim tempHwnd As Long
   
   ' Grab the first window handle that Windows finds:
   tempHwnd = FindWindow(vbNullString, vbNullString)
   
   ' Loop until you find a match or there are no more window handles:
   Do Until tempHwnd = 0
      ' Check if no parent for this window
      If GetParent(tempHwnd) = 0 Then
         ' Check for PID match
         If hInstance = ProcIDFromWnd(tempHwnd) Then
            ' Return found handle
            GetWinHandle = tempHwnd
            ' Exit search loop
            Exit Do
         End If
      End If
   
      ' Get the next window handle
      tempHwnd = GetWindow(tempHwnd, GW_HWNDNEXT)
   Loop
End Function



Sub OLEPlayFile(file As String)
    'play a file (using the VB shell command)
    On Error Resume Next

    Dim Scr_hDC As Long
    Scr_hDC = GetDesktopWindow()
    'OLEhInstance = ShellExecute(Scr_hDC, "Open", file, "", "C:\", SW_SHOWNORMAL)

    Dim appToPlay As String
    Dim fileToPlay As String
    
    appToPlay = DetermineDefaultApp(file)
    fileToPlay = GetShortName(file)
    If appToPlay <> "" Then
        OLEOpenedFile = file
        OLEhInstance = ShellExecute(Scr_hDC, "Open", appToPlay, fileToPlay, dummy, SW_SHOWNORMAL)
        'OLEhInstance = Shell(appToPlay + " " + file)
    End If
End Sub


