VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form editmainfile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Project Properties (Untitled)"
   ClientHeight    =   5220
   ClientLeft      =   90
   ClientTop       =   480
   ClientWidth     =   7755
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
   Icon            =   "EDITMAIN.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5220
   ScaleWidth      =   7755
   Tag             =   "1128"
   Begin VB.Frame projectframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   14
      Top             =   600
      Visible         =   0   'False
      Width           =   6855
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
         TabIndex        =   20
         Top             =   2160
         Width           =   6495
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
            TabIndex        =   84
            Tag             =   "1021"
            Top             =   1200
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
            TabIndex        =   83
            Tag             =   "1021"
            Top             =   840
            Width           =   1095
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
            TabIndex        =   82
            Tag             =   "1021"
            Top             =   480
            Width           =   1095
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
            TabIndex        =   81
            Top             =   840
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
            TabIndex        =   80
            Top             =   1200
            Width           =   2655
         End
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
            TabIndex        =   79
            Top             =   480
            Width           =   2655
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
            TabIndex        =   78
            Top             =   1200
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
            TabIndex        =   77
            Top             =   840
            Width           =   2175
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
            TabIndex        =   76
            Top             =   480
            Width           =   2175
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
         TabIndex        =   15
         Tag             =   "1182"
         Top             =   360
         Width           =   6495
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
            TabIndex        =   88
            Top             =   960
            Width           =   3735
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
            TabIndex        =   68
            Tag             =   "1183"
            Top             =   1320
            Width           =   3735
         End
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
            TabIndex        =   19
            Tag             =   "1184"
            Top             =   240
            Width           =   1575
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
            TabIndex        =   17
            Top             =   600
            Width           =   2895
         End
      End
   End
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
      Left            =   3720
      TabIndex        =   1
      Top             =   5040
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Frame graphicsframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   8
      Top             =   600
      Visible         =   0   'False
      Width           =   6855
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
         Left            =   120
         TabIndex        =   9
         Tag             =   "1136"
         Top             =   240
         Width           =   6615
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
            TabIndex        =   89
            Top             =   720
            Width           =   2175
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
               TabIndex        =   92
               Top             =   720
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
               TabIndex        =   91
               Top             =   480
               Width           =   1575
            End
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
               TabIndex        =   90
               Top             =   240
               Width           =   1575
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
            TabIndex        =   11
            Top             =   720
            Visible         =   0   'False
            Width           =   2655
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
            TabIndex        =   50
            Top             =   720
            Width           =   2175
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
               TabIndex        =   53
               Tag             =   "1138"
               Top             =   720
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
               TabIndex        =   52
               Tag             =   "1139"
               Top             =   480
               Width           =   1335
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
               TabIndex        =   51
               Tag             =   "1140"
               Top             =   240
               Width           =   1335
            End
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
            TabIndex        =   12
            Top             =   480
            Visible         =   0   'False
            Width           =   2415
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
            TabIndex        =   10
            Tag             =   "1142"
            Top             =   360
            Width           =   2775
         End
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
            TabIndex        =   13
            Tag             =   "1143"
            Top             =   240
            Visible         =   0   'False
            Width           =   3015
         End
      End
   End
   Begin VB.Frame daynightframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   54
      Top             =   600
      Width           =   6855
      Begin VB.Frame Frame2 
         Caption         =   "Day and Night Options"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2895
         Left            =   120
         TabIndex        =   55
         Tag             =   "1161"
         Top             =   240
         Width           =   6615
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
            Left            =   240
            TabIndex        =   58
            Tag             =   "1162"
            Top             =   720
            Width           =   6255
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
               TabIndex        =   61
               Text            =   "10"
               Top             =   1080
               Width           =   735
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
               TabIndex        =   60
               Tag             =   "1163"
               Top             =   720
               Width           =   4575
            End
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
               TabIndex        =   59
               Tag             =   "1164"
               Top             =   360
               Value           =   -1  'True
               Width           =   4455
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
               TabIndex        =   62
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
            Left            =   240
            TabIndex        =   57
            Tag             =   "1166"
            Top             =   360
            Width           =   4455
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
            Left            =   240
            MouseIcon       =   "EDITMAIN.frx":0CCA
            MousePointer    =   99  'Custom
            TabIndex        =   56
            Tag             =   "1158"
            Top             =   2400
            Visible         =   0   'False
            Width           =   3495
         End
      End
   End
   Begin VB.Frame rpgcodeframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   27
      Top             =   600
      Width           =   6855
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
         Left            =   120
         TabIndex        =   36
         Tag             =   "1144"
         Top             =   240
         Width           =   6615
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
            TabIndex        =   67
            Tag             =   "1021"
            Top             =   960
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
            TabIndex        =   66
            Tag             =   "1021"
            Top             =   600
            Width           =   1095
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
            TabIndex        =   65
            Tag             =   "1021"
            Top             =   240
            Width           =   1095
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
            TabIndex        =   40
            Text            =   "None"
            Top             =   600
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
            TabIndex        =   39
            Text            =   "None"
            Top             =   240
            Width           =   2655
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
            TabIndex        =   38
            Text            =   "None"
            Top             =   960
            Width           =   2655
         End
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
            TabIndex        =   37
            Tag             =   "1145"
            Top             =   1200
            Visible         =   0   'False
            Width           =   1095
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
            MouseIcon       =   "EDITMAIN.frx":0FD4
            MousePointer    =   99  'Custom
            TabIndex        =   47
            Tag             =   "1150"
            Top             =   1680
            Visible         =   0   'False
            Width           =   3135
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
            TabIndex        =   43
            Tag             =   "1146"
            Top             =   240
            Width           =   2175
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
            TabIndex        =   42
            Tag             =   "1148"
            Top             =   600
            Width           =   2295
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
            TabIndex        =   41
            Tag             =   "1149"
            Top             =   960
            Width           =   2295
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
         Left            =   120
         TabIndex        =   28
         Tag             =   "1151"
         Top             =   2400
         Width           =   6615
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
            TabIndex        =   32
            Tag             =   "1152"
            Top             =   360
            Width           =   1095
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
            TabIndex        =   31
            Text            =   "None"
            Top             =   360
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
            TabIndex        =   30
            Text            =   "None"
            Top             =   600
            Width           =   615
         End
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
            TabIndex        =   29
            Text            =   "None"
            Top             =   840
            Width           =   615
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
            TabIndex        =   35
            Tag             =   "1153"
            Top             =   360
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
            TabIndex        =   34
            Tag             =   "1154"
            Top             =   600
            Width           =   3495
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
            TabIndex        =   33
            Tag             =   "1155"
            Top             =   840
            Width           =   3495
         End
      End
   End
   Begin VB.Frame startupframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   2
      Top             =   600
      Visible         =   0   'False
      Width           =   6855
      Begin VB.Frame startframe 
         Caption         =   "Startup Conditions:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   120
         TabIndex        =   3
         Tag             =   "1156"
         Top             =   240
         Width           =   6615
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
            TabIndex        =   64
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
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
            TabIndex        =   63
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
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
            TabIndex        =   5
            Text            =   "None"
            Top             =   360
            Width           =   3135
         End
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
            TabIndex        =   4
            Text            =   "None"
            Top             =   720
            Width           =   3135
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
            MouseIcon       =   "EDITMAIN.frx":12DE
            MousePointer    =   99  'Custom
            TabIndex        =   46
            Tag             =   "1157"
            Top             =   1080
            Visible         =   0   'False
            Width           =   2415
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
            MouseIcon       =   "EDITMAIN.frx":15E8
            MousePointer    =   99  'Custom
            TabIndex        =   45
            Tag             =   "1158"
            Top             =   1080
            Visible         =   0   'False
            Width           =   2175
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
            TabIndex        =   7
            Tag             =   "1159"
            Top             =   360
            Width           =   2055
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
            TabIndex        =   6
            Tag             =   "1160"
            Top             =   720
            Width           =   1695
         End
      End
   End
   Begin VB.Frame pluginframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   48
      Top             =   600
      Visible         =   0   'False
      Width           =   6855
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
         Left            =   120
         TabIndex        =   49
         Tag             =   "1167"
         Top             =   240
         Width           =   6615
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
            TabIndex        =   86
            Tag             =   "1021"
            Top             =   3360
            Width           =   1095
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
            TabIndex        =   85
            Text            =   "None"
            Top             =   3360
            Width           =   2655
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
            TabIndex        =   74
            Text            =   "None"
            Top             =   2880
            Width           =   2655
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
            TabIndex        =   72
            Top             =   1680
            Width           =   1095
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
            TabIndex        =   71
            Top             =   2160
            Width           =   1095
         End
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
            TabIndex        =   70
            Top             =   480
            Width           =   4815
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
            TabIndex        =   87
            Top             =   3360
            Width           =   2055
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
            TabIndex        =   75
            Top             =   2880
            Width           =   2055
         End
      End
   End
   Begin VB.Frame fgtframe 
      Height          =   4215
      Left            =   480
      TabIndex        =   21
      Top             =   600
      Visible         =   0   'False
      Width           =   6855
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
         Left            =   120
         TabIndex        =   22
         Tag             =   "1186"
         Top             =   240
         Width           =   6615
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
            TabIndex        =   25
            Tag             =   "1100"
            Top             =   360
            Value           =   -1  'True
            Width           =   735
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
            TabIndex        =   24
            Tag             =   "1099"
            Top             =   600
            Width           =   735
         End
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
            TabIndex        =   23
            Tag             =   "1187"
            Top             =   600
            Width           =   1095
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
            MouseIcon       =   "EDITMAIN.frx":18F2
            MousePointer    =   99  'Custom
            TabIndex        =   44
            Tag             =   "1188"
            Top             =   960
            Visible         =   0   'False
            Width           =   2775
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
            TabIndex        =   26
            Tag             =   "1189"
            Top             =   360
            Width           =   1575
         End
      End
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   4935
      Left            =   240
      TabIndex        =   69
      Top             =   120
      Width           =   7335
      _ExtentX        =   12938
      _ExtentY        =   8705
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   6
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Project Settings"
            Object.Tag             =   "1198"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Startup Info"
            Object.Tag             =   "1197"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "RPGCode"
            Object.Tag             =   "1196"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Fighting"
            Object.Tag             =   "1195"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Graphics"
            Object.Tag             =   "1190"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Plugins"
            Object.Tag             =   "1167"
            ImageVarType    =   2
         EndProperty
      EndProperty
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
      Left            =   2280
      TabIndex        =   0
      Tag             =   "1199"
      Top             =   5040
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

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_MAINFILE
End Function


