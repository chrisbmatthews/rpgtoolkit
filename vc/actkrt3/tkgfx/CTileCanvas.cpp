//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////
// CTileCanvas.h
// Implementation for an offscreen buffer for an rpgtoolkit tile
// Developed for v2.19b (Dec 2001 - Feb 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////

#include "CTileCanvas.h"

CTileCanvas::CTileCanvas(int nCompatibleDC, std::vector<RGBSHADE> vShadeList, int nShadeType)
{
	m_nCompatibleDC = nCompatibleDC;
	m_cnvForeground.CreateBlank((HDC)m_nCompatibleDC, 32, 32);

	m_vShadeList = vShadeList;
	m_nShadeType = nShadeType;
}

CTileCanvas::~CTileCanvas()
{
	m_vShadeList.clear();
}

CTileCanvas::CTileCanvas(const CTileCanvas& rhs)
{
	m_nCompatibleDC = rhs.m_nCompatibleDC;
	m_cnvForeground = rhs.m_cnvForeground;

	m_vShadeList = rhs.m_vShadeList;
	m_nShadeType = rhs.m_nShadeType;
}

CTileCanvas& CTileCanvas::operator=(const CTileCanvas& rhs)
{
	m_vShadeList.clear();

	m_nCompatibleDC = rhs.m_nCompatibleDC;
	m_cnvForeground = rhs.m_cnvForeground;

	m_vShadeList = rhs.m_vShadeList;
	m_nShadeType = rhs.m_nShadeType;

	return (*this);
}


//deterine if this tile is shaded in a particular way...
bool CTileCanvas::isShadedAs(int hdc, std::vector<RGBSHADE> vShadeList, int nShadeType)
{
	bool bRet = false;
	if (hdc != m_nCompatibleDC)
	{
		return false;
	}
	if (nShadeType != m_nShadeType)
	{
		bRet = false;
	}
	else
	{
		if (m_vShadeList.size() != vShadeList.size())
		{
			bRet = false;
		}
		else
		{
			bRet = true;
			for (int i = 0; i < m_vShadeList.size(); i++)
			{
				RGBSHADE r1 = m_vShadeList[i];
				RGBSHADE r2 = vShadeList[i];
				if (r1.r == r2.r && r1.g == r2.g && r1.b == r2.b)
				{
					bRet = true;
				}
				else
				{
					bRet = false;
					break;
				}
			}
		}
	}
	return bRet;
}


bool CTileCanvas::isStillInMem()
{
	/*if (m_cnvForeground.GetHDC())
	{
		return true;
	}
	else
	{
		return false;
	}*/
	return true;
}


//re-init offscreen buffer
void CTileCanvas::reallocate(int hdc)
{
	m_nCompatibleDC = hdc;
	m_cnvForeground.CreateBlank((HDC)m_nCompatibleDC, 32, 32);
}
