VERSION 5.00
Begin VB.Form fightmenu 
   Appearance      =   0  'Flat
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Fight Menu"
   ClientHeight    =   1290
   ClientLeft      =   75
   ClientTop       =   5385
   ClientWidth     =   9480
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
   Icon            =   "FIGHTMEN.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1290
   ScaleWidth      =   9480
   Tag             =   "1919"
   Begin VB.Timer Timer4 
      Interval        =   1000
      Left            =   1920
      Top             =   840
   End
   Begin VB.Timer characterscan 
      Interval        =   50
      Left            =   5400
      Top             =   840
   End
   Begin VB.Timer Timer3 
      Interval        =   40
      Left            =   8040
      Top             =   840
   End
   Begin VB.Timer Timer2 
      Interval        =   40
      Left            =   120
      Top             =   480
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Execute"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2040
      Style           =   1  'Graphical
      TabIndex        =   12
      Tag             =   "1920"
      Top             =   120
      Width           =   735
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   8040
      Top             =   120
   End
   Begin VB.ListBox action 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1110
      Left            =   2760
      TabIndex        =   11
      Top             =   120
      Width           =   2055
   End
   Begin VB.PictureBox hpbox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   4
      Left            =   8520
      ScaleHeight     =   186.667
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   10
      Top             =   1000
      Width           =   855
   End
   Begin VB.PictureBox hpbox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   3
      Left            =   8520
      ScaleHeight     =   186.667
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   9
      Top             =   780
      Width           =   855
   End
   Begin VB.PictureBox hpbox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   2
      Left            =   8520
      ScaleHeight     =   186.667
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   8
      Top             =   560
      Width           =   855
   End
   Begin VB.PictureBox hpbox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   1
      Left            =   8520
      ScaleHeight     =   186.667
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   7
      Top             =   340
      Width           =   855
   End
   Begin VB.PictureBox hpbox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   0
      Left            =   8520
      ScaleHeight     =   186.667
      ScaleMode       =   0  'User
      ScaleWidth      =   100
      TabIndex        =   6
      Top             =   120
      Width           =   855
   End
   Begin VB.Label playerbox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   4
      Left            =   4920
      TabIndex        =   5
      Top             =   1000
      Width           =   4455
   End
   Begin VB.Label playerbox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   3
      Left            =   4920
      TabIndex        =   4
      Top             =   780
      Width           =   4455
   End
   Begin VB.Label playerbox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   2
      Left            =   4920
      TabIndex        =   3
      Top             =   560
      Width           =   4455
   End
   Begin VB.Label playerbox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   1
      Left            =   4920
      TabIndex        =   2
      Top             =   340
      Width           =   4455
   End
   Begin VB.Label playerbox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   235
      Index           =   0
      Left            =   4920
      TabIndex        =   1
      Top             =   120
      Width           =   4455
   End
   Begin VB.Label enemybox 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
End
Attribute VB_Name = "fightmenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub skin()
    'skins this window
    On Error Resume Next
    If fightMenuGraphic$ = "" Then
        If mainMem.skinWindow$ <> "" Then
            Call vbFrmAutoRedraw(fightmenu, True)
            If PakFileRunning Then
                F$ = PakLocate(bmppath$ + mainMem.skinWindow$)
                'fightmenu.Picture = LoadPicture(F$)
                Call DrawImage(F$, 0, 0, vbFrmHDC(fightmenu))
            Else
                'fightmenu.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinWindow$)
                Call DrawImage(projectPath$ + bmppath$ + mainMem.skinWindow$, 0, 0, vbFrmHDC(fightmenu))
            End If
            Call vbFrmRefresh(fightmenu)
        End If
    End If
    If mainMem.skinButton$ <> "" Then
        If PakFileRunning Then
            F$ = PakLocate(bmppath$ + mainMem.skinButton$)
            Command1.Picture = LoadPicture(F$)
        Else
            Command1.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinButton$)
        End If
    End If

End Sub


Private Sub action_Click()
    On Error GoTo errorhandler
    'playWav (projectPath$ + mediapath$ + bkgSelWav$)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub action_DblClick()
    On Error GoTo errorhandler
    Call Command1_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub action_KeyDown(KeyCode As Integer, Shift As Integer)
    'MsgBox KeyCode
    'MsgBox Shift
End Sub

