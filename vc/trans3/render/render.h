/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin Fitzpatrick & Jonathan Hughes
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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

#ifndef _RENDER_H_
#define _RENDER_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include "../../tkCommon/board/coords.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkGfx/CTile.h"

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
	void createCanvas(int w, int h)
	{
		// Ensure canvas has tile-integral width/height.
		w = (w / 32) * 32;
		h = (h / 32) * 32;

		cnv.CreateBlank(NULL, w, h, TRUE);
		cnv.ClearScreen(0);
		maxWidth = r.right = w;
		maxHeight = r.bottom = h;
	}

} SCROLL_CACHE;

typedef struct tagAmbientLevel
{
	RGBSHADE rgb;
	LONG color;
	DOUBLE sgn;
	tagAmbientLevel(): color(0), sgn(0.0) { rgb.r = rgb.g = rgb.b = 0; }

} AMBIENT_LEVEL;

typedef struct tagRenderOverlay
{
	CCanvas *cnv;
	LONG transp;
	bool draw;
	tagRenderOverlay(): cnv(NULL), transp(0), draw(false) {};

} RENDER_OVERLAY;

typedef struct tagMessageWindow
{
	CCanvas *cnvBkg;			// Background image.
	CCanvas *cnvText;			// Text to separate canvas to preserve antialiasing.
	int nextLine;				// Pixel y-position of next line.
	int width, height;			// Message window dimensions.
	bool visible;				// Show the message window?
	LONG color;					// Background color in image absence.
	double translucency;
	STRING bkg;					// Background image.
	tagMessageWindow():
		cnvBkg(NULL), cnvText(NULL), nextLine(0), visible(false), 
		color(0), translucency(0.5), width(600), height(100) {};

	void createCanvases(void);
	void destroyCanvases(void)
	{
		delete cnvBkg;
		delete cnvText;
	}

	void render(void);
	void render(const STRING img, const LONG col)
	{
		bkg = img;
		color = col;
		render();
	}

	void hide(void)
	{
		visible = false;
		nextLine = 0;
	}

} MESSAGE_WINDOW;

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
void renderNow(CCanvas *cnv = NULL, const bool bForce = false);

/*
 * Set the ambient level.
 */
void setAmbientLevel(void);

/*
 * Load a cursor from a file.
 */
void changeCursor(const STRING strCursor);

#endif
