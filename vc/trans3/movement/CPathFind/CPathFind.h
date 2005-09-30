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
#include "../../common/sprite.h"
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>				// RECT only.
#include <math.h>

/*
 * Defines
 */
const int PF_MAX_STEPS = 1000;		// Maximum number of steps in a path.

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
	MV_ENUM direction;				// Directional relationship to parent.

	tagNode(): pos(), cost(0), direction(MV_IDLE), dist(0), parent(NULL) {};
	tagNode(DB_POINT p): pos(p), cost(0), direction(MV_IDLE), dist(0), parent (NULL) {};

	int fValue(void) { return (cost + dist); };

} NODE;

typedef std::vector<NODE>::iterator NV_ITR;
typedef std::vector<DB_POINT> PF_PATH;

class CPathFind
{
public:

	// Constructor.
	CPathFind();

	// Destructor.
	virtual ~CPathFind()
	{
		freeVectors();
	}

	// Construct an equvialent directional path.
	std::vector<MV_ENUM> directionalPath(void);

	void freeVectors(void)
	{
		for (std::vector<CVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
		{
			delete *i;
		}
		m_obstructions.clear();
	};

	// Main function - apply the algorithm to the input points.
	PF_PATH pathFind(const DB_POINT start, const DB_POINT goal,
					 const int layer, const RECT &r, 
					 const int type, const void *pSprite);

private:
	CPathFind (CPathFind &rhs);
	CPathFind &operator= (CPathFind &rhs);

	// Find the node with the lowest f-value.
	NODE *bestOpenNode (void);

	// Make the path by tracing parents through m_closedNodes.
	PF_PATH constructPath(NODE node, const RECT &r);

	// Construct nodes from a CVector and add to the nodes vector.
	void createNodes (CVector *vector);

	// Estimate the straight-line distance between nodes.
	int distance (NODE &a, NODE &b);

	// Get the next potential child of a node.
	bool getChild(DB_POINT &child, const DB_POINT &parent);

	// Re-initialise the search.
	void initialize(const int layer, const RECT &r, const int type, const void *pSprite);

	// Determine if a node can be directly reached from another node.
	bool isChild(NODE &child, NODE &parent);

	// Reset the points at the start of a search.
	void reset(DB_POINT start, DB_POINT goal, const RECT &r);

	std::vector<DB_POINT> m_points;				// All node coords.
	std::vector<NODE> m_openNodes;
	std::vector<NODE> m_closedNodes;
	std::vector<CVector *> m_obstructions;		// Obstructions on the layer.

	PF_HEURISTIC m_heuristic;					// Estimate method.
	int m_layer;
	int m_steps;								// Number of steps taken.
	NODE m_start;
	NODE m_goal;

	union										// Get child loop trackers. 
	{
		DB_ITR v;								// Vector - m_points.
		int i;									// Tile - MV_ENUM.
	} m_u;
};

#endif