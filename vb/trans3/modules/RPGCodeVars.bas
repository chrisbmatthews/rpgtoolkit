Attribute VB_Name = "RPGCodeVars"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'rpgcode variable interface.
Option Explicit

Public bRPGCStarted As Boolean

Public globalHeap As Long   'the ID of the global heap

Public maxNum As Long, maxLit As Long      'the maximum numerical and literal indices


'decares for actkrt3.dll

Declare Function RPGCInit Lib "actkrt3.dll" () As Long

Declare Function RPGCShutdown Lib "actkrt3.dll" () As Long

Declare Function RPGCCreateHeap Lib "actkrt3.dll" () As Long

Declare Function RPGCDestroyHeap Lib "actkrt3.dll" (ByVal heapID As Long) _
 As Long

Declare Function RPGCSetNumVar Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal value As Double, ByVal heapID As Long) As Long

Declare Function RPGCSetLitVar Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal value As String, ByVal heapID As Long) As Long

Declare Function RPGCGetNumVar Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal heapID As Long) As Double

Declare Function RPGCGetLitVar Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal inSpaceAllocated As String, ByVal heapID As Long) As Long

Declare Function RPGCGetLitVarLen Lib "actkrt3.dll" (ByVal varName As _
 String, ByVal heapID As Long) As Long

Declare Function RPGCCountNum Lib "actkrt3.dll" (ByVal heapID As Long) As Long

Declare Function RPGCCountLit Lib "actkrt3.dll" (ByVal heapID As Long) As Long

Declare Function RPGCGetNumName Lib "actkrt3.dll" (ByVal nItrOffset As _
 Long, ByVal pstrToVal As String, ByVal heapID As Long) As Long

Declare Function RPGCGetLitName Lib "actkrt3.dll" (ByVal nItrOffset As _
 Long, ByVal pstrToVal As String, ByVal heapID As Long) As Long

Declare Function RPGCClearAll Lib "actkrt3.dll" (ByVal heapID As Long) As Long

Declare Function RPGCKillNum Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal heapID As Long) As Long

Declare Function RPGCKillLit Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal heapID As Long) As Long

Declare Function RPGCNumExists Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal heapID As Long) As Long

Declare Function RPGCLitExists Lib "actkrt3.dll" (ByVal varName As String, _
 ByVal heapID As Long) As Long

'redirect list...
Declare Function RPGCSetRedirect Lib "actkrt3.dll" (ByVal methodOrig As _
 String, ByVal methodTarget As String) As Long

Declare Function RPGCRedirectExists Lib "actkrt3.dll" (ByVal methodToCheck _
 As String) As Long

Declare Function RPGCGetRedirect Lib "actkrt3.dll" (ByVal methodToGet As _
 String, ByVal pstrToVal As String) As Long

Declare Function RPGCKillRedirect Lib "actkrt3.dll" (ByVal pstrMethod As _
 String) As Long

Declare Function RPGCGetRedirectName Lib "actkrt3.dll" (ByVal nItrOffset _
 As Long, ByVal pstrToVal As String) As Long

Declare Function RPGCClearRedirects Lib "actkrt3.dll" () As Long

Declare Function RPGCCountRedirects Lib "actkrt3.dll" () As Long



Function GetIndependentVariable(ByVal varName As String, ByRef lit As String, ByRef num As Double) As Long
    'gets a variable value.
    'kinda strange usage:
    'it returns 0 or 1 of it's a numerical or literal, respectively
    'returns -1 if it doesn't know
    'Directly changes values of passed variables lit$ and num
    'to give you the value
    'So:
    '  a=getvariable("test!",a$,b)
    '  would set *b* to the value since it is a numerical variable

    'Does not pass in a program, so this is independent from a program
    Dim aProgram As RPGCodeProgram
    aProgram.boardNum = -1
    Call InitRPGCodeProcess(aProgram)
    
    GetIndependentVariable = GetVariable(varName$, lit$, num, aProgram)
    
    Call ClearRPGCodeProcess(aProgram)
End Function

Sub ClearRedirects()
    'clear all redirects
    On Error Resume Next
    Dim a As Long
    a = RPGCClearRedirects
End Sub

Function dataType( _
                     ByVal Text As String, _
                     Optional ByRef equType As dtType = -1 _
                                                             ) As Long

    'MODIFIED BY KSNILOC
    
    'returns data type of text$
    '0- Numerical var, 1- lit var, 2- text, 3- number 5-equation
    On Error GoTo datatypeerr
    Dim length As Long, dType As Long, p As Long, part As String, a As Double, errorsA As Long
    length = Len(Text$)
    dType = -1
    
    'first check if it's a command...
    For p = 1 To length
        part$ = Mid$(Text$, p, 1)
        If part$ = chr$(34) Then
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
        For p = 1 To length
            part$ = Mid$(Text$, p, 1)
            If part$ = chr$(34) Then
                dType = 2
                'p = length
            End If
            If part$ = "$" Then
                dType = 1
                'p = length
            End If
            If part$ = "!" Then
                dType = 0
                'p = length
            End If
        Next p
    End If
    
    If dType = -1 Then
        a = CDbl(Text$)
        If errorsA = 1 Then
            errorsA = 0
            dType = 2
        Else
            dType = 3
        End If
    End If

    'Maybe it's an equation...
    Dim equResult As Long
    If isEquation(Text, equResult) Then
        dType = DT_EQUATION
        If equType = -1 Then
            dType = equResult
        Else
            equType = equResult
        End If
    End If
    
    dataType = dType
    
    'If text = "5+5" Then MsgBox "...here?": MsgBox dataType
    
Exit Function

datatypeerr:
    errorsA = 1
    Resume Next
Exit Function
End Function

Function GetRedirect(ByVal originalMethod As String) As String
    'get the redirected method name.
    On Error Resume Next
    Dim length As Long
    
    originalMethod = UCase$(removeChar(originalMethod, "#"))
    If RedirectExists(originalMethod) Then
        Dim getStr As String * 4048
        length = RPGCGetRedirect(originalMethod, getStr)
        If length = 0 Then
            GetRedirect = originalMethod
            Exit Function
        End If
        GetRedirect = Mid$(getStr, 1, length)
    Else
        GetRedirect = ""
    End If
End Function

Function GetRedirectName(ByVal Index As Long) As String
    'get the index-th redirect name
    On Error Resume Next
    
    Dim max As Long
    Dim length As Long
    max = RPGCCountRedirects()
    If Index > max - 1 Or Index < 0 Then
        GetRedirectName = ""
    Else
        Dim inBuf As String * 4024
        length = RPGCGetRedirectName(Index, inBuf)
        GetRedirectName = Mid$(inBuf, 1, length)
    End If
End Function

Sub KillRedirect(ByVal methodName As String)
    'kill redirect
    On Error Resume Next
    Dim a As Long
    methodName = UCase$(removeChar(methodName, "#"))
    a = RPGCKillRedirect(methodName)
End Sub

Function RedirectExists(ByVal methodToCheck As String) As Boolean
    'check if a redirect exists
    On Error Resume Next
    Dim a As Long
    methodToCheck = removeChar(methodToCheck, "#")
    a = RPGCRedirectExists(UCase$(methodToCheck))
    If a = 1 Then
        RedirectExists = True
    Else
        RedirectExists = False
    End If
End Function

