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
' Member declarations
'=========================================================================
Private Declare Sub RPGCInitParser Lib "actkrt3.dll" (ByVal stringFunction As Long)
Private Declare Sub RPGCGetMethodName Lib "actkrt3.dll" (ByVal text As Long)
Private Declare Sub RPGCParseAfter Lib "actkrt3.dll" (ByVal text As Long, ByVal startSymbol As Long)
Private Declare Sub RPGCParseBefore Lib "actkrt3.dll" (ByVal text As Long, ByVal endSymbol As Long)
Private Declare Sub RPGCGetVarList Lib "actkrt3.dll" (ByVal text As Long, ByVal number As Long)
Private Declare Sub RPGCParseWithin Lib "actkrt3.dll" (ByVal text As Long, ByVal startSymbol As Long, ByVal endSymbol As Long)
Private Declare Sub RPGCGetElement Lib "actkrt3.dll" (ByVal text As Long, ByVal elemNum As Long)
Private Declare Sub RPGCReplaceOutsideQuotes Lib "actkrt3.dll" (ByVal text As Long, ByVal find As Long, ByVal replace As Long)
Private Declare Sub RPGCGetBrackets Lib "actkrt3.dll" (ByVal text As Long)
Private Declare Sub RPGCGetCommandName Lib "actkrt3.dll" (ByVal text As Long)
Private Declare Function RPGCInStrOutsideQuotes Lib "actkrt3.dll" (ByVal startAt As Long, ByVal theString As Long, ByVal theSubString As Long) As Long
Private Declare Function RPGCValueNumber Lib "actkrt3.dll" (ByVal theString As Long) As Long

'=========================================================================
' Member variables
'=========================================================================
Private m_lastStr As String     'string returned from parsing functions

'=========================================================================
' Integral strcutures
'=========================================================================
Public Type parameters          'rpgcode parmater structure
    num As Double               '  numerical
    lit As String               '  literal
    dat As String               '  un-altered data
    dataType As RPGC_DT         '  type returned (lit or num)
End Type

'=========================================================================
' Initiate the parser
'=========================================================================
Public Sub initRPGCodeParser()
    Call RPGCInitParser(AddressOf setLastParseString)
End Sub

'=========================================================================
' Allows actkrt3.dll to set the current string
'=========================================================================
Private Sub setLastParseString(ByVal theString As String)
    'Set the string
    m_lastStr = theString
End Sub

'=========================================================================
' Returns the name of the method from a method delcaration
'=========================================================================
Public Function GetMethodName(ByVal text As String) As String
    Call RPGCGetMethodName(StrPtr(text))
    GetMethodName = m_lastStr
End Function

'=========================================================================
' Return content in text after startSymbol is located
'=========================================================================
Public Function ParseAfter(ByVal text As String, ByVal startSymbol As String) As String
    Call RPGCParseAfter(StrPtr(text), StrPtr(startSymbol))
    ParseAfter = m_lastStr
End Function

'=========================================================================
' Return content from text until startSymbol is located
'=========================================================================
Public Function ParseBefore(ByVal text As String, ByVal endSymbol As String) As String
    Call RPGCParseBefore(StrPtr(text), StrPtr(endSymbol))
    ParseBefore = m_lastStr
End Function

'=========================================================================
' Get the variable at number in an equation
'=========================================================================
Public Function GetVarList(ByVal text As String, ByVal number As Long) As String
    Call RPGCGetVarList(StrPtr(text), number)
    GetVarList = m_lastStr
End Function

'=========================================================================
' Return the content in text between the start and end symbols
'=========================================================================
Public Function ParseWithin(ByVal text As String, ByVal startSymbol As String, ByVal endSymbol As String) As String
    Call RPGCParseWithin(StrPtr(text), StrPtr(startSymbol), StrPtr(endSymbol))
    ParseWithin = m_lastStr
End Function

'=========================================================================
' Count the number of values in an equation
'=========================================================================
Public Function ValueNumber(ByVal text As String) As Long
    ValueNumber = RPGCValueNumber(StrPtr(text))
End Function

'=========================================================================
' Get the bracket element at eleeNum
'=========================================================================
Public Function GetElement(ByVal text As String, ByVal eleeNum As Long) As String
    Call RPGCGetElement(StrPtr(text), eleeNum)
    GetElement = m_lastStr
End Function

'=========================================================================
' Retrieve the text inside the brackets
'=========================================================================
Public Function GetBrackets(ByVal text As String) As String
    Call RPGCGetBrackets(StrPtr(text))
    GetBrackets = m_lastStr
End Function

