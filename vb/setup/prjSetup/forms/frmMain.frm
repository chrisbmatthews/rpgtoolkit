VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "RPGToolkit3 Installation Program"
   ClientHeight    =   15045
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   15270
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   15045
   ScaleWidth      =   15270
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   4
      Left            =   7560
      TabIndex        =   48
      Top             =   10200
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame10 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   51
         Top             =   1080
         Width           =   6975
         Begin VB.Label Label16 
            Caption         =   $"frmMain.frx":0CCA
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   975
            Left            =   120
            TabIndex        =   53
            Top             =   120
            Width           =   6735
         End
         Begin VB.Label Label15 
            Caption         =   "Press 'Next' to begin the installation."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   52
            Top             =   2520
            Width           =   6735
         End
      End
      Begin VB.Frame Frame9 
         Height          =   855
         Left            =   120
         TabIndex        =   49
         Top             =   120
         Width           =   6975
         Begin VB.Label Label12 
            Caption         =   "Summary"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   50
            Top             =   270
            Width           =   2535
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   1
      Left            =   120
      TabIndex        =   36
      Top             =   10200
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame8 
         BorderStyle     =   0  'None
         Height          =   3135
         Left            =   120
         TabIndex        =   39
         Top             =   1080
         Width           =   6975
         Begin VB.PictureBox Picture3 
            BorderStyle     =   0  'None
            Height          =   255
            Left            =   120
            ScaleHeight     =   255
            ScaleWidth      =   6855
            TabIndex        =   43
            Top             =   2780
            Width           =   6855
            Begin VB.OptionButton chkDoNotAgree 
               Caption         =   "I Do Not Agree"
               Height          =   255
               Left            =   1200
               TabIndex        =   45
               Top             =   0
               Value           =   -1  'True
               Width           =   1455
            End
            Begin VB.OptionButton chkAgree 
               Caption         =   "I Agree"
               Height          =   255
               Left            =   0
               TabIndex        =   44
               Top             =   0
               Width           =   855
            End
         End
         Begin VB.TextBox txtEula 
            Height          =   1935
            Left            =   120
            Locked          =   -1  'True
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   42
            Text            =   "frmMain.frx":0D75
            Top             =   720
            Width           =   6855
         End
         Begin VB.Label Label14 
            Caption         =   "You may only install this software if you agree to the terms of the EULA. Please read the licence and decide if you agree."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   120
            TabIndex        =   41
            Top             =   0
            Width           =   6735
         End
         Begin VB.Label Label13 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   40
            Top             =   1320
            Width           =   6735
         End
      End
      Begin VB.Frame Frame7 
         Height          =   855
         Left            =   120
         TabIndex        =   37
         Top             =   120
         Width           =   6975
         Begin VB.Label Label8 
            Caption         =   "End User Licence Agreement"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   38
            Top             =   270
            Width           =   3375
         End
      End
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   480
      ScaleHeight     =   375
      ScaleWidth      =   6495
      TabIndex        =   27
      Top             =   4850
      Width           =   6495
      Begin VB.CommandButton cmdBack 
         Caption         =   "< Back"
         Height          =   375
         Left            =   3120
         TabIndex        =   30
         Top             =   0
         Width           =   1455
      End
      Begin VB.CommandButton cmdExit 
         Caption         =   "Exit"
         Height          =   375
         Left            =   0
         TabIndex        =   29
         Top             =   0
         Width           =   1455
      End
      Begin VB.CommandButton cmdNext 
         Caption         =   "Next >"
         Default         =   -1  'True
         Height          =   375
         Left            =   5040
         TabIndex        =   28
         Top             =   0
         Width           =   1455
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   6
      Left            =   7560
      TabIndex        =   22
      Top             =   120
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame6 
         Height          =   855
         Left            =   120
         TabIndex        =   25
         Top             =   120
         Width           =   6975
         Begin VB.Label Label11 
            Caption         =   "Installation Finished"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   26
            Top             =   270
            Width           =   2775
         End
      End
      Begin VB.Frame Frame5 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   23
         Top             =   1080
         Width           =   6975
         Begin VB.Label Label9 
            Caption         =   "RPGToolkit3 has been successfully installed to your computer. Press 'Exit' to close this installation program."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   120
            TabIndex        =   24
            Top             =   120
            Width           =   6735
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   5
      Left            =   120
      TabIndex        =   17
      Top             =   5640
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame4 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   20
         Top             =   1080
         Width           =   6975
         Begin prjSetup.vbalProgressBar progress 
            Height          =   375
            Left            =   120
            TabIndex        =   34
            Top             =   720
            Width           =   6735
            _ExtentX        =   11880
            _ExtentY        =   661
            Picture         =   "frmMain.frx":13D4
            ForeColor       =   0
            BarPicture      =   "frmMain.frx":13F0
            ShowText        =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            XpStyle         =   -1  'True
         End
         Begin VB.Label lblCurrentFile 
            Height          =   255
            Left            =   120
            TabIndex        =   35
            Top             =   1200
            Width           =   6735
         End
         Begin VB.Label Label10 
            Caption         =   "Please wait while RPGToolkit3 is installed to your computer."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   21
            Top             =   120
            Width           =   6735
         End
      End
      Begin VB.Frame Frame3 
         Height          =   855
         Left            =   120
         TabIndex        =   18
         Top             =   120
         Width           =   6975
         Begin VB.Label Label7 
            Caption         =   "Installing - Please Wait"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   19
            Top             =   270
            Width           =   2775
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   3
      Left            =   7560
      TabIndex        =   10
      Top             =   5640
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame2 
         Height          =   855
         Left            =   120
         TabIndex        =   13
         Top             =   120
         Width           =   6975
         Begin VB.Label Label4 
            Caption         =   "Start Menu Group"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   14
            Top             =   270
            Width           =   2535
         End
      End
      Begin VB.Frame Frame1 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   11
         Top             =   1080
         Width           =   6975
         Begin VB.TextBox txtGroupName 
            Height          =   285
            Left            =   4080
            TabIndex        =   47
            Text            =   "RPG Toolkit 3"
            Top             =   1010
            Width           =   2895
         End
         Begin VB.CheckBox chkCreateStartMenuGroup 
            Caption         =   "Create a start menu group named"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   46
            Top             =   960
            Value           =   1  'Checked
            Width           =   3975
         End
         Begin VB.Label Label5 
            Caption         =   "Press 'Next' to continue."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   15
            Top             =   2520
            Width           =   6735
         End
         Begin VB.Label Label3 
            Caption         =   "If you would like it to, this installation program can place a group in the start menu to make RPGToolkit3 easier to open."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   975
            Left            =   120
            TabIndex        =   12
            Top             =   120
            Width           =   6735
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   2
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame fraStep1 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   7
         Top             =   1080
         Width           =   6975
         Begin VB.PictureBox Picture2 
            BorderStyle     =   0  'None
            Height          =   375
            Left            =   120
            ScaleHeight     =   375
            ScaleWidth      =   6735
            TabIndex        =   31
            Top             =   840
            Width           =   6735
            Begin VB.TextBox txtDirectory 
               Height          =   285
               Left            =   0
               TabIndex        =   33
               Text            =   "C:\Program Files\Toolkit3"
               Top             =   0
               Width           =   5895
            End
            Begin VB.CommandButton cmdBrowse 
               Caption         =   "..."
               Height          =   255
               Left            =   6120
               TabIndex        =   32
               Top             =   0
               Width           =   615
            End
         End
         Begin VB.Label Label6 
            Caption         =   "Press 'Next' to continue."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   16
            Top             =   2520
            Width           =   6735
         End
         Begin VB.Label lblExplain1 
            Caption         =   "Please choose the directory where you would like RPGToolkit3 to be installed. In most cases, the default will suffice."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   120
            TabIndex        =   9
            Top             =   120
            Width           =   6735
         End
      End
      Begin VB.Frame fraTopTop 
         Height          =   855
         Left            =   120
         TabIndex        =   6
         Top             =   120
         Width           =   6975
         Begin VB.Label Label2 
            Caption         =   "Installation Directory"
            BeginProperty Font 
               Name            =   "Comic Sans MS"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   8
            Top             =   270
            Width           =   2535
         End
      End
   End
   Begin VB.Frame fraNavigation 
      Height          =   855
      Left            =   120
      TabIndex        =   2
      Top             =   4560
      Width           =   7335
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7320
      Begin VB.PictureBox picSmallImage 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   4065
         Left            =   120
         Picture         =   "frmMain.frx":140C
         ScaleHeight     =   4035
         ScaleWidth      =   1875
         TabIndex        =   1
         Top             =   170
         Width           =   1905
      End
      Begin VB.Label lblInfo 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3135
         Left            =   2280
         TabIndex        =   4
         Top             =   960
         Width           =   4575
      End
      Begin VB.Label Label1 
         Caption         =   "RPGToolkit, Version 3.05"
         BeginProperty Font 
            Name            =   "Comic Sans MS"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   2280
         TabIndex        =   3
         Top             =   240
         Width           =   4695
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
' All contents copyright 2004, 2005, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' TK3 Installation Program
'=========================================================================

