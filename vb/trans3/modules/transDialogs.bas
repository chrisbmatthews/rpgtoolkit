Attribute VB_Name = "transDialogs"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Custom message box module.
'Replaces MsgBox function
'also contains defintiions for cursor-map SelectionBox and cursor-map screen
'and DX file dialog

Option Explicit

'types of message boxes...
Public Const MBT_OK = 0
Public Const MBT_YESNO = 1

Public Const MBR_OK = 1
Public Const MBR_YES = 6
Public Const MBR_NO = 7


Type CURSOR_MAP
    x As Long   'x coord of target
    y As Long   'y coord of target
    'if any of the links are -1, then it is determined by the system.
    leftLink As Long    'where do you go when you hit left?
    rightLink As Long   'where do you go when you hit right?
    upLink As Long      'where do you go when you hit up?
    downLink As Long    'where do you go when you hit down?
End Type

Type CURSOR_MAP_TABLE
    list() As CURSOR_MAP
    length As Long  'actual number of entries in cursor map tbale
End Type

'list of cursor map tables
Public cursorMapTables() As CURSOR_MAP_TABLE
Private cursorMapTablesOccupied() As Boolean    'are those array positions occupied?
Private cursorMapTablesSize As Long 'number of entires in that list

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Function ShowPromptDialog(ByVal title As String, ByVal text As String, Optional ByVal initialValue As String = "") As String
    'text prompt dialog.
    'title - title string of dialog
    'text - question in dialog
    'initialvalue - initial value in text box
    'return user input
    On Error Resume Next
    
    Call haltKeyDownScanning
    
    'save screen...
    Call CanvasGetScreen(cnvAllPurpose)
    
    Dim offsetX As Long
    Dim offsetY As Long
    
    Dim cnv As Long
    cnv = CreateCanvas(400, 90)
    
    Dim cnvTextBox As Long
    cnvTextBox = CreateCanvas(380, 20)
    Dim textBoxContents As String
    
    textBoxContents = initialValue
    
    Dim textSize As Long
    textSize = 20
    
    offsetX = (GetCanvasWidth(cnvAllPurpose) - GetCanvasWidth(cnv)) / 2
    offsetY = (GetCanvasHeight(cnvAllPurpose) - GetCanvasHeight(cnv)) / 2
    
    Dim done As Boolean
    done = False
    Call cursorDelay
    Do While Not (done)
        Dim idx As Long
        Dim cnt As Long
        cnt = 1
        
        'fill the text box...
        Call CanvasFill(cnvTextBox, RGB(255, 255, 255))
        Call CanvasDrawText(cnvTextBox, textBoxContents + "|", "Arial", textSize, 1, 1, 0, False, False, False, False)
        
        
        'list is filled...  finish constructing the dialog...
        Call CanvasFill(cnv, 0)
        Call CanvasDrawText(cnv, title, "Arial", textSize, 1, 1, RGB(255, 255, 255))
        Call CanvasDrawText(cnv, text, "Arial", textSize, 1, 2, RGB(255, 255, 255))
        Call Canvas2CanvasBlt(cnvTextBox, cnv, 10, 50)
            
        Call DXDrawCanvas(cnvAllPurpose, 0, 0)
        Call DXDrawCanvas(cnv, offsetX, offsetY)
        
        Call DXRefresh
        
        'first check the joystick...
        Dim keyb As String
        keyb = getAsciiKey()
        If keyb <> "" Then
            If Asc(LCase$(keyb)) >= 32 Then
                textBoxContents = textBoxContents + LCase$(keyb)
            End If
            If Asc(keyb) = 8 Then
                If textBoxContents <> "" Then
                    textBoxContents = Mid$(textBoxContents, 1, Len(textBoxContents) - 1)
                End If
            End If
        End If
        If isPressed("BUTTON1") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            ShowPromptDialog = textBoxContents
            done = True
        End If
        If isPressed("ENTER") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            ShowPromptDialog = textBoxContents
            done = True
        End If
        If isPressed("ESC") Or isPressed("BUTTON2") Then
            'cancel
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorCancelSound)
            ShowPromptDialog = ""
            done = True
        End If
    Loop
    
    Call DestroyCanvas(cnvTextBox)
    Call DestroyCanvas(cnv)
    Call FlushKB
    Call startKeyDownScanning
