VERSION 5.00
Begin VB.Form itemmenu 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Item Menu"
   ClientHeight    =   4365
   ClientLeft      =   2190
   ClientTop       =   1815
   ClientWidth     =   5655
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "ITEMMENU.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4365
   ScaleWidth      =   5655
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1295"
   Begin VB.CommandButton cmdDelete 
      Appearance      =   0  'Flat
      Caption         =   "Delete Item"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3840
      TabIndex        =   1
      Tag             =   "1712"
      Top             =   3960
      Width           =   1815
   End
   Begin VB.ListBox proglist 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3420
      Left            =   0
      TabIndex        =   3
      Top             =   360
      Width           =   5655
   End
   Begin VB.CommandButton cmdEditItem 
      Appearance      =   0  'Flat
      Caption         =   "Edit Item Slot"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      TabIndex        =   2
      Tag             =   "1713"
      Top             =   3960
      Width           =   2055
   End
   Begin VB.CommandButton cmdSetItem 
      Appearance      =   0  'Flat
      Caption         =   "Set Item"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Tag             =   "1293"
      Top             =   3960
      Width           =   1815
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Item Menu"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Tag             =   "1295"
      Top             =   0
      Width           =   3375
   End
End
Attribute VB_Name = "itemmenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

' ! MODIFIED BY KSNiloc...

Private Sub cmdEditItem_Click()
    On Error GoTo ErrorHandler
    
    Dim a As Long
    a = proglist.ListIndex
    If a = -1 Then MsgBox LoadStringLoc(966, "Please Select An Item From The Above List First!"): Exit Sub
    boardList(activeBoardIndex).itmCondition = a
    itemset.Show vbModal

    populateList

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub cmdDelete_Click()
    On Error GoTo ErrorHandler
    
    Dim a As Long
    a = proglist.ListIndex
    If a = -1 Then MsgBox LoadStringLoc(966, "Please Select An Item From The Above List First!"): Exit Sub
    
    With boardList(activeBoardIndex).theData
        .itmName(a) = vbNullString   'Board program filenames
        .itmX(a) = 0          'program x
        .itmY(a) = 0          'program y
        .itmLayer(a) = 0      'program layer
        .itmActivate(a) = 0   'program activation: 0- always active, 1- conditional activation.
        .itmVarActivate(a) = vbNullString 'activation variable
        .itmDoneVarActivate(a) = vbNullString 'activation variable at end of prg.
        .itmActivateInitNum(a) = vbNullString 'initial number of activation
        .itmActivateDoneNum(a) = vbNullString 'what to make variable at end of activation.
        .itmActivationType(a) = 0 'activation type- 0-step on, 1- conditional
    End With

    populateList

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub populateList()
    On Error Resume Next
    Call proglist.Clear
    Dim t As Long, nameI As String
    For t = 0 To UBound(boardList(activeBoardIndex).theData.itmName)
        If LenB(boardList(activeBoardIndex).theData.itmName(t)) = 0 Then
            nameI = "None"
        Else
            nameI = boardList(activeBoardIndex).theData.itmName(t)
        End If
        proglist.AddItem "Item" & str(t) & ": " & nameI & "   Location:" & _
            CStr(boardList(activeBoardIndex).theData.itmX(t)) & "," & _
            CStr(boardList(activeBoardIndex).theData.itmY(t)) & ", Layer" & _
            CStr(boardList(activeBoardIndex).theData.itmLayer(t))
    Next t
End Sub

Private Sub cmdSetItem_Click()
    On Error GoTo ErrorHandler
    
    MsgBox LoadStringLoc(946, "To set an item, click on the tile you want")
    boardList(activeBoardIndex).drawState = 3
    boardList(activeBoardIndex).itmCondition = -1
    Unload Me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)

    populateList

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub proglist_DblClick()
    On Error GoTo ErrorHandler
    cmdEditItem_Click

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

