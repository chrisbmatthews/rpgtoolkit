//////////////////////////////////////////////////////////////////////////
//All contents copyright 2003, 2004, Christopher Matthews or Contributors
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Include file for DirectX interface
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Protect the file
//////////////////////////////////////////////////////////////////////////
#ifndef PLATFORM_H
#define PLATFORM_H

//////////////////////////////////////////////////////////////////////////
// Inclusions
//////////////////////////////////////////////////////////////////////////
#include <windows.h>					//for windows
#include <string>						//for strings
#include "ddraw.h"						//for DirectX
#include "..\tkCanvas\GDICanvas.h"		//for gdi canvas objects

//////////////////////////////////////////////////////////////////////////
// Definitions
//////////////////////////////////////////////////////////////////////////
#define CNV_HANDLE long					//Handle to a canvas

//////////////////////////////////////////////////////////////////////////
// DirectX info structure
//////////////////////////////////////////////////////////////////////////
typedef struct dxInfoTag
{
	bool bFullScreen;					// Running in fullscreen mode?
	int nColorDepth;					// Color depth
	int nWidth;							// Width of surface
	int nHeight;						// Height of surface
	LPDIRECTDRAW7 lpdd;					// Main direct draw object
	LPDIRECTDRAWSURFACE7 lpddsPrime;	// Direct draw primary surface
	LPDIRECTDRAWSURFACE7 lpddsSecond;	// Direct draw back buffer
	struct
	{
		LPDIRECTDRAWCLIPPER lpddClip;	// Clipper
		RECT surfaceRect;				// Rect of surface
		RECT destRect;					// Rect of window's client area
		DDBLTFX bltFx;					// Effects for the blt
	} windowedMode;
} DXINFO;

//////////////////////////////////////////////////////////////////////////
// Canvas class
//////////////////////////////////////////////////////////////////////////
class CGDICanvas;

//////////////////////////////////////////////////////////////////////////
// Prototypes
//////////////////////////////////////////////////////////////////////////
inline bool InitGraphicsMode(HWND hostHwnd, int nWidth, int nHeight, bool bUseDirectX, long nColorDepth, bool bFullScreen);
inline bool KillGraphicsMode();
inline bool DrawPixel(int x, int y, long clr);
inline bool DrawLine(int x1, int y1, int x2, int y2, long clr);
inline bool DrawFilledRect(int x1, int y1, int x2, int y2, long clr);
inline bool Refresh(CGDICanvas* cnv = NULL);
inline bool DrawText(int x, int y, std::string strText, std::string strTypeFace, int size, long clr, bool bold = false, bool italics = false, bool underline = false, bool centred = false, bool outlined = false);
inline BOOL CopyScreenToCanvas(CGDICanvas* pCanvas);
inline bool DrawCanvas(CGDICanvas* pCanvas, int x, int y, long lRasterOp = SRCCOPY);
inline bool DrawCanvasTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor);
inline bool DrawCanvasTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
inline bool DrawCanvasPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp = SRCCOPY);
inline bool DrawCanvasTransparentPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long crTransparentColor);
inline void ClearScreen(long crColor);
inline long GetPixelColor(int x, int y);
inline void CloseDC(HDC hdc);
inline bool LockScreen();
inline bool UnlockScreen();
inline DXINFO InitDirectX(HWND hWnd, int nWidth, int nHeight, long nColorDepth, bool bFullScreen);
inline HDC OpenDC();
inline CGDICanvas* CreateCanvas(int nWidth, int nHeight, bool bUseDX = false);

//////////////////////////////////////////////////////////////////////////
// Exports
//////////////////////////////////////////////////////////////////////////
int APIENTRY DXInitGfxMode(int hostHwnd, int nScreenX, int nScreenY, int nUseDirectX, int nColorDepth, int nFullScreen);
int APIENTRY DXKillGfxMode();
int APIENTRY DXDrawPixel(int x, int y, long clr);
int APIENTRY DXRefresh(CNV_HANDLE cnvHandle = NULL);
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

//////////////////////////////////////////////////////////////////////////
// End of the header file
//////////////////////////////////////////////////////////////////////////
#endif