VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cBoardToolbar_Objects"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' BOARD TOOLBAR > OBJECTS v1.0
' DESIGNED AND CODED BY PHIL CARTY (AKA VAMPZ)
'========================================================================
' The toolbar allows users to manage programs, items, and warps on the
' board they are editing. Allowing them to edit, remove and even open
' the object to edit.
'
' If you'd like to discuss the tool, feel free to post on the open source
' forum at TKZ.
'========================================================================

Option Explicit

'========================================================================
' LOCAL VARIABLES
'========================================================================
Private mBoard As Long
Private mCount As Integer
Private mDisplay As Integer ' 0 - By Type, 1 - By Layer, 2 - Current Layer
Private mPrefix(3) As uPrefix
Private mSelected As Integer ' 0 - Program, 1 - Item, 2 - Warp
Private mObject As Integer

Private Enum ePrefix
    eProgram = 0
    eItem
    eWarp
    eLayer
End Enum

Private Type uPrefix
    Prefix As String * 1
    name As String
    Enum As ePrefix
End Type

'========================================================================
' PUBLIC PROPERTIES
'========================================================================
Property Get Display() As Integer
    Display = mDisplay
End Property
Property Let Display(ByVal newValue As Integer)
    mDisplay = newValue
    Populate (mBoard)
End Property
Property Get Selected() As Integer ' Read Only
    Selected = mSelected
End Property

'========================================================================
' POPULATES - Public procedure that is called to populate the tree view.
'========================================================================
Public Sub Populate(Optional ByVal board As Long = -1)

    ' KSNiloc: need to handle errors
    On Error Resume Next

    ' update local variable
    If board <> -1 Then
        mBoard = board
    End If
    
    ' clear all nodes
    tkMainForm.bTools_Objects_Tree.Nodes.Clear
    
    ' populate tree view
    Select Case mDisplay
        Case 0
            Populate_Layers eProgram
            Populate_Layers eItem
            Populate_Layers eWarp
        Case 1
            Populate_Layers
        Case 2
            Populate_Layers eLayer
    End Select

End Sub

'========================================================================
' POPULATES_PROGRAMS - Fills the tree view with boards programs.
'========================================================================
Private Sub Populate_Programs(layer As Integer)
    
    Dim i As Integer, name As String, count As Integer, keytmp As String
    
    count = 0

    ' loop through and add programs (exc. warps)
    For i = 0 To UBound(boardList(mBoard).theData.programName)
        If boardList(mBoard).theData.programName(i) <> "" Then
            If Left(boardList(mBoard).theData.programName(i), 4) <> "warp" Then
                If boardList(mBoard).theData.progLayer(i) = layer Then
                    
                    ' add tree node
                    name = boardList(mBoard).theData.programName(i) & " (" & Trim(str(boardList(mBoard).theData.progX(i))) & "," & Trim(str(boardList(mBoard).theData.progY(i))) & ")"
                    count = count + 1
                    Call tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(eProgram, eLayer, layer), tvwChild, Key(eProgram, eProgram, i), name)
                    
                End If
            End If
        End If
    Next i
    
    ' if no items added, remove parent node
    If count = 0 Then
        tkMainForm.bTools_Objects_Tree.Nodes.Remove (Key(eProgram, eLayer, layer))
    End If
    
    If mDisplay = 1 Then mCount = mCount + count

End Sub

'========================================================================
' POPULATE_ITEMS - Fills the tree view with boards objects.
'========================================================================
Private Sub Populate_Items(Optional layer As Integer)
 
    Dim i As Integer, name As String, count As Integer, keytmp As String
    
    count = 0

    ' loop through and add programs (exc. warps)
    For i = 0 To UBound(boardList(mBoard).theData.itmName)
        If boardList(mBoard).theData.itmName(i) <> "" Then
            If boardList(mBoard).theData.itmLayer(i) = layer Then
                    
                ' add tree node
                name = boardList(mBoard).theData.itmName(i) & " (" & Trim(str(boardList(mBoard).theData.itmX(i))) & "," & Trim(str(boardList(mBoard).theData.itmY(i))) & ")"
                count = count + 1
                Call tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(eItem, eLayer, layer), tvwChild, Key(eItem, eItem, i), name)
                    
            End If
        End If
    Next i
    
    ' if no items added, remove parent node
    If count = 0 Then
        tkMainForm.bTools_Objects_Tree.Nodes.Remove (Key(eItem, eLayer, layer))
    End If
 
    If mDisplay = 1 Then mCount = mCount + count
 
End Sub

