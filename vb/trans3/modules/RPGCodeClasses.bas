Attribute VB_Name = "RPGCodeClasses"
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGCode classes
'=========================================================================

Option Explicit

'=========================================================================
' All classes
'=========================================================================
Public classes() As RPGCODE_CLASS_INSTANCE  'All classes

'=========================================================================
' Array of used handles
'=========================================================================
Public objHandleUsed() As Boolean           'This handle used?

'=========================================================================
' An instance of a class
'=========================================================================
Private Type RPGCODE_CLASS_INSTANCE
    hClass As Long                          'Handle to this class
    strInstancedFrom As String              'It was instanced from this class
End Type

'=========================================================================
' A method
'=========================================================================
Private Type RPGCodeMethod
    name As String                          'Name of the method
    line As Long                            'Line method is defined on
End Type

'=========================================================================
' A scope in a class
'=========================================================================
Private Type RPGCODE_CLASS_SCOPE
    strVars() As String                     'Variables in this scope
    methods() As RPGCodeMethod              'Methods in this scope
End Type

'=========================================================================
' A class
'=========================================================================
Public Type RPGCODE_CLASS
    strName As String                       'Name of this class
    scopePrivate As RPGCODE_CLASS_SCOPE     'Private scope
    scopePublic As RPGCODE_CLASS_SCOPE      'Public scope
End Type

'=========================================================================
' Main data on classes (per program)
'=========================================================================
Private Type RPGCODE_CLASS_MAIN_DATA
    classes() As RPGCODE_CLASS              'Classes this program can instance
    nestle() As Long                        'Nestle of classes
    insideClass As Boolean                  'Inside a class?
End Type

'=========================================================================
' An RPGCode program
'=========================================================================
Public Type RPGCodeProgram
    program() As String                     'The program text
    methods() As RPGCodeMethod              'Methods in this program
    programPos As Long                      'Current position in program
    included(50) As String                  'Included files
    Length As Long                          'Length of program
    heapStack() As Long                     'Stack of local heaps
    currentHeapFrame As Long                'Current heap frame
    boardNum As Long                        'The corresponding board index of the program (default to 0)
    threadID As Long                        'The thread id (-1 if not a thread)
    compilerStack() As String               'Stack used by 'compiled' programs
    currentCompileStackIdx As Long          'Current index of compilerStack
    looping As Boolean                      'Is a multitask program looping?
    autoLocal As Boolean                    'Force implicitly created variables to the local scope?
    classes As RPGCODE_CLASS_MAIN_DATA      'Class stuff
End Type

'=========================================================================
' Add a class to a program
'=========================================================================
Public Sub addClassToProgram(ByRef theClass As RPGCODE_CLASS, ByRef prg As RPGCodeProgram)

    On Error Resume Next

    Dim idx As Long         'Loop var
    Dim pos As Long         'Position to use

    'Make pos void
    pos = -1

    'Check all classes already in program
    For idx = 0 To UBound(prg.classes.classes)
        If (theClass.strName = prg.classes.classes(idx).strName) Then
            'Already in program
            Exit Sub

        ElseIf (prg.classes.classes(idx).strName = "") Then
            'Free space
            If (pos = -1) Then
                pos = idx
            End If

        End If
    Next idx

    If (pos = -1) Then
        'No free spaces
        ReDim Preserve prg.classes.classes(UBound(prg.classes.classes) + 1)
        pos = UBound(prg.classes.classes)
    End If

    'Write in the data
    prg.classes.classes(pos) = theClass

End Sub

