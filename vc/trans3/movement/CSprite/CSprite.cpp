/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Jonathan D. Hughes
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

/*
 * Implementation of a base sprite class.
 */

#include "CSprite.h"
#include "../CPlayer/CPlayer.h"
#include "../CItem/CItem.h"
#include "../../common/animation.h"
#include "../../common/mainFile.h"
#include "../../common/board.h"
#include "../../common/paths.h"
#include "../../common/CAllocationHeap.h"
#include "../../common/CFile.h"
#include "../../fight/fight.h"
#include "../../audio/CAudioSegment.h"
#include "../../rpgcode/CProgram.h"
#include <math.h>
#include <vector>

bool CSprite::m_bDoneMove = false;
int CSprite::m_loopOffset = 0;
bool CSprite::m_bPxMovement = false;	// Using pixel or tile movement.

#pragma warning(push)
#pragma warning(disable : 4355)

/*
 * Constructor
 */
CSprite::CSprite(const bool show):
m_facing(this),
m_attr(),
m_bActive(show),
m_pPathFind(NULL),
m_pCanvas(NULL),
m_pos(),
m_thread(NULL),
m_tileType(TT_NORMAL)				// Tiletype at location, NOT sprite's type.
{
	m_v.x = m_v.y = 0;
}

#pragma warning(pop)

/*
 * Movement functions.
 */ 

/*
 * Evaluate the current movement state.
 * Returns: true if movement occurred.
 */ 
