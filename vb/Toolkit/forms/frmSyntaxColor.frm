VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmColoringOptions 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "RPGCode Editor Options"
   ClientHeight    =   3330
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4455
   Icon            =   "frmSyntaxColor.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3330
   ScaleWidth      =   4455
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Default         =   -1  'True
      Height          =   375
      Left            =   3120
      TabIndex        =   29
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Default"
      Height          =   375
      Left            =   3120
      TabIndex        =   28
      Top             =   720
      Width           =   1215
   End
   Begin TabDlg.SSTab Tabs 
      Height          =   2895
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   5106
      _Version        =   393216
      TabHeight       =   520
      BackColor       =   0
      TabCaption(0)   =   "Coloring"
      TabPicture(0)   =   "frmSyntaxColor.frx":000C
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "fraTab0"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "Misc"
      TabPicture(1)   =   "frmSyntaxColor.frx":0028
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "fraTab1"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Common"
      TabPicture(2)   =   "frmSyntaxColor.frx":0044
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "fraTab2"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).ControlCount=   1
      Begin VB.Frame fraTab2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2295
         Left            =   -74880
         TabIndex        =   21
         Top             =   480
         Width           =   2655
         Begin RichTextLib.RichTextBox codeForm 
            Height          =   1575
            Left            =   120
            TabIndex        =   24
            Top             =   600
            Width           =   2415
            _ExtentX        =   4260
            _ExtentY        =   2778
            _Version        =   393217
            Enabled         =   -1  'True
            ScrollBars      =   3
            Appearance      =   0
            TextRTF         =   $"frmSyntaxColor.frx":0060
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label lblNote2 
            BackColor       =   &H00FFFFFF&
            Caption         =   "Text to place at the start of each newly created program file:"
            Height          =   495
            Left            =   120
            TabIndex        =   23
            Top             =   120
            Width           =   2415
         End
         Begin VB.Shape Shape4 
            Height          =   2295
            Left            =   0
            Top             =   0
            Width           =   2655
         End
      End
      Begin VB.Frame fraTab1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2295
         Left            =   -74880
         TabIndex        =   20
         Top             =   480
         Width           =   2655
         Begin VB.Frame Frame1 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            Caption         =   "Auto Indentor         "
            ForeColor       =   &H80000008&
            Height          =   855
            Left            =   120
            TabIndex        =   22
            Top             =   240
            Width           =   2415
            Begin VB.PictureBox Picture1 
               BackColor       =   &H80000009&
               BorderStyle     =   0  'None
               Height          =   495
               Left            =   120
               ScaleHeight     =   495
               ScaleWidth      =   2175
               TabIndex        =   25
               Top             =   240
               Width           =   2175
               Begin VB.OptionButton optSpaces 
                  Appearance      =   0  'Flat
                  BackColor       =   &H80000005&
                  Caption         =   "Spaces"
                  ForeColor       =   &H80000008&
                  Height          =   255
                  Left            =   0
                  TabIndex        =   27
                  Top             =   0
                  Value           =   -1  'True
                  Width           =   975
               End
               Begin VB.OptionButton optTabs 
                  Appearance      =   0  'Flat
                  BackColor       =   &H80000005&
                  Caption         =   "Tabs"
                  ForeColor       =   &H80000008&
                  Height          =   255
                  Left            =   0
                  TabIndex        =   26
                  Top             =   240
                  Width           =   975
               End
            End
         End
         Begin VB.Shape Shape2 
            Height          =   2295
            Left            =   0
            Top             =   0
            Width           =   2655
         End
      End
      Begin VB.Frame fraTab0 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2295
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   2655
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H00FFFFFF&
            FillStyle       =   0  'Solid
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   0
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   7
            Top             =   120
            Width           =   615
         End
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   2
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   6
            Top             =   840
            Width           =   615
         End
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   3
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   5
            Top             =   1200
            Width           =   615
         End
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   4
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   4
            Top             =   1560
            Width           =   615
         End
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   5
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   3
            Top             =   1920
            Width           =   615
         End
         Begin VB.PictureBox shpColorPreview 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   1
            Left            =   1920
            MousePointer    =   99  'Custom
            ScaleHeight     =   225
            ScaleWidth      =   585
            TabIndex        =   2
            Top             =   480
            Width           =   615
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   8
            Top             =   480
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   2
            Left            =   1080
            TabIndex        =   9
            Top             =   840
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   3
            Left            =   1080
            TabIndex        =   10
            Top             =   1200
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   4
            Left            =   1080
            TabIndex        =   11
            Top             =   1560
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   5
            Left            =   1080
            TabIndex        =   12
            Top             =   1920
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin Toolkit.ctlBoldItalicUnderline BIU 
            Height          =   255
            Index           =   0
            Left            =   1080
            TabIndex        =   13
            Top             =   120
            Width           =   735
            _ExtentX        =   1296
            _ExtentY        =   450
         End
         Begin VB.Shape Shape1 
            Height          =   2295
            Left            =   0
            Top             =   0
            Width           =   2655
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "Commands"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   19
            Top             =   120
            Width           =   855
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "Comments"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   18
            Top             =   480
            Width           =   855
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "{ and }"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   17
            Top             =   840
            Width           =   855
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "Labels"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   16
            Top             =   1200
            Width           =   855
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "Parameters"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   4
            Left            =   120
            TabIndex        =   15
            Top             =   1560
            Width           =   855
         End
         Begin VB.Label lblColoringTypes 
            BackStyle       =   0  'Transparent
            Caption         =   "Variables"
            BeginProperty Font 
               Name            =   "Trebuchet MS"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   14
            Top             =   1920
            Width           =   855
         End
      End
   End
