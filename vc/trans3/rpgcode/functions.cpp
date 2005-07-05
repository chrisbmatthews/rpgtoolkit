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
#include "../../tkCommon/tkGfx/CTile.h"
#include "../input/input.h"
#include "../render/render.h"
#include "../audio/CAudioSegment.h"
#include "../common/board.h"
#include "../common/paths.h"
#include "../common/animation.h"
#include "../common/CAllocationHeap.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../images/FreeImage.h"
#include "CCursorMap.h"
#include <math.h>

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
// CAllocationHeap<CThread> g_threads;		// Threads.
typedef enum tagTargetType
{
	TI_EMPTY,		// Empty!
	TT_PLAYER,		// Player is targetted.
	TT_ITEM,		// Item is targetted.
	TT_ENEMY		// Enemy is targetted.
} TARGET_TYPE;
void *g_pTarget = NULL;						// Targetted entity.
TARGET_TYPE g_targetType = TI_EMPTY;		// Type of target entity.
void *g_pSource = NULL;						// Source entity.
TARGET_TYPE g_sourceType = TI_EMPTY;		// Type of source entity.

/*
 * Become ready to run a program.
 */
void programInit(void)
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
void programFinish(void)
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
CVariant mwin(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 1)
	{
		CProgram::debugger("MWin() requires one parameter.");
		return CVariant();
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
	return CVariant();
}

/*
 * key$ = wait()
 * 
 * Waits for a key to be pressed, and returns the key that was.
 */
CVariant wait(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 0)
	{
		return waitForKey();
	}
	else if (params.size() == 1)
	{
		prg->setVariable(params[0].getLit(), waitForKey());
	}
	else
	{
		CProgram::debugger("Wait() requires zero or one parameters.");
	}
	return CVariant();
}

/*
 * mwincls()
 * 
 * Clear and hide the message window.
 */
CVariant mwincls(CProgram::PARAMETERS params, CProgram *const)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
	g_mwinY = 0;
	renderRpgCodeScreen();
	return CVariant();
}

/*
 * send(file$, x!, y![, z!])
 * 
 * Send the player to a new board.
 */
CVariant send(CProgram::PARAMETERS params, CProgram *const)
{
	unsigned int layer = 1;
	if (params.size() != 3)
	{
		if (params.size() != 4)
		{
			CProgram::debugger("Send() requires three or four parameters.");
			return CVariant();
		}
		else
		{
			layer = params[3].getNum();
		}
	}
	BOARD board;
	extern std::string g_projectPath;
	board.open(g_projectPath + BRD_PATH + params[0].getLit());
	unsigned int x = params[1].getNum(), y = params[2].getNum();
	if (x > board.bSizeX)
	{
		CProgram::debugger("Send() location exceeds target board x-dimension.");
		x = board.bSizeX;
	}
	if (x < 1)
	{
		CProgram::debugger("Send() x location is less than one.");
		x = 1;
	}
	if (y > board.bSizeY)
	{
		CProgram::debugger("Send() location exceeds target board y-dimension.");
		y = board.bSizeY;
	}
	if (y < 1)
	{
		CProgram::debugger("Send() y location is less than one.");
		y = 1;
	}
	extern BOARD g_activeBoard;
	g_activeBoard.open(g_projectPath + BRD_PATH + params[0].getLit());
	
	clearAnmCache();
	extern CSprite *g_pSelectedPlayer;
	g_pSelectedPlayer->setPosition(x * 32, y * 32, layer);

	// After setPosition().
	extern RECT g_screen;
	extern SCROLL_CACHE g_scrollCache;
	g_pSelectedPlayer->alignBoard(g_screen, true);
	g_scrollCache.render(true);

	// Ensure that programs the player is standing on don't run immediately.
	g_pSelectedPlayer->deactivatePrograms();

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();

	extern CAudioSegment *g_bkgMusic;
	// Open file regardless of existence.
	g_bkgMusic->open(g_activeBoard.boardMusic);
	g_bkgMusic->play(true);

	if (!g_activeBoard.enterPrg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + g_activeBoard.enterPrg).run();
	}
	return CVariant();
}

/*
 * text(x, y, str[, cnv])
 *
 * Displays text on the screen.
 */
