/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006 - 2007  Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

/*
 * CPathFind - A* Pathfinding for vector collision.
 */

/*
 * Known issues:
 *	Goals contained in multiple vectors not considered.
 *  Artibrary tile grid size requires adjustments to coords namespace.
 */

#include "CPathFind.h"
#include "../CSprite/CSprite.h"
#include "../../common/board.h"
#include "../../../tkCommon/board/coords.h"
#include "../../common/mainfile.h"
#include <math.h>

/*
 * Defines
 */
const int PF_MAX_STEPS = 1000;		// Maximum number of steps in a path.
const int PF_GRID_SIZE = 32;		// Grid size for non-vector movement (= 32 for tile movement).
									// NOTE: if this is changed, coords namespace needs updating
									// to accept an arbitrary grid size.
const int PF_HALF_SIZE = PF_GRID_SIZE / 2;
const double PF_TILE_RATIO = 32.0 / PF_GRID_SIZE;

int CPathFind::m_isIso = 0;			// g_pBoard->isIsometric().
CTilePathFind::PF_TILE_MAP CTilePathFind::m_boardPoints;
CTilePathFind::PF_SWEEP_MAP CTilePathFind::m_sweeps;
CVectorPathFind::PF_VECTOR_MAP CVectorPathFind::m_boardVectors;

/*
 * Find the node with the lowest f-value.
 */
NV_ITR CPathFind::bestOpenNode(void)
{
	NV_ITR best = m_openNodes.begin();
	for (NV_ITR i = m_openNodes.begin(); i != m_openNodes.end(); ++i)
	{
		if (i->fValue() < best->fValue()) best = i;
	}
	return best;
}

/*
 * Construct an equivalent directional (MV_ENUM) path.
 */
std::vector<MV_ENUM> CPathFind::directionalPath(void)
{
	std::vector<MV_ENUM> path;
	NODE node = m_closedNodes.back();

	if (node.pos == m_goal.pos)
	{
		while(node.pos != m_start.pos)
		{
			path.push_back(node.direction);
			node = *(m_closedNodes.begin() + node.parent);
		}
	}
	return path;
}

/*
 * Free static members of derived classes.
 * This should be the only function to call freeStatics(), because
 * freePath() *must* be called on all sprites before it can be
 * called - otherwise sprite pathfinds will have dangling pointers.
 */
void CPathFind::freeAllData(void)
{
	extern ZO_VECTOR g_sprites;
	for (std::vector<CSprite *>::iterator i = g_sprites.v.begin(); i != g_sprites.v.end(); ++i)
	{
		(*i)->freePath();
	}
	CTilePathFind::freeStatics();
	CVectorPathFind::freeStatics();
	// And any other derived classes with static members.
}

/*
 * Entry point - static function.
 */
PF_PATH CPathFind::pathFind(
	CPathFind **ppPf,
	const DB_POINT start, 
	const DB_POINT goal,
	const int layer, 
	const int mode,				// Pathfinding mode.
	const CSprite *pSprite,		// Pointer to the calling sprite.
	const int flags)
{
	PF_HEURISTIC heuristic = PF_HEURISTIC(mode);
	CPathFind *p = *ppPf;

	if (!p && heuristic == PF_PREVIOUS)
	{
		// No previous algorithm to use - use default.
		extern MAIN_FILE g_mainFile;
		heuristic = PF_HEURISTIC(g_mainFile.pfHeuristic);
	}

	// Use the current derivative if already exists.
	if (!p || (heuristic != p->m_heuristic && heuristic != PF_PREVIOUS))
	{
		// Load a new derivative.
		delete p;
		switch (heuristic)
		{
			case PF_DIAGONAL:
			case PF_AXIAL:
			{
				p = new CTilePathFind();
				break;
			}
			case PF_VECTOR:
			{
				p = new CVectorPathFind();
				break;
			}
		}
		p->m_heuristic = heuristic;
	}
	*ppPf = p;
	if (!p->reset(start, goal, layer, pSprite, flags)) return PF_PATH();
	return p->pathFind(pSprite);
}

/*
 * Main function - apply the algorithm to the input points.
 */
