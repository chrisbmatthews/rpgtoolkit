/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a base sprite class.
 */

/*
 * What this file includes / needs:
 * - Basic movement variables - location, frame, etc.
 * - Movement functions.
 * - Rendering functions.
 *
 * What this file doesn't include:
 * Player- / item-specific functions.
 */

#include "CSprite.h"
#include "../CPlayer/CPlayer.h"
#include "../CItem/CItem.h"
#include "../../common/animation.h"
#include "../../common/mainFile.h"
#include "../../common/board.h"
#include "../../common/paths.h"
#include "../../rpgcode/CProgram/CProgram.h"
#include "../../fight/fight.h"
#include "../locate.h"
#include <math.h>
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

/*
 * Constructor
 */
CSprite::CSprite(const bool show):
m_attr(),
m_bActive(show),
m_lastRender(),
m_pend(),
m_pos(),
m_tileType(TT_NORMAL)				// Tiletype at location, NOT sprite's type.
{
	m_v.x = m_v.y = 0;

	// Create canvas.
	m_canvas.CreateBlank(NULL, 32, 32, TRUE);
	m_canvas.ClearScreen(0);
}

/*
 * Movement functions.
 */ 

/*
 * Evaluate the current movement state.
 * Returns: true if movement occurred.
 */ 
bool CSprite::move(const CSprite *selectedPlayer) 
{
	extern int g_gameState;
	extern int g_loopOffset;
	extern double g_movementSize;
	extern double g_renderCount;
	extern double g_renderTime;

	// Is the sprite active (visible).
	if (!m_bActive) return false;

	// Negative value indicates idle status (LOOP_WAIT or LOOP_IDLE)
	if (m_pos.loopFrame < 0)
	{
		// Parse the movement queue.
		m_pend.direction = getQueuedMovements();

		if (m_pend.direction != MV_IDLE)
		{
			// Insert target co-ordinates.
			insertTarget();

			// If we're in pixel movement, increment the animation frame
			// at the start of movement (for the case where the frame might
			// not be incremented again before the player stops.
//			if (g_movementSize != 1) m_pos.frame++;

			// Set the player to face the direction of movement (direction
			// may change if we slide.
			m_pos.facing = m_pend.direction;

			// Get the tiletype at the target.
			m_tileType = TILE_TYPE(boardCollisions() | spriteCollisions());
				
			// obtainTileType(); - boardCollisions().
			// checkObstruction(); - spriteCollisions().
			// checkBoardEdges(); - to do.

			if (!(m_tileType & TT_SOLID) || (this == selectedPlayer))
			{
				// Start the render frame counter.
				m_pos.loopFrame = 0;
			}

			/*
			 * Determine the number of frames we need to draw to make
			 * the sprite move at the requested speed, considering the fps.
			 * Scale the offset (GameSpeed() setting) to correspond to an
			 * increment of 10%.
			 */
			const double fpms = g_renderCount / g_renderTime; // transMain?
			m_pos.loopSpeed = round(m_attr.speed * fpms) + (g_loopOffset * round(fpms * 100.0));
			
			// The number of renders (main loops) to run in between animation
			// frame updates.
			if (m_pos.loopSpeed < 1)
			{
				m_pos.loopSpeed = 1;
			}
		}
		else
		{
			// Set g_gamestate to GS_IDLE to accept user input for the selected player.
			if (this == selectedPlayer) g_gameState = GS_IDLE;

		} // if (.direction != MV_IDLE)
	} // if (.loopFrame < 0)

	if (m_pos.loopFrame >= 0)
	{
		// Movement is occurring.
		if (push(selectedPlayer))
		{

			// Increment the frame count in fractions, the fraction being one over
			// the number of pixels per move. Then, the frame changes on
			// integral values.

			if (m_pos.loopFrame % int(m_pos.loopSpeed * 32.0 / g_movementSize) == 0)
			{
				// Increment the animation frame when we're on a multiple of
				// loopSpeed (the number of renders to make between animation
				// frame increments).
				++m_pos.frame;
			}

			// Always increment the render count.
			++m_pos.loopFrame;

			// Frames per move is the number of animation frames to
			// draw per move - a move being 1 tile or 1/4 tile.
			if (m_pos.loopFrame == framesPerMove() * m_pos.loopSpeed)
			{
				// The number of renders is equal to the animation frames
				// per move times the renders between animation frames
				// - i.e. we have finished movement.
				if (!(m_tileType & TT_SOLID))
				{
					m_pend.xOrig = m_pos.x = m_pend.xTarg;
					m_pend.yOrig = m_pos.y = m_pend.yTarg;
					m_pend.lOrig = m_pos.l;
				}
				// else restore xTarg -> xOrig?

				// Start the idle timer.
				m_pos.idle.time = GetTickCount();

				// Set the state to be able to start idle animations.
				// ("Wait" until the idle time is completed).
				m_pos.loopFrame = LOOP_WAIT;

				// Finish the move for the selected player.
				if (this == selectedPlayer) playerDoneMove();

				// Do this only after playerDoneMove().
				m_pend.direction = MV_IDLE;

			} // if (movement ended)

			return true;

		} // if (push)

		// If push() returned false, that means we've stopped moving
		// during a move (because direction is not MV_IDLE).
		// Hopefully it's due a sprite that's moving and will move out
		// of the way!
		/* Possibly end up merging push() since it's so small */

	} // if (direction != MV_IDLE)

	return false;
}

