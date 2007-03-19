VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmBoardEdit 
   Caption         =   "frmBoardEdit"
   ClientHeight    =   6405
   ClientLeft      =   60
   ClientTop       =   750
   ClientWidth     =   10545
   Icon            =   "frmBoardEdit.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6405
   ScaleWidth      =   10545
   Begin TabDlg.SSTab sstBoard 
      Height          =   6255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10335
      _ExtentX        =   18230
      _ExtentY        =   11033
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabHeight       =   520
      ShowFocusRect   =   0   'False
      TabCaption(0)   =   "Board"
      TabPicture(0)   =   "frmBoardEdit.frx":0CCA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "picBoard"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "vScroll"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "hScroll"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Properties"
      TabPicture(1)   =   "frmBoardEdit.frx":0CE6
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "picProperties"
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
         TabIndex        =   40
         Top             =   360
         Width           =   10095
         Begin VB.Frame fraProperties 
            Caption         =   "Threads"
            Height          =   1575
            Index           =   2
            Left            =   0
            TabIndex        =   77
            Top             =   4200
            Width           =   4935
            Begin VB.ListBox lbThreads 
               Height          =   1035
               Left            =   840
               TabIndex        =   14
               Top             =   360
               Width           =   2055
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   975
               Index           =   5
               Left            =   3120
               ScaleHeight     =   975
               ScaleWidth      =   975
               TabIndex        =   78
               Top             =   360
               Width           =   975
               Begin VB.CommandButton cmdThreadsAdd 
                  Caption         =   "Add"
                  Height          =   375
                  Left            =   0
                  TabIndex        =   15
                  Top             =   0
                  Width           =   975
               End
               Begin VB.CommandButton cmdThreadsRemove 
                  Caption         =   "Remove"
                  Height          =   375
                  Left            =   0
                  TabIndex        =   16
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
            TabIndex        =   71
            Top             =   0
            Width           =   4935
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   2
               Left            =   4320
               TabIndex        =   22
               Top             =   300
               Value           =   1
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   2
               Left            =   3600
               TabIndex        =   21
               Text            =   "Text7"
               Top             =   300
               Width           =   615
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   1
               Left            =   1500
               TabIndex        =   20
               Top             =   720
               Value           =   1
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   1
               Left            =   840
               TabIndex        =   19
               Text            =   "Text7"
               Top             =   720
               Width           =   615
            End
            Begin VB.HScrollBar hsbDims 
               Height          =   285
               Index           =   0
               Left            =   1500
               TabIndex        =   18
               Top             =   300
               Value           =   1
               Width           =   495
            End
            Begin VB.TextBox txtDims 
               Height          =   285
               Index           =   0
               Left            =   840
               TabIndex        =   17
               Text            =   "Text7"
               Top             =   300
               Width           =   615
            End
            Begin VB.Label lblProperties 
               Caption         =   "Isometric stacked / Pixel coordinates"
               Height          =   375
               Index           =   13
               Left            =   3000
               TabIndex        =   79
               Top             =   780
               Width           =   1815
            End
            Begin VB.Label lblProperties 
               Caption         =   "Layers"
               Height          =   255
               Index           =   12
               Left            =   3000
               TabIndex        =   76
               Top             =   360
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "1024 pixels"
               Height          =   255
               Index           =   11
               Left            =   2055
               TabIndex        =   75
               Top             =   780
               Width           =   975
            End
            Begin VB.Label lblProperties 
               Caption         =   "1024 pixels"
               Height          =   255
               Index           =   10
               Left            =   2055
               TabIndex        =   74
               Top             =   360
               Width           =   975
            End
            Begin VB.Label lblProperties 
               Caption         =   "Width"
               Height          =   255
               Index           =   8
               Left            =   120
               TabIndex        =   73
               Top             =   360
               Width           =   735
            End
            Begin VB.Label lblProperties 
               Caption         =   "Height"
               Height          =   255
               Index           =   9
               Left            =   120
               TabIndex        =   72
               Top             =   780
               Width           =   735
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Constants"
            Height          =   1215
            Index           =   4
            Left            =   5160
            TabIndex        =   66
            Top             =   1440
            Width           =   4935
            Begin VB.ComboBox cmbLayerTitles 
               Height          =   315
               Left            =   840
               Style           =   2  'Dropdown List
               TabIndex        =   25
               Top             =   720
               Width           =   1335
            End
            Begin VB.TextBox txtLayerTitle 
               Height          =   285
               Left            =   3000
               TabIndex        =   26
               Top             =   720
               Width           =   1815
            End
            Begin VB.TextBox txtConstant 
               Height          =   285
               Left            =   3000
               TabIndex        =   24
               Top             =   240
               Width           =   1815
            End
            Begin VB.ComboBox cmbConstants 
               Height          =   315
               Left            =   840
               Style           =   2  'Dropdown List
               TabIndex        =   23
               Top             =   240
               Width           =   1335
            End
            Begin VB.Label lblProperties 
               Caption         =   "Layer"
               Height          =   255
               Index           =   16
               Left            =   120
               TabIndex        =   70
               Top             =   780
               Width           =   735
            End
            Begin VB.Label lblProperties 
               Caption         =   "Title"
               Height          =   255
               Index           =   17
               Left            =   2400
               TabIndex        =   69
               Top             =   780
               Width           =   855
            End
            Begin VB.Label lblProperties 
               Caption         =   "Value"
               Height          =   255
               Index           =   15
               Left            =   2400
               TabIndex        =   68
               Top             =   300
               Width           =   855
            End
            Begin VB.Label lblProperties 
               Caption         =   "Constant"
               Height          =   255
               Index           =   14
               Left            =   120
               TabIndex        =   67
               Top             =   300
               Width           =   735
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Miscellaneous"
            Height          =   1575
            Index           =   6
            Left            =   5160
            TabIndex        =   63
            Top             =   4200
            Width           =   4935
            Begin VB.TextBox txtAmbientLevel 
               Height          =   285
               Index           =   2
               Left            =   4200
               TabIndex        =   34
               Text            =   "0"
               Top             =   960
               Width           =   615
            End
            Begin VB.TextBox txtAmbientLevel 
               Height          =   285
               Index           =   1
               Left            =   4200
               TabIndex        =   33
               Text            =   "0"
               Top             =   600
               Width           =   615
            End
            Begin VB.TextBox txtAmbientLevel 
               Height          =   285
               Index           =   0
               Left            =   4200
               TabIndex        =   32
               Text            =   "0"
               Top             =   240
               Width           =   615
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   6
               Left            =   2880
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   64
               Top             =   1080
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   8
                  Left            =   0
                  TabIndex        =   36
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtPrgEnterBoard 
               Height          =   285
               Left            =   240
               TabIndex        =   35
               Text            =   "Text2"
               Top             =   1080
               Width           =   2535
            End
            Begin VB.CheckBox chkDisableSaving 
               Caption         =   "Disable progressive saving"
               Height          =   375
               Left            =   240
               TabIndex        =   31
               ToolTipText     =   "Disable saving in the default menu"
               Top             =   360
               Width           =   2175
            End
            Begin VB.Label lblProperties 
               Caption         =   "R                          G                        B"
               Height          =   975
               Index           =   22
               Left            =   3960
               TabIndex        =   81
               Top             =   240
               Width           =   615
            End
            Begin VB.Label lblProperties 
               Caption         =   "Ambient RGB (-255 to +255) "
               Height          =   495
               Index           =   21
               Left            =   2880
               TabIndex        =   80
               ToolTipText     =   "A uniform shade that is applied to the board"
               Top             =   360
               Width           =   1215
            End
            Begin VB.Label lblProperties 
               Caption         =   "Program to run when entering board"
               Height          =   255
               Index           =   20
               Left            =   240
               TabIndex        =   65
               Top             =   840
               Width           =   2775
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Battle settings"
            Height          =   1335
            Index           =   5
            Left            =   5160
            TabIndex        =   59
            Top             =   2760
            Width           =   4935
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   9
               Left            =   4320
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   60
               Top             =   720
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   7
                  Left            =   0
                  TabIndex        =   30
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBattleBackground 
               Height          =   285
               Left            =   1560
               TabIndex        =   29
               Text            =   "Text4"
               Top             =   720
               Width           =   2655
            End
            Begin VB.TextBox txtBoardSkill 
               Height          =   285
               Left            =   4320
               TabIndex        =   28
               Text            =   "Text3"
               Top             =   240
               Width           =   495
            End
            Begin VB.CheckBox chkEnableBattles 
               Caption         =   "Enable fighting on this board"
               Height          =   375
               Left            =   240
               TabIndex        =   27
               Top             =   240
               Width           =   2535
            End
            Begin VB.Label lblProperties 
               Caption         =   "Battle background"
               Height          =   495
               Index           =   18
               Left            =   240
               TabIndex        =   62
               Top             =   660
               Width           =   1095
            End
            Begin VB.Label lblProperties 
               Caption         =   "Board skill"
               Height          =   255
               Index           =   19
               Left            =   3450
               TabIndex        =   61
               Top             =   300
               Width           =   855
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Links"
            Height          =   2055
            Index           =   0
            Left            =   0
            TabIndex        =   49
            Top             =   0
            Width           =   4935
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   325
               Index           =   3
               Left            =   3600
               ScaleHeight     =   330
               ScaleWidth      =   495
               TabIndex        =   53
               Top             =   1680
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   3
                  Left            =   0
                  TabIndex        =   8
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   3
               Left            =   840
               TabIndex        =   7
               Text            =   "Text2"
               Top             =   1680
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   2
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   52
               Top             =   1320
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   2
                  Left            =   0
                  TabIndex        =   6
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   2
               Left            =   840
               TabIndex        =   5
               Text            =   "Text2"
               Top             =   1320
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   1
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   51
               Top             =   960
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   1
                  Left            =   0
                  TabIndex        =   4
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   1
               Left            =   840
               TabIndex        =   3
               Text            =   "Text2"
               Top             =   960
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   0
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   50
               Top             =   600
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   0
                  Left            =   0
                  TabIndex        =   2
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtLinks 
               Height          =   285
               Index           =   0
               Left            =   840
               TabIndex        =   1
               Text            =   "Text2"
               Top             =   600
               Width           =   2655
            End
            Begin VB.Label lblProperties 
               Caption         =   "Directional links (board or program)"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   58
               Top             =   240
               Width           =   3255
            End
            Begin VB.Label lblProperties 
               Caption         =   "North"
               Height          =   255
               Index           =   1
               Left            =   240
               TabIndex        =   57
               Top             =   600
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "South"
               Height          =   255
               Index           =   2
               Left            =   240
               TabIndex        =   56
               Top             =   960
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "East"
               Height          =   255
               Index           =   3
               Left            =   240
               TabIndex        =   55
               Top             =   1320
               Width           =   495
            End
            Begin VB.Label lblProperties 
               Caption         =   "West"
               Height          =   255
               Index           =   4
               Left            =   240
               TabIndex        =   54
               Top             =   1680
               Width           =   495
            End
         End
         Begin VB.Frame fraProperties 
            Caption         =   "Background settings"
            Height          =   1935
            Index           =   1
            Left            =   0
            TabIndex        =   41
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
               TabIndex        =   45
               Top             =   960
               Width           =   615
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   4
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   44
               Top             =   480
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   4
                  Left            =   0
                  TabIndex        =   10
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundImage 
               Height          =   285
               Left            =   840
               TabIndex        =   9
               Text            =   "Text1"
               Top             =   480
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   8
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   43
               Top             =   960
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   5
                  Left            =   0
                  TabIndex        =   11
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.TextBox txtBackgroundMusic 
               Height          =   285
               Left            =   840
               TabIndex        =   12
               Text            =   "Text2"
               Top             =   1440
               Width           =   2655
            End
            Begin VB.PictureBox picHolder 
               BorderStyle     =   0  'None
               Height          =   375
               Index           =   7
               Left            =   3600
               ScaleHeight     =   375
               ScaleWidth      =   495
               TabIndex        =   42
               Top             =   1440
               Width           =   495
               Begin VB.CommandButton cmdBrowse 
                  Caption         =   "..."
                  Height          =   255
                  Index           =   6
                  Left            =   0
                  TabIndex        =   13
                  Top             =   0
                  Width           =   495
               End
            End
            Begin VB.Label lblProperties 
               Caption         =   "Background color"
               Height          =   255
               Index           =   6
               Left            =   840
               TabIndex        =   48
               Top             =   940
               Width           =   1815
            End
            Begin VB.Label lblProperties 
               Caption         =   "Board background image"
               Height          =   255
               Index           =   5
               Left            =   840
               TabIndex        =   47
               Top             =   240
               Width           =   2775
            End
            Begin VB.Label lblProperties 
               Caption         =   "Background music"
               Height          =   255
               Index           =   7
               Left            =   840
               TabIndex        =   46
               Top             =   1200
               Width           =   2775
            End
         End
      End
      Begin VB.HScrollBar hScroll 
         Height          =   255
         Left            =   120
         SmallChange     =   32
         TabIndex        =   39
         TabStop         =   0   'False
         Top             =   3000
         Visible         =   0   'False
         Width           =   4215
      End
      Begin VB.VScrollBar vScroll 
         Height          =   2655
         Left            =   4320
         SmallChange     =   32
         TabIndex        =   38
         TabStop         =   0   'False
         Top             =   360
         Visible         =   0   'False
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
         TabIndex        =   37
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
   Begin VB.Menu mnu 
      Caption         =   "File"
      Index           =   0
      Begin VB.Menu mnuNewProject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuNewFile 
         Caption         =   "New..."
         Begin VB.Menu mnuNew 
            Caption         =   "Tile"
            Index           =   0
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Animated Tile"
            Index           =   1
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Board"
            Index           =   2
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Player"
            Index           =   3
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Item"
            Index           =   4
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Enemy"
            Index           =   5
         End
         Begin VB.Menu mnuNew 
            Caption         =   "RPGCode Program"
            Index           =   6
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Fight Background"
            Index           =   7
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Special Move"
            Index           =   8
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Status Effect"
            Index           =   9
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Animation"
            Index           =   10
         End
         Begin VB.Menu mnuNew 
            Caption         =   "Tile Bitmap"
            Index           =   11
         End
      End
      Begin VB.Menu mnuS1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
         Index           =   0
      End
      Begin VB.Menu mnuOpenFile 
         Caption         =   "Open File"
         Index           =   1
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save Board"
         Index           =   0
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save Board As"
         Index           =   1
         Shortcut        =   {F2}
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save All"
         Index           =   2
         Shortcut        =   {F3}
      End
      Begin VB.Menu mnuS2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCloseBoard 
         Caption         =   "Close Board"
         Shortcut        =   ^{F4}
      End
      Begin VB.Menu mnuExitEditor 
         Caption         =   "Exit Editor"
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Edit"
      Index           =   1
      Begin VB.Menu mnuUndo 
         Caption         =   "Undo"
         Shortcut        =   ^Z
      End
      Begin VB.Menu mnuRedo 
         Caption         =   "Redo"
         Shortcut        =   ^Y
      End
      Begin VB.Menu mnuS3 
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
      Begin VB.Menu mnuS4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectAll 
         Caption         =   "Select All"
         Shortcut        =   ^A
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Board"
      Index           =   2
      Begin VB.Menu mnuBoard 
         Caption         =   "Preferences..."
         Index           =   0
         Shortcut        =   ^F
      End
      Begin VB.Menu mnuBoard 
         Caption         =   "Set Player Start Location"
         Index           =   1
         Shortcut        =   ^D
      End
      Begin VB.Menu mnuBoard 
         Caption         =   "Convert Co-ordinates"
         Index           =   2
         Begin VB.Menu mnuCoords 
            Caption         =   "to isometric rotated"
            Index           =   0
            Shortcut        =   ^I
         End
         Begin VB.Menu mnuCoords 
            Caption         =   "to pixel"
            Index           =   1
            Shortcut        =   ^P
         End
      End
      Begin VB.Menu mnuBoard 
         Caption         =   "Export Image"
         Index           =   3
         Begin VB.Menu mnuExport 
            Caption         =   "Current Screen"
            Index           =   0
         End
         Begin VB.Menu mnuExport 
            Caption         =   "Entire Board"
            Index           =   1
         End
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Toolkit"
      Index           =   3
      Begin VB.Menu mnuToolkit 
         Caption         =   "Test Game"
         Index           =   0
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuToolkit 
         Caption         =   "Select Language"
         Enabled         =   0   'False
         Index           =   1
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Build"
      Index           =   4
      Begin VB.Menu mnuBuild 
         Caption         =   "Create PakFile"
         Index           =   0
      End
      Begin VB.Menu mnuBuild 
         Caption         =   "Make EXE"
         Index           =   1
         Shortcut        =   {F7}
      End
      Begin VB.Menu mnuBuild 
         Caption         =   "-"
         Index           =   2
      End
      Begin VB.Menu mnuBuild 
         Caption         =   "Create Setup"
         Index           =   3
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Window"
      Index           =   5
      WindowList      =   -1  'True
      Begin VB.Menu mnuWindow 
         Caption         =   "Toggle Tileset Browser"
         Index           =   0
         Shortcut        =   ^L
      End
      Begin VB.Menu mnuWindow 
         Caption         =   "Toggle Board Toolbar"
         Index           =   1
         Shortcut        =   ^B
      End
      Begin VB.Menu mnuWindow 
         Caption         =   "Show/Hide Tools"
         Index           =   2
      End
   End
   Begin VB.Menu mnu 
      Caption         =   "Help"
      Index           =   6
      Begin VB.Menu mnuHelp 
         Caption         =   "User's Guide"
         Index           =   0
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "-"
         Index           =   1
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "History.txt"
         Index           =   2
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "-"
         Index           =   3
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "About"
         Index           =   4
      End
   End
