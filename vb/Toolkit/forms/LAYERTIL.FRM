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
      Width           =   3550
      Begin VB.TextBox txtIntensity 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2520
         TabIndex        =   8
         Text            =   "50"
         Top             =   1440
         Width           =   615
      End
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
         Caption         =   "Translucently Layer (%)"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1440
         Width           =   1935
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

Private intensity As Double
Private layerData(1, 64, 32) As Long        'The two tiles we are layering.

Private Const BASE_TILE = 0
Private Const LAYER_TILE = 1
'========================================================================
' The Cancel button
'========================================================================
Private Sub butCancel_click(): On Error Resume Next
    Unload Me
End Sub

'========================================================================
' The OK button
'========================================================================
Private Sub butOK_Click(): On Error Resume Next
    
    'Change the tile.
    Call Preview
    
    'Change the tile back during unload.
    saveChanges = True
    
    Unload Me
    
End Sub

'========================================================================
' The Open Tile button
'========================================================================
Private Sub butOpenTile_click(): On Error Resume Next

    'Open a file dialog.
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & tilePath
    dlg.strTitle = "Open Tile For Layering"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "Supported Types|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    ChDir (currentDir)
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    
    If UCase$(GetExt(dlg.strSelectedFile)) = "TST" Then
        
        'Selected an archive, open it.
        tstnum = 0
        tstFile = dlg.strSelectedFileNoPath
        
        'Open the tileset form.
        ChDir (currentDir)
        tilesetForm.Show vbModal
        
        If setFilename = vbNullString Then Exit Sub
        Call openWinTile(projectPath & tilePath & setFilename)
    
    Else
         
        'No archive, just open it up!
        Call openWinTile(dlg.strSelectedFile)
        
    End If
    
    picPreview.Cls
    
    'The layer tile is now in tileMem.
    
    Dim x As Long, y As Long
    For x = 1 To 32
        For y = 1 To 32
            layerData(LAYER_TILE, x, y) = tileMem(x, y)
            Call vbPicPSet(picPreview, x - 1, y - 1, layerData(LAYER_TILE, x, y))
        Next y
    Next x
    
    If chkPreview.value Then Call Preview
    
End Sub

'========================================================================
' The preview checkbox
'========================================================================
Private Sub chkPreview_Click(): On Error Resume Next
    
    Dim x As Long, y As Long
    
    'If it's unchecked, change the tile back.
    If chkPreview.value = 0 Then
    
        For x = 1 To 32
            For y = 1 To 32
                tileMem(x, y) = layerData(BASE_TILE, x, y)
            Next y
        Next x
    
        activeTile.tileRedraw
        
    Else
    
        'Else, preview the tile!
        Call Preview
        
    End If
End Sub

'========================================================================
' The translucent checkbox
'========================================================================
Private Sub chkTrans_Click()

    'Preview tile.
    If chkPreview.value Then Call Preview
    'Enable the intensity text field.
    txtIntensity.Enabled = chkTrans.value

End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next
    
    'Localize this form.
    ' Call LocalizeForm(Me)
    
    'Store the current tile as the base and set a clear layer tile.
    Dim x As Integer, y As Integer
    For x = 1 To 32
        For y = 1 To 32
            layerData(BASE_TILE, x, y) = tileMem(x, y)
            layerData(LAYER_TILE, x, y) = -1
        Next y
    Next x
    
    saveChanges = False
    'Set the chkTrans checkbox.
    chkTrans.value = 0
    txtIntensity.Enabled = chkTrans.value
    intensity = 50                  '50% mix value to start with.
    txtIntensity.Text = CStr(intensity)
        
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'See if the user has clicked "OK" or not.
    If Not saveChanges Then
        
        'Use new Undo.
        Call activeTile.setUndo
        
        'Change the tile.
        Dim x As Long, y As Long
        For x = 1 To 32
            For y = 1 To 32
                tileMem(x, y) = layerData(BASE_TILE, x, y)
            Next y
        Next x
        
    End If
    
    activeTile.tileRedraw
    
End Sub

'========================================================================
' The Open Tile button
'========================================================================
Private Sub picPreview_Click(): On Error Resume Next

    Call butOpenTile_click
    
End Sub

'========================================================================
' Previews the tile
'========================================================================
Private Sub Preview(): On Error Resume Next

    Dim x As Long, y As Long
    
    For x = 1 To 32
        For y = 1 To 32
        
            If chkTrans.value = 0 Then
                'Not a translucent layering, just copy it.
                
                If layerData(LAYER_TILE, x, y) = -1 Then
                    'Draw the base pixel.
                    tileMem(x, y) = layerData(BASE_TILE, x, y)
                Else
                    'Layer tile is not transparent here - draw the layer pixel.
                    tileMem(x, y) = layerData(LAYER_TILE, x, y)
                End If
               
            Else
            
                If layerData(LAYER_TILE, x, y) = -1 Then
                    'Draw the base pixel.
                    tileMem(x, y) = layerData(BASE_TILE, x, y)
                Else
                    'Layer tile is not transparent here - draw the layer pixel.
                    
                    Dim r As Byte, g As Byte, b As Byte
                    
                    'Add the scaled values from each tile.
                    r = red(layerData(LAYER_TILE, x, y)) * (intensity / 100) + red(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                    g = green(layerData(LAYER_TILE, x, y)) * (intensity / 100) + green(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                    b = blue(layerData(LAYER_TILE, x, y)) * (intensity / 100) + blue(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                                        
                    tileMem(x, y) = RGB(r, g, b)
                End If
            End If 'chkTrans.value = 0
        
        Next y
    Next x
    
    activeTile.tileRedraw
End Sub

'==============================================================================
'Set intensity for translucent layering.
'==============================================================================
Private Sub txtIntensity_LostFocus()
    
    intensity = inBounds(val(txtIntensity.Text), 0, 100)
    txtIntensity.Text = CStr(intensity)

End Sub
