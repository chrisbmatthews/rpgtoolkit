/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews & contributors
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

//-------------------------------------------------------------------
// CTile - a tile
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Detail types
//-------------------------------------------------------------------
#define ISOTYPE   2
#define TSTTYPE   0
#define ISODETAIL 150		// Arbitrary

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#include "CTile.h"			// Definition of CTile
#include "CUtil.h"			// Utility functions

//-------------------------------------------------------------------
// CTile Member Initialization
//-------------------------------------------------------------------
CCanvasPool *CTile::m_pCnvForeground = NULL;
CCanvasPool *CTile::m_pCnvAlphaMask = NULL;
CCanvasPool *CTile::m_pCnvMaskMask = NULL;
CCanvasPool *CTile::m_pCnvForegroundIso = NULL;
CCanvasPool *CTile::m_pCnvAlphaMaskIso = NULL;
CCanvasPool *CTile::m_pCnvMaskMaskIso = NULL;
BOOL CTile::bCTileCreateIsoMaskOnce = FALSE;
LONG CTile::isoMaskCTile[64][32] = {NULL};
std::vector<CTile *> CTile::m_tiles;

//-------------------------------------------------------------------
// actkrt3 and trans3 globals
//-------------------------------------------------------------------
STRING (*resolve)(const STRING path) = NULL; // How to resolve tile file names.

//-------------------------------------------------------------------
// Big DOS palette of doom
//-------------------------------------------------------------------
CONST UINT CTile::g_pnDosPalette[] = 
{
 0, 
 11010048 ,
 43008 ,
 11053056 ,
 168 ,
 11010216 ,
 22696 ,
 11053224 ,
 5789784 ,
 16734296 ,
 5832536 ,
 16777048 ,
 5789951 ,
 16734463 ,
 5832703 ,
 16777215 ,
 0 ,
 1579032 ,
 2105376 ,
 3158064 ,
 3684408 ,
 4737096 ,
 5263440 ,
 6316128 ,
 7368816 ,
 8421504 ,
 9474192 ,
 10526880 ,
 12105912 ,
 13158600 ,
 14737632 ,
 16777215 ,
 16711680 ,
 16711744 ,
 16711808 ,
 16711872 ,
 16711935 ,
 12583167 ,
 8388863 ,
 4194559 ,
 255 ,
 16639, 
 33023 ,
 49407 ,
 65535 ,
 65472 ,
 65408 ,
 65344 ,
 65280 ,
 4259584, 
 8453888 ,
 12648192 ,
 16776960 ,
 16760832 ,
 16744448 ,
 16728064 ,
 16744576 ,
 16744608 ,
 16744640 ,
 16744672 ,
 16744703 ,
 14713087 ,
 12615935 ,
 10518783 ,
 8421631 ,
 8429823 ,
 8438015 ,
 8446207 ,
 8454143 ,
 8454112 ,
 8454080 ,
 8454048 ,
 8454016 ,
 10551168 ,
 12648320 ,
 14745472 ,
 16777088 ,
 16769152 ,
 16760960 ,
 16752768 ,
 16758968 ,
 16758984 ,
 16759000 ,
 16759016 ,
 16759039 ,
 15251711 ,
 14203135 ,
 13154559 ,
 12105983 ,
 12110079 ,
 12114175 ,
 12118271 ,
 12124159 ,
 12124136 ,
 12124120 ,
 12124104 ,
 12124088 ,
 13172664 ,
 14221240 ,
 15269816 ,
 16777144 ,
 16771256 ,
 16767160 ,
 16763064 ,
 7340032 ,
 7340064 ,
 7340088 ,
 7340120 ,
 7340144 ,
 5767280 ,
 3670128 ,
 2097264 ,
 112 ,
 8304 ,
 14448 ,
 22640 ,
 28784 ,
 28760 ,
 28728 ,
 28704 ,
 28672 ,
 2125824, 
 3698688 ,
 5795840 ,
 7368704 ,
 7362560 ,
 7354368 ,
 7348224 ,
 7354424 ,
 7354440 ,
 7354456 ,
 7354464 ,
 7354480 ,
 6305904 ,
 5781616 ,
 4733040 ,
 3684464 ,
 3688560 ,
 3692656 ,
 3694704 ,
 3698800 ,
 3698784 ,
 3698776 ,
 3698760 ,
 3698744 ,
 4747320 ,
 5795896 ,
 6320184 ,
 7368760 ,
 7364664 ,
 7362616 ,
 7358520 ,
 7360592 ,
 7360600 ,
 7360608 ,
 7360616 ,
 7360624 ,
 6836336 ,
 6312048 ,
 5787760 ,
 5263472 ,
 5265520 ,
 5267568 ,
 5269616 ,
 5271664 ,
 5271656 ,
 5271648 ,
 5271640 ,
 5271632 ,
 5795920 ,
 6320208 ,
 6844496 ,
 7368784 ,
 7366736 ,
 7364688 ,
 7362640 ,
 4194304 ,
 4194320 ,
 4194336 ,
 4194352 ,
 4194368 ,
 3145792 ,
 2097216 ,
 1048640 ,
 64 ,
 4160, 
 8256 ,
 12352 ,
 16448 ,
 16432 ,
 16416 ,
 16400 ,
 16384 ,
 1064960, 
 2113536 ,
 3162112 ,
 4210688 ,
 4206592 ,
 4202496 ,
 4198400 ,
 4202528 ,
 4202536 ,
 4202544 ,
 4202552 ,
 4202560 ,
 3678272 ,
 3153984 ,
 2629696 ,
 2105408 ,
 2107456 ,
 2109504 ,
 2111552 ,
 2113600 ,
 2113592 ,
 2113584 ,
 2113576 ,
 2113568 ,
 2637856 ,
 3162144 ,
 3686432 ,
 4210720 ,
 4208672 ,
 4206624 ,
 4204576 ,
 4206640 ,
 4206640 ,
 4206648 ,
 4206656 ,
 4206656 ,
 4206656 ,
 3682368 ,
 3158080 ,
 3158080 ,
 3158080 ,
 3160128 ,
 3162176 ,
 3162176 ,
 3162176 ,
 3162168 ,
 3162160 ,
 3162160 ,
 3162160 ,
 3686448 ,
 4210736 ,
 4210736 ,
 4210736 ,
 4208688 ,
 4206640 ,
 0 ,
 0 ,
 0 ,
 0 ,
 0 ,
 0 ,
 0 ,
 0
};

