VERSION 5.00
Begin VB.Form statusbar 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   Caption         =   "Status"
   ClientHeight    =   1275
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4830
   Icon            =   "statusbar.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Palette         =   "statusbar.frx":000C
   ScaleHeight     =   1275
   ScaleWidth      =   4830
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox picLoadingPleaseWait 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   690
      Left            =   0
      Picture         =   "statusbar.frx":982E
      ScaleHeight     =   690
      ScaleWidth      =   4845
      TabIndex        =   1
      Top             =   0
      Width           =   4845
   End
   Begin VB.PictureBox picProgressBar 
      BorderStyle     =   0  'None
      Height          =   600
      Left            =   0
      Picture         =   "statusbar.frx":14718
      ScaleHeight     =   600
      ScaleWidth      =   4845
      TabIndex        =   0
      Top             =   690
      Width           =   4845
      Begin VB.Image imgLoading 
         Height          =   230
         Left            =   270
         Picture         =   "statusbar.frx":1DF3A
         Stretch         =   -1  'True
         Top             =   159
         Width           =   375
      End
      Begin VB.Shape maxProgress 
         Height          =   255
         Left            =   255
         Top             =   150
         Width           =   4305
      End
   End
End
Attribute VB_Name = "statusbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

' ! MODIFIED BY KSNiloc...

Option Explicit

Public Sub setStatus(ByVal sPercent As Long, ByVal cap As String)

    On Error Resume Next
    imgLoading.Width = sPercent * maxProgress.Width / 100
    DoEvents

    'set the current status on the bar at a certain percentage
    'Call vbPicFillRect(bar, sPercent, 0, 100, 1000, vbQBColor(15))
    'Dim t As Long
    'For t = sPercent To 0 Step -1
    '    Call vbPicFillRect(bar, 0, 0, t, 1000, RGB(255 - t * 2.5, 0, t * 2.5))
    'Next t
    'perc.caption = toString(sPercent) + " %"
    'Label1.caption = cap
End Sub

Private Sub Form_Load()
    On Error Resume Next
    imgLoading.Width = 0
    'SetParent Me.hwnd, tkMainForm.hwnd
    DoEvents
End Sub
