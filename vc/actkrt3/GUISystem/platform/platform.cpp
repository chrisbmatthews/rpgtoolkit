//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/************************************************
 Christopher B. Matthews
 platform.cpp
 Implementation of graphics system.

 ************************************************/

#include "platform.h"

//defines for main window
#define WINDOWCLASS "GFXCLASS"
#define WINDOWTITLE "Christopher B. Matthews B00109714"

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
HWND ghWndMain = NULL;

//Globals
bool g_bUseDirectX = false;		//now the option to use directX is not #defined

//globals
HINSTANCE ghInstance;			//handle of instance to app
HDC ghDCLocked = NULL;		//HDC of locked surface

//globals for directx...
DXINFO gDXInfo;		//DirectX info structure.

//global pointer to main event handling function...
EVENT_HANDLER gEvtHandler = NULL;

//clipping region
HRGN g_Clipper = NULL;

//back buffer for (a GDI or DirectX surface)
CGDICanvas* g_pBackBuffer = NULL;

//convert windows mouse flags to GUI system mouse flags
MOUSESTATE CreateMouseState(int x, int y, WPARAM wParam)
{
	MOUSESTATE toRet;
	toRet.bCTRL = false;
	toRet.bSHIFT = false;
	toRet.bLButton = false;
	toRet.bMButton = false;
	toRet.bRButton = false;
	toRet.bLButtonActive = false;
	toRet.bMButtonActive = false;
	toRet.bRButtonActive = false;

	toRet.x = x;
	toRet.y = y;

	if (wParam & MK_CONTROL)
	{
		toRet.bCTRL = true;
	}

	if (wParam & MK_LBUTTON)
	{
		toRet.bLButton = true;
	}

	if (wParam & MK_MBUTTON)
	{
		toRet.bMButton = true;
	}

	if (wParam & MK_RBUTTON)
	{
		toRet.bRButton = true;
	}

	if (wParam & MK_SHIFT)
	{
		toRet.bSHIFT = true;
	}

	return toRet;
}

////////////////////////////////////////
// SetCustomEventHandler
//
// Description:
// Set pointer to our own event handler
//
// Parameterss:
// eh - pointer to event hanlder function
//
// Return:
////////////////////////////////////////
void SetCustomEventHandler(EVENT_HANDLER eh) 
{ 
	gEvtHandler = eh; 
}


////////////////////////////////////////
// InitGraphicsMode
//
// Description:
// Startup graphics subsystem
//
// Parameterss:
// hWndHost - host window hwnd
// nWidth - width of screen
// nHeight - hiehgt of screen
// nColorDepth - color depth for dx mode (8, 16, 24, 32)
//
// Return:
// true - success
// false - failure
////////////////////////////////////////
bool InitGraphicsMode(HWND handle, int nWidth, int nHeight, bool bUseDirectX, long nColorDepth, bool bFullScreen)
{
	g_bUseDirectX = bUseDirectX;
	gDXInfo.lpdd = NULL;
	gDXInfo.lpddsSecond = NULL;
	gDXInfo.lpddclip = NULL;
	gDXInfo.bFullScreen = false;
	gDXInfo.nColorDepth = 0;

	ghWndMain = handle;

	if (!ghWndMain)
		return false;

	//initialize direct draw, but only of we're using DirectX
	if(g_bUseDirectX)
	{

		gDXInfo = InitDirectX(ghWndMain, nWidth, nHeight, nColorDepth, bFullScreen);

		if (!gDXInfo.lpddsPrime)
		{
			//problems initing...
			KillGraphicsMode();
			return false;
		}
	}
	else
	{
		//make a back buffer...
		g_pBackBuffer = CreateCanvas(nWidth, nHeight, false);

		//clear back buffer...
		DrawFilledRect(0, 0, nWidth, nHeight, 0);
	}
	

	return true;
}

