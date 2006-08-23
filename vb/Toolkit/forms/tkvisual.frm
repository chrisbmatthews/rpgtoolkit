VERSION 5.00
Begin VB.Form tkvisual 
   Caption         =   "RPG Toolkit Visual Editor"
   ClientHeight    =   6390
   ClientLeft      =   60
   ClientTop       =   525
   ClientWidth     =   9270
   Icon            =   "tkvisual.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6390
   ScaleWidth      =   9270
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1761"
   Visible         =   0   'False
   Begin VB.PictureBox colorform 
      BackColor       =   &H00000000&
      Height          =   495
      Left            =   8520
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   14
      Top             =   3120
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Set Graphic"
      Height          =   255
      Left            =   1680
      TabIndex        =   13
      Tag             =   "1762"
      Top             =   0
      Width           =   1335
   End
   Begin VB.TextBox codeform 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   4680
      Visible         =   0   'False
      Width           =   8055
   End
   Begin VB.CommandButton redrawbutton 
      Caption         =   "Redraw"
      Height          =   255
      Left            =   8400
      TabIndex        =   12
      TabStop         =   0   'False
      Tag             =   "1763"
      Top             =   1680
      Width           =   735
   End
   Begin VB.CommandButton gridbutton 
      Caption         =   "Grid"
      Height          =   255
      Left            =   8400
      TabIndex        =   11
      TabStop         =   0   'False
      Tag             =   "1764"
      Top             =   1320
      Width           =   735
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   5
      Left            =   8400
      Picture         =   "tkvisual.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   8
      TabStop         =   0   'False
      Tag             =   "1638"
      ToolTipText     =   "Rectangle Tool"
      Top             =   960
      Width           =   375
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   4
      Left            =   8760
      Picture         =   "tkvisual.frx":0FD4
      Style           =   1  'Graphical
      TabIndex        =   7
      TabStop         =   0   'False
      Tag             =   "1641"
      ToolTipText     =   "Line Tool"
      Top             =   600
      Width           =   375
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   3
      Left            =   8400
      Picture         =   "tkvisual.frx":12DE
      Style           =   1  'Graphical
      TabIndex        =   6
      TabStop         =   0   'False
      Tag             =   "1765"
      ToolTipText     =   "Button Tool"
      Top             =   600
      Width           =   375
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   2
      Left            =   8280
      Picture         =   "tkvisual.frx":15E8
      Style           =   1  'Graphical
      TabIndex        =   5
      TabStop         =   0   'False
      Tag             =   "1766"
      ToolTipText     =   "Text Tool"
      Top             =   2160
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   1
      Left            =   8760
      Picture         =   "tkvisual.frx":18F2
      Style           =   1  'Graphical
      TabIndex        =   4
      TabStop         =   0   'False
      Tag             =   "1767"
      ToolTipText     =   "Image Tool"
      Top             =   240
      Width           =   375
   End
   Begin VB.CommandButton ControlPanel 
      Height          =   375
      Index           =   0
      Left            =   8400
      Picture         =   "tkvisual.frx":1BFC
      Style           =   1  'Graphical
      TabIndex        =   3
      TabStop         =   0   'False
      Tag             =   "1768"
      ToolTipText     =   "Pointer Tool"
      Top             =   240
      Width           =   375
   End
   Begin VB.PictureBox boardform 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   4335
      Left            =   120
      MousePointer    =   2  'Cross
      ScaleHeight     =   285
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   534
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   240
      Width           =   8070
   End
   Begin VB.PictureBox buffer 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   8280
      ScaleHeight     =   21
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   61
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   5040
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Color"
      Height          =   255
      Left            =   8520
      TabIndex        =   15
      Tag             =   "1670"
      Top             =   3600
      Width           =   495
   End
   Begin VB.Label coords 
      Caption         =   "0,0"
      Height          =   255
      Left            =   6600
      TabIndex        =   9
      Tag             =   "1769"
      Top             =   0
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "Screen Canvas"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Tag             =   "1770"
      Top             =   0
      Width           =   2295
   End
   Begin VB.Menu filemnu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu mnunew 
         Caption         =   "New Form"
         Shortcut        =   ^N
         Tag             =   "1771"
      End
      Begin VB.Menu mnuopen 
         Caption         =   "Open Form"
         Shortcut        =   ^O
         Tag             =   "1772"
      End
      Begin VB.Menu mnusave 
         Caption         =   "Save"
         Shortcut        =   ^S
         Tag             =   "1233"
      End
      Begin VB.Menu mnusaveas 
         Caption         =   "Save As"
         Shortcut        =   ^A
         Tag             =   "1234"
      End
      Begin VB.Menu mnuclose 
         Caption         =   "Close"
         Tag             =   "1088"
      End
   End
   Begin VB.Menu mnugen 
      Caption         =   "Generate"
      Tag             =   "1773"
      Begin VB.Menu mnubuild 
         Caption         =   "Build To RPGCode"
         Shortcut        =   {F7}
         Tag             =   "1774"
      End
   End
   Begin VB.Menu helpmnu 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu tocmnu 
         Caption         =   "Table of Contents"
         Shortcut        =   {F1}
         Tag             =   "1207"
      End
   End
End
Attribute VB_Name = "tkvisual"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Begun cleaning up
'
' ---What needs to be done
' + Finish cleaning
' + Apply new visual style
' + Make into an MDI child
' + Make actually usable
'
'=======================================================

Option Explicit

