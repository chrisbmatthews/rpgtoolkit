/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Jonathan D. Hughes
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
const double PX_FACTOR	= 4.0;			// Movement scaler factor.
										// Note: Possibly out by a factor of 2.

// m_pos.loopFrame idle states. Only condition: must be negative.
enum
{
	LOOP_FREEZE = -6,					// Freezing sprite movement for a given period.
	LOOP_STANCE,						// Running a custom stance.
	LOOP_STANCE_END,					// Holding the last frame of a stance until movement.
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

#endif
