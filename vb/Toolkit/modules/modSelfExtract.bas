Attribute VB_Name = "modSelfExtract"
'==============================================================================
'TK3 Excutable Game Host
'Designed and Programmed by Colin James Fitzpatrick
'Copyright 2004
'==============================================================================
'This module adds files to the ends of other files

Option Explicit

Public Sub addToSelfExtract( _
                               selfExtract As String, _
                               WhatFile As String, _
                               SaveAs As String _
                                                  )

    On Error Resume Next

    Dim iFreeFile As Integer
    Dim iFreeFile2 As Integer
    Dim sBuffer As String
    Dim sBefore As String
    Dim size As String

    iFreeFile = FreeFile()

    Open selfExtract For Binary As iFreeFile
        sBefore = String(LOF(iFreeFile), chr(0))
        Get iFreeFile, , sBefore
    Close iFreeFile

    Open SaveAs For Output As iFreeFile
        iFreeFile2 = FreeFile
        Open WhatFile For Binary As iFreeFile2
            sBuffer = String(LOF(iFreeFile2), chr(0))
            Get iFreeFile2, , sBuffer
            size = LOF(iFreeFile2)
            size = String(10 - Len(size), "0") & size
            Print #iFreeFile, sBefore & sBuffer & size & "Y"
        Close iFreeFile2
    Close iFreeFile
    
End Sub

