VERSION 5.00
Begin VB.Form compoptions 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "File Compression Options"
   ClientHeight    =   1545
   ClientLeft      =   2355
   ClientTop       =   2685
   ClientWidth     =   4395
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "COMPOPTI.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1545
   ScaleWidth      =   4395
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1087"
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Close"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2640
      TabIndex        =   3
      Tag             =   "1088"
      Top             =   1080
      Width           =   1335
   End
   Begin VB.OptionButton compressoff 
      Caption         =   "Compression Off"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2520
      TabIndex        =   2
      Tag             =   "1089"
      Top             =   600
      Width           =   1815
   End
   Begin VB.OptionButton compresson 
      Caption         =   "Compression On"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2520
      TabIndex        =   1
      Tag             =   "1090"
      Top             =   240
      Width           =   1695
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Compression can be used to reduce the disk space used by tiles.  Tiles with many colors may not compress well."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   120
      TabIndex        =   0
      Tag             =   "1091"
      Top             =   120
      Width           =   2055
   End
End
Attribute VB_Name = "compoptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    On Error GoTo errorhandler
    Unload compoptions

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub compressoff_Click()
    On Error GoTo errorhandler
    compression = 0
    compresson.Value = 0
    compressoff.Value = 1

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub compresson_Click()
    On Error GoTo errorhandler
    compression = 1
    compresson.Value = 1
    compressoff.Value = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    On Error GoTo errorhandler
    If compression = 1 Then
        compresson.Value = 1
        compressoff.Value = 0
    Else
        compresson.Value = 0
        compressoff.Value = 1
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub


