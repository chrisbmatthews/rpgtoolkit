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
// Get the command name in the text passed in
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetCommandName(VB_STRING pText)
{

	inlineString splice = initVbString(pText);	//text to work with
	inlineString commandName;					//command name to return
	inlineString part(1);						//a character
	int depth = 0;								//depth in brackets
	int starting = 0;							//char to start at
	int length = splice.len();					//length of text
	int foundIt = 0;							//where we found it
	int p = 0;									//loop control variable

	if (splice == "")
	{
		//we got no text
		returnVbString("");
		return;
	}

	for (p = 1; p <= length; p ++)
	{

		//grab a character
		part = splice.mid(p, 1);

		if (part == "(")
		{
			//heading into brackets
			depth++;
		}

		if (part == ")")
		{
			//coming out of brackets
			depth--;
		}

		if (part == "=")
		{
			//if we're not within brackets
			if (depth == 0)
			{
				//it's a variable
				returnVbString("VAR");
				return;
			}
		}

    }

	for (p = 1; p <= length; p++)
	{

		//grab a character
        part = splice.mid(p, 1);

        if (part == "[")
		{
            //it's a vairable
            returnVbString("VAR");
			return;
		}
		else if (part == "" || part == "#" || part == "(")
			//*this* variable check fails (it still may be a variable, though)
			break;
    }

    //look for special characters
    for (p = 1; p <= length; p++)
	{

		//grab a character
        part = splice.mid(p, 1);

        if ( part != " " && part != "#" && part != TAB )
		{

            if ( part == "*" )
			{
				//it's a comment
                returnVbString("*");
                return;
			}

            else if ( part == ":" )
			{
                returnVbString("LABEL");
                return;
			}

            else if ( part == "@" )
			{
				returnVbString("@");
                return;
            }

            foundIt = p;
            starting = p - 1;
            break;

		}

        else if ( part == "#" )
		{
			//it's a command, but this command test will never pass,
			//but it has been left for now
            starting = p;
            foundIt = p;
            break;
        }

    }

    if (foundIt == 0)
	{

        //didn't find one of the special characters above, this
		//is going to be difficult

        for (p = 1; p <= length; p++)
		{

			//grab a character
            part = splice.mid(p, 1);

            if ( part != " " && part != "@" && part != TAB )
				//it's not a @ line
				break;

            else if (part == "@")
			{
				//it's an @ line
				returnVbString("@");
				return;
            }

        }

		//still haven't found it... try for comments
		for (p = 1; p <= length; p++)
		{

			//grab a character
			part = splice.mid(p, 1);

			if ( part != " " && part != "*" && part != TAB ) 
				//it's not a comment
				break;

			if (part == "*")
			{
				//it's a comment
				returnVbString("*");
				return;
			}

		}

		//yet to find it... try for labels
		for (p = 1; p <= length; p++)
		{

			//grab a character
			part = splice.mid(p, 1);

			if ( part != " " && part != ":" && part != TAB ) 
				//it's not a label
				break;

			if (part == ":")
			{
				//it's a label
				returnVbString("LABEL");
				return;
			}

		}

		//no luck yet... try for opening blocks
		for (p = 1; p <= length; p++)
		{

			//grab a character
			part = splice.mid(p, 1);

			if ( part != " " && part != "<" && part != "{" && part != TAB ) 
				//it's not an opening block
				break;

			if (part == "<" || part == "{")
			{
				//it's an opening block
				returnVbString("OPENBLOCK");
				return;
			}

		}

		//still no luck... try for closing blocks
		for (p = 1; p <= length; p++)
		{

			//grab a character
			part = splice.mid(p, 1);

			if ( part != " " && part != ">" && part != "}" && part != TAB ) 
				//it's not an closing block
				break;

			if (part == ">" || part == "}")
			{
				//it's an closing block
				returnVbString("CLOSEBLOCK");
				return;
			}

		}

		//if we make it here, it *could* be a message box. However, since
		//these types of message boxes are obsolete this may just serve as
		//an unneeded delay.
		returnVbString("MBOX");

    }

    //if we make it here, it's a command
	for (p = (starting + 1); p <= length; p++)
	{

		//grab a character
        part = splice.mid(p, 1);

        if (part != " ")
		{
			//found the start of the command's name
			starting = p;
			break;
        }

    }

    //now scoop out the command's name
    for (p = starting; p <= length; p++)
	{

		//grab a character
        part = splice.mid(p, 1);

		if ( part == " " || part == "(" || part == "=" ) 
			//found the name of the command
			break;

		//add to the return string
		commandName += part;

    }

    //before we return the result, let's check if we somehow missed an opening /
	//closing block, or a variable

    if (commandName == "{") commandName = "OPENBLOCK";
    if (commandName == "}") commandName = "CLOSEBLOCK";

    for (p = 1; p <= commandName.len(); p++)
	{

		//grab a character
		part = commandName.mid(p, 1);

		//check for type-declaration characters
		if (part == "!" || part == "$")
		{
			//it's a variable
			commandName = "VAR";
			break;
		}

    }

	//return the command's name
    returnVbString(commandName);

}

