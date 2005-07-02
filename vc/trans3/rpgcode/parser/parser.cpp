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
 * Determine whether a character is a delimiter.
 *
 * chr (in) - character to check
 * return (out) - whether it is a delimiter
 */
static inline bool isDelimiter(const char chr)
{
	switch (chr)
	{
		case '(':
		case ')':
		case ',':
		case '-':
		case '+':
		case '/':
		case '*':
		case '|':
		case '&':
		case '%':
		case '^':
		case '`':
		case '=':
		case '<':
		case '>':
		// case '!':
		case '~':
		case '\0': // Internal use only.
			return true;
	}
	return false;
}

/*
 * Determine whether a string is a delimiter.
 *
 * str (in) - character to check
 * return (out) - whether it is a delimiter
 */
static inline bool isDelimiter(const std::string str)
{
	return (
		str == "<<" ||
		str == ">=" ||
		str == "<=" ||
		str == ">>" ||
		str == "||" ||
		str == "&&" ||
		str == "==" ||
		// str == "!=" ||
		str == "~=" ||
		str == "++" ||
		str == "--" ||
		str == "+=" ||
		str == "-=" ||
		str == "*=" ||
		str == "/=" ||
		str == "%=" ||
		str == "^=" ||
		str == "`=" ||
		str == "|=" ||
		str == "&="
	);
}

/*
 * Eat whitespace from a string.
 *
 * str (in) - str to eat from
 * bIgnore (out) - ignore within quotes?
 */
std::string parser::eatWhitespace(const std::string str, const bool bIgnore)
{
	std::string toRet = "";
	const int len = str.length();
	bool bIgnoring = false;
	for (int i = 0; i < len; i++)
	{
		const char chr = str[i];
		if (bIgnore && chr == '"') bIgnoring = !bIgnoring;
		else if (!bIgnoring && chr != ' ') toRet += chr;
	}
	return toRet;
}

/*
 * Trim whitespace from the sides of a string.
 *
 * str (in) - string to trim
 * return (out) - trimmed string
 */
std::string parser::trim(const std::string str)
{
	const int len = str.length();
	if (len == 0) return "";
	int start = -1, end = -1;
	for (int i = 0; i < len; i++)
	{
		if (str[i] != ' ' && str[i] != '\t')
		{
			start = i;
			break;
		}
	}
	if (start == -1) return "";
	for (int j = len - 1; j >= 0; j--)
	{
		if (str[j] != ' ' && str[j] != '\t')
		{
			end = j + 1 - start;
			break;
		}
	}
	return str.substr(start, end);
}

/*
 * Tokenize a string.
 *
 * str (in) - the string to tokenize
 * pTokens (out) - map to take the tokens
 * pDelimiters (out) - map to take the respective delimiters
 * pPositions (out) - positions where delimiters were found
 */
void parser::getTokenList(const std::string str, std::vector<std::string> &pTokens, std::string &pDelimiters, std::vector<int> &pPositions)
{
	int lastToken = -1, size = 0;
	bool bIgnore = false;
	const int end = str.length();
	const int len = end + 1;
	for (int i = 0; i < len; i++, size++)
	{
		const char chr = str[i];
		if (chr == '"') bIgnore = !bIgnore;
		else if (!bIgnore && size)
		{
			const std::string part = str.substr(i, 2);
			if (isDelimiter(part))
			{
				i++;
				if (lastToken == -1)
				{
					size++;
					lastToken++;
				}
				const std::string strPush = trim(str.substr(lastToken, size - 1));
				if (strPush != "")
				{
					/*
					 * Push everything twice.
					 */
					pTokens.push_back(strPush);
					pTokens.push_back(strPush);
					pDelimiters += part;
					pPositions.push_back(i);
					pPositions.push_back(i);
					lastToken = i + 1;
					size = 0;
				}
			}
			else if (isDelimiter(chr))
			{
				/*
				 * Token here!
				 */
				if (lastToken == -1)
				{
					size++;
					lastToken++;
				}
				const std::string strPush = trim(str.substr(lastToken, size - 1));
				if (strPush != "" || chr == '(' || chr == ')')
				{
					pTokens.push_back(strPush);
					pDelimiters += chr;
					pPositions.push_back(i);
					lastToken = i + 1;
					size = 0;
				}
			}
		}
	}
}

/*
 * Convert a string to all capitals.
 *
 * str (in) - string to convert
 * return (out) - uppercase string
 */
std::string parser::uppercase(const std::string str)
{
	char *pstr = _strupr(_strdup(str.c_str()));
	const std::string toRet = pstr;
	free(pstr);
	return toRet;
}
