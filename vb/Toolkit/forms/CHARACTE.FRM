VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form characteredit 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Editor (Untitled)"
   ClientHeight    =   5295
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   7995
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
   Icon            =   "CHARACTE.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5295
   ScaleWidth      =   7995
   Tag             =   "3"
   Begin VB.Frame mainFrame 
      Height          =   4935
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   7695
      Begin VB.CommandButton cmdLevels 
         Appearance      =   0  'Flat
         Caption         =   "Levels..."
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
         Left            =   5880
         TabIndex        =   4
         Tag             =   "1298"
         Top             =   3000
         Width           =   1575
      End
      Begin VB.CommandButton cmdEquipment 
         Appearance      =   0  'Flat
         Caption         =   "Equipment..."
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
         Left            =   5880
         TabIndex        =   3
         Tag             =   "1299"
         Top             =   2640
         Width           =   1575
      End
      Begin VB.CommandButton cmdGraphics 
         Appearance      =   0  'Flat
         Caption         =   "Graphics..."
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
         Left            =   5880
         TabIndex        =   2
         Tag             =   "1300"
         Top             =   2280
         Width           =   1575
      End
      Begin VB.CommandButton cmdSpecialMoves 
         Appearance      =   0  'Flat
         Caption         =   "Special Moves..."
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
         Left            =   5880
         TabIndex        =   1
         Tag             =   "1301"
         Top             =   1920
         Width           =   1575
      End
      Begin VB.PictureBox profile 
         AutoRedraw      =   -1  'True
         Height          =   975
         Left            =   6120
         ScaleHeight     =   61
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   61
         TabIndex        =   6
         ToolTipText     =   "Profile Picture"
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton cmdProfile 
         Appearance      =   0  'Flat
         Caption         =   "Profile..."
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
         Left            =   5880
         TabIndex        =   0
         Tag             =   "1302"
         Top             =   1560
         Width           =   1575
      End
      Begin VB.Frame frStats 
         Caption         =   "Stats"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3615
         Left            =   480
         TabIndex        =   7
         Tag             =   "1303"
         Top             =   840
         Width           =   4935
         Begin VB.TextBox txtStats 
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
            Index           =   7
            Left            =   2400
            TabIndex        =   16
            Text            =   "0"
            Top             =   2760
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   8
            Left            =   2400
            TabIndex        =   15
            Text            =   "0"
            Top             =   3120
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   6
            Left            =   2400
            TabIndex        =   14
            Text            =   "0"
            Top             =   2400
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   5
            Left            =   2400
            TabIndex        =   13
            Text            =   "0"
            Top             =   2040
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   4
            Left            =   2400
            TabIndex        =   12
            Text            =   "0"
            Top             =   1680
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   3
            Left            =   2400
            TabIndex        =   11
            Text            =   "0"
            Top             =   1320
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   2
            Left            =   2400
            TabIndex        =   10
            Text            =   "0"
            Top             =   960
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   1
            Left            =   2400
            TabIndex        =   9
            Text            =   "0"
            Top             =   600
            Width           =   2175
         End
         Begin VB.TextBox txtStats 
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
            Index           =   0
            Left            =   2400
            TabIndex        =   8
            Text            =   "Undefined"
            Top             =   240
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting Max S Move Power:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   8
            Left            =   120
            TabIndex        =   25
            Tag             =   "1312"
            Top             =   2760
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting Level:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   7
            Left            =   120
            TabIndex        =   24
            Tag             =   "1311"
            Top             =   3120
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting S Move Power:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   6
            Left            =   120
            TabIndex        =   23
            Tag             =   "1310"
            Top             =   2400
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting FP:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   5
            Left            =   120
            TabIndex        =   22
            Tag             =   "1309"
            Top             =   2040
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting DP:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   4
            Left            =   120
            TabIndex        =   21
            Tag             =   "1308"
            Top             =   1680
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Initial Max Health:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   3
            Left            =   120
            TabIndex        =   20
            Tag             =   "1307"
            Top             =   1320
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting Health:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   2
            Left            =   120
            TabIndex        =   19
            Tag             =   "1306"
            Top             =   960
            Width           =   2175
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Starting Experience:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   1
            Left            =   120
            TabIndex        =   18
            Tag             =   "1305"
            Top             =   600
            Width           =   2175
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Character Name:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   0
            Left            =   120
            TabIndex        =   17
            Tag             =   "1304"
            Top             =   240
            Width           =   2175
         End
      End
      Begin VB.Frame frVariables 
         Caption         =   "Variables"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3615
         Left            =   480
         TabIndex        =   26
         Tag             =   "1316"
         Top             =   840
         Width           =   4935
         Begin VB.TextBox txtVariables 
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
            Index           =   0
            Left            =   2160
            TabIndex        =   54
            Text            =   "Undefined"
            Top             =   240
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Left            =   3840
            TabIndex        =   53
            ToolTipText     =   "Use the default form of the variable"
            Top             =   240
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   7
            Left            =   3840
            TabIndex        =   42
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   2760
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   7
            Left            =   2160
            TabIndex        =   41
            Text            =   "Undefined!"
            Top             =   2760
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   8
            Left            =   3840
            TabIndex        =   40
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   3120
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   8
            Left            =   2160
            TabIndex        =   39
            Text            =   "Undefined!"
            Top             =   3120
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   6
            Left            =   3840
            TabIndex        =   38
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   2400
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   6
            Left            =   2160
            TabIndex        =   37
            Text            =   "Undefined!"
            Top             =   2400
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   3
            Left            =   3840
            TabIndex        =   36
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   1320
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   3
            Left            =   2160
            TabIndex        =   35
            Text            =   "Undefined!"
            Top             =   1320
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   5
            Left            =   3840
            TabIndex        =   34
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   2040
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   5
            Left            =   2160
            TabIndex        =   33
            Text            =   "Undefined!"
            Top             =   2040
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   4
            Left            =   3840
            TabIndex        =   32
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   1680
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   4
            Left            =   2160
            TabIndex        =   31
            Text            =   "Undefined!"
            Top             =   1680
            Width           =   1575
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Index           =   2
            Left            =   3840
            TabIndex        =   30
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   960
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.CheckBox chkDefault 
            Caption         =   "Default"
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
            Left            =   3840
            TabIndex        =   29
            Tag             =   "1317"
            ToolTipText     =   "Use the default form of the variable"
            Top             =   600
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   2
            Left            =   2160
            TabIndex        =   28
            Text            =   "Undefined!"
            Top             =   960
            Width           =   1575
         End
         Begin VB.TextBox txtVariables 
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
            Index           =   1
            Left            =   2160
            TabIndex        =   27
            Text            =   "Undefined!"
            Top             =   600
            Width           =   1575
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Max S Move Power Var:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   9
            Left            =   120
            TabIndex        =   51
            Tag             =   "1326"
            Top             =   2760
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Level Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   8
            Left            =   120
            TabIndex        =   50
            Tag             =   "1325"
            Top             =   3120
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Special Move Power Var:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   7
            Left            =   120
            TabIndex        =   49
            Tag             =   "1324"
            Top             =   2400
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Max Health Var:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   5
            Left            =   120
            TabIndex        =   48
            Tag             =   "1323"
            Top             =   1320
            Width           =   1935
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Character Name Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   0
            Left            =   120
            TabIndex        =   47
            Tag             =   "1322"
            Top             =   240
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fight Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   4
            Left            =   120
            TabIndex        =   46
            Tag             =   "1321"
            Top             =   2040
            Width           =   1935
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Defence Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   3
            Left            =   120
            TabIndex        =   45
            Tag             =   "1320"
            Top             =   1680
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Health Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   2
            Left            =   120
            TabIndex        =   44
            Tag             =   "1319"
            Top             =   960
            Width           =   1815
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Exp Variable:"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   1
            Left            =   120
            TabIndex        =   43
            Tag             =   "1318"
            Top             =   600
            Width           =   1815
         End
      End
      Begin MSComctlLib.TabStrip tabCharacter 
         Height          =   4335
         Left            =   240
         TabIndex        =   52
         Top             =   360
         Width           =   5415
         _ExtentX        =   9551
         _ExtentY        =   7646
         _Version        =   393216
         BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
            NumTabs         =   2
            BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Stats"
               Object.Tag             =   "1303"
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Advanced"
               Object.Tag             =   "2048"
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
   Begin VB.Menu charfilemenu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu mnunewproject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnunew 
         Caption         =   "New..."
         Begin VB.Menu mnunewtile 
            Caption         =   "Tile"
         End
         Begin VB.Menu mnunewanimatedtile 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu mnunewboard 
            Caption         =   "Board"
         End
         Begin VB.Menu mnunewplayer 
            Caption         =   "Player"
         End
         Begin VB.Menu mnunewitem 
            Caption         =   "Item"
         End
         Begin VB.Menu mnunewenemy 
            Caption         =   "Enemy"
         End
         Begin VB.Menu mnunewrpgcodeprogram 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu mnunewspecialmove 
            Caption         =   "Special Move"
         End
         Begin VB.Menu mnunewstatuseffect 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu mnunewanimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnunewtilebitmap 
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
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save Character"
         Shortcut        =   ^S
         Tag             =   "1329"
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "Save Character As"
         Shortcut        =   ^A
         Tag             =   "1330"
      End
      Begin VB.Menu mnusaveall 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuexit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnutestgame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuselectlanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuinstallupgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnubuild 
      Caption         =   "Build"
      Begin VB.Menu mnucreatepakfile 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu mnumakeexe 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub4 
         Caption         =   "-"
      End
      Begin VB.Menu mnucreatesetup 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu mnushowtools 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu mnushowprojectlist 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnutilehorizontally 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu mnutilevertically 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu mnucascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuarrangeicons 
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
      Begin VB.Menu mnurpgcodeprimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnurpgcodereference 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnututorial 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub9 
         Caption         =   "-"
      End
      Begin VB.Menu mnuregistrationinfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuabout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "characteredit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

