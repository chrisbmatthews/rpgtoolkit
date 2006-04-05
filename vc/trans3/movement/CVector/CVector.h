/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CVector.cpp - Vector collision implementation.
 */

#ifndef _CVECTOR_H_
#define _CVECTOR_H_

/*
 * Includes
 */
//#define WIN32_LEAN_AND_MEAN
#include <windows.h>				// RECT only.
#include <vector>

/*
 * Defines
 */
const double CV_PRECISION = 0.01;	// Pixel precision for point comparison.
const double PI = 3.14159265359;
const double RADIAN = 180 / PI;
const double GRAD_INF = 0x00100000;	// Something big.

#define CURL_NDEF	0
#define CURL_LEFT	1				// Clockwise movement of subvectors.
#define CURL_RIGHT -1				// Anti-clockwise movement of subvectors.

// Sprite z-order flags.
typedef enum tagZOrder
{
	ZO_NONE,
	ZO_COLLIDE,
	ZO_ABOVE

} ZO_ENUM;

// Double-precision point.
typedef struct tagDbPoint
{
	double x, y;
} DB_POINT;

typedef std::vector<DB_POINT>::iterator DB_ITR;

inline bool operator== (const DB_POINT &a, const DB_POINT &b) 
{
	return ((a.x == b.x) && (a.y == b.y));
}

inline bool operator!= (const DB_POINT &a, const DB_POINT &b)
{
	return ((a.x != b.x) || (a.y != b.y));
}

class CCanvas;

class CVector  
{
public:
	// Default constructor.
	CVector(void);

	// (x, y) point Constructor.
	CVector(const double x, const double y);

	// (x, y) point Constructor.
	CVector(const DB_POINT p);

	// Addition operator (moves entire vector).
	CVector operator+ (const DB_POINT p) { return (CVector(*this) += p); }

	// Addition assignment operator (moves entire vector).
	CVector &operator+= (const DB_POINT p);

	// Comparison of the points of two vectors.
	bool operator== (const CVector &rhs) const;

	// Push a point onto the back of the vector.
	void push_back(DB_POINT p);

	// Push a point onto the back of the vector.
	void push_back(const double x, const double y);

	// Push an array of points onto the end of the vector.
	void push_back(const DB_POINT pts[], const short size);

	// Seal the vector to create a polygon.
	bool close(const bool isClosed);

	// Determine if a vector intersects or contains another vector.
	virtual bool contains(CVector &rhs, DB_POINT &ref);

	// Determine intersect and z-ordering.
	virtual ZO_ENUM contains(CVector &rhs/*, DB_POINT &ref*/);

	// Determine if a polygon contains a point.
	bool containsPoint(const DB_POINT p)
	{
		return (windingNumber(p) % 2);
	}
	int windingNumber(const DB_POINT p);

	// Create a mask from a closed vector.
	bool createMask(CCanvas *cnv, const int x, const int y, CONST LONG color);

	// Get the bounding box.
	RECT getBounds(void) const { return m_bounds; };

	// Determine if a vector intersects another vector.
	bool intersect(CVector &rhs, DB_POINT &ref);

	// Move a vector (x,y = new location of first point).
	void move(const int x, const int y)
	{
		const DB_POINT p = {x - m_p.front().x, y - m_p.front().y};
		*this += p;
	}

	// Draw the vector to the screen (testing purposes).
	void draw(CONST LONG color, const bool drawText, const int x, const int y, CCanvas *const cnv);

	// Return number of points in vector.
	int size(void) const { return m_p.size(); };

	// Get a vector point.
	DB_POINT operator[](const int i) const { return ((m_p.size() > i) ? m_p[i] : m_p.back()); }

//	void changePoint(int i, double x, double y) { m_p[i].x = x; m_p[i].y = y; };

	// Estimate the "curl" of a polygon (closed vector).
	int estimateCurl(void);

protected:

	// Calculate the bounding box of the vector.
	void boundingBox(RECT &rect);

	// Calculate gradient of a sub-vector.
	double gradient(const DB_ITR &i) const;

	// Calculate y-axis intercept of a sub-vector.
	double intercept(const DB_ITR &i) const;

	// Internal function NOT public: intersect.
	bool intersect(DB_ITR &i, CVector &rhs, DB_POINT &ref);

	// Determine if a sub-vector is vertical.
	bool isVertical(const DB_ITR &i) const { return (i->x == (i + 1)->x); };
	
	// Determine if a point lies on a sub-vector.
	bool pointOnLine(const DB_ITR &i, const DB_POINT &p) const;

	std::vector<DB_POINT> m_p;	// Vector of points.
	RECT m_bounds;				// Bounding box.
	bool m_closed;				// Closed to form a polygon.
	int m_curl;					// Clockwise or Anti-clockwise subvector movement.

};

class CPfVector: public CVector
{
public:
	// Default constructor.
	CPfVector(const CVector &rhs): CVector(rhs) {};
	
	// Point CVector constructor.
	CPfVector(const DB_POINT p): CVector(p) {};

	// Path-find ::contains() equivalent.
	bool contains(CPfVector &rhs);

	// Expand the vector radially outwards by a number of pixels.
	void grow(const int offset);

	// Find the nearest point on the edge of a vector to a point.
	DB_POINT nearestPoint(const DB_POINT start);

	// Construct nodes from a CVector and add to the nodes vector.
	void createNodes(std::vector<DB_POINT> &points, const DB_POINT max);

private:
	// Extend a point 'a' at the end of a (position) vector 'd' by 'offset' pixels.
	void extendPoint(DB_POINT &a, const DB_POINT &d, const int offset);
	
};

#endif
