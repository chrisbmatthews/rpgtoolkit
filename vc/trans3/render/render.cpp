/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "render.h"
#include "../rpgcode/parser/parser.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/CVector/CVector.h"
#include "../common/animation.h"
#include "../common/mainfile.h"
#include "../common/paths.h"
#include "../common/board.h"
#include "../input/input.h"
#include "../resource.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <vector>

#define CLASS_NAME "TK Window"

// Uncomment to show debug vectors.
#define DEBUG_VECTORS

/*
 * Globals.
 */
CDirectDraw *g_pDirectDraw = NULL;			// Access to DirectDraw.
HWND g_hHostWnd = NULL;						// Handle to the host window.
int g_resX = 0, g_resY = 0;					// Size of screen.
double g_tilesX = 0, g_tilesY = 0;			// Size of screen in tiles.
double g_isoTilesX = 0, g_isoTilesY = 0;	// Size of screen in isometric tiles.
double g_topX = 0, g_topY = 0;				// Offset of a scrolled board.
double scTopX = 0.0;						// Horizonal offset of the scroll cache
double scTopY = 0.0;						// Vertical offset of the scroll cache
int scTilesX = 0;							// Maximum scroll cache capacity, on width
int scTilesY = 0;							// Maximum scroll cache capacity, on height
std::vector<CTile *> g_tiles;				// Cache of tiles.

CCanvas *g_cnvRpgCode = NULL;			// RPGCode canvas.
CCanvas *g_cnvMessageWindow = NULL;		// RPGCode message window.
CCanvas *g_cnvCursor = NULL;				// Cursor used on maps &c.
std::vector<CCanvas *> g_cnvRpgScreens;	// SaveScreen() array.
std::vector<CCanvas *> g_cnvRpgScans;	// Scan() array...

bool g_bShowMessageWindow = false;			// Show the message window?
double g_messageWindowTranslucency = 0.5;	// Message window translucency.
double g_translucentOpacity = 0.30;			// Opacity to draw translucent sprites at.

RECT g_screen = {0, 0, 0, 0};				// = {g_topX, g_topY, g_resX + g_topX, g_resY + g_topY}
SCROLL_CACHE g_scrollCache;					// The scroll cache.

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen(void)
{
	g_pDirectDraw->DrawCanvas(g_cnvRpgCode, 0, 0);
	if (g_bShowMessageWindow)
	{
		extern COLORREF g_color;
		if (g_messageWindowTranslucency != 1.0)
		{
			g_pDirectDraw->DrawCanvasTranslucent(g_cnvMessageWindow, (g_tilesX * 32.0 - 600.0) * 0.5, 0, g_messageWindowTranslucency, g_color, -1);
		}
		else
		{
			g_pDirectDraw->DrawCanvas(g_cnvMessageWindow, (g_tilesX * 32.0 - 600.0) * 0.5, 0);
		}
	}
	g_pDirectDraw->Refresh();
}

/*
 * Draw a tile. (GFXDrawTileCNV)
 *
 * fileName		- tile to draw.
 * x, y			- tile co-ordinates to draw.
 * r, g, b		- shade.
 * cnv			- destination canvas.
 * offX, offY	- canvas offset.
 * bIsometric	- draw isometrically?
 * nIsoEvenOdd	- iso is even or odd?
 */
bool drawTile(const std::string fileName, 
			  const int x, const int y, 
			  const int r, const int g, const int b, 
			  CCanvas *cnv, 
			  const int offX, const int offY, 
			  const BOOL bIsometric, 
			  const int nIsoEvenOdd)
{

	extern std::string g_projectPath;

	int xx = 0, yy = 0;

	if (!bIsometric)
	{
		xx = x * 32 - 32;
		yy = y * 32 - 32;
	}
	else
	{
		xx = x * 64 - (nIsoEvenOdd == (y % 2) ? 64 : 96);
		yy = y * 16 - 32;
	}

	xx += offX;
	yy += offY;

/*
	// See if we need to clear the tile cache
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();
*/
	const RGBSHADE rgb = {r, g, b};
	const std::string strFileName = g_projectPath + TILE_PATH + fileName;

	for (std::vector<CTile *>::iterator i = g_tiles.begin(); i != g_tiles.end(); ++i)
	{
		const std::string strVect = (*i)->getFilename();
		if (strVect.compare(strFileName) == 0)
		{
			if ((*i)->isShadedAs(rgb, SHADE_UNIFORM))
			{
				if (bIsometric == (*i)->isIsometric())
				{
					// Found a match.
					(*i)->cnvDraw(cnv, xx, yy);
					return true;
				}
			}
		}
	} // for (i)

	// Load the tile.
	CTile *const pTile = new CTile(NULL, strFileName, rgb, SHADE_UNIFORM, bIsometric);

	// Push it into the vector.
	g_tiles.push_back(pTile);

	// Draw the tile.
	pTile->cnvDraw(cnv, xx, yy);
	return true;
}


/*
 * Draw a tile mask. (GFXDrawTileMaskCNV)
 *
 * fileName (in) - tile to draw
 * x (in) - board x coordinate to draw at
 * y (in) - board y coordinate to draw at
 * r (in) - red shade
 * g (in) - green shade
 * b (in) - blue shade
 * cnv (in) - destination canvas
 * nDirectBlt - 0: rendered directly (with transparency).
 *				1: blitted.
 * bIsometric (in) - draw isometrically?
 * nIsoEvenOdd (in) - iso is even or odd?
 */
bool drawTileMask (const std::string fileName, 
				   const int x, const int y, 
				   const int r, const int g, const int b, 
				   CCanvas *cnv,
				   const int nDirectBlt,
				   const BOOL bIsometric,
				   const int nIsoEvenOdd) 
{
	extern std::string g_projectPath;

	int xx = 0, yy = 0;

	if (!bIsometric)
	{
		xx = x * 32 - 32;
		yy = y * 32 - 32;
	}
	else
	{
		if (!nIsoEvenOdd)
		{
			if (!(y % 2))
			{
				xx = x * 64 - 64;
				yy = y * 16 - 32;
			}
			else
			{
				xx = x * 64 - 96;
				yy = y * 16 - 32;
			}
		}
		else
		{
			if (!(y % 2))
			{
				xx = x * 64 - 96;
				yy = y * 16 - 32;
			}
			else
			{
				xx = x * 64 - 64;
				yy = y * 16 - 32;
			}
		}
	}
/*
	//see if we need to clear the tile cache...
	if (gvTiles.size() > TILE_CACHE_SIZE)
		GFXClearTileCache();
*/

	const RGBSHADE rgb = {r, g, b};
	const std::string strFileName = g_projectPath + TILE_PATH + fileName;

	// Check if this tile has already been drawn.
	for (std::vector<CTile*>::iterator i = g_tiles.begin(); i != g_tiles.end(); i++)
	{
		const std::string strVect = (*i)->getFilename();
		if (strVect.compare(strFileName) == 0)
		{
			if (bIsometric)
			{
				if ((*i)->isIsometric())
				{
					// Found a match.
					if (nDirectBlt)
					{
						(*i)->cnvDrawAlpha(cnv, xx, yy);
					}
					else
					{
						(*i)->cnvRenderAlpha(cnv, xx, yy);
					}
					return true;
				}
			}
			else
			{
				if (!(*i)->isIsometric())
				{
					// Found a match.
					if (nDirectBlt)
					{
						(*i)->cnvDrawAlpha(cnv, xx, yy);
					}
					else
					{
						(*i)->cnvRenderAlpha(cnv, xx, yy);
					}
					return true;
				}
			}
		}
	} // for (i)

	// Load the tile.
	CTile *const pTile = new CTile(NULL, strFileName, rgb, SHADE_UNIFORM, bIsometric);

	// Push it into the vector.
	g_tiles.push_back(pTile);

	if (nDirectBlt)
	{
		pTile->cnvDrawAlpha(cnv, xx, yy);
	}
	else
	{
		pTile->cnvRenderAlpha(cnv, xx, yy);
	}
	return true;
}

/*
 * Draw a tile onto a canvas (CommonTkGfx drawTileCnv)
 */
bool drawTileCnv(CCanvas *cnv, 
				 const std::string file, 
				 const double x,
				 const double y, 
				 const int r, 
				 const int g,
				 const int b, 
				 const bool bMask, 
				 const bool bNonTransparentMask, 
				 const bool bIsometric, 
				 const bool isoEvenOdd)
{
	extern std::string g_projectPath;

    TILEANIM anm;
   
    if (removePath(file).empty()) return false;
    
	int iso = (bIsometric ? 1 : 0);
	int isoEO = (isoEvenOdd ? 0 : 1);

//    if (pakFileRunning)
	if (false)
	{
        // Do check for pakfile system
		std::string of = file, Temp = removePath(file);
		std::string ex = parser::uppercase(getExtension(Temp));
        if (ex.substr(0, 3) == "TST")
		{
            // numof = getTileNum(temp$)
//            Temp = util::tilesetFilename(Temp);
        }
//			file = PakLocate(TILE_PATH + Temp);
		std::string ff = "";
        if (ex == "TAN")
		{
            ff = removePath(Temp);
            anm.open(g_projectPath + TILE_PATH + ff);
//                file = TileAnmGet(anm, 0);
		}
    
//        _chdir (PakTempPath);
        ff = removePath(of);
		if (!bMask)
		{
			drawTile(ff, x, y, r, g, b, cnv, 0, 0, iso, isoEO);
		}
		else
		{
			if (bNonTransparentMask)
			{
				drawTileMask(ff, x, y, r, g, b, cnv, 1, iso, isoEO);
			} 
			else 
			{
				drawTileMask(ff, x, y, r, g, b, cnv, 0, iso, isoEO);
			}
		}
//		_chdir (currentDir$);

	}
	else
	{
		std::string ex = getExtension(file);
		std::string ff = removePath(file);
        if (parser::uppercase(ex) == "TAN")
		{
            if (!anm.open(g_projectPath + TILE_PATH + ff)) return false;
//            file$ = projectPath & tilePath & TileAnmGet(anm, 0)
        }
//        _chdir(g_projectPath);
        ff = removePath(file);
        if (!bMask)
		{
            drawTile(ff, x, y, r, g, b, cnv, 0, 0, iso, isoEO);
		}
        else
		{
            if (bNonTransparentMask)
			{
                drawTileMask(ff, x, y, r, g, b, cnv, 1, iso, isoEO);
            } 
			else 
			{
                drawTileMask(ff, x, y, r, g, b, cnv, 0, iso, isoEO);
			}
        }
//        _chdir(WORKING_DIRECTOY);
    }
	return true;
}

/*
 * Create global canvases.
 */
void createCanvases(void)
{
	g_cnvRpgCode = new CCanvas();
	g_cnvRpgCode->CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_cnvRpgCode->ClearScreen(0);

	g_cnvMessageWindow = new CCanvas();
	g_cnvMessageWindow->CreateBlank(NULL, 600, 100, TRUE);

	// Create sprite cache.
	extern std::vector<ANIMATION_FRAME> g_anmCache;
	g_anmCache.clear();
//	g_anmCache.reserve(128);

	RECT rect = {0, 0, g_resX * 2, g_resY * 2};
	g_scrollCache.pCnv = new CCanvas();
	g_scrollCache.pCnv->CreateBlank(NULL, rect.right, rect.bottom, TRUE);
	g_scrollCache.pCnv->ClearScreen(0);
	g_scrollCache.r = rect;

}

/*
 * Destroy global canvases.
 */
void destroyCanvases(void)
{
	delete g_cnvRpgCode;
	delete g_cnvMessageWindow;
	delete g_scrollCache.pCnv;
	delete g_cnvCursor;

	std::vector<CCanvas *>::iterator i = g_cnvRpgScreens.begin();
	for (; i != g_cnvRpgScreens.end(); ++i)
	{
		delete *i;
	}
	i = g_cnvRpgScans.begin();
	for (; i != g_cnvRpgScans.end(); ++i)
	{
		delete *i;
	}
}

/*
 * Load a cursor from a file.
 */
void changeCursor(const std::string strCursor)
{
	if (strCursor.empty()) return;
	if (!g_hHostWnd) return;
	extern MAIN_FILE g_mainFile;

	const HDC hHostDc = GetDC(g_hHostWnd);
	const HDC hColorDc = CreateCompatibleDC(hHostDc);

	HBITMAP hColorBmp = NULL;

	// Draw the cursor.
	if (strCursor == "TK DEFAULT")
	{
		extern HINSTANCE g_hInstance;
		hColorBmp = LoadBitmap(g_hInstance, MAKEINTRESOURCE(IDB_BITMAP2));
		SelectObject(hColorDc, hColorBmp);

		g_mainFile.transpColor = RGB(255, 0, 0);
		g_mainFile.hotSpotX = g_mainFile.hotSpotY = 0;
	}
	else
	{
		hColorBmp = CreateCompatibleBitmap(hHostDc, 32, 32);
		SelectObject(hColorDc, hColorBmp);
		SetStretchBltMode(hColorDc, COLORONCOLOR);
		extern std::string g_projectPath;
		drawImage(g_projectPath + BMP_PATH + strCursor, hColorDc, 0, 0, 32, 32);
	}

	const HDC hMaskDc = CreateCompatibleDC(hHostDc);
	const HBITMAP hMaskBmp = CreateBitmap(32, 32, 1, 1, NULL);
	SelectObject(hMaskDc, hMaskBmp);

	// Create a mask for the cursor.
	SetBkColor(hColorDc, g_mainFile.transpColor);
	BitBlt(hMaskDc, 0, 0, 32, 32, hColorDc, 0, 0, SRCCOPY);
	BitBlt(hColorDc, 0, 0, 32, 32, hMaskDc, 0, 0, SRCINVERT);

	DeleteDC(hMaskDc);
	DeleteDC(hColorDc);
	ReleaseDC(g_hHostWnd, hHostDc);

	ICONINFO cursor = {FALSE, g_mainFile.hotSpotX, g_mainFile.hotSpotY, hMaskBmp, hColorBmp};
	HCURSOR hCursor = CreateIconIndirect(&cursor);
	SetClassLong(g_hHostWnd, GCL_HCURSOR, LONG(hCursor));
	DestroyIcon(hCursor);

	DeleteObject(hColorBmp);
	DeleteObject(hMaskBmp);
}

/*
 * Show the host window.
 *
 * width (in) - width of window
 * height (in) - height of window
 */
void showScreen(const int width, const int height)
{

	extern MAIN_FILE g_mainFile;
	extern HINSTANCE g_hInstance;

	g_screen.right = width;
	g_screen.bottom = height;

	g_resX = width;
	g_resY = height;
	g_tilesX = width / 32.0;
	g_tilesY = height / 32.0;
	g_isoTilesX = g_tilesX / 2.0; // = 10.0 (640 res) = 12.5 (800 res)
	g_isoTilesY = g_tilesY * 2.0; // = 30 (640 res) = 36 (800 res)

	// Create a windows class.
	CONST WNDCLASSEX wnd = {
		sizeof(WNDCLASSEX),
		CS_OWNDC,
		eventProcessor,
		NULL,
		NULL,
		g_hInstance,
		NULL,
		NULL,
		HBRUSH(GetStockObject(BLACK_BRUSH)),
		NULL,
		CLASS_NAME,
		NULL
	};

	// Register the class so windows knows of its existence.
	RegisterClassEx(&wnd);

	// Create the window.
	g_hHostWnd = CreateWindowEx(
		NULL,
		CLASS_NAME,
		g_mainFile.gameTitle.c_str(),
		g_mainFile.extendToFullScreen ? WS_POPUP : (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX),
		(GetSystemMetrics(SM_CXSCREEN) - width) / 2,
		(GetSystemMetrics(SM_CYSCREEN) - height) / 2,
		width + GetSystemMetrics(SM_CXFIXEDFRAME),
		height + GetSystemMetrics(SM_CYFIXEDFRAME) + GetSystemMetrics(SM_CYSIZE),
		NULL, NULL,
		g_hInstance,
		NULL
	);

	changeCursor(g_mainFile.mouseCursor);

	int depth = 16 + g_mainFile.colorDepth * 8;
	g_pDirectDraw = new CDirectDraw();
	while (!g_pDirectDraw->InitGraphicsMode(g_hHostWnd, width, height, depth, g_mainFile.extendToFullScreen))
	{
		if (depth == 16)
		{
			if (!g_mainFile.extendToFullScreen)
			{
				MessageBox(NULL, "Error initializing graphics mode. Make sure you have DirectX 8 or higher installed.", "Cannot Initialize", 0);
				delete g_pDirectDraw;
				exit(EXIT_SUCCESS);
			}
			else
			{
				g_mainFile.extendToFullScreen = FALSE;
			}
		}
		else
		{
			depth -= 8;
		}
	}

	ShowWindow(g_hHostWnd, SW_SHOW);
	g_pDirectDraw->Refresh();

	extern void initInput(void);
	initInput();

	createCanvases();

}

