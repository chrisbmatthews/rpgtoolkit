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
SPRITE_POSITIONS g_pPos;					// Player positions.
SPRITE_POSITIONS g_itmPos;					// Positions of items on board.
PENDING_MOVEMENTS g_pendingPlayerMovement;	// Pending player movements.
PENDING_MOVEMENTS g_pendingItemMovement;	// Pending item movements.
int g_selectedPlayer = 0;					// Index of current player.
int g_loopOffset = 0;						// Offset for movement loops.
double g_movementSize = 1.0;				// Movement size (in fractions of a tile).

/*
 * Externals.
 */
extern BOARD g_activeBoard;		// The active board.

/*
 * Determine whether tiles are above x, y, z.
 *
 * x + y + z (in) - coordinates on the board
 * return (out) - whether there are
 */
bool checkAbove(const int x, const int y, const int z)
{
	if (z == g_activeBoard.bSizeL) return false;
	for (unsigned int i = z + 1; i <= g_activeBoard.bSizeL; i++)
	{
		if (!g_activeBoard.tileIndex[g_activeBoard.board[x][y][i]].empty())
		{
			// Tiles above!
			return true;
		}
	}
	return false;
}


/*
 * -Checks the current location and target co-ordinates against all player and item locations.
 * If the subject comes within a certain range of the object, the SOLID tiletype is returned.
 * -This is to be called every 1/4 tile (or less):
 *       - every frame for tile mvt
 *       - only at start for pixel mvt (since distances are so small).
 * -Tile mvt: If beginning move (if .loopFrame = 0) checks against objects that are moving are
 *           ignored since they may vacate the tile during the move. Moving items are detected
 *           on a per-frame basis.
 * -Pixel mvt:This is only called at the start of a move (if .loopFrame = 0), and all items
 *           (both moving / stationary) are considered.
 *
 * Last edited for 3.0.6 by Delano : tile mvt diagonal fix.
 * Called by EffectiveTileType, MoveItems, MovePlayers, PushItem, PushPlayer
 */