Private Sub action_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call Command1_Click

End Sub

Private Sub characterscan_Timer()
'scans to see who goes next.
'disabled while player is running.
'enabled when player is done.
'see if anyone is ready:
    On Error GoTo errorhandler
    If battleOver = 1 Then Unload fightmenu: Exit Sub

    'look for someone who is ready:
    theone = -1
    For t = 0 To 30
        If queue(t) <> -1 Then theone = queue(t): t = 30
    Next t
    
    'No one right now:
    If theone = -1 Then Exit Sub
        'MsgBox queue(0) + "fight"
        'MsgBox queue(1) + "fight"
        'MsgBox queue(2) + "fight"
    
    'shift the array contents.
    For t = 1 To 30
        queue(t - 1) = queue(t)
    Next t


    'cause this person to fight:
    'Call playerFight(theone)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub Command1_Click()
    On Error GoTo errorhandler
    nn = action.ListIndex
    If nn = -1 Then nn = 0
    'playWav (projectPath$ + mediapath$ + bkgChooseWav$)
    If meenumode = 0 Then
        'Call outMenu(nn)
    End If
    If meenumode = 1 Then
        'Call fightMnu(nn)
    End If
    
    'Item Selection
    If meenumode = 3 Then
        'Call itemMenu(nn)
    End If
    If meenumode = 4 Then
        'Call useItemMenu(nn)
    End If
    
    'Special moves
    If meenumode = 5 Then
        'Call moveMenu(nn)
    End If
    If meenumode = 6 Then
        'Call useMoveMenu(nn)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    Call skin

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    On Error GoTo errorhandler
keyWaitState = KeyCode
keyShiftState = Shift
Call action_KeyDown(KeyCode, Shift)
    If fightInProgress = True And fightmenu.Command1.Enabled = True Then
        'a fight is in progress.
        If KeyCode = 38 Then
            'pushed 'up'
            If fightmenu.action.ListIndex > 0 Then
                fightmenu.action.ListIndex = fightmenu.action.ListIndex - 1
            Else
                fightmenu.action.ListIndex = fightmenu.action.ListCount - 1
            End If
        End If
        If KeyCode = 40 Then
            'pushed 'down'
            If fightmenu.action.ListCount > fightmenu.action.ListIndex + 1 Then
                fightmenu.action.ListIndex = fightmenu.action.ListIndex + 1
            Else
                fightmenu.action.ListIndex = 0
            End If
        End If
        If KeyCode = 32 Or KeyCode = 13 Then
            'activation key
               fightmenu.Command1_Click
        End If
        Exit Sub
    End If
    If fightInProgress = True Then Exit Sub

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
        'use graphic
        Call vbFrmAutoRedraw(fightmenu, True)
        If PakFileRunning Then
            F$ = PakLocate(bmppath$ + fightMenuGraphic$)
            'fightmenu.Picture = LoadPicture(F$)
            Call DrawImage(F$, 0, 0, vbFrmHDC(fightmenu))
        Else
            'fightmenu.Picture = LoadPicture(projectPath$ + bmppath$ + fightMenuGraphic$)
            Call DrawImage(projectPath$ + bmppath$ + fightMenuGraphic$, 0, 0, vbFrmHDC(fightmenu))
        End If
        Call vbFrmRefresh(fightmenu)
    Call skin
    yy = screenHeight
    my = fightmenu.height
    loca = yy - my
    fightmenu.Top = loca

    xx = (screenWidth)
    mx = fightmenu.width
    loca = (xx - mx) / 2
    fightmenu.Left = loca

    fightmenu.Top = screenHeight - fightmenu.height

    fightmenu.action.Clear
    fightmenu.action.AddItem (LoadStringLoc(902, "Fight"))
    

    Select Case BattleSpeed
        Case 0:
            Timer3.interval = 40
            Timer2.interval = 50
        Case 1:
            Timer3.interval = 35
            Timer2.interval = 45
        Case 2:
            Timer3.interval = 30
            Timer2.interval = 40
        Case 3:
            Timer3.interval = 25
            Timer2.interval = 35
        Case 4:
            Timer3.interval = 20
            Timer2.interval = 30
        Case 5:
            Timer3.interval = 15
            Timer2.interval = 25
        Case 6:
            Timer3.interval = 10
            Timer2.interval = 20
        Case 7:
            Timer3.interval = 5
            Timer2.interval = 15
        Case 8:
            Timer3.interval = 1
            Timer2.interval = 10
    End Select
