/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CPathFind - A* Pathfinding for vector collision.
 */

/*
 * TBD:
 *		CENTRE SPRITE BASES IN 2D MODE.
 *		Goals in multiple vectors.
 */

#include "CPathFind.h"
#include "../CSprite/CSprite.h"
#include "../../common/board.h"
#include "../../../tkCommon/board/coords.h"
#include "../../common/mainfile.h"

/*
 * Defines
 */
const int PF_MAX_STEPS = 1000;		// Maximum number of steps in a path.
const int PF_GRID_SIZE = 32;		// Grid size for non-vector movement (= 32 for tile movement).
const DB_POINT SEPARATOR = {-1, -1};// Invalid point to separate board and sprites in m_points.


/*
 * Default constructor.
 */
CPathFind::CPathFind():
m_heuristic(PF_AXIAL),
m_goal(),
m_layer(0),
m_start(),
m_steps(0)
{
	// Insufficient information is available when CSprite is constructed
	// to be able to do anything here.
	extern MAIN_FILE g_mainFile;
	m_heuristic = PF_HEURISTIC(g_mainFile.pfHeuristic);
	m_u.v = NULL;
}

/*
 * Find the node with the lowest f-value.
 */
NODE *CPathFind::bestOpenNode(void)
{
	NODE *best = m_openNodes.begin();
	for (NV_ITR i = m_openNodes.begin(); i != m_openNodes.end(); ++i)
	{
		if (i->fValue() < best->fValue()) best = i;
	}
	return best;
}

/*
 * Make the path by tracing parents through m_closedNodes.
 */
PF_PATH CPathFind::constructPath(NODE node, const RECT &r)
{
	extern LPBOARD g_pBoard;

	int dx = 0, dy = 0;
	PF_PATH path;

	// Modify the points for any offsets.
	if (!g_pBoard->isIsometric())
	{
		// Shift points down the board by half
		// the base height or to the tile edge.
//		dx = (m_heuristic == PF_VECTOR ? (r.right - r.left) / 2 : 0);
		dy = (m_heuristic == PF_VECTOR ? (r.bottom - r.top) / 2 : 0);
	}

	if (m_heuristic == PF_VECTOR)
	{
		// Pushback the goal without modification.
		path.push_back(node.pos);
		node = *(m_closedNodes.begin() + node.parent);
	}

	// tbd: merge points on a straight line for non-vector movement.

	while(node.pos != m_start.pos)
	{
		node.pos.x += dx;
		node.pos.y += dy;
		path.push_back(node.pos);
		node = *(m_closedNodes.begin() + node.parent);
	}
	return path;
}

/*
 * Construct an equivalent directional path.
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
 * Estimate the straight-line distance between nodes, depending
 * on the movement style and adding any modifiers.
 */
int CPathFind::distance(NODE &a, NODE &b)
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
		case PF_VECTOR:
			return sqrt(dx * dx + dy * dy);
	}
	return 0;
}

/*
 * Get the next potential child of a node.
 */
bool CPathFind::getChild(DB_POINT &child, DB_POINT parent)
{
	extern const double g_directions[2][9][2];
	extern LPBOARD g_pBoard;

	if (m_heuristic == PF_VECTOR)
	{
		if (m_u.v == m_points.end())
		{
			m_u.v = m_points.begin();
			return false;
		}
		if (*m_u.v == SEPARATOR)
		{
			if (++m_u.v == m_points.end())
			{
				m_u.v = m_points.begin();
				return false;
			}
		}
		child = *m_u.v;
		++m_u.v;
	}
	else
	{
		const int isIso = int(g_pBoard->isIsometric());
		if (m_u.i > MV_NE)
		{
			m_u.i = (m_heuristic == PF_AXIAL && isIso ? MV_SE : MV_E);
			return false;
		}
		if (parent == m_start.pos)
		{
			// Cater for non-aligned starts.
			coords::roundToTile(parent.x, parent.y, isIso, true);
		}
		child.x = g_directions[isIso][m_u.i][0] * PF_GRID_SIZE + parent.x;
		child.y = g_directions[isIso][m_u.i][1] * PF_GRID_SIZE + parent.y;

		// Limit neighbours depending on allowed directions.
		m_u.i += (m_heuristic == PF_AXIAL ? 2 : 1);
	}
	return true;
}

