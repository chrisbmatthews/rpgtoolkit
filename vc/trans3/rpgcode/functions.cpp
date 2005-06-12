/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * RPGCode functions.
 */

/*
 * Inclusions.
 */
#include "CProgram/CProgram.h"
#include "parser/parser.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../input/input.h"
#include "../render/render.h"

/*
 * Externals.
 */
extern CGDICanvas *g_cnvRpgCode;

/*
 * Globals.
 */
std::string g_fontFace = "Arial";		// Font face.
int g_fontSize = 20;					// Font size.
COLORREF g_color = RGB(255, 255, 255);	// Current colour.
BOOL g_bold = FALSE;					// Bold enabled?
BOOL g_italic = FALSE;					// Italics enabled?
BOOL g_underline = FALSE;				// Underline enabled?

/*
 * mwin(...)
 * 
 * Description.
 */
CVariant mwin(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * key$ = wait()
 * 
 * Waits for a key to be pressed, and returns the key that was.
 */
CVariant wait(CProgram::PARAMETERS params)
{
	return waitForKey();
}

/*
 * mwincls(...)
 * 
 * Description.
 */
CVariant mwincls(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * send(...)
 * 
 * Description.
 */
CVariant send(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * text(x, y, str[, cnv])
 *
 * Displays text on the screen.
 *
 * x (in) - x position for text
 * y (in) - y position for text
 * str (in) - string to display
 * cnv (in) - canvas to draw to
 */
CVariant text(CProgram::PARAMETERS params)
{
	const int count = params.size();
	if (count != 3 && count != 4)
	{
		CProgram::debugger("text() requires 3 or 4 parameters!");
		return CVariant();
	}
	CGDICanvas *cnv = (count == 3) ? g_cnvRpgCode : reinterpret_cast<CGDICanvas *>(int(params[3].getNum()));
	cnv->DrawText(params[0].getNum() * g_fontSize - g_fontSize, params[1].getNum() * g_fontSize - g_fontSize, params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	if (count == 3)
	{
		renderRpgCodeScreen();
	}
	return CVariant();
}

/*
 * pixelText(x, y, str[, cnv])
 *
 * Displays text on the screen using pixel coordinates.
 *
 * x (in) - x position for text
 * y (in) - y position for text
 * str (in) - string to display
 * cnv (in) - canvas to draw to
 */
CVariant pixeltext(CProgram::PARAMETERS params)
{
	const int count = params.size();
	if (count != 3 && count != 4)
	{
		CProgram::debugger("pixelText() requires 3 or 4 parameters!");
		return CVariant();
	}
	CGDICanvas *cnv = (count == 3) ? g_cnvRpgCode : reinterpret_cast<CGDICanvas *>(int(params[3].getNum()));
	cnv->DrawText(params[0].getNum(), params[1].getNum(), params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	if (count == 3)
	{
		renderRpgCodeScreen();
	}
	return CVariant();
}

/*
 * label(...)
 * 
 * Description.
 */
CVariant label(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mbox(...)
 * 
 * Description.
 */
CVariant mbox(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * branch(...)
 * 
 * Description.
 */
CVariant branch(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * change(...)
 * 
 * Description.
 */
CVariant change(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * clear([cnv!])
 * 
 * Clears a surface.
 */
CVariant clear(CProgram::PARAMETERS params)
{
	if (params.size() != 0)
	{
		CGDICanvas *cnv = (CGDICanvas *)(int)params[0].getNum();
		cnv->ClearScreen(0);
	}
	else
	{
		g_cnvRpgCode->ClearScreen(0);
		renderRpgCodeScreen();
	}
	return CVariant();
}

/*
 * done(...)
 * 
 * Description.
 */
CVariant done(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * dos()
 * 
 * Exit to windows.
 */
CVariant dos(CProgram::PARAMETERS params)
{
	PostQuitMessage(0);
	return CVariant();
}

/*
 * windows()
 * 
 * Exit to windows.
 */
CVariant windows(CProgram::PARAMETERS params)
{
	PostQuitMessage(0);
	return CVariant();
}

/*
 * empty(...)
 * 
 * Description.
 */
CVariant empty(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * end(...)
 * 
 * Description.
 */
CVariant end(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * font(font$)
 * 
 * Load a font, either true type or TK2.
 */
CVariant font(CProgram::PARAMETERS params)
{
	g_fontFace = params[0].getLit();
	return CVariant();
}

/*
 * fontsize(size!)
 * 
 * Set the font size.
 */
CVariant fontsize(CProgram::PARAMETERS params)
{
	g_fontSize = params[0].getNum();
	return CVariant();
}

/*
 * fade(...)
 * 
 * Description.
 */
CVariant fade(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fbranch(...)
 * 
 * Description.
 */
CVariant fbranch(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fight(...)
 * 
 * Description.
 */
CVariant fight(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * get(...)
 * 
 * Description.
 */
CVariant get(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gone(...)
 * 
 * Description.
 */
CVariant gone(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * viewbrd(...)
 * 
 * Description.
 */
CVariant viewbrd(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * bold(on/off)
 * 
 * Toggle emboldening of text.
 */
CVariant bold(CProgram::PARAMETERS params)
{
	g_bold = (parser::uppercase(params[0].getLit()) == "ON");
	return CVariant();
}

/*
 * italics(on/off)
 * 
 * Toggle italicizing of text.
 */
CVariant italics(CProgram::PARAMETERS params)
{
	g_italic = (parser::uppercase(params[0].getLit()) == "ON");
	return CVariant();
}

/*
 * underline(on/off)
 * 
 * Toggle underlining of text.
 */
CVariant underline(CProgram::PARAMETERS params)
{
	g_underline = (parser::uppercase(params[0].getLit()) == "ON");
	return CVariant();
}

/*
 * wingraphic(...)
 * 
 * Description.
 */
CVariant wingraphic(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wincolor(...)
 * 
 * Description.
 */
CVariant wincolor(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wincolorrgb(...)
 * 
 * Description.
 */
CVariant wincolorrgb(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * color(...)
 * 
 * Description.
 */
CVariant color(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * colorrgb(r!, g!, b!)
 * 
 * Change the active colour to a RGB value.
 */
CVariant colorrgb(CProgram::PARAMETERS params)
{
	if (params.size() != 3)
	{
		CProgram::debugger("ColorRGB() requires three parameters.");
	}
	else
	{
		g_color = RGB(params[0].getNum(), params[1].getNum(), params[2].getNum());
	}
	return CVariant();
}

/*
 * move(...)
 * 
 * Description.
 */
CVariant move(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * newplyr(...)
 * 
 * Description.
 */
CVariant newplyr(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * over(...)
 * 
 * Description.
 */
CVariant over(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * prg(...)
 * 
 * Description.
 */
CVariant prg(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * prompt(...)
 * 
 * Description.
 */
CVariant prompt(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * put(x!, y!, tile$)
 * 
 * Put tile$ at x!, y! on the board.
 */
CVariant put(CProgram::PARAMETERS params)
{
	if (params.size() != 3)
	{
		CProgram::debugger("Put() requires three parameters.");
	}
	else
	{
		// getAmbientLevel();
		drawTileCnv(g_cnvRpgCode, params[2].getLit(), params[0].getNum(), params[1].getNum(), 0, 0, 0, false, true, false, false);
	}
	return CVariant();
}

/*
 * reset(...)
 * 
 * Description.
 */
CVariant reset(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * run(...)
 * 
 * Description.
 */
CVariant run(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * show(x)
 * 
 * Alias of mwin().
 */
CVariant show(CProgram::PARAMETERS params)
{
	return mwin(params);
}

/*
 * sound()
 * 
 * Depreciated TK1 function.
 */
CVariant sound(CProgram::PARAMETERS params)
{
	CProgram::debugger("Please use TK3's media functions, rather than this TK1 function!");
	return CVariant();
}

/*
 * win()
 * 
 * Wins the game.
 */
CVariant win(CProgram::PARAMETERS params)
{
	CProgram::debugger("Win() is obsolete.");
	return CVariant();
}

/*
 * hp(...)
 * 
 * Description.
 */
CVariant hp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * givehp(...)
 * 
 * Description.
 */
CVariant givehp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gethp(...)
 * 
 * Description.
 */
CVariant gethp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * maxhp(...)
 * 
 * Description.
 */
CVariant maxhp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getmaxhp(...)
 * 
 * Description.
 */
CVariant getmaxhp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * smp(...)
 * 
 * Description.
 */
CVariant smp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * givesmp(...)
 * 
 * Description.
 */
CVariant givesmp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getsmp(...)
 * 
 * Description.
 */
CVariant getsmp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * maxsmp(...)
 * 
 * Description.
 */
CVariant maxsmp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getmaxsmp(...)
 * 
 * Description.
 */
CVariant getmaxsmp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * start(...)
 * 
 * Description.
 */
CVariant start(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * giveitem(...)
 * 
 * Description.
 */
CVariant giveitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * takeitem(...)
 * 
 * Description.
 */
CVariant takeitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wav(...)
 * 
 * Description.
 */
CVariant wav(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * delay(time!)
 * 
 * Delay for a certain number of seconds.
 */
CVariant delay(CProgram::PARAMETERS params)
{
	if (params.size() != 1)
	{
		CProgram::debugger("Delay() requires one data element.");
	}
	else
	{
		Sleep(params[0].getNum() * 1000);
	}
	return CVariant();
}

/*
 * ret! = random(range![, ret!])
 * 
 * Generate a random number.
 */
CVariant random(CProgram::PARAMETERS params)
{
	return (1 + (rand() % int(params[0].getNum() + 1)));
}

/*
 * push(...)
 * 
 * Description.
 */
CVariant push(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * tiletype(...)
 * 
 * Description.
 */
CVariant tiletype(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * midiplay(...)
 * 
 * Description.
 */
CVariant midiplay(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playmidi(...)
 * 
 * Description.
 */
CVariant playmidi(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mediaplay(...)
 * 
 * Description.
 */
CVariant mediaplay(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mediastop(...)
 * 
 * Description.
 */
CVariant mediastop(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mediarest(...)
 * 
 * Description.
 */
CVariant mediarest(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * midirest(...)
 * 
 * Description.
 */
CVariant midirest(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * godos(command$)
 * 
 * Call into DOS.
 */
CVariant godos(CProgram::PARAMETERS params)
{
	CProgram::debugger("GoDos() is obsolete.");
	return CVariant();
}

/*
 * addplayer(...)
 * 
 * Description.
 */
CVariant addplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * removeplayer(...)
 * 
 * Description.
 */
CVariant removeplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setpixel(x!, y![, cnv!])
 * 
 * Set a pixel in the current colour.
 */
CVariant setpixel(CProgram::PARAMETERS params)
{
	if (params.size() == 2)
	{
		g_cnvRpgCode->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.size() == 3)
	{
		((CGDICanvas *)(int)params[2].getNum())->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
	}
	else
	{
		CProgram::debugger("SetPixel() requires two or three parameters.");
	}
	return CVariant();
}

/*
 * drawline(...)
 * 
 * Description.
 */
CVariant drawline(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drawrect(...)
 * 
 * Description.
 */
CVariant drawrect(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fillrect(...)
 * 
 * Description.
 */
CVariant fillrect(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * debug(...)
 * 
 * Description.
 */
CVariant debug(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * castnum(x)
 * 
 * Return x cast to a number. Pointless now.
 */
CVariant castnum(CProgram::PARAMETERS params)
{
	if (params.size() == 1)
	{
		return params[0].getNum();
	}
	CProgram::debugger("CastNum() requires one parameter.");
	return CVariant();
}

/*
 * castlit(x)
 * 
 * Return x cast to a string. Pointless now.
 */
CVariant castlit(CProgram::PARAMETERS params)
{
	if (params.size() == 1)
	{
		return params[0].getLit();
	}
	CProgram::debugger("CastLit() requires one parameter.");
	return CVariant();
}

/*
 * castint(x)
 * 
 * Return x cast to an integer (i.e., sans fractional pieces).
 */
CVariant castint(CProgram::PARAMETERS params)
{
	if (params.size() == 1)
	{
		return (int)params[0].getNum();
	}
	CProgram::debugger("CastInt() requires one parameter.");
	return CVariant();
}

/*
 * pushitem(...)
 * 
 * Description.
 */
CVariant pushitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wander(...)
 * 
 * Description.
 */
CVariant wander(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * bitmap(...)
 * 
 * Description.
 */
CVariant bitmap(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mainfile(...)
 * 
 * Description.
 */
CVariant mainfile(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * dirsav(...)
 * 
 * Description.
 */
CVariant dirsav(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * save(...)
 * 
 * Description.
 */
CVariant save(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * load(...)
 * 
 * Description.
 */
CVariant load(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * scan(...)
 * 
 * Description.
 */
CVariant scan(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mem(...)
 * 
 * Description.
 */
CVariant mem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * print(...)
 * 
 * Description.
 */
CVariant print(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * rpgcode(...)
 * 
 * Description.
 */
CVariant rpgcode(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * charat(...)
 * 
 * Description.
 */
CVariant charat(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * equip(...)
 * 
 * Description.
 */
CVariant equip(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * remove(...)
 * 
 * Description.
 */
CVariant remove(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * putplayer(...)
 * 
 * Description.
 */
CVariant putplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * eraseplayer(...)
 * 
 * Description.
 */
CVariant eraseplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * include(...)
 * 
 * Description.
 */
CVariant include(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * kill(...)
 * 
 * Description.
 */
CVariant kill(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * givegp(...)
 * 
 * Description.
 */
CVariant givegp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * takegp(...)
 * 
 * Description.
 */
CVariant takegp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getgp(...)
 * 
 * Description.
 */
CVariant getgp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wavstop(...)
 * 
 * Description.
 */
CVariant wavstop(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * bordercolor(...)
 * 
 * Description.
 */
CVariant bordercolor(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fightenemy(...)
 * 
 * Description.
 */
CVariant fightenemy(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * restoreplayer(...)
 * 
 * Description.
 */
CVariant restoreplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * callshop(...)
 * 
 * Description.
 */
CVariant callshop(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * clearbuffer(...)
 * 
 * Description.
 */
CVariant clearbuffer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * attackall(...)
 * 
 * Description.
 */
CVariant attackall(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drainall(...)
 * 
 * Description.
 */
CVariant drainall(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * inn(...)
 * 
 * Description.
 */
CVariant inn(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * targetlocation(...)
 * 
 * Description.
 */
CVariant targetlocation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * eraseitem(...)
 * 
 * Description.
 */
CVariant eraseitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * putitem(...)
 * 
 * Description.
 */
CVariant putitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * createitem(...)
 * 
 * Description.
 */
CVariant createitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * destroyitem(...)
 * 
 * Description.
 */
CVariant destroyitem(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * walkspeed(...)
 * 
 * Description.
 */
CVariant walkspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemwalkspeed(...)
 * 
 * Description.
 */
CVariant itemwalkspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * posture(...)
 * 
 * Description.
 */
CVariant posture(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setbutton(...)
 * 
 * Description.
 */
CVariant setbutton(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * checkbutton(...)
 * 
 * Description.
 */
CVariant checkbutton(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * clearbuttons(...)
 * 
 * Description.
 */
CVariant clearbuttons(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mouseclick(...)
 * 
 * Description.
 */
CVariant mouseclick(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mousemove(...)
 * 
 * Description.
 */
CVariant mousemove(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * zoom(...)
 * 
 * Description.
 */
CVariant zoom(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * earthquake(...)
 * 
 * Description.
 */
CVariant earthquake(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemcount(...)
 * 
 * Description.
 */
CVariant itemcount(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * destroyplayer(...)
 * 
 * Description.
 */
CVariant destroyplayer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * callplayerswap(...)
 * 
 * Description.
 */
CVariant callplayerswap(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playavi(...)
 * 
 * Description.
 */
CVariant playavi(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playavismall(...)
 * 
 * Description.
 */
CVariant playavismall(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getcorner(...)
 * 
 * Description.
 */
CVariant getcorner(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * underarrow(...)
 * 
 * Description.
 */
CVariant underarrow(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getlevel(...)
 * 
 * Description.
 */
CVariant getlevel(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * ai(...)
 * 
 * Description.
 */
CVariant ai(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * menugraphic(...)
 * 
 * Description.
 */
CVariant menugraphic(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fightmenugraphic(...)
 * 
 * Description.
 */
CVariant fightmenugraphic(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fightstyle(...)
 * 
 * Description.
 */
CVariant fightstyle(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * stance(...)
 * 
 * Description.
 */
CVariant stance(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * battlespeed(...)
 * 
 * Description.
 */
CVariant battlespeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * textspeed(...)
 * 
 * Description.
 */
CVariant textspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * characterspeed(...)
 * 
 * Description.
 */
CVariant characterspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mwinsize(...)
 * 
 * Description.
 */
CVariant mwinsize(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getdp(...)
 * 
 * Description.
 */
CVariant getdp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getfp(...)
 * 
 * Description.
 */
CVariant getfp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * internalmenu(...)
 * 
 * Description.
 */
CVariant internalmenu(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * applystatus(...)
 * 
 * Description.
 */
CVariant applystatus(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * removestatus(...)
 * 
 * Description.
 */
CVariant removestatus(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setimage(...)
 * 
 * Description.
 */
CVariant setimage(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drawcircle(...)
 * 
 * Description.
 */
CVariant drawcircle(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fillcircle(...)
 * 
 * Description.
 */
CVariant fillcircle(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * savescreen(...)
 * 
 * Description.
 */
CVariant savescreen(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * restorescreen(...)
 * 
 * Description.
 */
CVariant restorescreen(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * sin(...)
 * 
 * Description.
 */
CVariant sin(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * cos(...)
 * 
 * Description.
 */
CVariant cos(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * tan(...)
 * 
 * Description.
 */
CVariant tan(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getpixel(...)
 * 
 * Description.
 */
CVariant getpixel(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getcolor(...)
 * 
 * Description.
 */
CVariant getcolor(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getfontsize(...)
 * 
 * Description.
 */
CVariant getfontsize(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setimagetransparent(...)
 * 
 * Description.
 */
CVariant setimagetransparent(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setimagetranslucent(...)
 * 
 * Description.
 */
CVariant setimagetranslucent(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mp3(...)
 * 
 * Description.
 */
CVariant mp3(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * sourcelocation(...)
 * 
 * Description.
 */
CVariant sourcelocation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * targethandle(...)
 * 
 * Description.
 */
CVariant targethandle(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * sourcehandle(...)
 * 
 * Description.
 */
CVariant sourcehandle(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drawenemy(...)
 * 
 * Description.
 */
CVariant drawenemy(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mp3pause(...)
 * 
 * Description.
 */
CVariant mp3pause(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * layerput(...)
 * 
 * Description.
 */
CVariant layerput(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getboardtile(...)
 * 
 * Description.
 */
CVariant getboardtile(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * boardgettile(...)
 * 
 * Description.
 */
CVariant boardgettile(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * sqrt(...)
 * 
 * Description.
 */
CVariant sqrt(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getboardtiletype(...)
 * 
 * Description.
 */
CVariant getboardtiletype(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setimageadditive(...)
 * 
 * Description.
 */
CVariant setimageadditive(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * animation(...)
 * 
 * Description.
 */
CVariant animation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * sizedanimation(...)
 * 
 * Description.
 */
CVariant sizedanimation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * forceredraw(...)
 * 
 * Description.
 */
CVariant forceredraw(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemlocation(...)
 * 
 * Description.
 */
CVariant itemlocation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * wipe(...)
 * 
 * Description.
 */
CVariant wipe(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getres(...)
 * 
 * Description.
 */
CVariant getres(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * xyzzy(...)
 * 
 * Description.
 */
CVariant xyzzy(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * statictext(...)
 * 
 * Description.
 */
CVariant statictext(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * pathfind(...)
 * 
 * Description.
 */
CVariant pathfind(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemstep(...)
 * 
 * Description.
 */
CVariant itemstep(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playerstep(...)
 * 
 * Description.
 */
CVariant playerstep(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * redirect(...)
 * 
 * Description.
 */
CVariant redirect(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killredirect(...)
 * 
 * Description.
 */
CVariant killredirect(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killallredirects(...)
 * 
 * Description.
 */
CVariant killallredirects(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * parallax(...)
 * 
 * Description.
 */
CVariant parallax(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * giveexp(...)
 * 
 * Description.
 */
CVariant giveexp(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * animatedtiles(...)
 * 
 * Description.
 */
CVariant animatedtiles(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * smartstep(...)
 * 
 * Description.
 */
CVariant smartstep(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gamespeed(...)
 * 
 * Description.
 */
CVariant gamespeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * thread(...)
 * 
 * Description.
 */
CVariant thread(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killthread(...)
 * 
 * Description.
 */
CVariant killthread(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getthreadid(...)
 * 
 * Description.
 */
CVariant getthreadid(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * threadsleep(...)
 * 
 * Description.
 */
CVariant threadsleep(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * tellthread(...)
 * 
 * Description.
 */
CVariant tellthread(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * threadwake(...)
 * 
 * Description.
 */
CVariant threadwake(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * threadsleepremaining(...)
 * 
 * Description.
 */
CVariant threadsleepremaining(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * local(...)
 * 
 * Description.
 */
CVariant local(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * global(...)
 * 
 * Description.
 */
CVariant global(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * autocommand(...)
 * 
 * Description.
 */
CVariant autocommand(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * createcursormap(...)
 * 
 * Description.
 */
CVariant createcursormap(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killcursormap(...)
 * 
 * Description.
 */
CVariant killcursormap(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * cursormapadd(...)
 * 
 * Description.
 */
CVariant cursormapadd(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * cursormaprun(...)
 * 
 * Description.
 */
CVariant cursormaprun(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * createcanvas(...)
 * 
 * Description.
 */
CVariant createcanvas(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killcanvas(...)
 * 
 * Description.
 */
CVariant killcanvas(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drawcanvas(...)
 * 
 * Description.
 */
CVariant drawcanvas(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * openfileinput(...)
 * 
 * Description.
 */
CVariant openfileinput(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * openfileoutput(...)
 * 
 * Description.
 */
CVariant openfileoutput(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * openfileappend(...)
 * 
 * Description.
 */
CVariant openfileappend(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * openfilebinary(...)
 * 
 * Description.
 */
CVariant openfilebinary(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * closefile(...)
 * 
 * Description.
 */
CVariant closefile(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fileinput(...)
 * 
 * Description.
 */
CVariant fileinput(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fileprint(...)
 * 
 * Description.
 */
CVariant fileprint(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fileget(...)
 * 
 * Description.
 */
CVariant fileget(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fileput(...)
 * 
 * Description.
 */
CVariant fileput(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * fileeof(...)
 * 
 * Description.
 */
CVariant fileeof(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * length(...)
 * 
 * Description.
 */
CVariant length(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * len(...)
 * 
 * Description.
 */
CVariant len(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * instr(...)
 * 
 * Description.
 */
CVariant instr(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getitemname(...)
 * 
 * Description.
 */
CVariant getitemname(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getitemdesc(...)
 * 
 * Description.
 */
CVariant getitemdesc(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getitemcost(...)
 * 
 * Description.
 */
CVariant getitemcost(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getitemsellprice(...)
 * 
 * Description.
 */
CVariant getitemsellprice(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * with(...)
 * 
 * Description.
 */
CVariant with(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * stop(...)
 * 
 * Description.
 */
CVariant stop(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * restorescreenarray(...)
 * 
 * Description.
 */
CVariant restorescreenarray(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * restorearrayscreen(...)
 * 
 * Description.
 */
CVariant restorearrayscreen(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * splicevariables(...)
 * 
 * Description.
 */
CVariant splicevariables(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * split(...)
 * 
 * Description.
 */
CVariant split(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * asc(...)
 * 
 * Description.
 */
CVariant asc(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * chr(...)
 * 
 * Description.
 */
CVariant chr(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * trim(...)
 * 
 * Description.
 */
CVariant trim(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * right(...)
 * 
 * Description.
 */
CVariant right(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * left(...)
 * 
 * Description.
 */
CVariant left(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * cursormaphand(...)
 * 
 * Description.
 */
CVariant cursormaphand(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * debugger(...)
 * 
 * Description.
 */
CVariant debugger(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * onerror(...)
 * 
 * Description.
 */
CVariant onerror(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * resumenext(...)
 * 
 * Description.
 */
CVariant resumenext(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * msgbox(...)
 * 
 * Description.
 */
CVariant msgbox(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setconstants(...)
 * 
 * Description.
 */
CVariant setconstants(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * endcausesstop(...)
 * 
 * Description.
 */
CVariant endcausesstop(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * log(...)
 * 
 * Description.
 */
CVariant log(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * onboard(...)
 * 
 * Description.
 */
CVariant onboard(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * autolocal(...)
 * 
 * Description.
 */
CVariant autolocal(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * getboardname(...)
 * 
 * Description.
 */
CVariant getboardname(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * pixelmovement(...)
 * 
 * Description.
 */
CVariant pixelmovement(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * lcase(...)
 * 
 * Description.
 */
CVariant lcase(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * ucase(...)
 * 
 * Description.
 */
CVariant ucase(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * apppath(...)
 * 
 * Description.
 */
CVariant apppath(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mid(...)
 * 
 * Description.
 */
CVariant mid(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * replace(...)
 * 
 * Description.
 */
CVariant replace(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * endanimation(...)
 * 
 * Description.
 */
CVariant endanimation(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * rendernow(...)
 * 
 * Description.
 */
CVariant rendernow(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * multirun(...)
 * 
 * Description.
 */
CVariant multirun(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * shopcolors(...)
 * 
 * Description.
 */
CVariant shopcolors(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemspeed(...)
 * 
 * Description.
 */
CVariant itemspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playerspeed(...)
 * 
 * Description.
 */
CVariant playerspeed(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * mousecursor(...)
 * 
 * Description.
 */
CVariant mousecursor(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gettextwidth(...)
 * 
 * Description.
 */
CVariant gettextwidth(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gettextheight(...)
 * 
 * Description.
 */
CVariant gettextheight(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * iif(...)
 * 
 * Description.
 */
CVariant iif(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * itemstance(...)
 * 
 * Description.
 */
CVariant itemstance(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * playerstance(...)
 * 
 * Description.
 */
CVariant playerstance(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * drawcanvastransparent(...)
 * 
 * Description.
 */
CVariant drawcanvastransparent(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * gettickcount(...)
 * 
 * Description.
 */
CVariant gettickcount(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setvolume(...)
 * 
 * Description.
 */
CVariant setvolume(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * createtimer(...)
 * 
 * Description.
 */
CVariant createtimer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * killtimer(...)
 * 
 * Description.
 */
CVariant killtimer(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * setmwintranslucency(...)
 * 
 * Description.
 */
CVariant setmwintranslucency(CProgram::PARAMETERS params)
{
	return CVariant();
}

/*
 * Initialize RPGCode.
 */
void initRpgCode(void)
{
	// List of functions.
	CProgram::addFunction("mwin", mwin);
	CProgram::addFunction("wait", wait);
	CProgram::addFunction("mwincls", mwincls);
	CProgram::addFunction("send", send);
	CProgram::addFunction("text", text);
	CProgram::addFunction("pixeltext", pixeltext);
	CProgram::addFunction("label", label);
	CProgram::addFunction("mbox", mbox);
	CProgram::addFunction("branch", branch);
	CProgram::addFunction("change", change);
	CProgram::addFunction("clear", clear);
	CProgram::addFunction("done", done);
	CProgram::addFunction("dos", dos);
	CProgram::addFunction("windows", windows);
	CProgram::addFunction("empty", empty);
	CProgram::addFunction("end", end);
	CProgram::addFunction("font", font);
	CProgram::addFunction("fontsize", fontsize);
	CProgram::addFunction("fade", fade);
	CProgram::addFunction("fbranch", fbranch);
	CProgram::addFunction("fight", fight);
	CProgram::addFunction("get", get);
	CProgram::addFunction("gone", gone);
	CProgram::addFunction("viewbrd", viewbrd);
	CProgram::addFunction("bold", bold);
	CProgram::addFunction("italics", italics);
	CProgram::addFunction("underline", underline);
	CProgram::addFunction("wingraphic", wingraphic);
	CProgram::addFunction("wincolor", wincolor);
	CProgram::addFunction("wincolorrgb", wincolorrgb);
	CProgram::addFunction("color", color);
	CProgram::addFunction("colorrgb", colorrgb);
	CProgram::addFunction("move", move);
	CProgram::addFunction("newplyr", newplyr);
	CProgram::addFunction("over", over);
	CProgram::addFunction("prg", prg);
	CProgram::addFunction("prompt", prompt);
	CProgram::addFunction("put", put);
	CProgram::addFunction("reset", reset);
	CProgram::addFunction("run", run);
	CProgram::addFunction("show", show);
	CProgram::addFunction("sound", sound);
	CProgram::addFunction("win", win);
	CProgram::addFunction("hp", hp);
	CProgram::addFunction("givehp", givehp);
	CProgram::addFunction("gethp", gethp);
	CProgram::addFunction("maxhp", maxhp);
	CProgram::addFunction("getmaxhp", getmaxhp);
	CProgram::addFunction("smp", smp);
	CProgram::addFunction("givesmp", givesmp);
	CProgram::addFunction("getsmp", getsmp);
	CProgram::addFunction("maxsmp", maxsmp);
	CProgram::addFunction("getmaxsmp", getmaxsmp);
	CProgram::addFunction("start", start);
	CProgram::addFunction("giveitem", giveitem);
	CProgram::addFunction("takeitem", takeitem);
	CProgram::addFunction("wav", wav);
	CProgram::addFunction("delay", delay);
	CProgram::addFunction("random", random);
	CProgram::addFunction("push", push);
	CProgram::addFunction("tiletype", tiletype);
	CProgram::addFunction("midiplay", midiplay);
	CProgram::addFunction("playmidi", playmidi);
	CProgram::addFunction("mediaplay", mediaplay);
	CProgram::addFunction("mediastop", mediastop);
	CProgram::addFunction("mediarest", mediarest);
	CProgram::addFunction("midirest", midirest);
	CProgram::addFunction("godos", godos);
	CProgram::addFunction("addplayer", addplayer);
	CProgram::addFunction("removeplayer", removeplayer);
	CProgram::addFunction("setpixel", setpixel);
	CProgram::addFunction("drawline", drawline);
	CProgram::addFunction("drawrect", drawrect);
	CProgram::addFunction("fillrect", fillrect);
	CProgram::addFunction("debug", debug);
	CProgram::addFunction("castnum", castnum);
	CProgram::addFunction("castlit", castlit);
	CProgram::addFunction("castint", castint);
	CProgram::addFunction("pushitem", pushitem);
	CProgram::addFunction("wander", wander);
	CProgram::addFunction("bitmap", bitmap);
	CProgram::addFunction("mainfile", mainfile);
	CProgram::addFunction("dirsav", dirsav);
	CProgram::addFunction("save", save);
	CProgram::addFunction("load", load);
	CProgram::addFunction("scan", scan);
	CProgram::addFunction("mem", mem);
	CProgram::addFunction("print", print);
	CProgram::addFunction("rpgcode", rpgcode);
	CProgram::addFunction("charat", charat);
	CProgram::addFunction("equip", equip);
	CProgram::addFunction("remove", remove);
	CProgram::addFunction("putplayer", putplayer);
	CProgram::addFunction("eraseplayer", eraseplayer);
	CProgram::addFunction("include", include);
	CProgram::addFunction("kill", kill);
	CProgram::addFunction("givegp", givegp);
	CProgram::addFunction("takegp", takegp);
	CProgram::addFunction("getgp", getgp);
	CProgram::addFunction("wavstop", wavstop);
	CProgram::addFunction("bordercolor", bordercolor);
	CProgram::addFunction("fightenemy", fightenemy);
	CProgram::addFunction("restoreplayer", restoreplayer);
	CProgram::addFunction("callshop", callshop);
	CProgram::addFunction("clearbuffer", clearbuffer);
	CProgram::addFunction("attackall", attackall);
	CProgram::addFunction("drainall", drainall);
	CProgram::addFunction("inn", inn);
	CProgram::addFunction("targetlocation", targetlocation);
	CProgram::addFunction("eraseitem", eraseitem);
	CProgram::addFunction("putitem", putitem);
	CProgram::addFunction("createitem", createitem);
	CProgram::addFunction("destroyitem", destroyitem);
	CProgram::addFunction("walkspeed", walkspeed);
	CProgram::addFunction("itemwalkspeed", itemwalkspeed);
	CProgram::addFunction("posture", posture);
	CProgram::addFunction("setbutton", setbutton);
	CProgram::addFunction("checkbutton", checkbutton);
	CProgram::addFunction("clearbuttons", clearbuttons);
	CProgram::addFunction("mouseclick", mouseclick);
	CProgram::addFunction("mousemove", mousemove);
	CProgram::addFunction("zoom", zoom);
	CProgram::addFunction("earthquake", earthquake);
	CProgram::addFunction("itemcount", itemcount);
	CProgram::addFunction("destroyplayer", destroyplayer);
	CProgram::addFunction("callplayerswap", callplayerswap);
	CProgram::addFunction("playavi", playavi);
	CProgram::addFunction("playavismall", playavismall);
	CProgram::addFunction("getcorner", getcorner);
	CProgram::addFunction("underarrow", underarrow);
	CProgram::addFunction("getlevel", getlevel);
	CProgram::addFunction("ai", ai);
	CProgram::addFunction("menugraphic", menugraphic);
	CProgram::addFunction("fightmenugraphic", fightmenugraphic);
	CProgram::addFunction("fightstyle", fightstyle);
	CProgram::addFunction("stance", stance);
	CProgram::addFunction("battlespeed", battlespeed);
	CProgram::addFunction("textspeed", textspeed);
	CProgram::addFunction("characterspeed", characterspeed);
	CProgram::addFunction("mwinsize", mwinsize);
	CProgram::addFunction("getdp", getdp);
	CProgram::addFunction("getfp", getfp);
	CProgram::addFunction("internalmenu", internalmenu);
	CProgram::addFunction("applystatus", applystatus);
	CProgram::addFunction("removestatus", removestatus);
	CProgram::addFunction("setimage", setimage);
	CProgram::addFunction("drawcircle", drawcircle);
	CProgram::addFunction("fillcircle", fillcircle);
	CProgram::addFunction("savescreen", savescreen);
	CProgram::addFunction("restorescreen", restorescreen);
	CProgram::addFunction("sin", sin);
	CProgram::addFunction("cos", cos);
	CProgram::addFunction("tan", tan);
	CProgram::addFunction("getpixel", getpixel);
	CProgram::addFunction("getcolor", getcolor);
	CProgram::addFunction("getfontsize", getfontsize);
	CProgram::addFunction("setimagetransparent", setimagetransparent);
	CProgram::addFunction("setimagetranslucent", setimagetranslucent);
	CProgram::addFunction("mp3", mp3);
	CProgram::addFunction("sourcelocation", sourcelocation);
	CProgram::addFunction("targethandle", targethandle);
	CProgram::addFunction("sourcehandle", sourcehandle);
	CProgram::addFunction("drawenemy", drawenemy);
	CProgram::addFunction("mp3pause", mp3pause);
	CProgram::addFunction("layerput", layerput);
	CProgram::addFunction("getboardtile", getboardtile);
	CProgram::addFunction("boardgettile", boardgettile);
	CProgram::addFunction("sqrt", sqrt);
	CProgram::addFunction("getboardtiletype", getboardtiletype);
	CProgram::addFunction("setimageadditive", setimageadditive);
	CProgram::addFunction("animation", animation);
	CProgram::addFunction("sizedanimation", sizedanimation);
	CProgram::addFunction("forceredraw", forceredraw);
	CProgram::addFunction("itemlocation", itemlocation);
	CProgram::addFunction("wipe", wipe);
	CProgram::addFunction("getres", getres);
	CProgram::addFunction("xyzzy", xyzzy);
	CProgram::addFunction("statictext", statictext);
	CProgram::addFunction("pathfind", pathfind);
	CProgram::addFunction("itemstep", itemstep);
	CProgram::addFunction("playerstep", playerstep);
	CProgram::addFunction("redirect", redirect);
	CProgram::addFunction("killredirect", killredirect);
	CProgram::addFunction("killallredirects", killallredirects);
	CProgram::addFunction("parallax", parallax);
	CProgram::addFunction("giveexp", giveexp);
	CProgram::addFunction("animatedtiles", animatedtiles);
	CProgram::addFunction("smartstep", smartstep);
	CProgram::addFunction("gamespeed", gamespeed);
	CProgram::addFunction("thread", thread);
	CProgram::addFunction("killthread", killthread);
	CProgram::addFunction("getthreadid", getthreadid);
	CProgram::addFunction("threadsleep", threadsleep);
	CProgram::addFunction("tellthread", tellthread);
	CProgram::addFunction("threadwake", threadwake);
	CProgram::addFunction("threadsleepremaining", threadsleepremaining);
	CProgram::addFunction("local", local);
	CProgram::addFunction("global", global);
	CProgram::addFunction("autocommand", autocommand);
	CProgram::addFunction("createcursormap", createcursormap);
	CProgram::addFunction("killcursormap", killcursormap);
	CProgram::addFunction("cursormapadd", cursormapadd);
	CProgram::addFunction("cursormaprun", cursormaprun);
	CProgram::addFunction("createcanvas", createcanvas);
	CProgram::addFunction("killcanvas", killcanvas);
	CProgram::addFunction("drawcanvas", drawcanvas);
	CProgram::addFunction("openfileinput", openfileinput);
	CProgram::addFunction("openfileoutput", openfileoutput);
	CProgram::addFunction("openfileappend", openfileappend);
	CProgram::addFunction("openfilebinary", openfilebinary);
	CProgram::addFunction("closefile", closefile);
	CProgram::addFunction("fileinput", fileinput);
	CProgram::addFunction("fileprint", fileprint);
	CProgram::addFunction("fileget", fileget);
	CProgram::addFunction("fileput", fileput);
	CProgram::addFunction("fileeof", fileeof);
	CProgram::addFunction("length", length);
	CProgram::addFunction("len", len);
	CProgram::addFunction("instr", instr);
	CProgram::addFunction("getitemname", getitemname);
	CProgram::addFunction("getitemdesc", getitemdesc);
	CProgram::addFunction("getitemcost", getitemcost);
	CProgram::addFunction("getitemsellprice", getitemsellprice);
	CProgram::addFunction("with", with);
	CProgram::addFunction("stop", stop);
	CProgram::addFunction("restorescreenarray", restorescreenarray);
	CProgram::addFunction("restorearrayscreen", restorearrayscreen);
	CProgram::addFunction("splicevariables", splicevariables);
	CProgram::addFunction("split", split);
	CProgram::addFunction("asc", asc);
	CProgram::addFunction("chr", chr);
	CProgram::addFunction("trim", trim);
	CProgram::addFunction("right", right);
	CProgram::addFunction("left", left);
	CProgram::addFunction("cursormaphand", cursormaphand);
	CProgram::addFunction("debugger", debugger);
	CProgram::addFunction("onerror", onerror);
	CProgram::addFunction("resumenext", resumenext);
	CProgram::addFunction("msgbox", msgbox);
	CProgram::addFunction("setconstants", setconstants);
	CProgram::addFunction("endcausesstop", endcausesstop);
	CProgram::addFunction("log", log);
	CProgram::addFunction("onboard", onboard);
	CProgram::addFunction("autolocal", autolocal);
	CProgram::addFunction("getboardname", getboardname);
	CProgram::addFunction("pixelmovement", pixelmovement);
	CProgram::addFunction("lcase", lcase);
	CProgram::addFunction("ucase", ucase);
	CProgram::addFunction("apppath", apppath);
	CProgram::addFunction("mid", mid);
	CProgram::addFunction("replace", replace);
	CProgram::addFunction("endanimation", endanimation);
	CProgram::addFunction("rendernow", rendernow);
	CProgram::addFunction("multirun", multirun);
	CProgram::addFunction("shopcolors", shopcolors);
	CProgram::addFunction("itemspeed", itemspeed);
	CProgram::addFunction("playerspeed", playerspeed);
	CProgram::addFunction("mousecursor", mousecursor);
	CProgram::addFunction("gettextwidth", gettextwidth);
	CProgram::addFunction("gettextheight", gettextheight);
	CProgram::addFunction("iif", iif);
	CProgram::addFunction("itemstance", itemstance);
	CProgram::addFunction("playerstance", playerstance);
	CProgram::addFunction("drawcanvastransparent", drawcanvastransparent);
	CProgram::addFunction("gettickcount", gettickcount);
	CProgram::addFunction("setvolume", setvolume);
	CProgram::addFunction("createtimer", createtimer);
	CProgram::addFunction("killtimer", killtimer);
	CProgram::addFunction("setmwintranslucency", setmwintranslucency);
}
