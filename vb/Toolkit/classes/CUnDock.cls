VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CUnDock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'------------------------------------------------------------------------------
' Developed by Maksud Agamirzoyev 10/12/2000
'
' Class Properties: AutoDock (Boolean) - Sets whether dock will be
'                                        handled automatically. In other
'                                        words if try to undock and there
'                                        is already one undocked, it will
'                                        dock it back.
'
' Class Methods:    UnDock (Sub) - Undocks the controls from parent form
'                   Dock (Sub) - Docks control back to the parent form
'
'
' Note:
' It is not recomended to undock button controls, because then you might have some
' problems with receiving events for them, because of the way they handle messages.
'
' YOU SHOULD NOT HAVE CONTAINER OBJECT INSIDE OF ANOTHER CONTAINER OBJECT
'
' Request:
' Please if you modify this class send me a copy agamirm@westat.com
'-------------------------------------------------------------------------------
Option Explicit

'API calls
Private Declare Function GetWindowRect Lib "user32" _
                (ByVal hwnd As Long, lpRect As RECT) As Long
                
Private Declare Function GetParent Lib "user32" _
                (ByVal hwnd As Long) As Long

Private Declare Function GetWindow Lib "user32" _
                (ByVal hwnd As Long, ByVal wCmd As Long) As Long
                
Private Declare Function SetParent Lib "user32" _
                (ByVal hWndChild As Long, _
                ByVal hWndNewParent As Long) As Long

