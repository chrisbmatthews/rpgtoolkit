//--------------------------------------------------------------------------
// All contents copyright 2003, 2004, Christopher Matthews or Contributors
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// A canvas
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Protect the header
//--------------------------------------------------------------------------
#ifndef _CGDICANVAS_H_
#define _CGDICANVAS_H_
#ifdef _MSC_VER
#	pragma once
#endif

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN			// Flag lean version of Windows
#include <windows.h>				// The Windows API
#include "..\tkDirectX\platform.h"	// DirectX interface

//--------------------------------------------------------------------------
// Definitions
//--------------------------------------------------------------------------
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

//--------------------------------------------------------------------------
// Definition of the CGDICanvas class
//--------------------------------------------------------------------------
class CGDICanvas
{

//
// Public visibility
//
public:

	CGDICanvas(
		VOID
	);

	CGDICanvas(
		CONST CGDICanvas &rhs
	);

	~CGDICanvas(
		VOID
	);

	CGDICanvas &operator=(
		CONST CGDICanvas &rhs
	);

	VOID FAST_CALL CreateBlank(
		CONST HDC hdcCompatible,
		CONST INT width,
		CONST INT height,
		CONST BOOL bDX = FALSE
	);

	VOID Destroy(
		VOID
	);

	VOID SetPixel(
		CONST INT x,
		CONST INT y,
		CONST INT crColor
	);

	INT FAST_CALL GetPixel(
		CONST INT x,
		CONST INT y
	) CONST;

	INT GetWidth(
		VOID
	) CONST;

	INT GetHeight(
		VOID
	) CONST;

	HDC OpenDC(
		VOID
	) CONST;

	VOID CloseDC(
		HDC hdc
	) CONST;

	VOID Lock(
		VOID
	);

	VOID Unlock(
		VOID
	);

	VOID FAST_CALL SetPixels(
		CONST LPLONG p_crPixelArray,
		CONST INT x,
		CONST INT y,
		CONST INT width,
		CONST INT height
	);

	VOID FAST_CALL Resize(
		CONST HDC hdcCompatible,
		CONST INT width,
		CONST INT height
	);

	BOOL usingDX(
		VOID
	) CONST;

	INT FAST_CALL Blt(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL Blt(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL Blt(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL BltPart(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL BltPart(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL BltPart(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG lRasterOp = SRCCOPY
	) CONST;

	INT FAST_CALL BltTransparent(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTransparent(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTransparent(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTransparentPart(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTransparentPart(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTransparentPart(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTranslucentPart(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTranslucentPart(
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
	) CONST;

	INT FAST_CALL BltTranslucentPart(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST INT xSrc,
		CONST INT ySrc,
		CONST INT width,
		CONST INT height,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
			) CONST;

	INT FAST_CALL BltTranslucent(
		CONST HDC hdcTarget,
		CONST INT x,
		CONST INT y,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL BltTranslucent(
		CONST CGDICanvas *pCanvas,
		CONST INT x,
		CONST INT y,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	) CONST;

	INT BltTranslucent(
		CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
		CONST INT x,
		CONST INT y,
		CONST DOUBLE dIntensity,
		CONST LONG crUnaffectedColor,
		CONST LONG crTransparentColor
	) CONST;

	INT FAST_CALL ShiftLeft(
		CONST INT nPixels
	);

	INT FAST_CALL ShiftRight(
		CONST INT nPixels
	);

	INT FAST_CALL ShiftUp(
		CONST INT nPixels
	);

	INT FAST_CALL ShiftDown(
		CONST INT nPixels
	);

	LPDIRECTDRAWSURFACE7 GetDXSurface(
		VOID
	) CONST;

	LONG GetRGBColor(
		CONST LONG crColor
	) CONST;

	LONG GetSurfaceColor(
		CONST LONG dxColor
	) CONST;

//
// Private visibility
//
private:

	STATIC COLORREF ConvertDDColor(
		CONST DWORD dwColor,
		CONST LPDDPIXELFORMAT pddpf
	);

	STATIC DWORD ConvertColorRef(
		CONST COLORREF crColor,
		CONST LPDDPIXELFORMAT pddpf
	);

	STATIC WORD GetNumberOfBits(
		CONST DWORD dwMask
	);

	STATIC WORD GetMaskPos(
		CONST DWORD dwMask
	);

	STATIC VOID SetRGBPixel(
		CONST LPDDSURFACEDESC2 destSurface,
		CONST LPDDPIXELFORMAT pddpf,
		CONST INT x,
		CONST INT y,
		CONST LONG rgb
	);

	STATIC LONG GetRGBPixel(
		CONST LPDDSURFACEDESC2 destSurface,
		CONST LPDDPIXELFORMAT pddpf,
		CONST INT x,
		CONST INT y
	);

	VOID FAST_CALL SetPixelsDX(
		CONST LPLONG p_crPixelArray,
		CONST INT x,
		CONST INT y,
		CONST INT width,
		CONST INT height
	);

	VOID SetPixelsGDI(
		CONST LPLONG p_crPixelArray,
		CONST INT x,
		CONST INT y,
		CONST INT width,
		CONST INT height
	);

	HDC m_hdcMem;							// Memory DC
	INT m_nWidth;							// Width
	INT m_nHeight;							// Height
	HDC m_hdcLocked;						// Locked hdc
	BOOL m_bUseDX;							// Using DirectX?
	LPDIRECTDRAWSURFACE7 m_lpddsSurface;	// DirectDraw surface

};

//--------------------------------------------------------------------------
// End of the header
//--------------------------------------------------------------------------
#endif
