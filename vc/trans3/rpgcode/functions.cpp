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
#include "CProgram.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../input/input.h"
#include "../render/render.h"
#include "../audio/CAudioSegment.h"
#include "../common/board.h"
#include "../common/paths.h"
#include "../common/animation.h"
#include "../common/CAllocationHeap.h"
#include "../common/CInventory.h"
#include "../common/CFile.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../images/FreeImage.h"
#include "../fight/fight.h"
#include "CCursorMap.h"
#include <math.h>
#include <iostream>
#include <shellapi.h>

/*
 * Globals.
 */
extern CGDICanvas *g_cnvRpgCode;
std::string g_fontFace = "Arial";			// Font face.
int g_fontSize = 20;						// Font size.
COLORREF g_color = RGB(255, 255, 255);		// Current colour.
BOOL g_bold = FALSE;						// Bold enabled?
BOOL g_italic = FALSE;						// Italics enabled?
BOOL g_underline = FALSE;					// Underline enabled?
unsigned long g_mwinY = 0;					// MWin() y position.
std::string g_mwinBkg;						// MWin() background image.
COLORREF g_mwinColor = 0;					// Mwin() background colour.
CAllocationHeap<CGDICanvas> g_canvases;		// Allocated canvases.
CAllocationHeap<CCursorMap> g_cursorMaps;	// Cursor maps.
void *g_pTarget = NULL;						// Targetted entity.
TARGET_TYPE g_targetType = TI_EMPTY;		// Type of target entity.
void *g_pSource = NULL;						// Source entity.
TARGET_TYPE g_sourceType = TI_EMPTY;		// Type of source entity.
CInventory g_inv;							// Inventory.
unsigned long g_gp = 0;						// Amount of gold.
std::map<std::string, CFile> g_files;		// Files opened using RPGCode.

/*
 * Become ready to run a program.
 */
void programInit()
{
	extern CDirectDraw *g_pDirectDraw;
	g_pDirectDraw->CopyScreenToCanvas(g_cnvRpgCode);
	g_mwinY = 0;
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
}

/*
 * Finish running a program.
 */
void programFinish()
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
}

/*
 * Get a player by name.
 */
IFighter *getFighter(const std::string name)
{
	// Check for "target".
	if (_strcmpi("target", name.c_str()) == 0)
	{
		if (g_targetType == TT_PLAYER || g_targetType == TT_ENEMY)
		{
			return (IFighter *)g_pTarget;
		}
		else
		{
			return NULL;
		}
	}
	// Check for "source".
	if (_strcmpi("source", name.c_str()) == 0)
	{
		if (g_sourceType == TT_PLAYER || g_sourceType == TT_ENEMY)
		{
			return (IFighter *)g_pSource;
		}
		else
		{
			return NULL;
		}
	}
	// Check names of party members.
	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::iterator i = g_players.begin();
	for (; i != g_players.end(); ++i)
	{
		if (_strcmpi((*i)->name().c_str(), name.c_str()) == 0)
		{
			return *i;
		}
	}
	// Doesn't exist.
	return NULL;
}

/*
 * mwin(str$)
 * 
 * Show the message window.
 */
void mwin(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("MWin() requires one parameter.");
	}
	extern CGDICanvas *g_cnvMessageWindow;
	// If this is the first line, draw the background.
	if (g_mwinY == 0)
	{
		if (!g_mwinBkg.empty())
		{
			drawImage(g_mwinBkg, g_cnvMessageWindow, 0, 0, 600, 100);
		}
		else
		{
			g_cnvMessageWindow->ClearScreen(g_mwinColor);
		}
		extern bool g_bShowMessageWindow;
		g_bShowMessageWindow = true;
	}
	// Write the text.
	g_cnvMessageWindow->DrawText(0, g_mwinY, params[0].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	g_mwinY += g_fontSize;
	// Draw the window.
	renderRpgCodeScreen();
}

/*
 * wait([ret])
 * 
 * Waits for a key to be pressed, and returns the key that was.
 */
void wait(CALL_DATA &params)
{
	if (params.params == 0)
	{
		params.ret().udt = UDT_LIT;
		params.ret().lit = waitForKey();
	}
	else if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_LIT;
		var->lit = waitForKey();
	}
	else
	{
		throw CError("Wait() requires zero or one parameters.");
	}
}

/*
 * mwincls()
 * 
 * Clear and hide the message window.
 */
void mwincls(CALL_DATA &params)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
	g_mwinY = 0;
	renderRpgCodeScreen();
}

/*
 * send(file$, x!, y![, z!])
 * 
 * Send the player to a new board.
 */
void send(CALL_DATA &params)
{
	unsigned int layer = 1;
	if (params.params != 3)
	{
		if (params.params != 4)
		{
			throw CError("Send() requires three or four parameters.");
		}
		layer = params[3].getNum();
	}

	extern std::string g_projectPath;
	extern LPBOARD g_pBoard;
	g_pBoard->open(g_projectPath + BRD_PATH + params[0].getLit());

	unsigned int x = params[1].getNum(), y = params[2].getNum();

	/* Co-ordinate system stuff... */
	if (x > g_pBoard->bSizeX)
	{
		CProgram::debugger("Send() location exceeds target board x-dimension.");
		x = g_pBoard->bSizeX;
	}
	if (x < 1)
	{
		CProgram::debugger("Send() x location is less than one.");
		x = 1;
	}
	if (y > g_pBoard->bSizeY)
	{
		CProgram::debugger("Send() location exceeds target board y-dimension.");
		y = g_pBoard->bSizeY;
	}
	if (y < 1)
	{
		CProgram::debugger("Send() y location is less than one.");
		y = 1;
	}

	extern CSprite *g_pSelectedPlayer;

	g_pSelectedPlayer->setPosition(x, y, layer, g_pBoard->coordType);

	g_pSelectedPlayer->send();
}

/*
 * text(x, y, str[, cnv])
 *
 * Displays text on the screen.
 */
void text(CALL_DATA &params)
{
	const int count = params.params;
	if (count != 3 && count != 4)
	{
		throw CError("Text() requires 3 or 4 parameters!");
	}
	CGDICanvas *cnv = (count == 3) ? g_cnvRpgCode : g_canvases.cast(int(params[3].getNum()));
	if (cnv)
	{
		cnv->DrawText(params[0].getNum() * g_fontSize - g_fontSize, params[1].getNum() * g_fontSize - g_fontSize, params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	}
	if (count == 3)
	{
		renderRpgCodeScreen();
	}
}

/*
 * pixelText(x, y, str[, cnv])
 *
 * Displays text on the screen using pixel coordinates.
 */
void pixeltext(CALL_DATA &params)
{
	const int count = params.params;
	if (count != 3 && count != 4)
	{
		throw CError("PixelText() requires 3 or 4 parameters!");
	}
	CGDICanvas *cnv = (count == 3) ? g_cnvRpgCode : g_canvases.cast(int(params[3].getNum()));
	if (cnv)
	{
		cnv->DrawText(params[0].getNum(), params[1].getNum(), params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	}
	if (count == 3)
	{
		renderRpgCodeScreen();
	}
}

/*
 * branch(:label)
 * 
 * Jump to a label.
 */
void branch(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("Branch() requires one parameter.");
	}
	params.prg->jump(params[0].lit);
}

/*
 * change(...)
 * 
 * Description.
 */
void change(CALL_DATA &params)
{

}

/*
 * clear([cnv!])
 * 
 * Clears a surface.
 */
void clear(CALL_DATA &params)
{
	if (params.params != 0)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[0].getNum());
		if (cnv)
		{
			cnv->ClearScreen(0);
		}
	}
	else
	{
		g_cnvRpgCode->ClearScreen(0);
		renderRpgCodeScreen();
	}
}

/*
 * done()
 * 
 * End the program.
 */
void done(CALL_DATA &params)
{
	params.prg->end();
}

/*
 * windows()
 * 
 * Exit to windows.
 */
void windows(CALL_DATA &params)
{
	PostQuitMessage(0);
}

/*
 * empty()
 * 
 * Clear all globals.
 */
