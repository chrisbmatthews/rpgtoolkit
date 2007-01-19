VERSION 5.00
Begin VB.Form tilesetForm 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Tiles"
   ClientHeight    =   4125
   ClientLeft      =   60
   ClientTop       =   225
   ClientWidth     =   4965
   Icon            =   "tilesets.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   275
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   331
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1834"
   Begin Toolkit.ctlTilesetToolbar ctlTileset 
      Height          =   3975
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   7011
   End
End
Attribute VB_Name = "tilesetForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Jonathan D. Hughes
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

'==============================================================================
'Pop-up tileset browser (from keypress "L", or for saving into tst)
'==============================================================================
Option Explicit

Dim m_extraTile As Boolean

Private Sub Form_Load(): On Error Resume Next
    Dim x As Long, y As Long
    
    'Global
    setFilename = vbNullString
    
    'Put the current tilemem into the buffer (tile editor...)
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    m_extraTile = False
    If activeForm Is activeTile Then m_extraTile = openTileEditorDocs(activeTile.indice).bAllowExtraTst
    
    Call ctlTileset.resize(tstFile, m_extraTile)

End Sub

Private Sub Form_Resize(): On Error Resume Next
   ctlTileset.width = Me.ScaleWidth - ctlTileset.Left
   ctlTileset.Height = Me.ScaleHeight - ctlTileset.Top
   Call ctlTileset.resize(tstFile, m_extraTile)
End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    Dim x As Long, y As Long
    
    'Reinstate the tileMem (tile editor...)
    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = bufTile(x, y)
        Next y
    Next x

End Sub

'============================================================================
' Process selected tile information from tileset browser control
'============================================================================
Public Sub ctlTilesetMouseUp(ByVal filename As String) ': on error resume next
    setFilename = filename
    If Not (activeForm Is Nothing) Then
        If activeForm.formType = FT_BOARD Then Call activeBoard.changeSelectedTile(filename)
    End If
    ignore = 1
    Unload Me
End Sub
