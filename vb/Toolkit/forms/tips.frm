VERSION 5.00
Begin VB.Form tips 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tip Of The Day"
   ClientHeight    =   3165
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6555
   Icon            =   "tips.frx":0000
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3165
   ScaleWidth      =   6555
   Tag             =   "1837"
   Begin VB.Timer size 
      Interval        =   1
      Left            =   2280
      Top             =   1440
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
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
      Default         =   -1  'True
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
      Picture         =   "tips.frx":0CCA
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

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Added Option Explicit
' + Swapped +s for &s where appropriate
'
' ---What needs to be done
' + Apply new visual style
' + Make this form used
'
'=======================================================

Option Explicit

Public Property Get formType() As Long
    formType = FT_TIPS
End Property

Private Sub Check1_Click()
    On Error Resume Next
    If Check1.value = 1 Then
        configfile.tipsOnOff = 0
    Else
        configfile.tipsOnOff = 1
    End If
    Call configfile.saveConfig("toolkit.cfg")
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    configfile.tipNum = configfile.tipNum + 1
    Dim maxTip As Long
    maxTip = getTipCount(helpPath & ObtainCaptionFromTag(DB_tipFile, resourcePath & m_LangFile))
    If configfile.tipNum > maxTip Then configfile.tipNum = 1
    Dim cTip As String
    cTip = getTipNum(helpPath & ObtainCaptionFromTag(DB_tipFile, resourcePath & m_LangFile), configfile.tipNum)
    Label2.Caption = cTip
    Call configfile.saveConfig("toolkit.cfg")
End Sub

Private Sub Command2_Click()
    configfile.tipNum = configfile.tipNum + 1
    Call Unload(Me)
End Sub

Private Sub Form_Load()
    On Error Resume Next
    If (LenB(Command) <> 0) Then
        Call Unload(Me)
        Exit Sub
    End If
    If configfile.tipsOnOff = 1 Then
        Check1.value = 0
    Else
        Check1.value = 1
    End If
    Dim maxTip As Long
    maxTip = getTipCount(helpPath & ObtainCaptionFromTag(DB_tipFile, resourcePath & m_LangFile))
    If configfile.tipNum > maxTip Then configfile.tipNum = 1
    Dim cTip As String
    cTip = getTipNum(helpPath & ObtainCaptionFromTag(DB_tipFile, resourcePath & m_LangFile), configfile.tipNum)
    Label2.Caption = cTip
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    configfile.tipNum = configfile.tipNum + 1
    Call configfile.saveConfig("toolkit.cfg")
    Call Unload(Me)
    Call tkMainForm.refreshTabs
End Sub

Private Sub size_Timer()
    If Width <> 6645 Then Width = 6645
    If Height <> 3540 Then Height = 3540
End Sub
