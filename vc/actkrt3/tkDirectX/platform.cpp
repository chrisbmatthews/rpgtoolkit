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
#include "platform.h"						// Symbols for this file

//------------------------------------------------------------------------
// Globals
//------------------------------------------------------------------------
DXINFO gDXInfo;								// DirectX info structure.

//------------------------------------------------------------------------
// Locals
//------------------------------------------------------------------------
STATIC BOOL g_bUseDirectX = FALSE;			// Using DirectX?
STATIC HWND ghWndMain = NULL;				// Handle to host window
STATIC HINSTANCE ghInstance;				// Handle of instance to app
STATIC HDC ghDCLocked = NULL;				// HDC of locked surface
STATIC HRGN g_Clipper = NULL;				// Clipping region
STATIC CGDICanvas *g_pBackBuffer = NULL;	// Non-DirectX backbuffer

//------------------------------------------------------------------------
// Initiate the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL InitGraphicsMode(
	CONST HWND handle,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST BOOL bUseDirectX,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
		)
{

	// Store the main window's handle
	ghWndMain = handle;

	if (!ghWndMain) return FALSE;

	// Initialize direct draw, but only of we're using DirectX
	if (g_bUseDirectX = bUseDirectX)
	{

		gDXInfo = InitDirectX(ghWndMain, nWidth, nHeight, nColorDepth, bFullScreen);

		if (!gDXInfo.lpddsPrime)
		{
			// Problems initializing
			KillGraphicsMode();
			return FALSE;
		}

	}
	else
	{

		// Initiate the DirectX info structure
		gDXInfo.lpdd = NULL;
		gDXInfo.lpddsSecond = NULL;
		gDXInfo.windowedMode.lpddClip = NULL;
		gDXInfo.bFullScreen = FALSE;
		gDXInfo.nColorDepth = 0;

		// Make a back buffer
		g_pBackBuffer = CreateCanvas(nWidth, nHeight, FALSE);

		// Clear back buffer
		DrawFilledRect(0, 0, nWidth, nHeight, 0);

	}

	return TRUE;
}

//------------------------------------------------------------------------
// Initiate DirectX
//------------------------------------------------------------------------
DXINFO FAST_CALL InitDirectX(
	CONST HWND hWnd,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST LONG nColorDepth,
	CONST BOOL bFullScreen
		)
{

	// Initiate the return structure
	DXINFO dxInfo;
	dxInfo.lpdd = NULL;
	dxInfo.lpddsPrime = NULL;
	dxInfo.lpddsSecond = NULL;
	dxInfo.windowedMode.lpddClip = NULL;
	dxInfo.nWidth = nWidth;
	dxInfo.nHeight = nHeight;
	dxInfo.bFullScreen = bFullScreen;
	gDXInfo.nColorDepth = nColorDepth;

	// Create DirectDraw
	if (FAILED(DirectDrawCreateEx(
		NULL,
		reinterpret_cast<void **>(&dxInfo.lpdd),
		IID_IDirectDraw7, NULL))) return dxInfo;

	// Initiate the primary surface
	DDSURFACEDESC2 ddsd;
	DD_INIT_STRUCT(ddsd);

	if (bFullScreen)
	{
		// Full-screen mode
		if (FAILED(dxInfo.lpdd->SetCooperativeLevel(hWnd,DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE | DDSCL_ALLOWREBOOT))) return dxInfo;
		if (FAILED(dxInfo.lpdd->SetDisplayMode(nWidth, nHeight, nColorDepth, 0, 0))) return dxInfo;
		ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
		ddsd.dwBackBufferCount = 1;		// Make a *real* backbuffer
		ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_COMPLEX | DDSCAPS_FLIP;
	}
	else
	{
		// Windowed mode
		if (FAILED(dxInfo.lpdd->SetCooperativeLevel(hWnd,DDSCL_NORMAL))) return dxInfo;
		ddsd.dwFlags = DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;	// This will be the primary surface
	}

	// Create the primary surface
	if (FAILED(dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsPrime, NULL))) return dxInfo;

	// Create rectangles for the window and for the surface
	SetRect(&dxInfo.windowedMode.surfaceRect, 0, 0, dxInfo.nWidth, dxInfo.nHeight);

	// Get the back buffer
	if (bFullScreen)
	{
		ddsd.ddsCaps.dwCaps = DDSCAPS_BACKBUFFER;
		if (FAILED(dxInfo.lpddsPrime->GetAttachedSurface(&ddsd.ddsCaps, &dxInfo.lpddsSecond))) return dxInfo;
	}
	else
	{

		// Create clipper
		dxInfo.lpdd->CreateClipper(0, &dxInfo.windowedMode.lpddClip, NULL);

		// Set clipper window
		dxInfo.windowedMode.lpddClip->SetHWnd(0, hWnd);

		// Attach clipper
		dxInfo.lpddsPrime->SetClipper(dxInfo.windowedMode.lpddClip);

		// Setup the effects to blt with
		DD_INIT_STRUCT(dxInfo.windowedMode.bltFx);
		dxInfo.windowedMode.bltFx.dwROP = SRCCOPY;

		// Setup the backbuffer
		DD_INIT_STRUCT(ddsd);
		ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		ddsd.dwWidth = nWidth;
		ddsd.dwHeight = nHeight;

		if (FAILED(dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsSecond, NULL)))
		{
			// Not enough video memory - use RAM
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			if (FAILED(dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsSecond, NULL))) return dxInfo;
		}

	}

	// Black out screen
	DrawFilledRect(0, 0, nWidth, nHeight, 0);

	return dxInfo;

}

