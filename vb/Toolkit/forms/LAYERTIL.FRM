VERSION 5.00
Begin VB.Form frmLayerTile 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Layer Tile"
   ClientHeight    =   2100
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3855
   Icon            =   "LAYERTIL.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2100
   ScaleWidth      =   3855
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.VScrollBar scrOffsetX 
      Height          =   255
      Left            =   2760
      Max             =   -32
      Min             =   32
      TabIndex        =   12
      Top             =   1200
      Value           =   1
      Width           =   255
   End
   Begin VB.TextBox txtOffsetY 
      Height          =   285
      Left            =   3000
      TabIndex        =   10
      Text            =   "0"
      Top             =   1200
      Width           =   495
   End
   Begin VB.CommandButton butOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   2640
      TabIndex        =   5
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton butCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2640
      TabIndex        =   4
      Top             =   720
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3675
      Begin VB.VScrollBar scrOffsetY 
         Height          =   255
         Left            =   3360
         Max             =   -32
         Min             =   32
         TabIndex        =   11
         Top             =   1080
         Value           =   32
         Width           =   255
      End
      Begin VB.TextBox txtOffsetX 
         Height          =   285
         Left            =   2160
         TabIndex        =   9
         Text            =   "0"
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtIntensity 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2880
         TabIndex        =   8
         Text            =   "50"
         Top             =   1440
         Width           =   495
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   120
         ScaleHeight     =   375
         ScaleWidth      =   1215
         TabIndex        =   6
         Top             =   240
         Width           =   1215
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
         Width           =   975
      End
      Begin VB.PictureBox picPreview 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   1440
         ScaleHeight     =   33
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   65
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
      Begin VB.Label lblOffset 
         Caption         =   "Offset"
         Height          =   255
         Left            =   1680
         TabIndex        =   13
         Top             =   1080
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
'All contents copyright 2003, 2004, 2005 Christopher Matthews and Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Private intensity As Double
Private layerData(1, 64, 32) As Long        'The two tiles we are layering.
Private xRange As Long
Private tileName As String

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
    If openTileEditorDocs(activeTile.indice).isometric Then
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "Isometric Tileset (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "Supported Types|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    End If

    ChDir (currentDir)
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    
    If UCase$(GetExt(dlg.strSelectedFile)) = "TST" Or UCase$(GetExt(dlg.strSelectedFile)) = "ISO" Then
        
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
    tileName = vbNullString
    scrOffsetX.value = 0
    scrOffsetY.value = 0
    
    'The layer tile is now in tileMem.
    
    If UCase$(GetExt(dlg.strSelectedFile)) = "ISO" Then
        Dim xCount As Long, yCount As Long
        xCount = 1: yCount = 1
    
        'Now we need to form the 32x32 tile into a 64x32 in tilemem:
        
        'Temporarily hold tilemem in the buffer.
        Dim x As Long, y As Long
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
            Next y
        Next x
        
        For x = 1 To 64
            For y = 1 To 32
                            
                If isoMaskBmp(x, y) <> RGB(0, 0, 0) Then
                    'Masked pixel.
                    tileMem(x, y) = -1
                Else
                    'Unmasked pixel.
                    tileMem(x, y) = bufTile(xCount, yCount)
                                        
                    'Increment the tilemem entry.
                    yCount = yCount + 1
                    If yCount > 32 Then
                        xCount = xCount + 1
                        yCount = 1
                    End If
                End If
            Next y
        Next x
    End If '(whichtype = "ISO")
    
    For x = 1 To xRange
        For y = 1 To 32
            layerData(LAYER_TILE, x, y) = tileMem(x, y)
            Call vbPicPSet(picPreview, x - 1, y - 1, layerData(LAYER_TILE, x, y))
        Next y
    Next x
    
    Call Preview
    
    tileName = dlg.strSelectedFileNoPath
    
End Sub

'========================================================================
' The preview checkbox
'========================================================================
Private Sub chkPreview_Click(): On Error Resume Next
    
    Dim x As Long, y As Long
    
    'If it's unchecked, change the tile back.
    If chkPreview.value = 0 Then
    
        For x = 1 To xRange
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

    Call Preview
    'Enable the intensity text field.
    txtIntensity.Enabled = chkTrans.value

