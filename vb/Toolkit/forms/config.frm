VERSION 5.00
Begin VB.Form config 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Toolkit3 (Configuration)"
   ClientHeight    =   5250
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6540
   ControlBox      =   0   'False
   Icon            =   "config.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5250
   ScaleWidth      =   6540
   Tag             =   "1823"
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture2 
      BorderStyle     =   0  'None
      Height          =   2775
      Left            =   360
      ScaleHeight     =   2775
      ScaleWidth      =   5775
      TabIndex        =   8
      Top             =   360
      Width           =   5775
      Begin VB.PictureBox wallpaperthumb 
         AutoRedraw      =   -1  'True
         Height          =   2250
         Left            =   2520
         ScaleHeight     =   2190
         ScaleWidth      =   2940
         TabIndex        =   10
         Top             =   0
         Width           =   3000
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Change"
         Height          =   345
         Left            =   0
         TabIndex        =   9
         Tag             =   "1829"
         Top             =   2280
         Width           =   1095
      End
      Begin VB.Label wallpath 
         Alignment       =   1  'Right Justify
         Caption         =   "path"
         Height          =   255
         Left            =   1200
         TabIndex        =   11
         Tag             =   "1830"
         Top             =   2400
         Width           =   4335
      End
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   1095
      Left            =   360
      ScaleHeight     =   1095
      ScaleWidth      =   5895
      TabIndex        =   2
      Top             =   3840
      Width           =   5895
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   0
         TabIndex        =   7
         Text            =   "Combo1"
         Top             =   0
         Width           =   1695
      End
      Begin VB.CheckBox qlenabled 
         Caption         =   "Enabled"
         Height          =   255
         Left            =   0
         TabIndex        =   6
         Tag             =   "1825"
         Top             =   480
         Width           =   1455
      End
      Begin VB.TextBox qltarget 
         Height          =   285
         Left            =   1920
         TabIndex        =   5
         Top             =   0
         Width           =   2775
      End
      Begin VB.CommandButton qlicon 
         Height          =   480
         Left            =   2400
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   360
         Width           =   480
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   4800
         TabIndex        =   3
         Tag             =   "1021"
         Top             =   0
         Width           =   1095
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "QuickLaunch"
      Height          =   1575
      Left            =   240
      TabIndex        =   1
      Tag             =   "1824"
      Top             =   3480
      Width           =   6135
   End
   Begin VB.Frame Frame1 
      Caption         =   "Wallpaper"
      Height          =   3135
      Left            =   240
      TabIndex        =   0
      Tag             =   "1828"
      Top             =   120
      Width           =   6015
   End
End
Attribute VB_Name = "config"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Public Property Get formType() As Long
    formType = FT_CONFIG
End Property

Private Sub fillQuick(ByVal num As Long)
    'fill quick launch info with info about the
    On Error Resume Next
    'num-th quick launch item
    qltarget.Text = configfile.quickTarget(num)
    qlenabled.value = configfile.quickEnabled(num)
    If fileExists(configfile.quickIcon$(num)) Then
        qlicon.Picture = LoadPicture(configfile.quickIcon$(num))
    Else
        qlicon.Picture = LoadPicture("")
    End If
End Sub

Private Sub ShowPic()
    'loads a file into a picture box and resizes it.
    On Error Resume Next
    Dim f As String
    If fileExists(resourcePath$ & configfile.wallpaper$) Then
        f$ = resourcePath$ & configfile.wallpaper$
    Else
        If fileExists(configfile.wallpaper$) Then
            f$ = configfile.wallpaper$
        Else
            f$ = ""
        End If
    End If
    If f$ <> "" Then
        Call DrawSizedImage(f$, 0, 0, wallpaperthumb.Width / Screen.TwipsPerPixelX, wallpaperthumb.Height / Screen.TwipsPerPixelY, vbPicHDC(wallpaperthumb))
        Call vbPicRefresh(wallpaperthumb)
    End If
End Sub

Private Sub infofill()
    'fill in info for this form
    On Error GoTo ErrorHandler
    
    'configfile.wallpaper infofill...
    Call ShowPic
    wallpath.Caption = configfile.wallpaper$
    
    'quicklaunch
    Combo1.Clear
    For t = 0 To 4
        Combo1.AddItem ("Button" + str$(t))
    Next t
    Combo1.Text = "Button 0"
    Call fillQuick(0)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Combo1_Click()
    On Error GoTo ErrorHandler
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    Call fillQuick(i)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = resourcePath$
    dlg.strTitle = "Select Image"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then 'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    configfile.wallpaper$ = filename$(1)
    wallpath.Caption = configfile.wallpaper$
    Call ShowPic
    Call tkMainForm.ShowPic(configfile.wallpaper$)
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strTitle = "Select Target"
    dlg.strDefaultExt = "exe"
    dlg.strFileTypes = "All files (*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then 'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        ChDir (currentDir$)
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    configfile.quickTarget(i) = filename$(1)
    qltarget.Text = configfile.quickTarget(i)
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call tkMainForm.configForm
End Sub

Private Sub qlenabled_Click()
    On Error GoTo ErrorHandler
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    configfile.quickEnabled(i) = qlenabled.value
    Call mainoption.fillQuick

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub qlicon_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = resourcePath$
    dlg.strTitle = "Select Image"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = "All Pictures|*.jpg;*.jpeg;*.bmp;*.wmf;*.gif|Bitmap (*.Bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|Jpeg Compressed (*.jpg)|*.jpg;*.jpeg|Windows Metafile (*.Wmf)|*.wmf|All files (*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then 'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    configfile.quickIcon$(i) = filename$(1)
    qlicon.Picture = LoadPicture(configfile.quickIcon$(i))
    Call mainoption.fillQuick
End Sub

Private Sub qltarget_Change()
    On Error Resume Next
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    configfile.quickTarget(i) = qltarget.Text
End Sub
