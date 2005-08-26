/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _MOVEMENT_H_
#define _MOVEMENT_H_

/*
 * Inclusions.
 */
#include <string>
#include <deque>
#include "../common/sprite.h"

/*
 * Definitions.
 */
const int MILLISECONDS	= 1000;			// Milliseconds in a second.
const double PX_FACTOR	= 4.0;			// Movement scaler factor.
										// Note: Possibly out by a factor of 2.
/*
// m_pos.loopFrame idle states. Only condition: must be negative.
const int LOOP_WAIT				= -1;	// Waiting to begin idle animations.
const int LOOP_IDLE				= -2;	// Running idle animations.
const int LOOP_CUSTOM_STANCE	= -3;	// Running a custom stance?
*/

// m_pos.loopFrame idle states. Only condition: must be negative.
enum
{
	LOOP_CUSTOM_STANCE = -4,			// Running a custom stance.
	LOOP_IDLE,							// Running idle animations.
	LOOP_WAIT,							// Waiting to begin idle animations.
	LOOP_DONE,							// Just finished moving.
	LOOP_MOVE = 0,						// Moving.
};

enum GAME_STATE
{
	GS_IDLE,							// Receiving input.
	GS_MOVEMENT,						// Player movement is occurring (no input).
	GS_PAUSE,							// Game is paused (e.g. lost focus).
	GS_QUIT								// Shutdown sequence.
};

/*
 * Movement definitions.
 */

/* Unneeded - to be removed 
#define MV_IDLE		0
#define MV_NORTH	1
#define MV_SOUTH	2
#define MV_EAST		3
#define MV_WEST		4
#define MV_NE		5
#define MV_NW		6
#define MV_SE		7
#define MV_SW		8
*/

#define MVQ_IDLE "0"
#define MVQ_NORTH "1"
#define MVQ_SOUTH "2"
#define MVQ_EAST "3"
#define MVQ_WEST "4"
#define MVQ_NE "5"
#define MVQ_NW "6"
#define MVQ_SE "7"
#define MVQ_SW "8"

/* In the process of being depreciated */
#define WALK_N "walk_n"
#define WALK_S "walk_s"
#define WALK_E "walk_e"
#define WALK_W "walk_w"
#define WALK_NE "walk_ne"
#define WALK_NW "walk_nw"
#define WALK_SE "walk_se"
#define WALK_SW "walk_sw"

/*
 * Tile type definitions.
 *
 * Stairs are in the form "stairs + layer number"; i.e., layer = stairs - 10
 */

/* Unneeded. - to be removed */
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

/*
 * Co-ordinate system types (board member).
 */
typedef enum tagCoordType
{
	TILE_NORMAL = 0,
	ISO_STACKED = 1,						// (Old) staggered column method.
	ISO_ROTATED = 2,						// x-y axes rotated by 60 / 30 degrees.
	PX_ABSOLUTE = 4							// Absolute co-ordinates (iso and 2D).
} COORD_TYPE;

/*
 * Idle information for sprites.
 */
typedef struct tagIdleInfo
{
    unsigned int frameTime;		// Millisecond time this frame of the idle animation has played for.
    unsigned int frameDelay;	// Millisecond frame delay of the frames of the idle animation.
    unsigned int time;			// Millisecond time this sprite has been idle for.

	tagIdleInfo(void): 
		frameTime(0), 
		frameDelay(0), 
		time(GetTickCount()) {};

} IDLE_INFO;

/*
 * Position of a sprite.
 */
typedef struct tagSpritePosition
{
    std::string stance;		// Current stance.
	MV_ENUM facing;			// Which direction are we facing? May be different from .direction!
    int frame;				// Animation frame.
    double x;				// Current board x position (PIXEL co-ord).
    double y;				// Current board y position (PIXEL co-ord).
    int l;					// Current layer.
    int loopFrame;			// Current frame in a movement loop (different from .frame).
							// Also denotes idle status (when negative):
							//		= LOOP_WAIT - just finished moving.
							//		= LOOP_IDLE - started idle animations.
							//		= LOOP_CUSTOM_STANCE - running a custom stance through the mainloop.
	int loopSpeed;			// speed converted to loops.
    IDLE_INFO idle;
	bool bIsPath;			// Is the current movement part of a path?

	tagSpritePosition(void): 
		stance(std::string()),
		facing(MV_S),
		frame(0),
		x(0), y(0), l(1),
		loopFrame(LOOP_WAIT),
		bIsPath(false),
		loopSpeed(1),
		idle() {};

} SPRITE_POSITION;

/*
 * A pending movement.
 */
typedef struct tagPendingMovement
{
    double xOrig;			// Origin PIXEL co-ordinates.
    double yOrig;
    int lOrig;				// Integer levels.
    double xTarg;			// Target PIXEL co-ordinates.
    double yTarg;
    int lTarg;
//	std::deque<int> queue;	// The pending movements of the player/item.
	std::deque<DB_POINT> path;

	tagPendingMovement(void):
//		direction(MV_IDLE),
		xOrig(0), yOrig(0), lOrig(1),
		xTarg(0), yTarg(0), lTarg(1),
		path() {};

	/* TO BE REMOVED */
    MV_ENUM direction;		// MV_ direction code.

} PENDING_MOVEMENT;

/*
 * Round a floating point.
 *
 * num (in) - number to round
 * return (out) - rounded result
 */
inline int round(const double num)
{
	return int(num + 0.5);
}

/*
 * Return the sign of a number.
 */
inline int sgn(const double num)
{
	if (!num) return 0;
	return (num > 0 ? 1 : -1);
}

#endif