'editor vars
Public bGridOnOff As Boolean 'openTileEditorDocs(activeTile.indice).grid on / off
Public toolMode As Integer  'tool selected (0- pointer, 1-image, 2- text, 3- button, 4- line, 5- rect)
Public curcolor As Long     'cuurent color
Public curfilename As String   'current filename

Public bButtonPressed As Boolean    'button held in and depressed?
Public bIgnoreIt As Boolean         'ignore button?
Public x1 As Integer                'bounds of clicks
Public y1 As Integer                'bounds of clicks
Public x2 As Integer                'bounds of clicks
Public y2 As Integer                'bounds of clicks

Public nButtonNum As Long

'CANVAS
Public sCanvasFilename As String       'background of canvas

'standard form code...
Public formLoadRpgCode As String           'code to run when form has finished drawing.

'BUTTON
Private Type rpgcodeButton
    x1 As Integer
    y1 As Integer
    x2 As Integer
    y2 As Integer
    filename As String
    rpgcode As String
End Type
Private theButtons(50) As rpgcodeButton   '50 buttons defined

'IMAGE
Private Type rpgcodeImage
    x1 As Integer
    y1 As Integer
    x2 As Integer
    y2 As Integer
    filename As String
End Type
Private theImages(50) As rpgcodeImage   '50 images defined

'LINE
Private Type rpgcodeLine
    x1 As Integer
    y1 As Integer
    x2 As Integer
    y2 As Integer
    col As Long
End Type
Private theLines(50) As rpgcodeLine     '50 lines

'RECTANGLE
Private Type rpgcodeRect
    x1 As Integer
    y1 As Integer
    x2 As Integer
    y2 As Integer
    col As Long
End Type
Private theRects(50) As rpgcodeRect     '50 rects

'TEXT
Private Type rpgcodeText
    x1 As Integer
    y1 As Integer
    size As Integer
    textString As String
End Type

Private theText(50) As rpgcodeText   '50 text defined

Private Sub newVisualForm()
    'clears form memory
    On Error GoTo ErrorHandler
    Dim t As Integer
    sCanvasFilename = ""

    formLoadRpgCode = ""

    For t = 0 To 50
        theButtons(t).filename = ""
        theButtons(t).rpgcode = ""
        theButtons(t).x1 = 0
        theButtons(t).x2 = 0
        theButtons(t).y1 = 0
        theButtons(t).y2 = 0
    Next t

    For t = 0 To 50
        theImages(t).filename = ""
        theImages(t).x1 = 0
        theImages(t).x2 = 0
        theImages(t).y1 = 0
        theImages(t).y2 = 0
    Next t

    For t = 0 To 50
        theLines(t).col = 0
        theLines(t).x1 = 0
        theLines(t).x2 = 0
        theLines(t).y1 = 0
        theLines(t).y2 = 0
    Next t

    For t = 0 To 50
        theRects(t).col = 0
        theRects(t).x1 = 0
        theRects(t).x2 = 0
        theRects(t).y1 = 0
        theRects(t).y2 = 0
    Next t


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub openFile(ByVal file As String)
    'opens a file.
    On Error Resume Next
    tkvisual.Show
    Call loadForm(file)
    Call redraw
End Sub

Private Sub loadForm(ByVal filename As String)
    'load a form
    On Error Resume Next
    Dim a As String
    Dim num As Integer
    Dim x As Integer
    Dim bDone As Boolean
    
    num = FreeFile()
    
    Open filename For Input As #num
        Line Input #num, a
        If UCase$(a) <> "RPGTLKIT RPGCODEFORM" Then
            MsgBox "This is not a valid form file", , "Cannot open form"
            Close #num
            Exit Sub
        End If
        Line Input #num, a
        If a <> "2" Then
            MsgBox "This is not a version 2 form file", , "Cannot open form"
            Close #num
            Exit Sub
        End If
        Line Input #num, a
        Line Input #num, a 'resgieterd- yes
        'data....
        Line Input #num, sCanvasFilename     'canvas background image
        
        'buttons...
        For x = 0 To 50
            Line Input #num, theButtons(x).filename
            Input #num, theButtons(x).x1
            Input #num, theButtons(x).y1
            Input #num, theButtons(x).x2
            Input #num, theButtons(x).y2
            Line Input #num, a  '*CODE
            'following is code...
            bDone = False
            theButtons(x).rpgcode = ""
            Do While (Not bDone)
                Line Input #num, a
                If UCase$(a) = "*ENDCODE" Then
                    bDone = True
                Else
                    theButtons(x).rpgcode = theButtons(x).rpgcode + a + chr$(13) + chr$(10)
                End If
            Loop
        Next x
    
        'images...
        For x = 0 To 50
            Line Input #num, theImages(x).filename
            Input #num, theImages(x).x1
            Input #num, theImages(x).y1
            Input #num, theImages(x).x2
            Input #num, theImages(x).y2
        Next x
        
        'lines...
        For x = 0 To 50
            Input #num, theLines(x).x1
            Input #num, theLines(x).y1
            Input #num, theLines(x).x2
            Input #num, theLines(x).y2
            Input #num, theLines(x).col
        Next x
    
        'rects...
        For x = 0 To 50
            Input #num, theRects(x).x1
            Input #num, theRects(x).y1
            Input #num, theRects(x).x2
            Input #num, theRects(x).y2
            Input #num, theRects(x).col
        Next x
    
        'following is code...
        Line Input #num, a  '*CODE
        bDone = False
        formLoadRpgCode = ""
        Do While (Not bDone)
            Line Input #num, a
            If UCase$(a) = "*ENDCODE" Then
                bDone = True
            Else
                formLoadRpgCode = formLoadRpgCode + a + chr$(13) + chr$(10)
            End If
        Loop
    Close #num