void empty(CALL_DATA &params)
{
	params.prg->freeGlobals();
}

/*
 * end()
 * 
 * End the program.
 */
void end(CALL_DATA &params)
{
	params.prg->end();
}

/*
 * font(font$)
 * 
 * Load a font, either true type or TK2.
 */
void font(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("Font() requires one parameter.");
	}
	g_fontFace = params[0].getLit();
}

/*
 * fontsize(size!)
 * 
 * Set the font size.
 */
void fontsize(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("FontSize() requires one parameter.");
	}
	g_fontSize = params[0].getNum();
}

/*
 * fade(...)
 * 
 * Description.
 */
void fade(CALL_DATA &params)
{

}

/*
 * fight(skill!, background$)
 * 
 * Start a skill level fight.
 */
void fight(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("Fight() requires two parameters.");
	}
	skillFight(params[0].getNum(), params[1].getLit());
}

/*
 * get([key$])
 * 
 * Get a key from the queue.
 */
void get(CALL_DATA &params)
{
	params.ret().udt = UDT_LIT;
	extern std::vector<char> g_keys;
	if (g_keys.size() == 0)
	{
		params.ret().lit = "";
		return;
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	std::string toRet;
	switch (chr)
	{
		case 13: toRet = "ENTER"; break;
		case 38: toRet = "UP"; break;
		case 40: toRet = "DOWN"; break;
		case 37: toRet = "RIGHT"; break;
		case 39: toRet = "LEFT"; break;
	}
	if (toRet.empty())
	{
		const char str[] = {chr, '\0'};
		toRet = str;
	}
	if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_LIT;
		var->lit = toRet;
	}
	params.ret().lit = toRet;
}

/*
 * gone(...)
 * 
 * Description.
 */
void gone(CALL_DATA &params)
{

}

/*
 * viewbrd(...)
 * 
 * Description.
 */
void viewbrd(CALL_DATA &params)
{

}

/*
 * bold(on/off)
 * 
 * Toggle emboldening of text.
 */
void bold(CALL_DATA &params)
{
	if (params.params == 1)
	{
		g_bold = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		throw CError("Bold() requires one parameter.");
	}
}

/*
 * italics(on/off)
 * 
 * Toggle italicizing of text.
 */
void italics(CALL_DATA &params)
{
	if (params.params == 1)
	{
		g_italic = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		throw CError("Italics() requires one parameter.");
	}
}

/*
 * underline(on/off)
 * 
 * Toggle underlining of text.
 */
void underline(CALL_DATA &params)
{
	if (params.params == 1)
	{
		g_underline = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		throw CError("Underline() requires one parameter.");
	}
}

/*
 * wingraphic(file$)
 * 
 * Set the message window background image.
 */
void wingraphic(CALL_DATA &params)
{
	if (params.params == 1)
	{
		extern std::string g_projectPath;
		g_mwinBkg = g_projectPath + BMP_PATH + params[0].getLit();
		g_mwinColor = 0;
	}
	else
	{
		throw CError("WinGraphic() requires one parameter.");
	}
}

/*
 * wincolor(dos!)
 * 
 * Set the message window's colour using a DOS code.
 */
void wincolor(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("WinColor() requires one parameter.");
	}
	g_mwinBkg = "";
	int color = params[0].getNum();
	if (color < 0) color = 0;
	else if (color > 255) color = 255;
	g_mwinColor = CTile::getDOSColor(color);
}

/*
 * wincolorrgb(r!, g!, b!)
 * 
 * Set the message window's colour.
 */
void wincolorrgb(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError("WinColorRGB() requires three parameters.");
	}
	g_mwinBkg = "";
	g_mwinColor = RGB(params[0].getNum(), params[1].getNum(), params[2].getNum());
}

/*
 * color(dos!)
 * 
 * Change to a DOS colour.
 */
void color(CALL_DATA &params)
{
	if (params.params == 1)
	{
		int color = params[0].getNum();
		if (color < 0) color = 0;
		else if (color > 255) color = 255;
		g_color = CTile::getDOSColor(color);
	}
	else
	{
		throw CError("Color() requires one parameter.");
	}
}

/*
 * colorrgb(r!, g!, b!)
 * 
 * Change the active colour to an RGB value.
 */
void colorrgb(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError("ColorRGB() requires three parameters.");
	}
	g_color = RGB(params[0].getNum(), params[1].getNum(), params[2].getNum());
}

/*
 * move(...)
 * 
 * Description.
 */
void move(CALL_DATA &params)
{

}

/*
 * newplyr(...)
 * 
 * Description.
 */
void newplyr(CALL_DATA &params)
{

}

/*
 * over(...)
 * 
 * Description.
 */
void over(CALL_DATA &params)
{

}

/*
 * prg(...)
 * 
 * Description.
 */
void prg(CALL_DATA &params)
{

}

/*
 * prompt(...)
 * 
 * Description.
 */
void prompt(CALL_DATA &params)
{

}

/*
 * put(x!, y!, tile$)
 * 
 * Put tile$ at x!, y! on the board.
 */
void put(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError("Put() requires three parameters.");
	}
	// getAmbientLevel();
	drawTileCnv(g_cnvRpgCode, params[2].getLit(), params[0].getNum(), params[1].getNum(), 0, 0, 0, false, true, false, false);
	renderRpgCodeScreen();
}

/*
 * reset(...)
 * 
 * Description.
 */
void reset(CALL_DATA &params)
{

}

/*
 * run(str$)
 * 
 * Transfer control to a different program.
 */
void run(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.prg->end();
		extern std::string g_projectPath;
		CProgram(g_projectPath + PRG_PATH + params[0].getLit()).run();
	}
	else
	{
		throw CError("Run() requires one data element.");
	}
}

/*
 * sound()
 * 
 * Depreciated TK1 function.
 */
void sound(CALL_DATA &params)
{
	throw CError("Please use TK3's media functions, rather than this TK1 function!");
}

/*
 * win()
 * 
 * Wins the game.
 */
void win(CALL_DATA &params)
{
	throw CError("Win() is obsolete.");
}

/*
 * hp(handle$, value!)
 * 
 * Set a fighter's hp.
 */
void hp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("HP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->health((params[0].getNum() <= p->maxHealth()) ? params[0].getNum() : p->maxHealth());
	}
}

/*
 * givehp(handle$, add!)
 * 
 * Increase a fighter's current hp.
 */
void givehp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("GiveHP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int hp = p->health() + params[0].getNum();
		p->health((hp <= p->maxHealth()) ? ((hp > 0) ? hp : 0) : p->maxHealth());
		// if (fighting)
		// {
		//		...
		// }
	}
}

/*
 * gethp(handle$[, ret!])
 * 
 * Get a fighter's hp.
 */
void gethp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->health();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->health();
		}
	}
	else
	{
		throw CError("GetHP() requires one or two parameters.");
	}
}

/*
 * maxhp(handle$, value!)
 * 
 * Set a fighter's max hp.
 */
void maxhp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("MaxHP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->maxHealth(params[1].getNum());
	}
}

/*
 * getmaxhp(handle$[, ret!])
 * 
 * Get a fighter's max hp.
 */
void getmaxhp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->maxHealth();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->maxHealth();
		}
	}
	else
	{
		throw CError("GetMaxHP() requires one or two parameters.");
	}
}

/*
 * smp(handle$, value!)
 * 
 * Set a fighter's smp.
 */
void smp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("SMP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->smp((params[0].getNum() <= p->maxSmp()) ? params[0].getNum() : p->maxSmp());
	}
}

/*
 * givesmp(handle$, value!)
 * 
 * Increase a fighter's smp.
 */
void givesmp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("GiveSMP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int hp = p->smp() + params[0].getNum();
		p->smp((hp <= p->maxSmp()) ? ((hp > 0) ? hp : 0) : p->maxSmp());
		// if (fighting)
		// {
		//		...
		// }
	}
}

/*
 * getsmp(handle$[, ret!])
 * 
 * Get a fighter's smp.
 */
void getsmp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->smp();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->smp();
		}
	}
	else
	{
		throw CError("GetSMP() requires one or two parameters.");
	}
}

