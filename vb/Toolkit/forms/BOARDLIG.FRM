VERSION 5.00
Begin VB.Form boardlighting 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Lighting Effects"
   ClientHeight    =   4545
   ClientLeft      =   1410
   ClientTop       =   1665
   ClientWidth     =   6765
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
   Icon            =   "BOARDLIG.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   303
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   451
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1068"
   Begin VB.CommandButton OK 
      Appearance      =   0  'Flat
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
      Left            =   5160
      TabIndex        =   21
      Tag             =   "1022"
      Top             =   3960
      Width           =   1455
   End
   Begin VB.PictureBox shade 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   1680
      ScaleHeight     =   37
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   37
      TabIndex        =   20
      Top             =   3840
      Width           =   615
   End
   Begin VB.PictureBox lightcolor 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   5760
      ScaleHeight     =   37
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   37
      TabIndex        =   19
      Top             =   1680
      Width           =   615
   End
   Begin VB.TextBox amblevel 
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
      Left            =   6000
      TabIndex        =   17
      Text            =   "0"
      Top             =   2880
      Width           =   495
   End
   Begin VB.CommandButton resetwhite 
      Appearance      =   0  'Flat
      Caption         =   "Reset To Black"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4440
      TabIndex        =   13
      Tag             =   "1069"
      Top             =   240
      Width           =   2055
   End
   Begin VB.HScrollBar ambient 
      Height          =   255
      Left            =   480
      TabIndex        =   12
      Top             =   2880
      Width           =   5415
   End
   Begin VB.TextBox blueamvalue 
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
      Left            =   6000
      TabIndex        =   6
      Text            =   "0"
      Top             =   1320
      Width           =   495
   End
   Begin VB.TextBox greenamvalue 
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
      Left            =   6000
      TabIndex        =   5
      Text            =   "0"
      Top             =   960
      Width           =   495
   End
   Begin VB.TextBox redamval 
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
      Left            =   6000
      TabIndex        =   4
      Text            =   "0"
      Top             =   600
      Width           =   495
   End
   Begin VB.HScrollBar pullallambient 
      Height          =   255
      Left            =   1560
      TabIndex        =   3
      Top             =   1920
      Width           =   2895
   End
   Begin VB.HScrollBar blueambient 
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   1320
      Width           =   5055
   End
   Begin VB.HScrollBar greenambient 
      Height          =   255
      Left            =   840
      TabIndex        =   1
      Top             =   960
      Width           =   5055
   End
   Begin VB.HScrollBar redambient 
      Height          =   255
      Left            =   840
      TabIndex        =   0
      Top             =   600
      Width           =   5055
   End
   Begin VB.Label Label8 
      Caption         =   "Color Shade"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   18
      Tag             =   "1070"
      Top             =   3840
      Width           =   1335
   End
   Begin VB.Label Label7 
      Caption         =   "Light"
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
      Left            =   5400
      TabIndex        =   16
      Tag             =   "1071"
      Top             =   3120
      Width           =   855
   End
   Begin VB.Label Label6 
      Caption         =   "Dark"
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
      Left            =   480
      TabIndex        =   15
      Tag             =   "1072"
      Top             =   3120
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Ambient Lighting Level"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Tag             =   "1073"
      Top             =   2520
      Width           =   2775
   End
   Begin VB.Shape Shape2 
      Height          =   1095
      Left            =   120
      Top             =   2640
      Width           =   6495
   End
   Begin VB.Label Label4 
      Caption         =   "Color Of Light"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   11
      Tag             =   "1074"
      Top             =   0
      Width           =   2895
   End
   Begin VB.Shape Shape1 
      Height          =   2295
      Left            =   120
      Top             =   120
      Width           =   6495
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "Pull All"
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
      Left            =   240
      TabIndex        =   10
      Tag             =   "1075"
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Blue"
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
      TabIndex        =   9
      Tag             =   "1076"
      Top             =   1320
      Width           =   615
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Green"
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
      TabIndex        =   8
      Tag             =   "1077"
      Top             =   960
      Width           =   615
   End
   Begin VB.Label redtag 
      Alignment       =   1  'Right Justify
      Caption         =   "Red"
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
      TabIndex        =   7
      Tag             =   "1078"
      Top             =   600
      Width           =   615
   End
End
Attribute VB_Name = "boardlighting"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub ambient_Change()
    On Error GoTo errorhandler
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
    Change = ambient.value
    rr = redambient.value + Change
    gg = greenambient.value + Change
    bb = blueambient.value + Change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0
