/*
 ********************************************************************
 * The RPG Toolkit Version 3 Plugin Libraries
 * This file copyright (C) 2003-2007  Christopher B. Matthews
 ********************************************************************
 *
 * This file is released under the AC Open License v 1.0
 * See "AC Open License.txt" for details
 */

/*
 * To ensure the plugin works, do not modify this file.
 */

//canvas id type
#define CNVID long

//animation id type
#define ANMID long


//////////////////////////////////////////
// VB CALLBACKS
//0-CBRpgCode(byval rpgcodeCommand as string);
//1-CBGetString(ByVal varName As String); As String
//2-CBGetNumerical(ByVal varName As String); As Double
//3-CBSetString(ByVal varName As String, ByVal newValue As String);
//4-CBSetNumerical(ByVal varName As String, ByVal newValue As Double);
//5-CBGetScreenDC(); As Long
//6-CBGetScratch1DC(); As Long
//7-CBGetScratch2DC(); As Long
//8-CBGetMwinDC(); As Long
//9-CBPopupMwin();
//10-CBHideMwin(); 
//11-CBLoadEnemy(file As String, eneSlot As Long);
//12-CBGetEnemyNum(ByVal infoCode, ByVal eneSlot As Long); As Long
//13-CBGetEnemyString(ByVal infoCode As Long, ByVal eneSlot As Long); As String
//14-CBSetEnemyNum(ByVal infoCode As Long, ByVal newValue, ByVal eneSlot As Long);
//15-CBSetEnemyString(ByVal infoCode As Long, ByVal newValue As String, ByVal eneSlot As Long);
//16-CBGetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As Long
//17-CBGetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As String
//18-CBSetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As Long, ByVal playerSlot As Long);
//19-CBSetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As String, ByVal playerSlot As Long);
//20-CBGetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); as String
//21-CBGetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As Long
//22-CBSetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As String);
//23-CBSetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As Long);
//24-CBGetCommandName(ByVal rpgcodecommand As String); As String
//25-CBGetBrackets(ByVal rpgcodecommand As String); As String
//26-CBCountBracketElements(ByVal rpgcodecommand As String); As Long
//27-CBGetBracketElement(ByVal rpgcodecommand As String, ByVal elemNum As Long); As String
//28-CBGetStringElementValue(ByVal rpgcodecommand As String); As String
//29-CBGetNumElementValue(ByVal rpgcodecommand As String); As Double
//30-CBGetElementType(ByVal rpgcodecommand As String); As Long
//31-CBDebugMessage(ByVal message As String);
//32-CBGetPathString(ByVal infoCode As Long); As String
//33-CBLoadSpecialMove(ByVal file As String);
//34-CBGetSpecialMoveString(ByVal infoCode As Long); As String
//35-CBGetSpecialMoveNum(ByVal infoCode As Long); As String
//36-CBLoadItem(ByVal file As String, ByVal itmSlot As Long);
//37-CBGetItemString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long); As String
//38-CBGetItemNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long); As Long
//39-CBGetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long); As Long
//40-CBGetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long); As String
//41-CBSetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal nValue);
//42-CBSetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal newVal As String);
//43-CBGetHwnd(ByVal infoCode As Long, ByVal eneSlot As Long); As Long
//44-CBRefreshScreen(); As Long
//Added for version 3
//45-CBCreateCanvas(ByVal width As Long, ByVal height As Long); As Long
//46-CBDestroyCanvas(ByVal canvasID As Long); As Long
//47-CBDrawCanvas(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long); As Long
//48-CBDrawCanvasPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long); As Long
//49-CBDrawCanvasTransparent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTransparentColor As Long); As Long
//50-CBDrawCanvasTransparentPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long); As Long
//51-CBDrawCanvasTranslucent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long); As Long
//52-CBCanvasLoadImage(ByVal canvasID As Long, ByVal filename As String); As Long
//53-CBCanvasLoadSizedImage(ByVal canvasID As Long, ByVal filename As String); As Long
//54-CBCanvasFill(ByVal canvasID As Long, ByVal crColor As Long); As Long
//55-CBCanvasResize(ByVal canvasID As Long, ByVal width As Long, ByVal height As Long); As Long
//56-CBCanvas2CanvasBlt(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long); As Long
//57-CBCanvas2CanvasBltPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long); As Long
//58-CBCanvas2CanvasBltTransparent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal crTransparentColor As Long); As Long
//59-CBCanvas2CanvasBltTransparentPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor); As Long
//60-CBCanvas2CanvasBltTranslucent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long); As Long
//61-CBCanvasGetScreen(ByVal cnvDest As Long); As Long
//62-CBLoadString(ByVal id As Long, ByVal defaultString As String) As String
//64-CBCanvasPopup(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, byval stepSize as long, byval popupType as long) As Long
//65-CBCanvasWidth(ByVal canvasID As Long) As Long
//66-CBCanvasHeight(ByVal canvasID As Long) As Long
//67-CBCanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//68-CBCanvasDrawRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//69-CBCanvasFillRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//70-CBCanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long) As Long
//71-CBDrawHand(ByVal pointx As Long, ByVal pointy As Long) As Long
//72-CBCheckKey(ByVal keyPressed As String) As Long
//73-CBPlaySound(ByVal soundFile As String) As Long
//74-CBMessageWindow(ByVal text As String, ByVal textColor As Long, ByVal bgColor As Long, ByVal bgPic As String, ByVal mbtype As Long) As Long
//75-CBFileDialog(ByVal initialPath As String, ByVal fileFilter As String) As String
//76-CBDetermineSpecialMoves(ByVal playerHandle As String) As Long
//77-CBGetSpecialMoveListEntry(ByVal idx As Long) As String
//78-CBRunProgram(ByVal prgFile As String)
//79-CBSetTarget(ByVal targetIdx As Long, ByVal tType As Long)
//80-CBSetSource(ByVal sourceIdx As Long, ByVal sType As Long)
//81-Function CBGetPlayerHP(ByVal playerIdx As Long) As Double
//82-Function CBGetPlayerMaxHP(ByVal playerIdx As Long) As Double
//83-Function CBGetPlayerSMP(ByVal playerIdx As Long) As Double
//84-Function CBGetPlayerMaxSMP(ByVal playerIdx As Long) As Double
//85-Function CBGetPlayerFP(ByVal playerIdx As Long) As Double
//86-Function CBGetPlayerDP(ByVal playerIdx As Long) As Double
//87-Function CBGetPlayerName(ByVal playerIdx As Long) As String
//88-Sub CBAddPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
//89-Sub CBAddPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
//90-Sub CBSetPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
//91-Sub CBSetPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
//92-Sub CBSetPlayerFP(ByVal amount As Long, ByVal playerIdx As Long)
//93-Sub CBSetPlayerDP(ByVal amount As Long, ByVal playerIdx As Long)
//94-Function CBGetEnemyHP(ByVal eneIdx As Long) As Long
//95-Function CBGetEnemyMaxHP(ByVal eneIdx As Long) As Long
//96-Function CBGetEnemySMP(ByVal eneIdx As Long) As Long
//97-Function CBGetEnemyMaxSMP(ByVal eneIdx As Long) As Long
//98-Function CBGetEnemyFP(ByVal eneIdx As Long) As Long
//99-Function CBGetEnemyDP(ByVal eneIdx As Long) As Long
//100-Sub CBAddEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
//101-Sub CBAddEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
//102-Sub CBSetEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
//103-Sub CBSetEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
//104-Sub CBCanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
//105-Function CBCreateAnimation(ByVal file As String) As Long
//106-Sub CBDestroyAnimation(ByVal idx As Long)
//107-Sub CBCanvasDrawAnimation(ByVal canvasID As Long, ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal forceDraw As Long)
//108-Sub CBCanvasDrawAnimationFrame(ByVal canvasID As Long, ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal forceTranspFill As Long)
//109-Function CBAnimationCurrentFrame(ByVal idx As Long) As Long
//110-Function CBAnimationMaxFrames(ByVal idx As Long) As Long
//111-Function CBAnimationSizeX(ByVal idx As Long) As Long
//112-Function CBAnimationSizeY(ByVal idx As Long) As Long
//113-Function CBAnimationFrameImage(ByVal idx As Long, ByVal frame As Long) As String
//114-Function CBGetPartySize(ByVal partyIdx As Long) As Long
//115-Function CBGetFighterHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//116-Function CBGetFighterMaxHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//117-Function CBGetFighterSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//118-Function CBGetFighterMaxSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//119-Function CBGetFighterFP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//120-Function CBGetFighterDP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//121-Function CBGetFighterName(ByVal partyIdx As Long, ByVal fighterIdx As Long) As String
//122-Function CBGetFighterAnimation(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal animationName As String) As String
//123-Function CBGetFighterChargePercent(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//124-Sub CBFightTick()
//125-Function CBDrawTextAbsolute(ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long, byval isOutlined as long) As Long
//126-Sub CBReleaseFighterCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long)
//127-Function CBFightDoAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Long) As Long
//128-Sub CBFightUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
//129-Sub CBFightUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
//130-Sub CBDoEvents()