bool CSprite::move(const CSprite *selectedPlayer, const bool bRunningProgram) 
{
	extern LPBOARD g_pBoard;
	extern GAME_STATE g_gameState;

	// Is this the selected player?
	const bool isUser = (this == selectedPlayer);

	// Freeze the sprite for m_pos.idle.time.
	if (m_pos.loopFrame == LOOP_FREEZE)
	{
		if (GetTickCount() - m_pos.idle.frameTime < m_pos.idle.time) return false;

		m_pos.loopFrame = LOOP_WAIT;
		m_pos.idle.time = m_pos.idle.frameTime = 0;
	}

	// Negative value indicates idle status.
	if (m_pos.loopFrame < LOOP_MOVE)
	{
		// If movements are queued or there is a board-set path.
		if (!m_pos.path.empty() || m_brdData.boardPath())
		{
			// Determine the number of frames for required speed.
			m_pos.loopSpeed = calcLoops();
			m_tileType = TT_NORMAL;

			// Insert target co-ordinates.
			setPathTarget();

			if (m_pos.bIsPath)
			{
				// Pathfinding removes the need to call boardCollisions() for paths.

				// Check we can initialise the movement.
				if (spriteCollisions() & TT_SOLID)
				{
					// Try to find a diversion that allows the sprite to
					// resume the path.

					// Return true if diversion found to insert the new path.
					if (findDiversion()) return true;
					
					// Else, movement cannot start.
					m_tileType = TILE_TYPE(m_tileType | TT_SOLID);

					// Freeze the sprite for a short time because, if a waypoint 
					// link exists, the sprite will continue to try to
					// move to the next point until it can (i.e., findDiversion()
					// will run every loop) - this is processor intensive.
					m_pos.loopFrame = LOOP_FREEZE;
					m_pos.idle.time = 256; // Milliseconds.
					m_pos.idle.frameTime = GetTickCount();
				}
				else
				{
					m_facing.assign(getDirection(m_v));
				}
			}
			else
			{
				// Keyboard movement.

				// Increment the animation frame if movement did not 
				// finish the previous loop (pixel movement only).
				// Bitshift in place of multiply by two (<< 1 equivalent to * 2)
				if (m_bPxMovement && m_pos.loopFrame != LOOP_DONE) m_pos.frame += (m_pos.loopSpeed << 1) - 1;

				// Set the player to face the direction of movement (direction
				// may change if we slide).
				m_facing.assign(getDirection(m_v));

				m_tileType = TILE_TYPE(boardCollisions(g_pBoard) | spriteCollisions());
			}

			// Start the render frame counter.
			if (isUser || (~m_tileType & TT_SOLID)) m_pos.loopFrame = LOOP_MOVE;

			// Do this after the above if, to prevent walking on the target board.
			m_tileType = TILE_TYPE(m_tileType | boardEdges(isUser));
		}
		else
		{
			// Set g_gamestate to GS_IDLE to accept user input for the selected player.
			if (isUser) g_gameState = GS_IDLE;

			// Clear any LOOP_DONE status.
			if (m_pos.loopFrame == LOOP_DONE) m_pos.loopFrame = LOOP_WAIT;
			
			// Clear any pathfinding status.
			m_pos.bIsPath = true;

		} // if (!m_pos.path.empty())
	} // if (.loopFrame < LOOP_MOVE)

	// Non-negative value corresponds to the frame of the movement.
	if (m_pos.loopFrame >= LOOP_MOVE)
	{
		// Movement is occurring.

		if (m_pos.bIsPath)
		{
			// Re-test for sprite collisions. The path was calculated
			// to avoid sprites but cannot account for moving sprites.

			// Do sprite collisions before push(), otherwise the two
			// will operate on different target locations.
			
			// Test every pixel.
			if (!((m_pos.loopFrame * PX_FACTOR) % m_pos.loopSpeed)) 
			{
				// Reassign the direction in case of alteration.
				m_facing.assign(getDirection(m_v));

				m_tileType = TILE_TYPE(m_tileType | boardEdges(isUser));

				// Check stairs.
				DB_POINT pt = m_pos.target;
				CVector sprBase = m_attr.vBase + pt;
				
				int dest = m_pos.l;
				for (std::vector<BRD_VECTOR>::const_iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
				{
					if ((i->type & TT_STAIRS) && (i->layer == m_pos.l) && i->pV->contains(sprBase, pt))
					{
						dest = i->attributes;
					}
				}
				m_pos.l = dest;
			
				if (spriteCollisions() & TT_SOLID)
				{
					// Try to find a diversion that allows the sprite to
					// resume the path.

					// Return true if diversion found to insert the new path.
					// Else, continue to end movement (no diversion found).
					if (findDiversion()) return true;

					m_tileType = TILE_TYPE(m_tileType | TT_SOLID);
				} 

			} // if (testing collisions)
		} // if (path)


		if (m_tileType & TT_SOLID)
		{
			if(isUser)
			{
				// Increment the user's frame always to indicate user input.
				++m_pos.loopFrame;				// Count of this movement's renders.
				++m_pos.frame;					// Total frame count (for animation frames).
			}
		}
		else
		{
			// Push the sprite only when the tiletype is passable.
			push(isUser);
			++m_pos.loopFrame;
			++m_pos.frame;
		}

		if ((m_tileType & TT_SOLID) ||
			sgn(m_pos.target.x - m_pos.x) != sgn(m_v.x) ||
			sgn(m_pos.target.y - m_pos.y) != sgn(m_v.y))
		{
			// If we've moved past one of the targets or we're
			// walking against a wall, stop.

			// Do not pop until the movement has finished.
			if (!m_pos.path.empty())
			{
				m_pos.path.pop_front();
			}
			else
			{
				// Only advance to the next point on the waypoint path
				// if the previous point has been reached (the tiletype
				// check satisfies this).
				if (~m_tileType & TT_SOLID)
				{
					m_brdData.boardPath.advance();
				}
			}

			if (~m_tileType & TT_SOLID)
			{
				m_pos.x = m_pos.target.x;
				m_pos.y = m_pos.target.y;
			}

			// Start the idle timer.
			m_pos.idle.time = GetTickCount();

			// Set the state to LOOP_DONE so as to immediately
			// increment the frame when movement starts again
			// (for pixel movement).
			m_pos.loopFrame = LOOP_DONE;

			// Wake up any thread that this sprite has control over
			// if the path is empty (i.e. a thread-set movement has just finished).
			if (m_thread && m_pos.path.empty())
			{
				m_thread->wakeUp();
				m_thread = NULL;
			}

			// Finish the move for the selected player.
			if (isUser && !bRunningProgram) 
			{
				// Programs cannot be run from within the 
				// main movement loop (gameLogic()) because
				// they may add or erase players from g_sprites.
				// Instead, hold the result until after.

				m_bDoneMove = true;

				// Back to idle state (accepting input)
				g_gameState = GS_IDLE;
			}
		}
		else
		{
			// Do program/fight tests every move for sprites on a path.
			if (m_pos.bIsPath && isUser && !bRunningProgram) 
			{
				m_bDoneMove = true;
			}
		} // if (movement ended)

		// Return true for a set path only (not a board path).
		if (!m_pos.path.empty()) return true;

	} // if (movement occurred)

	return false;
}

/*
 * Complete a single frame's movement of the sprite.
 * Return true if movement occurred.
 */
bool CSprite::push(const bool bScroll) 
{
	extern RECT g_screen;
	extern LPBOARD g_pBoard;

	// Pixels per frame (tile or pixel movement - not moveSize()).
	const double stepSize = double(PX_FACTOR) / m_pos.loopSpeed;
	// Integer values to scroll.
	int scx = -round(m_pos.x), scy = -round(m_pos.y);

	m_pos.x += stepSize * m_v.x;
	m_pos.y += stepSize * m_v.y;

	scx += round(m_pos.x); scy += round(m_pos.y);

	// Scroll the board for players. Either set for all players, or only selected player
	// and create a Scroll RPGCode function so that scrolling can be achieved without having
	// to use invisible players.

	if (bScroll)
	{
		// Bitshift in place of divide by two (>> 1 equivalent to / 2)
		if ((m_v.y < 0 && m_pos.y < (g_screen.top + g_screen.bottom >> 1) && g_screen.top > 0) ||
			// North. Scroll if in upper half of screen.
			(m_v.y > 0 && m_pos.y > (g_screen.top + g_screen.bottom >> 1) && g_screen.bottom < g_pBoard->pxHeight()))
			// South. Scroll if in lower half of screen.
		{
			const int height = g_screen.bottom - g_screen.top;
			g_screen.top += scy;

			// Check bounds.
			if (g_screen.top < 0) g_screen.top = 0;
			else if (g_screen.top + height > g_pBoard->pxHeight()) g_screen.top = g_pBoard->pxHeight() - height;

			g_screen.bottom = g_screen.top + height;
		}

		if ((m_v.x < 0 && m_pos.x < (g_screen.left + g_screen.right >> 1) && g_screen.left > 0) ||
			// West. Scroll if in left half of screen.
			(m_v.x > 0 && m_pos.x > (g_screen.left + g_screen.right >> 1) && g_screen.right < g_pBoard->pxWidth()))
			// East. Scroll if in right half of screen.
		{
			const int width = g_screen.right - g_screen.left;
			g_screen.left += scx;

			if (g_screen.left < 0) g_screen.left = 0;
			else if (g_screen.left + width > g_pBoard->pxWidth()) g_screen.left = g_pBoard->pxWidth() - width;

			g_screen.right = g_screen.left + width;
		}
	} // if (isUser)

	return true;
}

/*
 * Try to find a diversion that allows the sprite to resume the path.
 */
bool CSprite::findDiversion(void)
{
	if (m_pos.path.empty())
	{
		// m_path is empty for board paths.

		// Create a local copy to preserve the current one.
		SPR_BRDPATH path = m_brdData.boardPath;
		DB_POINT pt = m_pos.target;
		PF_PATH p;

		// Note to self: are m_pos.target and path.getNextNode() different?

		// Do [size + 1] iterations to include the initial target.
		for (int i = 0; i <= path.size(); ++i, path.advance())
		{
			// Pass PF_QUIT_BLOCKED for the last point.
			const int flags = (path() ? PF_AVOID_SPRITE : PF_AVOID_SPRITE | PF_QUIT_BLOCKED);
			p = pathFind(pt.x, pt.y, PF_PREVIOUS, flags);

			if (!p.empty()) break;
			else p.clear();

			// Advance before obtaining node to preserve nextNode if path is found.
			if (!path()) break;
			pt = path.getNextNode();
		}

		if (p.empty())
		{
			// m_brdData.boardPath has not changed, hence the sprite
			// can continue the path if it becomes free to move again.
		}
		else
		{
			// Update m_brdData.boardPath because a diversion was found.
			m_brdData.boardPath = path;	

			// Set the diversion.
			setQueuedPath(p, false);
			return true;
		}
	}
	else
	{
		// Copy path to append later.
		MV_PATH path = m_pos.path;		
		PF_PATH p;
		for (MV_PATH::iterator i = path.begin(); i != path.end(); ++i)
		{
			// Try each point along the path in turn.

			const int flags = (i != path.end() - 1 ? PF_AVOID_SPRITE : PF_AVOID_SPRITE | PF_QUIT_BLOCKED);
			p = pathFind(i->x, i->y, PF_PREVIOUS, flags);

			if (!p.empty()) break;
			else p.clear();
		}

		// Was a path to some point found?
		if (p.empty())
		{
			// Cannot resume.
			clearQueue();
		}
		else
		{
			// Set the diversion and append the partial old path.
			setQueuedPath(p, true);
			// Miss the first point of partial path to avoid duplication.
			if (++i != path.end())
			{
				m_pos.path.insert(m_pos.path.end(), i, path.end());
			}
			return true;
		}
	} // if (m_pos.path.empty())
	return false;
}

/*
 * Take the angle of movement and return a MV_ENUM direction.
 */
MV_ENUM CSprite::getDirection(const DB_POINT &unitVector)
{
	extern LPBOARD g_pBoard;

	double angle = 90.0;

	// Convert the isometric angle to a "face down" angle
	// that corresponds to the implied direction, and that can 
	// be used along with non-iso boards.
	// arctan returns -pi/2 to +pi/2 radians (-90 to +90 degrees).
	if (unitVector.x) angle = RADIAN * (g_pBoard->isIsometric() ?
							  atan(2 * unitVector.y / unitVector.x) : 
							  atan(unitVector.y / unitVector.x));

	if (angle == 0.0 && unitVector.x < 0.0) angle = 180.0;
	// Correct for negatives.
	if (angle < 0.0) angle += 180.0;
	// Correct for inversion.
	if (unitVector.y < 0.0) angle += 180.0;

	return MV_ENUM((round(angle / 45.0) % 8) + 1);
}

/*
 * Get the target coordinates - either the next point on a path
 * or the ultimate target.
 */
DB_POINT CSprite::getTarget(void) const
{
	if (m_bPxMovement || m_pos.bIsPath)
	{
		// Pixels travelled this move.
		const int step = moveSize();
		const DB_POINT p = {m_pos.x + step * m_v.x,
							m_pos.y + step * m_v.y};
		return p;
	}
	return m_pos.target;
}

/*
 * Insert target co-ordinates based on a direction.
 */
void CSprite::setTarget(MV_ENUM direction) 
{
	extern LPBOARD g_pBoard;
	extern const double g_directions[2][9][2];

	const int nIso = int(g_pBoard->isIsometric());

	// Pixels travelled this move.
	const int step = moveSize();

	// The "movement vector" - a unit-like vector in the current direction.
	// g_directions[isIsometric()][MV_CODE][x OR y].
	m_v.x = g_directions[nIso][direction][0];
	m_v.y = g_directions[nIso][direction][1];

/*
	if (nIso == 1 && !m_bPxMovement && m_v.x && !m_v.y)
	{
		// Cause players to move twice as far for East/West in tile movement.
		m_v.x *= 2;
	}
*/
	m_pos.target.x = m_pos.x + m_v.x * step;
	m_pos.target.y = m_pos.y + m_v.y * step;
}

/*
 * Insert target co-ordinates from the path.
 */
void CSprite::setPathTarget(void)
{
	if (!m_pos.path.empty())
	{
		m_pos.target = m_pos.path.front();
	}
	else if (m_brdData.boardPath())
	{
		// Do not queue up the point - an empty queue signifies a board path.
		m_pos.target = m_brdData.boardPath.getNextNode();
	}
	else return;

	const double dx = m_pos.target.x - m_pos.x,
				 dy = m_pos.target.y - m_pos.y;
	const double dmax = fabs(dx) > fabs(dy) ? fabs(dx) : fabs(dy);

	// Scale the vector.
	if (dmax)
	{
		m_v.x = dx / dmax;
		m_v.y = dy / dmax;
	}
}

/*
 * Parse a Push() string and pass to setQueuedMovement().
 */
void CSprite::parseQueuedMovements(const STRING str, const bool bClearQueue)
{
	extern MAIN_FILE g_mainFile;
	STRING s;

	// Break out of the current movement.
	if (bClearQueue) clearQueue();

	// Should step = 8 for pixel push?
	const int step = (g_mainFile.pixelMovement == MF_PUSH_PIXEL ? moveSize() : 32);

	// Include str.end() in the loop to catch the last movement.
	for (STRING::const_iterator i = str.begin(); i <= str.end(); ++i)
	{
		if (i == str.end() || i[0] == _T(','))
		{
			MV_ENUM mv = MV_IDLE;
			if (!s.compare(_T("NORTH")) || !s.compare(_T("N")) || !s.compare(MVQ_NORTH))
				mv = MV_N;
			else if (!s.compare(_T("SOUTH")) || !s.compare(_T("S")) || !s.compare(MVQ_SOUTH))
				mv = MV_S;
			else if (!s.compare(_T("EAST")) || !s.compare(_T("E")) || !s.compare(MVQ_EAST))
				mv = MV_E;
			else if (!s.compare(_T("WEST")) || !s.compare(_T("W")) || !s.compare(MVQ_WEST))
				mv = MV_W;
			else if (!s.compare(_T("NORTHEAST")) || !s.compare(_T("NE")) || !s.compare(MVQ_NE))
				mv = MV_NE;
			else if (!s.compare(_T("NORTHWEST")) || !s.compare(_T("NW")) || !s.compare(MVQ_NW))
				mv = MV_NW;
			else if (!s.compare(_T("SOUTHEAST")) || !s.compare(_T("SE")) || !s.compare(MVQ_SE))
				mv = MV_SE;
			else if (!s.compare(_T("SOUTHWEST")) || !s.compare(_T("SW")) || !s.compare(MVQ_SW))
				mv = MV_SW;

			if (mv != MV_IDLE) setQueuedMovement(mv, false, step);
			s.erase();
		}
		else
		{
			if (i[0] != _T(' ')) s += *i;
		}
	} // for (i)

}

/*
 * Clear the queue.
 */
void CSprite::clearQueue(void)
{
	if (m_pos.loopFrame != LOOP_DONE) m_pos.loopFrame = LOOP_WAIT;
	
	m_pos.target.x = m_pos.x;
	m_pos.target.y = m_pos.y;
	m_pos.path.clear();
}

/*
 * Place a movement in the sprite's queue.
 */
void CSprite::setQueuedMovement(const int direction, const bool bClearQueue, int step)
{
	// Break out of the current movement.
	if (bClearQueue) clearQueue();
	m_pos.bIsPath = false;

	extern LPBOARD g_pBoard;
	extern const double g_directions[2][9][2];

	const int nIso = int(g_pBoard->isIsometric());

	// Pixels travelled this move, optionally overriden for rpgcode commands.
	if (!step) step = moveSize();

	// g_directions[isIsometric()][MV_CODE][x OR y].
	const double x = g_directions[nIso][direction][0], y = g_directions[nIso][direction][1];

	/** if (nIso == 1 && !m_bPxMovement && x && !y)
	{
		// Cause players to move twice as far for East/West in tile movement.
		m_v.x *= 2;
	} **/

	DB_POINT dest;
	getDestination(dest);

	DB_POINT p = {dest.x + x * step, dest.y + y * step};	
	m_pos.path.push_back(p);
}

/*
 * Run all the movements in the queue.
 */
void CSprite::runQueuedMovements(void) 
{
	extern CPlayer *g_pSelectedPlayer;
	extern CCanvas *g_cnvRpgCode;
	extern void processEvent();

	while (move(g_pSelectedPlayer, true))
	{
		renderNow(g_cnvRpgCode, true);
		renderRpgCodeScreen();
		processEvent();
	}
}

/*
 * Get the destination.
 */
void CSprite::getDestination(DB_POINT &p) const
{
	if (m_pos.path.empty())
	{
		// The origin of the current movement or the target
		// of the previous movement (origin = target on arrival).
		// Note to self - the origin will always equal pos whilst path has points
		// because the last point isn't cleared until movement ends. (Delano)

		p.x = m_pos.x;
		p.y = m_pos.y;
	}
	else
	{
		// The ultimate destination.
		p = m_pos.path.back();
	}
}

/*
 * Queue up a path-finding path.
 */
void CSprite::setQueuedPath(PF_PATH &path, const bool bClearQueue)
{
	if (bClearQueue) clearQueue();

	// PF_PATH is a std::vector<DB_POINT> with the points stored in reverse.
	PF_PATH::reverse_iterator i = path.rbegin();
	for (; i != path.rend(); ++i)
	{
		m_pos.path.push_back(*i);
	}
}

/*
 * Pathfind to pixel position x, y (same layer).
 */
PF_PATH CSprite::pathFind(const int x, const int y, const int type, const int flags)
{
	extern LPBOARD g_pBoard;
	if (x > 0 && x <= g_pBoard->pxWidth() && y > 0 && y <= g_pBoard->pxHeight())
	{
		const DB_POINT start = {m_pos.x, m_pos.y}, goal = {x, y};

		return CPathFind::pathFind(
			&m_pPathFind,
			start, 
			goal, 
			m_pos.l,
			type,
			this,
			flags
		);
	}
	return PF_PATH();
}

/*
 * Complete the selected player's move.
 */
void CSprite::playerDoneMove(void) 
{
	// Check if the selected player just completed a move.
	if (!m_bDoneMove) return;
	m_bDoneMove = false;

	extern GAME_STATE g_gameState;
	extern unsigned long g_pxStepsTaken;

	// Update the step count (number of pixels moved).
	const int step = moveSize();
	g_pxStepsTaken += step;

	// Movement in a program should not trigger other programs.
	programTest(false);
	fightTest(step);
}

/*
 * Set the sprite's pixel target and current locations, based on
 * the type of co-ordinate system.
 */
void CSprite::setPosition(int x, int y, const int l, const COORD_TYPE coord)
{
	extern LPBOARD g_pBoard;

	// Convert the co-ordinates an absolute pixel value.
	coords::tileToPixel(x, y, coord, true, g_pBoard->sizeX);
	m_pos.target.x = m_pos.x = x;
	m_pos.target.y = m_pos.y = y;
	m_pos.l = l;

	// Take this command to mean movement has halted.
	m_pos.path.clear();
	m_pos.loopFrame = LOOP_DONE;
}

/*
 * Initiate movement by program type.
 */
void CSprite::doMovement(const CProgram *prg, const bool bPauseThread)
{
	extern bool g_multirunning;

	if (prg->isThread())
	{
		if (bPauseThread)
		{
			// Hold thread execution until this command is finished.

			// Free any current thread.
			if (m_thread) m_thread->wakeUp();
			// Give thread control to the sprite.
			m_thread = (CThread *)prg;
			// Pause the thread indefinitely (until movement ends).
			m_thread->sleep(0);
		}
		else
		{
			// Continue program execution, run movements concurrently.
		}
	}
	else
	{
		if (!g_multirunning)
		{
			runQueuedMovements();
		}
		else 
		{
			// Hold movement until MultiRun closes, then run.
		}
	}
}

/*
 * Assign a board vector as a path.
 */
void CSprite::setBoardPath(CVector *const pV, const int cycles, const int flags)
{
	if (flags & tkMV_WAYPOINT_LINK)
	{
		m_brdData.boardPath.pVector = pV;
		m_brdData.boardPath.cycles = cycles;
		m_brdData.boardPath.nextNode = 0;
		m_brdData.boardPath.attributes = flags;
	}
	else
	{
		// Standard queued path.
		for (int i = 0; i < cycles; ++i)
		{
			for (unsigned int j = 0; j != pV->size(); ++j) m_pos.path.push_back((*pV)[j]);
		}
	}
}

/*
 * Collision detection.
 */

/*
 * Check against each board vector and build up a set of flags 
 * describing all tiletypes at this point. Evaluate one-way vectors
 * and sprite sliding (angled movement along solid boundaries).
 */
TILE_TYPE CSprite::boardCollisions(LPBOARD board, const bool recursing)
{
	TILE_TYPE tileTypes = TT_NORMAL;

	// Ignore board collisions when running a path since the routine
	// should have avoided collisions and negotiating any minor collisions
	// on a path is tedious.

	DB_POINT p = m_pos.target;
	CVector sprBase = m_attr.vBase + p;
	int layer = m_pos.l;				// Destination layer.

	// Loop over the board CVectors and check for intersections.
	for (std::vector<BRD_VECTOR>::iterator i = board->vectors.begin(); i != board->vectors.end(); ++i)
	{
		if (i->type == TT_UNDER || i->layer != m_pos.l) continue;

		TILE_TYPE tt = TT_NORMAL;

		// Check that the board vector contains the player,
		// *not* the other way round!
		if (i->pV->contains(sprBase, p))
		{
			tt = i->type;
		}

		/*
		 * If an intersection was found, p now holds a position vector
		 * parallel to the board subvector that was hit. Use this to 
		 * evaluate the vector's type for one-way and sliding movement.
		 */

		if (tt & TT_STAIRS)
		{
			// Hold the target layer, stored in tagBoardVector.attributes.
			layer = i->attributes;
		}			

		// Problem: corners on UNIDIRECTIONALs - more distant vector is
		// sometimes detected, and if the corner angle is <= 90, the wrong
		// result will be given.

		if (tt & TT_UNIDIRECTIONAL)
		{
			// Use the returned point to determine the direction of approach 
			// by crossing it with the sprite's movement vector. 
			if (p.x * m_v.y - p.y * m_v.x >= 0)
			{
				// Crossing boundary from the solid side.
				tt = TT_SOLID;
			}
			else
			{
				tt = TT_NORMAL;
			}
		}

		if ((tt & TT_SOLID) && !recursing && m_bPxMovement)
		{
			/*
			 * Compute the angle between the movement vector and
			 * the subvector to determine if we should _T("slide").
			 * If the angle is greater than 45 (or chosen other),
			 * try rotating the movement direction and evalutate
			 * the board vectors again at the new target.
			 * The facing direction is maintained to indicate the player
			 * is sliding.
			 * Do not slide for tile movement though!
			 */

			// Using the scalar (dot) product: a.b = |a||b|cos(c).
			// |a| is the magnitude of a.
			// a.b = a.x * b.x + a.y * b.y.
			// c = arccos(a.b / |a||b|), in the range 0 to 180 degrees.
			double angle = RADIAN * 
							acos(
								(p.x * m_v.x + p.y * m_v.y) / 
								sqrt(
										(p.x * p.x + p.y * p.y) * 
										(m_v.x * m_v.x + m_v.y * m_v.y)
									)
								);
			
			// However this doesn't give us enough information to 
			// identify the angle we've measured, so we need to use 
			// the cross product too (see below).

			// Slide if angle <= 45 or >= 135 degrees (2D), <= 63, >= 117 (iso).
			angle  = int(angle + 0.5) - 90.0;
			
			if (abs(angle) >= (board->isIsometric() ? 27.0 : 45.0))
			{
				// Work out which direction to rotate to.

				// Vector (cross) product returns a vector in the z-plane.
				// a x b = |a||b|sin(c) = (a.x * b.y - a.y * b.x)

				const double normal = (p.x * m_v.y - p.y * m_v.x);

				// If angle and normal are both positive or negative,
				// p is to the "right" of m_v (negative being the flipped case).
				// Otherwise, p is to the "left" of m_v.

				if ((angle > 0) == (normal > 0))
					// Rotate right. Reinsert the target and test again.
					setTarget(m_facing.right());
				else
					// Rotate left.
					setTarget(m_facing.left());

				// Recurse on the new target - evaluate all vectors and
				// return, rather than pausing as it has here.
				tt = boardCollisions(board, true);
				if (tt & TT_SOLID) 
				{
					// Target blocked.

					// Recurse once more in the opposite direction.
					if ((angle > 0) == (normal > 0))
						setTarget(m_facing.left());
					else
						setTarget(m_facing.right());

					tt = boardCollisions(board, true);
					if (tt & TT_SOLID) 
					{
						// Restore.
						setTarget(m_facing.dir());
						tt = TT_SOLID;
					}
					else return tt;
				}
				else return tt;
			} // if (abs(angle) <= 45.0)
		} // if (intersect)

		// Add this result, retaining previous vectors.
		tileTypes = TILE_TYPE(tileTypes | tt);

	} // for (i)

	// Move the player to the target layer (if stairs were encountered).
	m_pos.l = layer;

	return tileTypes;
}

/*
 * Check for collisions with other sprite base vectors. Currently only
 * returns TT_SOLID or TT_NORMAL, as all sprites default to solid.
 * Also, z-order sprites.
 */
TILE_TYPE CSprite::spriteCollisions(void)
{
	extern ZO_VECTOR g_sprites;
	extern LPBOARD g_pBoard;

	/*
	 * Check for collisions against all sprites and return the tiletype
	 * (currently only solid or normal, but sprites could be given their
	 * own tiletypes).
	 * Also z-order sprites as we search for collisions:
	 * z-ordered (ZO) sprite pointers are stored in g_sprites.
	 * Upon board loading, the initial ZO is calculated for all sprites.
	 * We only need to alter that order when a sprite moves, and then
	 * we only need to recalculate that sprite's ZO - the others' are preserved.
	 * Hence we remove the pointer from g_sprites, make the checks
	 * and reinsert afterwards.
	 * The position to insert will be the in front of the first pointer
	 * we find that is below this sprite.
	 */

	std::vector<CSprite *>::iterator i = g_sprites.v.begin(), pos = NULL;

	// Find this sprite's iterator in the z-ordered vector.
	for (; i != g_sprites.v.end(); ++i)
	{
		if (this == *i) break;
	}

	// Remove the pointer from the vector if it was found.
	if (i != g_sprites.v.end()) g_sprites.v.erase(i);

	TILE_TYPE result = TT_NORMAL;			// To return.

	// Create this sprite's vector base at the *target* location.
	CVector sprBase = m_attr.vBase + getTarget();
	const RECT bounds = sprBase.getBounds();

	for (i = g_sprites.v.begin(); i != g_sprites.v.end(); ++i)
	{
		if (m_pos.l > (*i)->m_pos.l)
		{
			// *i is on a lower layer and is drawn before this.
			// We want to insert this somewhere after *i.
			// Also, we haven't collided with it.
			continue;
		}
		if (m_pos.l < (*i)->m_pos.l)
		{
			// *i is on a higher layer, so we want to insert this somewhere
			// before *i. If this is the *first* encounter of a sprite
			// that is due to be drawn after this sprite, then we want
			// to insert this before *i. pos is the iterator position
			// we are going to insert this in front of.
			if (!&*pos) pos = i;

			// Also, we haven't collided with it.
			continue;
		}

		// Compare target bases.

		// Compare this sprite's target to others' current positions.
		const DB_POINT pt = {(*i)->m_pos.x, (*i)->m_pos.y};
		CVector tarBase = (*i)->m_attr.vBase + pt;
		const RECT tBounds = tarBase.getBounds();

		const ZO_ENUM zo = tarBase.contains(sprBase);

		if (!zo && !&*pos)
		{
			// No rect intersect - compare on bounding box bottom-left
			// corner position.
			if ((bounds.bottom * g_pBoard->pxWidth() + bounds.left) <
				(tBounds.bottom * g_pBoard->pxWidth() + tBounds.left))
				pos = i;
		}
		else if (!(zo & ZO_ABOVE) && !&*pos)
		{
			// If below sprite, we want to insert before i, but only
			// if we don't have an insertion point already.
			pos = i;
		}

		if (zo & ZO_COLLIDE)
		{
			// Hit another player.
			// Record result and continue, to determine z-ordering
			// against all sprites.
			result = TT_SOLID;

			// If we already have an insertion point, no need to continue.
			if (&*pos) break;
		}

		// Compare origins? Merge origins and targets? (how?)
	}

	if (!&*pos)
		g_sprites.v.push_back(this);
	else
		g_sprites.v.insert(pos, this);

	return result;
}

/*
 * Tests for movement at the board edges, return evaluated tile type.
 * TT_SOLID if: movement was blocked, either by a solid target tile on next board,
 *				or there was no link, or the link file was a program,
 *				or bSend was true (and a link was possible).
 * TT_NORMAL if:movement was allowed, either if the player was not at an edge, or
 *				if the player moved to a new board.
 */
TILE_TYPE CSprite::boardEdges(const bool bSend)
{
	extern STRING g_projectPath;
	extern LPBOARD g_pBoard;
	extern GAME_STATE g_gameState;
	extern CAllocationHeap<BOARD> g_boards;

	// Return normal for npcs and assume the user knows what
	// they are doing. Wandering sprites are constrained
	// in Wander(), so this isn't a problem for them.
	if (!bSend) return TT_NORMAL;

	LK_ENUM link = LK_NONE;
	const RECT r = m_attr.vBase.getBounds();
	const DB_POINT p = getTarget();

	// Check if any part of the vector base is off an edge.
	if (r.top + p.y < 0) link = LK_N;
	else if (r.bottom + p.y > g_pBoard->pxHeight()) link = LK_S;
	else if (r.right + p.x > g_pBoard->pxWidth()) link = LK_E;
	else if (r.left + p.x < 0) link = LK_W;

	// Not off an edge.
	if (link == LK_NONE) return TT_NORMAL;

	// This corresponds to the order links are stored in the board format.
	const STRING &fileName = g_pBoard->links[link];

	// No board exists.
	if (fileName.empty()) return TT_SOLID; 

	if (_stricmp(getExtension(fileName).c_str(), _T("prg")) == 0)
	{
		// This is a program.
		CProgram(g_projectPath + PRG_PATH + fileName).run();
		// Block movement.
		return TT_SOLID;
	}

	LPBOARD pBoard = g_boards.allocate();
	pBoard->open(g_projectPath + BRD_PATH + fileName);

	// Determine the target co-ordinates from the direction and current location.
	// Work on m_pos rather than pos so that boardCollisions() operates
	// with the correct co-ordinates.
	const DB_POINT pos = {m_pos.x, m_pos.y};

	// Place sprite so base is touching the edge of the board, aligned
	// to the grid dictated by moveSize() -- possibly should be only
	// 8px or 32px, to make it uniform for all users.
	const int mvSize = (m_bPxMovement ? 8.0 : 32.0); // = moveSize();
	const double width = (r.right - r.left) + (mvSize - (r.right - r.left) % mvSize),
				height = (r.bottom - r.top) + (mvSize - (r.bottom - r.top) % mvSize),
				offset = (pBoard->isIsometric() ? 0.0 : 32.0);

	switch (link)
	{
		case LK_N:
			// North
			m_pos.y = pBoard->pxHeight();

            if (!m_bPxMovement && pBoard->isIsometric())
                m_pos.y -= (int(pos.y) % 32 != int(m_pos.y) % 32 ? 16.0 : 32.0);
			else
				m_pos.y -= (pBoard->isIsometric() ? height : 32.0);

			break;

		case LK_S:
			// South
            if (!m_bPxMovement && pBoard->isIsometric())
                m_pos.y = (int(pos.y) % 32 ? 16.0 : 32.0);
			else
				m_pos.y = (height - offset < BASE_POINT_Y ? BASE_POINT_Y : height - offset);

			break;

		case LK_E:
			// East
			m_pos.x = (width - offset < BASE_POINT_X ? BASE_POINT_X : width - offset);
			break;

		case LK_W:
			// West
			m_pos.x = pBoard->pxWidth() - width;
	}

	// Update the target co-ordinates for boardCollisions().
	setPosition(m_pos.x, m_pos.y, m_pos.l, PX_ABSOLUTE);

	// Check the target board extends to the player's location.
	if (m_pos.x > pBoard->pxWidth() || 
		m_pos.y > pBoard->pxHeight() || 
		m_pos.l > pBoard->sizeL ||
		boardCollisions(pBoard) == TT_SOLID)		// Tiletype at target.
	{
		// Restore.
		setPosition(pos.x, pos.y, m_pos.l, PX_ABSOLUTE);
		g_boards.free(pBoard);
		return TT_SOLID;
	}

	// Prevent the player from moving on the next board.
	m_pos.loopFrame = LOOP_DONE;

	g_boards.free(pBoard);
	g_pBoard->open(g_projectPath + BRD_PATH + fileName);
	send();

	// Accept user input.
	g_gameState = GS_IDLE;

	// The target wasn't blocked and the send succeeded.
	return TT_NORMAL;
}

/*
 * Unconditionally send the sprite to a new board.
 * Assumes g_activeBoard already loaded.
 */
void CSprite::send(void)
{
	extern STRING g_projectPath;
	extern CCanvas *g_cnvRpgCode;
	extern LPBOARD g_pBoard;

	extern RECT g_screen;
	extern SCROLL_CACHE g_scrollCache;
	alignBoard(g_screen, true);
	g_scrollCache.render(true);

	extern ZO_VECTOR g_sprites;
	g_sprites.zOrder();
	CPathFind::freeAllData();

	// Ensure that programs the player is standing on don't run immediately.
	deactivatePrograms();

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();

	extern CAudioSegment *g_bkgMusic;
	// Open file regardless of existence.
	g_bkgMusic->open(g_pBoard->bkgMusic);
	g_bkgMusic->play(true);

	if (!g_pBoard->enterPrg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + g_pBoard->enterPrg).run();
	}
}

