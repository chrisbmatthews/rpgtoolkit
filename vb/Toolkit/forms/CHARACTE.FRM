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
      Begin VB.CommandButton Command5 
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
      Begin VB.CommandButton Command4 
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
      Begin VB.CommandButton Command3 
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
      Begin VB.CommandButton Command2 
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
      Begin VB.Frame Frame3 
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
         Begin VB.CheckBox maxsmdefault 
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
            Left            =   3840
            TabIndex        =   44
            Tag             =   "1317"
            Top             =   2760
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox maxsmvar 
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
            Left            =   2160
            TabIndex        =   43
            Text            =   "Undefined!"
            Top             =   2760
            Width           =   1575
         End
         Begin VB.CheckBox leveldefault 
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
            Left            =   3840
            TabIndex        =   42
            Tag             =   "1317"
            Top             =   3120
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox levelvar 
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
            Left            =   2160
            TabIndex        =   41
            Text            =   "Undefined!"
            Top             =   3120
            Width           =   1575
         End
         Begin VB.CheckBox smdefault 
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
            Left            =   3840
            TabIndex        =   40
            Tag             =   "1317"
            Top             =   2400
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox smpowervar 
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
            Left            =   2160
            TabIndex        =   39
            Text            =   "Undefined!"
            Top             =   2400
            Width           =   1575
         End
         Begin VB.CheckBox maxhealthdefault 
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
            Left            =   3840
            TabIndex        =   38
            Tag             =   "1317"
            Top             =   1320
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox maxhealthbox 
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
            Left            =   2160
            TabIndex        =   37
            Text            =   "Undefined!"
            Top             =   1320
            Width           =   1575
         End
         Begin VB.CheckBox namedefault 
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
            Left            =   3840
            TabIndex        =   36
            Tag             =   "1317"
            Top             =   240
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox namevarbox 
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
            Left            =   2160
            TabIndex        =   35
            Text            =   "Undefined$"
            Top             =   240
            Width           =   1575
         End
         Begin VB.CheckBox fightdefault 
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
            Left            =   3840
            TabIndex        =   34
            Tag             =   "1317"
            Top             =   2040
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox fightbox 
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
            Left            =   2160
            TabIndex        =   33
            Text            =   "Undefined!"
            Top             =   2040
            Width           =   1575
         End
         Begin VB.CheckBox defencedefault 
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
            Left            =   3840
            TabIndex        =   32
            Tag             =   "1317"
            Top             =   1680
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox defensebox 
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
            Left            =   2160
            TabIndex        =   31
            Text            =   "Undefined!"
            Top             =   1680
            Width           =   1575
         End
         Begin VB.CheckBox healthdefault 
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
            Left            =   3840
            TabIndex        =   30
            Tag             =   "1317"
            Top             =   960
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.CheckBox expdefault 
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
            Left            =   3840
            TabIndex        =   29
            Tag             =   "1317"
            Top             =   600
            Value           =   1  'Checked
            Width           =   855
         End
         Begin VB.TextBox healthbox 
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
            Left            =   2160
            TabIndex        =   28
            Text            =   "Undefined!"
            Top             =   960
            Width           =   1575
         End
         Begin VB.TextBox expbox 
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
            TabIndex        =   53
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
            TabIndex        =   52
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
            TabIndex        =   51
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
            TabIndex        =   50
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
            TabIndex        =   49
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
            TabIndex        =   48
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
            TabIndex        =   47
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
            TabIndex        =   46
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
            TabIndex        =   45
            Tag             =   "1318"
            Top             =   600
            Width           =   1815
         End
      End
      Begin VB.Frame Frame2 
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
         Begin VB.TextBox smmaxinit 
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
            TabIndex        =   16
            Text            =   "0"
            Top             =   2760
            Width           =   2175
         End
         Begin VB.TextBox initlevel1 
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
            TabIndex        =   15
            Text            =   "0"
            Top             =   3120
            Width           =   2175
         End
         Begin VB.TextBox sminit 
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
            TabIndex        =   14
            Text            =   "0"
            Top             =   2400
            Width           =   2175
         End
         Begin VB.TextBox fightstart 
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
            TabIndex        =   13
            Text            =   "0"
            Top             =   2040
            Width           =   2175
         End
         Begin VB.TextBox defencestart 
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
            TabIndex        =   12
            Text            =   "0"
            Top             =   1680
            Width           =   2175
         End
         Begin VB.TextBox maxhealthstart 
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
            TabIndex        =   11
            Text            =   "0"
            Top             =   1320
            Width           =   2175
         End
         Begin VB.TextBox starthealth 
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
            TabIndex        =   10
            Text            =   "0"
            Top             =   960
            Width           =   2175
         End
         Begin VB.TextBox startexp 
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
            TabIndex        =   9
            Text            =   "0"
            Top             =   600
            Width           =   2175
         End
         Begin VB.TextBox namebox 
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
      Begin VB.PictureBox profile 
         AutoRedraw      =   -1  'True
         Height          =   975
         Left            =   6120
         ScaleHeight     =   61
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   61
         TabIndex        =   6
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton Command1 
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
      Begin MSComctlLib.TabStrip TabStrip1 
         Height          =   4335
         Left            =   240
         TabIndex        =   54
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
      Begin VB.Menu savecharmenu 
         Caption         =   "Save Character"
         Shortcut        =   ^S
         Tag             =   "1329"
      End
      Begin VB.Menu scharasmnu 
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
      Begin VB.Menu clsemnu 
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
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private advancedOn As Boolean


