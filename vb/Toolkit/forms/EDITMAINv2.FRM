VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
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
      Left            =   2760
      TabIndex        =   1
      Top             =   5400
      Visible         =   0   'False
      Width           =   3135
   End
   Begin TabDlg.SSTab tabMain 
      Height          =   5640
      Left            =   120
      TabIndex        =   2
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
      Tab(1).Control(0)=   "startframe"
      Tab(1).ControlCount=   1
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
         TabIndex        =   79
         Tag             =   "1186"
         Top             =   600
         Width           =   6615
         Begin VB.CommandButton Command1 
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
            TabIndex        =   82
            Tag             =   "1187"
            Top             =   600
            Width           =   1095
         End
         Begin VB.OptionButton Option4 
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
            TabIndex        =   81
            Tag             =   "1099"
            Top             =   600
            Width           =   735
         End
         Begin VB.OptionButton Option3 
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
            TabIndex        =   80
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
            TabIndex        =   84
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
            MouseIcon       =   "EDITMAINv2.frx":0D8E
            MousePointer    =   99  'Custom
            TabIndex        =   83
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
         TabIndex        =   69
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
            TabIndex        =   76
            Top             =   480
            Width           =   4815
         End
         Begin VB.CommandButton Command4 
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
            TabIndex        =   75
            Top             =   2160
            Width           =   1095
         End
         Begin VB.CommandButton Command5 
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
            TabIndex        =   74
            Top             =   1680
            Width           =   1095
         End
         Begin VB.CommandButton Command6 
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
            TabIndex        =   73
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
            TabIndex        =   72
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
            TabIndex        =   71
            Text            =   "None"
            Top             =   3360
            Width           =   2655
         End
         Begin VB.CommandButton Command10 
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
            TabIndex        =   70
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
            TabIndex        =   78
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
            TabIndex        =   77
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
         TabIndex        =   60
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
            TabIndex        =   64
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
            TabIndex        =   63
            Text            =   "None"
            Top             =   360
            Width           =   3135
         End
         Begin VB.CommandButton Command14 
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
            TabIndex        =   62
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.CommandButton Command15 
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
            TabIndex        =   61
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
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
            TabIndex        =   68
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
            TabIndex        =   67
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
            Height          =   495
            Left            =   240
            MouseIcon       =   "EDITMAINv2.frx":1098
            MousePointer    =   99  'Custom
            TabIndex        =   66
            Tag             =   "1158"
            Top             =   1080
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
            Height          =   495
            Left            =   3000
            MouseIcon       =   "EDITMAINv2.frx":13A2
            MousePointer    =   99  'Custom
            TabIndex        =   65
            Tag             =   "1157"
            Top             =   1080
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
         TabIndex        =   52
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
            TabIndex        =   56
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
            TabIndex        =   55
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
            TabIndex        =   54
            Text            =   "None"
            Top             =   360
            Width           =   615
         End
         Begin VB.CommandButton Command3 
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
            TabIndex        =   53
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
            TabIndex        =   59
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
            TabIndex        =   58
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
            TabIndex        =   57
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
         TabIndex        =   40
         Tag             =   "1144"
         Top             =   600
         Width           =   6615
         Begin VB.CommandButton Command2 
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
            TabIndex        =   47
            Tag             =   "1145"
            Top             =   1200
            Visible         =   0   'False
            Width           =   1095
         End
         Begin VB.TextBox Text1 
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
            TabIndex        =   46
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
            TabIndex        =   45
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
            TabIndex        =   44
            Text            =   "None"
            Top             =   600
            Width           =   2655
         End
         Begin VB.CommandButton Command16 
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
            TabIndex        =   43
            Tag             =   "1021"
            Top             =   240
            Width           =   1095
         End
         Begin VB.CommandButton Command17 
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
            TabIndex        =   42
            Tag             =   "1021"
            Top             =   600
            Width           =   1095
         End
         Begin VB.CommandButton Command18 
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
            TabIndex        =   41
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
            TabIndex        =   51
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
            TabIndex        =   50
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
            TabIndex        =   49
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
            MouseIcon       =   "EDITMAINv2.frx":16AC
            MousePointer    =   99  'Custom
            TabIndex        =   48
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
         TabIndex        =   34
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
            TabIndex        =   37
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
            TabIndex        =   36
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
            TabIndex        =   35
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
            TabIndex        =   38
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
         TabIndex        =   33
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
         Height          =   2055
         Left            =   -74760
         TabIndex        =   20
         Tag             =   "1136"
         Top             =   600
         Width           =   6615
         Begin VB.OptionButton windowed 
            Caption         =   "Classic Resolution (Slower)"
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
            Left            =   2760
            TabIndex        =   32
            Tag             =   "1143"
            Top             =   240
            Visible         =   0   'False
            Width           =   3015
         End
         Begin VB.CheckBox stretchbox 
            Caption         =   "Run Full-Screen"
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
            TabIndex        =   31
            Tag             =   "1142"
            Top             =   360
            Width           =   2775
         End
         Begin VB.OptionButton fullscreen 
            Caption         =   "DirectX"
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
            Left            =   2760
            TabIndex        =   30
            Top             =   480
            Visible         =   0   'False
            Width           =   2415
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
            Height          =   1095
            Left            =   4320
            TabIndex        =   26
            Top             =   720
            Width           =   2175
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
               TabIndex        =   29
               Tag             =   "1140"
               Top             =   240
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
               TabIndex        =   28
               Tag             =   "1139"
               Top             =   480
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
               TabIndex        =   27
               Tag             =   "1138"
               Top             =   720
               Width           =   1335
            End
         End
         Begin VB.OptionButton smallwindowed 
            Caption         =   "Windows GDI"
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
            Left            =   2760
            TabIndex        =   25
            Top             =   720
            Visible         =   0   'False
            Width           =   2655
         End
         Begin VB.Frame Frame4 
            Caption         =   "Target Color Depth"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1095
            Left            =   120
            TabIndex        =   21
            Top             =   720
            Width           =   2175
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
               Left            =   240
               TabIndex        =   24
               Top             =   240
               Width           =   1575
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
               Left            =   240
               TabIndex        =   23
               Top             =   480
               Width           =   1575
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
               Left            =   240
               TabIndex        =   22
               Top             =   720
               Width           =   1575
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
         TabIndex        =   13
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
            TabIndex        =   16
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
            TabIndex        =   15
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
            TabIndex        =   14
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
            TabIndex        =   19
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
            TabIndex        =   18
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
            TabIndex        =   17
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
         TabIndex        =   3
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
            TabIndex        =   9
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
            TabIndex        =   8
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
            TabIndex        =   7
            Top             =   840
            Width           =   2655
         End
         Begin VB.CommandButton Command7 
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
            TabIndex        =   6
            Tag             =   "1021"
            Top             =   480
            Width           =   1095
         End
         Begin VB.CommandButton Command8 
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
            Top             =   840
            Width           =   1095
         End
         Begin VB.CommandButton Command9 
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
            TabIndex        =   12
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
            TabIndex        =   11
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
            TabIndex        =   10
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
         MouseIcon       =   "EDITMAINv2.frx":19B6
         MousePointer    =   99  'Custom
         TabIndex        =   39
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
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What needs to be done
' + Standardize
'
'=======================================================

Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_MAINFILE
End Function