//-------------------------------------------------------------------
// CTile::CTile()
//
// Action: Construct CTile object
//
// Params: nCompatibleDC - the hdc of a compatible drawing device (like what we're going to draw to)
//				 strFilename - filename to load.  You can include a number at the end of a tst to indicate the exact tile.
//				 nRed - Amount to shade red (-255 to 255)
//				 nGreen - Amount to shade green (-255 to 255)
//				 nBlue - Amount to shade blue (-255 to 255)
//
// Returns: NA
//-------------------------------------------------------------------
CTile::CTile(CONST INT nCompatibleDC, CONST std::string strFilename, CONST RGBSHADE rgb, CONST INT nShadeType, CONST BOOL bIsometric):
 m_strFilename(strFilename),
 m_bIsTransparent(FALSE),
 m_nCompatibleDC(nCompatibleDC),
 m_nDetail(0),
 m_nFgIdxIso(-1),
 m_nAlphaIdxIso(-1),
 m_nMaskIdxIso(-1),
 m_nFgIdx(-1),
 m_nAlphaIdx(-1),
 m_nMaskIdx(-1),
 m_bIsometric(bIsometric),
 m_nShadeType(SHADE_UNIFORM)

{

	if (m_bIsometric)
	{
		//isometric 64x32 tiles
		if (!m_pCnvForegroundIso)
			m_pCnvForegroundIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvAlphaMaskIso)
			m_pCnvAlphaMaskIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvMaskMaskIso)
			m_pCnvMaskMaskIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);

		m_nFgIdxIso = m_pCnvForegroundIso->getFree();
		m_nAlphaIdxIso = m_pCnvAlphaMaskIso->getFree();
		m_nMaskIdxIso = m_pCnvMaskMaskIso->getFree();
	}
	else
	{
		//2d 32x32 tiles
		if (!m_pCnvForeground)
			m_pCnvForeground = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvAlphaMask)
			m_pCnvAlphaMask = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvMaskMask)
			m_pCnvMaskMask = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2);

		m_nFgIdx = m_pCnvForeground->getFree();
		m_nAlphaIdx = m_pCnvAlphaMask->getFree();
		m_nMaskIdx = m_pCnvMaskMask->getFree();
	}

	//m_vShadeList.clear();
	m_rgb.r = rgb.r;
	m_rgb.g = rgb.g;
	m_rgb.b = rgb.b;

	memset(m_pnTile, 0, sizeof(m_pnTile));
	memset(m_pnAlphaChannel, 0, sizeof(m_pnAlphaChannel));

	open(strFilename, rgb, nShadeType);
}

//-------------------------------------------------------------------
// Construct from DC and iso flag
//-------------------------------------------------------------------
CTile::CTile(CONST INT nCompatibleDC, CONST BOOL bIsometric):
 m_strFilename(""),
 m_nDetail(0),
 m_bIsTransparent(FALSE),
 m_bIsometric(bIsometric),
 m_nFgIdxIso(-1),
 m_nAlphaIdxIso(-1),
 m_nMaskIdxIso(-1),
 m_nFgIdx(-1),
 m_nAlphaIdx(-1),
 m_nMaskIdx(-1),
 m_nCompatibleDC(nCompatibleDC),
 m_nShadeType(SHADE_UNIFORM)

{

	if (m_bIsometric)
	{
		if (!m_pCnvForegroundIso)
			m_pCnvForegroundIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvAlphaMaskIso)
			m_pCnvAlphaMaskIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);
		if (!m_pCnvMaskMaskIso)
			m_pCnvMaskMaskIso = new CCanvasPool(nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2);

		m_nFgIdxIso = m_pCnvForegroundIso->getFree();
		m_nAlphaIdxIso = m_pCnvAlphaMaskIso->getFree();
		m_nMaskIdxIso = m_pCnvMaskMaskIso->getFree();

	}
	else
	{
		if (!m_pCnvForeground)
			m_pCnvForeground = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		if (!m_pCnvAlphaMask)
			m_pCnvAlphaMask = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		if (!m_pCnvMaskMask)
			m_pCnvMaskMask = new CCanvasPool(nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );

		m_nFgIdx = m_pCnvForeground->getFree();
		m_nAlphaIdx = m_pCnvAlphaMask->getFree();
		m_nMaskIdx = m_pCnvMaskMask->getFree();

	}

	m_rgb.r = m_rgb.g = m_rgb.b = 0;
	memset(m_pnTile, 0, sizeof(m_pnTile));
	memset(m_pnAlphaChannel, 0, sizeof(m_pnAlphaChannel));
}

//-------------------------------------------------------------------
// DeConstructor
//-------------------------------------------------------------------
CTile::~CTile(VOID)
{
	// Blow away all members
	if (m_pCnvForeground && m_nFgIdx != -1)
		m_pCnvForeground->release(m_nFgIdx);
	if (m_pCnvAlphaMask && m_nAlphaIdx != -1)
		m_pCnvAlphaMask->release(m_nAlphaIdx);
	if (m_pCnvMaskMask && m_nMaskIdx != -1)
		m_pCnvMaskMask->release(m_nMaskIdx);
	if (m_pCnvForegroundIso && m_nFgIdxIso != -1)
		m_pCnvForegroundIso->release(m_nFgIdxIso);
	if (m_pCnvAlphaMaskIso && m_nAlphaIdxIso != -1)
		m_pCnvAlphaMaskIso->release(m_nAlphaIdxIso);
	if (m_pCnvMaskMaskIso && m_nMaskIdxIso != -1)
		m_pCnvMaskMaskIso->release(m_nMaskIdxIso);
}

//-------------------------------------------------------------------
// Copy Constructor
//-------------------------------------------------------------------
CTile::CTile(CONST CTile &rhs):
 m_strFilename(rhs.m_strFilename),
 m_bIsTransparent(rhs.m_bIsTransparent),
 m_nDetail(rhs.m_nDetail),
 m_nCompatibleDC(rhs.m_nCompatibleDC),
 m_bIsometric(rhs.m_bIsometric),
 m_rgb(rhs.m_rgb),
 m_nShadeType(rhs.m_nShadeType),
 m_nFgIdx(rhs.m_nFgIdx),
 m_nAlphaIdx(rhs.m_nAlphaIdx),
 m_nMaskIdx(rhs.m_nMaskIdx),
 m_nFgIdxIso(rhs.m_nFgIdxIso),
 m_nAlphaIdxIso(rhs.m_nAlphaIdxIso),
 m_nMaskIdxIso(rhs.m_nMaskIdxIso)

