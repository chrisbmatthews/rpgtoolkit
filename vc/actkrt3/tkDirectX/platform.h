//------------------------------------------------------------------------
// All contents copyright 2003, 2004, Christopher Matthews or Contributors
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Include file for DirectX interface
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Protect the file
//------------------------------------------------------------------------
#ifndef PLATFORM_H
#define PLATFORM_H

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#include <windows.h>					// For windows
#include <string>						// For strings
#include <ddraw.h>						// For DirectDraw
#include "..\tkCanvas\GDICanvas.h"		// For gdi canvas objects

//------------------------------------------------------------------------
// Definitions
//------------------------------------------------------------------------

// Initialize a DirectDraw struct
#define DD_INIT_STRUCT(x) \
	memset(&x, 0, sizeof(x)); \
	x.dwSize = sizeof(x)

// Standard calling conventions
#if !defined(INLINE) && !defined(FAST_CALL)
#	if defined(_MSC_VER)
#		define INLINE __inline		// VC++ prefers the __inline keyword
#		define FAST_CALL __fastcall
#	else
#		define INLINE inline
#		define FAST_CALL			// Register (fast) calls are specific to VC++
#	endif
#endif
#if !defined(DOUBLE)
typedef double DOUBLE;
#endif

//------------------------------------------------------------------------
// DirectX info structure
//------------------------------------------------------------------------
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

//------------------------------------------------------------------------
// Canvas class
//------------------------------------------------------------------------
class CGDICanvas;
#ifndef CNV_HANDLE
#define CNV_HANDLE int
#endif

//------------------------------------------------------------------------
// Prototypes
//------------------------------------------------------------------------
bool FAST_CALL InitGraphicsMode(HWND hostHwnd, int nWidth, int nHeight, bool bUseDirectX, long nColorDepth, bool bFullScreen);
bool FAST_CALL KillGraphicsMode();
bool FAST_CALL DrawPixel(int x, int y, long clr);
bool FAST_CALL DrawLine(int x1, int y1, int x2, int y2, long clr);
bool FAST_CALL DrawFilledRect(int x1, int y1, int x2, int y2, long clr);
bool FAST_CALL Refresh(CGDICanvas *cnv = NULL);
bool FAST_CALL DrawText(int x, int y, std::string strText, std::string strTypeFace, int size, long clr, bool bold = false, bool italics = false, bool underline = false, bool centred = false, bool outlined = false);
BOOL FAST_CALL CopyScreenToCanvas(CGDICanvas *pCanvas);
bool FAST_CALL DrawCanvas(CGDICanvas* pCanvas, int x, int y, long lRasterOp = SRCCOPY);
bool FAST_CALL DrawCanvasTransparent(CGDICanvas *pCanvas, int x, int y, long crTransparentColor);
bool FAST_CALL DrawCanvasTranslucent(CGDICanvas *pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
bool FAST_CALL DrawCanvasTranslucentPartial(const CGDICanvas *pCanvas, const int x, const int y, const int xSrc, const int ySrc, const int width, const int height, const double dIntensity, const long crUnaffectedColor, const long crTransparentColor);
bool FAST_CALL DrawCanvasPartial(CGDICanvas *pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp = SRCCOPY);
bool FAST_CALL DrawCanvasTransparentPartial(CGDICanvas *pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long crTransparentColor);
void FAST_CALL ClearScreen(long crColor);
long FAST_CALL GetPixelColor(int x, int y);
void FAST_CALL CloseDC(HDC hdc);
bool FAST_CALL LockScreen();
bool FAST_CALL UnlockScreen();
DXINFO FAST_CALL InitDirectX(HWND hWnd, int nWidth, int nHeight, long nColorDepth, bool bFullScreen);
HDC FAST_CALL OpenDC();
CGDICanvas *FAST_CALL CreateCanvas(int nWidth, int nHeight, bool bUseDX = false);

//------------------------------------------------------------------------
// End of the header file
//------------------------------------------------------------------------
#endif
