Attribute VB_Name = "event"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'event generator methods

Global evtList$()   'listing of the event program
Global evtToEditNum As Integer 'num in event list to edit (-1 = not in list)
Global evtToEdit As String 'an rpgcode command to edit

Global evtCategory$     'event category
Global evtDescription$  'event desc, from file
Global evtName$         'event command name, from file
Global evtNoArgs As Integer 'number of args in the event.
Global evtArgType$(20)  'arg types for each argument
Global evtArgDesc$(20)  'arg descriptions

Sub ListCategories(file$, elist As ListBox)
    'list all the categories in events.ref
    'display the event con\mmands stored in the file event.ref
    'file$- location of event.ref
    'categpry$- category of events to show.  empty = all
    'elist- list box to display in.
    On Error Resume Next
    
    elist.Clear
    elist.AddItem ("All")
    If FileExists(file$) Then
        num = FreeFile
        Open file$ For Input As #num
            'first get the categories...
            Input #num, numCategories
            If numCategories > 0 Then
                For t = 1 To numCategories
                    Line Input #num, aCategory$
                    elist.AddItem (aCategory$)
                Next t
            End If
        Close #num
    End If
End Sub


'FIXIT: Declare 'LocateBrackets' with an early-bound data type                             FixIT90210ae-R1672-R1B8ZE
Function LocateBrackets(text$)
    'returns position of first bracket/space after the RPGCode
    'Command.
    On Error GoTo errorhandler
    
    'First look for brackets--make it easy:
    length = Len(text$)
    For p = 1 To length
        part$ = Mid$(text$, p, 1)
        If part$ = "(" Then posat = p: p = length
    Next p
    If posat <> 0 Then LocateBrackets = posat: Exit Function

    'OK- no brackets.  Find position of first space after command.
    For p = 1 To length
        part$ = Mid$(text$, p, 1)
        If part$ = "#" Then posat = p: p = length
    Next p
    If posat = 0 Then LocateBrackets = 0: Exit Function 'couldn't find a command!
    For p = posat To length     'Find first occurrence of command name
        part$ = Mid$(text$, p, 1)
        If part$ <> " " Then posat = p: p = length
    Next p
    For p = posat To length     'Find where command name ends.
        part$ = Mid$(text$, p, 1)
        If part$ = " " Then posat = p: p = length
    Next p
    LocateBrackets = posat: Exit Function

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function GetCommandName$(cline$)
'Goes through a command cline$ and returns what type of command it
'is (the prefix, without the #).
'It returns MBOX for message box, LABEL for label and VAR for variable!
'Returns OPENBLOCK for block opening, CLOSEBLOCK for block closing
    On Error GoTo errorhandler
splice$ = cline$
If splice$ = "" Then GetCommandName$ = "": Exit Function
length = Len(splice$)
'Look for #
foundit = 0
For p = 1 To length
    part$ = Mid$(splice$, p, 1)
    If part$ <> " " And part$ <> "#" And part$ <> Chr$(9) Then foundit = 0: p = length
    If part$ = "#" Then foundit = p: p = length
Next p
If foundit = 0 Then
    'Yipes- didn't find a #.  Maybe it's a @ command
    For p = 1 To length
        part$ = Mid$(splice$, p, 1)
        If part$ <> " " And part$ <> "@" And part$ <> Chr$(9) Then foundit = 0: p = length
        If part$ = "@" Then GetCommandName$ = "@": Exit Function
    Next p
    If foundit = 0 Then
        'Oh oh- still can't find it!  Probably a message
        'maybe a comment?
        For p = 1 To length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> "*" And part$ <> Chr$(9) Then foundit = 0: p = length
            If part$ = "*" Then GetCommandName$ = "*": Exit Function
        Next p
    End If
    If foundit = 0 Then
        'Maybe a label
        For p = 1 To length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> ":" And part$ <> Chr$(9) Then foundit = 0: p = length
            If part$ = ":" Then GetCommandName$ = "LABEL": Exit Function
        Next p
    End If
    If foundit = 0 Then
        'Maybe an if then start/stop
        For p = 1 To length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> "<" And part$ <> "{" And part$ <> Chr$(9) Then foundit = 0: p = length
            If part$ = "<" Or part$ = "{" Then GetCommandName$ = "OPENBLOCK": Exit Function
        Next p
    End If
    If foundit = 0 Then
        'Maybe an if then start/stop
        For p = 1 To length
            part$ = Mid$(splice$, p, 1)
            If part$ <> " " And part$ <> ">" And part$ <> "}" And part$ <> Chr$(9) Then foundit = 0: p = length
            If part$ = ">" Or part$ = "}" Then GetCommandName$ = "CLOSEBLOCK": Exit Function
        Next p
    End If
    If foundit = 0 Then
        'if after all of this stuff we didn't find anything
        'it's a message
        GetCommandName$ = "MBOX"
        Exit Function
    End If
