Attribute VB_Name = "CommonStrings"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'string parsing functions

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' --What is done
' + insideCharacters re-written to comply much closer to
'   VB standards
'
'=======================================================

Option Explicit

Public Function insideBrackets(ByVal text As String) As String
    'return text enclosed in brackets
    On Error Resume Next
    insideBrackets = insideCharacters(text, "(", ")")
End Function

Public Function insideCharacters( _
                                    ByVal toParse As String, _
                                    ByVal c1 As String, _
                                    ByVal c2 As String _
                                                         ) As String

    Dim start As Long
    Dim tEnd As Long

    'See where the first char is
    start = InStr(1, toParse, c1, vbTextCompare)
    
    'Find the last char
    tEnd = InStr(1, StrReverse(toParse), c2, vbTextCompare)
    tEnd = Len(toParse) - tEnd + 1

    'Just keep what's in between the two
    insideCharacters = Mid(toParse, start + 1, tEnd - start - 1)

End Function


