VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form editmainfile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Project Properties (Untitled)"
   ClientHeight    =   6030
   ClientLeft      =   90
   ClientTop       =   480
   ClientWidth     =   7515
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
   Icon            =   "EDITMAINv2.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6030
   ScaleWidth      =   7515
   Tag             =   "7"
   Begin VB.TextBox gametitlebox 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   4080
      TabIndex        =   80
      Top             =   5280
      Visible         =   0   'False
      Width           =   3135
   End
   Begin TabDlg.SSTab tabMain 
      Height          =   5640
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   9948
      _Version        =   393216
      Style           =   1
      Tabs            =   7
      TabsPerRow      =   7
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Project Settings"
      TabPicture(0)   =   "EDITMAINv2.frx":0CCA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "envframe"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "prjframe"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Startup Info"
      TabPicture(1)   =   "EDITMAINv2.frx":0CE6
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "fraSettings"
      Tab(1).Control(1)=   "startframe"
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "RPGCode"
      TabPicture(2)   =   "EDITMAINv2.frx":0D02
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "prgframe"
      Tab(2).Control(1)=   "actionframe"
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Fighting"
      TabPicture(3)   =   "EDITMAINv2.frx":0D1E
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "fightframe"
      Tab(3).ControlCount=   1
      TabCaption(4)   =   "Graphics"
      TabPicture(4)   =   "EDITMAINv2.frx":0D3A
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "screenframe"
      Tab(4).ControlCount=   1
      TabCaption(5)   =   "Day/Night"
      TabPicture(5)   =   "EDITMAINv2.frx":0D56
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "Label24"
      Tab(5).Control(1)=   "daynightcheckbox"
      Tab(5).Control(2)=   "Frame3"
      Tab(5).ControlCount=   3
      TabCaption(6)   =   "Plugins"
      TabPicture(6)   =   "EDITMAINv2.frx":0D72
      Tab(6).ControlEnabled=   0   'False
      Tab(6).Control(0)=   "Frame1"
      Tab(6).ControlCount=   1
      Begin VB.Frame fraSettings 
         Caption         =   "Misc Settings:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Left            =   -74760
         TabIndex        =   81
         Top             =   2520
         Width           =   6615
         Begin VB.CheckBox chkUsePixelPush 
            Caption         =   "Push() in pixel increments (changable with PixelMovement())."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1800
            TabIndex        =   99
            Top             =   1800
            Width           =   4695
         End
         Begin VB.CommandButton cmdMouseCursor 
            Caption         =   "Mouse Cursor"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   87
            Top             =   2040
            Width           =   1455
         End
         Begin VB.OptionButton optTileBased 
            Caption         =   "Tile Based"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   3240
            TabIndex        =   86
            Top             =   1440
            Width           =   1815
         End
         Begin VB.OptionButton optPixelBased 
            Caption         =   "Pixel Based"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1800
            TabIndex        =   85
            Top             =   1440
            Width           =   1215
         End
         Begin MSComctlLib.Slider sliGameSpeed 
            Height          =   495
            Left            =   2400
            TabIndex        =   83
            TabStop         =   0   'False
            Top             =   240
            Width           =   3975
            _ExtentX        =   7011
            _ExtentY        =   873
            _Version        =   393216
            LargeChange     =   2
            Min             =   -4
            Max             =   4
         End
         Begin VB.Label lblGamesSpeedNote 
            Caption         =   $"EDITMAINv2.frx":0D8E
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   98
            Top             =   840
            Width           =   6255
         End
         Begin VB.Label Label23 
            Caption         =   "Movement style:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   84
            Top             =   1440
            Width           =   1215
         End
         Begin VB.Label Label15 
            Caption         =   "Additional speed adjustment: (GameSpeed() initial value)."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   82
            Top             =   360
            Width           =   2895
         End
      End
      Begin VB.Frame fightframe 
         Caption         =   "Fighting:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Left            =   -74760
         TabIndex        =   74
         Tag             =   "1186"
         Top             =   600
         Width           =   6615
         Begin VB.CommandButton cmdEditFighting 
            Appearance      =   0  'Flat
            Caption         =   "Edit..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   120
            TabIndex        =   77
            Tag             =   "1187"
            Top             =   600
            Width           =   1095
         End
         Begin VB.OptionButton optDisableFighting 
            Caption         =   "No"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1680
            TabIndex        =   76
            Tag             =   "1099"
            Top             =   600
            Width           =   735
         End
         Begin VB.OptionButton optEnableFighting 
            Caption         =   "Yes"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1680
            TabIndex        =   75
            Tag             =   "1100"
            Top             =   360
            Value           =   -1  'True
            Width           =   735
         End
         Begin VB.Label Label11 
            Caption         =   "Fighting In Game:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   79
            Tag             =   "1189"
            Top             =   360
            Width           =   1575
         End
         Begin VB.Label Label2 
            Caption         =   "Also see Enemy Editor"
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
            Height          =   255
            Left            =   2520
            MouseIcon       =   "EDITMAINv2.frx":0E46
            MousePointer    =   99  'Custom
            TabIndex        =   78
            Tag             =   "1188"
            Top             =   960
            Visible         =   0   'False
            Width           =   2775
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Plugins"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3855
         Left            =   -74760
         TabIndex        =   64
         Tag             =   "1167"
         Top             =   600
         Width           =   6615
         Begin VB.ListBox plugList 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2010
            Left            =   240
            TabIndex        =   71
            Top             =   480
            Width           =   4815
         End
         Begin VB.CommandButton cmdRemovePlugin 
            Appearance      =   0  'Flat
            Caption         =   "Remove"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   70
            Top             =   2160
            Width           =   1095
         End
         Begin VB.CommandButton cmdAddPlugin 
            Appearance      =   0  'Flat
            Caption         =   "Add"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   69
            Top             =   1680
            Width           =   1095
         End
         Begin VB.CommandButton cmdSelectMenuSystem 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   68
            Tag             =   "1021"
            Top             =   2880
            Width           =   1095
         End
         Begin VB.TextBox mnuplugin 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2400
            TabIndex        =   67
            Text            =   "None"
            Top             =   2880
            Width           =   2655
         End
         Begin VB.TextBox fgtPlugin 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2400
            TabIndex        =   66
            Text            =   "None"
            Top             =   3360
            Width           =   2655
         End
         Begin VB.CommandButton cmdSelectBattleSystem 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   65
            Tag             =   "1021"
            Top             =   3360
            Width           =   1095
         End
         Begin VB.Label Label5 
            Caption         =   "Menu System Plugin:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   73
            Top             =   2880
            Width           =   2055
         End
         Begin VB.Label Label14 
            Caption         =   "Fight System Plugin:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   72
            Top             =   3360
            Width           =   2055
         End
      End
      Begin VB.Frame startframe 
         Caption         =   "Startup Conditions:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   -74760
         TabIndex        =   55
         Tag             =   "1156"
         Top             =   600
         Width           =   6615
         Begin VB.TextBox initcharbox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2040
            TabIndex        =   59
            Text            =   "None"
            Top             =   720
            Width           =   3135
         End
         Begin VB.TextBox initboardbox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2040
            TabIndex        =   58
            Text            =   "None"
            Top             =   360
            Width           =   3135
         End
         Begin VB.CommandButton cmdInitialBoard 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5400
            TabIndex        =   57
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.CommandButton cmdInitialChar 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5400
            TabIndex        =   56
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
         End
         Begin VB.Label lblInitialBoardTip 
            Caption         =   "Note: You can leave the initial board empty if do not want to specify one."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   100
            Top             =   1200
            Width           =   5175
         End
         Begin VB.Label Label10 
            Caption         =   "Initial Character File:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   63
            Tag             =   "1160"
            Top             =   720
            Width           =   1695
         End
         Begin VB.Label Label20 
            Caption         =   "Initial Board File:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   62
            Tag             =   "1159"
            Top             =   360
            Width           =   2055
         End
         Begin VB.Label Label9 
            Caption         =   "Also see Board Editor"
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
            Height          =   255
            Left            =   240
            MouseIcon       =   "EDITMAINv2.frx":1150
            MousePointer    =   99  'Custom
            TabIndex        =   61
            Tag             =   "1158"
            Top             =   1320
            Visible         =   0   'False
            Width           =   2175
         End
         Begin VB.Label Label21 
            Caption         =   "Also see Character Editor"
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
            Height          =   255
            Left            =   3000
            MouseIcon       =   "EDITMAINv2.frx":145A
            MousePointer    =   99  'Custom
            TabIndex        =   60
            Tag             =   "1157"
            Top             =   1320
            Visible         =   0   'False
            Width           =   2415
         End
      End
      Begin VB.Frame actionframe 
         Caption         =   "Action Keys"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Left            =   -74760
         TabIndex        =   47
         Tag             =   "1151"
         Top             =   2880
         Width           =   6615
         Begin VB.TextBox keybox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   3840
            TabIndex        =   51
            Text            =   "None"
            Top             =   840
            Width           =   615
         End
         Begin VB.TextBox menukeybox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   3840
            TabIndex        =   50
            Text            =   "None"
            Top             =   600
            Width           =   615
         End
         Begin VB.TextBox runkeybox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   3840
            TabIndex        =   49
            Text            =   "None"
            Top             =   360
            Width           =   615
         End
         Begin VB.CommandButton cmdExtendedRunTimes 
            Caption         =   "More"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   48
            Tag             =   "1152"
            Top             =   360
            Width           =   1095
         End
         Begin VB.Label Label8 
            Caption         =   "General Activation Key:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   54
            Tag             =   "1155"
            Top             =   840
            Width           =   3495
         End
         Begin VB.Label Label7 
            Caption         =   "Built In Menu Activation Key:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   53
            Tag             =   "1154"
            Top             =   600
            Width           =   3495
         End
         Begin VB.Label Label6 
            Caption         =   "Run Time Program Activation Key:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   52
            Tag             =   "1153"
            Top             =   360
            Width           =   3495
         End
      End
      Begin VB.Frame prgframe 
         Caption         =   "Programs"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2055
         Left            =   -74760
         TabIndex        =   35
         Tag             =   "1144"
         Top             =   600
         Width           =   6615
         Begin VB.CommandButton cmdSkin 
            Caption         =   "Skin"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   480
            TabIndex        =   42
            Tag             =   "1145"
            Top             =   1200
            Visible         =   0   'False
            Width           =   1095
         End
         Begin VB.TextBox txtGameOver 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   41
            Text            =   "None"
            Top             =   960
            Width           =   2655
         End
         Begin VB.TextBox runtimebox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   40
            Text            =   "None"
            Top             =   240
            Width           =   2655
         End
         Begin VB.TextBox startupbox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   39
            Text            =   "None"
            Top             =   600
            Width           =   2655
         End
         Begin VB.CommandButton cmdRunTimePrg 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   38
            Tag             =   "1021"
            Top             =   240
            Width           =   1095
         End
         Begin VB.CommandButton cmdStartUpPrg 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   37
            Tag             =   "1021"
            Top             =   600
            Width           =   1095
         End
         Begin VB.CommandButton cmdGameOverPrg 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   36
            Tag             =   "1021"
            Top             =   960
            Width           =   1095
         End
         Begin VB.Label Label17 
            Caption         =   "Game Over Program:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   46
            Tag             =   "1149"
            Top             =   960
            Width           =   2295
         End
         Begin VB.Label Label3 
            Caption         =   "Startup Program:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   45
            Tag             =   "1148"
            Top             =   600
            Width           =   2295
         End
         Begin VB.Label Label4 
            Caption         =   "Run Time Program:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   240
            TabIndex        =   44
            Tag             =   "1146"
            Top             =   240
            Width           =   2175
         End
         Begin VB.Label Label22 
            Caption         =   "Also see RPGCode Editor"
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
            Height          =   255
            Left            =   2280
            MouseIcon       =   "EDITMAINv2.frx":1764
            MousePointer    =   99  'Custom
            TabIndex        =   43
            Tag             =   "1150"
            Top             =   1680
            Visible         =   0   'False
            Width           =   3135
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Day length"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1575
         Left            =   -74760
         TabIndex        =   29
         Tag             =   "1162"
         Top             =   1080
         Width           =   6255
         Begin VB.OptionButton daynightreal 
            Caption         =   "Day and night corresponds to Real World"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   32
            Tag             =   "1164"
            Top             =   360
            Value           =   -1  'True
            Width           =   4455
         End
         Begin VB.OptionButton daynightvirtual 
            Caption         =   "The day is a set number of minutes long"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   31
            Tag             =   "1163"
            Top             =   720
            Width           =   4575
         End
         Begin VB.TextBox daylengthbox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   600
            TabIndex        =   30
            Text            =   "10"
            Top             =   1080
            Width           =   735
         End
         Begin VB.Label Label25 
            Caption         =   "Minutes"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1560
            TabIndex        =   33
            Tag             =   "1165"
            Top             =   1080
            Width           =   1095
         End
      End
      Begin VB.CheckBox daynightcheckbox 
         Caption         =   "Game is affected by day and night"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74760
         TabIndex        =   28
         Tag             =   "1166"
         Top             =   600
         Width           =   4455
      End
      Begin VB.Frame screenframe 
         Caption         =   "Screen Mode"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3615
         Left            =   -74760
         TabIndex        =   19
         Tag             =   "1136"
         Top             =   600
         Width           =   6735
         Begin VB.Frame Frame5 
            Caption         =   "Custom Resolution"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1335
            Left            =   360
            TabIndex        =   92
            Top             =   2040
            Width           =   5655
            Begin VB.TextBox txtResY 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   285
               Left            =   2040
               TabIndex        =   97
               Top             =   720
               Width           =   1215
            End
            Begin VB.TextBox txtResX 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   285
               Left            =   360
               TabIndex        =   95
               Top             =   720
               Width           =   1215
            End
            Begin VB.Label Label28 
               Caption         =   "y:"
               Height          =   255
               Left            =   1800
               TabIndex        =   96
               Top             =   720
               Width           =   255
            End
            Begin VB.Label Label27 
               Caption         =   "x:"
               Height          =   255
               Left            =   120
               TabIndex        =   94
               Top             =   720
               Width           =   255
            End
            Begin VB.Label Label26 
               Caption         =   "Please note that not all video cards support all possible resolutions."
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   93
               Top             =   360
               Width           =   4815
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "Screen Style"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1575
            Left            =   2280
            TabIndex        =   89
            Top             =   360
            Width           =   1815
            Begin VB.OptionButton chkScreenStyle 
               Caption         =   "Full Screen"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   91
               Top             =   600
               Width           =   1335
            End
            Begin VB.OptionButton chkScreenStyle 
               Caption         =   "Windowed"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   90
               Top             =   360
               Width           =   1335
            End
         End
         Begin VB.Frame optres 
            Caption         =   "Resolution"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1575
            Left            =   4320
            TabIndex        =   24
            Top             =   360
            Width           =   1695
            Begin VB.OptionButton optResCustom 
               Caption         =   "Custom"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   88
               Top             =   1080
               Width           =   1215
            End
            Begin VB.OptionButton sixfourty 
               Caption         =   "640x480"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   120
               TabIndex        =   27
               Tag             =   "1140"
               Top             =   360
               Width           =   1335
            End
            Begin VB.OptionButton eighthundred 
               Caption         =   "800x600"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   120
               TabIndex        =   26
               Tag             =   "1139"
               Top             =   600
               Width           =   1335
            End
            Begin VB.OptionButton tentwentyfour 
               Caption         =   "1024x768"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   120
               TabIndex        =   25
               Tag             =   "1138"
               Top             =   840
               Width           =   1335
            End
         End
         Begin VB.Frame Frame4 
            Caption         =   "Color Depth"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1575
            Left            =   360
            TabIndex        =   20
            Top             =   360
            Width           =   1815
            Begin VB.OptionButton color16bit 
               Caption         =   "16-bit"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   23
               Top             =   360
               Width           =   855
            End
            Begin VB.OptionButton color24bit 
               Caption         =   "24-bit"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   22
               Top             =   600
               Width           =   855
            End
            Begin VB.OptionButton color32bit 
               Caption         =   "32-bit"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   21
               Top             =   840
               Width           =   855
            End
         End
      End
      Begin VB.Frame prjframe 
         Caption         =   "Project Info"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   240
         TabIndex        =   12
         Tag             =   "1182"
         Top             =   600
         Width           =   6495
         Begin VB.TextBox gametitlebox2 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   1920
            TabIndex        =   15
            Top             =   240
            Width           =   3255
         End
         Begin VB.CheckBox regprotect 
            Caption         =   "Protect Files from Tampering"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1920
            TabIndex        =   14
            Tag             =   "1183"
            Top             =   1320
            Width           =   3735
         End
         Begin VB.CheckBox enableJoystick 
            Caption         =   "Enable Joystick"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1920
            TabIndex        =   13
            Top             =   960
            Width           =   3735
         End
         Begin VB.Label pathbox 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1920
            TabIndex        =   18
            Top             =   600
            Width           =   2895
         End
         Begin VB.Label Label19 
            Caption         =   "Project Path:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   120
            TabIndex        =   17
            Tag             =   "1185"
            Top             =   600
            Width           =   1215
         End
         Begin VB.Label Label18 
            Caption         =   "Project Name:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   16
            Tag             =   "1184"
            Top             =   240
            Width           =   1575
         End
      End
      Begin VB.Frame envframe 
         Caption         =   "Cursor Sounds:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   240
         TabIndex        =   2
         Top             =   2520
         Width           =   6495
         Begin VB.TextBox cursormove 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   8
            Top             =   480
            Width           =   2655
         End
         Begin VB.TextBox cursorcancel 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   7
            Top             =   1200
            Width           =   2655
         End
         Begin VB.TextBox cursorselect 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   2520
            TabIndex        =   6
            Top             =   840
            Width           =   2655
         End
         Begin VB.CommandButton cmdCursorMoveSound 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   5
            Tag             =   "1021"
            Top             =   480
            Width           =   1095
         End
         Begin VB.CommandButton cmdCursorSelectSound 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   4
            Tag             =   "1021"
            Top             =   840
            Width           =   1095
         End
         Begin VB.CommandButton cmdCursorCancelSound 
            Caption         =   "Browse..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5280
            TabIndex        =   3
            Tag             =   "1021"
            Top             =   1200
            Width           =   1095
         End
         Begin VB.Label Label1 
            Caption         =   "Cursor Move:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   11
            Top             =   480
            Width           =   2175
         End
         Begin VB.Label Label12 
            Caption         =   "Cursor Select:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   10
            Top             =   840
            Width           =   2175
         End
         Begin VB.Label Label13 
            Caption         =   "Cursor Cancel:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Top             =   1200
            Width           =   2175
         End
      End
      Begin VB.Label Label24 
         Caption         =   "Also see Board Editor"
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
         Height          =   255
         Left            =   -74760
         MouseIcon       =   "EDITMAINv2.frx":1A6E
         MousePointer    =   99  'Custom
         TabIndex        =   34
         Tag             =   "1158"
         Top             =   2880
         Visible         =   0   'False
         Width           =   3495
      End
   End
   Begin VB.Label Label16 
      Caption         =   "Title Of The Game:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Tag             =   "1199"
      Top             =   5400
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Menu filemnu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu mnuNewProject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuNew 
         Caption         =   "New..."
         Begin VB.Menu mnuNewTile 
            Caption         =   "Tile"
         End
         Begin VB.Menu mnuNewAnimatedTile 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu mnuNewBoard 
            Caption         =   "Board"
         End
         Begin VB.Menu mnuNewPlayer 
            Caption         =   "Player"
         End
         Begin VB.Menu mnuNewItem 
            Caption         =   "Item"
         End
         Begin VB.Menu mnuNewEnemy 
            Caption         =   "Enemy"
         End
         Begin VB.Menu mnuNewRPGCodeProgram 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu mnuNewSpecialMove 
            Caption         =   "Special Move"
         End
         Begin VB.Menu mnuNewStatusEffect 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu mnuNewAnimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnunewTileBitmap 
            Caption         =   "Tile Bitmap"
         End
      End
      Begin VB.Menu sub1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "Open"
         Shortcut        =   ^O
         Tag             =   "1350"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save"
         Shortcut        =   ^S
         Tag             =   "1233"
      End
      Begin VB.Menu mnusaveas 
         Caption         =   "Save As"
         Shortcut        =   ^A
         Tag             =   "1234"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuclose 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnuTestGame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuSelectLanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInstallUpgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnuBuild 
      Caption         =   "Build"
      Begin VB.Menu mnuCreatePakFile 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu mnuMakeEXE 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCreateSetup 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu mnuShowTools 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu mnuShowProjectList 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sub5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTileHorizontally 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu mnuTileVertically 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu mnuCascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuArrangeIcons 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu h 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuusersguide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
         Tag             =   "1207"
      End
      Begin VB.Menu mnuRPGCodePrimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnuRPGCodeReference 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuregistrationinfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "editmainfile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Main file editor
