Attribute VB_Name = "CommonTextBox"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'text box routines
Option Explicit

Public Type TextLineInfo
    lineNumber As Long  'the line number the line is at (starting from 0)
    insertPosition As Long  'the insert position from the start of the line (starting at 0)
    textLine As String  'the actual text on this line
End Type

Function countTextLines(ByVal text As String) As Integer
    'count the lines of rpgcode we get from an rpgcode box
    On Error Resume Next
    Dim count As Integer
    Dim part As String
    Dim t As Long
    
    For t = 1 To Len(text)
        part = Mid$(text, t, 2)
        If part = Chr$(13) + Chr$(10) Or part = "" Then
            count = count + 1
        End If
    Next t
    countTextLines = count
End Function


Function getTextLineNumber(ByVal text As String, ByVal num As Integer) As String
    'given a stream of text from a text box, this function
    'returns the num-th line of text as a string.
    'num starts at zero
    On Error Resume Next
    Dim count As Long
    Dim theLine As String
    Dim part As String
    Dim t As Long
    
    count = -1
    For t = 1 To Len(text)
        part = Mid$(text, t, 2)
        If part = Chr$(13) + Chr$(10) Or part$ = "" Then
            count = count + 1
            If count = num Then
                'we have it!
                getTextLineNumber = theLine
                Exit Function
            Else
                theLine = ""
            End If
        Else
            If Mid$(part, 1, 1) <> Chr$(10) Then
                theLine = theLine + Mid$(part, 1, 1)
            End If
        End If
    Next t
End Function


Function getTextLineNumbers(ByVal text As String, ByRef returnArray() As String) As Long
    'given a stream of text from a text box, this function
    'obtains all lines form the text box, and returns them in an array
    'this function returns the size of the array
    On Error Resume Next
    Dim count As Long
    Dim theLine As String
    Dim part As String
    Dim t As Long
    
    Dim arrayPos As Long
    
    arrayPos = 0
    count = -1
    For t = 1 To Len(text)
        part = Mid$(text, t, 2)
        If part = Chr$(13) + Chr$(10) Or part$ = "" Then
            count = count + 1
            returnArray(arrayPos) = theLine
            arrayPos = arrayPos + 1
            If arrayPos >= UBound(returnArray) Then
                Dim theTop As Long
                theTop = UBound(returnArray) * 2
                ReDim Preserve returnArray(theTop)
            End If
            theLine = ""
        Else
            If Mid$(part, 1, 1) <> Chr$(10) Then
                theLine = theLine + Mid$(part, 1, 1)
            End If
        End If
    Next t
End Function



Function getTextLineInfo(ByVal text As String, ByVal selStart As Long) As TextLineInfo
    'given a stream of text from a text box, this function
    'returns the line info the selection is at.
    'the line number starts at zero
    'selStart is the textbox.SelStart property (the position where the insertion line is)
    
    On Error Resume Next
    Dim count As Long
    Dim part As String
    Dim t As Long
    
    Dim selPos As Long
    Dim linePos As Long
    Dim textLine As String
    Dim toRet As TextLineInfo
    
    selPos = 0
    linePos = 0
    textLine = ""
    
    count = 0
    For t = 1 To Len(text)
        If selPos = selStart Then
            toRet.lineNumber = count
            toRet.insertPosition = linePos
            toRet.textLine = textLine
            Exit For
        End If
        part = Mid$(text, t, 2)
               
        If part = Chr$(13) + Chr$(10) Or part$ = "" Then
            count = count + 1
            linePos = 0
            textLine = ""
            t = t + 1
            selPos = selPos + 2
        Else
            If part$ <> "" Then
                textLine = textLine + Mid$(part, 1, 1)
            End If
            selPos = selPos + 1
            linePos = linePos + 1
        End If
    Next t
    getTextLineInfo = toRet
End Function


