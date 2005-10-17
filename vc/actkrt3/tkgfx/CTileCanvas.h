//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////
// CTileCanvas.h
// Definition for an offscreen buffer for an rpgtoolkit tile
// Developed for v2.19b (Dec 2001 - Feb 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////

#ifndef _CTILECANVAS_H_
#define _CTILECANVAS_H_

#include <string>
#include <vector>
#include "..\tkCanvas\GDICanvas.h"


typedef struct tagColorShade
{
	int r;
	int g;
	int b;
} RGBSHADE;


//valid shade types...
#define SHADE_UNIFORM		0			//default version 2 (uniform) shading.


class CTileCanvas
{
	public:
		CTileCanvas(int nCompatibleDC, std::vector<RGBSHADE> vShadeList, int nShadeType);
		//big 3...
		~CTileCanvas();
		CTileCanvas(const CTileCanvas& rhs);
		CTileCanvas& operator=(const CTileCanvas& rhs);

		bool isShadedAs(int hdc, std::vector<RGBSHADE> vShadeList, int nShadeType);
		void SetPixel(int x, int y, int crColor) { 	m_cnvForeground.SetPixel(x, y, crColor); }
		int GetPixel(int x, int y) { return m_cnvForeground.GetPixel(x, y); }
		//HDC GetHDC() { return m_cnvForeground.GetHDC(); }
		bool isStillInMem();
		void reallocate(int hdc);

	private:

	private:
		int m_nShadeType;			//type of shading used (one of the constants defined above)
		std::vector<RGBSHADE> m_vShadeList;		//vector of rgb shadings used

		//GDI Stuff:
		int m_nCompatibleDC;						//the compatible hdc that we use to create ofscreen DCs
		//Offscreen DCs to actually hold the tile.
		CCanvas m_cnvForeground;		//the drawn tile, foreground
		//CCanvas* m_pcnvAlphaMask;		//the drawn tile, trnasparency mask
};

#endif