//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

//////////////////////////////////
// tkDirectX.h
//
// Header for directX stuff 

#ifndef TKDIRECTX_H
#define TKDIRECTX_H

#include "..\GUISystem\platform\platform.h"
#define CNV_HANDLE long
//#include "..\tkCanvas\tkCanvas.h"

int APIENTRY DXInitGfxMode( int hostHwnd, long nScreenX, long nScreenY, long nUseDirectX, long nColorDepth, long nFullScreen );

int APIENTRY DXKillGfxMode();

int APIENTRY DXDrawPixel(int x, int y, long clr);

int APIENTRY DXRefresh();

int APIENTRY DXLockScreen();

int APIENTRY DXUnlockScreen();

int APIENTRY DXDrawCanvas(CNV_HANDLE cnv, int x, int y, long lRasterOp = SRCCOPY);

int APIENTRY DXDrawCanvasTransparent(CNV_HANDLE cnv, int x, int y, long crTransparentColor);

int APIENTRY DXDrawCanvasTranslucent(CNV_HANDLE cnv, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);

int APIENTRY DXClearScreen(long crColor);

int APIENTRY DXDrawText(int x, int y, char* strText, char* strTypeFace, int size, long clr, int bold = 0, int italics = 0, int underline = 0, int centred = 0, int outlined = 0);

int APIENTRY DXDrawCanvasPartial(CNV_HANDLE cnv, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp = SRCCOPY);

int APIENTRY DXDrawCanvasTransparentPartial(CNV_HANDLE cnv, int destx, int desty, int srcx, int srcy, int width, int height, long crTrasparentColor);

int APIENTRY DXCopyScreenToCanvas(CNV_HANDLE cnv);

#endif