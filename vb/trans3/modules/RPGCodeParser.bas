Attribute VB_Name = "RPGCodeParser"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures for parsing rpgcode
'=========================================================================

Option Explicit

'=========================================================================
' A parameter
'=========================================================================
Public Type parameters
    num As Double       '  numerical
    lit As String       '  literal
    dat As String       '  un-altered data
    dataType As RPGC_DT '  type returned (lit or num)
End Type

'=========================================================================
' Commonly used operators
'=========================================================================
Private m_mathSigns(22) As String
Private m_compSigns(9) As String

'=========================================================================
' Build the sign arrays
'=========================================================================
Public Sub buildSignArrays()

    ' Build m_mathSigns
    m_mathSigns(0) = vbNullChar ' Prefixed NULL
    m_mathSigns(1) = "|="
    m_mathSigns(2) = "&="
    m_mathSigns(3) = "`="
    m_mathSigns(4) = "%="
    m_mathSigns(5) = "+="
    m_mathSigns(6) = "-="
    m_mathSigns(7) = "++"
    m_mathSigns(8) = "--"
    m_mathSigns(9) = "*="
    m_mathSigns(10) = "/="
    m_mathSigns(11) = "=="
    m_mathSigns(12) = "="
    m_mathSigns(13) = "+"
    m_mathSigns(14) = "-"
    m_mathSigns(15) = "/"
    m_mathSigns(16) = "*"
    m_mathSigns(17) = "^"
    m_mathSigns(18) = "\"
    m_mathSigns(19) = "|"
    m_mathSigns(20) = "&"
    m_mathSigns(21) = "`"
    m_mathSigns(22) = "%"

    ' Build m_compSigns
    m_compSigns(0) = vbNullChar ' Prefixed NULL
    m_compSigns(1) = "~="
    m_compSigns(2) = "=="
    m_compSigns(3) = "<="
    m_compSigns(4) = "=<"
    m_compSigns(5) = ">="
    m_compSigns(6) = "=>"
    m_compSigns(7) = ">"
    m_compSigns(8) = "<"
    m_compSigns(9) = "="

End Sub

'=========================================================================
' Returns the name of the method from a method delcaration
'=========================================================================
Public Function GetMethodName(ByRef Text As String) As String

    On Error Resume Next

    '// Passing Text ByRef for preformance related reasons

    Dim use As String, dataUse As String, number As Long, useIt As String, useIt1 As String, useIt2 As String, useIt3 As String, lit As String, num As Double, a As Long, lit1 As String, lit2 As String, lit3 As String, num1 As Double, num2 As Double, num3 As Double
    Dim Length As Long
    Dim t As Long
    Dim startHere As Long
    Dim mName As String

    dataUse$ = Text$
    Length = Len(dataUse$)
    Dim part As String
    For t = 1 To Length
        'Find #
        part$ = Mid$(dataUse$, t, 1)
        If part$ <> " " And part$ <> vbTab And part$ <> "#" Then
            startHere = t - 1
            If startHere = 0 Then startHere = 1
            Exit For
        End If
        If part$ = "#" Then
            startHere = t
            Exit For
        End If
    Next t
    For t = startHere To Length
        'Find start of command name
        part$ = Mid$(dataUse$, t, 1)
        If part$ <> " " Then startHere = t: t = Length
    Next t
    For t = startHere To Length
        'Find end of command name
        part$ = Mid$(dataUse$, t, 1)
        If part$ = " " Then startHere = t: t = Length
    Next t
    For t = startHere To Length
        'Find start  of method
        part$ = Mid$(dataUse$, t, 1)
        If part$ <> " " Then startHere = t: t = Length
    Next t
    For t = startHere To Length
        'Find name  of method
        part$ = Mid$(dataUse$, t, 1)
        If part$ = " " Or part$ = "(" Then
            t = Length
        Else
            mName$ = mName & part$
        End If
    Next t
    GetMethodName = mName$

End Function

'=========================================================================
' Return content in text after startSymbol is located
'=========================================================================
Public Function ParseAfter(ByRef Text As String, ByRef startSymbol As String) As String

    On Error Resume Next

    '// Passing Text and startSymbol ByRef for preformance related reasons

    Dim Length As Integer
    Dim t As Integer
    Dim part As String
    Dim toRet As String
    
    Length = Len(Text)
    Dim foundIt As Boolean, startAt As Long
    
    foundIt = False
    'find opening symbol...
    For t = 1 To Length
        part = Mid$(Text, t, 1)
        If part = startSymbol Then
            'found start symbol.
            startAt = t
            foundIt = True
            Exit For
        End If
    Next t
    
    If foundIt Then
        For t = startAt + 1 To Length
            part = Mid$(Text, t, 1)
            toRet = toRet & part
        Next t
    End If
    
    ParseAfter = toRet
End Function

