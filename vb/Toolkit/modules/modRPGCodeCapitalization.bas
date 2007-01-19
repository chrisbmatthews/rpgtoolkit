Attribute VB_Name = "modRPGCodeCleaner"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private rpgC As String

Public Function CapitalizeRPGCode(ByVal txt As String) As String
 CapitalizeRPGCode = txt
End Function

#If (OLD_CODE) Then

 txt = Trim(replaceOutsideQuotes((txt), vbTab, "", True))
 If Left(txt, 1) = "*" Or Left(txt, 2) = "//" Then
  CapitalizeRPGCode = txt
  Exit Function
 End If

 If GetSetting("RPGToolkit3", "PRG Editor", "Cap", 1) = 0 Then
  CapitalizeRPGCode = txt
  Exit Function
 End If

 'Make the text avaliable around this module...
 rpgC = txt

 'Do it!
 fR "AutoCommand"
 fR "AddPlayer"
 fR "AI"
 fR "AnimatedTiles"
 fR "Animation"
 fR "ApplyStatus"
 fR "Asc"
 fR "AttackAll"
 fR "BattleSpeed"
 fR "Bitmap"
 fR "Bold"
 fR "Branch"
 fR "Break"
 fR "CallPlayerSwap"
 fR "CallShop"
 fR "CastInt"
 fR "CastLit"
 fR "CastNum"
 fR "Change"
 fR "CharacterSpeed"
 fR "CharAt"
 fR "CheckButton"
 fR "ClearBuffer"
 fR "ClearButtons"
 fR "Clear"
 fR "CloseFile"
 fR "ColorRGB"
 fR "Color"
 fR "Cos"
 fR "CreateCanvas"
 fR "CreateCursorMap"
 fR "CreateItem"
 fR "CursorMapAdd"
 fR "CursorMapHand"
 fR "CursorMapRun"
 fR "Debugger"
 fR "Debug"
 fR "Delay"
 fR "DestroyItem"
 fR "DestroyPlayer"
 fR "DirSav"
 fR "Done"
 fR "Dos"
 fR "DrainAll"
 fR "DrawCanvas"
 fR "DrawCircle"
 fR "DrawEnemy"
 fR "DrawLine"
 fR "DrawRect"
 fR "Earthquake"
 fR "Empty"
 fR "End"
 fR "Equip"
 fR "EraseItem"
 fR "ErasePlayer"
 fR "Fade"
 fR "FBranch"
 fR "FightEnemy"
 fR "FightMenuGraphic"
 fR "Fight"
 fR "FightStyle"
 fR "FileEOF"
 fR "FileGet"
 fR "FileInput"
 fR "FilePrint"
 fR "FilePut"
 fR "FillCircle"
 fR "FillRect"
 fR "Font"
 fR "FontSize"
 fR "ForceRedraw"
 fR "For"
 fR "GameSpeed"
 fR "GetBoardTile"
 fR "GetBoardTileType"
 fR "GetColor"
 fR "GetCorner"
 fR "GetDP"
 fR "GetFontSize"
 fR "GetFP"
 fR "GetGP"
 fR "GetHP"
 fR "GetItemCost"
 fR "GetItemDesc"
 fR "GetItemName"
 fR "GetItemSell"
 fR "GetLevel"
 fR "GetMaxHP"
 fR "GetMaxSMP"
 fR "GetPixel"
 fR "GetRes"
 fR "Get"
 fR "GetSMP"
 fR "GetThreadID"
 fR "GiveEXP"
 fR "GiveGP"
 fR "GiveHP"
 fR "GiveItem"
 fR "GiveSMP"
 fR "Global"
 fR "GoDos"
 fR "Gone"
 fR "HP"
 fR "If"
 fR "ElseIf"
 fR "Else"
 fR "Include"
 fR "Inn"
 fR "InStr"
 fR "InternalMenu"
 fR "Italics"
 fR "ItemCount"
 fR "ItemLocation"
 fR "ItemStep"
 fR "ItemWalkSpeed"
 fR "KillAllRedirects"
 fR "KillCanvas"
 fR "KillCursorMap"
 fR "KillRedirect"
 fR "Kill"
 fR "KillThread"
 fR "LayerPut"
 fR "Load"
 fR "Local"
 fR "MainFile"
 fR "MaxHP"
 fR "MaxSMP"
 fR "MsgBox"
 fR "Mem"
 fR "MenuGraphic"
 fR "MidiPlay"
 fR "PlayMidi"
 fR "MediaPlay"
 fR "MidiRest"
 fR "MediaStop"
 fR "MouseClick"
 fR "MouseMove"
 fR "MousePointer"
 fR "Move"
 fR "MP3Pause"
 fR "MWinCls"
 fR "MWin"
 fR "MWinSize"
 fR "NewPlyr"
 fR "On Error Resume Next"
 fR "OnError"
 fR "Resume Next"
 fR "On Error Goto"
 fR "OpenFileAppend"
 fR "OpenFileBinary"
 fR "OpenFileInput"
 fR "OpenFileOutput"
 fR "Over"
 fR "Parallax"
 fR "PathFind"
 fR "PlayAVI"
 fR "PlayAviSmall"
 fR "PlayerStep"
 fR "Posture"
 fR "Prg"
 fR "Print"
 fR "Prompt"
 fR "PushItem"
 fR "Push"
 fR "PutItem"
 fR "PutPlayer"
 fR "Put"
 fR "Random"
 fR "Redirect"
 fR "RemovePlayer"
 fR "Remove"
 fR "RemoveStatus"
 fR "Reset"
 fR "RestorePlayer"
 fR "RestoreScreenArray"
 fR "RestoreScreen"
 fR "ResumeNext"
 fR "ReturnMethod"
 fR "Return"
 fR "Right"
 fR "Left"
 fR "RPGCode"
 fR "Run"
 fR "Save"
 fR "SaveScreen"
 fR "Scan"
 fR "Send"
 fR "SetButton"
 fR "SetConstants"
 fR "SetImageAddictive"
 fR "SetImage"
 fR "SetImageTransulcent"
 fR "SetImageTransparent"
 fR "SetPixel"
 fR "Show"
 fR "Sin"
 fR "SizedAnimation"
 fR "Method"
 fR "SmartStep"
 fR "SMP"
 fR "Sound"
 fR "SourceHandle"
 fR "SourceLocation"
 fR "SpliceVariables"
 fR "Split"
 fR "Sqrt"
 fR "Stance"
 fR "Start"
 fR "StaticText"
 fR "Length"
 fR "Len"
 fR "Switch"
 fR "Case"
 fR "TakeGP"
 fR "TakeItem"
 fR "Tan"
 fR "TargetHandle"
 fR "TargetLocation"
 fR "TellThread"
 fR "Text"
 fR "PixelText"
 fR "TextSpeed"
 fR "Thread"
 fR "ThreadSleepRemaining"
 fR "ThreadSleep"
 fR "ThreadWake"
 fR "TileType"
 fR "Trim"
 fR "UnderArrow"
 fR "Underline"
 fR "ViewBrd"
 fR "Wait"
 fR "WalkSpeed"
 fR "Wander"
 fR "Wav"
 fR "WavStop"
 fR "While"
 fR "WinColor"
 fR "WinColorRGB"
 fR "WinGraphic"
 fR "Win"
 fR "Wipe"
 fR "With"
 fR "ZoomIn"
 fR "Main"
 
 'Pass back that text...
 CapitalizeRPGCode = rpgC
 
End Function

Private Sub fR(ByVal Text As String)
    rpgC = replaceOutsideQuotes(rpgC, Text, Text, True)
End Sub

Private Function replaceOutsideQuotes(ByVal Text As String, ByVal find As String, ByVal replace As String, ByVal stopAtComment As Boolean) As String

    On Error Resume Next

    Dim a As Long
    Dim ignore As Boolean
    
    For a = 1 To Len(Text)
        Dim read As String
        read = Mid(Text, a, Len(find))

        If Left(read, 1) = chr(34) Then
            If ignore Then
                ignore = False
            Else
                ignore = True
            End If

        ElseIf Left(read, 1) = "*" Or Mid(Text, a, 2) = "//" Then
            Exit For

        ElseIf Not ignore Then
            If LCase(find) = LCase(read) Then
                Text = Mid(Text, 1, a - 1) & replace & Mid(Text, a + Len(replace))
            End If

        End If

    Next a
    
    replaceOutsideQuotes = Text

End Function

#End If
