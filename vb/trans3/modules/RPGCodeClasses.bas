Attribute VB_Name = "ClassRoutines"
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'KSNiloc's
''''''''''''''''
'Class Routines'
''''''''''''''''

'Note to developers:    Put new classes in the IsClassRPG function. However,
'                       *do not* put the sub-routines in this module. Place
'                       them in a module called Class_[name of class] so they
'                       can easily be found.

Option Explicit
Global InClass As ClassStuff
Global Const ClassMemory As Double = 999 'Memory for classes

Type ClassStuff
 PopupMethodNotFound As Boolean
 MethodWasFound As Boolean
 DoNotCheckForClass As Boolean

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/25/04]
 
 Inheriting As Boolean
 InheritClass As String
 InheritFrom As String
 
 ''''''''''''''''''''''''''
 '      End Addition      '
 ''''''''''''''''''''''''''
End Type

Function IsNonInstanceableClass(Class As String) As Boolean
 'List of "non-instanceable" classes...
 
 IsNonInstanceableClass = True
 
 Select Case Trim(LCase(Class))
  Case "class"
  'Case "OtherClassesHere"
  Case Else: IsNonInstanceableClass = False
 End Select
End Function

Function IsClassRPG(Class As String, pass As String, Text$, ByRef theProgram As RPGCodeProgram, ByRef retval As RPGCODE_RETURN) As Boolean
 'Determines if a command with a "." is a class and executes
 'it if it is...
 
 Dim a As Long
 Dim from As String
 Dim file As String
 Dim Temp As Variant
 Dim CallIt As String
 Dim b As Variant

 If IsNonInstanceableClass(Class) Then
  from = Class
 Else
  For a = 0 To ClassMemory
   b = CStr(a)
   If b = "" Then b = "0"
   If LCase(CBGetString("CreatedClasses[" + b + "]$")) = LCase(Class) Then Exit For
   If a = ClassMemory Then IsClassRPG = False: Exit Function
  Next a
  from = CBGetString("CreatedFrom[" + CStr(a) + "]$") 'what was it created from?
 End If
 
 IsClassRPG = True
 
 Select Case Trim(LCase(from))
  Case "class"
   Select Case LCase(pass)
    Case "setnew": SetNewClass Text$, theProgram
    Case "destroy": DestroyClass Text$, theProgram
    Case "setlocal": SetLocal Text$, theProgram
    Case "getlocal": GetLocal Text$, theProgram, retval
    Case "inherit": Inherit Text$, theProgram
    Case Else: ClassNotFound from, pass, Text$
   End Select
  'Add internal classes here
  Case Else
   'May be a user-made class...
   file = App.path & "\" & projectPath$ & "prg\" & from & ".prg"
   If FileExists(file) Then
    IncludeRPG "#Include(""" & from & ".prg"")", theProgram
    IncreaseClassNestle Class
    Temp = InStr(1, Text$, ".", vbTextCompare)
    CallIt = "#" & Right(Text$, Len(Text$) - Temp)
    Temp = theProgram.programPos
    DoSingleCommand CallIt, theProgram, retval
    theProgram.programPos = Temp
    DecreaseClassNestle
    If InClass.MethodWasFound = False Then
     ClassNotFound from, pass, Text$
     Exit Function
    End If
   Else
    IsClassRPG = False
    Exit Function
   End If
 End Select
 
End Function

Sub ClassNotFound(from As String, pass As String, Text$)
 debugger """" & pass & """ not found in """ & from & """ class-- " & Text$
End Sub