//////////////////////////////////////////
// INCLUDES
#include "tkplugdefines.h"		//include defines.
#include "tkpluglocalfns.h"		//local functions
#include <vector>
#include <string>

#ifndef TKPLUGCALLBACKS_H
#define TKPLUGCALLBACKS_H

///////////////////////////////////////////////////////
//
// Function: CBRpgCode
//
// Callback no: 0-CBRpgCode(byval rpgcodeCommand as string);
//
// Parameters: strCommand- rpgcode command to perform
//
// Action: perform an rpgcode command by calling
//				back to trans2
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBRpgCode(std::string strCommand);


///////////////////////////////////////////////////////
//
// Function: CBGetString
//
// Callback no: 1-CBGetString(ByVal varName As String); As String
//
// Parameters: strStringVar- rpgcode string to get
//
// Action: get the value of an rpgcode string, by calling
//				into trans2 and return it.
//
// Returns: std::string value stored in string var
//
///////////////////////////////////////////////////////
std::string CBGetString(std::string strStringVar);


///////////////////////////////////////////////////////
//
// Function: CBGetNumerical
//
// Callback no: 2-CBGetNumerical(ByVal varName As String); As Double
//
// Parameters: strNumVar- rpgcode numerical var to get
//
// Action: get the value of an rpgcode nuymerical var, 
//				by calling into trans2 and return it.
//
// Returns: double value stored in var
//
///////////////////////////////////////////////////////
double CBGetNumerical(std::string strNumVar);


///////////////////////////////////////////////////////
//
// Function: CBSetString
//
// Callback no: 3-CBSetString(ByVal varName As String, ByVal newValue As String);
//
// Parameters: strStringVar- rpgcode string to set
//						 strNewValue- new value
//
// Action: set the value of an rpgcode string, by calling
//				into trans2.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetString(std::string strStringVar, std::string strNewValue);


///////////////////////////////////////////////////////
//
// Function: CBSetNumerical
//
// Callback no: 4-CBSetNumerical(ByVal varName As String, ByVal newValue As Double);
//
// Parameters: strNumVar- rpgcode var to set
//						 strNewValue- new value
//
// Action: set the value of an rpgcode var, by calling
//				into trans2.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetNumerical(std::string strNumVar, double dNewValue);


///////////////////////////////////////////////////////
//
// Function: CBGetScreenDC
//
// Callback no: 5-CBGetScreenDC(); As Long
//
// Parameters: 
//
// Action: get the handle to the device context (HDC);
//				representing the main screen.  You can use
//				this value in susequent drawing routines.
//
// Returns: long- hdc of screen (cast to HDC before using it!);
//
///////////////////////////////////////////////////////
long CBGetScreenDC();


///////////////////////////////////////////////////////
//
// Function: CBGetScratch1DC
//
// Callback no: 6-CBGetScratch1DC(); As Long
//
// Parameters: 
//
// Action: get the handle to the device context (HDC);
//				representing the 1st scratch drawing area.
//				You can use this value in susequent drawing routines.
//				scratch areas are safe to draw on
//				without affecting things.
//
// Returns: long- hdc (cast to HDC before using it!);
//
///////////////////////////////////////////////////////
long CBGetScratch1DC();



///////////////////////////////////////////////////////
//
// Function: CBGetScratch2DC
//
// Callback no: 7-CBGetScratch2DC(); As Long
//
// Parameters: 
//
// Action: get the handle to the device context (HDC);
//				representing the 2nd scratch drawing area.
//				You can use this value in susequent drawing routines.
//				scratch areas are safe to draw on
//				without affecting things.
//
// Returns: long- hdc (cast to HDC before using it!);
//
///////////////////////////////////////////////////////
long CBGetScratch2DC();


///////////////////////////////////////////////////////
//
// Function: CBGetMwinDC
//
// Callback no: 7-CBGetMwinDC(); As Long
//
// Parameters: 
//
// Action: get the handle to the device context (HDC);
//				representing the message window.
//				You can use this value in susequent drawing routines.
//				Pop up the message window using CBPopupMwin first!
//
// Returns: long- hdc (cast to HDC before using it!);
//
///////////////////////////////////////////////////////
long CBGetMwinDC();



///////////////////////////////////////////////////////
//
// Function: CBPopupMwin
//
// Callback no: 9-CBPopupMwin(); 
//
// Parameters: 
//
// Action: pops up the message window
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBPopupMwin();


///////////////////////////////////////////////////////
//
// Function: CBHideMwin
//
// Callback no: 10-CBHideMwin();
//
// Parameters: 
//
// Action: hide the message window
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBHideMwin();


