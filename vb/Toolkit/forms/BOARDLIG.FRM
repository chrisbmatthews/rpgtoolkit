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

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Option Explicit added
' + Added ByVal or ByRef to arguments
'
'=======================================================

Option Explicit

Private Sub ambient_Change()
    On Error Resume Next
    Dim rr As Long, gg As Long, bb As Long, change As Long
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
    change = ambient.value
    rr = redambient.value + change
    gg = greenambient.value + change
    bb = blueambient.value + change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0
End Sub

Private Sub amblevel_Change()
    On Error Resume Next
    If val(amblevel.Text) > 255 Then amblevel.Text = 255
    If val(amblevel.Text) < -255 Then amblevel.Text = -255
    ambient.value = val(amblevel.Text)
End Sub

Private Sub blueambient_Change()
    On Error Resume Next
    blueamvalue.Text = str(blueambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
End Sub

Private Sub blueamvalue_Change()
    On Error Resume Next
    If val(blueamvalue.Text) > 255 Then blueamvalue.Text = 255
    If val(blueamvalue.Text) < 0 Then blueamvalue.Text = 0
    blueambient.value = val(blueamvalue.Text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
End Sub

Private Sub Form_Load()
    On Error Resume Next
    ' Call LocalizeForm(Me)
    oldValue = 0
    redambient.max = 255
    redambient.min = 0
    redambient.value = 0
    greenambient.max = 255
    greenambient.min = 0
    greenambient.value = 0
    blueambient.max = 255
    blueambient.min = 0
    blueambient.value = 0
    pullallambient.max = 255
    pullallambient.min = 0
    pullallambient.value = 0
    ambient.min = -255
    ambient.max = 255
    ambient.value = 0
    redambient.value = boardList(activeBoardIndex).ambientR
    greenambient.value = boardList(activeBoardIndex).ambientG
    blueambient.value = boardList(activeBoardIndex).ambientB
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
End Sub

Private Sub greenambient_Change()
    On Error Resume Next
    greenamvalue.Text = CStr(greenambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
End Sub

Private Sub greenamvalue_Change()
    On Error Resume Next
    If val(greenamvalue.Text) > 255 Then greenamvalue.Text = 255
    If val(greenamvalue.Text) < 0 Then greenamvalue.Text = 0
    greenambient.value = val(greenamvalue.Text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
End Sub

Private Sub OK_Click()
    On Error Resume Next
    Dim rr As Long, gg As Long, bb As Long, change As Long
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
    change = ambient.value
    rr = redambient.value + change
    gg = greenambient.value + change
    bb = blueambient.value + change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0
    boardList(activeBoardIndex).ambientR = rr
    boardList(activeBoardIndex).ambientG = gg
    boardList(activeBoardIndex).ambientB = bb
    Call Unload(Me)
End Sub

Private Sub pullallambient_Change()

    On Error Resume Next
    
    Dim change As Long, rRed As Long, gGreen As Long, bBlue As Long
    Dim greatest As Long, wasDone As Long, least As Long
    
    change = pullallambient.value - oldValue
    oldValue = pullallambient.value
    rRed = redambient.value
    gGreen = greenambient.value
    bBlue = blueambient.value
    greatest = 255

    If change > 0 Then
        If rRed > gGreen And rRed > bBlue Then greatest = 255 - rRed
        If gGreen > rRed And gGreen > bBlue Then greatest = 255 - gGreen
        If bBlue > gGreen And bBlue > rRed Then greatest = 255 - bBlue
        If change > greatest Then change = greatest
    ElseIf change < 0 Then
        If rRed < gGreen And rRed < bBlue Then least = rRed
        If gGreen < rRed And gGreen < bBlue Then least = gGreen
        If bBlue < gGreen And bBlue < rRed Then least = bBlue
        If -1 * change > least Then change = -1 * least
    End If
    
    Dim rr As Long, gg As Long, bb As Long
    rr = redambient.value + change
    gg = greenambient.value + change
    bb = blueambient.value + change
    If rr > 255 Then rr = 255: If rr < 0 Then rr = 0
    If gg > 255 Then gg = 255: If gg < 0 Then gg = 0
    If bb > 255 Then bb = 255: If bb < 0 Then bb = 0
    redambient.value = rr
    greenambient.value = gg
    blueambient.value = bb
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))

End Sub

Private Sub redambient_Change()
    On Error Resume Next
    redamval.Text = str(redambient.value)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
    Call vbPicFillRect(shade, 0, 0, 100, 100, RGBb(redambient.value + ambient.value, greenambient.value + ambient.value, blueambient.value + ambient.value))
End Sub

Private Sub redamval_Change()
    On Error Resume Next
    If val(redamval.Text) > 255 Then redamval.Text = 255
    If val(redamval.Text) < 0 Then redamval.Text = 0
    redambient.value = val(redamval.Text)
    Call vbPicFillRect(lightcolor, 0, 0, 100, 100, RGB(redambient.value, greenambient.value, blueambient.value))
End Sub

Private Sub resetwhite_Click()
    On Error Resume Next
    redambient.value = 0
    greenambient.value = 0
    blueambient.value = 0
    pullallambient.value = 0
End Sub

Private Function RGBb(ByVal redA As Long, ByVal greenA As Long, ByVal blueA As Long) As Long
    On Error Resume Next
    Dim redAA As Long, blueAA As Long, greenAA As Long
    redAA = redA
    blueAA = blueA
    greenAA = greenA
    If redAA > 255 Then redAA = 255
    If blueAA > 255 Then blueAA = 255
    If greenAA > 255 Then greenAA = 255
    If redAA < 0 Then redAA = 0
    If greenAA < 0 Then greenAA = 0
    If blueAA < 0 Then blueAA = 0
    RGBb = RGB(redAA, greenAA, blueAA)
End Function