'=========================================================================
' Get the command name in the text passed in
'=========================================================================
Public Function GetCommandName(ByVal splice As String) As String
    Call RPGCGetCommandName(StrPtr(splice))
    GetCommandName = m_lastStr
End Function

'=========================================================================
' Replace not within quotes
'=========================================================================
Public Function replaceOutsideQuotes(ByVal text As String, ByVal find As String, ByVal replace As String) As String
    Call RPGCReplaceOutsideQuotes(StrPtr(text), StrPtr(find), StrPtr(replace))
    replaceOutsideQuotes = m_lastStr
End Function

'=========================================================================
' InStr outside quotes
'=========================================================================
Public Function inStrOutsideQuotes(ByVal start As Long, ByVal text As String, ByVal find As String) As Long
    inStrOutsideQuotes = RPGCInStrOutsideQuotes(start, StrPtr(text), StrPtr(find))
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
Public Function MathFunction(ByVal text As String, ByVal num As Long, Optional ByVal comparison As Boolean) As String

    On Error Resume Next

    Dim signs() As String   'Array of math operators
    Dim p() As Long         'Positions of those operators
    Dim whichSpot As Long   'The spot containing the value returned
    Dim start As Long       'Position to start at in text
    Dim a As Long           'For loop control variable
    Dim S As Long           'For loop control variable

    ReDim signs(12)
    signs(0) = "+="
    signs(1) = "-="
    signs(2) = "++"
    signs(3) = "--"
    signs(4) = "*="
    signs(5) = "/="
    signs(6) = "="
    signs(7) = "+"
    signs(8) = "-"
    signs(9) = "/"
    signs(10) = "*"
    signs(11) = "^"
    signs(12) = "\"
    If (comparison) Then
        ReDim Preserve signs(13)
        signs(13) = "<"
        signs(14) = ">"
        signs(15) = "~"
    End If

    'Dimension p to have room for all the signs
    ReDim p(UBound(signs))

    'Find that sign!
    start = 1
    For a = 1 To num
        For S = 0 To UBound(signs)
            p(S) = inStrOutsideQuotes(start, text, signs(S))
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
Public Function evaluate(ByVal text As String, ByRef theProgram As RPGCodeProgram) As Long

    On Error GoTo errorhandler

    Dim use As String, Length As Long, val1 As String, val2 As String, part As String, p As Long
    Dim eqtype As String, startAt As Long, equ As String, val1type As Long, val2type As Long, var1type As Long, var2type As Long

    text = "Eval( " & text & " )"
    text = ParseRPGCodeCommand(text, theProgram)
    text = Trim(Mid(text, 7, Len(text) - 8))
   
    use$ = text$
    Length = Len(use$)
    val1$ = ""
       
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
        andOr() = Split(LCase(use), c, , vbTextCompare)
               
        If Not UBound(andOr) = 0 Then
            If checkBoth = 1 Or checkBoth = 2 Then stillOK = True
            If checkBoth = 3 Or checkBoth = 4 Then stillOK = False
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
    val2$ = ""
    For p = startAt To Length
         part$ = Mid$(use$, p, 1)
        If part$ <> " " Then val2$ = val2 & part$
    Next p
    
    If (Right(val1, 1) <> "!" And Right(val1, 1) <> "$") Then
        val1 = val1 & "!"
    End If
    
    If equ = "" Then
        'If only one value was passed, check if it equals 1
        equ = ">="
        val2 = "1"
    End If

    Dim lit1 As String, lit2 As String, num1 As Double, num2 As Double
    val1type = getValue(val1$, lit1$, num1, theProgram)
    val2type = getValue(val2$, lit2$, num2, theProgram)
    var1type = val1type
    var2type = val2type

    'Mop up some crazy possibilities:
    If val1type <> val2type Then Exit Function
    If val1 = "" And val2$ = "" Then Exit Function
    If val1 <> "" And val2 = "" Then
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
' Count the number of bracket elements in text
'=========================================================================
Public Function CountData(ByVal text As String) As Long

    On Error Resume Next

    'If there is no text, there are no elements
    If (Not (InStr(1, text, "("))) Then
        If (Trim(text) = "") Then Exit Function
    Else
        If (Trim(GetBrackets(text)) = "") Then Exit Function
    End If

    'Setup delimiter array
    Dim c(1) As String
    c(0) = ","
    c(1) = ";"

    'Split at the delimiters
    Dim S() As String
    Dim uD() As String
    S() = multiSplit(text, c, uD, True)

    'Number of data elements will be one higher than the upper bound
    CountData = UBound(S) + 1

End Function

