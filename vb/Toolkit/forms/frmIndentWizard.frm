VERSION 5.00
Begin VB.Form frmIndentWizard 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Indent Wizard"
   ClientHeight    =   2820
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4335
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2820
   ScaleWidth      =   4335
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdIndent 
      Caption         =   "Indent"
      Default         =   -1  'True
      Height          =   375
      Left            =   2640
      TabIndex        =   5
      Top             =   240
      Width           =   1575
   End
   Begin VB.Frame frmInfo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Info"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   2640
      TabIndex        =   2
      Top             =   720
      Visible         =   0   'False
      Width           =   1575
      Begin VB.Label lblWait 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BeginProperty Font 
            Name            =   "Trebuchet MS"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame frmDescription 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Description"
      BeginProperty Font 
         Name            =   "Trebuchet MS"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2415
      Begin VB.Label lblMoreDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "This will not damage any existing indentation and your code will be indented in accordance with today's standards."
         BeginProperty Font 
            Name            =   "Trebuchet MS"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   1335
         Left            =   120
         TabIndex        =   4
         Top             =   1080
         Width           =   2175
      End
      Begin VB.Label lblDescription 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "This wizard will properly indent your code for readability pruposes."
         BeginProperty Font 
            Name            =   "Trebuchet MS"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   735
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   2175
      End
   End
End
Attribute VB_Name = "frmIndentWizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'============================================================================
' RPGCode Indent Wizard
' Designed, Programmed, and Copyright of Colin James Fitzpatrick, 2004
'============================================================================

Option Explicit

'============================================================================
' Declarations
'============================================================================

Private preventClose As Integer

'============================================================================
' Control events
'============================================================================

Private Sub cmdIndent_Click()
    If (preventClose = 1) Then Exit Sub
    If GetSetting("RPGToolkit3", "PRG Editor", "Tabs", 1) = 0 Then
        Call indentCode(" ")
    Else
        Call indentCode(vbTab)
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = preventClose
End Sub

'============================================================================
' Main code
'============================================================================

Public Sub indentCode(ByVal ic As String)

    On Error Resume Next

    Dim noNext As Boolean, lines() As String
    Dim il As Long, a As Long, b As Long, c As Long
    Dim scopeDepth As Long, check As Boolean

    ' Don't let the user mess with anything
    preventClose = 1

    ' Show the 'please wait' frame
    frmInfo.Visible = True

    ' Indent the code
    With activeRPGCode.codeForm
        .Locked = True
        lblWait.Caption = "Splitting..."
        lines = Split(.Text, vbNewLine)
        .Text = vbNullString
        For a = 0 To UBound(lines)
            lblWait.Caption = CStr(CInt((a / UBound(lines) * 100))) & "% Complete"
            lines(a) = replace(Trim$(lines(a)), vbTab, vbNullString)
            Dim ucla As String
            ucla = UCase$(lines(a))
            For b = 1 To il
                lines(a) = ic & lines(a)
            Next b
            If (ucla = "PUBLIC:" Or ucla = "PRIVATE:") Then
                If (scopeDepth = 0) Then
                    il = il + 1
                    scopeDepth = il
                Else
                    lines(a) = replace(lines(a), vbTab, vbNullString, , 1)
                End If
            End If
            If (check) Then
                check = False
                If (scopeDepth = 0) Then
                    il = il - 1
                End If
            End If
            Dim tl As String
            tl = Trim$(lines(a + 1))
            If (Not noNext) Then
                Call changePerOccurence(Trim$(lines(a)), "{", il, 1)
            End If
            If InStrB(1, tl, "}") Then
                Dim oil As Long
                oil = il
                Call changePerOccurence(tl, "}", il, -1)
                Call changePerOccurence(tl, "{", il, 1)
                If (scopeDepth <> 0) Then
                    scopeDepth = scopeDepth + (il - oil)
                    check = True
                End If
                noNext = True
            Else
                noNext = False
            End If
            .Text = .Text & lines(a)
            If (a <> UBound(lines)) Then
                .Text = .Text & vbCrLf
            End If
            .selStart = Len(.Text)
            DoEvents
        Next a
        .Locked = False
    End With

    ' Re-color this code
    Call SplitLines
    DoEvents

    ' Did something go wrong?
    If (il <> 0) Then
        Call frmCodeTip.showTip("RPGCode Error", _
        "The amount of opening, {, and closing, }, brackets in your " _
        & "code are not equal. This not only has caused incorrect indentation, " _
        & "but it may cause errors in your program.")
    End If

    ' Unload this form
    preventClose = 0
    Call Unload(Me)
    DoEvents

End Sub

Private Sub changePerOccurence(ByVal txt As String, ByVal chr As String, ByRef toChange As Long, ByVal change As Long)
    Dim a As Long
    For a = 1 To Len(txt)
        If LCase$(Mid(txt, a, 1)) = chr Then
            toChange = toChange + change
        End If
    Next a
End Sub
