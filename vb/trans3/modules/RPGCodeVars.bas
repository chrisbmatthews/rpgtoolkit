Attribute VB_Name = "RPGCodeVars"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: variables
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================
Public bRPGCStarted As Boolean             'has rpgcode been initiated?
Public globalHeap As Long                  'the ID of the global heap

'=========================================================================
' Declarations for the actkrt3.dll variable exports
'=========================================================================
Public Declare Function RPGCInit Lib "actkrt3.dll" () As Long
Public Declare Function RPGCShutdown Lib "actkrt3.dll" () As Long
Public Declare Function RPGCCreateHeap Lib "actkrt3.dll" () As Long
Public Declare Function RPGCDestroyHeap Lib "actkrt3.dll" (ByVal heapID As Long) As Long
Public Declare Function RPGCSetNumVar Lib "actkrt3.dll" (ByVal varname As String, ByVal value As Double, ByVal heapID As Long) As Long
Public Declare Function RPGCSetLitVar Lib "actkrt3.dll" (ByVal varname As String, ByVal value As String, ByVal heapID As Long) As Long
Public Declare Function RPGCGetNumVar Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Double
Public Declare Function RPGCGetLitVar Lib "actkrt3.dll" (ByVal varname As String, ByVal inSpaceAllocated As String, ByVal heapID As Long) As Long
Public Declare Function RPGCGetLitVarLen Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Long
Public Declare Function RPGCCountNum Lib "actkrt3.dll" (ByVal heapID As Long) As Long
Public Declare Function RPGCCountLit Lib "actkrt3.dll" (ByVal heapID As Long) As Long
Public Declare Function RPGCGetNumName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String, ByVal heapID As Long) As Long
Public Declare Function RPGCGetLitName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String, ByVal heapID As Long) As Long
Public Declare Function RPGCClearAll Lib "actkrt3.dll" (ByVal heapID As Long) As Long
Public Declare Function RPGCKillNum Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Long
Public Declare Function RPGCKillLit Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Long
Public Declare Function RPGCNumExists Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Long
Public Declare Function RPGCLitExists Lib "actkrt3.dll" (ByVal varname As String, ByVal heapID As Long) As Long

'=========================================================================
' Declarations for the actkrt3.dll redirection exports
'=========================================================================
Public Declare Function RPGCSetRedirect Lib "actkrt3.dll" (ByVal methodOrig As String, ByVal methodTarget As String) As Long
Public Declare Function RPGCRedirectExists Lib "actkrt3.dll" (ByVal methodToCheck As String) As Long
Public Declare Function RPGCGetRedirect Lib "actkrt3.dll" (ByVal methodToGet As String, ByVal pstrToVal As String) As Long
Public Declare Function RPGCKillRedirect Lib "actkrt3.dll" (ByVal pstrMethod As String) As Long
Public Declare Function RPGCGetRedirectName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String) As Long
Public Declare Function RPGCClearRedirects Lib "actkrt3.dll" () As Long
Public Declare Function RPGCCountRedirects Lib "actkrt3.dll" () As Long

'=========================================================================
' Detect if something is an operator
'=========================================================================
Private Function isOperator(ByVal test As String) As Boolean
    isOperator = True
    Select Case test
        Case "-", "+", "*", "/", "^"
        Case "%", "&", "|", "`" '[Faero]
        Case Else: isOperator = False
    End Select
End Function

'=========================================================================
' Detect if something is a number
'=========================================================================
Private Function isNumber(ByVal num As String) As Boolean
    On Error GoTo error
    Dim ret As Double
    If (isOperator(Right(num, 1))) Then Exit Function
    ret = CDbl(num)
    isNumber = True
error:
End Function

