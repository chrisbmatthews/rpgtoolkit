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
// Include the header file
//////////////////////////////////////////////////////////////////////////
#include "parser.h"				//contains stuff integral to this file

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
CBOneParamStr setLastString;	//set the last parser string

//////////////////////////////////////////////////////////////////////////
// Check if a string contains a sub-string
//////////////////////////////////////////////////////////////////////////
int APIENTRY RPGCStringContains(VB_STRING pText, VB_STRING theChar)
{
	inlineString text = initVbString(pText);				//Text we're operating on
	inlineString symbol(initVbString(theChar));				//Symbol we need
	symbol.resize(symbol.len());
	return (int)(strstr(text,symbol));
}

//////////////////////////////////////////////////////////////////////////
// Get the variable at number in an equation
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetVarList(VB_STRING pText, int number)
{

	inlineString text = initVbString(pText);	//the text
	inlineString part(1);						//a character
	inlineString returnVal;						//value to return
	bool ignoreNext = false;					//ignore quotes?
	int element = 0;							//current element

	for (int p = 1; p <= (text.len() + 1); p++)
	{

		//grab a character
		part = text.mid(p, 1);

		if (part == QUOTE)
		{
			//it was a quote
			ignoreNext = (!ignoreNext);
            returnVal += part;
		}
        else if ( part == "=" || part == "+" || part == "-" || part == "/" || part == "*" || part == BACKSLASH || part == "^" )
		{
			//it was a math sign
            if (!ignoreNext)
			{
				//okay to use it
                element++;
                if (element == number)
				{
					//this one was the one we wanted
                    returnVbString(returnVal);
                    return;
				}
                else
				{
					//not the one we wanted
                    returnVal = "";
                }
			}
            else
			{
				//inside quotes, can't use it
                returnVal += part;
            }
		}
        else
		{
			//save the character
            returnVal += part;
        }

    }

    returnVbString(returnVal);

}

//////////////////////////////////////////////////////////////////////////
// Return content in text after startSymbol is located
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCParseAfter(VB_STRING pText, VB_STRING startSymbol)
{

	inlineString text = initVbString(pText);			//Text we're operating on
	inlineString part(1);								//A character
	inlineString toRet;									//The thing we'll return
	inlineString symbol(initVbString(startSymbol), 1);	//symbol we're looking for
	int t = 0;				 							//Loop control variables
	int length = text.len();							//Length of text
	bool foundIt = false;								//found symbol yet?
	int startAt = 0;									//char to start looking

	for (t = 1; t <= length; t++)
	{
		//Find the start symbol
		part = text.mid(t, 1);
		if (part == symbol)
		{
			startAt = t;
			foundIt = true;
		}
	}

	if (foundIt)
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
void APIENTRY RPGCParseBefore(VB_STRING pText, VB_STRING startSymbol)
{

	inlineString text = initVbString(pText);			//Text we're operating on
	inlineString part(1);								//A character
	inlineString toRet;									//The thing we'll return
	inlineString symbol(initVbString(startSymbol), 1);	//Symbol we're looking for
	int t = 0;				 							//Loop control variables
	int length = text.len();							//Length of text

	for (t = 1; t <= length; t++)
	{

		//Find the start symbol
		part = text.mid(t, 1);

		if (part == symbol)
		{
			//Found it
			returnVbString(toRet);
			return;
		}
		else
		{
			toRet += part;
		}
	}

	//return empty string
	returnVbString("");

}

//////////////////////////////////////////////////////////////////////////
// Get the name of a method
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetMethodName(VB_STRING pText)
{

	inlineString text = initVbString(pText);	//Text we're operating on
	inlineString part(1);						//A character
	inlineString mName;							//Name of the method
	int t = 0;				 					//Loop control variables
	int startHere = 0;							//Where to start
	int length = text.len();					//Length of text

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

	//First change the char* string to vb string format
	VB_STRING pVbString = charToVbString((char*)theString);

	//Let the system know of its existence
	VB_STRING theVbString = SysAllocString(pVbString);

	//Set the string
	setLastString(theVbString);

	//Make the system forget about it
	SysFreeString(theVbString);

}

//////////////////////////////////////////////////////////////////////////
// Init a VB string
//////////////////////////////////////////////////////////////////////////
inline char* initVbString(VB_STRING theString)
{
	//change the vb string to char*
	return vbStringToChar(theString);
}

//////////////////////////////////////////////////////////////////////////
// Convert a pointer to a string to a vb string
//////////////////////////////////////////////////////////////////////////
inline VB_STRING charToVbString(char* stringPointer)
{

	//get the length of the string passed in
	int len = strlen(stringPointer);

	//prepare a vb string string to return (one byte longer than char*
	//because vb string strings know their own length)
	VB_STRING bstrRet = new unsigned short[len + 1];

	//loop over each character
	for (int chrIdx = 0; chrIdx < len; chrIdx++)
	{

		//set in the character
		char part = stringPointer[chrIdx];
		bstrRet[chrIdx] = part;

		//set in the escape sequence (will be overwritten if
		//this is not the last character)
		bstrRet[chrIdx + 1] = '\0';

	}

	if (len == 0) 
	{
		//if the string had no length, then just set it to nothing
		bstrRet[0] = 0;
	}

	//return the vb string
	return bstrRet;

}

//////////////////////////////////////////////////////////////////////////
// Convert a vb string to a pointer to a string
//////////////////////////////////////////////////////////////////////////
inline char* vbStringToChar(VB_STRING theVbString)
{

	//get the length of the vb string
	int len = vbStringGetLen(theVbString);

	//create a pointer to a string to return
	char* pstrRet = new char[len + 1];

	//set the string to "" (nothing)
	strcpy(pstrRet, "");

	//loop over each character
	for (int chrIdx = 0; chrIdx < len; chrIdx++)
	{

		//set in the character
		unsigned int part = theVbString[chrIdx];
		pstrRet[chrIdx] = part;

		//set in the escape sequence (will be overwritten if
		//this is not the last character)
		pstrRet[chrIdx + 1] = '\0';

	}

	//return the pointer to a string
	return pstrRet;

}

//////////////////////////////////////////////////////////////////////////
// Get length of a VB string
//////////////////////////////////////////////////////////////////////////
inline int vbStringGetLen(VB_STRING theVbString)
{

	int len = 0;		//length to return
	int pos = 0;		//position in string
	bool done = false;	//done?

	//if we don't have a string, then its length is 0
	if (theVbString == NULL) 
		return 0;

	//until we're done
	while (!done)
	{

		//get a part of the string
		unsigned int part = theVbString[pos];

		if (part == 0)
		{
			//no part-- end of string
			return len;
		}
		else
		{
			//part-- increase length
			len++;
		}

		//both cases, increment position
		pos++;

	}

	//error out
	return 0;

}