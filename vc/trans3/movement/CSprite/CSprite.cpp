/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
#include "../../fight/fight.h"
#include "../../audio/CAudioSegment.h"
#include "../locate.h"
#include <math.h>
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

bool CSprite::m_bDoneMove = false;
int CSprite::m_loopOffset = 0;

/*
 * Constructor
 */
CSprite::CSprite(const bool show):
m_facing(this),
m_attr(),
m_bActive(show),
m_pathFind(),
m_pend(),
m_pos(),
m_thread(NULL),
m_tileType(TT_NORMAL)				// Tiletype at location, NOT sprite's type.
{
	m_v.x = m_v.y = 0;
}

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

	// Negative value indicates idle status.
	if (m_pos.loopFrame < LOOP_MOVE)
	{
		// If movements are queued or there is a board-set path.
		if (!m_pend.path.empty() || m_brdData.boardPath())
		{
			// Determine the number of frames for required speed
			m_pos.loopSpeed = calcLoops();

			// Increment the animation frame if movement did not 
			// finish the previous loop (pixel movement only).
			if (m_bPxMovement && m_pos.loopFrame != LOOP_DONE) m_pos.frame += m_pos.loopSpeed * 2 - 1;

			// Insert target co-ordinates.
			setPathTarget();

			// Set the player to face the direction of movement (direction
			// may change if we slide).
			m_facing.assign(getDirection());

			// Get the tiletype at the target.
			m_tileType = TILE_TYPE(boardCollisions(g_pBoard) | spriteCollisions());

			// Start the render frame counter.
			if (!(m_tileType & TT_SOLID) || isUser) m_pos.loopFrame = LOOP_MOVE;

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
			m_pos.bIsPath = false;

		} // if (!m_pend.path.empty())
	} // if (.loopFrame < LOOP_MOVE)

	// Non-negative value corresponds to the frame of the movement.
	if (m_pos.loopFrame >= LOOP_MOVE)
	{
		// Movement is occurring.

		// Push the sprite only when the tiletype is passable.
		// Items will not have entered this block if their target is solid.
		if (!(m_tileType & TT_SOLID)) push(isUser);

		if (m_pos.bIsPath)
		{
			// Re-test for sprite collisions. The path was calculated
			// to avoid sprites but cannot account for moving sprites.
			if (spriteCollisions() & TT_SOLID)
			{
				setQueuedPath(pathFind(m_pend.xTarg, m_pend.yTarg, PF_VECTOR), true);
			}
		}

		++m_pos.loopFrame;				// Count of this movement's renders.
		++m_pos.frame;					// Total frame count (for animation frames).

		if (sgn(m_pend.xTarg - m_pos.x) != sgn(m_v.x) ||
			sgn(m_pend.yTarg - m_pos.y) != sgn(m_v.y) ||
			(m_tileType & TT_SOLID))
		{
			// If we've moved past one of the targets or we're
			// walking against a wall, stop.

			// Do not pop until the movement has finished.
			if (!m_pend.path.empty()) m_pend.path.pop_front();

			if (!(m_tileType & TT_SOLID))
			{
				m_pend.xOrig = m_pos.x = m_pend.xTarg;
				m_pend.yOrig = m_pos.y = m_pend.yTarg;
				m_pend.lOrig = m_pos.l;
			}

			// Start the idle timer.
			m_pos.idle.time = GetTickCount();

			// Set the state to LOOP_DONE so as to immediately
			// increment the frame when movement starts again
			// (for pixel movement).
			m_pos.loopFrame = LOOP_DONE;

			// Wake up any thread that this sprite has control over
			// if the path is empty (i.e. a thread-set movement has just finished).
			if (m_thread && m_pend.path.empty())
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
		if (!m_pend.path.empty()) return true;

	} // if (movement occurred)

	return false;
}

/*
 * Complete a single frame's movement of the sprite.
 * Return: true if movement occurred.
 */
