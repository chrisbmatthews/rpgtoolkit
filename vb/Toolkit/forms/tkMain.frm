VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
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
   Begin VB.PictureBox projectListBar 
      Align           =   4  'Align Right
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5910
      Left            =   8775
      ScaleHeight     =   394
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   182
      TabIndex        =   77
      Top             =   360
      Visible         =   0   'False
      Width           =   2730
      Begin VB.Timer wallpaperTimer 
         Interval        =   250
         Left            =   960
         Top             =   2520
      End
      Begin VB.Timer animTileTimer 
         Enabled         =   0   'False
         Interval        =   5
         Left            =   1560
         Top             =   1920
      End
      Begin VB.Timer projectListSize 
         Interval        =   1
         Left            =   360
         Top             =   2520
      End
      Begin VB.Timer ReadCommandLine 
         Interval        =   1
         Left            =   1560
         Top             =   2520
      End
      Begin VB.Timer fileRefresh 
         Interval        =   64000
         Left            =   960
         Top             =   1920
      End
      Begin VB.CommandButton cmdProjectListClose 
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
         TabIndex        =   78
         Top             =   0
         Width           =   220
      End
      Begin MSComctlLib.TreeView tvProjectList 
         Height          =   5055
         Left            =   0
         TabIndex        =   159
         TabStop         =   0   'False
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
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
      Begin VB.Label lblProjectList 
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
         Left            =   0
         TabIndex        =   76
         Top             =   0
         Width           =   2655
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
      Height          =   360
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   635
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
            Object.ToolTipText     =   "Go To The RPGToolkit Homepage"
            Object.Tag             =   "1396"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "chat"
            Object.ToolTipText     =   "Chat"
            Object.Tag             =   "2034"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
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
      Height          =   5910
      Left            =   105
      ScaleHeight     =   5910
      ScaleWidth      =   3870
      TabIndex        =   68
      Top             =   360
      Visible         =   0   'False
      Width           =   3870
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
         Left            =   3600
         Picture         =   "tkMain.frx":1032C
         Style           =   1  'Graphical
         TabIndex        =   69
         Top             =   0
         Width           =   220
      End
      Begin TabDlg.SSTab bTools_Tabs 
         Height          =   7215
         Left            =   0
         TabIndex        =   70
         Top             =   240
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   12726
         _Version        =   393216
         Style           =   1
         Tabs            =   5
         TabsPerRow      =   5
         TabHeight       =   564
         WordWrap        =   0   'False
         ShowFocusRect   =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         TabCaption(0)   =   "&Vectors"
         TabPicture(0)   =   "tkMain.frx":10476
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "bTools_ctlVector"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).ControlCount=   1
         TabCaption(1)   =   "&Programs"
         TabPicture(1)   =   "tkMain.frx":10492
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "bTools_ctlPrg"
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "&Sprites"
         TabPicture(2)   =   "tkMain.frx":104AE
         Tab(2).ControlEnabled=   0   'False
         Tab(2).Control(0)=   "bTools_ctlSprite"
         Tab(2).ControlCount=   1
         TabCaption(3)   =   "&Images"
         TabPicture(3)   =   "tkMain.frx":104CA
         Tab(3).ControlEnabled=   0   'False
         Tab(3).Control(0)=   "bTools_ctlImage"
         Tab(3).ControlCount=   1
         TabCaption(4)   =   "&Lighting"
         TabPicture(4)   =   "tkMain.frx":104E6
         Tab(4).ControlEnabled=   0   'False
         Tab(4).Control(0)=   "bTools_ctlLighting"
         Tab(4).ControlCount=   1
         Begin Toolkit.ctlBrdLighting bTools_ctlLighting 
            Height          =   5535
            Left            =   -74760
            TabIndex        =   160
            Top             =   360
            Width           =   3495
            _ExtentX        =   6165
            _ExtentY        =   9763
         End
         Begin Toolkit.ctlBrdSprite bTools_ctlSprite 
            Height          =   6495
            Left            =   -74760
            TabIndex        =   142
            Top             =   360
            Width           =   3495
            _ExtentX        =   5318
            _ExtentY        =   11456
         End
         Begin Toolkit.ctlBrdImage bTools_ctlImage 
            Height          =   4575
            Left            =   -74760
            TabIndex        =   141
            Top             =   360
            Width           =   3375
            _ExtentX        =   5953
            _ExtentY        =   8070
         End
         Begin Toolkit.ctlBrdVector bTools_ctlVector 
            Height          =   5055
            Left            =   240
            TabIndex        =   128
            Top             =   360
            Width           =   3495
            _ExtentX        =   6165
            _ExtentY        =   8916
         End
         Begin Toolkit.ctlBrdProgram bTools_ctlPrg 
            Height          =   6375
            Left            =   -74760
            TabIndex        =   129
            Top             =   360
            Width           =   3495
            _ExtentX        =   5318
            _ExtentY        =   11245
         End
      End
      Begin VB.Label bTools_Title 
         BackColor       =   &H00808080&
         Caption         =   "Board Toolbar"
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
         TabIndex        =   73
         Top             =   0
         Width           =   3855
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
         TabIndex        =   72
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
         TabIndex        =   71
         Top             =   450
         Width           =   1245
      End
   End
   Begin VB.PictureBox newBarContainerContainer 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5910
      Left            =   -1710
      ScaleHeight     =   5910
      ScaleWidth      =   1815
      TabIndex        =   65
      Top             =   360
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
         Picture         =   "tkMain.frx":10502
         Style           =   1  'Graphical
         TabIndex        =   81
         Top             =   0
         Width           =   220
      End
      Begin VB.PictureBox newBar 
         BorderStyle     =   0  'None
         Height          =   5115
         Left            =   0
         ScaleHeight     =   5115
         ScaleWidth      =   1815
         TabIndex        =   66
         Top             =   240
         Width           =   1815
         Begin Toolkit.ctlNewBar NewBarIn 
            Height          =   5115
            Left            =   0
            TabIndex        =   67
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
         TabIndex        =   79
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
      Height          =   5910
      Left            =   0
      ScaleHeight     =   5910
      ScaleWidth      =   975
      TabIndex        =   32
      Top             =   360
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
         Picture         =   "tkMain.frx":1064C
         Style           =   1  'Graphical
         TabIndex        =   82
         Top             =   0
         Width           =   220
      End
      Begin VB.PictureBox leftbar 
         BorderStyle     =   0  'None
         FillColor       =   &H8000000F&
         ForeColor       =   &H8000000F&
         Height          =   6720
         Left            =   0
         ScaleHeight     =   6720
         ScaleWidth      =   1005
         TabIndex        =   33
         Top             =   240
         Width           =   1005
         Begin VB.Frame boardTools 
            BorderStyle     =   0  'None
            Caption         =   "Vct"
            Height          =   6105
            Left            =   0
            TabIndex        =   63
            Top             =   120
            Visible         =   0   'False
            Width           =   975
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   8
               Left            =   120
               Picture         =   "tkMain.frx":10796
               Style           =   1  'Graphical
               TabIndex        =   12
               TabStop         =   0   'False
               ToolTipText     =   "Lighting tools (U)"
               Top             =   2280
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   7
               Left            =   480
               Picture         =   "tkMain.frx":11060
               Style           =   1  'Graphical
               TabIndex        =   11
               TabStop         =   0   'False
               ToolTipText     =   "Shading tools (Y)"
               Top             =   1920
               Width           =   375
            End
            Begin VB.PictureBox brdPicCurrentTile 
               AutoRedraw      =   -1  'True
               Height          =   535
               Left            =   0
               ScaleHeight     =   32
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   63
               TabIndex        =   23
               ToolTipText     =   "Current tile (Click to change)"
               Top             =   5520
               Width           =   1000
            End
            Begin VB.Frame fraBrdToolLayers 
               BorderStyle     =   0  'None
               Height          =   1215
               Left            =   120
               TabIndex        =   127
               Top             =   4080
               Width           =   735
               Begin VB.CheckBox brdChkShowLayers 
                  Height          =   375
                  Left            =   360
                  Picture         =   "tkMain.frx":1192A
                  Style           =   1  'Graphical
                  TabIndex        =   22
                  ToolTipText     =   "Show all layers (K)"
                  Top             =   840
                  Width           =   375
               End
               Begin VB.CheckBox brdChkHideLayers 
                  Height          =   375
                  Left            =   0
                  Picture         =   "tkMain.frx":121F4
                  Style           =   1  'Graphical
                  TabIndex        =   21
                  ToolTipText     =   "Hide all layers except current (J)"
                  Top             =   840
                  Width           =   375
               End
               Begin VB.ComboBox brdCmbVisibleLayers 
                  Height          =   315
                  Left            =   60
                  Style           =   2  'Dropdown List
                  TabIndex        =   20
                  ToolTipText     =   "Toggle visible layers"
                  Top             =   480
                  Width           =   615
               End
               Begin VB.ComboBox brdCmbCurrentLayer 
                  Height          =   315
                  Left            =   60
                  Style           =   2  'Dropdown List
                  TabIndex        =   19
                  ToolTipText     =   "Current layer"
                  Top             =   120
                  Width           =   615
               End
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   6
               Left            =   120
               Picture         =   "tkMain.frx":12ABE
               Style           =   1  'Graphical
               TabIndex        =   10
               TabStop         =   0   'False
               ToolTipText     =   "Image tools (I)"
               Top             =   1920
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   5
               Left            =   480
               Picture         =   "tkMain.frx":13388
               Style           =   1  'Graphical
               TabIndex        =   9
               TabStop         =   0   'False
               ToolTipText     =   "Sprite tools (S)"
               Top             =   1560
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   4
               Left            =   120
               Picture         =   "tkMain.frx":13C52
               Style           =   1  'Graphical
               TabIndex        =   8
               TabStop         =   0   'False
               ToolTipText     =   "Program tools (P)"
               Top             =   1560
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   3
               Left            =   480
               Picture         =   "tkMain.frx":1451C
               Style           =   1  'Graphical
               TabIndex        =   7
               TabStop         =   0   'False
               ToolTipText     =   "Vector tools (V)"
               Top             =   1200
               Width           =   375
            End
            Begin VB.Frame fraBrdTools 
               BorderStyle     =   0  'None
               Caption         =   "Mv"
               Height          =   1335
               Left            =   120
               TabIndex        =   126
               Top             =   2760
               Width           =   735
               Begin VB.OptionButton brdOptTool 
                  Enabled         =   0   'False
                  Height          =   375
                  Index           =   5
                  Left            =   360
                  Picture         =   "tkMain.frx":14DE6
                  Style           =   1  'Graphical
                  TabIndex        =   18
                  TabStop         =   0   'False
                  ToolTipText     =   "Dropper (O)"
                  Top             =   720
                  Width           =   375
               End
               Begin VB.OptionButton brdOptTool 
                  Height          =   375
                  Index           =   4
                  Left            =   0
                  Picture         =   "tkMain.frx":150F0
                  Style           =   1  'Graphical
                  TabIndex        =   17
                  TabStop         =   0   'False
                  ToolTipText     =   "(Filled) Rectangle (R)"
                  Top             =   720
                  Width           =   375
               End
               Begin VB.OptionButton brdOptTool 
                  Height          =   375
                  Index           =   3
                  Left            =   360
                  Picture         =   "tkMain.frx":159BA
                  Style           =   1  'Graphical
                  TabIndex        =   16
                  TabStop         =   0   'False
                  ToolTipText     =   "Erase (E)"
                  Top             =   360
                  Width           =   375
               End
               Begin VB.OptionButton brdOptTool 
                  Height          =   375
                  Index           =   2
                  Left            =   0
                  Picture         =   "tkMain.frx":16284
                  Style           =   1  'Graphical
                  TabIndex        =   15
                  TabStop         =   0   'False
                  ToolTipText     =   "Flood fill (F)"
                  Top             =   360
                  Width           =   375
               End
               Begin VB.OptionButton brdOptTool 
                  Height          =   375
                  Index           =   1
                  Left            =   360
                  Picture         =   "tkMain.frx":16B4E
                  Style           =   1  'Graphical
                  TabIndex        =   14
                  TabStop         =   0   'False
                  ToolTipText     =   "Select (A)"
                  Top             =   0
                  Width           =   375
               End
               Begin VB.OptionButton brdOptTool 
                  Height          =   375
                  Index           =   0
                  Left            =   0
                  Picture         =   "tkMain.frx":17418
                  Style           =   1  'Graphical
                  TabIndex        =   13
                  TabStop         =   0   'False
                  ToolTipText     =   "Draw (D)"
                  Top             =   0
                  Width           =   375
               End
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   2
               Left            =   120
               Picture         =   "tkMain.frx":17CE2
               Style           =   1  'Graphical
               TabIndex        =   6
               TabStop         =   0   'False
               ToolTipText     =   "Tile tools (T)"
               Top             =   1200
               Width           =   375
            End
            Begin VB.CheckBox brdChkAutotile 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":185AC
               Style           =   1  'Graphical
               TabIndex        =   3
               ToolTipText     =   "Toggle Autotiler (H)"
               Top             =   360
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
               Picture         =   "tkMain.frx":188B6
               Style           =   1  'Graphical
               TabIndex        =   64
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CommandButton brdCmdUndo 
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
               Picture         =   "tkMain.frx":19580
               Style           =   1  'Graphical
               TabIndex        =   2
               TabStop         =   0   'False
               Tag             =   "1226"
               ToolTipText     =   "Undo (Ctrl+Z)"
               Top             =   0
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   1
               Left            =   480
               Picture         =   "tkMain.frx":19E4A
               Style           =   1  'Graphical
               TabIndex        =   5
               TabStop         =   0   'False
               ToolTipText     =   "Zoom (W)"
               Top             =   840
               Width           =   375
            End
            Begin VB.OptionButton brdOptSetting 
               Height          =   375
               Index           =   0
               Left            =   120
               Picture         =   "tkMain.frx":1A714
               Style           =   1  'Graphical
               TabIndex        =   4
               TabStop         =   0   'False
               ToolTipText     =   "Scroll board (Q)"
               Top             =   840
               Width           =   375
            End
            Begin VB.CheckBox brdChkGrid 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":1AFDE
               Style           =   1  'Graphical
               TabIndex        =   1
               TabStop         =   0   'False
               Tag             =   "1227"
               ToolTipText     =   "Grid on/off (G)"
               Top             =   0
               Width           =   375
            End
         End
         Begin VB.Frame tileTools 
            BorderStyle     =   0  'None
            Height          =   2895
            Left            =   0
            TabIndex        =   49
            Top             =   1680
            Visible         =   0   'False
            Width           =   975
            Begin VB.CommandButton tileColorChage 
               Appearance      =   0  'Flat
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":1BCA8
               Style           =   1  'Graphical
               TabIndex        =   62
               TabStop         =   0   'False
               ToolTipText     =   "Change Color"
               Top             =   360
               Width           =   375
            End
            Begin VB.CheckBox tileTool 
               Height          =   375
               Index           =   8
               Left            =   120
               Picture         =   "tkMain.frx":1C972
               Style           =   1  'Graphical
               TabIndex        =   61
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
               Picture         =   "tkMain.frx":1D23C
               Style           =   1  'Graphical
               TabIndex        =   60
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
               Picture         =   "tkMain.frx":1DB06
               Style           =   1  'Graphical
               TabIndex        =   59
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
               Picture         =   "tkMain.frx":1E3D0
               Style           =   1  'Graphical
               TabIndex        =   58
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
               Picture         =   "tkMain.frx":1EC9A
               Style           =   1  'Graphical
               TabIndex        =   57
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
               Picture         =   "tkMain.frx":1EFA4
               Style           =   1  'Graphical
               TabIndex        =   56
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
               Picture         =   "tkMain.frx":1F86E
               Style           =   1  'Graphical
               TabIndex        =   55
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
               Picture         =   "tkMain.frx":20138
               Style           =   1  'Graphical
               TabIndex        =   54
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
               Picture         =   "tkMain.frx":20442
               Style           =   1  'Graphical
               TabIndex        =   53
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
               Picture         =   "tkMain.frx":2074C
               Style           =   1  'Graphical
               TabIndex        =   52
               TabStop         =   0   'False
               Tag             =   "1226"
               ToolTipText     =   "Redraw"
               Top             =   0
               Width           =   375
            End
            Begin VB.CheckBox tileGrid 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":21016
               Style           =   1  'Graphical
               TabIndex        =   51
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
               Picture         =   "tkMain.frx":21CE0
               Style           =   1  'Graphical
               TabIndex        =   50
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CheckBox tileIsoCheck 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":229AA
               Style           =   1  'Graphical
               TabIndex        =   74
               Top             =   360
               Width           =   375
            End
         End
         Begin VB.Frame tilebmpTools 
            BorderStyle     =   0  'None
            Height          =   1575
            Left            =   0
            TabIndex        =   42
            Top             =   1560
            Visible         =   0   'False
            Width           =   975
            Begin VB.CheckBox tilebmpEraser 
               Height          =   375
               Left            =   480
               Picture         =   "tkMain.frx":23674
               Style           =   1  'Graphical
               TabIndex        =   48
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
               Picture         =   "tkMain.frx":23F3E
               Style           =   1  'Graphical
               TabIndex        =   47
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
               Picture         =   "tkMain.frx":24248
               Style           =   1  'Graphical
               TabIndex        =   46
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
               Picture         =   "tkMain.frx":24B12
               Style           =   1  'Graphical
               TabIndex        =   45
               TabStop         =   0   'False
               Tag             =   "1267"
               ToolTipText     =   "Apply lighting gradient"
               Top             =   720
               Width           =   375
            End
            Begin VB.CheckBox tilebmpDrawLock 
               Height          =   375
               Left            =   120
               Picture         =   "tkMain.frx":257DC
               Style           =   1  'Graphical
               TabIndex        =   44
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
               Picture         =   "tkMain.frx":260A6
               Style           =   1  'Graphical
               TabIndex        =   43
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
            TabIndex        =   38
            Top             =   240
            Visible         =   0   'False
            Width           =   735
            Begin VB.CommandButton cmdAnimIns 
               Caption         =   "Ins"
               Height          =   375
               Left            =   0
               Style           =   1  'Graphical
               TabIndex        =   84
               Tag             =   "1518"
               Top             =   840
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimDel 
               Caption         =   "Del"
               Height          =   375
               Left            =   360
               Style           =   1  'Graphical
               TabIndex        =   83
               Tag             =   "1517"
               Top             =   840
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimPlay 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":26D70
               Style           =   1  'Graphical
               TabIndex        =   41
               Top             =   360
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimForward 
               Height          =   375
               Left            =   360
               Picture         =   "tkMain.frx":27A3A
               Style           =   1  'Graphical
               TabIndex        =   40
               Top             =   0
               Width           =   375
            End
            Begin VB.CommandButton cmdAnimBack 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":28704
               Style           =   1  'Graphical
               TabIndex        =   39
               Top             =   0
               Width           =   375
            End
         End
         Begin VB.Frame rpgcodeTools 
            BorderStyle     =   0  'None
            Height          =   1215
            Left            =   120
            TabIndex        =   34
            Top             =   240
            Visible         =   0   'False
            Width           =   735
            Begin VB.CommandButton prgEventEdit 
               Height          =   375
               Left            =   0
               Picture         =   "tkMain.frx":293CE
               Style           =   1  'Graphical
               TabIndex        =   37
               TabStop         =   0   'False
               Tag             =   "1613"
               ToolTipText     =   "Edit As Event"
               Top             =   600
               Visible         =   0   'False
               Width           =   375
            End
            Begin VB.CommandButton prgDebug 
               Height          =   375
               Left            =   360
               Picture         =   "tkMain.frx":2A098
               Style           =   1  'Graphical
               TabIndex        =   36
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
               Picture         =   "tkMain.frx":2A962
               Style           =   1  'Graphical
               TabIndex        =   35
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
         TabIndex        =   80
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
      TabIndex        =   31
      Top             =   6270
      Visible         =   0   'False
      Width           =   11880
      Begin VB.Frame animationExtras 
         BorderStyle     =   0  'None
         Height          =   1455
         Left            =   960
         TabIndex        =   75
         Top             =   120
         Width           =   10935
         Begin VB.PictureBox anmPicHolder 
            BorderStyle     =   0  'None
            Height          =   1575
            Index           =   1
            Left            =   0
            ScaleHeight     =   1575
            ScaleWidth      =   10815
            TabIndex        =   146
            Top             =   0
            Width           =   10815
            Begin VB.Frame anmFra 
               Caption         =   "Frame Transparent Color"
               Height          =   1455
               Index           =   2
               Left            =   4560
               TabIndex        =   154
               Top             =   0
               Width           =   2175
               Begin VB.PictureBox anmPicHolder 
                  BorderStyle     =   0  'None
                  Height          =   1060
                  Index           =   0
                  Left            =   120
                  ScaleHeight     =   1065
                  ScaleWidth      =   1935
                  TabIndex        =   155
                  Top             =   240
                  Width           =   1935
                  Begin VB.PictureBox transpcolor 
                     Appearance      =   0  'Flat
                     AutoRedraw      =   -1  'True
                     BackColor       =   &H80000005&
                     ForeColor       =   &H80000008&
                     Height          =   255
                     Left            =   360
                     ScaleHeight     =   15
                     ScaleMode       =   3  'Pixel
                     ScaleWidth      =   71
                     TabIndex        =   156
                     Top             =   360
                     Width           =   1095
                  End
                  Begin VB.CommandButton cmdAnimTransp 
                     Caption         =   "Select"
                     Height          =   315
                     Left            =   360
                     TabIndex        =   135
                     Tag             =   "1516"
                     Top             =   720
                     Width           =   1095
                  End
                  Begin VB.Label lblAnimRGB 
                     Alignment       =   2  'Center
                     Caption         =   "RGB (255, 255, 255)"
                     Height          =   255
                     Left            =   120
                     TabIndex        =   157
                     Top             =   60
                     Width           =   1695
                  End
               End
            End
            Begin VB.Frame anmFra 
               Caption         =   "Frame Delay"
               Height          =   1455
               Index           =   1
               Left            =   2280
               TabIndex        =   150
               Top             =   0
               Width           =   2175
               Begin VB.HScrollBar hsbAnimPause 
                  Height          =   260
                  Left            =   120
                  Max             =   10
                  Min             =   1
                  TabIndex        =   134
                  TabStop         =   0   'False
                  Top             =   960
                  Value           =   1
                  Width           =   1935
               End
               Begin VB.TextBox anmTxtPause 
                  Height          =   285
                  Left            =   120
                  TabIndex        =   133
                  Top             =   360
                  Width           =   615
               End
               Begin VB.Label anmLbl 
                  AutoSize        =   -1  'True
                  Caption         =   "Fast"
                  Height          =   195
                  Index           =   0
                  Left            =   120
                  TabIndex        =   153
                  Tag             =   "1178"
                  Top             =   720
                  Width           =   300
               End
               Begin VB.Label anmLbl 
                  AutoSize        =   -1  'True
                  Caption         =   "Slow"
                  Height          =   195
                  Index           =   1
                  Left            =   1680
                  TabIndex        =   152
                  Tag             =   "1179"
                  Top             =   720
                  Width           =   345
               End
               Begin VB.Label anmLbl 
                  Caption         =   "Delay for all frames (seconds)"
                  Height          =   495
                  Index           =   2
                  Left            =   840
                  TabIndex        =   151
                  Top             =   240
                  Width           =   1215
               End
            End
            Begin VB.Frame anmFra 
               Caption         =   "Miscellaneous"
               Height          =   1455
               Index           =   3
               Left            =   6840
               TabIndex        =   149
               Top             =   0
               Width           =   3855
               Begin VB.PictureBox anmPicHolder 
                  BorderStyle     =   0  'None
                  Height          =   1160
                  Index           =   2
                  Left            =   120
                  ScaleHeight     =   1155
                  ScaleWidth      =   3615
                  TabIndex        =   158
                  Top             =   240
                  Width           =   3615
                  Begin VB.TextBox anmTxtFile 
                     Height          =   285
                     Left            =   960
                     TabIndex        =   137
                     Top             =   480
                     Width           =   2055
                  End
                  Begin VB.CommandButton anmCmdFile 
                     Caption         =   "..."
                     Height          =   255
                     Left            =   3120
                     TabIndex        =   138
                     Top             =   480
                     Width           =   495
                  End
                  Begin VB.TextBox anmTxtSound 
                     Height          =   285
                     Left            =   960
                     TabIndex        =   139
                     Top             =   840
                     Width           =   2055
                  End
                  Begin VB.CommandButton anmCmdWizard 
                     Caption         =   "Run Wizard..."
                     Height          =   375
                     Left            =   2040
                     TabIndex        =   136
                     Top             =   0
                     Width           =   1575
                  End
                  Begin VB.CommandButton anmCmdSound 
                     Caption         =   "..."
                     Height          =   255
                     Left            =   3120
                     TabIndex        =   140
                     Top             =   840
                     Width           =   495
                  End
                  Begin VB.Label anmLbl 
                     AutoSize        =   -1  'True
                     Caption         =   "Frame file"
                     Height          =   255
                     Index           =   4
                     Left            =   0
                     TabIndex        =   163
                     Tag             =   "1525"
                     Top             =   480
                     Width           =   885
                     WordWrap        =   -1  'True
                  End
                  Begin VB.Label anmLbl 
                     AutoSize        =   -1  'True
                     Caption         =   "Sound effect"
                     Height          =   315
                     Index           =   3
                     Left            =   0
                     TabIndex        =   162
                     Tag             =   "1525"
                     Top             =   840
                     Width           =   1005
                     WordWrap        =   -1  'True
                  End
                  Begin VB.Label lblAnimFrameCount 
                     AutoSize        =   -1  'True
                     Caption         =   "Frame 1 of 1"
                     Height          =   255
                     Left            =   0
                     TabIndex        =   161
                     Tag             =   "1527"
                     Top             =   120
                     Width           =   885
                  End
               End
            End
            Begin VB.Frame anmFra 
               Caption         =   "Size"
               Height          =   1455
               Index           =   0
               Left            =   0
               TabIndex        =   147
               Tag             =   "1042"
               Top             =   0
               Width           =   2175
               Begin VB.TextBox txtAnimXSize 
                  Height          =   285
                  Left            =   240
                  TabIndex        =   130
                  Top             =   360
                  Width           =   615
               End
               Begin VB.TextBox txtAnimYSize 
                  Height          =   285
                  Left            =   1200
                  TabIndex        =   131
                  Top             =   360
                  Width           =   615
               End
               Begin VB.ComboBox anmCmbSize 
                  Height          =   315
                  ItemData        =   "tkMain.frx":2B22C
                  Left            =   240
                  List            =   "tkMain.frx":2B23C
                  Style           =   2  'Dropdown List
                  TabIndex        =   132
                  ToolTipText     =   "Select a preset size"
                  Top             =   840
                  Width           =   1575
               End
               Begin VB.Label Label6 
                  Caption         =   "x"
                  Height          =   255
                  Left            =   960
                  TabIndex        =   148
                  Tag             =   "1046"
                  Top             =   360
                  Width           =   135
               End
            End
         End
      End
      Begin VB.Frame tileExtras 
         BorderStyle     =   0  'None
         Height          =   1455
         Left            =   960
         TabIndex        =   85
         Top             =   120
         Width           =   10200
         Begin VB.Frame Frame3 
            Caption         =   "Scroll              "
            Height          =   1215
            Left            =   8880
            TabIndex        =   97
            Tag             =   "1649"
            Top             =   240
            Width           =   1215
            Begin VB.PictureBox Picture6 
               BorderStyle     =   0  'None
               Height          =   615
               Left            =   120
               ScaleHeight     =   615
               ScaleWidth      =   975
               TabIndex        =   98
               Top             =   360
               Width           =   975
               Begin VB.CommandButton Command19 
                  Caption         =   "N"
                  Height          =   195
                  Left            =   360
                  TabIndex        =   102
                  TabStop         =   0   'False
                  Tag             =   "1653"
                  Top             =   0
                  Width           =   255
               End
               Begin VB.CommandButton Command18 
                  Caption         =   "S"
                  Height          =   195
                  Left            =   360
                  TabIndex        =   101
                  TabStop         =   0   'False
                  Tag             =   "1652"
                  Top             =   240
                  Width           =   255
               End
               Begin VB.CommandButton Command16 
                  Caption         =   "E"
                  Height          =   195
                  Left            =   720
                  TabIndex        =   100
                  TabStop         =   0   'False
                  Tag             =   "1651"
                  Top             =   120
                  Width           =   255
               End
               Begin VB.CommandButton Command15 
                  Caption         =   "W"
                  Height          =   195
                  Left            =   0
                  TabIndex        =   99
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
            TabIndex        =   91
            Top             =   240
            Width           =   2415
            Begin VB.PictureBox Picture8 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   120
               ScaleHeight     =   255
               ScaleWidth      =   1215
               TabIndex        =   95
               Top             =   840
               Width           =   1215
               Begin VB.CommandButton cmdImport 
                  Caption         =   "Import"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   96
                  ToolTipText     =   "Import single tile"
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
               TabIndex        =   94
               ToolTipText     =   "Current color"
               Top             =   240
               Width           =   495
            End
            Begin VB.PictureBox mirror 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000005&
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   720
               ScaleHeight     =   32
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   32
               TabIndex        =   93
               ToolTipText     =   "2D thumbnail (n/a in isometric)"
               Top             =   240
               Width           =   480
            End
            Begin VB.PictureBox isoMirror 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BorderStyle     =   0  'None
               ForeColor       =   &H80000008&
               Height          =   480
               Left            =   1320
               ScaleHeight     =   32
               ScaleMode       =   3  'Pixel
               ScaleWidth      =   64
               TabIndex        =   92
               ToolTipText     =   "Isometric thumbnail"
               Top             =   240
               Width           =   960
            End
            Begin VB.Label coords 
               Caption         =   "(32, 32)"
               Height          =   255
               Left            =   1440
               TabIndex        =   124
               Top             =   870
               Width           =   735
            End
         End
         Begin VB.Frame Frame7 
            Caption         =   "Color      "
            Height          =   1215
            Left            =   0
            TabIndex        =   86
            Top             =   240
            Width           =   6255
            Begin VB.PictureBox Picture11 
               BorderStyle     =   0  'None
               Height          =   495
               Left            =   105
               ScaleHeight     =   495
               ScaleWidth      =   6045
               TabIndex        =   103
               Top             =   240
               Width           =   6045
               Begin VB.CommandButton Command1 
                  Height          =   495
                  Left            =   5880
                  TabIndex        =   105
                  Tag             =   "1662"
                  ToolTipText     =   "Select Transparent Color"
                  Top             =   0
                  Width           =   180
               End
               Begin VB.PictureBox palettebox 
                  Appearance      =   0  'Flat
                  BackColor       =   &H80000005&
                  ForeColor       =   &H80000008&
                  Height          =   495
                  Left            =   0
                  Picture         =   "tkMain.frx":2B261
                  ScaleHeight     =   465
                  ScaleWidth      =   5865
                  TabIndex        =   104
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
               TabIndex        =   87
               Top             =   840
               Width           =   4335
               Begin VB.CommandButton cmdShadeTile 
                  Caption         =   "Shade Tile"
                  Height          =   255
                  Left            =   2880
                  TabIndex        =   90
                  ToolTipText     =   "Apply uniform shade to tile"
                  Top             =   0
                  Width           =   1335
               End
               Begin VB.CommandButton cmdSelColor 
                  Caption         =   "Select Color"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   89
                  ToolTipText     =   "Select color from dialog"
                  Top             =   0
                  Width           =   1335
               End
               Begin VB.CommandButton cmdDOS 
                  Caption         =   "DOS Pallete"
                  Height          =   255
                  Left            =   1440
                  TabIndex        =   88
                  ToolTipText     =   "Select DOS color"
                  Top             =   0
                  Width           =   1335
               End
            End
            Begin VB.Label lblTileRGB 
               Caption         =   "RGB (255, 255, 255)"
               Height          =   255
               Left            =   4560
               TabIndex        =   125
               Top             =   870
               Width           =   1575
            End
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
         TabIndex        =   106
         Top             =   240
         Width           =   7680
         Begin VB.Frame Frame2 
            Caption         =   "Size      "
            Height          =   1095
            Index           =   0
            Left            =   3960
            TabIndex        =   117
            Top             =   0
            Width           =   1695
            Begin VB.PictureBox Picture5 
               BorderStyle     =   0  'None
               Height          =   255
               Left            =   840
               ScaleHeight     =   255
               ScaleWidth      =   735
               TabIndex        =   120
               Top             =   720
               Width           =   735
               Begin VB.CommandButton tileBmpSizeOK 
                  Appearance      =   0  'Flat
                  Caption         =   "OK"
                  Height          =   255
                  Left            =   0
                  TabIndex        =   121
                  Tag             =   "1022"
                  Top             =   0
                  Width           =   615
               End
            End
            Begin VB.TextBox tileBmpSizeY 
               Appearance      =   0  'Flat
               Height          =   285
               Left            =   960
               TabIndex        =   119
               Top             =   240
               Width           =   495
            End
            Begin VB.TextBox tilebmpSizeX 
               Appearance      =   0  'Flat
               Height          =   285
               Left            =   240
               TabIndex        =   118
               Top             =   240
               Width           =   495
            End
            Begin VB.Label Label12 
               Caption         =   "Y"
               Height          =   255
               Left            =   830
               TabIndex        =   123
               Tag             =   "1045"
               Top             =   285
               Width           =   135
            End
            Begin VB.Label Label13 
               Caption         =   "X"
               Height          =   255
               Left            =   110
               TabIndex        =   122
               Tag             =   "1046"
               Top             =   285
               Width           =   135
            End
         End
         Begin VB.Frame frmTileLightning 
            Caption         =   "Tile Lighting                "
            Height          =   1095
            Left            =   0
            TabIndex        =   113
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
               TabIndex        =   116
               Top             =   240
               Width           =   495
            End
            Begin VB.TextBox tileBmpAmbient 
               Appearance      =   0  'Flat
               BackColor       =   &H00FFFFFF&
               Height          =   285
               Left            =   3240
               TabIndex        =   115
               Top             =   240
               Width           =   495
            End
            Begin VB.HScrollBar tileBmpAmbientSlider 
               Height          =   195
               Left            =   120
               Max             =   255
               Min             =   -255
               TabIndex        =   114
               Top             =   600
               Width           =   3615
            End
         End
         Begin VB.Frame frmTileCur 
            Caption         =   "Current Tile              "
            Height          =   1455
            Left            =   5760
            TabIndex        =   107
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
               TabIndex        =   108
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
               TabIndex        =   112
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
               TabIndex        =   111
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
               TabIndex        =   110
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
               TabIndex        =   109
               Tag             =   "1228"
               Top             =   240
               Width           =   495
            End
         End
      End
   End
   Begin VB.PictureBox popTray 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5910
      Left            =   11505
      ScaleHeight     =   5910
      ScaleWidth      =   375
      TabIndex        =   26
      Top             =   360
      Width           =   381
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   3
         Left            =   0
         Picture         =   "tkMain.frx":34B43
         Style           =   1  'Graphical
         TabIndex        =   30
         ToolTipText     =   "Toggle board object toolbar"
         Top             =   1080
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   2
         Left            =   0
         Picture         =   "tkMain.frx":34ECD
         Style           =   1  'Graphical
         TabIndex        =   29
         ToolTipText     =   "Toggle tileset browser"
         Top             =   720
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   1
         Left            =   0
         Picture         =   "tkMain.frx":35B97
         Style           =   1  'Graphical
         TabIndex        =   28
         ToolTipText     =   "Toggle new editor list"
         Top             =   360
         Width           =   375
      End
      Begin VB.CheckBox popButton 
         Height          =   375
         Index           =   0
         Left            =   3
         Picture         =   "tkMain.frx":36121
         Style           =   1  'Graphical
         TabIndex        =   27
         ToolTipText     =   "Toggle project file tree"
         Top             =   0
         Width           =   375
      End
   End
   Begin VB.PictureBox tilesetBar 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5910
      Left            =   3975
      ScaleHeight     =   394
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   320
      TabIndex        =   25
      Top             =   360
      Visible         =   0   'False
      Width           =   4800
      Begin VB.CommandButton cmdTilesetClose 
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
         Picture         =   "tkMain.frx":364AB
         Style           =   1  'Graphical
         TabIndex        =   144
         Top             =   0
         Width           =   220
      End
      Begin Toolkit.ctlTilesetToolbar ctlTileset 
         Height          =   3975
         Left            =   0
         TabIndex        =   143
         Top             =   360
         Width           =   4815
         _ExtentX        =   8493
         _ExtentY        =   9763
      End
      Begin VB.Label lblCurrentTileset 
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
         Left            =   0
         TabIndex        =   145
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
            AutoSize        =   1
            Object.Width           =   2884
            TextSave        =   "19/01/2007"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   1
            Object.Width           =   2884
            TextSave        =   "15:37"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   2884
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   2884
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   1
            Object.Width           =   2884
            TextSave        =   "NUM"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   3
            AutoSize        =   1
            Enabled         =   0   'False
            Object.Width           =   2884
            TextSave        =   "INS"
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            AutoSize        =   1
            Enabled         =   0   'False
            Object.Width           =   2884
            TextSave        =   "CAPS"
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuPopTree 
      Caption         =   "Right-click on file tree"
      Visible         =   0   'False
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Select into board editor"
         Index           =   0
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Open"
         Index           =   1
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Rename"
         Index           =   2
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Delete"
         Index           =   3
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "-"
         Index           =   4
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Refresh"
         Index           =   5
      End
      Begin VB.Menu mnuPopTreeItems 
         Caption         =   "Collapse All"
         Index           =   6
      End
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
      Begin VB.Menu sub45 
         Caption         =   "-"
      End
      Begin VB.Menu tutorialmnu 
         Caption         =   "Tutorial"
         Visible         =   0   'False
      End
      Begin VB.Menu historytxtmnu 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu registrationinfomnu 
         Caption         =   "Registration Info"
         Visible         =   0   'False
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
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'    - Sander Knape
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

