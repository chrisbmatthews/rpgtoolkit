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

	/*
	 * Eat whitespace from a string.
	 *
	 * str (in) - str to eat from
	 * bIgnore (out) - ignore within quotes?
	 */
	std::string eatWhitespace(const std::string str, const bool bIgnore = false);

	/*
	 * Trim whitespace from the sides of a string.
	 *
	 * str (in) - string to trim
	 * return (out) - trimmed string
	 */
	std::string trim(const std::string str);

	/*
	 * Tokenize a string.
	 *
	 * str (in) - the string to tokenize
	 * pTokens (out) - map to take the tokens
	 * pDelimiters (out) - map to take the respective delimiters
	 * pPositions (out) - positions where delimiters were found
	 */
	void getTokenList(const std::string str, std::vector<std::string> &pTokens, std::string &pDelimiters, std::vector<int> &pPositions);

	/*
	 * Convert a string to all capitals.
	 *
	 * str (in) - string to convert
	 * return (out) - uppercase string
	 */
	inline std::string uppercase(const std::string str)
	{
		char *pstr = _strupr(_strdup(str.c_str()));
		const std::string toRet = pstr;
		free(pstr);
		return toRet;
	}

}

#endif
