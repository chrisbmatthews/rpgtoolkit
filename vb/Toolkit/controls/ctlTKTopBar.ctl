VERSION 5.00
Begin VB.UserControl TKTopBar 
   BackColor       =   &H00FFFFFF&
   BackStyle       =   0  'Transparent
   ClientHeight    =   405
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4110
   ScaleHeight     =   405
   ScaleWidth      =   4110
   ToolboxBitmap   =   "ctlTKTopBar.ctx":0000
   Begin VB.PictureBox closeX 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   50
      Picture         =   "ctlTKTopBar.ctx":0312
      ScaleHeight     =   285
      ScaleMode       =   0  'User
      ScaleWidth      =   300
      TabIndex        =   1
      Top             =   20
      Width           =   300
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "      Caption"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   480
      TabIndex        =   0
      Top             =   15
      Width           =   7500
   End
   Begin VB.Image topBar 
      Height          =   375
      Left            =   18
      Stretch         =   -1  'True
      Top             =   10
      Width           =   5000
   End
End
Attribute VB_Name = "TKTopBar"
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

''''''''''''''''''
'Public Variables'
''''''''''''''''''

Public theForm As Form

''''''''''''''''''
'Member Variables'
''''''''''''''''''

Private draggingWindow As Boolean
Dim mouseX As Long, mouseY As Long

''''''''''''
'Properties'
''''''''''''

Public Property Get width() As Long
    width = topBar.width
End Property

Public Property Let width(ByVal new_width As Long)
    topBar.width = new_width
    UserControl.width = new_width
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
    Unload theForm
End Sub

Private Sub UserControl_Initialize()
    On Error Resume Next
    topBar.Picture = Images.Corner
    Call resizeMe
    closeX.MousePointer = 99
    closeX.MouseIcon = Images.MouseLink
End Sub

Public Sub resizeMe()
 UserControl.width = Me.width
 topBar.width = Me.width
 'Corner.Left = TopBar.Width - Corner.Width
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
 On Error Resume Next
 With PropBag
  Me.width = .ReadProperty("Width")
  Me.Caption = .ReadProperty("Caption")
 End With
 resizeMe
End Sub

Private Sub UserControl_Resize()
 UserControl.height = 480
 topBar.width = UserControl.width
 resizeMe
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
 With PropBag
  .WriteProperty "Width", Me.width
  .WriteProperty "Caption", Me.Caption
 End With
End Sub

'''''''''''''''''
'Window Dragging'
'''''''''''''''''

'First, make actions that are part of the window drag work...

Private Sub Corner_Mouseup(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub Label1_Mouseup(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub TopBar_Mouseup(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseUpEvent
End Sub

Private Sub Corner_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseDownEvent Button, X, Y
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseDownEvent Button, X, Y
End Sub

Private Sub TopBar_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseDownEvent Button, X, Y
End Sub

Private Sub Corner_Mousemove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent Button, X, Y
End Sub

Private Sub Label1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent Button, X, Y
End Sub

Private Sub TopBar_Mousemove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 mouseMoveEvent Button, X, Y
End Sub

Private Sub mouseDownEvent(ByVal Button As Integer, ByVal X As Single, ByVal Y As Single)
    mouseX = X
    mouseY = Y
End Sub

Private Sub mouseUpEvent()

End Sub

Private Sub mouseMoveEvent(ByVal Button As Integer, ByVal X As Single, ByVal Y As Single)
    If Button = vbLeftButton Then
        theForm.Left = theForm.Left - (mouseX - X)
        theForm.Top = theForm.Top - (mouseY - Y)
    End If
End Sub
