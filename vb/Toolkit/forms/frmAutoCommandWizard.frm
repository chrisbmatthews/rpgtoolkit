VERSION 5.00
Begin VB.Form frmAutoCommandWizard 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Auto Command Wizard"
   ClientHeight    =   3015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4575
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   4575
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   847
      Object.Width           =   3495
      Caption         =   "AutoCommand Wizard"
   End
   Begin VB.Frame fraInfo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Info"
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
      Height          =   615
      Left            =   2760
      TabIndex        =   4
      Top             =   1440
      Visible         =   0   'False
      Width           =   1575
      Begin VB.Label lblWait 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BeginProperty Font 
            Name            =   "Trebuchet MS"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   1335
      End
   End
   Begin Toolkit.TKButton cmdAutoCommand 
      Height          =   495
      Left            =   2640
      TabIndex        =   3
      Top             =   720
      Width           =   1815
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "AutoCommand"
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
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   2415
      Begin VB.Label lblDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "This wizard will clean up your code by removing #s and placing loose text in #MWins."
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
         Top             =   240
         Width           =   2175
      End
      Begin VB.Label lblMoreDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "None of your code will be damaged and will still function in exactly the same manner."
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
         Height          =   975
         Left            =   120
         TabIndex        =   1
         Top             =   1080
         Width           =   2175
      End
   End
   Begin VB.Shape Shape1 
      Height          =   3015
      Left            =   0
      Top             =   0
      Width           =   4575
   End
End
Attribute VB_Name = "frmAutoCommandWizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'============================================================================
'RPGCode Autocommand Wizard
'Designed, Programmed, and Copyright of Colin James Fitzpatrick, 2004
'============================================================================

Option Explicit

'============================================================================
'Declarations
'============================================================================

Private preventClose As Integer

'============================================================================
'Control events
'============================================================================

Private Sub Form_Activate()
 Set TopBar.theForm = Me
End Sub

Private Sub cmdAutoCommand_Click()
 If preventClose = 0 Then AutoCommand
End Sub

Private Sub Form_Unload(Cancel As Integer)
 Cancel = preventClose
End Sub

'============================================================================
'Main code
'============================================================================

Public Sub AutoCommand()

 'Error handling...
 On Error Resume Next

 'Declarations...
 Dim lines() As String
 Dim rtf As RichTextBox
 Dim done As Boolean
 Dim needsAC As Boolean
 Dim a As Long

 'Don't let the user mess with anything...
 preventClose = 1

 'Show the status box...
 fraInfo.Visible = True

 'Access the code...
 Set rtf = tkMainForm.activeForm.codeform
 With rtf
 
  .Locked = True
 
  'Split up the text...
  lblWait.Caption = "Splitting..."
  lines() = Split(.text, vbCrLf, , vbTextCompare)
  
  'See if it needs the #AutoCommand() command...
  needsAC = True
  a = 0
  Do Until done
   a = a + 1
   If InStr(1, LCase(lines(a)), "#autocommand()", vbTextCompare) > 0 Then
    needsAC = False
    done = True
    Exit Do
   End If
   If InStr(1, lines(a), "#", vbTextCompare) > 0 Then needsAC = True: Exit Do
   If a = UBound(lines) Then done = True
  Loop
  If needsAC Then .text = "#AutoCommand()" & vbCrLf & vbCrLf
  
  'AutoCommand!
  For a = 0 To UBound(lines)
   Select Case GetCommandName(AddNumberSignIfNeeded(lines(a)))
    Case "*"
    Case "@"
    Case "OPENBLOCK"
    Case "CLOSEBLOCK"
    Case "LABEL"
    Case "MBOX"
     lines(a) = Replace(lines(a), """", "'")
     lines(a) = "MWin(""" & lines(a) & """)"
    Case Else
     lines(a) = RemoveNumberSignIfThere(lines(a))
    End Select
    .text = .text & lines(a) & vbCrLf
    .selStart = Len(.text)
    lblWait.Caption = CStr(CInt(a / UBound(lines) * 100)) & "% Complete"
    DoEvents
  Next a
  
  .Locked = False
  
 End With

 'Unload this form...
 preventClose = 0
 Unload Me

 'Re-color the code...
 SplitLines

End Sub
