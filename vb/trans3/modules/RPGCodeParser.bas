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
' Integral variables
'=========================================================================
Public Type parameters          'rpgcode parmater structure
    num As Double               '  numerical
    lit As String               '  literal
    dat As String               '  un-altered data
    dataType As RPGC_DT         '  type returned (lit or num)
End Type

'=========================================================================
' Returns the name of the method from a method delcaration
'=========================================================================
Public Function GetMethodName(ByVal Text As String) As String

    On Error Resume Next
    
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
Public Function ParseAfter(ByVal Text As String, ByVal startSymbol As String) As String

    On Error Resume Next

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
            toRet = toRet + part
        Next t
    End If
    
    ParseAfter = toRet
End Function

'=========================================================================
' Return content from text until startSymbol is located
'=========================================================================
Public Function ParseBefore(ByVal Text As String, ByVal startSymbol As String) As String

    On Error Resume Next

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
    Dim a As Long
    For a = 0 To UBound(values)
        If a = 0 Then
            lowest = values(a)
            whichSpot = 0
        Else
            If (values(a) < lowest Or lowest = 0) And values(a) > 0 Then
                lowest = values(a)
                whichSpot = a
            End If
        End If
    Next a
End Function

'=========================================================================
' Returns the math function at pos num, optionally including comparsion
'=========================================================================
Public Function MathFunction(ByVal Text As String, ByVal num As Long, Optional ByVal comparison As Boolean) As String

    On Error Resume Next

    Dim signs() As String   'Array of math operators
    Dim p() As Long         'Positions of those operators
    Dim whichSpot As Long   'The spot containing the value returned
    Dim start As Long       'Position to start at in text
    Dim a As Long           'For loop control variable
    Dim S As Long           'For loop control variable

    ReDim signs(20)
    signs(0) = "|="
    signs(1) = "&="
    signs(2) = "`="
    signs(3) = "%="
    signs(4) = "+="
    signs(5) = "-="
    signs(6) = "++"
    signs(7) = "--"
    signs(8) = "*="
    signs(9) = "/="
    signs(10) = "="
    signs(11) = "+"
    signs(12) = "-"
    signs(13) = "/"
    signs(14) = "*"
    signs(15) = "^"
    signs(16) = "\"
    signs(17) = "|"
    signs(18) = "&"
    signs(19) = "`"
    signs(20) = "%"
    If (comparison) Then
        ReDim Preserve signs(23)
        signs(21) = "<"
        signs(22) = ">"
        signs(23) = "~"
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
        If a <> num Then
            ReDim p(UBound(signs))
        Else
            MathFunction = signs(whichSpot)
        End If
    Next a

End Function

