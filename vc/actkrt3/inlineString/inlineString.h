///////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// String class (fast!)
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Prevent multiple inclusions of this file
///////////////////////////////////////////////////////////////////////////
#ifndef STRING_CLASS_H
#define STRING_CLASS_H

///////////////////////////////////////////////////////////////////////////
// Inlusions
///////////////////////////////////////////////////////////////////////////
#include <string>				//For the STL string
#include <string.h>				//For strings

///////////////////////////////////////////////////////////////////////////
// Definition of the inlineString class
///////////////////////////////////////////////////////////////////////////
class inlineString
{

	//////////////////////////////////////////////////////
	// Private scope
	//////////////////////////////////////////////////////
	private:

		//The main contents of the inlineString
		//is stored in in array of characters.
		//This array is statically dimensioned to
		//4048 characters for speed reasons.
		char contents[4048];

	//////////////////////////////////////////////////////
	// Public scope
	//////////////////////////////////////////////////////
	public:

		//mainipulation
		int len();										// return length of the string
		inlineString mid(int start, int length);		// get character(s) from the string
		bool contains(char* text);						// check if we contain a pointer to a string
		bool contains(std::string text);				// check if we contain an STL string
		bool contains(inlineString text);				// check if we contain an inlineString
		void newMem(char* theNewMem);					// copy string to new memory

		//construction
		inlineString();									// empty string
		inlineString(char* defaultVal);					// construct from a pointer to a string
		inlineString(std::string cFrom);				// construct from an STL string
		inlineString(char defaultVal);					// construct from a character

		//operators
		inlineString operator + (inlineString &toAdd);	// + another inlineString
		inlineString operator + (char* toAdd);			// + a pointer to a string
		inlineString operator + (char toAdd);			// + a character
		inlineString operator + (std::string toAdd);	// + an STL string
		operator += (char* toAdd);						// += a pointer to a string
		operator += (inlineString toAdd);				// += an inlineString
		operator += (std::string toAdd);				// += an STL string
		operator += (char toAdd);						// += a character
		operator = (char* text);						// = a pointer to a string
		operator = (char text);							// = a character
		operator = (std::string cFrom);					// = an STL string
		operator char*();								// cast to pointer to a string
		operator std::string();							// cast to STL string
		unsigned char& operator [] (int pos);			// get/set binary value

};

///////////////////////////////////////////////////////////////////////////
// End of the header file
///////////////////////////////////////////////////////////////////////////
#endif