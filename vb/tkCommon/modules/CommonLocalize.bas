Attribute VB_Name = "CommonLocalize"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'localizer
Option Explicit

Private Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long
Private Const REG_SZ = 1
Public Const HKEY_CURRENT_USER = &H80000001

Private m_LangDB As Long    'language database
Public m_LangFile As String    'language db file
Private m_LangNoneString As String  'since the word 'none' comes up so much, we'll cache it.

Type LangEntry
    tagID As Long
    Caption As String
    toolTip As String
End Type

Type LangTable
    theTable() As LangEntry
    numEntries As Long
End Type

Private m_LangTable As LangTable

'constants of tags where things are in the db
Public Const DB_EventFile = 500
Public Const DB_QuickRefFile = 501
Public Const DB_Help1 = 502
Public Const DB_Help2 = 503
Public Const DB_Help3 = 504
Public Const DB_tipFile = 505
Public Const DB_RegInfo = 506
Public Const DB_Tutorial1 = 510
Public Const DB_Tutorial2 = 511
Public Const DB_Tutorial3 = 512
Public Const DB_Tutorial4 = 513
Public Const DB_Tutorial5 = 514
Public Const DB_Tutorial6 = 515
Public Const DB_Tutorial7 = 516
Public Const DB_Tutorial8 = 517
Public Const DB_Tutorial9 = 518
Public Const DB_Tutorial10 = 519
Public Const DB_Tutorial11 = 520
Public Const DB_Tutorial12 = 521
Public Const DB_LangName = 1000

