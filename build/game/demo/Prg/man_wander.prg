//-------------------------------------------------
// 3.1.0 Wander and intercept thread
//-------------------------------------------------

// Return the absolute value of a variable.
method abs(x)
{
	return (x < 0 ? -x : x);
}

// Maximum wandering distance per move.
range = 256;

// Minimum approach to trigger intercept.
intercept = 96;

while(true)
{
	// Obtain the locations of the player and this item.
	playerLocation("frap", px, py, z);
	itemLocation("source", ix, iy, z);
	
	// Intercept the player if they are close by.
	if ((abs(px - ix) < intercept) && (abs(py - iy) < intercept))
	{
		// Pathfind to the player's location. Use the 'pause thread'
		// flag to halt execution until the item reaches its destination.
		itemPath("source", tkMV_PAUSE_THREAD | tkMV_PATHFIND, px, py);

		// When the item reaches its destination, check if the player has
		// moved in the intervening period - if not, lauch an event.
		playerLocation("frap", x, y, z);
		if ((x == px) && (y == py))
		{
			run("man.prg");
			end();
		}
	}
	else
	{
		// Wander to a random point within 'range' of the current location.
		x = random(range * 2) - range;
		y = random(range * 2) - range;
		itemPath("source", tkMV_PAUSE_THREAD | tkMV_PATHFIND, ix + x, iy + y);

	}

	// Pause the thread to slow the item down.
	threadSleep(getThreadId(), 0.2);
}