///////////////////////////////////////////////////////
//
// Function: CBLoadEnemy
//
// Callback no: 11-CBLoadEnemy(ByVal file As String, ByVal eneSlot As long);
//
// Parameters: strfile- filename to load, NO PATH INFO
//						 nEneSlot- mem slot to load into (0-3);
//
// Action: load an enemy and place it in a trans2
//				memory slot.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBLoadEnemy(std::string strFile, int nEneSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetEnemyNum
//
// Callback no: 12-CBGetEnemyNum(ByVal infoCode, ByVal eneSlot As Long); As Long
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nEneSlot- mem slot to load into (0-3);
//
// Action: get info for enemy.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: int- retrieved value.
//
///////////////////////////////////////////////////////
int CBGetEnemyNum(int nInfoCode, int nEneSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetEnemyString
//
// Callback no: 13-CBGetEnemyString(ByVal infoCode, ByVal eneSlot As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nEneSlot- mem slot to load into (0-3);
//
// Action: get info for enemy.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: std::string- retrieved value.
//
///////////////////////////////////////////////////////
std::string CBGetEnemyString(int nInfoCode, int nEneSlot);



///////////////////////////////////////////////////////
//
// Function: CBSetEnemyNum
//
// Callback no: 14-CBSetEnemyNum(ByVal infoCode As Long, ByVal newValue, ByVal eneSlot As Long);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nNewValue- new value to set
//						 nEneSlot- mem slot to load into (0-3);
//
// Action: set info for enemy.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetEnemyNum(int nInfoCode, int nNewValue, int nEneSlot);


///////////////////////////////////////////////////////
//
// Function: CBSetEnemyString
//
// Callback no: 15-CBSetEnemyString(ByVal infoCode As Long, ByVal newValue As String, ByVal eneSlot As Long);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 strNewValue- new value to set
//						 nEneSlot- mem slot to load into (0-3);
//
// Action: set info for enemy.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetEnemyString(int nInfoCode, std::string strNewValue, int nEneSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetPlayerNum
//
// Callback no: 16-CBGetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As Long
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: get numerical info about a player
//
// Returns: int- the number to return
//
///////////////////////////////////////////////////////
int CBGetPlayerNum(int nInfoCode, int nArrayPos, int nPlayerSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetPlayerString
//
// Callback no: 17-CBGetPlayerString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: get string info about a player
//
// Returns: std::string - the returned string
//
///////////////////////////////////////////////////////
std::string CBGetPlayerString(int nInfoCode, int nArrayPos, int nPlayerSlot);



///////////////////////////////////////////////////////
//
// Function: CBSetPlayerNum
//
// Callback no: 18-CBSetPlayerNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As Long, ByVal playerSlot As Long);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nNewValue- new value to set
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: set info for player.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerNum(int nInfoCode, int nArrayPos, int nNewValue, int nPlayerSlot);


///////////////////////////////////////////////////////
//
// Function: CBSetPlayerString
//
// Callback no: 19-CBSetPlayerInfoString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal newVal As String, ByVal playerSlot As Long);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 strNewValue- new value to set
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: set info for player.  Check enemy #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerString(int nInfoCode, int nArrayPos, std::string strNewValue, int nPlayerSlot);




///////////////////////////////////////////////////////
//
// Function: CBGetGeneralString
//
// Callback no: 20-CBGetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); as String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nPlayerSlot- player (0-4); or enemy (0-3); number to get info from
//
// Action: get general info about the game.  Check 
//				general #defines for description of nInfoCode's
//
// Returns: string
//
///////////////////////////////////////////////////////
std::string CBGetGeneralString(int nInfoCode, int nArrayPos, int nPlayerSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetGeneralNum
//
// Callback no: 21-CBGetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long); As Long
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: get numerical info about the game
//
// Returns: int- the number to return
//
///////////////////////////////////////////////////////
int CBGetGeneralNum(int nInfoCode, int nArrayPos, int nPlayerSlot);



///////////////////////////////////////////////////////
//
// Function: CBSetGeneralString
//
// Callback no: 22-CBSetGeneralString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As String);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 strNewValue- new value to set
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: set info for general constants.  If this involves 
//				changing a filename, such as the filename of the
//				currently playing music, the toolkit will actually
//				load and play the music as well.
//				Check general #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetGeneralString(int nInfoCode, int nArrayPos, int nPlayerSlot, std::string strNewValue);



///////////////////////////////////////////////////////
//
// Function: CBSetGeneralNum
//
// Callback no: 23-CBSetGeneralNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal playerSlot As Long, ByVal newVal As Long);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- the array position we wish to access (only for some codes!);
//						 nNewValue- new value to set
//						 nPlayerSlot- player number to get info from (0-4);
//
// Action: set info for general constants.  
//				Check general #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetGeneralNum(int nInfoCode, int nArrayPos, int nPlayerSlot, int nNewValue);



///////////////////////////////////////////////////////
//
// Function: CBGetCommandName
//
// Callback no: 24-CBGetCommandName(ByVal rpgcodecommand As String); As String
//
// Parameters: strRpgCode- rpgcode command to splice
//
// Action: get the command name of an rpgcode 
//				command.  ie, if #Mwin("lala"); were 
//				passed in, Mwin would be returned.
//
// Returns: std::string value
//
///////////////////////////////////////////////////////
std::string CBGetCommandName(std::string strRpgCode);



///////////////////////////////////////////////////////
//
// Function: CBGetBrackets
//
// Callback no: 25-CBGetBrackets(ByVal rpgcodecommand As String); As String
//
// Parameters: strRpgCode- rpgcode command to splice
//
// Action: get the value sitting in the brackets
//				of an rpgcode command
//				ie, if #Mwin("lala"); were 
//				passed in, lala would be returned.
//
// Returns: std::string value
//
///////////////////////////////////////////////////////
std::string CBGetBrackets(std::string strRpgCode);



///////////////////////////////////////////////////////
//
// Function: CBCountBracketElements
//
// Callback no: 26-CBCountBracketElements(ByVal rpgcodecommand As String); As Long
//
// Parameters: strBracket- bracket data 
//						spliced from rpgcode command
//
// Action: count the elements in the bracket data
//				of an rpgcode command
//				ie, if "lala",12 were 
//				passed in, 2 would be returned.
//
// Returns: int
//
///////////////////////////////////////////////////////
int CBCountBracketElements(std::string strBracket);



///////////////////////////////////////////////////////
//
// Function: CBGetBracketElement
//
// Callback no: 27-CBGetBracketElement(ByVal rpgcodecommand As String, ByVal elemNum As Long); As String
//
// Parameters: strBracket- bracket data 
//						spliced from rpgcode command
//						 nElemNum- number of element to obtain
//
// Action: get the element in the bracket data
//				of an rpgcode command
//				ie, if ""lala",12", 2 were 
//				passed in, "12" would be returned.
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetBracketElement(std::string strBracket, int nElemNum);



///////////////////////////////////////////////////////
//
// Function: CBGetStringElementValue
//
// Callback no: 28-CBGetStringElementValue(ByVal rpgcodecommand As String); As String
//
// Parameters: strValue- value to evaluate
//
// Action: get the value of a string symbol.
//				if a string constant is passed in, the
//				constant is returned without it's quotations.
//				if a string var is passed in, the contents
//				of the var is returned.
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetStringElementValue(std::string strValue);



///////////////////////////////////////////////////////
//
// Function: CBGetNumElementValue
//
// Callback no: 29-CBGetNumElementValue(ByVal rpgcodecommand As String); As Double
//
// Parameters: strValue- value to evaluate
//
// Action: get the value of a numerical symbol.
//				if a constant is passed in, the
//				constant is returned.
//				if a var is passed in, the contents
//				of the var is returned.
//
// Returns: double
//
///////////////////////////////////////////////////////
double CBGetNumElementValue(std::string strValue);


///////////////////////////////////////////////////////
//
// Function: CBGetElementType
//
// Callback no: 30-CBGetElementType(ByVal rpgcodecommand As String); As Long
//
// Parameters: strValue- value to evaluate
//
// Action: determines if the element value
//				is a string or a number.
//
// Returns: 0=number, 1=string
//
///////////////////////////////////////////////////////
int CBGetElementType(std::string strValue);




///////////////////////////////////////////////////////
//
// Function: CBDebugMessage
//
// Callback no: 31-CBDebugMessage(ByVal message As String);
//
// Parameters: strMessage- message to display
//
// Action: displays a message in the rpgcode 
//				debugger window.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBDebugMessage(std::string strMessage);




///////////////////////////////////////////////////////
//
// Function: CBGetPathString
//
// Callback no: 32-CBGetPathString(ByVal infoCode As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//
// Action: get path info about the game.  Check 
//				general #defines for description of nInfoCode's
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetPathString(int nInfoCode);




///////////////////////////////////////////////////////
//
// Function: CBLoadSpecialMove
//
// Callback no: 33-CBLoadSpecialMove(ByVal file As String);
//
// Parameters: strfile- filename to load, NO PATH INFO
//
// Action: load a special move.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBLoadSpecialMove(std::string strFile);



///////////////////////////////////////////////////////
//
// Function: CBGetSpecialMoveString
//
// Callback no: 34-CBGetSpecialMoveString(ByVal infoCode As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//
// Action: get special move info.
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetSpecialMoveString(int nInfoCode);



///////////////////////////////////////////////////////
//
// Function: CBGetSpecialMoveNum
//
// Callback no: 35-CBGetSpecialMoveNum(ByVal infoCode As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//
// Action: get special move info.
//
// Returns: int
//
///////////////////////////////////////////////////////
int CBGetSpecialMoveNum(int nInfoCode);




///////////////////////////////////////////////////////
//
// Function: CBLoadItem
//
// Callback no: 36-CBLoadItem(ByVal file As String, ByVal itmSlot As Long);
//
// Parameters: strfile- filename to load, NO PATH INFO
//						 nItemSlot- slot to load item into (0-11);
//
// Action: load an item
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBLoadItem(std::string strFile, int nItemSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetItemString
//
// Callback no: 37-CBGetItemString(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- array position to obtain (only some);
//						 nItemSlot- item number to access (0-11);
//
// Action: get item info.
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetItemString(int nInfoCode, int nArrayPos, int nItemSlot);



///////////////////////////////////////////////////////
//
// Function: CBGetItemNum
//
// Callback no: 38-CBGetItemNum(ByVal infoCode As Long, ByVal arrayPos As Long, ByVal itmSlot As Long); As Long
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos- array position to obtain (only some);
//						 nItemSlot- item number to access (0-11);
//
// Action: get item info.
//
// Returns: int
//
///////////////////////////////////////////////////////
int CBGetItemNum(int nInfoCode, int nArrayPos, int nItemSlot);




///////////////////////////////////////////////////////
//
// Function: CBGetBoardNum
//
// Callback no: 39-CBGetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long); As Long
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos1- first array position to obtain (only some);
//						 nArrayPos2- second array position to obtain (only some);
//						 nArrayPos3- third array position to obtain (only some);
//
// Action: get board info.
//
// Returns: int
//
///////////////////////////////////////////////////////
int CBGetBoardNum(int nInfoCode, int nArrayPos1, int nArrayPos2, int nArrayPos3);



///////////////////////////////////////////////////////
//
// Function: CBGetBoardString
//
// Callback no: 40-CBGetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long); As String
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos1- first array position to obtain (only some);
//						 nArrayPos2- second array position to obtain (only some);
//						 nArrayPos3- third array position to obtain (only some);
//
// Action: get board info.
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetBoardString(int nInfoCode, int nArrayPos1, int nArrayPos2, int nArrayPos3);



///////////////////////////////////////////////////////
//
// Function: CBSetBoardNum
//
// Callback no: 41-CBSetBoardNum(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal nValue);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos1- first array position to obtain (only some);
//						 nArrayPos2- second array position to obtain (only some);
//						 nArrayPos3- third array position to obtain (only some);
//						 nNewVal- new value to set it to.
//
// Action: set board info.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetBoardNum(int nInfoCode, int nArrayPos1, int nArrayPos2, int nArrayPos3, int nNewVal);




///////////////////////////////////////////////////////
//
// Function: CBSetBoardString
//
// Callback no: 42-CBSetBoardString(ByVal infoCode As Long, ByVal arrayPos1 As Long, ByVal arrayPos2 As Long, ByVal arrayPos3 As Long, ByVal newVal As String);
//
// Parameters: nInfoCode- code of info you want (see tkplugdefines.h);
//						 nArrayPos1- first array position to obtain (only some);
//						 nArrayPos2- second array position to obtain (only some);
//						 nArrayPos3- third array position to obtain (only some);
//						 strNewValue- new value to set
//
// Action: set info for board. 
//				Check board #defines
//				for description of nInfoCode's
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetBoardString(int nInfoCode, int nArrayPos1, int nArrayPos2, int nArrayPos3, std::string strNewValue);



///////////////////////////////////////////////////////
//
// Function: CBGetHwnd
//
// Callback no: 43-CBGetHwnd(ByVal infoCode As Long, ByVal eneSlot As Long); As Long
//
// Parameters: 
//
// Action: obtain the hwnd of the main window
//
// Returns: hwnd
//
///////////////////////////////////////////////////////
long CBGetHwnd();


///////////////////////////////////////////////////////
//
// Function: CBRefreshScreen
//
// Callback no: 44-CBRefreshScreen(); As Long
//
// Parameters: 
//
// Action: flip back buffer forward, refreshing the screen
//
// Returns: 0
//
///////////////////////////////////////////////////////
long CBRefreshScreen();

///////////////////////////////////////////////////////
//
// Function: CBCreateCanvas
//
// Callback no: 45-CBCreateCanvas(ByVal width As Long, ByVal height As Long); As Long
//
// Parameters: nWidth - width of canvas to create
//						 nHeight - height of canvas to create
//
// Action: Create a new offscreen canvas
//				 Remeber to destroy it when you're done with it using
//				 CBDestroyCanvas
//
// Returns: ID of the created canvas
//
///////////////////////////////////////////////////////
CNVID CBCreateCanvas(int nWidth, int nHeight);


///////////////////////////////////////////////////////
//
// Function: CBDestroyCanvas
//
// Callback no: 46-CBDestroyCanvas(ByVal canvasID As Long); As Long
//
// Parameters: canvasID - ID of canvas to destroy
//
// Action: Destroy a canvas created with CBCreateCanvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBDestroyCanvas(CNVID canvasID);



///////////////////////////////////////////////////////
//
// Function: CBDrawCanvas
//
// Callback no: 47-CBDrawCanvas(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long); As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nX - x location to draw to
//						 nY - y location to draw to
//
// Action: Draw a canvas at nX, nY.
//				 call CBRefreshScreen(); afterwards to flip the screen
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBDrawCanvas(CNVID canvasID, int nX, int nY);


///////////////////////////////////////////////////////
//
// Function: CBDrawCanvasPartial
//
// Callback no: 48-CBDrawCanvasPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long); As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nXDest - x location to draw to
//						 nYDest - y location to draw to
//						 nXSrc, nYSrc - location on the canvas to draw from
//						 nWidth, nHeight - width and height to draw
//
// Action: Draw part of a canvas at nXDest, nYDest.
//				 call CBRefreshScreen(); afterwards to flip the screen
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBDrawCanvasPartial(CNVID canvasID, int nXDest, int nYDest, int nXSrc, int nYSrc, int nWidth, int nHeight);


///////////////////////////////////////////////////////
//
// Function: CBDrawCanvasTransparent
//
// Callback no: 49-CBDrawCanvasTransparent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crTransparentColor As Long); As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nX - x location to draw to
//						 nY - y location to draw to
//						 crTransparentColor - transparent color to use
//
// Action: Draw a canvas at nX, nY using transparency.
//				 call CBRefreshScreen(); afterwards to flip the screen
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBDrawCanvasTransparent(CNVID canvasID, int nX, int nY, int crTransparentColor);


///////////////////////////////////////////////////////
//
// Function: CBDrawCanvasTransparentPartial
//
// Callback no: 50-CBDrawCanvasTransparentPartial(ByVal canvasID As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor As Long); As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nXDest - x location to draw to
//						 nYDest - y location to draw to
//						 nXSrc, nYSrc - location on the canvas to draw from
//						 nWidth, nHeight - width and height to draw
//						 crTransparentColor - transparent color to use
//
// Action: Draw part of a canvas transparently at nXDest, nYDest.
//				 call CBRefreshScreen(); afterwards to flip the screen
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBDrawCanvasTransparentPartial(CNVID canvasID, int nXDest, int nYDest, int nXSrc, int nYSrc, int nWidth, int nHeight, int crTransparentColor);


///////////////////////////////////////////////////////
//
// Function: CBDrawCanvasTranslucent
//
// Callback no: 51-CBDrawCanvasTranslucent(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long); As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nX - x location to draw to
//						 nY - y location to draw to
//						 dIntensity - number between 0 and 1
//								specifying the intensity.
//						 crUnaffectedColor - the color of pixels to be
//								drawn normally (set to -1 if unused);.
//						 crTransparentColor - transparent color to use
//								(set to -1 if unused);
//
// Action: Draw a canvas at nX, nY using translucency.
//				 call CBRefreshScreen(); afterwards to flip the screen
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBDrawCanvasTranslucent(CNVID canvasID, int nX, int nY, double dIntensity, int crUnaffectedColor, int crTransparentColor);



///////////////////////////////////////////////////////
//
// Function: CBCanvasLoadImage
//
// Callback no: 52-CBCanvasLoadImage(ByVal canvasID As Long, ByVal filename As String); As Long
//
// Parameters: canvasID - canvas to use.
//						 strFilename - filename of image to load
//							do not include path information.  It is 
//							assumed that images are in the Bitmap\ folder of the game
//
// Action: Load an image into a canvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasLoadImage(CNVID canvasID, std::string strFilename);



///////////////////////////////////////////////////////
//
// Function: CBCanvasLoadSizedImage
//
// Callback no: 53-CBCanvasLoadSizedImage(ByVal canvasID As Long, ByVal filename As String); As Long
//
// Parameters: canvasID - canvas to use.
//						 strFilename - filename of image to load
//							do not include path information.  It is 
//							assumed that images are in the Bitmap\ folder of the game
//
// Action: Load an image into a canvas, size it to fit the canvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasLoadSizedImage(CNVID canvasID, std::string strFilename);


///////////////////////////////////////////////////////
//
// Function: CBCanvasFill
//
// Callback no: 54-CBCanvasFill(ByVal canvasID As Long, ByVal crColor As Long); As Long
//
// Parameters: canvasID - canvas to use.
//						 crColor - color to fill cavas with
//
// Action: Fill a canvas with a color
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvasFill(CNVID canvasID, long crColor);



///////////////////////////////////////////////////////
//
// Function: CBCanvasResize
//
// Callback no: 55-CBCanvasResize(ByVal canvasID As Long, ByVal width As Long, ByVal height As Long); As Long
//
// Parameters: canvasID - canvas to use.
//						 nWidth - new width
//						 nHeight - new height
//
// Action: Resize a canvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasResize(CNVID canvasID, int nWidth, int nHeight);



///////////////////////////////////////////////////////
//
// Function: CBCanvas2CanvasBlt
//
// Callback no: 56-CBCanvas2CanvasBlt(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long); As Long
//
// Parameters: cnvSrc - source canvas to use.
//						 cnvDest - canvas we are copying to
//						 nXDest, nYDest - x and y destination
//
// Action: Copy a canvas to another
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvas2CanvasBlt(CNVID cnvSrc, CNVID cnvDest, int nXDest, int nYDest);



///////////////////////////////////////////////////////
//
// Function: CBCanvas2CanvasBltPartial
//
// Callback no: 57-CBCanvas2CanvasBltPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long); As Long
//
// Parameters: cnvSrc - source canvas to use.
//						 cnvDest - canvas we are copying to
//						 nXDest, nYDest - x and y destination
//						 nXSrc, nYSrc - source x and y coords
//						 nWidth, nHeight - dimensions to copy
//
// Action: Copy a canvas partially to another
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvas2CanvasBltPartial(CNVID cnvSrc, CNVID cnvDest, int nXDest, int nYDest, int nXSrc, int nYSrc, int nWidth, int nHeight);



///////////////////////////////////////////////////////
//
// Function: CBCanvas2CanvasBltTransparent
//
// Callback no: 58-CBCanvas2CanvasBltTransparent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal crTransparentColor As Long); As Long
//
// Parameters: cnvSrc - source canvas to use.
//						 cnvDest - canvas we are copying to
//						 nXDest, nYDest - x and y destination
//						 crTransparentColor - transparent color to use
//
// Action: Copy a canvas to another with transparency
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvas2CanvasBltTransparent(CNVID cnvSrc, CNVID cnvDest, int nXDest, int nYDest, int crTransparentColor);


///////////////////////////////////////////////////////
//
// Function: CBCanvas2CanvasBltTransparentPartial
//
// Callback no: 59-CBCanvas2CanvasBltTransparentPartial(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal crTransparentColor); As Long
//
// Parameters: cnvSrc - source canvas to use.
//						 cnvDest - canvas we are copying to
//						 nXDest, nYDest - x and y destination
//						 nXSrc, nYSrc - source x and y coords
//						 nWidth, nHeight - dimensions to copy
//						 crTransparentColor - transparent color to use
//
// Action: Copy a canvas partially to another, using transparency
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvas2CanvasBltTransparentPartial(CNVID cnvSrc, CNVID cnvDest, int nXDest, int nYDest, int nXSrc, int nYSrc, int nWidth, int nHeight, int crTransparentColor);



///////////////////////////////////////////////////////
//
// Function: CBCanvas2CanvasBltTranslucent
//
// Callback no: 60-CBCanvas2CanvasBltTranslucent(ByVal cnvSrc As Long, ByVal cnvDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long); As Long
//
// Parameters: cnvSrc - source canvas to use.
//						 cnvDest - canvas we are copying to
//						 nXDest, nYDest - x and y destination
//						 dIntensity - number between 0 and 1
//								specifying the intensity.
//						 crUnaffectedColor - the color of pixels to be
//								drawn normally (set to -1 if unused);.
//						 crTransparentColor - transparent color to use
//								(set to -1 if unused);
//
// Action: Copy a canvas to another with translucency
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvas2CanvasBltTranslucent(CNVID cnvSrc, CNVID cnvDest, int nXDest, int nYDest, double dIntensity, long crUnaffectedColor, long crTransparentColor);



///////////////////////////////////////////////////////
//
// Function: CBCanvasGetScreen
//
// Callback no: 61-CBCanvasGetScreen(ByVal cnvDest As Long); As Long
//
// Parameters: cnvDest - canvas we are copying to
//
// Action: Copy the screen into a canvas
//
// Returns: 0 - failure, all else mean success
//
///////////////////////////////////////////////////////
int CBCanvasGetScreen(CNVID cnvDest);


///////////////////////////////////////////////////////
//
// Function: CBLoadString
//
// Callback no: 62-CBLoadString(ByVal id As Long, ByVal defaultString As String) As String
//
// Parameters: nID - tag id of string to load (from language file)
//						 strDefault - default string to use if tag not found
//
// Action: Load a string from the language file.
//
// Returns: std::string - the localized string
//
///////////////////////////////////////////////////////
std::string CBLoadString(int nID, std::string strDefault);


///////////////////////////////////////////////////////
//
// Function: CBCanvasDrawText
//
// Callback no: 63-CBCanvasDrawText(ByVal canvasID As Long, ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, byval isCentred as long, byval isOutlined as long) As Long
//
// Parameters: cnvDest - Canvas to draw to
//						 strText - text to draw
//						 strFont - font to use
//						 nSize - size of font, in pixels
//						 dX, dY - coords to draw to (character coords, not pixels)
//						 crColor - color to use
//						 bBold, bItalics, bUnderline - set to true if
//							you want these modifiers.
//						 bCentred - centre the text?
//						 bOutlined - outline text?
//
// Action: Draw text to a canvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasDrawText(CNVID cnvDest, std::string strText, std::string strFont, int nSize, double dX, double dY, long crColor, bool bBold, bool bItalics, bool bUnderline, bool bCentred, bool bOutlined = false);


///////////////////////////////////////////////////////
//
// Function: CBCanvasPopup
//
// Callback no: 64-CBCanvasPopup(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, byval stepSize as long, byval popupType as long) As Long
//
// Parameters: canvasID - ID of canvas to draw
//						 nX - x location to draw to
//						 nY - y location to draw to
//						 nStepSize - step size (large numbers == faster)
//						 nPopupType - popup type constant (see tkplugdefines.h)
//
// Action: Draw a canvas at nX, nY (but pop it up).
//
// Returns: 1 - success, 0 - failure
//
///////////////////////////////////////////////////////
int CBCanvasPopup(CNVID canvasID, int nX, int nY, int nStepSize, int nPopupType);


///////////////////////////////////////////////////////
//
// Function: CBCanvasWidth
//
// Callback no: 65-CBCanvasWidth(ByVal canvasID As Long) As Long
//
// Parameters: canvasID - ID of canvas
//
// Action: Obtain width of a canvas
//
// Returns: width in pixels
//
///////////////////////////////////////////////////////
int CBCanvasWidth(CNVID canvasID);


///////////////////////////////////////////////////////
//
// Function: CBCanvasHeight
//
// Callback no: 66-CBCanvasHeight(ByVal canvasID As Long) As Long
//
// Parameters: canvasID - ID of canvas
//
// Action: Obtain height of a canvas
//
// Returns: height in pixels
//
///////////////////////////////////////////////////////
int CBCanvasHeight(CNVID canvasID);


///////////////////////////////////////////////////////
//
// Function: CBCanvasDrawLine
//
// Callback no: 67-CBCanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//
// Parameters: canvasID - ID of canvas
//						x1, y1 - starting point
//						x2, y2 - end point
//						crColor - color of line
//
// Action: Draw a line on a canvas
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBCanvasDrawLine(CNVID canvasID, int x1, int y1, int x2, int y2, long crColor);


///////////////////////////////////////////////////////
//
// Function: CBCanvasDrawRect
//
// Callback no: 68-CBCanvasDrawRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//
// Parameters: canvasID - ID of canvas
//						x1, y1 - starting point
//						x2, y2 - end point
//						crColor - color 
//
// Action: Draw a rect on a canvas
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBCanvasDrawRect(CNVID canvasID, int x1, int y1, int x2, int y2, long crColor);


///////////////////////////////////////////////////////
//
// Function: CBCanvasFillRect
//
// Callback no: 69-CBCanvasFillRect(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long) As Long
//
// Parameters: canvasID - ID of canvas
//						x1, y1 - starting point
//						x2, y2 - end point
//						crColor - color 
//
// Action: Draw a filled rect on a canvas
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBCanvasFillRect(CNVID canvasID, int x1, int y1, int x2, int y2, long crColor);


///////////////////////////////////////////////////////
//
// Function: CBCanvasDrawHand
//
// Callback no: 70-CBCanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long) As Long
//
// Parameters: canvasID - ID of canvas
//						nPointX, nPointY - coords to point at
//
// Action: Draw a hand pointing at a point
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBCanvasDrawHand(CNVID canvasID, int nPointX, int nPointY);



///////////////////////////////////////////////////////
//
// Function: CBDrawHand
//
// Callback no: 71-CBDrawHand(ByVal pointx As Long, ByVal pointy As Long) As Long
//
// Parameters: nPointX, nPointY - coords to point at
//
// Action: Draw a hand pointing at a point, use CBRefreshScreen afterwards
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBDrawHand(int nPointX, int nPointY);


///////////////////////////////////////////////////////
//
// Function: CBCheckKey
//
// Callback no: 72-CBCheckKey(ByVal keyPressed As String) As Long
//
// Parameters: strKey - key to check (you can also use LEFT, RIGHT, UP,
//							DOWN, ESC, ENTER, SPACE, BUTTON1..BUTTON4(for joystick buttons))
//							or JOYUP, JOYDOWN, JOYLEFT, JOYRIGHT explicitly for the joystick
//
// Action: Check if a key is pressed.
//
// Returns: 1 if it is pressed, 0 if it is not.
//
///////////////////////////////////////////////////////
int CBCheckKey(std::string strKey);


///////////////////////////////////////////////////////
//
// Function: CBPlaySound
//
// Callback no: 73-CBPlaySound(ByVal soundFile As String) As Long
//
// Parameters: strFile - sound file to play (do not include path info!)
//
// Action: Play a sound effect.
//
// Returns: 1
//
///////////////////////////////////////////////////////
int CBPlaySound(std::string strFile);


///////////////////////////////////////////////////////
//
// Function: CBMessageWindow
//
// Callback no: 74-CBMessageWindow(ByVal text As String, ByVal textColor As Long, ByVal bgColor As Long, ByVal bgPic As String, ByVal mbtype As Long) As Long
//
// Parameters: strText - text for message window
//						crTextColor - text color (optional)
//						crBGColor - window color (optional)
//						strBGPicFile - background image for window (no path info, please!) (optional)
//					  nType - Message window type (MW_OK or MW_YESNO) (optional)
//
// Action: Open a message window.
//
// Returns: Results of message window (MW_OK, MW_YES, MW_NO)
//
///////////////////////////////////////////////////////
int CBMessageWindow(std::string strText, long crTextColor = 16777216, long crBGColor = 0, std::string strBGPicFile = "", int nType = MW_OK);


///////////////////////////////////////////////////////
//
// Function: CBFileDialog
//
// Callback no: 75-CBFileDialog(ByVal initialPath As String, ByVal fileFilter As String) As String
//
// Parameters: strInitialPath - initial path for file dialog (include '\' at end)
//						strFileFilter - file filter to use (ie, *.* or *.sav, etc).
//
// Action: Open a file dialog.
//
// Returns: selected filename, or "" on cancel
//
///////////////////////////////////////////////////////
std::string CBFileDialog(std::string strInitialPath, std::string strFileFilter);


///////////////////////////////////////////////////////
//
// Function: CBDetermineSpecialMoves
//
// Callback no: 76-CBDetermineSpecialMoves(ByVal playerHandle As String) As Long
//
// Parameters: strPlayerHandle - handle of player to determine special moves for.
//
// Action: Create a list of special moves this player can do.  
//				Use CBGetSpecialMoveList to obtain the entries of this list.
//
// Returns: count of special moves the player can do.
//
///////////////////////////////////////////////////////
int CBDetermineSpecialMoves(std::string strPlayerHandle);


///////////////////////////////////////////////////////
//
// Function: CBGetSpecialMoveListEntry
//
// Callback no: 77-CBGetSpecialMoveListEntry(ByVal idx As Long) As String
//
// Parameters: nIndex - index of special move to get
//
// Action: Get an entry from the special move list (assumes
//			CBDetermineSpecialMoves was called first).
//
// Returns: filename of special move.
//
///////////////////////////////////////////////////////
std::string CBGetSpecialMoveListEntry(int nIndex);


///////////////////////////////////////////////////////
//
// Function: CBRunProgram
//
// Callback no: 78-CBRunProgram(ByVal prgFile As String)
//
// Parameters: strFile - filename of program to run (no path)
//
// Action: Run an RPGCode program.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBRunProgram(std::string strFile);


///////////////////////////////////////////////////////
//
// Function: CBSetTarget
//
// Callback no: 79-CBSetTarget(ByVal targetIdx As Long, ByVal tType As Long)
//
// Parameters: nTargetIndex - index of target
//						 nTargetType - type of target
//
// Action: Set RPGCode target
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetTarget(int nTargetIndex, int nTargetType);


///////////////////////////////////////////////////////
//
// Function: CBSetSource
//
// Callback no: 80-CBSetSource(ByVal sourceIdx As Long, ByVal sType As Long)
//
// Parameters: nSourceIndex - index of source
//						 nSourceType - type of source
//
// Action: Set RPGCode source
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetSource(int nSourceIndex, int nSourceType);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerHP
//
// Callback no: 81-Function CBGetPlayerHP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerHP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerMaxHP
//
// Callback no: 82-Function CBGetPlayerMaxHP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerMaxHP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerSMP
//
// Callback no: 83-Function CBGetPlayerSMP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerSMP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerMaxSMP
//
// Callback no: 84-Function CBGetPlayerMaxSMP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerMaxSMP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerFP
//
// Callback no: 85-Function CBGetPlayerFP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerFP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerDP
//
// Callback no: 86-Function CBGetPlayerDP(ByVal playerIdx As Long) As Double
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: double (you should probably cast to a long)
//
///////////////////////////////////////////////////////
double CBGetPlayerDP(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetPlayerName
//
// Callback no: 87-Function CBGetPlayerName(ByVal playerIdx As Long) As String
//
// Parameters: nPlayerIdx - player index
//
// Action: Get player stat
//
// Returns: std::string
//
///////////////////////////////////////////////////////
std::string CBGetPlayerName(int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBAddPlayerHP
//
// Callback no: 88-Sub CBAddPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of HP to add (negative removes HP)
//					   nPlayerIdx - player index
//
// Action: Change player HP.  Makes sure it doesn't go below 0 or 
//				above the MaxHP.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBAddPlayerHP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBAddPlayerSMP
//
// Callback no: 89-Sub CBAddPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of SMP to add (negative removes SMP)
//					   nPlayerIdx - player index
//
// Action: Change player SMP.  Makes sure it doesn't go below 0 or 
//				above the MaxSMP.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBAddPlayerSMP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetPlayerHP
//
// Callback no: 90-Sub CBSetPlayerHP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of HP to set
//					   nPlayerIdx - player index
//
// Action: Set player HP.  Makes sure it doesn't go below 0 or 
//				above the MaxHP.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerHP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetPlayerSMP
//
// Callback no: 91-Sub CBSetPlayerSMP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of SMP to set
//					   nPlayerIdx - player index
//
// Action: Set player SMP.  Makes sure it doesn't go below 0 or 
//				above the MaxSMP.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerSMP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetPlayerFP
//
// Callback no: 92-Sub CBSetPlayerFP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of FP to set
//					   nPlayerIdx - player index
//
// Action: Set player FP. 
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerFP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetPlayerDP
//
// Callback no: 93-Sub CBSetPlayerDP(ByVal amount As Long, ByVal playerIdx As Long)
//
// Parameters: nAmount - amount of DP to set
//					   nPlayerIdx - player index
//
// Action: Set player DP. 
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetPlayerDP(int nAmount, int nPlayerIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemyHP
//
// Callback no: 94-Function CBGetEnemyHP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemyHP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemyMaxHP
//
// Callback no: 95-Function CBGetEnemyMaxHP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemyMaxHP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemySMP
//
// Callback no: 96-Function CBGetEnemySMP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemySMP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemyMaxSMP
//
// Callback no: 97-Function CBGetEnemyMaxSMP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemyMaxSMP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemyFP
//
// Callback no: 98-Function CBGetEnemyFP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemyFP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBGetEnemyDP
//
// Callback no: 99-Function CBGetEnemyDP(ByVal eneIdx As Long) As Long
//
// Parameters: nEneIdx - index of enemy to get
//
// Action: Get enemy stat
//
// Returns: long
//
///////////////////////////////////////////////////////
long CBGetEnemyDP(int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBAddEnemyHP
//
// Callback no: 100-Sub CBAddEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
//
// Parameters: nAmount - amount to add 
//						 nEneIdx - index of enemy to get
//
// Action: Add HP to enemy (negative removes HP)
//				Ensures it does not go below 0 or above the max.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBAddEnemyHP(int nAmount, int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBAddEnemySMP
//
// Callback no: 101-Sub CBAddEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
//
// Parameters: nAmount - amount to add 
//						 nEneIdx - index of enemy to get
//
// Action: Add SMP to enemy (negative removes SMP)
//				Ensures it does not go below 0 or above the max.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBAddEnemySMP(int nAmount, int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetEnemyHP
//
// Callback no: 102-Sub CBSetEnemyHP(ByVal amount As Long, ByVal eneIdx As Long)
//
// Parameters: nAmount - amount to set 
//						 nEneIdx - index of enemy to get
//
// Action: Set HP to enemy
//				Ensures it does not go below 0 or above the max.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetEnemyHP(int nAmount, int nEneIdx);

///////////////////////////////////////////////////////
//
// Function: CBSetEnemySMP
//
// Callback no: 103-Sub CBSetEnemySMP(ByVal amount As Long, ByVal eneIdx As Long)
//
// Parameters: nAmount - amount to set 
//						 nEneIdx - index of enemy to get
//
// Action: Set SMP to enemy
//				Ensures it does not go below 0 or above the max.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBSetEnemySMP(int nAmount, int nEneIdx);


///////////////////////////////////////////////////////
//
// Function: CBCanvasDrawBackground
//
// Callback no: 104-Sub CBCanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
//
// Parameters: cnv - canvas to draw to
//						 strFile - fight background file to draw (don't include path info)
//						 nX - x location to draw to
//						 nY - y location to draw to
//						 nWidth - width
//						 nHeight - height
//
// Action: Draw a fight background onto a canvas
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasDrawBackground( CNVID cnv, std::string strFile, int nX, int nY, int nWidth, int nHeight );


///////////////////////////////////////////////////////
//
// Function: CBCreateAnimation
//
// Callback no: 105-Function CBCreateAnimation(ByVal file As String) As Long
//
// Parameters: strFile - file to load (with no path info)
//
// Action: Load an animation file, and return a handle we can reference it with
//
// Returns: ANMID - a handle you can use to refer to this animation
//
///////////////////////////////////////////////////////
ANMID CBCreateAnimation( std::string strFile );


///////////////////////////////////////////////////////
//
// Function: CBDestroyAnimation
//
// Callback no: 106-Sub CBDestroyAnimation(ByVal idx As Long)
//
// Parameters: anmID - animation handle to destory
//
// Action: Free up memory associated with a specific animation
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBDestroyAnimation( ANMID anmID );


///////////////////////////////////////////////////////
//
// Function: CBDestroyAnimation
//
// Callback no: 107-Sub CBCanvasDrawAnimation(ByVal canvasID As Long, ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal forceDraw As Long)
//
// Parameters: canvasID - canvas to draw to
//						 anmID - animation to draw
//						 nX, nY - position to draw animation to
//						 bForceDraw - if you force draw, it will force the frame to be drawn
//						 bFillWithTranspColor - if true, the canvas will be filled with the transparent color first
//
// Action: Draw an animation frame for animation anmID.
//				 You should call this function every 5ms if you can.
//				 This will draw the next frame & play the sound *only* if it is time
//				 for the animation's frame to be advanced (based upon the animation speed).
//				 You can set bForceDraw to false so you won't redraw an already drawn frame
//				 since most of the time the animation frame will not change.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasDrawAnimation( CNVID canvasID, ANMID anmID, int nX, int nY, bool bForceDraw, bool bFillWithTranspColor  );


///////////////////////////////////////////////////////
//
// Function: CBDestroyAnimation
//
// Callback no: 108-Sub CBCanvasDrawAnimationFrame(ByVal canvasID As Long, ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal forceTranspFill As Long)
//
// Parameters: canvasID - canvas to draw to
//						 anmID - animation to draw
//						 nFrame - frame to draw
//						 nX, nY - position to draw animation to
//						 bFillWithTranspColor - if true, the canvas will be filled with the transparent color first
//
// Action: Draw an animation frame for animation anmID.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBCanvasDrawAnimationFrame( CNVID canvasID, ANMID anmID, int nFrame, int nX, int nY, bool bFillWithTranspColor  );


///////////////////////////////////////////////////////
//
// Function: CBAnimationCurrentFrame
//
// Callback no: 109-Function CBAnimationCurrentFrame(ByVal idx As Long) As Long
//
// Parameters: anmID - animation we want
//
// Action: Get the current frame of the animation
//
// Returns: current frame
//
///////////////////////////////////////////////////////
int CBAnimationCurrentFrame( ANMID anmID );

///////////////////////////////////////////////////////
//
// Function: CBAnimationMaxFrames
//
// Callback no: 110-Function CBAnimationMaxFrames(ByVal idx As Long) As Long
//
// Parameters: anmID - animation we want
//
// Action: Get the max frame of the animation
//
// Returns: max frame
//
///////////////////////////////////////////////////////
int CBAnimationMaxFrames( ANMID anmID );

///////////////////////////////////////////////////////
//
// Function: CBAnimationSizeX
//
// Callback no: 111-Function CBAnimationSizeX(ByVal idx As Long) As Long
//
// Parameters: anmID - animation we want
//
// Action: Get the size of the animation
//
// Returns: size x
//
///////////////////////////////////////////////////////
int CBAnimationSizeX( ANMID anmID );

///////////////////////////////////////////////////////
//
// Function: CBAnimationSizeY
//
// Callback no: 112-Function CBAnimationSizeY(ByVal idx As Long) As Long
//
// Parameters: anmID - animation we want
//
// Action: Get the size of the animation
//
// Returns: size y
//
///////////////////////////////////////////////////////
int CBAnimationSizeY( ANMID anmID );

///////////////////////////////////////////////////////
//
// Function: CBAnimationFrameImage
//
// Callback no: 113-Function CBAnimationFrameImage(ByVal idx As Long, ByVal frame As Long) As String
//
// Parameters: anmID - animation we want
//						 nFrame - frame we want
//
// Action: Get the filename of the image at a frame of an animation
//
// Returns: filename
//
///////////////////////////////////////////////////////
std::string CBAnimationFrameImage( ANMID anmID, int nFrame );

///////////////////////////////////////////////////////
//
// Function: CBGetPartySize
//
// Callback no: 114-Function CBGetPartySize(ByVal partyIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//
// Action: Get the size of a fighting party (either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: number of fighters in the party
//
///////////////////////////////////////////////////////
int CBGetPartySize( int nPartyIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterHP
//
// Callback no: 115-Function CBGetFighterHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterHP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterMaxHP
//
// Callback no: 116-Function CBGetFighterMaxHP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterMaxHP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterSMP
//
// Callback no: 117-Function CBGetFighterSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterSMP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterMaxSMP
//
// Callback no: 118-Function CBGetFighterMaxSMP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterMaxSMP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterFP
//
// Callback no: 119-Function CBGetFighterFP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterFP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterDP
//
// Callback no: 120-Function CBGetFighterDP(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
int CBGetFighterDP( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterName
//
// Callback no: 121-Function CBGetFighterName(ByVal partyIdx As Long, ByVal fighterIdx As Long) As String
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get stat for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: stat
//
///////////////////////////////////////////////////////
std::string CBGetFighterName( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterAnimation
//
// Callback no: 122-Function CBGetFighterAnimation(ByVal partyIdx As Long, ByVal fighterIdx As Long, ByVal animationName As String) As String
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//						 strAnimationName - the animation filename we wish to get of:
//								"Rest", "Attack", "Defend", "Special Move" or "Die"
//
// Action: Get animation filename for a fighter in a party (party is either ENEMY_PARTY or PLAYER_PARTY)
//
// Returns: filename
//
///////////////////////////////////////////////////////
std::string CBGetFighterAnimation( int nPartyIdx, int nFighterIdx, std::string strAnimationName );

///////////////////////////////////////////////////////
//
// Function: CBGetFighterChargePercent
//
// Callback no: 123-Function CBGetFighterChargePercent(ByVal partyIdx As Long, ByVal fighterIdx As Long) As Long
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Get the percent of charge up the player has had ( charge up is the time between doing moves in a fight )
//
// Returns: charge percent
//
///////////////////////////////////////////////////////
int CBGetFighterChargePercent( int nPartyIdx, int nFighterIdx );


///////////////////////////////////////////////////////
//
// Function: CBFightTick
//
// Callback no: 124-Sub CBFightTick()
//
// Parameters: 
//
// Action: Allow the Toolkit to advance the fight charge of all the fighters by
//				one tick.  If an enemy becomes fully charged, it will attck, and we
//				will be informed about this attack by a call to TKPlugFightInform
//				If a player is charged, we will be informed about it by TKPlugFightInform
//
// Returns: 
//
///////////////////////////////////////////////////////
void CBFightTick();

///////////////////////////////////////////////////////
//
// Function: CBDrawTextAbsolute
//
// Callback no: 125-Function CBDrawTextAbsolute(ByVal text As String, ByVal font As String, ByVal size As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal isBold As Long, ByVal isItalics As Long, ByVal isUnderline As Long, ByVal isCentred As Long, byval isOutlined as long) As Long
//
// Parameters: strText - text to draw
//						 strFont - font to use
//						 nSize - size of font, in pixels
//						 x, y - coords to draw to (pixels)
//						 crColor - color to use
//						 bBold, bItalics, bUnderline - set to true if
//							you want these modifiers.
//						 bCentred - centre the text?
//						 bOutlined - outline text?
//
// Action: Draw text directly to the screen (remember to call CBRefreshScreen)
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBDrawTextAbsolute(std::string strText, std::string strFont, int nSize, int x, int y, long crColor, bool bBold, bool bItalics, bool bUnderline, bool bCentred, bool bOutlined = false);


///////////////////////////////////////////////////////
//
// Function: CBReleaseFighterCharge
//
// Callback no: 126-Sub CBReleaseFighterCharge(ByVal partyIdx As Long, ByVal fighterIdx As Long)
//
// Parameters: nPartyIdx - party we are talking about
//						 nFighterIdx - fighter in ther party we are talking about.
//
// Action: Set a fighters charge counter to 0 and unfreeze it.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBReleaseFighterCharge( int nPartyIdx, int nFighterIdx );

///////////////////////////////////////////////////////
//
// Function: CBFightDoAttack
//
// Callback no: 127-Function CBFightDoAttack(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal amount As Long, ByVal toSMP As Long) As Long
//
// Parameters: nSourcePartyIdx - source of attack
//						 nSourceFighterIdx - source of attack
//						 nTargetPartyIdx - target of attack
//						 nTargetFighterIdx - target of attack
//						 nAmount - FP of attack
//						 bSMP - is this an attack on SMP? (if false, it's an attack on HP)
//
// Action: Cause one fighter to attack another.
//				This results in an event being called into the fight plugin
//				Call GetNextFightEvent to obtain the results of this attack.
//				Send in a negative amount if you want it to be healing.
//
// Returns: actual amount of damage done
//
///////////////////////////////////////////////////////
int CBFightDoAttack( int nSourcePartyIdx, int nSourceFighterIdx, int nTargetPartyIdx, int nTargetFighterIdx, int nAmount, bool bSMP );

///////////////////////////////////////////////////////
//
// Function: CBFightUseItem
//
// Callback no: 128-Sub CBFightUseItem(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal itemFile As String)
//
// Parameters: nSourcePartyIdx - source of attack
//						 nSourceFighterIdx - source of attack
//						 nTargetPartyIdx - target of attack
//						 nTargetFighterIdx - target of attack
//						 strItemFile - Filename of item to use (no path)
//
// Action: Cause one fighter to use an item on another.
//				This results in an event being called into the fight plugin
//				Call GetNextFightEvent to obtain the results of this actionk.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBFightUseItem( int nSourcePartyIdx, int nSourceFighterIdx, int nTargetPartyIdx, int nTargetFighterIdx, std::string strItemFile );

///////////////////////////////////////////////////////
//
// Function: CBFightUseSpecialMove
//
// Callback no: 129-Sub CBFightUseSpecialMove(ByVal sourcePartyIdx As Long, ByVal sourceFightIdx As Long, ByVal targetPartyIdx As Long, ByVal targetFightIdx As Long, ByVal moveFile As String)
//
// Parameters: nSourcePartyIdx - source of attack
//						 nSourceFighterIdx - source of attack
//						 nTargetPartyIdx - target of attack
//						 nTargetFighterIdx - target of attack
//						 strMoveFile - Filename of special move to use (no path)
//
// Action: Cause one fighter to use a special move on another.
//				This results in an event being called into the fight plugin
//				Call GetNextFightEvent to obtain the results of this actionk.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBFightUseSpecialMove( int nSourcePartyIdx, int nSourceFighterIdx, int nTargetPartyIdx, int nTargetFighterIdx, std::string strMoveFile );

///////////////////////////////////////////////////////
//
// Function: CBDoEvents
//
// Callback no: 130-Sub CBDoEvents()
//
// Parameters: 
//
// Action: Allow Windows events to occur
//
// Returns: void
//
///////////////////////////////////////////////////////
void CBDoEvents();

#endif