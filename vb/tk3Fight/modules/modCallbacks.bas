Attribute VB_Name = "modCallbacks"
'====================================================================================
'RPGToolkit3 Default Battle System
'====================================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'====================================================================================
'YOU MAY NOT REMOVE THIS NOTICE!
'====================================================================================

'====================================================================================
'Callback module
'====================================================================================

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
'43-CBGetHwnd() As Long
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
'130-Sub CBCall CBDoEvents()
'131-Sub CBFighterAddStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
'132-Sub CBFighterRemoveStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)

Option Explicit

Public transPlugin As Object

Public Sub CBRpgCode(ByVal rpgcodecommand As String)
    transPlugin.CBRpgCode rpgcodecommand
End Sub

Public Function CBGetString(ByVal varName As String) As String
    CBGetString = transPlugin.CBGetString(varName)
End Function

Public Function CBGetNumerical(ByVal varName As String) As Double
    CBGetNumerical = transPlugin.CBGetNumerical(varName)
End Function

Public Sub CBSetString(ByVal varName As String, ByVal newValue As String)
    transPlugin.CBSetString varName, newValue
End Sub

Public Sub CBSetNumerical(ByVal varName As String, ByVal newValue As Double)
    transPlugin.CBSetNumerical varName, newValue
End Sub

Public Function CBGetScreenDC() As Long
    CBGetScreenDC = transPlugin.CBGetScreenDC()
End Function

Public Function CBGetScratch1DC() As Long
    CBGetScratch1DC = transPlugin.CBGetScratch1DC()
End Function

Public Function CBGetScratch2DC() As Long
    CBGetScratch2DC = transPlugin.CBGetScratch2DC()
End Function

Public Function CBGetMwinDC() As Long
    CBGetMwinDC = transPlugin.CBGetMwinDC()
End Function

Public Function CBPopupMwin() As Long
    transPlugin.CBPopupMwin
End Function

Public Function CBHideMwin() As Long
    transPlugin.CBHideMwin
End Function

Public Sub CBLoadEnemy(file As String, eneSlot As Long)
    transPlugin.CBLoadEnemy file, eneSlot
End Sub

Public Function CBGetEnemyNum(ByVal infoCode, ByVal eneSlot As Long) As Long
    CBGetEnemyNum = transPlugin.CBGetEnemyNum(infoCode, eneSlot)
End Function

Public Function CBGetEnemyString(ByVal infoCode As Long, ByVal eneSlot As Long) As String
    CBGetEnemyString = transPlugin.CBGetEnemyString(infoCode, eneSlot)
End Function

Public Sub CBSetEnemyNum(ByVal infoCode As Long, ByVal newValue, ByVal eneSlot As Long)
    transPlugin.CBSetEnemyNum infoCode, newValue, eneSlot
End Sub

Public Sub CBSetEnemyString(ByVal infoCode As Long, ByVal newValue As String, ByVal eneSlot As Long)
    transPlugin.CBSetEnemyString infoCode, newValue, eneSlot
End Sub

Public Function CBGetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
    CBGetPlayerNum = transPlugin.CBGetPlayerNum(infoCode, arrayPos, playerSlot)
End Function

Public Function CBGetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As String
    CBGetPlayerString = transPlugin.CBGetPlayerString(infoCode, arrayPos, playerSlot)
End Function

Public Sub CBSetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As Long, ByVal playerSlot As Long)
    transPlugin.CBSetPlayerNum infoCode, arrayPos, newVal, playerSlot
End Sub

Public Sub CBSetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As String, ByVal playerSlot As Long)
    transPlugin.CBSetPlayerString infoCode, arrayPos, newVal, playerSlot
End Sub

Public Function CBGetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long)
    CBGetGeneralString = transPlugin.CBGetGeneralString(infoCode, arrayPos, playerSlot)
End Function

Public Function CBGetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long) As Long
    CBGetGeneralNum = transPlugin.CBGetGeneralNum(infoCode, arrayPos, playerSlot)
End Function

Public Sub CBSetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As String)
    transPlugin.CBSetGeneralString infoCode, arrayPos, playerSlot, newVal
End Sub

Public Sub CBSetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As Long)
    transPlugin.CBGetGeneralNum infoCode, arrayPos, playerSlot
End Sub

Public Function CBGetCommandName(ByVal rpgcodecommand As String) As String
    CBGetCommandName = transPlugin.CBGetCommandName(rpgcodecommand)
End Function

Public Function CBGetBrackets(ByVal rpgcodecommand As String) As String
    CBGetBrackets = transPlugin.CBGetBrackets(rpgcodecommand)
End Function

Public Function CBCountBracketElements(ByVal rpgcodecommand As String) As Long
    CBCountBracketElements = transPlugin.CBCountBracketElements(rpgcodecommand)
End Function

Public Function CBGetBracketElement(ByVal rpgcodecommand As String, ByVal elemNum As Long) As String
    CBGetBracketElement = transPlugin.CBGetBracketElement(rpgcodecommand, elemNum)
End Function

Public Function CBGetStringElementValue(ByVal rpgcodecommand As String) As String
    CBGetStringElementValue = transPlugin.CBGetStringElementValue(rpgcodecommand)
End Function

Public Function CBGetNumElementValue(ByVal rpgcodecommand As String) As Double
    CBGetNumElementValue = transPlugin.CBGetNumElementValue(rpgcodecommand)
End Function

Public Function CBGetElementType(ByVal rpgcodecommand As String) As Long
    CBGetElementType = transPlugin.CBGetElementType(rpgcodecommand)
End Function

Public Sub CBDebugMessage(ByVal message As String)
    transPlugin.CBDebugMessage message
End Sub

Public Function CBGetPathString(ByVal infoCode As Long) As String
    transPlugin.CBGetPathString infoCode
End Function

Public Sub CBLoadSpecialMove(ByVal file As String)
    transPlugin.CBLoadSpecialMove file
End Sub

Public Function CBGetSpecialMoveString(ByVal infoCode As Long) As String
    CBGetSpecialMoveString = transPlugin.CBGetSpecialMoveString(infoCode)
End Function

Public Function CBGetSpecialMoveNum(ByVal infoCode As Long) As Long
    CBGetSpecialMoveNum = transPlugin.CBGetSpecialMoveNum(infoCode)
End Function

Public Sub CBLoadItem(ByVal file As String, ByVal itmSlot As Long)
    transPlugin.CBLoadItem file, itmSlot
End Sub

Public Function CBGetItemString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As String
    CBGetItemString = transPlugin.CBGetItemString(infoCode, arrayPos, itmSlot)
End Function

Public Function CBGetItemNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long) As Long
    CBGetItemNum = transPlugin.CBGetItemNum(infoCode, arrayPos, itmSlot)
End Function

Public Function CBGetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As Long
    CBGetBoardNum = transPlugin.CBGetBoardNum(infoCode, arrayPos1, arrayPos2, arrayPos3)
End Function

Public Function CBGetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long) As String
    CBGetBoardString = transPlugin.CBGetBoardString(infoCode, arrayPos1, arrayPos2, arrayPos3)
End Function

Public Sub CBSetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal nValue)
    transPlugin.CBSetBoardNum infoCode, arrayPos1, arrayPos2, arrayPos3, nValue
End Sub

Public Sub CBSetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal newVal As String)
    transPlugin.CBSetBoardString infoCode, arrayPos1, arrayPos2, arrayPos3, newVal
End Sub

Public Function CBGetHwnd() As Long
    CBGetHwnd = transPlugin.CBGetHwnd()
End Function

Public Function CBRefreshScreen() As Long
    CBRefreshScreen = transPlugin.CBRefreshScreen()
End Function

Public Function CBCreateCanvas(ByVal width As Long, ByVal height As Long) As Long
    CBCreateCanvas = transPlugin.CBCreateCanvas(width, height)
End Function

Public Function CBDestroyCanvas(ByVal canvasID As Long) As Long
    CBDestroyCanvas = transPlugin.CBDestroyCanvas(canvasID)
End Function

Public Function CBDrawCanvas(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long) As Long
    CBDrawCanvas = transPlugin.CBDrawCanvas(canvasID, x, y)
End Function

Public Function CBDrawCanvasPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long) As Long
    CBDrawCanvasPartial = transPlugin.CBDrawCanvasPartial(canvasID, xDest, yDest, xSrc, ySrc, width, height)
End Function

Public Function CBDrawCanvasTransparent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTransparentColor As Long) As Long
    CBDrawCanvasTransparent = transPlugin.CBDrawCanvasTransparent(canvasID, x, y, crTransparentColor)
End Function

Public Function CBDrawCanvasTransparentPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long) As Long
    CBDrawCanvasTransparentPartial = transPlugin.CBDrawCanvasTransparentPartial(canvasID, xDest, yDest, xSrc, ySrc, width, height, crTransparentColor)
End Function

Public Function CBDrawCanvasTranslucent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
    CBDrawCanvasTranslucent = transPlugin.CBDrawCanvasTranslucent(canvasID, x, y, dIntensity, crUnaffectedColor, crTransparentColor)
End Function

