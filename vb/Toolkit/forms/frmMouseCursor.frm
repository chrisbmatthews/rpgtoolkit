VERSION 5.00
Begin VB.Form frmMouseCursor 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "(Mouse Cursor)"
   ClientHeight    =   4335
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4815
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   4815
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraCustom 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      ForeColor       =   &H80000008&
      Height          =   3255
      Left            =   120
      TabIndex        =   5
      Top             =   360
      Width           =   4575
      Begin VB.PictureBox picTranspColor 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         FillColor       =   &H00FFFFFF&
         FillStyle       =   0  'Solid
         FontTransparent =   0   'False
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   3480
         ScaleHeight     =   345
         ScaleWidth      =   345
         TabIndex        =   12
         Top             =   1560
         Width           =   375
      End
      Begin Toolkit.TKButton cmdSetHotSpot 
         Height          =   375
         Left            =   0
         TabIndex        =   11
         Top             =   1560
         Width           =   2415
         _ExtentX        =   661
         _ExtentY        =   661
         Object.Width           =   360
         Caption         =   "Set Cursor Hot Spot"
      End
      Begin VB.PictureBox cmdBrowse 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   3960
         MousePointer    =   99  'Custom
         Picture         =   "frmMouseCursor.frx":0000
         ScaleHeight     =   375
         ScaleWidth      =   615
         TabIndex        =   9
         Top             =   2670
         Width           =   615
      End
      Begin VB.PictureBox picPreview 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   1020
         Left            =   240
         ScaleHeight     =   66
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   66
         TabIndex        =   8
         Top             =   360
         Width           =   1020
      End
      Begin VB.TextBox txtFilename 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   0
         TabIndex        =   6
         Top             =   2760
         Width           =   3855
      End
      Begin Toolkit.TKButton cmdTranspColor 
         Height          =   375
         Left            =   0
         TabIndex        =   7
         Top             =   2160
         Width           =   2535
         _ExtentX        =   661
         _ExtentY        =   661
         Object.Width           =   360
         Caption         =   "Set Transparent Color"
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Current Transparent Color"
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   3000
         TabIndex        =   13
         Top             =   2040
         Width           =   1335
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "In game the cursor will be 32x32 pixles, it is shown larger here for your convenience."
         ForeColor       =   &H80000008&
         Height          =   615
         Left            =   1560
         TabIndex        =   10
         Top             =   480
         Width           =   2415
      End
   End
   Begin VB.OptionButton optCustom 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Custom"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2640
      TabIndex        =   4
      Top             =   3910
      Width           =   975
   End
   Begin VB.OptionButton optNoCursor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   1440
      TabIndex        =   3
      Top             =   3910
      Width           =   1095
   End
   Begin VB.OptionButton optDefault 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Default"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   3910
      Width           =   1095
   End
   Begin Toolkit.TKButton cmdOK 
      Height          =   375
      Left            =   3840
      TabIndex        =   1
      Top             =   3840
      Width           =   855
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   847
      Object.Width           =   3375
      Caption         =   "Mouse Cursor Settings"
   End
   Begin VB.Line Line2 
      X1              =   3720
      X2              =   3720
      Y1              =   3720
      Y2              =   4320
   End
   Begin VB.Line Line1 
      X1              =   0
      X2              =   4800
      Y1              =   3720
      Y2              =   3720
   End
   Begin VB.Shape Shape1 
      Height          =   4335
      Left            =   0
      Top             =   0
      Width           =   4815
   End
End
Attribute VB_Name = "frmMouseCursor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved  YOU MAY NOT REMOVE THIS NOTICE
'Read LICENSE.txt for licensing info
'=========================================================================

Option Explicit

'=========================================================================
' Member variables
'=========================================================================
Private setHotSpot As Boolean
Private setTranspColor As Boolean

'=========================================================================
' Fill in the form
'=========================================================================
Private Sub fillInfo(Optional ByVal noHotSpot As Boolean, Optional ByVal noOptionButtons As Boolean)
    Call picPreview.cls
    With mainMem
        If ((.mouseCursor <> "TK DEFAULT") And (.mouseCursor <> "")) Then
            fraCustom.Enabled = True
            If (fileExists(projectPath & bmpPath & .mouseCursor)) Then
                Call DrawSizedImage( _
                                       projectPath & bmpPath & .mouseCursor, _
                                       0, 0, _
                                       picPreview.ScaleWidth, _
                                       picPreview.ScaleHeight, _
                                       picPreview.hdc _
                                                        )
            End If
            picTranspColor.BackColor = .transpcolor
            If (Not noHotSpot) Then
                Call vbPicLine(picPreview, .hotSpotX * 2, 0, .hotSpotX * 2, picPreview.ScaleHeight, 0)
                Call vbPicLine(picPreview, 0, .hotSpotY * 2, picPreview.ScaleWidth, .hotSpotY * 2, 0)
            End If
            txtFilename.Text = .mouseCursor
            If (Not noOptionButtons) Then optCustom.value = True
        ElseIf (.mouseCursor = "") Then
            If (Not noOptionButtons) Then fraCustom.Enabled = False
            If (Not noOptionButtons) Then optNoCursor.value = True
        ElseIf (.mouseCursor = "TK DEFAULT") Then
            If (Not noOptionButtons) Then fraCustom.Enabled = False
            If (Not noOptionButtons) Then optDefault.value = True
        End If
    End With
