/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _MISC_H_
#define _MISC_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include <vector>

/*
 * Split a string.
 */
void split(const STRING str, const STRING delim, std::vector<STRING> &parts);

/*
 * Replace text in a string.
 */
STRING &replace(STRING &str, const STRING find, const STRING replace);

/*
 * Replace within a string.
 *
 * str (in) - string in question
 * find (in) - find this
 * replace (in) - replace with this
 * return (out) - result
 */
STRING replace(const STRING str, const char find, const char replace);

/*
 * Save a setting.
 *
 * strKey (in) - name of key to save to
 * dblValue (in) - value to save
 */
void saveSetting(const STRING strKey, const double dblValue);

/*
 * Get a setting.
 *
 * strKey (in) - name of key to get
 * dblValue (out) - result
 */
void getSetting(const STRING strKey, double &dblValue);

#endif