'=========================================================================
' Return content from text until startSymbol is located
'=========================================================================
Public Function ParseBefore(ByRef Text As String, ByRef startSymbol As String) As String

    On Error Resume Next

    '// Passing Text and startSymbol ByRef for preformance related reasons

    Dim Length As Integer
    Dim t As Integer
    Dim part As String
    Dim toRet As String
    
    Length = Len(Text)
    'find opening symbol...
    For t = 1 To Length
        part = Mid$(Text, t, 1)
        If part = startSymbol Then
            'found start symbol.
            ParseBefore = toRet
            Exit Function
        Else
            toRet = toRet & part
        End If
    Next t

    ParseBefore = vbNullString

End Function

'=========================================================================
' Return the lowest of a list of values
'=========================================================================
Public Function lowest(ByRef values() As Long, Optional ByRef whichSpot As Long) As Long
    On Error Resume Next
    Dim idx As Long
    For idx = 0 To UBound(values)
        If (idx = 0) Then
            lowest = values(idx)
            whichSpot = 0
        Else
            If ((values(idx) < lowest Or lowest = 0) And (values(idx) > 0)) Then
                lowest = values(idx)
                whichSpot = idx
            End If
        End If
    Next idx
End Function

'=========================================================================
' Returns the math function at pos num, optionally including comparsion
'=========================================================================
Public Function MathFunction(ByRef Text As String, ByVal num As Long, Optional ByVal comparison As Boolean) As String

    On Error Resume Next

    '// Passing Text ByRef for performance related reasons

    Dim signs() As String   ' Array of math operators
    Dim p() As Long         ' Positions of those operators
    Dim whichSpot As Long   ' The spot containing the value returned
    Dim start As Long       ' Position to start at in text
    Dim a As Long           ' For loop control variable
    Dim S As Long           ' For loop control variable

    If (Not comparison) Then
        ' Use m_mathSigns
        signs = m_mathSigns
    Else
        ' Use m_compSigns
        signs = m_compSigns
    End If

    'Dimension p to have room for all the signs
    ReDim p(UBound(signs))

    'Find that sign!
    start = 1
    For a = 1 To num
        For S = 0 To UBound(signs)
            p(S) = inStrOutsideQuotes(start, Text, signs(S))
        Next S
        start = lowest(p, whichSpot) + 1
        If (a <> num) Then
            ReDim p(UBound(signs))
        Else
            MathFunction = signs(whichSpot)
        End If
    Next a

End Function

