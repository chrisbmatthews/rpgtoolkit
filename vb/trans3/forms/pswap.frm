VERSION 5.00
Begin VB.Form pswap 
   Appearance      =   0  'Flat
   BackColor       =   &H00404040&
   BorderStyle     =   0  'None
   Caption         =   "Player Selection"
   ClientHeight    =   7200
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9600
   Icon            =   "pswap.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7200
   ScaleWidth      =   9600
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1980"
   Begin VB.CommandButton Command3 
      Caption         =   "OK"
      Height          =   375
      Left            =   7800
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "1022"
      Top             =   6600
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "-->"
      Height          =   495
      Left            =   4440
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   3600
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "<--"
      Height          =   495
      Left            =   4440
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   2640
      Width           =   495
   End
   Begin VB.ListBox oplayers 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4590
      Left            =   5160
      TabIndex        =   1
      Top             =   1320
      Width           =   3135
   End
   Begin VB.ListBox cplayers 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4590
      Left            =   1080
      TabIndex        =   0
      Top             =   1320
      Width           =   3135
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Player Selection"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   15.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   120
      TabIndex        =   7
      Tag             =   "1980"
      Top             =   120
      Width           =   7095
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Available Players:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   5160
      TabIndex        =   5
      Tag             =   "1983"
      Top             =   960
      Width           =   2295
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Current Party:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1080
      TabIndex        =   4
      Tag             =   "1984"
      Top             =   960
      Width           =   1815
   End
End
Attribute VB_Name = "pswap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Sub infofill()
    On Error GoTo errorhandler
    cplayers.Clear
    For t = 0 To 4
        cplayers.AddItem (playerListAr$(t))
    Next t
    oplayers.Clear
    For t = 0 To 25
        oplayers.AddItem (otherPlayersHandle$(t))
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub skin()
    'skins this window
    On Error Resume Next
    If mainMem.skinWindow$ <> "" Then
        Call vbFrmAutoRedraw(pswap, True)
        If PakFileRunning Then
            f$ = PakLocate(bmpPath$ + mainMem.skinWindow$)
            'pswap.Picture = LoadPicture(F$)
            Call DrawImage(f$, 0, 0, vbFrmHDC(pswap))
        Else
            'pswap.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinWindow$)
            Call DrawImage(projectPath$ + bmpPath$ + mainMem.skinWindow$, 0, 0, vbFrmHDC(pswap))
        End If
        Call vbFrmRefresh(pswap)
    End If
    If mainMem.skinButton$ <> "" Then
        If PakFileRunning Then
            f$ = PakLocate(bmpPath$ + mainMem.skinButton$)
            Command1.Picture = LoadPicture(f$)
            Command2.Picture = LoadPicture(f$)
            Command3.Picture = LoadPicture(f$)
        Else
            Command1.Picture = LoadPicture(projectPath$ + bmpPath$ + mainMem.skinButton$)
            Command2.Picture = LoadPicture(projectPath$ + bmpPath$ + mainMem.skinButton$)
            Command3.Picture = LoadPicture(projectPath$ + bmpPath$ + mainMem.skinButton$)
        End If
    End If
End Sub

Private Sub Command1_Click()
    On Error GoTo errorhandler
    num = oplayers.ListIndex
    If otherPlayers$(num) <> "" Then
        Dim aProgram As RPGCodeProgram
        ReDim aProgram.program(10)
        aProgram.boardNum = -1
        Call RestorePlayerRPG("#RestorePlayer(" + otherPlayers$(num) + ")", aProgram)
        otherPlayers$(num) = ""
        otherPlayersHandle$(num) = ""
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    num = cplayers.ListIndex
    If num = -1 Or num = 0 Then
        abc = MBox(LoadStringLoc(855, "You cannot remove the first player"), LoadStringLoc(856, "Remove Player"), 0, menuColor, projectPath$ + bmpPath$ + mainMem.skinWindow$, projectPath$ + bmpPath$ + mainMem.skinButton$)
        'MsgBox "You cannot remove the first player"
        Exit Sub
    End If
    If playerListAr$(num) <> "" Then
        Dim aProgram As RPGCodeProgram
        ReDim aProgram.program(10)
        aProgram.boardNum = -1
        Call RemovePlayerRPG("#RemovePlayer(" + playerListAr$(num) + ")", aProgram)
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command3_Click()
    On Error GoTo errorhandler
    Unload pswap

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command4_Click()

End Sub


Private Sub Form_Activate()
    Call skin

End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    shopwindow.BackColor = menuColor
    rr = red(menuColor)
    gg = green(menuColor)
    bb = blue(menuColor)
    cplayers.BackColor = RGB(rr + 128, gg + 128, bb + 128)
    oplayers.BackColor = RGB(rr + 128, gg + 128, bb + 128)
    Call skin
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