CVariant text(CProgram::PARAMETERS params, CProgram *const)
{
	const int count = params.size();
	if (count != 3 && count != 4)
	{
		CProgram::debugger("Text() requires 3 or 4 parameters!");
		return CVariant();
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
	return CVariant();
}

/*
 * pixelText(x, y, str[, cnv])
 *
 * Displays text on the screen using pixel coordinates.
 */
CVariant pixeltext(CProgram::PARAMETERS params, CProgram *const)
{
	const int count = params.size();
	if (count != 3 && count != 4)
	{
		CProgram::debugger("PixelText() requires 3 or 4 parameters!");
		return CVariant();
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
	return CVariant();
}

/*
 * label(...)
 * 
 * Description.
 */
CVariant label(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * branch(...)
 * 
 * Description.
 */
CVariant branch(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * change(...)
 * 
 * Description.
 */
CVariant change(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * clear([cnv!])
 * 
 * Clears a surface.
 */
CVariant clear(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 0)
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
	return CVariant();
}

/*
 * done()
 * 
 * End the program.
 */
CVariant done(CProgram::PARAMETERS params, CProgram *const prg)
{
	prg->end();
	return CVariant();
}

/*
 * windows()
 * 
 * Exit to windows.
 */
CVariant windows(CProgram::PARAMETERS params, CProgram *const)
{
	PostQuitMessage(0);
	return CVariant();
}

/*
 * empty(...)
 * 
 * Description.
 */
CVariant empty(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * end()
 * 
 * End the program.
 */
CVariant end(CProgram::PARAMETERS params, CProgram *const prg)
{
	prg->end();
	return CVariant();
}

/*
 * font(font$)
 * 
 * Load a font, either true type or TK2.
 */
CVariant font(CProgram::PARAMETERS params, CProgram *const)
{
	g_fontFace = params[0].getLit();
	return CVariant();
}

/*
 * fontsize(size!)
 * 
 * Set the font size.
 */
CVariant fontsize(CProgram::PARAMETERS params, CProgram *const)
{
	g_fontSize = params[0].getNum();
	return CVariant();
}

/*
 * fade(...)
 * 
 * Description.
 */
CVariant fade(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fbranch(...)
 * 
 * Description.
 */
CVariant fbranch(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fight(...)
 * 
 * Description.
 */
CVariant fight(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * key$ = get([key$])
 * 
 * Get a key from the queue.
 */
CVariant get(CProgram::PARAMETERS params, CProgram *const prg)
{
	extern std::vector<char> g_keys;
	if (g_keys.size() == 0)
	{
		return "";
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	switch (chr)
	{
		case 13: return "ENTER";
		case 38: return "UP";
		case 40: return "DOWN";
		case 37: return "RIGHT";
		case 39: return "LEFT";
	}
	const char str[] = {chr, '\0'};
	const std::string toRet = str;
	if (params.size() == 1)
	{
		prg->setVariable(params[0].getLit(), toRet);
	}
	return toRet;
}

/*
 * gone(...)
 * 
 * Description.
 */
CVariant gone(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * viewbrd(...)
 * 
 * Description.
 */
CVariant viewbrd(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * bold(on/off)
 * 
 * Toggle emboldening of text.
 */
CVariant bold(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		g_bold = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		CProgram::debugger("Bold() requires one parameter.");
	}
	return CVariant();
}

/*
 * italics(on/off)
 * 
 * Toggle italicizing of text.
 */
CVariant italics(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		g_italic = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		CProgram::debugger("Italics() requires one parameter.");
	}
	return CVariant();
}

/*
 * underline(on/off)
 * 
 * Toggle underlining of text.
 */
CVariant underline(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		g_underline = (parser::uppercase(params[0].getLit()) == "ON");
	}
	else
	{
		CProgram::debugger("Underline() requires one parameter.");
	}
	return CVariant();
}

/*
 * wingraphic(file$)
 * 
 * Set the message window background image.
 */
CVariant wingraphic(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		extern std::string g_projectPath;
		g_mwinBkg = g_projectPath + BMP_PATH + params[0].getLit();
		g_mwinColor = 0;
	}
	else
	{
		CProgram::debugger("WinGraphic() requires one parameter.");
	}
	return CVariant();
}

/*
 * wincolor(dos!)
 * 
 * Set the message window's colour using a DOS code.
 */
CVariant wincolor(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 1)
	{
		CProgram::debugger("WinColor() requires one parameter.");
	}
	else
	{
		g_mwinBkg = "";
		int color = params[0].getNum();
		if (color < 0) color = 0;
		else if (color > 255) color = 255;
		g_mwinColor = CTile::getDOSColor(color);
	}
	return CVariant();
}

/*
 * wincolorrgb(r!, g!, b!)
 * 
 * Set the message window's colour.
 */
CVariant wincolorrgb(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 3)
	{
		CProgram::debugger("WinColorRGB() requires three parameters.");
	}
	else
	{
		g_mwinBkg = "";
		g_mwinColor = RGB(params[0].getNum(), params[1].getNum(), params[2].getNum());
	}
	return CVariant();
}

/*
 * color(dos!)
 * 
 * Change to a DOS colour.
 */
CVariant color(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		int color = params[0].getNum();
		if (color < 0) color = 0;
		else if (color > 255) color = 255;
		g_color = CTile::getDOSColor(color);
	}
	else
	{
		CProgram::debugger("Color() requires one parameter.");
	}
	return CVariant();
}

/*
 * colorrgb(r!, g!, b!)
 * 
 * Change the active colour to an RGB value.
 */
CVariant colorrgb(CProgram::PARAMETERS params, CProgram *const)
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
CVariant move(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * newplyr(...)
 * 
 * Description.
 */
CVariant newplyr(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * over(...)
 * 
 * Description.
 */
CVariant over(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * prg(...)
 * 
 * Description.
 */
CVariant prg(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * prompt(...)
 * 
 * Description.
 */
CVariant prompt(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * put(x!, y!, tile$)
 * 
 * Put tile$ at x!, y! on the board.
 */
CVariant put(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 3)
	{
		CProgram::debugger("Put() requires three parameters.");
	}
	else
	{
		// getAmbientLevel();
		drawTileCnv(g_cnvRpgCode, params[2].getLit(), params[0].getNum(), params[1].getNum(), 0, 0, 0, false, true, false, false);
		renderRpgCodeScreen();
	}
	return CVariant();
}

/*
 * reset(...)
 * 
 * Description.
 */
CVariant reset(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * run(str$)
 * 
 * Transfer control to a different program.
 */
CVariant run(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		prg->end();
		extern std::string g_projectPath;
		CProgram(g_projectPath + PRG_PATH + params[0].getLit()).run();
	}
	else
	{
		CProgram::debugger("Run() requires one data element.");
	}
	return CVariant();
}

/*
 * sound()
 * 
 * Depreciated TK1 function.
 */
CVariant sound(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("Please use TK3's media functions, rather than this TK1 function!");
	return CVariant();
}

/*
 * win()
 * 
 * Wins the game.
 */
CVariant win(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("Win() is obsolete.");
	return CVariant();
}

/*
 * hp(handle$, value!)
 * 
 * Set a fighter's hp.
 */
CVariant hp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("HP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			p->health((params[0].getNum() <= p->maxHealth()) ? params[0].getNum() : p->maxHealth());
		}
	}
	return CVariant();
}

/*
 * givehp(handle$, add!)
 * 
 * Increase a fighter's current hp.
 */
CVariant givehp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("GiveHP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			const int hp = p->health() + params[0].getNum();
			p->health((hp <= p->maxHealth()) ? hp : p->maxHealth());
			// if (fighting)
			// {
			//		...
			// }
		}
	}
	return CVariant();
}

/*
 * gethp(handle$[, ret!])
 * 
 * Get a fighter's hp.
 */
CVariant gethp(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			return p->health();
		}
	}
	else if (params.size() == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			prg->setVariable(params[1].getLit(), p->health());
		}
	}
	else
	{
		CProgram::debugger("GetHP() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * maxhp(handle$, value!)
 * 
 * Set a fighter's max hp.
 */
CVariant maxhp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("MaxHP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			p->maxHealth(params[1].getNum());
		}
	}
	return CVariant();
}

/*
 * getmaxhp(handle$[, ret!])
 * 
 * Get a fighter's max hp.
 */
CVariant getmaxhp(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			return p->maxHealth();
		}
	}
	else if (params.size() == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			prg->setVariable(params[1].getLit(), p->maxHealth());
		}
	}
	else
	{
		CProgram::debugger("GetMaxHP() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * smp(handle$, value!)
 * 
 * Set a fighter's smp.
 */
CVariant smp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("SMP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			p->smp((params[0].getNum() <= p->maxSmp()) ? params[0].getNum() : p->maxSmp());
		}
	}
	return CVariant();
}

