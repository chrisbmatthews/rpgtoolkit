//------------------------------------------------------------------------
// All contents copyright 2003, 2004, Christopher Matthews or Contributors
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// DirectX interface
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#include "platform.h"		// Symbols for this file

//------------------------------------------------------------------------
// Default constructor
//------------------------------------------------------------------------
CDirectDraw::CDirectDraw(VOID)
{
	// Initialize all members
	m_bFullScreen = FALSE;
	m_nColorDepth = 0;
	m_nWidth = 0;
	m_nHeight = 0;
	m_lpdd = NULL;
	m_lpddsPrime = NULL;
	m_lpddsSecond = NULL;
	m_lpddClip = NULL;
	m_bUseDirectX = FALSE;
	m_hWndMain = NULL;
	m_hInstance = NULL;
	m_hDCLocked = NULL;
	m_pBackBuffer = NULL;
}

//------------------------------------------------------------------------
// Initiate the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::InitGraphicsMode(
	CONST HWND handle,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST BOOL bUseDirectX,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
		)
{

	// Store the main window's handle
	m_hWndMain = handle;

	if (!m_hWndMain) return FALSE;

	// Initialize direct draw, but only of we're using DirectX
	if (m_bUseDirectX = bUseDirectX)
	{

		// Initialize DirectX
		InitDirectX(m_hWndMain, nWidth, nHeight, nColorDepth, bFullScreen);

		if (!m_lpddsPrime)
		{
			// Problems initializing
			KillGraphicsMode();
			return FALSE;
		}

	}
	else
	{

		// Initiate the DirectX info structure
		m_lpdd = NULL;
		m_lpddsSecond = NULL;
		m_lpddClip = NULL;
		m_bFullScreen = FALSE;
		m_nColorDepth = 0;

		// Make a back buffer
		m_pBackBuffer = CreateCanvas(nWidth, nHeight, FALSE);

		// Clear back buffer
		DrawFilledRect(0, 0, nWidth, nHeight, 0);

	}

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
	}
	else
	{
		// Windowed mode
		if (FAILED(m_lpdd->SetCooperativeLevel(hWnd,DDSCL_NORMAL))) return;
		ddsd.dwFlags = DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;	// This will be the primary surface
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

		if (FAILED(m_lpdd->CreateSurface(&ddsd, &m_lpddsSecond, NULL)))
		{
			// Not enough video memory - use RAM
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			if (FAILED(m_lpdd->CreateSurface(&ddsd, &m_lpddsSecond, NULL))) return;
		}

	}

	// Black out screen
	DrawFilledRect(0, 0, nWidth, nHeight, 0);

}

//------------------------------------------------------------------------
// Kill the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::KillGraphicsMode(VOID)
{

	// Shut down direct draw, but only if we're using it
	if (m_bUseDirectX)
	{
		// Kill clipper
		if (m_lpddClip)
		{
			if (FAILED(m_lpddClip->Release())) return FALSE;
			m_lpddClip = NULL;
		}

		// Kill backbuffer
		if (m_lpddsSecond)
		{
			if FAILED(m_lpddsSecond->Release()) return FALSE;
			m_lpddsSecond = NULL;
		}

		// Kill primary surface
		if (m_lpddsPrime)
		{
			if (FAILED(m_lpddsPrime->Release())) return FALSE;
			m_lpddsPrime = NULL;
		}

		// Kill direct draw
		if (m_lpdd)
		{
			if (FAILED(m_lpdd->Release())) return FALSE;
			m_lpdd = NULL;
		}

	}
	else
	{

		// Kill back buffer
		delete m_pBackBuffer;

	}

	return TRUE;

}

//------------------------------------------------------------------------
// Get DC of the screen
//------------------------------------------------------------------------
INLINE HDC CDirectDraw::OpenDC(VOID) CONST
{

	// Return locked DC, if existent
	if (m_hDCLocked)
	{
		return m_hDCLocked;
	}

	if (m_bUseDirectX)
	{
		if (m_lpdd)
		{
			HDC hdc = 0;
			m_lpddsSecond->GetDC(&hdc);
			return hdc;
		}
	}
	else
	{
		if (m_pBackBuffer)
		{
			return m_pBackBuffer->OpenDC();
		}
		else
		{
			return GetDC(m_hWndMain);
		}
	}

	return 0;

}

//------------------------------------------------------------------------
// Close the screen's DC
//------------------------------------------------------------------------
INLINE VOID CDirectDraw::CloseDC(
	CONST HDC hdc
		) CONST
{

	// Check if screen is locked
	if (m_hDCLocked)
	{
		return;
	}

	if (m_bUseDirectX)
	{
		if (m_lpdd && hdc)
		{
			m_lpddsSecond->ReleaseDC(hdc);
		}
	}
	else
	{
		if (hdc)
		{
			if (m_pBackBuffer)
			{
				// Don't have to release it
				m_pBackBuffer->CloseDC(hdc);				
			}
			else
			{
				// Use GDI
				ReleaseDC(m_hWndMain, hdc);
			}
		}
	}
}