'============================================================================
' Globals
'============================================================================
Public toolTop As Integer               ' Distance from top of tools
Public ignoreFocus As Boolean           ' Ignore obtaining of the focus?
Public g_bNoTabRefresh As Boolean       ' Do not refresh the tabs?

'============================================================================
' Members
'============================================================================
Private m_cnvBkgImage As Long           ' Background image canvas
Private ignoreFlag As Boolean           ' All-purpose ignore flag
Private WithEvents m_tabs As cMDITabs   ' The MDI tab bar
Attribute m_tabs.VB_VarHelpID = -1
Private theBard As TK_BARD_INFO         ' The bard (MP3 player)

'============================================================================
' Current state of the bard
'============================================================================
Private Enum TK_BARD_STATE
    NOTOPEN = 0                         ' The bard is not open
    VISIBKE = 1                         ' The bard is open
End Enum

'============================================================================
' Info on the bard
'============================================================================
Private Type TK_BARD_INFO
    State As TK_BARD_STATE              ' State of the bard
    hwnd As Long                        ' Handle to the bard's window
End Type

'============================================================================
' Right toolbar indices
'============================================================================
Public Enum ePopButton
    PB_FILETREE
    PB_NEWEDITOR
    PB_TILESET
    PB_TOOLBAR
End Enum

