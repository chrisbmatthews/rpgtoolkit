//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

//////////////////////////////////
// tkDirectX.cpp
//
// Implementation for directX stuff 


#include "tkDirectX.h"

int APIENTRY DXInitGfxMode( int hostHwnd, long nScreenX, long nScreenY, long nUseDirectX, long nColorDepth, long nFullScreen  )
{
	//go into graphics mode
	bool bUseDX = false;
	bool bFullScreen = false;
	if (nFullScreen == 1)
	{
		bFullScreen = true;
	}
	if (nUseDirectX == 1)
	{
		bUseDX = true;
	}
	bool bRet = InitGraphicsMode((HWND)hostHwnd, nScreenX, nScreenY, bUseDX, nColorDepth, bFullScreen);

	if (bRet)
		return 1;
	else
		return 0;
}


int APIENTRY DXKillGfxMode()
{
	KillGraphicsMode();

	return 1;
}


int APIENTRY DXDrawPixel(int x, int y, long clr)
{
	return (int)DrawPixel(x, y, clr);
}


int APIENTRY DXRefresh()
{
	return (int)Refresh();
}


int APIENTRY DXLockScreen()
{
	return (int)LockScreen();
}

int APIENTRY DXUnlockScreen()
{
	return (int)UnlockScreen();
}


int APIENTRY DXDrawCanvas(CNV_HANDLE cnv, int x, int y, long lRasterOp)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return (int)DrawCanvas(pCnv, x, y, lRasterOp);
}

int APIENTRY DXDrawCanvasTransparent(CNV_HANDLE cnv, int x, int y, long crTransparentColor)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return (int)DrawCanvasTransparent(pCnv, x, y, crTransparentColor);
}

int APIENTRY DXDrawCanvasTranslucent(CNV_HANDLE cnv, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return (int)DrawCanvasTranslucent(pCnv, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
}

int APIENTRY DXClearScreen(long crColor)
{
	ClearScreen(crColor);
	return 1;
}

int APIENTRY DXDrawText(int x, int y, char* strText, char* strTypeFace, int size, long clr, int bold, int italics, int underline, int centred, int outlined)
{
	return (int)DrawText(x, y, strText, strTypeFace, size, clr, (bool)bold, (bool)italics, (bool)underline, (bool)centred, (bool)outlined);
}

int APIENTRY DXDrawCanvasPartial(CNV_HANDLE cnv, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return (int)DrawCanvasPartial(pCnv, destx, desty, srcx, srcy, width, height, lRasterOp);
}

int APIENTRY DXDrawCanvasTransparentPartial(CNV_HANDLE cnv, int destx, int desty, int srcx, int srcy, int width, int height, long crTransparentColor)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return (int)DrawCanvasTransparentPartial(pCnv, destx, desty, srcx, srcy, width, height, crTransparentColor);
}

int APIENTRY DXCopyScreenToCanvas(CNV_HANDLE cnv)
{
	CGDICanvas* pCnv = (CGDICanvas*)cnv;
	return CopyScreenToCanvas(pCnv);
}