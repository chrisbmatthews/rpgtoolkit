VERSION 5.00
Begin VB.Form sinskew 
   Caption         =   "Sinusoidal Skew"
   ClientHeight    =   3075
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2415
   Icon            =   "sinskew.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   3075
   ScaleWidth      =   2415
   StartUpPosition =   2  'CenterScreen
Tag = "1817"
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2640
      Width           =   2055
Tag = "1008"
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2280
      Width           =   2055
Tag = "1022"
   End
   Begin VB.Frame Frame1 
      Caption         =   "Sinusoidal Skew"
      Height          =   1695
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2055
Tag = "1817"
      Begin VB.OptionButton Option4 
         Caption         =   "Skew NW To SE"
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   1200
         Width           =   1695
Tag = "1818"
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Skew NE To SW"
         Height          =   315
         Left            =   120
         TabIndex        =   4
         Top             =   840
         Width           =   1575
Tag = "1819"
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Skew SE To NW"
         Height          =   315
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   1695
Tag = "1820"
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Skew SW to NE"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Value           =   -1  'True
         Width           =   1695
Tag = "1821"
      End
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Cut Away"
      Height          =   255
      Left            =   600
      TabIndex        =   0
      Top             =   1920
      Value           =   1  'Checked
      Width           =   1095
Tag = "1822"
   End
End
Attribute VB_Name = "sinskew"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    On Error Goto errorhandler
    If Option1.Value = True Then
        'sw to ne
        If detail = 1 Or detail = 3 Or detail = 5 Then
            maxxx = 32
        Else
            maxxx = 16
        End If
        degg = 0
        For x = 1 To maxxx
            amplit = Int(maxxx * Sin((degg * 3.14) / 180))
            offst = amplit
            tilemem(x, offst) = -1
            'For y = maxxx To maxxx - offst
            '    tilemem(x, y) = -1
            'Next y
            degg = degg + (90 / maxxx)
        Next x
        If maxxx = 32 Then Call highredraw Else Call lowredraw
        Unload sinskew
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub
