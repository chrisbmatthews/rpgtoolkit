//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

///////////////////////////////////////////////////////
//
// MODULE: tkgfx.cpp
//
// PURPOSE: dll for toolkit graphics engine
//
// Copyright 2000 by Christopher B. Matthews
//
///////////////////////////////////////////////////////

//=====================================================
// Alterations by Delano for 3.0.4 
// New isometric tile system.
//
// Variables added to tkgfx.h
// GFXDrawTstWindow
//=====================================================

//////////////////////////////////////////
// GLOBALS
long g_lCallbacks[60];		//array of visual basic function addresses (callbacks)
int g_nNumCallbacks;			//number of elements in the above array.
//board...
	char board[50][50][9][255];
	char boardback[255],borderback[255];
	long boardcolor,bordercolor;
	int ambienteffect;
	int ambientred[50][50][9], ambientgreen[50][50][9], ambientblue[50][50][9];
//tile...
	long tile[33][33];
	int detail;
//
	//std::set<std::string> gsetTransparentTiles;		//set listing what tiles are transparent
//256 color palette
	//int color256;		//256 color palette loaded? 0-no, 1-yes
	//long rgbpal[256];	//the palette in question
//tileset...

//enemy
	int sizeX, sizeY;	//enemy size.
//general
	double ddx,ddy;		//coord conversion
	int addonr,addong,addonb;	//addon colors
	int tilesX, tilesY;	//screen size, in tiles
	int g_topX, g_topY;	//top x, y of board

/*
 * Includes
 */
#include "stdafx.h"
#include "CBoard.h"
#include "tkgfx.h"
tilesetHeader tileset;
#include "../../tkCommon/tkGfx/CUtil.h"
#include "tkpluglocalfns.h"
#include <vector>

// The tiles in memory
static std::vector<CTile *> gvTiles;

///////////////////////////////////////////////////////
// Exported Functions

///////////////////////////////////////////////////////
//
// Function: GFXFunctionPtr
//
// Parameters: functionAddr- a long value indicating the 
//						 address of a visual basic function.
//
// Action: return visual basic function address.  Since
//				VB won't let you use the AddressOf operator to
//				directly obtain the address of a function, 
//				we instead call into this dll, which just shoots 
//				the address back to VB
//
// Returns: function address as a long
//
///////////////////////////////////////////////////////
long APIENTRY GFXFunctionPtr(long functionAddr)
{
	return functionAddr;
}



