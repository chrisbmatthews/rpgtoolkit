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
#if !defined(INLINE) && !defined(FAST_CALL)
#	if defined(_MSC_VER)
#		define INLINE __inline		// VC++ prefers the __inline keyword
#		define FAST_CALL __fastcall
#	else
#		define INLINE inline
#		define FAST_CALL			// Register (fast) calls are specific to VC++
#	endif
#endif
#if !defined(DOUBLE)
typedef double DOUBLE;
#endif
#if !defined(STATIC)
#define STATIC static
#endif

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#include <string>
#include <vector>
#include "../../tkCommon/tkCanvas/CCanvasPool.h"
#include "../movement/coords.h"

//-------------------------------------------------------------------
// A tileset header
//-------------------------------------------------------------------
typedef struct tagTilesetHeader
{
	WORD version;  		// 20=2.0, 21=2.1, etc
	WORD tilesInSet;	// number of tiles in set
	WORD detail;		// detail level in set MUST BE UNIFORM!
} TS_HEADER, *LPTS_HEADER;

#define SHADE_UNIFORM 0

// A colour shade.
typedef struct tagColorShade
{
	int r;
	int g;
	int b;
} RGBSHADE;

// Options for CTile::drawByBoardCoord.
enum tagTileMaskEnum
{
	TM_NONE,			// No mask.
	TM_COPY,			// Render mask opaquely.
	TM_AND				// Render mask transparently.
};

//-------------------------------------------------------------------
// CTile - a tile
//-------------------------------------------------------------------
class CTile
{
	public:
		// Construct with little information
		CTile(
			CONST INT nCompatibleDC,
			CONST BOOL bIsometric = FALSE
		);

		// Construct with full set of information
		CTile(
			CONST INT nCompatibleDC,
			CONST std::string strFilename,
			CONST RGBSHADE rgb,
			CONST INT nShadeType,
			CONST BOOL bIsometric = FALSE
		);

		// Deconstruct
		~CTile(
			VOID
		);

		// Copy constructor
		CTile(
			CONST CTile &rhs
		);

		// Assignment operator
		CTile &FAST_CALL operator=(
			CONST CTile &rhs
		);

		// Open a tile
		VOID FAST_CALL open(
			CONST std::string strFilename,
			CONST RGBSHADE rgb,
			CONST INT nShadeType
		);

		// Draw the tile
		VOID FAST_CALL gdiDraw(
			CONST HDC hdc,
			CONST INT x,
			CONST INT y
		);

		// Draw the tile in the foreground
		VOID FAST_CALL gdiDrawFG(
			CONST INT hdc,
			CONST INT x,
			CONST INT y
		);

		// Draw the tile to a canvas
		VOID FAST_CALL cnvDraw(
			CCanvas *pCanvas,
			CONST INT x,
			CONST INT y
		);

		// Draw the tile's alpha portion
		VOID FAST_CALL gdiDrawAlpha(
			CONST HDC hdc,
			CONST INT x,
			CONST INT y
		);

		// Render the tile's alpha's portion
		VOID FAST_CALL gdiRenderAlpha(
			CONST HDC hdc,
			CONST INT x,
			CONST INT y
		);

		// Draw the tile's alpha portion to a canvas
		VOID FAST_CALL cnvDrawAlpha(
			CCanvas *pCanvas,
			CONST INT x,
			CONST INT y
		);

		// Render the tile's alpha portion to a canvas
		VOID FAST_CALL cnvRenderAlpha(
			CCanvas *pCanvas,
			CONST INT x,
			CONST INT y
		);

		// Prepare the tile's alpha portion
		VOID FAST_CALL prepAlpha(
			VOID
		);

		// Create a shading mask for this tile
		VOID FAST_CALL createShading(
			CONST RGBSHADE rgb,
			CONST INT nShadeType,
			CONST INT nSetType
		);

		// Check if this tile is shaded in a certain manor
		BOOL FAST_CALL isShadedAs(
			CONST RGBSHADE rgb,
			CONST INT nShadeType
		);

		// Does this tile have transparency?
		BOOL hasTransparency(VOID) { return m_bIsTransparent; }

		// Get the filename of the tile
		std::string getFilename(VOID) { return m_strFilename; }

		// Check if the tile is isometric
		BOOL isIsometric(VOID) { return m_bIsometric; }

		// Get a color from the dos palette of doom
		STATIC UINT FAST_CALL getDOSColor(
			CONST UCHAR cColor
		);

		// Kill all canvases used
		STATIC VOID FAST_CALL KillPools(
			VOID
		);

		STATIC BOOL drawByBoardCoord(
			CONST STRING filename, 
			INT x, INT y, 
			CONST INT r, CONST INT g, CONST INT b, 
			CCanvas *cnv, 
			CONST INT eMaskValue,
			CONST INT pxOffsetX, CONST INT pxOffsetY, 
			COORD_TYPE coordType, 
			CONST INT brdSizeX
		);

		STATIC BOOL CTile::drawByBoardCoordHdc(
			CONST STRING filename, 
			INT x, INT y, 
			CONST INT r, CONST INT g, CONST INT b, 
			CONST HDC hdc,
			CONST INT eMaskValue,
			CONST INT pxOffsetX, CONST INT pxOffsetY, 
			COORD_TYPE coordType,
			CONST INT brdSizeX
		);

		STATIC CTile *getTile(
			CONST STRING filename, 
			CONST INT eMask, 
			CONST RGBSHADE rgb, 
			CONST BOOL bIsometric,
			CONST HDC hdcCompat
		);

		STATIC VOID clearTileCache(
			VOID
		);

		STATIC TS_HEADER FAST_CALL getTilesetInfo(
			CONST std::string strFilename
		);

		STATIC VOID deleteFromCache(
			CONST STRING filename
		);

	private:
		// Create an isometric mask
		VOID FAST_CALL createIsometricMask(
			VOID
		);

		// Convert source 32x32 pixel array to 64x32 pixel array.
		VOID toIsometric(
			LONG *dest, 
			CONST LONG *src
		);

		// Open a tile
		INT FAST_CALL openTile(
			CONST std::string strFilename
		);

		// Open a tile from a set
		INT FAST_CALL openFromTileSet(
			CONST std::string strFilename,
			CONST INT number
		);

		// Calculate the insertation position
		LONG FAST_CALL calcInsertionPoint(
			CONST INT idx,
			CONST INT number
		);

		// Increase this tile's detail
		VOID FAST_CALL increaseDetail(
			VOID
		);

		STATIC CTile **findCacheMatch(
			CONST STRING filename, 
			CONST INT eMask, 
			CONST RGBSHADE rgb, 
			CONST BOOL bIsometric
		);

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
		STATIC CCanvasPool *m_pCnvForeground;
		STATIC CCanvasPool *m_pCnvAlphaMask;
		STATIC CCanvasPool *m_pCnvMaskMask;
		STATIC CCanvasPool *m_pCnvForegroundIso;
		STATIC CCanvasPool *m_pCnvAlphaMaskIso;
		STATIC CCanvasPool *m_pCnvMaskMaskIso;

		// Has the iso mask been created?
		STATIC BOOL bCTileCreateIsoMaskOnce;

		// The iso mask
		STATIC LONG isoMaskCTile[64][32];

		// DOS palette
		STATIC CONST UINT g_pnDosPalette[];

		// Indices into canvas pools
		INT m_nFgIdx, m_nAlphaIdx, m_nMaskIdx;
		INT m_nFgIdxIso, m_nAlphaIdxIso, m_nMaskIdxIso;

		// Tile cache.
		STATIC std::vector<CTile *> m_tiles;
};

#endif
