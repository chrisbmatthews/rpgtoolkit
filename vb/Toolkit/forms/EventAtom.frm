VERSION 5.00
Begin VB.Form EventAtom 
   Caption         =   "Edit Event Command"
   ClientHeight    =   5610
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9495
   Icon            =   "EventAtom.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5610
   ScaleWidth      =   9495
   StartUpPosition =   3  'Windows Default
   Tag             =   "1873"
   Begin VB.CommandButton Command3 
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   9120
      TabIndex        =   21
      Tag             =   "1874"
      Top             =   3120
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   9120
      TabIndex        =   20
      Tag             =   "1875"
      Top             =   2760
      Width           =   255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   345
      Left            =   7920
      TabIndex        =   19
      Tag             =   "1022"
      Top             =   4200
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   4575
      Left            =   120
      TabIndex        =   6
      Top             =   840
      Width           =   4335
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   3975
         Left            =   3120
         ScaleHeight     =   3975
         ScaleWidth      =   1095
         TabIndex        =   22
         Top             =   480
         Width           =   1095
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   0
            Left            =   0
            TabIndex        =   28
            Tag             =   "1876"
            Top             =   0
            Width           =   1095
         End
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   1
            Left            =   0
            TabIndex        =   27
            Tag             =   "1876"
            Top             =   720
            Width           =   1095
         End
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   2
            Left            =   0
            TabIndex        =   26
            Tag             =   "1876"
            Top             =   1440
            Width           =   1095
         End
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   3
            Left            =   0
            TabIndex        =   25
            Tag             =   "1876"
            Top             =   2160
            Width           =   1095
         End
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   4
            Left            =   0
            TabIndex        =   24
            Tag             =   "1876"
            Top             =   2880
            Width           =   1095
         End
         Begin VB.CommandButton browsebutton 
            Caption         =   "Browse"
            Height          =   345
            Index           =   5
            Left            =   0
            TabIndex        =   23
            Tag             =   "1876"
            Top             =   3600
            Width           =   1095
         End
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   5
         Left            =   120
         TabIndex        =   18
         Top             =   4080
         Width           =   2895
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   4
         Left            =   120
         TabIndex        =   17
         Top             =   3360
         Width           =   2895
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   16
         Top             =   2640
         Width           =   2895
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   2
         Left            =   120
         TabIndex        =   15
         Top             =   1920
         Width           =   2895
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   1200
         Width           =   2895
      End
      Begin VB.TextBox argVal 
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   480
         Width           =   2895
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   13
         Tag             =   "1877"
         Top             =   3840
         Width           =   4095
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   12
         Tag             =   "1877"
         Top             =   3120
         Width           =   4095
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   11
         Tag             =   "1877"
         Top             =   2400
         Width           =   4095
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   10
         Tag             =   "1877"
         Top             =   1680
         Width           =   4095
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   9
         Tag             =   "1877"
         Top             =   960
         Width           =   4095
      End
      Begin VB.Label argDesc 
         Caption         =   "Description"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   8
         Tag             =   "1877"
         Top             =   240
         Width           =   4095
      End
   End
   Begin VB.TextBox directedit 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   4680
      TabIndex        =   0
      Top             =   3000
      Width           =   4335
   End
   Begin VB.Label aftCode 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "#following code"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   735
      Left            =   4680
      TabIndex        =   5
      Tag             =   "1878"
      Top             =   3240
      Width           =   4335
   End
   Begin VB.Label preCode 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "#preceeding code"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   735
      Left            =   4680
      TabIndex        =   4
      Tag             =   "1879"
      Top             =   2280
      Width           =   4335
   End
   Begin VB.Label commandDesc 
      Caption         =   "Description"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Tag             =   "1877"
      Top             =   480
      Width           =   6975
   End
   Begin VB.Label commandName 
      Caption         =   "Command Name"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Tag             =   "1880"
      Top             =   120
      Width           =   2655
   End
   Begin VB.Label Label1 
      Caption         =   "RPGCode Equivalent:"
      Height          =   255
      Left            =   4680
      TabIndex        =   1
      Tag             =   "1881"
      Top             =   2040
      Width           =   2415
   End
