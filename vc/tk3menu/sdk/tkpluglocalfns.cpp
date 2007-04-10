/*
 ********************************************************************
 * The RPG Toolkit Version 3 Plugin Libraries
 * This file copyright (C) 2003-2007  Christopher B. Matthews
 ********************************************************************
 *
 * This file is released under the AC Open License v 1.0
 * See "AC Open License.txt" for details
 */

/*
 * To ensure the plugin works, do not modify this file.
 */

#include "stdafx.h"
#include "tkpluglocalfns.h"

///////////////////////////////////////////////////////
//
// Function: BSTRLen
//
// Parameters: x- a BSTR string
//
// Action: determine length of BSTR string
//
// Returns: length of string
//
///////////////////////////////////////////////////////
int BSTRLen(BSTR x)
{
	int len = 0;
	int pos = 0;
	bool done = false;
	
	if (x == NULL) return 0;

	while (!done)
	{
		unsigned int part = x[pos];
		if (part == 0)
		{
			return len;
		}
		else
		{
			len++;
		}
		pos++;
	}
	return 0;
}


///////////////////////////////////////////////////////
//
// Function: BSTRToChar
//
// Parameters: x- a BSTR string
//
// Action: converts a BSTR string to a char string
//
// Returns: char*- the converted string.
//
///////////////////////////////////////////////////////
char* BSTRtoChar(BSTR x)
{
	int len = BSTRLen(x);
	char* pstrRet = new char[len+1];
	strcpy(pstrRet, "");
	for (int i=0; i<len; i++)
	{
		unsigned int part = x[i];
		pstrRet[i] = part;
		pstrRet[i+1] = '\0';
	}
	return pstrRet;
}


///////////////////////////////////////////////////////
//
// Function: CharToBSTR
//
// Parameters: x- a char* string
//
// Action: converts a ascii string to a BSTR string
//
// Returns: BSTR- the converted string.
//
///////////////////////////////////////////////////////
BSTR CharToBSTR(char* x)
{
	int len = strlen(x);
	unsigned short* bstrRet = new unsigned short[len+1];
	for (int i=0; i<len; i++)
	{
		char part = x[i];
		bstrRet[i] = part;
		bstrRet[i+1] = '\0';
	}
	if ( len == 0 ) 
	{
		bstrRet[0] = 0;
	}
	return bstrRet;
}


///////////////////////////////////////////////////////
//
// Function: BSTR2String
//
// Parameters: x- a BSTR string
//
// Action: converts a BSTR to a std::string
//
// Returns: std::string - the converted string
//
///////////////////////////////////////////////////////
std::string BSTR2String(BSTR x)
{
	char* s = BSTRtoChar(x);
	std::string strRet = s;
	delete [] s;

	return strRet;
}


///////////////////////////////////////////////////////
//
// Function: String2BSTR
//
// Parameters: str- a std::string
//
// Action: converts a string to a BSTR string (and uses SysAllocString)
//
// Returns: std::string- the converted string.
//
///////////////////////////////////////////////////////
BSTR String2BSTR(std::string str)
{
	BSTR b = CharToBSTR((char*)str.c_str());
	BSTR toRet = SysAllocString(b);
	delete [] b;
	return toRet;
}


///////////////////////////////////////////////////////
//
// Function: Int2String
//
// Parameters: n - an inter to be converted
//
// Action: converts an integer into a string
//
// Returns: std::string- the converted string.
//
///////////////////////////////////////////////////////
std::string Int2String(int n)
{
	char str[255];
	itoa(n, str, 10);
	std::string strRet = str;
	return strRet;
}


///////////////////////////////////////////////////////
//
// Function: rgb
//
// Parameters: red, green, blue- color
//
// Action: converts color compnents to an rgb color
//
// Returns: rgb color
//
///////////////////////////////////////////////////////
long rgb ( int red, 
					 int green, 
					 int blue ) 
{
	if (red>255) red=255;
	if (red<0) red=0;
	if (green>255) green=255;
	if (green<0) green=0;
	if (blue>255) blue=255;
	if (blue<0) blue=0;
	return RGB(red,green,blue);
}
