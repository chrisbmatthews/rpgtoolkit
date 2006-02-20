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
#include "../locate.h"

/*
 * Defines
 */
const int PF_MAX_STEPS = 1000;		// Maximum number of steps in a path.
const DB_POINT SEPARATOR = {-1, -1};// Invalid point to separate board and sprites in m_points.

/*
 * Default constructor.
 */
CPathFind::CPathFind():
m_heuristic(PF_VECTOR),
m_goal(),
m_layer(0),
m_start(),
m_steps(0)
{
	// Insufficient information is available when CSprite is constructed
	// to be able to do anything here.
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
//		dx = (m_heuristic == PF_VECTOR ? (r.right - r.left) / 2 : BASE_POINT_X - 16);
		dy = (m_heuristic == PF_VECTOR ? (r.bottom - r.top) / 2 : BASE_POINT_Y - 16);
	}

	if (m_heuristic == PF_VECTOR)
	{
		// Pushback the goal without modification.
		path.push_back(node.pos);
		node = *node.parent;
	}

	while(node.pos != m_start.pos)
	{
		node.pos.x += dx;
		node.pos.y += dy;
		path.push_back(node.pos);
		node = *node.parent;
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
			node = *node.parent;
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

	switch(m_heuristic)
	{
		case PF_AXIAL:
			return (dx + dy);
		case PF_DIAGONAL:
			return (dx > dy ? dx : dy);
		case PF_VECTOR:
			return sqrt(dx * dx + dy * dy);
	}
	return 0;
}

/*
 * Get the next potential child of a node.
 */
bool CPathFind::getChild(DB_POINT &child, const DB_POINT &parent)
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
		child.x = g_directions[isIso][m_u.i][0] * 32 + parent.x;
		child.y = g_directions[isIso][m_u.i][1] * 32 + parent.y;

		// Limit neighbours depending on allowed directions.
		m_u.i += (m_heuristic == PF_AXIAL ? 2 : 1);
	}
	return true;
}

/*
 * Re-initialise the search.
 */
void CPathFind::initialize(const int layer, const RECT &r, const int type)
{
	extern LPBOARD g_pBoard;

	m_layer = layer;
	m_heuristic = PF_HEURISTIC(type);

	m_points.clear();
	freeVectors();					// m_obstructions.

	// Prevent reallocation. Alternatively make .parent the offset from .begin().
	m_closedNodes.reserve(PF_MAX_STEPS);

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
		if (i->layer != m_layer || i->type != TT_SOLID) continue;

		// The board vectors have to be "grown" to make sure the sprites
		// can move around them without colliding.
		CVector *vector = new CVector(*(i->pV));
		vector->grow(size);

		m_obstructions.push_back(vector);
		vector->createNodes(m_points, limits);					
	}
	// Pushback a NULL pointer to separate the board vectors from sprite vectors.
	m_obstructions.push_back(NULL);
	// Pushback an "invalid" point to separate board and sprite in m_points.
	m_points.push_back(SEPARATOR);
}

/*
 * Determine if a node can be directly reached from another node
 * i.e. is there an unobstructed line between the two?
 */
bool CPathFind::isChild(NODE &child, NODE &parent)
{
	extern LPBOARD g_pBoard;

	if (child.pos == parent.pos) return false;

	CVector v(parent.pos, 2);
	v.push_back(child.pos);
	v.close(false);

	if (m_heuristic == PF_VECTOR)
	{

		// Check for board collisions along the path.
		for (std::vector<CVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
		{
			// Collision against a solid vector: not a child node.
			if ((*i) && (*i)->pfContains(v)) return false;		
		}
	}
	else
	{
		const DB_POINT max = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};
		if (child.pos.x <= 0 || child.pos.y <= 0 || child.pos.x >= max.x || child.pos.y >= max.y) 
			return false;
				
		// Tile pathfinding operates directly on the board vectors.
		for (std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
		{
			if (i->layer != m_layer || i->type != TT_SOLID) continue;
			DB_POINT ref = {0, 0};
			if (i->pV->contains(v, ref)) return false;
//			if (i->pV->containsPoint(child.pos) % 2) return false;
		}
	}
	return true;
}

/*
 * Main function - apply the algorithm to the input points.
 */
PF_PATH CPathFind::pathFind(const DB_POINT start, const DB_POINT goal,
							const int layer, const RECT &r, 
							const int type, const void *pSprite)
{
	// Recreate m_obstructions if running on a new board or changing layers.
	if (layer != m_layer || m_obstructions.empty()) initialize(layer, r, type);

	reset(start, goal, r, pSprite);
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
			if (!isChild(child, *parent)) continue;

			// Assign total cost of moving from the start to this node
			// *via this parent*, and the straight-line estimate to the goal (heuristic).
			child.cost = parent->cost + distance(*parent, child);
			child.dist = distance(child, m_goal);
			child.parent = parent;
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
void CPathFind::reset(DB_POINT start, DB_POINT goal, const RECT &r, const void *pSprite)
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
			if ((*i)->getPosition().l != m_layer || *i == (CSprite *)pSprite) continue;
			CVector *vector = new CVector((*i)->getVectorBase());
			// Extra clearance for sprites.
			vector->grow(size + 1);

			m_obstructions.push_back(vector);
			vector->createNodes(m_points, limits);					
		}

		// Check if the goal is contained in a solid area.
		// If so, set the goal to be the closest edge point.
		for (std::vector<CVector *>::iterator j = m_obstructions.begin(); j != m_obstructions.end(); ++j)
		{
			if (!*j) continue;
			if ((*j)->containsPoint(goal) % 2)
			{
				goal = (*j)->nearestPoint(goal);
				
				// Make provision for offsetting the points in
				// constructPath().
				if (!g_pBoard->isIsometric())
				{
					// Shift points down the board by half
					// the base height or to the tile edge.
//					goal.x += (r.right - r.left) / 2;
//					goal.y += (r.bottom - r.top) / 2;
				}

				/* Consider goals contained in multiple vectors! */
			}
			if ((*j)->containsPoint(start) % 2)
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
		// Limit neighbours depending on allowed directions.
		const bool isIso = g_pBoard->isIsometric();
		m_u.i = (m_heuristic == PF_AXIAL && isIso ? MV_SE : MV_E);

		// The base points 2D-board sprite bases are at the
		// bottom-centre, which causes an aesthetic problem 
		// because CVector::grow() is designed for centred
		// base points (as with isometric).
		// A solution is to offset the generated path points
		// by half the base height to centre the base point.

		roundToTile(goal.x, goal.y, isIso, false);
		roundToTile(start.x, start.y, isIso, false);

		if (!isIso)
		{
			// Place the tile pathfind node in the centre of the tile.
			// roundToTile(,,, false) returns top-left corner in 2D.
			goal.x += 16;
			goal.y += 16;
			start.x += 16;
			start.y += 16;
		}
	}

	m_goal = NODE(goal);
	m_start = NODE(start);


	// Distance estimate for start node (heuristic).
	m_start.dist = distance(m_start, m_goal);
	m_steps = 0;

	m_openNodes.clear();
	m_closedNodes.clear();
	m_openNodes.push_back(m_start);
}
