/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
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

//------------------------------------------------------------------------
// DirectX interface
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#include "platform.h"		// Symbols for this file

//------------------------------------------------------------------------
// Determine whether we support a ROP
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::supportsRop(
	CONST LONG lRop,
	CONST BOOL bLeftRam,
	CONST BOOL bRightRam
		) CONST
{

	// Determine which index to use
	UINT idx = 0;
	if (bLeftRam)
	{
		if (bRightRam) idx = 3;
		else idx = 1;
	}
	else
	{
		if (bRightRam) idx = 2;
		else idx = 0;
	}

	// Switch on the ROP
	switch (lRop)
	{
		case SRCAND:	return m_bSrcAnd[idx];
		case SRCPAINT:	return m_bSrcPaint[idx];
		default:		return TRUE;
	}

}

//------------------------------------------------------------------------
// Initiate the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::InitGraphicsMode(
	CONST HWND handle,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
		)
{

	// Store the main window's handle
	m_hWndMain = handle;

	if (!m_hWndMain) return FALSE;

	// Initialize DirectX
	InitDirectX(m_hWndMain, nWidth, nHeight, nColorDepth, bFullScreen);

	if (!m_lpddsPrime)
	{
		// Problems initializing
		KillGraphicsMode();
		return FALSE;
	}

	// Get capabilities of video card
	DDCAPS ddcA, ddcB;
	m_lpdd->GetCaps(&ddcA, &ddcB);

	// Check raster operations

	// VRAM -> VRAM
	m_bSrcAnd[0] = (ddcA.dwRops[5] & 0x80);
	m_bSrcPaint[0] = (ddcA.dwRops[8] & 0x2000);

	// RAM -> VRAM
	m_bSrcAnd[1] = (ddcA.dwSVBRops[5] & 0x80);
	m_bSrcPaint[1] = (ddcA.dwSVBRops[8] & 0x2000);

	// VRAM -> RAM
	m_bSrcAnd[2] = (ddcA.dwVSBRops[5] & 0x80);
	m_bSrcPaint[2] = (ddcA.dwVSBRops[8] & 0x2000);

	// RAM -> RAM
	m_bSrcAnd[3] = (ddcA.dwSSBRops[5] & 0x80);
	m_bSrcPaint[3] = (ddcA.dwSSBRops[8] & 0x2000);

	// The gamma controller can only be used in full screen mode.
	// This is not really a problem because games _should_ ship in
	// full screen. However, we may want to emulate it in windowed
	// mode somehow...
	//		- Colin
	m_bGammaEnabled = ((ddcA.dwCaps2 & DDCAPS2_PRIMARYGAMMA) && bFullScreen);

	return TRUE;
}

