VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.MDIForm tkMainForm 
   BackColor       =   &H8000000C&
   Caption         =   "RPG Toolkit Development System, 3.0 (Untitled)"
   ClientHeight    =   8190
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   11880
   Icon            =   "tkMain.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox rightbar 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5700
      Left            =   8775
      ScaleHeight     =   5700
      ScaleWidth      =   2730
      TabIndex        =   88
      Top             =   570
      Visible         =   0   'False
      Width           =   2730
      Begin VB.Frame fileTree1 
         BorderStyle     =   0  'None
         Height          =   5175
         Left            =   120
         TabIndex        =   91
         Top             =   240
         Width           =   2775
         Begin MSComctlLib.TreeView TreeView1 
            Height          =   5055
            Left            =   0
            TabIndex        =   92
            TabStop         =   0   'False
            Top             =   0
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   8916
            _Version        =   393217
            Style           =   5
            ImageList       =   "ImageList1"
            Appearance      =   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin VB.CommandButton Command7 
         Caption         =   ">"
         Height          =   220
         Left            =   1560
         TabIndex        =   90
         TabStop         =   0   'False
         Top             =   0
         Visible         =   0   'False
         Width           =   220
      End
      Begin VB.Timer fileRefresh 
         Interval        =   64000
         Left            =   960
         Top             =   1920
      End
      Begin VB.CommandButton exitbutton 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   220
         Left            =   2400
         Picture         =   "tkMain.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   89
         Top             =   0
         Width           =   220
      End
      Begin VB.Label Label2 
         BackColor       =   &H00808080&
         Caption         =   "Project List"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Left            =   120
         TabIndex        =   87
         Top             =   0
         Width           =   2535
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6600
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   17
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":0E14
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":11AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":1548
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":1862
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":253C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":3216
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":3EF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":4BCA
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":58A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":657E
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":7258
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":7F32
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":8C0C
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":98E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":A5C0
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":B29A
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "tkMain.frx":BF74
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar mainToolbar 
      Align           =   1  'Align Top
      Height          =   570
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   1005
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "mainToolbarImages"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   15
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "new"
            Object.ToolTipText     =   "New Game"
            Object.Tag             =   "1193"
            ImageIndex      =   1
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   12
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Tile"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Animated Tile"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Board"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Player"
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Item"
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Enemy"
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "RPGCode Program"
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Fight Background"
               EndProperty
               BeginProperty ButtonMenu9 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Special Move"
               EndProperty
               BeginProperty ButtonMenu10 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Status Effect"
               EndProperty
               BeginProperty ButtonMenu11 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Animation"
               EndProperty
               BeginProperty ButtonMenu12 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Tile Bitmap"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "properties"
            Object.ToolTipText     =   "Project Properties"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "open"
            Object.ToolTipText     =   "Open"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "save"
            Object.ToolTipText     =   "Save"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "saveall"
            Object.ToolTipText     =   "Save All Files"
            Object.Tag             =   "1400"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "bard"
            Object.ToolTipText     =   "Launch The Bard"
            Object.Tag             =   "1395"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "website"
            Object.ToolTipText     =   "Go To Awesome Computing Website"
            Object.Tag             =   "1396"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "chat"
            Object.ToolTipText     =   "Chat"
            Object.Tag             =   "2034"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "configTk"
            Object.ToolTipText     =   "Config"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "tilesetedit"
            Object.ToolTipText     =   "Edit Tileset"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "testrun"
            Object.ToolTipText     =   "Test Run Your Game"
            Object.Tag             =   "1397"
            ImageIndex      =   9
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList mainToolbarImages 
         Left            =   6000
         Top             =   -120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   11
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":CC4E
               Key             =   "New..."
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":D1E8
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":D782
               Key             =   "Open"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":DB1C
               Key             =   "Save"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":E0B6
               Key             =   "Save All"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":E450
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":E7EA
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":EB84
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":EF1E
               Key             =   "Test Game"
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":F2B8
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "tkMain.frx":F652
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.PictureBox pTools 
      Align           =   4  'Align Right
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5700
      Left            =   465
      ScaleHeight     =   5700
      ScaleWidth      =   3510
      TabIndex        =   56
      Top             =   570
      Visible         =   0   'False
      Width           =   3510
      Begin VB.CommandButton bTools_Close 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   220
         Left            =   3240
         Picture         =   "tkMain.frx":1032C
         Style           =   1  'Graphical
         TabIndex        =   57
         Top             =   0
         Width           =   220
      End
      Begin TabDlg.SSTab bTools_Tabs 
         Height          =   5775
         Left            =   120
         TabIndex        =   58
         Top             =   360
         Width           =   3285
         _ExtentX        =   5794
         _ExtentY        =   10186
         _Version        =   393216
         Style           =   1
         Tabs            =   2
         TabsPerRow      =   2
         TabHeight       =   520
         TabCaption(0)   =   "Objects"
         TabPicture(0)   =   "tkMain.frx":10476
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "bTools_Objects_Tree"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).Control(1)=   "bTools_Objects_Frame"
         Tab(0).Control(1).Enabled=   0   'False
         Tab(0).Control(2)=   "Picture2"
         Tab(0).Control(2).Enabled=   0   'False
         Tab(0).ControlCount=   3
         TabCaption(1)   =   "Display"
         TabPicture(1)   =   "tkMain.frx":10492
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "Frame4"
         Tab(1).Control(1)=   "Frame5"
         Tab(1).ControlCount=   2
         Begin VB.PictureBox Picture2 
            BorderStyle     =   0  'None
            Height          =   1095
            Left            =   240
            ScaleHeight     =   1095
            ScaleWidth      =   1995
            TabIndex        =   100
            Top             =   4440
            Width           =   2000
            Begin VB.OptionButton bTools_Objects_Display 
               Caption         =   "current layer only"
               Height          =   375
               Index           =   2
               Left            =   0
               TabIndex        =   103
               Top             =   720
               Width           =   2775
            End
            Begin VB.OptionButton bTools_Objects_Display 
               Caption         =   "by layer"
               Height          =   375
               Index           =   1
               Left            =   0
               TabIndex        =   102
               Top             =   360
               Width           =   1695
            End
            Begin VB.OptionButton bTools_Objects_Display 
               Caption         =   "by object type"
               Height          =   375
               Index           =   0
               Left            =   0
               TabIndex        =   101
               Top             =   0
               Width           =   2775
            End
         End
         Begin VB.Frame Frame5 
            Caption         =   "Current Layer"
            Height          =   1575
            Left            =   -74880
            TabIndex        =   63
            Top             =   1290
            Width           =   3015
            Begin VB.CheckBox bTools_Display_Option 
               Caption         =   "always show warps"
               Height          =   255
               Index           =   3
               Left            =   240
               TabIndex        =   66
               Top             =   1080
               Width           =   2535
            End
            Begin VB.CheckBox bTools_Display_Option 
               Caption         =   "always show items"
               Height          =   255
               Index           =   2
               Left            =   240
               TabIndex        =   65
               Top             =   720
               Width           =   2535
            End
            Begin VB.CheckBox bTools_Display_Option 
               Caption         =   "always show programs"
               Height          =   255
               Index           =   1
               Left            =   240
               TabIndex        =   64
               Top             =   360
               Width           =   2535
            End
         End
         Begin VB.Frame Frame4 
            Caption         =   "General"
            Height          =   765
            Left            =   -74880
            TabIndex        =   60
            Top             =   450
            Width           =   3015
            Begin VB.CheckBox bTools_Display_Option 
               Caption         =   "show program/item graphic"
               Height          =   255
               Index           =   4
               Left            =   300
               TabIndex        =   62
               Top             =   750
               Visible         =   0   'False
               Width           =   2535
            End
            Begin VB.CheckBox bTools_Display_Option 
               Caption         =   "always redraw all layers"
               Height          =   255
               Index           =   0
               Left            =   240
               TabIndex        =   61
               Top             =   360
               Width           =   2535
            End
         End
         Begin VB.Frame bTools_Objects_Frame 
            Caption         =   "Object Display Format"
            Height          =   1455
            Left            =   150
            TabIndex        =   59
            Top             =   4170
            Width           =   3015
         End
         Begin MSComctlLib.TreeView bTools_Objects_Tree 
            Height          =   3585
            Left            =   150
            TabIndex        =   67
            Top             =   450
            Width           =   3015
            _ExtentX        =   5318
            _ExtentY        =   6324
            _Version        =   393217
            Indentation     =   353
            LineStyle       =   1
            Style           =   6
            BorderStyle     =   1
            Appearance      =   0
         End
      End
      Begin VB.Label bTools_Title 
         BackColor       =   &H00808080&
         Caption         =   "Board Toolbar 1.0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Left            =   0
         TabIndex        =   70
         Top             =   0
         Width           =   3375
      End
      Begin VB.Label pBoardData_Title 
         BackColor       =   &H00808080&
         Caption         =   "Board Objects"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Index           =   1
         Left            =   4170
         TabIndex        =   69
         Top             =   0
         Width           =   4800
      End
      Begin VB.Label Label17 
         BackColor       =   &H00808080&
         Caption         =   "Label17"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   585
         Left            =   10380
         TabIndex        =   68
         Top             =   450
         Width           =   1245
      End
   End
   Begin VB.PictureBox newBarContainerContainer 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5700
      Left            =   -1350
      ScaleHeight     =   5700
      ScaleWidth      =   1815
      TabIndex        =   53
      Top             =   570
      Visible         =   0   'False
      Width           =   1815
      Begin VB.CommandButton Command2 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   220
         Left            =   1560
         Picture         =   "tkMain.frx":104AE
         Style           =   1  'Graphical
         TabIndex        =   98
         Top             =   0
         Width           =   220
      End
      Begin VB.PictureBox newBar 
         BorderStyle     =   0  'None
         Height          =   5115
         Left            =   0
         ScaleHeight     =   5115
         ScaleWidth      =   1815
         TabIndex        =   54
         Top             =   240
         Width           =   1815
         Begin Toolkit.ctlNewBar NewBarIn 
            Height          =   5115
            Left            =   0
            TabIndex        =   55
            Top             =   0
            Width           =   1815
            _ExtentX        =   3201
            _ExtentY        =   8070
         End
      End
      Begin VB.Label lblNew 
         BackColor       =   &H00808080&
         Caption         =   "New"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Left            =   0
         TabIndex        =   96
         Top             =   0
         Width           =   3375
      End
   End
   Begin VB.PictureBox leftBarContainer 
      Align           =   3  'Align Left
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      FillColor       =   &H8000000F&
      ForeColor       =   &H8000000F&
      Height          =   5700
      Left            =   0
      ScaleHeight     =   5700
      ScaleWidth      =   975
      TabIndex        =   11
      Top             =   570
      Width           =   975
      Begin VB.CommandButton Command3 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   220
         Left            =   750
         Picture         =   "tkMain.frx":105F8
         Style           =   1  'Graphical
         TabIndex        =   99
         Top             =   0
         Width           =   220
      End
      Begin VB.PictureBox leftbar 
         BorderStyle     =   0  'None
         FillColor       =   &H8000000F&
         ForeColor       =   &H8000000F&
         Height          =   3600
         Left            =   0
         ScaleHeight     =   3600
         ScaleWidth      =   1005
         TabIndex        =   12
         Top             =   240
         Width           =   1005
         Begin VB.Frame boardTools 
            BorderStyle     =   0  'None
            Height          =   2745
            Left            =   0
            TabIndex        =   42
            Top             =   1680
            Visible         =   0   'False
            Width           =   975
            Begin VB.CheckBox boardMultiSelect 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":10742
               Style           =   1  'Graphical
               TabIndex        =   94
               ToolTipText     =   "Multi Select"
               Top             =   1560
               Visible         =   0   'False
               Width           =   375
            End
            Begin VB.CheckBox boardAutotileDraw 
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1140C
               Style           =   1  'Graphical
               TabIndex        =   93
               ToolTipText     =   "Toggle Auto Tiler"
               Top             =   2040
               Width           =   375
            End
            Begin VB.CommandButton Command8 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   1560
               Picture         =   "tkMain.frx":11716
               Style           =   1  'Graphical
               TabIndex        =   52
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CheckBox boardDrawLock 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":123E0
               Style           =   1  'Graphical
               TabIndex        =   51
               TabStop         =   0   'False
               Tag             =   "1271"
               ToolTipText     =   "Draw lock tool"
               Top             =   840
               Value           =   1  'Checked
               Width           =   375
            End
            Begin VB.CheckBox boardGrid 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":12CAA
               Style           =   1  'Graphical
               TabIndex        =   50
               TabStop         =   0   'False
               Tag             =   "1227"
               ToolTipText     =   "Grid on/off"
               Top             =   0
               Width           =   375
            End
            Begin VB.CommandButton boardRedraw 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":13974
               Style           =   1  'Graphical
               TabIndex        =   49
               TabStop         =   0   'False
               Tag             =   "1226"
               ToolTipText     =   "Redraw"
               Top             =   0
               Width           =   375
            End
            Begin VB.CommandButton boardSelectTile 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":1423E
               Style           =   1  'Graphical
               TabIndex        =   48
               TabStop         =   0   'False
               Tag             =   "1222"
               ToolTipText     =   "Select Tile"
               Top             =   360
               Width           =   375
            End
            Begin VB.CommandButton boardGradient 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":14548
               Style           =   1  'Graphical
               TabIndex        =   47
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   360
               Width           =   375
            End
            Begin VB.CheckBox boardTypeLock 
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":15212
               Style           =   1  'Graphical
               TabIndex        =   46
               TabStop         =   0   'False
               Tag             =   "1270"
               ToolTipText     =   "Tile type lock tool"
               Top             =   840
               Width           =   375
            End
            Begin VB.CheckBox boardEraser 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":15ADC
               Style           =   1  'Graphical
               TabIndex        =   45
               TabStop         =   0   'False
               Tag             =   "1269"
               ToolTipText     =   "Eraser"
               Top             =   1200
               Width           =   375
            End
            Begin VB.CheckBox boardIso 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":163A6
               Style           =   1  'Graphical
               TabIndex        =   44
               ToolTipText     =   "Isometric View"
               Top             =   2040
               Width           =   375
            End
            Begin VB.CheckBox boardFillTool 
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":17070
               Style           =   1  'Graphical
               TabIndex        =   43
               TabStop         =   0   'False
               Tag             =   "1642"
               ToolTipText     =   "Eraser"
               Top             =   1200
               Width           =   375
            End
         End
         Begin VB.Frame tileTools 
            BorderStyle     =   0  'None
            Height          =   2895
            Left            =   0
            TabIndex        =   28
            Top             =   1680
            Visible         =   0   'False
            Width           =   975
            Begin VB.CommandButton tileColorChage 
               Appearance      =   0  'Flat
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1793A
               Style           =   1  'Graphical
               TabIndex        =   41
               TabStop         =   0   'False
               ToolTipText     =   "Change Color"
               Top             =   360
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   8
               Left            =   120
               Picture         =   "tkMain.frx":18604
               Style           =   1  'Graphical
               TabIndex        =   40
               TabStop         =   0   'False
               Tag             =   "1637"
               ToolTipText     =   "Fill rectangle tool"
               Top             =   2400
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   7
               Left            =   480
               Picture         =   "tkMain.frx":18ECE
               Style           =   1  'Graphical
               TabIndex        =   39
               TabStop         =   0   'False
               Tag             =   "1638"
               ToolTipText     =   "Rectangle tool"
               Top             =   2040
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   6
               Left            =   120
               Picture         =   "tkMain.frx":19798
               Style           =   1  'Graphical
               TabIndex        =   38
               TabStop         =   0   'False
               Tag             =   "1639"
               ToolTipText     =   "Filled ellipse tool"
               Top             =   2040
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   5
               Left            =   480
               Picture         =   "tkMain.frx":1A062
               Style           =   1  'Graphical
               TabIndex        =   37
               TabStop         =   0   'False
               Tag             =   "1640"
               ToolTipText     =   "Ellipse tool"
               Top             =   1680
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   4
               Left            =   120
               Picture         =   "tkMain.frx":1A92C
               Style           =   1  'Graphical
               TabIndex        =   36
               TabStop         =   0   'False
               Tag             =   "1641"
               ToolTipText     =   "Line tool"
               Top             =   1680
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   3
               Left            =   480
               Picture         =   "tkMain.frx":1AC36
               Style           =   1  'Graphical
               TabIndex        =   35
               TabStop         =   0   'False
               Tag             =   "1269"
               ToolTipText     =   "Eraser"
               Top             =   1320
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   2
               Left            =   120
               Picture         =   "tkMain.frx":1B500
               Style           =   1  'Graphical
               TabIndex        =   34
               TabStop         =   0   'False
               Tag             =   "1642"
               ToolTipText     =   "Flood fill tool"
               Top             =   1320
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   1
               Left            =   480
               Picture         =   "tkMain.frx":1BDCA
               Style           =   1  'Graphical
               TabIndex        =   33
               TabStop         =   0   'False
               Tag             =   "1643"
               ToolTipText     =   "Eyedropper tool (capture color)"
               Top             =   960
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   0
               Left            =   120
               Picture         =   "tkMain.frx":1C0D4
               Style           =   1  'Graphical
               TabIndex        =   32
               TabStop         =   0   'False
               Tag             =   "1644"
               ToolTipText     =   "Pencil tool (draw)"
               Top             =   960
               Width           =   375
            End
            Begin VB.CommandButton tileRedraw 
               Appearance      =   0  'Flat
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1C3DE
               Style           =   1  'Graphical
               TabIndex        =   31
               TabStop         =   0   'False
               Tag             =   "1226"
               ToolTipText     =   "Redraw"
               Top             =   0
               Width           =   375
            End
            Begin VB.CheckBox tileGrid 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":1CCA8
               Style           =   1  'Graphical
               TabIndex        =   30
               TabStop         =   0   'False
               Tag             =   "1227"
               ToolTipText     =   "Grid on/off"
               Top             =   0
               Value           =   1  'Checked
               Width           =   375
            End
            Begin VB.CommandButton Command17 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   1560
               Picture         =   "tkMain.frx":1D972
               Style           =   1  'Graphical
               TabIndex        =   29
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CheckBox tileIsoCheck 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":1E63C
               Style           =   1  'Graphical
               TabIndex        =   76
               Top             =   360
               Width           =   375
            End
         End
         Begin VB.Frame tilebmpTools 
            BorderStyle     =   0  'None
            Height          =   1575
            Left            =   0
            TabIndex        =   21
            Top             =   1560
            Visible         =   0   'False
            Width           =   975
            Begin VB.CheckBox tilebmpEraser 
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1F306
               Style           =   1  'Graphical
               TabIndex        =   27
               TabStop         =   0   'False
               Tag             =   "1269"
               ToolTipText     =   "Eraser"
               Top             =   840
               Width           =   375
            End
            Begin VB.CommandButton tilebmpSelectTile 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":1FBD0
               Style           =   1  'Graphical
               TabIndex        =   26
               TabStop         =   0   'False
               Tag             =   "1222"
               ToolTipText     =   "Select Tile"
               Top             =   360
               Width           =   375
            End
            Begin VB.CommandButton tilebmpRedraw 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1FEDA
               Style           =   1  'Graphical
               TabIndex        =   25
               TabStop         =   0   'False
               Tag             =   "1226"
               ToolTipText     =   "Redraw"
               Top             =   0
               Width           =   375
            End
            Begin VB.CommandButton Command27 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   1560
               Picture         =   "tkMain.frx":207A4
               Style           =   1  'Graphical
               TabIndex        =   24
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CheckBox tilebmpDrawLock 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":2146E
               Style           =   1  'Graphical
               TabIndex        =   23
               TabStop         =   0   'False
               Tag             =   "1271"
               ToolTipText     =   "Draw lock tool"
               Top             =   840
               Value           =   1  'Checked
               Width           =   375
            End
            Begin VB.CheckBox tilebmpGrid 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":21D38
               Style           =   1  'Graphical
               TabIndex        =   22
               TabStop         =   0   'False
               Tag             =   "1227"
               ToolTipText     =   "Grid on/off"
               Top             =   0
               Width           =   375
            End
         End
         Begin VB.Frame animationTools 
            BorderStyle     =   0  'None
            Height          =   1335
            Left            =   120
            TabIndex        =   17
            Top             =   240
            Visible         =   0   'False
            Width           =   735
            Begin VB.CommandButton cmdAnimIns 
               Caption         =   "Ins"
               Height          =   375
               Left            =   0
               Style           =   1  'Graphical
               TabIndex        =   105
               Tag             =   "1518"
               Top             =   840
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimDel 
               Caption         =   "Del"
               Height          =   375
               Left            =   360
               Style           =   1  'Graphical
               TabIndex        =   104
               Tag             =   "1517"
               Top             =   840
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimPlay 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":22A02
               Style           =   1  'Graphical
               TabIndex        =   20
               Top             =   360
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimForward 
               Height          =   375
               Left            =   360
               Picture         =   "tkMain.frx":236CC
               Style           =   1  'Graphical
               TabIndex        =   19
               Top             =   0
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimBack 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":24396
               Style           =   1  'Graphical
               TabIndex        =   18
               Top             =   0
               Width           =   375
            End
         End
         Begin VB.Frame rpgcodeTools 
            BorderStyle     =   0  'None
            Height          =   1215
            Left            =   120
            TabIndex        =   13
            Top             =   240
            Visible         =   0   'False
            Width           =   735
            Begin VB.CommandButton prgEventEdit 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":25060
               Style           =   1  'Graphical
               TabIndex        =   16
               TabStop         =   0   'False
               Tag             =   "1613"
               ToolTipText     =   "Edit As Event"
               Top             =   600
               Width           =   375
            End
            Begin VB.CommandButton prgDebug 
               Height          =   375
               Left            =   360
               Picture         =   "tkMain.frx":25D2A
               Style           =   1  'Graphical
               TabIndex        =   15
               TabStop         =   0   'False
               Tag             =   "1614"
               ToolTipText     =   "Debug (Shift-F5)"
               Top             =   120
               Visible         =   0   'False
               Width           =   375
            End
            Begin VB.CommandButton prgRun 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":265F4
               Style           =   1  'Graphical
               TabIndex        =   14
               TabStop         =   0   'False
               Tag             =   "1615"
               ToolTipText     =   "Run (F5)"
               Top             =   120
               Width           =   375
            End
         End
      End
      Begin VB.Label lblTools 
         BackColor       =   &H00808080&
         Caption         =   "Tools"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Left            =   0
         TabIndex        =   97
         Top             =   0
         Width           =   3375
      End
   End
   Begin VB.Timer theBardTimer 
      Interval        =   200
      Left            =   1200
      Top             =   1680
   End
   Begin VB.PictureBox bBar 
      Align           =   2  'Align Bottom
      BorderStyle     =   0  'None
      Height          =   1665
      Left            =   0
      ScaleHeight     =   1665
      ScaleWidth      =   11880
      TabIndex        =   10
      Top             =   6270
      Visible         =   0   'False
      Width           =   11880
      Begin VB.Frame frmBoardExtras 
         BorderStyle     =   0  'None
         Caption         =   "Frame8"
         Height          =   1455
         Left            =   960
         TabIndex        =   160
         Top             =   120
         Width           =   10575
         Begin VB.PictureBox Picture3 
            BorderStyle     =   0  'None
            Height          =   375
            Left            =   3960
            ScaleHeight     =   375
            ScaleWidth      =   3975
            TabIndex        =   181
            Top             =   1080
            Width           =   3975
            Begin VB.CommandButton Command21 
               Appearance      =   0  'Flat
               Caption         =   "Draw All Layers"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Left            =   0
               TabIndex        =   182
               Tag             =   "1265"
               Top             =   0
               Width           =   3885
            End
         End
         Begin VB.Frame bFrame 
            Height          =   1065
            Index           =   0
            Left            =   0
            TabIndex        =   175
            Top             =   0
            Width           =   3915
            Begin VB.PictureBox Picture1 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   285
               Left            =   690
               ScaleHeight     =   17
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   31
               TabIndex        =   178
               Top             =   270
               Width           =   495
            End
            Begin VB.TextBox ambientnumber 
               Appearance      =   0  'Flat
               BackColor       =   &H00FFFFFF&
               Height          =   315
               Left            =   3270
               TabIndex        =   177
               Top             =   240
               Width           =   495
            End
            Begin VB.HScrollBar ambientlight 
               Height          =   315
               Left            =   150
               Max             =   255
               Min             =   -255
               TabIndex        =   176
               TabStop         =   0   'False
               Top             =   600
               Width           =   3615
            End
            Begin VB.Label bCaption 
               Caption         =   "Color "
               Height          =   285
               Index           =   0
               Left            =   150
               TabIndex        =   180
               Top             =   300
               Width           =   615
            End
            Begin VB.Label bCaption 
               Caption         =   "Value"
               Height          =   285
               Index           =   1
               Left            =   2640
               TabIndex        =   179
               Top             =   300
               Width           =   615
            End
         End
         Begin VB.Frame bFrame 
            Caption         =   "Tile Type - Normal                     "
            Height          =   1065
            Index           =   1
            Left            =   3960
            TabIndex        =   170
            Top             =   0
            Width           =   3885
            Begin VB.PictureBox Picture4 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   120
               ScaleHeight     =   255
               ScaleWidth      =   855
               TabIndex        =   173
               Top             =   600
               Width           =   855
               Begin VB.CommandButton toggle 
                  Appearance      =   0  'Flat
                  BackColor       =   &H00404040&
                  Caption         =   "Toggle"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   6.75
                     Charset         =   0
                     Weight          =   400
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   270
                  Left            =   0
                  TabIndex        =   174
                  Tag             =   "1266"
                  Top             =   0
                  Width           =   855
               End
            End
            Begin VB.PictureBox tiletypes 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   270
               Left            =   120
               Picture         =   "tkMain.frx":26EBE
               ScaleHeight     =   16
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   236
               TabIndex        =   172
               Top             =   240
               Width           =   3570
            End
            Begin VB.PictureBox arrowtype 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   285
               Left            =   1080
               ScaleHeight     =   17
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   23
               TabIndex        =   171
               Top             =   600
               Width           =   375
            End
         End
         Begin VB.Frame bFrame 
            Caption         =   "Current Tile - None              "
            Height          =   1455
            Index           =   2
            Left            =   7950
            TabIndex        =   162
            Top             =   0
            Width           =   2505
            Begin VB.PictureBox currenttile 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   150
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   30
               TabIndex        =   167
               Top             =   270
               Width           =   480
            End
            Begin VB.CommandButton Command22 
               Enabled         =   0   'False
               Height          =   195
               Left            =   720
               Style           =   1  'Graphical
               TabIndex        =   166
               Top             =   840
               Width           =   195
            End
            Begin VB.CommandButton Command20 
               Enabled         =   0   'False
               Height          =   195
               Left            =   720
               Style           =   1  'Graphical
               TabIndex        =   165
               Top             =   1080
               Width           =   195
            End
            Begin VB.PictureBox currenttileIso 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   720
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   62
               TabIndex        =   164
               Top             =   270
               Width           =   960
            End
            Begin VB.PictureBox animTile 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   150
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   30
               TabIndex        =   163
               Top             =   840
               Width           =   480
            End
            Begin VB.Label boardCoords 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "1,1"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   990
               TabIndex        =   169
               Tag             =   "1229"
               Top             =   1050
               Width           =   855
            End
            Begin VB.Label drawstatebox 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Draw Lock"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   990
               TabIndex        =   168
               Tag             =   "1277"
               Top             =   810
               Width           =   1215
            End
         End
         Begin VB.ComboBox Editlayer 
            Appearance      =   0  'Flat
            BackColor       =   &H00FFFFFF&
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   0
            TabIndex        =   161
            Text            =   "Editlayer"
            Top             =   1140
            Width           =   3915
         End
      End
      Begin VB.Frame tileBmpExtras 
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   960
         TabIndex        =   142
         Top             =   240
         Width           =   7680
         Begin VB.Frame Frame2 
            Caption         =   "Size      "
            Height          =   1095
            Index           =   0
            Left            =   3960
            TabIndex        =   153
            Top             =   0
            Width           =   1695
            Begin VB.PictureBox Picture5 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   840
               ScaleHeight     =   255
               ScaleWidth      =   735
               TabIndex        =   156
               Top             =   720
               Width           =   735
               Begin VB.CommandButton tileBmpSizeOK 
                  Appearance      =   0  'Flat
                  Caption         =   "OK"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   157
                  Tag             =   "1022"
                  Top             =   0
                  Width           =   615
               End
            End
            Begin VB.TextBox tileBmpSizeY 
               Appearance      =   0  'Flat
               Height          =   285
               Left            =   960
               TabIndex        =   155
               Top             =   240
               Width           =   495
            End
            Begin VB.TextBox tilebmpSizeX 
               Appearance      =   0  'Flat
               Height          =   285
               Left            =   240
               TabIndex        =   154
               Top             =   240
               Width           =   495
            End
            Begin VB.Label Label12 
               Caption         =   "Y"
               Height          =   255
               Left            =   830
               TabIndex        =   159
               Tag             =   "1045"
               Top             =   285
               Width           =   135
            End
            Begin VB.Label Label13 
               Caption         =   "X"
               Height          =   255
               Left            =   110
               TabIndex        =   158
               Tag             =   "1046"
               Top             =   285
               Width           =   135
            End
         End
         Begin VB.Frame frmTileLightning 
            Caption         =   "Tile Lighting                "
            Height          =   1095
            Left            =   0
            TabIndex        =   149
            Top             =   0
            Width           =   3855
            Begin VB.PictureBox tilebmpColor 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   285
               Left            =   2640
               ScaleHeight     =   17
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   31
               TabIndex        =   152
               Top             =   240
               Width           =   495
            End
            Begin VB.TextBox tileBmpAmbient 
               Appearance      =   0  'Flat
               BackColor       =   &H00FFFFFF&
               Height          =   285
               Left            =   3240
               TabIndex        =   151
               Top             =   240
               Width           =   495
            End
            Begin VB.HScrollBar tileBmpAmbientSlider 
               Height          =   195
               Left            =   120
               Max             =   255
               Min             =   -255
               TabIndex        =   150
               Top             =   600
               Width           =   3615
            End
         End
         Begin VB.Frame frmTileCur 
            Caption         =   "Current Tile              "
            Height          =   1455
            Left            =   5760
            TabIndex        =   143
            Top             =   0
            Width           =   1695
            Begin VB.PictureBox tileBmpSelectedTile 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   1080
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   30
               TabIndex        =   144
               Top             =   240
               Width           =   480
            End
            Begin VB.Label tileBmpDrawMode 
               Alignment       =   1  'Right Justify
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Draw Lock"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   600
               TabIndex        =   148
               Tag             =   "1277"
               Top             =   840
               Width           =   975
            End
            Begin VB.Label tileBmpCoords 
               Alignment       =   1  'Right Justify
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "1,1"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   720
               TabIndex        =   147
               Tag             =   "1229"
               Top             =   1080
               Width           =   855
            End
            Begin VB.Label tilebmpCurrentTile 
               Alignment       =   1  'Right Justify
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "None"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   480
               TabIndex        =   146
               Tag             =   "1010"
               Top             =   480
               Width           =   495
            End
            Begin VB.Label Label18 
               Alignment       =   1  'Right Justify
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Tile:"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   480
               TabIndex        =   145
               Tag             =   "1228"
               Top             =   240
               Width           =   495
            End
         End
      End
      Begin VB.Frame tileExtras 
         BorderStyle     =   0  'None
         Height          =   1455
         Left            =   960
         TabIndex        =   120
         Top             =   120
         Width           =   10200
         Begin VB.Frame Frame3 
            Caption         =   "Scroll              "
            Height          =   1215
            Left            =   8880
            TabIndex        =   133
            Tag             =   "1649"
            Top             =   240
            Width           =   1215
            Begin VB.PictureBox Picture6 
               BorderStyle     =   0  'None
               Height          =   615
               Left            =   120
               ScaleHeight     =   615
               ScaleWidth      =   975
               TabIndex        =   134
               Top             =   360
               Width           =   975
               Begin VB.CommandButton Command19 
                  Caption         =   "N"
                  Height          =   195
                  Left            =   360
                  TabIndex        =   138
                  TabStop         =   0   'False
                  Tag             =   "1653"
                  Top             =   0
                  Width           =   255
               End
               Begin VB.CommandButton Command18 
                  Caption         =   "S"
                  Height          =   195
                  Left            =   360
                  TabIndex        =   137
                  TabStop         =   0   'False
                  Tag             =   "1652"
                  Top             =   240
                  Width           =   255
               End
               Begin VB.CommandButton Command16 
                  Caption         =   "E"
                  Height          =   195
                  Left            =   720
                  TabIndex        =   136
                  TabStop         =   0   'False
                  Tag             =   "1651"
                  Top             =   120
                  Width           =   255
               End
               Begin VB.CommandButton Command15 
                  Caption         =   "W"
                  Height          =   195
                  Left            =   0
                  TabIndex        =   135
                  TabStop         =   0   'False
                  Tag             =   "1650"
                  Top             =   120
                  Width           =   255
               End
            End
         End
         Begin VB.Frame Frame6 
            Caption         =   "Current Color/Tile                                "
            Height          =   1215
            Left            =   6360
            TabIndex        =   127
            Top             =   240
            Width           =   2415
            Begin VB.PictureBox Picture8 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   120
               ScaleHeight     =   255
               ScaleWidth      =   1215
               TabIndex        =   131
               Top             =   840
               Width           =   1215
               Begin VB.CommandButton cmdImport 
                  Caption         =   "Import"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   132
                  Top             =   0
                  Width           =   1095
               End
            End
            Begin VB.PictureBox selectedcolor 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   495
               Left            =   120
               ScaleHeight     =   31
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   31
               TabIndex        =   130
               Top             =   240
               Width           =   495
            End
            Begin VB.PictureBox mirror 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   720
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   30
               TabIndex        =   129
               Top             =   240
               Width           =   480
            End
            Begin VB.PictureBox isoMirror 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   1320
               ScaleHeight     =   30
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   62
               TabIndex        =   128
               Top             =   240
               Width           =   960
            End
         End
         Begin VB.Frame Frame7 
            Caption         =   "Color      "
            Height          =   1215
            Left            =   0
            TabIndex        =   121
            Top             =   240
            Width           =   6255
            Begin VB.PictureBox Picture11 
               BorderStyle     =   0  'None
               Height          =   495
               Left            =   105
               ScaleHeight     =   495
               ScaleWidth      =   6045
               TabIndex        =   139
               Top             =   240
               Width           =   6045
               Begin VB.CommandButton Command1 
                  Height          =   495
                  Left            =   5880
                  TabIndex        =   141
                  Tag             =   "1662"
                  ToolTipText     =   "Select Transparent Color"
                  Top             =   0
                  Width           =   135
               End
               Begin VB.PictureBox palettebox 
                  Appearance      =   0  'Flat
                  BackColor       =   &H80000005&
                  ForeColor       =   &H80000008&
                  Height          =   495
                  Left            =   0
                  Picture         =   "tkMain.frx":270FD
                  ScaleHeight     =   465
                  ScaleWidth      =   5865
                  TabIndex        =   140
                  Tag             =   "1661"
                  ToolTipText     =   "Click to select a color"
                  Top             =   0
                  Width           =   5895
               End
            End
            Begin VB.PictureBox Picture7 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   120
               ScaleHeight     =   255
               ScaleWidth      =   4335
               TabIndex        =   122
               Top             =   840
               Width           =   4335
               Begin VB.CommandButton cmdShadeTile 
                  Caption         =   "Shade Tile"
                  Height          =   255
                  Left            =   2880
                  TabIndex        =   125
                  Top             =   0
                  Width           =   1335
               End
               Begin VB.CommandButton cmdSelColor 
                  Caption         =   "Select Color"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   124
                  Top             =   0
                  Width           =   1335
               End
               Begin VB.CommandButton cmdDOS 
                  Caption         =   "DOS Pallete"
                  Height          =   255
                  Left            =   1440
                  TabIndex        =   123
                  Top             =   0
                  Width           =   1335
               End
            End
            Begin VB.Label coords 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               ForeColor       =   &H80000008&
               Height          =   255
               Left            =   5520
               TabIndex        =   126
               Top             =   840
               Width           =   735
            End
         End
      End
      Begin VB.Frame animationExtras 
         BorderStyle     =   0  'None
         Height          =   1335
         Left            =   960
         TabIndex        =   77
         Top             =   240
         Width           =   9615
         Begin VB.Frame Frame1 
            Caption         =   "Size            "
            Height          =   1335
            Left            =   0
            TabIndex        =   86
            Tag             =   "1042"
            Top             =   0
            Width           =   4215
            Begin VB.PictureBox Picture9 
               BorderStyle     =   0  'None
               Height          =   975
               Left            =   120
               ScaleHeight     =   975
               ScaleWidth      =   3975
               TabIndex        =   106
               Top             =   240
               Width           =   3975
               Begin VB.OptionButton optAnimSize 
                  Caption         =   "Other"
                  Height          =   255
                  Index           =   4
                  Left            =   2160
                  TabIndex        =   113
                  Tag             =   "1521"
                  Top             =   240
                  Width           =   1695
               End
               Begin VB.OptionButton optAnimSize 
                  Caption         =   "Sprite (32x64)"
                  Height          =   255
                  Index           =   3
                  Left            =   2160
                  TabIndex        =   112
                  Top             =   0
                  Width           =   1455
               End
               Begin VB.OptionButton optAnimSize 
                  Caption         =   "Large (256x256)"
                  Height          =   255
                  Index           =   2
                  Left            =   0
                  TabIndex        =   111
                  Tag             =   "1522"
                  Top             =   480
                  Width           =   1815
               End
               Begin VB.OptionButton optAnimSize 
                  Caption         =   "Medium (128x128)"
                  Height          =   255
                  Index           =   1
                  Left            =   0
                  TabIndex        =   110
                  Tag             =   "1523"
                  Top             =   240
                  Width           =   1935
               End
               Begin VB.OptionButton optAnimSize 
                  Caption         =   "Small (64x64)"
                  Height          =   255
                  Index           =   0
                  Left            =   0
                  TabIndex        =   109
                  Tag             =   "1524"
                  Top             =   0
                  Value           =   -1  'True
                  Width           =   1935
               End
               Begin VB.TextBox txtAnimXSize 
                  Appearance      =   0  'Flat
                  Height          =   285
                  Left            =   2520
                  TabIndex        =   108
                  Top             =   600
                  Width           =   495
               End
               Begin VB.TextBox txtAnimYSize 
                  Appearance      =   0  'Flat
                  Height          =   285
                  Left            =   3360
                  TabIndex        =   107
                  Top             =   600
                  Width           =   495
               End
               Begin VB.Label lblAnimNewTBM 
                  AutoSize        =   -1  'True
                  Caption         =   "Create a tile bitmap"
                  BeginProperty Font 
                     Name            =   "MS Sans Serif"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   400
                     Underline       =   -1  'True
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H00FF0000&
                  Height          =   195
                  Left            =   0
                  MousePointer    =   2  'Cross
                  TabIndex        =   115
                  Top             =   720
                  Width           =   1350
               End
               Begin VB.Label Label6 
                  Caption         =   "X"
                  Height          =   255
                  Left            =   3120
                  TabIndex        =   114
                  Tag             =   "1046"
                  Top             =   600
                  Width           =   135
               End
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "Settings           "
            Height          =   1335
            Index           =   1
            Left            =   4320
            TabIndex        =   78
            Top             =   0
            Width           =   5175
            Begin VB.PictureBox Picture10 
               BorderStyle     =   0  'None
               FillStyle       =   0  'Solid
               Height          =   375
               Left            =   2160
               ScaleHeight     =   375
               ScaleWidth      =   2895
               TabIndex        =   116
               Top             =   840
               Width           =   2895
               Begin VB.CommandButton cmdAnimTransp 
                  Caption         =   "Select"
                  Height          =   315
                  Left            =   1680
                  TabIndex        =   118
                  Tag             =   "1516"
                  Top             =   0
                  Width           =   1095
               End
               Begin VB.CommandButton cmdAnimDelSound 
                  Caption         =   "X"
                  BeginProperty Font 
                     Name            =   "MS Sans Serif"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Height          =   255
                  Left            =   0
                  TabIndex        =   117
                  Tag             =   "1046"
                  Top             =   120
                  Width           =   255
               End
               Begin VB.Label lblAnimFrameCount 
                  AutoSize        =   -1  'True
                  Caption         =   "Frame 1 / 1"
                  Height          =   195
                  Left            =   720
                  TabIndex        =   119
                  Tag             =   "1527"
                  Top             =   0
                  Width           =   825
               End
            End
            Begin VB.HScrollBar hsbAnimPause 
               Height          =   135
               Left            =   120
               Max             =   10
               TabIndex        =   81
               TabStop         =   0   'False
               Top             =   480
               Width           =   2175
            End
            Begin VB.TextBox txtAnimSound 
               Appearance      =   0  'Flat
               Height          =   285
               Left            =   120
               TabIndex        =   80
               Top             =   960
               Width           =   1935
            End
            Begin VB.PictureBox transpcolor 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   255
               Left            =   2760
               ScaleHeight     =   15
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   143
               TabIndex        =   79
               Top             =   480
               Width           =   2175
            End
            Begin VB.Label Label9 
               AutoSize        =   -1  'True
               Caption         =   "Fast"
               Height          =   195
               Left            =   120
               TabIndex        =   85
               Tag             =   "1178"
               Top             =   240
               Width           =   300
            End
            Begin VB.Label Label8 
               AutoSize        =   -1  'True
               Caption         =   "Slow"
               Height          =   195
               Left            =   1920
               TabIndex        =   84
               Tag             =   "1179"
               Top             =   240
               Width           =   345
            End
            Begin VB.Label Label10 
               AutoSize        =   -1  'True
               Caption         =   "Sound"
               Height          =   195
               Left            =   120
               TabIndex        =   83
               Tag             =   "1525"
               Top             =   720
               Width           =   465
            End
            Begin VB.Label Label11 
               Caption         =   "Frame Transparent Color"
               Height          =   255
               Left            =   2760
               TabIndex        =   82
               Tag             =   "1526"
               Top             =   240
               Width           =   1815
            End
         End
      End
   End
   Begin VB.PictureBox popTray 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5700
      Left            =   11505
      ScaleHeight     =   5700
      ScaleWidth      =   375
      TabIndex        =   3
      Top             =   570
      Width           =   381
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   3
         Left            =   0
         Picture         =   "tkMain.frx":309DF
         Style           =   1  'Graphical
         TabIndex        =   9
         ToolTipText     =   "board data"
         Top             =   1080
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   2
         Left            =   0
         Picture         =   "tkMain.frx":30D69
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   720
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   1
         Left            =   0
         Picture         =   "tkMain.frx":31A33
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   360
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   0
         Left            =   3
         Picture         =   "tkMain.frx":31FBD
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   0
         Width           =   375
      End
   End
   Begin VB.Timer wallpaperTimer 
      Interval        =   250
      Left            =   6240
      Top             =   4320
   End
   Begin VB.PictureBox tilesetBar 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5700
      Left            =   3975
      ScaleHeight     =   5700
      ScaleWidth      =   4800
      TabIndex        =   2
      Top             =   570
      Visible         =   0   'False
      Width           =   4800
      Begin VB.PictureBox tilesetContainer 
         BorderStyle     =   0  'None
         Height          =   6255
         Left            =   0
         ScaleHeight     =   6255
         ScaleWidth      =   4815
         TabIndex        =   71
         Top             =   240
         Width           =   4815
         Begin VB.CheckBox chkCurTilesetDrawGrid 
            Height          =   375
            Left            =   3960
            Picture         =   "tkMain.frx":32347
            Style           =   1  'Graphical
            TabIndex        =   95
            Top             =   120
            Width           =   375
         End
         Begin Toolkit.ctlOpenButton changedSelectedTileset 
            Height          =   375
            Left            =   4345
            TabIndex        =   75
            Top             =   120
            Width           =   375
            _ExtentX        =   661
            _ExtentY        =   661
         End
         Begin VB.PictureBox currentTilesetForm 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H00808080&
            ForeColor       =   &H80000008&
            Height          =   5535
            Left            =   60
            ScaleHeight     =   367
            ScaleMode       =   3  'Pixel
            ScaleWidth      =   286
            TabIndex        =   73
            Top             =   480
            Width           =   4320
            Begin VB.Timer ReadCommandLine 
               Interval        =   1
               Left            =   1800
               Top             =   1080
            End
            Begin VB.Timer projectListSize 
               Interval        =   1
               Left            =   600
               Top             =   2040
            End
         End
         Begin VB.VScrollBar tilesetScroller 
            Height          =   5535
            Left            =   4470
            TabIndex        =   72
            TabStop         =   0   'False
            Top             =   480
            Width           =   255
         End
         Begin VB.Label currentTilesetInfo 
            Height          =   255
            Left            =   0
            TabIndex        =   74
            Top             =   150
            Width           =   4335
         End
      End
      Begin VB.CommandButton killTilesetBar 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   220
         Left            =   4560
         Picture         =   "tkMain.frx":33011
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   0
         Width           =   220
      End
      Begin VB.Label Label15 
         BackColor       =   &H00808080&
         Caption         =   "Current Tileset"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000F&
         Height          =   225
         Index           =   0
         Left            =   0
         TabIndex        =   6
         Top             =   0
         Width           =   4800
      End
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   7935
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   450
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   7
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            TextSave        =   "20/12/2004"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   1
            Object.Width           =   5027
            TextSave        =   "12:33"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            Enabled         =   0   'False
            TextSave        =   "NUM"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   3
            Enabled         =   0   'False
            TextSave        =   "INS"
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Enabled         =   0   'False
            TextSave        =   "CAPS"
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuRightClick 
      Caption         =   "Right-click on open editor"
      Visible         =   0   'False
      Begin VB.Menu mnuRes 
         Caption         =   "&Restore"
      End
      Begin VB.Menu mnuMin 
         Caption         =   "M&inimize"
      End
      Begin VB.Menu mnuMax 
         Caption         =   "M&aximize"
      End
      Begin VB.Menu mnuBlankxx 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCloseWindow 
         Caption         =   "Close"
      End
   End
   Begin VB.Menu filemnu 
      Caption         =   "File"
      Begin VB.Menu newprojectmnu 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu newmnu 
         Caption         =   "New..."
         Begin VB.Menu newtilemnu 
            Caption         =   "Tile"
         End
         Begin VB.Menu newanimtilemnu 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu newboardmnu 
            Caption         =   "Board"
         End
         Begin VB.Menu newplayermnu 
            Caption         =   "Player"
         End
         Begin VB.Menu newitemmnu 
            Caption         =   "Item"
         End
         Begin VB.Menu newenemymnu 
            Caption         =   "Enemy"
         End
         Begin VB.Menu newrpgcodemnu 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu newspecialmovemnu 
            Caption         =   "Special Move"
         End
         Begin VB.Menu newstatuseffectmnu 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu newanimationmnu 
            Caption         =   "Animation"
         End
         Begin VB.Menu newtilebitmapmnu 
            Caption         =   "Tile Bitmap"
         End
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
      End
      Begin VB.Menu openmnu 
         Caption         =   "Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu savemnu 
         Caption         =   "Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu saveasmnu 
         Caption         =   "Save As..."
         Shortcut        =   ^A
      End
      Begin VB.Menu saveallmnu 
         Caption         =   "Save All"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu exitmnu 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu toolkitmnu 
      Caption         =   "Toolkit"
      Begin VB.Menu testgamemnu 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu selectlanguagemnu 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub46 
         Caption         =   "-"
      End
      Begin VB.Menu mnuShowSplashScreen 
         Caption         =   "Show Splash Screen"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuTips 
         Caption         =   "Show Tips?"
         Checked         =   -1  'True
      End
   End
   Begin VB.Menu buildmnu 
      Caption         =   "Build"
      Begin VB.Menu createpakfilemnu 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu makeexemnu 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub44 
         Caption         =   "-"
      End
      Begin VB.Menu createsetupmnu 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu windowmnu 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu ShowToolsMNU 
         Caption         =   "Show/Hide Tools"
      End
   End
   Begin VB.Menu helpmnu 
      Caption         =   "Help"
      Begin VB.Menu usersguidemnu 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu rpgcodeprimermnu 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu rpgcodereferencemnu 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub45 
         Caption         =   "-"
      End
      Begin VB.Menu tutorialmnu 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu historytxtmnu 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu registrationinfomnu 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu aboutmnu 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "tkMainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'============================================================================