{

	// Colin: There has got to be a better way to
	//	      implement this loop!
	for (INT x = 0; x < 32; x++)
	{
		for (INT y = 0; y < 32; y++)
		{
			m_pnTile[x][y] = rhs.m_pnTile[x][y];
			m_pnAlphaChannel[x][y] = rhs.m_pnAlphaChannel[x][y];
		}
	}

}

//-------------------------------------------------------------------
// Assignment operator
//-------------------------------------------------------------------
CTile &FAST_CALL CTile::operator=(CONST CTile &rhs)
{

	// Colin: There has got to be a better way to
	//	      implement this loop!
	for (INT x = 0; x < 32; x++)
	{
		for (INT y = 0; y < 32; y++)
		{
			m_pnTile[x][y] = rhs.m_pnTile[x][y];
			m_pnAlphaChannel[x][y] = rhs.m_pnAlphaChannel[x][y];
		}
	}

	// Copy over member values
	m_nCompatibleDC = rhs.m_nCompatibleDC;
	m_bIsometric = rhs.m_bIsometric;
	m_rgb.r = rhs.m_rgb.r;
	m_rgb.g = rhs.m_rgb.g;
	m_rgb.b = rhs.m_rgb.b;
	m_nShadeType = rhs.m_nShadeType;
	m_nFgIdx = rhs.m_nFgIdx;
	m_nAlphaIdx = rhs.m_nAlphaIdx;
	m_nMaskIdx = rhs.m_nMaskIdx;
	m_nFgIdxIso = rhs.m_nFgIdxIso;
	m_nAlphaIdxIso = rhs.m_nAlphaIdxIso;
	m_nMaskIdxIso = rhs.m_nMaskIdxIso;
	m_nDetail = rhs.m_nDetail;
	m_strFilename = rhs.m_strFilename;
	m_bIsTransparent = rhs.m_bIsTransparent;

	// Return this object to allow chained assignment
	return *this;

}

/////////////////////////////////////////////////
// CTile::open
//
// Action: load a tile, and then draw it INTo the INTernal buffers to be drawn later
//
// Params: strFilename - filename to load.  You can include a number at the end of a tst to indicate the exact tile.
//				 nRed - Amount to shade red (-255 to 255)
//				 nGreen - Amount to shade green (-255 to 255)
//				 nBlue - Amount to shade blue (-255 to 255)
//
// Returns: VOID
//
// Called by: CTile::Constructor only
//
//==============================================
// Edited by Delano for 3.0.4
//		openTile returns nSetType, which is
//		received by createShading.
//==============================================
////////////////////////////////////////////////

VOID FAST_CALL CTile::open(CONST std::string strFilename, CONST RGBSHADE rgb, CONST INT nShadeType)
{

	m_strFilename = strFilename;
	m_bIsTransparent = FALSE;

	//now do the actual loading. New! openTile returns nSetType, for createShading.
	INT nSetType = openTile(strFilename);

	if (m_nDetail == 2 || m_nDetail == 4 || m_nDetail == 6) 
		increaseDetail();

	prepAlpha();
	createShading(rgb, nShadeType, nSetType);
}

//-------------------------------------------------------------------
// CTile::createShading
//
// Action: Apply shading and draw to private canvas. Process isometric tiles.
//
// Params: RGBSHADE rgb:	additional shading to apply.
//		   INT nShadeType:	shading method (SHADE_UNIFORM).
//		   INT nSetType:	tileset type (for isometrics).
//
// Called by: CTile::open only.
//-------------------------------------------------------------------
VOID FAST_CALL CTile::createShading(
	CONST RGBSHADE rgb, 
	CONST INT nShadeType, 
	CONST INT nSetType)
{
	// Local copy of the tile.
	LONG pnTile[32 * 32];
	INT x = 0, y = 0;

	// "Shade" the tile.
	switch (nShadeType)
	{
		case SHADE_UNIFORM:
		{
			for (x = 0; x != 32; ++x)
			{
				for (y = 0; y != 32; ++y)
				{
					if (m_pnAlphaChannel[x][y] != 0)
					{
						// If not a transparent pixel.
						CONST INT r = util::red(m_pnTile[x][y]) + rgb.r,
								  g = util::green(m_pnTile[x][y]) + rgb.g,
								  b = util::blue(m_pnTile[x][y]) + rgb.b;
						INT color = util::rgb(r, g, b);

						// Pure white/black alterations...
						if (color == RGB(255, 255, 255)) color = RGB(245, 245, 245);
						if (color == 0) color = RGB(10, 10, 10);
						
						// Inverted axes for SetPixels().
						pnTile[y * 32 + x] = color;
					}
					else
					{
						pnTile[y * 32 + x] = TRANSP_COLOR;
					}
				} // for (y)
			} // for (x)
		} break;
	} // switch (nShadeType)

	// Draw to buffer.
	if (!m_bIsometric)
	{
		m_pCnvForeground->SetPixels(pnTile, 0, 0, 32, 32, m_nFgIdx);
	}
	else
	{
		LONG isometricTile[64 * 32];
		INT xi = 0, yi = 0, i = 0;
		memset(isometricTile, 0, sizeof(isometricTile));

		if (nSetType == ISOTYPE)
		{
			for (x = 0; x != 64; ++x)
			{
				for (y = 0; y != 32; ++y)
				{
					// Loop over the mask and insert the tile data into the 
					// transparent pixels.
					if (isoMaskCTile[x][y])
					{
						isometricTile[x * 32 + y] = pnTile[yi * 32 + xi];

						// Increment the entry in pnTile.
						if (++yi == 32)
						{
							++xi;
							yi = 0;
						}
					}
					else
					{
						isometricTile[x * 32 + y] = TRANSP_COLOR;
					}
				}
			} // for(x)
		}
		else
		{ 
			// Rotate 32x32 to 64x32.
			toIsometric(isometricTile, pnTile);
		}

		// Now draw the tile, alpha and mask.
		LONG fg[64 * 32], alpha[64 * 32], mask[64 * 32];
		for (y = 0; y != 32; ++y)
		{
			for (x = 0; x != 64; ++x, ++i)
			{
				if(!isoMaskCTile[x][y])
				{
					// Pure black = transparent in SRCPAINT.
					fg[i] = 0;
					alpha[i] = RGB(255, 255, 255);
					mask[i] = 0;
				}
				else
				{
					fg[i] = isometricTile[x * 32 + y];
					alpha[i] = 0;
					mask[i] = RGB(255, 255, 255);
				}
			}
		}
		m_pCnvForegroundIso->SetPixels(fg, 0, 0, 64, 32, m_nFgIdxIso);
		m_pCnvAlphaMaskIso->SetPixels(alpha, 0, 0, 64, 32, m_nAlphaIdxIso);
		m_pCnvMaskMaskIso->SetPixels(mask, 0, 0, 64, 32, m_nMaskIdxIso);

	} // if(!m_bIsometric)
}

