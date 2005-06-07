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

#endif