Public Function isEquation( _
                              ByVal lineText As String, _
                              ByRef litOrNum As dtType _
                                                         ) As Boolean

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[6/20/04]

 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 'Detects if what was passed in was an RPGCode equation '
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''

 On Error GoTo error

 'Declarations...
 Dim parts() As String
 Dim tSigns(5) As String
 Dim ud() As String
 Dim dt As Long
 Dim a As Long
 
 litOrNum = dtVoid
 
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
 parts() = multiSplit(lineText, tSigns, ud, True)

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
   Case DT_COMMAND
    dt = DT_COMMAND
    Exit For
  End Select
 Next a
 
 litOrNum = dt
 
 'Make sure there's nothing literal in the array...
 'For a = 0 To UBound(parts)
 ' dt = dataType(parts(a))
 ' If Not dt = 0 Then
 '  If Not dt = 3 Then
 '   If Not dt = DT_COMMAND Then
 '    isEquation = False
 '    Exit Function
 '   End If
 '  End If
 ' End If
 'Next a
 
 'If we made it here then it's an equation...
 isEquation = True
 
 Exit Function
 
error:
 HandleError
 Resume Next
 
wrongType:
 'debugger "All elements must be the same type-- " & lineText
End Function

Public Function RPGCodeEquation( _
                                   ByVal equ As String, _
                                   ByRef prg As RPGCodeProgram, _
                                   ByRef litOrNum As dtType _
                                                              ) As Parameters

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[6/20/04]

 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 'Evaluates an RPGCode equation and returns the value '
 'res = RPGCodeEquation("5 + 5", theProgram,dtNum)    '
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''

 RPGCodeEquation.dataType = litOrNum

 'Use a crazily named variable to prevent overwriting
 'an existing one...
 Dim tempVar As String
 Select Case litOrNum
 
  Case dtNum
   tempVar = "superlongvariablenobodyintheirright3456hjkchJHKJHKJHsdfsd" _
    & "mindwouldeverdreamofusingeveniftheywereinsanesdfdsfsdfdshkjhjkh!"
  Case dtLit
   tempVar = "superlongvariablenobodyintheirright345643hdkh345435jkhkjh" _
    & "mindwouldeverdreamofusingeveniftheywereinsane3245325dfgdsdfg734$"

  Case DT_COMMAND
   'It's a command so we don't know what of value it's going to return.
   'Try both!
   
   Dim testType(1) As Parameters
   testType(0) = RPGCodeEquation(equ, prg, dtLit)
   testType(1) = RPGCodeEquation(equ, prg, dtNum)
     
   'Check if one of them returned something useable...
   If Not testType(0).lit = "" Then
    'We've got a good string here
    RPGCodeEquation.dataType = dtLit
    RPGCodeEquation.num = testType(0).lit
    litOrNum = dtLit
        
   ElseIf Not testType(1).num = 0 Then
    'We've got a good number here
    RPGCodeEquation.dataType = dtNum
    RPGCodeEquation.num = testType(1).num
    litOrNum = dtNum

   Else
    'Ahhhhhh~ there's nothing useable here!
     RPGCodeEquation.dataType = dtVoid
     litOrNum = dtVoid
        
   End If
   
   Exit Function

  Case 6
   ' ++,--,-=,+=
   Dim oPP As Long
   Dim rV As RPGCODE_RETURN
   oPP = prg.programPos
   DoSingleCommand equ, prg, rV
   prg.programPos = oPP
   RPGCodeEquation.dataType = dtNum
   RPGCodeEquation.num = CBGetNumerical(GetVarList(equ, 1))
   litOrNum = dtNum
   Exit Function

 End Select
 
 'Evaluate the equation using RPGCode...
 VariableManip "#" & tempVar & " = " & equ, prg, True

 'Use a plugin callback to get the variable's value in
 'as little code as possible...
 Select Case litOrNum
  Case dtNum
   RPGCodeEquation.num = CBGetNumerical(tempVar)
  Case dtLit
   RPGCodeEquation.lit = CBGetString(tempVar)
 End Select

 'Kill our little temp variable...
 KillRPG "Kill(" & tempVar & ")", prg
 
End Function

Function GetValue(ByVal Text As String, ByRef lit As String, _
 ByRef num As Double, ByRef theProgram As RPGCodeProgram) As dtType
 