PF_PATH CPathFind::pathFind(const CSprite *pSprite)
{
	// Quit if the reset fails or the goal is the start point.
	if (m_start.pos == m_goal.pos) return PF_PATH();

	// Distance estimate for start node.
	m_start.dist = distance(m_start, m_goal);
	m_steps = 0;

	m_openNodes.clear();
	m_closedNodes.clear();
	m_openNodes.push_back(m_start);

	while (!m_openNodes.empty())
	{
		// Explore all open nodes until there are none left.
		++m_steps;

		// Remove the best open node and add it to the closed nodes.
		NV_ITR parentItr = bestOpenNode();
		m_closedNodes.push_back(*parentItr);
		m_openNodes.erase(parentItr);
		
		NODE *parent = &m_closedNodes.back();

		// Check if the goal has been reached.
		if (parent->pos == m_goal.pos || m_steps > PF_MAX_STEPS) break;

		// Find child nodes.
		NODE child;
		while (getChild(child, *parent))
		{
			// Check if this node has been encountered as a child of another
			// node, and if so whether it this new route is more efficient.

			if (!isChild(child, *parent)) continue;

			// Assign total cost of moving from the start to this node
			// *via this parent*, and the straight-line estimate to the goal (heuristic).
			child.cost = parent->cost + distance(*parent, child);
			child.dist = distance(child, m_goal);

			// m_closedNodes and parent are both constant in this while().
			child.parent = parent - &*m_closedNodes.begin();

			// Check if the node has been closed via a different route,
			// and if so, whether this is a more efficient route.
			NV_ITR k = m_closedNodes.begin();
			for (; k != m_closedNodes.end(); ++k)
			{
				if (k->pos == child.pos)
				{
					if(k->cost > child.cost)
					{
						// Replace the closed node.
						*k = child;
					}
					break;
				}
			}
			// If the child was closed, nothing else needs doing.
			if (k != m_closedNodes.end()) continue;
	
			// Check if the node has been opened via a different route,
			// and if so, whether this is a more efficient route.
			for (k = m_openNodes.begin(); k != m_openNodes.end(); ++k)
			{
				if (k->pos == child.pos)
				{
					if (k->fValue() > child.fValue())
					{
						// Replace the opened node. 
						*k = child;
					}
					break;
				}
			}
			if (k != m_openNodes.end()) continue;

			// If child is not open or closed, open it.
			m_openNodes.push_back(child);

		} // for (all points)

	} // while (!open.empty())

	if (m_closedNodes.back().pos == m_goal.pos)
	{
		// Construct the path.
		return constructPath(m_closedNodes.back(), pSprite);
	}
	return PF_PATH();
		
}

/*
 ********************************************************************
 * CTilePathFind
 ********************************************************************
 */

/*
 * Add a vector to the collision matrix.
 */
