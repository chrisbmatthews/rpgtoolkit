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

Public ColorCodes(5) As Double
Public BoldCodes(5) As Double
Public ItalicCodes(5) As Double
Public UnderlineCodes(5) As Double
Public ActiveModule As String

Private Property Get CurrentObject() As RichTextBox
    Set CurrentObject = tkMainForm.activeForm.codeForm
End Property

Public Function SplitLines(Optional ByVal min As Long = -1, Optional ByVal max As Long = -1)
ActiveModule = "SplitLines()"
' Synatx Coloring
Dim linesArray() As String
Dim runningTotal As Double
Dim StartTime As Double
Dim StopTime As Double
Dim TimeToColor As Double
Dim X As Long

'Added by KSNiloc...
GetLineColors

CurrentObject.tag = "1"

'Clear bookmarks...
tkMainForm.activeForm.cboMethodBookmarks.Clear
tkMainForm.activeForm.cboCommentBookmarks.Clear
tkMainForm.activeForm.cboLabelBookmarks.Clear

CurrentObject.Visible = False
CurrentObject.Text = CapitalizeRPGCode(CurrentObject.Text)
linesArray() = Split(CurrentObject.Text, vbNewLine)
runningTotal = 0

'StartTime = GetTickCount
For X = 0 To UBound(linesArray())
    'If UBound(linesArray()) > 0 Then frmMain.StatusBar1.Panels(1).text = "Coloring " & Int((x / UBound(linesArray())) * 100) & "%"

    CurrentObject.selStart = runningTotal
    CurrentObject.SelLength = Len(linesArray(X))

    If (X >= min And X <= max) Or (min = -1 And max = -1) Then

        With CurrentObject
            .SelFontName = "Courier New"
            .SelFontSize = 10
        End With

        If min = -1 Then
            ColorLine linesArray(X), runningTotal
        Else
            ColorLine linesArray(X), runningTotal, True
        End If
        
    End If

    If Not min - 1 Then addBookmark linesArray(X)

    runningTotal = runningTotal + Len(linesArray(X)) + 2
     
Next X

'StopTime = GetTickCount
If min = -1 Then CurrentObject.selStart = 1
CurrentObject.Visible = True
'TimeToColor = Round((StopTime - StartTime) / 1000, 2)
'frmMain.StatusBar1.Panels(1).text = "Loaded " & (UBound(linesArray()) - 1) & " liines in " & TimeToColor & " seconds"
End Function

Function ColorLine(lineText As String, runningTotal As Double, Optional ByVal noBookmarks As Boolean)
ActiveModule = "ColorLine()"
On Error GoTo ErrorHandler ' Skip any errors, 90% of the time they are RPG code mistake anyway
Dim SpaceLessLine As String ' Define a variable to hold the line of code
Dim moveFromStart As Long
' Set the active code text box as CurrentObject

SpaceLessLine = LTrim( _
 Replace(Replace(lineText, " ", ""), vbTab, "") _
 ) ': CurrentObject.SelText = RTrim(CurrentObject.SelText) ' Remove spaces, tabs and line feed from the line of code

If Mid(SpaceLessLine, 1, 2) = "//" Then
    ColorSelection CurrentObject, 1
    If Not noBookmarks Then addBookmark lineText
    Exit Function
End If

Select Case Mid(SpaceLessLine, 1, 1) ' Check first character of the line
Case "@"
    ColorSelection CurrentObject, 0
Case "*"
    ColorSelection CurrentObject, 1
Case "{", "}"
    ColorSelection CurrentObject, 2

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
    ColorSelection CurrentObject, 3
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

    ColorSelection CurrentObject, 0 ' set the whole line to command color
    Dim SplitCommandUp() As String ' Create a blank array
    Dim insideBrackets() As String ' Create a second blank array

    If InStr(1, SpaceLessLine, "(") > 0 Then ' Do we have a parameter bracket?
        
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
        If InStr(InStr(1, SpaceLessLine, ")"), SpaceLessLine, "*") > 0 Then
            
            ' Find the first location of a comment, and add it to existing lenght values
            moveFromStart = InStr(InStr(1, SpaceLessLine, ")"), lineText, "*") + runningTotal
            
            ' Color from the comment onwards.
            ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
        End If
        If InStr(InStr(1, SpaceLessLine, ")"), SpaceLessLine, "//") > 0 Then
            
            ' Find the first location of a comment, and add it to existing lenght values
            moveFromStart = InStr(InStr(1, SpaceLessLine, ")"), lineText, "//") + runningTotal
            
            ' Color from the comment onwards.
            ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "//") + 1, 1
        End If
        
    ' Check for Variable Defenitions
    ElseIf InStr(1, SpaceLessLine, "!") > 0 Or InStr(1, SpaceLessLine, "$") Then
               
        ColorSelection CurrentObject, 5
        moveFromStart = InStr(1, lineText, "=") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "=") + 1, 4
    
    ' Check for comments
    ElseIf InStr(1, SpaceLessLine, "*") > 0 Then
        moveFromStart = InStr(1, lineText, "*") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If
    ' Check for comments
    If InStr(1, SpaceLessLine, "//") > 0 Then
        moveFromStart = InStr(1, lineText, "//") + runningTotal
        ColorSection moveFromStart - 1, Len(lineText) - InStr(1, lineText, "*") + 1, 1
    End If