'==============================================================================
'Character Editor
'==============================================================================
'Cleaned up for 3.0.5 by Delano.

Option Explicit

Public dataIndex As Long    'Index into the vector of players maintained in CommonEnemy

'==============================================================================
'Identify type of form.
'==============================================================================
Public Function formType() As Long: On Error Resume Next
    formType = FT_CHARACTER
End Function

'==============================================================================
' Save the player file. Direct to Save As if untitled. Called from TkMain, etc.
'==============================================================================
Public Sub saveFile(): On Error Resume Next
    
    If playerList(activePlayerIndex).charFile = vbNullString Then
        'Untitled; prompt Save As.
        Me.Show
        Call mnuSaveAs_Click
        Exit Sub
    End If
    
    'Save the .tem file.
    Call saveChar(projectPath & temPath & playerList(activePlayerIndex).charFile, playerList(activePlayerIndex).theData)
    
    'Player file is up to date.
    playerList(activePlayerIndex).charNeedUpdate = False

End Sub

'==============================================================================
' Open character file. e.g., from File Tree or Main Form methods.
'==============================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next

    Dim antiPath As String
    
    activePlayer.Show
    
    antiPath = RemovePath(file)
    FileCopy file, projectPath & temPath & antiPath
    
    Call PlayerClear(playerList(activePlayerIndex).theData)
    Call openChar(file, playerList(activePlayerIndex).theData)
    
    activePlayer.Caption = LoadStringLoc(804, "Character Editor") & "  (" & antiPath & ")"
    playerList(activePlayerIndex).charFile = antiPath
    
    Dim i As Integer
    For i = 0 To chkDefault.UBound
        chkDefault(i).value = 0
    Next i
    
    Call infoFill
    
    playerList(activePlayerIndex).charNeedUpdate = False
    
