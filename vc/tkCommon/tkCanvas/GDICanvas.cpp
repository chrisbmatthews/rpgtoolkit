/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#include "..\tkDirectX\platform.h"	// DirectX interface
#include "GDICanvas.h"				// Contains stuff for this file
#include <map>						// Maps

//--------------------------------------------------------------------------
// Default constructor
//--------------------------------------------------------------------------
CCanvas::CCanvas(VOID)
{
	// Initialize members
	m_hdcMem = NULL;
	m_nWidth = 0;
	m_nHeight = 0;
	m_lpddsSurface = NULL;
	m_bUseDX = FALSE;
	m_hdcLocked = NULL;
	m_hBitmap = NULL;
	m_hOldBitmap = NULL;
	m_bInRam = FALSE;
}

//--------------------------------------------------------------------------
// Copy constructor
//--------------------------------------------------------------------------
CCanvas::CCanvas(
	CONST CCanvas &rhs
	):
	m_hdcMem(NULL),
	m_nWidth(0),
	m_nHeight(0),
	m_lpddsSurface (NULL),
	m_bUseDX(FALSE),
	m_hdcLocked(NULL),
	m_hBitmap(NULL),
	m_hOldBitmap(NULL),
	m_bInRam(FALSE)
{

	// First, create an equal sized canvas
	CreateBlank(rhs.m_hdcMem, rhs.m_nWidth, rhs.m_nHeight, rhs.m_bUseDX);

	// Now blt the image over
	if (rhs.m_bUseDX)
	{

		// Create rectangles
		RECT destRect = {0, 0, m_nWidth, m_nHeight};
		RECT rect = {0, 0, m_nWidth, m_nHeight};

		// Setup blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		m_lpddsSurface->Blt(&destRect, rhs.m_lpddsSurface, &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);

	}
	else
	{
		// Just use the incredibly slow BitBlt()
		BitBlt(m_hdcMem, 0, 0, rhs.m_nWidth, rhs.m_nHeight, rhs.m_hdcMem, 0, 0, SRCCOPY);
	}

	// HDC is not locked
	m_hdcLocked = NULL;

}

//--------------------------------------------------------------------------
// Assignment operator
//--------------------------------------------------------------------------
CCanvas &CCanvas::operator=(
	CONST CCanvas &rhs
		)
{

	// Destroy, if in use
	if (m_hdcMem) Destroy();

	// First, create an equal sized canvas
	CreateBlank(rhs.m_hdcMem, rhs.m_nWidth, rhs.m_nHeight, rhs.m_bUseDX);

	// Now blt the image over
	if (rhs.m_bUseDX)
	{

		// Create rectangles
		RECT destRect = {0, 0, m_nWidth, m_nHeight};
		RECT rect = {0, 0, m_nWidth, m_nHeight};

		// Setup blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		m_lpddsSurface->Blt(&destRect, rhs.m_lpddsSurface, &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);

	}
	else
	{
		// Just use the incredibly slow BitBlt()
		BitBlt(m_hdcMem, 0, 0, rhs.m_nWidth, rhs.m_nHeight, rhs.m_hdcMem, 0, 0, SRCCOPY);
	}

	// HDC is not locked
	m_hdcLocked = NULL;

	// Return the current object
	return *this;

}

//--------------------------------------------------------------------------
// Use an existing surface for this canvas.
//   Note that this surface will *not* be freed by this canvas, so its
//   destruction must be handled by whoever created it.
//--------------------------------------------------------------------------
CCanvas::CCanvas(LPDIRECTDRAWSURFACE7 surface, INT width, INT height, BOOL bRam)
{
	surface->AddRef();
	m_lpddsSurface = surface;
	m_nWidth = width;
	m_nHeight = height;
	m_bUseDX = TRUE;
	m_hdcLocked = m_hdcMem = NULL;
	m_hBitmap = m_hOldBitmap = NULL;
	m_bInRam = bRam;
}

//--------------------------------------------------------------------------
// Deconstructor
//--------------------------------------------------------------------------
INLINE CCanvas::~CCanvas(VOID)
{
	// Destroy existing canavs, if one
	if (usingDX())
	{
		if (m_lpddsSurface)
		{
			Destroy();
		}
	}
	else if (m_hdcMem)
	{
		Destroy();
	}
}

//------------------------------------------------------------------------
// Draw text onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawText(
	CONST INT x,
	CONST INT y,
	CONST STRING strText,
	CONST STRING strTypeFace,
	CONST INT size,
	CONST LONG clr,
	CONST BOOL bold,
	CONST BOOL italics,
	CONST BOOL underline,
	CONST BOOL centred,
	CONST BOOL outlined
		)
{

	// Create a font
	CONST HFONT hFont = CreateFont(
		size,
		0,
		0,
		0,
		bold ? FW_BOLD : FW_NORMAL,
		italics,
		underline,
		0,
		DEFAULT_CHARSET,
		OUT_DEFAULT_PRECIS,
		CLIP_DEFAULT_PRECIS,
		DEFAULT_QUALITY,
		DEFAULT_PITCH,
		strTypeFace.c_str()
	);

	// If the font was valid
	if (hFont)
	{

		// Open the DC
		CONST HDC hdc = OpenDC();

		// Set its background it transparent
		SetBkMode(hdc, TRANSPARENT);

		// Select out any old font
		CONST HGDIOBJ hOld = SelectObject(hdc, hFont);

		// Set the text color
		SetTextColor(hdc, clr);

		// Set allignment
		SetTextAlign(hdc, centred ? TA_CENTER : TA_LEFT);

		// Create a new brush
		CONST HGDIOBJ hNewBrush = CreateSolidBrush(clr);

		// Select out any old brush
		CONST HGDIOBJ hOldBrush = SelectObject(hdc, hNewBrush);

		// If the text is to be outlined
		if (outlined)
		{

			// Draw the text
			BeginPath(hdc);
			TextOut(hdc, x, y, strText.c_str(), strText.length());
			EndPath(hdc);

			// Outline the text
			SetBkColor(hdc, clr);
			SetBkMode(hdc, OPAQUE);
			StrokeAndFillPath(hdc);

		} 
		else
		{

			// Just draw the text
			TextOut(hdc, x, y, strText.c_str(), strText.length());

		}

		// Restore old objects
		SelectObject(hdc, hOldBrush);
		DeleteObject(hNewBrush);
		SelectObject(hdc, hOld);
		DeleteObject(hFont);

		// Close the DC
		CloseDC(hdc);
	}
	else
	{
		// Failed
		return FALSE;
	}

	// All's good
	return TRUE;

}

//------------------------------------------------------------------------
// Get dimensions of a string
//------------------------------------------------------------------------
SIZE FAST_CALL CCanvas::GetTextSize(
	CONST STRING strText,
	CONST STRING strTypeFace,
	CONST INT size,
	CONST BOOL bold,
	CONST BOOL italics
		)
{
	SIZE sz = {0, 0};
	UINT len = 0;

	// Create a font
	CONST HFONT hFont = CreateFont(
		size,
		0,
		0,
		0,
		bold ? FW_BOLD : FW_NORMAL,
		italics,
		0,
		0,
		DEFAULT_CHARSET,
		OUT_DEFAULT_PRECIS,
		CLIP_DEFAULT_PRECIS,
		DEFAULT_QUALITY,
		DEFAULT_PITCH,
		strTypeFace.c_str()
	);

	if (hFont)
	{
		CONST HDC hdc = OpenDC();
		SetBkMode(hdc, TRANSPARENT);

		// Select out old font.
		CONST HGDIOBJ hOld = SelectObject(hdc, hFont);

		len = strlen(strText.c_str());
		if (len)
		{
			GetTextExtentPoint32(hdc, strText.c_str(), len, &sz);
		}

		// Clean up.
		SelectObject(hdc, hOld);
		DeleteObject(hFont);
		CloseDC(hdc);
	}

	return sz;
}

//------------------------------------------------------------------------
// Draw a rectangle.
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawRect(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
		)
{
	CONST HRGN rgn = CreateRectRgn(x1, y1, x2 + 1, y2 + 1);
	CONST HBRUSH brush = CreateSolidBrush(clr);
	CONST HDC hdc = OpenDC();
	FrameRgn(hdc, rgn, brush, 1, 1);
	CloseDC(hdc);
	DeleteObject(rgn);
	DeleteObject(brush);
	return TRUE;
}

