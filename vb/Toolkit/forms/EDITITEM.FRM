VERSION 5.00
Begin VB.Form edititem 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Item Editor (Untitled)"
   ClientHeight    =   5040
   ClientLeft      =   2490
   ClientTop       =   1875
   ClientWidth     =   8385
   ControlBox      =   0   'False
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
   Icon            =   "EDITITEM.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5040
   ScaleWidth      =   8385
   Tag             =   "6"
   WindowState     =   2  'Maximized
   Begin VB.Frame mainFrame 
      Height          =   4695
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8055
      Begin VB.PictureBox Picture3 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   5640
         ScaleHeight     =   495
         ScaleWidth      =   2055
         TabIndex        =   30
         Top             =   3960
         Width           =   2055
         Begin VB.CommandButton Command5 
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
            Left            =   0
            TabIndex        =   31
            Tag             =   "1300"
            Top             =   0
            Width           =   1935
         End
      End
      Begin VB.Frame Frame5 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   240
         TabIndex        =   18
         Tag             =   "1366"
         Top             =   2640
         Width           =   4575
         Begin VB.PictureBox Picture1 
            BorderStyle     =   0  'None
            Height          =   1455
            Left            =   120
            ScaleHeight     =   1455
            ScaleWidth      =   4335
            TabIndex        =   19
            Top             =   240
            Width           =   4335
            Begin VB.OptionButton Option2 
               Caption         =   "Used By Defined Characters"
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
               TabIndex        =   23
               Tag             =   "1368"
               Top             =   240
               Width           =   3975
            End
            Begin VB.ComboBox chars 
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
               TabIndex        =   22
               Text            =   "Character 1"
               Top             =   600
               Visible         =   0   'False
               Width           =   1575
            End
            Begin VB.OptionButton Option1 
               Caption         =   "Used By All Characters"
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
               Left            =   0
               TabIndex        =   21
               Tag             =   "1367"
               Top             =   0
               Value           =   -1  'True
               Width           =   4335
            End
            Begin VB.TextBox charname 
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
               TabIndex        =   20
               Top             =   600
               Visible         =   0   'False
               Width           =   2055
            End
            Begin VB.Label Label3 
               Alignment       =   2  'Center
               Caption         =   "Please Type The Player's Handle Here!"
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
               Left            =   1800
               TabIndex        =   24
               Tag             =   "1369"
               Top             =   960
               Visible         =   0   'False
               Width           =   1815
            End
         End
      End
      Begin VB.TextBox itemnamebox 
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
         Left            =   3000
         TabIndex        =   16
         Top             =   360
         Width           =   2055
      End
      Begin VB.Frame Frame2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   240
         TabIndex        =   11
         Tag             =   "1376"
         Top             =   720
         Width           =   3135
         Begin VB.PictureBox Picture2 
            BorderStyle     =   0  'None
            Height          =   1215
            Left            =   1800
            ScaleHeight     =   1215
            ScaleWidth      =   1215
            TabIndex        =   25
            Top             =   360
            Width           =   1215
            Begin VB.CommandButton Command1 
               Caption         =   "Edit"
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
               Height          =   255
               Left            =   0
               TabIndex        =   29
               Tag             =   "1377"
               Top             =   0
               Width           =   975
            End
            Begin VB.CommandButton Command2 
               Caption         =   "Edit"
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
               Height          =   255
               Left            =   0
               TabIndex        =   28
               Tag             =   "1377"
               Top             =   240
               Width           =   975
            End
            Begin VB.CommandButton Command3 
               Caption         =   "Edit"
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
               Height          =   255
               Left            =   0
               TabIndex        =   27
               Tag             =   "1377"
               Top             =   480
               Width           =   975
            End
            Begin VB.CommandButton Command4 
               Caption         =   "Edit"
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
               Height          =   255
               Left            =   0
               TabIndex        =   26
               Tag             =   "1377"
               Top             =   720
               Width           =   975
            End
         End
         Begin VB.CheckBox fight 
            Caption         =   "Battle-Driven"
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
            TabIndex        =   12
            Tag             =   "1353"
            Top             =   1080
            Width           =   1695
         End
         Begin VB.CheckBox board 
            Caption         =   "Board-Driven"
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
            TabIndex        =   13
            Tag             =   "1352"
            Top             =   840
            Width           =   1695
         End
         Begin VB.CheckBox menu 
            Caption         =   "Menu-Driven"
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
            TabIndex        =   14
            Tag             =   "1379"
            Top             =   600
            Width           =   1695
         End
         Begin VB.CheckBox equipable 
            Caption         =   "Equipable"
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
            TabIndex        =   15
            Tag             =   "1378"
            Top             =   360
            Width           =   1695
         End
      End
      Begin VB.Frame Frame4 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   3600
         TabIndex        =   1
         Tag             =   "1370"
         Top             =   720
         Width           =   4215
         Begin VB.TextBox Text3 
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
            TabIndex        =   5
            Top             =   1080
            Width           =   1935
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
            Left            =   1680
            TabIndex        =   4
            Text            =   "0"
            Top             =   720
            Width           =   1935
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
            Left            =   1680
            TabIndex        =   3
            Text            =   "0"
            Top             =   360
            Width           =   1935
         End
         Begin VB.CheckBox Check1 
            Caption         =   "Key Item"
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
            TabIndex        =   2
            Tag             =   "1371"
            Top             =   1440
            Width           =   2295
         End
         Begin VB.Label Label7 
            Alignment       =   1  'Right Justify
            Caption         =   "Description:"
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
            Tag             =   "1354"
            Top             =   1080
            Width           =   1455
         End
         Begin VB.Label Label6 
            Caption         =   "GP"
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
            Left            =   3720
            TabIndex        =   9
            Tag             =   "1374"
            Top             =   720
            Width           =   255
         End
         Begin VB.Label Label6 
            Caption         =   "GP"
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
            Left            =   3720
            TabIndex        =   8
            Tag             =   "1374"
            Top             =   360
            Width           =   255
         End
         Begin VB.Label Label5 
            Alignment       =   1  'Right Justify
            Caption         =   "Selling Price:"
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
            TabIndex        =   7
            Tag             =   "1373"
            Top             =   720
            Width           =   1455
         End
         Begin VB.Label Label4 
            Alignment       =   1  'Right Justify
            Caption         =   "Purchase Price:"
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
            TabIndex        =   6
            Tag             =   "1372"
            Top             =   360
            Width           =   1455
         End
      End
      Begin VB.Label Label2 
         Caption         =   "Item Name (Handle):"
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
         Left            =   360
         TabIndex        =   17
         Tag             =   "1380"
         Top             =   360
         Width           =   2535
      End
   End
   Begin VB.Menu filemnu 
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
      Begin VB.Menu savemnu 
         Caption         =   "Save Item"
         Shortcut        =   ^S
         Tag             =   "1384"
      End
      Begin VB.Menu saveasmnu 
         Caption         =   "Save Item As"
         Shortcut        =   ^A
         Tag             =   "1385"
      End
      Begin VB.Menu mnusaveall 
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
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnututorial 
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
      Begin VB.Menu mnuabout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "edititem"
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
' Item editor
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Public dataIndex As Long    'indice in item editor vector

