VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmBoardEdit 
   Caption         =   "frmBoardEdit"
   ClientHeight    =   6465
   ClientLeft      =   60
   ClientTop       =   750
   ClientWidth     =   11340
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6465
   ScaleWidth      =   11340
   Begin TabDlg.SSTab sstBoard 
      Height          =   6255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   10335
      _ExtentX        =   18230
      _ExtentY        =   11033
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabHeight       =   520
      ShowFocusRect   =   0   'False
      TabCaption(0)   =   "Board"
      TabPicture(0)   =   "frmBoardEdit.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "picBoard"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "vScroll"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "hScroll"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Properties"
      TabPicture(1)   =   "frmBoardEdit.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "picProperties"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).ControlCount=   1
      Begin VB.PictureBox picProperties 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         HasDC           =   0   'False
         Height          =   5775
         Left            =   -74880
         ScaleHeight     =   5775
         ScaleWidth      =   10095
         TabIndex        =   4
         Top             =   360
         Width           =   10095
         Begin VB.Frame fraProperties 
            Caption         =   "Threads"
            Height          =   1575
            Index           =   2
            Left            =   0
            TabIndex        =   71
            Top             =   4200
            Width           =   4935
            Begin VB.ListBox lbThreads 
               Height          =   1035
               Left            =   840
               TabIndex        =   75
               Top             =   360
               Width           =   2055
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   975
               Index           =   5
               Left            =   3120
               ScaleHeight     =   975
               ScaleWidth      =   975
               TabIndex        =   72
               Top             =   360
               Width           =   975
               Begin VB.CommandButton cmdThreadsAdd 
                  Caption         =   "Add"
                  Height          =   375
                  Index           =   0
                  Left            =   0
                  TabIndex        =   74
                  Top             =   0
                  Width           =   975
               End
               Begin VB.CommandButton cmdThreadsRemove 
                  Caption         =   "Remove"
                  Height          =   375
                  Index           =   1
                  Left            =   0
                  TabIndex        =   73
                  Top             =   480
                  Width           =   975
               End
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Dimensions"
            Height          =   1335
            Index           =   3
            Left            =   5160
            TabIndex        =   59
            Top             =   0
            Width           =   4935
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   2
               Left            =   4080
               TabIndex        =   65
               Top             =   600
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   2
               Left            =   3360
               TabIndex        =   64
               Text            =   "Text7"
               Top             =   600
               Width           =   615
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   1
               Left            =   1560
               TabIndex        =   63
               Top             =   840
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   1
               Left            =   840
               TabIndex        =   62
               Text            =   "Text7"
               Top             =   840
               Width           =   615
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   0
               Left            =   1560
               TabIndex        =   61
               Top             =   360
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   0
               Left            =   840
               TabIndex        =   60
               Text            =   "Text7"
               Top             =   360
               Width           =   615
            End
            Begin VB.Label lblProperties 
               Caption         =   "Layers"
               Height          =   255
               Index           =   12
               Left            =   3360
               TabIndex        =   70
               Top             =   360
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "1024 pixels"
               Height          =   255
               Index           =   11
               Left            =   2160
               TabIndex        =   69
               Top             =   840
               Width           =   975
            End
            Begin VB.Label lblProperties 
               Caption         =   "1024 pixels"
               Height          =   255
               Index           =   10
               Left            =   2160
               TabIndex        =   68
               Top             =   360
               Width           =   975
            End
            Begin VB.Label lblProperties 
               Caption         =   "Width"
               Height          =   255
               Index           =   8
               Left            =   120
               TabIndex        =   67
               Top             =   360
               Width           =   735
            End
            Begin VB.Label lblProperties 
               Caption         =   "Height"
               Height          =   255
               Index           =   9
               Left            =   120
               TabIndex        =   66
               Top             =   840
               Width           =   735
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Variables"
            Height          =   1215
            Index           =   4
            Left            =   5160
            TabIndex        =   50
            Top             =   1440
            Width           =   4935
            Begin VB.ComboBox cmbLayerTitles 
               Height          =   315
               Left            =   960
               TabIndex        =   54
               Text            =   "Combo2"
               Top             =   720
               Width           =   1335
            End
            Begin VB.TextBox txtLayerTitle 
               Height          =   285
               Left            =   3000
               TabIndex        =   53
               Text            =   "Text6"
               Top             =   720
               Width           =   1815
            End
            Begin VB.TextBox txtConstant 
               Height          =   285
               Left            =   3000
               TabIndex        =   52
               Text            =   "Text5"
               Top             =   240
               Width           =   1815
            End
            Begin VB.ComboBox cmbConstants 
               Height          =   315
               Left            =   960
               TabIndex        =   51
               Text            =   "Combo1"
               Top             =   240
               Width           =   1335
            End
            Begin VB.Label lblProperties 
               Caption         =   "Layer"
               Height          =   255
               Index           =   15
               Left            =   120
               TabIndex        =   58
               Top             =   720
               Width           =   735
            End
            Begin VB.Label lblProperties 
               Caption         =   "Title"
               Height          =   255
               Index           =   16
               Left            =   2400
               TabIndex        =   57
               Top             =   720
               Width           =   855
            End
            Begin VB.Label lblProperties 
               Caption         =   "Value"
               Height          =   255
               Index           =   14
               Left            =   2400
               TabIndex        =   56
               Top             =   240
               Width           =   855
            End
            Begin VB.Label lblProperties 
               Caption         =   "Constant"
               Height          =   255
               Index           =   13
               Left            =   120
               TabIndex        =   55
               Top             =   240
               Width           =   975
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Miscellaneous"
            Height          =   1575
            Index           =   6
            Left            =   5160
            TabIndex        =   44
            Top             =   4200
            Width           =   4935
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   6
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   47
               Top             =   960
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   8
                  Left            =   0
                  TabIndex        =   48
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtPrgEnterBoard 
               Height          =   285
               Left            =   840
               TabIndex        =   46
               Text            =   "Text2"
               Top             =   960
               Width           =   2655
            End
            Begin VB.CheckBox chkProgressiveSaving 
               Caption         =   "Disable progressive saving"
               Height          =   255
               Left            =   600
               TabIndex        =   45
               Top             =   360
               Width           =   3255
            End
            Begin VB.Label lblProperties 
               Caption         =   "Program to run when entering board"
               Height          =   255
               Index           =   19
               Left            =   840
               TabIndex        =   49
               Top             =   720
               Width           =   2775
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Battle settings"
            Height          =   1335
            Index           =   5
            Left            =   5160
            TabIndex        =   36
            Top             =   2760
            Width           =   4935
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   9
               Left            =   4320
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   40
               Top             =   720
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   7
                  Left            =   0
                  TabIndex        =   41
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBattleBackground 
               Height          =   285
               Left            =   1560
               TabIndex        =   39
               Text            =   "Text4"
               Top             =   720
               Width           =   2655
            End
            Begin VB.TextBox txtBoardSkill 
               Height          =   285
               Left            =   4320
               TabIndex        =   38
               Text            =   "Text3"
               Top             =   240
               Width           =   495
            End
            Begin VB.CheckBox chkEnableBattles 
               Caption         =   "Enable fighting on this board"
               Height          =   375
               Left            =   240
               TabIndex        =   37
               Top             =   240
               Width           =   2535
            End
            Begin VB.Label lblProperties 
               Caption         =   "Battle background"
               Height          =   495
               Index           =   17
               Left            =   240
               TabIndex        =   43
               Top             =   720
               Width           =   1095
            End
            Begin VB.Label lblProperties 
               Caption         =   "Board skill"
               Height          =   255
               Index           =   18
               Left            =   3360
               TabIndex        =   42
               Top             =   240
               Width           =   855
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Links"
            Height          =   2055
            Index           =   0
            Left            =   0
            TabIndex        =   18
            Top             =   0
            Width           =   4935
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   3
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   29
               Top             =   1680
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   4
                  Left            =   0
                  TabIndex        =   30
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   3
               Left            =   840
               TabIndex        =   28
               Text            =   "Text2"
               Top             =   1680
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   2
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   26
               Top             =   1320
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   3
                  Left            =   0
                  TabIndex        =   27
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   2
               Left            =   840
               TabIndex        =   25
               Text            =   "Text2"
               Top             =   1320
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   1
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   23
               Top             =   960
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   2
                  Left            =   0
                  TabIndex        =   24
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   1
               Left            =   840
               TabIndex        =   22
               Text            =   "Text2"
               Top             =   960
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   0
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   20
               Top             =   600
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   1
                  Left            =   0
                  TabIndex        =   21
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   0
               Left            =   840
               TabIndex        =   19
               Text            =   "Text2"
               Top             =   600
               Width           =   2655
            End
            Begin VB.Label lblProperties 
               Caption         =   "Directional links (board or program)"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   35
               Top             =   240
               Width           =   3255
            End
            Begin VB.Label lblProperties 
               Caption         =   "North"
               Height          =   255
               Index           =   1
               Left            =   240
               TabIndex        =   34
               Top             =   600
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "South"
               Height          =   255
               Index           =   2
               Left            =   240
               TabIndex        =   33
               Top             =   960
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "East"
               Height          =   255
               Index           =   3
               Left            =   240
               TabIndex        =   32
               Top             =   1320
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "West"
               Height          =   255
               Index           =   4
               Left            =   240
               TabIndex        =   31
               Top             =   1680
               Width           =   495
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Background settings"
            Height          =   1935
            Index           =   1
            Left            =   0
            TabIndex        =   5
            Top             =   2160
            Width           =   4935
            Begin VB.PictureBox picBackgroundColor 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   255
               Left            =   2880
               ScaleHeight     =   255
               ScaleWidth      =   615
               TabIndex        =   14
               Top             =   960
               Width           =   615
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   4
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   12
               Top             =   480
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   0
                  Left            =   0
                  TabIndex        =   13
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundImage 
               Height          =   285
               Left            =   840
               TabIndex        =   11
               Text            =   "Text1"
               Top             =   480
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   8
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   9
               Top             =   960
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   5
                  Left            =   0
                  TabIndex        =   10
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundMusic 
               Height          =   285
               Left            =   840
               TabIndex        =   8
               Text            =   "Text2"
               Top             =   1440
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   375
               Index           =   7
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   6
               Top             =   1440
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   6
                  Left            =   0
                  TabIndex        =   7
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.Label lblProperties 
               Caption         =   "Board background color"
               Height          =   255
               Index           =   6
               Left            =   840
               TabIndex        =   17
               Top             =   880
               Width           =   1815
            End
            Begin VB.Label lblProperties 
               Caption         =   "Board background image"
               Height          =   255
               Index           =   5
               Left            =   840
               TabIndex        =   16
               Top             =   240
               Width           =   2775
            End
            Begin VB.Label lblProperties 
               Caption         =   "Background music"
               Height          =   255
               Index           =   7
               Left            =   840
               TabIndex        =   15
               Top             =   1200
               Width           =   2775
            End
         End
      End
      Begin VB.HScrollBar hScroll 
         Height          =   255
         Left            =   120
         SmallChange     =   32
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   3000
         Width           =   4215
      End
      Begin VB.VScrollBar vScroll 
         Height          =   2655
         Left            =   4320
         SmallChange     =   32
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   360
         Width           =   255
      End
      Begin VB.PictureBox picBoard 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2655
         Left            =   120
         MousePointer    =   1  'Arrow
         ScaleHeight     =   177
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   281
         TabIndex        =   1
         Top             =   360
         Width           =   4215
         Begin VB.Line lineSelection 
            BorderStyle     =   3  'Dot
            DrawMode        =   6  'Mask Pen Not
            Index           =   0
            Visible         =   0   'False
            X1              =   32
            X2              =   128
            Y1              =   64
            Y2              =   64
         End
         Begin VB.Line lineSelection 
            BorderStyle     =   3  'Dot
            DrawMode        =   6  'Mask Pen Not
            Index           =   1
            Visible         =   0   'False
            X1              =   32
            X2              =   128
            Y1              =   128
            Y2              =   128
         End
         Begin VB.Line lineSelection 
            BorderStyle     =   3  'Dot
            DrawMode        =   6  'Mask Pen Not
            Index           =   2
            Visible         =   0   'False
            X1              =   32
            X2              =   32
            Y1              =   64
            Y2              =   128
         End
         Begin VB.Line lineSelection 
            BorderStyle     =   3  'Dot
            DrawMode        =   6  'Mask Pen Not
            Index           =   3
            Visible         =   0   'False
            X1              =   128
            X2              =   128
            Y1              =   64
            Y2              =   128
         End
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "Edit"
      Begin VB.Menu mnuUndo 
         Caption         =   "Undo"
         Shortcut        =   ^Z
      End
      Begin VB.Menu mnuRedo 
         Caption         =   "Redo"
         Shortcut        =   ^Y
      End
      Begin VB.Menu mnuS1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCopy 
         Caption         =   "Copy"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuCut 
         Caption         =   "Cut"
         Shortcut        =   ^X
      End
      Begin VB.Menu mnuPaste 
         Caption         =   "Paste"
         Shortcut        =   ^V
      End
      Begin VB.Menu mnuS2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectAll 
         Caption         =   "Select All"
         Shortcut        =   ^A
      End
   End
End
Attribute VB_Name = "frmBoardEdit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
'Note to self: wip = temporary additions to old code.
'Files to consider (remember to remove from cvs after use)
'   boardinformation
'   boardlighting
'   boardgradientdefine
'   brdbackground
'   BoardDayNightForm (?)
'   frmThreading
'   itemmenu
'   itemset
'   programmenu
'   programset
'   spotlighting
'   tileinfo
'   warpset
'   CScrollBoard
'   cBoardToolbar & co.

