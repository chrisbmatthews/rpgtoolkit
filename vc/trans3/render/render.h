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
typedef struct tagSpriteRender
{
    CCanvas *canvas;		// Canvas used for this render.
	STRING stance;		// Stance player was rendered in.
    unsigned int frame;		// Frame of this stance.
    double x;				// X position the render occured in.
    double y;				// Y position the render occured in.

	tagSpriteRender():
		canvas(NULL),
		stance(STRING()),
		frame(0),
		x(0), y(0) {};

} SPRITE_RENDER;

typedef struct tagScrollCache
{
	CCanvas *pCnv;		// Canvas for each layer.
	RECT r;					// Bounds of graphics on this layer (board co-ords).

	tagScrollCache(): 
		pCnv(NULL)
		{ r.top = r.bottom = r.left = r.right = 0; };

	void render(const bool bForceRedraw);

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
