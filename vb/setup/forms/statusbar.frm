VERSION 5.00
Begin VB.Form statusbar 
   Caption         =   "Status"
   ClientHeight    =   750
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5745
   Icon            =   "statusbar.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   750
   ScaleWidth      =   5745
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox bar 
      Height          =   255
      Left            =   240
      ScaleHeight     =   195
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   0
      Top             =   240
      Width           =   4575
   End
   Begin VB.Label Label1 
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   0
      Width           =   5295
   End
   Begin VB.Label perc 
      Caption         =   "0 %"
      Height          =   255
      Left            =   4920
      TabIndex        =   1
      Top             =   240
      Width           =   615
   End
End
Attribute VB_Name = "statusbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info


Public Sub setStatus(sPercent, text$)
    'set the current status on the bar at a certain percentage
    Call vbPicFillRect(bar, sPercent, 0, 100, 1000, vbQBColor(15))
    For t = sPercent To 0 Step -1
        Call vbPicFillRect(bar, 0, 0, t, 1000, RGB(255 - t * 2.5, 0, t * 2.5))
    Next t
    perc.Caption = Str$(sPercent) + " %"
    Label1.Caption = text$
    DoEvents
End Sub


Private Sub Form_Load()

End Sub


