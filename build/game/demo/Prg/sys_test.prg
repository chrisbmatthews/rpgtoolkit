#fontsize( 8)
#AutoCommand()

*******************************************************
**
**  Basic Startup Program.
**  ----------------------
**
**  Look for all lines commented as TBD (to be done)
**  to see what you should change.
**
*******************************************************

*******************************************************
* Some initial settings.  Maybe you want to change these...
fontsize(18)
bold("on")
*******************************************************
menugraphic("layout.gif")
fightmenugraphic("mwin.jpg")


*******************************************************
* TBD: Play a title screen file here...
* MidiPlay("mysong.mid")
*******************************************************

Clear
WinGraphic("mwin.jpg") *Message window graphic

*******************************************************
* Create a cursor map to allow the user to select an option...

done! = 0
while ( done! == 0 )
{
	*draw title screen...
	drawtitle()

	text( 17, 10.5, "New Game" )
	text( 17, 12, "Load Game" )
	text( 17, 13.5, "Quit" )

	cMap! = CreateCursorMap()
	CursorMapAdd( 295, 180, cMap! )
	CursorMapAdd( 295, 210, cMap! )
	CursorMapAdd( 295, 230, cMap! )
	res! = CursorMapRun( cMap! )
	KillCursorMap( cMap! )

	if ( res! == 0 )
	{
		* new game
		history()
		done! = 1
		end
	}
	if ( res! == 1 )
	{
		* load game
	        dirsav(dest$)
	        if(dest$~="CANCEL")
	        {
	            load(dest$)
	            done!=1
	            end
	        }
	}
	if ( res! == 2 )
	{
		* new game
		dos
		done! = 1
		end
	}
}
end


*******************************************************
* This method draws the title screen...
*******************************************************
method drawtitle()
{
    Clear
    * TBD: Set some graphic for your title screen graphic.
    text( 1, 1, "Creature Fish & Bobe" )
    *Bitmap("title.gif")
}

* TBD: Put a stroy here...
method history()
{
	*Main story
        MWin("Your story goes here...")
	Wait(a$)
}





