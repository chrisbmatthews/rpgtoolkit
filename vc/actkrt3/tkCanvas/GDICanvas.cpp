//////////////////////////////////////////////////////////////////////////
//All contents copyright 2003, 2004, Christopher Matthews or Contributors
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// GDICanvas.cpp: implementation of the CGDICanvas class.
// Portions based on Isometric Game Programming With DirtectX 7.0 (Pazera)
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Inclusions
//////////////////////////////////////////////////////////////////////////
#include "GDICanvas.h"		//Contains stuff for this file
#include <list>				//list class

//////////////////////////////////////////////////////////////////////////
// Externs
//////////////////////////////////////////////////////////////////////////
extern DXINFO gDXInfo;		//DirectX info structure.

//////////////////////////////////////////////////////////////////////////
// Definitions
//////////////////////////////////////////////////////////////////////////
#define CNV_HANDLE long		//handle to a canvas

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
int canvasHostHwnd = 0;					//HWND of canvas host
std::list<CGDICanvas*> g_canvasList;	//List of canvases

//////////////////////////////////////////////////////////////////////////
// Exports
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVCreateCanvasHost(int hInstance);
void APIENTRY CNVKillCanvasHost(int hInstance, int hCanvasHostDC);
int APIENTRY CNVInit();
int APIENTRY CNVShutdown();
CNV_HANDLE APIENTRY CNVCreate(long hdcCompatable, int nWidth, int nHeight, int nUseDX=1);
int APIENTRY CNVDestroy(CNV_HANDLE cnv);
long APIENTRY CNVOpenHDC(CNV_HANDLE cnv);
long APIENTRY CNVCloseHDC(CNV_HANDLE cnv, long hdc);
int APIENTRY CNVLock(CNV_HANDLE cnv);
int APIENTRY CNVUnlock(CNV_HANDLE cnv);
int APIENTRY CNVGetWidth(CNV_HANDLE cnv);
int APIENTRY CNVGetHeight(CNV_HANDLE cnv);
long APIENTRY CNVGetPixel(CNV_HANDLE cnv, int x, int y);
int APIENTRY CNVSetPixel(CNV_HANDLE cnv, int x, int y, long crColor);
int APIENTRY CNVExists(CNV_HANDLE cnv);
int APIENTRY CNVBltCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long lRasterOp = SRCCOPY);
int APIENTRY CNVBltCanvasTransparent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long crColor);
int APIENTRY CNVBltCanvasTranslucent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
long APIENTRY CNVGetRGBColor(CNV_HANDLE cnv, long crColor);
int APIENTRY CNVResize(CNV_HANDLE cnv, long hdcCompatible, int nWidth, int nHeight);
int APIENTRY CNVShiftLeft(CNV_HANDLE cnv, long nPixels);
int APIENTRY CNVShiftRight(CNV_HANDLE cnv, long nPixels);
int APIENTRY CNVShiftUp(CNV_HANDLE cnv, long nPixels);
int APIENTRY CNVShiftDown(CNV_HANDLE cnv, long nPixels);
int APIENTRY CNVBltPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long lRasterOp = SRCCOPY);
int APIENTRY CNVBltTransparentPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long crTransparentColor);