/*
 * For the player (or potentially any other sprite), check for program
 * vectors or sprite active bases. Sprites have a second vector that is
 * the area the player must be in to trigger the program.
 * Players take precedence over items, over programs (could be altered).
 */
bool CSprite::programTest(const bool keypressOnly)
{
	extern std::vector<CPlayer *> g_players;
	extern MAIN_FILE g_mainFile;
	extern LPBOARD g_pBoard;
	extern STRING g_projectPath;

	CONST HKL hkl = GetKeyboardLayout(0);

	// Create the sprite's vector base at the *target* location (for the
	// case of pressing against an item, etc.)
	// We want to use the player's *solid* base (not any active vector it may have).
	DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;

	/** Currently unused
	// Players 
	for (std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		if (this == *i || m_pos.l != (*i)->m_pos.l) continue;

		DB_POINT pt = {(*i)->m_pos.x, (*i)->m_pos.x};
		CVector tarActivate = (*i)->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p))
		{
			// Standing in another player's area.
		}
	} **/

	CItem *itm = NULL; DB_POINT f = {0, 0}; double fs = -1;

	// Items
	for (std::vector<CItem *>::iterator j = g_pBoard->items.begin(); j != g_pBoard->items.end(); ++j)
	{
		CItem *pItm = *j;

		// Some item entries may be NULL since users
		// can insert items at any slot number.
		if (!pItm || this == pItm || !pItm->isActive() || m_pos.l != pItm->m_pos.l) continue;
		if (pItm->m_brdData.prgActivate.empty()) continue;

		const DB_POINT pt = {pItm->m_pos.x, pItm->m_pos.y};

		CVector tarActivate = pItm->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p))
		{
			// Standing in an item's area.
			// Are we facing this item?
			// Are there any other items that are closer?

			// The separation of the two sprites (should use centre-points of m_bounds).
			const DB_POINT s = {pItm->m_pos.x - m_pos.x, pItm->m_pos.y - m_pos.y};
			
			// Is the target in the facing direction?
			const DB_POINT d = {double(sgn(s.x) == m_v.x), double(sgn(s.y) == m_v.y)};

			// This item is less directly in front of the player.
			if (d.x + d.y < f.x + f.y) continue;

			const double ds = s.x * s.x + s.y * s.y; 
			if (d.x + d.y == f.x + f.y)
			{
				// Check the separation when we 
				// can't determine on direction alone.
				if (ds > fs && fs != -1) continue;
			}

			if (pItm->m_brdData.activationType & SPR_KEYPRESS)
			{
				// General activation key. GetAsyncKeyState is
				// negative if key is currently down.
				const short state = GetAsyncKeyState(MapVirtualKeyEx(g_mainFile.key, 1, hkl));
				if (state >= 0) continue;
			}
			else if (keypressOnly) continue;

			// Check activation conditions.
			if (pItm->m_brdData.activate == SPR_CONDITIONAL)
			{
				if (CProgram::getGlobal(pItm->m_brdData.initialVar)->getLit() != pItm->m_brdData.initialValue)
				{
					// Activation conditions not met.
					continue;
				}
			}

			// Hold on to these results.
			f = d; itm = pItm; fs = ds;
		}
	}

	if (itm)
	{
		// Stop the player's movement - assume interaction with an
		// item should always stop movement (else introduce SPR_STOPS_MOVEMENT flag).
		clearQueue();

		// Make the item look at this sprite.
		const DB_POINT pt = {m_pos.x - itm->m_pos.x, m_pos.y - itm->m_pos.y};
		itm->m_facing.assign(getDirection(pt));
		renderNow(NULL, false);

		// If we go to a new board in this program, we kill
		// this pointer, so save the values we need.
		const short activate = itm->m_brdData.activate;
		const STRING finalValue = itm->m_brdData.finalValue;
		const STRING finalVar = itm->m_brdData.finalVar;

		// Set the source and target types.
		extern ENTITY g_target, g_source;
		extern CPlayer *g_pSelectedPlayer;
		const ENTITY t = g_target, s = g_source;

		g_source.p = itm;
		g_target.p = g_pSelectedPlayer;
		g_source.type = ET_ITEM;
		g_target.type = ET_PLAYER;

		if (CFile::fileExists(g_projectPath + PRG_PATH + itm->m_brdData.prgActivate))
		{
			CProgram(g_projectPath + PRG_PATH + itm->m_brdData.prgActivate).run();
		}
		else
		{
			CProgram p;
			p.loadFromString(itm->m_brdData.prgActivate);
			p.run();
		}

		// Restore the source and target.
		g_source = s;
		g_target = t;

		// Set the requested variable after the program is complete.
		if (activate == SPR_CONDITIONAL)
		{
			LPSTACK_FRAME var = CProgram::getGlobal(finalVar);
			const double num = atof(getAsciiString(finalValue).c_str());
			if (num != 0.0)
			{
				var->udt = UDT_NUM;
				var->num = num;
			}
			else
			{
				var->udt = UDT_LIT;
				var->lit = finalValue;
			}
		}
		return true;
	}

	// Programs

	std::vector<LPBRD_PROGRAM>::iterator k = g_pBoard->programs.begin();
	LPBRD_PROGRAM prg = NULL;

	for (; k != g_pBoard->programs.end(); ++k)
	{
		if (!*k) continue;

		// Local copy of the program to avoid derefencing.
		const BRD_PROGRAM bp = **k;
		double *const distance = &(*k)->distance;

		if (bp.layer != m_pos.l) continue;

		// Check that the board vector contains the player.
		// We check *every* vector, in order to reset the 
		// distance of those we have left.
		if (!bp.vBase.contains(sprBase, p))
		{
			// Not inside this vector. Set the distance to the 
			// value to trigger program when we re-enter.
			if (bp.activationType & PRG_REPEAT) 
			{
				*distance = bp.distanceRepeat;
			}
			else
			{
				*distance = 0;
			}
		}
		else
		{
			// Standing in a program activation area.

			// Increase distance travelled within the vector.
			*distance += moveSize();

			// Check activation conditions.
			if (bp.activationType & PRG_REPEAT)
			{
				// Repeat triggers - check player has moved
				// the required distance.
				if (*distance < bp.distanceRepeat) continue;
			}
			else
			{
				// Single trigger - check the player has moved at all,
				// but only in the case of step-activations (key-press
				// without the PRG_REPEAT can always trigger).
				if (!(bp.activationType & PRG_KEYPRESS))
				{
					if (*distance != moveSize()) continue;
				}
			}

			if (bp.activationType & PRG_KEYPRESS)
			{
				// General activation key - if not pressed, continue.
				const short state = GetAsyncKeyState(MapVirtualKeyEx(g_mainFile.key, 1, hkl));
				if (state >= 0) continue;
			}
			else if (keypressOnly) continue;

			// Check activation conditions.
			if (bp.activate == PRG_CONDITIONAL)
			{
				if (CProgram::getGlobal(bp.initialVar)->getLit() != bp.initialValue)
				{
					// Activation conditions not met.
					continue;
				}
			}

			// Conditions have been satisfied - save this iterator,
			// continue looping.
			prg = *k;
		}
	}

	if (prg)
	{
		if (prg->activationType & PRG_REPEAT) 
		{
			// Reset the distance for repeat activations - single activations
			// are cleared at the top of this loop.
			prg->distance = 0;
		}

		if (prg->activationType & PRG_STOPS_MOVEMENT)
		{
			// Clear the queue.
			clearQueue();
		}

		// If we go to a new board in this program, we kill
		// this pointer, so save the values we need.
		const short activate = prg->activate;
		const STRING finalValue = prg->finalValue;
		const STRING finalVar = prg->finalVar;

		if (CFile::fileExists(g_projectPath + PRG_PATH + prg->fileName))
		{
			CProgram(g_projectPath + PRG_PATH + prg->fileName, prg).run();
		}
		else
		{
			CProgram p;
			p.loadFromString(prg->fileName);
			p.run();
		}

		// Set the requested variable after the program is complete.
		if (activate == PRG_CONDITIONAL)
		{
			LPSTACK_FRAME var = CProgram::getGlobal(finalVar);
			const double num = atof(getAsciiString(finalValue).c_str());
			if (num != 0.0)
			{
				var->udt = UDT_NUM;
				var->num = num;
			}
			else
			{
				var->udt = UDT_LIT;
				var->lit = finalValue;
			}
		}
		return true;
	}
	return false;
}