'gets value of text- be it literal, numerical or a var
'returns data type: 0-num, 1-lit

    '''''''''''''''''''''''''''
    '   Modified by KSNiloc   '
    '''''''''''''''''''''''''''
    '[5/28/04]
    '[6/20/04]
    
    '''''''
    'Notes'
    '''''''
    '+ Now returns "dtType" rather than "long"
    '+ Now evaluates equations
    
    On Error GoTo errorhandler
    
    Dim dType As Long, aa As Long, numa As Double, lita As String, p As Long, part As String
    Dim length As Long, checkIt As Long, newPos As Long, sendText As String
    
    Dim EquTyp As dtType
    dType = dataType(Text, EquTyp)
  
    Select Case dType
        Case DT_NUM:
            'numerical var
            aa = GetVariable(Text$, lita$, numa, theProgram)
            If aa = 0 Then
                num = numa
                GetValue = 0
                Exit Function
            Else
                num = 0
                GetValue = 0
                Exit Function
            End If
        Case DT_LIT:
            'literal var
            aa = GetVariable(Text$, lita$, numa, theProgram)
            If aa = 1 Then
                lit$ = lita$
                GetValue = 1
                Exit Function
            Else
                lit$ = ""
                GetValue = 1
                Exit Function
            End If
        Case 2:
            length = Len(Text$)
            For p = 1 To length
                part$ = Mid$(Text$, p, 1)
                If part$ = chr$(34) Then checkIt = 1
            Next p
            If checkIt = 1 Then
                'it's in quotes!
                For p = 1 To length
                    part$ = Mid$(Text$, p, 1)
                    If part$ = chr$(34) Then newPos = p: p = length
                Next p
                For p = newPos + 1 To length
                    part$ = Mid$(Text$, p, 1)
                    If part$ = chr$(34) Or part$ = "" Then
                        lit$ = sendText$
                        GetValue = 1
                        Exit Function
                    Else
                        sendText$ = sendText$ + part$
                    End If
                Next p
            Else
                lit$ = Text$
                GetValue = 1
                Exit Function
            End If
    
        Case 3:
            num = val(Text$)
            GetValue = 0
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
                GetValue = GetValue(retval.lit, lit$, num, theProgram)
            Else
                GetValue = GetValue(str$(retval.num), lit$, num, theProgram)
            End If
            
        Case DT_EQUATION
            'It's an equation!
            Dim equVal As Parameters
            equVal = RPGCodeEquation(Text, theProgram, EquTyp)
            Select Case equVal.dataType
                Case dtNum
                    num = equVal.num
                Case dtLit
                    lit = equVal.lit
            End Select
            GetValue = equVal.dataType

    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function LitVarExists(ByVal varName As String, ByVal heapID As Long) As Boolean
    'determine if a var exists
    On Error Resume Next
    Dim r As Long
    If varName <> "" Then
        r = RPGCLitExists(UCase$(varName), heapID)
        If r = 1 Then
            LitVarExists = True
        Else
            LitVarExists = False
        End If
    Else
        LitVarExists = False
    End If
End Function

Sub KillLit(ByVal varName As String, ByVal heapID As Long)
    'kill a var
    On Error Resume Next
    Dim a As Long
    a = RPGCKillLit(UCase$(varName), heapID)
End Sub

Sub ClearVars(ByVal heapID As Long)
    On Error Resume Next
    'clear all vars
    'use with caution...
    Dim a As Long
    a = RPGCClearAll(heapID)
End Sub

Function GetNumName(ByVal Index As Integer, ByVal heapID As Long) As String
    'get the index-th numerical variable name
    On Error Resume Next
    
    Dim max As Long, length As Long
    max = RPGCCountNum(heapID)
    If Index > max - 1 Or Index < 0 Then
        GetNumName = ""
    Else
        Dim inBuf As String * 4024
        length = RPGCGetNumName(Index, inBuf, heapID)
        GetNumName = Mid$(inBuf, 1, length)
    End If
