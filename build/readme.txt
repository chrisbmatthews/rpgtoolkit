======================================================================
RPGTOOLKIT DEVELOPMENT SYSTEM, VERSION 3.0.6
======================================================================

i.	Prelude
ii.	The System Is Not Bug Free
iii.	Help Files
iv.	Threading
v.	Afterword

i. PRELUDE
----------------------------------------------------------------------

Welcome to release 3.0.6 of the RPGToolkit Development System! In this version, we, the development team, have aimed to correct the majority of the bugs found in previous versions of the Toolkit. This readme file contains several timely pieces of information too miscellaneous to have been found in other places. To ensure the most successful experience possible with the system, we highly recommend you read it.

ii. THE SYSTEM IS NOT BUG FREE
----------------------------------------------------------------------

While we have put forth a great amount of time and effort to increase the stability of the Toolkit, this is by no means a bug free release. If you believe you have located a bug, first read the Help File's Frequently Asked Questions and Technical Issues pages to see whether your problem is known. If it is not, please make a post on the Suggestions, Bugs, and General Questions at The Toolkit Zone (http://toolkitzone.com). Be sure to include as many relevant details as possible, as well as your system's statistics, and other hardware information.

iii. HELP FILES
----------------------------------------------------------------------

For this release, the help files (Help -> User's Guide) have been completely rewritten. We encourage you, especially if you are a new user, to peruse these files. All suggestions are welcome, and we hope you find the documents informative and helpful.

iv. THREADING
----------------------------------------------------------------------

In the previous release, threading was largely broken. 3.0.6 has rectified threading so that it should work fully and completely. However, it is worth noting that code within methods does not thread. This is because methods will run in the global process, not your thread. Fortunately, this is not a sacrifice of power; rather, just a call to warning. Consider the following:

while (true) { func() }
method func()
{
	for (i! = 0; i! < 99; i!++)
	{
		// Stuff
	}
}

The above code will probably cause a notable speed loss, and could be better written as follows:

while (true)
{
	for (i! = 0; i! < 99; i!++)
	{
		func(i!)
	}
}
method func(i!)
{
	// Stuff
}

The general idea is simple: keep the time consuming stuff in the main process.

v. AFTERWORD
----------------------------------------------------------------------

It has been months in the making, and we're glad to finally release 3.0.6 to the world. This version marks prominent stability for the 3.x series; we're glad to be offering this, and we hope you enjoy using the software!

- The TK3 Dev Team