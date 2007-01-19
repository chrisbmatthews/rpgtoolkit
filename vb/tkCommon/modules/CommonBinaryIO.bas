Attribute VB_Name = "CommonBinaryIO"
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
' Binary input and output
'=========================================================================

Option Explicit

'=========================================================================
' Read a line from a file
'=========================================================================
Public Function fread(ByVal fileNo As Integer) As String
    Line Input #fileNo, fread
End Function

'=========================================================================
' Read a string from a file
'=========================================================================
Public Function BinReadString(ByVal fileNum As Integer) As String
    On Error Resume Next
    Dim theString As String
    Dim part As String * 1
    theString = vbNullString
    Dim bDone As Boolean
    bDone = False
    Do Until bDone
        Get fileNum, , part
        If Asc(part) = 0 Then
            'the end of the string
            'is found!
            bDone = True
        Else
            theString = theString & part
        End If
    Loop
    BinReadString = theString
End Function

'=========================================================================
' Read an int from a file
'=========================================================================
Public Function BinWriteInt(ByVal fileNo As Integer, ByVal intToWrite As Integer) As Integer
    On Error Resume Next
    Put fileNo, , intToWrite
End Function

'=========================================================================
' Read a long from a file
'=========================================================================
Public Function BinWriteLong(ByVal fileNo As Integer, ByVal longToWrite As Long) As Integer
    On Error Resume Next
    Put fileNo, , longToWrite
End Function

'=========================================================================
' Read a byte from a file
'=========================================================================
Public Function BinWriteByte(ByVal fileNo As Integer, ByVal byteToWrite As Byte) As Integer
    On Error Resume Next
    Put fileNo, , byteToWrite
End Function

'=========================================================================
' Read an int from a file
'=========================================================================
Public Function BinReadInt(ByVal fileNo As Integer) As Integer
    On Error Resume Next
    Dim ret As Integer
    Get fileNo, , ret
    BinReadInt = ret
End Function

'=========================================================================
' Read a long from a file
'=========================================================================
Public Function BinReadLong(ByVal fileNo As Integer) As Long
    On Error Resume Next
    Dim ret As Long
    Get fileNo, , ret
    BinReadLong = ret
End Function

'=========================================================================
' Read a byte from a file
'=========================================================================
Public Function BinReadByte(ByVal fileNo As Integer) As Byte
    On Error Resume Next
    Dim ret As Byte
    Get fileNo, , ret
    BinReadByte = ret
End Function

'=========================================================================
' Read a double from a file
'=========================================================================
Public Function BinReadDouble(ByVal fileNo As Integer) As Double
    On Error Resume Next
    Get fileNo, , BinReadDouble
End Function

'=========================================================================
' Write a double to a file
'=========================================================================
Public Sub BinWriteDouble(ByVal fileNo As Integer, ByVal doubleToWrite As Double)
    On Error Resume Next
    Put fileNo, , doubleToWrite
End Sub

'=========================================================================
' Write a string to a file
'=========================================================================
Public Function BinWriteString(ByVal fileNum As Integer, ByVal theString As String) As Long
    On Error Resume Next
    Dim part As String * 1
    Dim Length As Long, t As Long
    Length = Len(theString)
    For t = 1 To Length
        part = Mid$(theString, t, 1)
        Put fileNum, , part
    Next t
    Put fileNum, , vbNullChar
End Function