End Select

If Not noBookmarks Then addBookmark lineText

ErrorHandler:
End Function

Private Sub addBookmark(ByVal lineText As String)

    'Bookmarks...
    Dim af As rpgcodeedit
    Set af = tkMainForm.activeForm
    With af
        Select Case LCase(GetCommandName(Trim(lineText)))
            Case "label": .addBookmark lineText, .cboLabelBookmarks
            'Case "method": .AddBookmark RemoveNumberSignIfThere(lineText), .cboMethodBookmarks
            Case "*": .addBookmark lineText, .cboCommentBookmarks
        End Select
    End With

    If LCase(GetCommandName(Trim("#" & RemoveNumberSignIfThere(lineText)))) = "method" _
        Then af.addBookmark _
        RemoveNumberSignIfThere(lineText), af.cboMethodBookmarks

    'Remove trailing spaces...
    'CurrentObject.SelText = RTrim(CurrentObject.SelText)
    
End Sub

Public Sub ColorSelection(ByRef rtf As RichTextBox, ByVal numtp As _
 Double): ColorSection rtf.selStart, rtf.SelLength, numtp: End Sub

Function ColorSection(SectionStart As Double, SectionLen As Double, SectionColor As Double)

 On Error Resume Next

 'Access the RTF box...
 Dim CurrentObject As RichTextBox
 Set CurrentObject = tkMainForm.activeForm.codeForm
 
 'Select the text...
 CurrentObject.selStart = SectionStart
 CurrentObject.SelLength = SectionLen
 
 'Apply the color...
 CurrentObject.SelColor = ColorCodes(SectionColor)
 
 'Apply the style...
 CurrentObject.SelBold = CVar(BoldCodes(SectionColor))
 CurrentObject.SelItalic = CVar(ItalicCodes(SectionColor))
 CurrentObject.SelUnderline = CVar(UnderlineCodes(SectionColor))
 
End Function

Public Sub GotoLine(ByVal lineText As String)

 On Error Resume Next

 'Declarations...
 Dim rtf As RichTextBox
 Dim lines() As String
 Dim count As Long
 Dim a As Long
 
 'Access the richTextBox...
 Set rtf = tkMainForm.activeForm.codeForm
 With rtf
 
  'Split the code up into lines...
  lines() = Split(.Text, vbCrLf, , vbTextCompare)
  
  'For each line...
  For a = 0 To UBound(lines)
   'We found the line!
   If (InStr(1, lines(a), lineText, vbTextCompare) > 0) Then
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