/*
 * Re-initialise the search.
 */
void CPathFind::initialize(const int layer, const RECT &r, const PF_HEURISTIC type)
{
	extern LPBOARD g_pBoard;

	m_layer = layer;
	m_heuristic = type;

	m_points.clear();
	freeVectors();					// m_obstructions.

	if (m_heuristic != PF_VECTOR)
	{
		// Pushback a NULL to create a single entry that prevents
		// initialisation each run in tile mode, but is otherwise unused.
		m_obstructions.push_back(NULL);
		// Nothing else to do for tile pathfinding.
		return;
	}

	const DB_POINT limits = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};

	// Grow by longest diagonal.
	const int x = abs(r.left) > abs(r.right) ? r.left : r.right,
			  y = abs(r.top) > abs(r.bottom) ? r.top : r.bottom;
	const int size = x > y ? x : y; //sqrt(x * x + y * y);

	// Pushback two empty points to act as the first goal and start. Do this first!
	m_points.push_back(DB_POINT());
	m_points.push_back(DB_POINT());

	// Add collidable nodes from the board.
	for (std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
	{
		if (i->layer != m_layer || i->type & ~TT_SOLID) continue;

		// The board vectors have to be "grown" to make sure the sprites
		// can move around them without colliding.
		CPfVector *vector = new CPfVector(*(i->pV));
		vector->grow(size);

		m_obstructions.push_back(vector);
		vector->createNodes(m_points, limits);					
	}
	// Pushback a NULL pointer to separate the board vectors from sprite vectors.
	m_obstructions.push_back(NULL);
	// Pushback an invalid point to separate board and sprite in m_points.
	m_points.push_back(SEPARATOR);
}

/*
 * Determine if a node can be directly reached from another node
 * i.e. is there an unobstructed line between the two?
 */
bool CPathFind::isChild(
	const NODE &child, 
	const NODE &parent, 
	const CSprite *pSprite, 
	const CPfVector &base,
	const int flags)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (child.pos == parent.pos) return false;

	if (m_heuristic == PF_VECTOR)
	{
		CPfVector v(parent.pos);
		v.push_back(child.pos);
		v.close(false);

		// Check for board collisions along the path.
		for (std::vector<CPfVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
		{
			if ((*i) && (*i)->contains(v)) return false;		
		}
	}
	else
	{
		const DB_POINT max = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};
		if (child.pos.x <= 0 || child.pos.y <= 0 || child.pos.x >= max.x || child.pos.y >= max.y) 
			return false;

		// Check for collisions with both the swept vector and the target.
		CPfVector sweep = CPfVector(base + parent.pos).sweep(parent.pos, child.pos);
		// Move the origin to the target.
		CPfVector v = base + child.pos;
		
		// Tile pathfinding operates directly on board/sprite vectors.
		for (std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
		{
			if (i->layer != m_layer || i->type != TT_SOLID) continue;
			if ((flags & PF_SWEEP) && i->pV->contains(sweep)) return false;
			if (i->pV->contains(v)) return false;
		}

		// If the goal is occupied by a sprite and do not want to bypass
		// it (i.e., we want to meet it) then return.
		if ((child.pos == m_goal.pos) && (~flags & PF_AVOID_SPRITE)) return true;

		DB_POINT unused = {0, 0};
		for (std::vector<CSprite *>::iterator j = g_sprites.v.begin(); j != g_sprites.v.end(); ++j)
		{
			if ((*j)->getPosition().l != m_layer || *j == pSprite) continue;
			CVector base = (*j)->getVectorBase(true);
			if ((flags & PF_SWEEP) && base.contains(sweep, unused)) return false;
			if (base.contains(v, unused)) return false;
		}
	}
	return true;
}