/*
 * Complete a single frame's movement of the sprite.
 * Return: true if movement occurred.
 */
bool CSprite::push(const CSprite *selectedPlayer) 
{
	extern double g_movementSize;

	SPRITE_POSITION testPosition = m_pos;
    const double moveFraction = g_movementSize / (framesPerMove() * m_pos.loopSpeed);
	
	incrementPosition(m_pos, m_pend, moveFraction);

	if (m_tileType & TT_SOLID)
	{
		// May check collisions every frame.
		m_pos = testPosition;

		// Cause the player to walk on spot.
		if (this == selectedPlayer) return true;
		// Other sprites don't animate.
		return false;
	}

	// Scroll the board for players. Either set for all players, or only selected player
	// and create a Scroll RPGCode function so that scrolling can be achieved without having
	// to use invisible players.
	extern RECT g_screen;
	extern BOARD g_activeBoard;

	if (this == selectedPlayer)
	{
		if (m_v.y == -1)
		{
			// North. Scroll if in upper half of *screen*.
			if (m_pos.y < (g_screen.top + g_screen.bottom) * 0.5 && g_screen.top > 0) 
			{
				g_screen.top -= moveFraction;
				g_screen.bottom -= moveFraction;
			}
		}
		else if (m_v.y == 1)
		{
			// South. Scroll if in lower half of screen.
			if (m_pos.y > (g_screen.top + g_screen.bottom) * 0.5 && g_screen.bottom < g_activeBoard.bSizeY * 32)
			{
				g_screen.top += moveFraction;
				g_screen.bottom += moveFraction;
			}
		}
		if (m_v.x == -1)
		{
			// West. Scroll if in left half of screen.
			if (m_pos.x  < (g_screen.left + g_screen.right) * 0.5 && g_screen.left > 0)
			{
				g_screen.left -= moveFraction;
				g_screen.right -= moveFraction;
			}
		}
		else if (m_v.x == 1)
		{
			// East. Scroll if in right half of screen.
			if (m_pos.x > (g_screen.left + g_screen.right) * 0.5 && g_screen.right < g_activeBoard.bSizeX * 32)
			{
				g_screen.left += moveFraction;
				g_screen.right += moveFraction;
			}
		}
	} // if (this == selectedPlayer)
	
	return true;
}

/*
 * Get the next queued movement and remove it from the queue.
 */
MV_ENUM CSprite::getQueuedMovements(void) 
{
	// Check that we have queued movements before popping!
	if (m_pend.queue.size())
	{
		// Peek.
		const int peek = m_pend.queue.front();
		// Pop.
		m_pend.queue.pop_front();
		return MV_ENUM(peek);
	}
	return MV_IDLE;
}

/*
 * Place a movement in the sprite's queue.
 */
void CSprite::setQueuedMovements(const int queue, const bool bClearQueue) 
{
	// Clear any currently queued movements if requested.
	if (bClearQueue) m_pend.queue.clear();

	// Push the new movements onto the queue.
	m_pend.queue.push_back(queue);
}

/*
 * Run all the movements in the queue.
 */
void CSprite::runQueuedMovements(void) {}

/*
 * Complete the selected player's move.
 */
void CSprite::playerDoneMove(void) 
{
	extern double g_movementSize;
	extern int g_gameState;
	extern unsigned long g_stepsTaken;

	// Update the step count.
	g_stepsTaken += g_movementSize;

	programTest();
	fightTest();

	// Back to idle state (accepting input)
	g_gameState = GS_IDLE;
}

/*
 * Set the sprite's target and current locations.
 */
void CSprite::setPosition(const int x, const int y, const int l)
{
	m_pend.xOrig = m_pend.xTarg = m_pos.x = x;
	m_pend.yOrig = m_pend.yTarg = m_pos.y = y;
	m_pend.lOrig = m_pend.lTarg = m_pos.l = l;
}

/*
 * Collision detection.
 */

/*
 * Check against each board vector and build up a set of flags 
 * describing all tiletypes at this point. Evaluate one-way vectors
 * and sprite sliding (angled movement along solid boundaries). 
 */
TILE_TYPE CSprite::boardCollisions(const bool recursing)
{
	// To do - stairs, layers.
	extern BOARD g_activeBoard;

	TILE_TYPE tileTypes = TT_NORMAL;

	// Create the sprite's vector base at the *target* location.
	DB_POINT p = {m_pend.xTarg - 32.0, m_pend.yTarg - 32.0};
	CVector sprBase = m_attr.vBase + p;

	// Loop over the board CVectors and check for intersections.
	for (std::vector<BRD_VECTOR>::iterator i = g_activeBoard.vectors.begin(); i != g_activeBoard.vectors.end(); ++i)
	{
		if (i->layer != m_pos.l) continue;

		// Check that the board vector contains the player,
		// *not* the other way round!
		TILE_TYPE tt = i->pV->contains(sprBase, p) ? i->type : TT_NORMAL;

		/*
		 * If an intersection was found, p now holds a position vector
		 * parallel to the board subvector that was hit. Use this to 
		 * evaluate the vector's type for one-way and sliding movement.
		 */

		// Problem: corners on UNIDIRECTIONALs - more distant vector is
		// sometimes detected, and if the corner angle is <= 90, the wrong
		// result will be given.

		if (tt & TT_UNIDIRECTIONAL)
		{
			// Use the returned point to determine the direction of approach 
			// by crossing it with the sprite's movement vector. 
			if (p.x * m_v.y - p.y * m_v.x >= 0)
			{
				// Crossing boundary from the "solid" side.
				tt = TT_SOLID;
			}
			else
			{
				tt = TT_NORMAL;
			}
		}

		if ((tt & TT_SOLID) && (!recursing))
		{
			/*
			 * Compute the angle between the movement vector and
			 * the subvector to determine if we should "slide".
			 * If the angle is greater than 45 (or chosen other),
			 * try rotating the movement direction and evalutate
			 * the board vectors again at the new target.
			 * The facing direction is maintained to indicate the player
			 * is sliding.
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
			double angle = (180 / PI) * 
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

			// Round. Slide if angle <= 45 or >= 135 degrees.
			angle  = int(angle + 0.5) - 90.0;
			
			if ((abs(angle) >= 45.0))
			{
				// Work out which direction to rotate to.

				// Vector (cross) product returns a vector in the z-plane.
				// a x b = |a||b|sin(c) = (a.x * b.y - a.y * b.x)

				const double normal = (p.x * m_v.y - p.y * m_v.x);

				// If angle and normal are both positive or negative,
				// p is to the "right" of m_v (negative being the flipped case).
				// Otherwise, p is to the "left" of m_v.

				if ((angle > 0) == (normal > 0))
					// Rotate right.
					m_pend.direction++;
				else
					// Rotate left.
					m_pend.direction--;

				// Reinsert the target and test again.
				insertTarget();

				// Recurse on the new target - evaluate all vectors and
				// return, rather than pausing as it has here.
				tt = boardCollisions(true);
				if(tt & TT_SOLID) 
				{
					// Target blocked.

					// Recurse once more in the opposite direction.
					m_pend.direction = m_pos.facing;
					if ((angle > 0) == (normal > 0))
						m_pend.direction--;
					else
						m_pend.direction++;

					insertTarget();
					tt = boardCollisions(true);
					if(tt & TT_SOLID) 
					{
						// Restore.
						m_pend.direction = m_pos.facing;
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
	extern BOARD g_activeBoard;

	/*
	 * Check for collisions against all sprites and return the tiletype
	 * (currently only solid or normal, but sprites could be given their
	 * own tiletypes).
	 * Also z-order sprites as we search for collisions:
	 * z-ordered (ZO) sprite pointers are stored in g_zSprites.
	 * Upon board loading, the initial ZO is calculated for all sprites.
	 * We only need to alter that order when a sprite moves, and then
	 * we only need to recalculate that sprite's ZO - the others' are preserved.
	 * Hence we remove the pointer from g_zSprites, make the checks
	 * and reinsert at the end.
	 * The position to insert will be the in front of the first pointer
	 * we find that is "below" this sprite.
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
	DB_POINT p = {m_pend.xTarg - 32.0, m_pend.yTarg - 32.0};
	CVector sprBase = m_attr.vBase + p;

	for(i = g_sprites.v.begin(); i != g_sprites.v.end(); ++i)
	{
//		if (this == *i) continue;			// Redundant check.

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
		DB_POINT pt = {(*i)->m_pend.xTarg - 32.0, (*i)->m_pend.yTarg - 32.0};
		CVector tarBase = (*i)->m_attr.vBase + pt;

		ZO_ENUM zo = tarBase.contains(sprBase);

		if ((zo & ZO_ABOVE) && !pos)
		{
			// If above sprite, and we don't have an insertion point already.
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

		if (!zo)
		{
			// No rect intersect - compare on bounding box bottom-left
			// corner position.
			if (!pos)
			{
				double  a = ((m_attr.vBase.getBounds().bottom + m_pend.yTarg) *
							g_activeBoard.bSizeX * 32 + 
							m_attr.vBase.getBounds().left + m_pend.xTarg),

						b = (((*i)->m_attr.vBase.getBounds().bottom + (*i)->m_pend.yTarg) *
							g_activeBoard.bSizeX * 32 + 
							(*i)->m_attr.vBase.getBounds().left + (*i)->m_pend.xTarg);
				
				if (a < b) pos = i;
			}
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
 * For the player (or potentially any other sprite), check for program
 * vectors or sprite active bases. Sprites have a second vector that is
 * the area the player must be in to trigger the program.
 * Players take precedence over items, over programs (could be altered).
 */
bool CSprite::programTest(void)
{
	extern std::vector<CPlayer *> g_players;
	extern std::vector<CItem *> g_items;
	extern double g_movementSize;
	extern MAIN_FILE g_mainFile;
	extern BOARD g_activeBoard;
	extern std::string g_projectPath;

	// Create the sprite's vector base at the *target* location (for the
	// case of pressing against an item, etc.)
	// We want to use the player's *solid* base (not any active vector it may have).
	DB_POINT p = {m_pend.xTarg - 32.0, m_pend.yTarg - 32.0};
	CVector sprBase = m_attr.vBase + p;

	// Construct merged origin / target?

	// Players 
	for(std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		if (this == *i || m_pos.l != (*i)->m_pos.l) continue;

		DB_POINT pt = {(*i)->m_pos.x - 32.0, (*i)->m_pos.x - 32.0};
		CVector tarActivate = (*i)->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p))
		{
			// Standing in another player's area.
		}
	}


	CItem *itm = NULL; DB_POINT f = {0, 0}; double fs = -1;

	// Items
	for(std::vector<CItem *>::iterator j = g_items.begin(); j != g_items.end(); ++j)
	{
		if (this == *j || m_pos.l != (*j)->m_pos.l) continue;

		DB_POINT pt = {(*j)->m_pos.x - 32.0, (*j)->m_pos.y - 32.0};

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
				if (CProgram::getGlobal((*j)->m_brdData.initialVar).getLit() != (*j)->m_brdData.initialValue)
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
		(itm->m_pos.facing = m_pos.facing) += 4;
		renderNow(NULL, false);

		// If we go to a new board in this program, we kill
		// this pointer, so save the values we need.
		const short activate = itm->m_brdData.activate;
		const std::string finalValue = itm->m_brdData.finalValue;
		const std::string finalVar = itm->m_brdData.finalVar;

		CProgram(g_projectPath + PRG_PATH + itm->m_brdData.prgActivate).run();

		// Set the requested variable after the program is complete.
		if (activate == SPR_CONDITIONAL)
		{
			const double num = atof(finalValue.c_str());
			CProgram::setGlobal(finalVar, (num == 0.0) ? finalValue : CVariant(num));
		}
		return true;
	}

	// Programs

	std::vector<LPBRD_PROGRAM>::iterator k = g_activeBoard.programs.begin();
	LPBRD_PROGRAM prg = NULL;

	for (; k != g_activeBoard.programs.end(); ++k)
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
			(*k)->distance += g_movementSize;

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
					if ((*k)->distance != g_movementSize) continue;
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
				if (CProgram::getGlobal((*k)->initialVar).getLit() != (*k)->initialValue)
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

		// If we go to a new board in this program, we kill
		// this pointer, so save the values we need.
		const short activate = prg->activate;
		const std::string finalValue = prg->finalValue;
		const std::string finalVar = prg->finalVar;

		CProgram(g_projectPath + PRG_PATH + prg->fileName).run();

		// Set the requested variable after the program is complete.
		if (activate == PRG_CONDITIONAL)
		{
			const double num = atof(finalValue.c_str());
			CProgram::setGlobal(finalVar, (num == 0.0) ? finalValue : CVariant(num));
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
	extern double g_movementSize;
	extern BOARD g_activeBoard;

	DB_POINT p = {m_pend.xTarg - 32.0, m_pend.yTarg - 32.0};
	CVector sprBase = m_attr.vBase + p;

	std::vector<LPBRD_PROGRAM>::iterator i = g_activeBoard.programs.begin();

	for (; i != g_activeBoard.programs.end(); ++i)
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
					(*i)->distance = g_movementSize;
				}
			}
		}
	} // for (programs)
}

