Attribute VB_Name = "modSelfExtract"
'==============================================================================
'TK3 Excutable Game Host
'Designed and Programmed by Colin James Fitzpatrick
'Copyright 2004
'==============================================================================
'This module removes files attached to the end of other files

Option Explicit

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



