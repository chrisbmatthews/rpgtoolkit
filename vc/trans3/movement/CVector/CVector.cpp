/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CVector.cpp - Vector collision implementation.
 */

#include "CVector.h"
#include <math.h>
#include "../movement.h"
#include "../../../tkCommon/strings.h"
#include "../../../tkCommon/tkCanvas/GDICanvas.h"

/*
 * Default constructor.
 */
CVector::CVector(void):
m_closed(false),
m_curl(CURL_NDEF)
{
	// Create an void vector of no points.
	RECT bounds = {0, 0, 0, 0}; 
	m_bounds = bounds;
	m_p.clear();
}

/*
 * Point constructor. Note reserve need not be the exact number of points.
 */
CVector::CVector(const double x, const double y):
m_closed(false),
m_curl(CURL_NDEF)
{
	// Create a vector of one point.
	RECT bounds = {x, y, x, y}; 
	m_bounds = bounds;
	push_back(x, y);
}

/*
 * Point constructor. Note reserve need not be the exact number of points.
 */
CVector::CVector(const DB_POINT p):
m_closed(false),
m_curl(CURL_NDEF)
{
	// Create a vector of one point.
	RECT bounds = {p.x, p.y, p.x, p.y}; 
	m_bounds = bounds;
	push_back(p);
}

/*
 * Addition assignment operator - moves the entire vector.
 */
CVector &CVector::operator+= (const DB_POINT p)
{
	// Offset each point by the passed values.
	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)	
	{
		i->x += p.x;
		i->y += p.y;
	}

	// Offset the bounding box.
	m_bounds.right += p.x;
	m_bounds.left += p.x;
	m_bounds.top += p.y;
	m_bounds.bottom += p.y;
	return *this;
}

/*
 * Push a point onto the end of the vector.
 */
void CVector::push_back(DB_POINT p)
{
	// If closed, don't allow more points to be added.
	if (m_closed) return;

	// Check we're not adding the same point twice.
	if (size() > 1)
	{
		if (p == m_p.back()) return;
	}

	// Push a point onto the vector.
	m_p.push_back(p);
}	

/*
 * Push a point onto the end of the vector.
 */
void CVector::push_back(const double x, const double y)
{
	DB_POINT p = {x, y};
	this->push_back(p);
}

/*
 * Push an array of points onto the end of the vector.
 */
void CVector::push_back(const DB_POINT pts[], const short size)
{
	for (int i = 0; i != size; ++i)
	{
		this->push_back(pts[i]);
	}
}

/*
 * Create the bounding box of the vector.
 */
void CVector::boundingBox(RECT &rect)
{
	// Create a box in which the vector is contained.
	rect.bottom = rect.left = rect.right = rect.top = 0;

	// Loop over subvectors and find biggest and smallest points.
	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)
	{
		if ((i->x < rect.left) || (i == m_p.begin())) rect.left = i->x;
		if ((i->y < rect.top) || (i == m_p.begin())) rect.top = i->y;
		if (i->x > rect.right) rect.right = i->x;
		if (i->y > rect.bottom) rect.bottom = i->y;
	}
}

/*
 * Seal the vector: create a polygon and prevent 
 * further points from being added.
 */
bool CVector::close(const bool isClosed)
{
	boundingBox(m_bounds);			// Make the bounding box.

	if ((size() > 1) && (isClosed))
	{
		// If this is closed, add the first points as the last (for curl estimate).
		push_back(m_p.front().x, m_p.front().y);
		m_closed = true;

		// Assign the curl. Estimate if needed.
		m_curl = estimateCurl();
	}
	return true;
}

/*
 * Compare the points of two vectors. 
 * Assumes all points were added in same order.
 */
bool CVector::operator== (const CVector &rhs) const
{
	if (m_p.size() != rhs.m_p.size()) return false;

	for (unsigned int i = 0; i != m_p.size(); ++i)
	{
		if (m_p[i] != rhs.m_p[i]) return false;
	}
	return true;
}

/*
 * Determine if a polygon intersects or contains a CVector.
 * Return a point that represents the intersecting subvector
 * as a position vector for use in sliding tests, etc.
 */
bool CVector::contains(CVector &rhs, DB_POINT &ref)
{
	/*
	 * The rhs CVector intersects the polygon if any of the rhs's
	 * points lie within it, or if any of the CVector's lines
	 * intersect any of the polygon's lines.
	 */

	// Reset ref, but not to zero (div 0 error).
	ref.x = ref.y = 1;

	// Check the pointer (for selected player checking).
	if (&rhs == this) return false;

	// Do a bounding box test for the entire rhs vector.
	if ((rhs.m_bounds.right < m_bounds.left) || (rhs.m_bounds.left > m_bounds.right) ||
		(rhs.m_bounds.bottom < m_bounds.top) || (rhs.m_bounds.top > m_bounds.bottom)) 
		return false;

	// Check for boundary collisions first.
	// CVECTOR_TYPE tt = intersect(rhs, ref);
//	if (intersect(rhs, ref) != TT_NORMAL) return m_type;

	/* BOARD VECTOR */

	DB_POINT unused = {0, 0};
	// Loop over the subvectors in this vector (to size() - 1).
	for (DB_ITR i = m_p.begin(); i != m_p.end() - 1; ++i)	
	{
		if (intersect(i, rhs, unused))
		{
			ref.x = (i + 1)->x - i->x;
			ref.y = (i + 1)->y - i->y;

/*			if (m_type & TT_UNIDIRECTIONAL)
			{
				// Continue one point for the case of corners.
				if (intersect(++i, rhs))
				{
					ref.x = (i + 1)->x - i->x;
					ref.y = (i + 1)->y - i->y;
				}
			}
*/
			return true;
		}
	}

	// We may be completely inside the vector.
	// Check we have a closed object.
	if (m_closed)
	{
		/* SPRITE VECTOR */
		// Loop over the points of the rhs vector.
		for (i = rhs.m_p.begin(); i != rhs.m_p.end(); ++i)
		{
			// Determine if this point is contained in the polygon.
			if (containsPoint(*i)) return true;
		}
	}
	return false;
}

/*
 * Determine if a polygon intersects or contains a CVector.
 * Return z-order flags describing if a collision occurred and
 * whether the source is above or below the target (based on the
 * number of times the target's boundaries are crossed.
 */
ZO_ENUM CVector::contains(CVector &rhs/*, DB_POINT &ref*/)
{
	/*
	 * The rhs CVector intersects the polygon if any of the rhs's
	 * points lie within it, or if any of the CVector's lines
	 * intersect any of the polygon's lines.
	 */

	// Check the pointer (for selected player checking).
	if (&rhs == this) return ZO_NONE;

	// Do a bounding box test for the entire rhs vector.
	if ((rhs.m_bounds.right < m_bounds.left) ||
		(rhs.m_bounds.left > m_bounds.right) ||
		(rhs.m_bounds.bottom < m_bounds.top) ||
		(rhs.m_bounds.top > m_bounds.bottom))
	{
		// No overlap - no strict z-order.
		return ZO_NONE;
	}

	ZO_ENUM zo = ZO_NONE;

	DB_POINT unused = {0, 0};
	if (intersect(rhs, unused)) zo = ZO_COLLIDE;

	// We may be completely inside the vector.
	// Check we have a closed object.

	if (m_closed)
	{
		// Loop over the points of the rhs vector.
		for (DB_ITR i = rhs.m_p.begin(); i != rhs.m_p.end(); ++i)
		{
			// Determine if this point is contained in the polygon.
			// Returns the number of times the target vector's borders
			// were crossed.
			int count = windingNumber(*i);
			if (count % 2 == 1) 
			{
				// A point is contained.
				zo = ZO_ENUM (zo | ZO_COLLIDE);
			}
			else if (count)
			{
				// Even count > 0.
				zo = ZO_ENUM (zo | ZO_ABOVE);
			}
		}
	}
	return zo;
}

/*
 * Determine if a point lies on a subvector.
 */		
bool CVector::pointOnLine(const DB_ITR &i, const DB_POINT &p) const
{
	/*
	 * In some cases, due to the finite capacity of variables, some
	 * points will not evaluate as being on the line even if algebraically
	 * they are.
	 */
	if ((p.y < i->y - CV_PRECISION) && (p.y < (i + 1)->y - CV_PRECISION) ||
		(p.y > i->y + CV_PRECISION) && (p.y > (i + 1)->y + CV_PRECISION) ||
		(p.x < i->x - CV_PRECISION) && (p.x < (i + 1)->x - CV_PRECISION) ||
		(p.x > i->x + CV_PRECISION) && (p.x > (i + 1)->x + CV_PRECISION)) 
	{
		// Bounding box check.
		return false;
	} 
	else 
	{
		// Evaluate the straight-line equation.
		if (isVertical(i)) 
		{
			if (p.x == i->x) return true;
		}
		else
		{
			if (dAbs(p.y - (gradient(i) * (p.x - i->x) + i->y)) < CV_PRECISION) return true;
		}
	}
	return false;
}

/*
 * Determine if a polygon contains a point (a CVector point, or any other).
 * Return the number of times the boundary was crossed - the "winding number" for z-ordering.
 */
int CVector::windingNumber(const DB_POINT p)
{
	/*
	 * Determine if a point lies within a polygon by counting the number
	 * of times a test vector from the point to the top of the board crosses 
	 * the polygon's boundaries. The vector must cross an odd number of 
	 * boundaries if the point is inside the polygon.
	 * We can also use this method to z-order sprites by their bases:
	 * If the sprite is "above" the vector on the screen, the boundaries
	 * will not be crossed.
	 * If the sprite is below the vector, the boundaries will be crossed
	 * (an even number of times).
	 */
	if (!m_closed) return 0;

	// Do a bounding box test for *this* point only.
	// (As opposed to the whole vector check in contains().)
	// Return 0 boundaries crossed for left, right or above.
	// Return 2 boundaries crossed for below.
	if ((p.x < m_bounds.left)  || 
		(p.x > m_bounds.right) ||
		(p.y < m_bounds.top)) return 0;
	if	(p.y > m_bounds.bottom) return 2;

	int count = 0; 
	for (DB_ITR i = m_p.begin(), j = m_p.end() - 2; i != m_p.end() - 1; j = i++)	
	{
		// Check the point is in the column created by the vector.
		// Node intersections and vertical lines are handled by these conditions.
		if ((j->x <= p.x && i->x > p.x) || (i->x <= p.x && j->x > p.x))
		{
			// Calculate intersection point of the subvector and a
			// vertical vector from the point to the top of the board.
			// y = mx + c
			const double y = (p.x - i->x) * (j->y - i->y) / (j->x - i->x) + i->y;

			// If the point is below the line, increment the count.
			if (p.y > y) ++count;
		}
	} // for (i)

	return count;
}

/*
 * Create a mask by drawing a closed area and flooding.
 * (Currently using the GDI).
 */
bool CVector::createMask(CCanvas *cnv, const int x, const int y, CONST LONG color)
{
	// Can't create a mask from an open vector (or a null canvas).
	if (!m_closed || !cnv) return false;

	// Could end up drawing lines off the canvas.
	if (x > m_bounds.left || y > m_bounds.top) return false;

	// Set up to draw using GDI.
	CONST HDC hdc = cnv->OpenDC();
	HPEN pen = CreatePen(0, 1, color);
	HGDIOBJ m = SelectObject(hdc, pen);

	// Draw the bounding box.
	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)
	{
		if (i != m_p.end() - 1)
		{
			MoveToEx(hdc, i->x - x, i->y - y, NULL);
			LineTo(hdc, (i + 1)->x - x, (i + 1)->y - y);
		}
	}
	SelectObject(hdc, m);
	DeleteObject(pen);

	// Flood the created area.
    HBRUSH brush = CreateSolidBrush(color);
    m = SelectObject(hdc, brush);

	// Find a point that is contained in the vector.
	// Work down a vertical line along the centre of the vector
	// and check if the point is both contained in the vector and
	// is not on the outline (if GetPixel returns the same colour as
	// we're flooding with, the flood won't work).

	// This won't work for vectors whose lines cross to form multiple
	// enclosures, but the user can achieve the desired effect by
	// converting to the vector to two or more vectors.

	DB_POINT p = {int((m_bounds.left + m_bounds.right) / 2), m_bounds.top};
	for (; p.y != m_bounds.bottom; ++p.y)
	{
		if (containsPoint(p) && (GetPixel(hdc, int(p.x - x), int(p.y - y)) != color))
		{
			ExtFloodFill(hdc, p.x - x, p.y - y, color, FLOODFILLBORDER);
			break;
		}
	}

	SelectObject(hdc, m);
	DeleteObject(brush);

	cnv->CloseDC(hdc);

	return true;
}

/*
 * Draw the vector / polygon onto a canvas, offset by x,y. 
 */
void CVector::draw(CONST LONG color, const bool drawText, const int x, const int y, CCanvas *const cnv)
{
	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)
	{
		if (i != m_p.end() - 1)
		{
			cnv->DrawLine(i->x - x, i->y - y, (i + 1)->x - x, (i + 1)->y - y, color);
		}

		// Draw the co-ordinates for each corner.
		if (drawText)
		{
			STRING text; 
			char c[5]; 
			text = gcvt(i->x, 5, c);
#ifdef _UNICODE
			text = getUnicodeString(text);
#endif
			cnv->DrawText(i->x - x, i->y - y, text, _T("Arial"), 10, color);
			text = gcvt(i->y, 5, c);
#ifdef _UNICODE
			text = getUnicodeString(text);
#endif
			cnv->DrawText(i->x - x, i->y - y + 8, text, _T("Arial"), 10, color);
		}
	}
}

/*
 * Estimate which area is "inside" the polygon created 
 * by the vector (if a polygon exists).
 */
int CVector::estimateCurl(void)
{
	/*
	 * The curl is a measure of the direction of movement around a
	 * closed vector. It is found by taking the cross product of the
	 * bottom right-hand corner - this is always convex. The curl of 
	 * an open vector is undefined.
	 *
	 * Right curl is defined as anti-clockwise movement of subvectors.
	 * Left curl is defined as clockwise movement of subvectors.
	 */

	// Push the 2nd point onto the end in order to evaluate the last corner.
	m_p.push_back(*(m_p.begin() + 1));
	
	// Find the bottom right corner.
	DB_POINT corner = {0, 0};
	for (DB_ITR i = m_p.begin() + 1; i != m_p.end() - 1; ++i)
	{
		if (i->y > corner.y || (i->y == corner.y && i->x > corner.x))
		{
			corner = *i;
		}
	}
	// Remove the extra point.
	m_p.pop_back();

	// Dimensions of vectors.
	const DB_POINT  a = {i->x - (i - 1)->x, i->y - (i - 1)->y},
					b = {(i + 1)->x - i->x, (i + 1)->y - i->y};

	return ((a.x * b.y - a.y * b.x > 0) ? CURL_RIGHT : CURL_LEFT);
}

/*
 * Calculate gradient. Return GRAD_INF for vertical lines
 * (need something other than zero for gradient comparisons).
 */				
inline double CVector::gradient(const DB_ITR &i) const
{
	// Avoid divide by zero.
	if (isVertical(i)) return GRAD_INF;

	return (((i + 1)->y - i->y) / ((i + 1)->x - i->x));
}

/*
 * Calculate Y-axis intercept, c = y - mx.
 */
double CVector::intercept(const DB_ITR &i) const
{
	// Avoid vertical lines - return (unless other?).
	if (isVertical(i)) return 0;

	return (i->y - (gradient(i) * i->x));
}

/*
 * Determine if a CVector intersects this CVector.
 * Return a point that represents the intersecting subvector
 * as a position vector for use in sliding tests, etc.
 */
bool CVector::intersect(CVector &rhs, DB_POINT &ref)
{
	// Check the rhs vector.
	if (&rhs == this) return false;

	DB_POINT unused = {0, 0};

	// Loop over the subvectors in this vector (to size() - 1).
	for (DB_ITR i = m_p.begin(); i != m_p.end() - 1; ++i)	
	{
		if (intersect(i, rhs, unused))
		{
			/*
			 * Return a point that represents this board's subvector
			 * as a position vector (i.e. with origin at 0, 0), so
			 * that we can test for one-way movement and collision
			 * angle with the velocity vector.
			 */
			ref.x = (i + 1)->x - i->x;
			ref.y = (i + 1)->y - i->y;
			return true;
		}
	} // for (i)

	return false;
}

/* Internal function to be contained in a loop over a DB_ITR */

/*
 * Determine if a CVector intersects this CVector.
 * Return the point of intersection (passed in).
 */
bool CVector::intersect(DB_ITR &i, CVector &rhs, DB_POINT &ref)
{
	const double m1 = gradient(i), c1 = i->y - (m1 * i->x);

	// Loop over the subvectors in the target vector.
	for (DB_ITR j = rhs.m_p.begin(); j != rhs.m_p.end() - 1; ++j)	
	{
		if (*j == *i || *j == *(i + 1)) 
		{ 
			ref = *j; 
			return true; 
		}
		// Calculate gradient, intercept.
		const double m2 = rhs.gradient(j), c2 = j->y - (m2 * j->x);

		// Skip this subvector if lines are parallel.
		if (dAbs(m1 - m2) < CV_PRECISION) continue;

		// Deal with vertical lines.
		if (isVertical(i)) 
		{
			ref.x = i->x;
			ref.y = m2 * ref.x + c2;
		} 
		else if (rhs.isVertical(j)) 
		{
			ref.x = j->x;
			ref.y = m1 * ref.x + c1;
		} 
		else 
		{
			// Solve the equations.
			ref.x = (c2 - c1) / (m1 - m2);
			// Unless m2 is 0, use m1 as it is more likely to be more simply shaped.
			ref.y = (!m2 ? c2 : m1 * ref.x + c1);
		}

		// Determine if this point lies on either line.
		if ((pointOnLine(i, ref)) && (rhs.pointOnLine(j, ref)))
		{
			// Return the point of intersection.
			return true;
		}
	} // for (j)

	return false;
}

/* CPfVector: Pathfinding functions */

/*
 * Path-find ::contains() equivalent.
 */
bool CPfVector::contains(CPfVector &rhs)
{
	/*
	 * pathfinding: the nodes of the path are corners of the
	 * board vectors, so standard collision detection will always
	 * block movement at these points.
	 * But the pf vectors have been grown and we want to allow
	 * movement between consecutive points on the vector.
	 */

	// Do a bounding box test for the entire rhs vector.
	if ((rhs.m_bounds.right < m_bounds.left) ||
		(rhs.m_bounds.left > m_bounds.right) ||
		(rhs.m_bounds.bottom < m_bounds.top) ||
		(rhs.m_bounds.top > m_bounds.bottom))
	{
		return false;
	}

	// rhs should only comprise two points.
	if (rhs.size() != 2) return false;
	const DB_POINT start = rhs.m_p.front(), end = rhs.m_p.back();

	DB_ITR first = NULL, last = NULL;

	// Loop over the subvectors in this vector (to size() - 1).
	for (DB_ITR i = m_p.begin(); i != m_p.end() - 1; ++i)	
	{
		// Check if *both* of the points of the rhs vector are in this vector.
		if (*i == start || *i == end)
		{
			if (!first) first = i;
			else
			{
				last = i;
				// There are two points on the vector.
				// Are they consecutive? If so, we can move between them.
				// If one of the points is concave, we can also move to
				// the next point.

				if (last - first == 1 || last - first == (m_p.end() - 2) - m_p.begin())
					// Consecutive.
					return false;

				// See if the midpoint of the path is in the vector.
				// Whilst this is not enough on its own, it's half.
				const DB_POINT d = {(start.x + end.x) / 2,
									(start.y + end.y) / 2};
				if (containsPoint(d)) return true;

				// See if the path crosses the vector anywhere -
				// include in second loop.
				break;

			} // (*i == first)
		} // if (either point on vector)
	} // for (i)

	// Repeat, knowing if a node is on this vector.
	for (i = m_p.begin(); i != m_p.end() - 1; ++i)	
	{
		DB_POINT p = {0, 0};
		// Do the two lines cross?
		if (intersect(i, rhs, p))
		{
			// Check if the intersect point is on the vector.
			DB_POINT a = first ? *first : *i, b = {-1, -1};
			b = last ? *last : (first ? b : *(i + 1));

			if ((dAbs(p.x - a.x) > CV_PRECISION || dAbs(p.y - a.y) > CV_PRECISION) &&
				(dAbs(p.x - b.x) > CV_PRECISION || dAbs(p.y - b.y) > CV_PRECISION))
				return true;
		}
	} // for (i)

	// There are 2 or 0 nodes on the vector and the line does not intersect the vector.
	if (!first || last)	return false;

	// There is one node on the vector - is the other inside the vector?
	return (*first == end ? containsPoint(start) : containsPoint(end));

}

/*
 * Expand the vector radially outwards by a number of pixels.
 */
void CPfVector::grow(const int offset)
{
	/*
	 * For pathfinding each point must be offset so a sprite
	 * can navigate around the obstruction.
	 * For an arbitrary vector, each point can be offset along
	 * its bisector, or two points can be created extended from
	 * the end of each incident vector.
	 * For an open vector, a closed vector is formed around it.
	 */

	// Store the new points separately so we can work on the originals.
	std::vector<DB_POINT> p;

	if (!m_closed)
	{
		// Create a closed vector from the open vector to expand.
		// Add each point to m_p in reverse to close.
		p = m_p;
		for (std::vector<DB_POINT>::reverse_iterator i = p.rbegin() + 1; i != p.rend(); ++i)
		{
			m_p.push_back(*i);
		}
		p.clear();

		m_curl = estimateCurl();
	}
	// Push the second point so we can start from begin()++ and
	// go up to end()--. The last point of a closed vector is a 
	// copy of the  first point.
	m_p.push_back(*(m_p.begin() + 1));

	for (DB_ITR i = m_p.begin() + 1; i != m_p.end() - 1; ++i)
	{
		// Create points at the extensions of each vector or on the
		// the internal bisector: Dimensions of vectors.
		const DB_POINT  a = {i->x - (i - 1)->x, i->y - (i - 1)->y},
						b = {(i + 1)->x - i->x, (i + 1)->y - i->y};
		DB_POINT pt = *i;

		// Cross the vectors and calculate the normal.
		// If the normal is -ve, the corner is right-curl convex.
		// If the normal is +ve, the corner is left-curl convex.
		const int curl = sgn(a.x * b.y - a.y * b.x);
		if (curl == CURL_NDEF)
		{
			// Parallel lines.
			if (m_closed) continue;

			// Place two points diagonally.
			// Parallel extension.
			extendPoint(pt, a, offset);
			DB_POINT q = pt;

			// Perpendicular extension.
			const DB_POINT c = {-a.y, a.x};
			extendPoint(q, c, offset);
			p.push_back(q);

			q = pt;
			const DB_POINT d = {a.y, -a.x};
			extendPoint(q, d, offset);
			p.push_back(q);
		}
		else if (curl == m_curl)
		{
			// Form a small triangle from i-1, i, i+1 by joining short
			// vectors parallel to i-1 and i+1.
			// The bisector is *approximately* the line joining the 
			// the midpoint of the third side to i.
			DB_POINT m = *i, n = *i;
			extendPoint(m, b, offset);

			const DB_POINT c = {-a.x, -a.y};
			extendPoint(n, c, offset);

			m.x = pt.x - (m.x + n.x) / 2;
			m.y = pt.y - (m.y + n.y) / 2;
			extendPoint(pt, m, offset);
			p.push_back(pt);
		}
		else
		{
			// Concave.
			// Form a triangle from i-1, i, i+1 by joining i-1 to i+1.
			// The bisector is *approximately* the line joining the 
			// the midpoint of the third side.
			const DB_POINT c = {((i - 1)->x + (i + 1)->x) / 2 - i->x,
								((i - 1)->y + (i + 1)->y) / 2 - i->y};
			extendPoint(pt, c, offset);
			p.push_back(pt);
		}
	}

	// Push the first point onto the back to close the vector.
	p.push_back(p.front());

	m_p.swap(p);

	m_closed = true;

	// Expand the bounding rectangle.
	boundingBox(m_bounds);
}