//////////////////////////////////////////////////////////////////////////
// Init the canvas system
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVInit()
{
	g_canvasList.clear();
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Kill the canvas system
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVShutdown()
{
	std::list<CGDICanvas*>::iterator itr = g_canvasList.begin();
	for (; itr != g_canvasList.end(); itr++)
	{
		delete (*itr);
	}

	g_canvasList.clear();
	return 0;
}

//////////////////////////////////////////////////////////////////////////
// Return a handle to a DC to base canvases on
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVCreateCanvasHost(int hInstance)
{
    //Create a windows class and fill it in
    WNDCLASSEX wnd;
	wnd.cbClsExtra = NULL; //Not applicable
	wnd.cbSize = sizeof(wnd); //callback size == length of the structure
	wnd.cbWndExtra = NULL; //Not applicable
	wnd.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wnd.hCursor = NULL; //Not applicable
	wnd.hIcon = NULL; //Not applicable
	wnd.hIconSm = NULL; //Not applicable
	wnd.hInstance = (HINSTANCE)hInstance; //instance of owning application
	wnd.lpfnWndProc = DefWindowProc; //Let windows manage this window
	wnd.lpszClassName = "canvasHost"; //name of this class
	wnd.lpszMenuName = NULL; //Not applicable
	wnd.style = CS_OWNDC; //ask for a DC

    //Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

	//Create the window
	canvasHostHwnd = (int)CreateWindowEx(
                                          NULL,
                                          "canvasHost",
                                          NULL,NULL,
                                          NULL,NULL,
										  NULL,NULL,
                                          NULL,NULL,
                                          (HINSTANCE)hInstance,
                                          NULL
                                               );
	//Return its hdc
	return (int)GetDC((HWND)canvasHostHwnd);

}

//////////////////////////////////////////////////////////////////////////
// Kill the canvas host
//////////////////////////////////////////////////////////////////////////
void APIENTRY CNVKillCanvasHost(int hInstance, int hCanvasHostDC)
{
	ReleaseDC((HWND)canvasHostHwnd,(HDC)hCanvasHostDC);
	DestroyWindow((HWND)canvasHostHwnd);
	UnregisterClass("canvasHost",(HINSTANCE)hInstance);
}

//////////////////////////////////////////////////////////////////////////
// Create a canvas
//////////////////////////////////////////////////////////////////////////
CNV_HANDLE APIENTRY CNVCreate(long hdcCompatable, int nWidth, int nHeight, int nUseDX)
{
	int nRet = 0;

	CGDICanvas* cnv = new CGDICanvas();
	//by default, we will attempt to create the canvas as a DirectX surface.
	//if DX is not initialised, this will default to a GDI canvas
	bool bUseDX = true;
	if (nUseDX == 0)
	{
		bUseDX = false;
	}
	cnv->CreateBlank((HDC)hdcCompatable, nWidth, nHeight, bUseDX);

	g_canvasList.push_back(cnv);

	return (CNV_HANDLE)cnv;
}

//////////////////////////////////////////////////////////////////////////
// Destroy a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVDestroy(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	g_canvasList.remove(p);
	delete p;
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Open a canvas' DC
//////////////////////////////////////////////////////////////////////////
long APIENTRY CNVOpenHDC(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return (long)p->OpenDC();
}

//////////////////////////////////////////////////////////////////////////
// Close a canvas' DC
//////////////////////////////////////////////////////////////////////////
long APIENTRY CNVCloseHDC(CNV_HANDLE cnv, long hdc)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->CloseDC((HDC)hdc);
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Lock a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVLock(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Lock();
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Unlock a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVUnlock(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Unlock();
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Get width of a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVGetWidth(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetWidth();
}

//////////////////////////////////////////////////////////////////////////
// Get height of a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVGetHeight(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetHeight();
}

//////////////////////////////////////////////////////////////////////////
// Get a pixel on a canvas
//////////////////////////////////////////////////////////////////////////
long APIENTRY CNVGetPixel(CNV_HANDLE cnv, int x, int y)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetPixel(x, y);
}

//////////////////////////////////////////////////////////////////////////
// Set a pixel on a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVSetPixel(CNV_HANDLE cnv, int x, int y, long crColor)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	HDC hdc = p->OpenDC();
	int nToRet = SetPixelV(hdc, x, y, crColor);
	p->CloseDC(hdc);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Check if a canvas exists
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVExists(CNV_HANDLE cnv)
{
	int nToRet = 0;

	std::list<CGDICanvas*>::iterator itr = g_canvasList.begin();
	for (; itr != g_canvasList.end(); itr++)
	{
		if ((CNV_HANDLE)(*itr) == cnv)
		{
			nToRet = 1;
			break;
		}
	}
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Blt on canvas to another
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVBltCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long lRasterOp)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->Blt(targ, x, y, lRasterOp);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Blt on canvas onto another using transparency
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVBltCanvasTransparent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long crColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTransparent(targ, x, y, crColor);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Blt on canvas onto another using translucency
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVBltCanvasTranslucent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTranslucent(targ, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Get a color in canvas' current color depth
//////////////////////////////////////////////////////////////////////////
long APIENTRY CNVGetRGBColor(CNV_HANDLE cnv, long crColor)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetRGBColor(crColor);
}

//////////////////////////////////////////////////////////////////////////
// Resize a canvas
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVResize(CNV_HANDLE cnv, long hdcCompatible, int nWidth, int nHeight)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Resize((HDC)hdcCompatible, nWidth, nHeight);
	return 1;
}

//////////////////////////////////////////////////////////////////////////
// Shift a canvas left
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVShiftLeft(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftLeft(nPixels);
}

//////////////////////////////////////////////////////////////////////////
// Shift a canvas right
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVShiftRight(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftRight(nPixels);
}

//////////////////////////////////////////////////////////////////////////
// Shift a canvas up
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVShiftUp(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftUp(nPixels);
}

//////////////////////////////////////////////////////////////////////////
// Shift a canvas down
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVShiftDown(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftDown(nPixels);
}

//////////////////////////////////////////////////////////////////////////
// Blt part of one canvas onto another
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVBltPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long lRasterOp)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltPart(targ, x, y, xSrc, ySrc, nWidth, nHeight, lRasterOp);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Blt part of a canvas onto another using transparency
//////////////////////////////////////////////////////////////////////////
int APIENTRY CNVBltTransparentPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long crTransparentColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTransparentPart(targ, x, y, xSrc, ySrc, nWidth, nHeight, crTransparentColor);
	return nToRet;
}

//////////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////////

inline CGDICanvas::CGDICanvas()
{
	//initialize all members to NULL or 0
	m_hdcMem=NULL;
	m_hbmNew=NULL;
	m_hbmOld=NULL;
	m_nWidth=0;
	m_nHeight=0;
	m_lpddsSurface = NULL;
	m_bUseDX = false;
	m_hdcLocked = NULL;
}

//copy c-tor (also blts the image over)
inline CGDICanvas::CGDICanvas(const CGDICanvas& rhs)
{
	//first create an equal sized canvas...
	CreateBlank(rhs.m_hdcMem, rhs.m_nWidth, rhs.m_nHeight, rhs.m_bUseDX);

	//now blt the image over...
	if (rhs.m_bUseDX)
	{
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, 0, 0, m_nWidth, m_nHeight);

		RECT rect;
		SetRect(&rect, 0, 0, m_nWidth, m_nHeight);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = m_lpddsSurface->Blt(&destRect, rhs.m_lpddsSurface, &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
	}
	else
	{
		BitBlt(m_hdcMem, 0, 0, rhs.m_nWidth, rhs.m_nHeight, rhs.m_hdcMem, 0, 0, SRCCOPY);
	}

	m_hdcLocked = NULL;
}