bool CSprite::push(const bool bScroll) 
{
	extern RECT g_screen;
	extern LPBOARD g_pBoard;

	// Pixels per frame.
	const double stepSize = PX_FACTOR / m_pos.loopSpeed;
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

		if ((m_v.y < 0 && m_pos.y < (g_screen.top + g_screen.bottom) * 0.5 && g_screen.top > 0) ||
			// North. Scroll if in upper half of screen.
			(m_v.y > 0 && m_pos.y > (g_screen.top + g_screen.bottom) * 0.5 && g_screen.bottom < g_pBoard->pxHeight()))
			// South. Scroll if in lower half of screen.
		{
			const int height = g_screen.bottom - g_screen.top;
			g_screen.top += scy;

			// Check bounds.
			if (g_screen.top < 0) g_screen.top = 0;
			else if (g_screen.top + height > g_pBoard->pxHeight()) g_screen.top = g_pBoard->pxHeight() - height;

			g_screen.bottom = g_screen.top + height;
		}

		if ((m_v.x < 0 && m_pos.x < (g_screen.left + g_screen.right) * 0.5 && g_screen.left > 0) ||
			// West. Scroll if in left half of screen.
			(m_v.x > 0 && m_pos.x > (g_screen.left + g_screen.right) * 0.5 && g_screen.right < g_pBoard->pxWidth()))
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
 * Take the angle of movement and return a MV_ENUM direction.
 */
MV_ENUM CSprite::getDirection(void)
{
	extern LPBOARD g_pBoard;

	double angle = 90.0;

	// Convert the isometric angle to a "face down" angle
	// that corresponds to the implied direction, and that can 
	// be used along with non-iso boards.
	// arctan returns -pi/2 to +pi/2 radians (-90 to +90 degrees).
	if (m_v.x) angle = RADIAN * (g_pBoard->isIsometric() ?
								atan(2 * m_v.y / m_v.x) : 
								atan(m_v.y / m_v.x));

	if (angle == 0 && m_v.x < 0) angle = 180.0;
	// Correct for negatives.
	if (angle < 0) angle += 180.0;
	// Correct for inversion.
	if (m_v.y < 0) angle += 180.0;

	return MV_ENUM((round(angle / 45.0) % 8) + 1);
}

/*
 * Get the target coordinates - either the next point on a path
 * or the ultimate target.
 */
DB_POINT CSprite::getTarget(void)
{
	if (m_pos.bIsPath)
	{
		// Pixels travelled this move.
		const int step = moveSize();
		const DB_POINT p = {round(m_pos.x + step * m_v.x),
							round(m_pos.y + step * m_v.y)};
		return p;
	}
	const DB_POINT p = {m_pend.xTarg, m_pend.yTarg};
	return p;
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
	m_pend.xTarg = m_pend.xOrig + m_v.x * step;
	m_pend.yTarg = m_pend.yOrig + m_v.y * step;
	m_pend.lTarg = m_pend.lOrig;
}

/*
 * Insert target co-ordinates from the path.
 */
void CSprite::setPathTarget(void)
{
	if (!m_pend.path.empty())
	{
		m_pend.xTarg = m_pend.path.front().x;
		m_pend.yTarg = m_pend.path.front().y;

		// Null the board path if one exists and it is set to run
		// only until interrupted (do not delete the vector since
		// it belongs to the board).
		if (m_brdData.boardPath.attributes & BP_STOP_ON_INTERRUPT)
		{
			m_brdData.boardPath.pVector = NULL;
		}
	}
	else if (m_brdData.boardPath())
	{
		DB_POINT pt = m_brdData.boardPath.getNextNode();
		m_pend.xTarg = pt.x;
		m_pend.yTarg = pt.y;
		m_pos.bIsPath = true;
	}
	else return;

	const double dx = m_pend.xTarg - m_pend.xOrig,
				 dy = m_pend.yTarg - m_pend.yOrig;
	const double dmax = dAbs(dx) > dAbs(dy) ? dAbs(dx) : dAbs(dy);

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
	m_pend.xOrig = m_pos.x;
	m_pend.yOrig = m_pos.y;
	m_pend.path.clear();
	m_pos.bIsPath = false;
}

/*
 * Place a movement in the sprite's queue.
 */
void CSprite::setQueuedMovement(const int direction, const bool bClearQueue, int step)
{
	// Break out of the current movement.
	if (bClearQueue) clearQueue();

	extern LPBOARD g_pBoard;
	extern const double g_directions[2][9][2];

	const int nIso = int(g_pBoard->isIsometric());

	// Pixels travelled this move, optionally overriden for rpgcode commands.
	if (!step) step = moveSize();

	// The "movement vector".
	// g_directions[isIsometric()][MV_CODE][x OR y].
	m_v.x = g_directions[nIso][direction][0];
	m_v.y = g_directions[nIso][direction][1];

	/** if (nIso == 1 && !m_bPxMovement && m_v.x && !m_v.y)
	{
		// Cause players to move twice as far for East/West in tile movement.
		m_v.x *= 2;
	} **/

	DB_POINT dest;
	getDestination(dest);

	DB_POINT p = {dest.x + m_v.x * step, dest.y + m_v.y * step};	
	m_pend.path.push_back(p);
}

/*
 * Run all the movements in the queue.
 */
void CSprite::runQueuedMovements(void) 
{
	extern CPlayer *g_pSelectedPlayer;
	extern CCanvas *g_cnvRpgCode;

	while (move(g_pSelectedPlayer, true))
	{
		renderNow(g_cnvRpgCode, true);
		renderRpgCodeScreen();
	}
}

/*
 * Get the destination.
 */
void CSprite::getDestination(DB_POINT &p) const
{
	if (m_pend.path.empty())
	{
		// The origin of the current movement or the target
		// of the previous movement (origin = target on arrival).
		p.x = m_pend.xOrig;
		p.y = m_pend.yOrig;
	}
	else
	{
		// The "final" destination.
		p = m_pend.path.back();
	}
}

/*
 * Queue up a path-finding path.
 */
void CSprite::setQueuedPath(PF_PATH &path, const bool bClearQueue)
{
	if (path.empty()) return;
	if (bClearQueue) clearQueue();

	// PF_PATH is a std::vector<DB_POINT> with the points stored in reverse.
	PF_PATH::reverse_iterator i = path.rbegin();
	for (; i != path.rend(); ++i)
	{
		m_pend.path.push_back(*i);
	}
	m_pos.bIsPath = true;
}

/*
 * Pathfind to pixel position x, y (same layer).
 */
PF_PATH CSprite::pathFind(const int x, const int y, const int type)
{
	extern LPBOARD g_pBoard;
	if (x > 0 && x < g_pBoard->pxWidth() && y > 0 && y < g_pBoard->pxHeight())
	{
		const DB_POINT start = {m_pos.x, m_pos.y}, goal = {x, y};

		return m_pathFind.pathFind (start, 
			goal, 
			m_pos.l, 
			m_attr.vBase.getBounds(), 
			type,
			this);
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
	programTest();
	fightTest(step);
}

/*
 * Set the sprite's pixel target and current locations, based on
 * the type of co-ordinate system.
 */
void CSprite::setPosition(int x, int y, const int l, const COORD_TYPE coord)
{
	// Convert the co-ordinates an absolute pixel value.
	pixelCoordinate(x, y, coord, true);

	m_pend.xOrig = m_pend.xTarg = m_pos.x = x;
	m_pend.yOrig = m_pend.yTarg = m_pos.y = y;
	m_pend.lOrig = m_pend.lTarg = m_pos.l = l;

	// Take this command to mean movement has halted.
	m_pend.path.clear();
	m_pos.loopFrame = LOOP_DONE;
	m_pos.bIsPath = false;

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
	if (m_pos.bIsPath) return TT_NORMAL;

	// Create the sprite's vector base at the *target* location.
	DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;
	int layer = m_pos.l;				// Destination layer.

	// Loop over the board CVectors and check for intersections.
	for (std::vector<BRD_VECTOR>::iterator i = board->vectors.begin(); i != board->vectors.end(); ++i)
	{
		if (i->layer != m_pos.l) continue;

		TILE_TYPE tt = TT_NORMAL;

		// Check that the board vector contains the player,
		// *not* the other way round!
		// Disregard _T("under") type, it has no effect in collisions.
		if (i->type != TT_UNDER && i->pV->contains(sprBase, p))
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

			// Could just miss all this angle stuff (also then p)? Since the potential targets
			// are tested, the incident angle is largely irrelevant, unless we want
			// movement to specifically occur for > 45 degrees (otherwise sliding in
			// all circumstances.
			// Depends upon resultant action in true pixel movement.

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
	 * we only need to recalculate that sprite_T('s ZO - the others') are preserved.
	 * Hence we remove the pointer from g_sprites, make the checks
	 * and reinsert afterwards.
	 * The position to insert will be the in front of the first pointer
	 * we find that is _T("below") this sprite.
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
	const DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;
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
			if (!pos) pos = i;

			// Also, we haven't collided with it.
			continue;
		}

		// Compare target bases.
		const DB_POINT pt = (*i)->getTarget();
		CVector tarBase = (*i)->m_attr.vBase + pt;
		const RECT tBounds = tarBase.getBounds();

		const ZO_ENUM zo = tarBase.contains(sprBase);

		if (!zo && !pos)
		{
			// No rect intersect - compare on bounding box bottom-left
			// corner position.
			if ((bounds.bottom * g_pBoard->pxWidth() + bounds.left) <
				(tBounds.bottom * g_pBoard->pxWidth() + tBounds.left))
				pos = i;
		}
		else if (!(zo & ZO_ABOVE) && !pos)
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
			if (pos) break;
		}

		// Compare origins? Merge origins and targets? (how?)
	}

	if (!pos)
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
	const STRING &fileName = g_pBoard->dirLink[link];

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
		m_pos.l > pBoard->bSizeL ||
		boardCollisions(pBoard) == TT_SOLID)		// Tiletype at target.
	{
		// Restore.
		setPosition(pos.x, pos.y, m_pos.l, PX_ABSOLUTE);
		g_boards.free(pBoard);
		return TT_SOLID;
	}

	// Prevent the player from moving on the next board.
	m_pos.loopFrame = LOOP_DONE;

	// This is refusing to work, Delano.
	//----------------------------------