/*
 * maxsmp(handle$, value!)
 * 
 * Set a fighter's max smp.
 */
void maxsmp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("MaxSMP() requires two parameters.");
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->maxSmp(params[1].getNum());
	}
}

/*
 * GetMaxSMP(handle$[, ret!])
 * 
 * Get a fighter's max smp.
 */
void getmaxsmp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->maxSmp();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->maxSmp();
		}
	}
	else
	{
		throw CError("GetMaxSMP() requires one or two parameters.");
	}
}

/*
 * start(file)
 * 
 * Open a file with the shell.
 */
void start(CALL_DATA &params)
{
	/*
	 * This is laughable, but there is no default directory
	 * for this function, and assuming one will only break
	 * backward compatibility in some obscure manner.
	 *
	 * Note also that previous incarnations prevented the
	 * launching of executables and shortcuts, but this is
	 * a nonsensical security measure when plugins no longer
	 * display a silly warning box, and this function can be
	 * trivially modified by someone who intends to be malicious.
	 */
	if (params.params != 1)
	{
		throw CError("Start() requires one parameter.");
	}
	ShellExecute(NULL, "open", params[0].getLit().c_str(), NULL, NULL, 0);
}

/*
 * GiveItem(itm$)
 * 
 * Add an item to the inventory.
 */
void giveitem(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("GiveItem() requires one parameter.");
	}
	extern std::string g_projectPath;
	g_inv.give(g_projectPath + ITM_PATH + params[0].getLit());
}

/*
 * TakeItem(itm$)
 * 
 * Remove an item from the inventory.
 */
void takeitem(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("TakeItem() requires one parameter.");
	}
	extern std::string g_projectPath;
	g_inv.take(g_projectPath + ITM_PATH + params[0].getLit());
}

/*
 * wav(...)
 * 
 * Description.
 */
void wav(CALL_DATA &params)
{

}

/*
 * delay(time!)
 * 
 * Delay for a certain number of seconds.
 */
void delay(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("Delay() requires one data element.");
	}
	Sleep(DWORD(params[0].getNum() * 1000.0));
}

/*
 * random(range![, ret!])
 * 
 * Generate a random number.
 */
void random(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Random() requires one or two parameters.");
	}
	const double toRet = (1 + (rand() % int(params[0].getNum() + 1)));
	if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = toRet;
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = toRet;
}

/*
 * push(...)
 * 
 * Description.
 */
void push(CALL_DATA &params)
{

}

/*
 * tiletype(...)
 * 
 * Description.
 */
void tiletype(CALL_DATA &params)
{

}

/*
 * MediaPlay(file$)
 * 
 * Set file$ as the background music.
 */
void mediaplay(CALL_DATA &params)
{
	if (params.params == 1)
	{
		extern CAudioSegment *g_bkgMusic;
		g_bkgMusic->open(params[0].getLit());
		g_bkgMusic->play(true);
	}
	else
	{
		throw CError("MediaPlay() requires one parameter.");
	}
}

/*
 * MediaStop()
 * 
 * Stop the background music.
 */
void mediastop(CALL_DATA &params)
{
	extern CAudioSegment *g_bkgMusic;
	g_bkgMusic->stop();
}

/*
 * GoDOS(command$)
 * 
 * Call in to DOS.
 */
void godos(CALL_DATA &params)
{
	throw CError("GoDos() is obsolete.");
}

/*
 * AddPlayer(file$)
 * 
 * Add a player to the party.
 */
void addplayer(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("AddPlayer() requires one parameter.");
	}
	extern std::vector<CPlayer *> g_players;
	extern std::string g_projectPath;
	g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + params[0].getLit(), false));
}

/*
 * removeplayer(...)
 * 
 * Description.
 */
void removeplayer(CALL_DATA &params)
{

}

/*
 * SetPixel(x!, y![, cnv!])
 * 
 * Set a pixel in the current colour.
 */
void setpixel(CALL_DATA &params)
{
	if (params.params == 2)
	{
		g_cnvRpgCode->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 3)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[2].getNum());
		if (cnv)
		{
			cnv->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		}
	}
	else
	{
		throw CError("SetPixel() requires two or three parameters.");
	}
}

/*
 * DrawLine(x1!, y1!, x2!, y2![, cnv!])
 * 
 * Draw a line.
 */
void drawline(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawLine(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawLine(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError("DrawLine() requires four or five parameters.");
	}
}

/*
 * DrawRect(x1!, y1!, x2!, y2![, cnv!])
 * 
 * Draw a rectangle.
 */
void drawrect(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError("DrawRect() requires four or five parameters.");
	}
}

/*
 * FillRect(x1!, y1!, x2!, y2![, cnv!])
 * 
 * Draw a filled rectangle.
 */
void fillrect(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawFilledRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawFilledRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError("FillRect() requires four or five parameters.");
	}
}

/*
 * debug(...)
 * 
 * Description.
 */
void debug(CALL_DATA &params)
{

}

/*
 * CastNum(x, [ret])
 * 
 * Return x cast to a number. Pointless now.
 */
void castnum(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = params[0].getNum();
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = params[0].getNum();
	}
	else
	{
		throw CError("CastNum() requires one or two parameters.");
	}
}

/*
 * CastLit(x, [ret])
 * 
 * Return x cast to a string. Pointless now.
 */
void castlit(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_LIT;
		params.ret().lit = params[0].getLit();
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_LIT;
		var->lit = params[0].getLit();
	}
	else
	{
		throw CError("CastLit() requires one or two parameters.");
	}
}

/*
 * CastInt(x)
 * 
 * Return x cast to an integer (i.e., sans fractional pieces).
 */
void castint(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(int(params[0].getNum()));
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = double(int(params[0].getNum()));
	}
	else
	{
		throw CError("CastInt() requires one or two parameters.");
	}
}

/*
 * pushitem(...)
 * 
 * Description.
 */
void pushitem(CALL_DATA &params)
{

}

/*
 * wander(target[, restrict])
 * 
 * Cause an NPC to wander.
 */
void wander(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Wander() requires one or two parameters.");
	}

	CSprite *p = NULL;

	if (params[0].getType() & UDT_NUM)
	{
		const unsigned int i = (unsigned int)params[0].getNum();
		if (g_pBoard->items.size() > i)
		{
			p = g_pBoard->items[i];
		}
		else
		{
			throw CError("Item does not exist.");
		}
	}
	else
	{
		const std::string str = params[0].getLit();
		if (_strcmpi(str.c_str(), "target") == 0)
		{
			p = (CSprite *)g_pTarget;
		}
		else if (_strcmpi(str.c_str(), "souce") == 0)
		{
			p = (CSprite *)g_pSource;
		}
		else
		{
			throw CError("Literal target must be \"target\" or \"source\".");
		}
	}

	if (!p) return;

	if (CSprite::m_bPxMovement)
	{
		const int queue = rand() % 9;
		for (unsigned int i = 0; i < 32; ++i)
		{
			p->setQueuedMovements(queue, false);
		}
	}
	else
	{
		p->setQueuedMovements(rand() % 9, false);
	}

	if (!params.prg->isThread())
	{
		// If not a thread, move now.
		extern CSprite *g_pSelectedPlayer;
		while (p->move(g_pSelectedPlayer))
		{
			renderNow(g_cnvRpgCode, true);
			renderRpgCodeScreen();
		}
	}

}

/*
 * bitmap(file$[, cnv!])
 * 
 * Fill a surface with an image.
 */
void bitmap(CALL_DATA &params)
{
	CGDICanvas *cnv = NULL;
	if (params.params == 1)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.params == 2)
	{
		cnv = g_canvases.cast(int(params[1].getNum()));
	}
	else
	{
		throw CError("Bitmap() requires one or two parameters.");
	}
	if (cnv)
	{
		extern std::string g_projectPath;
		extern int g_resX, g_resY;
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), cnv, 0, 0, g_resX, g_resY);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
}

/*
 * mainfile(...)
 * 
 * Description.
 */
void mainfile(CALL_DATA &params)
{

}

/*
 * dirsav(...)
 * 
 * Description.
 */