CGDICanvas& CGDICanvas::operator=(const CGDICanvas& rhs)
{
	if(m_hdcMem) Destroy();

	//first create an equal sized canvas...
	CreateBlank(rhs.m_hdcMem, rhs.m_nWidth, rhs.m_nHeight, rhs.m_bUseDX);

	//now blt the image over...
	if (rhs.m_bUseDX)
	{
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, 0, 0, m_nWidth, m_nHeight);

		RECT rect;
		SetRect(&rect, 0, 0, m_nWidth, m_nHeight);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = m_lpddsSurface->Blt(&destRect, rhs.m_lpddsSurface, &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
	}
	else
	{
		BitBlt(m_hdcMem, 0, 0, rhs.m_nWidth, rhs.m_nHeight, rhs.m_hdcMem, 0, 0, SRCCOPY);
	}
	m_hdcLocked = NULL;

	return(*this);
}


inline CGDICanvas::~CGDICanvas()
{
	//if the hdcMem has not been destroyed, do so
	if (usingDX())
	{
		if (m_lpddsSurface) Destroy();
	}
	else
	{
		if(m_hdcMem) Destroy();
	}
}

//////////////////////////////////////////////////////////////////////////
//Creation/Loading
//////////////////////////////////////////////////////////////////////////

//creates a blank bitmap
inline void CGDICanvas::CreateBlank(HDC hdcCompatible, int width, int height, bool bDX)
{
	if (!(bDX && gDXInfo.lpdd))
	{
		m_bUseDX = false;
		//If using GDI...

		//if the hdcMem is not null, destroy
		if(m_hdcMem) Destroy();

		//create the memory dc
		m_hdcMem=CreateCompatibleDC(hdcCompatible);

		if (!m_hdcMem)
		{
			/*LPVOID lpMsgBuf;
			FormatMessage( 
					FORMAT_MESSAGE_ALLOCATE_BUFFER | 
					FORMAT_MESSAGE_FROM_SYSTEM | 
					FORMAT_MESSAGE_IGNORE_INSERTS,
					NULL,
					GetLastError(),
					MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
					(LPTSTR) &lpMsgBuf,
					0,
					NULL 
			);
			// Process any inserts in lpMsgBuf.
			// ...
			// Display the string.
			MessageBox( NULL, (LPCTSTR)lpMsgBuf, "Error", MB_OK | MB_ICONINFORMATION );
			// Free the buffer.
			LocalFree( lpMsgBuf );*/
		}
		//create the image
		m_hbmNew=CreateCompatibleBitmap(hdcCompatible,width,height);

		//select the image into the dc
		m_hbmOld=(HBITMAP)SelectObject(m_hdcMem,m_hbmNew);
	}
	else
	{
		m_bUseDX = true;
		//create a DirectX surface...
		DDSURFACEDESC2 ddsd;

		memset(&ddsd, 0, sizeof(DDSURFACEDESC2));
		ddsd.dwSize = sizeof(DDSURFACEDESC2);
		ddsd.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS;
		ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		ddsd.dwWidth = width;
		ddsd.dwHeight = height;
		HRESULT hr = gDXInfo.lpdd->CreateSurface(&ddsd, &m_lpddsSurface, NULL);
		if (FAILED(hr))
		{
			//not enough video memory.
			ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
			hr = gDXInfo.lpdd->CreateSurface(&ddsd, &m_lpddsSurface, NULL);
		}
	}

	//assign the width and height
	m_nWidth=width;
	m_nHeight=height;

}


inline void CGDICanvas::Resize(HDC hdcCompatible, int width, int height)
{
	bool bDX = usingDX();
	Destroy();
	CreateBlank(hdcCompatible, width, height, bDX);
}


//////////////////////////////////////////////////////////////////////
//Clean-up
//////////////////////////////////////////////////////////////////////

//destroys bitmap and dc
inline void CGDICanvas::Destroy()
{
	if (!usingDX())
	{
		//restore old bitmap
		SelectObject(m_hdcMem,m_hbmOld);

		//delete new bitmap
		DeleteObject(m_hbmNew);

		//delete device context
		DeleteDC(m_hdcMem);
	}
	else
	{
		//directX
		if (m_lpddsSurface)
		{
			m_lpddsSurface->Release();
		}
	}

	//set all members to 0 or NULL
	m_hdcMem=NULL;
	m_hbmNew=NULL;
	m_hbmOld=NULL;
	m_lpddsSurface = NULL;
	m_nWidth=0;
	m_nHeight=0;
}

//////////////////////////////////////////////////////////////////////////
//Drawing
//////////////////////////////////////////////////////////////////////////

void CGDICanvas::SetPixel(int x, int y, int crColor)
{
	HDC hdc = OpenDC();
	SetPixelV(hdc, x, y, crColor);
	CloseDC(hdc);
}

inline int CGDICanvas::GetPixel(int x, int y)
{
	HDC hdc = OpenDC();
	int nToRet = ::GetPixel(hdc, x, y);
	CloseDC(hdc);
	return nToRet;
}


//Partial bltters-- blt part of this to another canvas...
inline int CGDICanvas::BltPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
{
	HDC hdc = OpenDC();
	int nToRet = BitBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, lRasterOp);
	CloseDC(hdc);
	return nToRet;
}