//------------------------------------------------------------------------
// Kill the graphics engine
//------------------------------------------------------------------------
BOOL FAST_CALL KillGraphicsMode(VOID)
{

	// Shut down direct draw, but only if we're using it
	if( g_bUseDirectX)
	{
		// Kill clipper
		if (gDXInfo.windowedMode.lpddClip)
		{
			if (FAILED(gDXInfo.windowedMode.lpddClip->Release())) return FALSE;;
			gDXInfo.windowedMode.lpddClip = NULL;
		}

		// Kill backbuffer
		if (gDXInfo.lpddsSecond)
		{
			if FAILED(gDXInfo.lpddsSecond->Release()) return FALSE;
			gDXInfo.lpddsSecond = NULL;
		}

		// Kill primary surface
		if(gDXInfo.lpddsPrime)
		{
			if (FAILED(gDXInfo.lpddsPrime->Release())) return FALSE;
			gDXInfo.lpddsPrime = NULL;
		}

		// Kill direct draw
		if(gDXInfo.lpdd)
		{
			if (FAILED(gDXInfo.lpdd->Release())) return FALSE;
			gDXInfo.lpdd = NULL;
		}

	}

	else
	{

		// Kill back buffer
		delete g_pBackBuffer;

	}

	return TRUE;

}

//------------------------------------------------------------------------
// Get DC of the screen
//------------------------------------------------------------------------
INLINE HDC OpenDC(VOID)
{

	// Return locked DC, if existent
	if (ghDCLocked)
	{
		return ghDCLocked;
	}

	if (g_bUseDirectX)
	{
		if (gDXInfo.lpdd)
		{
			HDC hdc = 0;
			gDXInfo.lpddsSecond->GetDC(&hdc);
			return hdc;
		}
	}
	else
	{
		if (g_pBackBuffer)
		{
			return g_pBackBuffer->OpenDC();
		}
		else
		{
			return GetDC(ghWndMain);
		}
	}

	return 0;

}

//------------------------------------------------------------------------
// Close the screen's DC
//------------------------------------------------------------------------
INLINE VOID CloseDC(
	CONST HDC hdc
		)
{

	// Check if screen is locked
	if (ghDCLocked)
	{
		return;
	}

	if (g_bUseDirectX)
	{
		if (gDXInfo.lpdd && hdc)
		{
			gDXInfo.lpddsSecond->ReleaseDC(hdc);
		}
	}
	else
	{
		if (hdc)
		{
			if (g_pBackBuffer)
			{
				// Don't have to release it
				g_pBackBuffer->CloseDC(hdc);				
			}
			else
			{
				// Use GDI
				ReleaseDC(ghWndMain, hdc);
			}
		}
	}
}