void dirsav(CALL_DATA &params)
{

}

/*
 * save(...)
 * 
 * Description.
 */
void save(CALL_DATA &params)
{

}

/*
 * load(...)
 * 
 * Description.
 */
void load(CALL_DATA &params)
{

}

/*
 * scan(...)
 * 
 * Description.
 */
void scan(CALL_DATA &params)
{

}

/*
 * mem(...)
 * 
 * Description.
 */
void mem(CALL_DATA &params)
{

}

/*
 * print(...)
 * 
 * Description.
 */
void print(CALL_DATA &params)
{

}

/*
 * RPGCode(line$)
 * 
 * Independently run a line of RPGCode.
 */
void rpgcode(CALL_DATA &params)
{
	if (params.params == 1)
	{
		CProgramChild prg(*params.prg);
		prg.loadFromString(params[0].getLit());
		prg.run();
	}
	else
	{
		throw CError("RPGCode() requires one parameter.");
	}
}

/*
 * CharAt(string, pos, [ret])
 * 
 * Get a character from a string. The first character is one.
 */
void charat(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError("CharAt() requires two or three parameters.");
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = params[0].getLit().substr(int(params[1].getNum()) - 1, 1);
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * equip(...)
 * 
 * Description.
 */
void equip(CALL_DATA &params)
{

}

/*
 * remove(...)
 * 
 * Description.
 */
void remove(CALL_DATA &params)
{

}

/*
 * putplayer(...)
 * 
 * Description.
 */
void putplayer(CALL_DATA &params)
{

}

/*
 * eraseplayer(...)
 * 
 * Description.
 */
void eraseplayer(CALL_DATA &params)
{

}

/*
 * kill(...)
 * 
 * Description.
 */
void kill(CALL_DATA &params)
{

}

/*
 * GiveGP(gp)
 * 
 * Give gold pieces.
 */
void givegp(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("GiveGP() requires one parameter.");
	}
	g_gp += params[0].getNum();
}

/*
 * TakeGP(gp)
 * 
 * Take gold pieces.
 */
void takegp(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("TakeGP() requires one parameter.");
	}
	g_gp -= params[0].getNum();
}

/*
 * GetGP([ret])
 * 
 * Return the amount of gold pieces held.
 */
void getgp(CALL_DATA &params)
{
	params.ret().udt = UDT_NUM;
	params.ret().num = double(g_gp);
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * wavstop(...)
 * 
 * Description.
 */
void wavstop(CALL_DATA &params)
{

}

/*
 * BorderColor(r!, g!, b!)
 * 
 * Obsolete.
 */
void bordercolor(CALL_DATA &params)
{
	throw CError("BorderColor() is obsolete.");
}

/*
 * FightRnemy(enemy$, enemy$, ... background$)
 * 
 * Start a fight.
 */
void fightenemy(CALL_DATA &params)
{
	if (params.params < 2)
	{
		throw CError("FightEnemy() requires at least two parameters.");
	}
	std::vector<std::string> enemies;
	for (unsigned int i = 0; i < (params.params - 1); ++i)
	{
		enemies.push_back(params[i].getLit());
	}
	runFight(enemies, params[params.params - 1].getLit());
}

/*
 * restoreplayer(...)
 * 
 * Description.
 */
void restoreplayer(CALL_DATA &params)
{

}

/*
 * callshop(...)
 * 
 * Description.
 */
void callshop(CALL_DATA &params)
{

}

/*
 * ClearBuffer()
 * 
 * Clear the keyboard buffer.
 */
void clearbuffer(CALL_DATA &params)
{
	extern std::vector<char> g_keys;
	g_keys.clear();
}

/*
 * attackall(...)
 * 
 * Description.
 */
void attackall(CALL_DATA &params)
{

}

/*
 * drainall(...)
 * 
 * Description.
 */
void drainall(CALL_DATA &params)
{

}

/*
 * inn()
 * 
 * Fully heal the player party.
 */
void inn(CALL_DATA &params)
{
	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::const_iterator i = g_players.begin();
	for (; i != g_players.end(); ++i)
	{
		(*i)->health((*i)->maxHealth());
		(*i)->smp((*i)->maxSmp());
	}
}

/*
 * targetlocation(...)
 * 
 * Description.
 */
void targetlocation(CALL_DATA &params)
{

}

/*
 * eraseitem(...)
 * 
 * Description.
 */
void eraseitem(CALL_DATA &params)
{

}

/*
 * putitem(...)
 * 
 * Description.
 */
void putitem(CALL_DATA &params)
{

}

/*
 * createitem(...)
 * 
 * Description.
 */
void createitem(CALL_DATA &params)
{

}

/*
 * destroyitem(...)
 * 
 * Description.
 */
void destroyitem(CALL_DATA &params)
{

}

/*
 * WalkSpeed(fast/slow)
 * 
 * Obsolete.
 */
void walkspeed(CALL_DATA &params)
{
	throw CError("WalkSpeed() is obsolete.");
}

/*
 * ItemWalkSpeed(fast/slow)
 * 
 * Obsolete.
 */
void itemwalkspeed(CALL_DATA &params)
{
	throw CError("ItemWalkSpeed() is obsolete.");
}

/*
 * posture(...)
 * 
 * Description.
 */
void posture(CALL_DATA &params)
{

}

/*
 * setbutton(...)
 * 
 * Description.
 */
void setbutton(CALL_DATA &params)
{

}

/*
 * checkbutton(...)
 * 
 * Description.
 */
void checkbutton(CALL_DATA &params)
{

}

/*
 * clearbuttons(...)
 * 
 * Description.
 */
void clearbuttons(CALL_DATA &params)
{

}

/*
 * mouseclick(...)
 * 
 * Description.
 */
void mouseclick(CALL_DATA &params)
{

}

/*
 * mousemove(...)
 * 
 * Description.
 */
void mousemove(CALL_DATA &params)
{

}

/*
 * zoom(...)
 * 
 * Description.
 */
void zoom(CALL_DATA &params)
{

}

/*
 * earthquake(...)
 * 
 * Description.
 */
void earthquake(CALL_DATA &params)
{

}

/*
 * itemcount(...)
 * 
 * Description.
 */
void itemcount(CALL_DATA &params)
{

}

/*
 * destroyplayer(...)
 * 
 * Description.
 */
void destroyplayer(CALL_DATA &params)
{

}

/*
 * callplayerswap(...)
 * 
 * Description.
 */
void callplayerswap(CALL_DATA &params)
{

}

/*
 * playavi(...)
 * 
 * Description.
 */
void playavi(CALL_DATA &params)
{

}

/*
 * playavismall(...)
 * 
 * Description.
 */
void playavismall(CALL_DATA &params)
{

}

/*
 * GetCorner(topX, topY)
 * 
 * Get the corner of the currently shown portion of the board.
 */
void getcorner(CALL_DATA &params)
{
	extern double g_topX, g_topY;

	if (params.params != 2)
	{
		throw CError("GetCorner() requires two parameters.");
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = g_topX;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = g_topY;
	}
}

/*
 * UnderArrow(on/off)
 * 
 * Toggle the under arrow.
 */
void underarrow(CALL_DATA &params)
{
	throw CError("UnderArrow() is obsolete.");
}

/*
 * getlevel(...)
 * 
 * Description.
 */
void getlevel(CALL_DATA &params)
{

}

/*
 * ai(...)
 * 
 * Description.
 */
void ai(CALL_DATA &params)
{

}

/*
 * menugraphic(...)
 * 
 * Description.
 */
void menugraphic(CALL_DATA &params)
{

}

/*
 * FightMenuGraphic(image$)
 * 
 * Choose an image for the fight menu graphic.
 */
void fightmenugraphic(CALL_DATA &params)
{
	if (params.params == 1)
	{
		extern std::string g_fightMenuGraphic;
		g_fightMenuGraphic = params[0].getLit();
	}
	else
	{
		throw CError("FightMenuGraphic() requires one parameter.");
	}
}

/*
 * fightstyle(0/1)
 * 
 * Obsolete.
 */
void fightstyle(CALL_DATA &params)
{
	throw CError("FightStyle() is obsolete.");
}

/*
 * stance(...)
 * 
 * Description.
 */
void stance(CALL_DATA &params)
{

}

/*
 * BattleSpeed(speed!)
 * 
 * Obsolete.
 */
void battlespeed(CALL_DATA &params)
{
	throw CError("BattleSpeed() is obsolete.");
}

/*
 * TextSpeed(speed!)
 * 
 * Obsolete.
 */
void textspeed(CALL_DATA &params)
{
	throw CError("TextSpeed() is obsolete.");
}

/*
 * mwinsize(...)
 * 
 * Description.
 */
void mwinsize(CALL_DATA &params)
{

}

/*
 * GetDP(handle, [ret])
 * 
 * Get a fighter's dp.
 */
void getdp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->defence();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->defence();
		}
	}
	else
	{
		throw CError("GetDP() requires one or two parameters.");
	}
}