End Function




Function CreateCursorMapTable() As Long
    'create a cursor map table
    'return an index into the cursorMapTables array
    On Error GoTo toosmall

    If cursorMapTablesSize = 0 Then
        ReDim cursorMapTables(10)
        ReDim cursorMapTablesOccupied(10)
    End If

    'find empty slot...
    Dim t As Long
    For t = 0 To UBound(cursorMapTables)
        If Not (cursorMapTablesOccupied(t)) Then
            cursorMapTablesOccupied(t) = True
            CreateCursorMapTable = t
            cursorMapTablesSize = cursorMapTablesSize + 1
            Exit Function
        End If
    Next t

toosmall:
    'check size of container...
    Dim sz As Long
    If cursorMapTablesSize + 1 > UBound(cursorMapTables) Then
        sz = UBound(cursorMapTables) * 2 + 2
        ReDim Preserve cursorMapTables(sz)
        ReDim Preserve cursorMapTablesOccupied(sz)
    End If
    
    'add...
    cursorMapTablesOccupied(cursorMapTablesSize) = True
    CreateCursorMapTable = cursorMapTablesSize
    cursorMapTablesSize = cursorMapTablesSize + 1
End Function


Sub DeleteCursorMapTable(ByVal idx As Long)
    On Error Resume Next
    cursorMapTablesOccupied(idx) = False
    Call CursorMapClear(cursorMapTables(idx))
End Sub


Function ShowFileDialog(ByVal path As String, ByVal ext As String) As String
    'open file dialog.
    'path - path of starting dialog (including trailing \)
    'ext - default entension (eg, *.*)
    'return selected file, or "" if cancelled
    On Error Resume Next
    
    Call haltKeyDownScanning
    
    'save screen...
    Call CanvasGetScreen(cnvAllPurpose)
    
    Dim offsetX As Long
    Dim offsetY As Long
    
    ReDim Files(10) As String
    Dim count As Long
    count = 0
    'obtain files...
    Dim a As String
    a = Dir(path + ext)
    Do While a <> ""
        Files(count) = a
        count = count + 1
        If count > UBound(Files) Then
            Dim sz As Long
            sz = UBound(Files) * 2
            ReDim Preserve Files(sz)
        End If
        a = Dir
    Loop
    
    'now we have the file list in files, and the count in count
    Dim cnv As Long
    cnv = CreateCanvas(400, 270)
    
    Dim cnvList As Long
    cnvList = CreateCanvas(380, 200)
    
    Dim cnvTextBox As Long
    cnvTextBox = CreateCanvas(380, 20)
    Dim textBoxContents As String
    
    textBoxContents = Files(0)
    
    Dim topFile As Long
    topFile = 0
    Dim textSize As Long
    textSize = 20
    
    offsetX = (GetCanvasWidth(cnvAllPurpose) - GetCanvasWidth(cnv)) / 2
    offsetY = (GetCanvasHeight(cnvAllPurpose) - GetCanvasHeight(cnv)) / 2
    
    
    'fill the list...
    Dim filesPerPage As Long
    filesPerPage = Int(GetCanvasHeight(cnvList) / textSize)
    
    Dim cursorNum As Long
    cursorNum = 0
    
    Dim done As Boolean
    done = False
    Call cursorDelay
    Do While Not (done)
        Call CanvasFill(cnvList, RGB(255, 255, 255))
        Dim idx As Long
        Dim cnt As Long
        cnt = 1
        For idx = topFile To topFile + filesPerPage Step 1
            Call CanvasDrawText(cnvList, Files(idx), "Arial", textSize, 1.2, cnt, 0, False, False, False, False)
            If (idx + 1) >= count Then
                Exit For
            End If
            cnt = cnt + 1
        Next idx
        
        'fill the text box...
        Call CanvasFill(cnvTextBox, RGB(255, 255, 255))
        Call CanvasDrawText(cnvTextBox, textBoxContents + "|", "Arial", textSize, 1, 1, 0, False, False, False, False)
        
        
        'list is filled...  finish constructing the dialog...
        Call CanvasFill(cnv, 0)
        Call Canvas2CanvasBlt(cnvList, cnv, 10, 50)
        Call Canvas2CanvasBlt(cnvTextBox, cnv, 10, 10)
            
        Call DXDrawCanvas(cnvAllPurpose, 0, 0)
        Call DXDrawCanvas(cnv, offsetX, offsetY)
        
        Dim x As Long
        Dim y As Long
        x = offsetX + textSize * 0.2 + 10
        y = ((cursorNum + 1) * textSize - (textSize / 2)) + offsetY + 50
        
        Call CBDrawHand(x, y)
        Call DXRefresh
        
        'first check the joystick...
        Dim keyb As String
        keyb = getAsciiKey()
        If keyb <> "" Then
            If Asc(LCase$(keyb)) >= 32 Then
                textBoxContents = textBoxContents + LCase$(keyb)
            End If
            If Asc(keyb) = 8 Then
                If textBoxContents <> "" Then
                    textBoxContents = Mid$(textBoxContents, 1, Len(textBoxContents) - 1)
                End If
            End If
        End If
        
        If isPressed("UP") Then
            cursorNum = cursorNum - 1
            If cursorNum < 0 Then
                cursorNum = 0
                topFile = topFile - 1
                If topFile < 0 Then topFile = 0
            End If
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            textBoxContents = Files(cursorNum + topFile)
            Call cursorDelay
        End If
        If isPressed("DOWN") Then
            cursorNum = cursorNum + 1
            If cursorNum + topFile >= count Then
                cursorNum = cursorNum - 1
            Else
                If cursorNum >= filesPerPage - 1 Then
                    cursorNum = filesPerPage - 1
                    topFile = topFile + 1
                    If topFile + filesPerPage > count Then
                        topFile = filesPerPage
                    End If
                End If
            End If
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            textBoxContents = Files(cursorNum + topFile)
            Call cursorDelay
        End If
        If isPressed("BUTTON1") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            ShowFileDialog = Files(cursorNum + topFile)
            done = True
        End If
        If isPressed("ENTER") Then
            If textBoxContents = "" Then
                Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
                ShowFileDialog = Files(cursorNum + topFile)
                done = True
            Else
                Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
                ShowFileDialog = addext(textBoxContents, "." + GetExt(ext))
                done = True
            End If
        End If
        If isPressed("ESC") Or isPressed("BUTTON2") Then
            'cancel
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorCancelSound)
            ShowFileDialog = ""
            done = True
        End If
    Loop
    
    Call DestroyCanvas(cnvTextBox)
    Call DestroyCanvas(cnvList)
    Call DestroyCanvas(cnv)
    Call FlushKB
    Call startKeyDownScanning