End Sub

Private Sub redrawLines()
    'redraw the lines
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    Dim x1 As Integer
    Dim y1 As Integer
    Dim x2 As Integer
    Dim y2 As Integer
    Dim col As Long
    
    For nCount = 0 To 50
        If Not (theLines(nCount).x1 = 0 And theLines(nCount).y1 = 0 And theLines(nCount).x2 = 0 And theLines(nCount).y2 = 0) Then
            x1 = theLines(nCount).x1
            y1 = theLines(nCount).y1
            x2 = theLines(nCount).x2
            y2 = theLines(nCount).y2
            col = theLines(nCount).col
            Call vbPicAutoRedraw(tkvisual.boardform, True)
            Call vbPicLine(tkvisual.boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), col)
        End If
    Next nCount

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub redrawrects()
    'redraw the rects
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    Dim x1 As Integer
    Dim y1 As Integer
    Dim x2 As Integer
    Dim y2 As Integer
    Dim col As Long
    
    For nCount = 0 To 50
        If Not (theRects(nCount).x1 = 0 And theRects(nCount).y1 = 0 And theRects(nCount).x2 = 0 And theRects(nCount).y2 = 0) Then
            x1 = theRects(nCount).x1
            y1 = theRects(nCount).y1
            x2 = theRects(nCount).x2
            y2 = theRects(nCount).y2
            col = theRects(nCount).col
            Call vbPicAutoRedraw(tkvisual.boardform, True)
            Call vbPicRect(tkvisual.boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), col)
        End If
    Next nCount

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub saveForm(filename As String)
    'save this form
    On Error Resume Next
    Dim num As Integer
    Dim x As Integer
    
    num = FreeFile
    
    Open filename For Output As #num
        Print #num, "RPGTLKIT RPGCODEFORM"
        Print #num, "2"
        Print #num, "0"
        Print #num, "1" 'resgieterd- yes
        Print #num, sCanvasFilename     'canvas background image
        'buttons...
        For x = 0 To 50
            Print #num, theButtons(x).filename
            Print #num, theButtons(x).x1
            Print #num, theButtons(x).y1
            Print #num, theButtons(x).x2
            Print #num, theButtons(x).y2
            Print #num, "*CODE"
            Print #num, theButtons(x).rpgcode
            Print #num, "*ENDCODE"
        Next x
        'images...
        For x = 0 To 50
            Print #num, theImages(x).filename
            Print #num, theImages(x).x1
            Print #num, theImages(x).y1
            Print #num, theImages(x).x2
            Print #num, theImages(x).y2
        Next x
        'lines...
        For x = 0 To 50
            Print #num, theLines(x).x1
            Print #num, theLines(x).y1
            Print #num, theLines(x).x2
            Print #num, theLines(x).y2
            Print #num, theLines(x).col
        Next x
    
        'rects...
        For x = 0 To 50
            Print #num, theRects(x).x1
            Print #num, theRects(x).y1
            Print #num, theRects(x).x2
            Print #num, theRects(x).y2
            Print #num, theRects(x).col
        Next x
        'user load code...
        Print #num, "*CODE"
        Print #num, formLoadRpgCode
        Print #num, "*ENDCODE"
    Close #num
End Sub

