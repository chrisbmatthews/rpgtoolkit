VERSION 5.00
Begin VB.Form frmCodeTip 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "CalledTip"
   ClientHeight    =   3375
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5535
   LinkTopic       =   "Form2"
   ScaleHeight     =   3375
   ScaleWidth      =   5535
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   847
      Object.Width           =   4815
      Caption         =   "Caption"
   End
   Begin Toolkit.TKButton cmdClose 
      Height          =   495
      Left            =   4200
      TabIndex        =   3
      Top             =   2760
      Width           =   1095
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Close"
   End
   Begin VB.CheckBox chkShowAgain 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Don't show this tip again"
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
      TabIndex        =   2
      Top             =   2880
      Width           =   2295
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   120
      Picture         =   "frmCodeTip.frx":0000
      ScaleHeight     =   2055
      ScaleWidth      =   615
      TabIndex        =   0
      Top             =   650
      Width           =   615
   End
   Begin VB.Shape shpBorder 
      Height          =   3375
      Left            =   0
      Top             =   0
      Width           =   5535
   End
   Begin VB.Label lblTip 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Tip"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   720
      TabIndex        =   1
      Tag             =   "1840"
      Top             =   645
      Width           =   4575
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmCodeTip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public noSave As Boolean

Private Sub cmdClose_Click()
 Unload Me
End Sub

Private Sub Form_Activate()
 Set TopBar.theForm = Me
End Sub

Public Sub showTip(ByVal Caption As String, ByVal txt As String, _
 Optional ByVal tipID As Long = -1)
 
 'Flag to not touch the registry...
 noSave = True
 'We're creating a new instance so close this one
 'to prevent any confusion...
 Unload Me
 
 'Does the user *want* to see this tip?
 If GetSetting("RPGToolkit3", "Tips", _
  loadedMainFile & CStr(tipID), 0) = 1 Then Exit Sub

 'Make a new instance of this form...
 Dim tip As New frmCodeTip
 With tip
  .TopBar.Caption = Caption
  .lblTip.Caption = txt
  .tag = tipID
 End With
 
 'If there's no tipID this tip can't be 'not shown again'...
 If tipID = -1 Then
  tip.chkShowAgain.Visible = False
  tip.noSave = True
 End If
 
 'Show the tip...
 tip.Show 1
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
 If chkShowAgain.value = 1 And Not noSave Then _
  SaveSetting "RPGToolkit3", "Tips", loadedMainFile & CStr(Me.tag), 1
End Sub