////////////////////////////////////////
// InitDirectX
//
// Description:
// Initialize direct X and go into direct X mode
// (adapted from code found in Isometric Game Programming)
//
// Parameterss:
// hInstance - hinstance of controlling app
// nWidth - width of window
// nHeight - hiehgt of window
// nColorDepth - color depth
//
// Return:
// DirectX info structure.
////////////////////////////////////////
DXINFO InitDirectX(HWND hWnd, int nWidth, int nHeight, long nColorDepth, bool bFullScreen)
{
	DXINFO dxInfo;
	dxInfo.lpdd = NULL;
	dxInfo.lpddsPrime = NULL;
	dxInfo.lpddsSecond = NULL;
	dxInfo.lpddclip = NULL;
	dxInfo.nWidth = nWidth;
	dxInfo.nHeight = nHeight;
	dxInfo.bFullScreen = bFullScreen;
	gDXInfo.nColorDepth = nColorDepth;

	//create the direct draw object...
	HRESULT hr = DirectDrawCreateEx(NULL, (void**)&dxInfo.lpdd, IID_IDirectDraw7, NULL);
	if (FAILED(hr))
		return dxInfo;

	//set cooperative level to grab full screen...
	if (bFullScreen)
	{
		hr = dxInfo.lpdd->SetCooperativeLevel(hWnd,DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE | DDSCL_ALLOWREBOOT);
	}
	else
	{
		hr = dxInfo.lpdd->SetCooperativeLevel(hWnd,DDSCL_NORMAL);
	}
	if (FAILED(hr))
		return dxInfo;

	//go into graphics mode (24 bpp)...
	if (bFullScreen)
	{
		hr = dxInfo.lpdd->SetDisplayMode(nWidth, nHeight, nColorDepth, 0, 0);
		if (FAILED(hr))
			return dxInfo;
	}

	//create a primary surface...
	DDSURFACEDESC2 ddsd;
	memset(&ddsd, 0, sizeof(DDSURFACEDESC2));
	ddsd.dwSize = sizeof(DDSURFACEDESC2);
	ddsd.dwFlags = DDSD_CAPS;
	ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;	//this will be the primary surface
	dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsPrime, NULL);

	if (!bFullScreen)
	{
		//create clipper
		dxInfo.lpdd->CreateClipper(0,&dxInfo.lpddclip,NULL);
		//set clipper window
		dxInfo.lpddclip->SetHWnd(0,hWnd);
		//attach clipper
		dxInfo.lpddsPrime->SetClipper(dxInfo.lpddclip);
	}

	//if (!bFullScreen)
	{
		//create the secondary surface...
		//this is going to be an offscreen image, instead of a true
		//offscreen surface...
		memset(&ddsd, 0, sizeof(DDSURFACEDESC2));
		ddsd.dwSize = sizeof(DDSURFACEDESC2);
		ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		ddsd.dwWidth = nWidth;
		ddsd.dwHeight = nHeight;
		hr = dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsSecond, NULL);
		if (FAILED(hr))
		{
			//not enough video memory.
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			hr = dxInfo.lpdd->CreateSurface(&ddsd, &dxInfo.lpddsSecond, NULL);
		}
	}
	/*else
	{
		//running in fullscreen mode, so make a back buffer
		DDSCAPS2 ddsCaps;
		memset(&ddsCaps, 0, sizeof(DDSCAPS2));
		ddsCaps.dwCaps = DDSCAPS_BACKBUFFER;
		hr = dxInfo.lpddsPrime->GetAttachedSurface(&ddsCaps, &dxInfo.lpddsSecond);
	}*/


	DrawFilledRect(0, 0, nWidth, nHeight, 0);
		

	return dxInfo;
}


////////////////////////////////////////
// KillGraphicsMode
//
// Description:
// Terminate graphics subsystem
//
// Parameters:
//
// Return:
// true - success
// false - failure
////////////////////////////////////////
bool KillGraphicsMode()
{
	//shut down direct draw, but only if we're using it...
	if(g_bUseDirectX)
	{
		if(gDXInfo.lpddclip)
		{
			gDXInfo.lpddclip->Release();
			gDXInfo.lpddclip=NULL;
		}

		//kill primary surface...
		if(gDXInfo.lpddsPrime)
		{
			gDXInfo.lpddsPrime->Release();
			gDXInfo.lpddsPrime = NULL;
		}

		if (gDXInfo.lpddsSecond)
		{
			gDXInfo.lpddsSecond->Release();
			gDXInfo.lpddsSecond = NULL;
		}

		//kill direct draw...
		if(gDXInfo.lpdd)
		{
			gDXInfo.lpdd->Release();
			gDXInfo.lpdd = NULL;
		}
	}
	else
	{
		//kill back buffer...
		delete g_pBackBuffer;
	}

	return true;
}


HDC OpenDC()
{
	//first check if the screen is locked...
	if (ghDCLocked)
	{
		return ghDCLocked;
	}

	HDC hdc = 0;
	if (g_bUseDirectX)
	{
		//use DirectX
		if (gDXInfo.lpdd)
		{
			gDXInfo.lpddsSecond->GetDC(&hdc);
		}
	}
	else
	{
		if (g_pBackBuffer)
		{
			hdc = g_pBackBuffer->OpenDC();
		}
		else
		{
			hdc = GetDC(ghWndMain);
		}
	}

	return hdc;
}