Option Explicit

'=========================================================================
' Constants
'=========================================================================
Private Const LAST_STEP = 7

'=========================================================================
' Members
'=========================================================================
Private m_lngStep As Long   ' Current step

'=========================================================================
' Create a start menu group?
'=========================================================================
Private Sub chkCreateStartMenuGroup_Click()
    txtGroupName.Enabled = chkCreateStartMenuGroup.Value
End Sub

'=========================================================================
' Move back a step
'=========================================================================
Private Sub cmdBack_Click()
    If (m_lngStep <> 0) Then
        Call changeStep(m_lngStep - 1)
    End If
End Sub

'=========================================================================
' Browse for a directory
'=========================================================================
Private Sub cmdBrowse_Click()

    ' Use the windows shell
    Dim shell As shell, folder As Folder3
    Set shell = New shell
    Set folder = shell.BrowseForFolder(hwnd, "Please choose the directory where you would like RPGToolkit3 to be installed:", 0)
    If Not (folder Is Nothing) Then

        ' Update the text box
        txtDirectory.Text = folder.Self().Path()

    End If

End Sub

'=========================================================================
' Exit the installation
'=========================================================================
Private Sub cmdExit_Click()
    If (m_lngStep <> LAST_STEP) Then
        If (MsgBox("RPGToolkit, Version 3 is not completely installed. Are you sure you want to cancel the installation process?", vbYesNo Or vbDefaultButton2) = vbYes) Then
            ' Exit the installation
            m_lngStep = LAST_STEP
            End
        End If
    Else
        ' Exit
        End
    End If