'=========================================================================

Option Explicit

'=========================================================================
' Read-only property returning type of form
'=========================================================================
Public Property Get formType() As Long
    On Error Resume Next
    formType = FT_MAINFILE
End Property

'=========================================================================
' Fill in plugin tab
'=========================================================================
Private Sub pluginInfoFill()
    On Error Resume Next
    Call plugList.Clear
    Dim t As Integer
    For t = 0 To UBound(mainMem.plugins)
        If mainMem.plugins(t) <> "" Then
            Dim descrip As String
            descrip = pluginDescription(projectPath & plugPath & mainMem.plugins(t))
            Call plugList.AddItem(mainMem.plugins(t) & "    " & descrip)
        End If
    Next t
    Call PLUGShutdownSystem
End Sub

'=========================================================================
' Save the file
'=========================================================================
Public Sub saveFile()
    On Error Resume Next
    filename(2) = mainFile
    mainNeedUpdate = False
    If filename(2) = "" Then
        Call editmainfile.Show
        Call mnusaveas_Click
    Else
        DoEvents
        Call saveMain(gamPath & filename(2), mainMem)
    End If
End Sub

'=========================================================================
' Clear the data
'=========================================================================
Public Sub clearAll()
    On Error Resume Next
    Call MainClear(mainMem)