End
Attribute VB_Name = "frmColoringOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'This form allows the user to customize syntax coloring

Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()

 'Declarations...
 Dim a As Long

 'Save new settings to the registry...
 SaveSetting "RPGToolkit3", "Colors", "#", CStr(shpColorPreview(0).BackColor)
 SaveSetting "RPGToolkit3", "Colors", "*", CStr(shpColorPreview(1).BackColor)
 SaveSetting "RPGToolkit3", "Colors", "{}", CStr(shpColorPreview(2).BackColor)
 SaveSetting "RPGToolkit3", "Colors", ":", CStr(shpColorPreview(3).BackColor)
 SaveSetting "RPGToolkit3", "Colors", "()", CStr(shpColorPreview(4).BackColor)
 SaveSetting "RPGToolkit3", "Colors", "!$", CStr(shpColorPreview(5).BackColor)
 For a = 0 To 5
  SaveSetting "RPGToolkit3", "SyntaxBold", CStr(a), _
   CStr(booleanToLong(BIU(a).Bold))
  SaveSetting "RPGToolkit3", "SyntaxItalics", CStr(a), _
   CStr(booleanToLong(BIU(a).Italics))
  SaveSetting "RPGToolkit3", "SyntaxUnderline", CStr(a), _
   CStr(booleanToLong(BIU(a).Underline))
 Next a
 
 'Flag to have any open programs be re-colored...
 needsReColor = True
 programEditorCountDown = programEditorCount
 
 'Save other settings
 ' SaveSetting "RPGToolkit3", "PRG Editor", "Cap", chkCapital.value
 SaveSetting "RPGToolkit3", "PRG Editor", "Tabs", booleanToLong(optTabs.value)
 SaveSetting "RPGToolkit3", "PRG Editor", "Common", codeForm.Text
 
 'Unload this form...
 Unload Me
 
End Sub

Private Sub cmdDefault_Click()

 'Declarations...
 Dim a As Long

 'Set to default colors...
 shpColorPreview(0).BackColor = 8388608
 shpColorPreview(1).BackColor = 32768
 shpColorPreview(2).BackColor = 15490
 shpColorPreview(3).BackColor = 12632064
 shpColorPreview(4).BackColor = 0
 shpColorPreview(5).BackColor = 10223809
 
 'Remove all styling...
 For a = 0 To 5
  BIU(a).Bold = False
  BIU(a).Italics = False
  BIU(a).Underline = False
 Next a
 
 ' chkCapital.value = 1
 optTabs.value = True
 
End Sub

Private Sub cmdSave_Click()
 cmdOK_Click
End Sub

Private Sub Form_Activate()
 Dim a As Long
 For a = 0 To 5: shpColorPreview(a).MouseIcon = Images.MouseLink: Next a
End Sub

Private Sub Form_Load(): On Error Resume Next
    updateColors
    ' chkCapital.value = GetSetting("RPGToolkit3", "PRG Editor", "Cap", 1)
    If GetSetting("RPGToolkit3", "PRG Editor", "Tabs", 1) = 1 Then
        optTabs.value = True
    End If
    codeForm.Text = GetSetting("RPGToolkit3", "PRG Editor", "Common", "")
End Sub

Private Sub updateColors()
 
 'Declarations...
 Dim a As Long
 
 'Update the color previews in the boxes
 shpColorPreview(0).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", "#", "8388608"))
 shpColorPreview(1).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", "*", "32768"))
 shpColorPreview(2).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", "{}", "15490"))
 shpColorPreview(3).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", ":", "12632064"))
 shpColorPreview(4).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", "()", "0"))
 shpColorPreview(5).BackColor = CDbl(GetSetting("RPGToolkit3", "Colors", "!$", "10223809"))
 
 'Put the bold/italic/underline buttons in the right state...
 For a = 0 To 5
  BIU(a).Bold = integerToBoolean(CInt(GetSetting("RPGToolkit3", _
   "SyntaxBold", CStr(a), 0)))
  BIU(a).Italics = integerToBoolean(CInt(GetSetting("RPGToolkit3", _
   "SyntaxItalics", CStr(a), 0)))
  BIU(a).Underline = integerToBoolean(CInt(GetSetting("RPGToolkit3", _
   "SyntaxUnderline", CStr(a), 0)))
 Next a
 
End Sub

Private Sub lblOK_Click()
 Call cmdOK_Click
End Sub

Private Sub shpColorPreview_Click(index As Integer)
 Dim retColor As Long
 retColor = ColorDialog(True)
 If retColor = -1 Then Exit Sub
 shpColorPreview(index).BackColor = retColor
End Sub
