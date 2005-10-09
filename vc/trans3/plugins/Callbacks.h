/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CALLBACKS_H_
#define _CALLBACKS_H_

#include "../resource.h"

/////////////////////////////////////////////////////////////////////////////
// CCallbacks
class ATL_NO_VTABLE CCallbacks : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CCallbacks, &CLSID_Callbacks>,
	public IDispatchImpl<ICallbacks, &IID_ICallbacks, &LIBID_TRANS3Lib>
{
public:

	DECLARE_REGISTRY_RESOURCEID(IDR_CALLBACKS)
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	BEGIN_COM_MAP(CCallbacks)
		COM_INTERFACE_ENTRY(ICallbacks)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

// ICallbacks
public:
	STDMETHOD(CBRpgCode) (BSTR rpgcodeCommand);
	STDMETHOD(CBGetString) (BSTR varname, BSTR *pRet);
	STDMETHOD(CBGetNumerical) (BSTR varname, double *pRet);
	STDMETHOD(CBSetString) (BSTR varname, BSTR newValue);
	STDMETHOD(CBSetNumerical) (BSTR varname, double newValue);
	STDMETHOD(CBGetScreenDC) (int *pRet);
	STDMETHOD(CBGetScratch1DC) (int *pRet);
	STDMETHOD(CBGetScratch2DC) (int *pRet);
	STDMETHOD(CBGetMwinDC) (int *pRet);
	STDMETHOD(CBPopupMwin) (int *pRet);
	STDMETHOD(CBHideMwin) (int *pRet);
	STDMETHOD(CBLoadEnemy) (BSTR file, int eneSlot);
	STDMETHOD(CBGetEnemyNum) (int infoCode, int eneSlot, int *pRet);
	STDMETHOD(CBGetEnemyString) (int infoCode, int eneSlot, BSTR *pRet);
	STDMETHOD(CBSetEnemyNum) (int infoCode, int newValue, int eneSlot);
	STDMETHOD(CBSetEnemyString) (int infoCode, BSTR newValue, int eneSlot);
	STDMETHOD(CBGetPlayerNum) (int infoCode, int arrayPos, int playerSlot, int *pRet);
	STDMETHOD(CBGetPlayerString) (int infoCode, int arrayPos, int playerSlot, BSTR *pRet);
	STDMETHOD(CBSetPlayerNum) (int infoCode, int arrayPos, int newVal, int playerSlot);
	STDMETHOD(CBSetPlayerString) (int infoCode, int arrayPos, BSTR newVal, int playerSlot);
	STDMETHOD(CBGetGeneralString) (int infoCode, int arrayPos, int playerSlot, BSTR *pRet);
	STDMETHOD(CBGetGeneralNum) (int infoCode, int arrayPos, int playerSlot, int *pRet);
	STDMETHOD(CBSetGeneralString) (int infoCode, int arrayPos, int playerSlot, BSTR newVal);
	STDMETHOD(CBSetGeneralNum) (int infoCode, int arrayPos, int playerSlot, int newVal);
	STDMETHOD(CBGetCommandName) (BSTR rpgcodeCommand, BSTR *pRet);
	STDMETHOD(CBGetBrackets) (BSTR rpgcodeCommand, BSTR *pRet);
	STDMETHOD(CBCountBracketElements) (BSTR rpgcodeCommand, int *pRet);
	STDMETHOD(CBGetBracketElement) (BSTR rpgcodeCommand, int elemNum, BSTR *pRet);
	STDMETHOD(CBGetStringElementValue) (BSTR rpgcodeCommand, BSTR *pRet);
	STDMETHOD(CBGetNumElementValue) (BSTR rpgcodeCommand, double *pRet);
	STDMETHOD(CBGetElementType) (BSTR rpgcodeCommand, int *pRet);
	STDMETHOD(CBDebugMessage) (BSTR message);
	STDMETHOD(CBGetPathString) (int infoCode, BSTR *pRet);
	STDMETHOD(CBLoadSpecialMove) (BSTR file);
	STDMETHOD(CBGetSpecialMoveString) (int infoCode, BSTR *pRet);
	STDMETHOD(CBGetSpecialMoveNum) (int infoCode, int *pRet);
	STDMETHOD(CBLoadItem) (BSTR file, int itmSlot);
	STDMETHOD(CBGetItemString) (int infoCode, int arrayPos, int itmSlot, BSTR *pRet);
	STDMETHOD(CBGetItemNum) (int infoCode, int arrayPos, int itmSlot, int *pRet);
	STDMETHOD(CBGetBoardNum) (int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int *pRet);
	STDMETHOD(CBGetBoardString) (int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR *pRet);
	STDMETHOD(CBSetBoardNum) (int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int nValue);
	STDMETHOD(CBSetBoardString) (int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR newVal);
	STDMETHOD(CBGetHwnd) (int *pRet);
	STDMETHOD(CBRefreshScreen) (int *pRet);
	STDMETHOD(CBCreateCanvas) (int width, int height, int *pRet);
	STDMETHOD(CBDestroyCanvas) (int canvasID, int *pRet);
	STDMETHOD(CBDrawCanvas) (int canvasID, int x, int y, int *pRet);
	STDMETHOD(CBDrawCanvasPartial) (int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet);
	STDMETHOD(CBDrawCanvasTransparent) (int canvasID, int x, int y, int crTransparentColor, int *pRet);
	STDMETHOD(CBDrawCanvasTransparentPartial) (int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet);
	STDMETHOD(CBDrawCanvasTranslucent) (int canvasID, int x, int y, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet);
	STDMETHOD(CBCanvasLoadImage) (int canvasID, BSTR filename, int *pRet);
	STDMETHOD(CBCanvasLoadSizedImage) (int canvasID, BSTR filename, int *pRet);
	STDMETHOD(CBCanvasFill) (int canvasID, int crColor, int *pRet);
	STDMETHOD(CBCanvasResize) (int canvasID, int width, int height, int *pRet);
	STDMETHOD(CBCanvas2CanvasBlt) (int cnvSrc, int cnvDest, int xDest, int yDest, int *pRet);
	STDMETHOD(CBCanvas2CanvasBltPartial) (int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet);
	STDMETHOD(CBCanvas2CanvasBltTransparent) (int cnvSrc, int cnvDest, int xDest, int yDest, int crTransparentColor, int *pRet);
	STDMETHOD(CBCanvas2CanvasBltTransparentPartial) (int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet);
	STDMETHOD(CBCanvas2CanvasBltTranslucent) (int cnvSrc, int cnvDest, int destX, int destY, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet);
	STDMETHOD(CBCanvasGetScreen) (int cnvDest, int *pRet);
	STDMETHOD(CBLoadString) (int id, BSTR defaultString, BSTR *pRet);
	STDMETHOD(CBCanvasDrawText) (int canvasID, BSTR text, BSTR font, int size, double x, double y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int *pRet);
	STDMETHOD(CBCanvasPopup) (int canvasID, int x, int y, int stepSize, int popupType, int *pRet);
	STDMETHOD(CBCanvasWidth) (int canvasID, int *pRet);
	STDMETHOD(CBCanvasHeight) (int canvasID, int *pRet);
	STDMETHOD(CBCanvasDrawLine) (int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet);
	STDMETHOD(CBCanvasDrawRect) (int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet);
	STDMETHOD(CBCanvasFillRect) (int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet);
	STDMETHOD(CBCanvasDrawHand) (int canvasID, int pointx, int pointy, int *pRet);
	STDMETHOD(CBDrawHand) (int pointx, int pointy, int *pRet);
	STDMETHOD(CBCheckKey) (BSTR keyPressed, int *pRet);
	STDMETHOD(CBPlaySound) (BSTR soundFile, int *pRet);
	STDMETHOD(CBMessageWindow) (BSTR text, int textColor, int bgColor, BSTR bgPic, int mbtype, int *pRet);
	STDMETHOD(CBFileDialog) (BSTR initialPath, BSTR fileFilter, BSTR *pRet);
	STDMETHOD(CBDetermineSpecialMoves) (BSTR playerHandle, int *pRet);
	STDMETHOD(CBGetSpecialMoveListEntry) (int idx, BSTR *pRet);
	STDMETHOD(CBRunProgram) (BSTR prgFile);
	STDMETHOD(CBSetTarget) (int targetIdx, int ttype);
	STDMETHOD(CBSetSource) (int sourceIdx, int sType);
	STDMETHOD(CBGetPlayerHP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerMaxHP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerSMP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerMaxSMP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerFP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerDP) (int playerIdx, double *pRet);
	STDMETHOD(CBGetPlayerName) (int playerIdx, BSTR *pRet);
	STDMETHOD(CBAddPlayerHP) (int amount, int playerIdx);
	STDMETHOD(CBAddPlayerSMP) (int amount, int playerIdx);
	STDMETHOD(CBSetPlayerHP) (int amount, int playerIdx);
	STDMETHOD(CBSetPlayerSMP) (int amount, int playerIdx);
	STDMETHOD(CBSetPlayerFP) (int amount, int playerIdx);
	STDMETHOD(CBSetPlayerDP) (int amount, int playerIdx);
	STDMETHOD(CBGetEnemyHP) (int eneIdx, int *pRet);
	STDMETHOD(CBGetEnemyMaxHP) (int eneIdx, int *pRet);
	STDMETHOD(CBGetEnemySMP) (int eneIdx, int *pRet);
	STDMETHOD(CBGetEnemyMaxSMP) (int eneIdx, int *pRet);
	STDMETHOD(CBGetEnemyFP) (int eneIdx, int *pRet);
	STDMETHOD(CBGetEnemyDP) (int eneIdx, int *pRet);
	STDMETHOD(CBAddEnemyHP) (int amount, int eneIdx);
	STDMETHOD(CBAddEnemySMP) (int amount, int eneIdx);
	STDMETHOD(CBSetEnemyHP) (int amount, int eneIdx);
	STDMETHOD(CBSetEnemySMP) (int amount, int eneIdx);
	STDMETHOD(CBCanvasDrawBackground) (int canvasID, BSTR bkgFile, int x, int y, int width, int height);
	STDMETHOD(CBCreateAnimation) (BSTR file, int *pRet);
	STDMETHOD(CBDestroyAnimation) (int idx);
	STDMETHOD(CBCanvasDrawAnimation) (int canvasID, int idx, int x, int y, int forceDraw, int forceTransp);
	STDMETHOD(CBCanvasDrawAnimationFrame) (int canvasID, int idx, int frame, int x, int y, int forceTranspFill);
	STDMETHOD(CBAnimationCurrentFrame) (int idx, int *pRet);
	STDMETHOD(CBAnimationMaxFrames) (int idx, int *pRet);
	STDMETHOD(CBAnimationSizeX) (int idx, int *pRet);
	STDMETHOD(CBAnimationSizeY) (int idx, int *pRet);
	STDMETHOD(CBAnimationFrameImage) (int idx, int frame, BSTR *pRet);
	STDMETHOD(CBGetPartySize) (int partyIdx, int *pRet);
	STDMETHOD(CBGetFighterHP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterMaxHP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterSMP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterMaxSMP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterFP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterDP) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBGetFighterName) (int partyIdx, int fighterIdx, BSTR *pRet);
	STDMETHOD(CBGetFighterAnimation) (int partyIdx, int fighterIdx, BSTR animationName, BSTR *pRet);
	STDMETHOD(CBGetFighterChargePercent) (int partyIdx, int fighterIdx, int *pRet);
	STDMETHOD(CBFightTick) ();
	STDMETHOD(CBDrawTextAbsolute) (BSTR text, BSTR font, int size, int x, int y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int *pRet);
	STDMETHOD(CBReleaseFighterCharge) (int partyIdx, int fighterIdx);
	STDMETHOD(CBFightDoAttack) (int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, int amount, int toSMP, int *pRet);
	STDMETHOD(CBFightUseItem) (int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR itemFile);
	STDMETHOD(CBFightUseSpecialMove) (int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR moveFile);
	STDMETHOD(CBDoEvents) ();
	STDMETHOD(CBFighterAddStatusEffect) (int partyIdx, int fightIdx, BSTR statusFile);
	STDMETHOD(CBFighterRemoveStatusEffect) (int partyIdx, int fightIdx, BSTR statusFile);
	STDMETHOD(CBCheckMusic) ();
	STDMETHOD(CBReleaseScreenDC) ();
	STDMETHOD(CBCanvasOpenHdc) (int cnv, int *pRet);
	STDMETHOD(CBCanvasCloseHdc) (int cnv, int hdc);
	STDMETHOD(CBFileExists) (BSTR strFile, short *pRet);
};

#endif //_CALLBACKS_H_
