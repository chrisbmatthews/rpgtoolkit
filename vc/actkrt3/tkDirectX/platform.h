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
#if !defined(STATIC)
#define STATIC static
#endif

//------------------------------------------------------------------------
// DirectX info structure
//------------------------------------------------------------------------
typedef struct dxInfoTag
{
	BOOL bFullScreen;					// Running in fullscreen mode?
	INT nColorDepth;					// Color depth
	INT nWidth;							// Width of surface
	INT nHeight;						// Height of surface
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
#define CNV_HANDLE INT
#endif

//------------------------------------------------------------------------
// Prototypes
//------------------------------------------------------------------------

BOOL FAST_CALL InitGraphicsMode(
	CONST HWND hostHwnd,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST BOOL bUseDirectX,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
);

BOOL FAST_CALL KillGraphicsMode(
	VOID
);

BOOL FAST_CALL DrawPixel(
	CONST INT x,
	CONST INT y,
	CONST LONG clr
);

BOOL FAST_CALL DrawLine(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
);

BOOL FAST_CALL DrawFilledRect(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
);

BOOL FAST_CALL Refresh(
	CONST CGDICanvas *cnv = NULL
);

BOOL FAST_CALL DrawText(
	CONST INT x,
	CONST INT y,
	CONST std::string strText,
	CONST std::string strTypeFace,
	CONST INT size,
	CONST LONG clr,
	CONST BOOL bold = FALSE,
	CONST BOOL italics = FALSE,
	CONST BOOL underline = FALSE,
	CONST BOOL centred = FALSE,
	CONST BOOL outlined = FALSE
);

BOOL FAST_CALL CopyScreenToCanvas(
	CONST CGDICanvas *pCanvas
);

BOOL FAST_CALL DrawCanvas(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG lRasterOp = SRCCOPY
);

BOOL FAST_CALL DrawCanvasTransparent(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG crTransparentColor
);

BOOL FAST_CALL DrawCanvasTranslucent(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
);

BOOL FAST_CALL DrawCanvasTranslucentPartial(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
);

BOOL FAST_CALL DrawCanvasPartial(
	CONST CGDICanvas *pCanvas,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST LONG lRasterOp = SRCCOPY
);

BOOL FAST_CALL DrawCanvasTransparentPartial(
	CONST CGDICanvas *pCanvas,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST LONG crTransparentColor
);

VOID FAST_CALL ClearScreen(
	CONST LONG crColor
);

LONG FAST_CALL GetPixelColor(
	CONST INT x,
	CONST INT y
);

VOID CloseDC(
	CONST HDC hdc
);

BOOL FAST_CALL LockScreen(
	VOID
);

BOOL FAST_CALL UnlockScreen(
	VOID
);

DXINFO FAST_CALL InitDirectX(
	CONST HWND hWnd,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
);

HDC OpenDC(
	VOID
);

CGDICanvas *FAST_CALL CreateCanvas(
	CONST INT nWidth,
	CONST INT nHeight,
	CONST BOOL bUseDX = FALSE
);

//------------------------------------------------------------------------
// End of the header file
//------------------------------------------------------------------------
#endif