inline int CGDICanvas::BltPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
{
	int nToRet = 0;
	if (x < 0)
	{
		xSrc = xSrc-x;
		width = width + x;
		x = 0;
	}
	if (y < 0)
	{
		ySrc = ySrc-y;
		height = height + y;
		y = 0;
	}
	if (x+width > pCanvas->GetWidth())
	{
		width = pCanvas->GetWidth()-x;
	}
	if (y+height > pCanvas->GetHeight())
	{
		height = pCanvas->GetHeight()-y;
	}

	if (pCanvas->usingDX() && this->usingDX())
	{
		//blt them using directX blt call
		nToRet = BltPart(pCanvas->GetDXSurface(), x, y, xSrc, ySrc, width, height, lRasterOp);
	}
	else
	{
		//blt them using GDI
		HDC hdc = pCanvas->OpenDC();
		nToRet = BltPart(hdc, x, y, xSrc, ySrc, width, height, lRasterOp);
		pCanvas->CloseDC(hdc);
	}
	return nToRet;
}

inline int CGDICanvas::BltPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
{
	int nToRet = 0;
	if (lpddsSurface && this->usingDX())
	{
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, x, y, x+width, y+height);

		RECT rect;
		SetRect(&rect, xSrc, ySrc, xSrc+width, ySrc+height);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = lRasterOp;

		//HRESULT hr = lpddsSurface->Blt(&destRect, this->GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
		HRESULT hr = lpddsSurface->BltFast(x, y, this->GetDXSurface(), &rect, DDBLTFAST_WAIT | DDBLTFAST_NOCOLORKEY);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		if (lpddsSurface)
		{
			HDC hdc = 0;
			lpddsSurface->GetDC(&hdc);
			nToRet = BltPart(hdc, x, y, xSrc, ySrc, width, height, lRasterOp);
			lpddsSurface->ReleaseDC(hdc);
		}
	}
	return nToRet;
}


//blt to another hdc
inline int CGDICanvas::Blt(HDC hdcTarget, int x, int y, long lRasterOp)
{
	return BltPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}
//blt to another canvas
inline int CGDICanvas::Blt(CGDICanvas* pCanvas, int x, int y, long lRasterOp)
{
	return BltPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}
inline int CGDICanvas::Blt(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long lRasterOp)
{
	return BltPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}


//blt to another hdc, transparently
inline int CGDICanvas::BltTransparent(HDC hdcTarget, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}
//blt to another canvas, transparently
inline int CGDICanvas::BltTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}
//blt to a dx surface, transparently
inline int CGDICanvas::BltTransparent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}

inline int CGDICanvas::BltTransparentPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
{
	HDC hdc = OpenDC();
	int nToRet = TransparentBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, width, height, crTransparentColor);
	CloseDC(hdc);
	return nToRet;
}
inline int CGDICanvas::BltTransparentPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
{
	int nToRet = 0;
	if (x < 0)
	{
		xSrc = xSrc-x;
		width = width + x;
		x = 0;
	}
	if (y < 0)
	{
		ySrc = ySrc-y;
		height = height + y;
		y = 0;
	}
	if (x+width > pCanvas->GetWidth())
	{
		width = pCanvas->GetWidth()-x;
	}
	if (y+height > pCanvas->GetHeight())
	{
		height = pCanvas->GetHeight()-y;
	}

	if (pCanvas->usingDX() && this->usingDX())
	{
		//blt them using directX blt call
		nToRet = BltTransparentPart(pCanvas->GetDXSurface(), x, y, xSrc, ySrc, width, height, crTransparentColor);
	}
	else
	{
		//blt them using GDI
		HDC hdc = pCanvas->OpenDC();
		nToRet = BltTransparentPart(hdc, x, y, xSrc, ySrc, width, height, crTransparentColor);
		pCanvas->CloseDC(hdc);
	}
	return nToRet;
}
inline int CGDICanvas::BltTransparentPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
{
	int nToRet = 0;
	if (lpddsSurface && this->usingDX())
	{
		crTransparentColor = GetRGBColor(crTransparentColor);

		//set up color key...
		DDCOLORKEY ddck;
		ddck.dwColorSpaceHighValue = crTransparentColor;
		ddck.dwColorSpaceLowValue = crTransparentColor;
		this->GetDXSurface()->SetColorKey(DDCKEY_SRCBLT, &ddck);

		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, x, y, x+width, y+height);

		RECT rect;
		SetRect(&rect, xSrc, ySrc, xSrc+width, ySrc+height);

		//HRESULT hr = lpddsSurface->Blt(&destRect, this->GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_KEYSRC, NULL);
		HRESULT hr = lpddsSurface->BltFast(x, y, this->GetDXSurface(), &rect, DDBLTFAST_WAIT | DDBLTFAST_SRCCOLORKEY);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		if (lpddsSurface)
		{
			HDC hdc = 0;
			lpddsSurface->GetDC(&hdc);
			nToRet = BltTransparentPart(hdc, x, y, xSrc, ySrc, width, height, crTransparentColor);
			lpddsSurface->ReleaseDC(hdc);
		}
	}
	return nToRet;
}


inline int CGDICanvas::BltTranslucent(HDC hdcTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	//in GDI mode, translucent blts are too slow.
	//so just blt regularly...
	if (crTransparentColor == -1)
	{
		return this->Blt(hdcTarget, x, y);
	}
	else
	{
		return this->BltTransparent(hdcTarget, x, y, crTransparentColor);
	}
}

