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
#include "../../tkCommon/board/coords.h"
#include "../../tkCommon/tkDirectX/platform.h"

// Uncomment to show debug vectors.
#define DEBUG_VECTORS

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
 */
bool renderNow(CCanvas *cnv = NULL, const bool bForce = false);

/*
 * Set the ambient level.
 */
void setAmbientLevel(void);

/*
 * Load a cursor from a file.
 */
void changeCursor(const STRING strCursor);

#endif