/*
 * Main function - apply the algorithm to the input points.
 */
PF_PATH CPathFind::pathFind(
	const DB_POINT start, 
	const DB_POINT goal,
	const int layer, 
	const RECT &r, 
	const int type, 
	const CSprite *pSprite,
	const int flags)
{
	// Recreate m_obstructions if running on a new board or changing layers.
	PF_HEURISTIC heur = PF_HEURISTIC(type);
	if (heur == PF_PREVIOUS) heur = m_heuristic;

	if (layer != m_layer || m_obstructions.empty() || heur != m_heuristic)
		initialize(layer, r, heur);

	// Quit if the reset fails or the goal is the start point.
	CPfVector base;
	if (!reset(start, goal, r, pSprite, base, flags)) return PF_PATH();
	if (m_start.pos == m_goal.pos) return PF_PATH();

	while (!m_openNodes.empty())
	{
		// Explore all open nodes until there are none left.
		++m_steps;

		// Remove the best open node and add it to the closed nodes.
		NODE *parent = bestOpenNode();
		m_closedNodes.push_back(*parent);
		m_openNodes.erase(parent);
		parent = &m_closedNodes.back();

		// Check if the goal has been reached.
		if (parent->pos == m_goal.pos || m_steps > PF_MAX_STEPS) break;

		// Find child nodes.
		DB_POINT p = {0, 0};
		while (getChild(p, parent->pos))
		{
			// Check if this node has been encountered as a child of another
			// node, and if so whether it this new cost (route) is more
			// efficient.

			NODE child(p);
			if (!isChild(child, *parent, pSprite, base, flags | PF_SWEEP)) continue;

			// Assign total cost of moving from the start to this node
			// *via this parent*, and the straight-line estimate to the goal (heuristic).
			child.cost = parent->cost + distance(*parent, child);
			child.dist = distance(child, m_goal);

			// m_closedNodes and parent are both constant in this while().
			child.parent = parent - m_closedNodes.begin();
			if (m_heuristic != PF_VECTOR) 
			{
				// m_u.i will have incremented - the previous value is needed.
				child.direction = MV_ENUM(m_u.i - (m_heuristic == PF_AXIAL ? 2 : 1));
			}

			// Check if the node has been closed via a different route,
			// and if so, whether this is a more efficient route.
			for (NV_ITR k = m_closedNodes.begin(); k != m_closedNodes.end(); ++k)
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
		return constructPath(m_closedNodes.back(), r);
	}
	return PF_PATH();
		
}

/*
 * Reset the points at the start of a search.
 */
bool CPathFind::reset(
	DB_POINT start, 
	DB_POINT goal, 
	const RECT &r, 
	const CSprite *pSprite,
	CPfVector &base,
	const int flags)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (m_heuristic == PF_VECTOR)
	{
		// Remove old sprite bases up to board separator.
		while (m_obstructions.back())
		{
			delete m_obstructions.back();
			m_obstructions.pop_back();
		}

		// Remove old sprite base nodes up to board separator.
		while (m_points.back() != SEPARATOR)
		{
			m_points.pop_back();
		}

		const DB_POINT limits = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};
		// Grow by longest diagonal.
		const int x = abs(r.left) > abs(r.right) ? r.left : r.right,
				  y = abs(r.top) > abs(r.bottom) ? r.top : r.bottom;
		const int size = x > y ? x : y; //sqrt(x * x + y * y);

		// Re-add the sprite bases each time.
		for (std::vector<CSprite *>::iterator i = g_sprites.v.begin(); i != g_sprites.v.end(); ++i)
		{
			if ((*i)->getPosition().l != m_layer || *i == pSprite) continue;

			// tbd: speed up by saving old pfvectors (associate each with its base vector).
			CPfVector *vector = new CPfVector((*i)->getVectorBase(true));

			// Extra clearance for sprites.
			vector->grow(size + 1);

			// If a sprite is at the goal and we do not want to bypass it
			// (i.e., we want to meet it), then do not add it's vector
			// and the path will reach the requested goal.
			if ((~flags & PF_AVOID_SPRITE) && vector->containsPoint(goal)) 				
			{
				if (vector->containsPoint(start)) start = vector->nearestPoint(start);
				delete vector;
			}
			else
			{
				m_obstructions.push_back(vector);
				vector->createNodes(m_points, limits);					
			}
		}

		// Check if the goal is contained in a solid area.
		// If so, set the goal to be the closest edge point.
		int spFlags = PF_AVOID_SPRITE;
		for (std::vector<CPfVector *>::iterator j = m_obstructions.begin(); j != m_obstructions.end(); ++j)
		{
			if (!*j)
			{
				// Board vector / sprite separator.
				spFlags = flags;
				continue;
			}
			// If the goal is allowed in a sprite base skip because 
			// we have already checked this in the previous loop.
			if ((spFlags & PF_AVOID_SPRITE) && (*j)->containsPoint(goal))
			{
				// If the goal is blocked and a nearby point is not allowed, quit.
				if (spFlags & PF_QUIT_BLOCKED) return false;

				goal = (*j)->nearestPoint(goal);
				/* Consider goals contained in multiple vectors! */
			}
			if ((*j)->containsPoint(start))
			{
				start = (*j)->nearestPoint(start);
				/* Consider starts contained in multiple vectors! */
			}
		}

		// Change the previous goal and start.
		*m_points.begin() = start;
		*(m_points.begin() + 1) = goal;
		m_u.v = m_points.begin();
	}
	else
	{
		// Tile pathfinding.
		const bool isIso = g_pBoard->isIsometric();

		// Get the vector base once.
		if (pSprite)
			base = pSprite->getVectorBase(false);
		else
		{
			DB_POINT pts[4];
			tagSpriteAttr::defaultVector(pts, g_pBoard->isIsometric(), CSprite::m_bPxMovement, false);
			base.push_back(pts, 4);
			base.close(true);
		}

		coords::roundToTile(goal.x, goal.y, isIso, true);

		// Check for goal contained in tiles. This does a quick check
		// on the goal and surrounding 9 tiles, but looks no further.

		// Switch the heuristic to check all children of the goal.
		const PF_HEURISTIC heur = m_heuristic;
		m_heuristic = PF_DIAGONAL;
		m_u.i = MV_E;

		// Temporarily set m_goal, but overwrite if first is blocked.
		m_goal = NODE(goal);
		NODE child(goal), unused;
		while (true)
		{
			// Determine if the sprite can exist at the target - if
			// so the target is clear.
			if (isChild(child, unused, pSprite, base, flags))
			{
				goal = child.pos;
				break;
			}

			if (flags & PF_QUIT_BLOCKED) return false;

			// If the target isn't clear try the children of the goal
			// until all surrounding tiles are checked.
			if (!getChild(child.pos, goal))
			{
				// Signal to quit the alogrithm since we can't reach the goal.
				return false;
			}
		}

		// Limit neighbours depending on allowed directions.
		m_heuristic = heur;
		m_u.i = (m_heuristic == PF_AXIAL && isIso ? MV_SE : MV_E);
	}

	m_goal = NODE(goal);
	m_start = NODE(start);

	// Distance estimate for start node (heuristic).
	m_start.dist = distance(m_start, m_goal);
	m_steps = 0;

	m_openNodes.clear();
	m_closedNodes.clear();
	m_openNodes.push_back(m_start);

	return true;
}

void CPathFind::drawObstructions(int x, int y, CCanvas *cnv)
{
	for (std::vector<CPfVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
	{
		if (!*i) break;
		(*i)->draw(RGB(255,0,128), false, x, y, cnv);
	}
}