End Sub

'=========================================================================
' Close menu
'=========================================================================
Private Sub closemnu_Click()
    On Error Resume Next
    Call Unload(mainfight)
    Call Unload(editmainfile)
End Sub

'=========================================================================
' Change screen style
'=========================================================================
Private Sub chkScreenStyle_Click(ByRef Index As Integer)
    mainMem.extendToFullScreen = Index
End Sub

'=========================================================================
' #Push() in pixel increments.
'=========================================================================
Private Sub chkUsePixelPush_Click()
    If (optPixelBased.value) Then
        If (chkUsePixelPush.value) Then
            mainMem.pixelMovement = PIXEL_MOVEMENT_PIXEL_PUSH
        Else
            mainMem.pixelMovement = PIXEL_MOVEMENT_TILE_PUSH
        End If
    End If
End Sub

'=========================================================================
' Mouse cursor button
'=========================================================================
Private Sub cmdMouseCursor_Click()
    Call frmMouseCursor.Show
End Sub

'=========================================================================
' Color depth option boxes
'=========================================================================
Private Sub color16bit_Click()
    On Error Resume Next
    mainMem.colordepth = COLOR16
End Sub
Private Sub color24bit_Click()
    On Error Resume Next
    mainMem.colordepth = COLOR24
End Sub
Private Sub color32bit_Click()
    On Error Resume Next
    mainMem.colordepth = COLOR32
