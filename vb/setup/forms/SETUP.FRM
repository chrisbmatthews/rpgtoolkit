VERSION 5.00
Begin VB.Form setup 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   Caption         =   "RPG Toolkit Development System, 2.1 Setup"
   ClientHeight    =   4020
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   7365
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
   Icon            =   "SETUP.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   268
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   491
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   4680
      Top             =   1200
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Cancel"
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
      Left            =   0
      TabIndex        =   2
      Top             =   1320
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Setup"
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
      Left            =   0
      TabIndex        =   1
      Top             =   960
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "RPG Toolkit Development System, Version 2.1"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   1095
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   4815
   End
End
Attribute VB_Name = "setup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub Command1_Click()
    Command1.Enabled = False
    Command2.Enabled = False
    eula.Show
End Sub

Private Sub Command2_Click()
    End
End Sub

Private Sub Form_Load()
    'registered = 0
    
    'MsgBox fGetSpecialFolder(CSIDL_programs)
    
    mypath$ = App.Path
    'mypath$ = CurDir$
    If Mid$(mypath$, Len(mypath$), 1) <> "\" Then
        mypath$ = mypath$ + "\"
    End If
    Call openInf
    Label1.Caption = title$
    Me.Caption = title$
    For y = 0 To 255 Step 1
        Call vbFrmFillRect(Me, 0, y * 3, 2000, y * 3 + 3, RGB(0, 0, 255 - y))
    Next y
    
    'startm = StartMenuDir()
    'startm = startm + "RPG Toolkit\"
    'Call CreateDir(startm)
    
    Call testZIPdll
    setup.Hide
End Sub

Private Sub Timer1_Timer()
    Command1.Enabled = False
    Command2.Enabled = False
    Timer1.Enabled = False
    eula.Show
End Sub


