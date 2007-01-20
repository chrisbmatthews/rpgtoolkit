/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Colin James Fitzpatrick
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

#ifndef _STRINGS_H_
#define _STRINGS_H_

#include <string>
#include <sstream>
#include <tchar.h>
//#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <oleauto.h>

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

inline bool isVbNullString(const BSTR bstr)
{
	return (bstr == NULL);
}

inline STRING getString(const BSTR bstr)
{
	if (isVbNullString(bstr)) return STRING();
#ifndef _UNICODE
	const int length = SysStringLen(bstr) + 1;
	char *const str = new char[length];
	WideCharToMultiByte(CP_ACP, 0, bstr, -1, str, length, NULL, NULL);
	const STRING toRet = str;
	delete [] str;
	return toRet;
#else
	return (wchar_t *)bstr;
#endif
}

inline BSTR getString(const STRING rhs)
{
#ifndef _UNICODE
	wchar_t *str = new wchar_t[rhs.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1);
	const BSTR toRet = SysAllocString(str);
	delete [] str;
	return toRet;
#else
	return SysAllocString(rhs.c_str());
#endif
}

#endif // !_STRINGS_H_