End Sub

'==============================================================================
' "Default" check box array: set variables to default form.
'==============================================================================
Private Sub chkDefault_Click(Index As Integer): On Error Resume Next

    'If unchecked, exit.
    If chkDefault(Index).value = 0 Then Exit Sub

    Dim varname As String

    'Select the variable ending for the specific index.
    With playerList(activePlayerIndex).theData
        Select Case Index
        
            Case 0: varname = "[name]$"
            Case 1: varname = "[experience]!"
            Case 2: varname = "[health]!"
            Case 3: varname = "[maxhealth]!"
            Case 4: varname = "[defence]!"
            Case 5: varname = "[fight]!"
            Case 6: varname = "[smpower]!"
            Case 7: varname = "[maxsm]!"
            Case 8: varname = "[level]!"
            
        End Select
    End With
    
    'Change the associated text box to the default name.
    ' e.g. Frap[name]$
    'This will trigger txt*_change and alter the member variables also.
    txtVariables(Index).Text = addUnderscore(playerList(activePlayerIndex).theData.charname) & varname

End Sub

'==============================================================================
'File -> Save Character
'==============================================================================
Private Sub mnusave_Click(): On Error Resume Next

    If playerList(activePlayerIndex).charFile = vbNullString Then
        Call mnuSaveAs_Click
        Exit Sub
    End If
    
    Call saveChar(projectPath & temPath & playerList(activePlayerIndex).charFile, playerList(activePlayerIndex).theData)
    
    playerList(activePlayerIndex).charNeedUpdate = False

