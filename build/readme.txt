RPG Toolkit Development System 3.0.5
------------------------------------
December 2004

Welcome to the release of the RPGToolkit 3.0.5! If you're upgrading from the previous version, here is some information regarding an upgrade of certain files. If you're new to the Toolkit, you don't need to worry about this, just jump in and start making your game!

View the history.txt for a list of changes for this version.

3.0.5 Readme - Important!
-------------------------

There have some imporant changes to the toolkit in this version that will require users to reset some values in certain game files if you are upgrading. These changes won't prevent you running any games, but not making them may produce results that appear to be bugs.

1. gameSpeed()
--------------
As you may have read, the movement system has been overhauled for this release, and you can now assign players and items individual speeds. You can set each character a speed value (in fractions of a second) in the Graphics window of that character (we recommend 0.05 to 0.2s for normal movement).

As a result, you no longer need to use the gameSpeed() RPGCode command, but you *can* still use it to control the overall speed of the characters (for instance, as a menu option or a runtime program). From 3.0.5, possible gameSpeed() values range from -4 to +4, where negative values decrease and positive increase speed. It is therefore recommended that you set any initial gameSpeed() calls to 0 (or remove them) so that you observe the "true" speed of the characters.

2. Animation Transparencies
---------------------------
As the result of a bug, it may be required to reset the transparent colour in every frame of every animation, if you find that players appear with their image background colour.

3. VB Runtime Files
-------------------
The VB Runtimes have been removed from the download for size reasons. Most users will have these installed anyway, but if you are a Windows 95 user, or you experience problems, download the files from Microsoft and install:

http://www.microsoft.com/downloads/details.aspx?FamilyID=bf9a24f9-b5c5-48f4-8edd-cdf2d29a79d5&DisplayLang=en

---------------------------
If you have any further issues, please let us know at www.toolkitzone.com

Many thanks, the Tk3 Dev Team

December 2004