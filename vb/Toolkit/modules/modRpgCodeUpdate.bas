Attribute VB_Name = "modRpgCodeUpdate"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick & contributors
'
' Contributors:
'    - Jonathan D. Hughes
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

Private m_chars(20) As String   ' Operators.

'=========================================================================
' Initialise the updater.
'=========================================================================
Public Function initUpdater()
    m_chars(0) = "!"
    m_chars(1) = "$"
    m_chars(2) = "("
    m_chars(3) = ")"
    m_chars(4) = "+"
    m_chars(5) = "-"
    m_chars(6) = "*"
    m_chars(7) = "/"
    m_chars(8) = "<"
    m_chars(9) = ">"
    m_chars(10) = "="
    m_chars(11) = "&"
    m_chars(12) = "|"
    m_chars(13) = "`"
    m_chars(14) = "!"
    m_chars(15) = "~"
    m_chars(16) = "^"
    m_chars(17) = "%"
    m_chars(18) = "."
    m_chars(19) = ","
    m_chars(20) = """" ' Already quoted.
End Function

'=========================================================================
' Determine whether a string could have been interpreted as an
' unquoted string in 3.0.6.
'=========================================================================
Private Function isString(ByVal str As String) As Boolean
    If Not (IsNumeric(str)) Then
        ' Characters that would not be in an unquoted string.

        Dim clean As String
        clean = LCase$(Trim$(str))
        If ((clean = "true") Or (clean = "false")) Then
            ' Don't quote true or false.
            Exit Function
        End If

        isString = True
        Dim i As Long
        For i = 0 To UBound(m_chars)
            If (InStr(1, str, m_chars(i))) Then
                isString = False
                Exit Function
            End If
        Next i
    End If
End Function

'=========================================================================
' Exchange part of a string for another string.
'=========================================================================
Private Function exchange(ByRef str As String, ByVal begin As Long, ByVal Length As Long, ByRef replace As String) As String
    exchange = Left$(str, begin - 1) & replace & Mid$(str, begin + Length)
End Function

'=========================================================================
' Quote the parameters of a function which are unquoted strings.
'=========================================================================
Private Function updateFunction(ByVal funcName As String, ByRef str As String, ByVal strict As Boolean) As String

    ' Just skip "for"! Hopefully nobody used = for comparison in a "for"...
    Select Case funcName
        Case "for"
            updateFunction = replace(str, ",", ";")
            Exit Function
        Case "case"
            If (LCase$(Trim$(str)) = "else") Then
                updateFunction = str
                Exit Function
            End If
    End Select
    
    'Recurse into nested functions.
    updateFunction = updateLine(str, strict, True)
    
    If (Trim$(updateFunction) = vbNullString) Then Exit Function
    
    'Split the line into parameters by commas, but ignore quoted commas.
    Dim i As Long, start As Long, params() As String, bQuotes As Boolean, char As String
    ReDim params(0)
    start = 1
    For i = 1 To Len(updateFunction)
        char = Mid$(updateFunction, i, 1)
        If (char = """") Then
            bQuotes = Not bQuotes
        ElseIf (char = ",") Then
            If Not bQuotes Then
                ReDim Preserve params(UBound(params) + 1)
                params(UBound(params)) = Mid$(updateFunction, start, i - start)
                start = i + 1
            End If
        End If
    Next i

    'Add last parameter.
    ReDim Preserve params(UBound(params) + 1)
    params(UBound(params)) = Mid$(updateFunction, start)
    
    'Quote unquoted parameters. Note params(0) is empty.
    start = 1
    For i = 1 To UBound(params)
        Dim part As String
        part = Trim$(params(i))
        
        If (isString(part)) Then
            updateFunction = exchange(updateFunction, start, Len(params(i)), """" & part & """")
            start = start + Len(part) + 3
        Else
            start = start + Len(params(i)) + 1
        End If
    Next i

End Function

'=========================================================================
' Update a line.
'=========================================================================
Private Function updateLine(ByRef str As String, ByVal strict As Boolean, ByVal fromFunction As Boolean) As String

    updateLine = str

    Dim updatedFunction As Boolean, begin As Long, Length As Long, bQuotes As Boolean
    Dim i As Long, j As Long, depth As Long, funcName As String, func As String, insideChar As String
    
    For i = 1 To Len(updateLine)
        Dim char As String
        char = Mid$(updateLine, i, 1)

        If (char = """") Then
            bQuotes = Not bQuotes
        ElseIf (Not bQuotes) Then
            If (char = "(") Then
                updatedFunction = True
                
                ' Find the function's name!
                funcName = vbNullString
                For j = i - 1 To 1 Step -1
                    If (Not (isString(Mid$(updateLine, j, 1)))) Then
                        'Search up to first non-string character.
                        funcName = Mid$(updateLine, j + 1, i - j - 1)
                    End If
                Next j
                If (LenB(funcName) = 0) Then
                    'Non-string character not encountered - take all preceding characters.
                    funcName = Left$(updateLine, i - 1)
                End If
                funcName = LCase$(Trim$(replace(funcName, vbTab, vbNullString)))
                
                depth = 0
                For j = i To Len(updateLine)
                    insideChar = Mid$(updateLine, j, 1)
                    If (insideChar = "(") Then
                        depth = depth + 1
                    ElseIf (insideChar = ")") Then
                        depth = depth - 1
                        If (depth = 0) Then
                            ' Found the matching closing brace. Extract the contents of the brackets.
                            begin = i + 1
                            Length = j - i - 1
                            func = Mid$(updateLine, begin, Length)
    
                            ' Quote the function's parameters.
                            updateLine = exchange(updateLine, begin, Length, updateFunction(funcName, func, strict))
                            Exit For
                        End If
                    End If
                Next j
                
            ElseIf (char = "[") Then
                'Quote text map keys.
                
                depth = 0
                For j = i To Len(updateLine)
                    insideChar = Mid$(updateLine, j, 1)
                    If (insideChar = "[") Then
                        depth = depth + 1
                    ElseIf (insideChar = "]") Then
                        depth = depth - 1
                        If (depth = 0) Then
                            ' Found the matching closing brace. Extract the contents of the brackets.
                            begin = i + 1
                            Length = j - i - 1
                            func = Mid$(updateLine, begin, Length)
    
                            ' Quote the map's key.
                            updateLine = exchange(updateLine, begin, Length, updateFunction(funcName, func, strict))
                            Exit For
                        End If
                    End If
                Next j
                
            ElseIf Not (updatedFunction) Then
                Dim nextChar As String, prevChar As String
                If (i <> Len(updateLine)) Then
                    nextChar = Mid$(updateLine, i + 1, 1)
                Else
                    nextChar = vbNullString
                End If
                If (i <> 1) Then
                    prevChar = Mid$(updateLine, i - 1, 1)
                Else
                    prevChar = vbNullString
                End If
                If ((char = "=") And (nextChar <> "=")) Then
                    If ((prevChar <> "<") And (prevChar <> ">") And (prevChar <> "~")) Then
                        begin = i + 1
                        Length = Len(updateLine) - i
    
                        ' Quote the right hand side of an assignment.
                        updateLine = exchange(updateLine, begin, Length, updateFunction(vbNullString, Mid$(updateLine, i + 1), strict))
    
                        ' Change = to == if within a function and not in #strict mode.
                        If (fromFunction And (Not (strict))) Then
                            updateLine = exchange(updateLine, i, 1, "==")
                            i = i + 1
                        End If
                    End If
                ElseIf (char = "=") Then
                    ' == operator
    
                    begin = i + 2
                    Length = Len(updateLine) - i - 1
    
                    ' Quote the right hand side of a comparison.
                    updateLine = exchange(updateLine, begin, Length, updateFunction(vbNullString, Mid$(updateLine, i + 2), strict))
    
                    ' Prevent == from also being read as a =.
                    i = i + 1
                ElseIf ((char = "+") And (nextChar = "=")) Then
                    begin = i + 2
                    Length = Len(updateLine) - i - 1
    
                    ' Quote the right hand side of an addition assignment.
                    updateLine = exchange(updateLine, begin, Length, updateFunction(vbNullString, Mid$(updateLine, i + 2), strict))
    
                    ' Prevent += from also being processed as =.
                    i = i + 1
                End If
            End If ' char = "("
        End If 'Not bQuotes
    Next i

End Function

'=========================================================================
' Strip type declaration characters.
'=========================================================================
Private Function stripTypes(ByRef str As String) As String: On Error GoTo err
    stripTypes = str
    Dim i As Long, quotes As Boolean
    For i = 1 To Len(str)
        Dim c As String
        c = Mid$(stripTypes, i, 1)  ' This will err at the end if any characters are removed.
        If Not (quotes) Then
            If ((c = "!") Or (c = "$")) Then
                stripTypes = exchange(stripTypes, i, 1, vbNullString)
                i = i - 1
            End If
        End If
        If (c = """") Then
            quotes = Not (quotes)
        End If
    Next i
err:
End Function

'=========================================================================
' Update a program.
'=========================================================================
Public Sub updateProgram(ByRef prg As String, ByRef SaveAs As String)
    Dim ffPrg As Integer, strict As Boolean, txt As String

    Call initUpdater

    ffPrg = FreeFile()
    Open prg For Input As ffPrg

    Do While Not (EOF(ffPrg))
        Dim line As String
        Line Input #ffPrg, line

        ' Get a whitespace-free version.
        Dim wfree As String
        wfree = Trim$(replace(line, vbTab, vbNullString))

        If (LCase$(wfree) = "#strict") Then
            strict = True
        Else
            ' Deal with archaic * comments.
            If (Left$(wfree, 1) <> "*") Then
                ' No * comment found; update the line.
                
                ' Deal with // comments.
                Dim cpos As Long, comment As String
                cpos = InStr(1, line, "//")
                If (cpos) Then
                    comment = Trim$(Mid$(line, cpos + 2))
                    line = RTrim$(Mid$(line, 1, cpos - 1))
                Else
                    comment = vbNullString
                End If

                line = stripTypes(updateLine(line, strict, False))
                If (LenB(comment)) Then
                    If (LenB(Trim$(replace(line, vbTab, vbNullString)))) Then
                        ' Set the comment off from the rest of the line.
                        line = line & " "
                    End If
                    line = line & "// " & comment
                End If
            End If
            txt = txt & line & vbCrLf
        End If
    Loop

    Close ffPrg

    Dim ffSave As Integer
    ffSave = FreeFile()
    Open SaveAs For Output As ffSave
        Print #ffSave, txt
    Close ffSave
End Sub
