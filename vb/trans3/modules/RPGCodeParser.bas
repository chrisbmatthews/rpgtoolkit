Attribute VB_Name = "RPGCodeParser"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'string parsing routines.

Option Explicit

Public Enum dtType

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/28/04]
 
 '''''''''
 'Purpose'
 '''''''''
 'Makes remembering dt_ constants eaiser
 
 dtLit = 1
 dtNum = 0
 dtVoid = -1

End Enum

Public Type Parameters

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/28/04]
 
 '''''''''
 'Purpose'
 '''''''''
 'Holds data about the parameters passed to an RPGCode command
 
 num As Double
 lit As String
 dat As String
 dataType As dtType
End Type

Function GetMethodName(ByVal Text$, ByRef thePrg As RPGCodeProgram) As String
    'Return name of a method from a method statement.
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
        If part$ <> " " And part$ <> chr$(9) And part$ <> "#" Then
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

Function ParseAfter(ByVal Text As String, ByVal startSymbol As String) As String
    On Error Resume Next
    'parse out text after startSymbol
    '(ie, get stuff before a [ pair)
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

Function ParseBefore(ByVal Text As String, ByVal startSymbol As String) As String
    On Error Resume Next
    'parse out text before startSymbol
    '(ie, get stuff before a [ pair)
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

Public Function lowest(ByRef values() As Long, _
    Optional ByRef whichSpot As Long) As Long

    '=========================================================================
    'Added by KSNiloc
    '=========================================================================
    'Returns which value is the lowest
    
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

Public Function MathFunction _
    (ByVal Text As String, ByVal num As Long, Optional ByVal comparison As Boolean) _
        As String
    
    'Returns math function type in variable expression
    On Error Resume Next
   
    '===========================================================================
    'Improved by KSNiloc
    '===========================================================================
    'Previously couldn't detect signs that consisted of more than one character
    
    'Declarations...
    Dim signs() As String
    Dim p() As Long
    Dim whichSpot As Long
    Dim start As Long
    Dim a As Long
    Dim S As Long
    
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
        ReDim Preserve signs(18)
        signs(17) = "<"
        signs(18) = ">"
        signs(19) = "~"
    End If
    
    'Have p() enlarge itself...
    On Error GoTo enlargeP
    
    'Find that sign!
    start = 1
    For a = 1 To num
        For S = 0 To UBound(signs)
            p(S) = InStr(start, Text, signs(S), vbTextCompare)
        Next S
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

Function Evaluate(Text$, ByRef theProgram As RPGCodeProgram) As Long
    'Evaluates condition.
    'returns 0 for false, 1 for true
    On Error GoTo errorhandler
    Dim use As String, Length As Long, val1 As String, val2 As String, part As String, p As Long
    Dim eqtype As String, startAt As Long, equ As String, val1type As Long, val2type As Long, var1type As Long, var2type As Long

    '=====================================================================================
    'Allow for commands in the condition... [KSNiloc]
    '=====================================================================================
    Text = "Eval( " & Text & " )"
    Text = ParseRPGCodeCommand(Text, theProgram)
    Text = Trim(Mid(Text, 7, Len(Text) - 8))
   
    use$ = Text$
    Length = Len(use$)
    val1$ = ""
    
    ''''''''''''''''''''''''''
    '    Added by KSNiloc    '
    ''''''''''''''''''''''''''
    '[6/19/04]
    
    'Allow for AND and OR...
    
    'Declarations...
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
            Evaluate = BooleanToLong(stillOK)
            
            'Exit this function...
            Exit Function
            
        End If
    Next checkBoth
   
    ''''''''''''''''''''''''''
    '      End Addition      '
    ''''''''''''''''''''''''''
    
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
    
    '=====================================================================================
    'Default the second value to 1... [KSNiloc]
    '=====================================================================================
    If equ = "" Then
        equ = "="
        val2 = "1"
    End If

    Dim lit1 As String, lit2 As String, num1 As Double, num2 As Double
    val1type = GetValue(val1$, lit1$, num1, theProgram)
    val2type = GetValue(val2$, lit2$, num2, theProgram)
    var1type = val1type
    var2type = val2type
    'MsgBox "a" + equ$ + "a"

    'Mop up some crazy possibilities:
    If val1type <> val2type Then Evaluate = 0: Exit Function
    If val1$ = "" And val2$ = "" Then Evaluate = 0: Exit Function
    If val1$ <> "" And val2$ = "" Then
        If val1type = 0 Then
            Evaluate = num1: Exit Function
        Else
            Evaluate = 0: Exit Function
        End If
    End If
    Dim returnVal As Long
    returnVal = 0
    If equ$ = "=" Or equ$ = "==" Then
        If var1type = 0 Then
            'numerical
            If num1 = num2 Then returnVal = 1
        Else
            If lit1$ = lit2$ Then returnVal = 1
        End If
    End If
    If equ$ = "~" Or equ$ = "~=" Or equ$ = "=~" Then
        If var1type = 0 Then
            'numerical
            If num1 <> num2 Then returnVal = 1
        Else
            If lit1$ <> lit2$ Then returnVal = 1
        End If
    End If
    If equ$ = "<=" Or equ$ = "=<" Then
        If var1type = 0 Then
            'numerical
            If num1 <= num2 Then returnVal = 1
            'MsgBox Str$(num1) + Str$(num2)
        Else
            returnVal = 0
        End If
    End If
    If equ$ = ">=" Or equ$ = "=>" Then
        If var1type = 0 Then
            'numerical
            If num1 >= num2 Then returnVal = 1
        Else
            returnVal = 0
        End If
    End If
    If equ$ = ">" Or equ$ = ">" Then
        If var1type = 0 Then
            'numerical
            If num1 > num2 Then returnVal = 1
        Else
            returnVal = 0
        End If
    End If
    If equ$ = "<" Or equ$ = "<" Then
        If var1type = 0 Then
            'numerical
            If num1 < num2 Then returnVal = 1
        Else
            returnVal = 0
        End If
    End If