End If
'OK, if I'm here, that means that it is a # command
starting = foundit
For p = starting + 1 To length
    part$ = Mid$(splice$, p, 1)
    If part$ <> " " Then starting = p: p = length
Next p

commandName$ = ""
'now find command
For p = starting To length
    part$ = Mid$(splice$, p, 1)
    If part$ = " " Or part$ = "(" Or part$ = "=" Then p = length: part$ = ""
    commandName$ = commandName$ + part$
Next p
'Now, before sending this back, let's see if it's a varibale
testit$ = commandName$
length = Len(testit$)
For p = 1 To length
    part$ = Mid$(testit$, p, 1)
    If part$ = "!" Or part$ = "$" Then commandName$ = "VAR"
Next p
GetCommandName$ = commandName$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'GetBrackets' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Function GetBrackets(text$)
    'Takes a command and gets all the data that occurs after
    'The command itself (what's in the brackets).
    On Error GoTo errorhandler
    use$ = text$
    location = LocateBrackets(use$)
    length = Len(text$)
    For p = location + 1 To length
        part$ = Mid$(text$, p, 1)
        If part$ = ")" Or part$ = "" Then
            p = length
        Else
            fulluse$ = fulluse$ + part$
        End If
    Next p
GetBrackets = fulluse$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

'FIXIT: Declare 'CountData' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Function CountData(text$)
    'Counts data elements in text
    'Elements are seperated by ,'s or ;'s
    On Error GoTo errorhandler
    length = Len(text$)
    ele = 1
    For p = 1 To length
        part$ = Mid$(text$, p, 1)
        If part$ = Chr$(34) Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
        End If
        If part$ = "," Or part$ = ";" Then
            If ignore = 0 Then ele = ele + 1
        End If
    Next p
    CountData = ele

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function GetDescription(commandName$) As String
    'get the description of a command from events.ref
    On Error Resume Next
    toTest$ = "#" + UCase$(commandName$)
   
    file$ = helppath$ + ObtainCaptionFromTag(DB_EventFile, resourcePath$ + m_LangFile)
    If FileExists(file$) Then
        num = FreeFile
        Open file$ For Input As #num
            'first get the categories...
            Input #num, numCategories
            If numCategories > 0 Then
                For t = 1 To numCategories
                    Line Input #num, aCategory$
                Next t
            End If
            Input #num, numCommands 'number of commands in file.
            Input #num, dummy$
            
            For l = 1 To numCommands
                Line Input #num, evtCategory$ 'category
                Line Input #num, evtDescription$     'description
                Line Input #num, evtName$ 'corresponding command
                
                Input #num, evtNoArgs         'number of args
                If evtNoArgs > 0 Then
                    For Q = 1 To evtNoArgs
                        Line Input #num, evtArgType$(Q - 1)
                        Line Input #num, evtArgDesc$(Q - 1)
                    Next Q
                End If
                Input #num, dummy$
                
                If UCase$(evtName$) = toTest$ Then
                    'found a match!
                    GetDescription = evtDescription$
                    Close #num
                    Exit Function
                End If
            Next l
        Close #num
    End If
    
    GetDescription = ""
End Function