'========================================================================
' POPULATE_WARPS - Fills the tree view with boards warps.
'========================================================================
Private Sub Populate_Warps(layer As Integer)

    Dim i As Integer, name As String, count As Integer, keytmp As String
    
    count = 0
    
    ' loop through and add programs (exc. warps)
    For i = 0 To UBound(boardList(mBoard).theData.programName)
        If boardList(mBoard).theData.programName(i) <> "" Then
            If Left(boardList(mBoard).theData.programName(i), 4) = "warp" Then
                If boardList(mBoard).theData.progLayer(i) = layer Then
                    
                    ' add tree node
                    name = boardList(mBoard).theData.programName(i) & " (" & Trim(str(boardList(mBoard).theData.progX(i))) & "," & Trim(str(boardList(mBoard).theData.progY(i))) & ")"
                    count = count + 1
                    Call tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(eWarp, eLayer, layer), tvwChild, Key(eWarp, eWarp, i), name)
                    
                End If
            End If
        End If
    Next i
    
    ' if no items added, remove parent node
    If count = 0 Then
        tkMainForm.bTools_Objects_Tree.Nodes.Remove (Key(eWarp, eLayer, layer))
    End If
    
    If mDisplay = 1 Then mCount = mCount + count

End Sub

'========================================================================
' POPULATE_LAYERS - Loops through layers, adding objects
'========================================================================
Private Sub Populate_Layers(Optional parent As ePrefix)

    Dim i As Integer, j As Integer, start As Integer, fend As Integer

    ' set start and end values for loop
    start = 1
    fend = boardList(mBoard).theData.Bsizel

    ' see if specific operation is defined
    If IsMissing(parent) = False And mDisplay <> 1 Then
    
        ' if current layer call
        If parent = eLayer Then
        
            ' set new start and end values
            start = boardList(mBoard).currentLayer
            fend = boardList(mBoard).currentLayer
            
        Else
        
            ' else add object type node
            With tkMainForm.bTools_Objects_Tree.Nodes.Add(, , Key(parent), mPrefix(parent).name)
                .Bold = True: .Expanded = True
            End With
            
        End If
        
    End If
    
    ' loop through layers
    For i = start To fend
        
        ' add layer node
        If Not IsMissing(parent) And mDisplay <> 1 Then
            If parent = eLayer Then
                With tkMainForm.bTools_Objects_Tree.Nodes.Add(, , Key(eLayer, , i), "current " & mPrefix(parent).name)
                    .Bold = True: .Expanded = True
                End With
            Else
                With tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(parent), tvwChild, Key(parent, eLayer, i), mPrefix(eLayer).name & " " & i)
                    .Bold = True: .Expanded = True
                End With
            End If
        Else
            With tkMainForm.bTools_Objects_Tree.Nodes.Add(, , Key(eLayer, , i), mPrefix(eLayer).name & " " & i)
                .Bold = True: .Expanded = True
            End With
        End If
        
        ' take appropiate action depending on display and parent
        Select Case mDisplay
            Case 0
                Populate_Object parent, i
            Case 1
                ' loop through three object types
                mCount = 0
                For j = 0 To 2
                    
                    ' add node
                    With tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(eLayer, , i), tvwChild, Key(mPrefix(j).Enum, eLayer, i), mPrefix(j).name)
                        .Bold = True: .Expanded = True
                    End With
                    Populate_Object mPrefix(j).Enum, i
                    
                Next j
                If mCount = 0 Then tkMainForm.bTools_Objects_Tree.Nodes.Remove (Key(eLayer, , i))
            Case 2
                For j = 0 To 2
                    
                    ' add node
                    With tkMainForm.bTools_Objects_Tree.Nodes.Add(Key(eLayer, , i), tvwChild, Key(mPrefix(j).Enum, eLayer, i), mPrefix(j).name)
                        .Bold = True: .Expanded = True
                    End With
                    Populate_Object mPrefix(j).Enum, i
                    
                Next j
        End Select
        
    Next i
    
End Sub

'========================================================================
' POPULATE_OBJECT - Calls the appropiate object routine
'========================================================================
Private Sub Populate_Object(object As ePrefix, layer As Integer)
    Select Case object
        Case eProgram
            Populate_Programs (layer)
        Case eItem
            Populate_Items (layer)
        Case eWarp
            Populate_Warps (layer)
    End Select
End Sub

'========================================================================
' KEY - Create appropiate key for treeview item.
'========================================================================
Private Function Key(Prefix As ePrefix, Optional tag As ePrefix, Optional id As Integer = -1) As String
    Key = mPrefix(Prefix).Prefix
    If IsMissing(tag) = False Then Key = Key & "_" & mPrefix(tag).Prefix
    If id <> -1 Then Key = Key & "_" & id