void CTilePathFind::addVector(CVector &vector, PF_SWEEPS &sweeps, PF_MATRIX &points)
{
	extern LPBOARD g_pBoard;

	// Tile pathfinding works in cartesian and rotated coordinate systems.
	// The actual tile coordinate system is irrelevant.
	COORD_TYPE coord = m_isIso ? ISO_ROTATED : TILE_NORMAL;

	// Convert bounds to grid point coordinates and determine if
	// each grid point is in the vector.
	RECT b = vector.getBounds();

	// Expand the area that is checked.
	const POINT size = {
		long(g_directions[m_isIso][MV_E][0]) * PF_GRID_SIZE, 
		long(g_directions[m_isIso][MV_S][1]) * PF_GRID_SIZE
	};
	b.left -= size.x; b.right += size.x;
	b.top -= size.y; b.bottom += size.y;

	// Round to sprite positions (pixel points corresponding
	// to matrix elements).
	coords::roundToTile(b.left, b.top, m_isIso, true);
	coords::roundToTile(b.right, b.bottom, m_isIso, true);

	// Allow negative points - since b.left/top will never be < 0,
	// the expanded area will always be within the matrix range (i.e. 0, 0)
	// If the size of the expansion ('size') changes, this may need reconsidering.
	// if (b.left < 0) b.left = 0;
	// if (b.top < 0) b.top = 0;
	if (b.right > g_pBoard->pxWidth()) b.right = g_pBoard->pxWidth();
	if (b.bottom > g_pBoard->pxHeight()) b.bottom = g_pBoard->pxHeight();

	DB_POINT unused = {0.0};
	int dy = 0;
	for (int x = b.left; x <= b.right; x += 32)
	{
		for (int y = b.top + dy; y <= b.bottom; y += 32)
		{
			// Determine if the neighbouring points can be reached from this point
			// for this sprite.
			const DB_POINT pt = {double(x), double(y)};

			int i = x, j = y;
			coords::pixelToTile(i, j, coord, false, g_pBoard->sizeX);

			for (MV_ENUM k = MV_E; k != MV_W; ++k)
			{
				CPfVector &v = sweeps[k].first;
				v += pt;
									
				if (vector.contains(v, unused))
				{
					// Block the movement from ij in the k direction.
					// The kth bit of points[i][j] corresponds to 
					// movement(0) or block(1) in that direction.
					points[i][j] |= 1 << (k - 1);

					// Block movement in the opposite direction.
					// Obtain the tile coordinate of the target tile.
					const DB_POINT target = sweeps[k].second;
					int m = pt.x + target.x, n = pt.y + target.y;
					coords::pixelToTile(m, n, coord, false, g_pBoard->sizeX);

					if (m >= 0 && m < points.size() && n >= 0 && n < points[0].size())
					{
						points[m][n] |= 1 << (k - 1 + 4);
					}
				}
				v -= pt;

			} // for (MV_ENUM)
		} // for (y)
		// Ensure isometric columns are vertically offset correctly.
		if (m_isIso) dy = abs(dy - 16);
	} // for (x)
}

/*
 * Make the path by tracing parents through m_closedNodes.
 */
PF_PATH CTilePathFind::constructPath(NODE node, const CSprite *) const
{
	PF_PATH path;

	while(node.pos != m_start.pos)
	{
		path.push_back(node.pos);

		NODE nextNode(node);
		do
		{
			nextNode = *(m_closedNodes.begin() + nextNode.parent);
		} 
		while (nextNode.direction == node.direction);
		
		node = nextNode;
	}
	if (m_movedStart)
	{
		path.push_back(m_start.pos);
	}
	return path;
}

/*
 * Estimate the straight-line distance between nodes, depending
 * on the movement style and adding any modifiers.
 */
int CTilePathFind::distance(const NODE &a, const NODE &b) const
{
	const int dx = abs(a.pos.x - b.pos.x), dy = abs(a.pos.y - b.pos.y);
	int di = 0;

	switch(m_heuristic)
	{
		case PF_AXIAL:
			return (dx + dy);
		case PF_DIAGONAL:
			// Diagonals cost sqrt(2):
			di = (dx < dy ? dx : dy);
			return (1.41 * di + (dx + dy - 2 * di));
	}
	return 0;
}

/*
 * Get the next potential child of a node.
 */
bool CTilePathFind::getChild(NODE &child, NODE &parent)
{
	extern const double g_directions[2][9][2];

	if (m_nextDir > MV_NE)
	{
		m_nextDir = (m_heuristic == PF_AXIAL && m_isIso ? MV_SE : MV_E);
		return false;
	}
	DB_POINT pt = parent.pos;
	if (pt == m_start.pos)
	{
		// Cater for non-aligned starts.
		coords::roundToTile(pt.x, pt.y, m_isIso, true);
	}
	child.pos.x = g_directions[m_isIso][m_nextDir][0] * PF_GRID_SIZE + pt.x;
	child.pos.y = g_directions[m_isIso][m_nextDir][1] * PF_GRID_SIZE + pt.y;
	child.direction = MV_ENUM(m_nextDir);

	// Limit neighbours depending on allowed directions.
	m_nextDir += (m_heuristic == PF_AXIAL ? 2 : 1);

	return true;
}

/*
 * Tile pathfinding: re-initialise the search.
 * Tile pf: create a matrix of valid nodes by generating grown
 * collision vectors and testing each point (does not include sprites).
 * Remember the nodes are matrix coordinates, not collision vector points.
 */