End Sub

'==============================================================================
'File -> Save Character As
'==============================================================================
Private Sub mnuSaveAs_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo
    ChDir (currentDir)
    
    dlg.strDefaultFolder = projectPath & temPath
    dlg.strTitle = "Save Character As (Archives cannot be used with characters!)"
    dlg.strDefaultExt = "tem"
    dlg.strFileTypes = "RPG Toolkit Character (*.tem)|*.tem|All files(*.*)|*.*"
    
    'Prompt for overwrite.
    If Not (SaveFileDialog(dlg, Me.hwnd, True)) Then Exit Sub
    If dlg.strSelectedFile = vbNullString Then Exit Sub
    
    ChDir (currentDir)
    
    'Write the file.
    Call saveChar(dlg.strSelectedFile, playerList(activePlayerIndex).theData)
    
    playerList(activePlayerIndex).charFile = dlg.strSelectedFileNoPath
    
    activePlayer.Caption = LoadStringLoc(804, "Character Editor") & " (" & dlg.strSelectedFileNoPath & ")"
    
    'File is up to date.
    playerList(activePlayerIndex).charNeedUpdate = False
    
    'Add file to the tree.
    Call tkMainForm.fillTree("", projectPath)

End Sub

'==============================================================================
'File -> Close
'==============================================================================
Private Sub mnuClose_Click(): On Error Resume Next

    Unload editcharsm
    Unload charequip
    Unload charlevels
    Unload characteredit

End Sub

'==============================================================================
'Select the player's profile.
'==============================================================================
Private Sub cmdProfile_Click(): On Error Resume Next

    ChDir (currentDir)
    
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & bmpPath
    dlg.strTitle = "Select Profile Picture"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterWithTiles
    
    If Not (OpenFileDialog(dlg, Me.hwnd)) Then Exit Sub    'User pressed cancel.
    If dlg.strSelectedFile = vbNullString Then Exit Sub
    
    ChDir (currentDir)
    
    Call FileCopy(dlg.strSelectedFile, projectPath & bmpPath & dlg.strSelectedFileNoPath)
    
    'Draw the image, scaled to 64x64.
    Call DrawSizedImage(projectPath & bmpPath & dlg.strSelectedFileNoPath, 0, 0, 64, 64, profile.hdc)
    profile.Refresh
    
    playerList(activePlayerIndex).theData.profilePic = dlg.strSelectedFileNoPath
    playerList(activePlayerIndex).charNeedUpdate = True
    
End Sub

'==============================================================================
'Alter characters' special moves.
'==============================================================================
Private Sub cmdSpecialMoves_Click(): On Error Resume Next

    playerList(activePlayerIndex).charNeedUpdate = True
    editcharsm.Show vbModal ', me

End Sub

'==============================================================================
'Alter characters' graphics.
'==============================================================================
Private Sub cmdGraphics_Click(): On Error Resume Next

    playerList(activePlayerIndex).charNeedUpdate = True
    characterGraphics.Show vbModal

End Sub

'==============================================================================
'Alter characters' equipment.
'==============================================================================
Private Sub cmdEquipment_Click(): On Error Resume Next

    playerList(activePlayerIndex).charNeedUpdate = True
    charequip.Show vbModal ', me

End Sub

