Attribute VB_Name = "modSelfExtract"
'==============================================================================
'TK3 Compilation Procedures
'Designed and Programmed by Colin James Fitzpatrick
'Copyright 2004
'==============================================================================

Option Explicit

Public Sub addToSelfExtract( _
                               ByVal selfExtract As String, _
                               ByVal WhatFile As String, _
                               ByVal SaveAs As String _
                                                  )

    On Error Resume Next

    Dim iFreeFile As Integer
    Dim iFreeFile2 As Integer
    Dim sBuffer As String
    Dim sBefore As String
    Dim size As String

    iFreeFile = FreeFile()

    Open selfExtract For Binary Access Read As iFreeFile
        sBefore = String(LOF(iFreeFile), chr(0))
        Get iFreeFile, , sBefore
    Close iFreeFile

    Open SaveAs For Output Access Write As iFreeFile
        iFreeFile2 = FreeFile()
        Open WhatFile For Binary Access Read As iFreeFile2
            sBuffer = String(LOF(iFreeFile2), chr(0))
            Get iFreeFile2, , sBuffer
            size = LOF(iFreeFile2)
            size = String(10 - Len(size), "0") & size
            Print #iFreeFile, sBefore & sBuffer & size & "Y"
        Close iFreeFile2
    Close iFreeFile
    
End Sub
