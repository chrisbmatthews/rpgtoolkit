/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include "stdafx.h"

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