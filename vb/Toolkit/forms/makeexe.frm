VERSION 5.00
Begin VB.Form makeexe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Make EXE"
   ClientHeight    =   2625
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6015
   Icon            =   "makeexe.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2625
   ScaleWidth      =   6015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1844"
   Begin VB.CommandButton Command3 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4560
      TabIndex        =   4
      Top             =   720
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Compile"
      Default         =   -1  'True
      Height          =   375
      Left            =   4560
      TabIndex        =   3
      Top             =   240
      Width           =   1335
   End
   Begin VB.Frame Frame2 
      Caption         =   "Icon"
      Height          =   1095
      Left            =   120
      TabIndex        =   2
      Top             =   1320
      Width           =   2055
      Begin VB.PictureBox Picture2 
         BackColor       =   &H80000009&
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   960
         ScaleHeight     =   375
         ScaleWidth      =   975
         TabIndex        =   7
         Top             =   600
         Width           =   975
         Begin VB.CommandButton cmdChange 
            Caption         =   "Change"
            Height          =   375
            Left            =   0
            TabIndex        =   8
            Top             =   0
            Width           =   975
         End
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
   Begin VB.Frame Frame1 
      Caption         =   "Select Target"
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Tag             =   "1845"
      Top             =   120
      Width           =   4335
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   3720
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   5
         Top             =   480
         Width           =   495
         Begin VB.CommandButton Command2 
            Caption         =   "..."
            Height          =   255
            Left            =   0
            TabIndex        =   6
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   3495
      End
   End
End
Attribute VB_Name = "makeexe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private iconPath As String

Private Declare Function ZIPCreateCompoundFile Lib "actkrt3.dll" (ByVal pstrOrigFile As String, ByVal pstrExtendedFile As String) As Long

'==========================================================================
'Compiles the currently loaded project (Colin)
'==========================================================================
Private Sub CreateEXE(ByVal file As String)
    ' Last modified: June 23, 2006

    On Error Resume Next

    Dim tmp As String
    tmp = TempDir() & "temp.tpk"

    Dim trans As String
    trans = App.path & "\trans3.exe"
    If Not (fileExists(trans)) Then trans = CurDir$() & "\trans3.exe"
    If Not (fileExists(trans)) Then
        Call MsgBox("The RPGToolkit engine cannot be found in the application or working directory." & vbCrLf & vbCrLf & "The engine (trans3.exe) is required to make exes.")
        Exit Sub
    End If

    Call SaveSetting("RPGToolkit3", "MakeEXE", "Prev" & loadedMainFile, file)
    Call CreatePakFile(tmp)
    Call FileCopy(trans, file)
    Call ZIPCreateCompoundFile(file, tmp)
    Call Kill(tmp)
    
    MsgBox "Successfully created executable!", vbInformation

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
        iconPreview.picture = Images.Corner
    End If

    iconPath = filename(1)
    iconPreview.picture = LoadPicture(iconPath)

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
    ' Call LocalizeForm(Me)
    Text1.Text = GetSetting("RPGToolkit3", "MakeEXE", "Prev" & loadedMainFile, "")
End Sub



