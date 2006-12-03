/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin Fitzpatrick
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
 * Protect the header.
 */
#ifndef _PARSER_H_
#define _PARSER_H_

/*
 * Inclusions
 */
#include <vector>
#include "../../../tkCommon/strings.h"

/*
 * String parsing functions.
 */
namespace parser
{

	STRING trim(const STRING str);

	inline STRING uppercase(const STRING str)
	{
		char *pstr = _tcsupr(_tcsdup(str.c_str()));
		const std::string toRet = pstr;
		free(pstr);
		return toRet;
	}

}

#endif
