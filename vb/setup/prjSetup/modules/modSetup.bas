Attribute VB_Name = "modSetup"
'=========================================================================
' All contents copyright 2004, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Setup code
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function ZIPOpen Lib "tkzip.dll" (ByVal fileOpen As String) As Long
Private Declare Function ZIPGetFileCount Lib "tkzip.dll" () As Long
Private Declare Function ZIPGetFile Lib "tkzip.dll" (ByVal fileNum As Long, ByVal fileout As String) As Long
Private Declare Function ZIPExtract Lib "tkzip.dll" (ByVal fileToExtract As String, ByVal SaveAs As String) As Long
Private Declare Function ZIPClose Lib "tkzip.dll" () As Long
Private Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Any, ByVal Msg As Any, ByVal wParam As Any, ByVal lParam As Any) As Long
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Declare Function InitCommonControlsEx Lib "comctl32.dll" (ByRef iccex As tagInitCommonControlsEx) As Boolean

'=========================================================================
' Constants
'=========================================================================
Private Const REG_SZ = 1
Private Const HKEY_LOCAL_MACHINE = &H80000002
Private Const ICC_USEREX_CLASSES = &H200
Public Const RPGTOOLKIT_VERSION = "3.05"

'=======================================================================
' Common controls structure
'=======================================================================
Private Type tagInitCommonControlsEx
   lngSize As Long
   lngICC As Long
End Type

'=======================================================================
' Initiate the common controls
'=======================================================================
Public Function initCommonControls() As Boolean
    On Error Resume Next
    Dim iccex As tagInitCommonControlsEx
    iccex.lngSize = LenB(iccex)
    iccex.lngICC = ICC_USEREX_CLASSES
    Call InitCommonControlsEx(iccex)
    initCommonControls = (Err.Number = 0)
End Function

'=========================================================================
' Main entry point
'=========================================================================
Public Sub Main()
 
    ' First, initiate the common controls
    Call initCommonControls

    ' Check if same version is already installed
    If (GetSetting("RPGToolkit3", "Settings", "Version", vbNullString) = RPGTOOLKIT_VERSION) Then

        ' Alert the user
        If (MsgBox("Version " & RPGTOOLKIT_VERSION & " of the RPGToolkit appears to be already installed on this computer. It is recommended you uninstall (via ""Add or Remove Programs"") before attempting to install again. Proceed anyway?", vbDefaultButton2 Or vbYesNo) = vbNo) Then

            ' Do not proceed
            Exit Sub

        End If

    End If

    ' Finally, show the main form
    Call frmMain.Show

End Sub

'=========================================================================
' Register or unregister a COM server
'=========================================================================
Private Sub registerServer(ByRef strServer As String, ByVal hwnd As Long, Optional ByVal bRegister As Boolean = True)

    ' First, make sure the file exists
    If (GetAttr(strServer) And vbDirectory) Then Exit Sub

    ' Load the server
    Dim pServer As Long
    pServer = LoadLibrary(strServer)

    ' Obtain the procedure address we want
    Dim pProc As Long
    pProc = GetProcAddress(pServer, IIf(bRegister, "DllRegisterServer", "DllUnregisterServer"))

    ' Call the procedure
    Call CallWindowProc(pProc, hwnd, 0&, 0&, 0&)

    ' Unload the server
    Call FreeLibrary(pServer)

End Sub

'=========================================================================
' Pull a file off another file
'=========================================================================
Private Function selfExtract( _
                               ByVal file As String, _
                               ByVal saveExtractedFileAs As String, _
                               Optional ByVal startAt As Long _
                                                                ) As Long

    On Error Resume Next

    Dim iFreeFile As Integer
    Dim theFile As String
    Dim size As String

    iFreeFile = FreeFile()

    Open file For Binary As iFreeFile

        Dim minus As Long
        Dim done As Boolean
        Do Until done
            Seek #iFreeFile, LOF(iFreeFile) - 12 - startAt - minus
            size = String(11, Chr(0))
            Get iFreeFile, , size
            If Right(size, 1) <> "Y" Then
                minus = minus + 1
            Else
                done = True
            End If
            DoEvents
        Loop
        
        Seek #iFreeFile, LOF(iFreeFile) - 12 - startAt - minus
        size = String(10, Chr(0))
        Get iFreeFile, , size
        size = CCur(size)
        Seek #iFreeFile, LOF(iFreeFile) - CCur(size) - 12 - startAt - minus
        Dim toTakeOff As String
        toTakeOff = String(size + 12, Chr(0))

        Seek #iFreeFile, LOF(iFreeFile) - CCur(size) - startAt - minus
        Get iFreeFile, , toTakeOff

        Seek #iFreeFile, LOF(iFreeFile) - 12 - CCur(size) - startAt - minus
        theFile = String(size, Chr(0))
        Get iFreeFile, , theFile

    Close iFreeFile

    selfExtract = CCur(size) + 12 + startAt + minus

    Open saveExtractedFileAs For Output As iFreeFile
        Print #iFreeFile, theFile
    Close iFreeFile

End Function

