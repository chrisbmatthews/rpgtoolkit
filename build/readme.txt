RPG Toolkit Development System 3.05
-----------------------------------
December 2004

Welcome to the release of the RPGToolkit 3.05! This readme file addresses miscellaneous notes and information too timely to have been located in other places. To ensure a successful experience with version 3.05, we suggest you read this document. Also, be sure to view history.txt for a complete list of changes to this version.

3.05 Readme - Important!
------------------------

There have some imporant changes to the toolkit in this version that will require users to reset some values in certain game files if you are upgrading. These changes won't prevent you running any games, but not making them may produce results that appear to be bugs.

1. gameSpeed()
--------------
As you may have read, the movement system has been overhauled for this release, and you can now assign players and items individual speeds. You can set each character a speed value (in fractions of a second) in the Graphics window of that character (we recommend 0.05 to 0.2s for normal movement).

As a result, you no longer need to use the gameSpeed() RPGCode command, but you *can* still use it to control the overall speed of the characters (for instance, as a menu option or a runtime program). From 3.05, possible gameSpeed() values range from -4 to +4, where negative values decrease and positive increase speed. It is therefore recommended that you set any initial gameSpeed() calls to 0 (or remove them) so that you observe the "true" speed of the characters.

2. Animation Transparencies
---------------------------
As the result of a bug, it may be required to reset the transparent colour in every frame of every animation, if you find that players appear with their image background colour.

3. Object Oriented Programming
------------------------------
The "RGPCode OOP Overview" showed several pieces of code like this:

method CTest::function(obj)
{
	if (obj->getType() == CTEST)
	{
		// Copy over
		m_myObject = obj!
	}
}

Unfortunately, code like this does not work. Methods must specifiy the type of object they require. Objects passed in can derive from that type if required. The corrected version of code like the above is as follows:

method CTest::function(CTest obj)
{
	// Copy over
	m_myObject = obj!
}

This enables you to make assumptions about the object passed in without worrying about its type. It also allows you to overload the function to take different types of objects. For example, this method could coexist with the above:

method CTest::function(CTestTwo obj)
{
	// Copy over
	m_myObjectTwo = obj!
}

While the advantages of this are incredible, you no longer have an obvious way to take *any* type of object. If you want to acomplish this, you could use the undocumented "interface" keyword. An interface is a class that has no code, and as a result cannot be created directly. Say CTest::function() can take any object, so long as it has a run() method; you might code the following:

interface IRun
{
	method run()
}

method CTest::function(IRun obj)
{
	// Call the object's run method
	obj->run() // Will always succeed
}

The object the caller passes in must derive from IRun to succeed. Because of this property, interfaces cannot be created directly - only inherit. The object the creator passes in might be of a class that looks like this:

class CRun: IRun
{
public:
	method run()
	{
		mwin("In CRun::run()!")
		wait()
		mwincls()
	}
}

Our apologies for any incovenience this may cause you.

4. VB Runtime Files
-------------------
The VB Runtimes have been removed from the download for size reasons. Most users will have these installed anyway, but if you are a Windows 95 user, or you experience problems, download the files from Microsoft and install:

http://www.microsoft.com/downloads/details.aspx?FamilyID=bf9a24f9-b5c5-48f4-8edd-cdf2d29a79d5&DisplayLang=en

---------------------------
If you have any further issues, please let us know at www.toolkitzone.com

Many thanks, the Tk3 Dev Team

December 2004