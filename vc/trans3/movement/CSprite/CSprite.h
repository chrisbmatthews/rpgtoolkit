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
#include "../movement.h"
#include "../../common/sprite.h"
#include "../../render/render.h"
#include "../CVector/CVector.h"

class CSprite  
{
public:

	// Constructor.
	CSprite(const bool show);

	// Destructor.
	virtual ~CSprite() { }

	// Evaluate the current movement state.
	bool move(const CSprite *selectedPlayer);

	// Return the number of pixels for the whole move (e.g. 32, 1, 2).
	int moveSize(void) const
	{
		const int result = (!m_bPxMovement ? 32 : round(PX_FACTOR / m_pos.loopSpeed));
		return (result < 1 ? 1 : result);
	};

	// Determine if the sprite's base intersects a RECT.
	CVector getVectorBase(void)
	{
		const DB_POINT p = { m_pos.x, m_pos.y };
		return (m_attr.vBase + p);
	};

	// Create default vectors, overwriting any user-defined.
	// Called for PRE_VECTOR_ITEMs.
	void createVectors(void) { m_attr.createVectors(m_brdData.activationType); };

	// Get the next queued movement and remove it from the queue.
	MV_ENUM getQueuedMovements(void);

	// Place a movement in the sprite's queue.
	void setQueuedMovements(const int queue, const bool bClearQueue);
	
	// Run all the movements in the queue.
	void runQueuedMovements(void);

	// Complete the selected player's move.
	void playerDoneMove(void);

	// Set the sprite's locations based on a co-ordinate system.
	void setPosition(int x, int y, const int l, const COORD_TYPE coord);

	// Evaluate sprites (players and items).
	TILE_TYPE spriteCollisions(void);

	// Unconditionally send the sprite to the active board.
	void send(void);

	// Test for program activations (by programs, items, players).
	bool programTest(void);

	// Override repeat values for programs the player is standing on.
	void deactivatePrograms(void);

	// Debug: draw the sprite's base vector.
	void drawVector(CGDICanvas *const cnv);

	// Calculate sprite location and place on destination canvas.
	bool putSpriteAt(const CGDICanvas *cnvTarget, 
					const int layer,
					RECT &rect);

	// Align a RECT to the sprite's location.
	void alignBoard(RECT &rect, const bool bAllowNegatives);

	// Using pixel/tile movement (whole engine).
	static bool m_bPxMovement;		

protected:
	SPRITE_ATTR m_attr;				// Sprite attributes (common file data).
	bool m_bActive;					// Is the sprite visible?
	BRD_SPRITE m_brdData;			// Board-set sprite data (activation variables).
	SPRITE_RENDER m_lastRender;		// Last render location / frame of the sprite.
	CGDICanvas m_canvas;			// Pointer to sprite's frame.
	SPRITE_POSITION m_pos;			// Current location and frame details.
	PENDING_MOVEMENT m_pend;		// Pending movements of the player, including queue.
	TILE_TYPE m_tileType;			// The tiletypes at the sprite's location (NOT the "tiletype" of the sprite).
	DB_POINT m_v;					// Position vector in movement direction

private:

	// Complete a single frame's movement of the sprite.
	bool push(const bool bScroll);

	// Increment the target co-ordinates based on the move direction.
	void insertTarget(void);

	// Calculate the loopSpeed - the number of renders that equate to
	// the sprite's movement speed (and any offsets).
	inline int calcLoops(void) const
	{
		extern int g_loopOffset;
		extern double g_renderCount, g_renderTime;

		// Frames per millisecond.
		const double fpms = g_renderCount / g_renderTime;
		const int result = round(m_attr.speed * fpms) + (g_loopOffset * round(fpms * 100.0));
		return (result < 1 ? 1 : result);
	};

	// Evaluate board vectors.
	TILE_TYPE boardCollisions(LPBOARD board, const bool recursing = false);

	// Tests for movement at the board edges.
	TILE_TYPE boardEdges(const bool bSend);

	// Render if the current frame requires updating.
	bool render(void);

};

typedef struct tagZOrderedSprites
{
	std::vector<CSprite *> v;
	void zOrder(void);
} ZO_VECTOR;

#endif