//------------------------------------------------------------------------
// Plot a pixel onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawPixel(
	CONST INT x,
	CONST INT y,
	CONST LONG clr
		)
{
	CONST HDC hdc = OpenDC();
	SetPixelV(hdc, x, y, clr);
	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Draw a line on the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawLine(
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
// Get the pixel at x, y
//------------------------------------------------------------------------
LONG FAST_CALL CDirectDraw::GetPixelColor(
	CONST INT x,
	CONST INT y
		) CONST
{
	CONST HDC hdc = OpenDC();
	CONST LONG lRet = GetPixel(hdc, x, y);
	CloseDC(hdc);
	return lRet;
}

//------------------------------------------------------------------------
// Draw a filled rectangle
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawFilledRect(
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
// Flip back buffer onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::Refresh(
	CONST CGDICanvas *cnv
		)
{

	if (m_bUseDirectX && m_lpdd)
	{

		if (m_bFullScreen)
		{

			if (cnv)
			{
				// Blt to a canvas
				cnv->GetDXSurface()->BltFast(0, 0, m_lpddsSecond, &m_surfaceRect, 0);
			}
			else
			{
				// Page flip
				while (FAILED(m_lpddsPrime->Flip(NULL, DDFLIP_WAIT)));
			}

		}
		else
		{

			// Get the point of the window outside of the title bar and border
			POINT ptPrimeBlt = {0, 0};
			ClientToScreen(m_hWndMain, &ptPrimeBlt);

			// Now offset the top/left of the window rect by the distance from the
			// title bar / border
			SetRect(&m_destRect, 0, 0, m_nWidth, m_nHeight);
			OffsetRect(&m_destRect, ptPrimeBlt.x, ptPrimeBlt.y);

			if (cnv)
			{
				// Blt to a canvas
				cnv->GetDXSurface()->BltFast(0, 0, m_lpddsSecond, &m_surfaceRect, DDBLTFAST_NOCOLORKEY);
			}	
			else
			{
				// Blt to the screen
				m_lpddsPrime->Blt(&m_destRect, m_lpddsSecond, &m_surfaceRect, DDBLT_WAIT | DDBLT_ROP, &m_bltFx);
			}

		}

	}
	else if (m_pBackBuffer)
	{
		// Blt offscreen canvas
		HDC hdc = GetDC(m_hWndMain);
		HDC hdcBuffer = m_pBackBuffer->OpenDC();
		BitBlt(hdc, 0, 0, m_pBackBuffer->GetWidth(), m_pBackBuffer->GetHeight(), hdcBuffer, 0, 0, SRCCOPY);
		m_pBackBuffer->CloseDC(hdcBuffer);
		ReleaseDC(m_hWndMain, hdc);
	}

	return TRUE;
}

//------------------------------------------------------------------------
// Draw text onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawText(
	CONST INT x,
	CONST INT y,
	CONST std::string strText,
	CONST std::string strTypeFace,
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
// Make a back buffer with GDI
//------------------------------------------------------------------------
CGDICanvas *FAST_CALL CDirectDraw::CreateCanvas(
	CONST INT nWidth,
	CONST INT nHeight,
	CONST BOOL bUseDX
		)
{

	// Allocate a new canvas
	CGDICanvas *pToRet = new CGDICanvas();

	if (pToRet)
	{
		// Get the screen's DC
		CONST HDC hdc = GetDC(m_hWndMain);
		if (hdc)
		{
			// Create a blank canvas
			pToRet->CreateBlank(hdc, nWidth, nHeight, bUseDX);
			// Release the DC
			ReleaseDC(m_hWndMain, hdc);
		}
	}

	// Return the canvas
	return pToRet;

}

//------------------------------------------------------------------------
// Draw a canvas onto the back buffer
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvas(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG lRasterOp
		)
{
	return DrawCanvasPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), lRasterOp);
}

//------------------------------------------------------------------------
// Draw a canvas with transparency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTransparent(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST LONG crTransparentColor
		)
{
	return DrawCanvasTransparentPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), crTransparentColor);
}

//------------------------------------------------------------------------
// Draw a canvas with translucency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTranslucent(
	CONST CGDICanvas *pCanvas,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST LONG crUnaffectedColor,
	CONST LONG crTransparentColor
		)
{

	if (pCanvas)
	{
		// If using DirectX
		if (m_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltTranslucent(m_lpddsSecond, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
		}
		else
		{
			// Use GDI
			CONST HDC hdc = OpenDC();
			CONST BOOL bToRet = pCanvas->BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
			CloseDC(hdc);
			return bToRet;
		}
	}
	else
	{
		// We've failed
		return FALSE;
	}

}

//------------------------------------------------------------------------
// Partially draw a canvas
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasPartial(
	CONST CGDICanvas *pCanvas,
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
		// If using DirectX
		if (m_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltPart(m_lpddsSecond, destX, destY, srcX, srcY, width, height, lRasterOp);
		}
		else
		{
			// Use GDI
			CONST HDC hdc = OpenDC();
			CONST BOOL bToRet = pCanvas->BltPart(hdc, destX, destY, srcX, srcY, width, height, lRasterOp);
			CloseDC(hdc);
			return bToRet;
		}
	}
	else
	{
		// We've failed
		return FALSE;
	}

}

