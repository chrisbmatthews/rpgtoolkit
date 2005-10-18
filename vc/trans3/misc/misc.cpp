/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "misc.h"
#include "../common/player.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <vector>
#include <sstream>

/*
 * Definitions.
 */
#define KEY_TRANS3 _T("Software\\VB and VBA Program Settings\\RPGToolkit3\\Trans3")

/*
 * Split a string.
 */
void split(const STRING str, const STRING delim, std::vector<STRING> &parts)
{
	STRING::size_type pos = STRING::npos, begin = 0;
	while ((pos = str.find(delim, pos + 1)) != STRING::npos)
	{
		parts.push_back(str.substr(begin, pos - begin));
		begin = pos + 1;
	}
	parts.push_back(str.substr(begin, pos - begin));
}

/*
 * Replace text in a string.
 */
STRING &replace(STRING &str, const STRING find, const STRING replace)
{
	unsigned int pos = STRING::npos;
	while ((pos = str.find(find)) != STRING::npos)
	{
		str.erase(pos, find.length());
		str.insert(pos, replace);
	}
	return str;
}

/*
 * Replace within a string.
 *
 * str (in) - string in question
 * find (in) - find this
 * replace (in) - replace with this
 * return (out) - result
 */
STRING replace(const STRING str, const char find, const char replace)
{
	STRING toRet = str;
	const int len = str.length();
	for (unsigned int i = 0; i < len; i++)
	{
		if (toRet[i] == find) toRet[i] = replace;
	}
	return toRet;
}

/*
 * Save a setting.
 *
 * strKey (in) - name of key to save to
 * dblValue (in) - value to save
 */
void saveSetting(const STRING strKey, const double dblValue)
{
	HKEY hKey;
	RegCreateKey(HKEY_CURRENT_USER, KEY_TRANS3, &hKey);
	STRINGSTREAM ss;
	ss << dblValue;
	const TCHAR *str = ss.str().c_str();
	RegSetValueEx(hKey, strKey.c_str(), 0, REG_SZ, (LPBYTE)str, strlen(str) + 1);
	RegCloseKey(hKey);
}

/*
 * Get a setting.
 *
 * strKey (in) - name of key to get
 * dblValue (out) - result
 */
void getSetting(const STRING strKey, double &dblValue)
{
	HKEY hKey;
	RegCreateKey(HKEY_CURRENT_USER, KEY_TRANS3, &hKey);
	TCHAR str[255];
	DWORD dwSize = sizeof(str);
	if (FAILED(RegQueryValueEx(hKey, strKey.c_str(), 0, NULL, (unsigned char *)str, &dwSize)))
	{
		dblValue = -1;
	}
	else
	{
#ifndef _UNICODE
		dblValue = atof(str);
#else
		dblValue = atof(getAsciiString(std::wstring(str)).c_str());
#endif
	}
	RegCloseKey(hKey);
}
