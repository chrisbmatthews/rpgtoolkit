VERSION 5.00
Begin VB.Form itemset 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Set Item"
   ClientHeight    =   6600
   ClientLeft      =   2055
   ClientTop       =   1485
   ClientWidth     =   6030
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
   Icon            =   "ITEMSET.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6491.803
   ScaleMode       =   0  'User
   ScaleWidth      =   6030
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1293"
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
      TabIndex        =   29
      Tag             =   "1297"
      Top             =   960
      Width           =   2175
   End
   Begin VB.Frame Frame3 
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
      Height          =   1695
      Left            =   120
      TabIndex        =   17
      Tag             =   "1457"
      Top             =   4680
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
         TabIndex        =   18
         Text            =   "BoardName[XXYYLR]!"
         Top             =   840
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
         TabIndex        =   23
         Text            =   "1"
         Top             =   1200
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
         TabIndex        =   22
         Text            =   "BoardName[XXYYLR]!"
         Top             =   1200
         Width           =   2175
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
         TabIndex        =   21
         Text            =   "0"
         Top             =   840
         Width           =   735
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
         TabIndex        =   20
         Tag             =   "1458"
         Top             =   600
         Width           =   2295
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
         TabIndex        =   19
         Tag             =   "1459"
         Top             =   360
         Value           =   -1  'True
         Width           =   2055
      End
      Begin VB.Label Label3 
         Alignment       =   2  'Center
         Caption         =   "Note:  If you only want to run the item once, click on Conditional Activation and leave the defaults."
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
         TabIndex        =   28
         Tag             =   "1460"
         Top             =   240
         Width           =   3255
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         Caption         =   "="
         Enabled         =   0   'False
         Height          =   255
         Left            =   4440
         TabIndex        =   27
         Tag             =   "1461"
         Top             =   1200
         Width           =   375
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
         TabIndex        =   26
         Tag             =   "1462"
         Top             =   840
         Width           =   1815
      End
      Begin VB.Label Label5 
         Caption         =   "="
         Height          =   255
         Left            =   4440
         TabIndex        =   25
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
         Height          =   375
         Left            =   120
         TabIndex        =   24
         Tag             =   "1463"
         Top             =   1200
         Width           =   1935
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "RPGCode"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   120
      TabIndex        =   9
      Tag             =   "1196"
      Top             =   2640
      Width           =   5775
      Begin VB.TextBox multi 
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
         TabIndex        =   13
         Top             =   1200
         Width           =   3015
      End
      Begin VB.TextBox iprg 
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
         TabIndex        =   12
         Top             =   600
         Width           =   2895
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
         Left            =   3360
         TabIndex        =   11
         Tag             =   "1021"
         Top             =   600
         Width           =   1095
      End
      Begin VB.CommandButton Command5 
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
         Left            =   3360
         TabIndex        =   10
         Tag             =   "1021"
         Top             =   1200
         Width           =   1095
      End
      Begin VB.Label Label12 
         Caption         =   "The Above Will Override The Item's RPGCode Programs"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   255
         Left            =   360
         TabIndex        =   16
         Tag             =   "1464"
         Top             =   1560
         Width           =   5055
      End
      Begin VB.Label Label11 
         Caption         =   "Multi-Task Program"
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
         TabIndex        =   15
         Tag             =   "1465"
         Top             =   960
         Width           =   3495
      End
      Begin VB.Label Label10 
         Caption         =   "Activation Program"
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
         TabIndex        =   14
         Tag             =   "1466"
         Top             =   360
         Width           =   3375
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
      TabIndex        =   7
      Top             =   600
      Width           =   2775
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
      Height          =   351
      Left            =   3000
      TabIndex        =   5
      Tag             =   "1021"
      Top             =   600
      Width           =   1095
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
      Height          =   975
      Left            =   120
      TabIndex        =   2
      Tag             =   "1467"
      Top             =   1560
      Width           =   5775
      Begin VB.OptionButton Option3 
         Caption         =   "Player Steps On This Item"
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
         TabIndex        =   4
         Tag             =   "1468"
         Top             =   360
         Value           =   -1  'True
         Width           =   4935
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Player Presses Activation Key Beside Item"
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
         TabIndex        =   3
         Tag             =   "1469"
         Top             =   600
         Width           =   5295
      End
   End
   Begin VB.CommandButton Command3 
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
      Left            =   3720
      TabIndex        =   1
      Tag             =   "1293"
      Top             =   960
      Width           =   2175
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
      TabIndex        =   8
      Tag             =   "1470"
      Top             =   360
      Width           =   2055
   End
   Begin VB.Label link1 
      Caption         =   "Also see Item Editor"
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
      Left            =   4440
      MouseIcon       =   "ITEMSET.frx":0CCA
      MousePointer    =   99  'Custom
      TabIndex        =   6
      Tag             =   "1471"
      Top             =   600
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label setat 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Set Item at X, Y, Layer layer"
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
      Tag             =   "1472"
      Top             =   0
      Width           =   5655
   End