void CTilePathFind::initialize(const CSprite *pSprite)
{
	extern LPBOARD g_pBoard;

	CVector cvBase = pSprite->getVectorBase(false);
	CPfVector cpfvBase = CPfVector(cvBase, m_layer);

	// Check to see if a board matrix has already been defined for this
	// particular sprite vector base shape *on this particular layer*
	// - the PF_MATRIX in m_boardPoints is layer-specific, so the key
	// (the CPfVector) must be also.
	PF_TILE_MAP::iterator i = m_boardPoints.find(cpfvBase);
	if (i != m_boardPoints.end())
	{
		// Tracking users will prove too complicated and isn't important
		// if the static data are cleared when the board changes.
		m_pBoardPoints = &i->second;

		// m_sweeps does not need to be indexed by layer since it only
		// contains templates, hence is mapped to a CVector.
		// If m_boardPoints[cpfv] exists, then m_sweeps[cv] will also
		// exist, since they are both created below.
		m_pSweeps = &m_sweeps[cvBase];
		return;
	}

	// Create a set of 4 swept vectors that cover the 8 directions
	// of movement for this sprite's base. Store a swept vector and
	// the sweep target in a pair.
	PF_SWEEPS sweeps;

	const DB_POINT zero = {0.0};
	for (MV_ENUM j = MV_E; j != MV_W; ++j)
	{
		// g_directions[isIsometric()][MV_CODE][x OR y].
		const DB_POINT pt = {
			g_directions[m_isIso][j][0] * PF_GRID_SIZE, 
			g_directions[m_isIso][j][1] * PF_GRID_SIZE
		};

		sweeps[j].first = cpfvBase;
		sweeps[j].first.merge(cpfvBase.sweep(zero, pt));
		// Also include base at target location.
		sweeps[j].first.merge(cpfvBase + pt);
		sweeps[j].second = pt;
	}

	// Insert the sweeps into the static map for this unique sprite base.
	// Remember that the sweep key is a CVector.
	m_sweeps[cvBase] = sweeps;
	m_pSweeps = &m_sweeps[cvBase];

	// Set up the coordinate matrix (match true (effective) size of tile array).
	PF_MATRIX points;
	sizeMatrix(points);

	for (std::vector<BRD_VECTOR>::iterator k = g_pBoard->vectors.begin(); k != g_pBoard->vectors.end(); ++k)
	{
		if (k->layer != m_layer || k->type & ~TT_SOLID) continue;
		addVector(*(k->pV), sweeps, points);
	}

	// Insert the matrix into the static map to allow other identical
	// sprites to use it. Tracking users will prove too complicated and
	// isn't important if the static data are cleared when the board changes.
	m_boardPoints[cpfvBase] = points;
	m_pBoardPoints = &m_boardPoints[cpfvBase];
}

/*
 * Determine if a node can be directly reached from another node
 */
bool CTilePathFind::isChild(const NODE &child, const NODE &parent) const
{
	extern LPBOARD g_pBoard;

	if (child.pos == parent.pos) return false;

	if (child.pos.x < 0 || child.pos.x > g_pBoard->pxWidth() || child.pos.y < 0 || child.pos.y > g_pBoard->pxHeight()) return false;

	int i = int(parent.pos.x), j = int(parent.pos.y);
	coords::pixelToTile(i, j, m_isIso ? ISO_ROTATED : TILE_NORMAL, false, g_pBoard->sizeX);

	PF_MATRIX &pts = *m_pBoardPoints;
	if (i < pts.size() && j < pts[0].size())
	{
		const PF_MATRIX_ELEMENT dir = 1 << (child.direction - 1);
		if ((pts[i][j] & dir) || (m_spritePoints[i][j] & dir)) return false;
	}
	return true;
}

/*
 * Reset the points at the start of a search.
 */