/////////////////////////////////////////////////
// CTile::prepAlpha
//
// Action: draw the alpha channel to the alpha canvas
//
// Params: 
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::prepAlpha(VOID)
{
	if (!m_bIsometric)
	{
		LONG alpha[32*32];
		LONG mask[32*32];
		INT arrayPos = 0;
		for (INT yy = 0; yy<32; yy++)
		{
			for (INT xx=0; xx<32; xx++)
			{
				alpha[arrayPos] = RGB(255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy]);
				mask[arrayPos] = 0;
				arrayPos++;
			}
		}
		m_pCnvAlphaMask->SetPixels( alpha, 0, 0, 32, 32, m_nAlphaIdx );
		m_pCnvMaskMask->SetPixels( mask, 0, 0, 32, 32, m_nMaskIdx );
	}
}

/////////////////////////////////////////////////
// CTile::gdiDraw
//
// Action: draw the tile
//
// Params: hdc: hdc to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::gdiDraw(CONST HDC hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		//m_pCnvForegroundIso->Blt(hdc, x, y, m_nFgIdxIso, SRCCOPY);
		
		//blit the alpha channel down...
		m_pCnvAlphaMaskIso->Blt(hdc, x, y, m_nAlphaIdxIso, SRCAND);
		//blit the foreground down...
		m_pCnvForegroundIso->Blt(hdc, x, y, m_nFgIdxIso, SRCPAINT);
	}
	else
	{
		// SRCCOPY with TRANSP_COLOR is sufficient for 32x32.
		m_pCnvForeground->Blt(hdc, x, y, m_nFgIdx, SRCCOPY );

		//blit the alpha channel down...
		//m_pCnvAlphaMask->Blt(hdc, x, y, m_nAlphaIdx, SRCAND);
		//blit the foreground down...
		//m_pCnvForeground->Blt(hdc, x, y, m_nFgIdx, SRCPAINT);
	}
}

/////////////////////////////////////////////////
// CTile::cnvDraw
//
// Action: draw the tile onto a canvas
//
// Params: pCanvas: canvas to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::cnvDraw(CCanvas *pCanvas, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvForegroundIso->BltTransparent(pCanvas, x, y, m_nFgIdxIso, 0);
	}
	else
	{
		m_pCnvForeground->BltTransparent(pCanvas, x, y, m_nFgIdx, TRANSP_COLOR);
	}
}

/////////////////////////////////////////////////
// CTile::gdiDrawFG
//
// Action: draw the tile
//
// Params: hdc: hdc to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::gdiDrawFG(CONST INT hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvForegroundIso->Blt( HDC(hdc), x, y, m_nFgIdxIso, SRCPAINT );
	}
	else
	{
		m_pCnvForeground->Blt( HDC(hdc), x, y, m_nFgIdx, SRCPAINT );
	}
}

/////////////////////////////////////////////////
// CTile::gdiDrawAlpha
//
// Action: draw the tile
//
// Params: hdc: hdc to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::gdiDrawAlpha(CONST HDC hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt(hdc, x, y, m_nAlphaIdxIso, SRCCOPY);
	}
	else
	{
		m_pCnvAlphaMask->Blt(hdc, x, y, m_nAlphaIdx, SRCCOPY);
	}
}

/////////////////////////////////////////////////
// CTile::cnviDrawAlpha
//
// Action: draw the tile
//
// Params: pCanvas: canvas to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::cnvDrawAlpha(CCanvas* pCanvas, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( pCanvas, x, y, m_nAlphaIdxIso, SRCCOPY );
	}
	else
	{
		m_pCnvAlphaMask->Blt( pCanvas, x, y, m_nAlphaIdx, SRCCOPY );
	}
}

/////////////////////////////////////////////////
// CTile::gdiRenderAlpha
//
// Action: render the alpha channel
//				if the level is 255, the pixel isn't drawn.
//
// Params: hdc: hdc to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::gdiRenderAlpha(CONST HDC hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt(hdc, x, y, m_nAlphaIdxIso, SRCAND);
		m_pCnvMaskMaskIso->Blt(hdc, x, y, m_nMaskIdxIso, SRCAND);
	}
	else
	{
		m_pCnvAlphaMask->Blt(hdc, x, y, m_nAlphaIdx, SRCAND);
		m_pCnvMaskMask->Blt(hdc, x, y, m_nMaskIdx, SRCAND);
	}
}

/////////////////////////////////////////////////
// CTile::cnvRenderAlpha
//
// Action: render the alpha channel
//				if the level is 255, the pixel isn't drawn.
//
// Params: pCanvas: canvas to draw to
//				 x: x pixel to draw to
//				 y: y pixel to draw to
//
// Returns: VOID
////////////////////////////////////////////////
VOID FAST_CALL CTile::cnvRenderAlpha(CCanvas* pCanvas, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( pCanvas, x, y, m_nAlphaIdxIso, SRCAND );
		m_pCnvMaskMaskIso->Blt( pCanvas, x, y, m_nMaskIdxIso, SRCAND );
	}
	else
	{
		m_pCnvAlphaMask->Blt( pCanvas, x, y, m_nAlphaIdx, SRCAND );
		m_pCnvMaskMask->Blt( pCanvas, x, y, m_nMaskIdx, SRCAND );
	}
}

///////////////////////////////////////////////////////
// CTile::openTile (private)
//
// Action: load a tile into the tile arrays.  Scale to 32x32
//
// Params: strFilename - filename to load.  You can include a number at the end of a tst to indicate the exact tile.
//
// Returns: VOID
//
// Called by: CTile::open only.
//
//=====================================================
// Edited: for 3.0.4 by Delano 
//		   Added support for new isometric tilesets.
//		   Added recognition for the .iso extention.
//
//		Now returns an INT! This is used for .iso in
//      create shading. openTile = ISOTYPE for .iso
//								 = TSTTYPE else.
//      Returns -1 on fail.
//=====================================================
///////////////////////////////////////////////////////

