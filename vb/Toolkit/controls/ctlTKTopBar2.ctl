VERSION 5.00
Begin VB.UserControl TKTopBar_Tools 
   BackColor       =   &H00FFFFFF&
   BackStyle       =   0  'Transparent
   ClientHeight    =   240
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   240
   ScaleWidth      =   4800
   ToolboxBitmap   =   "ctlTKTopBar2.ctx":0000
   Begin VB.PictureBox TopBar 
      Appearance      =   0  'Flat
      BackColor       =   &H00CC9966&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   210
      Left            =   0
      ScaleHeight     =   14
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   321
      TabIndex        =   0
      Top             =   0
      Width           =   4815
      Begin VB.PictureBox Corner 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   210
         Left            =   960
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   14
         TabIndex        =   1
         Top             =   0
         Width           =   210
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Caption"
         BeginProperty Font 
            Name            =   "Trebuchet MS"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   0
         Width           =   4575
      End
      Begin VB.Image CloseX 
         Height          =   195
         Left            =   0
         MousePointer    =   99  'Custom
         Stretch         =   -1  'True
         ToolTipText     =   "Close"
         Top             =   15
         Width           =   195
      End
   End
End
Attribute VB_Name = "TKTopBar_Tools"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'All code copyright 2004, Colin James Fitzpatrick                   '
'                                                                   '
'Graphics copyright 2004, Dan Cryer                                 '
'                                                                   '
'YOU MAY NOT REMOVE THIS NOTICE                                     '
'Read LICENSE.txt for more information                              '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit

''''''''
'Events'
''''''''

Event mouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)

''''''''''''''''''
'Public Variables'
''''''''''''''''''

Public theForm As PictureBox

''''''''''''''''''
'Member Variables'
''''''''''''''''''

Private draggingWindow As Boolean

''''''''''''
'Properties'
''''''''''''

Public Property Get Width() As Long
    Width = TopBar.Width
End Property

Public Property Let Width(ByVal new_width As Long)
    TopBar.Width = new_width
    UserControl.Width = new_width
    Call resizeMe
End Property

Public Property Get Caption() As String
    Caption = Label1.Caption
End Property

Public Property Let Caption(ByVal new_caption As String)
    Label1.Caption = new_caption
End Property

'''''''''
'Methods'
'''''''''

Private Sub CloseX_Click()
 theForm.Visible = False
End Sub

Private Sub UserControl_Initialize()
 CloseX.Picture = Images.CloseX
 Corner.Picture = Images.Corner
 resizeMe
 CloseX.MouseIcon = Images.MouseLink
End Sub

Public Sub resizeMe()
 UserControl.Width = Me.Width
 TopBar.Width = Me.Width
 Corner.Left = TopBar.ScaleWidth - Corner.Width
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
 On Error Resume Next
 With PropBag
  Me.Width = .ReadProperty("Width")
  Me.Caption = .ReadProperty("Caption")
 End With
 resizeMe
End Sub

Private Sub UserControl_Resize()
 UserControl.height = 210
 TopBar.Width = UserControl.Width
 resizeMe
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
 With PropBag
  .WriteProperty "Width", Me.Width
  .WriteProperty "Caption", Me.Caption
 End With
End Sub

'''''''''''''''''
'Window Dragging'
'''''''''''''''''

'First, make actions that are part of the window drag work...

Private Sub Corner_Mouseup(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub Label1_Mouseup(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub TopBar_Mouseup(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub Corner_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseDownEvent button, X, Y
End Sub

Private Sub Label1_dblClick()
 mouseDownEvent 1, 1, 1
 RaiseEvent mouseDown(1, 1, 1, 1)
End Sub

Private Sub TopBar_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseDownEvent button, X, Y
End Sub

Private Sub Corner_Mousemove(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent X, Y
End Sub

Private Sub Label1_Mousemove(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent X, Y
End Sub

Private Sub TopBar_Mousemove(button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent X, Y
End Sub

Private Sub mouseDownEvent(ByVal button As Integer, ByVal X As Single, _
 ByVal Y As Single)

 'Only the left button can drag the window...
 'If Not button = 1 Then Exit Sub
 
 'Flag that we're dragging the window...
 'draggingWindow = True
 
End Sub

Private Sub mouseUpEvent()

 'We've stopped dragging the window- flag it!
 'draggingWindow = False

End Sub

Private Sub mouseMoveEvent(ByVal X As Single, ByVal Y As Single)

 'If we're not dragging the window, we shouldn't be here...
 'If Not draggingWindow Then Exit Sub

 'Move the window to X,Y...
 'theForm.Left = X
 'theForm.Top = Y

End Sub
