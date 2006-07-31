/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CSPRITE_H_
#define _CSPRITE_H_

/*
 * Includes 
 */
#include "../../../tkCommon/movement/board conversion.h"
#include "../../../tkCommon/movement/coords.h"
#include "../../../tkCommon/strings.h"
#include "../movement.h"
#include "../../common/sprite.h"
#include "../CVector/CVector.h"
#include "../CPathFind/CPathFind.h"

class CProgram;
class CThread;
struct tagBoard;
typedef struct tagBoard BOARD, *LPBOARD;

class CSprite  
{
public:
	CSprite(const bool show);				// Constructor.
	virtual ~CSprite() {}					// Destructor.
	static bool m_bPxMovement;				// Using pixel/tile movement (whole engine).

	void clearQueue(void);					// Clear the queue.
	void doMovement(						// Initiate rpgcode movements.
		const CProgram *prg, 
		const bool bPauseThread);
	void freePath(void) { m_pathFind.freeVectors(); }
	void parseQueuedMovements(				// Parse a Push() string and pass to setQueuedMovement().
		const STRING str, 
		const bool bClearQueue);	
	PF_PATH pathFind( 						// Pathfind to pixel position x, y (same layer).
		const int x,
		const int y, 
		const int type,
		const int flags);
	void runQueuedMovements(void);			// Run all the movements in the queue.
	void setQueuedMovement(					// Place a movement in the sprite's queue.
		const int queue,
		const bool bClearQueue, 
		int step = 0);
	void setQueuedPath(						// Queue up a path-finding path.
		PF_PATH &path, 
		const bool bClearQueue);	
	void setQueuedPoint(					// Queue just one point to create a path.
		const DB_POINT pt, 
		const bool bClearQueue)	
	{
		if (bClearQueue) m_pos.path.clear();
		m_pos.path.push_back(pt);
	}
	void setBoardPath(						// Set a board vector as a path.
		CVector *const pV, 
		const int cycles, 
		const int flags);

	void drawPath(CCanvas *const cnv);		// Draw the path this sprite is on.
	void drawVector(CCanvas *const cnv);	// Debug: draw the sprite's base vector.
	void drawPfObjects(int x, int y, CCanvas *cnv) { m_pathFind.drawObstructions(x, y , cnv); }
	
	bool render( 							// Render frame to canvas.
		const CCanvas *cnv,
		const int layer,
		RECT &rect);
	void setAnm(MV_ENUM dir);				// Set the facing animation.
	void customStance( 						// Start a custom stance.
		const STRING stance, 
		const CProgram *prg, 
		const bool bPauseThread);

	bool move(								// Evaluate the current movement state.
		const CSprite *selectedPlayer,
		const bool bRunningProgram);
	void deactivatePrograms(void);			// Override repeat values for programs the player is standing on.
	void playerDoneMove(void);				// Complete the selected player's move.
	bool programTest(void);					// Test for program activations (by programs, items, players).
	void send(void);						// Unconditionally send the sprite to the active board.
	TILE_TYPE spriteCollisions(void);		// Evaluate sprites (players and items).

	void alignBoard( 						// Align a RECT to the sprite's location.
		RECT &rect,
		const bool bAllowNegatives);
	void getDestination(DB_POINT &p) const;
	SPRITE_POSITION getPosition(void) const { return m_pos; }
	bool isActive(void) const { return m_bActive; }
	void setActive(const bool bActive) { m_bActive = bActive; }
	void setPosition(int x, int y, const int l, const COORD_TYPE coord);
	BRD_SPRITE *getBoardSprite(void) { return &m_brdData; }

	// Create default vectors, overwriting any user-defined (PRE_VECTOR_ITEMs).
	void createVectors(void) { m_attr.createVectors(m_brdData.activationType); };
	// Determine if the sprite's base intersects a RECT.
	CVector getVectorBase(const bool bAtLocation) const
	{
		if (!bAtLocation) return m_attr.vBase;
		const DB_POINT p = { m_pos.x, m_pos.y };
		return (CVector(m_attr.vBase) + p);
	}

