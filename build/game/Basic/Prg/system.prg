//-----------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE
// Read LICENSE.txt for licensing info
//-----------------------------------------------------------

//-----------------------------------------------------------
// RPGToolkit, Version 3.05 - System Library
//-----------------------------------------------------------

//-----------------------------------------------------------
// A file
//-----------------------------------------------------------
class CFile
{

//
// Public visibility
//
public:

	//
	// Construct a file
	//
	method CFile(file$, folder$)
	{
		m_file$ = file$
		m_folder$ = folder$
		openFileBinary(m_file$, m_folder$)
		g_files[m_folder$][m_file$]!++
	}

	//
	// Copy constructor
	//
	method CFile(CFile rhs)
	{
		m_file$ = rhs->getFile()
		m_folder$ = rhs->getFolder()
		m_ptr! = rhs->getFilePtr()
		g_files[m_folder$][m_file$]!++
	}

	//
	// Write a number to the file
	//
	method operator<<(in!)
	{
		writeBytes(8, in!)
		returnMethod(this)
	}

	//
	// Write a string to the file
	//
	method operator<<(in$)
	{
		if (m_mode! == 0) {m_mode! = 1}
		if (m_mode! == 1)
		{
			local(i!)
			local(len!)
			len! = len(in$)
			for (i! = 1; i! <= len!; i!++)
			{
				filePut(m_file$, charAt(in$, i!))
				m_ptr!++
			}
			filePut(m_file$, chr(0))
			m_ptr!++
		}
		else
		{
			debugger("Call changeMode() before writing!")
		}
		returnMethod(this)
	}

	//
	// Read from the file
	//
	method operator>>(out$)
	{
		if (m_mode! == 0) {m_mode! = 2}
		if (m_mode! == 2)
		{
			local(done!)
			local(char$)
			local(null$)
			local(toRet$)
			null$ = chr(0)
			until (done!)
			{
				char$ = fileGet(m_file$)
				if (char$ == null$) {done! = true}
				else {toRet$ += char$}
				m_ptr!++
			}
			out$ = toRet$
		}
		else
		{
			out$ = ""
			debugger("Call changeMode() before reading!")
		}
		returnMethod(out$)
		returnMethod(this)
	}

	//
	// Read a number from the file
	//
	method operator>>(out!)
	{
		out! = readBytes(8)
		returnMethod(out!)
		returnMethod(this)
	}

	//
	// Write a number to the file
	//
	method writeBytes(bytes!, num!)
	{
		if (m_mode! == 0) {m_mode! = 1}
		if (m_mode! ~= 1)
		{
			debugger("Call changeMode() before writing!")
		}
		else
		{
			local(i!)
			for (i! = 1; i! <= bytes!; i!++)
			{
				local(prev!)
				prev! = i! - 1
				toWrite! = num! >> 8 * prev!
				toWrite! &= 255
				filePut(m_file$, chr(toWrite!))
				m_ptr!++
			}
		}
	}

	//
	// Read a number from the file
	//
	method readBytes(bytes!)
	{
		if (m_mode! == 0) {m_mode! = 2}
		if (m_mode! ~= 2)
		{
			debugger("Call changeMode() before reading!")
		}
		else
		{
			local(i!)
			local(raw!)
			local(prev!)
			local(toRet!)
			for (i! = 1; i! <= bytes!; i!++)
			{
				raw! = asc(fileGet(m_file$))
				prev! = i! - 1
				raw! <<= prev!
				toRet! |= raw!
				m_ptr!++
			}
			returnMethod(toRet!)
		}
	}

	//
	// Change current access mode
	//
	method changeMode()
	{
		if (m_mode! ~= 0)
		{
			m_ptr! = 0
			closeFile(m_file$)
			openFileBinary(m_file$, m_folder$)
			if (m_mode! == 1) {m_mode! = 2}
			else {m_mode! = 1}
		}
	}

	//
	// Check filename
	//
	method getFile() {returnMethod(m_file$)}

	//
	// Check folder
	//
	method getFolder() {returnMethod(m_folder$)}

	//
	// Check current access mode
	//
	method getMode() {returnMethod(m_mode!)}

	//
	// Check location in file
	//
	method getFilePtr() {returnMethod(m_ptr!)}

	//
	// Deconstruct the file
	//
	method ~CFile()
	{
		g_files[m_folder$][m_file$]!--
		if (! g_files[m_folder$][m_file$]!)
		{
			kill(g_files[m_folder$][m_file$]!)
			closeFile(m_file$)
		}
	}

//
// Private visibility
//
private:

	m_file$	// Filename of the file
	m_folder$	// Folder the file is in
	m_mode!	// Current access mode
	m_ptr!	// Location in file

}

//-----------------------------------------------------------
// A console
//-----------------------------------------------------------

//
// The main stream object--cio--is an instance of the CScreen class.
// You can write to the screen with <<, sending it varying objects,
// and you can read from the stream into a literal variable.
//
class CScreen
{

//
// Public visibility
//
public:

	//
	// Construct the stream
	//
	method CScreen(x!, y!)
	{
		// Use the numbers passed in
		m_x! = x!
		m_y! = y!
	}
	method CScreen()
	{
		// Start at 1, 1
		m_x! = 1
		m_y! = 1
	}

	//
	// Clear the screen
	//
	method clear()
	{
		clear()
		m_x! = 1
		m_y! = 1
		m_str$ = ""
	}

	//
	// Write a string to the stream
	//
	method operator<<(in$)
	{
		// Send in a CioText() of the string
		this << CioText(in$)
	}

	//
	// Write a number to the stream
	//
	method operator<<(in!)
	{
		// Send in a CioText() of the number cast to a string
		this << CioText(castLit(in!))
	}

	//
	// Write a CioText object to the stream
	//
	method operator<<(CioText in)
	{
		pixelText(m_x!, m_y!, in)
		m_x! += getTextWidth(in)
		m_str$ += in
		returnMethod(this)
	}

	//
	// Move to a different location
	//
	method operator<<(CioMove in)
	{
		m_x! += getTextWidth(right(m_str$, in->getX()))
		m_y! += in->getY()
		returnMethod(this)
	}

	//
	// Move to the next line
	//
	method operator<<(CioLine in)
	{
		m_x! = 1
		m_y! += getFontSize()
		m_str$ = ""
		returnMethod(this)
	}

	//
	// Read a literal value from the stream
	//
	method operator>>(dest$)
	{
		local(done!)
		local(key$)
		local(shift!)
		local(asc!)
		dest$ = ""
		until (done!)
		{
			wait(key$)
			asc! = asc(key$)
			if (! shift!) {key$ = LCase(key$)}
			if (asc! == 16) {shift! = shift! == false}
			else
			{
				if (UCase(key$) ~= "ENTER")
				{
					this << CioText(key$)
					dest$ += key$
				}
				else
					// All done
					done! = true
			}
		}
		returnMethod(dest$)
		returnMethod(this)
	}

	//
	// Read a numerical value from the stream
	//
	method operator>>(dest!)
	{
		local(done!)
		local(dest$)
		local(key$)
		local(shift!)
		local(asc!)
		dest$ = ""
		until (done!)
		{
			wait(key$)
			if (UCase(key$) == "ENTER")
				// All done
				done! = true
			else
			{
				asc! = asc(key$)
				if (asc! >= 48 && asc! <= 57)
				{
					this << CioText(key$)
					dest$ += key$
				}
			}
		}
		dest! = castNum(dest$)
		returnMethod(dest!)
		returnMethod(this)
	}

	//
	// Get current x location
	//
	method getX() {returnMethod(m_x!)}

	//
	// Get current y location
	//
	method getY() {returnMethod(m_y!)}

	//
	// Set current x location
	//
	method setX(x!) {m_x! = x!}

	//
	// Set current y location
	//
	method setY(y!) {m_y! = y!}

	//
	// Move to a new location
	//
	method moveTo(x!, y!)
	{
		m_x! = x!
		m_y! = y!
	}

//
// Private visibility
//
private:

	m_x!		// Current x coordinate
	m_y!		// Current y coordinate
	m_str$	// Current line

}

//
// The main console object
//
#global cio CScreen()

//
// Passing a CioText object to a CStream outputs text to the stream
// and moves the current position horizontally.
//   cio << CScreenText("Hello, world!")
//
class CioText
{

//
// Public visibility
//
public:

	//
	// Construct a CioText
	//
	method CioText(str$)
	{
		m_str$ = str$
	}

	//
	// Cast to string
	//
	method operator$() {returnMethod(&m_str$)}

//
// Private visibility
//
private:

	m_str$	// The string

}

//
// Passing a CioMove object to a CStream moves the current position
// by x, y *characters*, not pixels
//   cio << CioMove(2, 2)
//
class CioMove
{

//
// Public visibility
//
public:

	//
	// Construct a CioMove
	//
	method CioMove(x!, y!)
	{
		m_xDiff! = x!
		m_yDiff! = y! * getFontSize()
	}

	//
	// Get the x coord
	//
	method getX() {returnMethod(m_xDiff!)}

	//
	// Get the y coord
	//
	method getY() {returnMethod(m_yDiff!)}

//
// Private visibility
//
private:

	m_xDiff! // Width to move
	m_yDiff! // Height to move

}

//
// Passing a CioLine to a CScreen positions the cursor on the start
// of the next line.
//   cio << CioText("One") << CioLine() << CioText("Two")
//
class CioLine {}

//-----------------------------------------------------------
// An array
//-----------------------------------------------------------
class CArray
{

//
// Public visibility
//
public:

	//
	// Default constructor
	//
	method CArray()
	{
		// Create dynamic array
		m_bound! = -1
		m_isDynamic! = true
	}

	//
	// Construct with set size
	//
	method CArray(upperBound!)
	{
		if (upperBound! >= 0)
			// Bound is okay
			m_bound! = upperBound!

		else
			// Bound is no good
			debugger("Invalid upper bound: " + CastLit(upperBound!))
	}

	//
	// Copy constructor
	//
	method CArray(CArray rhs)
	{
		// Copy the rhs into this array
		local(i!)
		local(bound!)
		clean()
		bound! = rhs->getBound()
		m_bound! = bound!
		m_isDynamic! = rhs->isDynamic()
		for (i! = 0; i! <= bound!; i!++)
			// Copy over the rhs' data
			this[i!] = rhs[i!]
	}

	//
	// Assignment operator (copys an array)
	//
	method operator=(CArray rhs)
	{
		local(i!)
		local(bound!)
		clean()
		bound! = rhs->getBound()
		m_bound! = bound!
		m_isDynamic! = rhs->isDynamic()
		for (i! = 0; i! <= bound!; i!++)
			// Copy over the rhs' data
			this[i!] = rhs[i!]
	}

	//
	// Subscript operator
	//
	method operator[](idx!)
	{
		if (m_isDynamic!)
		{
			// Change bound if required
			if (idx! > m_bound!)
				// It needs to be changed
				m_bound! = idx!

			// Return the element
			returnMethod(&m_data[idx!])
		}
		else
		{
			// Check bounds
			if (idx! <= m_bound! && idx! >= 0)
				// Within bounds
				returnMethod(&m_data[idx!])

			else
			{
				// Out of bounds
				debugger("Out of array bounds: " + CastLit(idx!))
				global(g_null!)
				returnMethod(&g_null!)
			}
		}
	}

	//
	// Get the upper bound
	//
	method getBound()
	{
		// Return the upper bound
		returnMethod(m_bound!)
	}

	//
	// Resize the array
	//
	method resize(newSize!)
	{
		if (newSize! >= 0)
			// Bound is okay
			m_bound! = newSize!
	}

	//
	// Determine whether the array is dyamic
	//
	method isDynamic()
	{
		returnMethod(m_isDynamic!)
	}

	//
	// Change dynamic state (true or false)
	//
	method setDynamicState(bState!)
	{
		m_isDynamic! = bState!
	}

	//
	// Deconstructor
	//
	method ~CArray()
	{
		// Clean out the array
		clean()
	}

//
// Private visibility
//
private:

	//
	// Clean out the array
	//
	method clean()
	{
		on error resume next
		local(idx!)
		for (idx! = 0; idx! <= m_bound!; idx!++)
			// Release this object
			m_data[idx!]->release()
	}

	m_data[]		// Main data
	m_bound!		// Upper bound of the array
	m_isDynamic!	// Is a dynamic array?

}

//-----------------------------------------------------------
// A map
//-----------------------------------------------------------
class CMap: CArray
{

//
// Public visibility
//
public:

	//
	// Copy constructor
	//
	method CMap(CMap rhs)
	{
		// Copy the rhs over
		local(i!)
		local(bound!)
		clean()
		bound! = rhs->getBound()
		if (bound!)
			resize(bound!)
		for (i! = 0; i! <= bound!; i!++)
		{
			// Copy this element over
			this[i!] = rhs[i!]
			m_elements[i!]$ = rhs->getElement(i!)
			m_names[m_elements[i!]$]! = i!
		}
	}

	//
	// Subscript operator
	//
	method operator[](idx$)
	{

		// See if we already have this element in the map
		local(loc!)
		loc! = m_names[idx$]!

		if (! loc!)
		{

			// It's not in the map
			local(bound!)
			bound! = getBound() + 1
			if (bound! == 0) {bound! = 1}
			m_names[idx$]! = bound!
			m_elements[bound!]$ = idx$
			returnMethod(&this[bound!])

		}
		else

			// It's in the map
			returnMethod(&this[loc!])

	}

	//
	// Determine is an element is in the map
	//
	method inMap(element$)
	{
		// Return whether it's in the map
		if (m_names[element$]! ~= 0)
			returnMethod(true)
	}

	//
	// Determine whether an index is occupied
	//
	method inMap(idx!)
	{
		// Return whether it's in the map
		if (m_elements[idx!]$ ~= "")
			returnMethod(true)
	}

	//
	// Get the index of an element
	//
	method getIndex(element$)
	{
		// Return the index
		returnMethod(m_names[element$]!)
	}

	//
	// Get the element at an index
	//
	method getElement(idx!)
	{
		// Return the element
		returnMethod(m_elements[idx!]$)
	}

	//
	// Assignment operator (copies a map)
	//
	method operator=(CMap rhs)
	{
		local(i!)
		local(bound!)
		clean()
		bound! = rhs->getBound()
		if (bound!)
			resize(bound!)
		for (i! = 0; i! <= bound!; i!++)
		{
			// Copy this element over
			this[i!] = rhs[i!]
			m_elements[i!]$ = rhs->getElement(i!)
			m_names[m_elements[i!]$]! = i!
		}
	}

//
// Private visibility
//
private:

	//
	// Clean out the map
	//
	method clean()
	{
		on error resume next
		local(i!)
		local(bound!)
		bound! = getBound()
		for (i! = 0; i! <= bound!; i!++)
		{
			// Kill this element
			this[i!]->release()
			local(elem$)
			elem$ = m_elements[i!]$
			m_elements[i!]$ = ""
			m_names[elem$]! = 0
		}
	}

	m_names[]!		// Indicies of map elements
	m_elements[]$	// Elements of indicies

}

//-----------------------------------------------------------
// Wait for a key, ignoring arrow keys
//   returns$ - the key pressed
//-----------------------------------------------------------
method pause()
{
	local(key$)
	key$ = "LEFT"
	until (key$ ~= "LEFT"  && _
		 key$ ~= "RIGHT" && _
		 key$ ~= "UP"    && _
		 key$ ~= "DOWN")
	{
		key$ = wait()
	}
	returnMethod(key$)
}

//-----------------------------------------------------------
// Delime a number for readability
//   num!     - number to delime
//   delimer$ - string to delime with (ie: ", ")
//   returns$ - the result
//-----------------------------------------------------------
method delimeNumber(num!, delimer$)
{

	local(toRet$)	// String to return
	local(str$)		// Number as a string
	local(len!)		// Number of digits in the string
	local(mod!)		// Numbers of digits over and above even triplets
	local(i!)		// Index variable

	// Cast the number to a string
	str$ = CastLit(num!)

	// Get the length of the string (number of digits)
	len! = len(str$)

	// See how many digits run out of triplets
	// "123" -> 0
	// "1234" -> 1
	// "12345" -> 2
	// "123456" -> 0
	mod! = len! % 3

	// Loop over the string starting at the first digit that
	// is part of a triplet of numbers
	for (i! = mod! + 1; i! <= len!; i! += 3)
	{
		// If this is not the left-most triplet
		if (i! ~= 1)
		{
			// Add in the delimiter
			toRet$ += delimer$
		}
		// Add to the return string
		toRet$ += mid(str$, i!, 3)
	}

	// Add numbers not in triplets to the return string
	toRet$ = mid(str$, 1, mod!) + toRet$

	// Return the result
	returnMethod(toRet$)

}