'=========================================================================
' Perform the installation
'=========================================================================
Public Sub performSetup()

    On Error Resume Next

    Dim strPath As String, strExe As String
    strPath = frmMain.txtDirectory.Text
    If (RightB$(strPath, 2) <> "\") Then strPath = strPath & "\"
    strExe = App.Path & "\" & App.EXEName & ".exe"

    ' Make sure destination directory exists
    Call MkDir(strPath)

    ' Change status text
    frmMain.progress.Text = "Initializing..."

    ' Obtain tkzip.dll
    Dim lngPosistion As Long
    lngPosistion = selfExtract(strExe, "tkzip.dll")

    ' Obtain zip.zip
    Call selfExtract(strExe, "zip.zip", lngPosistion)

    ' Extract the files
    Call extractDir("zip.zip", strPath)

    ' Register ActiveX controls
    Call registerServer(strPath & "richtx32.ocx", frmMain.hwnd)
    Call registerServer(strPath & "tabctl32.ocx", frmMain.hwnd)

    ' Store some settings
    Call SaveSetting("RPGToolkit3", "Settings", "Path", strPath)
    Call SaveSetting("RPGToolkit3", "Settings", "Group", IIf(frmMain.chkCreateStartMenuGroup.Value, frmMain.txtGroupName, vbNullString))
    Call SaveSetting("RPGToolkit3", "Settings", "Version", RPGTOOLKIT_VERSION)

    ' Add an entry to Add or Remove programs
    Dim hKey As Long, hNewKey As Long
    Call RegOpenKey(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\", hKey)
    Call RegCreateKey(hKey, "RPGToolkit3", hNewKey)
    Call RegCloseKey(hKey)
    hKey = hNewKey
    Call RegSetValueEx(hKey, "DisplayName", 0, REG_SZ, ByVal "RPGToolkit, Version " & RPGTOOLKIT_VERSION, Len("RPGToolkit, Version " & RPGTOOLKIT_VERSION))
    Call RegSetValueEx(hKey, "UninstallString", 0, REG_SZ, ByVal (strPath & "uninstall.exe"), Len(strPath & "uninstall.exe"))
    Call RegSetValueEx(hKey, "DisplayIcon", 0, REG_SZ, ByVal (strPath & "trans3.exe,0"), Len(strPath & "trans3.exe,0"))
    Call RegSetValueEx(hKey, "URLInfoAbout", 0, REG_SZ, ByVal "http://www.toolkitzone.com", Len("http://www.toolkitzone.com"))
    Call RegSetValueEx(hKey, "URLUpdateInfo", 0, REG_SZ, ByVal "http://www.toolkitzone.com", Len("http://www.toolkitzone.com"))
    Call RegCloseKey(hKey)

    ' Make sure the start menu group has no trailing "\"
    Dim lngLength As Long
    lngLength = LenB(frmMain.txtGroupName)
    If (lngLength) Then
        Dim rB As String
        rB = RightB$(frmMain.txtGroupName, 2)
        If (rB = "\" Or rB = "/") Then
            frmMain.txtGroupName = LeftB$(frmMain.txtGroupName, lngLength - 2)
        End If
    End If

    ' Create start menu icons
    If (frmMain.chkCreateStartMenuGroup.Value) Then
        Call FileCopy(strPath & "vb5stkit.dll", "vb5stkit.dll")
        Call MkDir(StartMenuDir() & frmMain.txtGroupName)
        Call MakeShortcut(strPath & "trans3.exe", "", frmMain.txtGroupName & "\Game Engine")
        Call MakeShortcut(strPath & "trans3.exe", "demo.gam", frmMain.txtGroupName & "\Play Demo Game")
        Call MakeShortcut(strPath & "toolkit3.exe", "", frmMain.txtGroupName & "\RPG Toolkit Editor")
    End If

    ' Clean up
    Call Kill("zip.zip")
    Call Kill("vb5stkit.dll")
    Call Kill("tkzip.dll")

End Sub

'=========================================================================
' Extract a zip into a \ terminated directory
'=========================================================================
Private Sub extractDir( _
                         ByVal zipFile As String, _
                         ByVal extractInto As String _
                                                       )
    On Error Resume Next
    Dim fileIdx As Long, cnt As Long, perc As Long
    Call ZIPOpen(zipFile)
    cnt = ZIPGetFileCount()
    frmMain.progress.Min = 0
    frmMain.progress.Max = cnt
    For fileIdx = 0 To (cnt - 1)
        Dim strName As String
        strName = GetZipFilename(fileIdx)
        frmMain.progress.Value = fileIdx
        frmMain.progress.Text = CStr(Round(frmMain.progress.Percent)) & "%"
        frmMain.lblCurrentFile.Caption = Replace(strName, "/", "\")
        Call ZIPExtract(strName, extractInto & strName)
        DoEvents
    Next fileIdx
    Call ZIPClose
End Sub

'=========================================================================
' Get the filename in a ZIP at fileNum
'=========================================================================
Private Function GetZipFilename(ByVal fileNum As Long) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = ZIPGetFile(fileNum, ret)
    GetZipFilename = Mid$(ret, 1, le)
End Function
