/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
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
 */

/*
 * Inclusions.
 */
#include "render.h"
#include "../rpgcode/parser/parser.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/CVector/CVector.h"
#include "../common/CAllocationHeap.h"
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

/*
 * Globals.
 */
CDirectDraw *g_pDirectDraw = NULL;			// Access to DirectDraw.
HWND g_hHostWnd = NULL;						// Handle to the host window.
int g_resX = 0, g_resY = 0;					// Size of screen.

CCanvas *g_cnvRpgCode = NULL;				// RPGCode canvas.
CCanvas *g_cnvCursor = NULL;				// Cursor used on maps &c.
RENDER_OVERLAY g_renderNow;					// The user's overlay canvas.
std::vector<CCanvas *> g_cnvRpgScreens;		// SaveScreen() array.
std::vector<CCanvas *> g_cnvRpgScans;		// Scan() array...

RECT g_screen = {0, 0, 0, 0};				// = {g_topX, g_topY, g_resX + g_topX, g_resY + g_topY}
SCROLL_CACHE g_scrollCache;					// The scroll cache.
AMBIENT_LEVEL g_ambientLevel;
MESSAGE_WINDOW g_mwin;

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen()
{
	g_pDirectDraw->DrawCanvas(g_cnvRpgCode, 0, 0);
	if (g_mwin.visible)
	{
		const int x = (g_resX - g_mwin.width) >> 1;
		if (g_mwin.translucency != 1.0)
		{
			g_pDirectDraw->DrawCanvasTranslucent(g_mwin.cnvBkg, x, 0, g_mwin.translucency, -1, -1);
		}
		else
		{
			g_pDirectDraw->DrawCanvas(g_mwin.cnvBkg, x, 0);
		}
		g_pDirectDraw->DrawCanvasTransparent(g_mwin.cnvText, x, 0, g_mwin.color);
	}
	g_pDirectDraw->Refresh();
}

/*
 * Render the message window background.
 */
void tagMessageWindow::render(void)
{
	if (!bkg.empty())
	{
		drawImage(bkg, cnvBkg, 0, 0, width, height);
	}
	else
	{
		cnvBkg->ClearScreen(color);
	}
}

/*
 * Create message window canvases.
 */
void tagMessageWindow::createCanvases(void)
{
	cnvBkg = new CCanvas();
	cnvBkg->CreateBlank(NULL, width, height, TRUE);

	cnvText = new CCanvas();
	cnvText->CreateBlank(NULL, width, height, TRUE);
}

/*
 * Create global canvases.
 */
void createCanvases()
{
	extern CAllocationHeap<CCanvas> g_canvases;

	g_cnvRpgCode = new CCanvas();
	g_cnvRpgCode->CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_cnvRpgCode->ClearScreen(0);

	g_renderNow.cnv = g_canvases.allocate();
	g_renderNow.cnv->CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_renderNow.cnv->ClearScreen(g_renderNow.transp);

	g_mwin.createCanvases();

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
	// Do not delete g_renderNow.cnv since it is allocated in g_canvases.
	delete g_cnvRpgCode;
	delete g_cnvCursor;
	g_mwin.destroyCanvases();

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
	extern MAIN_FILE g_mainFile;

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

		// Use ForceRedraw to update the vector canvases (e.g. to ensure
		// ambient level changes are applied to under vectors or that
		// tiles placed on the board are added to under vectors.
		g_pBoard->createVectorCanvases();
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

		g_pBoard->render(
			&cnv, 
			0, 0, 
			1, g_pBoard->sizeL,
			r.left, 
			r.top, 
			width, 
			height
		); 

#ifdef DEBUG_VECTORS
		if (g_mainFile.drawVectors & CV_DRAW_BRD_VECTORS)
		{
			// Draw program and tile vectors.
			cnv.Lock();

			for (std::vector<LPBRD_PROGRAM>::iterator b = g_pBoard->programs.begin(); b != g_pBoard->programs.end(); ++b)
			{
				if (*b) (*b)->vBase.draw(RGB(255, 255, 0), true, r.left, r.top, &cnv);
			}

			for (std::vector<BRD_VECTOR>::iterator c = g_pBoard->vectors.begin(); c != g_pBoard->vectors.end(); ++c)
			{
				const int color = c->type == TT_SOLID ? RGB(255, 255, 255) : RGB(0, 255, 0);
				c->pV->draw(color, true, r.left, r.top, &cnv);
				//RECT r = c->pV->getBounds();
				//cnv.DrawRect(r.left, r.top, r.right, r.bottom, RGB(255, 255, 255));
			}

			// Draw pathfinding obstructions (grown vectors) for the selected player only.
			// (Debug).
			// g_pSelectedPlayer->drawPfObjects(r.left, r.top, &cnv);

			cnv.Unlock();
		}
#endif
	} // if (redrawing)
}

/*
 * Set the ambient level.
 */