'=========================================================================
' Property identifying this form
'=========================================================================
Public Property Get formType() As Long
    On Error Resume Next
    formType = FT_ITEM
End Property

'=========================================================================
' Save file as
'=========================================================================
Public Sub saveAsFile()
    On Error Resume Next
    If itemList(activeItemIndex).itemNeedUpdate = True Then
        Call Me.Show
        Call saveasmnu_Click
    End If
End Sub

'=========================================================================
' Save the file
'=========================================================================
Public Sub saveFile()
    On Error Resume Next
    filename(2) = itemList(activeItemIndex).itemFile
    itemList(activeItemIndex).itemNeedUpdate = False
    If filename$(2) = "" Then
        Call Me.Show
        Call saveasmnu_Click
        Exit Sub
    End If
    Call saveItem(projectPath & itmPath & filename(2), itemList(activeItemIndex).theData)
End Sub

'=========================================================================
' Open a file
'=========================================================================
Public Sub openFile(ByVal file As String)
    On Error Resume Next
    Call activeItem.Show
    filename$(1) = file$
    Dim antiPath As String
    antiPath$ = absNoPath(file$)
    FileCopy filename$(1), projectPath$ + itmPath$ + antiPath$
    itemList(activeItemIndex).theData = openItem(filename$(1))
    itemList(activeItemIndex).itemFile$ = antiPath$
    activeItem.Caption = LoadStringLoc(805, "Item Editor") + "  (" + antiPath$ + ")"
    Call infofill
    itemList(activeItemIndex).itemNeedUpdate = False