End Function

Function GetLitName(ByVal Index As Integer, ByVal heapID As Long) As String
    'get the index-th literal variable name
    On Error Resume Next
    
    Dim max As Long, length As Long
    max = RPGCCountLit(heapID)
    If Index > max - 1 Or Index < 0 Then
        GetLitName = ""
    Else
        Dim inBuf As String * 4024
        length = RPGCGetLitName(Index, inBuf, heapID)
        GetLitName = Mid$(inBuf, 1, length)
    End If
End Function


Sub KillNum(ByVal varName As String, ByVal heapID As Long)
    'kill a var
    On Error Resume Next
    Dim a As Long
    a = RPGCKillNum(UCase$(varName), heapID)
End Sub

Function NumVarExists(ByVal varName As String, ByVal heapID As Long) As Boolean
    'determine if a var exists
    On Error Resume Next
    Dim r As Long
    If varName <> "" Then
        r = RPGCNumExists(UCase$(varName), heapID)
        If r = 1 Then
            NumVarExists = True
        Else
            NumVarExists = False
        End If
    Else
        NumVarExists = False
    End If
End Function

Function SearchNumVar(ByVal varName As String, ByRef thePrg As RPGCodeProgram) As Double
    'search for a numerical variable belonging to thePrg
    On Error Resume Next
    'first search the local heap...
    If thePrg.currentHeapFrame >= 0 Then
        If NumVarExists(varName, thePrg.heapStack(thePrg.currentHeapFrame)) Then
            'try local heap...
            SearchNumVar = GetNumVar(varName, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            'try global heap...
            SearchNumVar = GetNumVar(varName, globalHeap)
        End If
    Else
        'obtain from global heap...
        SearchNumVar = GetNumVar(varName, globalHeap)
    End If
End Function

Function SearchLitVar(ByVal varName As String, ByRef thePrg As RPGCodeProgram) As String
    'search for a string variable belonging to thePrg
    On Error Resume Next
    'first search the local heap...
    If thePrg.currentHeapFrame >= 0 Then
        If LitVarExists(varName, thePrg.heapStack(thePrg.currentHeapFrame)) Then
            'try local heap...
            SearchLitVar = GetLitVar(varName, thePrg.heapStack(thePrg.currentHeapFrame))
        Else
            'try global heap...
            SearchLitVar = GetLitVar(varName, globalHeap)
        End If
    Else
        'obtain from global heap...
        SearchLitVar = GetLitVar(varName, globalHeap)
    End If
End Function


Sub SetRedirect(ByVal originalMethod As String, ByVal targetMethod As String)
    'add to redirect list
    On Error Resume Next
    Dim a As Long
    originalMethod = removeChar(originalMethod, "#")
    targetMethod = removeChar(targetMethod, "#")
    a = RPGCSetRedirect(UCase$(originalMethod), UCase$(targetMethod))
End Sub

Function varitype(var$, ByVal heapID As Long) As Long
    'returns what type the variable is:
    '0- numerical, 1- literal, -1 if it cannot tell
    On Error GoTo errorhandler
    
    Dim a As String, length As Long, pos As Long, typeIt As Long, part As String
    a$ = var$
    length = Len(a$)
    For pos = 1 To length
        part$ = Mid$(a$, pos, 1)
        If part$ = "$" Then typeIt = 1
        If part$ = "!" Then typeIt = 2
    Next pos
    If typeIt = 0 Then
        'If we didn't find out what type it was, we have to
        'search the records to see
        'LITERAL:
        If LitVarExists(a$, heapID) Then
            typeIt = 1
        End If
        If NumVarExists(a$, heapID) Then
            typeIt = 2
        End If
    End If
    
    If typeIt = 1 Then varitype = 1
    If typeIt = 2 Then varitype = 0
    If typeIt = 0 Then varitype = -1

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub setIndependentVariable(varName$, value$)
    On Error Resume Next
    'Sets a varibale to a specific value
    Dim aProgram As RPGCodeProgram
    aProgram.boardNum = -1
    Call InitRPGCodeProcess(aProgram)
    Call SetVariable(varName$, value$, aProgram)
    Call ClearRPGCodeProcess(aProgram)
End Sub

Sub SetVariable(ByVal varName As String, ByVal value As String, ByRef theProgram As RPGCodeProgram, Optional ByVal bForceGlobal As Boolean = False)
    On Error GoTo setvarerr
    'Sets a varibale to a specific value
    'if bForceGlobal, forces it to set to the global heap
    Dim a As String, v As String, chat As Long, arrayElem As String, postFix As String, prefix As String
    Dim lit As String, num As Double, tpe As Long, vv As String, vtype As Long, aa As Double
    
    a$ = varName$
    a$ = removeChar(a$, " ")
    v$ = value$
    'make sure v is valid:
    chat = Asc(Mid$(v$, 1, 1))
    If chat < 32 Then v$ = ""

    ''''''''''''''''''''''''''
    '    Added by KSNiloc    '
    ''''''''''''''''''''''''''
    '[5/24/04]

    a = parseArray(a, theProgram)

    ''''''''''''''''''''''''''
    '      End Addition      '
    ''''''''''''''''''''''''''

    If setReservedStructure(varName, value, theProgram) Then Exit Sub
    
    vtype = varitype(a$, globalHeap)
    
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
            If (Not NumVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            valUse = val(v$)
            'first try to set it to the local heap...
            If theProgram.currentHeapFrame >= 0 And Not (bForceGlobal) Then
                If NumVarExists(a$, theProgram.heapStack(theProgram.currentHeapFrame)) Then
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
            If (Not LitVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            'first try to set it to the local heap...
            If theProgram.currentHeapFrame >= 0 And Not (bForceGlobal) Then
                If LitVarExists(a$, theProgram.heapStack(theProgram.currentHeapFrame)) Then
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
        
        ''''''''''''''''''''''''''
        '    Added by KSNiloc    '
        ''''''''''''''''''''''''''
        '[5/24/04]
    
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
                    RPGCode = "#" & fromClass & "." & propCall & "_Set(" & CStr(valUse) & ")"
                Case DT_LIT
                    RPGCode = "#" & fromClass & "." & propCall & "_Set(""" & v$ & """)"
            End Select
            DoIndependentCommand RPGCode, passData
            DecreaseClassNestle
        End If
    
        ''''''''''''''''''''''''''
        '      End Addition      '
        ''''''''''''''''''''''''''
        
    End If
    
Exit Sub
setvarerr:
errorsA = 1
Resume Next
End Sub


Function GetVariable(ByVal varName As String, ByRef lit As String, ByRef num As Double, ByRef theProgram As RPGCodeProgram) As Long
    'gets a variable value.
    'kinda strange usage:
    'it returns 0 or 1 of it's a numerical or literal, respectively
    'returns -1 if it doesn't know
    'Directly changes values of passed variables lit$ and num
    'to give you the value
    'So:
    '  a=getvariable("test!",a$,b)
    '  would set *b* to the value since it is a numerical variable
    On Error GoTo errorhandler
    Dim a As String, arrayElem As String, postFix As String, prefix As String, tpe As Long, v As String
    Dim typeVar As Long
    
    a$ = varName$
    a$ = removeChar(a$, " ")
    
    ''''''''''''''''''''''''''
    '    Added by KSNiloc    '
    ''''''''''''''''''''''''''
    '[5/24/04]
    
    a$ = parseArray(a$, theProgram)
    
    ''''''''''''''''''''''''''
    '      End Addition      '
    ''''''''''''''''''''''''''

    ' KSNiloc...
    Dim rV As RPGCODE_RETURN

    typeVar = varitype(a$, globalHeap)
    If typeVar = -1 Then GetVariable = -1
    
    If bRPGCStarted Then
        'using the c++ dll
        If typeVar = 0 Then
            'numerical

            'KSNiloc...
            If (Not NumVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            num = SearchNumVar(a$, theProgram)
            GetVariable = 0
        End If
        If typeVar = 1 Then
            'literal

            'KSNiloc...
            If (Not LitVarExists(a, theProgram.heapStack(theProgram.currentHeapFrame))) And (theProgram.autoLocal) Then
                LocalRPG "Local(" & a & ")", theProgram, rV
            End If
            
            lit$ = SearchLitVar(a$, theProgram)
            GetVariable = 1
        End If
        
        ''''''''''''''''''''''''''
        '    Added by KSNiloc    '
        ''''''''''''''''''''''''''
        '[5/24/04]
    
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
    
        ''''''''''''''''''''''''''
        '      End Addition      '
        ''''''''''''''''''''''''''
        
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function InitVarSystem() As Boolean
    'init tkrpgc.dll
    On Error GoTo anErr
    
    Dim a As Long
    a = RPGCInit()
    bRPGCStarted = True
    InitVarSystem = bRPGCStarted
    globalHeap = RPGCCreateHeap()
    Exit Function
    
anErr:
    bRPGCStarted = False
    InitVarSystem = bRPGCStarted
    MsgBox "Cannot initialize heap system."
    gGameState = GS_QUIT
End Function

Sub ShutdownVarSystem()
    On Error Resume Next
    
    Dim a As Long
    a = RPGCShutdown()
End Sub


Function SetNumVar(ByVal varName As String, ByVal val As Double, ByVal heapID As Long) As Long
    'set numerical var.
    On Error Resume Next
    SetNumVar = RPGCSetNumVar(UCase$(varName), val, heapID)
End Function

Function SetLitVar(ByVal varName As String, ByVal val As String, ByVal heapID As Long) As Long
    'set literal var.
    On Error Resume Next
    SetLitVar = RPGCSetLitVar(UCase$(varName), val, heapID)
End Function

Function GetNumVar(ByVal varName As String, ByVal heapID As Long) As Double
    'get numerical var.
    On Error Resume Next
    GetNumVar = RPGCGetNumVar(UCase$(varName), heapID)
End Function


Function GetLitVar(ByVal varName As String, ByVal heapID As Long) As String
    'get literal var.
    On Error Resume Next
    Dim l As Long, length As Long
    
    l = RPGCGetLitVarLen(UCase$(varName), heapID)
    If l > 0 Then
        l = l + 1
        Dim getStr As String * 4048
        length = RPGCGetLitVar(UCase$(varName), getStr, heapID)
        GetLitVar = Mid$(getStr, 1, length)
    Else
        GetLitVar = ""
    End If
End Function

Public Function VarBelongsToClass(ByVal var As String, Optional ByRef theClass As String) As Boolean

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/24/04]
 
 ''''''''
 'Return'
 ''''''''
 'Detects if a variable belongs to a class.
 'Returns true or false.
 
 ''''''''''''
 'Parameters'
 ''''''''''''
 'var is the variable to use
 'theClass is where to place the class it comes from

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

Public Function parseArray(ByVal variable As String, ByRef prg As RPGCodeProgram) As String

    '======================================================================================
    'Array Handler [KSNiloc]
    '======================================================================================
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

    Dim arrayElements() As Parameters
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
            Case dtNum: build = build & CStr(arrayElements(a).num)
            Case dtLit: build = build & """" & arrayElements(a).lit & """"
        End Select

        'Add on a ]
        build = build & "]"

    Next a

    'Pass it back with the type (! or $) on the end
    parseArray = build & variableType

skipError:
End Function