//------------------------------------------------------------------------
// Draw a filled rectangle.
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawFilledRect(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
		)
{
	CONST HDC hdc = OpenDC();
	CONST RECT r = {x1, y1, x2 + 1, y2 + 1};
	CONST HPEN pen = CreatePen(0, 1, clr);
	CONST HGDIOBJ l = SelectObject(hdc, pen);
	CONST HBRUSH brush = CreateSolidBrush(clr);
	CONST HGDIOBJ m = SelectObject(hdc, brush);
	FillRect(hdc, &r, brush);
	SelectObject(hdc, m);
	SelectObject(hdc, l);
	DeleteObject(brush);
	DeleteObject(pen);
	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Draw an ellipse.
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawEllipse(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
		)
{
	CONST HRGN rgn = CreateEllipticRgn(x1, y1, x2 + 1, y2 + 1);
	CONST HBRUSH brush = CreateSolidBrush(clr);
	CONST HDC hdc = OpenDC();
	FrameRgn(hdc, rgn, brush, 1, 1);
	CloseDC(hdc);
	DeleteObject(rgn);
	DeleteObject(brush);
	return TRUE;
}

//------------------------------------------------------------------------
// Draw a filled ellipse.
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawFilledEllipse(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
		)
{
	CONST HDC hdc = OpenDC();
	CONST HPEN pen = CreatePen(0, 1, clr);
	CONST HGDIOBJ l = SelectObject(hdc, pen);
	CONST HBRUSH brush = CreateSolidBrush(clr);
	CONST HGDIOBJ m = SelectObject(hdc, brush);
    Ellipse(hdc, x1, y1, x2 + 1, y2 + 1);
	SelectObject(hdc, m);
	SelectObject(hdc, l);
	DeleteObject(brush);
	DeleteObject(pen);
	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Draw a line on the canvas.
//------------------------------------------------------------------------
BOOL FAST_CALL CCanvas::DrawLine(
	CONST INT x1,
	CONST INT y1,
	CONST INT x2,
	CONST INT y2,
	CONST LONG clr
		)
{
	CONST HDC hdc = OpenDC();

	POINT point;
	HPEN brush = CreatePen(0, 1, clr);
	HGDIOBJ m = SelectObject(hdc, brush);
	MoveToEx(hdc, x1, y1, &point);
	LineTo(hdc, x2, y2);
	SelectObject(hdc, m);
	DeleteObject(brush);

	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Clear the canvas to a color
//------------------------------------------------------------------------
VOID FAST_CALL CCanvas::ClearScreen(CONST LONG crColor)
{

	// Open the screen's DC
	CONST HDC hdc = OpenDC();

	// Create a rect
	RECT r = {0, 0, 0, 0};
	r.right = m_nWidth + 1;
	r.bottom = m_nHeight + 1;

	// Create and select objects
	CONST HPEN pen = CreatePen(0, 1, crColor);
	CONST HGDIOBJ l = SelectObject(hdc, pen);
	CONST HBRUSH brush = CreateSolidBrush(crColor);
	CONST HGDIOBJ m = SelectObject(hdc, brush);

	// Fill the screen
	FillRect(hdc, &r, brush);

	// Unselect and delete objects
	SelectObject(hdc, m);
	SelectObject(hdc, l);
	DeleteObject(brush);
	DeleteObject(pen);

	// Close the dc
	CloseDC(hdc);

}

//--------------------------------------------------------------------------
// Find the closest match to a colour
//--------------------------------------------------------------------------
COLORREF FAST_CALL CCanvas::matchColor(CONST COLORREF rgb) CONST
{

	// Map of colours
	STATIC std::map<COLORREF, COLORREF> colors;

	// Just return colour if in map
	if (colors.count(rgb)) return colors[rgb];

	// Lay down a pixel
	HDC hdc = NULL;
	m_lpddsSurface->GetDC(&hdc);					// Open the surface's DC
	CONST COLORREF rgbT = ::GetPixel(hdc, 0, 0);	// Save current pixel value
	::SetPixel(hdc, 0, 0, rgb);						// Set the colour in question
	m_lpddsSurface->ReleaseDC(hdc);					// Release the DC

	// Lock the surface
	DDSURFACEDESC2 ddsd;
	DD_INIT_STRUCT(ddsd);
	while ((m_lpddsSurface->Lock(NULL, &ddsd, 0, NULL)) == DDERR_WASSTILLDRAWING);

	// Get the colour that was actually set
	COLORREF toRet = *reinterpret_cast<LPCOLORREF>(ddsd.lpSurface);
	if (ddsd.ddpfPixelFormat.dwRGBBitCount < 32)
	{
		// Reduce if colour is less than 32 bit
		toRet &= (1 << ddsd.ddpfPixelFormat.dwRGBBitCount) - 1;
	}
	m_lpddsSurface->Unlock(NULL);

	// Set back old pixel
	m_lpddsSurface->GetDC(&hdc);	// Open the surface's DC
	::SetPixel(hdc, 0, 0, rgbT);	// Set the old colour
	m_lpddsSurface->ReleaseDC(hdc);	// Release the DC

	// Return the result
	return (colors[rgb] = toRet);

}

//--------------------------------------------------------------------------
// Create a canvas
//--------------------------------------------------------------------------
VOID FAST_CALL CCanvas::CreateBlank(
	CONST HDC hdcCompatible,
	CONST INT width,
	CONST INT height,
	CONST BOOL bDX
		)
{

	// Destroy existing canvas
	if (m_hdcMem || m_lpddsSurface) Destroy();

	// Record width and height
	m_nWidth = width;
	m_nHeight = height;

	// If a DirectDraw object exists
	extern CDirectDraw *g_pDirectDraw;
	if (g_pDirectDraw)
	{

		// If using DirectX
		if (m_bUseDX = bDX)
		{

			// Create a DirectDraw surface
			m_lpddsSurface = g_pDirectDraw->createSurface(width, height, &m_bInRam);
			return;

		}

	}
	else
	{

		// Not using DX
		m_bUseDX = FALSE;

	}

	// Create a new device context
	m_hdcMem = CreateCompatibleDC(hdcCompatible);

	// Create a new bitmap
	m_hBitmap = CreateCompatibleBitmap(hdcCompatible, width, height);

	// Select the bitmap into the device context
	m_hOldBitmap = HBITMAP(SelectObject(m_hdcMem, m_hBitmap));

	// Set StretchBlt mode
	SetStretchBltMode(m_hdcMem, COLORONCOLOR);

}

//--------------------------------------------------------------------------
// Resize the canvas
//--------------------------------------------------------------------------
VOID FAST_CALL CCanvas::Resize(
	CONST HDC hdcCompatible,
	CONST INT width,
	CONST INT height
		)
{
	CONST BOOL bDX = usingDX();
	Destroy();
	CreateBlank(hdcCompatible, width, height, bDX);
}

//--------------------------------------------------------------------------
// Destroy the canvas
//--------------------------------------------------------------------------
INLINE VOID CCanvas::Destroy(VOID)
{

	// If using GDI
	if (!(usingDX()))
	{

		// Select out current bitmap
		SelectObject(m_hdcMem, m_hOldBitmap);

		// Delete the canvas
		DeleteObject(m_hBitmap);

		// Delete the DC
		DeleteDC(m_hdcMem);

	}
	else if (m_lpddsSurface)
	{
		// Release the surface
		m_lpddsSurface->Release();
	}

	// Clear members
	m_hdcMem = NULL;
	m_hBitmap = NULL;
	m_hOldBitmap = NULL;
	m_lpddsSurface = NULL;
	m_nWidth = 0;
	m_nHeight = 0;

}

//--------------------------------------------------------------------------
// Set a pixel using GDI
//--------------------------------------------------------------------------
VOID CCanvas::SetPixel(
	CONST INT x,
	CONST INT y,
	CONST LONG crColor
		)
{
	CONST HDC hdc = OpenDC();
	SetPixelV(hdc, x, y, crColor);
	CloseDC(hdc);
}

//--------------------------------------------------------------------------
// Get a pixel using GDI
//--------------------------------------------------------------------------
INT FAST_CALL CCanvas::GetPixel(
	CONST INT x,
	CONST INT y
		) CONST
{
	CONST HDC hdc = OpenDC();
	CONST INT nToRet = ::GetPixel(hdc, x, y);
	CloseDC(hdc);
	return nToRet;
}

//--------------------------------------------------------------------------
// Opaque blitter
//--------------------------------------------------------------------------

//
// HDC target
//
INT FAST_CALL CCanvas::BltPart(
	CONST HDC hdcTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST LONG lRasterOp
		) CONST
{
	CONST HDC hdc = OpenDC();
	CONST INT nToRet = BitBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, lRasterOp);
	CloseDC(hdc);
	return nToRet;
}

//
// Canvas target
//
INT FAST_CALL CCanvas::BltPart(
	CONST CCanvas *pCanvas,
	INT x,
	INT y,
	INT xSrc,
	INT ySrc,
	INT width,
	INT height,
	CONST LONG lRasterOp
		) CONST
{

	if (x < 0)
	{
		xSrc -= x;
		width += x;
		x = 0;
	}

	if (y < 0)
	{
		ySrc -= y;
		height += y;
		y = 0;
	}

	if (x + width > pCanvas->GetWidth())
	{
		width = pCanvas->GetWidth() - x;
	}

	if (y + height > pCanvas->GetHeight())
	{
		height = pCanvas->GetHeight() - y;
	}

	if (pCanvas->usingDX() && usingDX())
	{
		// Blt using DirectX blt call
		return BltPart(pCanvas->GetDXSurface(), x, y, xSrc, ySrc, width, height, lRasterOp);
	}
	else
	{
		// Use GDI
		CONST HDC hdc = pCanvas->OpenDC();
		CONST INT nToRet = BltPart(hdc, x, y, xSrc, ySrc, width, height, lRasterOp);
		pCanvas->CloseDC(hdc);
		return nToRet;
	}

}

//
// Surface target
//
INT FAST_CALL CCanvas::BltPart(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST LONG lRasterOp
		) CONST
{

	// If using DirectX
	if (lpddsSurface && usingDX())
	{

		// Setup the rects
		RECT destRect = {x, y, x + width, y + height};
		RECT rect = {xSrc, ySrc, xSrc + width, ySrc + height};

		// Execute the blt
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = lRasterOp;
		return SUCCEEDED(lpddsSurface->BltFast(x, y, GetDXSurface(), &rect, DDBLTFAST_WAIT | DDBLTFAST_NOCOLORKEY));

	}
	else if (lpddsSurface)
	{
		// Use GDI
		HDC hdc = NULL;
		lpddsSurface->GetDC(&hdc);
		CONST INT nToRet = BltPart(hdc, x, y, xSrc, ySrc, width, height, lRasterOp);
		lpddsSurface->ReleaseDC(hdc);
		return nToRet;
	}

	// Else, we've failed
	return FALSE;

}

#if FALSE
//--------------------------------------------------------------------------
// Get a DirectDraw error's string
//--------------------------------------------------------------------------
STRING getDirectDrawErrorString(CONST HRESULT hr)
{
	switch (hr)
	{
		case DDERR_ALREADYINITIALIZED:           return _T("DDERR_ALREADYINITIALIZED");
		case DDERR_CANNOTATTACHSURFACE:          return _T("DDERR_CANNOTATTACHSURFACE");
		case DDERR_CANNOTDETACHSURFACE:          return _T("DDERR_CANNOTDETACHSURFACE");
		case DDERR_CURRENTLYNOTAVAIL:            return _T("DDERR_CURRENTLYNOTAVAIL");
		case DDERR_EXCEPTION:                    return _T("DDERR_EXCEPTION");
		case DDERR_GENERIC:                      return _T("DDERR_GENERIC");
		case DDERR_HEIGHTALIGN:                  return _T("DDERR_HEIGHTALIGN");
		case DDERR_INCOMPATIBLEPRIMARY:          return _T("DDERR_INCOMPATIBLEPRIMARY");
		case DDERR_INVALIDCAPS:                  return _T("DDERR_INVALIDCAPS");
		case DDERR_INVALIDCLIPLIST:              return _T("DDERR_INVALIDCLIPLIST");
		case DDERR_INVALIDMODE:                  return _T("DDERR_INVALIDMODE");
		case DDERR_INVALIDOBJECT:                return _T("DDERR_INVALIDOBJECT");
		case DDERR_INVALIDPARAMS:                return _T("DDERR_INVALIDPARAMS");
		case DDERR_INVALIDPIXELFORMAT:           return _T("DDERR_INVALIDPIXELFORMAT");
		case DDERR_INVALIDRECT:                  return _T("DDERR_INVALIDRECT");
		case DDERR_LOCKEDSURFACES:               return _T("DDERR_LOCKEDSURFACES");
		case DDERR_NO3D:                         return _T("DDERR_NO3D");
		case DDERR_NOALPHAHW:                    return _T("DDERR_NOALPHAHW");
		case DDERR_NOCLIPLIST:                   return _T("DDERR_NOCLIPLIST");
		case DDERR_NOCOLORCONVHW:                return _T("DDERR_NOCOLORCONVHW");
		case DDERR_NOCOOPERATIVELEVELSET:        return _T("DDERR_NOCOOPERATIVELEVELSET");
		case DDERR_NOCOLORKEY:                   return _T("DDERR_NOCOLORKEY");
		case DDERR_NOCOLORKEYHW:                 return _T("DDERR_NOCOLORKEYHW");
		case DDERR_NODIRECTDRAWSUPPORT:          return _T("DDERR_NODIRECTDRAWSUPPORT");
		case DDERR_NOEXCLUSIVEMODE:              return _T("DDERR_NOEXCLUSIVEMODE");
		case DDERR_NOFLIPHW:                     return _T("DDERR_NOFLIPHW");
		case DDERR_NOGDI:                        return _T("DDERR_NOGDI");
		case DDERR_NOMIRRORHW:                   return _T("DDERR_NOMIRRORHW");
		case DDERR_NOTFOUND:                     return _T("DDERR_NOTFOUND");
		case DDERR_NOOVERLAYHW:                  return _T("DDERR_NOOVERLAYHW");
		case DDERR_NORASTEROPHW:                 return _T("DDERR_NORASTEROPHW");
		case DDERR_NOROTATIONHW:                 return _T("DDERR_NOROTATIONHW");
		case DDERR_NOSTRETCHHW:                  return _T("DDERR_NOSTRETCHHW");
		case DDERR_NOT4BITCOLOR:                 return _T("DDERR_NOT4BITCOLOR");
		case DDERR_NOT4BITCOLORINDEX:            return _T("DDERR_NOT4BITCOLORINDEX");
		case DDERR_NOT8BITCOLOR:                 return _T("DDERR_NOT8BITCOLOR");
		case DDERR_NOTEXTUREHW:                  return _T("DDERR_NOTEXTUREHW");
		case DDERR_NOVSYNCHW:                    return _T("DDERR_NOVSYNCHW");
		case DDERR_NOZBUFFERHW:                  return _T("DDERR_NOZBUFFERHW");
		case DDERR_NOZOVERLAYHW:                 return _T("DDERR_NOZOVERLAYHW");
		case DDERR_OUTOFCAPS:                    return _T("DDERR_OUTOFCAPS");
		case DDERR_OUTOFMEMORY:                  return _T("DDERR_OUTOFMEMORY");
		case DDERR_OUTOFVIDEOMEMORY:             return _T("DDERR_OUTOFVIDEOMEMORY");
		case DDERR_OVERLAYCANTCLIP:              return _T("DDERR_OVERLAYCANTCLIP");
		case DDERR_OVERLAYCOLORKEYONLYONEACTIVE: return _T("DDERR_OVERLAYCOLORKEYONLYONEACTIVE");
		case DDERR_PALETTEBUSY:                  return _T("DDERR_PALETTEBUSY");
		case DDERR_COLORKEYNOTSET:               return _T("DDERR_COLORKEYNOTSET");
		case DDERR_SURFACEALREADYATTACHED:       return _T("DDERR_SURFACEALREADYATTACHED");
		case DDERR_SURFACEALREADYDEPENDENT:      return _T("DDERR_SURFACEALREADYDEPENDENT");
		case DDERR_SURFACEBUSY:                  return _T("DDERR_SURFACEBUSY");
		case DDERR_CANTLOCKSURFACE:              return _T("DDERR_CANTLOCKSURFACE");
		case DDERR_SURFACEISOBSCURED:            return _T("DDERR_SURFACEISOBSCURED");
		case DDERR_SURFACELOST:                  return _T("DDERR_SURFACELOST");
		case DDERR_SURFACENOTATTACHED:           return _T("DDERR_SURFACENOTATTACHED");
		case DDERR_TOOBIGHEIGHT:                 return _T("DDERR_TOOBIGHEIGHT");
		case DDERR_TOOBIGSIZE:                   return _T("DDERR_TOOBIGSIZE");
		case DDERR_TOOBIGWIDTH:                  return _T("DDERR_TOOBIGWIDTH");
		case DDERR_UNSUPPORTED:                  return _T("DDERR_UNSUPPORTED");
		case DDERR_UNSUPPORTEDFORMAT:            return _T("DDERR_UNSUPPORTEDFORMAT");
		case DDERR_UNSUPPORTEDMASK:              return _T("DDERR_UNSUPPORTEDMASK");
		case DDERR_VERTICALBLANKINPROGRESS:      return _T("DDERR_VERTICALBLANKINPROGRESS");
		case DDERR_WASSTILLDRAWING:              return _T("DDERR_WASSTILLDRAWING");
		case DDERR_XALIGN:                       return _T("DDERR_XALIGN");
		case DDERR_INVALIDDIRECTDRAWGUID:        return _T("DDERR_INVALIDDIRECTDRAWGUID");
		case DDERR_DIRECTDRAWALREADYCREATED:     return _T("DDERR_DIRECTDRAWALREADYCREATED");
		case DDERR_NODIRECTDRAWHW:               return _T("DDERR_NODIRECTDRAWHW");
		case DDERR_PRIMARYSURFACEALREADYEXISTS:  return _T("DDERR_PRIMARYSURFACEALREADYEXISTS");
		case DDERR_NOEMULATION:                  return _T("DDERR_NOEMULATION");
		case DDERR_REGIONTOOSMALL:               return _T("DDERR_REGIONTOOSMALL");
		case DDERR_CLIPPERISUSINGHWND:           return _T("DDERR_CLIPPERISUSINGHWND");
		case DDERR_NOCLIPPERATTACHED:            return _T("DDERR_NOCLIPPERATTACHED");
		case DDERR_NOHWND:                       return _T("DDERR_NOHWND");
		case DDERR_HWNDSUBCLASSED:               return _T("DDERR_HWNDSUBCLASSED");
		case DDERR_HWNDALREADYSET:               return _T("DDERR_HWNDALREADYSET");
		case DDERR_NOPALETTEATTACHED:            return _T("DDERR_NOPALETTEATTACHED");
		case DDERR_NOPALETTEHW:                  return _T("DDERR_NOPALETTEHW");
		case DDERR_BLTFASTCANTCLIP:              return _T("DDERR_BLTFASTCANTCLIP");
		case DDERR_NOBLTHW:                      return _T("DDERR_NOBLTHW");
		case DDERR_NODDROPSHW:                   return _T("DDERR_NODDROPSHW");
		case DDERR_OVERLAYNOTVISIBLE:            return _T("DDERR_OVERLAYNOTVISIBLE");
		case DDERR_NOOVERLAYDEST:                return _T("DDERR_NOOVERLAYDEST");
		case DDERR_INVALIDPOSITION:              return _T("DDERR_INVALIDPOSITION");
		case DDERR_NOTAOVERLAYSURFACE:           return _T("DDERR_NOTAOVERLAYSURFACE");
		case DDERR_EXCLUSIVEMODEALREADYSET:      return _T("DDERR_EXCLUSIVEMODEALREADYSET");
		case DDERR_NOTFLIPPABLE:                 return _T("DDERR_NOTFLIPPABLE");
		case DDERR_CANTDUPLICATE:                return _T("DDERR_CANTDUPLICATE");
		case DDERR_NOTLOCKED:                    return _T("DDERR_NOTLOCKED");
		case DDERR_CANTCREATEDC:                 return _T("DDERR_CANTCREATEDC");
		case DDERR_NODC:                         return _T("DDERR_NODC");
		case DDERR_WRONGMODE:                    return _T("DDERR_WRONGMODE");
		case DDERR_IMPLICITLYCREATED:            return _T("DDERR_IMPLICITLYCREATED");
		case DDERR_NOTPALETTIZED:                return _T("DDERR_NOTPALETTIZED");
		case DDERR_UNSUPPORTEDMODE:              return _T("DDERR_UNSUPPORTEDMODE");
		case DDERR_NOMIPMAPHW:                   return _T("DDERR_NOMIPMAPHW");
		case DDERR_INVALIDSURFACETYPE:           return _T("DDERR_INVALIDSURFACETYPE");
		case DDERR_DCALREADYCREATED:             return _T("DDERR_DCALREADYCREATED");
		case DDERR_CANTPAGELOCK:                 return _T("DDERR_CANTPAGELOCK");
		case DDERR_CANTPAGEUNLOCK:               return _T("DDERR_CANTPAGEUNLOCK");
		case DDERR_NOTPAGELOCKED:                return _T("DDERR_NOTPAGELOCKED");
		case DDERR_NOTINITIALIZED:               return _T("DDERR_NOTINITIALIZED");
	}
	return _T("Unknown");
}
#endif

//
// Surface target
//
INT FAST_CALL CCanvas::BltStretch(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST INT newWidth,
	CONST INT newHeight,
	CONST LONG lRasterOp,
	CONST BOOL bInRam
		) CONST
{

	// If using DirectX
	/**if	(
			lpddsSurface &&
			usingDX() &&
			g_pDirectDraw->supportsRop(lRasterOp, m_bInRam, bInRam)
		)
	{

		// Setup the rects
		RECT destRect = {x, y, x + newWidth, y + newHeight};
		RECT rect = {xSrc, ySrc, xSrc + width, ySrc + height};

		// Execute the blt
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = lRasterOp;
		CONST HRESULT hr = lpddsSurface->Blt(&destRect, GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);

		// If there was an error
		if (FAILED(hr))
		{

			// Fall back to GDI
			HDC hdc = NULL;
			lpddsSurface->GetDC(&hdc);
			CONST INT nToRet = BltStretch(hdc, x, y, xSrc, ySrc, width, height, newWidth, newHeight, lRasterOp);
			lpddsSurface->ReleaseDC(hdc);
			return nToRet;

		}

		// All's good
		return TRUE;

	}
	else if (lpddsSurface)**/
	{
		// Use GDI
		HDC hdc = NULL;
		lpddsSurface->GetDC(&hdc);
		CONST INT nToRet = BltStretch(hdc, x, y, xSrc, ySrc, width, height, newWidth, newHeight, lRasterOp);
		lpddsSurface->ReleaseDC(hdc);
		return nToRet;
	}

	// Else, we've failed
	return FALSE;

}

//
// HDC target
//
INT FAST_CALL CCanvas::BltStretch(
	CONST HDC hdc,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST INT newWidth,
	CONST INT newHeight,
	CONST LONG lRasterOp
		) CONST
{

	CONST HDC srcHdc = OpenDC();
	CONST INT toRet = StretchBlt(hdc, x, y, newWidth, newHeight, srcHdc, xSrc, ySrc, width, height, lRasterOp);
	CloseDC(srcHdc);
	return toRet;

}

//
// Canvas target
//
INT FAST_CALL CCanvas::BltStretch(
	CONST CCanvas *cnv,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST INT newWidth,
	CONST INT newHeight,
	CONST LONG lRasterOp
		) CONST
{

	if (cnv->usingDX())
	{

		// Use DirectX
		return BltStretch(cnv->GetDXSurface(), x, y, xSrc, ySrc, width, height, newWidth, newHeight, lRasterOp, cnv->m_bInRam);

	}
	else
	{

		// Use GDI
		CONST HDC hdc = cnv->OpenDC();
		CONST INT toRet = BltStretch(hdc, x, y, xSrc, ySrc, width, height, newWidth, newHeight, lRasterOp);
		cnv->CloseDC(hdc);
		return toRet;

	}

}

//
// Stretch a masked canvas.
//
BOOL FAST_CALL CCanvas::BltStretchMask(
	CONST CCanvas *cnvMask,
	CONST CCanvas *cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST INT newWidth,
	CONST INT newHeight) CONST
{
	if (TRUE)
	{
		// Use GDI BitBlt and StretchBlt.
	    CONST HDC hdc = OpenDC();
        CONST HDC hdcMask = cnvMask->OpenDC();
        CONST HDC hdcTarget = cnvTarget->OpenDC();

		if (width == newWidth && height == newHeight)
		{
			// No need to use StretchBlt.
            BitBlt(hdcTarget, x, y, width, height, hdcMask, xSrc, ySrc, SRCAND);
            BitBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, SRCPAINT);
		}
        else
		{
			// Need to use StretchBlt, may fail on Win9x machines.
            StretchBlt(
				hdcTarget, 
				x, y, 
				newWidth, newHeight,
				hdcMask, 
				xSrc, ySrc, 
				width, height, 
				SRCAND
			);
            StretchBlt(
				hdcTarget, 
				x, y, 
				newWidth, newHeight,
				hdc,
				xSrc, ySrc, 
				width, height, 
				SRCPAINT
			);
        } // if (requires stretching).

        cnvTarget->CloseDC(hdcTarget);
		cnvMask->CloseDC(hdcMask);
        CloseDC(hdc);
	}
	else
	{
		// Use Dx.
		cnvMask->BltStretch(cnvTarget, x, y, xSrc, ySrc, width, height, newWidth, newHeight, SRCAND);
		this->BltStretch(cnvTarget, x, y, xSrc, ySrc, width, height, newWidth, newHeight, SRCPAINT);
	}
	return TRUE;
}

//
// Complete blt to an HDC
//
INT FAST_CALL CCanvas::Blt(
	CONST HDC hdcTarget,
	CONST INT x,
	CONST INT y,
	CONST LONG lRasterOp
		) CONST
{
	return BltPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}

//
// Complete blt to a canvas
//
INT FAST_CALL CCanvas::Blt(
	CONST CCanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG lRasterOp
		) CONST
{
	return BltPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}

//
// Complete blt to a strface
//
INT FAST_CALL CCanvas::Blt(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST LONG lRasterOp
		) CONST
{
	return BltPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}

//--------------------------------------------------------------------------
// Transparent blitter
//--------------------------------------------------------------------------

//
// HDC target
//
INT FAST_CALL CCanvas::BltTransparent(
	CONST HDC hdcTarget,
	CONST INT x,
	CONST INT y,
	CONST LONG crTransparentColor
		) CONST
{
	return BltTransparentPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}

//
// Canvas target
//
INT FAST_CALL CCanvas::BltTransparent(
	CONST CCanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG crTransparentColor
		) CONST
{
	return BltTransparentPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}

//
// Surface target
//
INT FAST_CALL CCanvas::BltTransparent(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST LONG crTransparentColor
		) CONST
{
	return BltTransparentPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}

//
// Partial - HDC target
//
INT FAST_CALL CCanvas::BltTransparentPart(
	CONST HDC hdcTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST LONG crTransparentColor
		) CONST
{
	CONST HDC hdc = OpenDC();
	CONST INT nToRet = TransparentBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, width, height, crTransparentColor);
	CloseDC(hdc);
	return nToRet;
}