	// Return the number of pixels for the whole move (e.g. 32, 1, 2).
	int moveSize(void) const
	{
		const int result = (!m_bPxMovement ? 32 : round(PX_FACTOR / m_pos.loopSpeed));
		return (result < 1 ? 1 : result);
	}
	static void setLoopOffset(const int offset) { m_loopOffset = offset; }
	void setSpeed(const double delay) { m_attr.speed = delay * MILLISECONDS; }

	// The facing direction - tie changes to alter the animation.
	class CFacing
	{
	public:
		CFacing(CSprite *owner): m_dir(MV_S), m_owner(owner) {}
		void assign(MV_ENUM dir) { m_dir = dir; m_owner->setAnm(m_dir); }
		MV_ENUM right(void) { MV_ENUM dir = m_dir; return ++dir; }
		MV_ENUM left(void) { MV_ENUM dir = m_dir; return --dir; }
		MV_ENUM dir(void) const { return m_dir; }
		CFacing &operator+= (unsigned int i) 
		{ 
			m_dir += i; 
			m_owner->setAnm(m_dir);
			return *this;
		}
		CFacing &operator= (CFacing &rhs) 
		{ 
			m_dir = rhs.m_dir; 
			m_owner->setAnm(m_dir);
			return *this;
		}
	private:
		MV_ENUM m_dir;
		CSprite *m_owner;
	};
	CFacing *getFacing(void) { return &m_facing; }


protected:
	SPRITE_ATTR m_attr;						// Sprite attributes (common file data).
	bool m_bActive;							// Is the sprite visible?
	BRD_SPRITE m_brdData;					// Board-set sprite data (activation variables).
	CCanvas *m_pCanvas;						// Pointer to sprite's frame.
	SPRITE_POSITION m_pos;					// Current location and frame details.
	TILE_TYPE m_tileType;					// The tiletypes at the sprite's location (NOT the "tiletype" of the sprite).
	DB_POINT m_v;							// Position vector in movement direction
	CPathFind m_pathFind;					// Sprite-specific pathfinding information.
	CFacing m_facing;						// Facing direction.
	CThread *m_thread;						// Sleeping thread id if moving in a thread.

private:
	static bool m_bDoneMove;				// Record whether we need to run playerDoneMove().
	static int m_loopOffset;				// Global speed offset.

	// Evaluate board vectors.
	TILE_TYPE boardCollisions(LPBOARD board, const bool recursing = false);
	
	TILE_TYPE boardEdges(const bool bSend);	// Tests for movement at the board edges.
	void checkIdling(void);					// Update idle and custom animations.
	MV_ENUM getDirection(void) const;		// Take the angle of movement and return a MV_ENUM direction.
	DB_POINT getTarget(void) const;			// Get the next position co-ordinates.
	bool push(const bool bScroll);			// Complete a single frame's movement of the sprite.
	void setPathTarget(void);				// Insert target co-ordinates from the path.
	void setTarget(MV_ENUM direction);		// Increment target co-ordinates based on a direction.
	bool findDiversion(void);

	// Calculate the loopSpeed - the number of renders that equate to
	// the sprite's movement speed (and any offsets).
	inline int calcLoops() const
	{
		// Frames per millisecond.
		extern double g_fpms;
		const int result = round(m_attr.speed * g_fpms) + (m_loopOffset * round(g_fpms * 100.0));
		return (result < 1 ? 1 : result);
	};
};

/*
 * A z-ordered vector of players and items.
 */
typedef struct tagZOrderedSprites
{
	std::vector<CSprite *> v;

	// Form v into a z-ordered vector from g_players and g_items.
	void zOrder();

	// Free pathfinding vectors CPathFind::m_obstructions.
	void freePaths()
	{
		for (std::vector<CSprite *>::iterator i = v.begin(); i != v.end(); ++i)
			(*i)->freePath();
	};

	// Remove a pointer from the vector.
	void remove(CSprite *p)
	{
		for (std::vector<CSprite *>::iterator i = v.begin(); i != v.end(); ++i)
		{
			if (*i == p) 
			{
				v.erase(i);
				return;
			}
		}
	};

} ZO_VECTOR;

#endif
