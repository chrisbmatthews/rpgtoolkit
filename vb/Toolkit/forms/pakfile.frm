VERSION 5.00
Begin VB.Form pakfile 
   Caption         =   "Pak File Compiler"
   ClientHeight    =   1425
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6285
   Icon            =   "pakfile.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   1425
   ScaleWidth      =   6285
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1846"
   Begin VB.CommandButton Command3 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   4320
      TabIndex        =   3
      Tag             =   "1008"
      Top             =   720
      Width           =   1815
   End
   Begin VB.Frame Frame1 
      Caption         =   "Pak File Manager"
      Height          =   1095
      Left            =   120
      TabIndex        =   1
      Tag             =   "1849"
      Top             =   120
      Width           =   4095
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   2880
         ScaleHeight     =   375
         ScaleWidth      =   1095
         TabIndex        =   5
         Top             =   480
         Width           =   1095
         Begin VB.CommandButton Command2 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   6
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   2655
      End
      Begin VB.Label link1 
         Caption         =   "Also see Make EXE"
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
         Left            =   2400
         MouseIcon       =   "pakfile.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   4
         Tag             =   "1848"
         Top             =   960
         Visible         =   0   'False
         Width           =   1575
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Create PakFile"
      Height          =   345
      Left            =   4320
      TabIndex        =   0
      Tag             =   "1847"
      Top             =   240
      Width           =   1815
   End
End
Attribute VB_Name = "pakfile"
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
    Dim cmp As Boolean
    
    filename$(1) = Text1.Text
    
    If filename$(1) = "" Then Exit Sub
    
    If fileExists(filename(1)) Then
        MsgBox "Cannot overwrite an existing file!"
        Exit Sub
    End If
    
    Call CreatePakFile(filename$(1))
End Sub


Private Sub Command2_Click()
    On Error Resume Next
    Dim cmp As Boolean
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gamPath$
    
    dlg.strTitle = "Save PakFile As"
    dlg.strDefaultExt = "tpk"
    dlg.strFileTypes = "PakFile (*.tpk)|*.tpk|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    
    Text1.Text = filename$(1)
End Sub


Private Sub Command3_Click()
    Unload pakfile
End Sub

Private Sub Form_Load()
    ' Call LocalizeForm(Me)
End Sub


Private Sub link1_Click()
    On Error GoTo ErrorHandler

    a = PAKTestSystem()
    If a = False Then Exit Sub

    makeexe.Show
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


