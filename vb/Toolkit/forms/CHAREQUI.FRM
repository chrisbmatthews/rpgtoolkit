VERSION 5.00
Begin VB.Form charequip 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Equippable Items"
   ClientHeight    =   3450
   ClientLeft      =   2625
   ClientTop       =   2400
   ClientWidth     =   6315
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
   Icon            =   "CHAREQUI.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3450
   ScaleWidth      =   6315
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1105"
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
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Caption         =   "Accessory List:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   120
      TabIndex        =   8
      Tag             =   "1114"
      Top             =   2280
      Width           =   4695
      Begin VB.ComboBox Combo1 
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
         TabIndex        =   10
         Text            =   "Accessory 1"
         Top             =   360
         Width           =   1695
      End
      Begin VB.TextBox accessorynamebox 
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
         TabIndex        =   9
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Name:"
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
         TabIndex        =   11
         Tag             =   "1112"
         Top             =   360
         Width           =   615
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Standard Equipment Can Be Equipped On:"
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
      Left            =   120
      TabIndex        =   1
      Tag             =   "1113"
      Top             =   120
      Width           =   4695
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
         TabIndex        =   7
         Tag             =   "1111"
         Top             =   1560
         Width           =   3495
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
         TabIndex        =   6
         Tag             =   "1110"
         Top             =   1320
         Width           =   3615
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
         TabIndex        =   5
         Tag             =   "1109"
         Top             =   1080
         Width           =   3375
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
         TabIndex        =   4
         Tag             =   "1108"
         Top             =   840
         Width           =   3495
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Neck Accessory"
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
         TabIndex        =   3
         Tag             =   "1107"
         Top             =   600
         Width           =   3375
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
         TabIndex        =   2
         Tag             =   "1106"
         Top             =   360
         Width           =   3255
      End
   End
End
Attribute VB_Name = "charequip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub accessorynamebox_Change()
    On Error GoTo errorhandler
    t = Combo1.ListIndex
    If t = -1 Then t = 0
    playerList(activePlayerIndex).theData.accessoryName$(t + 1) = accessorynamebox.text

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check1_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(1) = Check1.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check2_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(2) = Check2.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check3_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(3) = Check3.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check4_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(4) = Check4.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check5_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(5) = Check5.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check6_Click()
    On Error GoTo errorhandler
    playerList(activePlayerIndex).theData.armorType(6) = Check6.value

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Combo1_Click()
    On Error GoTo errorhandler
    t = Combo1.ListIndex + 1
    accessorynamebox.text = playerList(activePlayerIndex).theData.accessoryName$(t)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    Unload charequip
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Check1.value = playerList(activePlayerIndex).theData.armorType(1)
    Check2.value = playerList(activePlayerIndex).theData.armorType(2)
    Check3.value = playerList(activePlayerIndex).theData.armorType(3)
    Check4.value = playerList(activePlayerIndex).theData.armorType(4)
    Check5.value = playerList(activePlayerIndex).theData.armorType(5)
    Check6.value = playerList(activePlayerIndex).theData.armorType(6)
    Combo1.Clear
    For t = 1 To 10
        Combo1.AddItem "Accessory" + str$(t)
    Next t
    Combo1.text = "Accessory 1"
    accessorynamebox.text = playerList(activePlayerIndex).theData.accessoryName$(1)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