'=========================================================================
' Evaluate an equation (Asimir & KSNiloc)
'=========================================================================
Private Function evaluate(ByVal Text As String) As Double

    On Error Resume Next

    Const BOR_SIGN = 0              '[Faero] Binary or
    Const BAND_SIGN = 1             '[Faero] Binary and
    Const BXOR_SIGN = 2             '[Faero] Binary xor
    
    Const BSL_SIGN = 3              '[Faero] Bitshift left
    Const BSR_SIGN = 4              '[Faero] Bitshift right

    Const NEG_SIGN = 5              '- sign
    Const PLUS_SIGN = 6             '+ sign
    
    Const MOD_SIGN = 7              '[Faero] Modulus
    
    Const MULTIPLY_SIGN = 8         '* sign
    Const DIV_SIGN = 9              '/ sign
    Const RAISE_SIGN = 10            '^ sign

    Dim idx As Long                 'Current character
    Dim char As String              'A character
    Dim num As String               'A number
    Dim depth As Long               'Depth in brackets
    Dim tokenIdx As Long            'Current token
    Dim operatorIdx As Long         'Current operator
    Dim toSolve As Long             'Idx to solve
    Dim solveVal As Long            'Value of that idx
    Dim isValid As Boolean          'Is a valid number?

    ReDim tokens(0) As Double       'Tokens in the string
    ReDim operators(0) As Long      'Operators in the string
    ReDim brackets(0) As Long       'Bracket counts at operators
    
    Dim twoChars As String

    'Set indexes to -1
    tokenIdx = -1
    operatorIdx = -1

    'Eat spaces, replace "(-" with "(-1*", and encase string in ()s
    Text = replace(replace(replace("(" & Text & ")", vbTab, ""), " ", ""), "(-", "(-1*")

    'Loop over each character
    For idx = 1 To Len(Text)

        'Grab a character
        char = Mid(Text, idx, 1)
        
        'Grab two
        twoChars = Mid(Text, idx, 2)

        'Set valid flag to false
        isValid = False

        'If we haven't started a number yet, and it's a ".",
        'change it to a "0."
        If ((num = "") And (char = ".")) Then char = "0."

        'If char is -, and we don't have a number, then check the
        'next char, to see if it will form a number
        If ((num = "") And (char = "-")) Then
            'See if adding it to the next character will make
            'a valid number
            isValid = ( _
                          isNumber(char & Mid(Text, idx + 1, 1)) And _
                          (Mid(Text, idx - 1, 1) <> ")") _
                                                           )
        Else
            'Else, check if adding this character to the current
            'number would produce a valid number
            isValid = (isNumber(num & char))
        End If

        'If either of those two tests passed, then add it to the
        'string for the current number
        If (isValid) Then
            'It would, so add it on
            num = num & char
            If (char = "-") Then
                'If it was a negative sign, then remove it
                Text = Mid(Text, 1, idx - 1) & "0" & Mid(Text, idx + 1)
            End If
        Else
            'If we have a number, then we've reached its end
            If (num <> "") Then
                'Record the token
                tokenIdx = tokenIdx + 1
                ReDim Preserve tokens(tokenIdx)
                tokens(tokenIdx) = CDbl(num)
                'Set running num to nothing
                num = ""
            End If
            'Try other things
            If (char = "(") Then            'Opening Bracket
                                            '---------------
                'Getting deeper
                depth = depth + 1
            ElseIf (char = ")") Then        'Closing Bracket
                                            '---------------
                'Coming out
                depth = depth - 1
            ElseIf (isOperator(char)) Then  'Operator
                                            '--------
                'Record the operator
                operatorIdx = operatorIdx + 1
                ReDim Preserve operators(operatorIdx)
                Select Case char
                    Case "-": operators(operatorIdx) = NEG_SIGN
                    Case "+": operators(operatorIdx) = PLUS_SIGN
                    Case "/": operators(operatorIdx) = DIV_SIGN
                    Case "*": operators(operatorIdx) = MULTIPLY_SIGN
                    Case "^": operators(operatorIdx) = RAISE_SIGN
                    
                    Case "|": operators(operatorIdx) = BOR_SIGN  '[Faero] Binary or
                    Case "&": operators(operatorIdx) = BAND_SIGN '[Faero] Binary and
                    Case "`": operators(operatorIdx) = BXOR_SIGN '[Faero] Binary exclusive or
                    Case "%": operators(operatorIdx) = MOD_SIGN  '[Faero] Modulus
                End Select
                'Record the bracket depth
                ReDim Preserve brackets(operatorIdx)
                brackets(operatorIdx) = depth
            End If
        End If

    Next idx

    'Before we try and solve this equation, let's make sure all's good
    If ((depth <> 0) Or ((operatorIdx + 1) <> tokenIdx)) Then
        'Error out
        evaluate = -1
        Exit Function
    End If

    'Now solve this sucker, based on operator precedurence
    Do Until (UBound(tokens) = 0)
        toSolve = -1
        solveVal = -1
        For idx = 0 To UBound(operators)
            If ((brackets(idx) * 5 + operators(idx)) > solveVal) Then
                'This one has the highest precedurence yet
                solveVal = brackets(idx) * 5 + operators(idx)
                toSolve = idx
            End If
        Next idx
        'Now we know which token to solve, so let's make it happen
        Select Case operators(toSolve)
            Case PLUS_SIGN: tokens(toSolve) = tokens(toSolve) + tokens(toSolve + 1)
            Case NEG_SIGN: tokens(toSolve) = tokens(toSolve) - tokens(toSolve + 1)
            Case MULTIPLY_SIGN: tokens(toSolve) = tokens(toSolve) * tokens(toSolve + 1)
            Case DIV_SIGN: tokens(toSolve) = tokens(toSolve) / tokens(toSolve + 1)
            Case RAISE_SIGN: tokens(toSolve) = tokens(toSolve) ^ tokens(toSolve + 1)
            
            '[Faero] 3.0.5
            Case BSL_SIGN: tokens(toSolve) = tokens(toSolve) * (2 ^ tokens(toSolve + 1))
            Case BSR_SIGN: tokens(toSolve) = tokens(toSolve) / (2 ^ tokens(toSolve + 1))
            Case BOR_SIGN: tokens(toSolve) = tokens(toSolve) Or tokens(toSolve + 1)
            Case BAND_SIGN: tokens(toSolve) = tokens(toSolve) And tokens(toSolve + 1)
            Case BXOR_SIGN: tokens(toSolve) = tokens(toSolve) Xor tokens(toSolve + 1)
            Case MOD_SIGN: tokens(toSolve) = tokens(toSolve) Mod tokens(toSolve + 1)
        End Select
        'Knock the arrays back a notch
        For idx = toSolve To UBound(tokens)
            tokens(idx + 1) = tokens(idx + 2)
            brackets(idx) = brackets(idx + 1)
            operators(idx) = operators(idx + 1)
        Next idx
        ReDim Preserve tokens(UBound(tokens) - 1)
        ReDim Preserve brackets(UBound(brackets) - 1)
        ReDim Preserve operators(UBound(operators) - 1)
    Loop

    'Return the result
    evaluate = tokens(0)