'==============================================================================
'Alter characters' levels.
'==============================================================================
Private Sub cmdLevels_Click(): On Error Resume Next

    playerList(activePlayerIndex).charNeedUpdate = True
    charlevels.Show vbModal ', me

End Sub

'==============================================================================
'Click on the profile picture box: change picture.
'==============================================================================
Private Sub profile_Click(): On Error Resume Next
    Call cmdProfile_Click
End Sub

'==============================================================================
'Form
'==============================================================================
Private Sub Form_Activate(): On Error Resume Next

    Set activePlayer = Me
    Set activeForm = Me
    activePlayerIndex = dataIndex
    Call hideAllTools
    
End Sub

Private Sub Form_Load(): On Error Resume Next

    Call LocalizeForm(Me)
    Call LocalizeTabStrip(tabCharacter)
    
    Set activePlayer = Me
    
    dataIndex = VectPlayerNewSlot()
    activePlayerIndex = dataIndex
    
    Call PlayerClear(playerList(dataIndex).theData)
       
    Call infoFill

End Sub

Private Sub Form_Resize(): On Error Resume Next

    mainFrame.Left = (Me.width - mainFrame.width) / 2
    mainFrame.Top = (Me.height - mainFrame.height - 500) / 2

End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    
    'See if the board needs saving:
    If playerList(activePlayerIndex).charNeedUpdate Then
        
        'Use caption to set "Untitled" for blank boards.
        Dim answer As VbMsgBoxResult
        answer = MsgBox("Save changes to " & insideBrackets(Me.Caption) & "?", vbYesNoCancel + vbQuestion)
        
        If answer = vbCancel Then
            
            'Cancel unload.
            Cancel = 1
            Exit Sub
            
        ElseIf answer = vbYes Then
        
            'Save the file; prompt for untitled.
            Call saveFile
            
        End If
    
    End If
    
    Call hideAllTools
    
End Sub

'==============================================================================
'Fill the form entries with the player data.
'==============================================================================
Private Sub infoFill(): On Error Resume Next

    With playerList(activePlayerIndex).theData
    
        If .profilePic <> "" Then
            Call DrawSizedImage(projectPath & bmpPath & .profilePic, 0, 0, 64, 64, profile.hdc)
            profile.Refresh
        End If
    
        If .nameVar <> "" Then txtVariables(0).Text = .nameVar Else txtVariables(0).Text = "Undefined!"
        If .experienceVar <> "" Then txtVariables(1).Text = .experienceVar Else txtVariables(1).Text = "Undefined$"
        If .healthVar <> "" Then txtVariables(2).Text = .healthVar Else txtVariables(2).Text = "Undefined!"
        If .maxHealthVar <> "" Then txtVariables(3).Text = .maxHealthVar Else txtVariables(3).Text = "Undefined!"
        If .defenseVar <> "" Then txtVariables(4).Text = .defenseVar Else txtVariables(4).Text = "Undefined!"
        If .fightVar <> "" Then txtVariables(5).Text = .fightVar Else txtVariables(5).Text = "Undefined!"
        If .smVar <> "" Then txtVariables(6).Text = .smVar Else txtVariables(6).Text = "Undefined!"
        If .smMaxVar <> "" Then txtVariables(7).Text = .smMaxVar Else txtVariables(7).Text = "Undefined!"
        If .leVar <> "" Then txtVariables(8).Text = .leVar Else txtVariables(8).Text = "Undefined!"

        If .charname <> "" Then txtStats(0).Text = playerList(activePlayerIndex).theData.charname Else txtStats(0).Text = "Undefined"
        txtStats(1).Text = .initExperience
        txtStats(2).Text = .initHealth
        txtStats(3).Text = .initMaxHealth
        txtStats(4).Text = .initDefense
        txtStats(5).Text = .initFight
        txtStats(6).Text = .initSm
        txtStats(7).Text = .initSmMax
        txtStats(8).Text = .initLevel
    
    End With
        
End Sub

