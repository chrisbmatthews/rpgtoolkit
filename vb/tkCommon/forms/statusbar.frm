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
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' All-purpose status bar
'=========================================================================

Option Explicit

'=========================================================================
' Set status on bar
'=========================================================================
Public Sub setStatus(ByVal sPercent As Long, ByVal cap As String)
    On Error Resume Next
    imgLoading.Width = sPercent * maxProgress.Width / 100
    #If isToolkit = 0 Then
        Call processEvent
    #Else
        DoEvents
    #End If
End Sub

'=========================================================================
' Load bar
'=========================================================================
Private Sub Form_Load()
    On Error Resume Next
    imgLoading.Width = 0
    #If isToolkit = 1 Then
        Call SetParent(Me.hwnd, tkMainForm.hwnd)
        DoEvents
    #Else
        Call processEvent
    #End If
End Sub
