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

namespace util
{
	std::string getExt(std::string strFile);
	std::string upperCase(std::string strString);
	int getTileNum(std::string strFilename);
	std::string tilesetFilename(std::string strFilename);
	bool tileExists(std::string strFilename);
	long rgb(int red, int green, int blue);
	int red(long rgb);
	int green(long rgb);
	int blue(long rgb);
};

#endif
