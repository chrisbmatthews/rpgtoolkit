VERSION 5.00
Begin VB.Form testprefs 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Test Run Preferences"
   ClientHeight    =   3075
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7815
   Icon            =   "testprefs.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3075
   ScaleWidth      =   7815
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1739"
   Begin VB.CommandButton btnOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   6600
      TabIndex        =   18
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Preferences"
      Height          =   2775
      Left            =   120
      TabIndex        =   0
      Tag             =   "1746"
      Top             =   120
      Width           =   6375
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1815
         Left            =   5040
         ScaleHeight     =   1815
         ScaleWidth      =   1095
         TabIndex        =   13
         Top             =   360
         Width           =   1095
         Begin VB.CommandButton Command4 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   17
            Tag             =   "1021"
            Top             =   1440
            Width           =   1095
         End
         Begin VB.CommandButton Command3 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   16
            Tag             =   "1021"
            Top             =   1080
            Width           =   1095
         End
         Begin VB.CommandButton Command2 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   15
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
         End
         Begin VB.CommandButton Command14 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   0
            TabIndex        =   14
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   2280
         TabIndex        =   6
         Text            =   "Text1"
         Top             =   360
         Width           =   2655
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   2280
         TabIndex        =   5
         Text            =   "Text2"
         Top             =   1080
         Width           =   2655
      End
      Begin VB.TextBox Text3 
         Height          =   285
         Left            =   3480
         TabIndex        =   4
         Text            =   "Text3"
         Top             =   1440
         Width           =   1455
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   2280
         TabIndex        =   3
         Text            =   "Player 1"
         Top             =   1440
         Width           =   1095
      End
      Begin VB.TextBox Text4 
         Height          =   285
         Left            =   2280
         TabIndex        =   2
         Text            =   "Text4"
         Top             =   1800
         Width           =   2655
      End
      Begin VB.TextBox Text5 
         Height          =   285
         Left            =   2280
         TabIndex        =   1
         Text            =   "Text5"
         Top             =   720
         Width           =   2655
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Initial Font"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Tag             =   "1745"
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label3 
         BackStyle       =   0  'Transparent
         Caption         =   "Initial Message Window"
         Height          =   375
         Left            =   120
         TabIndex        =   11
         Tag             =   "1744"
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label Label4 
         BackStyle       =   0  'Transparent
         Caption         =   "Initial Characters"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Tag             =   "1743"
         Top             =   1440
         Width           =   2055
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         Caption         =   "Initial Board"
         Height          =   375
         Left            =   120
         TabIndex        =   9
         Tag             =   "1742"
         Top             =   1800
         Width           =   2055
      End
      Begin VB.Label Label6 
         BackStyle       =   0  'Transparent
         Caption         =   "These preferences will be used when test runing a program"
         ForeColor       =   &H00808080&
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Tag             =   "1741"
         Top             =   2280
         Width           =   5775
      End
      Begin VB.Label Label7 
         BackStyle       =   0  'Transparent
         Caption         =   "Initial Font Size"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Tag             =   "1740"
         Top             =   720
         Width           =   2055
      End
   End
End
Attribute VB_Name = "testprefs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub btnOK_Click()
 Command1_Click
End Sub

Private Sub CloseX_Click()
 Unload Me
End Sub

Private Sub Combo1_Click()
    On Error GoTo ErrorHandler
    Text3.Text = rpgcodeList(activeRPGCodeIndex).Ichar$(Combo1.ListIndex)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    Unload testprefs

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    
    dlg.strTitle = "Open Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filenamea$ = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filenamea$ = "" Then Exit Sub
    fName$ = filenamea$
    FileCopy filenamea$, projectPath$ + bmpPath$ + antiPath$
    rpgcodeList(activeRPGCodeIndex).Imwin$ = antiPath$
    Text2.Text = rpgcodeList(activeRPGCodeIndex).Imwin$
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + fontPath$
    
    dlg.strTitle = "Open Font"
    dlg.strDefaultExt = "fnt"
    dlg.strFileTypes = "RPG Toolkit Font (*.fnt)|*.fnt|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filenamea$ = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filenamea$ = "" Then Exit Sub
    fName$ = filenamea$
    FileCopy filenamea$, projectPath$ + fontPath$ + antiPath$
    rpgcodeList(activeRPGCodeIndex).Ifont$ = antiPath$
    Text1.Text = rpgcodeList(activeRPGCodeIndex).Ifont$
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
    If Combo1.ListIndex = -1 Then Combo1.ListIndex = 0
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + temPath$
    
    dlg.strTitle = "Open Character"
    dlg.strDefaultExt = "tem"
    dlg.strFileTypes = "RPG Toolkit Character (*.tem)|*.tem|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filenamea$ = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filenamea$ = "" Then Exit Sub
    fName$ = filenamea$
    FileCopy filenamea$, projectPath$ + temPath$ + antiPath$
    rpgcodeList(activeRPGCodeIndex).Ichar$(Combo1.ListIndex) = antiPath$
    Text3.Text = antiPath$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command4_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdPath$
    
    dlg.strTitle = "Open Board"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filenamea$ = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filenamea$ = "" Then Exit Sub
    fName$ = filenamea$
    FileCopy filenamea$, projectPath$ + brdPath$ + antiPath$
    rpgcodeList(activeRPGCodeIndex).Iboard$ = antiPath$
    Text4.Text = rpgcodeList(activeRPGCodeIndex).Iboard$
End Sub


Private Sub Command5_Click()
    On Error GoTo ErrorHandler
    rpgcodeList(activeRPGCodeIndex).Iboard$ = ""
    Text4.Text = ""

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Text1.Text = rpgcodeList(activeRPGCodeIndex).Ifont$
    Text2.Text = rpgcodeList(activeRPGCodeIndex).Imwin$
    Text3.Text = rpgcodeList(activeRPGCodeIndex).Ichar$(0)
    Text4.Text = rpgcodeList(activeRPGCodeIndex).Iboard$
    If rpgcodeList(activeRPGCodeIndex).IfontSize < 8 Then rpgcodeList(activeRPGCodeIndex).IfontSize = 8
    Text5.Text = str$(rpgcodeList(activeRPGCodeIndex).IfontSize)
    Combo1.AddItem ("Player 1")
    Combo1.AddItem ("Player 2")
    Combo1.AddItem ("Player 3")
    Combo1.AddItem ("Player 4")
    Combo1.AddItem ("Player 5")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub lblOK_Click()
 Command1_Click
End Sub

Private Sub Text1_Change()
    On Error Resume Next
    rpgcodeList(activeRPGCodeIndex).Ifont$ = Text1.Text
End Sub

Private Sub Text2_Change()
    On Error Resume Next
    rpgcodeList(activeRPGCodeIndex).Imwin$ = Text2.Text
End Sub

Private Sub Text3_Change()
    On Error GoTo ErrorHandler
    If Combo1.ListIndex = -1 Then Combo1.ListIndex = 0
    rpgcodeList(activeRPGCodeIndex).Ichar$(Combo1.ListIndex) = Text3.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text4_Change()
    On Error Resume Next
    rpgcodeList(activeRPGCodeIndex).Iboard$ = Text4.Text
End Sub

Private Sub Text5_Change()
    On Error GoTo ErrorHandler
    rpgcodeList(activeRPGCodeIndex).IfontSize = val(Text5.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


