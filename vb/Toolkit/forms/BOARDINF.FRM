VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form boardinformation 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Information"
   ClientHeight    =   4440
   ClientLeft      =   1230
   ClientTop       =   1050
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
   Icon            =   "BOARDINF.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4440
   ScaleWidth      =   7515
   Tag             =   "1039"
   Begin VB.CommandButton Command11 
      Caption         =   "Cancel"
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
      Left            =   6240
      TabIndex        =   9
      Tag             =   "1008"
      Top             =   3960
      Width           =   1095
   End
   Begin VB.CommandButton Command6 
      Appearance      =   0  'Flat
      Caption         =   "OK"
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
      Left            =   5040
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   3960
      Width           =   1095
   End
   Begin VB.Frame Frame4 
      Caption         =   "Directional Links"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   4
      Tag             =   "1057"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   2415
         Left            =   240
         ScaleHeight     =   2415
         ScaleWidth      =   6615
         TabIndex        =   38
         Top             =   360
         Width           =   6615
         Begin VB.CommandButton Command1 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   48
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
         Begin VB.CommandButton Command2 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   47
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.CommandButton Command3 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   46
            Tag             =   "1021"
            Top             =   720
            Width           =   1095
         End
         Begin VB.CommandButton Command4 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   45
            Tag             =   "1021"
            Top             =   1080
            Width           =   1095
         End
         Begin VB.TextBox nl 
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
            Left            =   1560
            TabIndex        =   44
            Top             =   0
            Width           =   1815
         End
         Begin VB.TextBox sl 
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
            Left            =   1560
            TabIndex        =   43
            Top             =   360
            Width           =   1815
         End
         Begin VB.TextBox el 
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
            Left            =   1560
            TabIndex        =   42
            Top             =   720
            Width           =   1815
         End
         Begin VB.TextBox wl 
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
            Left            =   1560
            TabIndex        =   41
            Top             =   1080
            Width           =   1815
         End
         Begin VB.TextBox txtEnterPrg 
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
            Left            =   1560
            TabIndex        =   40
            Top             =   1800
            Width           =   1815
         End
         Begin VB.CommandButton cmdEnterPrg 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   39
            Tag             =   "1021"
            Top             =   1800
            Width           =   1095
         End
         Begin VB.Label Label4 
            Caption         =   "Northern Link"
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
            Left            =   0
            TabIndex        =   54
            Tag             =   "1061"
            Top             =   0
            Width           =   1455
         End
         Begin VB.Label Label8 
            Caption         =   "Southern Link"
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
            Left            =   0
            TabIndex        =   53
            Tag             =   "1060"
            Top             =   360
            Width           =   1455
         End
         Begin VB.Label Label9 
            Caption         =   "Eastern Link"
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
            Left            =   0
            TabIndex        =   52
            Tag             =   "1059"
            Top             =   720
            Width           =   1455
         End
         Begin VB.Label Label10 
            Caption         =   "Western Link"
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
            Left            =   0
            TabIndex        =   51
            Tag             =   "1058"
            Top             =   1080
            Width           =   1455
         End
         Begin VB.Label lblEnterPrg 
            Caption         =   "Program to run when entering board"
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
            Left            =   0
            TabIndex        =   50
            Top             =   1800
            Width           =   1575
         End
         Begin VB.Label lblDirLinkInfo 
            Caption         =   "Tip:"
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
            Left            =   4800
            TabIndex        =   49
            Top             =   0
            Width           =   1695
         End
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Music"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   3
      Tag             =   "1062"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   1815
         Left            =   120
         ScaleHeight     =   1815
         ScaleWidth      =   5655
         TabIndex        =   55
         Top             =   360
         Width           =   5655
         Begin VB.CommandButton Command9 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   360
            Picture         =   "BOARDINF.frx":0CCA
            Style           =   1  'Graphical
            TabIndex        =   59
            Top             =   720
            Width           =   375
         End
         Begin VB.CommandButton Command8 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   0
            Picture         =   "BOARDINF.frx":1994
            Style           =   1  'Graphical
            TabIndex        =   58
            Top             =   720
            Width           =   375
         End
         Begin VB.TextBox music 
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
            Left            =   0
            TabIndex        =   57
            Top             =   360
            Width           =   3255
         End
         Begin VB.CommandButton Command7 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   56
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.Label Label12 
            Caption         =   "Background Music"
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
            Left            =   0
            TabIndex        =   60
            Tag             =   "1024"
            Top             =   0
            Width           =   2295
         End
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Battle Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   5
      Tag             =   "1051"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture8 
         BorderStyle     =   0  'None
         Height          =   2055
         Left            =   240
         ScaleHeight     =   2055
         ScaleWidth      =   5415
         TabIndex        =   61
         Top             =   360
         Width           =   5415
         Begin VB.CommandButton Command5 
            Appearance      =   0  'Flat
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
            Left            =   3480
            TabIndex        =   65
            Tag             =   "1053"
            Top             =   1200
            Width           =   1095
         End
         Begin VB.TextBox skillbox 
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
            Left            =   1560
            TabIndex        =   64
            Text            =   "1"
            Top             =   360
            Width           =   1815
         End
         Begin VB.CheckBox fyes 
            Caption         =   "Fighting is permitted on this board"
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
            Left            =   0
            TabIndex        =   63
            Tag             =   "1052"
            Top             =   0
            Width           =   3255
         End
         Begin VB.TextBox Text2 
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
            Left            =   1560
            TabIndex        =   62
            Top             =   1200
            Width           =   1815
         End
         Begin VB.Label Label3 
            Alignment       =   1  'Right Justify
            Caption         =   "Also see Enemy Info"
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
            Index           =   2
            Left            =   1800
            MouseIcon       =   "BOARDINF.frx":265E
            MousePointer    =   99  'Custom
            TabIndex        =   68
            Tag             =   "1055"
            Top             =   720
            Visible         =   0   'False
            Width           =   2775
         End
         Begin VB.Label Label3 
            Caption         =   "Board Skill:"
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
            Index           =   0
            Left            =   0
            TabIndex        =   67
            Tag             =   "1054"
            Top             =   360
            Width           =   1335
         End
         Begin VB.Label Label11 
            Caption         =   "Background:"
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
            Left            =   0
            TabIndex        =   66
            Tag             =   "1053"
            Top             =   1200
            Width           =   1455
         End
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Progress"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   2
      Tag             =   "1063"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture3 
         BorderStyle     =   0  'None
         Height          =   615
         Left            =   120
         ScaleHeight     =   615
         ScaleWidth      =   2415
         TabIndex        =   11
         Top             =   240
         Width           =   2415
         Begin VB.CheckBox Check1 
            Caption         =   "Disable Progress Saving"
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
            TabIndex        =   12
            Tag             =   "1064"
            Top             =   0
            Width           =   2655
         End
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Constants"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   1
      Tag             =   "1065"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture4 
         BorderStyle     =   0  'None
         Height          =   1695
         Left            =   240
         ScaleHeight     =   1695
         ScaleWidth      =   5055
         TabIndex        =   13
         Top             =   360
         Width           =   5055
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
            Left            =   1680
            TabIndex        =   15
            Text            =   "0"
            Top             =   240
            Width           =   735
         End
         Begin VB.ComboBox consta 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   0
            TabIndex        =   14
            Text            =   "Constant 1"
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Value"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   1680
            TabIndex        =   17
            Tag             =   "1067"
            Top             =   0
            Width           =   735
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Number"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   16
            Tag             =   "1066"
            Top             =   0
            Width           =   735
         End
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Title"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   8
      Tag             =   "1040"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture5 
         BorderStyle     =   0  'None
         Height          =   1695
         Left            =   240
         ScaleHeight     =   1695
         ScaleWidth      =   4815
         TabIndex        =   18
         Top             =   360
         Width           =   4815
         Begin VB.TextBox layername 
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
            Left            =   1560
            TabIndex        =   20
            Top             =   240
            Width           =   1815
         End
         Begin VB.ComboBox blayer 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   0
            TabIndex        =   19
            Text            =   "Layer 1"
            Top             =   240
            Width           =   1215
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Title"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Index           =   2
            Left            =   1560
            TabIndex        =   22
            Tag             =   "1040"
            Top             =   0
            Width           =   495
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Layer"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   21
            Tag             =   "1041"
            Top             =   0
            Width           =   855
         End
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Day/Night"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   6
      Tag             =   "1048"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture6 
         BorderStyle     =   0  'None
         Height          =   1215
         Left            =   240
         ScaleHeight     =   1215
         ScaleWidth      =   4455
         TabIndex        =   23
         Top             =   360
         Width           =   4455
         Begin VB.CheckBox daynight 
            Caption         =   "Day/Night Enabled"
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
            Left            =   0
            TabIndex        =   25
            Tag             =   "1050"
            Top             =   0
            Width           =   2175
         End
         Begin VB.CommandButton Command10 
            Caption         =   "More..."
            Enabled         =   0   'False
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
            Left            =   2280
            TabIndex        =   24
            Tag             =   "1049"
            Top             =   0
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Size"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   360
      TabIndex        =   7
      Tag             =   "1042"
      Top             =   600
      Width           =   6855
      Begin VB.PictureBox Picture7 
         BorderStyle     =   0  'None
         Height          =   1815
         Left            =   240
         ScaleHeight     =   1815
         ScaleWidth      =   4335
         TabIndex        =   26
         Top             =   240
         Width           =   4335
         Begin VB.VScrollBar VScroll1 
            Height          =   375
            Left            =   2280
            Max             =   512
            Min             =   11
            TabIndex        =   34
            Top             =   600
            Value           =   11
            Visible         =   0   'False
            Width           =   135
         End
         Begin VB.HScrollBar HScroll1 
            Height          =   135
            Left            =   2400
            Max             =   512
            Min             =   19
            TabIndex        =   33
            Top             =   960
            Value           =   19
            Visible         =   0   'False
            Width           =   375
         End
         Begin VB.TextBox sx 
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
            Left            =   240
            TabIndex        =   32
            Top             =   120
            Width           =   495
         End
         Begin VB.TextBox sy 
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
            Left            =   1200
            TabIndex        =   31
            Top             =   120
            Width           =   495
         End
         Begin VB.VScrollBar VScroll2 
            Height          =   255
            Left            =   720
            Max             =   0
            Min             =   2048
            TabIndex        =   30
            TabStop         =   0   'False
            Top             =   120
            Value           =   2048
            Width           =   135
         End
         Begin VB.VScrollBar VScroll3 
            Height          =   255
            Left            =   1680
            Max             =   0
            Min             =   2048
            TabIndex        =   29
            TabStop         =   0   'False
            Top             =   120
            Width           =   135
         End
         Begin VB.OptionButton Option1 
            Caption         =   "4 Layers"
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
            Left            =   2040
            TabIndex        =   28
            Tag             =   "1044"
            Top             =   0
            Width           =   1815
         End
         Begin VB.OptionButton Option2 
            Caption         =   "8 Layers"
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
            Left            =   2040
            TabIndex        =   27
            Tag             =   "1043"
            Top             =   240
            Width           =   1575
         End
         Begin VB.Label Label1 
            Caption         =   "X"
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
            Left            =   0
            TabIndex        =   37
            Tag             =   "1046"
            Top             =   120
            Width           =   135
         End
         Begin VB.Label Label2 
            Caption         =   "Y"
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
            Left            =   960
            TabIndex        =   36
            Tag             =   "1045"
            Top             =   120
            Width           =   135
         End
         Begin VB.Label bs 
            Caption         =   "xx X yy"
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
            Left            =   2520
            TabIndex        =   35
            Tag             =   "1047"
            Top             =   720
            Visible         =   0   'False
            Width           =   855
         End
      End
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   3735
      Left            =   240
      TabIndex        =   10
      Top             =   120
      Width           =   7095
      _ExtentX        =   12515
      _ExtentY        =   6588
      MultiRow        =   -1  'True
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   7
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Directional Links"
            Object.Tag             =   "1057"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Battle Options"
            Object.Tag             =   "1051"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Title"
            Object.Tag             =   "1040"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Constants"
            Object.Tag             =   "1065"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Progress"
            Object.Tag             =   "1063"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Music"
            Object.Tag             =   "1062"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab7 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Size"
            Object.Tag             =   "1042"
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
End
Attribute VB_Name = "boardinformation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Sub infofill()
On Error Resume Next
    If boardList(activeBoardIndex).theData.dirLink$(1) <> "" Then nl.Text = boardList(activeBoardIndex).theData.dirLink$(1)
    If boardList(activeBoardIndex).theData.dirLink$(2) <> "" Then sl.Text = boardList(activeBoardIndex).theData.dirLink$(2)
    If boardList(activeBoardIndex).theData.dirLink$(3) <> "" Then el.Text = boardList(activeBoardIndex).theData.dirLink$(3)
    If boardList(activeBoardIndex).theData.dirLink$(4) <> "" Then wl.Text = boardList(activeBoardIndex).theData.dirLink$(4)
    If boardList(activeBoardIndex).theData.fightingYN = 0 Then
        fyes.value = 0
        Label3(0).Enabled = 0
        Command5.Enabled = 0
        skillbox.Enabled = 0
        bkgbox.Enabled = 0
    Else
        fyes.value = 1
        Label3(0).Enabled = 1
        Command5.Enabled = 1
        skillbox.Enabled = 1
        bkgbox.Enabled = 1
    End If
    skillbox.Text = boardList(activeBoardIndex).theData.boardSkill
    If boardList(activeBoardIndex).theData.boardBackground$ <> "" Then Text2.Text = boardList(activeBoardIndex).theData.boardBackground$
    
    'Constant values
    consta.Clear
    consta.AddItem "1"
    consta.AddItem "2"
    consta.AddItem "3"
    consta.AddItem "4"
    consta.AddItem "5"
    consta.AddItem "6"
    consta.AddItem "7"
    consta.AddItem "8"
    consta.AddItem "9"
    consta.AddItem "10"

    'Board title values
    blayer.Clear
    blayer.AddItem "1"
    blayer.AddItem "2"
    blayer.AddItem "3"
    blayer.AddItem "4"
    blayer.AddItem "5"
    blayer.AddItem "6"
    blayer.AddItem "7"
    blayer.AddItem "8"

    If boardList(activeBoardIndex).theData.boardTitle$(1) <> "" Then layername.Text = boardList(activeBoardIndex).theData.boardTitle$(1)


    If boardList(activeBoardIndex).theData.boardMusic$ <> "" Then music.Text = boardList(activeBoardIndex).theData.boardMusic$

    Check1.value = boardList(activeBoardIndex).theData.brdSavingYN
    
    bs.Caption = str$(boardList(activeBoardIndex).theData.bSizeX) + " X" + str$(boardList(activeBoardIndex).theData.bSizeY)

    daynight.value = boardList(activeBoardIndex).theData.BoardDayNight
    If boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Command10.Enabled = True
    Else
        Command10.Enabled = False
    End If
    
    If boardList(activeBoardIndex).theData.bSizeL = 4 Then
        Option1.value = True
    Else
        Option2.value = True
    End If
    VScroll2.value = boardList(activeBoardIndex).theData.bSizeX
    VScroll3.value = boardList(activeBoardIndex).theData.bSizeY
    
    txtEnterPrg.Text = boardList(activeBoardIndex).theData.enterPrg
    'Add the caption for the directional board links.
    lblDirLinkInfo.Caption = "Tip: You can also set a program as a link to run " & _
                             "instead of being sent to a new board."