//
// Partial - canvas target
//
INT FAST_CALL CCanvas::BltTransparentPart(
	CONST CCanvas *pCanvas,
	INT x,
	INT y,
	INT xSrc,
	INT ySrc,
	INT width,
	INT height,
	LONG crTransparentColor
		) CONST
{

	if (x < 0)
	{
		xSrc -= x;
		width += x;
		x = 0;
	}

	if (y < 0)
	{
		ySrc -= y;
		height += y;
		y = 0;
	}

	if (x + width > pCanvas->GetWidth())
	{
		width = pCanvas->GetWidth() - x;
	}

	if (y + height > pCanvas->GetHeight())
	{
		height = pCanvas->GetHeight() - y;
	}

	if (pCanvas->usingDX() && usingDX())
	{
		// Use DirectX
		return BltTransparentPart(pCanvas->GetDXSurface(), x, y, xSrc, ySrc, width, height, crTransparentColor);
	}
	else
	{
		// Use GDI
		CONST HDC hdc = pCanvas->OpenDC();
		CONST INT nToRet = BltTransparentPart(hdc, x, y, xSrc, ySrc, width, height, crTransparentColor);
		pCanvas->CloseDC(hdc);
		return nToRet;
	}

}

//
// Partial - surface target
//
INT FAST_CALL CCanvas::BltTransparentPart(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST LONG crTransparentColor
		) CONST
{

	// If using DirectX
	if (lpddsSurface &&usingDX())
	{

		// Obtain RGB color
		CONST LONG rgb = matchColor(crTransparentColor);

		// Setup color key
		DDCOLORKEY ddck = {rgb, rgb};
		GetDXSurface()->SetColorKey(DDCKEY_SRCBLT, &ddck);

		// Setup rectangles
		RECT destRect = {x, y, x + width, y + height};
		RECT rect = {xSrc, ySrc, xSrc + width, ySrc + height};

		// Execute the blt
		return SUCCEEDED(lpddsSurface->BltFast(x, y, this->GetDXSurface(), &rect, DDBLTFAST_WAIT | DDBLTFAST_SRCCOLORKEY));

	}
	else if (lpddsSurface)
	{
		// Use GDI
		HDC hdc = 0;
		lpddsSurface->GetDC(&hdc);
		CONST INT nToRet = BltTransparentPart(hdc, x, y, xSrc, ySrc, width, height, crTransparentColor);
		lpddsSurface->ReleaseDC(hdc);
		return nToRet;
	}

	// If here, we've failed
	return FALSE;

}