Evaluate = returnVal

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function CheckBlockStart(ByVal Text$, ByVal returnText$, ByVal openings As Long) As Long
    'Checks text$ for the beginning of a block
    'If the block starts here, then the command
    'contained within is returned as returntext$
    'If the block ends on this line, then it returns 1
    'On Error GoTo errorhandler
    Dim use As String, Length As Long, BeginHere As Long, p As Long, part As String, returnVal As String
    
    use$ = Text$
    Length = Len(use$)
    
    BeginHere = 0
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = ")" Then
            BeginHere = p + 1
            p = Length
        End If
    Next p
    
    'Check for the beginning of the Block (</{):
    'The starting pos will be placed in BeginHere
    For p = BeginHere To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = "<" Or part$ = "{" Then
            BeginHere = p + 1
            p = Length
            openings = 1
        End If
    Next p
    
    If BeginHere = 0 Or BeginHere > Length Then
        'alas, nothing was found
        CheckBlockStart = 0
        Exit Function
    End If
    
    'We've found the start of the block
    'Now search for the end.
    returnVal$ = ""
    For p = BeginHere To Length
        part$ = Mid$(use$, p, 1)
        If part$ = ">" Or part$ = "}" Then
            'We found the end of the block already!
            returnText$ = returnVal$
            openings = 0
            CheckBlockStart = 1 'The end was found
            Exit Function
        End If
        If part$ = "" Then
            'We've got a command, but we didn't find the end of the block
            returnText$ = returnVal$
            CheckBlockStart = 0 'The end wasn't found
            Exit Function
        Else
            returnVal$ = returnVal$ + part$
        End If
    Next p
    'We've got a command, but we didn't find the end of the block
    returnText$ = returnVal$
    CheckBlockStart = 0 'The end wasn't found

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function GetVarList(ByVal Text$, ByVal number As Long) As String
'Gets a variable from an expression.
'ie: joey!=1+fifty! has joey! as #1, 1 as #2, and fifty as #3
    On Error GoTo errorhandler
    Dim Length As Long, ignoreNext As Long, element As Long, part As String, p As Long, returnVal As String
    
    Length = Len(Text$)
    ignoreNext = 0
    element = 0
    For p = 1 To Length + 1
        part$ = Mid$(Text$, p, 1)
        If part$ = chr$(34) Then
            If ignoreNext = 0 Then
                ignoreNext = 1
            Else
                ignoreNext = 0
            End If
        End If
        If part$ = "=" Or part$ = "+" Or part$ = "-" Or part$ = "/" Or part$ = "*" Then
            If ignoreNext = 0 Then
                element = element + 1
                If element = number Then
                    GetVarList = returnVal$
                    Exit Function
                Else
                    returnVal$ = ""
                End If
            Else
                returnVal$ = returnVal$ + part$
            End If
        Else
            returnVal$ = returnVal$ + part$
        End If
    Next p

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function ParseWithin(ByVal Text As String, ByVal startSymbol As String, ByVal endSymbol As String) As String
    On Error Resume Next
    'parse out text enclosed by startSymbol and endSymbol
    '(ie, get stuff between a [] pair)
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
                End If
                If part = endSymbol Then
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

Function stringContains(ByVal theString As String, ByVal theChar As String) As Boolean
    'determine if a string contains a substring...
    
    '======================================================================================
    'Re-written by KSNiloc
    '======================================================================================
    If InStr(1, theString, theChar, vbTextCompare) > 0 Then
        stringContains = True
    Else
        stringContains = False
    End If
    
End Function

