///////////////////////////////////////////////////////////////////////////
//All contents copyright 2004 Colin James Fitzpatrick (KSNiloc)
//and Sander Knape (Woozy)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// RPGCode Parser
///////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Protect the header
//////////////////////////////////////////////////////////////////////////
#ifndef RPGCODE_PARSER_H
#define RPGCODE_PARSER_H

//////////////////////////////////////////////////////////////////////////
// Inclusions
//////////////////////////////////////////////////////////////////////////
#define WIN32_LEAN_AND_MEAN					//no MFC
#include <windows.h>						//include windows API
#include "..\inlineString\inlineString.h"	//for strings
#include <wtypes.h>							//for VB strings
#include <oleauto.h>						//for OLE automation

//////////////////////////////////////////////////////////////////////////
// Special keys
//////////////////////////////////////////////////////////////////////////
#define TAB				"\t"				//the tab key
#define QUOTE			"\""				//a quote
#define BACKSLASH		"\\"				//a backslash

//////////////////////////////////////////////////////////////////////////
// Macro to return a VB string
//////////////////////////////////////////////////////////////////////////

//When a vb function called by Declare returns a string, VB will
//change to it UNICODE *for you* whether it's in UNICODE, or not.
//It won't make it a BSTR, however. So here, we return a pointer
//to the char* array in BSTR format -- VB can take it from there.

//However, if you thought it was that easy, you were wrong, my
//friend. by the time VB gets the string it'll have four 16-bit
//NULLs on the end. This is very much a problem. In a bid to
//prevent this, we only allocate one byte per character.

//SysAllocString will allocate memory as it sees fit, fortunately,
//however, SysAllocStringLen doesn't do this. Rather it only copies
//the maximum amount of characters you set. At two bytes pre char,
//half the string's length ensures that only enough room is made
//for the chars, and no NULLs -- which VB will add-on itself.

#define RETURN_VB_STRING(theString)									\
{																	\
	return SysAllocStringLen(										\
							  (const OLECHAR*)(char*)theString,		\
							  strlen((char*)theString) / 2			\
														   );		\
}

//////////////////////////////////////////////////////////////////////////
// A VB string
//////////////////////////////////////////////////////////////////////////
typedef unsigned short* VB_STRING;

//////////////////////////////////////////////////////////////////////////
// Prototypes
//////////////////////////////////////////////////////////////////////////

//private parsing functions
inline int locateBrackets(inlineString);

//exports
VB_STRING APIENTRY RPGCGetMethodName(const char*);
VB_STRING APIENTRY RPGCParseAfter(const char*, const char*);
VB_STRING APIENTRY RPGCParseBefore(const char*, const char*);
VB_STRING APIENTRY RPGCGetVarList(const char*, const int);
VB_STRING APIENTRY RPGCParseWithin(const char*, const char*, const char*);
VB_STRING APIENTRY RPGCGetElement(const char*, const int);
VB_STRING APIENTRY RPGCReplaceOutsideQuotes(const char*, const char*, const char*);
VB_STRING APIENTRY RPGCGetBrackets(const char*);
VB_STRING APIENTRY RPGCGetCommandName(const char*);
int APIENTRY RPGCValueNumber(const char*);
int APIENTRY RPGCInStrOutsideQuotes(const int, const char*, const char*);

//////////////////////////////////////////////////////////////////////////
// End of the file
//////////////////////////////////////////////////////////////////////////
#endif