' All contents copyright 2003, 2004, Christopher Matthews or Contributors
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'============================================================================

'============================================================================
' Main MDI form
'============================================================================

Option Explicit

'============================================================================
' Globals
'============================================================================
Public boardToolbar As New cBoardToolbar
Public boardCount As Integer
Public toolTop As Integer
Public lastIconForm As Form
Public doNotShowTools As Boolean
Public ignoreFocus As Boolean

'============================================================================
' Members
'============================================================================
Private cnvBkgImage As Long
Private ignoreFlag As Boolean
Private frmIndex As Long
Private WithEvents m_tabs As cMDITabs
Attribute m_tabs.VB_VarHelpID = -1

Private Enum TK_BARD_STATE
    notOpen = 0
    Visible = 1
End Enum

Private Type TK_BARD_INFO
    State As TK_BARD_STATE
    hwnd As Long
End Type

Private theBard As TK_BARD_INFO

Private Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long

'============================================================================
' Force a refresh of the tab bar
'============================================================================
Public Sub refreshTabs()
    Call m_tabs.ForceRefresh
End Sub

'============================================================================
' Fill the tree with the project's file
'============================================================================
Public Sub fillTree(ByVal parentNode As String, ByVal folder As String): On Error Resume Next

    Dim a As String, b As String, gfx As Long

    a = Dir(folder & "*.*", vbDirectory)
    a = Dir()
    a = Dir()

    TreeView1.Sorted = True     'Sort alphabetically.

    With TreeView1.Nodes
        
        Do Until a = ""
        
            .Item(parentNode).Sorted = True
            
            If GetAttr(folder & a) = vbDirectory Then
            'This is a folder.
            
                If parentNode <> "" Then
                    'There is already a parent node.
                
                    Call .Add(parentNode, tvwChild, a, a, 1)
                    'do subtrees...
                    Call fillTree(a, folder & a & "\")
                
                    'reset dir counter
                    b = Dir(folder & "*.*", vbDirectory)
                    Do Until a = b
                        b = Dir()
                    Loop
                    
                Else
                    'No parent node - create.
                
                    Call .Add(, , a, a, 1)
                    'do subtrees...
                    Call fillTree(a, folder & a & "\")
                
                    'reset dir counter
                    b = Dir(folder & "*.*", vbDirectory)
                    Do Until a = b
                        b = Dir()
                    Loop
                    
                End If
                
            Else
                'This is a file.
            
                Select Case UCase(commonRoutines.extention(a))
                    Case "GAM": gfx = 3
                    Case "TST", "GPH": gfx = 4
                    Case "TAN": gfx = 5
                    Case "BRD": gfx = 6
                    Case "PRG": gfx = 7
                    Case "TEM": gfx = 8
                    Case "ITM": gfx = 9
                    Case "ENE": gfx = 10
                    Case "BKG": gfx = 11
                    Case "SPC": gfx = 12
                    Case "STE": gfx = 13
                    Case "FNT": gfx = 14
                    Case "ANM": gfx = 15
                    Case "TBM": gfx = 16
                    Case "ISO": gfx = 17
                    Case Else: gfx = 2
                End Select
                
                If parentNode <> "" Then
                    'If file is in a subdirectory.
                    
                    Call .Add(parentNode, tvwChild, a, a, gfx)
                Else
                    'File is in the root.
                
                    Call .Add(, , a, a, gfx)
                End If
                
            End If 'isFolder.
            a = Dir()
            
        Loop
    
    End With

End Sub

'============================================================================
' The 2 buttons above the tree
'============================================================================
'Open file
Private Sub cmdOpenFromTree_Click()
    Call TreeView1_DblClick
End Sub
'Refresh tree
Private Sub cmdRefreshTree_Click()
    Call fillTree("", projectPath)
End Sub

'============================================================================
' Current tileset browser draw grid check button.
'============================================================================
Private Sub chkCurTilesetDrawGrid_Click(): On Error Resume Next
    'Redraw the tileset (with or without grid).
    Call fillTilesetBar
End Sub

Private Sub redrawTilesetBar(Optional ByVal autoRefresh As Boolean = False): On Error Resume Next
'===================================================================
'Draws the opened tileset in the flyout tileset viewer.
'Called by fillTilesetBar, tilesetScroller_Change
'===================================================================
    Dim isoFormat As Long, tilesWide As Long, tilesHigh As Long
    Dim x As Long, y As Long
    
    If configfile.lastTileset = vbNullString Then Exit Sub
    If tstnum = 0 Then tstnum = 1
    
    If UCase$(GetExt(configfile.lastTileset)) = "ISO" Then isoFormat = 2
    
    'Calculate the number of tiles that will be in view.
    If isoFormat = 0 Then
        tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 32)
    Else
        tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 64)
    End If
    tilesHigh = Int((currentTilesetForm.Height / Screen.TwipsPerPixelY) / 32)
    
    'This export requires isoFormat = 2 for .iso tiles!!
    'tstnum is the tile to start drawing at.
    Call GFXInitScreen(640, 480)
    Call GFXdrawTstWindow(projectPath & tilePath & configfile.lastTileset, _
                          currentTilesetForm.hdc, _
                          tstnum, _
                          tilesWide, _
                          tilesHigh, _
                          isoFormat)
    
    'Now, draw the grid.
    If chkCurTilesetDrawGrid.value Then
    
        'Draw vertical lines.
        If isoFormat = 0 Then
            'Not isometric
            For x = 0 To tilesWide * 32 Step 32
                Call vbPicLine(currentTilesetForm, x, 0, x, tilesHigh * 32, QBColor(1))
            Next x
            'Draw horizontal lines.
            For y = 0 To (tilesHigh + 1) * 32 Step 32
                Call vbPicLine(currentTilesetForm, 0, y, tilesWide * 32, y, QBColor(1))
            Next y
        Else
            For x = 0 To tilesWide * 64 Step 64
                Call vbPicLine(currentTilesetForm, x, 0, x, tilesHigh * 32, QBColor(1))
            Next x
            'Draw horizontal lines.
            For y = 0 To (tilesHigh + 1) * 32 Step 32
                Call vbPicLine(currentTilesetForm, 0, y, tilesWide * 64, y, QBColor(1))
            Next y
        End If

        
    End If 'Draw grid.
        
    If autoRefresh Then
        Call vbPicRefresh(currentTilesetForm)
    End If
    