'=========================================================================
' Retrieve the parameters from the command passed in
'=========================================================================
Public Function GetParameters(ByVal text As String, ByRef theProgram As RPGCodeProgram) As parameters()

    On Error Resume Next

    'Declarations...
    Dim ret() As parameters
    Dim count As Long
    Dim brackets As String
    Dim a As Long
    Dim lit As String
    Dim num As Double
    Dim dataType As RPGC_DT
 
    'Get the parameters...
    count = CountData(text)
    brackets = GetBrackets(text)
    For a = 1 To count
        dataType = getValue(GetElement(brackets, a), lit, num, theProgram)
        ReDim Preserve ret(a - 1)
        Select Case dataType
            Case DT_LIT
                ret(a - 1).dataType = DT_LIT
                ret(a - 1).lit = lit
            Case DT_NUM
                ret(a - 1).dataType = DT_NUM
                ret(a - 1).num = num
        End Select
        ret(a - 1).dat = GetElement(brackets, a)
    Next a

    'Pass back the data...
    GetParameters = ret()

End Function

'=========================================================================
' Return the prefix to attach to lines starting with '.'
'=========================================================================
Public Function GetWithPrefix() As String
    On Error Resume Next
    If inWith(0) = "" Then Exit Function
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

    'We're going to find all the commands (functions) inside this command
    'and replace them with their values. You can have nestled commands, and
    'even commands added to variables. Yes, this is the parser to end all
    'parsers (heh...)

    On Error Resume Next

    Dim cmdName As String       'Command name of line we're parsing
    cmdName = UCase(GetCommandName(line))

    'Some things don't require parsing
    Select Case cmdName
        Case "@", "*", "", "LABEL", "OPENBLOCK", "CLOSEBLOCK", "REDIRECT", "METHOD"
            ParseRPGCodeCommand = line
            Exit Function
    End Select

    Dim depth As Long           'Depth within brackets
    Dim char As String          'A character
    Dim char2 As String         'Another character
    Dim a As Long               'Loop control
    Dim b As Long               'Loop control
    Dim prefix As String        'Command name
    Dim bT As String            'Line to work on
    Dim cN As String            'Function to execute
    Dim rV As RPGCODE_RETURN    'Value the function returned
    Dim v As String             'String value of rV
    Dim oPP As Long             'Program position before running function
    Dim ignore As Boolean       'Within quotes?
    Dim ret As String           'Value to return
    Dim varExp As Boolean       'Variable expression?

    'Check if we have a variable expression
    varExp = (cmdName = "VAR")

    'Get the text to operate on
    If (varExp) Then
        bT = line
    Else
        prefix = cmdName
        bT = " " & GetBrackets(line)
    End If

    'Loop over each character
    For a = 1 To Len(bT)

        'Get a character
        char = Mid(bT, a, 1)

        Select Case char

            'Quote
            Case Chr(34)
                ignore = (Not ignore)

            'Opening bracket
            Case "("
                If Not ignore Then depth = depth + 1

            'Closing bracket
            Case ")"
                If (Not ignore) Then
                    depth = depth - 1
                    If (depth = 0) Then

                        'Loop from current position backwards
                        For b = a To 1 Step -1

                            'Get a character
                            char2 = Mid(bT, b, 1)

                            Select Case char2

                                'Quote
                                Case Chr(34)
                                    ignore = (Not ignore)

                                'Opening/closing bracket
                                Case "(": If Not ignore Then depth = depth - 1
                                Case ")": If Not ignore Then depth = depth + 1

                                'Divider
                                Case " ", ",", "#", "=", "<", ">", "+", "-", ";", "*", "\", "/", "^"

                                    If ((depth = 0) And (Not ignore) And (b >= startAt)) Then
                                        'We've found a space. This means that the name of the
                                        'command is now to the right of us. Hence, it's between
                                        'B and A.

                                        cN = Mid(bT, b + 1, a - b)

                                        Dim theInlineCommand As String
                                        theInlineCommand = UCase(GetCommandName(cN))

                                        If (theInlineCommand <> "") Then

                                            'Now let's execute this command
                                            oPP = prg.programPos
                                            rV.usingReturnData = True
                                            prg.programPos = DoSingleCommand(cN, prg, rV)
                                            prg.programPos = oPP

                                            'Get the value it returned
                                            If (theInlineCommand <> "WAIT") _
                                             And (theInlineCommand <> "GET") Then
                                                Select Case rV.dataType
                                                    Case DT_NUM: v = " " & CStr(rV.num)
                                                    Case DT_LIT: v = " " & Chr(34) & rV.lit & Chr(34)
                                                End Select
                                            Else
                                                'Wait/Get command-- don't add quotes!
                                                v = " " & rV.lit
                                            End If

                                        Else
                                            'Math-- don't touch
                                            v = cN
                                        End If

                                        'Replace the command's name with
                                        'the value it returned
                                        If (Not varExp) Then
                                            ret = _
                                                    prefix & _
                                                    "(" & _
                                                    Mid(bT, 2, b - 1) & _
                                                    v & _
                                                    Mid(bT, a + 1, Len(bT) - a) & _
                                                    ")"
                                        Else
                                            ret = _
                                                    Mid(bT, 1, b - 1) & _
                                                    v & _
                                                    Mid(bT, a + 1, Len(bT) - a)
                                        End If

                                        'Recurse!
                                        ParseRPGCodeCommand = _
                                            ParseRPGCodeCommand(ret, prg, b + 1)

                                        Exit Function
                                    End If '(depth = 0) And (Not ignore)
                            End Select '(char2)
                        Next b '(b = a To 1 Step -1)
                    End If '(depth = 0)
                End If '(Not ignore)
        End Select '(char)
    Next a '(a = 1 To Len(bT))

    'Return what we've done
    ParseRPGCodeCommand = line

