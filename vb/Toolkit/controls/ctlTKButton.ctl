VERSION 5.00
Begin VB.UserControl TKButton 
   BackColor       =   &H00FFFFFF&
   ClientHeight    =   645
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1845
   ScaleHeight     =   645
   ScaleWidth      =   1845
   ToolboxBitmap   =   "ctlTKButton.ctx":0000
   Begin VB.Label lblCaption 
      BackStyle       =   0  'Transparent
      Caption         =   "Caption"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      MousePointer    =   99  'Custom
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
   Begin VB.Image cmdButton 
      Height          =   495
      Left            =   20
      MousePointer    =   99  'Custom
      Top             =   20
      Width           =   1815
   End
End
Attribute VB_Name = "TKButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'All code copyright 2004, Colin James Fitzpatrick                   '
'                                                                   '
'Normal button graphic copyright 2004, Dan Cryer                    '
'Mouse-over button graphics copyright 2004, Colin James Fiztpatrick '
'                                                                   '
'YOU MAY NOT REMOVE THIS NOTICE                                     '
'Read LICENSE.txt for more information                              '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'RPGToolkit button...

Option Explicit

''''''''
'Events'
''''''''

Public Event Click()
Public Event MouseDown(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
Public Event MouseUp(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)

''''''''''''
'Properties'
''''''''''''

Public Property Get Width()
 Width = cmdButton.Width
End Property

Public Property Set Width(new_width)
 cmdButton.Width = new_width
 UserControl.Width = new_width + 20
End Property

Public Property Let Width(new_width)
 cmdButton.Width = new_width
 UserControl.Width = new_width + 20
End Property

Public Property Get Caption()
 Caption = lblCaption.Caption
End Property

Public Property Set Caption(new_caption)
 lblCaption.Caption = new_caption
End Property

Public Property Let Caption(new_caption)
 lblCaption.Caption = new_caption
End Property

'''''''''
'Methods'
'''''''''

Private Sub cmdbutton_Click()
 RaiseEvent Click
End Sub

Private Sub cmdbutton_MouseDown(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 RaiseEvent MouseDown(cmdButton, Shift, X, Y)
End Sub

Private Sub cmdbutton_MouseMove(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 swapState True
End Sub

Private Sub cmdbutton_MouseUp(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 RaiseEvent MouseUp(cmdButton, Shift, X, Y)
End Sub

Private Sub lblCaption_MouseDown(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 RaiseEvent MouseDown(cmdButton, Shift, X, Y)
End Sub

Private Sub lblCaption_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 swapState True
End Sub

Private Sub lblCaption_MouseUp(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 RaiseEvent MouseUp(cmdButton, Shift, X, Y)
End Sub

Private Sub lblCaption_Click()
 RaiseEvent Click
End Sub

Private Sub UserControl_Initialize()
 On Error Resume Next
 cmdButton.Picture = Images.Bullet
 cmdButton.MouseIcon = Images.MouseLink
 lblCaption.MouseIcon = Images.MouseLink
 UserControl.height = cmdButton.height + 5
End Sub

Private Sub UserControl_MouseMove(cmdButton As Integer, Shift As Integer, X As Single, Y As Single)
 swapState False
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
 On Error Resume Next
 With PropBag
  Width = .ReadProperty("Width")
  Caption = .ReadProperty("Caption")
 End With
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
 On Error Resume Next
 With PropBag
  .WriteProperty "Width", Width
  .WriteProperty "Caption", Caption
 End With
End Sub

Private Sub swapState(ByVal mouseOver As Boolean)
 If mouseOver Then cmdButton.Picture = Images.BulletMouseOver
 If Not mouseOver Then cmdButton.Picture = Images.Bullet
End Sub
