VERSION 5.00
Begin VB.UserControl ctlBrdSprite 
   ClientHeight    =   6585
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3135
   ScaleHeight     =   6585
   ScaleWidth      =   3135
   Begin VB.Frame fraProperties 
      Caption         =   "Properties"
      Height          =   5535
      Left            =   0
      TabIndex        =   3
      Top             =   960
      Width           =   3015
      Begin VB.HScrollBar hsbSlot 
         Height          =   255
         Left            =   1260
         Max             =   2
         TabIndex        =   37
         Top             =   1440
         Value           =   1
         Width           =   495
      End
      Begin VB.TextBox txtMultitask 
         Height          =   285
         Left            =   120
         TabIndex        =   33
         Top             =   2640
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   2
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   31
         Top             =   2640
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   2
            Left            =   0
            TabIndex        =   32
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   1
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   29
         Top             =   2040
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   30
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.TextBox txtActivate 
         Height          =   285
         Left            =   120
         TabIndex        =   28
         Top             =   2040
         Width           =   2055
      End
      Begin VB.PictureBox picActivationType 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   240
         ScaleHeight     =   495
         ScaleWidth      =   2415
         TabIndex        =   25
         Top             =   3000
         Width           =   2415
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by step-on"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   27
            Top             =   0
            Width           =   2055
         End
         Begin VB.OptionButton optActivationType 
            Caption         =   "Activation by key press"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   26
            Top             =   240
            Width           =   2055
         End
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   1
         Left            =   1260
         TabIndex        =   10
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   2
         Left            =   2280
         TabIndex        =   9
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtLoc 
         Height          =   285
         Index           =   0
         Left            =   360
         TabIndex        =   8
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtFilename 
         Height          =   285
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   2055
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   0
         Left            =   2280
         ScaleHeight     =   375
         ScaleWidth      =   495
         TabIndex        =   4
         Top             =   480
         Width           =   495
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   5
            Top             =   0
            Width           =   495
         End
      End
      Begin VB.Frame fraConditionallyActive 
         BorderStyle     =   0  'None
         Caption         =   "Conditional activation"
         Height          =   2055
         Left            =   120
         TabIndex        =   13
         Top             =   3360
         Width           =   2775
         Begin VB.PictureBox picConditionallyActive 
            Appearance      =   0  'Flat
            BorderStyle     =   0  'None
            ForeColor       =   &H80000008&
            Height          =   615
            Left            =   120
            ScaleHeight     =   615
            ScaleWidth      =   2535
            TabIndex        =   18
            Top             =   240
            Width           =   2535
            Begin VB.OptionButton optConditionallyActive 
               Caption         =   "Conditionally active"
               Height          =   255
               Index           =   1
               Left            =   0
               TabIndex        =   20
               Top             =   240
               Width           =   1815
            End
            Begin VB.OptionButton optConditionallyActive 
               Caption         =   "Always active"
               Height          =   255
               Index           =   0
               Left            =   0
               TabIndex        =   19
               Top             =   0
               Width           =   1815
            End
         End
         Begin VB.TextBox txtConditionVars 
            Height          =   285
            Index           =   0
            Left            =   120
            TabIndex        =   17
            Text            =   "<variable_A>"
            Top             =   1080
            Width           =   1455
         End
         Begin VB.TextBox txtConditionVars 
            Height          =   285
            Index           =   1
            Left            =   1920
            TabIndex        =   16
            Text            =   "<value>"
            Top             =   1080
            Width           =   735
         End
         Begin VB.TextBox txtConditionVars 
            Height          =   285
            Index           =   2
            Left            =   120
            TabIndex        =   15
            Text            =   "<variable_B>"
            Top             =   1680
            Width           =   1455
         End
         Begin VB.TextBox txtConditionVars 
            Height          =   285
            Index           =   3
            Left            =   1920
            TabIndex        =   14
            Text            =   "<value>"
            Top             =   1680
            Width           =   735
         End
         Begin VB.Label lblInitiallyActive 
            Caption         =   "Active if variable:"
            Height          =   255
            Left            =   120
            TabIndex        =   24
            Top             =   840
            Width           =   1455
         End
         Begin VB.Label lblEquals 
            Caption         =   "="
            Height          =   255
            Index           =   0
            Left            =   1680
            TabIndex        =   23
            Top             =   1080
            Width           =   255
         End
         Begin VB.Label lblAfterActivation 
            Caption         =   "After activation:"
            Height          =   255
            Left            =   120
            TabIndex        =   22
            Top             =   1440
            Width           =   1815
         End
         Begin VB.Label lblEquals 
            Caption         =   "="
            Height          =   255
            Index           =   1
            Left            =   1680
            TabIndex        =   21
            Top             =   1680
            Width           =   255
         End
      End
      Begin VB.Label lblSlot 
         Caption         =   "Slot index: 99"
         Height          =   255
         Left            =   120
         TabIndex        =   36
         Top             =   1500
         Width           =   1215
      End
      Begin VB.Label lblMultitask 
         Caption         =   "Override multitasking program"
         Height          =   375
         Left            =   120
         TabIndex        =   35
         Top             =   2400
         Width           =   2655
      End
      Begin VB.Label lblActivate 
         Caption         =   "Override program to run on activation"
         Height          =   375
         Left            =   120
         TabIndex        =   34
         Top             =   1800
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "X                  Y              Layer"
         Height          =   255
         Index           =   1
         Left            =   180
         TabIndex        =   12
         Top             =   1125
         Width           =   2655
      End
      Begin VB.Label lblLoc 
         Caption         =   "Location"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   11
         Top             =   840
         Width           =   975
      End
      Begin VB.Label lblFilename 
         Caption         =   "Item filename"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.ComboBox cmbSprite 
      Height          =   315
      Left            =   0
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   120
      Width           =   3015
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   855
   End
   Begin VB.CommandButton cmdDuplicate 
      Caption         =   "Duplicate"
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   480
      Width           =   855
   End
