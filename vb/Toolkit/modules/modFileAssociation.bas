Attribute VB_Name = "modFileAssociation"
Option Explicit

Private Const REG_SZ As Long = &H1
Private Const REG_DWORD As Long = &H4
Private Const HKEY_CLASSES_ROOT As Long = &H80000000
Private Const HKEY_CURRENT_USER As Long = &H80000001
Private Const HKEY_LOCAL_MACHINE As Long = &H80000002
Private Const HKEY_USERS As Long = &H80000003
Private Const ERROR_SUCCESS As Long = 0
Private Const ERROR_BADDB As Long = 1009
Private Const ERROR_BADKEY As Long = 1010
Private Const ERROR_CANTOPEN As Long = 1011
Private Const ERROR_CANTREAD As Long = 1012
Private Const ERROR_CANTWRITE As Long = 1013
Private Const ERROR_OUTOFMEMORY As Long = 14
Private Const ERROR_INVALID_PARAMETER As Long = 87
Private Const ERROR_ACCESS_DENIED As Long = 5
Private Const ERROR_MORE_DATA As Long = 234
Private Const ERROR_NO_MORE_ITEMS As Long = 259
Private Const KEY_ALL_ACCESS As Long = &H3F
Private Const REG_OPTION_NON_VOLATILE As Long = 0

Private Declare Function RegCloseKey Lib "advapi32.dll" _
    (ByVal hKey As Long) As Long

Private Declare Function RegCreateKeyEx _
    Lib "advapi32.dll" Alias "RegCreateKeyExA" _
    (ByVal hKey As Long, _
    ByVal lpSubKey As String, _
    ByVal Reserved As Long, _
    ByVal lpClass As String, _
    ByVal dwOptions As Long, _
    ByVal samDesired As Long, _
    ByVal lpSecurityAttributes As Long, _
    phkResult As Long, _
    lpdwDisposition As Long) As Long

Private Declare Function RegOpenKeyEx _
    Lib "advapi32.dll" Alias "RegOpenKeyExA" _
    (ByVal hKey As Long, _
    ByVal lpSubKey As String, _
    ByVal ulOptions As Long, _
    ByVal samDesired As Long, _
    phkResult As Long) As Long

Private Declare Function RegSetValueExString _
    Lib "advapi32.dll" Alias "RegSetValueExA" _
    (ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal Reserved As Long, _
    ByVal dwType As Long, _
    ByVal lpValue As String, _
    ByVal cbData As Long) As Long

Private Declare Function RegSetValueExLong _
    Lib "advapi32.dll" Alias "RegSetValueExA" _
    (ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal Reserved As Long, _
    ByVal dwType As Long, _
    lpValue As Long, _
    ByVal cbData As Long) As Long

Public Sub CreateAssociation(sExtension As String, sApplication As String, sAppPath As String)
    Dim sPath As String
    Dim sAppExe As String
    sAppExe = sApplication
    CreateNewKey "." & sExtension, HKEY_CLASSES_ROOT
    SetKeyValue "." & sExtension, "", sApplication & ".Document", REG_SZ
    CreateNewKey sApplication & ".Document\shell\open\command", HKEY_CLASSES_ROOT
    SetKeyValue sApplication & ".Document", "", sApplication, REG_SZ
    sPath = sAppPath & " %1"
    SetKeyValue sApplication & ".Document\shell\open\command", "", sPath, REG_SZ
    CreateNewKey "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\." _
    & sExtension, HKEY_CURRENT_USER
    SetKeyValue "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\." _
    & sExtension, "Application", sAppExe, REG_SZ
    CreateNewKey "Applications\" & sAppExe & "\shell\open\command", HKEY_CLASSES_ROOT
    SetKeyValue "Applications\" & sAppExe & "\shell\open\command", "", sPath, REG_SZ
End Sub

Private Function SetValueEx(ByVal hKey As Long, _
    sValueName As String, _
    lType As Long, _
    vValue As Variant) As Long
    Dim nValue As Long
    Dim sValue As String

    Select Case lType
        Case REG_SZ
        sValue = vValue & chr$(0)
        SetValueEx = RegSetValueExString(hKey, _
        sValueName, _
        0&, _
        lType, _
        sValue, _
        Len(sValue))
        Case REG_DWORD
        nValue = vValue
        SetValueEx = RegSetValueExLong(hKey, _
        sValueName, _
        0&, _
        lType, _
        nValue, _
        4)
    End Select
End Function

Private Sub CreateNewKey(sNewKeyName As String, _
    lPredefinedKey As Long)
    Dim hKey As Long
    Dim result As Long
    Call RegCreateKeyEx(lPredefinedKey, _
    sNewKeyName, 0&, _
    vbNullString, _
    REG_OPTION_NON_VOLATILE, _
    KEY_ALL_ACCESS, 0&, hKey, result)
    Call RegCloseKey(hKey)
End Sub

Private Sub SetKeyValue(sKeyName As String, _
    sValueName As String, _
    vValueSetting As Variant, _
    lValueType As Long)
    Dim hKey As Long
    Call RegOpenKeyEx(HKEY_CLASSES_ROOT, _
    sKeyName, 0, _
    KEY_ALL_ACCESS, hKey)
    Call SetValueEx(hKey, _
    sValueName, _
    lValueType, _
    vValueSetting)
    Call RegCloseKey(hKey)
End Sub
