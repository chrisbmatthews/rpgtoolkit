VERSION 5.00
Begin VB.Form itmboard 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board-Driven Properties"
   ClientHeight    =   1635
   ClientLeft      =   2250
   ClientTop       =   2955
   ClientWidth     =   8700
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
   Icon            =   "ITMBOARD.frx":0000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1635
   ScaleWidth      =   8700
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1714"
   Begin VB.CommandButton Command5 
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
      Left            =   7440
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Board Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   120
      TabIndex        =   1
      Tag             =   "1716"
      Top             =   120
      Width           =   7215
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   855
         Left            =   5880
         ScaleHeight     =   855
         ScaleWidth      =   1215
         TabIndex        =   6
         Top             =   360
         Width           =   1215
         Begin VB.CommandButton Command1 
            Caption         =   "Browse..."
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
            Left            =   0
            TabIndex        =   8
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.CommandButton Command14 
            Caption         =   "Browse..."
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
            Left            =   0
            TabIndex        =   7
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.TextBox equipped 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3720
         TabIndex        =   3
         Text            =   "None"
         Top             =   720
         Width           =   2055
      End
      Begin VB.TextBox onboard 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3720
         TabIndex        =   2
         Text            =   "None"
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label7 
         Caption         =   "Program To Run When Item Is Picked Up:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Tag             =   "1717"
         Top             =   720
         Width           =   3615
      End
      Begin VB.Label Label7 
         Caption         =   "Program To Run While Item Is On Board:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   120
         TabIndex        =   4
         Tag             =   "1715"
         Top             =   360
         Width           =   3615
      End
   End
End
Attribute VB_Name = "itmboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    equipped.Text = antiPath$
    itemList(activeItemIndex).theData.itmPrgPickUp$ = antiPath$
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    onboard.Text = antiPath$
    itemList(activeItemIndex).theData.itmPrgOnBoard$ = antiPath$
End Sub

Private Sub Command5_Click()
    Unload itmboard
End Sub

Private Sub equipped_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.itmPrgPickUp$ = equipped.Text
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    If itemList(activeItemIndex).theData.itmPrgOnBoard$ <> "" Then onboard.Text = itemList(activeItemIndex).theData.itmPrgOnBoard$   'Program to run while item is on board
    If itemList(activeItemIndex).theData.itmPrgPickUp$ <> "" Then equipped.Text = itemList(activeItemIndex).theData.itmPrgPickUp$    'Program to run when picked up.

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub onboard_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.itmPrgOnBoard$ = onboard.Text
End Sub