//------------------------------------------------------------------------
// Initiate DirectX
//------------------------------------------------------------------------
VOID FAST_CALL CDirectDraw::InitDirectX(
	CONST HWND hWnd,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
		)
{

	// Set some members
	m_lpdd = NULL;
	m_lpddsPrime = NULL;
	m_lpddsSecond = NULL;
	m_lpddClip = NULL;
	m_lpddGammaControl = NULL;
	m_nWidth = nWidth;
	m_nHeight = nHeight;
	m_bFullScreen = bFullScreen;
	m_nColorDepth = nColorDepth;

	// Create DirectDraw
	if (FAILED(DirectDrawCreateEx(
		NULL,
		reinterpret_cast<LPVOID *>(&m_lpdd),
		IID_IDirectDraw7, NULL))) return;

	// Initiate the primary surface
	DDSURFACEDESC2 ddsd;
	DD_INIT_STRUCT(ddsd);

	if (bFullScreen)
	{
		// Full-screen mode
		if (FAILED(m_lpdd->SetCooperativeLevel(hWnd,DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE | DDSCL_ALLOWREBOOT))) return;
		if (FAILED(m_lpdd->SetDisplayMode(nWidth, nHeight, nColorDepth, 0, 0))) return;
		ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
		ddsd.dwBackBufferCount = 1;		// Make a *real* backbuffer
		ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_COMPLEX | DDSCAPS_FLIP;
		m_pRefresh = RefreshFullScreen;
	}
	else
	{
		// Windowed mode
		if (FAILED(m_lpdd->SetCooperativeLevel(hWnd,DDSCL_NORMAL))) return;
		ddsd.dwFlags = DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;	// This will be the primary surface
		m_pRefresh = RefreshWindowed;
	}

	// Create the primary surface
	if (FAILED(m_lpdd->CreateSurface(&ddsd, &m_lpddsPrime, NULL))) return;

	// Create rectangles for the window and for the surface
	SetRect(&m_surfaceRect, 0, 0, m_nWidth, m_nHeight);

	// Get the back buffer
	if (bFullScreen)
	{
		ddsd.ddsCaps.dwCaps = DDSCAPS_BACKBUFFER;
		if (FAILED(m_lpddsPrime->GetAttachedSurface(&ddsd.ddsCaps, &m_lpddsSecond))) return;
		m_pBackBuffer = new CCanvas(m_lpddsSecond, nWidth, nHeight, TRUE);
	}
	else
	{

		// Create clipper
		m_lpdd->CreateClipper(0, &m_lpddClip, NULL);

		// Set clipper window
		m_lpddClip->SetHWnd(0, hWnd);

		// Attach clipper
		m_lpddsPrime->SetClipper(m_lpddClip);

		// Setup the effects to blt with
		DD_INIT_STRUCT(m_bltFx);
		m_bltFx.dwROP = SRCCOPY;

		// Setup the backbuffer
		DD_INIT_STRUCT(ddsd);
		ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		ddsd.dwWidth = nWidth;
		ddsd.dwHeight = nHeight;

		CONST BOOL bUseRam = FAILED(m_lpdd->CreateSurface(&ddsd, &m_lpddsSecond, NULL));
		if (bUseRam)
		{
			// Not enough video memory - use RAM
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			if (FAILED(m_lpdd->CreateSurface(&ddsd, &m_lpddsSecond, NULL))) return;
		}
		m_pBackBuffer = new CCanvas(m_lpddsSecond, nWidth, nHeight, bUseRam);

	}

	m_lpddsPrime->QueryInterface(IID_IDirectDrawGammaControl, (void **)&m_lpddGammaControl);

	// Black out screen
	DrawFilledRect(0, 0, nWidth, nHeight, 0);

}

//------------------------------------------------------------------------
// Kill the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::KillGraphicsMode(VOID)
{
	#define SAFE_RELEASE(x) if (x) { x->Release(); x = NULL; } void(0)

	// Kill back buffer
	delete m_pBackBuffer;
	m_pBackBuffer = NULL;

	// Release DirectDraw interfaces.
	SAFE_RELEASE(m_lpddClip);
	SAFE_RELEASE(m_lpddsSecond);
	SAFE_RELEASE(m_lpddsPrime);
	SAFE_RELEASE(m_lpddGammaControl);
	SAFE_RELEASE(m_lpdd);

	return TRUE;
}

//------------------------------------------------------------------------
// Offset the gamma ramp by the colour passed in.
// Each pixel (x,y,z) is mapped to (x+r,y+g,z+b)
//------------------------------------------------------------------------
BOOL CDirectDraw::OffsetGammaRamp(INT r, INT g, INT b)
{
	if (!m_lpddGammaControl) return FALSE;

	DDGAMMARAMP ramp;

	// Actual colour variation is greater than 0-255, so we
	// multiply our colour values by 255 to bring them into the
	// magnitude of colours in the gamma ramp.
	r *= 255; g *= 255; b *= 255;

	// Offset the ramp.
	for (UINT i = 0; i < 256; ++i)
	{
		// The typical value for each index.
		const int base = 255 * i;

		// Permissible values are from 0-65535 (FFFF).
		// VC++ will not bound these and the gamma ramp uses WORDs,
		// which are unsigned, so we have to use a temp variable to
		// check if they are within the range.

		{
			int dr = base + r;
			if (dr < 0) dr = 0;
			else if (dr > 0xffff) dr = 0xffff;

			ramp.red[i] = dr;
		}

		{
			int dg = base + g;
			if (dg < 0) dg = 0;
			else if (dg > 0xffff) dg = 0xffff;

			ramp.green[i] = dg;
		}

		{
			int db = base + b;
			if (db < 0) db = 0;
			else if (db > 0xffff) db = 0xffff;

			ramp.blue[i] = db;
		}
	}

	// Install the new gamma ramp.
	return SUCCEEDED(m_lpddGammaControl->SetGammaRamp(0, &ramp));
}

