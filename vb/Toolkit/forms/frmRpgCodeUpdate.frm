VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmRpgCodeUpdate 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "RPGCode Update Wizard"
   ClientHeight    =   5430
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   7245
   Icon            =   "frmRpgCodeUpdate.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5430
   ScaleWidth      =   7245
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   5
      Left            =   2160
      TabIndex        =   20
      Top             =   720
      Width           =   4935
      Begin VB.Label Label10 
         Caption         =   "We hope you enjoy using 3.1.0's improved RPGCode."
         Height          =   975
         Left            =   240
         TabIndex        =   22
         Top             =   1440
         Width           =   4455
      End
      Begin VB.Label Label9 
         Caption         =   $"frmRpgCodeUpdate.frx":0CCA
         Height          =   1095
         Left            =   240
         TabIndex        =   21
         Top             =   240
         Width           =   4455
      End
   End
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   4
      Left            =   2280
      TabIndex        =   17
      Top             =   720
      Width           =   4935
      Begin MSComctlLib.ProgressBar status 
         Height          =   375
         Left            =   120
         TabIndex        =   19
         Top             =   720
         Width           =   4335
         _ExtentX        =   7646
         _ExtentY        =   661
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.Label txtCurrentFile 
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   480
         Width           =   4575
      End
   End
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   3
      Left            =   2280
      TabIndex        =   15
      Top             =   720
      Width           =   4935
      Begin VB.Label Label5 
         Caption         =   $"frmRpgCodeUpdate.frx":0DC2
         Height          =   1215
         Left            =   120
         TabIndex        =   16
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   2
      Left            =   2160
      TabIndex        =   12
      Top             =   720
      Width           =   4935
      Begin MSComctlLib.TreeView files 
         Height          =   3375
         Left            =   240
         TabIndex        =   14
         Top             =   480
         Width           =   4455
         _ExtentX        =   7858
         _ExtentY        =   5953
         _Version        =   393217
         LabelEdit       =   1
         LineStyle       =   1
         Sorted          =   -1  'True
         Style           =   7
         Checkboxes      =   -1  'True
         Appearance      =   1
      End
      Begin VB.Label Label8 
         Caption         =   "Please deselect any files you would like the updater to skip."
         Height          =   375
         Left            =   120
         TabIndex        =   13
         Top             =   120
         Width           =   4575
      End
   End
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3975
      Index           =   1
      Left            =   2160
      TabIndex        =   9
      Top             =   720
      Width           =   4935
      Begin VB.Label Label7 
         Caption         =   $"frmRpgCodeUpdate.frx":0F34
         Height          =   3415
         Left            =   120
         TabIndex        =   11
         Top             =   1080
         Width           =   4575
      End
      Begin VB.Label Label6 
         Caption         =   $"frmRpgCodeUpdate.frx":1280
         Height          =   855
         Left            =   120
         TabIndex        =   10
         Top             =   120
         Width           =   4695
      End
   End
   Begin VB.Frame frmStep 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3975
      Index           =   0
      Left            =   2160
      TabIndex        =   4
      Top             =   720
      Width           =   4935
      Begin VB.Label Label4 
         Caption         =   "Updating is not an ""all or nothing"" process. This wizard will allow you to choose which files you do not want to update."
         Height          =   495
         Left            =   0
         TabIndex        =   8
         Top             =   3480
         Width           =   4935
      End
      Begin VB.Label Label1 
         Caption         =   $"frmRpgCodeUpdate.frx":1380
         Height          =   975
         Left            =   0
         TabIndex        =   7
         Top             =   0
         Width           =   4815
      End
      Begin VB.Label Label2 
         Caption         =   $"frmRpgCodeUpdate.frx":146A
         Height          =   1095
         Left            =   0
         TabIndex        =   6
         Top             =   960
         Width           =   4815
      End
      Begin VB.Label Label3 
         Caption         =   $"frmRpgCodeUpdate.frx":1573
         Height          =   1215
         Left            =   0
         TabIndex        =   5
         Top             =   2160
         Width           =   4815
      End
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   4575
      Left            =   240
      ScaleHeight     =   4545
      ScaleWidth      =   1665
      TabIndex        =   2
      Top             =   360
      Width           =   1695
   End
   Begin VB.CommandButton cmdBack 
      Cancel          =   -1  'True
      Caption         =   "Back"
      Height          =   375
      Left            =   3840
      TabIndex        =   1
      Top             =   4920
      Width           =   1575
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "Next"
      Default         =   -1  'True
      Height          =   375
      Left            =   5640
      TabIndex        =   0
      Top             =   4920
      Width           =   1455
   End
   Begin VB.Label lblTitle 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2400
      TabIndex        =   3
      Top             =   240
      Width           =   4455
   End
End
Attribute VB_Name = "frmRpgCodeUpdate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
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

'=========================================================================
' Directory search declarations
'=========================================================================
Private Const MAX_PATH = 260
Private Const INVALID_HANDLE_VALUE = -1
Private Const FILE_ATTRIBUTE_DIRECTORY = &H10

Private Type FILETIME
   dwLowDateTime As Long
   dwHighDateTime As Long
End Type

Private Type WIN32_FIND_DATA
   dwFileAttributes As Long
   ftCreationTime As FILETIME
   ftLastAccessTime As FILETIME
   ftLastWriteTime As FILETIME
   nFileSizeHigh As Long
   nFileSizeLow As Long
   dwReserved0 As Long
   dwReserved1 As Long
   cFileName As String * MAX_PATH
   cAlternate As String * 14
End Type

