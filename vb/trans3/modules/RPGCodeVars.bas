Attribute VB_Name = "RPGCodeVars"
'=========================================================================
' All contents copyright 2003, 2004, Christopher Matthews or Contributors
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGCode Variables
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function RPGCInit Lib "actkrt3.dll" () As Long
Private Declare Function RPGCShutdown Lib "actkrt3.dll" () As Long
Private Declare Function RPGCCreateHeap Lib "actkrt3.dll" () As Long
Private Declare Function RPGCDestroyHeap Lib "actkrt3.dll" (ByVal heapId As Long) As Long
Private Declare Function RPGCSetNumVar Lib "actkrt3.dll" (ByVal varname As String, ByVal value As Double, ByVal heapId As Long) As Long
Private Declare Function RPGCSetLitVar Lib "actkrt3.dll" (ByVal varname As String, ByVal value As String, ByVal heapId As Long, ByVal theByteLen As Long) As Long
Private Declare Function RPGCGetNumVar Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Double
Private Declare Function RPGCGetLitVar Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As String
Private Declare Function RPGCGetLitVarLen Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Long
Private Declare Function RPGCCountNum Lib "actkrt3.dll" (ByVal heapId As Long) As Long
Private Declare Function RPGCCountLit Lib "actkrt3.dll" (ByVal heapId As Long) As Long
Private Declare Function RPGCGetNumName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String, ByVal heapId As Long) As Long
Private Declare Function RPGCGetLitName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String, ByVal heapId As Long) As Long
Private Declare Function RPGCClearAll Lib "actkrt3.dll" (ByVal heapId As Long) As Long
Private Declare Function RPGCKillNum Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Long
Private Declare Function RPGCKillLit Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Long
Private Declare Function RPGCNumExists Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Long
Private Declare Function RPGCLitExists Lib "actkrt3.dll" (ByVal varname As String, ByVal heapId As Long) As Long
Private Declare Function RPGCGetLitVarByteLen Lib "actkrt3.dll" (ByVal theVar As String, ByVal theHeap As Long) As Long
Private Declare Function RPGCSetRedirect Lib "actkrt3.dll" (ByVal methodOrig As String, ByVal methodTarget As String) As Long
Private Declare Function RPGCRedirectExists Lib "actkrt3.dll" (ByVal methodToCheck As String) As Long
Private Declare Function RPGCGetRedirect Lib "actkrt3.dll" (ByVal methodToGet As String, ByVal pstrToVal As String) As Long
Private Declare Function RPGCKillRedirect Lib "actkrt3.dll" (ByVal pstrMethod As String) As Long
Private Declare Function RPGCGetRedirectName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String) As Long
Private Declare Function RPGCClearRedirects Lib "actkrt3.dll" () As Long
Private Declare Function RPGCCountRedirects Lib "actkrt3.dll" () As Long

'=========================================================================
' Members
'=========================================================================
Private m_globalHeap As Long            ' The ID of the global heap

'=========================================================================
' Get the ID of the global heap
'=========================================================================
Public Property Get globalHeap() As Long
    globalHeap = m_globalHeap
End Property

'=========================================================================
' Add a local heap to a program
'=========================================================================
Public Sub AddHeapToStack(ByRef thePrg As RPGCodeProgram)
    On Error Resume Next
    thePrg.currentHeapFrame = thePrg.currentHeapFrame + 1
    If (thePrg.currentHeapFrame + 1 > UBound(thePrg.heapStack)) Then
        ' Resize heap stack
        ReDim Preserve thePrg.heapStack(thePrg.currentHeapFrame * 2)
    End If
    thePrg.heapStack(thePrg.currentHeapFrame) = RPGCCreateHeap()
End Sub

'=========================================================================
' Add a value to a stack
'=========================================================================
Public Sub PushCompileStack(ByRef thePrg As RPGCodeProgram, ByVal value As String)
    On Error Resume Next
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx + 1
    If (thePrg.currentCompileStackIdx + 1 > UBound(thePrg.compilerStack)) Then
        ' Resize stack
        ReDim Preserve thePrg.compilerStack(thePrg.currentCompileStackIdx * 2)
    End If
    thePrg.compilerStack(thePrg.currentCompileStackIdx) = value
End Sub

'=========================================================================
' Pop a value from a stack
'=========================================================================
Public Function PopCompileStack(ByRef thePrg As RPGCodeProgram) As String
    On Error Resume Next
    If (thePrg.currentCompileStackIdx = -1) Then
        Exit Function
    End If
    PopCompileStack = thePrg.compilerStack(thePrg.currentCompileStackIdx)
    thePrg.currentCompileStackIdx = thePrg.currentCompileStackIdx - 1
End Function

'=========================================================================
' Remove all heaps from a program
'=========================================================================
Public Sub ClearRPGCodeProcess(ByRef thePrg As RPGCodeProgram)
    On Error GoTo skipHeap
    ' Clear the stack
    ReDim thePrg.methods(0)
    Dim t As Long
    For t = 0 To UBound(thePrg.heapStack)
        Call RPGCDestroyHeap(thePrg.heapStack(t))
        thePrg.heapStack(t) = 0
    Next t
    For t = 0 To UBound(thePrg.included)
        thePrg.included(t) = vbNullString
    Next t