'    redambient.Value = rr
'    greenambient.Value = gg
'    blueambient.Value = bb

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub amblevel_Change()
    On Error GoTo errorhandler
    If val(amblevel.text) > 255 Then amblevel.text = 255
    If val(amblevel.text) < -255 Then amblevel.text = -255
    ambient.value = val(amblevel.text)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub blueambient_Change()
    On Error GoTo errorhandler
    blueamvalue.text = str$(blueambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub blueamvalue_Change()
    On Error GoTo errorhandler
    If val(blueamvalue.text) > 255 Then blueamvalue.text = 255
    If val(blueamvalue.text) < 0 Then blueamvalue.text = 0
    blueambient.value = val(blueamvalue.text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    oldvalue = 0
    redambient.Max = 255
    redambient.Min = 0
    redambient.value = 0
    greenambient.Max = 255
    greenambient.Min = 0
    greenambient.value = 0
    blueambient.Max = 255
    blueambient.Min = 0
    blueambient.value = 0
    pullallambient.Max = 255
    pullallambient.Min = 0
    pullallambient.value = 0
    ambient.Min = -255
    ambient.Max = 255
    ambient.value = 0
    
    redambient.value = boardList(activeBoardIndex).ambientR
    greenambient.value = boardList(activeBoardIndex).ambientG
    blueambient.value = boardList(activeBoardIndex).ambientB
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    'publictile.currentColor = rgbcol.Point(1, 1)
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub greenambient_Change()
    On Error GoTo errorhandler
    greenamvalue.text = str$(greenambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub greenamvalue_Change()
    On Error GoTo errorhandler
    If val(greenamvalue.text) > 255 Then greenamvalue.text = 255
    If val(greenamvalue.text) < 0 Then greenamvalue.text = 0
    greenambient.value = val(greenamvalue.text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub OK_Click()
    On Error GoTo errorhandler
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
    Change = ambient.value
    rr = redambient.value + Change
    gg = greenambient.value + Change
    bb = blueambient.value + Change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0
    boardList(activeBoardIndex).ambientR = rr
    boardList(activeBoardIndex).ambientG = gg
    boardList(activeBoardIndex).ambientB = bb
    Unload boardlighting

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub pullallambient_Change()
    On Error GoTo errorhandler
    Change = pullallambient.value - oldvalue
    oldvalue = pullallambient.value
    rred = redambient.value
    ggreen = greenambient.value
    bblue = blueambient.value
    greatest = 255
    wasdone = 0
    If Change > 0 Then
        If rred > ggreen And rred > bblue Then greatest = 255 - rred
        If ggreen > rred And ggreen > bblue Then greatest = 255 - ggreen
        If bblue > ggreen And bblue > rred Then greatest = 255 - bblue
        If Change > greatest Then Change = greatest
    End If
    If Change < 0 Then
        If rred < ggreen And rred < bblue Then least = rred
        If ggreen < rred And ggreen < bblue Then least = ggreen
        If bblue < ggreen And bblue < rred Then least = bblue
        If -1 * Change > least Then Change = -1 * least
    End If
    rr = redambient.value + Change
    gg = greenambient.value + Change
    bb = blueambient.value + Change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0

    redambient.value = rr
    greenambient.value = gg
    blueambient.value = bb
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub redambient_Change()
    On Error GoTo errorhandler
    redamval.text = str$(redambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    'publictile.currentColor = rgbcol.Point(1, 1)
    Call vbPicFillRect(shade, 0, 0, 100, 100, rgbb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub redamval_Change()
    On Error GoTo errorhandler
    If val(redamval.text) > 255 Then redamval.text = 255
    If val(redamval.text) < 0 Then redamval.text = 0
    redambient.value = val(redamval.text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub resetwhite_Click()
    On Error GoTo errorhandler
    redambient.value = 0
    greenambient.value = 0
    blueambient.value = 0
    pullallambient.value = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'rgbb' and 'reda' and 'greena' and 'bluea' with an early-bound data type     FixIT90210ae-R1672-R1B8ZE
Private Function rgbb(reda, greena, bluea)
    On Error GoTo errorhandler
    redaa = reda
    blueaa = bluea
    greenaa = greena
    If redaa > 255 Then redaa = 255
    If blueaa > 255 Then blueaa = 255
    If greenaa > 255 Then greenaa = 255
    If redaa < 0 Then redaa = 0
    If greenaa < 0 Then greenaa = 0
    If blueaa < 0 Then blueaa = 0
    newval = RGB(redaa, greenaa, blueaa)
    rgbb = newval

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

