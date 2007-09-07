/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
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

#ifndef _CUTIL_H_
#define _CUTIL_H_

#include <string>

#define WIN32_MEAN_AND_LEAN
#include <windows.h>

namespace util
{
	inline std::string getExt(std::string strFile);
	inline std::string upperCase(std::string strString);
	inline int getTileNum(std::string strFilename);
	inline std::string tilesetFilename(std::string strFilename);
	inline bool tileExists(std::string strFilename);
	inline long rgb(int red, int green, int blue);
	inline int red(long rgb);
	inline int green(long rgb);
	inline int blue(long rgb);
	std::string binReadString(CONST HFILE hFile, LPOVERLAPPED ptr);
};

/////////////////////////////////////////////////
// util::upperCase (static)
//
// Action: convert a string to upper case
//
// Params: strString - string to parse
//
// Returns: upper case string
////////////////////////////////////////////////
inline std::string util::upperCase(std::string strString)
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
// util::getTileNum (static)
//
// Parameters: strFilename - the filename
//
// Action: gets the tile number from a tileset filename
//
// Returns: the number
//
///////////////////////////////////////////////////////
inline int util::getTileNum (std::string strFilename) 
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
// util::tilesetFilename (static)
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

inline std::string util::tilesetFilename(std::string strFilename) 
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
// util::tileExists (static)
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

inline bool util::tileExists(std::string strFilename)
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
// util::rgb (static)
//
// Parameters: red, green, blue- color
//
// Action: converts color compnents to an rgb color
//
// Returns: rgb color
//
///////////////////////////////////////////////////////
inline long util::rgb ( int red, 
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
inline int util::red ( long rgb ) 
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
inline int util::green ( long rgb ) 
{
	//returns green component of rgb value.
	/*int bluecomp=(int)(rgb/65536);
	long takeaway=bluecomp*65536;
	rgb-=takeaway;

	int greencomp=(int)(rgb/256);
	return greencomp;*/
	return GetGValue(rgb);
}
inline int util::blue ( long rgb ) 
{
	//returns blue component of rgb value.
	/*int bluecomp=(int)(rgb/65536);
	return bluecomp;*/
	return GetBValue(rgb);
}

/////////////////////////////////////////////////
// util::getExt (static)
//
// Action: return the extension of a filename (without the .)
//
// Params: strFile - filename to parse
//
// Returns: 3 character extension.
////////////////////////////////////////////////
inline std::string util::getExt(std::string strFile)
{
	std::string strToRet = "";

	int nExtPos = strFile.rfind(".");

	strToRet = strFile.substr(nExtPos+1, 3);

	return strToRet;
}

#endif