End Sub

'=========================================================================
' Open the main fight editor
'=========================================================================
Private Sub cmdEditFighting_Click(): On Error Resume Next
    mainNeedUpdate = True
    Call mainfight.Show
End Sub

'=========================================================================
' Select battle system
'=========================================================================
Private Sub cmdSelectBattleSystem_Click(): On Error Resume Next
    
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo
    With dlg
        .strDefaultFolder = projectPath & plugPath
        .strTitle = "Select Plugin"
        .strDefaultExt = "dll"
        .strFileTypes = "RPG Toolkit Plugin (*.dll)|*.dll|All files(*.*)|*.*"
        If OpenFileDialog(dlg, Me.hwnd) Then
            filename(1) = .strSelectedFile
            Dim antiPath As String
            antiPath = .strSelectedFileNoPath
        Else
            Exit Sub
        End If
    End With

    mainNeedUpdate = True
    Call ChDir(currentDir)
    If filename(1) = "" Then Exit Sub
    Call FileCopy(filename(1), projectPath & plugPath & antiPath)
    fgtPlugin.Text = antiPath
    mainMem.fightPlugin = antiPath

End Sub

'=========================================================================
' Select initial board
'=========================================================================
Private Sub cmdInitialBoard_Click(): On Error Resume Next
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & brdPath$
    dlg.strTitle = "Select Board"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    Call ChDir(currentDir$)
    If filename$(1) = "" Then Exit Sub
    Call FileCopy(filename$(1), projectPath$ & brdPath$ & antiPath$)
    initboardbox.Text = antiPath$
    mainMem.initBoard$ = antiPath$