Private Sub decimalFix()
    'Fix for decimals that occurs in some countries
    Dim hKey As Long
    Call RegOpenKey(HKEY_CURRENT_USER, "Control Panel\International\", hKey)
    Call RegSetValueEx(hKey, "sDecimal", 0, REG_SZ, ByVal ".", Len("."))
    Call RegCloseKey(hKey)
End Sub

Function LangIndexOfTag(ByVal tagID As Long, lTable As LangTable) As Long
    'find the tagID in a langtable
    'assume lag table is in sorted order by tagid
    'so we can do a binary search
    'returns -1 if not found
    Dim lower As Long, upper As Long, midval As Long, bDone As Boolean
    lower = 0
    upper = lTable.numEntries - 1
    midval = Int((upper - lower) / 2) + lower
    
    bDone = False
    Do While Not (bDone)
        If upper < lower Then
            bDone = True
        Else
            If lTable.theTable(midval).tagID = tagID Then
                'found it!
                LangIndexOfTag = midval
                Exit Function
            Else
                If lTable.theTable(midval).tagID > tagID Then
                    'lower half
                    upper = midval - 1
                    midval = Int((upper - lower) / 2) + lower
                Else
                    'upper half
                    lower = midval + 1
                    midval = Int((upper - lower) / 2) + lower
                End If
            End If
        End If
    Loop
    
    'if we made it herem, we didn't find it.
    'return -1
    LangIndexOfTag = -1
End Function


Function LoadStringLoc(ByVal tagID As Long, ByVal equivStringOptional As String) As String
    'load a string from the caption field of the db
    'return it, or return the optional equiv string (if the db cannot
    'be accessed)'
    On Error Resume Next
    Dim idx As Long
    If LenB(m_LangFile) <> 0 Then
        If tagID = 1010 Then
            'none string
            If LenB(m_LangNoneString) <> 0 Then
                LoadStringLoc = m_LangNoneString
                Exit Function
            End If
        End If
        idx = LangIndexOfTag(tagID, m_LangTable)
        If idx <> -1 Then
            LoadStringLoc = m_LangTable.theTable(idx).Caption
        Else
            LoadStringLoc = equivStringOptional
        End If
    Else
        LoadStringLoc = equivStringOptional
    End If
End Function



Function ObtainToolTipFromTag(ByVal tagID As Long, ByVal dbfile As String) As String
    'get the tooltip from a tag value...
    On Error Resume Next
    Dim lTable As LangTable
    Call OpenLanguage(dbfile, lTable)
    Dim idx As Long
    If lTable.numEntries > 0 Then
        idx = LangIndexOfTag(tagID, lTable)
        If idx <> -1 Then
            ObtainToolTipFromTag = lTable.theTable(idx).toolTip
        Else
        End If
    Else
        ObtainToolTipFromTag = vbNullString
    End If
End Function

Sub ChangeLanguage(ByVal file As String)
    'change the active language
    On Error Resume Next
    
    Dim frm As VB.Form

    'use toolkit lang files
    m_LangNoneString = vbNullString
    
    Call OpenLanguage(file, m_LangTable)
    If file <> "default" Then
        m_LangFile = RemovePath(file)
    Else
        m_LangFile = vbNullString
    End If
    If file <> "default" Then
        'ok
        'change all forms to the new language...
'FIXIT: Forms collection not upgraded to Visual Basic .NET by the Upgrade Wizard.          FixIT90210ae-R6616-H1984
        For Each frm In Forms
            Call LocalizeForm(frm)
        Next frm
    End If
End Sub


Sub InitLocalizeSystem()
    'initialize localizer
    On Error Resume Next
    Call decimalFix
    Call OpenLanguage("resources\0english.lng", m_LangTable)
    m_LangFile = "0english.lng"
End Sub


Sub LocalizeForm(frm As VB.Form)
    'localize a form that is passed in...
    On Error Resume Next
    Dim ctl As VB.Control
    
    If (LenB(m_LangFile) = 0) Then
        'didn't mount db-- leave as english text
        Exit Sub
    End If
    
    Dim idx As Long
    If IsNumeric(frm.Tag) Then
        idx = LangIndexOfTag(Int(frm.Tag), m_LangTable)
        If idx <> -1 Then
            frm.Caption = m_LangTable.theTable(idx).Caption
            If frm.Caption = " " Then frm.Caption = vbNullString
        End If
    End If
    
    For Each ctl In frm.Controls
        If IsNumeric(ctl.Tag) Then
            idx = LangIndexOfTag(Int(ctl.Tag), m_LangTable)
            If idx <> -1 Then
                ctl.Caption = m_LangTable.theTable(idx).Caption
                If ctl.Caption = " " Then ctl.Caption = vbNullString
                ctl.ToolTipText = m_LangTable.theTable(idx).toolTip
                If ctl.ToolTipText = " " Then ctl.ToolTipText = vbNullString
            End If
        End If
    Next ctl
End Sub


Function ObtainCaptionFromTag(ByVal tagID As Long, ByVal dbfile As String) As String
    'get the caption from a tag value...
    On Error Resume Next
    
    Dim lTable As LangTable, idx As Long
    Call OpenLanguage(dbfile, lTable)
    If lTable.numEntries > 0 Then
        idx = LangIndexOfTag(tagID, lTable)
        If idx <> -1 Then
            ObtainCaptionFromTag = lTable.theTable(idx).Caption
        Else
        End If
    Else
        Select Case tagID
            Case DB_EventFile:
                ObtainCaptionFromTag = "eventsEN.ref"
            Case DB_QuickRefFile:
                ObtainCaptionFromTag = "rpgcodeEN.ref"
            Case DB_Help1:
                ObtainCaptionFromTag = "help1.htm"
            Case DB_Help2:
                ObtainCaptionFromTag = "help2.htm"
            Case DB_Help3:
                ObtainCaptionFromTag = "help3.htm"
            Case DB_tipFile:
                ObtainCaptionFromTag = "tipEN.tip"
            Case DB_RegInfo:
                ObtainCaptionFromTag = "registration.htm"
            Case DB_Tutorial1:
                ObtainCaptionFromTag = "tut1.txt"
            Case DB_Tutorial2:
                ObtainCaptionFromTag = "tut2.txt"
            Case DB_Tutorial3:
                ObtainCaptionFromTag = "tut3.txt"
            Case DB_Tutorial4:
                ObtainCaptionFromTag = "tut4.txt"
            Case DB_Tutorial5:
                ObtainCaptionFromTag = "tut5.txt"
            Case DB_Tutorial6:
                ObtainCaptionFromTag = "tut6.txt"
            Case DB_Tutorial7:
                ObtainCaptionFromTag = "tut7.txt"
            Case DB_Tutorial8:
                ObtainCaptionFromTag = "tut8.txt"
            Case DB_Tutorial9:
                ObtainCaptionFromTag = "tut9.txt"
            Case DB_Tutorial10:
                ObtainCaptionFromTag = "tut10.txt"
            Case DB_Tutorial11:
                ObtainCaptionFromTag = "tut11.txt"
            Case DB_Tutorial12:
                ObtainCaptionFromTag = "tut12.txt"
            Case DB_LangName:
                ObtainCaptionFromTag = "English"
            Case Else:
                ObtainCaptionFromTag = vbNullString
        End Select
    End If
End Function

Function ObtainLanguageName(ByVal dbfile As String) As String
    'return value 1000 (the language name) from the database
    On Error Resume Next
    ObtainLanguageName = ObtainCaptionFromTag(DB_LangName, dbfile)
End Function


Sub OpenLanguage(ByVal file As String, lTable As LangTable)
    'open a language database (lng) file
    
    On Error Resume Next
    
    ReDim lTable.theTable(10)
    lTable.numEntries = 0
    Dim idx As Long
    idx = 0
    
    If Not (fileExists(file)) Then
        Exit Sub
    End If
    
    Dim num As Long, a As String, upper As Long
    num = FreeFile
    Open file For Input As #num
        Do While Not (EOF(num))
            Line Input #num, a$
            lTable.theTable(idx) = ParseLangEntry(a$)
            idx = idx + 1
            upper = UBound(lTable.theTable)
            If idx > upper Then
                ReDim Preserve lTable.theTable(upper * 2)
            End If
        Loop
    Close #num
    
    lTable.numEntries = idx
End Sub


Function ParseLangEntry(ByVal line As String) As LangEntry
    'take a lnaguge file entry and parse it
    'ie tagID "Caption" "ToolTip"
    On Error Resume Next
    
    Dim tagID As Long
    Dim Caption As String
    Dim toolTip As String
    tagID = 0
    Caption = vbNullString
    toolTip = vbNullString
    
    Dim Temp As String
    'TagID
    Dim t As Long, part As String, idx As Long
    For t = 1 To Len(line)
        part$ = Mid$(line, t, 1)
        If part$ = " " Or part$ = vbTab Then
            'ok, we're starting in on the caption tag...
            tagID = CInt(Temp)
            Temp = vbNullString
            idx = t
            Exit For
        Else
            Temp = Temp & part$
        End If
    Next t
       
    'gobble up whitespace...
    For t = idx To Len(line)
        part$ = Mid$(line, t, 1)
        If part$ = vbTab Then
            'tab. This means next entry is coming...
            idx = t + 1
            Exit For
        End If
        If part$ <> " " And part$ <> vbTab Then
            'found start of new block
            idx = t
            Exit For
        End If
    Next t
    
    'Caption
    Dim firstOccur As Boolean
    firstOccur = True
    For t = idx To Len(line)
        part$ = Mid$(line, t, 1)
        If part$ = vbTab Then
            'next entry, please!
            idx = t
            Exit For
        End If
        If part$ = ("""") Then
            If firstOccur = True Then
                firstOccur = False
            Else
                'found end of caption tag.
                Caption = Temp
                Temp = vbNullString
                idx = t + 1
                Exit For
            End If
        Else
            If part$ = "\" Then
                t = t + 1
                part$ = Mid$(line, t, 1)
            End If
            Temp = Temp & part$
        End If
    Next t
    
    'gobble up whitespace...
    For t = idx To Len(line)
        part$ = Mid$(line, t, 1)
        If part$ = vbTab Then
            'tab. This means next entry is coming...
            idx = t + 1
            Exit For
        End If
        If part$ <> " " And part$ <> vbTab Then
            'found start of new block
            idx = t
            Exit For
        End If
    Next t
    
    'ToolTip
    firstOccur = True
    For t = idx To Len(line)
        part$ = Mid$(line, t, 1)
        If part$ = ("""") Then
            If firstOccur = True Then
                firstOccur = False
            Else
                'found end of tooltip tag.
                toolTip = Temp
                Temp = vbNullString
                idx = t + 1
                Exit For
            End If
        Else
            If part$ = "\" Then
                t = t + 1
                part$ = Mid$(line, t, 1)
            End If
            Temp = Temp & part$
        End If
    Next t
    
    Dim toRet As LangEntry
    toRet.tagID = tagID
    toRet.Caption = Caption
    toRet.toolTip = toolTip
    
    ParseLangEntry = toRet
End Function


