Attribute VB_Name = "CommonStrings"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'string parsing functions
Option Explicit

Function insideBrackets(ByVal text As String) As String
    'return text enclosed in brackets
    On Error Resume Next
    insideBrackets = insideCharacters(text, "(", ")")
End Function


Function insideCharacters(ByVal text As String, ByVal c1 As String, ByVal c2 As String) As String
    On Error Resume Next
    'return text enclosed by characters c1 and c2
    
    Dim toRet As String
    Dim c As Long
    Dim part As String
    
    If Len(c1) > 1 Then
        c1 = Mid(c1, 1, 1)
    End If
    If Len(c2) > 1 Then
        c2 = Mid(c2, 1, 1)
    End If
    
    Dim nextStart As Long
    
    nextStart = 1
    For c = nextStart To Len(text)
        part = Mid(text, c, 1)
        If part = c1 Then
            nextStart = c + 1
            Exit For
        End If
    Next c
    
    If nextStart = 1 Then
        Exit Function
    End If
    
    For c = nextStart To Len(text)
        part = Mid(text, c, 1)
        If part = c2 Then
            Exit For
        Else
            toRet = toRet + part
        End If
    Next c
    
    insideCharacters = toRet
End Function


