//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

// GDICanvas.cpp: implementation of the CGDICanvas class.
// Portions based on Isometric Game Programming With DirtectX 7.0 (Pazera)
//
//////////////////////////////////////////////////////////////////////

#include "GDICanvas.h"


//globals for directx (defined in platform.cpp)...
extern DXINFO gDXInfo;		//DirectX info structure.


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CGDICanvas::CGDICanvas()
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
CGDICanvas::CGDICanvas(const CGDICanvas& rhs)
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


CGDICanvas::~CGDICanvas()
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

//////////////////////////////////////////////////////////////////////
//Creation/Loading
//////////////////////////////////////////////////////////////////////

//loads bitmap from a file
/*void CGDICanvas::Load(HDC hdcCompatible,LPCTSTR lpszFilename)
{
	//if the hdcMem is not null, destroy
	if(m_hdcMem) Destroy();

	//create the memory dc
	m_hdcMem=CreateCompatibleDC(hdcCompatible);

	//load the image
	m_hbmNew=(HBITMAP)LoadImage(NULL,lpszFilename,IMAGE_BITMAP,0,0,LR_LOADFROMFILE);

	//select the image into the dc
	m_hbmOld=(HBITMAP)SelectObject(m_hdcMem,m_hbmNew);

	//fetch the bitmaps properties
	BITMAP bmp;
	GetObject(m_hbmNew,sizeof(BITMAP),(LPVOID)&bmp);

	//assign height and width
	m_nWidth=bmp.bmWidth;
	m_nHeight=bmp.bmHeight;
}*/

//creates a blank bitmap
void CGDICanvas::CreateBlank(HDC hdcCompatible, int width, int height, bool bDX)
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


void CGDICanvas::Resize(HDC hdcCompatible, int width, int height)
{
	bool bDX = usingDX();
	Destroy();
	CreateBlank(hdcCompatible, width, height, bDX);
}


//////////////////////////////////////////////////////////////////////
//Clean-up
//////////////////////////////////////////////////////////////////////

//destroys bitmap and dc
void CGDICanvas::Destroy()
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

//////////////////////////////////////////////////////////////////////
//Drawing
//////////////////////////////////////////////////////////////////////

void CGDICanvas::SetPixel(int x, int y, int crColor)
{
	HDC hdc = OpenDC();
	SetPixelV(hdc, x, y, crColor);
	CloseDC(hdc);
}

int CGDICanvas::GetPixel(int x, int y)
{
	HDC hdc = OpenDC();
	int nToRet = ::GetPixel(hdc, x, y);
	CloseDC(hdc);
	return nToRet;
}


//Partial bltters-- blt part of this to another canvas...
int CGDICanvas::BltPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
{
	HDC hdc = OpenDC();
	int nToRet = BitBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, lRasterOp);
	CloseDC(hdc);
	return nToRet;
}

int CGDICanvas::BltPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
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

int CGDICanvas::BltPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp)
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
int CGDICanvas::Blt(HDC hdcTarget, int x, int y, long lRasterOp)
{
	return BltPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}
//blt to another canvas
int CGDICanvas::Blt(CGDICanvas* pCanvas, int x, int y, long lRasterOp)
{
	return BltPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}
int CGDICanvas::Blt(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long lRasterOp)
{
	return BltPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), lRasterOp);
}


//blt to another hdc, transparently
int CGDICanvas::BltTransparent(HDC hdcTarget, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(hdcTarget, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}
//blt to another canvas, transparently
int CGDICanvas::BltTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(pCanvas, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}
//blt to a dx surface, transparently
int CGDICanvas::BltTransparent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long crTransparentColor)
{
	return BltTransparentPart(lpddsSurface, x, y, 0, 0, GetWidth(), GetHeight(), crTransparentColor);
}

int CGDICanvas::BltTransparentPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
{
	HDC hdc = OpenDC();
	int nToRet = TransparentBlt(hdcTarget, x, y, width, height, hdc, xSrc, ySrc, width, height, crTransparentColor);
	CloseDC(hdc);
	return nToRet;
}
int CGDICanvas::BltTransparentPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
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
int CGDICanvas::BltTransparentPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor)
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


