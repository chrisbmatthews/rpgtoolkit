Attribute VB_Name = "transPlugin"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'plug in manager
'added in 2.14
'(Sept 28, 2000)
'Updated for 3.0 (beginning Nov 14, 2002)
Option Explicit



'callbacks:
'0-CBRpgCode(byval rpgcodeCommand as string)
'1-CBGetString(ByVal varName As String) As String
'2-CBGetNumerical(ByVal varName As String) As Double
'3-CBSetString(ByVal varName As String, ByVal newValue As String)
'4-CBSetNumerical(ByVal varName As String, ByVal newValue As Double)
'5-CBGetScreenDC() As Long
'6-CBGetScratch1DC() As Long
'7-CBGetScratch2DC() As Long
'8-CBGetMwinDC() As Long
'9-CBPopupMwin() As Long
'10-CBHideMwin() As Long
'11-CBLoadEnemy(file As String, eneSlot As Long)
'12-CBGetEnemyNum(ByVal infoCode, ByVal eneSlot As Long) As Long
'13-CBGetEnemyString(ByVal infoCode As Long, ByVal eneSlot As Long) As String
'14-CBSetEnemyNum(ByVal infoCode As Long, ByVal newValue, ByVal eneSlot As Long)
'15-CBSetEnemyString(ByVal infoCode As Long, ByVal newValue As String, ByVal eneSlot As Long)
'16-CBGetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
'17-CBGetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As String
'18-CBSetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As Long, ByVal playerSlot As Long)
'19-CBSetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As String, ByVal playerSlot As Long)
'20-CBGetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long)
'21-CBGetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
'22-CBSetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As String)
'23-CBSetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As Long)
'24-CBGetCommandName(ByVal rpgcodecommand As String) As String
'25-CBGetBrackets(ByVal rpgcodecommand As String) As String
'26-CBCountBracketElements(ByVal rpgcodecommand As String) As Long
'27-CBGetBracketElement(ByVal rpgcodecommand As String, ByVal elemNum As Long) As String
'28-CBGetStringElementValue(ByVal rpgcodecommand As String) As String
'29-CBGetNumElementValue(ByVal rpgcodecommand As String) As Double
'30-CBGetElementType(ByVal rpgcodecommand As String) As Long
'31-CBDebugMessage(ByVal message As String)
'32-CBGetPathString(ByVal infoCode As Long) As String
'33-CBLoadSpecialMove(ByVal file As String)
'34-CBGetSpecialMoveString(ByVal infoCode As Long) As String
'35-CBGetSpecialMoveNum(ByVal infoCode As Long) As String
'36-CBLoadItem(ByVal file As String, ByVal itmSlot As Long)
'37-CBGetItemString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As String
'38-CBGetItemNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As Long
'39-CBGetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As Long
'40-CBGetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As String
'41-CBSetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal nValue)
'42-CBSetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal newVal As String)
'43-CBGetHwnd(ByVal infoCode As Long, ByVal eneSlot As Long) As Long
'44-CBRefreshScreen() As Long
'version 3.0
'45-CBCreateCanvas(ByVal width As Long, ByVal height As Long) As Long
'46-CBDestroyCanvas(ByVal canvasID As Long) As Long
'47-CBDrawCanvas(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long) As Long
'48-CBDrawCanvasPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long) As Long
'49-CBDrawCanvasTransparent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTransparentColor As Long) As Long
'50-CBDrawCanvasTransparentPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long) As Long
'51-CBDrawCanvasTranslucent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
'52-CBCanvasLoadImage(ByVal canvasID As Long, ByVal filename As String) As Long
'53-CBCanvasLoadSizedImage(ByVal canvasID As Long, ByVal filename As String) As Long
'54-CBCanvasFill(ByVal canvasID As Long, ByVal crColor As Long) As Long
'55-CBCanvasResize(ByVal canvasID As Long, ByVal width As Long, ByVal height As Long) As Long
'56-CBCanvas2CanvasBlt(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long) As Long
'57-CBCanvas2CanvasBltPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long) As Long
'58-CBCanvas2CanvasBltTransparent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal crTransparentColor As Long) As Long
'59-CBCanvas2CanvasBltTransparentPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor) As Long
'60-CBCanvas2CanvasBltTranslucent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
'61-CBCanvasGetScreen(ByVal cnvDest As Long) As Long
'62-CBLoadString(ByVal id As Long, ByVal defaultString As String) As String
'63-CBCanvasDrawText(ByVal canvasID As Long, ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, byval isCentred as long) As Long
'64-CBCanvasPopup(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, byval stepSize as long, byval popupType as long) As Long
'65-CBCanvasWidth(ByVal canvasID As Long) As Long
'66-CBCanvasHeight(ByVal canvasID As Long) As Long
'67-CBCanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
'68-CBCanvasDrawRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
'69-CBCanvasFillRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
'70-CBCanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long) As Long
'71-CBDrawHand(ByVal pointx As Long, ByVal pointy As Long) As Long
'72-CBCheckKey(ByVal keyPressed As String) As Long
'73-CBPlaySound(ByVal soundFile As String) As Long
'74-CBMessageWindow(ByVal text As String, ByVal textColor As Long, ByVal bgColor As Long, ByVal bgPic As String, ByVal mbtype As Long) As Long
'75-CBFileDialog(ByVal initialPath As String, ByVal fileFilter As String) As String
'76-CBDetermineSpecialMoves(ByVal playerHandle As String) As Long
'77-CBGetSpecialMoveListEntry(ByVal idx As Long) As String
'78-CBRunProgram(ByVal prgFile As String)
'79-CBSetTarget(ByVal targetIdx As Long, ByVal tType As Long)
'80-CBSetSource(ByVal sourceIdx As Long, ByVal sType As Long)
'81-CBGetPlayerHP(ByVal playerIdx As Long) As Double
'82-Function CBGetPlayerMaxHP(ByVal playerIdx As Long) As Double
'83-Function CBGetPlayerSMP(ByVal playerIdx As Long) As Double
'84-Function CBGetPlayerMaxSMP(ByVal playerIdx As Long) As Double
'85-Function CBGetPlayerFP(ByVal playerIdx As Long) As Double
'86-Function CBGetPlayerDP(ByVal playerIdx As Long) As Double
'87-Function CBGetPlayerName(ByVal playerIdx As Long) As String
'88-Sub CBAddPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
'89-Sub CBAddPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
'90-Sub CBSetPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
'91-Sub CBSetPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
'92-Sub CBSetPlayerFP(ByVal amount As Long, ByVal playerIdx As Long)
'93-Sub CBSetPlayerDP(ByVal amount As Long, ByVal playerIdx As Long)
'94-Function CBGetEnemyHP(ByVal eneIdx As Long) As Long
'95-Function CBGetEnemyMaxHP(ByVal eneIdx As Long) As Long
'96-Function CBGetEnemySMP(ByVal eneIdx As Long) As Long
'97-Function CBGetEnemyMaxSMP(ByVal eneIdx As Long) As Long
'98-Function CBGetEnemyFP(ByVal eneIdx As Long) As Long
'99-Function CBGetEnemyDP(ByVal eneIdx As Long) As Long
'100-Sub CBAddEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
'101-Sub CBAddEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
'102-Sub CBSetEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
'103-Sub CBSetEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
'104-Sub CBCanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
'105-Function CBCreateAnimation(ByVal file As String) As Long
'106-Sub CBDestroyAnimation(ByVal idx As Long)
'107-Sub CBCanvasDrawAnimation(ByVal canvasID As Long, ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal forceDraw As Long)
'108-Sub CBCanvasDrawAnimationFrame(ByVal canvasID As Long, ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal forceTranspFill As Long)
'109-Function CBAnimationCurrentFrame(ByVal idx As Long) As Long
'110-Function CBAnimationMaxFrames(ByVal idx As Long) As Long
'111-Function CBAnimationSizeX(ByVal idx As Long) As Long
'112-Function CBAnimationSizeY(ByVal idx As Long) As Long
'113-Function CBAnimationFrameImage(ByVal idx As Long, ByVal frame As Long) As String
'114-Function CBGetPartySize(ByVal partyIdx As Long) As Long
'115-Function CBGetFighterHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'116-Function CBGetFighterMaxHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'117-Function CBGetFighterSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'118-Function CBGetFighterMaxSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'119-Function CBGetFighterFP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'120-Function CBGetFighterDP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'121-Function CBGetFighterName(ByVal partyIdx As Long, ByVal fighterIdx As Long) As String
'122-Function CBGetFighterAnimation(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal animationName As String) As String
'123-Function CBGetFighterChargePercent(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
'124-Sub CBFightTick()
'125-Function CBDrawTextAbsolute(ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long) As Long
'126-Sub CBReleaseFighterCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long)
'127-Function CBFightDoAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Long) As Long
'128-Sub CBFightUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
'129-Sub CBFightUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
'130-Sub CBcall processevent()
'131-Sub CBFighterAddStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
'132-Sub CBFighterRemoveStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)

Public plugtest As Long
Private specialMoveList() As String
Private plugItems() As TKItem

Public obtainedDC As Long

Function CBGetHwnd() As Long
    'obtain the hwnd of the mainForm window
    'callback 43
    On Error GoTo errorhandler

    CBGetHwnd = host.hwnd

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub BeginPlugins()
    'calls tkplugbegin for each plugin...
    On Error GoTo errorhandler
    
    'call tracestring("In BeginPlugins")
    Dim t As Long
    For t = 0 To UBound(mainMem.plugins)
        If LenB(mainMem.plugins(t)) <> 0 Then
            Dim plugName As String
            plugName = PakLocate(projectPath & plugPath & mainMem.plugins(t))

            ' ! MODIFIED BY KSNiloc...
            If isVBPlugin(plugName) Then
                Call VBPlugin(plugName).Initialize
            Else
                Call PLUGBegin(plugName)
            End If
        End If
    Next t

    'call tracestring("Done BeginPlugins")

    Exit Sub
'Begin error handling code:
errorhandler:
    'call tracestring("BeginPlugins error")
    
    Resume Next
End Sub


Function CBRefreshScreen() As Long
    'refresh the screen (redraw)
    'callback 44
    
    Call DXRefresh
End Function

