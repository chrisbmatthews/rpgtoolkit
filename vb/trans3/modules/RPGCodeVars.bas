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
Public bRPGCStarted As Boolean             ' Has rpgcode been initiated?
Public globalHeap As Long                  ' The ID of the global heap

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
        Case "-", "+", "*", "/", "^", "%", "&", "|", "`"
        Case Else
            ' It's not an operator
            isOperator = False
    End Select
End Function

'=========================================================================
' Detect if something is a number
'=========================================================================
Private Function isNumber(ByVal num As String) As Boolean
    On Error GoTo error
    Dim ret As Double
    If (isOperator(Right$(num, 1))) Then Exit Function
    ret = CDbl(num)
    isNumber = True
error:
End Function

'=========================================================================
' Evaluate an equation (Asimir & KSNiloc)
'=========================================================================
Private Function evaluate(ByVal Text As String) As Double

    On Error Resume Next

    Const BOR_SIGN = 0              ' Binary or
    Const BAND_SIGN = 1             ' Binary and
    Const BXOR_SIGN = 2             ' Binary xor
    Const BSL_SIGN = 3              ' Bitshift left
    Const BSR_SIGN = 4              ' Bitshift right
    Const NEG_SIGN = 5              ' - sign
    Const PLUS_SIGN = 6             ' + sign
    Const MOD_SIGN = 7              ' Modulus
    Const MULTIPLY_SIGN = 8         ' * sign
    Const DIV_SIGN = 9              ' / sign
    Const RAISE_SIGN = 10             '^ sign

    Dim idx As Long                 ' Current character
    Dim char As String              ' A character
    Dim num As String               ' A number
    Dim depth As Long               ' Depth in brackets
    Dim tokenIdx As Long            ' Current token
    Dim operatorIdx As Long         ' Current operator
    Dim toSolve As Long             ' Idx to solve
    Dim solveVal As Long            ' Value of that idx
    Dim isValid As Boolean          ' Is a valid number?

    ReDim tokens(0) As Double       ' Tokens in the string
    ReDim operators(0) As Long      ' Operators in the string
    ReDim brackets(0) As Long       ' Bracket counts at operators

    ' Set indexes to -1
    tokenIdx = -1
    operatorIdx = -1

    ' Eat spaces, replace "(-" with "(-1*", and encase string in ()s
    Text = replace(replace(replace("(" & Text & ")", vbTab, ""), " ", ""), "(-", "(-1*")

    ' Loop over each character
    For idx = 1 To Len(Text)

        ' Grab a character
        char = Mid$(Text, idx, 1)

        ' Set valid flag to false
        isValid = False

        ' If we haven't started a number yet, and it's a ".",
        ' change it to a "0."
        If ((LenB(num) = 0) And (char = ".")) Then char = "0."

        ' If char is "-" and we don't have a number then check the
        ' next char to see if it will form a number
        If ((LenB(num) = 0) And (char = "-")) Then
            ' See if adding it to the next character will make
            ' a valid number
            isValid = ( _
                          isNumber(char & Mid$(Text, idx + 1, 1)) And _
                          (Mid$(Text, idx - 1, 1) <> ")") _
                                                           )
        Else
            ' Else, check if adding this character to the current
            ' number would produce a valid number
            isValid = (isNumber(num & char))
        End If

        ' If either of those two tests passed then add it to the
        ' string for the current number
        If (isValid) Then
            ' It would, so add it on
            num = num & char
            If (char = "-") Then
                ' If it was a negative sign, then remove it
                Text = Mid$(Text, 1, idx - 1) & "0" & Mid$(Text, idx + 1)
            End If
        Else
            ' If we have a number, then we've reached its end
            If (LenB(num) <> 0) Then
                ' Record the token
                tokenIdx = tokenIdx + 1
                ReDim Preserve tokens(tokenIdx)
                tokens(tokenIdx) = CDbl(num)
                ' Set running num to nothing
                num = vbNullString
            End If
            ' Try other things
            If (char = "(") Then            'Opening Bracket
                                            '---------------
                ' Getting deeper
                depth = depth + 1
            ElseIf (char = ")") Then        'Closing Bracket
                                            '---------------
                ' Coming out
                depth = depth - 1
            ElseIf (isOperator(char)) Then  'Operator
                                            '--------
                ' Record the operator
                operatorIdx = operatorIdx + 1
                ReDim Preserve operators(operatorIdx)
                Select Case char
                    Case "-": operators(operatorIdx) = NEG_SIGN
                    Case "+": operators(operatorIdx) = PLUS_SIGN
                    Case "/": operators(operatorIdx) = DIV_SIGN
                    Case "*": operators(operatorIdx) = MULTIPLY_SIGN
                    Case "^": operators(operatorIdx) = RAISE_SIGN
                    Case "|": operators(operatorIdx) = BOR_SIGN
                    Case "&": operators(operatorIdx) = BAND_SIGN
                    Case "`": operators(operatorIdx) = BXOR_SIGN
                    Case "%": operators(operatorIdx) = MOD_SIGN
                End Select
                ' Record the bracket depth
                ReDim Preserve brackets(operatorIdx)
                brackets(operatorIdx) = depth
            End If
        End If

    Next idx

    ' Before we try and solve this equation, let's make sure all's good
    If ((depth <> 0) Or ((operatorIdx + 1) <> tokenIdx)) Then
        ' Error out
        evaluate = -1
        Exit Function
    End If

    ' Now solve this sucker, based on operator precedurence
    Do Until (UBound(tokens) = 0)
        toSolve = -1
        solveVal = -1
        For idx = 0 To UBound(operators)
            If ((brackets(idx) * 5 + operators(idx)) > solveVal) Then
                ' This one has the highest precedurence yet
                solveVal = brackets(idx) * 5 + operators(idx)
                toSolve = idx
            End If
        Next idx
        ' Now we know which token to solve, so let's make it happen
        Select Case operators(toSolve)
            Case PLUS_SIGN: tokens(toSolve) = tokens(toSolve) + tokens(toSolve + 1)
            Case NEG_SIGN: tokens(toSolve) = tokens(toSolve) - tokens(toSolve + 1)
            Case MULTIPLY_SIGN: tokens(toSolve) = tokens(toSolve) * tokens(toSolve + 1)
            Case DIV_SIGN: tokens(toSolve) = tokens(toSolve) / tokens(toSolve + 1)
            Case RAISE_SIGN: tokens(toSolve) = tokens(toSolve) ^ tokens(toSolve + 1)
            Case BSL_SIGN: tokens(toSolve) = tokens(toSolve) * (2 ^ tokens(toSolve + 1))
            Case BSR_SIGN: tokens(toSolve) = tokens(toSolve) / (2 ^ tokens(toSolve + 1))
            Case BOR_SIGN: tokens(toSolve) = tokens(toSolve) Or tokens(toSolve + 1)
            Case BAND_SIGN: tokens(toSolve) = tokens(toSolve) And tokens(toSolve + 1)
            Case BXOR_SIGN: tokens(toSolve) = tokens(toSolve) Xor tokens(toSolve + 1)
            Case MOD_SIGN: tokens(toSolve) = tokens(toSolve) Mod tokens(toSolve + 1)
        End Select
        ' Knock the arrays back a notch
        For idx = toSolve To UBound(tokens)
            tokens(idx + 1) = tokens(idx + 2)
            brackets(idx) = brackets(idx + 1)
            operators(idx) = operators(idx + 1)
        Next idx
        ReDim Preserve tokens(UBound(tokens) - 1)
        ReDim Preserve brackets(UBound(brackets) - 1)
        ReDim Preserve operators(UBound(operators) - 1)
    Loop

    ' Return the result
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
Public Function dataType(ByVal Text As String, ByRef prg As RPGCodeProgram, Optional ByVal allowEquations As Boolean = True, Optional ByRef isEquation As Boolean) As RPGC_DT

    On Error Resume Next

    If (allowEquations) Then

        ' Create an array of signs
        Dim signs(9) As String
        signs(0) = "+"
        signs(1) = "-"
        signs(2) = "/"
        signs(3) = "*"
        signs(4) = "^"
        signs(5) = "\"
        signs(6) = "|"
        signs(7) = "&"
        signs(8) = "`"
        signs(9) = "%"

        ' Remove brackets from the text for this test
        Text = replace(replace(Text, ")", vbNullString), "(", vbNullString)

        ' Split up the text
        Dim parts() As String, delimiters() As String
        parts = multiSplit(Text, signs, delimiters, True)

        ' Assume all parts will be the same type
        dataType = dataType(parts(0), prg, False)

        ' Check if it's an equation
        isEquation = (UBound(parts) <> 0)

        ' Bail
        Exit Function

    End If

    On Error GoTo dataTypeErr

    Dim ret As Double       ' Return from CDbl()
    Dim errors As Boolean   ' Was there an error?

    ' Variables for obtaining an rppcode variable's value
    Dim lit As String, num As Double, hClass As Long

    ' Trim up text
    Text = Trim$(replace(Text, vbTab, vbNullString))

    ' Try to change the text to a double
    ret = CDbl(Text)

    If (Not errors) Then
        ' If we lived through that then it's a number, hands down!
        dataType = DT_NUMBER
        Exit Function
    End If

    ' Resume handling errors
    On Error Resume Next

    ' Check the TDC
    Select Case Right$(Text, 1)

        Case "$"
            ' Literal type declaration character
            dataType = DT_LIT
            ' Fly away little birdy, fly
            Exit Function

        Case "!"
            ' Numerical type declaration character
            dataType = DT_NUM
            ' Let's not hang around
            Exit Function

    End Select

    ' Check for quotes in the text
    Dim idx As Long, depth As Long
    For idx = 1 To Len(Text)

        Select Case Mid$(Text, idx, 1)

            Case """"
                If (depth = 0) Then
                    ' It's a string constant
                    dataType = DT_STRING
                    ' There's no need to hang around
                    Exit Function
                End If

            Case "["
                ' Getting deeper in arrays
                depth = depth + 1

            Case "]"
                ' Leaving an array
                depth = depth - 1

        End Select

    Next idx

    ' At this point I'm going to check for user defined casts
    If (getVariable(Text & "!", lit, num, prg) = DT_NUM) Then
        ' It turned out numerical... that's good :)
        If (num <> 0) Then
            ' We got a number, to boot
            hClass = CLng(num)
            If (isObject(hClass, prg)) Then
                ' And it's an object, woo!
                Dim outside As Boolean
                outside = (topNestle(prg) <> hClass)
                If (isMethodMember("operator!", hClass, prg, outside)) Then
                    ' It's numerical
                    dataType = DT_NUM
                    Exit Function
                ElseIf (isMethodMember("operator$", hClass, prg, outside)) Then
                    ' It's literal
                    dataType = DT_LIT
                    Exit Function
                End If
            End If
        End If
    End If

    ' If we're still not free of this nightmare then assume string, for
    ' backwards compatibility
    dataType = DT_STRING

    ' Fin
    Exit Function

dataTypeErr:
    ' Flag there was an error
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
        getRedirect = vbNullString
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
        getRedirectName = vbNullString
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
    methodName = UCase$(replace(methodName, "#", ""))
    Call RPGCKillRedirect(methodName)
End Sub

'=========================================================================
' Determine if a redirect exists for the text passed in
'=========================================================================
Public Function redirectExists(ByVal methodToCheck As String) As Boolean
    redirectExists = (RPGCRedirectExists(UCase$(replace(methodToCheck, "#", ""))) = 1)
End Function

'=========================================================================
' RPGCode interface with variables
'=========================================================================
Public Sub variableManip(ByVal Text As String, ByRef theProgram As RPGCodeProgram, Optional ByRef pLit As String, Optional ByRef pNum As Double, Optional ByVal solveType As RPGC_DT = DT_VOID)

    On Error Resume Next

    Dim Destination As String       ' RPGCode destination variable
    Dim tokenIdx As Long            ' Token index
    Dim dType As RPGC_DT            ' Type of data
    Dim equal As String             ' The conjunction
    Dim number As Long              ' Number of tokens we have
    Dim lit As String               ' Literal value
    Dim num As Double               ' Numerical value
    Dim hClass As Long              ' Handle to a class
    Dim retval As RPGCODE_RETURN    ' Return value
    Dim destLit As String           ' Destination as a string
    Dim destNum As Double           ' Destination as a num
    Dim noVar As Boolean            ' No var on left side?

    ' Check if a type was passed
    If (solveType <> DT_VOID) Then
        ' We'll pass the value out in a param
        noVar = True
        Text = "x=" & Text
        dType = solveType
    End If

    If (Not noVar) Then ' If there's a var

        ' Get the destination variable and remove unwanted characters
        Destination = parseArray(replace(replace(replace(GetVarList(Text, 1), "#", ""), " ", ""), vbTab, ""), theProgram)
        If (Right$(Destination, 1) <> "!" And Right$(Destination, 1) <> "$") Then
            ' Append a "!"
            Destination = Destination & "!"
            ' Get value of the destination
            Call getValue(Destination, lit, num, theProgram)
            ' If it's not NULL
            If (num <> 0) Then
                ' Check if it's already an object
                If (isObject(num, theProgram)) Then
                    ' It is; we may need to handle an overloaded =
                    hClass = num
                    ' Mark that we'll get the data type from the data
                    dType = DT_VOID
                End If
            Else
                ' It's a number
                dType = DT_NUM
            End If
        Else
            ' Get the type of the destination
            dType = dataType(Destination, theProgram, True)
        End If

    End If

    If ((dType = DT_NUM) Or (dType = DT_VOID)) Then
        ' If we have a numerical variable then add to
        ' the string to evaluate (prevents some errors)
        Text = Text & " +0+0"
    End If

    ' Check what type of conjuction we have
    equal = MathFunction(Text, 1)

    ' Remove the conjuction from the text
    Text = replace(Text, equal, "=")

    ' Get the number of tokens we have
    number = ValueNumber(Text)

    ' Create an array to hold the tokens
    ReDim valueList(number) As String

    ' For each token after the equal sign
    For tokenIdx = 2 To number

        ' Get the token
        valueList(tokenIdx) = GetVarList(Text, tokenIdx)

        ' We need to get the data type
        If ((dType = DT_VOID) And (tokenIdx = 2)) Then
            ' Get the data type from this
            dType = getValue(valueList(tokenIdx), lit, num, theProgram)
        End If

    Next tokenIdx

    If (Not noVar) Then
        ' Get the value of the destination
        Call getValue(Destination, destLit, destNum, theProgram)
    End If

    ' Switch on the data type
    Select Case dType

        Case DT_NUM             'NUMERICAL
                                '---------

            ' Switch on the sign
            Select Case equal

                Case "++"
                    Call SetVariable(Destination, destNum + 1, theProgram)
                    Exit Sub

                Case "--"
                    Call SetVariable(Destination, destNum - 1, theProgram)
                    Exit Sub

                Case "+=", "-=", "*=", "/=", "=", "|=", "&=", "`=", "%="

                Case Else
                    Call debugger("Error: Invalid conjunction-- " & equal & " -- " & Text)
                    Exit Sub

            End Select

            ' Put all the tokens into an array
            ReDim numberUse(number) As Double
            For tokenIdx = 2 To number
                Call getValue(valueList(tokenIdx), lit, numberUse(tokenIdx), theProgram)
            Next tokenIdx

            ' Build the equation into a string
            Dim build As String
            For tokenIdx = 2 To number
                build = build & numberUse(tokenIdx) & MathFunction(Text, tokenIdx)
            Next tokenIdx
            build = Mid$(build, 1, Len(build) - 2)

            ' Now actually evaluate the quation
            Dim dRes As Double
            dRes = evaluate(build)

            If ((hClass <> 0) And (equal <> "=") And (Not noVar)) Then
                ' If this class handles this *specific* operator
                If (isMethodMember("operator" & equal, hClass, theProgram, topNestle(theProgram) <> hClass)) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator" & equal & "(" & CStr(dRes) & ")", theProgram, retval, "operator" & equal)
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            ' Preform any special effects
            Select Case equal
                Case "-=": dRes = destNum - dRes
                Case "+=": dRes = dRes + destNum
                Case "*=": dRes = dRes * destNum
                Case "/=": dRes = destNum / dRes
                Case "|=": dRes = dRes Or destNum
                Case "&=": dRes = dRes And destNum
                Case "`=": dRes = dRes Xor destNum
                Case "%=": dRes = dRes Mod destNum
            End Select

            If ((hClass <> 0) And (Not noVar)) Then
                ' If this class handles =
                If (isMethodMember("operator=", hClass, theProgram, topNestle(theProgram) <> hClass)) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator=(" & CStr(dRes) & ")", theProgram, retval, "operator=")
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            If (Not noVar) Then
                ' Set destination to the result
                Call SetVariable(Destination, CStr(dRes), theProgram)
            Else
                ' Pass out via params
                pNum = dRes
            End If

        Case DT_LIT         'LITERAL
                            '-------

            ' Get the tokens
            ReDim litUse(number) As String
            For tokenIdx = 2 To number
                Call getValue(Trim$(valueList(tokenIdx)), litUse(tokenIdx), num, theProgram)
            Next tokenIdx

            ' Combine the tokens
            Dim res As String
            For tokenIdx = 2 To number
                res = res & litUse(tokenIdx)
            Next tokenIdx

            If ((equal = "+=") And (Not noVar)) Then
                ' Add result to existing value
                res = destLit & res
            End If

            ' If we recorded a class' handle earlier
            If ((hClass <> 0) And (Not noVar)) Then
                ' If this class handles =
                If (isMethodMember("operator=", hClass, theProgram, topNestle(theProgram) <> hClass)) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator=(""" & res & """)", theProgram, retval, "operator=")
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            If (Not noVar) Then
                ' Set destination to result
                Call SetVariable(Destination, res, theProgram)
            Else
                ' Pass out value via params
                pLit = res
            End If

        Case Else       'INVALID DESTINATION VARIABLE
                        '----------------------------
            Call debugger("Error: Value on left must be a valid variable-- " & Text)

    End Select

End Sub

'=========================================================================
' Gets the value of the text passed
'=========================================================================
Public Function getValue(ByVal Text As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram, Optional ByVal allowEquations As Boolean = True) As RPGC_DT

    On Error Resume Next

    Dim numA As Double      ' Numerical value
    Dim litA As String      ' Literal value
    Dim p As Long           ' For loop control variable
    Dim Length As Long      ' Length of text
    Dim part As String      ' A character
    Dim checkIt As Boolean  ' In quotes?
    Dim newPos As Long      ' New position
    Dim sendText As String  ' Text to return
    Dim equType As RPGC_DT  ' Type of equation

    If (allowEquations) Then

        ' Get type of the equation
        Dim isEquation As Boolean
        equType = dataType(Text, theProgram, True, isEquation)

        ' Make sure it's an equation
        If (isEquation) Then

            ' Evaluate the equation
            If ((equType = DT_LIT) Or (equType = DT_STRING)) Then
                ' Literal equation
                Call variableManip(Text, theProgram, lit, , DT_LIT)
                getValue = DT_LIT
            Else
                ' Numerical equation
                Call variableManip(Text, theProgram, , num, DT_NUM)
                getValue = DT_NUM
            End If

            ' Bail
            Exit Function

        End If

    Else

        ' Get the data type
        equType = dataType(Text, theProgram, False)

    End If

    ' Switch on the data type
    Select Case equType

        Case DT_NUM         'NUMERICAL VARIABLE
                            '------------------

            If getVariable(Text, litA, numA, theProgram) = DT_NUM Then
                ' Found one!
                num = numA
            End If
            getValue = DT_NUM

        Case DT_LIT         'LITERAL VARIABLE
                            '----------------

            If getVariable(Text, litA, numA, theProgram) = DT_LIT Then
                ' Found one!
                lit = litA
            End If
            getValue = DT_LIT

        Case DT_STRING      'STRING
                            '------

            ' Get the length of the text
            Length = Len(Text)

            ' Check if text is in quotes
            For p = 1 To Length
                If Mid$(Text, p, 1) = ("""") Then
                    checkIt = True
                    Exit For
                End If
            Next p

            If (checkIt) Then
                ' It is!
                For p = 1 To Length
                    If Mid$(Text, p, 1) = ("""") Then
                        newPos = p
                        Exit For
                    End If
                Next p
                For p = (newPos + 1) To (Length)
                    part = Mid$(Text, p, 1)
                    If ((part = ("""")) Or (LenB(part) = 0)) Then
                        lit = sendText
                        getValue = DT_LIT
                        Exit Function
                    Else
                        sendText = sendText & part
                    End If
                Next p
            Else
                ' Try for an object
                Dim noArray As String
                noArray = Mid$(Text, 1, InStr(1, Text, "[") - 1)
                If (LenB(noArray) <> 0) Then
                    ' Use stuff before "["
                    Call getVariable(noArray & "!", litA, numA, theProgram)
                Else
                    ' Use the text in its entirety
                    Call getVariable(Text & "!", litA, numA, theProgram)
                End If
                If (numA <> 0) Then
                    If (isObject(CLng(numA), theProgram)) Then
                        If (getVariable(Text, litA, numA, theProgram) = DT_NUM) Then
                            num = numA
                            getValue = DT_NUM
                        Else
                            lit = litA
                            getValue = DT_LIT
                        End If
                    Else
                        lit = Text
                        getValue = DT_LIT
                    End If
                Else
                    lit = Text
                    getValue = DT_LIT
                End If
            End If

        Case DT_NUMBER      'NUMBER
                            '------

            num = CDbl(Text)
            getValue = DT_NUM

    End Select

End Function

'=========================================================================
' Determine if a literal variable exists
'=========================================================================
Public Function litVarExists(ByVal varname As String, ByVal heapID As Long) As Boolean
    If (LenB(varname) <> 0) Then
        litVarExists = (RPGCLitExists(UCase$(varname), heapID) = 1)
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
        GetNumName = vbNullString
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
        GetLitName = vbNullString
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
    If (LenB(varname) <> 0) Then
        numVarExists = (RPGCNumExists(UCase$(varname), heapID) = 1)
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

    ' Clean up the variable's name
    varname = Trim$(LCase$(varname))

    ' Check for reserved dynamically updating variables
    Select Case varname

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

    ' Get the variable
    Dim theVar As String
    theVar = parseArray(replace(varname, " ", ""), theProgram)

    ' Check if it belongs to a class
    If (theProgram.classes.insideClass) Then
        If (isVarMember(varname, topNestle(theProgram), theProgram)) Then
            theVar = getObjectVarName(theVar, topNestle(theProgram))
        End If
    End If

    ' Create an rpgcode return value
    Dim rV As RPGCODE_RETURN

    ' Get the var's type
    Dim varType As RPGC_DT
    varType = variType(theVar, globalHeap)
    getVariable = varType

    If ((Right$(theVar, 1) <> "!") And (Right$(theVar, 1) <> "$")) Then
        ' Append a "!"
        theVar = theVar & "!"
        ' Get value of the destination
        Dim litA As String, numA As Double
        Call getValue(theVar, litA, numA, theProgram)
        ' If it's not NULL
        If (numA <> 0) Then
            ' Check if it's already an object
            If (isObject(numA, theProgram)) Then
                ' It is; we may need to handle an overloaded ! or $
                Dim hClass As Long
                hClass = CLng(numA)
                ' Check if it exists
                If (isMethodMember("operator!", hClass, theProgram, topNestle(theProgram) <> hClass)) Then
                    ' Call it
                    Call callObjectMethod(hClass, "operator!()", theProgram, rV, "operator!")
                    ' Return and leave
                    If (rV.dataType = DT_REFERENCE) Then
                        ' Recurse
                        getVariable = getVariable(rV.ref, lit, num, theProgram)
                        Exit Function
                    End If
                    getVariable = DT_NUM
                    num = rV.num
                    Exit Function
                ElseIf (isMethodMember("operator$", hClass, theProgram, topNestle(theProgram) <> hClass)) Then
                    ' Call it
                    Call callObjectMethod(hClass, "operator$()", theProgram, rV, "operator$")
                    ' Return and leave
                    If (rV.dataType = DT_REFERENCE) Then
                        ' Recurse
                        getVariable = getVariable(rV.ref, lit, num, theProgram)
                        Exit Function
                    End If
                    getVariable = DT_LIT
                    lit = rV.lit
                    Exit Function
                End If
            End If
        End If
    End If

    If (varType = DT_VOID) Then
        ' If there was an error, just exit this function
        Exit Function
    End If

    If (varType = DT_NUM) Then      'NUMERICAL VARIABLE
                                    '------------------

        If (theProgram.autoLocal) Then
            If (Not numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                Call LocalRPG("Local(" & theVar & ")", theProgram, rV)
            End If
        End If

        num = SearchNumVar(theVar, theProgram)

    ElseIf (varType = DT_LIT) Then  'LITERAL VARIABLE
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
        GetLitVar = vbNullString
    End If
End Function