'=========================================================================
' Evaluates if the text passed in is true (1) or false (0)
'=========================================================================
Public Function evaluate(ByRef Text As String, ByRef prg As RPGCodeProgram, Optional ByRef didEvaluate As Boolean) As Long

    '// Passing string(s) ByRef for preformance related reasons

    On Error Resume Next

    ' Declare a variable to work on
    Dim str As String
    str = Trim$(Text)

    ' Check for logic
    Dim logic(3) As String
    logic(0) = "&&"
    logic(1) = " AND "
    logic(2) = "||"
    logic(3) = " OR "

    Dim idx As Long
    For idx = 0 To 3

        ' Split the text
        Dim parts() As String
        parts = Split(str, logic(idx), , vbTextCompare) ' vbTextCompare makes things simple, though
                                                        ' more coding could provide a better
                                                        ' alternative here.

        ' Check if logic was found
        Dim partUb As Long
        partUb = UBound(parts)
        If (partUb <> 0) Then

            Dim toRet As Long

            ' Set initital toRet value
            Select Case idx
                Case 0, 1: toRet = 1 ' Logical AND
                Case 2, 3: toRet = 0 ' Logical OR
            End Select

            ' Loop over each part
            Dim pIdx As Long, doneLoop As Boolean
            For pIdx = 0 To partUb

                ' Evaluate this part
                Dim run As Long
                run = evaluate(parts(pIdx), prg)

                ' Check how toRet should change
                If Not (doneLoop) Then
                    If (run = 1) Then
                        Select Case idx
                            Case 2, 3
                                ' Fin
                                toRet = 1
                                doneLoop = True
                        End Select
                    Else
                        Select Case idx
                            Case 0, 1
                                ' Fin
                                toRet = 0
                                doneLoop = True
                        End Select
                    End If
                End If

            Next pIdx

            ' Return the result
            evaluate = toRet
            Exit Function

        End If

    Next idx

    ' Declare an array for signs
    ReDim signs(0) As String

    ' First, parse out all the signs
    idx = 0
    Do

        ' Increment idx
        idx = idx + 1

        ' Get the sign here
        ReDim Preserve signs(idx - 1)
        signs(idx - 1) = MathFunction(str, idx, True)

        ' Check if we got a sign
        If (signs(idx - 1) = vbNullChar) Then

            If ((idx = 1) And (didEvaluate)) Then

                ' Flag we did not evaluate
                didEvaluate = False
                Exit Function

            End If

            ' Leave this loop
            Exit Do

        End If

        ' Remove said sign from the text
        str = replace(str, signs(idx - 1), vbNullChar, , 1)
        If (signs(idx - 1) = "=") Then signs(idx - 1) = "=="

    Loop

    ' Now just use Split() to get all the values
    Dim values() As String
    values = Split(str, vbNullChar)

    ' Create arrays for the values
    Dim valueUb As Long
    valueUb = UBound(values)
    ReDim strVal(valueUb) As String, numVal(valueUb) As Double, typeVal(valueUb) As RPGC_DT

    ' If we got only one value values
    If ((valueUb = 0) And (didEvaluate)) Then

        ' Flag we did not evaluate
        didEvaluate = False
        Exit Function

    End If

    ' Loop over each values
    For idx = 0 To valueUb

        ' Trim this value
        values(idx) = Trim$(values(idx))

        ' Check for logical or binary NOT
        Dim lv As String
        lv = LeftB$(values(idx), 2)
        If (lv = "~") Then

            ' Remove the tilda
            values(idx) = Mid$(values(idx), 2)

            ' Get its value
            typeVal(idx) = getValue(values(idx), strVal(idx), numVal(idx), prg)

            ' Check for type problems
            If (typeVal(idx) <> DT_NUM) Then

                ' Error out
                Call debugger("Binary not is invalid on strings-- " & Text)
                Exit Function

            End If

            numVal(idx) = Not numVal(idx)

        ElseIf (lv = "!") Then

            ' Remove the mark
            values(idx) = Mid$(values(idx), 2)

            ' Get its value
            typeVal(idx) = getValue(values(idx), strVal(idx), numVal(idx), prg)

            ' Check for type problems
            If (typeVal(idx) <> DT_NUM) Then

                ' Error out
                Call debugger("Logical not is invalid on strings-- " & Text)
                Exit Function

            End If

            If (numVal(idx) <> 0) Then
                ' Becomes false
                numVal(idx) = 0
            Else
                ' Becomes true
                numVal(idx) = 1
            End If

        Else

            ' Get its value
            typeVal(idx) = getValue(values(idx), strVal(idx), numVal(idx), prg)

        End If

        If (idx <> 0) Then

            ' Check for type mismatch
            If (typeVal(idx) <> typeVal(0)) Then

                ' Error out
                Call debugger("Type mismatch-- " & Text)
                Exit Function

            End If

        End If

    Next idx

    ' Evaluate from left to right (for now, anyway):
    If (typeVal(0) = DT_NUM) Then

        ' Numerical

        For idx = 0 To valueUb - 1

            Dim signSwitch As Boolean
            signSwitch = True

            ' Check for overloaded operator
            Dim tdc As String
            tdc = RightB$(values(idx), 2)
            If ((tdc <> "!") And (tdc <> "$")) Then

                ' It's an object
                Dim outside As Boolean, hClass As Long, op As String
                hClass = CLng(numVal(idx))
                outside = (topNestle(prg) <> hClass)
                op = "operator" & signs(idx)

                If (isMethodMember(op, hClass, prg, outside)) Then

                    ' It handles this operator
                    Dim retval As RPGCODE_RETURN
                    signSwitch = False
                    retval.num = 0
                    Call callObjectMethod(hClass, op & "(" & CStr(numVal(idx + 1)) & ")", prg, retval, op)
                    numVal(idx + 1) = -retval.num

                End If

            End If

            If (signSwitch) Then
                ' Switch on the sign
                Select Case signs(idx)
                    Case "==": numVal(idx + 1) = (numVal(idx) = numVal(idx + 1))
                    Case "~=": numVal(idx + 1) = (numVal(idx) <> numVal(idx + 1))
                    Case ">=", "=>": numVal(idx + 1) = (numVal(idx) >= numVal(idx + 1))
                    Case "<=", "=<": numVal(idx + 1) = (numVal(idx) <= numVal(idx + 1))
                    Case ">": numVal(idx + 1) = (numVal(idx) > numVal(idx + 1))
                    Case "<": numVal(idx + 1) = (numVal(idx) < numVal(idx + 1))
                End Select
            End If

        Next idx

        evaluate = -(numVal(valueUb) <> 0)

    Else

        ' Literal

        For idx = 0 To valueUb - 1

            ' Switch on the sign
            Select Case signs(idx)
                Case "==": strVal(idx + 1) = CStr(CLng(strVal(idx) = strVal(idx + 1)))
                Case "~=": strVal(idx + 1) = CStr(CLng(strVal(idx) <> strVal(idx + 1)))
                Case ">=", "=>": strVal(idx + 1) = CStr(CLng(strVal(idx) >= strVal(idx + 1)))
                Case "<=", "=<": strVal(idx + 1) = CStr(CLng(strVal(idx) <= strVal(idx + 1)))
                Case ">": strVal(idx + 1) = CStr(CLng(strVal(idx) > strVal(idx + 1)))
                Case "<": strVal(idx + 1) = CStr(CLng(strVal(idx) < strVal(idx + 1)))
            End Select

        Next idx

        evaluate = -((CLng(strVal(valueUb))) <> 0)

    End If

