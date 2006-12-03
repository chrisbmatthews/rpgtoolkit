/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
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
 */

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