'============================================================================
' Declarations
'============================================================================
Private Declare Function CloseWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

Private Const WS_THICKFRAME = &H40000
Private Const GWL_STYLE = (-16)
Private Const SWP_NOZORDER = &H4
Private Const SWP_NOSIZE = &H1
Private Const SWP_NOMOVE = &H2
Private Const SWP_FRAMECHANGED = &H20

'============================================================================
' Draw the background image
'============================================================================
Public Sub DrawBackground()

    ' If an image is set
    If (m_cnvBkgImage) Then

        ' Obtain the window
        Dim hwnd As Long, hdc As Long
        hwnd = FindWindowEx(Me.hwnd, 0&, "MDIClient", vbNullChar)

        ' Get the window's DC
        hdc = GetDC(hwnd)

        ' Draw the image
        Call canvasBlt(m_cnvBkgImage, 0, 0, hdc)

        ' Release the DC!
        Call ReleaseDC(hwnd, hdc)

    End If

End Sub

'============================================================================
' Load the background image
'============================================================================
Public Sub loadBackgroundImage()
    If (m_cnvBkgImage) Then Call destroyCanvas(m_cnvBkgImage)
    If (LenB(configfile.wallpaper)) Then
        If (fileExists(configfile.wallpaper)) Then
            m_cnvBkgImage = createCanvas( _
                Me.width / Screen.TwipsPerPixelX, _
                Me.Height / Screen.TwipsPerPixelY _
            )
            Call canvasLoadSizedPicture( _
                m_cnvBkgImage, _
                configfile.wallpaper _
            )
        End If
    End If