End Sub

Private Sub Timer1_Timer()
On Error Resume Next
    If battleOver = 1 Then Unload fightmenu: Exit Sub
    fightmenu.Show
    If updown = 0 Then
        notch = notch - 10
        If notch <= 10 Then updown = 1
    Else
        notch = notch + 10
        If notch >= 250 Then updown = 0
    End If
    If notch < 0 Then notch = 0
    If currentc < 0 Then bb = 0 Else bb = currentc
    fightmenu.playerbox(bb).ForeColor = RGB(255 - notch, notch, 255)
    For t = 0 To 4
        If playerListAr$(t) <> "" And t <> bb Then
            fightmenu.playerbox(t).ForeColor = RGB(0, 0, 0)
        End If
    Next t
    For t = 0 To 4
        If playerListAr$(t) <> "" Then
            Call vbPicFillRect(fightmenu.hpbox(t), 0, 175, 100, 200, RGB(100, 100, 100))
            If playerCharge(t) <= 0 Then
                frac = 0
            Else
                frac = Int(playerCharge(t))
            End If
            If frac <> 0 Then
                For ll = 0 To frac
                    'fightmenu.hpbox(t).Line (ll, 175)-(ll, 200), RGB(0, ll * 2.5, 255), BF
                    If playerStop(t) = False Then
                        Select Case playerChargeIncr(t)
                            Case 5:
                                'fast...
                                Call vbPicFillRect(fightmenu.hpbox(t), ll, 175, ll, 200, RGB(ll * 2.5, 0, 0))
                        
                            Case 1:
                                'slow...
                                Call vbPicFillRect(fightmenu.hpbox(t), ll, 175, ll, 200, RGB(0, 0, ll * 2.5))
                        
                            Case 3:
                                'normal
                                Call vbPicFillRect(fightmenu.hpbox(t), ll, 175, ll, 200, RGB(255, 255 - ll * 2.5, ll * 2.5))
                        End Select
                    Else
                        'stopped
                        Call vbPicFillRect(fightmenu.hpbox(t), ll, 175, ll, 200, RGB(ll * 2.5, ll * 2.5, ll * 2.5))
                    End If
                Next ll
            End If
        End If
    Next t
End Sub

Private Sub Timer2_Timer()
'active time battle for enemies.
'when charge reaches 100, they will make a move.
    On Error GoTo errorhandler
    If battleOver = 1 Then Unload fightmenu: Exit Sub
    
    For t = 0 To numEne - 1
        eneCharge(t) = eneCharge(t) + enemyChargeIncr(t)
        If eneCharge(t) >= 180 And enemyMem(t).eneHP > 0 Then
            'do statuses...
            'Call useEnemyStatuses(eenum)
            eneCharge(t) = 0
            If enemyStop(t) = False Then
                'Call enemyMove(t)
            End If
            'Call updateEnemyStatuses(num)
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Timer3_Timer()
'active time battle for players.
'when charge reaches 100, they will make a move.
    On Error GoTo errorhandler
    If battleOver = 1 Then Unload fightmenu: Exit Sub
    For t = 0 To 4
        'the queue is only added to if
        'the player is not the current character, the player
        'exists, and the player is not dead.
        'also, if the player is not in the queue.
        If playerListAr$(t) <> "" And getHP(playerListAr$(t)) > 0 And currentc <> t Then
            todo = 0
            'check if the player is in the queue
            For ll = 0 To 30
                If queue(ll) = t Then todo = -1
            Next ll
            If todo = 0 Then
                playerCharge(t) = playerCharge(t) + playerChargeIncr(t)
                If playerCharge(t) >= 100 Then
                    'update statuses...
                    playerCharge(t) = 0
                    Call usePlayerStatuses(t)
                    If playerStop(t) = False Then
                        Call playerQueue(t)
                    End If
                    Call updatePlayerStatuses(t)
                End If
            End If
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Timer4_Timer()
    'checks music
    'MsgBox boardmusic$
    On Error GoTo errorhandler
    
    If battleOver = 1 Then Unload fightmenu: Exit Sub
    
    bWaitingForInput = False
    If boardList(activeBoardIndex).theData.boardMusic$ <> "" Then Call checkMusic

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

