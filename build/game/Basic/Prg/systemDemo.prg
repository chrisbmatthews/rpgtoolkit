//-----------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE
// Read LICENSE.txt for licensing info
//-----------------------------------------------------------

//-----------------------------------------------------------
// RPGToolkit, Version 3.05 - System Library Demonstration
//-----------------------------------------------------------

//-----------------------------------------------------------
// Inclusions
//-----------------------------------------------------------
#include "system.prg" 	// The system library

//-----------------------------------------------------------
// Main entry point
//-----------------------------------------------------------
method main()
{

	// Use the console stream to greet the user
	cio << "Hello!" << CioLine()
	cio << "This is a demonstration of the system library." << CioLine()
	cio << "Press [almost] any key to continue" << CioLine() << CioLine()

	// Wait for a key, but ignore arrows
	pause()

	// Ask the user to input a number
	cio << "Please input a huge number: "

	// Take in the number
	cio >> num!

	// Tell the user what they typed
	cio << CioLine() << CioLine() << "You typed: " << delimeNumber(num!, ", ")
	pause() // Wait for a key

	// Clear the screen
	cio->clear()

	// Ask them to enter five more things
	cio << "Please enter five strings (can be one letter [whatever you want]): "
	cio << CioLine() << CioLine()

	// Create an array
	local(anArray!)
	anArray = CArray(4) // Runs from 0 - 4

	// Just for kicks, get its bound
	local(ub!)
	ub!= anArray->getBound()

	// Iterate over each element
	local(i!)
	for (i! = 0; i! <= ub!; i!++)
	{
		// Get a value for it
		local(str$)
		cio >> str$ << CioLine()
		anArray[i!] = CioText(str$)
	}

	// Create a file object
	local(file!)
	file = CFile("test.txt", "misc")

	// Iterate over the array (saving it to the file)
	for (i! = 0; i! <= ub!; i!++)
	{
		// Write to the file
		file << anArray[i!]
		// Clear the array element
		anArray[i!] = ""
	}

	// Switch file modes (to read)
	file->changeMode()

	// Read back into the array
	for (i! = 0; i! <= ub!; i!++)
		file >> anArray[i!]

	// Free the file
	file->release()

	// Display the contents of the array
	cio << CioLine() << "What you typed was saved to a file:"
	cio << CioLine() << CioLine()
	for (i! = 0; i! <= ub!; i!++)
		// Show this element
		cio << anArray[i!]! << CioLine()

	// Free the array
	anArray->release()

	// Say farewell
	cio << CioLine() << "Thanks for testing (look at the source!)"

	// Wait for a key, ignoring arrays
	pause()

}

