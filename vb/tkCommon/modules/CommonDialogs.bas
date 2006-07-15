Attribute VB_Name = "CommonDialogs"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Common windows dialog code
'=========================================================================

Option Explicit

'=========================================================================
' A file dialog structure
'=========================================================================
Public Type FileDialogInfo
    strTitle As String                'title of dialog (in)
    strFileTypes As String            'a filetypes string (in) (ie 'All files (*.*)|*.*')
    strDefaultExt As String           'default ext (in)
    strDefaultFolder As String        'default folder (in)
    strSelectedFile As String         'file that was selected, with path (out)
    strSelectedFileNoPath As String   'file that was selected, no path (out)
End Type

'=========================================================================
' Win32 APIs
'=========================================================================
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function ChooseColor Lib "comdlg32.dll" Alias "ChooseColorA" (pChoosecolor As CHOOSECOLOR_TYPE) As Long
Private Declare Function GlobalAlloc Lib "kernel32.dll" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalLock Lib "kernel32.dll" (ByVal hMem As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Long, ByRef Source As Long, ByVal Length As Long)
Private Declare Function GlobalUnlock Lib "kernel32.dll" (ByVal hMem As Long) As Long
Private Declare Function GlobalFree Lib "kernel32.dll" (ByVal hMem As Long) As Long
Private Declare Function CommDlgExtendedError Lib "comdlg32.dll" () As Long

'=========================================================================
' Win32 structure for an open file dialog
'=========================================================================
Private Type OPENFILENAME
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    lpstrFilter As String
    lpstrCustomFilter As String
    nMaxCustFilter As Long
    nFilterIndex As Long
    lpstrFile As String
    nMaxFile As Long
    lpstrFileTitle As String
    nMaxFileTitle As Long
    lpstrInitialDir As String
    lpstrTitle As String
    flags As Long
    nFileOffset As Integer
    nFileExtension As Integer
    lpstrDefExt As String
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

'=========================================================================
' Win32 structure for a color choosing dialog
'=========================================================================
Private Type CHOOSECOLOR_TYPE
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    rgbResult As Long
    lpCustColors As Long
    flags As Long
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

'=========================================================================
' Custom colors (not used!)
'=========================================================================
Private custCols(15) As Long

'=========================================================================
' Related Win32 constants
'=========================================================================
Private Const GMEM_DDESHARE = &H2000
Private Const GMEM_DISCARDABLE = &H100
Private Const GMEM_DISCARDED = &H4000
Private Const GMEM_FIXED = &H0
Private Const GMEM_INVALID_HANDLE = &H8000
Private Const GMEM_LOCKCOUNT = &HFF
Private Const GMEM_MODIFY = &H80
Private Const GMEM_MOVEABLE = &H2
Private Const GMEM_NOCOMPACT = &H10
Private Const GMEM_NODISCARD = &H20
Private Const GMEM_NOT_BANKED = &H1000
Private Const GMEM_NOTIFY = &H4000
Private Const GMEM_SHARE = &H2000
Private Const GMEM_VALID_FLAGS = &H7F72
Private Const GMEM_ZEROINIT = &H40
Private Const GMEM_LOWER = GMEM_NOT_BANKED
Private Const CC_ANYCOLOR = &H100
Private Const CC_CHORD = 4               '  Can do chord arcs
Private Const CC_CIRCLES = 1             '  Can do circles
Private Const CC_ELLIPSES = 8            '  Can do ellipese
Private Const CC_ENABLEHOOK = &H10
Private Const CC_ENABLETEMPLATE = &H20
Private Const CC_ENABLETEMPLATEHANDLE = &H40
Private Const CC_FULLOPEN = &H2
Private Const CC_INTERIORS = 128         '  Can do interiors
Private Const CC_NONE = 0                '  Curves not supported
Private Const CC_PIE = 2                 '  Can do pie wedges
Private Const CC_PREVENTFULLOPEN = &H4
Private Const CC_RGBINIT = &H1
Private Const CC_ROUNDRECT = 256 '
Private Const CC_SHOWHELP = &H8
Private Const CC_SOLIDCOLOR = &H80
Private Const CC_STYLED = 32             '  Can do styled lines
Private Const CC_WIDE = 16               '  Can do wide lines
Private Const CC_WIDESTYLED = 64         '  Can do wide styled lines
Private Const OFN_OVERWRITEPROMPT = &H2
Private Const OFN_HIDEREADONLY = &H4
Private Const OFN_NOCHANGEDIR = &H8
Private Const OFN_NOREADONLYRETURN = &H8000&

Private Const MAX_BUFFER = 255

'=========================================================================
' Convert a pointer to a null-terminated string to a VB string
'=========================================================================
Private Function APIString2VBString(ByVal str As String) As String
    On Error Resume Next
    Dim part As String, stringPos As Integer
    For stringPos = 0 To Len(str)
        part = Mid$(str, stringPos, 1)
        If part = vbNullChar Then
            Exit For
        Else
            APIString2VBString = APIString2VBString & part
        End If
    Next stringPos
End Function

'=========================================================================
' Show a color dialog
'=========================================================================
Public Function ColorDialog(Optional ByVal returnNegOnCancel As Boolean = True) As Long

    On Error Resume Next

    Dim cc As CHOOSECOLOR_TYPE ' structure to pass data
    Dim c As Integer  ' counter variable
    Dim retval As Long  ' return value
    
    Dim hMem As Long  ' handle to the memory block to store the custom color list
    Dim pMem As Long  ' pointer to the memory block to store the custom color list
    ' Create a memory block and get a pointer to it.
    hMem = GlobalAlloc(GMEM_MOVEABLE Or GMEM_ZEROINIT, 64)  ' allocate sufficient memory block
    pMem = GlobalLock(hMem)  ' get a pointer to the block
    ' Copy the data inside the array into the memory block.
    Call CopyMemory(ByVal pMem, custCols(0), 64)   ' 16 elements * 4 bytes
   
    ' Store the initial settings of the Choose Color box.
    With cc
        .lStructSize = Len(cc)  ' size of the structure
        .hwndOwner = 0  ' Form1 is opening the Choose Color box
        .hInstance = App.hInstance  ' not needed
        .rgbResult = 0  ' set default selected color to Form1's background color
        .lpCustColors = pMem  ' pointer to list of custom colors
        .flags = CC_ANYCOLOR Or CC_RGBINIT  ' allow any color, use rgbResult as default selection
        .lCustData = 0  ' not needed
        .lpfnHook = 0  ' not needed
        .lpTemplateName = vbNullString  ' not needed
    End With

    ' Open the Choose Color box.  If the user chooses a color, set Form1's
    ' background color to that color.
    retval = ChooseColor(cc)
    If (retval) Then   ' success
      ' Copy the possibly altered contents of the custom color list
      ' back into the array.
      Call CopyMemory(custCols(0), ByVal pMem, 64)
      ' Set Form1's background color.
      ColorDialog = cc.rgbResult
    Else
        If returnNegOnCancel Then
            ColorDialog = -1
        Else
            ColorDialog = 0
        End If
    End If

    ' Deallocate the memory blocks to free up resources.
    retval = GlobalUnlock(hMem)
    retval = GlobalFree(pMem)
End Function

'=========================================================================
' Convert a dialog filter with |s to one with NULLs
'=========================================================================
Private Function DialogFilterToAPIFilter(ByVal filter As String) As String
    On Error Resume Next
    Dim toRet As String, t As Integer, part As String
    For t = 0 To Len(filter)
        part = Mid$(filter, t, 1)
        If part = "|" Then part = vbNullChar
        toRet = toRet & part
    Next t
    toRet = toRet & vbNullChar
    toRet = toRet & vbNullChar
    DialogFilterToAPIFilter = toRet
End Function

