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

#define CLASS_NAME _T("TK Window")

// Uncomment to show debug vectors.
#define DEBUG_VECTORS

/*
 * Globals.
 */
CDirectDraw *g_pDirectDraw = NULL;			// Access to DirectDraw.
HWND g_hHostWnd = NULL;						// Handle to the host window.
int g_resX = 0, g_resY = 0;					// Size of screen.

CCanvas *g_cnvRpgCode = NULL;				// RPGCode canvas.
CCanvas *g_cnvMessageWindow = NULL;			// RPGCode message window.
CCanvas *g_cnvCursor = NULL;				// Cursor used on maps &c.
std::vector<CCanvas *> g_cnvRpgScreens;		// SaveScreen() array.
std::vector<CCanvas *> g_cnvRpgScans;		// Scan() array...

bool g_bShowMessageWindow = false;			// Show the message window?
double g_messageWindowTranslucency = 0.5;	// Message window translucency.
double g_translucentOpacity = 0.4;			// Opacity to draw translucent sprites at.

RECT g_screen = {0, 0, 0, 0};				// = {g_topX, g_topY, g_resX + g_topX, g_resY + g_topY}
SCROLL_CACHE g_scrollCache;					// The scroll cache.

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen()
{
	g_pDirectDraw->DrawCanvas(g_cnvRpgCode, 0, 0);
	if (g_bShowMessageWindow)
	{
		extern COLORREF g_color;
		if (g_messageWindowTranslucency != 1.0)
		{
			g_pDirectDraw->DrawCanvasTranslucent(g_cnvMessageWindow, (g_resX - 600.0) * 0.5, 0, g_messageWindowTranslucency, g_color, -1);
		}
		else
		{
			g_pDirectDraw->DrawCanvas(g_cnvMessageWindow, (g_resX - 600.0) * 0.5, 0);
		}
	}
	g_pDirectDraw->Refresh();
}

/*
 * Draw a tile onto a canvas (CommonTkGfx drawTileCnv)
 */
bool drawTileCnv(CCanvas *cnv, 
				 const STRING file, 
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
	extern STRING g_projectPath;

    TILEANIM anm;
   
    if (removePath(file).empty()) return false;
    
	int tileSizeX = 1;		// Width of tbm(or other) in tiles, for ISO_ROTATED.
	int iso = (bIsometric ? 1 : 0);
	int isoEO = (isoEvenOdd ? 0 : 1);

//    if (pakFileRunning)
	if (false)
	{
        // Do check for pakfile system
		STRING of = file, Temp = removePath(file);
		STRING ex = parser::uppercase(getExtension(Temp));
        if (ex.substr(0, 3) == _T("TST"))
		{
            // numof = getTileNum(temp$)
//            Temp = util::tilesetFilename(Temp);
        }
//			file = PakLocate(TILE_PATH + Temp);
		STRING ff = _T("");
        if (ex == _T("TAN"))
		{
            ff = removePath(Temp);
            anm.open(g_projectPath + TILE_PATH + ff);
//                file = TileAnmGet(anm, 0);
		}
    
//        _chdir (PakTempPath);
        ff = removePath(of);
		if (!bMask)
		{
			CTile::drawByBoardCoord(
				g_projectPath + TILE_PATH + ff,
				x, y,
				r, g, b,
				cnv,
				TM_NONE,
				0, 0,
				COORD_TYPE(iso),
				tileSizeX,		// Width of tbm(or other) in tiles, for ISO_ROTATED.
				isoEO
			);
		}
		else
		{
			CTile::drawByBoardCoord(
				g_projectPath + TILE_PATH + ff,
				x, y,
				r, g, b,
				cnv, 
				bNonTransparentMask ? TM_COPY : TM_AND,
				0, 0,
				COORD_TYPE(iso),
				tileSizeX,		// Width of tbm(or other) in tiles, for ISO_ROTATED.
				isoEO
			);
		}
//		_chdir (currentDir$);

	}
	else
	{
		STRING ex = getExtension(file);
		STRING ff = removePath(file);
        if (parser::uppercase(ex) == _T("TAN"))
		{
            if (!anm.open(g_projectPath + TILE_PATH + ff)) return false;
//            file$ = projectPath & tilePath & TileAnmGet(anm, 0)
        }
//        _chdir(g_projectPath);
        ff = removePath(file);
		if (!bMask)
		{
			CTile::drawByBoardCoord(
				g_projectPath + TILE_PATH + ff,
				x, y,
				r, g, b,
				cnv,
				TM_NONE,
				0, 0,
				COORD_TYPE(iso),
				tileSizeX,		// Width of tbm(or other) in tiles, for ISO_ROTATED.
				isoEO
			);
		}
		else
		{
			CTile::drawByBoardCoord(
				g_projectPath + TILE_PATH + ff,
				x, y,
				r, g, b,
				cnv, 
				bNonTransparentMask ? TM_COPY : TM_AND,
				0, 0,
				COORD_TYPE(iso),
				tileSizeX,		// Width of tbm(or other) in tiles, for ISO_ROTATED.
				isoEO
			);
		}
//        _chdir(WORKING_DIRECTOY);
    }
	return true;
}

