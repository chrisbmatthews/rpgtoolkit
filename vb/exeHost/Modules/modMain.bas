Attribute VB_Name = "modMain"
'==============================================================================
'TK3 Excutable Game Host
'Designed and Programmed by Colin James Fitzpatrick
'Copyright 2004
'==============================================================================

Option Explicit

Public Sub Main()

    On Error Resume Next

    ' This small program is the 'EXE Host' for Trans3. It allows games compiled
    ' to .exe to run without *any* other files. What's more, RC4 encrytion is
    ' used to keep the game's file safe.

    ' STEP 1:   Pull the files off this exe

    Dim file1 As String
    Dim file2 As String
    Dim file3 As String
    Dim file4 As String
    Dim file5 As String

    'Where to extract the files to
    file1 = TempDir & "freeImage.dll"
    file2 = TempDir & "actkrt3.dll"
    file3 = TempDir & App.EXEName & ".exe"
    file4 = TempDir & "temp2.tpk"
    file5 = TempDir & "audiere.dll"

    Dim sA As Long

    sA = selfExtract(App.Path & "\" & App.EXEName & ".exe", _
                file1)

    sA = selfExtract(App.Path & "\" & App.EXEName & ".exe", _
                file2, sA)

    sA = selfExtract(App.Path & "\" & App.EXEName & ".exe", _
                file3, sA)

    sA = selfExtract(App.Path & "\" & App.EXEName & ".exe", _
                file4, sA)

    sA = selfExtract(App.Path & "\" & App.EXEName & ".exe", _
                file5, sA)

    ' STEP 2:   Decrypt the files
    Dim RC4 As New clsRC4
    RC4.Key = "TK3 EXE HOST"
    RC4.EncryptFile file4, TempDir & "temp.tpk", True
    Kill file4

    ' STEP 3:   Record this directory so we know where to save files
    MkDir App.Path & "\saved"
    SaveSetting "TK3 EXE HOST", "Settings", "Save Path", App.Path & "\saved\"

    ' STEP 4:   Launch the game
    Shell file3 & " temp.tpk", vbNormalFocus
                                        
End Sub
