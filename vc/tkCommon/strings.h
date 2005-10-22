/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _STRINGS_H_
#define _STRINGS_H_

#include <string>
#include <sstream>
#include <tchar.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#if !defined(STRING_DEFINED)
typedef std::basic_string<TCHAR> STRING;
#define STRING_DEFINED
#endif // !STRING_DEFINED

typedef std::basic_stringstream<TCHAR> STRINGSTREAM;

typedef STRING STD_NATURAL_STRING;

// Get an ASCII string.
template <class T>
inline std::string getAsciiString(const std::basic_string<T> istr)
{
#ifdef _UNICODE
	const int length = istr.length() + 1;
	char *const str = new char[length];
	WideCharToMultiByte(CP_ACP, 0, istr.c_str(), -1, str, length, NULL, NULL);
	const std::string toRet = str;
	delete [] str;
	return toRet;
#else
	return istr;
#endif
}

// Get a UNICODE string.
template <class T>
inline std::wstring getUnicodeString(const std::basic_string<T> istr)
{
#ifndef _UNICODE
	wchar_t *str = new wchar_t[istr.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, istr.c_str(), -1, str, istr.length() + 1);
	const std::wstring toRet = str;
	delete [] str;
	return toRet;
#else
	return istr;
#endif
}

#endif // !_STRINGS_H_
