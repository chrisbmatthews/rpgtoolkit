Attribute VB_Name = "modSyntax"
' modSyntax
'
' This module handles all of the synatax coloring routines.
'
' MODULE REVISION
'
' 2.00
'   - Added real-time coloring (KSNiloc)
'   - Added styling options (KSNiloc)
'   - Added code bookmarks (KSNiloc)
' 1.70
'   - Fixed for Toolkit 3 Implemtentation (gw)
'   - Fixed to work with #AutoCommand, this is a temporary
'     solution that can be improved upon in later versions (gw)
' 1.60
'   - More improvements to coloring routines (gw)
'   - Fixed a bug with bracket coloring. (gw)
'   - Fixed a bug with comment coloring after a command / variable line (gw)
' 1.50
'   - Changed module name to modSyntax (gw)
'   - Improvmenets to Coloring code, theres now no For loop for the
'     line type detection (gw)
' 1.40
'   - Removed Old Debugging Code (gw)
' 1.30
'   - Syntax Coloring Routines (gw)
' 1.20
'   - Contiuned work on Debugging (this could take a while) (gw)
' 1.10
'   - Added Debugging Functions (gw)
' 1.00
'   - First Version (gw)

Option Explicit

Private ColorCodes(5) As Long
Private BoldCodes(5) As Long
Private ItalicCodes(5) As Long
Private UnderlineCodes(5) As Long

Public Function SplitLines(Optional ByVal min As Long = -1, Optional ByVal max As Long = -1)

' Synatx Coloring
Dim linesArray() As String
Dim runningTotal As Long
Dim startTime As Long
Dim StopTime As Long
Dim TimeToColor As Long
Dim x As Long

Dim currentObject As RichTextBox
Set currentObject = activeRPGCode.codeForm

Call GetLineColors

currentObject.tag = "1"

'Clear bookmarks...
With activeRPGCode
    .cboMethodBookmarks.Clear
    .cboCommentBookmarks.Clear
    .cboLabelBookmarks.Clear
End With

currentObject.Visible = False
linesArray() = Split(currentObject.Text, vbNewLine)
runningTotal = 0

'StartTime = GetTickCount
For x = 0 To UBound(linesArray())
    'If UBound(linesArray()) > 0 Then frmMain.StatusBar1.Panels(1).text = "Coloring " & Int((x / UBound(linesArray())) * 100) & "%"

    currentObject.selStart = runningTotal
    currentObject.SelLength = Len(linesArray(x))

    If (x >= min And x <= max) Or (min = -1 And max = -1) Then

        currentObject.SelFontName = "Courier New"
        currentObject.SelFontSize = 10

        If min = -1 Then
            ColorLine linesArray(x), runningTotal
        Else
            ColorLine linesArray(x), runningTotal, True
        End If
        
    End If

    If Not min - 1 Then addBookmark linesArray(x)

    runningTotal = runningTotal + Len(linesArray(x)) + 2
     
Next x

'StopTime = GetTickCount
If min = -1 Then currentObject.selStart = 1
currentObject.Visible = True
'TimeToColor = Round((StopTime - StartTime) / 1000, 2)
'frmMain.StatusBar1.Panels(1).text = "Loaded " & (UBound(linesArray()) - 1) & " liines in " & TimeToColor & " seconds"
End Function

Function ColorLine(lineText As String, runningTotal As Long, Optional ByVal noBookmarks As Boolean)

On Error GoTo ErrorHandler ' Skip any errors, 90% of the time they are RPG code mistake anyway
Dim SpaceLessLine As String ' Define a variable to hold the line of code
Dim moveFromStart As Long
' Set the active code text box as CurrentObject

Dim currentObject As RichTextBox
Set currentObject = activeRPGCode.codeForm

SpaceLessLine = replace(replace(lineText, " ", vbNullString), vbTab, vbNullString) _

If LeftB$(SpaceLessLine, 4) = "//" Then
    Call ColorSection(currentObject.selStart, currentObject.SelLength, 1)
    If Not noBookmarks Then addBookmark lineText
    Exit Function
End If

Select Case LeftB$(SpaceLessLine, 2)  ' Check first character of the line
Case "@"
    Call ColorSection(currentObject.selStart, currentObject.SelLength, 0)
Case "*"
    Call ColorSection(currentObject.selStart, currentObject.SelLength, 1)
Case "{", "}"
    Call ColorSection(currentObject.selStart, currentObject.SelLength, 2)

    ' Check for comments
    If InStr(1, SpaceLessLine, "*") > 0 Then
        moveFromStart = InStr(1, lineText, "*") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
    ' Check for comments
    If InStr(1, SpaceLessLine, "//") > 0 Then
        moveFromStart = InStr(1, lineText, "//") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