//--------------------------------------------------------------------------
// Translucent blitter
//--------------------------------------------------------------------------

//
// HDC target
//
INT FAST_CALL CCanvas::BltTranslucent(
	CONST HDC hdcTarget,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		) CONST
{

	// GDI translucent blts are way too slow - don't do it
	if (crTransparentColor == -1)
	{
		// Blt opaque
		return Blt(hdcTarget, x, y);
	}
	else
	{
		// Blt transp
		return BltTransparent(hdcTarget, x, y, crTransparentColor);
	}

}

//
// Canvas target
//
INT FAST_CALL CCanvas::BltTranslucent(
	CONST CCanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		) CONST
{

	// If using DirectX
	if (pCanvas->usingDX() && usingDX())
	{
		// Use the DX blitter
		return BltTranslucent(pCanvas->GetDXSurface(), x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	else
	{
		// Blt using GDI
		CONST HDC hdc = pCanvas->OpenDC();
		CONST INT nToRet = BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
		pCanvas->CloseDC(hdc);
		return nToRet;
	}

}

//
// Surface target
//
INT CCanvas::BltTranslucent(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		) CONST
{

	// Use the partial blitter
	return BltTranslucentPart(
		lpddsSurface,
		x, y, 0, 0,
		m_nWidth, m_nHeight,
		dIntensity, crUnaffectedColor, crTransparentColor
	);

}

//
// Partial - HDC target
//
INT FAST_CALL CCanvas::BltTranslucentPart(
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
		) CONST
{

	// GDI translucent blts are way too slow - don't do it
	if (crTransparentColor == -1)
	{
		// Blt opaque
		return Blt(hdcTarget, x, y);
	}
	else
	{
		// Blt transp
		return BltTransparent(hdcTarget, x, y, crTransparentColor);
	}

}

//
// Partial - canvas target
//
INT FAST_CALL CCanvas::BltTranslucentPart(
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
		) CONST
{

	if (pCanvas->usingDX() && usingDX())
	{
		// Blt using DirectX
		return BltTranslucentPart(
			pCanvas->GetDXSurface(),
			x, y, xSrc, ySrc,
			width, height,
			dIntensity, crUnaffectedColor, crTransparentColor
		);
	}
	else
	{
		// Blt using GDI
		CONST HDC hdc = pCanvas->OpenDC();
		CONST INT toRet = BltTranslucentPart(
			hdc,
			x, y, xSrc, ySrc,
			width, height,
			dIntensity, crUnaffectedColor, crTransparentColor
		);
		pCanvas->CloseDC(hdc);
		return toRet;
	}

}

//
// Partial - surface target
//
INT FAST_CALL CCanvas::BltTranslucentPart(
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
		) CONST
{

	// If we have a valid surface ptr and we're using DirectX
	if (lpddsSurface && usingDX())
	{

		// Lock the destination surface
		DDSURFACEDESC2 destSurface;
		DD_INIT_STRUCT(destSurface);
		HRESULT hr = lpddsSurface->Lock(NULL, &destSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);

		if (FAILED(hr))
		{
			// Return failed
			return FALSE;
		}

		// Lock the source surface
		DDSURFACEDESC2 srcSurface;
		DD_INIT_STRUCT(srcSurface);
		hr = GetDXSurface()->Lock(NULL, &srcSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);

		if (FAILED(hr))
		{

			// Unlock destination surface
			lpddsSurface->Unlock(NULL);

			// Failed
			return FALSE;

		}

		// Obtain the pixel format
		DDPIXELFORMAT ddpfDest;
		DD_INIT_STRUCT(ddpfDest);
		lpddsSurface->GetPixelFormat(&ddpfDest);

		// (Could kill this check by saving color depth and using function pointer?)

		// Switch on pixel format
		switch (ddpfDest.dwRGBBitCount)
		{

			// 32-bit color depth
			case 32:
			{

				// Calculate pixels per row
				CONST INT nDestPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
				CONST INT nSrcPixelsPerRow = srcSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);

				// Obtain pointers to the surfaces
				LPDWORD CONST pSurfDest = reinterpret_cast<LPDWORD>(destSurface.lpSurface);
				LPDWORD CONST pSurfSrc = reinterpret_cast<LPDWORD>(srcSurface.lpSurface);

				// For the y axis
				for (INT yy = 0; yy < height; yy++)
				{

					// Calculate index into destination and source, respectively
					INT idxd = (yy + y) * nDestPixelsPerRow + x;
					INT idx = (yy + ySrc) * nSrcPixelsPerRow + xSrc;

					// For the x axis
					for (INT xx = 0; xx < width; xx++)
					{

						// Obtain a pixel in RGB format
						CONST LONG srcRGB = ConvertDDColor(pSurfSrc[idx], &ddpfDest);

						// Check for unaffected color
						if (srcRGB == crUnaffectedColor)
						{
							// Directly copy
							pSurfDest[idxd] = ConvertColorRef(srcRGB, &ddpfDest);
						}

						// Check for opaque color
						else if (srcRGB != crTransparentColor)
						{

							// Obtain destination RGB
							CONST LONG destRGB = ConvertDDColor(pSurfDest[idxd], &ddpfDest);

							// Calculate translucent rgb value
							CONST INT r = INT((GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity)));
							CONST INT g = INT((GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity)));
							CONST INT b = INT((GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity)));

							// Lay down translucently
							pSurfDest[idxd] = ConvertColorRef(RGB(r, g, b), &ddpfDest);

						}

						// Increment position on surfaces
						idx++;
						idxd++;

					} // x axis
				} // y axis
			} break; // 32 bit blt

			// 24 bit color depth
			case 24:
			{

				// Modify RGB params by setting and getting a pixel
				CONST LONG crTemp = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
				LONG rgbUnaffectedColor = -1, rgbTransparentColor = -1;
				if (crUnaffectedColor != -1)
				{
					// Modify unaffected color
					SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crUnaffectedColor);
					rgbUnaffectedColor = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
				}
				if (crTransparentColor != -1)
				{
					// Modify transparent color
					SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTransparentColor);
					rgbTransparentColor = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
				}
				// Set back down pixel
				SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTemp);

				// For the y axis
				for (INT yy = 0; yy < height; yy++)
				{

					// For the x axis
					for (INT xx = 0; xx < width; xx++)
					{

						// Get pixel on source surface
						CONST LONG srcRGB = GetRGBPixel(&srcSurface, &ddpfDest, xSrc + xx, ySrc + yy);

						// Check for unaffected color
						if (srcRGB == rgbUnaffectedColor)
						{
							// Just copy over
							SetRGBPixel(&destSurface, &ddpfDest, x + xx, y + yy, srcRGB);
						}

						// If color is not transparent
						else if (srcRGB != rgbTransparentColor)
						{

							// Obtain destination pixel
							CONST LONG destRGB = GetRGBPixel(&destSurface, &ddpfDest, xx + x, yy + y);

							// Calculate new rgb color
							CONST INT r = INT((GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity)));
							CONST INT g = INT((GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity)));
							CONST INT b = INT((GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity)));

							// Set the pixel
							SetRGBPixel(&destSurface, &ddpfDest, x + xx, y + yy, RGB(r, g, b));

						}

					} // x axis
				} // y axis
			} break; // 24 bit blt

			// 16 bit color depth
			case 16:
			{

				// Calculate pixels per row
				CONST INT nDestPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
				CONST INT nSrcPixelsPerRow = srcSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);

				// Obtain pointers to the surfaces
				LPWORD CONST pSurfDest = reinterpret_cast<LPWORD>(destSurface.lpSurface);
				LPWORD CONST pSurfSrc = reinterpret_cast<LPWORD>(srcSurface.lpSurface);

				// For the y axis
				for (INT yy = 0; yy < height; yy++)
				{

					// Calculate index into destination and source, respectively
					INT idxd = (yy + y) * nDestPixelsPerRow + x;
					INT idx = (yy + ySrc) * nSrcPixelsPerRow + xSrc;

					// For the x axis
					for (INT xx = 0; xx < width; xx++)
					{

						// Obtain a pixel in RGB format
						CONST LONG srcRGB = ConvertDDColor(pSurfSrc[idx], &ddpfDest);

						// Check for unaffected color
						if (srcRGB == crUnaffectedColor)
						{
							// Directly copy
							pSurfDest[idxd] = ConvertColorRef(srcRGB, &ddpfDest);
						}

						// Check for opaque color
						else if (srcRGB != crTransparentColor)
						{

							// Obtain destination RGB
							CONST LONG destRGB = ConvertDDColor(pSurfDest[idxd], &ddpfDest);

							// Calculate translucent rgb value
							CONST INT r = (GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity));
							CONST INT g = (GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity));
							CONST INT b = (GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity));

							// Lay down translucently
							pSurfDest[idxd] = ConvertColorRef(RGB(r, g, b), &ddpfDest);

						}

						// Increment position on surfaces
						idx++;
						idxd++;

					} // x axis
				} // y axis
			} break; // 16 bit blt

			// Unsupported color depth
			default:
			{

				// Unlock surfaces
				GetDXSurface()->Unlock(NULL);
				lpddsSurface->Unlock(NULL);

				// If a transp color is not set
				if (crTransparentColor == -1)
				{
					// Just do direct blt
					return Blt(lpddsSurface, x, y);
				}
				else
				{
					// Else, do transp blt
					return BltTransparent(lpddsSurface, x, y, crTransparentColor);
				}

			} break;

		} // Color depth switch

		// Unlock the surfaces
		GetDXSurface()->Unlock(NULL);
		lpddsSurface->Unlock(NULL);

		// All's good
		return TRUE;

	} // Can use DirectX

	else if (lpddsSurface)
	{

		// Not using DirectX, but we have a surface
		HDC hdc = 0;
		lpddsSurface->GetDC(&hdc);

		// Do super slow GDI blt
		CONST INT nToRet = BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
		lpddsSurface->ReleaseDC(hdc);

		// Return the result
		return nToRet;

	}

	// If we made it here, we failed
	return FALSE;

}