#if(0)
void CPfVector::grow(const int offset)
{
	// Offset each point depending on its position relative to the centre.

	const DB_POINT centre = { (m_bounds.left + m_bounds.right) * 0.5,
							  (m_bounds.top + m_bounds.bottom) * 0.5};

	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)
	{
		// The nodes need to be offset from the vector points so that
		// they do not interfere with collision checks and sprites
		// can reach them.
		const int x = sgn(i->x - centre.x), y = sgn(i->y - centre.y);

		i->x += x * offset;
		i->y += y * offset;
	}

	// Expand the bounding rectangle.
	m_bounds.left -= r.left;
	m_bounds.right += r.right;
	m_bounds.top -= r.top;
	m_bounds.bottom += r.bottom;
}
#endif

/*
 * Construct CPathFind nodes from a CVector and add to the nodes vector.
 */
void CPfVector::createNodes(std::vector<DB_POINT> &points, const DB_POINT max)
{
	for (DB_ITR i = m_p.begin(); i != m_p.end(); ++i)
	{
		if (i->x > 0 && i->y > 0 && i->x < max.x && i->y < max.y) 
		{
			points.push_back(*i);
		}
	}
}

/*
 * Find the nearest point on the edge of a vector to a point.
 */
DB_POINT CPfVector::nearestPoint(const DB_POINT start)
{
	// Take a perpendicular line to each vector and intersect()
	// to give point, or find nearest point.

	const int PX_OFFSET = 1;
	DB_POINT best = {0, 0};

	for (DB_ITR i = m_p.begin(); i != m_p.end() - 1; ++i)
	{
		DB_POINT p = {0, 0};

		if (pointOnLine(i, start))
		{
			// This will be the nearest point and we can break now.
			p = start;
			// Perpendicular line.
			DB_POINT d = {i->y - (i + 1)->y, (i + 1)->x - i->x};
			extendPoint(p, d, PX_OFFSET);
			if (containsPoint(p))
			{
				// Extended on the wrong side!
				p = start;
				d.x = -d.x; d.y = -d.y;
				extendPoint(p, d, PX_OFFSET);
			}
			return p;
		}

		if (isVertical(i)) 
		{
			p.x = i->x;
			p.y = start.y;
		} 
		else if (i->y == (i + 1)->y) 
		{
			// Horizontal
			p.x = start.x;
			p.y = i->y;
		} 
		else 
		{
			// Solve the equations.
			const double m1 = gradient(i), c1 = i->y - (m1 * i->x);
			const double m2 = -1 / m1, c2 = start.y - (m2 * start.x);

			p.x = (c2 - c1) / (m1 - m2);
			p.y = m1 * p.x + c1;
		}

		if (!pointOnLine(i, p))
		{
			// If the perpendicular point is not on the line, 
			// take the nearest node.
			const double j = dAbs(start.x - i->x) + dAbs(start.y - i->y),
					     k = dAbs(start.x - (i + 1)->x) + dAbs(start.y - (i + 1)->y);
			p = (j < k) ? *i : *(i + 1);
		}

		// Keep nearest point.
		const double j = dAbs(start.x - p.x) + dAbs(start.y - p.y),
					 k = dAbs(start.x - best.x) + dAbs(start.y - best.y);

		if (j < k) best = p;

	} // for (i)

	// Offset best a little to prevent pfContains() blocking vectors to it.
	const DB_POINT d = {best.x - start.x, best.y - start.y};
	extendPoint(best, d, PX_OFFSET);

	return best;
}

/*
 * Extend a point 'a' at the end of a (position) vector 'd' by 'offset' pixels.
 */
void CPfVector::extendPoint(DB_POINT &a, const DB_POINT &d, const int offset)
{
	const double grad = (!d.x ? GRAD_INF : dAbs(d.y / d.x));

	if (dAbs(grad) < 1)
	{
		a.x += sgn(d.x) * offset; 
		a.y += sgn(d.y) * offset * grad;
	}
	else
	{
		a.x += sgn(d.x) * offset / grad;
		a.y += sgn(d.y) * offset;
	}
}