/**	g_boards.free(g_pBoard);
	g_pBoard = pBoard;
	g_pBoard->createVectorCanvases(); **/

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

	clearAnmCache();

	extern RECT g_screen;
	extern SCROLL_CACHE g_scrollCache;
	alignBoard(g_screen, true);
	g_scrollCache.render(true);

	extern ZO_VECTOR g_sprites;
	g_sprites.zOrder();
	g_sprites.freePaths();

	// Ensure that programs the player is standing on don't run immediately.
	deactivatePrograms();

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();

	extern CAudioSegment *g_bkgMusic;
	// Open file regardless of existence.
	g_bkgMusic->open(g_pBoard->boardMusic);
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
bool CSprite::programTest(void)
{
	extern std::vector<CPlayer *> g_players;
	extern MAIN_FILE g_mainFile;
	extern LPBOARD g_pBoard;
	extern STRING g_projectPath;

	// Create the sprite's vector base at the *target* location (for the
	// case of pressing against an item, etc.)
	// We want to use the player's *solid* base (not any active vector it may have).
	DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;

	// Construct merged origin / target?

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
	}

	CItem *itm = NULL; DB_POINT f = {0, 0}; double fs = -1;

	// Items
	for (std::vector<CItem *>::iterator j = g_pBoard->items.begin(); j != g_pBoard->items.end(); ++j)
	{
		// Some item entries may be NULL since users
		// can insert items at any slot number.
		if (!*j || this == *j || m_pos.l != (*j)->m_pos.l) continue;
		if ((*j)->m_brdData.prgActivate.empty()) continue;

		DB_POINT pt = {(*j)->m_pos.x, (*j)->m_pos.y};

		CVector tarActivate = (*j)->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p))
		{
			// Standing in an item's area.
			// Are we facing this item?
			// Are there any other items that are closer?

			// The separation of the two sprites (should use centre-points of m_bounds).
			DB_POINT s = {(*j)->m_pos.x - m_pos.x, (*j)->m_pos.y - m_pos.y};
			
			// Is the target in the facing direction?
			DB_POINT d = {double(sgn(s.x) == m_v.x), double(sgn(s.y) == m_v.y)};

			// This item is less directly in front of the player.
			if (d.x + d.y < f.x + f.y) continue;

			double ds = s.x * s.x + s.y * s.y; 
			if (d.x + d.y == f.x + f.y)
			{
				// Check the separation when we 
				// can't determine on direction alone.
				if (ds > fs && fs != -1) continue;
			}

			if ((*j)->m_brdData.activationType & SPR_KEYPRESS)
			{
				// General activation key - if not pressed, continue.
				if (GetAsyncKeyState(g_mainFile.key) >= 0) continue;
			}

			// Check activation conditions.
			if ((*j)->m_brdData.activate == SPR_CONDITIONAL)
			{
				if (CProgram::getGlobal((*j)->m_brdData.initialVar)->getLit() != (*j)->m_brdData.initialValue)
				{
					// Activation conditions not met.
					continue;
				}
			}

			// Hold on to these results.
			f = d; itm = *j; fs = ds;
		}
	}

	if (itm)
	{
		// Make the item look at this sprite.
		(itm->m_facing = m_facing) += 4;
		renderNow(NULL, false);

		// If we go to a new board in this program, we kill
		// this pointer, so save the values we need.
		const short activate = itm->m_brdData.activate;
		const STRING finalValue = itm->m_brdData.finalValue;
		const STRING finalVar = itm->m_brdData.finalVar;

		CProgram(g_projectPath + PRG_PATH + itm->m_brdData.prgActivate).run();

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
		if ((*k)->layer != m_pos.l) continue;
		// Check that the board vector contains the player.
		// We check *every* vector, in order to reset the 
		// distance of those we have left.
		if (!(*k)->vBase.contains(sprBase, p))
		{
			// Not inside this vector. Set the distance to the 
			// value to trigger program when we re-enter.
			if ((*k)->activationType & PRG_REPEAT) 
			{
				(*k)->distance = (*k)->distanceRepeat;
			}
			else
			{
				(*k)->distance = 0;
			}
		}
		else
		{
			// Standing in a program activation area.

			// Increase distance travelled within the vector.
			(*k)->distance += moveSize();

			// Check activation conditions.
			if ((*k)->activationType & PRG_REPEAT)
			{
				// Repeat triggers - check player has moved
				// the required distance.
				if ((*k)->distance < (*k)->distanceRepeat) continue;
			}
			else
			{
				// Single trigger - check the player has moved at all,
				// but only in the case of step-activations (key-press
				// without the PRG_REPEAT can always trigger).
				if (!((*k)->activationType & PRG_KEYPRESS))
				{
					if ((*k)->distance != moveSize()) continue;
				}
			}

			if ((*k)->activationType & PRG_KEYPRESS)
			{
				// General activation key - if not pressed, continue.
				if (GetAsyncKeyState(g_mainFile.key) >= 0) continue;
			}

			// Check activation conditions.
			if ((*k)->activate == PRG_CONDITIONAL)
			{
				if (CProgram::getGlobal((*k)->initialVar)->getLit() != (*k)->initialValue)
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

		CProgram(g_projectPath + PRG_PATH + prg->fileName, prg).run();

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
		if (((*i)->layer == m_pos.l) && (*i)->vBase.contains(sprBase, p))
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

// Debug function - draw vector onto screen.
// Might be worth keeping in some form.
void CSprite::drawVector(CCanvas *const cnv)
{
	extern RECT g_screen;
	extern CPlayer *g_pSelectedPlayer;

	// Draw the target base one colour.
	DB_POINT p = getTarget();
	CVector sprBase = m_attr.vBase + p;
	sprBase.draw(RGB(0,255,255), false, g_screen.left, g_screen.top, cnv);

	// Draw the current position base another.
	p.x = m_pos.x; p.y = m_pos.y;
	sprBase = m_attr.vBase + p;
	sprBase.draw(RGB(255,255,255), false, g_screen.left, g_screen.top, cnv);

	// Draw the activation area.
	sprBase = m_attr.vActivate + p;
	sprBase.draw(RGB(255,255,255), false, g_screen.left, g_screen.top, cnv);

	// Draw the path this sprite is on. This is always done for the selected
	// player, so don't draw it for him here.
	if (this != g_pSelectedPlayer)
	{
		drawPath(cnv);
	}
}

/*
 * Draw the path this sprite is on. Used when clicking
 * to move -- the player needs to be able to see where
 * the character is going.
 */
void CSprite::drawPath(CCanvas *const cnv)
{
	extern RECT g_screen;
	extern LPBOARD g_pBoard;
	CONST LONG color = RGB(255, 0, 0);

	if (!m_pos.bIsPath ||
		(round(m_pos.x) == m_pend.xTarg &&
		round(m_pos.y) == m_pend.yTarg)) return;

	int x = m_pend.xTarg - g_screen.left, 
		y = m_pend.yTarg - g_screen.top,
		dx = 12,
		dy = g_pBoard->isIsometric() ? 6: 12;

	cnv->DrawLine(round(m_pos.x) - g_screen.left, round(m_pos.y) - g_screen.top, 
		m_pend.xTarg - g_screen.left, m_pend.yTarg - g_screen.top, color);

	if (!m_pend.path.empty())
	{
		std::deque<DB_POINT>::iterator i = m_pend.path.begin();
		cnv->DrawLine(m_pend.xTarg - g_screen.left, m_pend.yTarg - g_screen.top, 
			i->x - g_screen.left, i->y - g_screen.top, color);

		for (; i != m_pend.path.end() - 1; ++i)
		{
			cnv->DrawLine(i->x - g_screen.left, i->y - g_screen.top, 
				(i + 1)->x - g_screen.left, (i + 1)->y - g_screen.top, color);
		}
		x = i->x - g_screen.left;
		y = i->y - g_screen.top;
	}

	cnv->DrawEllipse(x - dx, y - dy, x + dx, y + dy, color);
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
			rect.left = (g_pBoard->pxWidth() - width) * 0.5;
		}
		else
		{
			rect.left = 0;
		}
	}
	else
	{
		// Centre around the player.
		rect.left = m_pos.x - width * 0.5;
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
			rect.top = (g_pBoard->pxHeight() - height) * 0.5;
		}
		else
		{
			rect.top = 0;
		}
	}
	else
	{
		rect.top = m_pos.y - height * 0.5;
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
	m_pos.idle.frameDelay = m_pos.pAnm->data()->animPause * MILLISECONDS;
	
	// Set idle.time to hold the *number of frames this will run for*.
	m_pos.idle.time = m_pos.pAnm->data()->animFrames + 1;
	m_pos.idle.frameTime = GetTickCount();

	m_pos.loopFrame = LOOP_STANCE;
	m_pos.frame = 0;

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
	if (m_pos.loopFrame < LOOP_MOVE && m_pend.path.empty())
	{
		// We're idle, and we're not about to start moving.

		if ((m_pos.loopFrame == LOOP_WAIT) && (GetTickCount() - m_pos.idle.time >= m_attr.idleTime))
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
				m_pos.idle.frameDelay = m_pos.pAnm->data()->animPause * MILLISECONDS;
			}
		} // if (time player has been idle > idle time)

		// Run idle and custom animations. Custom animations utilise
		// the idle object.
		if (m_pos.loopFrame == LOOP_IDLE || m_pos.loopFrame == LOOP_STANCE)
		{
			if (GetTickCount() - m_pos.idle.frameTime >= m_pos.idle.frameDelay)
			{
				// Increment the animation frame when the delay is up.
				++m_pos.frame;

				// Start the timer for this frame.
				m_pos.idle.frameTime = GetTickCount();

				// End custom stances. idle.time stores the number of frames
				// to run for, rather than time in stance instances!
				if (m_pos.loopFrame == LOOP_STANCE && --m_pos.idle.time == 0)
				{
					// Animation has finished.
					m_pos.loopFrame = LOOP_WAIT;
					m_pos.idle.time = GetTickCount();
					setAnm(m_facing.dir());

					// Free any thread that is waiting for the custom
					// animation to finish.
					if (m_thread)
					{
						m_thread->wakeUp();
						m_thread = NULL;
					}
				}
			}
		} // if (running custom or idle animation)
	} // if (player is not moving)
}