End
Attribute VB_Name = "ctlBrdSprite"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

Private m_sprite As CBoardSprite

Private Sub apply() ': On Error Resume Next
    Dim x As Long, y As Long
    If Not m_sprite Is Nothing Then
        With m_sprite
            x = val(txtLoc(0).Text)
            y = val(txtLoc(1).Text)
            Call activeBoard.tileToBoardPixel(x, y, True, False)
            .x = x
            .y = y
            .layer = val(txtLoc(2).Text)
            .activate = Abs(optConditionallyActive(SPR_CONDITIONAL).value)
            .initialVar = txtConditionVars(0).Text
            .initialValue = txtConditionVars(1).Text
            .finalVar = txtConditionVars(2).Text
            .finalValue = txtConditionVars(3).Text
            .activationType = Abs(optActivationType(SPR_KEYPRESS).value)
            .prgActivate = txtActivate.Text
            .prgMultitask = txtMultitask.Text
       
            'Free the canvas of the current image if changing filename.
            Call activeBoard.spriteUpdateImageData(m_sprite, txtFilename.Text)
        End With
    End If
    Call populate(cmbSprite.ListIndex, m_sprite)
End Sub
Public Sub disableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = False
        i.Text = vbNullString
    Next i
    cmbSprite.Enabled = True
End Sub
Public Sub enableAll(): On Error Resume Next
    Dim i As Control
    For Each i In UserControl
        i.Enabled = True
    Next i
End Sub
Public Sub moveCurrentTo(ByRef sel As CBoardSelection) ':on error resume next
    'Call activeBoard.setUndo
    'Selection holds the frame bounds. Derive the base point.
    m_sprite.x = str((sel.x1 + sel.x2) / 2)
    m_sprite.y = str(sel.y2)
    Call activeBoard.spriteUpdateImageData(m_sprite, txtFilename.Text)
    Call populate(cmbSprite.ListIndex, m_sprite)
    Call activeBoard.drawAll
End Sub

Public Sub populate(ByVal index As Long, ByRef spr As CBoardSprite) ':on error resume next
    Dim i As Long, x As Long, y As Long
    
    Set m_sprite = spr
    If (spr Is Nothing) Or (Not activeBoard.toolbarSetCurrent(cmbSprite, index)) Then
        'No matching combo entry.
        Call disableAll
        Exit Sub
    End If
    
    Call enableAll
    
    cmbSprite.list(index) = str(index) & ": " & IIf(LenB(spr.filename), spr.filename, "<sprite>")
    txtFilename.Text = spr.filename
    x = spr.x
    y = spr.y
    Call activeBoard.boardPixelToTile(x, y, True, False)
    txtLoc(0).Text = str(x)
    txtLoc(1).Text = str(y)
    txtLoc(2).Text = str(spr.layer)
    txtActivate = spr.prgActivate
    txtMultitask = spr.prgMultitask
    lblSlot.Caption = "Slot index: " & str(index)
    
    optConditionallyActive(spr.activate).value = True
    If spr.activate = SPR_CONDITIONAL Then
        txtConditionVars(0).Text = spr.initialVar:  txtConditionVars(1).Text = spr.initialValue
        txtConditionVars(2).Text = spr.finalVar:    txtConditionVars(3).Text = spr.finalValue
    Else
        For i = 0 To 4 - 1
            txtConditionVars(i).Enabled = False
        Next i
    End If
    optActivationType(spr.activationType And SPR_KEYPRESS).value = True

End Sub

Public Property Get getCombo() As ComboBox: On Error Resume Next
    Set getCombo = cmbSprite
End Property

Private Sub cmbSprite_Click(): On Error Resume Next
    If cmbSprite.ListIndex <> -1 Then Call activeBoard.toolbarChange(cmbSprite.ItemData(cmbSprite.ListIndex), BS_SPRITE)
End Sub
Private Sub cmdBrowse_Click(index As Integer): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub cmdDelete_Click(): On Error Resume Next
    Call activeBoard.setUndo
    Call activeBoard.spriteDeleteCurrent(cmbSprite.ListIndex)
    Call activeBoard.drawAll
End Sub
Private Sub cmdDuplicate_Click(): On Error Resume Next
    MsgBox "tbd"
End Sub
Private Sub hsbSlot_Change(): On Error Resume Next
    If hsbSlot.value <> 1 Then
        Call activeBoard.spriteSwapSlots(cmbSprite.ListIndex, cmbSprite.ListIndex + hsbSlot.value - 1)
    End If
    hsbSlot.value = 1
End Sub
Private Sub optActivationType_MouseUp(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub optConditionallyActive_MouseUp(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Call apply
End Sub
Private Sub txtActivate_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtConditionVars_Validate(index As Integer, Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
Private Sub txtFilename_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
    Call activeBoard.drawAll
End Sub
Private Sub txtLoc_Validate(index As Integer, Cancel As Boolean): On Error Resume Next
    Call apply
    Call activeBoard.drawAll
End Sub
Private Sub txtMultitask_Validate(Cancel As Boolean): On Error Resume Next
    Call apply
End Sub
