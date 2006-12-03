/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Jonathan D. Hughes
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

// Distance measurements.
enum PF_HEURISTIC
{
	PF_PREVIOUS,
	PF_AXIAL,
	PF_DIAGONAL,
	PF_VECTOR
};

// Flags: Three possibilities when target is blocked -
//	0 - cannot reach target, do not pathfind (e.g., wander())
//	1 - attempt to reach given target (e.g., attacking a sprite)
//	2 - move the goal to the nearest free point (e.g., when a sprite
//		blocks a mid-section of a path). 
#define PF_QUIT_BLOCKED		1	// Do not move the goal to the nearest free point when blocked.
#define PF_AVOID_SPRITE		2	// Walk around a sprite when it blocks the goal.
#define PF_SWEEP			4	// Check a sweep from parent to child (private use).

// A node or navigation point.
typedef struct tagNode
{
	DB_POINT pos;					// Location of the node.
	int cost;						// Cost to reach this node from start via parents (g).
	int dist;						// Estimate to destination (h).
	int parent;						// Node's parent in m_closedNodes (offset from .begin()).
	MV_ENUM direction;				// Directional relationship to parent.

	tagNode(): pos(), cost(0), direction(MV_IDLE), dist(0), parent(NULL) { pos.x = pos.y = 0; };
	tagNode(DB_POINT p): pos(p), cost(0), direction(MV_IDLE), dist(0), parent (NULL) {};

	int fValue(void) const { return (cost + dist); };

} NODE;

typedef std::vector<NODE>::iterator NV_ITR;
typedef std::vector<DB_POINT> PF_PATH;

class CSprite;
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
		for (std::vector<CPfVector *>::iterator i = m_obstructions.begin(); i != m_obstructions.end(); ++i)
		{
			delete *i;
		}
		m_obstructions.clear();
	};

	// Main function - apply the algorithm to the input points.
	PF_PATH pathFind(
		const DB_POINT start, 
		const DB_POINT goal,
		const int layer, 
		const RECT &r, 
		const int type, 
		const CSprite *pSprite,
		const int flags
	);

	void drawObstructions(int x, int y, CCanvas *cnv);

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
	bool getChild(DB_POINT &child, DB_POINT parent);

	// Re-initialise the search.
	void initialize(const int layer, const RECT &r, const PF_HEURISTIC type);

	// Determine if a node can be directly reached from another node.
	bool CPathFind::isChild(
		const NODE &child, 
		const NODE &parent, 
		const CSprite *pSprite, 
		const CPfVector &base,
		const int flags
	);

	// Reset the points at the start of a search.
	bool reset(
		DB_POINT start, 
		DB_POINT goal, 
		const RECT &r, 
		const CSprite *pSprite,
		CPfVector &base,
		const int flags
	);

	std::vector<DB_POINT> m_points;				// All node coords.
	std::vector<NODE> m_openNodes;
	std::vector<NODE> m_closedNodes;
	std::vector<CPfVector *> m_obstructions;	// Obstructions on the layer.

	PF_HEURISTIC m_heuristic;					// Estimate method.
	int m_layer;
	int m_steps;								// Number of steps taken.
	NODE m_start;
	NODE m_goal;

	/* Colin:	This can't be a union because DB_ITR has a copy constructor.
	 *			It also can't be nameless because nameless classes can't have
	 *			compiler-generated constructors. */
	struct tagU									// Get child loop trackers. 
	{
		DB_ITR v;								// Vector - m_points.
		int i;									// Tile - MV_ENUM.
	} m_u;
};

#endif