Attribute VB_Name = "modRpgCodeUpdate"
'=========================================================================
' All contents copyright 2005, 2006, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE
' Read LICENSE.txt for licensing info
'=========================================================================

Option Explicit

'=========================================================================
' Determine whether a string could have been interpreted as an
' unquoted string in 3.0.6.
'=========================================================================
Private Function isString(ByRef str As String) As Boolean
    If Not (IsNumeric(str)) Then
        ' Characters that would not be in an unquoted string.
        Dim chars(20) As String
        chars(0) = "!"
        chars(1) = "$"
        chars(2) = "("
        chars(3) = ")"
        chars(4) = "+"
        chars(5) = "-"
        chars(6) = "*"
        chars(7) = "/"
        chars(8) = "<"
        chars(9) = ">"
        chars(10) = "="
        chars(11) = "&"
        chars(12) = "|"
        chars(13) = "`"
        chars(14) = "!"
        chars(15) = "~"
        chars(16) = "^"
        chars(17) = "%"
        chars(18) = "."
        chars(19) = ","
        chars(20) = """" ' Already quoted.

        isString = True
        Dim i As Long
        For i = 0 To UBound(chars)
            If (InStr(1, str, chars(i))) Then
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
Private Function updateFunction(ByRef str As String, ByVal strict As Boolean) As String

    Dim opn As Long
    opn = InStr(1, str, "(")

    Dim begin As Long, Length As Long
    begin = opn + 1
    Length = Len(str) - opn - IIf(InStr(1, str, ")") <> 0, 1, 0)

    Dim inside As String
    inside = Mid$(str, begin, Length)
    inside = updateLine(inside, strict, True)

    opn = opn + 1

    Dim params() As String
    params = Split(inside, ",")

    updateFunction = str
    updateFunction = exchange(updateFunction, begin, Length, inside)

    Dim i As Long
    For i = 0 To UBound(params)
        Dim part As String
        part = Trim$(params(i))
        If (isString(part)) Then
            updateFunction = exchange(updateFunction, opn, Len(params(i)), """" & part & """")
        End If
        opn = opn + Len(params(i)) + 1
    Next i

End Function

'=========================================================================
' Update a line.
'=========================================================================
Private Function updateLine(ByRef str As String, ByVal strict As Boolean, ByVal fromFunction As Boolean) As String

    updateLine = str

    Dim updatedFunction As Boolean, begin As Long, Length As Long

    Dim i As Long
    For i = 1 To Len(updateLine)
        Dim char As String
        char = Mid$(updateLine, i, 1)

        If (char = "(") Then
            updatedFunction = True
            Dim j As Long, depth As Long
            For j = i To Len(updateLine)
                Dim insideChar As String
                insideChar = Mid$(updateLine, j, 1)
                If (insideChar = "(") Then
                    depth = depth + 1
                ElseIf (insideChar = ")") Then
                    depth = depth - 1
                    If (depth = 0) Then
                        ' Found the matching closing brace.
                        Dim func As String
                        begin = i + 1
                        Length = j - i - 1
                        func = Mid$(updateLine, i + 1, j - i - 1)

                        ' Quote the function's parameters.
                        updateLine = exchange(updateLine, begin, Length, updateFunction(func, strict))

                        Exit For
                    End If
                End If
            Next j
        ElseIf Not (updatedFunction) Then
            If (char = "=") Then
                begin = i + 1
                Length = Len(updateLine) - i

                ' Quote the right hand side of an assignment.
                updateLine = exchange(updateLine, begin, Length, updateFunction(Mid$(updateLine, i + 1), strict))

                ' Change = to == if within a function and not in #strict mode.
                If (fromFunction And (Not (strict))) Then
                    updateLine = exchange(updateLine, i, 1, "==")
                    i = i + 1
                End If
            ElseIf (char = "+") Then
                If ((i <> Len(str)) And (Mid$(str, i + 1, 1) = "=")) Then
                    begin = i + 2
                    Length = Len(updateLine) - i - 1

                    ' Quote the right hand side of an addition assignment.
                    updateLine = exchange(updateLine, begin, Length, updateFunction(Mid$(updateLine, i + 2), strict))

                    ' Prevent += from also being processed as =.
                    i = i + 1
                End If
            End If
        End If
    Next i

End Function

'=========================================================================
' Strip type declaration characters.
'=========================================================================
Private Function stripTypes(ByRef str As String) As String
    stripTypes = str
    Dim i As Long, quotes As Boolean
    For i = 1 To Len(str)
        Dim c As String
        c = Mid$(str, i, 1)
        If Not (quotes) Then
            If ((c = "!") Or (c = "$")) Then
                stripTypes = exchange(stripTypes, i, 1, vbNullString)
            End If
        End If
        If (c = """") Then
            quotes = Not (quotes)
        End If
    Next i
End Function

'=========================================================================
' Update a program.
'=========================================================================
Public Sub updateProgram(ByRef prg As String, ByRef SaveAs As String)
    Dim ffPrg As Integer, strict As Boolean, txt As String

    ffPrg = FreeFile()
    Open prg For Input As ffPrg

    Do While Not (EOF(ffPrg))
        Dim line As String
        Line Input #ffPrg, line
        If (LCase$(Trim$(replace(line, vbTab, vbNullString))) = "#strict") Then
            strict = True
        Else
            line = stripTypes(updateLine(line, strict, False))
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