//------------------------------------------------------------------------
// Draw part of a canvas with transparency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTransparentPartial(
	CONST CGDICanvas *pCanvas,
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
		// If using DirectX
		if (m_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltTransparentPart(m_lpddsSecond, destX, destY, srcX, srcY, width, height, crTransparentColor);
		}
		else
		{
			// Use GDI
			CONST HDC hdc = OpenDC();
			CONST BOOL bToRet = pCanvas->BltTransparentPart(hdc, destX, destY, srcX, srcY, width, height, crTransparentColor);
			CloseDC(hdc);
			return bToRet;
		}
	}
	else
	{
		// We've failed
		return FALSE;
	}

}

//------------------------------------------------------------------------
// Draw part of a canvas, using translucency
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::DrawCanvasTranslucentPartial(CONST CGDICanvas *pCanvas, CONST INT x, CONST INT y, CONST INT xSrc, CONST INT ySrc, CONST INT width, CONST INT height, CONST DOUBLE dIntensity, CONST LONG crUnaffectedColor, CONST LONG crTransparentColor)
{
	if (pCanvas)
	{
		if (m_bUseDirectX)
		{
			return BOOL(pCanvas->BltTranslucentPart(m_lpddsSecond, x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor));
		}
		else
		{
			CONST HDC hdc = OpenDC();
			CONST INT toRet = pCanvas->BltTranslucentPart(hdc, x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor);
			CloseDC(hdc);
			return BOOL(toRet);
		}
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Copy contents of screen to a canvas
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::CopyScreenToCanvas(CONST CGDICanvas *pCanvas) CONST
{
	if (pCanvas)
	{
		if (m_bUseDirectX && pCanvas->usingDX())
		{
			// Use DirectX
			RECT rect = {0, 0, m_nWidth, m_nHeight};
			return pCanvas->GetDXSurface()->BltFast(0, 0, m_lpddsSecond, &rect, DDBLTFAST_NOCOLORKEY | DDBLTFAST_WAIT);
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
// Clear the screen to a color
//------------------------------------------------------------------------
VOID FAST_CALL CDirectDraw::ClearScreen(
	CONST LONG crColor
		)
{

	// Open the screen's DC
	CONST HDC hdc = OpenDC();

	// Create a rect
	RECT r = {0, 0, 0, 0};

	// If using DirectX
	if (m_bUseDirectX)
	{
		r.right = m_nWidth + 1;
		r.bottom = m_nHeight + 1;
	}
	else
	{
		r.right = m_pBackBuffer->GetWidth() + 1;
		r.bottom = m_pBackBuffer->GetHeight() + 1;
	}

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

//------------------------------------------------------------------------
// Unlock the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::UnlockScreen(VOID)
{
	CONST HDC hdc = m_hDCLocked;
	m_hDCLocked = NULL;
	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Lock the screen
//------------------------------------------------------------------------
BOOL FAST_CALL CDirectDraw::LockScreen(VOID)
{
	m_hDCLocked = OpenDC();
	return TRUE;
}

//------------------------------------------------------------------------
// Create a DirectDraw surface
//------------------------------------------------------------------------
LPDIRECTDRAWSURFACE7 FAST_CALL CDirectDraw::createSurface(
	CONST INT width,
	CONST INT height
		) CONST
{

	// Surface ptr to return
	LPDIRECTDRAWSURFACE7 lpddsSurface = NULL;

	// If we're using DirectX
	if (m_bUseDirectX)
	{

		// Setup the struct
		DDSURFACEDESC2 ddsd;
		DD_INIT_STRUCT(ddsd);
		ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		ddsd.dwWidth = width;
		ddsd.dwHeight = height;

		// Create the surface in VRAM
		CONST HRESULT hr = m_lpdd->CreateSurface(&ddsd, &lpddsSurface, NULL);

		// If we failed
		if (FAILED(hr))
		{

			// No VRAM left, use RAM
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			m_lpdd->CreateSurface(&ddsd, &lpddsSurface, NULL);

		}

	}

	// Return the surface
	return lpddsSurface;

}

//------------------------------------------------------------------------
// Deconstructor
//------------------------------------------------------------------------
CDirectDraw::~CDirectDraw(VOID)
{
	// Kill graphics mode, just in case we're live
	KillGraphicsMode();
}
