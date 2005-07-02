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
const int MILLISECONDS = 1000;		// Milliseconds in a second.

#define GS_IDLE 0					// Just re-renders the screen
#define GS_MOVEMENT 1				// Movement is occurring (players or items)
#define GS_PAUSE 2					// Pause game (do nothing)
#define GS_QUIT 3					// Shutdown sequence

/*
 * Movement definitions.
 */

// m_pos.loopFrame idle states. Only condition: must be negative.
#define LOOP_WAIT			(-1)	// Waiting to begin idle animations.
#define LOOP_IDLE			(-2)	// Running idle animations.
#define LOOP_CUSTOM_STANCE	(-3)	// Running a custom stance?

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

	tagSpritePosition(void): 
		stance(std::string()),
		facing(MV_S),
		frame(0),
		x(0), y(0), l(1),
		loopFrame(-1),
		loopSpeed(1),
		idle() {};

} SPRITE_POSITION;

/*
 * A pending movement.
 */
typedef struct tagPendingMovement
{
    MV_ENUM direction;		// MV_ direction code.
    double xOrig;			// Origin PIXEL co-ordinates.
    double yOrig;
    int lOrig;				// Integer levels.
    double xTarg;			// Target PIXEL co-ordinates.
    double yTarg;
    int lTarg;
	std::deque<int> queue;	// The pending movements of the player/item.

	tagPendingMovement(void):
		direction(MV_IDLE),
		xOrig(0), yOrig(0), lOrig(1),
		xTarg(0), yTarg(0), lTarg(1),
		queue() {};

} PENDING_MOVEMENT;

/*
 * Determine how many frames to move at a time.
 *
 * return (out) - number of frames
 */
inline int framesPerMove(void)
{
	extern double g_movementSize;
	const int toRet = int(g_movementSize * 0.125);
	if (toRet < 2) return 2;
	return toRet;
}

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
