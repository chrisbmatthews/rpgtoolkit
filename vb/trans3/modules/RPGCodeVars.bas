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
Public Declare Function RPGCEvaluate Lib "actkrt3.dll" (ByVal equation As String) As Double

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

    'Check if we have a command
    For p = 1 To Length
        part = Mid(Text, p, 1)
        If part = Chr(34) Then
            Exit For
        ElseIf (part = "(") Or (part = "#") Then
            dType = DT_COMMAND
            Exit For
        End If
    Next p

    'Haven't got it yet; check right most character for type character (! or $)
    If dType = -1 Then
        part = Right(Trim(replaceOutsideQuotes(Text, vbTab, "")), 1)
        If part = "$" Then
            dType = DT_LIT
        ElseIf part = "!" Then
            dType = DT_NUM
        End If
    End If

    'Still haven't got it, resort to error handling
    If dType = -1 Then

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
        If equType = -1 Then
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
    
    originalMethod = UCase$(removeChar(originalMethod, "#"))
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
    methodName = UCase(removeChar(methodName, "#"))
    Call RPGCKillRedirect(methodName)
End Sub

'=========================================================================
' Determine if a redirect exists for the text passed in
'=========================================================================
Public Function redirectExists(ByVal methodToCheck As String) As Boolean
    On Error Resume Next
    Dim a As Long
    methodToCheck = removeChar(methodToCheck, "#")
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
    Dim tSigns(5) As String     'Math signs array
    Dim uD() As String          'Delimiters that were used (dummy)
    Dim dt As Long              'Data type
    Dim a As Long               'Loop control variables

    litOrNum = DT_VOID
 
    'Make sure we were passed data...
    lineText = Trim(lineText)
    If lineText = "" Then Exit Function
 
    If Left(lineText, 1) = "-" Then
        'Probably a negative number...
        Exit Function
    End If
 
    'Populate the tSigns() array...
    tSigns(0) = "+"
    tSigns(1) = "-"
    tSigns(2) = "/"
    tSigns(3) = "*"
    tSigns(4) = "^"
    tSigns(5) = "\"

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
                .num = RPGCEvaluate(equ)
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
    originalMethod = removeChar(originalMethod, "#")
    targetMethod = removeChar(targetMethod, "#")
    Call RPGCSetRedirect(UCase$(originalMethod), UCase$(targetMethod))
End Sub

'=========================================================================
' Return the type of a variable
'=========================================================================
Public Function variType(ByVal var As String, ByVal heapID As Long) As Long

    On Error GoTo errorhandler
    
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

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
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
    On Error GoTo setvarerr
    Dim a As String, v As String, chat As Long, arrayElem As String, postFix As String, prefix As String
    Dim lit As String, num As Double, tpe As Long, vv As String, vtype As Long, aa As Double
    
    a = varname
    a = removeChar(a, " ")
    v = value
    'make sure v is valid:
    chat = Asc(Mid$(v$, 1, 1))
    If chat < 32 Then v$ = ""

    a = parseArray(a, theProgram)
   
    vtype = variType(a$, globalHeap)
    
    Dim errorsA As Long, valUse As Double

    'ADDED BY KSNiloc... [Backwards Compatability]
    If v = "SPACE" Then v = " "

    'KSNiloc...
    Dim rV As RPGCODE_RETURN
    
    If vtype = -1 Then
    'undefined- try to figure out data type
        aa = CDbl(value$)
        If errorsA = 1 Then
            'if that produced an error, it's literal
            vtype = 1
            errorsA = 0
        Else
            vtype = 0
        End If
    End If
    
    If bRPGCStarted Then
        'using the c++ dll
        If vtype = 0 Then
            'numerical
            
            'KSNiloc...
            If (Not numVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            valUse = val(v$)
            'first try to set it to the local heap...
            If theProgram.currentHeapFrame >= 0 And Not (bForceGlobal) Then
                If numVarExists(a$, theProgram.heapStack(theProgram.currentHeapFrame)) Then
                    'a local variable exists.
                    'set it...
                    Call SetNumVar(a$, valUse, theProgram.heapStack(theProgram.currentHeapFrame))
                Else
                    'assume it must be global...
                    Call SetNumVar(a$, valUse, globalHeap)
                End If
            Else
                Call SetNumVar(a$, valUse, globalHeap)
            End If
        End If
        If vtype = 1 Then
            'literal

            'KSNiloc...
            If (Not litVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            'first try to set it to the local heap...
            If theProgram.currentHeapFrame >= 0 And Not (bForceGlobal) Then
                If litVarExists(a$, theProgram.heapStack(theProgram.currentHeapFrame)) Then
                    'a local variable exists.
                    'set it...
                    Call SetLitVar(a$, v$, theProgram.heapStack(theProgram.currentHeapFrame))
                Else
                    'assume it must be global...
                    Call SetLitVar(a$, v$, globalHeap)
                End If
            Else
                Call SetLitVar(a$, v$, globalHeap)
            End If
        End If

    End If

    Exit Sub

setvarerr:
    errorsA = 1
    Resume Next
End Sub

'=========================================================================
' Get the value of a variable
'=========================================================================
Public Function getVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As RPGC_DT

    On Error GoTo errorhandler

    Dim a As String, arrayElem As String, postFix As String, prefix As String, tpe As Long, v As String
    Dim typeVar As Long

    Select Case Trim(LCase(varname))

        Case "gametime!"
            Call updateGameTime
            num = gameTime
            getVariable = DT_NUM
            Exit Function
            
        Case "cnvrendernow!"
            num = cnvRenderNow
            getVariable = DT_NUM
            Exit Function

    End Select

    a = parseArray(removeChar(varname, " "), theProgram)

    Dim rV As RPGCODE_RETURN
    typeVar = variType(a$, globalHeap)
    If typeVar = -1 Then getVariable = -1

    If bRPGCStarted Then
        'using the c++ dll
        If typeVar = 0 Then
            'numerical

            'KSNiloc...
            If (Not numVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            num = SearchNumVar(a$, theProgram)
            getVariable = 0
        End If
        If typeVar = 1 Then
            'literal

            'KSNiloc...
            If (Not litVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            lit$ = SearchLitVar(a$, theProgram)
            getVariable = 1
        End If
  
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
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