skipHeap:
    thePrg.currentHeapFrame = -1
    thePrg.currentCompileStackIdx = -1
End Sub

'=========================================================================
' Count number of redirects
'=========================================================================
Public Function countRedirects() As Long

    ' Call into actkrt3
    countRedirects = RPGCCountRedirects()

End Function

'=========================================================================
' Count number of RPGCode literal variables
'=========================================================================
Public Function countLitVars(ByVal heapId As Long) As Long

    ' Call into actkrt3
    countLitVars = RPGCCountLit(heapId)

End Function

'=========================================================================
' Count number of RPGCode numerical variables
'=========================================================================
Public Function countNumVars(ByVal heapId As Long) As Long

    ' Call into actkrt3
    countNumVars = RPGCCountNum(heapId)

End Function

'=========================================================================
' Detect if something is an operator
'=========================================================================
Private Function isOperator(ByRef test As String) As Boolean
    isOperator = True
    Select Case test
        Case "-", "+", "*", "/", "^", "%", "&", "|", "`", "<<", ">>"
        Case Else
            ' It's not an operator
            isOperator = False
    End Select
End Function

'=========================================================================
' Detect if something is a number
'=========================================================================
Public Function isNumber(ByVal num As String) As Boolean
    On Error GoTo error
    Dim ret As Double
    If (isOperator(RightB$(num, 2))) Then Exit Function
    ret = CDbl(num)
    isNumber = True
error:
End Function

'=========================================================================
' Declare a variable
'=========================================================================
Public Sub declareVariable(ByRef strVarName As String, ByRef prg As RPGCodeProgram)

    ' First, get the variable's type
    Dim dtVarType As RPGC_DT
    dtVarType = variType(strVarName, m_globalHeap)

    If (dtVarType = DT_NUM) Then

        ' Check to make sure there's not already a numerical variable by
        ' this name
        If Not (numVarExists(strVarName, prg.heapStack(prg.currentHeapFrame))) Then

            ' Create the variable
            Call SetNumVar(strVarName, 0, prg.heapStack(prg.currentHeapFrame))

        End If

    Else

        ' Check to make sure there's not already a literal variable by
        ' this name
        If Not (litVarExists(strVarName, prg.heapStack(prg.currentHeapFrame))) Then

            ' Create the variable
            Call SetLitVar(strVarName, vbNullString, prg.heapStack(prg.currentHeapFrame))

        End If

    End If

End Sub

'=========================================================================
' Remove a heap from a stack
'=========================================================================
Public Function RemoveHeapFromStack(ByRef thePrg As RPGCodeProgram) As Boolean
    On Error Resume Next
    If thePrg.currentHeapFrame >= 0 Then
        Call RPGCDestroyHeap(thePrg.heapStack(thePrg.currentHeapFrame))
        thePrg.currentHeapFrame = thePrg.currentHeapFrame - 1
        RemoveHeapFromStack = True
    End If
End Function

'=========================================================================
' Evaluate an equation (Asimir & KSNiloc)
'=========================================================================
Private Function equEvaluate(ByVal Text As String) As Double

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
    Const RAISE_SIGN = 10           ' ^ sign

    Dim idx As Long                 ' Current character
    Dim char As String              ' A character
    Dim char2 As String             ' Another character
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
    Text = replace(replace(replace("(" & Text & ")", vbTab, vbNullString), " ", vbNullString), "(-", "(-1*")

    ' Loop over each character
    For idx = 1 To Len(Text)

        ' Grab two characters
        char = Mid$(Text, idx, 1)
        char2 = Mid$(Text, idx + 1, 1)

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
                ' If it was a negative sign then remove it
                Text = Mid$(Text, 1, idx - 1) & "0" & Mid$(Text, idx + 1)
            End If
        Else
            ' If we have a number, then we've reached its end
            If (LenB(num)) Then
                ' Record the token
                tokenIdx = tokenIdx + 1
                ReDim Preserve tokens(tokenIdx)
                tokens(tokenIdx) = CDbl(num)
                ' Set running num to nothing
                num = vbNullString
            End If

            ' Try other things
            If (char = "(") Then

                ' Getting deeper
                depth = depth + 1

            ElseIf (char = ")") Then

                ' Coming out
                depth = depth - 1

            ElseIf (isOperator(char)) Then

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

            ElseIf (isOperator(char & char2)) Then

                ' Record the operator
                operatorIdx = operatorIdx + 1
                ReDim Preserve operators(operatorIdx)
                Select Case (char & char2)
                    Case "<<": operators(operatorIdx) = BSL_SIGN
                    Case ">>": operators(operatorIdx) = BSR_SIGN
                End Select

                ' Record the bracket depth
                ReDim Preserve brackets(operatorIdx)
                brackets(operatorIdx) = depth

                ' Skip a character
                idx = idx + 1

            End If

        End If

    Next idx

    ' Before we try and solve this equation, let's make sure all's good
    If ((depth <> 0) Or ((operatorIdx + 1) <> tokenIdx)) Then
        ' Error out
        equEvaluate = -1
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
    equEvaluate = tokens(0)

