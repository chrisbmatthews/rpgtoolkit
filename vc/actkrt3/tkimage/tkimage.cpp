////////////////////////////////////////////////////////
//All contents copyright 2003, 2004, CBM or developers
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE
//Read LICENSE.txt for licensing info
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// FreeImage interface
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// EDITED [KSNiloc] :: September 4, 2004
//
// + Modified to use FreeImage version 3
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// Inclusions
////////////////////////////////////////////////////////
#include "stdafx.h"
#include <stdlib.h>
#include <string.h>
#include "freeimage.h"
#include "tkimage.h"

////////////////////////////////////////////////////////
// Initiate FreeImage
////////////////////////////////////////////////////////
int APIENTRY IMGInit()
{
	FreeImage_Initialise();
	return 1;
}

////////////////////////////////////////////////////////
// Kill FreeImage
////////////////////////////////////////////////////////
int APIENTRY IMGClose()
{
	FreeImage_DeInitialise();
	return 1;
}

////////////////////////////////////////////////////////
// Draw an image onto a device context
////////////////////////////////////////////////////////
int APIENTRY IMGDraw(char* pstrFilename, int x, int y, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)IMGLoad(pstrFilename);

	if(bmp)
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


////////////////////////////////////////////////////////
// Draw an image (resized) onto a device context
////////////////////////////////////////////////////////
int APIENTRY IMGDrawSized(char* pstrFilename, int x, int y, int sizex, int sizey, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)IMGLoad(pstrFilename);

	if(bmp)
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

////////////////////////////////////////////////////////
// Load an image
////////////////////////////////////////////////////////
FIBITMAP* APIENTRY IMGLoad(char* pstrFilename)
{

	//FreeImage version 3 has merged image loading procedures
	return FreeImage_Load(FreeImage_GetFileType(pstrFilename, 16), pstrFilename);

}

////////////////////////////////////////////////////////
// Kill a loaded image
////////////////////////////////////////////////////////
int APIENTRY IMGFree(FIBITMAP* nFreeImagePtr)
{
	FreeImage_Unload((FIBITMAP*)nFreeImagePtr);
	return 1;
}

////////////////////////////////////////////////////////
// Get width of an image
////////////////////////////////////////////////////////
int APIENTRY IMGGetWidth(FIBITMAP* nFreeImagePtr)
{
	return FreeImage_GetWidth((FIBITMAP*)nFreeImagePtr);
}

////////////////////////////////////////////////////////
// Get height of an image
////////////////////////////////////////////////////////
int APIENTRY IMGGetHeight(FIBITMAP* nFreeImagePtr)
{
	return FreeImage_GetHeight((FIBITMAP*)nFreeImagePtr);
}

////////////////////////////////////////////////////////
// Get a DIB pointer
////////////////////////////////////////////////////////
int APIENTRY IMGGetDIB(FIBITMAP* nFreeImagePtr)
{
	return (int)FreeImage_GetBits((FIBITMAP*)nFreeImagePtr);
}

////////////////////////////////////////////////////////
// Get info on a loaded image
////////////////////////////////////////////////////////
int APIENTRY IMGGetBitmapInfo(FIBITMAP* nFreeImagePtr)
{
	return (int)FreeImage_GetInfo((FIBITMAP*)nFreeImagePtr);
}

////////////////////////////////////////////////////////
// Draw an image onto a device context
////////////////////////////////////////////////////////
int APIENTRY IMGBlt(FIBITMAP* nFreeImagePtr, int x, int y, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)nFreeImagePtr;
	if(bmp)
	{
		SetDIBitsToDevice((HDC)hdc, x, y, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), 0, 0, 0,
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS); 
	}

	return 1;
}

////////////////////////////////////////////////////////
// Draw an image (resized) onto a device context
////////////////////////////////////////////////////////
int APIENTRY IMGStretchBlt(FIBITMAP* nFreeImagePtr, int x, int y, int sizex, int sizey, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)nFreeImagePtr;
	if(bmp)
	{
		StretchDIBits((HDC)hdc, x, y, sizex, sizey, 
			0, 0, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY); 
	}

	return 1;
}
