VERSION 5.00
Begin VB.Form import 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Import Ico, Bmp, Wmf"
   ClientHeight    =   1455
   ClientLeft      =   2010
   ClientTop       =   2985
   ClientWidth     =   3255
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
   Icon            =   "IMPORT.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1455
   ScaleWidth      =   3255
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1584"
   Begin VB.CheckBox chkFast 
      Caption         =   "Go back to tile after opening"
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
      Left            =   120
      TabIndex        =   4
      Top             =   1080
      Value           =   1  'Checked
      Width           =   3135
   End
   Begin VB.CommandButton cmdCancel 
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
      Left            =   2040
      TabIndex        =   3
      Top             =   600
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
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
      Left            =   2040
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
   Begin VB.PictureBox importpic 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   1320
      ScaleHeight     =   39
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   39
      TabIndex        =   1
      Top             =   120
      Width           =   615
   End
   Begin VB.CommandButton opentoconvert 
      Appearance      =   0  'Flat
      Caption         =   "Open Picture"
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
      Left            =   120
      TabIndex        =   0
      Tag             =   "1586"
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "import"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

'========================================================================
' The OK button
'========================================================================
Private Sub cmdOK_Click()
    On Error GoTo ErrorHandler
    
    saveChanges = True
    'Redraw
    activeTile.tileRedraw
    Unload import

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' !NEW! The cancel button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
    Unload Me
End Sub
'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load()
    ' Call LocalizeForm(Me)
    '!NEW! Set the variable to False at the start...
    saveChanges = False
End Sub
'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
   
    If saveChanges Then
    For x = 1 To 32
        For y = 1 To 32
            pixel = vbFrmPoint(importpic, x - 1, y - 1)
            tileMem(x, y) = pixel
        Next y
    Next x
    'Redraw
    activeTile.tileRedraw

    End If
End Sub

Private Sub opentoconvert_Click()
On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    
    dlg.strTitle = "Open Tile"
    dlg.strDefaultExt = "ico"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    '!NEW! Added this line so that the Dialog opens in the bitmap folder (NEW for 3.0.4)
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
    Else
        Exit Sub
    End If
    If filename$(1) = "" Then Exit Sub
    thextention$ = extention(filename$(1))
    'If UCase$(thextention$) = "GIF" Then
    '    dummy = GifToBMP(filename$(1), "rpgscrtc.bmp")
    '    filename$(1) = "rpgscrtc.bmp"
    'End If
    'importpic.Picture = LoadPicture(filename$(1))
    Call vbPicAutoRedraw(importpic, True)
    Call drawImage(filename$(1), 0, 0, vbPicHDC(importpic))
    Call vbPicRefresh(importpic)
    ChDir (currentDir$)
    
    '!NEW! Go back to the tile if the checkbox is checked (NEW for 3.0.4)
    If chkFast.value = 1 Then Call cmdOK_Click
End Sub