End Sub

Private Sub fillTilesetBar(): On Error Resume Next
'=================================================
'Sets up the drawing of the flyout tileset viewer.
'Called by: popButton_click, changeSelectedTileset_click
'=================================================
'Edited by Delano for 3.0.4 new isometric tilesets.
'Configured the scroller to scroll row by row.

'Fill the current tileset bar with the contents of the current tileset,
'or draws it for the first time.
    Dim tilesHigh As Integer, tilesWide As Integer, setType As Integer
    
    'resize the picture box...
    currentTilesetForm.Height = tilesetBar.Height - (900)
    If currentTilesetForm.Height Mod (32 * Screen.TwipsPerPixelY) <> 0 Then
        currentTilesetForm.Height = currentTilesetForm.Height - (currentTilesetForm.Height Mod (32 * Screen.TwipsPerPixelY))
    End If
    tilesetScroller.Height = currentTilesetForm.Height
    
    'Clear the picture box. Added for non-flickering scrolling.
    Call vbPicAutoRedraw(currentTilesetForm, False)
    currentTilesetForm.Picture = LoadPicture("")
    
    If configfile.lastTileset$ <> "" Then
    
        setType = tilesetInfo(projectPath$ + tilePath$ + configfile.lastTileset$)
        If setType = TSTTYPE Or setType = ISOTYPE Then
            'tilesetInfo now returns 2 for isometric tilesets. Set type constants introduced.
            
            currentTilesetInfo.Caption = LoadStringLoc(2035, "Tileset") + " " + configfile.lastTileset + LoadStringLoc(2036, ": Contains") + str$(tileset.tilesInSet) + " Tiles"
    
            'Set the scroller depending on the tileset type.
            If setType = ISOTYPE Then
                tilesWide = (currentTilesetForm.Width / Screen.TwipsPerPixelY) / 64
            Else
                tilesWide = (currentTilesetForm.Width / Screen.TwipsPerPixelY) / 32
            End If
            tilesHigh = (currentTilesetForm.Height / Screen.TwipsPerPixelY) / 32
            
            'This will return the number of rows. Negative signs make use of
            'Int's handling of negative numbers to always round *down*.
            'Now we have the number of rows, but we want to stop when the last row
            'is at the bottom of the window. Take off the viewable number of rows.
            
            tilesetScroller.max = (-Int(tileset.tilesInSet / (-tilesWide))) - tilesHigh
                        
            If tilesetScroller.max < 1 Then
                'If all the tiles are contained in the window.
                tilesetScroller.Enabled = False
            Else
                'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
                tilesetScroller.LargeChange = tilesHigh - 1
                tilesetScroller.Enabled = True
            End If
                    
            ignoreFlag = True
            tilesetScroller.value = 0
            ignoreFlag = False
            
            Call vbPicAutoRedraw(currentTilesetForm, True)
            Call redrawTilesetBar(True)
            'Call drawTstGrid(True)
        End If
    Else
        'No tileset has been previously opened.
        tilesetScroller.Enabled = False
    End If
