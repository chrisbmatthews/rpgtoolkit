//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////////////////////
// CTile.cpp
// Implementation for an rpgtoolkit tile
// Developed for v2.19b (Dec 2001 - Jan 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////////////////////

//===============================================
// Alterations by Delano for 3.0.4
// New isometric tile system.
//
// Edited:
// CTile::createShading
// CTile::open
// CTile::openTile
// CTile::openFromTileSet
// CTile::calcInsertionPoint
//
// New:
// CTile::createIsometricMask
// New constants:

#define ISOTYPE   2
#define TSTTYPE   0
#define ISODETAIL 150		// Arbitrary.

// New variables:
bool bCTileCreateIsoMaskOnce = false;
long isoMaskCTile[64][32];
//===============================================

#include "CTile.h"
#include "CUtil.h"

CCanvasPool* CTile::m_pCnvForeground = NULL;
CCanvasPool* CTile::m_pCnvAlphaMask = NULL;
CCanvasPool* CTile::m_pCnvMaskMask = NULL;

CCanvasPool* CTile::m_pCnvForegroundIso = NULL;
CCanvasPool* CTile::m_pCnvAlphaMaskIso = NULL;
CCanvasPool* CTile::m_pCnvMaskMaskIso = NULL;

//DOS 13h color palette...
unsigned int g_pnDosPalette[] = 
{ 0, 
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

//Constructors...
/////////////////////////////////////////////////
// CTile::CTile()
//
// Action: construct CTile object
//
// Params: nCompatibleDC - the hdc of a compatible drawing device (like what we're going to draw to)
//				 strFilename - filename to load.  You can include a number at the end of a tst to indicate the exact tile.
//				 nRed - Amount to shade red (-255 to 255)
//				 nGreen - Amount to shade green (-255 to 255)
//				 nBlue - Amount to shade blue (-255 to 255)
//
// Returns: NA
////////////////////////////////////////////////
CTile::CTile(int nCompatibleDC, std::string strFilename, RGBSHADE rgb, int nShadeType, bool bIsometric)
{
	//init members...
	m_strFilename = strFilename;
	m_bIsTransparent = false;

	//the gdi canvases will be initialized by the open menthod
	m_nCompatibleDC = nCompatibleDC;
	m_nDetail = 0;

	m_nFgIdxIso = -1;
	m_nAlphaIdxIso = -1;
	m_nMaskIdxIso = -1;

	m_nFgIdx = -1;
	m_nAlphaIdx = -1;
	m_nMaskIdx = -1;


	m_bIsometric = bIsometric;
	//m_vForeground.clear();

	if (m_bIsometric)
	{
		//isometric 64x32 tiles
		if ( m_pCnvForegroundIso == NULL )
		{
			m_pCnvForegroundIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvAlphaMaskIso == NULL )
		{
			m_pCnvAlphaMaskIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvMaskMaskIso == NULL )
		{
			m_pCnvMaskMaskIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}

		m_nFgIdxIso = m_pCnvForegroundIso->getFree();
		m_nAlphaIdxIso = m_pCnvAlphaMaskIso->getFree();
		m_nMaskIdxIso = m_pCnvMaskMaskIso->getFree();
	}
	else
	{
		//2d 32x32 tiles
		if ( m_pCnvForeground == NULL )
		{
			m_pCnvForeground = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvAlphaMask == NULL )
		{
			m_pCnvAlphaMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvMaskMask == NULL )
		{
			m_pCnvMaskMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}

		m_nFgIdx = m_pCnvForeground->getFree();
		m_nAlphaIdx = m_pCnvAlphaMask->getFree();
		m_nMaskIdx = m_pCnvMaskMask->getFree();
	}

	m_nShadeType = SHADE_UNIFORM;
	//m_vShadeList.clear();
	m_rgb.r = rgb.r;
	m_rgb.g = rgb.g;
	m_rgb.b = rgb.b;

	open(strFilename, rgb, nShadeType);
}

CTile::CTile(int nCompatibleDC, bool bIsometric)
{
	//init members...
	m_strFilename = "";

	m_nDetail = 0;
	m_bIsTransparent = false;

	m_bIsometric = bIsometric;

	m_nFgIdxIso = -1;
	m_nAlphaIdxIso = -1;
	m_nMaskIdxIso = -1;

	m_nFgIdx = -1;
	m_nAlphaIdx = -1;
	m_nMaskIdx = -1;

	//the gdi canvases will be initialized by the open menthod
	m_nCompatibleDC = nCompatibleDC;

	if (m_bIsometric)
	{
		//isometric 66x32 tiles
		if ( m_pCnvForegroundIso == NULL )
		{
			m_pCnvForegroundIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvAlphaMaskIso == NULL )
		{
			m_pCnvAlphaMaskIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvMaskMaskIso == NULL )
		{
			m_pCnvMaskMaskIso = new CCanvasPool( nCompatibleDC, 64, 32, TILE_CACHE_SIZE * 2 );
		}

		m_nFgIdxIso = m_pCnvForegroundIso->getFree();
		m_nAlphaIdxIso = m_pCnvAlphaMaskIso->getFree();
		m_nMaskIdxIso = m_pCnvMaskMaskIso->getFree();
	}
	else
	{
		//2d 32x32 tiles
		if ( m_pCnvForeground == NULL )
		{
			m_pCnvForeground = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvAlphaMask == NULL )
		{
			m_pCnvAlphaMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}
		if ( m_pCnvMaskMask == NULL )
		{
			m_pCnvMaskMask = new CCanvasPool( nCompatibleDC, 32, 32, TILE_CACHE_SIZE * 2 );
		}

		m_nFgIdx = m_pCnvForeground->getFree();
		m_nAlphaIdx = m_pCnvAlphaMask->getFree();
		m_nMaskIdx = m_pCnvMaskMask->getFree();
	}


	m_nShadeType = SHADE_UNIFORM;
	m_rgb.r = m_rgb.g = m_rgb.b = 0;

	//m_vForeground.clear();
}

//d-tor
CTile::~CTile()
{
	//destroy gdi canvases
	/*for (int i = 0; i < m_vForeground.size(); i++)
	{
		CTileCanvas* p = m_vForeground[i];
		m_vForeground[i] = NULL;
		delete p;
	}*/
	/*delete m_pcnvForeground;
	delete m_pcnvAlphaMask;
	delete m_pcnvMaskMask;*/

	if ( m_pCnvForeground && m_nFgIdx != -1 )
	{
		m_pCnvForeground->release( m_nFgIdx );
	}
	if ( m_pCnvAlphaMask && m_nAlphaIdx != -1 )
	{
		m_pCnvAlphaMask->release( m_nAlphaIdx );
	}
	if ( m_pCnvMaskMask && m_nMaskIdx != -1 )
	{
		m_pCnvMaskMask->release( m_nMaskIdx );
	}

	if ( m_pCnvForegroundIso && m_nFgIdxIso != -1 )
	{
		m_pCnvForegroundIso->release( m_nFgIdxIso );
	}
	if ( m_pCnvAlphaMaskIso && m_nAlphaIdxIso != -1 )
	{
		m_pCnvAlphaMaskIso->release( m_nAlphaIdxIso );
	}
	if ( m_pCnvMaskMaskIso && m_nMaskIdxIso != -1 )
	{
		m_pCnvMaskMaskIso->release( m_nMaskIdxIso );
	}

}

//copy c-tor
CTile::CTile(const CTile& rhs)
{
	//init members...
	m_strFilename = rhs.m_strFilename;
	m_bIsTransparent = rhs.m_bIsTransparent;
	m_nDetail = rhs.m_nDetail;

	for(int x = 0; x < 32; x++)
	{
		for(int y = 0; y < 32; y++)
		{
			m_pnTile[x][y] = rhs.m_pnTile[x][y];
			m_pnAlphaChannel[x][y] = rhs.m_pnAlphaChannel[x][y];
		}
	}

	m_nCompatibleDC = rhs.m_nCompatibleDC;

	m_bIsometric = rhs.m_bIsometric;

	/*m_vForeground.clear();
	for (int i = 0; i < rhs.m_vForeground.size(); i++)
	{
		CTileCanvas* p = new CTileCanvas((*rhs.m_vForeground[i]));
		m_vForeground.push_back(p);
	}*/

	/*m_vShadeList.clear();
	for (int i = 0; i < rhs.m_vShadeList.size(); i++)
	{
		m_vShadeList.push_back(rhs.m_vShadeList[i]);
	}*/
	m_rgb.r = rhs.m_rgb.r;
	m_rgb.g = rhs.m_rgb.g;
	m_rgb.b = rhs.m_rgb.b;
	m_nShadeType = rhs.m_nShadeType;

	/*m_pcnvForeground = new CGDICanvas(*(rhs.m_pcnvForeground));
	m_pcnvAlphaMask = new CGDICanvas(*(rhs.m_pcnvAlphaMask));
	m_pcnvMaskMask = new CGDICanvas(*(rhs.m_pcnvMaskMask));*/

	m_nFgIdx = rhs.m_nFgIdx;
	m_nAlphaIdx = rhs.m_nAlphaIdx;
	m_nMaskIdx = rhs.m_nMaskIdx;

	m_nFgIdxIso = rhs.m_nFgIdxIso;
	m_nAlphaIdxIso = rhs.m_nAlphaIdxIso;
	m_nMaskIdxIso = rhs.m_nMaskIdxIso;
}


CTile& CTile::operator=(const CTile& rhs)
{
	//destroy gdi canvases
	/*for (int i = 0; i < m_vForeground.size(); i++)
	{
		CTileCanvas* p = m_vForeground[i];
		m_vForeground[i] = NULL;
		delete p;
	}*/
	//delete m_pcnvForeground;
	//delete m_pcnvAlphaMask;
	//delete m_pcnvMaskMask;

	//init members...
	m_nDetail = rhs.m_nDetail;
	m_strFilename = rhs.m_strFilename;
	m_bIsTransparent = rhs.m_bIsTransparent;

	for(int x = 0; x < 32; x++)
	{
		for(int y = 0; y < 32; y++)
		{
			m_pnTile[x][y] = rhs.m_pnTile[x][y];
			m_pnAlphaChannel[x][y] = rhs.m_pnAlphaChannel[x][y];
		}
	}

	m_nCompatibleDC = rhs.m_nCompatibleDC;

	m_bIsometric = rhs.m_bIsometric;

	/*m_vForeground.clear();
	for (i = 0; i < rhs.m_vForeground.size(); i++)
	{
		CTileCanvas* p = new CTileCanvas((*rhs.m_vForeground[i]));
		m_vForeground.push_back(p);
	}*/

	/*m_vShadeList.clear();
	for (int i = 0; i < rhs.m_vShadeList.size(); i++)
	{
		m_vShadeList.push_back(rhs.m_vShadeList[i]);
	}*/
	m_rgb.r = rhs.m_rgb.r;
	m_rgb.g = rhs.m_rgb.g;
	m_rgb.b = rhs.m_rgb.b;
	m_nShadeType = rhs.m_nShadeType;

	/*m_pcnvForeground = new CGDICanvas(*(rhs.m_pcnvForeground));
	m_pcnvAlphaMask = new CGDICanvas(*(rhs.m_pcnvAlphaMask));
	m_pcnvMaskMask = new CGDICanvas(*(rhs.m_pcnvMaskMask));*/

	m_nFgIdx = rhs.m_nFgIdx;
	m_nAlphaIdx = rhs.m_nAlphaIdx;
	m_nMaskIdx = rhs.m_nMaskIdx;

	m_nFgIdxIso = rhs.m_nFgIdxIso;
	m_nAlphaIdxIso = rhs.m_nAlphaIdxIso;
	m_nMaskIdxIso = rhs.m_nMaskIdxIso;

	return (*this);
}


/////////////////////////////////////////////////
// CTile::open
//
// Action: load a tile, and then draw it into the internal buffers to be drawn later
//
// Params: strFilename - filename to load.  You can include a number at the end of a tst to indicate the exact tile.
//				 nRed - Amount to shade red (-255 to 255)
//				 nGreen - Amount to shade green (-255 to 255)
//				 nBlue - Amount to shade blue (-255 to 255)
//
// Returns: void
//
// Called by: CTile::constructor only
//
//==============================================
// Edited by Delano for 3.0.4
//		openTile returns nSetType, which is
//		received by createShading.
//==============================================
////////////////////////////////////////////////

void CTile::open(std::string strFilename, RGBSHADE rgb, int nShadeType)
{

	m_strFilename = strFilename;
	m_bIsTransparent = false;

	//now do the actual loading. New! openTile returns nSetType, for createShading.
	int nSetType = openTile(strFilename);

	if (m_nDetail==2 || m_nDetail==4 || m_nDetail==6) 
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

void CTile::createShading(int hdc, RGBSHADE rgb, int nShadeType, int nSetType)
{

	//now shade...
	int pnTile[32][32];						//Scaled tile in memory.


	// Apply the shading to the tile that is required.
	switch(nShadeType)
	{
		case SHADE_UNIFORM:
		{

			// Don't need an isometric version of this since we're
			// using the same arrays. Added else code though.

			for (int x = 0; x < 32; x++)
			{
				for (int y = 0; y < 32; y++)
				{
					if (m_pnAlphaChannel[x][y] != 0)
					{
						//If not transparent pixel.
						int r = CUtil::red(m_pnTile[x][y]) + rgb.r;
						int g = CUtil::green(m_pnTile[x][y]) + rgb.g;
						int b = CUtil::blue(m_pnTile[x][y]) + rgb.b;
						pnTile[x][y] = CUtil::rgb(r, g, b);
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
		long fgPixels[32*32];
		int arrayPos = 0;

		//m_pCnvForeground->Lock();
		for (int yy = 0; yy<32; yy++)
		{
			for (int xx = 0; xx<32; xx++)
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
		int smalltile[64][32];	// These were declared further down and are used
		int x, y;				// by both processes.

		// Set up the count for the tile. Note that all arrays here run from
		// 0 to 31 whereas in tkpluglocalfns.h they run from 1 o 32.
		int xCount = 0, yCount = 0;

		// Value passed in from opentile.
		if (nSetType == ISOTYPE)
		{
			for (x = 0; x < 64; x++)
			{
				for (y = 0; y < 32; y++)
				{

					//Loop over isoMaskBmp and insert the tile data into the 
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
			int nQuality = 3;
			int isotile[128][64];
			// int x, y;						// This declaration has been moved.

			// Initialize the tile array.
			for (x = 0; x < 128; x++)
			{
				for (y = 0; y < 64; y++)
				{
					isotile[x][y] = -1;
				}
			}
    
			int tx, ty;

			for (tx = 0; tx < 32; tx++)
			{
				for (ty = 0; ty < 32; ty++)
				{
					if (m_pnAlphaChannel[tx][ty] == 0)
					{
					}
					else
					{
						x = 62 + tx * 2 - ty * 2;
						y = tx + ty;
						int crColor = pnTile[tx][ty];
						int crColor2 = pnTile[tx+1][ty];
						if ((m_pnAlphaChannel[tx][ty] != -1) && (m_pnAlphaChannel[tx+1][ty] != -1) && (nQuality == 1 || nQuality == 2))
						{
							int r1 = CUtil::red(crColor);
							int g1 = CUtil::green(crColor);
							int b1 = CUtil::blue(crColor);

							int r2 = CUtil::red(crColor2);
							int g2 = CUtil::green(crColor2);
							int b2 = CUtil::blue(crColor2);

							int ra = (r2 - r1) / 4;
							int ga = (g2 - g1) / 4;
							int ba = (b2 - b1) / 4;

							for (int tempX = x; tempX < x + 4; tempX++)
							{
								int col = CUtil::rgb(r1, g1, b1);
								isotile[tempX][y] = col;

								r1 += ra;
								g1 += ga;
								b1 += ba;
							}
						}
						else
						{
							for (int tempX = x; tempX < x + 4; tempX++)
							{
								isotile[tempX][y] = crColor;
							}
						}
					}
				}
			} // Close for(tx)
    
			//now shrink the iso tile...
			// int smalltile[64][32];				// This declaration has been moved.

			if (nQuality == 3)
			{
				//first shrink on x...
			    int medTile[64][64];
			    int xx = 0;
					int yy = 0;
			    for(x = 0; x < 128; x+=2)
				{
					for (y=0; y<64; y++)
					{
						int c1 = isotile[x][y];
						int c2 = isotile[x+1][y];

						if (c1 != -1 && c2 != -1)
						{
							int r1 = CUtil::red(c1);
							int g1 = CUtil::green(c1);
							int b1 = CUtil::blue(c1);

							int r2 = CUtil::red(c2);
							int g2 = CUtil::green(c2);
							int b2 = CUtil::blue(c2);

							int rr = (r1 + r2) / 2;
							int gg = (g1 + g2) / 2;
							int bb = (b1 + b2) / 2;
							medTile[xx][yy] = CUtil::rgb(rr, gg, bb);
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
						int c1 = medTile[x][y];
						int c2 = medTile[x][y + 1];
          
						if(c1 != -1 && c2 != -1)
						{
							int r1 = CUtil::red(c1);
							int g1 = CUtil::green(c1);
							int b1 = CUtil::blue(c1);

							int r2 = CUtil::red(c2);
							int g2 = CUtil::green(c2);
							int b2 = CUtil::blue(c2);

							int rr = (r1 + r2) / 2;
							int gg = (g1 + g2) / 2;
							int bb = (b1 + b2) / 2;
							smalltile[xx][yy] = CUtil::rgb(rr, gg, bb);
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

				int xx = 0;
				int yy = 0;
				for (x= 0; x < 128; x+=2)
				{
					for (y=0; y<64; y+=2)
					{
						int c1 = isotile[x][y];
						int c2 = isotile[x+1][y];
						if (c1 != -1 && c2 != -1 && nQuality == 2)
						{
							int r1 = CUtil::red(c1);
							int g1 = CUtil::green(c1);
							int b1 = CUtil::blue(c1);

							int r2 = CUtil::red(c2);
							int g2 = CUtil::green(c2);
							int b2 = CUtil::blue(c2);

							int rr = (r1 + r2) / 2;
							int gg = (g1 + g2) / 2;
							int bb = (b1 + b2) / 2;
							smalltile[xx][yy] = CUtil::rgb(rr, gg, bb);
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

		long fg[64*32];
		long alpha[64*32];
		long mask[64*32];
		int arrayPos = 0;
		//m_pCnvForegroundIso->Lock();
		//m_pCnvAlphaMaskIso->Lock();
		//m_pCnvMaskMaskIso->Lock();

		//now draw...
		for (int yy = 0; yy < 32; yy++)
		{
			for (int xx = 0; xx < 64; xx++)
			{
				if (smalltile[xx][yy] == -1)
				{
					// If transparent, set the alpha to white.

					//m_pCnvForegroundIso->SetPixel(xx, yy, 0, m_nFgIdxIso);
					//m_pCnvAlphaMaskIso->SetPixel(xx, yy, RGB(255, 255, 255), m_nAlphaIdxIso);
					//m_pCnvMaskMaskIso->SetPixel(xx, yy, RGB(0,0,0), m_nMaskIdxIso);
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


					//m_pCnvForegroundIso->SetPixel(xx, yy, smalltile[xx][yy], m_nFgIdxIso);
					//m_pCnvAlphaMaskIso->SetPixel(xx, yy, RGB(0, 0, 0), m_nAlphaIdxIso);
					//m_pCnvMaskMaskIso->SetPixel(xx, yy, RGB(255,255,255), m_nMaskIdxIso);
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
		//m_pCnvForegroundIso->Unlock();
		//m_pCnvAlphaMaskIso->Unlock();
		//m_pCnvMaskMaskIso->Unlock();

	} // Close if(!m_bIsometric)
}


/////////////////////////////////////////////////
// CTile::prepAlpha
//
// Action: draw the alpha channel to the alpha canvas
//
// Params: 
//
// Returns: void
////////////////////////////////////////////////
void CTile::prepAlpha()
{
	if (!m_bIsometric)
	{
		long alpha[32*32];
		long mask[32*32];
		int arrayPos = 0;

		//m_pCnvAlphaMask->Lock();
		//m_pCnvMaskMask->Lock();
		for (int yy = 0; yy<32; yy++)
		{
			for (int xx=0; xx<32; xx++)
			{
				//m_pCnvAlphaMask->SetPixel(xx, yy, RGB(255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy]), m_nAlphaIdx);
				//m_pCnvMaskMask->SetPixel(xx, yy, RGB(0,0,0), m_nMaskIdx);
				alpha[arrayPos] = RGB(255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy], 255-m_pnAlphaChannel[xx][yy]);
				mask[arrayPos] = 0;
				arrayPos++;
			}
		}
		m_pCnvAlphaMask->SetPixels( alpha, 0, 0, 32, 32, m_nAlphaIdx );
		m_pCnvMaskMask->SetPixels( mask, 0, 0, 32, 32, m_nMaskIdx );
		//m_pCnvAlphaMask->Unlock();
		//m_pCnvMaskMask->Unlock();
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
// Returns: void
////////////////////////////////////////////////
void CTile::gdiDraw(int hdc, int x, int y)
{
	if (m_bIsometric)
	{
		//blit the alpha channel down...
		m_pCnvAlphaMaskIso->Blt( ( HDC ) hdc, x, y, m_nAlphaIdxIso, SRCAND );
		//blit the foreground down...
		m_pCnvForegroundIso->Blt( ( HDC ) hdc, x, y, m_nFgIdxIso, SRCPAINT );

		//BitBlt((HDC)hdc, x, y, 64, 32, hdcAlpha, 0, 0, SRCAND);
		//BitBlt((HDC)hdc, x, y, 64, 32, hdcFG, 0, 0, SRCPAINT);
	}
	else
	{
		//blit the alpha channel down...
		m_pCnvAlphaMask->Blt( ( HDC ) hdc, x, y, m_nAlphaIdx, SRCAND );
		//blit the foreground down...
		m_pCnvForeground->Blt( ( HDC ) hdc, x, y, m_nFgIdx, SRCPAINT );

		//blit the alpha channel down...
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcAlpha, 0, 0, SRCAND);
		//blit the foreground down...
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcFG, 0, 0, SRCPAINT);
	}
	//m_pcnvAlphaMask->CloseDC(hdcAlpha);
	//m_pcnvForeground->CloseDC(hdcFG);
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
// Returns: void
////////////////////////////////////////////////
void CTile::cnvDraw(CGDICanvas* pCanvas, int x, int y)
{
	if (m_bIsometric)
	{
		//blit the alpha channel down...
		//m_pCnvAlphaMaskIso->Blt( pCanvas, x, y, m_nAlphaIdxIso, SRCAND );
		//blit the foreground down...
		//m_pCnvForegroundIso->Blt( pCanvas, x, y, m_nFgIdxIso, SRCPAINT );
		m_pCnvForegroundIso->BltTransparent( pCanvas, x, y, m_nFgIdxIso, 0 );
	}
	else
	{
		//blit the alpha channel down...
		//m_pCnvAlphaMask->Blt( pCanvas, x, y, m_nAlphaIdx, SRCAND );
		//blit the foreground down...
		//m_pCnvForeground->Blt( pCanvas, x, y, m_nFgIdx, SRCPAINT );
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
// Returns: void
////////////////////////////////////////////////
void CTile::gdiDrawFG(int hdc, int x, int y)
{
	//blit the foreground down...
	//CTileCanvas* pCanvas = GetShadedCanvas(hdc, vShadeList, nShadeType);
	//BitBlt((HDC)hdc, x, y, 32, 32, pCanvas->GetHDC(), 0, 0, SRCPAINT);

	//HDC hdcFG = m_pcnvForeground->OpenDC();
	if (m_bIsometric)
	{
		m_pCnvForegroundIso->Blt( ( HDC ) hdc, x, y, m_nFgIdxIso, SRCPAINT );
		//BitBlt((HDC)hdc, x, y, 64, 32, hdcFG, 0, 0, SRCPAINT);
	}
	else
	{
		m_pCnvForeground->Blt( ( HDC ) hdc, x, y, m_nFgIdx, SRCPAINT );
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcFG, 0, 0, SRCPAINT);
	}
	//m_pcnvForeground->CloseDC(hdcFG);
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
// Returns: void
////////////////////////////////////////////////
void CTile::gdiDrawAlpha(int hdc, int x, int y)
{
	//HDC hdcAlpha = m_pcnvAlphaMask->OpenDC();
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( ( HDC ) hdc, x, y, m_nAlphaIdxIso, SRCCOPY );
		//blit the alpha channel down...
		//BitBlt((HDC)hdc, x, y, 64, 32, hdcAlpha, 0, 0, SRCCOPY);
	}
	else
	{
		m_pCnvAlphaMask->Blt( ( HDC ) hdc, x, y, m_nAlphaIdx, SRCCOPY );
		//blit the alpha channel down...
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcAlpha, 0, 0, SRCCOPY);
	}
	//m_pcnvAlphaMask->CloseDC(hdcAlpha);
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
// Returns: void
////////////////////////////////////////////////
void CTile::cnvDrawAlpha(CGDICanvas* pCanvas, int x, int y)
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
// Returns: void
////////////////////////////////////////////////
void CTile::gdiRenderAlpha(int hdc, int x, int y)
{
	//blit the alpha channel down...
	/*for (int xx= 0; xx<32; xx++)
	{
		for (int yy=0; yy<32; yy++)
		{
			if (m_pnAlphaChannel[xx][yy] == 255)
			{
				SetPixelV((HDC)hdc, x+xx, y+yy, 0);
			}
		}
	}*/

	//HDC hdcAlpha = m_pcnvAlphaMask->OpenDC();
	//HDC hdcMask = m_pcnvMaskMask->OpenDC();
	if (m_bIsometric)
	{
		m_pCnvAlphaMaskIso->Blt( ( HDC ) hdc, x, y, m_nAlphaIdxIso, SRCAND );
		m_pCnvMaskMaskIso->Blt( ( HDC ) hdc, x, y, m_nMaskIdxIso, SRCAND );
		//blit the alpha channel down...
		//BitBlt((HDC)hdc, x, y, 64, 32, hdcAlpha, 0, 0, SRCAND);
		//blit the foreground down...
		//BitBlt((HDC)hdc, x, y, 64, 32, hdcMask, 0, 0, SRCPAINT);
	}
	else
	{
		m_pCnvAlphaMask->Blt( ( HDC ) hdc, x, y, m_nAlphaIdx, SRCAND );
		m_pCnvMaskMask->Blt( ( HDC ) hdc, x, y, m_nMaskIdx, SRCAND );

		//blit the alpha channel down...
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcAlpha, 0, 0, SRCAND);
		//blit the foreground down...
		//BitBlt((HDC)hdc, x, y, 32, 32, hdcMask, 0, 0, SRCPAINT);
	}
	//m_pcnvAlphaMask->CloseDC(hdcAlpha);
	//m_pcnvMaskMask->CloseDC(hdcMask);

	//BitBlt((HDC)hdc, x, y, 32, 32, m_pcnvForeground->GetHDC(), 0, 0, SRCCOPY);
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
// Returns: void
////////////////////////////////////////////////
void CTile::cnvRenderAlpha(CGDICanvas* pCanvas, int x, int y)
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
// Returns: void
//
// Called by: CTile::open only.
//
//=====================================================
// Edited: for 3.0.4 by Delano 
//		   Added support for new isometric tilesets.
//		   Added recognition for the .iso extention.
//
//		Now returns an int! This is used for .iso in
//      create shading. openTile = ISOTYPE for .iso
//								 = TSTTYPE else.
//      Returns -1 on fail.
//=====================================================
///////////////////////////////////////////////////////

int CTile::openTile(std::string strFilename)
{
	int x,y;
	int comp;

	std::string strExt;

	strExt = CUtil::getExt(strFilename);
	strExt = CUtil::upperCase(strExt);

	int nSetType = 1;		//New!

	if((strExt.compare("TST") == 0) || (strExt.compare("ISO") == 0))
	{
		int number = CUtil::getTileNum(strFilename);
		std::string strTstFilename = CUtil::tilesetFilename(strFilename);

		m_nDetail = openFromTileSet(strTstFilename,number);

		
		// Added:
		if (strExt.compare("TST") == 0) nSetType = TSTTYPE;
		if (strExt.compare("ISO") == 0) nSetType = ISOTYPE;

		return nSetType;
	}

	//it's a .gph tile...
	bool bTransparentParts = false;

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
							bTransparentParts = true;
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
							bTransparentParts = true;
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
			int xx,yy,times;
			long clr;
			if (m_nDetail==1 || m_nDetail==3 || m_nDetail==5) 
			{
				xx = 0;yy = 0;
				while(xx<32) 
				{
					fgets(dummy,255,infile);
					times=atoi(dummy);

					fgets(dummy,255,infile);
					clr=atol(dummy);

					for (int loopit=1;loopit<=times;loopit++) 
					{
						m_pnTile[xx][yy] = clr;
						m_pnAlphaChannel[xx][yy] = 255;
						if (clr == -1)
						{
							bTransparentParts = true;
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

					for (int loopit=1;loopit<=times;loopit++) 
					{
						m_pnTile[xx][yy] = clr;
						m_pnAlphaChannel[xx][yy] = 255;
						if (clr == -1)
						{
							bTransparentParts = true;
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
		int thevalue=0;
		
		fclose(infile);
		FILE* infile=fopen(strFilename.c_str(),"rt");
		
		if(!infile) {
			return -1;		//Now returns!
		}
		m_nDetail=4;
		for (int y=0;y<16;y++) 
		{
			fgets(dummy,255,infile);
			for (int x=0;x<16;x++) 
			{
				part=dummy[x];
				thevalue=(int)part-33;
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
// Returns: detail level constant
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

int CTile::openFromTileSet ( std::string strFilename, int number ) 
{
	//opens tile #number from a tileset
	//going by the name of fname
	int xx,yy;
	unsigned char rrr,ggg,bbb;
	int detail = -1;

	tilesetHeader tileset = getTilesetInfo(strFilename);

	if (number<1 || number>tileset.tilesInSet) return detail;
	
	bool bTransparentParts = false;

	//===============================================
	// Isometric tilesets start here...
	//
	// The tileset information is loaded into tileset
	// for all formats. Different values for .iso.

	// Create the isometric mask once (for speed considerations).
	if (!bCTileCreateIsoMaskOnce)
	{
		createIsometricMask();
		bCTileCreateIsoMaskOnce = true;
	}


	if ( (tileset.version==20) || (tileset.version==30) )
	{

		FILE* infile=fopen(strFilename.c_str(),"rb");
		if(!infile) 
		{
			return -1;
		}
		long np = calcInsertionPoint(tileset.detail,number);
		fseek(infile,np,0);

		detail=tileset.detail;
		switch(detail) 
		{
			case ISODETAIL:
				// Isometric case. Fall through! End changes.
				detail = 1;
			case 1:
				//32x32x16.7 million;
				for (xx=0;xx<32;xx++) 
				{
					for (yy=0;yy<32;yy++) 
					{
						fread(&rrr,1,1,infile);
						fread(&ggg,1,1,infile);
						fread(&bbb,1,1,infile);
						if ((int)rrr==0 && (int)ggg==1&& (int)bbb==2) 
						{
							m_pnTile[xx][yy]=0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = true;
						}
						else 
						{
							//tile[xx][yy]=rgb((int)bbb,(int)rrr,(int)ggg);
							m_pnTile[xx][yy]=CUtil::rgb((int)rrr,(int)ggg,(int)bbb);
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				}
				break;

			case 2:
				//16x16x16.7 million;
				for (xx=0;xx<16;xx++) 
				{
					for (yy=0;yy<16;yy++) 
					{
						fread(&rrr,1,1,infile);
						fread(&ggg,1,1,infile);
						fread(&bbb,1,1,infile);
						if ((int)rrr==0 && (int)ggg==1&& (int)bbb==2) 
						{
							m_pnTile[xx][yy]=0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = true;
						}
						else 
						{
							m_pnTile[xx][yy]=CUtil::rgb((int)rrr,(int)ggg,(int)bbb);
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				}
				break;

			case 3:
			case 5:
				//32x32x256 (or 16)
				for (xx=0;xx<32;xx++) 
				{
					for (yy=0;yy<32;yy++) 
					{
						fread(&rrr,1,1,infile);
						if ((int)rrr==255) 
						{
							m_pnTile[xx][yy]=0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = true;
						}
						else 
						{
							m_pnTile[xx][yy]=g_pnDosPalette[(int)rrr];
							m_pnAlphaChannel[xx][yy] = 255;
						}
					}
				}
				break;

			case 4:
			case 6:
				//16x16x256 (or 16)
				for (xx=0;xx<16;xx++) 
				{
					for (yy=0;yy<16;yy++) 
					{
						fread(&rrr,1,1,infile);
						if ((int)rrr==255) 
						{
							m_pnTile[xx][yy]=0;
							m_pnAlphaChannel[xx][yy] = 0;
							bTransparentParts = true;
						}
						else 
						{
							m_pnTile[xx][yy]=g_pnDosPalette[(int)rrr];
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
tilesetHeader CTile::getTilesetInfo(std::string strFilename) 
{
	//gets tileset header for filename.
	//returns 0-success, 1 failure.
	tilesetHeader tileset;
	tileset.detail=0;
	tileset.tilesInSet = 0;
	tileset.version = 0;

	FILE* infile=fopen(strFilename.c_str(),"rb");
	if(!infile) 
	{
		return tileset;
	}
	fread(&tileset,6,1,infile);
	fclose(infile);

	return tileset;
}


///////////////////////////////////////////////////////
//
// CTile::calcInsertionPoint
//
// Parameters: d- detail level
//						 number- tile num
//
// Action: calc insertion point of a tile in a tst
//
// Returns: offset
//
//=====================================================
// Edited: for 3.0.4 by Delano
//		   Added support for new isometric tilesets.
//		   Added case for isometric detail = ISODETAIL
//=====================================================
///////////////////////////////////////////////////////

long CTile::calcInsertionPoint ( int d, int number ) 
{
	long num=(long)number;
	switch(d) 
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
void CTile::increaseDetail() 
{
	long int btile[17][17];
	long int atile[17][17];
	int x,y;

	if (m_nDetail==2) m_nDetail=1;
	if (m_nDetail==4) m_nDetail=3;
	if (m_nDetail==6) m_nDetail=5;

	//backup old tile
	for (x=0;x<16;x++) 
	{
		for (y=0;y<16;y++) 
		{
			btile[x][y] = m_pnTile[x][y];
			atile[x][y] = m_pnAlphaChannel[x][y];
			m_pnTile[x][y] = -1;
		}	
	}
	//increase detail
	int xx=0, yy=0;
	for (x=0;x<16;x++) 
	{
		for (y=0;y<16;y++) 
		{
			m_pnTile[xx  ][yy  ] = btile[x][y];
			m_pnTile[xx  ][yy+1] = btile[x][y];
			m_pnTile[xx+1][yy  ] = btile[x][y];
			m_pnTile[xx+1][yy+1] = btile[x][y];

			m_pnAlphaChannel[xx  ][yy  ] = atile[x][y];
			m_pnAlphaChannel[xx  ][yy+1] = atile[x][y];
			m_pnAlphaChannel[xx+1][yy  ] = atile[x][y];
			m_pnAlphaChannel[xx+1][yy+1] = atile[x][y];
			yy=yy+2;
		}
		xx=xx+2;
		yy=0;
	}
}



//determine shading...
bool CTile::isShadedAs(RGBSHADE rgb, int nShadeType)
{
	bool bRet = false;
	if (nShadeType != m_nShadeType)
	{
		bRet = false;
	}
	else
	{
		RGBSHADE r1 = m_rgb;
		RGBSHADE r2 = rgb;
		if (r1.r == r2.r && r1.g == r2.g && r1.b == r2.b)
		{
			bRet = true;
		}
		else
		{
			bRet = false;
		}
	}
	return bRet;
}



//get DOS palette color
unsigned int CTile::getDOSColor(unsigned char cColor)
{
	return g_pnDosPalette[cColor];
}


//kill alive tile pools
void CTile::KillPools()
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

void CTile::createIsometricMask ( )
{

	int nQuality = 3;
	int isotile[128][64];
	int x, y;
	
	//Take a black tile and pass it through the rotation routine.

	int blackTile[32][32];

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
  
	int tx, ty;

	for (tx = 0; tx < 32; tx++)
	{
		for (ty = 0; ty < 32; ty++)
		{

			x = 62 + tx * 2 - ty * 2;
			y = tx + ty;
			int crColor = blackTile[tx][ty];

			for (int tempX = x; tempX < x + 4; tempX++)
			{
				isotile[tempX][y] = crColor;
			}

		}
	} // next tx
  
	//now shrink the iso tile...
	int smalltile[64][32];

	//first shrink on x...
	int medTile[64][64];
	int xx = 0, yy = 0;
	for(x = 0; x < 128; x+=2)
	{
		for (y=0; y<64; y++)
		{
			int c1 = isotile[x][y];

			medTile[xx][yy] = c1;

			yy++;
		}
		xx++;
		yy=0;
	} // next x

	//now shrink on y...
	xx = yy = 0;
	for(x = 0; x<64; x++)
	{
		for(y = 0; y < 64; y+= 2)
		{
			int c1 = medTile[x][y];
    
			smalltile[xx][yy] = c1;

			yy++;
		}
		xx++;
		yy = 0;
	} // next x



	// We now have our isometric mask! Now, load it into the CTile mask.

	for (x = 0; x < 64; x++)
	{
		for (y = 0; y < 32; y++)
		{
			isoMaskCTile[x][y] = smalltile[x][y];
		}
	}

	return;
}
