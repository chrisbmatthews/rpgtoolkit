Attribute VB_Name = "CommonDialogs"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Contains code for file open /save dialogs
'and color dialogs

Option Explicit

'info passed between file dialog function calls
Type FileDialogInfo
    strTitle As String  'title of dialog (in)
    strFileTypes As String  'a filetypes string (in) (ie 'All files (*.*)|*.*')
    strDefaultExt As String 'default ext (in)
    strDefaultFolder As String  'default folder (in)
    
    'Things returned:
    strSelectedFile As String   'file that was selected, with path (out)
    strSelectedFileNoPath As String 'file that was selected, no path (out)
End Type


'windows api:

Public Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Public Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function ChooseColor Lib "comdlg32.dll" Alias "ChooseColorA" (pChoosecolor As CHOOSECOLOR_TYPE) As Long

Declare Function GlobalAlloc Lib "kernel32.dll" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Declare Function GlobalLock Lib "kernel32.dll" (ByVal hMem As Long) As Long
Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Long, ByRef Source As Long, ByVal Length As Long)
Declare Function GlobalUnlock Lib "kernel32.dll" (ByVal hMem As Long) As Long
Declare Function GlobalFree Lib "kernel32.dll" (ByVal hMem As Long) As Long

Public Declare Function CommDlgExtendedError Lib "comdlg32.dll" () As Long

Public Type OPENFILENAME
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


Public Type CHOOSECOLOR_TYPE
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

Dim custcols(15) As Long  ' holds list of the 16 custom colors

Public Const GMEM_DDESHARE = &H2000
Public Const GMEM_DISCARDABLE = &H100
Public Const GMEM_DISCARDED = &H4000
Public Const GMEM_FIXED = &H0
Public Const GMEM_INVALID_HANDLE = &H8000
Public Const GMEM_LOCKCOUNT = &HFF
Public Const GMEM_MODIFY = &H80
Public Const GMEM_MOVEABLE = &H2
Public Const GMEM_NOCOMPACT = &H10
Public Const GMEM_NODISCARD = &H20
Public Const GMEM_NOT_BANKED = &H1000
Public Const GMEM_NOTIFY = &H4000
Public Const GMEM_SHARE = &H2000
Public Const GMEM_VALID_FLAGS = &H7F72
Public Const GMEM_ZEROINIT = &H40
Public Const GMEM_LOWER = GMEM_NOT_BANKED

Public Const CC_ANYCOLOR = &H100
Public Const CC_CHORD = 4               '  Can do chord arcs
Public Const CC_CIRCLES = 1             '  Can do circles
Public Const CC_ELLIPSES = 8            '  Can do ellipese
Public Const CC_ENABLEHOOK = &H10
Public Const CC_ENABLETEMPLATE = &H20
Public Const CC_ENABLETEMPLATEHANDLE = &H40
Public Const CC_FULLOPEN = &H2
Public Const CC_INTERIORS = 128 '  Can do interiors
Public Const CC_NONE = 0                '  Curves not supported
Public Const CC_PIE = 2                 '  Can do pie wedges
Public Const CC_PREVENTFULLOPEN = &H4
Public Const CC_RGBINIT = &H1
Public Const CC_ROUNDRECT = 256 '
Public Const CC_SHOWHELP = &H8
Public Const CC_SOLIDCOLOR = &H80
Public Const CC_STYLED = 32             '  Can do styled lines
Public Const CC_WIDE = 16               '  Can do wide lines
Public Const CC_WIDESTYLED = 64         '  Can do wide styled lines

Private Function APIString2VBString(ByVal str As String) As String
    'convert a null terminated string into a vb string
    On Error Resume Next
    
    Dim toRet As String
    Dim part As String
    Dim t As Integer
    For t = 0 To Len(str)
        part = Mid$(str, t, 1)
        If part = chr$(0) Then
            Exit For
        Else
            toRet = toRet + part
        End If
    Next t
    
    APIString2VBString = toRet
End Function


Function ColorDialog(Optional ByVal returnNegOnCancel As Boolean = False) As Long
    'pop up a color dialog
    'return -1 if cancelled.
    'else return rgb color bvalue as a long
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
    CopyMemory ByVal pMem, custcols(0), 64  ' 16 elements * 4 bytes
    
   
    ' Store the initial settings of the Choose Color box.
    cc.lStructSize = Len(cc)  ' size of the structure
    cc.hwndOwner = 0  ' Form1 is opening the Choose Color box
    cc.hInstance = App.hInstance  ' not needed
    cc.rgbResult = 0  ' set default selected color to Form1's background color
    cc.lpCustColors = pMem  ' pointer to list of custom colors
    cc.flags = CC_ANYCOLOR Or CC_RGBINIT  ' allow any color, use rgbResult as default selection
    cc.lCustData = 0  ' not needed
    cc.lpfnHook = 0  ' not needed
    cc.lpTemplateName = ""  ' not needed
    
    ' Open the Choose Color box.  If the user chooses a color, set Form1's
    ' background color to that color.
    retval = ChooseColor(cc)
    If retval <> 0 Then  ' success
      ' Copy the possibly altered contents of the custom color list
      ' back into the array.
      CopyMemory custcols(0), ByVal pMem, 64
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


