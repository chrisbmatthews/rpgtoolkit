VERSION 5.00
Begin VB.Form programset 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Set Program"
   ClientHeight    =   6300
   ClientLeft      =   1920
   ClientTop       =   1485
   ClientWidth     =   6045
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
   Icon            =   "Programs.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6300
   ScaleWidth      =   6045
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1291"
   Begin VB.CommandButton Command4 
      Caption         =   "Advanced >>"
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
      Left            =   120
      TabIndex        =   7
      Tag             =   "1297"
      Top             =   960
      Width           =   2175
   End
   Begin VB.Frame Frame3 
      Caption         =   "Graphic"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   120
      TabIndex        =   22
      Tag             =   "1548"
      Top             =   2880
      Width           =   5775
      Begin VB.TextBox prggraphic 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   240
         TabIndex        =   24
         Top             =   600
         Width           =   2775
      End
      Begin VB.CommandButton Command2 
         Appearance      =   0  'Flat
         Caption         =   "Browse..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   3120
         TabIndex        =   23
         Tag             =   "1021"
         Top             =   600
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "Display Program As"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   25
         Tag             =   "1549"
         Top             =   360
         Width           =   2535
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Activation"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   120
      TabIndex        =   10
      Tag             =   "1457"
      Top             =   4200
      Width           =   5775
      Begin VB.TextBox prgactivation 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2040
         TabIndex        =   14
         Text            =   "BoardName[XXYYLR]!"
         Top             =   840
         Width           =   2175
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Always Active"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   16
         Tag             =   "1459"
         Top             =   360
         Value           =   -1  'True
         Width           =   1815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Conditional Activation"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Tag             =   "1458"
         Top             =   600
         Width           =   2295
      End
      Begin VB.TextBox prgequals 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   4800
         TabIndex        =   13
         Text            =   "0"
         Top             =   840
         Width           =   735
      End
      Begin VB.TextBox afterprgvar 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2280
         TabIndex        =   12
         Text            =   "BoardName[XXYYLR]!"
         Top             =   1200
         Width           =   2175
      End
      Begin VB.TextBox afteractivate 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   4800
         TabIndex        =   11
         Text            =   "1"
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "Active If Variable"
         Enabled         =   0   'False
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
         Left            =   120
         TabIndex        =   21
         Tag             =   "1462"
         Top             =   840
         Width           =   1815
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         Caption         =   "="
         Enabled         =   0   'False
         Height          =   255
         Left            =   4440
         TabIndex        =   20
         Tag             =   "1461"
         Top             =   1200
         Width           =   375
      End
      Begin VB.Label Label3 
         Alignment       =   2  'Center
         Caption         =   "Note:  If you only want to run the program once, click on Conditional Activation and leave the defaults."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   495
         Left            =   2280
         TabIndex        =   19
         Tag             =   "1550"
         Top             =   240
         Width           =   3375
      End
      Begin VB.Label Label5 
         Caption         =   "="
         Height          =   255
         Left            =   4440
         TabIndex        =   18
         Tag             =   "1461"
         Top             =   840
         Width           =   255
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "After Activation,"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   120
         TabIndex        =   17
         Tag             =   "1463"
         Top             =   1200
         Width           =   1935
      End
   End
   Begin VB.TextBox prgfilename 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   120
      TabIndex        =   8
      Top             =   600
      Width           =   2775
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
      Left            =   3600
      TabIndex        =   5
      Tag             =   "1291"
      Top             =   960
      Width           =   2295
   End
   Begin VB.Frame Frame1 
      Caption         =   "Activation Type"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   120
      TabIndex        =   2
      Tag             =   "1467"
      Top             =   1680
      Width           =   5775
      Begin VB.OptionButton Option4 
         Caption         =   "Player Presses Activation Key Beside Program"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Tag             =   "1551"
         Top             =   600
         Width           =   5295
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Player Steps On This Program"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Tag             =   "1552"
         Top             =   360
         Value           =   -1  'True
         Width           =   5175
      End
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Browse..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   3000
      TabIndex        =   1
      Tag             =   "1021"
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label9 
      Caption         =   "Filename"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Tag             =   "1470"
      Top             =   360
      Width           =   2055
   End
   Begin VB.Label link1 
      Caption         =   "Also see RPGCode Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   4080
      MouseIcon       =   "Programs.frx":0CCA
      MousePointer    =   99  'Custom
      TabIndex        =   6
      Tag             =   "1150"
      Top             =   600
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label setat 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Set Program at X, Y, Layer layer"
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
      Tag             =   "1553"
      Top             =   0
      Width           =   5655
   End
End
Attribute VB_Name = "programset"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984


Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Program Filename"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
'        dirlink$(1) = antipath$
    prgfilename.Text = antiPath$
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    
    dlg.strTitle = "Program Graphic"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "Supported Files|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tiles$ + antiPath$
    whichType$ = extention(filename$(1))
    If UCase$(whichType$) = "TST" Then      'Yipes! we've selected an archive!
        tstFile$ = antiPath$
        configfile.lastTileset$ = tstFile$
        tilesetform.Show 1
        'MsgBox setFilename$
        If setFilename$ = "" Then Exit Sub
        antiPath$ = setFilename$
    End If
    prggraphic.Text = antiPath$
End Sub

Private Sub Command3_Click()
'search for a free program space.
    On Error GoTo ErrorHandler
thisProgram = -1
For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
    If boardList(activeBoardIndex).theData.programName$(t) = "" Then thisProgram = t: t = UBound(boardList(activeBoardIndex).theData.programName)