//dIntensity - intensity of translucency (0 is not displayed, 1 is fully displayed)
//crUnaffectedColor - color to ignore (set to -1 if you don't want it)
//crTransparentColor - transp color (-1 if you don't want it)
inline int CGDICanvas::BltTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	int nToRet = 0;
	if (pCanvas->usingDX() && this->usingDX())
	{
		//blt them using directX blt call
		nToRet = BltTranslucent(pCanvas->GetDXSurface(), x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	else
	{
		//blt them using GDI
		HDC hdc = pCanvas->OpenDC();
		nToRet = BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
		pCanvas->CloseDC(hdc);
	}
	return nToRet;
}
inline int CGDICanvas::BltTranslucent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	int nToRet = 0;
	if (lpddsSurface && this->usingDX())
	{
		//do a quick blt on my own...
		RECT destRect;
		SetRect(&destRect, x, y, x+this->GetWidth(), y+this->GetHeight());

		RECT rect;
		SetRect(&rect, 0, 0, this->GetWidth(), this->GetHeight());

		//lock the destination surface...
		DDSURFACEDESC2 destSurface;
		memset(&destSurface, 0, sizeof(DDSURFACEDESC2));
		destSurface.dwSize = sizeof(DDSURFACEDESC2);
		HRESULT hr = lpddsSurface->Lock(NULL, &destSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);
		if (!FAILED(hr))
		{
			//lock the source surface...
			DDSURFACEDESC2 srcSurface;
			memset(&srcSurface, 0, sizeof(DDSURFACEDESC2));
			srcSurface.dwSize = sizeof(DDSURFACEDESC2);
			hr = GetDXSurface()->Lock(NULL, &srcSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);
			if (!FAILED(hr))
			{

				DDPIXELFORMAT ddpfDest;
				memset(&ddpfDest, 0, sizeof(DDPIXELFORMAT));
				ddpfDest.dwSize = sizeof(DDPIXELFORMAT);
				lpddsSurface->GetPixelFormat(&ddpfDest);

				//I'm going to assume that the source and destination pixel formats are the same
				//maybe a bad assumption, I don't know :)
				switch (ddpfDest.dwRGBBitCount)
				{
					case 32:
					{
						int nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount/8);
						DWORD* pSurfDest = (DWORD*)destSurface.lpSurface;
						DWORD* pSurfSrc = (DWORD*)srcSurface.lpSurface;

						//now blt!!!
						int idx = 0;	//index into source surface...
						for (int yy = 0; yy < GetHeight(); yy++)
						{
							int idxd = (yy+y)*nPixelsPerRow + x;
							idx = yy * ( srcSurface.lPitch / (ddpfDest.dwRGBBitCount/8) ) + 0;
							for (int xx=0; xx < GetWidth(); xx++)
							{
								long src = pSurfSrc[idx];
								long dest = pSurfDest[idxd];
								//convert pixels to RGB...
								long srcRGB = ConvertDDColor(src, &ddpfDest);
								long destRGB = ConvertDDColor(dest, &ddpfDest);

								int r, g, b;
								if (srcRGB == crUnaffectedColor)
								{
									r = GetRValue(srcRGB);
									g = GetGValue(srcRGB);
									b = GetBValue(srcRGB);
								}
								else
								{
									if (srcRGB != crTransparentColor)
									{
										r = (GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity));
										g = (GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity));
										b = (GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity));
									}
								}
								if (srcRGB != crTransparentColor)
								{
									//ok, r, g, b contain the color we should set the dest to...
									DWORD dClr = ConvertColorRef(RGB(r, g, b), &ddpfDest);
									pSurfDest[idxd] = dClr;
								}
								
								//pSurfDest[idxd] = pSurfSrc[idx];
								idx++;
								idxd++;
							}
						}
					}
					break;

					case 24:
					{
						//obtain modified params...
						long crTemp = GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
						if (crUnaffectedColor != -1)
						{
							SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crUnaffectedColor);
							crUnaffectedColor =GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
						}
						if (crTransparentColor != -1)
						{
							SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTransparentColor);
							crTransparentColor =GetRGBPixel(&srcSurface, &ddpfDest, 1, 1);
						}
						SetRGBPixel(&srcSurface, &ddpfDest, 1, 1, crTemp);
						for (int yy = 0; yy < GetHeight(); yy++)
						{
							for (int xx=0; xx < GetWidth(); xx++)
							{
								long srcRGB = GetRGBPixel(&srcSurface, &ddpfDest, xx, yy);
								long destRGB = GetRGBPixel(&destSurface, &ddpfDest, xx+x, yy+y);
								//long src = pSurfSrc[idx];
								//long dest = pSurfDest[idxd];

								int r, g, b;
								if (srcRGB == crUnaffectedColor)
								{
									r = GetRValue(srcRGB);
									g = GetGValue(srcRGB);
									b = GetBValue(srcRGB);
								}
								else
								{
									if (srcRGB != crTransparentColor)
									{
										r = (GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity));
										g = (GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity));
										b = (GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity));
									}
								}
								if (srcRGB != crTransparentColor)
								{
									//ok, r, g, b contain the color we should set the dest to...
									long crColor = RGB(r, g, b);
									SetRGBPixel(&destSurface, &ddpfDest, x+xx, y+yy, crColor);
								}
							}
						}
					}
					break;

					case 16:
					{
						int nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount/8);
						WORD* pSurfDest = (WORD*)destSurface.lpSurface;
						WORD* pSurfSrc = (WORD*)srcSurface.lpSurface;

						//now blt!!!
						int idx = 0;	//index into source surface...
						for (int yy = 0; yy < GetHeight(); yy++)
						{
							int idxd = (yy+y)*nPixelsPerRow + x;
							idx = yy * ( srcSurface.lPitch / (ddpfDest.dwRGBBitCount/8) ) + 0;
							for (int xx=0; xx < GetWidth(); xx++)
							{
								long src = pSurfSrc[idx];
								long dest = pSurfDest[idxd];
								//convert pixels to RGB...
								long srcRGB = ConvertDDColor(src, &ddpfDest);
								long destRGB = ConvertDDColor(dest, &ddpfDest);

								int r, g, b;
								if (srcRGB == crUnaffectedColor)
								{
									r = GetRValue(srcRGB);
									g = GetGValue(srcRGB);
									b = GetBValue(srcRGB);
								}
								else
								{
									if (srcRGB != crTransparentColor)
									{
										r = (GetRValue(srcRGB) * dIntensity) + (GetRValue(destRGB) * (1 - dIntensity));
										g = (GetGValue(srcRGB) * dIntensity) + (GetGValue(destRGB) * (1 - dIntensity));
										b = (GetBValue(srcRGB) * dIntensity) + (GetBValue(destRGB) * (1 - dIntensity));
									}
								}
								if (srcRGB != crTransparentColor)
								{
									//ok, r, g, b contain the color we should set the dest to...
									WORD dClr = ConvertColorRef(RGB(r, g, b), &ddpfDest);
									pSurfDest[idxd] = dClr;
								}
								
								//pSurfDest[idxd] = pSurfSrc[idx];
								idx++;
								idxd++;
							}
						}
					}
					break;

					default:
					{
						//unsupported color depth, just blt...
						GetDXSurface()->Unlock(NULL);
						lpddsSurface->Unlock(NULL);
						if (crTransparentColor == -1)
						{
							return this->Blt(lpddsSurface, x, y);
						}
						else
						{
							return this->BltTransparent(lpddsSurface, x, y, crTransparentColor);
						}
					}
				}

				GetDXSurface()->Unlock(NULL);
				lpddsSurface->Unlock(NULL);
				nToRet = 1;
			}
			else
			{
				nToRet = 0;
				lpddsSurface->Unlock(NULL);
			}
		}
		else
		{
			nToRet = 0;
		}
	}
	else
	{
		if (lpddsSurface)
		{
			HDC hdc = 0;
			lpddsSurface->GetDC(&hdc);
			nToRet = BltTranslucent(hdc, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
			lpddsSurface->ReleaseDC(hdc);
		}
	}
	return nToRet;
}