/*
 * GetFP(handle, [ret])
 * 
 * Get a fighter's fp.
 */
void getfp(CALL_DATA &params)
{
	if (params.params == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = p->fight();
		}
	}
	else if (params.params == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = p->fight();
		}
	}
	else
	{
		throw CError("GetFP() requires one or two parameters.");
	}
}

/*
 * internalmenu(...)
 * 
 * Description.
 */
void internalmenu(CALL_DATA &params)
{

}

/*
 * applystatus(...)
 * 
 * Description.
 */
void applystatus(CALL_DATA &params)
{

}

/*
 * removestatus(...)
 * 
 * Description.
 */
void removestatus(CALL_DATA &params)
{

}

/*
 * SetImage(str$, x!, y!, width!, height![, cnv!])
 * 
 * Sets an image.
 */
void setimage(CALL_DATA &params)
{
	CGDICanvas *cnv = NULL;
	if (params.params == 5)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.params == 6)
	{
		cnv = g_canvases.cast(int(params[5].getNum()));
	}
	else
	{
		throw CError("SetImage() requires five or six parameters.");
	}
	if (cnv)
	{
		extern std::string g_projectPath;
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), cnv, params[1].getNum(), params[2].getNum(), params[3].getNum(), params[4].getNum());
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}

}

/*
 * drawcircle(...)
 * 
 * Description.
 */
void drawcircle(CALL_DATA &params)
{

}

/*
 * fillcircle(...)
 * 
 * Description.
 */
void fillcircle(CALL_DATA &params)
{

}

/*
 * savescreen(...)
 * 
 * Description.
 */
void savescreen(CALL_DATA &params)
{

}

/*
 * restorescreen(...)
 * 
 * Description.
 */
void restorescreen(CALL_DATA &params)
{

}

/*
 * sin(x![, ret!])
 * 
 * Calculate sine x.
 */
void sin(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = sin(params[0].getNum() / 180 * PI);
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = sin(params[0].getNum() / 180 * PI);
	}
}

/*
 * cos(x![, ret!])
 * 
 * Calculate cosine x.
 */
void cos(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = cos(params[0].getNum() / 180 * PI);
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = cos(params[0].getNum() / 180 * PI);
	}
}

/*
 * tan(x![, ret!])
 * 
 * Calculate tangent x.
 */
void tan(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = tan(params[0].getNum() / 180 * PI);
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = tan(params[0].getNum() / 180 * PI);
	}
}

/*
 * GetPixel(x!, y!, r!, g!, b![, cnv])
 * 
 * Get the colour of the pixel at x, y.
 */
void getpixel(CALL_DATA &params)
{
	COLORREF color = 0;
	if (params.params == 5)
	{
		color = g_cnvRpgCode->GetPixel(params[0].getNum(), params[1].getNum());
	}
	else if (params.params == 6)
	{
		CGDICanvas *cnv = g_canvases.cast(int(params[5].getNum()));
		if (cnv)
		{
			color = cnv->GetPixel(params[0].getNum(), params[1].getNum());
		}
	}
	else
	{
		throw CError("GetPixel() requires five or six parameters.");
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[2].lit);
		var->udt = UDT_NUM;
		var->num = double(GetRValue(color));
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[3].lit);
		var->udt = UDT_NUM;
		var->num = double(GetGValue(color));
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[4].lit);
		var->udt = UDT_NUM;
		var->num = double(GetBValue(color));
	}
}

/*
 * GetColor(r!, g!, b!)
 * 
 * Get the current colour.
 */
void getcolor(CALL_DATA &params)
{
	if (params.params == 3)
	{
		{
			LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
			var->udt = UDT_NUM;
			var->num = double(GetRValue(g_color));
		}
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = double(GetGValue(g_color));
		}
		{
			LPSTACK_FRAME var = params.prg->getVar(params[2].lit);
			var->udt = UDT_NUM;
			var->num = double(GetBValue(g_color));
		}
	}
	else
	{
		throw CError("GetColor() requires three parameters.");
	}
}

/*
 * GetFontSize([size!])
 * 
 * Get the current font size.
 */
void getfontsize(CALL_DATA &params)
{
	if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = double(g_fontSize);
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(g_fontSize);
}

/*
 * SetImageTransparent(file$, x!, y!, width!, height!, r!, g!, b![, cnv!])
 * 
 * Set an image with a transparent colour.
 */
void setimagetransparent(CALL_DATA &params)
{
	CGDICanvas *cnv = NULL;
	if (params.params == 8)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.params == 9)
	{
		cnv = g_canvases.cast(int(params[8].getNum()));
	}
	else
	{
		throw CError("SetImageTransparent() requires eight or nine parameters.");
	}
	if (cnv)
	{
		extern std::string g_projectPath;
		CGDICanvas intermediate;
		intermediate.CreateBlank(NULL, params[3].getNum(), params[4].getNum(), TRUE);
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), &intermediate, 0, 0, params[3].getNum(), params[4].getNum());
		intermediate.BltTransparent(cnv, params[1].getNum(), params[2].getNum(), RGB(params[5].getNum(), params[6].getNum(), params[7].getNum()));
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
}

/*
 * SetImageTranslucent(file$, x!, y!, width!, height![, cnv!])
 * 
 * Set an image translucently.
 */
void setimagetranslucent(CALL_DATA &params)
{
	CGDICanvas *cnv = NULL;
	if (params.params == 5)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.params == 6)
	{
		cnv = g_canvases.cast(int(params[5].getNum()));
	}
	else
	{
		throw CError("SetImageTransparent() requires five or six parameters.");
	}
	if (cnv)
	{
		extern std::string g_projectPath;
		CGDICanvas intermediate;
		intermediate.CreateBlank(NULL, params[3].getNum(), params[4].getNum(), TRUE);
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), &intermediate, 0, 0, params[3].getNum(), params[4].getNum());
		intermediate.BltTranslucent(cnv, params[1].getNum(), params[2].getNum(), 0.5, -1, -1);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
}

/*
 * sourcelocation(...)
 * 
 * Description.
 */
void sourcelocation(CALL_DATA &params)
{

}

/*
 * targethandle(...)
 * 
 * Description.
 */
void targethandle(CALL_DATA &params)
{

}

/*
 * sourcehandle(...)
 * 
 * Description.
 */
void sourcehandle(CALL_DATA &params)
{

}

/*
 * DrawEnemy(file, x, y, [cnv])
 * 
 * Draw an enemy.
 */
void drawenemy(CALL_DATA &params)
{
	extern std::string g_projectPath;

	CGDICanvas *cnv = NULL;
	if (params.params == 3)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.params == 4)
	{
		if (!(cnv = g_canvases.cast(int(params[3].getNum()))))
		{
			return;
		}
	}
	else
	{
		throw CError("DrawEnemy() requires three or four parameters.");
	}
	ENEMY enemy;
	if (enemy.open(g_projectPath + ENE_PATH + params[0].getLit()))
	{
		renderAnimationFrame(cnv, enemy.gfx[EN_REST], 0, int(params[1].getNum()), int(params[2].getNum()));
	}
}

/*
 * mp3pause(...)
 * 
 * Description.
 */
void mp3pause(CALL_DATA &params)
{

}

