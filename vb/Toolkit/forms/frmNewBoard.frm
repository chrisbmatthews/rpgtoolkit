VERSION 5.00
Begin VB.Form frmNewBoard 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "New board"
   ClientHeight    =   3705
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6195
   Icon            =   "frmNewBoard.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3705
   ScaleWidth      =   6195
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraBack 
      Height          =   3615
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   6015
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   3375
         Left            =   120
         ScaleHeight     =   3375
         ScaleWidth      =   5775
         TabIndex        =   19
         Top             =   120
         Width           =   5775
         Begin VB.Frame fraDimensions 
            Caption         =   "Dimensions"
            Height          =   1935
            Left            =   0
            TabIndex        =   24
            Top             =   480
            Width           =   1935
            Begin VB.HScrollBar hsbDims 
               Height          =   255
               Index           =   1
               Left            =   1320
               Max             =   2
               TabIndex        =   5
               Top             =   720
               Value           =   1
               Width           =   495
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   255
               Index           =   2
               Left            =   1320
               Max             =   2
               TabIndex        =   7
               Top             =   1080
               Value           =   1
               Width           =   495
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   255
               Index           =   0
               Left            =   1320
               Max             =   2
               TabIndex        =   3
               Top             =   360
               Value           =   1
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   2
               Left            =   720
               TabIndex        =   6
               Text            =   "4"
               Top             =   1080
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   1
               Left            =   720
               TabIndex        =   4
               Text            =   "10"
               Top             =   720
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   0
               Left            =   720
               TabIndex        =   2
               Text            =   "15"
               Top             =   360
               Width           =   495
            End
            Begin VB.Label lblDims 
               Caption         =   "Layers"
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   28
               Top             =   1120
               Width           =   495
            End
            Begin VB.Label lblPxDimensions 
               Alignment       =   2  'Center
               Caption         =   "(1024 x 1024 pixels)"
               Height          =   255
               Left            =   120
               TabIndex        =   27
               Top             =   1560
               Width           =   1695
            End
            Begin VB.Label lblDims 
               Caption         =   "Height"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   26
               Top             =   760
               Width           =   495
            End
            Begin VB.Label lblDims 
               Caption         =   "Width"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   25
               Top             =   400
               Width           =   495
            End
         End
         Begin VB.Frame fraCoordinates 
            Caption         =   "Coordinate system"
            Height          =   1215
            Left            =   2040
            TabIndex        =   22
            Top             =   480
            Width           =   3735
            Begin VB.PictureBox Picture3 
               Appearance      =   0  'Flat
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   855
               Left            =   120
               ScaleHeight     =   855
               ScaleWidth      =   3495
               TabIndex        =   23
               Top             =   240
               Width           =   3495
               Begin VB.CheckBox chkPxAbsolute 
                  Caption         =   "Use pixel coordinates"
                  Height          =   375
                  Left            =   1680
                  TabIndex        =   11
                  Top             =   480
                  Width           =   1815
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Isometric rotated"
                  Height          =   375
                  Index           =   2
                  Left            =   1680
                  TabIndex        =   9
                  Top             =   0
                  Width           =   1815
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Isometric stacked"
                  Height          =   375
                  Index           =   1
                  Left            =   0
                  TabIndex        =   10
                  Top             =   480
                  Width           =   1575
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Standard"
                  Height          =   375
                  Index           =   0
                  Left            =   0
                  TabIndex        =   8
                  Top             =   0
                  Value           =   -1  'True
                  Width           =   1935
               End
            End
         End
         Begin VB.Frame fraBackground 
            Caption         =   "Background image"
            Height          =   615
            Left            =   2040
            TabIndex        =   20
            Top             =   1800
            Width           =   3735
            Begin VB.PictureBox Picture2 
               Appearance      =   0  'Flat
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   285
               Left            =   3060
               ScaleHeight     =   285
               ScaleWidth      =   615
               TabIndex        =   21
               Top             =   240
               Width           =   615
               Begin VB.CommandButton cmdBrowseBkgImg 
                  Caption         =   "..."
                  Height          =   255
                  Left            =   60
                  TabIndex        =   13
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundImage 
               Height          =   285
               Left            =   240
               TabIndex        =   12
               Top             =   240
               Width           =   2775
            End
         End
         Begin VB.TextBox txtDefaultBoard 
            Enabled         =   0   'False
            Height          =   285
            Left            =   2280
            TabIndex        =   15
            Top             =   2520
            Width           =   2775
         End
         Begin VB.CommandButton cmdBrowseDefaultBoard 
            Caption         =   "..."
            Enabled         =   0   'False
            Height          =   255
            Left            =   5160
            TabIndex        =   16
            Top             =   2520
            Width           =   495
         End
         Begin VB.CommandButton cmdOK 
            Cancel          =   -1  'True
            Caption         =   "OK"
            Height          =   375
            Left            =   4200
            TabIndex        =   18
            Top             =   3000
            Width           =   1455
         End
         Begin VB.CheckBox chkDoNotShow 
            Caption         =   "Do not show this form on startup"
            Height          =   255
            Left            =   120
            TabIndex        =   17
            Top             =   3000
            Width           =   2655
         End
         Begin VB.OptionButton optType 
            Caption         =   "Load a default board"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   14
            Top             =   2520
            Width           =   1815
         End
         Begin VB.OptionButton optType 
            Caption         =   "Specify parameters of the new board"
            Height          =   495
            Index           =   0
            Left            =   120
            TabIndex        =   1
            Top             =   0
            Value           =   -1  'True
            Width           =   3135
         End
      End
   End
