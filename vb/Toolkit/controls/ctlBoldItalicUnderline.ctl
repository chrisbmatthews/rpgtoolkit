VERSION 5.00
Begin VB.UserControl ctlBoldItalicUnderline 
   BackColor       =   &H00FFFFFF&
   ClientHeight    =   255
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   720
   ScaleHeight     =   255
   ScaleWidth      =   720
   ToolboxBitmap   =   "ctlBoldItalicUnderline.ctx":0000
   Begin VB.CheckBox chkUnderline 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "U"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   480
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   0
      Width           =   255
   End
   Begin VB.CheckBox chkItalics 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "I"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   0
      Width           =   255
   End
   Begin VB.CheckBox chkBold 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   0
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Width           =   255
   End
End
Attribute VB_Name = "ctlBoldItalicUnderline"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Portable bold/italic/underline chooser

Option Explicit

'---Properties---

'The properties are variants because of a strange
'error I got...

'---Bold---

Public Property Get Bold()
 Bold = integerToBoolean(chkBold.value)
End Property

Public Property Set Bold(bol)
 chkBold.value = CInt(BooleanToLong(bol))
End Property

Public Property Let Bold(bol)
 chkBold.value = CInt(BooleanToLong(bol))
End Property

'---Italics---

Public Property Get Italics()
 Italics = integerToBoolean(chkItalics.value)
End Property

Public Property Set Italics(bol)
 chkItalics.value = CInt(BooleanToLong(bol))
End Property

Public Property Let Italics(bol)
 chkItalics.value = CInt(BooleanToLong(bol))
End Property

'---Underline---

Public Property Get Underline()
 Underline = integerToBoolean(chkUnderline.value)
End Property

Public Property Set Underline(bol)
 chkUnderline.value = CInt(BooleanToLong(bol))
End Property

Public Property Let Underline(bol)
 chkUnderline.value = CInt(BooleanToLong(bol))
End Property

'---End of Properties---

Private Sub chkBold_Click()
 ChangeBoolean Bold
End Sub

Private Sub chkItalics_Click()
 ChangeBoolean Italics
End Sub

Private Sub chkUnderline_Click()
 ChangeBoolean Underline
End Sub