void CloseDC(HDC hdc)
{
	//check if screen is locked
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
				//don't have to release it.
				g_pBackBuffer->CloseDC(hdc);				
			}
			else
			{
				//use the GDI...
				ReleaseDC(ghWndMain, hdc);
			}
		}
	}
}


////////////////////////////////////////
// DrawPixel
//
// Description:
// Plot a pixel on the surface
//
// Parameters:
// x - x coord to draw to.
// y - y coord to draw to.
// clr - color of pixel.
//
// Return:
// true - success
// false - failure
////////////////////////////////////////
bool DrawPixel(int x, int y, long clr)
{
	HDC hdc = OpenDC();

	SetPixelV(hdc, x, y, clr);

	CloseDC(hdc);
	return true;
}


////////////////////////////////////////
// DrawLine
//
// Description:
// Plot a pixel on the surface
//
// Parameters:
// x1, y1 - x coord to draw to.
// x2, y2 - y coord to draw to.
// clr - color of pixel.
//
// Return:
// true - success
// false - failure
////////////////////////////////////////
bool DrawLine(int x1, int y1, int x2, int y2, long clr)
{
	HDC hdc = OpenDC();

	POINT point;
	HPEN brush = CreatePen(0, 1, clr);
	HGDIOBJ m = SelectObject(hdc, brush);
	MoveToEx(hdc, x1, y1, &point);
	LineTo(hdc, x2, y2);
	SelectObject(hdc, m);
	DeleteObject(brush);

	CloseDC(hdc);
	return true;
}


long GetPixelColor(int x, int y)
{
	HDC hdc = OpenDC();

	long lRet = GetPixel(hdc, x, y);

	CloseDC(hdc);

	return lRet;
}

bool DrawFilledRect(int x1, int y1, int x2, int y2, long clr)
{
	HDC hdc = OpenDC();

	RECT r;
	r.left = x1;
	r.top = y1;
	r.bottom = y2+1;
	r.right = x2+1;

	HPEN pen = CreatePen(0, 1, clr);
	HGDIOBJ l = SelectObject(hdc, pen);
	HBRUSH brush = CreateSolidBrush(clr);
	HGDIOBJ m = SelectObject(hdc, brush);

	FillRect(hdc, &r, brush);

	SelectObject(hdc, m);
	SelectObject(hdc, l);
	DeleteObject(brush);
	DeleteObject(pen);

	CloseDC(hdc);

	return true;
}