End Function

'=========================================================================
' Get the value of a variable - unattached to a program
'=========================================================================
Public Function getIndependentVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double) As RPGC_DT
    Dim aProgram As RPGCodeProgram
    aProgram.boardNum = -1
    Call InitRPGCodeProcess(aProgram)
    getIndependentVariable = getVariable(varname$, lit$, num, aProgram)
    Call ClearRPGCodeProcess(aProgram)
End Function

'=========================================================================
' Clear all redirects
'=========================================================================
Public Sub clearRedirects()
    On Error Resume Next
    Call RPGCClearRedirects
End Sub

'=========================================================================
' Determines type of text passed in
'=========================================================================
Public Function dataType( _
                            ByVal Text As String, _
                            Optional ByRef equType As RPGC_DT = -1 _
                                                                     ) As RPGC_DT

    On Error Resume Next

    Dim Length As Long      'Length of text
    Dim dType As RPGC_DT    'Data type
    Dim p As Long           'Position
    Dim part As String      'Part of string
    Dim ret As Double       'Return from CDbl()
    Dim errors As Boolean   'Was there an error?

    Length = Len(Text)      'Get the text's length
    dType = -1              'Flag we haven't got a type yet

    'Check right most character for type character (! or $)
    If dType = -1 Then
        part = Right(Trim(replaceOutsideQuotes(Text, vbTab, "")), 1)
        If part = "$" Then
            dType = DT_LIT
        ElseIf part = "!" Then
            dType = DT_NUM
        End If
    End If

    'Haven't got it, resort to error handling
    If (dType = -1) Then

        'Setup error handling
        On Error GoTo dataTypeErr

        'Try to change the text to a double
        ret = CDbl(Text)

        If (errors) Then
            'If we got here, it's an error so it must be a string
            dType = DT_STRING
        Else
            'If here, it was successful meaning it's a number
            dType = DT_NUMBER
        End If

    End If

    'Before we leave, check if there is an equation
    Dim equResult As RPGC_DT
    If isEquation(Text, equResult) Then
        dType = DT_EQUATION
        If (equType = -1) Then
            dType = equResult
        Else
            equType = equResult
        End If
    End If

    'Return what we've found
    dataType = dType

    Exit Function

dataTypeErr:
    'Flag there was an error
    errors = True
    Resume Next

End Function

'=========================================================================
' Return the name of the method that handles calls to the method passed in
'=========================================================================
Public Function getRedirect(ByVal originalMethod As String) As String

    On Error Resume Next
    Dim Length As Long
    
    originalMethod = UCase$(replace(originalMethod, "#", ""))
    If redirectExists(originalMethod) Then
        Dim getStr As String * 4048
        Length = RPGCGetRedirect(originalMethod, getStr)
        If Length = 0 Then
            getRedirect = originalMethod
            Exit Function
        End If
        getRedirect = Mid$(getStr, 1, Length)
    Else
        getRedirect = ""
    End If

End Function

'=========================================================================
' Get the redirect at the index passed in
'=========================================================================
Public Function getRedirectName(ByVal Index As Long) As String

    On Error Resume Next
    
    Dim max As Long
    Dim Length As Long
    max = RPGCCountRedirects()
    If Index > max - 1 Or Index < 0 Then
        getRedirectName = ""
    Else
        Dim inBuf As String * 4024
        Length = RPGCGetRedirectName(Index, inBuf)
        getRedirectName = Mid$(inBuf, 1, Length)
    End If

End Function

'=========================================================================
' Delete the redirect referring to the method passed in
'=========================================================================
Public Sub killRedirect(ByVal methodName As String)
    On Error Resume Next
    methodName = UCase(replace(methodName, "#", ""))
    Call RPGCKillRedirect(methodName)
End Sub

