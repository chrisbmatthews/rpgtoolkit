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
' Member ZIP extraction declarations
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

'=========================================================================
' Constants
'=========================================================================
Private Const REG_SZ = 1
Private Const HKEY_LOCAL_MACHINE = &H80000002

'=========================================================================
' Pull a file off another file
'=========================================================================
Public Function selfExtract( _
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
    strPath = frmMain.txtDirecory.Text
    If (RightB$(strPath, 2) <> "\") Then strPath = strPath & "\"
    strExe = App.Path & "\" & App.EXEName & ".exe"

    ' Make sure destination directory exists
    Call MkDir(strPath)

    ' Obtain tkzip.dll
    Dim lngPosistion As Long
    lngPosistion = selfExtract(strExe, "tkzip.dll")

    ' Obtain zip.zip
    Call selfExtract(strExe, "zip.zip", lngPosistion)

    ' Extract the files
    Call extractDir("zip.zip", strPath)

    ' Register ActiveX controls
    Call Shell("regsvr32 /s """ & strPath & "richtx32.ocx""")
    Call Shell("regsvr32 /s """ & strPath & "tabctl32.ocx""")

    ' Store path in a key
    Call SaveSetting("RPGToolkit3", "Settings", "Path", strPath)

    ' Add an entry to Add or Remove programs
    Dim hKey As Long, hNewKey As Long
    Call RegOpenKey(HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\", hKey)
    Call RegCreateKey(hKey, "RPGToolkit3", hNewKey)
    Call RegCloseKey(hKey)
    hKey = hNewKey
    Call RegSetValueEx(hKey, "DisplayName", 0, REG_SZ, ByVal "RPGToolkit, Version 3.05", Len("RPGToolkit, Version 3.05"))
    Call RegSetValueEx(hKey, "UninstallString", 0, REG_SZ, ByVal (strPath & "uninstall.exe"), Len(strPath & "uninstall.exe"))
    Call RegSetValueEx(hKey, "DisplayIcon", 0, REG_SZ, ByVal (strPath & "trans3.exe,0"), Len(strPath & "trans3.exe,0"))
    Call RegCloseKey(hKey)

    ' Create start menu icons
    Call FileCopy(strPath & "vb5stkit.dll", "vb5stkit.dll")
    Call MkDir(StartMenuDir() & "RPG Toolkit 3")
    Call MakeShortcut(strPath & "trans3.exe", "", "RPG Toolkit 3\Game Engine")
    Call MakeShortcut(strPath & "trans3.exe", "demo.gam", "RPG Toolkit 3\Play Demo Game")
    Call MakeShortcut(strPath & "toolkit3.exe", "", "RPG Toolkit 3\RPG Toolkit Editor")

    ' Clean up
    Call Kill("zip.zip")

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
    ' Call statusBar.Show
    For fileIdx = 0 To (cnt - 1)
        perc = (((fileIdx + 1) \ cnt) * 100)
        ' Call statusBar.setStatus(perc, vbNullString)
        Dim strName As String
        strName = GetZipFilename(fileIdx)
        frmMain.shpProgress.Width = perc * frmMain.shpPogressMax.Width / 100
        frmMain.lblProgress = CStr(perc) & "% complete"
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