/*
 * layerput(...)
 * 
 * Description.
 */
void layerput(CALL_DATA &params)
{

}

/*
 * GetBoardTile(x, y, z[, ret])
 * 
 * Get the file name of the tile at x, y, z.
 */
void getboardtile(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	if (params.params == 3)
	{
		try
		{
			params.ret().udt = UDT_LIT;
			params.ret().lit = g_pBoard->tileIndex[g_pBoard->board[params[0].getNum()][params[1].getNum()][params[2].getNum()]];
		}
		catch (...) // Lazy solution.
		{
			throw CError("Out of bounds.");
		}
	}
	else if (params.params == 4)
	{
		try
		{
			LPSTACK_FRAME var = params.prg->getVar(params[3].lit);
			var->udt = UDT_LIT;
			var->lit = g_pBoard->tileIndex[g_pBoard->board[params[0].getNum()][params[1].getNum()][params[2].getNum()]];
		}
		catch (...)
		{
			throw CError("Out of bounds.");
		}
	}
	else
	{
		throw CError("GetBoardTile() requires three or four parameters.");
	}
}

/*
 * sqrt(x![, ret!])
 * 
 * Calculate the square root of x.
 */
void sqrt(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = sqrt(params[0].getNum());
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = sqrt(params[0].getNum());
	}
}

/*
 * getboardtiletype(...)
 * 
 * Description.
 */
void getboardtiletype(CALL_DATA &params)
{

}

/*
 * setimageadditive(...)
 * 
 * Description.
 */
void setimageadditive(CALL_DATA &params)
{

}

/*
 * animation(...)
 * 
 * Description.
 */
void animation(CALL_DATA &params)
{

}

/*
 * sizedanimation(...)
 * 
 * Description.
 */
void sizedanimation(CALL_DATA &params)
{

}

/*
 * ForceRedraw()
 * 
 * Force a redrawing of the screen.
 */
void forceredraw(CALL_DATA &params)
{
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * itemlocation(...)
 * 
 * Description.
 */
void itemlocation(CALL_DATA &params)
{

}

/*
 * wipe(...)
 * 
 * Description.
 */
void wipe(CALL_DATA &params)
{

}

/*
 * GetRes(x!, y!)
 * 
 * Get the screen's resolution.
 */
void getres(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("GetRes() requires two parameters.");
	}
	extern int g_resX, g_resY;
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = g_resX;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = g_resY;
	}
}

/*
 * StaticText()
 * 
 * Toggle antialiasing.
 */
void statictext(CALL_DATA &params)
{
	throw CError("StaticText() is obsolete.");
}

/*
 * pathfind(...)
 * 
 * Description.
 */
void pathfind(CALL_DATA &params)
{

}

/*
 * itemstep(...)
 * 
 * Description.
 */
void itemstep(CALL_DATA &params)
{

}

/*
 * playerstep(...)
 * 
 * Description.
 */
void playerstep(CALL_DATA &params)
{

}

/*
 * redirect(...)
 * 
 * Description.
 */
void redirect(CALL_DATA &params)
{

}

/*
 * killredirect(...)
 * 
 * Description.
 */
void killredirect(CALL_DATA &params)
{

}

/*
 * killallredirects(...)
 * 
 * Description.
 */
void killallredirects(CALL_DATA &params)
{

}

/*
 * parallax(...)
 * 
 * Description.
 */
void parallax(CALL_DATA &params)
{

}

/*
 * giveexp(...)
 * 
 * Description.
 */
void giveexp(CALL_DATA &params)
{

}

/*
 * AnimatedTiles()
 * 
 * Toggle animated tiles.
 */
void animatedtiles(CALL_DATA &params)
{
	throw CError("AnimatedTiles() is obsolete.");
}

/*
 * SmartStep()
 * 
 * Toggle "smart" stepping.
 */
void smartstep(CALL_DATA &params)
{
	throw CError("SmartStep() is obsolete.");
}

/*
 * gamespeed(...)
 * 
 * Description.
 */
void gamespeed(CALL_DATA &params)
{

}

/*
 * CharacterSpeed(speed!)
 * 
 * Obsolete.
 */
void characterspeed(CALL_DATA &params)
{
	CProgram::debugger("CharacterSpeed() has depreciated into GameSpeed().");
	gamespeed(params);
}

/*
 * Thread(file, presist[, id])
 * 
 * Start a thread.
 */
void thread(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError("Thread() requires two or three parameters.");
	}
	extern std::string g_projectPath;
	const std::string file = g_projectPath + PRG_PATH + params[0].getLit();
	if (!CFile::fileExists(file))
	{
		throw CError("Could not find " + params[0].getLit() + " for Thread().");
	}
	CThread *p = CThread::create(file);
	if (params[1].getNum() == 0)
	{
		extern LPBOARD g_pBoard;
		g_pBoard->threads.push_back(p);
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(int(p));
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * KillThread(id)
 * 
 * Kill a thread.
 */
void killthread(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("KillThread() requires one parameter.");
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError("Invalid thread ID for KillThread().");
	}
	CThread::destroy(p); // Innocuous.
}

/*
 * GetThreadID([ret])
 * 
 * Get the ID of this thread.
 */
void getthreadid(CALL_DATA &params)
{
	if (!params.prg->isThread())
	{
		throw CError("GetThreadID() is invalid outside of threads.");
	}
	if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = double(int(params.prg));
	}
	else if (params.params != 0)
	{
		throw CError("GetThreadID() requires zero or one parameters.");
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(int(params.prg));
}

/*
 * ThreadSleep(thread, seconds)
 * 
 * Put a thread to sleep.
 */
void threadsleep(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("ThreadSleep() requires one parameter.");
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError("Invalid thread ID for ThreadSleep().");
	}
	p->sleep((unsigned long)(params[1].getNum() * 1000.0));
}

/*
 * tellthread(...)
 * 
 * Description.
 */
void tellthread(CALL_DATA &params)
{

}

/*
 * ThreadWake(thread)
 * 
 * Wake up a thread.
 */
void threadwake(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("ThreadWake() requires one parameter.");
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError("Invalid thread ID for ThreadWake().");
	}
	p->wakeUp();
}

/*
 * ThreadSleepRemaining(thread[, ret])
 * 
 * Check how much sleep remains for a thread.
 */
void threadsleepremaining(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("ThreadSleepRemaining() requires one or two parameters.");
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError("Invalid thread ID for ThreadSleepRemaining().");
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = p->sleepRemaining() / 1000.0;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * local(name, [ret])
 * 
 * Allocate a variable off the stack and returns a reference to it.
 */
void local(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Local() requires one or two parameters.");
	}
	params.prg->getLocal(params[0].lit); // Allocates a var if it does not exist.
	params.ret().udt = UDT_ID;
	params.ret().lit = params[0].lit;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * global(name, [ret])
 * 
 * Allocates a variable on the heap and returns a reference to it.
 */
void global(CALL_DATA &params)
{
	/*
	 * x = 1;
	 * method func()
	 * {
	 *    local(x) = 2;
	 *    mwin(global(x));
	 *    mwin(x);
	 * }
	 *
	 * Given the above code, the values of the message windows,
	 * should func() be called, would be 1 and 2 respectively
	 * because variables off the stack are preferred to ones
	 * on the heap. The call to global() explictly requests
	 * the variable 'x' from the heap.
	 */
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Global() requires one or two parameters.");
	}
	CProgram::getGlobal(params[0].lit); // Allocates a var if it does not exist.
	params.ret().udt = UDT_ID;
	params.ret().lit = ":" + params[0].lit;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * AutoCommand()
 * 
 * Obsolete.
 */
void autocommand(CALL_DATA &params)
{
	throw CWarning("AutoCommand() is obsolete.");
}

/*
 * CreateCursorMap([map!])
 * 
 * Create a cursor map.
 */
void createcursormap(CALL_DATA &params)
{
	if (params.params == 0)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(int(g_cursorMaps.allocate()));
	}
	else if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = double(int(g_cursorMaps.allocate()));
	}
	else
	{
		throw CError("CreateCursorMap() requires zero or one parameters.");
	}
}

