VERSION 5.00
Begin VB.Form frmMusicCheck 
   Caption         =   "Music Check"
   ClientHeight    =   2475
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3315
   LinkTopic       =   "Form1"
   ScaleHeight     =   2475
   ScaleWidth      =   3315
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer checkMusic 
      Interval        =   1200
      Left            =   480
      Top             =   840
   End
End
Attribute VB_Name = "frmMusicCheck"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'====================================================================================
'RPGToolkit3 Default Battle System
'====================================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'====================================================================================
'YOU MAY NOT REMOVE THIS NOTICE!
'====================================================================================

Option Explicit

Private Sub checkMusic_Timer()
    Call modBattleSystem.checkMusic
End Sub
