VERSION 5.00
Begin VB.Form mainfight 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Main Fight Options"
   ClientHeight    =   5850
   ClientLeft      =   1800
   ClientTop       =   2820
   ClientWidth     =   8865
   ControlBox      =   0   'False
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
   Icon            =   "MAINFIGH.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5850
   ScaleWidth      =   8865
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command5 
      Appearance      =   0  'Flat
      Caption         =   "OK"
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
      Left            =   7560
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Main Fight Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5535
      Left            =   120
      TabIndex        =   1
      Tag             =   "1554"
      Top             =   120
      Width           =   7215
      Begin VB.Frame Frame1 
         Caption         =   "Use Built In Fighting System?"
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
         TabIndex        =   12
         Tag             =   "1557"
         Top             =   4080
         Width           =   6855
         Begin VB.OptionButton Option4 
            Caption         =   "No, Run Program"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   240
            TabIndex        =   15
            Tag             =   "1558"
            Top             =   480
            Width           =   2535
         End
         Begin VB.OptionButton Option3 
            Caption         =   "Yes"
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
            TabIndex        =   16
            Tag             =   "1100"
            Top             =   240
            Value           =   -1  'True
            Width           =   1335
         End
         Begin VB.TextBox fprg 
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
            Left            =   480
            TabIndex        =   14
            Text            =   "None"
            Top             =   720
            Width           =   2055
         End
         Begin VB.CommandButton Command14 
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
            Left            =   2640
            TabIndex        =   13
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Fighting Type:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Left            =   120
         TabIndex        =   7
         Tag             =   "1563"
         Top             =   2640
         Width           =   6855
         Begin VB.OptionButton Option2 
            Caption         =   "Planned"
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
            TabIndex        =   8
            Tag             =   "1559"
            Top             =   480
            Width           =   1695
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Random"
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
            TabIndex        =   9
            Tag             =   "1560"
            Top             =   240
            Value           =   -1  'True
            Width           =   1695
         End
         Begin VB.TextBox Text1 
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
            Left            =   3480
            TabIndex        =   11
            Text            =   "50"
            Top             =   840
            Width           =   3255
         End
         Begin VB.Label chan 
            Caption         =   "Chances of getting in a fight: (1 in x)"
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
            Left            =   240
            TabIndex        =   10
            Tag             =   "1562"
            Top             =   840
            Width           =   2655
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Enemy Skill Level"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Left            =   120
         TabIndex        =   2
         Tag             =   "1561"
         Top             =   360
         Width           =   6855
         Begin VB.ListBox enemylist 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1620
            Left            =   120
            TabIndex        =   4
            Top             =   360
            Width           =   3255
         End
         Begin VB.TextBox skilllevel 
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
            Left            =   3480
            TabIndex        =   3
            Top             =   600
            Width           =   3255
         End
         Begin VB.Label link1 
            Alignment       =   1  'Right Justify
            Caption         =   "Also see Enemy Editor"
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
            Left            =   3480
            MouseIcon       =   "MAINFIGH.frx":0CCA
            MousePointer    =   99  'Custom
            TabIndex        =   6
            Tag             =   "1188"
            Top             =   1560
            Visible         =   0   'False
            Width           =   3135
         End
         Begin VB.Label Label2 
            Caption         =   "Enemy Skill Level"
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
            Left            =   3480
            TabIndex        =   5
            Tag             =   "1561"
            Top             =   360
            Width           =   3255
         End
      End
   End
End
Attribute VB_Name = "mainfight"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public Property Get formType() As Long
    formType = FT_FIGHTING
End Property

Private Sub Command14_Click()
    On Error Resume Next
    a = enemylist.ListIndex
    If a < 0 Then a = 0
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
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
    mainMem.fightPrg$ = antiPath$
    fprg.Text = antiPath$
End Sub

Private Sub Command5_Click()
    Unload mainfight
End Sub

Private Sub enemylist_Click()
    On Error GoTo ErrorHandler
    a = enemylist.ListIndex
    If a < 0 Then a = 0
    skilllevel.Text = str$(mainMem.skill(a))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub enemylist_DblClick()
    On Error Resume Next
    a = enemylist.ListIndex
    If a < 0 Then a = 0
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & enePath
    
    dlg.strTitle = "Select Enemy"
    dlg.strDefaultExt = "ene"
    dlg.strFileTypes = "RPG Toolkit Enemy (*.ene)|*.ene|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + enePath$ + antiPath$
    mainMem.enemy$(a) = antiPath$
    enemylist.Clear
    For t = 0 To 500
        aa$ = mainMem.enemy$(t)
        If aa$ = "" Then aa$ = LoadStringLoc(1010, "None")
        enemylist.AddItem "Enemy" + str$(t) + ": " + aa$
    Next t
    skilllevel.Text = str$(mainMem.skill(a))
    enemylist.ListIndex = a
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    Me.Caption = "Main File (Fighting)"
    
    mainNeedUpdate = True
    enemylist.Clear
    For t = 0 To 500
        a$ = mainMem.enemy$(t)
        If a$ = "" Then a$ = LoadStringLoc(1010, "None")
        enemylist.AddItem "Enemy" + str$(t) + ": " + a$
    Next t
    skilllevel.Text = str$(mainMem.skill(0))
    Option2.value = mainMem.fightType
    Text1.Text = str$(mainMem.chances)
    Option4.value = mainMem.fprgYN
    fprg.Text = mainMem.fightPrg$
        
    If mainMem.fprgYN = 0 Then
        Frame2.Visible = True
    Else
        Frame2.Visible = False
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call tkMainForm.refreshTabs
End Sub

Private Sub fprg_Change()
    On Error Resume Next
    mainMem.fightPrg$ = fprg.Text
End Sub

Private Sub link1_Click()
    On Error GoTo ErrorHandler
    activeEnemy.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option1_Click()
    On Error GoTo ErrorHandler
    chan.Caption = LoadStringLoc(2024, "Chances of getting in a fight: (1 in x)")
    mainMem.fightType = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option2_Click()
    On Error GoTo ErrorHandler
    chan.Caption = LoadStringLoc(2025, "Number of steps to take before getting in fight:")
    mainMem.fightType = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option3_Click()
    On Error GoTo ErrorHandler
    mainMem.fprgYN = 0
    Frame2.Visible = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option4_Click()
    On Error GoTo ErrorHandler
    mainMem.fprgYN = 1
    Frame2.Visible = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub skilllevel_Change()
    On Error GoTo ErrorHandler
    a = enemylist.ListIndex
    If a < 0 Then a = 0
    mainMem.skill(a) = val(skilllevel.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_Change()
    On Error GoTo ErrorHandler
    mainMem.chances = val(Text1.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

