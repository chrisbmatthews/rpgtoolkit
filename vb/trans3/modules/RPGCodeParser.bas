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
Public Function GetMethodName(ByVal Text As String, ByRef thePrg As RPGCodeProgram) As String

    On Error GoTo errorhandler
    
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
        If part$ <> " " And part$ <> Chr$(9) And part$ <> "#" Then
            If thePrg.autoCommand Then
                startHere = t - 1
                If startHere = 0 Then startHere = 1
                Exit For
            End If
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
            mName$ = mName$ + part$
        End If
    Next t
    GetMethodName = mName$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
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
            toRet = toRet + part
        End If
    Next t
    
    ParseBefore = ""
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
   
    'Declarations...
    Dim signs() As String
    Dim p() As Long
    Dim whichSpot As Long
    Dim start As Long
    Dim a As Long
    Dim s As Long
    
    'Dimension p()...
    ReDim p(0)
    
    'Math signs...
    ReDim signs(16)
    signs(0) = "+="
    signs(1) = "-="
    signs(2) = "++"
    signs(3) = "--"
    signs(4) = "=+"
    signs(5) = "=-"
    signs(6) = "*="
    signs(7) = "/="
    signs(8) = "=*"
    signs(9) = "=/"
    signs(10) = "="
    signs(11) = "+"
    signs(12) = "-"
    signs(13) = "/"
    signs(14) = "*"
    signs(15) = "^"
    signs(16) = "\"
    If comparison Then
        ReDim Preserve signs(19)
        signs(17) = "<"
        signs(18) = ">"
        signs(19) = "~"
    End If
    
    'Have p() enlarge itself...
    On Error GoTo enlargeP
    
    'Find that sign!
    start = 1
    For a = 1 To num
        For s = 0 To UBound(signs)
            p(s) = InStr(start, Text, signs(s), vbTextCompare)
        Next s
        start = lowest(p, whichSpot) + 1
        If Not a = num Then
            ReDim p(0)
        Else
            On Error Resume Next
            If signs(whichSpot) = "=+" Then signs(whichSpot) = "+="
            If signs(whichSpot) = "=-" Then signs(whichSpot) = "-="
            If signs(whichSpot) = "=*" Then signs(whichSpot) = "*="
            If signs(whichSpot) = "=/" Then signs(whichSpot) = "/="
            MathFunction = signs(whichSpot)
        End If
    Next a

Exit Function

enlargeP:
    ReDim Preserve p(UBound(p) + 1)
    Resume
    
End Function

