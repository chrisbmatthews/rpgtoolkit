//--------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Handle based interface to CGDICanvas
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#include "tkCanvas.h"						// Stuff for this file
#include "GDICanvas.h"						// The CGDICanvas class
#include <list>								// Standard list class

//--------------------------------------------------------------------------
// Locals
//--------------------------------------------------------------------------
static HWND m_hHostWnd = NULL;				// Handle to the canvas host
static std::list<CGDICanvas *> m_canvases;	// All canvases

//--------------------------------------------------------------------------
// Create the canvas host
//--------------------------------------------------------------------------
INT APIENTRY CNVCreateCanvasHost(
	CONST INT hInstance	
		)
{

    // Create a windows class
    CONST WNDCLASSEX wnd = {
		sizeof(wnd),
		CS_OWNDC,
		DefWindowProc,
		NULL,
		NULL,
		HINSTANCE(hInstance),
		NULL,
		NULL,
		HBRUSH(GetStockObject(BLACK_BRUSH)),
		NULL,
		"canvasHost",
		NULL
	};

    // Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

	// Create the window
	m_hHostWnd = CreateWindowEx(
		NULL,
		"canvasHost",
		NULL, NULL,
		NULL, NULL,
		NULL, NULL,
		NULL, NULL,
		HINSTANCE(hInstance),
		NULL
	);

	// Return its hdc
	return INT(GetDC(m_hHostWnd));

}

//--------------------------------------------------------------------------
// Kill the canvas host
//--------------------------------------------------------------------------
VOID APIENTRY CNVKillCanvasHost(
	CONST INT hInstance,
	CONST INT hCanvasHostDC
		)
{

	// Release the window's DC
	ReleaseDC(m_hHostWnd, HDC(hCanvasHostDC));

	// Destroy the window
	DestroyWindow(m_hHostWnd);

	// Unregister the windows class
	UnregisterClass("canvasHost", HINSTANCE(hInstance));

}

