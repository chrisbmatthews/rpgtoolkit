Attribute VB_Name = "CommonParse"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'simple string parsing...
Option Explicit

Public Function countSubStrings(ByVal theString As String, ByVal stringSeperator As String) As Long
    'count the numbver of substrings contained in the string
    'seperated by stringSeperator
    On Error Resume Next
    
    If theString = "" Then
        countSubStrings = 0
        Exit Function
    End If
    
    Dim toRet As Long
    toRet = 1
    
    Dim t As Long
    Dim part As String
    
    For t = 1 To Len(theString)
        part = Mid$(theString, t, 1)
        If part = stringSeperator Then
            toRet = toRet + 1
        End If
    Next t
    
    countSubStrings = toRet
End Function

Public Function getSubString(ByVal theString As String, ByVal stringSeperator As String, ByVal idx As Long) As String
    'return the substring at index idx (starting at 0)
    'seperated by stringSeperator
    Dim toRet As String
    
    Dim cnt As Long
    Dim t As Long
    Dim part As String
    Dim substr As String
    
    For t = 1 To Len(theString)
        part = Mid$(theString, t, 1)
        If part = stringSeperator Then
            If cnt = idx Then
                getSubString = substr
                Exit Function
            End If
            cnt = cnt + 1
            substr = ""
        Else
            substr = substr + part
        End If
    Next t
    
    getSubString = substr
End Function


