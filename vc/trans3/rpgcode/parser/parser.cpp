/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

/*
 * Implementation of string parsing functions.
 */

/*
 * Inclusions
 */
#include "parser.h"

/*
 * Trim whitespace from the sides of a string.
 *
 * str (in) - string to trim
 * return (out) - trimmed string
 */
STRING parser::trim(const STRING str)
{
	const int len = str.length();
	if (len == 0) return _T("");
	int start = -1, end = -1;
	for (int i = 0; i < len; i++)
	{
		if (str[i] != _T(' ') && str[i] != _T('\t'))
		{
			start = i;
			break;
		}
	}
	if (start == -1) return _T("");
	for (int j = len - 1; j >= 0; j--)
	{
		if (str[j] != _T(' ') && str[j] != _T('\t'))
		{
			end = j + 1 - start;
			break;
		}
	}
	return str.substr(start, end);
}
