VERSION 5.00
Begin VB.Form Version1Palette 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "DOS Color Palette (16 Colors)"
   ClientHeight    =   2400
   ClientLeft      =   2775
   ClientTop       =   2550
   ClientWidth     =   4320
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
   Icon            =   "VERSION1.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2400
   ScaleWidth      =   4320
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1842"
   Begin VB.TextBox colcode 
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
      Left            =   2640
      TabIndex        =   3
      Top             =   1200
      Width           =   1455
   End
   Begin VB.CommandButton selectdoscol 
      Appearance      =   0  'Flat
      Caption         =   "Close"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   3120
      TabIndex        =   0
      Tag             =   "1088"
      Top             =   120
      Width           =   1095
   End
   Begin VB.PictureBox doscurrentcol 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   3480
      ScaleHeight     =   39
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   39
      TabIndex        =   2
      Top             =   1680
      Width           =   615
   End
   Begin VB.PictureBox dospal 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   2415
      Left            =   0
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   159
      TabIndex        =   1
      Top             =   0
      Width           =   2415
   End
   Begin VB.Label Label1 
      Caption         =   "Color Code:"
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
      Left            =   2640
      TabIndex        =   4
      Tag             =   "1843"
      Top             =   960
      Width           =   1455
   End
End
Attribute VB_Name = "Version1Palette"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What needs to be done
' + Add Option Explicit
' + Apply new visual style
' + Standardize
'
'=======================================================

Private Sub colcode_Change()
    On Error GoTo ErrorHandler
    If val(colcode.text) > 255 Then colcode.text = "255"
    If val(colcode.text) < 0 Then colcode.text = "0"
    Call vbPicFillRect(doscurrentcol, 0, 0, 100, 100, GFXGetDOSColor(val(colcode.text)))
    publicTile.currentColor = GFXGetDOSColor(val(colcode.text))
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub dospal_MouseDown(button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo ErrorHandler
    
    xx = Int((x / 10))
    yy = Int((y / 10))
    thecolor = yy * 16 + xx
    Call vbPicFillRect(doscurrentcol, 0, 0, 100, 100, GFXGetDOSColor(thecolor))
    colcode.text = str$(thecolor)
    publicTile.currentColor = GFXGetDOSColor(thecolor)
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
    If detail <> 1 And detail <> 2 Then
        If detail = 3 Or detail = 4 Then
        publicTile.currentColor = thecolor
        End If
        If detail = 5 Or detail = 6 Then
        publicTile.currentColor = toColor(publicTile.currentColor, "16")
        End If
        Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, GFXGetDOSColor(publicTile.currentColor))
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    x = 0
    color = 0
    For yy = 0 To 15
        For xx = 0 To 15
            Call vbPicFillRect(dospal, xx * 10, yy * 10, xx * 10 + 8, yy * 10 + 8, GFXGetDOSColor(color))
            color = color + 1
        Next xx
    Next yy
    Call vbPicRefresh(dospal)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub selectdoscol_Click()
    On Error GoTo ErrorHandler
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
    Unload Version1Palette

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