INT FAST_CALL CTile::openTile(CONST std::string strFilename)
{
	INT x,y;
	INT comp;

	std::string strExt;

	strExt = util::getExt(strFilename);
	strExt = util::upperCase(strExt);

	INT nSetType = 1;		//New!

	if((strExt.compare("TST") == 0) || (strExt.compare("ISO") == 0))
	{
		INT number = util::getTileNum(strFilename);
		std::string strTstFilename = util::tilesetFilename(strFilename);

		m_nDetail = openFromTileSet(resolve ? resolve(strTstFilename) : strTstFilename, number);

		
		// Added:
		if (strExt.compare("TST") == 0) nSetType = TSTTYPE;
		if (strExt.compare("ISO") == 0) nSetType = ISOTYPE;

		return nSetType;
	}

	//it's a .gph tile...
	BOOL bTransparentParts = FALSE;

	FILE* infile=fopen((resolve ? resolve(strFilename) : strFilename).c_str(),"rt");
	if(!infile) {
		return -1;		//Now returns.
	}

	char dummy[255];
	fgets(dummy,255,infile);
	if (strcmpi(dummy,"RPGTLKIT TILE\n")==0) 
	{
		//Version 2
		fgets(dummy,255,infile);	//majorver
		fgets(dummy,255,infile);	//minorver

		fgets(dummy,255,infile);	//detail
		m_nDetail = atoi(dummy);

		fgets(dummy,255,infile);	//compression used? 1-yes, 0-no
		comp=atoi(dummy);
		if (comp==0) 
		{
			//No compression!
			if (m_nDetail==1 || m_nDetail==3 || m_nDetail==5) 
			{
				for (x=0;x<32;x++) 
				{
					for (y=0;y<32;y++) 
					{
 						fgets(dummy,255,infile);
						m_pnTile[x][y]=atol(dummy);
						m_pnAlphaChannel[x][y] = 255;
						if (m_pnTile[x][y] == -1)
						{
							bTransparentParts = TRUE;
							m_pnTile[x][y] = 0;
							m_pnAlphaChannel[x][y] = 0;
						}
						if (m_nDetail == 3 || m_nDetail == 5)
						{
							m_pnTile[x][y] = g_pnDosPalette[m_pnTile[x][y]];
						}
					}
				}
			}
			if (m_nDetail==2 || m_nDetail==4 || m_nDetail==6) 
			{
				for (x=0;x<16;x++) 
				{
					for (y=0;y<16;y++) 
					{
						fgets(dummy,255,infile);
						m_pnTile[x][y]=atol(dummy);
						m_pnAlphaChannel[x][y] = 255;
						if (m_pnTile[x][y] == -1)
						{
							bTransparentParts = TRUE;
							m_pnTile[x][y] = 0;
							m_pnAlphaChannel[x][y] = 0;
						}
					}
				}
			}
		}
		if (comp==1) 
		{
			//Compression used!!!
			INT xx,yy,times;
			LONG clr;
			if (m_nDetail==1 || m_nDetail==3 || m_nDetail==5) 
			{
				xx = 0;yy = 0;
				while(xx<32) 
				{
					fgets(dummy,255,infile);
					times=atoi(dummy);

					fgets(dummy,255,infile);
					clr=atol(dummy);

					for (INT loopit=1;loopit<=times;loopit++) 
					{
						m_pnTile[xx][yy] = clr;
						m_pnAlphaChannel[xx][yy] = 255;
						if (clr == -1)
						{
							bTransparentParts = TRUE;
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
						}
						if (m_nDetail == 3 || m_nDetail == 5)
						{
							m_pnTile[xx][yy] = g_pnDosPalette[m_pnTile[xx][yy]];
						}
						yy++;
						if (yy>=32) 
						{
							yy=0;
							xx++;
						}
					}
				}
			}
			if (m_nDetail==2 || m_nDetail==4 || m_nDetail==6) {
				xx = 0;yy = 0;
				while(xx<16) 
				{
					fgets(dummy,255,infile);
					times=atoi(dummy);

					fgets(dummy,255,infile);
					clr=atol(dummy);

					for (INT loopit=1;loopit<=times;loopit++) 
					{
						m_pnTile[xx][yy] = clr;
						m_pnAlphaChannel[xx][yy] = 255;
						if (clr == -1)
						{
							bTransparentParts = TRUE;
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
						}
						yy++;
						if (yy>=16) 
						{
							yy=0;
							xx++;
						}
					}
				}
			}
		}
	}
	else 
	{
		//Version 1
		char part;
		INT thevalue=0;
		
		fclose(infile);
		FILE* infile=fopen((resolve ? resolve(strFilename) : strFilename).c_str(),"rt");
		
		if(!infile) {
			return -1;		//Now returns!
		}
		m_nDetail=4;
		for (INT y=0;y<16;y++) 
		{
			fgets(dummy,255,infile);
			for (INT x=0;x<16;x++) 
			{
				part=dummy[x];
				thevalue=(INT)part-33;
				m_pnTile[x][y] = g_pnDosPalette[thevalue];
				m_pnAlphaChannel[x][y] = 255;
			}
		}
	}
	fclose(infile);

	m_bIsTransparent = bTransparentParts;

	return 1;	//Now returns!
}

///////////////////////////////////////////////////////
//
// CTile::openFromTileSet
//
// Parameters: strFilename- the filename to open
//             number- the number to open
//
// Action: opens a tile from a tileset
//
// Returns: detail level CONSTant
//
// Called by: CTile::opentile only.
//
//=====================================================
// Edited: for 3.0.4 by Delano 
//		   Added support for new isometric tilesets.
//  
//  Added code for opening the new .iso format. The file
//  consists of:
//	  Header:			tileset (6 bytes as .tst)
//	  Isometric tiles:	32x32x3	(3072 bytes) (as .tst)
//
//		Header:	tileset.version = 30
//				tileset.tilesInSet
//				tileset.detail = ISODETAIL
//=====================================================
///////////////////////////////////////////////////////