End Sub

Public Sub openFile(ByVal fName As String)

    On Error Resume Next

    Dim ex As String
    ex = UCase(extention(fName))
    
    Dim frm As Form
    
    Select Case ex

        Case "GPH"
            Set frm = New tileedit
            Call frm.Show
            Set activeTile = frm
            Call activeTile.openFile(fName)
            
        Case "TST", "ISO"
        
            'Information for the tileset browser.
            tstnum = 0
            tstFile = RemovePath(fName)
            configfile.lastTileset = tstFile
            
            Call FileCopy(fName, projectPath & tilePath & tstFile)
            
            'Show the tileset browser.
            Call tilesetForm.Show(vbModal)
            
            'Load only if a tile has been selected.
            If setFilename <> vbNullString Then
                Set frm = New tileedit
                Call frm.Show
                Set activeTile = frm
                Call activeTile.openFile(projectPath & tilePath & setFilename)
            End If

        Case "BRD"
            Set frm = New boardedit
            Call frm.Show
            Set activeBoard = frm
            Call activeBoard.openFile(fName)

        Case "TBM"
            Set frm = New editTileBitmap
            Call frm.Show
            Set activeTileBmp = frm
            Call activeTileBmp.openFile(fName)

        Case "PRG"
            Set frm = New rpgcodeedit
            Call frm.Show
            Set activeRPGCode = frm
            Call activeRPGCode.openFile(fName)
            
        Case "SPC"
            Set frm = New editsm
            Call frm.Show
            Set activeSpecialMove = frm
            Call activeSpecialMove.openFile(fName)
            
        Case "TEM"
            Set frm = New characteredit
            Call frm.Show
            Set activePlayer = frm
            Call activePlayer.openFile(fName)
            
        Case "ITM"
            Set frm = New EditItem
            Call frm.Show
            Set activeItem = frm
            Call activeItem.openFile(fName)
            
        Case "FNT"
            'Call fontedit.openFile(fName$)
            
        Case "ENE"
            Set frm = New editenemy
            Call frm.Show
            Set activeEnemy = frm
            Call activeEnemy.openFile(fName)
            
        Case "BKG"
            Set frm = New editBackground
            Call frm.Show
            Set activeBackground = frm
            Call activeBackground.openFile(fName)
            
        Case "STE"
            Set frm = New editstatus
            Call frm.Show
            Set activeStatusEffect = frm
            Call activeStatusEffect.openFile(fName)
            
        Case "ANM"
            Set frm = New animationeditor
            Call frm.Show
            Set activeAnimation = frm
            Call activeAnimation.openFile(fName)

        Case "TAN"
            Set frm = New tileanim
            Call frm.Show
            Set activeTileAnm = frm
            Call activeTileAnm.openFile(fName)
            
        Case "RFM"
            Call tkvisual.openFile(fName)
            
        Case Else
            Dim theAppTemp As String
            theAppTemp = determineDefaultApp(fName)
            Dim ff As Long
            ff = FreeFile()
            Open TempDir & "temp" For Output As ff
                Print #ff, theAppTemp
            Close ff
            Open TempDir & "temp" For Input As ff
                Dim theApp As String
                theApp = replace(replace(fread(ff), vbCrLf, ""), " ", "")
            Close ff
            Dim commandLine As String
            commandLine = theApp & " " & """" & resolve(CurDir) & fName & """"
            Call Shell(commandLine, vbNormalFocus)

    End Select
    
    If Not frm Is Nothing Then
        Call m_tabs.ForceRefresh
        Call frm.SetFocus
    End If