//////////////////////////////////////////////////////////////////////////
// Retrieve the text inside the brackets
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetBrackets(VB_STRING pText)
{

	inlineString text = initVbString(pText);	//text to work with
	inlineString toRet;							//string to return
	inlineString part(1);						//a character
	bool ignoreClosing = false;					//within quotes?
	int bracketDepth = 0;						//depth in brackets

	for (int p = (locateBrackets(text) + 1); p <= text.len(); p++)
	{

		//grab a charater
		part = text.mid(p, 1);

        if ( ((part == ")") && (!ignoreClosing) && (bracketDepth <= 0)) || (part == "") )
			//end of the brackets
            break;

        else
		{

            if (part == ")")
				//leaving brackets
                bracketDepth--;

            else if (part == QUOTE)
				//found a quote
				ignoreClosing = (!ignoreClosing);

            else if (part == "(")
				//entering brackets
                bracketDepth++;

			//add it onto the return string
            toRet += part;

        }
    }

    returnVbString(toRet);

}

//////////////////////////////////////////////////////////////////////////
// Return the first space after the command / the opening bracket
//////////////////////////////////////////////////////////////////////////
inline int locateBrackets(inlineString text)
{

	////////////////////////////////
	//Called only by RPGCGetBrackets
	////////////////////////////////

    //look for the brackets
	for (int p = 1; p <= text.len(); p++)
	{
        if (text.mid(p, 1) == "(")
			//found them
			return p;
	}

	//brackets couldn't be found
	return 0;

}

//////////////////////////////////////////////////////////////////////////
// Replace not within quotes
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCReplaceOutsideQuotes(VB_STRING pText, VB_STRING pFind, VB_STRING pReplace)
{

	inlineString text = initVbString(pText);			//text we're working with
	inlineString find(initVbString(pFind), 1);			//character to find
	inlineString replace(initVbString(pReplace), 1);	//character to replace it with
    inlineString toRet;									//string to return
    inlineString chr(1);								//a character
    bool ignore = false;								//within quotes?

	for (int idx = 1; idx <= text.len(); idx++)
	{

		//grab a character
		chr = text.mid(idx, 1);

		if (chr == QUOTE)
			//found a quote
			ignore = (!ignore);

		else if ( (!ignore) && (chr == find) )
			//found the find character-- swap with replace character
			chr = (char*)replace;

		//add to the return string
		toRet += chr;

    }

    //return what we've found
	returnVbString(toRet);

}

//////////////////////////////////////////////////////////////////////////
// InStr outside quotes
//////////////////////////////////////////////////////////////////////////
int APIENTRY RPGCInStrOutsideQuotes(int start, VB_STRING pText, VB_STRING pFind)
{

	inlineString text = initVbString(pText);	//text to look in
	inlineString find = initVbString(pFind);	//sub-string to find
	inlineString chr(1);						//a character
	bool ignore = false;						//within quotes?

	//loop over each character
    for (int chrIdx = start; chrIdx <= text.len(); chrIdx++)
	{

		//grab a character
		chr = text.mid(chrIdx, find.len());

		if (chr.left(1) == QUOTE)
			//found a quote
			ignore = (!ignore);

		else if ( (chr == find) && (!ignore) )
			//found it
            return chrIdx;

    }

	//if we get here, it wasn't found, so return 0
	return 0;

}