Public Function CBCanvasLoadImage(ByVal canvasID As Long, ByVal filename As String) As Long
    CBCanvasLoadImage = transPlugin.CBCanvasLoadImage(canvasID, filename)
End Function

Public Function CBCanvasLoadSizedImage(ByVal canvasID As Long, ByVal filename As String) As Long
    CBCanvasLoadSizedImage = transPlugin.CBCanvasLoadSizedImage(canvasID, filename)
End Function

Public Function CBCanvasFill(ByVal canvasID As Long, ByVal crColor As Long) As Long
    CBCanvasFill = transPlugin.CBCanvasFill(canvasID, crColor)
End Function

Public Function CBCanvasResize(ByVal canvasID As Long, ByVal width As Long, ByVal height As Long) As Long
    CBCanvasResize = transPlugin.CBCanvasResize(canvasID, width, height)
End Function

Public Function CBCanvas2CanvasBlt(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long) As Long
    CBCanvas2CanvasBlt = transPlugin.CBCanvas2CanvasBlt(cnvSrc, cnvDest, xDest, yDest)
End Function

Public Function CBCanvas2CanvasBltPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long) As Long
    CBCanvas2CanvasBltPartial = transPlugin.CBCanvas2CanvasBltPartial(cnvSrc, cnvDest, xDest, yDest, xSrc, ySrc, width, height)
End Function

Public Function CBCanvas2CanvasBltTransparent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal crTransparentColor As Long) As Long
    CBCanvas2CanvasBltTransparent = transPlugin.CBCanvas2CanvasBltTransparent(cnvSrc, cnvDest, xDest, yDest, crTransparentColor)
End Function

Public Function CBCanvas2CanvasBltTransparentPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor) As Long
    CBCanvas2CanvasBltTransparentPartial = transPlugin.CBCanvas2CanvasBltTransparentPartial(cnvSrc, cnvDest, xDest, yDest, xSrc, ySrc, width, height, crTransparentColor)
End Function

Public Function CBCanvas2CanvasBltTranslucent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
    CBCanvas2CanvasBltTranslucent = transPlugin.CBCanvas2CanvasBltTranslucent(cnvSrc, cnvDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
End Function

Public Function CBCanvasGetScreen(ByVal cnvDest As Long) As Long
    CBCanvasGetScreen = transPlugin.CBCanvasGetScreen(cnvDest)
End Function

Public Function CBLoadString(ByVal id As Long, ByVal defaultString As String) As String
    CBLoadString = transPlugin.CBLoadString(id, defaultString)
End Function

Public Function CBCanvasDrawText(ByVal canvasID As Long, ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long) As Long
    CBCanvasDrawText = transPlugin.CBCanvasDrawText(canvasID, text, font, size, x, y, crColor, isBold, isItalics, isUnderline, isCentred)
End Function

Public Function CBCanvasPopup(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal stepSize As Long, ByVal popupType As Long) As Long
    CBCanvasPopup = transPlugin.CBCanvasPopup(canvasID, x, y, stepSize, popupType)
End Function

Public Function CBCanvasWidth(ByVal canvasID As Long) As Long
    CBCanvasWidth = transPlugin.CBCanvasWidth(canvasID)
End Function

Public Function CBCanvasHeight(ByVal canvasID As Long) As Long
    CBCanvasHeight = transPlugin.CBCanvasHeight(canvasID)
End Function

Public Function CBCanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    CBCanvasDrawLine = transPlugin.CBCanvasDrawLine(canvasID, x1, y1, x2, y2, crColor)
End Function

Public Function CBCanvasDrawRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    CBCanvasDrawRect = transPlugin.CBCanvasDrawRect(canvasID, x1, y1, x2, y2, crColor)
End Function

Public Function CBCanvasFillRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
    CBCanvasFillRect = transPlugin.CBCanvasFillRect(canvasID, x1, y1, x2, y2, crColor)
End Function

Public Function CBCanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long) As Long
    CBCanvasDrawHand = transPlugin.CBCanvasDrawHand(canvasID, pointx, pointy)
End Function

Public Function CBDrawHand(ByVal pointx As Long, ByVal pointy As Long) As Long
    CBDrawHand = transPlugin.CBDrawHand(pointx, pointy)
End Function

Public Function CBCheckKey(ByVal keyPressed As String) As Long
    CBCheckKey = transPlugin.CBCheckKey(keyPressed)
End Function

Public Function CBPlaySound(ByVal soundFile As String) As Long
    CBPlaySound = transPlugin.CBPlaySound(soundFile)
End Function

