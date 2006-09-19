//--------------------------------------------------------------------------
// All contents copyright 2006 Jonathan D. Hughes
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

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