End
Attribute VB_Name = "EventAtom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private newArgs$(6) 'new args we have obtained.
Private bIgnore As Boolean

Sub infofill()
    'fill in the event info
    'for event # evtToEdit
    On Error Resume Next
    bIgnore = True
    
    'fill in info section...
    Dim didDesc As Boolean
    aDesc$ = DescribeEvent(evtToEdit, didDesc)
    If didDesc Then
        Frame1.Visible = True
        commandName.Caption = evtName$
        commandDesc.Caption = evtDescription$
        
        For t = 0 To 5
            argDesc(t).Visible = False
            browsebutton(t).Visible = False
            argVal(t).Visible = False
        Next t
        
        'fill in text boxes...
        bk$ = GetBrackets(evtToEdit)
        For t = 0 To evtNoArgs - 1
            argDesc(t).Visible = True
            argVal(t).Visible = True
                      
            aa$ = GetElement(bk$, t + 1)
            If Mid$(aa$, 1, 1) = chr$(34) Then
                'remove quotes...
                aa$ = Mid$(aa$, 2, Len(aa$) - 2)
            End If
            argVal(t).Text = aa$
                        
            thedesc$ = evtArgDesc$(t)
            Select Case evtArgType$(t)
                Case "!":
                    thedesc$ = thedesc$ + "  [Numeric value (!)]"
                Case "!v":
                    thedesc$ = thedesc$ + "  [Numeric variable (!)]"
                Case "!o":
                    thedesc$ = thedesc$ + "  [Numeric value, optional (!)]"
                Case "$":
                    thedesc$ = thedesc$ + "  [Literal value ($)]"
                Case "$v":
                    thedesc$ = thedesc$ + "  [Literal variable ($)]"
                Case "$o":
                    thedesc$ = thedesc$ + "  [Literal variable, optional ($)]"
                Case Else:
                    browsebutton(t).Visible = True
            End Select
            argDesc(t).Caption = thedesc$
        Next
    Else
        Frame1.Visible = False
        For t = 0 To 5
            argDesc(t).Visible = False
            browsebutton(t).Visible = False
            argVal(t).Visible = False
        Next t
        commandName.Caption = "#" + GetCommandName(evtToEdit)
        commandDesc.Caption = "No description."
    End If
    
    'fill in code section...
    directedit.Text = evtToEdit
    
    If evtToEditNum <> -1 Then
        pc$ = ""
        If evtToEditNum - 3 >= 0 Then pc$ = evtList$(evtToEditNum - 3)
        If evtToEditNum - 2 >= 0 Then pc$ = pc$ + chr$(10) + chr$(13) + evtList$(evtToEditNum - 2)
        If evtToEditNum - 1 >= 0 Then pc$ = pc$ + chr$(10) + chr$(13) + evtList$(evtToEditNum - 1)
        preCode.Caption = pc$
        
        ac$ = ""
        If evtToEditNum + 1 <= UBound(evtList) Then ac$ = evtList$(evtToEditNum + 1)
        If evtToEditNum + 2 <= UBound(evtList) Then ac$ = ac$ + chr$(10) + chr$(13) + evtList$(evtToEditNum + 2)
        If evtToEditNum + 3 <= UBound(evtList) Then ac$ = ac$ + chr$(10) + chr$(13) + evtList$(evtToEditNum + 3)
        aftCode.Caption = ac$
    End If

    bIgnore = False
End Sub


Function VarType(Text$) As String
    'determine if value text$ represents a variable or a constant
    'returns var type:
    '$ string
    '! num
    'nothing - it's a constant
    On Error Resume Next
    a$ = Text$
    a$ = noSpaces(a$)
    l = Len(a$)
    p$ = Mid$(a$, l, 1)
    If p$ = "$" Or p$ = "!" Then
        VarType = p$
    Else
        VarType = ""
    End If
End Function