End
Attribute VB_Name = "frmNewBoard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Private m_coordOpt As Integer
Private m_width As Integer
Private m_height As Integer
Private m_layers As Integer
Private m_default As String

Private Enum eDimensions
    NB_W
    NB_H
    NB_L
End Enum

Private Sub chkPxAbsolute_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    m_coordOpt = m_coordOpt Xor PX_ABSOLUTE
End Sub
Private Sub cmdBrowseBkgImg_Click(): On Error Resume Next
    Dim file As String
    If browseFileDialog(Me.hwnd, projectPath & bmpPath, "Background image", "jpg", strFileDialogFilterGfx, file) Then
        txtBackgroundImage.Text = file
    End If
End Sub
Private Sub cmdBrowseDefaultBoard_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & brdPath, "Default board", "brd", fileTypes, file) Then
        txtDefaultBoard.Text = file
    End If
End Sub

'========================================================================
'========================================================================
Private Sub cmdOK_Click(): On Error Resume Next
    
    g_CBoardPreferences.bShowNewBoardDialog = (chkDoNotShow.value = 0)
    
    If optType(0).value = True Then
        m_height = IIf(val(txtDims(NB_H).Text) > 0, val(txtDims(NB_H).Text), 10)
        m_layers = IIf(val(txtDims(NB_L).Text) > 0, val(txtDims(NB_L).Text), 10)
        
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New width", CStr(m_width))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New height", CStr(m_height))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New layers", CStr(m_layers))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New coords", CStr(m_coordOpt))
        
        Call loadNewBoard
    Else
        m_default = txtDefaultBoard.Text
        Call SaveSetting("RPGToolkit3", "BRD Editor", "Default board", m_default)
        
        Call loadDefaultBoard
    End If
    Unload Me
End Sub