//--------------------------------------------------------------------------
// Shift the canvas left
//--------------------------------------------------------------------------
INT FAST_CALL CCanvas::ShiftLeft(
	CONST INT nPixels
		)
{

	// If using DirectX
	if (usingDX())
	{

		// Create a copy of this canvas
		CONST CCanvas temp = *this;

		// Setup rects
		RECT destRect = {0, 0, m_nWidth - nPixels, m_nHeight};
		RECT rect = {nPixels, 0, m_nWidth, m_nHeight};

		// Setup the blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		return SUCCEEDED(GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx));

	}
	else
	{
		// Use GDI
		CONST HDC hdcMe = OpenDC();
		CONST INT nToRet = BitBlt(hdcMe, -nPixels, 0, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
		return nToRet;
	}

	// If here, we've failed
	return FALSE;

}

//--------------------------------------------------------------------------
// Shift the canvas right
//--------------------------------------------------------------------------
INT FAST_CALL CCanvas::ShiftRight(
	CONST INT nPixels
		)
{

	// If using DirectX
	if (usingDX())
	{

		// Create a copy of this canvas
		CONST CCanvas temp = *this;

		// Setup rects
		RECT destRect = {nPixels, 0, m_nWidth, m_nHeight};
		RECT rect = {0, 0, m_nWidth - nPixels, m_nHeight};

		// Setup the blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		return SUCCEEDED(GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx));

	}
	else
	{
		// Use GDI
		CONST HDC hdcMe = OpenDC();
		CONST INT nToRet = BitBlt(hdcMe, nPixels, 0, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
		return nToRet;
	}

	// If here, we've failed
	return FALSE;

}

//--------------------------------------------------------------------------
// Shift the canvas up
//--------------------------------------------------------------------------
INT FAST_CALL CCanvas::ShiftUp(
	CONST INT nPixels
		)
{

	// If using DirectX
	if (usingDX())
	{

		// Create a copy of this canvas
		CONST CCanvas temp = *this;

		// Setup rects
		RECT destRect = {0, 0, m_nWidth, m_nHeight - nPixels};
		RECT rect = {0, nPixels, m_nWidth, m_nHeight};

		// Setup the blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		return SUCCEEDED(GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx));

	}
	else
	{
		// Use GDI
		CONST HDC hdcMe = OpenDC();
		CONST INT nToRet = BitBlt(hdcMe, 0, -nPixels, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
		return nToRet;
	}

	// If here, we've failed
	return FALSE;

}

//--------------------------------------------------------------------------
// Shift the canvas down
//--------------------------------------------------------------------------
INT FAST_CALL CCanvas::ShiftDown(
	CONST INT nPixels
		)
{

	// If using DirectX
	if (usingDX())
	{

		// Create a copy of this canvas
		CONST CCanvas temp = *this;

		// Setup rects
		RECT destRect = {0, nPixels, m_nWidth, m_nHeight};
		RECT rect = {0, 0, m_nWidth, m_nHeight - nPixels};

		// Setup the blt effects
		DDBLTFX bltFx;
		DD_INIT_STRUCT(bltFx);
		bltFx.dwROP = SRCCOPY;

		// Execute the blt
		return SUCCEEDED(GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx));

	}
	else
	{
		// Use GDI
		CONST HDC hdcMe = OpenDC();
		CONST INT nToRet = BitBlt(hdcMe, 0, nPixels, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
		return nToRet;
	}

	// If here, we've failed
	return FALSE;

}

//
// Additive blit.
//
INT FAST_CALL CCanvas::BltAdditivePart(
	CONST LPDIRECTDRAWSURFACE7 lpddsSurface,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST DOUBLE percent,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		) CONST
{
	// Bound LONG to [0 255]
	#define BOUND(x) (x & 0x80000000 ? 0 : (x & 0x100 ? 0xFF : x))

	// If we have a valid surface ptr and we're using DirectX
	if (!(lpddsSurface && usingDX()))
	{
		return FALSE;
	}

	// Lock the destination surface
	DDSURFACEDESC2 destSurface;
	DD_INIT_STRUCT(destSurface);
	HRESULT hr = lpddsSurface->Lock(NULL, &destSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);

	if (FAILED(hr))
	{
		// Return failed
		return FALSE;
	}

	// Lock the source surface
	DDSURFACEDESC2 srcSurface;
	DD_INIT_STRUCT(srcSurface);
	hr = GetDXSurface()->Lock(NULL, &srcSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);

	if (FAILED(hr))
	{

		// Unlock destination surface
		lpddsSurface->Unlock(NULL);

		// Failed
		return FALSE;

	}

	// Obtain the pixel format
	DDPIXELFORMAT ddpfDest;
	DD_INIT_STRUCT(ddpfDest);
	lpddsSurface->GetPixelFormat(&ddpfDest);

	// (Could kill this check by saving color depth and using function pointer?)

	// Switch on pixel format
	switch (ddpfDest.dwRGBBitCount)
	{

		// 32-bit color depth
		case 32:
		{

			// Calculate pixels per row
			CONST INT nDestPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
			CONST INT nSrcPixelsPerRow = srcSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);

			// Obtain pointers to the surfaces
			LPDWORD CONST pSurfDest = reinterpret_cast<LPDWORD>(destSurface.lpSurface);
			LPDWORD CONST pSurfSrc = reinterpret_cast<LPDWORD>(srcSurface.lpSurface);

			// For the y axis
			for (INT yy = 0; yy < height; ++yy)
			{

				// Calculate index into destination and source, respectively
				INT idxd = (yy + y) * nDestPixelsPerRow + x;
				INT idx = (yy + ySrc) * nSrcPixelsPerRow + xSrc;

				// For the x axis
				for (INT xx = 0; xx < width; ++xx)
				{

					// Obtain a pixel in RGB format
					CONST LONG srcRGB = ConvertDDColor(pSurfSrc[idx], &ddpfDest);

					// Obtain destination RGB
					CONST LONG destRGB = ConvertDDColor(pSurfDest[idxd], &ddpfDest);

					// Check for unaffected color
					if (srcRGB == crUnaffectedColor)
					{
						// Directly copy
						pSurfDest[idxd] = ConvertColorRef(srcRGB, &ddpfDest);
					}

					// Check for opaque color
					else if (destRGB != crTransparentColor)
					{

						// Calculate translucent rgb value
						CONST LONG r = GetRValue(srcRGB) * percent + GetRValue(destRGB);
						CONST LONG g = GetGValue(srcRGB) * percent + GetGValue(destRGB);
						CONST LONG b = GetBValue(srcRGB) * percent + GetBValue(destRGB);

						// Bound in the region [0 255]. No advantage using ULONG.
						CONST LONG res = RGB(BOUND(r), BOUND(g), BOUND(b));
						pSurfDest[idxd] = ConvertColorRef(res, &ddpfDest);

					}

					// Increment position on surfaces
					++idx;
					++idxd;

				} // x axis
			} // y axis
		} break; // 32 bit blt

		// 24 bit color depth
		case 24:
		{

			// Modify RGB params by setting and getting a pixel
			CONST LONG crTemp = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
			LONG rgbUnaffectedColor = -1, rgbTransparentColor = -1;
			if (crUnaffectedColor != -1)
			{
				// Modify unaffected color
				SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crUnaffectedColor);
				rgbUnaffectedColor = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
			}
			if (crTransparentColor != -1)
			{
				// Modify transparent color
				SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTransparentColor);
				rgbTransparentColor = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
			}
			// Set back down pixel
			SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTemp);

			// For the y axis
			for (INT yy = 0; yy < height; ++yy)
			{

				// For the x axis
				for (INT xx = 0; xx < width; ++xx)
				{

					// Get pixel on source surface
					CONST LONG srcRGB = GetRGBPixel(&srcSurface, &ddpfDest, xSrc + xx, ySrc + yy);

					// Obtain destination pixel
					CONST LONG destRGB = GetRGBPixel(&destSurface, &ddpfDest, xx + x, yy + y);

					// Check for unaffected color
					if (srcRGB == rgbUnaffectedColor)
					{
						// Just copy over
						SetRGBPixel(&destSurface, &ddpfDest, x + xx, y + yy, srcRGB);
					}

					// If color is not transparent
					else if (destRGB != rgbTransparentColor)
					{

						// Calculate new rgb color
						CONST LONG r = GetRValue(srcRGB) * percent + GetRValue(destRGB);
						CONST LONG g = GetGValue(srcRGB) * percent + GetGValue(destRGB);
						CONST LONG b = GetBValue(srcRGB) * percent + GetBValue(destRGB);

						// Set the pixel
						CONST LONG res = RGB(BOUND(r), BOUND(g), BOUND(b));
						SetRGBPixel(&destSurface, &ddpfDest, x + xx, y + yy, res);

					}

				} // x axis
			} // y axis
		} break; // 24 bit blt

		// 16 bit color depth
		case 16:
		{

			// Calculate pixels per row
			CONST INT nDestPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
			CONST INT nSrcPixelsPerRow = srcSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);

			// Obtain pointers to the surfaces
			LPWORD CONST pSurfDest = reinterpret_cast<LPWORD>(destSurface.lpSurface);
			LPWORD CONST pSurfSrc = reinterpret_cast<LPWORD>(srcSurface.lpSurface);

			// For the y axis
			for (INT yy = 0; yy < height; ++yy)
			{

				// Calculate index into destination and source, respectively
				INT idxd = (yy + y) * nDestPixelsPerRow + x;
				INT idx = (yy + ySrc) * nSrcPixelsPerRow + xSrc;

				// For the x axis
				for (INT xx = 0; xx < width; ++xx)
				{

					// Obtain a pixel in RGB format
					CONST LONG srcRGB = ConvertDDColor(pSurfSrc[idx], &ddpfDest);

						// Obtain destination RGB
						CONST LONG destRGB = ConvertDDColor(pSurfDest[idxd], &ddpfDest);

					// Check for unaffected color
					if (srcRGB == crUnaffectedColor)
					{
						// Directly copy
						pSurfDest[idxd] = ConvertColorRef(srcRGB, &ddpfDest);
					}

					// Check for opaque color
					else if (destRGB != crTransparentColor)
					{

						// Calculate translucent rgb value
						CONST LONG r = GetRValue(srcRGB) * percent + GetRValue(destRGB);
						CONST LONG g = GetGValue(srcRGB) * percent + GetGValue(destRGB);
						CONST LONG b = GetBValue(srcRGB) * percent + GetBValue(destRGB);

						CONST LONG res = RGB(BOUND(r), BOUND(g), BOUND(b));
						pSurfDest[idxd] = ConvertColorRef(res, &ddpfDest);

					}

					// Increment position on surfaces
					++idx;
					++idxd;

				} // x axis
			} // y axis
		} break; // 16 bit blt

		// Unsupported color depth
		default:
		{

			// Unlock surfaces
			GetDXSurface()->Unlock(NULL);
			lpddsSurface->Unlock(NULL);

			// If a transp color is not set
			if (crTransparentColor == -1)
			{
				// Just do direct blt
				return Blt(lpddsSurface, x, y);
			}
			else
			{
				// Else, do transp blt
				return BltTransparent(lpddsSurface, x, y, crTransparentColor);
			}

		} break;

	} // Color depth switch

	// Unlock the surfaces
	GetDXSurface()->Unlock(NULL);
	lpddsSurface->Unlock(NULL);

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Convert a DirectX color to RGB
//--------------------------------------------------------------------------
INLINE LONG CCanvas::GetSurfaceColor(
	CONST LONG dxColor
		) CONST
{

	if (usingDX())
	{
		DDPIXELFORMAT ddpf;
		DD_INIT_STRUCT(ddpf);
		GetDXSurface()->GetPixelFormat(&ddpf);
		return ConvertDDColor(dxColor, &ddpf);
	}
	else
	{
		// GDI already uses RGB
		return dxColor;
	}

}