// Debug function - draw vector onto screen.
// Might be worth keeping in some form.
void CSprite::drawVector(CGDICanvas *const cnv)
{
	extern RECT g_screen;

	// Draw the target base one colour.
	DB_POINT p = {m_pend.xTarg - 32.0, m_pend.yTarg - 32.0};
	CVector sprBase = m_attr.vBase + p;
	sprBase.draw(65535, false, g_screen.left, g_screen.top, cnv);

	// Draw the current position base another.
	p.x = m_pos.x - 32.0; p.y = m_pos.y - 32.0;
	sprBase = m_attr.vBase + p;
	sprBase.draw(16777215, false, g_screen.left, g_screen.top, cnv);

	// Draw the activation area.
	sprBase = m_attr.vActivate + p;
	sprBase.draw(16777215, false, g_screen.left, g_screen.top, cnv);
}

/*
 * Form all players and items into a z-ordered vector.
 */
void tagZOrderedSprites::zOrder(void)
{
	extern std::vector<CPlayer *> g_players;
	extern std::vector<CItem *> g_items;

	// Clear the current contents and re-insert the players and items.
	v.clear();
	// Reserve extra space for possible AddPlayers()/CreateItems().
	v.reserve(g_players.size() + g_items.size() + 16);

	// Push one sprite onto the vector to start the process.
	v.push_back(g_players.front());

	// Run spriteCollisions for every player and item, inserting them
	// into v.
	for (std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		(*i)->spriteCollisions();
	}

	for (std::vector<CItem *>::iterator j = g_items.begin(); j != g_items.end(); ++j)
	{
		(*j)->spriteCollisions();
	}
}

