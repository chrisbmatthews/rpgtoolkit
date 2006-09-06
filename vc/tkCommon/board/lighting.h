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
typedef struct tagRgbShade
{
    SHORT r, g, b;
} RGB_SHADE, *LPRGB_SHADE;

// Lighting types (see toolkit3, modBoard.eBoardLight)
typedef enum tagBoardLightType
{
    BL_SPOTLIGHT,
    BL_GRADIENT,
	BL_GRADIENT_CLIPPED
} LIGHT_TYPE;

typedef std::vector<RGB_SHADE> tagRgbVector, RGB_VECTOR;
typedef std::vector<RGB_VECTOR> tagRgbMatrix, RGB_MATRIX;

// C++ version of VB CBoardLight.
typedef struct tagBoardLight
{
	std::vector<POINT> nodes;
	RGB_VECTOR colors;
	LIGHT_TYPE eType;
} BRD_LIGHT, *LPBRD_LIGHT;

//--------------------------------------------------------------------------
// Cast a BRD_LIGHT onto a matrix.
//--------------------------------------------------------------------------
VOID calculateLighting(RGB_MATRIX &values, CONST BRD_LIGHT &bl, CONST COORD_TYPE coordType, CONST INT brdSizeX);
	
//--------------------------------------------------------------------------
// Call a method of a COM object through IDispatch.
//--------------------------------------------------------------------------
VARIANT invokeObject(CONST LPUNKNOWN pUnk, BSTR method, DISPPARAMS &dispparams, CONST WORD methodFlags);
