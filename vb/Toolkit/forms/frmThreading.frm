VERSION 5.00
Begin VB.Form frmThreading 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Threading"
   ClientHeight    =   3795
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   4215
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   4215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Default         =   -1  'True
      Height          =   375
      Left            =   2760
      TabIndex        =   3
      Top             =   360
      Width           =   1215
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "Add"
      Height          =   375
      Left            =   2760
      TabIndex        =   2
      Top             =   1080
      Width           =   1215
   End
   Begin VB.CommandButton cmdRemove 
      Caption         =   "Remove"
      Height          =   375
      Left            =   2760
      TabIndex        =   1
      Top             =   1560
      Width           =   1215
   End
   Begin VB.ListBox lstThreads 
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   2415
   End
End
Attribute VB_Name = "frmThreading"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Property Get Threads(ByVal pos As Long) As String
    Threads = boardList(activeBoardIndex).theData.Threads(pos)
End Property

Private Property Let Threads(ByVal pos As Long, ByVal new_val As String)
    boardList(activeBoardIndex).theData.Threads(pos) = new_val
End Property

Private Sub cmdAdd_Click()

    On Error Resume Next
    Dim antiPath As String
    Dim whichType As String
    ChDir currentDir

    Dim dlg As FileDialogInfo
    With dlg

        .strDefaultFolder = projectPath & prgPath
        .strTitle = "Program Filename"
        .strDefaultExt = "prg"
        .strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"

        If OpenFileDialog(dlg, Me.hwnd) Then
            filename(1) = .strSelectedFile
            antiPath = .strSelectedFileNoPath
        Else
            Exit Sub
        End If
    
    End With
    
    ChDir currentDir
    If filename(1) = "" Then Exit Sub
    whichType = extention(filename(1))
    FileCopy filename(1), projectPath & prgPath & antiPath

    lstThreads.AddItem antiPath
    
End Sub

Private Sub cmdRemove_Click()

    On Error Resume Next
    lstThreads.RemoveItem lstThreads.ListIndex

End Sub

Private Sub cmdSave_Click()

    saveListBoxContents
    Unload Me

End Sub

Private Sub Form_Load()

    populateListBox

End Sub

Private Sub populateListBox()

    On Error GoTo error
    
    lstThreads.Clear
    
    Dim ub As Long
    ub = UBound(boardList(activeBoardIndex).theData.Threads)

    Dim a As Long
    For a = 0 To ub
        If Not Threads(a) = "" Then
            lstThreads.AddItem Threads(a)
        End If
    Next a

    Exit Sub
error:
End Sub

Private Sub saveListBoxContents()

    Dim a As Long
    ReDim boardList(activeBoardIndex).theData.Threads(0)
    For a = 0 To lstThreads.ListCount - 1
        ReDim Preserve boardList(activeBoardIndex).theData.Threads(a)
        Threads(a) = lstThreads.list(a)
    Next a

End Sub