Public Sub checkSave()
    'check if the file has changed an it needs to be saved...
    On Error GoTo errorhandler
    If mainNeedUpdate = True Then
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub plugininfofill()
    'fills in plugin info
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub saveFile()
    'saves the file.
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub


Public Sub clearAll()
'erases main file data
    On Error GoTo errorhandler
    Call MainClear(mainMem)
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub closemnu_Click()
    On Error GoTo errorhandler
    Unload mainfight
    Unload editmainfile

    Exit Sub
'Begin error handling code:
errorhandler:
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
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainfight.Show vbModal ', me

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command13_Click()
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command10_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + pluginPath$ + antiPath$
    fgtPlugin.text = antiPath$
    mainMem.fightPlugin = antiPath$
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    initboardbox.text = antiPath$
    mainMem.initBoard$ = antiPath$
End Sub

Private Sub Command15_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tempath$ + antiPath$
    initcharbox.text = antiPath$
    mainMem.initChar$ = antiPath$
End Sub

Private Sub Command16_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    runtimebox.text = antiPath$
    mainMem.runTime$ = antiPath$
End Sub

Private Sub Command17_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    startupbox.text = antiPath$
    mainMem.startupPrg$ = antiPath$
End Sub

Private Sub Command18_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    whichType$ = extention(filename$(1))
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    Text1.text = antiPath$
    mainMem.gameOverPrg$ = antiPath$
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    skinedit.Show vbModal ', me

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    runtimeprograms.Show vbModal ', me

    Exit Sub