Public dataIndex As Long    'index into the vector of players maintained in commonenemy


Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_CHARACTER
End Function


Public Sub saveAsFile()
    'saves the file.
    On Error GoTo ErrorHandler
    If playerList(activePlayerIndex).charNeedUpdate = True Then
        Me.Show
        scharasmnu_Click
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub



Public Sub checkSave()
    'check if the file has changed an it needs to be saved...
    On Error GoTo ErrorHandler
    If playerList(activePlayerIndex).charNeedUpdate = True Then
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo, LoadStringLoc(950, "Save file"))
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

Public Sub saveFile()
    'saves the file.
    On Error GoTo ErrorHandler
    'If playerList(activePlayerIndex).charNeedUpdate = True Then
        filename$(2) = playerList(activePlayerIndex).charFile$
        playerList(activePlayerIndex).charNeedUpdate = False
        filename$(2) = playerList(activePlayerIndex).charFile$
        If filename$(2) = "" Then
            Me.Show
            Call scharasmnu_Click
            Exit Sub
        End If
        Call savechar(projectPath$ + temPath$ + filename$(2), playerList(activePlayerIndex).theData)
    'End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub openFile(file$)
    On Error Resume Next
    'Call checkSave
    activePlayer.Show
    filename$(1) = file$
    antiPath$ = absNoPath(file$)
    FileCopy filename$(1), projectPath$ + temPath$ + antiPath$
    Call clearchar
    Call openchar(filename$(1), playerList(activePlayerIndex).theData)
    activePlayer.Caption = LoadStringLoc(804, "Character Editor") + "  (" + antiPath$ + ")"
    playerList(activePlayerIndex).charFile$ = antiPath$
    namedefault.value = False
    maxhealthdefault.value = False
    expdefault.value = False
    healthdefault.value = False
    defencedefault.value = False
    fightdefault.value = False
    smdefault.value = False
    maxsmdefault.value = False
    leveldefault.value = False
    
    Call infofill
    playerList(activePlayerIndex).charNeedUpdate = False
End Sub