End
Attribute VB_Name = "frmBoardEdit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007  Jonathan D. Hughes & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Shao Xiang
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
Private Declare Function BRDRenderStack Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByVal pEditorData As Long, ByVal hdcCompat As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function BRDRenderTile Lib "actkrt3.dll" (ByVal filename As String, ByVal bIsometric As Boolean, ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal backColor As Long) As Long
Private Declare Function BRDFreeImage Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pImage As Long) As Long
Private Declare Function BRDRenderImage Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pImage As Long, ByVal hdcCompat As Long) As Long
Private Declare Function BRDConvertLight Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByRef pLight As Object) As Long

Private Declare Function CNVGetWidth Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVGetHeight Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVResize Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdcCompatible As Long, ByVal width As Long, ByVal Height As Long) As Long

Private Declare Function IMGExport Lib "actkrt3.dll" (ByVal hBitmap As Long, ByVal filename As String) As Long

Private m_ed As TKBoardEditorData
Private m_sel As CBoardSelection
Private m_mouseScrollDistance As Long
Private m_bScrollHorizontal As Boolean  ' Scroll horizontally? (If false, scroll vertically.)
Private m_mousePosition As POINTAPI     ' For zooming with the mousewheel.

Private Const BTAB_BOARD = 0
Private Const BTAB_PROPERTIES = 1

Private m_ctls(BTAB_LIGHTING) As Object

Private Const WM_MOUSEWHEEL = &H20A     ' Event: Mouse wheel was scrolled.
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
        If (.pCBoard) Then Call BRDFree(.pCBoard)
        .pCBoard = BRDNewCBoard(projectPath)
        .currentLayer = 1
        For i = 0 To UBound(m_ed.currentObject)
            m_ed.currentObject(i) = -1              'Initialise the selected objects.
        Next i
        ReDim m_ed.bDrawObjects(BS_LIGHTING)
        For i = 0 To UBound(m_ed.bDrawObjects)
            m_ed.bDrawObjects(i) = True
        Next i
    End With
    Set m_sel = New CBoardSelection
    Me.Caption = "Untitled board"
    Call currentShade(64, 64, 64)
End Sub
'=========================================================================
'=========================================================================
Private Sub resetEditor(ByRef ed As TKBoardEditorData) ': On Error Resume Next
    With ed
        Dim i As Long
        For i = 0 To UBound(.bLayerVisible)
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
    Call boardInitialise(m_ed.board(m_ed.undoIndex))
    Call boardSetSize(x, y, z, m_ed, m_ed.board(m_ed.undoIndex), False)
    m_ed.board(m_ed.undoIndex).bkgImage.filename = background
    
    Call initializeEditor(m_ed)
    Call assignProperties
    Call reRenderAllLayers(True)
End Sub

'========================================================================
' change selected tile {from tkMainForm: currentTilesetForm_MouseDown}
'========================================================================
Public Sub changeSelectedTile(ByVal file As String, Optional ByVal bChangeTool As Boolean = True) ': On Error Resume Next

    tkMainForm.brdPicCurrentTile.Cls
    If (LenB(file) = 0) Then Exit Sub

    ' update tileset filename
    m_ed.selectedTile = file
    tkMainForm.brdPicCurrentTile.ToolTipText = file & " (Click to change)"
    
    ' change setting/tool to tile/draw.
    If bChangeTool And m_ed.optSetting <> BS_TILE Then
        m_ed.optSetting = BS_TILE
        tkMainForm.brdOptSetting(m_ed.optSetting).value = True
        m_ed.optTool = BT_DRAW
        tkMainForm.brdOptTool(m_ed.optTool).value = True
    End If
    
    'Check for TANs here.
    If UCase$(GetExt(file)) = "TAN" Then
        Dim tan As TKTileAnm
        Call openTileAnm(projectPath & tilePath & file, tan)
        file = tan.animTileFrame(1)
    End If
    
    Call BRDRenderTile( _
        projectPath & tilePath & file, _
        isIsometric, _
        tkMainForm.brdPicCurrentTile.hdc, _
        IIf(isIsometric, 0, 16), 0, _
        GetSysColor(tkMainForm.brdPicCurrentTile.backColor And &HFFFFFF) _
    )
End Sub

'========================================================================
' identify type of form
'========================================================================
Public Property Get formType() As Long: On Error Resume Next
    formType = FT_BOARD
End Property

Public Property Get isIsometric() As Boolean: On Error Resume Next
    isIsometric = modBoard.isIsometric(m_ed.board(m_ed.undoIndex).coordType)
End Property

Private Sub Form_Activate() ':on error resume next
    Set activeBoard = Me
    Set activeForm = Me
        
    'Show tools.
    hideAllTools
    tkMainForm.popButton(PB_TOOLBAR).visible = True              'Board toolbar
    tkMainForm.boardTools.visible = True                         'Lefthand tools
    tkMainForm.boardTools.Top = tkMainForm.toolTop
    
    tkMainForm.brdOptSetting(m_ed.optSetting).value = True
    tkMainForm.brdOptTool(m_ed.optTool).value = True
    tkMainForm.brdChkGrid.value = Abs(m_ed.bGrid)
    tkMainForm.brdChkAutotile.value = Abs(m_ed.bAutotiler)
    Call changeSelectedTile(m_ed.selectedTile)
    Call toolsRefresh
    
    mnuUndo.Enabled = m_ed.bUndoData(nextUndo)
    mnuRedo.Enabled = m_ed.bUndoData(nextRedo)
    
    'Co-ordinate conversions.
    mnuCoords(0).Enabled = (m_ed.board(m_ed.undoIndex).coordType And ISO_STACKED)
    mnuCoords(1).Enabled = (m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = False
    
    Call resetLayerCombos
    
    'Update the toolbar.
    Call toolbarPopulatePrgs
    Call toolbarPopulateImages
    Call toolbarPopulateSprites
    Call toolbarPopulateLighting
    
    If tkMainForm.popButton(PB_TOOLBAR).value = 1 Then
        tkMainForm.pTools.visible = True
    End If
    
    tkMainForm.StatusBar1.Panels(4).Text = "Zoom: " & str(m_ed.pCEd.zoom * 100) & "%"
   
    Call Form_Resize

End Sub
Public Sub Form_Deactivate() ':on error resume next

    If Not (Me Is activeBoard) Then Exit Sub

    'Clear status panels.
    tkMainForm.StatusBar1.Panels(3).Text = vbNullString
    tkMainForm.StatusBar1.Panels(4).Text = vbNullString
    
    'Reset visible layers list.
    Call setVisibleLayersByCombo
    
    tkMainForm.popButton(PB_TOOLBAR).visible = False
    tkMainForm.pTools.visible = False
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
    Set m_ctls(BTAB_LIGHTING) = tkMainForm.bTools_ctlLighting

    'Map the settings to the tabs
    For i = 0 To UBound(g_tabMap): g_tabMap(i) = -1: Next i
    g_tabMap(BS_VECTOR) = BTAB_VECTOR
    g_tabMap(BS_PROGRAM) = BTAB_PROGRAM
    g_tabMap(BS_SPRITE) = BTAB_SPRITE
    g_tabMap(BS_IMAGE) = BTAB_IMAGE
    g_tabMap(BS_SHADING) = BTAB_LIGHTING
    g_tabMap(BS_LIGHTING) = BTAB_LIGHTING

    ' Hook scroll wheel.
    Call AttachMessage(Me, hwnd, WM_MOUSEWHEEL)
End Sub
Private Sub Form_Resize() ':on error resume next
    Call resize
    Call drawAll
End Sub
Private Sub resize() 'on error resume next
    Dim brdWidth As Long, brdHeight As Long
    
    'Available space.
    sstBoard.width = Me.width - 120
    sstBoard.Height = Me.Height - 480
    
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
        hScroll.visible = True
        hScroll.width = picBoard.width
        hScroll.max = brdWidth - picBoard.ScaleWidth
        hScroll.SmallChange = scrollUnitWidth(m_ed)
        hScroll.LargeChange = picBoard.ScaleWidth - scrollUnitWidth(m_ed)
    Else
        hScroll.visible = False
        hScroll.max = 0
        picBoard.width = picBoard.ScaleX(brdWidth, vbPixels, vbTwips)
        m_ed.pCEd.topX = 0
    End If
         
    If picBoard.ScaleY(brdHeight, vbPixels, vbTwips) > picBoard.Height Then
        picBoard.Height = picBoard.Height - (picBoard.Height Mod picBoard.ScaleY(scrollUnitHeight(m_ed), vbPixels, vbTwips))
        vScroll.visible = True
        vScroll.Height = picBoard.Height
        vScroll.max = brdHeight - picBoard.ScaleHeight
        vScroll.SmallChange = scrollUnitHeight(m_ed)
        vScroll.LargeChange = picBoard.ScaleHeight - scrollUnitHeight(m_ed)
    Else
        vScroll.visible = False
        vScroll.max = 0
        picBoard.Height = picBoard.ScaleY(brdHeight, vbPixels, vbTwips)
        m_ed.pCEd.topY = 0
    End If
    
    picBoard.Left = (sstBoard.width - (picBoard.width + IIf(vScroll.visible, vScroll.width, 0))) / 2
    picBoard.Top = (sstBoard.Height + sstBoard.TabHeight - (picBoard.Height + IIf(hScroll.visible, hScroll.Height, 0))) / 2
    hScroll.Top = picBoard.Height + picBoard.Top
    vScroll.Left = picBoard.width + picBoard.Left
    vScroll.Top = picBoard.Top
    hScroll.Left = picBoard.Left
    
End Sub
Private Sub Form_Unload(Cancel As Integer) ': On Error Resume Next
    
    If checkSave(vbYesNoCancel) = vbCancel Then
        Cancel = 1
        Exit Sub
    End If
    
    Call BRDFree(m_ed.pCBoard)
    Call hideAllTools
    
    'Clear status panels.
    tkMainForm.StatusBar1.Panels(3).Text = vbNullString
    tkMainForm.StatusBar1.Panels(4).Text = vbNullString
    
    tkMainForm.popButton(PB_TOOLBAR).visible = False         'Before Set m_sel = Nothing
    tkMainForm.pTools.visible = False
    
    Set m_sel = Nothing
    Set activeBoard = Nothing
    Set activeForm = Nothing

    ' Unhook scroll wheel.
    Call DetachMessage(Me, hwnd, WM_MOUSEWHEEL)
End Sub

'========================================================================
'========================================================================
Private Sub hScroll_Change() ': On Error Resume Next
    If LenB(hScroll.Tag) Then Exit Sub
    hScroll.value = hScroll.value - (hScroll.value Mod scrollUnitWidth(m_ed))
    m_ed.pCEd.topX = hScroll.value
    Call drawAll
End Sub

'========================================================================
'========================================================================
Public Sub openFile(ByVal file As String) ': On Error Resume Next
    
    Call activeBoard.Show
    Call checkSave(vbYesNo)
    
    Call openBoard(file, m_ed, m_ed.board(m_ed.undoIndex))
    Call assignProperties
        
    Call resetEditor(m_ed)
    Call reRenderAllLayers(True)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & brdPath, m_ed.boardName, False)
    Me.Caption = m_ed.boardName
    
    Call Form_Resize

End Sub
Public Sub saveFile() ':on error resume next

    'Ensure board dimension changes are updated if the properties tab has not been switched.
    Call sstBoard_Click(BTAB_PROPERTIES)

    ' if no filename exists, we've just created this board, so show dialog.
    If LenB(m_ed.boardName) = 0 Then
        Call saveFileAs
        Exit Sub
    End If

    'Check this isn't read-only.
    If (fileExists(projectPath & brdPath & m_ed.boardName)) Then
        If (GetAttr(projectPath & brdPath & m_ed.boardName) And vbReadOnly) Then
            Call MsgBox(m_ed.boardName & " is read-only, please choose a different filename", vbExclamation)
            Call saveFileAs
            Exit Sub
        End If
    End If

    m_ed.bUnsavedData = False
    Call saveBoard(projectPath & brdPath & m_ed.boardName, m_ed.board(m_ed.undoIndex))
    Me.Caption = m_ed.boardName

End Sub
Private Sub saveFileAs() ':on error resume next

    'Ensure board dimension changes are updated if the properties tab has not been switched.
    Call sstBoard_Click(BTAB_PROPERTIES)
    
    Dim dlg As FileDialogInfo

    dlg.strDefaultFolder = projectPath & brdPath
    dlg.strTitle = "Save Board As"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"

    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub

    'If no filename entered, exit.
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub

    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, m_ed.boardName, True) Then Exit Sub

    Call saveBoard(dlg.strDefaultFolder & m_ed.boardName, m_ed.board(m_ed.undoIndex))
    Me.Caption = m_ed.boardName
    
    m_ed.bUnsavedData = False
    Call tkMainForm.tvAddFile(dlg.strDefaultFolder & m_ed.boardName)
End Sub

Private Function checkSave(ByVal style As VbMsgBoxStyle) As VbMsgBoxResult: On Error Resume Next
    If m_ed.bUnsavedData Then
        checkSave = MsgBox("Save changes to " & Me.Caption & "?", style + vbExclamation, "Board editor")
        If checkSave = vbYes Then Call saveFile
    End If
End Function

'==========================================================================
' Get the high or low order word.
'==========================================================================
Private Function LoWord(ByRef lng As Long) As Integer
   Call CopyMemory(LoWord, ByVal VarPtr(lng), 2)
End Function
Private Function HiWord(ByRef lng As Long) As Integer
   Call CopyMemory(HiWord, ByVal (VarPtr(lng) + 2), 2)
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
        If (LoWord(wParam) And MK_CONTROL) Then
            ' Control is down: zoom.
            m_mouseScrollDistance = m_mouseScrollDistance + HiWord(wParam)

            If (Abs(m_mouseScrollDistance) >= WHEEL_DELTA) Then
                ' We've scrolled the delta distance
                
                ' Do not use lParam since it gives the absolute pixel position of the mouse
                ' on the screen; deriving the board pixel point is tedious.
                Call zoom(Sgn(m_mouseScrollDistance), m_mousePosition)

                ' Preserve any partial rotations of the wheel.
                m_mouseScrollDistance = (m_mouseScrollDistance Mod WHEEL_DELTA) * Sgn(m_mouseScrollDistance)
            End If
        Else
            ' Control is not down: scroll.

            Dim Scroll As Object ' Cannot use more specific type because there isn't one.
            Set Scroll = IIf(m_bScrollHorizontal, hScroll, vScroll)

            Dim newVal As Long
            newVal = Scroll.value - Scroll.SmallChange * HiWord(wParam) / WHEEL_DELTA
            Scroll.value = IIf(newVal < Scroll.min, Scroll.min, IIf(newVal > Scroll.max, Scroll.max, newVal))
            If (m_bScrollHorizontal) Then
                m_ed.pCEd.topX = Scroll.value
            Else
                m_ed.pCEd.topY = Scroll.value
            End If
            Call drawAll

        End If
    End If
End Function

Private Sub mnuBoard_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0:
            frmBoardPreferences.Show vbModal
        Case 1:
            'Player start location.
            tkMainForm.brdOptSetting(BS_SCROLL).value = True
            m_ed.optTool = BT_SET_PSTART
    End Select