Public Sub checkSave()
    'check if the file has changed an it needs to be saved...
    On Error GoTo ErrorHandler
    If mainNeedUpdate = True Then
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Sub plugininfofill()
    'fills in plugin info
    On Error GoTo ErrorHandler
    Call plugList.Clear
    For t = 0 To UBound(mainMem.plugins)
        If mainMem.plugins(t) <> "" Then
            descr$ = pluginDescription(projectPath$ + plugpath$ + mainMem.plugins(t))
            Call plugList.AddItem(mainMem.plugins(t) + "    " + descr$)
        End If
    Next t
    Call PLUGShutdownSystem

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub saveFile()
    'saves the file.
    On Error GoTo ErrorHandler
    'If mainNeedUpdate = True Then
        filename$(2) = mainfile$
        mainNeedUpdate = False
        If filename$(2) = "" Then
            editmainfile.Show
            Call mnusaveas_Click
            Exit Sub
        End If
        Call saveMain(gampath$ + filename$(2), mainMem)
    'End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Public Sub clearAll()
'erases main file data
    On Error GoTo ErrorHandler
    Call MainClear(mainMem)
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub closemnu_Click()
    On Error GoTo ErrorHandler
    Unload mainfight
    Unload editmainfile

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub color16bit_Click()
    On Error Resume Next
    mainMem.colorDepth = COLOR16
End Sub

Private Sub color24bit_Click()
    On Error Resume Next
    mainMem.colorDepth = COLOR24
End Sub


Private Sub color32bit_Click()
    On Error Resume Next
    mainMem.colorDepth = COLOR32
