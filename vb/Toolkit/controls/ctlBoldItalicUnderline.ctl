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
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'=========================================================================
' Portable bold/italic/underline chooser
'=========================================================================

Option Explicit

Public Property Get Bold() As Boolean
    Bold = integerToBoolean(chkBold.value)
End Property
Public Property Let Bold(ByVal bol As Boolean)
    chkBold.value = CInt(booleanToLong(bol))
End Property
Public Property Get Italics() As Boolean
    Italics = integerToBoolean(chkItalics.value)
End Property
Public Property Let Italics(ByVal bol As Boolean)
    chkItalics.value = CInt(booleanToLong(bol))
End Property
Public Property Get Underline() As Boolean
    Underline = integerToBoolean(chkUnderline.value)
End Property
Public Property Let Underline(ByVal bol As Boolean)
    chkUnderline.value = CInt(booleanToLong(bol))
End Property