Option Explicit

Implements ISubclass

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)

Private Declare Function ExtFloodFill Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal wFillType As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long

Private Declare Function BRDNewCBoard Lib "actkrt3.dll" (ByVal projectPath As String) As Long
Private Declare Function BRDFree Lib "actkrt3.dll" (ByVal pCBoard As Long) As Long
Private Declare Function BRDRender Lib "actkrt3.dll" (ByVal pEditorData As Long, ByVal pData As Long, ByVal hdcCompat As Long, ByVal bDestroyCanvas As Boolean, Optional ByVal layer As Long = 0) As Long
Private Declare Function BRDDraw Lib "actkrt3.dll" (ByVal pEditorData As Long, ByVal pData As Long, ByVal hdc As Long, ByVal destX As Long, ByVal destY As Long, ByVal brdX As Long, ByVal brdY As Long, ByVal width As Long, ByVal Height As Long, ByVal zoom As Double) As Long
Private Declare Function BRDRenderTileToBoard Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByVal hdcCompat As Long, ByVal x As Long, ByVal y As Long, ByVal z As Long) As Long
Private Declare Function BRDRenderTile Lib "actkrt3.dll" (ByVal filename As String, ByVal bIsometric As Boolean, ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal backColor As Long) As Long
Private Declare Function BRDFreeImage Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pImage As Long) As Long

Private Declare Function CNVGetWidth Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVGetHeight Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVResize Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdcCompatible As Long, ByVal width As Long, ByVal Height As Long) As Long

Private m_ed As TKBoardEditorData
Private m_sel As CBoardSelection
Private m_mouseScrollDistance As Long
Private m_bScrollVertical As Boolean    ' Scroll vertically? (If false, scroll horizontally.)

Private Const BTAB_BOARD = 0
Private Const BTAB_PROPERTIES = 1

Private m_ctls(BTAB_IMAGE) As Object

Private Const WM_MOUSEWHEEL = &H20A     ' Event: mouse wheel was scrolled.
Private Const WM_MBUTTONDOWN = &H207    ' Event: mouse wheel was pressed down.
Private Const WHEEL_DELTA = 120         ' One complete rotation of the scroll wheel.
Private Const MK_CONTROL = 8            ' The control key was down while a mouse event took place.
Private Const MAX_UNDO = 10             ' Maximum number of undo-redo positions.

'=========================================================================
'=========================================================================
Private Sub initializeEditor(ByRef ed As TKBoardEditorData) ': On Error Resume Next
    ' Assign default values.
    Dim i As Long
    Call resetEditor(ed)
    With ed
        .pCEd.zoom = 1
        If (.pCBoard) Then Call BRDFree(.pCBoard)
        .pCBoard = BRDNewCBoard(projectPath)
        .bRevertToDraw = True
        .currentLayer = 1
        For i = 0 To UBound(m_ed.currentObject)
            m_ed.currentObject(i) = -1              'Initialise the selected objects.
        Next i
    End With
    Set m_sel = New CBoardSelection
    
    'testing
    m_ed.board(m_ed.undoIndex).brdColor = 0 'RGB(255, 255, 255)
    m_ed.vectorColor(TT_SOLID) = RGB(255, 255, 255)
    m_ed.vectorColor(TT_UNDER) = RGB(0, 255, 0)
    m_ed.vectorColor(TT_STAIRS) = RGB(0, 255, 255)
    m_ed.programColor = RGB(255, 255, 0)
    m_ed.waypointColor = RGB(255, 0, 0)
    m_ed.gridColor = RGB(255, 255, 255)
    m_ed.bShowVectorIndices = True
End Sub
'=========================================================================
'=========================================================================
Private Sub resetEditor(ByRef ed As TKBoardEditorData) ': On Error Resume Next
    With ed
        Dim i As Integer '.bLayerOccupied assigned in openBoard()
        ReDim .bLayerVisible(m_ed.board(m_ed.undoIndex).bSizeL + 1)
        For i = 1 To UBound(.bLayerVisible)
            .bLayerVisible(i) = True
        Next i
        Call resetLayerCombos
    End With
End Sub
'=========================================================================
'=========================================================================
Public Sub newBoard(ByVal x As Long, ByVal y As Long, ByVal z As Long, ByVal coordType As Long, ByVal background As String) ':on error resume next
    ReDim m_ed.board(MAX_UNDO)                  'Cannot be a static array.
    ReDim m_ed.bUndoData(MAX_UNDO)
    m_ed.bUndoData(m_ed.undoIndex) = True
    
    m_ed.board(m_ed.undoIndex).coordType = coordType
    Call BoardClear(m_ed.board(m_ed.undoIndex))
    Call BoardSetSize(x, y, z, m_ed, m_ed.board(m_ed.undoIndex))
    
    m_ed.board(m_ed.undoIndex).bkgImage.file = background
    Call initializeEditor(m_ed)
    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, True)
End Sub

'========================================================================
' change selected tile {from tkMainForm: currentTilesetForm_MouseDown}
'========================================================================
Public Sub changeSelectedTile(ByVal file As String) ': On Error Resume Next

    tkMainForm.brdPicCurrentTile.Cls
    If (LenB(file) = 0) Then Exit Sub

    ' update tileset filename
    m_ed.selectedTile = file
    
    ' change setting/tool to tile/draw.
    If m_ed.optSetting <> BS_TILE Then
        m_ed.optSetting = BS_TILE
        m_ed.optTool = BT_DRAW
        tkMainForm.brdOptSetting(m_ed.optSetting).value = True
        tkMainForm.brdOptTool(m_ed.optTool).value = True
    End If
    
    Call BRDRenderTile( _
        projectPath & tilePath & file, _
        isIsometric(m_ed.board(m_ed.undoIndex).coordType), _
        tkMainForm.brdPicCurrentTile.hdc, _
        IIf(isIsometric(m_ed.board(m_ed.undoIndex).coordType), 0, 16), 0, _
        GetSysColor(tkMainForm.brdPicCurrentTile.backColor And &HFFFFFF) _
    )
    tkMainForm.brdPicCurrentTile.ToolTipText = file
End Sub

'========================================================================
' identify type of form
'========================================================================
Public Property Get formType() As Long: On Error Resume Next
    formType = FT_BOARD
End Property
Private Sub Form_Activate() ':on error resume next
    Set activeBoard = Me
    Set activeForm = Me
        
    'Show tools.
    hideAllTools
    tkMainForm.popButton(3).Visible = True              'Board toolbar
    tkMainForm.boardTools.Visible = True                'Lefthand tools
    tkMainForm.boardTools.Top = tkMainForm.toolTop
    
    tkMainForm.brdOptSetting(m_ed.optSetting).value = True
    tkMainForm.brdOptTool(m_ed.optTool).value = True
    tkMainForm.brdChkGrid.value = Abs(m_ed.bGrid)
    tkMainForm.brdChkAutotile.value = Abs(m_ed.bAutotiler)
    Call toolsRefresh
    
    mnuUndo.Enabled = m_ed.bUndoData(nextUndo)
    mnuRedo.Enabled = m_ed.bUndoData(nextRedo)
    
    Call resetLayerCombos
    
    'Update the toolbar.
    Call toolbarPopulatePrgs
    Call toolbarPopulateImages
    Call toolbarPopulateSprites
    
    If tkMainForm.popButton(3).value = 1 Then
        tkMainForm.pTools.Visible = True
    End If
    
    tkMainForm.StatusBar1.Panels(4).Text = "Zoom: " & str(m_ed.pCEd.zoom * 100) & "%"
   
    'Tick the flood option if entry made.
    'mnuRecursiveFlooding.Checked = False
    'If GetSetting("RPGToolkit3", "Settings", "Recursive Flooding", "0") = "1" Then mnuRecursiveFlooding.Checked = True
    
    Call Form_Resize
    
    Exit Sub
    
    'Redraw the selected tile.
    'tkMainForm.currenttile.Cls
    'tkMainForm.currenttileIso.Cls
    'tkMainForm.bFrame(2).Caption = "Current Tile - None" & "       "
    'Call changeSelectedTile(boardList(activeBoardIndex).selectedTile)
    'tkMainForm.animTileTimer.Enabled = m_bAnimating

End Sub
Public Sub Form_Deactivate() ':on error resume next
    'Clear status panels.
    tkMainForm.StatusBar1.Panels(3).Text = vbNullString
    tkMainForm.StatusBar1.Panels(4).Text = vbNullString

    'Reset visible layers list.
    Call setVisibleLayersByCombo
    
    tkMainForm.popButton(3).Visible = False
    tkMainForm.pTools.Visible = False
End Sub
Private Sub Form_KeyDown(keyCode As Integer, Shift As Integer) ':on error resume next
    Call picBoard_KeyDown(keyCode, Shift)
End Sub
Private Sub Form_Load() ':on error resume next
    'Board loading performed explicitly through newBoard()
    Dim i As Long
    Set activeBoard = Me
    
    'Pixel scaling
    picBoard.ScaleMode = vbPixels
    
    'Ctls
    Set m_ctls(BTAB_VECTOR) = tkMainForm.bTools_ctlVector
    Set m_ctls(BTAB_PROGRAM) = tkMainForm.bTools_ctlPrg
    Set m_ctls(BTAB_SPRITE) = tkMainForm.bTools_ctlSprite
    Set m_ctls(BTAB_IMAGE) = tkMainForm.bTools_ctlImage
    
    'Map the settings to the tabs
    For i = 0 To UBound(g_tabMap): g_tabMap(i) = -1: Next i
    g_tabMap(BS_VECTOR) = BTAB_VECTOR
    g_tabMap(BS_PROGRAM) = BTAB_PROGRAM
    g_tabMap(BS_SPRITE) = BTAB_SPRITE
    g_tabMap(BS_IMAGE) = BTAB_IMAGE
        
    ' Hook scroll wheel.
    Call AttachMessage(Me, hwnd, WM_MOUSEWHEEL)
    Call AttachMessage(Me, hwnd, WM_MBUTTONDOWN)
End Sub
Private Sub Form_Resize() ':on error resume next
        
    Dim brdWidth As Integer, brdHeight As Integer
    
    'Available space.
    sstBoard.width = activeBoard.width - sstBoard.Left * 3
    sstBoard.Height = activeBoard.Height - sstBoard.Top * 6
    
    If sstBoard.Tab = BTAB_PROPERTIES Then
        picProperties.Left = (sstBoard.width - picProperties.width) / 2
        picProperties.Top = (sstBoard.Height + sstBoard.TabHeight - picProperties.Height) / 2
        If picProperties.Left < 120 Then picProperties.Left = 120
        If picProperties.Top < sstBoard.TabHeight + 120 Then picProperties.Top = sstBoard.TabHeight + 120
        
        'Do not resize picturebox if not visible, since this will cause it to
        'become visible on another tab.
        Exit Sub
    End If
   
    picBoard.width = sstBoard.width - vScroll.width
    picBoard.Height = sstBoard.Height - sstBoard.TabHeight - hScroll.Height
    picBoard.ScaleMode = vbPixels
    
    brdWidth = relWidth(m_ed)
    brdHeight = relHeight(m_ed)
       
    If picBoard.ScaleX(brdWidth, vbPixels, vbTwips) > picBoard.width Then
        picBoard.width = picBoard.width - (picBoard.width Mod picBoard.ScaleX(scrollUnitWidth(m_ed), vbPixels, vbTwips))
        hScroll.Visible = True
        hScroll.width = picBoard.width
        hScroll.max = brdWidth - picBoard.ScaleWidth
        hScroll.SmallChange = scrollUnitWidth(m_ed)
        hScroll.LargeChange = picBoard.ScaleWidth - scrollUnitWidth(m_ed)
    Else
        hScroll.Visible = False
        hScroll.max = 0
        picBoard.width = picBoard.ScaleX(brdWidth, vbPixels, vbTwips)
        m_ed.pCEd.topX = 0
    End If
         
    If picBoard.ScaleY(brdHeight, vbPixels, vbTwips) > picBoard.Height Then
        picBoard.Height = picBoard.Height - (picBoard.Height Mod picBoard.ScaleY(scrollUnitHeight(m_ed), vbPixels, vbTwips))
        vScroll.Visible = True
        vScroll.Height = picBoard.Height
        vScroll.max = brdHeight - picBoard.ScaleHeight
        vScroll.SmallChange = scrollUnitHeight(m_ed)
        vScroll.LargeChange = picBoard.ScaleHeight - scrollUnitHeight(m_ed)
    Else
        vScroll.Visible = False
        vScroll.max = 0
        picBoard.Height = picBoard.ScaleY(brdHeight, vbPixels, vbTwips)
        m_ed.pCEd.topY = 0
    End If
    
    picBoard.Left = (sstBoard.width - (picBoard.width + IIf(vScroll.Visible, vScroll.width, 0))) / 2
    picBoard.Top = (sstBoard.Height + sstBoard.TabHeight - (picBoard.Height + IIf(hScroll.Visible, hScroll.Height, 0))) / 2
    hScroll.Top = picBoard.Height + picBoard.Top
    vScroll.Left = picBoard.width + picBoard.Left
    vScroll.Top = picBoard.Top
    hScroll.Left = picBoard.Left
    
    Call drawAll
End Sub
Private Sub Form_Unload(Cancel As Integer) ': On Error Resume Next
    Call BRDFree(m_ed.pCBoard)
    Call BoardClear(m_ed.board(m_ed.undoIndex))
    Call hideAllTools
    tkMainForm.popButton(3).Visible = False         'Before Set m_sel = Nothing
    tkMainForm.pTools.Visible = False
    Set m_sel = Nothing
    'tbc

    ' Unhook scroll wheel.
    Call DetachMessage(Me, hwnd, WM_MBUTTONDOWN)
    Call DetachMessage(Me, hwnd, WM_MOUSEWHEEL)