//Shifting functions-- 'scroll' the ontents of the canvas a set number of pixels
inline int CGDICanvas::ShiftLeft(int nPixels)
{
	int nToRet = 0;
	if (this->usingDX())
	{
		CGDICanvas temp = (*this);
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, 0, 0, m_nWidth-nPixels, m_nHeight);

		RECT rect;
		SetRect(&rect, nPixels, 0, m_nWidth, m_nHeight);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		HDC hdcMe = OpenDC();
		nToRet = BitBlt(hdcMe, -nPixels, 0, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
	}
	return nToRet;
}

inline int CGDICanvas::ShiftRight(int nPixels)
{
	int nToRet = 0;
	if (this->usingDX())
	{
		CGDICanvas temp = (*this);
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, nPixels, 0, m_nWidth, m_nHeight);

		RECT rect;
		SetRect(&rect, 0, 0, m_nWidth-nPixels, m_nHeight);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		HDC hdcMe = OpenDC();
		nToRet = BitBlt(hdcMe, nPixels, 0, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
	}
	return nToRet;
}
inline int CGDICanvas::ShiftUp(int nPixels)
{
	int nToRet = 0;
	if (this->usingDX())
	{
		CGDICanvas temp = (*this);
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, 0, 0, m_nWidth, m_nHeight-nPixels);

		RECT rect;
		SetRect(&rect, 0, nPixels, m_nWidth, m_nHeight);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		HDC hdcMe = OpenDC();
		nToRet = BitBlt(hdcMe, 0, -nPixels, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
	}
	return nToRet;
}
inline int CGDICanvas::ShiftDown(int nPixels)
{
	int nToRet = 0;
	if (this->usingDX())
	{
		CGDICanvas temp = (*this);
		//blt them using directX blt call
		RECT destRect;
		SetRect(&destRect, 0, nPixels, m_nWidth, m_nHeight);

		RECT rect;
		SetRect(&rect, 0, 0, m_nWidth, m_nHeight-nPixels);

		//I'm going to use a raster operation witht he blt
		//it will be SRCCOPY (straight copy!)
		DDBLTFX bltFx;
		memset(&bltFx, 0, sizeof(DDBLTFX));
		bltFx.dwSize = sizeof(DDBLTFX);
		bltFx.dwROP = SRCCOPY;

		HRESULT hr = GetDXSurface()->Blt(&destRect, temp.GetDXSurface(), &rect, DDBLT_WAIT | DDBLT_ROP, &bltFx);
		if (FAILED(hr))
		{
			nToRet = 0;
		}
		else
		{
			nToRet = 1;
		}
	}
	else
	{
		HDC hdcMe = OpenDC();
		nToRet = BitBlt(hdcMe, 0, nPixels, GetWidth(), GetHeight(), hdcMe, 0, 0, SRCCOPY);
		CloseDC(hdcMe);
	}
	return nToRet;
}



//return the RGB equivalent of a surface color on a DX surface
inline long CGDICanvas::GetSurfaceColor(long dxColor)
{
	long lToRet = dxColor;

	if (this->usingDX())
	{
		DDPIXELFORMAT ddpf;
		memset(&ddpf, 0, sizeof(DDPIXELFORMAT));
		ddpf.dwSize = sizeof(DDPIXELFORMAT);
		this->GetDXSurface()->GetPixelFormat(&ddpf);

		lToRet = ConvertDDColor(dxColor, &ddpf);
	}

	return lToRet;
}