//--------------------------------------------------------------------------
// Obtain the canvas' HDC
//--------------------------------------------------------------------------
HDC CCanvas::OpenDC(VOID) CONST
{
	if (m_hdcLocked)
	{
		// Surface is locked
		return m_hdcLocked;
	}
	else if (m_bUseDX && m_lpddsSurface)
	{
		// Using DirectX
		HDC toRet = NULL;
		m_lpddsSurface->GetDC(&toRet);
		// Lock is implicit -- DC will not be consistent
		SetStretchBltMode(toRet, COLORONCOLOR);
		return toRet;
	}
	else
	{
		// Use GDI's DC
		return m_hdcMem;
	}
}

//--------------------------------------------------------------------------
// Close the canvas' HDC
//--------------------------------------------------------------------------
VOID CCanvas::CloseDC(
	CONST HDC hdc
		) CONST
{
	if (!m_hdcLocked && m_bUseDX && m_lpddsSurface && hdc)
	{
		// Release the DC
		m_lpddsSurface->ReleaseDC(hdc);
	}
}

//--------------------------------------------------------------------------
// Convert a DX color to a RGB color
//--------------------------------------------------------------------------
INLINE COLORREF CCanvas::ConvertDDColor(
	CONST DWORD dwColor,
	CONST LPDDPIXELFORMAT pddpf
		)
{

	DWORD dwRed = dwColor & pddpf->dwRBitMask;
	DWORD dwGreen = dwColor & pddpf->dwGBitMask;
	DWORD dwBlue = dwColor & pddpf->dwBBitMask;

	dwRed *= 255;
	dwGreen *= 255;
	dwBlue *= 255;

	dwRed /= pddpf->dwRBitMask;
	dwGreen /= pddpf->dwGBitMask;
	dwBlue /= pddpf->dwBBitMask;

	return RGB(dwRed, dwGreen, dwBlue);

}

