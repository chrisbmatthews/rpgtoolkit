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

Declare Function RPGCSetRedirect Lib "actkrt3.dll" (ByVal methodOrig As String, ByVal methodTarget As String) As Long
Declare Function RPGCRedirectExists Lib "actkrt3.dll" (ByVal methodToCheck As String) As Long
Declare Function RPGCGetRedirect Lib "actkrt3.dll" (ByVal methodToGet As String, ByVal pstrToVal As String) As Long
Declare Function RPGCKillRedirect Lib "actkrt3.dll" (ByVal pstrMethod As String) As Long
Declare Function RPGCGetRedirectName Lib "actkrt3.dll" (ByVal nItrOffset As Long, ByVal pstrToVal As String) As Long
Declare Function RPGCClearRedirects Lib "actkrt3.dll" () As Long
Declare Function RPGCCountRedirects Lib "actkrt3.dll" () As Long

'=========================================================================
' Get the value of a variable - unattached to a program
'=========================================================================
Public Function getIndependentVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double) As Long
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
   
    On Error GoTo datatypeerr
    Dim Length As Long, dType As RPGC_DT, p As Long, part As String, a As Double, errorsA As Long
    Length = Len(Text$)
    dType = -1
    
    'first check if it's a command...
    For p = 1 To Length
        part$ = Mid$(Text$, p, 1)
        If part$ = Chr$(34) Then
            'if we encounter quotes before we encounter
            '# or ( then it's not a command!
            Exit For
        End If
        If part$ = "(" Or part$ = "#" Then
            dType = DT_COMMAND
            Exit For
        End If
    Next p
    
    'wasn't a command-- try other types
    If dType = -1 Then
        For p = 1 To Length
            part$ = Mid$(Text$, p, 1)
            If part$ = Chr$(34) Then
                dType = DT_STRING
            ElseIf part$ = "$" Then
                dType = DT_LIT
            ElseIf part$ = "!" Then
                dType = DT_NUM
            End If
        Next p
    End If

    If dType = -1 Then
        'Try to change the text to a double
        a = CDbl(Text)
        If errorsA = 1 Then
            'If we got here, it's an error so it must be a string
            dType = DT_STRING
        Else
            'If here, it was successful meaning it's a number
            dType = DT_NUMBER
        End If
    End If

    'Before we leave, check if there is an equation
    Dim equResult As RPGC_DT
    If isEquation(Text, equResult) And _
       (Not ((dType = DT_STRING) And (Not stringContains(Text, Chr(34))))) Then
        dType = DT_EQUATION
        If equType = -1 Then
            dType = equResult
        Else
            equType = equResult
        End If
    End If
    
    dataType = dType
    
    Exit Function

datatypeerr:
    errorsA = 1
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

    On Error GoTo error

    'Declarations...
    Dim parts() As String
    Dim tSigns(5) As String
    Dim uD() As String
    Dim dt As Long
    Dim a As Long

    litOrNum = DT_VOID
 
    'Make sure we were passed data...
    lineText = Trim(lineText)
    If lineText = "" Then Exit Function
 
    If Left(lineText, 1) = "-" Then
        'Probably a negative number...
        Exit Function
    End If
 
    Dim check As String
    check = replace(lineText, " ", "")
    If _
         stringContains(check, "--") Or _
         stringContains(check, "++") Or _
         stringContains(check, "+=") Or _
         stringContains(check, "+-") Or _
         stringContains(check, "-=") Or _
         stringContains(check, "+=") _
                                       Then

        litOrNum = 6
        isEquation = True
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
            Case 0, 3
                If Not dt = DT_NUM Then Err.Raise 0
            Case 1, 2
                If Not dt = DT_LIT Then Err.Raise 0
        End Select
    Next a
 
    litOrNum = dt
 
    'If we made it here then it's an equation...
    isEquation = True
 
    Exit Function
 