End Sub

'========================================================================
'========================================================================
Private Sub hScroll_Change() ': On Error Resume Next
    ' exit if opening board
    'If bOpeningBoard Then Exit Sub
    hScroll.value = hScroll.value - (hScroll.value Mod scrollUnitWidth(m_ed))
    m_ed.pCEd.topX = hScroll.value
    Call drawAll
End Sub

'========================================================================
'========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next

    Call activeBoard.Show
    Call checkSave
    
    ' copy board to directory
    ' Call FileCopy(filename(1), projectPath & brdPath & antiPath)
    
    Call openBoard(file, m_ed, m_ed.board(m_ed.undoIndex))
    Call vectorize(m_ed)                          'tbd: For old boards only.
    
    'tbd: merge with openBoard?
    '.bounds information set in actkrt3
    m_ed.board(m_ed.undoIndex).bkgImage.file = bmpPath & m_ed.board(m_ed.undoIndex).brdBack   'tbd: remove brdback
    m_ed.board(m_ed.undoIndex).bkgImage.drawType = BI_PARALLAX                  'Default for background.
    
    Call resetEditor(m_ed)
    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, True)
    
    m_ed.boardName = RemovePath(file)
    activeBoard.Caption = "Board Editor (" & m_ed.boardName & ")"
    
    Call Form_Resize
End Sub
Public Sub saveFile() ':on error resume next

    ' if no filename exists, we've just created this board, so show dialog.
    If LenB(boardList(activeBoardIndex).boardName) = 0 Then
        Call saveFileAs
        Exit Sub
    End If

    'Check this isn't read-only.
    If (fileExists(projectPath & brdPath & boardList(activeBoardIndex).boardName)) Then
        If (GetAttr(projectPath & brdPath & boardList(activeBoardIndex).boardName) And vbReadOnly) Then
        
            Call MsgBox(boardList(activeBoardIndex).boardName & " is read-only, please choose a different filename", vbExclamation)
            Call saveFileAs

            Exit Sub
        End If
    End If

    boardList(activeBoardIndex).boardNeedUpdate = False
    Call saveBoard(projectPath & brdPath & boardList(activeBoardIndex).boardName, boardList(activeBoardIndex).theData)
    activeBoard.Caption = LoadStringLoc(802, "Board Editor") & " (" & boardList(activeBoardIndex).boardName & ")"

End Sub
Private Sub saveFileAs() ':on error resume next

    Dim dlg As FileDialogInfo

    dlg.strDefaultFolder = projectPath & brdPath
    dlg.strTitle = "Save Board As"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"

    ChDir (currentDir)
    If Not (SaveFileDialog(dlg, Me.hwnd, True)) Then Exit Sub
    ChDir (currentDir)

    ' if no filename entered, exit.
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub

    boardList(activeBoardIndex).boardName = dlg.strSelectedFileNoPath
    Call saveBoard(dlg.strSelectedFile, boardList(activeBoardIndex).theData)
    activeBoard.Caption = LoadStringLoc(802, "Board Editor") & " (" & dlg.strSelectedFileNoPath & ")"
    
    boardList(activeBoardIndex).boardNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath)
End Sub

Private Sub checkSave(): On Error Resume Next
    If m_ed.bNeedUpdate Then
        If MsgBox("Would you like to save your changes to the current board?", vbYesNo, "Save board") = vbYes Then
            Call saveFile
        End If
    End If
End Sub

'==========================================================================
' Get the high or low order word.
'==========================================================================
Private Function loWord(ByRef lng As Long) As Integer
   Call CopyMemory(loWord, ByVal VarPtr(lng), 2)
End Function
Private Function hiWord(ByRef lng As Long) As Integer
   Call CopyMemory(hiWord, ByVal (VarPtr(lng) + 2), 2)
End Function

'==========================================================================
' Type of subclassing used for the scroll wheel.
'==========================================================================
Private Property Get ISubclass_MsgResponse() As EMsgResponse
    ISubclass_MsgResponse = emrConsume
End Property
Private Property Let ISubclass_MsgResponse(ByVal rhs As EMsgResponse)
    ' Cannot be set.
End Property

'==========================================================================
' On mouse wheel scroll or click.
'==========================================================================
Private Function ISubclass_WindowProc(ByVal hwnd As Long, ByVal iMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    If (iMsg = WM_MOUSEWHEEL) Then
        Dim distance As Long
        distance = hiWord(wParam)
        If (m_mouseScrollDistance <> 0) Then
            If (Sgn(distance) <> Sgn(m_mouseScrollDistance)) Then
                ' Signs are not the same, so start the total distance from zero.
                m_mouseScrollDistance = 0
            End If
        End If
        m_mouseScrollDistance = m_mouseScrollDistance + distance
        If (Abs(m_mouseScrollDistance) >= WHEEL_DELTA) Then
            ' We've scrolled the delta distance

            If (loWord(wParam) And MK_CONTROL) Then
                ' Control is down: zoom.
                Dim pt As POINTAPI
                pt.x = loWord(lParam)
                pt.y = hiWord(lParam)
                Call zoom(Sgn(m_mouseScrollDistance), pt)
            Else
                ' Control is not down: scroll.

                Dim scroll As Object ' Cannot use more specific type because there isn't one.
                Set scroll = IIf(m_bScrollVertical, vScroll, hScroll)

                scroll.value = scroll.value + scroll.LargeChange * Sgn(m_mouseScrollDistance)
                IIf(m_bScrollVertical, m_ed.pCEd.topY, m_ed.pCEd.topX) = scroll.value
                Call drawAll
            End If

            ' Preserve any partial rotations of the wheel.
            m_mouseScrollDistance = (m_mouseScrollDistance Mod WHEEL_DELTA) * Sgn(m_mouseScrollDistance)
        End If
    ElseIf (iMsg = WM_MBUTTONDOWN) Then
        ' Toggle axis of scrolling.
        m_bScrollVertical = Not (m_bScrollVertical)
    End If
End Function

Private Sub mnuCopy_Click() ': On Error Resume Next
    tkMainForm.brdOptTool(BT_SELECT).value = True
    Call clipCopy(g_boardClipboard, m_sel, True)
End Sub
Private Sub mnuCut_Click(): On Error Resume Next
    Call setUndo
    Call clipCopy(g_boardClipboard, m_sel, True)
    Call clipCut(g_boardClipboard, True)
End Sub
Private Sub mnuPaste_Click(): On Error Resume Next
    'Start a move, retaining selection information.
    Call setUndo
    m_sel.xDrag = m_sel.x1
    m_sel.yDrag = m_sel.y1
    m_sel.status = SS_PASTING
End Sub
Private Sub mnuSelectAll_Click() ': On Error Resume Next
    If m_ed.optTool <> BT_SELECT Then Exit Sub
    Select Case m_ed.optSetting
        Case BS_TILE
            Call m_sel.assign(0, 0, absWidth(m_ed.board(m_ed.undoIndex).bSizeX, m_ed.board(m_ed.undoIndex).coordType), absHeight(m_ed.board(m_ed.undoIndex).bSizeY, m_ed.board(m_ed.undoIndex).coordType))
        Case BS_VECTOR, BS_PROGRAM
            Dim r As RECT
            If currentVector Is Nothing Then Exit Sub
            Call currentVector.getBounds(r.Left, r.Top, r.Right, r.Bottom)
            Call m_sel.assign(r.Left, r.Top, r.Right, r.Bottom)
    End Select
    Call m_sel.draw(Me, m_ed.pCEd)
End Sub
Private Sub mnuUndo_Click() ': On Error Resume Next
    m_ed.undoIndex = nextUndo
    Call toolbarRefresh
    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, True)
    Call drawAll
    mnuUndo.Enabled = m_ed.bUndoData(nextUndo)
    mnuRedo.Enabled = True
End Sub
Private Sub mnuRedo_Click() ': On Error Resume Next
    m_ed.undoIndex = nextRedo
    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, True)
    Call drawAll
    mnuUndo.Enabled = True
    mnuRedo.Enabled = m_ed.bUndoData(nextRedo)
End Sub
Private Function nextUndo() As Long: On Error Resume Next
    nextUndo = IIf(m_ed.undoIndex < 1, MAX_UNDO, m_ed.undoIndex - 1)
End Function
Private Function nextRedo() As Long: On Error Resume Next
    nextRedo = (m_ed.undoIndex + 1) Mod (MAX_UNDO + 1)
End Function
Public Sub setUndo() ': On Error Resume Next
    Dim id As Long
    id = nextRedo
    Call boardCopy(m_ed.board(m_ed.undoIndex), m_ed.board(id))
    m_ed.undoIndex = id
    m_ed.bUndoData(id) = True
    m_ed.bUndoData(nextRedo) = False            'Clear redo data.
    mnuUndo.Enabled = True
    mnuRedo.Enabled = False
End Sub

'========================================================================
'========================================================================
Private Sub picBoard_KeyDown(keyCode As Integer, Shift As Integer) ':on error resume next

    Dim curVector As CVector
    Set curVector = currentVector
    
    'Currently handling Ctrl+letter through menus.
    If Shift And (vbCtrlMask Or vbAltMask) Then Exit Sub
    
    Select Case keyCode
        Case vbKeyQ: tkMainForm.brdOptSetting(BS_GENERAL).value = True
        Case vbKeyW: tkMainForm.brdOptSetting(BS_ZOOM).value = True
        Case vbKeyE: tkMainForm.brdOptSetting(BS_TILE).value = True
        Case vbKeyR: tkMainForm.brdOptSetting(BS_VECTOR).value = True
        Case vbKeyT: tkMainForm.brdOptSetting(BS_PROGRAM).value = True
        Case vbKeyY: tkMainForm.brdOptSetting(BS_SPRITE).value = True
        Case vbKeyU: tkMainForm.brdOptSetting(BS_IMAGE).value = True
        Case vbKeyA: tkMainForm.brdOptTool(BT_DRAW).value = True
        Case vbKeyS: tkMainForm.brdOptTool(BT_SELECT).value = True
        Case vbKeyD: tkMainForm.brdOptTool(BT_FLOOD).value = True
        Case vbKeyF: tkMainForm.brdOptTool(BT_ERASE).value = True
        Case vbKeyG: tkMainForm.brdChkGrid.value = Not tkMainForm.brdChkGrid.value
        Case vbKeyH: tkMainForm.brdChkAutotile.value = Not tkMainForm.brdChkAutotile.value
        Case vbKeyN: tkMainForm.brdChkHideLayers.value = Not tkMainForm.brdChkHideLayers.value
        Case vbKeyM: tkMainForm.brdChkShowLayers.value = Not tkMainForm.brdChkShowLayers.value
    End Select

    Select Case m_ed.optSetting
        Case BS_VECTOR, BS_PROGRAM
            Select Case keyCode
                Case vbKeyDelete, vbKeyBack
                    Call vectorDeleteSelection(m_sel)
                Case vbKeyZ
                    Call vectorSubdivideSelection(m_sel)
                Case vbKeyX
                    Call vectorExtendSelection(m_sel)
                Case vbKeyEscape
                    If (m_ed.optTool = BT_DRAW And m_sel.status = SS_DRAWING) And (Not curVector Is Nothing) Then
                        Call curVector.closeVector(Shift, m_ed.currentLayer)
                        Call m_sel.clear(Me)
                        Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, m_ed.bShowVectorIndices, True)
                    End If
            End Select 'Key
            
            Call toolbarRefresh

        Case BS_TILE
            Select Case keyCode
                Case vbKeyDelete, vbKeyBack
                    'Create a local clipboard and cut to it.
                    Dim clip As TKBoardClipboard
                    Call setUndo
                    Call clipCopy(clip, m_sel, True)
                    Call clipCut(clip, True)
                Case vbKeyEscape
                    Call m_sel.clear(Me)
            End Select 'Key
            
        Case BS_IMAGE
            Select Case keyCode
                Case vbKeyDelete, vbKeyBack
                    Call imageDeleteCurrent(tkMainForm.bTools_ctlImage.getCombo.ListIndex)
            End Select
    End Select 'Setting
