Attribute VB_Name = "tkReg"
'toolkit regsitration file

Global regSysCode As String
Global regSysOwner As String

Global regLocalCode As String
Global regLocalOwner As String

Function testCode(tcode$) As Boolean
    'tests a cd code.
    'YOU MAY NOT DISTRIBUTE THIS INFORMATION!
    'DOING SO WILL RESULT IN THE REVOCATION OF YOUR SOURCE CODE
    'AND TRANS2 LICENSES
    'YOU WILL BE IN VIOLATION OF INTERNATIONAL COPYRIGHT LAWS
    On Error GoTo errorhandler
    
    Length = Len(tcode$)
    If Length <> 13 Then
        testCode = False
        Exit Function
    End If
    
    f$ = Mid$(tcode$, 1, 3)
    If UCase$(f$) <> "TK2" Then
        testCode = False
        Exit Function
    End If
    
    n1 = val(Mid$(tcode$, 4, 1))
    n2 = val(Mid$(tcode$, 7, 1))
    n3 = val(Mid$(tcode$, 10, 1))
    
    If n3 = 0 Then
        testCode = False
        Exit Function
    End If
    
    vv = (n1 + n2) / n3
    If vv <> 3 Then
        testCode = False
        Exit Function
    End If
    
    n1 = val(Mid$(tcode$, 11, 1))
    n2 = val(Mid$(tcode$, 12, 1))
    n3 = val(Mid$(tcode$, 13, 1))
    
    If n3 = 0 Then
        testCode = False
        Exit Function
    End If
    
    vv = (n1 + n2) / n3
    If vv <> 5 Then
        testCode = False
        Exit Function
    End If
    
    testCode = True

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function CheckLocalReg() As Boolean
    'checks if tkr.tkr exists in local dir.
    'loads registration info if so.
    On Error GoTo errorhandler
    
    Dim isItThere As Boolean
    
    isItThere = FileExists("tkr.tkr")
    If (isItThere = False) Then
        CheckLocalReg = False
        Exit Function
    End If
    
    On Error GoTo locer
    
    num = FreeFile
    
    Open ws$ + "tkr.tkr" For Input As #num
        Line Input #num, regLocalCode$
        Line Input #num, regLocalOwner$
    Close #num
    
    isItThere = VerifyCode(regLocalCode$)
    If (isItThere = False) Then
        CheckLocalReg = False
        Exit Function
    End If
    
    CheckLocalReg = True
    Exit Function

locer:
    CheckLocalReg = False
    Close #num
    Exit Function

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function CheckRegistration() As Boolean
    'check c:\windows\system for the registration file.
    'also check local path.
    'return true or false if the tk is properly
    'registered or not.
    On Error GoTo errorhandler
    Dim checkSysFile As Boolean
    Dim checkLocalFile As Boolean
    
    ws$ = SystemDir()
       
    checkSysFile = CheckSystemReg()
    If (checkSysFile = False) Then
        CheckRegistration = False
        Exit Function
    End If
    
    checkLocalFile = CheckLocalReg()
    If (checkLocalFile = False) Then
        CheckRegistration = False
        Exit Function
    End If
    
    If (regSysCode$ = regLocalCode$) Then
        If (regSysOwner$ = regLocalOwner$) Then
            CheckRegistration = True
            Exit Function
        End If
    End If
    
    CheckRegistration = False

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function CheckSystemReg() As Boolean
    'checks if tkr.tkr exists in c:\windows\system.
    'loads registration info if so.
    On Error GoTo errorhandler
    
    Dim isItThere As Boolean
    
    ws$ = SystemDir()
    isItThere = FileExists(ws$ + "tkr.tkr")
    If (isItThere = False) Then
        CheckSystemReg = False
        Exit Function
    End If
    
    On Error GoTo syser
    
    num = FreeFile
    
    Open ws$ + "tkr.tkr" For Input As #num
        Line Input #num, regSysCode$
        Line Input #num, regSysOwner$
    Close #num
    
    isItThere = VerifyCode(regSysCode$)
    If (isItThere = False) Then
        CheckSysReg = False
        Exit Function
    End If
    
    CheckSystemReg = True
    Exit Function

syser:
    CheckSystemReg = False
    Close #num
    Exit Function

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function EncodeCode(code$) As String
    'encodes the reg code...
    On Error GoTo errorhandler
    Length = Len(code$)
    ret$ = ""
    For t = 1 To Length
        part$ = Mid$(code$, t, 1)
        vv = Asc(part$)
        vv = vv + 1
        ret$ = ret$ + Chr$(vv)
    Next t
    EncodeCode = ret$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function DecodeCode(code$) As String
    'dencodes the reg code...
    On Error GoTo errorhandler
    Length = Len(code$)
    ret$ = ""
    For t = 1 To Length
        part$ = Mid$(code$, t, 1)
        vv = Asc(part$)
        vv = vv - 1
        ret$ = ret$ + Chr$(vv)
    Next t
    DecodeCode = ret$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function VerifyCode(code$) As Boolean
    'verifies a reg code as valid.
    On Error GoTo errorhandler
    VerifyCode = testCode(code$)

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


