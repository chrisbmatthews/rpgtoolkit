VERSION 5.00
Begin VB.Form transPlayerSwap 
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
   ScaleHeight     =   480
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   640
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1980"
   Begin VB.Timer eventTimer 
      Interval        =   1
      Left            =   360
      Top             =   2040
   End
   Begin VB.CommandButton Command3 
      Caption         =   "OK"
      Default         =   -1  'True
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
   Begin VB.ListBox oPlayers 
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
   Begin VB.ListBox cPlayers 
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
Attribute VB_Name = "transPlayerSwap"
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
' Player swap window -- needs serious re-writing!!!
' Status: C-
'=========================================================================

Option Explicit

'=========================================================================
' Win32 APIs
'=========================================================================
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

'=========================================================================
' Fill in this form
'=========================================================================
Private Sub infoFill()
    Call cPlayers.clear
    Call oPlayers.clear
    Dim playerIdx As Long
    For playerIdx = 0 To UBound(playerListAr)
        Call cPlayers.addItem(playerListAr(playerIdx))
    Next playerIdx
    For playerIdx = 0 To UBound(otherPlayersHandle)
        Call oPlayers.addItem(otherPlayersHandle(playerIdx))
    Next playerIdx
End Sub

'=========================================================================
' Skin this window
'=========================================================================
Private Sub skin()
    On Error Resume Next
    If mainMem.skinWindow$ <> "" Then
        Call vbFrmAutoRedraw(Me, True)
        If pakFileRunning Then
            Call drawImage(PakLocate(bmpPath$ & mainMem.skinWindow$), 0, 0, vbFrmHDC(Me))
        Else
            Call drawImage(projectPath$ & bmpPath$ & mainMem.skinWindow$, 0, 0, vbFrmHDC(Me))
        End If
        Call vbFrmRefresh(Me)
    End If
    If mainMem.skinButton$ <> "" Then
        If pakFileRunning Then
            Dim theFile As String
            theFile = PakLocate(bmpPath$ & mainMem.skinButton$)
            Command1.Picture = LoadPicture(theFile)
            Command2.Picture = LoadPicture(theFile)
            Command3.Picture = LoadPicture(theFile)
        Else
            Command1.Picture = LoadPicture(projectPath$ & bmpPath$ & mainMem.skinButton$)
            Command2.Picture = LoadPicture(projectPath$ & bmpPath$ & mainMem.skinButton$)
            Command3.Picture = LoadPicture(projectPath$ & bmpPath$ & mainMem.skinButton$)
        End If
    End If
End Sub

'=========================================================================
' Restore player button clicked
'=========================================================================
Private Sub Command1_Click()
    On Error Resume Next
    Dim rV As RPGCODE_RETURN
    If otherPlayers(oPlayers.ListIndex) <> "" Then
        Call DoIndependentCommand("RestorePlayer(" & otherPlayers(oPlayers.ListIndex) & ")", rV)
        otherPlayers(oPlayers.ListIndex) = ""
        otherPlayersHandle(oPlayers.ListIndex) = ""
        Call infoFill
    End If
End Sub

'=========================================================================
' Remove player button clicked
'=========================================================================
Private Sub Command2_Click()
    On Error Resume Next
    Dim rV As RPGCODE_RETURN
    If cPlayers.ListIndex = -1 Or cPlayers.ListIndex = 0 Then
        Call MBox(LoadStringLoc(855, "You cannot remove the first player"), LoadStringLoc(856, "Remove Player"), 0, menuColor, projectPath$ & bmpPath$ & mainMem.skinWindow$, projectPath$ & bmpPath$ & mainMem.skinButton$)
    Else
        If playerListAr(cPlayers.ListIndex) <> "" Then
            Call DoIndependentCommand("RemovePlayer(" & playerListAr(cPlayers.ListIndex) & ")", rV)
            Call infoFill
        End If
    End If
End Sub

'=========================================================================
' Close button clicked
'=========================================================================
Private Sub Command3_Click()
    Call Unload(Me)
End Sub

'=========================================================================
' Don't lock up
'=========================================================================
Private Sub eventTimer_Timer()
    Call processEvent
End Sub

'=========================================================================
' Form loaded
'=========================================================================
Private Sub Form_Load()
    On Error Resume Next
    Dim theColor As Long
    theColor = RGB(red(menuColor) + 128, green(menuColor) + 128, blue(menuColor) + 128)
    cPlayers.BackColor = theColor
    oPlayers.BackColor = theColor
    Call skin
    Call infoFill
    With Me
        If Not usingFullScreen() Then
            Call SetParent(.hwnd, host.hwnd)
        Else
            Call host.Hide
        End If
        .Left = 0
        .Top = 0
        .Width = host.Width
        .height = host.height
    End With
End Sub

'=========================================================================
' Form unloaded
'=========================================================================
Private Sub Form_Unload(ByRef Cancel As Integer)
    If usingFullScreen() Then
        Call host.Show
    End If
End Sub
