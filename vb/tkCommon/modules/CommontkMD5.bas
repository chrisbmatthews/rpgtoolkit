Attribute VB_Name = "CommontkMD5"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'md5 routines
Option Explicit

Declare Function MD5String Lib "actkrt3.dll" (ByVal strToEncode As String, ByVal strBuffer As String) As Long

Declare Function MD5File Lib "actkrt3.dll" (ByVal strFileToEncode As String, ByVal strBuffer As String) As Long

Function md5EncodeString(ByVal strString As String) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = MD5String(strString, ret)
    md5EncodeString = Mid$(ret, 1, le)
End Function

Function md5EncodeFile(ByVal strFile As String) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = MD5File(strFile, ret)
    md5EncodeFile = Mid$(ret, 1, le)
End Function


