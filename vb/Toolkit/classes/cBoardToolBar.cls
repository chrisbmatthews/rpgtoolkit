VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cBoardToolbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' BOARD TOOLBAR v1.0
' DESIGNED AND CODED BY PHIL CARTY (AKA VAMPZ)
'========================================================================
' The toolbar allows for quick managing of various aspects of the board
' such as handling programs and items or setting additional configurations.
'
' If you'd like to discuss the tool, feel free to post on the open source
' forum at TKZ.
'========================================================================

Option Explicit

'========================================================================
' LOCAL VARIABLES
'========================================================================
Private mObjects As New cBoardToolbar_Objects
Private mDisplay As New cBoardToolbar_Display

'========================================================================
' PUBLIC PROPERTIES
'========================================================================
Property Get Objects() As cBoardToolbar_Objects
    Set Objects = mObjects
End Property
Property Set Objects(newValue As cBoardToolbar_Objects)
    Set mObjects = newValue
End Property

Property Get Display() As cBoardToolbar_Display
    Set Display = mDisplay
End Property
Property Set Display(newValue As cBoardToolbar_Display)
    Set mDisplay = newValue
End Property