End Function


Sub cursorDelay()
    '==========================
    'Some people have problems with the speed of the
    'cursor on the menus, however this delay is too great not
    'to be noticed, so this probably isn't the problem.
    '
    'Note: This only applies to cursor maps made in RPGCode!
    'The menu plugin calls its own delays (although selection boxes
    'use this too).

    Call delay(0.1)
    
End Sub


Sub CursorMapClear(ByRef ctable As CURSOR_MAP_TABLE)
    'clear the cursor map...
    On Error Resume Next
    ReDim ctable.list(10)
    ctable.length = 0
End Sub
Sub CursorMapAdd(ByRef cmap As CURSOR_MAP, ByRef ctable As CURSOR_MAP_TABLE)
    'add an entry to the cursor map...
    On Error Resume Next
    
    If ctable.length = 0 Then
        ReDim ctable.list(10)
    End If
    
    'check size of container...
    Dim sz As Long
    If ctable.length + 1 > UBound(ctable.list) Then
        sz = UBound(ctable.list) * 2
        ReDim Preserve ctable.list(sz)
    End If
    
    'add...
    ctable.list(ctable.length) = cmap
    ctable.length = ctable.length + 1
End Sub


Function CursorMapRun(ByRef ctable As CURSOR_MAP_TABLE) As Long
    '==============================
    'EDITED: [Delano - 8/05/04]
    'Added the use of the numberpad on cursor maps.
    '==============================
    'Called by CursorMapRunRPG only.
    
    'Run the cursor map.
    'Returns the index of the selected entry...
    On Error Resume Next
    
    'Save the screen into a canvas...
    Dim cnv As Long
    cnv = CreateCanvas(resX, resY)
    Call CanvasGetScreen(cnv)
        
    Dim cursorNum As Long
    cursorNum = 0
    
    Dim done As Boolean
    
    Call cursorDelay
    Do Until done
        
        'Call cursorDelay
   
        Call DXDrawCanvas(cnv, 0, 0)
        
        'draw the cursor...
        Dim x As Long
        Dim y As Long
        x = ctable.list(cursorNum).x
        y = ctable.list(cursorNum).y
        
        Call CBDrawHand(x, y)
        
        Call DXRefresh
        
        If isPressed("UP") Or isPressed("NUMPAD8") Then
            If ctable.list(cursorNum).upLink <> -1 Then
                cursorNum = ctable.list(cursorNum).upLink
            Else
                cursorNum = cursorNum - 1
            End If
            If cursorNum < 0 Then cursorNum = ctable.length - 1
            If cursorNum >= ctable.length Then cursorNum = 0
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("LEFT") Or isPressed("NUMPAD4") Then
            If ctable.list(cursorNum).leftLink <> -1 Then
                cursorNum = ctable.list(cursorNum).leftLink
            Else
                cursorNum = cursorNum - 1
            End If
            If cursorNum < 0 Then cursorNum = ctable.length - 1
            If cursorNum >= ctable.length Then cursorNum = 0
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("DOWN") Or isPressed("NUMPAD2") Then
            If ctable.list(cursorNum).downLink <> -1 Then
                cursorNum = ctable.list(cursorNum).downLink
            Else
                cursorNum = cursorNum + 1
            End If
            If cursorNum < 0 Then cursorNum = ctable.length - 1
            If cursorNum >= ctable.length Then cursorNum = 0
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("RIGHT") Or isPressed("NUMPAD6") Then
            If ctable.list(cursorNum).rightLink <> -1 Then
                cursorNum = ctable.list(cursorNum).rightLink
            Else
                cursorNum = cursorNum + 1
            End If
            If cursorNum >= ctable.length Then cursorNum = 0
            If cursorNum < 0 Then cursorNum = ctable.length - 1
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("ENTER") Or isPressed("SPACE") Or isPressed("BUTTON1") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            done = True
        End If
        If isPressed("ESC") Or isPressed("BUTTON2") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            cursorNum = -1
            done = True
        End If
        
        'KSNiloc adds...
        DoEvents
        
    Loop
    
    'restore screen...
    Call DXDrawCanvas(cnv, 0, 0)
    Call DXRefresh
    Call FlushKB
    Call DestroyCanvas(cnv)
    
    CursorMapRun = cursorNum
