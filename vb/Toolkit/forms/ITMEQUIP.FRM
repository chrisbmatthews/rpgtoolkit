VERSION 5.00
Begin VB.Form itmequip 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Equipable Item Properties"
   ClientHeight    =   5595
   ClientLeft      =   2010
   ClientTop       =   1305
   ClientWidth     =   9510
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
   Icon            =   "ITMEQUIP.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5595
   ScaleWidth      =   9510
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1496"
   Begin VB.CommandButton Command5 
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
      Left            =   8280
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame4 
      Caption         =   "Equipable Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5175
      Left            =   120
      TabIndex        =   1
      Tag             =   "1510"
      Top             =   120
      Width           =   8055
      Begin VB.Frame Frame1 
         Caption         =   "Equipable To"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Left            =   240
         TabIndex        =   25
         Tag             =   "1506"
         Top             =   360
         Width           =   3255
         Begin VB.CheckBox Check7 
            Caption         =   "Special Accessory"
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
            TabIndex        =   33
            Tag             =   "1508"
            Top             =   1800
            Width           =   2775
         End
         Begin VB.CheckBox Check6 
            Caption         =   "Legs"
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
            TabIndex        =   32
            Tag             =   "1111"
            Top             =   1560
            Width           =   2775
         End
         Begin VB.CheckBox Check5 
            Caption         =   "Body Armour"
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
            Tag             =   "1110"
            Top             =   1320
            Width           =   2895
         End
         Begin VB.CheckBox Check4 
            Caption         =   "Right Hand"
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
            TabIndex        =   30
            Tag             =   "1109"
            Top             =   1080
            Width           =   2895
         End
         Begin VB.CheckBox Check3 
            Caption         =   "Left Hand"
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
            TabIndex        =   29
            Tag             =   "1108"
            Top             =   840
            Width           =   3015
         End
         Begin VB.CheckBox Check2 
            Caption         =   "Neck"
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
            TabIndex        =   28
            Tag             =   "1507"
            Top             =   600
            Width           =   3015
         End
         Begin VB.CheckBox Check1 
            Caption         =   "Head"
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
            TabIndex        =   27
            Tag             =   "1106"
            Top             =   360
            Width           =   3015
         End
         Begin VB.TextBox specify 
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
            TabIndex        =   26
            Top             =   2040
            Visible         =   0   'False
            Width           =   1815
         End
         Begin VB.Label Label3 
            Caption         =   "Specify:"
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
            Left            =   360
            TabIndex        =   34
            Tag             =   "1509"
            Top             =   2040
            Visible         =   0   'False
            Width           =   615
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Effects of Equipping Item"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Left            =   3600
         TabIndex        =   12
         Tag             =   "1500"
         Top             =   360
         Width           =   4215
         Begin VB.TextBox hpup 
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
            Left            =   2880
            TabIndex        =   16
            Text            =   "0"
            Top             =   360
            Width           =   495
         End
         Begin VB.TextBox dpup 
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
            Left            =   2880
            TabIndex        =   15
            Text            =   "0"
            Top             =   720
            Width           =   495
         End
         Begin VB.TextBox fpup 
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
            Left            =   2880
            TabIndex        =   14
            Text            =   "0"
            Top             =   1080
            Width           =   495
         End
         Begin VB.TextBox smup 
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
            Left            =   2880
            TabIndex        =   13
            Text            =   "0"
            Top             =   1440
            Width           =   495
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
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
            Left            =   3480
            TabIndex        =   24
            Tag             =   "1504"
            Top             =   720
            Width           =   615
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
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
            Left            =   3480
            TabIndex        =   23
            Tag             =   "1504"
            Top             =   1080
            Width           =   615
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
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
            Left            =   3480
            TabIndex        =   22
            Tag             =   "1504"
            Top             =   1440
            Width           =   615
         End
         Begin VB.Label Label5 
            Alignment       =   1  'Right Justify
            Caption         =   "Max Health Increase By"
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
            TabIndex        =   21
            Tag             =   "1505"
            Top             =   360
            Width           =   2655
         End
         Begin VB.Label Label6 
            Caption         =   "Points"
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
            Left            =   3480
            TabIndex        =   20
            Tag             =   "1504"
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label5 
            Alignment       =   1  'Right Justify
            Caption         =   "DP Increase By"
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
            Left            =   360
            TabIndex        =   19
            Tag             =   "1503"
            Top             =   720
            Width           =   2415
         End
         Begin VB.Label Label5 
            Alignment       =   1  'Right Justify
            Caption         =   "FP Increase By"
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
            Left            =   360
            TabIndex        =   18
            Tag             =   "1502"
            Top             =   1080
            Width           =   2415
         End
         Begin VB.Label Label5 
            Alignment       =   1  'Right Justify
            Caption         =   "Max Sp'l Move Power Increase By"
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
            Index           =   3
            Left            =   120
            TabIndex        =   17
            Tag             =   "1501"
            Top             =   1440
            Width           =   2655
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "RPGCode"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1935
         Left            =   240
         TabIndex        =   2
         Tag             =   "1196"
         Top             =   3000
         Width           =   7575
         Begin VB.CommandButton Command2 
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
            Left            =   6360
            TabIndex        =   8
            Tag             =   "1021"
            Top             =   1080
            Width           =   1095
         End
         Begin VB.CommandButton Command1 
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
            Left            =   6360
            TabIndex        =   7
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
            Left            =   6360
            TabIndex        =   6
            Tag             =   "1021"
            Top             =   360
            Width           =   1095
         End
         Begin VB.TextBox animation 
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
            Left            =   4200
            TabIndex        =   5
            Text            =   "None"
            Top             =   1080
            Width           =   2055
         End
         Begin VB.TextBox removed 
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
            Left            =   4200
            TabIndex        =   4
            Text            =   "None"
            Top             =   720
            Width           =   2055
         End
         Begin VB.TextBox equipped 
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
            Left            =   4200
            TabIndex        =   3
            Text            =   "None"
            Top             =   360
            Width           =   2055
         End
         Begin VB.Label Label7 
            Alignment       =   1  'Right Justify
            Caption         =   "Animation To Use During Battle (if item is on right or left hand)"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   615
            Index           =   2
            Left            =   120
            TabIndex        =   11
            Tag             =   "1499"
            Top             =   1080
            Width           =   3975
         End
         Begin VB.Label Label7 
            Alignment       =   1  'Right Justify
            Caption         =   "Program To Run When Item Is Removed:"
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
            Index           =   1
            Left            =   120
            TabIndex        =   10
            Tag             =   "1498"
            Top             =   720
            Width           =   3975
         End
         Begin VB.Label Label7 
            Alignment       =   1  'Right Justify
            Caption         =   "Program To Run When Item Is Equipped:"
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
            TabIndex        =   9
            Tag             =   "1497"
            Top             =   360
            Width           =   3975
         End
      End
      Begin VB.Label link1 
         Alignment       =   1  'Right Justify
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
         Left            =   3240
         MouseIcon       =   "ITMEQUIP.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   37
         Tag             =   "1157"
         Top             =   5760
         Visible         =   0   'False
         Width           =   4575
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
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
         Left            =   3360
         MouseIcon       =   "ITMEQUIP.frx":0FD4
         MousePointer    =   99  'Custom
         TabIndex        =   36
         Tag             =   "1150"
         Top             =   5040
         Visible         =   0   'False
         Width           =   4455
      End
      Begin VB.Label Label9 
         Alignment       =   1  'Right Justify
         Caption         =   "Also see Animation Editor"
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
         Left            =   3240
         MouseIcon       =   "ITMEQUIP.frx":12DE
         MousePointer    =   99  'Custom
         TabIndex        =   35
         Tag             =   "1356"
         Top             =   5400
         Visible         =   0   'False
         Width           =   4575
      End
   End