Function ValueNumber(ByVal Text$) As Long
'Gets numver of values in a variable expression
    On Error GoTo errorhandler
    Dim ignoreNext As Long, Length As Long, ele As Long, p As Long, part As String
    
    ignoreNext = 0
    Length = Len(Text$)
    ele = 1
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = chr$(34) Then
            If ignoreNext = 1 Then
                ignoreNext = 0
            Else
                ignoreNext = 1
            End If
        End If
        If part$ = "=" Or part$ = "+" Or part$ = "-" Or part$ = "/" Or part$ = "*" Then
            If ignoreNext = 0 Then ele = ele + 1
        End If
    Next p
    ValueNumber = ele

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function removeChar(ByVal Text As String, ByVal char As String) As String
'remove char from text
    On Error GoTo errorhandler
    Dim Length As Long, p As Long, part As String, ret As String
    
    Length = Len(Text$)
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ <> char$ Then ret$ = ret$ + part$
    Next p
    removeChar = ret$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function GetElement(ByVal Text$, ByVal eleeNum As Long) As String
    'gets element number from struing
    On Error GoTo errorhandler
    Dim Length As Long, element As Long, part As String, ignore As Long, returnVal As String, p As Long
    
    Length = Len(Text$)
    element = 0
    For p = 1 To Length + 1
        part$ = Mid$(Text$, p, 1)
        If part$ = chr$(34) Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
        End If
        If part$ = "," Or part$ = ";" Or part$ = "" Then
            If ignore = 0 Then
                element = element + 1
                If element = eleeNum Then
                    GetElement = returnVal$
                    Exit Function
                Else
                    returnVal$ = ""
                End If
            Else
                returnVal$ = returnVal$ + part$
            End If
        Else
            returnVal$ = returnVal$ + part$
        End If
    Next p

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Public Function CountData(ByVal Text As String) As Long
    'Counts data elements in text
    'Elements are seperated by ,'s or ;'s
    'On Error GoTo errorhandler
       
    '======================================================================================
    'Re-written by KSNiloc
    '======================================================================================

    On Error Resume Next

    Dim gB As String
    gB = GetBrackets(Text, True)
    If gB = "" Then Exit Function

    Dim c(1) As String
    c(0) = ","
    c(1) = ";"

    Dim S() As String
    Dim ud() As String
    S() = multiSplit(Text, c, ud, True)

    CountData = UBound(S) + 1
    
End Function

