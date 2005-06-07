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
#include <vector>

/*
 * Movement definitions.
 */

#define MV_IDLE 0
#define MV_NORTH 1
#define MV_SOUTH 2
#define MV_EAST 3
#define MV_WEST 4
#define MV_NE 5
#define MV_NW 6
#define MV_SE 7
#define MV_SW 8

#define MVQ_IDLE "0"
#define MVQ_NORTH "1"
#define MVQ_SOUTH "2"
#define MVQ_EAST "3"
#define MVQ_WEST "4"
#define MVQ_NE "5"
#define MVQ_NW "6"
#define MVQ_SE "7"
#define MVQ_SW "8"

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
    double frameTime;		// Length of time this frame of the idle animation has played for.
    double frameDelay;		// Frame delay of the frames of the idle animation.
    double time;			// Length of time this item has been idle for.
} IDLE_INFO;

/*
 * Position of a sprite.
 */
typedef struct tagSpritePosition
{
    std::string stance;		// Current stance.
    int frame;				// Animation frame.
    double x;				// Current board x position (fraction of tiles).
    double y;				// Current board y position (fraction of tiles).
    int l;					// Current layer.
    int loopFrame;			// Current frame in a movement loop (different from .frame).
    IDLE_INFO idle;
} SPRITE_POSITION;
typedef std::vector<SPRITE_POSITION> SPRITE_POSITIONS;

/*
 * A movement queue.
 */
typedef struct tagMovementQueue
{
    int lngSize;					// Size of the queue
    std::vector<int> lngMovements;	// Movements in the queue
} MOVEMENT_QUEUE;

/*
 * A pending movement.
 */
typedef struct tagPendingMovement
{
    int direction;			// MV_ direction code.
    double xOrig;			// Original board coordinates.
    double yOrig;
    int lOrig;				// Integer levels.
    double xTarg;			// Target board co-ordinates.
    double yTarg;
    int lTarg;
    MOVEMENT_QUEUE queue;	// The pending movements of the player/item.
} PENDING_MOVEMENT;
typedef std::vector<PENDING_MOVEMENT> PENDING_MOVEMENTS;

/*
 * Determine how many frames to move at a time.
 *
 * return (out) - number of frames
 */
inline int framesPerMove(void)
{
	extern double g_movementSize;
	const int toRet = int(g_movementSize * 4.0);
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
	const int whole = int(num);
	return (((num - whole) >= 0.5) ? (whole + 1) : whole);
}

#endif
