VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form frmTutorial 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   ClientHeight    =   4935
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4215
   ControlBox      =   0   'False
   Icon            =   "frmTutorial.frx":0000
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   4935
   ScaleWidth      =   4215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin RichTextLib.RichTextBox txtContent 
      Height          =   3735
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   6588
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      Appearance      =   0
      TextRTF         =   $"frmTutorial.frx":000C
   End
   Begin Toolkit.TKButton cmdForward 
      Height          =   375
      Left            =   3000
      TabIndex        =   2
      Top             =   4440
      Width           =   1095
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "Next"
   End
   Begin Toolkit.TKButton cmdBack 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   4440
      Width           =   975
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "Back"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   847
      Object.Width           =   3375
      Caption         =   "RPGToolkit 3 Tutorial"
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   5
      Top             =   30
      Width           =   255
   End
   Begin VB.Label lblPage 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Page x of y"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1320
      TabIndex        =   3
      Top             =   4440
      Width           =   1455
   End
   Begin VB.Line Line3 
      X1              =   2880
      X2              =   2880
      Y1              =   4320
      Y2              =   4920
   End
   Begin VB.Line Line2 
      X1              =   1200
      X2              =   1200
      Y1              =   4320
      Y2              =   4920
   End
   Begin VB.Line Line1 
      X1              =   0
      X2              =   4200
      Y1              =   4320
      Y2              =   4320
   End
   Begin VB.Shape Shape1 
      Height          =   4935
      Left            =   0
      Top             =   0
      Width           =   4215
   End
End
Attribute VB_Name = "frmTutorial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (2004)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

'========================================================================
' Member structures
'========================================================================
Private Type tutorialPage
    title As String                 'Title of the page
    content As String               'Main content
End Type

'========================================================================
' Member variables
'========================================================================
Private m_pages() As tutorialPage   'All the pages of the tutorial

'========================================================================
' Load the tutorial
'========================================================================
Private Sub loadTutorial()
    On Error Resume Next
    Dim a As Long
    Do
        a = a + 1
        ReDim Preserve m_pages(Int(a / 2))
        With m_pages(Int(a / 2))
            .title = LoadResString(a)
            .content = LoadResString(a + 1)
            If (.title = "") Then
                ReDim Preserve m_pages(Int(a / 2) - 2)
                Exit Do
            End If
        End With
        a = a + 1
    Loop
End Sub

'========================================================================
' Fill in the form
'========================================================================
Private Sub fillInfo()
    If (UBound(m_pages) <= configfile.tutCurrentLesson - 1) Then
        configfile.tutCurrentLesson = UBound(m_pages)
    ElseIf (configfile.tutCurrentLesson = 0) Then
        configfile.tutCurrentLesson = 1
    End If
    With m_pages(configfile.tutCurrentLesson - 1)
        Me.Caption = .title
        TopBar.Caption = .title
        txtContent.Text = .content
    End With
    lblPage.Caption = CStr(configfile.tutCurrentLesson) & " of " & CStr(UBound(m_pages))
End Sub

'========================================================================
' Previous page
'========================================================================
Private Sub cmdBack_click()
    configfile.tutCurrentLesson = configfile.tutCurrentLesson - 1
    Call fillInfo
End Sub

'========================================================================
' Next page
'========================================================================
Private Sub cmdForward_click()
    configfile.tutCurrentLesson = configfile.tutCurrentLesson + 1
    Call fillInfo
End Sub

'========================================================================
' Form loaded
'========================================================================
Private Sub Form_Load()
    Set TopBar.theForm = Me
    Call loadTutorial
    Call fillInfo
    lblNick.MousePointer = 99
    lblNick.MouseIcon = Images.MouseLink()
End Sub

'========================================================================
' Retrieve type of form
'========================================================================
Public Property Get formType()
    formType = FT_TUTORIAL
End Property

Private Sub Form_Unload(Cancel As Integer)
    Call tkMainForm.refreshTabs
End Sub

'========================================================================
' Special thanks
'========================================================================
Private Sub lblNick_Click()
    Call MsgBox("A special thanks to Nick, who wrote this tutorial.")
End Sub
