VERSION 5.00
Begin VB.Form skinedit 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Skin"
   ClientHeight    =   1935
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6780
   Icon            =   "skinedit.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   6780
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1733"
   Begin VB.Frame Frame1 
      Caption         =   "Skin Editor"
      Height          =   1575
      Left            =   120
      TabIndex        =   1
      Tag             =   "1736"
      Top             =   120
      Width           =   5295
      Begin VB.CommandButton Command2 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   3960
         Style           =   1  'Graphical
         TabIndex        =   7
         Tag             =   "1021"
         Top             =   960
         Width           =   1095
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   1920
         TabIndex        =   6
         Top             =   960
         Width           =   1935
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   3960
         Style           =   1  'Graphical
         TabIndex        =   4
         Tag             =   "1021"
         Top             =   480
         Width           =   1095
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   1920
         TabIndex        =   3
         Top             =   480
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Window Graphic"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Tag             =   "1734"
         Top             =   960
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "Button Graphic"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Tag             =   "1735"
         Top             =   480
         Width           =   1695
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "OK"
      Height          =   345
      Left            =   5520
      Style           =   1  'Graphical
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "skinedit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public Sub skin()
On Error Resume Next
    'skinifies this form.
    If mainMem.skinButton$ <> "" Then
        Command1.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinButton$)
        Command2.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinButton$)
        Command3.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinButton$)
    Else
        Command1.Picture = LoadPicture("")
        Command2.Picture = LoadPicture("")
        Command3.Picture = LoadPicture("")
    End If
    If mainMem.skinWindow$ <> "" Then
        'skinedit.Picture = LoadPicture(projectPath$ + bmppath$ + mainMem.skinWindow$)
        Call vbFrmAutoRedraw(skinedit, True)
        Call DrawImage(projectPath$ + bmppath$ + mainMem.skinWindow$, 0, 0, vbFrmHDC(skinedit))
        Call vbFrmRefresh(skinedit)
    Else
        skinedit.Picture = LoadPicture("")
    End If
    Text1.text = mainMem.skinButton$
    Text2.text = mainMem.skinWindow$
End Sub


Private Sub Command1_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmppath$
    
    dlg.strTitle = "Select Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = "All Pictures|*.jpg;*.jpeg;*.bmp;*.wmf;*.gif|Bitmap (*.Bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|Jpeg Compressed (*.jpg)|*.jpg;*.jpeg|Windows Metafile (*.Wmf)|*.wmf|All files (*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgNeedUpdate = True
    
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmppath$ + antiPath$
    mainMem.skinButton$ = antiPath$
    Text1.text = antiPath$
    Call skin
End Sub

Private Sub toc_Click()
    On Error GoTo errorhandler
    Call BrowseFile(helppath$ + ObtainCaptionFromTag(DB_Help1, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmppath$
    
    dlg.strTitle = "Select Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    bkgNeedUpdate = True
    
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmppath$ + antiPath$
    mainMem.skinWindow$ = antiPath$
    Text2.text = antiPath$
    Call skin
End Sub


Private Sub Command3_Click()
    On Error GoTo errorhandler
    Unload skinedit

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    mainMem.skinButton$ = ""
    bgname.caption = LoadStringLoc(1010, "None")
    Call skin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command5_Click()
    On Error GoTo errorhandler
    mainMem.skinWindow$ = ""
    wgname.caption = LoadStringLoc(1010, "None")
    Call skin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Call skin

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Text1_Change()
    mainMem.skinButton$ = Text1.text
End Sub


Private Sub Text2_Change()
    mainMem.skinWindow$ = Text2.text
End Sub