error:
    HandleError
    Resume Next

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
    '======================================================================================

    RPGCodeEquation.dataType = litOrNum

    'Use a crazily named variable to prevent overwriting
    'an existing one...
    Dim tempVar As String
    Select Case litOrNum
 
        Case DT_NUM
            tempVar = "superlongvariablenobodyintheirright3456hjkchJHKJHKJHsdfsd" _
            & "mindwouldeverdreamofusingeveniftheywereinsanesdfdsfsdfdshkjhjkh!"
        Case DT_LIT
            tempVar = "superlongvariablenobodyintheirright345643hdkh345435jkhkjh" _
            & "mindwouldeverdreamofusingeveniftheywereinsane3245325dfgdsdfg734$"
  
        Case 6
            ' ++,--,-=,+=
            Dim oPP As Long
            Dim rV As RPGCODE_RETURN
            oPP = prg.programPos
            DoSingleCommand equ, prg, rV
            prg.programPos = oPP
            RPGCodeEquation.dataType = DT_NUM
            RPGCodeEquation.num = CBGetNumerical(GetVarList(equ, 1))
            litOrNum = DT_NUM
            Exit Function

    End Select
 
    'Evaluate the equation using RPGCode...
    Call VariableManip(tempVar & " = " & equ, prg, True)

    'Use a plugin callback to get the variable's value in
    'as little code as possible...
    Select Case litOrNum
        Case DT_NUM
            RPGCodeEquation.num = CBGetNumerical(tempVar)
        Case DT_LIT
            RPGCodeEquation.lit = CBGetString(tempVar)
    End Select

    'Kill our little temp variable...
    Call KillRPG("Kill(" & tempVar & ")", prg)
 
End Function