'=========================================================================
' Determine if a redirect exists for the text passed in
'=========================================================================
Public Function redirectExists(ByVal methodToCheck As String) As Boolean
    On Error Resume Next
    Dim a As Long
    methodToCheck = replace(methodToCheck, "#", "")
    a = RPGCRedirectExists(UCase$(methodToCheck))
    If a = 1 Then
        redirectExists = True
    Else
        redirectExists = False
    End If
End Function

'=========================================================================
' Determines if the text passed in is an equation
'=========================================================================
Public Function isEquation( _
                              ByVal lineText As String, _
                              ByRef litOrNum As RPGC_DT _
                                                         ) As Boolean

    '======================================================================================
    ' lineText - text to test (in)
    ' litOrNum - literal or numerial equation (out)
    ' return - was it an equation? (out)
    '======================================================================================

    On Error Resume Next

    Dim parts() As String       'Parts of the equation
    Dim tSigns(9) As String     'Math signs array
    Dim uD() As String          'Delimiters that were used (dummy)
    Dim dt As Long              'Data type
    Dim a As Long               'Loop control variables

    litOrNum = DT_VOID
 
    'Make sure we were passed data...
    lineText = Trim(lineText)
    If lineText = "" Then Exit Function

    'Populate the tSigns() array...
    tSigns(0) = "+"
    tSigns(1) = "-"
    tSigns(2) = "/"
    tSigns(3) = "*"
    tSigns(4) = "^"
    tSigns(5) = "\"
    tSigns(6) = "|"
    tSigns(7) = "&"
    tSigns(8) = "`"
    tSigns(9) = "%"
    

    'Retrieve the text sans math signs...
    parts() = multiSplit(lineText, tSigns, uD, True)

    'If there's only one element we'll recurse to our DOOM!
    If UBound(parts) = 0 Then Exit Function
 
    dt = dataType(parts(0))
    Select Case dt
        Case 0, 3: dt = DT_NUM
        Case 1, 2: dt = DT_LIT
    End Select
 
    'Make sure all the elements are the same type...
    On Error GoTo wrongType
    For a = 1 To UBound(parts)
        Select Case dataType(parts(a))
            Case 0, 3: If (Not dt = DT_NUM) Then Error 0
            Case 1, 2: If (Not dt = DT_LIT) Then Error 0
        End Select
    Next a
 
    litOrNum = dt
 
    'If we made it here then it's an equation...
    isEquation = True

wrongType:
End Function

'=========================================================================
' Evaluates the equation passed in
'=========================================================================
Public Function RPGCodeEquation( _
                                   ByVal equ As String, _
                                   ByRef prg As RPGCodeProgram, _
                                   ByRef litOrNum As RPGC_DT _
                                                              ) As parameters

    '======================================================================================
    ' + Assumes that it is an equation
    '
    ' equ - the equation to evaluate (in)
    ' prg - the rpgcode program (in)
    ' litOrNum - literal or numerical (in, but may be modified)
    ' return - evaluated equation (out)
    '
    '======================================================================================

    On Error Resume Next

    With RPGCodeEquation
        .dataType = litOrNum
        Select Case .dataType
            Case DT_NUM
                'Numerical!
                .num = evaluate(equ)
            Case DT_LIT
                'Literal!
                Dim varIdx As Long, num As Double, dat As String
                For varIdx = 1 To ValueNumber(equ)
                    dat = GetVarList(equ, varIdx)
                    Call getValue(dat, dat, num, prg)
                    .lit = .lit & dat
                Next varIdx
        End Select
    End With

End Function

