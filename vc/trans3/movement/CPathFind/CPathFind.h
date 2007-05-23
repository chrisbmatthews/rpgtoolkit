/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006 - 2007 Jonathan D. Hughes
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
	virtual ~CPathFind() { freeData(); }

	// Construct an equvialent directional path.
	std::vector<MV_ENUM> directionalPath(void);

	// Release allocated memory.
	virtual void freeData(void) {}

	// Public constructor / executor.
	static PF_PATH CPathFind::pathFind(
		CPathFind **ppPf,
		const DB_POINT start, 
		const DB_POINT goal,
		const int layer, 
		const int mode,				// Pathfinding mode.
		const CSprite *pSprite,		// Pointer to the calling sprite - may be NULL.
		const int flags
	);

	// Release members of derived classes.
	static void freeAllData(void);

protected:
	CPathFind(): m_heuristic(PF_AXIAL), m_goal(), m_layer(0), m_start(), m_steps(0) {}
	CPathFind (CPathFind &rhs);
	CPathFind &operator= (CPathFind &rhs);

	// Find the node with the lowest f-value.
	NODE *bestOpenNode (void);

	// Make the path by tracing parents through m_closedNodes.
	virtual PF_PATH constructPath(NODE node, const CSprite *pSprite) const { return PF_PATH(); }

	// Construct nodes from a CVector and add to the nodes vector.
	void createNodes (CVector *vector);

	// Estimate the straight-line distance between nodes.
	virtual int distance(const NODE &a, const NODE &b) const { return 0; }

	// Get the next potential child of a node.
	virtual bool getChild(NODE &child, NODE &parent) { return false; }

	// Determine if a node can be directly reached from another node.
	virtual bool isChild(const NODE &child, const NODE &parent) const { return false; }

	// Main function - apply the algorithm to the input points.
	PF_PATH pathFind(const CSprite *pSprite);

	// Reset the points at the start of a search.
	virtual bool reset(
		DB_POINT start, 
		DB_POINT goal, 
		const int layer,
		const CSprite *pSprite,
		const int flags
	) { return false; }

	std::vector<NODE> m_openNodes;
	std::vector<NODE> m_closedNodes;
	NODE m_start;
	NODE m_goal;

	PF_HEURISTIC m_heuristic;			// Algorithm method.
	int m_layer;
	int m_steps;						// Number of steps (between nodes) taken.

	static int m_isIso;					// g_pBoard->isIsometric().		
};


class CTilePathFind: public CPathFind
{
public:
	CTilePathFind(): m_nextDir(MV_E), m_pBoardPoints(NULL), m_pSweeps(NULL) {}
	void freeData(void) { m_pBoardPoints = NULL; m_pSweeps = NULL; }
	static void freeStatics(void) { m_boardPoints.clear(); m_sweeps.clear(); }

	typedef unsigned char PF_MATRIX_ELEMENT;
	typedef std::vector<std::vector<PF_MATRIX_ELEMENT> > PF_MATRIX;
	typedef PF_MATRIX *LPPF_MATRIX;
	typedef std::map<CPfVector, PF_MATRIX> PF_TILE_MAP;
	typedef std::map<MV_ENUM, std::pair<CPfVector, DB_POINT> > PF_SWEEPS;
	typedef PF_SWEEPS *LPPF_SWEEPS;
	typedef std::map<CVector, PF_SWEEPS> PF_SWEEP_MAP;

private:
	PF_PATH constructPath(NODE node, const CSprite *) const;
	int distance(const NODE &a, const NODE &b) const;
	void initialize(const CSprite *pSprite);
	bool isChild(const NODE &child, const NODE &parent) const;
	bool getChild(NODE &child, NODE &parent);
	bool reset(DB_POINT start, DB_POINT goal, const int layer, const CSprite *pSprite,	const int flags);	

	// Unique.
	void addVector(CVector &vector, PF_SWEEPS &sweeps, PF_MATRIX &points);
	void sizeMatrix(PF_MATRIX &points);

	static PF_TILE_MAP m_boardPoints;	// Board collision vector matrices for unique sprite bases.
	static PF_SWEEP_MAP m_sweeps;		// Sweep set associated with the unique sprite bases.
	PF_MATRIX m_spritePoints;			// Position of sprite collision bases at time of execution.
	LPPF_MATRIX m_pBoardPoints;			// Pointer into m_boardPoints.
	LPPF_SWEEPS m_pSweeps;				// Pointer into m_sweeps;
	int m_nextDir;						// Next neighbour (one of MV_ENUM).
};

class CVectorPathFind: public CPathFind
{
public:
	CVectorPathFind(): m_nextPoint(NULL), m_growSize(0), m_pBoardVectors(NULL) {}
	void freeData(void);
	static void freeStatics(void);

	typedef std::vector<CPfVector *> PF_VECTOR_OBS;
	typedef PF_VECTOR_OBS *LPPF_VECTOR_OBS;
	typedef std::map<CPfVector, PF_VECTOR_OBS> PF_VECTOR_MAP;

private:
	PF_PATH constructPath(NODE node, const CSprite *pSprite) const;
	int distance(const NODE &a, const NODE &b) const;
	void initialize(const CSprite *pSprite);
	bool isChild(const NODE &child, const NODE &parent) const;
	bool getChild(NODE &child, NODE &parent);
	bool reset(DB_POINT start, DB_POINT goal, const int layer, const CSprite *pSprite,	const int flags);	

	std::vector<DB_POINT> m_points;				// All node coordinates (grown board and sprite points).
	PF_VECTOR_OBS m_spriteVectors;

	static PF_VECTOR_MAP m_boardVectors;
	LPPF_VECTOR_OBS m_pBoardVectors;

	DB_ITR m_nextPoint;							// Currently selected point in "points".
	int m_growSize;								// Pixel value to expand collision vectors by.
};

#endif