End Sub

'============================================================================
' Force a refresh of the tab bar
'============================================================================
Public Sub refreshTabs()
    Call m_tabs.ForceRefresh
End Sub

Private Sub animTileTimer_Timer()
    'wip:'Call activeBoard.animateTile
End Sub

'============================================================================
' Give a control a resizable frame (resizing triggers ctl_Resize())
'============================================================================
Private Sub controlSetSizable(ByRef ctl As Control) ':on error resume next
    Dim ws As Long
    ws = GetWindowLong(ctl.hwnd, GWL_STYLE)
    ws = ws Or WS_THICKFRAME
    Call SetWindowLong(ctl.hwnd, GWL_STYLE, ws)
    
    'Redraw the frame.
    Call SetWindowPos(ctl.hwnd, 0, 0, 0, 0, 0, SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE Or SWP_FRAMECHANGED)
End Sub

'============================================================================
' Launch the RPGCode updater.
'============================================================================
Private Sub mnuRpgCodeUpdater_Click()
    Call frmRpgCodeUpdate.Show(vbModal)
End Sub

'============================================================================
' Tileset browser resize event
'============================================================================
Private Sub tilesetBar_Resize(): On Error Resume Next
    If tilesetBar.ScaleWidth < 192 Then tilesetBar.width = 192 * Screen.TwipsPerPixelX
    cmdTilesetClose.Left = tilesetBar.ScaleWidth - cmdTilesetClose.width
    lblCurrentTileset.width = tilesetBar.ScaleWidth
    
    ctlTileset.Height = tilesetBar.ScaleHeight - ctlTileset.Top
    ctlTileset.width = tilesetBar.ScaleWidth
    Call ctlTileset.resize(configfile.lastTileset, False, tilesetBar.visible)
    
    'Prevent the resize inverting the position of the righthand toolbar.
    popTray.Left = Me.width - popTray.width
