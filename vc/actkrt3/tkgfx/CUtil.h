//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////
// CUtil.h
// Definition for filename and path functions
// Developed for v2.19b (Dec 2001 - Jan 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////

#ifndef _CUTIL_H_
#define _CUTIL_H_

#include <string>


class CUtil
{
	public:
		static std::string getExt(std::string strFile);
		static std::string upperCase(std::string strString);
		static int getTileNum(std::string strFilename);
		static std::string tilesetFilename(std::string strFilename);
		static bool tileExists(std::string strFilename);
		static long rgb ( int red, int green, int blue );
		static int red ( long rgb );
		static int green ( long rgb );
		static int blue ( long rgb );
};

#endif