'=========================================================================
' RPGCode interface with variables
'=========================================================================
Public Sub variableManip(ByVal Text As String, ByRef theProgram As RPGCodeProgram)

    On Error Resume Next

    Dim Destination As String   'RPGCode destination variable
    Dim tokenIdx As Long        'Token index
    Dim dType As RPGC_DT        'Type of data
    Dim equal As String         'The conjunction
    Dim number As Long          'Number of tokens we have
    Dim lit As String           'Literal value
    Dim num As Double           'Numerical value

    'Get the destination variable and remove unwanted characters
    Destination = replace(replace(replace(GetVarList(Text, 1), "#", ""), " ", ""), vbTab, "")
    If (Right(Destination, 1) <> "!" And Right(Destination, 1) <> "$") Then
        Destination = Destination & "!"
    End If

    'Get the type of the destination
    dType = dataType(Destination)

    If (dType = DT_NUM) Then
        'If we have a numerical variable then add to
        'the string to evaluate (prevents some errors)
        Text = Text & " +0+0"
    End If

    'Get the number of tokens we have
    number = ValueNumber(Text)

    'Create an array to hold the tokens
    ReDim valueList(number) As String

    'For each token after the equal sign
    For tokenIdx = 2 To number

        'Get the token
        valueList(tokenIdx) = GetVarList(Text, tokenIdx)

        'Remove spaces if it's not a literal variable (has quotes)
        'If (Not InStr(valueList(tokenIdx), Chr(34))) Then
            'Remove those spaces
            'valueList(tokenIdx) = replace(valueList(tokenIdx), " ", "")
        'End If

    Next tokenIdx

    'Switch on the data type
    Select Case dType

        Case DT_NUM, DT_STRING  'NUMERICAL
                                '---------

            'Put all the tokens into an array
            ReDim numberUse(number) As Double
            For tokenIdx = 2 To number
                Call getValue(valueList(tokenIdx), lit, numberUse(tokenIdx), theProgram)
            Next tokenIdx

            'Check what type of conjuction we have
            equal = MathFunction(Text, 1)

            'Switch on the sign
            Select Case equal

                Case "++"                           'INCREMENTAION OPERATOR
                                                    '----------------------
                    Call SetVariable(Destination, CBGetNumerical(Destination) + 1, theProgram)
                    Exit Sub

                Case "--"                           'DECREMENTATION OPERATOR
                                                    '-----------------------
                    Call SetVariable(Destination, CBGetNumerical(Destination) - 1, theProgram)
                    Exit Sub

                Case "+=", "-=", "*=", "/=", "="    'OTHER VALID OPERATOR
                                                    '--------------------

                Case "|=", "&=", "`=", "%=" '[Faero] Other valid ops :)


                Case Else                           'INVALID OPERATOR
                                                    '----------------
                    Call debugger("Error: Invalid conjunction-- " & equal)
                    Exit Sub

            End Select

            'Build the equation into a string
            Dim build As String
            For tokenIdx = 2 To number
                build = build & numberUse(tokenIdx) & MathFunction(Text, tokenIdx)
            Next tokenIdx
            build = Mid(build, 1, Len(build) - 2)

            'Now actually evaluate the quation
            numberUse(number) = evaluate(build)

            'Switch on the equal sign
            Select Case equal

                Case "-="       'RELATIVE SUBTRACTION OPERATOR
                                '-----------------------------
                    Call SetVariable(Destination, CStr(CBGetNumerical(Destination) - numberUse(number)), theProgram)

                Case "+="       'RELATIVE ADDITION OPERATOR
                                '--------------------------
                    Call SetVariable(Destination, CStr(numberUse(number) + CBGetNumerical(Destination)), theProgram)

                Case "*="       'RELATIVE MULTIPLICATION OPERATOR
                                '--------------------------------
                    Call SetVariable(Destination, CStr(numberUse(number) * CBGetNumerical(Destination)), theProgram)

                Case "/="       'RELATIVE DIVISION OPERATOR
                                '--------------------------
                    Call SetVariable(Destination, CStr(CBGetNumerical(Destination) / numberUse(number)), theProgram)

                Case "="        'NORMAL EQUAL OPERATOR
                                '---------------------
                    Call SetVariable(Destination, CStr(numberUse(number)), theProgram)


                'Taken out because I don't feel like making trans3 read 2 char operators
                'Case "<<="      '[Faero] Bitshift left
                                '---------------------
                '    Call SetVariable(Destination, CStr(CBGetNumerical(Destination) * (2 ^ numberUse(number))), theProgram)

                'Case ">>="      '[Faero] Bitshift right
                                '---------------------
                '    Call debugger("bitshift right")
                '    Call SetVariable(Destination, CStr(CBGetNumerical(Destination) / (2 ^ numberUse(number))), theProgram)

                Case "|="      '[Faero] Or
                                '---------------------
                    'Call debugger("binary or")
                    Call SetVariable(Destination, CStr(numberUse(number) Or CBGetNumerical(Destination)), theProgram)

                Case "&="      '[Faero] And
                                '---------------------
                    Call SetVariable(Destination, CStr(numberUse(number) And CBGetNumerical(Destination)), theProgram)

                Case "`="      '[Faero] XOr
                                '---------------------
                    Call SetVariable(Destination, CStr(numberUse(number) Xor CBGetNumerical(Destination)), theProgram)

                Case "%="      '[Faero] Modulus
                                '---------------------
                    Call SetVariable(Destination, CStr(numberUse(number) Mod CBGetNumerical(Destination)), theProgram)

            End Select

        Case DT_LIT         'LITERAL
                            '-------

            'Get the tokens
            ReDim litUse(number) As String
            For tokenIdx = 2 To number
                Call getValue(Trim(valueList(tokenIdx)), litUse(tokenIdx), num, theProgram)
            Next tokenIdx

            'Get the equal sign
            equal = MathFunction(Text, 1)

            'Combine the tokens
            Dim res As String
            For tokenIdx = 2 To number
                res = res & litUse(tokenIdx)
            Next tokenIdx

            If equal = "+=" Then
                'Add result to existing value
                Call SetVariable(Destination, CBGetString(Destination) & res, theProgram)
            Else
                'Set destination to result
                Call SetVariable(Destination, res, theProgram)
            End If

        Case Else       'INVALID DESTINATION VARIABLE
                        '----------------------------
            Call debugger("Error: Value on left must be a valid variable-- " & Text)

    End Select

