//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

///////////////////////
// tkCanvas.h
// C++ canvasing system
// requires CGDICanvas

#ifndef TKCANVAS_H_
#define TKCANVAS_H_

#include <list>
#include "GDICanvas.h"


#define CNV_HANDLE long

std::list<CGDICanvas*> g_canvasList;

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

#endif