End Sub

'=========================================================================
' Buttons, option buttons, check boxes, text boxes and the like
'=========================================================================
Private Sub board_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    If board.value = 1 Then Command3.Enabled = True Else Command3.Enabled = False
    itemList(activeItemIndex).theData.BoardYN = board.value
End Sub
Private Sub charname_Change()
    Dim a As Long
    itemList(activeItemIndex).itemNeedUpdate = True
    a = chars.ListIndex + 1
    If a = 0 Then a = 1
    itemList(activeItemIndex).theData.itmChars$(a) = charname.Text
End Sub
Private Sub chars_Click()
    Dim a As Long
    a = chars.ListIndex + 1
    charname.Text = itemList(activeItemIndex).theData.itmChars$(a)
End Sub
Private Sub Check1_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.keyItem = Check1.value
End Sub
Private Sub Command1_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itmequip.Show vbModal ', me
End Sub
Private Sub Command2_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itmmenu.Show vbModal ', me
End Sub
Private Sub Command3_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itmboard.Show vbModal ', me
End Sub
Private Sub Command4_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itmfight.Show vbModal ', me
End Sub
Private Sub Command5_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    itemGraphics.Show vbModal
End Sub
Private Sub equipable_Click()
    itemList(activeItemIndex).itemNeedUpdate = True
    If equipable.value = 1 Then Command1.Enabled = True Else Command1.Enabled = False
    itemList(activeItemIndex).theData.EquipYN = equipable.value
End Sub
Private Sub fight_Click()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    If fight.value = 1 Then Command4.Enabled = True Else Command4.Enabled = False
    itemList(activeItemIndex).theData.FightYN = fight.value
End Sub

'=========================================================================
' Form activate
'=========================================================================
Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    filename(2) = ""
    
    Set activeItem = Me
    Set activeForm = Me
    activeItemIndex = dataIndex
    
    Call hideAllTools
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'=========================================================================
' Form load
'=========================================================================
Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Set activeItem = Me
    dataIndex = VectItemNewSlot()
    activeItemIndex = dataIndex
    Call ItemClear(itemList(dataIndex).theData)
    
    filename(2) = ""
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'=========================================================================
' Fill in form
'=========================================================================
Private Sub infofill()
    On Error GoTo ErrorHandler
    itemnamebox.Text = itemList(activeItemIndex).theData.itemName
    equipable.value = itemList(activeItemIndex).theData.EquipYN
    menu.value = itemList(activeItemIndex).theData.MenuYN
    board.value = itemList(activeItemIndex).theData.BoardYN
    fight.value = itemList(activeItemIndex).theData.FightYN
    If fight.value = 1 Then Command4.Enabled = True Else Command4.Enabled = False
    If menu.value = 1 Then Command2.Enabled = True Else Command2.Enabled = False
    If equipable.value = 1 Then Command1.Enabled = True Else Command1.Enabled = False
    If board.value = 1 Then Command3.Enabled = True Else Command3.Enabled = False
    If itemList(activeItemIndex).theData.usedBy = 1 Then Option2.value = True: Option1.value = False
    If itemList(activeItemIndex).theData.usedBy = 2 Then Option2.value = False: Option1.value = True

    Text1.Text = str$(itemList(activeItemIndex).theData.buyPrice)
    Text2.Text = str$(itemList(activeItemIndex).theData.sellPrice)

    Call chars.Clear
    chars.Text = "Character 1"
    Dim t As Long
    For t = 1 To 50
        chars.AddItem "Character" + str$(t)
    Next t
    charname.Text = itemList(activeItemIndex).theData.itmChars$(1)

    Check1.value = itemList(activeItemIndex).theData.keyItem
    
    Text3.Text = itemList(activeItemIndex).theData.itmDescription

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'=========================================================================
' Form unload
'=========================================================================
Private Sub Form_Unload(ByRef Cancel As Integer): On Error Resume Next
    
    'See if the board needs saving:
    If itemList(activeItemIndex).itemNeedUpdate Then
        
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
    Call tkMainForm.refreshTabs
    