Case ":"
    Call ColorSection(currentObject.selStart, currentObject.SelLength, 3)
    If InStr(1, SpaceLessLine, "*") > 0 Then
        moveFromStart = InStr(1, lineText, "*") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
    ' Check for comments
    If InStr(1, SpaceLessLine, "//") > 0 Then
        moveFromStart = InStr(1, lineText, "//") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
Case Else ' It's a command

    Call ColorSection(currentObject.selStart, currentObject.SelLength, 0)   ' set the whole line to command color
    Dim SplitCommandUp() As String ' Create a blank array
    Dim insideBrackets() As String ' Create a second blank array

    If InStr(1, SpaceLessLine, "(") <> 0 Then ' Do we have a parameter bracket?
        
        ' Where does the parameter bracket start
        SplitCommandUp() = Split(lineText, "(")
        
        ' Make sure we select from right place
        moveFromStart = Len(SplitCommandUp(0)) + runningTotal
        
        ' Find all text before the closing bracket
        insideBrackets() = Split(lineText, ")")
        
        ' Take the lenght of the text before the bracket away from the lenght of the text before the closing bracket
        ' e.g. #moo( = 4  - #moo("123") = 10, so we select 6 letters, but we actually only _need_ 5, so we minus an extra
        ' one off
        ColorSection moveFromStart + 1, Len(insideBrackets(0)) - Len(SplitCommandUp(0)) - 1, 4
        
        ' Check for comments
        ' This line stops us detecting comments inside paramter brackets ()
        If InStr(InStr(1, SpaceLessLine, ")"), SpaceLessLine, "*") <> 0 Then
            
            ' Find the first location of a comment, and add it to existing lenght values
            moveFromStart = InStr(InStr(1, SpaceLessLine, ")"), lineText, "*") + runningTotal
            
            ' Color from the comment onwards.
            ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
        End If
        If InStr(InStr(1, SpaceLessLine, ")"), SpaceLessLine, "//") <> 0 Then
            
            ' Find the first location of a comment, and add it to existing lenght values
            moveFromStart = InStr(InStr(1, SpaceLessLine, ")"), lineText, "//") + runningTotal
            
            ' Color from the comment onwards.
            ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "//") + 1, 1
        End If
        
    ' Check for Variable Defenitions
    ElseIf InStr(1, SpaceLessLine, "!") <> 0 Or InStr(1, SpaceLessLine, "$") Then

        Call ColorSection(currentObject.selStart, currentObject.SelLength, 5)
        moveFromStart = InStr(1, lineText, "=") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "=") + 1, 4

    ' Check for comments
    ElseIf InStr(1, SpaceLessLine, "*") Then
        moveFromStart = InStr(1, lineText, "*") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
    ' Check for comments
    If InStr(1, SpaceLessLine, "//") Then
        moveFromStart = InStr(1, lineText, "//") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "//") + 1, 1
    End If

End Select

If Not (noBookmarks) Then Call addBookmark(lineText)

ErrorHandler:
End Function

Private Sub addBookmark(ByRef lineText As String)

    If (InStr(1, lineText, ":") <> 0) Or (InStr(1, lineText, "*") <> 0) Or (InStr(1, lineText, "//") <> 0) Or (InStr(1, LCase$(lineText), "method") <> 0) Then

        'Bookmarks...
        Dim af As rpgcodeedit
        Set af = tkMainForm.activeForm
        With af
            Select Case LCase$(GetCommandName(Trim(lineText)))
                Case "label": .addBookmark lineText, .cboLabelBookmarks
                'Case "method": .AddBookmark RemoveNumberSignIfThere(lineText), .cboMethodBookmarks
                Case "*": .addBookmark lineText, .cboCommentBookmarks
            End Select
        End With

        If LCase$(GetCommandName(Trim("#" & RemoveNumberSignIfThere(lineText)))) = "method" _
            Then af.addBookmark _
            RemoveNumberSignIfThere(lineText), af.cboMethodBookmarks

    End If

    'Remove trailing spaces...
    'CurrentObject.SelText = RTrim(CurrentObject.SelText)
    
End Sub

Function ColorSection(SectionStart As Long, SectionLen As Long, SectionColor As Long)

 On Error Resume Next

 'Access the RTF box...
 Dim currentObject As RichTextBox
 Set currentObject = activeRPGCode.codeForm ' 3.06: Use the active RPGCode form
 
 'Select the text...
 currentObject.selStart = SectionStart
 currentObject.SelLength = SectionLen
 
 'Apply the color...
 currentObject.SelColor = ColorCodes(SectionColor)
 
 'Apply the style...
 currentObject.SelBold = CVar(BoldCodes(SectionColor))
 currentObject.SelItalic = CVar(ItalicCodes(SectionColor))
 currentObject.SelUnderline = CVar(UnderlineCodes(SectionColor))
 
End Function

