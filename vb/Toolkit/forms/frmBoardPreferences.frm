VERSION 5.00
Begin VB.Form frmBoardPreferences 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Board Preferences"
   ClientHeight    =   3795
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6120
   Icon            =   "frmBoardPreferences.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   6120
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4800
      TabIndex        =   18
      Top             =   3360
      Width           =   1215
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   3480
      TabIndex        =   17
      Top             =   3360
      Width           =   1215
   End
   Begin VB.PictureBox picContainer 
      BorderStyle     =   0  'None
      HasDC           =   0   'False
      Height          =   3135
      Left            =   120
      ScaleHeight     =   3135
      ScaleWidth      =   5895
      TabIndex        =   0
      Top             =   120
      Width           =   5895
      Begin VB.Frame fraOptions 
         Caption         =   "Miscellaneous"
         Height          =   3135
         Left            =   3000
         TabIndex        =   12
         Top             =   0
         Width           =   2895
         Begin VB.CheckBox chkNewBoardDialog 
            Caption         =   "Show New Board dialog window"
            Height          =   375
            Left            =   120
            TabIndex        =   16
            Top             =   1560
            Width           =   2655
         End
         Begin VB.CheckBox chkRecursiveFlooding 
            Caption         =   "Use recursive flooding"
            Height          =   375
            Left            =   120
            TabIndex        =   15
            Top             =   1200
            Width           =   1935
         End
         Begin VB.CheckBox chkVectorIndices 
            Caption         =   "Show vector indices"
            Height          =   375
            Left            =   120
            TabIndex        =   14
            Top             =   840
            Width           =   1695
         End
         Begin VB.CheckBox chkRevertToDraw 
            Caption         =   "Revert to draw tool after flooding"
            Height          =   375
            Left            =   120
            TabIndex        =   13
            Top             =   480
            Width           =   2655
         End
      End
      Begin VB.Frame fraColors 
         Caption         =   "Color options"
         Height          =   3135
         Left            =   0
         TabIndex        =   1
         Top             =   0
         Width           =   2895
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   7
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   23
            Top             =   2760
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   6
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   21
            Top             =   2400
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   3
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   20
            Top             =   1320
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   5
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   10
            Top             =   2040
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   4
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   8
            Top             =   1680
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   2
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   6
            Top             =   960
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   1
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   4
            Top             =   600
            Width           =   255
         End
         Begin VB.PictureBox picColors 
            Height          =   255
            Index           =   0
            Left            =   120
            ScaleHeight     =   195
            ScaleWidth      =   195
            TabIndex        =   2
            Top             =   240
            Width           =   255
         End
         Begin VB.Label lblColors 
            Caption         =   "Dynamic lighting nodes"
            Height          =   255
            Index           =   7
            Left            =   480
            TabIndex        =   24
            Top             =   2760
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Player start location"
            Height          =   255
            Index           =   6
            Left            =   480
            TabIndex        =   22
            Top             =   2400
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Waypoint vectors"
            Height          =   255
            Index           =   3
            Left            =   480
            TabIndex        =   19
            Top             =   1320
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Selected sprites and images"
            Height          =   255
            Index           =   5
            Left            =   480
            TabIndex        =   11
            Top             =   2040
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Program vectors"
            Height          =   255
            Index           =   4
            Left            =   480
            TabIndex        =   9
            Top             =   1680
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Stair vectors"
            Height          =   255
            Index           =   2
            Left            =   480
            TabIndex        =   7
            Top             =   960
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Under vectors"
            Height          =   255
            Index           =   1
            Left            =   480
            TabIndex        =   5
            Top             =   600
            Width           =   2295
         End
         Begin VB.Label lblColors 
            Caption         =   "Solid (collision) vectors"
            Height          =   255
            Index           =   0
            Left            =   480
            TabIndex        =   3
            Top             =   240
            Width           =   2295
         End
      End
   End
End
Attribute VB_Name = "frmBoardPreferences"
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

Private Sub cmdCancel_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub cmdDefault_Click() ': On Error Resume Next
    With g_CBoardPreferences
        .bShowNewBoardDialog = chkNewBoardDialog.value
        .bUseRecursiveFlooding = chkRecursiveFlooding.value
        .bRevertToDraw = chkRevertToDraw.value
        .bShowVectorIndices = chkVectorIndices.value
        
        .vectorColor(TT_SOLID) = picColors(0).backColor
        .vectorColor(TT_UNDER) = picColors(1).backColor
        .vectorColor(TT_STAIRS) = picColors(2).backColor
        .vectorColor(TT_WAYPOINT) = picColors(3).backColor
        .programColor = picColors(4).backColor
        .highlightColor = picColors(5).backColor
        .pStartColor = picColors(6).backColor
        .lightsColor = picColors(7).backColor
    End With
    
    Unload Me
    Call activeBoard.drawAll
End Sub

Private Sub Form_Load() ': On Error Resume Next
    With g_CBoardPreferences
        chkNewBoardDialog.value = Abs(.bShowNewBoardDialog)
        chkRecursiveFlooding.value = Abs(.bUseRecursiveFlooding)
        chkRevertToDraw.value = Abs(.bRevertToDraw)
        chkVectorIndices.value = Abs(.bShowVectorIndices)
        
        picColors(0).backColor = .vectorColor(TT_SOLID)
        picColors(1).backColor = .vectorColor(TT_UNDER)
        picColors(2).backColor = .vectorColor(TT_STAIRS)
        picColors(3).backColor = .vectorColor(TT_WAYPOINT)
        picColors(4).backColor = .programColor
        picColors(5).backColor = .highlightColor
        picColors(6).backColor = .pStartColor
        picColors(7).backColor = .lightsColor
    End With
End Sub

Private Sub picColors_Click(Index As Integer): On Error Resume Next
    Dim color As Long
    color = ColorDialog()
    If color >= 0 Then picColors(Index).backColor = color
End Sub
