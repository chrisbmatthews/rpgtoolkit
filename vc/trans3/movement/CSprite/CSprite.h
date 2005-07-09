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

	// Copy constructor.
	CSprite(const CSprite &rhs);

	// Assignment operator.
	CSprite &operator=(const CSprite &rhs);

	// Destructor.
	virtual ~CSprite();

	// Evaluate the current movement state.
	bool move(const CSprite *selectedPlayer);

	// Complete a single frame's movement of the sprite.
	bool push(const CSprite *selectedPlayer);

	// Get the next queued movement and remove it from the queue.
	MV_ENUM getQueuedMovements(void);

	// Place a movement in the sprite's queue.
	void setQueuedMovements(const int queue, const bool bClearQueue);
	
	// Run all the movements in the queue.
	void runQueuedMovements(void);

	// Complete the selected player's move.
	void playerDoneMove(void);

	// Increment the target co-ordinates based on the move direction.
	void insertTarget(void);

	// Set the sprite's target and current locations.
	void setPosition(const int x, const int y, const int l);

	// Evaluate board vectors.
	TILE_TYPE boardCollisions(const bool recursing = false);
	
	// Evaluate sprites (players and items).
	TILE_TYPE spriteCollisions(void);

	// Test for program activations (by programs, items, players).
	bool programTest(void);

	// Override repeat values for programs the player is standing on.
	void deactivatePrograms(void);

	// Debug: draw the sprite's base vector.
	void drawVector(void);

	// Render if the current frame requires updating.
	bool render(void);

	// Calculate sprite location and place on destination canvas.
	bool putSpriteAt(const CGDICanvas *cnvTarget, 
					const int layer,
					RECT &rect);

	// Align a RECT to the sprite's location.
	void alignBoard(RECT &rect, const bool bAllowNegatives);

protected:
	SPRITE_ATTR m_attr;				// Sprite attributes (common file data).
	bool m_bActive;					// Is the sprite visible?
	BRD_SPRITE m_brdData;			// Board-set sprite data (activation variables).
	SPRITE_RENDER m_lastRender;		// Last render location / frame of the sprite.
	CGDICanvas *m_pCanvas;			// Pointer to sprite's frame.
	SPRITE_POSITION m_pos;			// Current location and frame details.
	PENDING_MOVEMENT m_pend;		// Pending movements of the player, including queue.
	TILE_TYPE m_tileType;			// The tiletypes at the sprite's location (NOT the "tiletype" of the sprite).
	DB_POINT m_v;					// Position vector in movement direction

};

typedef struct tagZOrderedSprites
{
	std::vector<CSprite *> v;
	void zOrder(void);
} ZO_VECTOR;

#endif