/*
 * Calculate sprite location and place on destination canvas.
 */
bool CSprite::render(const CCanvas *cnv, const int layer, RECT &rect)
{
	extern LPBOARD g_pBoard;
	extern RECT g_screen;
	extern double g_translucentOpacity;

	// If we're rendering the top layer, draw the translucent sprite.
	if (layer != m_pos.l && 
		(layer != g_pBoard->bSizeL || !g_translucentOpacity)
		) return false;

	// Render the frame here (but not when rendering translucently).
	if (m_pos.l == layer)
	{
		// Update idle and custom animations.
		checkIdling();

		// Get a pointer to the current animation.
		const int frame =  (m_pos.loopFrame == LOOP_STANCE || 
							m_pos.loopFrame == LOOP_IDLE) ?
							m_pos.frame :
							int(m_pos.frame / (m_pos.loopSpeed * 2));
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
	RECT screen = {0, 0, 0, 0},
		 board = { centreX - int(m_pCanvas->GetWidth() * 0.5), centreY - m_pCanvas->GetHeight(),
				   centreX + int(m_pCanvas->GetWidth() * 0.5), centreY };

	// Off the screen!
	if (!IntersectRect(&screen, &board, &g_screen)) return false;

	// screen holds the portion of the frame we need to draw.
	// Put the board co-ordinates into rect.
	rect = screen;

	// Blt the player to the target.
	if (m_pos.l == layer)
	{
		m_pCanvas->BltTransparentPart(cnv,
								screen.left - g_screen.left,	// destination coord
								screen.top - g_screen.top,
								screen.left - board.left,		// source coord
								screen.top - board.top,
								screen.right - screen.left,		// width / height
								screen.bottom - screen.top,
								TRANSP_COLOR);
		return true;
	}

	// Blt the translucent player, unless they're on the top layer.
	m_pCanvas->BltTranslucentPart(cnv,
							screen.left - g_screen.left,	// destination coord
							screen.top - g_screen.top,
							screen.left - board.left,		// source coord
							screen.top - board.top,
							screen.right - screen.left,		// width / height
							screen.bottom - screen.top,
							g_translucentOpacity,
							-1,
							TRANSP_COLOR);

	// Return false on translucentBlt to prevent excessive queuing in renderNow().
	return false;
}