/*
 * Create global canvases.
 */
void createCanvases()
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

	g_scrollCache.createCanvas(g_resX * 2, g_resY * 2);

	g_cnvCursor = new CCanvas();
	g_cnvCursor->CreateBlank(NULL, 32, 32, TRUE);
	{
		const HDC hdc = g_cnvCursor->OpenDC();
		const HDC compat = CreateCompatibleDC(hdc);
		extern HINSTANCE g_hInstance;
		HBITMAP bmp = LoadBitmap(g_hInstance, MAKEINTRESOURCE(IDB_BITMAP1));
		HGDIOBJ obj = SelectObject(compat, bmp);
		BitBlt(hdc, 0, 0, 32, 32, compat, 0, 0, SRCCOPY);
		g_cnvCursor->CloseDC(hdc);
		SelectObject(compat, obj);
		DeleteObject(bmp);
		DeleteDC(compat);
	}
}

/*
 * Destroy global canvases.
 */
void destroyCanvases()
{
	delete g_cnvRpgCode;
	delete g_cnvMessageWindow;
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
void changeCursor(const STRING strCursor)
{
	if (strCursor.empty()) return;
	if (!g_hHostWnd) return;
	extern MAIN_FILE g_mainFile;

	const HDC hHostDc = GetDC(g_hHostWnd);
	const HDC hColorDc = CreateCompatibleDC(hHostDc);

	HBITMAP hColorBmp = NULL;

	// Draw the cursor.
	if (strCursor == _T("TK DEFAULT"))
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
		extern STRING g_projectPath;
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
				MessageBox(NULL, _T("Error initializing graphics mode. Make sure you have DirectX 8 or higher installed."), _T("Cannot Initialize"), 0);
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

	extern void initInput();
	initInput();

	createCanvases();

}

/*
 * Check and render the scrollcache.
 */
void tagScrollCache::render(const bool bForceRedraw)
{
	extern LPBOARD g_pBoard;
	extern CPlayer *g_pSelectedPlayer;

	// Reduce cache size if the board is smaller than the maximum.
	if (bForceRedraw)
	{
		const int w = (g_pBoard->pxWidth() < maxWidth ? g_pBoard->pxWidth() : maxWidth);
		const int h = (g_pBoard->pxHeight() < maxHeight ? g_pBoard->pxHeight() : maxHeight);
		if (w != cnv.GetWidth() || h != cnv.GetHeight())
		{
			cnv.Resize(NULL, w, h);
		}
		r.left = r.top = 0;
		r.right = w;
		r.bottom = h;
	}

	if ((g_screen.left >= 0 && g_screen.left < r.left) || 
		(g_screen.top >= 0 && g_screen.top < r.top) ||
		(g_screen.left >= 0 && g_screen.right > r.right) ||	
		(g_screen.top >= 0 && g_screen.bottom > r.bottom) ||
		bForceRedraw)
	{
		// The screen is off the scrollcache area.
		// (>= 0 for caches smaller than the screen.)
		const int width = r.right - r.left, height = r.bottom - r.top;

		// Align to player.
		g_pSelectedPlayer->alignBoard(r, true);

		// Align to the grid (always % 32 on r.left).
		r.left -= r.left % 32;
		r.top -= r.top % (g_pBoard->isIsometric() ? 16 : 32);
		r.right = r.left + width;
		r.bottom = r.top + height;

		cnv.ClearScreen(TRANSP_COLOR);

		g_pBoard->render(&cnv, 
				  0, 0, 
				  1, g_pBoard->bSizeL,
				  r.left, 
				  r.top, 
				  width, 
				  height, 
				  0, 0, 0); 

#ifdef DEBUG_VECTORS
		// Draw program and tile vectors.
		cnv.Lock();
		for (std::vector<LPBRD_PROGRAM>::iterator b = g_pBoard->programs.begin(); b != g_pBoard->programs.end(); ++b)
		{
			(*b)->vBase.draw(RGB(255, 255, 0), true, r.left, r.top, &cnv);
		}
		for (std::vector<BRD_VECTOR>::iterator c = g_pBoard->vectors.begin(); c != g_pBoard->vectors.end(); ++c)
		{
			int color = c->type == TT_SOLID ? RGB(255, 255, 255) : RGB(0, 255, 0);
			c->pV->draw(color, true, r.left, r.top, &cnv);
		}
		cnv.Unlock();
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
	extern CPlayer *g_pSelectedPlayer;

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
		g_scrollCache.cnv.BltTransparentPart(cnv, 
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
			// rects are the sprite frames located on the board,
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
			if ((*j)->render(cnv, layer, rect))
			{
				// Sprite is on this layer and has been drawn.
				// Store this area for tiles on higher layers.
				rects.push_back(rect);
			}
			else continue;

			// Get the sprite's vector base to test for collisions with the under vector.
			CVector v = (*j)->getVectorBase();
			RECT sr = v.getBounds();

			// Draw any "under" vectors this sprite is standing on.
			for (std::vector<BRD_VECTOR>::iterator k = g_pBoard->vectors.begin(); k != g_pBoard->vectors.end(); ++k)
			{
				// Check if this is an "under" vector, is on the same layer and has a canvas.
				if (!k->pCnv || k->layer != layer || !(k->type & TT_UNDER)) 
					continue;

				// Under vector's bounds.
				const RECT rBounds = k->pV->getBounds();

				RECT r = {0, 0, 0, 0};
				DB_POINT p = {0, 0};

				// Place the intersection of the sprite's *frame* and the under vector's
				// bounds in 'r' - this is the area to draw.
				if (IntersectRect(&r, &rect, &rBounds))
				{
					// If the under tile is "simple rect" intersection draw straight
					// off, else check for vector collision.
					if(((k->attributes & TA_RECT_INTERSECT) && IntersectRect(&sr, &sr, &rBounds))
						|| k->pV->contains(v, p))
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
				}
			} // for (under tile canvases)

		} // for (sprites)

	} // for (layer)

	// Render multitasking animations.
	CThreadAnimation::renderAll(cnv);


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
void initGraphics()
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
void clearTileCache()
{
	CTile::clearTileCache();
	clearAnmCache();
}

/*
 * Shut down the graphics engine.
 */
void closeGraphics()
{
	extern HINSTANCE g_hInstance;

	clearTileCache();
	destroyCanvases();
	delete g_pDirectDraw;

	DestroyWindow(g_hHostWnd);
	UnregisterClass(CLASS_NAME, g_hInstance);
}
