//--------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Handle based interface to CGDICanvas
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Protect the header
//--------------------------------------------------------------------------
#ifndef _TK_CANVAS_H_
#define _TK_CANVAS_H_
#pragma once

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#define WIN32_MEAN_AND_LEAN		// Obtain lean version of windows
#include <windows.h>			// Windows headers

//--------------------------------------------------------------------------
// Types
//--------------------------------------------------------------------------
#if !defined(CNV_HANDLE)
typedef INT CNV_HANDLE;			// Handle to a canvas
#endif
#if !defined(DOUBLE)
typedef double DOUBLE;
#endif

//--------------------------------------------------------------------------
// Prototypes
//--------------------------------------------------------------------------

// Create the canvas host
INT APIENTRY CNVCreateCanvasHost(
	CONST INT hInstance	
);

// Kill the canvas host
VOID APIENTRY CNVKillCanvasHost(
	CONST INT hInstance,
	CONST INT hCanvasHostDC
);

// Initialize the canvas engine
BOOL APIENTRY CNVInit(
	VOID
);

// Shutdown the canavs engine
BOOL APIENTRY CNVShutdown(
	VOID
);

// Create a canvas
CNV_HANDLE APIENTRY CNVCreate(
	CONST INT hdcCompatable,
	CONST INT nWidth,
	CONST INT nHeight, 
	CONST INT nUseDX = 1
);

// Destroy a canvas
BOOL APIENTRY CNVDestroy(
	CONST CNV_HANDLE cnv
);

// Obtain a canvas' HDC
INT APIENTRY CNVOpenHDC(
	CONST CNV_HANDLE cnv
);

// Close a canvas' HDC
BOOL APIENTRY CNVCloseHDC(
	CONST CNV_HANDLE cnv,
	CONST INT hdc
);

// Lock a canvas
BOOL APIENTRY CNVLock(
	CONST CNV_HANDLE cnv
);

// Unlock a canvas
BOOL APIENTRY CNVUnlock(
	CONST CNV_HANDLE cnv
);

// Get the width of a canvas
INT APIENTRY CNVGetWidth(
	CONST CNV_HANDLE cnv
);

// Get the height of a canvas
INT APIENTRY CNVGetHeight(
	CONST CNV_HANDLE cnv
);

// Get a pixel on a canvas
INT APIENTRY CNVGetPixel(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y
);

// Set a pixel on a canvas
BOOL APIENTRY CNVSetPixel(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT crColor
);

// Determine if a handle is valid
BOOL APIENTRY CNVExists(
	CONST CNV_HANDLE cnv
);

// Blt between canvases
BOOL APIENTRY CNVBltCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT lRasterOp = SRCCOPY
);

// Blt transparently between canvases
BOOL APIENTRY CNVBltCanvasTransparent(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT crColor
);

// Blt translucently between canvases
BOOL APIENTRY CNVBltCanvasTranslucent(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
);

// Partially blt translucently between canvases
BOOL APIENTRY CNVBltCanvasTranslucentPart(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
);

// Get a RGB color in a canvas' pixel format
INT APIENTRY CNVGetRGBColor(
	CONST CNV_HANDLE cnv,
	CONST INT crColor
);

// Resize a canvas
BOOL APIENTRY CNVResize(
	CONST CNV_HANDLE cnv,
	CONST INT hdcCompatible,
	CONST INT nWidth,
	CONST INT nHeight
);

// Shift a canvas left
BOOL APIENTRY CNVShiftLeft(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
);

// Shift a canvas right
BOOL APIENTRY CNVShiftRight(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
);

// Shift a canvas up
BOOL APIENTRY CNVShiftUp(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
);

// Shift a canvas down
BOOL APIENTRY CNVShiftDown(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
);

// Blt part of a canvas to another canvas
BOOL APIENTRY CNVBltPartCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST INT lRasterOp = SRCCOPY
);

// Transparently blt part of a canvas to another canvas
BOOL APIENTRY CNVBltTransparentPartCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST INT crTransparentColor
);

// Blt a canvas stretched
INT APIENTRY CNVBltStretchCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST INT newWidth,
	CONST INT newHeight,
	CONST LONG lRasterOp
);

//--------------------------------------------------------------------------
// End of the header
//--------------------------------------------------------------------------
#endif