////////////////////////////////////////
// Refresh
//
// Description:
// Flip the secondary surface onto the
// primary surface (only functions in DX mode)
//
// Parameters:
//
// Return:
// true - success
// false - failure
////////////////////////////////////////
bool Refresh()
{
	if(g_bUseDirectX)
	{
		/*if (gDXInfo.bFullScreen)
		{
			//running full screen -- flip surfaces
			gDXInfo.lpddsPrime->Flip(NULL, DDFLIP_WAIT);
		}
		else*/
		{
			if (gDXInfo.lpdd)
			{
				//copy secondary surface to primary surface...
				RECT rect;
				RECT destrect;
				SetRect(&rect, 0, 0, gDXInfo.nWidth, gDXInfo.nHeight);
				SetRect(&destrect, 0, 0, gDXInfo.nWidth, gDXInfo.nHeight);

				//SetRect(&rect, 0, 0, gDXInfo.nWidth-1, gDXInfo.nHeight-1);
				//SetRect(&destrect, 0, 0, gDXInfo.nWidth-1, gDXInfo.nHeight-1);

				if (gDXInfo.lpddclip)
				{
					//if in windowed mode, offset the rect...
					POINT ptPrimeBlt;
					ptPrimeBlt.x = ptPrimeBlt.y = 0;
					ClientToScreen(ghWndMain,&ptPrimeBlt);

					//offset by the screen coordinate of the window's client area
					OffsetRect(&destrect,ptPrimeBlt.x,ptPrimeBlt.y);
				}

				//I'm going to use a raster operation witht he blt
				//it will be SRCCOPY (straight copy!)
				DDBLTFX bltFx;
				memset(&bltFx, 0, sizeof(DDBLTFX));
				bltFx.dwSize = sizeof(DDBLTFX);
				bltFx.dwROP = SRCCOPY;

				gDXInfo.lpddsPrime->Blt(&destrect, gDXInfo.lpddsSecond, &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
				//gDXInfo.lpddsPrime->BltFast(0, 0, gDXInfo.lpddsSecond, &rect, DDBLTFAST_WAIT | DDBLTFAST_NOCOLORKEY);
			}
		}
	}
	else
	{
		
		//if offscreen buffer exists, blit it formward.
		if (g_pBackBuffer)
		{
			HDC hdc = GetDC(ghWndMain);
			
			HDC hdcBuffer = g_pBackBuffer->OpenDC();
			BitBlt(hdc, 0, 0, g_pBackBuffer->GetWidth(), g_pBackBuffer->GetHeight(), hdcBuffer, 0, 0, SRCCOPY);
			g_pBackBuffer->CloseDC(hdcBuffer);
			
			ReleaseDC(ghWndMain, hdc);
		}
	}

	return true;
}


bool DrawText(int x, int y, std::string strText, std::string strTypeFace, int size, long clr, bool bold, bool italics, bool underline, bool centred, bool outlined)
{

  int nWeight = 0;
  if (bold)
	{
		nWeight = FW_BOLD;
	}
	else
	{
		nWeight = FW_NORMAL;
	}

	HFONT hFont = 0;
	hFont = CreateFont(size, 0, 0, 0, nWeight, italics, underline, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, strTypeFace.c_str());
	if (hFont)
	{
		HDC hdc = OpenDC();

    SetBkMode(hdc, TRANSPARENT);
		//SetBkColor(hdc, bkclr);
		
		HGDIOBJ hOld = SelectObject(hdc, hFont);

		SetTextColor(hdc, clr);

		if ( centred )
		{
			SetTextAlign(hdc, TA_CENTER);
		} 
		else 
		{
			SetTextAlign(hdc, TA_LEFT);
		}


		HGDIOBJ hOldBrush,hNewBrush;
		hNewBrush = CreateSolidBrush(clr);
		hOldBrush = SelectObject(hdc, hNewBrush);

		if (outlined)
		{
			BeginPath(hdc);
			TextOut(hdc, x, y, strText.c_str(), strText.length());
			EndPath(hdc);
        
			SetBkColor(hdc, clr);
			SetBkMode(hdc, OPAQUE);
			StrokeAndFillPath(hdc);
		} 
		else
		{
			TextOut(hdc, x, y, strText.c_str(), strText.length());
		}

		SelectObject(hdc, hOldBrush);
		DeleteObject(hNewBrush);

		//put the old font back...
		SelectObject(hdc, hOld);
		DeleteObject(hFont);

		CloseDC(hdc);
	}
	else
	{
		return false;
	}

	return true;
}


bool DrawGradientRect(int x1, int y1, int x2, int y2, long clr1, long clr2)
{
	//set up the gradiated transition...
	RGBCOLOR c1, c2;
	c1.red = GetRValue(clr1);
	c1.green = GetGValue(clr1);
	c1.blue = GetBValue(clr1);

	c2.red = GetRValue(clr2);
	c2.green = GetGValue(clr2);
	c2.blue = GetBValue(clr2);

	//obtain transition steps...
	float fStepR = ((float)c2.red - c1.red) / abs(x2-x1);
	float fStepG = ((float)c2.green - c1.green) / abs(x2-x1);
	float fStepB = ((float)c2.blue - c1.blue) / abs(x2-x1);

	float r = c1.red;
	float g = c1.green;
	float b = c1.blue;

	//now draw the gradient...
	for (int x = x1; x <= x2; x++)
	{
		::DrawLine(x, y1, x, y2, RGB(r, g, b));
		r += fStepR;
		g += fStepG;
		b += fStepB;
	}
	return true;
}

//Create a GDI canvas we can use as a back buffer
CGDICanvas* CreateCanvas(int nWidth, int nHeight, bool bUseDX)
{
	CGDICanvas* pToRet = NULL;

	//get dc of screen...
	HDC hdc = 0;
	//use the GDI...
	hdc = GetDC(ghWndMain);


	pToRet = new CGDICanvas();
	if (pToRet)
	{
		pToRet->CreateBlank(hdc, nWidth, nHeight, bUseDX);
	}

	//release dc...
	if (hdc)
	{
		//use the GDI...
		ReleaseDC(ghWndMain, hdc);
	}

	return pToRet;
}


//copy contents of a canvas to the screen at x, y
bool DrawCanvas(CGDICanvas* pCanvas, int x, int y, long lRasterOp)
{
	return DrawCanvasPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), lRasterOp);
}


//copy contents of a canvas to the screen at x, y with transparency
bool DrawCanvasTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor)
{
	return DrawCanvasTransparentPartial(pCanvas, x, y, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), crTransparentColor);
}