Next t
If boardList(activeBoardIndex).prgCondition <> -1 Then thisProgram = boardList(activeBoardIndex).prgCondition
If thisProgram = -1 Then MsgBox LoadStringLoc(975, "This board already has 500 programs.  This is the set limit."), , LoadStringLoc(976, "Too many programs."): Exit Sub
If prgfilename.Text = LoadStringLoc(1010, "None") Or prgfilename.Text = "" Then
    Unload programset
    Exit Sub
End If
boardList(activeBoardIndex).theData.programName$(thisProgram) = prgfilename.Text
boardList(activeBoardIndex).theData.progX(thisProgram) = boardList(activeBoardIndex).infoX              'program x
boardList(activeBoardIndex).theData.progY(thisProgram) = boardList(activeBoardIndex).infoY              'program y
boardList(activeBoardIndex).theData.progLayer(thisProgram) = boardList(activeBoardIndex).currentLayer   'program layer
boardList(activeBoardIndex).theData.progGraphic$(thisProgram) = prggraphic.Text  'program graphic
If Option1.value = True Then
    boardList(activeBoardIndex).theData.progActivate(thisProgram) = 0   'program activation: 0- always active, 1- conditional activation.
    Else
    boardList(activeBoardIndex).theData.progActivate(thisProgram) = 1
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.progVarActivate$(thisProgram) = prgactivation.Text 'activation variable
    Else
    boardList(activeBoardIndex).theData.progVarActivate$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.progDoneVarActivate$(thisProgram) = afterprgvar.Text 'activation variable at end of prg.
    Else
    boardList(activeBoardIndex).theData.progDoneVarActivate$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.activateInitNum$(thisProgram) = prgequals.Text 'initial number of activation
    Else
    boardList(activeBoardIndex).theData.activateInitNum$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.activateDoneNum$(thisProgram) = afteractivate.Text    'what to make variable at end of activation.
    Else
    boardList(activeBoardIndex).theData.activateDoneNum$(thisProgram) = ""
End If
If Option3.value = True Then
    boardList(activeBoardIndex).theData.activationType(thisProgram) = 0 'activation type- 0-step on, 1- conditional
    Else
    boardList(activeBoardIndex).theData.activationType(thisProgram) = 1
End If
boardList(activeBoardIndex).theData.progGraphic$(thisProgram) = prggraphic.Text

Unload programset

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo ErrorHandler

    If programset.height = 2010 Then
        Command4.Caption = LoadStringLoc(911, "Advanced <<")
        programset.height = 6700
    Else
        Command4.Caption = LoadStringLoc(912, "Advanced >>")
        programset.height = 2010
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    programset.height = 2010
    
    setat.Caption = str$(boardList(activeBoardIndex).infoX) + "," + str$(boardList(activeBoardIndex).infoY) + " Layer" + str$(boardList(activeBoardIndex).currentLayer)

    thevar$ = "BoardName[" + str$(boardList(activeBoardIndex).infoX) + str$(boardList(activeBoardIndex).infoY) + str$(boardList(activeBoardIndex).currentLayer) + "]!"
    thevar$ = noSpaces(thevar$)
    prgactivation.Text = thevar$
    afterprgvar.Text = thevar$
    If boardList(activeBoardIndex).prgCondition = -1 Then Exit Sub     'we are starting a new prg.
    'If we are here, that means we are looking at a previously set prg.
    thisProgram = boardList(activeBoardIndex).prgCondition
    prgfilename.Text = boardList(activeBoardIndex).theData.programName$(thisProgram)
    If boardList(activeBoardIndex).theData.progX(thisProgram) <> 0 Then boardList(activeBoardIndex).infoX = boardList(activeBoardIndex).theData.progX(thisProgram)
    If boardList(activeBoardIndex).theData.progY(thisProgram) <> 0 Then boardList(activeBoardIndex).infoY = boardList(activeBoardIndex).theData.progY(thisProgram)
    prglayer = boardList(activeBoardIndex).theData.progLayer(thisProgram)
    prggraphic.Text = boardList(activeBoardIndex).theData.progGraphic$(thisProgram)
    If boardList(activeBoardIndex).theData.progActivate(thisProgram) = 0 Then
        Option1.value = True
        Else
        Option2.value = True
        prgactivation.Text = boardList(activeBoardIndex).theData.progVarActivate$(thisProgram)
        afterprgvar.Text = boardList(activeBoardIndex).theData.progDoneVarActivate$(thisProgram)
        prgequals.Text = boardList(activeBoardIndex).theData.activateInitNum$(thisProgram)
        afteractivate.Text = boardList(activeBoardIndex).theData.activateDoneNum$(thisProgram)
    End If
If boardList(activeBoardIndex).theData.activationType(thisProgram) = 0 Then
    Option3.value = True
    Else
    Option4.value = True
End If
    setat.Caption = str$(boardList(activeBoardIndex).infoX) + "," + str$(boardList(activeBoardIndex).infoY) + " Layer" + str$(prglayer)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

' !NEW!
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'My god, Vampz =P... [KSNiloc]

    tkMainForm.boardToolbar.Objects.Populate
End Sub

Private Sub link1_Click()
    On Error GoTo ErrorHandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option1_Click()
    On Error GoTo ErrorHandler
    Label2.Enabled = False
    prgactivation.Enabled = False
    prgequals.Enabled = False
    afterprgvar.Enabled = False
    Label4.Enabled = False
    afteractivate.Enabled = False


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option2_Click()
    On Error GoTo ErrorHandler
    Label2.Enabled = True
    prgactivation.Enabled = True
    prgequals.Enabled = True
    afterprgvar.Enabled = True
    Label4.Enabled = True
    afteractivate.Enabled = True


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option3_Click()
    'check2.Enabled = False
    'check3.Enabled = False
    On Error GoTo ErrorHandler


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