End Function

'=========================================================================
' Get the value of a variable - unattached to a program
'=========================================================================
Public Function getIndependentVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double) As RPGC_DT
    getIndependentVariable = getVariable(varname, lit, num, errorKeep)
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
Public Function dataType(ByVal Text As String, ByRef prg As RPGCodeProgram, Optional ByVal allowEquations As Boolean = True, Optional ByRef isEquation As Boolean, Optional ByVal dtFallBack As RPGC_DT = DT_STRING) As RPGC_DT

    On Error Resume Next

    If (allowEquations) Then

        ' Create an array of signs
        Dim signs(15) As String
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
        signs(10) = "=="
        signs(11) = "="
        signs(12) = "<<"
        signs(13) = ">>"
        signs(14) = "<"
        signs(15) = ">"

        ' Replace '-' with '+'
        Text = replace(Text, "-", "+")

        ' Remove brackets from the text for this test
        Text = replace(replace(Text, ")", vbNullString), "(", vbNullString)

        ' Split up the text
        Dim parts() As String, delimiters() As String
        parts = multiSplit(Text, signs, delimiters, True)

        ' Check if it's an equation
        isEquation = (UBound(parts))

        ' Get the data type
        Dim anotre As Boolean, dataIdx As Long
        Do
            ' Do the loop :P
            anotre = True
            dataType = dataType(parts(dataIdx), prg, False, anotre)
            dataIdx = dataIdx + 1
        Loop Until ((anotre) Or (dataIdx > UBound(parts)))

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

    If Not (errors) Then
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
        If (num) Then
            ' We got a number, to boot
            hClass = CLng(num)
            If (isObject(hClass)) Then
                ' And it's an object, woo!
                Dim outside As Boolean
                outside = isOutside(hClass, prg) ' (topNestle(prg) <> hClass)
                If (isMethodMember("operator!", hClass, prg, outside)) Then
                    ' It's numerical
                    dataType = DT_NUM
                    Exit Function
                ElseIf (isMethodMember("operator$", hClass, prg, outside)) Then
                    ' It's literal
                    dataType = DT_LIT
                    Exit Function
                ElseIf (isEquation) Then
                    ' Flag we can't decide on this
                    isEquation = False
                    Exit Function
                End If
            End If
        End If
    End If

    ' Check for numerical var without its sign
    Dim lngHeapFrame As Long
    lngHeapFrame = prg.heapStack(prg.currentHeapFrame)
    If (lngHeapFrame) Then
        If (numVarExists(Text, lngHeapFrame) Or _
            numVarExists(Text, m_globalHeap)) Then

            ' It's a numerical var
            dataType = DT_NUM
            Exit Function

        End If
    End If

    ' If we're still not free of this nightmare then assume string, for
    ' backwards compatibility
    dataType = dtFallBack

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
    
    originalMethod = UCase$(replace(originalMethod, "#", vbNullString))
    If redirectExists(originalMethod) Then
        Dim getStr As String * 4048
        Length = RPGCGetRedirect(originalMethod, getStr)
        If Length = 0 Then
            getRedirect = originalMethod
            Exit Function
        End If
        getRedirect = Mid$(getStr, 1, Length)
    Else
        getRedirect = originalMethod
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
    methodName = UCase$(replace(methodName, "#", vbNullString))
    Call RPGCKillRedirect(methodName)
End Sub