/*
 * givesmp(handle$, value!)
 * 
 * Increase a fighter's smp.
 */
CVariant givesmp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("GiveSMP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			const int hp = p->smp() + params[0].getNum();
			p->smp((hp <= p->maxSmp()) ? hp : p->maxSmp());
			// if (fighting)
			// {
			//		...
			// }
		}
	}
	return CVariant();
}

/*
 * getsmp(handle$[, ret!])
 * 
 * Get a fighter's smp.
 */
CVariant getsmp(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			return p->smp();
		}
	}
	else if (params.size() == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			prg->setVariable(params[1].getLit(), p->smp());
		}
	}
	else
	{
		CProgram::debugger("GetSMP() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * maxsmp(handle$, value!)
 * 
 * Set a fighter's max smp.
 */
CVariant maxsmp(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 2)
	{
		CProgram::debugger("MaxSMP() requires two parameters.");
	}
	else
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			p->maxSmp(params[1].getNum());
		}
	}
	return CVariant();
}

/*
 * getmaxsmp(handle$[, ret!])
 * 
 * Get a fighter's max smp.
 */
CVariant getmaxsmp(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			return p->maxSmp();
		}
	}
	else if (params.size() == 2)
	{
		IFighter *p = getFighter(params[0].getLit());
		if (p)
		{
			prg->setVariable(params[1].getLit(), p->maxSmp());
		}
	}
	else
	{
		CProgram::debugger("GetMaxSMP() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * start(...)
 * 
 * Description.
 */
CVariant start(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * giveitem(...)
 * 
 * Description.
 */
CVariant giveitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * takeitem(...)
 * 
 * Description.
 */
CVariant takeitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * wav(...)
 * 
 * Description.
 */
CVariant wav(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * delay(time!)
 * 
 * Delay for a certain number of seconds.
 */
CVariant delay(CProgram::PARAMETERS params, CProgram *const)
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
CVariant random(CProgram::PARAMETERS params, CProgram *const prg)
{
	const CVariant toRet = (1 + (rand() % int(params[0].getNum() + 1)));
	if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), toRet);
	}
	return toRet;
}

/*
 * push(...)
 * 
 * Description.
 */
CVariant push(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * tiletype(...)
 * 
 * Description.
 */
CVariant tiletype(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mediaplay(file$)
 * 
 * Set file$ as the background music.
 */
CVariant mediaplay(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		extern CAudioSegment *g_bkgMusic;
		g_bkgMusic->open(params[0].getLit());
		g_bkgMusic->play(true);
	}
	else
	{
		CProgram::debugger("MediaPlay() requires one parameter.");
	}
	return CVariant();
}

/*
 * mediastop()
 * 
 * Stop the background music.
 */
CVariant mediastop(CProgram::PARAMETERS params, CProgram *const)
{
	extern CAudioSegment *g_bkgMusic;
	g_bkgMusic->stop();
	return CVariant();
}

/*
 * godos(command$)
 * 
 * Call into DOS.
 */
CVariant godos(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("GoDos() is obsolete.");
	return CVariant();
}

/*
 * addplayer(file$)
 * 
 * Add a player to the party.
 */
CVariant addplayer(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 1)
	{
		CProgram::debugger("AddPlayer() requires one parameter.");
	}
	else
	{
		extern std::vector<CPlayer *> g_players;
		extern std::string g_projectPath;
		g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + params[0].getLit(), false));
	}
	return CVariant();
}

/*
 * removeplayer(...)
 * 
 * Description.
 */
CVariant removeplayer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * setpixel(x!, y![, cnv!])
 * 
 * Set a pixel in the current colour.
 */