'==============================================================================
'Array of initial stat text boxes.
'==============================================================================
Private Sub txtStats_Change(Index As Integer): On Error Resume Next

    With playerList(activePlayerIndex).theData
        Select Case Index
        
            Case 0
                    playerList(activePlayerIndex).theData.charname = txtStats(0).Text
            
                    'Create RPGCode variables containing the character name.
                    Dim i As Integer
                    For i = 0 To chkDefault.UBound
                        Call chkDefault_Click(i)
                    Next i

            Case 1: .initExperience = val(txtStats(1).Text)
            Case 2: .initHealth = val(txtStats(2).Text)
            Case 3: .initMaxHealth = val(txtStats(3).Text)
            Case 4: .initDefense = val(txtStats(4).Text)
            Case 5: .initFight = val(txtStats(5).Text)
            Case 6: .initSm = val(txtStats(6).Text)
            Case 7: .initSmMax = val(txtStats(7).Text)
            Case 8: .initLevel = val(txtStats(8).Text)
            
        End Select
    End With

    playerList(activePlayerIndex).charNeedUpdate = True

End Sub

'==============================================================================
'Array of variable text boxes.
'==============================================================================
Private Sub txtVariables_Change(Index As Integer): On Error Resume Next

    With playerList(activePlayerIndex).theData
        Select Case Index
        
            Case 0: .nameVar = txtVariables(0).Text
            Case 1: .experienceVar = txtVariables(1).Text
            Case 2: .healthVar = txtVariables(2).Text
            Case 3: .maxHealthVar = txtVariables(3).Text
            Case 4: .defenseVar = txtVariables(4).Text
            Case 5: .fightVar = txtVariables(5).Text
            Case 6: .smVar = txtVariables(6).Text
            Case 7: .smMaxVar = txtVariables(7).Text
            Case 8: .leVar = txtVariables(8).Text
            
        End Select
    End With

    playerList(activePlayerIndex).charNeedUpdate = True

End Sub

'==============================================================================
'Tab strip
'==============================================================================
Private Sub tabCharacter_Click(): On Error Resume Next

    frStats.Visible = False
    frVariables.Visible = False

    Select Case tabCharacter.SelectedItem.Index
        Case 1:
            frStats.Visible = True
        Case 2:
            frVariables.Visible = True
    End Select
End Sub

'==============================================================================
'TkMain menu items
'==============================================================================
Private Sub mnutilehorizontally_Click(): On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub

Private Sub mnutilevertically_Click(): On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub

Private Sub mnuTutorial_Click(): On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

Private Sub mnuusersguide_Click(): On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

Private Sub mnuAbout_Click(): On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub

Private Sub mnuArrangeIcons_Click(): On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub

Private Sub mnuCascade_Click(): On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub

Private Sub mnucreatepakfile_Click(): On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub

Private Sub mnucreatesetup_Click(): On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub

Private Sub mnuexit_Click(): On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub

Private Sub mnuHistorytxt_Click(): On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub

Private Sub mnuinstallupgrade_Click(): On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub

Private Sub mnumakeexe_Click(): On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub

Private Sub mnunewanimatedtile_Click(): On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub

Private Sub mnunewanimation_Click(): On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub

Private Sub mnunewboard_Click(): On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub

Private Sub mnunewenemy_Click(): On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub

Private Sub mnunewitem_Click(): On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub

Private Sub mnunewplayer_Click(): On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub

Private Sub mnunewproject_Click(): On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub

Private Sub mnunewrpgcodeprogram_Click(): On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub

Private Sub mnunewspecialmove_Click(): On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub

Private Sub mnunewstatuseffect_Click(): On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub

Private Sub mnunewtile_Click(): On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub

Private Sub mnunewtilebitmap_Click(): On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub

Private Sub mnuopen_Click(): On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub

Private Sub mnuRegistrationInfo_Click(): On Error Resume Next
    Call tkMainForm.registrationinfomnu_Click
End Sub

Private Sub mnuRPGCodePrimer_Click(): On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub

Private Sub mnurpgcodereference_Click(): On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub

Private Sub mnusaveall_Click(): On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub

Private Sub mnuselectlanguage_Click(): On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub

Private Sub mnushowprojectlist_Click(): On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub

Private Sub mnushowtools_Click(): On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub

Private Sub mnutestgame_Click(): On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub

Private Sub mnuOpenProject_Click(): On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

Private Sub mnuNewFightBackground_Click(): On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub
