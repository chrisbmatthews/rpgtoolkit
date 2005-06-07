/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "paths.h"

/*
 * Globals.
 */
std::string g_projectPath;

/*
 * Remove the path from a filename.
 *
 * str (in) - filename
 * return (out) - pathless filename
 */
std::string removePath(const std::string str)
{
	return str.substr(str.find_last_of('\\') + 1);
}

/*
 * Get the extension of a file.
 *
 * str (in) - file to check
 * return (out) - extension
 */
std::string getExtension(const std::string str)
{
	const int dot = str.find_last_of('.');
	return (dot == -1) ? "" : str.substr(dot + 1);
}