CVariant setpixel(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 2)
	{
		g_cnvRpgCode->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.size() == 3)
	{
		CGDICanvas *cnv = g_canvases.cast((int)params[2].getNum());
		if (cnv)
		{
			cnv->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		}
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
CVariant drawline(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * drawrect(...)
 * 
 * Description.
 */
CVariant drawrect(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fillrect(...)
 * 
 * Description.
 */
CVariant fillrect(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * debug(...)
 * 
 * Description.
 */
CVariant debug(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * castnum(x)
 * 
 * Return x cast to a number. Pointless now.
 */
CVariant castnum(CProgram::PARAMETERS params, CProgram *const)
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
CVariant castlit(CProgram::PARAMETERS params, CProgram *const)
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
CVariant castint(CProgram::PARAMETERS params, CProgram *const)
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
CVariant pushitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * wander(...)
 * 
 * Description.
 */
CVariant wander(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * bitmap(file$[, cnv!])
 * 
 * Fill a surface with an image.
 */
CVariant bitmap(CProgram::PARAMETERS params, CProgram *const)
{
	CGDICanvas *cnv = NULL;
	if (params.size() == 1)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.size() == 2)
	{
		cnv = g_canvases.cast(int(params[1].getNum()));
	}
	else
	{
		CProgram::debugger("Bitmap() requires one or two parameters.");
	}
	if (cnv)
	{
		extern std::string g_projectPath;
		const std::string file = g_projectPath + BMP_PATH + params[0].getLit();
		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(file.c_str(), 16), file.c_str());
		const HDC hdc = cnv->OpenDC();
		extern int g_resX, g_resY;
		StretchDIBits(hdc, 0, 0, g_resX, g_resY, 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
		cnv->CloseDC(hdc);
		FreeImage_Unload(bmp);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
	return CVariant();
}

/*
 * mainfile(...)
 * 
 * Description.
 */
CVariant mainfile(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * dirsav(...)
 * 
 * Description.
 */
CVariant dirsav(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * save(...)
 * 
 * Description.
 */
CVariant save(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * load(...)
 * 
 * Description.
 */
CVariant load(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * scan(...)
 * 
 * Description.
 */
CVariant scan(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mem(...)
 * 
 * Description.
 */
CVariant mem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * print(...)
 * 
 * Description.
 */
CVariant print(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * rpgcode(line$)
 * 
 * Independently run a line of RPGCode.
 */
CVariant rpgcode(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		prg->runLine(params[0].getLit());
	}
	else
	{
		CProgram::debugger("RPGCode() requires one parameter.");
	}
	return CVariant();
}

/*
 * charat(...)
 * 
 * Description.
 */
CVariant charat(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * equip(...)
 * 
 * Description.
 */
CVariant equip(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * remove(...)
 * 
 * Description.
 */
CVariant remove(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * putplayer(...)
 * 
 * Description.
 */
CVariant putplayer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * eraseplayer(...)
 * 
 * Description.
 */
CVariant eraseplayer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * include(...)
 * 
 * Description.
 */
CVariant include(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * kill(...)
 * 
 * Description.
 */
CVariant kill(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * givegp(...)
 * 
 * Description.
 */
CVariant givegp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * takegp(...)
 * 
 * Description.
 */
CVariant takegp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getgp(...)
 * 
 * Description.
 */
CVariant getgp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * wavstop(...)
 * 
 * Description.
 */
CVariant wavstop(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * bordercolor(r!, g!, b!)
 * 
 * Obsolete.
 */
CVariant bordercolor(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("BorderColor() is obsolete.");
	return CVariant();
}

/*
 * fightenemy(...)
 * 
 * Description.
 */
CVariant fightenemy(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * restoreplayer(...)
 * 
 * Description.
 */
CVariant restoreplayer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * callshop(...)
 * 
 * Description.
 */
CVariant callshop(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * clearbuffer(...)
 * 
 * Description.
 */
CVariant clearbuffer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * attackall(...)
 * 
 * Description.
 */
CVariant attackall(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * drainall(...)
 * 
 * Description.
 */
CVariant drainall(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * inn()
 * 
 * Fully heal the player party.
 */
CVariant inn(CProgram::PARAMETERS params, CProgram *const)
{
	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::iterator i = g_players.begin();
	for (; i != g_players.end(); ++i)
	{
		(*i)->health((*i)->maxHealth());
		(*i)->smp((*i)->maxSmp());
	}
	return CVariant();
}

/*
 * targetlocation(...)
 * 
 * Description.
 */
CVariant targetlocation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * eraseitem(...)
 * 
 * Description.
 */
CVariant eraseitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * putitem(...)
 * 
 * Description.
 */
CVariant putitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * createitem(...)
 * 
 * Description.
 */
CVariant createitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * destroyitem(...)
 * 
 * Description.
 */
CVariant destroyitem(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * walkspeed(fast/slow)
 * 
 * Obsolete.
 */
CVariant walkspeed(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("WalkSpeed() is obsolete.");
	return CVariant();
}

/*
 * itemwalkspeed(fast/slow)
 * 
 * Obsolete.
 */
CVariant itemwalkspeed(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("ItemWalkSpeed() is obsolete.");
	return CVariant();
}

/*
 * posture(...)
 * 
 * Description.
 */
CVariant posture(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * setbutton(...)
 * 
 * Description.
 */
CVariant setbutton(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * checkbutton(...)
 * 
 * Description.
 */
CVariant checkbutton(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * clearbuttons(...)
 * 
 * Description.
 */
CVariant clearbuttons(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mouseclick(...)
 * 
 * Description.
 */
CVariant mouseclick(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mousemove(...)
 * 
 * Description.
 */
CVariant mousemove(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * zoom(...)
 * 
 * Description.
 */
CVariant zoom(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * earthquake(...)
 * 
 * Description.
 */
CVariant earthquake(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * itemcount(...)
 * 
 * Description.
 */
CVariant itemcount(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * destroyplayer(...)
 * 
 * Description.
 */
CVariant destroyplayer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * callplayerswap(...)
 * 
 * Description.
 */
CVariant callplayerswap(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * playavi(...)
 * 
 * Description.
 */
CVariant playavi(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * playavismall(...)
 * 
 * Description.
 */
CVariant playavismall(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getcorner(...)
 * 
 * Description.
 */
CVariant getcorner(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * underarrow(...)
 * 
 * Description.
 */
CVariant underarrow(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getlevel(...)
 * 
 * Description.
 */
CVariant getlevel(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * ai(...)
 * 
 * Description.
 */
CVariant ai(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * menugraphic(...)
 * 
 * Description.
 */
CVariant menugraphic(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fightmenugraphic(...)
 * 
 * Description.
 */
CVariant fightmenugraphic(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fightstyle(0/1)
 * 
 * Obsolete.
 */
CVariant fightstyle(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("FightStyle() is obsolete.");
	return CVariant();
}

/*
 * stance(...)
 * 
 * Description.
 */
CVariant stance(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * battlespeed(speed!)
 * 
 * Obsolete.
 */
CVariant battlespeed(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("BattleSpeed() is obsolete.");
	return CVariant();
}

/*
 * textspeed(speed!)
 * 
 * Obsolete.
 */
CVariant textspeed(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("TextSpeed() is obsolete.");
	return CVariant();
}

/*
 * mwinsize(...)
 * 
 * Description.
 */
CVariant mwinsize(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getdp(...)
 * 
 * Description.
 */
CVariant getdp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getfp(...)
 * 
 * Description.
 */
CVariant getfp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * internalmenu(...)
 * 
 * Description.
 */
CVariant internalmenu(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * applystatus(...)
 * 
 * Description.
 */
CVariant applystatus(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * removestatus(...)
 * 
 * Description.
 */
CVariant removestatus(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * SetImage(str$, x!, y!, width!, height![, cnv!])
 * 
 * Sets an image.
 */
CVariant setimage(CProgram::PARAMETERS params, CProgram *const)
{
	CGDICanvas *cnv = NULL;
	if (params.size() == 5)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.size() == 6)
	{
		cnv = g_canvases.cast(int(params[5].getNum()));
	}
	else
	{
		CProgram::debugger("SetImage() requires five or six parameters.");
	}
	if (cnv)
	{
		/**const std::string file = g_projectPath + BMP_PATH + params[0].getLit();
		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(file.c_str(), 16), file.c_str());
		const HDC hdc = cnv->OpenDC();
		StretchDIBits(hdc, params[1].getNum(), params[2].getNum(), params[3].getNum(), params[4].getNum(), 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
		cnv->CloseDC(hdc);
		FreeImage_Unload(bmp);**/
		extern std::string g_projectPath;
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), cnv, params[1].getNum(), params[2].getNum(), params[3].getNum(), params[4].getNum());
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
	return CVariant();
}

/*
 * drawcircle(...)
 * 
 * Description.
 */
CVariant drawcircle(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fillcircle(...)
 * 
 * Description.
 */
CVariant fillcircle(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * savescreen(...)
 * 
 * Description.
 */
CVariant savescreen(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * restorescreen(...)
 * 
 * Description.
 */
CVariant restorescreen(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * sin(x![, ret!])
 * 
 * Calculate sine x.
 */
CVariant sin(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return sin(params[0].getNum() / 180 * PI);
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), sin(params[0].getNum() / 180 * PI));
	}
	return CVariant();
}

/*
 * cos(x![, ret!])
 * 
 * Calculate cosine x.
 */
CVariant cos(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return cos(params[0].getNum() / 180 * PI);
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), cos(params[0].getNum() / 180 * PI));
	}
	return CVariant();
}

/*
 * tan(x![, ret!])
 * 
 * Calculate tangent x.
 */
CVariant tan(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return tan(params[0].getNum() / 180 * PI);
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), tan(params[0].getNum() / 180 * PI));
	}
	return CVariant();
}

/*
 * getpixel(x!, y!, r!, g!, b![, cnv])
 * 
 * Get the colour of the pixel at x, y.
 */
CVariant getpixel(CProgram::PARAMETERS params, CProgram *const prg)
{
	COLORREF color = 0;
	if (params.size() == 5)
	{
		color = g_cnvRpgCode->GetPixel(params[0].getNum(), params[1].getNum());
	}
	else if (params.size() == 6)
	{
		CGDICanvas *cnv = g_canvases.cast(int(params[5].getNum()));
		if (cnv)
		{
			color = cnv->GetPixel(params[0].getNum(), params[1].getNum());
		}
	}
	else
	{
		CProgram::debugger("GetPixel() requires five or six parameters.");
	}
	prg->setVariable(params[2].getLit(), GetRValue(color));
	prg->setVariable(params[3].getLit(), GetGValue(color));
	prg->setVariable(params[4].getLit(), GetBValue(color));
	return CVariant();
}

/*
 * getcolor(r!, g!, b!)
 * 
 * Get the current colour.
 */
CVariant getcolor(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 3)
	{
		prg->setVariable(params[0].getLit(), GetRValue(g_color));
		prg->setVariable(params[1].getLit(), GetGValue(g_color));
		prg->setVariable(params[2].getLit(), GetBValue(g_color));
	}
	else
	{
		CProgram::debugger("GetColor() requires three parameters.");
	}
	return CVariant();
}

/*
 * size! = getfontsize([size!])
 * 
 * Get the current font size.
 */
CVariant getfontsize(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		prg->setVariable(params[0].getLit(), g_fontSize);
	}
	return g_fontSize;
}

/*
 * SetImageTransparent(file$, x!, y!, width!, height!, r!, g!, b![, cnv!])
 * 
 * Set an image with a transparent colour.
 */
CVariant setimagetransparent(CProgram::PARAMETERS params, CProgram *const)
{
	CGDICanvas *cnv = NULL;
	if (params.size() == 8)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.size() == 9)
	{
		cnv = g_canvases.cast(int(params[8].getNum()));
	}
	else
	{
		CProgram::debugger("SetImageTransparent() requires eight or nine parameters.");
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
	return CVariant();
}

/*
 * SetImageTranslucent(file$, x!, y!, width!, height![, cnv!])
 * 
 * Set an image translucently.
 */
CVariant setimagetranslucent(CProgram::PARAMETERS params, CProgram *const)
{
	CGDICanvas *cnv = NULL;
	if (params.size() == 5)
	{
		cnv = g_cnvRpgCode;
	}
	else if (params.size() == 6)
	{
		cnv = g_canvases.cast(int(params[5].getNum()));
	}
	else
	{
		CProgram::debugger("SetImageTransparent() requires five or six parameters.");
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
	return CVariant();
}

/*
 * sourcelocation(...)
 * 
 * Description.
 */
CVariant sourcelocation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * targethandle(...)
 * 
 * Description.
 */
CVariant targethandle(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * sourcehandle(...)
 * 
 * Description.
 */
CVariant sourcehandle(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * drawenemy(...)
 * 
 * Description.
 */
CVariant drawenemy(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mp3pause(...)
 * 
 * Description.
 */
CVariant mp3pause(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * layerput(...)
 * 
 * Description.
 */
CVariant layerput(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getboardtile(...)
 * 
 * Description.
 */
CVariant getboardtile(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * sqrt(x![, ret!])
 * 
 * Calculate the square root of x.
 */
CVariant sqrt(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return sqrt(params[0].getNum());
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), sqrt(params[0].getNum()));
	}
	return CVariant();
}

/*
 * getboardtiletype(...)
 * 
 * Description.
 */
CVariant getboardtiletype(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * setimageadditive(...)
 * 
 * Description.
 */
CVariant setimageadditive(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * animation(...)
 * 
 * Description.
 */
CVariant animation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * sizedanimation(...)
 * 
 * Description.
 */
CVariant sizedanimation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * forceredraw()
 * 
 * Force a redrawing of the screen.
 */
CVariant forceredraw(CProgram::PARAMETERS params, CProgram *const)
{
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
	return CVariant();
}

/*
 * itemlocation(...)
 * 
 * Description.
 */
CVariant itemlocation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * wipe(...)
 * 
 * Description.
 */
CVariant wipe(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getres(x!, y!)
 * 
 * Get the screen's resolution.
 */
CVariant getres(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() != 2)
	{
		CProgram::debugger("GetRes() requires two parameters.");
	}
	else
	{
		extern int g_resX, g_resY;
		prg->setVariable(params[0].getLit(), g_resX);
		prg->setVariable(params[1].getLit(), g_resY);
	}
	return CVariant();
}

/*
 * xyzzy()
 * 
 * Tribute to ZZT.
 */
CVariant xyzzy(CProgram::PARAMETERS, CProgram *const prg)
{
	std::vector<CVariant> params;
	params.push_back(CVariant("Nothing happens..."));
	return mwin(params, prg);
}

/*
 * statictext()
 * 
 * Toggle antialiasing.
 */
CVariant statictext(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("StaticText() is obsolete.");
	return CVariant();
}

/*
 * pathfind(...)
 * 
 * Description.
 */
CVariant pathfind(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * itemstep(...)
 * 
 * Description.
 */
CVariant itemstep(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * playerstep(...)
 * 
 * Description.
 */
CVariant playerstep(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * redirect(...)
 * 
 * Description.
 */
CVariant redirect(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * killredirect(...)
 * 
 * Description.
 */
CVariant killredirect(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * killallredirects(...)
 * 
 * Description.
 */
CVariant killallredirects(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * parallax(...)
 * 
 * Description.
 */
CVariant parallax(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * giveexp(...)
 * 
 * Description.
 */
CVariant giveexp(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * AnimatedTiles()
 * 
 * Toggle animated tiles.
 */
CVariant animatedtiles(CProgram::PARAMETERS params, CProgram *const)
{
	CProgram::debugger("AnimatedTiles() is obsolete.");
	return CVariant();
}

/*
 * smartstep(...)
 * 
 * Description.
 */
CVariant smartstep(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * gamespeed(...)
 * 
 * Description.
 */
CVariant gamespeed(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * CharacterSpeed(speed!)
 * 
 * Obsolete.
 */
CVariant characterspeed(CProgram::PARAMETERS params, CProgram *const prg)
{
	CProgram::debugger("CharacterSpeed() has depreciated into GameSpeed().");
	return gamespeed(params, prg);
}

/*
 * thread(file$, presist![, id!])
 * 
 * Start a thread.
 */
CVariant thread(CProgram::PARAMETERS params, CProgram *const prg)
{
	/**extern std::string g_projectPath;
	if (params.size() == 2)
	{
		CThread *p = g_threads.allocate();
		p->start(g_projectPath + PRG_PATH + params[0].getLit());
		return int(p);
	}
	else if (params.size() == 3)
	{
		CThread *p = g_threads.allocate();
		p->start(g_projectPath + PRG_PATH + params[0].getLit());		
		prg->setVariable(params[2].getLit(), int(p));
	}
	else
	{
		CProgram::debugger("Thread() requires two or three parameters.");
	}**/
	return CVariant();
}

/*
 * killthread(id!)
 * 
 * Kill a thread.
 */
CVariant killthread(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getthreadid(...)
 * 
 * Description.
 */
CVariant getthreadid(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * threadsleep(...)
 * 
 * Description.
 */
CVariant threadsleep(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * tellthread(...)
 * 
 * Description.
 */
CVariant tellthread(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * threadwake(...)
 * 
 * Description.
 */
CVariant threadwake(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * threadsleepremaining(...)
 * 
 * Description.
 */
CVariant threadsleepremaining(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * local(...)
 * 
 * Description.
 */
CVariant local(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * global(...)
 * 
 * Description.
 */
CVariant global(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * autocommand()
 * 
 * Obsolete.
 */
CVariant autocommand(CProgram::PARAMETERS params, CProgram *const)
{
	// Does nothing, but don't bother showing an error.
	return CVariant();
}

/*
 * createcursormap([map!])
 * 
 * Create a cursor map.
 */
CVariant createcursormap(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 0)
	{
		return int(g_cursorMaps.allocate());
	}
	else if (params.size() == 1)
	{
		prg->setVariable(params[0].getLit(), int(g_cursorMaps.allocate()));
	}
	else
	{
		CProgram::debugger("CreateCursorMap() requires zero or one parameters.");
	}
	return CVariant();
}

/*
 * killcursormap(map!)
 * 
 * Kill a cursor map.
 */
CVariant killcursormap(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 1)
	{
		CProgram::debugger("KillCursorMap() requires one parameter.");
	}
	else
	{
		g_cursorMaps.free((CCursorMap *)(int)params[0].getNum());
	}
	return CVariant();
}

/*
 * cursormapadd(x!, y!, map!)
 * 
 * Add a point to a cursor map.
 */
CVariant cursormapadd(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 3)
	{
		CProgram::debugger("CursorMapAdd() requires three parameters.");
	}
	else
	{
		CCursorMap *p = g_cursorMaps.cast((int)params[2].getNum());
		if (p)
		{
			p->add(params[0].getNum(), params[1].getNum());
		}
	}
	return CVariant();
}

/*
 * cursormaprun(map![, ret!])
 * 
 * Run a cursor map.
 */
CVariant cursormaprun(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		CCursorMap *p = g_cursorMaps.cast((int)params[0].getNum());
		if (p)
		{
			return p->run();
		}
	}
	else if (params.size() == 2)
	{
		CCursorMap *p = g_cursorMaps.cast((int)params[0].getNum());
		if (p)
		{
			prg->setVariable(params[1].getLit(), p->run());
		}
	}
	else
	{
		CProgram::debugger("CursorMapRun() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * createcanvas(width!, height![, cnv!])
 * 
 * Create a canvas.
 */
CVariant createcanvas(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() != 2 && params.size() != 3)
	{
		CProgram::debugger("CreateCanvas() requires two or three parameters.");
		return CVariant();
	}
	CGDICanvas *p = g_canvases.allocate();
	p->CreateBlank(NULL, params[0].getNum(), params[1].getNum(), TRUE);
	p->ClearScreen(0);
	if (params.size() == 3)
	{
		prg->setVariable(params[2].getLit(), int(p));
	}
	return int(p);
}

/*
 * killcanvas(cnv!)
 * 
 * Kill a canvas.
 */
CVariant killcanvas(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() != 1)
	{
		CProgram::debugger("KillCanvas() requires one parameter.");
	}
	else
	{
		CGDICanvas *p = (CGDICanvas *)(int)params[0].getNum();
		g_canvases.free(p);
	}
	return CVariant();
}

/*
 * drawcanvas(cnv!, x!, y![, width!, height![, dest!]])
 * 
 * Blit a canvas forward.
 */
CVariant drawcanvas(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 3)
	{
		CGDICanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->Blt(g_cnvRpgCode, params[1].getNum(), params[2].getNum());
			renderRpgCodeScreen();
		}
	}
	else if (params.size() == 5)
	{
		CGDICanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->BltStretch(g_cnvRpgCode, params[1].getNum(), params[2].getNum(), 0, 0, p->GetWidth(), p->GetHeight(), params[3].getNum(), params[4].getNum(), SRCCOPY);
			renderRpgCodeScreen();
		}
	}
	else if (params.size() == 6)
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
		CProgram::debugger("DrawCanvas() requires three, five, or six parameters.");
	}
	return CVariant();
}

/*
 * openfileinput(...)
 * 
 * Description.
 */
CVariant openfileinput(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * openfileoutput(...)
 * 
 * Description.
 */
CVariant openfileoutput(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * openfileappend(...)
 * 
 * Description.
 */
CVariant openfileappend(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * openfilebinary(...)
 * 
 * Description.
 */
CVariant openfilebinary(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * closefile(...)
 * 
 * Description.
 */
CVariant closefile(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fileinput(...)
 * 
 * Description.
 */
CVariant fileinput(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fileprint(...)
 * 
 * Description.
 */
CVariant fileprint(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fileget(...)
 * 
 * Description.
 */
CVariant fileget(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fileput(...)
 * 
 * Description.
 */
CVariant fileput(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * fileeof(...)
 * 
 * Description.
 */
CVariant fileeof(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * len! = len(str$[, length!)
 * 
 * Get the length of a string.
 */
CVariant len(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return params[0].getLit().length();
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), params[0].getLit().length());
	}
	else
	{
		CProgram::debugger("Len() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * instr(...)
 * 
 * Description.
 */
CVariant instr(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getitemname(...)
 * 
 * Description.
 */
CVariant getitemname(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getitemdesc(...)
 * 
 * Description.
 */
CVariant getitemdesc(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getitemcost(...)
 * 
 * Description.
 */
CVariant getitemcost(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getitemsellprice(...)
 * 
 * Description.
 */
CVariant getitemsellprice(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * with(...)
 * 
 * Description.
 */
CVariant with(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * restorescreenarray(...)
 * 
 * Description.
 */
CVariant restorescreenarray(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * restorearrayscreen(...)
 * 
 * Description.
 */
CVariant restorearrayscreen(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * splicevariables(...)
 * 
 * Description.
 */
CVariant splicevariables(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * split(...)
 * 
 * Description.
 */
CVariant split(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * ret! = asc(chr$[, ret!])
 * 
 * Get the ASCII value of chr$
 */
CVariant asc(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1)
	{
		return (double)params[0].getLit()[0];
	}
	else if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), (double)params[0].getLit()[0]);
	}
	else
	{
		CProgram::debugger("Asc() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * chr$ = chr(asc![, chr$])
 * 
 * Get the character represented by the ASCII code passed in.
 */
CVariant chr(CProgram::PARAMETERS params, CProgram *const prg)
{
	std::string ret;
	ret += (char)params[0].getNum();
	if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), ret);
	}
	return ret;
}

/*
 * ret$ = trim(str$[, ret$})
 * 
 * Trim whitespace from a string.
 */
CVariant trim(CProgram::PARAMETERS params, CProgram *const prg)
{
	if (params.size() == 1 || params.size() == 2)
	{
		const std::string toRet = parser::trim(params[0].getLit());
		if (params.size() == 1)
		{
			return toRet;
		}
		else
		{
			prg->setVariable(params[1].getLit(), toRet);
		}
	}
	else
	{
		CProgram::debugger("Trim() requires one or two parameters.");
	}
	return CVariant();
}

/*
 * right(...)
 * 
 * Description.
 */
CVariant right(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * left(...)
 * 
 * Description.
 */
CVariant left(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * cursormaphand(...)
 * 
 * Description.
 */
CVariant cursormaphand(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * debugger(message!)
 * 
 * Show a debug message.
 */
CVariant debugger(CProgram::PARAMETERS params, CProgram *const)
{
	if (params.size() == 1)
	{
		CProgram::debugger(params[0].getLit());
	}
	else
	{
		CProgram::debugger("Debugger() requires one parameter.");
	}
	return CVariant();
}

/*
 * onerror(...)
 * 
 * Description.
 */
CVariant onerror(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * resumenext(...)
 * 
 * Description.
 */
CVariant resumenext(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * msgbox(...)
 * 
 * Description.
 */
CVariant msgbox(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * setconstants(...)
 * 
 * Description.
 */
CVariant setconstants(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * ret! = log(x![, ret!])
 * 
 * Get the natural log of x!
 */
CVariant log(CProgram::PARAMETERS params, CProgram *const prg)
{
	const double toRet = log(params[0].getNum());
	if (params.size() == 2)
	{
		prg->setVariable(params[1].getLit(), toRet);
	}
	return toRet;
}

/*
 * onboard(...)
 * 
 * Description.
 */
CVariant onboard(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * autolocal(...)
 * 
 * Description.
 */
CVariant autolocal(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * getboardname(...)
 * 
 * Description.
 */
CVariant getboardname(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * pixelmovement(...)
 * 
 * Description.
 */
CVariant pixelmovement(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * lcase(...)
 * 
 * Description.
 */
CVariant lcase(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * ucase(...)
 * 
 * Description.
 */
CVariant ucase(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * apppath(...)
 * 
 * Description.
 */
CVariant apppath(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mid(...)
 * 
 * Description.
 */
CVariant mid(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * replace(...)
 * 
 * Description.
 */
CVariant replace(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * endanimation(...)
 * 
 * Description.
 */
CVariant endanimation(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * rendernow(...)
 * 
 * Description.
 */
CVariant rendernow(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * multirun(...)
 * 
 * Description.
 */
CVariant multirun(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * shopcolors(...)
 * 
 * Description.
 */
CVariant shopcolors(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * itemspeed(...)
 * 
 * Description.
 */
CVariant itemspeed(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * playerspeed(...)
 * 
 * Description.
 */
CVariant playerspeed(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * mousecursor(...)
 * 
 * Description.
 */
CVariant mousecursor(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * gettextwidth(...)
 * 
 * Description.
 */
CVariant gettextwidth(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * gettextheight(...)
 * 
 * Description.
 */
CVariant gettextheight(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * iif(...)
 * 
 * Description.
 */
CVariant iif(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * itemstance(...)
 * 
 * Description.
 */
CVariant itemstance(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * playerstance(...)
 * 
 * Description.
 */
CVariant playerstance(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * drawcanvastransparent(...)
 * 
 * Description.
 */
CVariant drawcanvastransparent(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * gettickcount()
 * 
 * Get the number of milliseconds since Windows started.
 */
CVariant gettickcount(CProgram::PARAMETERS params, CProgram *const)
{
	return GetTickCount();
}

/*
 * setvolume(...)
 * 
 * Description.
 */
CVariant setvolume(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * createtimer(...)
 * 
 * Description.
 */
CVariant createtimer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * killtimer(...)
 * 
 * Description.
 */
CVariant killtimer(CProgram::PARAMETERS params, CProgram *const)
{
	return CVariant();
}

/*
 * setmwintranslucency(...)
 * 
 * Description.
 */
CVariant setmwintranslucency(CProgram::PARAMETERS params, CProgram *const)
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
	CProgram::addFunction("length", len);
	CProgram::addFunction("len", len);
	CProgram::addFunction("instr", instr);
	CProgram::addFunction("getitemname", getitemname);
	CProgram::addFunction("getitemdesc", getitemdesc);
	CProgram::addFunction("getitemcost", getitemcost);
	CProgram::addFunction("getitemsellprice", getitemsellprice);
	CProgram::addFunction("with", with);
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
