VERSION 5.00
Begin VB.Form warpset 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Set Warp"
   ClientHeight    =   2655
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6375
   Icon            =   "warpset.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2655
   ScaleWidth      =   6375
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1775"
   Begin Toolkit.TKButton Command1 
      Height          =   495
      Left            =   5400
      TabIndex        =   11
      Top             =   600
      Width           =   855
      _ExtentX        =   820
      _ExtentY        =   873
      Object.Width           =   450
      Caption         =   "OK"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   847
      Object.Width           =   5055
      Caption         =   "Warp Set"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Set Warp Tile at X, Y, Layer"
      ForeColor       =   &H80000008&
      Height          =   1935
      Left            =   120
      TabIndex        =   0
      Tag             =   "1779"
      Top             =   600
      Width           =   5175
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   1440
         TabIndex        =   5
         Top             =   360
         Width           =   2295
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   1440
         TabIndex        =   4
         Top             =   720
         Width           =   2295
      End
      Begin VB.TextBox Text3 
         Height          =   285
         Left            =   1440
         TabIndex        =   3
         Top             =   1080
         Width           =   2295
      End
      Begin VB.TextBox Text4 
         Height          =   285
         Left            =   1440
         TabIndex        =   2
         Top             =   1440
         Width           =   2295
      End
      Begin VB.CommandButton Command4 
         Appearance      =   0  'Flat
         Caption         =   "Browse..."
         Height          =   345
         Left            =   3840
         TabIndex        =   1
         Tag             =   "1021"
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Destination:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Tag             =   "1778"
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "X Position:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Tag             =   "1777"
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Y Position:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Tag             =   "1776"
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Layer:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Tag             =   "1710"
         Top             =   1440
         Width           =   1095
      End
   End
   Begin VB.Shape Shape1 
      Height          =   2655
      Left            =   0
      Top             =   0
      Width           =   6375
   End
End
Attribute VB_Name = "warpset"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Option Explicit added
' + New visual style applied
' + Removed $s
' + Swapped +s for &s where appropriate
'
' ---What needs to be done
' + Rename controls
'
'=======================================================

Option Explicit

Private Sub Command1_Click()

    Dim de As String, deX As Long, deY As Long, deL As Long, st As Long, done As Boolean, Length As Long

    de = Text1.Text
    deX = val(Text2.Text)
    deY = val(Text3.Text)
    deL = val(Text4.Text)

    Do Until done
    
        Dim tX As String
        tX = CStr(st)
        If Len(tX) < 8 Then
            Length = Len(tX)
            Dim t As Long
            For t = 1 To 8 - Length
                tX = "0" & tX
            Next t
        End If
        tX = "warp" & tX & ".prg"
        If Not fileExists(projectPath & prgPath & tX) Then
            done = True
        Else
            st = st + 1
            If st > 99999999 Then
                MsgBox "Cannot make more warp tile programs!"
                Unload Me
                Exit Sub
            End If
        End If
    Loop

    Dim num As Long
    num = FreeFile()
    Open projectPath & prgPath & tX For Output As num
        Print #num, "*Warp tile generated by board editor"
        Print #num, "Send(" & chr(34) & de & chr(34) & "," & str(deX) & "," & str(deY) & "," & str(deL) & ")"
    Close #num

    'search for a free program space.
    Dim thisProgram As Long
    thisProgram = -1
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName(t) = "" Then
            thisProgram = t
            t = UBound(boardList(activeBoardIndex).theData.programName)
        End If
    Next t

    If thisProgram = -1 Then MsgBox LoadStringLoc(975, "This board already has 500 programs.  This is the set limit."), , LoadStringLoc(976, "Too many programs."): Exit Sub

    With boardList(activeBoardIndex).theData
        .programName(thisProgram) = tX
        .progX(thisProgram) = boardList(activeBoardIndex).infoX              'program x
        .progY(thisProgram) = boardList(activeBoardIndex).infoY              'program y
        .progLayer(thisProgram) = boardList(activeBoardIndex).currentLayer   'program layer
    End With

    Unload Me

End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Command4_Click()

    On Error Resume Next
    
    ChDir (currentDir)
    
    Dim dlg As FileDialogInfo
    
    With dlg
        .strDefaultFolder = projectPath & brdPath
        .strTitle = "Open Board"
        .strDefaultExt = "brd"
        .strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    
        If OpenFileDialog(dlg, Me.hwnd) Then
            filename(1) = .strSelectedFile
            Dim antiPath As String
            antiPath = .strSelectedFileNoPath
        Else
            Exit Sub
        End If

        ChDir (currentDir)
        If filename(1) = "" Then Exit Sub
        FileCopy filename(1), projectPath & brdPath & antiPath
        Text1.Text = antiPath

    End With

End Sub

Private Sub Form_Load()
    On Error Resume Next
    ' Call LocalizeForm(Me)
    Frame1.Caption = str(boardList(activeBoardIndex).infoX) & "," & str(boardList(activeBoardIndex).infoY) & "," & str(boardList(activeBoardIndex).currentLayer)
    Set TopBar.theForm = Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    tkMainForm.boardToolbar.Objects.Populate
End Sub
