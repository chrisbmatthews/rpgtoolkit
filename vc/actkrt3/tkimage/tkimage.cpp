//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

// tkreg.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <stdlib.h>
#include <string.h>
#include <windows.h>

//#define FREEIMAGE_LIB
#include "freeimage.h"
#include "tkimage.h"

										

///////////////////////////////////
// DLL Entry point...
int APIENTRY IMGInit()
{
	FreeImage_Initialise();
	return 1;
}


///////////////////////////////////
// Shutdown freeimage system
int APIENTRY IMGClose()
{
	FreeImage_DeInitialise();
	return 1;
}


////////////////////////////////////
// Load and draw an image to the screen
int APIENTRY IMGDraw(char* pstrFilename, int x, int y, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)IMGLoad(pstrFilename);

	if(bmp)
	{
		SetDIBitsToDevice((HDC)hdc, x, y, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), 0, 0, 0,
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS); 

		FreeImage_Free(bmp);	
		return 1;
	}
	return 0;
}


////////////////////////////////////
// Load and draw an image to the screen
int APIENTRY IMGDrawSized(char* pstrFilename, int x, int y, int sizex, int sizey, int hdc)
{
	FIBITMAP* bmp = (FIBITMAP*)IMGLoad(pstrFilename);

	if(bmp)
	{
		StretchDIBits((HDC)hdc, x, y, sizex, sizey, 
			0, 0, FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY); 

		FreeImage_Free(bmp);	
		return 1;
	}
	return 0;
}


////////////////////////////////////////
// Load an image
// return 'pointer' to freeimage
// this pointer is returned as an int
FIBITMAP* APIENTRY IMGLoad(char* pstrFilename)
{
	FREE_IMAGE_FORMAT fmt = FreeImage_GetFileType(pstrFilename, 16); 
	FIBITMAP* bmp = NULL;

	switch(fmt)
	{
		case FIF_BMP:
			bmp = FreeImage_LoadBMP(pstrFilename);
			break;
		case FIF_ICO:
			bmp = FreeImage_LoadICO(pstrFilename);
			break;
		case FIF_JPEG:
			bmp = FreeImage_LoadJPEG(pstrFilename);
			break;
		case FIF_KOALA:
			bmp = FreeImage_LoadKOALA(pstrFilename);
			break;
		case FIF_LBM:
			bmp = FreeImage_LoadLBM(pstrFilename);
			break;
		case FIF_MNG:
			bmp = FreeImage_LoadMNG(pstrFilename);
			break;
		case FIF_PCD:
			bmp = FreeImage_LoadPCD(pstrFilename);
			break;
		case FIF_PCX:
			bmp = FreeImage_LoadPCX(pstrFilename);
			break;
		case FIF_PNG:
			bmp = FreeImage_LoadPNG(pstrFilename);
			break;
		case FIF_RAS:
			bmp = FreeImage_LoadRAS(pstrFilename);
			break;
		case FIF_TARGA:
			bmp = FreeImage_LoadTARGA(pstrFilename);
			break;
		case FIF_TIFF:
			bmp = FreeImage_LoadTIFF(pstrFilename);
			break;
		case FIF_WBMP:
			bmp = FreeImage_LoadWBMP(pstrFilename);
			break;
		case FIF_PBM:
		case FIF_PGM:
		case FIF_PPM:
		case FIF_JNG:
		case FIF_UNKNOWN:
			break;
	}

	return bmp;
}


////////////////////////////////////////
// Free an image
int APIENTRY IMGFree(FIBITMAP* nFreeImagePtr)
{
	FreeImage_Free((FIBITMAP*)nFreeImagePtr);
	return 1;
}

/////////////////////////////////////////
// Get image dimensions
int APIENTRY IMGGetWidth(FIBITMAP* nFreeImagePtr)
{
	return FreeImage_GetWidth((FIBITMAP*)nFreeImagePtr);
}

int APIENTRY IMGGetHeight(FIBITMAP* nFreeImagePtr)
{
	return FreeImage_GetHeight((FIBITMAP*)nFreeImagePtr);
}

/////////////////////////////////////////
// Get FreeImage DIB pointer
int APIENTRY IMGGetDIB(FIBITMAP* nFreeImagePtr)
{
	return (int)FreeImage_GetBits((FIBITMAP*)nFreeImagePtr);
}

//////////////////////////////////////////
// Get FreeImage BITMAPINFO pointer
int APIENTRY IMGGetBitmapInfo(FIBITMAP* nFreeImagePtr)
{
	return (int)FreeImage_GetInfo((FIBITMAP*)nFreeImagePtr);
}


////////////////////////////////////////////
// Blt freeimage to device
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


////////////////////////////////////////////
// StretchBlt freeimage to device
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
