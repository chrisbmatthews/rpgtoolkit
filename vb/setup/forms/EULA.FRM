VERSION 5.00
Begin VB.Form eula 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Software Agreement"
   ClientHeight    =   5370
   ClientLeft      =   1560
   ClientTop       =   1740
   ClientWidth     =   6600
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00000000&
   Icon            =   "EULA.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5370
   ScaleWidth      =   6600
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "< Back"
      Enabled         =   0   'False
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
      Left            =   3120
      TabIndex        =   5
      Top             =   4800
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "I Agree >"
      Default         =   -1  'True
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
      Left            =   4200
      TabIndex        =   0
      Top             =   4800
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Exit"
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
      Left            =   5280
      TabIndex        =   2
      Top             =   4800
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   135
      Left            =   120
      TabIndex        =   4
      Top             =   4440
      Width           =   6255
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      Height          =   4200
      Left            =   120
      ScaleHeight     =   4140
      ScaleWidth      =   1860
      TabIndex        =   3
      Top             =   120
      Width           =   1920
   End
   Begin VB.TextBox agreement 
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4215
      Left            =   2280
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   120
      Width           =   4095
   End
End
Attribute VB_Name = "eula"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub agreement_KeyPress(KeyAscii As Integer)
KeyAscii = 0
End Sub

Private Sub Command1_Click()
    Unload eula
    setupform.Show
End Sub

Private Sub Command2_Click()
    End
End Sub

Private Sub Form_Load()
    On Error GoTo errorshere
    
    If smallImage <> "" And fileExist(mypath$ + smallImage) = 1 Then
        Picture1.Picture = LoadPicture(mypath$ + smallImage)
    End If
    
    num = FreeFile
    errora = 0
    Open "eula.txt" For Input As #num
        If errora = 1 Then
            MsgBox "License Agreement File: EULA.txt Not Found.  Quitting...", , "File Not Found"
            End
        End If
        Do While Not EOF(num)
            Line Input #num, Add$
            agreement.text = agreement.text + Add$ + Chr$(13) + Chr$(10)
        Loop
    Close #num
Exit Sub
errorshere:
errora = 1
Resume Next
End Sub