Sub EndPlugins()
    'calls tkplugend for each plugin...
    On Error GoTo errorhandler
    
    Dim t As Long
    For t = 0 To UBound(mainMem.plugins)
        If LenB(mainMem.plugins(t)) <> 0 Then
            Dim plugName As String
            plugName = PakLocate(projectPath & plugPath & mainMem.plugins(t))
            ' ! MODIFIED BY KSNiloc...
            If isVBPlugin(plugName) Then
                VBPlugin(plugName).Terminate
            Else
                PLUGEnd plugName
            End If
        End If
    Next t
    
    Call PLUGShutdownSystem

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Sub generateCallbacks(cbList() As Long)
    'generate the callbacks for us...
    On Error GoTo errorhandler
    
    cbList(0) = GFXFunctionPtr(AddressOf CBRpgCode)
    cbList(1) = GFXFunctionPtr(AddressOf CBGetString)
    cbList(2) = GFXFunctionPtr(AddressOf CBGetNumerical)
    cbList(3) = GFXFunctionPtr(AddressOf CBSetString)
    cbList(4) = GFXFunctionPtr(AddressOf CBSetNumerical)
    cbList(5) = GFXFunctionPtr(AddressOf CBGetScreenDC)
    cbList(6) = GFXFunctionPtr(AddressOf CBGetScratch1DC)
    cbList(7) = GFXFunctionPtr(AddressOf CBGetScratch2DC)
    cbList(8) = GFXFunctionPtr(AddressOf CBGetMwinDC)
    cbList(9) = GFXFunctionPtr(AddressOf CBPopupMwin)
    cbList(10) = GFXFunctionPtr(AddressOf CBHideMwin)
    cbList(11) = GFXFunctionPtr(AddressOf CBLoadEnemy)
    cbList(12) = GFXFunctionPtr(AddressOf CBGetEnemyNum)
    cbList(13) = GFXFunctionPtr(AddressOf CBGetEnemyString)
    cbList(14) = GFXFunctionPtr(AddressOf CBSetEnemyNum)
    cbList(15) = GFXFunctionPtr(AddressOf CBSetEnemyString)
    cbList(16) = GFXFunctionPtr(AddressOf CBGetPlayerNum)
    cbList(17) = GFXFunctionPtr(AddressOf CBGetPlayerString)
    cbList(18) = GFXFunctionPtr(AddressOf CBSetPlayerNum)
    cbList(19) = GFXFunctionPtr(AddressOf CBSetPlayerString)
    cbList(20) = GFXFunctionPtr(AddressOf CBGetGeneralString)
    cbList(21) = GFXFunctionPtr(AddressOf CBGetGeneralNum)
    cbList(22) = GFXFunctionPtr(AddressOf CBSetGeneralString)
    cbList(23) = GFXFunctionPtr(AddressOf CBSetGeneralNum)
    cbList(24) = GFXFunctionPtr(AddressOf CBGetCommandName)
    cbList(25) = GFXFunctionPtr(AddressOf CBGetBrackets)
    cbList(26) = GFXFunctionPtr(AddressOf CBCountBracketElements)
    cbList(27) = GFXFunctionPtr(AddressOf CBGetBracketElement)
    cbList(28) = GFXFunctionPtr(AddressOf CBGetStringElementValue)
    cbList(29) = GFXFunctionPtr(AddressOf CBGetNumElementValue)
    cbList(30) = GFXFunctionPtr(AddressOf CBGetElementType)
    cbList(31) = GFXFunctionPtr(AddressOf CBDebugMessage)
    cbList(32) = GFXFunctionPtr(AddressOf CBGetPathString)
    cbList(33) = GFXFunctionPtr(AddressOf CBLoadSpecialMove)
    cbList(34) = GFXFunctionPtr(AddressOf CBGetSpecialMoveString)
    cbList(35) = GFXFunctionPtr(AddressOf CBGetSpecialMoveNum)
    cbList(36) = GFXFunctionPtr(AddressOf CBLoadItem)
    cbList(37) = GFXFunctionPtr(AddressOf CBGetItemString)
    cbList(38) = GFXFunctionPtr(AddressOf CBGetItemNum)
    cbList(39) = GFXFunctionPtr(AddressOf CBGetBoardNum)
    cbList(40) = GFXFunctionPtr(AddressOf CBGetBoardString)
    cbList(41) = GFXFunctionPtr(AddressOf CBSetBoardNum)
    cbList(42) = GFXFunctionPtr(AddressOf CBSetBoardString)
    cbList(43) = GFXFunctionPtr(AddressOf CBGetHwnd)
    cbList(44) = GFXFunctionPtr(AddressOf CBRefreshScreen)
    '3.0
    cbList(45) = GFXFunctionPtr(AddressOf CBCreateCanvas)
    cbList(46) = GFXFunctionPtr(AddressOf CBDestroyCanvas)
    cbList(47) = GFXFunctionPtr(AddressOf CBDrawCanvas)
    cbList(48) = GFXFunctionPtr(AddressOf CBDrawCanvasPartial)
    cbList(49) = GFXFunctionPtr(AddressOf CBDrawCanvasTransparent)
    cbList(50) = GFXFunctionPtr(AddressOf CBDrawCanvasTransparentPartial)
    cbList(51) = GFXFunctionPtr(AddressOf CBDrawCanvasTranslucent)
    cbList(52) = GFXFunctionPtr(AddressOf CBCanvasLoadImage)
    cbList(53) = GFXFunctionPtr(AddressOf CBCanvasLoadSizedImage)
    cbList(54) = GFXFunctionPtr(AddressOf CBCanvasFill)
    cbList(55) = GFXFunctionPtr(AddressOf CBCanvasResize)
    cbList(56) = GFXFunctionPtr(AddressOf CBCanvas2CanvasBlt)
    cbList(57) = GFXFunctionPtr(AddressOf CBCanvas2CanvasBltPartial)
    cbList(58) = GFXFunctionPtr(AddressOf CBCanvas2CanvasBltTransparent)
    cbList(59) = GFXFunctionPtr(AddressOf CBCanvas2CanvasBltTransparentPartial)
    cbList(60) = GFXFunctionPtr(AddressOf CBCanvas2CanvasBltTranslucent)
    cbList(61) = GFXFunctionPtr(AddressOf CBCanvasGetScreen)
    cbList(62) = GFXFunctionPtr(AddressOf CBLoadString)
    cbList(63) = GFXFunctionPtr(AddressOf CBCanvasDrawText)
    cbList(64) = GFXFunctionPtr(AddressOf CBCanvasPopup)
    cbList(65) = GFXFunctionPtr(AddressOf CBCanvasWidth)
    cbList(66) = GFXFunctionPtr(AddressOf CBCanvasHeight)
    cbList(67) = GFXFunctionPtr(AddressOf CBCanvasDrawLine)
    cbList(68) = GFXFunctionPtr(AddressOf CBCanvasDrawRect)
    cbList(69) = GFXFunctionPtr(AddressOf CBCanvasFillRect)
    cbList(70) = GFXFunctionPtr(AddressOf CBCanvasDrawHand)
    cbList(71) = GFXFunctionPtr(AddressOf CBDrawHand)
    cbList(72) = GFXFunctionPtr(AddressOf CBCheckKey)
    cbList(73) = GFXFunctionPtr(AddressOf CBPlaySound)
    cbList(74) = GFXFunctionPtr(AddressOf CBMessageWindow)
    cbList(75) = GFXFunctionPtr(AddressOf CBFileDialog)
    cbList(76) = GFXFunctionPtr(AddressOf CBDetermineSpecialMoves)
    cbList(77) = GFXFunctionPtr(AddressOf CBGetSpecialMoveListEntry)
    cbList(78) = GFXFunctionPtr(AddressOf CBRunProgram)
    cbList(79) = GFXFunctionPtr(AddressOf CBSetTarget)
    cbList(80) = GFXFunctionPtr(AddressOf CBSetSource)
    cbList(81) = GFXFunctionPtr(AddressOf CBGetPlayerHP)
    cbList(82) = GFXFunctionPtr(AddressOf CBGetPlayerMaxHP)
    cbList(83) = GFXFunctionPtr(AddressOf CBGetPlayerSMP)
    cbList(84) = GFXFunctionPtr(AddressOf CBGetPlayerMaxSMP)
    cbList(85) = GFXFunctionPtr(AddressOf CBGetPlayerFP)
    cbList(86) = GFXFunctionPtr(AddressOf CBGetPlayerDP)
    cbList(87) = GFXFunctionPtr(AddressOf CBGetPlayerName)
    cbList(88) = GFXFunctionPtr(AddressOf CBAddPlayerHP)
    cbList(89) = GFXFunctionPtr(AddressOf CBAddPlayerSMP)
    cbList(90) = GFXFunctionPtr(AddressOf CBSetPlayerHP)
    cbList(91) = GFXFunctionPtr(AddressOf CBSetPlayerSMP)
    cbList(92) = GFXFunctionPtr(AddressOf CBSetPlayerFP)
    cbList(93) = GFXFunctionPtr(AddressOf CBSetPlayerDP)
    cbList(94) = GFXFunctionPtr(AddressOf CBGetEnemyHP)
    cbList(95) = GFXFunctionPtr(AddressOf CBGetEnemyMaxHP)
    cbList(96) = GFXFunctionPtr(AddressOf CBGetEnemySMP)
    cbList(97) = GFXFunctionPtr(AddressOf CBGetEnemyMaxSMP)
    cbList(98) = GFXFunctionPtr(AddressOf CBGetEnemyFP)
    cbList(99) = GFXFunctionPtr(AddressOf CBGetEnemyDP)
    cbList(100) = GFXFunctionPtr(AddressOf CBAddEnemyHP)
    cbList(101) = GFXFunctionPtr(AddressOf CBAddEnemySMP)
    cbList(102) = GFXFunctionPtr(AddressOf CBSetEnemyHP)
    cbList(103) = GFXFunctionPtr(AddressOf CBSetEnemySMP)
    cbList(104) = GFXFunctionPtr(AddressOf CBCanvasDrawBackground)
    cbList(105) = GFXFunctionPtr(AddressOf CBCreateAnimation)
    cbList(106) = GFXFunctionPtr(AddressOf CBDestroyAnimation)
    cbList(107) = GFXFunctionPtr(AddressOf CBCanvasDrawAnimation)
    cbList(108) = GFXFunctionPtr(AddressOf CBCanvasDrawAnimationFrame)
    cbList(109) = GFXFunctionPtr(AddressOf CBAnimationCurrentFrame)
    cbList(110) = GFXFunctionPtr(AddressOf CBAnimationMaxFrames)
    cbList(111) = GFXFunctionPtr(AddressOf CBAnimationSizeX)
    cbList(112) = GFXFunctionPtr(AddressOf CBAnimationSizeY)
    cbList(113) = GFXFunctionPtr(AddressOf CBAnimationFrameImage)
    cbList(114) = GFXFunctionPtr(AddressOf CBGetPartySize)
    cbList(115) = GFXFunctionPtr(AddressOf CBGetFighterHP)
    cbList(116) = GFXFunctionPtr(AddressOf CBGetFighterMaxHP)
    cbList(117) = GFXFunctionPtr(AddressOf CBGetFighterSMP)
    cbList(118) = GFXFunctionPtr(AddressOf CBGetFighterMaxSMP)
    cbList(119) = GFXFunctionPtr(AddressOf CBGetFighterFP)
    cbList(120) = GFXFunctionPtr(AddressOf CBGetFighterDP)
    cbList(121) = GFXFunctionPtr(AddressOf CBGetFighterName)
    cbList(122) = GFXFunctionPtr(AddressOf CBGetFighterAnimation)
    cbList(123) = GFXFunctionPtr(AddressOf CBGetFighterChargePercent)
    cbList(124) = GFXFunctionPtr(AddressOf CBFightTick)
    cbList(125) = GFXFunctionPtr(AddressOf CBDrawTextAbsolute)
    cbList(126) = GFXFunctionPtr(AddressOf CBReleaseFighterCharge)
    cbList(127) = GFXFunctionPtr(AddressOf CBFightDoAttack)
    cbList(128) = GFXFunctionPtr(AddressOf CBFightUseItem)
    cbList(129) = GFXFunctionPtr(AddressOf CBFightUseSpecialMove)
    cbList(130) = GFXFunctionPtr(AddressOf CBDoEvents)
    cbList(131) = GFXFunctionPtr(AddressOf CBFighterAddStatusEffect)
    cbList(132) = GFXFunctionPtr(AddressOf CBFighterRemoveStatusEffect)
      
    Exit Sub

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub
Sub InitPlugins()
    'init the plugins
    'first, ask if we should use the plugins...
    'determine if game actually uses plugins...
    On Error GoTo errorhandler
    'call tracestring("In InitPlugins")
      
    'first, set up the callbacks...
    ReDim cbList(255) As Long
    Call generateCallbacks(cbList())
    ReDim plugItems(0)
    
    'array length is max index + 1
    Call PLUGInitSystem(cbList(0), 133)
    
    'call tracestring("Done InitPlugins")

    Exit Sub
'Begin error handling code:
errorhandler:
    'call tracestring("Initplugins error")
    
    Resume Next
End Sub

Public Function QueryPlugins(ByVal mName As String, ByVal Text As String, ByRef retval As RPGCODE_RETURN) As Boolean
    'mname$ is the name of a method to call.  text$ is the full command.
    'this fuction checks if a plugin can perform this command.
    'if it can, the command is performed and we return true.
    'we return false else.
    On Error GoTo errorhandler
   
    Dim t As Long
    Dim aa As Long
    For t = 0 To UBound(mainMem.plugins)
        If LenB(mainMem.plugins(t)) <> 0 Then
            Dim tt As Long
           
            Dim plugName As String
            plugName = PakLocate(projectPath & plugPath & mainMem.plugins(t))

            ' ! MODIFIED BY KSNiloc...
            If isVBPlugin(plugName) Then
                tt = VBPlugin(plugName).plugType(PT_RPGCODE)
            Else
                tt = plugType(plugName, PT_RPGCODE)
            End If
           
            If tt = 1 Then

                ' ! MODIFIED BY KSNiloc...
                If isVBPlugin(plugName) Then
                    aa = VBPlugin(plugName).Query(LCase$(mName))
                Else
                    aa = PLUGQuery(plugName, LCase$(mName$))
                End If
                If aa = 1 Then
                    'the plugin can handle the command!
                    'so, pass execution to the plugin!

                    ' ! MODIFIED BY KSNiloc...
                    If isVBPlugin(plugName) Then
                        aa = VBPlugin(plugName).Execute(Text, retval.dataType, retval.lit, retval.num, retval.usingReturnData)
                    Else
                        aa = PLUGExecute(plugName, Text$)
                    End If
                    If aa = 0 Then
                        Call debugger("Error: Plugin could not execute command!-- " + Text$)
                    End If
                    QueryPlugins = True
                    Exit Function
                End If
            End If
        End If
    Next t
   
    'couldn't do it!
    QueryPlugins = False

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Sub CBRpgCode(ByVal rpgcodeCommand As String)
    'callback to run rpgcode command
    'rpgcodeCommand is the command to run
    'this is callback 0
    On Error GoTo errorhandler
    Dim retval As RPGCODE_RETURN
    Dim vv As Long
    
    Call CanvasGetScreen(cnvRPGCodeScreen)
    vv = DoIndependentCommand(rpgcodeCommand, retval)

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetString(ByVal varname As String) As String
    'callback to obtain the contents of a string var
    'varName is the string variable (ie var$)
    'this is callback 1
    On Error GoTo errorhandler
    Dim lit As String
    Dim num As Double
    Dim a As Long
    a = getIndependentVariable(varname, lit$, num)
    CBGetString = lit$

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Function CBGetNumerical(ByVal varname As String) As Double
    'callback to obtain the contents of a numerical var
    'varName is the string variable (ie var!)
    'this is callback 2
    On Error GoTo errorhandler
    Dim lit As String
    Dim num As Double
    Dim a As Long
    a = getIndependentVariable(varname, lit$, num)
    CBGetNumerical = num

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Sub CBSetString(ByVal varname As String, ByVal newValue As String)
    'callback to set the contents of a string var
    'varName is the string variable (ie var$)
    'newValue is the new string value
    'this is callback 3
    On Error GoTo errorhandler
    Call setIndependentVariable(varname, newValue)

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Sub CBSetNumerical(ByVal varname As String, ByVal newValue As Double)
    'callback to set the contents of a numerical var
    'varName is the variable (ie var!)
    'newValue is the new value
    'this is callback 4
    On Error GoTo errorhandler
    Call setIndependentVariable(varname, CStr(newValue))

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetScreenDC() As Long
    'callback to return hdc of mainForm.boardform
    'call back 5
    On Error GoTo errorhandler

    CBGetScreenDC = host.hdc
    obtainedDC = CBGetScreenDC

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Function CBGetScratch1DC() As Long
    'callback to return hdc of mainForm.allpurpose
    'call back 6
    On Error GoTo errorhandler
    'TBD
    'CBGetScratch1DC = CanvasHDC(CreateCanvas(tilesX * 32, tilesY * 32))

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Function CBGetScratch2DC() As Long
    'callback to return hdc of allpurpose2
    'call back 7
    On Error GoTo errorhandler
    'TBD:
    'CBGetScratch2DC = CanvasHDC(CreateCanvas(tilesX * 32, tilesY * 32))

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Function CBGetMwinDC() As Long
    'callback to return hdc of messagewindow.win
    'call back 8
    On Error GoTo errorhandler
    'TBD
    'CBGetMwinDC = vbPicHDC(messagewindow.win)

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Sub CBPopupMwin()
    'callback to popup messagewindow.win
    'call back 9
    On Error GoTo errorhandler
    Call showMsgBox
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Sub CBHideMwin()
    'callback to pop down messagewindow.win
    'call back 10
    On Error GoTo errorhandler
    Call hideMsgBox
    Call renderRPGCodeScreen

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Sub CBLoadEnemy(ByVal file As String, ByVal eneSlot As Long)
    'loads an enemy into enemy slot 0-3
    'file should be *without* path info
    'callback 11
    On Error GoTo errorhandler
    eneSlot = inBounds(eneSlot, 0, 3)
    enemyMem(eneSlot) = openEnemy(projectPath$ & enePath$ & file)

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetEnemyNum(ByVal infoCode As Long, ByVal eneSlot As Long) As Long
    'get enemy info (numerical)
    'callback 12
    'eneslot is the enemy memory slot (0-3)
    'infoCode is the code of the info you want:
    '   0- hp
    '   1- max hp
    '   2- smp
    '   3- max smp
    '   4- fp
    '   5- dp
    '   6- run yn (0=no, 1=yes)
    '   7- chances of sneaking up on enemy
    '   8- chances of enemy sneaking up on you
    '   9- size x
    '   10- size y
    '   11- ai level (0= low, 1= medium, . . ., 4= very high
    '   12- experience the enemy gives you
    '   13- gp the enemy gives you.
    On Error GoTo errorhandler
    
    eneSlot = inBounds(eneSlot, 0, 3)
    Select Case infoCode
        Case 0:
            CBGetEnemyNum = enemyMem(eneSlot).eneHP
            Exit Function
        Case 1:
            CBGetEnemyNum = enemyMem(eneSlot).eneMaxHP
            Exit Function
        Case 2:
            CBGetEnemyNum = enemyMem(eneSlot).eneSMP
            Exit Function
        Case 3:
            CBGetEnemyNum = enemyMem(eneSlot).eneMaxSMP
            Exit Function
        Case 4:
            CBGetEnemyNum = enemyMem(eneSlot).eneFP
            Exit Function
        Case 5:
            CBGetEnemyNum = enemyMem(eneSlot).eneDP
            Exit Function
        Case 6:
            CBGetEnemyNum = enemyMem(eneSlot).eneRun
            Exit Function
        Case 7:
            CBGetEnemyNum = enemyMem(eneSlot).eneSneakChances
            Exit Function
        Case 8:
            CBGetEnemyNum = enemyMem(eneSlot).eneSneakUp
            Exit Function
        Case 9:
            CBGetEnemyNum = enemyMem(eneSlot).eneSizeX
            Exit Function
        Case 10:
            CBGetEnemyNum = enemyMem(eneSlot).eneSizeY
            Exit Function
        Case 11:
            CBGetEnemyNum = enemyMem(eneSlot).eneAI
            Exit Function
        Case 12:
            CBGetEnemyNum = enemyMem(eneSlot).eneExp
            Exit Function
        Case 13:
            CBGetEnemyNum = enemyMem(eneSlot).eneGP
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Function CBGetEnemyString(ByVal infoCode As Long, ByVal eneSlot As Long) As String
    'get enemy info (string)
    'callback 13
    'eneslot is the enemy memory slot (0-3)
    'infoCode is the code of the info you want:
    '   0- filename of enemy
    '   1- enemy name
    '   2- rpgcode program to run as a tactic
    '   3- program to run when enemy is defeated
    '   4- program to run when player runs away
    '   5- filename of swipe sound
    '   6- filename of sm sound
    '   7- filename of hit sound
    '   8- sound to play when enemy dies
    On Error GoTo errorhandler
    
    eneSlot = inBounds(eneSlot, 0, 3)
    Select Case infoCode
        Case 0:
            CBGetEnemyString = enemyMem(eneSlot).eneFileName$
            Exit Function
        Case 1:
            CBGetEnemyString = enemyMem(eneSlot).eneName$
            Exit Function
        Case 2:
            CBGetEnemyString = enemyMem(eneSlot).eneRPGCode$
            Exit Function
        Case 3:
            CBGetEnemyString = enemyMem(eneSlot).eneWinPrg$
            Exit Function
        Case 4:
            CBGetEnemyString = enemyMem(eneSlot).eneRunPrg$
            Exit Function
        Case 5:
            CBGetEnemyString = enemyMem(eneSlot).eneSwipeSound$
            Exit Function
        Case 6:
            CBGetEnemyString = enemyMem(eneSlot).eneSMSound$
            Exit Function
        Case 7:
            CBGetEnemyString = enemyMem(eneSlot).eneHitSound$
            Exit Function
        Case 8:
            CBGetEnemyString = enemyMem(eneSlot).eneDieSound$
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBSetEnemyNum(ByVal infoCode As Long, ByVal newValue As Long, ByVal eneSlot As Long)
    'set enemy info (numerical)
    'callback 14
    'eneslot is the enemy memory slot (0-3)
    'newValue is the new value to set
    'infoCode is the code of the info you want:
    'same as CBGetEnemyNum
    On Error GoTo errorhandler
    
    eneSlot = inBounds(eneSlot, 0, 3)
    Select Case infoCode
        Case 0:
            enemyMem(eneSlot).eneHP = newValue
            Exit Sub
        Case 1:
            enemyMem(eneSlot).eneMaxHP = newValue
            Exit Sub
        Case 2:
            enemyMem(eneSlot).eneSMP = newValue
            Exit Sub
        Case 3:
            enemyMem(eneSlot).eneMaxSMP = newValue
            Exit Sub
        Case 4:
            enemyMem(eneSlot).eneFP = newValue
            Exit Sub
        Case 5:
            enemyMem(eneSlot).eneDP = newValue
            Exit Sub
        Case 6:
            enemyMem(eneSlot).eneRun = newValue
            Exit Sub
        Case 7:
            enemyMem(eneSlot).eneSneakChances = newValue
            Exit Sub
        Case 8:
            enemyMem(eneSlot).eneSneakUp = newValue
            Exit Sub
        Case 9:
            enemyMem(eneSlot).eneSizeX = newValue
            Exit Sub
        Case 10:
            enemyMem(eneSlot).eneSizeY = newValue
            Exit Sub
        Case 11:
            enemyMem(eneSlot).eneAI = newValue
            Exit Sub
        Case 12:
            enemyMem(eneSlot).eneExp = newValue
            Exit Sub
        Case 13:
            enemyMem(eneSlot).eneGP = newValue
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Sub CBSetEnemyString(ByVal infoCode As Long, ByVal newValue As String, ByVal eneSlot As Long)
    'set enemy info (string)
    'callback 15
    'eneslot is the enemy memory slot (0-3)
    'newValue is the new value to set
    'infoCode is the code of the info you want:
    'same as CBGetEnemyString
    On Error GoTo errorhandler
    
    eneSlot = inBounds(eneSlot, 0, 3)
    Select Case infoCode
        Case 0:
            enemyMem(eneSlot).eneFileName$ = newValue
            Exit Sub
        Case 1:
            enemyMem(eneSlot).eneName$ = newValue
            Exit Sub
        Case 2:
            enemyMem(eneSlot).eneRPGCode$ = newValue
            Exit Sub
        Case 3:
            enemyMem(eneSlot).eneWinPrg$ = newValue
            Exit Sub
        Case 4:
            enemyMem(eneSlot).eneRunPrg$ = newValue
            Exit Sub
        Case 5:
            enemyMem(eneSlot).eneSwipeSound$ = newValue
            Exit Sub
        Case 6:
            enemyMem(eneSlot).eneSMSound$ = newValue
            Exit Sub
        Case 7:
            enemyMem(eneSlot).eneHitSound$ = newValue
            Exit Sub
        Case 8:
            enemyMem(eneSlot).eneDieSound$ = newValue
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
    'get player info (numerical)
    'callback 16
    'playerSlot is the player memory slot (0-4)
    'arraypos is a supporting value used by only some calls.  It indicates the positon in an array to obtain.
    'infoCode is the code of the info you want:
    '   0- init experience
    '   1- init health
    '   2- init max HP
    '   3- init DP
    '   4- init FP
    '   5- init SMP
    '   6- init Max SMP
    '   7- init Level
    '   8- does he do special moves? (0=NO, 1=YES)  (the return value is opposite of the actual value here in memory)
    '   9- min expericne requd for each move (also requires arrayPos 0-200)
    '   10- min level for each move (also requires arrayPos 0-200)
    '   11- is armortype used (0=n, 1=y) (also requires arrayPos 0-6: 1=head, 2=neck, 3=left hand, 4=right hand, 5=body, 6=legs)
    '   12- initial level progression
    '   13- experience increase factor
    '   14- max level
    '   15- hp increase on level up
    '   16- dp increase on level up
    '   17- fp increase on level up
    '   18- smp increase on level up
    '   19- level up type 0=exponential, 1=linear
    '   20- direction we are facing (1-s, 2-w, 3-n, 4-e)    facing
    '   21- percent till next level
    On Error Resume Next
    Dim Temp As Long

    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            CBGetPlayerNum = playerMem(playerSlot).initExperience
            Exit Function
        Case 1:
            CBGetPlayerNum = playerMem(playerSlot).initHealth
            Exit Function
        Case 2:
            CBGetPlayerNum = playerMem(playerSlot).initMaxHealth
            Exit Function
        Case 3:
            CBGetPlayerNum = playerMem(playerSlot).initDefense
            Exit Function
        Case 4:
            CBGetPlayerNum = playerMem(playerSlot).initFight
            Exit Function
        Case 5:
            CBGetPlayerNum = playerMem(playerSlot).initSm
            Exit Function
        Case 6:
            CBGetPlayerNum = playerMem(playerSlot).initSmMax
            Exit Function
        Case 7:
            CBGetPlayerNum = playerMem(playerSlot).initLevel
            Exit Function
        Case 8:
            Temp = playerMem(playerSlot).smYN
            If Temp = 0 Then CBGetPlayerNum = 1
            If Temp = 1 Then CBGetPlayerNum = 0
            Exit Function
        Case 9:
            arrayPos = inBounds(arrayPos, 0, 200)
            CBGetPlayerNum = playerMem(playerSlot).spcMinExp(arrayPos)
            Exit Function
        Case 10:
            arrayPos = inBounds(arrayPos, 0, 200)
            CBGetPlayerNum = playerMem(playerSlot).spcMinLevel(arrayPos)
            Exit Function
        Case 11:
            arrayPos = inBounds(arrayPos, 0, 6)
            CBGetPlayerNum = playerMem(playerSlot).armorType(arrayPos)
            Exit Function
        Case 12:
            CBGetPlayerNum = playerMem(playerSlot).levelType
            Exit Function
        Case 13:
            CBGetPlayerNum = playerMem(playerSlot).experienceIncrease
            Exit Function
        Case 14:
            CBGetPlayerNum = playerMem(playerSlot).maxLevel
            Exit Function
        Case 15:
            CBGetPlayerNum = playerMem(playerSlot).levelHp
            Exit Function
        Case 16:
            CBGetPlayerNum = playerMem(playerSlot).levelDp
            Exit Function
        Case 17:
            CBGetPlayerNum = playerMem(playerSlot).levelFp
            Exit Function
        Case 18:
            CBGetPlayerNum = playerMem(playerSlot).levelSm
            Exit Function
        Case 19:
            CBGetPlayerNum = playerMem(playerSlot).charLevelUpType
            Exit Function
        Case 20:
            'direction facing...
            CBGetPlayerNum = facing
            Exit Function
        Case 21:
            With playerMem(playerSlot)
                Dim levStart As Long, perc As Long
                levStart = .levelStarts(CBGetNumerical(.leVar) - 1)
                perc = (CBGetNumerical(.experienceVar) - levStart) / (.nextLevel - levStart) * 100
                CBGetPlayerNum = perc
            End With
    End Select

End Function