End Sub

'=========================================================================
' Select initial character
'=========================================================================
Private Sub cmdInitialChar_Click(): On Error Resume Next
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & temPath$
    dlg.strTitle = "Select Character"
    dlg.strDefaultExt = "tem"
    dlg.strFileTypes = "Supported Files|*.tem|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    Call FileCopy(filename$(1), projectPath$ & temPath$ & antiPath$)
    initcharbox.Text = antiPath$
    mainMem.initChar$ = antiPath$
End Sub

'=========================================================================
' Select runtime program
'=========================================================================
Private Sub cmdRunTimePrg_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & prgPath$
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    Call FileCopy(filename$(1), projectPath$ & prgPath$ & antiPath$)
    runtimebox.Text = antiPath$
    mainMem.runTime$ = antiPath$
End Sub

'=========================================================================
' Select startup program
'=========================================================================
Private Sub cmdStartUpPrg_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & prgPath$
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & prgPath$ & antiPath$
    startupbox.Text = antiPath$
    mainMem.startupPrg$ = antiPath$
End Sub

'=========================================================================
' Select game over program
'=========================================================================
Private Sub cmdGameOverPrg_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & prgPath$
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & prgPath$ & antiPath$
    txtGameOver.Text = antiPath$
    mainMem.gameOverPrg$ = antiPath$
End Sub

'=========================================================================
' Extended run-time programs
'=========================================================================
Private Sub cmdExtendedRunTimes_Click(): On Error Resume Next
    Call runtimeprograms.Show
End Sub

'=========================================================================
' Remove plugin
'=========================================================================
Private Sub cmdRemovePlugin_Click(): On Error Resume Next

    If plugList.ListIndex = -1 Then plugList.ListIndex = 0
    Call MainRemovePlugin(mainMem, MainGetNthPlugin(mainMem, plugList.ListIndex))
    Dim idx As Long
    idx = plugList.ListIndex - 1
    If idx = -1 Then idx = 0
    Call pluginInfoFill
    plugList.ListIndex = idx
    
End Sub

'=========================================================================
' Add plugin
'=========================================================================
Private Sub cmdAddPlugin_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & plugPath$
    dlg.strTitle = "Select Plugin"
    dlg.strDefaultExt = "dll"
    dlg.strFileTypes = "RPG Toolkit Plugins (*.dll)|*.dll|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & plugPath$ & antiPath$
    Call MainAddPlugin(mainMem, antiPath$)
    Call pluginInfoFill
End Sub

'=========================================================================
' Select menu system
'=========================================================================
Private Sub cmdSelectMenuSystem_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & plugPath$
    dlg.strTitle = "Select Plugin"
    dlg.strDefaultExt = "dll"
    dlg.strFileTypes = "RPG Toolkit Plugin (*.dll)|*.dll|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & plugPath$ & antiPath$
    mnuplugin.Text = antiPath$
    mainMem.menuPlugin = antiPath$
End Sub

'=========================================================================
' Select cursor move sound
'=========================================================================
Private Sub cmdCursorMoveSound_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediaPath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    cursormove.Text = antiPath$
    mainMem.cursorMoveSound = antiPath$
End Sub

'=========================================================================
' Select cursor select sound
'=========================================================================
Private Sub cmdCursorSelectSound_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & mediaPath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & mediaPath$ & antiPath$
    cursorselect.Text = antiPath$
    mainMem.cursorSelectSound = antiPath$
End Sub

'=========================================================================
' Select cursor cancel sound
'=========================================================================
Private Sub cmdCursorCancelSound_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ & mediaPath$
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ & mediaPath$ & antiPath$
    cursorcancel.Text = antiPath$
    mainMem.cursorCancelSound = antiPath$
End Sub

'=========================================================================
' Cursor sound effect changing events
'=========================================================================
Private Sub cursorcancel_Change()
    On Error Resume Next
    mainMem.cursorCancelSound = cursorcancel.Text
End Sub
Private Sub cursormove_Change()
    On Error Resume Next
    mainMem.cursorMoveSound = cursormove.Text
End Sub
Private Sub cursorselect_Change()
    On Error Resume Next
    mainMem.cursorSelectSound = cursorselect.Text
End Sub

'=========================================================================
' Day/night settings
'=========================================================================
Private Sub daylengthbox_Change()
    On Error Resume Next
    mainMem.mainDayLength = val(daylengthbox.Text)
End Sub
Private Sub daynightcheckbox_Click()
    On Error Resume Next
    mainMem.mainUseDayNight = daynightcheckbox.value
    Frame3.Visible = (mainMem.mainUseDayNight = 1)
