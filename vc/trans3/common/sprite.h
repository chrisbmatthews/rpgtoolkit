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
#include <string>
#include "../movement/CVector/CVector.h"

/*
 * Definitions.
 */

// Ordered specifically for rotation permutations (when sliding).
typedef enum tagMovementCodes
{
	MV_IDLE,
	MV_N,
	MV_NE,
	MV_E,
	MV_SE,
	MV_S,
	MV_SW,
	MV_W,
	MV_NW
} MV_ENUM;

// Postfix increment - rotate the movement "right".
inline void operator++ (MV_ENUM& rhs, int)
{
	if (rhs == MV_NW) { rhs = MV_N; return; }
	if (rhs == MV_IDLE) return;
	rhs = MV_ENUM(rhs + 1);
};

// Postfix decrement - rotate the movement "left".
inline void operator-- (MV_ENUM& rhs, int)
{
	if (rhs == MV_N) { rhs = MV_NW; return; }
	if (rhs == MV_IDLE) return;
	rhs = MV_ENUM(rhs - 1);
};

/*
 * Movement vector values - increments for insertTarget().
 *		{ dx, dy }
 *		{ MV_IDLE, 
 *		 MV_N, MV_NE, MV_E, MV_SE, 
 *		 MV_S, MV_SW, MV_W, MV_NW }
 *
 *		g_directions[isIsometric][MV_CODE][x or y]
 */
const int g_directions[2][9][2] = 
			{
				// Non - isometric.
				{	{ 0, 0 }, 
					{ 0,-1 }, { 1,-1 }, { 1, 0 }, { 1, 1 },
					{ 0, 1 }, {-1, 1 }, {-1, 0 }, {-1,-1 }
				},
// To be done.				// Isometric.
				{	{ 0, 0 }, 
					{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },
					{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }
				}
			};


/* Unneeded - to be removed */
#define PLYR_WALK_S 0
#define PLYR_WALK_N 1
#define PLYR_WALK_E 2
#define PLYR_WALK_W 3
#define PLYR_WALK_NW 4
#define PLYR_WALK_NE 5
#define PLYR_WALK_SW 6
#define PLYR_WALK_SE 7
#define PLYR_FIGHT 8
#define PLYR_DEFEND 9
#define PLYR_SPC 10
#define PLYR_DIE 11
#define PLYR_REST 12

// Vector indices for mapGfx.
const int GFX_MOVE = 0;	
const int GFX_IDLE = 1;

// Custom map keys, mirrored in the battle plugin.
const std::string GFX_FIGHT		= "FIGHT";
const std::string GFX_DEFEND	= "DEFEND";
const std::string GFX_SPC		= "SPECIAL MOVE";
const std::string GFX_DIE		= "DIE";
const std::string GFX_REST		= "REST";

/*
 * Common attributes of players and items:
 * animation sets, speed variables.
 */
typedef std::map<MV_ENUM, std::string> GFX_MAP;

typedef struct tagSpriteAttr
{
	// Provision for multiple sets of movement-indexed graphics.
	std::vector<GFX_MAP> mapGfx;	

	// Map of custom animations, indexed by string handles.
	std::map<std::string, std::string> mapCustomGfx;

/* Unneeded - to be removed.*/
	std::vector<std::string> gfx;				// Filenames of standard animations for graphics.
	std::vector<std::string> standingGfx;		// Filenames of the standing animations/graphics.
	std::vector<std::string> customGfx;			// Customized animations.
	std::vector<std::string> customGfxNames;	// Customized animations (handles).

	double idleTime;							// Seconds to wait prior to switching to idle graphics.
	double speed;								// Seconds between each frame increase.
	CVector vActivate;							// Sprite's interaction area.
	CVector vBase;								// Sprite's contact area on board.

	tagSpriteAttr (void): 
		idleTime(3.0),
		speed(0.05), 
		vActivate (1, 1, 4, TT_SOLID),
		vBase (1, 1, 4, TT_SOLID) {};

	// Get the animation filename corresponding to stance.
	std::string getStanceAnm(std::string stance);

	// Fill out diagonal movement entries with axial entries.
	void completeStances(GFX_MAP &gfx);

} SPRITE_ATTR;

#endif
