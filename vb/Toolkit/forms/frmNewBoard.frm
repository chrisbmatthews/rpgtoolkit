VERSION 5.00
Begin VB.Form frmNewBoard 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "New board"
   ClientHeight    =   3705
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5985
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3705
   ScaleWidth      =   5985
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraBack 
      Height          =   3615
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   5775
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   3375
         Left            =   120
         ScaleHeight     =   3375
         ScaleWidth      =   5535
         TabIndex        =   1
         Top             =   120
         Width           =   5535
         Begin VB.Frame fraDimensions 
            Caption         =   "Dimensions"
            Height          =   1935
            Left            =   0
            TabIndex        =   18
            Top             =   480
            Width           =   1695
            Begin VB.TextBox txtLayers 
               Height          =   285
               Left            =   240
               TabIndex        =   21
               Text            =   "4"
               Top             =   1080
               Width           =   495
            End
            Begin VB.TextBox txtHeight 
               Height          =   285
               Left            =   240
               TabIndex        =   20
               Text            =   "10"
               Top             =   720
               Width           =   495
            End
            Begin VB.TextBox txtWidth 
               Height          =   285
               Left            =   240
               TabIndex        =   19
               Text            =   "15"
               Top             =   360
               Width           =   495
            End
            Begin VB.Label lblLayers 
               Caption         =   "Layers"
               Height          =   255
               Left            =   840
               TabIndex        =   25
               Top             =   1140
               Width           =   615
            End
            Begin VB.Label lblPxDimensions 
               Alignment       =   2  'Center
               Caption         =   "(1024 x 1024 pixels)"
               Height          =   375
               Left            =   120
               TabIndex        =   24
               Top             =   1440
               Width           =   1455
            End
            Begin VB.Label lblHeight 
               Caption         =   "Height"
               Height          =   255
               Left            =   840
               TabIndex        =   23
               Top             =   780
               Width           =   615
            End
            Begin VB.Label lblWidth 
               Caption         =   "Width"
               Height          =   255
               Left            =   840
               TabIndex        =   22
               Top             =   420
               Width           =   495
            End
         End
         Begin VB.Frame fraCoordinates 
            Caption         =   "Coordinate system"
            Height          =   1215
            Left            =   1800
            TabIndex        =   12
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
               TabIndex        =   13
               Top             =   240
               Width           =   3495
               Begin VB.CheckBox chkPxAbsolute 
                  Caption         =   "Use pixel coordinates"
                  Height          =   375
                  Left            =   1680
                  TabIndex        =   17
                  Top             =   480
                  Width           =   1815
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Isometric rotated"
                  Height          =   375
                  Index           =   2
                  Left            =   1680
                  TabIndex        =   16
                  Top             =   0
                  Width           =   1815
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Isometric stacked"
                  Height          =   375
                  Index           =   1
                  Left            =   0
                  TabIndex        =   15
                  Top             =   480
                  Width           =   1575
               End
               Begin VB.OptionButton optCoords 
                  Caption         =   "Standard"
                  Height          =   375
                  Index           =   0
                  Left            =   0
                  TabIndex        =   14
                  Top             =   0
                  Value           =   -1  'True
                  Width           =   1935
               End
            End
         End
         Begin VB.Frame fraBackground 
            Caption         =   "Background image"
            Height          =   615
            Left            =   1800
            TabIndex        =   8
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
               TabIndex        =   10
               Top             =   240
               Width           =   615
               Begin VB.CommandButton cmdBrowseBkgImg 
                  Caption         =   "..."
                  Height          =   255
                  Left            =   60
                  TabIndex        =   11
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundImage 
               Height          =   285
               Left            =   240
               TabIndex        =   9
               Top             =   240
               Width           =   2775
            End
         End
         Begin VB.TextBox txtDefaultBoard 
            Height          =   285
            Left            =   2040
            TabIndex        =   7
            Top             =   2520
            Width           =   2775
         End
         Begin VB.CommandButton cmdBrowseDefaultBoard 
            Caption         =   "..."
            Height          =   255
            Left            =   4920
            TabIndex        =   6
            Top             =   2520
            Width           =   495
         End
         Begin VB.CommandButton cmdOK 
            Cancel          =   -1  'True
            Caption         =   "OK"
            Height          =   375
            Left            =   3960
            TabIndex        =   5
            Top             =   3000
            Width           =   1455
         End
         Begin VB.CheckBox chkDoNotShow 
            Caption         =   "Do not show this form on startup"
            Height          =   255
            Left            =   120
            TabIndex        =   4
            Top             =   3000
            Width           =   2655
         End
         Begin VB.OptionButton optType 
            Caption         =   "Load a default board"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   3
            Top             =   2520
            Width           =   1815
         End
         Begin VB.OptionButton optType 
            Caption         =   "Specify parameters of the new board"
            Height          =   495
            Index           =   0
            Left            =   120
            TabIndex        =   2
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

