//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info


#include "tkCanvas.h"


//init canvas system
int APIENTRY CNVInit()
{
	g_canvasList.clear();
	return 1;
}

//kill canvas system
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



//Create a canvas
//width and height are width and height to make it
//returns a canvas handle
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


//destroy a canvas
int APIENTRY CNVDestroy(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	g_canvasList.remove(p);
	delete p;
	return 1;
}


long APIENTRY CNVOpenHDC(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return (long)p->OpenDC();
}

long APIENTRY CNVCloseHDC(CNV_HANDLE cnv, long hdc)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->CloseDC((HDC)hdc);
	return 1;
}

int APIENTRY CNVLock(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Lock();
	return 1;
}

int APIENTRY CNVUnlock(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Unlock();
	return 1;
}


int APIENTRY CNVGetWidth(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetWidth();
}


int APIENTRY CNVGetHeight(CNV_HANDLE cnv)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetHeight();
}

long APIENTRY CNVGetPixel(CNV_HANDLE cnv, int x, int y)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetPixel(x, y);
}

int APIENTRY CNVSetPixel(CNV_HANDLE cnv, int x, int y, long crColor)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	HDC hdc = p->OpenDC();
	int nToRet = SetPixelV(hdc, x, y, crColor);
	p->CloseDC(hdc);
	return nToRet;
}


//check if a canvas exists
//return 0 if flase, or 1 if true
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

//Blt one canvas onto another
int APIENTRY CNVBltCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long lRasterOp)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->Blt(targ, x, y, lRasterOp);
	return nToRet;
}

//Blt one canvas onto another using transparency
int APIENTRY CNVBltCanvasTransparent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, long crColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTransparent(targ, x, y, crColor);
	return nToRet;
}

//Blt one canvas onto another using translucency
int APIENTRY CNVBltCanvasTranslucent(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTranslucent(targ, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	return nToRet;
}

//get rgb color based upon current color mode
long APIENTRY CNVGetRGBColor(CNV_HANDLE cnv, long crColor)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->GetRGBColor(crColor);
}


//resize existing canvas...
int APIENTRY CNVResize(CNV_HANDLE cnv, long hdcCompatible, int nWidth, int nHeight)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	p->Resize((HDC)hdcCompatible, nWidth, nHeight);
	return 1;
}


//shifting functions...
int APIENTRY CNVShiftLeft(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftLeft(nPixels);
}

//shifting functions...
int APIENTRY CNVShiftRight(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftRight(nPixels);
}

//shifting functions...
int APIENTRY CNVShiftUp(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftUp(nPixels);
}

//shifting functions...
int APIENTRY CNVShiftDown(CNV_HANDLE cnv, long nPixels)
{
	CGDICanvas* p = (CGDICanvas*)cnv;
	return p->ShiftDown(nPixels);
}

//partial blt functions...
int APIENTRY CNVBltPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long lRasterOp)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltPart(targ, x, y, xSrc, ySrc, nWidth, nHeight, lRasterOp);
	return nToRet;
}


int APIENTRY CNVBltTransparentPartCanvas(CNV_HANDLE cnvSource, CNV_HANDLE cnvTarget, int x, int y, int xSrc, int ySrc, int nWidth, int nHeight, long crTransparentColor)
{
	CGDICanvas* src = (CGDICanvas*)cnvSource;
	CGDICanvas* targ = (CGDICanvas*)cnvTarget;
	int nToRet = src->BltTransparentPart(targ, x, y, xSrc, ySrc, nWidth, nHeight, crTransparentColor);
	return nToRet;
}
