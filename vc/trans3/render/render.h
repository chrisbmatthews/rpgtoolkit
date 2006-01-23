/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _RENDER_H_
#define _RENDER_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include "../../tkCommon/tkDirectX/platform.h"

/*
 * Typedefs.
 */
typedef struct tagScrollCache
{
	CCanvas cnv;				// Canvas for all layers.
	RECT r;						// Bounds of graphics (board co-ords).
	int maxWidth, maxHeight;	// Maximum size of cache.

	tagScrollCache(): cnv()
	{ r.top = r.bottom = r.left = r.right = 0; };

	void render(const bool bForceRedraw);
	void createCanvas(const int w, const int h)
	{
		cnv.CreateBlank(NULL, w, h, TRUE);
		cnv.ClearScreen(0);
		maxWidth = r.right = w;
		maxHeight = r.bottom = h;
	}

} SCROLL_CACHE;


/*
 * Constants.
 */
const long TRANSP_COLOR = 16711935;	// Transparent color (magic pink).

/*
 * Initialize the graphics engine.
 */
void initGraphics();

/*
 * Shut down the graphics engine.
 */
void closeGraphics();

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen();

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
bool renderNow(CCanvas *cnv = NULL, const bool bForce = false);

/*** These functions are looking for homes ***/

struct tagBoard;
typedef struct tagBoard BOARD, *LPBOARD;

bool drawTile(const STRING fileName, 
			  const int x, const int y, 
			  const int r, const int g, const int b, 
			  CCanvas *cnv, 
			  const int offX, const int offY,
			  const BOOL bIsometric, 
			  const int nIsoEvenOdd);

bool drawTileMask (const STRING fileName, 
				   const int x, const int y, 
				   const int r, const int g, const int b, 
				   CCanvas *cnv,
				   const int nDirectBlt,
				   const bool bIsometric,
				   const int nIsoEvenOdd);

bool drawTileCnv(CCanvas *cnv, 
				 const STRING file, 
				 const double x,
				 const double y, 
				 const int r, 
				 const int g,
				 const int b, 
				 const bool bMask, 
				 const bool bNonTransparentMask = true, 
				 const bool bIsometric = false, 
				 const bool isoEvenOdd = false);

void changeCursor(const STRING strCursor);

#endif