End Function

'========================================================================
' CLICK - Object is selected, so popup menu
'========================================================================
Public Sub click()
    Dim valid As Boolean
    Select Case Left(tkMainForm.bTools_Objects_Tree.SelectedItem.Key, 4)
        Case "p_p_"
            mSelected = 0: valid = True
        Case "i_i_"
            mSelected = 1: valid = True
        Case "w_w_"
            mSelected = 2: valid = True
    End Select
    If valid = True Then
        mObject = Right(tkMainForm.bTools_Objects_Tree.SelectedItem.Key, 1)
        activeBoard.PopupMenu activeBoard.mTB
    End If
End Sub

'========================================================================
' SETTINGS - Open edit object form
'========================================================================
Public Sub Settings()
    Select Case mSelected
        Case 0, 2
            boardList(activeBoardIndex).prgCondition = mObject
            programset.Show vbModal
        Case 1
            boardList(activeBoardIndex).itmCondition = mObject
            itemset.Show vbModal
    End Select
End Sub

'========================================================================
' REMOVE - Remove object
'========================================================================
Public Sub Remove()
    Select Case mSelected
        Case 0, 2
            boardList(activeBoardIndex).theData.programName$(mObject) = ""
            boardList(activeBoardIndex).theData.progX(mObject) = 0
            boardList(activeBoardIndex).theData.progY(mObject) = 0
            boardList(activeBoardIndex).theData.progLayer(mObject) = 0
            boardList(activeBoardIndex).theData.progGraphic$(mObject) = ""
            boardList(activeBoardIndex).theData.progActivate(mObject) = 0
            boardList(activeBoardIndex).theData.progVarActivate$(mObject) = ""
            boardList(activeBoardIndex).theData.progDoneVarActivate$(mObject) = ""
            boardList(activeBoardIndex).theData.activateInitNum$(mObject) = ""
            boardList(activeBoardIndex).theData.activateDoneNum$(mObject) = ""
            boardList(activeBoardIndex).theData.activationType(mObject) = 0
        Case 1
            boardList(activeBoardIndex).theData.itmName$(mObject) = ""
            boardList(activeBoardIndex).theData.itmX(mObject) = 0
            boardList(activeBoardIndex).theData.itmY(mObject) = 0
            boardList(activeBoardIndex).theData.itmLayer(mObject) = 0
            boardList(activeBoardIndex).theData.itmActivate(mObject) = 0
            boardList(activeBoardIndex).theData.itmVarActivate$(mObject) = ""
            boardList(activeBoardIndex).theData.itmDoneVarActivate$(mObject) = ""
            boardList(activeBoardIndex).theData.itmActivateInitNum$(mObject) = ""
            boardList(activeBoardIndex).theData.itmActivateDoneNum$(mObject) = ""
            boardList(activeBoardIndex).theData.itmActivationType(mObject) = 0
    End Select
    activeBoard.boardRedraw: Populate
End Sub

'========================================================================
' EDIT - Edit object (ie: the program itself, the item itself)
'========================================================================
Public Sub Edit()
    Dim mObjEdit As String
    Select Case mSelected
        Case 0, 2
            mObjEdit = "Prg/" & boardList(activeBoardIndex).theData.programName(mObject)
        Case 1
            mObjEdit = "Item/" & boardList(activeBoardIndex).theData.itmName(mObject)
    End Select
    If FileExists(projectPath$ + mObjEdit) Then
        Call tkMainForm.openFile(projectPath$ + mObjEdit)
    Else
        MsgBox ("The object could not be found!")
    End If
End Sub

'========================================================================
' INITIALISE - Initialise class
'========================================================================
Private Sub Class_Initialize()
    ' populate prefixes
    mPrefix(0).Prefix = "p"
    mPrefix(0).name = "programs"
    mPrefix(0).Enum = eProgram
    mPrefix(1).Prefix = "i"
    mPrefix(1).name = "items"
    mPrefix(1).Enum = eItem
    mPrefix(2).Prefix = "w"
    mPrefix(2).name = "warps"
    mPrefix(2).Enum = eWarp
    mPrefix(3).Prefix = "l"
    mPrefix(3).name = "layer"
    mPrefix(3).Enum = eLayer

    ' set display value
    mDisplay = 0
    
    ' set control value
    tkMainForm.bTools_Objects_Display(mDisplay).value = True
End Sub