/*
 * Check and render the scrollcache.
 */
void tagScrollCache::render(const bool bForceRedraw)
{
	extern LPBOARD g_pBoard;
	extern CSprite *g_pSelectedPlayer;

	if (g_screen.left < r.left || g_screen.top < r.top ||
		g_screen.right > r.right ||	g_screen.bottom > r.bottom ||
		bForceRedraw)
	{
		// The screen is off the scrollcache area.

		const int width = r.right - r.left, height = r.bottom - r.top;

		// Align to player.
		g_pSelectedPlayer->alignBoard(r, true);

		// Align to the grid (always % 32 on r.left).
		r.left -= r.left % 32;
		r.top -= r.top % (g_pBoard->isIsometric() ? 16 : 32);
		r.right = r.left + width;
		r.bottom = r.top + height;

		pCnv->ClearScreen(TRANSP_COLOR);

		g_pBoard->render(pCnv, 
				  0, 0, 
				  1, g_pBoard->bSizeL,
				  r.left, 
				  r.top, 
				  width, 
				  height, 
				  0, 0, 0); 

#ifdef DEBUG_VECTORS
		// Draw program and tile vectors.
		pCnv->Lock();
		for (std::vector<LPBRD_PROGRAM>::iterator b = g_pBoard->programs.begin(); b != g_pBoard->programs.end(); ++b)
		{
			(*b)->vBase.draw(RGB(128, 255, 255), true, r.left, r.top, pCnv);
		}
		for (std::vector<BRD_VECTOR>::iterator c = g_pBoard->vectors.begin(); c != g_pBoard->vectors.end(); ++c)
		{
			int color = c->type == TT_SOLID ? RGB(255, 255, 255) : RGB(255, 128, 128);
			c->pV->draw(color, true, r.left, r.top, pCnv);
		}
		pCnv->Unlock();
#endif
	}
}

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
bool renderNow(CCanvas *cnv, const bool bForce)
{
	extern ZO_VECTOR g_sprites;
	extern LPBOARD g_pBoard;
	extern CSprite *g_pSelectedPlayer;

	const bool bScreen = (cnv == NULL);
	if (!cnv) cnv = g_pDirectDraw->getBackBuffer();

	cnv->ClearScreen(g_pBoard->brdColor);

	// Set of RECTs covering the sprites.
	std::vector<RECT> rects;		

	// Draw the background (parallaxed or otherwise).
	g_pBoard->renderBackground(cnv, g_screen);

	// Render the flattened board if it exists ([0] represents any layer occupied).
	if (g_pBoard->bLayerOccupied[0])
	{
		// Check if we need to re-render the scroll cache.
		g_scrollCache.render(false);

		// Draw flattened layers.
		g_scrollCache.pCnv->BltTransparentPart(cnv, 
									g_scrollCache.r.left - g_screen.left,
									g_scrollCache.r.top - g_screen.top,
									0, 0, 
									g_scrollCache.r.right - g_scrollCache.r.left, 
									g_scrollCache.r.bottom - g_scrollCache.r.top,
									TRANSP_COLOR);
	}

	/*
	 * Loop over layers. Draw sprites, recording the portion of their
	 * frame on the screen in a RECT vector. 
	 * Draw any under vectors over sprites that are standing on them.
	 * Draw tiles on higher layers over the sprites: draw tiles directly
	 * rather than using any intermediate canvas.
	 */
	for (int layer = 1; layer <= g_pBoard->bSizeL; ++layer)
	{
		// Draw tiles on higher layers over the sprites.
		if (g_pBoard->bLayerOccupied[layer])
		{
			// 'rects' are the sprite frames located on the board,
			// which are only added when the sprite is encountered in the loop.
			for (std::vector<RECT>::iterator i = rects.begin(); i != rects.end(); ++i)
			{
				// Inflate to align to the grid (iso or 2D).
				const RECT rAlign = {i->left - i->left % 32,
									i->top - i->top % 32,
									i->right - i->right % 32 + 32,
									i->bottom - i->bottom % 32 + 32};

				// If this rect is occupied, draw all the tiles on this layer
				// it totally or partially contains, covering the sprite.
				g_pBoard->render(cnv,
								rAlign.left - g_screen.left,
								rAlign.top - g_screen.top,
								layer, layer,
								rAlign.left, rAlign.top, 
								rAlign.right - rAlign.left, 
								rAlign.bottom - rAlign.top,
								0, 0, 0);
			}
		} // if (g_pBoard->bLayerOccupied[layer])

		// z-ordered players and items.
		for (std::vector<CSprite *>::iterator j = g_sprites.v.begin(); j != g_sprites.v.end(); ++j)
		{
			// Check the sprite's layer and draw if match. Pass back
			// a RECT that is the intersection of the sprite and screen.
			RECT rect = {0, 0, 0, 0};
			if ((*j)->putSpriteAt(cnv, layer, rect))
			{
				// Sprite is on this layer and has been drawn.
				// Store this area for tiles on higher layers.
				rects.push_back(rect);
			}
			else continue;

			// Draw any "under" vectors this sprite is standing on.
			for (std::vector<BRD_VECTOR>::iterator k = g_pBoard->vectors.begin(); k != g_pBoard->vectors.end(); ++k)
			{
				// Check if this is an "under" vector, is on the same layer and has a canvas.
				if (!k->pCnv || k->layer != layer || !(k->type & TT_UNDER)) 
					continue;

				// Get the sprite's vector base to test for collisions with the under vector.
				CVector v = (*j)->getVectorBase();
				// Under vector's bounds.
				const RECT rBounds = k->pV->getBounds();

				RECT r = {0, 0, 0, 0};
				DB_POINT p = {0, 0};

				// Place the intersection of the sprite's *frame* and the under vector's
				// bounds in 'r' - this is the area to draw.
				if (IntersectRect(&r, &rect, &rBounds) && k->pV->contains(v, p))
				{
					k->pCnv->BltTransparentPart(cnv, 
								r.left - g_screen.left,
								r.top - g_screen.top,
								r.left - rBounds.left, 
								r.top - rBounds.top, 
								r.right - r.left, 
								r.bottom - r.top,
								TRANSP_COLOR);
				}
			} // for (under tile canvases)

		} // for (sprites)

	} // for (layer)

	cnv->Lock();

#ifdef DEBUG_VECTORS
	// Draw sprite bases for debugging.
	for (std::vector<CSprite *>::iterator a = g_sprites.v.begin(); a != g_sprites.v.end(); ++a)
	{
		(*a)->drawVector(cnv);
	}
#endif

	// Draw the path the selected player is on.
	g_pSelectedPlayer->drawPath(cnv);

	cnv->Unlock();

	if (bScreen) g_pDirectDraw->Refresh();
	return true;
}

/*
 * Initialize the graphics engine.
 */
void initGraphics(void)
{

	extern MAIN_FILE g_mainFile;

	int width = 0, height = 0;

	switch (g_mainFile.mainResolution)
	{
		case 0:
			width = 640;
			height = 480;
			break;
		case 1:
			width = 800;
			height = 600;
			break;
		case 2:
			width = 1024;
			height = 768;
			break;
		default:
			width = g_mainFile.resX;
			height = g_mainFile.resY;
			break;
	}

	// Show the screen.
	showScreen(width, height);

}

/*
 * Clear the tile cache.
 */
void clearTileCache(void)
{
	for (std::vector<CTile *>::iterator i = g_tiles.begin(); i != g_tiles.end(); ++i)
	{
		delete (*i);
	}
	g_tiles.clear();
	clearAnmCache();
}

/*
 * Shut down the graphics engine.
 */
void closeGraphics(void)
{

	extern HINSTANCE g_hInstance;

	clearTileCache();
	destroyCanvases();
	delete g_pDirectDraw;

	DestroyWindow(g_hHostWnd);
	UnregisterClass(CLASS_NAME, g_hInstance);

}