End Sub
Private Sub picBoard_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim pxCoord As POINTAPI, curVector As CVector
    pxCoord = screenToBoardPixel(x, y, m_ed)
    Set curVector = currentVector
    
    'Process tools common to all settings.
    Select Case m_ed.optTool
        Case BT_SELECT
            If Button <= vbLeftButton And m_ed.optSetting > BS_ZOOM Then
                'Making a selection.
                Select Case m_sel.status
                    Case SS_NONE, SS_FINISHED
                        If m_sel.containsPoint(pxCoord.x, pxCoord.y) And m_sel.status = SS_FINISHED Then
                            'Start to move selection.
                            m_sel.status = SS_MOVING
                            
                            Select Case m_ed.optSetting
                                Case BS_TILE
                                    Call setUndo
                                    pxCoord = snapToGrid(pxCoord)
                                    g_boardClipboard.origin.x = m_sel.x1        'Prepare a copy.
                                    g_boardClipboard.origin.y = m_sel.y1
                                    
                                Case BS_VECTOR, BS_PROGRAM
                                    'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                                    If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord)
                                    
                                    Call setUndo
                                    Set curVector = currentVector           'Update since setUndo increments vectors.
                                    
                                    'Determine selected points.
                                    If Not curVector Is Nothing Then Call curVector.setSelection(m_sel)
                                Case BS_SPRITE
                                    If (m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0 Then pxCoord = snapToGrid(pxCoord)
                            End Select
                            
                            m_sel.xDrag = pxCoord.x
                            m_sel.yDrag = pxCoord.y
                        Else
                            Dim img As TKBoardImage, index  As Long
                            Select Case m_ed.optSetting
                                Case BS_TILE, BS_VECTOR, BS_PROGRAM
                                    'Start new selection.
                                    'CBoardSlection stores board pixel coordinate.
                                    Call m_sel.restart(pxCoord.x, pxCoord.y)
                                Case BS_SPRITE
                                    'Start moving the selected sprite.
                                    If imageHitTest(pxCoord.x, pxCoord.y, index, img, m_ed.board(m_ed.undoIndex).spriteImages) Then
                                        Call toolbarChange(index, m_ed.optSetting)
                                        Call m_sel.assign(img.bounds.Left, img.bounds.Top, img.bounds.Right, img.bounds.Bottom)
                                    End If
                                Case BS_IMAGE
                                    If imageHitTest(pxCoord.x, pxCoord.y, index, img, m_ed.board(m_ed.undoIndex).Images) Then
                                        Call toolbarChange(index, m_ed.optSetting)
                                        Call m_sel.assign(img.bounds.Left, img.bounds.Top, img.bounds.Right, img.bounds.Bottom)
                                    End If
                            End Select
                        End If
                        
                    Case SS_DRAWING
                        m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                        Call m_sel.draw(Me, m_ed.pCEd)
                        
                    Case SS_MOVING, SS_PASTING
                        Select Case m_ed.optSetting
                            Case BS_TILE
                                pxCoord = snapToGrid(pxCoord)
                            Case BS_VECTOR, BS_PROGRAM, BS_IMAGE
                                'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                                If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord)
                            Case BS_SPRITE
                                If (m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0 Then pxCoord = snapToGrid(pxCoord)
                        End Select
                        
                        Dim dx As Long, dy As Long
                        dx = pxCoord.x - m_sel.xDrag
                        dy = pxCoord.y - m_sel.yDrag
                        m_sel.xDrag = pxCoord.x
                        m_sel.yDrag = pxCoord.y
                        
                        Select Case m_ed.optSetting
                            Case BS_TILE
                            Case BS_VECTOR, BS_PROGRAM
                                If Not curVector Is Nothing Then
                                    Call curVector.moveSelectionBy(dx, dy)
                                    Call drawBoard
                                End If
                        End Select
                        
                        Call m_sel.move(dx, dy)
                        Call m_sel.draw(Me, m_ed.pCEd)
    
                End Select
            Else
                Call m_sel.clear(Me)
            End If
            Exit Sub
            
        Case BT_IMG_TRANSP
            tkMainForm.bTools_ctlImage.transpcolor = picBoard.point(x, y)
            Exit Sub
    End Select
    
    Select Case m_ed.optSetting
        Case BS_GENERAL
            'Move the board by dragging. Use the selection.
            m_sel.xDrag = x:             m_sel.yDrag = y
            hScroll.Tag = hScroll.value: vScroll.Tag = vScroll.value
        Case BS_ZOOM
            Call zoom(IIf(Button = vbLeftButton, 1, -1), pxCoord)
        Case BS_TILE
            Call setUndo
            Call tileSettingMouseDown(Button, Shift, x, y)
        Case BS_VECTOR, BS_PROGRAM
            Call vectorSettingMouseDown(Button, Shift, x, y)
        Case BS_IMAGE
            Call setUndo
            Call imageCreate(m_ed.board(m_ed.undoIndex), pxCoord.x, pxCoord.y)
            Call drawAll
        Case BS_SPRITE
            Call setUndo
            Call spriteCreate(m_ed.board(m_ed.undoIndex), pxCoord.x, pxCoord.y)
            Call drawAll
    End Select
End Sub
Private Sub picBoard_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim pxCoord As POINTAPI, tileCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_ed)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
    tkMainForm.StatusBar1.Panels(3).Text = str(tileCoord.x) & ", " & str(tileCoord.y)
    
    If m_sel.status = SS_DRAWING Or m_sel.status = SS_MOVING Then
        'Scroll the board to expand selection.
        If x > picBoard.ScaleWidth - 8 And hScroll.value <> hScroll.max And hScroll.Visible Then hScroll.value = hScroll.value + hScroll.SmallChange
        If x < 8 And hScroll.value <> hScroll.min Then hScroll.value = hScroll.value - hScroll.SmallChange
        If y > picBoard.ScaleHeight - 8 And vScroll.value <> vScroll.max And vScroll.Visible Then vScroll.value = vScroll.value + vScroll.SmallChange
        If y < 8 And vScroll.value <> vScroll.min Then vScroll.value = vScroll.value - vScroll.SmallChange
    End If
      
    Select Case m_ed.optTool
        Case BT_SELECT, BT_IMG_TRANSP
            If Button <> 0 Or m_sel.status = SS_PASTING Then Call picBoard_MouseDown(Button, Shift, x, y)
            Exit Sub
    End Select
    
    Select Case m_ed.optSetting
        Case BS_GENERAL
            'Move the board by dragging.
            If Button <> 0 And (hScroll.Visible Or vScroll.Visible) Then
                Dim dx As Long, dy As Long, hx As Long, hy As Long, tX As Long, tY As Long
                dx = m_sel.xDrag - x:           dy = m_sel.yDrag - y
                hx = scrollUnitWidth(m_ed) / 2
                hy = scrollUnitHeight(m_ed) / 2
                tX = val(hScroll.Tag):          tY = val(vScroll.Tag)
                
                If dx > 0 Then
                    tX = IIf(dx + tX < hScroll.max, dx + tX, hScroll.max)
                Else
                    tX = IIf(dx + tX > hScroll.min, dx + tX, hScroll.min)
                End If
                'Round to nearest scroll unit.
                hScroll.value = tX - ((tX + hx) Mod (2 * hx)) + hx
                
                If dy > 0 Then
                    tY = IIf(dy + tY < vScroll.max, dy + tY, vScroll.max)
                Else
                    tY = IIf(dy + tY > vScroll.min, dy + tY, vScroll.min)
                End If
                vScroll.value = tY - ((tY + hy) Mod (2 * hy)) + hy
                
                m_sel.xDrag = x:                m_sel.yDrag = y
                hScroll.Tag = tX:               vScroll.Tag = tY
            End If
            
        Case BS_TILE
            If Button <> 0 Then Call tileSettingMouseDown(Button, Shift, x, y)
            
        Case BS_VECTOR, BS_PROGRAM
            If (m_ed.optTool = BT_DRAW And m_sel.status = SS_DRAWING) Then
                
                'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord)

                m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                Call m_sel.drawLine(Me, m_ed.pCEd)
            End If
    End Select
End Sub
Private Sub picBoard_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single) ':on error resume next
    
    Dim pxCoord As POINTAPI, i As Long
    pxCoord = screenToBoardPixel(x, y, m_ed)
    
    If Button <> vbLeftButton Then Exit Sub
            
    Select Case m_ed.optTool
        Case BT_SELECT
            Select Case m_ed.optSetting
                Case BS_TILE
                    Select Case m_sel.status
                        Case SS_DRAWING
                            Call m_sel.expandToGrid(m_ed.board(m_ed.undoIndex).coordType, m_ed.board(m_ed.undoIndex).bSizeX)
                        Case SS_MOVING, SS_PASTING
                            If m_sel.status = SS_MOVING Then
                                'Perform a cut/copy-paste when dragging tiles.
                                Call clipCopy(g_boardClipboard, m_sel, False)
                                If Shift = 0 Then Call clipCut(g_boardClipboard, False)
                            End If
                            m_sel.status = SS_FINISHED
                            Call clipPaste(g_boardClipboard, m_sel)
                    End Select
                Case BS_VECTOR, BS_PROGRAM
                    'Click only: select the nearest vector.
                    If m_sel.isEmpty Then
                        Call vectorSetCurrent(m_sel)
                        Call m_sel.clear(Me)
                        Call toolbarRefresh
                        Exit Sub
                    Else
                        If m_sel.status = SS_PASTING Then
                            m_sel.status = SS_FINISHED
                            Call clipPaste(g_boardClipboard, m_sel)
                        End If
                    End If
                    Call toolbarRefresh
                Case BS_SPRITE, BS_IMAGE
                    'Finish the move.
                    i = IIf(m_ed.optSetting = BS_SPRITE, BTAB_SPRITE, BTAB_IMAGE)
                    Select Case m_sel.status
                        Case SS_MOVING
                            Call m_ctls(i).moveCurrentTo(m_sel)
                        Case SS_PASTING
                            m_sel.status = SS_FINISHED
                            Call clipPaste(g_boardClipboard, m_sel)
                    End Select
                    Call m_sel.clear(Me)
                    Exit Sub
            End Select
            
            Call m_sel.reorientate
            m_sel.status = SS_FINISHED
            Call m_sel.draw(Me, m_ed.pCEd)
            
        Case BT_IMG_TRANSP
            'Reset the tool.
            tkMainForm.brdOptTool(BT_SELECT).value = True
            Call mdiOptTool(BT_SELECT)
            tkMainForm.bTools_ctlImage.getChkTransp.value = 0
            Call imageApply(tkMainForm.bTools_ctlImage.getCombo.ListIndex)
            Call drawAll
    End Select
         
End Sub
Private Function snapToGrid(ByRef pxCoord As POINTAPI, Optional ByVal bAddBasePoint As Boolean = False) As POINTAPI: On Error Resume Next
    Dim pt As POINTAPI: pt = pxCoord
    pt = modBoard.boardPixelToTile(pt.x, pt.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
    snapToGrid = modBoard.tileToBoardPixel(pt.x, pt.y, m_ed.board(m_ed.undoIndex).coordType, bAddBasePoint, m_ed.board(m_ed.undoIndex).bSizeX)
End Function

'========================================================================
' x,y as tileCoord
'========================================================================
Private Sub placeTile(file As String, x As Long, y As Long) ': On Error Resume Next

    'Get board pixel _drawing_ coordinate from tile.
    Dim brdPt As POINTAPI, scrPt As POINTAPI
    brdPt = modBoard.tileToBoardPixel(x, y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX, True)
    scrPt = boardPixelToScreen(brdPt.x, brdPt.y, m_ed)
    
    'Check if this tile is already inserted.
    If BoardGetTile(x, y, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)) = file Then Exit Sub
    
    'Insert the selected tile into the board array.
    Call BoardSetTile( _
        x, y, _
        m_ed.currentLayer, _
        file, _
        m_ed.board(m_ed.undoIndex) _
    )
    ' set ambient details
    m_ed.board(m_ed.undoIndex).ambientRed(x, y, m_ed.currentLayer) = m_ed.ambientR
    m_ed.board(m_ed.undoIndex).ambientGreen(x, y, m_ed.currentLayer) = m_ed.ambientG
    m_ed.board(m_ed.undoIndex).ambientBlue(x, y, m_ed.currentLayer) = m_ed.ambientB
    
    ' set tiletype details (tbd:?)
    m_ed.board(m_ed.undoIndex).tiletype(x, y, m_ed.currentLayer) = m_ed.currentTileType
    
    'Render the tile to actkrt's layer canvas.
    Call BRDRenderTileToBoard( _
        m_ed.pCBoard, _
        VarPtr(m_ed.board(m_ed.undoIndex)), _
        picBoard.hdc, _
        x, y, _
        m_ed.currentLayer _
    )
    'Redraw all board layers at this position.
    Call BRDDraw( _
        VarPtr(m_ed), _
        VarPtr(m_ed.board(m_ed.undoIndex)), _
        picBoard.hdc, _
        scrPt.x, scrPt.y, _
        brdPt.x, brdPt.y, _
        tileWidth(m_ed), _
        tileHeight(m_ed), _
        m_ed.pCEd.zoom _
    )
    picBoard.Refresh
End Sub

