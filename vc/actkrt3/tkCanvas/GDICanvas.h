//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

// GDICanvas.h: interface for the CGDICanvas class.
// Portions based on Isometric Game Programming With DirtectX 7.0 (Pazera)
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GDICANVAS_H__F5EB4F68_2CBC_11D4_A1EE_8F7A3049432E__INCLUDED_)
#define AFX_GDICANVAS_H__F5EB4F68_2CBC_11D4_A1EE_8F7A3049432E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include <windows.h>

///for DirectX...
#include "..\GUISystem\platform\platform.h"

typedef struct _tagColor24
{
	unsigned char r;
	unsigned char g;
	unsigned char b;
} COLOR24;

//GDICanvas--wrapper for a dc and a bitmap
class CGDICanvas  
{
	public:
		CGDICanvas();
		CGDICanvas(const CGDICanvas& rhs);
		~CGDICanvas();
		CGDICanvas& operator=(const CGDICanvas& rhs);

		//methods...
		//void Load(HDC hdcCompatible,LPCTSTR lpszFilename);	//loads bitmap from a file
		void CreateBlank(HDC hdcCompatible, int width, int height, bool bDX = false);	//creates a blank bitmap
		void Destroy();  //destroys bitmap and dc
		void SetPixel(int x, int y, int crColor);
		int GetPixel(int x, int y);
		int GetWidth();
		int GetHeight();
		HDC OpenDC();
		void CloseDC(HDC hdc);
		void Lock();
		void Unlock();
		void SetPixels( long* p_crPixelArray, int x, int y, int width, int height );

		void Resize(HDC hdcCompatible, int width, int height);

		bool usingDX() { return m_bUseDX; }

		int Blt(HDC hdcTarget, int x, int y, long lRasterOp = SRCCOPY);
		int Blt(CGDICanvas* pCanvas, int x, int y, long lRasterOp = SRCCOPY);
		int Blt(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long lRasterOp = SRCCOPY);

		int BltPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);
		int BltPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);
		int BltPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);

		int BltTransparent(HDC hdcTarget, int x, int y, long crTransparentColor);
		int BltTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor);
		int BltTransparent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long crTransparentColor);

		int BltTransparentPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);
		int BltTransparentPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);
		int BltTransparentPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);

		int BltTranslucent(HDC hdcTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
		int BltTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
		int BltTranslucent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);

		int ShiftLeft(int nPixels);
		int ShiftRight(int nPixels);
		int ShiftUp(int nPixels);
		int ShiftDown(int nPixels);

		LPDIRECTDRAWSURFACE7 GetDXSurface() { return m_lpddsSurface; }

		long GetRGBColor(long crColor);
		long GetSurfaceColor(long dxColor);

	private:
		COLORREF ConvertDDColor(DWORD dwColor, DDPIXELFORMAT* pddpf);
		DWORD ConvertColorRef(COLORREF crColor, DDPIXELFORMAT* pddpf);
		WORD GetNumberOfBits( DWORD dwMask );
		WORD GetMaskPos( DWORD dwMask );
		void SetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y, long rgb);
		long GetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y);

		void SetPixelsDX( long* p_crPixelArray, int x, int y, int width, int height );
		void SetPixelsGDI( long* p_crPixelArray, int x, int y, int width, int height );

	private:
		HDC m_hdcMem;		//memory dc
		HBITMAP m_hbmNew;		//new bitmap
		HBITMAP m_hbmOld;		//old bitmap
		//width and height
		int m_nWidth;
		int m_nHeight;

		HDC m_hdcLocked;	//locked hdc (if null, then surface is not locked)

		//For DirectX surfaces only:
		bool		m_bUseDX;		//using directx?
		LPDIRECTDRAWSURFACE7 m_lpddsSurface;		//direct draw back buffer
};

#endif // !defined(AFX_GDICANVAS_H__F5EB4F68_2CBC_11D4_A1EE_8F7A3049432E__INCLUDED_)