//--------------------------------------------------------------------------
// Convert a RGB color to a DX color
//--------------------------------------------------------------------------
INLINE DWORD CCanvas::ConvertColorRef(
	CONST COLORREF crColor,
	CONST LPDDPIXELFORMAT pddpf
		)
{

	DWORD dwRed = GetRValue(crColor);
	DWORD dwGreen = GetGValue(crColor);
	DWORD dwBlue = GetBValue(crColor);

	dwRed *= pddpf->dwRBitMask;
	dwGreen *= pddpf->dwGBitMask;
	dwBlue *= pddpf->dwBBitMask;
	dwRed /= 255;
	dwGreen /= 255;
	dwBlue /= 255;

	dwRed &= pddpf->dwRBitMask;
	dwGreen &= pddpf->dwGBitMask;
	dwBlue &= pddpf->dwBBitMask;

	return (dwRed | dwGreen | dwBlue);

}

//--------------------------------------------------------------------------
// Get the number of bits from a mask
//--------------------------------------------------------------------------
INLINE WORD CCanvas::GetNumberOfBits(
	DWORD dwMask
		)
{
    WORD wBits = 0;
    while (dwMask)
    {
        dwMask &= (dwMask - 1);
        wBits++;
    }
    return wBits;
}

//--------------------------------------------------------------------------
// Get a mask position
//--------------------------------------------------------------------------
INLINE WORD CCanvas::GetMaskPos(
	CONST DWORD dwMask
		)
{
    WORD wPos = 0;
    while (!(dwMask & (1 << wPos))) wPos++;
    return wPos;
}

