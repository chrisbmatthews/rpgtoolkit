////////////////////////////////////////////////////////////////
//
// If you want your plugin to work, DO NOT MODIFY THIS FILE!
//
////////////////////////////////////////////////////////////////
//
// RPG Toolkit Development System, Version 3
// Plugin Libraries
// Developed by Christopher B. Matthews (Copyright 2003)
//
// This file is released under the AC Open License v 1.0
// See "AC Open License.txt"
//
////////////////////////////////////////////////////////////////
//
// File:					tkpluglocalfns.h
// Includes:			
// Description:		Local Functions-- these functions are 
//								provided as helper functions for your
//								plugin.  Some are *required* by the
//								plugin manager to be here.
//
////////////////////////////////////////////////////////////////

#include <string>

#ifndef TKPLUGLOCALFNS_H
#define TKPLUGLOCALFNS_H

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
int BSTRLen(BSTR x);

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
char* BSTRtoChar(BSTR x);

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
BSTR CharToBSTR(char* x);


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
std::string BSTR2String(BSTR x);


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
BSTR String2BSTR(std::string str);


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
std::string Int2String(int n);


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
					 int blue );
#endif