End Sub

'============================================================================
' Tileset browser close button
'============================================================================
Private Sub cmdTilesetClose_Click(): On Error Resume Next
    tkMainForm.popButton(PB_TILESET).value = 0
End Sub

'============================================================================
' Process selected tile information from tileset browser control
'============================================================================
Public Sub ctlTilesetMouseUp(ByVal filename As String) ':on error resume next
    
    'Inform the system that the set filename has changed. Load into whichever editor is active.
    Dim formType As Long
    If Not (activeForm Is Nothing) Then formType = activeForm.formType
    
    Select Case formType
        Case FT_BOARD, FT_ANIMATION, FT_TILEBITMAP, FT_TILEANIM
            'These editors have specific uses for the tileset browser.
            Call activeForm.changeSelectedTile(filename)
            
        Case Else
            'It's not a form that uses the tile browser, so load it in the tile editor.
            Dim newTile As New tileedit
            Set activeTile = newTile
            activeTile.Show
            Call activeTile.openFile(projectPath & tilePath & filename)
            
    End Select

End Sub

'============================================================================
' Click a tab
'============================================================================
Private Sub m_tabs_TabClick(ByVal iButton As MouseButtonConstants, ByVal hwnd As Long, ByVal screenX As Long, ByVal screenY As Long)

    ' Find the window
    Dim frm As Form
    For Each frm In Forms
        If (frm.hwnd = hwnd) Then

            ' Hide then show this window
            g_bNoTabRefresh = True
            Call frm.Hide
            Call frm.Show
            g_bNoTabRefresh = False
            Exit For

        End If
    Next frm

End Sub

'============================================================================
' Hide the tabs
'============================================================================
Public Sub hideTabs()
    Call m_tabs.Detach
End Sub

'============================================================================
' Show the tabs
'============================================================================
Public Sub ShowTabs()
    Call m_tabs.Attach(hwnd)
End Sub

