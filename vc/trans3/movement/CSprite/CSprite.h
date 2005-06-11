/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CSPRITE_H_
#define _CSPRITE_H_

#include "../../common/animation.h"
#include "../../common/board.h"
#include "../../common/sprite.h"
#include "../../common/paths.h"
#include "../../render/render.h"
#include "../movement.h"
#include "../locate.h"
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

class CSprite  
{
public:

	/*
	 * Constructor
	 */
	CSprite(const bool show);

	/*
	 * Copy constructor
	 */
	CSprite(const CSprite &rhs);

	/*
	 * Assignment operator
	 */
	CSprite &operator=(const CSprite &rhs);

	/*
	 * Destructor
	 */
	virtual ~CSprite();

	/*
	 * Evaluate the current movement state.
	 * Returns: true if movement occurred.
	 */
	bool move(void);

	/*
	 * Complete a single frame's movement of the sprite.
	 * Return: true if movement occurred.
	 */
	bool push(void);

	/*
	 * Get the next queued movement and remove it from the queue.
	 */
	int getQueuedMovements(void);

	/*
	 * Place a movement in the sprite's queue.
	 */
	void setQueuedMovements(const int queue, const bool bClearQueue);
	
	/*
	 * Run all the movements in the queue.
	 */
	void runQueuedMovements(void);

	/*
	 * Complete the selected player's move.
	 */
	void playerDoneMove(void);

	/*
	 * Determine the current sprite frame to use, and render if the current
	 * frame requires updating.
	 * Returns: true if frame requires redrawing.
	 */
	bool render(const CGDICanvas* cnv = NULL);

	/*
	 * Calculate sprite location and place on destination canvas.
	 */
	void CSprite::putSpriteAt(const CGDICanvas *cnvTarget, 
							  const bool bAccountForUnderTiles = true);

protected:
	SPRITE_POSITION m_pos;			// Current location and frame details.
	PENDING_MOVEMENT m_pend;		// Pending movements of the player, including queue.
	SPRITE_RENDER m_lastRender;		// Last render location / frame of the sprite.
	SPRITE_ATTR *m_pAttr;			// Pointer to sprite attributes.
	CGDICanvas *m_pCanvas;			// Pointer to sprite's frame.
	bool m_bActive;					// Is the sprite visible?
	int m_staticTileType;

};

#endif