INT FAST_CALL CTile::openFromTileSet(CONST std::string strFilename, CONST INT number) 
{

	INT xx = 0, yy = 0;
	UCHAR rrr = '\0', ggg = '\0', bbb = '\0';
	INT detail = -1;

	CONST TS_HEADER tileset = getTilesetInfo(strFilename);

	if (number < 1 || number > tileset.tilesInSet) return detail;
	
	BOOL bTransparentParts = FALSE;

	//===============================================
	// Isometric tilesets start here...
	//
	// The tileset information is loaded INTo tileset
	// for all formats. Different values for .iso.

	// Create the isometric mask once (for speed considerations).
	if (!bCTileCreateIsoMaskOnce)
	{
		createIsometricMask();
		bCTileCreateIsoMaskOnce = TRUE;
	}

	if ((tileset.version == 20) || (tileset.version == 30))
	{

		FILE *CONST infile = fopen(strFilename.c_str(), "rb");
		if (!infile) return -1;
		CONST LONG np = calcInsertionPoint(tileset.detail,number);
		fseek(infile, np, 0);

		// Switch on the detail level
		switch (detail = tileset.detail) 
		{

			case ISODETAIL:
				// Isometric case. Fall through! End changes.
				detail = 1;

			case 1:
				//32x32x16.7 million;
				for (xx = 0; xx < 32; xx++) 
				{
					for (yy = 0; yy < 32; yy++) 
					{
						fread(&rrr, 1, 1, infile);
						fread(&ggg, 1, 1, infile);
						fread(&bbb, 1, 1, infile);
						if (INT(rrr) == 0 && INT(ggg) == 1 && INT(bbb) == 2) 
						{
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = TRUE;
						}
						else 
						{
							m_pnTile[xx][yy] = util::rgb(INT(rrr), INT(ggg), INT(bbb));
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				} break;

			case 2:
				//16x16x16.7 million;
				for (xx = 0; xx < 16; xx++) 
				{
					for (yy=0;yy<16;yy++) 
					{
						fread(&rrr, 1, 1, infile);
						fread(&ggg, 1, 1, infile);
						fread(&bbb, 1, 1, infile);
						if (INT(rrr) == 0 && INT(ggg) == 1 && INT(bbb) == 2) 
						{
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = TRUE;
						}
						else 
						{
							m_pnTile[xx][yy] = util::rgb(INT(rrr), INT(ggg), INT(bbb));
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				}
				break;

			case 3:
			case 5:
				//32x32x256 (or 16)
				for (xx = 0; xx < 32; xx++) 
				{
					for (yy = 0; yy < 32; yy++) 
					{
						fread(&rrr, 1, 1, infile);
						if (INT(rrr) == 255) 
						{
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = TRUE;
						}
						else 
						{
							m_pnTile[xx][yy] = g_pnDosPalette[INT(rrr)];
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				} break;

			case 4:
			case 6:
				//16x16x256 (or 16)
				for (xx = 0; xx < 16; xx++) 
				{
					for (yy = 0; yy < 16; yy++) 
					{
						fread(&rrr, 1, 1, infile);
						if (INT(rrr) == 255) 
						{
							m_pnTile[xx][yy] = 0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = TRUE;
						}
						else 
						{
							m_pnTile[xx][yy] = g_pnDosPalette[INT(rrr)];
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				}
				break;
		}
		fclose(infile);
	}

	m_bIsTransparent = bTransparentParts;

	return detail;
}


///////////////////////////////////////////////////////
//
// CTile::getTilesetInfo
//
// Parameters: strFilename- the filename
//
// Action: get info about a tileset
//
// Returns: info struct
//
// Called by: CTile::openFromTileset only.
//
///////////////////////////////////////////////////////
TS_HEADER FAST_CALL CTile::getTilesetInfo(CONST std::string strFilename) 
{
	TS_HEADER header = {0, 0, 0};

	FILE* file = fopen(strFilename.c_str(), "rb");
	if (!file) return header;

	fread(&header, 6, 1, file);
	fclose(file);

	return header;
}


///////////////////////////////////////////////////////
//
// CTile::calcInsertionPoINT
//
// Parameters: d- detail level
//						 number- tile num
//
// Action: calc insertion poINT of a tile in a tst
//
// Returns: offset
//
//=====================================================
// Edited: for 3.0.4 by Delano
//		   Added support for new isometric tilesets.
//		   Added case for isometric detail = ISODETAIL
//=====================================================
///////////////////////////////////////////////////////

LONG FAST_CALL CTile::calcInsertionPoint(CONST INT d, CONST INT number)
{
	LONG num = LONG(number);
	switch (d) 
	{
		case ISODETAIL:
			//Same as for 1: fall through!
		case 1:
			//32x32, 16.7 million colors. (32x32x3 bytes each)
			return ((3072 * (num - 1)) + 6);

		case 2:
			//16x16, 16.7 million colors (16x16x3 bytes)
			return ((768 * (num - 1)) + 6);

		case 3:
			//32x32, 256 colors (32x32x1 bytes)
			return ((1024 * (num - 1)) + 6);
		
		case 4:
			//16x16, 256 colors (16x16x1 bytes)
			return ((256 * (num - 1)) + 6);
		
		case 5:
			//32x32, 16 colors (32x32x1 byte)
			return ((1024 * (num - 1)) + 6);

		case 6:
			//16x16, 16 colors (16x16,1 bytes)
			return ((256 * (num - 1)) + 6);

	}
	return 0;
}


///////////////////////////////////////////////////////
//
// CTile::increaseDetail
//
// Parameters: 
//
// Action: increases the detail of the tile in memory
//
// Returns: 
//
///////////////////////////////////////////////////////
VOID FAST_CALL CTile::increaseDetail(VOID) /* Use VOID for paramless functions */ 
{

	LONG btile[17][17];
	LONG atile[17][17];
	INT x, y;

	if (m_nDetail == 2) m_nDetail = 1;
	if (m_nDetail == 4) m_nDetail = 3;
	if (m_nDetail == 6) m_nDetail = 5;

	//backup old tile
	for (x = 0; x < 16; x++) 
	{
		for (y = 0; y < 16; y++) 
		{
			btile[x][y] = m_pnTile[x][y];
			atile[x][y] = m_pnAlphaChannel[x][y];
			m_pnTile[x][y] = -1;
		}	
	}

	//increase detail
	INT xx = 0, yy = 0;
	for (x = 0; x < 16; x++) 
	{
		for (y = 0; y < 16; y++) 
		{
			m_pnTile[xx  ][yy  ] = btile[x][y];
			m_pnTile[xx  ][yy+1] = btile[x][y];
			m_pnTile[xx+1][yy  ] = btile[x][y];
			m_pnTile[xx+1][yy+1] = btile[x][y];

			m_pnAlphaChannel[xx  ][yy  ] = atile[x][y];
			m_pnAlphaChannel[xx  ][yy+1] = atile[x][y];
			m_pnAlphaChannel[xx+1][yy  ] = atile[x][y];
			m_pnAlphaChannel[xx+1][yy+1] = atile[x][y];
			yy += 2;
		}
		xx += 2;
		yy = 0;
	}
}

//-------------------------------------------------------------------
// Check if we're shaded in a certain way
//-------------------------------------------------------------------
BOOL FAST_CALL CTile::isShadedAs(CONST RGBSHADE rgb, CONST INT nShadeType)
{

	if (nShadeType != m_nShadeType)
		return FALSE;

	return (m_rgb.r == rgb.r && m_rgb.g == rgb.g && m_rgb.b == rgb.b);

}

//-------------------------------------------------------------------
// Get a DOS palette color
//-------------------------------------------------------------------
UINT FAST_CALL CTile::getDOSColor(CONST UCHAR cColor)
{
	return g_pnDosPalette[cColor];
}

//-------------------------------------------------------------------
// Kill all canvases
//-------------------------------------------------------------------
VOID FAST_CALL CTile::KillPools(VOID)
{
	if ( m_pCnvForeground )
	{
		delete m_pCnvForeground;
		m_pCnvForeground = NULL;
	}
	if ( m_pCnvAlphaMask )
	{
		delete m_pCnvAlphaMask;
		m_pCnvAlphaMask = NULL;
	}
	if ( m_pCnvMaskMask )
	{
		delete m_pCnvMaskMask;
		m_pCnvMaskMask = NULL;
	}

	if ( m_pCnvForegroundIso )
	{
		delete m_pCnvForegroundIso;
		m_pCnvForegroundIso = NULL;
	}
	if ( m_pCnvAlphaMaskIso )
	{
		delete m_pCnvAlphaMaskIso;
		m_pCnvAlphaMaskIso = NULL;
	}
	if ( m_pCnvMaskMaskIso )
	{
		delete m_pCnvMaskMaskIso;
		m_pCnvMaskMask = NULL;
	}
}

//-------------------------------------------------------------------
// Create an isometric mask into CTile::isoMaskCTile
//-------------------------------------------------------------------
VOID FAST_CALL CTile::createIsometricMask(VOID)
{
	memset(isoMaskCTile, 0, sizeof(isoMaskCTile));

	for (INT x = 0; x != 32; ++x)
	{
		for (INT y = 0; y != 16; ++y)
		{
			// Conditions carefully chosen. Note y-axis is inverted!
			// Top left.
			isoMaskCTile[x][y] = (2 * y < 32 - (x + 1) ? 0 : 1);
			// Bottom right.
			isoMaskCTile[x + 32][y + 16] = (2 * y >= 32 - (x + 1) ? 0 : 1);
			// Top right.
			isoMaskCTile[x + 32][y] = (2 * y <  x ? 0 : 1);
			// Bottom left.
			isoMaskCTile[x][y + 16] = (2 * y >= x ? 0 : 1);
		}
	}
}

//-------------------------------------------------------------------
// Rotate a src 32x32 tile into a dest 64x32 tile
//-------------------------------------------------------------------
VOID CTile::toIsometric(LONG *dest, CONST LONG *src)
{
	INT bgTile[128][64];
	INT x = 0, y = 0, MASK = -1;
	memset(bgTile, MASK, sizeof(bgTile));

	for (INT tx = 0; tx != 32; ++tx)
	{
		for (INT ty = 0; ty != 32; ++ty)
		{
			x = 62 + tx * 2 - ty * 2;
			y = tx + ty;

			for (INT i = x; i != x + 4; ++i)
			{
				// if (m_pnAlphaChannel[tx][ty])
				{
					// Source is inverted for SetPixels()
					bgTile[i][y] = src[ty * 32 + tx];
				}
			}
		}
	}

	// Shrink on x
	INT mdTile[64][64];
	memset(mdTile, MASK, sizeof(mdTile));

	for(x = 0; x != 64; ++x)
	{
		for (y = 0; y != 64; ++y)
		{
			CONST INT c1 = bgTile[2 * x][y], c2 = bgTile[2 * x + 1][y];

			if (c1 != MASK && c2 != MASK)
			{
				CONST INT r = (util::red(c1) + util::red(c2)) / 2,
						  g = (util::green(c1) + util::green(c2)) / 2,
						  b = (util::blue(c1) + util::blue(c2)) / 2;
				mdTile[x][y] = util::rgb(r, g, b);
			}
			else
			{
				mdTile[x][y] = c1;
			}
		}
	}

	// Shrink on y
	for(x = 0; x != 64; ++x)
	{
		for(y = 0; y != 32; ++y)
		{
			CONST INT c1 = mdTile[x][2 * y], c2 = mdTile[x][2 * y + 1];

			if(c1 != MASK && c2 != MASK)
			{
				CONST INT r = (util::red(c1) + util::red(c2)) / 2,
						  g = (util::green(c1) + util::green(c2)) / 2,
						  b = (util::blue(c1) + util::blue(c2)) / 2;
				dest[x * 32 + y] = util::rgb(r, g, b);
			}
			else
			{
				dest[x * 32 + y] = c1;
			}
		}
	}
}

//-------------------------------------------------------------------
// Draw a tile to a board by board coordinates.
// CNV and HDC versions - cnv blts by DirectX, hdc by GDI.
//
// fileName		- tile to draw, including project path.
// x, y			- tile co-ordinates to draw.
// r, g, b		- shade.
// cnv			- destination canvas.
// offX, offY	- canvas pixel offset.
// coordType	- define handling of tile co-ordinates.
// eMaskValue	- see tagTileMaskEnum
// brdSizeX		- board width in tiles, for ISO_ROTATED boards.
// nIsoEvenOdd	- does the canvas corner occur at a tile centre or corner?
//-------------------------------------------------------------------
VOID CTile::drawByBoardCoord(
	CONST STRING filename, 
	INT x, INT y, 
	CONST INT r, CONST INT g, CONST INT b, 
	CCanvas *cnv,
	CONST INT eMaskValue,
	CONST INT pxOffsetX, CONST INT pxOffsetY, 
	COORD_TYPE coordType,
	CONST INT brdSizeX)
{
	// Remove any PX_ABSOLUTE flag - tiles are always given in tile coordinates.
	coordType = COORD_TYPE(coordType & ~PX_ABSOLUTE);

	CONST BOOL bIsometric = coordType & (ISO_STACKED | ISO_ROTATED);
	coords::tileToPixel(x, y, coordType, FALSE, brdSizeX);
	if (bIsometric)
	{
		// tileToPixel() reports the centre of the tile.
		x -= 32;
		y -= 16;
	}
	x += pxOffsetX;
	y += pxOffsetY;

	CONST RGBSHADE rgb = {r, g, b};

	CTile *CONST pTile = getTile(filename, eMaskValue, rgb, bIsometric, NULL);

	switch (eMaskValue)
	{
		case (TM_COPY):
			pTile->cnvDrawAlpha(cnv, x, y);
			break;
		case (TM_AND):
			pTile->cnvRenderAlpha(cnv, x, y);
			break;
		default:
			pTile->cnvDraw(cnv, x, y);
	}
}

//-------------------------------------------------------------------
// HDC equivalent - transparent blt by gdi.
//-------------------------------------------------------------------
VOID CTile::drawByBoardCoordHdc(
	CONST STRING filename, 
	INT x, INT y, 
	CONST INT r, CONST INT g, CONST INT b, 
	CONST HDC hdc,
	CONST INT eMaskValue,
	CONST INT pxOffsetX, CONST INT pxOffsetY, 
	COORD_TYPE coordType,
	CONST INT brdSizeX)
{
	// Remove any PX_ABSOLUTE flag - tiles are always given in tile coordinates.
	coordType = COORD_TYPE(coordType & ~PX_ABSOLUTE);
	
	CONST BOOL bIsometric = coordType & (ISO_STACKED | ISO_ROTATED);
	coords::tileToPixel(x, y, coordType, FALSE, brdSizeX);
	if (bIsometric)
	{
		// tileToPixel() reports the centre of the tile.
		x -= 32;
		y -= 16;
	}
	x += pxOffsetX;
	y += pxOffsetY;

	CONST RGBSHADE rgb = {r, g, b};

	CTile *CONST pTile = getTile(filename, eMaskValue, rgb, bIsometric, hdc);
	if (pTile)
	{
		switch (eMaskValue)
		{
			case (TM_COPY):
				pTile->gdiDrawAlpha(hdc, x, y);
				break;
			case (TM_AND):
				pTile->gdiRenderAlpha(hdc, x, y);
				break;
			default:
				pTile->gdiDraw(hdc, x, y);
		}
	}
}

//-------------------------------------------------------------------
// Get a tile from m_tiles by name. If not found, create new.
//-------------------------------------------------------------------
CTile *CTile::getTile(CONST STRING filename, CONST INT eMask, CONST RGBSHADE rgb, CONST BOOL bIsometric, CONST HDC hdcCompat)
{
	if (m_tiles.size() > TILE_CACHE_SIZE) clearTileCache();

	// Check if this tile has already been drawn.
	CTile **itrTile = findCacheMatch(filename, eMask, rgb, bIsometric);
	
	if (itrTile) return *itrTile;

	// Load the tile.
	CTile *CONST pTile = new CTile(INT(hdcCompat), filename, rgb, SHADE_UNIFORM, bIsometric);

	// Push it into the vector.
	m_tiles.push_back(pTile);

	return pTile;
}

//-------------------------------------------------------------------
// Find a tile match in m_tiles by name.
//-------------------------------------------------------------------
CTile **CTile::findCacheMatch(CONST STRING filename, CONST INT eMask, CONST RGBSHADE rgb, CONST BOOL bIsometric)
{
	for (std::vector<CTile *>::iterator i = m_tiles.begin(); i != m_tiles.end(); ++i)
	{
		CONST STRING strVect = (*i)->getFilename();
		if (strVect.compare(filename) == 0)
		{
			if (eMask || (*i)->isShadedAs(rgb, SHADE_UNIFORM))
			{
				// Check isometrics match.
				if (bIsometric == (*i)->isIsometric())
				{
					return &*i;
				}
			}
		}
	}
	return NULL;
}

//-------------------------------------------------------------------
// Erase a single tile from the cache, if found.
//-------------------------------------------------------------------
VOID CTile::deleteFromCache(CONST STRING filename)
{
	CONST RGBSHADE rgb = {0, 0, 0};

	// Standard tile.
	CTile **itrTile = findCacheMatch(filename, TM_NONE, rgb, FALSE);
	if (itrTile)
	{
		m_tiles.erase(itrTile);
	}

	// Isometric.
	itrTile = findCacheMatch(filename, TM_NONE, rgb, TRUE);
	if (itrTile)
	{
		m_tiles.erase(itrTile);
	}
}

//-------------------------------------------------------------------
// Clear the tile cache.
//-------------------------------------------------------------------
VOID CTile::clearTileCache(VOID)
{
	for (std::vector<CTile *>::iterator i = m_tiles.begin(); i != m_tiles.end(); ++i)
	{
		delete *i;
	}
	m_tiles.clear();
}

//-------------------------------------------------------------------
// Draw a blank tile of a given colour
//-------------------------------------------------------------------
VOID CTile::drawBlankHdc(
	INT x, INT y, 
	CONST HDC hdc,
	CONST LONG color,
	CONST INT pxOffsetX, CONST INT pxOffsetY, 
	COORD_TYPE coordType,
	CONST INT brdSizeX)
{	
	// Remove any PX_ABSOLUTE flag - tiles are always given in tile coordinates.
	coordType = COORD_TYPE(coordType & ~PX_ABSOLUTE);
	
	CONST BOOL bIsometric = coordType & (ISO_STACKED | ISO_ROTATED);
	coords::tileToPixel(x, y, coordType, FALSE, brdSizeX);
	if (bIsometric)
	{
		// tileToPixel() reports the centre of the tile.
		x -= 32;
		y -= 16;
	}
	x += pxOffsetX;
	y += pxOffsetY;

	// Create a local tile and colour it.
	CTile tile(INT(hdc), bIsometric);
	memset(tile.m_pnTile, color, sizeof(tile.m_pnTile));

	// Set the necessary canvases.
	CONST RGBSHADE rgb = {0, 0, 0};
	tile.prepAlpha();
	tile.createShading(rgb, SHADE_UNIFORM, bIsometric ? ISOTYPE : TSTTYPE);
	
	tile.gdiDraw(hdc, x, y);
}
