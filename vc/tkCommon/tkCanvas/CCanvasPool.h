//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

//////////////////////
// CCanvasPool.h
// Definition of canvas pool object
// Christopher Matthews, Nov 2003


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