End
Attribute VB_Name = "itemset"
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
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + itmpath$
    
    dlg.strTitle = "Item Filename"
    dlg.strDefaultExt = "itm"
    dlg.strFileTypes = "RPG Toolkit Item (*.itm)|*.itm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + itmpath$ + antiPath$
'        dirlink$(1) = antipath$
    prgfilename.text = antiPath$
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Program Filename"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    whichType$ = extention(filename$(1))
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
'        dirlink$(1) = antipath$
    iprg.text = antiPath$
End Sub

Private Sub Command3_Click()
'search for a free itm space.
    On Error GoTo errorhandler

' ! MODIFIED BY KSNiloc...
Dim thisProgram As Long
dimensionItemArrays
thisProgram = UBound(boardList(activeBoardIndex).theData.itmName)
'If boardList(activeBoardIndex).itmCondition <> -1 Then thisProgram = boardList(activeBoardIndex).itmCondition

On Error Resume Next

If thisProgram = -1 Then MsgBox LoadStringLoc(964, "This board already has 10 items.  This is the set limit."), , LoadStringLoc(964, "Too many items."): Exit Sub
If prgfilename.text = LoadStringLoc(1010, "None") Or prgfilename.text = "" Then
    Unload itemset
    Exit Sub
End If

boardList(activeBoardIndex).theData.itmName$(thisProgram) = prgfilename.text
boardList(activeBoardIndex).theData.itemProgram$(thisProgram) = iprg.text
boardList(activeBoardIndex).theData.itemMulti$(thisProgram) = multi.text
boardList(activeBoardIndex).theData.itmX(thisProgram) = boardList(activeBoardIndex).infoX              'program x
boardList(activeBoardIndex).theData.itmY(thisProgram) = boardList(activeBoardIndex).infoY              'program y
boardList(activeBoardIndex).theData.itmLayer(thisProgram) = boardList(activeBoardIndex).currentLayer   'program layer
If Option1.value = True Then
    boardList(activeBoardIndex).theData.itmActivate(thisProgram) = 0   'program activation: 0- always active, 1- conditional activation.
    Else
    boardList(activeBoardIndex).theData.itmActivate(thisProgram) = 1
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.itmVarActivate$(thisProgram) = prgactivation.text 'activation variable
    Else
    boardList(activeBoardIndex).theData.itmVarActivate$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.itmDoneVarActivate$(thisProgram) = afterprgvar.text 'activation variable at end of prg.
    Else
    boardList(activeBoardIndex).theData.itmDoneVarActivate$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.itmActivateInitNum$(thisProgram) = prgequals.text 'initial number of activation
    Else
    boardList(activeBoardIndex).theData.itmActivateInitNum$(thisProgram) = ""
End If
If Option2.value = True Then
    boardList(activeBoardIndex).theData.itmActivateDoneNum$(thisProgram) = afteractivate.text    'what to make variable at end of activation.
    Else
    boardList(activeBoardIndex).theData.itmActivateDoneNum$(thisProgram) = ""
