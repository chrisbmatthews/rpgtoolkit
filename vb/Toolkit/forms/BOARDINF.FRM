VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form boardinformation 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Information"
   ClientHeight    =   4500
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
   ScaleHeight     =   4500
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
      TabIndex        =   56
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
      TabIndex        =   8
      Tag             =   "1062"
      Top             =   720
      Width           =   6855
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
         Left            =   480
         Picture         =   "BOARDINF.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   960
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
         Left            =   120
         Picture         =   "BOARDINF.frx":1994
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   960
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
         Left            =   120
         TabIndex        =   55
         Top             =   600
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
         Left            =   3600
         TabIndex        =   11
         Tag             =   "1021"
         Top             =   600
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
         Left            =   120
         TabIndex        =   54
         Tag             =   "1024"
         Top             =   240
         Width           =   2295
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
      TabIndex        =   17
      Tag             =   "1051"
      Top             =   720
      Width           =   6855
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
         Left            =   1680
         TabIndex        =   52
         Top             =   1560
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
         Left            =   120
         TabIndex        =   20
         Tag             =   "1052"
         Top             =   360
         Width           =   3255
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
         Left            =   1680
         TabIndex        =   19
         Text            =   "1"
         Top             =   720
         Width           =   1815
      End
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
         Left            =   3600
         TabIndex        =   18
         Tag             =   "1053"
         Top             =   1560
         Width           =   1095
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
         Left            =   120
         TabIndex        =   53
         Tag             =   "1053"
         Top             =   1560
         Width           =   1455
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
         Left            =   120
         TabIndex        =   23
         Tag             =   "1054"
         Top             =   720
         Width           =   1335
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
         Left            =   1920
         MouseIcon       =   "BOARDINF.frx":265E
         MousePointer    =   99  'Custom
         TabIndex        =   22
         Tag             =   "1055"
         Top             =   1080
         Visible         =   0   'False
         Width           =   2775
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Caption         =   "Also see Background Editor"
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
         Index           =   1
         Left            =   1320
         MouseIcon       =   "BOARDINF.frx":2968
         MousePointer    =   99  'Custom
         TabIndex        =   21
         Tag             =   "1056"
         Top             =   2040
         Visible         =   0   'False
         Width           =   3375
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
      TabIndex        =   6
      Tag             =   "1063"
      Top             =   720
      Width           =   6855
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
         TabIndex        =   7
         Tag             =   "1064"
         Top             =   240
         Width           =   2655
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
      Top             =   720
      Width           =   6855
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
         Left            =   120
         TabIndex        =   3
         Text            =   "Constant 1"
         Top             =   480
         Width           =   1455
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
         Left            =   1800
         TabIndex        =   2
         Text            =   "0"
         Top             =   480
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
         Left            =   120
         TabIndex        =   5
         Tag             =   "1066"
         Top             =   240
         Width           =   735
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
         Left            =   1800
         TabIndex        =   4
         Tag             =   "1067"
         Top             =   240
         Width           =   735
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
      TabIndex        =   31
      Tag             =   "1040"
      Top             =   720
      Width           =   6855
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
         Left            =   120
         TabIndex        =   33
         Text            =   "Layer 1"
         Top             =   480
         Width           =   1215
      End
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
         Left            =   1680
         TabIndex        =   32
         Top             =   480
         Width           =   1815
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
         Left            =   120
         TabIndex        =   35
         Tag             =   "1041"
         Top             =   240
         Width           =   855
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
         Left            =   1680
         TabIndex        =   34
         Tag             =   "1040"
         Top             =   240
         Width           =   495
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
      TabIndex        =   24
      Tag             =   "1048"
      Top             =   720
      Width           =   6855
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
         Left            =   2520
         TabIndex        =   25
         Tag             =   "1049"
         Top             =   240
         Width           =   1215
      End
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
         Left            =   240
         TabIndex        =   26
         Tag             =   "1050"
         Top             =   240
         Width           =   2175
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
      TabIndex        =   27
      Tag             =   "1042"
      Top             =   720
      Width           =   6855
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
         Left            =   1800
         TabIndex        =   43
         Tag             =   "1043"
         Top             =   480
         Width           =   1575
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
         Left            =   1800
         TabIndex        =   42
         Tag             =   "1044"
         Top             =   240
         Width           =   1815
      End
      Begin VB.VScrollBar VScroll3 
         Height          =   255
         Left            =   1560
         Max             =   1024
         TabIndex        =   39
         Top             =   360
         Value           =   11
         Width           =   135
      End
      Begin VB.VScrollBar VScroll2 
         Height          =   255
         Left            =   720
         Max             =   1024
         TabIndex        =   38
         Top             =   360
         Value           =   19
         Width           =   135
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
         Left            =   1080
         TabIndex        =   37
         Top             =   360
         Width           =   495
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
         TabIndex        =   36
         Top             =   360
         Width           =   495
      End
      Begin VB.HScrollBar HScroll1 
         Height          =   135
         Left            =   2160
         Max             =   512
         Min             =   19
         TabIndex        =   29
         Top             =   1440
         Value           =   19
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   375
         Left            =   2040
         Max             =   512
         Min             =   11
         TabIndex        =   28
         Top             =   1080
         Value           =   11
         Visible         =   0   'False
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
         TabIndex        =   41
         Tag             =   "1045"
         Top             =   360
         Width           =   135
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
         Left            =   120
         TabIndex        =   40
         Tag             =   "1046"
         Top             =   360
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
         Left            =   2280
         TabIndex        =   30
         Tag             =   "1047"
         Top             =   1200
         Visible         =   0   'False
         Width           =   855
      End
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
      TabIndex        =   12
      Tag             =   "1057"
      Top             =   720
      Width           =   6855
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
         Left            =   1680
         TabIndex        =   47
         Top             =   1440
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
         Left            =   1680
         TabIndex        =   46
         Top             =   1080
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
         Left            =   1680
         TabIndex        =   45
         Top             =   720
         Width           =   1815
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
         Left            =   1680
         TabIndex        =   44
         Top             =   360
         Width           =   1815
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
         Left            =   3600
         TabIndex        =   13
         Tag             =   "1021"
         Top             =   1440
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
         Left            =   3600
         TabIndex        =   14
         Tag             =   "1021"
         Top             =   1080
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
         Left            =   3600
         TabIndex        =   15
         Tag             =   "1021"
         Top             =   720
         Width           =   1095
      End
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
         Left            =   3600
         TabIndex        =   16
         Tag             =   "1021"
         Top             =   360
         Width           =   1095
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
         Left            =   120
         TabIndex        =   51
         Tag             =   "1058"
         Top             =   1440
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
         Left            =   120
         TabIndex        =   50
         Tag             =   "1059"
         Top             =   1080
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
         Left            =   120
         TabIndex        =   49
         Tag             =   "1060"
         Top             =   720
         Width           =   1455
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
         Left            =   120
         TabIndex        =   48
         Tag             =   "1061"
         Top             =   360
         Width           =   1455
      End
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   3735
      Left            =   240
      TabIndex        =   57
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
On Error GoTo errorhandler
    If boardList(activeBoardIndex).theData.dirLink$(1) <> "" Then nl.text = boardList(activeBoardIndex).theData.dirLink$(1)
    If boardList(activeBoardIndex).theData.dirLink$(2) <> "" Then sl.text = boardList(activeBoardIndex).theData.dirLink$(2)
    If boardList(activeBoardIndex).theData.dirLink$(3) <> "" Then el.text = boardList(activeBoardIndex).theData.dirLink$(3)
    If boardList(activeBoardIndex).theData.dirLink$(4) <> "" Then wl.text = boardList(activeBoardIndex).theData.dirLink$(4)
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
    skillbox.text = boardList(activeBoardIndex).theData.boardskill
    If boardList(activeBoardIndex).theData.boardBackground$ <> "" Then Text2.text = boardList(activeBoardIndex).theData.boardBackground$
    
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

    If boardList(activeBoardIndex).theData.boardTitle$(1) <> "" Then layername.text = boardList(activeBoardIndex).theData.boardTitle$(1)


    If boardList(activeBoardIndex).theData.boardMusic$ <> "" Then music.text = boardList(activeBoardIndex).theData.boardMusic$

    Check1.value = boardList(activeBoardIndex).theData.brdSavingYN
    
    bs.caption = str$(boardList(activeBoardIndex).theData.Bsizex) + " X" + str$(boardList(activeBoardIndex).theData.Bsizey)

    daynight.value = boardList(activeBoardIndex).theData.BoardDayNight
    If boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Command10.Enabled = True
    Else
        Command10.Enabled = False
    End If
    
    If boardList(activeBoardIndex).theData.Bsizel = 4 Then
        Option1.value = True
    Else
        Option2.value = True
    End If
    sx.text = toString(boardList(activeBoardIndex).theData.Bsizex)
    sy.text = toString(boardList(activeBoardIndex).theData.Bsizey)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub blayer_Click()
    On Error GoTo errorhandler
    whichone = blayer.ListIndex
    If whichone = -1 Then whichone = 0
    whichone = whichone + 1
    layername.text = boardList(activeBoardIndex).theData.boardTitle$(whichone)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check1_Click()
    On Error GoTo errorhandler
    boardList(activeBoardIndex).theData.brdSavingYN = Check1.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check2_Click()
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdpath$
    dlg.strTitle = "Northern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    E$ = extention(antiPath$)
    If UCase$(E$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    End If
    If UCase$(E$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(1) = antiPath$
    nl.text = antiPath$
End Sub


Private Sub Command10_Click()
    On Error GoTo errorhandler
    boardNeedUpdate = True

    BoardDayNightForm.Show vbModal ', me

    Exit Sub
'Begin error handling code:
errorhandler:
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
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdpath$
    dlg.strTitle = "Southern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    E$ = extention(antiPath$)
    If UCase$(E$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    End If
    If UCase$(E$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(2) = antiPath$
    sl.text = antiPath$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdpath$
    dlg.strTitle = "Eastern Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    E$ = extention(antiPath$)
    If UCase$(E$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    End If
    If UCase$(E$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(3) = antiPath$
    el.text = antiPath$
End Sub

Private Sub Command4_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + brdpath$
    dlg.strTitle = "Western Link (Note: you may select archives!)"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "Supported Files|*.brd;*.prg|RPG Toolkit Board (*.brd)|*.brd|RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    E$ = extention(antiPath$)
    If UCase$(E$) = "BRD" Then
        FileCopy filename$(1), projectPath$ + brdpath$ + antiPath$
    End If
    If UCase$(E$) = "PRG" Then
        FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    End If
    boardList(activeBoardIndex).theData.dirLink$(4) = antiPath$
    wl.text = antiPath$
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bkgpath$
    dlg.strTitle = "Board Background"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bkgpath$ + antiPath$
    boardList(activeBoardIndex).theData.boardBackground$ = antiPath$
    Text2.text = antiPath$
End Sub

Private Sub Command6_Click(): On Error GoTo errorhandler

    boardList(activeBoardIndex).theData.boardskill = val(skillbox.text)
    
    ' Check minimum board width/height values
    If val(sx.text) < 19 Then: sx.text = "19"
    If val(sy.text) < 11 Then: sy.text = "11"
    
    ' Get layer selection
    bl = 8: If Option1.value = True Then bl = 4
    
    ' Get x and y values
    bx = val(sx.text): By = val(sy.text)
    
    ' If changes were made to board width/height
    If bx <> boardList(activeBoardIndex).theData.Bsizex Or By <> boardList(activeBoardIndex).theData.Bsizey Then
        
        ' Assign new values
        boardList(activeBoardIndex).theData.Bsizex = bx
        boardList(activeBoardIndex).theData.Bsizey = By
        boardList(activeBoardIndex).theData.Bsizel = bl
        
        ' Resize board
        Call BoardResize(bx, By, bl, boardList(activeBoardIndex).theData)
        
        ' Resize form
        Call activeBoard.resizeForm(activeBoard.width, activeBoard.height)
        
        boardNeedUpdate = True
        
    ' If only the layer choice was changed
    ElseIf bl <> boardList(activeBoardIndex).theData.Bsizel Then

        ' Assign new value
        boardList(activeBoardIndex).theData.Bsizel = bl
        
        boardNeedUpdate = True

    End If

    ' Unload form
    Unload boardinformation

    Exit Sub

errorhandler:
    Call HandleError: Resume Next
End Sub

Private Sub Option1_Click()
    ignore = 1
    VScroll2.Max = 2048: VScroll3.Max = 2048
    ignore = 0
End Sub

Private Sub Option2_Click()
    If val(sx.text) > 1024 Then sx.text = "1024"
    If val(sy.text) > 1024 Then sy.text = "1024"
    
    ignore = 1
    VScroll2.Max = 1024: VScroll3.Max = 1024
    ignore = 0
End Sub

Private Sub sx_Change(): On Error Resume Next
    If Option1.value = True Then
        If val(sx.text) > 2048 Then sx.text = "2048"
        VScroll2.value = 2048 - val(sx.text)
    Else
        If val(sx.text) > 1024 Then sx.text = "1024"
        VScroll2.value = 1024 - val(sx.text)
    End If
End Sub

Private Sub sy_Change(): On Error Resume Next
    If Option1.value = True Then
        If val(sy.text) > 2048 Then sy.text = "2048"
        VScroll3.value = 2048 - val(sy.text)
    Else
        If val(sy.text) > 1024 Then sy.text = "1024"
        VScroll3.value = 1024 - val(sy.text)
    End If
End Sub

Private Sub VScroll2_Change(): If ignore = 1 Then Exit Sub
    If Option1.value = True Then
        sx.text = 2048 - VScroll2.value
    Else
        sx.text = 1024 - VScroll2.value
    End If
End Sub

Private Sub VScroll3_Change(): If ignore = 1 Then Exit Sub
    If Option1.value = True Then
        sy.text = 2048 - VScroll3.value
    Else
        sy.text = 1024 - VScroll3.value
    End If
End Sub

Private Sub Command7_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + mediapath$
    dlg.strTitle = "Select Board Music"
    dlg.strDefaultExt = "mid"
    dlg.strFileTypes = strFileDialogFilterMedia
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + mediapath$ + antiPath$
    boardList(activeBoardIndex).theData.boardMusic$ = antiPath$
    music.text = antiPath$
End Sub

Private Sub Command8_Click()
On Error GoTo errmid
If boardList(activeBoardIndex).theData.boardMusic$ = "" Then MsgBox LoadStringLoc(957, "Please Select A Filename!"), , LoadStringLoc(958, "Music Player"): Exit Sub
ext$ = extention(boardList(activeBoardIndex).theData.boardMusic$)
If UCase$(ext$) = "WAV" Then
    wFlags% = SND_ASYNC Or SND_NODEFAULT
    x% = sndPlaySound(projectPath$ + mediapath$ + boardList(activeBoardIndex).theData.boardMusic$, wFlags%)
Else
    'If UCase$(ext$) = "MID" Then
    '    OLE1.SourceDoc = projectPath$ + mediapath$ + boardmusic$
    '    OLE1.Action = 1
    '    OLE1.Action = 7
    'Else
        mp3player.Show
        mp3player.playSong (projectPath$ + mediapath$ + boardList(activeBoardIndex).theData.boardMusic$)
    'End If
End If
Exit Sub
errmid:
Exit Sub
End Sub

Private Sub Command9_Click()
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub consta_Click()
    On Error GoTo errorhandler
    whichone = consta.ListIndex
    If whichone = -1 Then whichone = 0
    whichone = whichone + 1
    Text1.text = str$(boardList(activeBoardIndex).theData.brdConst(whichone))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub daynight_Click()
    On Error GoTo errorhandler
    
    boardNeedUpdate = True
    boardList(activeBoardIndex).theData.BoardDayNight = daynight.value
    
    If boardList(activeBoardIndex).theData.BoardDayNight = 1 Then
        Command10.Enabled = True
    Else
        Command10.Enabled = False
    End If
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub el_Change()
    boardList(activeBoardIndex).theData.dirLink$(3) = el.text
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fyes_Click()
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub HScroll1_Change()
    On Error GoTo errorhandler
    boardList(activeBoardIndex).theData.Bsizex = HScroll1.value
    bs.caption = str$(boardList(activeBoardIndex).theData.Bsizex) + " X" + str$(boardList(activeBoardIndex).theData.Bsizey)

    activeBoard.VScroll1.Max = boardList(activeBoardIndex).theData.Bsizey - tilesY + 1
    activeBoard.HScroll1.Max = boardList(activeBoardIndex).theData.Bsizex - tilesX + 1
    Call BoardSetSize(boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, boardList(activeBoardIndex).theData)
    Call activeBoard.resizeForm(activeBoard.width, activeBoard.height)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label3_Click(Index As Integer)
    On Error GoTo errorhandler
    If Index = 2 Then mainfight.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Label5_Click(Index As Integer)
    On Error GoTo errorhandler
    If Index = 1 Then editBackground.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub layername_Change()
    On Error GoTo errorhandler
    whichone = blayer.ListIndex
    If whichone = -1 Then whichone = 0
    whichone = whichone + 1
    boardList(activeBoardIndex).theData.boardTitle$(whichone) = layername.text

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub music_Change()
    boardList(activeBoardIndex).theData.boardMusic$ = music.text
End Sub

Private Sub nl_Change()
    boardList(activeBoardIndex).theData.dirLink$(1) = nl.text
End Sub

Private Sub sl_Change()
    boardList(activeBoardIndex).theData.dirLink$(2) = sl.text
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
    Select Case TabStrip1.SelectedItem.Index
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
    whichone = consta.ListIndex
    If whichone = -1 Then whichone = 0
    whichone = whichone + 1
    boardList(activeBoardIndex).theData.brdConst(whichone) = val(Text1.text)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text2_Change()
    boardList(activeBoardIndex).theData.boardBackground$ = Text2.text
End Sub

Private Sub VScroll1_Change()
    On Error GoTo errorhandler
    boardList(activeBoardIndex).theData.Bsizey = VScroll1.value
    bs.caption = str$(boardList(activeBoardIndex).theData.Bsizex) + " X" + str$(boardList(activeBoardIndex).theData.Bsizey)

    activeBoard.VScroll1.Max = boardList(activeBoardIndex).theData.Bsizey - tilesY + 1
    activeBoard.HScroll1.Max = boardList(activeBoardIndex).theData.Bsizex - tilesX + 1
    Call BoardSetSize(boardList(activeBoardIndex).theData.Bsizex, boardList(activeBoardIndex).theData.Bsizey, boardList(activeBoardIndex).theData.Bsizel, boardList(activeBoardIndex).theData)
    Call activeBoard.resizeForm(activeBoard.width, activeBoard.height)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub wl_Change()
    boardList(activeBoardIndex).theData.dirLink$(4) = wl.text
End Sub


