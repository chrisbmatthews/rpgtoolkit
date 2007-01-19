Attribute VB_Name = "CommontkMD5"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'=========================================================================
' Interface with actkrt3.dll :: MD5 hashing
'=========================================================================

Option Explicit

'=========================================================================
' Declarations for actkrt3.dll MD5 exports
'=========================================================================

Private Declare Function MD5String Lib "actkrt3.dll" (ByVal strToEncode As String, ByVal strBuffer As String) As Long
Private Declare Function MD5File Lib "actkrt3.dll" (ByVal strFileToEncode As String, ByVal strBuffer As String) As Long

'=========================================================================
' Encode a string
'=========================================================================
Public Function md5EncodeString(ByVal strString As String) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = MD5String(strString, ret)
    md5EncodeString = Mid$(ret, 1, le)
End Function

'=========================================================================
' Encode a file
'=========================================================================
Public Function md5EncodeFile(ByVal strFile As String) As String
    On Error Resume Next
    Dim ret As String * 400
    Dim le As Long
    le = MD5File(strFile, ret)
    md5EncodeFile = Mid$(ret, 1, le)
End Function