End Sub

Public Sub aboutmnu_Click(): On Error Resume Next
    Call helpAbout.Show(vbModal)
End Sub

Private Sub ambientlight_Change(): On Error Resume Next
    Call activeBoard.changeAmbientLight
End Sub

Private Sub ambientnumber_Change(): On Error Resume Next
    Call activeBoard.changeAmbientNumber
End Sub

Public Sub arrangeiconsmnu_Click(): On Error Resume Next
    Call Me.Arrange(3)
End Sub

Private Sub arrowtype_Click()
    Call toggle_Click
End Sub

Private Sub Command1_Click(): On Error Resume Next
    Call activeTile.Command1_Click
End Sub

Public Sub cascademnu_Click(): On Error Resume Next
    Call Me.Arrange(0)
End Sub

Private Sub Command14_Click()
    leftbar.Visible = False
End Sub

Private Sub Command2_Click()
    popButton(1).value = 0
    Call popButton_Click(1)
End Sub

Private Sub Command20_Click()
    animTile.Enabled = False
End Sub

Private Sub Command3_Click()
    Call showtoolsmnu_Click
End Sub

Public Sub createpakfilemnu_Click(): On Error GoTo ErrorHandler
    
    Dim a As Boolean
    a = PAKTestSystem()
    If a = False Then Exit Sub
    
    pakfile.Show
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub createsetupmnu_Click(): On Error Resume Next
    Dim a As Long
    a = Shell("setupkit.exe", 1)
    'mainoption.ZOrder 1
    Exit Sub