bool CTilePathFind::reset(
	DB_POINT start, 
	DB_POINT goal, 
	const int layer,
	const CSprite *pSprite,
	const int flags)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	// Recreate collision data if changing layers / absent.
	if (layer != m_layer || !m_pBoardPoints) 
	{
		m_isIso = int(g_pBoard->isIsometric());
		m_layer = layer;
		initialize(pSprite);
	}

	const CVector base = pSprite->getVectorBase(false);
	CVector cvGoal = base + goal, cvStart = base + start;
	DB_POINT unused = {0.0};

	// Start must be aligned to grid.
	DB_POINT newStart = start;
	coords::roundToTile(newStart.x, newStart.y, m_isIso, true);
	m_movedStart = false;
	bool movedGoal = false;

	std::vector<PF_SWEEP_PAIR> ss;
	std::vector<bool> ssIndex;

	if (newStart != start)
	{
		m_movedStart = true;

		// Sweep a set to the four nearest grid points. Begin by
		// finding the nearest point in the direction of the goal.
		DB_POINT d = goal - start, grid = start;
		MV_ENUM mv;
		if (m_isIso)
		{
			if (fabs(d.x) > fabs(d.y))
			{
				grid.x += sgn(d.x) * PF_GRID_SIZE;
				mv = d.x > 0 ? MV_NW : MV_NE;
			}
			else
			{
				grid.y += sgn(d.y) * PF_HALF_SIZE;
				mv = d.y > 0 ? MV_NE : MV_SE;
			}
		}
		else
		{
			if (d.y > 0)
			{
				grid.x += sgn(d.x) * PF_HALF_SIZE;
				mv = MV_N;
			}
			else
			{
				grid.x += sgn(d.x) * PF_HALF_SIZE;
				grid.y -= PF_GRID_SIZE;
				mv = MV_S;
			}
		}
		coords::roundToTile(grid.x, grid.y, m_isIso, true);
		
		CPfVector cpfvStart = CPfVector(cvStart);
		for (int i = 0; i != 4; ++i, mv += 2)
		{
			ss.push_back(PF_SWEEP_PAIR(cpfvStart.sweep(start, grid), grid));
			const DB_POINT next = {
				g_directions[m_isIso][mv][0] * PF_GRID_SIZE, 
				g_directions[m_isIso][mv][1] * PF_GRID_SIZE
			};
			grid = grid + next;
		}
		ssIndex.assign(ss.size(), true);
	}		

	// Add sprite base collision data.
	sizeMatrix(m_spritePoints);
	for (ZO_ITR i = g_sprites.v.begin(); i != g_sprites.v.end(); ++i)
	{
		const SPRITE_POSITION pos = (*i)->getPosition();
		if (*i == pSprite || pos.l != m_layer) continue;

		const DB_POINT pt = {pos.x, pos.y};
		CVector spriteVector = (*i)->getVectorBase(false) + pt;

		if (m_movedStart)
		{
			// Need to move start to grid point, but need gridpoint that
			// is reachable.
			for (std::vector<PF_SWEEP_PAIR>::iterator j = ss.begin(); j != ss.end(); ++j)
			{
				if (spriteVector.contains(j->first, unused))
				{
					// Cannot use this direction.
					ssIndex[j - ss.begin()] = false;
				}
			}
		}

		// If a sprite is at the goal and we do not want to bypass it
		// (i.e., we want to intercept it), then do not add it's vector
		// and the path will reach the requested goal.
		if (spriteVector.contains(cvGoal, unused))
		{
			if (flags & PF_QUIT_BLOCKED)
			{
				return false;
			}
			else if (flags & PF_AVOID_SPRITE)
			{
				goal = CPfVector(spriteVector).nearestPoint(goal);
				addVector(spriteVector, *m_pSweeps, m_spritePoints);
				movedGoal = true;
			}
			// else, ignore and this will walk into (intercept) the sprite.
		}
		else
		{
			// Ignore sprite bases at the start (only a problem for
			// PathFind(), since this rpgcode function is not linked
			// to a sprite base).
			if (!spriteVector.contains(cvStart, unused))
			{
				addVector(spriteVector, *m_pSweeps, m_spritePoints);
			}
		}
	} // for (sprite vectors).

	// Process the results of the moved start.
	if (m_movedStart)
	{
		// Find the first non-false entry in ssIndex - use corresponding ss entry.
		std::vector<bool>::iterator j = ssIndex.begin();
		for (; j != ssIndex.end(); ++j)
		{
			if (*j) break;
		}
		
		// Unable to move to nearby grid point - quit.
		if (j == ssIndex.end()) return false;

		start = ss[j - ssIndex.begin()].second;
	}

	// Round (potentially new) goal to tile and check for board vectors.
	coords::roundToTile(goal.x, goal.y, m_isIso, true);
	cvGoal = base + goal;

	// Check for goal contained in board vectors. Select the nearest 
	// edge point. Determine the closest reachable grid point 
	// separately (see below).
	for (std::vector<BRD_VECTOR>::iterator j = g_pBoard->vectors.begin(); j != g_pBoard->vectors.end(); ++j)
	{
		if (j->layer != m_layer || j->type & ~TT_SOLID) continue;

		CVector &boardVector = *(j->pV);
		if (boardVector.contains(cvGoal, unused))
		{
			// If the goal is blocked and a nearby point is not allowed, quit.
			if (flags & PF_QUIT_BLOCKED) return false;

			const CPfVector pfv = CPfVector(boardVector);
			goal = pfv.nearestPoint(goal);
			movedGoal = true;
			// Consider goals contained in multiple vectors!
		}
		/* Need to consider if moving the start will prevent the
		   sprite starting, and whether not moving the start will do
		   the same (in the case that the start is not the sprite's position).
		if (j->pV->contains(cvStart, unused))
		{
			const CPfVector pfv = CPfVector(*(j->pV));
			start = pfv.nearestPoint(start);
			// Consider starts contained in multiple vectors!
		}
		*/
	}

	if (movedGoal)
	{
		// Find the first reachable grid point to the goal.
		coords::roundToTile(goal.x, goal.y, m_isIso, true);

		// Switch the heuristic to check all children of the goal.
		const PF_HEURISTIC heur = m_heuristic;
		m_heuristic = PF_DIAGONAL;
		m_nextDir = MV_E;

		// Temporarily set m_goal, but overwrite if first is blocked.
		m_goal = NODE(goal);
		NODE target(goal);

		PF_MATRIX &pts = *m_pBoardPoints;
		const PF_MATRIX_ELEMENT blocked = 255;
		
		while (true)
		{
			if (target.pos.x >= 0 && target.pos.x <= g_pBoard->pxWidth() || target.pos.y >= 0 && target.pos.y <= g_pBoard->pxHeight())
			{
				int x = int(target.pos.x), y = int(target.pos.y);
				coords::pixelToTile(x, y, m_isIso ? ISO_ROTATED : TILE_NORMAL, false, g_pBoard->sizeX);

				if (x < pts.size() && y < pts[0].size())
				{
					if (pts[x][y] != blocked && m_spritePoints[x][y] != blocked) 
					{
						goal = target.pos;
						break;
					}
				}
			}

			if (flags & PF_QUIT_BLOCKED) return false;

			// If the target isn't clear try the children of the goal
			// until all surrounding tiles are checked.
			if (!getChild(target, m_goal))
			{
				// Signal to quit the alogrithm since we can't reach the goal.
				return false;
			}
		}
		m_heuristic = heur;
	} // if (goal was moved)

	// Limit neighbours depending on allowed directions.
	m_nextDir = (m_heuristic == PF_AXIAL && m_isIso ? MV_SE : MV_E);

	m_goal = NODE(goal);
	m_start = NODE(start);

	return true;
}

