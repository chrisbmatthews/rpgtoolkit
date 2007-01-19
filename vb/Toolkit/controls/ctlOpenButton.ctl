VERSION 5.00
Begin VB.UserControl ctlOpenButton 
   ClientHeight    =   375
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   375
   ScaleHeight     =   375
   ScaleWidth      =   375
   Begin VB.CommandButton changedSelectedTileset 
      Height          =   375
      Left            =   0
      Picture         =   "ctlOpenButton.ctx":0000
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Width           =   375
   End
End
Attribute VB_Name = "ctlOpenButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
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

Option Explicit

Public Event click()

Private Sub changedSelectedTileset_Click()
    RaiseEvent click
End Sub