Private Sub clearchar()
    On Error GoTo ErrorHandler
    filename$(2) = ""
    Call PlayerClear(playerList(activePlayerIndex).theData)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub clsemnu_Click()
    On Error GoTo ErrorHandler
    Unload editcharsm
    'Unload chargfx
    Unload charequip
    Unload charlevels
    Unload characteredit

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    dlg.strTitle = "Open Profile"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterWithTiles
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    playerList(activePlayerIndex).charNeedUpdate = True
    Call vbPicFillRect(profile, 0, 0, 1000, 1000, vbQBColor(15))
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
    
    picname$ = antiPath$
    Call drawprofile(projectPath$ + bmpPath$ + picname$)
    playerList(activePlayerIndex).theData.profilePic$ = picname$
End Sub

Private Sub Command2_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    editcharsm.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    'If charSizeType = 0 Then
    '    chargfx.Show
    'Else
    '    chargfx2.Show vbModal ', me
    'End If
    characterGraphics.Show vbModal

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    charequip.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command5_Click()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    charlevels.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    advancedOn = Not (advancedOn)
    If advancedOn Then
        Command6.Caption = LoadStringLoc(911, "Advanced <<")
        activePlayer.Width = 9600
    Else
        Command6.Caption = LoadStringLoc(912, "Advanced >>")
        activePlayer.Width = 4440
    End If
End Sub