/*
 * Set the size of a tile matrix (sprite or board).
 */
void CTilePathFind::sizeMatrix(PF_MATRIX &points)
{
	extern LPBOARD g_pBoard;
	points.clear();
	const int width = g_pBoard->effectiveWidth() * PF_TILE_RATIO, height = g_pBoard->effectiveHeight() * PF_TILE_RATIO;
	for (int i = 0; i <= width; ++i)
	{
		points.push_back(std::vector<PF_MATRIX_ELEMENT>(height + 1, 0));
	}
}

/*
 ********************************************************************
 * CVectorPathFind
 ********************************************************************
 */

/*
 * Make the path by tracing parents through m_closedNodes.
 */
PF_PATH CVectorPathFind::constructPath(NODE node, const CSprite *pSprite) const
{
	PF_PATH path;

	while(node.pos != m_start.pos)
	{
		path.push_back(node.pos);
		node = *(m_closedNodes.begin() + node.parent);
	}
	if (m_movedStart)
	{
		path.push_back(m_start.pos);
	}
	return path;
}

/*
 * Estimate the straight-line distance between nodes, depending
 * on the movement style and adding any modifiers.
 */
int CVectorPathFind::distance(const NODE &a, const NODE &b) const
{
	const int dx = abs(a.pos.x - b.pos.x), dy = abs(a.pos.y - b.pos.y);
	return sqrt(static_cast<DOUBLE>(dx * dx + dy * dy));
}

