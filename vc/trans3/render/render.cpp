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

/*
 * Definitions.
 */
#define CLASS_NAME "TK Window"

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
CGDICanvas *g_cnvRpgCode = NULL;			// RPGCode canvas.
CGDICanvas *g_cnvMessageWindow = NULL;		// RPGCode message window.
CGDICanvas *g_cnvCursor = NULL;				// Cursor used on maps &c.
bool g_bShowMessageWindow = false;			// Show the message window?
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
		g_pDirectDraw->DrawCanvasTranslucent(g_cnvMessageWindow, (g_tilesX * 32.0 - 600.0) * 0.5, 0, 0.5, g_color, -1);
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
			  CGDICanvas *cnv, 
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
				   CGDICanvas *cnv,
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
bool drawTileCnv(CGDICanvas *cnv, 
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
 * Draw a board.
 *
 * brd			- board to draw.
 * cnv			- target surface.
 * destX, destY	- destination canvas co-ordinates.
 * layer		- layer to draw.
 * topX, topY	- tile co-ordinates to begin drawing at.
 * tilesX, 
 * tilesY		- width, height to draw, in tiles.
 * aR,aG,aB		- ambient rgb.
 * bIsometric	- is board isometric?
 */
void drawBoard(CONST LPBOARD brd, 
			   CGDICanvas *cnv,
			   const int destX, const int destY,
			   const int layer, 
			   const int topX, const int topY, 
			   const int tilesX, const int tilesY, 
			   const int aR, const int aG, const int aB, 
			   const bool bIsometric)
{

	// Is it an even or odd tile?
	const int nIsoEvenOdd = !(topY % 2);

	// Record top and bottom layers
	const int nLower = layer ? layer : 1;
	const int nUpper = layer ? layer : brd->bSizeL;

	// Calculate width and height
	const int nWidth = (tilesX + topX > brd->bSizeX) ? brd->bSizeX - topX : tilesX;
	const int nHeight = (tilesY + topY > brd->bSizeY) ? brd->bSizeY - topY : tilesY;

	// For each layer
	for (unsigned int i = nLower; i <= nUpper; ++i)
	{

		// For the x axis
		for (unsigned int j = 1; j <= nWidth; ++j)
		{

			// For the y axis
			for (unsigned int k = 1; k <= nHeight; ++k)
			{

				// The tile co-ordinates.
				const int x = j + topX, y = k + topY;
				
				if (brd->board[x][y][i])
				{
					const std::string strTile = brd->tileIndex[brd->board[x][y][i]];
					if (!strTile.empty())
					{
						// Tile exists at this location.
						drawTile(strTile, 
								 j, k, 
								 brd->ambientRed[x][y][i] + aR,
								 brd->ambientGreen[x][y][i] + aG,
								 brd->ambientBlue[x][y][i] + aB,
								 cnv, 
								 destX, destY,
								 bIsometric, 
								 nIsoEvenOdd);

					} // if (!strTile.empty())

				} // if (brd.board[x][y][i])

			} // for k

		} // for j

	} // for i

}

/*
 * Create global canvases.
 */
void createCanvases(void)
{
	g_cnvRpgCode = new CGDICanvas();
	g_cnvRpgCode->CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_cnvRpgCode->ClearScreen(0);

	g_cnvMessageWindow = new CGDICanvas();
	g_cnvMessageWindow->CreateBlank(NULL, 600, 100, TRUE);

	// Create sprite cache.
	extern std::vector<ANIMATION_FRAME> g_anmCache;
	g_anmCache.clear();
//	g_anmCache.reserve(128);

	RECT rect = {0, 0, g_resX * 2, g_resY * 2};
	g_scrollCache.pCnv = new CGDICanvas();
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

		// Align to player.
		g_pSelectedPlayer->alignBoard(r, false);

		// Align to the grid.
		r.left -= r.left % 32;
		r.top -= r.top % 32;
		r.right = r.left + g_resX * 2;
		r.bottom = r.top + g_resY * 2;

		pCnv->ClearScreen(TRANSP_COLOR);

		// Draw all layers to the canvas.
		drawBoard(g_pBoard, 
				  pCnv, 
				  0, 0, 0,
				  int(r.left / 32), 
				  int(r.top / 32), 
				  int((r.right - r.left) / 32), 
				  int((r.bottom - r.top) / 32), 
				  0, 0, 0, false); 
	}
}

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
bool renderNow(CGDICanvas *cnv, const bool bForce)
{
	extern ZO_VECTOR g_sprites;
	extern LPBOARD g_pBoard;

	const bool bScreen = (cnv == NULL);
	if (!cnv) cnv = g_pDirectDraw->getBackBuffer();

	cnv->ClearScreen(g_pBoard->brdColor);

	// Check if we need to re-render the scroll cache.
	g_scrollCache.render(false);
	
	std::vector<RECT> rects;		// Set of RECTs covering the sprites.
	RECT r = {0, 0, 0, 0};			// Multipurpose RECT.
	rects.push_back(r);

	// Draw flattened layers.
	g_scrollCache.pCnv->BltTransparentPart(cnv, 
								g_scrollCache.r.left - g_screen.left,
								g_scrollCache.r.top - g_screen.top,
								0, 0, 
								g_scrollCache.r.right - g_scrollCache.r.left, 
								g_scrollCache.r.bottom - g_scrollCache.r.top,
								TRANSP_COLOR);

	for (int layer = 1; layer <= g_pBoard->bSizeL; ++layer)
	{
		for (std::vector<RECT>::iterator i = rects.begin(); i != rects.end(); ++i)
		{
			if (i->right)
			{
				// If this rect is occupied, draw all the tiles on this layer
				// it totally or partially contains, covering the sprite.
				drawBoard(g_pBoard,
						  cnv,
						  i->left - (i->left % 32) - g_screen.left,
						  i->top - (i->top % 32) - g_screen.top,
						  layer,
						  int(i->left / 32),
						  int(i->top / 32),
						  int((i->right - i->left) / 32 + 1),
						  int((i->bottom - i->top) / 32 + 1),
						  0, 0, 0, false);
			}
		}

		// z-ordered players and items.
		for (std::vector<CSprite *>::iterator j = g_sprites.v.begin(); j != g_sprites.v.end(); ++j)
		{
			if ((*j)->putSpriteAt(cnv, layer, rects.back()))
			{
				// Sprite is on this layer and has been drawn.
				// Store this area, and draw the tiles of the next
				// layer on this one.
				rects.push_back(r);
			}
		}

		// Draw the "under" tiles for this layer over any sprites below.
		for (std::vector<BRD_VECTOR>::iterator m = g_pBoard->vectors.begin(); m != g_pBoard->vectors.end(); ++m)
		{
			// Check if this is an "under" vector, is on the same layer and has a canvas.
			if (!m->pCnv || m->layer != layer || !(m->type & TT_UNDER)) 
				continue;

			// Loop over the rects (the areas occupied by sprites) and
			// draw the vector's canvas over any intersecting areas.
			for (std::vector<RECT>::iterator i = rects.begin(); i != rects.end(); ++i)
			{
				RECT rBounds = m->pV->getBounds(), rect = {0, 0, 0, 0};

				// Place the intersection in rect.
				if (IntersectRect(&rect, i, &rBounds))
				{
					m->pCnv->BltTransparentPart(cnv, 
								rect.left - g_screen.left,
								rect.top - g_screen.top,
								rect.left - rBounds.left, 
								rect.top - rBounds.top, 
								rect.right - rect.left, 
								rect.bottom - rect.top,
								TRANSP_COLOR);
				}
			}
		}


	} // for (layer)

	// Temporary: draw vectors for debugging.
	/** cnv->Lock();
	for (std::vector<CSprite *>::iterator a = g_sprites.v.begin(); a != g_sprites.v.end(); ++a)
	{
		(*a)->drawVector(cnv);
	}
	for (std::vector<LPBRD_PROGRAM>::iterator c = g_pBoard->programs.begin(); c != g_pBoard->programs.end(); ++c)
	{
		(*c)->vBase.draw(16777215, true, g_screen.left, g_screen.top, cnv);
	}
	for (std::vector<BRD_VECTOR>::iterator d = g_pBoard->vectors.begin(); d != g_pBoard->vectors.end(); ++d)
	{
		d->pV->draw(16777215, true, g_screen.left, g_screen.top, cnv);
	}
	cnv->Unlock(); **/

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