'Begin error handling code:
errorhandler:
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
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + plugpath$ + antiPath$
       
    Call MainAddPlugin(mainMem, antiPath$)
    
    descr$ = pluginDescription(projectPath$ + plugpath$ + antiPath$)
    plugList.AddItem (antiPath$ + "    " + descr$)
    Call PLUGShutdownSystem
    
End Sub


Private Sub Command6_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + pluginPath$ + antiPath$
    mnuplugin.text = antiPath$
    mainMem.menuPlugin = antiPath$
End Sub


Private Sub Command7_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursormove.text = antiPath$
    mainMem.cursorMoveSound = antiPath$
End Sub


Private Sub Command8_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursorselect.text = antiPath$
    mainMem.cursorSelectSound = antiPath$
End Sub

Private Sub Command9_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    cursorcancel.text = antiPath$
    mainMem.cursorCancelSound = antiPath$
End Sub

Private Sub cursorcancel_Change()
    On Error Resume Next
    mainMem.cursorCancelSound = cursorcancel.text
End Sub

Private Sub cursormove_Change()
    On Error Resume Next
    mainMem.cursorMoveSound = cursormove.text
End Sub

Private Sub cursorselect_Change()
    On Error Resume Next
    mainMem.cursorSelectSound = cursorselect.text