///////////////////////////////////////////////////////
//
// Function: GFXInit
//
// Parameters: pCBArray- pointer to array of callbacks
//											(addresses of those callbacks)
//						 nCallbacks- no of callbacks in array.
//
// Action: init gfx engine
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXInit(long *pCBArray, int nCallbacks)
{
	//copy callback array into our global callback array.
	g_nNumCallbacks = nCallbacks;
	for (int i=0; i< nCallbacks; i++)
	{
		g_lCallbacks[i] = pCBArray[i];
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXKill
//
// Parameters: 
//
// Action: kill gfx engine
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXKill()
{
	CTile::KillPools();
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXInitScreen
//
// Parameters: screenX, screenY- screen x and y size
//
// Action: init scaling
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXInitScreen( int screenX,
														int screenY )
{
	ddx=screenX/640.0;
	ddy=screenY/480.0;
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXAbout
//
// Parameters:
//
// Action: Show an about box for the graphics engine
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXAbout()
{
	MessageBox(NULL, "RPG Toolkit Development System 2.1 Copyright 1999, 2000, 2001\nBy Christopher B. Matthews\n\nGraphics Engine", "RPG Toolkit Hi-Speed Graphics Engine", MB_OK);
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawboard
//
// Parameters: hdc- hdc of device to draw to
//						 maskhdc- hdc of the device to draw the mask to.
//						 layer to draw (0 is all)
//						 topx- top-left x coord of board
//						 topy- top-left y coord of board
//						 tilesX, tilesY- x, y size to draw
//						 nBsizex, nBsizey, nBsizel - dimensions of board.
//						 ar- red ambient shade of board
//						 ag- green ambient of board
//						 ab- blue ambient of board
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//
// Action: calls back into trans2 and draws
//				each tile.  if hdc != -1 it draws
//				a color board there.  if maskhdc !=-1
//				it draws the mask, too.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXdrawboard ( CBoard *brd, int hdc,
														int maskhdc,
														int layer,
														int topx, 
														int topy,
														int tilesX,
														int tilesY,
														int nBsizex,
														int nBsizey,
														int nBsizel,
														int ar, 
														int ag, 
														int ab,
														int nIsometric )

{
//	brd->drawHdc(hdc, layer, topx, topy, tilesX, tilesY, nBsizex, nBsizey, nBsizel, ar, ag, ab, nIsometric);
	return TRUE;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawboard
//
// Parameters: cnv - canvas id to draw to
//						 maskcnv- canvas of the device to draw the mask to.
//						 layer to draw (0 is all)
//						 topx- top-left x coord of board
//						 topy- top-left y coord of board
//						 tilesX, tilesY- x, y size to draw
//						 nBsizex, nBsizey, nBsizel - dimensions of board.
//						 ar- red ambient shade of board
//						 ag- green ambient of board
//						 ab- blue ambient of board
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//
// Action: calls back into trans2 and draws
//				each tile.  if hdc != -1 it draws
//				a color board there.  if maskhdc !=-1
//				it draws the mask, too.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXDrawBoardCNV ( CBoard *brd, CNV_HANDLE cnv,
														// CNV_HANDLE maskcnv,
														int layer,
														int topx, 
														int topy,
														int tilesX,
														int tilesY,
														int nBsizex,
														int nBsizey,
														int nBsizel,
														int ar, 
														int ag, 
														int ab,
														int nIsometric )

{
//	brd->draw(cnv, /*maskcnv,*/ layer, topx, topy, tilesX, tilesY, nBsizex, nBsizey, nBsizel, ar, ag, ab, nIsometric);
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawtile
//
// Parameters: fname- filename of tile to draw
//						 x- x tile coord
//						 y- y tile coord
//						 rred- red shade
//						 ggreen- green shade
//						 bblue- blue shade
//						 hdc- hdc of device to draw to
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Opens and draws a tile
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXdrawtile ( const char* fname, 
									 				 double x, 
													 double y, 
													 int rred, 
													 int ggreen, 
													 int bblue, 
													 long hdc,
													 int nIsometric,
													 int nIsoEvenOdd ) 
{
	std::string strFilename = fname;
//	std::string strPath = "tiles\\";
//	strFilename = strPath + strFilename;

	int xx, yy;

	if (nIsometric == 0)
	{
		xx=(int)(x*32-32);
		yy=(int)(y*32-32);
	}
	else
	{
		if (nIsoEvenOdd == 0)
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
		}
		else
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
		}
	}

	//see if we need to clear the tile cache...
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();

	//first check if this tile has already been drawn...
	RGBSHADE rgb;
	rgb.r = rred;
	rgb.g = ggreen;
	rgb.b = bblue;
	//std::vector<RGBSHADE> vShades;
	//vShades.push_back(rgb);


	std::vector<CTile*>::iterator itr = gvTiles.begin();
	for (; itr != gvTiles.end(); itr++)
	{
		std::string strVect = (*itr)->getFilename();
		if (strVect.compare(strFilename) == 0)
		{
			//match!
			//(*itr)->gdiDraw(hdc, xx, yy, vShades, SHADE_UNIFORM);
			//return 1;
			if ((*itr)->isShadedAs(rgb, SHADE_UNIFORM))
			{
				if (nIsometric == 1)
				{
					if ((*itr)->isIsometric())
					{
						//found a match...
						(*itr)->gdiDraw(HDC(hdc), xx, yy);
						return 1;			
					}
				}
				else
				{
					if (!(*itr)->isIsometric())
					{
						//found a match...
						(*itr)->gdiDraw(HDC(hdc), xx, yy);
						return 1;			
					}
				}
			}
		}
	}


	//wasn't found.
	//we have to load it...
	//check if file exists
	if (!(util::tileExists(strFilename))) return 1;

	CTile* t = new CTile(hdc, strFilename, rgb, SHADE_UNIFORM, (bool)nIsometric);
	gvTiles.push_back(t);
	//t->gdiDraw(hdc, xx, yy, vShades, SHADE_UNIFORM);
	t->gdiDraw(HDC(hdc), xx, yy);
	return 1;
}




///////////////////////////////////////////////////////
//
// Function: GFXdrawtile
//
// Parameters: fname- filename of tile to draw
//						 x- x tile coord
//						 y- y tile coord
//						 rred- red shade
//						 ggreen- green shade
//						 bblue- blue shade
//						 cnv- canvas of device to draw to
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Opens and draws a tile
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXDrawTileCNV ( const char* fname, 
									 				 double x, 
													 double y, 
													 int rred, 
													 int ggreen, 
													 int bblue, 
													 CNV_HANDLE cnv,
													 int nIsometric,
													 int nIsoEvenOdd ) 
{
	CONST std::string strPath = "tiles\\";
	CONST std::string strFilename = strPath + fname;

	CCanvas *CONST canvas = reinterpret_cast<CCanvas *>(cnv);

	int xx, yy;

	if (nIsometric == 0)
	{
		xx=(int)(x*32-32);
		yy=(int)(y*32-32);
	}
	else
	{
		if (nIsoEvenOdd == 0)
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
		}
		else
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
		}
	}

	// See if we need to clear the tile cache
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();

	// Attempt to find the tile
	CONST RGBSHADE rgb = {rred, ggreen, bblue};

	std::vector<CTile *>::iterator itr = gvTiles.begin();
	for (; itr != gvTiles.end(); itr++)
	{
		CONST std::string strVect = (*itr)->getFilename();
		if (strVect.compare(strFilename) == 0)
		{
			if ((*itr)->isShadedAs(rgb, SHADE_UNIFORM))
			{
				if (nIsometric)
				{
					if ((*itr)->isIsometric())
					{
						// Found a match
						(*itr)->cnvDraw(canvas, xx, yy);
						return TRUE;			
					}
				}
				else if (!(*itr)->isIsometric())
				{
					// Found a match
					(*itr)->cnvDraw(canvas, xx, yy);
					return TRUE;			
				}
			}
		}
	}


	if (!(util::tileExists(strFilename))) return 1;


	// Load the tile
	CONST HDC hdc = canvas->OpenDC();
	CTile *p = new CTile(INT(hdc), strFilename, rgb, SHADE_UNIFORM, nIsometric);
	canvas->CloseDC(hdc);

	// Push it into the vector
	gvTiles.push_back(p);

	// Draw the tile
	p->cnvDraw(canvas, xx, yy);

	// All's good
	return TRUE;

}


///////////////////////////////////////////////////////
//
// Function: GFXdrawtilemask
//
// Parameters: fname- filename of tile to draw
//						 x- x tile coord
//						 y- y tile coord
//						 rred- red shade
//						 ggreen- green shade
//						 bblue- blue shade
//						 hdc- hdc of device to draw to
//						 nDirectBlt - if 0, then the tile is rendered directly (with transparency).
//										 if 1, it is blitted.
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Opens and draws a tile, masked.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXdrawtilemask ( const char *fname, 
									 double x, 
									 double y, 
									 int rred, 
									 int ggreen, 
									 int bblue, 
									 long hdc,
									 int nDirectBlt,
									 int nIsometric,
									 int nIsoEvenOdd ) 
{
	std::string strFilename = fname;
	std::string strPath = "tiles\\";
	strFilename = strPath + strFilename;

	int xx, yy;

	if (nIsometric == 0)
	{
		xx=(int)(x*32-32);
		yy=(int)(y*32-32);
	}
	else
	{
		if (nIsoEvenOdd == 0)
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
		}
		else
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
		}
	}

	//see if we need to clear the tile cache...
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();

	//first check if this tile has already been drawn...
	RGBSHADE rgb;
	rgb.r = rred;
	rgb.g = ggreen;
	rgb.b = bblue;

	//first check if this tile has already been drawn...
	std::vector<CTile*>::iterator itr = gvTiles.begin();
	for (; itr != gvTiles.end(); itr++)
	{
		std::string strVect = (*itr)->getFilename();
		if (strVect.compare(strFilename) == 0)
		{
			if (nIsometric == 1)
			{
				if ((*itr)->isIsometric())
				{
					//match!
					if (nDirectBlt)
					{
						(*itr)->gdiDrawAlpha(HDC(hdc), xx, yy);
					}
					else
					{
						(*itr)->gdiRenderAlpha(HDC(hdc), xx, yy);
					}
					return 1;
				}
			}
			else
			{
				if (!(*itr)->isIsometric())
				{
					//match!
					if (nDirectBlt)
					{
						(*itr)->gdiDrawAlpha(HDC(hdc), xx, yy);
					}
					else
					{
						(*itr)->gdiRenderAlpha(HDC(hdc), xx, yy);
					}
					return 1;
				}
			}
		}
	}

	//wasn't found.
	//we have to load it...
	//check if file exists
	if (!(util::tileExists(strFilename)))
		return 1;

	CTile* t = new CTile(hdc, strFilename, rgb, SHADE_UNIFORM, (bool)nIsometric);
	gvTiles.push_back(t);
	if (nDirectBlt)
	{
		t->gdiDrawAlpha(HDC(hdc), xx, yy);
	}
	else
	{
		t->gdiRenderAlpha(HDC(hdc), xx, yy);
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawtilemaskCNV
//
// Parameters: fname- filename of tile to draw
//						 x- x tile coord
//						 y- y tile coord
//						 rred- red shade
//						 ggreen- green shade
//						 bblue- blue shade
//						 cnv- canvas of device to draw to
//						 nDirectBlt - if 0, then the tile is rendered directly (with transparency).
//										 if 1, it is blitted.
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Opens and draws a tile, masked.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXDrawTileMaskCNV ( const char fname[], 
									 double x, 
									 double y, 
									 int rred, 
									 int ggreen, 
									 int bblue, 
									 CNV_HANDLE cnv,
									 int nDirectBlt,
									 int nIsometric,
									 int nIsoEvenOdd ) 
{
	std::string strFilename = fname;
	std::string strPath = "tiles\\";
	strFilename = strPath + strFilename;

	CCanvas* canvas = (CCanvas*)cnv;

	int xx, yy;

	if (nIsometric == 0)
	{
		xx=(int)(x*32-32);
		yy=(int)(y*32-32);
	}
	else
	{
		if (nIsoEvenOdd == 0)
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
		}
		else
		{
			if (((int)y % 2) == 0)
			{
				xx=(int)(x*64-96);
				yy=(int)(y*16-32);
			}
			else
			{
				xx=(int)(x*64-64);
				yy=(int)(y*16-32);
			}
		}
	}

	//see if we need to clear the tile cache...
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();

	//first check if this tile has already been drawn...
	RGBSHADE rgb;
	rgb.r = rred;
	rgb.g = ggreen;
	rgb.b = bblue;

	//first check if this tile has already been drawn...
	std::vector<CTile*>::iterator itr = gvTiles.begin();
	for (; itr != gvTiles.end(); itr++)
	{
		std::string strVect = (*itr)->getFilename();
		if (strVect.compare(strFilename) == 0)
		{
			if (nIsometric == 1)
			{
				if ((*itr)->isIsometric())
				{
					//match!
					if (nDirectBlt)
					{
						(*itr)->cnvDrawAlpha(canvas, xx, yy);
					}
					else
					{
						(*itr)->cnvRenderAlpha(canvas, xx, yy);
					}
					return 1;
				}
			}
			else
			{
				if (!(*itr)->isIsometric())
				{
					//match!
					if (nDirectBlt)
					{
						(*itr)->cnvDrawAlpha(canvas, xx, yy);
					}
					else
					{
						(*itr)->cnvRenderAlpha(canvas, xx, yy);
					}
					return 1;
				}
			}
		}
	}

	//wasn't found.
	//we have to load it...
	//check if file exists
	if (!(util::tileExists(strFilename)))
		return 1;

	HDC hdc = canvas->OpenDC();
	CTile* t = new CTile((long)hdc, strFilename, rgb, SHADE_UNIFORM, (bool)nIsometric);
	canvas->CloseDC( hdc );

	gvTiles.push_back(t);
	if (nDirectBlt)
	{
		t->cnvDrawAlpha(canvas, xx, yy);
	}
	else
	{
		t->cnvRenderAlpha(canvas, xx, yy);
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawpixel
//
// Parameters: hdc- hdc of device to draw to
//			   x- the x coord to draw to
//			   y- the y coord to draw to
//			   col- an rgb color
//
// Action: Draws a pixel
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXdrawpixel ( long hdc, 
														long x, 
														long y, 
														long col ) 
{
	//draws a pixel scaled.
	//ddx=ddy=1;
	if (ddx==1 && ddy==1) {
		SetPixelV((HDC)hdc,x,y,col);
	}
	else {
		for (int xx=(int)(x*ddx); xx<=(int)(x*ddx+ddx); xx++) {
			for (int yy=(int)(y*ddy); yy<=(int)(y*ddy+ddy); yy++) {
				SetPixelV((HDC)hdc,xx,yy,col);
			}
		}
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXdrawTstWindow
//
// Parameters: fname- filename of tile to draw
//						 hdc- hdc of device to draw to
//						 start- start location of tileset
//						 tilesx- number of tiles to draw horizonatally
//						 tilesy- number of tiles to draw vertically
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//
// Action: Draws tileset for the tileset window
//
// Returns: 1 (TRUE)
//
//=====================================================
// Edited: for 3.0.4 by Delano 
//		   Added support for new isometric tilesets.
//
//	The imported function will give nIsometric = 2 for 
//  new isometric tiles. This is passed to drawIsoTile 
//  and openFromTileset.
//
//	Transparent pixels are now drawn as the 
//	background colour (127,127,127) - changed to
//	stop flickering during scrolling.
//=====================================================
///////////////////////////////////////////////////////
int APIENTRY GFXdrawTstWindow ( char fname[],
								int hdc,
								int start,
								int tilesx,
								int tilesy,
								int nIsometric ) 
{
	int xx,yy,x,y;
	char ex[255];
	extention(fname, ex);


	if((strcmpi(ex, "TST") == 0) || (strcmpi(ex, "ISO") == 0))
	{
		tilesetInfo(fname);
		int numtiles=tileset.tilesInSet;
		int vx=1;

		//New variables and for-loop.
		//For loop now loops over visible tiles - if the end of set is reached, draw blank tiles.
		int t = start;
		bool endOfSet = false;	

		//Previously looped over t.
		for (int a=1; a<=(tilesx*tilesy); a++, t++)	
		{
			
			//Added to stop scrolling tilesets flickering.
			if (t > numtiles)
			{
				//Draw blank squares.
				endOfSet = true;
			}
			else
			{

				//Load next tile.

				openFromTileSet(fname,t);

				if (detail==2||detail==4||detail==6) 
					increasedetail();
				if (detail==3||detail==5) 
					increasecolors();
				
			} //Close (t > numtiles)


			if (nIsometric == 0)
			{
				yy=(int)(vx/tilesx);
				if (t%tilesx==0) 
				{
					xx=tilesx*32-32;
					yy=yy*32-32;
				}
				else 
				{
					xx=vx-(yy*tilesx);
					xx=xx*32-32;
					yy=yy*32;
				}
				for (x=1;x<=32;x++) 
				{
					for (y=1;y<=32;y++) 
					{
						if ((tile[x][y]!=-1) && (!endOfSet))						
						{
							GFXdrawpixel(hdc,x+xx,y+yy,tile[x][y]);
						}
						else
						{	
							//Draw transparent = background colour.
							//Added to stop scrolling tilesets flickering.
							GFXdrawpixel(hdc,x+xx,y+yy,rgb(127,127,127));
						}
					}
				}
				vx++;
			}
			else //if (nIsometric == 0)
			{
				//Isometric
				yy=(int)(vx/tilesx);
				if (t%tilesx==0) 
				{
					xx=tilesx*64-64;
					yy=yy*32-32;
				}
				else 
				{
					xx=vx-(yy*tilesx);
					xx=xx*64-64;
					yy=yy*32;
				}

				//Added to stop scrolling tilesets flickering.
				if (!endOfSet)
				{
					//Receives nIsometric now!
					drawIsoTile(hdc, xx, yy, nIsometric);
				}
				else
				{
					//End of the tileset, draw blank tiles.
					for (x=1;x<=64;x++) 
					{
						for (y=1;y<=32;y++) 
						{
							//Draw transparent = background colour.
							GFXdrawpixel(hdc,x+xx,y+yy,rgb(127,127,127));
						}
					}
				} // (!endOfSet)

				vx++;

			} //Close if (nIsometric == 0)
		} //Close for (a)

		return 1;

	} //Close 	if((strcmpi(ex,"TST")==0) || (strcmpi(ex,"ISO")==0))

	return 0;	//Failed because tiletypes weren't mathced.
}





///////////////////////////////////////////////////////
//
// Function: BitBltTransparent
//
// Parameters: hdcDest- dest dc
//						 xDest, yDest- coords of destination
//						 width, height- dimensions of area, in pixels
//						 hdcSrc- souce dc
//						 xSrc, ySrc- coords to copy from
//						 transRed, transGreen, transBlue- color
//											of pixels NOT to copy
//
// Action: BitBlts with transparent pixels.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXBitBltTransparent ( long hdcDest,
																 long xDest,
																 long yDest,
																 long width,
																 long height,
																 long hdcSrc,
																 long xSrc,
																 long ySrc,
																 int transRed,
																 int transGreen,
																 int transBlue )
{
	int x, y;
	int xd, yd;
	xd = xDest;
	yd = yDest;
	for (x = xSrc; x <= xSrc + width; x++)
	{
		for (y = ySrc; y <= ySrc + height; y++)
		{
			long col = GetPixel((HDC)hdcSrc, x, y);
			if ( rgb(transRed, transGreen, transBlue) != col )
			{
				//not a transparent color-- copy it!
				SetPixelV((HDC)hdcDest, xd, yd, col);
			}
			yd++;
		}
		xd++;
		yd = yDest;
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: BitBltTranslucent
//
// Parameters: hdcDest- dest dc
//						 xDest, yDest- coords of destination
//						 width, height- dimensions of area, in pixels
//						 hdcSrc- souce dc
//						 xSrc, ySrc- coords to copy from
//
// Action: BitBlts with translucency.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXBitBltTranslucent ( long hdcDest,
																		long xDest,
																		long yDest,
																		long width,
																		long height,
																		long hdcSrc,
																		long xSrc,
																		long ySrc )
{
	int x, y;
	int xd, yd;
	xd = xDest;
	yd = yDest;
	for (x = xSrc; x <= xSrc + width; x++)
	{
		for (y = ySrc; y <= ySrc + height; y++)
		{
			long col = GetPixel((HDC)hdcSrc, x, y);
			long destCol = GetPixel((HDC)hdcDest, xd, yd);

			int r = red(col);
			int g = green(col);
			int b = blue(col);

			int rd = red(destCol);
			int gd = green(destCol);
			int bd = blue(destCol);

			r = (r+rd) / 2;
			g = (g+gd) / 2;
			b = (b+bd) / 2;

			col = rgb(r, g, b);

			SetPixelV((HDC)hdcDest, xd, yd, col);
			yd++;
		}
		xd++;
		yd = yDest;
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: BitBltAdditive
//
// Parameters: hdcDest- dest dc
//						 xDest, yDest- coords of destination
//						 width, height- dimensions of area, in pixels
//						 hdcSrc- souce dc
//						 xSrc, ySrc- coords to copy from
//						 nPercent- the amount to shade to (-100 
//										to 100 are valid)
//
// Action: BitBlts with additive translucency.
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXBitBltAdditive ( long hdcDest,
																 long xDest,
																 long yDest,
																 long width,
																 long height,
																 long hdcSrc,
																 long xSrc,
																 long ySrc,
																 long nPercent )
{
	int x, y;
	int xd, yd;
	xd = xDest;
	yd = yDest;
	for (x = xSrc; x <= xSrc + width; x++)
	{
		for (y = ySrc; y <= ySrc + height; y++)
		{
			long col = GetPixel((HDC)hdcSrc, x, y);
			long destCol = GetPixel((HDC)hdcDest, xd, yd);

			int r = red(col);
			int g = green(col);
			int b = blue(col);

			int rd = red(destCol);
			int gd = green(destCol);
			int bd = blue(destCol);

			int rr = (int)(nPercent * r / 100.0);
			int gg = (int)(nPercent * g / 100.0);
			int bb = (int)(nPercent * b / 100.0);

			r = (rr+rd);
			g = (gg+gd);
			b = (bb+bd);

			col = rgb(r, g, b);

			SetPixelV((HDC)hdcDest, xd, yd, col);
			yd++;
		}
		xd++;
		yd = yDest;
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXClearTileCache
//
// Parameters: 
//
// Action: Clear the cache of tiles we have in memory
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY GFXClearTileCache()
{
	for (int i = 0; i < gvTiles.size(); i++)
	{
		CTile* t = gvTiles[i];
		delete t;
		gvTiles[i] = 0;
	}
	gvTiles.clear();
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: GFXGetDOSColor
//
// Parameters: 
//
// Action: Obtain DOS color from palette
//
// Returns: color
//
///////////////////////////////////////////////////////
long APIENTRY GFXGetDOSColor( int nColorIdx )
{
	return CTile::getDOSColor(nColorIdx);
}

/* end of file */
