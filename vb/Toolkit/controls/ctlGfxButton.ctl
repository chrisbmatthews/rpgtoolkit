VERSION 5.00
Begin VB.UserControl ctlGfxButton 
   ClientHeight    =   1920
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3030
   PropertyPages   =   "ctlGfxButton.ctx":0000
   ScaleHeight     =   1920
   ScaleWidth      =   3030
   Begin VB.CommandButton cmdFallback 
      Height          =   375
      Left            =   0
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   1455
   End
End
Attribute VB_Name = "ctlGfxButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
' All contents copyright 2004, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Graphical Button
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function TransparentBlt Lib "msimg32" (ByVal hdcDest As Long, ByVal nXOriginDest As Long, ByVal nYOriginDest As Long, ByVal nWidthDest As Long, ByVal nHeightDest As Long, ByVal hdcSrc As Long, ByVal nXOriginSrc As Long, ByVal nYOriginSrc As Long, ByVal nWidthSrc As Long, ByVal nHeightSrc As Long, ByVal crTransparent As Long) As Long
Private Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Private Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal lpString As String, ByVal nCount As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long

'=========================================================================
' Constants
'=========================================================================
Private Const TRANSPARENT = 1       ' Transparent text background

'=========================================================================
' Members
'=========================================================================
Private m_lngWidth As Long          ' Width of the button
Private m_lngHeight As Long         ' Height of the button
Private m_hPicDC As Long            ' GDC the image is drawn on
Private m_picDisp As IPictureDisp   ' IPictureDisp object of the picture
Private m_strCaption As String      ' Caption on the button

'=========================================================================
' Events
'=========================================================================
Public Event click()                ' Button was clicked

'=========================================================================
' Width property
'=========================================================================
Public Property Get width() As Long
    width = m_lngWidth
End Property
Public Property Let width(ByVal RHS As Long)
    m_lngWidth = RHS
    cmdFallback.width = RHS
End Property

'=========================================================================
' Height property
'=========================================================================
Public Property Get Height() As Long
    Height = m_lngHeight
End Property
Public Property Let Height(ByVal RHS As Long)
    m_lngHeight = RHS
    cmdFallback.Height = RHS
End Property

'=========================================================================
' Caption property
'=========================================================================
Public Property Get Caption() As String
    Caption = m_strCaption
End Property
Public Property Let Caption(ByRef strCaption As String)
    m_strCaption = strCaption
    cmdFallback.Caption = strCaption
    ' Need to redraw
    Call draw(1)
End Property

'=========================================================================
' Picture propery
'=========================================================================
Public Property Get picture() As IPictureDisp
    Set picture = m_picDisp
End Property
Public Property Let picture(ByRef RHS As IPictureDisp)

    ' If it's a non-zero RHS
    If Not (RHS Is Nothing) Then

        Dim hOldObject As Long

        ' Select the picture into our DC
        hOldObject = SelectObject(m_hPicDC, RHS.handle)

        ' If there was an old object
        If (hOldObject) Then

            ' Delete the old object
            Call DeleteObject(hOldObject)

        End If

    End If

    ' Store the RHS
    Set m_picDisp = RHS

    ' Also copy over to fallback button
    Set cmdFallback.picture = RHS

    ' Need to redraw
    Call draw(1)

End Property
Public Property Set picture(ByRef RHS As IPictureDisp)

    ' Let the picture be the RHS
    picture = RHS

End Property

'=========================================================================
' Constructor
'=========================================================================
Private Sub UserControl_Initialize()

    ' Create a new DC
    m_hPicDC = CreateCompatibleDC(0)

End Sub

'=========================================================================
' Draw the button
'=========================================================================
Private Sub draw(ByVal lngState As Long)

    ' Create an object for drawing XP visual styles, if they are avaliable
    Dim xpStyles As cUxTheme
    Set xpStyles = New cUxTheme

    ' Set to draw an push button in the specified state
    xpStyles.Class = "Button"
    xpStyles.part = 1
    xpStyles.State = lngState

    ' Set width and height to the size of the button
    xpStyles.width = m_lngWidth \ Screen.TwipsPerPixelX
    xpStyles.Height = m_lngHeight \ Screen.TwipsPerPixelY

    ' Draw the button
    xpStyles.hdc = UserControl.hdc
    cmdFallback.Visible = Not (xpStyles.draw())

    ' If we fell back
    If (cmdFallback.Visible) Then

        ' Allow the button to draw its own caption and picture
        Exit Sub

    End If

    ' If a caption is set
    If (LenB(m_strCaption)) Then

        ' Lay down caption
        Call SetBkMode(UserControl.hdc, TRANSPARENT)
        Call TextOut(UserControl.hdc, 0, xpStyles.Height \ 2 - 5, m_strCaption, Len(m_strCaption))

    End If

    ' If an image is set
    If Not (m_picDisp Is Nothing) Then

        ' Draw the image
        Dim lngWidth As Long
        lngWidth = m_picDisp.width \ Screen.TwipsPerPixelX
        Call BitBlt(UserControl.hdc, 0, 0, m_picDisp.width \ Screen.TwipsPerPixelX, m_picDisp.Height \ Screen.TwipsPerPixelY, m_hPicDC, 0, 0, vbSrcAnd)

    End If

End Sub

'=========================================================================
' Mouse moved over the button
'=========================================================================
Private Sub UserControl_MouseMove(ByRef Button As Integer, ByRef Shift As Integer, ByRef x As Single, ByRef y As Single)

    ' Draw the hover image
    Call draw(2)

End Sub

'=========================================================================
' Paint the control
'=========================================================================
Private Sub UserControl_Paint()

    ' Draw the button unpushed
    Call draw(1)

End Sub

'=========================================================================
' Read properties from a bag
'=========================================================================
Private Sub UserControl_ReadProperties(ByRef props As PropertyBag)
    width = props.ReadProperty("width", 500)
    Height = props.ReadProperty("height", 300)
    picture = props.ReadProperty("picture", Nothing)
    Caption = props.ReadProperty("caption", vbNullString)
End Sub

'=========================================================================
' Height and / or width were changed
'=========================================================================
Private Sub UserControl_Resize()
    Height = UserControl.Height
    width = UserControl.width
End Sub

'=========================================================================
' Write properties to a bag
'=========================================================================
Private Sub UserControl_WriteProperties(ByRef props As PropertyBag)
    Call props.WriteProperty("width", width)
    Call props.WriteProperty("height", Height)
    Call props.WriteProperty("picture", picture)
    Call props.WriteProperty("caption", Caption)
End Sub

'=========================================================================
' Deconstructor
'=========================================================================
Private Sub UserControl_Terminate()

    ' Delete the picture DC
    Call DeleteDC(m_hPicDC)

End Sub
