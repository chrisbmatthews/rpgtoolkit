VERSION 5.00
Begin VB.Form frmNewThings 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   ClientHeight    =   4095
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5055
   LinkTopic       =   "Form2"
   ScaleHeight     =   4095
   ScaleWidth      =   5055
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdForward 
      Caption         =   ">"
      Height          =   255
      Left            =   4440
      TabIndex        =   7
      Top             =   3060
      Width           =   255
   End
   Begin VB.CommandButton cmdBack 
      Caption         =   "<"
      Height          =   255
      Left            =   4080
      TabIndex        =   6
      Top             =   3060
      Width           =   255
   End
   Begin VB.CheckBox chkShowAgain 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Don't show show this screen again"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   3600
      Width           =   2895
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00CC9966&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2520
      ScaleHeight     =   225
      ScaleWidth      =   2490
      TabIndex        =   1
      Top             =   225
      Width           =   2525
      Begin VB.Label lblVersion 
         BackStyle       =   0  'Transparent
         Height          =   255
         Left            =   0
         TabIndex        =   2
         Top             =   0
         Width           =   2535
      End
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   847
      Object.Width           =   2415
      Caption         =   "What's New?"
   End
   Begin Toolkit.TKButton cmdClose 
      Height          =   495
      Left            =   3720
      TabIndex        =   8
      Top             =   3480
      Width           =   1095
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Close"
   End
   Begin VB.Label lblPage 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Page X of Y"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2880
      TabIndex        =   5
      Top             =   3060
      Width           =   1095
   End
   Begin VB.Shape Shape1 
      Height          =   375
      Left            =   2760
      Top             =   3000
      Width           =   2055
   End
   Begin VB.Shape shpMockFrame 
      Height          =   2415
      Left            =   120
      Top             =   600
      Width           =   4695
   End
   Begin VB.Label lblText 
      BackStyle       =   0  'Transparent
      Caption         =   "TEXT TEXT TEXT"
      Height          =   2175
      Index           =   0
      Left            =   240
      TabIndex        =   4
      Top             =   720
      Width           =   4455
   End
   Begin VB.Shape shpBorder 
      Height          =   4095
      Left            =   0
      Top             =   0
      Width           =   5055
   End
End
Attribute VB_Name = "frmNewThings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Activate()
 lblVersion.Caption = "Version " & CStr(App.Major) & _
  "." & CStr(App.Major) & CStr(App.Revision)
End Sub
