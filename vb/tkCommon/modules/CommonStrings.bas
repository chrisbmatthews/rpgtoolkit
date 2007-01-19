Attribute VB_Name = "CommonStrings"
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

Option Explicit

Public Function insideBrackets(ByVal Text As String) As String
    'return text enclosed in brackets
    On Error Resume Next
    insideBrackets = insideCharacters(Text, "(", ")")
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


