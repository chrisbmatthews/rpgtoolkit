//-------------------------------------------------------------------
// All contents copyright 2003, Christopher Matthews or Contributors
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// CTile - a tile
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Protect the header
//-------------------------------------------------------------------
#ifndef _CTILE_H_
#define _CTILE_H_
#pragma once

//-------------------------------------------------------------------
// Definitions
//-------------------------------------------------------------------
#define CTILE_COMMONCANVAS
#define TILE_CACHE_SIZE 256

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#include <string>
#include <vector>
#include "CTileCanvas.h"
#include "../tkCanvas/CCanvasPool.h"

//-------------------------------------------------------------------
// A tileset header
//-------------------------------------------------------------------
struct tilesetHeader
{
	WORD version;  		// 20=2.0, 21=2.1, etc
	WORD tilesInSet;	// number of tiles in set
	WORD detail;		// detail level in set MUST BE UNIFORM!
};

//-------------------------------------------------------------------
// CTile - a tile
//-------------------------------------------------------------------
class CTile
{

	// Public visibility
	public:

		// CONSTruct with little information
		CTile(INT nCompatibleDC, BOOL bIsometric = FALSE);

		// CONSTruct with full set of information
		CTile(INT nCompatibleDC, std::string strFilename, RGBSHADE rgb, INT nShadeType, BOOL bIsometric = FALSE);

		// DeCONSTruct
		~CTile();

		// Copy CONSTructor
		CTile(CONST CTile &rhs);

		// Assignment operator
		CTile& operator = (CONST CTile &rhs);

		// Open a tile
		VOID open(std::string strFilename, RGBSHADE rgb, INT nShadeType);

		// Draw the tile
		VOID gdiDraw(INT hdc, INT x, INT y);

		// Draw the tile in the foreground
		VOID gdiDrawFG(INT hdc, INT x, INT y);

		// Draw the tile to a canvas
		VOID cnvDraw(CGDICanvas *pCanvas, INT x, INT y);

		// Draw the tile's alpha portion
		VOID gdiDrawAlpha(INT hdc, INT x, INT y);

		// Render the tile's alpha's portion
		VOID gdiRenderAlpha(INT hdc, INT x, INT y);

		// Draw the tile's alpha portion to a canvas
		VOID cnvDrawAlpha(CGDICanvas *pCanvas, INT x, INT y);

		// Render the tile's alpha portion to a canvas
		VOID cnvRenderAlpha(CGDICanvas *pCanvas, INT x, INT y);

		// Prepare the tile's alpha portion
		VOID prepAlpha(VOID);

		// Create a shading mask for this tile
		VOID createShading(INT hdc, RGBSHADE rgb, INT nShadeType, INT nSetType);

		// Check if this tile is shaded in a certain manor
		BOOL isShadedAs(RGBSHADE rgb, INT nShadeType);

		// Does this tile has transparency?
		BOOL hasTransparency(VOID) {return m_bIsTransparent;}

		// Get the filename of the tile
		std::string getFilename(VOID) {return m_strFilename;}

		// Check if the tile is isometric
		BOOL isIsometric(VOID) {return m_bIsometric;}

		// Get a color from the dos palette of doom
		static UINT getDOSColor(UCHAR cColor);

		// Kill all canvases used
		static VOID KillPools(VOID);

	// Private visibility
	private:

		// Create an isometric mask
		VOID createIsometricMask(VOID);

		// Open a tile
		INT openTile(std::string strFilename);

		// Open a tile from a set
		INT openFromTileSet(std::string strFilename, INT number);

		// Get the tileset's header
		tilesetHeader getTilesetInfo(std::string strFilename);

		// Calculate the insertation position
		long calcInsertionPoINT(INT idx, INT number);

		// Increase this tile's detail
		VOID increaseDetail(VOID);

		// Filename of the tile
		std::string m_strFilename;

		// Is the tile transparent?
		BOOL m_bIsTransparent;

		// The tile
		INT m_pnTile[32][32];			// Tile scaled tile, in memory
		INT m_pnAlphaChannel[32][32];	// The tile's alpha channel (255 == opaque part, 0 == tarnsparent part)
		INT m_nDetail;					// Detail level for the tile

		// Shading on the tile
		RGBSHADE m_rgb;
		INT m_nShadeType;

		// Is the tile isometric?
		BOOL m_bIsometric;

		// The HDC this tile was based on
		INT m_nCompatibleDC;

		// Canvas pools used for tiles
		static CCanvasPool *m_pCnvForeground;
		static CCanvasPool *m_pCnvAlphaMask;
		static CCanvasPool *m_pCnvMaskMask;
		static CCanvasPool *m_pCnvForegroundIso;
		static CCanvasPool *m_pCnvAlphaMaskIso;
		static CCanvasPool *m_pCnvMaskMaskIso;

		// Has the iso mask been created?
		static BOOL bCTileCreateIsoMaskOnce;

		// The iso mask
		static LONG isoMaskCTile[64][32];

		// DOS palette
		static UINT g_pnDosPalette[];

		// Indices INTo canvas pools
		INT m_nFgIdx, m_nAlphaIdx, m_nMaskIdx;
		INT m_nFgIdxIso, m_nAlphaIdxIso, m_nMaskIdxIso;

};

//-------------------------------------------------------------------
// End of the header
//-------------------------------------------------------------------
#endif