'=========================================================================
' Determine if a redirect exists for the text passed in
'=========================================================================
Public Function redirectExists(ByVal methodToCheck As String) As Boolean
    redirectExists = (RPGCRedirectExists(UCase$(replace(methodToCheck, "#", vbNullString))) = 1)
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
    Dim logicEval As Boolean        ' Can we evaluate with logic?

    ' Check if a type was passed
    If (solveType <> DT_VOID) Then

        ' We'll pass the value out in a param
        noVar = True
        Text = "x = " & Text
        dType = solveType

    End If

    If Not (noVar) Then ' If there's a var

        ' Get the destination variable and remove unwanted characters
        Destination = parseArray(replace(replace(replace(GetVarList(Text, 1), "#", vbNullString), " ", vbNullString), vbTab, vbNullString), theProgram)
        Dim rdtdc As String
        rdtdc = RightB$(Destination, 2)
        If ((rdtdc <> "!") And (rdtdc <> "$")) Then
            ' Append a "!"
            Destination = Destination & "!"
            ' Get value of the destination
            Call getValue(Destination, lit, num, theProgram)
            ' If it's not NULL
            If (num) Then
                ' Check if it's already an object
                If (isObject(num)) Then
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

    Dim oldText As String
    oldText = Text

    If ((dType = DT_NUM) Or (dType = DT_VOID)) Then
        ' If we have a numerical variable then add to
        ' the string to evaluate (prevents some errors)
       Text = Text & " +0+0"
    End If

    ' Check what type of conjuction we have
    equal = MathFunction(Text, 1)
    Select Case equal
        Case "+", "-", "*", "/", "^", "&", "|", "`", "<<", ">>"
            ' Not a "real" conjuction
            noVar = True
            Text = "x = " & Text
            equal = "="
    End Select

    ' Remove the conjuction from the text
    Text = replace(Text, equal, " = ", , 1)

    ' Get the number of tokens we have
    number = ValueNumber(Text)

    ' Create an array to hold the tokens
    ReDim valueList(number) As String, bIsVar(number) As Boolean
    Dim bVarNext As Boolean

    ' For each token after the equal sign
    For tokenIdx = 2 To number

        ' Get the token
        valueList(tokenIdx) = Trim$(GetVarList(Text, tokenIdx))

        If (LenB(valueList(tokenIdx))) Then

            If (bVarNext) Then
                bIsVar(tokenIdx) = True
                bVarNext = False
            End If

            If (InStrB(1, valueList(tokenIdx), "(")) Then
                If (valueList(tokenIdx) = "(") Then
                    bVarNext = True
                Else
                    bIsVar(tokenIdx) = True
                End If
            End If
        
        End If

        ' We need to get the data type
        If ((dType = DT_VOID) And (tokenIdx = 2)) Then
            ' Get the data type from this
            dType = getValue(valueList(tokenIdx), lit, num, theProgram)
        End If

    Next tokenIdx

    If Not (noVar) Then
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
                    If ((hClass <> 0) And (Not (noVar))) Then
                        ' If this class handles this operator
                        If (isMethodMember("operator++", hClass, theProgram, isOutside(hClass, theProgram))) Then
                            ' Call the method
                            Call callObjectMethod(hClass, "operator++", theProgram, retval, "operator++")
                            ' Leave this procedure
                            Exit Sub
                        End If
                    End If
                    Call SetVariable(Destination, destNum + 1, theProgram)
                    Exit Sub

                Case "--"
                    If ((hClass <> 0) And (Not (noVar))) Then
                        ' If this class handles this operator
                        If (isMethodMember("operator--", hClass, theProgram, isOutside(hClass, theProgram))) Then
                            ' Call the method
                            Call callObjectMethod(hClass, "operator--", theProgram, retval, "operator--")
                            ' Leave this procedure
                            Exit Sub
                        End If
                    End If
                    Call SetVariable(Destination, destNum - 1, theProgram)
                    Exit Sub

                Case "+=", "-=", "*=", "/=", "=", "|=", "&=", "`=", "%=", "<<=", ">>="

                Case Else
                    Call debugger("Error: Invalid conjunction-- " & equal & " -- " & Text)
                    Exit Sub

            End Select

            ' Check if we can evaluate using logic
            Dim dRes As Double
            logicEval = True
            dRes = CDbl(evaluate(MidB$(oldText, InStrB(1, oldText, equal) + LenB(equal)), theProgram, logicEval))

            If Not (logicEval) Then

                ' Put all the tokens into an array
                ReDim numberUse(number) As Double, conjunctions(number) As String, nulled(number) As Boolean
                For tokenIdx = 2 To number
                    ' Get the conjuction here
                    conjunctions(tokenIdx) = MathFunction(Text, tokenIdx)
                    ' Get the value of the token
                    Dim strToken As String
                    strToken = replace(replace(valueList(tokenIdx), ")", vbNullString), "(", vbNullString)
                    lit = vbNullString
                    Call getValue(strToken, lit, numberUse(tokenIdx), theProgram, , bIsVar(tokenIdx))
                    If (LenB(lit)) Then
                        Call getValue(strToken, lit, numberUse(tokenIdx), theProgram, , bIsVar(tokenIdx), , True)
                    End If
                    ' Add the inverse for subtraction
                    If (conjunctions(tokenIdx - 1) = "-") Then
                        conjunctions(tokenIdx - 1) = "+"
                        numberUse(tokenIdx) = -numberUse(tokenIdx)
                    End If
                    ' If this isn't the first token
                    If ((tokenIdx <> 2) And (tokenIdx <= (number - 2))) Then
                        ' Find a token
                        Dim toFind As Long
                        toFind = 0
                        Do
                            If ((tokenIdx + toFind) = 2) Then
                                ' No luck at all
                                toFind = 0
                                Exit Do
                            End If
                            toFind = toFind - 1
                            If Not (nulled(tokenIdx + toFind)) Then
                                ' This one will do
                                Exit Do
                            End If
                        Loop
                        ' If we found one
                        If (toFind) Then
                            ' Check for operator overloading on previous token
                            Dim prevToken As String
                            prevToken = CStr(numberUse(tokenIdx - 1 + nulled(tokenIdx - 1)))
                            ' Get the value of the previous token
                            If (getValue(prevToken, lit, num, theProgram) = DT_NUM) Then
                                ' If it's not NULL
                                If (num) Then
                                    ' See if it's an object
                                    Dim hTokenClass As Long
                                    hTokenClass = CLng(num)
                                    If (isObject(hTokenClass)) Then
                                        ' See if it handles said conjuction
                                        Dim cnj As String
                                        cnj = "operator" & conjunctions(tokenIdx - 1)
                                        If (isMethodMember(cnj, hTokenClass, theProgram, isOutside(hClass, theProgram))) Then
                                            ' Call the method
                                            Call callObjectMethod(hTokenClass, cnj & "(" & valueList(tokenIdx) & ")", theProgram, retval, cnj)
                                            ' Switch on returned type
                                            Dim theVal As String
                                            Select Case retval.dataType
                                                Case DT_LIT: theVal = retval.lit
                                                Case DT_NUM: theVal = CStr(retval.num)
                                                Case DT_REFERENCE: theVal = retval.ref
                                            End Select
                                            ' Fill in new data
                                            Call getValue(theVal, lit, numberUse(tokenIdx - 1), theProgram)
                                            ' Nullify this position
                                            nulled(tokenIdx) = True
                                            ' Count functions as variables
                                            bIsVar(tokenIdx) = True
                                        End If ' isMethodMember
                                    End If ' isObject
                                End If ' (num <> 0)
                            End If ' (getVariable == DT_NUM)
                        End If ' (toFind <> 0)
                    End If ' ((tokenIdx <> 2) And (tokenIdx <= (number - 2)))
                Next tokenIdx

                ' Build the equation into a string
                Dim build As String
                For tokenIdx = 2 To number
                    If Not (nulled(tokenIdx)) Then
                        If Not (bIsVar(tokenIdx)) Then
                            build = build & numberUse(tokenIdx)
                        Else
                            build = build & "(" & numberUse(tokenIdx) & ")"
                        End If
                        If (tokenIdx <> number) Then
                            build = build & conjunctions(tokenIdx)
                        End If
                    End If
                Next tokenIdx

                If (LeftB$(build, 4) = "0+") Then

                    ' Chop off the initial "0+" until Asimir fixes his evaluator
                    build = Mid$(build, 3)

                End If

                ' Now actually evaluate the equation
                dRes = equEvaluate(build)

            End If

            If ((hClass <> 0) And (equal <> "=") And (Not (noVar))) Then
                ' If this class handles this *specific* operator
                If (isMethodMember("operator" & equal, hClass, theProgram, isOutside(hClass, theProgram))) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator" & equal & "(" & CStr(dRes) & ")", theProgram, retval, "operator" & equal)
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            ' Preform any special effects
            Select Case equal
                Case "+=": dRes = destNum + dRes
                Case "-=": dRes = destNum - dRes
                Case "*=": dRes = destNum * dRes
                Case "/=": dRes = destNum / dRes
                Case "|=": dRes = destNum Or dRes
                Case "&=": dRes = destNum And dRes
                Case "`=": dRes = destNum Xor dRes
                Case "%=": dRes = destNum Mod dRes
                Case "<<=": dRes = destNum * 2 ^ dRes
                Case ">>=": dRes = destNum / 2 ^ dRes
            End Select

            If ((hClass <> 0) And (Not (noVar))) Then
                ' If this class handles =
                If (isMethodMember("operator=", hClass, theProgram, isOutside(hClass, theProgram))) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator=(" & CStr(dRes) & ")", theProgram, retval, "operator=")
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            Dim bSetObject As Boolean

            If (isObject(dRes)) Then

                If (equal = "=") Then

                    If (hClass) Then

                        If (objectType(dRes) = objectType(destNum)) Then

                            ' Copy the object over
                            Call copyObject(dRes, theProgram, destNum)
                            bSetObject = True

                        End If

                    Else

                        ' Create a new copy
                        dRes = copyObject(dRes, theProgram)

                    End If

                End If

            End If

            If Not (bSetObject) Then

                If Not (noVar) Then
                    ' Set destination to the result
                    Call SetVariable(Destination, CStr(dRes), theProgram)
                Else
                    ' Pass out via params
                    pNum = dRes
                End If

            End If

        Case DT_LIT         'LITERAL
                            '-------

            ' Get the tokens
            ReDim litUse(number) As String
            For tokenIdx = 2 To number
                Call getValue(Trim$(valueList(tokenIdx)), litUse(tokenIdx), num, theProgram)
            Next tokenIdx

            ' Check if we can evaluate using logic
            Dim strRes As String
            logicEval = True
            Call evaluate(MidB$(oldText, InStrB(1, oldText, equal) + LenB(equal)), theProgram, logicEval, strRes)

            If Not (logicEval) Then

                ' Combine the tokens
                For tokenIdx = 2 To number
                    strRes = strRes & litUse(tokenIdx)
                Next tokenIdx

            End If

            If ((equal = "+=") And (Not (noVar))) Then
                ' Add result to existing value
                strRes = destLit & strRes
            End If

            ' If we recorded a class' handle earlier
            If ((hClass <> 0) And (Not (noVar))) Then
                ' If this class handles =
                If (isMethodMember("operator=", hClass, theProgram, isOutside(hClass, theProgram))) Then
                    ' Call the method
                    Call callObjectMethod(hClass, "operator=(""" & strRes & """)", theProgram, retval, "operator=")
                    ' Leave this procedure
                    Exit Sub
                End If
            End If

            If Not (noVar) Then
                ' Set destination to result
                Call SetVariable(Destination, strRes, theProgram)
            Else
                ' Pass out value via params
                pLit = strRes
            End If

        Case Else       'INVALID DESTINATION VARIABLE
                        '----------------------------
            Call debugger("Error: Value on left must be a valid variable-- " & Text)

    End Select

End Sub

'=========================================================================
' Gets the value of the text passed
'=========================================================================
Public Function getValue(ByVal Text As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram, Optional ByVal allowEquations As Boolean = True, Optional ByRef bWasVar As Boolean, Optional ByVal bForceNum As Boolean, Optional ByVal bTakeNumPath As Boolean) As RPGC_DT

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
        If (bTakeNumPath) Then equType = DT_NUM

        ' Make sure it's an equation
        If (isEquation) Then

            ' Evaluate the equation
            If ((equType = DT_LIT) Or (equType = DT_STRING)) Then
                ' Literal equation
                Call variableManip(Text, theProgram, lit, , DT_LIT)
                If Not (bForceNum) Then
                    getValue = DT_LIT
                Else
                    num = val(lit)
                    getValue = DT_NUM
                End If
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
        If Not (bTakeNumPath) Then
            equType = dataType(Text, theProgram, False)
        Else
            equType = DT_NUM
        End If

    End If

    ' Switch on the data type
    Select Case equType

        Case DT_NUM         'NUMERICAL VARIABLE
                            '------------------

            If (getVariable(Text, litA, numA, theProgram, bTakeNumPath) = DT_NUM) Then
                ' Found one!
                num = numA
            End If
            bWasVar = True
            getValue = DT_NUM

        Case DT_LIT         'LITERAL VARIABLE
                            '----------------

            If (getVariable(Text, litA, numA, theProgram) = DT_LIT) Then
                ' Found one!
                lit = litA
            End If
            bWasVar = True
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
                        If Not (bForceNum) Then
                            getValue = DT_LIT
                        Else
                            num = val(lit)
                            getValue = DT_NUM
                        End If
                        Exit Function
                    Else
                        sendText = sendText & part
                    End If
                Next p
            Else
                ' Try for an object
                Dim noArray As String
                noArray = Mid$(Text, 1, InStr(1, Text, "[") - 1)
                If (LenB(noArray)) Then
                    ' Use stuff before "["
                    Call getVariable(noArray & "!", litA, numA, theProgram)
                Else
                    ' Use the text in its entirety
                    Call getVariable(Text & "!", litA, numA, theProgram)
                End If
                If (numA) Then
                    If (isObject(CLng(numA))) Then
                        bWasVar = True
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
                    If Not (bForceNum) Then
                        getValue = DT_LIT
                    Else
                        num = val(lit)
                        getValue = DT_NUM
                    End If
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
Public Function litVarExists(ByVal varname As String, ByVal heapId As Long) As Boolean
    If (LenB(varname)) Then
        litVarExists = (RPGCLitExists(UCase$(varname), heapId) = 1)
    End If
End Function

'=========================================================================
' Kill a literal variable
'=========================================================================
Public Sub KillLit(ByVal varname As String, ByVal heapId As Long)
    On Error Resume Next
    Call RPGCKillLit(UCase$(varname), heapId)
End Sub

'=========================================================================
' Kill all variables
'=========================================================================
Public Sub clearVars(ByVal heapId As Long)
    On Error Resume Next
    Call RPGCClearAll(heapId)
End Sub

'=========================================================================
' Get the numerical variable at the index passed in
'=========================================================================
Public Function GetNumName(ByVal Index As Integer, ByVal heapId As Long) As String
    On Error Resume Next
    
    Dim max As Long, Length As Long
    max = RPGCCountNum(heapId)
    If Index > max - 1 Or Index < 0 Then
        GetNumName = vbNullString
    Else
        Dim inBuf As String * 4024
        Length = RPGCGetNumName(Index, inBuf, heapId)
        GetNumName = Mid$(inBuf, 1, Length)
    End If
End Function

'=========================================================================
' Get the literal variable at the index passed in
'=========================================================================
Public Function GetLitName(ByVal Index As Integer, ByVal heapId As Long) As String
    On Error Resume Next
    
    Dim max As Long, Length As Long
    max = RPGCCountLit(heapId)
    If Index > max - 1 Or Index < 0 Then
        GetLitName = vbNullString
    Else
        Dim inBuf As String * 4024
        Length = RPGCGetLitName(Index, inBuf, heapId)
        GetLitName = Mid$(inBuf, 1, Length)
    End If
End Function

'=========================================================================
' Kill the numerical variable passed in
'=========================================================================
Public Sub killNum(ByVal varname As String, ByVal heapId As Long)
    On Error Resume Next
    Call RPGCKillNum(UCase$(varname), heapId)
End Sub

'=========================================================================
' Determine if a numerical variable exists
'=========================================================================
Public Function numVarExists(ByVal varname As String, ByVal heapId As Long) As Boolean
    If (LenB(varname) <> 0 And heapId <> 0) Then
        numVarExists = (RPGCNumExists(UCase$(varname), heapId) = 1)
    End If
End Function

'=========================================================================
' Return a numerical variable belonging to a program's value
'=========================================================================
Public Function SearchNumVar(ByVal varname As String, ByRef thePrg As RPGCodeProgram) As Double

    ' If actkrt3 errors out, we'll just check the global heap
    On Error GoTo invalidFrame

    If (thePrg.currentHeapFrame >= 0) Then
        If (numVarExists(varname, thePrg.heapStack(thePrg.currentHeapFrame))) Then
            ' Found on the local heap
            SearchNumVar = GetNumVar(varname, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            ' Not found: use the global heap
            SearchNumVar = GetNumVar(varname, m_globalHeap)
        End If
    Else
        ' No local heap: use global heap
        SearchNumVar = GetNumVar(varname, m_globalHeap)
    End If

    Exit Function

invalidFrame:
    
    ' Don't recurse
    On Error Resume Next

    ' Check the global heap:
    SearchNumVar = GetNumVar(varname, m_globalHeap)

End Function

'=========================================================================
' Return a literal variable belonging to a program's value
'=========================================================================
Public Function SearchLitVar(ByVal varname As String, ByRef thePrg As RPGCodeProgram) As String

    ' If actkrt3 errors out, we'll just check the global heap
    On Error GoTo invalidFrame

    If (thePrg.currentHeapFrame >= 0) Then
        If (litVarExists(varname, thePrg.heapStack(thePrg.currentHeapFrame))) Then
            ' Found on the local heap
            SearchLitVar = GetLitVar(varname, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            ' Not found: use the global heap
            SearchLitVar = GetLitVar(varname, m_globalHeap)
        End If
    Else
        ' No local heap: use global heap
        SearchLitVar = GetLitVar(varname, m_globalHeap)
    End If

    Exit Function

invalidFrame:
    
    ' Don't recurse
    On Error Resume Next

    ' Check the global heap:
    SearchLitVar = GetLitVar(varname, m_globalHeap)

End Function

'=========================================================================
' Create a redirect
'=========================================================================
Public Sub SetRedirect(ByVal originalMethod As String, ByVal targetMethod As String)
    'add to redirect list
    On Error Resume Next
    originalMethod = replace(originalMethod, "#", vbNullString)
    targetMethod = replace(targetMethod, "#", vbNullString)
    Call RPGCSetRedirect(UCase$(originalMethod), UCase$(targetMethod))
End Sub

'=========================================================================
' Return the type of a variable
'=========================================================================
Public Function variType(ByVal var As String, ByVal heapId As Long) As Long

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
        If litVarExists(a$, heapId) Then
            typeIt = 1
        End If
        If numVarExists(a$, heapId) Then
            typeIt = 2
        End If
    End If
    
    If typeIt = 1 Then variType = DT_LIT
    If typeIt = 2 Then variType = DT_NUM

End Function

'=========================================================================
' Set a variable - unattached to a program
'=========================================================================
Public Sub setIndependentVariable(ByVal varname As String, ByVal value As String)
    On Error Resume Next
    Call SetVariable(varname, value, errorKeep)
End Sub

'=========================================================================
' Set a variable optionally forced to the global heap
'=========================================================================
Public Sub SetVariable(ByVal varname As String, ByVal value As String, ByRef theProgram As RPGCodeProgram, Optional ByVal bForceGlobal As Boolean)

    On Error Resume Next

    'Get the variable's name
    Dim theVar As String
    theVar = parseArray(replace(varname, " ", vbNullString), theProgram)

    'Check if it belongs to a class
    If (theProgram.classes.insideClass) Then
        If (isVarMember(theVar, topNestle(theProgram), theProgram)) Then
            ' Get the new name
            theVar = getObjectVarName(theVar, topNestle(theProgram))
            ' All class members are global
            bForceGlobal = True
        End If
    End If

    'Get its type
    Dim varType As RPGC_DT
    varType = variType(theVar, m_globalHeap)

    ' Declare some vars
    Dim rV As RPGCODE_RETURN, exists As Boolean

    If (varType = DT_NUM) Then        'NUMERICAL VARIABLE
                                      '------------------

        ' Check if the variable exists
        exists = numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))

        If (theProgram.autoLocal) And (Not (bForceGlobal)) Then
            If Not (exists) Then
                Call SetNumVar(theVar, 0, theProgram.heapStack(theProgram.currentHeapFrame))
                exists = True
            End If
        End If

        If (theProgram.currentHeapFrame >= 0) And (Not (bForceGlobal)) Then
            If (exists) Then
                ' Local
                Call SetNumVar(theVar, CDbl(value), theProgram.heapStack(theProgram.currentHeapFrame))
            Else
                ' Global
                Call SetNumVar(theVar, CDbl(value), m_globalHeap)
            End If
        Else
            ' Global
            Call SetNumVar(theVar, CDbl(value), m_globalHeap)
        End If

    ElseIf (varType = DT_LIT) Then    'LITERAL VARIABLE
                                      '----------------

        ' Check if the variable exists
        exists = litVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))

        If (theProgram.autoLocal) And (Not (bForceGlobal)) Then
            If Not (exists) Then
                Call SetLitVar(theVar, vbNullString, theProgram.heapStack(theProgram.currentHeapFrame))
                exists = True
            End If
        End If

        If (theProgram.currentHeapFrame >= 0) And (Not (bForceGlobal)) Then
            If (exists) Then
                ' Local
                Call SetLitVar(theVar, value, theProgram.heapStack(theProgram.currentHeapFrame))
            Else
                ' Global
                Call SetLitVar(theVar, value, m_globalHeap)
            End If
        Else
            ' Global
            Call SetLitVar(theVar, value, m_globalHeap)
        End If

    End If

End Sub

'=========================================================================
' Get the value of a variable
'=========================================================================
Public Function getVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram, Optional ByVal bTakeNumPath As Boolean) As RPGC_DT

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
    theVar = parseArray(replace(varname, " ", vbNullString), theProgram)

    ' Check if it belongs to a class
    If (theProgram.classes.insideClass) Then
        If (isVarMember(theVar, topNestle(theProgram), theProgram)) Then
            theVar = getObjectVarName(theVar, topNestle(theProgram))
        End If
    End If

    ' Create an rpgcode return value
    Dim rV As RPGCODE_RETURN

    ' Get the var's type
    Dim varType As RPGC_DT
    varType = variType(theVar, m_globalHeap)
    getVariable = varType

    Dim tdc As String
    tdc = RightB$(theVar, 2)
    If ((tdc <> "!") And (tdc <> "$")) Then
        If Not (numVarExists(theVar, m_globalHeap)) Then
            If Not (numVarExists(theVar, theProgram.heapStack(theProgram.currentHeapFrame))) Then
                ' Get value of the destination
                Dim litA As String, numA As Double
                theVar = theVar & "!"
                Call getValue(theVar, litA, numA, theProgram)
                ' If it's not NULL
                If (numA) Then
                    ' Check if it's already an object
                    If (isObject(numA)) Then
                        ' It is; we may need to handle an overloaded ! or $
                        Dim hClass As Long
                        hClass = CLng(numA)
                        ' Check if it exists
                        If (isMethodMember("operator!", hClass, theProgram, isOutside(hClass, theProgram))) Then
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
                        ElseIf Not (bTakeNumPath) Then
                            If (isMethodMember("operator$", hClass, theProgram, isOutside(hClass, theProgram))) Then
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
                            End If ' isMethodMember
                        End If ' Not (bTakeNumPath)
                    End If ' isObject
                End If ' (numA <> 0)
            End If ' Not numVarExists
        End If ' Not numVarExists
    End If ' ((tdc <> "!") And (tdc <> "$"))

    If (varType = DT_VOID) Then
        ' If there was an error, just exit this function
        Exit Function
    End If

    If (varType = DT_NUM) Then      'NUMERICAL VARIABLE
                                    '------------------

        num = SearchNumVar(theVar, theProgram)

    ElseIf (varType = DT_LIT) Then  'LITERAL VARIABLE
                                    '----------------

        lit = SearchLitVar(theVar, theProgram)

    End If

End Function

'=========================================================================
' Initiate the variable system
'=========================================================================
Public Sub initVarSystem()

    On Error GoTo anErr

    Call RPGCInit
    m_globalHeap = RPGCCreateHeap()
    Call initRPGCodeClasses
    Call buildSignArrays
    Call SetVariable("true", 1, errorKeep, True)
    Call SetVariable("false", 0, errorKeep, True)

    Exit Sub

anErr:
    Call MsgBox("Cannot initialize heap system-- get the latest actkrt3.dll")
    gGameState = GS_QUIT
End Sub

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
Public Function SetNumVar(ByVal varname As String, ByVal val As Double, ByVal heapId As Long) As Long
    On Error Resume Next
    SetNumVar = RPGCSetNumVar(UCase$(varname), val, heapId)
End Function

'=========================================================================
' Set a literal variable
'=========================================================================
Public Function SetLitVar(ByVal varname As String, ByVal val As String, ByVal heapId As Long) As Long
    On Error Resume Next
    SetLitVar = RPGCSetLitVar(UCase$(varname), val, heapId, LenB(val))
End Function

'=========================================================================
' Get a numerical variable
'=========================================================================
Public Function GetNumVar(ByVal varname As String, ByVal heapId As Long) As Double
    On Error Resume Next
    GetNumVar = RPGCGetNumVar(UCase$(varname), heapId)
End Function

'=========================================================================
' Get a literal variable
'=========================================================================
Public Function GetLitVar(ByVal varname As String, ByVal heapId As Long) As String
    Dim var As String, varLen As Long, valLen As Long
    var = UCase$(varname)
    If (RPGCLitExists(var, heapId)) Then
        varLen = RPGCGetLitVarByteLen(var, heapId)
        GetLitVar = LeftB$(RPGCGetLitVar(var, heapId), varLen)
        valLen = varLen - LenB(GetLitVar)
        If (valLen) Then
            GetLitVar = GetLitVar & String$(valLen * 0.5, vbNullChar)
        End If
    End If
End Function