Sub UpdateRPGCodeEquiv()
    'update the rpgcode equivalent.
    On Error Resume Next
    
    If bIgnore Then Exit Sub
    
    eqiv$ = ""
    equiv$ = evtName$ + "("
    For t = 0 To evtNoArgs - 1
        tempval$ = argVal(t).Text
        Select Case evtArgType$(t)
            Case "!":
                v$ = VarType(tempval$)
                If (v$ = "!" Or v$ = "") And tempval$ <> "" Then
                    equiv$ = equiv$ + tempval$
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case "!v":
                v$ = VarType(tempval$)
                If v$ = "!" And tempval$ <> "" Then
                    equiv$ = equiv$ + tempval$
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case "!o":
                v$ = VarType(tempval$)
                If v$ = "!" Or v$ = "" Then
                    equiv$ = equiv$ + tempval$
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case "$":
                v$ = VarType(tempval$)
                If (v$ = "$" Or v$ = "") And tempval$ <> "" Then
                    If v$ = "$" Then
                        equiv$ = equiv$ + tempval$
                    Else
                        equiv$ = equiv$ + chr$(34) + tempval$ + chr$(34)
                    End If
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case "$v":
                v$ = VarType(tempval$)
                If v$ = "$" And tempval$ <> "" Then
                    equiv$ = equiv$ + tempval$
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case "$o":
                v$ = VarType(tempval$)
                If v$ = "$" Or v$ = "" Then
                    If v$ = "$" Then
                        equiv$ = equiv$ + tempval$
                    Else
                        equiv$ = equiv$ + chr$(34) + tempval$ + chr$(34)
                    End If
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    Exit Sub
                End If
            Case Else:
                v$ = VarType(tempval$)
                If (v$ = "$" Or v$ = "") And tempval$ <> "" Then
                    If v$ = "$" Then
                        equiv$ = equiv$ + tempval$
                    Else
                        equiv$ = equiv$ + chr$(34) + tempval$ + chr$(34)
                    End If
                Else
                    'MsgBox "Argument" + Str$(t) + " is incorrect.  Either it is the wrong type or it is not optional"
                    'Exit Sub
                End If
        End Select
        If t < evtNoArgs - 1 Then
            equiv$ = equiv$ + ", "
        End If
    Next t
    equiv$ = equiv$ + ")"
    bIgnore = True
    directedit.Text = equiv$
    bIgnore = False
End Sub

Private Sub argVal_Change(index As Integer)
    newArgs$(index) = argVal(index).Text
    Call UpdateRPGCodeEquiv
End Sub

Private Sub browsebutton_Click(index As Integer)
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + evtArgType$(index)
    
    dlg.strTitle = "Select File"
    dlg.strDefaultExt = ""
    dlg.strFileTypes = "All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filenamea$ = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    argVal(index).Text = antiPath$
    newArgs(index) = antiPath$
    bIgnore = False
    Call UpdateRPGCodeEquiv
End Sub


Private Sub Command1_Click()
    On Error Resume Next
    If evtToEditNum <> -1 Then
        evtList$(evtToEditNum) = directedit.Text
    End If
    evtToEdit = directedit.Text
    Call EventEdit.infofill
    Unload EventAtom
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    If evtToEditNum <> -1 Then
        evtList$(evtToEditNum) = directedit.Text
        If evtToEditNum - 1 >= 0 Then
            evtToEditNum = evtToEditNum - 1
            evtToEdit = evtList$(evtToEditNum)
            Call infofill
        End If
    End If
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    If evtToEditNum <> -1 Then
        evtList$(evtToEditNum) = directedit.Text
        If evtToEditNum + 1 <= UBound(evtList) Then
            evtToEditNum = evtToEditNum + 1
            evtToEdit = evtList$(evtToEditNum)
            Call infofill
        End If
    End If
End Sub


Private Sub directedit_Change()
    On Error Resume Next
    If bIgnore Then Exit Sub
    Text$ = directedit.Text
    evtToEdit = Text$
    Call infofill
    bIgnore = False
End Sub

Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    Call infofill
End Sub


