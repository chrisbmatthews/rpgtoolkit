VERSION 5.00
Begin VB.Form EventCategories 
   Caption         =   "Select an event"
   ClientHeight    =   4395
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9165
   Icon            =   "EventCategories.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   4395
   ScaleWidth      =   9165
   StartUpPosition =   3  'Windows Default
   Tag             =   "1887"
   Begin VB.Frame Frame1 
      Caption         =   "Select an event"
      Height          =   4095
      Left            =   120
      TabIndex        =   2
      Tag             =   "1887"
      Top             =   120
      Width           =   7575
      Begin VB.ListBox categories 
         Height          =   3180
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   2175
      End
      Begin VB.ListBox events 
         Height          =   3180
         Left            =   2640
         TabIndex        =   3
         Top             =   600
         Width           =   4695
      End
      Begin VB.Label Label1 
         Caption         =   "Category"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Tag             =   "1890"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Events in Category"
         Height          =   255
         Left            =   2640
         TabIndex        =   5
         Tag             =   "1889"
         Top             =   360
         Width           =   2655
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   7920
      TabIndex        =   1
      Tag             =   "1008"
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Edit Event ->"
      Height          =   345
      Left            =   7920
      TabIndex        =   0
      Tag             =   "1888"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "EventCategories"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Sub infofill()
    On Error Resume Next
    Call ListCategories(helpPath$ + ObtainCaptionFromTag(DB_EventFile, resourcePath$ + m_LangFile), categories)
    Call DisplayEventCommands(helpPath$ + ObtainCaptionFromTag(DB_EventFile, resourcePath$ + m_LangFile), "", events)
End Sub


Private Sub categories_Click()
    On Error Resume Next
    cat$ = categories.list(categories.ListIndex)
    If cat$ = "All" Then cat$ = ""
    Call DisplayEventCommands(helpPath$ + ObtainCaptionFromTag(DB_EventFile, resourcePath$ + m_LangFile), cat$, events)
End Sub


Private Sub Command1_Click()
    On Error Resume Next
    idx = events.ListIndex
    If idx = -1 Then idx = 0
    cmd$ = events.list(idx)
    l = Len(cmd$)
    
    thecmd$ = "#"
    For t = 1 To l
        part$ = Mid$(cmd$, t, 1)
        If part$ = " " Or part$ = "-" Then
            Exit For
        Else
            thecmd$ = thecmd$ + part$
        End If
    Next t
    
    evtToEdit = thecmd$ + "()"
    EventAtom.Show
    Unload EventCategories
End Sub


Private Sub Command2_Click()
    Unload EventCategories
End Sub


Private Sub events_DblClick()
    Call Command1_Click
End Sub


Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    Call infofill
End Sub