Private Sub boxCreated(ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
    'sub that is called after the user drags a box onto the screen.
    'action is based upon the tool that is currently selected.
    On Error GoTo ErrorHandler
    Dim Temp As Integer
    If toolMode <> 4 Then
        If x1 > x2 Then
            Temp = x1
            x1 = x2
            x2 = Temp
        End If
        If y1 > y2 Then
            Temp = y1
            y1 = y2
            y2 = Temp
        End If
    End If
    
    Select Case toolMode
        Case 0:
            'pointer
            
        Case 1:
            'image
            Call setImage(x1, y1, x2, y2)
            
        Case 2:
            'text
            'Call setText(x1, y1, x2, y2)
            
        Case 3:
            'button
            Call setButton(x1, y1, x2, y2)
            
        Case 4:
            'line
            Call setLine(x1, y1, x2, y2, curcolor)
            
        Case 5:
            'rectangle
            Call setRect(x1, y1, x2, y2, curcolor)
            
    End Select
    bButtonPressed = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub BuildToRPGCode(filename As String)
    'build the visual form into an RPGCode file
    On Error Resume Next
    If filename = "" Then Exit Sub
    
    Dim num As Integer
    Dim x As Integer
    Dim numLines As Integer
    Dim c As Integer
    num = FreeFile
    
    Open filename For Output As num
        'phase 1...  comments...
        Print #num, "**********************************************************"
        Print #num, "*                RPGCode Visual Program                  *"
        Print #num, "*       Generated by the RPG Toolkit Visual Editor       *"
        Print #num, "* RPG Toolkit Development System, 3 Open Source Edition  *"
        Print #num, "**********************************************************"
        Print #num, ""
        Print #num, "Include(" + chr(34) & "System.prg" & chr(34) + ")"
        Print #num, ""
        'phase 2... save the rpg code state...
        Print #num, "* Save current RPGCode state..."
        Print #num, "GetColor(m_clr!, m_clg!, m_clb!)"
        Print #num, "m_fsize! = GetFontSize()"
        Print #num, ""

        'phase 3a... now 'draw' into the program...
        Print #num, "* Render the screen..."
        Print #num, "RenderVisualForm()"
        Print #num, ""
        
        'phase 3b... insert user's draw code...
        Print #num, "* Render user code..."
        Print #num, "RenderUserCode()"
        Print #num, ""
        
        'phase 4... now process events...
        Print #num, "* Process events..."
        Print #num, "#ProcessFormEvents()"
        Print #num, ""
        
        'phase 5... restore the rpg code state...
        Print #num, "* Restore RPGCode state..."
        Print #num, "ColorRGB(m_clr!, m_clg!, m_clb!)"
        Print #num, "FontSize(m_fsize!)"
        Print #num, "Stop()"
        Print #num, ""
        Print #num, ""
        
        'phase 6... method comment block...
        Print #num, "********************************************************"
        Print #num, "* Methods:                                             *"
        Print #num, "* RenderVisualForm()- Renders the screen               *"
        Print #num, "* RenderUserCode()- User defined code for startup      *"
        Print #num, "* ProcessFormEvents()- Process events                  *"
        Print #num, "* FormEnd()- Called to exit the event processing       *"
        Print #num, "********************************************************"
        Print #num, ""
        
        'phase 7... the rendering method...
        Print #num, "Method RenderVisualForm()"
        Print #num, "{"
            Print #num, chr$(9) & "* Clearn screen..."
            Print #num, chr$(9) & "ColorRGB(255, 255, 255)"
            Print #num, chr$(9) & "FillRect(0, 0, 608, 352)"
            Print #num, ""
            
            'first render the background image...
            If (sCanvasFilename <> "") Then
                Print #num, chr(9) & "* Render background image..."
                Print #num, chr(9) & "Bitmap(" & chr(34) & sCanvasFilename & chr(34) & ")"
                Print #num, ""
            End If
            
            'now render images...
            Print #num, chr$(9) + "* Render images (if any exist)..."
            For x = 0 To 50
                If theImages(x).filename <> "" Then
                    Print #num, chr(9) + "SetImage(" & chr(34) & theImages(x).filename & chr(34) & _
                                                "," & str(theImages(x).x1) & _
                                                "," & str(theImages(x).y1) & _
                                                "," & str(theImages(x).x2 - theImages(x).x1) & _
                                                "," & str(theImages(x).y2 - theImages(x).y1) & _
                                                ")"
                End If
            Next x
            Print #num, ""
        
            'now render buttons...
            Print #num, chr(9) & "* Render buttons (if any exist)..."
            Print #num, chr(9) + "ClearButtons()"
            For x = 0 To 50
                If theButtons(x).filename <> "" Then
                    Print #num, chr(9) + "SetButton(" & chr(34) & theButtons(x).filename & chr(34) + _
                                                "," & str(x) & _
                                                "," & str(theButtons(x).x1) + _
                                                "," & str(theButtons(x).y1) + _
                                                "," & str(theButtons(x).x2 - theButtons(x).x1) & _
                                                "," & str(theButtons(x).y2 - theButtons(x).y1) & _
                                                ")"
                End If
            Next x
            Print #num, ""

            'now render lines...
            Print #num, chr(9) & "* Render lines (if any exist)..."
            For x = 0 To 50
                If Not (theLines(x).x1 = 0 And theLines(x).y1 = 0 And theLines(x).x2 = 0 And theLines(x).y2 = 0) Then
                    Print #num, chr(9) & "ColorRGB(" & _
                                                        str(red(theLines(x).col)) & "," & _
                                                        str(green(theLines(x).col)) & "," & _
                                                        str(blue(theLines(x).col)) & ")"
                    Print #num, chr(9) & "#DrawLine(" & str(theLines(x).x1) & _
                                            "," & str(theLines(x).y1) & _
                                            "," & str(theLines(x).x2) & _
                                            "," & str(theLines(x).y2) & ")"
                End If
            Next x
            Print #num, ""
            
            'now render rects...
            Print #num, chr(9) & "* Render rectangles (if any exist)..."
            For x = 0 To 50
                If Not (theRects(x).x1 = 0 And theRects(x).y1 = 0 And theRects(x).x2 = 0 And theRects(x).y2 = 0) Then
                    Print #num, chr(9) + "ColorRGB(" + _
                                                        str(red(theRects(x).col)) & "," & _
                                                        str(green(theRects(x).col)) & "," & _
                                                        str(blue(theRects(x).col)) & ")"
                    Print #num, chr(9) & "DrawRect(" & str(theRects(x).x1) & _
                                            "," & str(theRects(x).y1) & _
                                            "," & str(theRects(x).x2) & _
                                            "," & str(theRects(x).y2) & ")"
                End If
            Next x
            Print #num, ""
        Print #num, "}"
        Print #num, ""
        Print #num, ""
        
        'phase 7b... the user rendering method...
        Print #num, "Method RenderUserCode()"
        Print #num, "{"
            formLoadRpgCode = formLoadRpgCode & vbCrLf
            numLines = countTextLines(formLoadRpgCode)
            If numLines > 0 Then
                For c = 0 To numLines - 1
                    Print num, chr(9) & getTextLineNumber(formLoadRpgCode, c)
                Next c
            End If
        Print #num, "}"
        Print #num, ""
        Print #num, ""
        
        'phase 8... the event processing method...
        Print #num, "Method ProcessFormEvents()"
        Print #num, "{"
            'now, if we have buttons, events will be handles by mouseclicks.
            'otherwise, the #wait command will be our only event.
            If (ifButtons()) Then
                Print #num, chr(9) & "* Wait for user to click a button..."
                Print #num, chr(9) & "m_done! = 0"
                Print #num, chr(9) & "while (m_done! == 0)"
                Print #num, chr(9) & "{"
                    Print #num, chr(9) & chr(9) & "MWinCls()"
                    Print #num, chr(9) & chr(9) & "MouseClick(m_x!, m_y!)"
                    Print #num, chr(9) & chr(9) & "CheckButton(m_x!, m_y!, m_button!)"
                    Print #num, chr(9) & chr(9) & "* Check which button was pressed..."
                    Print #num, ""
                    
                    For x = 0 To 50
                        If theButtons(x).filename <> "" Then
                            Print #num, chr(9) & chr(9) & "if (m_button! ==" & str(x) & ")"
                            Print #num, chr(9) & chr(9) & "{"
                                theButtons(x).rpgcode = theButtons(x).rpgcode & chr(13) & chr(10)
                                numLines = countTextLines(theButtons(x).rpgcode)
                                If numLines > 0 Then
                                    For c = 0 To numLines - 1
                                        Print #num, chr(9) & chr(9) & chr(9) & getTextLineNumber(theButtons(x).rpgcode, c)
                                    Next c
                                End If
                            Print #num, chr$(9) + chr$(9) + "}"
                            Print #num, ""
                        End If
                    Next x
                    
                Print #num, chr(9) & "}"
                Print #num, ""
            Else
                'no buttons-- process the #wait command
                Print #num, chr(9) & "* Wait for user to press a key..."
                Print #num, chr(9) & "Wait()"
            End If
        Print #num, "}"
        Print #num, ""
        
        'phase 9... the formend method...
        Print #num, "method FormEnd()"
        Print #num, "{"
        Print #num, chr(9) & "* Cause the event processing #while loop to break..."
        Print #num, chr(9) & "m_done! = 1"
        Print #num, "}"
    Close #num
End Sub

Private Function checkButtonClicked(x As Integer, y As Integer, ByRef theNum As Integer) As Boolean
    'checks all buttons to see if x,y is within the click area.
    'if it it, the button that was clicked is placed in theNum and this function returns true
    On Error Resume Next
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theButtons(nCount).filename <> "" Then
            If theButtons(nCount).x1 <= x And _
                theButtons(nCount).x2 >= x And _
                theButtons(nCount).y1 <= y And _
                theButtons(nCount).y2 >= y Then
                theNum = nCount
                checkButtonClicked = True
                Exit Function
            End If
        End If
    Next nCount

End Function

Private Function getImageFilename() As String
    'prompts for a button filename.
    On Error Resume Next
    Dim filename As String
    Dim antiPath As String
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "jpg"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        getImageFilename = ""
        Exit Function
    End If
    ChDir (currentDir$)
    'If filename$(1) = "" Then Exit Sub
    FileCopy filename$, projectPath$ + bmpPath$ + antiPath$
    getImageFilename = antiPath
End Function

Function GetPrgFilename() As String
    'prompts for an rpgcode program.
    On Error Resume Next
    Dim filename As String
    Dim antiPath As String
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPGCode Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        GetPrgFilename = ""
        Exit Function
    End If
    ChDir (currentDir$)
    'If filename$(1) = "" Then Exit Sub
    FileCopy filename$, projectPath$ + prgPath$ + antiPath$
    GetPrgFilename = filename
End Function

Function getTrueCoordX(x As Integer) As Integer
    'returns the true pixel of an x coordinate
    'originally defined within the boardform bounds (ie 608 x 352)
    On Error GoTo ErrorHandler
    Dim nWidth As Integer
    Dim dRatio As Double
    Dim nRet As Integer
    
    nWidth = tkvisual.boardform.width / Screen.TwipsPerPixelX
    dRatio = nWidth / (19 * 32)
        
    nRet = x * dRatio
    getTrueCoordX = nRet

    Exit Function

'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function

Function getTrueCoordY(y As Integer) As Integer
    'returns the true pixel of a y coordinate
    'originally defined within the boardform bounds (ie 608 x 352)
    On Error GoTo ErrorHandler
    Dim nHeight As Integer
    Dim dRatio As Double
    Dim nRet As Integer
    
    nHeight = tkvisual.boardform.Height / Screen.TwipsPerPixelY
    dRatio = nHeight / (11 * 32)
        
    nRet = y * dRatio
    getTrueCoordY = nRet

    Exit Function

'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function


Function ifButtons() As Boolean
    'checks to see if any buttons are set.
    'If the are, then we return true, else false
    On Error GoTo ErrorHandler
    Dim x As Integer
    
    For x = 0 To 50
        If theButtons(x).filename <> "" Then
            ifButtons = True
            Exit Function
        End If
    Next x
    ifButtons = False

    Exit Function

'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function

Sub loadSizedPicture(filename As String, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    'loads a sized picture into the boardformn
    'PicClip1.Picture = LoadPicture(filename)
    'PicClip1.ClipX = 0
    'PicClip1.ClipY = 0
    'PicClip1.ClipHeight = PicClip1.Height
    'PicClip1.ClipWidth = PicClip1.Width
    'PicClip1.StretchX = (x2 - x1)
    'PicClip1.StretchY = (y2 - y1)
    'boardform.Picture = PicClip1.Clip
    On Error GoTo ErrorHandler
    Dim a As Integer

     'tkvisual.PicClip1.Picture = LoadPicture(projectPath + bmppath + filename)
     'tkvisual.PicClip1.ClipX = 0
     'tkvisual.PicClip1.ClipY = 0
     'tkvisual.PicClip1.ClipHeight = tkvisual.PicClip1.height
     'tkvisual.PicClip1.ClipWidth = tkvisual.PicClip1.width
     'tkvisual.PicClip1.StretchX = getTrueCoordX(x2 - x1)
     'tkvisual.PicClip1.StretchY = getTrueCoordY(y2 - y1)
    
     'tkvisual.buffer.Picture = tkvisual.PicClip1.Clip
     Call vbPicAutoRedraw(tkvisual.buffer, True)
     Call DrawSizedImage(projectPath + bmpPath + filename, 0, 0, getTrueCoordX(x2 - x1), getTrueCoordY(y2 - y1), vbPicHDC(tkvisual.buffer))
        
     Call vbPicAutoRedraw(tkvisual.buffer, True)
     Call vbPicAutoRedraw(tkvisual.boardform, True)
     
     a = BitBlt(vbPicHDC(tkvisual.boardform), _
                getTrueCoordX(x1), _
                getTrueCoordY(y1), _
                getTrueCoordX(x2 - x1), _
                getTrueCoordY(y2 - y1), _
                vbPicHDC(tkvisual.buffer), _
                0, _
                0, _
                SRCCOPY)
     Call vbPicRefresh(tkvisual.boardform)
     
     'tkvisual.cache.AutoRedraw = False
     'tkvisual.boardform.AutoRedraw = False


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub redraw()
    'refreshes the form.
    On Error GoTo ErrorHandler
    
    Call vbPicCls(tkvisual.boardform)
    
    Dim x As Integer
    Dim y As Integer
    Dim xx As Integer
    Dim yy As Integer
      
      
    'draw background image...
    Call redrawBackground
    
    'draw openTileEditorDocs(activeTile.indice).grid...
    If bGridOnOff Then
        For x = 0 To 19 * 32 Step 10
            For y = 0 To 11 * 32 Step 10
                xx = getTrueCoordX(x) - 1
                yy = getTrueCoordY(y) - 1
                Call vbPicPSet(tkvisual.boardform, xx, yy, vbQBColor(8))
            Next y
        Next x
    End If
    
    'draw images...
    Call redrawImages
    
    'draw buttons...
    Call redrawButtons
    
    'draw text...
    
    'draw lines...
    Call redrawLines
    
    'draw rects...
    Call redrawrects
    

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub redrawBackground()
    'redraws canvas bkg graphic
    On Error GoTo ErrorHandler
    Dim xx As Integer
    Dim yy As Integer
    
    If sCanvasFilename = "" Then Exit Sub
    Call loadSizedPicture(sCanvasFilename, 0, 0, 608, 352)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub redrawButtons()
    'redraws all buttons
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theButtons(nCount).filename <> "" Then
            Call loadSizedPicture(theButtons(nCount).filename, _
                                  theButtons(nCount).x1, _
                                  theButtons(nCount).y1, _
                                  theButtons(nCount).x2, _
                                  theButtons(nCount).y2)
        End If
    Next nCount

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub redrawImages()
    'redraws all images
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theImages(nCount).filename <> "" Then
            Call loadSizedPicture(theImages(nCount).filename, _
                                  theImages(nCount).x1, _
                                  theImages(nCount).y1, _
                                  theImages(nCount).x2, _
                                  theImages(nCount).y2)
        End If
    Next nCount

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub setButton(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    'called when we are to set a button from x1,y1 to x2,y2
    'find and empty button...
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theButtons(nCount).filename = "" Then
            theButtons(nCount).filename = getImageFilename()
            If theButtons(nCount).filename = "" Then Exit Sub
            theButtons(nCount).x1 = x1
            theButtons(nCount).y1 = y1
            theButtons(nCount).x2 = x2
            theButtons(nCount).y2 = y2
            theButtons(nCount).rpgcode = "* Button" + str$(nCount) + "; Filename " + theButtons(nCount).filename + chr$(13) + chr$(10) + "* TBD: Replace the #FormEnd with your own code" + chr$(13) + chr$(10) + "#FormEnd()"
            Call loadSizedPicture(theButtons(nCount).filename, x1, y1, x2, y2)
            'MsgBox Str$(nCount) + " " + theButtons(nCount).filename
            Exit Sub
        End If
    Next nCount
    MsgBox "Cannot place any more buttons on this form (max is 51)", , "Can't place button"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub setImage(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    'called when we are to set an image from x1,y1 to x2,y2
    'find and empty image...
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theImages(nCount).filename = "" Then
            theImages(nCount).filename = getImageFilename()
            If theImages(nCount).filename = "" Then Exit Sub
            theImages(nCount).x1 = x1
            theImages(nCount).y1 = y1
            theImages(nCount).x2 = x2
            theImages(nCount).y2 = y2
            Call loadSizedPicture(theImages(nCount).filename, x1, y1, x2, y2)
            'MsgBox Str$(nCount) + " " + theButtons(nCount).filename
            Exit Sub
        End If
    Next nCount
    MsgBox "Cannot place any more images on this form (max is 51)", , "Can't place image"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub setLine(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, col As Long)
    'set a line
    'find and empty line...
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theLines(nCount).x1 = 0 And theLines(nCount).y1 = 0 And theLines(nCount).x2 = 0 And theLines(nCount).y2 = 0 Then
            theLines(nCount).x1 = x1
            theLines(nCount).y1 = y1
            theLines(nCount).x2 = x2
            theLines(nCount).y2 = y2
            theLines(nCount).col = col
            Call vbPicAutoRedraw(tkvisual.boardform, True)
            Call vbPicLine(tkvisual.boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), col)
            Call vbPicRefresh(tkvisual.boardform)
            Exit Sub
        End If
    Next nCount
    MsgBox "Cannot place any more lines on this form (max is 51)", , "Can't place line"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub setRect(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, col As Long)
    'set a rect
    'find and empty rect...
    On Error GoTo ErrorHandler
    Dim nCount As Integer
    
    For nCount = 0 To 50
        If theRects(nCount).x1 = 0 And theRects(nCount).y1 = 0 And theRects(nCount).x2 = 0 And theRects(nCount).y2 = 0 Then
            theRects(nCount).x1 = x1
            theRects(nCount).y1 = y1
            theRects(nCount).x2 = x2
            theRects(nCount).y2 = y2
            theRects(nCount).col = col
            Call vbPicAutoRedraw(tkvisual.boardform, True)
            Call vbPicRect(tkvisual.boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), col)
            Call vbPicRefresh(tkvisual.boardform)
            Exit Sub
        End If
    Next nCount
    MsgBox "Cannot place any more rectangles on this form (max is 51)", , "Can't place rectangle"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub sizescreen()
    'sizes screen to appropriate resoultion
    On Error GoTo ErrorHandler
    Dim sx As Integer   'screen width, pixels
    Dim sy As Integer   'screen height, pixels
    Dim tppx As Integer 'twips per pixel x
    Dim tppy As Integer 'twips per pixel y
    Dim screenPercentage As Double  'percentage of screne to take up (0-1)
    
    'screenPercentage = 0.75
    
    'tppx = Screen.TwipsPerPixelX
    'tppy = Screen.TwipsPerPixelY
    
    'sx = Screen.Width / tppx
    'sy = Screen.Height / tppy
    
    'size form...
    'tkvisual.Top = 0
    'tkvisual.Left = 0
    'tkvisual.Width = screenPercentage * sx * tppx
    'tkvisual.Height = screenPercentage * sy * tppy
    
    'size boardform...
    'it must have the same aspect ratio as 608x352 pixels (the actual boardofrm with in the tk)
    'aspect: 1.72 (w/h) or 0.57 (h/w)
    
    'tkvisual.boardform.Top = 0.05 * tkvisual.Width
    'tkvisual.boardform.Left = 0.025 * tkvisual.Height
    'tkvisual.boardform.Width = 0.8 * tkvisual.Width
    'tkvisual.boardform.Height = 0.57 * tkvisual.boardform.Width
    
    buffer.Top = boardform.Top
    buffer.Left = boardform.Left
    buffer.width = boardform.width
    buffer.Height = boardform.Height
    
    'size code form...
    'tkvisual.codeform.Top = tkvisual.boardform.Top + tkvisual.boardform.Height + 20 * tppy
    'tkvisual.codeform.Left = tkvisual.boardform.Left
    'tkvisual.codeform.Width = tkvisual.boardform.Width
    'tkvisual.codeform.Height = 0.2 * tkvisual.Height
    
    'Dim nCount As Integer
    'For nCount = 0 To 5 Step 2
    '    ControlPanel(nCount).Left = boardform.Left + boardform.Width + 10 * tppx
    'Next nCount
    'For nCount = 1 To 5 Step 2
    '    ControlPanel(nCount).Left = ControlPanel(nCount).Width + boardform.Left + boardform.Width + 10 * tppx
    'Next nCount
    'ControlPanel(0).Top = boardform.Top
    'ControlPanel(1).Top = boardform.Top
    'ControlPanel(2).Top = boardform.Top + ControlPanel(0).Height
    'ControlPanel(3).Top = boardform.Top + ControlPanel(0).Height
    'ControlPanel(4).Top = boardform.Top + ControlPanel(0).Height * 2
    'ControlPanel(5).Top = boardform.Top + ControlPanel(0).Height * 2
    'gridbutton.Top = boardform.Top + ControlPanel(0).Height * 3
    'gridbutton.Left = ControlPanel(0).Left
    'gridbutton.Width = ControlPanel(0).Width * 2
    'redrawbutton.Top = boardform.Top + ControlPanel(0).Height * 3 + gridbutton.Height * 2
    'redrawbutton.Left = ControlPanel(0).Left
    'redrawbutton.Width = ControlPanel(0).Width * 2

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub boardform_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo ErrorHandler
    Dim xx As Integer
    Dim yy As Integer
      
    xx = x * (19 * 32) / (boardform.width / Screen.TwipsPerPixelX)
    yy = y * (11 * 32) / (boardform.Height / Screen.TwipsPerPixelY)
      
    If bGridOnOff Then
        xx = Int(xx / 10) * 10
        yy = Int(yy / 10) * 10
    End If
      
    coords.Caption = str$(xx) + "," + str$(yy)
    
    If toolMode = 0 And Button = 1 Then
        'pointer tool selected.  Let's see if we clicked on something...
        Dim bClicked As Boolean
        Dim num As Integer
        bClicked = checkButtonClicked(xx, yy, num)
        If bClicked = True Then
            codeForm.visible = True
            nButtonNum = num
            codeForm.Text = theButtons(num).rpgcode
        Else
            nButtonNum = -1
            If formLoadRpgCode = "" Then
                formLoadRpgCode = "* Form Load Event (this code gets run each time the screen is refreshed)" + chr$(13) + chr$(10) + "* TBD: Input your own code here:"
            End If
            codeForm.visible = True
            codeForm.Text = formLoadRpgCode
        End If
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub boardform_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo ErrorHandler
    Dim xx As Integer
    Dim yy As Integer
      
    If bIgnoreIt = True Then
        bIgnoreIt = False
        bButtonPressed = False
        Exit Sub
    End If
      
    xx = x * (19 * 32) / (boardform.width / Screen.TwipsPerPixelX)
    yy = y * (11 * 32) / (boardform.Height / Screen.TwipsPerPixelY)
      
    If bGridOnOff Then
        xx = Round(xx / 10) * 10
        yy = Round(yy / 10) * 10
    End If
      
    coords.Caption = str$(xx) + "," + str$(yy)
    
    If toolMode <> 0 Then
        If bButtonPressed = True And Button = 0 Then
            'end of button click
            x2 = xx
            y2 = yy
            Call vbPicAutoRedraw(boardform, False)
            Call vbPicRefresh(boardform)
            If toolMode = 4 Then
                Call vbPicLine(boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), curcolor)
            Else
                Call vbPicRect(boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(x2), getTrueCoordY(y2), curcolor)
            End If
            'boardform.Line (x1, y1)-(x2, y2), vbqbcolor(1), B
            Call vbPicAutoRedraw(boardform, True)
            Call boxCreated(x1, y1, x2, y2)
            bButtonPressed = False
            bIgnoreIt = True
            Exit Sub
        End If
        If bButtonPressed = False And Button = 1 Then
            x1 = xx
            y1 = yy
            bButtonPressed = True
            Exit Sub
        End If
        If bButtonPressed = True And Button = 1 Then
            Call vbPicAutoRedraw(boardform, False)
            Call vbPicRefresh(boardform)
            If toolMode = 4 Then
                Call vbPicLine(boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(xx), getTrueCoordY(yy), curcolor)
            Else
                Call vbPicRect(boardform, getTrueCoordX(x1), getTrueCoordY(y1), getTrueCoordX(xx), getTrueCoordY(yy), curcolor)
            End If
            Call vbPicAutoRedraw(boardform, True)
            Exit Sub
        End If
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub codeform_Change()
    On Error GoTo ErrorHandler
    If nButtonNum = -1 Then
        formLoadRpgCode = codeForm.Text
    Else
        theButtons(nButtonNum).rpgcode = codeForm.Text
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub colorform_Click()
    On Error GoTo ErrorHandler
    curcolor = ColorDialog()
    Call vbPicFillRect(colorform, 0, 0, 1000, 1000, curcolor)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    sCanvasFilename = getImageFilename()
    Call redraw

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub editmnu_Click()
    On Error GoTo ErrorHandler


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo ErrorHandler
    Dim aa As Integer
    aa = MsgBox(LoadStringLoc(990, "Closing this window will destroy changes.  Do you wish to save your changes?"), vbYesNo)
    If aa = 6 Then
        'yes
        Call mnusave_Click
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub gridbutton_Click()
    On Error GoTo ErrorHandler
    Dim x As Integer
    Dim y As Integer
    Dim xx As Integer
    Dim yy As Integer
    
    bGridOnOff = Not (bGridOnOff)
    
    Call redraw

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub ControlPanel_Click(Index As Integer)
    On Error GoTo ErrorHandler
    toolMode = Index

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    'projectPath = "Game\thejew~1\"
    'bmpPath = "bitmap\"
    'prgPath = "prg\"
    'currentdir$ = CurDir$
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Call sizescreen

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub mnubuild_Click()
    On Error GoTo ErrorHandler
    Call BuildToRPGCode(GetPrgFilename())

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuCLose_Click()
    On Error GoTo ErrorHandler
    Unload tkvisual

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnunew_Click()
    On Error GoTo ErrorHandler
    Dim aa As Integer
    aa = MsgBox(LoadStringLoc(947, "Are you sure you want to erase the current form and start a new one?"), vbYesNo)
    If aa = 6 Then
        'yes
        Call newVisualForm
        Call redraw
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuopen_Click()
    On Error Resume Next
    Dim filename As String
    Dim antiPath As String
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "rfm"
    dlg.strFileTypes = "RPGCode Form (*.rfm)|*.rfm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    'If filename$(1) = "" Then Exit Sub
    Call loadForm(filename)
    Call redraw
End Sub

Public Sub mnusave_Click()
    On Error GoTo ErrorHandler
    If curfilename = "" Then
        Call mnusaveas_Click
    Else
        Call saveForm(curfilename)
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Public Sub mnusaveas_Click()
    On Error Resume Next
    Dim filename As String
    Dim antiPath As String
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "rfm"
    dlg.strFileTypes = "RPGCode Form (*.rfm)|*.rfm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    Call saveForm(filename)
    curfilename = filename
    Call tkMainForm.tvAddFile(filename)
End Sub

Private Sub redrawbutton_Click()
    On Error Resume Next
    Call redraw
End Sub

Private Sub tocmnu_Click()
    On Error Resume Next
    Call BrowseFile(helpPath & ObtainCaptionFromTag(DB_Help1, resourcePath & m_LangFile))
End Sub