bool DrawCanvasTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	bool bToRet = false;
	if (pCanvas)
	{
		if(g_bUseDirectX)
		{
			bToRet = pCanvas->BltTranslucent(gDXInfo.lpddsSecond, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
		}
		else
		{
			//use GDI
			HDC hdc = OpenDC();

			int n = pCanvas->BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
			if (n == 1)
			{
				bToRet = true;
			}
			
			CloseDC(hdc);
		}
	}

	return bToRet;
}


bool DrawCanvasPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp)
{
	bool bToRet = false;
	if (pCanvas)
	{
		if(g_bUseDirectX)
		{
			//use DirectX
			int n = pCanvas->BltPart(gDXInfo.lpddsSecond, destx, desty, srcx, srcy, width, height, lRasterOp);
			if (n == 1)
			{
				bToRet = true;
			}
		}
		else
		{
			//use GDI
			HDC hdc = OpenDC();

			int n = pCanvas->BltPart(hdc, destx, desty, srcx, srcy, width, height, lRasterOp);
			if (n == 1)
			{
				bToRet = true;
			}
			
			CloseDC(hdc);
		}
	}

	return bToRet;
}
bool DrawCanvasTransparentPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long crTransparentColor)
{
	bool bToRet = false;
	if (pCanvas)
	{
		if(g_bUseDirectX)
		{
			//use DirectX
			int n = pCanvas->BltTransparentPart(gDXInfo.lpddsSecond, destx, desty, srcx, srcy, width, height, crTransparentColor);
			if (n == 1)
			{
				bToRet = true;
			}
		}
		else
		{
			HDC hdc = OpenDC();

			int n = pCanvas->BltTransparentPart(hdc, destx, desty, srcx, srcy, width, height, crTransparentColor);
			if (n == 0)
			{
				bToRet = true;
			}
			
			CloseDC(hdc);
		}
	}

	return bToRet;
}

//copy the screen to a canvas
//SLow right now....
//returns 0 on failure
int CopyScreenToCanvas(CGDICanvas* pCanvas)
{
	int nRet = 0;
	if (pCanvas)
	{
		HDC hdcSrc = OpenDC();
		HDC hdcDest = pCanvas->OpenDC();
		
		nRet = BitBlt(hdcDest, 0, 0, pCanvas->GetWidth(), pCanvas->GetHeight(), hdcSrc, 0, 0, SRCCOPY);

		pCanvas->CloseDC(hdcDest);
		CloseDC(hdcSrc);
	}
	return nRet;
}


void ClearScreen(long crColor)
{
	HDC hdc = OpenDC();
	RECT r;
	r.left = 0;
	r.top = 0;

	if(g_bUseDirectX)
	{
		r.right = gDXInfo.nWidth+1;
		r.bottom = gDXInfo.nHeight+1;
	}
	else
	{
		r.right = g_pBackBuffer->GetWidth() + 1;
		r.bottom = g_pBackBuffer->GetHeight() + 1;
	}

	HPEN pen = CreatePen(0, 1, crColor);
	HGDIOBJ l = SelectObject(hdc, pen);
	HBRUSH brush = CreateSolidBrush(crColor);
	HGDIOBJ m = SelectObject(hdc, brush);

	FillRect(hdc, &r, brush);

	SelectObject(hdc, m);
	SelectObject(hdc, l);
	DeleteObject(brush);
	DeleteObject(pen);

	//FillRect(hdc, &r, (HBRUSH)GetStockObject(BLACK_BRUSH));

	CloseDC(hdc);
}


/*bool SetClippingRect(int x, int y, int width, int height)
{
	g_Clipper = CreateRectRgn(x, y, x+width, y+height);

	HDC hdc = OpenDC();

	//select into clipping region...
	HGDIOBJ a = SelectObject(hdc, g_Clipper);
	DeleteObject(a);

	CloseDC(hdc);

	return true;
}

bool ClearClipping()
{
	HRGN clipper = NULL;

	HDC hdc = OpenDC();

	//select into clipping region...
	SelectObject(hdc, clipper);
	DeleteObject(g_Clipper);

	CloseDC(hdc);

	return true;
}
*/

///////////////////////
// LOCKING FUNCTIONS
//
// Locks the screen (obtains the hdc) so you can do a lot of drawing
// all at once with the locked drawing functions.
// ALWAYS UNLOCK WHEN DONE!!!

bool LockScreen()
{
	ghDCLocked = OpenDC();
	return true;
}

bool UnlockScreen()
{
	HDC hdc = ghDCLocked;
	ghDCLocked = NULL;
	CloseDC(hdc);
	return true;
}

