//----------------------------------------------------------------
// All contents copyright 2003, 2004, CBM or developers
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE
// Read LICENSE.txt for licensing info
//----------------------------------------------------------------

//----------------------------------------------------------------
// FreeImage interface
//----------------------------------------------------------------

//----------------------------------------------------------------
// Inclusions
//----------------------------------------------------------------
#include "stdafx.h"
#include <stdlib.h>
#include <string.h>
#include "freeimage.h"
#include "tkimage.h"
#include "..\tkCanvas\GDICanvas.h"
#include "..\tkgfx\CUtil.h"

//----------------------------------------------------------------
// Initiate FreeImage
//----------------------------------------------------------------
INT APIENTRY IMGInit(VOID)
{
	FreeImage_Initialise();
	return 1;
}

//----------------------------------------------------------------
// Kill FreeImage
//----------------------------------------------------------------
INT APIENTRY IMGClose(VOID)
{
	FreeImage_DeInitialise();
	return 1;
}

//----------------------------------------------------------------
// Save the contents of a canvas to a *.ico file
//----------------------------------------------------------------
VOID APIENTRY IMGCreateIcon(CGDICanvas *CONST cnv, LPCSTR strFileName)
{

	// Create a new bitmap
	DDPIXELFORMAT ddpf;
	DD_INIT_STRUCT(ddpf);
	cnv->GetDXSurface()->GetPixelFormat(&ddpf);
	FIBITMAP *bmp = FreeImage_Allocate(32, 32, ddpf.dwRGBBitCount);

	// Lock the canvas
	cnv->Lock();

	// The x axis
	for (INT i = 0; i < 32; i++)
	{

		// The y axis
		for (INT j = 0, y = 31; j < 32; j++, y--)
		{

			// Obtain rgb at this location
			CONST INT rgb = cnv->GetPixel(i, j);
			RGBQUAD rgbq;
			rgbq.rgbBlue = util::blue(rgb);
			rgbq.rgbGreen = util::green(rgb);
			rgbq.rgbRed = util::red(rgb);

			// Set onto destination bitmap
			FreeImage_SetPixelColor(bmp, i, y, &rgbq);

		}

	}

	// Unlock the canvas
	cnv->Unlock();

	// Save to destination file
	FreeImage_Save(FIF_ICO, bmp, strFileName);

	// Clean up
	FreeImage_Unload(bmp);

}

//----------------------------------------------------------------
// Draw an image onto a device context
//----------------------------------------------------------------
INT APIENTRY IMGDraw(LPSTR pstrFilename, INT x, INT y, INT hdc)
{
	FIBITMAP *bmp = (FIBITMAP *)IMGLoad(pstrFilename);

	if (bmp)
	{
		SetDIBitsToDevice((HDC)hdc, x, y, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), 0, 0, 0,
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS); 

		FreeImage_Unload(bmp);
		return 1;
	}
	return 0;
}


//----------------------------------------------------------------
// Draw an image (resized) onto a device context
//----------------------------------------------------------------
INT APIENTRY IMGDrawSized(LPSTR pstrFilename, INT x, INT y, INT sizex, INT sizey, INT hdc)
{
	FIBITMAP *bmp = (FIBITMAP *)IMGLoad(pstrFilename);

	if (bmp)
	{
		StretchDIBits((HDC)hdc, x, y, sizex, sizey, 
			0, 0, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY); 

		FreeImage_Unload(bmp);	
		return 1;
	}
	return 0;
}

//----------------------------------------------------------------
// Load an image
//----------------------------------------------------------------
FIBITMAP *APIENTRY IMGLoad(LPSTR pstrFilename)
{

	// FreeImage version 3 has merged image loading procedures
	return FreeImage_Load(FreeImage_GetFileType(pstrFilename, 16), pstrFilename);

}

//----------------------------------------------------------------
// Kill a loaded image
//----------------------------------------------------------------
INT APIENTRY IMGFree(FIBITMAP *nFreeImagePtr)
{
	FreeImage_Unload((FIBITMAP *)nFreeImagePtr);
	return 1;
}

//----------------------------------------------------------------
// Get width of an image
//----------------------------------------------------------------
INT APIENTRY IMGGetWidth(FIBITMAP *nFreeImagePtr)
{
	return FreeImage_GetWidth((FIBITMAP*)nFreeImagePtr);
}

//----------------------------------------------------------------
// Get height of an image
//----------------------------------------------------------------
INT APIENTRY IMGGetHeight(FIBITMAP *nFreeImagePtr)
{
	return FreeImage_GetHeight((FIBITMAP *)nFreeImagePtr);
}

//----------------------------------------------------------------
// Get a DIB pointer
//----------------------------------------------------------------
INT APIENTRY IMGGetDIB(FIBITMAP *nFreeImagePtr)
{
	return INT(FreeImage_GetBits((FIBITMAP *)nFreeImagePtr));
}

//----------------------------------------------------------------
// Get info on a loaded image
//----------------------------------------------------------------
INT APIENTRY IMGGetBitmapInfo(FIBITMAP *nFreeImagePtr)
{
	return INT(FreeImage_GetInfo((FIBITMAP *)nFreeImagePtr));
}

//----------------------------------------------------------------
// Draw an image onto a device context
//----------------------------------------------------------------
INT APIENTRY IMGBlt(FIBITMAP *nFreeImagePtr, INT x, INT y, INT hdc)
{
	FIBITMAP *bmp = (FIBITMAP *)nFreeImagePtr;
	if (bmp)
	{
		SetDIBitsToDevice((HDC)hdc, x, y, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), 0, 0, 0,
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS); 
	}

	return 1;
}

//----------------------------------------------------------------
// Draw an image (resized) onto a device context
//----------------------------------------------------------------
INT APIENTRY IMGStretchBlt(FIBITMAP *nFreeImagePtr, INT x, INT y, INT sizex, INT sizey, INT hdc)
{
	FIBITMAP *bmp = (FIBITMAP *)nFreeImagePtr;
	if (bmp)
	{
		StretchDIBits((HDC)hdc, x, y, sizex, sizey, 
			0, 0, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY); 
	}

	return 1;
}