'=========================================================================
' Evaluates if the text passed in is true (1) or false (0)
'=========================================================================
Public Function Evaluate(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Long

    On Error GoTo errorhandler

    Dim use As String, Length As Long, val1 As String, val2 As String, part As String, p As Long
    Dim eqtype As String, startAt As Long, equ As String, val1type As Long, val2type As Long, var1type As Long, var2type As Long

    Text = "Eval( " & Text & " )"
    Text = ParseRPGCodeCommand(Text, theProgram)
    Text = Trim(Mid(Text, 7, Len(Text) - 8))
   
    use$ = Text$
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
                        If Evaluate(andOr(runThrough), theProgram) = 0 Then
                            stillOK = False
                            Exit For
                        End If
                        
                    Case 3, 4 ' OR
                        If Evaluate(andOr(runThrough), theProgram) = 1 Then
                            stillOK = True
                            Exit For
                        End If

                End Select
                
            Next runThrough
            
            'Return the result...
            Evaluate = booleanToLong(stillOK)
            
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
            If part$ <> " " Then val1$ = val1$ + part$
        End If
    Next p
    equ$ = eqtype$
    For p = startAt + 1 To Length
        part$ = Mid$(use$, p, 1)
        If part$ <> " " Then
            If part$ = "=" Or part$ = ">" Or part$ = "<" Then
                equ$ = equ$ + part$
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
        If part$ <> " " Then val2$ = val2$ + part$
    Next p
        
    If equ = "" Then
        'If only one value was passed, check if it equals 1
        equ = "=="
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
            Evaluate = num1
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

    Evaluate = returnVal

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'=========================================================================
' Get the variable at number in an equation
'=========================================================================
Public Function GetVarList(ByVal Text As String, ByVal number As Long) As String

    On Error Resume Next

    Dim ignoreNext As Long, element As Long, part As String, p As Long, returnVal As String
    
    For p = 1 To Len(Text) + 1

        part = Mid(Text, p, 1)

        If part = Chr(34) Then
            If ignoreNext = 0 Then
                ignoreNext = 1
            Else
                ignoreNext = 0
            End If

        ElseIf part = "=" Or part = "+" Or part = "-" Or part = "/" Or part = "*" Or part = "\" Or part = "^" Then
            If ignoreNext = 0 Then
                element = element + 1
                If element = number Then
                    GetVarList = returnVal
                    Exit Function
                Else
                    returnVal = ""
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
        part = Mid(Text, t, 1)
        If part = startSymbol Then
            'founf start symbol.
            'now locate end symbol...
            For l = t + 1 To Length
                part = Mid(Text, l, 1)
                If part = startSymbol Then
                    ignoreDepth = ignoreDepth + 1
                ElseIf part = endSymbol Then
                    If ignoreDepth = 0 Then
                        ParseWithin = toRet
                        Exit Function
                    End If
                    ignoreDepth = ignoreDepth - 1
                Else
                    toRet = toRet + part
                End If
            Next l
            ParseWithin = toRet
            Exit Function
        End If
    Next t
    
    ParseWithin = ""
End Function

'=========================================================================
' Determine if a string contains a substring
'=========================================================================
Public Function stringContains(ByVal theString As String, ByVal theChar As String) As Boolean
    If InStr(1, theString, theChar, vbTextCompare) > 0 Then
        stringContains = True
    End If
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
        part = Mid(Text, p, 1)
        If part = Chr(34) Then
            If ignoreNext = 1 Then
                ignoreNext = 0
            Else
                ignoreNext = 1
            End If
        ElseIf part = "=" Or part = "+" Or part = "-" Or part = "/" Or part = "*" Or part = "\" Or part = "^" Then
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
        part = Mid(Text, p, 1)
        If part = Chr(34) Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
        ElseIf part = "," Or part = ";" Or part = "" Then
            If ignore = 0 Then
                element = element + 1
                If element = eleeNum Then
                    GetElement = returnVal
                    Exit Function
                Else
                    returnVal = ""
                End If
            Else
                returnVal = returnVal & part
            End If
        Else
            returnVal = returnVal & part
        End If
    Next p

End Function

'=========================================================================
' Count the number of bracket elements in text
'=========================================================================
Public Function CountData(ByVal Text As String) As Long

    On Error Resume Next

    'If there is no text, there are no elements
    Dim gB As String
    gB = GetBrackets(Text, True)
    If gB = "" Then Exit Function

    'Setup delimiter array
    Dim c(1) As String
    c(0) = ","
    c(1) = ";"

    'Split at the delimiters
    Dim s() As String
    Dim uD() As String
    s() = multiSplit(Text, c, uD, True)

    'Number of data elements will be one higher than the upper bound
    CountData = UBound(s) + 1

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
        part = Mid(Text, p, 1)
        If part = "#" Then posAt = p
        Exit For
    Next p
    If posAt = 0 Then
        Exit Function 'couldn't find a command!
    End If
    For p = posAt To Length     'Find first occurrence of command name
        part = Mid(Text$, p, 1)
        If part <> " " Then
            posAt = p
            Exit For
        End If
    Next p
    For p = posAt To Length     'Find where command name ends.
        part = Mid(Text$, p, 1)
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
        If ((part = ")") And ignoreClosing = False And bracketDepth <= 0) Or part = "" Then
            Exit For
        Else
            If part = ")" Then
                bracketDepth = bracketDepth - 1
            ElseIf part = Chr(34) Then
                'quote-- ignore stuff inside quotes.
                If ignoreClosing = True Then
                    'clsing quote...
                    ignoreClosing = False
                Else
                    ignoreClosing = True
                End If
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
Public Function GetCommandName( _
                                  ByVal splice As String, _
                                  ByRef thePrg As RPGCodeProgram _
                                                                   ) As String

    On Error Resume Next

    If splice = "" Then Exit Function
    
    Dim Length As Long, foundIt As Long, p As Long, part As String, starting As Long, commandName As String
    Dim testIt As String
    
    Length = Len(splice)
    'Look for #
    For p = 1 To Length
        part = Mid$(splice, p, 1)
        If part <> " " And part <> "#" And part <> Chr(9) Then
            If thePrg.autoCommand Then

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
            Else
                foundIt = 0
                Exit For
            End If

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
            If part$ <> " " And part$ <> "@" And part$ <> Chr$(9) Then
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
                If part$ <> " " And part$ <> "*" And part$ <> Chr$(9) Then foundIt = 0: p = Length
                If part$ = "*" Then GetCommandName$ = "*": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe a label
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ":" And part$ <> Chr$(9) Then foundIt = 0: p = Length
                If part$ = ":" Then GetCommandName$ = "LABEL": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> "<" And part$ <> "{" And part$ <> Chr$(9) Then foundIt = 0: p = Length
                If part$ = "<" Or part$ = "{" Then GetCommandName$ = "OPENBLOCK": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ">" And part$ <> "}" And part$ <> Chr$(9) Then foundIt = 0: p = Length
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
    
    commandName$ = ""
    'now find command
    For p = starting To Length
        part$ = Mid$(splice$, p, 1)
        If part$ = " " Or part$ = "(" Or part$ = "=" Then p = Length: part$ = ""
        commandName$ = commandName$ + part$
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

    'Declarations...
    Dim ret() As parameters
    Dim count As Long
    Dim brackets As String
    Dim a As Long
    Dim lit As String
    Dim num As Double
    Dim dataType As RPGC_DT
 
    'Get the parameters...
    count = CountData(Text)
    brackets = GetBrackets(Text)
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
                                       ByRef prg As RPGCodeProgram _
                                                                     ) As String

    'We're going to find all the commands (functions) inside this command
    'and replace them with their values. You can have nestled commands, and
    'even commands added to variables. Yes, this is the parser to end all
    'parsers (heh...)

    'First see if we'll actually be of any use...
    Select Case UCase(GetCommandName(line, prg))
        Case "@", "*", "LABEL", "OPENBLOCK", "CLOSEBLOCK", _
            "REDIRECT", "METHOD"
            ParseRPGCodeCommand = line
            Exit Function
    End Select
 
    Dim depth As Long
 
    Dim char As String
    Dim a As Long
    Dim b As Long
 
    Dim prefix As String
    prefix = LCase(GetCommandName(line, prg))
 
    Dim bT As String
    bT = " " & GetBrackets(line)
    If GetCommandName(line, prg) = "VAR" Then bT = line
    
    Dim cN As String
    Dim rV As RPGCODE_RETURN
    Dim v As String
 
    Dim oPP As Long
 
    Dim ignore As Boolean
 
    For a = 1 To Len(bT)
        char = Mid(bT, a, 1)
        Select Case UCase(char)

            Case """"
                If ignore Then
                    ignore = False
                Else
                    ignore = True
                End If

            Case "(": If Not ignore Then depth = depth + 1

            Case ")"
                If Not ignore Then
                    depth = depth - 1
                    If depth = 0 Then

                        Dim char2 As String
                        For b = a To 1 Step -1
                            'Work backwards and find the name of this command!
                            char2 = Mid(bT, b, 1)
                            Select Case char2

                                Case """"
                                    If ignore Then
                                        ignore = False
                                    Else
                                        ignore = True
                                    End If
                                    
                                Case "(": If Not ignore Then depth = depth - 1
                                Case ")": If Not ignore Then depth = depth + 1

                                Case " ", ",", "#", "=", "<", ">", "+", "-", ";", "*", "\", "/", "^"

                                    If (depth = 0) And (Not ignore) Then
                                        'We've found a space. This means that the name of the
                                        'command is now to the right of us. Hence, it's between
                                        'B and A.
                                        cN = Mid(bT, b + 1, a - b)

                                        'Now let's execute this command...
                                        oPP = prg.programPos
                                        rV.usingReturnData = True
                                        prg.programPos = DoSingleCommand(cN, prg, rV)
                                        prg.programPos = oPP

                                        'Get the value it returned...
                                        Select Case rV.dataType
                                            Case DT_NUM: v = CStr(rV.num)
                                            Case DT_LIT: v = """" & rV.lit & """"
                                        End Select

                                        'Replace the command's name with its returned value...
                                        Dim ret As String
                                        If Not GetCommandName(line, prg) = "VAR" Then
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
                                            ParseRPGCodeCommand(ret, prg)

                                    Exit Function
                                End If
                            End Select
                        Next b
                    End If
                End If
            End Select
        Next a

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
        char = Mid(Text, a, 1)
        Select Case char
            Case """"
                If ignore Then
                    ignore = False
                Else
                    ignore = True
                End If
        End Select
        If Not ignore Then If char = find Then char = replace
        build = build & char
    Next a

    replaceOutsideQuotes = build

End Function
