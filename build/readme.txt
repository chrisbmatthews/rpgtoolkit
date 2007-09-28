======================================================================
RPGTOOLKIT DEVELOPMENT SYSTEM, VERSION 3.1.0
======================================================================
September 2007

i.	Prelude
ii.	The System Is Not Bug Free
iii.	Help Files
iv.	Upgrading
iv.i	RPGCode
iv.ii	Boards
iv.iii	Items as overlays
iv.iv	Walking animation frame rate
v.	Vista
vi.	Afterword

i. PRELUDE
----------------------------------------------------------------------

Welcome to release 3.1.0 of the RPGToolkit Development System. 3.1.0 represents a significant advance in the power and versatility of the Toolkit. The engine has been rewritten in C++ and includes a new RPGCode interpreter and vectorial collision system. The board editor has been rewritten and a number of tools added to the editor environment. There have also been important changes to the licensing of the Toolkit: the program is now released under the GNU General Public License (GPL), which ensures that the Toolkit will always be protected as open source software.

ii. THE SYSTEM IS NOT BUG FREE
----------------------------------------------------------------------

In a project of this magnitude there will always be bugs. The new engine has been through an extensive testing stage but we anticipate the need to make further small releases to address bugs that have slipped through the net. On the plus side, some old bugs in the engine have been implicitly eliminated by rewriting the engine (though some fundamental bugs may still exist).

iii. HELP FILES
----------------------------------------------------------------------

A number of the help file pages have been rewritten or updated in accordance with the changes to the editor and engine. We recommend that you look at the new board editor, vector tutorial and RPGCode overview pages, which have changed significantly. (Thanks goes to Occasionally_Correct for the new RPGCode pages.)

iv. UPGRADING
----------------------------------------------------------------------

The addition of new features has necessitated changes in the Toolkit's functionality, such that some aspects of games made in version 3.0.6 may not work without modification or upgrade; i.e., we cannot guarantee backwards compatibility. However, we provide tools to help upgrade games to work with 3.1.0. These include an RPGCode updater and board tile-to-vector and coordinate conversion routines. Even still, you will need to spend time ensuring that your games are fully upgraded and please make sure you have done this before posting any queries about bugs or errors.

iv.i RPGCODE
----------------------------------------------------------------------

A number of changes have been made to RPGCode to make it compatible with the new interpreter, which have the potential to improve program performance. The previous interpreter allowed users to write 'scrappy' code that was syntactically ambiguous or incorrect but still executed - the cost this freedom was slow execution. By conforming to stricter language rules, program performance can be improved, as the interpreter does not have to resolve or allow mistakes by the users. The principal changes to RPGCode are:

- Strings must be quoted
	mwin("this is a string")	// Correct
	mwin(this is a string)		// Incorrect
- Variables types are dynamic (there is no difference between 'numeric' and 'literal' variables, identifiers ! and $ are not required)
	var = 12
	var = "this is a string"
- = is not the same as ==
	x = 12				// Assigns a value of 12 to x
	if (x == 12)			// Is x equal to 12?
	if (x = 12)			// Assigns a value of 12 to x and returns x - probably unintended

An RPGCode updater has been written to apply these and other changes to programs written in 3.0.6 to make them more compatible with 3.1.0. Before you attempt to run games in 3.1.0, you should run the updater on all of your game's programs, except those containing classes. The updater does not recognise classes and will corrupt class programs. These should be updated manually. The updater can be found in the Tools menu of the Program Editor. Whilst the updater has been tested thoroughly, there may be instances where you need to manually edit your programs to resolve more complex errors. If you have maintained a good coding practise, this will be less likely.

iv.ii BOARDS
----------------------------------------------------------------------

All collision is now handled 'vectorially', which means that tiles are converted to vectors by the engine and board editor. This occurs silently when 3.0.6 boards are run or loaded. 3.0.6 boards may be run unedited in the engine, however we recommend that you open your boards in the editor, check them and resave them to upgrade the format. In some instances you may wish to correct the way the Toolkit has converted tiles to vectors. 

Additionally, you have the option to upgrade the coordinate system of the board. Previously, all coordinates were in tile units, and isometric boards had a complex numbering system. Two new 'coordinate systems' have been introduced, the first providing a more intuitive isometric numbering system, the second providing a simple pixel coordinate system. Board coordinate systems can be upgraded through the Board menu in the Board Editor. If you choose to alter the coordinate system the coordinates of all objects on boards are updated accordingly; however, RPGCode programs that refer to coordinates will not be updated.

iv.iii ITEMS AS OVERLAYS
----------------------------------------------------------------------

Many people use items to create the effect that sprites are moving under static objects (such as doorways), because of the undesirable whole-sprite translucency effect that occurs when sprites move under board tiles. One aim of 3.1.0 was to rectify this situation by implementing 'partial translucency' when sprites move under board tiles, and this has been achieved. Additionally, non-tile images may be placed on layers alongside tiles. The rendering routines have been rewritten in order to produce this effect, and as a consequence the previous method of using items as whole-screen overlays may cause a significant slow-down to the engine. Therefore it is recommended that users manually convert these items to tiles or images-on-layers (the board editor now supports tile bitmap placing so this should be relatively easy). Use the new function spriteTranslucency() to control the visibility of sprites behind objects.

iv.iv WALKING ANIMATION FRAME RATE
----------------------------------------------------------------------

The speed at which walking animation frames change is now determined by the speed of the animation itself, rather than the speed at which the sprite moves. Users may need to alter their animations to set the desired frame rate.

v. VISTA
----------------------------------------------------------------------

We can offer no guarantees of compatiblity with Windows Vista, but experience with previous versions suggests that you may have some success by running the Toolkit as an admin, by choosing the option in the right-click menu.

vi. AFTERWORD
----------------------------------------------------------------------

Version 3.1.0 has been in development for over two years and, whilst we could have continued testing until each and every tiny bug was eliminated, we felt that the system was now stable enough to be released. We are both proud of what we have achieved and grateful to the testers and wider community for the support and patience they have given us.

- Colin Fitzpatrick and Jonathan Hughes