Function DialogFilterToAPIFilter(ByVal filter As String) As String
    'convert a vb file dialog filter list (delineated by '|') to
    'an API filter list (delineated by chr$(0))
    On Error Resume Next

    Dim toRet As String
    
    Dim t As Integer
    Dim part As String
    For t = 0 To Len(filter)
        part = Mid$(filter, t, 1)
        If part = "|" Then part = chr$(0)
        toRet = toRet + part
    Next t
          
    toRet = toRet + chr$(0)
    toRet = toRet + chr$(0)

    DialogFilterToAPIFilter = toRet
End Function

Function OpenFileDialog(ByRef dlgInfo As FileDialogInfo, Optional ByVal hwndParent As Long = 0) As Boolean
    'open file dialog.
    'return false if cancelled
    On Error Resume Next
    
    Dim retval As Long ' return value of the function
    Dim opfS As OPENFILENAME ' variable to hold the structure
    
    Const MAX_BUFFER = 255 ' the maximum length of the file name
    
    With opfS ' populate the structure
          .lStructSize = Len(opfS) ' the size of the structure
          .hwndOwner = hwndParent ' the owner of the dialog (the form handle)
          .hInstance = App.hInstance ' instance of the app, use App.hInstance
          .lpstrTitle = dlgInfo.strTitle ' the title of the dialog box
          .lpstrInitialDir = dlgInfo.strDefaultFolder ' initial directory which the user will see
          .lpstrFilter = DialogFilterToAPIFilter(dlgInfo.strFileTypes)
          .nFilterIndex = 1 '
          .lpstrFile = String(MAX_BUFFER + 1, 0) ' initialize empty string to get 'filename
          .nMaxFile = MAX_BUFFER ' the maximum length of the filename
          .lpstrFileTitle = .lpstrFile '
          .nMaxFileTitle = MAX_BUFFER
          .lpstrDefExt = dlgInfo.strDefaultExt
    End With
    
    retval = GetOpenFileName(opfS)
    
    dlgInfo.strSelectedFile = APIString2VBString(opfS.lpstrFile)
    dlgInfo.strSelectedFileNoPath = APIString2VBString(opfS.lpstrFileTitle)
    
    If retval = 0 Then
        OpenFileDialog = False
    Else
        OpenFileDialog = True
    End If
End Function


Function SaveFileDialog(ByRef dlgInfo As FileDialogInfo, Optional ByVal hwndParent As Long = 0) As Boolean
    'save file dialog.
    'return false if cancelled
    On Error Resume Next
    
    'CommonDialogsHost.CommonDialog1.CancelError = True
    'CommonDialogsHost.CommonDialog1.InitDir = dlgInfo.strDefaultFolder
    'CommonDialogsHost.CommonDialog1.filename = ""
    'CommonDialogsHost.CommonDialog1.DialogTitle = dlgInfo.strTitle
    'CommonDialogsHost.CommonDialog1.DefaultExt = dlgInfo.strDefaultExt
    'CommonDialogsHost.CommonDialog1.filter = dlgInfo.strFileTypes
    'CommonDialogsHost.CommonDialog1.Action = 2
    'If Err.number = 32755 Then  'user pressed cancel
    '    SaveFileDialog = False
    '    Exit Function
    'End If
   '
   ' dlgInfo.strSelectedFile = CommonDialogsHost.CommonDialog1.filename
   ' dlgInfo.strSelectedFileNoPath = CommonDialogsHost.CommonDialog1.FileTitle
   '
   ' SaveFileDialog = True

    Dim retval As Long ' return value of the function
    Dim opfS As OPENFILENAME ' variable to hold the structure
    
    Const MAX_BUFFER = 255 ' the maximum length of the file name
    
    With opfS ' populate the structure
          .lStructSize = Len(opfS) ' the size of the structure
          .hwndOwner = hwndParent ' the owner of the dialog (the form handle)
          .hInstance = App.hInstance ' instance of the app, use App.hInstance
          .lpstrTitle = dlgInfo.strTitle ' the title of the dialog box
          .lpstrInitialDir = dlgInfo.strDefaultFolder ' initial directory which the user will see
          .lpstrFilter = DialogFilterToAPIFilter(dlgInfo.strFileTypes)
          .nFilterIndex = 1 '
          .lpstrFile = String(MAX_BUFFER + 1, 0) ' initialize empty string to get 'filename
          .nMaxFile = MAX_BUFFER ' the maximum length of the filename
          .lpstrFileTitle = .lpstrFile '
          .nMaxFileTitle = MAX_BUFFER
          .lpstrDefExt = dlgInfo.strDefaultExt
    End With
    
    retval = GetSaveFileName(opfS)
    
    dlgInfo.strSelectedFile = APIString2VBString(opfS.lpstrFile)
    dlgInfo.strSelectedFileNoPath = APIString2VBString(opfS.lpstrFileTitle)
    
    If retval = 0 Then
        SaveFileDialog = False
    Else
        SaveFileDialog = True
    End If
End Function


