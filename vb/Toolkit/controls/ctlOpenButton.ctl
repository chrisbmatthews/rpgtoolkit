VERSION 5.00
Begin VB.UserControl ctlOpenButton 
   ClientHeight    =   375
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   375
   ScaleHeight     =   375
   ScaleWidth      =   375
   Begin VB.CommandButton changedSelectedTileset 
      Height          =   375
      Left            =   0
      Picture         =   "ctlOpenButton.ctx":0000
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Width           =   375
   End
End
Attribute VB_Name = "ctlOpenButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Event click()

Private Sub changedSelectedTileset_Click()
    RaiseEvent click
End Sub
