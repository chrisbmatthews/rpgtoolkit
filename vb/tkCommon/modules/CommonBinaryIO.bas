Attribute VB_Name = "CommonBinaryIO"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'binary file IO routines

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Swapped +s for &s where appropriate
' + Removed obsolete code
' + Removed variants
'
'=======================================================

Option Explicit

Public Function fread(ByVal fileNo As Integer) As String
    'read the next entry from fileNo
    'from a text file
    On Error Resume Next
    Line Input #fileNo, fread
End Function

Public Function BinReadString(ByVal fileNum As Integer) As String
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

Public Function BinWriteInt(ByVal fileNo As Integer, ByVal intToWrite As Integer) As Integer
    'write an integer to the file
    'On Error Resume Next
    
    Put fileNo, , intToWrite
End Function

Public Function BinWriteLong(ByVal fileNo As Integer, ByVal longToWrite As Long) As Integer
    'write a long to the file
    On Error Resume Next
    
    Put fileNo, , longToWrite
End Function

Public Function BinWriteByte(ByVal fileNo As Integer, ByVal byteToWrite As Byte) As Integer
    'write a byte to the file
    On Error Resume Next
    
    Put fileNo, , byteToWrite
End Function

Public Function BinReadInt(ByVal fileNo As Integer) As Integer
    'read an integer to the file
    On Error Resume Next
    
    Dim ret As Integer
    Get fileNo, , ret
    BinReadInt = ret
End Function

Public Function BinReadLong(ByVal fileNo As Integer) As Long
    'read a long to the file
    On Error Resume Next
    
    Dim ret As Long
    Get fileNo, , ret
    BinReadLong = ret
End Function

Public Function BinReadByte(ByVal fileNo As Integer) As Byte
    'read an byte to the file
    On Error Resume Next
    
    Dim ret As Byte
    Get fileNo, , ret
    BinReadByte = ret
End Function

#If isToolkit = 0 Then

    Public Function BinReadDouble(ByVal fileNo As Integer) As Double
        'write a long to the file
        On Error Resume Next

        Get fileNo, , BinReadDouble
    End Function

    Public Sub BinWriteDouble(ByVal fileNo As Integer, ByVal doubleToWrite As Long)
        'write a long to the file
        On Error Resume Next
        Put fileNo, , doubleToWrite
    End Sub

#End If

Public Function BinWriteString(ByVal fileNum As Integer, ByVal theString As String) As Long
    'writes a string to a binary file...
    'terminates the string with a NULL (0)
    'character
    'does not track the writable position (offset) in the file (handled automatically)
    On Error Resume Next
    
    Dim part As String * 1
    
    Dim Length As Long, t As Long
    Length = Len(theString)

    For t = 1 To Length
        part = Mid(theString, t, 1)
        Put fileNum, , part
    Next t
    Put fileNum, , chr$(0)
End Function

