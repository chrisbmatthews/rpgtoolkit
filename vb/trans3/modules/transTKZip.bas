Attribute VB_Name = "transTKZip"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: zip files :: extracting
'=========================================================================

Option Explicit

'=========================================================================
' Member ZIP extraction declarations
'=========================================================================
Private Declare Function ZIPOpen Lib "actkrt3.dll" (ByVal fileOpen As String) As Long
Private Declare Function ZIPGetFileCount Lib "actkrt3.dll" () As Long
Private Declare Function ZIPGetFile Lib "actkrt3.dll" (ByVal fileNum As Long, ByVal fileout As String) As Long

'=========================================================================
' Public ZIP extraction declarations
'=========================================================================
Public Declare Function ZIPExtract Lib "actkrt3.dll" (ByVal fileToExtract As String, ByVal SaveAs As String) As Long

'=========================================================================
' Integral variables
'=========================================================================
Public PakFileMounted As String     'filename of the pakfile we have mounted
Public pakFileRunning As Boolean    'is the game running from the pakfile?
Public PakTempPath As String        'temp file path

'=========================================================================
' Extract a zip into a \ terminated directory
'=========================================================================
Public Sub extractDir( _
                         ByVal zipFile As String, _
                         ByVal extractInto As String _
                                                       )
    On Error Resume Next
    Dim fileIdx As Long, cnt As Long, perc As Long
    Call ZIPOpen(zipFile)
    cnt = ZIPGetFileCount()
    Call statusbar.Show
    For fileIdx = 0 To (cnt - 1)
        perc = Int(((fileIdx + 1) / cnt) * 100)
        Call statusbar.setStatus(perc, "")
        Call ZIPExtract(GetZipFilename(fileIdx), extractInto & GetZipFilename(fileIdx))
    Next fileIdx
    Call ZIPClose
    Call Unload(statusbar)
End Sub

'=========================================================================
' Create temporary PAK folders
'=========================================================================
Public Sub CreatePakTemp()

    On Error Resume Next

    PakTempPath = TempDir() & "TKCACHE\"
    projectPath = ""
    
    Call MkDir(PakTempPath)
    Call MkDir(PakTempPath & tilePath)
    Call MkDir(PakTempPath & brdPath)
    Call MkDir(PakTempPath & temPath)
    Call MkDir(PakTempPath & spcPath)
    Call MkDir(PakTempPath & bkgPath)
    Call MkDir(PakTempPath & mediaPath)
    Call MkDir(PakTempPath & prgPath)
    Call MkDir(PakTempPath & fontPath)
    Call MkDir(PakTempPath & itmPath)
    Call MkDir(PakTempPath & enePath)
    Call MkDir(PakTempPath & statusPath)
    Call MkDir(PakTempPath & bmpPath)
    Call MkDir(PakTempPath & miscPath)
    Call MkDir(PakTempPath & plugPath)

End Sub

'=========================================================================
' Get the filename in a ZIP at fileNum
'=========================================================================
Public Function GetZipFilename(ByVal fileNum As Long) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = ZIPGetFile(fileNum, ret)
    GetZipFilename = Mid$(ret, 1, le)
End Function

'=========================================================================
' Delete the temporary PAK folders
'=========================================================================
Public Sub DeletePakTemp()

    On Error Resume Next
    
    'Get the location of the temp directory
    If PakTempPath = "" Then
        PakTempPath = TempDir() & "TKCache\"
        projectPath = PakTempPath
    End If

    'Kill it all!!! (:P)
    Call deletePath(PakTempPath$ & tilePath$)
    Call deletePath(PakTempPath$ & brdPath$)
    Call deletePath(PakTempPath$ & temPath$)
    Call deletePath(PakTempPath$ & spcPath$)
    Call deletePath(PakTempPath$ & bkgPath$)
    Call deletePath(PakTempPath$ & mediaPath$)
    Call deletePath(PakTempPath$ & prgPath$)
    Call deletePath(PakTempPath$ & fontPath$)
    Call deletePath(PakTempPath$ & itmPath$)
    Call deletePath(PakTempPath$ & enePath$)
    Call deletePath(PakTempPath$ & statusPath$)
    Call deletePath(PakTempPath$ & bmpPath$)
    Call deletePath(PakTempPath$ & miscPath$)
    Call deletePath(PakTempPath$ & plugPath$)
    Call deletePath(PakTempPath)
    
    PakTempPath = ""
    
    If runningAsEXE Then
        Call Kill(TempDir & "actkrt3.dll")
        Call Kill(TempDir & "freeImage.dll")
        Call Kill(TempDir & "temp.tpk")
    End If

End Sub

'=========================================================================
' Kill all files in a directory and the directory itself
'=========================================================================
Public Sub deletePath(ByVal path As String)

    On Error Resume Next
    
    Dim aFile As String
    aFile = Dir(path & "*.*")
    Do While aFile <> ""
        Call Kill(path & aFile)
        aFile = Dir()
    Loop
    
    Call RmDir(path)

End Sub

'=========================================================================
' Setup a PAK file
'=========================================================================
Public Sub setupPakSystem(ByVal thePakFile As String)

    On Error Resume Next
    
    If Not PAKTestSystem() Then
        gGameState = GS_QUIT
        Exit Sub
    End If
    
    'setup the pakfile system using the pakfile
    PakFileMounted = thePakFile
    pakFileRunning = True
    Call DeletePakTemp
    Call CreatePakTemp
    
    'Let's make this a lot less 'painful'... extract the files now...
    Call extractDir(thePakFile, TempDir & "tkcache\")

    'Now open it 'normally'...
    Call ZIPOpen(thePakFile)

End Sub

'=========================================================================
' Shutdown the PAK system
'=========================================================================
Public Sub shutdownPakSystem()
    On Error Resume Next
    Call ZIPClose
    Call DeletePakTemp
End Sub