End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next
    
    'Localize this form.
    ' Call LocalizeForm(Me)
    
    If openTileEditorDocs(activeTile.indice).isometric Then
        xRange = 64
    Else
        xRange = 32
    End If
    
    tileName = vbNullString
    picPreview.width = xRange * Screen.TwipsPerPixelX
    scrOffsetX.max = -xRange
    scrOffsetX.min = xRange
    scrOffsetX.value = 0
    scrOffsetY.value = 0
    
    'Store the current tile as the base and set a clear layer tile.
    Dim x As Long, y As Long
    For x = 1 To xRange
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
        For x = 1 To xRange
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

    Dim x As Long, y As Long, r As Integer, g As Integer, b As Integer

    If chkPreview.value = 0 Then Exit Sub
    
    For x = 1 To xRange
        For y = 1 To 32
        
            If x - scrOffsetX.value > 0 And x - scrOffsetX.value <= xRange And _
               y - scrOffsetY.value > 0 And y - scrOffsetY.value <= 32 Then
               
               If layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value) <> -1 Then
                    'Layered tile is not transparent here.
                    If chkTrans.value = 0 Then
                        'Not a translucent layering, just copy it.
                        tileMem(x, y) = layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value)
                       
                    Else
                        'Translucent, add the scaled values from each tile.
                        r = red(layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value)) * (intensity / 100) + red(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                        g = green(layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value)) * (intensity / 100) + green(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                        b = blue(layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value)) * (intensity / 100) + blue(layerData(BASE_TILE, x, y)) * (1 - intensity / 100)
                                            
                        tileMem(x, y) = RGB(r, g, b)
                    End If
                Else
                    'Layered tile transparent, only base tile shows.
                    tileMem(x, y) = layerData(BASE_TILE, x, y)
                End If
            Else
                'Layered tile offset past this pixel, only base tile shows.
                tileMem(x, y) = layerData(BASE_TILE, x, y)
            End If
        
        Next y
    Next x
    
    activeTile.tileRedraw
End Sub

'==============================================================================
'Layered tile horizontal offset
'==============================================================================
Private Sub scrOffsetX_Change(): On Error Resume Next

    Dim x As Long, y As Long
    
    txtOffsetX.Text = CStr(scrOffsetX.value)
    If LenB(tileName) Then
        picPreview.Cls
        For x = 1 To xRange
            For y = 1 To 32
                If x - scrOffsetX.value > 0 And x - scrOffsetX.value <= xRange And _
                   y - scrOffsetY.value > 0 And y - scrOffsetY.value <= 32 Then
                    If layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value) <> -1 Then
                        Call vbPicPSet(picPreview, x - 1, y - 1, layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value))
                    Else
                        Call vbPicPSet(picPreview, x - 1, y - 1, QBColor(15))
                    End If
                Else
                    Call vbPicPSet(picPreview, x - 1, y - 1, QBColor(15))
                End If
            Next y
        Next x
        Call Preview
    End If
End Sub

'==============================================================================
'Layered tile vertical offset
'==============================================================================
Private Sub scrOffsetY_Change(): On Error Resume Next

    Dim x As Long, y As Long
    
    txtOffsetY.Text = CStr(scrOffsetY.value)
    If LenB(tileName) Then
        picPreview.Cls
        For x = 1 To xRange
            For y = 1 To 32
                If x - scrOffsetX.value > 0 And x - scrOffsetX.value <= xRange And _
                   y - scrOffsetY.value > 0 And y - scrOffsetY.value <= 32 Then
                    If layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value) <> -1 Then
                        Call vbPicPSet(picPreview, x - 1, y - 1, layerData(LAYER_TILE, x - scrOffsetX.value, y - scrOffsetY.value))
                    Else
                        Call vbPicPSet(picPreview, x - 1, y - 1, QBColor(15))
                    End If
                Else
                    Call vbPicPSet(picPreview, x - 1, y - 1, QBColor(15))
                End If
            Next y
        Next x
        Call Preview
    End If
End Sub

'==============================================================================
'Set intensity for translucent layering.
'==============================================================================
Private Sub txtIntensity_Change(): On Error Resume Next
    
    intensity = inBounds(val(txtIntensity.Text), 0, 100)
    txtIntensity.Text = CStr(intensity)
    Call Preview

End Sub

'==============================================================================
'Set offsets for layered tile.
'==============================================================================
Private Sub txtOffsetX_Change(): On Error Resume Next
    scrOffsetX.value = inBounds(CLng(txtOffsetX.Text), -xRange, xRange)
End Sub

Private Sub txtOffsetY_Change(): On Error Resume Next
    scrOffsetY.value = inBounds(CLng(txtOffsetY.Text), -32, 32)
End Sub