//return an RGB color as the equivalent on this surface
//(returns a palette entry if in DX mode, for instance)
inline long CGDICanvas::GetRGBColor(long crColor)
{
	long lToRet = crColor;

	if (this->usingDX())
	{
		DDPIXELFORMAT ddpf;
		memset(&ddpf, 0, sizeof(DDPIXELFORMAT));
		ddpf.dwSize = sizeof(DDPIXELFORMAT);
		this->GetDXSurface()->GetPixelFormat(&ddpf);

		lToRet = ConvertColorRef(crColor, &ddpf);
	}

	return lToRet;
}


//////////////////////////////////////////////////////////////////////
//Returning information
//////////////////////////////////////////////////////////////////////
//return width
inline int CGDICanvas::GetWidth()
{
	//return the width
	return(m_nWidth);
}

//return height
inline int CGDICanvas::GetHeight()
{
	//return the height
	return(m_nHeight);
}

inline HDC CGDICanvas::OpenDC()
{
	HDC hdc = 0;
	if (m_hdcLocked)
	{
		//surface was locked-- return locked hdc
		hdc = m_hdcLocked;
	}
	else
	{
		if(m_bUseDX)
		{
			//use DirectX
			if (m_lpddsSurface)
			{
				m_lpddsSurface->GetDC(&hdc);
			}
		}
		else
		{
			//use the GDI...
			hdc = m_hdcMem;
		}
	}

	return hdc;
}


inline void CGDICanvas::CloseDC(HDC hdc)
{
	if (m_hdcLocked)
	{
		//canvas is locked-- don't actually close the dc
	}
	else
	{
		if(m_bUseDX)
		{
			//use DirectX
			if (m_lpddsSurface && hdc)
			{
				m_lpddsSurface->ReleaseDC(hdc);
			}
		}
		else
		{
		}
	}
}


//Lock and unlock store the hdc so all 
//gfx operations go quickly.
//Always unlock a canvas when you're done with it!
inline void CGDICanvas::Lock()
{
	m_hdcLocked = OpenDC();
}


inline void CGDICanvas::Unlock()
{
	HDC hdc = m_hdcLocked;
	m_hdcLocked = NULL;
	CloseDC(hdc);
}



/////////////////////////////
// PRIVATE

//convert DX color to RGB color
inline COLORREF CGDICanvas::ConvertDDColor(DWORD dwColor, DDPIXELFORMAT* pddpf)
{
	DWORD dwRed = dwColor & pddpf->dwRBitMask;
	DWORD dwGreen = dwColor & pddpf->dwGBitMask;
	DWORD dwBlue = dwColor & pddpf->dwBBitMask;
	dwRed*=255;
	dwGreen*=255;
	dwBlue*=255;
	dwRed/=pddpf->dwRBitMask;
	dwGreen/=pddpf->dwGBitMask;
	dwBlue/=pddpf->dwBBitMask;
	return RGB(dwRed, dwGreen, dwBlue);
}

//convert RGB color to DX color
inline DWORD CGDICanvas::ConvertColorRef(COLORREF crColor, DDPIXELFORMAT* pddpf)
{
	DWORD dwRed = GetRValue(crColor);
	DWORD dwGreen = GetGValue(crColor);
	DWORD dwBlue = GetBValue(crColor);
	dwRed*=pddpf->dwRBitMask;
	dwGreen*=pddpf->dwGBitMask;
	dwBlue*=pddpf->dwBBitMask;
	dwRed/=255;
	dwGreen/=255;
	dwBlue/=255;

	dwRed&=pddpf->dwRBitMask;
	dwGreen&=pddpf->dwGBitMask;
	dwBlue&=pddpf->dwBBitMask;
	return (dwRed | dwGreen | dwBlue);
}


inline WORD CGDICanvas::GetNumberOfBits( DWORD dwMask )
{
    WORD wBits = 0;
    while( dwMask )
    {
        dwMask = dwMask & ( dwMask - 1 );
        wBits++;
    }
    return wBits;
}

inline WORD CGDICanvas::GetMaskPos( DWORD dwMask )
{
    WORD wPos = 0;
    while( !(dwMask & (1 << wPos)) ) wPos++;
    return wPos;
}

//set pixel on a locked surface
inline void CGDICanvas::SetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y, long rgb)
{
	WORD wRBits=GetNumberOfBits(pddpf->dwRBitMask);
	WORD wGBits=GetNumberOfBits(pddpf->dwGBitMask);
	WORD wBBits=GetNumberOfBits(pddpf->dwBBitMask);
	WORD wRPos=GetMaskPos(pddpf->dwRBitMask);
	WORD wGPos=GetMaskPos(pddpf->dwGBitMask);
	WORD wBPos=GetMaskPos(pddpf->dwBBitMask);

	DWORD Offset = y * destSurface->lPitch +
			x * (pddpf->dwRGBBitCount >> 3);
	DWORD Pixel;
	Pixel = *((LPDWORD)((DWORD)destSurface->lpSurface+Offset));
	Pixel = (Pixel & ~pddpf->dwRBitMask) |
			((GetRValue(rgb) >> (8-wRBits)) << wRPos);
	Pixel = (Pixel & ~pddpf->dwGBitMask) |
			((GetGValue(rgb) >> (8-wGBits)) << wGPos);
	Pixel = (Pixel & ~pddpf->dwBBitMask) |
			((GetBValue(rgb) >> (8-wBBits)) << wBPos);
	*((LPDWORD)((DWORD)destSurface->lpSurface+Offset)) = Pixel;
}


