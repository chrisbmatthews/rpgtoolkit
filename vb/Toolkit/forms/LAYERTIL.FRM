VERSION 5.00
Begin VB.Form frmLayerTile 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Layer Tile"
   ClientHeight    =   2100
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3735
   Icon            =   "LAYERTIL.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2100
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton butOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   2520
      TabIndex        =   5
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton butCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2520
      TabIndex        =   4
      Top             =   720
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2295
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   120
         ScaleHeight     =   495
         ScaleWidth      =   1335
         TabIndex        =   6
         Top             =   240
         Width           =   1335
         Begin VB.CommandButton butOpenTile 
            Caption         =   "Open Tile"
            Height          =   375
            Left            =   0
            TabIndex        =   7
            Top             =   0
            Width           =   1215
         End
      End
      Begin VB.CheckBox chkTrans 
         Appearance      =   0  'Flat
         Caption         =   "Transparently Layer"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1440
         Width           =   1695
      End
      Begin VB.CheckBox chkPreview 
         Appearance      =   0  'Flat
         Caption         =   "Preview"
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   960
         Width           =   1335
      End
      Begin VB.PictureBox picPreview 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   1680
         ScaleHeight     =   31
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   31
         TabIndex        =   1
         Top             =   240
         Width           =   495
      End
   End
End
Attribute VB_Name = "frmLayerTile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

'========================================================================
' The Cancel button
'========================================================================
Private Sub butCancel_click()
    
    'Just unload, the tile will be changed back in Form_Unload
    Unload Me
    
End Sub

'========================================================================
' The OK button
'========================================================================
Private Sub butOK_Click(): On Error Resume Next
    
    'Change the tile
    Call Preview
    
    'Don't change the tile back during unload
    saveChanges = True
    
    'Unload
    Unload Me
    
End Sub

'========================================================================
' The Open Tile button
'========================================================================
Private Sub butOpenTile_click(): On Error Resume Next

    'Redim the buffer array
    ReDim buffer(32, 32)
    
    'Store the current tileMem
    Dim x As Integer, y As Integer
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    'Open a file dialog
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath + tilePath
    dlg.strTitle = "Open Tile For Layering"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "Supported Types|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    ChDir (currentDir)
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub 'Pressed cancel
    
    'If we got here, see if we got a correct file
    Dim noPath As String
    filename(1) = dlg.strSelectedFile
    noPath = dlg.strSelectedFileNoPath
    
    If UCase(extention(filename(1))) = "TST" Then
        
        'Selected an archive, open it
        tstnum = 0
        tstFile = noPath
        
        'Open the tileset form
        ChDir (currentDir)
        tilesetForm.Show vbModal
        
        If setFilename = "" Then Exit Sub
        Call openWinTile(projectPath + tilePath + setFilename)
    
    Else
         
        'No archive, just open it up!
        Call openWinTile(filename(1))
        
    End If
    
    'Clear the preview picturebox
    picPreview.Cls
    
    'Paint the opened tile on the picturebox
    For x = 1 To 32
        For y = 1 To 32
            Call vbPicPSet(picPreview, x - 1, y - 1, tileMem(x, y))
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    'Change tilemem back
    For x = 1 To 32
        For y = 1 To 32
            buffer(x, y) = tileMem(x, y)
            tileMem(x, y) = bufTile(x, y)
            bufTile(x, y) = buffer(x, y)
        Next y
    Next x
    
    'Preview tile
    If chkPreview.value Then Call Preview
    
End Sub

'========================================================================
' The preview checkbox
'========================================================================
Private Sub chkPreview_Click()
    
    'If it's unchecked, change the tile back
    If chkPreview.value = 0 Then
    
        Dim x, y As Integer
        For x = 1 To 32
            For y = 1 To 32
                tileMem(x, y) = tilePreview(x, y)
            Next y
        Next x
    
        'Redraw
        activeTile.tileRedraw
        
    Else
    
        'Else, preview the tile!
        Call Preview
        
    End If
End Sub

'========================================================================
' The transparent checkbox
'========================================================================
Private Sub chkTrans_Click()

    'Update variable
    With openTileEditorDocs(activeTile.indice)
        If .transparentLayer = 0 Then
            .transparentLayer = 1
        Else
            .transparentLayer = 0
        End If
    End With
    
    'Preview tile
    If chkPreview.value Then Call Preview

End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next
    
    'Localize this form
    ' Call LocalizeForm(Me)
    
    'Store the current tile and clear buftile
    Dim x As Integer, y As Integer
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = -1
            tilePreview(x, y) = tileMem(x, y)
        Next y
    Next x
    
    'Set this to false at startup
    saveChanges = False
    
    'Set the chkTrans checkbox
    chkTrans.value = openTileEditorDocs(activeTile.indice).transparentLayer = 1
        
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'See if the user has clicked "OK" or not
    If Not saveChanges Then
        
        'Use new Undo
        Call activeTile.setUndo
        
        'Change the tile
        Dim x As Integer, y As Integer
        For x = 1 To 32
            For y = 1 To 32
                If tileMem(x, y) <> -1 Then
                    tileMem(x, y) = tilePreview(x, y)
                End If
            Next y
        Next x
        
    End If
    
    'Redraw
    activeTile.tileRedraw
    
End Sub

'========================================================================
' The Open Tile button
'========================================================================
Private Sub picPreview_Click(): On Error Resume Next

    'Open tile
    Call butOpenTile_click
    
End Sub

'========================================================================
' Previews the tile
'========================================================================
Private Sub Preview(): On Error Resume Next

    'First we need to to set the tile back to how it was at the start
    Dim x, y As Integer
    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = tilePreview(x, y)
        Next y
    Next x

    For x = 1 To 32
        For y = 1 To 32
        
            If openTileEditorDocs(activeTile.indice).transparentLayer = 0 Then
            
                'Not a transparent layer, just copy it
                If bufTile(x, y) = -1 Then bufTile(x, y) = tileMem(x, y)
                tileMem(x, y) = bufTile(x, y)
                
            Else
            
                'Transparent layer, add effect
                If bufTile(x, y) = -1 Then
                
                    'Transparent pixel
                    bufTile(x, y) = tileMem(x, y)
                Else
                
                    'Not transparent
                    
                    'Needed variables
                    Dim rrbuf As String, ggbuf As String, bbbuf As String
                    Dim rrtile As String, ggtile As String, bbtile As String
                    rrbuf = red(bufTile(x, y))
                    ggbuf = green(bufTile(x, y))
                    bbbuf = blue(bufTile(x, y))
                    rrtile = red(tileMem(x, y))
                    ggtile = green(tileMem(x, y))
                    bbtile = green(tileMem(x, y))
                    rrtile = rrtile + rrbuf: If rrtile > 255 Then rrtile = 255
                    ggtile = ggtile + ggbuf: If ggtile > 255 Then ggtile = 255
                    bbtile = bbtile + bbbuf: If bbtile > 255 Then bbtile = 255
                    tileMem(x, y) = RGB(rrtile, ggtile, bbtile)
                    
                End If
                
            End If
            
        Next y
    Next x
    
    'Redraw
    activeTile.tileRedraw
End Sub