End Sub


Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainfight.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command13_Click()
    On Error GoTo ErrorHandler
    pluginframe.Visible = False
    rpgcodeframe.Visible = False
    fgtframe.Visible = False
    projectframe.Visible = False
    startupframe.Visible = False
    graphicsframe.Visible = False
    daynightframe.Top = 600
    daynightframe.Left = 2160
    daynightframe.Visible = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command10_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + pluginPath$
    
    dlg.strTitle = "Select Plugin"
    dlg.strDefaultExt = "dll"
    dlg.strFileTypes = "RPG Toolkit Plugin (*.dll)|*.dll|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + pluginPath$ + antiPath$
    fgtPlugin.Text = antiPath$
    mainMem.fightPlugin = antiPath$
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdpath$
    
    dlg.strTitle = "Select Board"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    initboardbox.Text = antiPath$
    mainMem.initBoard$ = antiPath$
End Sub

Private Sub Command15_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tempath$
    
    dlg.strTitle = "Select Character"
    dlg.strDefaultExt = "tem"
    dlg.strFileTypes = "Supported Files|*.tem|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tempath$ + antiPath$
    initcharbox.Text = antiPath$
    mainMem.initChar$ = antiPath$
End Sub

Private Sub Command16_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    runtimebox.Text = antiPath$
    mainMem.runTime$ = antiPath$
End Sub

Private Sub Command17_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    startupbox.Text = antiPath$
    mainMem.startupPrg$ = antiPath$
End Sub

Private Sub Command18_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgpath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    whichType$ = extention(filename$(1))
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    Text1.Text = antiPath$
    mainMem.gameOverPrg$ = antiPath$
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    skinedit.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
    runtimeprograms.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error Resume Next
    
    If plugList.ListIndex = -1 Then plugList.ListIndex = 0
    
    Call MainRemovePlugin(mainMem, MainGetNthPlugin(mainMem, plugList.ListIndex))
    
    Dim idx As Long
    
    idx = plugList.ListIndex - 1
    If idx = -1 Then idx = 0
    
    Call plugininfofill
    
    plugList.ListIndex = idx
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + pluginPath$
    
    dlg.strTitle = "Select Plugin"
    dlg.strDefaultExt = "dll"
    dlg.strFileTypes = "RPG Toolkit Plugins (*.dll)|*.dll|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + plugpath$ + antiPath$
       
    Call MainAddPlugin(mainMem, antiPath$)
    
    descr$ = pluginDescription(projectPath$ + plugpath$ + antiPath$)
    plugList.AddItem (antiPath$ + "    " + descr$)
    Call PLUGShutdownSystem
    
End Sub


Private Sub Command6_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + pluginPath$
    
    dlg.strTitle = "Select Plugin"
    dlg.strDefaultExt = "dll"
    dlg.strFileTypes = "RPG Toolkit Plugin (*.dll)|*.dll|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + pluginPath$ + antiPath$
    mnuplugin.Text = antiPath$
    mainMem.menuPlugin = antiPath$
End Sub


Private Sub Command7_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediapath$
    
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursormove.Text = antiPath$
    mainMem.cursorMoveSound = antiPath$
End Sub


Private Sub Command8_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediapath$
    
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursorselect.Text = antiPath$
    mainMem.cursorSelectSound = antiPath$
End Sub

Private Sub Command9_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediapath$
    
    dlg.strTitle = "Select Sound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = dlg.strFileTypes = "Supported Types|*.wav;*.mp3|Wav Digital (*.wav)|*.wav|MP3 Compressed (*.mp3)|*.mp3|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    mainNeedUpdate = True
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursorcancel.Text = antiPath$
    mainMem.cursorCancelSound = antiPath$
End Sub

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


