VERSION 5.00
Begin VB.Form itmfight 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Battle-Driven Properties"
   ClientHeight    =   3855
   ClientLeft      =   2160
   ClientTop       =   2565
   ClientWidth     =   8925
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
   Icon            =   "ITMFIGHT.frx":0000
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3855
   ScaleWidth      =   8925
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1532"
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
      Left            =   7680
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Battle Driven Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3495
      Left            =   120
      TabIndex        =   1
      Tag             =   "1538"
      Top             =   120
      Width           =   7455
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
         Height          =   1455
         Left            =   240
         TabIndex        =   9
         Tag             =   "1534"
         Top             =   360
         Width           =   6975
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
            Left            =   2520
            TabIndex        =   11
            Text            =   "0"
            Top             =   360
            Width           =   495
         End
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
            Left            =   2520
            TabIndex        =   10
            Text            =   "0"
            Top             =   720
            Width           =   495
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
            TabIndex        =   16
            Tag             =   "1537"
            Top             =   1080
            Width           =   5655
         End
         Begin VB.Label Label5 
            Caption         =   "Health of Target Increases By"
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
            TabIndex        =   15
            Tag             =   "1536"
            Top             =   360
            Width           =   2295
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
            Left            =   3120
            TabIndex        =   14
            Tag             =   "1504"
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label5 
            Caption         =   "SMP of Target Increases By"
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
            Index           =   3
            Left            =   120
            TabIndex        =   13
            Tag             =   "1535"
            Top             =   720
            Width           =   2295
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
            Left            =   3120
            TabIndex        =   12
            Tag             =   "1504"
            Top             =   720
            Width           =   615
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
         Height          =   1335
         Left            =   240
         TabIndex        =   2
         Tag             =   "1196"
         Top             =   1920
         Width           =   6975
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
            Left            =   5760
            TabIndex        =   6
            Tag             =   "1021"
            Top             =   720
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
            Left            =   5760
            TabIndex        =   5
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.TextBox animation 
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
            Left            =   3600
            TabIndex        =   4
            Text            =   "None"
            Top             =   720
            Width           =   2055
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
            Left            =   3600
            TabIndex        =   3
            Text            =   "None"
            Top             =   360
            Width           =   2055
         End
         Begin VB.Label Label7 
            Caption         =   "Animation To Use During Battle (if item is on right or left hand)"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   120
            TabIndex        =   8
            Tag             =   "1499"
            Top             =   720
            Width           =   3375
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
            TabIndex        =   7
            Tag             =   "1533"
            Top             =   360
            Width           =   3375
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
         Left            =   4560
         MouseIcon       =   "ITMFIGHT.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   18
         Tag             =   "1150"
         Top             =   3360
         Visible         =   0   'False
         Width           =   2655
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         Caption         =   "Also see Animation Editor"
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
         Left            =   4440
         MouseIcon       =   "ITMFIGHT.frx":0FD4
         MousePointer    =   99  'Custom
         TabIndex        =   17
         Tag             =   "1356"
         Top             =   3720
         Visible         =   0   'False
         Width           =   2775
      End
   End
End
Attribute VB_Name = "itmfight"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub animation_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.itmAnimation$ = animation.text
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + miscPath$
    
    dlg.strTitle = "Select Animation"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + miscPath$ + antiPath$
    animation.text = antiPath$
    itemList(activeItemIndex).theData.itmAnimation$ = antiPath$
End Sub


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
    whichType$ = extention(filename$(1))
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    equipped.text = antiPath$
    itemList(activeItemIndex).theData.fgtUse = antiPath$
End Sub

Private Sub Command5_Click()
    Unload itmfight
End Sub

Private Sub equipped_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.fgtUse$ = equipped.text
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    hpup.text = str$(itemList(activeItemIndex).theData.fgtHPup)
    smup.text = str$(itemList(activeItemIndex).theData.fgtSMup)
    If itemList(activeItemIndex).theData.fgtUse$ <> "" Then equipped.text = itemList(activeItemIndex).theData.fgtUse$
    If itemList(activeItemIndex).theData.itmAnimation$ <> "" Then animation.text = itemList(activeItemIndex).theData.itmAnimation$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub hpup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.fgtHPup = val(hpup.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label1_Click()

End Sub

Private Sub Label8_Click()
    On Error GoTo errorhandler
    animationedit.Show

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
    itemList(activeItemIndex).theData.fgtSMup = val(smup.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