'=========================================================================
' Read all data on classes from a program
'=========================================================================
Public Sub spliceUpClasses(ByRef prg As RPGCodeProgram)

    On Error Resume Next

    Dim lineIdx As Long     'Current line
    Dim inClass As Boolean  'Inside a class?
    Dim scope As String     'Current scope (public or private)
    Dim cmd As String       'The command
    Dim opening As Boolean  'Looking for { bracket?
    Dim depth As Long       'Depth in class
    Dim classIdx As Long    'Current class
    Dim inStruct As Boolean 'In a structure?

    'Make classIdx void
    classIdx = -1

    'Loop over each line
    For lineIdx = 0 To UBound(prg.program)

        cmd = UCase(GetCommandName(prg.program(lineIdx)))

        If (opening And inClass And (cmd = "OPENBLOCK")) Then
            'Found first { bracket
            opening = False
            depth = depth + 1

        ElseIf (inClass And (Not opening) And (cmd = "OPENBLOCK")) Then
            'Getting deeper
            depth = depth + 1

        ElseIf (inClass And (Not opening) And (cmd = "CLOSEBLOCK")) Then
            'Coming out
            depth = depth - 1
            'Check if we're completely out
            If (depth = 0) Then
                'Out of the class
                inClass = False
                inStruct = False
                scope = ""
            End If

        ElseIf ((cmd = "CLASS" Or cmd = "STRUCT") And (Not inClass)) Then
            'Found a class
            inClass = True
            opening = True
            classIdx = classIdx + 1
            ReDim Preserve prg.classes.classes(classIdx)
            ReDim prg.classes.classes(classIdx).scopePrivate.methods(0)
            ReDim prg.classes.classes(classIdx).scopePrivate.strVars(0)
            ReDim prg.classes.classes(classIdx).scopePublic.methods(0)
            ReDim prg.classes.classes(classIdx).scopePublic.strVars(0)
            prg.classes.classes(classIdx).strName = UCase(GetMethodName(prg.program(lineIdx)))
            If (cmd = "STRUCT") Then
                'It's a structure, default to public visibility
                scope = "public"
                inStruct = True
            Else
                'Default to private in classes
                scope = "private"
                inStruct = False
            End If

        ElseIf (inClass And (scope <> "") And (prg.program(lineIdx) <> "")) Then
            If (InStr(1, prg.program(lineIdx), "(")) Then
                'Found a method
                If (Not inStruct) Then
                    If (scope = "private") Then
                        Call addMethodToScope(prg.classes.classes(classIdx).strName, prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePrivate)
                    Else
                        Call addMethodToScope(prg.classes.classes(classIdx).strName, prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePublic)
                    End If
                Else
                    Call debugger("Methods are not valid in structures-- " & prg.program(lineIdx))
                End If
            Else
                'Found a variable
                If (InStr(1, prg.program(lineIdx), "[")) Then
                    'It's an array
                    If (scope = "private") Then
                        Call addArrayToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePrivate)
                    Else
                        Call addArrayToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePublic)
                    End If
                Else
                    If (scope = "private") Then
                        Call addVarToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePrivate)
                    Else
                        Call addVarToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePublic)
                    End If
                End If
            End If

        End If

        If (inClass) Then

            Select Case LCase(Trim(prg.program(lineIdx)))

                Case "private:"
                    'Found start of private scope
                    scope = "public"
                    If (inStruct) Then
                        scope = "error"
                    Else
                        scope = "private"
                    End If

                Case "public:"
                    'Found start of public scope
                    scope = "public"
                    If (inStruct) Then
                        scope = "error"
                    Else
                        scope = "public"
                    End If

            End Select

            If (scope = "error") Then
                'No scope in structures
                Call debugger("Scope is not valid in structures-- " & prg.program(lineIdx))
                scope = "public"
            End If

            'Make sure this line isn't run
            prg.program(lineIdx) = ""

        End If

    Next lineIdx

End Sub