/*
 * KillCursorMap(map!)
 * 
 * Kill a cursor map.
 */
void killcursormap(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("KillCursorMap() requires one parameter.");
	}
	g_cursorMaps.free((CCursorMap *)(int)params[0].getNum());
}

/*
 * CursorMapAdd(x!, y!, map!)
 * 
 * Add a point to a cursor map.
 */
void cursormapadd(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError("CursorMapAdd() requires three parameters.");
	}
	CCursorMap *p = g_cursorMaps.cast((int)params[2].getNum());
	if (p)
	{
		p->add(int(params[0].getNum()), int(params[1].getNum()));
	}
}

/*
 * CursorMapRun(map![, ret!])
 * 
 * Run a cursor map.
 */
void cursormaprun(CALL_DATA &params)
{
	if (params.params == 1)
	{
		CCursorMap *p = g_cursorMaps.cast((int)params[0].getNum());
		if (p)
		{
			params.ret().udt = UDT_NUM;
			params.ret().num = double(p->run());
		}
	}
	else if (params.params == 2)
	{
		CCursorMap *p = g_cursorMaps.cast((int)params[0].getNum());
		if (p)
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_NUM;
			var->num = double(p->run());
		}
	}
	else
	{
		throw CError("CursorMapRun() requires one or two parameters.");
	}
}

/*
 * CreateCanvas(width!, height![, cnv!])
 * 
 * Create a canvas.
 */
void createcanvas(CALL_DATA &params)
{
	if (params.params != 2 && params.params != 3)
	{
		throw CError("CreateCanvas() requires two or three parameters.");
	}
	CGDICanvas *p = g_canvases.allocate();
	p->CreateBlank(NULL, params[0].getNum(), params[1].getNum(), TRUE);
	p->ClearScreen(0);
	params.ret().udt = UDT_NUM;
	params.ret().num = double(int(p));
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * KillCanvas(cnv!)
 * 
 * Kill a canvas.
 */
void killcanvas(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("KillCanvas() requires one parameter.");
	}
	CGDICanvas *p = (CGDICanvas *)(int)params[0].getNum();
	g_canvases.free(p);
}

/*
 * DrawCanvas(cnv!, x!, y![, width!, height![, dest!]])
 * 
 * Blit a canvas forward.
 */
void drawcanvas(CALL_DATA &params)
{
	if (params.params == 3)
	{
		CGDICanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->Blt(g_cnvRpgCode, params[1].getNum(), params[2].getNum());
			renderRpgCodeScreen();
		}
	}
	else if (params.params == 5)
	{
		CGDICanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->BltStretch(g_cnvRpgCode, params[1].getNum(), params[2].getNum(), 0, 0, p->GetWidth(), p->GetHeight(), params[3].getNum(), params[4].getNum(), SRCCOPY);
			renderRpgCodeScreen();
		}
	}
	else if (params.params == 6)
	{
		CGDICanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			CGDICanvas *pDest = g_canvases.cast((int)params[5].getNum());
			if (pDest)
			{
				p->BltStretch(pDest, params[1].getNum(), params[2].getNum(), 0, 0, p->GetWidth(), p->GetHeight(), params[3].getNum(), params[4].getNum(), SRCCOPY);
			}
		}
	}
	else
	{
		throw CError("DrawCanvas() requires three, five, or six parameters.");
	}
}

/*
 * OpenFileInput(file, folder)
 * 
 * Open a file in input mode.
 */
void openfileinput(CALL_DATA &params)
{
	extern std::string g_projectPath;

	if (params.params != 2)
	{
		throw CError("OpenFileInput() requires two parameters.");
	}
	g_files[parser::uppercase(params[0].getLit())].open(g_projectPath + params[1].getLit() + '\\' + params[0].getLit(), OF_READ);
}

/*
 * OpenFileOutput(file, folder)
 * 
 * Open a file in output mode.
 */
void openfileoutput(CALL_DATA &params)
{
	extern std::string g_projectPath;

	if (params.params != 2)
	{
		throw CError("OpenFileOutput() requires two parameters.");
	}
	g_files[parser::uppercase(params[0].getLit())].open(g_projectPath + params[1].getLit() + '\\' + params[0].getLit(), OF_CREATE | OF_WRITE);
}

/*
 * OpenFileAppend(file, folder)
 * 
 * Open a file for appending.
 */
void openfileappend(CALL_DATA &params)
{
	extern std::string g_projectPath;

	if (params.params != 2)
	{
		throw CError("OpenFileOutput() requires two parameters.");
	}
	CFile &file = g_files[parser::uppercase(params[0].getLit())];
	file.open(g_projectPath + params[1].getLit() + '\\' + params[0].getLit(), OF_WRITE);
	file.seek(file.size());
}

/*
 * OpenFileBinary(file, folder)
 * 
 * Obsolete.
 */
void openfilebinary(CALL_DATA &params)
{
	CProgram::debugger("OpenFileBinary() is obsolete. Use OpenFileInput() instead.");
	openfileinput(params);
}

/*
 * CloseFile(file)
 * 
 * Close a file.
 */