Private Sub chkPxAbsolute_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    m_coordOpt = m_coordOpt Xor PX_ABSOLUTE
End Sub
Private Sub cmdBrowseBkgImg_Click()
    MsgBox "tbd"
End Sub
Private Sub cmdBrowseDefaultBoard_Click()
    MsgBox "tbd"
End Sub

'========================================================================
'========================================================================
Private Sub cmdOK_Click(): On Error Resume Next
    
    If chkDoNotShow.value = 1 Then
        Call SaveSetting("RPGToolkit3", "BRD Editor", "Show frmNewBoard", "1")
    End If
    
    If optType(0).value = True Then
        m_height = IIf(val(txtHeight.Text) > 0, val(txtHeight.Text), 10)
        m_layers = IIf(val(txtLayers.Text) > 0, val(txtLayers.Text), 10)
        
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New width", str(m_width))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New height", str(m_height))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New layers", str(m_layers))
        Call SaveSetting("RPGToolkit3", "BRD Editor", "New coords", str(m_coordOpt))
        
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

    m_width = val(GetSetting("RPGToolkit3", "BRD Editor", "New width", "5"))
    m_height = val(GetSetting("RPGToolkit3", "BRD Editor", "New height", "5"))
    m_layers = val(GetSetting("RPGToolkit3", "BRD Editor", "New layers", "4"))
    m_coordOpt = val(GetSetting("RPGToolkit3", "BRD Editor", "New coords", "0"))
    m_default = GetSetting("RPGToolkit3", "BRD Editor", "Default board", vbNullString)
        
    If GetSetting("RPGToolkit3", "BRD Editor", "Show frmNewBoard", "0") = "1" Then
        If m_default = vbNullString Then
            Call loadNewBoard
        Else
            Call loadDefaultBoard
        End If
        Unload Me
    End If
    
    txtWidth.Text = str(m_width)
    txtHeight.Text = str(m_height)
    txtLayers.Text = str(m_layers)
    optCoords(m_coordOpt And Not PX_ABSOLUTE).value = True
    chkPxAbsolute.value = Abs((m_coordOpt And PX_ABSOLUTE) <> 0)
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

'========================================================================
'========================================================================
Private Sub optCoords_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0:
            m_coordOpt = TILE_NORMAL
        Case 1:
            m_coordOpt = ISO_STACKED
        Case 2:
            m_coordOpt = ISO_ROTATED
    End Select
    Call updatePxDimensions
End Sub

'========================================================================
'========================================================================
Private Sub txtWidth_Change(): On Error Resume Next
    m_width = IIf(val(txtWidth.Text) > 0, val(txtWidth.Text), 10)
    Call updatePxDimensions
End Sub
Private Sub txtHeight_Change(): On Error Resume Next
    m_height = IIf(val(txtHeight.Text) > 0, val(txtHeight.Text), 10)
    Call updatePxDimensions
End Sub
Private Sub updatePxDimensions(): On Error Resume Next
    lblPxDimensions.Caption = "(" & str(absWidth(m_width, m_coordOpt)) & " x " _
        & str(absHeight(m_height, m_coordOpt)) & " pixels)"
End Sub

