VERSION 5.00
Begin VB.Form dbwin 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPGCode Debugger"
   ClientHeight    =   6285
   ClientLeft      =   150
   ClientTop       =   840
   ClientWidth     =   8160
   Icon            =   "debugger.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6285
   ScaleWidth      =   8160
   StartUpPosition =   3  'Windows Default
   Tag             =   "1906"
   Begin VB.CommandButton Command8 
      Caption         =   "Insert Line"
      Height          =   255
      Left            =   6240
      TabIndex        =   12
      Tag             =   "1869"
      Top             =   480
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Breakpoint"
      Height          =   255
      Left            =   6240
      TabIndex        =   3
      Tag             =   "1996"
      Top             =   240
      Width           =   1455
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Delete Line"
      Height          =   255
      Left            =   4440
      TabIndex        =   10
      Tag             =   "1868"
      Top             =   480
      Width           =   1455
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Modify Line"
      Height          =   255
      Left            =   4440
      TabIndex        =   11
      Tag             =   "1997"
      Top             =   0
      Width           =   1455
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Toggle Step Into"
      Height          =   255
      Left            =   6240
      TabIndex        =   7
      Tag             =   "1998"
      Top             =   0
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Delete Watch"
      Height          =   255
      Left            =   3360
      TabIndex        =   6
      Tag             =   "1999"
      Top             =   6000
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Modify Variable"
      Height          =   255
      Left            =   6720
      TabIndex        =   5
      Tag             =   "2000"
      Top             =   6000
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Add Watch"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Tag             =   "2001"
      Top             =   6000
      Width           =   1215
   End
   Begin VB.ListBox watchlist 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   120
      TabIndex        =   2
      Top             =   5040
      Width           =   7815
   End
   Begin VB.ListBox codewin 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3900
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   7815
   End
   Begin VB.Label Label2 
      Caption         =   "Press ENTER to step thru your code"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Tag             =   "2002"
      Top             =   240
      Width           =   2655
   End
   Begin VB.Label stin 
      Caption         =   "Off"
      Height          =   255
      Left            =   7800
      TabIndex        =   8
      Tag             =   "1175"
      Top             =   0
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Watch"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Tag             =   "2003"
      Top             =   4800
      Width           =   975
   End
   Begin VB.Menu dbmnu 
      Caption         =   "Debug"
      Tag             =   "1625"
      Begin VB.Menu savemnu 
         Caption         =   "Save"
         Tag             =   "1233"
      End
      Begin VB.Menu runmnu 
         Caption         =   "Run"
         Shortcut        =   {F5}
         Tag             =   "1623"
      End
      Begin VB.Menu stepinmnu 
         Caption         =   "Toggle Step Into"
         Shortcut        =   {F11}
         Tag             =   "1998"
      End
   End