//------------------------------------------------------------------------
// Plot a pixel onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL DrawPixel(
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
BOOL FAST_CALL DrawLine(
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
LONG FAST_CALL GetPixelColor(
	CONST INT x,
	CONST INT y
		)
{
	CONST HDC hdc = OpenDC();
	CONST LONG lRet = GetPixel(hdc, x, y);
	CloseDC(hdc);
	return lRet;
}

//------------------------------------------------------------------------
// Draw a filled rectangle
//------------------------------------------------------------------------
BOOL FAST_CALL DrawFilledRect(
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
BOOL FAST_CALL Refresh(
	CONST CGDICanvas *cnv
		)
{
	if (g_bUseDirectX && gDXInfo.lpdd)
	{

		if (gDXInfo.bFullScreen)
		{

			if (cnv)
			{
				// Blt to a canvas
				cnv->GetDXSurface()->BltFast(0, 0, gDXInfo.lpddsSecond, &gDXInfo.windowedMode.surfaceRect, NULL);
			}
			else
			{
				// Page flip
				while (FAILED(gDXInfo.lpddsPrime->Flip(NULL, DDFLIP_WAIT)));
			}

		}
		else
		{

			// Get the point of the window outside of the title bar and border
			POINT ptPrimeBlt;
			ptPrimeBlt.x = ptPrimeBlt.y = 0;
			ClientToScreen(ghWndMain, &ptPrimeBlt);

			// Now offset the top/left of the window rect by the distance from the
			// title bar / border
			SetRect(&gDXInfo.windowedMode.destRect, 0, 0, gDXInfo.nWidth, gDXInfo.nHeight);
			OffsetRect(&gDXInfo.windowedMode.destRect, ptPrimeBlt.x, ptPrimeBlt.y);

			if (cnv)
			{
				// Blt to a canvas
				cnv->GetDXSurface()->BltFast(0, 0, gDXInfo.lpddsSecond, &gDXInfo.windowedMode.surfaceRect, DDBLTFAST_NOCOLORKEY);
			}	
			else
			{
				// Blt to the screen
				gDXInfo.lpddsPrime->Blt(&gDXInfo.windowedMode.destRect, gDXInfo.lpddsSecond, &gDXInfo.windowedMode.surfaceRect, DDBLT_WAIT | DDBLT_ROP, &gDXInfo.windowedMode.bltFx);
			}
		}
	}
	else if (g_pBackBuffer)
	{
		// Blt offscreen canvas
		HDC hdc = GetDC(ghWndMain);
		HDC hdcBuffer = g_pBackBuffer->OpenDC();
		BitBlt(hdc, 0, 0, g_pBackBuffer->GetWidth(), g_pBackBuffer->GetHeight(), hdcBuffer, 0, 0, SRCCOPY);
		g_pBackBuffer->CloseDC(hdcBuffer);
		ReleaseDC(ghWndMain, hdc);
	}

	return TRUE;
}

//------------------------------------------------------------------------
// Draw text onto the screen
//------------------------------------------------------------------------
BOOL FAST_CALL DrawText(
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
CGDICanvas *FAST_CALL CreateCanvas(INT nWidth, INT nHeight, BOOL bUseDX)
{

	// Allocate a new canvas
	CGDICanvas *pToRet = new CGDICanvas();

	if (pToRet)
	{
		// Get the screen's DC
		CONST HDC hdc = GetDC(ghWndMain);
		if (hdc)
		{
			// Create a blank canvas
			pToRet->CreateBlank(hdc, nWidth, nHeight, bUseDX);
			// Release the DC
			ReleaseDC(ghWndMain, hdc);
		}
	}

	// Return the canvas
	return pToRet;

}

//------------------------------------------------------------------------
// Draw a canvas onto the back buffer
//------------------------------------------------------------------------
BOOL FAST_CALL DrawCanvas(
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
BOOL FAST_CALL DrawCanvasTransparent(
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
BOOL FAST_CALL DrawCanvasTranslucent(
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
		if (g_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltTranslucent(gDXInfo.lpddsSecond, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
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
BOOL FAST_CALL DrawCanvasPartial(
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
		if (g_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltPart(gDXInfo.lpddsSecond, destX, destY, srcX, srcY, width, height, lRasterOp);
		}
		else
		{
			// Use GDI
			CONST HDC hdc = OpenDC();
			CONST bToRet = pCanvas->BltPart(hdc, destX, destY, srcX, srcY, width, height, lRasterOp);
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
BOOL FAST_CALL DrawCanvasTransparentPartial(
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
		if (g_bUseDirectX)
		{
			// Use DirectX
			return pCanvas->BltTransparentPart(gDXInfo.lpddsSecond, destX, destY, srcX, srcY, width, height, crTransparentColor);
		}
		else
		{
			// Use GDI
			CONST HDC hdc = OpenDC();
			CONST bToRet = pCanvas->BltTransparentPart(hdc, destX, destY, srcX, srcY, width, height, crTransparentColor);
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
BOOL FAST_CALL DrawCanvasTranslucentPartial(CONST CONST CGDICanvas *pCanvas, CONST INT x, CONST INT y, CONST INT xSrc, CONST INT ySrc, CONST INT width, CONST INT height, CONST DOUBLE dIntensity, CONST LONG crUnaffectedColor, CONST LONG crTransparentColor)
{
	if (pCanvas)
	{
		if (g_bUseDirectX)
		{
			return BOOL(pCanvas->BltTranslucentPart(gDXInfo.lpddsSecond, x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor));
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
BOOL FAST_CALL CopyScreenToCanvas(CONST CGDICanvas* pCanvas)
{
	if (pCanvas)
	{
		CONST HDC hdcSrc = OpenDC();
		CONST HDC hdcDest = pCanvas->OpenDC();
		CONST BOOL bRet = BitBlt(hdcDest, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), hdcSrc, 0, 0, SRCCOPY);
		pCanvas->CloseDC(hdcDest);
		CloseDC(hdcSrc);
		return bRet;
	}
	return FALSE;
}

//------------------------------------------------------------------------
// Clear the screen to a color
//------------------------------------------------------------------------
VOID FAST_CALL ClearScreen(
	CONST LONG crColor
		)
{

	// Open the screen's DC
	CONST HDC hdc = OpenDC();

	// Create a rect
	RECT r = {0, 0, 0, 0};

	// If using DirectX
	if (g_bUseDirectX)
	{
		r.right = gDXInfo.nWidth + 1;
		r.bottom = gDXInfo.nHeight + 1;
	}
	else
	{
		r.right = g_pBackBuffer->GetWidth() + 1;
		r.bottom = g_pBackBuffer->GetHeight() + 1;
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
BOOL FAST_CALL UnlockScreen(VOID)
{
	CONST HDC hdc = ghDCLocked;
	ghDCLocked = NULL;
	CloseDC(hdc);
	return TRUE;
}

//------------------------------------------------------------------------
// Lock the screen
//------------------------------------------------------------------------
BOOL FAST_CALL LockScreen(VOID)
{
	ghDCLocked = OpenDC();
	return TRUE;
}
