//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////////////////////
// CTile.h
// Definition for an rpgtoolkit tile
// Developed for v2.19b (Dec 2001 - Jan 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////////////////////

//===============================================
// Alterations by Delano for 3.0.4
// New isometric tile system.
//
// Added createIsometricMask prototype.
// Altered prototypes for:
//		createShading - new parameter.
//		openTile - now returns.
//===============================================

#ifndef _CTILE_H_
#define _CTILE_H_

//comment out if you want each tile to have its
//own canvas (bad for the GDI resources!!!
#define CTILE_COMMONCANVAS

#define TILE_CACHE_SIZE 256


#include <string>
#include <vector>
#include "CTileCanvas.h"
#include "../tkCanvas/CCanvasPool.h"

typedef struct tilesetHeaderTag {		//6 bytes
	WORD version;  						//20=2.0, 21=2.1, etc
	WORD tilesInSet;					//number of tiles in set
	WORD detail;						//detail level in set MUST BE UNIFORM!
} tilesetHeader;

class CTile
{
	public:
		CTile(int nCompatibleDC, bool bIsometric = false);
		CTile(int nCompatibleDC, std::string strFilename, RGBSHADE rgb, int nShadeType, bool bIsometric = false);
		//big 3...
		~CTile();
		CTile(const CTile& rhs);
		CTile& operator=(const CTile& rhs);

		//other operations...
		int operator<(const CTile& rhs);

		//methods...
		void open(std::string strFilename, RGBSHADE rgb, int nShadeType);
		void gdiDraw(int hdc, int x, int y);
		void gdiDrawFG(int hdc, int x, int y);

		void cnvDraw(CGDICanvas* pCanvas, int x, int y);

		void gdiDrawAlpha(int hdc, int x, int y);
		void gdiRenderAlpha(int hdc, int x, int y);

		void cnvDrawAlpha(CGDICanvas* pCanvas, int x, int y);
		void cnvRenderAlpha(CGDICanvas* pCanvas, int x, int y);


		void prepAlpha();

		//Altered for 3.0.4 by Delano - new nSetType
		void createShading(int hdc, RGBSHADE rgb, int nShadeType, int nSetType);

		bool isShadedAs(RGBSHADE rgb, int nShadeType);
		
		//accessor methods...
		bool HasTransparency() { return m_bIsTransparent; }
		std::string getFilename() { return m_strFilename; }
		bool isIsometric() { return m_bIsometric; }

		static unsigned int getDOSColor(unsigned char cColor);
		static void KillPools();


	private:

		//Added/altered for 3.0.4 by Delano.
		void createIsometricMask();
		int openTile(std::string strFilename);

		int openFromTileSet ( std::string strFilename, int number );
		tilesetHeader getTilesetInfo(std::string strFilename) ;
		long calcInsertionPoint ( int d, int number );
		void increaseDetail();
		//CTileCanvas* GetShadedCanvas(int hdc, std::vector<RGBSHADE> vShadeList, int nShadeType);

	private:
		//Regular information...
		std::string m_strFilename;			//the filename of the tile (if in a tileset, the number of the tileset tile is appended at the end)
		bool m_bIsTransparent;					//does it have transparent parts?  This is maintained for convenience.

		//The tile in memory...
		int m_pnTile[32][32];						//tile scaled tile, in memory
		int m_pnAlphaChannel[32][32];		//tiel tile's alpha channel (255 = opaque part, 0 = tarnsparent part)
		int m_nDetail;									//detail level for the tile

		//std::vector<RGBSHADE> m_vShadeList;
		RGBSHADE m_rgb;	//shading
		int m_nShadeType;

		bool m_bIsometric;					//is the tile isometric (44x22)

		//GDI Stuff:
		int m_nCompatibleDC;						//the compatible hdc that we use to create ofscreen DCs
		
		static CCanvasPool* m_pCnvForeground;	//canvas pool
		static CCanvasPool* m_pCnvAlphaMask;	//canvas pool
		static CCanvasPool* m_pCnvMaskMask;	//canvas pool

		static CCanvasPool* m_pCnvForegroundIso;	//canvas pool
		static CCanvasPool* m_pCnvAlphaMaskIso;	//canvas pool
		static CCanvasPool* m_pCnvMaskMaskIso;	//canvas pool

		//pool indicies of each canvas...
		int m_nFgIdx, m_nAlphaIdx, m_nMaskIdx;
		int m_nFgIdxIso, m_nAlphaIdxIso, m_nMaskIdxIso;

		//Offscreen DCs to actually hold the tile.
		//CGDICanvas* m_pcnvForeground;		//the drawn tile, foreground
		//CGDICanvas* m_pcnvAlphaMask;		//the drawn tile, trnasparency mask
		//CGDICanvas* m_pcnvMaskMask;			//mask for the mask!
};

#endif