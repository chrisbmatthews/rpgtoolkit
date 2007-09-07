/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews
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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

#ifndef CCANVASPOOL_H
#define CCANVASPOOL_H

#include <windows.h>
#include <vector>
#include "GDICanvas.h"

#define POOLS_PER_CANVAS 32

class CCanvasPool
{
public:
	CCanvasPool( int nCompatibleDC, int nSizeX, int nSizeY, int nPoolSize );
	~CCanvasPool();

	int getFree();
	void release( int nIndex );

	void SetPixel( int nX, int nY, long crColor, int nIndex );
	void Blt( HDC hDest, int nDestX, int nDestY, int nIndex, long rasterOp = SRCCOPY );
	void Blt( CCanvas* pDest, int nDestX, int nDestY, int nIndex, long rasterOp = SRCCOPY );
	void BltTransparent( HDC hDest, int nDestX, int nDestY, int nIndex, long crTransparent );
	void BltTransparent( CCanvas* pDest, int nDestX, int nDestY, int nIndex, long crTransparent );
	void SetPixels( long* p_crPixelArray, int x, int y, int width, int height, int nIndex );

	void Lock( int nIndex );
	void Unlock( int nIndex );

	int getSizeX() { return m_nSizeX; }
	int getSizeY() { return m_nSizeY; }
	int getPoolSize() { return m_nPoolSize; }

private:
	int getX( int nX, int nIndex ) 
	{ 
		nIndex = nIndex % ( POOLS_PER_CANVAS );
		return nIndex * getSizeX() + nX; 
	}

	int getY( int nY, int nIndex ) { return nY; }
	CCanvas* getCanvas( int nIndex );

private:
	//the canvas that holds this pool object
	int m_nCompatibleDC;
	std::vector<CCanvas*> m_vCanvases;
	int m_nSizeX, m_nSizeY, m_nPoolSize;
	std::vector<bool> m_vOccupied;
};

#endif
