/*
 * All contents copyright 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Common sprite file attribute functions.
 */

#ifndef _SPRITE_H_
#define _SPRITE_H_

/*
 * Includes.
 */
#include <vector>
#include <map>
#include "../../tkCommon/strings.h"
#include "../movement/CVector/CVector.h"

/*
 * Definitions.
 */

// Ordered specifically for rotation permutations (when sliding).
typedef enum tagMovementCodes
{
	MV_IDLE,
	MV_E,
	MV_SE,
	MV_S,
	MV_SW,
	MV_W,
	MV_NW,
	MV_N,
	MV_NE
} MV_ENUM;

// Postfix increment - rotate the movement "right", return a new object.
inline MV_ENUM operator++ (MV_ENUM lhs, int)
{
	if (lhs == MV_NE) return MV_E; 
	if (lhs == MV_IDLE) return MV_IDLE;
	return MV_ENUM(lhs + 1);
}

inline MV_ENUM operator-- (MV_ENUM lhs, int)
{
	if (lhs == MV_E) return MV_NE;
	if (lhs == MV_IDLE) return MV_IDLE;
	return MV_ENUM(lhs - 1);
}

// Prefix increment - rotate the movement "right".
inline void operator++ (MV_ENUM &lhs)
{
	if (lhs == MV_NE) { lhs = MV_E; return; }
	if (lhs == MV_IDLE) return;
	lhs = MV_ENUM(lhs + 1);
}

inline void operator-- (MV_ENUM &lhs)
{
	if (lhs == MV_E) { lhs = MV_NE; return; }
	if (lhs == MV_IDLE) return;
	lhs = MV_ENUM(lhs - 1);
}

inline MV_ENUM &operator+=(MV_ENUM &lhs, unsigned int inc)
{
	for (unsigned int i = 0; i < inc; ++i) ++lhs;
	return lhs;
}


/*
 * Movement vector values - increments for insertTarget().
 *		{ dx, dy }
 *		{ MV_IDLE, 
 *		 MV_E, MV_SE, MV_S, MV_SW, 
 *		 MV_W, MV_NW, MV_N, MV_NE }
 *
 *		g_directions[isIsometric][MV_CODE][x or y]
 */
const double g_directions[2][9][2] = 
			{
				// Non - isometric.
				{	{ 0, 0 }, 
					{ 1, 0 }, { 1, 1 }, { 0, 1 }, {-1, 1 },
					{-1, 0 }, {-1,-1 }, { 0,-1 }, { 1,-1 }
				},
				// Isometric.
				{	{ 0, 0 }, 
					{ 2, 0 }, { 1, 0.5 }, { 0, 1 }, {-1, 0.5 },
					{-2, 0 }, {-1,-0.5 }, { 0,-1 }, { 1,-0.5 }
				}
			};

// Base-point of a square tile, with 0,0 at the top-left corner.
const int BASE_POINT_X = 16;
const int BASE_POINT_Y = 32;
// Iso tile, 0,0 at centre.
const int BASE_POINT_ISO_X = 0;
const int BASE_POINT_ISO_Y = 0;

// Vector indices for mapGfx.
#define GFX_MOVE 0
#define GFX_IDLE 1

// Custom map keys, mirrored in the battle plugin.
const STRING GFX_FIGHT		= _T("FIGHT");
const STRING GFX_DEFEND		= _T("DEFEND");
const STRING GFX_SPC		= _T("SPECIAL MOVE");
const STRING GFX_DIE		= _T("DIE");
const STRING GFX_REST		= _T("REST");

/*
 * Common attributes of players and items:
 * animation sets, speed variables.
 */
typedef std::map<MV_ENUM, STRING> GFX_MAP;

typedef struct tagSpriteAttr
{
	// Provision for multiple sets of movement-indexed graphics.
	std::vector<GFX_MAP> mapGfx;	

	// Map of custom animations, indexed by string handles.
	std::map<STRING, STRING> mapCustomGfx;

	double idleTime;							// Seconds to wait prior to switching to idle graphics.
	double speed;								// Seconds between each frame increase.
	CVector vActivate;							// Sprite's interaction area.
	CVector vBase;								// Sprite's contact area on board.

	tagSpriteAttr (void): 
		idleTime(3.0),
		speed(0.05), 
		vActivate (),
		vBase () {};

	// Get the animation filename corresponding to stance.
	STRING getStanceAnm(STRING stance);

	// Fill out diagonal movement entries with axial entries.
	void completeStances(GFX_MAP &gfx);

	// Create some default vectors for old versions of players, items.
	void createVectors(const int activationType);

} SPRITE_ATTR;

/*
 * A board-set sprite.
 */

#define SPR_STEP		0				// Triggers once until player leaves area.
#define SPR_KEYPRESS	1				// Player must hit activation key.
#define SPR_REPEAT		2				// Triggers repeatedly after a certain distance or
										// can only be triggered after a certain distance.

#define SPR_ACTIVE		0				// Program is always active.
#define SPR_CONDITIONAL	1				// Program's running depends on RPGCode variables.

typedef struct tagBoardSprite
{
	STRING fileName;				// Filename of item.
//	short x;
//	short y;
//	short layer;

	short activate;						// SPR_ACTIVE - always active.
										// SPR_CONDITIONAL - conditional activation.
	STRING initialVar;				// Activation variable.
	STRING finalVar;				// Activation variable at end of sprite prg.
	STRING initialValue;			// Initial value of activation variable.
	STRING finalValue;				// Value of variable after sprite prg runs.
	short activationType;				// Activation type: (flags)
										// SPR_STEP - walk in vector.
										// SPR_KEYPRESS - hit general activation key inside vector.
										// SPR_REPEAT - Whether sprite must leave vector to before
										//				program can retrigger or not.
	STRING prgActivate;			// Program to run when sprite is activated.
	STRING prgMultitask;			// Multitask program for sprite.

	// The item will have its own vectors.
	tagBoardSprite(void): 
		activate(SPR_ACTIVE),
		activationType(SPR_STEP) {};

} BRD_SPRITE;

#endif