End Sub
Private Sub mnuCoords_Click(Index As Integer): On Error Resume Next
    Call setUndo
    Select Case Index
        Case 0:
            Call Commonboard.boardToIsoRotated(m_ed, m_ed.board(m_ed.undoIndex))
            Call reRenderAllLayers(True)
            Call Form_Resize
        Case 1:
             m_ed.board(m_ed.undoIndex).coordType = m_ed.board(m_ed.undoIndex).coordType Or PX_ABSOLUTE
    End Select
    mnuCoords(Index).Enabled = False            'Only allow operation once.
    Call assignProperties                       'Update coordinate display.
End Sub

Private Sub mnuCopy_Click() ': On Error Resume Next
    'Deal with text ccp.
    If TypeOf getActiveControl Is TextBox Then
        Clipboard.clear
        Clipboard.SetText getActiveControl.SelText
        Exit Sub
    End If

    tkMainForm.brdOptTool(BT_SELECT).value = True
    Call clipCopy(g_boardClipboard, m_sel, True)
End Sub
Private Sub mnuCut_Click(): On Error Resume Next
    If TypeOf getActiveControl Is TextBox Then
        Clipboard.clear
        Clipboard.SetText getActiveControl.SelText
        getActiveControl.SelText = vbNullString
        Exit Sub
    End If

    Call setUndo
    Call clipCopy(g_boardClipboard, m_sel, True)
    Call clipCut(g_boardClipboard, True)
End Sub
Private Sub mnuExport_Click(Index As Integer): On Error Resume Next
    Call exportImage(Index)
End Sub

Private Sub mnuOpenFile_Click(Index As Integer): On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub

Private Sub mnuPaste_Click(): On Error Resume Next
    If TypeOf getActiveControl Is TextBox Then
        getActiveControl.SelText = Clipboard.GetText
        Exit Sub
    End If
    
    'Start a move, retaining selection information.
    Call setUndo
    m_sel.xDrag = m_sel.x1
    m_sel.yDrag = m_sel.y1
    m_sel.status = SS_PASTING
End Sub

Private Sub mnusave_Click(Index As Integer) ': On Error Resume Next
    Select Case Index
        Case 0: Call saveFile
        Case 1: Call saveFileAs
        Case 2: Call tkMainForm.saveallmnu_Click
    End Select
End Sub
Private Sub mnuSelectAll_Click() ': On Error Resume Next
    If m_ed.optTool <> BT_SELECT Then Exit Sub
    Select Case m_ed.optSetting
        Case BS_TILE, BS_SHADING
            Call m_sel.assign(0, 0, absWidth(m_ed.board(m_ed.undoIndex).sizex, m_ed.board(m_ed.undoIndex).coordType), absHeight(m_ed.board(m_ed.undoIndex).sizey, m_ed.board(m_ed.undoIndex).coordType))
        Case BS_VECTOR, BS_PROGRAM
            Dim r As RECT
            If currentVector Is Nothing Then Exit Sub
            Call currentVector.getBounds(r.Left, r.Top, r.Right, r.Bottom)
            Call m_sel.assign(r.Left, r.Top, r.Right, r.Bottom)
    End Select
    Call m_sel.draw(Me, m_ed.pCEd)
End Sub
Private Sub mnuUndo_Click() ': On Error Resume Next
    'Handle vector points separately - danger of loose vectors.
    If vectorUndoLastPoint Then Exit Sub
    
    m_ed.undoIndex = nextUndo
    Call toolbarRefresh
    Call reRenderAllLayers(True)
    Call assignProperties
    Call Form_Resize
    mnuUndo.Enabled = m_ed.bUndoData(nextUndo)
    mnuRedo.Enabled = True
End Sub
Private Sub mnuRedo_Click() ': On Error Resume Next
    m_ed.undoIndex = nextRedo
    Call toolbarRefresh
    Call reRenderAllLayers(True)
    Call assignProperties
    Call Form_Resize
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
    m_ed.bUnsavedData = True                    'Set to prompt to save.
End Sub
Private Function getActiveControl() As Control ':on error resume next
    'Doesn't seem to be a clean way to do this: typeOf ... is UserControl does not work.
    'Could go by activeControl.tag/.name etc., but this is fallible.
    Dim ctl As Control
    Set ctl = Screen.ActiveControl
    If TypeOf ctl Is ctlBrdImage Or TypeOf ctl Is ctlBrdSprite Or TypeOf ctl Is ctlBrdProgram Then
        Set ctl = ctl.ActiveControl
    End If
    Set getActiveControl = ctl
End Function

'========================================================================
'========================================================================
Private Sub picBoard_KeyDown(keyCode As Integer, Shift As Integer) ':on error resume next

    Dim curVector As CVector
    Set curVector = currentVector
    
    'Ctrl+letter through menus.
    If Shift And (vbCtrlMask Or vbAltMask) Then Exit Sub
    
    With tkMainForm
        Select Case keyCode
            Case vbKeyQ: .brdOptSetting(BS_SCROLL).value = True
            Case vbKeyW: .brdOptSetting(BS_ZOOM).value = True
            Case vbKeyT: .brdOptSetting(BS_TILE).value = True
            Case vbKeyV: .brdOptSetting(BS_VECTOR).value = True
            Case vbKeyP: .brdOptSetting(BS_PROGRAM).value = True
            Case vbKeyS: .brdOptSetting(BS_SPRITE).value = True
            Case vbKeyI: .brdOptSetting(BS_IMAGE).value = True
            Case vbKeyY: .brdOptSetting(BS_SHADING).value = True
            Case vbKeyU: .brdOptSetting(BS_LIGHTING).value = True
            Case vbKeyD: If .brdOptTool(BT_DRAW).Enabled Then .brdOptTool(BT_DRAW).value = True
            Case vbKeyA: If .brdOptTool(BT_SELECT).Enabled Then .brdOptTool(BT_SELECT).value = True
            Case vbKeyF: If .brdOptTool(BT_FLOOD).Enabled Then .brdOptTool(BT_FLOOD).value = True
            Case vbKeyE: If .brdOptTool(BT_ERASE).Enabled Then .brdOptTool(BT_ERASE).value = True
            Case vbKeyR: If .brdOptTool(BT_RECT).Enabled Then .brdOptTool(BT_RECT).value = True
            Case vbKeyO: If .brdOptTool(BT_DROPPER).Enabled Then .brdOptTool(BT_DROPPER).value = True
            Case vbKeyG:
                .brdChkGrid.value = IIf(.brdChkGrid.value, 0, 1)
                Call mdiChkGrid(.brdChkGrid.value)
            Case vbKeyH:
                .brdChkAutotile.value = IIf(.brdChkAutotile.value, 0, 1)
                Call mdiChkAutotile(.brdChkAutotile.value)
            Case vbKeyL
                tstFile = configfile.lastTileset
                tilesetForm.Show vbModal
            Case vbKeyJ
                .brdChkHideLayers.value = IIf(.brdChkHideLayers.value, 0, 1)
                Call mdiChkHideLayers(.brdChkHideLayers.value, True)
            Case vbKeyK
                .brdChkShowLayers.value = IIf(.brdChkShowLayers.value, 0, 1)
                Call mdiChkShowLayers(.brdChkShowLayers.value, True)
            
            Case vbKeyDelete, vbKeyBack:
                Select Case m_ed.optSetting
                    Case BS_VECTOR, BS_PROGRAM
                        If (m_sel.status <> SS_DRAWING) Then Call vectorDeleteSelection(m_sel)
                    Case BS_TILE, BS_SHADING
                        'Create a local clipboard and cut to it.
                        Dim clip As TKBoardClipboard
                        Call setUndo
                        Call clipCopy(clip, m_sel, True)
                        Call clipCut(clip, True)
                    Case BS_SPRITE
                        Call spriteDeleteCurrent(toolbarGetIndex(BS_SPRITE))
                    Case BS_IMAGE
                        Call imageDeleteCurrent(toolbarGetIndex(BS_IMAGE))
                    Case BS_LIGHTING
                        Call lightingDeleteCurrent
                End Select 'Setting (Delete, Backspace)
                
        End Select 'Key
    End With

    Select Case m_ed.optSetting
        Case BS_VECTOR, BS_PROGRAM
            Select Case keyCode
                Case vbKeyZ
                    Call vectorSubdivideSelection(m_sel)
                Case vbKeyX
                    Call vectorExtendSelection(m_sel)
                Case vbKeyEscape
                    If (m_ed.optTool = BT_DRAW And m_sel.status = SS_DRAWING) And (Not curVector Is Nothing) Then
                        Call m_sel.clear(Me)
                        If Not curVector.closeVector(Shift, m_ed.currentLayer) Then
                            'Delete vector.
                            Set curVector = Nothing
                            Call vectorDeleteCurrent(m_ed.optSetting)
                        Else
                            Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, g_CBoardPreferences.bShowVectorIndices, True)
                        End If
                    End If
            End Select 'Key
            
            Call toolbarRefresh

        Case BS_TILE, BS_SHADING
            Select Case keyCode
                Case vbKeyEscape
                    Call m_sel.clear(Me)
            End Select 'Key

    End Select 'Setting
End Sub
Private Sub picBoard_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
       
    Dim pxCoord As POINTAPI, curVector As CVector
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    Set curVector = currentVector
    
    'Switch mousewheel scrolling axis by clicking the mousewheel button.
    If Button = vbMiddleButton Then m_bScrollHorizontal = (Not m_bScrollHorizontal): Exit Sub
    
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
                                Case BS_TILE, BS_SHADING
                                    Call setUndo
                                    pxCoord = snapToGrid(pxCoord)
                                    g_boardClipboard.origin.x = m_sel.x1        'Prepare a copy.
                                    g_boardClipboard.origin.y = m_sel.y1
                                    
                                Case BS_VECTOR, BS_PROGRAM, BS_LIGHTING
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
                            Dim img As TKBoardImage, Index  As Long
                            Select Case m_ed.optSetting
                                Case BS_TILE, BS_VECTOR, BS_PROGRAM, BS_SHADING, BS_LIGHTING
                                    'Start new selection.
                                    'CBoardSlection stores board pixel coordinate.
                                    Call m_sel.restart(pxCoord.x, pxCoord.y)
                                Case BS_SPRITE
                                    'Start moving the selected sprite.
                                    If imageHitTest(pxCoord.x, pxCoord.y, Index, img, m_ed.board(m_ed.undoIndex).spriteImages) Then
                                        Call toolbarChange(Index, m_ed.optSetting)
                                        Call m_sel.assign(img.bounds.Left, img.bounds.Top, img.bounds.Right, img.bounds.Bottom)
                                    End If
                                Case BS_IMAGE
                                    If imageHitTest(pxCoord.x, pxCoord.y, Index, img, m_ed.board(m_ed.undoIndex).Images) Then
                                        Call toolbarChange(Index, m_ed.optSetting)
                                        Call m_sel.assign(img.bounds.Left, img.bounds.Top, img.bounds.Right, img.bounds.Bottom)
                                    End If
                            End Select
                        End If
                        
                    Case SS_DRAWING
                        m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                        Call m_sel.draw(Me, m_ed.pCEd)
                        
                    Case SS_MOVING, SS_PASTING
                        Select Case m_ed.optSetting
                            Case BS_TILE, BS_SHADING
                                pxCoord = snapToGrid(pxCoord)
                            Case BS_VECTOR, BS_PROGRAM, BS_IMAGE, BS_LIGHTING
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
                            Case BS_VECTOR, BS_PROGRAM, BS_LIGHTING
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
        Case BS_SCROLL
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
        Case BS_SHADING
            Call setUndo
            Call shadingSettingMouseDown(Button, Shift, x, y)
        Case BS_LIGHTING
            Call setUndo
            Call lightingCreate(m_ed.board(m_ed.undoIndex), pxCoord.x, pxCoord.y)
            Call reRenderAllLayers(False)
            Call drawAll
    End Select
End Sub
Private Sub picBoard_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim pxCoord As POINTAPI, tileCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    m_mousePosition = pxCoord
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    tkMainForm.StatusBar1.Panels(3).Text = CStr(tileCoord.x) & ", " & CStr(tileCoord.y) & " : " & CStr(pxCoord.x) & ", " & CStr(pxCoord.y)
    
    If Button = vbMiddleButton Then Exit Sub
    
    If m_sel.status = SS_DRAWING Or m_sel.status = SS_MOVING Then
        'Scroll the board to expand selection.
        If x > picBoard.ScaleWidth - 8 And hScroll.value <> hScroll.max And hScroll.visible Then hScroll.value = hScroll.value + hScroll.SmallChange
        If x < 8 And hScroll.value <> hScroll.min Then hScroll.value = hScroll.value - hScroll.SmallChange
        If y > picBoard.ScaleHeight - 8 And vScroll.value <> vScroll.max And vScroll.visible Then vScroll.value = vScroll.value + vScroll.SmallChange
        If y < 8 And vScroll.value <> vScroll.min Then vScroll.value = vScroll.value - vScroll.SmallChange
    End If
      
    Select Case m_ed.optTool
        Case BT_SELECT, BT_IMG_TRANSP, BT_RECT
            If Button Or m_sel.status = SS_PASTING Then Call picBoard_MouseDown(Button, Shift, x, y)
            Exit Sub
    End Select
    
    Select Case m_ed.optSetting
        Case BS_SCROLL
            'Move the board by dragging.
            If Button = vbLeftButton And (hScroll.visible Or vScroll.visible) Then
                Dim dx As Long, dy As Long, hx As Long, hy As Long, tX As Long, tY As Long
                dx = m_sel.xDrag - x:           dy = m_sel.yDrag - y
                hx = scrollUnitWidth(m_ed) / 2
                hy = scrollUnitHeight(m_ed) / 2
                tX = val(hScroll.Tag):          tY = val(vScroll.Tag)
                'Clear the tag since it is also used to prevent unwanted scrolling.
                hScroll.Tag = vbNullString:     vScroll.Tag = vbNullString
                
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
                
                'Hold the unrounded value in the tag.
                m_sel.xDrag = x:                m_sel.yDrag = y
                hScroll.Tag = tX:               vScroll.Tag = tY
            End If
            
        Case BS_TILE
            If Button Then Call tileSettingMouseDown(Button, Shift, x, y)
            
        Case BS_VECTOR, BS_PROGRAM
            If (m_ed.optTool = BT_DRAW And m_sel.status = SS_DRAWING) Then
                
                'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = ((Shift And vbCtrlMask) <> 0) Then pxCoord = snapToGrid(pxCoord, , False)
                If (Shift And vbShiftMask) Then pxCoord = snapToAxis(pxCoord, m_sel.x1, m_sel.y1)

                m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                Call m_sel.drawLine(Me, m_ed.pCEd)
            End If
            
        Case BS_SHADING
            If Button Then Call shadingSettingMouseDown(Button, Shift, x, y)
    End Select
End Sub
Private Sub picBoard_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single) ':on error resume next
    
    Dim pxCoord As POINTAPI, i As Long
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    
    If Button <> vbLeftButton Then Exit Sub
            
    Select Case m_ed.optTool
        Case BT_DRAW
            If m_ed.optSetting = BS_SCROLL Then
                'Clear the scroll bar tags, which were used to scroll the board by dragging.
                hScroll.Tag = vbNullString
                vScroll.Tag = vbNullString
            End If
                
        Case BT_SELECT
            Select Case m_ed.optSetting
                Case BS_TILE, BS_SHADING
                    Select Case m_sel.status
                        Case SS_DRAWING
                            Call m_sel.expandToGrid(m_ed.board(m_ed.undoIndex).coordType, m_ed.board(m_ed.undoIndex).sizex)
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
                    
                Case BS_LIGHTING
                    'Click only: select the nearest vector.
                    If m_sel.isEmpty Then
                        Call vectorSetCurrent(m_sel)
                        Call m_sel.clear(Me)
                        Call toolbarRefresh
                        Exit Sub
                    Else
                        'Redraw the light.
                        Call reRenderAllLayers(False)
                        Call drawBoard
                    End If
                    Call toolbarRefresh
            End Select
            
            Call m_sel.reorientate
            m_sel.status = SS_FINISHED
            Call m_sel.draw(Me, m_ed.pCEd)
            
        Case BT_RECT
            Select Case m_ed.optSetting
                Case BS_TILE
                    m_ed.bLayerOccupied(0) = True
                    m_ed.bLayerOccupied(m_ed.currentLayer) = True
                    
                    Call tileDrawRect(m_sel, Shift)
                    Call m_sel.clear(Me)
                    
                    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
                    Call drawBoard
                    
                Case BS_VECTOR, BS_PROGRAM
                    Call vectorCreateRect(m_sel)
                    
                Case BS_SHADING
                    Call shadingDrawRect(m_sel, Shift)
                    Call m_sel.clear(Me)
                    
                    Call reRenderAllLayers(False)
                    Call drawBoard
            End Select
            
        Case BT_DROPPER
            Call boardPixelToTile(pxCoord.x, pxCoord.y, False)
            If m_ed.optSetting = BS_TILE Then
                Call changeSelectedTile(boardGetTile(pxCoord.x, pxCoord.y, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))
            Else
                'Lighting.
                m_ed.currentShade = m_ed.board(m_ed.undoIndex).tileShading(0).values(pxCoord.x, pxCoord.y)
                Call m_ctls(BTAB_LIGHTING).currentShade(m_ed.currentShade.r, m_ed.currentShade.g, m_ed.currentShade.b)
            End If
            
            'Revert to draw.
            m_ed.optTool = BT_DRAW
            tkMainForm.brdOptTool(m_ed.optTool).value = True
        
        Case BT_IMG_TRANSP
            'Reset the tool.
            Call mdiOptTool(BT_DRAW)
            tkMainForm.bTools_ctlImage.getChkTransp.value = 0
            Call imageApply(toolbarGetIndex(BS_IMAGE))
            Call drawAll
            
        Case BT_SET_PSTART
            If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord, True)
            m_ed.board(m_ed.undoIndex).startX = pxCoord.x
            m_ed.board(m_ed.undoIndex).startY = pxCoord.y
            m_ed.board(m_ed.undoIndex).startL = m_ed.currentLayer
            Call mdiOptTool(BT_DRAW)
            
            If drawStartPosition = False Then MsgBox "Use the board preferences to display the start location " & vbCrLf & "when the board is not the start (initial) board", vbInformation
            Call drawAll
    End Select
         
