VERSION 5.00
Begin VB.Form itmmenu 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Menu-Driven Properties"
   ClientHeight    =   3615
   ClientLeft      =   2160
   ClientTop       =   2550
   ClientWidth     =   8565
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
   Icon            =   "ITMMENU.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3615
   ScaleWidth      =   8565
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1539"
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
      Left            =   7320
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Menu Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   120
      TabIndex        =   1
      Tag             =   "1542"
      Top             =   120
      Width           =   7095
      Begin VB.Frame Frame1 
         Caption         =   "Effects of Using Item"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1575
         Left            =   120
         TabIndex        =   6
         Tag             =   "1534"
         Top             =   360
         Width           =   6615
         Begin VB.TextBox smup 
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
            Left            =   2160
            TabIndex        =   8
            Text            =   "0"
            Top             =   840
            Width           =   495
         End
         Begin VB.TextBox hpup 
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
            Left            =   2160
            TabIndex        =   7
            Text            =   "0"
            Top             =   480
            Width           =   495
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   3
            Left            =   2760
            TabIndex        =   13
            Tag             =   "1504"
            Top             =   840
            Width           =   615
         End
         Begin VB.Label Label5 
            Caption         =   "SMP Increases By"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   12
            Tag             =   "1541"
            Top             =   840
            Width           =   1935
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   0
            Left            =   2760
            TabIndex        =   11
            Tag             =   "1504"
            Top             =   480
            Width           =   615
         End
         Begin VB.Label Label5 
            Caption         =   "Health Increases By"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   10
            Tag             =   "1540"
            Top             =   480
            Width           =   1935
         End
         Begin VB.Label Label3 
            Caption         =   "Negative values decrease health/SM Power!"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808080&
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Tag             =   "1537"
            Top             =   1200
            Width           =   5415
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "RPGCode"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   120
         TabIndex        =   2
         Tag             =   "1196"
         Top             =   2040
         Width           =   6615
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
            Left            =   5400
            TabIndex        =   4
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
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
            Left            =   3120
            TabIndex        =   3
            Text            =   "None"
            Top             =   360
            Width           =   2055
         End
         Begin VB.Label Label7 
            Caption         =   "Program To Run When Item Is Used:"
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
            Tag             =   "1533"
            Top             =   360
            Width           =   2895
         End
      End
      Begin VB.Label link1 
         Alignment       =   1  'Right Justify
         Caption         =   "Also see RPGCode Editor"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   1080
         MouseIcon       =   "ITMMENU.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   14
         Tag             =   "1150"
         Top             =   3120
         Visible         =   0   'False
         Width           =   5655
      End
   End
End
Attribute VB_Name = "itmmenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    equipped.text = antiPath$
    itemList(activeItemIndex).theData.mnuUse$ = antiPath$
End Sub

Private Sub Command5_Click()
    Unload itmmenu
End Sub


Private Sub equipped_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.mnuUse$ = equipped.text
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    hpup.text = str$(itemList(activeItemIndex).theData.mnuHPup)
    smup.text = str$(itemList(activeItemIndex).theData.mnuSMup)
    If itemList(activeItemIndex).theData.mnuUse$ <> "" Then equipped.text = itemList(activeItemIndex).theData.mnuUse$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

' !NEW!
Private Sub Form_Unload(Cancel As Integer)
    tkMainForm.boardToolbar.Objects.Populate
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub hpup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.mnuHPup = val(hpup.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub link1_Click()
    On Error GoTo errorhandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub smup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.mnuSMup = val(smup.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