void closefile(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("CloseFile() requires one parameter.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (i != g_files.end())
	{
		g_files.erase(i);
	}
}

/*
 * FileInput(file, [ret])
 * 
 * Read a line from a line.
 */
void fileinput(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("FileInput() requires one or two parameters.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	params.ret().udt = UDT_LIT;
	params.ret().lit = i->second.line();
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * FilePrint(file, line)
 * 
 * Write a line to a file.
 */
void fileprint(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("FilePrint() requires two parameters.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	const std::string str = params[1].getLit();
	for (std::string::const_iterator j = str.begin(); j != str.end(); ++j)
	{
		i->second << *j;
	}
	i->second << '\r' << '\n';
}

/*
 * FileGet(file, [ret])
 * 
 * Get a byte from a file.
 */
void fileget(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("FileGet() requires one or two parameters.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	params.ret().udt = UDT_LIT;
	char c;
	i->second >> c;
	params.ret().lit = c;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * FilePut(file, byte)
 * 
 * Write a byte to a file.
 */
void fileput(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError("FilePut() requires two parameters.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	i->second << params[1].getLit()[0];
}

/*
 * FileEOF(file, [ret])
 * 
 * Check whether the end of a file has been reached.
 */
void fileeof(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("FileEOF() requires one or two parameters.");
	}
	std::map<std::string, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	params.ret().udt = UDT_NUM;
	params.ret().num = double(i->second.isEof());
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * len(str$[, length!)
 * 
 * Get the length of a string.
 */
void len(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = params[0].getLit().length();
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = params[0].getLit().length();
	}
	else
	{
		throw CError("Len() requires one or two parameters.");
	}
}

/*
 * instr(...)
 * 
 * Description.
 */
void instr(CALL_DATA &params)
{

}

/*
 * getitemname(...)
 * 
 * Description.
 */
void getitemname(CALL_DATA &params)
{

}

/*
 * getitemdesc(...)
 * 
 * Description.
 */
void getitemdesc(CALL_DATA &params)
{

}

/*
 * getitemcost(...)
 * 
 * Description.
 */
void getitemcost(CALL_DATA &params)
{

}

/*
 * getitemsellprice(...)
 * 
 * Description.
 */
void getitemsellprice(CALL_DATA &params)
{

}

/*
 * restorescreenarray(...)
 * 
 * Description.
 */
void restorescreenarray(CALL_DATA &params)
{

}

/*
 * restorearrayscreen(...)
 * 
 * Description.
 */
void restorearrayscreen(CALL_DATA &params)
{

}

/*
 * splicevariables(...)
 * 
 * Description.
 */
void splicevariables(CALL_DATA &params)
{

}

/*
 * split(...)
 * 
 * Description.
 */
void split(CALL_DATA &params)
{

}

/*
 * ret! = asc(chr$[, ret!])
 * 
 * Get the ASCII value of chr$
 */
void asc(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = (double)params[0].getLit()[0];
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = (double)params[0].getLit()[0];
	}
	else
	{
		throw CError("Asc() requires one or two parameters.");
	}
}

/*
 * chr$ = chr(asc![, chr$])
 * 
 * Get the character represented by the ASCII code passed in.
 */
void chr(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Chr() requires one or two parameters.");
	}
	std::string ret;
	ret += (char)params[0].getNum();
	if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_LIT;
		var->lit = ret;
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = ret;
}

/*
 * ret$ = trim(str$[, ret$})
 * 
 * Trim whitespace from a string.
 */
void trim(CALL_DATA &params)
{
	if (params.params == 1 || params.params == 2)
	{
		const std::string toRet = parser::trim(params[0].getLit());
		if (params.params == 1)
		{
			params.ret().udt = UDT_LIT;
			params.ret().lit = toRet;
		}
		else
		{
			LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
			var->udt = UDT_LIT;
			var->lit = toRet;
		}
	}
	else
	{
		throw CError("Trim() requires one or two parameters.");
	}
}

/*
 * right(...)
 * 
 * Description.
 */
void right(CALL_DATA &params)
{

}

/*
 * left(...)
 * 
 * Description.
 */
void left(CALL_DATA &params)
{

}

/*
 * cursormaphand(...)
 * 
 * Description.
 */
void cursormaphand(CALL_DATA &params)
{

}

/*
 * debugger(message!)
 * 
 * Show a debug message.
 */
void debugger(CALL_DATA &params)
{
	if (params.params == 1)
	{
		CProgram::debugger(params[0].getLit());
	}
	else
	{
		throw CError("Debugger() requires one parameter.");
	}
}

/*
 * onerror(...)
 * 
 * Description.
 */
void onerror(CALL_DATA &params)
{

}

/*
 * resumenext(...)
 * 
 * Description.
 */
void resumenext(CALL_DATA &params)
{

}

/*
 * msgbox(...)
 * 
 * Description.
 */
void msgbox(CALL_DATA &params)
{

}

/*
 * setconstants(...)
 * 
 * Description.
 */
void setconstants(CALL_DATA &params)
{

}

/*
 * ret! = log(x![, ret!])
 * 
 * Get the natural log of x!
 */
void log(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError("Log() requires one or two parameters.");
	}
	const double toRet = log(params[0].getNum());
	if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = toRet;
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = toRet;
}

/*
 * onboard(...)
 * 
 * Description.
 */
void onboard(CALL_DATA &params)
{

}

/*
 * autolocal(...)
 * 
 * Description.
 */
void autolocal(CALL_DATA &params)
{

}

/*
 * getboardname([ret$])
 * 
 * Get the current board's file name.
 */
void getboardname(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_LIT;
		var->lit = g_pBoard->strFilename;
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = g_pBoard->strFilename;
}

/*
 * pixelmovement(...)
 * 
 * Description.
 */
void pixelmovement(CALL_DATA &params)
{

}

/*
 * lcase(...)
 * 
 * Description.
 */
void lcase(CALL_DATA &params)
{

}

/*
 * ucase(...)
 * 
 * Description.
 */
void ucase(CALL_DATA &params)
{

}

/*
 * apppath(...)
 * 
 * Description.
 */
void apppath(CALL_DATA &params)
{

}

/*
 * mid(...)
 * 
 * Description.
 */
void mid(CALL_DATA &params)
{

}

/*
 * replace(...)
 * 
 * Description.
 */
void replace(CALL_DATA &params)
{

}

/*
 * endanimation(...)
 * 
 * Description.
 */
void endanimation(CALL_DATA &params)
{

}

/*
 * rendernow(...)
 * 
 * Description.
 */
void rendernow(CALL_DATA &params)
{

}

/*
 * multirun(...)
 * 
 * Description.
 */
void multirun(CALL_DATA &params)
{

}

/*
 * shopcolors(...)
 * 
 * Description.
 */
void shopcolors(CALL_DATA &params)
{

}

/*
 * itemspeed(...)
 * 
 * Description.
 */
void itemspeed(CALL_DATA &params)
{

}

/*
 * playerspeed(...)
 * 
 * Description.
 */
void playerspeed(CALL_DATA &params)
{

}

/*
 * mousecursor(...)
 * 
 * Description.
 */
void mousecursor(CALL_DATA &params)
{

}

/*
 * gettextwidth(...)
 * 
 * Description.
 */
void gettextwidth(CALL_DATA &params)
{

}

/*
 * gettextheight(...)
 * 
 * Description.
 */
void gettextheight(CALL_DATA &params)
{

}

/*
 * iif(condition, true, false)
 * 
 * Obsolete.
 */
void iif(CALL_DATA &params)
{
	throw CError("IIf() is obsolete. Use the ?: operator.");
}

/*
 * itemstance(...)
 * 
 * Description.
 */
void itemstance(CALL_DATA &params)
{

}

/*
 * playerstance(...)
 * 
 * Description.
 */
void playerstance(CALL_DATA &params)
{

}

/*
 * drawcanvastransparent(...)
 * 
 * Description.
 */
void drawcanvastransparent(CALL_DATA &params)
{

}

/*
 * GetTickCount()
 * 
 * Get the number of milliseconds since Windows started.
 */
void gettickcount(CALL_DATA &params)
{
	params.ret().udt = UDT_NUM;
	params.ret().num = GetTickCount();
}

/*
 * setvolume(...)
 * 
 * Description.
 */
void setvolume(CALL_DATA &params)
{

}

/*
 * createtimer(...)
 * 
 * Description.
 */
void createtimer(CALL_DATA &params)
{

}

/*
 * killtimer(...)
 * 
 * Description.
 */
void killtimer(CALL_DATA &params)
{

}

/*
 * setmwintranslucency(...)
 * 
 * Description.
 */
void setmwintranslucency(CALL_DATA &params)
{

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
	CProgram::addFunction("mbox", mwin);
	CProgram::addFunction("branch", branch);
	CProgram::addFunction("change", change);
	CProgram::addFunction("clear", clear);
	CProgram::addFunction("done", done);
	CProgram::addFunction("dos", windows);
	CProgram::addFunction("windows", windows);
	CProgram::addFunction("empty", empty);
	CProgram::addFunction("end", end);
	CProgram::addFunction("font", font);
	CProgram::addFunction("fontsize", fontsize);
	CProgram::addFunction("fade", fade);
	CProgram::addFunction("fbranch", branch);
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
	CProgram::addFunction("show", mwin);
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
	CProgram::addFunction("midiplay", mediaplay);
	CProgram::addFunction("playmidi", mediaplay);
	CProgram::addFunction("mediaplay", mediaplay);
	CProgram::addFunction("mediastop", mediastop);
	CProgram::addFunction("mediarest", mediastop);
	CProgram::addFunction("midirest", mediastop);
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
	CProgram::addFunction("mp3", wav);
	CProgram::addFunction("sourcelocation", sourcelocation);
	CProgram::addFunction("targethandle", targethandle);
	CProgram::addFunction("sourcehandle", sourcehandle);
	CProgram::addFunction("drawenemy", drawenemy);
	CProgram::addFunction("mp3pause", mp3pause);
	CProgram::addFunction("layerput", layerput);
	CProgram::addFunction("getboardtile", getboardtile);
	CProgram::addFunction("boardgettile", getboardtile);
	CProgram::addFunction("sqrt", sqrt);
	CProgram::addFunction("getboardtiletype", getboardtiletype);
	CProgram::addFunction("setimageadditive", setimageadditive);
	CProgram::addFunction("animation", animation);
	CProgram::addFunction("sizedanimation", sizedanimation);
	CProgram::addFunction("forceredraw", forceredraw);
	CProgram::addFunction("itemlocation", itemlocation);
	CProgram::addFunction("wipe", wipe);
	CProgram::addFunction("getres", getres);
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
	CProgram::addFunction("length", len);
	CProgram::addFunction("len", len);
	CProgram::addFunction("instr", instr);
	CProgram::addFunction("getitemname", getitemname);
	CProgram::addFunction("getitemdesc", getitemdesc);
	CProgram::addFunction("getitemcost", getitemcost);
	CProgram::addFunction("getitemsellprice", getitemsellprice);
	CProgram::addFunction("stop", end);
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