Public Function CBMessageWindow(ByVal text As String, ByVal textColor As Long, ByVal bgColor As Long, ByVal bgPic As String, ByVal mbtype As Long) As Long
    CBMessageWindow = transPlugin.CBMessageWindow(text, textColor, bgColor, bgPic, mbtype)
End Function

Public Function CBFileDialog(ByVal initialPath As String, ByVal fileFilter As String) As String
    CBFileDialog = transPlugin.CBFileDialog(initialPath, fileFilter)
End Function

Public Function CBDetermineSpecialMoves(ByVal playerHandle As String) As Long
    CBDetermineSpecialMoves = transPlugin.CBDetermineSpecialMoves(playerHandle)
End Function

Public Function CBGetSpecialMoveListEntry(ByVal idx As Long) As String
    CBGetSpecialMoveListEntry = transPlugin.CBGetSpecialMoveListEntry(idx)
End Function

Public Sub CBRunProgram(ByVal prgFile As String)
    transPlugin.CBRunProgram prgFile
End Sub

Public Sub CBSetTarget(ByVal targetIdx As Long, ByVal tType As Long)
    transPlugin.CBSetTarget targetIdx, tType
End Sub

Public Sub CBSetSource(ByVal sourceIdx As Long, ByVal sType As Long)
    transPlugin.CBSetSource sourceIdx, sType
End Sub

Public Function CBGetPlayerHP(ByVal playerIdx As Long) As Double
    CBGetPlayerHP = transPlugin.CBGetPlayerHP(playerIdx)
End Function

Public Function CBGetPlayerMaxHP(ByVal playerIdx As Long) As Double
    CBGetPlayerMaxHP = transPlugin.CBGetPlayerMaxHP(playerIdx)
End Function

Public Function CBGetPlayerSMP(ByVal playerIdx As Long) As Double
    CBGetPlayerSMP = transPlugin.CBGetPlayerSMP(playerIdx)
End Function

Public Function CBGetPlayerMaxSMP(ByVal playerIdx As Long) As Double
    CBGetPlayerMaxSMP = transPlugin.CBGetPlayerMaxSMP(playerIdx)
End Function

Public Function CBGetPlayerFP(ByVal playerIdx As Long) As Double
    CBGetPlayerFP = transPlugin.CBGetPlayerFP(playerIdx)
End Function

Public Function CBGetPlayerDP(ByVal playerIdx As Long) As Double
    CBGetPlayerDP = transPlugin.CBGetPlayerDP(playerIdx)
End Function

Public Function CBGetPlayerName(ByVal playerIdx As Long) As String
    CBGetPlayerName = transPlugin.CBGetPlayerName(playerIdx)
End Function

Public Sub CBAddPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBAddPlayerHP amount, playerIdx
End Sub

Public Sub CBAddPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBAddPlayerSMP amount, playerIdx
End Sub

Public Sub CBSetPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBSetPlayerHP amount, playerIdx
End Sub

Public Sub CBSetPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBSetPlayerSMP amount, playerIdx
End Sub

Public Sub CBSetPlayerFP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBSetPlayerFP amount, playerIdx
End Sub

Public Sub CBSetPlayerDP(ByVal amount As Long, ByVal playerIdx As Long)
    transPlugin.CBSetPlayerDP amount, playerIdx
End Sub

Public Function CBGetEnemyHP(ByVal eneIdx As Long) As Long
    CBGetEnemyHP = transPlugin.CBGetEnemyHP(eneIdx)
End Function

Public Function CBGetEnemyMaxHP(ByVal eneIdx As Long) As Long
    CBGetEnemyMaxHP = transPlugin.CBGetEnemyMaxHP(eneIdx)
End Function

Public Function CBGetEnemySMP(ByVal eneIdx As Long) As Long
    CBGetEnemySMP = transPlugin.CBGetEnemySMP(eneIdx)
End Function

Public Function CBGetEnemyMaxSMP(ByVal eneIdx As Long) As Long
    CBGetEnemyMaxSMP = transPlugin.CBGetEnemyMaxSMP(eneIdx)
End Function

Public Function CBGetEnemyFP(ByVal eneIdx As Long) As Long
    CBGetEnemyFP = transPlugin.CBGetEnemyFP(eneIdx)
End Function

Public Function CBGetEnemyDP(ByVal eneIdx As Long) As Long
    CBGetEnemyDP = transPlugin.CBGetEnemyDP(eneIdx)
End Function

Public Sub CBAddEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
    transPlugin.CBAddEnemyHP amount, eneIdx
End Sub

Public Sub CBAddEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
    transPlugin.CBAddEnemySMP amount, eneIdx
End Sub

Public Sub CBSetEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
    transPlugin.CBSetEnemyHP amount, eneIdx
