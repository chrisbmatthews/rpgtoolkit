/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
