//-------------------------------------------------------------------
// All contents copyright 2003, Christopher Matthews or Contributors
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------

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

// Colin: Has nobody ever heard of member initialization lists? :P
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

	open(strFilename, rgb, nShadeType);
}

//-------------------------------------------------------------------
// Construct from DC and iso flag
//-------------------------------------------------------------------
CTile::CTile(CONST INT nCompatibleDC, CONST BOOL bIsometric):

// Colin: Added real member initialization list
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

		// Colin says: Delano, the !, logical NOT, operator will check for
		//			   inequality with NULL.

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
			m_pCnvForeground = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		if (!m_pCnvAlphaMask)
			m_pCnvAlphaMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		if (!m_pCnvMaskMask)
			m_pCnvMaskMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );

		m_nFgIdx = m_pCnvForeground->getFree();
		m_nAlphaIdx = m_pCnvAlphaMask->getFree();
		m_nMaskIdx = m_pCnvMaskMask->getFree();

	}

	m_rgb.r = m_rgb.g = m_rgb.b = 0;

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

// Member initialization list
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

	//now prep the alpha channel...
	prepAlpha();

	//New! createShading receives nSetType.
	createShading(m_nCompatibleDC, rgb, nShadeType, nSetType);
}

///////////////////////////////////////////////////////
// CTile::createShading
//
// Action: create offscreen canvas for the tile and
//         prep it with the proper shading...
//
// Params: vShadeList - list of shadings
//         nShadeType = type of shading used.
//
// Returns: 
//
// Called by: CTile::open only.
//
//=====================================================
// Edited: Delano 15/06/04 for 3.0.4
//		   Added support for new isometric tilesets.
//
//   Added new parameter, nSetType passed from OpenTile.
//   nSetType = ISOTYPE for .iso, TSTTYPE else.
//
//   This is where the tile is prepared and written to 
//   the gdi.
//   This (the CTile class) handles tile drawing for 
//   trans3 and the board editor. Tileset browsing is
//   handled by tkpluglocalfns.h and preview boxes by
//   toolkit3.exe itself.
//
//   This function is only called upon first loading the
//   tile so there isn't a danger of the tile being 
//   "mistreated" if it's found in the cache since this
//   routine won't be called.
//
//   There was also a bug where perfectly black tiles 
//   were drawn transparently on isometric boards in 
//   trans3 (but not the board editor or normal boards).
//=====================================================
///////////////////////////////////////////////////////

