Attribute VB_Name = "toolkitTKZip"
'=========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: zip files :: compressing
'=========================================================================

Option Explicit

'=========================================================================
' ZIP file declarations
'=========================================================================
Private Declare Function ZIPCreate Lib "actkrt3.dll" (ByVal fileCreate As String, ByVal TackOntoEndYN As Long) As Long
Private Declare Function ZIPCloseNew Lib "actkrt3.dll" () As Long
Private Declare Function ZIPAdd Lib "actkrt3.dll" (ByVal fileToAdd As String, ByVal fileAddAs As String) As Long

'=========================================================================
' Directory search declarations
'=========================================================================
Private Const MAX_PATH = 260
Private Const INVALID_HANDLE_VALUE = -1
Private Const FILE_ATTRIBUTE_DIRECTORY = &H10

Private Type FILETIME
   dwLowDateTime As Long
   dwHighDateTime As Long
End Type

Private Type WIN32_FIND_DATA
   dwFileAttributes As Long
   ftCreationTime As FILETIME
   ftLastAccessTime As FILETIME
   ftLastWriteTime As FILETIME
   nFileSizeHigh As Long
   nFileSizeLow As Long
   dwReserved0 As Long
   dwReserved1 As Long
   cFileName As String * MAX_PATH
   cAlternate As String * 14
End Type

Private Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Long
Private Declare Function FindNextFile Lib "kernel32" Alias "FindNextFileA" (ByVal hFindFile As Long, lpFindFileData As WIN32_FIND_DATA) As Long
Private Declare Function FindClose Lib "kernel32" (ByVal hFindFile As Long) As Long

'=========================================================================
' Create a PAK file
'=========================================================================
Public Sub CreatePakFile(ByVal file As String)
    
    Dim fileCount As Long, totalFiles As Long, currentDir As String
    
    totalFiles = countDirectoryFiles(projectPath, True)
    If totalFiles = 0 Then
        MsgBox "Unable to access game files, cannot compile game", vbCritical
        Exit Sub
    End If
    
    If fileExists(file) Then Kill file
    Call ZIPCreate(file, 0)

    'Add the main game file separately as it resides outside the project path.
    Call ZIPAdd(gamPath & mainFile, "main.gam")
    statusBar.Show
    Call statusBar.setStatus(0, "Adding main.gam")
    fileCount = fileCount + 1
    
    'Change the directory in order that the projectPath string is not present in the file structure.
    currentDir = CurDir()
    ChDir (projectPath)
    Call zipDirectory(vbNullString, fileCount, totalFiles, True)
    ChDir (currentDir)
    
    Call ZIPCloseNew
    Unload statusBar

End Sub

'=========================================================================
' Add files in a directory or subdirectories to a zip.
'=========================================================================
Private Sub zipDirectory(ByVal path As String, ByRef fileCount As Long, ByVal totalFiles As Long, ByVal recurse As Boolean): On Error Resume Next

    Dim count As Long, hFind As Long, file As String, wfd As WIN32_FIND_DATA
    
    hFind = FindFirstFile(path & "*", wfd)
    If hFind <> INVALID_HANDLE_VALUE Then
        Do
            DoEvents
            file = trimNulls(wfd.cFileName)
            If file <> "." And file <> ".." Then
                'Avoid the current and parent directories
                If wfd.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY Then
                    'Recurse.
                    If recurse Then Call zipDirectory(path & file & "\", fileCount, totalFiles, True)
                Else
                    'File.
                    fileCount = fileCount + 1
                    Call ZIPAdd(path & file, path & file)
                    Call statusBar.setStatus(100 * fileCount / totalFiles, "Adding " & path & file)
                End If
            End If
            If FindNextFile(hFind, wfd) = 0 Then Exit Do
        Loop
    End If
    
End Sub

'=========================================================================
' WIN32_FIND_DATA contains a fixed-length string, padded with null chars
'=========================================================================
Private Function trimNulls(ByVal file As String) As String: On Error Resume Next
    trimNulls = IIf(InStr(file, chr$(0)) > 0, Left$(file, InStr(file, chr$(0)) - 1), file)
End Function

'=========================================================================
' Return the number of files in a directory or subdirectories
'=========================================================================
Private Function countDirectoryFiles(ByVal path As String, ByVal recurse As Boolean) As Long: On Error Resume Next

    Dim count As Long, hFind As Long, file As String, wfd As WIN32_FIND_DATA
    
    hFind = FindFirstFile(path & "*", wfd)
    If hFind <> INVALID_HANDLE_VALUE Then
        Do
            file = trimNulls(wfd.cFileName)
            If file <> "." And file <> ".." Then
                'Avoid the current and parent directories
                If wfd.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY Then
                    'Recurse.
                    If recurse Then count = count + countDirectoryFiles(path & file & "\", True)
                Else
                    'Normal file.
                    count = count + 1
                End If
            End If
            If FindNextFile(hFind, wfd) = 0 Then Exit Do
        Loop
    End If
    
    countDirectoryFiles = count
    
End Function
