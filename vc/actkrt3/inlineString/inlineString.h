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

		char* m_contents;							// pointer to string holding contents
		int m_length;								// max length of string
		char* getChars(int, int);					// get character(s) from the string

	//////////////////////////////////////////////////////
	// Public scope
	//////////////////////////////////////////////////////
	public:

		//mainipulation
		int len();									// return length of the string
		void newMem(char*);							// copy string to new memory
		void resize(int);							// resize the string (maintain contents if possible)
		char* mid(int, int);						// get character(s) from the string
		char* left(int);							// get character(s) from left of string
		char* right(int);							// get character(s) from right of string

		//construction
		inlineString(int = 4048);					// empty string
		inlineString(char*, int = 4048);			// construct from a pointer to a string
		inlineString(std::string, int = 4048);		// construct from an STL string
		inlineString(char, int = 4048);				// construct from a character

		//deconstruction
		~inlineString();							// free up memory

		//operators
		inlineString& operator + (inlineString&);	// + another inlineString
		inlineString& operator + (char*);			// + a pointer to a string
		inlineString& operator + (char);			// + a character
		inlineString& operator + (std::string);		// + an STL string
		operator += (char*);						// += a pointer to a string
		operator += (inlineString);					// += an inlineString
		operator += (std::string);					// += an STL string
		operator += (char);							// += a character
		operator = (char*);							// = a pointer to a string
		operator = (char);							// = a character
		operator = (std::string);					// = an STL string
		operator char*();							// cast to pointer to a string
		operator std::string();						// cast to STL string
		unsigned char& operator [] (int);			// get/set binary value
		bool operator == (char*);					// == to a pointer to a string?
		bool operator == (std::string);				// == to an STL string?
		bool operator == (inlineString);			// == to an inlineString?
		bool operator == (int);						// == to an int?
		bool operator != (char*);					// != to a pointer to a string?
		bool operator != (std::string);				// != to an STL string?
		bool operator != (inlineString);			// != to an inlineString?
		bool operator != (int);						// != to an int?
		bool operator != (char);					// != to a character?

};

///////////////////////////////////////////////////////////////////////////
// End of the header file
///////////////////////////////////////////////////////////////////////////
#endif