Public Sub GotoLine(ByVal lineText As String)

 On Error Resume Next

 'Declarations...
 Dim rtf As RichTextBox
 Dim lines() As String
 Dim count As Long
 Dim a As Long
 
 Dim currentObject As RichTextBox
 Set currentObject = activeRPGCode.codeForm

 With currentObject
 
  'Split the code up into lines...
  lines() = Split(.Text, vbCrLf)
  
  'For each line...
  For a = 0 To UBound(lines)
   'We found the line!
   If (InStr(1, lines(a), lineText)) Then
    'Move the cursor there
    .selStart = count
    .SetFocus
    Exit Sub
   Else
    'We didn't find the text...
    count = count + Len(lines(a)) + 2
   End If
  Next a
  
 End With

End Sub

Public Sub reColorLine( _
    Optional ByRef blackLine As Boolean = True, _
    Optional ByVal colorBlack As Boolean = False)

    On Error Resume Next

    With activeRPGCode.codeForm

        .Visible = False

        Dim oldSS As Long, oldSL As Long
        oldSS = .selStart
        oldSL = .SelLength

        Dim lines() As String
        lines = Split(.Text, vbCrLf)

        Dim i As Long, j As Long
        For i = 0 To UBound(lines)
            If (.selStart >= j - 2) And (.selStart <= Len(lines(i)) + j + 1) Then
                .selStart = j
                .SelLength = Len(lines(i))
                Exit For
            End If
            j = j + Len(lines(i)) + 2
        Next i

        If Not (colorBlack) Then

            If (blackLine) Then

                Call ColorLine(.SelText, .selStart)

            End If

        Else

            .SelColor = &H0&
            .SelBold = 0
            .SelItalic = 0
            .SelUnderline = 0
            Call makeLineBlack(.SelText)

        End If

        .selStart = oldSS
        .SelLength = oldSL

        .Visible = True
        Call .SetFocus

    End With

End Sub

Private Sub makeLineBlack(ByRef lineText As String)
    With activeRPGCode
        Select Case LCase$(GetCommandName(AddNumberSignIfNeeded(lineText)))
            Case "label": .removeBookmark lineText, .cboLabelBookmarks
            Case "method": .removeBookmark RemoveNumberSignIfThere(lineText), .cboMethodBookmarks
            Case "*": .removeBookmark lineText, .cboCommentBookmarks
        End Select
    End With
End Sub

Public Sub GetLineColors()

    On Error Resume Next

    Dim a As Long

    ColorCodes(0) = GetSetting("RPGToolkit3", "Colors", "#", "8388608")
    ColorCodes(1) = GetSetting("RPGToolkit3", "Colors", "*", "32768")
    ColorCodes(2) = GetSetting("RPGToolkit3", "Colors", "{}", "15490")
    ColorCodes(3) = GetSetting("RPGToolkit3", "Colors", ":", "12632064")
    ColorCodes(4) = GetSetting("RPGToolkit3", "Colors", "()", "0")
    ColorCodes(5) = GetSetting("RPGToolkit3", "Colors", "!$", "10223809")

    Dim i As Long
    For i = 0 To 5
        BoldCodes(i) = CDbl(GetSetting("RPGToolkit3", "SyntaxBold", CStr(i), 0))
        ItalicCodes(i) = CDbl(GetSetting("RPGToolkit3", "SyntaxItalics", CStr(i), 0))
        UnderlineCodes(i) = CDbl(GetSetting("RPGToolkit3", "SyntaxUnderline", CStr(i), 0))
    Next i
 
End Sub

Public Function AddNumberSignIfNeeded(ByVal txt As String) As String
 Dim build As String
 build = txt
 Select Case GetCommandName(txt)
  'Make sure it's not something that isn't suppposed to have a
  'number sign...
  Case "LABEL"
  Case "MBOX"
  Case "*"
  Case "OPENCLOCK"
  Case "CLOSEBLOCK"
  Case Else
   'It's not...
   Dim a As Long
   build = "" 'We aren't passing the same text back to empty this
   For a = 1 To Len(txt) 'For each character...
    If a = " " Or a = vbTab Then    'Check for indentation in the code,
     build = build & Mid$(txt, a, 1) 'we don't want to touch this.
    Else
     'This is where the indentation ends!
     If a = "#" Then
      'It already has a number sign.
      build = txt 'Pass back what was passed in.
      Exit For 'Exit the loop to save time.
     End If
     'Stick on the number sign... AND the rest of the text...
     build = build & "#" & Mid$(txt, a, Len(txt) - a + 1)
     'Our job here is done; exit the loop...
     Exit For
    End If
   Next a 'Onto the next character
 End Select
 'Pass back the data...
 AddNumberSignIfNeeded = build
End Function

Public Function RemoveNumberSignIfThere(ByRef txt As String) As String
    RemoveNumberSignIfThere = replace(txt, "#", vbNullString)
End Function