Private Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Long
Private Declare Function FindNextFile Lib "kernel32" Alias "FindNextFileA" (ByVal hFindFile As Long, lpFindFileData As WIN32_FIND_DATA) As Long
Private Declare Function FindClose Lib "kernel32" (ByVal hFindFile As Long) As Long

'=========================================================================
' Members
'=========================================================================
Private m_step As Long                  ' Current step
Private Const FINAL_STEP = 5            ' Final step
Private Const ROOT_NODE = "Programs"    ' Root node

'=========================================================================
' Go back a page.
'=========================================================================
Private Sub cmdBack_Click()
    m_step = m_step - 1
    frmStep(m_step + 1).visible = False
    frmStep(m_step).visible = True

    cmdBack.Enabled = (m_step <> 0)

    Call changeTitle
End Sub

'=========================================================================
' Go forward a page.
'=========================================================================
Private Sub cmdNext_Click()
    If (m_step = FINAL_STEP) Then
        ' Prevent the updater from running again on startup.
        Call SaveSetting("RPGToolkit3", "Installation", "Previous", "0")
        Call Unload(Me)
    End If

    m_step = m_step + 1
    frmStep(m_step - 1).visible = False
    frmStep(m_step).visible = True

    cmdNext.Enabled = (m_step <> FINAL_STEP)
    cmdBack.Enabled = (m_step <> 0)
    If (m_step = FINAL_STEP) Then
        cmdNext.Caption = "Close"
        cmdBack.visible = False
        cmdNext.Enabled = True
    End If

    Call changeTitle

    If (m_step = (FINAL_STEP - 1)) Then
        cmdBack.Enabled = False
        cmdNext.Enabled = False
        Call executeUpdate
    End If
End Sub

'=========================================================================
' Change the title to the current page's.
'=========================================================================
Private Sub changeTitle()
    ' The first index with Choose is 1.
    lblTitle.Caption = Choose(m_step + 1, _
        "Welcome to the RPGCode Updater", _
        "Caveats with the Updater", _
        "Choose Files for Update", _
        "Confirm Update", _
        "Updating...", _
        "Finished Update")
End Sub

'=========================================================================
' Trim nulls from a string (by Delano).
'=========================================================================
Private Function trimNulls(ByVal file As String) As String: On Error Resume Next
    trimNulls = IIf(InStr(file, vbNullChar), Left$(file, InStr(file, vbNullChar) - 1), file)
End Function

'=========================================================================
' Prepare the file tree control.
'=========================================================================
Private Sub prepareFileTree(ByVal path As String, ByRef node As String)
    Dim hSearch As Long, fd As WIN32_FIND_DATA
    hSearch = FindFirstFile(path & "*", fd)
    If (hSearch = INVALID_HANDLE_VALUE) Then Exit Sub
    Do
        Dim str As String
        str = trimNulls(fd.cFileName)
        If (fd.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY) Then
            If ((str <> ".") And (str <> "..")) Then
                Call files.nodes.Add(node, tvwChild, node & "\" & str, str)
                Call prepareFileTree(path & str & "\", node & "\" & str)
            End If
        Else
            Call files.nodes.Add(node, tvwChild, path & str, str)
        End If
    Loop While (FindNextFile(hSearch, fd))
    Call FindClose(hSearch)
End Sub

'=========================================================================
' Make all children of a node be checked or unchecked when the parent is.
'=========================================================================
Private Sub files_NodeCheck(ByVal node As MSComctlLib.node)
    Dim i As MSComctlLib.node
    If (node.Children = 0) Then Exit Sub
    Set i = node.Child
    Do
        i.Checked = node.Checked
        ' Apply recursively.
        Call files_NodeCheck(i)

        If (i = node.LastSibling) Then Exit Do
        Set i = i.Next
        If (i Is Nothing) Then Exit Do
    Loop
End Sub

'=========================================================================
' Perform the actual updating.
'=========================================================================
Private Sub executeUpdate(): On Error Resume Next
    ' Make the backup directory.
    Call MkDir(projectPath & prgPath & "Backup\")

    ' Calculate maximum value of progress bar.
    status.max = files.nodes.count() - 1 ' -1 for root node

    Dim i As node
    For Each i In files.nodes
        DoEvents
        If (i.Checked) Then
            Dim file As String
            file = Mid$(i.fullPath, 10)
            If (i.Children) Then
                ' If it's a directory, just create it in Backup.
                Call MkDir(projectPath & prgPath & "Backup\" & file & "\")
            Else
                If (LenB(file)) Then
                    Dim fileq As String
                    fileq = projectPath & prgPath & file

                    ' Update this file.
                    txtCurrentFile.Caption = "Updating " & file & "..."
                    Call FileCopy(fileq, projectPath & prgPath & "Backup\" & file)
                    Call updateProgram(fileq, fileq)
                End If
            End If
            status.value = status.value + 1
        End If
        DoEvents
    Next i

    Call cmdNext_Click
End Sub

'=========================================================================
' Set up the form.
'=========================================================================
Private Sub Form_Load()
    cmdBack.Enabled = False
    Dim i As frame
    For Each i In frmStep
        i.visible = False
    Next i
    frmStep(0).visible = True
    m_step = 0
    Call changeTitle
    Call files.nodes.Add(, , ROOT_NODE, ROOT_NODE)
    Call prepareFileTree(projectPath & prgPath, ROOT_NODE)

    Dim j As node
    For Each j In files.nodes
        Call j.EnsureVisible
        j.Checked = True
    Next j
    Set files.SelectedItem = files.nodes.Item(ROOT_NODE)
End Sub