/*
 * Deactivate any programs the player is standing on.
 * Specifically designed for moving to a new board and arriving on a
 * warp tile / other program. If users need to run programs when boards
 * load, they can use the "program to run on entering board".
 */
void CSprite::deactivatePrograms(void)
{
	extern LPBOARD g_pBoard;

	DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;

	std::vector<LPBRD_PROGRAM>::iterator i = g_pBoard->programs.begin();

	for (; i != g_pBoard->programs.end(); ++i)
	{
		if ((*i) && ((*i)->layer == m_pos.l) && (*i)->vBase.contains(sprBase, p))
		{
			// Standing in a program activation area.
			if ((*i)->activationType & PRG_REPEAT)
			{
				// Repeat triggers - set to minimum value.
				(*i)->distance = 0;
			}
			else
			{
				if (!((*i)->activationType & PRG_KEYPRESS))
				{
					// Single triggers - prevent from running until
					// player leaves area.
					(*i)->distance = moveSize();
				}
			}
		}
	} // for (programs)
}

/*
 * Draw the sprite's vector path.
 */
void CSprite::drawVector(CCanvas *const cnv)
{
	extern RECT g_screen;
	extern CPlayer *g_pSelectedPlayer;
	extern LPBOARD g_pBoard;
	extern MAIN_FILE g_mainFile;

/**	
	// Draw the target base one colour. (Debug).
	CVector sprBase = m_attr.vBase + getTarget();
	sprBase.draw(RGB(0, 255, 255), false, g_screen.left, g_screen.top, cnv);
**/
	if (g_mainFile.drawVectors & CV_DRAW_SPR_VECTORS)
	{
		// Draw the activation area.
		const DB_POINT p = {m_pos.x, m_pos.y};
		CVector sprBase = m_attr.vActivate + p;
		sprBase.draw(RGB(255, 255, 0), false, g_screen.left, g_screen.top, cnv);

		// Draw the current position base.
		sprBase = m_attr.vBase + p;
		sprBase.draw(RGB(255, 255, 255), false, g_screen.left, g_screen.top, cnv);
	}

	// Only drawing path and destination for selected player.
	if (this != g_pSelectedPlayer) return;

	if (g_mainFile.drawVectors & CV_DRAW_SP_PATH)
	{
		// Draw the path this sprite is on. 
		drawPath(cnv, g_mainFile.pathColor);
	}

	if (g_mainFile.drawVectors & CV_DRAW_SP_DEST_CIRCLE)
	{
		// Draw the destination circle.
		const int dx = 12, dy = 6/*g_pBoard->isIsometric() ? 6: 12*/;	
		DB_POINT pt = {0.0, 0.0};
		getDestination(pt);

		cnv->DrawEllipse(
			pt.x - dx - g_screen.left, 
			pt.y - dy - g_screen.top, 
			pt.x + dx - g_screen.left, 
			pt.y + dy - g_screen.top, 
			g_mainFile.pathColor
		);
	}
}