Private Sub daylengthbox_Change()
    On Error GoTo ErrorHandler
    
    mainMem.mainDayLength = val(daylengthbox.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub daynightcheckbox_Click()
    On Error GoTo ErrorHandler
    
    mainMem.mainUseDayNight = daynightcheckbox.value
    If mainMem.mainUseDayNight = 1 Then
        Frame3.Visible = True
    Else
        Frame3.Visible = False
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub daynightreal_Click()
    mainMem.mainDayNightType = 0
    daylengthbox.Enabled = False
End Sub


Private Sub daynightvirtual_Click()
    mainMem.mainDayNightType = 1
    daylengthbox.Enabled = True
End Sub


Private Sub eighthundred_Click()
    On Error GoTo ErrorHandler
    mainMem.mainResolution = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub enableJoystick_Click()
    On Error Resume Next
    mainMem.useJoystick = enableJoystick.value
End Sub

Private Sub fgtPlugin_Change()
    On Error Resume Next
    mainMem.fightPlugin = fgtPlugin.Text
End Sub

Private Sub Form_Activate()
    Set activeForm = Me
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    'Call LocalizeTabStrip(TabStrip1)
    
    editmainfile.height = 6270
    editmainfile.Width = 7600
    filename$(2) = ""
    Call infofill
    projectframe.Visible = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub fullscreen_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub gametitlebox_Change()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox.Text
    gametitlebox2.Text = mainMem.gameTitle$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub horizontalupdate_Click()
    On Error GoTo ErrorHandler
    updatetype = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo ErrorHandler
    Option3.value = True
    Option1.value = True
    Option5.value = True
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
        Text1.Text = mainMem.gameOverPrg$             'run time program
    Else
        Text1.Text = LoadStringLoc(1010, "None")
    End If
    mnuplugin.Text = mainMem.menuPlugin
    fgtPlugin.Text = mainMem.fightPlugin
    
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

    Option4.value = mainMem.fightgameYN             'fighting in game? 0-yes, 1-no

    'If updatetype = 0 Then noupdate.Value = True
    'If updatetype = 1 Then horizontalupdate.Value = True
    'If updatetype = 2 Then tileupdate.Value = True

    If mainMem.mainScreenType = 0 Then fullscreen.value = True
    If mainMem.mainScreenType = 1 Then fullscreen.value = True
    If mainMem.mainScreenType = 2 Then smallwindowed.value = True
    
    gametitlebox.Text = mainMem.gameTitle$
    gametitlebox2.Text = mainMem.gameTitle$
    editmainfile.Caption = LoadStringLoc(800, "Main Project Editor") + "  (" + mainfile$ + ")"
    
    pathbox.Caption = projectPath$
    
    Call testGraphicsMode
    If targetPlatform = 0 Or targetPlatform = 2 Then
        win9x.value = True
    End If
    'If targetPlatform = 2 Then
    '    win3.Value = True
    'End If
    If targetPlatform = 1 Then
        winNT.value = True
    End If
    stretchbox.value = mainMem.extendToFullScreen
    
    If mainMem.mainResolution = 0 Then
        sixfourty.value = True
    End If
    If mainMem.mainResolution = 1 Then
        eighthundred.value = True
    End If
    If mainMem.mainResolution = 2 Then
        tentwentyfour.value = True
    End If
    
    Call plugininfofill

    daynightcheckbox.value = mainMem.mainUseDayNight
    If mainMem.mainUseDayNight = 1 Then
        Frame3.Visible = True
    Else
        Frame3.Visible = False
    End If
    If mainMem.mainDayNightType = 0 Then
        daynightreal.value = True
        daylengthbox.Enabled = False
    Else
        daynightvirtual.value = True
        daylengthbox.Enabled = True
    End If
    daylengthbox.Text = str$(mainMem.mainDayLength)

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

    Select Case mainMem.colorDepth
        Case COLOR16:
            color16bit.value = True
                    
        Case COLOR24:
            color24bit.value = True
        
        Case COLOR32:
            color32bit.value = True
    End Select

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub gametitlebox2_Change()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox2.Text
    gametitlebox.Text = mainMem.gameTitle$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub initboardbox_Change()
    On Error Resume Next
    mainMem.initBoard$ = initboardbox.Text
End Sub

Private Sub initcharbox_Change()
    On Error Resume Next
    mainMem.initChar$ = initcharbox.Text
End Sub

Private Sub keybox_KeyPress(KeyAscii As Integer)
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    ascii = KeyAscii
    If mainMem.menuKey = ascii Or mainMem.runKey = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.Key = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    keybox.Text = a$
    KeyAscii = 0


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label2_Click()
    On Error GoTo ErrorHandler
    activeEnemy.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label21_Click()
    On Error GoTo ErrorHandler
    activePlayer.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label22_Click()
    On Error GoTo ErrorHandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Label24_Click()
    On Error GoTo ErrorHandler
    activeBoard.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label9_Click()
    On Error GoTo ErrorHandler
    activeBoard.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub menukeybox_KeyPress(KeyAscii As Integer)
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    ascii = KeyAscii
    If mainMem.runKey = ascii Or mainMem.Key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.menuKey = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    menukeybox.Text = a$
    KeyAscii = 0


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuCLose_Click()
    Unload Me
End Sub

Private Sub mnuplugin_Change()
    On Error Resume Next
    mainMem.menuPlugin = mnuplugin.Text
End Sub

Private Sub newmain()
    On Error GoTo ErrorHandler
    Call clearAll

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub newmainmnu_Click()
    On Error GoTo ErrorHandler
    user = MsgBox(LoadStringLoc(947, "Remove current data and start a new file.  Are you sure?"), 4)
    If user = 6 Then
        mainfile$ = ""
        Call newmain
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub noupdate_Click()
    On Error GoTo ErrorHandler
    updatetype = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub openmnu_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gampath$
    
    dlg.strTitle = "Open Main File"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "RPG Toolkit Main File (*.gam)|*.gam|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), gampath$ + antiPath$
    Call openMainFile(filename$(1))
    mainfile$ = antiPath$
    editmainfile.Caption = LoadStringLoc(800, "Project Properties") + "  (" + antiPath$ + ")"
    Call infofill
    lastProject$ = antiPath$
    mainoption.Caption = "RPG Toolkit Development System, Version 3.0 (" + antiPath$ + ")"
End Sub



Private Sub mnusave_Click()
    Call saveFile
End Sub

Private Sub mnusaveas_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = gampath$
    
    dlg.strTitle = "Save Main File As"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "RPG Toolkit Main File (*.gam)|*.gam|All files(*.*)|*.*"
    'dlg2
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    aa = fileExist(filename$(1))
    If aa = 1 Then
        bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo, LoadStringLoc(950, "Save"))
        If bb = 7 Then Exit Sub
    End If
    
    Call saveMain(filename$(1), mainMem)
    mainfile$ = antiPath$
    editmainfile.Caption = LoadStringLoc(800, "Project Properties") + " (" + antiPath$ + ")"
    mainNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub


