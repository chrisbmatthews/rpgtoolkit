VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   2520
      Width           =   975
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      Height          =   2055
      Left            =   240
      ScaleHeight     =   133
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   285
      TabIndex        =   0
      Top             =   240
      Width           =   4335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    a = drawTileTest(Picture1.hdc, 0, 0, "default.tst110")
    a = drawTileTest(Picture1.hdc, 32, 0, "32x32.gph")
    a = drawTileTest(Picture1.hdc, 64, 0, "version1.gph")
End Sub