'FIXIT: Declare 'GetElement' and 'eleenum' with an early-bound data type                   FixIT90210ae-R1672-R1B8ZE
Function GetElement(text$, eleenum)
    'gets element number from struing
    On Error GoTo errorhandler
    length = Len(text$)
    element = 0
    For p = 1 To length + 1
        part$ = Mid$(text$, p, 1)
        If part$ = Chr$(34) Then
            'A quote
            If ignore = 0 Then
                ignore = 1
            Else
                ignore = 0
            End If
        End If
        If part$ = "," Or part$ = ";" Or part$ = "" Then
            If ignore = 0 Then
                element = element + 1
                If element = eleenum Then
                    GetElement = returnval$
                    Exit Function
                Else
                    returnval$ = ""
                End If
            Else
                returnval$ = returnval$ + part$
            End If
        Else
            returnval$ = returnval$ + part$
        End If
    Next p

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function DescribeEvent(rpgcodecommand$, ByRef didDescribe As Boolean) As String
    'accept an rpgcode command.
    'try to determine a description of the event from events.ref
    'return the description.
    
    'will fill in info for the event
    On Error GoTo errorhandler
    
    commandName$ = UCase$(GetCommandName(rpgcodecommand$))
    aDesc$ = GetDescription(commandName$)
    If aDesc$ <> "" Then
        didDescribe = True
        DescribeEvent = aDesc$
    Else
        didDescribe = False
        'DescribeEvent = NoIndent(rpgcodecommand$)
        DescribeEvent = rpgcodecommand$
    End If

    Exit Function
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub DisplayEventCommands(file$, category$, elist As ListBox)
    'display the event con\mmands stored in the file event.ref
    'file$- location of event.ref
    'categpry$- category of events to show.  empty = all
    'elist- list box to display in.
    On Error Resume Next
    
    elist.Clear
    If FileExists(file$) Then
        num = FreeFile
        Open file$ For Input As #num
            'first get the categories...
            Input #num, numCategories
            If numCategories > 0 Then
                For t = 1 To numCategories
                    Line Input #num, aCategory$
                Next t
            End If
            Input #num, numCommands 'number of commands in file.
            Input #num, dummy$
            
            For l = 1 To numCommands
                Line Input #num, aCategory$ 'category
                Line Input #num, aDesc$     'description
                Line Input #num, aCommand$ 'corresponding command
                Input #num, numArgs         'number of args
                If numArgs > 0 Then
                    For Q = 1 To numArgs
                        Line Input #num, argType$
                        Line Input #num, argDesc$
                    Next Q
                End If
                Input #num, dummy$
                If category$ = "" Or UCase$(category$) = UCase$(aCategory$) Then
                    elist.AddItem (aDesc$)
                End If
            Next l
        Close #num
    End If
End Sub


Function NoIndent(cline$) As String
    'remove indentation from text
    On Error GoTo errorhandler
    splice$ = cline$
    If splice$ = "" Then NoIndent$ = "": Exit Function
    length = Len(splice$)
    
    toRet$ = ""
    'Look for #
    For p = 1 To length
        part$ = Mid$(splice$, p, 1)
        If part$ <> " " And part$ <> Chr$(9) Then
            foundit = p
            Exit For
        End If
    Next p
    
    For t = foundit To length
        toRet$ = toRet$ + Mid$(splice$, t, 1)
    Next t
    
    NoIndent = toRet$
    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub OpenEventList(file$, eventlist As ListBox)
    'fill the event list with the events as indicated in the
    'misc\event.evt file
    'this file doesn't actually do anything except tell us which rpgcode programs
    'have been generated for each event
    
    On Error Resume Next
    
    Call eventlist.Clear
    
    num = FreeFile
    If FileExists(file$) Then
        Open file$ For Input As #num
            t = 0
            Do While Not EOF(num)
                'get each event...
                Line Input #num, evtDescription$    'description
                Input #num, evtBoard$               'board event is on
                Input #num, evtx                    'board x
                Input #num, evty                    'board y
                Input #num, evtl                    'board layer
                Input #num, evtfile$                'corresponding rpgcode file
                
                'now put the event info into the list...
                text$ = "Event " + toString(t) + ": " + evtDescription$ + " (" + evtfile$ + " (" + evtBoard$ + " " + toString(evtx) + ", " + toString(evty) + ", " + toString(evtl) + "))"
                eventlist.AddItem (text$)
                t = t + 1
            Loop
        Close #num
    End If
End Sub