//////////////////////////////////////////////////////////////////////////
// Get the bracket element at elemNum
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCGetElement(VB_STRING pText, int elemNum)
{

	inlineString text = initVbString(pText);		//Text we're operating on
	inlineString returnVal;							//What we will return		
	inlineString part(1);							//Character
	int element = 0;								//Current element
	bool ignore = false;							//Do we need to ignore?

	for (int t = 1; t <= text.len(); t++)
	{

		//grab a character
		part = text.mid(t, 1);

		if (part == QUOTE)
		{
			//found a quote
			ignore = (!ignore);
			returnVal += part;
		}
		else if (part == "," || part == ";" || part == "")
		{
			if (!ignore)
			{
				//increment element
				element++;
				if (element == elemNum)
				{
					//return what we found
					returnVbString(returnVal);
					return;
				}
				else
					//not the correct element
					returnVal = "";
			}
			else
				//within quotes-- can't take it
				returnVal += part;
		}
		else
			//not a special character
			returnVal += part;
	}

	//return what we've found
	returnVbString(returnVal);

}

//////////////////////////////////////////////////////////////////////////
// Count the number of values in an equation
//////////////////////////////////////////////////////////////////////////
int APIENTRY RPGCValueNumber(VB_STRING pText)
{

	inlineString text = initVbString(pText);		//Text we're operating on
	inlineString part(1);							//Character
	bool ignoreNext = false;						//Within quotes?
	int length = text.len();						//Text length
	int ele = 1;									//Current return value

	for (int t = 1; t <= length; t++)
	{
		part = text.mid(t, 1);
		if (part == QUOTE)
		{
			ignoreNext = (!ignoreNext);
		}
		else if ( part == "=" || part == "+" || part == "-" || part == "/" || part == "*" || part == BACKSLASH || part == "^" )
		{
			if (!ignoreNext) 
				ele++;
		}
	}

	return ele;

}

//////////////////////////////////////////////////////////////////////////
// Return the content in text between the start and end symbols
//////////////////////////////////////////////////////////////////////////
void APIENTRY RPGCParseWithin(VB_STRING pText, VB_STRING startSymbol, VB_STRING endSymbol)
{

	inlineString text = initVbString(pText);				//Text we're operating on
	inlineString symbolStart(initVbString(startSymbol), 1); //Starting symbol
	inlineString symbolEnd(initVbString(endSymbol), 1);		//Ending symbol

	int length = text.len();
	int ignoreDepth = 0;									//Ignore
	inlineString part(1);									//Character
	inlineString toRet;										//The stuff we'll return

	for (int t = 1; t <= length; t++)
	{
		part = text.mid(t, 1);
		if (part == symbolStart)
		{
			//Found starting symbol, now get end symbol
			for (int l = t + 1; l <= length; l++)
			{

				part = text.mid(l, 1);

				if (part == symbolStart)
					ignoreDepth++;

				else if (part == symbolEnd)
				{
					if (ignoreDepth == 0)
					{
						//Return what we found
						returnVbString(toRet);
						return;
					}
					ignoreDepth--;
				}

				else
					toRet += part;

			}
		}
	}

	//Return what we found (If we got here, the 2 symbols weren't found)
	returnVbString("");	
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
					//not the one we wanted
                    returnVal = "";
			}
            else
				//inside quotes, can't use it
                returnVal += part;
		}
        else
			//save the character
            returnVal += part;

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
	int length = text.len();							//Length of text
	bool foundIt = false;								//found symbol yet?
	int startAt = 0;									//char to start looking

	for (int t = 1; t <= length; t++)
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
		for (int i = startAt + 1; i <= length; i++)
			toRet += text.mid(i, 1);
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
	int length = text.len();							//Length of text

	for (int t = 1; t <= length; t++)
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
			toRet += part;
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
            t = length + 1;
		else
            mName += part;
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