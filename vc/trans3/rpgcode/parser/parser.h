/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