End Sub

'=========================================================================
' Change item name
'=========================================================================
Private Sub itemnamebox_Change()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.itemName$ = itemnamebox.Text
End Sub

'=========================================================================
' Toggle menu usage
'=========================================================================
Private Sub menu_Click()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    If menu.value = 1 Then Command2.Enabled = True Else Command2.Enabled = False
    itemList(activeItemIndex).theData.MenuYN = menu.value
End Sub

'=========================================================================
' Close dialog
'=========================================================================
Private Sub mnuCLose_Click()
    On Error Resume Next
    Call Unload(itmequip)
    Call Unload(itmmenu)
    Call Unload(itmfight)
    Call Unload(itmboard)
    Call Unload(activeItem)
End Sub

'=========================================================================
' Clear item
'=========================================================================
Private Sub newitem()
    Call ItemClear(itemList(activeItemIndex).theData)
End Sub

'=========================================================================
' Change option boxes
'=========================================================================
Private Sub Option1_Click()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.usedBy = 0
    chars.Visible = False
    charname.Visible = False
    Label3.Visible = False
End Sub
Private Sub Option2_Click()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.usedBy = 1
    chars.Visible = True
    charname.Visible = True
    Label3.Visible = True
End Sub

'=========================================================================
' Save as menu
'=========================================================================
Private Sub saveasmnu_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + itmPath$
    dlg.strTitle = "Save Item As"
    dlg.strDefaultExt = "itm"
    dlg.strFileTypes = "RPG Toolkit Item (*.itm)|*.itm|All files(*.*)|*.*"
    If SaveFileDialog(dlg, Me.hwnd, True) Then  'Prompt overwrite.
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    Call saveItem(filename$(1), itemList(activeItemIndex).theData)
    itemList(activeItemIndex).itemFile$ = antiPath$
    activeItem.Caption = LoadStringLoc(805, "Item Editor") + " (" + antiPath$ + ")"
    itemList(activeItemIndex).itemNeedUpdate = False
    Call tkMainForm.fillTree("", projectPath$)
End Sub

'=========================================================================
' Save menu
'=========================================================================
Private Sub savemnu_Click()
    On Error Resume Next
    filename(2) = itemList(activeItemIndex).itemFile
    If filename(2) = "" Then saveasmnu_Click: Exit Sub
    Call saveItem(projectPath & itmPath & filename(2), itemList(activeItemIndex).theData)
    itemList(activeItemIndex).itemNeedUpdate = False
End Sub

'=========================================================================
' Change text fields
'=========================================================================
Private Sub Text1_Change()
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.buyPrice = val(Text1.Text)
End Sub
Private Sub Text2_Change()
    On Error Resume Next
    itemList(activeItemIndex).itemNeedUpdate = True
    itemList(activeItemIndex).theData.sellPrice = val(Text2.Text)
End Sub
Private Sub Text3_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.itmDescription = Text3.Text
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
