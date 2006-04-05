/*
 * All contents copyright 2005, 2006 
 * Colin James Fitzpatrick & Jonathan D. Hughes.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */
#include "board conversion.h"
#include <malloc.h>

std::vector<CONV_POINT> tileToVector(
	const int x, 
	const int y, 
	const COORD_TYPE coordType)
{
	std::vector<CONV_POINT> vector;
	if (coordType & ISO_STACKED)
	{
		// Column offset (old co-ordinate system).
		const double dx = (y % 2 ? 0 : 32);

		// Isometric diamond at the location (3.0-).
		vector.push_back(CONV_POINT((x - 1.0) * 64.0 - dx, (y - 1.0) * 16.0));
		vector.push_back(CONV_POINT((x - 0.5) * 64.0 - dx, (y - 2.0) * 16.0));
		vector.push_back(CONV_POINT(x * 64.0 - dx, (y - 1.0) * 16.0));
		vector.push_back(CONV_POINT((x - 0.5) * 64.0 - dx, y * 16.0));
	}
	else if(coordType & ISO_ROTATED)
	{

	}
	else
	{
		// Create a 32x32 vector at the location.
		// Order: top-left, bot-left, bot-right, top-right.
		vector.push_back(CONV_POINT((x - 1.0) * 32.0, (y - 1.0) * 32.0));
		vector.push_back(CONV_POINT((x - 1.0) * 32.0, y * 32.0));
		vector.push_back(CONV_POINT(x * 32.0, y * 32.0));
		vector.push_back(CONV_POINT(x * 32.0, (y - 1.0) * 32.0));
	}
	return vector;
}

/*
 * Convert the tiletype array to vectors.
 *
 * Note: tiletype[y][x]
 */
std::vector<LPCONV_VECTOR> vectorizeLayer(
	const VECTOR_CHAR2D &tiletype,
	const unsigned int bSizeX,
	const unsigned int bSizeY,
	const COORD_TYPE coordType)
{
	std::vector<LPCONV_VECTOR> vectors;
	unsigned int i, j, width = bSizeX, height = bSizeY;

	if (coordType & ISO_STACKED)
	{
		// For old isometrics transform the layer to the rotated
		// co-ordinate system so we can apply the same routine.

		// Determine the transformed dimensions.
		double x = double(bSizeX), y = double(bSizeY);
		coords::isometricTransform(x, y, ISO_STACKED, ISO_ROTATED, bSizeX);

		// New iso board is effectively square but with many empty entries.
		width = height = (unsigned int)x;
	}

	bool *const pFinished = (bool *)_alloca(width * height);
	memset(pFinished, 0, width * height);

	// Local array of the tiletype.
	int *const pTypes = (int *)_alloca(width * height * sizeof(int));
	memset(pTypes, 0, width * height * sizeof(int));

	// Create a new array to work from (iso rotated, or the standard 2D).
	for (i = 0; i < bSizeX; ++i)
	{
		for (j = 0; j < bSizeY; ++j)
		{
			if (coordType & ISO_STACKED)
			{
				// Transform this co-ordinate.
				double x = double(i + 1), y = double(j + 1);
				coords::isometricTransform(x, y, ISO_STACKED, ISO_ROTATED, bSizeX);
				// Enter its type in the new array.
				pTypes[height * int(x - 1) + int(y - 1)] = tiletype[j + 1][i + 1];
			}
			else
			{
				// Just copy the value across.
				pTypes[height * i + j] = tiletype[j + 1][i + 1];
			}
		}
	}

	while (true)
	{
		/*
		 * Working southeast from the top-left corner, locate
		 * the first tile that is neither "normal" nor included
		 * in any vector.
		 */
		int x = -1, y, i, j;
		for (i = 0; i < width; ++i)
		{
			for (j = 0; j < height; ++j)
			{
				if (!pFinished[height * i + j] && pTypes[height * i + j])
				{
					// More effective method?
					x = i;
					y = j;
					i = width + 1;
					break;
				}
			}
		}
		// If there are none left, exit.
		if (x == -1) break;

		// Store current x and y, and the tile type as this position.
		int type = pTypes[height * x + y], origX = x, origY = y;

		// Find the lowest point where this type stops.
		while ((y < height) && (pTypes[height * x + y + 1] == type)) y++;

		while (x < width)
		{
			/*
			 * Check whether this column, to the height of the first
			 * one found, contains the type of the current vector.
			 */
			bool column = true;
			for (i = origY; i <= y; i++)
			{
				if (pTypes[height * (x + 1) + i] != type)
				{
					// It doesn't, so stop here.
					column = false;
					break;
				}
			}
			if (!column) break;
			// Move onto the next column.
			x++;
		}

		// Increment to set up for vector creation.
		x++; y++;

		// Mark off the tiles in this rectangle as in a vector.
		for (i = origX; i < x; i++)
		{
			memset(pFinished + height * i + origY, 1, y - origY);
		}

		// Create the vector and add it to the board's list.

		if (coordType & ISO_STACKED)
		{
			// Order: top, left, bottom, right.
			LPCONV_VECTOR vector = new CONV_VECTOR(type);
			vector->pts.push_back(CONV_POINT((origX - origY + bSizeX) * 32, (origX + origY - bSizeX) * 16));
			vector->pts.push_back(CONV_POINT((origX - y + bSizeX) * 32, (origX + y - bSizeX) * 16));
			vector->pts.push_back(CONV_POINT((x - y + bSizeX) * 32, (x + y - bSizeX) * 16));
			vector->pts.push_back(CONV_POINT((x - origY + bSizeX) * 32, (x + origY - bSizeX) * 16));
			vectors.push_back(vector);
		}
		else
		{
			if (type == NORTH_SOUTH)
			{
				// vector->type = TT_SOLID;
				// Vertical lines.
				for (i = origX; i <= x; ++i)
				{
					LPCONV_VECTOR vector = new CONV_VECTOR(type);
					vector->pts.push_back(CONV_POINT(i * 32, origY * 32));
					vector->pts.push_back(CONV_POINT(i * 32, y * 32));
					vectors.push_back(vector);
				}
			}
			else if (type == EAST_WEST)
			{
				// vector.type = TT_SOLID;
				// Horizontal lines.
				for (i = origY; i <= y; ++i)
				{
					LPCONV_VECTOR vector = new CONV_VECTOR(type);
					vector->pts.push_back(CONV_POINT(origX * 32, i * 32));
					vector->pts.push_back(CONV_POINT(x * 32, i * 32));
					vectors.push_back(vector);
				}
			}
			else
			{
				// Order: top-left, bot-left, bot-right, top-right.
				LPCONV_VECTOR vector = new CONV_VECTOR(type);
				vector->pts.push_back(CONV_POINT(origX * 32, origY * 32));
				vector->pts.push_back(CONV_POINT(origX * 32, y * 32));
				vector->pts.push_back(CONV_POINT(x * 32, y * 32));
				vector->pts.push_back(CONV_POINT(x * 32, origY * 32));
				vectors.push_back(vector);
			}
		}
	}
	return vectors;
}
