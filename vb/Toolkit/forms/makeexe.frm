VERSION 5.00
Begin VB.Form makeexe 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "EXE Builder"
   ClientHeight    =   3015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6015
   Icon            =   "makeexe.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   6015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1844"
   Begin Toolkit.TKTopBar topBar 
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   847
      Object.Width           =   4815
      Caption         =   "Make EXE"
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      Caption         =   "Icon"
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Width           =   2055
      Begin VB.CommandButton cmdChange 
         Caption         =   "Change"
         Height          =   375
         Left            =   960
         TabIndex        =   5
         Top             =   600
         Width           =   975
      End
      Begin VB.Image iconPreview 
         Appearance      =   0  'Flat
         Height          =   720
         Left            =   120
         Picture         =   "makeexe.frx":0CCA
         Stretch         =   -1  'True
         Top             =   240
         Width           =   720
      End
   End
   Begin Toolkit.TKButton Command1 
      Height          =   495
      Left            =   4560
      TabIndex        =   3
      Top             =   600
      Width           =   1335
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Compile"
   End
   Begin Toolkit.TKButton Command3 
      Height          =   495
      Left            =   4560
      TabIndex        =   2
      Top             =   1200
      Width           =   1215
      _ExtentX        =   820
      _ExtentY        =   661
      Object.Width           =   450
      Caption         =   "Cancel"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Select Target"
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Tag             =   "1845"
      Top             =   600
      Width           =   4335
      Begin VB.PictureBox command2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   3650
         Picture         =   "makeexe.frx":1994
         ScaleHeight     =   375
         ScaleWidth      =   615
         TabIndex        =   7
         Top             =   400
         Width           =   615
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   3495
      End
   End
   Begin VB.Shape shpBorder 
      Height          =   3015
      Left            =   0
      Top             =   0
      Width           =   6015
   End
End
Attribute VB_Name = "makeexe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private iconPath As String

'==========================================================================
'Compiles the currently loaded project [KSNiloc]
'==========================================================================
Private Sub CreateEXE(ByVal file As String)

    On Error Resume Next

    Call SaveSetting("RPGToolkit3", "MakeEXE", "Prev" & loadedMainFile, file)

    Call CreatePakFile(TempDir & "temp2.tpk")

    Dim RC4 As New clsRC4
    RC4.Key = "TK3 EXE HOST"
    RC4.EncryptFile TempDir & "temp2.tpk", TempDir & "temp.tpk", True

    Call FileCopy(App.path & "\exeHost.dll", TempDir & "tkTempExe2")

    Dim files(1 To 5) As String

    files(1) = App.path & "\freeImage.dll"
    files(2) = App.path & "\actkrt3.dll"
    files(3) = App.path & "\trans3.exe"
    files(4) = TempDir & "temp.tpk"
    files(5) = App.path & "\audiere.dll"

    Call addToSelfExtract(TempDir & "tkTempExe2", _
                          files(5), _
                          TempDir & "tkTempExe5")

    Call addToSelfExtract(TempDir & "tkTempExe5", _
                          files(4), _
                          TempDir & "tkTempExe4")

    Call addToSelfExtract(TempDir & "tkTempExe4", _
                           files(3), _
                           TempDir & "tkTempExe3")

    Call addToSelfExtract(TempDir & "tkTempExe3", _
                          files(2), _
                          TempDir & "tkTempExe6")

    Call addToSelfExtract(TempDir & "tkTempExe6", _
                          files(1), _
                          file)

    Call Kill(TempDir & "temp.tpk")
    Call Kill(TempDir & "temp2.tpk")
    Call Kill(TempDir & "tkTempExe")
    Call Kill(TempDir & "tkTempExe2")
    Call Kill(TempDir & "tkTempExe3")
    Call Kill(TempDir & "tkTempExe4")
    Call Kill(TempDir & "tkTempExe5")
    Call Kill(TempDir & "tkTempExe6")

End Sub

Private Sub cmdChange_Click()

    On Error Resume Next

    Dim cmp As Boolean
    Dim antiPath As String

    ChDir (currentDir)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gamPath
    dlg.strTitle = "Change EXE Icon"
    dlg.strFileTypes = "Icons (*.ico / *.exe)|*.ico;*.exe"
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    
    Dim ext As String
    ext = Right(GetExt(filename(1)), 3)

    If ext <> "ico" And ext <> "exe" Then
        MsgBox "Icons must be .ico or .exe files!", vbInformation
        Exit Sub
    End If

    If ext = "exe" Then
        'Extract the icon from the EXE and save it...
        ExtractIcons filename(1), TempDir & "TKIconTemp.ico"
        filename(1) = TempDir & "TKIconTemp.ico"
        iconPreview.Picture = Images.Corner
    End If

    iconPath = filename(1)
    iconPreview.Picture = LoadPicture(iconPath)

End Sub

Private Sub Command1_Click()

    On Error Resume Next
    
    Dim aa As Long
    Dim bb As Long

    filename(1) = Text1.Text
    If filename(1) = "" Then Exit Sub


    Me.Hide

    CreateEXE filename(1)
    
    If iconPath <> "" Then
        InsertIcons iconPath, filename(1)
    End If
    
    Unload Me

End Sub

Private Sub Command2_Click()

    On Error Resume Next
    
    Dim cmp As Boolean
    Dim antiPath As String
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gamPath$
    
    dlg.strTitle = "Make EXE"
    dlg.strDefaultExt = "exe"
    dlg.strFileTypes = "Game EXE (*.exe)|*.exe|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    
    Text1.Text = filename$(1)
End Sub

Private Sub Command3_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    SetParent Me.hwnd, tkMainForm.hwnd
    Command2.MousePointer = 99
    Command2.MouseIcon = Images.MouseLink
    Set TopBar.theForm = Me
    Call LocalizeForm(Me)
    Text1.Text = GetSetting("RPGToolkit3", "MakeEXE", "Prev" & loadedMainFile, "")
End Sub