End Sub
Private Sub daynightreal_Click()
    mainMem.mainDayNightType = 0
    daylengthbox.Enabled = False
End Sub
Private Sub daynightvirtual_Click()
    mainMem.mainDayNightType = 1
    daylengthbox.Enabled = True
End Sub

'=========================================================================
' Set resolution to 800 x 600
'=========================================================================
Private Sub eighthundred_Click()
    On Error Resume Next
    mainMem.mainResolution = 1
End Sub

'=========================================================================
' Enable / disable the joystick
'=========================================================================
Private Sub enableJoystick_Click()
    On Error Resume Next
    mainMem.useJoystick = enableJoystick.value
End Sub

'=========================================================================
' Change the fight plugin
'=========================================================================
Private Sub fgtPlugin_Change()
    On Error Resume Next
    mainMem.fightPlugin = fgtPlugin.Text
End Sub

'=========================================================================
' Update activeForm
'=========================================================================
Private Sub Form_Activate(): On Error Resume Next
    Set activeForm = Me
    Call hideAllTools
End Sub

'=========================================================================
' Load form
'=========================================================================
Private Sub Form_Load(): On Error Resume Next

    Call LocalizeForm(Me)
    Me.height = 6270
    Me.width = 7600
    filename(2) = vbNullString
    sliGameSpeed.max = MAX_GAMESPEED                'Gamespeed range.
    sliGameSpeed.min = -MAX_GAMESPEED
    Call infoFill
End Sub

'=========================================================================
' Resize form
'=========================================================================
Private Sub Form_Resize(): On Error Resume Next
    'Centre the tabs.
    tabMain.Top = (Me.height - tabMain.height) / 2 - 200
    tabMain.Left = (Me.width - tabMain.width) / 2
End Sub

'=========================================================================
' Unload form
'=========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Call releaseComPlugins
    Call hideAllTools
End Sub

'=========================================================================
' Set the game to run in full-screen
'=========================================================================
Private Sub fullscreen_Click()
    On Error Resume Next
    mainNeedUpdate = True
    mainMem.mainScreenType = 1
End Sub

'=========================================================================
' Change game title
'=========================================================================
Private Sub gametitlebox_Change()
    On Error Resume Next
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox.Text
    gametitlebox2.Text = mainMem.gameTitle$
End Sub

'=========================================================================
' Fill in the form with info
'=========================================================================
Private Sub infoFill()
    On Error Resume Next
    optEnableFighting.value = True
    If mainMem.startupPrg$ <> "" Then
        startupbox.Text = mainMem.startupPrg$          'start up program
    Else
        startupbox.Text = LoadStringLoc(1010, "None")
    End If
    If mainMem.runTime$ <> "" Then
        runtimebox.Text = mainMem.runTime$             'run time program
    Else
        runtimebox.Text = LoadStringLoc(1010, "None")
    End If
    If mainMem.gameOverPrg$ <> "" Then
        txtGameOver.Text = mainMem.gameOverPrg$             'run time program
    Else
        txtGameOver.Text = LoadStringLoc(1010, "None")
    End If
    mnuplugin.Text = mainMem.menuPlugin
    fgtPlugin.Text = mainMem.fightPlugin
    
    Dim a As String
    a$ = UCase$(chr$(mainMem.runKey))
    If mainMem.runKey = 32 Then a$ = "SPC"
    If mainMem.runKey = 27 Then a$ = "ESC"
    If mainMem.runKey = 13 Then a$ = "ENTR"
    runkeybox.Text = a$
    a$ = UCase$(chr$(mainMem.menuKey))
    If mainMem.menuKey = 32 Then a$ = "SPC"
    If mainMem.menuKey = 27 Then a$ = "ESC"
    If mainMem.menuKey = 13 Then a$ = "ENTR"
    menukeybox.Text = a$
    a$ = UCase$(chr$(mainMem.Key))
    If mainMem.Key = 32 Then a$ = "SPC"
    If mainMem.Key = 27 Then a$ = "ESC"
    If mainMem.Key = 13 Then a$ = "ENTR"
    keybox.Text = a$

    If mainMem.initBoard$ <> "" Then
        initboardbox.Text = mainMem.initBoard$           'initial board
    Else
        initboardbox.Text = LoadStringLoc(1010, "None")
    End If
    If mainMem.initChar$ <> "" Then
        initcharbox.Text = mainMem.initChar$            'initial character
    Else
        initcharbox.Text = LoadStringLoc(1010, "None")
    End If

    optDisableFighting.value = mainMem.fightgameYN             'fighting in game? 0-yes, 1-no
   
    gametitlebox.Text = mainMem.gameTitle$
    gametitlebox2.Text = mainMem.gameTitle$
    editmainfile.Caption = LoadStringLoc(800, "Main Project Editor") + "  (" + mainFile$ + ")"
    
    pathbox.Caption = projectPath
    
    chkScreenStyle(mainMem.extendToFullScreen).value = True

    txtResX.Text = CStr(mainMem.resX)
    txtResY.Text = CStr(mainMem.resY)

    sixfourty.value = (mainMem.mainResolution = 0)
    eighthundred.value = (mainMem.mainResolution = 1)
    tentwentyfour.value = (mainMem.mainResolution = 2)
    optResCustom.value = (mainMem.mainResolution = 4)
    
    Call pluginInfoFill

    daynightcheckbox.value = mainMem.mainUseDayNight
    Frame3.Visible = (mainMem.mainUseDayNight = 1)
    If mainMem.mainDayNightType = 0 Then
        daynightreal.value = True
        daylengthbox.Enabled = False
    Else
        daynightvirtual.value = True
        daylengthbox.Enabled = True
    End If
    daylengthbox.Text = CStr(mainMem.mainDayLength)

    If mainMem.mainDisableProtectReg = 0 Then
        regprotect.value = 1
    Else
        regprotect.value = 0
    End If
    
    regprotect.Visible = False
   
    cursormove.Text = mainMem.cursorMoveSound
    cursorselect.Text = mainMem.cursorSelectSound
    cursorcancel.Text = mainMem.cursorCancelSound

    enableJoystick.value = mainMem.useJoystick

    Select Case mainMem.colordepth
        Case COLOR16:
            color16bit.value = True
        Case COLOR24:
            color24bit.value = True
        Case COLOR32:
            color32bit.value = True
    End Select
   
    Select Case mainMem.pixelMovement
        Case PIXEL_MOVEMENT_PIXEL_PUSH
            optPixelBased.value = True
            chkUsePixelPush.value = 1
            chkUsePixelPush.Enabled = True
        Case PIXEL_MOVEMENT_TILE_PUSH
            optPixelBased.value = True
            chkUsePixelPush.value = 0
            chkUsePixelPush.Enabled = True
        Case Else
            'TILE_MOVEMENT or error.
            optTileBased.value = True
            chkUsePixelPush.value = 0
            chkUsePixelPush.Enabled = False
    End Select
    
    sliGameSpeed.value = getGameSpeed(mainMem.gameSpeed)

