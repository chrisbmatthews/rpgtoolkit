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
#include "../../tkCommon/strings.h"
#include <deque>
#include <math.h>
#include "../common/sprite.h"

/*
 * Definitions.
 */
const int MILLISECONDS	= 1000;			// Milliseconds in a second.
const int PX_FACTOR		= 4;			// Movement scaler factor.
										// Note: Possibly out by a factor of 2.

// m_pos.loopFrame idle states. Only condition: must be negative.
enum
{
	LOOP_STANCE = -4,					// Running a custom stance.
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
#define MVQ_IDLE _T("0")
#define MVQ_NORTH _T("1")
#define MVQ_SOUTH _T("2")
#define MVQ_EAST _T("3")
#define MVQ_WEST _T("4")
#define MVQ_NE _T("5")
#define MVQ_NW _T("6")
#define MVQ_SE _T("7")
#define MVQ_SW _T("8")

/* In the process of being depreciated.. SpriteAttr::getStanceAnm? */
#define WALK_N _T("walk_n")
#define WALK_S _T("walk_s")
#define WALK_E _T("walk_e")
#define WALK_W _T("walk_w")
#define WALK_NE _T("walk_ne")
#define WALK_NW _T("walk_nw")
#define WALK_SE _T("walk_se")
#define WALK_SW _T("walk_sw")

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

typedef std::deque<DB_POINT> MV_PATH;
typedef std::deque<DB_POINT>::iterator MV_PATH_ITR;

/*
 * Position of a sprite.
 */
typedef struct tagSpritePosition
{
    CAnimation *pAnm;		// Current animation in use.
    int frame;				// Animation frame.
    double x;				// Current board x position (PIXEL co-ord).
    double y;				// Current board y position (PIXEL co-ord).
    int l;					// Current layer.
    int loopFrame;			// Current frame in a movement loop (different from .frame).
							// Also denotes idle status (when negative):
							//		= LOOP_WAIT - just finished moving.
							//		= LOOP_IDLE - started idle animations.
							//		= LOOP_STANCE - running a custom stance through the mainloop.
	int loopSpeed;			// speed converted to loops.
    IDLE_INFO idle;

	DB_POINT target;		// Target co-ordinates.
	bool bIsPath;			// Is the current movement part of a path?
	MV_PATH path;

	tagSpritePosition(void): 
		pAnm(NULL),
		frame(0),
		x(0), y(0), l(1),
		loopFrame(LOOP_WAIT),
		bIsPath(true),
		loopSpeed(1),
		idle(),
		path() { target.x = target.y = 0.0; };

} SPRITE_POSITION;

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

/*
 * Absolute value of a double.
 */
inline double dAbs(const double x)
{
	return (x < 0 ? -x : x);
}

#endif