VOID FAST_CALL CTile::createShading(CONST INT hdc, CONST RGBSHADE rgb, CONST INT nShadeType, CONST INT nSetType)
{

	//now shade...
	INT pnTile[32][32];						//Scaled tile in memory.

	// Apply the shading to the tile that is required.
	switch (nShadeType)
	{
		case SHADE_UNIFORM:
		{

			// Don't need an isometric version of this since we're
			// using the same arrays. Added else code though.

			for (INT x = 0; x < 32; x++)
			{
				for (INT y = 0; y < 32; y++)
				{
					if (m_pnAlphaChannel[x][y] != 0)
					{
						//If not transparent pixel.
						INT r = util::red(m_pnTile[x][y]) + rgb.r;
						INT g = util::green(m_pnTile[x][y]) + rgb.g;
						INT b = util::blue(m_pnTile[x][y]) + rgb.b;
						pnTile[x][y] = util::rgb(r, g, b);
					}
					else
					{
						//Added: Set the element to transparent.
						pnTile[x][y] = -1;
					}
				}
			}

		} break;	// SHADE_UNIFORM
	}	// Close switch(nShadeType)


	//now that it's shaded, draw this onto our offscreen buffer...
	if (!m_bIsometric)
	{
		//do 2d tiles...
		LONG fgPixels[32*32];
		INT arrayPos = 0;

		//m_pCnvForeground->Lock();
		for (INT yy = 0; yy<32; yy++)
		{
			for (INT xx = 0; xx<32; xx++)
			{
				if (m_pnAlphaChannel[xx][yy] == 0)
				{
					//m_pCnvForeground->SetPixel(xx, yy, 0, m_nFgIdx);
					fgPixels[arrayPos] = 0;
				}
				else
				{
					if (pnTile[xx][yy] == RGB(255, 255, 255))
					{
						//m_pCnvForeground->SetPixel(xx, yy, RGB(245, 245, 245), m_nFgIdx);
						fgPixels[arrayPos] = RGB(245, 245, 245);
					}
					else if ( pnTile[xx][yy] == 0 ) 
					{
						fgPixels[arrayPos] = RGB(10, 10, 10);
					}
					else
					{
						//m_pCnvForeground->SetPixel(xx, yy, pnTile[xx][yy], m_nFgIdx);
						fgPixels[arrayPos] = pnTile[xx][yy];
					}
				}
				arrayPos++;
			}
		} // Close for(yy)


		//set those pixels...
		m_pCnvForeground->SetPixels( fgPixels, 0, 0, 32, 32, m_nFgIdx );
		//m_pCnvForeground->Unlock();

	}
	else	// if(!m_bIsometric)
	{

		//==================================
		// New isometric tiles start here.
		INT smalltile[64][32];	// These were declared further down and are used
		INT x, y;				// by both processes.

		// Set up the count for the tile. Note that all arrays here run from
		// 0 to 31 whereas in tkpluglocalfns.h they run from 1 o 32.
		INT xCount = 0, yCount = 0;

		// Value passed in from opentile.
		if (nSetType == ISOTYPE)
		{
			for (x = 0; x < 64; x++)
			{
				for (y = 0; y < 32; y++)
				{

					//Loop over isoMaskBmp and insert the tile data INTo the 
					//black (transparent) pixels.
					if (isoMaskCTile[x][y] == 0) //Black pixel.
					{
						smalltile[x][y] = pnTile[xCount][yCount];

						// Increment the entry in pnTile;
						yCount++;
						if (yCount >= 32)
						{
							xCount++;
							yCount = 0;
						}
					}
					else
					{
						smalltile[x][y] = -1; //Transparent
					}


				} // Close for(y)
			} // Close for(x)

		}
		else // if(nSetType == ISOTYPE)
		{ 
			// End new isometric tiles. Further fixes below though!
			//=======================================================

			//do isometric tile...
			INT nQuality = 3;
			INT isotile[128][64];
			// INT x, y;						// This declaration has been moved.

			// Initialize the tile array.
			for (x = 0; x < 128; x++)
			{
				for (y = 0; y < 64; y++)
				{
					isotile[x][y] = -1;
				}
			}

			for (INT tx = 0; tx < 32; tx++)
			{
				for (INT ty = 0; ty < 32; ty++)
				{
					if (m_pnAlphaChannel[tx][ty])
					{
						x = 62 + tx * 2 - ty * 2;
						y = tx + ty;
						INT crColor = pnTile[tx][ty];
						INT crColor2 = pnTile[tx+1][ty];
						if ((m_pnAlphaChannel[tx][ty] != -1) && (m_pnAlphaChannel[tx+1][ty] != -1) && (nQuality == 1 || nQuality == 2))
						{
							INT r1 = util::red(crColor);
							INT g1 = util::green(crColor);
							INT b1 = util::blue(crColor);

							INT r2 = util::red(crColor2);
							INT g2 = util::green(crColor2);
							INT b2 = util::blue(crColor2);

							INT ra = (r2 - r1) / 4;
							INT ga = (g2 - g1) / 4;
							INT ba = (b2 - b1) / 4;

							for (INT tempX = x; tempX < x + 4; tempX++)
							{
								INT col = util::rgb(r1, g1, b1);
								isotile[tempX][y] = col;

								r1 += ra;
								g1 += ga;
								b1 += ba;
							}
						}
						else
						{
							for (INT tempX = x; tempX < x + 4; tempX++)
							{
								isotile[tempX][y] = crColor;
							}
						}
					}
				}
			} // Close for(tx)
    
			if (nQuality == 3)
			{
				//first shrink on x...
			    INT medTile[64][64];
			    INT xx = 0;
					INT yy = 0;
			    for(x = 0; x < 128; x+=2)
				{
					for (y=0; y<64; y++)
					{
						INT c1 = isotile[x][y];
						INT c2 = isotile[x+1][y];

						if (c1 != -1 && c2 != -1)
						{
							INT r1 = util::red(c1);
							INT g1 = util::green(c1);
							INT b1 = util::blue(c1);

							INT r2 = util::red(c2);
							INT g2 = util::green(c2);
							INT b2 = util::blue(c2);

							INT rr = (r1 + r2) / 2;
							INT gg = (g1 + g2) / 2;
							INT bb = (b1 + b2) / 2;
							medTile[xx][yy] = util::rgb(rr, gg, bb);
						}
						else
						{
							medTile[xx][yy] = c1;
						}
						yy++;
					}
					xx++;
					yy=0;
				} // Close for(x)
  
				//now shrink on y...
				xx = yy = 0;
				for(x = 0; x<64; x++)
				{
					for(y = 0; y < 64; y+= 2)
					{
						INT c1 = medTile[x][y];
						INT c2 = medTile[x][y + 1];
          
						if(c1 != -1 && c2 != -1)
						{
							INT r1 = util::red(c1);
							INT g1 = util::green(c1);
							INT b1 = util::blue(c1);

							INT r2 = util::red(c2);
							INT g2 = util::green(c2);
							INT b2 = util::blue(c2);

							INT rr = (r1 + r2) / 2;
							INT gg = (g1 + g2) / 2;
							INT bb = (b1 + b2) / 2;
							smalltile[xx][yy] = util::rgb(rr, gg, bb);
						}
						else
						{
							smalltile[xx][yy] = c1;
						}
						yy++;
					}
					xx++;
					yy = 0;
				}	// Close for(x)

			}
			else // if (nQuality == 3)
			{

				INT xx = 0;
				INT yy = 0;
				for (x= 0; x < 128; x+=2)
				{
					for (y=0; y<64; y+=2)
					{
						INT c1 = isotile[x][y];
						INT c2 = isotile[x+1][y];
						if (c1 != -1 && c2 != -1 && nQuality == 2)
						{
							INT r1 = util::red(c1);
							INT g1 = util::green(c1);
							INT b1 = util::blue(c1);

							INT r2 = util::red(c2);
							INT g2 = util::green(c2);
							INT b2 = util::blue(c2);

							INT rr = (r1 + r2) / 2;
							INT gg = (g1 + g2) / 2;
							INT bb = (b1 + b2) / 2;
							smalltile[xx][yy] = util::rgb(rr, gg, bb);
						}
						else
						{
							smalltile[xx][yy] = c1;
						}
						yy++;
					}
					xx++;
					yy=0;
				} // Close for(x)

			} // Close if(nQuality == 3)


		} // Close if(nSetType == ISOTYPE)


		// Now, draw the tile, alpha and mask.
		// Need to change the pure black and white pixels!

		LONG fg[64*32];
		LONG alpha[64*32];
		LONG mask[64*32];
		INT arrayPos = 0;

		//now draw...
		for (INT yy = 0; yy < 32; yy++)
		{
			for (INT xx = 0; xx < 64; xx++)
			{
				if (smalltile[xx][yy] == -1)
				{
					// If transparent, set the alpha to white.

					fg[arrayPos] = 0;
					alpha[arrayPos] = RGB(255, 255, 255);
					mask[arrayPos] = 0;
				}
				else
				{
					// Solid. Alter for pure black/white pixels.
					// Added by Delano.
					if (smalltile[xx][yy] == RGB(255, 255, 255))
					{
						smalltile[xx][yy] = RGB(245, 245, 245);		// Off-white.
					}
					else if ( smalltile[xx][yy] == RGB(0, 0, 0))
					{
						smalltile[xx][yy] = RGB(10, 10, 10);		// Off-black.
					}

					fg[arrayPos] = smalltile[xx][yy];
					alpha[arrayPos] = 0;
					mask[arrayPos] = RGB(255,255,255);
				}
				arrayPos++;
			}
		} // Close for(yy)

		m_pCnvForegroundIso->SetPixels( fg, 0, 0, 64, 32, m_nFgIdxIso );
		m_pCnvAlphaMaskIso->SetPixels( alpha, 0, 0, 64, 32, m_nAlphaIdxIso );
		m_pCnvMaskMaskIso->SetPixels( mask, 0, 0, 64, 32, m_nMaskIdxIso );

	} // Close if(!m_bIsometric)
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
VOID FAST_CALL CTile::prepAlpha(VOID) /* Use VOID for paramless functions */
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
VOID FAST_CALL CTile::gdiDraw(CONST INT hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		//blit the alpha channel down...
		m_pCnvAlphaMaskIso->Blt( ( HDC ) hdc, x, y, m_nAlphaIdxIso, SRCAND );
		//blit the foreground down...
		m_pCnvForegroundIso->Blt( ( HDC ) hdc, x, y, m_nFgIdxIso, SRCPAINT );
	}
	else
	{
		//blit the alpha channel down...
		m_pCnvAlphaMask->Blt( ( HDC ) hdc, x, y, m_nAlphaIdx, SRCAND );
		//blit the foreground down...
		m_pCnvForeground->Blt( ( HDC ) hdc, x, y, m_nFgIdx, SRCPAINT );
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
VOID FAST_CALL CTile::cnvDraw(CGDICanvas *pCanvas, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvForegroundIso->BltTransparent( pCanvas, x, y, m_nFgIdxIso, 0 );
	}
	else
	{
		m_pCnvForeground->BltTransparent( pCanvas, x, y, m_nFgIdx, 0 );
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
VOID FAST_CALL CTile::gdiDrawAlpha(CONST INT hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( HDC(hdc), x, y, m_nAlphaIdxIso, SRCCOPY );
	}
	else
	{
		m_pCnvAlphaMask->Blt( HDC(hdc), x, y, m_nAlphaIdx, SRCCOPY );
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
VOID FAST_CALL CTile::cnvDrawAlpha(CGDICanvas* pCanvas, CONST INT x, CONST INT y)
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
VOID FAST_CALL CTile::gdiRenderAlpha(INT hdc, CONST INT x, CONST INT y)
{
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( HDC(hdc), x, y, m_nAlphaIdxIso, SRCAND );
		m_pCnvMaskMaskIso->Blt( HDC(hdc), x, y, m_nMaskIdxIso, SRCAND );
	}
	else
	{
		m_pCnvAlphaMask->Blt( HDC(hdc), x, y, m_nAlphaIdx, SRCAND );
		m_pCnvMaskMask->Blt( HDC(hdc), x, y, m_nMaskIdx, SRCAND );
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
VOID FAST_CALL CTile::cnvRenderAlpha(CGDICanvas* pCanvas, CONST INT x, CONST INT y)
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

		m_nDetail = openFromTileSet(strTstFilename,number);

		
		// Added:
		if (strExt.compare("TST") == 0) nSetType = TSTTYPE;
		if (strExt.compare("ISO") == 0) nSetType = ISOTYPE;

		return nSetType;
	}

	//it's a .gph tile...
	BOOL bTransparentParts = FALSE;

	FILE* infile=fopen(strFilename.c_str(),"rt");
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
		FILE* infile=fopen(strFilename.c_str(),"rt");
		
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

	CONST tilesetHeader tileset = getTilesetInfo(strFilename);

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
tilesetHeader FAST_CALL CTile::getTilesetInfo(CONST std::string strFilename) 
{
	//gets tileset header for filename.
	//returns 0-success, 1 failure.
	tilesetHeader tileset;
	tileset.detail=0;
	tileset.tilesInSet = 0;
	tileset.version = 0;

	FILE* infile = fopen(strFilename.c_str(), "rb");
	if (!infile) 
		return tileset;

	fread(&tileset, 6, 1, infile);
	fclose(infile);

	return tileset;
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

	RGBSHADE r1 = m_rgb;
	RGBSHADE r2 = rgb;
	return (r1.r == r2.r && r1.g == r2.g && r1.b == r2.b);

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
VOID FAST_CALL CTile::KillPools(VOID) /* Use VOID for paramless functions */
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


//==============================================
//
// New function: Added by Delano for 3.0.4
//
// Creates isometric mask for .iso tiles.
// Uses a shortened version of the rotation code
//
//==============================================

VOID FAST_CALL CTile::createIsometricMask(VOID) /* Use VOID for paramless functions */
{

	INT nQuality = 3;
	INT isotile[128][64];
	INT x, y;

	// Take a black tile and pass it through the rotation routine.

	INT blackTile[32][32];

	for (x = 0; x < 32; x++)
	{
		for (y = 0; y < 32; y++) blackTile[x][y] = 0;
	}

	// Initialize the mask.
	for (x = 0; x < 64; x++)
	{
		for (y = 0; y < 32; y++) isoMaskCTile[x][y] = -1;
	}

	for (x = 0; x < 128; x++)
	{
		for (y = 0; y < 64; y++) isotile[x][y] = -1;
	}

	for (INT tx = 0; tx < 32; tx++)
	{
		for (INT ty = 0; ty < 32; ty++)
		{

			x = 62 + tx * 2 - ty * 2;
			y = tx + ty;
			INT crColor = blackTile[tx][ty];

			for (INT tempX = x; tempX < x + 4; tempX++)
			{
				isotile[tempX][y] = crColor;
			}

		}
	} // next tx
  
	//now shrink the iso tile...
	INT smalltile[64][32];

	//first shrink on x...
	INT medTile[64][64];
	INT xx = 0, yy = 0;
	for (x = 0; x < 128; x += 2)
	{
		for (y = 0; y < 64; y++)
		{
			INT c1 = isotile[x][y];

			medTile[xx][yy] = c1;

			yy++;
		}
		xx++;
		yy = 0;
	}

	//now shrink on y...
	xx = yy = 0;
	for (x = 0; x<64; x++)
	{
		for (y = 0; y < 64; y+= 2)
		{
			INT c1 = medTile[x][y];
    		smalltile[xx][yy] = c1;
			yy++;
		}
		xx++;
		yy = 0;
	}

	// Colin says: copy the array over
	memcpy(isoMaskCTile, smalltile, sizeof(smalltile));

	return;
}