'=========================================================================
' Gets the value of the text passed
'=========================================================================
Public Function getValue(ByVal Text As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As RPGC_DT

    On Error GoTo errorhandler
    
    Dim dType As Long, aa As Long, numa As Double, lita As String, p As Long, part As String
    Dim Length As Long, checkIt As Long, newPos As Long, sendText As String
    
    Dim EquTyp As RPGC_DT
    dType = dataType(Text, EquTyp)
  
    Select Case dType
        Case DT_NUM:
            'numerical var
            aa = getVariable(Text$, lita$, numa, theProgram)
            If aa = 0 Then
                num = numa
                getValue = 0
                Exit Function
            Else
                num = 0
                getValue = 0
                Exit Function
            End If
        Case DT_LIT:
            'literal var
            aa = getVariable(Text$, lita$, numa, theProgram)
            If aa = 1 Then
                lit$ = lita$
                getValue = 1
                Exit Function
            Else
                lit$ = ""
                getValue = 1
                Exit Function
            End If
        Case 2:
            Length = Len(Text$)
            For p = 1 To Length
                part$ = Mid$(Text$, p, 1)
                If part$ = Chr$(34) Then checkIt = 1
            Next p
            If checkIt = 1 Then
                'it's in quotes!
                For p = 1 To Length
                    part$ = Mid$(Text$, p, 1)
                    If part$ = Chr$(34) Then newPos = p: p = Length
                Next p
                For p = newPos + 1 To Length
                    part$ = Mid$(Text$, p, 1)
                    If part$ = Chr$(34) Or part$ = "" Then
                        lit$ = sendText$
                        getValue = 1
                        Exit Function
                    Else
                        sendText$ = sendText$ + part$
                    End If
                Next p
            Else
                lit$ = Text$
                getValue = 1
                Exit Function
            End If
    
        Case 3:
            num = val(Text$)
            getValue = 0
            Exit Function
            
        Case DT_COMMAND:
            'if it's a command, run the command
            'and return the value it produces...
            Dim retval As RPGCODE_RETURN
            Dim oldPos As Long
            oldPos = theProgram.programPos
            Call DoSingleCommand(Text$, theProgram, retval)
            theProgram.programPos = oldPos
            If retval.dataType = DT_LIT Then
                getValue = getValue(retval.lit, lit$, num, theProgram)
            Else
                getValue = getValue(str$(retval.num), lit$, num, theProgram)
            End If
            
        Case DT_EQUATION
            'It's an equation!
            Dim equVal As parameters
            equVal = RPGCodeEquation(Text, theProgram, EquTyp)
            Select Case equVal.dataType
                Case DT_NUM
                    num = equVal.num
                Case DT_LIT
                    lit = equVal.lit
            End Select
            getValue = equVal.dataType

    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'=========================================================================
' Determine is a literal variable exists
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
    Call HandleError
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

    If setReservedStructure(varname, value, theProgram) Then Exit Sub
    
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

        Dim fromClass As String
        If VarBelongsToClass(a$, fromClass) Then
            IncreaseClassNestle fromClass
            Dim prop As String
            Dim propCall As String
            Dim propData As String
            Dim RPGCode As String
            Dim passData As RPGCODE_RETURN
            prop = ParseAfter(a$, ".")
            propCall = Left(prop, Len(prop) - 1)
            Select Case vtype
                Case DT_NUM
                    RPGCode = fromClass & "." & propCall & "_Set(" & CStr(valUse) & ")"
                Case DT_LIT
                    RPGCode = fromClass & "." & propCall & "_Set(""" & v$ & """)"
            End Select
            DoIndependentCommand RPGCode, passData
            DecreaseClassNestle
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
Public Function getVariable(ByVal varname As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As Long

    On Error GoTo errorhandler

    Dim a As String, arrayElem As String, postFix As String, prefix As String, tpe As Long, v As String
    Dim typeVar As Long
    
    a = varname
    a = removeChar(a, " ")
    a = parseArray(a, theProgram)

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
 
        Dim fromClass As String
        If VarBelongsToClass(a$, fromClass) Then
            IncreaseClassNestle fromClass
            Dim prop As String
            Dim propCall As String
            Dim RPGCode As String
            Dim passData As RPGCODE_RETURN
            prop = ParseAfter(a$, ".")
            propCall = Left(prop, Len(prop) - 1)
            RPGCode = "#" & fromClass & "." & propCall & "_Get()"
            DoIndependentCommand RPGCode, passData
            With passData
                Select Case .dataType
                    Case DT_NUM: num = .num
                    Case DT_LIT: lit$ = .lit
                End Select
            End With
            DecreaseClassNestle
        End If
   
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
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
    Call MsgBox("Cannot initialize heap system.")
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

'=========================================================================
' Determine if a variable belongs to a class
'=========================================================================
Public Function VarBelongsToClass(ByVal var As String, Optional ByRef theClass As String) As Boolean

    'Declare and populate variables...
    Dim dot As Long
    dot = InStr(1, var, ".", vbTextCompare)
    If dot = 0 Then VarBelongsToClass = False: Exit Function
    Dim Class As String
    Class = ParseBefore(var, ".")
    Dim prop As String
    prop = ParseAfter(var, ".")
    Dim from As String
    Dim a As Long
    Dim b As String
 
    'Look through all the instances...
    If IsNonInstanceableClass(Class) Then
        from = Class
    Else
        For a = 0 To ClassMemory
            b = CStr(a)
            If b = "" Then b = "0"
            If LCase(CBGetString("CreatedClasses[" + b + "]$")) = LCase(Class) Then Exit For
            If a = ClassMemory Then VarBelongsToClass = False: Exit Function 'Didn't find it...
        Next a
        'Found it!
        from = CBGetString("CreatedFrom[" + b + "]$") 'what was it created from?
    End If
 
    'Pass the data back...
    VarBelongsToClass = True
    theClass = from
  
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

    If InStr(1, toParse, "[", vbTextCompare) = 0 Then
        'There's not a [ so it's not an array and we're not needed
        Exit Function
    End If

    Dim variableType As String
    'Grab the variable's type (! or $)
    variableType = Right(toParse, 1)

    Dim start As Long
    Dim tEnd As Long

    'See where the first [ is
    start = InStr(1, toParse, "[", vbTextCompare)
    
    Dim variableName As String
    'Grab the variable's name
    variableName = Mid(toParse, 1, start - 1)
    
    'Find the last ]
    tEnd = InStr(1, StrReverse(toParse), "]", vbTextCompare)
    tEnd = Len(toParse) - tEnd + 1

    'Just keep what's inbetween the two
    toParse = Mid(toParse, start + 1, tEnd - start - 1)

    Dim parseArrayD() As String
    'Split it at '][' (bewteen elements)
    parseArrayD() = Split(toParse, "][", , vbTextCompare)

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
            Case DT_LIT: build = build & """" & arrayElements(a).lit & """"
        End Select

        'Add on a ]
        build = build & "]"

    Next a

    'Pass it back with the type (! or $) on the end
    parseArray = build & variableType

skipError:
End Function
