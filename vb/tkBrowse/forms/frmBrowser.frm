VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmBrowser 
   Caption         =   "RPG Toolkit Browser"
   ClientHeight    =   5730
   ClientLeft      =   3060
   ClientTop       =   3345
   ClientWidth     =   7080
   Icon            =   "frmBrowser.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5730
   ScaleWidth      =   7080
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command6 
      Caption         =   "S"
      Height          =   375
      Left            =   2760
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton Command5 
      Caption         =   "H"
      Height          =   375
      Left            =   2400
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   600
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   1058
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      Style           =   1
      ImageList       =   "toolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "back"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "forward"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "stop"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "reload"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList toolbarIcons 
         Left            =   5280
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmBrowser.frx":0CCA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmBrowser.frx":19A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmBrowser.frx":267E
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmBrowser.frx":3358
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame statusbar 
      Height          =   400
      Left            =   0
      TabIndex        =   3
      Top             =   5280
      Width           =   7095
      Begin VB.PictureBox status 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   4920
         ScaleHeight     =   11
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   138
         TabIndex        =   4
         Top             =   150
         Width           =   2100
      End
      Begin VB.Label statustext 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   120
         Width           =   6735
      End
   End
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   7095
      Begin VB.ComboBox cboAddress 
         Height          =   315
         Left            =   840
         TabIndex        =   2
         Top             =   120
         Width           =   5835
      End
      Begin VB.Label Label1 
         Caption         =   "Address:"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   120
         Width           =   855
      End
   End
   Begin VB.Timer timTimer 
      Enabled         =   0   'False
      Interval        =   75
      Left            =   6180
      Top             =   1500
   End
   Begin SHDocVwCtl.WebBrowser brwWebBrowser 
      Height          =   4080
      Left            =   45
      TabIndex        =   0
      Top             =   1215
      Width           =   6840
      ExtentX         =   12065
      ExtentY         =   7197
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "http:///"
   End
End
Attribute VB_Name = "frmBrowser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Public StartingAddress As String
Dim mbDontNavigateNow As Boolean

Public flip As Boolean  'flipper for title bar

Private Sub brwWebBrowser_ProgressChange(ByVal Progress As Long, ByVal ProgressMax As Long)
    On Error Resume Next
    perc = Progress / ProgressMax
    dw = Int(status.Width * perc)
    Call vbPicFillRect(status, 0, 0, 1000, 1000, RGB(255, 255, 255))
    Call vbPicFillRect(status, 0, 0, dw, 1000, RGB(0, 0, 255))
End Sub


Private Sub brwWebBrowser_StatusTextChange(ByVal Text As String)
    statustext.Caption = Text
End Sub


Private Sub brwWebBrowser_TitleChange(ByVal Text As String)
    'frmBrowser.Caption = Text
End Sub

Private Sub Command5_Click()
    On Error Resume Next
      

    timTimer.Enabled = True
      

    brwWebBrowser.GoHome
End Sub


Private Sub Command6_Click()
    On Error Resume Next
      

    timTimer.Enabled = True
      
    brwWebBrowser.GoSearch
End Sub


Private Sub Form_Load()
    On Error Resume Next
    Me.Show
    If Command$ <> "" Then
        StartingAddress = Command$
    Else
        StartingAddress = "http://rpgtoolkit.com"
    End If
    tbToolBar.Refresh
    Form_Resize

    'cboAddress.Move 50, lblAddress.Top + lblAddress.Height + 15


    If Len(StartingAddress) > 0 Then
        cboAddress.Text = StartingAddress
        cboAddress.AddItem cboAddress.Text
        'try to navigate to the starting address
        timTimer.Enabled = True
        brwWebBrowser.Navigate StartingAddress
    End If


End Sub



Private Sub brwWebBrowser_DownloadComplete()
    On Error Resume Next
    Me.Caption = "RPG Toolkit Browser [" + brwWebBrowser.LocationName + "]"
End Sub


Private Sub brwWebBrowser_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
    On Error Resume Next
    Dim i As Integer
    Dim bFound As Boolean
    Me.Caption = "RPG Toolkit Browser [" + brwWebBrowser.LocationName + "]"
    For i = 0 To cboAddress.ListCount - 1
        If cboAddress.List(i) = brwWebBrowser.LocationURL Then
            bFound = True
            Exit For
        End If
    Next i
    mbDontNavigateNow = True
    If bFound Then
        cboAddress.RemoveItem i
    End If
    cboAddress.AddItem brwWebBrowser.LocationURL, 0
    cboAddress.ListIndex = 0
    mbDontNavigateNow = False
End Sub


Private Sub cboAddress_Click()
    If mbDontNavigateNow Then Exit Sub
    timTimer.Enabled = True
    brwWebBrowser.Navigate cboAddress.Text
End Sub


Private Sub cboAddress_KeyPress(KeyAscii As Integer)
    On Error Resume Next
    If KeyAscii = vbKeyReturn Then
        cboAddress_Click
    End If
End Sub


Private Sub Form_Resize()
    On Error Resume Next
    Frame1.Width = Me.Width
    cboAddress.Width = Me.ScaleWidth - 900
    brwWebBrowser.Width = Me.ScaleWidth - 100
    
    statusbar.Top = Me.ScaleHeight - statusbar.Height - 50
    statusbar.Width = brwWebBrowser.Width
    statusbar.Left = brwWebBrowser.Left
    statusbar.Left = 50
    status.Left = statusbar.Width - status.Width - 70
    statustext.Width = statusbar.Width - 300
    
    If Frame1.Visible = True Then
        brwWebBrowser.Top = Frame1.Top + Frame1.Height
        brwWebBrowser.Height = Me.ScaleHeight - Frame1.Height - 800 - statusbar.Height
    Else
        brwWebBrowser.Top = 100
        brwWebBrowser.Height = Me.ScaleHeight - 800 - statusbar.Height
    End If
End Sub


Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub timTimer_Timer()
    If brwWebBrowser.Busy = False Then
        timTimer.Enabled = False
        Me.Caption = "RPG Toolkit Browser [" + brwWebBrowser.LocationName + "]"
    Else
        Me.Caption = "RPG Toolkit Browser [" + statustext.Caption + "]"
    End If
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error Resume Next
    Select Case Button.Key
        Case "back":
            timTimer.Enabled = True
            brwWebBrowser.GoBack
        Case "forward":
            timTimer.Enabled = True
            brwWebBrowser.GoForward
        Case "stop":
            timTimer.Enabled = False
            brwWebBrowser.Stop
            Me.Caption = "RPG Toolkit Browser [" + brwWebBrowser.LocationName + "]"
        Case "reload":
            timTimer.Enabled = True
            brwWebBrowser.Refresh
    End Select
End Sub


