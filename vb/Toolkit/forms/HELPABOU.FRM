VERSION 5.00
Begin VB.Form helpAbout 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "About RPG Toolkit"
   ClientHeight    =   5295
   ClientLeft      =   2550
   ClientTop       =   2400
   ClientWidth     =   7215
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
   Icon            =   "HELPABOU.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5295
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1115"
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   6975
      _ExtentX        =   12303
      _ExtentY        =   847
      Object.Width           =   6975
      Caption         =   "About the RPGToolkit Development System, Version 3"
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1695
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   3480
      Width           =   6855
   End
   Begin VB.Shape Shape1 
      Height          =   5295
      Left            =   0
      Top             =   0
      Width           =   7215
   End
   Begin VB.Label Label7 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   $"HELPABOU.frx":0CCA
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   240
      TabIndex        =   7
      Top             =   2640
      Width           =   6855
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "You may not remove any notices from this screen."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Tag             =   "1126"
      Top             =   2160
      Width           =   4095
   End
   Begin VB.Label Label8 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Release 3.0.4 (August 2004)"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Tag             =   "1122"
      Top             =   840
      Width           =   2895
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "- Open Source -"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   4320
      TabIndex        =   3
      Tag             =   "1124"
      Top             =   1440
      Width           =   2415
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "All Rights Reserved.  Registered in the US and Canada, bound by international treaties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Tag             =   "1126"
      Top             =   1680
      Width           =   4095
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright 2004 By Christopher Matthews and the TK3 Dev Team"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Tag             =   "1094"
      Top             =   1200
      Width           =   3855
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "RPG Toolkit Development System, Version 3.0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Tag             =   "1127"
      Top             =   480
      Width           =   6615
   End
End
Attribute VB_Name = "helpabout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Form_Load()
    On Error GoTo ErrorHandler

    Set TopBar.theForm = Me

    Dim theText As String
    theText = theText & "Open source contributions by: Colin James Fitzpatrick (KSNiloc), Peter Fenner (Asimir), Phil Carty (Xavier), John@aljo, Jonathan Hughes (Delano), Chris Hutchinson (Euix), Geoff, Sander Knape (Woozy), Samuel Bedwell (Occasionally_Correct)" & vbCrLf & vbCrLf
    theText = theText & "Spanish translations provided by Ignacio Chitinsky and Jaime Peña.  French translation provided by Alexandre Thomas.  German translation provided by Martin Holtz.  Italian translation provided by Andrea Piras." & vbCrLf & vbCrLf
    theText = theText & "RPGToolkit Fo' Sho' Music Pak v2.18 composed by Chris and Craig Reeves, Copyright 2000.  Used with permission.  http://www.vipcouncil.com" & vbCrLf & vbCrLf
    theText = theText & "Menu System graphic and layout based on designs provided by |3lue.  Used with permission." & vbCrLf & vbCrLf
    theText = theText & "This program uses FreeImage, an open source image library supporting all common bitmap formats. Get your free copy now from http://www.6ixsoft.com." & vbCrLf & vbCrLf
    theText = theText & "Compression provided by zlib v1.1.3, copyright 1995-1998 Jean-loup Gailly and Mark Adler.  Used under license.  http://www.freesoftware.com/pub/infozip/zlib/" & vbCrLf & vbCrLf
    theText = theText & "This product includes images from Corel Clipart which are protected by the copyright laws of the U.S., Canada and elsewhere. Used under license.  They are for viewing purposes only." & vbCrLf & vbCrLf

    'RSA credits...
    theText = theText & "Credits for RSA md5 algorithm implementation:" & vbCrLf
    theText = theText & "Copyright (C) 1991-2, RSA Data Security, Inc. Created 1991. All" & vbCrLf
    theText = theText & "rights reserved." & vbCrLf & vbCrLf
    theText = theText & "License to copy and use this software is granted provided that it" & vbCrLf
    theText = theText & "is identified as the 'RSA Data Security, Inc. MD5 Message-Digest" & vbCrLf
    theText = theText & "Algorithm ' in all material mentioning or referencing this software" & vbCrLf
    theText = theText & "or this function." & vbCrLf & vbCrLf
    theText = theText & "License is also granted to make and use derivative works provided" & vbCrLf
    theText = theText & "that such works are identified as 'derived from the RSA Data" & vbCrLf
    theText = theText & "Security, Inc. MD5 Message-Digest Algorithm' in all material" & vbCrLf
    theText = theText & "mentioning or referencing the derived work." & vbCrLf & vbCrLf
    theText = theText & "RSA Data Security, Inc. makes no representations concerning either" & vbCrLf
    theText = theText & "the merchantability of this software or the suitability of this" & vbCrLf
    theText = theText & "software for any particular purpose. It is provided 'as is'" & vbCrLf
    theText = theText & "without express or implied warranty of any kind." & vbCrLf & vbCrLf

    theText = theText & "These notices must be retained in any copies of any part of this" & vbCrLf
    theText = theText & "documentation and/or software." & vbCrLf & vbCrLf

    theText = theText & "This program uses the Audiere sound library, released under the LGPL." & vbCrLf
    theText = theText & "Used under license.  http://audiere.sourceforge.net" & vbCrLf & vbCrLf

    Text1.Text = theText

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_KeyDown(keyCode As Integer, Shift As Integer)
    keyCode = 0: Shift = 0
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    KeyAscii = 0
End Sub

Private Sub Text1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Button = -1: Shift = 0
End Sub