/*
 * Release allocated memory.
 */
void CVectorPathFind::freeData(void) 
{ 
	m_pBoardVectors = NULL; 
	for (PF_VECTOR_OBS::iterator i = m_spriteVectors.begin(); i != m_spriteVectors.end(); ++i)
	{
		delete *i;
	}
	m_spriteVectors.clear();
}
void CVectorPathFind::freeStatics(void)
{
	for (PF_VECTOR_MAP::iterator i = m_boardVectors.begin(); i != m_boardVectors.end(); ++i)
	{
		for (PF_VECTOR_OBS::iterator j = i->second.begin(); j != i->second.end(); ++j)
		{
			delete *j;
		}
	}
	m_boardVectors.clear();
}

/*
 * Get the next potential child of a node.
 */
bool CVectorPathFind::getChild(NODE &child, NODE &parent)
{
	if (m_nextPoint == m_points.end())
	{
		m_nextPoint = m_points.begin();
		return false;
	}
	child.pos = *m_nextPoint;
	++m_nextPoint;
	return true;
}

/*
 * Re-initialise the search.
 */
void CVectorPathFind::initialize(const CSprite *pSprite)
{
	extern LPBOARD g_pBoard;

	CVector cvBase = pSprite->getVectorBase(false);
	CPfVector cpfvBase = CPfVector(cvBase, m_layer);

	// Grow collision vectors by longest diagonal of sprite base.
	const RECT r = cvBase.getBounds();
	const int x = abs(r.left) > abs(r.right) ? r.left : r.right;
	const int y = abs(r.top) > abs(r.bottom) ? r.top : r.bottom;
	m_growSize = x > y ? x : y; //sqrt(x * x + y * y);

	// Check to see if a group of grown board collision vectors 
	// has already been defined for this particular sprite vector base 
	// shape *on this particular layer* - as the vectors are 
	// layer-specific, so the key (the CPfVector) must be also.
	PF_VECTOR_MAP::iterator i = m_boardVectors.find(cpfvBase);
	if (i != m_boardVectors.end())
	{
		// Tracking users will prove too complicated and isn't important
		// if the static data are cleared when the board changes.
		m_pBoardVectors = &i->second;
		return;
	}

	// Construct a group of grown collision vectors.
	PF_VECTOR_OBS obs;
	obs.reserve(g_pBoard->vectors.size());

	for (std::vector<BRD_VECTOR>::iterator j = g_pBoard->vectors.begin(); j != g_pBoard->vectors.end(); ++j)
	{
		if (j->layer != m_layer || j->type & ~TT_SOLID) continue;

		// The board vectors have to be "grown" to make sure the sprites
		// can move around them without colliding.
		CPfVector *pVector = new CPfVector(*(j->pV));
		pVector->grow(m_growSize);
		obs.push_back(pVector);
	}

	// Insert the vector into the static map to allow other identical
	// sprites to use it. Tracking users will prove too complicated and
	// isn't important if the static data are cleared when the board changes.
	m_boardVectors[cpfvBase] = obs;
	m_pBoardVectors = &m_boardVectors[cpfvBase];	
}

/*
 * Determine if a node can be directly reached from another node
 * i.e. is there an unobstructed line between the two?
 */
bool CVectorPathFind::isChild(const NODE &child, const NODE &parent) const
{
	if (child.pos == parent.pos) return false;

	CPfVector v(parent.pos);
	v.push_back(child.pos);
	v.close(false);

	// Check for board collisions along the path.
	for (PF_VECTOR_OBS::const_iterator i = m_pBoardVectors->begin(); i != m_pBoardVectors->end(); ++i)
	{
		if ((*i) && (*i)->contains(v)) return false;		
	}
	// Check for sprite collisions.
	for (PF_VECTOR_OBS::const_iterator i = m_spriteVectors.begin(); i != m_spriteVectors.end(); ++i)
	{
		if ((*i) && (*i)->contains(v)) return false;		
	}	

	return true;
}