End Function

'=========================================================================
' Get the variable at number in an equation
'=========================================================================
Public Function GetVarList(ByRef Text As String, ByVal number As Long) As String

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim ignoreNext As Long, element As Long, part As String, p As Long, returnVal As String
    
    For p = 1 To Len(Text) + 1

        part = Mid$(Text, p, 1)

        If part = ("""") Then
            If ignoreNext = 0 Then
                ignoreNext = 1
            Else
                ignoreNext = 0
            End If
            returnVal = returnVal & part

        ElseIf part = "=" Or part = "+" Or part = "-" Or part = "/" Or part = "*" Or part = "\" Or part = "^" _
        Or part = "%" Or part = "`" Or part = "|" Or part = "&" Then
            If ignoreNext = 0 Then
                element = element + 1
                If element = number Then
                    GetVarList = returnVal
                    Exit Function
                Else
                    returnVal = vbNullString
                End If
            Else
                returnVal = returnVal & part
            End If
        Else
            returnVal = returnVal & part
        End If

    Next p
    
    GetVarList = returnVal

End Function

'=========================================================================
' Return the content in text between the start and end symbols
'=========================================================================
Public Function ParseWithin(ByRef Text As String, ByRef startSymbol As String, ByRef endSymbol As String) As String

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim Length As Integer
    Dim t As Integer
    Dim l As Integer
    Dim part As String
    Dim toRet As String
    Dim ignoreDepth As Integer
    
    Length = Len(Text)
    'find opening symbol...
    For t = 1 To Length
        part = Mid$(Text, t, 1)
        If part = startSymbol Then
            'founf start symbol.
            'now locate end symbol...
            For l = t + 1 To Length
                part = Mid$(Text, l, 1)
                If part = startSymbol Then
                    ignoreDepth = ignoreDepth + 1
                ElseIf part = endSymbol Then
                    If ignoreDepth = 0 Then
                        ParseWithin = toRet
                        Exit Function
                    End If
                    ignoreDepth = ignoreDepth - 1
                Else
                    toRet = toRet & part
                End If
            Next l
            ParseWithin = toRet
            Exit Function
        End If
    Next t
    
    ParseWithin = vbNullString
End Function

'=========================================================================
' Count the number of values in an equation
'=========================================================================
Public Function ValueNumber(ByRef Text As String) As Long

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim ignoreNext As Long, Length As Long, ele As Long, p As Long, part As String
    
    ignoreNext = 0
    Length = Len(Text$)
    ele = 1
    For p = 1 To Length
        part = Mid$(Text, p, 1)
        If part = ("""") Then
            If ignoreNext = 1 Then
                ignoreNext = 0
            Else
                ignoreNext = 1
            End If
        ElseIf part = "=" Or part = "+" Or part = "-" Or part = "/" Or part = "*" Or part = "\" Or part = "^" _
        Or part = "%" Or part = "`" Or part = "|" Or part = "&" Then
            If (ignoreNext = 0) Then ele = ele + 1
        End If
    Next p

    ValueNumber = ele

End Function

'=========================================================================
' Get the bracket element at eleeNum
'=========================================================================
Public Function GetElement(ByRef Text As String, ByVal eleeNum As Long) As String

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim Length As Long, element As Long, part As String, ignore As Boolean, returnVal As String, p As Long
    
    Length = Len(Text$)
    For p = 1 To Length + 1
        part = Mid$(Text, p, 1)
        If part = ("""") Then
            'A quote
            ignore = (Not ignore)
            returnVal = returnVal & part
        ElseIf part = "," Or part = ";" Or (LenB(part) = 0) Then
            If (Not ignore) Then
                element = element + 1
                If element = eleeNum Then
                    GetElement = returnVal
                    Exit Function
                Else
                    returnVal = vbNullString
                End If
            Else
                returnVal = returnVal & part
            End If
        Else
            returnVal = returnVal & part
        End If
    Next p
    
    GetElement = returnVal

End Function

'=========================================================================
' Count the number of bracket elements in text
'=========================================================================
Public Function CountData(ByRef Text As String) As Long

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    ' If there is no text, there are no elements
    Dim gB As String
    gB = GetBrackets(Text, True)
    If (LenB(gB) = 0) Then Exit Function

    ' Setup delimiter array
    Dim c(1) As String
    c(0) = ","
    c(1) = ";"

    ' Split at the delimiters
    Dim S() As String
    Dim uD() As String
    S() = multiSplit(Text, c, uD, True)

    ' Number of data elements will be one higher than the upper bound
    CountData = UBound(S) + 1

End Function

'=========================================================================
' Return the first space after the command / the opening bracket
'=========================================================================
Public Function LocateBrackets(ByRef Text As String) As Long

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim p As Long

    For p = 1 To Len(Text$)
        If (Mid$(Text$, p, 1) = "(") Then
            LocateBrackets = p
            Exit Function
        End If
    Next p

End Function

'=========================================================================
' Retrieve the text inside the brackets
'=========================================================================
Public Function GetBrackets(ByRef Text As String, Optional ByVal doNotCheckForBrackets As Boolean) As String

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim ignoreClosing As Boolean
    Dim use As String, location As Long, Length As Long, bracketDepth As Long, p As Long, part As String
    Dim fullUse As String
    
    use = Text
    location = LocateBrackets(use)
    Length = Len(Text)
    
    If (Not doNotCheckForBrackets) Then
        If (InStrB(Text, "(") = 0) Then
            If (InStrB(Text, ")") = 0) Then
                'No (s or )s here!
                Exit Function
            End If
        End If
    End If

    For p = location + 1 To Length
        part$ = Mid$(Text$, p, 1)
        If ((part = ")") And (Not ignoreClosing) And bracketDepth <= 0) Or (LenB(part) = 0) Then
            Exit For
        Else
            If part = ")" Then
                bracketDepth = bracketDepth - 1
            ElseIf part = ("""") Then
                'quote-- ignore stuff inside quotes.
                ignoreClosing = (Not ignoreClosing)
            ElseIf part = "(" Then
                bracketDepth = bracketDepth + 1
            End If
            fullUse = fullUse & part
        End If
    Next p

    GetBrackets = fullUse

End Function

'=========================================================================
' Get the command name in the text passed in
'=========================================================================
Public Function GetCommandName(ByRef splice As String) As String

    On Error Resume Next

    '// Passing splice ByRef for preformance related reasons

    If (LenB(splice) = 0) Then Exit Function

    Dim Length As Long, foundIt As Long, p As Long, part As String, starting As Long, commandName As String
    Dim testIt As String, depth As Long
    
    Length = Len(splice)

    For p = 1 To Length
        part = Mid$(splice, p, 1)
        If (part = "(") Then depth = depth + 1
        If (part = ")") Then depth = depth - 1
        If (part = "=") And (depth = 0) Then
            GetCommandName = "VAR"
            Exit Function
        End If
    Next p

    For p = 1 To Length
        part = Mid$(splice, p, 1)
        If (part = "[") Then
            GetCommandName = "VAR"
            Exit Function
        ElseIf (part = " " Or part = "#" Or part = "(") Then
            Exit For
        End If
    Next p

    'Look for #
    For p = 1 To Length
        part = Mid$(splice, p, 1)
        If part <> " " And part <> "#" And part <> vbTab Then
            If part$ = "*" Then
                GetCommandName = "*"
                Exit Function
                
            ElseIf part$ = ":" Then
                GetCommandName = "LABEL"
                Exit Function
                
            ElseIf part$ = "@" Then
                GetCommandName = "@"
                Exit Function
            End If
                
            foundIt = p
            starting = p - 1
            Exit For

        ElseIf part = "#" Then
            starting = p
            foundIt = p
            Exit For
        End If
    Next p
    If foundIt = 0 Then
        'Yipes- didn't find a #.  Maybe it's a @ command
        For p = 1 To Length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> "@" And part$ <> vbTab Then
                foundIt = 0
                Exit For
            End If
            If part$ = "@" Then
                GetCommandName$ = "@"
                Exit Function
            End If
        Next p
        If foundIt = 0 Then
            'Oh oh- still can't find it!  Probably a message
            'maybe a comment?
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> "*" And part$ <> vbTab Then foundIt = 0: p = Length
                If part$ = "*" Then GetCommandName$ = "*": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe a label
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ":" And part$ <> vbTab Then foundIt = 0: p = Length
                If part$ = ":" Then GetCommandName$ = "LABEL": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> "<" And part$ <> "{" And part$ <> vbTab Then foundIt = 0: p = Length
                If part$ = "<" Or part$ = "{" Then GetCommandName$ = "OPENBLOCK": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ">" And part$ <> "}" And part$ <> vbTab Then foundIt = 0: p = Length
                If part$ = ">" Or part$ = "}" Then GetCommandName$ = "CLOSEBLOCK": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'if after all of this stuff we didn't find anything
            'it's a message
            GetCommandName$ = "MBOX"
            'Exit Function
        End If
    End If
    'OK, if I'm here, that means that it is a # command
    For p = starting + 1 To Length
        part$ = Mid$(splice$, p, 1)
        If part$ <> " " Then
            starting = p
            Exit For
        End If
    Next p
    
    commandName$ = vbNullString
    'now find command
    For p = starting To Length
        part$ = Mid$(splice$, p, 1)
        If part$ = " " Or part$ = "(" Or part$ = "=" Then p = Length: part$ = vbNullString
        commandName$ = commandName & part$
    Next p
    'Now, before sending this back, let's see if it's a varibale
    If commandName$ = "{" Then commandName$ = "OPENBLOCK"
    If commandName$ = "}" Then commandName$ = "CLOSEBLOCK"

    testIt$ = commandName$
    Length = Len(testIt$)
    For p = 1 To Length
        part$ = Mid$(testIt$, p, 1)
        If part$ = "!" Or part$ = "$" Then commandName$ = "VAR"
    Next p

    GetCommandName = commandName

End Function

'=========================================================================
' Retrieve the parameters from the command passed in
'=========================================================================
Public Function GetParameters(ByRef Text As String, ByRef theProgram As RPGCodeProgram) As parameters()

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    ' Declarations
    Dim ret() As parameters
    Dim count As Long
    Dim brackets As String
    Dim a As Long
    Dim lit As String
    Dim num As Double
    Dim dataType As RPGC_DT

    ' Get the parameters
    count = CountData(Text)
    brackets = GetBrackets(Text)
    For a = 1 To count
        Dim theElem As String
        theElem = Trim$(GetElement(brackets, a))
        dataType = getValue(theElem, lit, num, theProgram)
        ReDim Preserve ret(a - 1)
        Select Case dataType
            Case DT_LIT
                ret(a - 1).dataType = DT_LIT
                ret(a - 1).lit = Trim$(lit)
            Case DT_NUM
                ret(a - 1).dataType = DT_NUM
                ret(a - 1).num = num
        End Select
        ret(a - 1).dat = theElem
    Next a

    ' Pass back the data
    GetParameters = ret

End Function

'=========================================================================
' Return the prefix to attach to lines starting with '.'
'=========================================================================
Public Function GetWithPrefix() As String
    On Error Resume Next
    If (LenB(inWith(0)) = 0) Then Exit Function
    Dim a As Long
    For a = 0 To UBound(inWith)
        GetWithPrefix = GetWithPrefix & inWith(a)
    Next a
End Function

'=========================================================================
' Parse the line passed in
'=========================================================================
Public Function ParseRPGCodeCommand( _
                                       ByRef line As String, _
                                       ByRef prg As RPGCodeProgram, _
                                       Optional ByVal startAt As Long _
                                                                        ) As String

    ' We' re going to find all the commands (functions) inside this command
    ' and replace them with their values. You can have nestled commands, and
    ' even commands added to variables. Yes, this is the parser to end all
    ' parsers (heh...)

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    ' Check for methods that might elude this code
    If (LeftB$(UCase$(line), 12) = "METHOD") Then
        ParseRPGCodeCommand = line
        Exit Function
    End If

    Dim cmdName As String       ' Command name of line we're parsing
    cmdName = UCase$(GetCommandName(line))

    ' Some things don' t require parsing
    Select Case cmdName
        Case "@", "*", vbNullString, "LABEL", "OPENBLOCK", "CLOSEBLOCK", "REDIRECT"
            ParseRPGCodeCommand = line
            Exit Function
    End Select

    Dim depth As Long           ' Depth within brackets
    Dim char As String          ' A character
    Dim char2 As String         ' Another character
    Dim a As Long               ' Loop control
    Dim b As Long               ' Loop control
    Dim prefix As String        ' Command name
    Dim bT As String            ' Line to work on
    Dim cN As String            ' Function to execute
    Dim rV As RPGCODE_RETURN    ' Value the function returned
    Dim v As String             ' String value of rV
    Dim oPP As Long             ' Program position before running function
    Dim ignore As Boolean       ' Within quotes?
    Dim ret As String           ' Value to return
    Dim varExp As Boolean       ' Variable expression?

    ' Check if we have a variable expression
    varExp = (cmdName = "VAR")

    ' Get the text to operate on
    If (varExp) Then
        bT = " " & line
    Else
        prefix = cmdName
        bT = " " & GetBrackets(line)
    End If

    ' Loop over each character
    For a = 1 To Len(bT)

        ' Get a character
        char = Mid$(bT, a, 1)

        Select Case char

            ' Quote
            Case """"
                ignore = (Not ignore)

            ' Opening bracket
            Case "(": If (Not ignore) Then depth = depth + 1

            ' Closing bracket
            Case ")"
                If (Not ignore) Then
                    depth = depth - 1
                    If (depth = 0) Then

                        ' Loop from current position backwards
                        For b = a To 1 Step -1

                            ' Get a character
                            char2 = Mid$(bT, b, 1)

                            Select Case char2

                                ' Quote
                                Case """"
                                    ignore = (Not ignore)

                                ' Opening/closing bracket
                                Case "(": If (Not ignore) Then depth = depth - 1
                                Case ")": If (Not ignore) Then depth = depth + 1

                                ' Divider
                                Case " ", ",", "#", "=", "<", ">", "+", "-", ";", "*", "\", "/", "^", "%", "`", "|", "&", "~"

                                    If ((depth = 0) And (Not ignore) And (b >= startAt)) Then
                                        ' We' ve found a space. This means that the name of the
                                        ' command is now to the right of us. Hence, it's between
                                        ' B and A.

                                        cN = Mid$(bT, b + 1, a - b)

                                        Dim theInlineCommand As String
                                        theInlineCommand = UCase$(GetCommandName(cN))

                                        If (LenB(theInlineCommand) <> 0) Then

                                            ' Now let's execute this command
                                            oPP = prg.programPos
                                            rV.usingReturnData = True
                                            prg.programPos = DoSingleCommand(cN, prg, rV)
                                            prg.programPos = oPP

                                            ' Get the value it returned
                                            If (theInlineCommand <> "WAIT") _
                                             And (theInlineCommand <> "GET") Then
                                                Select Case rV.dataType
                                                    Case DT_NUM: v = " " & CStr(rV.num)
                                                    Case DT_LIT: v = " """ & rV.lit & """"
                                                    Case DT_REFERENCE: v = " " & rV.ref
                                                End Select
                                            Else
                                                ' Wait/Get command-- don't add quotes!
                                                v = " " & rV.lit
                                            End If

                                        Else
                                            ' Math-- don't touch
                                            v = cN
                                        End If

                                        ' Replace the command's name with
                                        ' the value it returned
                                        If Not (varExp) Then
                                            ret = _
                                                    prefix & _
                                                    "(" & _
                                                    Mid$(bT, 2, b - 1) & _
                                                    v & _
                                                    Mid$(bT, a + 1, Len(bT) - a) & _
                                                    ")"
                                        Else
                                            ret = _
                                                    Mid$(bT, 1, b) & _
                                                    v & _
                                                    Mid$(bT, a + 1, Len(bT) - a)
                                        End If

                                        ' Recurse!
                                        ParseRPGCodeCommand = _
                                            ParseRPGCodeCommand(ret, prg, b + 1)

                                        Exit Function
                                    End If ' (depth = 0) And (Not ignore)
                            End Select ' (char2)
                        Next b ' (b = a To 1 Step -1)
                    End If ' (depth = 0)
                End If ' (Not ignore)
        End Select ' (char)
    Next a ' (a = 1 To Len(bT))

    ' Return what we've done
    ParseRPGCodeCommand = line

End Function

'=========================================================================
' Replace not within quotes
'=========================================================================
Public Function replaceOutsideQuotes(ByRef Text As String, ByRef find As String, ByRef replace As String)

    On Error Resume Next

    '// Passing string(s) ByRef for preformance related reasons

    Dim ignore As Boolean
    Dim build As String
    Dim char As String
    Dim a As Long

    For a = 1 To Len(Text)
        char = Mid$(Text, a, 1)
        Select Case char
            Case """"
                ignore = (Not ignore)
        End Select
        If Not ignore Then If char = find Then char = replace
        build = build & char
    Next a

    replaceOutsideQuotes = build

End Function

'=========================================================================
' InStr outside quotes
'=========================================================================
Public Function inStrOutsideQuotes(ByVal start As Long, ByRef Text As String, ByRef find As String) As Long
    '// Passing Text and find ByRef for preformance related reasons
    On Error Resume Next
    Dim a As Long, ignore As Boolean, char As String
    For a = start To Len(Text)
        char = Mid$(Text, a, Len(find))
        If Left$(char, 1) = ("""") Then
            ignore = (Not ignore)
        ElseIf (char = find) And (Not ignore) Then
            inStrOutsideQuotes = a
            Exit Function
        End If
    Next a
End Function

'=========================================================================
' Replace vars like <var!> with their values
'=========================================================================
Public Function MWinPrepare(ByVal Text As String, ByRef prg As RPGCodeProgram) As String

    On Error Resume Next

    'Find the first <
    Dim firstLocation As Long
    firstLocation = InStr(1, Text, "<")

    'If we found one
    If firstLocation <> 0 Then

        'Find the associated >
        Dim secondLocation As Long
        secondLocation = InStr(1, Text, ">")

        'If we found one
        If secondLocation <> 0 Then

            'Get the name of the variable between them
            Dim theVar As String
            theVar = Mid$(Text, firstLocation + 1, secondLocation - firstLocation - 1)

            'Put the variable in brackets
            Dim cLine As String
            cLine = "(" & theVar & ")"

            'Use GetParameters() to get its value
            Dim value() As parameters
            value() = GetParameters(cLine, prg)

            'Change it to a string, if required
            Dim theValue As String
            If (value(0).dataType <> DT_NUM) Then
                theValue = value(0).lit
            Else
                theValue = CStr(value(0).num)
            End If

            'Replace <var!> with the var's value
            Text = replace(Text, "<" & theVar & ">", theValue)

            'Recurse passing in the running text
            MWinPrepare = MWinPrepare(Text, prg)

            Exit Function

        End If

    End If

    'Return what we've done
    MWinPrepare = Text

End Function

'=========================================================================
' Parse an array
'=========================================================================
Public Function parseArray(ByRef variable As String, ByRef prg As RPGCodeProgram) As String

    ' This will take an array such as Array[a!+2]["Pos"]$ and replace variables, commands,
    ' equations, etc with their values.

    '// Passing string(s) ByRef for preformance related reasons

    ' Just skip errors because they're probably the rpgcoder's fault
    On Error GoTo skipError

    ' Have something to return incase we leave early
    parseArray = variable

    If (InStrB(1, variable, "[") = 0) Then
        ' There's not a [ so it's not an array and we're not needed
        Exit Function
    End If

    Dim toParse As String
    ' First remove spaces and tabs
    toParse = replaceOutsideQuotes(variable, " ", vbNullString)
    toParse = replaceOutsideQuotes(toParse, vbTab, vbNullString)

    Dim variableType As String
    ' Grab the variable's type (! or $)
    variableType = Right$(toParse, 1)
    If (variableType <> "!" And variableType <> "$") Then variableType = vbNullString

    Dim start As Long
    Dim tEnd As Long

    ' See where the first [ is
    start = InStr(1, toParse, "[")

    Dim variableName As String
    ' Grab the variable's name
    variableName = Mid$(toParse, 1, start - 1)

    ' Check it it's an object
    Dim hClass As Long, hClassDbl As Double, lit As String
    Call getValue(variableName & "!", lit, hClassDbl, prg)
    hClass = CLng(hClassDbl)
    If (hClass <> 0) Then
        If (isObject(hClass, prg)) Then
            ' Check for overloaded [] operator
            If (Not isMethodMember("operator[]", hClass, prg, topNestle(prg) <> hClass)) Then
                ' Alert the user
                Call debugger("Overloaded [] operator not found or cannot be reached-- " & variable)
                ' Nullify hClass
                hClass = 0
            End If
        Else
            ' Nullify hClass
            hClass = 0
        End If
    End If

    ' Find the last ]
    tEnd = InStr(1, StrReverse(toParse), "]")
    tEnd = Len(toParse) - tEnd + 1

    ' Just keep what's inbetween the two
    toParse = Mid$(toParse, start + 1, tEnd - start - 1)

    Dim parseArrayD() As String
    ' Split it at '][' (bewteen elements)
    parseArrayD() = Split(toParse, "][")

    Dim build As String
    Dim a As Long

    build = "Array("

    ' Mould the array as if it were parameters passed to a command
    For a = 0 To UBound(parseArrayD)
        build = build & parseArrayD(a)
        If (a <> UBound(parseArrayD)) Then
            build = build & ","
        Else
            build = build & ")"
        End If
    Next a

    ' Parse for commands
    build = ParseRPGCodeCommand(build, prg)

    Dim arrayElements() As parameters
    ' Use my getParameters() function to retrieve the values of the dimensions
    arrayElements() = GetParameters(build, prg)

    ' Splice out the object's overloaded [] operator, if existent
    If (hClass <> 0) Then
        ' Create a return value
        Dim retval As RPGCODE_RETURN
        ' Call the method
        If (arrayElements(0).dataType = DT_LIT) Then
            Call callObjectMethod(hClass, "operator[](""" & arrayElements(0).lit & """)", prg, retval, "operator[]")
        Else
            Call callObjectMethod(hClass, "operator[](" & CStr(arrayElements(0).num) & ")", prg, retval, "operator[]")
        End If
        ' Make sure we got a reference
        If (retval.dataType <> DT_REFERENCE) Then
            Call debugger("Overloaded [] operator must return a reference to a variable-- " & variable)
            Exit Function
        End If
        ' Vold the data in between the []s
        arrayElements(0).dataType = DT_VOID
        ' Set in the new variable name
        variableName = retval.ref
        ' Check for postfixed sign
        Dim postFix As String
        postFix = Right$(variableName, 1)
        If ((postFix = "!") Or (postFix = "$")) Then
            ' Override this array's sign
            variableType = postFix
            ' Remove the sign from the variable name
            variableName = Mid$(variableName, 1, Len(variableName) - 1)
        End If
    End If

    ' Begin to build the return value
    build = variableName

    ' For each dimension
    For a = 0 To UBound(arrayElements)

        ' Add in the content
        Select Case arrayElements(a).dataType
            Case DT_NUM: build = build & "[" & CStr(arrayElements(a).num) & "]"
            Case DT_LIT: build = build & "[""" & arrayElements(a).lit & """]"
        End Select

    Next a

    ' Pass it back with the type (! or $) on the end
    parseArray = build & variableType

skipError:
End Function