/*
 * Location functions.
 */

/*
 * Insert the target co-ordinates (the position at the end of the move).
 */
void CSprite::insertTarget() 
{
	extern BOARD g_activeBoard;
	extern double g_movementSize;
	extern const int g_directions[2][9][2];

	/* Isometric conversions */

	const int nIso = int(g_activeBoard.isIsometric);

	// g_directions[isIsometric][MV_CODE][x OR y].
	m_pend.xTarg = m_pend.xOrig + g_directions[nIso][m_pend.direction][0] * g_movementSize;
	m_pend.yTarg = m_pend.yOrig + g_directions[nIso][m_pend.direction][1] * g_movementSize;
	m_pend.lTarg = m_pend.lOrig;

	// The "movement vector".
	m_v.x = g_directions[nIso][m_pend.direction][0];
	m_v.y = g_directions[nIso][m_pend.direction][1];

}

// CSprite::incrementPosition() {} To do.


/*
 * Align a RECT to the sprite's location.
 */
void CSprite::alignBoard(RECT &rect, const bool bAllowNegatives)
{
	extern BOARD g_activeBoard;
	const int width = rect.right - rect.left;
	const int height = rect.bottom - rect.top;

	if (g_activeBoard.bSizeX * 32 < width)
	{
		// Board smaller than screen.
		if (bAllowNegatives)
		{
			rect.left = (g_activeBoard.bSizeX * 32 - width) * 0.5;
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
		if (rect.left + width > g_activeBoard.bSizeX * 32)
		{
			// Align to right of board.
			rect.left = g_activeBoard.bSizeX * 32 - width;
		}
	}

	if (g_activeBoard.bSizeY * 32 < height)
	{
		if (bAllowNegatives)
		{
			rect.top = (g_activeBoard.bSizeY * 32 - height) * 0.5;
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
		if (rect.top + height > g_activeBoard.bSizeY * 32)
		{
			rect.top = g_activeBoard.bSizeY * 32 - height;
		}
	}

	rect.right = rect.left + width;
	rect.bottom = rect.top + height;
}

/*
 * Render functions.
 */

/*
 * Determine the current sprite frame to use, and render if the current
 * frame requires updating.
 * Returns: true if frame requires redrawing.
 */
bool CSprite::render(void) 
{
	extern int g_gameState;
	extern std::string g_projectPath;

	// Check idleness.
	if ((m_pos.loopFrame < 0) && (!m_pend.queue.size()))
	{
		// We're idle, and we're not about to start moving.

		if ((m_pos.loopFrame == LOOP_WAIT) && (GetTickCount() - m_pos.idle.time >= m_attr.idleTime))
		{
			// Push into idle graphics if not already.

			// Check that a standing graphic for this direction exists.
			// m_pend.facing will *always* be a direction, although
			// m_pend.direction might not be.
			if (!m_attr.mapGfx[GFX_IDLE][m_pos.facing].empty())
			{
				// Put the loop counter into idling status.
				m_pos.loopFrame = LOOP_IDLE;
//				m_pos.frame = 0;

				// Set the timer for idleness.
				m_pos.idle.frameTime = GetTickCount();

// Must be better way to do this!
				// Load the frame delay for the idle animation.
				ANIMATION idleAnim;
				idleAnim.open(g_projectPath + MISC_PATH + m_attr.mapGfx[GFX_IDLE][m_pos.facing]);
				// Get into milliseconds.
				m_pos.idle.frameDelay = idleAnim.animPause * MILLISECONDS;
			}
		} // if (time player has been idle > idle time)

		if (m_pos.loopFrame == LOOP_IDLE)
		{
			if (GetTickCount() - m_pos.idle.frameTime >= m_pos.idle.frameDelay)
			{
				// Increment the animation frame when the delay is up.
				m_pos.frame++;

				// Start the timer for this frame.
				m_pos.idle.frameTime = GetTickCount();
			}
		}

/* To do.
		// Also deal with custom stances here!
		// Use the idle frameTime and frameDelay properties to time
		// frames for the custom stance only.
		// NOTE: Custom animation delay cannot currently be loaded here
		// by this setup - must be done through the RPGCode call.
		if (m_pos.loopFrame == LOOP_CUSTOM_STANCE)
		{
			if (GetTickCount() - m_pos.idle.frameTime >= m_pos.idle.frameDelay)
			{
				// if(m_pos.frame > m_pos.idle.frames)
				//	m_pos.loopFrame = LOOP_WAIT;

				// Increment the animation frame when the delay is up.
				m_pos.frame++;

				// Start the timer for this frame.
				m_pos.idle.frameTime = GetTickCount();
			}
		}
*/

	} // if (player is not moving)

	std::string strAnm;
//	GFX_MAP::iterator j = NULL;

	// Get the animation filename to use.
	switch (m_pos.loopFrame)
	{
		case LOOP_CUSTOM_STANCE:
		{
			// Custom stance. RPGCode call has inserted m_pos.stance.
			std::map<std::string, std::string>::iterator i = m_attr.mapCustomGfx.find(m_pos.stance);

			if (i != m_attr.mapCustomGfx.end())
			{
				// Iterator moves to end() if not found.
				strAnm = i->second;
			}
			break;
		}

		case LOOP_IDLE:
			// Idle. Use the idle animation of the facing direction.
//			j = m_attr.mapGfx[GFX_IDLE].find(m_pos.facing);
//			if (j != m_attr.mapGfx[GFX_IDLE].end())
//				strAnm = i->second;

			strAnm = m_attr.mapGfx[GFX_IDLE][m_pos.facing];
			break;

		default:
			// Walking graphics.
//			j = m_attr.mapGfx[GFX_MOVE].find(m_pos.facing);
//			if (j != m_attr.mapGfx[GFX_MOVE].end())
//				strAnm = i->second;

			strAnm = m_attr.mapGfx[GFX_MOVE][m_pos.facing];
	}


	if (m_lastRender.canvas == &m_canvas 
		&& m_lastRender.frame == m_pos.frame 
		&& m_lastRender.stance == strAnm 
		&& m_lastRender.x == m_pos.x 
		&& m_lastRender.y == m_pos.y)
	{
		// We've just rendered this frame so we don't need to again.
		return false;
	}

	// Update the last render.
	m_lastRender.canvas = &m_canvas;
	m_lastRender.frame = m_pos.frame;
	m_lastRender.stance = strAnm;
	m_lastRender.x = m_pos.x;
	m_lastRender.y = m_pos.y;

	// Render the frame to the sprite's canvas, at location (0, 0).
	renderAnimationFrame(&m_canvas, strAnm, m_pos.frame, 0, 0);

	return true;
}

/*
 * Calculate sprite location and place on destination canvas.
 */
bool CSprite::putSpriteAt(const CGDICanvas *cnvTarget, 
						  const int layer,
						  RECT &rect)
{
	extern BOARD g_activeBoard;

	// If we're rendering the top layer, draw the translucent sprite.
	if (m_pos.l != layer && layer != g_activeBoard.bSizeL) return false;

	// Render the frame here (but not when rendering translucently).
	if (m_pos.l == layer) this->render();

	// Screen location on board.
	extern RECT g_screen;
	extern CDirectDraw *g_pDirectDraw;
	extern double g_translucentOpacity;
	extern std::vector<SCROLL_CACHE> g_scrollCache;

/* Referencing with m_pos at the bottom-left corner of the tile. */

	const int centreX = m_pos.x - 16.0;
	const int centreY = m_pos.y;

	// Determine the centrepoint of the tile *on the screen* in pixels.
//    const int centreX = getBottomCentreX(m_pos.x, m_pos.y);
//    int centreY = getBottomCentreY(m_pos.x, m_pos.y);

    // + 8 offsets the sprite 3/4 of way down tile rather than 1/2 for isometrics.
//    if (g_activeBoard.isIsometric) centreY += 8;
       
    // The dimensions of the sprite frame, in pixels.
    const int spriteWidth = m_canvas.GetWidth();
    const int spriteHeight = m_canvas.GetHeight();

	// Sprite location on screen and board.
	RECT screen = {0, 0, 0, 0},
		 board = { centreX - int(spriteWidth / 2), centreY - spriteHeight,
				   centreX + int(spriteWidth / 2), centreY };
	

	if (!IntersectRect(&screen, &board, &g_screen))
	{
		// Off the screen!
		return false;
	}

	// screen holds the portion of the frame we need to draw.
	// Put the board co-ordinates into rect.
	rect = screen;

	// Blt the player to the target.
	if (m_pos.l == layer)
	{
		m_canvas.BltTransparentPart(cnvTarget,
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
	// (Should really do this separately right before flipping).
	if (layer == g_activeBoard.bSizeL && m_pos.l != layer)
	{
		m_canvas.BltTranslucentPart(cnvTarget,
								screen.left - g_screen.left,	// destination coord
								screen.top - g_screen.top,
								screen.left - board.left,		// source coord
								screen.top - board.top,
								screen.right - screen.left,		// width / height
								screen.bottom - screen.top,
								g_translucentOpacity,
								-1,
								TRANSP_COLOR);
	}
	// Return false on translucentBlt to prevent excessive queuing in renderNow().
	return false;
}

