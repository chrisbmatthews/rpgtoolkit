/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "stdafx.h"
#include "../trans3.h"
#include "Callbacks.h"
#include "../rpgcode/CProgram/CProgram.h"
#include "../common/CAllocationHeap.h"
#include "../common/paths.h"
#include "../common/CFile.h"
#include "../common/animation.h"
#include "../common/board.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../images/FreeImage.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkCanvas/GDICanvas.h"

extern CAllocationHeap<CGDICanvas> g_canvases;
extern CDirectDraw *g_pDirectDraw;
extern std::vector<CPlayer *> g_players;
CAllocationHeap<ANIMATION> g_animations;

inline std::string getString(const BSTR bstr)
{
	const int length = SysStringLen(bstr) + 1;
	char *const str = new char[length];
	WideCharToMultiByte(CP_ACP, 0, bstr, -1, str, length, NULL, NULL);
	const std::string toRet = str;
	delete [] str;
	return toRet;
}

inline BSTR getString(const std::string rhs)
{
	wchar_t *str = new wchar_t[rhs.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1);
	const BSTR toRet = SysAllocString(str);
	delete [] str;
	return toRet;
}

STDMETHODIMP CCallbacks::CBRpgCode(BSTR rpgcodeCommand)
{
	CProgram().runLine(getString(rpgcodeCommand));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetString(BSTR varname, BSTR *pRet)
{
	SysReAllocString(pRet, getString(CProgram::getGlobal(getString(varname)).getLit()));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetNumerical(BSTR varname, double *pRet)
{
	*pRet = CProgram::getGlobal(getString(varname)).getNum();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetString(BSTR varname, BSTR newValue)
{
	CProgram::setGlobal(getString(varname), getString(newValue));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetNumerical(BSTR varname, double newValue)
{
	CProgram::setGlobal(getString(varname), newValue);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScreenDC(int *pRet)
{
	extern HWND g_hHostWnd;
	*pRet = (int)GetDC(g_hHostWnd);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScratch1DC(int *pRet)
{
	*pRet = NULL; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScratch2DC(int *pRet)
{
	*pRet = NULL; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetMwinDC(int *pRet)
{
	*pRet = NULL; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBPopupMwin(int *pRet)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = true;
	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBHideMwin(int *pRet)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadEnemy(BSTR *file, int *eneSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyNum(int infoCode, int eneSlot, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyString(int infoCode, int eneSlot, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyNum(int infoCode, int newValue, int eneSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyString(int infoCode, BSTR newValue, int eneSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerNum(int infoCode, int arrayPos, int playerSlot, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerString(int infoCode, int arrayPos, int playerSlot, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerNum(int infoCode, int arrayPos, int newVal, int playerSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerString(int infoCode, int arrayPos, BSTR newVal, int playerSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetGeneralString(int infoCode, int arrayPos, int playerSlot, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetGeneralNum(int infoCode, int arrayPos, int playerSlot, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetGeneralString(int infoCode, int arrayPos, int playerSlot, BSTR newVal)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetGeneralNum(int infoCode, int arrayPos, int playerSlot, int newVal)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetCommandName(BSTR rpgcodeCommand, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBrackets(BSTR rpgcodeCommand, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCountBracketElements(BSTR rpgcodeCommand, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBracketElement(BSTR rpgcodeCommand, int elemNum, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetStringElementValue(BSTR rpgcodeCommand, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetNumElementValue(BSTR rpgcodeCommand, double *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetElementType(BSTR data, int *pRet)
{
	const CVariant::DATA_TYPE dt = CProgram::getCurrentProgram()->constructVariant(getString(data)).getType();
	if (dt == CVariant::DT_NUM) *pRet = PLUG_DT_NUM;
	else if (dt == CVariant::DT_LIT) *pRet = PLUG_DT_LIT;
	else *pRet = PLUG_DT_VOID; // No object support for plugins.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDebugMessage(BSTR message)
{
	CProgram::debugger(getString(message));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPathString(int infoCode, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadSpecialMove(BSTR file)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveString(int infoCode, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveNum(int infoCode, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadItem(BSTR file, int itmSlot)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetItemString(int infoCode, int arrayPos, int itmSlot, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetItemNum(int infoCode, int arrayPos, int itmSlot, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBoardNum(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int *pRet)
{
	extern BOARD g_activeBoard;
	switch (infoCode)
	{
		case BRD_SIZEX:
			*pRet = g_activeBoard.bSizeX;
			break;
		case BRD_SIZEY:
			*pRet = g_activeBoard.bSizeY;
			break;
		case BRD_AMBIENTRED:
			*pRet = g_activeBoard.ambientRed[arrayPos1][arrayPos2][arrayPos3];
			break;
		case BRD_AMBIENTGREEN:
			*pRet = g_activeBoard.ambientGreen[arrayPos1][arrayPos2][arrayPos3];
			break;
		case BRD_AMBIENTBLUE:
			*pRet = g_activeBoard.ambientBlue[arrayPos1][arrayPos2][arrayPos3];
			break;
		case BRD_TILETYPE:
			*pRet = g_activeBoard.tiletype[arrayPos1][arrayPos2][arrayPos3];
			break;
		case BRD_BACKCOLOR:
			*pRet = g_activeBoard.brdColor;
			break;
		case BRD_BORDERCOLOR:
			*pRet = g_activeBoard.borderColor;
			break;
		case BRD_SKILL:
			*pRet = g_activeBoard.boardSkill;
			break;
		case BRD_FIGHTINGYN:
			*pRet = g_activeBoard.fightingYN;
			break;
		case BRD_PRG_X:
			// [...]
			break;
	}
	// THIS IS NOT FINISHED!
	//////////////////////////////////////////////
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBoardString(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetBoardNum(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int nValue)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetBoardString(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR newVal)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetHwnd(int *pRet)
{
	extern HWND g_hHostWnd;
	*pRet = (int)g_hHostWnd;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBRefreshScreen(int *pRet)
{
	*pRet = g_pDirectDraw->Refresh();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCreateCanvas(int width, int height, int *pRet)
{
	CGDICanvas *p = g_canvases.allocate();
	p->CreateBlank(NULL, width, height, TRUE);
	*pRet = (int)p;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDestroyCanvas(int canvasID, int *pRet)
{
	*pRet = (int)g_canvases.free((CGDICanvas *)canvasID);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvas(int canvasID, int x, int y, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvas(p, x, y, SRCCOPY);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasPartial(int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasPartial(p, xDest, yDest, xsrc, ysrc, width, height, SRCCOPY);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTransparent(int canvasID, int x, int y, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTransparent(p, x, y, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTransparentPartial(int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTransparentPartial(p, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTranslucent(int canvasID, int x, int y, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTranslucent(p, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasLoadImage(int canvasID, BSTR filename, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		extern std::string g_projectPath;
		const std::string file = g_projectPath + BMP_PATH + getString(filename);
		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(file.c_str(), 16), file.c_str());
		const HDC hdc = p->OpenDC();
		*pRet = StretchDIBits(hdc, 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
		p->CloseDC(hdc);
		FreeImage_Unload(bmp);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasLoadSizedImage(int canvasID, BSTR filename, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		extern std::string g_projectPath;
		const std::string file = g_projectPath + BMP_PATH + getString(filename);
		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(file.c_str(), 16), file.c_str());
		const HDC hdc = p->OpenDC();
		*pRet = StretchDIBits(hdc, 0, 0, p->GetWidth(), p->GetHeight(), 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
		p->CloseDC(hdc);
		FreeImage_Unload(bmp);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasFill(int canvasID, int crColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (*pRet = (p != NULL))
	{
		p->ClearScreen(crColor);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasResize(int canvasID, int width, int height, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (*pRet = (p != NULL))
	{
		p->Resize(NULL, width, height);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBlt(int cnvSrc, int cnvDest, int xDest, int yDest, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CGDICanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->Blt(pDest, xDest, yDest, SRCCOPY);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltPartial(int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CGDICanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltPart(pDest, xDest, yDest, xsrc, ysrc, width, height, SRCCOPY);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTransparent(int cnvSrc, int cnvDest, int xDest, int yDest, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CGDICanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTransparent(pDest, xDest, yDest, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTransparentPartial(int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CGDICanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTransparentPart(pDest, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTranslucent(int cnvSrc, int cnvDest, int destX, int destY, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CGDICanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTranslucent(pDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasGetScreen(int cnvDest, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnvDest);
	if (p)
	{
		*pRet = g_pDirectDraw->CopyScreenToCanvas(p);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadString(int id, BSTR defaultString, BSTR *pRet)
{
	// Translations?
	SysReAllocString(pRet, defaultString); // Just return default.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawText(int canvasID, BSTR text, BSTR font, int size, double x, double y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->DrawText(x, y, getString(text), getString(font), size, crColor, isBold, isItalics, isUnderline, isCentred);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasPopup(int canvasID, int x, int y, int stepSize, int popupType, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasWidth(int canvasID, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->GetWidth();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasHeight(int canvasID, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->GetHeight();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawLine(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawRect(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasFillRect(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawHand(int canvasID, int pointx, int pointy, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawHand(int pointx, int pointy, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCheckKey(BSTR keyPressed, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBPlaySound(BSTR soundFile, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBMessageWindow(BSTR text, int textColor, int bgColor, BSTR bgPic, int mbtype, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFileDialog(BSTR initialPath, BSTR fileFilter, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDetermineSpecialMoves(BSTR playerHandle, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveListEntry(int idx, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBRunProgram(BSTR prgFile)
{
	CProgram(getString(prgFile)).run();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetTarget(int targetIdx, int ttype)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetSource(int sourceIdx, int sType)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerHP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->health();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerMaxHP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->maxHealth();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerSMP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->smp();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerMaxSMP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->maxSmp();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerFP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->fight();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerDP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->defence();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerName(int playerIdx, BSTR *pRet)
{
	if (g_players.size() > playerIdx)
	{
		SysReAllocString(pRet, getString(g_players[playerIdx]->name()));
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddPlayerHP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->health(g_players[playerIdx]->health() + amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddPlayerSMP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->smp(g_players[playerIdx]->smp() + amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerHP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->health(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerSMP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->smp(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerFP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->fight(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerDP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->defence(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyHP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyMaxHP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemySMP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyMaxSMP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyFP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyDP(int eneIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddEnemyHP(int amount, int eneIdx)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddEnemySMP(int amount, int eneIdx)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyHP(int amount, int eneIdx)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemySMP(int amount, int eneIdx)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawBackground(int canvasID, BSTR bkgFile, int x, int y, int width, int height)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCreateAnimation(BSTR file, int *pRet)
{
	LPANIMATION p = g_animations.allocate();
	p->open(getString(file));
	*pRet = (int)p;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDestroyAnimation(int idx)
{
	g_animations.free((LPANIMATION)idx);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawAnimation(int canvasID, int idx, int x, int y, int forceDraw)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawAnimationFrame(int canvasID, int idx, int frame, int x, int y, int forceTranspFill)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationCurrentFrame(int idx, int *pRet)
{
	LPANIMATION p = g_animations.cast(idx);
	*pRet = (p ? p->currentAnmFrame : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationMaxFrames(int idx, int *pRet)
{
	LPANIMATION p = g_animations.cast(idx);
	*pRet = (p ? p->animFrames : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationSizeX(int idx, int *pRet)
{
	LPANIMATION p = g_animations.cast(idx);
	*pRet = (p ? p->animSizeX : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationSizeY(int idx, int *pRet)
{
	LPANIMATION p = g_animations.cast(idx);
	*pRet = (p ? p->animSizeY : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationFrameImage(int idx, int frame, BSTR *pRet)
{
	LPANIMATION p = g_animations.cast(idx);
	if (p && (p->animFrames > frame))
	{
		SysReAllocString(pRet, getString(p->animFrame[frame]));
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPartySize(int partyIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterHP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterMaxHP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterSMP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterMaxSMP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterFP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterDP(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterName(int partyIdx, int fighterIdx, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterAnimation(int partyIdx, int fighterIdx, BSTR animationName, BSTR *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterChargePercent(int partyIdx, int fighterIdx, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightTick(void)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawTextAbsolute(BSTR text, BSTR font, int size, int x, int y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int *pRet)
{
	*pRet = g_pDirectDraw->DrawText(x, y, getString(text), getString(font), size, crColor, isBold, isItalics, isUnderline, isCentred);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBReleaseFighterCharge(int partyIdx, int fighterIdx)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightDoAttack(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, int amount, int toSMP, int *pRet)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightUseItem(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR itemFile)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightUseSpecialMove(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR moveFile)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDoEvents(void)
{
	extern void processEvent(void);
	processEvent();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFighterAddStatusEffect(int partyIdx, int fightIdx, BSTR statusFile)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFighterRemoveStatusEffect(int partyIdx, int fightIdx, BSTR statusFile)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCheckMusic(void)
{
	// Obsolete. Do nothing.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBReleaseScreenDC(void)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawImageHDC(BSTR file, int x, int y, int hdc)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawSizedImageHDC(BSTR file, int x, int y, int width, int height, int hdc)
{
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasOpenHdc(int cnv, int *pRet)
{
	CGDICanvas *p = g_canvases.cast(cnv);
	if (p)
	{
		*pRet = (int)p->OpenDC();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasCloseHdc(int cnv, int hdc)
{
	CGDICanvas *p = g_canvases.cast(cnv);
	if (p)
	{
		p->CloseDC((HDC)hdc);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFileExists(BSTR strFile, VARIANT_BOOL *pRet)
{
	extern std::string g_projectPath;
	*pRet = (CFile::fileExists(g_projectPath + getString(strFile)) ? VARIANT_TRUE : VARIANT_FALSE);
	return S_OK;
}