//--------------------------------------------------------------------------
// Initialize the canvas engine
//--------------------------------------------------------------------------
BOOL APIENTRY CNVInit(
	VOID
		)
{

	// Clear the list of canvases
	m_canvases.clear();

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Shutdown the canavs engine
//--------------------------------------------------------------------------
BOOL APIENTRY CNVShutdown(
	VOID
		)
{

	// Create an iterator
	std::list<CGDICanvas *>::iterator itr = m_canvases.begin();

	// Iterate over the canvas list
	for (; itr != m_canvases.end(); itr++)
	{
		// Delete this canvas
		delete *itr;
	}

	// Clear the canvas list
	m_canvases.clear();

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Create a canvas
//--------------------------------------------------------------------------
CNV_HANDLE APIENTRY CNVCreate(
	CONST INT hdcCompatable,
	CONST INT nWidth,
	CONST INT nHeight, 
	CONST INT nUseDX
		)
{

	// Allocate a new canvas
	CGDICanvas *cnv = new CGDICanvas();

	// Create the canvas
	cnv->CreateBlank(HDC(hdcCompatable), nWidth, nHeight, nUseDX);

	// Push the canvas onto the list
	m_canvases.push_back(cnv);

	// Return the canvas' address
	return reinterpret_cast<CNV_HANDLE>(cnv);

}

//--------------------------------------------------------------------------
// Destroy a canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVDestroy(
	CONST CNV_HANDLE cnv
		)
{

	// Cast to a CGDICanvas pointer
	CGDICanvas *const pCnv = reinterpret_cast<CGDICanvas *>(cnv);

	// Remove the canvas from the list
	m_canvases.remove(pCnv);

	// Delete the canvas
	delete pCnv;

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Obtain a canvas' HDC
//--------------------------------------------------------------------------
INT APIENTRY CNVOpenHDC(
	CONST CNV_HANDLE cnv
		)
{

	// Return the canvas' HDC
	return INT(reinterpret_cast<CGDICanvas *>(cnv)->OpenDC());

}

//--------------------------------------------------------------------------
// Close a canvas' HDC
//--------------------------------------------------------------------------
BOOL APIENTRY CNVCloseHDC(
	CONST CNV_HANDLE cnv,
	CONST INT hdc
		)
{

	// Close the canvas' HDC
	reinterpret_cast<CGDICanvas *>(cnv)->CloseDC(HDC(hdc));

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Lock a canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVLock(
	CONST CNV_HANDLE cnv
		)
{

	// Lock the canvas
	reinterpret_cast<CGDICanvas *>(cnv)->Lock();

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Unlock a canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVUnlock(
	CONST CNV_HANDLE cnv
		)
{

	// Unlock the canvas
	reinterpret_cast<CGDICanvas *>(cnv)->Unlock();

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Get the width of a canvas
//--------------------------------------------------------------------------
INT APIENTRY CNVGetWidth(
	CONST CNV_HANDLE cnv
		)
{

	// Return the canvas' width
	return reinterpret_cast<CGDICanvas *>(cnv)->GetWidth();

}

//--------------------------------------------------------------------------
// Get the height of a canvas
//--------------------------------------------------------------------------
INT APIENTRY CNVGetHeight(
	CONST CNV_HANDLE cnv
		)
{

	// Return the canvas' height
	return reinterpret_cast<CGDICanvas *>(cnv)->GetHeight();

}

//--------------------------------------------------------------------------
// Get a pixel on a canvas
//--------------------------------------------------------------------------
INT APIENTRY CNVGetPixel(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y
		)
{

	// Return the pixel in question
	return reinterpret_cast<CGDICanvas *>(cnv)->GetPixel(x, y);

}

//--------------------------------------------------------------------------
// Set a pixel on a canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVSetPixel(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT crColor
		)
{

	// Set a pixel on the canvas
	reinterpret_cast<CGDICanvas *>(cnv)->SetPixel(x, y, crColor);

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Determine if a handle is valid
//--------------------------------------------------------------------------
BOOL APIENTRY CNVExists(
	CONST CNV_HANDLE cnv
		)
{

	// Create an iterator
	std::list<CGDICanvas *>::iterator itr = m_canvases.begin();

	// Obtain a pointer to the canvas
	const CGDICanvas *pCnv = reinterpret_cast<CGDICanvas *>(cnv);

	// Iterate over the canvas list
	for (; itr != m_canvases.end(); itr++)
	{
		// Check if this is the canvas in question
		if (*itr == pCnv)
		{
			// It exists
			return TRUE;
		}
	}

	// It doesn't exist
	return FALSE;

}

//--------------------------------------------------------------------------
// Blt between canvases
//--------------------------------------------------------------------------
BOOL APIENTRY CNVBltCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT lRasterOp
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->Blt(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		lRasterOp
	);

}

//--------------------------------------------------------------------------
// Blt transparently between canvases
//--------------------------------------------------------------------------
BOOL APIENTRY CNVBltCanvasTransparent(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT crColor
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->BltTransparent(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		crColor
			);

}

//--------------------------------------------------------------------------
// Partially blt translucently between canvases
//--------------------------------------------------------------------------
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
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->BltTranslucentPart(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		xSrc,
		ySrc,
		width,
		height,
		dIntensity,
		crUnaffectedColor,
		crTransparentColor
	);

}

//--------------------------------------------------------------------------
// Blt translucently between canvases
//--------------------------------------------------------------------------
BOOL APIENTRY CNVBltCanvasTranslucent(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->BltTranslucent(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		dIntensity,
		crUnaffectedColor,
		crTransparentColor
	);

}

//--------------------------------------------------------------------------
// Get a RGB color in a canvas' pixel format
//--------------------------------------------------------------------------
INT APIENTRY CNVGetRGBColor(
	CONST CNV_HANDLE cnv,
	CONST INT crColor
		)
{

	// Return the color
	return reinterpret_cast<CGDICanvas *>(cnv)->GetRGBColor(crColor);

}

//--------------------------------------------------------------------------
// Resize a canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVResize(
	CONST CNV_HANDLE cnv,
	CONST INT hdcCompatible,
	CONST INT nWidth,
	CONST INT nHeight
		)
{

	// Resize the canvas
	reinterpret_cast<CGDICanvas *>(cnv)->Resize(HDC(hdcCompatible), nWidth, nHeight);

	// All's good
	return TRUE;

}

//--------------------------------------------------------------------------
// Shift a canvas left
//--------------------------------------------------------------------------
BOOL APIENTRY CNVShiftLeft(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
		)
{

	// Execute the shift
	return reinterpret_cast<CGDICanvas *>(cnv)->ShiftLeft(nPixels);

}

//--------------------------------------------------------------------------
// Shift a canvas right
//--------------------------------------------------------------------------
BOOL APIENTRY CNVShiftRight(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
		)
{

	// Execute the shift
	return reinterpret_cast<CGDICanvas *>(cnv)->ShiftRight(nPixels);

}

//--------------------------------------------------------------------------
// Shift a canvas up
//--------------------------------------------------------------------------
BOOL APIENTRY CNVShiftUp(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
		)
{

	// Execute the shift
	return reinterpret_cast<CGDICanvas *>(cnv)->ShiftUp(nPixels);

}

//--------------------------------------------------------------------------
// Shift a canvas down
//--------------------------------------------------------------------------
BOOL APIENTRY CNVShiftDown(
	CONST CNV_HANDLE cnv,
	CONST INT nPixels
		)
{

	// Execute the shift
	return reinterpret_cast<CGDICanvas *>(cnv)->ShiftDown(nPixels);

}

//--------------------------------------------------------------------------
// Blt part of a canvas to another canvas
//--------------------------------------------------------------------------
BOOL APIENTRY CNVBltPartCanvas(
	CONST CNV_HANDLE cnvSource,
	CONST CNV_HANDLE cnvTarget,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT nWidth,
	CONST INT nHeight,
	CONST INT lRasterOp
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->BltPart(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		xSrc,
		ySrc,
		nWidth,
		nHeight,
		lRasterOp
			);

}

//--------------------------------------------------------------------------
// Transparently blt part of a canvas to another canvas
//--------------------------------------------------------------------------
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
		)
{

	// Execute the blt
	return reinterpret_cast<CGDICanvas *>(cnvSource)->BltTransparentPart(
		reinterpret_cast<CGDICanvas *>(cnvTarget),
		x,
		y,
		xSrc,
		ySrc,
		nWidth,
		nHeight,
		crTransparentColor
			);

}
