VERSION 5.00
Begin VB.Form runtimeprograms 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Extended Run Time Keys"
   ClientHeight    =   2055
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6390
   Icon            =   "runtimeprograms.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2055
   ScaleWidth      =   6390
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1729"
   Begin VB.Frame Frame1 
      Caption         =   "Extended Run Time Keys"
      Height          =   1695
      Left            =   120
      TabIndex        =   1
      Tag             =   "1729"
      Top             =   120
      Width           =   4935
      Begin VB.ComboBox keynum 
         Height          =   315
         Left            =   120
         TabIndex        =   5
         Text            =   "Combo1"
         Top             =   720
         Width           =   1335
      End
      Begin VB.TextBox activationkey 
         Height          =   285
         Left            =   1680
         TabIndex        =   4
         Top             =   720
         Width           =   1095
      End
      Begin VB.TextBox runtimep 
         Height          =   285
         Left            =   3000
         TabIndex        =   3
         Top             =   720
         Width           =   1695
      End
      Begin VB.CommandButton Command14 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   3600
         TabIndex        =   2
         Tag             =   "1021"
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Activation Key"
         Height          =   375
         Left            =   1680
         TabIndex        =   7
         Tag             =   "1731"
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Key Number"
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Tag             =   "1732"
         Top             =   360
         Width           =   1575
      End
      Begin VB.Label Label3 
         Caption         =   "Run Time Program"
         Height          =   375
         Left            =   3000
         TabIndex        =   6
         Tag             =   "1730"
         Top             =   360
         Width           =   1695
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   345
      Left            =   5160
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "runtimeprograms"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub activationkey_KeyPress(KeyAscii As Integer)
    On Error GoTo errorhandler
    mainNeedUpdate = True
    ascii = KeyAscii
    li = keynum.ListIndex
    If li = -1 Then li = 0
    mainMem.runTimeKeys(li) = ascii
    a$ = UCase$(Chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    activationkey.text = a$
    KeyAscii = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    On Error GoTo errorhandler
    Unload runtimeprograms

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    lp = keynum.ListIndex
    If lp = -1 Then lp = 0
    mainMem.runTimePrg$(lp) = antiPath$
    runtimep.text = antiPath$
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    keynum.Clear
    For t = 0 To 50
        keynum.AddItem ("Key" + str$(t))
    Next t
    li = keynum.ListIndex
    If li = -1 Then li = 0
    a$ = UCase$(Chr$(mainMem.runTimeKeys(li)))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    activationkey.text = a$
    runtimep.text = mainMem.runTimePrg$(li)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub keynum_Click()
    On Error GoTo errorhandler
    li = keynum.ListIndex
    If li = -1 Then li = 0
    a$ = UCase$(Chr$(mainMem.runTimeKeys(li)))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    activationkey.text = a$
    runtimep.text = mainMem.runTimePrg$(li)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub runtimep_Change()
    On Error Resume Next
    lp = keynum.ListIndex
    If lp = -1 Then lp = 0
    mainMem.runTimePrg$(lp) = runtimep.text
End Sub

