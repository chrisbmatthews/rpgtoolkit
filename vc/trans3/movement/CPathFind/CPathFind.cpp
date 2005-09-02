/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CPathFind - A* Pathfinding for vector collision.
 */

/*
 * TO DO:
 *		TILE PATHFINDING.
 *		SPRITES.
 */

#include "CPathFind.h"
#include "../../common/board.h"

/*----- VECTOR PATHFINDING -----*

// Create nodes. Find connected nodes, distances (straight line, diagonal map, "manhattan").
// Pointer to parent.

// Create OPEN and CLOSED sets.

// OPEN set: nodes to be examined (initially the starting node).

// CLOSED set: visited nodes (initially empty).

// g(n) = cost (e.g. distance) of traversing the path from start to node n.
// h(n) = estimate of cost to goal (using heuristic).
// f(n) = g(n) + h(n)
// heuristic = distance evaluation (straight line, terrain modifiers).

{
	while(OPEN has nodes)
	{
		// Take best node in OPEN (lowest f-value).

		if (best == goal)
		{
			return path;
		}
		
		// Add node to CLOSED.
		
		// Examine neighbours.
		for (each neighbour)
		{

			g(neighbour) = g(best) + distance (best -> neighbour)

			if (neighbour is already in CLOSED)
			{
				// compare CLOSED entry's g() to this g()

				if (this g() > old g())
				{
					// This route is longer, disregard node.
				}
				else
				{
					// New node is better, remove old and add new.
				}
			}
			else
			{
				// Calculate heuristic for this neighbour.
				h(neighbour) = distance (neighbour -> goal)
				f(neighbour) = g(neighbour) + h(neighbour)

				if (neighbour is already in OPEN)
				{

					if (old f() > this f())
					{
						// This route is longer, disregard node.
					}
					else
					{
						// New node is better, remove old and add new to OPEN.
					}
				}
				else { add node to OPEN }.
				
			}
		} // for neighbours.

		Add best to CLOSED.

	}

	// Construct path.
	Map through parents in CLOSED.

}

*----- VECTOR PATHFINDING -----*/

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
PF_PATH CPathFind::constructPath(NODE node)
{
	PF_PATH path;

	while(node.pos != m_start.pos)
	{
		path.push_back(node.pos);
		node = *node.parent;
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
			return max(dx, dy);
		case PF_VECTOR:
			return sqrt(dx * dx + dy * dy);
	}
	return 0;
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

	const DB_POINT limits = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};

	// Grow by longest diagonal.
	const int x = abs(r.left) > abs(r.right) ? r.left : r.right,
			  y = abs(r.top) > abs(r.bottom) ? r.top : r.bottom;
	const int size = x > y ? x : y; //sqrt(x * x + y * y);

	// Add collidable nodes.
	for (std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
	{
		if (i->layer != layer || i->type != TT_SOLID) continue;

		// The board vectors have to be "grown" to make sure the sprites
		// can move around them without colliding.
		CVector *vector = new CVector(*(i->pV));
		vector->grow(size);

		m_obstructions.push_back(vector);
		vector->createNodes(m_points, limits);					
	}

	// Pushback two empty points to act as the first goal and start.
	m_points.push_back(DB_POINT());
	m_points.push_back(DB_POINT());

	// Prevent reallocation. Alternatively make .parent the offset from .begin().
	m_closedNodes.reserve(PF_MAX_STEPS);
}

/*
 * Determine if a node can be directly reached from another node
 * i.e. is there an unobstructed line between the two?
 */
bool CPathFind::isChild(NODE &child, NODE &parent)
{
	if (child.pos == parent.pos) return false;

	CVector v(parent.pos, 2);
	v.push_back(child.pos);
	v.close(false);

	// Check for board collisions along the path.
	for (std::vector<CVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
	{
		// Collision against a solid vector: not a child node.
		if ((*i)->pfContains(v)) break;		
	}

	// No collisions - is a child.
	return (i == m_obstructions.end());
}

/*
 * Main function - apply the algorithm to the input points.
 */
PF_PATH CPathFind::pathFind(const DB_POINT start, const DB_POINT goal,
							const int layer, const RECT &r, const int type)
{
	// Recreate m_obstructions if running on a new board or changing layers.
	if (layer != m_layer || m_obstructions.empty()) initialize(layer, r, type);

	reset(start, goal);

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
		for (DB_ITR i = m_points.begin(); i != m_points.end(); ++i)
		{
			// Check if this node has been encountered as a child of another
			// node, and if so whether it this new cost (route) is more
			// efficient.

			NODE child(*i);
			if (!isChild(child, *parent)) continue;

			// Assign total cost of moving from the start to this node
			// *via this parent*, and the straight-line estimate to the goal (heuristic).
			child.cost = parent->cost + distance(*parent, child);
			child.dist = distance(child, m_goal);
			child.parent = parent;

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
		return constructPath(m_closedNodes.back());
	}
	return PF_PATH();
		
}

/*
 * Reset the points at the start of a search.
 */
void CPathFind::reset(DB_POINT start, DB_POINT goal)
{
	// Check if the goal is contained in a solid area.
	// If so, set the goal to be the closest edge point.
	for (std::vector<CVector *>::iterator j = m_obstructions.begin(); j != m_obstructions.end(); ++j)
	{
		if ((*j)->containsPoint(goal) % 2)
		{
			goal = (*j)->nearestPoint(goal);
			/* Consider goals contained in multiple vectors! */
		}
		if ((*j)->containsPoint(start) % 2)
		{
			start = (*j)->nearestPoint(start);
			/* Consider starts contained in multiple vectors! */
		}

	}

	/* Sprite collisions */

	m_goal = NODE(goal);
	m_start = NODE(start);

	// Change the previous goal and start.
	*(m_points.end() - 2) = start;
	*(m_points.end() - 1) = goal;

	// Distance estimate for start node (heuristic).
	m_start.dist = distance(m_start, m_goal);
	m_steps = 0;

	m_openNodes.clear();
	m_closedNodes.clear();
	m_openNodes.push_back(m_start);
}