End Sub

'=========================================================================
' Move forward a step
'=========================================================================
Private Sub cmdNext_Click()
    If (m_lngStep <> LAST_STEP) Then
        Call changeStep(m_lngStep + 1)
    End If
End Sub

'=========================================================================
' Change to a different step
'=========================================================================
Private Sub changeStep(ByVal lngNewStep As Long)

    On Error Resume Next

    If (lngNewStep = 2) Then

        ' Must agree to license
        If (chkDoNotAgree.Value) Then

            Call MsgBox("You must agree to the terms of the EULA in order to install this software.")
            Exit Sub

        End If

    ElseIf (lngNewStep = 7) Then

        ' Exit

        ' Make the path
        Dim strPath As String
        strPath = txtDirectory.Text
        If (RightB$(strPath, 2) <> "\") Then strPath = strPath & "\"

        ' Show the readme file, if one exists
        If ((GetAttr(strPath & "readme.txt") And vbDirectory) = 0) Then
            Call shell("notepad.exe " & strPath & "readme.txt", vbNormalFocus)
        End If

        End

    End If

    ' Hide current step
    fraTop(m_lngStep).Visible = False

    ' Update step
    m_lngStep = lngNewStep

    ' Show new step
    Dim theFrame As Frame
    Set theFrame = fraTop(m_lngStep)
    theFrame.Left = 120
    theFrame.Top = 120
    theFrame.Visible = True

    ' Update buttons
    cmdBack.Visible = (m_lngStep <> 0)
    cmdNext.Visible = (m_lngStep <> LAST_STEP)
    cmdBack.Enabled = (m_lngStep <> 5)
    cmdNext.Enabled = (m_lngStep <> 5)

    If (cmdNext.Visible) Then
        ' Set focus to 'Next' button
        Call cmdNext.SetFocus
    End If

    If (m_lngStep = 5) Then

        ' Run the installer
        Call performSetup

        ' Move to next step
        Call changeStep(6)

    ElseIf (m_lngStep = 6) Then

        ' Hide buttons
        cmdNext.Caption = "Exit"
        cmdBack.Visible = False
        cmdExit.Visible = False

    End If

End Sub

'=========================================================================
' Load the form
'=========================================================================
Private Sub Form_Load()
    Width = 7650
    Height = 6000
    lblInfo.Caption = "Welcome to the RPGToolkit 3 installation program; this program will enable you to install RPGToolkit3 on your computer." & vbCrLf & vbCrLf & "Before proceeding, it is highly advised that you close all other applications to ensure a successful installation." & vbCrLf & vbCrLf & "If you do not wish to continue, press 'Exit'; otherwise, press 'Next' to continue."
    txtGroupName.Text = GetSetting("RPGToolkit3", "Settings", "Group", "RPG Toolkit 3")
    Label1.Caption = "RPGToolkit, Version " & RPGTOOLKIT_VERSION
    Call changeStep(0)
End Sub

'=========================================================================
' Form close event
'=========================================================================
Private Sub Form_Unload(ByRef cancel As Integer)
    Call cmdExit_Click
    cancel = True
End Sub
