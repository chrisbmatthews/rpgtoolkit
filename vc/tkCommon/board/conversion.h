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
	TT_UNIDIRECTIONAL = 4,			// Depreciated / unnecessary.
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