End Function

'=========================================================================
' Replace vars like <var!> with their values
'=========================================================================
Public Function MWinPrepare(ByVal text As String, ByRef prg As RPGCodeProgram) As String

    On Error Resume Next

    'Find the first <
    Dim firstLocation As Long
    firstLocation = InStr(1, text, "<")

    'If we found one
    If firstLocation > 0 Then

        'Find the associated >
        Dim secondLocation As Long
        secondLocation = InStr(1, text, ">")

        'If we found one
        If secondLocation > 0 Then

            'Get the name of the variable between them
            Dim theVar As String
            theVar = Mid(text, firstLocation + 1, secondLocation - firstLocation - 1)

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
            text = replace(text, "<" & theVar & ">", theValue)

            'Recurse passing in the running text
            MWinPrepare = MWinPrepare(text, prg)

            Exit Function

        End If

    End If

    'Return what we've done
    MWinPrepare = text

End Function

'=========================================================================
' Parse an array
'=========================================================================
Public Function parseArray(ByVal variable As String, ByRef prg As RPGCodeProgram) As String

    'This will take an array such as Array[a!+2]["Pos"]$ and replace variables, commands,
    'equations, etc with their values.

    'Just skip errors because they're probably the rpgcoder's fault
    On Error GoTo skipError

    'Have something to return incase we leave early
    parseArray = variable

    Dim toParse As String
    'First remove spaces and tabs
    toParse = replaceOutsideQuotes(variable, " ", "")
    toParse = replaceOutsideQuotes(toParse, vbTab, "")

    If InStr(1, toParse, "[") = 0 Then
        'There's not a [ so it's not an array and we're not needed
        Exit Function
    End If

    Dim variableType As String
    'Grab the variable's type (! or $)
    variableType = Right(toParse, 1)
    If (variableType <> "!" And variableType <> "$") Then variableType = ""

    Dim start As Long
    Dim tEnd As Long

    'See where the first [ is
    start = InStr(1, toParse, "[")

    Dim variableName As String
    'Grab the variable's name
    variableName = Mid(toParse, 1, start - 1)

    'Find the last ]
    tEnd = InStr(1, StrReverse(toParse), "]")
    tEnd = Len(toParse) - tEnd + 1

    'Just keep what's inbetween the two
    toParse = Mid(toParse, start + 1, tEnd - start - 1)

    Dim parseArrayD() As String
    'Split it at '][' (bewteen elements)
    parseArrayD() = Split(toParse, "][")

    Dim build As String
    Dim a As Long

    build = "Array("

    'Mould the array as if it were parameters passed to a command
    For a = 0 To UBound(parseArrayD)
        build = build & parseArrayD(a)
        If Not a = UBound(parseArrayD) Then
            build = build & ","
        Else
            build = build & ")"
        End If
    Next a

    Dim arrayElements() As parameters
    'Use my getParameters() function to retrieve the values of the dimensions
    arrayElements() = GetParameters(build, prg)

    'Begin to build the return value
    build = variableName

    'For each dimension
    For a = 0 To UBound(arrayElements)

        'Add on a [
        build = build & "["

        'Add in the content...
        Select Case arrayElements(a).dataType
            Case DT_NUM: build = build & CStr(arrayElements(a).num)
            Case DT_LIT: build = build & Chr(34) & arrayElements(a).lit & Chr(34)
        End Select

        'Add on a ]
        build = build & "]"

    Next a

    'Pass it back with the type (! or $) on the end
    parseArray = build & variableType

skipError:
End Function
