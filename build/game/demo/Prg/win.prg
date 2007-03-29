//
// Program that runs when pirate.ene is defeated
//

mwin("Arr, ye beat me!");
wait();
mwincls();

// Erase this item from the screen - note: causes the
// item's thread to end.
eraseItem("source");