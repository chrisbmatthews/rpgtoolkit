//=====================================================
//
//  Basic Startup Program
//  ----------------------
//
//  Look for all lines commented as TBD (to be done)
//  to see what you should change.
//
//=====================================================

//=====================================================
// Preprocessors
//=====================================================
#autolocal
#include "system.prg"

//=====================================================
// Initial settings - you may want to change these
//=====================================================
font("Comic Sans MS")		// Initial font
fontSize(18)			// Font size
bold("on")			// Bold text on
menuGraphic("layout.gif")	// Menu graphic
fightMenuGraphic("mwin.jpg")	// Fighting graphic
winGraphic("mwin.jpg")		// Message window graphic
//=====================================================

//=====================================================
// TBD: Play a title screen file here (remove //)
// mediaPlay("mySong.mid")
//=====================================================

// Clear the screen
clear()

until (done!)
{

	// Draw the title screen
	drawTitle()
	text(17, 10.5, "New Game")
	text(17, 12, "Load Game")
	text(17, 13.5, "Quit")

	// Run a cursor map
	cMap! = createCursorMap()
	cursorMapAdd(295, 180, cMap!)
	cursorMapAdd(295, 210, cMap!)
	cursorMapAdd(295, 230, cMap!)
	res! = cursorMapRun(cMap!)
	killCursorMap(cMap!)

	// Switch on the outcome
	switch (res!)
	{
		case(0)
		{
			// New game
			history()
			done! = true
		}
		case(1)
		{
			// Load game
			dest$ = dirSav()
			if (dest$ ~= "CANCEL")
			{
				load(dest$)
				done! = true
			}
		}
		case(2)
		{
			// End game
			windows()
		}
	}
}

//=====================================================
// Draw the title screen
//=====================================================
method drawTitle()
{
	clear()
	text(1, 1, "Test Game")
	// TBD: Set some graphic for your title screen (remove //)
	// Bitmap("title.gif")
}

//=====================================================
// Display the story
//=====================================================
method history()
{
	mwin("Your story goes here...")
	pause()
	mwincls()
}