End Sub

Private Sub currentTilesetForm_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
'===========================================================
'MouseDown event on the flyout tileset viewer.
'===========================================================
'Edited by Delano for 3.0.4 new isometric tilesets.
'Added code for selection of isometric tiles.
'Fixed problem where higher tile numbers could be selected.

    Dim iMetric As Integer, tileNumber As Integer
    Dim tilesWide As Integer, tilesHigh As Integer, tileX As Integer, tileY As Integer
    
    If configfile.lastTileset$ = "" Then Exit Sub
    
    'Added:If the current tilset (configfile.lastTileset$) is isometric.
    'Same return as for getTileInfo on a .iso.
    If UCase$(GetExt(configfile.lastTileset$)) = "ISO" Then iMetric = 2
    
    'Determine the tile that has been clicked on by considering the
    'size of the form, the position of the scroller, and the type of
    'tileset.
    
    If iMetric = 0 Then
        'Not isometric.
        tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 32)   'width of window.
        tileX = Int(x / 32)                                                        'x-tile clicked.
    Else
        tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 64)
        tileX = Int(x / 64)
    End If
    
    tilesHigh = Int((currentTilesetForm.Height / Screen.TwipsPerPixelY) / 32)
    tileY = Int(y / 32)
    
    'Alterations for the scroller. Now scrolls row by row.
    tileNumber = (tileY * tilesWide) + tileX + 1                        'Tile clicked if scroller = 0.
    tileNumber = tileNumber + (tilesetScroller.value * tilesWide)       'Add the rows that have been scrolled.
    
    'Fix:Check we've not selected a tile that isn't in the set.
    If tileNumber > tileset.tilesInSet Then Exit Sub
    
    setFilename = configfile.lastTileset & CStr(tileNumber)
    'inform the system that the set filename has changed. For loading into whichever editor is active.
    Call activeForm.changeSelectedTile(setFilename$)

End Sub

Private Sub exitbutton_Click()
    popButton(0).value = 0
    Call popButton_Click(0)
End Sub

Public Sub exitmnu_Click(): On Error Resume Next
    Call Unload(Me)
End Sub

Public Sub historytxtmnu_Click(): On Error GoTo ErrorHandler
    'commandt$ = "start history.txt"
    'a = Shell(commandt$)
    Call BrowseFile("history.txt")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub installupgrademnu_Click(): On Error Resume Next
    Dim aa As Long, a As Long
    aa = MsgBox(LoadStringLoc(929, "In order to install an upgrade, the Toolkit must be shut down.  You will lose unsaved info.  Do you wish to close the Toolkit now?"), vbYesNo, LoadStringLoc(930, "Install Upgrade"))
    If aa = 6 Then
        a = Shell("tkupdate.exe")
        Call exitmnu_Click
        End
        Exit Sub
    End If
    Exit Sub
End Sub

Private Sub killNewBar_Click()
    popButton(1).value = 0
End Sub

Private Sub killTilesetBar_Click()
    popButton(2).value = 0
    Call popButton_Click(2)
End Sub

'============================================================================
' Close a window
'============================================================================
Private Sub m_tabs_CloseWindow(ByVal hwnd As Long)

    ' Find the window
    Dim frm As Form
    For Each frm In Forms
        If (frm.hwnd = hwnd) Then

            ' Close this window
            Call Unload(frm)
            Exit For

        End If
    Next frm

End Sub

Private Sub mainToolbar_ButtonClick(ByVal Button As MSComctlLib.Button): On Error Resume Next
'==================================
'Added: Tilesetedit button - Delano

    Select Case Button.Key
        Case "new":
        Case "properties":
            editmainfile.Show
        Case "open":
            Call tkMainForm.openmnu_Click
        Case "save":
            Call tkMainForm.savemnu_Click
        Case "saveall":
            Call tkMainForm.saveallmnu_Click
        Case "bard":
            Call LaunchBard
        Case "website":
            Call BrowseLocation("http://www.rpgtoolkit.com")
        Case "chat":
            Call BrowseLocation("http://rpgtoolkit.com/chat.html")
        Case "configTk":
            Call config.Show
        Case "tilesetedit":                 'Added.
            tilesetedit.Show vbModal
        Case "testrun":
            Call testgamemnu_Click
    End Select
End Sub

'============================================================================
'Code for the Bard by KSNiloc
'============================================================================

Private Sub LaunchBard()
 
    '========================================================================
    'Launches the Bard
    '========================================================================
 
    Select Case theBard.State
 
        Case notOpen
            'Launch the program...
            theBard.hwnd = getWinHandle(Shell("bard3.exe", vbNormalFocus))
            'Make it a child of TKMainForm...
            SetParent theBard.hwnd, Me.hwnd
            'Flag that the Bard is open...
            theBard.State = Visible

        Case Visible
            If IsWindow(theBard.hwnd) = 1 Then
                'Tis already open- we need do nothing
                Exit Sub
            Else
                'It has been closed...
                theBard.State = notOpen
                'Recurse!
                LaunchBard
            End If
    
    End Select
 
End Sub

Private Sub exitTheBard()

    '========================================================================
    'Exits the Bard
    '========================================================================

    If theBard.State = Visible Then CloseWindow theBard.hwnd

End Sub

Public Sub MDIForm_Resize(): On Error Resume Next

    'KSNiloc...
    'ProjectListSize_Timer

    'TreeView1.height = Me.height - 4985
    fileTree1.Height = Me.Height - 2000
    
End Sub

Private Sub mnuShowSplashScreen_Click()
    mnuShowSplashScreen.Checked = Not mnuShowSplashScreen.Checked
    If mnuShowSplashScreen.Checked Then
        Call SaveSetting("RPGToolkit3", "Settings", "Splash", "1")
    Else
        Call SaveSetting("RPGToolkit3", "Settings", "Splash", "0")
    End If
End Sub

Private Sub mnuTips_Click()
    mnuTips.Checked = Not mnuTips.Checked
    configfile.tipsOnOff = booleanToLong(mnuTips.Checked)
End Sub

Private Sub NewBarTop_mouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim uD As TK_UNDOCK_DATA
    uD.e = True: uD.W = True
    Call unDock(newBar, "New", uD)
    newBarContainerContainer.Visible = False
    popButton(1).Enabled = False
End Sub

Private Sub ReadCommandLine_Timer()
   
    On Error Resume Next
    
    DoEvents
    ReadCommandLine.Enabled = False

    If LCase(Right(GetExt(Command), 3)) = "prg" Then
        Dim Edit As New rpgcodeedit
        With Edit
            .tag = "1"
            .mnuNewProject.Visible = False
            .mnuNew.Visible = False
            .mnuNewPRG.Visible = True
            .mnuOpenProject.Visible = False
            .mnuSaveAll.Visible = False
            .closemnu.Visible = False
            .mnuToolkit.Visible = False
            .mnuBuild.Visible = False
            .mnuWindow.Visible = False
            Call .Show
            Call m_tabs.ForceRefresh
            Call .SetFocus
            Dim fCaption As String
            Dim filename As String
            fCaption = Command
            filename = absNoPath(fCaption)
            If Command = ".prg" Or Command = "prg" Then
                fCaption = "Untitled"
                filename = fCaption
            End If
            .Caption = LoadStringLoc(803, "RPGCode Program Editor") & "  (" & filename & ")"
            Call m_tabs.ForceRefresh
            .mnuNotepadMode.Checked = False
            .mnuNotepadMode.Visible = False
            .mnuNotepadMode_Click
            If Left < 0 Then Left = 0
            If Top < 0 Then Top = 0
            DoEvents
            If fCaption <> "Untitled" Then
                Call .OpenProgram(Command)
                rpgcodeList(activeRPGCodeIndex).prgName = Command
                CommonGlobals.filename(2) = Command
            End If
        End With
    End If

End Sub

'============================================================================
'End code for the Bard by KSNiloc
'============================================================================

Private Sub mainToolbar_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu): On Error Resume Next
    Dim frm As Form
    Select Case ButtonMenu.index
        Case 1:
            Set frm = New tileedit
        Case 2:
            Set frm = New tileanim
        Case 3:
            Set frm = New boardedit
        Case 4:
            Set frm = New characteredit
        Case 5:
            Set frm = New EditItem
        Case 6:
            Set frm = New editenemy
        Case 7:
            Set frm = New rpgcodeedit
        Case 8:
            Set frm = New editBackground
        Case 9:
            Set frm = New editsm
        Case 10:
            Set frm = New editstatus
        Case 11:
            Set frm = New animationeditor
        Case 12:
            Set frm = New editTileBitmap
    End Select
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub makeexemnu_Click(): On Error GoTo ErrorHandler

    Dim a As Boolean
    If Not PAKTestSystem() Then Exit Sub

    Call makeexe.Show
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub MDIForm_Activate()
    tilesetContainer.Height = Me.Height - 50
    Call MDIForm_Resize
    Call configForm
    ' Call refreshOpenFileList
End Sub