void setAmbientLevel(void)
{
	extern LPBOARD g_pBoard;
	const RGB_SHORT bae = g_pBoard->ambientEffect;
	const RGBSHADE al = 
	{
		int(CProgram::getGlobal(_T("ambientred"))->getNum()) + bae.r,
		int(CProgram::getGlobal(_T("ambientgreen"))->getNum()) + bae.g,
		int(CProgram::getGlobal(_T("ambientblue"))->getNum()) + bae.b
	};
	
	if (g_pDirectDraw->IsGammaEnabled())
	{
		g_pDirectDraw->OffsetGammaRamp(al.r, al.g, al.b);
		return;
	}

	// If we're not in full screen mode, we can't use the
	// gamma controller, so we need to do something else here.
	// A translucent blt each frame is out of the question, so tiles
	// are redrawn with the ambient rgb additively applied. This requires
	// a g_scrollCache.render(true) call to force a redraw.
	// In order to apply the level to sprites, the animation cache is cleared,
	// forcing sprites to redraw their frames as and when each is required.
	// No mechanism currently exists to apply the levels to non-tile images
	// in windowed mode.
	g_ambientLevel.rgb = al;
	g_ambientLevel.color = RGB(abs(al.r), abs(al.g), abs(al.b));
	g_ambientLevel.sgn = DOUBLE(sgn(double(al.r)));

	CSharedAnimation::freeAllCanvases();
	g_pBoard->createImageCanvases();
}

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
void renderNow(CCanvas *cnv, const bool bForce)
{
	extern ZO_VECTOR g_sprites;
	extern LPBOARD g_pBoard;
	extern CPlayer *g_pSelectedPlayer;

	const bool bScreen = (cnv == NULL);
	if (!cnv) cnv = g_pDirectDraw->getBackBuffer();

	cnv->ClearScreen(g_pBoard->bkgColor);

	// Set of RECTs covering the sprites.
	std::vector<RECT> rects;		

	// Draw the background (parallaxed or otherwise).
	g_pBoard->renderBackground(cnv, g_screen);

	// Render the flattened board if it exists ([0] represents any layer occupied).
	if (g_pBoard->bLayerOccupied[0])
	{
		// Check if we need to re-render the scroll cache.
		g_scrollCache.render(false);

		// Advance animated tiles and update the scroll cache.
		g_pBoard->renderAnimatedTiles(g_scrollCache);

		// Draw flattened layers.
		g_scrollCache.cnv.BltTransparentPart(
			cnv, 
			g_scrollCache.r.left - g_screen.left,
			g_scrollCache.r.top - g_screen.top,
			0, 0, 
			g_scrollCache.r.right - g_scrollCache.r.left, 
			g_scrollCache.r.bottom - g_scrollCache.r.top,
			TRANSP_COLOR
		);			
	}

	/*
	 * Loop over layers. Draw sprites, recording the portion of their
	 * frame on the screen in a RECT vector. 
	 * Draw any under vectors over sprites that are standing on them.
	 * Draw tiles on higher layers over the sprites: draw tiles directly
	 * rather than using any intermediate canvas.
	 */
	for (int layer = 1; layer <= g_pBoard->sizeL; ++layer)
	{
		// Draw tiles/images on higher layers over the sprites.
		if (g_pBoard->bLayerOccupied[layer])
		{
			// rects are the sprite frames located on the board,
			// which are only added when the sprite is encountered in the loop.
			for (std::vector<RECT>::const_iterator i = rects.begin(); i != rects.end(); ++i)
			{
				// rects are aligned to grid.
				const RECT rAligned = *i;

				// If this rect is occupied, draw all the tiles on this layer
				// it totally or partially contains, covering the sprite.
				g_pBoard->render(
					cnv,
					rAligned.left - g_screen.left,
					rAligned.top - g_screen.top,
					layer, layer,
					rAligned.left, rAligned.top, 
					rAligned.right - rAligned.left, 
					rAligned.bottom - rAligned.top
				);
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
				// Store the portion of the sprite that was rendered
				// in 'rects' and draw the intersecting board contents
				// on higher layers.

				// Inflate to align to the grid (iso or 2D). Create
				// new RECT since 'rect' is used below.
				const RECT rAligned = {
					rect.left - rect.left % 32,
					rect.top - rect.top % 32,
					rect.right - rect.right % 32 + 32,
					rect.bottom - rect.bottom % 32 + 32
				};
				rects.push_back(rAligned);
			}
			else continue;

			// Get the sprite's vector base to test for collisions with the under vector.
			const CVector v = (*j)->getVectorBase(true);
			RECT sr = v.getBounds();

			// Draw any "under" vectors this sprite is standing on.
			for (std::vector<BRD_VECTOR>::const_iterator k = g_pBoard->vectors.begin(); k != g_pBoard->vectors.end(); ++k)
			{
				// Check if this is an "under" vector, is on the same layer and has a canvas.
				if (!k->pCnv || k->layer != layer || k->type & ~TT_UNDER) 
					continue;

				// Under vector's bounds.
				const RECT rBounds = k->pV->getBounds();

				RECT r = {0, 0, 0, 0};
				DB_POINT ptUnused = {0, 0};

				// Place the intersection of the sprite's *frame* and the under vector's
				// bounds in 'r' - this is the area to draw.
				if (IntersectRect(&r, &rect, &rBounds))
				{
					// If the effect occurs on frame intersection draw straight
					// off, else check for vector collision.
					if(k->attributes & TA_FRAME_INTERSECT || k->pV->contains(v, ptUnused))
					{
						k->pCnv->BltTransparentPart(
							cnv, 
							r.left - g_screen.left,
							r.top - g_screen.top,
							r.left - rBounds.left, 
							r.top - rBounds.top, 
							r.right - r.left, 
							r.bottom - r.top,
							TRANSP_COLOR
						);
					}
				}
			} // for (under tile canvases)

		} // for (sprites)

	} // for (layer)

	// Render multitasking animations.
	CThreadAnimation::renderAll(cnv);

	// Render the 'renderNow' overlay.
	if (g_renderNow.draw) g_renderNow.cnv->BltTransparent(cnv, 0, 0, g_renderNow.transp);

	if (bScreen) g_pDirectDraw->Refresh();
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
 * Shut down the graphics engine.
 */
void closeGraphics()
{
	extern HINSTANCE g_hInstance;

	CTile::clearTileCache();
	destroyCanvases();
	delete g_pDirectDraw;

	DestroyWindow(g_hHostWnd);
	UnregisterClass(CLASS_NAME, g_hInstance);
}
