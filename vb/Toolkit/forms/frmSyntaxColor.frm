VERSION 5.00
Begin VB.Form frmColoringOptions 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Syntax Coloring Options"
   ClientHeight    =   3255
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4095
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3255
   ScaleWidth      =   4095
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   847
      Object.Width           =   3735
      Caption         =   "Syntax Coloring Options"
   End
   Begin Toolkit.TKButton cmdDefault 
      Height          =   495
      Left            =   2640
      TabIndex        =   20
      Top             =   1320
      Width           =   1335
      _ExtentX        =   3440
      _ExtentY        =   873
      Object.Width           =   1935
      Caption         =   "Default"
   End
   Begin Toolkit.ctlBoldItalicUnderline BIU 
      Height          =   255
      Index           =   0
      Left            =   1200
      TabIndex        =   13
      Top             =   960
      Width           =   735
      _ExtentX        =   1296
      _ExtentY        =   450
   End
   Begin VB.Frame Blocks 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Color and Style"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   2300
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
         ScaleWidth      =   225
         TabIndex        =   12
         Top             =   720
         Width           =   255
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
         ScaleWidth      =   225
         TabIndex        =   11
         Top             =   2160
         Width           =   255
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
         ScaleWidth      =   225
         TabIndex        =   10
         Top             =   1800
         Width           =   255
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
         ScaleWidth      =   225
         TabIndex        =   9
         Top             =   1440
         Width           =   255
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
         ScaleWidth      =   225
         TabIndex        =   8
         Top             =   1080
         Width           =   255
      End
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
         ScaleWidth      =   225
         TabIndex        =   7
         Top             =   360
         Width           =   255
      End
      Begin Toolkit.ctlBoldItalicUnderline BIU 
         Height          =   255
         Index           =   1
         Left            =   1080
         TabIndex        =   14
         Top             =   720
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
      End
      Begin Toolkit.ctlBoldItalicUnderline BIU 
         Height          =   255
         Index           =   2
         Left            =   1080
         TabIndex        =   15
         Top             =   1080
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
      End
      Begin Toolkit.ctlBoldItalicUnderline BIU 
         Height          =   255
         Index           =   3
         Left            =   1080
         TabIndex        =   16
         Top             =   1440
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
      End
      Begin Toolkit.ctlBoldItalicUnderline BIU 
         Height          =   255
         Index           =   4
         Left            =   1080
         TabIndex        =   17
         Top             =   1800
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
      End
      Begin Toolkit.ctlBoldItalicUnderline BIU 
         Height          =   255
         Index           =   5
         Left            =   1080
         TabIndex        =   18
         Top             =   2160
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
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
         TabIndex        =   6
         Top             =   2160
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
         TabIndex        =   5
         Top             =   1800
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
         TabIndex        =   4
         Top             =   1440
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
         TabIndex        =   3
         Top             =   1080
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
         TabIndex        =   2
         Top             =   720
         Width           =   855
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
         TabIndex        =   1
         Top             =   360
         Width           =   855
      End
   End
   Begin Toolkit.TKButton cmdSave 
      Height          =   495
      Left            =   2640
      TabIndex        =   19
      Top             =   840
      Width           =   1335
      _ExtentX        =   3440
      _ExtentY        =   873
      Object.Width           =   1935
      Caption         =   "Save"
   End
   Begin VB.Shape Shape1 
      Height          =   3255
      Left            =   0
      Top             =   0
      Width           =   4095
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

Private Sub cmdCancel_Click(): Unload Me: End Sub

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
   CStr(BooleanToLong(BIU(a).Bold))
  SaveSetting "RPGToolkit3", "SyntaxItalics", CStr(a), _
   CStr(BooleanToLong(BIU(a).Italics))
  SaveSetting "RPGToolkit3", "SyntaxUnderline", CStr(a), _
   CStr(BooleanToLong(BIU(a).Underline))
 Next a
 
 'Flag to have any open programs be re-colored...
 needsReColor = True
 programEditorCountDown = programEditorCount
 
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
 
End Sub

Private Sub cmdSave_Click()
 cmdOK_Click
End Sub

Private Sub Form_Activate()
 Dim a As Long
 For a = 0 To 5: shpColorPreview(a).MouseIcon = Images.MouseLink: Next a
 Set TopBar.theForm = Me
End Sub

Private Sub Form_Load(): updateColors: Form_Resize: End Sub

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

Private Sub Form_Resize()
 'TopBar.Width = Me.ScaleWidth - (Me.ScaleWidth / 6)
 'Corner.Left = TopBar.ScaleWidth - Corner.Width
End Sub

Private Sub lblOK_Click()
 Call cmdOK_Click
End Sub

Private Sub shpColorPreview_Click(Index As Integer)
 Dim retColor As Long
 retColor = ColorDialog(True)
 If retColor = -1 Then Exit Sub
 shpColorPreview(Index).BackColor = retColor
End Sub
