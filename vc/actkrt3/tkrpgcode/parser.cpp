///////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// RPGCode Parser
///////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Include the header file
//////////////////////////////////////////////////////////////////////////
#include "parser.h"		//contains stuff integral to this file

//////////////////////////////////////////////////////////////////////////
// Get the name of a method
//////////////////////////////////////////////////////////////////////////
int APIENTRY RPGCGetMethodName(char* pText, int &lengthBuffer)
{

	//read the VB string
	initVbString(pText);

	inlineString text = pText;		//Text we're operating on
	inlineString part;				//A character
	inlineString mName;				//Name of the method
	int t = 0;				 		//Loop control variables
	int startHere = 0;				//Where to start
	int length = text.len();		//Length of text

    for (t = 1; t <= length; t++)
	{
        //Attempt to find #
		part = text.mid(t, 1);
        if ( !part.contains(" ") && (!part.contains(TAB)) && (!part.contains("#")) )
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
        if (!part.contains(" "))
		{
			startHere = t;
			t = length;
		}
	}

    for (t = startHere; t <= length; t++)
	{
        //Find end of command name
        part = text.mid(t, 1);
        if (part.contains(" "))
		{
			startHere = t;
			t = length;
		}
    }

    for (t = startHere; t <= length; t++)
	{
        //Find start of method
        part = text.mid(t, 1);
        if (!part.contains(" "))
		{
			startHere = t;
			t = length;
		}
    }

    for (t = startHere; t <= length; t++)
	{
        //Find name  of method
        part = text.mid(t, 1);
		if ( part.contains(" ") || part.contains("(") )
		{
            t = length + 1;
        }
		else
		{
            mName = mName + part;
        }
    }

	//return what we found
	return returnVbString(mName, lengthBuffer);

}

//////////////////////////////////////////////////////////////////////////
// Return a VB string
//////////////////////////////////////////////////////////////////////////
inline int returnVbString(inlineString &theString, int &lengthBuffer)
{

	/////////////////////////////////////////////////////////////////
	//theString is the string to return
	//lengthBuffer is the var to use as the length buffer
	//returns address of string (what you should use as return value)
	/////////////////////////////////////////////////////////////////

	//create a static variable to hold the address of the string
	static char* memAdd;

	//if we previously had a value, delete it now
	if (memAdd) delete memAdd;

	//allocate some memory for the string
	memAdd = new(char[theString.len()]);

	//copy the string into the memory
	strcpy(memAdd, theString.value());

	//set the length buffer to the size in memory
	lengthBuffer = sizeof(memAdd);

	//return the address to the string
	return (int)memAdd;

}

//////////////////////////////////////////////////////////////////////////
// Init a VB string
//////////////////////////////////////////////////////////////////////////
inline void initVbString(char* theString)
{
	theString = (char*)(BSTR)theString;
}