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
#include "../../tkCommon/images/freeimage.h"
#include "tkimage.h"
#include "../../tkCommon/tkGfx/CUtil.h"

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

//----------------------------------------------------------------
// Write a BITMAP to file
//----------------------------------------------------------------
INT APIENTRY IMGExport(CONST HBITMAP hbmp, CONST CHAR* filename)
{
	if(!hbmp) return 0;

	BITMAP bmp;
	GetObject(hbmp, sizeof(BITMAP), LPVOID(&bmp));

	FIBITMAP *dib = FreeImage_Allocate(bmp.bmWidth, bmp.bmHeight, bmp.bmBitsPixel);
	
	// The GetDIBits function clears the biClrUsed and biClrImportant 
	// BITMAPINFO members so we save these (for palettized images only). 
	INT nColors = FreeImage_GetColorsUsed(dib);

	HDC hdc = GetDC(NULL);
	GetDIBits(
		hdc, 
		hbmp, 
		0, 
		FreeImage_GetHeight(dib), 
		FreeImage_GetBits(dib), 
		FreeImage_GetInfo(dib), 
		DIB_RGB_COLORS
	);
	ReleaseDC(NULL, hdc);

	// Restore BITMAPINFO members.
	FreeImage_GetInfoHeader(dib)->biClrUsed = nColors;
	FreeImage_GetInfoHeader(dib)->biClrImportant = nColors;

	// Get image format (default to bmp).
	FREE_IMAGE_FORMAT fif = FIF_BMP;
	INT flags = BMP_DEFAULT;

	std::string ext = util::getExt(filename);
	if (stricmp(ext.c_str(), "jpg") == 0)
	{
		fif = FIF_JPEG;
		flags = JPEG_QUALITYGOOD;
	}
	else if (stricmp(ext.c_str(), "png") == 0)
	{
		fif = FIF_PNG;
		flags = PNG_DEFAULT;
	}
	
	// Attempt to convert to 24-bit.
	FIBITMAP *dib24bit = FreeImage_ConvertTo24Bits(dib);
	if (dib24bit)
	{
		FreeImage_Save(fif, dib24bit, filename, flags);
		FreeImage_Unload(dib24bit);
	}
	FreeImage_Unload(dib);

	return (dib24bit != 0);
}