End Function


Function max3(ByVal x As Long, ByVal y As Long, ByVal z As Long) As Long
    'return the max of 3 vars
    On Error Resume Next
    If z >= x And z >= y Then
        max3 = z
    End If
    If y >= x And y >= z Then
        max3 = y
    End If
    If x >= z And x >= y Then
        max3 = x
    End If
End Function


Public Function MBox(ByVal text As String, Optional ByVal title As String = "", Optional ByVal mBoxType As Long = MBT_OK, Optional ByVal textColor As Long = vbWhite, Optional ByVal bgColor As Long = 0, Optional ByVal bgPic As String = "") As Integer
    'calls the mbox function (pops up an eqivalent to mwin.)
    On Error Resume Next

    Dim options() As String
    Dim res As Long
    
    Select Case mBoxType
        Case MBT_OK:
            ReDim options(1)
            options(0) = LoadStringLoc(1022, "OK")
            res = SelectionBox(text, options, textColor, bgColor, bgPic)
            MBox = MBR_OK
            Exit Function
        
        Case MBT_YESNO:
            ReDim options(2)
            options(0) = LoadStringLoc(1100, "Yes")
            options(1) = LoadStringLoc(1099, "No")
            res = SelectionBox(text, options, textColor, bgColor, bgPic)
            If res = 0 Then
                MBox = MBR_YES
            Else
                MBox = MBR_NO
            End If
            Exit Function
    End Select
End Function



