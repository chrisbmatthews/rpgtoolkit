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
// Inclusions
//------------------------------------------------------------------------
#include <windows.h>
#include <ddraw.h>
#include "../strings.h"
#include "../tkCanvas/GDICanvas.h"

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
	) { memset(this, 0, sizeof(CDirectDraw)); }

	// Initialize the graphics mode
	BOOL FAST_CALL InitGraphicsMode(
		CONST HWND hostHwnd,
		CONST INT nWidth,
		CONST INT nHeight,
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
	BOOL DrawPixel(
		CONST INT x,
		CONST INT y,
		CONST LONG clr
	) { m_pBackBuffer->SetPixel(x, y, clr); return TRUE; }

	// Draw a line
	BOOL DrawLine(
		CONST INT x1,
		CONST INT y1,
		CONST INT x2,
		CONST INT y2,
		CONST LONG clr
	) { return m_pBackBuffer->DrawLine(x1, y1, x2, y2, clr); }

	// Draw a filled rectangle
	BOOL DrawFilledRect(
		CONST INT x1,
		CONST INT y1,
		CONST INT x2,
		CONST INT y2,
		CONST LONG clr
	) { return m_pBackBuffer->DrawFilledRect(x1, y1, x2, y2, clr); }

	// Offset the gamma ramp.
	BOOL OffsetGammaRamp(INT r, INT g, INT b);
	BOOL IsGammaEnabled() CONST { return m_bGammaEnabled; }

	// Flip the backbuffer to the primary surface
	BOOL Refresh(VOID) { return (this->*m_pRefresh)(); }
	BOOL FAST_CALL RefreshFullScreen(VOID);
	BOOL FAST_CALL RefreshWindowed(VOID);

	// Draw text on the screen
	BOOL DrawText(
		CONST INT x,
		CONST INT y,
		CONST STRING strText,
		CONST STRING strTypeFace,
		CONST INT size,
		CONST LONG clr,
		CONST BOOL bold = FALSE,
		CONST BOOL italics = FALSE,
		CONST BOOL underline = FALSE,
		CONST BOOL centred = FALSE,
		CONST BOOL outlined = FALSE
	) { return m_pBackBuffer->DrawText(x, y, strText, strTypeFace, size, clr, bold, italics, underline, centred, outlined); }

	// Copy the screen to a canvas
	BOOL FAST_CALL CopyScreenToCanvas(
		CONST CCanvas *pCanvas
	) CONST;

	// Draw a canvas
	BOOL DrawCanvas(
		CONST CCanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG lRasterOp = SRCCOPY
	) { return DrawCanvasPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), lRasterOp); }

	// Draw a canvas, using transparency
	BOOL DrawCanvasTransparent(
		CONST CCanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG crTransparentColor
	) { return DrawCanvasTransparentPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), crTransparentColor); }

	// Draw a canvas, using translucency
	BOOL FAST_CALL DrawCanvasTranslucent(
		CONST CCanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	);

	// Draw part of a canvas, using translucency
	BOOL FAST_CALL DrawCanvasTranslucentPartial(
		CONST CCanvas *pCanvas,
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
		CONST CCanvas *pCanvas,
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
		CONST CCanvas *pCanvas,
		CONST INT destX,
		CONST INT destY,
		CONST INT srcX,
		CONST INT srcY,
		CONST INT width,
		CONST INT height,
		CONST LONG crTransparentColor
	);

	// Clear the screen
	VOID ClearScreen(
		CONST LONG crColor
	) { m_pBackBuffer->ClearScreen(crColor); }

	// Get a pixel on the screen
	LONG GetPixelColor(
		CONST INT x,
		CONST INT y
	) CONST { return m_pBackBuffer->GetPixel(x, y); }

	// Lock the screen
	BOOL LockScreen(
		VOID
	) { m_pBackBuffer->Lock(); return TRUE; }

	// Unlock the screen
	BOOL UnlockScreen(
		VOID
	) { m_pBackBuffer->Unlock(); return TRUE; }

	// Determine whether we support a ROP
	BOOL FAST_CALL supportsRop(
		CONST LONG lRop,
		CONST BOOL bLeftRam,
		CONST BOOL bRightRam
	) CONST;

	// Obtain the screen's DC
	HDC OpenDC(
		VOID
	) CONST { return m_pBackBuffer->OpenDC(); }

	// Close the screen's DC
	VOID CloseDC(
		CONST HDC hdc
	) CONST { m_pBackBuffer->CloseDC(hdc); }

	HRESULT GetGammaRamp(
		DDGAMMARAMP &ramp
	) CONST { return m_lpddGammaControl->GetGammaRamp(0, &ramp); }

	CCanvas *getBackBuffer(VOID) { return m_pBackBuffer; }

	// Deconstructor
	~CDirectDraw(
		VOID
	) { KillGraphicsMode(); }

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
	HWND m_hWndMain;					// Handle to host window
	HINSTANCE m_hInstance;				// Handle of instance to app
	HDC m_hDCLocked;					// HDC of locked surface
	CCanvas *m_pBackBuffer;				// Backbuffer
	BOOL m_bSrcAnd[4];					// SRCAND support?
	BOOL m_bSrcPaint[4];				// SRCPAINT support?
	BOOL (FAST_CALL CDirectDraw::*m_pRefresh) (VOID);
	LPDIRECTDRAWGAMMACONTROL m_lpddGammaControl;		// Gamma control.
	BOOL m_bGammaEnabled;				// Gamma enabled?

};

//------------------------------------------------------------------------
// End of the header file
//------------------------------------------------------------------------
#endif