int checkObstruction(SPRITE_POSITION &pos, PENDING_MOVEMENT &pend, const int currentPlayer, const int currentItem, char &staticTileType, const bool bStartingMove = false)
{

	extern std::vector<bool> g_showPlayer;
	extern std::vector<ITEM> g_itemMem;

	// Transform pixel isometrics.
	double posX, posY, xTarg, yTarg;
	double tPosX, tPosY, txTarg, tyTarg;

	isoCoordTransform(pos.x, pos.y, posX, posY);
	isoCoordTransform(pend.xTarg, pend.yTarg, xTarg, yTarg);

	const double pMovementSize = (g_activeBoard.isIsometric ? 1 : g_movementSize);

	unsigned int i;
	const unsigned int players = g_pendingPlayerMovement.size();

	// Check players.
	for (i = 0; i < players; i++)
	{

		if (g_showPlayer[i] && i != currentPlayer)
		{
			// Only if the player is on the board, and is not the player we're checking against.

			isoCoordTransform(g_pPos[i].x, g_pPos[i].y, tPosX, tPosY);
			isoCoordTransform(g_pendingPlayerMovement[i].xTarg,
									g_pendingPlayerMovement[i].yTarg,
									txTarg,
									tyTarg);

			if (g_movementSize == 1)
			{
				// Tile movement.

				// Current (test!) location against player current location.
				if (
					(abs(posY - tPosY) < pMovementSize) &&
					(abs(posX - tPosX) < 1) &&
					(g_pPos[i].l == pos.l))
				{
					
					if ((!bStartingMove) && (g_pendingPlayerMovement[i].direction == MV_IDLE))
					{
						/*
						 * Player had started moving but this item is idle.
						 * Change the staticTileType to force the loop through.
						 */
						staticTileType = SOLID;
					}

					return SOLID;

				}

				/*
				 * Only test targets if we're beginning movement.
				 * If we're in movement and the target becomes occupied (if it was occupied at start
				 * then movement would be rejected) it must be due to another moving *player*.
				 * In this case, continue movement because we can't stop!
				 */
				if (
					(abs(yTarg - tyTarg) < pMovementSize) &&
					(abs(xTarg - txTarg) < 1) &&
					(g_pPos[i].l == pos.l) &&
					bStartingMove)
				{
					return SOLID;
				}

			}
			else
			{

				/*
				 * Pixel movement.
				 * Only check this at the start of a move.
				 */
				if (bStartingMove)
				{

					// Current locations: minimum separations. Probably don't even need these.
					if (
						(abs(posY - tPosY) < pMovementSize) &&
						(abs(posX - tPosX) < 1) &&
						(g_pPos[i].l == pos.l))
					{
						return SOLID;
					}

					// Target location against player current location.
					if (
						(abs(tPosY - yTarg) < pMovementSize) &&
						(abs(tPosX - xTarg) < 1) &&
						(g_pPos[i].l == pos.l))
					{
						return SOLID;
					}

					// Target location against player target location.
					if (
						(abs(yTarg - tyTarg) < pMovementSize) &&
						(abs(xTarg - txTarg) < 1) &&
						(g_pPos[i].l == pos.l))
					{
						return SOLID;
					}

				} // startingMove.

			} //usingPixelMovement.

		} // showPlayer.

	}

	const unsigned int items = g_pendingItemMovement.size();

	// Items.
	for (i = 0; i < items; i++)
	{

		if ((!g_itemMem[i].itemName.empty()) && (i != currentItem))
		{

			isoCoordTransform(g_itmPos[i].x, g_itmPos[i].y, tPosX, tPosY);
			isoCoordTransform(g_pendingItemMovement[i].xTarg,
								   g_pendingItemMovement[i].yTarg,
								   txTarg,
								   tyTarg);

			bool coordMatch = false;

			if (g_movementSize == 1)
			{

				// Tile movement.

				// Current locations.
				if (
					(abs(tPosY - posY) < pMovementSize) &&
					(abs(tPosX - posX) < 1) &&
					(g_itmPos[i].l == pos.l))
				{

					coordMatch = !(bStartingMove && (g_pendingItemMovement[i].direction != MV_IDLE));
										   
					if ((!bStartingMove) && (g_pendingItemMovement[i].direction == MV_IDLE))
					{
						/*
						 * Player had started moving but this item is idle.
						 * Change the staticTileType to force the loop through.
						 */
						staticTileType = SOLID;
					}

				}

				/*
				 * Only test targets if we're beginning movement.
				 * If we're in movement and the target becomes occupied (if it was occupied at start
				 * then movement would be rejected) it must be due to another moving *player*.
				 * In this case, continue movement because we can't stop!
				 */
				if (
					(abs(yTarg - tyTarg) < pMovementSize) &&
					(abs(xTarg - txTarg) < 1) &&
					(g_itmPos[i].l == pos.l) &&
					bStartingMove)
				{
					coordMatch = true;
				}

			}
			else
			{

				/*
				 * Pixel movement.
				 * Only check this at the start of a move.
				 */
				if (bStartingMove)
				{

					// Current locations: minimum separations. Probably don't even need these.
					if (
						(abs(tPosY - posY) < pMovementSize) &&
						(abs(tPosX - posX) < 1) &&
						(g_itmPos[i].l == pos.l))
					{
						coordMatch = true;
					}

					// Target against item current location.
					if (
						(abs(tPosY - yTarg) < pMovementSize) &&
						(abs(tPosX - xTarg) < 1) &&
						(g_itmPos[i].l == pos.l))
					{
						coordMatch = true;
					}

					// Target against item target location.
					if (
						(abs(yTarg - tyTarg) < pMovementSize) &&
						(abs(xTarg - txTarg) < 1) &&
						(g_itmPos[i].l == pos.l))
					{
						coordMatch = true;
					}

				} // startingMove.

			} // usingPixelMovement.

			if (coordMatch)
			{

				// There's an item here, but is it active?
				if (g_activeBoard.itmActivate[i])
				{

					// Conditional activation
					/** variableType = getIndependentVariable(g_activeBoard.itmVarActivate[i], paras.lit, paras.num);

					if (variableType == DT_NUM)
					{
						// It's a numerical variable
						if (paras.num == atof(g_activeBoard.itmActivateInitNum[i]))
						{
							return SOLID;
						}
					}
					else if (variableType == DT_LIT)
					{
						// It's a literal variable
						if (paras.lit == g_activeBoard.itmActivateInitNum[i])
						{
							return SOLID;
						}
					} **/

				}
				else
				{

					// Not conditionally activated - permanently active.
					return SOLID;

				}

			} // coordMatch

		}

	}

	// We've got here, so no match has been found.
	return NORMAL;

}
