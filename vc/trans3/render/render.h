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
#include "../../tkCommon/tkDirectX/platform.h"

/*
 * Typedefs.
 */
typedef struct tagSpriteRender
{
    CGDICanvas *canvas;		// Canvas used for this render.
	std::string stance;		// Stance player was rendered in.
    unsigned int frame;		// Frame of this stance.
    double x;				// X position the render occured in.
    double y;				// Y position the render occured in.

	tagSpriteRender(void):
		canvas(NULL),
		stance(std::string()),
		frame(0),
		x(0), y(0) {};

} SPRITE_RENDER;

typedef struct tagScrollCache
{
	CGDICanvas *pCnv;		// Canvas for each layer.
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
void initGraphics(void);

/*
 * Shut down the graphics engine.
 */
void closeGraphics(void);

/*
 * Render the RPGCode screen.
 */
void renderRpgCodeScreen(void);

/*
 * Render the scene now.
 *
 * cnv (in) - canvas to render to (NULL is screen)
 * bForce (in) - force the render?
 * return (out) - did a render occur?
 */
bool renderNow(CGDICanvas *cnv = NULL, const bool bForce = false);

/*** These functions are looking for homes ***/

struct tagBoard;
typedef struct tagBoard BOARD, *LPBOARD;

bool drawTile(const std::string fileName, 
			  const int x, const int y, 
			  const int r, const int g, const int b, 
			  CGDICanvas *cnv, 
			  const int offX, const int offY,
			  const BOOL bIsometric, 
			  const int nIsoEvenOdd);

bool drawTileMask (const std::string fileName, 
				   const int x, const int y, 
				   const int r, const int g, const int b, 
				   CGDICanvas *cnv,
				   const int nDirectBlt,
				   const bool bIsometric,
				   const int nIsoEvenOdd);

bool drawTileCnv(CGDICanvas *cnv, 
				 const std::string file, 
				 const double x,
				 const double y, 
				 const int r, 
				 const int g,
				 const int b, 
				 const bool bMask, 
				 const bool bNonTransparentMask = true, 
				 const bool bIsometric = false, 
				 const bool isoEvenOdd = false);

void changeCursor(const std::string strCursor);

#endif
