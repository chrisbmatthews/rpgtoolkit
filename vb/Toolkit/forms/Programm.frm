VERSION 5.00
Begin VB.Form programmenu 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPGCode Program Menu"
   ClientHeight    =   4095
   ClientLeft      =   2100
   ClientTop       =   1620
   ClientWidth     =   5640
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
   Icon            =   "Programm.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4095
   ScaleWidth      =   5640
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1797"
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Delete Program"
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
      TabIndex        =   3
      Tag             =   "1798"
      Top             =   3720
      Width           =   1815
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Edit Program Slot"
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
      Tag             =   "1799"
      Top             =   3720
      Width           =   2055
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
      Height          =   3210
      Left            =   0
      TabIndex        =   1
      Top             =   360
      Width           =   5655
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "Set Program"
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
      TabIndex        =   4
      Tag             =   "1291"
      Top             =   3720
      Width           =   1815
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "RPGCode Program Menu"
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
      TabIndex        =   0
      Tag             =   "1797"
      Top             =   0
      Width           =   5055
   End
End
Attribute VB_Name = "programmenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub Command1_Click()
    On Error GoTo errorhandler
    a = proglist.ListIndex
    If a = -1 Then MsgBox LoadStringLoc(987, "Please Select A Program From The Above List First!"): Exit Sub
    boardList(activeBoardIndex).prgCondition = a
    programset.Show vbModal ', me
    proglist.Clear
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(t) = "" Then namei$ = LoadStringLoc(1010, "None") Else namei$ = boardList(activeBoardIndex).theData.programName$(t)
        proglist.AddItem "Program" + str$(t) + ": " + namei$ + "   Location:" + str$(boardList(activeBoardIndex).theData.progX(t)) + "," + str$(boardList(activeBoardIndex).theData.progY(t)) + ", Layer" + str$(boardList(activeBoardIndex).theData.progLayer(t))
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    a = proglist.ListIndex
    If a = -1 Then MsgBox LoadStringLoc(987, "Please Select A Program From The Above List First!"): Exit Sub
    boardList(activeBoardIndex).theData.programName$(a) = ""   'Board program filenames
    boardList(activeBoardIndex).theData.progX(a) = 0          'program x
    boardList(activeBoardIndex).theData.progY(a) = 0          'program y
    boardList(activeBoardIndex).theData.progLayer(a) = 0      'program layer
    boardList(activeBoardIndex).theData.progGraphic$(a) = ""   'program graphic
    boardList(activeBoardIndex).theData.progActivate(a) = 0   'program activation: 0- always active, 1- conditional activation.
    boardList(activeBoardIndex).theData.progVarActivate$(a) = "" 'activation variable
    boardList(activeBoardIndex).theData.progDoneVarActivate$(a) = "" 'activation variable at end of prg.
    boardList(activeBoardIndex).theData.activateInitNum$(a) = "" 'initial number of activation
    boardList(activeBoardIndex).theData.activateDoneNum$(a) = "" 'what to make variable at end of activation.
    boardList(activeBoardIndex).theData.activationType(a) = 0 'activation type- 0-step on, 1- conditional

    proglist.Clear
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(t) = "" Then namei$ = LoadStringLoc(1010, "None") Else namei$ = boardList(activeBoardIndex).theData.programName$(t)
        proglist.AddItem "Program" + str$(t) + ": " + namei$ + "   Location:" + str$(boardList(activeBoardIndex).theData.progX(t)) + "," + str$(boardList(activeBoardIndex).theData.progY(t)) + ", Layer" + str$(boardList(activeBoardIndex).theData.progLayer(t))
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    MsgBox LoadStringLoc(948, "To set a program, click on the tile you want")
    boardList(activeBoardIndex).drawState = 2
    boardList(activeBoardIndex).prgCondition = -1
    Unload programmenu

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    proglist.Clear
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(t) = "" Then namei$ = LoadStringLoc(1010, "None") Else namei$ = boardList(activeBoardIndex).theData.programName$(t)
        proglist.AddItem "Program" + str$(t) + ": " + namei$ + "   Location:" + str$(boardList(activeBoardIndex).theData.progX(t)) + "," + str$(boardList(activeBoardIndex).theData.progY(t)) + ", Layer" + str$(boardList(activeBoardIndex).theData.progLayer(t))
    Next t


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub proglist_DblClick()
    On Error GoTo errorhandler
    Command1_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

