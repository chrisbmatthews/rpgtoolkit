VERSION 5.00
Begin VB.Form config 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Toolkit.exe Configuration"
   ClientHeight    =   5355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6540
   Icon            =   "config.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5355
   ScaleWidth      =   6540
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1823"
   Begin VB.Frame Frame2 
      Caption         =   "QuickLaunch"
      Height          =   1575
      Left            =   240
      TabIndex        =   4
      Tag             =   "1824"
      Top             =   3480
      Visible         =   0   'False
      Width           =   6135
      Begin VB.CommandButton Command2 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   4920
         TabIndex        =   11
         Tag             =   "1021"
         Top             =   600
         Width           =   1095
      End
      Begin VB.CommandButton qlicon 
         Height          =   480
         Left            =   2520
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   960
         Width           =   480
      End
      Begin VB.TextBox qltarget 
         Height          =   285
         Left            =   2040
         TabIndex        =   8
         Top             =   600
         Width           =   2775
      End
      Begin VB.CheckBox qlenabled 
         Caption         =   "Enabled"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Tag             =   "1825"
         Top             =   1080
         Width           =   1455
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   120
         TabIndex        =   5
         Text            =   "Combo1"
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label Label2 
         Caption         =   "Icon"
         Height          =   255
         Left            =   2040
         TabIndex        =   9
         Tag             =   "1826"
         Top             =   960
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "Target"
         Height          =   255
         Left            =   2040
         TabIndex        =   7
         Tag             =   "1827"
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Wallpaper"
      Height          =   3135
      Left            =   240
      TabIndex        =   0
      Tag             =   "1828"
      Top             =   120
      Width           =   6015
      Begin VB.CommandButton Command1 
         Caption         =   "Change"
         Height          =   345
         Left            =   240
         TabIndex        =   2
         Tag             =   "1829"
         Top             =   2280
         Width           =   1095
      End
      Begin VB.PictureBox wallpaperthumb 
         AutoRedraw      =   -1  'True
         Height          =   2250
         Left            =   2760
         ScaleHeight     =   2190
         ScaleWidth      =   2940
         TabIndex        =   1
         Top             =   360
         Width           =   3000
      End
      Begin VB.Label wallpath 
         Alignment       =   1  'Right Justify
         Caption         =   "path"
         Height          =   255
         Left            =   1440
         TabIndex        =   3
         Tag             =   "1830"
         Top             =   2760
         Width           =   4335
      End
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

Sub fillQuick(num)
    'fill quick launch info with info about the
On Error Resume Next
    
    'num-th quick launch item
    qltarget.text = quickTarget(num)
    qlenabled.value = quickEnabled(num)
    If FileExists(quickIcon$(num)) Then
        qlicon.Picture = LoadPicture(quickIcon$(num))
    Else
        qlicon.Picture = LoadPicture("")
    End If
End Sub


Sub ShowPic()
    'loads a file into a picture box and resizes it.
On Error Resume Next
    If FileExists(resourcePath$ + wallpaper$) Then
        f$ = resourcePath$ + wallpaper$
    Else
        If FileExists(wallpaper$) Then
            f$ = wallpaper$
        Else
            f$ = ""
        End If
    End If
    If f$ <> "" Then
        'mainoption.PicClip1.Picture = LoadPicture(f$)
        'mainoption.PicClip1.ClipX = 0
        'mainoption.PicClip1.ClipY = 0
        'mainoption.PicClip1.ClipHeight = mainoption.PicClip1.height
        'mainoption.PicClip1.ClipWidth = mainoption.PicClip1.width
        'mainoption.PicClip1.StretchX = wallpaperthumb.width / Screen.TwipsPerPixelX
        'mainoption.PicClip1.StretchY = wallpaperthumb.height / Screen.TwipsPerPixelY
        'wallpaperthumb.Picture = mainoption.PicClip1.Clip
        Call DrawSizedImage(f$, 0, 0, wallpaperthumb.width / Screen.TwipsPerPixelX, wallpaperthumb.height / Screen.TwipsPerPixelY, vbPicHDC(wallpaperthumb))
        Call vbPicRefresh(wallpaperthumb)
    Else
    End If
End Sub



Sub infofill()
    'fill in info for this form
    On Error GoTo errorhandler
    
    'wallpaper infofill...
    Call ShowPic
    wallpath.caption = wallpaper$
    
    'quicklaunch
    Combo1.Clear
    For t = 0 To 4
        Combo1.AddItem ("Button" + str$(t))
    Next t
    Combo1.text = "Button 0"
    Call fillQuick(0)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Combo1_Click()
    On Error GoTo errorhandler
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    Call fillQuick(i)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    wallpaper$ = filename$(1)
    wallpath.caption = wallpaper$
    Call ShowPic
    Call tkMainForm.ShowPic(wallpaper$)
End Sub


Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strTitle = "Select Target"
    dlg.strDefaultExt = "exe"
    dlg.strFileTypes = "All files (*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then 'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        ChDir (currentdir$)
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    quickTarget(i) = filename$(1)
    qltarget.text = quickTarget(i)
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub qlenabled_Click()
    On Error GoTo errorhandler
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    quickEnabled(i) = qlenabled.value
    Call mainoption.fillQuick

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub qlicon_Click()
    On Error Resume Next
    ChDir (currentdir$)
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
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    quickIcon$(i) = filename$(1)
    qlicon.Picture = LoadPicture(quickIcon$(i))
    Call mainoption.fillQuick
End Sub

Private Sub qltarget_Change()
    On Error Resume Next
    i = Combo1.ListIndex
    If i = -1 Then i = 0
    quickTarget(i) = qltarget.text
End Sub