//--------------------------------------------------------------------------
// Set a RGB pixel
//--------------------------------------------------------------------------
INLINE VOID CCanvas::SetRGBPixel(
	CONST LPDDSURFACEDESC2 destSurface,
	CONST LPDDPIXELFORMAT pddpf,
	CONST INT x,
	CONST INT y,
	CONST LONG rgb
		)
{
	CONST WORD wRBits = GetNumberOfBits(pddpf->dwRBitMask);
	CONST WORD wGBits = GetNumberOfBits(pddpf->dwGBitMask);
	CONST WORD wBBits = GetNumberOfBits(pddpf->dwBBitMask);
	CONST WORD wRPos = GetMaskPos(pddpf->dwRBitMask);
	CONST WORD wGPos = GetMaskPos(pddpf->dwGBitMask);
	CONST WORD wBPos = GetMaskPos(pddpf->dwBBitMask);
	CONST DWORD offset = y * destSurface->lPitch + x * (pddpf->dwRGBBitCount >> 3);
	*((LPDWORD)((DWORD)destSurface->lpSurface + offset)) =
		(((((((*((LPDWORD)(DWORD)destSurface->lpSurface + offset)) & ~pddpf->dwRBitMask) |
		((GetRValue(rgb) >> (8 - wRBits)) << wRPos)) & ~pddpf->dwGBitMask) |
		((GetGValue(rgb) >> (8 - wGBits)) << wGPos)) & ~pddpf->dwBBitMask) |
		((GetBValue(rgb) >> (8 - wBBits)) << wBPos));
}

//--------------------------------------------------------------------------
// Get a pixel on a locked surface
//--------------------------------------------------------------------------
INLINE LONG CCanvas::GetRGBPixel(
	CONST LPDDSURFACEDESC2 destSurface,
	CONST LPDDPIXELFORMAT pddpf,
	CONST INT x,
	CONST INT y
		)
{
	CONST WORD wRBits = GetNumberOfBits(pddpf->dwRBitMask);
	CONST WORD wGBits = GetNumberOfBits(pddpf->dwGBitMask);
	CONST WORD wBBits = GetNumberOfBits(pddpf->dwBBitMask);
	//CONST WORD wRPos = GetMaskPos(pddpf->dwRBitMask);
	//CONST WORD wGPos = GetMaskPos(pddpf->dwGBitMask);
	//CONST WORD wBPos = GetMaskPos(pddpf->dwBBitMask);
	CONST DWORD offset = y * destSurface->lPitch + x * (pddpf->dwRGBBitCount >> 3);
	CONST DWORD pixel = *((LPDWORD)((DWORD)destSurface->lpSurface + offset));
	CONST BYTE r = (pixel & pddpf->dwRBitMask) << (8 - wRBits);
	CONST BYTE g = (pixel & pddpf->dwGBitMask) << (8 - wGBits);
	CONST BYTE b = (pixel & pddpf->dwBBitMask) << (8 - wBBits);
	return RGB(r, g, b);
}

//--------------------------------------------------------------------------
// Emulate the gamma controller settings on this surface.
//--------------------------------------------------------------------------
VOID CCanvas::EmulateGamma()
{
	extern CDirectDraw *g_pDirectDraw;

	DDSURFACEDESC2 ddsd;
	DD_INIT_STRUCT(ddsd);
	HRESULT hr = m_lpddsSurface->Lock(NULL, &ddsd, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);
	if (FAILED(hr))
		return;

	DDPIXELFORMAT ddpf;
	DD_INIT_STRUCT(ddpf);
	m_lpddsSurface->GetPixelFormat(&ddpf);

	// Calculate the colour masks for the current pixel format.
	CONST WORD wRBits = GetNumberOfBits(ddpf.dwRBitMask);
	CONST WORD wGBits = GetNumberOfBits(ddpf.dwGBitMask);
	CONST WORD wBBits = GetNumberOfBits(ddpf.dwBBitMask);
	CONST WORD wRPos = GetMaskPos(ddpf.dwRBitMask);
	CONST WORD wGPos = GetMaskPos(ddpf.dwGBitMask);
	CONST WORD wBPos = GetMaskPos(ddpf.dwBBitMask);
	CONST WORD rgbOffset = (ddpf.dwRGBBitCount >> 3);

	// Get the gamma ramp.
	DDGAMMARAMP ramp;
	g_pDirectDraw->GetGammaRamp(ramp);

	for (UINT i = 0; i < ddsd.dwWidth; ++i)
	{
		const UINT x = i * rgbOffset;

		for (UINT j = 0; j < ddsd.dwHeight; ++j)
		{
			const DWORD offset = x + j * ddsd.lPitch;

			CONST DWORD pixel = *((LPDWORD)((DWORD)ddsd.lpSurface + offset));
			BYTE r = (pixel & ddpf.dwRBitMask) << (8 - wRBits);
			BYTE g = (pixel & ddpf.dwGBitMask) << (8 - wGBits);
			BYTE b = (pixel & ddpf.dwBBitMask) << (8 - wBBits);

			// Note: This division is _slow_.
			r = ramp.red[r] / 255;
			g = ramp.green[g] / 255;
			b = ramp.blue[b] / 255;

			*((LPDWORD)((DWORD)ddsd.lpSurface + offset)) =
				(((((((*((LPDWORD)(DWORD)ddsd.lpSurface + offset)) & ~ddpf.dwRBitMask) |
				((r >> (8 - wRBits)) << wRPos)) & ~ddpf.dwGBitMask) |
				((g >> (8 - wGBits)) << wGPos)) & ~ddpf.dwBBitMask) |
				((b >> (8 - wBBits)) << wBPos));
		}
	}

	m_lpddsSurface->Unlock(NULL);
}

//--------------------------------------------------------------------------
// Set pixels using DirectX
//--------------------------------------------------------------------------
VOID FAST_CALL CCanvas::SetPixelsDX(
	CONST LPLONG p_crPixelArray,
	CONST INT x,
	CONST INT y,
	CONST INT width,
	CONST INT height
		)
{

	// Get this DX surface
	LPDIRECTDRAWSURFACE7 lpddsSurface = GetDXSurface();

	// If using DirectX
	if (lpddsSurface && usingDX())
	{

		// Lock the destination surface
		DDSURFACEDESC2 destSurface;
		DD_INIT_STRUCT(destSurface);
		HRESULT hr = lpddsSurface->Lock(NULL, &destSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);

		// If it locked
		if (!FAILED(hr))
		{

			// Obtain pixel format
			DDPIXELFORMAT ddpfDest;
			DD_INIT_STRUCT(ddpfDest);
			lpddsSurface->GetPixelFormat(&ddpfDest);

			// Switch on the pixel format
			switch (ddpfDest.dwRGBBitCount)
			{

				// 32 bit
				case 32:
				{

					CONST INT nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
					LPDWORD CONST pSurfDest = reinterpret_cast<LPDWORD>(destSurface.lpSurface);

					// Lay down the pixels
					INT idx = 0;	// Index into source array
					for (INT yy = 0; yy < height; yy++)
					{
						INT idxd = (yy + y) * nPixelsPerRow + x;
						for (INT xx = 0; xx < width; xx++)
						{

							// Convert to RGB
							CONST LONG srcRGB = p_crPixelArray[idx];

							// Set the pixel down
							CONST DWORD dClr = ConvertColorRef(srcRGB, &ddpfDest);
							pSurfDest[idxd] = dClr;

							idx++;
							idxd++;

						}
					}
				} break;

				// 16 bit
				case 16:
				{

					CONST INT nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount / 8);
					LPWORD CONST pSurfDest = reinterpret_cast<LPWORD>(destSurface.lpSurface);

					// Lay down the pixels
					INT idx = 0;	// Index into source array
					for (INT yy = 0; yy < height; yy++)
					{
						INT idxd = (yy + y) * nPixelsPerRow + x;
						for (INT xx = 0; xx < width; xx++)
						{

							// Convert to RGB
							CONST LONG srcRGB = p_crPixelArray[idx];

							// Set down the pixel
							CONST WORD dClr = ConvertColorRef(srcRGB, &ddpfDest);
							pSurfDest[idxd] = dClr;

							idx++;
							idxd++;
						}
					}
				} break;

				default:
				{
					// Just use GDI
					SetPixelsGDI(p_crPixelArray, x, y, width, height);
				}
			}

			// Unlock
			lpddsSurface->Unlock(NULL);

		}
		else
		{
			// Unlock
			lpddsSurface->Unlock(NULL);
		}
	}
	else
	{
		// Set using GDI
		SetPixelsGDI(p_crPixelArray, x, y, width, height);
	}

}

//--------------------------------------------------------------------------
// Set pixels using GDI
//--------------------------------------------------------------------------
INLINE VOID CCanvas::SetPixelsGDI(
	CONST LPLONG p_crPixelArray,
	CONST INT x,
	CONST INT y,
	CONST INT width,
	CONST INT height
		)
{

	// Lock the canvas
	Lock();

	// Position in the array
	INT arrayPos = 0;

	// Set the pixels
	for (INT yy = y; yy < y + height; yy++)
	{
		for (INT xx = x; xx < x + width; xx++)
		{
			SetPixel(xx, yy, p_crPixelArray[arrayPos++]);
		}
	}

	// Unlock the canvas
	Unlock();

}

//--------------------------------------------------------------------------
// Set a block of pixels
//--------------------------------------------------------------------------
VOID FAST_CALL CCanvas::SetPixels(
	CONST LPLONG p_crPixelArray,
	CONST INT x,
	CONST INT y,
	CONST INT width,
	CONST INT height
		)
{
	if (usingDX())
	{
		// Blt them using directX blt call
		SetPixelsDX(p_crPixelArray, x, y, width, height);
	}
	else
	{
		// Blt them using GDI
		SetPixelsGDI(p_crPixelArray, x, y, width, height);
	}
}