Function CBGetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As String
    'get player info (string)
    'callback 17
    'playerSlot is the player memory slot (0-4)
    'arraypos is a supporting value used by only some calls.  It indicates the positon in an array to obtain.
    'infoCode is the code of the info you want:
    '   0- character name
    '   1- experience variable
    '   2- defense var
    '   3- fight var
    '   4- health var
    '   5- max hp var
    '   6- name var
    '   7- smp var
    '   8- max smp var
    '   9- level var
    '   10- profile picture filename
    '   11- special move filename array (requires arrayPos 0-200)
    '   12- special move name (what special moves are called in the fight menu)
    '   13- conditional vars for each special move (requires arrayPos 0-200)
    '   14- conditional variable equality for each special move (requires arrayPos 0-200)
    '   15- accessory names (requires arrayPos 0-10)
    '   16- sword swipe sound
    '   17- defense sound
    '   18- special move sound
    '   19- death sound
    '   20- rpgcode program to run on level up
    On Error GoTo errorhandler
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            CBGetPlayerString = playerMem(playerSlot).charname$
            Exit Function
        Case 1:
            CBGetPlayerString = playerMem(playerSlot).experienceVar$
            Exit Function
        Case 2:
            CBGetPlayerString = playerMem(playerSlot).defenseVar$
            Exit Function
        Case 3:
            CBGetPlayerString = playerMem(playerSlot).fightVar$
            Exit Function
        Case 4:
            CBGetPlayerString = playerMem(playerSlot).healthVar$
            Exit Function
        Case 5:
            CBGetPlayerString = playerMem(playerSlot).maxHealthVar$
            Exit Function
        Case 6:
            CBGetPlayerString = playerMem(playerSlot).nameVar$
            Exit Function
        Case 7:
            CBGetPlayerString = playerMem(playerSlot).smVar$
            Exit Function
        Case 8:
            CBGetPlayerString = playerMem(playerSlot).smMaxVar$
            Exit Function
        Case 9:
            CBGetPlayerString = playerMem(playerSlot).leVar$
            Exit Function
        Case 10:
            CBGetPlayerString = playerMem(playerSlot).profilePic$
            Exit Function
        Case 11:
            arrayPos = inBounds(arrayPos, 0, 200)
            CBGetPlayerString = playerMem(playerSlot).smlist$(arrayPos)
            Exit Function
        Case 12:
            CBGetPlayerString = playerMem(playerSlot).specialMoveName$
            Exit Function
        Case 13:
            arrayPos = inBounds(arrayPos, 0, 200)
            CBGetPlayerString = playerMem(playerSlot).spcVar$(arrayPos)
            Exit Function
        Case 14:
            arrayPos = inBounds(arrayPos, 0, 200)
            CBGetPlayerString = playerMem(playerSlot).spcEquals$(arrayPos)
            Exit Function
        Case 15:
            arrayPos = inBounds(arrayPos, 0, 10)
            CBGetPlayerString = playerMem(playerSlot).accessoryName$(arrayPos)
            Exit Function
        Case 16:
            CBGetPlayerString = vbNullString 'playerMem(playerSlot).swipeWav$
            Exit Function
        Case 17:
            CBGetPlayerString = vbNullString 'playerMem(playerSlot).defendWav$
            Exit Function
        Case 18:
            CBGetPlayerString = vbNullString 'playerMem(playerSlot).smWav$
            Exit Function
        Case 19:
            CBGetPlayerString = vbNullString 'playerMem(playerSlot).deadWav$
            Exit Function
        Case 20:
            CBGetPlayerString = playerMem(playerSlot).charLevelUpRPGCode$
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBSetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As Long, ByVal playerSlot As Long)
    'set player info (numerical)
    'callback 18
    'playerSlot is the player memory slot (0-4)
    'arraypos is a supporting value used by only some calls.  It indicates the positon in an array to obtain.
    'infoCode is the code of the info you want:
    'same as CBGetPlayerNum above
    On Error GoTo errorhandler
    
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            playerMem(playerSlot).initExperience = newVal
            Exit Sub
        Case 1:
            playerMem(playerSlot).initHealth = newVal
            Exit Sub
        Case 2:
            playerMem(playerSlot).initMaxHealth = newVal
            Exit Sub
        Case 3:
            playerMem(playerSlot).initDefense = newVal
            Exit Sub
        Case 4:
            playerMem(playerSlot).initFight = newVal
            Exit Sub
        Case 5:
            playerMem(playerSlot).initSm = newVal
            Exit Sub
        Case 6:
            playerMem(playerSlot).initSmMax = newVal
            Exit Sub
        Case 7:
            playerMem(playerSlot).initLevel = newVal
            Exit Sub
        Case 8:
            If newVal = 0 Then playerMem(playerSlot).smYN = 1
            If newVal = 1 Then playerMem(playerSlot).smYN = 0
            Exit Sub
        Case 9:
            arrayPos = inBounds(arrayPos, 0, 200)
            playerMem(playerSlot).spcMinExp(arrayPos) = newVal
            Exit Sub
        Case 10:
            arrayPos = inBounds(arrayPos, 0, 200)
            playerMem(playerSlot).spcMinLevel(arrayPos) = newVal
            Exit Sub
        Case 11:
            arrayPos = inBounds(arrayPos, 0, 6)
            playerMem(playerSlot).armorType(arrayPos) = newVal
            Exit Sub
        Case 12:
            playerMem(playerSlot).levelType = newVal
            Exit Sub
        Case 13:
            playerMem(playerSlot).experienceIncrease = newVal
            Exit Sub
        Case 14:
            playerMem(playerSlot).maxLevel = newVal
            Exit Sub
        Case 15:
            playerMem(playerSlot).levelHp = newVal
            Exit Sub
        Case 16:
            playerMem(playerSlot).levelDp = newVal
            Exit Sub
        Case 17:
            playerMem(playerSlot).levelFp = newVal
            Exit Sub
        Case 18:
            playerMem(playerSlot).levelSm = newVal
            Exit Sub
        Case 19:
            playerMem(playerSlot).charLevelUpType = newVal
            Exit Sub
        Case 20:
            newVal = inBounds(newVal, 1, 4)
            facing = newVal
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub


Sub CBSetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As String, ByVal playerSlot As Long)
    'set player info (string)
    'callback 19
    'playerSlot is the player memory slot (0-4)
    'arraypos is a supporting value used by only some calls.  It indicates the positon in an array to obtain.
    'infoCode is the code of the info you want:
    'same as CBGetPlayerString above
    On Error GoTo errorhandler
    
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            playerMem(playerSlot).charname$ = newVal
            Exit Sub
        Case 1:
            playerMem(playerSlot).experienceVar$ = newVal
            Exit Sub
        Case 2:
            playerMem(playerSlot).defenseVar$ = newVal
            Exit Sub
        Case 3:
            playerMem(playerSlot).fightVar$ = newVal
            Exit Sub
        Case 4:
            playerMem(playerSlot).healthVar$ = newVal
            Exit Sub
        Case 5:
            playerMem(playerSlot).maxHealthVar$ = newVal
            Exit Sub
        Case 6:
            playerMem(playerSlot).nameVar$ = newVal
            Exit Sub
        Case 7:
            playerMem(playerSlot).smVar$ = newVal
            Exit Sub
        Case 8:
            playerMem(playerSlot).smMaxVar$ = newVal
            Exit Sub
        Case 9:
            playerMem(playerSlot).leVar$ = newVal
            Exit Sub
        Case 10:
            playerMem(playerSlot).profilePic$ = newVal
            Exit Sub
        Case 11:
            arrayPos = inBounds(arrayPos, 0, 200)
            playerMem(playerSlot).smlist$(arrayPos) = newVal
            Exit Sub
        Case 12:
            playerMem(playerSlot).specialMoveName$ = newVal
            Exit Sub
        Case 13:
            arrayPos = inBounds(arrayPos, 0, 200)
            playerMem(playerSlot).spcVar$(arrayPos) = newVal
            Exit Sub
        Case 14:
            arrayPos = inBounds(arrayPos, 0, 200)
            playerMem(playerSlot).spcEquals$(arrayPos) = newVal
            Exit Sub
        Case 15:
            arrayPos = inBounds(arrayPos, 0, 10)
            playerMem(playerSlot).accessoryName$(arrayPos) = newVal
            Exit Sub
        Case 16:
            'playerMem(playerSlot).swipeWav$ = newVal
            Exit Sub
        Case 17:
            'playerMem(playerSlot).defendWav$ = newVal
            Exit Sub
        Case 18:
            'playerMem(playerSlot).smWav$ = newVal
            Exit Sub
        Case 19:
            'playerMem(playerSlot).deadWav$ = newVal
            Exit Sub
        Case 20:
            playerMem(playerSlot).charLevelUpRPGCode$ = newVal
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub


Function CBGetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As String
    'get general info (string)
    'callback 20
    'infoCode is the code of the info we want.
    'arrayPos is the optional array position to obtain (some codes only)
    'playerSlot is the optional player slot to obtain (0-4) (some codes only)
    'infoCodes:
    '   0-  player handles (requires playerslot 0-4)    playerListAr$
    '   1-  player filenames (requires playerslot 0-4)  playerfile$
    '   2-  filenames of other players (requires arrayPos 0-25) otherPlayers$
    '   3-  handles of other players (requires arrayPos 0-25)   otherPlayerHandles$
    '   4-  filenames of items in inventory (requires arrayPos 0-500)   inventory$
    '   5-  handles of items in inventory (arrayPos 0-500)              itemListAr$
    '   6-  filename of equipment on each player (arraypos 0-16, playerslot 0-4)    playerequip$
    '   7-  handles of items equipped on players (arraypos 0-16, playerslot 0-4)    EquipList$
    '   8-  currently playing music     musicplaying$
    '   9-  current board               currentboard$
    '   10- filename of menu graphic    menugraphic$
    '   11- filename of fight menu graphic  fightmenugraphic$
    '   12- filename of picture in message window   MWinPic$
    '   13- filename of font                fontname$
    '   14- filename of loaded enemies (playerSlot 0-3)     enemies$
    '   15- filename of program to win on fight victory (playerSlot 0-3)  programsWin$
    '   16- filename of status effects applied to enemies (arrayPos 0-10, playerSlot 0-3)  enemyStatus$
    '   17- filename of status effects applied to players (arrayPos 0-10, playerSlot 0-4)  playerStatus$
    '   18- filename of cursor movement sound (mainMem.cursormovesound)
    '   19- filename of cursor selection sound (mainMem.cursorselectsound)
    '   20- filename of cursor cancel sound (mainMem.cursorcancelsound)
    On Error GoTo errorhandler
    
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            CBGetGeneralString = playerListAr$(playerSlot)
            Exit Function
        Case 1:
            CBGetGeneralString = playerFile$(playerSlot)
            Exit Function
        Case 2:
            arrayPos = inBounds(arrayPos, 0, 25)
            CBGetGeneralString = otherPlayers$(arrayPos)
            Exit Function
        Case 3:
            arrayPos = inBounds(arrayPos, 0, 25)
            CBGetGeneralString = otherPlayersHandle$(arrayPos)
            Exit Function
        Case 4:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            CBGetGeneralString = inv.fileNames(arrayPos)
            Exit Function
        Case 5:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            CBGetGeneralString = inv.handles(arrayPos)
            Exit Function
        Case 6:
            arrayPos = inBounds(arrayPos, 0, 16)
            CBGetGeneralString = playerEquip$(arrayPos, playerSlot)
            Exit Function
        Case 7:
            arrayPos = inBounds(arrayPos, 0, 16)
            CBGetGeneralString = equipList$(arrayPos, playerSlot)
            Exit Function
        Case 8:
            CBGetGeneralString = musicPlaying$
            Exit Function
        Case 9:
            CBGetGeneralString = currentBoard$
            Exit Function
        Case 10:
            CBGetGeneralString = menuGraphic$
            Exit Function
        Case 11:
            CBGetGeneralString = fightMenuGraphic$
            Exit Function
        Case 12:
            CBGetGeneralString = MWinPic$
            Exit Function
        Case 13:
            CBGetGeneralString = fontName$
            Exit Function
        Case 14:
            playerSlot = inBounds(playerSlot, 0, 3)
            CBGetGeneralString = enemies$(playerSlot)
            Exit Function
        Case 15:
            playerSlot = inBounds(playerSlot, 0, 3)
            CBGetGeneralString = enemyMem(playerSlot).eneWinPrg
            Exit Function
        Case 16:
            playerSlot = inBounds(playerSlot, 0, 3)
            CBGetGeneralString = enemyMem(playerSlot).status(arrayPos).statusFile
            Exit Function
        Case 17:
            CBGetGeneralString = playerMem(playerSlot).status(arrayPos).statusFile
            Exit Function
        Case 18:
            CBGetGeneralString = mainMem.cursorMoveSound
            Exit Function
        Case 19:
            CBGetGeneralString = mainMem.cursorSelectSound
            Exit Function
        Case 20:
            CBGetGeneralString = mainMem.cursorCancelSound
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
    'get general info (num)
    'callback 21
    'infoCode is the code of the info we want.
    'arrayPos is the optional array position to obtain (some codes only)
    'playerSlot is the optional player slot to obtain (0-4) (some codes only)
    'infoCodes:
    '   0-  number of each item in inventory (arrayPos 0-500)   NumberItem
    '   1-  amount of hp added to player by equipment (playerslot 0-4)  equipHPadd
    '   2-  amount of smp added to player by equipment (playerslot 0-4)  equipSMadd
    '   3-  amount of dp added to player by equipment (playerslot 0-4)  equipDPadd
    '   4-  amount of fp added to player by equipment (playerslot 0-4)  equipFPadd
    '   5-  current player x pos (playerslot 0-4)   curx
    '   6-  current player y pos (playerslot 0-4)   cury
    '   7-  current player layer pos (playerslot 0-4)   curlayer
    '   8-  currently selected player (returns 0-4) selectedplayer
    '   9-  size of screen x (in tiles) tilesx
    '   10-  size of screen y (in tiles)    tilesy
    '   11-  current battle speed (returns 0=slow -> 8=fast)    BattleSpeed
    '   12-  current text speed (returns 0=slow -> 3=fast)     TextSpeed
    '   13-  current character speed (returns 0=slow -> 3=fast) CharacterSpeed
    '   14-  is scrolling turned off? 0=no, 1=yes   scrollingOff
    '   15-  x resolution, in pixels    resx
    '   16-  y resolution, in pixels    resy
    '   17-  gp carried by player   gpcount
    '   18-  color of font (rgb value)  fontcolor
    '   19-  time spent in previuously loaded game  addtime
    '   20-  time at start of game  inittime
    '   21-  length of game, in seconds gametime
    '   22-  number of steps taken  stepstaken
    '   23-  can we run from the currently loaded enemies? 0=no, 1=yes  canrun
    '   24-  x location of each enemy (playerSlot 0-3)  eneX
    '   25-  y location of each enemy (playerSlot 0-3)  eneY
    '   26-  fighting window x offset, in tiles fwOffsetX
    '   27-  fighting window y offset, in tiles fwOffsetY
    '   28-  transparent color (gTranspColor)
    On Error GoTo errorhandler
    
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            CBGetGeneralNum = inv.quantities(arrayPos)
            Exit Function
        Case 1:
            CBGetGeneralNum = equipHPadd(playerSlot)
            Exit Function
        Case 2:
            CBGetGeneralNum = equipSMadd(playerSlot)
            Exit Function
        Case 3:
            CBGetGeneralNum = equipDPadd(playerSlot)
            Exit Function
        Case 4:
            CBGetGeneralNum = equipFPadd(playerSlot)
            Exit Function
        Case 5:
            CBGetGeneralNum = pPos(playerSlot).x
            Exit Function
        Case 6:
            CBGetGeneralNum = pPos(playerSlot).y
            Exit Function
        Case 7:
            CBGetGeneralNum = pPos(playerSlot).l
            Exit Function
        Case 8:
            CBGetGeneralNum = selectedPlayer
            Exit Function
        Case 9:
            CBGetGeneralNum = tilesX
            Exit Function
        Case 10:
            CBGetGeneralNum = tilesY
            Exit Function
        Case 11:
            CBGetGeneralNum = 0
            Exit Function
        Case 12:
            CBGetGeneralNum = 0
            Exit Function
        Case 13:
            CBGetGeneralNum = 0
            Exit Function
        Case 14:
            CBGetGeneralNum = 0 'scrollingOff
            Exit Function
        Case 15:
            CBGetGeneralNum = resX
            Exit Function
        Case 16:
            CBGetGeneralNum = resY
            Exit Function
        Case 17:
            CBGetGeneralNum = GPCount
            Exit Function
        Case 18:
            CBGetGeneralNum = fontColor
            Exit Function
        Case 19:
            CBGetGeneralNum = addTime
            Exit Function
        Case 20:
            CBGetGeneralNum = initTime
            Exit Function
        Case 21:
            CBGetGeneralNum = gameTime
            Exit Function
        Case 22:
            CBGetGeneralNum = stepsTaken
            Exit Function
        Case 23:
            CBGetGeneralNum = canrun
            Exit Function
        Case 24:
            playerSlot = inBounds(playerSlot, 0, 3)
            CBGetGeneralNum = enemyMem(playerSlot).x
            Exit Function
        Case 25:
            playerSlot = inBounds(playerSlot, 0, 3)
            CBGetGeneralNum = enemyMem(playerSlot).y
            Exit Function
        Case 26:
            CBGetGeneralNum = 0
            Exit Function
        Case 27:
            CBGetGeneralNum = 0
            Exit Function
        Case 28:
            CBGetGeneralNum = TRANSP_COLOR
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBSetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As String)
    'set general info (string)
    'callback 22
    'infoCode is the code of the info we want.
    'arrayPos is the optional array position to obtain (some codes only)
    'playerSlot is the optional player slot to obtain (0-4) (some codes only)
    'infoCodes same as CBGetGeneralString
    On Error GoTo errorhandler
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            playerListAr$(playerSlot) = newVal
            Exit Sub
        Case 1:
            playerFile$(playerSlot) = newVal
            Call openChar(projectPath & temPath & newVal, playerMem(playerSlot))
            Exit Sub
        Case 2:
            arrayPos = inBounds(arrayPos, 0, 25)
            otherPlayers$(arrayPos) = newVal
            Exit Sub
        Case 3:
            arrayPos = inBounds(arrayPos, 0, 25)
            otherPlayersHandle$(arrayPos) = newVal
            Exit Sub
        Case 4:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            inv.fileNames(arrayPos) = newVal
            Exit Sub
        Case 5:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            inv.handles(arrayPos) = newVal
            Exit Sub
        Case 6:
            arrayPos = inBounds(arrayPos, 0, 16)
            playerEquip$(arrayPos, playerSlot) = newVal
            Exit Sub
        Case 7:
            arrayPos = inBounds(arrayPos, 0, 16)
            equipList$(arrayPos, playerSlot) = newVal
            Exit Sub
        Case 8:
            'musicplaying$ = newVal
            boardList(activeBoardIndex).theData.boardMusic$ = newVal
            Call checkMusic
            Exit Sub
        Case 9:
            Call openBoard(projectPath$ & brdPath$ & newVal, boardList(activeBoardIndex).theData)
            'clear non-persistent threads...
            Call ClearNonPersistentThreads
            lastRender.canvas = -1
            scTopX = -1
            scTopY = -1
            Call renderNow
            wentToNewBoard = True
            currentBoard$ = newVal
            Exit Sub
        Case 10:
            menuGraphic$ = newVal
            Exit Sub
        Case 11:
            fightMenuGraphic$ = newVal
            Exit Sub
        Case 12:
            MWinPic$ = newVal
            Exit Sub
        Case 13:
            Call loadFont(projectPath & fontPath & newVal)
            fontName$ = newVal
            Exit Sub
        Case 14:
            playerSlot = inBounds(playerSlot, 0, 3)
            enemyMem(playerSlot) = openEnemy(projectPath$ & enePath$ & newVal)
            enemies$(playerSlot) = newVal
            Exit Sub
        Case 15:
            playerSlot = inBounds(playerSlot, 0, 3)
            enemyMem(playerSlot).eneWinPrg = newVal
            Exit Sub
        Case 16:
            playerSlot = inBounds(playerSlot, 0, 3)
            enemyMem(playerSlot).status(arrayPos).statusFile = newVal
            Exit Sub
        Case 17:
            playerMem(playerSlot).status(arrayPos).statusFile = newVal
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub


Sub CBSetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As Long)
    'get general info (num)
    'callback 23
    'infoCode is the code of the info we want.
    'arrayPos is the optional array position to obtain (some codes only)
    'playerSlot is the optional player slot to obtain (0-4) (some codes only)
    'infoCodes same as CBGetGeneralNum
    On Error GoTo errorhandler
    playerSlot = inBounds(playerSlot, 0, 4)
    Select Case infoCode
        Case 0:
            arrayPos = inBounds(arrayPos, 0, inv.upperBound())
            inv.quantities(arrayPos) = newVal
            Exit Sub
        Case 1:
            equipHPadd(playerSlot) = newVal
            Exit Sub
        Case 2:
            equipSMadd(playerSlot) = newVal
            Exit Sub
        Case 3:
            equipDPadd(playerSlot) = newVal
            Exit Sub
        Case 4:
            equipFPadd(playerSlot) = newVal
            Exit Sub
        Case 5:
            pPos(playerSlot).x = newVal
            Exit Sub
        Case 6:
            pPos(playerSlot).y = newVal
            Exit Sub
        Case 7:
            pPos(playerSlot).l = newVal
            Exit Sub
        Case 8:
            newVal = inBounds(newVal, 0, 4)
            selectedPlayer = newVal
            Exit Sub
        Case 9:
            tilesX = newVal
            Exit Sub
        Case 10:
            tilesY = newVal
            Exit Sub
        Case 11:
            newVal = inBounds(newVal, 0, 8)
            'BattleSpeed = newVal
            Exit Sub
        Case 12:
            newVal = inBounds(newVal, 0, 3)
            'TextSpeed = newVal
            Exit Sub
        Case 13:
            newVal = inBounds(newVal, 0, 3)
            'CharacterSpeed = newVal
            Exit Sub
        Case 14:
            newVal = inBounds(newVal, 0, 1)
            'scrollingOff = newVal
            Exit Sub
        Case 15:
            resX = newVal
            Exit Sub
        Case 16:
            resY = newVal
            Exit Sub
        Case 17:
            GPCount = newVal
            Exit Sub
        Case 18:
            fontColor = newVal
            Exit Sub
        Case 19:
            addTime = newVal
            Exit Sub
        Case 20:
            initTime = newVal
            Exit Sub
        Case 21:
            gameTime = newVal
            Exit Sub
        Case 22:
            stepsTaken = newVal
            Exit Sub
        Case 23:
            newVal = inBounds(newVal, 0, 1)
            canrun = newVal
            Exit Sub
        Case 24:
            playerSlot = inBounds(playerSlot, 0, 3)
            enemyMem(playerSlot).x = newVal
            Exit Sub
        Case 25:
            playerSlot = inBounds(playerSlot, 0, 3)
            enemyMem(playerSlot).x = newVal
            Exit Sub
        Case 26:
            'fwOffsetX = newVal
            Exit Sub
        Case 27:
            'fwOffsetY = newVal
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetCommandName(ByVal rpgcodeCommand As String) As String
    'callback 24
    'calls GetCommandName
    'splices the command name out of the string sent in (assuming the
    'string is an rpgcode command)
    'ie #Test(lala) returns "Test"
    On Error Resume Next
    CBGetCommandName = LCase$(GetCommandName(rpgcodeCommand))
End Function


Function CBGetBrackets(ByVal rpgcodeCommand As String) As String
    'callback 25
    'calls GetBrackets
    'splices the bracket contents out of the string sent in (assuming the
    'string is an rpgcode command)
    'ie #Test(lala) returns "lala"
    On Error GoTo errorhandler
    CBGetBrackets = GetBrackets(rpgcodeCommand)

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBCountBracketElements(ByVal rpgcodeCommand As String) As Long
    'callback 26
    'calls CountData
    'returns the number of elements that had been
    'in the bracketed data (spliced out with CBGetBrackets)
    'ie "joey", 14, 12 returns 3
    On Error GoTo errorhandler
    CBCountBracketElements = CountData(rpgcodeCommand)

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetBracketElement(ByVal rpgcodeCommand As String, ByVal elemNum As Long) As String
    'callback 27
    'calls GetElement
    'returns the ith elements from the bracketed data
    'ie ""joey", 14, 12", 2 returns "14"
    On Error GoTo errorhandler
    CBGetBracketElement = GetElement(rpgcodeCommand, elemNum)

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetStringElementValue(ByVal rpgcodeCommand As String) As String
    'callback 28
    'calls GetValue (assuming string)
    'returns the value of one of the elements from the brackets.
    'if the element is a string variable, it returns the contents
    'of the variable.  if it's a string constant, it returns the
    'constant.
    On Error GoTo errorhandler
    Dim lit As String
    Dim num As Double
    Dim a As Long
    Dim aProgram As RPGCodeProgram
    ReDim aProgram.program(10)
    aProgram.boardNum = -1
    a = getValue(rpgcodeCommand, lit$, num, aProgram)
    CBGetStringElementValue = lit$

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetNumElementValue(ByVal rpgcodeCommand As String) As Double
    'callback 29
    'calls GetValue (assuming number)
    'returns the value of one of the elements from the brackets.
    'if the element is a num variable, it returns the contents
    'of the variable.  if it's a num constant, it returns the
    'constant.
    On Error GoTo errorhandler
    Dim lit As String
    Dim num As Double
    Dim a As Long
    Dim aProgram As RPGCodeProgram
    ReDim aProgram.program(10)
    aProgram.boardNum = -1
    a = getValue(rpgcodeCommand, lit$, num, aProgram)
    CBGetNumElementValue = num

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetElementType(ByVal rpgcodeCommand As String) As Long
    'callback 30
    'calls GetValue (to determine type)
    'returns 0 if the element is evaluated to be a num
    'returns 1 if the element is evaluated to be a lit
    On Error GoTo errorhandler
    Dim lit As String
    Dim num As Double
    Dim aProgram As RPGCodeProgram
    ReDim aProgram.program(10)
    aProgram.boardNum = -1
    CBGetElementType = getValue(rpgcodeCommand, lit$, num, aProgram)

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBDebugMessage(ByVal message As String)
    'callback 31
    'calls debugger function to display text in debug window
    On Error GoTo errorhandler
    Call debugger(message)

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

Function CBGetPathString(ByVal infoCode As Long) As String
    'get the name of a path
    'callback 32
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  tile path (tilepath$)
    '   1-  board path (brdpath$)
    '   2-  character path (tempath$)
    '   3-  special move path (spcpath$)
    '   4-  background path (bkgpath$)
    '   5-  media path (mediapath$)
    '   6-  program path (prgpath$)
    '   7-  font path (fontpath$)
    '   8-  item path (itmpath$)
    '   9-  enemy path (enepath$)
    '   10-  mainForm file path (gampath$)
    '   11-  bitmap path (bmppath$)
    '   12-  status effect path (statuspath$)
    '   13-  misc path (miscpath$)
    '   14-  save path (savpath$)
    '   15-  project path (projectpath$)
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            CBGetPathString = tilePath$
            Exit Function
        Case 1:
            CBGetPathString = brdPath$
            Exit Function
        Case 2:
            CBGetPathString = temPath$
            Exit Function
        Case 3:
            CBGetPathString = spcPath$
            Exit Function
        Case 4:
            CBGetPathString = bkgPath$
            Exit Function
        Case 5:
            CBGetPathString = mediaPath$
            Exit Function
        Case 6:
            CBGetPathString = prgPath$
            Exit Function
        Case 7:
            CBGetPathString = fontPath$
            Exit Function
        Case 8:
            CBGetPathString = itmPath$
            Exit Function
        Case 9:
            CBGetPathString = enePath$
            Exit Function
        Case 10:
            CBGetPathString = gamPath$
            Exit Function
        Case 11:
            CBGetPathString = bmpPath$
            Exit Function
        Case 12:
            CBGetPathString = statusPath$
            Exit Function
        Case 13:
            CBGetPathString = miscPath$
            Exit Function
        Case 14:
            CBGetPathString = savPath$
            Exit Function
        Case 15:
            CBGetPathString = projectPath$
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBLoadSpecialMove(ByVal file As String)
    'load a special move
    'callback 33
    On Error GoTo errorhandler
    specialMoveMem = openSpecialMove(projectPath$ & spcPath$ & file)

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub


Function CBGetSpecialMoveString(ByVal infoCode As Long) As String
    'get special move info (string)
    'callback 34
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  name                smName$
    '   1-  program filename    smPrg$
    '   2-  status effect connected to this move    smStatusEffect$
    '   3-  animation           smAnimation$
    '   4-  description         smDescription$
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            CBGetSpecialMoveString = specialMoveMem.smname$
            Exit Function
        Case 1:
            CBGetSpecialMoveString = specialMoveMem.smPrg$
            Exit Function
        Case 2:
            CBGetSpecialMoveString = specialMoveMem.smStatusEffect$
            Exit Function
        Case 3:
            CBGetSpecialMoveString = specialMoveMem.smAnimation$
            Exit Function
        Case 4:
            CBGetSpecialMoveString = specialMoveMem.smDescription
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetSpecialMoveNum(ByVal infoCode As Long) As Long
    'get special move info (num)
    'callback 35
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  fp     smFP
    '   1-  smp    smSMP
    '   2-  smp to remove from target   smtargSMP
    '   3-  battle driven yn?   smBattle
    '   4-  menu driven yn?   smmenu
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            CBGetSpecialMoveNum = specialMoveMem.smFP
            Exit Function
        Case 1:
            CBGetSpecialMoveNum = specialMoveMem.smSMP
            Exit Function
        Case 2:
            CBGetSpecialMoveNum = specialMoveMem.smtargSMP
            Exit Function
        Case 3:
            CBGetSpecialMoveNum = specialMoveMem.smBattle
            Exit Function
        Case 4:
            CBGetSpecialMoveNum = specialMoveMem.smMenu
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

Sub CBLoadItem(ByVal file As String, ByVal itmSlot As Long)
    'loads an item into item slot 0-11
    'file should be *without* path info
    'callback 36

    On Error Resume Next

    If itmSlot < 0 Then

        'Make itmSlot positive
        itmSlot = -itmSlot

        'Use special plug item array
        If UBound(plugItems) < itmSlot Then
            ReDim Preserve plugItems(itmSlot)
        End If

        'Open the item (WARNING: possible memory leak!!)
        plugItems(itmSlot) = openItem(projectPath & itmPath & file)

    Else

        'Preform all actions associated with opening the item
        Do While (UBound(boardList(activeBoardIndex).theData.itmActivate)) < itmSlot
            Call dimensionItemArrays(boardList(activeBoardIndex).theData)
        Loop

        'Open the item
        itemMem(itmSlot) = openItem(projectPath & itmPath & file)

    End If