End Sub

'=========================================================================
' Change game title
'=========================================================================
Private Sub gametitlebox2_Change()
    On Error Resume Next
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox2.Text
    gametitlebox.Text = mainMem.gameTitle$
End Sub

'=========================================================================
' Change initial board
'=========================================================================
Private Sub initboardbox_Change()
    On Error Resume Next
    mainMem.initBoard = initboardbox.Text
End Sub

'=========================================================================
' Change initial character
'=========================================================================
Private Sub initcharbox_Change()
    On Error Resume Next
    mainMem.initChar$ = initcharbox.Text
End Sub

'=========================================================================
' Press a key in the key box
'=========================================================================
Private Sub keybox_KeyPress(ByRef KeyAscii As Integer)
    On Error Resume Next
    mainNeedUpdate = True
    Dim ascii As Long
    ascii = KeyAscii
    If mainMem.menuKey = ascii Or mainMem.runKey = ascii Then
        MsgBox LoadStringLoc(963, "That's already being used!")
        KeyAscii = 0
        Exit Sub
    End If
    mainMem.Key = ascii
    Dim a As String
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    keybox.Text = a$
    KeyAscii = 0
End Sub

'=========================================================================
' Show the enemy editor
'=========================================================================
Private Sub Label2_Click()
    Call activeEnemy.Show
End Sub

'=========================================================================
' Show the player editor
'=========================================================================
Private Sub Label21_Click()
    Call activePlayer.Show
End Sub

'=========================================================================
' Show the RPGCode editor
'=========================================================================
Private Sub Label22_Click()
    Call activeRPGCode.Show
End Sub

'=========================================================================
' Show the board editor
'=========================================================================
Private Sub Label24_Click()
    Call activeBoard.Show
End Sub

Private Sub Label9_Click()
    Call activeBoard.Show
End Sub

'=========================================================================
' Press a key in a key box
'=========================================================================
Private Sub menukeybox_KeyPress(ByRef KeyAscii As Integer)
    On Error Resume Next
    mainNeedUpdate = True
    Dim ascii As Long
    ascii = KeyAscii
    If mainMem.runKey = ascii Or mainMem.Key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.menuKey = ascii
    Dim a As String
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    menukeybox.Text = a$
    KeyAscii = 0
End Sub

'=========================================================================
' Close menu
'=========================================================================
Private Sub mnuClose_Click()
    Call Unload(Me)
End Sub

'=========================================================================
' Change menu plugin
'=========================================================================
Private Sub mnuplugin_Change()
    On Error Resume Next
    mainMem.menuPlugin = mnuplugin.Text
End Sub

'=========================================================================
' Clear all data
'=========================================================================
Private Sub newmain()
    Call clearAll
End Sub

'=========================================================================
' New menu
'=========================================================================
Private Sub newmainmnu_Click()
    On Error Resume Next
    Dim user As VbMsgBoxResult
    user = MsgBox(LoadStringLoc(947, "Remove current data and start a new file.  Are you sure?"), 4)
    If user = 6 Then
        mainFile$ = ""
        Call newmain
        Call infoFill
    End If
End Sub

'=========================================================================
' Save menu
'=========================================================================
Private Sub mnusave_Click()
    Call saveFile
End Sub

'=========================================================================
' Save as menu
'=========================================================================
Private Sub mnusaveas_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gamPath$
    dlg.strTitle = "Save Main File As"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "RPG Toolkit Main File (*.gam)|*.gam|All files(*.*)|*.*"
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    Call saveMain(filename$(1), mainMem)
    mainFile$ = antiPath$
    editmainfile.Caption = LoadStringLoc(800, "Project Properties") + " (" + antiPath$ + ")"
    mainNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub

'=========================================================================
' Disable fighting
'=========================================================================
Private Sub optEnableFighting_Click(): On Error Resume Next
    mainNeedUpdate = True
    mainMem.fightgameYN = 0
    cmdEditFighting.Enabled = True
End Sub

'=========================================================================
' Enable fighting
'=========================================================================
Private Sub optDisableFighting_Click(): On Error Resume Next
    mainNeedUpdate = True
    mainMem.fightgameYN = 1
    cmdEditFighting.Enabled = False
End Sub

'=========================================================================
' Change to pixel movement
'=========================================================================
Private Sub optPixelBased_Click()
    If chkUsePixelPush.value = 0 Then
        mainMem.pixelMovement = PIXEL_MOVEMENT_TILE_PUSH
    Else
        mainMem.pixelMovement = PIXEL_MOVEMENT_PIXEL_PUSH
    End If
    chkUsePixelPush.Enabled = True
End Sub

'=========================================================================
' Change to custom resolution
'=========================================================================
Private Sub optResCustom_Click()
    mainMem.mainResolution = 4
End Sub

'=========================================================================
' Change to tile movement
'=========================================================================
Private Sub optTileBased_Click()
    mainMem.pixelMovement = TILE_MOVEMENT
    chkUsePixelPush.Enabled = False
    chkUsePixelPush.value = 0
End Sub

'=========================================================================
' Enable / disable registration protection
'=========================================================================
Private Sub regprotect_Click()
    If regprotect.value = 0 Then
        mainMem.mainDisableProtectReg = 1
    Else
        mainMem.mainDisableProtectReg = 0
    End If