/*
 * Reset the points at the start of a search.
 */
bool CVectorPathFind::reset(
	DB_POINT start, 
	DB_POINT goal, 
	const int layer,
	const CSprite *pSprite,
	const int flags)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	// Recreate collision data if changing layers / absent.
	if (layer != m_layer || !m_pBoardVectors) 
	{
		m_isIso = int(g_pBoard->isIsometric());
		m_layer = layer;
		initialize(pSprite);
	}

	const DB_POINT limits = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};

	// Pushback two empty points to act as the first goal and start. Do this first!
	m_points.clear();
	m_points.push_back(DB_POINT());
	m_points.push_back(DB_POINT());
	m_movedStart = false;
	
	// Check if the goal is contained in a solid area.
	// If so, set the goal to be the closest edge point.
	for (PF_VECTOR_OBS::iterator i = m_pBoardVectors->begin(); i != m_pBoardVectors->end(); ++i)
	{
		CPfVector &boardVector = **i;
		boardVector.createNodes(m_points, limits);					
		
		// If the goal is allowed in a sprite base skip because 
		// we have already checked this in the previous loop.
		if (boardVector.containsPoint(goal))
		{
			// If the goal is blocked and a nearby point is not allowed, quit.
			if (flags & PF_QUIT_BLOCKED) return false;

			goal = boardVector.nearestPoint(goal);
			// Consider goals contained in multiple vectors!
		}
		if (boardVector.containsPoint(start))
		{
			const DB_POINT result = boardVector.nearestPoint(start);
			if (result != start)
			{
				start = result;
				m_movedStart = true;
			}
			// Consider starts contained in multiple vectors!
		}
	}

	// Generate sprite bases each time, since sprites will have moved.
	for (PF_VECTOR_OBS::iterator i = m_spriteVectors.begin(); i != m_spriteVectors.end(); ++i)
	{
		delete *i;
	}
	m_spriteVectors.clear();

	for (std::vector<CSprite *>::iterator j = g_sprites.v.begin(); j != g_sprites.v.end(); ++j)
	{
		const SPRITE_POSITION pos = (*j)->getPosition();
		if (*j == pSprite || pos.l != m_layer) continue;

		// tbd: speed up by saving old pfvectors (associate each with its base vector).
		const DB_POINT pt = {pos.x, pos.y};
		CPfVector *spriteVector = new CPfVector((*j)->getVectorBase(false) + pt);

		// Extra clearance for sprites.
		spriteVector->grow(m_growSize + 4);

		// If a sprite is at the goal and we do not want to bypass it
		// (i.e., we want to meet it), then do not add it's vector
		// and the path will reach the requested goal.
		// Only requires a containsPoint(), not a full contains(),
		// because the vectors have been grown.
		if (spriteVector->containsPoint(start))
		{
			// Use projectedPoint() for sprite vectors because
			// nearestPoint() may return an unreachable point.
			const DB_POINT result = spriteVector->projectedPoint(pt, start);
			if (result != start)
			{
				start = result;
				m_movedStart = true;
			}
		}

		if (spriteVector->containsPoint(goal))
		{
			if (flags & PF_QUIT_BLOCKED)
			{
				delete spriteVector;
				return false;
			}
			else if (flags & PF_AVOID_SPRITE)
			{
				// Move the goal because an interception is not wanted.
				goal = spriteVector->nearestPoint(goal);
			}
			else
			{
				// Delete so that this walks into (intercepts) the sprite.
				delete spriteVector;
				continue;
			}
		}
		spriteVector->createNodes(m_points, limits);					
		m_spriteVectors.push_back(spriteVector);
	}

	// Insert the start and goal at the front of the vector (two spaces
	// reserved above).
	*m_points.begin() = start;
	*(m_points.begin() + 1) = goal;
	m_nextPoint = m_points.begin();

	m_goal = NODE(goal);
	m_start = NODE(start);

	return true;
}
