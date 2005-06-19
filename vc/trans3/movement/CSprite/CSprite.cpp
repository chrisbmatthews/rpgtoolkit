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
m_tileType(TT_NORMAL)
{
	m_v.x = m_v.y = 0;

	// Create canvas.
	m_pCanvas = new CGDICanvas();
	m_pCanvas->CreateBlank(NULL, 32, 32, TRUE);
	m_pCanvas->ClearScreen(0);
}

/*
 * Copy constructor
 */
CSprite::CSprite(const CSprite &rhs)
{
	// Copy canvas.
}

/*
 * Assignment operator
 */
CSprite &CSprite::operator=(const CSprite &rhs)
{
	return CSprite(true);
	// Copy canvas.
}

/*
 * Destructor
 */
CSprite::~CSprite() 
{
	m_pCanvas->Destroy();
	delete m_pCanvas;
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
	extern unsigned int g_renderCount;
	extern unsigned int g_renderTime;

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
			m_tileType = CVECTOR_TYPE(boardCollisions() | spriteCollisions());

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
			const double avgTimeInverse = g_renderCount / g_renderTime; // transMain?
			m_pos.loopSpeed = round(m_attr.speed * avgTimeInverse) + (g_loopOffset * round(avgTimeInverse / 10));
			
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
		if (push() || ((m_tileType & TT_SOLID) && (this == selectedPlayer)))
		{
			if (m_pos.loopFrame % int(m_pos.loopSpeed / g_movementSize) == 0)
			{
				// Increment the animation frame when we're on a multiple of
				// loopSpeed (the number of renders to make between animation
				// frame increments).
				m_pos.frame++;
			}

			// Always increment the render count.
			m_pos.loopFrame++;

			// Frames per move is the number of animation frames to
			// draw per move - a move being 1 tile or 1/4 tile.
			if (m_pos.loopFrame == framesPerMove() * m_pos.loopSpeed)
			{
				// The number of renders is equal to the animation frames
				// per move times the renders between animation frames
				// - i.e. we have finished movement.
				if (!(m_tileType & TT_SOLID))
				{
					m_pend.xOrig = m_pend.xTarg;
					m_pend.yOrig = m_pend.yTarg;
					m_pend.lOrig = m_pos.l;
					m_pos.x = m_pend.xTarg;
					m_pos.y = m_pend.yTarg;
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
bool CSprite::push(void) 
{
	extern double g_movementSize;

	SPRITE_POSITION testPosition = m_pos;
    const double moveFraction = g_movementSize / (framesPerMove() * m_pos.loopSpeed);
	
	incrementPosition(m_pos, m_pend, moveFraction);

//	if (spriteCollisions())
	if (m_tileType & TT_SOLID)
	{
		// May check collisions every frame.
		m_pos = testPosition;
		return false;	// Except for selected player.
	}

	// Scroll the board for players. Either set for all players, or only selected player
	// and create a Scroll RPGCode function so that scrolling can be achieved without having
	// to use invisible players.
	/*	Scroll() */
	
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
	extern unsigned int g_stepsTaken;
	/*
	 * Used to track number of times fighting
	 * *would* have been checked for if not
	 * in pixel movement. In pixel movement,
	 * only check every four steps (one tile).
	 */
	static int checkfight;

	programTest();

	// Test for a fight.
	checkfight++;
	if (checkfight == (1 / g_movementSize))
	{
//		fightTest();
		checkfight = 0;
	}

	// Update the step count (doesn't take pixel movement into account yet).
	g_stepsTaken++;

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
CVECTOR_TYPE CSprite::boardCollisions(const bool recursing)
{
	// To do - stairs, layers.
	extern BOARD g_activeBoard;

	CVECTOR_TYPE tileTypes = TT_NORMAL;

	// Create the sprite's vector base at the *target* location.
	DB_POINT p = {(m_pend.xTarg - 1.0) * 32.0, (m_pend.yTarg - 1.0) * 32.0};
	CVector sprBase = m_attr.vBase + p;

	// Loop over the board CVectors and check for intersections.
	for (std::vector<CVector *>::iterator i = g_activeBoard.vectors.begin(); i != g_activeBoard.vectors.end(); ++i)
	{
		// Check that the board vector contains the player,
		// *not* the other way round!
		CVECTOR_TYPE tt = (*i)->contains(sprBase, p);

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
		tileTypes = CVECTOR_TYPE(tileTypes | tt);

	} // for (i)

	return tileTypes;
}

/*
 * Check for collisions with other sprite base vectors. Currently only
 * returns TT_SOLID or TT_NORMAL, as all sprites default to solid.
 */
CVECTOR_TYPE CSprite::spriteCollisions(void)
{
	extern std::vector<CPlayer *> g_players;
	extern std::vector<CItem *> g_items;

	// Create the sprite's vector base at the *target* location.
	DB_POINT p = {(m_pend.xTarg - 1.0) * 32.0, (m_pend.yTarg - 1.0) * 32.0};
	CVector sprBase = m_attr.vBase + p;

	for(std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); i++)
	{
		if (this == *i) continue;

		// Compare target bases.
		DB_POINT pt = {((*i)->m_pend.xTarg - 1.0) * 32.0, ((*i)->m_pend.yTarg - 1.0) * 32.0};
		CVector tarBase = (*i)->m_attr.vBase + pt;

		if (tarBase.contains(sprBase, p) != TT_NORMAL)
		{
			// Hit another player.
			return TT_SOLID;
		}

// Compare origins? Merge origins and targets? (how?)
	}

	// Items. Possible to put in one loop with players?
	for(std::vector<CItem *>::iterator j = g_items.begin(); j != g_items.end(); j++)
	{
		if (this == *j) continue;

		// Compare target bases.
		DB_POINT pt = {((*j)->m_pend.xTarg - 1.0) * 32.0, ((*j)->m_pend.yTarg - 1.0) * 32.0};
		CVector tarBase = (*j)->m_attr.vBase + pt;

		if (tarBase.contains(sprBase, p) != TT_NORMAL)
		{
			// Hit an item.
			return TT_SOLID;
		}
	}
	return TT_NORMAL;
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
	DB_POINT p = {(m_pend.xTarg - 1.0) * 32.0, (m_pend.yTarg - 1.0) * 32.0};
	CVector sprBase = m_attr.vBase + p;

	// Construct merged origin / target?

	// Players 
	for(std::vector<CPlayer *>::iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		if (this == *i) continue;

		DB_POINT pt = {((*i)->m_pos.x - 1.0) * 32.0, ((*i)->m_pos.x - 1.0) * 32.0};
		CVector tarActivate = (*i)->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p) != TT_NORMAL)
		{
			// Standing in another player's area.
		}
	}

	// Items
	for(std::vector<CItem *>::iterator j = g_items.begin(); j != g_items.end(); ++j)
	{
		if (this == *j) continue;

		DB_POINT pt = {((*j)->m_pos.x - 1.0) * 32.0, ((*j)->m_pos.y - 1.0) * 32.0};
		CVector tarActivate = (*j)->m_attr.vActivate + pt;

		if (tarActivate.contains(sprBase, p) != TT_NORMAL)
		{
			// Standing in an item's area.
		}
	}

	std::vector<LPBRD_PROGRAM>::iterator k = g_activeBoard.programs.begin();
	LPBRD_PROGRAM prg = NULL;

	// Programs
	for (; k != g_activeBoard.programs.end(); ++k)
	{
		// Check that the board vector contains the player.
		// We check *every* vector, in order to reset the 
		// distance of those we have left.
		if ((*k)->vBase.contains(sprBase, p) == TT_NORMAL)
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
			(*k)->distance += g_movementSize * 32;

			// Check activation conditions.
			if ((*k)->activationType & PRG_REPEAT)
			{
				// Repeat triggers - check player has moved
				// the required distance.
				if ((*k)->distance < (*k)->distanceRepeat) continue;
			}
			else
			{
				// Single trigger - check the player has moved at all.
				if ((*k)->distance != g_movementSize * 32) continue;
			}

			if ((*k)->activationType & PRG_KEYPRESS)
			{
				// General activation key - if not pressed, continue.
				if (GetAsyncKeyState(g_mainFile.key[0]) >= 0) continue;
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
		CProgram(g_projectPath + PRG_PATH + prg->fileName).run();
		if (prg->activate == PRG_CONDITIONAL)
		{
			const double num = atof(prg->finalValue.c_str());
			CProgram::setGlobal(prg->finalVar, (num == 0.0) ? prg->finalValue : CVariant(num));
		}
		return true;
	}
	return false;
}

// Debug function - draw vector onto screen.
// Might be worth keeping in some form, but drawing to canvas rather than
// directly to the device!
void CSprite::drawVector(void)
{
	// Draw the target base one colour.
	DB_POINT p = {(m_pend.xTarg - 1.0) * 32.0, (m_pend.yTarg - 1.0) * 32.0};
	CVector sprBase = m_attr.vBase + p;
	sprBase.draw(65535, false);

	// Draw the current position base another.
	p.x = (m_pos.x - 1.0) * 32.0; p.y = (m_pos.y - 1.0) * 32.0;
	sprBase = m_attr.vBase + p;
	sprBase.draw(16777215, false);
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
 * Render functions.
 */

/*
 * Determine the current sprite frame to use, and render if the current
 * frame requires updating.
 * Returns: true if frame requires redrawing.
 */
bool CSprite::render(const CGDICanvas* cnv) 
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
	std::map<std::string, std::string>::iterator i = NULL;
//	GFX_MAP::iterator j = NULL;

	// Get the animation filename to use.
	switch (m_pos.loopFrame)
	{
		case LOOP_CUSTOM_STANCE:
			// Custom stance. RPGCode call has inserted m_pos.stance.
			i = m_attr.mapCustomGfx.find(m_pos.stance);

			if (i != m_attr.mapCustomGfx.end())
			{
				// Iterator moves to end() if not found.
				strAnm = i->second;
			}
			break;

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


	if (m_lastRender.canvas == m_pCanvas 
		&& m_lastRender.frame == m_pos.frame 
		&& m_lastRender.stance == strAnm 
		&& m_lastRender.x == m_pos.x 
		&& m_lastRender.y == m_pos.y)
	{
		// We've just rendered this frame so we don't need to again.
		return false;
	}

	// Update the last render.
	m_lastRender.canvas = m_pCanvas;
	m_lastRender.frame = m_pos.frame;
	m_lastRender.stance = strAnm;
	m_lastRender.x = m_pos.x;
	m_lastRender.y = m_pos.y;

	// Render the frame to the sprite's canvas, at location (0, 0).
	renderAnimationFrame(m_pCanvas, strAnm, m_pos.frame, 0, 0);

	return true;
}

/*
 * Calculate sprite location and place on destination canvas.
 * To be cleaned!
 */
void CSprite::putSpriteAt(const CGDICanvas *cnvTarget)
{    
	extern BOARD g_activeBoard;
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;
	extern double g_translucentOpacity;

    double xOrig = m_pend.xOrig;
    double yOrig = m_pend.yOrig;
    double xTarg = m_pend.xTarg;
    double yTarg = m_pend.yTarg;
    
    if (xOrig > g_activeBoard.bSizeX || xOrig < 0) xOrig = round(m_pos.x);
    if (yOrig > g_activeBoard.bSizeY || yOrig < 0) yOrig = round(m_pos.y);
    if (xTarg > g_activeBoard.bSizeX || xTarg < 0) xTarg = round(m_pos.x);
    if (yTarg > g_activeBoard.bSizeY || yTarg < 0) yTarg = round(m_pos.y);
    
    const BYTE targetTile = 0; // g_activeBoard.tiletype[round(xTarg)][-int(-yTarg)][int(m_pos.l)];
    const BYTE originTile = 0; // g_activeBoard.tiletype[round(xOrig)][-int(-yOrig)][int(m_pos.l)];


	/*    
	 * If [tiles on layers above]
	 * OR [Moving *to* "under" tile (target)]
	 * OR [Moving *from* "under" tile (origin)]
	 * OR [Moving between "under" tiles]
	 */ 
    bool bDrawTranslucently = false;
    if (g_activeBoard.isIsometric)
	{
        if (
/*            checkAbove(m_pos.x, m_pos.y, m_pos.l) == 1
            || */ (targetTile == UNDER && round(m_pos.x) == xTarg && round(m_pos.y) == yTarg)
            || (originTile == UNDER && round(m_pos.x) == xOrig && round(m_pos.y) == yOrig)
            || (targetTile == UNDER && originTile == UNDER))
                bDrawTranslucently = true;
	}
    else
	{
        if (
/*            checkAbove(m_pos.x, m_pos.y, m_pos.l) == 1
            || */ (targetTile == UNDER && round(m_pos.x) == round(xTarg) && -int(-m_pos.y) == -int(-yTarg))
            || (originTile == UNDER && round(m_pos.x) == round(xOrig) && -int(-m_pos.y) == -int(-yOrig))
            || (targetTile == UNDER && originTile == UNDER))
                bDrawTranslucently = true;
	}

    // Determine the centrepoint of the tile in pixels.
    const int centreX = getBottomCentreX(m_pos.x, m_pos.y);
    int centreY = getBottomCentreY(m_pos.x, m_pos.y);

    // + 8 offsets the sprite 3/4 of way down tile rather than 1/2 for isometrics.
    if (g_activeBoard.isIsometric) centreY += 8;
       
    // The dimensions of the sprite frame, in pixels.
    const int spriteWidth = m_pCanvas->GetWidth();
    const int spriteHeight = m_pCanvas->GetHeight();

    // Will place the top left corner of the sprite frame at cornerX, cornerY:
    int cornerX = centreX - int(spriteWidth / 2);
    int cornerY = centreY - spriteHeight;
           
    // Exit if sprite is off the board.
    if (cornerX > g_resX || 
		cornerY > g_resY ||
        cornerX + spriteWidth < 0 || 
		cornerY + spriteHeight < 0) return;
       
    // Offset on the sprite's frame from the top left corner (cornerX, cornerY)
    int offsetX = 0, offsetY = 0;
    // Portion of frame to be drawn, after offset considerations.
    int renderWidth = 0, renderHeight = 0;
       
    // Calculate locations and areas to draw.
    if (cornerX < 0)
	{
        offsetX = -cornerX;
        if (cornerX + spriteWidth > g_resX)
            renderWidth = g_resX;					// Both edges off board.
        else
            renderWidth = spriteWidth - offsetX;	// Left.
        cornerX = 0;
	}
    else
	{
        if (cornerX + spriteWidth > g_resX)
            renderWidth = g_resX - cornerX;			// Right.
        else
            renderWidth = spriteWidth;				// None.
	}
    
    if (cornerY < 0)
	{
        offsetY = -cornerY;
        if (cornerY + spriteHeight > g_resY)
            renderHeight = g_resY;					// Both.
        else
            renderHeight = spriteHeight - offsetY;	// Left.
        cornerY = 0;
	}
    else
	{
        if (cornerY + spriteHeight > g_resY)
            renderHeight = g_resY - cornerY;		// Right.
        else
            renderHeight = spriteHeight;			// None.
	}
    
    // We now have the position and area of the sprite to draw.
    // Check if we need to draw the sprite transluscently:
    
//    if (bDrawTranslucently)
	if(m_tileType & TT_UNDER)
	{
        // If on "under" tiles, make sprite translucent.
        
        if (!cnvTarget)
		{
			// Draw to screen.
			g_pDirectDraw->DrawCanvasTranslucentPartial(m_pCanvas,
														cornerX,
														cornerY,
														offsetX,
														offsetY,
														renderWidth,
														renderHeight,
														g_translucentOpacity,
														-1,
														TRANSP_COLOR);
		}
        else 
		{
			// Draw to canvas.
			/* Canvas checks */
			m_pCanvas->BltTranslucentPart(cnvTarget,
										cornerX,
										cornerY,
										offsetX,
										offsetY,
										renderWidth,
										renderHeight,
										g_translucentOpacity,
										-1,
										TRANSP_COLOR);
		}
	}
    else
	{
        // Draw solid. Transparent refers to the transparent colour (alpha) on the frame.
        if (!cnvTarget)
		{
			// Draw to screen.
			g_pDirectDraw->DrawCanvasTransparentPartial(m_pCanvas,
														cornerX,
														cornerY,
														offsetX,
														offsetY,
														renderWidth,
														renderHeight,
														TRANSP_COLOR);
		}
        else 
		{
			// Draw to canvas.
			/* Canvas checks */
			m_pCanvas->BltTransparentPart(cnvTarget,
										cornerX,
										cornerY,
										offsetX,
										offsetY,
										renderWidth,
										renderHeight,
										TRANSP_COLOR);
		}
	} // if (bDrawTranslucently)
}