'=========================================================================
' Show an open file dialog
'=========================================================================
Public Function OpenFileDialog(ByRef dlgInfo As FileDialogInfo, Optional ByVal hwndParent As Long = 0) As Boolean: On Error Resume Next
    
    Dim opfS As OPENFILENAME
    With opfS
          .lStructSize = Len(opfS)                      ' the size of the structure
          .hwndOwner = hwndParent                       ' the owner of the dialog (the form handle)
          .hInstance = App.hInstance                    ' instance of the app, use App.hInstance
          .lpstrTitle = dlgInfo.strTitle                ' the title of the dialog box
          .lpstrInitialDir = dlgInfo.strDefaultFolder   ' initial directory which the user will see
          .lpstrFilter = DialogFilterToAPIFilter(dlgInfo.strFileTypes)
          .nFilterIndex = 1 '
          .lpstrFile = String(MAX_BUFFER + 1, 0)        ' initialize empty string to get 'filename
          .nMaxFile = MAX_BUFFER                        ' the maximum length of the filename
          .lpstrFileTitle = .lpstrFile
          .nMaxFileTitle = MAX_BUFFER
          .lpstrDefExt = dlgInfo.strDefaultExt
          .flags = OFN_HIDEREADONLY Or OFN_NOCHANGEDIR
    End With
    
    OpenFileDialog = (GetOpenFileName(opfS) <> 0)
    
    dlgInfo.strSelectedFile = APIString2VBString(opfS.lpstrFile)
    dlgInfo.strSelectedFileNoPath = APIString2VBString(opfS.lpstrFileTitle)

End Function

'=========================================================================
' Show a save file dialog
'=========================================================================
Public Function SaveFileDialog( _
    ByRef dlgInfo As FileDialogInfo, _
    Optional ByVal hwndParent As Long = 0, _
    Optional ByVal overwritePrompt As Boolean = False) As Boolean: On Error Resume Next
    
    Dim opfS As OPENFILENAME
    With opfS
          .lStructSize = Len(opfS)                      ' the size of the structure
          .hwndOwner = hwndParent                       ' the owner of the dialog (the form handle)
          .hInstance = App.hInstance                    ' instance of the app, use App.hInstance
          .lpstrTitle = dlgInfo.strTitle                ' the title of the dialog box
          .lpstrInitialDir = dlgInfo.strDefaultFolder   ' initial directory which the user will see
          .lpstrFilter = DialogFilterToAPIFilter(dlgInfo.strFileTypes)
          .nFilterIndex = 1
          .lpstrFile = String(MAX_BUFFER + 1, 0)        ' initialize empty string to get 'filename
          .nMaxFile = MAX_BUFFER                        ' the maximum length of the filename
          .lpstrFileTitle = .lpstrFile
          .nMaxFileTitle = MAX_BUFFER
          .lpstrDefExt = dlgInfo.strDefaultExt
          .flags = OFN_HIDEREADONLY Or OFN_NOCHANGEDIR Or OFN_NOREADONLYRETURN
          
          'Do not allow for selection of read-only files.
          'Prompt if overwriting - optional since this may be a save-game file.
          If overwritePrompt Then .flags = .flags Or OFN_OVERWRITEPROMPT
    End With
    
    SaveFileDialog = (GetSaveFileName(opfS) <> 0)
    
    dlgInfo.strSelectedFile = APIString2VBString(opfS.lpstrFile)
    dlgInfo.strSelectedFileNoPath = APIString2VBString(opfS.lpstrFileTitle)

End Function

'=========================================================================
' Preserve files saved in subfolders of the default folders
' Copy files outside the default folder into the default folder
'=========================================================================
Public Function browseFileDialog( _
    ByVal hwndParent As Long, _
    ByVal defaultPath As String, _
    ByVal windowTitle As String, _
    ByVal defaultExt As String, _
    ByVal fileTypes As String, _
    ByRef returnPath As String) As Boolean ': on error resume next

    Dim dlg As FileDialogInfo
    With dlg
        .strDefaultFolder = defaultPath
        .strTitle = windowTitle
        .strDefaultExt = defaultExt
        .strFileTypes = fileTypes
    End With
    ChDir (currentDir)
    If Not OpenFileDialog(dlg, hwndParent) Then Exit Function
    
    'If no filename entered, exit.
    If LenB(dlg.strSelectedFile) = 0 Then Exit Function

    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, defaultPath, returnPath, True) Then Exit Function
    
    'Copy folders outside the default directory into the default directory.
    If Not fileExists(defaultPath & returnPath) Then
        FileCopy dlg.strSelectedFile, defaultPath & returnPath
    End If

    'A file was selected
    browseFileDialog = True
End Function


