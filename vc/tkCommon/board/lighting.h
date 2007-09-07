/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Jonathan D. Hughes
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

//--------------------------------------------------------------------------
// Board light rendering routines
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Defines
//--------------------------------------------------------------------------
#include "coords.h"
#define WIN32_MEAN_AND_LEAN			// Obtain lean version of windows
#include <windows.h>				// Windows headers
#include <vector>

// An short rgb colorshade.
typedef struct tagRgbShadeShort
{
    SHORT r, g, b;
} RGB_SHORT, *LPRGB_SHORT;

// Lighting types (see toolkit3, modBoard.eBoardLight)
typedef enum tagBoardLightType
{
    BL_ELLIPSE,
    BL_GRADIENT,
	BL_GRADIENT_CLIPPED
} LIGHT_TYPE;

typedef std::vector<RGB_SHORT> tagRgbVector, RGB_VECTOR;
typedef std::vector<RGB_VECTOR> tagRgbMatrix, RGB_MATRIX, *LPRGB_MATRIX;

// C++ version of tagVBLayerShade.
typedef struct tagLayerShade
{
	RGB_MATRIX shades;
	INT layer;

	tagLayerShade(VOID): layer(1) {};
	tagLayerShade(CONST INT width, CONST INT height): layer(1) { size(width, height); }
	void size(CONST INT width, CONST INT height);

} LAYER_SHADE, *LPLAYER_SHADE;

// C++ version of VB CBoardLight.
typedef struct tagBoardLight
{
	std::vector<POINT> nodes;
	RGB_VECTOR colors;
	LIGHT_TYPE eType;
	INT layer;
} BRD_LIGHT, *LPBRD_LIGHT;

//--------------------------------------------------------------------------
// Cast a BRD_LIGHT onto a matrix.
//--------------------------------------------------------------------------
VOID calculateLighting(RGB_MATRIX &values, CONST BRD_LIGHT &bl, CONST COORD_TYPE coordType, CONST INT brdSizeX);
	
//--------------------------------------------------------------------------
// Call a method of a COM object through IDispatch.
//--------------------------------------------------------------------------
VARIANT invokeObject(CONST LPUNKNOWN pUnk, BSTR method, DISPPARAMS &dispparams, CONST WORD methodFlags);