'=========================================================================
' Add an array to a scope
'=========================================================================
Private Sub addArrayToScope(ByVal theVar As String, ByRef scope As RPGCODE_CLASS_SCOPE)

    On Error Resume Next

    Dim toParse As String           'Text to parse
    Dim variableType As String      'Type of var
    Dim start As Long               'First [
    Dim tEnd As Long                'Last ]
    Dim variableName As String      'Name of var
    Dim parseArrayD() As String     'Dimensions
    Dim idx As Long                 'Loop var

    'Set toParse to the text passed in
    toParse = Trim(theVar)

    'Grab the variable's type (! or $)
    variableType = Right(toParse, 1)
    If (variableType <> "!" And variableType <> "$") Then
        'It's an object
        variableType = ""
    End If

    'See where the first [ is
    start = InStr(1, toParse, "[")

    'Grab the variable's name
    variableName = Mid(toParse, 1, start - 1)

    'Find the last ]
    tEnd = InStr(1, StrReverse(toParse), "]")
    tEnd = Len(toParse) - tEnd + 1

    'Just keep what's inbetween the two
    toParse = Mid(toParse, start + 1, tEnd - start - 1)

    'Split it at '][' (bewteen elements)
    parseArrayD() = Split(toParse, "][")

    'Add the vars
    ReDim x(UBound(parseArrayD)) As Long
    ReDim size(UBound(parseArrayD)) As Long
    For idx = 0 To UBound(size)
        size(idx) = CLng(parseArrayD(idx))
    Next idx
    Call getVarsFromArray(0, size(), x(), scope, variableName, variableType)

End Sub

'=========================================================================
' Add a variable to a scope
'=========================================================================
Private Sub addVarToScope(ByVal theVar As String, ByRef scope As RPGCODE_CLASS_SCOPE)

    On Error Resume Next

    Dim origName As String  'Name in original case
    Dim idx As Long         'Loop var
    Dim pos As Long         'Position we're using

    'Make theVar all caps
    origName = Trim(theVar)
    theVar = Trim(UCase(theVar))

    'Default to ! if no type def character
    If (Right(theVar, 1) <> "!" And Right(theVar, 1) <> "$") Then
        'Add the !
        theVar = theVar & "!"
    End If

    'Make pos void
    pos = -1

    'Loop over all vars in this scope
    For idx = 0 To UBound(scope.strVars)
        If (scope.strVars(idx) = theVar) Then
            Call debugger("Illegal redefinition of variable " & origName)
            Exit Sub

        ElseIf (scope.strVars(idx) = "") Then
            If (pos = -1) Then
                'Free position!
                pos = idx
            End If

        End If
    Next idx

    If (pos = -1) Then
        'Didn't find a position
        ReDim Preserve scope.strVars(UBound(scope.strVars) + 1)
        pos = UBound(scope.strVars)
    End If

    'Write in the data
    scope.strVars(pos) = theVar

End Sub

'=========================================================================
' Add a method to a scope
'=========================================================================
Private Sub addMethodToScope(ByVal theClass As String, ByVal Text As String, ByRef prg As RPGCodeProgram, ByRef scope As RPGCODE_CLASS_SCOPE)

    On Error Resume Next

    Dim theLine As Long         'Line method starts on
    Dim methodName As String    'Name of method
    Dim origName As String      'Name of method in orig case
    Dim idx As Long             'Loop variable
    Dim pos As Long             'Pos we're using

    'Get the method's name
    origName = GetMethodName(Text)
    methodName = UCase(theClass) & "::" & UCase(origName)

    'Get line method starts on
    theLine = getMethodLine(methodName, prg)

    'Check if we errored out
    If (theLine = -1) Then
        Call debugger("Could not find method " & origName & " -- " & Text)
        Exit Sub
    End If

    'Make pos void
    pos = -1

    'Find an open position
    For idx = 0 To UBound(scope.methods)
        If (scope.methods(idx).name = UCase(origName)) Then
            'Illegal redifinition
            Call debugger("Illegal redefinition of method " & origName & " -- " & Text)
            Exit Sub

        ElseIf (scope.methods(idx).name = "") Then
            If (pos = -1) Then
                'Found a spot
                pos = idx
            End If
        End If
    Next idx

    'Check if we found a spot
    If (pos = -1) Then
        'Didn't find one
        ReDim Preserve scope.methods(UBound(scope.methods) + 1)
        pos = UBound(scope.methods)
    End If

    'Add in the data
    scope.methods(pos).line = theLine
    scope.methods(pos).name = UCase(origName)

End Sub

'=========================================================================
' Remove class name from a function
'=========================================================================
Private Function removeClassName(ByVal Text As String) As String

    On Error Resume Next

    Dim idx As Long         'For loop var
    Dim char As String * 2  'Characters

    For idx = 1 To Len(Text)
        'Get a character
        char = Mid(Text, idx, 2)
        'Check if it's the scope operator
        If (char = "::") Then
            'Found it
            removeClassName = Mid(Text, idx + 2)
            Exit Function
        End If
    Next idx

    'Didn't find it
    removeClassName = Text

End Function

'=========================================================================
' Initiate the class system
'=========================================================================
Public Sub initRPGCodeClasses()
    ReDim objHandleUsed(0)
    ReDim classes(0)
    Call newHandle
End Sub

'=========================================================================
' Kill a handle number
'=========================================================================
Private Sub killHandle(ByVal hClass As Long)

    On Error Resume Next

    If (Not UBound(objHandleUsed) < hClass) Then
        'Write in the data
        objHandleUsed(hClass) = False
    End If

End Sub

'=========================================================================
' Get a new handle number
'=========================================================================
Private Function newHandle() As Long

    On Error Resume Next

    Dim idx As Long     'Loop var
    Dim pos As Long     'Position to use

    'Make pos void
    pos = -1

    'Loop over each handle
    For idx = 0 To UBound(objHandleUsed)
        If (Not objHandleUsed(idx)) Then
            'Free position
            pos = idx
            Exit For
        End If
    Next idx

    If (pos = -1) Then
        'Didn't find a spot
        ReDim Preserve objHandleUsed(UBound(objHandleUsed) + 1)
        pos = UBound(objHandleUsed)
    End If

    'Write in the data
    objHandleUsed(pos) = True
    newHandle = pos

End Function

'=========================================================================
' Check if a program can instance a class
'=========================================================================
Private Function canInstanceClass(ByVal theClass As String, ByRef prg As RPGCodeProgram) As Boolean

    On Error Resume Next

    Dim idx As Long     'Loop var

    'Loop over each class we can instance
    For idx = 0 To UBound(prg.classes.classes)
        If (prg.classes.classes(idx).strName = UCase(theClass)) Then
            'Yes, we can
            canInstanceClass = True
            Exit Function
        End If
    Next idx

    'If we get here, we can't instance this class

End Function

'=========================================================================
' Determine if a variable is a member of a class
'=========================================================================
Public Function isVarMember(ByVal var As String, ByVal hClass As Long, ByRef prg As RPGCodeProgram, Optional ByVal outside As Boolean) As Boolean

    On Error Resume Next

    Dim idx As Long, scopeIdx As Long   'Loop var
    Dim theClass As RPGCODE_CLASS       'The class
    Dim scope As RPGCODE_CLASS_SCOPE    'A scope

    'Get the class
    theClass = getClass(hClass, prg)

    If (theClass.strName = "INVALID") Then
        'Class doesn't exist!
        Exit Function
    End If

    'Make the var all caps
    var = Trim(UCase(var))

    'For each scope
    For scopeIdx = 0 To 1
        'Get the scope
        If (scopeIdx = 1) Then
            'Private scope
            scope = theClass.scopePrivate
        Else
            'Public scope
            scope = theClass.scopePublic
        End If
        'For each var within that scope
        For idx = 0 To UBound(scope.strVars)
            If (scope.strVars(idx) = var) Then
                'Found it
                isVarMember = True
                Exit Function
            End If
        Next idx
        If (outside) Then
            'Don't check private scope
            Exit Function
        End If
    Next scopeIdx

    'It we get here, then this variable is not a member of the class

End Function

'=========================================================================
' Determine if a method is a member of a class
'=========================================================================
Public Function isMethodMember(ByVal methodName As String, ByVal hClass As Long, ByRef prg As RPGCodeProgram, Optional ByVal outside As Boolean) As Boolean

    On Error Resume Next

    Dim idx As Long, scopeIdx As Long   'Loop var
    Dim theClass As RPGCODE_CLASS       'The class
    Dim scope As RPGCODE_CLASS_SCOPE    'A scope

    'Get the class
    theClass = getClass(hClass, prg)

    If (theClass.strName = "INVALID") Then
        'Class doesn't exist!
        Exit Function
    End If

    'Make the method name all caps
    methodName = Trim(UCase(methodName))

    'For each scope
    For scopeIdx = 0 To 1
        'Get the scope
        If (scopeIdx = 1) Then
            'Private scope
            scope = theClass.scopePrivate
        Else
            'Public scope
            scope = theClass.scopePublic
        End If
        'For each method within that scope
        For idx = 0 To UBound(scope.methods)
            If (scope.methods(idx).name = methodName) Then
                'Found it
                isMethodMember = True
                Exit Function
            End If
        Next idx
        If (outside) Then
            'Don't check private scope
            Exit Function
        End If
    Next scopeIdx

    'It we get here, then this method is not a member of the class

End Function

'=========================================================================
' Get the *real* name of a variable
'=========================================================================
Public Function getObjectVarName(ByVal theVar As String, ByVal hClass As Long) As String

    On Error Resume Next

    'Return the new name
    getObjectVarName = CStr(hClass) & "::" & theVar

End Function

'=========================================================================
' Decrease the nestle
'=========================================================================
Public Sub decreaseNestle(ByRef prg As RPGCodeProgram)

    On Error Resume Next

    'Shrink the nestle array
    ReDim Preserve prg.classes.nestle(UBound(prg.classes.nestle) - 1)

    If (UBound(prg.classes.nestle) = 0) Then
        'Flag we're out of all classes
        prg.classes.insideClass = False
    End If

End Sub

'=========================================================================
' Get value on top of nestle stack
'=========================================================================
Public Function topNestle(ByRef prg As RPGCodeProgram) As Long

    On Error Resume Next

    'Return the value
    topNestle = prg.classes.nestle(UBound(prg.classes.nestle))

End Function

'=========================================================================
' Increase nestle
'=========================================================================
Public Sub increaseNestle(ByVal push As Long, ByRef prg As RPGCodeProgram)

    On Error Resume Next

    'Enlarge the nestle array
    ReDim Preserve prg.classes.nestle(UBound(prg.classes.nestle) + 1)

    'Push on the value
    prg.classes.nestle(UBound(prg.classes.nestle)) = push

    'Flag we're inside a class
    prg.classes.insideClass = True

End Sub

'=========================================================================
' Get a class from an instance of it
'=========================================================================
Public Function getClass(ByVal hClass As Long, ByRef prg As RPGCodeProgram) As RPGCODE_CLASS

    On Error Resume Next

    Dim strClass As String  'The class' name
    Dim idx As Long         'Loop var

    'Get the class' name
    strClass = classes(hClass).strInstancedFrom

    'Loop over every class it could be
    For idx = 0 To UBound(prg.classes.classes)
        If (prg.classes.classes(idx).strName = strClass) Then
            'Found it!
            getClass = prg.classes.classes(idx)
            Exit Function
        End If
    Next idx

    'If we get here, it wasn't a valid class
    getClass.strName = "INVALID"

End Function

'=========================================================================
' Clear an object
'=========================================================================
Private Sub clearObject(ByRef object As RPGCODE_CLASS_INSTANCE, ByRef prg As RPGCodeProgram)

    On Error Resume Next

    Dim idx As Long, scopeIdx As Long           'Loop var
    Dim theClass As RPGCODE_CLASS               'The class
    Dim scope As RPGCODE_CLASS_SCOPE            'A scope
    Dim oldDebug As Long, oldError As String    'Old stuff

    'Get the class
    theClass = getClass(object.hClass, prg)

    If (theClass.strName = "INVALID") Then
        'Class doesn't exist!
        Exit Sub
    End If

    'Get old values
    oldDebug = debugYN
    oldError = errorBranch

    'Clear values
    debugYN = 0
    oldError = ""

    'For each scope
    For scopeIdx = 0 To 1
        'Get the scope
        If (scopeIdx = 0) Then
            'Private scope
            scope = theClass.scopePrivate
        Else
            'Public scope
            scope = theClass.scopePublic
        End If
        'For each var within that scope
        For idx = 0 To UBound(scope.strVars)
            'Kill the variable
            Call KillRPG("Kill(" & getObjectVarName(scope.strVars(idx), object.hClass) & ")", prg)
        Next idx
    Next scopeIdx

    'Restore values
    debugYN = oldDebug
    errorBranch = oldError

End Sub

'=========================================================================
' Create a new instance of a class
'=========================================================================
Public Function createRPGCodeObject(ByVal theClass As String, ByRef prg As RPGCodeProgram, ByRef constructParams() As String, ByVal noParams As Boolean) As Long

    On Error Resume Next

    Dim hClass As Long              'Handle to use
    Dim retval As RPGCODE_RETURN    'Return value

    'Return -1 on error
    hClass = -1

    'Check if we can instance this class
    If (canInstanceClass(theClass, prg)) Then
        'Create a new handle
        hClass = newHandle()
        'Make sure we have enough room in the instances array
        If (UBound(classes) < hClass) Then
            'Enlarge the array
            ReDim Preserve classes(hClass)
        End If
        'Write in the data
        classes(hClass).strInstancedFrom = UCase(theClass)
        classes(hClass).hClass = hClass
        Call clearObject(classes(hClass), prg)
        Call callObjectMethod(hClass, theClass & createParams(constructParams, noParams), prg, retval)
    End If

    'Return a handle to the class
    createRPGCodeObject = hClass

End Function

'=========================================================================
' Grab vars from an array
'=========================================================================
Private Sub getVarsFromArray(ByVal depth As Long, ByRef size() As Long, ByRef x() As Long, ByRef scope As RPGCODE_CLASS_SCOPE, ByVal prefix As String, ByVal postFix As String)

    On Error Resume Next

    Dim dimIdx As Long      'Dimension index
    Dim theVar As String    'The variable

    For x(depth) = 0 To size(depth)
        If (depth <= UBound(size)) Then
            Call getVarsFromArray(depth + 1, size(), x(), scope, prefix, postFix)
        Else
            theVar = ""
            For dimIdx = 0 To UBound(size)
                theVar = theVar & "[" & CStr(x(dimIdx)) & "]"
            Next dimIdx
            Call addVarToScope(prefix & theVar & postFix, scope)
        End If
    Next x(depth)

End Sub

'=========================================================================
' Create a string for params from an array
'=========================================================================
Private Function createParams(ByRef params() As String, ByVal noParams As Boolean) As String

    On Error Resume Next

    Dim idx As Long     'Loop var

    'Begin the return string
    createParams = "("

    If (Not noParams) Then
        'Loop over each param
        For idx = 0 To UBound(params)
            createParams = createParams & params(idx) & ","
        Next idx
        createParams = Left(createParams, Len(createParams) - 1)
    End If

    'Finish the return string
    createParams = createParams & ")"

End Function

'=========================================================================
' Splice up a line for object things
'=========================================================================
Public Function spliceForObjects(ByVal Text As String, ByRef prg As RPGCodeProgram) As String

    On Error Resume Next

    Dim inArray As Boolean          'In an array?
    Dim value As String             'Value of function
    Dim retval As RPGCODE_RETURN    'Return value
    Dim begin As Long               'Char to begin at
    Dim char As String              'Character(s)
    Dim spacesOK As Boolean         'Spaces are okay?
    Dim cLine As String             'Command line
    Dim object As String            'Object name
    Dim depth As Long               'Depth
    Dim ignore As Boolean           'In quotes?
    Dim lngEnd As Long              'End of text
    Dim start As Long               'Start of object manipulation
    Dim hClassDbl As Double         'Handle to a class (double)
    Dim hClass As Long              'Handle to a class
    Dim var As Boolean              'Variable?
    Dim outside As Boolean          'Calling from outside class?
    Dim cmdName As String           'Command's name
    Dim a As Long                   'Loop var

    'Get location of first ->
    begin = inStrOutsideQuotes(1, Text, "->")

    If (begin = 0) Then
        'Contains no object manipulation
        spliceForObjects = Text
        Exit Function
    End If

    'Loop over each charater, forwards
    For a = (begin + 2) To Len(Text)
        'Get a character
        char = Mid(Text, a, 1)
        Select Case char

            Case "!", "$", "-"
                'Could be a public var
                If (depth = 0 And (Not ignore) And (Not inArray)) Then
                    lngEnd = a
                    var = True
                    Exit For
                End If

            Case "("
                If (Not ignore) Then
                    'Increase depth
                    depth = depth + 1
                End If

            Case ")"
                If (Not ignore) Then
                    'Decrease depth
                    depth = depth - 1
                    If (depth = 0) Then
                        lngEnd = a
                        Exit For
                    End If
                End If

            Case "["
                'Entering array
                inArray = True

            Case "]"
                'Leaving array
                inArray = False

            Case Chr(34)
                'Found a quote
                ignore = (Not ignore)

        End Select
    Next a

    'Record the method's command line
    cLine = ParseRPGCodeCommand(Trim(Mid(Text, begin + 2, lngEnd - begin - 1)), prg)
    If (Not var) Then
        cmdName = UCase(GetCommandName(cLine))
    Else
        'Parse the var
        cLine = parseArray(cLine, prg)
        If (Right(cLine, 1) <> "!" And Right(cLine, 1) <> "$") Then
            'Assume object
            cLine = replace(replace(cLine & "!", "-", ""), " ", "")
        End If
    End If

    'Flag we're not in quotes
    ignore = False

    'Flag that spaces are okay
    spacesOK = True

    'Make sure start has a value
    start = 1

    'Loop over each charater, backwards
    For a = (begin - 1) To 1 Step -1
        'Get a character
        char = Mid(Text, a, 1)
        If ((spacesOK) And (char = " ")) Then
            'Alter char
            char = ""
            'Flag spaces are no longer okay
            spacesOK = False
        End If
        Select Case char

            Case " ", ",", "#", "=", "<", ">", "+", "-", ";", "*", "\", "/", "^", "(", ")"
                'It's a divider
                If (Not ignore) Then
                    start = a + 1
                    Exit For
                End If

            Case Chr(34)
                'Found a quote
                ignore = (Not ignore)
                spacesOK = False

            Case Else
                'Not a space, so they aren't okay anymore
                spacesOK = False

        End Select
    Next a

    'Record the object
    object = parseArray(UCase(Trim(Mid(Text, start, begin - start))), prg)
    If (object = "") Then object = GetWithPrefix()

    'Get its handle
    If (object <> "THIS") Then
        If (Right(object, 1) <> "!" And Right(object, 1) <> "$") Then object = object & "!"
        Call getVariable(object, object, hClassDbl, prg)
        hClass = CLng(hClassDbl)
        'Check if we're calling from outside
        outside = (topNestle(prg) <> hClass)
    Else
        'It's this object
        hClass = topNestle(prg)
        'We're calling from inside
        outside = False
    End If

    If (Not var) Then

        'Check if we're to release
        If (cmdName = "RELEASE") Then
            Call callObjectMethod(hClass, "~" & classes(hClass).strInstancedFrom, prg, retval)
            Call clearObject(classes(hClass), prg)
            Call killHandle(hClass)
            classes(hClass).hClass = 0
            classes(hClass).strInstancedFrom = ""
        Else

            If (isMethodMember(cmdName, hClass, prg, outside)) Then

                'Execute the method
                Call callObjectMethod(hClass, cLine, prg, retval)

                'Replace text with value the method returned
                If (retval.dataType = DT_NUM) Then
                    value = " " & CStr(retval.num)
                ElseIf (retval.dataType = DT_LIT) Then
                    value = " " & Chr(34) & retval.lit & Chr(34)
                End If

            Else

                Call debugger("Error: Could not call method-- " & cLine)

            End If

        End If

    Else
        'It's a variable
        If (isVarMember(cLine, hClass, prg, outside)) Then
            'It's a member
            value = getObjectVarName(cLine, hClass)
        Else
            Call debugger("Error: Could not get/set " & cLine & " -- " & Text)
        End If
    End If

    'Internationalize
    value = replace(value, ",", ".")

    'Complete the return string
    spliceForObjects = Mid(Text, 1, start - 1) & value & Mid(Text, lngEnd + 1)
    If (Trim(spliceForObjects) = "0") Then
        spliceForObjects = ""
    Else
        'Recurse, passing in the running text
        spliceForObjects = spliceForObjects(spliceForObjects, prg)
    End If

End Function