Function SelectionBox(ByVal text As String, ByRef options() As String, Optional ByVal textColor As Long = vbWhite, Optional ByVal bgColor As Long = 0, Optional ByVal bgPic As String = "") As Long
    On Error Resume Next
    'display a message box.
    'text is the question
    'options are a list of options to be displayed-- selected by joystick or keyboard
    'returns index of selected option
    
    'save screen...
    Call CanvasGetScreen(cnvAllPurpose)
        
    Dim subStrings As Long
    Dim t As Long
    'seperate the string on the newline character
    subStrings = countSubStrings(text, chr$(10))
    
    ReDim textlist(subStrings) As String
    For t = 0 To subStrings - 1
        textlist(t) = getSubString(text, chr$(10), t)
    Next t
    
    Dim maxWidth As Long
    
    For t = 0 To UBound(textlist)
        If Len(textlist(t)) > maxWidth Then
            maxWidth = Len(textlist(t))
        End If
    Next t
    
    For t = 0 To UBound(options)
        If Len(options(t)) > maxWidth Then
            maxWidth = Len(options(t))
        End If
    Next t

    
    Dim textSize As Long
    textSize = 20
    
    Dim cnv As Long
    Dim Width As Long
    Width = (textSize / 1.5) * maxWidth
    If Width < 100 Then Width = 100
    
    cnv = CreateCanvas(Width, textSize * (subStrings + UBound(options) + 3))
    Call CanvasFill(cnv, bgColor)
    If bgPic <> "" Then
        Call CanvasLoadSizedPicture(cnv, bgPic)
    End If
    
    Dim oy As Long
    If subStrings > 0 Then
        For t = 0 To subStrings - 1
            Call CanvasDrawText(cnv, textlist(t), "Arial", textSize, 1.4, 2 + t, textColor, True, False, False, False)
        Next t
        oy = subStrings + 1
    End If
        
    For t = 0 To UBound(options) - 1
        Call CanvasDrawText(cnv, options(t), "Arial", textSize, 1.4, t + oy + 2, textColor, True, False, False, False)
    Next t
    
    Dim offsetX As Long
    Dim offsetY As Long
    offsetX = (GetCanvasWidth(cnvAllPurpose) - GetCanvasWidth(cnv)) / 2
    offsetY = (GetCanvasHeight(cnvAllPurpose) - GetCanvasHeight(cnv)) / 2
    'Call DXDrawCanvas(cnv, offsetX, offsetY)
    
    'Dim ctable As CURSOR_MAP_TABLE
    'Call CursorMapClear(ctable)
    'Dim cm As CURSOR_MAP
    'cm.leftLink = -1
    'cm.rightLink = -1
    'cm.upLink = -1
    'cm.downLink = -1
    
    'For t = 0 To UBound(options) - 1
    '    Dim X As Long
    '    Dim Y As Long
    '    X = offsetX + textSize * 0.2
    '    Y = (t + 2 + oy) * textSize - (textSize / 2) + offsetY
    '    cm.X = X
    '    cm.Y = Y
    '    Call CursorMapAdd(cm, ctable)
    'Next t
    
    'SelectionBox = CursorMapRun(ctable)
    
    Dim cursorNum As Long
    cursorNum = 0
    
    Dim done As Boolean
    
    
    Call cursorDelay
    
    Do While Not (done)
        Call DXDrawCanvas(cnvAllPurpose, 0, 0)
        Call DXDrawCanvas(cnv, offsetX, offsetY)
        
        'draw the cursor...
        Dim x As Long
        Dim y As Long
        x = offsetX + textSize * 0.2
        y = (cursorNum + 2 + oy) * textSize - (textSize / 2) + offsetY
        
        Call CBDrawHand(x, y)
        
        Call DXRefresh
        
        If isPressed("UP") Then
            cursorNum = cursorNum - 1
            If cursorNum < 0 Then cursorNum = UBound(options) - 1
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("DOWN") Then
            cursorNum = cursorNum + 1
            If cursorNum >= UBound(options) Then cursorNum = 0
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorMoveSound)
            Call cursorDelay
        End If
        If isPressed("ENTER") Or isPressed("SPACE") Or isPressed("BUTTON1") Then
            Call PlaySoundFX(projectPath$ + mediaPath$ + mainMem.cursorSelectSound)
            done = True
            'Call cursorDelay
        End If
    Loop
    
    SelectionBox = cursorNum
    
    
    'restore screen...
    Call DXDrawCanvas(cnvAllPurpose, 0, 0)
    Call DXRefresh
    Call FlushKB
End Function


