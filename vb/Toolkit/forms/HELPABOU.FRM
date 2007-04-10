VERSION 5.00
Begin VB.Form helpAbout 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "About RPG Toolkit"
   ClientHeight    =   5040
   ClientLeft      =   2595
   ClientTop       =   2715
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
   ScaleHeight     =   5040
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1115"
   Begin VB.TextBox Text1 
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
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   3240
      Width           =   6855
   End
   Begin VB.Label Label4 
      Caption         =   $"HELPABOU.frx":0CCA
      Height          =   615
      Left            =   120
      TabIndex        =   8
      Top             =   2520
      Width           =   6855
   End
   Begin VB.Label Label7 
      Caption         =   "TK3 Dev Team: Christopher B. Matthews, Colin James Fitzpatrick (Colin), Jonathan Hughes (Delano)"
      Height          =   495
      Left            =   120
      TabIndex        =   7
      Top             =   2040
      Width           =   6855
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "You may not remove any notices from this screen, unless they no longer apply."
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
      Top             =   1560
      Width           =   6135
   End
   Begin VB.Label Label8 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Release 3.1.0 (2007)"
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
      Top             =   480
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
      Top             =   1080
      Width           =   2415
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "All Rights Reserved."
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
      Top             =   1200
      Width           =   4095
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright (C) 2004, 2005, 2006, 2007 by the TK3 Dev Team and contributors"
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
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Tag             =   "1094"
      Top             =   840
      Width           =   5775
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "RPG Toolkit Development System, Version 3"
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
      Top             =   120
      Width           =   6615
   End
End
Attribute VB_Name = "helpAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private Sub Form_Load(): On Error Resume Next

    Dim theText As String
    theText = theText & "The RPG Toolkit, including the editor (toolkit3.exe), the engine (trans3.exe), the default menu (tk3menu.dll) and battle (tk3fight.dll) systems, is free software licensed under the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version." & vbCrLf & vbCrLf
    theText = theText & "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details." & vbCrLf & vbCrLf
    
    theText = theText & "Spanish translations provided by Ignacio Chitinsky and Jaime Peña.  French translation provided by Alexandre Thomas.  German translation provided by Martin Holtz.  Italian translation provided by Andrea Piras." & vbCrLf & vbCrLf
    theText = theText & "RPGToolkit Fo' Sho' Music Pak v2.18 composed by Chris and Craig Reeves, Copyright 2000.  Used with permission.  http://www.vipcouncil.com" & vbCrLf & vbCrLf
    theText = theText & "Menu System graphic and layout based on designs provided by |3lue.  Used with permission." & vbCrLf & vbCrLf
    theText = theText & "This program uses FreeImage, an open source image library supporting all common bitmap formats. Get your free copy now from http://www.6ixsoft.com." & vbCrLf & vbCrLf
    theText = theText & "Compression provided by zlib v1.1.3, copyright 1995-1998 Jean-loup Gailly and Mark Adler.  Used under license.  http://www.freesoftware.com/pub/infozip/zlib/" & vbCrLf & vbCrLf
    theText = theText & "This product includes images from Corel Clipart which are protected by the copyright laws of the U.S., Canada and elsewhere. Used under license.  They are for viewing purposes only." & vbCrLf & vbCrLf
    theText = theText & "This product includes software developed by vbAccelerator (http://vbaccelerator.com/)." & vbCrLf & vbCrLf
    theText = theText & "This program uses the Audiere sound library, released under the LGPL." & vbCrLf
    theText = theText & "Used under license.  http://audiere.sourceforge.net" & vbCrLf & vbCrLf
    theText = theText & "This program uses GUID generation code by Gus Molina; see Microsoft support article 176790 for details"

    Text1.Text = theText

End Sub

