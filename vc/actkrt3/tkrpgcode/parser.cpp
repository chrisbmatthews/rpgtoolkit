///////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, KSNiloc and Woozy
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// RPGCode Parser
///////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Include the header file
//////////////////////////////////////////////////////////////////////////
#include "parser.h"				//contains stuff integral to this file

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
CBOneParamStr setLastString;	//set the last parser string

//////////////////////////////////////////////////////////////////////////
// Return content in text after startSymbol is located
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCParseAfter(char* pText, char* startSymbol)
{
	
	//Read the VB string
	initVbString(pText);
	
	inlineString text = pText;			//Text we're operating on
	inlineString part(1);				//A character
	inlineString toRet;					//The thing we'll return
	int t = 0;				 			//Loop control variables
	int length = text.len();			//Length of text
	bool foundIt = false;				//found symbol yet?
	int startAt = 0;					//char to start looking

	for (t = 1; t <= length; t++)
	{
		//Find the start symbol
		part = text.mid(t, 1);
		if (part == startSymbol)
		{
			startAt = t;
			foundIt = true;
		}
	}

	if(foundIt)
	{
		for (t = startAt + 1; t <= length; t++)
		{
			toRet += text.mid(t, 1);
		}
	}

	//Return what we found
	returnVbString(toRet);

}

//////////////////////////////////////////////////////////////////////////
// Return content from text until startSymbol is located
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCParseBefore(char* pText, char* startSymbol)
{

	//Read the VB string
	initVbString(pText);

	inlineString text = pText;			//Text we're operating on
	inlineString part(1);				//A character
	inlineString toRet;					//The thing we'll return
	int t = 0;				 			//Loop control variables
	int length = text.len();			//Length of text

	for (t = 1; t <= length; t++)
	{
		//Find the start symbol
		part = text.mid(t, 1);
		if (part == startSymbol)
		{
			//Found it
			returnVbString(toRet);
			break;
		}
		else
		{
			toRet += part;
		}
	}

	returnVbString("");
}

//////////////////////////////////////////////////////////////////////////
// Get the name of a method
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetMethodName(char* pText)
{

	//read the VB string
	initVbString(pText);

	inlineString text = pText;		//Text we're operating on
	inlineString part(1);			//A character
	inlineString mName;				//Name of the method
	int t = 0;				 		//Loop control variables
	int startHere = 0;				//Where to start
	int length = text.len();		//Length of text

    for (t = 1; t <= length; t++)
	{
        //Attempt to find #
		part = text.mid(t, 1);
        if ( (part != " ") && (part != TAB) && (part != "#") )
		{
			startHere = t - 1;
			if (startHere == 0) startHere = 1;
			t = length;
        }
        else
		{
            startHere = t;
            t = length;
        }
    }

	for (t = startHere; t <= length; t++)
	{
		//Find start of command name
		part = text.mid(t, 1);
        if (part != " ")
		{
			startHere = t;
			t = length;
		}
	}

    for (t = startHere; t <= length; t++)
	{
        //Find end of command name
        part = text.mid(t, 1);
        if (part == " ")
		{
			startHere = t;
			t = length;
		}
    }

    for (t = startHere; t <= length; t++)
	{
        //Find start of method
        part = text.mid(t, 1);
        if (part != " ")
		{
			startHere = t;
			t = length;
		}
    }

    for (t = startHere; t <= length; t++)
	{
        //Find name  of method
        part = text.mid(t, 1);
		if ( part == " " || part == "(" )
		{
            t = length + 1;
        }
		else
		{
            mName += part;
        }
    }

	//return what we found
	returnVbString(mName);

}

//////////////////////////////////////////////////////////////////////////
// Initiate the parser
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCInitParser(int setStringAddress)
{
	setLastString = (CBOneParamStr)setStringAddress;
}

//////////////////////////////////////////////////////////////////////////
// Return a VB string
//////////////////////////////////////////////////////////////////////////
inline void returnVbString(inlineString theString)
{
	setLastString(CharToBSTR((char*)theString));
}

//////////////////////////////////////////////////////////////////////////
// Init a VB string
//////////////////////////////////////////////////////////////////////////
inline void initVbString(char* theString)
{
	theString = (char*)(BSTR)theString;
}

//////////////////////////////////////////////////////////////////////////
// Convert a pointer to a string to a BSTR
//////////////////////////////////////////////////////////////////////////
inline BSTR CharToBSTR(char* stringPointer)
{

	//get the length of the string passed in
	int len = strlen(stringPointer);

	//prepare a BSTR string to return (one byte longer than char*
	//because BSTR strings know their own length)
	unsigned short* bstrRet = new unsigned short[len + 1];

	//loop over each character
	for (int chrIdx = 0; chrIdx < len; chrIdx++)
	{

		//set in the character
		bstrRet[chrIdx] = stringPointer[chrIdx];

		//set in the escape sequence (will be overwritten if
		//this is not the last character)
		bstrRet[chrIdx + 1] = '\0';

	}

	if (len == 0) 
	{
		//if the string had no length, then just set it to nothing
		bstrRet[0] = 0;
	}

	//return the BSTR
	return bstrRet;

}