End Sub


Private Sub daylengthbox_Change()
    On Error GoTo errorhandler
    
    mainMem.mainDayLength = val(daylengthbox.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub daynightcheckbox_Click()
    On Error GoTo errorhandler
    
    mainMem.mainUseDayNight = daynightcheckbox.value
    If mainMem.mainUseDayNight = 1 Then
        Frame3.Visible = True
    Else
        Frame3.Visible = False
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
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
    On Error GoTo errorhandler
    mainMem.mainResolution = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub enableJoystick_Click()
    On Error Resume Next
    mainMem.useJoystick = enableJoystick.value
End Sub

Private Sub fgtPlugin_Change()
    On Error Resume Next
    mainMem.fightPlugin = fgtPlugin.text
End Sub

Private Sub Form_Activate()
    Set activeForm = Me
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    Call LocalizeTabStrip(TabStrip1)
    
    editmainfile.height = 6270
    editmainfile.Width = 7905
    filename$(2) = ""
    Call infofill
    projectframe.Visible = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub fullscreen_Click()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub gametitlebox_Change()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox.text
    gametitlebox2.text = mainMem.gameTitle$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub horizontalupdate_Click()
    On Error GoTo errorhandler
    updatetype = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo errorhandler
    Option3.value = True
    Option1.value = True
    Option5.value = True
    If mainMem.startupPrg$ <> "" Then
        startupbox.text = mainMem.startupPrg$          'start up program
    Else
        startupbox.text = LoadStringLoc(1010, "None")
    End If
    If mainMem.runTime$ <> "" Then
        runtimebox.text = mainMem.runTime$             'run time program
    Else
        runtimebox.text = LoadStringLoc(1010, "None")
    End If
    If mainMem.gameOverPrg$ <> "" Then
        Text1.text = mainMem.gameOverPrg$             'run time program
    Else
        Text1.text = LoadStringLoc(1010, "None")
    End If
    mnuplugin.text = mainMem.menuPlugin
    fgtPlugin.text = mainMem.fightPlugin
    
    a$ = UCase$(chr$(mainMem.runKey))
    If mainMem.runKey = 32 Then a$ = "SPC"
    If mainMem.runKey = 27 Then a$ = "ESC"
    If mainMem.runKey = 13 Then a$ = "ENTR"
    runkeybox.text = a$

    a$ = UCase$(chr$(mainMem.menuKey))
    If mainMem.menuKey = 32 Then a$ = "SPC"
    If mainMem.menuKey = 27 Then a$ = "ESC"
    If mainMem.menuKey = 13 Then a$ = "ENTR"
    menukeybox.text = a$

    a$ = UCase$(chr$(mainMem.key))
    If mainMem.key = 32 Then a$ = "SPC"
    If mainMem.key = 27 Then a$ = "ESC"
    If mainMem.key = 13 Then a$ = "ENTR"
    keybox.text = a$

    If mainMem.initBoard$ <> "" Then
        initboardbox.text = mainMem.initBoard$           'initial board
    Else
        initboardbox.text = LoadStringLoc(1010, "None")
    End If
    If mainMem.initChar$ <> "" Then
        initcharbox.text = mainMem.initChar$            'initial character
    Else
        initcharbox.text = LoadStringLoc(1010, "None")
    End If

    Option4.value = mainMem.fightgameYN             'fighting in game? 0-yes, 1-no

    'If updatetype = 0 Then noupdate.Value = True
    'If updatetype = 1 Then horizontalupdate.Value = True
    'If updatetype = 2 Then tileupdate.Value = True

    If mainMem.mainScreenType = 0 Then fullscreen.value = True
    If mainMem.mainScreenType = 1 Then fullscreen.value = True
    If mainMem.mainScreenType = 2 Then smallwindowed.value = True
    
    gametitlebox.text = mainMem.gameTitle$
    gametitlebox2.text = mainMem.gameTitle$
    editmainfile.Caption = LoadStringLoc(800, "Main Project Editor") + "  (" + mainfile$ + ")"
    
    pathbox.Caption = projectPath$
    
    Call TestGraphicsMode
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
    daylengthbox.text = str$(mainMem.mainDayLength)

    If mainMem.mainDisableProtectReg = 0 Then
        regprotect.value = 1
    Else
        regprotect.value = 0
    End If
    
    regprotect.Visible = False
   
    cursormove.text = mainMem.cursorMoveSound
    cursorselect.text = mainMem.cursorSelectSound
    cursorcancel.text = mainMem.cursorCancelSound

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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub gametitlebox2_Change()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.gameTitle$ = gametitlebox2.text
    gametitlebox.text = mainMem.gameTitle$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub initboardbox_Change()
    On Error Resume Next
    mainMem.initBoard$ = initboardbox.text
End Sub

Private Sub initcharbox_Change()
    On Error Resume Next
    mainMem.initChar$ = initcharbox.text
End Sub

Private Sub keybox_KeyPress(KeyAscii As Integer)
    On Error GoTo errorhandler
    mainNeedUpdate = True
    ascii = KeyAscii
    If mainMem.menuKey = ascii Or mainMem.runKey = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.key = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    keybox.text = a$
    KeyAscii = 0


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label2_Click()
    On Error GoTo errorhandler
    activeEnemy.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label21_Click()
    On Error GoTo errorhandler
    activePlayer.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label22_Click()
    On Error GoTo errorhandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Label24_Click()
    On Error GoTo errorhandler
    activeBoard.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label9_Click()
    On Error GoTo errorhandler
    activeBoard.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub menukeybox_KeyPress(KeyAscii As Integer)
    On Error GoTo errorhandler
    mainNeedUpdate = True
    ascii = KeyAscii
    If mainMem.runKey = ascii Or mainMem.key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.menuKey = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    menukeybox.text = a$
    KeyAscii = 0


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuCLose_Click()
    Unload Me
End Sub

Private Sub mnuplugin_Change()
    On Error Resume Next
    mainMem.menuPlugin = mnuplugin.text
End Sub

Private Sub newmain()
    On Error GoTo errorhandler
    Call clearAll

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub newmainmnu_Click()
    On Error GoTo errorhandler
    user = MsgBox(LoadStringLoc(947, "Remove current data and start a new file.  Are you sure?"), 4)
    If user = 6 Then
        mainfile$ = ""
        Call newmain
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub noupdate_Click()
    On Error GoTo errorhandler
    updatetype = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub openmnu_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
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
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    
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
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.fightgameYN = 0
    Command1.Enabled = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option4_Click()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.fightgameYN = 1
    Command1.Enabled = False

    Exit Sub
'Begin error handling code:
errorhandler:
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
    If mainMem.menuKey = ascii Or mainMem.key = ascii Then MsgBox LoadStringLoc(963, "That's already being used!"): KeyAscii = 0: Exit Sub
    mainMem.runKey = ascii
    a$ = UCase$(chr$(ascii))
    If ascii = 32 Then a$ = "SPC"
    If ascii = 27 Then a$ = "ESC"
    If ascii = 13 Then a$ = "ENTR"
    runkeybox.text = a$
    KeyAscii = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub runtimebox_Change()
    On Error Resume Next
    mainMem.runTime$ = runtimebox.text
End Sub


Private Sub savemnu_Click()
    On Error GoTo errorhandler
    filename$(2) = mainfile$
    If filename$(2) = "" Then mnusaveas_Click: Exit Sub
    Call saveMain(gampath$ + filename$(2), mainMem)
    mainNeedUpdate = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub sixfourty_Click()
    On Error GoTo errorhandler
    mainMem.mainResolution = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smallwindowed_Click()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 2

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub startupbox_Change()
    On Error Resume Next
    mainMem.startupPrg$ = startupbox.text
End Sub

Private Sub tileupdate_Click()
    On Error GoTo errorhandler
    updatetype = 2

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub stretchbox_Click()
    On Error GoTo errorhandler
    mainMem.extendToFullScreen = stretchbox.value

    Exit Sub
'Begin error handling code:
errorhandler:
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
    On Error GoTo errorhandler
    mainMem.mainResolution = 2

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_Change()
    On Error Resume Next
    mainMem.gameOverPrg$ = Text1.text
'    End If

End Sub

Private Sub toc_Click()
    On Error GoTo errorhandler
    Call BrowseFile(helppath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub win3_Click()
    On Error GoTo errorhandler
    usefastdrawYN = True
    targetPlatform = 2

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub windowed_Click()
    On Error GoTo errorhandler
    mainNeedUpdate = True
    mainMem.mainScreenType = 0

    Exit Sub
'Begin error handling code:
errorhandler:
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

