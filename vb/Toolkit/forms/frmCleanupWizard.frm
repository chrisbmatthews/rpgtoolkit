VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmCleanupWizard 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Cleanup Wizard"
   ClientHeight    =   3555
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4845
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3555
   ScaleWidth      =   4845
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.ProgressBar FileProgress 
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   3120
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
   End
   Begin MSComctlLib.ProgressBar TotalProgress 
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   2760
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Frame frmDescription 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Description"
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
      Height          =   1935
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   2415
      Begin VB.Label lblDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "This wizard will run all of the cleanup wizards on every RPGCode file in your game."
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
         Height          =   735
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   2175
      End
      Begin VB.Label lblMoreDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "No damage will be done to your code and it will still function as it did before."
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
         Height          =   735
         Left            =   120
         TabIndex        =   2
         Top             =   1080
         Width           =   2175
      End
   End
   Begin Toolkit.TKTopBar_Tools topBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3135
      _ExtentX        =   5530
      _ExtentY        =   370
      Object.Width           =   3135
      Caption         =   "RPGCode Cleanup"
   End
   Begin VB.Shape Shape1 
      Height          =   3495
      Left            =   0
      Top             =   0
      Width           =   4815
   End
End
Attribute VB_Name = "frmCleanupWizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
