VERSION 5.00
Begin VB.Form setupform 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Browse"
   ClientHeight    =   5370
   ClientLeft      =   1980
   ClientTop       =   1725
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
   ForeColor       =   &H80000008&
   Icon            =   "setupfor.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5370
   ScaleMode       =   0  'User
   ScaleWidth      =   5775
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command4 
      Caption         =   "< Back"
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
      TabIndex        =   6
      Top             =   4800
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Next >"
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
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      Height          =   4200
      Left            =   120
      ScaleHeight     =   4140
      ScaleWidth      =   1860
      TabIndex        =   5
      Top             =   120
      Width           =   1920
   End
   Begin VB.Frame Frame1 
      Height          =   135
      Left            =   120
      TabIndex        =   4
      Top             =   4440
      Width           =   6255
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "Default"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5520
      TabIndex        =   3
      Top             =   1080
      Width           =   855
   End
   Begin VB.TextBox dest 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2280
      TabIndex        =   1
      Text            =   "C:\Toolkit2\"
      Top             =   1080
      Width           =   3015
   End
   Begin VB.Label Label2 
      Caption         =   "The program will be installed into the following directory..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2280
      TabIndex        =   7
      Top             =   240
      Width           =   3975
   End
End
Attribute VB_Name = "setupform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub Command1_Click()
On Error GoTo insterr
    winsys$ = SystemDir
    destdir$ = dest.text
    If destdir$ = "" Then
        MsgBox "Please Fill In The Destination Directory!!!"
        dest.text = defaultdir$
        Exit Sub
    End If
    winsys$ = resolve(winsys$)
    destdir$ = resolve(destdir$)
    
    Call CreateDir(destdir$)
    If ea <> 0 Then
        If ea = 75 Then ea = 0  'dir already exists
        If ea = 76 Then
            MsgBox "The installation directory structure is not correct!" + Chr$(13) + "It probably contains invalid characters.", , "Cannot install!"
            'sysdir.Text = "C:\Windows\System\"
            dest.text = "C:\Program Files\Toolkit2\"
            Exit Sub
        End If
    End If
    MkDir (destdir$)
    
    'a = MsgBox("Is This Information Correct?" + Chr$(13) + "Installation Directory: " + destdir$, 4, "Confirmation")
    'If a = 6 Then
        'makedir$ = unresolve(destdir$)
        'MkDir makedir$
    
    Call runSetup
    'End If
Exit Sub
insterr:
ea = Err
Resume Next
End Sub

Private Sub Command2_Click()
    a = MsgBox("Installation is not complete! Are you sure you want to cancel?", 4, "Cancel")
    If a = 6 Then End
End Sub

Private Sub Command3_Click()
        dest.text = defaultdir$
        modified = 0
End Sub

Private Sub Command4_Click()
    eula.Show
    Unload setupform
End Sub

Private Sub Command5_Click()
    a$ = DirBrowse1.GetPath()
    If a$ <> "USERCANCEL" Then
        dest.text = a$
    End If
End Sub

Private Sub dest_Change()
    modified = 1
End Sub

Private Sub Form_Load()
    On Error Resume Next
    If smallImage <> "" And fileExist(mypath$ + smallImage) = 1 Then
        Picture1.Picture = LoadPicture(mypath$ + smallImage)
    End If
    
    setupform.ZOrder 0
    dest.text = destdir$
End Sub

Private Sub sysdir_Change()

End Sub


