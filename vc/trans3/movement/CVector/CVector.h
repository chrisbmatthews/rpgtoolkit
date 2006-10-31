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

// Drawing flags.
typedef enum tagDrawVectors
{
	CV_DRAW_BRD_VECTORS = 1,		// Board vectors.
	CV_DRAW_SPR_VECTORS = 2,		// Sprite vectors.
	CV_DRAW_PATH = 4,				// Sprite paths.
	CV_DRAW_DEST_CIRCLE = 8,		// Sprite destination circles.
	CV_DRAW_SP_PATH = 16,			// Selected player path.
	CV_DRAW_SP_DEST_CIRCLE = 32		// Selected player circle.

} CV_DRAW_VECTORS;

// Double-precision point.
typedef struct tagDbPoint
{
	double x, y;
} DB_POINT;

typedef std::vector<DB_POINT>::iterator DB_ITR;
typedef std::vector<DB_POINT>::const_iterator DB_CITR;

inline bool operator== (const DB_POINT &a, const DB_POINT &b) 
{
	return ((a.x == b.x) && (a.y == b.y));
}

inline bool operator!= (const DB_POINT &a, const DB_POINT &b)
{
	return ((a.x != b.x) || (a.y != b.y));
}

inline DB_POINT operator+ (const DB_POINT &a, const DB_POINT &b)
{
	const DB_POINT p = {a.x + b.x, a.y + b.y};
	return p;
}

inline DB_POINT operator- (const DB_POINT &a, const DB_POINT &b)
{
	const DB_POINT p = {a.x - b.x, a.y - b.y};
	return p;
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
	CVector operator+ (const DB_POINT p) const { return (CVector(*this) += p); }

	// Addition assignment operator (moves entire vector).
	CVector &operator+= (const DB_POINT p);

	// Comparison of the points of two vectors.
	bool operator== (const CVector &rhs) const;

	// Get a vector point.
	DB_POINT operator[](const unsigned int i) const { return ((m_p.size() > i) ? m_p[i] : m_p.back()); }

	// Push a point onto the back of the vector.
	void push_back(DB_POINT p);

	// Push a point onto the back of the vector.
	void push_back(const double x, const double y);

	// Push an array of points onto the end of the vector.
	void push_back(const DB_POINT pts[], const short size);

	// Seal the vector to create a polygon.
	void close(bool isClosed);

	bool closed(void) const { return m_closed; }

	// Determine if a vector intersects or contains another vector.
	virtual bool contains(const CVector &rhs, DB_POINT &ref) const;

	// Determine intersect and z-ordering.
	virtual ZO_ENUM contains(const CVector &rhs/*, DB_POINT &ref*/) const;

	// Determine if a polygon contains a point.
	bool containsPoint(const DB_POINT p) const
	{
		return (windingNumber(p) % 2);
	}
	int windingNumber(const DB_POINT p) const;

	// Create a mask from a closed vector.
	bool createMask(CCanvas *const cnv, const int x, const int y, CONST LONG color) const;

	// Get the bounding box.
	RECT getBounds(void) const { return m_bounds; };

	// Determine if a vector intersects another vector.
	bool intersect(const CVector &rhs, DB_POINT &ref) const;

	// Move a vector (x,y = new location of first point).
	void move(const int x, const int y)
	{
		const DB_POINT p = {x - m_p.front().x, y - m_p.front().y};
		*this += p;
	}

	// Draw the vector to the screen (testing purposes).
	void draw(CONST LONG color, const bool drawText, const int x, const int y, CCanvas *const cnv) const;

	// Return number of points in vector.
	int size(void) const { return m_p.size(); };

	// Alter an existing point.
	void setPoint(const unsigned int i, const double x, const double y);

	// Estimate the "curl" of a polygon (closed vector).
	int estimateCurl(void);

	// Resize the vector.
	void resize(const unsigned int length);

protected:

	// Calculate the bounding box of the vector.
	void boundingBox(RECT &rect) const;

	// Calculate gradient of a sub-vector.
	double gradient(const DB_CITR &i) const;

	// Calculate y-axis intercept of a sub-vector.
	double intercept(const DB_CITR &i) const;

	// Internal function NOT public: intersect.
	bool intersect(DB_CITR &i, const CVector &rhs, DB_POINT &ref) const;

	// Determine if a sub-vector is vertical.
	bool isVertical(const DB_CITR &i) const { return (i->x == (i + 1)->x); };
	
	// Determine if a point lies on a sub-vector.
	bool pointOnLine(const DB_CITR &i, const DB_POINT &p) const;

	std::vector<DB_POINT> m_p;	// Vector of points.
	RECT m_bounds;				// Bounding box.
	bool m_closed;				// Closed to form a polygon.
	int m_curl;					// Clockwise or Anti-clockwise subvector movement.

};

class CPfVector: public CVector
{
public:

	// Void constructor.
	CPfVector(void): CVector() {};

	// Default constructor.
	CPfVector(const CVector &rhs): CVector(rhs) {};
	
	// Point CVector constructor.
	CPfVector(const DB_POINT p): CVector(p) {};

	// Path-find ::contains() equivalent.
	bool contains(const CPfVector &rhs) const;

	// Expand the vector radially outwards by a number of pixels.
	void grow(const int offset);

	// Find the nearest point on the edge of a vector to a point.
	DB_POINT nearestPoint(const DB_POINT start) const;

	// Construct nodes from a CVector and add to the nodes vector.
	void createNodes(std::vector<DB_POINT> &points, const DB_POINT max) const;

	// Sweep out the vector from current location to target.
	CPfVector sweep(const DB_POINT &origin, const DB_POINT &target);

private:
	// Extend a point 'a' at the end of a (position) vector 'd' by 'offset' pixels.
	void extendPoint(DB_POINT &a, const DB_POINT &d, const int offset) const;
	
};

#endif