Private Sub defencestart_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initDefense = val(defencestart.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub defensebox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.defenseVar$ = defensebox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub drawprofile(file$)
On Error Resume Next
ReDim supertile(64, 64)
    profile.Picture = LoadPicture("")
    'PicClip1.Picture = LoadPicture("")
    If file$ = "" Then Exit Sub
    Call vbPicAutoRedraw(profile, True)
    thextention$ = extention(file$)
    'If UCase$(thextention$) = "GIF" Then
    '    dummy = GifToBMP(filename$(1), "rpgscrtc.bmp")
    '    picname$ = filename$(1)
    '    profile.Picture = LoadPicture("rpgscrtc.bmp")
    'End If
    'If UCase$(thextention$) <> "GPH" Then
    '    profile.Picture = LoadPicture(file$)
    '    picname$ = filename$(1)
    'End If
    If UCase$(thextention$) = "GPH" Then
        'Backup the tile in memory
        openTileEditorDocs(activeTile.indice).oldDetail = detail
        For xx = 1 To 32
            For yy = 1 To 32
                bufTile(xx, yy) = tileMem(xx, yy)
            Next yy
        Next xx
        
        
        'Open new tile
        Call openWinTile(file$)
        If detail = 2 Then Call increaseDetail
        'Resize to 64x64
        xx = 1: yy = 1
        For X = 1 To 32
            For Y = 1 To 32
                supertile(xx, yy) = tileMem(X, Y)
                supertile(xx, yy + 1) = tileMem(X, Y)
                supertile(xx + 1, yy) = tileMem(X, Y)
                supertile(xx + 1, yy + 1) = tileMem(X, Y)
                yy = yy + 2
            Next Y
            yy = 1
            xx = xx + 2
        Next X
        For xx = 1 To 32
            For yy = 1 To 32
                tileMem(xx, yy) = bufTile(xx, yy)
            Next yy
        Next xx
        detail = openTileEditorDocs(activeTile.indice).oldDetail
        
        'Now that we've properly resized the GPH, draw it:
        For X = 1 To 64
            For Y = 1 To 64
                If supertile(X, Y) <> -1 Then
                    Call vbPicPSet(profile, X - 1, Y - 1, supertile(X, Y))
                End If
            Next Y
        Next X
        picname$ = filename$(1)
    Else
        'PicClip1.Picture = LoadPicture(file$)
        'PicClip1.ClipX = 0
        'PicClip1.ClipY = 0
        'PicClip1.ClipHeight = PicClip1.height
        'PicClip1.ClipWidth = PicClip1.width
        'PicClip1.StretchX = 64
        'PicClip1.StretchY = 64
        'profile.Picture = PicClip1.Clip
        'profile.Picture = LoadPicture(file$)
        Call vbPicAutoRedraw(profile, True)
        Call DrawSizedImage(file$, 0, 0, 64, 64, vbPicHDC(profile))
        Call vbPicRefresh(profile)
    End If

End Sub

Private Sub expbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.experienceVar$ = expbox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fightbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.fightVar$ = fightbox.Text


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fightstart_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initFight = val(fightstart.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    
    Set activePlayer = Me
    Set activeForm = Me
    activePlayerIndex = dataIndex
    
    'extras
    tkMainForm.animationExtras.Visible = False
    tkMainForm.bottomFrame.Visible = False
    tkMainForm.tileExtras.Visible = False
    tkMainForm.tileBmpExtras.Visible = False
    
    'tools
    tkMainForm.tilebmpTools.Visible = False
    tkMainForm.animationTools.Visible = False
    tkMainForm.rpgcodeTools.Visible = False
    tkMainForm.tileTools.Visible = False
    tkMainForm.tileTools.Top = tkMainForm.toolTop
    tkMainForm.boardTools.Visible = False
    
    filename$(2) = ""
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    Call LocalizeTabStrip(TabStrip1)
    
    Set activePlayer = Me
    dataIndex = VectPlayerNewSlot()
    activePlayerIndex = dataIndex
    Call PlayerClear(playerList(dataIndex).theData)
       
    Y = Screen.height
    X = Screen.height * (1 / 0.75)
    mainX = activePlayer.Width
    mainY = activePlayer.height
    dx = (X - mainX) / 2
    dy = (Y - mainY) / 2
    activePlayer.Top = dy
    activePlayer.Left = dx
    
    filename$(2) = ""
    Call infofill
    Frame2.Visible = True
    Frame3.Visible = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    'mainFrame.Left = (Me.width - mainFrame.width) / 2
    'mainFrame.Top = (Me.height - mainFrame.height) / 2
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub healthbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.healthVar$ = healthbox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo ErrorHandler
    Call drawprofile(projectPath$ + bmpPath$ + playerList(activePlayerIndex).theData.profilePic$)
    If playerList(activePlayerIndex).theData.charname$ <> "" Then namebox.Text = playerList(activePlayerIndex).theData.charname$ Else namebox.Text = "Undefined"
    If playerList(activePlayerIndex).theData.experienceVar$ <> "" Then expbox.Text = playerList(activePlayerIndex).theData.experienceVar$ Else expbox.Text = "Undefined$"
    If playerList(activePlayerIndex).theData.healthVar$ <> "" Then healthbox.Text = playerList(activePlayerIndex).theData.healthVar$ Else healthbox.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.defenseVar$ <> "" Then defensebox.Text = playerList(activePlayerIndex).theData.defenseVar$ Else defensebox.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.fightVar$ <> "" Then fightbox.Text = playerList(activePlayerIndex).theData.fightVar$ Else fightbox.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.nameVar$ <> "" Then namevarbox.Text = playerList(activePlayerIndex).theData.nameVar$ Else namevarbox.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.maxHealthVar$ <> "" Then maxhealthbox = playerList(activePlayerIndex).theData.maxHealthVar$ Else maxhealthbox.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.smVar$ <> "" Then smpowervar = playerList(activePlayerIndex).theData.smVar$ Else smpowervar.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.smMaxVar$ <> "" Then maxsmvar.Text = playerList(activePlayerIndex).theData.smMaxVar$ Else maxsmvar.Text = "Undefined!"
    If playerList(activePlayerIndex).theData.leVar$ <> "" Then levelvar.Text = playerList(activePlayerIndex).theData.leVar$ Else levelvar.Text = "Undefined!"

    startexp.Text = playerList(activePlayerIndex).theData.initExperience
    starthealth.Text = playerList(activePlayerIndex).theData.initHealth
    maxhealthstart.Text = playerList(activePlayerIndex).theData.initMaxHealth
    defencestart.Text = playerList(activePlayerIndex).theData.initDefense
    fightstart.Text = playerList(activePlayerIndex).theData.initFight
    sminit.Text = playerList(activePlayerIndex).theData.initSm
    smmaxinit.Text = playerList(activePlayerIndex).theData.initSmMax
    initlevel1.Text = playerList(activePlayerIndex).theData.initLevel
    If playerList(activePlayerIndex).theData.charSizeType = 0 Then
        Option1.value = True
    Else
        Option2.value = True
    End If
    'activePlayer.Caption = "Character Editor (" + filename$(2) + ")"
    'If filename$(2) = "" Then activePlayer.Caption = "Character Editor (Untitled)"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub initlevel1_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initLevel = val(initlevel1.Text)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub initsmmax_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.initSmMax = val(smmaxinit.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub levelvar_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.leVar$ = levelvar.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub maxhealthbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.maxHealthVar$ = maxhealthbox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub maxhealthstart_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initMaxHealth = val(maxhealthstart.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub maxsmvar_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.smMaxVar$ = maxsmvar.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub namebox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.charname$ = namebox.Text
    Temp$ = addUnderscore(playerList(activePlayerIndex).theData.charname$)
    If namedefault.value = 1 Then namevarbox.Text = Temp$ + "[name]$"
    If maxhealthdefault.value = 1 Then maxhealthbox.Text = Temp$ + "[maxhealth]!"
    If expdefault.value = 1 Then expbox.Text = Temp$ + "[experience]!"
    If healthdefault.value = 1 Then healthbox.Text = Temp$ + "[health]!"
    If defencedefault.value = 1 Then defensebox.Text = Temp$ + "[defence]!"
    If fightdefault.value = 1 Then fightbox.Text = Temp$ + "[fight]!"
    If smdefault.value = 1 Then smpowervar.Text = Temp$ + "[smpower]!"
    If maxsmdefault.value = 1 Then maxsmvar.Text = Temp$ + "[maxsm]!"
    If leveldefault.value = 1 Then levelvar.Text = Temp$ + "[level]!"
    playerList(activePlayerIndex).charNeedUpdate = True

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub namevarbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.nameVar$ = namevarbox.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub profile_Click()
    Call Command1_Click
End Sub

Private Sub savecharmenu_Click()
    On Error GoTo ErrorHandler
    filename$(2) = playerList(activePlayerIndex).charFile$
    If filename$(2) = "" Then Call scharasmnu_Click: Exit Sub
    Call savechar(projectPath$ + temPath$ + filename$(2), playerList(activePlayerIndex).theData)
    playerList(activePlayerIndex).charNeedUpdate = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub scharasmnu_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + temPath$
    dlg.strTitle = "Save Character As (Archives cannot be used with characters!)"
    dlg.strDefaultExt = "tem"
    dlg.strFileTypes = "RPG Toolkit Character (*.tem)|*.tem|All files(*.*)|*.*"
    If SaveFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    
    If filename$(1) = "" Then Exit Sub
    If fileExists(filename(1)) Then
        bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo, LoadStringLoc(950, "Save"))
        If bb = 7 Then Exit Sub
    End If
    
    Call savechar(filename$(1), playerList(activePlayerIndex).theData)
    playerList(activePlayerIndex).charFile$ = antiPath$
    activePlayer.Caption = LoadStringLoc(804, "Character Editor") + " (" + antiPath$ + ")"
    playerList(activePlayerIndex).charNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub

Private Sub sminit_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initSm = val(sminit.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smmaxinit_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initSmMax = val(smmaxinit.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub smpowervar_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.smVar$ = smpowervar.Text

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub startexp_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initExperience = val(startexp.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub starthealth_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).charNeedUpdate = True
    playerList(activePlayerIndex).theData.initHealth = val(starthealth.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub TabStrip1_Click()
    On Error Resume Next
    Frame2.Visible = False
    Frame3.Visible = False
'FIXIT: p1.SelectedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
'FIXIT: electedItem.Index property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
    Select Case TabStrip1.SelectedItem.Index
        Case 1:
            Frame2.Visible = True
        Case 2:
            Frame3.Visible = True
    End Select
End Sub

Private Sub toc_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

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