End Sub

Public Sub CBSetEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
    transPlugin.CBSetEnemySMP amount, eneIdx
End Sub

Public Sub CBCanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
    transPlugin.CBCanvasDrawBackground canvasID, bkgFile, x, y, width, height
End Sub

Public Function CBCreateAnimation(ByVal file As String) As Long
    CBCreateAnimation = transPlugin.CBCreateAnimation(file)
End Function

Public Sub CBDestroyAnimation(ByVal idx As Long)
    transPlugin.CBDestroyAnimation idx
End Sub

Public Sub CBCanvasDrawAnimation(ByVal canvasID As Long, ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal forceDraw As Long)
    transPlugin.CBCanvasDrawAnimation canvasID, idx, x, y, forceDraw, 0
End Sub

Public Sub CBCanvasDrawAnimationFrame(ByVal canvasID As Long, ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal forceTranspFill As Long)
    transPlugin.CBCanvasDrawAnimationFrame canvasID, idx, frame, x, y, forceTranspFill
End Sub

Public Function CBAnimationCurrentFrame(ByVal idx As Long) As Long
    CBAnimationCurrentFrame = transPlugin.CBAnimationCurrentFrame(idx)
End Function

Public Function CBAnimationMaxFrames(ByVal idx As Long) As Long
    CBAnimationMaxFrames = transPlugin.CBAnimationMaxFrames(idx)
End Function

Public Function CBAnimationSizeX(ByVal idx As Long) As Long
    CBAnimationSizeX = transPlugin.CBAnimationSizeX(idx)
End Function

Public Function CBAnimationSizeY(ByVal idx As Long) As Long
    CBAnimationSizeY = transPlugin.CBAnimationSizeY(idx)
End Function

Public Function CBAnimationFrameImage(ByVal idx As Long, ByVal frame As Long) As String
    CBAnimationFrameImage = transPlugin.CBAnimationFrameImage(idx, frame)
End Function

Public Function CBGetPartySize(ByVal partyIdx As Long) As Long
    CBGetPartySize = transPlugin.CBGetPartySize(partyIdx)
End Function

Public Function CBGetFighterHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterHP = transPlugin.CBGetFighterHP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterMaxHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterMaxHP = transPlugin.CBGetFighterMaxHP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterSMP = transPlugin.CBGetFighterSMP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterMaxSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterMaxSMP = transPlugin.CBGetFighterMaxSMP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterFP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterFP = transPlugin.CBGetFighterFP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterDP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterDP = transPlugin.CBGetFighterDP(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterName(ByVal partyIdx As Long, ByVal fighterIdx As Long) As String
    CBGetFighterName = transPlugin.CBGetFighterName(partyIdx, fighterIdx)
End Function

Public Function CBGetFighterAnimation(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal animationName As String) As String
    CBGetFighterAnimation = transPlugin.CBGetFighterAnimation(partyIdx, fighterIdx, animationName)
End Function

Public Function CBGetFighterChargePercent(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
    CBGetFighterChargePercent = transPlugin.CBGetFighterChargePercent(partyIdx, fighterIdx)
End Function

Public Sub CBFightTick()
    transPlugin.CBFightTick
End Sub

Public Function CBDrawTextAbsolute(ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long) As Long
    CBDrawTextAbsolute = transPlugin.CBDrawTextAbsolute(text, font, size, x, y, crColor, isBold, isItalics, isUnderline, isCentred)
End Function

Public Sub CBReleaseFighterCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long)
    transPlugin.CBReleaseFighterCharge partyIdx, fighterIdx
End Sub

Public Function CBFightDoAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Long) As Long
    CBFightDoAttack = transPlugin.CBFightDoAttack(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, amount, toSMP)
End Function

Public Sub CBFightUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
    transPlugin.CBFightUseItem sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, itemFile
End Sub

Public Sub CBFightUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
    transPlugin.CBFightUseSpecialMove sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, moveFile
End Sub

Public Sub CBDoEvents()
    Call transPlugin.CBCheckMusic
    Call transPlugin.CBDoEvents
End Sub

Public Sub CBFighterAddStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    transPlugin.CBFighterAddStatusEffect partyIdx, fightIdx, statusFile
End Sub

Public Sub CBFighterRemoveStatusEffect(ByVal partyIdx As Long, ByVal fightIdx As Long, ByVal statusFile As String)
    transPlugin.CBFighterRemoveStatusEffect partyIdx, fightIdx, statusFile
End Sub

Public Function CBFileExists(ByVal strFile As String) As Boolean
    CBFileExists = transPlugin.CBFileExists(strFile)
End Function