End Sub

'=========================================================================
' Return type of form
'=========================================================================
Public Property Get formType() As Long
    formType = FT_CURSOR
End Property

'=========================================================================
' Browse button
'=========================================================================
Private Sub cmdBrowse_Click()
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo, antiPath As String
    With dlg
        .strDefaultFolder = projectPath & bmpPath
        .strTitle = "Open Profile"
        .strDefaultExt = "bmp"
        .strFileTypes = strFileDialogFilterWithTiles
        If (OpenFileDialog(dlg, Me.hwnd)) Then
            filename(1) = .strSelectedFile
            antiPath = .strSelectedFileNoPath
        Else
            Exit Sub
        End If
    End With
    Call ChDir(currentDir)
    If (filename(1) = "") Then Exit Sub
    Dim ext As String
    ext = UCase(GetExt(antiPath))
    If (ext = "TST" Or ext = "GPH") Then
        Dim theTile As String
        theTile = antiPath
        If (ext = "TST") Then
            'Get tile from the set
            Dim oldTst As String
            oldTst = tstFile
            tstFile = antiPath
            Call tilesetform.Show(vbModal)
            If (setFilename = "") Then Exit Sub
            theTile = setFilename
            oldTst = tstFile
        End If
        'Make a tile bitmap
        Dim tbm As TKTileBitmap
        Call TileBitmapSize(tbm, 1, 1)
        tbm.tiles(0, 0) = theTile
        antiPath = replace(replace("cursor_image_" & Mid(theTile, 1, Len(antiPath) - 4) & "_.tbm", " ", ""), ".", "") & ".tbm"
        Call SaveTileBitmap(projectPath & bmpPath & antiPath, tbm)
    End If
    txtFilename.Text = antiPath
    mainMem.mouseCursor = antiPath
    Call fillInfo
End Sub

'=========================================================================
' OK button
'=========================================================================
Private Sub cmdOK_Click()
    Call Unload(Me)
End Sub

'=========================================================================
' Set hot spot
'=========================================================================
Private Sub cmdSetHotSpot_click()
    If (setTranspColor) Then
        Call MsgBox("Please finish setting the transparent color first.")
    Else
        Call MsgBox("Please click on the cursor where you would like the hot spot to be.")
        setHotSpot = True
    End If
End Sub

'=========================================================================
' Set transparent color
'=========================================================================
Private Sub cmdTranspColor_click()
    If (setHotSpot) Then
        Call MsgBox("Please finish setting the hot spot first.")
    Else
        Call MsgBox("Please click on the color in the cursor you would like to set as transparent.")
        setTranspColor = True
    End If
End Sub

'=========================================================================
' Form loaded
'=========================================================================
Private Sub Form_Load()
    On Error Resume Next
    Set TopBar.theForm = Me
    cmdBrowse.MouseIcon = Images.MouseLink()
    Call fillInfo
End Sub

'=========================================================================
' Option buttons
'=========================================================================
Private Sub optCustom_Click()
    fraCustom.Enabled = True
    Call fillInfo(False, True)
End Sub
Private Sub optNoCursor_Click()
    fraCustom.Enabled = False
    txtFilename.Text = ""
    mainMem.mouseCursor = ""
    Call fillInfo
End Sub
Private Sub optDefault_Click()
    fraCustom.Enabled = False
    txtFilename.Text = ""
    mainMem.mouseCursor = "TK DEFAULT"
    Call fillInfo
End Sub

'=========================================================================
' Click on preview picture
'=========================================================================
Private Sub picPreview_MouseDown(ByRef Button As Integer, ByRef Shift As Integer, ByRef X As Single, ByRef Y As Single)
    On Error Resume Next
    If (setTranspColor) Then
        Call fillInfo(True)
        mainMem.transpcolor = GetPixel(picPreview.hdc, X, Y)
    ElseIf (setHotSpot) Then
        mainMem.hotSpotX = X / 2
        mainMem.hotSpotY = Y / 2
    End If
    Call fillInfo
    setTranspColor = False
    setHotSpot = False
End Sub

'=========================================================================
' Change filename
'=========================================================================
Private Sub txtFilename_Change()
    mainMem.mouseCursor = txtFilename.Text
    Call fillInfo
End Sub