End If
If Option3.value = True Then
    boardList(activeBoardIndex).theData.itmActivationType(thisProgram) = 0 'activation type- 0-step on, 1- conditional
    Else
    boardList(activeBoardIndex).theData.itmActivationType(thisProgram) = 1
End If
Unload itemset

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler

    If itemset.height = 1950 Then
        Command4.Caption = LoadStringLoc(911, "Advanced <<")
        itemset.height = 7005
    Else
        Command4.Caption = LoadStringLoc(912, "Advanced >>")
        itemset.height = 1950
    End If


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Program Filename"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
'        dirlink$(1) = antipath$
    multi.text = antiPath$
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    itemset.height = 1950
        
    setat.Caption = str$(boardList(activeBoardIndex).infoX) + "," + str$(boardList(activeBoardIndex).infoY) + " Layer" + str$(boardList(activeBoardIndex).currentLayer)
    thevar$ = "BoardName[" + str$(boardList(activeBoardIndex).infoX) + str$(boardList(activeBoardIndex).infoY) + str$(boardList(activeBoardIndex).currentLayer) + "]!"
    thevar$ = NoSpaces(thevar$)
    prgactivation.text = thevar$
    afterprgvar.text = thevar$
    If boardList(activeBoardIndex).itmCondition = -1 Then Exit Sub     'we are starting a new prg.
    'If we are here, that means we are looking at a previously set prg.
    thisProgram = boardList(activeBoardIndex).itmCondition
    prgfilename.text = boardList(activeBoardIndex).theData.itmName$(thisProgram)
    If boardList(activeBoardIndex).theData.itmX(thisProgram) <> 0 Then boardList(activeBoardIndex).infoX = boardList(activeBoardIndex).theData.itmX(thisProgram)
    If boardList(activeBoardIndex).theData.itmY(thisProgram) <> 0 Then boardList(activeBoardIndex).infoY = boardList(activeBoardIndex).theData.itmY(thisProgram)
    prglayer = boardList(activeBoardIndex).theData.itmLayer(thisProgram)
    If boardList(activeBoardIndex).theData.itmActivate(thisProgram) = 0 Then
        Option1.value = True
        Else
        Option2.value = True
        prgactivation.text = boardList(activeBoardIndex).theData.itmVarActivate$(thisProgram)
        afterprgvar.text = boardList(activeBoardIndex).theData.itmDoneVarActivate$(thisProgram)
        prgequals.text = boardList(activeBoardIndex).theData.itmActivateInitNum$(thisProgram)
        afteractivate.text = boardList(activeBoardIndex).theData.itmActivateDoneNum$(thisProgram)
    End If
    If boardList(activeBoardIndex).theData.itmActivationType(thisProgram) = 0 Then
        Option3.value = True
        Else
        Option4.value = True
    End If
    setat.Caption = str$(boardList(activeBoardIndex).infoX) + "," + str$(boardList(activeBoardIndex).infoY) + " Layer" + str$(prglayer)

    iprg.text = boardList(activeBoardIndex).theData.itemProgram$(thisProgram)
    multi.text = boardList(activeBoardIndex).theData.itemMulti$(thisProgram)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)

    'Confound you Vampz, your bloody neglect of error handling
    'has caused me great grief!
    
    On Error Resume Next

    tkMainForm.boardToolbar.Objects.Populate
End Sub

Private Sub link1_Click()
    On Error GoTo errorhandler
    activeItem.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option1_Click()
    On Error GoTo errorhandler
    Label2.Enabled = False
    prgactivation.Enabled = False
    prgequals.Enabled = False
    afterprgvar.Enabled = False
    Label4.Enabled = False
    afteractivate.Enabled = False


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option2_Click()
    On Error GoTo errorhandler
    Label2.Enabled = True
    prgactivation.Enabled = True
    prgequals.Enabled = True
    afterprgvar.Enabled = True
    Label4.Enabled = True
    afteractivate.Enabled = True


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

