VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "RPGToolkit3 Installation Program"
   ClientHeight    =   5520
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7560
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5520
   ScaleWidth      =   7560
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   480
      ScaleHeight     =   375
      ScaleWidth      =   6495
      TabIndex        =   28
      Top             =   4850
      Width           =   6495
      Begin VB.CommandButton cmdBack 
         Caption         =   "< Back"
         Height          =   375
         Left            =   3120
         TabIndex        =   31
         Top             =   0
         Width           =   1455
      End
      Begin VB.CommandButton cmdExit 
         Caption         =   "Exit"
         Height          =   375
         Left            =   0
         TabIndex        =   30
         Top             =   0
         Width           =   1455
      End
      Begin VB.CommandButton cmdNext 
         Caption         =   "Next >"
         Default         =   -1  'True
         Height          =   375
         Left            =   5040
         TabIndex        =   29
         Top             =   0
         Width           =   1455
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   4
      Left            =   120
      TabIndex        =   23
      Top             =   120
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame6 
         Height          =   855
         Left            =   120
         TabIndex        =   26
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
            TabIndex        =   27
            Top             =   270
            Width           =   2775
         End
      End
      Begin VB.Frame Frame5 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   24
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
            TabIndex        =   25
            Top             =   120
            Width           =   6735
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   3
      Left            =   120
      TabIndex        =   18
      Top             =   120
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame4 
         BorderStyle     =   0  'None
         Height          =   3015
         Left            =   120
         TabIndex        =   21
         Top             =   1080
         Width           =   6975
         Begin prjSetup.vbalProgressBar progress 
            Height          =   375
            Left            =   120
            TabIndex        =   35
            Top             =   720
            Width           =   6735
            _ExtentX        =   11880
            _ExtentY        =   661
            Picture         =   "frmMain.frx":0CCA
            ForeColor       =   0
            BarPicture      =   "frmMain.frx":0CE6
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
            TabIndex        =   22
            Top             =   120
            Width           =   6735
         End
      End
      Begin VB.Frame Frame3 
         Height          =   855
         Left            =   120
         TabIndex        =   19
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
            TabIndex        =   20
            Top             =   270
            Width           =   2775
         End
      End
   End
   Begin VB.Frame fraTop 
      Height          =   4335
      Index           =   2
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Visible         =   0   'False
      Width           =   7320
      Begin VB.Frame Frame2 
         Height          =   855
         Left            =   120
         TabIndex        =   13
         Top             =   120
         Width           =   6975
         Begin VB.Label Label4 
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
            TabIndex        =   16
            Top             =   2520
            Width           =   6735
         End
         Begin VB.Label lblFolderName 
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
            Top             =   1320
            Width           =   6735
         End
         Begin VB.Label Label3 
            Caption         =   $"frmMain.frx":0D02
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
      Index           =   1
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
            TabIndex        =   32
            Top             =   840
            Width           =   6735
            Begin VB.TextBox txtDirecory 
               Height          =   285
               Left            =   0
               TabIndex        =   34
               Text            =   "C:\Program Files\Toolkit3"
               Top             =   0
               Width           =   5895
            End
            Begin VB.CommandButton cmdBrowse 
               Caption         =   "..."
               Height          =   255
               Left            =   6120
               TabIndex        =   33
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
            TabIndex        =   17
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
         Picture         =   "frmMain.frx":0DC3
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
' All contents copyright 2004, Colin James Fitzpatrick
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
Private Const LAST_STEP = 5

'=========================================================================
' Members
'=========================================================================
Private m_lngStep As Long   ' Current step

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
    Dim sh As Shell, f As Folder
    Set sh = New Shell
    Set f = sh.BrowseForFolder(hwnd, "Please choose the direcory where you would like RPGToolkit3 to be installed:", 0)
    If Not (f Is Nothing) Then

        ' Update the text box
        txtDirecory.Text = f.Self().Path()
        lblFolderName.Caption = txtDirecory.Text

    End If

End Sub

'=========================================================================
' Exit the installation
'=========================================================================
Private Sub cmdExit_Click()
    If (m_lngStep <> LAST_STEP) Then
        If (MsgBox("RPGToolkit3 is not completely installed - if you cancel now you will have to restart the installation process if you choose to install. Exit?", vbYesNo) = vbYes) Then
            ' Exit the installation
            m_lngStep = LAST_STEP
            Call Unload(Me)
        End If
    Else
        ' Exit
        Call Unload(Me)
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

    If (lngNewStep = 5) Then

        ' Exit
        Call Unload(Me)
        Exit Sub

    End If

    ' Hide current step
    fraTop(m_lngStep).Visible = False

    ' Update step
    m_lngStep = lngNewStep

    ' Show new step
    fraTop(m_lngStep).Visible = True

    ' Update buttons
    cmdBack.Visible = (m_lngStep <> 0)
    cmdNext.Visible = (m_lngStep <> LAST_STEP)
    cmdBack.Enabled = (m_lngStep <> 3)
    cmdNext.Enabled = (m_lngStep <> 3)

    If (cmdNext.Visible) Then
        ' Set focus to 'Next' button
        Call cmdNext.SetFocus
    End If

    If (m_lngStep = 3) Then

        ' Run the installer
        Call performSetup

        ' Move to next step
        Call changeStep(4)

    End If

    If (m_lngStep = 4) Then

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
    lblInfo.Caption = "Welcome to the RPGToolkit 3 installation program; this program will enable you to install RPGToolkit3 on your computer." & vbCrLf & vbCrLf & "Before proceeding, it is highly advised that you close all other applications to ensure a successful installation." & vbCrLf & vbCrLf & "If you do not wish to continue, press 'Exit', otherwise, press 'Next' to continue."
    Call changeStep(0)
    lblFolderName.Caption = txtDirecory.Text
End Sub

'=========================================================================
' Direcory was changed
'=========================================================================
Private Sub txtDirecory_Change()
    lblFolderName.Caption = txtDirecory.Text
End Sub
