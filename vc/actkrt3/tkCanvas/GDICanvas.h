//////////////////////////////////////////////////////////////////////////
//All contents copyright 2003, 2004, Christopher Matthews or Contributors
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// GDICanvas.h: interface for the CGDICanvas class.
// Portions based on Isometric Game Programming With DirtectX 7.0 (Pazera)
//////////////////////////////////////////////////////////////////////////

#if !defined(AFX_GDICANVAS_H__F5EB4F68_2CBC_11D4_A1EE_8F7A3049432E__INCLUDED_)
#define AFX_GDICANVAS_H__F5EB4F68_2CBC_11D4_A1EE_8F7A3049432E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include <windows.h>

///for DirectX...
#include "..\tkDirectX\platform.h"

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
		inline CGDICanvas();
		inline CGDICanvas(const CGDICanvas& rhs);
		inline ~CGDICanvas();
		CGDICanvas& operator=(const CGDICanvas& rhs);

		//methods...
		//void Load(HDC hdcCompatible,LPCTSTR lpszFilename);	//loads bitmap from a file
		inline void CreateBlank(HDC hdcCompatible, int width, int height, bool bDX = false);	//creates a blank bitmap
		inline void Destroy();  //destroys bitmap and dc
		void SetPixel(int x, int y, int crColor);
		inline int GetPixel(int x, int y);
		inline int GetWidth();
		inline int GetHeight();
		inline HDC OpenDC();
		inline void CloseDC(HDC hdc);
		inline void Lock();
		inline void Unlock();
		void SetPixels( long* p_crPixelArray, int x, int y, int width, int height );

		inline void Resize(HDC hdcCompatible, int width, int height);

		inline bool usingDX() { return m_bUseDX; }

		inline int Blt(HDC hdcTarget, int x, int y, long lRasterOp = SRCCOPY);
		inline int Blt(CGDICanvas* pCanvas, int x, int y, long lRasterOp = SRCCOPY);
		inline int Blt(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long lRasterOp = SRCCOPY);

		inline int BltPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);
		inline int BltPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);
		inline int BltPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long lRasterOp = SRCCOPY);

		inline int BltTransparent(HDC hdcTarget, int x, int y, long crTransparentColor);
		inline int BltTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor);
		inline int BltTransparent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, long crTransparentColor);

		inline int BltTransparentPart(HDC hdcTarget, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);
		inline int BltTransparentPart(CGDICanvas* pCanvas, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);
		inline int BltTransparentPart(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, int xSrc, int ySrc, int width, int height, long crTransparentColor);

		inline int BltTranslucent(HDC hdcTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
		inline int BltTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
		inline int BltTranslucent(LPDIRECTDRAWSURFACE7 lpddsSurface, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);

		inline int ShiftLeft(int nPixels);
		inline int ShiftRight(int nPixels);
		inline int ShiftUp(int nPixels);
		inline int ShiftDown(int nPixels);

		inline LPDIRECTDRAWSURFACE7 GetDXSurface() { return m_lpddsSurface; }

		inline long GetRGBColor(long crColor);
		inline long GetSurfaceColor(long dxColor);

	private:
		inline COLORREF ConvertDDColor(DWORD dwColor, DDPIXELFORMAT* pddpf);
		inline DWORD ConvertColorRef(COLORREF crColor, DDPIXELFORMAT* pddpf);
		inline WORD GetNumberOfBits( DWORD dwMask );
		inline WORD GetMaskPos( DWORD dwMask );
		inline void SetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y, long rgb);
		inline long GetRGBPixel(DDSURFACEDESC2* destSurface, DDPIXELFORMAT* pddpf, int x, int y);

		inline void SetPixelsDX( long* p_crPixelArray, int x, int y, int width, int height );
		inline void SetPixelsGDI( long* p_crPixelArray, int x, int y, int width, int height );

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
