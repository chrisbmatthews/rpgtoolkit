Attribute VB_Name = "transRoutines"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public Sub openMainFile(ByVal file As String)
    'opens mainForm file
    On Error Resume Next

    projectPath = ""
    mainMem.mainResolution = 0

    Call openMain(file, mainMem)
    Call ChangeLanguage(resourcePath & m_LangFile)
    
    'set gfx mode...
    If resX = 0 Then
        resX = (screenWidth) / screen.TwipsPerPixelX
        resY = screenHeight / screen.TwipsPerPixelY
    End If

End Sub

Function toString(ByVal val As String) As String
    On Error Resume Next
    toString = str(val)
    toString = removeChar(toString, " ")
End Function

Public Function BooleanToLong(ByVal bol As Boolean) As Long
    If bol = True Then BooleanToLong = 1
    If bol = False Then BooleanToLong = 0
End Function

Public Function multiSplit(ByVal txt As String, ByRef chars() As String, ByRef _
 usedDelimiters() As String, Optional ByVal ignoreQuotes As Boolean) As String()

 On Error Resume Next

 'Declarations...
 Dim ignore As Boolean
 Dim ret() As String
 Dim ud() As String
 Dim a As Long
 Dim b As Long
 Dim c As String
 
 'Make one space in the arrays...
 ReDim ret(0)
 ReDim ud(0)
 
 'For each character in the string...
 For a = 1 To Len(txt)
  c = Mid(txt, a, 1) 'Get the charater
  ret(UBound(ret)) = ret(UBound(ret)) & c
  
  If c = """" Then
   If ignoreQuotes Then
    If Not ignore Then
     ignore = True
    Else
     ignore = False
    End If
   End If
  End If
  
  If Not ignore Then
   'For each delimiter...
   For b = 0 To UBound(chars)
    'It's a delimiter...
    If c = chars(b) Then
     'Take it off the ret() array...
     ret(UBound(ret)) = Left(ret(UBound(ret)), _
      Len(ret(UBound(ret))) - 1)
     'Put it in the ud() array...
     ud(UBound(ret)) = c
     'Enlarge the ret() array
     ReDim Preserve ret(UBound(ret) + 1)
     'Enlarge the ud() array...
     ReDim Preserve ud(UBound(ud) + 1)
    End If
   Next b
  End If

 Next a 'Onto the next character
 
 'Make sure the last array element isn't empty...
 If ret(UBound(ret)) = "" Then ReDim Preserve ret(UBound(ret) - 1)
 
 'Pass back the data...
 multiSplit = ret()
 usedDelimiters = ud()

End Function