'============================================================================
' Open a file
'============================================================================
Public Sub openFile(ByVal fName As String)

    On Error Resume Next

    Dim ex As String
    ex = UCase$(extention(fName))

    Dim frm As Form

    Select Case ex

        Case "GPH"
            Set frm = New tileedit
            Call frm.Show
            Set activeTile = frm
            Call activeTile.openFile(fName)

        Case "TST", "ISO"

            ' Information for the tileset browser
            tstnum = 0
            tstFile = RemovePath(fName)
            configfile.lastTileset = tstFile

            Call FileCopy(fName, projectPath & tilePath & tstFile)

            ' Show the tileset browser
            Call tilesetForm.Show(vbModal)

            ' Load only if a tile has been selected
            If (LenB(setFilename)) Then
                Set frm = New tileedit
                Call frm.Show
                Set activeTile = frm
                Call activeTile.openFile(projectPath & tilePath & setFilename)
            End If

        Case "BRD"
            Set frm = New frmBoardEdit
            'Trigger the active board's deactivate since it won't be called before the new form's activate.
            If Not (activeForm Is Nothing) Then
                If activeForm.formType = FT_BOARD Then Call activeBoard.Form_Deactivate
            End If
            Set activeBoard = frm
            '.newBoard initialises the board editor.
            Call activeBoard.newBoard(1, 1, 1, 0, vbNullString)
            Call activeBoard.Show
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
            Set frm = New edititem
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
            Call Shell(determineDefaultApp(fName) & " " & """" & resolve(CurDir$()) & fName & """", vbNormalFocus)

    End Select

    If Not (frm Is Nothing) Then
        Call m_tabs.ForceRefresh
        Call frm.SetFocus
    End If

End Sub

Public Sub aboutmnu_Click(): On Error Resume Next
    Call helpAbout.Show(vbModal)
End Sub

Public Sub arrangeiconsmnu_Click(): On Error Resume Next
    Call Me.Arrange(3)
End Sub

Private Sub Command1_Click(): On Error Resume Next
    openTileEditorDocs(activeTile.indice).currentColor = -1
    Call activeTile.updateSelectedColor
End Sub

Public Sub cascademnu_Click(): On Error Resume Next
    Call Me.Arrange(0)
End Sub

Private Sub Command14_Click()
    leftbar.visible = False
End Sub

Private Sub Command2_Click()
    popButton(PB_NEWEDITOR).value = 0
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

Private Sub cmdProjectListClose_Click(): On Error Resume Next
    popButton(PB_FILETREE).value = 0
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
    popButton(PB_NEWEDITOR).value = 0
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

Private Sub LaunchBard()
    
    Select Case theBard.State
 
        Case NOTOPEN
            'Launch the program...
            theBard.hwnd = getWinHandle(Shell("bard3.exe", vbNormalFocus))
            'Make it a child of TKMainForm...
            SetParent theBard.hwnd, Me.hwnd
            'Flag that the Bard is open...
            theBard.State = visible

        Case visible
            If IsWindow(theBard.hwnd) = 1 Then
                'Tis already open- we need do nothing
                Exit Sub
            Else
                'It has been closed...
                theBard.State = NOTOPEN
                'Recurse!
                LaunchBard
            End If
    
    End Select
 
End Sub

Private Sub exitTheBard()
    If (theBard.State = visible) Then Call CloseWindow(theBard.hwnd)
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
    mnuTips.Checked = Not (mnuTips.Checked)
    configfile.tipsOnOff = -mnuTips.Checked
End Sub

Private Sub ReadCommandLine_Timer()
   
    On Error Resume Next
    
    DoEvents
    ReadCommandLine.Enabled = False

    If LCase$(GetExt(Command$())) = "prg" Then
        With New rpgcodeedit
            .Tag = "1"
            .mnuNewProject.visible = False
            .mnuNew.visible = False
            .mnuNewPRG.visible = True
            .mnuOpenProject.visible = False
            .mnuSaveAll.visible = False
            .closemnu.visible = False
            .mnuToolkit.visible = False
            .mnuBuild.visible = False
            .mnuWindow.visible = False
            Call .Show
            Call m_tabs.ForceRefresh
            Call .SetFocus
            Dim fCaption As String
            Dim filename As String
            fCaption = Command$()
            filename = absNoPath(fCaption)
            If Command$() = ".prg" Or Command$() = "prg" Then
                fCaption = "Untitled"
                filename = fCaption
            End If
            .Caption = LoadStringLoc(803, "RPGCode Program Editor") & "  (" & filename & ")"
            Call m_tabs.ForceRefresh
            .mnuNotepadMode.Checked = False
            .mnuNotepadMode.visible = False
            .mnuNotepadMode_Click
            If Left < 0 Then Left = 0
            If Top < 0 Then Top = 0
            DoEvents
            If fCaption <> "Untitled" Then
                Call .openProgram(Command$())
                rpgcodeList(activeRPGCodeIndex).prgName = Command$()
                CommonGlobals.filename(2) = Command$()
            End If
        End With
    End If

End Sub

Private Sub mainToolbar_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu): On Error Resume Next
    Dim frm As Form
    Select Case ButtonMenu.Index
        Case 1:
            Set frm = New tileedit
        Case 2:
            Set frm = New tileanim
        Case 3:
            Call newboardmnu_Click
            Exit Sub
        Case 4:
            Set frm = New characteredit
        Case 5:
            Set frm = New edititem
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

Private Sub MDIForm_Load(): On Error Resume Next
'=====================================================
'Call added for isometrics, 3.0.4

    Call Show

    Set m_tabs = New cMDITabs
    Call m_tabs.Attach(Me.hwnd)
    Call m_tabs.ForceRefresh
    Call configForm

    Call loadBackgroundImage

    Call createIsoMask
    Call controlSetSizable(tilesetBar)
    Call controlSetSizable(projectListBar)             'Project file tree.
    
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
        Call tvReset
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
    Call mainToolbar.Buttons.Remove(16)
    Call mainToolbar.Buttons.Remove(17)
    Call mainToolbar.Buttons.Remove(18)
    Call mainToolbar.Buttons.Remove(19)
    Dim i As Long
    For i = 0 To 4
        If (LenB(configfile.quickTarget(i))) Then
            Dim icon As IPictureDisp
            If (LenB(configfile.quickIcon(i))) Then
                Set icon = LoadPicture(configfile.quickIcon(i))
            Else
                Set icon = LoadResPicture(101, vbResBitmap)
            End If
            Dim btn As Button
            Set btn = mainToolbar.Buttons.Add(, , , , LoadPicture(configfile.quickIcon(i)))
            btn.visible = True
            btn.Enabled = configfile.quickEnabled(i)
        End If
    Next i
End Sub

Private Sub MDIForm_Unload(ByRef Cancel As Integer)
    Set m_tabs = Nothing
    If (m_cnvBkgImage) Then Call destroyCanvas(m_cnvBkgImage)
    Call exitTheBard
    Call saveConfigAndEnd("toolkit.cfg")
    End
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
    
    Call tvReset                      'Reset file tree.
    
    loadedMainFile = configfile.lastProject
    
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

Public Sub newboardmnu_Click(): On Error Resume Next
    'Trigger the active board's deactivate since it won't be called before the new form's activate/
    If activeForm.formType = FT_BOARD Then Call activeBoard.Form_Deactivate
    Call frmNewBoard.Show
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
    Set frm = New edititem
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

Public Sub newprojectmnu_Click(): On Error Resume Next
    Call newGame.Show(1)
    tkMainForm.Caption = "RPG Toolkit Development System, Version 3.0 (" & mainFile & ")"
    Call editmainfile.Show
    Call tvReset                'Reset file tree.
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

    ChDir (currentDir)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath
    dlg.strTitle = "Open Toolkit File"
    dlg.strFileTypes = "Supported Files|*.tbm;*.brd;*.gph;*.tst;*.iso;*.tan;*.prg;*.tem;*.itm;*.ene;*.bkg;*.ste;*.spc;*.anm;*.rfm|Tile (*.tst;*.tan;*.gph;*.iso)|*.tst;*.tan;*.gph;*.iso|Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|Player (*.tem)|*.tem|Item (*.itm)|*.itm|Enemy (*.ene)|*.ene|Fight Background (*.bkg)|*.bkg|Status Effect (*.ste)|*.ste|Special Move (*.spc)|*.spc|Animation (*.anm)|*.anm|Tile Bitmap (*.tbm)|*.tbm|Visual Form (*.rfm)|*.rfm|All files(*.*)|*.*"
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    ChDir (currentDir)
    If LenB(dlg.strSelectedFile) Then Call tkMainForm.openFile(dlg.strSelectedFile)
    
End Sub

'==============================================================================
'Tile editor colour palette
'==============================================================================
Private Sub palettebox_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    openTileEditorDocs(activeTile.indice).currentColor = tkMainForm.palettebox.point(x, y)
    Call activeTile.updateSelectedColor
End Sub

'==============================================================================
'Update the RGB label with the colour under the mouse
'==============================================================================
Private Sub palettebox_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Dim colour As Long
    colour = palettebox.point(x, y)
    lblTileRGB.Caption = "RGB (" & red(colour) & ", " & green(colour) & ", " & blue(colour) & ")"
End Sub

'==============================================================================
'Restore the selected colour when the mouse moves off the palette
'==============================================================================
Private Sub Frame7_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    If openTileEditorDocs(activeTile.indice).currentColor <> -1 Then
        lblTileRGB.Caption = "RGB (" & red(openTileEditorDocs(activeTile.indice).currentColor) & _
                             ", " & green(openTileEditorDocs(activeTile.indice).currentColor) & _
                             ", " & blue(openTileEditorDocs(activeTile.indice).currentColor) & ")"
    Else
        lblTileRGB.Caption = "RGB ( Transparent )"
    End If
