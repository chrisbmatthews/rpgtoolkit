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
#include <string>

/*
 * String parsing functions.
 */
namespace parser
{

	std::string trim(const std::string str);

	inline std::string uppercase(const std::string str)
	{
		char *pstr = _strupr(_strdup(str.c_str()));
		const std::string toRet = pstr;
		free(pstr);
		return toRet;
	}

}

#endif