End Sub

Function CBGetItemString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As String
    'get item info (string)
    'callback 37
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  item name (handle)  itemname$
    '   1-  acessory name to equip this to.     accessory$
    '   2-  program to run when equipped        prgequip$
    '   3-  program to run when removed         prgremove$
    '   4-  program to run when used from menu  mnuUse$
    '   5-  program to run when used from a fight   fgtUse$
    '   6-  program to run while item is on board (mainmem.multitask)   itmPrgOnBoard$
    '   7-  program to run when item is picked up   itmPrgPickUp$
    '   8-  characters who can use the item (arrayPos 0-50)     itmChars$
    '   9-  item description
    '   10-  item animation

    On Error Resume Next

    Dim theItem As TKItem

    If itmSlot > 0 Then
        itmSlot = inBounds(itmSlot, 0, UBound(itemMem))
        theItem = itemMem(itmSlot)
    Else
        itmSlot = inBounds(-itmSlot, 0, UBound(plugItems))
        theItem = plugItems(itmSlot)
    End If

    Select Case infoCode
        Case 0:
            CBGetItemString = theItem.itemName$
            Exit Function
        Case 1:
            CBGetItemString = theItem.accessory$
            Exit Function
        Case 2:
            CBGetItemString = theItem.prgEquip$
            Exit Function
        Case 3:
            CBGetItemString = theItem.prgRemove$
            Exit Function
        Case 4:
            CBGetItemString = theItem.mnuUse$
            Exit Function
        Case 5:
            CBGetItemString = theItem.fgtUse$
            Exit Function
        Case 6:
            CBGetItemString = theItem.itmPrgOnBoard$
            Exit Function
        Case 7:
            CBGetItemString = theItem.itmPrgPickUp$
            Exit Function
        Case 8:
            arrayPos = inBounds(arrayPos, 0, 10)
            CBGetItemString = theItem.itmChars$(arrayPos)
            Exit Function
        Case 9:
            CBGetItemString = theItem.itmDescription
            Exit Function
        Case 10:
            CBGetItemString = theItem.itmAnimation
            Exit Function
    End Select

End Function


Function CBGetItemNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As Long
    'get item info (num)
    'callback 38
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  equippable? 0=no, 1=yes     EquipYN
    '   1-  menu item?  0=no, 1=yes     menuYN
    '   2-  board item? 0=no, 1=yes     BoardYN
    '   3-  battle item?0=no, 1=yes     FightYN
    '   4-  equip on what body locations? (arrayPos 1-7) (head->accessory)  itemarmour
    '   5-  hp increase when equipped   equiphp
    '   6-  dp increase when equipped   equipdp
    '   7-  fp increase when equipped   equipfp
    '   8-  smp increase when equipped   equipsm
    '   9-  hp increase when used from menu   mnuHPup
    '   10- smp increase when used from menu   mnuSMup
    '   11- hp increase when used from fight    fgtHPup
    '   12- smp increase when used from fight   fgtSMup
    '   13- item used by 0=all, 1=defined  usedby
    '   14- buying price        buyprice
    '   15- selling price       sellprice
    '   16- key item 0=no, 1=yes    keyitem

    On Error Resume Next

    Dim theItem As TKItem

    If itmSlot > 0 Then
        itmSlot = inBounds(itmSlot, 0, UBound(itemMem))
        theItem = itemMem(itmSlot)
    Else
        itmSlot = inBounds(-itmSlot, 0, UBound(plugItems))
        theItem = plugItems(itmSlot)
    End If

    Select Case infoCode
        Case 0:
            CBGetItemNum = theItem.EquipYN
            Exit Function
        Case 1:
            CBGetItemNum = theItem.MenuYN
            Exit Function
        Case 2:
            CBGetItemNum = theItem.BoardYN
            Exit Function
        Case 3:
            CBGetItemNum = theItem.FightYN
            Exit Function
        Case 4:
            arrayPos = inBounds(arrayPos, 1, 7)
            CBGetItemNum = theItem.itemArmor(arrayPos)
            Exit Function
        Case 5:
            CBGetItemNum = theItem.equipHP
            Exit Function
        Case 6:
            CBGetItemNum = theItem.equipDP
            Exit Function
        Case 7:
            CBGetItemNum = theItem.equipFP
            Exit Function
        Case 8:
            CBGetItemNum = theItem.equipSM
            Exit Function
        Case 9:
            CBGetItemNum = theItem.mnuHPup
            Exit Function
        Case 10:
            CBGetItemNum = theItem.mnuSMup
            Exit Function
        Case 11:
            CBGetItemNum = theItem.fgtHPup
            Exit Function
        Case 12:
            CBGetItemNum = theItem.fgtSMup
            Exit Function
        Case 13:
            CBGetItemNum = theItem.usedBy
            Exit Function
        Case 14:
            CBGetItemNum = theItem.buyPrice
            Exit Function
        Case 15:
            CBGetItemNum = theItem.sellPrice
            Exit Function
        Case 16:
            CBGetItemNum = theItem.keyItem
            Exit Function
    End Select

End Function

Function CBGetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As Long
    'get item board (num)
    'callback 39
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  board x size    (BsizeX)
    '   1-  board y size    (BsizeY)
    '   2-  ambient red array    (arrayPos1 1-50, arrayPos2 1-50, arrayPos3 1-8)    (ambientred)
    '   3-  ambient green array    (arrayPos1 1-50, arrayPos2 1-50, arrayPos3 1-8)    (ambientgreen)
    '   4-  ambient blue array    (arrayPos1 1-50, arrayPos2 1-50, arrayPos3 1-8)    (ambientblue)
    '   5-  tiletype array    (arrayPos1 1-50, arrayPos2 1-50, arrayPos3 1-8)    (tiletype)
    '   6-  board background color  (brdcolor)
    '   7-  border color            (bordercolor)
    '   8-  board skill     (boardskill)
    '   9-  fighting on board YN      (1= yes, 0=no)    (fightingYN)
    '   10- board constants (arrayPos1 1-10)    (brdConst)
    '   11- program x pos (arrayPos1 0-50)  (progx)
    '   12- program y pos (arrayPos1 0-50)  (progy)
    '   13- program layer pos (arrayPos1 0-50)  (proglayer)
    '   14- program activation (arrayPos1 0-50) (0=always active, 1=conditional activation)    (progactivate)
    '   15- program activation type (arrayPos1 0-50) (0=step on, 1=conditional (activation key)) (activationtype)
    '   16- item x position (arrayPos1 0-10) (itmx)
    '   17- item y position (arrayPos1 0-10) (itmy)
    '   18- item layer position (arrayPos1 0-10) (itmlayer)
    '   19- item activation (arrayPos1 0-10)    (0-always active, 1-conditional activation)  (itmactivate)
    '   20- item activation type (arrayPos1 0-10)    (0-step on, 1-conditional)  (itmactivationtype)
    '   21- starting player x pos   (playerx)
    '   22- starting player y pos   (playery)
    '   23- starting player layer pos   (playerlayer)
    '   24- is saving disabled on this board? (0=no, 1=yes) (brdsavingYN)
    On Error GoTo errorhandler
    
    ' ! MODIFIED BY KSNiloc
    
    Select Case infoCode
        Case 0:
            CBGetBoardNum = boardList(activeBoardIndex).theData.bSizeX
            Exit Function
        Case 1:
            CBGetBoardNum = boardList(activeBoardIndex).theData.bSizeY
            Exit Function
        Case 2:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            CBGetBoardNum = boardList(activeBoardIndex).theData.ambientRed(arrayPos1, arrayPos2, arrayPos3)
            Exit Function
        Case 3:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            CBGetBoardNum = boardList(activeBoardIndex).theData.ambientGreen(arrayPos1, arrayPos2, arrayPos3)
            Exit Function
        Case 4:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            CBGetBoardNum = boardList(activeBoardIndex).theData.ambientBlue(arrayPos1, arrayPos2, arrayPos3)
            Exit Function
        Case 5:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            CBGetBoardNum = boardList(activeBoardIndex).theData.tiletype(arrayPos1, arrayPos2, arrayPos3)
            Exit Function
        Case 6:
            CBGetBoardNum = boardList(activeBoardIndex).theData.brdColor
            Exit Function
        Case 7:
            CBGetBoardNum = boardList(activeBoardIndex).theData.borderColor
            Exit Function
        Case 8:
            CBGetBoardNum = boardList(activeBoardIndex).theData.boardSkill
            Exit Function
        Case 9:
            CBGetBoardNum = boardList(activeBoardIndex).theData.fightingYN
            Exit Function
        Case 10:
            arrayPos1 = inBounds(arrayPos1, 1, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.brdConst(arrayPos1)
            Exit Function
        Case 11:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardNum = boardList(activeBoardIndex).theData.progX(arrayPos1)
            Exit Function
        Case 12:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardNum = boardList(activeBoardIndex).theData.progY(arrayPos1)
            Exit Function
        Case 13:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardNum = boardList(activeBoardIndex).theData.progLayer(arrayPos1)
            Exit Function
        Case 14:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardNum = boardList(activeBoardIndex).theData.progActivate(arrayPos1)
            Exit Function
        Case 15:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardNum = boardList(activeBoardIndex).theData.activationType(arrayPos1)
            Exit Function
        Case 16:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.itmX(arrayPos1)
            Exit Function
        Case 17:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.itmY(arrayPos1)
            Exit Function
        Case 18:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.itmLayer(arrayPos1)
            Exit Function
        Case 19:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.itmActivate(arrayPos1)
            Exit Function
        Case 20:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardNum = boardList(activeBoardIndex).theData.activationType(arrayPos1)
            Exit Function
        Case 21:
            CBGetBoardNum = boardList(activeBoardIndex).theData.playerX
            Exit Function
        Case 22:
            CBGetBoardNum = boardList(activeBoardIndex).theData.playerY
            Exit Function
        Case 23:
            CBGetBoardNum = boardList(activeBoardIndex).theData.playerLayer
            Exit Function
        Case 24:
            CBGetBoardNum = boardList(activeBoardIndex).theData.brdSavingYN
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function CBGetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As String
    'get board info (string)
    'callback 40
    'infoCode is the code of the info we want.
    'infoCodes:
    '   0-  board tile array (arrayPos1 1-50, arrayPos2 1-50, arrayPos3 1-8)    (board$)
    '   1-  board background image  (brdback$)
    '   2-  board border image (borderback$)
    '   3-  directional links (arrayPos1 1-4) (1=N, 2=S, 3=E, 4=W)  (dirlink$)
    '   4-  fighting background (boardbackground$)
    '   5-  background music    (boardmusic$)
    '   6-  layer title (arrayPos1 1-8) (boardtitle$)
    '   7-  board program filenames (arrayPos1 0-50)    (programname$)
    '   8-  program graphics (arrayPos1 0-50)   (proggraphic$)
    '   9-  program activation variable (arrayPos1 0-50)   (progvaractivate$)
    '   10-  program actiavtion var at end of program (arrayPos1 0-50)   (progdonvaractiavte$)
    '   11-  initial number of activation (arrayPos1 0-50)   (activateinitnum$)
    '   12-  what to make var at end of activation (arrayPos1 0-50)   (activatedonenum$)
    '   13-  board item filenames (arrayPos1 0-10)    (itmname$)
    '   14-  item activation variable (arrayPos1 0-10)   (itmvaractivate$)
    '   15-  item actiavtion var at end of program (arrayPos1 0-10)   (itmdonvaractiavte$)
    '   16-  item initial number of activation (arrayPos1 0-10)   (itmactivateinitnum$)
    '   17-  item what to make var at end of activation (arrayPos1 0-10)   (itmactivatedonenum$)
    '   18-  item program (arrayPos1 0-10)   (itemprogram$)
    '   19-  item multitaks program (arrayPos1 0-10)   (itemmulti$)
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            CBGetBoardString = BoardGetTile(arrayPos1, arrayPos2, arrayPos3, boardList(activeBoardIndex).theData)
            Exit Function
        Case 1:
            CBGetBoardString = boardList(activeBoardIndex).theData.brdBack$
            Exit Function
        Case 2:
            CBGetBoardString = boardList(activeBoardIndex).theData.borderBack$
            Exit Function
        Case 3:
            arrayPos1 = inBounds(arrayPos1, 1, 4)
            CBGetBoardString = boardList(activeBoardIndex).theData.dirLink$(arrayPos1)
            Exit Function
        Case 4:
            CBGetBoardString = boardList(activeBoardIndex).theData.boardBackground$
            Exit Function
        Case 5:
            CBGetBoardString = boardList(activeBoardIndex).theData.boardMusic$
            Exit Function
        Case 6:
            arrayPos1 = inBounds(arrayPos1, 1, 8)
            CBGetBoardString = boardList(activeBoardIndex).theData.boardTitle$(arrayPos1)
            Exit Function
        Case 7:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            CBGetBoardString = boardList(activeBoardIndex).theData.programName$(arrayPos1)
            Exit Function
        Case 8:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            CBGetBoardString = boardList(activeBoardIndex).theData.progGraphic$(arrayPos1)
            Exit Function
        Case 9:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            CBGetBoardString = boardList(activeBoardIndex).theData.progVarActivate$(arrayPos1)
            Exit Function
        Case 10:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            CBGetBoardString = boardList(activeBoardIndex).theData.progDoneVarActivate$(arrayPos1)
            Exit Function
        Case 11:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            CBGetBoardString = boardList(activeBoardIndex).theData.activateInitNum$(arrayPos1)
            Exit Function
        Case 12:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            CBGetBoardString = boardList(activeBoardIndex).theData.activateDoneNum$(arrayPos1)
            Exit Function
        Case 13:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itmName$(arrayPos1)
            Exit Function
        Case 14:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itmVarActivate$(arrayPos1)
            Exit Function
        Case 15:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itmDoneVarActivate$(arrayPos1)
            Exit Function
        Case 16:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itmActivateInitNum$(arrayPos1)
            Exit Function
        Case 17:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itmActivateDoneNum$(arrayPos1)
            Exit Function
        Case 18:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itemProgram$(arrayPos1)
            Exit Function
        Case 19:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            CBGetBoardString = boardList(activeBoardIndex).theData.itemMulti$(arrayPos1)
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Sub CBSetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal nValue As Long)
    'set board info (num)
    'callback 41
    'infoCode is the code of the info we want.
    'same as CBGetBoardNum
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.bSizeX = nValue
            Exit Sub
        Case 1:
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.bSizeY = nValue
            Exit Sub
        Case 2:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            nValue = inBounds(nValue, -255, 255)
            boardList(activeBoardIndex).theData.ambientRed(arrayPos1, arrayPos2, arrayPos3) = nValue
            Exit Sub
        Case 3:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            nValue = inBounds(nValue, -255, 255)
            boardList(activeBoardIndex).theData.ambientGreen(arrayPos1, arrayPos2, arrayPos3) = nValue
            Exit Sub
        Case 4:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            nValue = inBounds(nValue, -255, 255)
            boardList(activeBoardIndex).theData.ambientBlue(arrayPos1, arrayPos2, arrayPos3) = nValue
            Exit Sub
        Case 5:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            nValue = inBounds(nValue, 0, 18)
            boardList(activeBoardIndex).theData.tiletype(arrayPos1, arrayPos2, arrayPos3) = nValue
            Exit Sub
        Case 6:
            boardList(activeBoardIndex).theData.brdColor = nValue
            scTopX = -1
            scTopY = -1
            Call renderNow
            Exit Sub
        Case 7:
            'boardList(activeBoardIndex).theData.borderColor = nValue
            Exit Sub
        Case 8:
            boardList(activeBoardIndex).theData.boardSkill = nValue
            Exit Sub
        Case 9:
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.fightingYN = nValue
            Exit Sub
        Case 10:
            arrayPos1 = inBounds(arrayPos1, 1, 10)
            boardList(activeBoardIndex).theData.brdConst(arrayPos1) = nValue
            Exit Sub
        Case 11:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.progX(arrayPos1) = nValue
            Exit Sub
        Case 12:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.progY(arrayPos1) = nValue
            Exit Sub
        Case 13:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            nValue = inBounds(nValue, 1, 8)
            boardList(activeBoardIndex).theData.progLayer(arrayPos1) = nValue
            Exit Sub
        Case 14:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.progActivate(arrayPos1) = nValue
            Exit Sub
        Case 15:
            arrayPos1 = inBounds(arrayPos1, 0, 50)
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.activationType(arrayPos1) = nValue
            Exit Sub
        Case 16:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.itmX(arrayPos1) = nValue
            Exit Sub
        Case 17:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.itmY(arrayPos1) = nValue
            Exit Sub
        Case 18:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            nValue = inBounds(nValue, 1, 8)
            boardList(activeBoardIndex).theData.itmLayer(arrayPos1) = nValue
            Exit Sub
        Case 19:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.itmActivate(arrayPos1) = nValue
            Exit Sub
        Case 20:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.activationType(arrayPos1) = nValue
            Exit Sub
        Case 21:
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.playerX = nValue
            Exit Sub
        Case 22:
            nValue = inBounds(nValue, 1, 50)
            boardList(activeBoardIndex).theData.playerY = nValue
            Exit Sub
        Case 23:
            nValue = inBounds(nValue, 1, 8)
            boardList(activeBoardIndex).theData.playerLayer = nValue
            Exit Sub
        Case 24:
            nValue = inBounds(nValue, 0, 1)
            boardList(activeBoardIndex).theData.brdSavingYN = nValue
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub


Sub CBSetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal newVal As String)

    ' ! MODIFIED BY KSNiloc...

    'get board info (string)
    'callback 42
    'infoCode is the code of the info we want.
    'infoCodes:
    ' same as cbgetboardstring
    On Error GoTo errorhandler
    Select Case infoCode
        Case 0:
            arrayPos1 = inBounds(arrayPos1, 1, 50)
            arrayPos2 = inBounds(arrayPos2, 1, 50)
            arrayPos3 = inBounds(arrayPos3, 1, 8)
            Call BoardSetTile(arrayPos1, arrayPos2, arrayPos3, newVal, boardList(activeBoardIndex).theData)
            Exit Sub
        Case 1:
            boardList(activeBoardIndex).theData.brdBack$ = newVal
            scTopX = -1
            scTopY = -1
            Call renderNow
            Exit Sub
        Case 2:
            'boardList(activeBoardIndex).theData.borderBack$ = newVal
            Exit Sub
        Case 3:
            arrayPos1 = inBounds(arrayPos1, 1, 4)
            boardList(activeBoardIndex).theData.dirLink$(arrayPos1) = newVal
            Exit Sub
        Case 4:
            boardList(activeBoardIndex).theData.boardBackground$ = newVal
            Exit Sub
        Case 5:
            boardList(activeBoardIndex).theData.boardMusic$ = newVal
            Call checkMusic
            Exit Sub
        Case 6:
            arrayPos1 = inBounds(arrayPos1, 1, 8)
            boardList(activeBoardIndex).theData.boardTitle$(arrayPos1) = newVal
            Exit Sub
        Case 7:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.programName$(arrayPos1) = newVal
            Exit Sub
        Case 8:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.progGraphic$(arrayPos1) = newVal
            Exit Sub
        Case 9:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.progVarActivate$(arrayPos1) = newVal
            Exit Sub
        Case 10:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.progDoneVarActivate$(arrayPos1) = newVal
            Exit Sub
        Case 11:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.activateInitNum$(arrayPos1) = newVal
            Exit Sub
        Case 12:
            arrayPos1 = inBounds(arrayPos1, 0, UBound(boardList(activeBoardIndex).theData.programName))
            boardList(activeBoardIndex).theData.activateDoneNum$(arrayPos1) = newVal
            Exit Sub
        Case 13:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itmName$(arrayPos1) = newVal
            Exit Sub
        Case 14:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itmVarActivate$(arrayPos1) = newVal
            Exit Sub
        Case 15:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itmDoneVarActivate$(arrayPos1) = newVal
            Exit Sub
        Case 16:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itmActivateInitNum$(arrayPos1) = newVal
            Exit Sub
        Case 17:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itmActivateDoneNum$(arrayPos1) = newVal
            Exit Sub
        Case 18:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itemProgram$(arrayPos1) = newVal
            Exit Sub
        Case 19:
            arrayPos1 = inBounds(arrayPos1, 0, (UBound(boardList(activeBoardIndex).theData.itmActivate)))
            boardList(activeBoardIndex).theData.itemMulti$(arrayPos1) = newVal
            Exit Sub
    End Select

    Exit Sub
'Begin error handling code:
errorhandler:
    
    Resume Next
End Sub

'VERSION 3.0

Function CBCreateCanvas(ByVal width As Long, ByVal height As Long) As Long
    'callback 45
    'create an offscreen canvas, return it's id
    On Error Resume Next
    If width <= 0 Then width = 1
    If height <= 0 Then height = 1
    CBCreateCanvas = CreateCanvas(width, height)
End Function

Function CBDestroyCanvas(ByVal canvasID As Long) As Long
    'callback 46
    'destory an offscreen canvas
    On Error Resume Next
    Call DestroyCanvas(canvasID)
    CBDestroyCanvas = 1
End Function

Function CBDrawCanvas(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long) As Long
    'callback 47
    'display an offscreen canvas
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call DXDrawCanvas(canvasID, x, y)
        CBDrawCanvas = 1
    Else
        CBDrawCanvas = 0
    End If
End Function

Function CBDrawCanvasPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long) As Long
    'callback 48
    'display an offscreen canvas (partially)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call DXDrawCanvasPartial(canvasID, xDest, yDest, xsrc, ysrc, width, height)
        CBDrawCanvasPartial = 1
    Else
        CBDrawCanvasPartial = 0
    End If
End Function

Function CBDrawCanvasTransparent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTransparentColor As Long) As Long
    'callback 49
    'display an offscreen canvas with transparency
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call DXDrawCanvasTransparent(canvasID, x, y, crTransparentColor)
        CBDrawCanvasTransparent = 1
    Else
        CBDrawCanvasTransparent = 0
    End If
End Function

Function CBDrawCanvasTransparentPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long) As Long
    'callback 50
    'display an offscreen canvas (partially) with transparency
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call DXDrawCanvasTransparentPartial(canvasID, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor)
        CBDrawCanvasTransparentPartial = 1
    Else
        CBDrawCanvasTransparentPartial = 0
    End If
End Function

Function CBDrawCanvasTranslucent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
    'callback 51
    'display an offscreen canvas with translucency
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Call DXDrawCanvasTranslucent(canvasID, x, y, dIntensity, crUnaffectedColor, crTransparentColor)
        CBDrawCanvasTranslucent = 1
    Else
        CBDrawCanvasTranslucent = 0
    End If
End Function

Function CBCanvasLoadImage(ByVal canvasID As Long, ByVal filename As String) As Long
    'callback 52
    'load an image into the canvas
    'adds path info
    On Error Resume Next
    
    CBCanvasLoadImage = CanvasLoadPicture(canvasID, PakLocate(projectPath & bmpPath & filename))
End Function

Function CBCanvasLoadSizedImage(ByVal canvasID As Long, ByVal filename As String) As Long
    'callback 53
    'load an image into the canvas (fit to canvas)
    'adds path info
    On Error Resume Next
    
    Call CanvasLoadSizedPicture(canvasID, PakLocate(projectPath & bmpPath & filename))
    CBCanvasLoadSizedImage = 1
End Function

Function CBCanvasFill(ByVal canvasID As Long, ByVal crColor As Long) As Long
    'callback 54
    'fill canvas with color
    On Error Resume Next
    
    Call CanvasFill(canvasID, crColor)
    CBCanvasFill = 1
End Function

Function CBCanvasResize(ByVal canvasID As Long, ByVal width As Long, ByVal height As Long) As Long
    'callback 55
    'resize canvas
    On Error Resume Next
    
    Call SetCanvasSize(canvasID, width, height)
    CBCanvasResize = 1
End Function

Function CBCanvas2CanvasBlt(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long) As Long
    'callback 56
    'copy one canvas into another
    On Error Resume Next
    
    CBCanvas2CanvasBlt = Canvas2CanvasBlt(cnvSrc, cnvDest, xDest, yDest)
End Function

Function CBCanvas2CanvasBltPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long) As Long
    'callback 57
    'copy one canvas into another (partially)
    On Error Resume Next
    
    CBCanvas2CanvasBltPartial = Canvas2CanvasBltPartial(cnvSrc, cnvDest, xDest, yDest, xsrc, ysrc, width, height)
End Function

Function CBCanvas2CanvasBltTransparent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal crTransparentColor As Long) As Long
    'callback 58
    'copy one canvas into another, using transparency
    On Error Resume Next
    
    CBCanvas2CanvasBltTransparent = Canvas2CanvasBltTransparent(cnvSrc, cnvDest, xDest, yDest, crTransparentColor)
End Function

Function CBCanvas2CanvasBltTransparentPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long) As Long
    'callback 59
    'copy one canvas into another, using transparency (partially)
    On Error Resume Next
    
    CBCanvas2CanvasBltTransparentPartial = Canvas2CanvasBltTransparentPartial(cnvSrc, cnvDest, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor)
End Function

Function CBCanvas2CanvasBltTranslucent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
    'callback 60
    'copy one canvas into another, using translucency
    On Error Resume Next
    
    CBCanvas2CanvasBltTranslucent = Canvas2CanvasBltTranslucent(cnvSrc, cnvDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
End Function

Function CBCanvasGetScreen(ByVal cnvDest As Long) As Long
    'callback 61
    'copy the screen into a canvas
    On Error Resume Next
    
    CBCanvasGetScreen = CanvasGetScreen(cnvDest)
End Function

Function CBLoadString(ByVal id As Long, ByVal defaultString As String) As String
    'callback 62
    'load locaized string
    On Error Resume Next
    
    CBLoadString = LoadStringLoc(id, defaultString)
End Function

Function CBCanvasDrawText(ByVal canvasID As Long, ByVal Text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long, Optional ByVal isOutlined As Long = 0) As Long
    'callback 63
    'draw text to a canvas
    On Error Resume Next
    Call CanvasDrawText(canvasID, Text, font, size, x, y, crColor, (isBold = 1), (isItalics = 1), (isUnderline = 1), (isCentred = 1), (isOutlined = 1))
    CBCanvasDrawText = 1
End Function

Function CBCanvasPopup(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal stepSize As Long, ByVal popupType As Long) As Long
    'callback 64
    'draw canvas (but pop it up)
    On Error Resume Next
    stepSize = inBounds(stepSize, 1, 100)
    Call PopupCanvas(canvasID, x, y, stepSize, popupType)
    CBCanvasPopup = 1
End Function


Function CBCanvasWidth(ByVal canvasID As Long) As Long
    'callback 65
    'get canvas width
    On Error Resume Next
    CBCanvasWidth = GetCanvasWidth(canvasID)
End Function


Function CBCanvasHeight(ByVal canvasID As Long) As Long
    'callback 66
    'get canvas height
    On Error Resume Next
    CBCanvasHeight = GetCanvasHeight(canvasID)
End Function


Function CBCanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    'callback 67
    'draw a line to a canvas
    On Error Resume Next
    Call CanvasDrawLine(canvasID, x1, y1, x2, y2, crColor)
    CBCanvasDrawLine = 1
End Function


Function CBCanvasDrawRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    'callback 68
    'draw a rect to a canvas
    On Error Resume Next
    Call CanvasBox(canvasID, x1, y1, x2, y2, crColor)
    CBCanvasDrawRect = 1
End Function


Function CBCanvasFillRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    'callback 69
    'draw a filled rect to a canvas
    On Error Resume Next
    Call CanvasFillBox(canvasID, x1, y1, x2, y2, crColor)
    CBCanvasFillRect = 1
End Function


Function CBCanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long) As Long
    'callback 70
    'draw a hand pointing to pointx, pointy
    On Error Resume Next
    '-10 added by KSNiloc...
    Call CanvasDrawHand(canvasID, pointx - 10, pointy)
    CBCanvasDrawHand = 1
End Function