Private Sub MDIForm_Load(): On Error Resume Next
'=====================================================
'Call added for isometrics, 3.0.4

    Set m_tabs = New cMDITabs
    Call m_tabs.Attach(Me.hwnd)
    Call m_tabs.ForceRefresh

    lblAnimNewTBM.MousePointer = 99
    lblAnimNewTBM.MouseIcon = Images.MouseLink()

    Call createIsoMask
    ' Call LocalizeForm(Me)
    
    toolTop = 240
    
    mnuShowSplashScreen.Checked = integerToBoolean(GetSetting("RPGToolkit3", "Settings", "Splash", "1"))
    mnuTips.Checked = integerToBoolean(configfile.tipsOnOff)
    
    Dim upgradeYN As Boolean
    'check if we have top upgrade...
    upgradeYN = checkForArcPath()
    If upgradeYN = True Then
        Dim a As Long
        a = MsgBox("It appears that you have upgraded from version 2.06b or lower.  This version of the Toolkit uses a new filesystem.  Would you like to upgrade your filesystem? (if you have already upgraded it, you still need to delete the old file system.  In this case, goto File/Delete Old File System)", vbYesNo, "Upgrade Your Game")
        If a = 6 Then
            'show as modal form
            upgradeform.Show (1)
            Exit Sub
        End If
    End If
    ' ! KSNiloc...
    
    If Command = "" Then
        SaveSetting "RPGToolkit3", "Settings", "Path", App.path & "\"
    Else
        currentDir = GetSetting("RPGToolkit3", "Settings", "Path")
        ChDir currentDir
    End If
    
    If configfile.lastProject <> "" And Command = "" Then
        Call traceString("Opening project..." + gamPath$ & configfile.lastProject$)
        
        Call openMainFile(gamPath$ & configfile.lastProject$)
        
        Call traceString("Done opening project..." + gamPath$ & configfile.lastProject$)
        mainFile$ = configfile.lastProject$
        loadedMainFile = mainFile
        tkMainForm.Caption = "RPG Toolkit Development System, Version 3.0 (" + configfile.lastProject$ + ")"
        Call fillTree("", projectPath$)
    Else
        loadedMainFile = configfile.lastProject
        mainFile = configfile.lastProject
    End If
    
End Sub

'=====================================================
' Config this form
'=====================================================
Public Sub configForm()
    On Error Resume Next
    If configfile.wallpaper <> "" Then
        Call ShowPic(configfile.wallpaper)
    End If
    With mainToolbar.Buttons
        Call .Remove(16)
        Call .Remove(17)
        Call .Remove(18)
        Call .Remove(19)
        Dim a As Long
        For a = 0 To 4
            If configfile.quickTarget(a) <> "" Then
                Call .Add(, , "Quick Launch " & a, , LoadPicture(configfile.quickIcon(a)))
                .Item(a).Enabled = integerToBoolean(configfile.quickEnabled(a))
            End If
        Next a
    End With
End Sub

Private Sub MDIForm_Unload(ByRef Cancel As Integer): On Error GoTo ErrorHandler
    Set m_tabs = Nothing
    Call exitTheBard
    Call saveConfigAndEnd("toolkit.cfg")
    End

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Dim frm As Form
    Set frm = New editBackground
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

'===========================================================================
' File -> Open Project
'===========================================================================
Public Sub mnuOpenProject_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo, antiPath As String
    
    ChDir (currentDir)
    
    dlg.strDefaultFolder = gamPath
    dlg.strTitle = "Open Project"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "Supported Files|*.gam|RPG Toolkit Project (*.gam)|*.gam|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then
        filename(1) = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
        mainFile = antiPath
    Else
        'User pressed cancel.
        Exit Sub
    End If
    
    If filename(1) = vbNullString Then Exit Sub
    
    ChDir (currentDir)
    FileCopy filename(1), gamPath & antiPath
    
    'Close all open editors. Got to do it in reverse order!
    Dim i As Long
    For i = Forms.count - 1 To 2 Step -1
        If Forms(i).formType() >= FT_BOARD Then Call Unload(Forms(i))
    Next i
    
    'Open the main file and show the editor.
    Call openMainFile(filename(1))
    editmainfile.Show
    
    configfile.lastProject = antiPath
    tkMainForm.Caption = "RPG Toolkit Development System, Version 3.0 (" & antiPath & ")"
    
    Call tkMainForm.TreeView1.Nodes.Clear       'Clear all files from the previous project. [Delano]
    Call tkMainForm.fillTree("", projectPath)  'Refill the tree.
    
    loadedMainFile = configfile.lastProject ' [KSNiloc]
    
End Sub

Public Sub newanimationmnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New animationeditor
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newanimtilemnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New tileanim
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

'Private Sub newBar_LostFocus(): On Error Resume Next
'    If Not (ignoreFocus) Then
'        popButton(1).value = 0
'    End If
'End Sub

Public Sub newboardmnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New boardedit
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newenemymnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New editenemy
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newitemmnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New EditItem
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newplayermnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New characteredit
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newprojectmnu_Click(): On Error GoTo ErrorHandler
    newGame.Show 1
    'mainoption.ZOrder 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub newrpgcodemnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New rpgcodeedit
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newspecialmovemnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New editsm
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newstatuseffectmnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New editstatus
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newtilebitmapmnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New editTileBitmap
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub newtilemnu_Click(): On Error Resume Next
    Dim frm As Form
    Set frm = New tileedit
    Call frm.Show
    Call m_tabs.ForceRefresh
    Call frm.SetFocus
End Sub

Public Sub openmnu_Click(): On Error Resume Next
'=================================================
'Open file in main menu/on toolbar/folder tree
'=================================================
'Edited by Delano for 3.0.4 new isometric tilesets.
'Added .iso to the list of openable files.

    ChDir (currentDir$)
    Dim antiPath As String
    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath$
    dlg.strTitle = "Open"
    'dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.tbm;*.brd;*.gph;*.tst;*.iso;*.tan;*.prg;*.tem;*.itm;*.ene;*.bkg;*.ste;*.anm;*.rfm|Tile (*.tst;*.tan;*.gph;*.iso)|*.tst;*.tan;*.gph;*.iso|Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|Player (*.tem)|*.tem|Item (*.itm)|*.itm|Enemy (*.ene)|*.ene|Fight Background (*.bkg)|*.bkg|Status Effect (*.ste)|*.ste|Animation (*.anm)|*.anm|Tile Bitmap (*.tbm)|*.tbm|Visual Form (*.rfm)|*.rfm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then   'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    
    Call tkMainForm.openFile(filename$(1))
End Sub

Private Sub palettebox_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeTile.palettebox_MouseDown(Button, Shift, x, y)
End Sub

Private Sub Picture1_Click(): On Error Resume Next
    Call activeBoard.selectAmbientColor
End Sub

'=========================================================================================
' ADDED FOURTH BUTTON FOR BOARD TOOLBAR
Private Sub popButton_Click(index As Integer): On Error Resume Next
    
    Select Case index
        Case 0
            'File tree.
            If popButton(index).value = 1 Then
                popButton(1).value = 0
                popButton(2).value = 0
                popButton(3).value = 0
                rightbar.Visible = True
                rightbar.SetFocus
                Call fillTree("", projectPath)      'Refill the tree every time.
            Else
                rightbar.Visible = False
            End If
            
        Case 1
            'Open editors.
            If popButton(index).value = 1 Then
                popButton(0).value = 0
                popButton(2).value = 0
                popButton(3).value = 0
                newBarContainerContainer.Visible = True
            Else
                newBarContainerContainer.Visible = False
            End If
            
        Case 2
            'Tileset browser.
            If popButton(index).value = 1 Then
                popButton(0).value = 0
                popButton(1).value = 0
                popButton(3).value = 0
                tstnum = 0
                tilesetBar.Visible = True
                Call fillTilesetBar
                tilesetBar.SetFocus
            Else
                tilesetBar.Visible = False
            End If
            
        Case 3
            'Board editor toolbar.
            If popButton(index).value = 1 Then
                popButton(0).value = 0
                popButton(1).value = 0
                popButton(2).value = 0
                Call boardToolbar.Objects.Populate(activeBoardIndex)
                pTools.Visible = True
                pTools.SetFocus
            Else
                pTools.Visible = False
            End If
            
    End Select
End Sub
'=========================================================================================

Private Sub prgDebug_Click(): On Error Resume Next
    Call activeRPGCode.prgDebug
End Sub

Private Sub prgEventEdit_Click(): On Error Resume Next
    Call activeRPGCode.prgEventEdit
End Sub

Private Sub prgRun_Click(): On Error Resume Next
    Call activeRPGCode.prgRun
End Sub

Public Sub registrationinfomnu_Click(): On Error GoTo ErrorHandler
    MsgBox "This is an open source project"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub rightbar_LostFocus(): On Error Resume Next
    If Not (ignoreFocus) Then
        popButton(0).value = 0
        'rightbar.width = 400
        'Command7.caption = "<"
    End If
End Sub

Private Sub rightbar_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    'ignoreFocus = False
    'rightbar.SetFocus
    'If rightbar.width = 2730 Then
    'Else
    '    rightbar.width = 2730
    '    Command7.caption = ">"
    '    Call rightbar.SetFocus
    'End If
End Sub

Public Sub rpgcodeprimermnu_Click(): On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help2, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub rpgcodereferencemnu_Click(): On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help3, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub saveallmnu_Click(): On Error Resume Next
    'save all...
    'KSNiloc says: If/when we upgrade to vb.net this can be improved
    '              via inheritance
    Dim frm As VB.Form
    Dim ani As animationeditor
    Dim brd As boardedit
    Dim chr As characteredit
    Dim bkg As editBackground
    Dim ene As editenemy
    Dim itm As EditItem
    Dim man As editmainfile
    Dim spcMove As editsm
    Dim sta As editstatus
    Dim tbm As editTileBitmap
    Dim rpg As rpgcodeedit
    Dim aniTile As tileanim
    Dim tile As tileedit
    For Each frm In Forms
        Select Case frm.tag
            Case 1
                Set ani = frm
                ani.saveFile
            Case 2
                Set brd = frm
                brd.saveFile
            Case 3
                Set chr = frm
                chr.saveFile
            Case 4
                Set bkg = frm
                bkg.saveFile
            Case 5
                Set ene = frm
                ene.saveFile
            Case 6
                Set itm = frm
                itm.saveFile
            Case 7
                Set man = frm
                man.saveFile
            Case 8
                Set spcMove = frm
                spcMove.saveFile
            Case 9
                Set sta = frm
                sta.saveFile
            Case 10
                Set tbm = frm
                tbm.saveFile
            Case 12
                Set rpg = frm
                rpg.saveFile
            Case 13
                Set aniTile = frm
                aniTile.saveFile
            Case 14
                Set tile = frm
                tile.saveFile
        End Select
    Next frm
End Sub

Public Sub saveasmnu_Click(): On Error Resume Next
    'Call activeForm.saveAsFile
End Sub

Public Sub savemnu_Click(): On Error Resume Next
    'TBD
    activeForm.saveFile
End Sub

Public Sub selectlanguagemnu_Click(): On Error Resume Next
    selectLanguage.Show
    'MsgBox "lang"
End Sub

Public Sub showprojectlistmnu_Click(): On Error Resume Next
    If rightbar.Visible Then
        rightbar.Visible = False
    Else
        rightbar.Visible = True
    End If
End Sub

Public Sub showtoolsmnu_Click(): On Error Resume Next

    ' ! MODIFIED BY KSNiloc...
    
    If doNotShowTools Then Exit Sub
        
    If leftbar.Visible Then
        leftbar.Visible = False
        leftBarContainer.Visible = False
    Else
        leftbar.Visible = True
        leftBarContainer.Visible = True
    End If
End Sub

Public Sub testgamemnu_Click()
    On Error Resume Next
    Dim Command As String
    'Checks to see if there is a .gam file.
    If mainFile$ = "" Then
        MsgBox LoadStringLoc(926, "Cannot test run-- no project is loaded!")
    Else
        'Construct the call with the .gam file as the parameter.
        Command = "trans3 " & mainFile
        'Run trans3 through the Shell. Fix: Added second argument, to give trans3 the focus.
        Call Shell(Command$, vbNormalFocus)
    End If
End Sub

Private Sub theBardTimer_Timer()
    Call m_tabs.ForceRefresh
End Sub

Private Sub tileBmpAmbientSlider_Change(): On Error Resume Next
    Call activeTileBmp.tileBmpAmbientSlider
End Sub

Private Sub tilebmpColor_Click(): On Error Resume Next
    Call activeTileBmp.changeColor
End Sub

Private Sub tilebmpDrawLock_Click(): On Error Resume Next
    Call activeTileBmp.tilebmpDrawLock
End Sub

Private Sub tilebmpEraser_Click(): On Error Resume Next
    Call activeTileBmp.tilebmpEraser
End Sub

Private Sub tilebmpGrid_Click(): On Error Resume Next
    Call activeTileBmp.tilebmpGrid(tilebmpGrid.value)