End Sub

'=========================================================================================
' ADDED FOURTH BUTTON FOR BOARD TOOLBAR
Private Sub popButton_Click(Index As Integer): On Error Resume Next
    
    Select Case Index
        Case PB_FILETREE
            'File tree.
            If popButton(Index).value = 1 Then
                popButton(PB_NEWEDITOR).value = 0
                popButton(PB_TILESET).value = 0
                popButton(PB_TOOLBAR).value = 0
                projectListBar.visible = True
                projectListBar.SetFocus
            Else
                projectListBar.visible = False
            End If
            
        Case PB_NEWEDITOR
            'Open editors.
            If popButton(Index).value = 1 Then
                popButton(PB_FILETREE).value = 0
                popButton(PB_TILESET).value = 0
                popButton(PB_TOOLBAR).value = 0
                newBarContainerContainer.visible = True
            Else
                newBarContainerContainer.visible = False
            End If
            
        Case PB_TILESET
            'Tileset browser.
            If popButton(Index).value = 1 Then
                popButton(PB_FILETREE).value = 0
                popButton(PB_NEWEDITOR).value = 0
                popButton(PB_TOOLBAR).value = 0
                tstnum = 0
                tilesetBar.visible = True
                Call ctlTileset.resize(configfile.lastTileset)
                tilesetBar.SetFocus
            Else
                tilesetBar.visible = False
            End If
            
        Case PB_TOOLBAR
            'Board editor toolbar.
            If popButton(Index).value = 1 Then
                popButton(PB_FILETREE).value = 0
                popButton(PB_NEWEDITOR).value = 0
                popButton(PB_TILESET).value = 0
                pTools.visible = True
                Call activeBoard.toolbarRefresh
                pTools.SetFocus
            Else
                pTools.visible = False
            End If
            
    End Select
End Sub
'=========================================================================================

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
    Dim frm As Form
    For Each frm In Forms
        'Any forms without the saveFile() sub will error.
        Call frm.saveFile
    Next frm
End Sub

Public Sub saveAsMnu_Click(): On Error Resume Next
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
    projectListBar.visible = Not projectListBar.visible
End Sub

Public Sub showtoolsmnu_Click(): On Error Resume Next
    If leftbar.visible Then
        leftbar.visible = False
        leftBarContainer.visible = False
    Else
        leftbar.visible = True
        leftBarContainer.visible = True
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

Private Sub tileTool_Click(Index As Integer): On Error Resume Next
    Call activeTile.ToolSet(Index)
End Sub

Public Sub tileverticallymnu_Click(): On Error Resume Next
    Call Me.Arrange(2)
End Sub

'==============================================================================
' File tree events
'==============================================================================