int CGDICanvas::BltTranslucent(HDC hdcTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
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
	/*HDC hdcSrc = OpenDC();
	for (int xx = 0; xx < GetWidth(); xx++)
	{
		for (int yy = 0; yy < GetHeight(); yy++)
		{
			long r, g, b;
			long crColor1 = ::GetPixel(hdcSrc, xx, yy);
			long crColor2 = ::GetPixel(hdcTarget, x+xx, y+yy);
			if (crColor1 == crUnaffectedColor)
			{
				r = GetRValue(crColor1);
				g = GetGValue(crColor1);
				b = GetBValue(crColor1);
			}
			else
			{
				if (crColor1 != crTransparentColor)
				{
					r = (GetRValue(crColor1) * dIntensity) + (GetRValue(crColor2) * (1 - dIntensity));
					g = (GetGValue(crColor1) * dIntensity) + (GetGValue(crColor2) * (1 - dIntensity));
					b = (GetBValue(crColor1) * dIntensity) + (GetBValue(crColor2) * (1 - dIntensity));
				}
			}
			if (crColor1 != crTransparentColor)
			{
				SetPixelV(hdcTarget, x+xx, y+yy, RGB(r, g, b));
			}
			//SetPixelV(hdcTarget, x+xx, y+yy, (crColor1 + crColor2) / 2);
		}
	}
	CloseDC(hdcSrc);
	return 1;*/
}

//dIntensity - intensity of translucency (0 is not displayed, 1 is fully displayed)
//crUnaffectedColor - color to ignore (set to -1 if you don't want it)
//crTransparentColor - transp color (-1 if you don't want it)
int CGDICanvas::BltTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
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
int CGDICanvas::BltTranslucent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
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
int CGDICanvas::ShiftLeft(int nPixels)
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

int CGDICanvas::ShiftRight(int nPixels)
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
int CGDICanvas::ShiftUp(int nPixels)
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
int CGDICanvas::ShiftDown(int nPixels)
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
long CGDICanvas::GetSurfaceColor(long dxColor)
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
long CGDICanvas::GetRGBColor(long crColor)
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
int CGDICanvas::GetWidth()
{
	//return the width
	return(m_nWidth);
}

//return height
int CGDICanvas::GetHeight()
{
	//return the height
	return(m_nHeight);
}

HDC CGDICanvas::OpenDC()
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


void CGDICanvas::CloseDC(HDC hdc)
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
void CGDICanvas::Lock()
{
	m_hdcLocked = OpenDC();
}


void CGDICanvas::Unlock()
{
	HDC hdc = m_hdcLocked;
	m_hdcLocked = NULL;
	CloseDC(hdc);
}



/////////////////////////////
// PRIVATE

//convert DX color to RGB color
COLORREF CGDICanvas::ConvertDDColor(DWORD dwColor, DDPIXELFORMAT* pddpf)
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
DWORD CGDICanvas::ConvertColorRef(COLORREF crColor, DDPIXELFORMAT* pddpf)
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


WORD CGDICanvas::GetNumberOfBits( DWORD dwMask )
{
    WORD wBits = 0;
    while( dwMask )
    {
        dwMask = dwMask & ( dwMask - 1 );
        wBits++;
    }
    return wBits;
}

WORD CGDICanvas::GetMaskPos( DWORD dwMask )
{
    WORD wPos = 0;
    while( !(dwMask & (1 << wPos)) ) wPos++;
    return wPos;
}

//set pixel on a locked surface
void CGDICanvas::SetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y, long rgb)
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
long CGDICanvas::GetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y)
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
void CGDICanvas::SetPixelsDX( long* p_crPixelArray, int x, int y, int width, int height )
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
void CGDICanvas::SetPixelsGDI( long* p_crPixelArray, int x, int y, int width, int height )
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
