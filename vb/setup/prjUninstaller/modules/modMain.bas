Attribute VB_Name = "modMain"
Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long

'=========================================================================
' Main entry point
'=========================================================================
Public Sub Main()

    If (MsgBox("This will uninstall the RPGToolkit, version 3; your game projects will not be removed. Proceed?", vbCritical Or vbOKCancel Or vbDefaultButton2, "Uninstaller") = vbOK) Then

        ' Get path to TK3
        Dim strPath As String
        strPath = GetSetting("RPGToolkit3", "Settings", "Path")

        ' Blow it away
        Call deletePath(strPath & "help\help1_std_files\")
        Call deletePath(strPath & "help\")
        Call deletePath(strPath & "game\basic\Bitmap\")
        Call deletePath(strPath & "game\basic\Bkrounds\")
        Call deletePath(strPath & "game\basic\Boards\")
        Call deletePath(strPath & "game\basic\Chrs\")
        Call deletePath(strPath & "game\basic\Enemy\")
        Call deletePath(strPath & "game\basic\Font\")
        Call deletePath(strPath & "game\basic\Item\")
        Call deletePath(strPath & "game\basic\Media\")
        Call deletePath(strPath & "game\basic\Misc\")
        Call deletePath(strPath & "game\basic\Plugin\")
        Call deletePath(strPath & "game\basic\Prg\")
        Call deletePath(strPath & "game\basic\Spcmove\")
        Call deletePath(strPath & "game\basic\StatusE\")
        Call deletePath(strPath & "game\basic\Tiles\")
        Call deletePath(strPath & "game\basic\")
        Call deletePath(strPath & "resources\")
        Call deletePath(strPath)
        Call deletePath(StartMenuDir() & "RPG Toolkit 3\")

        ' Kill registry keys
        Call RegDeleteKey(&H80000002, "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\RPGToolkit3\")

        Call MsgBox("The RPGToolkit, version 3 was successfully uninstalled!", , "Uninstaller")

    End If

End Sub

'=========================================================================
' Kill all files in a directory and the directory itself
'=========================================================================
Private Sub deletePath(ByVal path As String)

    On Error Resume Next
    
    Dim aFile As String
    aFile = Dir(path & "*.*")
    Do While (LenB(aFile))
        Call Kill(path & aFile)
        aFile = Dir()
    Loop
    
    Call RmDir(path)

End Sub
