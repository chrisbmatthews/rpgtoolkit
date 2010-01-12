/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Jonathan D. Hughes
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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

//--------------------------------------------------------------------------
// Board light rendering routines
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#include "lighting.h"
#include <math.h>

//--------------------------------------------------------------------------
// Cast a BRD_LIGHT onto a matrix.
//--------------------------------------------------------------------------
VOID calculateLighting(RGB_MATRIX &shades, CONST BRD_LIGHT &bl, CONST COORD_TYPE coordType, CONST INT brdSizeX)
{
	switch (bl.eType)
	{
		case (BL_ELLIPSE):
		{
			// bl.nodes(1) defines centre.
			// |bl.nodes(1) - bl.nodes(0)|, |bl.nodes(1) - bl.nodes(2)| 
			// defines semi-major and semi-minor axes (whichever is longer/shorter respectively).
			// bl.colors(1) defines color at centre,
			// bl.colors(0) defines color at edge.

			if (bl.nodes.size() != 3 || bl.colors.size() < 2) return;

			// Semi-major and semi-minor axes.
			CONST DOUBLE axes[] = {
				sqrt(static_cast<DOUBLE>(
					(bl.nodes[1].x - bl.nodes[0].x) * (bl.nodes[1].x - bl.nodes[0].x) +
					(bl.nodes[1].y - bl.nodes[0].y) * (bl.nodes[1].y - bl.nodes[0].y))
				),
				0,	// Padding.
				sqrt(static_cast<DOUBLE>(
					(bl.nodes[1].x - bl.nodes[2].x) * (bl.nodes[1].x - bl.nodes[2].x) +
					(bl.nodes[1].y - bl.nodes[2].y) * (bl.nodes[1].y - bl.nodes[2].y))
				)
			};
			if (!axes[0] || !axes[2]) return;

			// Indices of longer axis = major axis, shorter axis = minor.
			CONST LONG mj = (axes[0] > axes[2] ? 0 : 2), mn = (mj == 0 ? 2 : 0);

			// sin and cos of incline angle of ellipse semi-major axis.
			CONST DOUBLE sine = (bl.nodes[1].y - bl.nodes[mj].y) / axes[mj], cosine = (bl.nodes[1].x - bl.nodes[mj].x) / axes[mj];

			for (INT i = 1; i != shades.size(); ++i)
			{
				for (INT j = 1; j != shades[0].size(); ++j)
				{
					// Coordinate transforms.
					INT bx = i, by = j;
					coords::tileToPixel(bx, by, COORD_TYPE(coordType & ~PX_ABSOLUTE), FALSE, brdSizeX);

					// Intercept of line passing through nodes[1] and i, j.
					// (x/a)^2 + (y/b)^2 = 1
					// y = mx + c

					// Origin at nodes[1] (so that c = 0).
					CONST DOUBLE x = bx - bl.nodes[1].x, y = by - bl.nodes[1].y;

					// Rotate to align with the ellipse's axes.
					CONST DOUBLE xp = x * cosine + y * sine;
					CONST DOUBLE yp = y * cosine - x * sine;

					// Calculate ratio of x, y to intercept point to create
					// a fraction mixing the outer and inner colours.
					DOUBLE fraction = 0.0;

					if (xp == 0.0)
					{
						// Vertical - take ratio to semi-minor axis.
						fraction = yp / axes[mn];
					}
					else
					{
						CONST DOUBLE m = yp / xp;

						// Intercept point (rearrange equations).
						CONST DOUBLE xi = axes[mj] * axes[mn] / sqrt(axes[mn] * axes[mn] + (m * m) * (axes[mj] * axes[mj]));
						CONST DOUBLE yi = m * xi;

						fraction = sqrt((xp * xp + yp * yp) / (xi * xi + yi * yi));
					}
					if (fraction < 0.0) fraction = -fraction;

					// Apply shading to points inside the ellipse.
					if (fraction < 1.0)
					{
						shades[i][j].r += fraction * bl.colors[0].r + (1.0 - fraction) * bl.colors[1].r;
						shades[i][j].g += fraction * bl.colors[0].g + (1.0 - fraction) * bl.colors[1].g;
						shades[i][j].b += fraction * bl.colors[0].b + (1.0 - fraction) * bl.colors[1].b;
					}
				} // for(j)
			} // for(i)

		} // case(BL_SPOTLIGHT)

		case (BL_GRADIENT):
		case (BL_GRADIENT_CLIPPED):
		{
			// bl.nodes(0) - bl.nodes(1) defines gradient axis.
			// bl.colors(0) defines color at bl.nodes(0),
			// bl.colors(1) defines color at bl.nodes(1).

			if (bl.nodes.size() != 2 || bl.colors.size() < 2) return;

			// Node separation.
			CONST DOUBLE length = sqrt(static_cast<DOUBLE>(
				(bl.nodes[1].x - bl.nodes[0].x) * (bl.nodes[1].x - bl.nodes[0].x) +
				(bl.nodes[1].y - bl.nodes[0].y) * (bl.nodes[1].y - bl.nodes[0].y))
			);
			if (!length) return;

			// sin and cos of incline angle of gradient x-axis.
			CONST DOUBLE sine = (bl.nodes[1].y - bl.nodes[0].y) / length, cosine = (bl.nodes[1].x - bl.nodes[0].x) / length;

			for (INT i = 1; i != shades.size(); ++i)
			{
				for (INT j = 1; j != shades[0].size(); ++j)
				{
					// Coordinate transforms.
					INT bx = i, by = j;
					coords::tileToPixel(bx, by, COORD_TYPE(coordType & ~PX_ABSOLUTE), FALSE, brdSizeX);

					// Origin at nodes[0].
					CONST DOUBLE x = bx - bl.nodes[0].x, y = by - bl.nodes[0].y;

					// Projection onto gradient axis.
					CONST DOUBLE xp = x * cosine + y * sine;
					DOUBLE fraction = xp / length;

					// Bound to the node y-axes for full coverage gradient (not clipped).
					if (bl.eType == BL_GRADIENT)
					{
						fraction = (fraction < 0.0 ? 0.0 : (fraction > 1.0 ? 1.0 : fraction));
					}

					// To prevent shading past the node y-axes (clipped), only apply shading when (0 < fraction < 1).
					if (fraction >= 0.0 && fraction <= 1.0)
					{
						shades[i][j].r += fraction * bl.colors[1].r + (1.0 - fraction) * bl.colors[0].r;
						shades[i][j].g += fraction * bl.colors[1].g + (1.0 - fraction) * bl.colors[0].g;
						shades[i][j].b += fraction * bl.colors[1].b + (1.0 - fraction) * bl.colors[0].b;
					}
				}
			}
		} // case (BL_GRADIENTs)

	} // switch(bl.eType)

}

