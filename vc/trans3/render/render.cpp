/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "render.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../common/mainfile.h"
#include "../common/board.h"
#include "../common/paths.h"
#include "../input/input.h"
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
CGDICanvas *g_cnvRpgCode;					// RPGCode canvas.
std::vector<bool> g_showPlayer;				// Show these players?

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen(void)
{
	g_pDirectDraw->DrawCanvas(g_cnvRpgCode, 0, 0);
	/* ... draw message window ... */
	g_pDirectDraw->Refresh();
}

/*
 * Draw a tile.
 *
 * fileName (in) - tile to draw
 * x (in) - board x coordinate to draw at
 * y (in) - board y coordinate to draw at
 * r (in) - red shade
 * g (in) - green shade
 * b (in) - blue shade
 * cnv (in) - destination canvas
 * bIsometric (in) - draw isometrically?
 * nIsoEvenOdd (in) - iso is even or odd?
 */
void drawTile(const std::string fileName, const int x, const int y, const int r, const int g, const int b, CGDICanvas *cnv, const bool bIsometric, const int nIsoEvenOdd)
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

	const RGBSHADE rgb = {r, g, b};
	const std::string strFileName = g_projectPath + TILE_PATH + fileName;

	for (std::vector<CTile *>::iterator i = g_tiles.begin(); i != g_tiles.end(); i++)
	{
		const std::string strVect = (*i)->getFilename();
		if (strVect.compare(strFileName) == 0)
		{
			if ((*i)->isShadedAs(rgb, SHADE_UNIFORM))
			{
				if (bIsometric)
				{
					if ((*i)->isIsometric())
					{
						// Found a match.
						(*i)->cnvDraw(cnv, xx, yy);
						return;
					}
				}
				else if (!(*i)->isIsometric())
				{
					// Found a match.
					(*i)->cnvDraw(cnv, xx, yy);
					return;
				}
			}
		}
	}

	// Load the tile
	CTile *const pTile = new CTile(NULL, strFileName, rgb, SHADE_UNIFORM, bIsometric);

	// Push it into the vector
	g_tiles.push_back(pTile);

	// Draw the tile.
	pTile->cnvDraw(cnv, xx, yy);

}

/*
 * Draw a board.
 *
 * brd (in) - board to draw
 * cnv (in) - target surface
 * layer (in) - layer to draw
 * topX (in) - top x coordinate
 * topY (in) - top y coordinate
 * tilesX (in) - number of tiles to draw on x
 * tilesY (in) - number of tiles to draw on y
 * aR (in) - ambient red
 * aG (in) - ambient green
 * aB (in) - ambient blue
 * bIsometric (in) - board is isometric?
 */
void drawBoard(CONST BOARD &brd, CGDICanvas *cnv, const int layer, const int topX, const int topY, const int tilesX, const int tilesY, const int aR, const int aG, const int aB, const bool bIsometric)
{

	// Is it an even or odd tile?
	const int nIsoEvenOdd = !(topY % 2);

	// Record top and bottom layers
	const int nLower = layer ? layer : 1;
	const int nUpper = layer ? layer : brd.bSizeL;

	// Calculate width and height
	const int nWidth = (tilesX + topX > brd.bSizeX) ? brd.bSizeX - topX : tilesX;
	const int nHeight = (tilesY + topY > brd.bSizeY) ? brd.bSizeY - topY : tilesY;

	// For each layer
	for (unsigned int i = nLower; i <= nUpper; i++)
	{

		// For the x axis
		for (unsigned int j = 1; j <= nWidth; j++)
		{

			// For the y axis
			for (unsigned int k = 1; k <= nHeight; k++)
			{

				// Obtain some information.
				const int x = j + topX;
				const int y = k + topY;
				const std::string strTile = brd.tileIndex[brd.board[x][y][i]];
				if (!strTile.empty())
				{

					// Tile exists at this location.
					drawTile(strTile, j, k, brd.ambientRed[x][y][i] + aR, brd.ambientGreen[x][y][i] + aG, brd.ambientBlue[x][y][i] + aB, cnv, bIsometric, nIsoEvenOdd);

				} // if (!strTile.empty())

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
}

/*
 * Destroy global canvases.
 */
void destroyCanvases(void)
{
	delete g_cnvRpgCode;
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
		/*HICON(hCursor)*/ NULL,
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

	int depth = 16 + g_mainFile.colorDepth * 8;
	g_pDirectDraw = new CDirectDraw();
	while (!g_pDirectDraw->InitGraphicsMode(g_hHostWnd, width, height, TRUE, depth, g_mainFile.extendToFullScreen))
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

	createCanvases();

}

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
bool renderNow(CGDICanvas * /*cnv*/, const bool bForce)
{
	CGDICanvas cnv;
	cnv.CreateBlank(NULL, g_resX, g_resY, TRUE);
	cnv.ClearScreen(0);
	extern BOARD g_activeBoard;
	drawBoard(g_activeBoard, &cnv, 0, 0, 0, g_tilesX, g_tilesY, 0, 0, 0, false);
	g_pDirectDraw->DrawCanvas(&cnv, 0, 0);
	g_pDirectDraw->Refresh();
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
	for (std::vector<CTile *>::iterator i = g_tiles.begin(); i != g_tiles.end(); i++)
	{
		delete (*i);
	}
	g_tiles.clear();
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