/*
 * Draw the path this sprite is on. Used when clicking
 * to move -- the player needs to be able to see where
 * the character is going.
 */
void CSprite::drawPath(CCanvas *const cnv, const LONG color)
{
	extern RECT g_screen;

	if (!m_pos.bIsPath ||
		(round(m_pos.x) == m_pos.target.x &&
		round(m_pos.y) == m_pos.target.y && 
		m_pos.path.empty())) return;

	const int x = m_pos.target.x - g_screen.left, y = m_pos.target.y - g_screen.top;

	// Draw to the first point of the queue.
	cnv->DrawLine(round(m_pos.x) - g_screen.left, round(m_pos.y) - g_screen.top, x, y, color);

	// Draw the queue.
	if (!m_pos.path.empty())
	{
		MV_PATH_ITR i = m_pos.path.begin();
		cnv->DrawLine(x, y,	i->x - g_screen.left, i->y - g_screen.top, color);

		for (; i != m_pos.path.end() - 1; ++i)
		{
			cnv->DrawLine(
				i->x - g_screen.left, 
				i->y - g_screen.top, 
				(i + 1)->x - g_screen.left, 
				(i + 1)->y - g_screen.top, 
				color
			);
		}
	}
}

/*
 * Form all players and items into a z-ordered vector.
 */
