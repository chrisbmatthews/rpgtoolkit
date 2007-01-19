VERSION 5.00
Begin VB.Form frmCommonImages 
   BorderStyle     =   0  'None
   Caption         =   "Image Host"
   ClientHeight    =   735
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3180
   LinkTopic       =   "Form2"
   ScaleHeight     =   735
   ScaleWidth      =   3180
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox picNewX 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   2520
      Picture         =   "frmCommonImages.frx":0000
      ScaleHeight     =   465
      ScaleWidth      =   465
      TabIndex        =   3
      Top             =   120
      Width           =   495
   End
   Begin VB.PictureBox picNormal 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   120
      MouseIcon       =   "frmCommonImages.frx":05E1
      MousePointer    =   99  'Custom
      Picture         =   "frmCommonImages.frx":08EB
      ScaleHeight     =   465
      ScaleWidth      =   465
      TabIndex        =   2
      Top             =   120
      Width           =   495
   End
   Begin VB.PictureBox Corner 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   450
      Left            =   1920
      Picture         =   "frmCommonImages.frx":0E43
      ScaleHeight     =   450
      ScaleWidth      =   450
      TabIndex        =   1
      Top             =   120
      Width           =   450
   End
   Begin VB.PictureBox picMouseOver 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   720
      Picture         =   "frmCommonImages.frx":18D4
      ScaleHeight     =   465
      ScaleWidth      =   465
      TabIndex        =   0
      Top             =   120
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Image CloseX 
      Height          =   450
      Left            =   1320
      MousePointer    =   99  'Custom
      Picture         =   "frmCommonImages.frx":1E2C
      ToolTipText     =   "Close"
      Top             =   120
      Width           =   450
   End
End
Attribute VB_Name = "frmCommonImages"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
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


'Used to load common images