End
Attribute VB_Name = "itmequip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub animation_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.itmAnimation$ = animation.text
End Sub

Private Sub Check1_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(1) = Check1.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check2_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(2) = Check2.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check3_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(3) = Check3.value


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check4_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(4) = Check4.value


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check5_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(5) = Check5.value


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check6_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(6) = Check6.value


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check7_Click()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.itemarmor(7) = Check7.value
    If Check7.value = 1 Then
        Label3.Visible = True
        specify.Visible = True
    Else
        Label3.Visible = False
        specify.Visible = False
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    removed.text = antiPath$
    itemList(activeItemIndex).theData.prgRemove = antiPath$
End Sub

Private Sub Command14_Click()
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgpath$ + antiPath$
    equipped.text = antiPath$
    itemList(activeItemIndex).theData.prgEquip = antiPath$
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + miscPath$
    
    dlg.strTitle = "Select Animation"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + miscPath$ + antiPath$
    animation.text = antiPath$
    itemList(activeItemIndex).theData.itmAnimation$ = antiPath$
End Sub

Private Sub Command5_Click()
    Unload itmequip
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub dpup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.equipDP = val(dpup.text)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub equipped_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.prgEquip = equipped.text
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    If itemList(activeItemIndex).theData.itemarmor(1) = 1 Then Check1.value = 1
    If itemList(activeItemIndex).theData.itemarmor(2) = 1 Then Check2.value = 1
    If itemList(activeItemIndex).theData.itemarmor(3) = 1 Then Check3.value = 1
    If itemList(activeItemIndex).theData.itemarmor(4) = 1 Then Check4.value = 1
    If itemList(activeItemIndex).theData.itemarmor(5) = 1 Then Check5.value = 1
    If itemList(activeItemIndex).theData.itemarmor(6) = 1 Then Check6.value = 1
    If itemList(activeItemIndex).theData.itemarmor(7) = 1 Then Check7.value = 1
    specify.text = itemList(activeItemIndex).theData.accessory
    hpup.text = str$(itemList(activeItemIndex).theData.equipHP)
    dpup.text = str$(itemList(activeItemIndex).theData.equipDP)
    fpup.text = str$(itemList(activeItemIndex).theData.equipFP)
    smup.text = str$(itemList(activeItemIndex).theData.equipSM)
    If itemList(activeItemIndex).theData.prgEquip <> "" Then equipped.text = itemList(activeItemIndex).theData.prgEquip
    If itemList(activeItemIndex).theData.prgRemove <> "" Then removed.text = itemList(activeItemIndex).theData.prgRemove
    If itemList(activeItemIndex).theData.itmAnimation <> "" Then animation.text = itemList(activeItemIndex).theData.itmAnimation

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub fpup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.equipFP = val(fpup.text)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub hpup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.equipHP = val(hpup.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label8_Click()
    On Error GoTo errorhandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label9_Click()
    On Error GoTo errorhandler
    activeAnimation.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub link1_Click()
    On Error GoTo errorhandler
    activePlayer.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub removed_Change()
    On Error Resume Next
    itemList(activeItemIndex).theData.prgRemove = removed.text
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub smup_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.equipSM = val(smup.text)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub specify_Change()
    On Error GoTo errorhandler
    itemList(activeItemIndex).theData.accessory = specify.text

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