//--------------------------------------------------------------------------
// Call a method of a COM object through IDispatch.
//--------------------------------------------------------------------------
VARIANT invokeObject(CONST LPUNKNOWN pUnk, BSTR method, DISPPARAMS &dispparams, CONST WORD methodFlags)
{
	// Call QueryInterface() to see if the object supports IDispatch.
	LPDISPATCH pDisp = NULL;
	VARIANT result;
	result.vt = VT_EMPTY;
	if(pUnk->QueryInterface(IID_IDispatch, (LPVOID *)&pDisp) == S_OK)
	{
		// Retrieve the dispatch identifier for the method.
		DISPID dispid = NULL;
		if(pDisp->GetIDsOfNames(IID_NULL, &method, 1, NULL, &dispid) == S_OK)
		{
			pDisp->Invoke(
				dispid,						// Member identifier.
				IID_NULL,					// Reserved.
				NULL,						// Locale identifier.
				methodFlags,				// Method description flags.
				&dispparams,				// Parameters.
				&result,					// Return result.
				NULL, 
				NULL
			);
		}
		pDisp->Release();
	}
	return result;
}

//--------------------------------------------------------------------------
// Size a LAYER_SHADE
//--------------------------------------------------------------------------
void tagLayerShade::size(CONST INT width, CONST INT height)
{
	shades.clear();
	for (LONG i = 0; i <= width; ++i)
	{
		RGB_VECTOR row;
		CONST RGB_SHORT ts = {0, 0, 0};
		for (LONG j = 0; j <= height; ++j) row.push_back(ts);
		shades.push_back(row);
	}
}