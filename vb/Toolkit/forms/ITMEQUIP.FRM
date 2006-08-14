VERSION 5.00
Begin VB.Form itmequip 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Equipable Item Properties"
   ClientHeight    =   5145
   ClientLeft      =   2010
   ClientTop       =   1305
   ClientWidth     =   9195
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
   ScaleHeight     =   5145
   ScaleWidth      =   9195
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1496"
   Begin VB.CommandButton cmdOK 
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
      Left            =   8040
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
      Height          =   4695
      Left            =   120
      TabIndex        =   1
      Tag             =   "1510"
      Top             =   120
      Width           =   7815
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   4335
         Index           =   0
         Left            =   120
         ScaleHeight     =   4335
         ScaleWidth      =   7575
         TabIndex        =   2
         Top             =   240
         Width           =   7575
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
            Height          =   1695
            Left            =   0
            TabIndex        =   26
            Tag             =   "1196"
            Top             =   2640
            Width           =   7575
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
               TabIndex        =   33
               Text            =   "None"
               Top             =   360
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
               TabIndex        =   32
               Text            =   "None"
               Top             =   720
               Width           =   2055
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
               TabIndex        =   31
               Text            =   "None"
               Top             =   1080
               Width           =   2055
            End
            Begin VB.PictureBox Picture1 
               BorderStyle     =   0  'None
               Height          =   1215
               Index           =   1
               Left            =   6360
               ScaleHeight     =   1215
               ScaleWidth      =   1095
               TabIndex        =   27
               Top             =   360
               Width           =   1095
               Begin VB.CommandButton cmdAnimation 
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
                  Left            =   0
                  TabIndex        =   30
                  Tag             =   "1021"
                  Top             =   720
                  Width           =   1095
               End
               Begin VB.CommandButton cmdPrgRemove 
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
                  Left            =   0
                  TabIndex        =   29
                  Tag             =   "1021"
                  Top             =   360
                  Width           =   1095
               End
               Begin VB.CommandButton cmdPrgEquip 
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
                  Left            =   0
                  TabIndex        =   28
                  Tag             =   "1021"
                  Top             =   0
                  Width           =   1095
               End
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
               TabIndex        =   36
               Tag             =   "1497"
               Top             =   360
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
               TabIndex        =   35
               Tag             =   "1498"
               Top             =   720
               Width           =   3975
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
               Height          =   495
               Index           =   2
               Left            =   1800
               TabIndex        =   34
               Tag             =   "1499"
               Top             =   1080
               Width           =   2295
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
            Left            =   3360
            TabIndex        =   13
            Tag             =   "1500"
            Top             =   0
            Width           =   4215
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
               TabIndex        =   17
               Text            =   "0"
               Top             =   1440
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
               TabIndex        =   16
               Text            =   "0"
               Top             =   1080
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
               TabIndex        =   14
               Text            =   "0"
               Top             =   360
               Width           =   495
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
               TabIndex        =   25
               Tag             =   "1501"
               Top             =   1440
               Width           =   2655
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
               TabIndex        =   24
               Tag             =   "1502"
               Top             =   1080
               Width           =   2415
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
               TabIndex        =   23
               Tag             =   "1503"
               Top             =   720
               Width           =   2415
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
               TabIndex        =   22
               Tag             =   "1504"
               Top             =   360
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
               Index           =   1
               Left            =   3480
               TabIndex        =   20
               Tag             =   "1504"
               Top             =   1440
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
               TabIndex        =   19
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
               Index           =   3
               Left            =   3480
               TabIndex        =   18
               Tag             =   "1504"
               Top             =   720
               Width           =   615
            End
         End
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
            Left            =   0
            TabIndex        =   3
            Tag             =   "1506"
            Top             =   0
            Width           =   3255
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
               TabIndex        =   11
               Top             =   2160
               Visible         =   0   'False
               Width           =   1815
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   1
               Left            =   120
               TabIndex        =   10
               Tag             =   "1106"
               Top             =   360
               Width           =   3015
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   2
               Left            =   120
               TabIndex        =   9
               Tag             =   "1507"
               Top             =   600
               Width           =   3015
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   3
               Left            =   120
               TabIndex        =   8
               Tag             =   "1108"
               Top             =   840
               Width           =   3015
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   4
               Left            =   120
               TabIndex        =   7
               Tag             =   "1109"
               Top             =   1080
               Width           =   2895
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   5
               Left            =   120
               TabIndex        =   6
               Tag             =   "1110"
               Top             =   1320
               Width           =   2895
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   6
               Left            =   120
               TabIndex        =   5
               Tag             =   "1111"
               Top             =   1560
               Width           =   2775
            End
            Begin VB.CheckBox chkEquip 
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
               Index           =   7
               Left            =   120
               TabIndex        =   4
               Tag             =   "1508"
               Top             =   1800
               Width           =   2775
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
               TabIndex        =   12
               Tag             =   "1509"
               Top             =   2160
               Visible         =   0   'False
               Width           =   615
            End
         End
      End
   End
End
Attribute VB_Name = "itmequip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

Option Explicit

Private Sub animation_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.itmAnimation = animation.Text
End Sub

Private Sub chkEquip_Click(Index As Integer): On Error Resume Next
    itemList(activeItemIndex).theData.itemArmor(Index) = chkEquip(Index).value
    If Index = 7 Then
        If chkEquip(Index).value Then
            Label3.visible = True
            specify.visible = True
        Else
            Label3.visible = False
            specify.visible = False
        End If
    End If
End Sub

Private Sub cmdPrgRemove_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        removed.Text = file
        itemList(activeItemIndex).theData.prgRemove = file
    End If
End Sub

Private Sub cmdPrgEquip_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        equipped.Text = file
        itemList(activeItemIndex).theData.prgEquip = file
    End If
End Sub

Private Sub cmdAnimation_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & miscPath, "Select animation", "anm", fileTypes, file) Then
        animation.Text = file
        itemList(activeItemIndex).theData.itmAnimation = file
    End If
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub dpup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.equipDP = val(dpup.Text)
End Sub

Private Sub equipped_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.prgEquip = equipped.Text
End Sub

Private Sub Form_Load(): On Error Resume Next
    Dim i As Long
    With itemList(activeItemIndex).theData
        For i = 1 To UBound(.itemArmor)
          chkEquip(i).value = .itemArmor(i)
        Next i
        specify.Text = .accessory
        hpup.Text = str$(.equipHP)
        dpup.Text = str$(.equipDP)
        fpup.Text = str$(.equipFP)
        smup.Text = str$(.equipSM)
        If LenB(.prgEquip) Then equipped.Text = .prgEquip
        If LenB(.prgRemove) Then removed.Text = .prgRemove
        If LenB(.itmAnimation) Then animation.Text = .itmAnimation
    End With
End Sub

Private Sub fpup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.equipFP = val(fpup.Text)
End Sub

Private Sub hpup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.equipHP = val(hpup.Text)
End Sub

Private Sub removed_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.prgRemove = removed.Text
End Sub

Private Sub smup_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.equipSM = val(smup.Text)
End Sub

Private Sub specify_Change(): On Error Resume Next
    itemList(activeItemIndex).theData.accessory = specify.Text
End Sub

