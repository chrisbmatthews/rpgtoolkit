/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _LOCATE_H_
#define _LOCATE_H_

/*
 * Inclusions.
 */
#include "movement.h"

/*
 * Convert a tile co-ordinate to a pixel co-ordinate.
 */
void pixelCoordinate(int &x, int &y, const COORD_TYPE coord);

/*
 * Round a pixel co-ordinate to the centre of the corresponding tile.
 */
void roundToTile(double &x, double &y, const bool bIso);

/*
 * Transform old-type isometric co-ordinates to new-type.
 */
void isoCoordTransform(const double oldX, const double oldY, double &newX, double &newY);

/*
 * Inverse transform old-type isometric co-ordinates to new-type.
 */
void invIsoCoordTransform(const double newX, const double newY, double &oldX, double &oldY);

/*
 * Get the x coord at the bottom center of a board.
 * Called by putSpriteAt, checkScrollEast, checkScrollWest.
 */
int getBottomCentreX(const double boardX, const double boardY);

/*
 * Get the y coord at the bottom center of a board.
 * Called by putSpriteAt, checkScrollNorth, checkScrollSouth.
 */
int getBottomCentreY(const double boardX, const double boardY);

/*
 * Increment a player's position on the board.
 */
void incrementPosition(SPRITE_POSITION &pos, PENDING_MOVEMENT &pend, const double moveFraction);

/*
 * Fill in tile target coordinates from pending movement.
 */
void insertTarget(PENDING_MOVEMENT &pend);

/*
 * Round player coords.
 */
SPRITE_POSITION roundCoords(SPRITE_POSITION &passPos, const int direction);

/*
 * Increment the player co-ords one tile from the direction they are facing, to test
 * if items or programs lie directly in front of them.
 * Called by programTest only.
 */
SPRITE_POSITION activationCoords(SPRITE_POSITION &passPos, SPRITE_POSITION &roundPos);

#endif
