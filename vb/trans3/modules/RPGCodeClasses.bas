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
' An instance of a class
'=========================================================================
Private Type RPGCODE_CLASS_INSTANCE
    strInstanceName As String               'Name of this object
    strInstancedFrom As String              'It was instanced from this class
End Type

'=========================================================================
' A method
'=========================================================================
Private Type RPGCodeMethod
    name As String                          'name of the method
    line As Long                            'line method is defined on
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
    instances() As RPGCODE_CLASS_INSTANCE   'Instances of these classes that have
                                            'been created
End Type

'=========================================================================
' An RPGCode program
'=========================================================================
Public Type RPGCodeProgram
    program() As String                     'the program text
    methods() As RPGCodeMethod              'methods in this program
    programPos As Long                      'current position in program
    included(50) As String                  'included files
    Length As Long                          'length of program
    heapStack() As Long                     'stack of local heaps
    currentHeapFrame As Long                'current heap frame
    boardNum As Long                        'the corresponding board index of the program (default to 0)
    threadID As Long                        'the thread id (-1 if not a thread)
    compilerStack() As String               'stack used by 'compiled' programs
    currentCompileStackIdx As Long          'current index of compilerStack
    looping As Boolean                      'is a multitask program looping?
    autoLocal As Boolean                    'force implicitly created variables to the local scope?
    classes As RPGCODE_CLASS_MAIN_DATA      'class stuff
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
    ReDim prg.classes.instances(0)

    'Make classIdx void
    classIdx = -1

    'Loop over each line
    For lineIdx = 0 To UBound(prg.program)

        cmd = GetCommandName(prg.program(lineIdx))

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
            prg.classes.classes(classIdx).strName = GetMethodName(prg.program(lineIdx))

        ElseIf (inClass And (scope = "")) Then
            scope = LCase(Trim(prg.program(lineIdx)))
            Select Case scope

                Case "private:"
                    'Found start of private scope
                    scope = "private"
                    ReDim prg.classes.classes(classIdx).scopePrivate.methods(0)
                    ReDim prg.classes.classes(classIdx).scopePrivate.strVars(0)

                Case "public:"
                    'Found start of public scope
                    scope = "public"
                    ReDim prg.classes.classes(classIdx).scopePublic.methods(0)
                    ReDim prg.classes.classes(classIdx).scopePublic.strVars(0)

                Case Else
                    'Not definition of scope
                    scope = ""

            End Select

        ElseIf (inClass And (scope <> "")) Then
            If (InStr(1, prg.program(lineIdx), "(")) Then
                'Found a method
                If (scope = "private") Then
                    Call addMethodToScope(prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePrivate)
                Else
                    Call addMethodToScope(prg.program(lineIdx), prg, prg.classes.classes(classIdx).scopePublic)
                End If
            Else
                'Found a variable
                If (scope = "private") Then
                
                Else
                
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
' Add a method to a scope
'=========================================================================
Private Sub addMethodToScope(ByVal text As String, ByRef prg As RPGCodeProgram, ByRef scope As RPGCODE_CLASS_SCOPE)

    On Error Resume Next

    Dim theLine As Long         'Line method starts on
    Dim methodName As String    'Name of method
    Dim idx As Long             'Loop variable
    Dim pos As Long             'Pos we're using

    'Get the method's name
    methodName = UCase(removeClassName(GetMethodName(text)))

    'Get line method starts on
    theLine = getMethodLine(methodName, prg)

    'Check if we errored out
    If (theLine = -1) Then
        Call debugger("Could not find method " & methodName & " -- " & text)
        Exit Sub
    End If

    'Make pos void
    pos = -1

    'Find an open position
    For idx = 0 To UBound(scope.methods)
        If (scope.methods(idx).name = "") Then
            'Found a spot
            pos = idx
            Exit For
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
    scope.methods(pos).name = methodName

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