End
Attribute VB_Name = "dbwin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub codewin_DblClick()
    On Error GoTo errorhandler
    Call Command7_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    'add watch...
    On Error GoTo errorhandler
    wtoadd$ = InputBox$(LoadStringLoc(872, "Please type a variable name to watch:"), LoadStringLoc(860, "Add Watch"))
    'wtoadd$ = DoPrompt(LoadStringLoc(860, "Add Watch"), LoadStringLoc(872, "Please type a variable name to watch:"))
    Call DBAddWatch(wtoadd$)
    Call DBFillWatchWindow
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    If codewin.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(857, "Please select a line to break at!"), LoadStringLoc(858, "Set Breakpoint"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Plase select a line to break at!", , "Set Breakpoint"
    Else
        Call DBInsertPrgLine("#BREAK()", codewin.ListIndex, 0)
        DBWinFilled = False
        Call DBFillCodeWindow
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command3_Click()
    On Error GoTo errorhandler
    If watchlist.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(859, "Please select a variable from the watch list first!"), LoadStringLoc(860, "Watch"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Please select a varibale from the watch list first!"
        codewin.SetFocus
    Else
        t = watchlist.ListIndex
        If DBWatchVars$(t) <> "" Then
            Dim n As Double
            a = GetIndependentVariable(DBWatchVars$(t), l$, n)
            If a = 0 Then
                'numerical
                valu$ = str$(n)
            Else
                'literal
                valu$ = l$
            End If
            dbwin.watchlist.AddItem (DBWatchVars$(t) + "     " + valu$)
            newVal$ = InputBox(LoadStringLoc(873, "Please enter a new value for ") + DBWatchVars$(t), LoadStringLoc(874, "Modify variable"), valu$)
            'newVal$ = DoPrompt(LoadStringLoc(874, "Modify variable"), LoadStringLoc(873, "Please enter a new value for ") + DBWatchVars$(t), valu$)
            Call setIndependentVariable(DBWatchVars$(t), newVal$)
            Call DBFillWatchWindow
        End If
        codewin.SetFocus
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command4_Click()
    On Error GoTo errorhandler
    If watchlist.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(859, "Please select a variable from the watch list first!"), LoadStringLoc(860, "Watch"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Please select a varibale from the watch list first!"
        codewin.SetFocus
    Else
        t = watchlist.ListIndex
        If DBWatchVars$(t) <> "" Then
            DBWatchVars$(t) = ""
            Call DBFillWatchWindow
        End If
        codewin.SetFocus
        
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command5_Click()
    On Error GoTo errorhandler
    DBMethodStep = Not (DBMethodStep)
    If DBMethodStep Then
        stin.caption = LoadStringLoc(893, "On")
    Else
        stin.caption = LoadStringLoc(894, "Off")
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    On Error GoTo errorhandler
    If codewin.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(861, "Please select a line to delete!"), LoadStringLoc(862, "Delete line"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Plase select a line to delete!", , "Delete line"
    Else
        Call DBRemoveLine(codewin.ListIndex, 0)
        DBWinFilled = False
        Call DBFillCodeWindow
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command7_Click()
    On Error GoTo errorhandler
    If codewin.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(863, "Please select a line to modify!"), LoadStringLoc(864, "Modify line"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Plase select a line to modify!", , "Modify line"
    Else
        lnum = codewin.ListIndex
        
        md$ = InputBox$(LoadStringLoc(875, "Please modify the code:"), LoadStringLoc(876, "Code Modification"), program(0).program$(lnum))
        'md$ = DoPrompt(LoadStringLoc(876, "Code Modification"), LoadStringLoc(875, "Please modify the code:"), program(0).program$(lnum))
        If md$ <> "" Then
            program(0).program$(lnum) = md$
        End If
        DBWinFilled = False
        Call DBFillCodeWindow
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command8_Click()
    On Error GoTo errorhandler
    If codewin.ListIndex = -1 Then
        abc = MBox(LoadStringLoc(865, "Please select a line to insert at!"), LoadStringLoc(866, "Insert Line"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "Plase select a line to insert at!", , "Insert Line"
    Else
        Call DBInsertPrgLine("", codewin.ListIndex, 0)
        DBWinFilled = False
        Call DBFillCodeWindow
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Activate()
    On Error GoTo errorhandler
    If DBMethodStep Then
        stin.caption = LoadStringLoc(893, "On")
    Else
        stin.caption = LoadStringLoc(894, "Off")
    End If
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_KeyDown(keyCode As Integer, shift As Integer)
    On Error GoTo errorhandler
keyWaitState = keyCode
keyShiftState = shift

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    If DBMethodStep Then
        stin.caption = LoadStringLoc(893, "On")
    Else
        stin.caption = LoadStringLoc(894, "Off")
    End If
    'codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub methodstep1_Click()
    On Error GoTo errorhandler
    DBMethodStep = Not (DBMethodStep)
    codewin.SetFocus

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo errorhandler
    debugging = False
    keyWaitState = 1
    keyShiftState = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub runmnu_Click()
    On Error GoTo errorhandler
    debugging = False
    keyWaitState = 1
    keyShiftState = 1
    Unload dbwin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub savemnu_Click()
    On Error Resume Next
    Dim cmp As Boolean
    
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    dlg.strTitle = "Save Program As"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If SaveFileDialog(dlg) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    
    If filename$(1) = "" Then Exit Sub
    
    If FileExists(filename$(1)) Then
        bb = MsgBox("That file exists.  Are you sure you want to overwrite it?", vbYesNo, "Save")
        If bb = 7 Then Exit Sub
    End If
    
    Call DBSaveProgram(filename$(1), 0)
End Sub

Private Sub stepinmnu_Click()
    On Error GoTo errorhandler
    Command5_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub stepovrmnu_Click()
End Sub


Private Sub watchlist_DblClick()
    Call Command3_Click
End Sub