Private Declare Function SetWindowLong Lib "user32" _
                Alias "SetWindowLongA" (ByVal hwnd As Long, _
                ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
                
Private Declare Function ShowWindow Lib "user32" _
                (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
                
Private Declare Function MoveWindow Lib "user32" _
                (ByVal hwnd As Long, ByVal X As Long, _
                ByVal Y As Long, ByVal nWidth As Long, _
                ByVal nHeight As Long, ByVal bRepaint As Long) As Long

Private Declare Function GetWindowLong Lib "user32" Alias _
                "GetWindowLongA" (ByVal hwnd As Long, _
                ByVal nIndex As Long) As Long

'struct to store returned from GetWindowRect
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
    End Type

'status flags
Private Enum DockingStatus
    docked = 0
    UnDocked = 1
End Enum
    
Private Const SW_SHOWDEFAULT = 10
Private Const GWL_STYLE = (-16)
Private Const WS_CHILD = &H40000000
Private Const WS_POPUP = &H80000000
Private Const WS_SYSMENU = &H80000
Private Const GW_CHILD = 5
Private Const GW_HWNDNEXT = 2
Private Const GW_HWNDFIRST = 0
Private Const WS_GROUP = &H20000


'other local variables
Private hwndParent      As Long 'holds parent handle
Private hWndChild       As Long 'stores object handle

Private ObjRect         As RECT 'receives object size info
Private WinRect         As RECT 'receives parent size info

Private xOld            As Long 'holds old coordinates
Private yOld            As Long 'holds old coordinates

Private OldStyle            As Long
Private CurrentStatus       As DockingStatus 'stores current status of object
Private mvarAutoDock        As Boolean 'local copy
Private mvarSetAsChild      As Boolean 'local copy

Public WithEvents MyForm   As frmToolWindow 'Form which holds the undocked control
Attribute MyForm.VB_VarHelpID = -1

Public Property Let SetAsChild(ByVal vData As Boolean)
    'property which determines if Tool window is set to be
    'a child of controls parent
    mvarSetAsChild = vData
End Property

Public Property Get SetAsChild() As Boolean
    SetAsChild = mvarSetAsChild
End Property

Public Property Let AutoDock(ByVal vData As Boolean)
    'property which determines if auto dock should be allowed
    mvarAutoDock = vData
End Property

Public Property Get AutoDock() As Boolean
    AutoDock = mvarAutoDock
End Property

Public Sub unDock(ByVal ObjectHandle As Long, Optional ProcessChildren As Boolean = False, Optional ByVal Caption As String, Optional xPos As Long = -1, Optional yPos As Long = -1)
    Dim retval     As Long
    Dim hTemp      As Long
    Dim ChildStyle As Long
        'check if control is undocked and autodock is off
        If CurrentStatus = UnDocked And AutoDock = False Then
           Exit Sub
        'check if control is undocked and autodock is on
        ElseIf CurrentStatus = UnDocked And AutoDock = True Then
           Dock 'dock control back to its parent
        End If
           
        hWndChild = ObjectHandle 'reassign to higher level variable
        
        If hWndChild = tkMainForm.TreeView1.hwnd Then
            MyForm.BorderStyle = 5
        End If
        If hWndChild = tkMainForm.leftbar.hwnd Then
            tkMainForm.doNotShowTools = True
        End If
        
        retval = GetWindowRect(ObjectHandle, ObjRect) 'obtain size of object
        
        hwndParent = GetParent(ObjectHandle) 'get parent of object
        retval = GetWindowRect(hwndParent, WinRect) 'obtain size of object
        'checks if parent was obtained
        If hwndParent = 0 Then
           Err.Raise 10000, "UnDock", "No Parent"
           Exit Sub
        End If
        
        'check if position coorditates were specified,
        'if not assign from object actual postion
        If xPos = -1 And yPos = -1 Then
           'calculates postion of control relative to parent client area
           xPos = Abs(WinRect.Left - ObjRect.Left) - 4
           xOld = xPos 'saves in global variable
           yPos = Abs(WinRect.Top - ObjRect.Top) - 23
           yOld = yPos 'saves in global variable
        End If
        
        'saves old style information about control which is undocked
        OldStyle = GetWindowLong(ObjectHandle, GWL_STYLE)
        'changes flag of control moved to be a ChildWindow
        retval = SetWindowLong(ObjectHandle, GWL_STYLE, WS_CHILD)
        
        'checks if child processing requested, if control is frame for example
        If ProcessChildren = True Then
           hTemp = GetWindow(ObjectHandle, GW_CHILD) ' gets handle to the first child
           'enters loop to process all children
           Do Until hTemp = 0
              'changes flag of control moved to be a ChildWindow
              retval = SetWindowLong(hTemp, GWL_STYLE, WS_CHILD)
              'shows child window
              ShowWindow hTemp, SW_SHOWDEFAULT
              'gets next child window
              hTemp = GetWindow(hTemp, GW_HWNDNEXT)
           Loop
        End If
        
        'shows actual window on the new form
        ShowWindow ObjectHandle, SW_SHOWDEFAULT
        'rereferences parent of the control to ToolWindow
        SetParent ObjectHandle, MyForm.hwnd
        'rereferences parent of the control to be parent of ToolWindow
        If mvarSetAsChild = True Then _
           SetParent MyForm.hwnd, hwndParent
        
        'moves control
        MoveWindow ObjectHandle, 0, 0, (ObjRect.Right - ObjRect.Left), _
                                 (ObjRect.Bottom - ObjRect.Top), 1

        'moves toolwindow
        MoveWindow MyForm.hwnd, xPos, yPos, _
                   (ObjRect.Right - ObjRect.Left) + 5, _
                   (ObjRect.Bottom - ObjRect.Top) + 22, 1

        MyForm.Show
        
        'Now move them all back...
        Dim ctl As Control
        For Each ctl In MyForm.Controls
            'If (Not ctl.Visible) Then
                If ctl.Left < 0 Then ctl.Left = ctl.Left + 9999
            'End If
        Next ctl

        If hWndChild = tkMainForm.tilesetContainer.hwnd Then
            MyForm.height = tkMainForm.currentTilesetForm.height + 575
        End If

        'assigns caption to the ToolWindow
        MyForm.Caption = Caption
        CurrentStatus = UnDocked 'records status that control was undocked
End Sub

Public Sub Dock()
        'checks if cotrol is undocked

        Select Case hWndChild

            Case tkMainForm.leftbar.hwnd
                tkMainForm.leftBarContainer.Visible = True
                tkMainForm.leftbar.Visible = True
                tkMainForm.doNotShowTools = False
                
            Case tkMainForm.newBar.hwnd
                tkMainForm.popButton(1).Enabled = True
                tkMainForm.popButton(1).value = 0
                
            Case tkMainForm.bTools_Tabs.hwnd
                tkMainForm.popButton(3).Enabled = True
                tkMainForm.popButton(3).value = 0
                
            Case tkMainForm.TreeView1.hwnd
                tkMainForm.popButton(0).Enabled = True
                tkMainForm.popButton(0).value = 0
                
            Case tkMainForm.tilesetContainer.hwnd
                tkMainForm.popButton(2).Enabled = True
                tkMainForm.popButton(2).value = 0
        
        End Select
        
        If CurrentStatus = UnDocked Then
           MyForm.Hide
           'sets cotrol back to its original parent
           SetParent hWndChild, hwndParent
           'restores original style settings
           SetWindowLong hWndChild, GWL_STYLE, OldStyle
           'positions it as it was
           MoveWindow hWndChild, xOld, yOld, _
                      (ObjRect.Right - ObjRect.Left), _
                      (ObjRect.Bottom - ObjRect.Top), 1
           'sets parent of ToolWindow to be Desktop
           SetParent MyForm.hwnd, 0
           CurrentStatus = docked 'records that control is docked
        End If
        
        Select Case hWndChild

            Case tkMainForm.leftbar.hwnd
                tkMainForm.leftbar.Top = 240
                tkMainForm.leftbar.Left = 0
                
            Case tkMainForm.newBar.hwnd
                tkMainForm.newBar.Top = 240
                tkMainForm.newBar.Left = 0
                
            Case tkMainForm.tilesetContainer.hwnd
                tkMainForm.tilesetContainer.Top = 240
                tkMainForm.tilesetContainer.Left = 0
            
            Case tkMainForm.bTools_Tabs.hwnd
                tkMainForm.bTools_Tabs.Top = 360
                tkMainForm.bTools_Tabs.Left = 120
                
            Case tkMainForm.TreeView1.hwnd
                tkMainForm.TreeView1.Left = 0
                tkMainForm.TreeView1.Top = 0
                tkMainForm.fileTree1.Top = 240
                tkMainForm.fileTree1.Left = 110
                tkMainForm.TreeView1.Width = 2535
                tkMainForm.MDIForm_Resize
        
        End Select
        
End Sub

Private Sub Class_Initialize()
    Set MyForm = New frmToolWindow 'creates instance of the form
    'initializes variables
    CurrentStatus = docked
    mvarAutoDock = False
    mvarSetAsChild = False
    Load MyForm 'loads the form into memory
End Sub

Private Sub MyForm_Unload()
    Dock 'docks control back when toolwindow is destroyed
End Sub
