Attribute VB_Name = "CommonBinaryIO"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'binary file IO routines

Option Explicit

'FIXIT: Declare 'fread' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Function fread(ByVal fileNo As Integer) As Variant
    'read the next entry from fileNo
    'from a text file
    On Error Resume Next
'FIXIT: Declare 'Q' with an early-bound data type                                          FixIT90210ae-R1672-R1B8ZE
    Dim Q As Variant
    Line Input #fileNo, Q
    fread = Q
End Function

Function BinReadString(ByVal fileNum As Integer) As String
    'this function reads a string from a binary file.
    'fileNum is the file number
    'theString is a locationwhere the string will be placed.
    'does not need an offset- starts at the current file pointer.
    On Error Resume Next
    
    Dim theString As String
    Dim part As String * 1
    theString = ""
    
    Dim bDone As Boolean
    bDone = False
    Do While Not (bDone)
        Get #fileNum, , part
        If Asc(part) = 0 Then
            'the end of the string
            'is found!
            bDone = True
        Else
            theString = theString + part
        End If
    Loop
    
    BinReadString = theString
End Function



Function BinWriteInt(ByVal fileNo As Integer, ByVal intToWrite As Integer) As Integer
    'write an integer to the file
    'On Error Resume Next
    
    Put #fileNo, , intToWrite
End Function

Function BinWriteLong(ByVal fileNo As Integer, ByVal longToWrite As Long) As Integer
    'write a long to the file
    On Error Resume Next
    
    Put #fileNo, , longToWrite
End Function
Function BinWriteDouble(ByVal fileNo As Integer, ByVal doubleToWrite As Double) As Integer
    'write a double to the file
    On Error Resume Next
    
    Put #fileNo, , doubleToWrite
End Function

Function BinWriteByte(ByVal fileNo As Integer, ByVal byteToWrite As Byte) As Integer
    'write a byte to the file
    On Error Resume Next
    
    Put #fileNo, , byteToWrite
End Function

Function BinReadInt(ByVal fileNo As Integer) As Integer
    'read an integer to the file
    On Error Resume Next
    
    Dim ret As Integer
    Get #fileNo, , ret
    BinReadInt = ret
End Function

Function BinReadLong(ByVal fileNo As Integer) As Long
    'read a long to the file
    On Error Resume Next
    
    Dim ret As Long
    Get #fileNo, , ret
    BinReadLong = ret
End Function
Function BinReadDouble(ByVal fileNo As Integer) As Double
    'read a double from the file
    On Error Resume Next
    
    Dim ret As Double
    Get #fileNo, , ret
    BinReadDouble = ret
End Function

Function BinReadByte(ByVal fileNo As Integer) As Byte
    'read an byte to the file
    On Error Resume Next
    
    Dim ret As Byte
    Get #fileNo, , ret
    BinReadByte = ret
End Function



Function BinWriteString(ByVal fileNum As Integer, ByVal theString As String) As Long
    'writes a string to a binary file...
    'terminates the string with a NULL (0)
    'character
    'does not track the writable position (offset) in the file (handled automatically)
    On Error Resume Next
    
    Dim part As String * 1
    
    Dim length As Long, t As Long
    length = Len(theString)
    
    For t = 1 To length
        part = Mid$(theString, t, 1)
        Put #fileNum, , part
    Next t
    Put #fileNum, , chr$(0)
End Function

Function readBinaryString(ByVal fileNum As Integer, ByVal offPos As Long, ByRef theString As String) As Long
    'this function reads a string from a binary file.
    'fileNum is the file number
    'offPos is the offset position to start at.
    'theString is a locationwhere the string will be placed.
    'this returns the new offset position after reading
    On Error Resume Next
    
    Dim part As String * 1
    theString = ""
    Dim op As Long, bDone As Boolean
    op = offPos
    
    bDone = False
    Do While Not (bDone)
        Get #fileNum, op, part
        If Asc(part) = 0 Then
            'the end of the string
            'is found!
            bDone = True
        Else
            theString = theString + part
        End If
        op = op + 1
    Loop
    
    readBinaryString = op
End Function


Function writeBinaryString(ByVal fileNum As Integer, ByVal offsetPos As Long, ByVal theString As String) As Long
    'writes a string to a binary file...
    'terminates the string with a NULL (0)
    'character
    'returns the next writable position after the string.
    On Error Resume Next
    
    Dim part As String * 1
    
    Dim length As Long, offs As Long, t As Long
    length = Len(theString)
    offs = offsetPos
    
    For t = 1 To length
        part = Mid$(theString, t, 1)
        Put #fileNum, offs, part
        offs = offs + 1
    Next t
    Put #fileNum, offs, chr$(0)
    offs = offs + 1
    writeBinaryString = offs
End Function


