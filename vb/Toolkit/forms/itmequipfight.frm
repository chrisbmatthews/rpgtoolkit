VERSION 5.00
Begin VB.Form itmequipfight 
   Caption         =   "Item Equip Fight Graphics"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   Icon            =   "itmequipfight.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
Tag = "1737"
   Begin VB.OptionButton Option2 
      Caption         =   "Option2"
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   2160
      Width           =   2055
Tag = "1738"
   End
   Begin VB.OptionButton Option1 
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1800
      Width           =   1935
   End
   Begin VB.PictureBox fightgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   0
      Left            =   240
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   5
      Top             =   840
      Width           =   495
   End
   Begin VB.PictureBox fightgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   1
      Left            =   840
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   4
      Top             =   840
      Width           =   495
   End
   Begin VB.PictureBox fightgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   2
      Left            =   1440
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   3
      Top             =   840
      Width           =   495
   End
   Begin VB.PictureBox fightgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   3
      Left            =   2040
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   2
      Top             =   840
      Width           =   495
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "Animate!"
      Height          =   375
      Left            =   2880
      TabIndex        =   1
      Top             =   480
      Width           =   1215
Tag = "1237"
   End
   Begin VB.PictureBox fightanimate 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   3240
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   0
      Top             =   960
      Width           =   495
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Standard Fighting Graphics:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Index           =   1
      Left            =   0
      TabIndex        =   6
      Top             =   480
      Width           =   2775
Tag = "1261"
   End
End
Attribute VB_Name = "itmequipfight"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
