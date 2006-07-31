/*
 * All contents copyright 2005, 2006 
 * Colin James Fitzpatrick & Jonathan D. Hughes.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _BOARD_CONV_H_
#define _BOARD_CONV_H_

#include <vector>
#include "coords.h"

/*
 * Pre-3.0.7 defines - for board conversion.
 */
#define NORMAL 0
#define SOLID 1
#define UNDER 2
#define NORTH_SOUTH 3
#define EAST_WEST 4
#define STAIRS1 11
#define STAIRS2 12
#define STAIRS3 13
#define STAIRS4 14
#define STAIRS5 15
#define STAIRS6 16
#define STAIRS7 17
#define STAIRS8 18

// Post 3.0.7 tiletypes.
typedef enum tagTileType
{
	TT_NORMAL = 0,
	TT_SOLID = 1,
	TT_UNDER = 2,
	TT_UNIDIRECTIONAL = 4,
	TT_STAIRS = 8,
	TT_WAYPOINT = 16

} TILE_TYPE;

typedef std::vector<char> VECTOR_CHAR;
typedef std::vector<VECTOR_CHAR> VECTOR_CHAR2D;

typedef struct tagConvertedPoint
{
	int x, y;
	tagConvertedPoint(const int a, const int b): x(a), y(b) {}
} CONV_POINT;

typedef struct tagConvertedVector
{
	std::vector<CONV_POINT> pts;
	int type;

	tagConvertedVector(const int t): type(t) {}
} CONV_VECTOR, *LPCONV_VECTOR;

std::vector<CONV_POINT> tileToVector(
	const int x, 
	const int y, 
	const COORD_TYPE coordType
);

std::vector<LPCONV_VECTOR> vectorizeLayer(
	const VECTOR_CHAR2D &tiletype,
	const unsigned int bSizeX,
	const unsigned int bSizeY,
	const COORD_TYPE coordType
);

#endif