End Sub

'=========================================================================
' Press a key in the key box
'=========================================================================
Private Sub runkeybox_KeyPress(ByRef KeyAscii As Integer)
    mainNeedUpdate = True
    Dim ascii As Long
    ascii = KeyAscii
    If mainMem.menuKey = ascii Or mainMem.Key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.runKey = ascii
    Dim a As String
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    runkeybox.Text = a$
    KeyAscii = 0
End Sub

'=========================================================================
' Change run-time program
'=========================================================================
Private Sub runtimebox_Change()
    On Error Resume Next
    mainMem.runTime$ = runtimebox.Text
End Sub

'=========================================================================
' Set resolution to 640 x 480
'=========================================================================
Private Sub sixfourty_Click()
    On Error Resume Next
    mainMem.mainResolution = 0
End Sub

'=========================================================================
' Change initial game speed
'=========================================================================
Private Sub sliGameSpeed_Change()

    Call setGameSpeed(mainMem.gameSpeed, sliGameSpeed.value)
End Sub

Private Sub sliGameSpeed_Scroll()
    If sliGameSpeed.value > 0 Then
        sliGameSpeed.Text = "Increase (" & CStr(sliGameSpeed.value) & ")"
    ElseIf sliGameSpeed.value < 0 Then
        sliGameSpeed.Text = "Decrease (" & CStr(sliGameSpeed.value) & ")"
    Else
        sliGameSpeed.Text = "Unaltered (0)"
    End If
End Sub

'=========================================================================
' Set game to windowed mode
'=========================================================================
Private Sub smallWindowed_Click()
    On Error Resume Next
    mainNeedUpdate = True
    mainMem.mainScreenType = 2
End Sub


'=========================================================================
' Change startup program
'=========================================================================
Private Sub startupbox_Change()
    On Error Resume Next
    mainMem.startupPrg$ = startupbox.Text
End Sub

'=========================================================================
' Set resolution to 1024 x 768
'=========================================================================
Private Sub tentwentyfour_Click()
    On Error Resume Next
    mainMem.mainResolution = 2
End Sub

'=========================================================================
' Change game over program
'=========================================================================
Private Sub txtGameOver_Change()
    On Error Resume Next
    mainMem.gameOverPrg$ = txtGameOver.Text
End Sub

'=========================================================================
' Windowed mode
'=========================================================================
Private Sub windowed_Click()
    On Error Resume Next
    mainNeedUpdate = True
    mainMem.mainScreenType = 0
End Sub

'=========================================================================
' Common menus
'=========================================================================
Private Sub mnutilehorizontally_Click()
    On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub
Private Sub mnutilevertically_Click()
    On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub
Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub
Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub
Private Sub mnuAbout_Click()
    On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub
Private Sub mnuArrangeIcons_Click()
    On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub
Private Sub mnuCascade_Click()
    On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub
Private Sub mnucreatepakfile_Click()
    On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub
Private Sub mnucreatesetup_Click()
    On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub
Private Sub mnuexit_Click()
    On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub
Private Sub mnuHistorytxt_Click()
    On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub
Private Sub mnuinstallupgrade_Click()
    On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub
Private Sub mnumakeexe_Click()
    On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub
Private Sub mnunewanimatedtile_Click()
    On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub
Private Sub mnunewanimation_Click()
    On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub
Private Sub mnunewboard_Click()
    On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub
Private Sub mnunewenemy_Click()
    On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub
Private Sub mnunewitem_Click()
    On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub
Private Sub mnunewplayer_Click()
    On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub
Private Sub mnunewproject_Click()
    On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub
Private Sub mnunewrpgcodeprogram_Click()
    On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub
Private Sub mnunewspecialmove_Click()
    On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub
Private Sub mnunewstatuseffect_Click()
    On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub
Private Sub mnunewtile_Click()
    On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub
Private Sub mnunewtilebitmap_Click()
    On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub
Private Sub mnuopen_Click()
    On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub
Private Sub mnuRegistrationInfo_Click()
    On Error Resume Next
    Call tkMainForm.registrationinfomnu_Click
End Sub
Private Sub mnuRPGCodePrimer_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub
Private Sub mnurpgcodereference_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub
Private Sub mnusaveall_Click()
    On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub
Private Sub mnuselectlanguage_Click()
    On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub
Private Sub mnushowprojectlist_Click()
    On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub
Private Sub mnushowtools_Click()
    On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub
Private Sub mnutestgame_Click()
    On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub
Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub
Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub

'=========================================================================
' Custom resolution stuff
'=========================================================================
Private Sub txtResX_KeyDown(ByRef keyCode As Integer, ByRef Shift As Integer)
    optResCustom.value = True
    mainMem.mainResolution = 4
End Sub
Private Sub txtResX_KeyPress(ByRef KeyAscii As Integer)
    On Error GoTo letter
    Dim ret As Double
    ret = CDbl(txtResX.Text & chr$(KeyAscii))
    Exit Sub
letter:
    If (KeyAscii <> 8) Then
        'Bad key
        KeyAscii = 0
    End If
End Sub
Private Sub txtResX_Change()
    mainMem.resX = val(txtResX.Text) ' val *must* be used - CDbl is no good here
End Sub
Private Sub txtResY_KeyPress(ByRef KeyAscii As Integer)
    On Error GoTo letter
    Dim ret As Double
    ret = CDbl(txtResY.Text & chr$(KeyAscii))
    Exit Sub
letter:
    If (KeyAscii <> 8) Then
        'Bad key
        KeyAscii = 0
    End If
End Sub
Private Sub txtResY_Change()
    mainMem.resY = val(txtResY.Text) ' val *must* be used - CDbl is no good here
End Sub
Private Sub txtResY_KeyDown(ByRef keyCode As Integer, ByRef Shift As Integer)
    optResCustom.value = True
    mainMem.mainResolution = 4
End Sub