'=========================================================================
' Evaluates if the text passed in is true (1) or false (0)
'=========================================================================
Public Function evaluate(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long

    On Error GoTo errorhandler

    Dim use As String, Length As Long, val1 As String, val2 As String, part As String, p As Long
    Dim eqtype As String, startAt As Long, equ As String, val1type As Long, val2type As Long, var1type As Long, var2type As Long

    'Text = "Eval( " & Text & " )"
    'Text = ParseRPGCodeCommand(Text, theProgram)
    'Text = Trim$(Mid$(Text, 7, Len(Text) - 8))
   
    use$ = Text$
    Length = Len(use$)
    val1$ = vbNullString
       
    Dim andOr() As String
    Dim checkBoth As Long
    Dim runThrough As Long
    Dim stillOK As Boolean
    Dim c As String
       
    For checkBoth = 1 To 4
    
        If checkBoth = 1 Then c = "&&"
        If checkBoth = 2 Then c = " and "
        If checkBoth = 3 Then c = "||"
        If checkBoth = 4 Then c = " or "

        'Split up the line...
        andOr() = Split(LCase$(use), c, , vbTextCompare)
               
        If Not UBound(andOr) = 0 Then
            stillOK = (checkBoth = 1 Or checkBoth = 2)
            stillOK = (Not (checkBoth = 3 Or checkBoth = 4))
            For runThrough = 0 To UBound(andOr)
                Select Case checkBoth
                
                    Case 1, 2 ' AND
                        If evaluate(andOr(runThrough), theProgram) = 0 Then
                            stillOK = False
                            Exit For
                        End If
                        
                    Case 3, 4 ' OR
                        If evaluate(andOr(runThrough), theProgram) = 1 Then
                            stillOK = True
                            Exit For
                        End If

                End Select
                
            Next runThrough
            
            'Return the result...
            evaluate = booleanToLong(stillOK)
            
            'Exit this function...
            Exit Function
            
        End If
    Next checkBoth
   
    'Get first variable
    For p = 1 To Length
        part$ = Mid$(use$, p, 1)
        If part$ = "=" Or part$ = "~" Or part$ = ">" Or part$ = "<" Then
            'Found equality operator
            eqtype$ = part$
            startAt = p
            p = Length
        Else
            If part$ <> " " Then val1$ = val1 & part$
        End If
    Next p
    equ$ = eqtype$
    For p = startAt + 1 To Length
        part$ = Mid$(use$, p, 1)
        If part$ <> " " Then
            If part$ = "=" Or part$ = ">" Or part$ = "<" Then
                equ$ = equ & part$
                startAt = p + 1
                p = Length
            Else
                startAt = p
                p = Length
            End If
        End If
    Next p
    'Now get the other variable
    val2$ = vbNullString
    For p = startAt To Length
         part$ = Mid$(use$, p, 1)
        If part$ <> " " Then val2$ = val2 & part$
    Next p

    If (LenB(equ) = 0) Then
        ' If only one value was passed, check if it's non-zero
        equ = "~="
        val2 = "0"
    End If

    Dim lit1 As String, lit2 As String, num1 As Double, num2 As Double
    val1type = getValue(val1$, lit1$, num1, theProgram)
    val2type = getValue(val2$, lit2$, num2, theProgram)
    var1type = val1type
    var2type = val2type

    'Mop up some crazy possibilities:
    If val1type <> val2type Then Exit Function
    If LenB(val1) = 0 And LenB(val2$) = 0 Then Exit Function
    If (LenB(val1) <> 0) And (LenB(val2) = 0) Then
        If val1type = 0 Then
            evaluate = num1
            Exit Function
        Else
            Exit Function
        End If
    End If
    Dim returnVal As Long
    returnVal = 0
    If equ = "=" Or equ = "==" Then
        If var1type = 0 Then
            'numerical
            If num1 = num2 Then returnVal = 1
        Else
            If lit1 = lit2 Then returnVal = 1
        End If
    End If
    If equ = "~" Or equ = "~=" Or equ = "=~" Then
        If var1type = 0 Then
            'numerical
            If num1 <> num2 Then returnVal = 1
        Else
            If lit1 <> lit2 Then returnVal = 1
        End If
    End If
    If equ = "<=" Or equ = "=<" Then
        If var1type = 0 Then
            'numerical
            If num1 <= num2 Then returnVal = 1
        End If
    ElseIf equ = ">=" Or equ$ = "=>" Then
        If var1type = 0 Then
            'numerical
            If num1 >= num2 Then returnVal = 1
        End If
    ElseIf equ = ">" Or equ$ = ">" Then
        If var1type = 0 Then
            'numerical
            If num1 > num2 Then returnVal = 1
        End If
    ElseIf equ = "<" Or equ$ = "<" Then
        If var1type = 0 Then
            'numerical
            If num1 < num2 Then returnVal = 1
        End If
    End If

    evaluate = returnVal

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

'=========================================================================
' Get the variable at number in an equation
'=========================================================================
Public Function GetVarList(ByVal Text As String, ByVal number As Long) As String

    On Error Resume Next

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
Public Function ParseWithin(ByVal Text As String, ByVal startSymbol As String, ByVal endSymbol As String) As String

    On Error Resume Next

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
' Determine if a string contains a substring
'=========================================================================
Public Function stringContains(ByVal theString As String, ByVal theChar As String) As Boolean
    stringContains = (InStr(1, theString, theChar, vbTextCompare) > 0)
End Function

'=========================================================================
' Count the number of values in an equation
'=========================================================================
Public Function ValueNumber(ByVal Text As String) As Long

    On Error Resume Next

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
            If ignoreNext = 0 Then ele = ele + 1
        End If
    Next p

    ValueNumber = ele

End Function

'=========================================================================
' Remove the character passed in from the text passed in
'=========================================================================
Public Function removeChar(ByVal Text As String, ByVal char As String) As String
    On Error Resume Next
    removeChar = replace(Text, char, "")
End Function

'=========================================================================
' Get the bracket element at eleeNum
'=========================================================================
Public Function GetElement(ByVal Text As String, ByVal eleeNum As Long) As String

    On Error Resume Next

    Dim Length As Long, element As Long, part As String, ignore As Long, returnVal As String, p As Long
    
    Length = Len(Text$)
    For p = 1 To Length + 1
        part = Mid$(Text, p, 1)
        If part = ("""") Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
            returnVal = returnVal & part
        ElseIf part = "," Or part = ";" Or (LenB(part) = 0) Then
            If ignore = 0 Then
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
Public Function CountData(ByVal Text As String) As Long

    On Error Resume Next

    'If there is no text, there are no elements
    Dim gB As String
    gB = GetBrackets(Text, True)
    If (LenB(gB) = 0) Then Exit Function

    'Setup delimiter array
    Dim c(1) As String
    c(0) = ","
    c(1) = ";"

    'Split at the delimiters
    Dim S() As String
    Dim uD() As String
    S() = multiSplit(Text, c, uD, True)

    'Number of data elements will be one higher than the upper bound
    CountData = UBound(S) + 1

End Function

'=========================================================================
' Return the first space after the command / the opening bracket
'=========================================================================
Public Function LocateBrackets(ByVal Text As String) As Long

    On Error Resume Next
    
    Dim Length As Long, p As Long, part As String, posAt As Long
    
    'First look for brackets--make it easy:
    Length = Len(Text$)
    For p = 1 To Length
        part = Mid$(Text$, p, 1)
        If part = "(" Then
            posAt = p
            Exit For
        End If
    Next p
    If posAt <> 0 Then
        LocateBrackets = posAt
        Exit Function
    End If

    'OK- no brackets.  Find position of first space after command.
    For p = 1 To Length
        part = Mid$(Text, p, 1)
        If part = "#" Then posAt = p
        Exit For
    Next p
    If posAt = 0 Then
        Exit Function 'couldn't find a command!
    End If
    For p = posAt To Length     'Find first occurrence of command name
        part = Mid$(Text$, p, 1)
        If part <> " " Then
            posAt = p
            Exit For
        End If
    Next p
    For p = posAt To Length     'Find where command name ends.
        part = Mid$(Text$, p, 1)
        If part = " " Then
            posAt = p
            Exit For
        End If
    Next p

    LocateBrackets = posAt

End Function

'=========================================================================
' Retrieve the text inside the brackets
'=========================================================================
Public Function GetBrackets(ByVal Text As String, Optional ByVal doNotCheckForBrackets As Boolean) As String

    On Error Resume Next

    Dim ignoreClosing As Boolean
    Dim use As String, location As Long, Length As Long, bracketDepth As Long, p As Long, part As String
    Dim fullUse As String
    
    use = Text
    location = LocateBrackets(use)
    Length = Len(Text)
    
    If Not doNotCheckForBrackets Then
        If Not stringContains(Text, "(") Then
            If Not stringContains(Text, ")") Then
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
Public Function GetCommandName(ByVal splice As String) As String

    On Error Resume Next

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
Public Function GetParameters(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As parameters()

    On Error Resume Next

    ' Declarations...
    Dim ret() As parameters
    Dim count As Long
    Dim brackets As String
    Dim a As Long
    Dim lit As String
    Dim num As Double
    Dim dataType As RPGC_DT

    ' Get the parameters...
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

    ' Pass back the data...
    GetParameters = ret()

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
                                       ByVal line As String, _
                                       ByRef prg As RPGCodeProgram, _
                                       Optional ByVal startAt As Long _
                                                                        ) As String

    ' We' re going to find all the commands (functions) inside this command
    ' and replace them with their values. You can have nestled commands, and
    ' even commands added to variables. Yes, this is the parser to end all
    ' parsers (heh...)

    On Error Resume Next

    Dim cmdName As String       ' Command name of line we're parsing
    cmdName = UCase$(GetCommandName(line))

    ' Some things don' t require parsing
    Select Case cmdName
        Case "@", "*", "", "LABEL", "OPENBLOCK", "CLOSEBLOCK", "REDIRECT", "METHOD"
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
                                Case " ", ",", "#", "=", "<", ">", "+", "-", ";", "*", "\", "/", "^", "%", "`", "|", "&"

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
                                        If (Not varExp) Then
                                            ret = _
                                                    prefix & _
                                                    "(" & _
                                                    Mid$(bT, 2, b - 1) & _
                                                    v & _
                                                    Mid$(bT, a + 1, Len(bT) - a) & _
                                                    ")"
                                        Else
                                            ret = _
                                                    Mid$(bT, 1, b - 1) & _
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
Public Function replaceOutsideQuotes(ByVal Text As String, ByVal find As String, ByVal replace As String)

    On Error Resume Next

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
Public Function inStrOutsideQuotes(ByVal start As Long, ByVal Text As String, ByVal find As String) As Long
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
    If firstLocation > 0 Then

        'Find the associated >
        Dim secondLocation As Long
        secondLocation = InStr(1, Text, ">")

        'If we found one
        If secondLocation > 0 Then

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
Public Function parseArray(ByVal variable As String, ByRef prg As RPGCodeProgram) As String

    ' This will take an array such as Array[a!+2]["Pos"]$ and replace variables, commands,
    ' equations, etc with their values.

    ' Just skip errors because they're probably the rpgcoder's fault
    On Error GoTo skipError

    ' Have something to return incase we leave early
    parseArray = variable

    Dim toParse As String
    ' First remove spaces and tabs
    toParse = replaceOutsideQuotes(variable, " ", "")
    toParse = replaceOutsideQuotes(toParse, vbTab, "")

    If (InStr(1, toParse, "[") = 0) Then
        ' There's not a [ so it's not an array and we're not needed
        Exit Function
    End If

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