Private Sub Option3_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.fightgameYN = 0
    Command1.Enabled = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option4_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.fightgameYN = 1
    Command1.Enabled = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub






Private Sub regprotect_Click()
    If regprotect.value = 0 Then
        mainMem.mainDisableProtectReg = 1
    Else
        mainMem.mainDisableProtectReg = 0
    End If
End Sub

Private Sub runkeybox_KeyPress(KeyAscii As Integer)
    mainNeedUpdate = True
    ascii = KeyAscii
    If mainMem.menuKey = ascii Or mainMem.Key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.runKey = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    runkeybox.Text = a$
    KeyAscii = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub runtimebox_Change()
    On Error Resume Next
    mainMem.runTime$ = runtimebox.Text
End Sub


Private Sub savemnu_Click()
    On Error GoTo ErrorHandler
    filename$(2) = mainfile$
    If filename$(2) = "" Then mnusaveas_Click: Exit Sub
    Call saveMain(gampath$ + filename$(2), mainMem)
    mainNeedUpdate = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub sixfourty_Click()
    On Error GoTo ErrorHandler
    mainMem.mainResolution = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smallwindowed_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub startupbox_Change()
    On Error Resume Next
    mainMem.startupPrg$ = startupbox.Text
End Sub

Private Sub tileupdate_Click()
    On Error GoTo ErrorHandler
    updatetype = 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub stretchbox_Click()
    On Error GoTo ErrorHandler
    mainMem.extendToFullScreen = stretchbox.value

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub TabStrip1_Click()
    On Error Resume Next
    pluginframe.Visible = False
    rpgcodeframe.Visible = False
    fgtframe.Visible = False
    graphicsframe.Visible = False
    startupframe.Visible = False
    daynightframe.Visible = False
    projectframe.Visible = False
'FIXIT: p1.SelectedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
'FIXIT: electedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
    Select Case TabStrip1.SelectedItem.Index
        Case 1:
            projectframe.Visible = True
        Case 2:
            startupframe.Visible = True
        Case 3:
            rpgcodeframe.Visible = True
        Case 4:
            fgtframe.Visible = True
        'Case 5:
        '    daynightframe.Visible = True
        Case 5:
            graphicsframe.Visible = True
        Case 6:
            pluginframe.Visible = True
    End Select
End Sub

Private Sub tentwentyfour_Click()
    On Error GoTo ErrorHandler
    mainMem.mainResolution = 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_Change()
    On Error Resume Next
    mainMem.gameOverPrg$ = Text1.Text
'    End If

End Sub

Private Sub toc_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helppath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub win3_Click()
    On Error GoTo ErrorHandler
    usefastdrawYN = True
    targetPlatform = 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub windowed_Click()
    On Error GoTo ErrorHandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


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

