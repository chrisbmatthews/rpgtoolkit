//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////////////////////
// CUtil.h
// Implementation for filename and path functions
// Developed for v2.19b (Dec 2001 - Jan 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////////////////////

//===============================================
// Alterations Delano for 3.0.4 
// For new isometric tile system
//
// CUtil::tilesetFilename
// CUtil::tileExists
//===============================================


#include <windows.h>
#include "CUtil.h"

/////////////////////////////////////////////////
// CUtil::getExt (static)
//
// Action: return the extension of a filename (without the .)
//
// Params: strFile - filename to parse
//
// Returns: 3 character extension.
////////////////////////////////////////////////
std::string CUtil::getExt(std::string strFile)
{
	std::string strToRet = "";

	int nExtPos = strFile.rfind(".");

	strToRet = strFile.substr(nExtPos+1, 3);

	return strToRet;
}


/////////////////////////////////////////////////
// CUtil::upperCase (static)
//
// Action: convert a string to upper case
//
// Params: strString - string to parse
//
// Returns: upper case string
////////////////////////////////////////////////
std::string CUtil::upperCase(std::string strString)
{
	std::string strToRet = "";

	for (int c = 0; c < strString.length(); c++)
	{
		strToRet += toupper(strString.at(c));
	}

	return strToRet;
}


///////////////////////////////////////////////////////
//
// CUtil::getTileNum (static)
//
// Parameters: strFilename - the filename
//
// Action: gets the tile number from a tileset filename
//
// Returns: the number
//
///////////////////////////////////////////////////////
int CUtil::getTileNum (std::string strFilename) 
{
	//determine tile number from tst filename
	//ie. tileset.tst48 returns 48
	//return -1 on failure.
	int length = strFilename.length();
	
	for (int t=0;t<length;t++) 
	{
		if (strFilename.at(t) == '.') 
		{
			char num[255];
			int cnt=0;
			for (int x=t+4;x<length;x++) 
			{
				num[cnt]=strFilename.at(x);
				num[cnt+1]='\0';
				cnt++;
			}
			int toReturn=atoi(num);
			return toReturn;
		}
	}
	return -1;
}


///////////////////////////////////////////////////////
//
// CUtil::tilesetFilename (static)
//
// Parameters: strFilename- the filename
//
// Action: extract filename from a tst filename
//
// Returns: the filename
//
//=====================================================
// Edited for 3.0.4 by Delano
// Added .iso recognition.
//=====================================================
///////////////////////////////////////////////////////

std::string CUtil::tilesetFilename(std::string strFilename) 
{
	//returns filename w/out the number after ext
	std::string strToRet = "";


	int nExtPos = strFilename.rfind(".");

	strToRet = strFilename.substr(0, nExtPos+1);

	std::string strExt;
	strExt = getExt(strFilename);

	strToRet += strExt;
	return strToRet;

}


///////////////////////////////////////////////////////
//
// CUtil::tileExists (static)
//
// Parameters: strFilename- the filename
//
// Action: determine if a tile exists (even if it's amangled tst name)
//
// Returns: t / f
//
//=====================================================
// Edited for 3.0.4 by Delano
// Added .iso recognition.
//=====================================================
///////////////////////////////////////////////////////

bool CUtil::tileExists(std::string strFilename)
{
	std::string ext = upperCase(getExt(strFilename));

	//Added "ISO
	if ((ext.compare("TST") == 0) || (ext.compare("ISO") == 0))
	{
		strFilename = tilesetFilename(strFilename);
	}

	//check if file exists
	FILE* f = fopen(strFilename.c_str(), "r");
	if (!f)
	{
		return false;
	}
	else
	{
		fclose(f);
		return true;
	}
}


///////////////////////////////////////////////////////
//
// CUtil::rgb (static)
//
// Parameters: red, green, blue- color
//
// Action: converts color compnents to an rgb color
//
// Returns: rgb color
//
///////////////////////////////////////////////////////
long CUtil::rgb ( int red, 
					 int green, 
					 int blue ) 
{
	if (red>255) red=255;
	if (red<0) red=0;
	if (green>255) green=255;
	if (green<0) green=0;
	if (blue>255) blue=255;
	if (blue<0) blue=0;
	return RGB(red,green,blue);
}


///////////////////////////////////////////////////////
//
// Function: red, green and blue
//
// Parameters: rgb- a long color
//
// Action: converts color to compnents
//
// Returns: component
//
///////////////////////////////////////////////////////
int CUtil::red ( long rgb ) 
{
	//returns red component of rgb value.
	/*int bluecomp=(int)(rgb/65536);
	long takeaway=bluecomp*65536;
	rgb-=takeaway;

	int greencomp=(int)(rgb/256);
	takeaway=greencomp*256;

	int redcomp=rgb-takeaway;
	return redcomp;*/
	return GetRValue(rgb);
}
int CUtil::green ( long rgb ) 
{
	//returns green component of rgb value.
	/*int bluecomp=(int)(rgb/65536);
	long takeaway=bluecomp*65536;
	rgb-=takeaway;

	int greencomp=(int)(rgb/256);
	return greencomp;*/
	return GetGValue(rgb);
}
int CUtil::blue ( long rgb ) 
{
	//returns blue component of rgb value.
	/*int bluecomp=(int)(rgb/65536);
	return bluecomp;*/
	return GetBValue(rgb);
}


