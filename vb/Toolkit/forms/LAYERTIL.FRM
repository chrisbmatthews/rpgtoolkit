VERSION 5.00
Begin VB.Form frmLayerTile 
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   2415
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3735
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2415
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin Toolkit.TKButton butCanel 
      Height          =   495
      Left            =   2520
      TabIndex        =   7
      Top             =   960
      Width           =   1095
      _extentx        =   661
      _extenty        =   873
      Object.width           =   360
      caption         =   "Cancel"
   End
   Begin Toolkit.TKButton butOK 
      Height          =   495
      Left            =   2520
      TabIndex        =   6
      Top             =   480
      Width           =   855
      _extentx        =   661
      _extenty        =   873
      Object.width           =   360
      caption         =   "OK"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1815
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   2295
      Begin VB.CheckBox chkTrans 
         BackColor       =   &H80000005&
         Caption         =   "Transparently Layer"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   1440
         Width           =   1695
      End
      Begin VB.CheckBox chkPreview 
         BackColor       =   &H80000005&
         Caption         =   "Preview"
         Height          =   375
         Left            =   120
         TabIndex        =   4
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
         TabIndex        =   3
         Top             =   240
         Width           =   495
      End
      Begin Toolkit.TKButton butOpenTile 
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   1335
         _extentx        =   661
         _extenty        =   661
         Object.width           =   360
         caption         =   "Open Tile"
      End
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2895
      _extentx        =   5106
      _extenty        =   847
      Object.width           =   2895
      caption         =   "Layer Tile"
   End
   Begin VB.Shape Shape1 
      Height          =   2415
      Left            =   0
      Top             =   0
      Width           =   3735
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
Private Sub butCanel_click()
    
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
    Dim X As Integer, Y As Integer
    For X = 1 To 32
        For Y = 1 To 32
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
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
        tilesetform.Show vbModal
        
        If setFilename = "" Then Exit Sub
        Call openWinTile(projectPath + tilePath + setFilename)
    
    Else
         
        'No archive, just open it up!
        Call openWinTile(filename(1))
        
    End If
    
    'Clear the preview picturebox
    picPreview.cls
    
    'Paint the opened tile on the picturebox
    For X = 1 To 32
        For Y = 1 To 32
            Call vbPicPSet(picPreview, X - 1, Y - 1, tileMem(X, Y))
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
    'Change tilemem back
    For X = 1 To 32
        For Y = 1 To 32
            buffer(X, Y) = tileMem(X, Y)
            tileMem(X, Y) = bufTile(X, Y)
            bufTile(X, Y) = buffer(X, Y)
        Next Y
    Next X
    
    'Preview tile
    If chkPreview.value Then Call Preview
    
End Sub

'========================================================================
' The preview checkbox
'========================================================================
Private Sub chkPreview_Click()
    
    'If it's unchecked, change the tile back
    If chkPreview.value = 0 Then
    
        Dim X, Y As Integer
        For X = 1 To 32
            For Y = 1 To 32
                tileMem(X, Y) = tilePreview(X, Y)
            Next Y
        Next X
    
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
    Call LocalizeForm(Me)
    
    'Store the current tile and clear buftile
    Dim X As Integer, Y As Integer
    For X = 1 To 32
        For Y = 1 To 32
            bufTile(X, Y) = -1
            tilePreview(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
    'Set this to false at startup
    saveChanges = False
    
    'Make sure the topbar knows which form it is on
    Set TopBar.theForm = Me
    
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
        Dim X As Integer, Y As Integer
        For X = 1 To 32
            For Y = 1 To 32
                If tileMem(X, Y) <> -1 Then
                    tileMem(X, Y) = tilePreview(X, Y)
                End If
            Next Y
        Next X
        
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
    Dim X, Y As Integer
    For X = 1 To 32
        For Y = 1 To 32
            tileMem(X, Y) = tilePreview(X, Y)
        Next Y
    Next X

    For X = 1 To 32
        For Y = 1 To 32
        
            If openTileEditorDocs(activeTile.indice).transparentLayer = 0 Then
            
                'Not a transparent layer, just copy it
                If bufTile(X, Y) = -1 Then bufTile(X, Y) = tileMem(X, Y)
                tileMem(X, Y) = bufTile(X, Y)
                
            Else
            
                'Transparent layer, add effect
                If bufTile(X, Y) = -1 Then
                
                    'Transparent pixel
                    bufTile(X, Y) = tileMem(X, Y)
                Else
                
                    'Not transparent
                    
                    'Needed variables
                    Dim rrbuf As String, ggbuf As String, bbbuf As String
                    Dim rrtile As String, ggtile As String, bbtile As String
                    rrbuf = red(bufTile(X, Y))
                    ggbuf = green(bufTile(X, Y))
                    bbbuf = blue(bufTile(X, Y))
                    rrtile = red(tileMem(X, Y))
                    ggtile = green(tileMem(X, Y))
                    bbtile = green(tileMem(X, Y))
                    rrtile = rrtile + rrbuf: If rrtile > 255 Then rrtile = 255
                    ggtile = ggtile + ggbuf: If ggtile > 255 Then ggtile = 255
                    bbtile = bbtile + bbbuf: If bbtile > 255 Then bbtile = 255
                    tileMem(X, Y) = RGB(rrtile, ggtile, bbtile)
                    
                End If
                
            End If
            
        Next Y
    Next X
    
    'Redraw
    activeTile.tileRedraw
End Sub