'========================================================================
'========================================================================
Private Sub tileSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next

    Dim tileCoord As POINTAPI, pxCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_ed)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)

    If tileCoord.x > m_ed.effectiveBoardX Or tileCoord.y > m_ed.effectiveBoardY Then Exit Sub

    Select Case m_ed.optTool
        Case BT_DRAW
            If LenB(m_ed.selectedTile) = 0 Then Exit Sub
            
            m_ed.bLayerOccupied(0) = True
            m_ed.bLayerOccupied(m_ed.currentLayer) = True
                
            If (commonRoutines.extention(tilePath & m_ed.selectedTile) <> "TBM") Then
                
                Dim eo As Long
                eo = 0 'TBD: isometric even-odd
                If m_ed.bAutotiler Then
                    Call autoTilerPutTile( _
                        m_ed.selectedTile, _
                        tileCoord.x, tileCoord.y, _
                        m_ed.board(m_ed.undoIndex).coordType, eo, _
                        ((Shift And vbShiftMask) = vbShiftMask) _
                    )
                Else
                    Call placeTile(m_ed.selectedTile, tileCoord.x, tileCoord.y)
                End If
            Else
                'Tile bitmap.
                'TBD: test this; do isometrics. Possible overdraw at edges of picBoard.
                Dim i As Long, j As Long, width As Long, Height As Long, tbm As TKTileBitmap
                Call OpenTileBitmap(tilePath & m_ed.selectedTile, tbm)
                width = UBound(tbm.tiles, 1)
                Height = UBound(tbm.tiles, 2)
                
                'Lose any tiles that go off the board.
                If (m_ed.board(m_ed.undoIndex).bSizeX - 1) < width Then width = (m_ed.board(m_ed.undoIndex).bSizeX - 1)
                If (m_ed.board(m_ed.undoIndex).bSizeY - 1) < Height Then Height = (m_ed.board(m_ed.undoIndex).bSizeY - 1)
                                   
                For i = 0 To width
                    For j = 0 To Height
                        Call placeTile(tbm.tiles(i, j), tileCoord.x + i, tileCoord.y + j)
                    Next j
                Next i
            End If ' .selectedTile <> "TBM"
            
        Case BT_SELECT
            ' Code is common to settings.
    
        Case BT_FLOOD
            If LenB(m_ed.selectedTile) = 0 Then Exit Sub
            If m_ed.bAutotiler Then
                'fill disabled in autotiler mode (unless someone wants to code it)
                MsgBox "The Fill tool is disabled in AutoTiler mode!"
            Else
                m_ed.bLayerOccupied(0) = True
                m_ed.bLayerOccupied(m_ed.currentLayer) = True
            
                'Use gdi version as recursive routine crashes on large boards (3.0.6)
                If GetSetting("RPGToolkit3", "Settings", "Recursive Flooding", "0") = "1" Then
                    'User has enabled recursive flooding - when gdi doesn't work.
                    Call floodRecursive(tileCoord.x, tileCoord.y, m_ed.currentLayer, m_ed.selectedTile)
                Else
                    'Use gdi if no setting exists (default).
                    Call floodGdi(tileCoord.x, tileCoord.y, m_ed.currentLayer, m_ed.selectedTile)
                End If
            End If
            If (m_ed.bRevertToDraw) Then
                m_ed.optTool = BT_DRAW
                tkMainForm.brdOptTool(m_ed.optTool).value = True
            End If
            
            Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
            Call drawBoard
            
        Case BT_ERASE
            eo = 0 'TBD: isometric even-odd
            If m_ed.bAutotiler Then
                Call autoTilerPutTile("", tileCoord.x, tileCoord.y, m_ed.board(m_ed.undoIndex).coordType, eo, ((Shift And vbShiftMask) = vbShiftMask))
            Else
                Call placeTile("", tileCoord.x, tileCoord.y)
            End If
    
    End Select
End Sub

Private Sub sstBoard_Click(PreviousTab As Integer) ': On Error Resume Next
    If sstBoard.Tab = BTAB_BOARD Then
        Call Form_Resize
    End If
End Sub

'========================================================================
'========================================================================
Private Sub vScroll_Change() ': On Error Resume Next
    ' exit if opening board
    'If bOpeningBoard Then Exit Sub
    vScroll.value = vScroll.value - (vScroll.value Mod scrollUnitHeight(m_ed))
    m_ed.pCEd.topY = vScroll.value
    Call drawAll
End Sub

'========================================================================
'========================================================================
Private Sub zoom(ByVal direction As Integer, ByRef pxCoord As POINTAPI) ': On Error Resume Next

    'Record the old zoom.
    Dim oldZoom As Double, h As Long, v As Long
    oldZoom = m_ed.pCEd.zoom

    If direction > 0 Then
        m_ed.pCEd.zoom = m_ed.pCEd.zoom + IIf(m_ed.pCEd.zoom >= 1, 0.5, 0.25)
        If m_ed.pCEd.zoom > 2 Then m_ed.pCEd.zoom = 2: Exit Sub
    Else
        m_ed.pCEd.zoom = m_ed.pCEd.zoom - IIf(m_ed.pCEd.zoom > 1, 0.5, 0.25)
        If m_ed.pCEd.zoom < 0.25 Then m_ed.pCEd.zoom = 0.25: Exit Sub
    End If
        
    hScroll.SmallChange = modBoard.scrollUnitWidth(m_ed)
    vScroll.SmallChange = modBoard.scrollUnitHeight(m_ed)
    
    'Scale topX,Y via true values using oldZoom.
    m_ed.pCEd.topX = (m_ed.pCEd.topX / oldZoom) * m_ed.pCEd.zoom
    m_ed.pCEd.topY = (m_ed.pCEd.topY / oldZoom) * m_ed.pCEd.zoom
    Call Form_Resize
    
    'Centre around the given pixel coordinate.
    pxCoord = snapToGrid(pxCoord, False)
    h = pxCoord.x * m_ed.pCEd.zoom + scrollUnitWidth(m_ed) - picBoard.ScaleWidth / 2
    v = pxCoord.y * m_ed.pCEd.zoom + scrollUnitHeight(m_ed) - picBoard.ScaleHeight / 2
    If h < 0 Then h = 0
    If h > hScroll.max Then h = hScroll.max
    If v < 0 Then v = 0
    If v > vScroll.max Then v = vScroll.max
    hScroll.value = h
    vScroll.value = v
    
    'Display the zoom level.
    tkMainForm.StatusBar1.Panels(4).Text = "Zoom: " & str(m_ed.pCEd.zoom * 100) & "%"

End Sub

'========================================================================
'========================================================================
Private Sub drawBoard(Optional ByVal bRefresh As Boolean = True) ': On Error Resume Next
    picBoard.AutoRedraw = True
    Call BRDDraw( _
        VarPtr(m_ed), _
        VarPtr(m_ed.board(m_ed.undoIndex)), _
        picBoard.hdc, _
        0, 0, _
        screenToBoardPixel(0, 0, m_ed).x, _
        screenToBoardPixel(0, 0, m_ed).y, _
        CLng(picBoard.ScaleWidth), _
        CLng(picBoard.ScaleHeight), _
        m_ed.pCEd.zoom _
    )
    
    If bRefresh Then
        Call vectorDrawAll
        Call gridDraw
        picBoard.Refresh
    End If
End Sub

'========================================================================
'========================================================================
Public Sub mdiChkAutotile(ByVal value As Integer) ':on error resume next
    m_ed.bAutotiler = (value <> 0)
End Sub
Public Sub mdiOptSetting(ByVal index As Integer) ': On Error Resume Next
    m_ed.optSetting = index
    If Not (m_sel Is Nothing) Then Call m_sel.clear(Me)
    
    'Switch to BT_DRAW for general/zoom.
    If m_ed.optSetting <= BS_ZOOM Then tkMainForm.brdOptTool(BT_DRAW).value = True
    Call toolsRefresh
    
    'Switch the object toolbar pane.
    If g_tabMap(index) <> -1 Then tkMainForm.bTools_Tabs.Tab = g_tabMap(index)
    Call toolbarRefresh
    Call drawBoard
End Sub
Public Sub mdiOptTool(ByVal index As Integer) ': On Error Resume Next
    m_ed.optTool = index
    If (index <> BT_SELECT) And Not (m_sel Is Nothing) Then Call m_sel.clear(Me)
End Sub
Public Sub mdiChkGrid(ByVal value As Integer) ': On Error Resume Next
    m_ed.bGrid = value
    Call drawBoard
End Sub
Public Sub mdiChkHideLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    If value Then
        For i = 1 To m_ed.board(m_ed.undoIndex).bSizeL
            If i <> m_ed.currentLayer Then m_ed.bLayerVisible(i) = False
        Next i
        tkMainForm.brdChkShowLayers.value = 0
        m_ed.bShowAllLayers = False
        m_ed.bHideAllLayers = True
    Else
        'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiChkShowLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    If value Then
        For i = 1 To m_ed.board(m_ed.undoIndex).bSizeL
            m_ed.bLayerVisible(i) = True
        Next i
        tkMainForm.brdChkHideLayers.value = 0
        m_ed.bHideAllLayers = False
        m_ed.bShowAllLayers = True
   Else
         'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiCmbCurrentLayer(ByVal layer As Long) ':on error resume next
    m_ed.currentLayer = layer
End Sub
Public Sub mdiCmbVisibleLayers() ':on error resume next
    'Invert the selected layer.
    Dim Text As String, i As Integer, layer As String
    With tkMainForm.brdCmbVisibleLayers
        If (.ListIndex >= 0) Then
            Text = .list(.ListIndex)
            layer = Right$(Text, 1)
            i = IIf(.ListIndex > 0, CInt(val(layer)), 0)
            If (Left$(Text, 1) = "*" And i <> m_ed.currentLayer) Then
                'Do not disable current layer.
                .list(.ListIndex) = layer
                m_ed.bLayerVisible(i) = False
            Else
                .list(.ListIndex) = "* " & layer
                m_ed.bLayerVisible(i) = True
            End If
        End If
        .ListIndex = -1
    End With
    Call drawBoard
End Sub
Public Sub mdiCmdUndo(): On Error Resume Next
    Call mnuUndo_Click
End Sub

'=========================================================================
'=========================================================================
Private Sub setVisibleLayersByCombo() ':on error resume next
    Dim i As Integer, layer As Integer, Text As String
    For i = 1 To tkMainForm.brdCmbVisibleLayers.ListCount
        'Zeroth list entry is the background.
        Text = tkMainForm.brdCmbVisibleLayers.list(i)
        layer = CInt(val(Right$(Text, 1)))
        'm_ed.bLayerVisible(layer) = (Left$(Text, 1) = "*")
    Next i
End Sub

'=========================================================================
'=========================================================================
Private Sub resetLayerCombos() ':on error resume next
    tkMainForm.brdCmbCurrentLayer.clear
    tkMainForm.brdCmbVisibleLayers.clear
    Call tkMainForm.brdCmbVisibleLayers.AddItem("* B", 0)
    Dim i As Integer, Text As String
    For i = 1 To m_ed.board(m_ed.undoIndex).bSizeL
        Call tkMainForm.brdCmbVisibleLayers.AddItem(IIf(m_ed.bLayerVisible(i), "* " & i, i))
        Call tkMainForm.brdCmbCurrentLayer.AddItem(i)
    Next i
    'Combo box is zero-indexed.
    tkMainForm.brdCmbCurrentLayer.ListIndex = m_ed.currentLayer - 1
    Call mdiChkShowLayers(Abs(m_ed.bHideAllLayers), False)
    Call mdiChkShowLayers(Abs(m_ed.bShowAllLayers), False)
End Sub

'========================================================================
' Board AutoTiler functions - Added by Shao, 09/24/2004
'========================================================================
'returns the index of an autotst, or -1 if invalid
'if its not presently an autotst, make it one now
'========================================================================
Private Function autoTileset(ByVal tileset As String, Optional ByVal allowAdd As Boolean = True) As Long
    On Error Resume Next
    Dim i As Long, ub As Long ', sGrpCode As String

    ub = UBound(autoTilerSets)

    autoTileset = -1

    If UCase(Left(tileset, 10)) <> "AUTOTILES_" Then Exit Function
    
    'insert check for proper tile count here

    For i = 0 To ub
        If autoTilerSets(i) = tileset Then
            'if the autotileset is recognized, return its index
            autoTileset = i
            Exit Function
        End If
    Next i

    'add as autotileset
    If (allowAdd) And (autoTileset = -1) Then
        'known issue: first element is skipped, doesn't seem to be a big problem
        autoTileset = ub + 1
        ReDim Preserve autoTilerSets(autoTileset)
        autoTilerSets(autoTileset) = tileset
    End If
End Function

