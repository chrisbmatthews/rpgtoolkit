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
#include "../../../tkCommon/tkDirectx/platform.h"
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>				// RECT only.

/*
 * Defines
 */
const double CV_PRECISION = 0.001;	// Pixel precision for point comparison.
const double PI = 3.14159265359;
const double GRAD_INF = 0x00100000;	// Something big.

/*
typedef enum tagCurl 
{
	CURL_RIGHT = -1,	
	CURL_NDEF,
	CURL_LEFT
} E_CURL;
*/
#define CURL_NDEF  0
#define CURL_LEFT  1
#define CURL_RIGHT -1


typedef enum tagVectorType
{
	TT_NORMAL = 0,
	TT_SOLID = 1,
	TT_UNDER = 2,
	TT_UNIDIRECTIONAL = 4,
	TT_STAIRS = 8
	/* etc */
} CVECTOR_TYPE;

// Double-precision point.
typedef struct tagDbPoint
{
	double x, y;
} DB_POINT;

typedef std::vector<DB_POINT>::iterator DB_ITR;

class CVector  
{
public:
	// (0, 0) point Constructor.
	CVector(void);

	// (x, y) point Constructor.
	CVector(const double x, const double y, const int reserve, const int tileType);

	// Addition operator (moves entire vector).
	CVector operator+ (const DB_POINT p);

	// Addition assignment operator (moves entire vector).
	CVector &operator+= (const DB_POINT p);

	// Push a point onto the back of the vector.
	void push_back(const double x, const double y);

	// Seal the vector to create a polygon.
	bool close(const int n, const bool isClosed, const int curl);

	// Determine if a vector intersects or contains another vector.
	CVECTOR_TYPE contains(CVector &rhs, DB_POINT &ref);

	// Determine if a polygon contains a point.
	bool containsPoint(DB_POINT p);

	// Determine if a vector intersects another vector.
	CVECTOR_TYPE intersect(CVector &rhs, DB_POINT &ref);

	// Draw the vector to the screen (testing purposes).
	void draw(CONST LONG color, const bool drawText);

	// Return number of points in vector.
	int size(void) const { return m_p.size(); };

//	void changePoint(int i, double x, double y) { m_p[i].x = x; m_p[i].y = y; };

	// Estimate the "curl" of a polygon (closed vector).
	int estimateCurl(void);

private:
	// Calculate the bounding box of the vector.
	void boundingBox(RECT &rect);

	// Calculate gradient of a sub-vector.
	double gradient(const DB_ITR &i) const;

	// Calculate y-axis intercept of a sub-vector.
	double intercept(const DB_ITR &i) const;

	// Internal function NOT public: intersect.
	bool intersect(DB_ITR &i, CVector &rhs);

	// Determine if a sub-vector is vertical.
	inline bool isVertical(const DB_ITR &i) const { return (i->x == (i + 1)->x); };
	
	// Determine if a point lies on a sub-vector.
	bool pointOnLine(const DB_ITR &i, const DB_POINT &p) const;

	std::vector<DB_POINT> m_p;	// Vector of points.
	RECT m_bounds;				// Bounding box.
	bool m_closed;				// Closed to form a polygon.
	int m_curl;					// Clockwise or Anti-clockwise subvector movement.
	CVECTOR_TYPE m_type;		// What kind of action does this vector have?

};

#endif