End Sub


Private Sub blayer_Click()
    On Error GoTo ErrorHandler
    whichOne = blayer.ListIndex
    If whichOne = -1 Then whichOne = 0
    whichOne = whichOne + 1
    layername.Text = boardList(activeBoardIndex).theData.boardTitle$(whichOne)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check1_Click()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).theData.brdSavingYN = Check1.value

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub cmdEnterPrg_Click(): On Error Resume Next
'====================================================
'Program to run on entering board Browse button.
'====================================================

    ChDir (currentDir)

    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & prgPath
    dlg.strTitle = "Program to run on entering board"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "Supported Files|*.prg|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    ChDir (currentDir)
    
    If dlg.strSelectedFile = "" Then Exit Sub
    
    If UCase$(GetExt(dlg.strSelectedFileNoPath)) = "PRG" Then
        FileCopy dlg.strSelectedFile, projectPath & prgPath & antiPath
        boardList(activeBoardIndex).theData.enterPrg = dlg.strSelectedFileNoPath
        txtEnterPrg.Text = dlg.strSelectedFileNoPath
    End If

End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdPath$
    dlg.strTitle = "Northern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    e$ = extention(antiPath$)
    If UCase$(e$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdPath$ + antiPath$
    End If
    If UCase$(e$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(1) = antiPath$
    nl.Text = antiPath$
End Sub


Private Sub Command10_Click()
    On Error GoTo ErrorHandler
    boardNeedUpdate = True

    BoardDayNightForm.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command11_Click()
    Unload boardinformation
End Sub

Private Sub Command12_Click()
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdPath$
    dlg.strTitle = "Southern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    e$ = extention(antiPath$)
    If UCase$(e$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdPath$ + antiPath$
    End If
    If UCase$(e$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(2) = antiPath$
    sl.Text = antiPath$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdPath$
    dlg.strTitle = "Eastern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    e$ = extention(antiPath$)
    If UCase$(e$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdPath$ + antiPath$
    End If
    If UCase$(e$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(3) = antiPath$
    el.Text = antiPath$
End Sub

Private Sub Command4_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdPath$
    dlg.strTitle = "Western Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    e$ = extention(antiPath$)
    If UCase$(e$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdPath$ + antiPath$
    End If
    If UCase$(e$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(4) = antiPath$
    wl.Text = antiPath$
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bkgPath$
    dlg.strTitle = "Board Background"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bkgPath$ + antiPath$
    boardList(activeBoardIndex).theData.boardBackground$ = antiPath$
    Text2.Text = antiPath$
End Sub

Private Sub Command6_Click(): On Error GoTo ErrorHandler
'========================================================
'Altered for isometrics by Delano for 3.0.4.
'Added label on this tab listing minmum board sizes.

    boardList(activeBoardIndex).theData.boardSkill = val(skillbox.Text)
    
    'Fix: allow for minimum board size for isometric boards:
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        'Isometric minima: 10x30 (640x480)
        If val(sx.Text) < 10 Then: sx.Text = "10"
        If val(sy.Text) < 30 Then: sy.Text = "30"
    Else
        '2D
        If val(sx.Text) < 19 Then: sx.Text = "19"
        If val(sy.Text) < 11 Then: sy.Text = "11"
    End If

    
    ' Get layer selection
    bl = 8: If Option1.value = True Then bl = 4
    
    ' Get x and y values
    bx = val(sx.Text): By = val(sy.Text)
    
    ' If changes were made to board width/height
    If bx <> boardList(activeBoardIndex).theData.bSizeX Or By <> boardList(activeBoardIndex).theData.bSizeY Then
        
        ' Assign new values
        boardList(activeBoardIndex).theData.bSizeX = bx
        boardList(activeBoardIndex).theData.bSizeY = By
        boardList(activeBoardIndex).theData.bSizeL = bl
        
        ' Resize board
        Call BoardResize(bx, By, bl, boardList(activeBoardIndex).theData)
        
        ' Resize form
        Call activeBoard.resizeForm(activeBoard.Width, activeBoard.Height)
        
        boardNeedUpdate = True
        
    ' If only the layer choice was changed
    ElseIf bl <> boardList(activeBoardIndex).theData.bSizeL Then

        ' Assign new value
        boardList(activeBoardIndex).theData.bSizeL = bl
        
        boardNeedUpdate = True

    End If

    ' Unload form
    Unload boardinformation

    Exit Sub

ErrorHandler:
    Call HandleError: Resume Next
End Sub

Private Sub sx_LostFocus(): On Error Resume Next
'===============================================
' On leaving the X-size textbox, check the value.

        'Maximum board size.
        If val(sx.Text) > 2048 Then sx.Text = "2048"
        
        If boardList(activeBoardIndex).theData.isIsometric = 1 Then
            'Isometric minima: 10x30 (640x480)
            If val(sx.Text) < 10 Then: sx.Text = "10"
        Else
            '2D
            If val(sx.Text) < 19 Then: sx.Text = "19"
        End If
    
        VScroll2.value = val(sx.Text)
End Sub

Private Sub sy_LostFocus(): On Error Resume Next
'===============================================
' On leaving the Y-size textbox, check the value.

        'Maximum board size.
        If val(sy.Text) > 2048 Then sy.Text = "2048"
        
        If boardList(activeBoardIndex).theData.isIsometric = 1 Then
            'Isometric minima: 10x30 (640x480)
            If val(sy.Text) < 30 Then: sy.Text = "30"
        Else
            '2D
            If val(sy.Text) < 11 Then: sy.Text = "11"
        End If
    
        VScroll3.value = val(sy.Text)
End Sub

Private Sub txtEnterPrg_Change(): On Error Resume Next
'=====================================================
'Program to run on entering board text field.
'=====================================================
    boardList(activeBoardIndex).theData.enterPrg = txtEnterPrg.Text
End Sub

Private Sub VScroll2_Change(): On Error Resume Next
'==================================================
'X-scroller.

    sx.Text = CStr(VScroll2.value)
    Call sx_LostFocus
    
End Sub

Private Sub VScroll3_Change(): On Error Resume Next
'==================================================
'Y-scroller.

    sy.Text = CStr(VScroll3.value)
    Call sy_LostFocus
    
End Sub

Private Sub Command7_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediaPath$
    dlg.strTitle = "Select Board Music"
    dlg.strDefaultExt = "mid"
    dlg.strFileTypes = strFileDialogFilterMedia
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath$
    boardList(activeBoardIndex).theData.boardMusic$ = antiPath$
    music.Text = antiPath$
End Sub

Private Sub Command8_Click()
On Error GoTo errmid
If boardList(activeBoardIndex).theData.boardMusic$ = "" Then MsgBox LoadStringLoc(957, "Please Select A Filename!"), , LoadStringLoc(958, "Music Player"): Exit Sub
ext$ = extention(boardList(activeBoardIndex).theData.boardMusic$)
If UCase$(ext$) = "WAV" Then
    wFlags% = SND_ASYNC Or SND_NODEFAULT
    x% = sndPlaySound(projectPath$ + mediaPath$ + boardList(activeBoardIndex).theData.boardMusic$, wFlags%)
Else
    'If UCase$(ext$) = "MID" Then
    '    OLE1.SourceDoc = projectPath$ + mediapath$ + boardmusic$
    '    OLE1.Action = 1
    '    OLE1.Action = 7
    'Else
        mp3player.Show
        mp3player.playSong (projectPath$ + mediaPath$ + boardList(activeBoardIndex).theData.boardMusic$)
    'End If
End If
Exit Sub
errmid:
Exit Sub
End Sub

Private Sub Command9_Click()
    On Error GoTo ErrorHandler
ext$ = extention(boardList(activeBoardIndex).theData.boardMusic$)
If UCase$(ext$) = "WAV" Then
    wFlags% = SND_ASYNC
    x% = sndPlaySound("stop.wav", wFlags%)
Else
    'OLE1.Action = 10
    Call mp3player.stopMusic
End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub consta_Click()
    On Error GoTo ErrorHandler
    whichOne = consta.ListIndex
    If whichOne = -1 Then whichOne = 0
    whichOne = whichOne + 1
    Text1.Text = str$(boardList(activeBoardIndex).theData.brdConst(whichOne))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub daynight_Click()
    On Error GoTo ErrorHandler
    
    boardNeedUpdate = True
    boardList(activeBoardIndex).theData.BoardDayNight = daynight.value
    
    If boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Command10.Enabled = True
    Else
        Command10.Enabled = False
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub el_Change()
    boardList(activeBoardIndex).theData.dirLink$(3) = el.Text
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    Call LocalizeTabStrip(TabStrip1)
    
    Frame4.Visible = True
    Frame2.Visible = False
    Frame3.Visible = False
    Frame1.Visible = False
    Frame5.Visible = False
    Frame6.Visible = False
    Frame7.Visible = False
    Frame8.Visible = False
    
    Call infofill
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fyes_Click()
    On Error GoTo ErrorHandler
    If fyes.value = 0 Then
        'fyes.Value = 1
        boardList(activeBoardIndex).theData.fightingYN = 0
    Else
        'fyes.Value = 0
        boardList(activeBoardIndex).theData.fightingYN = 1
    End If
    If boardList(activeBoardIndex).theData.fightingYN = 0 Then
        'fyes.Value = 0
        Label3(0).Enabled = 0
        Command5.Enabled = 0
        skillbox.Enabled = 0
        bkgbox.Enabled = 0
    Else
        'fyes.Value = 1
        Label3(0).Enabled = 1
        Command5.Enabled = 1
        skillbox.Enabled = 1
        bkgbox.Enabled = 1
    End If


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub HScroll1_Change()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).theData.bSizeX = HScroll1.value
    bs.Caption = str$(boardList(activeBoardIndex).theData.bSizeX) + " X" + str$(boardList(activeBoardIndex).theData.bSizeY)

    activeBoard.VScroll1.max = boardList(activeBoardIndex).theData.bSizeY - tilesY + 1
    activeBoard.HScroll1.max = boardList(activeBoardIndex).theData.bSizeX - tilesX + 1
    Call BoardSetSize(boardList(activeBoardIndex).theData.bSizeX, boardList(activeBoardIndex).theData.bSizeY, boardList(activeBoardIndex).theData.bSizeL, boardList(activeBoardIndex).theData)
    Call activeBoard.resizeForm(activeBoard.Width, activeBoard.Height)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label3_Click(index As Integer)
    On Error GoTo ErrorHandler
    If index = 2 Then mainfight.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Label5_Click(index As Integer)
    On Error GoTo ErrorHandler
    If index = 1 Then editBackground.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub layername_Change()
    On Error GoTo ErrorHandler
    whichOne = blayer.ListIndex
    If whichOne = -1 Then whichOne = 0
    whichOne = whichOne + 1
    boardList(activeBoardIndex).theData.boardTitle$(whichOne) = layername.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub music_Change()
    boardList(activeBoardIndex).theData.boardMusic$ = music.Text
End Sub

Private Sub nl_Change()
    boardList(activeBoardIndex).theData.dirLink$(1) = nl.Text
End Sub

Private Sub sl_Change()
    boardList(activeBoardIndex).theData.dirLink$(2) = sl.Text
End Sub

Private Sub TabStrip1_Click()
    Frame1.Visible = False
    Frame2.Visible = False
    Frame3.Visible = False
    Frame4.Visible = False
    Frame5.Visible = False
    Frame6.Visible = False
    Frame7.Visible = False
    Frame8.Visible = False
'FIXIT: p1.SelectedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
'FIXIT: electedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
    Select Case TabStrip1.SelectedItem.index
        Case 1:
            Frame4.Visible = True
        Case 2:
            Frame5.Visible = True
        Case 3:
            Frame8.Visible = True
        Case 4:
            Frame1.Visible = True
        Case 5:
            Frame2.Visible = True
        Case 6:
            Frame3.Visible = True
        'Case 7:
        '    Frame6.Visible = True
        Case 7:
            Frame7.Visible = True
    End Select
End Sub

Private Sub Text1_Change()
    whichOne = consta.ListIndex
    If whichOne = -1 Then whichOne = 0
    whichOne = whichOne + 1
    boardList(activeBoardIndex).theData.brdConst(whichOne) = val(Text1.Text)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text2_Change()
    boardList(activeBoardIndex).theData.boardBackground$ = Text2.Text
End Sub

Private Sub VScroll1_Change()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).theData.bSizeY = VScroll1.value
    bs.Caption = str$(boardList(activeBoardIndex).theData.bSizeX) + " X" + str$(boardList(activeBoardIndex).theData.bSizeY)

    activeBoard.VScroll1.max = boardList(activeBoardIndex).theData.bSizeY - tilesY + 1
    activeBoard.HScroll1.max = boardList(activeBoardIndex).theData.bSizeX - tilesX + 1
    Call BoardSetSize(boardList(activeBoardIndex).theData.bSizeX, boardList(activeBoardIndex).theData.bSizeY, boardList(activeBoardIndex).theData.bSizeL, boardList(activeBoardIndex).theData)
    Call activeBoard.resizeForm(activeBoard.Width, activeBoard.Height)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub wl_Change()
    boardList(activeBoardIndex).theData.dirLink$(4) = wl.Text
End Sub


