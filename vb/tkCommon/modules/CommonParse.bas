Attribute VB_Name = "CommonParse"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'simple string parsing...

Option Explicit

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Functions re-written to use VB standard functions
'
'=======================================================

Public Function countSubStrings( _
                                   ByVal theString As String, _
                                   ByVal stringSeperator As String _
                                                                     ) As Long

    'count the numbver of substrings contained in the string
    'seperated by stringSeperator
    
    On Error Resume Next
    
    If theString = "" Then
        countSubStrings = 0
    Else
        Dim parse() As String
        parse() = Split(theString, stringSeperator)
        countSubStrings = UBound(parse) + 1
    End If

End Function

Public Function getSubString( _
                                ByVal theString As String, _
                                ByVal stringSeperator As String, _
                                ByVal idx As Long _
                                                    ) As String

    'return the substring at index idx (starting at 0)
    'seperated by stringSeperator

    On Error Resume Next

    Dim parse() As String
    parse() = Split(theString, stringSeperator)
    getSubString = parse(idx)

End Function


