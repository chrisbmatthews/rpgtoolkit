VERSION 5.00
Begin VB.Form debugWin 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "RPGCode Debugger"
   ClientHeight    =   2460
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   4785
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
   Icon            =   "DEBUGWIN.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2460
   ScaleWidth      =   4785
   ShowInTaskbar   =   0   'False
   Tag             =   "1906"
   Begin VB.TextBox buglist 
      Appearance      =   0  'Flat
      Height          =   2415
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   0
      Width           =   4815
   End
End
Attribute VB_Name = "debugwin"
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
' RPGCode debug window (pops up on rpgcode error)
' Status: N/A
'=========================================================================

Option Explicit

'=========================================================================
' Key pressed down on debug window
'=========================================================================
Private Sub Form_KeyDown(keyCode As Integer, Shift As Integer)
    keyWaitState = keyCode
    keyShiftState = Shift
End Sub

'=========================================================================
' Debug window opened
'=========================================================================
Private Sub Form_Load()
    If usingFullScreen() Then
        Call Unload(Me)
    Else
        With Me
            .Top = Screen.height - .height
            .Left = Screen.width - .width
        End With
    End If
End Sub
