VERSION 5.00
Begin VB.Form frmToolWindow 
   Appearance      =   0  'Flat
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "ToolBar"
   ClientHeight    =   4665
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   1905
   ClipControls    =   0   'False
   HasDC           =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   ScaleHeight     =   233.25
   ScaleMode       =   2  'Point
   ScaleWidth      =   95.25
   ShowInTaskbar   =   0   'False
End
Attribute VB_Name = "frmToolWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
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

Event Unload()

Private Sub Form_Resize()
 tkMainForm.tvProjectList.Height = Me.Height - 400
 tkMainForm.tvProjectList.width = Me.width - 145
End Sub

Private Sub Form_Unload(Cancel As Integer)
 RaiseEvent Unload
End Sub
