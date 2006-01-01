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
void pixelCoordinate(int &x, int &y, const COORD_TYPE coord, const bool bAddBasePoint);

/*
 * Convert a pixel co-ordinate to a tile co-ordinate.
 */
void tileCoordinate(int &x, int &y, const COORD_TYPE coord);

/*
 * Round a pixel co-ordinate to the centre of the corresponding tile.
 */
void roundToTile(double &x, double &y, const bool bIso, const bool bAddBasePoint);

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

#endif
