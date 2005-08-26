/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CPathFind - A* Pathfinding for vector collision.
 */

#ifndef _CPATHFIND_H_
#define _CPATHFIND_H_

/*
 * Includes
 */
#include "../CVector/CVector.h"
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>				// RECT only.
#include <math.h>

/*
 * Defines
 */
const int PF_MAX_STEPS = 100;		// Maximum number of steps in a path.

// Distance measurements.
enum PF_HEURISTIC
{
	PF_AXIAL,
	PF_DIAGONAL,
	PF_VECTOR
};

// A node or navigation point.
typedef struct tagNode
{
	DB_POINT pos;					// Location of the node.
	int cost;						// Cost to reach this node from start via parents (g).
	int dist;						// Estimate to destination (h).
	tagNode *parent;				// Node's parent in m_closedNodes.

	tagNode(): pos(), cost(0), dist(0), parent(NULL) {};
	tagNode(DB_POINT p): pos(p), cost(0), dist(0), parent (NULL) {};

	int fValue(void) { return (cost + dist); };

} NODE;

typedef std::vector<NODE>::iterator NV_ITR;
typedef std::vector<DB_POINT> PF_PATH;

class CPathFind
{
public:

	// Constructor.
	CPathFind(const DB_POINT start, const DB_POINT goal, const int layer, const RECT base);

	// Destructor.
	virtual ~CPathFind()
	{
		for (std::vector<CVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
		{
			delete *i;
		}
	}

	// Find the node with the lowest f-value.
	NODE *bestOpenNode (void);

	// Make the path by tracing parents through m_closedNodes.
	PF_PATH constructPath(NODE node);

	// Construct nodes from a CVector and add to the nodes vector.
	void createNodes (CVector *vector);

	// Estimate the straight-line distance between nodes.
	int distance (NODE &a, NODE &b);

	// Determine if a node can be directly reached from another node.
	bool isChild(NODE &child, NODE &parent);

	// Main function - apply the algorithm to the input points.
	PF_PATH pathFind (void);

private:
	CPathFind (CPathFind &rhs);
	CPathFind &operator= (CPathFind &rhs);

	std::vector<DB_POINT> m_points;				// All node coords.
	std::vector<NODE> m_openNodes;
	std::vector<NODE> m_closedNodes;
	std::vector<CVector *> m_obstructions;		// Obstructions on the layer.

	PF_HEURISTIC m_heuristic;					// Estimate method.
	int m_layer;
	int m_steps;								// Number of steps taken.
	NODE m_start;
	NODE m_goal;
};

#endif