'========================================================================
'========================================================================
Private Sub Form_Load(): On Error Resume Next

    m_width = val(GetSetting("RPGToolkit3", "BRD Editor", "New width", "20"))
    m_height = val(GetSetting("RPGToolkit3", "BRD Editor", "New height", "15"))
    m_layers = val(GetSetting("RPGToolkit3", "BRD Editor", "New layers", "4"))
    m_coordOpt = val(GetSetting("RPGToolkit3", "BRD Editor", "New coords", "0"))
    m_default = GetSetting("RPGToolkit3", "BRD Editor", "Default board", vbNullString)
        
    If Not g_CBoardPreferences.bShowNewBoardDialog Then
        If m_default = vbNullString Then
            Call loadNewBoard
        Else
            Call loadDefaultBoard
        End If
        Unload Me
        Exit Sub
    End If
    
    txtDims(NB_W).Text = str(m_width)
    txtDims(NB_H).Text = str(m_height)
    txtDims(NB_L).Text = str(m_layers)
    chkPxAbsolute.value = Abs((m_coordOpt And PX_ABSOLUTE) <> 0)
    optCoords(m_coordOpt And Not PX_ABSOLUTE).value = True
    txtDefaultBoard.Text = m_default
    Call updatePxDimensions
    
End Sub

'========================================================================
'========================================================================
Private Sub loadDefaultBoard(): On Error Resume Next
    Dim frm As Form
    Set frm = New frmBoardEdit
    Set activeBoard = frm
    '.newBoard initialises the board editor.
    Call frm.newBoard(1, 1, 1, 0, vbNullString)
    Call frm.Show
    Call activeBoard.openFile(m_default)
    Call tkMainForm.refreshTabs
End Sub

'========================================================================
'========================================================================
Private Sub loadNewBoard(): On Error Resume Next
    Dim frm As Form
    Set frm = New frmBoardEdit
    Set activeBoard = frm
    '.newBoard initialises the board editor.
    Call frm.newBoard(m_width, m_height, m_layers, m_coordOpt, txtBackgroundImage.Text)
    Call frm.Show
    Call tkMainForm.refreshTabs
End Sub

Private Sub hsbDims_Change(Index As Integer): On Error Resume Next
    Dim i As Long
    If hsbDims(Index).value <> 1 Then
        i = val(txtDims(Index).Text) + hsbDims(Index).value - 1
        txtDims(Index).Text = IIf(i < 1, " 1", str(i))
    End If
    hsbDims(Index).value = 1
End Sub

'========================================================================
'========================================================================
Private Sub optCoords_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0:
            m_coordOpt = (m_coordOpt And PX_ABSOLUTE) Or TILE_NORMAL
        Case 1:
            m_coordOpt = (m_coordOpt And PX_ABSOLUTE) Or ISO_STACKED
        Case 2:
            m_coordOpt = (m_coordOpt And PX_ABSOLUTE) Or ISO_ROTATED
    End Select
    Call updatePxDimensions
End Sub

Private Sub optType_Click(Index As Integer): On Error Resume Next
    Dim i As Long
    chkPxAbsolute.Enabled = optType(0).value
    cmdBrowseBkgImg.Enabled = optType(0).value
    lblPxDimensions.Enabled = optType(0).value
    txtBackgroundImage.Enabled = optType(0).value
    fraCoordinates.Enabled = optType(0).value
    fraDimensions.Enabled = optType(0).value
    For i = NB_W To NB_L
        hsbDims(i).Enabled = optType(0).value
        lblDims(i).Enabled = optType(0).value
        txtDims(i).Enabled = optType(0).value
    optCoords(i).Enabled = optType(0).value
    Next i
    
    txtDefaultBoard.Enabled = optType(1).value
    cmdBrowseDefaultBoard.Enabled = optType(1).value
End Sub

'========================================================================
'========================================================================
Private Sub txtDims_Change(Index As Integer): On Error Resume Next
    Dim i As Long
    i = IIf(val(txtDims(Index).Text) > 0, val(txtDims(Index).Text), 10)
    Select Case Index
        Case NB_W: m_width = i
        Case NB_H: m_height = i
        Case NB_L: m_layers = i
    End Select
    Call updatePxDimensions
End Sub
Private Sub updatePxDimensions(): On Error Resume Next
    lblPxDimensions.Caption = "(" & str(absWidth(m_width, m_coordOpt)) & " x " _
        & str(absHeight(m_height, m_coordOpt)) & " pixels)"
End Sub

