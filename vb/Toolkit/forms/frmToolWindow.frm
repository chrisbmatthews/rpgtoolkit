VERSION 5.00
Begin VB.Form frmToolWindow 
   Appearance      =   0  'Flat
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "ToolBar"
   ClientHeight    =   4665
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   1905
   ClipControls    =   0   'False
   HasDC           =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   ScaleHeight     =   233.25
   ScaleMode       =   2  'Point
   ScaleWidth      =   95.25
   ShowInTaskbar   =   0   'False
End
Attribute VB_Name = "frmToolWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Event Unload()

Private Sub Form_Resize()
 tkMainForm.TreeView1.height = Me.height - 400
 tkMainForm.TreeView1.Width = Me.Width - 145
End Sub

Private Sub Form_Unload(Cancel As Integer)
 RaiseEvent Unload
End Sub
