VERSION 5.00
Begin VB.Form commandref 
   Caption         =   "RPGCode Version 2 Language Specification"
   ClientHeight    =   4695
   ClientLeft      =   3900
   ClientTop       =   960
   ClientWidth     =   6255
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
   Icon            =   "COMMANDR.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4695
   ScaleWidth      =   6255
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1208"
   Begin VB.CommandButton Command1 
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
      Left            =   5040
      TabIndex        =   2
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.TextBox description 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   3840
      Width           =   6015
   End
   Begin VB.ListBox commands 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3570
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4815
   End
End
Attribute VB_Name = "commandref"
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
    Unload commandref

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub commands_Click()
On Error Resume Next
whichone = commands.ListIndex + 1
num = FreeFile
cnt = 0
Open helppath$ + ObtainCaptionFromTag(DB_QuickRefFile, resourcePath$ + m_LangFile) For Input As #num
    Do While Not EOF(num)
        Line Input #num, a$
        If UCase$(a$) = ":DESCR" Then
            cnt = cnt + 1
            If cnt = whichone Then
                Line Input #num, Desc$
                
                '!NEW! Added this so it's easier to read the description of the
                'command choosed. Also see the changed reference file.
                cnt = cnt + 1
                Line Input #num, Desc2$
                
            End If
        End If
    Loop
Close #num

'!NEW! Changed this so it fit's with the changes made above.
description.Text = Desc$ & vbCrLf & Desc2$

End Sub

Private Sub commands_DblClick()
    On Error GoTo errorhandler

    ' KSNiloc... commented...
    
    'If commands.ListIndex <> 0 Then
    '    activeRPGCode.codeform.Text = activeRPGCode.codeform.Text + commands.Text
    '    Unload commandref
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
On Error GoTo errref
    Call LocalizeForm(Me)

    num = FreeFile
    Open helppath$ + ObtainCaptionFromTag(DB_QuickRefFile, resourcePath$ + m_LangFile) For Input As #num
        Do While Not EOF(num)
            Line Input #num, a$
            If UCase$(a$) = ":COMMAND" Then
                Line Input #num, com$
                commands.AddItem com$
            End If
        Loop
    Close #num
    commands.ListIndex = 0
    Exit Sub
errref:
MsgBox LoadStringLoc(961, "Reference File Not Found!"), , LoadStringLoc(962, "Command Reference")
Exit Sub
End Sub