void tagZOrderedSprites::zOrder(void)
{
	extern std::vector<CPlayer *> g_players;
	extern LPBOARD g_pBoard;

	// Clear the current contents and re-insert the players and items.
	v.clear();
	// Reserve extra space for possible AddPlayers()/CreateItems().
	v.reserve(g_players.size() + g_pBoard->items.size() + 16);

	// Push one sprite onto the vector to start the process.
	v.push_back(g_players.front());

	// Run spriteCollisions for every player and item, inserting them
	// into v.
	for (std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		if ((*i)->isActive()) (*i)->spriteCollisions();
	}

	for (std::vector<CItem *>::iterator j = g_pBoard->items.begin(); j != g_pBoard->items.end(); ++j)
	{
		// Some item entries may be NULL since users
		// can insert items at any slot number.
		if (*j && (*j)->isActive()) (*j)->spriteCollisions();
	}
}

/*
 * Align a RECT to the sprite's location.
 */
void CSprite::alignBoard(RECT &rect, const bool bAllowNegatives)
{
	extern LPBOARD g_pBoard;
	const int width = rect.right - rect.left;
	const int height = rect.bottom - rect.top;

	if (g_pBoard->pxWidth() < width)
	{
		// Board smaller than screen.
		if (bAllowNegatives)
		{
			// Bitshift in place of divide by two (>> 1 equivalent to / 2)
			rect.left = (g_pBoard->pxWidth() - width) >> 1;
		}
		else
		{
			rect.left = 0;
		}
	}
	else
	{
		// Centre around the player.
		rect.left = m_pos.x - (width >> 1);
		if (rect.left < 0)
		{
			// Align to left of board.
			rect.left = 0;
		}
		if (rect.left + width > g_pBoard->pxWidth())
		{
			// Align to right of board.
			rect.left = g_pBoard->pxWidth() - width;
		}
	}

	if (g_pBoard->pxHeight() < height)
	{
		if (bAllowNegatives)
		{
			// Bitshift in place of divide by two (>> 1 equivalent to / 2)
			rect.top = (g_pBoard->pxHeight() - height) >> 1;
		}
		else
		{
			rect.top = 0;
		}
	}
	else
	{
		rect.top = m_pos.y - (height >> 1);
		if (rect.top < 0)
		{
			rect.top = 0;
		}
		if (rect.top + height > g_pBoard->pxHeight())
		{
			rect.top = g_pBoard->pxHeight() - height;
		}
	}

	rect.right = rect.left + width;
	rect.bottom = rect.top + height;
}

