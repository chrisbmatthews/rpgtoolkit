VERSION 5.00
Begin VB.Form commandRef 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "RPGCode Version 2 Language Specification"
   ClientHeight    =   5055
   ClientLeft      =   3840
   ClientTop       =   615
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
   ScaleHeight     =   5055
   ScaleWidth      =   6255
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1208"
   Begin Toolkit.TKButton command1 
      Height          =   375
      Left            =   5040
      TabIndex        =   3
      Top             =   480
      Width           =   855
      _extentx        =   1508
      _extenty        =   661
      Object.width           =   360
      caption         =   "OK"
   End
   Begin Toolkit.TKTopBar topBar 
      Height          =   480
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4335
      _extentx        =   7646
      _extenty        =   847
      Object.width           =   4335
      caption         =   "Command Reference"
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
      Top             =   4200
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
      Top             =   480
      Width           =   4815
   End
   Begin VB.Shape Shape1 
      Height          =   5055
      Left            =   0
      Top             =   0
      Width           =   6255
   End
End
Attribute VB_Name = "commandref"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

Option Explicit

Private Sub Command1_Click()
    On Error Resume Next
    Call Unload(commandref)
End Sub

Private Sub commands_Click()
    On Error Resume Next
    Dim whichOne As Long, num As Long, cnt As Long, dest As String, dest2 As String
    whichOne = commands.ListIndex + 1
    num = FreeFile()
    Open helpPath$ + ObtainCaptionFromTag(DB_QuickRefFile, resourcePath$ + m_LangFile) For Input As #num
        Do While Not EOF(num)
            If UCase$(fread(num)) = ":DESCR" Then
                cnt = cnt + 1
                If cnt = whichOne Then
                    dest = fread(num)
                    cnt = cnt + 1
                    dest2 = fread(num)
                End If
            End If
        Loop
    Close num
    description.Text = dest & vbCrLf & dest2
End Sub

Private Sub Form_Load()
    On Error GoTo errref
    Call LocalizeForm(Me)
    Dim num As Long
    num = FreeFile()
    Open helpPath$ + ObtainCaptionFromTag(DB_QuickRefFile, resourcePath$ + m_LangFile) For Input As #num
        Do Until EOF(num)
            If UCase$(fread(num)) = ":COMMAND" Then
                commands.AddItem fread(num)
            End If
        Loop
    Close #num
    commands.ListIndex = 0
    Exit Sub

errref:
    MsgBox LoadStringLoc(961, "Reference File Not Found!"), , LoadStringLoc(962, "Command Reference")

End Sub