'========================================================================
' Autotiler: alters surrounding tiles to form contiguous blocks
'========================================================================
Private Sub autoTilerPutTile(ByVal tst As String, ByVal tileX As Long, ByVal tileY As Long, Optional ByVal coordType As Long, Optional ByVal eo As Boolean = False, Optional ByVal ignoreOthers As Boolean = False): On Error Resume Next
    Dim ix As Long, iy As Long, morphTileIndex As Byte, currentTileset As String, currentAutotileset As Long, thisAutoTileset As Long
    Dim brdWidth As Long, brdHeight As Long, startY As Long, endY As Long, startX As Long, endX As Long

    currentTileset = tilesetFilename(tst)
     
    If autoTileset(currentTileset, True) = -1 Then
        'Not an autotileset! set it down to close off surrounding autotiles
        Call placeTile(tst, tileX, tileY)
    Else
        'Valid autotileset! set down tile 51 (arbitrary) to link to surrounding autotiles
        Call placeTile(currentTileset & CStr(51), tileX, tileY)
    End If
    
    brdWidth = m_ed.effectiveBoardX
    brdHeight = m_ed.effectiveBoardY
    
    currentAutotileset = autoTileset(tilesetFilename(BoardGetTile(tileX, tileY, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
    
    If coordType = ISO_STACKED Then
        'Iso board [ISO_STACKED only]
        'Loop through each surrounding tile to check if it should be morphed
        'Known issue: this loop has a few unneeded iterations
        
        startY = tileY - 2: If startY < 1 Then startY = 1
        endY = tileY + 2: If endY > brdHeight Then endY = brdHeight
        
        startX = tileX - 1: If startX < 1 Then startX = 1
        endX = tileX + 1: If endX > brdWidth Then endX = brdWidth
        
        For iy = startY To endY
            For ix = startX To endX
                thisAutoTileset = autoTileset(tilesetFilename(BoardGetTile(ix, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
                
                'If shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'The 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'Check if the tile should link to the cardinal directions
                    If iy Mod 2 = 0 Then
                        'Even row
                        If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    Else
                        'Odd row
                        If (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    End If
                    
                    'Check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (iy > 2) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 2, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (iy < brdHeight - 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 2, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    If (ix < brdWidth) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                
                    'Draw and set the new tile
                    Call placeTile(autoTilerSets(thisAutoTileset) & CStr(tileMorphs(morphTileIndex)), ix, iy)
                End If
            Next ix
        Next iy
    
    Else
        '2d board/ ISO_ROTATED
        'Loop through each surrounding tile to check if it should be morphed
        
        startY = tileY - 1: If startY < 1 Then startY = 1
        endY = tileY + 1: If endY > brdHeight Then endY = brdHeight
        
        startX = tileX - 1: If startX < 1 Then startX = 1
        endX = tileX + 1: If endX > brdWidth Then endX = brdWidth
        
        For iy = startY To endY
            For ix = startX To endX
                thisAutoTileset = autoTileset(tilesetFilename(BoardGetTile(ix, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
                
                'If shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'The 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'Check if the tile should link to the cardinal directions
                    If (ix > 1) And autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_W
                    If (iy > 1) And autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_N
                    If (iy < brdHeight) And autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_S
                    If (ix < brdWidth) And autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_E
                     
                    'Check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                    If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    
                    'Draw and set the new tile
                    Call placeTile(autoTilerSets(thisAutoTileset) & CStr(tileMorphs(morphTileIndex)), ix, iy)
                End If
            Next ix
        Next iy
    End If
    
    Call picBoard.Refresh
End Sub

'==============================================================================
' Fill board with selected tile
' Optional from 3.0.6: crashes on large boards (>~ 100 x 100) - use gdi instead!
' Menu options in tile / board editor
'==============================================================================
Private Sub floodRecursive(ByVal x As Long, ByVal y As Long, ByVal l As Long, ByVal tileFile As String, Optional ByVal lastX As Long = -1, Optional ByVal lastY As Long = -1): On Error Resume Next
    
    Dim replaceTile As Long, newTile As Long
    replaceTile = m_ed.board(m_ed.undoIndex).board(x, y, l)
    newTile = BoardTileInLUT(tileFile, m_ed.board(m_ed.undoIndex))
    
    ' check if old and new tile are the same.
    ' also compare rgb ambient levels, in case we're flooding a different shade.
    If replaceTile = newTile _
        And m_ed.board(m_ed.undoIndex).ambientRed(x, y, l) = m_ed.ambientR _
        And m_ed.board(m_ed.undoIndex).ambientGreen(x, y, l) = m_ed.ambientG _
        And m_ed.board(m_ed.undoIndex).ambientBlue(x, y, l) = m_ed.ambientB _
        Then Exit Sub
    
    ' enter the tile data of the copying tile.
    m_ed.board(m_ed.undoIndex).board(x, y, l) = newTile
    m_ed.board(m_ed.undoIndex).tiletype(x, y, l) = m_ed.currentTileType
    m_ed.board(m_ed.undoIndex).ambientRed(x, y, l) = m_ed.ambientR
    m_ed.board(m_ed.undoIndex).ambientGreen(x, y, l) = m_ed.ambientG
    m_ed.board(m_ed.undoIndex).ambientBlue(x, y, l) = m_ed.ambientB
    
    Dim sizex As Long, sizey As Long, x2 As Long, y2 As Long
    sizex = m_ed.effectiveBoardX
    sizey = m_ed.effectiveBoardY
    
    'new x and y position
    x2 = x + 1: y2 = y
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        ' if old tile is the same as replaced tile
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call floodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y - 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call floodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x - 1: y2 = y
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call floodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y + 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call floodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
End Sub

'========================================================================
' Fill board with selected tile - using gdi (added for 3.0.6)
'========================================================================
Private Sub floodGdi(ByVal xLoc As Long, ByVal yLoc As Long, ByVal layer As Long, ByVal tileFilename As String) ': On Error Resume Next

    Const MAGIC_NUMBER = 32768
                
    With m_ed.board(m_ed.undoIndex)
    
        Dim curIdx As Long, newIdx As Long
        'The tile we clicked to flood and the tile we want to flood it with.
        curIdx = .board(xLoc, yLoc, layer)
        newIdx = BoardTileInLUT(tileFilename, m_ed.board(m_ed.undoIndex))
        
        If curIdx = newIdx Then
            'We're flooding the same tile, but does it have the same attributes?
            If .ambientRed(xLoc, yLoc, layer) = m_ed.ambientR And _
                .ambientGreen(xLoc, yLoc, layer) = m_ed.ambientG And _
                .ambientBlue(xLoc, yLoc, layer) = m_ed.ambientB And _
                .tiletype(xLoc, yLoc, layer) = m_ed.currentTileType Then
                    Exit Sub
            Else
                'Give the new tile a different "colour" so these tiles get flooded.
                'The magic number... there aren't going to be this many different tiles on a
                'board so this is safe.
                newIdx = MAGIC_NUMBER
            End If
        End If
        
        'Draw the board onto a canvas.
        'We use a different "colour" for each tile, by its LUT entry.
        
        Dim cnv As Long, width As Long, Height As Long
        width = m_ed.effectiveBoardX
        Height = m_ed.effectiveBoardY
        cnv = createCanvas(width + 1, Height + 1)
        
        Dim x As Long, y As Long
        For x = 1 To width
            For y = 1 To Height
                'Set a pixel per tile, an empty tile is represented as 0 (black).
                Call canvasSetPixel(cnv, x, y, .board(x, y, layer))
            Next y
        Next x
        
        'Perform the flood...
        
        Dim hdc As Long, brush As Long
        hdc = canvasOpenHDC(cnv)                        'Open the canvas device context.
        brush = CreateSolidBrush(newIdx)                'Create a brush.
        
        Call SelectObject(hdc, brush)                   'Assign the brush to the device context.
        Call ExtFloodFill(hdc, xLoc, yLoc, curIdx, 1)   'Process the flood fill on the device context.
        
        Call DeleteObject(brush)                        'Destroy the brush.
        Call canvasCloseHDC(cnv, hdc)                   'Close the device context.
            
        For x = 1 To width
            For y = 1 To Height
                'Copy the flooded image back to the board.
                
                If .board(x, y, layer) <> canvasGetPixel(cnv, x, y) Then
                    'This tile has been flooded, copy attributes across.
                    .board(x, y, layer) = canvasGetPixel(cnv, x, y)
                    
                    If newIdx = MAGIC_NUMBER Then
                        'The magic number - this was the same tile, so change it back.
                        .board(x, y, layer) = curIdx
                    End If
                    
                    'Set attributes.
                    .tiletype(x, y, layer) = m_ed.currentTileType
                    .ambientRed(x, y, layer) = m_ed.ambientR
                    .ambientGreen(x, y, layer) = m_ed.ambientG
                    .ambientBlue(x, y, layer) = m_ed.ambientB
                    
                End If
            Next y
        Next x
        
        Call destroyCanvas(cnv)                         'Destroy the canvas.
        
    End With
End Sub

'========================================================================
'========================================================================
Private Sub gridDraw() ': On Error Resume Next
    
    Dim color As Long, offsetY As Long, x As Long, y As Long, oldMode As Long, intHeight As Long
    color = m_ed.gridColor
    
    oldMode = picBoard.DrawMode
    picBoard.DrawMode = vbInvert
        
    If m_ed.bGrid = True Then
        If isIsometric(m_ed.board(m_ed.undoIndex).coordType) Then
            offsetY = IIf((m_ed.pCEd.topY Mod tileHeight(m_ed) = 0) = (m_ed.pCEd.topX Mod tileWidth(m_ed) = 0), 0, 16 * m_ed.pCEd.zoom)
            
            ' Top right to bottom left.
            Do While y < picBoard.ScaleWidth / 2 + picBoard.ScaleHeight
                picBoard.Line (0, y + offsetY)-(x + offsetY * 2, 0), color
                x = x + tileWidth(m_ed): y = y + tileHeight(m_ed)
            Loop

            ' Top left to bottom right.
            x = 0
            intHeight = picBoard.ScaleHeight + (picBoard.ScaleHeight Mod tileHeight(m_ed))
            y = intHeight
            Do While y > -picBoard.ScaleWidth / 2
                picBoard.Line (0, y + offsetY)-(x, intHeight + offsetY), color
                x = x + tileWidth(m_ed):  y = y - tileHeight(m_ed)
            Loop
        Else
            Do While x < picBoard.ScaleWidth
                picBoard.Line (x, 0)-(x, picBoard.ScaleHeight), color
                x = x + tileWidth(m_ed)
            Loop
            Do While y < picBoard.ScaleHeight
                picBoard.Line (0, y)-(picBoard.ScaleWidth, y), color
                y = y + tileHeight(m_ed)
            Loop
        End If 'isIsometric
    End If 'bGrid
    
    picBoard.DrawMode = oldMode
End Sub

'=========================================================================
'=========================================================================
Public Sub drawAll() ':on error resume next
    Call drawBoard
    
    'Update line controls.
    If m_ed.optTool = BT_SELECT Then Call m_sel.draw(Me, m_ed.pCEd)
End Sub

'========================================================================
'========================================================================
Private Sub vectorSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim tileCoord As POINTAPI, pxCoord As POINTAPI, curVector As CVector
    pxCoord = screenToBoardPixel(x, y, m_ed)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
    Set curVector = currentVector

    Select Case m_ed.optTool
        Case BT_DRAW
            If Button = vbLeftButton Then
                If m_sel.status <> SS_DRAWING Then
                    'Start a new vector.
                    Call setUndo
                    Set curVector = vectorCreate(m_ed.optSetting, m_ed.board(m_ed.undoIndex), m_ed.currentLayer)
                    Call drawBoard
                Else
                    'Close the last point.
                End If
                        
                'Start new point.
                
                'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord)
                
                'CBoardSlection stores board pixel coordinate.
                Call m_sel.restart(pxCoord.x, pxCoord.y)
                
                Call curVector.addPoint(pxCoord.x, pxCoord.y)
                Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, m_ed.bShowVectorIndices, True)
            Else
                'Finish the vector.
                Call curVector.closeVector(Shift, m_ed.currentLayer)
                Call m_sel.clear(Me)
                Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, m_ed.bShowVectorIndices, True)
                Call toolbarRefresh
            End If
    End Select

End Sub
Private Sub vectorBuildCurrentSet() ':on error resume next
    Dim i As Long
    'Note to self: Don't really need this - only for vectorSetCurrent
    ReDim m_ed.currentVectorSet(0)
    Select Case m_ed.optSetting
        Case BS_VECTOR
            For i = 0 To UBound(m_ed.board(m_ed.undoIndex).vectors)
                ReDim Preserve m_ed.currentVectorSet(i)
                Set m_ed.currentVectorSet(i) = m_ed.board(m_ed.undoIndex).vectors(i)
            Next i
        Case BS_PROGRAM
            For i = 0 To UBound(m_ed.board(m_ed.undoIndex).prgs)
                ReDim Preserve m_ed.currentVectorSet(i)
                If m_ed.board(m_ed.undoIndex).prgs(i) Is Nothing Then
                    Set m_ed.currentVectorSet(i) = Nothing
                Else
                    Set m_ed.currentVectorSet(i) = m_ed.board(m_ed.undoIndex).prgs(i).vBase
                End If
            Next i
    End Select
End Sub
Private Function currentVector() As CVector ': On Error Resume Next
    Dim i As Long
    Set currentVector = Nothing
    Select Case m_ed.optSetting
        Case BS_VECTOR
            i = m_ed.currentObject(BTAB_VECTOR)
            If i >= 0 And i <= UBound(m_ed.board(m_ed.undoIndex).vectors) Then
                If Not m_ed.board(m_ed.undoIndex).vectors(i) Is Nothing Then Set currentVector = m_ed.board(m_ed.undoIndex).vectors(i)
            End If
        Case BS_PROGRAM
            i = m_ed.currentObject(BTAB_PROGRAM)
            If i >= 0 And i <= UBound(m_ed.board(m_ed.undoIndex).prgs) Then
                If Not m_ed.board(m_ed.undoIndex).prgs(i) Is Nothing Then Set currentVector = m_ed.board(m_ed.undoIndex).prgs(i).vBase
            End If
    End Select
End Function
Private Sub vectorDrawAll() ': On Error Resume Next
    Dim i As Long, p1 As POINTAPI, p2 As POINTAPI
    With m_ed.board(m_ed.undoIndex)
        'Vectors
        If m_ed.bShowVectors Or m_ed.optSetting = BS_VECTOR Then
            For i = 0 To UBound(.vectors)
                If Not (.vectors(i) Is Nothing) Then
                    If .vectors(i).layer <= .bSizeL And m_ed.bLayerVisible(.vectors(i).layer) And (.vectors(i).tiletype <> TT_NULL) Then _
                        Call .vectors(i).draw(picBoard, m_ed.pCEd, m_ed.vectorColor(.vectors(i).tiletype), m_ed.bShowVectorIndices)
                End If
            Next i
        End If
        'Programs
        If m_ed.bShowPrograms Or m_ed.optSetting = BS_PROGRAM Then
            For i = 0 To UBound(.prgs)
                If Not (.prgs(i) Is Nothing) Then
                    If m_ed.bLayerVisible(.prgs(i).vBase.layer) Then _
                        Call .prgs(i).draw(picBoard, m_ed.pCEd, m_ed.programColor, m_ed.bShowVectorIndices)
                    End If
            Next i
        End If
    End With
    
    'Selected vector
    If Not currentVector Is Nothing Then Call currentVector.draw(picBoard, m_ed.pCEd, vectorGetColor, m_ed.bShowVectorIndices, True)
End Sub
Public Sub vectorDeleteCurrent(ByVal setting As eBrdSetting) ': on error resume next
    Dim i As Long
    Select Case setting
        Case BS_VECTOR
            i = m_ed.currentObject(BTAB_VECTOR)
            If i >= 0 Then
                'Jiggle the vector.
                For i = i To UBound(m_ed.board(m_ed.undoIndex).vectors) - 1
                   Set m_ed.board(m_ed.undoIndex).vectors(i) = m_ed.board(m_ed.undoIndex).vectors(i + 1)
                Next i
                Set m_ed.board(m_ed.undoIndex).vectors(i) = Nothing
                If i <> 0 Then ReDim Preserve m_ed.board(m_ed.undoIndex).vectors(i - 1)
            End If
        Case BS_PROGRAM
            i = m_ed.currentObject(BTAB_PROGRAM)
            If i >= 0 Then
                For i = i To UBound(m_ed.board(m_ed.undoIndex).prgs) - 1
                   Set m_ed.board(m_ed.undoIndex).prgs(i) = m_ed.board(m_ed.undoIndex).prgs(i + 1)
                Next i
                Set m_ed.board(m_ed.undoIndex).prgs(i) = Nothing
                If i <> 0 Then ReDim Preserve m_ed.board(m_ed.undoIndex).prgs(i - 1)
            End If
    End Select
    Call toolbarRefresh
End Sub
Private Sub vectorDeleteSelection(ByRef sel As CBoardSelection) ':on error resume next
    Dim curVector As CVector
    If currentVector Is Nothing Then Exit Sub
    Call setUndo
    Set curVector = currentVector                   'After setUndo
    
    If m_ed.optTool = BT_SELECT And m_sel.status = SS_FINISHED Then
        Call curVector.deleteSelection(sel)
    Else
        Call curVector.deletePoints
    End If
    If curVector.tiletype = TT_NULL Then
        Set curVector = Nothing
        Call vectorDeleteCurrent(m_ed.optSetting)
    End If
    Call drawBoard
End Sub
Private Sub vectorExtendSelection(ByRef sel As CBoardSelection) ':on error resume next
    Dim x As Long, y As Long
    If m_ed.optTool = BT_SELECT And m_sel.status = SS_FINISHED And (Not currentVector Is Nothing) Then
        If currentVector.extendSelection(sel, x, y) Then
            Call setUndo
            'Extend the first endpoint found.
            tkMainForm.brdOptTool(BT_DRAW).value = True
            sel.x1 = x
            sel.y1 = y
            sel.status = SS_DRAWING
        End If
    End If
End Sub
Private Function vectorGetColor() As Long: On Error Resume Next
    Select Case m_ed.optSetting
        Case BS_VECTOR
            vectorGetColor = m_ed.vectorColor(currentVector.tiletype)
        Case BS_PROGRAM
            vectorGetColor = m_ed.programColor
    End Select
End Function
Private Sub vectorSetCurrent(ByRef sel As CBoardSelection) ': on error resume next
    'Determine the nearest point on a vector and make it the current vector.
    Dim i As Long, j As Long, x As Long, y As Long, dist As Long, best As Long
    best = -1
    
    Call vectorBuildCurrentSet
    For i = 0 To UBound(m_ed.currentVectorSet)
        '.vectors is always dimensioned.
        If Not m_ed.currentVectorSet(i) Is Nothing Then
            Call m_ed.currentVectorSet(i).nearestPoint(sel.x1, sel.y1, x, y, dist)
            If dist < best Or best = -1 Then
                best = dist: j = i
            End If
        End If
    Next i
    
    Call toolbarChange(j, m_ed.optSetting)
    
End Sub
Private Sub vectorSubdivideSelection(ByRef sel As CBoardSelection) ':on error resume next
    If m_ed.optTool = BT_SELECT And m_sel.status = SS_FINISHED And (Not currentVector Is Nothing) Then
        Call setUndo
        Call currentVector.subdivideSelection(sel)
        Call drawBoard
    End If
End Sub

'========================================================================
'========================================================================
Public Sub imageApply(ByVal index As Long) ':on error resume next
    Dim ctl As ctlBrdImage, w As Long, h As Long, img As TKBoardImage
    Set ctl = tkMainForm.bTools_ctlImage
    
    img = m_ed.board(m_ed.undoIndex).Images(index)
    w = img.bounds.Right - img.bounds.Left
    h = img.bounds.Bottom - img.bounds.Top
    
    img.bounds.Left = val(ctl.getTxtLoc(0).Text)    'Board pixel co-ordinates always.
    img.bounds.Top = val(ctl.getTxtLoc(1).Text)
    img.bounds.Right = img.bounds.Left + w
    img.bounds.Bottom = img.bounds.Top + h
    img.layer = val(ctl.getTxtLoc(2).Text)
    
    img.drawType = BI_NORMAL                        'Until parallax/stretch implemented.
    img.transpcolor = ctl.transpcolor
    
    'Free the canvas of the current image if changing filename.
    If img.file <> ctl.getTxtFilename.Text And img.pCnv Then
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(img))
    End If
    img.file = ctl.getTxtFilename.Text
    
    m_ed.board(m_ed.undoIndex).Images(index) = img
    Call imagePopulate(ctl.getCombo.ListIndex, img)
End Sub
Private Sub imageCreate(ByRef board As TKBoard, ByVal x As Long, ByVal y As Long) ':on error resume next
    Dim i As Long, bFound As Boolean '.prgs is always dimensioned.
    For i = 0 To UBound(board.Images)
        If board.Images(i).drawType = BI_NULL Then
            bFound = True
            Exit For
        End If
    Next i
    If Not bFound Then
        ReDim Preserve board.Images(i)
    End If
    board.Images(i).drawType = BI_NORMAL
    Call toolbarPopulateImages
    
    board.Images(i).layer = m_ed.currentLayer
    board.Images(i).bounds.Left = x             'Board pixel co-ordinates always.
    board.Images(i).bounds.Top = y
    
    Call imagePopulate(i, board.Images(i))
End Sub
Public Sub imageDeleteCurrent(ByVal index As Long) ':on error resume next
    Dim i As Long, img As TKBoardImage
    If index >= 0 Then
        Call setUndo
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(m_ed.board(m_ed.undoIndex).Images(index)))
        For i = index To UBound(m_ed.board(m_ed.undoIndex).Images) - 1
           m_ed.board(m_ed.undoIndex).Images(i) = m_ed.board(m_ed.undoIndex).Images(i + 1)
        Next i
        If i = 0 Then
            img.drawType = BI_NULL
            m_ed.board(m_ed.undoIndex).Images(0) = img
        Else
            ReDim Preserve m_ed.board(m_ed.undoIndex).Images(i - 1)
        End If
        Call toolbarPopulateImages
    End If
End Sub
Private Function imageHitTest(ByVal x As Long, ByVal y As Long, ByRef index As Long, ByRef img As TKBoardImage, ByRef imgs() As TKBoardImage) As Boolean ':on error resume next
    Dim i As Long
    For i = UBound(imgs) To 0 Step -1
        If x > imgs(i).bounds.Left And x < imgs(i).bounds.Right And _
            y > imgs(i).bounds.Top And y < imgs(i).bounds.Bottom Then
            img = imgs(i)
            index = i
            imageHitTest = True
            Exit Function
        End If
    Next i
End Function
Private Sub imagePopulate(ByVal index As Long, ByRef img As TKBoardImage) ':on error resume next
    Dim ctl As ctlBrdImage, cmb As ComboBox
    Set ctl = m_ctls(BTAB_IMAGE)
    Set cmb = ctl.getCombo
    
    If img.drawType = BI_NULL Then
        Call ctl.disableAll
        Exit Sub
    End If
    
    Call toolbarSetCurrent(BTAB_IMAGE, index)
    Call ctl.enableAll
    
    If cmb.ListIndex <> index Then cmb.ListIndex = index
    cmb.list(index) = str(index) & ": " & IIf(LenB(img.file), img.file, "<image>")
    ctl.getTxtFilename.Text = img.file
    ctl.getTxtLoc(0).Text = str(img.bounds.Left)
    ctl.getTxtLoc(1).Text = str(img.bounds.Top)
    ctl.getTxtLoc(2).Text = str(img.layer)
    ctl.transpcolor = img.transpcolor
End Sub

'========================================================================
'========================================================================
Private Sub spriteCreate(ByRef board As TKBoard, ByVal x As Long, ByVal y As Long) ':on error resume next
    Dim i As Long, bFound As Boolean
    For i = 0 To UBound(board.sprites)
        If board.sprites(i) Is Nothing Then
            bFound = True
            Exit For
        End If
    Next i
    If Not bFound Then
        ReDim Preserve board.sprites(i)
        ReDim Preserve board.spriteImages(i)
    End If
    Set board.sprites(i) = New CBoardSprite
    Call toolbarPopulateSprites                         'Add the combo entry.
    
    board.sprites(i).layer = m_ed.currentLayer
    
    'Store the board pixel point always.
    Dim pt As POINTAPI
    pt.x = x: pt.y = y
    If (m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0 Then pt = snapToGrid(pt, True)
    board.sprites(i).x = pt.x
    board.sprites(i).y = pt.y
    Call spriteUpdateImageData(board.sprites(i), vbNullString)
    
    Call m_ctls(BTAB_SPRITE).populate(i, board.sprites(i))
End Sub
Public Sub spriteDeleteCurrent(ByVal index As Long) ':on error resume next
    Dim i As Long
    If index >= 0 Then
        Call setUndo
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(m_ed.board(m_ed.undoIndex).spriteImages(index)))
        For i = index To UBound(m_ed.board(m_ed.undoIndex).sprites) - 1
            Set m_ed.board(m_ed.undoIndex).sprites(i) = m_ed.board(m_ed.undoIndex).sprites(i + 1)
           m_ed.board(m_ed.undoIndex).spriteImages(i) = m_ed.board(m_ed.undoIndex).spriteImages(i + 1)
        Next i
        Set m_ed.board(m_ed.undoIndex).sprites(i) = Nothing
        If i = 0 Then
            ReDim m_ed.board(m_ed.undoIndex).spriteImages(0)
        Else
            ReDim Preserve m_ed.board(m_ed.undoIndex).spriteImages(i - 1)
            ReDim Preserve m_ed.board(m_ed.undoIndex).sprites(i - 1)
        End If
        Call toolbarPopulateSprites
    End If
End Sub
Public Sub spriteUpdateImageData(ByRef spr As CBoardSprite, ByVal filename As String) ':on error resume next
    Dim img As TKBoardImage, w As Long, h As Long, ext As String
    img = spriteGetImageData(spr)
    
    If spr.filename <> filename Then 'And img.pCnv Then
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(img))
        Call modBoard.spriteGetDisplayImage(filename, img.file, img.transpcolor)
        
        'Render the new image and update img.
        Call spriteSetImageData(spr, img)
        Call drawBoard(False)
        img = spriteGetImageData(spr)
        
        'Render tst/tbm here because actkrt does not have easy access to tbm format.
        'actkrt3 creates a blank canvas to render onto, which is a member of CBoard.m_images
        If LCase$(extention(img.file)) = "tst" Then
            Call drawTileCnv(img.pCnv, projectPath & img.file, 1, 1, 0, 0, 0, False)
        ElseIf LCase$(extention(img.file)) = "tbm" Then
            Dim tbm As TKTileBitmap
            Call OpenTileBitmap(projectPath & img.file, tbm)
            Call CNVResize(img.pCnv, picBoard.hdc, tbm.sizex * 32, tbm.sizey * 32)
            Call DrawTileBitmapCNV(img.pCnv, -1, 0, 0, tbm)
        End If
        
    End If
    spr.filename = filename
    
    'spr.x,y is at the centre-bottom of the frame (where the sprite's position is referenced).
    w = 32: h = 32
    If img.pCnv Then w = CNVGetWidth(img.pCnv): h = CNVGetHeight(img.pCnv)
    img.bounds.Left = spr.x - w / 2
    img.bounds.Top = spr.y - h
    img.bounds.Right = img.bounds.Left + w
    img.bounds.Bottom = img.bounds.Top + h
    img.layer = spr.layer
    Call spriteSetImageData(spr, img)
End Sub
Private Function spriteGetImageData(ByRef spr As CBoardSprite) As TKBoardImage ':on error resume next
    Dim i As Long
    For i = 0 To UBound(m_ed.board(m_ed.undoIndex).sprites)
        If m_ed.board(m_ed.undoIndex).sprites(i) Is spr Then
            spriteGetImageData = m_ed.board(m_ed.undoIndex).spriteImages(i)
            Exit Function
        End If
    Next i
End Function
Private Sub spriteSetImageData(ByRef spr As CBoardSprite, img As TKBoardImage) ':on error resume next
    Dim i As Long
    For i = 0 To UBound(m_ed.board(m_ed.undoIndex).sprites)
        If m_ed.board(m_ed.undoIndex).sprites(i) Is spr Then
            m_ed.board(m_ed.undoIndex).spriteImages(i) = img
            Exit Sub
        End If
    Next i
End Sub
Public Function spriteSwapSlots(ByVal index As Long, ByVal newIndex As Long) As Boolean ':on error resume next
    If newIndex = index Or newIndex < 0 Or newIndex > UBound(m_ed.board(m_ed.undoIndex).sprites) Then Exit Function
    
    Dim spr As CBoardSprite, img As TKBoardImage
    'Hold the data in the new slot.
    Set spr = m_ed.board(m_ed.undoIndex).sprites(newIndex)
    img = m_ed.board(m_ed.undoIndex).spriteImages(newIndex)
    
    Set m_ed.board(m_ed.undoIndex).sprites(newIndex) = m_ed.board(m_ed.undoIndex).sprites(index)
    m_ed.board(m_ed.undoIndex).spriteImages(newIndex) = m_ed.board(m_ed.undoIndex).spriteImages(index)
    
    Set m_ed.board(m_ed.undoIndex).sprites(index) = spr
    m_ed.board(m_ed.undoIndex).spriteImages(index) = img
        
    Call toolbarSetCurrent(BTAB_SPRITE, newIndex)
    Call toolbarPopulateSprites
End Function

'========================================================================
'========================================================================
Public Sub toolbarRefresh() ':on error resume next
    Select Case tkMainForm.bTools_Tabs.Tab
        Case BTAB_VECTOR:     Call toolbarPopulateVectors
        Case BTAB_PROGRAM:    Call toolbarPopulatePrgs
        Case BTAB_SPRITE:     Call toolbarPopulateSprites
        Case BTAB_IMAGE:      Call toolbarPopulateImages
    End Select
End Sub
Public Sub toolbarChange(ByVal index As Long, ByVal setting As eBrdSetting) ':on error resume next
    Select Case setting
        Case BS_VECTOR
            Call m_ctls(BTAB_VECTOR).populate(index, m_ed.board(m_ed.undoIndex).vectors(index))
        Case BS_PROGRAM
            Call m_ctls(BTAB_PROGRAM).populate(index, m_ed.board(m_ed.undoIndex).prgs(index))
        Case BS_SPRITE
            Call m_ctls(BTAB_SPRITE).populate(index, m_ed.board(m_ed.undoIndex).sprites(index))
        Case BS_IMAGE
            Call imagePopulate(index, m_ed.board(m_ed.undoIndex).Images(index))
    End Select
    Call drawAll
End Sub
Public Sub toolbarPopulateVectors() ':on error resume next
    Dim i As Long, j As Long, k As Long
    k = m_ed.currentObject(BTAB_VECTOR)
                
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.vectors)
            If Not .vectors(i) Is Nothing Then j = j + 1
        Next i
    End With
    If j > 0 Then
        'Preserve selected vector.
        i = IIf(k < j And k <> -1, k, 0)
        Call m_ctls(BTAB_VECTOR).populate(i, m_ed.board(m_ed.undoIndex).vectors(i))
    Else
        'No vectors.
        Call m_ctls(BTAB_VECTOR).populate(-1, Nothing)
    End If
End Sub
Public Sub toolbarPopulatePrgs() ':on error resume next

    'User controls don't seem to like arrays of class references, so...
    Dim combo As ComboBox, i As Long, j As Long, k As Long
    Set combo = m_ctls(BTAB_PROGRAM).getCombo
    combo.clear
    k = m_ed.currentObject(BTAB_PROGRAM)
    
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.prgs)
            If Not .prgs(i) Is Nothing Then
                    combo.AddItem str(j) & ": " & IIf(LenB(.prgs(i).filename), .prgs(i).filename, "<program>")
                    j = j + 1
            End If
        Next i
    End With
    If j > 0 Then
        'Preserve selected vector.
        i = IIf(k < j And k <> -1, k, 0)
        Call m_ctls(BTAB_PROGRAM).populate(i, m_ed.board(m_ed.undoIndex).prgs(i))
    Else
        'No programs.
        Call m_ctls(BTAB_PROGRAM).disableAll
    End If

End Sub
Private Sub toolbarPopulateImages() ':on error resume next
    
    'User controls don't seem to like arrays, so...
    Dim combo As ComboBox, i As Long, j As Long, k As Long
    Set combo = m_ctls(BTAB_IMAGE).getCombo
    combo.clear
    k = m_ed.currentObject(BTAB_IMAGE)
    
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.Images)
            If Not .Images(i).drawType = BI_NULL Then
                'If Not .images(i) Is Nothing Then
                    combo.AddItem str(j) & ": " & IIf(LenB(.Images(i).file), .Images(i).file, "<image>")
                    j = j + 1
                'End If
            End If
        Next i
    End With
    If j > 0 Then
        'Preserve selected image.
        i = IIf(k < j And k <> -1, k, 0)
        Call imagePopulate(i, m_ed.board(m_ed.undoIndex).Images(i))
    Else
        'No images.
        Call m_ctls(BTAB_IMAGE).disableAll
        Call drawAll
    End If
End Sub
Private Sub toolbarPopulateSprites() ':on error resume next
    
    Dim combo As ComboBox, i As Long, j As Long, k As Long
    Set combo = m_ctls(BTAB_SPRITE).getCombo
    k = m_ed.currentObject(BTAB_SPRITE)
    combo.clear
    
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.sprites)
            If Not .sprites(i) Is Nothing Then
                    combo.AddItem str(j) & ": " & IIf(LenB(.sprites(i).filename), .sprites(i).filename, "<sprite>")
                    j = j + 1
            End If
        Next i
    End With
    If j > 0 Then
        'Preserve selected sprite.
        i = IIf(k < j And k <> -1, k, 0)
        Call m_ctls(BTAB_SPRITE).populate(i, m_ed.board(m_ed.undoIndex).sprites(i))
    Else
        'No sprites.
        Call m_ctls(BTAB_SPRITE).disableAll
        Call drawAll
    End If
