VERSION 5.00
Begin VB.Form frmThreading 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Threading"
   ClientHeight    =   4575
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4215
   LinkTopic       =   "Form2"
   ScaleHeight     =   4575
   ScaleWidth      =   4215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox lstThreads 
      Appearance      =   0  'Flat
      Height          =   3540
      Left            =   120
      TabIndex        =   4
      Top             =   720
      Width           =   2415
   End
   Begin Toolkit.TKButton cmdRemove 
      Height          =   495
      Left            =   2760
      TabIndex        =   3
      Top             =   2280
      Width           =   1215
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Remove"
   End
   Begin Toolkit.TKButton cmdAdd 
      Height          =   495
      Left            =   2760
      TabIndex        =   2
      Top             =   1680
      Width           =   1215
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Add"
   End
   Begin Toolkit.TKButton cmdSave 
      Height          =   495
      Left            =   2760
      TabIndex        =   1
      Top             =   840
      Width           =   1215
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "Save"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   847
      Object.Width           =   3495
      Caption         =   "Threading"
   End
   Begin VB.Shape shpBorder 
      Height          =   4575
      Left            =   0
      Top             =   0
      Width           =   4215
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

    Set TopBar.theForm = Me
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
        Threads(a) = lstThreads.List(a)
    Next a

End Sub

