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
 */

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