/*
 * Render functions.
 */

/*
 * Run a custom stance.
 */
void CSprite::customStance(const STRING stance, const CProgram *prg, const bool bPauseThread)
{
	extern CCanvas *g_cnvRpgCode;
	extern void processEvent();

	GFX_CUSTOM_MAP::iterator i = m_attr.mapCustomGfx.find(stance);
	if (i == m_attr.mapCustomGfx.end()) return;

	m_pos.pAnm = i->second.pAnm->m_pAnm;
	m_pos.idle.frameDelay = m_pos.pAnm->data()->delay * MILLISECONDS;
	
	// Set idle.time to hold the *number of frames this will run for*.
	m_pos.idle.time = m_pos.pAnm->data()->frameCount;
	m_pos.idle.frameTime = GetTickCount();

	m_pos.loopFrame = LOOP_STANCE;
	m_pos.frame = 0;				// Ensure that custom animations start at the first frame.

	if (prg->isThread())
	{
		if (bPauseThread)
		{
			// Hold thread execution until this command is finished.

			// Free any current thread.
			if (m_thread) m_thread->wakeUp();
			// Give thread control to the sprite.
			m_thread = (CThread *)prg;
			// Pause the thread indefinitely (until movement ends).
			m_thread->sleep(0);
		}
	}
	else
	{
		// Animate now!
		while (m_pos.loopFrame == LOOP_STANCE)
		{
			renderNow(g_cnvRpgCode, true);
			renderRpgCodeScreen();
			processEvent();
		}
	}
}

