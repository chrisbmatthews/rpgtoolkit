//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/////////////////////////////////////////////////
// util.h
// Implementation for filename and path functions
// Developed for v2.19b (Dec 2001 - Jan 2002)
// Copyright 2002 by Christopher B. Matthews
/////////////////////////////////////////////////

//===============================================
// Alterations Delano for 3.0.4 
// For new isometric tile system
//
// util::tilesetFilename
// util::tileExists
//===============================================


#include <windows.h>
#include "CUtil.h"

//
// Read a binary string
//
std::string util::binReadString(CONST HFILE hFile, LPOVERLAPPED ptr)
{
	bool bDone = false;		// Done?
	std::string toRet;		// String to return
	while (!bDone)
	{
		// Read a character
		char chr;
		DWORD read;
		ReadFile(HANDLE(hFile), &chr, 1, &read, ptr);
		ptr->Offset++;
		if (chr == '\0')
		{
			// All done
			bDone = true;
		}
		else
		{
			// Append to return string
			toRet += chr;
		}
	}
	// Return the result
	return toRet;
}