//get pixel on a locked surface
inline long CGDICanvas::GetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y)
{
	WORD wRBits=GetNumberOfBits(pddpf->dwRBitMask);
	WORD wGBits=GetNumberOfBits(pddpf->dwGBitMask);
	WORD wBBits=GetNumberOfBits(pddpf->dwBBitMask);
	WORD wRPos=GetMaskPos(pddpf->dwRBitMask);
	WORD wGPos=GetMaskPos(pddpf->dwGBitMask);
	WORD wBPos=GetMaskPos(pddpf->dwBBitMask);

	DWORD Offset = y * destSurface->lPitch +
			x * (pddpf->dwRGBBitCount >> 3);
	DWORD Pixel = *((LPDWORD)((DWORD)destSurface->lpSurface+Offset));

	BYTE r = (Pixel & pddpf->dwRBitMask) << (8 - wRBits);
	BYTE g = (Pixel & pddpf->dwGBitMask) << (8 - wGBits);
	BYTE b = (Pixel & pddpf->dwBBitMask) << (8 - wBBits);
	return RGB(r, g, b);
}



//Set a block of pixels to x, y of dimensions width, height
void CGDICanvas::SetPixels( long* p_crPixelArray, int x, int y, int width, int height )
{
	if (this->usingDX())
	{
		//blt them using directX blt call
		SetPixelsDX( p_crPixelArray, x, y, width, height );
	}
	else
	{
		//blt them using GDI
		SetPixelsGDI( p_crPixelArray, x, y, width, height );
	}
}


//Set pixels onto a direct draw surface
inline void CGDICanvas::SetPixelsDX( long* p_crPixelArray, int x, int y, int width, int height )
{
	//pCanvas->GetDXSurface
	//SetPixelsGDI( p_crPixelArray, x, y, width, height );

	LPDIRECTDRAWSURFACE7 lpddsSurface = this->GetDXSurface();

	if (lpddsSurface && this->usingDX())
	{
		//do a quick blt on my own...
		RECT destRect;
		SetRect(&destRect, x, y, x+this->GetWidth(), y+this->GetHeight());

		RECT rect;
		SetRect(&rect, 0, 0, this->GetWidth(), this->GetHeight());

		//lock the destination surface...
		DDSURFACEDESC2 destSurface;
		memset(&destSurface, 0, sizeof(DDSURFACEDESC2));
		destSurface.dwSize = sizeof(DDSURFACEDESC2);
		HRESULT hr = lpddsSurface->Lock(NULL, &destSurface, DDLOCK_SURFACEMEMORYPTR | DDLOCK_NOSYSLOCK | DDLOCK_WAIT, NULL);
		if (!FAILED(hr))
		{
			DDPIXELFORMAT ddpfDest;
			memset(&ddpfDest, 0, sizeof(DDPIXELFORMAT));
			ddpfDest.dwSize = sizeof(DDPIXELFORMAT);
			lpddsSurface->GetPixelFormat(&ddpfDest);

			//I'm going to assume that the source and destination pixel formats are the same
			//maybe a bad assumption, I don't know :)
			switch (ddpfDest.dwRGBBitCount)
			{
				case 32:
				{
					int nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount/8);
					DWORD* pSurfDest = (DWORD*)destSurface.lpSurface;

					//now blt!!!
					int idx = 0;	//index into source array...
					for (int yy = 0; yy < height; yy++)
					{
						int idxd = (yy+y)*nPixelsPerRow + x;
						for (int xx=0; xx < width; xx++)
						{
							//convert pixels to RGB...
							long srcRGB = p_crPixelArray[idx];

							//put the pixel down
							DWORD dClr = ConvertColorRef(srcRGB, &ddpfDest);
							pSurfDest[idxd] = dClr;

							idx++;
							idxd++;
						}
					}
				}
				break;

				case 16:
				{
					int nPixelsPerRow = destSurface.lPitch / (ddpfDest.dwRGBBitCount/8);
					WORD* pSurfDest = (WORD*)destSurface.lpSurface;

					//now blt!!!
					int idx = 0;	//index into source array...
					for (int yy = 0; yy < height; yy++)
					{
						int idxd = (yy+y)*nPixelsPerRow + x;
						for (int xx=0; xx < width; xx++)
						{
							//convert pixels to RGB...
							long srcRGB = p_crPixelArray[idx];

							//put the pixel down
							WORD dClr = ConvertColorRef(srcRGB, &ddpfDest);
							pSurfDest[idxd] = dClr;

							idx++;
							idxd++;
						}
					}
				}
				break;

				default:
				{
					//for 24 bit, just do a regular set pixel thru GDI...
					SetPixelsGDI( p_crPixelArray, x, y, width, height );
				}
			}

			lpddsSurface->Unlock(NULL);
		}
		else
		{
			lpddsSurface->Unlock(NULL);
		}
	}
	else
	{
		SetPixelsGDI( p_crPixelArray, x, y, width, height );
	}

}


//Set pixels onto an HDC surface
inline void CGDICanvas::SetPixelsGDI( long* p_crPixelArray, int x, int y, int width, int height )
{
	int xs, ys;

	Lock();
	int arrayPos = 0;
	for ( int yy = y; yy < y + height; yy++ )
	{
		for ( int xx = x; xx < x + width; xx++ )
		{
			SetPixel( xx, yy, p_crPixelArray[ arrayPos ] );
			arrayPos++;
		}
	}
	Unlock();

}