End Sub
Private Function snapToGrid(ByRef pxCoord As POINTAPI, Optional ByVal bAddBasePoint As Boolean = False, Optional ByVal bToIsoCentre As Boolean = True) As POINTAPI: On Error Resume Next
    Dim pt As POINTAPI
    pt = pxCoord
    pt = modBoard.boardPixelToTile(pt.x, pt.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    snapToGrid = modBoard.tileToBoardPixel(pt.x, pt.y, m_ed.board(m_ed.undoIndex).coordType, bAddBasePoint, m_ed.board(m_ed.undoIndex).sizex)
    
    If (Not bToIsoCentre) And isIsometric Then
        'Align the rect to the grid (tileToBoardPixel() returns the centre of isometric tiles).
        snapToGrid.x = snapToGrid.x - 32
    End If
End Function
Private Function snapToAxis(ByRef pt As POINTAPI, ByVal x1 As Long, ByVal y1 As Long) As POINTAPI: On Error Resume Next
    Dim iso As Long, dx As Long, dy As Long
    snapToAxis = pt
    iso = IIf(isIsometric, 2, 1)
    
    'x1, y1 are the start coordinates of the line.
    dx = pt.x - x1
    dy = pt.y - y1
    
    If Abs(dx) > Abs(dy) Then
        snapToAxis.y = IIf(Abs(dx) > 2 * iso * Abs(dy), y1, y1 + Abs(dx / iso) * Sgn(dy))
    Else
        snapToAxis.x = IIf(Abs(dy) > 2 * iso * Abs(dx), x1, x1 + Abs(dy * iso) * Sgn(dx))
    End If
End Function

'========================================================================
'========================================================================
Private Sub vScroll_Change() ': On Error Resume Next
    If LenB(vScroll.Tag) Then Exit Sub
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
        If m_ed.pCEd.zoom > 4 Then m_ed.pCEd.zoom = 4: Exit Sub
    Else
        m_ed.pCEd.zoom = m_ed.pCEd.zoom - IIf(m_ed.pCEd.zoom > 1, 0.5, 0.25)
        If m_ed.pCEd.zoom < 0.25 Then m_ed.pCEd.zoom = 0.25: Exit Sub
    End If
        
    'Prevent _Change() events on the scroll bars induced by setting .value
    hScroll.Tag = "1": vScroll.Tag = "1"
    
    hScroll.SmallChange = modBoard.scrollUnitWidth(m_ed)
    vScroll.SmallChange = modBoard.scrollUnitHeight(m_ed)
    
    'Scale topX,Y via true values using oldZoom.
    m_ed.pCEd.topX = (m_ed.pCEd.topX / oldZoom) * m_ed.pCEd.zoom
    m_ed.pCEd.topY = (m_ed.pCEd.topY / oldZoom) * m_ed.pCEd.zoom
    Call resize
    
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
    hScroll.Tag = vbNullString: vScroll.Tag = vbNullString
    m_ed.pCEd.topX = h
    m_ed.pCEd.topY = v
    Call drawAll
    
    'Display the zoom level.
    tkMainForm.StatusBar1.Panels(4).Text = "Zoom: " & str(m_ed.pCEd.zoom * 100) & "%"

End Sub

'========================================================================
'========================================================================
Public Sub drawAll() ':on error resume next
    Call drawBoard
    
    'Update line controls.
    If m_ed.optTool = BT_SELECT Then Call m_sel.draw(Me, m_ed.pCEd)
End Sub

'========================================================================
'========================================================================
Private Sub drawGrid() ': On Error Resume Next
    If m_ed.bGrid Then
        Call modBoard.gridDraw( _
            picBoard, _
            m_ed.pCEd, _
            isIsometric, _
            modBoard.tileWidth(m_ed), _
            modBoard.tileHeight(m_ed) _
        )
    End If
End Sub

'=========================================================================
'=========================================================================
Private Sub drawBoard(Optional ByVal bRefresh As Boolean = True) ': On Error Resume Next
    picBoard.AutoRedraw = True
    Call BRDDraw( _
        VarPtr(m_ed), _
        VarPtr(m_ed.board(m_ed.undoIndex)), _
        picBoard.hdc, _
        0, 0, _
        screenToBoardPixel(0, 0, m_ed.pCEd).x, _
        screenToBoardPixel(0, 0, m_ed.pCEd).y, _
        CLng(picBoard.ScaleWidth), _
        CLng(picBoard.ScaleHeight), _
        m_ed.pCEd.zoom _
    )

    If bRefresh Then
        'Update the background image dimensions here because the
        'image's bounds are assigned only when it is drawn.
        If LenB(m_ed.board(m_ed.undoIndex).bkgImage.filename) Then
            lblProperties(5).Caption = "Background image (" & CStr(m_ed.board(m_ed.undoIndex).bkgImage.bounds.Right) & " x " & CStr(m_ed.board(m_ed.undoIndex).bkgImage.bounds.Bottom) & ")"
        End If
        Call vectorDrawAll
        Call spriteHighlightSelected
        Call imageHighlightSelected
        Call drawStartPosition
        Call drawGrid
        picBoard.Refresh
    End If
End Sub

Private Function drawStartPosition() As Boolean ':on error resume next
    
    'Do not show if undefined.
    If m_ed.board(m_ed.undoIndex).startX = 0 And m_ed.board(m_ed.undoIndex).startY = 0 Then Exit Function
    'Show if is initial board or 'hide start location if not initial board' option disabled.
    If g_CBoardPreferences.bHideStartLocation And mainMem.initBoard <> m_ed.boardName And m_ed.boardName <> vbNullString Then Exit Function

    Dim p As POINTAPI
    p = modBoard.boardPixelToScreen(m_ed.board(m_ed.undoIndex).startX, m_ed.board(m_ed.undoIndex).startY, m_ed.pCEd)
    
    picBoard.currentX = p.x + 1
    picBoard.currentY = p.y
    picBoard.ForeColor = g_CBoardPreferences.pStartColor
    picBoard.Print "Player start location layer " & CStr(m_ed.board(m_ed.undoIndex).startL)
    
    picBoard.Line (p.x, p.y - 8)-(p.x, p.y + 8), g_CBoardPreferences.pStartColor, B
    picBoard.Line (p.x - 8, p.y)-(p.x + 8, p.y), g_CBoardPreferences.pStartColor, B

    drawStartPosition = True

End Function

'========================================================================
' Redraw all tiles at a single position
'========================================================================
Private Sub drawStack(ByVal x As Long, ByVal y As Long, ByVal z As Long) ':on error resume next

    'Get board pixel _drawing_ coordinate from tile.
    Dim brdPt As POINTAPI, scrPt As POINTAPI
    brdPt = modBoard.tileToBoardPixel(x, y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex, True)
    scrPt = boardPixelToScreen(brdPt.x, brdPt.y, m_ed.pCEd)

    Call BRDRenderStack( _
        m_ed.pCBoard, _
        VarPtr(m_ed.board(m_ed.undoIndex)), _
        VarPtr(m_ed), _
        picBoard.hdc, _
        x, y _
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

Private Sub exportImage(ByVal Index As Long) ':on error resume next
    Dim hdc As Long, bmp As Long, obj As Long, width As Long, Height As Long
    Dim dlg As FileDialogInfo

    dlg.strDefaultFolder = projectPath & bmpPath
    dlg.strTitle = "Export Image"
    dlg.strDefaultExt = "png"
    dlg.strFileTypes = "JPEG - JFIF Compliant (*.jpg)|*.jpg|Portable Network Graphics (*.png)|*.png|Windows Bitmap (*.bmp)|*.bmp|All files (*.*)|*.*"

    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
        
    If Index = 0 Then
        'Visible area.
        width = picBoard.ScaleWidth
        Height = picBoard.ScaleHeight
    Else
        'Whole board.
        width = absWidth(m_ed.board(m_ed.undoIndex).sizex, m_ed.board(m_ed.undoIndex).coordType)
        Height = absHeight(m_ed.board(m_ed.undoIndex).sizey, m_ed.board(m_ed.undoIndex).coordType)
    End If
            
    'Create compatible dc.
    hdc = CreateCompatibleDC(picBoard.hdc)
    
    'Create a BITMAP.
    bmp = CreateCompatibleBitmap(picBoard.hdc, width, Height)
        
    If bmp Then
        'Select the bitmap into the dc.
        obj = SelectObject(hdc, bmp)
        
        If Index = 0 Then
            'Blt the PictureBox contents.
            Call BitBlt(hdc, 0, 0, width, Height, picBoard.hdc, 0, 0, SRCCOPY)
        Else
            'Draw board to hdc.
            Call BRDDraw(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), hdc, 0, 0, 0, 0, width, Height, 1#)
        End If
        
        'Select out the bitmap, return the previous contents.
        Call SelectObject(hdc, obj)
        
        If IMGExport(bmp, dlg.strSelectedFile) = 0 Then MsgBox "Unable to generate image, try another format", vbExclamation
        Call DeleteObject(bmp)
    End If
    
    Call DeleteObject(hdc)
    
End Sub

'========================================================================
' Destroy layer canvases to rerender all layers in actkrt
'========================================================================
Public Sub reRenderAllLayers(ByVal destroyCanvas As Boolean): On Error Resume Next
    'Only really need to destroy canvases when resizing is required.
    Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, destroyCanvas)
End Sub

'========================================================================
'========================================================================
Public Sub mdiChkAutotile(ByVal value As Integer) ':on error resume next
    m_ed.bAutotiler = (value <> 0)
End Sub
Public Sub mdiOptSetting(ByVal Index As Integer) ': On Error Resume Next
    m_ed.optSetting = Index
    If Not (m_sel Is Nothing) Then Call m_sel.clear(Me)

    'Revert to select when changing tool, since a tool may be selected that becomes disabled.
    Dim optTool As eBrdTool
    optTool = IIf(Index <= BS_ZOOM, BT_DRAW, BT_SELECT)
    tkMainForm.brdOptTool(optTool).value = True
    Call toolsRefresh
    
    'Switch the object toolbar pane.
    If g_tabMap(Index) <> -1 Then tkMainForm.bTools_Tabs.Tab = g_tabMap(Index)
    Call toolbarRefresh
    Call drawBoard
End Sub
Public Sub mdiOptTool(ByVal Index As Integer) ': On Error Resume Next
    m_ed.optTool = Index
    If (Index <> BT_SELECT) And Not (m_sel Is Nothing) Then Call m_sel.clear(Me)
End Sub
Public Sub mdiChkGrid(ByVal value As Integer) ': On Error Resume Next
    m_ed.bGrid = value
    Call drawBoard
End Sub
Public Sub mdiChkHideLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    m_ed.bHideAllLayers = CBool(value)
    If value Then
        For i = 1 To m_ed.board(m_ed.undoIndex).sizeL
            If i <> m_ed.currentLayer Then m_ed.bLayerVisible(i) = False
        Next i
        tkMainForm.brdChkShowLayers.value = 0
        m_ed.bShowAllLayers = False
    Else
        'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiChkShowLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    m_ed.bShowAllLayers = CBool(value)
    If value Then
        For i = 1 To m_ed.board(m_ed.undoIndex).sizeL
            m_ed.bLayerVisible(i) = True
        Next i
        tkMainForm.brdChkHideLayers.value = 0
        m_ed.bHideAllLayers = False
    Else
         'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiCmbCurrentLayer(ByVal layer As Long) ':on error resume next
    'Hide the current layer if 'Hide all layers' selected.
    If m_ed.bHideAllLayers Then m_ed.bLayerVisible(m_ed.currentLayer) = False
    m_ed.currentLayer = layer
    m_ed.bLayerVisible(layer) = True
    tkMainForm.brdCmbVisibleLayers.List(layer) = CStr(layer) & " *"
    Call drawAll
End Sub
Public Sub mdiCmbVisibleLayers() ':on error resume next
    'Invert the selected layer.
    Dim Text As String, i As Integer, layer As String
    With tkMainForm.brdCmbVisibleLayers
        If (.ListIndex >= 0) Then
            Text = .List(.ListIndex)
            i = .ListIndex
            If (Right$(Text, 1) = "*" And i <> m_ed.currentLayer) Then
                'Do not disable current layer.
                .List(.ListIndex) = CStr(i)
                'Do not alter the layer list if an override check button is down.
                If (m_ed.bShowAllLayers = m_ed.bHideAllLayers) Then m_ed.bLayerVisible(i) = False
            Else
                .List(.ListIndex) = CStr(i) & " *"
                'Do not alter the layer list if an override check button is down.
                If (m_ed.bShowAllLayers = m_ed.bHideAllLayers) Then m_ed.bLayerVisible(i) = True
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
    For i = 1 To tkMainForm.brdCmbVisibleLayers.ListCount - 1
        'Zeroth list entry is the background.
        m_ed.bLayerVisible(i) = (Right$(tkMainForm.brdCmbVisibleLayers.List(i), 1) = "*")
    Next i
End Sub

'=========================================================================
'=========================================================================
Private Sub resetLayerCombos() ':on error resume next
    tkMainForm.brdCmbCurrentLayer.clear
    tkMainForm.brdCmbVisibleLayers.clear
    Call tkMainForm.brdCmbVisibleLayers.AddItem("B *", 0)
    Dim i As Integer, Text As String
    For i = 1 To m_ed.board(m_ed.undoIndex).sizeL
        Call tkMainForm.brdCmbVisibleLayers.AddItem(IIf(m_ed.bLayerVisible(i), CStr(i) & " *", CStr(i)))
        Call tkMainForm.brdCmbCurrentLayer.AddItem(CStr(i))
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
    
    currentAutotileset = autoTileset(tilesetFilename(boardGetTile(tileX, tileY, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
    
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
                thisAutoTileset = autoTileset(tilesetFilename(boardGetTile(ix, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
                
                'If shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'The 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'Check if the tile should link to the cardinal directions
                    If iy Mod 2 = 0 Then
                        'Even row
                        If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix - 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix - 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    Else
                        'Odd row
                        If (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix + 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix + 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    End If
                    
                    'Check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (autoTileset(tilesetFilename(boardGetTile(ix - 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (iy > 2) And (autoTileset(tilesetFilename(boardGetTile(ix, iy - 2, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (iy < brdHeight - 1) And (autoTileset(tilesetFilename(boardGetTile(ix, iy + 2, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    If (ix < brdWidth) And (autoTileset(tilesetFilename(boardGetTile(ix + 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                
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
                thisAutoTileset = autoTileset(tilesetFilename(boardGetTile(ix, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))))
                
                'If shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'The 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'Check if the tile should link to the cardinal directions
                    If (ix > 1) And autoTileset(tilesetFilename(boardGetTile(ix - 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_W
                    If (iy > 1) And autoTileset(tilesetFilename(boardGetTile(ix, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_N
                    If (iy < brdHeight) And autoTileset(tilesetFilename(boardGetTile(ix, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_S
                    If (ix < brdWidth) And autoTileset(tilesetFilename(boardGetTile(ix + 1, iy, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_E
                     
                    'Check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix - 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix - 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(boardGetTile(ix + 1, iy - 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                    If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(boardGetTile(ix + 1, iy + 1, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    
                    'Draw and set the new tile
                    Call placeTile(autoTilerSets(thisAutoTileset) & CStr(tileMorphs(morphTileIndex)), ix, iy)
                End If
            Next ix
        Next iy
    End If
    
    Call picBoard.Refresh
End Sub

'========================================================================
' TILE FUNCTIONS
'========================================================================
' Add a tile to the board. x, y as tile coords.
'========================================================================
Private Sub placeTile(file As String, x As Long, y As Long) ': On Error Resume Next

    'Get board pixel _drawing_ coordinate from tile.
    Dim brdPt As POINTAPI, scrPt As POINTAPI
    brdPt = modBoard.tileToBoardPixel(x, y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex, True)
    scrPt = boardPixelToScreen(brdPt.x, brdPt.y, m_ed.pCEd)
    
    'Check if this tile is already inserted.
    If boardGetTile(x, y, m_ed.currentLayer, m_ed.board(m_ed.undoIndex)) = file Then Exit Sub
    
    'Insert the selected tile into the board array.
    Call boardSetTile( _
        x, y, _
        m_ed.currentLayer, _
        file, _
        m_ed.board(m_ed.undoIndex) _
    )
    Call drawStack(x, y, m_ed.currentLayer)
End Sub

'========================================================================
'========================================================================
Private Sub tileSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next

    Dim tileCoord As POINTAPI, pxCoord As POINTAPI, tool As eBrdTool
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)

    If tileCoord.x > m_ed.effectiveBoardX Or tileCoord.y > m_ed.effectiveBoardY Then Exit Sub

    'Allow right-click in draw mode to erase tile.
    tool = IIf(m_ed.optTool = BT_DRAW And Button = vbRightButton, BT_ERASE, m_ed.optTool)
    
    Select Case tool
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
                If (m_ed.board(m_ed.undoIndex).sizex - 1) < width Then width = (m_ed.board(m_ed.undoIndex).sizex - 1)
                If (m_ed.board(m_ed.undoIndex).sizey - 1) < Height Then Height = (m_ed.board(m_ed.undoIndex).sizey - 1)
                                   
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
                If g_CBoardPreferences.bUseRecursiveFlooding Then
                    'User has enabled recursive flooding - when gdi doesn't work.
                    Call tileFloodRecursive(tileCoord.x, tileCoord.y, m_ed.currentLayer, m_ed.selectedTile)
                Else
                    'Use gdi if no setting exists (default).
                    Call tileFloodGdi(tileCoord.x, tileCoord.y, m_ed.currentLayer, m_ed.selectedTile)
                End If
            End If
            If (g_CBoardPreferences.bRevertToDraw) Then
                m_ed.optTool = BT_DRAW
                tkMainForm.brdOptTool(m_ed.optTool).value = True
            End If
            
            Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
            Call drawBoard
            
        Case BT_ERASE
            eo = 0 'TBD: isometric even-odd
            If m_ed.bAutotiler Then
                Call autoTilerPutTile(vbNullString, tileCoord.x, tileCoord.y, m_ed.board(m_ed.undoIndex).coordType, eo, ((Shift And vbShiftMask) = vbShiftMask))
            Else
                Call placeTile(vbNullString, tileCoord.x, tileCoord.y)
            End If
            
        Case BT_RECT
            If LenB(m_ed.selectedTile) = 0 Then Exit Sub
            If m_ed.bAutotiler Then
                MsgBox "The rectangle tool is disabled in AutoTiler mode!"
                Exit Sub
            End If
            
            If m_sel.status <> SS_DRAWING Then
                Call m_sel.restart(pxCoord.x, pxCoord.y)
            Else
                m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                Call m_sel.drawProjectedRect(Me, m_ed.pCEd, m_ed.board(m_ed.undoIndex).coordType)
            End If
            
    End Select
End Sub

'==============================================================================
' Fill board with selected tile
' Optional from 3.0.6: crashes on large boards (>~ 100 x 100) - use gdi instead!
' Menu options in tile / board editor
'==============================================================================
Private Sub tileFloodRecursive(ByVal x As Long, ByVal y As Long, ByVal l As Long, ByVal tileFile As String, Optional ByVal lastX As Long = -1, Optional ByVal lastY As Long = -1): On Error Resume Next
    
    Dim replaceTile As Long, newTile As Long
    replaceTile = m_ed.board(m_ed.undoIndex).board(x, y, l)
    newTile = boardTileInLut(tileFile, m_ed.board(m_ed.undoIndex))
    
    ' check if old and new tile are the same.
    If replaceTile = newTile Then Exit Sub
        
    ' enter the tile data of the copying tile.
    m_ed.board(m_ed.undoIndex).board(x, y, l) = newTile
    
    Dim sizex As Long, sizey As Long, x2 As Long, y2 As Long
    sizex = m_ed.effectiveBoardX
    sizey = m_ed.effectiveBoardY
    
    'new x and y position
    x2 = x + 1: y2 = y
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        ' if old tile is the same as replaced tile
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call tileFloodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y - 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call tileFloodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x - 1: y2 = y
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call tileFloodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y + 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_ed.board(m_ed.undoIndex).board(x2, y2, l) = replaceTile Then Call tileFloodRecursive(x2, y2, l, tileFile, x, y)
    End If
    
End Sub

'========================================================================
' Fill board with selected tile - using gdi (added for 3.0.6)
'========================================================================
Private Sub tileFloodGdi(ByVal xLoc As Long, ByVal yLoc As Long, ByVal layer As Long, ByVal tileFilename As String) ': On Error Resume Next

    Const ISO_EDGE As Integer = 32767

    With m_ed.board(m_ed.undoIndex)
    
        Dim curIdx As Long, newIdx As Long
        'The tile we clicked to flood and the tile we want to flood it with.
        curIdx = .board(xLoc, yLoc, layer)
        newIdx = boardTileInLut(tileFilename, m_ed.board(m_ed.undoIndex))
        
        If curIdx = newIdx Then Exit Sub
        
        'Draw the board onto a canvas.
        'Use a different colour for each tile, by its LUT entry.
        
        Dim cnv As Long, width As Long, Height As Long
        width = m_ed.effectiveBoardX
        Height = m_ed.effectiveBoardY
        cnv = createCanvas(width + 1, Height + 1)
        
        Dim x As Long, y As Long
        For x = 0 To width
            For y = 0 To Height
                If modBoard.isoOffEdge(x, y, m_ed.board(m_ed.undoIndex)) Or x = 0 Or y = 0 Then
                    'Block off invisible edges.
                    Call canvasSetPixel(cnv, x, y, ISO_EDGE)
                Else
                    'Set a pixel per tile, an empty tile is represented as 0 (black).
                    Call canvasSetPixel(cnv, x, y, .board(x, y, layer))
                End If
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
            
        'Copy the flooded image back to the board.
        For x = 1 To width
            For y = 1 To Height
                .board(x, y, layer) = canvasGetPixel(cnv, x, y)
                
                'Remove isometric rotated block.
                If .board(x, y, layer) = ISO_EDGE Then .board(x, y, layer) = 0
            Next y
        Next x
        
        Call destroyCanvas(cnv)                         'Destroy the canvas.
        
    End With
End Sub

Private Sub tileDrawRect(ByRef sel As CBoardSelection, ByVal Shift As Integer) ':on error resume next
    Dim Index As Integer, i As Long, j As Long, p1 As POINTAPI, p2 As POINTAPI
    'sel.x,y doesn't seem to like byRef.
    p1 = modBoard.boardPixelToTile(sel.x1, sel.y1, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    p2 = modBoard.boardPixelToTile(sel.x2, sel.y2, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    Index = boardTileInLut(m_ed.selectedTile, m_ed.board(m_ed.undoIndex))
    
    'Reorientate
    i = p1.x: j = p1.y
    If p1.x > p2.x Then p1.x = p2.x: p2.x = i
    If p1.y > p2.y Then p1.y = p2.y: p2.y = j
    
    For i = p1.x To p2.x
        For j = p1.y To p2.y
            If Shift Or ((i = p1.x Or i = p2.x) Or (j = p1.y Or j = p2.y)) Then
                m_ed.board(m_ed.undoIndex).board(i, j, m_ed.currentLayer) = Index
            End If
        Next j
    Next i
    
End Sub

'========================================================================
' COLLISION VECTOR, PROGRAM and LIGHTING VECTOR FUNCTIONS
'========================================================================
Private Sub vectorSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim tileCoord As POINTAPI, pxCoord As POINTAPI, curVector As CVector
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    Set curVector = currentVector

    Select Case m_ed.optTool
        Case BT_DRAW
            If Button = vbLeftButton Then
                
                If m_sel.status <> SS_DRAWING Then
                    If (Not curVector Is Nothing) And (Shift And vbAltMask) Then
                        'Determine action depending on nearest point or line.
                        Dim Continue As Boolean
                        
                        'Reacquire the current vector.
                        Call setUndo
                        Set curVector = currentVector
                        
                        Continue = curVector.interpretAction(pxCoord.x, pxCoord.y, m_ed.optSetting)
                        Call drawBoard
                        If Not Continue Then Exit Sub
                    Else
                        'Start a new vector.
                        Call setUndo
                        Set curVector = vectorCreate(m_ed.optSetting, m_ed.board(m_ed.undoIndex), m_ed.currentLayer)
                        Call drawBoard
                    End If
                End If
                        
                'Add a new point.
                
                'Snap if in pixels and a shift state exists or if in tiles and no shift state exists.
                If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = ((Shift And vbCtrlMask) <> 0) Then pxCoord = snapToGrid(pxCoord, , False)
                If (Shift And vbShiftMask) Then pxCoord = snapToAxis(pxCoord, m_sel.x1, m_sel.y1)
                
                'CBoardSlection stores board pixel coordinate.
                Call m_sel.restart(pxCoord.x, pxCoord.y)
                
                Call curVector.addPoint(pxCoord.x, pxCoord.y)
                Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, g_CBoardPreferences.bShowVectorIndices, True)
            Else
                'Finish the vector.
                If curVector Is Nothing Then Exit Sub
                Call m_sel.clear(Me)
                If Not curVector.closeVector(Shift, m_ed.currentLayer) Then
                    'Delete vector.
                    Set curVector = Nothing
                    Call vectorDeleteCurrent(m_ed.optSetting)
                Else
                    Call curVector.draw(picBoard, m_ed.pCEd, vectorGetColor, g_CBoardPreferences.bShowVectorIndices, True)
                End If
                Call toolbarRefresh
            End If
        Case BT_RECT
            If ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) <> 0) = (Shift <> 0) Then pxCoord = snapToGrid(pxCoord, , False)
            If m_sel.status <> SS_DRAWING Then
                Call m_sel.restart(pxCoord.x, pxCoord.y)
            Else
                m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                Call m_sel.drawProjectedRect(Me, m_ed.pCEd, m_ed.board(m_ed.undoIndex).coordType)
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
        Case BS_LIGHTING
            For i = 0 To UBound(m_ed.board(m_ed.undoIndex).lights)
                ReDim Preserve m_ed.currentVectorSet(i)
                If m_ed.board(m_ed.undoIndex).lights(i) Is Nothing Then
                    Set m_ed.currentVectorSet(i) = Nothing
                Else
                    Set m_ed.currentVectorSet(i) = m_ed.board(m_ed.undoIndex).lights(i).nodes
                End If
            Next i
    End Select
End Sub
Private Sub vectorCreateRect(ByRef sel As CBoardSelection) ':on error resum next
    If sel.isEmpty Then Exit Sub
    Dim i As Long, pts() As POINTAPI, vect As CVector
    
    Call setUndo
    Set vect = vectorCreate(m_ed.optSetting, m_ed.board(m_ed.undoIndex), m_ed.currentLayer)
    
    If isIsometric Then
        pts = modBoard.rectProjectIsometric(sel)
        For i = 0 To UBound(pts)
            Call vect.addPoint(pts(i).x, pts(i).y)
        Next i
    Else
        Call vect.addPoint(sel.x1, sel.y1)
        Call vect.addPoint(sel.x2, sel.y1)
        Call vect.addPoint(sel.x2, sel.y2)
        Call vect.addPoint(sel.x1, sel.y2)
    End If
    
    Call vect.closeVector(0, m_ed.currentLayer)
    Call sel.clear(Me)
    Call vect.draw(picBoard, m_ed.pCEd, vectorGetColor, g_CBoardPreferences.bShowVectorIndices, True)
    Call toolbarRefresh
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
        Case BS_LIGHTING
            i = m_ed.currentObject(BTAB_LIGHTING)
            If i >= 0 And i <= UBound(m_ed.board(m_ed.undoIndex).lights) Then
                If Not m_ed.board(m_ed.undoIndex).lights(i) Is Nothing Then Set currentVector = m_ed.board(m_ed.undoIndex).lights(i).nodes
            End If
    End Select
End Function
Private Sub vectorDrawAll() ': On Error Resume Next
    Dim i As Long, vis As Boolean
    With m_ed.board(m_ed.undoIndex)
    
        'Vectors
        If m_ed.bDrawObjects(BS_VECTOR) Or m_ed.optSetting = BS_VECTOR Then
            For i = 0 To UBound(.vectors)
                If Not (.vectors(i) Is Nothing) Then
                    'Check visibility. Draw if layer exceeds ubound.
                    If .vectors(i).layer <= UBound(m_ed.bLayerVisible) Then vis = m_ed.bLayerVisible(.vectors(i).layer)
                    If vis Or .vectors(i).layer > .sizeL Then _
                        Call .vectors(i).draw(picBoard, m_ed.pCEd, g_CBoardPreferences.vectorColor(.vectors(i).tiletype), g_CBoardPreferences.bShowVectorIndices)
                End If
            Next i
        End If
        
        'Programs
        If m_ed.bDrawObjects(BS_PROGRAM) Or m_ed.optSetting = BS_PROGRAM Then
            For i = 0 To UBound(.prgs)
                If Not (.prgs(i) Is Nothing) Then
                    If .prgs(i).layer <= UBound(m_ed.bLayerVisible) Then vis = m_ed.bLayerVisible(.prgs(i).layer)
                    If vis Or .prgs(i).layer > .sizeL Then _
                        Call .prgs(i).draw(picBoard, m_ed.pCEd, g_CBoardPreferences.programColor, g_CBoardPreferences.bShowVectorIndices)
                    End If
            Next i
        End If
        
        'Lights
        If toolbarDrawObject(BS_LIGHTING) Or m_ed.optSetting = BS_LIGHTING Then
            For i = 0 To UBound(.lights)
                If Not (.lights(i) Is Nothing) Then
                    Call .lights(i).nodes.draw(picBoard, m_ed.pCEd, g_CBoardPreferences.lightsColor, g_CBoardPreferences.bShowVectorIndices)
                End If
            Next i
        End If
    End With
    
    'Selected vector
    If Not currentVector Is Nothing Then Call currentVector.draw(picBoard, m_ed.pCEd, vectorGetColor, g_CBoardPreferences.bShowVectorIndices, True)
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
    
    If m_ed.optTool = BT_SELECT And sel.status = SS_FINISHED Then
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
            vectorGetColor = g_CBoardPreferences.vectorColor(currentVector.tiletype)
        Case BS_PROGRAM
            vectorGetColor = g_CBoardPreferences.programColor
        Case BS_LIGHTING
            vectorGetColor = g_CBoardPreferences.lightsColor
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
Public Sub vectorSetHandle(ByVal handle As String) ':on error resume next
    Dim i As Long, j As Long, pos As Long
    i = m_ed.currentObject(BTAB_VECTOR)
    
    pos = InStrRev(handle, ":")
    If pos > 0 Then handle = Trim$(Mid$(handle, pos + 1))
    If handle = BRD_VECTOR_HANDLE Then Exit Sub
        
    If i >= 0 Then
        For j = 0 To UBound(m_ed.board(m_ed.undoIndex).vectors)
            If j <> i Then
                If m_ed.board(m_ed.undoIndex).vectors(j).handle = handle Then
                    MsgBox "Handle in use", vbInformation
                    Exit For
                End If
            End If
        Next j
        
        'Did not find a match.
        If j > UBound(m_ed.board(m_ed.undoIndex).vectors) Then m_ed.board(m_ed.undoIndex).vectors(i).handle = handle
    End If
    Call toolbarPopulateVectors
End Sub
Private Sub vectorSubdivideSelection(ByRef sel As CBoardSelection) ':on error resume next
    If m_ed.optTool = BT_SELECT And m_sel.status = SS_FINISHED And (Not currentVector Is Nothing) Then
        Call setUndo
        Call currentVector.subdivideSelection(sel)
        Call drawBoard
    End If
End Sub
Public Function vectorSwapSlots(ByVal Index As Long, ByVal newIndex As Long) As Boolean ':on error resume next
    If newIndex = Index Or newIndex < 0 Or newIndex > UBound(m_ed.board(m_ed.undoIndex).vectors) Then Exit Function
    
    Dim vect As CVector
    Set vect = m_ed.board(m_ed.undoIndex).vectors(newIndex)
    Set m_ed.board(m_ed.undoIndex).vectors(newIndex) = m_ed.board(m_ed.undoIndex).vectors(Index)
    Set m_ed.board(m_ed.undoIndex).vectors(Index) = vect
        
    Call toolbarSetCurrent(BTAB_VECTOR, newIndex)
    Call toolbarPopulateVectors
End Function
Private Function vectorUndoLastPoint() As Boolean ':on error resume next
    Dim x As Long, y As Long, vect As CVector
    Set vect = currentVector
    
    If Not (vect Is Nothing) And m_sel.status = SS_DRAWING Then
        vect.deletePoints (currentVector.getPoints)
        
        If vect.tiletype = TT_NULL Then
            Set vect = Nothing
            Call vectorDeleteCurrent(m_ed.optSetting)
            Call m_sel.clear(Me)
        Else
            'Reset the selection.
            Call currentVector.getPoint(currentVector.getPoints, x, y)
            m_sel.x1 = x: m_sel.y1 = y
        End If
        vectorUndoLastPoint = True
        Call drawBoard
    End If
End Function

'========================================================================
' LAYERED IMAGE OBJECT FUNCTIONS (ctlBrdImage)
'========================================================================
Public Sub imageApply(ByVal Index As Long) ':on error resume next
    Dim ctl As ctlBrdImage, w As Long, h As Long, img As TKBoardImage
    Set ctl = m_ctls(BTAB_IMAGE)
    
    img = m_ed.board(m_ed.undoIndex).Images(Index)
    w = img.bounds.Right - img.bounds.Left
    h = img.bounds.Bottom - img.bounds.Top
    
    img.bounds.Left = val(ctl.getTxtLoc(0).Text)    'Board pixel co-ordinates always.
    img.bounds.Top = val(ctl.getTxtLoc(1).Text)
    img.bounds.Right = img.bounds.Left + w
    img.bounds.Bottom = img.bounds.Top + h
    img.layer = Abs(val(ctl.getTxtLoc(2).Text))
    
    img.drawType = BI_NORMAL                        'Until parallax/stretch implemented.
    img.transpcolor = ctl.transpcolor
    
    'Free the canvas of the current image if changing filename.
    If img.filename <> ctl.getTxtFilename.Text And img.pCnv Then
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(img))
    End If
    img.filename = ctl.getTxtFilename.Text
    
    m_ed.board(m_ed.undoIndex).Images(Index) = img
    Call imagePopulate(ctl.getCombo.ListIndex, img)
End Sub
Private Sub imageCreate(ByRef board As TKBoard, ByVal x As Long, ByVal y As Long) ':on error resume next
    Dim i As Long, bFound As Boolean '.images is always dimensioned.
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
Public Sub imageDeleteCurrent(ByVal Index As Long) ':on error resume next
    Dim i As Long, img As TKBoardImage
    If Index >= 0 Then
        Call setUndo
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(m_ed.board(m_ed.undoIndex).Images(Index)))
        For i = Index To UBound(m_ed.board(m_ed.undoIndex).Images) - 1
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
Private Sub imageHighlightSelected() ':on error resume next
    Dim r As RECT, p1 As POINTAPI, p2 As POINTAPI
    If m_ed.optSetting = BS_IMAGE And m_ed.currentObject(BTAB_IMAGE) <> -1 Then
        r = m_ed.board(m_ed.undoIndex).Images(m_ed.currentObject(BTAB_IMAGE)).bounds
        p1 = boardPixelToScreen(r.Left, r.Top, m_ed.pCEd)
        p2 = boardPixelToScreen(r.Right, r.Bottom, m_ed.pCEd)
        picBoard.Line (p1.x, p1.y)-(p2.x, p2.y), g_CBoardPreferences.highlightColor, B
    End If
End Sub
Private Function imageHitTest(ByVal x As Long, ByVal y As Long, ByRef Index As Long, ByRef img As TKBoardImage, ByRef imgs() As TKBoardImage) As Boolean ':on error resume next
    Dim i As Long
    For i = UBound(imgs) To 0 Step -1
        If x > imgs(i).bounds.Left And x < imgs(i).bounds.Right And _
            y > imgs(i).bounds.Top And y < imgs(i).bounds.Bottom Then
            img = imgs(i)
            Index = i
            imageHitTest = True
            Exit Function
        End If
    Next i
End Function
Private Sub imagePopulate(ByVal Index As Long, ByRef img As TKBoardImage) ':on error resume next
    Dim ctl As ctlBrdImage, cmb As ComboBox
    Set ctl = m_ctls(BTAB_IMAGE)
    Set cmb = ctl.getCombo
    
    If img.drawType = BI_NULL Then
        Call ctl.disableAll
        Exit Sub
    End If
    
    Call toolbarSetCurrent(BTAB_IMAGE, Index)
    Call ctl.enableAll
    
    If cmb.ListIndex <> Index Then cmb.ListIndex = Index
    cmb.List(Index) = str(Index) & ": " & IIf(LenB(img.filename), img.filename, "<image>")
    ctl.getTxtFilename.Text = img.filename
    ctl.getTxtLoc(0).Text = str(img.bounds.Left)
    ctl.getTxtLoc(1).Text = str(img.bounds.Top)
    ctl.getTxtLoc(2).Text = str(img.layer)
    ctl.transpcolor = img.transpcolor
End Sub

'========================================================================
' LIGHTING FUNCTIONS (ctlBrdSprite)
'========================================================================
Private Function spriteCreate(ByRef board As TKBoard, ByVal x As Long, ByVal y As Long) As CBoardSprite ':on error resume next
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
    Call spriteUpdateImageData(board.sprites(i), vbNullString, False)
    
    Call m_ctls(BTAB_SPRITE).populate(i, board.sprites(i))
    Set spriteCreate = board.sprites(i)
End Function
Public Sub spriteDeleteCurrent(ByVal Index As Long) ':on error resume next
    Dim i As Long
    If Index >= 0 Then
        Call setUndo
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(m_ed.board(m_ed.undoIndex).spriteImages(Index)))
        For i = Index To UBound(m_ed.board(m_ed.undoIndex).sprites) - 1
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
Private Sub spriteHighlightSelected() ':on error resume next
    Dim r As RECT, p1 As POINTAPI, p2 As POINTAPI
    If m_ed.optSetting = BS_SPRITE And m_ed.currentObject(BTAB_SPRITE) <> -1 Then
        r = m_ed.board(m_ed.undoIndex).spriteImages(m_ed.currentObject(BTAB_SPRITE)).bounds
        p1 = boardPixelToScreen(r.Left, r.Top, m_ed.pCEd)
        p2 = boardPixelToScreen(r.Right, r.Bottom, m_ed.pCEd)
        picBoard.Line (p1.x, p1.y)-(p2.x, p2.y), g_CBoardPreferences.highlightColor, B
    End If
End Sub
Public Sub spriteUpdateImageData(ByRef spr As CBoardSprite, ByVal filename As String, ByVal bForceRedraw As Boolean) ':on error resume next
    Dim img As TKBoardImage, w As Long, h As Long, ext As String
    img = spriteGetImageData(spr)
    
    If spr.filename <> filename Or bForceRedraw Then 'And img.pCnv Then
        
        Call BRDFreeImage(m_ed.pCBoard, VarPtr(img))
        Call modBoard.spriteGetDisplayImage(filename, img.filename, img.transpcolor)
        Call BRDRenderImage(m_ed.pCBoard, VarPtr(img), picBoard.hdc)
        
        'Render tst/tbm here because actkrt does not have easy access to tbm format.
        'actkrt3 creates a blank canvas to render onto, which is a member of CBoard.m_images
        If LCase$(extention(img.filename)) = "tst" Then
            Call drawTileCnv(img.pCnv, projectPath & tilePath & img.filename, 1, 1, 0, 0, 0, False)
            img.transpcolor = RGB(255, 0, 255) 'TRANSP_COLOR
        ElseIf LCase$(extention(img.filename)) = "tbm" Then
            Dim tbm As TKTileBitmap
            Call OpenTileBitmap(projectPath & bmpPath & img.filename, tbm)
            Call CNVResize(img.pCnv, picBoard.hdc, tbm.sizex * 32, tbm.sizey * 32)
            Call DrawTileBitmapCNV(img.pCnv, -1, 0, 0, tbm)
            img.transpcolor = RGB(255, 0, 255) 'TRANSP_COLOR
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
Public Function spriteSwapSlots(ByVal Index As Long, ByVal newIndex As Long) As Boolean ':on error resume next
    If newIndex = Index Or newIndex < 0 Or newIndex > UBound(m_ed.board(m_ed.undoIndex).sprites) Then Exit Function
    
    Dim spr As CBoardSprite, img As TKBoardImage
    'Hold the data in the new slot.
    Set spr = m_ed.board(m_ed.undoIndex).sprites(newIndex)
    img = m_ed.board(m_ed.undoIndex).spriteImages(newIndex)
    
    Set m_ed.board(m_ed.undoIndex).sprites(newIndex) = m_ed.board(m_ed.undoIndex).sprites(Index)
    m_ed.board(m_ed.undoIndex).spriteImages(newIndex) = m_ed.board(m_ed.undoIndex).spriteImages(Index)
    
    Set m_ed.board(m_ed.undoIndex).sprites(Index) = spr
    m_ed.board(m_ed.undoIndex).spriteImages(Index) = img
        
    Call toolbarSetCurrent(BTAB_SPRITE, newIndex)
    Call toolbarPopulateSprites
End Function

'========================================================================
' SHADING FUNCTIONS (ctlBrdLighting)
'========================================================================
Private Sub shadingSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next

    Dim tileCoord As POINTAPI, pxCoord As POINTAPI, tool As eBrdTool
    pxCoord = screenToBoardPixel(x, y, m_ed.pCEd)
    tileCoord = modBoard.boardPixelToTile(pxCoord.x, pxCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    
    If tileCoord.x > m_ed.effectiveBoardX Or tileCoord.y > m_ed.effectiveBoardY Then Exit Sub
    
    'Allow right-click in draw mode to erase tile.
    tool = IIf(m_ed.optTool = BT_DRAW And Button = vbRightButton, BT_ERASE, m_ed.optTool)
    
    Select Case tool
        Case BT_DRAW
            'Single lighting layer implementation.
            m_ed.board(m_ed.undoIndex).tileShading(0).values(tileCoord.x, tileCoord.y) = m_ed.currentShade
            Call drawStack(tileCoord.x, tileCoord.y, m_ed.board(m_ed.undoIndex).tileShading(0).layer)
   
        Case BT_SELECT
            ' Code is common to settings.
    
        Case BT_FLOOD
            'Use gdi.
            Call shadingFloodGdi(tileCoord.x, tileCoord.y, m_ed.board(m_ed.undoIndex).tileShading(0), m_ed.currentShade)
            
            If (g_CBoardPreferences.bRevertToDraw) Then
                m_ed.optTool = BT_DRAW
                tkMainForm.brdOptTool(m_ed.optTool).value = True
            End If
            
            'Clear all the layer canvases to cast light onto lower layers.
            Call reRenderAllLayers(False)
            Call drawBoard
            
        Case BT_ERASE
            Dim ts As TKTileShade
            m_ed.board(m_ed.undoIndex).tileShading(0).values(tileCoord.x, tileCoord.y) = ts
            Call drawStack(tileCoord.x, tileCoord.y, m_ed.board(m_ed.undoIndex).tileShading(0).layer)
            
        Case BT_RECT
            If m_sel.status <> SS_DRAWING Then
                Call m_sel.restart(pxCoord.x, pxCoord.y)
            Else
                m_sel.x2 = pxCoord.x: m_sel.y2 = pxCoord.y
                Call m_sel.drawProjectedRect(Me, m_ed.pCEd, m_ed.board(m_ed.undoIndex).coordType)
            End If
            
    End Select
End Sub
Public Sub shadingApply() ':on error resume next
    m_ed.board(m_ed.undoIndex).tileShading(0).layer = Abs(val(m_ctls(BTAB_LIGHTING).getTxtLayer.Text))
    Call activeBoard.reRenderAllLayers(False)
    Call activeBoard.drawAll
End Sub
'========================================================================
' Fill board with selected lighting shade - using gdi
'========================================================================
Private Sub shadingFloodGdi(ByVal xLoc As Long, ByVal yLoc As Long, ByRef ls As TKLayerShade, ByRef ts As TKTileShade) ': On Error Resume Next

    Const TS_OFFSET = 255           'Shades range from -255 to +255, but canvases cannot hold negatives.
    Const ISO_EDGE = 32767
                
    If ls.values(xLoc, yLoc).r = ts.r And ls.values(xLoc, yLoc).g = ts.g And ls.values(xLoc, yLoc).b = ts.b Then
        Exit Sub
    End If
    
    Dim tsCur(2) As Long, tsNew(2) As Long
    tsCur(0) = ls.values(xLoc, yLoc).r: tsCur(1) = ls.values(xLoc, yLoc).g: tsCur(2) = ls.values(xLoc, yLoc).b
    tsNew(0) = ts.r: tsNew(1) = ts.g: tsNew(2) = ts.b
    
    'Create a canvas per channel.
    Dim cnv(2) As Long, width As Long, Height As Long, i As Long, x As Long, y As Long
    width = m_ed.effectiveBoardX
    Height = m_ed.effectiveBoardY
    For i = 0 To 2
        cnv(i) = createCanvas(width + 1, Height + 1)
    Next i
    
    For x = 0 To width
        For y = 0 To Height
            If modBoard.isoOffEdge(x, y, m_ed.board(m_ed.undoIndex)) Or x = 0 Or y = 0 Then
                Call canvasSetPixel(cnv(0), x, y, ISO_EDGE)
                Call canvasSetPixel(cnv(1), x, y, ISO_EDGE)
                Call canvasSetPixel(cnv(2), x, y, ISO_EDGE)
            Else
                'Set a pixel per tile per channel.
                Call canvasSetPixel(cnv(0), x, y, ls.values(x, y).r + TS_OFFSET)
                Call canvasSetPixel(cnv(1), x, y, ls.values(x, y).g + TS_OFFSET)
                Call canvasSetPixel(cnv(2), x, y, ls.values(x, y).b + TS_OFFSET)
            End If
        Next y
    Next x
    
    'Perform the flood...
    
    Dim hdc As Long, brush As Long
    
    For i = 0 To 2
        hdc = canvasOpenHDC(cnv(i))                                 'Open the canvas device context.
        brush = CreateSolidBrush(tsNew(i) + TS_OFFSET)              'Create a brush.
        Call SelectObject(hdc, brush)                               'Assign the brush to the device context.
        Call ExtFloodFill(hdc, xLoc, yLoc, tsCur(i) + TS_OFFSET, 1) 'Process the flood fill on the device context.
        Call DeleteObject(brush)                                    'Destroy the brush.
        Call canvasCloseHDC(cnv(i), hdc)                            'Close the device context.
    Next i
            
    For x = 1 To width
        For y = 1 To Height
            'Copy the flooded image back to the array.
            ls.values(x, y).r = canvasGetPixel(cnv(0), x, y) - TS_OFFSET
            ls.values(x, y).g = canvasGetPixel(cnv(1), x, y) - TS_OFFSET
            ls.values(x, y).b = canvasGetPixel(cnv(2), x, y) - TS_OFFSET
            If ls.values(x, y).r = ISO_EDGE Then
                ls.values(x, y).r = 0
                ls.values(x, y).g = 0
                ls.values(x, y).b = 0
            End If
        Next y
    Next x
    
    For i = 0 To 2
        Call destroyCanvas(cnv(i))
    Next i
        
End Sub
Private Sub shadingDrawRect(ByRef sel As CBoardSelection, ByVal Shift As Integer) ':on error resume next
    Dim Index As Integer, i As Long, j As Long, p1 As POINTAPI, p2 As POINTAPI
    
    p1 = modBoard.boardPixelToTile(sel.x1, sel.y1, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    p2 = modBoard.boardPixelToTile(sel.x2, sel.y2, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
    
    'Reorientate
    i = p1.x: j = p1.y
    If p1.x > p2.x Then p1.x = p2.x: p2.x = i
    If p1.y > p2.y Then p1.y = p2.y: p2.y = j
    
    For i = p1.x To p2.x
        For j = p1.y To p2.y
            If Shift Or ((i = p1.x Or i = p2.x) Or (j = p1.y Or j = p2.y)) Then
                m_ed.board(m_ed.undoIndex).tileShading(0).values(i, j) = m_ed.currentShade
            End If
        Next j
    Next i
    
End Sub
Public Sub currentShade(ByVal r As Integer, ByVal g As Integer, ByVal b As Integer): On Error Resume Next
    m_ed.currentShade.r = r
    m_ed.currentShade.g = g
    m_ed.currentShade.b = b
    Call m_ctls(BTAB_LIGHTING).currentShade(r, g, b)
End Sub

'========================================================================
' LIGHTING FUNCTIONS (ctlBrdLighting)
'========================================================================
Private Sub lightingCreate(ByRef board As TKBoard, ByVal x As Long, ByVal y As Long) ':on error resume next
    Dim i As Long, bFound As Boolean
    
    '.lights is always dimensioned.
    For i = 0 To UBound(board.lights)
        If board.lights(i) Is Nothing Then
            Set board.lights(i) = New CBoardLight
            bFound = True
            Exit For
        End If
    Next i
    If Not bFound Then
        ReDim Preserve board.lights(i)
        Set board.lights(i) = New CBoardLight
    End If
    Call board.lights(i).setType(x, y)
    Call board.lights(i).setColor(1, m_ed.currentShade.r, m_ed.currentShade.g, m_ed.currentShade.b)
    board.lights(i).layer = board.tileShading(0).layer
    
    Call toolbarPopulateLighting
    Call toolbarChange(i, BS_LIGHTING)
End Sub
Public Sub lightingDeleteCurrent() ': on error resume next
    Dim i As Long
    i = m_ed.currentObject(BTAB_LIGHTING)
    If i >= 0 Then
        For i = i To UBound(m_ed.board(m_ed.undoIndex).lights) - 1
           Set m_ed.board(m_ed.undoIndex).lights(i) = m_ed.board(m_ed.undoIndex).lights(i + 1)
        Next i
        Set m_ed.board(m_ed.undoIndex).lights(i) = Nothing
        If i <> 0 Then ReDim Preserve m_ed.board(m_ed.undoIndex).lights(i - 1)
    End If
    Call toolbarRefresh
End Sub
Public Sub lightingConvert() ': on error resume next
    Dim pLight As CBoardLight
    Set pLight = toolbarGetCurrent(BS_LIGHTING)

    If Not pLight Is Nothing Then
        Call BRDConvertLight( _
            m_ed.pCBoard, _
            VarPtr(m_ed.board(m_ed.undoIndex)), _
            pLight _
        )
        
        Call activeBoard.setUndo
        Call activeBoard.lightingDeleteCurrent
        Call activeBoard.reRenderAllLayers(False)
        Call activeBoard.drawAll
    End If
    
End Sub

'========================================================================
' GENERAL TOOLBAR FUNCTIONS
'========================================================================
Public Sub toolbarRefresh() ':on error resume next
    Select Case tkMainForm.bTools_Tabs.Tab
        Case BTAB_VECTOR:     Call toolbarPopulateVectors
        Case BTAB_PROGRAM:    Call toolbarPopulatePrgs
        Case BTAB_SPRITE:     Call toolbarPopulateSprites
        Case BTAB_IMAGE:      Call toolbarPopulateImages
        Case BTAB_LIGHTING:   Call toolbarPopulateLighting
    End Select
End Sub
Public Sub toolbarChange(ByVal Index As Long, ByVal setting As eBrdSetting) ':on error resume next
    Select Case setting
        Case BS_VECTOR
            Call m_ctls(BTAB_VECTOR).populate(Index, m_ed.board(m_ed.undoIndex).vectors(Index))
        Case BS_PROGRAM
            Call m_ctls(BTAB_PROGRAM).populate(Index, m_ed.board(m_ed.undoIndex).prgs(Index))
        Case BS_SPRITE
            Call m_ctls(BTAB_SPRITE).populate(Index, m_ed.board(m_ed.undoIndex).sprites(Index))
        Case BS_IMAGE
            Call imagePopulate(Index, m_ed.board(m_ed.undoIndex).Images(Index))
        Case BS_LIGHTING, BS_SHADING
            Call m_ctls(BTAB_LIGHTING).populate(Index, m_ed.board(m_ed.undoIndex).lights(Index))
    End Select
    Call drawAll
End Sub
Public Sub toolbarPopulateVectors() ':on error resume next
    Dim combo As ComboBox, i As Long, j As Long, k As Long
    Set combo = m_ctls(BTAB_VECTOR).getCombo
    combo.clear
    k = m_ed.currentObject(BTAB_VECTOR)
                
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.vectors)
            If Not .vectors(i) Is Nothing Then
                combo.AddItem CStr(j) & ": " & IIf(LenB(.vectors(i).handle), .vectors(i).handle, BRD_VECTOR_HANDLE)
                j = j + 1
            End If
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
                    combo.AddItem CStr(j) & ": " & IIf(LenB(.prgs(i).filename), .prgs(i).filename, "<program>")
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
                    combo.AddItem str(j) & ": " & IIf(LenB(.Images(i).filename), .Images(i).filename, "<image>")
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
Private Sub toolbarPopulateLighting() ':on error resume next

    'BTAB_LIGHTING holds two lists: .tileShading and .lights, so there is an issue
    'with which list m_ed.currentObject(BTAB_LIGHTING) refers to.
    'However .tileShading only holds a single element as of 3.0.7, so m_ed.currentObject will
    'hold the *selected lighting object*.
                
    'Populate lighting objects.
    
    'User controls don't seem to like arrays, so...
    Dim combo As ComboBox, ctl As ctlBrdLighting, i As Long, j As Long, k As Long
    Set ctl = m_ctls(BTAB_LIGHTING)
    Set combo = ctl.getLightCombo
    combo.clear
    k = m_ed.currentObject(BTAB_LIGHTING)
    
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.lights)
            If Not .lights(i) Is Nothing Then
                combo.AddItem CStr(j) & ": " & ctl.lightName(.lights(i).eType)
                j = j + 1
            End If
        Next i
    End With
    
    If j > 0 Then
        'Preserve selected light.
        i = IIf(k < j And k <> -1, k, 0)
        Call ctl.populate(i, m_ed.board(m_ed.undoIndex).lights(i))
    Else
        'No lights.
        Call ctl.disableAll
        Call drawAll
    End If
    
    'Populate shading elements - tbd: move to shadingPopulate?
    ctl.getTxtLayer.Text = CStr(m_ed.board(m_ed.undoIndex).tileShading(0).layer)

End Sub
Public Function toolbarGetCurrent(ByVal setting As eBrdSetting) As Object ':on error resume next
    Dim i As Long
    i = toolbarGetIndex(setting)
    If i >= 0 Then
        Select Case setting
            Case BS_VECTOR:     Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).vectors(i)
            Case BS_PROGRAM:    Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).prgs(i)
            Case BS_SPRITE:     Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).sprites(i)
            Case BS_LIGHTING:   Set toolbarGetCurrent = m_ed.board(m_ed.undoIndex).lights(i)
        End Select
    End If
End Function
Public Function toolbarGetIndex(ByVal setting As eBrdSetting) As Long ':on error resume next
    toolbarGetIndex = m_ed.currentObject(g_tabMap(setting))
End Function
Public Sub toolbarSetCurrent(ByVal obj As eBoardTabs, ByVal Index As Long) ':on error resume next
    m_ed.currentObject(obj) = Index
End Sub
Public Property Get toolbarDrawObject(ByVal setting As eBrdSetting) As Boolean ':on error resume next
    toolbarDrawObject = m_ed.bDrawObjects(setting)
End Property
Public Property Let toolbarDrawObject(ByVal setting As eBrdSetting, ByVal value As Boolean) ':on error resume next
    m_ed.bDrawObjects(setting) = value
    Call drawAll
End Property

'========================================================================
' CLIPBOARD FUNCTIONS
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
        Case BS_TILE, BS_SHADING
            'Store shades and tiles in clip.tiles
            ReDim clip.tiles(0)
            k = 0
            
            If isIsometric Then
                'Find the centres of the contained tiles by pixel coordinates.
                i = O.x + 32
                Do While i < O.x + d.x
                    j = O.y + IIf(i - O.x Mod 64 = 0, 32, 16)
                    Do While j < O.y + d.y
                        
                        t1 = modBoard.boardPixelToTile(i, j, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
                        If m_ed.optSetting = BS_TILE Then
                            file = boardGetTile(t1.x, t1.y, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))
                            If file <> vbNullString Then
                                ReDim Preserve clip.tiles(k)
                                'Save tile coordinates.
                                clip.tiles(k).brdCoord.x = t1.x
                                clip.tiles(k).brdCoord.y = t1.y
                                clip.tiles(k).file = file
                                k = k + 1
                            End If
                        Else
                            'Lighting.
                            ReDim Preserve clip.tiles(k)
                            'Save tile coordinates.
                            clip.tiles(k).brdCoord.x = t1.x
                            clip.tiles(k).brdCoord.y = t1.y
                            clip.tiles(k).shade = m_ed.board(m_ed.undoIndex).tileShading(0).values(t1.x, t1.y)
                            k = k + 1
                        End If
                        
                        j = j + 32
                    Loop
                    i = i + 32
                Loop
            Else
                'TILE_NORMAL
                t1 = modBoard.boardPixelToTile(O.x, O.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
                t2 = modBoard.boardPixelToTile(O.x + d.x, O.y + d.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
                
                t1.x = IIf(t1.x < 1, 1, t1.x)
                t1.y = IIf(t1.y < 1, 1, t1.y)
                t2.x = IIf(t2.x > m_ed.effectiveBoardX + 1, m_ed.effectiveBoardX + 1, t2.x)
                t2.y = IIf(t2.y > m_ed.effectiveBoardY + 1, m_ed.effectiveBoardY + 1, t2.y)
                
                For i = t1.x To t2.x - 1
                    For j = t1.y To t2.y - 1
                        If m_ed.optSetting = BS_TILE Then
                            file = boardGetTile(i, j, m_ed.currentLayer, m_ed.board(m_ed.undoIndex))
                            If file <> vbNullString Then
                                ReDim Preserve clip.tiles(k)
                                clip.tiles(k).brdCoord.x = i
                                clip.tiles(k).brdCoord.y = j
                                clip.tiles(k).file = file
                                k = k + 1
                            End If
                        Else
                            'Lighting.
                            ReDim Preserve clip.tiles(k)
                            'Save tile coordinates.
                            clip.tiles(k).brdCoord.x = i
                            clip.tiles(k).brdCoord.y = j
                            clip.tiles(k).shade = m_ed.board(m_ed.undoIndex).tileShading(0).values(i, j)
                            k = k + 1
                        End If
                    Next j
                Next i
            End If 'isIsometric()
            
            Exit Sub
            
        Case BS_VECTOR, BS_PROGRAM
            Dim obj As Object
            Set obj = toolbarGetCurrent(m_ed.optSetting)
            If Not (obj Is Nothing) Then
                Call mnuSelectAll_Click
                Set clip.obj = obj
                'Call clip.obj.setSelection(sel) 'Unneeded if calling moveBy() over moveSelectionBy() [see clipPaste()]
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
    
    'Update for BS_VECTOR, BS_PROGRAM, BS_SPRITE, BS_IMAGE
    clip.origin.x = sel.x1
    clip.origin.y = sel.y1
    
End Sub
Private Sub clipCut(ByRef clip As TKBoardClipboard, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Long
    Select Case m_ed.optSetting
        Case BS_TILE
            For i = 0 To UBound(clip.tiles)
                'Cut the current tile.
                Call boardSetTile( _
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
            
        Case BS_SHADING
            For i = 0 To UBound(clip.tiles)
                'Erase the current shade.
                Dim ts As TKTileShade
                m_ed.board(m_ed.undoIndex).tileShading(0).values(clip.tiles(i).brdCoord.x, clip.tiles(i).brdCoord.y) = ts
            Next i
            If bRedraw Then
                Call reRenderAllLayers(False)
                Call drawBoard
            End If
    End Select
End Sub
Private Sub clipPaste(ByRef clip As TKBoardClipboard, ByRef sel As CBoardSelection) ':on error resume next
    Dim dr As POINTAPI, pt As POINTAPI, i As Long, obj As Object
    
    'Displacement of the copied area.
    dr.x = sel.x1 - clip.origin.x
    dr.y = sel.y1 - clip.origin.y
    
    Select Case m_ed.optSetting
        Case BS_TILE, BS_SHADING
            For i = 0 To UBound(clip.tiles)
                'Origin.
                pt = modBoard.tileToBoardPixel(clip.tiles(i).brdCoord.x, clip.tiles(i).brdCoord.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
                'Get new tile from new position in pixels.
                pt = modBoard.boardPixelToTile(pt.x + dr.x, pt.y + dr.y, m_ed.board(m_ed.undoIndex).coordType, False, m_ed.board(m_ed.undoIndex).sizex)
                
                If pt.x > 0 And pt.x <= m_ed.effectiveBoardX And pt.y > 0 And pt.y <= m_ed.effectiveBoardY Then
                    If m_ed.optSetting = BS_TILE Then
                        Call boardSetTile( _
                            pt.x, pt.y, _
                            m_ed.currentLayer, _
                            clip.tiles(i).file, _
                            m_ed.board(m_ed.undoIndex) _
                        )
                        m_ed.bLayerOccupied(m_ed.currentLayer) = True
                    Else
                        'Lighting.
                        m_ed.board(m_ed.undoIndex).tileShading(0).values(pt.x, pt.y) = clip.tiles(i).shade
                    End If
                End If

            Next i
            
            If m_ed.optSetting = BS_TILE Then
                Call BRDRender(VarPtr(m_ed), VarPtr(m_ed.board(m_ed.undoIndex)), picBoard.hdc, False, m_ed.currentLayer)
            Else
                'Force a redraw of all layers by destroying canvases.
                Call reRenderAllLayers(False)
            End If
            
        'Remember that clip.obj points to an object in a previous Undo state.
        Case BS_VECTOR, BS_PROGRAM
            Set obj = vectorCreate(m_ed.optSetting, m_ed.board(m_ed.undoIndex), m_ed.currentLayer)
            Call clip.obj.copy(obj)
            Call obj.moveBy(dr.x, dr.y)
            Call toolbarRefresh
        Case BS_SPRITE
            Set obj = spriteCreate(m_ed.board(m_ed.undoIndex), 0, 0)
            Call clip.obj.copy(obj)
            Call obj.moveBy(dr.x, dr.y)
            Call toolbarRefresh
        Case BS_IMAGE
            Call imageCreate(m_ed.board(m_ed.undoIndex), 0, 0)
            i = toolbarGetIndex(m_ed.optSetting)
            m_ed.board(m_ed.undoIndex).Images(i) = clip.img
            m_ed.board(m_ed.undoIndex).Images(i).bounds.Left = clip.img.bounds.Left + dr.x
            m_ed.board(m_ed.undoIndex).Images(i).bounds.Top = clip.img.bounds.Top + dr.y
            Call toolbarRefresh
        End Select
    Call drawBoard
End Sub

'========================================================================
' Wrappers for toolbar controls
'========================================================================
Public Sub boardPixelToTile(ByRef x As Long, ByRef y As Long, ByVal bRemoveBasePoint As Boolean, Optional ByVal bIgnorePxAbsolute As Boolean = True): On Error Resume Next
    Dim pt As POINTAPI
    If bIgnorePxAbsolute Or ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0) Then
        pt = modBoard.boardPixelToTile(x, y, m_ed.board(m_ed.undoIndex).coordType, bRemoveBasePoint, m_ed.board(m_ed.undoIndex).sizex)
        x = pt.x
        y = pt.y
    End If
End Sub
Public Sub tileToBoardPixel(ByRef x As Long, ByRef y As Long, ByVal bAddBasePoint As Boolean, Optional ByVal bIgnorePxAbsolute As Boolean = True): On Error Resume Next
    Dim pt As POINTAPI
    If bIgnorePxAbsolute Or ((m_ed.board(m_ed.undoIndex).coordType And PX_ABSOLUTE) = 0) Then
        pt = modBoard.tileToBoardPixel(x, y, m_ed.board(m_ed.undoIndex).coordType, bAddBasePoint, m_ed.board(m_ed.undoIndex).sizex)
        x = pt.x
        y = pt.y
    End If
End Sub

'========================================================================
' Set the tools of the left-hand toolbar
'========================================================================
Private Sub toolsRefresh(): On Error Resume Next
    tkMainForm.brdOptTool(BT_DRAW).Enabled = (m_ed.optSetting > BS_ZOOM)
    tkMainForm.brdOptTool(BT_SELECT).Enabled = (m_ed.optSetting > BS_ZOOM)
    tkMainForm.brdOptTool(BT_FLOOD).Enabled = (m_ed.optSetting = BS_TILE Or m_ed.optSetting = BS_SHADING)
    tkMainForm.brdOptTool(BT_ERASE).Enabled = (m_ed.optSetting = BS_TILE Or m_ed.optSetting = BS_SHADING)
    tkMainForm.brdOptTool(BT_DROPPER).Enabled = (m_ed.optSetting = BS_TILE Or m_ed.optSetting = BS_SHADING)
    tkMainForm.brdOptTool(BT_RECT).Enabled = False
    Select Case m_ed.optSetting
        Case BS_TILE, BS_SHADING
            'Only allow rectangle tool in ISO_ROTATED and TILE_NORMAL modes.
            tkMainForm.brdOptTool(BT_RECT).Enabled = ((m_ed.board(m_ed.undoIndex).coordType And ISO_STACKED) = 0)
        Case BS_VECTOR, BS_PROGRAM
            tkMainForm.brdOptTool(BT_RECT).Enabled = True
    End Select
End Sub

'========================================================================
' BOARD PROPERTIES (TAB) FUNCTIONS
'========================================================================
Private Sub assignProperties() ': on error resume next
    Dim i As Long
    With m_ed.board(m_ed.undoIndex)
        For i = 0 To UBound(.directionalLinks)
            txtLinks(i).Text = .directionalLinks(i)
        Next i
        
        txtBackgroundImage.Text = .bkgImage.filename
        picBackgroundColor.backColor = .bkgColor
        txtBackgroundMusic.Text = .bkgMusic
        
        lblProperties(5).Caption = "Background image"
        If LenB(.bkgImage.filename) Then
            lblProperties(5).Caption = "Background image (" & CStr(.bkgImage.bounds.Right) & " x " & CStr(.bkgImage.bounds.Bottom) & ")"
        End If
    
        lbThreads.clear
        For i = 0 To UBound(.Threads)
            lbThreads.AddItem (.Threads(i))
        Next i
    
        txtDims(0).Text = str(.sizex)
        txtDims(1).Text = str(.sizey)
        txtDims(2).Text = str(.sizeL)
        lblProperties(10).Caption = modBoard.absWidth(.sizex, .coordType) & " pixels"
        lblProperties(11).Caption = modBoard.absHeight(.sizey, .coordType) & " pixels"
        
        Select Case (.coordType And Not PX_ABSOLUTE)
            Case ISO_STACKED: lblProperties(13).Caption = "Isometric stacked" & vbCrLf
            Case ISO_ROTATED: lblProperties(13).Caption = "Isometric rotated" & vbCrLf
            Case TILE_NORMAL: lblProperties(13).Caption = "Standard 2D " & vbCrLf
        End Select
        lblProperties(13).Caption = lblProperties(13).Caption & IIf(.coordType And PX_ABSOLUTE, "Pixel ", "Tile ") & "coordinates"
        
        cmbConstants.clear
        For i = 0 To UBound(.constants)
            cmbConstants.AddItem ("constant[" & i & "]")
        Next i
        cmbConstants.AddItem vbNullString           'Provision for the next board constant.
        cmbConstants.ListIndex = -1
        
        Call assignLayerTitles
        
        chkEnableBattles.value = Abs(.bAllowBattles)
        Call chkEnableBattles_Click
        txtBoardSkill.Text = str(.battleSkill)
        txtBattleBackground.Text = .battleBackground
        
        chkDisableSaving.value = Abs(.bDisableSaving)
        txtPrgEnterBoard.Text = .enterPrg
        
        txtAmbientLevel(0).Text = CStr(.ambientEffect.r)
        txtAmbientLevel(1).Text = CStr(.ambientEffect.g)
        txtAmbientLevel(2).Text = CStr(.ambientEffect.b)
        
    End With
End Sub
Private Sub assignLayerTitles() ': on error resume next
    Dim i As Long
    cmbLayerTitles.clear
    For i = 0 To UBound(m_ed.board(m_ed.undoIndex).layerTitles)
        cmbLayerTitles.AddItem ("boardTitle[" & i & "]")
    Next i
    cmbLayerTitles.ListIndex = -1
End Sub
Private Sub chkDisableSaving_Click() ': on error resume next
    m_ed.board(m_ed.undoIndex).bDisableSaving = chkDisableSaving.value
End Sub
Private Sub chkEnableBattles_Click() ': on error resume next
    m_ed.board(m_ed.undoIndex).bAllowBattles = chkEnableBattles.value
    txtBattleBackground.Enabled = chkEnableBattles.value
    txtBoardSkill.Enabled = chkEnableBattles.value
    lblProperties(18).Enabled = chkEnableBattles.value
    lblProperties(19).Enabled = chkEnableBattles.value
End Sub
Private Sub cmbConstants_Click() ': on error resume next
    With cmbConstants
        If .ListIndex = -1 Then Exit Sub
        If .ListIndex = .ListCount - 1 Then
            'Add a new constant.
            .List(.ListIndex) = "constant[" & .ListIndex & "]"
            ReDim Preserve m_ed.board(m_ed.undoIndex).constants(.ListIndex)
            .AddItem vbNullString
        End If
        txtConstant.Text = m_ed.board(m_ed.undoIndex).constants(.ListIndex)
        txtConstant.SetFocus
    End With
End Sub
Private Sub cmbLayerTitles_Click() ': on error resume next
    If cmbLayerTitles.ListIndex <> -1 Then
        txtLayerTitle.Text = m_ed.board(m_ed.undoIndex).layerTitles(cmbLayerTitles.ListIndex)
        txtLayerTitle.SetFocus
    End If
End Sub
Private Sub cmdBrowse_Click(Index As Integer) ': On Error Resume Next
    Dim file As String, fileTypes As String, i As Long
    Select Case Index
         Case 0, 1, 2, 3:
            fileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(Me.hwnd, projectPath & brdPath, "Linking board or program", "brd", fileTypes, file) Then
                txtLinks(Index).Text = file
            End If
        Case 4:
            If browseFileDialog(Me.hwnd, projectPath & bmpPath, "Background image", "jpg", strFileDialogFilterGfx, file) Then
                txtBackgroundImage.Text = file
            End If
        Case 5:
            i = ColorDialog()
            If i >= 0 Then
                picBackgroundColor.backColor = i
                m_ed.board(m_ed.undoIndex).bkgColor = i
            End If
        Case 6:
            If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Background music", "mid", strFileDialogFilterMedia, file) Then
                txtBackgroundMusic.Text = file
            End If
        Case 7:
            fileTypes = "RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
            If browseFileDialog(Me.hwnd, projectPath & bkgPath, "Battle background", "bkg", fileTypes, file) Then
                txtBattleBackground.Text = file
            End If
        Case 8:
            fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
            If browseFileDialog(Me.hwnd, projectPath & prgPath, "Program to run on entering board", "prg", fileTypes, file) Then
                txtPrgEnterBoard.Text = file
            End If
    End Select
End Sub
Private Sub cmdThreadsAdd_Click() ': On Error Resume Next
    Dim file As String, fileTypes As String, ub As Long
    fileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Board thread", "prg", fileTypes, file) Then
        ub = UBound(m_ed.board(m_ed.undoIndex).Threads) + 1
        ReDim Preserve m_ed.board(m_ed.undoIndex).Threads(ub)
        m_ed.board(m_ed.undoIndex).Threads(ub) = file
        lbThreads.AddItem (file)
    End If
End Sub
Private Sub cmdThreadsRemove_Click() ': On Error Resume Next
   Dim i As Long
    If lbThreads.ListIndex <> -1 Then
        lbThreads.RemoveItem (lbThreads.ListIndex)
        If lbThreads.ListCount <> 0 Then
            ReDim m_ed.board(m_ed.undoIndex).Threads(lbThreads.ListCount - 1)
            For i = 0 To UBound(m_ed.board(m_ed.undoIndex).Threads)
                m_ed.board(m_ed.undoIndex).Threads(i) = lbThreads.List(i)
            Next i
        Else
            ReDim m_ed.board(m_ed.undoIndex).Threads(0)
        End If
    End If
End Sub
Private Sub hsbDims_Change(Index As Integer) ': on error resume next
    Dim i As Long
    If hsbDims(Index).value <> 1 Then
        i = val(txtDims(Index).Text) + hsbDims(Index).value - 1
        txtDims(Index).Text = IIf(i < 1, " 1", str(i))
    End If
    hsbDims(Index).value = 1
    
    Dim KeyAscii As Integer
    Call txtDims_KeyPress(Index, KeyAscii)
End Sub
Private Sub sstBoard_Click(PreviousTab As Integer) ': On Error Resume Next
    If PreviousTab = BTAB_PROPERTIES And picProperties.Tag = "Resize" Then
        'The dimensions textboxes have been edited; resize the board.
        picProperties.Tag = vbNullString
        Call setUndo
        Call boardSetSize(val(txtDims(0).Text), val(txtDims(1).Text), val(txtDims(2).Text), m_ed, m_ed.board(m_ed.undoIndex), True)
        Call resetLayerCombos
        Call assignLayerTitles
        Call reRenderAllLayers(True)
    End If
    If sstBoard.Tab = BTAB_BOARD Then
        Call Form_Resize
    End If
End Sub
'========================================================================
' Enable vectors to be drawn up to the edge of the board
'========================================================================
Private Sub sstBoard_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    If sstBoard.Tab <> BTAB_BOARD Then Exit Sub
    If m_ed.optSetting = BS_PROGRAM Or m_ed.optSetting = BS_VECTOR Then
        'Reject events on the the tabs themselves.
        If y > sstBoard.TabHeight Then
            Call sstBoardToPicBoard(x, y)
            Call picBoard_MouseDown(Button, Shift, x, y)
        End If
    End If
End Sub
Private Sub sstBoard_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    If sstBoard.Tab <> BTAB_BOARD Then Exit Sub
    If m_ed.optSetting = BS_PROGRAM Or m_ed.optSetting = BS_VECTOR Then
        'Reject events on the the tabs themselves.
        If y > sstBoard.TabHeight Then
            Call sstBoardToPicBoard(x, y)
            Call picBoard_MouseMove(Button, Shift, x, y)
        End If
    End If
End Sub
'========================================================================
' Round a coordinate on picBoard's container to the nearest picBoard edge
'========================================================================
Private Sub sstBoardToPicBoard(ByRef x As Single, ByRef y As Single): On Error Resume Next
    x = x - picBoard.Left
    y = y - picBoard.Top
    If x < 0 Then x = 0
    If x > picBoard.width Then x = picBoard.width
    If y < 0 Then y = 0
    If y > picBoard.Height Then y = picBoard.Height
    x = picBoard.ScaleX(x, vbTwips, vbPixels)
    y = picBoard.ScaleY(y, vbTwips, vbPixels)
End Sub
Private Sub txtAmbientLevel_Change(Index As Integer): On Error Resume Next
    
    Dim value As Long
    value = CLng(val(txtAmbientLevel(Index).Text))
    value = IIf(value < -255, -255, IIf(value > 255, 255, value))
    
    Select Case Index
        Case 0: m_ed.board(m_ed.undoIndex).ambientEffect.r = value
        Case 1: m_ed.board(m_ed.undoIndex).ambientEffect.g = value
        Case 2: m_ed.board(m_ed.undoIndex).ambientEffect.b = value
    End Select
            
End Sub
Private Sub txtBackgroundImage_Change(): On Error Resume Next
    m_ed.board(m_ed.undoIndex).bkgImage.filename = txtBackgroundImage.Text
    Call BRDFreeImage(m_ed.pCBoard, VarPtr(m_ed.board(m_ed.undoIndex).bkgImage))
End Sub
Private Sub txtBackgroundMusic_Change(): On Error Resume Next
    m_ed.board(m_ed.undoIndex).bkgMusic = txtBackgroundMusic.Text
End Sub
Private Sub txtBattleBackground_Change(): On Error Resume Next
    m_ed.board(m_ed.undoIndex).battleBackground = txtBattleBackground.Text
End Sub
Private Sub txtBoardSkill_Change(): On Error Resume Next
    m_ed.board(m_ed.undoIndex).battleSkill = val(txtBoardSkill.Text)
End Sub
Private Sub txtConstant_Change(): On Error Resume Next
    If cmbConstants.ListIndex <> -1 Then
        m_ed.board(m_ed.undoIndex).constants(cmbConstants.ListIndex) = txtConstant.Text
    End If
End Sub
Private Sub txtDims_KeyPress(Index As Integer, KeyAscii As Integer): On Error Resume Next
    'Indicate that we want to resize the board when the tab is switched.
    'Do not resize after every validation, since it is a big operation.
    picProperties.Tag = "Resize"
    lblProperties(10).Caption = modBoard.absWidth(val(txtDims(0).Text), m_ed.board(m_ed.undoIndex).coordType) & " pixels"
    lblProperties(11).Caption = modBoard.absHeight(val(txtDims(1).Text), m_ed.board(m_ed.undoIndex).coordType) & " pixels"
End Sub
Private Sub txtLayerTitle_Change(): On Error Resume Next
    If cmbLayerTitles.ListIndex <> -1 Then
        m_ed.board(m_ed.undoIndex).layerTitles(cmbLayerTitles.ListIndex) = txtLayerTitle.Text
    End If
End Sub
Private Sub txtLinks_Change(Index As Integer): On Error Resume Next
    m_ed.board(m_ed.undoIndex).directionalLinks(Index) = txtLinks(Index).Text
End Sub
Private Sub txtPrgEnterBoard_Change(): On Error Resume Next
    m_ed.board(m_ed.undoIndex).enterPrg = txtPrgEnterBoard.Text
End Sub

'========================================================================
' Common menu items
'========================================================================
Private Sub mnubuild_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0: Call tkMainForm.createpakfilemnu_Click
        Case 1: Call tkMainForm.makeexemnu_Click
        Case 3: Call tkMainForm.createsetupmnu_Click
    End Select
End Sub
Private Sub mnuCloseBoard_Click(): On Error Resume Next
    Unload Me
End Sub
Private Sub mnuExitEditor_Click(): On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub
Private Sub mnuHelp_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0: Call tkMainForm.usersguidemnu_Click
        Case 2: Call tkMainForm.historytxtmnu_Click
        Case 4: Call tkMainForm.aboutmnu_Click
    End Select
End Sub
Private Sub mnunew_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0: Call tkMainForm.newtilemnu_Click
        Case 1: Call tkMainForm.newanimtilemnu_Click
        Case 2: Call tkMainForm.newboardmnu_Click
        Case 3: Call tkMainForm.newplayermnu_Click
        Case 4: Call tkMainForm.newitemmnu_Click
        Case 5: Call tkMainForm.newenemymnu_Click
        Case 6: Call tkMainForm.newrpgcodemnu_Click
        Case 7: Call tkMainForm.mnuNewFightBackground_Click
        Case 8: Call tkMainForm.newspecialmovemnu_Click
        Case 9: Call tkMainForm.newstatuseffectmnu_Click
        Case 10: Call tkMainForm.newanimationmnu_Click
        Case 11: Call tkMainForm.newtilebitmapmnu_Click
    End Select
End Sub
Private Sub mnunewproject_Click(): On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub
Private Sub mnuOpenProject_Click(Index As Integer): On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub
Private Sub mnuToolkit_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0: Call tkMainForm.testgamemnu_Click
    End Select
End Sub
Private Sub mnuWindow_Click(Index As Integer): On Error Resume Next
    Select Case Index
        Case 0: tkMainForm.popButton(PB_TILESET).value = Abs(tkMainForm.popButton(PB_TILESET).value - 1)
        Case 1: tkMainForm.popButton(PB_TOOLBAR).value = Abs(tkMainForm.popButton(PB_TOOLBAR).value - 1)
        Case 2: Call tkMainForm.showtoolsmnu_Click
    End Select
End Sub