End Sub
Public Function toolbarGetCurrent(ByVal setting As eBrdSetting) As Object ':on error resume next
    Select Case setting
        Case BS_VECTOR:     Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).vectors(toolbarGetIndex(setting))
        Case BS_PROGRAM:    Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).prgs(toolbarGetIndex(setting))
        Case BS_SPRITE:     Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).sprites(toolbarGetIndex(setting))
    End Select
End Function
Public Function toolbarGetIndex(ByVal setting As eBrdSetting) As Long ':on error resume next
    toolbarGetIndex = m_ed.currentObject(g_tabMap(setting))
End Function
Public Sub toolbarSetCurrent(ByVal obj As eBoardTabs, ByVal index As Long) ':on error resume next
    m_ed.currentObject(obj) = index
End Sub

'========================================================================
'========================================================================
Private Sub clipCopy(ByRef clip As TKBoardClipboard, ByRef sel As CBoardSelection, ByVal bSetOrigin As Boolean) ':on error resume next
    Dim t1 As POINTAPI, t2 As POINTAPI, d As POINTAPI, O As POINTAPI
    Dim i As Long, j As Long, k As Long, file As String, r As RECT
    
    'Set the origin of the copy.
    'Allow for a tile drag-drop: set the origin at the beginning of the drag and recreate the
    'original area from the selection dimensions.
    If bSetOrigin Then
        clip.origin.x = sel.x1
        clip.origin.y = sel.y1
    End If
    O = clip.origin
    d.x = sel.x2 - sel.x1
    d.y = sel.y2 - sel.y1
    
    Select Case m_ed.optSetting
        Case BS_TILE
            ReDim clip.tiles(0)
            k = 0
            If isIsometric(m_ed.board(m_ed.undoIndex).coordType) Then
                'Find the centres of the contained tiles by pixel coordinates.
                i = O.x + 32
                Do While i < O.x + d.x
                    j = O.y + IIf(i - O.x Mod 64 = 0, 32, 16)
                    Do While j < O.y + d.y
                        t1 = modBoard.boardPixelToTile(i, j, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
                        file = BoardGetTile(t1.x, t1.y, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))
                        If file <> vbNullString Then
                            ReDim Preserve clip.tiles(k)
                            'Save tile coordinates.
                            clip.tiles(k).brdCoord.x = t1.x
                            clip.tiles(k).brdCoord.y = t1.y
                            clip.tiles(k).file = file
                            k = k + 1
                        End If
                        j = j + 32
                    Loop
                    i = i + 32
                Loop
            Else
                t1 = modBoard.boardPixelToTile(O.x, O.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
                t2 = modBoard.boardPixelToTile(O.x + d.x, O.y + d.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
                For i = t1.x To t2.x - 1
                    For j = t1.y To t2.y - 1
                        file = BoardGetTile(i, j, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))
                        If file <> vbNullString Then
                            ReDim Preserve clip.tiles(k)
                            clip.tiles(k).brdCoord.x = i
                            clip.tiles(k).brdCoord.y = j
                            clip.tiles(k).file = file
                            k = k + 1
                        End If
                    Next j
                Next i
            End If 'isIsometric()
            
        Case BS_VECTOR, BS_PROGRAM
            Dim obj As Object
            Set obj = toolbarGetCurrent(m_ed.optSetting)
            If Not (obj Is Nothing) Then
                Call mnuSelectAll_Click
                Set clip.obj = obj
                Call clip.obj.setSelection(sel)
            End If
        Case BS_SPRITE
            Dim spr As CBoardSprite
            Set spr = toolbarGetCurrent(m_ed.optSetting)
            If Not (spr Is Nothing) Then
                r = m_ed.board(m_ed.undoIndex).spriteImages(toolbarGetIndex(m_ed.optSetting)).bounds
                Call m_sel.assign(r.Left, r.Top, r.Right, r.Bottom)
                Set clip.obj = spr
            End If
        Case BS_IMAGE
            i = toolbarGetIndex(m_ed.optSetting)
            If m_ed.board(m_ed.undoIndex).Images(i).drawType <> BI_NULL Then
                r = m_ed.board(m_ed.undoIndex).Images(i).bounds
                Call m_sel.assign(r.Left, r.Top, r.Right, r.Bottom)
                clip.img = m_ed.board(m_ed.undoIndex).Images(i)
                clip.img.pCnv = 0               'Do not let two objects point to the same canvas.
            End If
            
    End Select
    
    'Update for BS_VECTOR,BS_PROGRAM,BS_SPRITE,BS_IMAGE
    clip.origin.x = sel.x1
    clip.origin.y = sel.y1
    
End Sub
Private Sub clipCut(ByRef clip As TKBoardClipboard, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Long
    For i = 0 To UBound(clip.tiles)
        'Cut the current tile.
        Call BoardSetTile( _
            clip.tiles(i).brdCoord.x, clip.tiles(i).brdCoord.y, _
            m_ed.currentLayer, _
            vbNullString, _
            m_ed.board(m_ed.undoIndex) _
        )
    Next i
    If bRedraw Then
        Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
        Call drawBoard
    End If
End Sub
Private Sub clipPaste(ByRef clip As TKBoardClipboard, ByRef sel As CBoardSelection) ':on error resume next
    Dim dr As POINTAPI, pt As POINTAPI, i As Long
    
    'Displacement of the copied area.
    dr.x = sel.x1 - clip.origin.x
    dr.y = sel.y1 - clip.origin.y
    
    Select Case m_ed.optSetting
        Case BS_TILE
            For i = 0 To UBound(clip.tiles)
                'Origin.
                pt = modBoard.tileToBoardPixel(clip.tiles(i).brdCoord.x, clip.tiles(i).brdCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
                'Get new tile from new position in pixels.
                pt = modBoard.boardPixelToTile(pt.x + dr.x, pt.y + dr.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).bSizeX)
                Call BoardSetTile( _
                    pt.x, pt.y, _
                    m_ed.currentLayer, _
                    clip.tiles(i).file, _
                    m_ed.board(m_ed.undoIndex) _
                )
                'm_ed.board(m_ed.undoIndex).ambientRed(x, y, m_ed.currentLayer) = m_ed.ambientR
                'm_ed.board(m_ed.undoIndex).ambientGreen(x, y, m_ed.currentLayer) = m_ed.ambientG
                'm_ed.board(m_ed.undoIndex).ambientBlue(x, y, m_ed.currentLayer) = m_ed.ambientB
            Next i
            Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
        
        Case BS_VECTOR, BS_PROGRAM
            Call vectorCreate(m_ed.optSetting, m_ed.board(m_ed.undoIndex), m_ed.currentLayer)
            Call clip.obj.moveSelectionBy(dr.x, dr.y)
            Call clip.obj.copy(toolbarGetCurrent(m_ed.optSetting))
            Call toolbarRefresh
        Case BS_SPRITE
            clip.obj.x = clip.obj.x + dr.x
            clip.obj.y = clip.obj.y + dr.y
            Call spriteCreate(m_ed.board(m_ed.undoIndex), clip.obj.x, clip.obj.y)
            Call clip.obj.copy(toolbarGetCurrent(m_ed.optSetting))
            Call toolbarRefresh
        Case BS_IMAGE
            clip.img.bounds.Left = clip.img.bounds.Left + dr.x
            clip.img.bounds.Top = clip.img.bounds.Top + dr.y
            Call imageCreate(m_ed.board(m_ed.undoIndex), 0, 0)
            m_ed.board(m_ed.undoIndex).Images(toolbarGetIndex(m_ed.optSetting)) = clip.img
            Call toolbarRefresh
        End Select
    Call drawBoard
End Sub

Public Sub boardPixelToTile(ByRef x As Long, ByRef y As Long, ByVal bRemoveBasePoint As Boolean, Optional ByVal bIgnorePxAbsolute As Boolean = True): On Error Resume Next
    Dim pt As POINTAPI
    If bIgnorePxAbsolute Or ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0) Then
        pt = modBoard.boardPixelToTile(x, y, m_ed.board(m_ed.undoIndex).coordType, bRemoveBasePoint, m_ed.board(m_ed.undoIndex).bSizeX)
        x = pt.x
        y = pt.y
    End If
End Sub
Public Sub tileToBoardPixel(ByRef x As Long, ByRef y As Long, ByVal bAddBasePoint As Boolean, Optional ByVal bIgnorePxAbsolute As Boolean = True): On Error Resume Next
    Dim pt As POINTAPI
    If bIgnorePxAbsolute Or ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0) Then
        pt = modBoard.tileToBoardPixel(x, y, m_ed.board(m_ed.undoIndex).coordType, bAddBasePoint, m_ed.board(m_ed.undoIndex).bSizeX)
        x = pt.x
        y = pt.y
    End If
End Sub

Private Sub toolsRefresh(): On Error Resume Next
    tkMainForm.brdOptTool(BT_DRAW).Enabled = (m_ed.optSetting > BS_ZOOM)
    tkMainForm.brdOptTool(BT_SELECT).Enabled = (m_ed.optSetting > BS_ZOOM)
    tkMainForm.brdOptTool(BT_FLOOD).Enabled = (m_ed.optSetting = BS_TILE)
    tkMainForm.brdOptTool(BT_ERASE).Enabled = (m_ed.optSetting = BS_TILE)
End Sub