// Set the animation based on direction and idle status.
void CSprite::setAnm(MV_ENUM dir)
{
	switch (m_pos.loopFrame)
	{
		case LOOP_STANCE:
			// String stance is released upon loading.
		case LOOP_IDLE:
			if (m_attr.mapGfx[GFX_IDLE][dir].pAnm)
			{
				m_pos.pAnm = m_attr.mapGfx[GFX_IDLE][dir].pAnm->m_pAnm;
			} break;
		default:
			if (m_attr.mapGfx[GFX_MOVE][dir].pAnm)
			{
				m_pos.pAnm = m_attr.mapGfx[GFX_MOVE][dir].pAnm->m_pAnm;
			}
	}
}

/*
 * Process idle and custom animations.
 */
void CSprite::checkIdling(void) 
{
	if (m_pos.loopFrame < LOOP_MOVE)
	{
		if ((m_pos.loopFrame == LOOP_WAIT) && m_pos.path.empty() && (GetTickCount() - m_pos.idle.time >= m_attr.idleTime))
		{
			// Push into idle graphics if not already.

			// Check that a standing graphic for this direction exists.
			if (m_attr.mapGfx[GFX_IDLE][m_facing.dir()].pAnm)
			{
				m_pos.pAnm = m_attr.mapGfx[GFX_IDLE][m_facing.dir()].pAnm->m_pAnm;
				
				// Put the loop counter into idling status.
				m_pos.loopFrame = LOOP_IDLE;

				// Recalculate loopSpeed.
				m_pos.loopSpeed = calcLoops();

				m_pos.frame = 0;

				// Set the timer for idleness.
				m_pos.idle.frameTime = GetTickCount();

				// Frame delay for the idle animation.
				m_pos.idle.frameDelay = m_pos.pAnm->data()->delay * MILLISECONDS;
			}
		} // if (time player has been idle > idle time)

		// Run idle and custom animations. Custom animations utilise
		// the idle object.
		if (m_pos.loopFrame == LOOP_IDLE || m_pos.loopFrame == LOOP_STANCE)
		{
			if (GetTickCount() - m_pos.idle.frameTime >= m_pos.idle.frameDelay)
			{
				// Start the timer for this frame.
				m_pos.idle.frameTime = GetTickCount();

				// End custom stances. idle.time stores the number of frames
				// to run for, rather than time in stance instances!
				if (m_pos.loopFrame == LOOP_STANCE && --m_pos.idle.time == 0)
				{
					// Animation has finished. Continue to render the
					// last frame of the stance until it is interrupted
					// by movement or another stance command.
					m_pos.loopFrame = LOOP_STANCE_END;
					m_pos.idle.time = GetTickCount();

					// Free any thread that is waiting for the custom
					// animation to finish.
					if (m_thread)
					{
						m_thread->wakeUp();
						m_thread = NULL;
					}
				}
				else 
				{
					// Increment the animation frame when the delay is up.
					// Do not increment on the last frame.
					++m_pos.frame;
				}
			}
		} // if (running custom or idle animation)
	} // if (player is not moving)
}

/*
 * Calculate sprite location and place on destination canvas.
 */
bool CSprite::render(CCanvas *const cnv, const int layer, RECT &rect)
{
	extern LPBOARD g_pBoard;
	extern RECT g_screen;
	extern double g_spriteTranslucency;

	if (!m_pos.l) return false;

	// If we're rendering the top layer, draw the translucent sprite.
	if (layer != m_pos.l && 
		(layer != g_pBoard->sizeL || !g_spriteTranslucency)
		) return false;

	// Render the frame here (but not when rendering translucently).
	if (m_pos.l == layer)
	{
		// Update idle and custom animations.
		checkIdling();

		// Get a pointer to the current animation.
		// Bitshift in place of multiply by two (<< 1 equivalent to * 2)
		// *Remove div 2 to double the movement frame rate*.
		const int frame = (m_pos.loopFrame <= LOOP_IDLE) ?	m_pos.frame : int(m_pos.frame / (m_pos.loopSpeed << 1));
		
		// Get the canvas for the current frame.
		if (m_pos.pAnm)
		{
			CCanvas *p = m_pos.pAnm->getFrame(frame);
			if (p != m_pCanvas) m_pos.pAnm->playFrameSound(frame);
			m_pCanvas = p;
		}
		else 
		{
			m_pCanvas = NULL;
			return false;
		}
	}
	else if (!m_pCanvas) return false;

	// Screen location on board.
	// Referencing with m_pos at the bottom-centre of the tile for
	// 2D, in the centre of the tile for isometric. 
	// Vertically offset iso sprites.

	const int centreX = round(m_pos.x),
			  centreY = round(m_pos.y) + (g_pBoard->isIsometric() ? 8 : 0);
	/** centreY = round(m_pos.y) + m_attr.vBase.getBounds().bottom; **/
  
	// Sprite location on screen and board.
	// Bitshift in place of divide by two (>> 1 equivalent to / 2)
	RECT screen = {0, 0, 0, 0},
		 board = { centreX - (m_pCanvas->GetWidth() >> 1), centreY - m_pCanvas->GetHeight(),
				   centreX + (m_pCanvas->GetWidth() >> 1), centreY };

	// Off the screen!
	if (!IntersectRect(&screen, &board, &g_screen)) return false;

	// screen holds the portion of the frame we need to draw.
	// Put the board co-ordinates into rect.
	rect = screen;

	// Blt the player to the target.
	if (m_pos.l == layer)
	{

#ifdef DEBUG_VECTORS
		// Draw the vectors and path associated with the sprite.
		drawVector(cnv);
#endif

		m_pCanvas->BltTransparentPart(
			cnv,
			screen.left - g_screen.left,	// destination coord
			screen.top - g_screen.top,
			screen.left - board.left,		// source coord
			screen.top - board.top,
			screen.right - screen.left,		// width / height
			screen.bottom - screen.top,
			TRANSP_COLOR
		);
		return true;
	}

	// Blt the translucent player, unless they're on the top layer.
	m_pCanvas->BltTranslucentPart(
		cnv,
		screen.left - g_screen.left,	// destination coord
		screen.top - g_screen.top,
		screen.left - board.left,		// source coord
		screen.top - board.top,
		screen.right - screen.left,		// width / height
		screen.bottom - screen.top,
		g_spriteTranslucency,
		-1,
		TRANSP_COLOR
	);

	// Return false on translucentBlt to prevent excessive queuing in renderNow().
	return false;
}