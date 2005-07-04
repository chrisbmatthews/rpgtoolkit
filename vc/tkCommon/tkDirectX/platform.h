//------------------------------------------------------------------------
// All contents copyright 2003, 2004, Christopher Matthews or Contributors
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// DirectDraw interface
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Protect the header
//------------------------------------------------------------------------
#if !defined(_PLATFORM_H_)
#define _PLATFORM_H_
#if defined(_MSC_VER)
#	pragma once
#endif

//------------------------------------------------------------------------
// Forward references
//------------------------------------------------------------------------
class CGDICanvas;						// Canvas backbuffer
class CDirectDraw;						// DirectDraw object

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#include <windows.h>					// For windows
#include <string>						// For strings
#include <ddraw.h>						// For DirectDraw
#include "..\tkCanvas\GDICanvas.h"		// For canvases

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
// CDirectDraw - interface to DirectDarw
//------------------------------------------------------------------------
class CDirectDraw
{

//
// Public visibility
//
public:

	// Default constructor
	CDirectDraw(
		VOID
	);

	// Initialize the graphics mode
	BOOL FAST_CALL InitGraphicsMode(
		CONST HWND hostHwnd,
		CONST INT nWidth,
		CONST INT nHeight,
		CONST BOOL bUseDirectX,
		CONST LONG nColorDepth,
		CONST BOOL bFullScreen
	);

	// Create a surface
	LPDIRECTDRAWSURFACE7 FAST_CALL createSurface(
		CONST INT width,
		CONST INT height,
		CONST LPBOOL bRam
	) CONST;

	// Kill the graphics mode
	BOOL FAST_CALL KillGraphicsMode(
		VOID
	);

	// Draw a pixel
	BOOL FAST_CALL DrawPixel(
		CONST INT x,
		CONST INT y,
		CONST LONG clr
	);

	// Draw a line
	BOOL FAST_CALL DrawLine(
		CONST INT x1,
		CONST INT y1,
		CONST INT x2,
		CONST INT y2,
		CONST LONG clr
	);

	// Draw a filled rectangle
	BOOL FAST_CALL DrawFilledRect(
		CONST INT x1,
		CONST INT y1,
		CONST INT x2,
		CONST INT y2,
		CONST LONG clr
	);

	// Flip the backbuffer to the primary surface
	BOOL FAST_CALL Refresh(VOID) { return (this->*m_pRefresh)(); }
	BOOL FAST_CALL RefreshFullScreen(VOID);
	BOOL FAST_CALL RefreshWindowed(VOID);

	// Draw text on the screen
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

	// Copy the screen to a canvas
	BOOL FAST_CALL CopyScreenToCanvas(
		CONST CGDICanvas *pCanvas
	) CONST;

	// Draw a canvas
	BOOL FAST_CALL DrawCanvas(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG lRasterOp = SRCCOPY
	);

	// Draw a canvas, using transparency
	BOOL FAST_CALL DrawCanvasTransparent(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG crTransparentColor
	);

	// Draw a canvas, using translucency
	BOOL FAST_CALL DrawCanvasTranslucent(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	);

	// Draw part of a canvas, using translucency
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

	// Draw part of a canvas
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

	// Draw part of a canvas, using transparency
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

	// Clear the screen
	VOID FAST_CALL ClearScreen(
		CONST LONG crColor
	);

	// Get a pixel on the screen
	LONG FAST_CALL GetPixelColor(
		CONST INT x,
		CONST INT y
	) CONST;

	// Lock the screen
	BOOL FAST_CALL LockScreen(
		VOID
	);

	// Unlock the screen
	BOOL FAST_CALL UnlockScreen(
		VOID
	);

	// Check whether we're using DirectDraw
	BOOL usingDirectX(VOID) CONST { return m_bUseDirectX; }

	// Determine whether we support a ROP
	BOOL FAST_CALL supportsRop(
		CONST LONG lRop,
		CONST BOOL bLeftRam,
		CONST BOOL bRightRam
	) CONST;

	// Obtain the screen's DC
	HDC OpenDC(
		VOID
	) CONST;

	// Close the screen's DC
	VOID CloseDC(
		CONST HDC hdc
	) CONST;

	CGDICanvas *getBackBuffer(VOID) { return m_pBackBuffer; }

	// Deconstructor
	~CDirectDraw(
		VOID
	);

//
// Private visibility
//
private:

	// Initialize DirectDraw
	VOID FAST_CALL InitDirectX(
		CONST HWND hWnd,
		CONST INT nWidth,
		CONST INT nHeight,
		CONST LONG nColorDepth,
		CONST BOOL bFullScreen
	);

	// Create a canvas for use as a backbuffer
	CGDICanvas *FAST_CALL CreateCanvas(
		CONST INT nWidth,
		CONST INT nHeight,
		CONST BOOL bUseDX = FALSE
	);

	BOOL m_bFullScreen;					// Running in fullscreen mode?
	INT m_nColorDepth;					// Color depth
	INT m_nWidth;						// Width of surface
	INT m_nHeight;						// Height of surface
	LPDIRECTDRAW7 m_lpdd;				// Main direct draw object
	LPDIRECTDRAWSURFACE7 m_lpddsPrime;	// Direct draw primary surface
	LPDIRECTDRAWSURFACE7 m_lpddsSecond;	// Direct draw back buffer
	LPDIRECTDRAWCLIPPER m_lpddClip;		// Clipper
	RECT m_surfaceRect;					// Rect of surface
	RECT m_destRect;					// Rect of window's client area
	DDBLTFX m_bltFx;					// Effects for the blt
	BOOL m_bUseDirectX;					// Using DirectX?
	HWND m_hWndMain;					// Handle to host window
	HINSTANCE m_hInstance;				// Handle of instance to app
	HDC m_hDCLocked;					// HDC of locked surface
	CGDICanvas *m_pBackBuffer;			// Backbuffer
	BOOL m_bSrcAnd[4];					// SRCAND support?
	BOOL m_bSrcPaint[4];				// SRCPAINT support?
	BOOL (FAST_CALL CDirectDraw::*m_pRefresh) (VOID);

};

//------------------------------------------------------------------------
// End of the header file
//------------------------------------------------------------------------
#endif
