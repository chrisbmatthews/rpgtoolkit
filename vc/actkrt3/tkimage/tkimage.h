//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

////////////////////////////////////////////////////////
// Inclusions
////////////////////////////////////////////////////////
#include "stdafx.h"

////////////////////////////////////////////////////////
// FreeImage exports
////////////////////////////////////////////////////////
int APIENTRY IMGInit();
int APIENTRY IMGClose(char* pstrCode);
int APIENTRY IMGDraw(char* pstrFilename, int x, int y, int hdc);
int APIENTRY IMGDrawSized(char* pstrFilename, int x, int y, int sizex, int sizey, int hdc);
FIBITMAP* APIENTRY IMGLoad(char* pstrFilename);
int APIENTRY IMGFree(FIBITMAP* nFreeImagePtr);
int APIENTRY IMGGetWidth(FIBITMAP* nFreeImagePtr);
int APIENTRY IMGGetHeight(FIBITMAP* nFreeImagePtr);
int APIENTRY IMGGetDIB(FIBITMAP* nFreeImagePtr);
int APIENTRY IMGGetBitmapInfo(FIBITMAP* nFreeImagePtr);
int APIENTRY IMGBlt(FIBITMAP* nFreeImagePtr, int x, int y, int hdc);
int APIENTRY IMGStretchBlt(FIBITMAP* nFreeImagePtr, int x, int y, int sizex, int sizey, int hdc);