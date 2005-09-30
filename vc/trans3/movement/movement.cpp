/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "movement.h"
#include "locate.h"
#include "../common/board.h"
#include "../common/item.h"

/*
 * Globals.
 */

// Temp. uncomment to allow compile.
typedef std::vector<SPRITE_POSITION> SPRITE_POSITIONS;
typedef std::vector<PENDING_MOVEMENT> PENDING_MOVEMENTS;

SPRITE_POSITIONS g_pPos;					// Player positions.
SPRITE_POSITIONS g_itmPos;					// Positions of items on board.
PENDING_MOVEMENTS g_pendingPlayerMovement;	// Pending player movements.
PENDING_MOVEMENTS g_pendingItemMovement;	// Pending item movements.

int g_selectedPlayer = 0;					// Index of current player.
double g_movementSize = 32.0;				// Movement size (in pixels).
unsigned long g_stepsTaken = 0;				// Number of steps the player has taken.
