Attribute VB_Name = "Routines"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'''''''''''''''''''''''''''
'   Modified by KSNiloc   '
'''''''''''''''''''''''''''
'[5/26/04]

'''''''
'Notes'
'''''''
'Corrected FixIT90210ae-R383-H1984 (using Option Explicit)

Option Explicit

Function FindFile(file$) As String
'searches for a filename if it exists.
'It first checks the actual path, then the root, then archives, etc
    On Error GoTo errorhandler

    '! MODIFIED BY KSNiloc...
    FindFile = file
    
    'Dim pth As String
    'Dim fName As String
    'Dim bb As String
    'Dim cc As String
    'Dim nowuse As String
    'Dim isthere1 As Byte
    'Dim isthere2 As Byte
    'Dim isthere3 As Byte
    'Dim isthere4 As Byte
    
    'pth$ = GetPath(file$)
    'fName$ = RemovePath(file$)
    'bb$ = fName$
    'If FileExists(file$) Then isthere1 = 1
    'If isthere1 = 1 Then FindFile = file$: Exit Function 'check actual filename
    
    'fName$ = bb$
    'If FileExists(fName$) Then isthere2 = 1
    'fName$ = bb$

    'OK, we've looked pretty well EVERYWHERE.  let's see:
    'fName$ = bb$
    'nowuse$ = cc$
    'If isthere1 = 1 Then FindFile = file$: Exit Function 'check actual filename
    'If isthere2 = 1 Then FindFile = fName$: Exit Function  'check just filename
    'If isthere3 = 1 Then FindFile = nowuse$: Exit Function 'without archive
    'If isthere4 = 1 Then FindFile = pth$ + nowuse$: Exit Function 'with archive
    'FindFile = file$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub openMainFile(file$)
'opens mainForm file
On Error Resume Next

    Dim a As Byte

    projectPath$ = ""
    mainMem.mainResolution = 0
           
    a = openMain(file, mainMem)
    Call ChangeLanguage(resourcePath$ + m_LangFile)
    If mainMem.mainDisableProtectReg = 1 Then
        nocodeYN = False
    End If
    
    'set gfx mode...
    If resX = 0 Then
        resX = (screenWidth) / screen.TwipsPerPixelX
        resY = screenHeight / screen.TwipsPerPixelY
    End If
Exit Sub
End Sub

Function replaceChar(ByVal text$, ByVal src$, ByVal dest$) As String
    'Replace occurences of src$ with dest$
    On Error GoTo errorhandler
    
    Dim Length As Long
    Dim t As Long
    Dim part As String
    Dim ret As String
    
    Length = Len(text$)
    For t = 1 To Length
        part$ = Mid$(text$, t, 1)
        If part$ = src$ Then part$ = dest$
        ret$ = ret$ + part$
    Next t
    replaceChar = ret$

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function toString(ByVal val As Variant) As String
    On Error Resume Next
    toString = str$(val)
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