End Sub

Private Sub tilebmpRedraw_Click(): On Error Resume Next
    Call activeTileBmp.tilebmpRedraw
End Sub

Private Sub tilebmpSelectTile_Click(): On Error Resume Next
    Call activeTileBmp.tilebmpSelectTile
End Sub

Private Sub tileBmpSizeOK_Click(): On Error Resume Next
    Call activeTileBmp.tileBmpSizeOK
End Sub

Private Sub tileBmpSizeX_Change(): On Error Resume Next
    Call activeTileBmp.tilebmpSizeX
End Sub

Private Sub tileBmpSizeY_Change(): On Error Resume Next
    Call activeTileBmp.tileBmpSizeY
End Sub

Private Sub tileColorChage_Click()
    On Error Resume Next
    Call activeTile.changeColor
End Sub

Private Sub tileGrid_Click(): On Error Resume Next
    Call activeTile.tileGrid(tileGrid.value)
End Sub

Public Sub tilehorizonatllymnu_Click(): On Error Resume Next
    Me.Arrange 1
End Sub

Private Sub tileRedraw_Click(): On Error Resume Next
    Call activeTile.tileRedraw
End Sub

Private Sub tilesetBar_LostFocus(): On Error Resume Next
    If Not (ignoreFocus) Then
    '    popButton(2).value = 0
    End If
End Sub

Private Sub tilesetScroller_Change(): On Error Resume Next
'=========================================================
'Scrolling the flyout tileset viewer.
'=========================================================
'Edited by Delano for 3.0.4 new isometric tilesets.
'Configured to scroll row by row.

    Dim iMetric As Integer, tilesWide As Integer, tilesHigh As Integer
        
    If ignoreFlag = False Then
        Call currentTilesetForm.SetFocus
        ignoreFocus = True
        
        If tstnum = 0 Then tstnum = 1
        
        'Added: Check the current tileset file.
        iMetric = 0
        If UCase$(GetExt(tstFile$)) = "ISO" Then iMetric = 2
        
        Call GFXInitScreen(640, 480)
        
        If iMetric = 0 Then
            tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 32)
        Else
            tilesWide = Int((currentTilesetForm.Width / Screen.TwipsPerPixelX) / 64)
        End If
        tilesHigh = Int((currentTilesetForm.Height / Screen.TwipsPerPixelY) / 32)
                
        'Scrollbar alteration: tstnum is the first tile to draw (tile in top lefthand corner).
        tstnum = (tilesetScroller.value * tilesWide) + 1      '.value is now the row.
        
        
        Call redrawTilesetBar(True)
    End If
End Sub

Private Sub tileTool_Click(index As Integer): On Error Resume Next
    Call activeTile.ToolSet(index)
End Sub

Private Sub tiletypes_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeBoard.ChangeTileType(Button, Shift, x, y)
End Sub

Public Sub tileverticallymnu_Click(): On Error Resume Next
    Call Me.Arrange(2)
End Sub

Private Sub timerIconRefresh_Timer()
    'Call addCommonIcons(lastIconForm)
End Sub

Public Sub toggle_Click(): On Error Resume Next
    Call activeBoard.toggleTileType
End Sub

Private Sub ToolsTopBar_mouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)

 ' ! ADDED BY KSNiloc...

 Dim uD As TK_UNDOCK_DATA
 uD.e = True: uD.W = True
 
 unDock leftbar, "Tools", uD
 leftBarContainer.Visible = False
 
End Sub

Private Sub TreeView1_DblClick(): On Error Resume Next
    If fileExists(projectPath & TreeView1.SelectedItem.fullPath) Then
        popButton(0).value = 0
        'Call rightbar.SetFocus
        Call tkMainForm.openFile(projectPath & TreeView1.SelectedItem.fullPath)
    End If
    ignoreFocus = False
End Sub

Private Sub TreeView1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    ignoreFocus = True
End Sub

Public Sub tutorialmnu_Click(): On Error Resume Next
    Call frmTutorial.Show(vbModal)
End Sub

Public Sub usersguidemnu_Click(): On Error GoTo ErrorHandler
    
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub ShowPic(ByRef file As String): On Error Resume Next
    
    Dim W As Long, h As Long
    
    W = Me.Width / Screen.TwipsPerPixelX
    h = Me.Height / Screen.TwipsPerPixelY
    
    If cnvBkgImage = 0 Then
        cnvBkgImage = createCanvas(W, h)
        Call canvasFill(cnvBkgImage, 0)
    End If
    
    If fileExists(file) Then
        Call canvasLoadSizedPicture(cnvBkgImage, file)
    End If
    
    Call canvasBlt(cnvBkgImage, 0, 0, GetDC(hwnd))
       
End Sub

'=========================================================================================
' BOARD EDITOR RELATED EVENTS
'=========================================================================================
' BOARD TOOLBAR EVENTS
'=========================================================================================
' close toolbar
Private Sub bTools_Close_Click(): On Error Resume Next
    popButton(3).value = 0
    pTools.Visible = False
End Sub
' set display option
Private Sub bTools_Display_Option_Click(index As Integer): On Error Resume Next
    boardToolbar.Display.Update(index) = bTools_Display_Option(index).value
End Sub
' select display format
Private Sub bTools_Objects_Display_Click(index As Integer): On Error Resume Next
    boardToolbar.Objects.Display = index
End Sub
' select object
Private Sub bTools_Objects_Tree_Click(): On Error Resume Next
    boardToolbar.Objects.click
End Sub

'=========================================================================================
' GENERAL BOARD EVENTS
'=========================================================================================
Private Sub boardDrawLock_Click(): On Error Resume Next
    Call activeBoard.boardDrawLock
End Sub
Private Sub boardEraser_Click(): On Error Resume Next
    Call activeBoard.boardEraser
End Sub
Private Sub boardFillTool_Click(): On Error Resume Next
    Call activeBoard.boardFillTool
End Sub
Private Sub boardAutotileDraw_Click(): On Error Resume Next
    Call activeBoard.boardAutotiler(boardAutotileDraw.value)
End Sub
Private Sub boardMultiSelect_Click(): On Error Resume Next
    ' Call activeBoard.boardMultiSelect
End Sub
Private Sub boardGradient_Click(): On Error Resume Next
    Call activeBoard.boardGradient
End Sub
Private Sub boardGrid_Click(): On Error Resume Next
    Call activeBoard.boardGrid(boardGrid.value)
End Sub
Private Sub boardIso_Click(): On Error Resume Next
    Call activeBoard.boardIso(boardIso.value)
End Sub
Private Sub boardRedraw_Click(): On Error Resume Next
    Call activeBoard.boardRedraw
End Sub
Private Sub boardboardselecttile(): On Error Resume Next
    Call activeBoard.boardSelectTile
End Sub
Private Sub boardSelectTile_Click(): On Error Resume Next
    Call activeBoard.boardSelectTile
End Sub
Private Sub boardTypeLock_Click(): On Error Resume Next
    Call activeBoard.boardTypeLock
End Sub
Private Sub Command21_Click(): On Error Resume Next '!AMENDED!
    Call activeBoard.drawLayers(True)
End Sub
Private Sub Command22_Click(): On Error Resume Next
    Call activeBoard.playAnimatedTile
End Sub
Private Sub currenttile_Click(): On Error Resume Next
    Call activeBoard.boardSelectTile
End Sub
Private Sub Editlayer_Click(): On Error Resume Next
    Call activeBoard.changeLayer
End Sub
Private Sub changedSelectedTileset_Click(): On Error Resume Next
'================================================================
'The open tileset button at the top of the flyout tileset viewer.
'================================================================
'Edited by Delano for 3.0.4 for new isometric tilesets.
'Added .iso permissions for the open dialog window.

    Dim antiPath As String, whichType As String
    
    ChDir (currentDir$)
    
    'Set up the dialog window for opening the tileset.
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Select Tileset"
    dlg.strDefaultExt = "tst"
    
    'Added: Allow to open files with the new .iso extension.
    dlg.strFileTypes = "Supported Types|*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile      'Filename chosen for opening. (with path)
        antiPath$ = dlg.strSelectedFileNoPath   'Filename without path.
    Else
        Exit Sub 'user pressed cancel
    End If
    
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    
    configfile.lastTileset$ = antiPath$                    'The current tileset, without path.
    tstFile$ = antiPath$
    tstnum = 0
    
    Call fillTilesetBar                         'Draw the tileset.
End Sub
'=========================================================================================
' END BOARD EDITOR RELATED EVENTS
'=========================================================================================
'=========================================================================================
' TILE EDITOR RELATED EVENTS (EDIT & NEW for 3.0.4 by Woozy)
'=========================================================================================
'(EDIT for 3.0.4)
Private Sub Command15_Click(): On Error Resume Next
    Call activeTile.Scroll(4)
End Sub
'(EDIT for 3.0.4)
Private Sub Command16_Click(): On Error Resume Next
    Call activeTile.Scroll(2)
End Sub
'(EDIT for 3.0.4)
Private Sub Command18_Click(): On Error Resume Next
    Call activeTile.Scroll(3)
End Sub
'(EDIT for 3.0.4)
Private Sub Command19_Click(): On Error Resume Next
    Call activeTile.Scroll(1)
End Sub
'(NEW for 3.0.4)
Private Sub cmdImport_Click()
 Call activeTile.convert_Click
End Sub
'(NEW for 3.0.4)
Private Sub cmdDOS_Click()
    Call activeTile.mnuDOS_Click
End Sub
'(NEW for 3.0.4)
Private Sub cmdSelColor_Click()
    Call tileedit.scolormnu_Click
End Sub
'(NEW for 3.0.4)
Private Sub cmdShadeTile_Click()
    Call tileedit.shadetle_Click
End Sub
'(NEW for 3.0.4)
Private Sub tileIsoCheck_Click()
    Call activeTile.isoChange(integerToBoolean(tileIsoCheck.value))
End Sub
'=========================================================================================
' END TILE EDITOR RELATED EVENTS
'=========================================================================================

'=========================================================================================
' ANIMATION EDITOR RELATED EVENTS
'=========================================================================================
'Set the size of the animation
Private Sub optAnimSize_Click(index As Integer): On Error Resume Next
    Call activeAnimation.setAnimSize(index)
End Sub
'Set the X-Size (Custom anim only)
Private Sub txtAnimXSize_Change(): On Error Resume Next
    Call activeAnimation.setXSize
End Sub
'Set the Y-Size (Custom anim only)
Private Sub txtAnimYSize_Change(): On Error Resume Next
    Call activeAnimation.setYSize
End Sub
'Set the pause time
Private Sub hsbAnimPause_Change(): On Error Resume Next
    Call activeAnimation.setPause
End Sub
'Set the sound
Private Sub txtAnimSound_Click(): On Error Resume Next
    Call activeAnimation.setSound
End Sub
'Clear the sound
Private Sub cmdAnimDelSound_Click(): On Error Resume Next
    Call activeAnimation.delSound
End Sub
'Set the transparent color
Private Sub cmdAnimTransp_Click(): On Error Resume Next
    Call activeAnimation.setTransp
End Sub
'Play animation
Private Sub cmdAnimPlay_Click(): On Error Resume Next
    Call activeAnimation.animPlay
End Sub
'Insert frame
Private Sub cmdAnimIns_Click(): On Error Resume Next
    Call activeAnimation.animIns
End Sub
'Delete frame
Private Sub cmdAnimDel_Click(): On Error Resume Next
    Call activeAnimation.animDel
End Sub
'One frame forward
Private Sub cmdAnimForward_Click(): On Error Resume Next
    Call activeAnimation.animForward
End Sub
'One frame back
Private Sub cmdAnimBack_Click(): On Error Resume Next
    Call activeAnimation.animBack
End Sub
'New tilebitmap
Private Sub lblAnimNewTBM_Click()
    Call newtilebitmapmnu_Click
End Sub

Private Sub animTile_Timer(): On Error Resume Next
    Call activeBoard.animateTile
End Sub
Private Sub Command4_Click(): On Error Resume Next
    'Call activeAnimation.Command7_Click
End Sub

'=========================================================================================
' END ANIMATION EDITOR RELATED EVENTS
'=========================================================================================