End Sub

'=========================================================================
' Gets the value of the text passed
'=========================================================================
Public Function getValue(ByVal Text As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As RPGC_DT

    On Error Resume Next

    Dim numA As Double      'Numerical value
    Dim litA As String      'Literal value
    Dim p As Long           'For loop control variable
    Dim Length As Long      'Length of text
    Dim part As String      'A character
    Dim checkIt As Boolean  'In quotes?
    Dim newPos As Long      'New position
    Dim sendText As String  'Text to return
    Dim equTyp As RPGC_DT   'Type of equation

    'Switch on the data type
    Select Case dataType(Text, equTyp)

        Case DT_NUM         'NUMERICAL VARIABLE
                            '------------------

            If getVariable(Text, litA, numA, theProgram) = DT_NUM Then
                'Found one!
                num = numA
            End If
            getValue = DT_NUM

        Case DT_LIT         'LITERAL VARIABLE
                            '----------------

            If getVariable(Text, litA, numA, theProgram) = DT_LIT Then
                'Found one!
                lit = litA
            End If
            getValue = DT_LIT

        Case DT_STRING      'STRING
                            '------

            'Get the length of the text
            Length = Len(Text)

            'Check if text is in quotes
            For p = 1 To Length
                If Mid(Text, p, 1) = Chr(34) Then
                    checkIt = True
                    Exit For
                End If
            Next p

            If (checkIt) Then
                'It is!
                For p = 1 To Length
                    If Mid(Text, p, 1) = Chr(34) Then
                        newPos = p
                        Exit For
                    End If
                Next p
                For p = (newPos + 1) To (Length)
                    part = Mid(Text, p, 1)
                    If (part = Chr(34)) Or (part = "") Then
                        lit = sendText
                        getValue = DT_LIT
                        Exit Function
                    Else
                        sendText = sendText & part
                    End If
                Next p
            Else
                'It's not!
                lit = Text
                getValue = DT_LIT
            End If

        Case DT_NUMBER      'NUMBER
                            '------

            num = CDbl(Text)
            getValue = DT_NUM

        Case DT_EQUATION    'EQUATION
                            '--------

            Dim equVal As parameters
            equVal = RPGCodeEquation(Text, theProgram, equTyp)
            With equVal
                Select Case .dataType
                    Case DT_NUM: num = .num
                    Case DT_LIT: lit = .lit
                End Select
                getValue = .dataType
            End With

    End Select

End Function

'=========================================================================
' Determine if a literal variable exists
'=========================================================================
Public Function litVarExists(ByVal varname As String, ByVal heapID As Long) As Boolean
    On Error Resume Next
    Dim r As Long
    If varname <> "" Then
        r = RPGCLitExists(UCase$(varname), heapID)
        If r = 1 Then
            litVarExists = True
        Else
            litVarExists = False
        End If
    Else
        litVarExists = False
    End If
End Function

'=========================================================================
' Kill a literal variable
'=========================================================================
Public Sub KillLit(ByVal varname As String, ByVal heapID As Long)
    On Error Resume Next
    Call RPGCKillLit(UCase$(varname), heapID)
End Sub

'=========================================================================
' Kill all variables
'=========================================================================
Public Sub clearVars(ByVal heapID As Long)
    On Error Resume Next
    Call RPGCClearAll(heapID)
End Sub

'=========================================================================
' Get the numerical variable at the index passed in
'=========================================================================
Public Function GetNumName(ByVal Index As Integer, ByVal heapID As Long) As String
    On Error Resume Next
    
    Dim max As Long, Length As Long
    max = RPGCCountNum(heapID)
    If Index > max - 1 Or Index < 0 Then
        GetNumName = ""
    Else
        Dim inBuf As String * 4024
        Length = RPGCGetNumName(Index, inBuf, heapID)
        GetNumName = Mid$(inBuf, 1, Length)
    End If
End Function

'=========================================================================
' Get the literal variable at the index passed in
'=========================================================================
Public Function GetLitName(ByVal Index As Integer, ByVal heapID As Long) As String
    On Error Resume Next
    
    Dim max As Long, Length As Long
    max = RPGCCountLit(heapID)
    If Index > max - 1 Or Index < 0 Then
        GetLitName = ""
    Else
        Dim inBuf As String * 4024
        Length = RPGCGetLitName(Index, inBuf, heapID)
        GetLitName = Mid$(inBuf, 1, Length)
    End If
End Function

'=========================================================================
' Kill the numerical variable passed in
'=========================================================================
Public Sub killNum(ByVal varname As String, ByVal heapID As Long)
    On Error Resume Next
    Call RPGCKillNum(UCase$(varname), heapID)
End Sub

'=========================================================================
' Determine if a numerical variable exists
'=========================================================================
Public Function numVarExists(ByVal varname As String, ByVal heapID As Long) As Boolean
    On Error Resume Next
    Dim r As Long
    If varname <> "" Then
        r = RPGCNumExists(UCase$(varname), heapID)
        If r = 1 Then
            numVarExists = True
        Else
            numVarExists = False
        End If
    Else
        numVarExists = False
    End If
End Function

'=========================================================================
' Return a numerical variable belonging to a program's value
'=========================================================================
Public Function SearchNumVar(ByVal varname As String, ByRef thePrg As RPGCodeProgram) As Double
    On Error Resume Next
    'first search the local heap...
    If thePrg.currentHeapFrame >= 0 Then
        If numVarExists(varname, thePrg.heapStack(thePrg.currentHeapFrame)) Then
            'try local heap...
            SearchNumVar = GetNumVar(varname, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            'try global heap...
            SearchNumVar = GetNumVar(varname, globalHeap)
        End If
    Else
        'obtain from global heap...
        SearchNumVar = GetNumVar(varname, globalHeap)
    End If
End Function

'=========================================================================
' Return a literal variable belonging to a program's value
'=========================================================================
Public Function SearchLitVar(ByVal varname As String, ByRef thePrg As RPGCodeProgram) As String
    On Error Resume Next
    'first search the local heap...
    If thePrg.currentHeapFrame >= 0 Then
        If litVarExists(varname, thePrg.heapStack(thePrg.currentHeapFrame)) Then
            'try local heap...
            SearchLitVar = GetLitVar(varname, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            'try global heap...
            SearchLitVar = GetLitVar(varname, globalHeap)
        End If
    Else
        'obtain from global heap...
        SearchLitVar = GetLitVar(varname, globalHeap)
    End If
End Function

'=========================================================================
' Create a redirect
'=========================================================================
Public Sub SetRedirect(ByVal originalMethod As String, ByVal targetMethod As String)
    'add to redirect list
    On Error Resume Next
    originalMethod = replace(originalMethod, "#", "")
    targetMethod = replace(targetMethod, "#", "")
    Call RPGCSetRedirect(UCase$(originalMethod), UCase$(targetMethod))
End Sub

'=========================================================================
' Return the type of a variable
'=========================================================================
Public Function variType(ByVal var As String, ByVal heapID As Long) As Long

    On Error Resume Next
    
    Dim a As String, Length As Long, pos As Long, typeIt As Long, part As String
    a$ = var$
    Length = Len(a$)
    For pos = 1 To Length
        part$ = Mid$(a$, pos, 1)
        If part$ = "$" Then typeIt = 1
        If part$ = "!" Then typeIt = 2
    Next pos
    If typeIt = 0 Then
        'If we didn't find out what type it was, we have to
        'search the records to see
        'LITERAL:
        If litVarExists(a$, heapID) Then
            typeIt = 1
        End If
        If numVarExists(a$, heapID) Then
            typeIt = 2
        End If
    End If
    
    If typeIt = 1 Then variType = 1
    If typeIt = 2 Then variType = 0
    If typeIt = 0 Then variType = -1

End Function

'=========================================================================
' Set a variable - unattached to a program
'=========================================================================
Public Sub setIndependentVariable(ByVal varname As String, ByVal value As String)
    On Error Resume Next
    Dim aProgram As RPGCodeProgram
    aProgram.boardNum = -1
    Call InitRPGCodeProcess(aProgram)
    Call SetVariable(varname$, value$, aProgram)
    Call ClearRPGCodeProcess(aProgram)
End Sub

'=========================================================================
' Set a variable optionally forced to the global heap
'=========================================================================
Public Sub SetVariable(ByVal varname As String, ByVal value As String, ByRef theProgram As RPGCodeProgram, Optional ByVal bForceGlobal As Boolean = False)

    On Error Resume Next

    'Get the variable's name
    Dim theVar As String
    theVar = parseArray(replace(varname, " ", ""), theProgram)

    'Check if it belongs to a class
    If (theProgram.classes.insideClass) Then
        If (isVarMember(varname, topNestle(theProgram), theProgram)) Then
            theVar = getObjectVarName(theVar, topNestle(theProgram))
        End If
    End If

    'Get its type
    Dim varType As RPGC_DT
    varType = variType(theVar, globalHeap)

    'Create an rpgcode return value
    Dim rV As RPGCODE_RETURN

    If varType = DT_NUM Then        'NUMERICAL VARIABLE
                                    '------------------

        If (theProgram.autoLocal) Then
            If (Not numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                Call LocalRPG("Local(" & theVar & ")", theProgram, rV)
            End If
        End If

        If (theProgram.currentHeapFrame >= 0) And (Not bForceGlobal) Then
            If numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame)) Then
                'Local
                Call SetNumVar(theVar, CDbl(value), theProgram.heapStack(theProgram.currentHeapFrame))
            Else
                'Global
                Call SetNumVar(theVar, CDbl(value), globalHeap)
            End If
        Else
            'Global
            Call SetNumVar(theVar, CDbl(value), globalHeap)
        End If

    ElseIf varType = DT_LIT Then    'LITERAL VARIABLE
                                    '----------------

        If (theProgram.autoLocal) Then
            If (Not litVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                Call LocalRPG("Local(" & theVar & ")", theProgram, rV)
            End If
        End If

        If (theProgram.currentHeapFrame >= 0) And (Not bForceGlobal) Then
            If litVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame)) Then
                'Local
                Call SetLitVar(theVar, value, theProgram.heapStack(theProgram.currentHeapFrame))
            Else
                'Global
                Call SetLitVar(theVar, value, globalHeap)
            End If
        Else
            'Global
            Call SetLitVar(theVar, value, globalHeap)
        End If

    End If

End Sub

'=========================================================================
' Get the value of a variable
'=========================================================================
Public Function getVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As RPGC_DT

    On Error Resume Next

    'Check for reserved dynamically updating variables
    Select Case Trim(LCase(varname))

        Case "gametime!"            'LENGTH OF GAME IN SECONDS
                                    '-------------------------
            Call updateGameTime
            num = gameTime
            getVariable = DT_NUM
            Exit Function
            
        Case "cnvrendernow!"        'HANDLE TO THE RENDER NOW CANVAS
                                    '-------------------------------
            num = cnvRenderNow
            getVariable = DT_NUM
            Exit Function

    End Select

    'Get the variable
    Dim theVar As String
    theVar = parseArray(replace(varname, " ", ""), theProgram)

    'Check if it belongs to a class
    If (theProgram.classes.insideClass) Then
        If (isVarMember(varname, topNestle(theProgram), theProgram)) Then
            theVar = getObjectVarName(theVar, topNestle(theProgram))
        End If
    End If

    'Create an rpgcode return value
    Dim rV As RPGCODE_RETURN

    'Get the var's type
    Dim varType As RPGC_DT
    varType = variType(theVar, globalHeap)
    getVariable = varType

    If varType = DT_VOID Then
        'If there was an error, just exit this function
        Exit Function
    End If

    If varType = DT_NUM Then        'NUMERICAL VARIABLE
                                    '------------------

        If (theProgram.autoLocal) Then
            If (Not numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                Call LocalRPG("Local(" & theVar & ")", theProgram, rV)
            End If
        End If

        num = SearchNumVar(theVar, theProgram)

    ElseIf varType = DT_LIT Then    'LITERAL VARIABLE
                                    '----------------

        If (theProgram.autoLocal) Then
            If (Not litVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                Call LocalRPG("Local(" & theVar & ")", theProgram, rV)
            End If
        End If

        lit = SearchLitVar(theVar, theProgram)

    End If

End Function

'=========================================================================
' Initiate the variable system (probably redundant)
'=========================================================================
Public Function initVarSystem() As Boolean

    On Error GoTo anErr
    
    Call RPGCInit

    bRPGCStarted = True
    initVarSystem = bRPGCStarted
    globalHeap = RPGCCreateHeap()
    Call initRPGCodeClasses

    Exit Function
    
anErr:
    bRPGCStarted = False
    initVarSystem = bRPGCStarted
    Call MsgBox("Cannot initialize heap system-- get the latest actkrt3.dll")
    gGameState = GS_QUIT
End Function

'=========================================================================
' Shutdown the variable system
'=========================================================================
Public Sub ShutdownVarSystem()
    On Error Resume Next
    Call RPGCShutdown
End Sub

'=========================================================================
' Set a numerical variable
'=========================================================================
Public Function SetNumVar(ByVal varname As String, ByVal val As Double, ByVal heapID As Long) As Long
    On Error Resume Next
    SetNumVar = RPGCSetNumVar(UCase$(varname), val, heapID)
End Function

'=========================================================================
' Set a literal variable
'=========================================================================
Public Function SetLitVar(ByVal varname As String, ByVal val As String, ByVal heapID As Long) As Long
    On Error Resume Next
    SetLitVar = RPGCSetLitVar(UCase$(varname), val, heapID)
End Function

'=========================================================================
' Get a numerical variable
'=========================================================================
Public Function GetNumVar(ByVal varname As String, ByVal heapID As Long) As Double
    On Error Resume Next
    GetNumVar = RPGCGetNumVar(UCase$(varname), heapID)
End Function

'=========================================================================
' Get a literal variable
'=========================================================================
Public Function GetLitVar(ByVal varname As String, ByVal heapID As Long) As String
    On Error Resume Next
    Dim l As Long, Length As Long
    
    l = RPGCGetLitVarLen(UCase$(varname), heapID)
    If l > 0 Then
        l = l + 1
        Dim getStr As String * 4048
        Length = RPGCGetLitVar(UCase$(varname), getStr, heapID)
        GetLitVar = Mid$(getStr, 1, Length)
    Else
        GetLitVar = ""
    End If
End Function