Sub SetNewClass(Text$, ByRef theProgram As RPGCodeProgram)

 '#Class.SetNew(name,from)
 'Creates an instance of a class.
 
 'Status: Fully functional

 Dim Temp As Variant
 Dim temp2 As Long
 Dim temp3 As Double
 Dim name As String
 Dim from As String
 Dim a As Long

 On Error GoTo error

 Temp = CountData(Text$)
 If Not Temp = 2 Then
  debugger "Class.SetNew needs two data elements-- " & Text$
  Exit Sub
 End If

 temp2 = GetValue(GetElement(GetBrackets(Text$), 1), name, temp3, theProgram)
 If Not temp3 = 0 Then
  debugger "Class.SetNew needs object data elements-- " & Text$
  Exit Sub
 End If

 temp2 = GetValue(GetElement(GetBrackets(Text$), 2), from, temp3, theProgram)
 If Not temp3 = 0 Then
  debugger "Class.SetNew needs object data elements-- " & Text$
  Exit Sub
 End If
 
 For a = 0 To ClassMemory
  If LCase(CBGetString("CreatedClasses[" + CStr(a) + "]$")) = LCase(from) Then
   debugger "A class already exists under that name-- " & Text$
   Exit Sub
  End If
 Next a
 
 Dim b As Variant
 For a = 0 To ClassMemory
  b = CStr(a)
  If b = "" Then b = "0"
  If CBGetString("CreatedClasses[" + b + "]$") = "" Then Exit For
  If a = ClassMemory Then
   debugger "Out of memory for classes."
   Exit Sub
  End If
 Next a
 
 If IsNonInstanceableClass(from) Then
  debugger "Class """ & from & """ is non-instanceable."
  Exit Sub
 End If
 
 CBSetString "CreatedClasses[" + b + "]$", name
 CBSetString "CreatedFrom[" + b + "]$", from
 
 IncreaseClassNestle name
 
 Dim retval As RPGCODE_RETURN
 DoIndependentCommand "#" & from & ".Initiate()", retval
 
 DecreaseClassNestle

 Exit Sub
error:
 debugger "Unexpected error with Class.SetNew-- " & error
End Sub

Sub SetLocal(Text$, ByRef theProgram As RPGCodeProgram)

 '#Class.SetLocal(var!,1)
 '-or-
 '#Class.SetLocal(var$,"one")
 'Sets a local variable.

 On Error GoTo error
 
 Dim Temp As Variant
 Dim Class As String
 Dim var As String
 Dim var2 As Double
 Dim Data As String
 Dim temp2 As Long

 Temp = CountData(Text$)
 If Not Temp = 2 Then
  debugger "Class.SetLocal needs two data elements-- " & Text$
  Exit Sub
 End If

 Class = CBGetString("Class_Nestled_Name[" & CStr(CBGetNumerical("Class_Nestled!")) & "]$")
 var = GetElement(GetBrackets(Text$), 1)
 temp2 = GetValue(GetElement(GetBrackets(Text$), 2), Data, var2, theProgram)

 var = parseArray(var, theProgram)

 If temp2 = DT_LIT Then CBSetString Class & "." & var, Data
 If temp2 = DT_NUM Then CBSetNumerical Class & "." & var, var2

 Exit Sub
error:
 debugger "Unexpected error with Class.SetLocal-- " & error
End Sub

Sub GetLocal(Text$, ByRef theProgram As RPGCodeProgram, retval As RPGCODE_RETURN)

 '#a$ = #Class.GetLocal(var$)
 '#a! = #Class.GetLocal(var!)
 'Retrieves a local variable.

 On Error GoTo error
 
 Dim Temp As Variant
 Dim Class As String
 Dim var As String
 Dim varType As String
 
 Temp = CountData(Text$)
 If Not Temp = 1 Then
  debugger "Class.GetLocal needs one data element-- " & Text$
  Exit Sub
 End If

 Class = CBGetString("Class_Nestled_Name[" & CStr(CBGetNumerical("Class_Nestled!")) & "]$")
 var = GetElement(GetBrackets(Text$), 1)

 var = parseArray(var, theProgram)

 varType = Right(var, 1)
 If varType = "$" Then
  retval.dataType = DT_LIT
  retval.lit = CBGetString(Class & "." & var)
 Else
  If varType = "!" Then
   retval.dataType = DT_NUM
   retval.num = CBGetNumerical(Class & "." & var)
  Else
   debugger "Illegal variable name-- " & var
   Exit Sub
  End If
 End If
 
 Exit Sub
error:
 debugger "Unexpected error with Class.GetLocal-- " & error
End Sub

Sub DestroyClass(Text$, ByRef theProgram As RPGCodeProgram)

 '#Class.Destroy(Class)
 'Destroys an instance of a class.

 On Error GoTo error

 Dim Temp As Variant
 Dim temp2 As Long
 Dim temp3 As Double
 Dim name As String
 Dim a As Long
 Dim b As Variant

 Temp = CountData(Text$)
 If Not Temp = 1 Then
  debugger "Class.Destroy needs one data element-- " & Text$
  Exit Sub
 End If

 temp2 = GetValue(GetElement(GetBrackets(Text$), 1), name, temp3, theProgram)
 If IsNonInstanceableClass(name) Then
  debugger "Class """ & name & """ cannot be destroyed."
  Exit Sub
 End If

 For a = 0 To ClassMemory
  b = CStr(a)
  If b = "" Then b = "0"
  If LCase(CBGetString("CreatedClasses[" + b + "]$")) = LCase(name) Then Exit For
  If a = ClassMemory Then
   debugger "Class " & name & " does not exist."
   Exit Sub
  End If
 Next a

 CBSetString "CreatedClasses[" + b + "]$", ""
 CBSetString "CreatedFrom[" + b + "]$", ""
 
 IncreaseClassNestle name
 
 Dim retval As RPGCODE_RETURN
 DoIndependentCommand "#" & name & ".Destroy()", retval
 
 DecreaseClassNestle

 Exit Sub
error:
 debugger "Unexpected error with Class.Destroy-- " & error
End Sub

Public Sub IncreaseClassNestle(ByVal className As String)

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/24/04]

 '''''''''
 'Purpose'
 '''''''''
 'Increases the nestle of the class stack

 ''''''''''''
 'Parameters'
 ''''''''''''
 'className is the name of the class to put at the top of the stack

 With InClass
  .PopupMethodNotFound = False
  .DoNotCheckForClass = True
  CBSetNumerical "Class_Nestled!", CBGetNumerical("Class_Nestled!") + 1
  CBSetString "Class_Nestled_Name[" & CStr(CBGetNumerical("Class_Nestled!")) & "]$", className
 End With
End Sub

Public Sub DecreaseClassNestle(Optional ByRef popClassName As String)

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/24/04]

 '''''''''
 'Purpose'
 '''''''''
 'Decreases the nestle of the class stack
 
 ''''''''''''
 'Parameters'
 ''''''''''''
 'popClassName is where to place the popped class name

 On Error Resume Next

 With InClass
  .DoNotCheckForClass = False
  .PopupMethodNotFound = True
  popClassName = CBGetString("Class_Nestled_Name[" & CStr(CBGetNumerical("Class_Nestled!")) & "]$")
  CBSetString "Class_Nestled_Name[" & CStr(CBGetNumerical("Class_Nestled!")) & "]$", ""
  CBSetNumerical "Class_Nestled!", CBGetNumerical("Class_Nestled!") - 1
 End With
End Sub

Public Function OnTopOfClassStack() As String
 
 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/25/04]
 
 '''''''''
 'Purpose'
 '''''''''
 'Retrieves the class on top of the stack WITHOUT popping it off
 
 ''''''''
 'Return'
 ''''''''
 'The instance of the class
 
 Dim className As String
 DecreaseClassNestle className
 IncreaseClassNestle className
 OnTopOfClassStack = className
 
End Function

Public Sub Inherit(Text$, ByRef theProgram As RPGCodeProgram)

 'NOTE: NOT FUNCTIONAL!!!!

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[5/25/04]

 '''''''''
 'Purpose'
 '''''''''
 'Allows an instance of a class to inherit properties of another
 
 ''''''''''''
 'Parameters'
 ''''''''''''
 'text$ is the full command line
 'theProgram is the RPGCode program we're working with
 
 ''''''''''''''''
 'RPGCode Syntax'
 ''''''''''''''''
 '#Class.Inherit(MyNewClass,MyOldClass)
 '#Class.Inherit(Property!$)

 'Error handling...
 On Error GoTo error

 'Declarations...
 Dim varType(1) As Long
 Dim num(1) As Double
 Dim lit(1) As String
 Dim Temp As Variant
 Dim RPGCode As String
 
 Temp = CountData(Text$)
 If InClass.Inheriting = False Then 'begin the inheritence
  'Make sure syntax is correct...
  If Not Temp = 2 Then
   debugger "Class.Inherit needs two data elements-- " & Text$
   Exit Sub
  End If
  varType(0) = GetValue(GetElement(GetBrackets(Text$), 1), lit(0), num(0), theProgram)
  varType(1) = GetValue(GetElement(GetBrackets(Text$), 2), lit(1), num(1), theProgram)
  If Not varType(0) = DT_LIT Or Not varType(1) = DT_LIT Then
   debugger "Class.Inherit needs object data elements-- " & Text$
   Exit Sub
  End If
  'If VarBelongsToClass(lit(1), InClass.InheritClass) And VarBelongsToClass(lit(0), InClass.InheritClass) Then
  ' InClass.Inheriting = True
  'Else
  ' debugger "Make sure classes are both valid instances-- " & text$
  ' Exit Sub
  'End If
  InClass.InheritClass = lit(0)
  InClass.InheritFrom = lit(1)
  InClass.Inheriting = True
  RPGCode = "#" & lit(1) & ".Inherit()"
  Dim dummyRet As RPGCODE_RETURN
  'IncreaseClassNestle lit(1)
  DoSingleCommand RPGCode, theProgram, dummyRet
  InClass.Inheriting = False
  'DecreaseClassNestle
 Else 'inherit the properties
  'Make sure the syntax is correct...
  If Not Temp = 1 Then
   debugger "Class.Inherit needs one data element-- " & Text$
   Exit Sub
  End If
  Dim fromClass As String
  fromClass = InClass.InheritFrom
  'fromClass = OnTopOfClassStack()
  varType(0) = GetVariable(fromClass & "." & GetElement(GetBrackets(Text$), 1), lit(0), num(0), theProgram)
  
  Select Case varType(0)
   Case DT_NUM
    CBSetNumerical InClass.InheritClass & "." & GetElement(GetBrackets(Text$), 1), num(0)
   Case DT_LIT
    CBSetString InClass.InheritClass & "." & GetElement(GetBrackets(Text$), 1), lit(0)
  End Select
 End If
 
 Exit Sub
error:
 debugger "Unexpected error with Class.Inherit-- " & error
End Sub

Public Function setReservedStructure( _
                                        ByVal theVar As String, _
                                        ByVal theValue As String, _
                                        ByRef prg As RPGCodeProgram _
                                                                      ) As Boolean

    '====================================================================================
    'Sets a value in a reserved structure [KSNiloc]
    '====================================================================================

    On Error Resume Next
    
    Dim theStructure As String
    theStructure = ParseBefore(ParseBefore(theVar, "."), "[")
    Dim theStructureElement As String
    theStructureElement = ParseWithin(ParseBefore(theVar, "."), "[", "]")
    Dim theProperty As String
    theProperty = ParseAfter(theVar, ".")
    setReservedStructure = True

    Select Case LCase(theStructure)

        Case "player"
            Dim thePlayer As Integer
            thePlayer = CInt(theStructureElement)
            If thePlayer < 0 And thePlayer > 4 Then
                debugger "Subscript out of range-- " & theVar
                Exit Function
            End If
            
            With playerMem(thePlayer)
            
                Select Case LCase(theProperty)
            
                    Case "health", "hp"
                        SetVariable .healthVar, theValue, prg, True
                        
                    Case "maxhealth", "maxhp"
                        SetVariable .maxHealthVar, theValue, prg, True
                        
                    Case "name"
                        SetVariable .nameVar, theValue, prg, True
                        
                    Case "smp"
                        SetVariable .smVar, theValue, prg, True
                        
                    Case "maxsmp"
                        SetVariable .smMaxVar, theValue, prg, True
                        
                    Case "level"
                        SetVariable .leVar, theValue, prg, True
                        
                    Case "fp", "fight", "attack"
                        SetVariable .fightVar, theValue, prg, True
                        
                    Case Else
                        setReservedStructure = False
            
                End Select
            
            End With
        
        Case "board"
        
            With boardList(activeBoardIndex).theData
            
                Select Case LCase(theProperty)
                
                    ' TBD
                
                End Select
            
            End With

        Case Else
            setReservedStructure = False
    
    End Select

End Function