Function CBDrawHand(ByVal pointx As Long, ByVal pointy As Long) As Long
    'callback 71
    'draw a hand pointing to pointx, pointy
    On Error Resume Next
    Dim cnv As Long
    cnv = CreateCanvas(32, 32)
    Call CanvasFill(cnv, RGB(255, 0, 0))
    Call CanvasDrawHand(cnv, 32, 10)
    Call DXDrawCanvasTransparent(cnv, pointx - 32 - 10, pointy - 10, RGB(255, 0, 0))
    Call DestroyCanvas(cnv)
    CBDrawHand = 1
End Function

Function CBCheckKey(ByVal keyPressed As String) As Long
    'callback 72
    'determine if a key is pressed.
    'return 1 if it is, 0 if it isn't
    'also works with special keys ('LEFT', 'RIGHT', 'UP', 'DOWN', 'ESC', 'SPACE', 'ENTER')
    On Error Resume Next
    If isPressed(keyPressed) Then
        CBCheckKey = 1
    Else
        CBCheckKey = 0
    End If
End Function


Function CBPlaySound(ByVal soundFile As String) As Long
    'callback 73
    'play a sound effect (do not include path info!)
    On Error Resume Next
    Call playSoundFX(projectPath & mediaPath & soundFile)
    CBPlaySound = 1
End Function

Function CBMessageWindow(ByVal Text As String, ByVal textColor As Long, ByVal bgColor As Long, ByVal bgPic As String, ByVal mbtype As Long) As Long
    'callback 74
    'pop up a message box
    On Error Resume Next
    CBMessageWindow = MBox(Text, "", mbtype, textColor, bgColor, PakLocate(projectPath & bmpPath & bgPic))
End Function

Function CBFileDialog(ByVal initialPath As String, ByVal fileFilter As String) As String
    'callback 75
    'pop up a file dialog
    On Error Resume Next
    
    Dim toadd As String
    If (LenB(GetExt(fileFilter)) = 0) Then
        toadd = "*"
    Else
        toadd = GetExt(fileFilter)
    End If
    fileFilter = "*." & toadd
    CBFileDialog = ShowFileDialog(initialPath, fileFilter)
End Function

Function CBDetermineSpecialMoves(ByVal playerHandle As String) As Long
    'callback 76
    'determine special moves player playerHanlde can do
    'returns count.
    On Error Resume Next
    
    ReDim specialMoveList(200)
    
    CBDetermineSpecialMoves = determineSpecialMoves(playerHandle, specialMoveList)
End Function

Function CBGetSpecialMoveListEntry(ByVal idx As Long) As String
    'callback 77
    'get the special move in the specialMoveList
    'assumes user called CBDetermineSpecialMoves first
    'idx is the index of the special move filename to obtain.
    On Error Resume Next
    
    If idx > UBound(specialMoveList) Then
        CBGetSpecialMoveListEntry = vbNullString
    Else
        CBGetSpecialMoveListEntry = specialMoveList(idx)
    End If
End Function

Sub CBRunProgram(ByVal prgFile As String)
    'callback 78
    'run a program
    On Error Resume Next
    
    Call runProgram(projectPath & prgPath & prgFile, -1, False)
End Sub

Sub CBSetTarget(ByVal targetIdx As Long, ByVal ttype As Long)
    'callback 79
    'set RPGCode target
    On Error Resume Next
    
    target = targetIdx
    targetType = ttype
End Sub

Sub CBSetSource(ByVal sourceIdx As Long, ByVal sType As Long)
    'callback 80
    'set RPGCode source
    On Error Resume Next
    
    Source = sourceIdx
    sourceType = sType
End Sub

Function CBGetPlayerHP(ByVal playerIdx As Long) As Double
    'callback 81
    'get player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerHP = getPlayerHP(playerMem(playerIdx))
End Function

Function CBGetPlayerMaxHP(ByVal playerIdx As Long) As Double
    'callback 82
    'get player max hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerMaxHP = getPlayerMaxHP(playerMem(playerIdx))
End Function

Function CBGetPlayerSMP(ByVal playerIdx As Long) As Double
    'callback 83
    'get player smp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerSMP = getPlayerSMP(playerMem(playerIdx))
End Function

Function CBGetPlayerMaxSMP(ByVal playerIdx As Long) As Double
    'callback 84
    'get player max smp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerMaxSMP = getPlayerMaxSMP(playerMem(playerIdx))
End Function

Function CBGetPlayerFP(ByVal playerIdx As Long) As Double
    'callback 85
    'get player fp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerFP = getPlayerFP(playerMem(playerIdx))
End Function

Function CBGetPlayerDP(ByVal playerIdx As Long) As Double
    'callback 86
    'get player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerDP = getPlayerDP(playerMem(playerIdx))
End Function

Function CBGetPlayerName(ByVal playerIdx As Long) As String
    'callback 87
    'get player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    CBGetPlayerName = getPlayerName(playerMem(playerIdx))
End Function

Sub CBAddPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 88
    'add player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call addPlayerHP(amount, playerMem(playerIdx))
End Sub

Sub CBAddPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 89
    'add player smp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call addPlayerSMP(amount, playerMem(playerIdx))
End Sub

Sub CBSetPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 90
    'set player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call setPlayerHP(amount, playerMem(playerIdx))
End Sub

Sub CBSetPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 91
    'set player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call setPlayerSMP(amount, playerMem(playerIdx))
End Sub

Sub CBSetPlayerFP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 92
    'set player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call setPlayerFP(amount, playerMem(playerIdx))
End Sub

Sub CBSetPlayerDP(ByVal amount As Long, ByVal playerIdx As Long)
    'callback 93
    'set player hp
    On Error Resume Next
    playerIdx = inBounds(playerIdx, 0, 4)
    Call setPlayerDP(amount, playerMem(playerIdx))
End Sub

Function CBGetEnemyHP(ByVal eneIdx As Long) As Long
    'callback 94
    'get enemy hp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemyHP = getEnemyHP(enemyMem(eneIdx))
End Function

Function CBGetEnemyMaxHP(ByVal eneIdx As Long) As Long
    'callback 95
    'get enemy max hp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemyMaxHP = getEnemyMaxHP(enemyMem(eneIdx))
End Function

Function CBGetEnemySMP(ByVal eneIdx As Long) As Long
    'callback 96
    'get enemy max smp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemySMP = getEnemySMP(enemyMem(eneIdx))
End Function

Function CBGetEnemyMaxSMP(ByVal eneIdx As Long) As Long
    'callback 97
    'get enemy max smp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemyMaxSMP = getEnemyMaxSMP(enemyMem(eneIdx))
End Function

Function CBGetEnemyFP(ByVal eneIdx As Long) As Long
    'callback 98
    'get enemy fp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemyFP = getEnemyFP(enemyMem(eneIdx))
End Function

Function CBGetEnemyDP(ByVal eneIdx As Long) As Long
    'callback 99
    'get enemy max hp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    CBGetEnemyDP = getEnemyDP(enemyMem(eneIdx))
End Function

Sub CBAddEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
    'callback 100
    'add enemy hp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    Call addEnemyHP(amount, enemyMem(eneIdx))
End Sub

Sub CBAddEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
    'callback 101
    'add enemy smp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    Call addEnemySMP(amount, enemyMem(eneIdx))
End Sub

Sub CBSetEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
    'callback 102
    'set enemy hp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    Call setEnemyHP(amount, enemyMem(eneIdx))
End Sub

Sub CBSetEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
    'callback 103
    'set enemy smp
    On Error Resume Next
    eneIdx = inBounds(eneIdx, 0, 3)
    Call setEnemySMP(amount, enemyMem(eneIdx))
End Sub

Sub CBCanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
    'callback 104
    'draw fight background to canvas
    On Error Resume Next
    Call CanvasDrawBackground(canvasID, projectPath & bkgPath & bkgFile, x, y, width, height)
End Sub

Function CBCreateAnimation(ByVal file As String) As Long
    'callback 105
    'load an animation file, return an id to refer to it with
    On Error Resume Next
    CBCreateAnimation = CreateAnimation(projectPath & miscPath & file)
End Function

Sub CBDestroyAnimation(ByVal idx As Long)
    'callback 106
    'kill a loaded animation fiule
    On Error Resume Next
    Call DestroyAnimation(idx)
End Sub

Sub CBCanvasDrawAnimation(ByVal canvasID As Long, ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal forceDraw As Long, ByVal forceTranspFill As Long)
    'callback 107
    'draw a loaded animation inot a canvas -- advance the frame if necissary
    'if forcedraw = 1 then it will force the frma eot be re-drawn
    On Error Resume Next
    Call DrawAnimationIndexCanvas(idx, x, y, canvasID, (forceDraw = 1), (forceTranspFill = 1))
End Sub

Sub CBCanvasDrawAnimationFrame(ByVal canvasID As Long, ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal forceTranspFill As Long)
    'callback 108
    'draw a loaded animation inot a canvas (specific frame)
    On Error Resume Next
    
    Call DrawAnimationIndexCanvasFrame(idx, frame, x, y, canvasID, (forceTranspFill = 1))
End Sub


Function CBAnimationCurrentFrame(ByVal idx As Long) As Long
    'callback 109
    'get current frame of animation
    On Error Resume Next
    CBAnimationCurrentFrame = AnimationIndexCurrentFrame(idx)
End Function

Function CBAnimationMaxFrames(ByVal idx As Long) As Long
    'callback 110
    'get max frame of animation
    On Error Resume Next
    CBAnimationMaxFrames = AnimationIndexMaxFrames(idx)
End Function

Function CBAnimationSizeX(ByVal idx As Long) As Long
    'callback 111
    'get max frame of animation
    On Error Resume Next
    If anmListOccupied(idx) Then
        CBAnimationSizeX = anmList(idx).theData.animSizeX
    End If
End Function

Function CBAnimationSizeY(ByVal idx As Long) As Long
    'callback 112
    'get max frame of animation
    On Error Resume Next
    If anmListOccupied(idx) Then
        CBAnimationSizeY = anmList(idx).theData.animSizeX
    End If
End Function

Function CBAnimationFrameImage(ByVal idx As Long, ByVal frame As Long) As String
    'callback 113
    'get the filename of the image at a frame of animation
    On Error Resume Next
    CBAnimationFrameImage = AnimationIndexFrameImage(idx, frame)
End Function

Function CBGetPartySize(ByVal partyIdx As Long) As Long
    'callback 114
    'get size of fighter party
    On Error Resume Next
    CBGetPartySize = getPartySize(partyIdx)
End Function

Function CBGetFighterHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 115
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterHP = getPartyMemberHP(partyIdx, fighterIdx)
End Function

Function CBGetFighterMaxHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 116
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterMaxHP = getPartyMemberMaxHP(partyIdx, fighterIdx)
End Function

Function CBGetFighterSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 117
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterSMP = getPartyMemberSMP(partyIdx, fighterIdx)
End Function

Function CBGetFighterMaxSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 118
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterMaxSMP = getPartyMemberMaxSMP(partyIdx, fighterIdx)
End Function

Function CBGetFighterFP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 119
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterFP = getPartyMemberFP(partyIdx, fighterIdx)
End Function

Function CBGetFighterDP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 120
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterDP = getPartyMemberDP(partyIdx, fighterIdx)
End Function

Function CBGetFighterName(ByVal partyIdx As Long, ByVal fighterIdx As Long) As String
    'callback 121
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterName = getPartyMemberName(partyIdx, fighterIdx)
End Function

Function CBGetFighterAnimation(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal animationName As String) As String
    'callback 122
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterAnimation = getPartyMemberAnimation(partyIdx, fighterIdx, animationName)
End Function

Function CBGetFighterChargePercent(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    'callback 123
    'get stat of a fighter in the party
    On Error Resume Next
    CBGetFighterChargePercent = getPartyMemberCharge(partyIdx, fighterIdx)
End Function

Sub CBFightTick()
    'callback 124
    'advance the fight
    On Error Resume Next
    Call fightTick
End Sub

Function CBDrawTextAbsolute(ByVal Text As String, ByVal font As String, ByVal size As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long, Optional ByVal isOutlined As Long = 0) As Long
    'callback 125
    'draw text directly to the screen at x, y (pixels)
    On Error Resume Next
    CBDrawTextAbsolute = DXDrawText(x, y, Text, font, size, crColor, isBold, isItalics, isUnderline, isCentred, isOutlined)
End Function

Sub CBReleaseFighterCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    'callback 126
    'reset and unfreeze a fighter charge
    On Error Resume Next
    parties(partyIdx).fighterList(fighterIdx).chargeCounter = 0
    parties(partyIdx).fighterList(fighterIdx).freezeCharge = False
End Sub

Function CBFightDoAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Long) As Long
    'callback 127
    'cause one fighter to attack another
    On Error Resume Next
    CBFightDoAttack = doAttack(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, amount, (toSMP = 1))
End Function

Sub CBFightUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
    'callback 128
    'cause one fighter to use an item on another
    On Error Resume Next
    Call doUseItem(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, itemFile)
End Sub

Sub CBFightUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
    'callback 129
    'cause one fighter to use an item on another
    On Error Resume Next
    Call doUseSpecialMove(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, moveFile)
End Sub

Sub CBDoEvents()
    'callback 130
    'do events
    On Error Resume Next
    Call processEvent
End Sub

Sub CBFighterAddStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    'callback 131
    'add a status effect to a fighter
    On Error Resume Next
    Call partyMemberAddStatus(partyIdx, fightIdx, statusFile)
End Sub

Sub CBFighterRemoveStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    'callback 132
    'add a status effect to a fighter
    On Error Resume Next
    Call partyMemberRemoveStatus(partyIdx, fightIdx, statusFile)
End Sub

Public Sub CBDrawImageHDC(ByVal file As String, ByVal x As Long, ByVal y As Long, ByVal hdc As Long)
    On Error Resume Next
    Call drawImage(PakLocate(projectPath & bmpPath & file), x, y, hdc)
End Sub

Public Sub CBDrawSizedImageHDC(ByVal file As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long, ByVal hdc As Long)
    On Error Resume Next
    Call DrawSizedImage(PakLocate(projectPath & bmpPath & file), x, y, width, height, hdc)
End Sub
