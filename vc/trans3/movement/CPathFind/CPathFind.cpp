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
 *		GOAL TESTS.
 *		TILE PATHFINDING.
 *		SPRITES.
 *		CONCAVE POINTS.
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
CPathFind::CPathFind(const DB_POINT start, const DB_POINT goal, 
					 const int layer, const RECT base):
m_start(start),
m_goal(goal),
m_layer(layer),
m_heuristic(PF_DIAGONAL)
{
	extern LPBOARD g_pBoard;
	// Determine closest approach to obstructions, rounded up.
	const int width = (base.right - base.left + 1) * 0.5, 
			  height = (base.bottom - base.top + 1) /* 0.5*/;

	// Distance estimate for start node (heuristic).
	m_start.dist = distance(m_start, m_goal);

	// Add to coordinate vector.
	m_points.push_back(start);
	m_points.push_back(goal);

	DB_POINT limits = {g_pBoard->pxWidth(), g_pBoard->pxHeight()};

	// Add collidable nodes.
	for (std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin(); i != g_pBoard->vectors.end(); ++i)
	{
		if (i->layer != m_layer || i->type != TT_SOLID) continue;

		/* Check goal is not in a solid region. */

		// The board vectors have to be "grown" to make sure the sprites
		// can move around them without colliding.
		CVector *vector = new CVector(*(i->pV));
		vector->grow(width, height);

		m_obstructions.push_back(vector);
		vector->createNodes(m_points, limits);					
	}

	/* Sprite collisions */

	// Prevent reallocation. Alternatively make .parent the offset from .begin().
	m_closedNodes.reserve(PF_MAX_STEPS);
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

	/* Sprite collisions */			

	// No collisions - is a child.
	return (i == m_obstructions.end());
}

/*
 * Main function - apply the algorithm to the input points.
 */
PF_PATH CPathFind::pathFind(void)
{
	m_openNodes.clear();
	m_closedNodes.clear();
	m_openNodes.push_back(m_start);

	while (!m_openNodes.empty())
	{
		// Explore all open nodes until there are none left.

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
			if (*i == parent->pos || !isChild(child, *parent)) continue;

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


			
