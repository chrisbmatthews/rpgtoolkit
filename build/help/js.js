//------------------------------------------------------------------------
// All contents copyright 2005, Colin James Fitzpatrick.
// All rights reserved; you may not remove this notice.
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Online Help -- JavaScript
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Globals
//------------------------------------------------------------------------
var g_bUsingIe = false;		// Using Internet Explorer?
var g_currentMenu = null;	// Current menu

//------------------------------------------------------------------------
// Window values
//------------------------------------------------------------------------
window.onload = initialize;	// Main entry point

//------------------------------------------------------------------------
// Hide all menus
//------------------------------------------------------------------------
function hideMenus()
{
	// Hide the divisions
	document.getElementById("editor").style.display = "none";
	document.getElementById("engine").style.display = "none";
	document.getElementById("rpgcode").style.display = "none";
	// document.getElementById("rpgcode_oop").style.display = "none";
	// document.getElementById("rpgcode_features").style.display = "none";
	document.getElementById("troubleshooting").style.display = "none";
	document.getElementById("about").style.display = "none";
}

//------------------------------------------------------------------------
// Show a menu and optionally hide all others
//------------------------------------------------------------------------
function showMenu(div, bNoHideAll)
{

	// No current menu
	g_currentMenu = null;

	// Hide all menus, if flagged
	if (!bNoHideAll) hideMenus();

	// Obtain pointers to the divisions and the link
	var pDiv = document.getElementById(div);
	var pLink = document.getElementById(div + "_link");

	// Show the menu under the link
	var bSubMenu = ((div == "rpgcode_oop") | (div == "rpgcode_features"));
	pDiv.style.left = (pLink.offsetLeft + (bSubMenu ? 190 : 0)) + "px";
	pDiv.style.top = (pLink.offsetTop + 13 - (bSubMenu ? 24 : 0)) + "px";

	// Make the division visible
	pDiv.style.display = "block";

}

//------------------------------------------------------------------------
// Hide a menu after a delay, or optionally now
//------------------------------------------------------------------------
function hideMenu(div, bNow)
{

	// If we're not hiding now
	if (!bNow)
	{

		// Set the current menu global to this division
		g_currentMenu = document.getElementById(div);

		// Internet Explorer?
		if (g_bUsingIe)
		{

			// Make sure we actually left
			if (
				(event.offsetX < 12 || event.offsetX > g_currentMenu.offsetWidth - 30) ||
				(event.offsetY < -50 || event.offsetY > g_currentMenu.offsetHeight - 12)
			   )
			{

				// Hide the menu in 1/5 of a second
				window.setTimeout("if (g_currentMenu) g_currentMenu.style.display = 'none'", 200);

			}

		}
		else
		{

			// Real browsers don't need the check
			window.setTimeout("if (g_currentMenu) g_currentMenu.style.display = 'none'", 200);

		}

	}
	else
	{

		// Just hide now
		document.getElementById(div).style.display = "none";

	}

}

//------------------------------------------------------------------------
// Strip tags from a string
//------------------------------------------------------------------------
function stripTags(str)
{
	var i = -1;
	while ((i = str.indexOf("<")) != -1)
	{
		str = str.substring(0, i) + str.substring(str.indexOf(">") + 1, str.length);
	}
	return str;
}

//------------------------------------------------------------------------
// Initialize the document
//------------------------------------------------------------------------
function initialize()
{

	// Make sure the content area >= 200 pixels in browsers that
	// don't support min-height (namely IE)
	var pContent = document.getElementById("content");
	if (pContent.offsetHeight < 200)
	{
		pContent.style.height = "200px";
	}

	// If we can get elements by their name
	if (document.getElementsByTagName)
	{

		// Get an array of all <a> elements
		var anchors = document.getElementsByTagName("a");
		for (var i = 0; i < anchors.length; i++)
		{

			// Grab the current anchor
			var anchor = anchors[i];

			// If it's an external link
			if (anchor.getAttribute("rel") == "external")
			{
				if (anchor.getAttribute("href"))
				{
					// Set it to open in a new window
					anchor.target = "_blank";
				}
			}

		}

		// Change the title bar
		document.title += stripTags((document.getElementsByTagName("h2"))[0].innerHTML);

	}

}