Function LocateBrackets(ByVal Text As String) As Long
    'returns position of first bracket/space after the RPGCode
    'Command.
    On Error GoTo errorhandler
    
    Dim Length As Long, p As Long, part As String, posat As Long
    
    'First look for brackets--make it easy:
    Length = Len(Text$)
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = "(" Then posat = p: p = Length
    Next p
    If posat <> 0 Then LocateBrackets = posat: Exit Function

    'OK- no brackets.  Find position of first space after command.
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = "#" Then posat = p: p = Length
    Next p
    If posat = 0 Then LocateBrackets = 0: Exit Function 'couldn't find a command!
    For p = posat To Length     'Find first occurrence of command name
        part$ = Mid$(Text$, p, 1)
        If part$ <> " " Then posat = p: p = Length
    Next p
    For p = posat To Length     'Find where command name ends.
        part$ = Mid$(Text$, p, 1)
        If part$ = " " Then posat = p: p = Length
    Next p
    LocateBrackets = posat: Exit Function

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Public Function GetBrackets(ByVal Text As String, Optional ByVal doNotCheckForBrackets As Boolean) As String
    'Takes a command and gets all the data that occurs after
    'The command itself (what's in the brackets).
    On Error GoTo errorhandler
    Dim ignoreClosing As Boolean
    Dim use As String, location As Long, Length As Long, bracketDepth As Long, p As Long, part As String
    Dim fullUse As String
    
    use$ = Text$
    location = LocateBrackets(use$)
    Length = Len(Text$)
    
    ' ! ADDED BY KSNiloc...
    If Not doNotCheckForBrackets Then
        If Not stringContains(Text, "(") Then
            If Not stringContains(Text, ")") Then
                'No (s or )s here!
                Exit Function
            End If
        End If
    End If

    bracketDepth = 0
    ignoreClosing = False
    For p = location + 1 To Length
        part$ = Mid$(Text$, p, 1)
        If ((part$ = ")") And ignoreClosing = False And bracketDepth <= 0) Or part$ = "" Then
            Exit For
        Else
            If part$ = ")" Then
                bracketDepth = bracketDepth - 1
            End If
            If part$ = chr$(34) Then
                'quote-- ignore stuff inside quotes.
                If ignoreClosing = True Then
                    'clsing quote...
                    ignoreClosing = False
                Else
                    ignoreClosing = True
                End If
            End If
            If part = "(" Then
                bracketDepth = bracketDepth + 1
            End If
            fullUse$ = fullUse$ + part$
        End If
    Next p
    GetBrackets = fullUse$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function GetCommandName$( _
                            ByVal splice As String, _
                            ByRef thePrg As RPGCodeProgram _
                                                             )
    'Goes through a command cline$ and returns what type of command it
    'is (the prefix, without the #).
    'It returns MBOX for message box, LABEL for label and VAR for variable!
    'Returns OPENBLOCK for block opening, CLOSEBLOCK for block closing
    'If autocommand for the program is on, then you don't need #
    On Error GoTo errorhandler
       
    If splice$ = "" Then GetCommandName$ = "": Exit Function
    
    Dim Length As Long, foundIt As Long, p As Long, part As String, starting As Long, commandName As String
    Dim testIt As String
    
    Length = Len(splice$)
    'Look for #
    foundIt = 0
    For p = 1 To Length
        part$ = Mid$(splice$, p, 1)
        If part$ <> " " And part$ <> "#" And part$ <> chr$(9) Then
            If thePrg.autoCommand Then
                If part$ = "*" Then
                    GetCommandName = "*"
                    Exit Function
                End If
                
                If part$ = ":" Then
                    GetCommandName = "LABEL"
                    Exit Function
                End If
                
                If part$ = "@" Then
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
        End If
        If part$ = "#" Then
            starting = p
            foundIt = p
            Exit For
        End If
    Next p
    If foundIt = 0 Then
        'Yipes- didn't find a #.  Maybe it's a @ command
        For p = 1 To Length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> "@" And part$ <> chr$(9) Then
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
                If part$ <> " " And part$ <> "*" And part$ <> chr$(9) Then foundIt = 0: p = Length
                If part$ = "*" Then GetCommandName$ = "*": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe a label
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ":" And part$ <> chr$(9) Then foundIt = 0: p = Length
                If part$ = ":" Then GetCommandName$ = "LABEL": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> "<" And part$ <> "{" And part$ <> chr$(9) Then foundIt = 0: p = Length
                If part$ = "<" Or part$ = "{" Then GetCommandName$ = "OPENBLOCK": Exit Function
            Next p
        End If
        If foundIt = 0 Then
            'Maybe an if then start/stop
            For p = 1 To Length
                part$ = Mid$(splice$, p, 1)
                If part$ <> " " And part$ <> ">" And part$ <> "}" And part$ <> chr$(9) Then foundIt = 0: p = Length
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
    
    GetCommandName$ = commandName$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Public Function GetParameters(ByVal Text As String, ByRef theProgram As RPGCodeProgram) As Parameters()

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/28/04]
 
 '''''''''
 'Purpose'
 '''''''''
 'Gets the parameters of an RPGCode command
 
 ''''''''
 'Return'
 ''''''''
 'An array of the parameters
 
 ''''''''''''
 'Parameters'
 ''''''''''''
 'text is the FULL COMMAND LINE of the command

 On Error Resume Next

 'Declarations...
 Dim ret() As Parameters
 Dim count As Long
 Dim brackets As String
 Dim a As Long
 Dim lit As String
 Dim num As Double
 Dim dataType As dtType
 
 'Get the parameters...
 count = CountData(Text)
 brackets = GetBrackets(Text)
 For a = 1 To count
  dataType = GetValue(GetElement(brackets, a), lit, num, theProgram)
  ReDim Preserve ret(a - 1)
  Select Case dataType
   Case dtLit
    ret(a - 1).dataType = dtLit
    ret(a - 1).lit = lit
   Case dtNum
    ret(a - 1).dataType = dtNum
    ret(a - 1).num = num
  End Select
  ret(a - 1).dat = GetElement(brackets, a)
 Next a

 'Pass back the data...
 GetParameters = ret()

End Function

Public Function GetWithPrefix() As String

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[6/18/04]

 '''''''''
 'Purpose'
 '''''''''
 'Returns the contents of the 'With Stack' ready to attach
 'to the beginning of each line in a 'With' structure.

 On Error Resume Next
 If inWith(0) = "" Then Exit Function
 Dim a As Long
 For a = 0 To UBound(inWith)
  GetWithPrefix = GetWithPrefix & inWith(a)
  'If Not a = UBound(inWith) Then GetWithPrefix = GetWithPrefix & "."
 Next a

End Function

Public Function ParseRPGCodeCommand( _
                                       ByVal line As String, _
                                       ByRef prg As RPGCodeProgram _
                                                                     ) As String

    '=========================================================================
    'Added by KSNiloc
    '=========================================================================

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
 
    Dim bl As Long
    Dim bT As String
    bl = LocateBrackets(line)
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

                                Case " ", ",", "#", "=", "<", ">", "+", "-"

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

Public Function replaceOutsideQuotes(ByVal Text As String, ByVal find As String, ByVal replace As String)

    ' Added by KSNiloc...

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
