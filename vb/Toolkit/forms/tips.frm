VERSION 5.00
Begin VB.Form tips 
   Caption         =   "RPG Toolkit Tip Of The Day"
   ClientHeight    =   3165
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6555
   Icon            =   "tips.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3165
   ScaleWidth      =   6555
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1837"
   Begin VB.CommandButton Command2 
      Caption         =   "Close"
      Height          =   375
      Left            =   5040
      TabIndex        =   0
      Tag             =   "1088"
      Top             =   2640
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Next Tip"
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Tag             =   "1838"
      Top             =   2640
      Width           =   1215
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Don't show tips at startup"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Tag             =   "1839"
      Top             =   2640
      Width           =   2775
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   2295
      Left            =   240
      Picture         =   "tips.frx":030A
      ScaleHeight     =   2295
      ScaleWidth      =   615
      TabIndex        =   1
      Top             =   240
      Width           =   615
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Tip"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   840
      TabIndex        =   4
      Tag             =   "1840"
      Top             =   720
      Width           =   5415
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Did you know..."
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   15.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   840
      TabIndex        =   2
      Tag             =   "1841"
      Top             =   240
      Width           =   5415
   End
End
Attribute VB_Name = "tips"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Check1_Click()
    On Error GoTo errorhandler
    If Check1.value = 1 Then
        tipsOnOff = 0
    Else
        tipsOnOff = 1
    End If
    Call saveConfig("toolkit.cfg")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo errorhandler
    tipNum = tipNum + 1
    maxTip = getTipCount(helppath$ + ObtainCaptionFromTag(DB_TipFile, resourcePath$ + m_LangFile))
    If tipNum > maxTip Then tipNum = 1
    ctip$ = getTipNum(helppath$ + ObtainCaptionFromTag(DB_TipFile, resourcePath$ + m_LangFile), tipNum)
    Label2.caption = ctip$
    Call saveConfig("toolkit.cfg")

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    Unload tips

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    If tipsOnOff = 1 Then
        Check1.value = 0
    Else
        Check1.value = 1
    End If
    maxTip = getTipCount(helppath$ + ObtainCaptionFromTag(DB_TipFile, resourcePath$ + m_LangFile))
    If tipNum > maxTip Then tipNum = 1
    ctip$ = getTipNum(helppath$ + ObtainCaptionFromTag(DB_TipFile, resourcePath$ + m_LangFile), tipNum)
    Label2.caption = ctip$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo errorhandler
    tipNum = tipNum + 1
    Call saveConfig("toolkit.cfg")
    Unload tips

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


