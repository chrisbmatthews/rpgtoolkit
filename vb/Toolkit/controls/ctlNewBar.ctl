VERSION 5.00
Begin VB.UserControl ctlNewBar 
   ClientHeight    =   5115
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1815
   ScaleHeight     =   5115
   ScaleWidth      =   1815
   Begin VB.PictureBox newBar 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   5115
      Left            =   0
      ScaleHeight     =   5115
      ScaleWidth      =   1815
      TabIndex        =   0
      Top             =   0
      Width           =   1815
      Begin VB.CommandButton CommandDock 
         Caption         =   "        Edit Tileset"
         Height          =   375
         Index           =   6
         Left            =   0
         MaskColor       =   &H00FFFFFF&
         Picture         =   "ctlNewBar.ctx":0000
         Style           =   1  'Graphical
         TabIndex        =   13
         TabStop         =   0   'False
         Tag             =   "1403"
         ToolTipText     =   "Organize and prune your tilesets"
         Top             =   4560
         UseMaskColor    =   -1  'True
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Animation"
         Height          =   375
         Index           =   14
         Left            =   0
         Picture         =   "ctlNewBar.ctx":03CD
         Style           =   1  'Graphical
         TabIndex        =   12
         TabStop         =   0   'False
         Tag             =   "1403"
         ToolTipText     =   "Create animations for battles"
         Top             =   4200
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Status Effect"
         Height          =   375
         Index           =   12
         Left            =   0
         Picture         =   "ctlNewBar.ctx":088A
         Style           =   1  'Graphical
         TabIndex        =   11
         TabStop         =   0   'False
         Tag             =   "1405"
         ToolTipText     =   "Create status effects for fights"
         Top             =   3840
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Special Move"
         Height          =   375
         Index           =   7
         Left            =   0
         Picture         =   "ctlNewBar.ctx":0B8A
         Style           =   1  'Graphical
         TabIndex        =   10
         TabStop         =   0   'False
         Tag             =   "1406"
         ToolTipText     =   "Create powerful attacks"
         Top             =   3480
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Background"
         Height          =   375
         Index           =   9
         Left            =   0
         Picture         =   "ctlNewBar.ctx":0E7B
         Style           =   1  'Graphical
         TabIndex        =   9
         TabStop         =   0   'False
         Tag             =   "1407"
         ToolTipText     =   "The backdrop against which fights occur"
         Top             =   3120
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Enemy"
         Height          =   375
         Index           =   8
         Left            =   0
         Picture         =   "ctlNewBar.ctx":117E
         Style           =   1  'Graphical
         TabIndex        =   8
         TabStop         =   0   'False
         Tag             =   "1893"
         ToolTipText     =   "What's a game without enemies?"
         Top             =   2760
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Item"
         Height          =   375
         Index           =   5
         Left            =   0
         Picture         =   "ctlNewBar.ctx":14C2
         Style           =   1  'Graphical
         TabIndex        =   7
         TabStop         =   0   'False
         Tag             =   "1409"
         ToolTipText     =   "Items can be a lot of things"
         Top             =   2400
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Character"
         Height          =   375
         Index           =   3
         Left            =   0
         Picture         =   "ctlNewBar.ctx":1699
         Style           =   1  'Graphical
         TabIndex        =   6
         TabStop         =   0   'False
         Tag             =   "1410"
         ToolTipText     =   "Edit character stats"
         Top             =   2040
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Program"
         Height          =   375
         Index           =   4
         Left            =   0
         Picture         =   "ctlNewBar.ctx":1B4A
         Style           =   1  'Graphical
         TabIndex        =   5
         TabStop         =   0   'False
         Tag             =   "1411"
         ToolTipText     =   "Take control of your game with RPGCode"
         Top             =   1680
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Board"
         Height          =   375
         Index           =   2
         Left            =   0
         Picture         =   "ctlNewBar.ctx":1C43
         Style           =   1  'Graphical
         TabIndex        =   4
         TabStop         =   0   'False
         Tag             =   "1412"
         ToolTipText     =   "Boards are the locations your players will visit"
         Top             =   1320
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Animated Tile"
         Height          =   375
         Index           =   15
         Left            =   0
         Picture         =   "ctlNewBar.ctx":1F3E
         Style           =   1  'Graphical
         TabIndex        =   3
         TabStop         =   0   'False
         Tag             =   "2049"
         Top             =   960
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Tile"
         Height          =   375
         Index           =   1
         Left            =   0
         Picture         =   "ctlNewBar.ctx":227A
         Style           =   1  'Graphical
         TabIndex        =   2
         TabStop         =   0   'False
         Tag             =   "1413"
         ToolTipText     =   "Tiles are the backbone of any game"
         Top             =   600
         Width           =   1815
      End
      Begin VB.CommandButton CommandDock 
         Caption         =   "         Edit Main File"
         Height          =   375
         Index           =   0
         Left            =   0
         Picture         =   "ctlNewBar.ctx":24F1
         Style           =   1  'Graphical
         TabIndex        =   1
         TabStop         =   0   'False
         Tag             =   "1414"
         ToolTipText     =   "The main project file that controls your game"
         Top             =   240
         Width           =   1815
      End
   End
End
Attribute VB_Name = "ctlNewBar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Sub CommandDock_Click(Index As Integer)

    With tkMainForm
        .ignoreFocus = False
        Select Case Index
            Case 0
                Call editmainfile.Show
            Case 1
                Call .newtilemnu_Click
            Case 15
                Call .newanimtilemnu_Click
            Case 2
                Call .newboardmnu_Click
            Case 4
                Call .newrpgcodemnu_Click
            Case 3
                Call .newplayermnu_Click
            Case 5
                Call .newitemmnu_Click
            Case 8
                Call .newenemymnu_Click
            Case 9
                Call .mnuNewFightBackground_Click
            Case 7
                Call .newspecialmovemnu_Click
            Case 12
                Call .newstatuseffectmnu_Click
            Case 14
                Call .newanimationmnu_Click
            Case 6
                Call tilesetedit.Show(vbModal)
        End Select
    End With
    
End Sub
