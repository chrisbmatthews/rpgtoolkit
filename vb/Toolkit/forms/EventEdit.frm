VERSION 5.00
Begin VB.Form EventEdit 
   Caption         =   "Edit Event"
   ClientHeight    =   5490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   Icon            =   "EventEdit.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5490
   ScaleWidth      =   9300
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1867"
   Begin VB.Frame Frame1 
      Caption         =   "Generate Event"
      Height          =   5175
      Left            =   120
      TabIndex        =   1
      Tag             =   "1872"
      Top             =   120
      Width           =   7815
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   5280
         ScaleHeight     =   375
         ScaleWidth      =   2415
         TabIndex        =   5
         Top             =   4080
         Width           =   2415
         Begin VB.CommandButton Command3 
            Caption         =   "Delete Line"
            Height          =   345
            Left            =   1200
            TabIndex        =   7
            Tag             =   "1868"
            Top             =   0
            Width           =   1095
         End
         Begin VB.CommandButton Command2 
            Caption         =   "Insert Line"
            Height          =   345
            Left            =   0
            TabIndex        =   6
            Tag             =   "1869"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.ListBox List1 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3375
         Left            =   120
         TabIndex        =   2
         Top             =   600
         Width           =   7455
      End
      Begin VB.Label Label2 
         Caption         =   "Current Event Contents:"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Tag             =   "1871"
         Top             =   360
         Width           =   2895
      End
      Begin VB.Label Label3 
         Caption         =   "Double-click a line to edit the event."
         ForeColor       =   &H00808080&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Tag             =   "1870"
         Top             =   4680
         Width           =   4215
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   345
      Left            =   8040
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "EventEdit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Sub infofill()
    'will fill in info for the event
    On Error GoTo ErrorHandler
    
    'find length of event program array...
    evtTop = UBound(evtList$)
    
    'find last entry in the array...
    lastOne = evtTop
    For t = evtTop To 0 Step -1
        If evtList$(t) <> "" Then
            Exit For
        Else
            lastOne = t
        End If
    Next t

    'now fill in event listbox...
    List1.Clear
    For t = 0 To lastOne
        Dim a As Boolean
        evtDesc$ = DescribeEvent(evtList$(t), a)
        evtDesc$ = CStr(t) + ": " + evtDesc$
        List1.AddItem (evtDesc$)
    Next t

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    'now put this stuff back into the rpgcode editor...
    'will fill in info for the event
    On Error GoTo ErrorHandler
    
    'find length of event program array...
    evtTop = UBound(evtList$)
    
    'find last entry in the array...
    lastOne = evtTop
    For t = evtTop To 0 Step -1
        If evtList$(t) <> "" Then
            Exit For
        Else
            lastOne = t
        End If
    Next t

    'now fill in event listbox...
    toRet$ = ""
    For t = 0 To lastOne
        toRet$ = toRet$ + evtList(t) + chr$(13) + chr$(10)
    Next t
    activeRPGCode.codeForm.Text = toRet$
    
    Unload EventEdit

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command2_Click()
    'insert line into event.
    On Error GoTo ErrorHandler
    
    'find length of event program array...
    evtTop = UBound(evtList$)
    
    'find last entry in the array...
    lastOne = evtTop
    For t = evtTop To 0 Step -1
        If evtList$(t) <> "" Then
            Exit For
        Else
            lastOne = t
        End If
    Next t

    insertTo = List1.ListIndex
    If insertTo = -1 Then insertTo = 1
    For t = lastOne To insertTo Step -1
        evtList$(t + 1) = evtList$(t)
    Next t
    evtList$(insertTo) = ""
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    'insert line into event.
    On Error GoTo ErrorHandler
    
    'find length of event program array...
    evtTop = UBound(evtList$)
    
    'find last entry in the array...
    lastOne = evtTop
    For t = evtTop To 0 Step -1
        If evtList$(t) <> "" Then
            Exit For
        Else
            lastOne = t
        End If
    Next t

    delTo = List1.ListIndex
    If delTo = -1 Then delTo = 1
    For t = delTo To lastOne
        evtList$(t) = evtList$(t + 1)
    Next t
    evtList$(lastOne) = ""
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    Call infofill
End Sub


Private Sub List1_DblClick()
    On Error Resume Next
    
    num = List1.ListIndex
    If num > -1 Then
        If evtList(num) = "" Then
            'new line...
            evtToEditNum = num
            evtToEdit = evtList(num)
            EventCategories.Show
        Else
            evtToEditNum = num
            evtToEdit = evtList(num)
            EventAtom.Show
        End If
    End If
End Sub