//------------------------------------------------------------------------
// Flip back buffer onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::RefreshFullScreen(VOID)
{
	// Just flip
	while (FAILED(m_lpddsPrime->Flip(NULL, DDFLIP_WAIT)));
	return TRUE;
}
BOOL FAST_CALL CDirectDraw::RefreshWindowed(VOID)
{
	// Get the point of the window outside of the title bar and border
	POINT ptPrimeBlt = {0, 0};
	ClientToScreen(m_hWndMain, &ptPrimeBlt);

	// Now offset the top/left of the window rect by the distance from the
	// title bar / border
	SetRect(&m_destRect, 0, 0, m_nWidth, m_nHeight);
	OffsetRect(&m_destRect, ptPrimeBlt.x, ptPrimeBlt.y);

	// Emulate the gamma controller.
	//m_pBackBuffer->EmulateGamma();

	// Blt to the screen
	return SUCCEEDED(m_lpddsPrime->Blt(&m_destRect, m_lpddsSecond, &m_surfaceRect, DDBLT_WAIT | DDBLT_ROP, &m_bltFx));

	//m_pBackBuffer->BltAdditivePart(m_lpddsPrime, m_destRect.left, m_destRect.top, m_surfaceRect.left, m_surfaceRect.top, m_nWidth, m_nHeight, 50, -1, -1);
	//return TRUE;
}

//------------------------------------------------------------------------
// Draw a canvas with translucency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTranslucent(
	CONST CCanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		)
{
	if (pCanvas)
	{
		return pCanvas->BltTranslucent(m_lpddsSecond, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Partially draw a canvas
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasPartial(
	CONST CCanvas *pCanvas,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST LONG lRasterOp
		)
{
	if (pCanvas)
	{
		return pCanvas->BltPart(m_lpddsSecond, destX, destY, srcX, srcY, width, height, lRasterOp);
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Draw part of a canvas with transparency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTransparentPartial(
	CONST CCanvas *pCanvas,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST LONG crTransparentColor
		)
{
	if (pCanvas)
	{
		return pCanvas->BltTransparentPart(m_lpddsSecond, destX, destY, srcX, srcY, width, height, crTransparentColor);
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Draw part of a canvas, using translucency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTranslucentPartial(
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
		)
{
	if (pCanvas)
	{
		return pCanvas->BltTranslucentPart(m_lpddsSecond, x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Copy contents of screen to a canvas
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::CopyScreenToCanvas(
	CONST CCanvas *pCanvas
		) CONST
{
	if (pCanvas)
	{
		if (pCanvas->usingDX())
		{
			// Use DirectX

			// Get the point of the window outside of the title bar and border
			POINT pt = {0, 0};
			ClientToScreen(m_hWndMain, &pt);

			// Now offset the top/left of the window rect by the distance from the
			// title bar / border
			RECT rect = {0, 0, m_nWidth, m_nHeight};
			OffsetRect(&rect, pt.x, pt.y);

			return pCanvas->GetDXSurface()->BltFast(0, 0, m_lpddsPrime, &rect, DDBLTFAST_NOCOLORKEY | DDBLTFAST_WAIT);
		}
		else
		{
			// Use GDI
			CONST HDC hdcSrc = OpenDC();
			CONST HDC hdcDest = pCanvas->OpenDC();
			CONST BOOL bRet = BitBlt(hdcDest, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), hdcSrc, 0, 0, SRCCOPY);
			pCanvas->CloseDC(hdcDest);
			CloseDC(hdcSrc);
			return bRet;
		}
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Create a DirectDraw surface
//------------------------------------------------------------------------
LPDIRECTDRAWSURFACE7 FAST_CALL CDirectDraw::createSurface(
	CONST INT width,
	CONST INT height,
	CONST LPBOOL bRam
		) CONST
{
	// Setup the struct
	DDSURFACEDESC2 ddsd;
	DD_INIT_STRUCT(ddsd);
	ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
	ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
	ddsd.dwWidth = width;
	ddsd.dwHeight = height;

	// Create the surface in VRAM
	LPDIRECTDRAWSURFACE7 lpddsSurface = NULL;
	CONST HRESULT hr = m_lpdd->CreateSurface(&ddsd, &lpddsSurface, NULL);

	// If we failed
	if ((*bRam) = FAILED(hr))
	{

		// No VRAM left, use RAM
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
		m_lpdd->CreateSurface(&ddsd, &lpddsSurface, NULL);

	}

	// Return the surface
	return lpddsSurface;

}