'==============================================================================
' Fill the tree with the project's files
'==============================================================================
Private Sub tvListDirectory(ByVal parentNode As Long, ByRef folder As String): On Error Resume Next

    'Pass parentNode as node index rather than key.
    'TreeView.Nodes is 1-based - set parentNode = 0 to access top level.

    Dim a As String, b As String, gfx As Long, nod As MSComctlLib.node

    a = Dir(folder & "*.*", vbDirectory)
    a = Dir()                               'Skip the "." current
    a = Dir()                               'and ".." parent directories.

    ' Disable sort whilst adding top level nodes.
    If parentNode = 0 Then tvProjectList.Sorted = False
    
    'Prevent total lock-up (but do not process events between files, since this causes significant slowdown).
    DoEvents

    With tvProjectList.nodes

        'Cycle through the files and subfolders of 'folder'.
        Do While LenB(a)
        
            'Directories.
            If (GetAttr(folder & a) And vbDirectory) Then
            
                'Icon index in ImageList1 to identify folders.
                gfx = 1

                If parentNode Then
                    'Subfolder of a default folder.
                    
                    'Hack to alphabetically sort folders above files - prepend a space to the text.
                    'Do not specify the filename as the key, since multiple files/folders may
                    'exist with the same name in different folders, and keys must be unique.
                    Set nod = .Add(parentNode, tvwChild, , " " & a, gfx)

                    'Recurse into the directory.
                    Call tvListDirectory(nod.Index, folder & a & "\")
                Else
                    'Default folder - add to top level.
                    Set nod = .Add(, , , " " & a, gfx)
                    Call tvListDirectory(nod.Index, folder & a & "\")
                End If
                
                'Reset the current file of the current folder.
                b = Dir(folder & "*.*", vbDirectory)
                Do Until a = b
                    b = Dir()
                Loop
            Else
                'This is a file.

                'Assign a graphic from the associated ImageList1
                Select Case UCase$(commonRoutines.extention(a))
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

                If parentNode Then
                    'If file is in a subdirectory.
                    Call .Add(parentNode, tvwChild, , a, gfx)
                Else
                    'File is in the root.
                    Call .Add(, , , a, gfx)
                End If

            End If 'isFolder.

            'Get the next file in the directory.
            a = Dir()

        Loop
        
        'Sort subnodes after adding is finished, else sorting occurs for each new addition.
        If parentNode Then .Item(parentNode).Sorted = True

    End With
    
    'Sort top level nodes after adding.
    If parentNode = 0 Then tvProjectList.Sorted = True

End Sub

'============================================================================
' Add a file to the tree view
'============================================================================
Public Sub tvAddFile(ByVal file As String): On Error Resume Next
    'Just refresh the tree for the time being.
    Call tvReset
End Sub

'============================================================================
' Relist the project files
'============================================================================
Public Sub tvReset(): On Error Resume Next
    tvProjectList.nodes.clear
    Call tvListDirectory(0, projectPath)
End Sub

'============================================================================
' Remove the prepended space from directory node text used in sorting (see tvListDirectory())
'============================================================================
Private Function tvTrimPath(ByRef tv As TreeView, ByVal path As String) As String
    Dim dirs() As String, i As Long
    dirs = Split(path, tv.PathSeparator)
    
    'path is, for example: " Bitmap\ subfolder\file.bmp"
    For i = 0 To UBound(dirs)
        dirs(i) = Trim$(dirs(i))
    Next i
    
    tvTrimPath = Join(dirs, tv.PathSeparator)
End Function

'============================================================================
' Open a file from the tree view
'============================================================================
Private Sub tvProjectList_DblClick(): On Error Resume Next

    Dim fullPath As String
    fullPath = tvTrimPath(tvProjectList, tvProjectList.SelectedItem.fullPath)
    
    'Complete directories as and when they are expanded to save time.
    'If dirExists(projectPath & fullpath) Then
    '
    '    If tvProjectList.SelectedItem.Children = 0 Then
    '        'This is a folder that hasn't been expanded.
    '        Call tvlistdirectory(tvProjectList.SelectedItem.index, projectPath & fullPath & "\")
    '
    '        'Trigger the expand event (not automatically triggered since Children = 0 on click.
    '        tvProjectList.SelectedItem.Expanded = True
    '    End If
    
    If fileExists(projectPath & fullPath) Then
        Call tkMainForm.openFile(projectPath & fullPath)
    End If
    
    Call projectListBar.SetFocus
    ignoreFocus = False
End Sub

'============================================================================
' Show a right-click menu on the tree view
'============================================================================
Private Sub tvProjectList_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Dim visible As Boolean
    If Button = vbRightButton Then
        'Show a right-click menu.
    
        'Determine if an item was clicked.
        tvProjectList.SelectedItem = tvProjectList.HitTest(x, y)
        If Not (tvProjectList.SelectedItem Is Nothing) Then
            If fileExists(projectPath & tvTrimPath(tvProjectList, tvProjectList.SelectedItem.fullPath)) Then
                'Enable options on files only.
                visible = True
            End If
        End If
        
        'Load TANs into board editor.
        Dim isBoard As Boolean
        If Not activeForm Is Nothing Then isBoard = (activeForm.formType = FT_BOARD)
        mnuPopTreeItems(0).visible = (visible And isBoard And (LCase$(GetExt(tvProjectList.SelectedItem.Text)) = "tan"))
        
        mnuPopTreeItems(1).visible = visible        'Open
        mnuPopTreeItems(2).visible = visible        'Rename
        mnuPopTreeItems(3).visible = visible        'Delete
        mnuPopTreeItems(4).visible = visible        'Separator
        
        'Popup the menu.
        PopupMenu mnuPopTree
    End If

End Sub

Private Sub tvProjectList_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    ignoreFocus = True
End Sub

'============================================================================
' Tree view right-click menu options
'============================================================================
Private Sub mnuPopTreeItems_Click(Index As Integer): On Error Resume Next
    Dim nod As MSComctlLib.node
    
    Select Case Index
        Case 0:
            'Load TANs into board editor.
            Call tvProjectList_NodeClick(tvProjectList.SelectedItem)
        Case 1:
            'Open selected file.
            Call tvProjectList_DblClick
        Case 2:
            'Rename.
            tvProjectList.StartLabelEdit
        Case 3:
            'Delete.
            Call tvDeleteSelectedItem
        Case 4:
            'Separator
        Case 5:
            'Refresh tree.
            Call tvReset
        Case 6:
            'Collapse open nodes.
            For Each nod In tvProjectList.nodes
                nod.Expanded = False
            Next nod
    End Select
End Sub

'============================================================================
' Rename selected file
'============================================================================
Private Sub tvProjectList_AfterLabelEdit(Cancel As Integer, NewString As String)

    Dim file() As String, fullPath As String
    
    If Cancel Then Exit Sub
    Cancel = True
    
    fullPath = tvTrimPath(tvProjectList, tvProjectList.SelectedItem.fullPath)
    file = Split(fullPath, "\")
    
    If (LenB(NewString) = 0) Or dirExists(projectPath & fullPath) Then
        If dirExists(projectPath & fullPath) Then MsgBox "Directories cannot be renamed", vbExclamation
        Exit Sub
    End If
  
    If MsgBox( _
        "Are you sure you want to rename this file? If you have used this file in " & _
        "any Toolkit objects (e.g. tiles on boards or animations in items) they will " & _
        "not be updated", vbYesNo + vbQuestion _
        ) = vbNo Then Exit Sub

    'Preserve the extension.
    Dim ext As String
    ext = LCase$(GetExt(tvProjectList.SelectedItem.Text))
    
    If ext <> LCase$(GetExt(NewString)) Then NewString = NewString & "." & ext

    'Rename the file.
    file(UBound(file)) = NewString

    If fileExists(projectPath & Join(file, "\")) Then
        MsgBox NewString & " already exists! Please delete the original before trying to rename this file.", vbExclamation
        Cancel = True
    ElseIf fileExists(projectPath & fullPath) Then
        'Check the file exists before
        Name projectPath & fullPath As projectPath & Join(file, "\")
        Cancel = False
    End If

End Sub

'==============================================================================
' Process single-click events
'==============================================================================
Private Sub tvProjectList_NodeClick(ByVal node As MSComctlLib.node): On Error Resume Next

    If LCase$(GetExt(node.Text)) = "tan" And Not (activeForm Is Nothing) Then
        If activeForm.formType = FT_BOARD Then
            'Load tans into board editor.
            Call activeBoard.changeSelectedTile(node.Text)
        End If
    End If
    
End Sub

'==============================================================================
' Delete selected file
'==============================================================================
Private Sub tvDeleteSelectedItem(): On Error Resume Next
    Dim fullPath As String
    fullPath = tvTrimPath(tvProjectList, tvProjectList.SelectedItem.fullPath)
   
    'Only delete files - do not allow (potentially default) folders to be deleted.
    If fileExists(projectPath & fullPath) Then
        
        'No need to check if the file is open, since saving a deleted open file will recreate that file.
        If MsgBox("Are you sure you want to delete " & tvProjectList.SelectedItem.Text & "?", vbYesNo + vbQuestion) = vbYes Then
        
            Kill (projectPath & fullPath)
            tvProjectList.nodes.Remove (tvProjectList.SelectedItem.Index)
            
        End If
    End If
End Sub

Private Sub projectListBar_Resize(): On Error Resume Next
    If projectListBar.ScaleWidth < 192 Then projectListBar.width = 192 * Screen.TwipsPerPixelX
    cmdProjectListClose.Left = projectListBar.ScaleWidth - cmdProjectListClose.width
    lblProjectList.width = projectListBar.ScaleWidth
    
    tvProjectList.Height = projectListBar.ScaleHeight - tvProjectList.Top
    tvProjectList.width = projectListBar.ScaleWidth
    
    'Prevent the resize inverting the position of the righthand toolbar.
    popTray.Left = Me.width - popTray.width
End Sub

Private Sub projectListBar_LostFocus(): On Error Resume Next
    If Not (ignoreFocus) Then popButton(PB_FILETREE).value = 0
End Sub

'==============================================================================
' End file tree events
'==============================================================================

Public Sub tutorialmnu_Click(): On Error Resume Next
    Call frmTutorial.Show(vbModal)
End Sub

Public Sub usersguidemnu_Click()
    Call frmHelpViewer.Show
End Sub

'=========================================================================================
' BOARD EDITOR RELATED EVENTS
'=========================================================================================
' BOARD TOOLBAR EVENTS
'=========================================================================================
Private Sub bTools_Tabs_Click(PreviousTab As Integer)
    Call activeBoard.toolbarRefresh
End Sub

' close toolbar
Private Sub bTools_Close_Click(): On Error Resume Next
    popButton(PB_TOOLBAR).value = 0
    pTools.visible = False
End Sub

'=========================================================================================
' GENERAL BOARD EVENTS
'=========================================================================================
Private Sub brdChkHideLayers_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeBoard.mdiChkHideLayers(brdChkHideLayers.value, True)
End Sub
Private Sub brdChkShowLayers_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeBoard.mdiChkShowLayers(brdChkShowLayers.value, True)
End Sub
Private Sub brdCmbCurrentLayer_Click(): On Error Resume Next
    'Combo list is zero-indexed.
    Call activeBoard.mdiCmbCurrentLayer(CLng(brdCmbCurrentLayer.Text))
End Sub
Private Sub brdCmbVisibleLayers_Click(): On Error Resume Next
    Call activeBoard.mdiCmbVisibleLayers
End Sub
Private Sub brdOptSetting_Click(Index As Integer): On Error Resume Next
    Call activeBoard.mdiOptSetting(Index)
End Sub
Private Sub brdOptTool_Click(Index As Integer): On Error Resume Next
    Call activeBoard.mdiOptTool(Index)
End Sub
Private Sub brdChkAutotile_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeBoard.mdiChkAutotile(brdChkAutotile.value)
End Sub
Private Sub brdChkGrid_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call activeBoard.mdiChkGrid(brdChkGrid.value)
End Sub
Private Sub brdCmdUndo_Click(): On Error Resume Next
    Call activeBoard.mdiCmdUndo
End Sub
Private Sub brdPicCurrentTile_Click(): On Error Resume Next
    Dim file As String, fileTypes As String, ext As String
    fileTypes = "Supported Files|*.tst;*.iso;*.tan|RPG Toolkit TileSet (*.tst)|*.tst|RPGToolkit Isometric TileSet (*.iso)|*.iso|RPGToolkit Animated Tile (*.tan)|*.tan|All files(*.*)|*.*"
    If Not browseFileDialog(Me.hwnd, projectPath & tilePath, "Select tile", "tst", fileTypes, file) Then
        Exit Sub
    End If
    ext = UCase$(extention(file))
    
    'Set some badly-named globals.
    If ext = "TST" Or ext = "ISO" Then
        tstnum = 0
        tstFile = file
        configfile.lastTileset = file
        tilesetForm.Show vbModal
        file = setFilename
    End If
    Call activeBoard.changeSelectedTile(file)
End Sub
Private Sub Command22_Click(): On Error Resume Next
    'wip: play button for TANs on board.
    'Call activeBoard.playAnimatedTile
End Sub
Private Sub Command20_Click()
    'wip: stop button for TANs on board.
    animTileTimer.Enabled = False
End Sub
Private Sub Picture1_Click(): On Error Resume Next
    'wip: tile shading colour
    'Call activeBoard.selectAmbientColor
End Sub
Private Sub ambientlight_Change(): On Error Resume Next
    'wip: tile shading lightness
    'Call activeBoard.changeAmbientLight
End Sub
Private Sub ambientnumber_Change(): On Error Resume Next
    'wip: tile shading "value"
    'Call activeBoard.changeAmbientNumber
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
Private Sub anmCmbSize_Click(): On Error Resume Next
    If anmCmbSize.ListIndex <> -1 Then
        Call activeAnimation.setAnimSize(anmCmbSize.List(anmCmbSize.ListIndex))
    End If
    anmCmbSize.ListIndex = -1
End Sub
'Set the X-Size
Private Sub txtAnimXSize_Change(): On Error Resume Next
    Call activeAnimation.setXSize
End Sub
'Set the Y-Size
Private Sub txtAnimYSize_Change(): On Error Resume Next
    Call activeAnimation.setYSize
End Sub
'Set the pause time
Private Sub hsbAnimPause_Change(): On Error Resume Next
    tkMainForm.anmTxtPause = CStr(tkMainForm.hsbAnimPause.value / 20)
End Sub
Private Sub anmTxtPause_Change(): On Error Resume Next
    Call activeAnimation.setPause
End Sub
Private Sub anmCmdFile_Click(): On Error Resume Next
    Call activeAnimation.BrowseFile
End Sub
Private Sub anmTxtFile_Change(): On Error Resume Next
    Call activeAnimation.changeFile(anmTxtFile.Text)
End Sub
'Set the sound
Private Sub anmCmdSound_Click(): On Error Resume Next
    Call activeAnimation.browseSound
End Sub
Private Sub anmTxtSound_Change(): On Error Resume Next
    Call activeAnimation.changeSound(anmTxtSound.Text)
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
'Animation wizard
Private Sub anmCmdWizard_Click(): On Error Resume Next
    frmAnmWizard.Show vbModal
End Sub

Private Sub animTile_Timer(): On Error Resume Next
    'wip:'Call activeBoard.animateTile
End Sub
Private Sub Command4_Click(): On Error Resume Next
    'Call activeAnimation.Command7_Click
End Sub

'=========================================================================================
' END ANIMATION EDITOR RELATED EVENTS
'=========================================================================================