Public Sub ReColorLine(Optional ByRef blackLine As Boolean = -2, _
 Optional ByVal colorBlack As Boolean = False)

 ''''''''''''''''''''''''''
 '    Added by KSNiloc    '
 ''''''''''''''''''''''''''
 '[6/18/04]
 
 '''''''''
 'Purpose'
 '''''''''
 'Colors the current line
 
 '''''''
 'Notes'
 '''''''
 'The code here's a bit messy- it's written in a way so it
 'runs as fast as it can.

 On Error Resume Next
 
 'Declare variables...
 'Dim enterKey As String
 Dim lines() As String
 Dim cf As rpgcodeedit
 Dim oldSS As Long
 Dim oldSL As Long
 Dim done As Boolean
 Dim tempSS As Long
 Dim tempSL As Long
 Dim a As Long
 Dim b As Long
 
 'Access the RTF box...
 Set cf = tkMainForm.activeForm
 With CurrentObject 'cf.codeform
 
  .Visible = False
 
  'enterKey = vbCrLf
  'Find the start of the line...
  'For a = (.selStart - 1) To 1 Step -1
  ' If Mid(.text, a + 1, 1) = Mid(enterKey, 2, 1) Then Exit For
  'Next a
  'Find the end of the line...
  'b = InStr(.selStart, .text & vbCrLf, enterKey, vbTextCompare)
 
  'Remember what is selected now...
  oldSS = .selStart
  oldSL = .SelLength
  
  'Break the code up into lines...
  lines() = Split(.Text, vbCrLf, , vbTextCompare)

  'This part may seem very convoluted, that's because it is (heh...)
  For a = 0 To UBound(lines) 'For each line...
   'If the cursor is located on this line...
   If (.selStart >= b - 2) And (.selStart <= Len(lines(a)) + b + 1) Then
   'If .GetLineFromChar(.selStart) = a Then
    'Select this *whole* line!
    .selStart = b
    .SelLength = Len(lines(a))
    'Save time by leaving the loop...
    Exit For
   End If
   'We didn't find the loop so increase the running total by the
   'length of the line we left plus two for the line break...
   b = b + Len(lines(a)) + 2
   'If we've tried every line and still haven't found anything then
   'just color the first line as it's sometimes missed...
   If a = UBound(lines) Then b = 1
  Next a
  
  tempSS = .selStart
  tempSL = .SelLength
  .SelText = CapitalizeRPGCode(.SelText)
  .selStart = tempSS
  .SelLength = tempSL
  
  If Not blackLine = -2 Then
   'We're going to change the boolean passed in...

   'If the line's only got one charater MAKE SURE it's colored...
   If Len(Trim( _
   Replace(Replace(Replace(.SelText, " ", ""), vbTab, ""), vbCrLf, "") _
   )) = 1 Then blackLine = True
  
   If Not colorBlack Then
    'If the line is black...
    If blackLine Then
     'Color it...
     ColorLine .SelText, .selStart
    End If
   Else
   
    'Make this line black...
    .SelColor = &H0&
    'And remove its possible bookmark...
    makeLineBlack .SelText
    'Flag that this line's black...
    blackLine = True
   End If
  Else
  
   'The boolean's not our problem; don't worry about it...
   If colorBlack Then
    'We're to color this line black!
    .SelColor = &H0& 'Do it!
    makeLineBlack .SelText '...and remove its bookmark.
   Else
   
    'We're supposed to give this line some color...
    ColorLine .SelText, .selStart '...make it happen!
   End If
  End If

  If Not colorBlack Then
   'Properly capitalize that command!
    '.SelText = CapitalizeRPGCode(.SelText)
   'See if the user's using an old, bad habit...
   cf.checkBadHabits .SelText
  End If

  'Select whatever was selected before...
  .selStart = oldSS
  .SelLength = oldSL

  .Visible = True
  .SetFocus
  
 End With
 
End Sub

Private Sub makeLineBlack(ByVal lineText As String)
 'Take away its bookmark (if there is one...)
 Dim af As rpgcodeedit
 Set af = tkMainForm.activeForm
 With af
  Select Case LCase(GetCommandName(AddNumberSignIfNeeded(lineText)))
   Case "label": .removeBookmark lineText, .cboLabelBookmarks
   Case "method": .removeBookmark RemoveNumberSignIfThere(lineText), .cboMethodBookmarks
   Case "*": .removeBookmark lineText, .cboCommentBookmarks
  End Select
 End With
End Sub

Public Sub GetLineColors()

 On Error Resume Next

 'Declarations...
 Dim a As Long

 'Retrieve colors to use from the registry...
 ColorCodes(0) = CDbl(GetSetting("RPGToolkit3", "Colors", "#", "8388608"))
 ColorCodes(1) = CDbl(GetSetting("RPGToolkit3", "Colors", "*", "32768"))
 ColorCodes(2) = CDbl(GetSetting("RPGToolkit3", "Colors", "{}", "15490"))
 ColorCodes(3) = CDbl(GetSetting("RPGToolkit3", "Colors", ":", "12632064"))
 ColorCodes(4) = CDbl(GetSetting("RPGToolkit3", "Colors", "()", "0"))
 ColorCodes(5) = CDbl(GetSetting("RPGToolkit3", "Colors", "!$", "10223809"))
 
 'Retrieve styles to use from the registry...
 For a = 0 To 5
  BoldCodes(a) = CDbl(GetSetting("RPGToolkit3", _
   "SyntaxBold", CStr(a), 0))
  ItalicCodes(a) = CDbl(GetSetting("RPGToolkit3", _
   "SyntaxItalics", CStr(a), 0))
  UnderlineCodes(a) = CDbl(GetSetting("RPGToolkit3", _
   "SyntaxUnderline", CStr(a), 0))
 Next a
 
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
     build = build & Mid(txt, a, 1) 'we don't want to touch this.
    Else
     'This is where the indentation ends!
     If a = "#" Then
      'It already has a number sign.
      build = txt 'Pass back what was passed in.
      Exit For 'Exit the loop to save time.
     End If
     'Stick on the number sign... AND the rest of the text...
     build = build & "#" & Mid(txt, a, Len(txt) - a + 1)
     'Our job here is done; exit the loop...
     Exit For
    End If
   Next a 'Onto the next character
 End Select
 'Pass back the data...
 AddNumberSignIfNeeded = build
End Function

Public Function RemoveNumberSignIfThere(ByVal txt As String) As String
 txt = Replace(txt, "#", "")
 RemoveNumberSignIfThere = txt
End Function
