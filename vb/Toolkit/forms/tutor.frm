VERSION 5.00
Begin VB.Form tutor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RPG Toolkit Tutorial"
   ClientHeight    =   6435
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4845
   ForeColor       =   &H00000000&
   Icon            =   "tutor.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6435
   ScaleWidth      =   4845
   StartUpPosition =   3  'Windows Default
   Tag             =   "1855"
   Begin VB.CommandButton Command4 
      Caption         =   "Print"
      Height          =   315
      Left            =   1800
      TabIndex        =   4
      Tag             =   "1283"
      Top             =   6000
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "<< Previous Lesson"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Tag             =   "1856"
      Top             =   5520
      Width           =   1695
   End
   Begin VB.TextBox tutinfo 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   5295
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Text            =   "tutor.frx":030A
      Top             =   120
      Width           =   4575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Next Lesson >>"
      Height          =   375
      Left            =   3000
      TabIndex        =   0
      Tag             =   "1858"
      Top             =   5520
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "1 / 12"
      Height          =   255
      Left            =   2040
      TabIndex        =   3
      Tag             =   "1859"
      Top             =   5640
      Width           =   735
   End
End
Attribute VB_Name = "tutor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub displayFile(file$)
    On Error GoTo errorhandler

    tutinfo.text = ""

    num = FreeFile
    Open file$ For Input As #num
        Do While Not EOF(num)
            Line Input #num, a$
            tutinfo.text = tutinfo.text + a$ + Chr$(13) + Chr$(10)
        Loop
    Close #num

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    On Error GoTo errorhandler

    If tutCurrentLesson = 0 Then tutCurrentLesson = 1
    If tutCurrentLesson = 12 Then Exit Sub
    tutCurrentLesson = tutCurrentLesson + 1
    
    tutid = DB_Tutorial1 + tutCurrentLesson - 1
    'file$ = helppath$ + "tut" + toString(tutCurrentLesson) + ".txt"
    Call displayFile(helppath$ + ObtainCaptionFromTag(tutid, resourcePath$ + m_LangFile))
    Label1.caption = toString(tutCurrentLesson) + " / 12"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command2_Click()
    On Error GoTo errorhandler

    'invert the colors of the tutorial window.
    If tutinfo.BackColor = 0 Then
        tutinfo.BackColor = RGB(255, 255, 255)
        tutinfo.ForeColor = 0
    Else
        tutinfo.BackColor = 0
        tutinfo.ForeColor = RGB(255, 255, 255)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command3_Click()
    On Error GoTo errorhandler

    If tutCurrentLesson = 0 Then tutCurrentLesson = 1
    If tutCurrentLesson = 1 Then Exit Sub
    tutCurrentLesson = tutCurrentLesson - 1
    
    tutid = DB_Tutorial1 + tutCurrentLesson - 1
    'file$ = helppath$ + "tut" + toString(tutCurrentLesson) + ".txt"
    Call displayFile(helppath$ + ObtainCaptionFromTag(tutid, resourcePath$ + m_LangFile))
    
    'file$ = helppath$ + "tut" + toString(tutCurrentLesson) + ".txt"
    'Call displayFile(file$)
    
    Label1.caption = toString(tutCurrentLesson) + " / 12"
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    
    a = MsgBox(LoadStringLoc(992, "Would you like to print this lesson?"), vbYesNo)
    If a = 6 Then
        Printer.Print tutinfo.text
        Printer.EndDoc
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)

    If tutCurrentLesson = 0 Then tutCurrentLesson = 1
    
    tutid = DB_Tutorial1 + tutCurrentLesson - 1
    'file$ = helppath$ + "tut" + toString(tutCurrentLesson) + ".txt"
    Call displayFile(helppath$ + ObtainCaptionFromTag(tutid, resourcePath$ + m_LangFile))
    
    'file$ = helppath$ + "tut" + toString(tutCurrentLesson) + ".txt"
    'Call displayFile(file$)
    
    Label1.caption = toString(tutCurrentLesson) + " / 12"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub tutinfo_KeyPress(KeyAscii As Integer)
    KeyAscii = 0
End Sub


