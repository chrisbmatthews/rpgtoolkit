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
Private m_handleUsed() As Boolean           'This handle used?

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
Private Type RPGCODE_CLASS
    strName As String                       'Name of this class
    scopePrivate As RPGCODE_CLASS_SCOPE     'Private scope
    scopePublic As RPGCODE_CLASS_SCOPE      'Public scope
End Type

'=========================================================================
' Main data on classes (per program)
'=========================================================================
Private Type RPGCODE_CLASS_MAIN_DATA
    classes() As RPGCODE_CLASS              'Classes this program can instance
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

    'Init the classes array
    ReDim prg.classes.classes(0)

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
                scope = ""
            End If

        ElseIf (cmd = "CLASS" And (Not inClass)) Then
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

        ElseIf (inClass And (scope = "")) Then
            scope = LCase(Trim(prg.program(lineIdx)))
            Select Case scope

                Case "private:"
                    'Found start of private scope
                    scope = "private"

                Case "public:"
                    'Found start of public scope
                    scope = "public"

                Case Else
                    'Not definition of scope
                    scope = ""

            End Select

        ElseIf (inClass And (scope <> "") And (prg.program(lineIdx) <> "")) Then
            If (InStr(1, prg.program(lineIdx), "(")) Then
                'Found a method
                If (scope = "private") Then
                    Call addMethodToScope(prg.classes.classes(classIdx).strName, prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePrivate)
                Else
                    Call addMethodToScope(prg.classes.classes(classIdx).strName, prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePublic)
                End If
            Else
                'Found a variable
                If (scope = "private") Then
                    Call addVarToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePrivate)
                Else
                    Call addVarToScope(prg.program(lineIdx), prg.classes.classes(classIdx).scopePublic)
                End If
            End If

        End If

        If (inClass) Then
            'Make sure this line isn't run
            prg.program(lineIdx) = ""
        End If

    Next lineIdx

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
    origName = theVar
    theVar = UCase(theVar)

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
Private Sub addMethodToScope(ByVal theClass As String, ByVal text As String, ByRef prg As RPGCodeProgram, ByRef scope As RPGCODE_CLASS_SCOPE)

    On Error Resume Next

    Dim theLine As Long         'Line method starts on
    Dim methodName As String    'Name of method
    Dim origName As String      'Name of method in orig case
    Dim idx As Long             'Loop variable
    Dim pos As Long             'Pos we're using

    'Get the method's name
    origName = GetMethodName(text)
    methodName = UCase(theClass) & "::" & UCase(origName)

    'Get line method starts on
    theLine = getMethodLine(methodName, prg)

    'Check if we errored out
    If (theLine = -1) Then
        Call debugger("Could not find method " & origName & " -- " & text)
        Exit Sub
    End If

    'Make pos void
    pos = -1

    'Find an open position
    For idx = 0 To UBound(scope.methods)
        If (scope.methods(idx).name = UCase(origName)) Then
            'Illegal redifinition
            Call debugger("Illegal redefinition of method " & origName & " -- " & text)
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
Private Function removeClassName(ByVal text As String) As String

    On Error Resume Next

    Dim idx As Long         'For loop var
    Dim char As String * 2  'Characters

    For idx = 1 To Len(text)
        'Get a character
        char = Mid(text, idx, 2)
        'Check if it's the scope operator
        If (char = "::") Then
            'Found it
            removeClassName = Mid(text, idx + 2)
            Exit Function
        End If
    Next idx

    'Didn't find it
    removeClassName = text

End Function

'=========================================================================
' Initiate the class system
'=========================================================================
Public Sub initRPGCodeClasses()
    'Dimension two arrays
    ReDim m_handleUsed(0)
    ReDim classes(0)
End Sub

'=========================================================================
' Kill a handle number
'=========================================================================
Private Sub killHandle(ByVal hClass As Long)

    On Error Resume Next

    If (Not UBound(m_handleUsed) < hClass) Then
        'Write in the data
        m_handleUsed(hClass) = False
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
    For idx = 0 To UBound(m_handleUsed)
        If (Not m_handleUsed(idx)) Then
            'Free position
            pos = idx
            Exit For
        End If
    Next idx

    If (pos = -1) Then
        'Didn't find a spot
        ReDim Preserve m_handleUsed(UBound(m_handleUsed) + 1)
        pos = UBound(m_handleUsed)
    End If

    'Write in the data
    m_handleUsed(pos) = True
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
Public Function isVarMember(ByVal var As String, ByVal hClass As Long, ByRef prg As RPGCodeProgram) As Boolean

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
' Get a class from an instance of it
'=========================================================================
Private Function getClass(ByVal hClass As Long, ByRef prg As RPGCodeProgram) As RPGCODE_CLASS

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

    Dim idx As Long, scopeIdx As Long   'Loop var
    Dim theClass As RPGCODE_CLASS       'The class
    Dim scope As RPGCODE_CLASS_SCOPE    'A scope

    'Get the class
    theClass = getClass(object.hClass, prg)

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

End Sub

'=========================================================================
' Create a new instance of a class
'=========================================================================
Public Function createRPGCodeObject(ByVal theClass As String, ByRef prg As RPGCodeProgram) As Long

    On Error Resume Next

    Dim hClass As Long      'Handle to use

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
    End If

    'Return a handle to the class
    createRPGCodeObject = hClass

End Function
