/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin Fitzpatrick & Jonathan Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

/*
 * RPGCode functions.
 */

/*
 * Inclusions.
 */
#include "../../tkCommon/board/coords.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../../tkCommon/strings.h"
#include "../input/input.h"
#include "../render/render.h"
#include "../audio/CAudioSegment.h"
#include "../common/CAnimation.h"
#include "../common/board.h"
#include "../common/mainfile.h"
#include "../common/paths.h"
#include "../common/CAllocationHeap.h"
#include "../common/CInventory.h"
#include "../common/CFile.h"
#include "../common/CShop.h"
#include "../common/mbox.h"
#include "../common/state.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/CPathFind/CPathFind.h"
#include "../../tkCommon/images/FreeImage.h"
#include "../../tkCommon/board/conversion.h"
#include "../fight/fight.h"
#include "../misc/misc.h"
#include "../plugins/plugins.h"
#include "../plugins/constants.h"
#include "../video/CVideo.h"
#include "../stdafx.h"
#include "../resource.h"
#include "CCursorMap.h"
#include "CProgram.h"
#include <math.h>
#include <iostream>
#include <shellapi.h>
#include <objbase.h>
#include <typeinfo.h>

/*
 * Globals.
 */
extern CCanvas *g_cnvRpgCode;
STRING g_fontFace = _T("Arial");			// Font face.
int g_fontSize = 20;						// Font size.
COLORREF g_color = RGB(255, 255, 255);		// Current colour.
BOOL g_bold = FALSE;						// Bold enabled?
BOOL g_italic = FALSE;						// Italics enabled?
BOOL g_underline = FALSE;					// Underline enabled?
CAllocationHeap<CCanvas> g_canvases;		// Allocated canvases.
CAllocationHeap<CCursorMap> g_cursorMaps;	// Cursor maps.
ENTITY g_target, g_source;					// Target and source.
CInventory g_inv;							// Inventory.
unsigned long g_gp = 0;						// Amount of gold.
std::map<STRING, CFile> g_files;			// Files opened using RPGCode.
double g_textX = 0.0, g_textY = 0.0;		// Last position text() was used at.
typedef std::pair<STRING, RECT> RPG_BUTTON;	// Rpgcode button <image, position>
std::map<int, RPG_BUTTON> g_buttons;		// setButton(), checkButton().
const int MISC_DELAY = 5;					// Miscellaneous delay (millisecond).
bool g_multirunning = false;				// Are we in multirun()'s scope (non-thread only). 
double g_spriteTranslucency = 0.5;			// Sprite translucency.

// CLSID for Microsoft's regular expression class.
const CLSID CLSID_REGEXP = {0x3F4DACA4, 0x160D, 0x11D2, {0xA8, 0xE9, 0x00, 0x10, 0x4B, 0x36, 0x5C, 0x9F}};

/*
 * Rpgcode flags.
 */

// Vector type constants.
typedef enum tkVT_CONSTANTS
{
	tkVT_SOLID				= TT_SOLID,
	tkVT_UNDER				= TT_UNDER,
	tkVT_STAIRS				= TT_STAIRS,
	tkVT_WAYPOINT			= TT_WAYPOINT,

	tkVT_BKGIMAGE			= TA_BRD_BACKGROUND,		// Under tiletype attributes.
	tkVT_ALL_LAYERS_BELOW	= TA_ALL_LAYERS_BELOW,
	tkVT_FRAME_INTERSECT	= TA_FRAME_INTERSECT
};


// BoardGetProgram() to BoardSetProgramPoint().
typedef enum tkPRG_CONSTANTS
{
	tkPRG_STEP				= PRG_STEP,
	tkPRG_KEYPRESS			= PRG_KEYPRESS,
	tkPRG_REPEAT			= PRG_REPEAT,
	tkPRG_STOPS_MOVEMENT	= PRG_STOPS_MOVEMENT
};

/*
 * Become ready to run a program.
 */
void programInit()
{
	extern CDirectDraw *g_pDirectDraw;
	extern MESSAGE_WINDOW g_mwin;

	// Don't reset the message the window if we're here
	// from another program (e.g. by run() or rpgcode()).
	if (CProgram::getRunningProgramCount() > 1) return;

	g_pDirectDraw->CopyScreenToCanvas(g_cnvRpgCode);
	g_mwin.hide();
}

/*
 * Finish running a program.
 */
void programFinish()
{
	extern MESSAGE_WINDOW g_mwin;
	// Refer to programInit().
	if (CProgram::getRunningProgramCount() > 1) return;
	g_mwin.visible = false;
}

/*
 * Format direction string.
 */
STRING formatDirectionString(STRING str)
{
	str = parser::uppercase(str);
	const STRING delimiter = _T(",");

	// If the string contains any delimiters,
	// assume it's been properly formatted.
	if (str.find(delimiter, 0) != STRING::npos) return str;
	
	STRING s;
	for (STRING::iterator i = str.begin(); i != str.end(); ++i)
	{
		if (i[0] == _T(' ')) continue;

		if (i[0] == _T('N') || i[0] == _T('W'))
		{
			// Start of a direction.
			s += delimiter;
		}
		else if (i[0] == _T('S'))
		{
			// Look at the next letter.
			if (i >= str.end() - 1 || i[1] != _T('T'))
			{
				// Not part of west or east.
				s += delimiter;
			}
		}
		else if (i[0] == _T('E'))
		{
			// Look at the 2nd next letter.
			if (i >= str.end() - 2 || i[2] != _T('T'))
			{
				// Not part of west.
				s += delimiter;
			}
		}
		s += *i;

	} // for (i)

	return s;
}

/*
 * Get a player by name.
 */
IFighter *getFighter(const STRING name)
{
	// Check for "target".
	if (_ftcsicmp(_T("target"), name.c_str()) == 0)
	{
		if ((g_target.type == ET_PLAYER) || (g_target.type == ET_ENEMY))
		{
			return (IFighter *)g_target.p;
		}
		else
		{
			return NULL;
		}
	}
	// Check for "source".
	if (_ftcsicmp(_T("source"), name.c_str()) == 0)
	{
		if ((g_source.type == ET_PLAYER) || (g_source.type == ET_ENEMY))
		{
			return (IFighter *)g_source.p;
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
		if (_ftcsicmp((*i)->name().c_str(), name.c_str()) == 0)
		{
			return *i;
		}
	}
	// Doesn't exist.
	return NULL;
}

/*
 * Get a player pointer from an index / literal target parameter.
 */
CPlayer *getPlayerPointer(STACK_FRAME &param)
{
	extern std::vector<CPlayer *> g_players;

	if (param.getType() & UDT_LIT)
	{
		// Handle, "target", "source".
		return (CPlayer *)(getFighter(param.getLit()));
	}

	// g_players index.
	const int i = int(param.getNum());
	if (i < g_players.size())
	{
		return g_players.at(i);
	}
	return NULL;
}

/*
 * Get an item pointer from a board index / literal target parameter.
 */
CItem *getItemPointer(STACK_FRAME &param)
{
	extern LPBOARD g_pBoard;

	if (param.getType() & UDT_NUM)
	{
		const unsigned int i = (unsigned int)param.getNum();
		if (g_pBoard->items.size() > i)
		{
			return g_pBoard->items[i];
		}
		else
		{
			char str[255]; itoa(i, str, 10);
			throw CError(_T("Item does not exist at board index ") + STRING(str) + _T("."));
		}
	}

	const STRING str = param.getLit();
	if (_ftcsicmp(str.c_str(), _T("target")) == 0)
	{
		return (CItem *)g_target.p;
	}
	else if (_ftcsicmp(str.c_str(), _T("source")) == 0)
	{
		return (CItem *)g_source.p;
	}
	else
	{
		throw CError(_T("Literal item target must be \"target\" or \"source\"."));
	}

	return NULL;
}


/*
 * Splice arrays, e.g. "<array[i!]>" or "<array[str$]>" or <"array[map]">.
 */
STRING spliceArrays(CProgram *prg, STRING str)
{
	STRING::iterator i = str.begin(), first = NULL, last = NULL;
	int depth = 0;

	for (; i < str.end(); ++i)
	{
		if (*i == _T('['))
		{
			if (!depth) first = i + 1;
			++depth;
		}
		else if (*i == _T(']'))
		{
			if (!--depth)
			{
				// Deal with nested arrays.
				last = i;
				STRING var = STRING(first, last);
				
				if (var.find_first_of(_T("!$")) != STRING::npos)
				{
					var = spliceArrays(prg, var);
					replace(var, _T("!"), _T(""));
					replace(var, _T("$"), _T(""));

					const STRING val = prg->getVar(var)->getLit();
					str.replace(first, last, val);

					// first will be invalid if replace() caused reallocation.
					i = first + val.length();
				}
			}
		}
	}
	return str;
}

/*
 * Splice variables.
 */
STRING spliceVariables(CProgram *prg, STRING str)
{
	STRING::size_type pos = STRING::npos;
	
	while (true)
	{
		pos = str.find_first_of(_T('<'), pos + 1);
		if (pos == STRING::npos) break;

		STRING::size_type	l = str.find_first_of(_T('<'), pos + 1),
							r = str.find_first_of(_T('>'), pos + 1);
		if ((l < r) && (l != STRING::npos)) continue;
		if (r == STRING::npos) break;

		STRING var = str.substr(pos + 1, r - pos - 1);

		// Convert to lower case.
		char *const lower = _tcslwr(_tcsdup(var.c_str()));
		var = lower;
		free(lower);

		// Splice arrays before removing old identifiers.
		var = spliceArrays(prg, var);

		replace(var, _T("!"), _T(""));
		replace(var, _T("$"), _T(""));

		const STRING val = prg->getVar(var)->getLit();
		str.erase(pos, r - pos + 1);
		str.insert(pos, val);

		pos = STRING::npos;
	}
	return str;
}

/*
 * @fpbegin: Marker for functionparse.php - do not alter this line.
 * Note about functionparse.php: the function reference is generated
 * from the function comments contained in this file. This is done to
 * ensure the reference is always up to date. The parser looks for
 * comments that contain the declaration on the first line. The
 * declarations should always consist of a return type, a function
 * name and a set of parentheses.
 */

/*
 * void mwin(string str)
 * 
 * Show the message window.
 */
void mwin(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;

	if (params.params != 1)
	{
		throw CError(_T("MWin() requires one parameter."));
	}

	if (g_mwin.nextLine == 0) 
	{
		g_mwin.cnvText->ClearScreen(g_mwin.color);
		g_mwin.visible = true;
	}

	// Write the text.
	g_mwin.cnvText->DrawText(0, g_mwin.nextLine, spliceVariables(params.prg, params[0].getLit()), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	g_mwin.nextLine += g_fontSize;

	CONST_POS i = params.prg->getPos() + 1;
	for (; i != params.prg->getEnd(); ++i)
	{
		if (i->udt & UDT_LINE)
		{
			if ((i->udt & UDT_FUNC) && (i->func == mwin))
			{
				// The next line is also a call to mwin(),
				// so don't bother drawing yet.
				return;
			}
			break;
		}
	}

	// Draw the window.
	renderRpgCodeScreen();
}

/*
 * string wait([string &ret])
 * 
 * Wait for a key to be pressed, and return the key that was.
 */
void wait(CALL_DATA &params)
{
	params.ret().udt = UDT_LIT;
	params.ret().lit = waitForKey(true);
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * void mwinCls()
 * 
 * Clear and hide the message window.
 */
void mwinCls(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;
	g_mwin.hide();
	renderRpgCodeScreen();
}

/*
 * void send(string file, int x, int y, [int z = 1])
 * 
 * Send the player to a new board.
 */
void send(CALL_DATA &params)
{
	extern STRING g_projectPath;
	extern LPBOARD g_pBoard;
	extern CPlayer *g_pSelectedPlayer;

	unsigned int layer = 1;
	if (params.params != 3)
	{
		if (params.params != 4)
		{
			throw CError(_T("Send() requires three or four parameters."));
		}
		layer = params[3].getNum();
	}

	g_pBoard->open(g_projectPath + BRD_PATH + params[0].getLit());

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	coords::tileToPixel(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);

	if (x < 1 || x > g_pBoard->pxWidth())
	{
		CProgram::debugger(_T("Send() location exceeds target board x-dimensions."));
		x = 32;
	}
	if (y < 1 || y > g_pBoard->pxHeight())
	{
		CProgram::debugger(_T("Send() location exceeds target board y-dimensions."));
		y = 32;
	}

	g_pSelectedPlayer->setPosition(x, y, layer, PX_ABSOLUTE);
	g_pSelectedPlayer->send();
}

/*
 * void text(double x, double y, string str, [canvas cnv])
 *
 * Displays text on the screen.
 */
void text(CALL_DATA &params)
{
	const int count = params.params;
	if (count != 3 && count != 4)
	{
		throw CError(_T("Text() requires 3 or 4 parameters!"));
	}
	CCanvas *cnv = (count == 3) ? g_cnvRpgCode : g_canvases.cast(int(params[3].getNum()));
	if (cnv)
	{
		cnv->DrawText(params[0].getNum() * g_fontSize - g_fontSize, params[1].getNum() * g_fontSize - g_fontSize, spliceVariables(params.prg, params[2].getLit()), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	}
	if (count == 3)
	{
		g_textX = params[0].getNum();
		g_textY = params[1].getNum();
		renderRpgCodeScreen();
	}
}

/*
 * void pixelText(int x, int y, string str, [canvas cnv])
 *
 * Displays text on the screen using pixel coordinates.
 */
void pixelText(CALL_DATA &params)
{
	const int count = params.params;
	if (count != 3 && count != 4)
	{
		throw CError(_T("PixelText() requires 3 or 4 parameters!"));
	}
	CCanvas *cnv = (count == 3) ? g_cnvRpgCode : g_canvases.cast(int(params[3].getNum()));
	if (cnv)
	{
		cnv->DrawText(int(params[0].getNum()), int(params[1].getNum()), spliceVariables(params.prg, params[2].getLit()), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	}
	if (count == 3)
	{
		renderRpgCodeScreen();
	}
}

/*
 * void branch(label lbl)
 * 
 * Jump to a label.
 */
void branch(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Branch() requires one parameter."));
	}
	const STRING label = (params[0].udt & UDT_LABEL) ? params[0].lit : params[0].getLit();
	if (!params.prg->jump(label))
	{
		throw CError(_T("Branch(): could not find label \"") + label + _T("\"."));
	}
}

/*
 * void setErrorHandler(label lbl)
 *
 * Set an error handler for the current function. This <i>does
 * not</i> propagate up the call stack! Refer to the language features
 * section of the manual for more information.
 */
void setErrorHandler(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("SetErrorHandler() requires one parameter."));
	}
	const STRING label = (params[0].udt & UDT_LABEL) ? params[0].lit : params[0].getLit();
	params.prg->setErrorHandler(label);
}

/*
 * void setResumeNextHandler()
 *
 * Cause errors in the current function to be silently ignored.
 * This <i>does not</i> propagate up the call stack!
 */
void setResumeNextHandler(CALL_DATA &params)
{
	if (params.params != 0)
	{
		throw CError("SetResumeNextHandler() requires zero parameters.");
	}
	params.prg->setErrorHandler(" "); // Refer to CProgram::handleError().
}

/*
 * void change(string program)
 * 
 * Change this program so that next time it is triggered, a
 * different program runs instead. Change() is active only
 * while the player remains on the board (i.e., leaving
 * the board causes programs to return to normal).
 */
void change(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 1)
	{
		throw CError(_T("Change() requires one parameter."));
	}
	LPBRD_PROGRAM p = params.prg->getBoardLocation();
	if (g_pBoard->hasProgram(p))
	{
		p->fileName = params[0].getLit();
	}
}

/*
 * void clear([canvas cnv])
 * 
 * Clear a surface. clear() blanks the screen.
 * clear(cnv) blanks the canvas whose handle is 'cnv'.
 */
void clear(CALL_DATA &params)
{
	if (params.params != 0)
	{
		CCanvas *cnv = g_canvases.cast((int)params[0].getNum());
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
 * void done()
 * 
 * End the program.
 */
void done(CALL_DATA &params)
{
	params.prg->end();
}

/*
 * void windows()
 * 
 * Exit to windows.
 */
void windows(CALL_DATA &params)
{
	PostQuitMessage(0);
}

/*
 * void empty()
 * 
 * Clear all globals.
 */
void empty(CALL_DATA &params)
{
	params.prg->freeGlobals();
}

/*
 * void end()
 * 
 * End the program.
 */
void end(CALL_DATA &params)
{
	params.prg->end();
}

/*
 * void font(string font)
 * 
 * Load a true type font. TK2 fonts are not supported. 
 */
void font(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Font() requires one parameter."));
	}
	g_fontFace = params[0].getLit();
}

/*
 * void fontSize(int size)
 * 
 * Set the font size.
 */
void fontSize(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("FontSize() requires one parameter."));
	}
	g_fontSize = int(params[0].getNum());
}

/*
 * void fight(int skill, string background)
 * 
 * Start a skill level fight.
 */
void fight(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("Fight() requires two parameters."));
	}
	skillFight(int(params[0].getNum()), params[1].getLit());
}

/*
 * string get([string &ret])
 * 
 * Get a key from the queue.
 */
void get(CALL_DATA &params)
{
	params.ret().udt = UDT_LIT;
	extern std::vector<char> g_keys;
	if (g_keys.size() == 0)
	{
		params.ret().lit = _T("");
		return;
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	const STRING toRet = getName(chr, true);
	if (params.params == 1)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_LIT;
		var->lit = toRet;
	}
	params.ret().lit = toRet;
}

/*
 * void gone()
 * 
 * Remove the currently running program from the board
 * until the board has been left.
 */
void gone(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 0)
	{
		throw CError(_T("Gone() requires zero parameters."));
	}

	LPBRD_PROGRAM p = params.prg->getBoardLocation();
	std::vector<LPBRD_PROGRAM>::iterator i = g_pBoard->programs.begin();
	for (; i != g_pBoard->programs.end(); ++i)
	{
		if ((*i) == p)
		{
			g_pBoard->programs.erase(i);
			delete p;
			break;
		}
	}
}

/*
 * void viewbrd(string filename [, int x, int y [, canvas cnv]])
 * 
 * Draw a board to the screen or to a canvas,
 * starting at co-ordinates topX, topY.
 */
void viewbrd(CALL_DATA &params)
{
	extern CAllocationHeap<BOARD> g_boards;
	extern STRING g_projectPath;
	CCanvas *pCnv = g_cnvRpgCode;

	if (params.params == 4)
	{
		pCnv = g_canvases.cast(int(params[3].getNum()));
	}
	if (!pCnv) throw CError(_T("ViewBrd(): canvas not found."));

	LPBOARD pBoard = NULL;
	if (params.params > 0)
	{
		pBoard = g_boards.allocate();
		if (!pBoard->open(g_projectPath + BRD_PATH + params[0].getLit()))
		{
			g_boards.free(pBoard);
			throw CError(_T("ViewBrd(): unable to open board."));
		}
	}
	else throw CError(_T("ViewBrd(): requires at least one parameter."));

	int x = 0, y = 0;
	if (params.params > 2)
	{
		x = params[1].getNum();
		y = params[2].getNum();
		coords::tileToPixel(x, y, pBoard->coordType, false, pBoard->sizeX);
		if (pBoard->coordType == TILE_NORMAL)
		{
			// coords::tileToPixel(...false.) returns at top-left for 2D.
			x += 32;
			y += 32;
		}
	}

	pCnv->ClearScreen(pBoard->bkgColor);
	pBoard->render(
		pCnv, 
		0, 0, 
		1, pBoard->sizeL,
		x, y, 
		pCnv->GetWidth(), 
		pCnv->GetHeight()
	); 
	g_boards.free(pBoard);

	if (params.params != 4) renderRpgCodeScreen();
}

/*
 * void bold(bool enable)
 * 
 * Toggle emboldening of text.
 */
void bold(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Bold() requires one parameter."));
	}
	g_bold = params[0].getBool();
}

/*
 * void italics(bool enable)
 * 
 * Toggle italicizing of text.
 */
void italics(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Italics() requires one parameter."));
	}
	g_italic = params[0].getBool();
}

/*
 * void underline(bool enable)
 * 
 * Toggle underlining of text.
 */
void underline(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Underline() requires one parameter."));
	}
	g_underline = params[0].getBool();
}

/*
 * void winGraphic(string file)
 * 
 * Set the message window background image.
 */
void winGraphic(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;
	extern STRING g_projectPath;

	if (params.params != 1)
	{
		throw CError(_T("WinGraphic() requires one parameter."));
	}

	g_mwin.render(g_projectPath + BMP_PATH + params[0].getLit(), 0);
}

/*
 * void winColor(int dos)
 * 
 * Set the message window's colour using a DOS code.
 */
void winColor(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;

	if (params.params != 1)
	{
		throw CError(_T("WinColor() requires one parameter."));
	}

	int color = int(params[0].getNum());
	if (color < 0) color = 0;
	else if (color > 255) color = 255;
	color = CTile::getDOSColor(color);

	g_mwin.render(_T(""), color);
}

/*
 * void winColorRgb(int r, int g, int b)
 * 
 * Set the message window's colour.
 */
void winColorRgb(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;

	if (params.params != 3)
	{
		throw CError(_T("WinColorRGB() requires three parameters."));
	}

	g_mwin.render(_T(""), RGB(int(params[0].getNum()), int(params[1].getNum()), int(params[2].getNum())));
}

/*
 * void color(int dos)
 * 
 * Change to a DOS colour.
 */
void color(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Color() requires one parameter."));
	}
	int color = params[0].getNum();
	if (color < 0) color = 0;
	else if (color > 255) color = 255;
	g_color = CTile::getDOSColor(color);
}

/*
 * void colorRgb(int r, int g, int b)
 * 
 * Change the active colour to an RGB value.
 */
void colorRgb(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("ColorRGB() requires three parameters."));
	}
	g_color = RGB(int(params[0].getNum()), int(params[1].getNum()), int(params[2].getNum()));
}

/*
 * void move(int x, int y, [int z = 1])
 * 
 * Move this board program to a new location on the board. The
 * effect lasts until the board has been left.
 */
void move(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	int z = 1;
	if (params.params == 3)
	{
		z = int(params[2].getNum());
	}
	else if (params.params != 2)
	{
		throw CError(_T("Move() requires two or three parameters."));
	}
	
	int x = int(params[0].getNum()), y = int(params[1].getNum());
	coords::tileToPixel(x, y, g_pBoard->coordType, false, g_pBoard->sizeX);
	if (g_pBoard->isIsometric() && !(g_pBoard->coordType & PX_ABSOLUTE))
	{
		// coords::tileToPixel() returns the centrepoint of isometric tiles.
		// If PX_ABSOLUTE is not set, assume programs are tile-based and
		// require an additional offset.
		// These programs start on the left of the diamond (see board.cpp)
		x -= 32;
	}

	LPBRD_PROGRAM p = params.prg->getBoardLocation();
	if (g_pBoard->hasProgram(p))
	{
		// Move to a new location (x,y location for first point).
		p->vBase.move(x, y);
		p->layer = z;
	}
}

/*
 * void prg(string program. int x, int y, [int z = 1])
 * 
 * Move a program on the current board to a new location. This
 * stays in effect until the board is left.
 */
void prg(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	int z = 1;
	if (params.params == 4)
	{
		z = int(params[3].getNum());
	}
	else if (params.params != 3)
	{
		throw CError(_T("Prg() requires three or four parameters."));
	}
	int x = int(params[1].getNum()), y = int(params[2].getNum());
	coords::tileToPixel(x, y, g_pBoard->coordType, false, g_pBoard->sizeX);
	if (g_pBoard->isIsometric() && !(g_pBoard->coordType & PX_ABSOLUTE))
	{
		// coords::tileToPixel() returns the centrepoint of isometric tiles.
		// If PX_ABSOLUTE is not set, assume programs are tile-based and
		// require an additional offset.
		// These programs start on the left of the diamond (see board.cpp)
		x -= 32;
	}

	std::vector<LPBRD_PROGRAM>::iterator i = g_pBoard->programs.begin();
	for (; i != g_pBoard->programs.end(); ++i)
	{
		if ((*i) && (_tcsicmp((*i)->fileName.c_str(), params[0].getLit().c_str()) == 0))
		{
			(*i)->vBase.move(x, y);
			(*i)->layer = z;
			break;
		}
	}
}

/*
 * string prompt(string question, [string &ret])
 * 
 * Ask the player a question and return the result.
 */
void prompt(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Prompt() requires one or two parameters."));
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = prompt(params[0].getLit());
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void put(int x, int y, string tile)
 * 
 * Puts a tile at the specified location on the board. The tile persists
 * only until the program ends. Use LayerPut() to place a tile for the
 * duration the user is on the board. 
 * x and y are specified in tile coordinates.
 */
void put(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern STRING g_projectPath;
	extern AMBIENT_LEVEL g_ambientLevel;

	if (params.params != 3)
	{
		throw CError(_T("Put() requires three parameters."));
	}

	CTile::drawByBoardCoord(
		g_projectPath + TILE_PATH + params[2].getLit(),
		int(params[0].getNum()), 
		int(params[1].getNum()),
		g_ambientLevel.rgb.r, g_ambientLevel.rgb.g, g_ambientLevel.rgb.b, 
		g_cnvRpgCode,
		TM_NONE,
		0, 0,
		g_pBoard->coordType,
		1		// Width of tbm (or other) in tiles for ISO_ROTATED.
	);

	renderRpgCodeScreen();
}

/*
 * void reset()
 * 
 * Reset the game.
 */
void reset(CALL_DATA &params)
{
	extern void reset();
	reset();
}

/*
 * void over()
 * 
 * Displays a game over message and resets the game. Because
 * you can (and should) set a game over program, this function
 * is pointless.
 */
void over(CALL_DATA &params)
{
	extern MAIN_FILE g_mainFile;
	extern STRING g_projectPath;
	extern void reset();

	if (g_mainFile.gameOverPrg.empty())
	{
		messageBox(_T("Game over."));
		reset();
	}
	else
	{
		params.prg->end();
		CProgram(g_projectPath + PRG_PATH + g_mainFile.gameOverPrg).run();
	}
}

/*
 * void run(string program)
 * 
 * Transfer control to a different program.
 */
void run(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 1)
	{
		throw CError(_T("Run() requires one data element."));
	}
	params.prg->end();
	CProgram(g_projectPath + PRG_PATH + params[0].getLit()).run();
}

/*
 * void sound()
 * 
 * Obsolete.
 */
void sound(CALL_DATA &params)
{
	throw CError(_T("Sound() is obsolete. Please use TK3's media functions."));
}

/*
 * void win()
 * 
 * Obsolete.
 */
void win(CALL_DATA &params)
{
	throw CError(_T("Win() is obsolete."));
}

/*
 * void hp(string handle, int value)
 * 
 * Set a fighter's hp.
 */
void hp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("HP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int max = p->maxHealth();
		const int hp = int(params[1].getNum());
		p->health((hp <= max) ? hp : max);
	}
}

/*
 * void giveHp(string handle, int add)
 * 
 * Increase a fighter's current hp.
 */
void giveHp(CALL_DATA &params)
{
	extern IPlugin *g_pFightPlugin;

	if (params.params != 2)
	{
		throw CError(_T("GiveHP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int given = int(params[1].getNum());
		const int hp = p->health() + given;
		const int max = p->maxHealth();
		p->health((hp <= max) ? ((hp > 0) ? hp : 0) : max);
		if (isFighting())
		{
			// Get the fighter's indices.
			int party, idx;
			getFighterIndices(p, party, idx);

			if ((party != -1) && (idx != -1))
			{
				// Inform the fight plugin that health was modified.
				g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, -given, 0, _T(""), INFORM_REMOVE_HP);
			}
		}
	}
}

/*
 * int getHp(string handle, [int &ret])
 * 
 * Get a fighter's hp.
 */
void getHp(CALL_DATA &params)
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
		throw CError(_T("GetHP() requires one or two parameters."));
	}
}

/*
 * void maxHp(string handle, int value)
 * 
 * Set a fighter's max hp.
 */
void maxHp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("MaxHP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->maxHealth(params[1].getNum());
	}
}

/*
 * int getMaxHp(string handle, [int &ret])
 * 
 * Get a fighter's max hp.
 */
void getMaxHp(CALL_DATA &params)
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
		throw CError(_T("GetMaxHP() requires one or two parameters."));
	}
}

/*
 * void smp(string handle, int value)
 * 
 * Set a fighter's smp.
 */
void smp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("SMP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int max = int(p->maxSmp());
		const int mana = int(params[1].getNum());
		p->smp((mana <= max) ? mana : max);
	}
}

/*
 * void giveSmp(string handle, int value)
 * 
 * Increase a fighter's smp.
 */
void giveSmp(CALL_DATA &params)
{
	extern IPlugin *g_pFightPlugin;

	if (params.params != 2)
	{
		throw CError(_T("GiveSMP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		const int given = int(params[1].getNum());
		const int smp = p->smp() + given;
		const int max = p->maxSmp();
		p->smp((smp <= max) ? ((smp > 0) ? smp : 0) : max);
		if (isFighting())
		{
			// Get the fighter's indices.
			int party = -1, idx = -1;
			getFighterIndices(p, party, idx);

			if ((party != -1) && (idx != -1))
			{
				// Inform the fight plugin that health was modified.
				g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, 0, -given, _T(""), INFORM_REMOVE_SMP);
			}
		}
	}
}

/*
 * int getSmp(string handle, [int &ret])
 * 
 * Get a fighter's smp.
 */
void getSmp(CALL_DATA &params)
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
		throw CError(_T("GetSMP() requires one or two parameters."));
	}
}

/*
 * void maxSmp(string handle, int value)
 * 
 * Set a fighter's max smp.
 */
void maxSmp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("MaxSMP() requires two parameters."));
	}
	IFighter *p = getFighter(params[0].getLit());
	if (p)
	{
		p->maxSmp(params[1].getNum());
	}
}

/*
 * int getMaxSmp(string handle, [int &ret])
 * 
 * Get a fighter's max smp.
 */
void getMaxSmp(CALL_DATA &params)
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
		throw CError(_T("GetMaxSMP() requires one or two parameters."));
	}
}

/*
 * void start(string file)
 * 
 * Open a file with the shell.
 *
 * There is unfortunately no default directory for this
 * function and assuming one will only break backward
 * compatibility in some obscure manner.
 *
 * Note also that previous incarnations prevented the
 * launching of executables and shortcuts, but this is
 * a nonsensical security measure when plugins no longer
 * display a silly warning box, and this function can be
 * trivially modified by someone who intends to be malicious.
 */
void start(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Start() requires one parameter."));
	}
	ShellExecute(NULL, _T("open"), params[0].getLit().c_str(), NULL, NULL, 0);
}

/*
 * void giveItem(string itm)
 * 
 * Add an item to the inventory.
 */
void giveItem(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("GiveItem() requires one parameter."));
	}
	extern STRING g_projectPath;
	g_inv.give(g_projectPath + ITM_PATH + params[0].getLit());
}

/*
 * void takeItem(string itm)
 * 
 * Remove an item from the inventory.
 */
void takeItem(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("TakeItem() requires one parameter."));
	}
	extern STRING g_projectPath;
	g_inv.take(g_projectPath + ITM_PATH + params[0].getLit());
}

/*
 * void wav(string file)
 * 
 * Play a wave file (e.g. a sound effect).
 */
void wav(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Wav() requires one parameter."));
	}
	// Do not pass \Media path.
	CAudioSegment::playSoundEffect(params[0].getLit(), false);
}

/*
 * void wavstop()
 * 
 * Stop the current sound effect.
 */
void wavstop(CALL_DATA &params)
{
	CAudioSegment::stopSoundEffect();
}

/*
 * void mp3pause()
 * 
 * Play a sound effect and pause the engine until it finishes.
 */
void mp3pause(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Mp3Pause() requires one parameter."));
	}
	// Do not pass \Media path.
	CAudioSegment::playSoundEffect(params[0].getLit(), true);
}

/*
 * void delay(double time)
 * 
 * Delay for a certain number of seconds.
 */
void delay(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Delay() requires one data element."));
	}
	Sleep(DWORD(params[0].getNum() * 1000.0));
}

/*
 * int random(int max, [int &ret])
 * 
 * Generate a random number from one to the supplied maximum, inclusive.
 */
void random(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Random() requires one or two parameters."));
	}
	const int max = int(params[0].getNum());
	params.ret().udt = UDT_NUM;
	params.ret().num = (max ? (rand() % max) + 1 : 1);
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void tileType(int x, int y, string type, [int z = 1])
 * 
 * Change a tile's type. Valid types for the string parameter
 * are "NORMAL", "SOLID", "UNDER", "NS", "EW", "STAIRS#".
 * Do not use when using vectors - use vector tools instead.
 */
void tileType(CALL_DATA &params)
{
	/* Better solution: regenerate vectors from tagBoard.tiletype */
	// See movement.h for old tiletype defines.

	extern LPBOARD g_pBoard;

	if (params.params != 3 && params.params != 4)
	{
		throw CError(_T("TileType() requires three or four parameters."));
	}

	const int x = int(params[0].getNum()), 
			  y = int(params[1].getNum()),
			  z = (params.params == 4 ? int(params[3].getNum()) : 1);

	const STRING type = params[2].getLit();
	int tile = NORMAL;

	// "tile" to be recognised in tagBoard::vectorize()
	if (_ftcsicmp(type.c_str(), _T("SOLID")) == 0) tile = SOLID;
	else if (_ftcsicmp(type.c_str(), _T("UNDER")) == 0) tile = UNDER;
	else if (_ftcsicmp(type.substr(0, 6).c_str(), _T("STAIRS")) == 0)
	{
		tile = 10 + atoi(type.substr(6).c_str());
	}
	else if (_ftcsicmp(type.c_str(), _T("NS")) == 0) tile = NORTH_SOUTH;
	else if (_ftcsicmp(type.c_str(), _T("EW")) == 0) tile = EAST_WEST;

	// Enter the tiletype into the table.
	try
	{
		g_pBoard->tiletype[z][y][x] = tile;
	}
	catch (...)
	{
		throw CError(_T("TileType(): tile co-ordinates out of bounds."));
	}

	// Delete the vectors of this layer and re-generate.
	g_pBoard->freeVectors(z);
	g_pBoard->vectorize(z);
}

/*
 * void mediaPlay(string file)
 * 
 * Play the specified file as the background music.
 */
void mediaPlay(CALL_DATA &params)
{
	extern CAudioSegment *g_bkgMusic;

	if (params.params != 1)
	{
		throw CError(_T("MediaPlay() requires one parameter."));
	}
	g_bkgMusic->open(params[0].getLit());
	g_bkgMusic->play(true);
}

/*
 * void mediaStop()
 * 
 * Stop the background music.
 */
void mediaStop(CALL_DATA &params)
{
	extern CAudioSegment *g_bkgMusic;
	g_bkgMusic->stop();
}

/*
 * void goDos(string command)
 * 
 * Obsolete.
 */
void goDos(CALL_DATA &params)
{
	throw CError(_T("GoDos() is obsolete."));
}

/*
 * void setPixel(int x, int y, [canvas cnv])
 * 
 * Set a pixel in the current colour.
 */
void setPixel(CALL_DATA &params)
{
	if (params.params == 2)
	{
		g_cnvRpgCode->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 3)
	{
		CCanvas *cnv = g_canvases.cast((int)params[2].getNum());
		if (cnv)
		{
			cnv->SetPixel(params[0].getNum(), params[1].getNum(), g_color);
		}
	}
	else
	{
		throw CError(_T("SetPixel() requires two or three parameters."));
	}
}

/*
 * void drawLine(int x1, int y1, int x2, int y2, [canvas cnv])
 * 
 * Draw a line.
 */
void drawLine(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawLine(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CCanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawLine(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError(_T("DrawLine() requires four or five parameters."));
	}
}

/*
 * void drawRect(int x1, int y1, int x2, int y2, [canvas cnv])
 * 
 * Draw a rectangle.
 */
void drawRect(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CCanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError(_T("DrawRect() requires four or five parameters."));
	}
}

/*
 * void fillRect(int x1, int y1, int x2, int y2, [canvas cnv])
 * 
 * Draw a filled rectangle.
 */
void fillRect(CALL_DATA &params)
{
	if (params.params == 4)
	{
		g_cnvRpgCode->DrawFilledRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		renderRpgCodeScreen();
	}
	else if (params.params == 5)
	{
		CCanvas *cnv = g_canvases.cast((int)params[4].getNum());
		if (cnv)
		{
			cnv->DrawFilledRect(params[0].getNum(), params[1].getNum(), params[2].getNum(), params[3].getNum(), g_color);
		}
	}
	else
	{
		throw CError(_T("FillRect() requires four or five parameters."));
	}
}

/*
 * void debug(bool enable)
 * 
 * Toggle whether to show debug messages.
 */
void debug(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("Debug() requires one parameter.");
	}
	CProgram::setDebugLevel(params[0].getBool() ? E_WARNING : E_DISABLED);
}

/*
 * double castNum(variant x, [double &ret])
 * 
 * Cast the specified value to a number (double). There is really no need
 * to do this ever. RPGCode by itself will cast values passed to functions
 * to the correct types as required.
 */
void castNum(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = params[0].getNum();
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->num = params[0].getNum();
		var->udt = UDT_NUM;
	}
	else
	{
		throw CError(_T("CastNum() requires one or two parameters."));
	}
}

/*
 * string castLit(variant x, [string &ret])
 * 
 * Cast the specified value to a string. There is really no need
 * to do this ever. RPGCode by itself will cast values passed to
 * functions to the correct types as required.
 */
void castLit(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_LIT;
		params.ret().lit = params[0].getLit();
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->lit = params[0].getLit();
		var->udt = UDT_LIT;
	}
	else
	{
		throw CError(_T("CastLit() requires one or two parameters."));
	}
}

/*
 * int castInt(variant x, [int &ret])
 * 
 * Cast the specified value to an integer (i.e., a number in the sequence
 * ...-2, -1, 0, 1, 2...). This is useful for removing fractional parts of
 * numbers. Note that this function does not round.
 */
void castInt(CALL_DATA &params)
{
	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(int(params[0].getNum()));
	}
	else if (params.params == 2)
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->num = double(int(params[0].getNum()));
		var->udt = UDT_NUM;
	}
	else
	{
		throw CError(_T("CastInt() requires one or two parameters."));
	}
}

/*
 * bool pixelMovement([bool pixelMovement [, bool pixelPush]])
 * 
 * Toggles pixel movement and push() et al. in pixels.
 * Returns whether pixel movement is being used.
 * pixelPush is ineffective for tile movement.
 */
void pixelmovement(CALL_DATA &params)
{
	extern MAIN_FILE g_mainFile;

	if ((params.params == 1) || (params.params == 2))
	{
		if (params.params == 2)
		{
			g_mainFile.pixelMovement = params[1].getBool() ? MF_PUSH_PIXEL : MF_MOVE_PIXEL;
		}

		if (params[0].getBool())
		{
			CSprite::m_bPxMovement = true;
		}
		else
		{
			g_mainFile.pixelMovement = MF_MOVE_TILE;
			CSprite::m_bPxMovement = false;
		}
	}

	// Return the state.
	params.ret().udt = UDT_NUM;
	params.ret().num = double(CSprite::m_bPxMovement);
}

/*
 * string pathfind (int x1, int y1, int x2, int y2, string &ret [, int layer])
 *
 * Construct a directional string of the shortest tiled path from
 * one location to the other.
 */
void pathfind(CALL_DATA &params)
{
	extern CPlayer *g_pSelectedPlayer;
	extern LPBOARD g_pBoard;

	if (params.params < 4 || params.params > 6)
	{
		throw CError(_T("PathFind() requires four, five or six parameters.")); 
	}

	const int layer = (params.params == 6) ?
					  int(params[5].getNum()) :
					  g_pSelectedPlayer->getPosition().l;

	int x1 = int(params[0].getNum()), y1 = int(params[1].getNum()),
		x2 = int(params[2].getNum()), y2 = int(params[3].getNum());

	// Transform the input co-ordinates based on the board co-ordinate system.
	coords::tileToPixel(x1, y1, g_pBoard->coordType, true, g_pBoard->sizeX);
	coords::tileToPixel(x2, y2, g_pBoard->coordType, true, g_pBoard->sizeX);

	// Parameters. r is unneeded for tile pathfinding.
	const DB_POINT start = {x1, y1}, goal = {x2, y2};
	STRING s;

	// Pre C++, PathFind() was implemented axially only.
	CPathFind *path = NULL;

	// Create a dummy sprite to hold the default vectors (not ideal...).
	CSprite sprite(false);
	sprite.createVectors();
	CPathFind::pathFind(&path, start, goal, layer, PF_AXIAL, &sprite, PF_QUIT_BLOCKED); 
	std::vector<MV_ENUM> p = path->directionalPath();

	// path is allocated in CPathFind::pathFind().
	delete path;

	for (std::vector<MV_ENUM>::reverse_iterator i = p.rbegin(); i != p.rend(); ++i)
	{
		switch (*i)
		{
			case MV_N: { s += _T("N"); } break;
			case MV_S: { s += _T("S"); } break;
			case MV_E: { s += _T("E"); } break;
			case MV_W: { s += _T("W"); } break;
			case MV_NE: { s += _T("NE"); } break;
			case MV_NW: { s += _T("NW"); } break;
			case MV_SE: { s += _T("SE"); } break;
			case MV_SW: { s += _T("SW"); }
		}
		if (i != p.rend() - 1) s += _T(",");
	}
	
	params.ret().udt = UDT_LIT;
	params.ret().lit = s;

	if (params.params >= 5)
	{
		*params.prg->getVar(params[4].lit) = params.ret();
	}
}

/*
 * void playerstep(variant handle, int x, int y [, int flags])
 * 
 * Causes the player to take one step in the direction of x, y
 * following a route determined by pathFind.
 *
 * Possible flags<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void playerstep(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 3 && params.params != 4)
	{
		throw CError(_T("PlayerStep() requires three or four parameters."));
	}

	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerStep(): player not found"));

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	const unsigned int flags = (params.params > 3 ? (unsigned int)params[3].getNum() : 0);
	coords::tileToPixel(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);

	PF_PATH path = p->pathFind(x, y, PF_AXIAL, 0);
	if (!path.empty())
	{
		// Prune to the last element.
		path.front() = path.back();		
		path.resize(1);

		// Initiate movement by program type.
		p->setQueuedPath(path, flags & tkMV_CLEAR_QUEUE);
		p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
	}
}

/*
 * void itemstep(variant handle, int x, int y [, int flags])
 * 
 * Causes the item to take one step in the direction of x, y
 * following a route determined by pathFind.
 *
 * Possible flags<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void itemstep(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 3 && params.params != 4)
	{
		throw CError(_T("ItemStep() requires three or four parameters."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemStep(): item not found"));

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	const unsigned int flags = (params.params > 3 ? (unsigned int)params[3].getNum() : 0);
	coords::tileToPixel(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);

	PF_PATH path = p->pathFind(x, y, PF_AXIAL, 0);
	if (!path.empty())
	{
		// Prune to the last element.
		path.front() = path.back();		
		path.resize(1);

		// Initiate movement by program type.
		p->setQueuedPath(path, flags & tkMV_CLEAR_QUEUE);
		p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
	}
}

/*
 * void push(string direction [, variant handle [, int flags]])
 * 
 * Push the player with the specified handle, or the default player
 * if no handle is specified, along the given directions. The direction
 * should be a comma delimited, but if it is not, it will be delimited
 * for backward compatibility. These styles are accepted, and can be
 * mixed even within the same directonal string:
 *
 * <ul><li>N, S, E, W, NE, NW, SE, SW</li>
 * <li>NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST</li>
 * <li>1, 2, 3, 4, 5, 6, 7, 8</li></ul>
 *
 * Possible flags<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void push(CALL_DATA &params)
{
	extern CPlayer *g_pSelectedPlayer;

	if ((params.params < 1) || (params.params > 3))
	{
		throw CError(_T("Push() requires one, two or three parameters."));
	}

	CSprite *p = (params.params > 1 ? getPlayerPointer(params[1]) : g_pSelectedPlayer);
	if (!p) throw CError(_T("Push(): player not found"));

	// Backwards compatibility.
	STRING str = formatDirectionString(params[0].getLit());

	const unsigned int flags = (params.params > 2 ? (unsigned int)params[2].getNum() : 0);

	// Parse and set queued movements.
	p->parseQueuedMovements(str, flags & tkMV_CLEAR_QUEUE);
	// Initiate movement by program type.
	p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
}

/*
 * void pushItem(variant item, string direction [, int flags])
 * 
 * The first parameter accepts either a string that can be either
 * "target" or "source" direction or the number of an item. The
 * syntax of the directional string is the same as for [[push()]].
 *
 * Possible flags<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void pushItem(CALL_DATA &params)
{
	extern CPlayer *g_pSelectedPlayer;

	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("PushItem() requires two or three parameters."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("PushItem(): item not found"));

	// Backwards compatibility.
	STRING str = formatDirectionString(params[1].getLit());

	const unsigned int flags = (params.params > 2 ? (unsigned int)params[2].getNum() : 0);

	// Parse and set queued movements.
	p->parseQueuedMovements(str, flags & tkMV_CLEAR_QUEUE);
	// Initiate movement by program type.
	p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
}

/*
 * void wander(variant target, [int restrict = 0])
 * 
 * The first parameter accepts either a string that can be either
 * "target" or "source" or the number of an item. The selected item
 * will take a step in a random direction, or as restricted by the
 * optional parameter. The allowed values for said parameter are:
 *
 * <ul><li>0 - only north, south, east, and west on normal boards, only
 *     diagonals on isometric boards (default)</li>
 * <li>1 - only north, south, east, and west</li>
 * <li>2 - only diagonals</li>
 * <li>3 - all directions</li></ul>
 */
void wander(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern const double g_directions[2][9][2];

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Wander() requires one or two parameters."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("Wander(): item not found"));
	
	// Break early if the item is already moving.
	if (!p->getPosition().path.empty()) return;

	const int isIso = int(g_pBoard->isIsometric());

	int restrict = 0;
	if (params.params == 2)
	{
		restrict = int(params[1].getNum());
		if (restrict < 0) restrict = 0;
		else if (restrict > 3) restrict = 3;
	}

	if (restrict-- == 0)
	{
		restrict = isIso;
	}

	int direction = 0, heuristic = PF_AXIAL;

	if (restrict == 0)
	{
		direction = (rand() % 4) * 2 + 1;
	}
	else if (restrict == 1)
	{
		direction = (rand() % 4) * 2 + 2;
	}
	else
	{
		direction = rand() % 8 + 1;
		heuristic = PF_DIAGONAL;
	}
		
	DB_POINT d;
	p->getDestination(d);
	const DB_POINT pt = {d.x + g_directions[isIso][direction][0] * 32, d.y + g_directions[isIso][direction][1] * 32};
	
	if (pt.x > 0 && pt.x <= g_pBoard->pxWidth() && pt.y > 0 && pt.y < g_pBoard->pxHeight())
	{
		// Pathfind to ensure tile collision checks.
		PF_PATH path = p->pathFind(pt.x, pt.y, heuristic, PF_QUIT_BLOCKED);
		if (!path.empty())
		{
			p->setQueuedPath(path, true);
			// Initiate movement by program type.
			p->doMovement(params.prg, false);
		}
	}
}

/*
 * void addPlayer(string file)
 * 
 * Add a player to the party.
 */
void addPlayer(CALL_DATA &params)
{
	extern std::vector<CPlayer *> g_players;
	extern STRING g_projectPath;
	extern CPlayer *g_pSelectedPlayer;

	if (params.params != 1)
	{
		throw CError(_T("AddPlayer() requires one parameter."));
	}

	const STRING file = g_projectPath + TEM_PATH + params[0].getLit();

	if (CFile::fileExists(file))
	{
		CPlayer *p = new CPlayer(file, false, true);
		g_players.push_back(p);

		// Allow the initial character to be loaded via the start progam.
		if (!g_pSelectedPlayer) g_pSelectedPlayer = p;
	}
}

/*
 * void putplayer(string handle, int x, int y, int layer)
 * 
 * Place the player on the board at the given location.
 */
void putplayer(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern RECT g_screen;
	extern ZO_VECTOR g_sprites;
	extern CPlayer *g_pSelectedPlayer;

	if (params.params != 4)
	{
		throw CError(_T("PutPlayer() requires four parameters."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PutPlayer(): player not found"));

	p->setActive(true);
    p->setPosition(int(params[1].getNum()), 
		int(params[2].getNum()), 
		int(params[3].getNum()), 
		g_pBoard->coordType);

	// Insert the pointer into the z-ordered vector.
	g_sprites.zOrder();
    
	if (p == g_pSelectedPlayer) p->alignBoard(g_screen, true);
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void eraseplayer(string handle)
 *
 * Erase a party player from the screen.
 */
void eraseplayer(CALL_DATA &params)
{
	extern ZO_VECTOR g_sprites;

	if (params.params != 1)
	{
		throw CError(_T("ErasePlayer() requires one parameter."));
	}

	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("ErasePlayer(): player not found"));

	// Remove the player from the z-ordered vector.
	g_sprites.remove(p);
	p->setActive(false);

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void destroyPlayer(string handle)
 * 
 * Permanently remove a player from the party.
 */
void destroyplayer(CALL_DATA &params)
{
	extern std::vector<CPlayer *> g_players;
	extern ZO_VECTOR g_sprites;
	extern CPlayer *g_pSelectedPlayer;

	if (params.params != 1)
	{
		throw CError(_T("DestroyPlayer() requires one parameter."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("DestroyPlayer(): player not found"));

	if (p == g_pSelectedPlayer) throw CError(_T("DestroyPlayer(): cannot destroy the active player"));

	// Remove the player from the z-ordered vector.
	g_sprites.remove(p);

	// TBD: free globals?

	// Remove from the party.
	std::vector<CPlayer *>::iterator i = g_players.begin();
	for (; i != g_players.end(); ++i)
	{
		if (*i == p)
		{
			g_players.erase(i);
			break;
		}
	}
	delete p;

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void removePlayer(string handle)
 * 
 * Remove a player from the party [to an old player list].
 */
void removePlayer(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("RemovePlayer() requires one parameter."));
	}

	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("RemovePlayer(): player not found"));

	// Player was placed in "other players" list.
	// List was saved to game state, so the players could be restored.
	// However, variables were never used to restore player, only for 
	// callbacks - and probably served little use.
	// Stats are are reconstructed using RPGCode variables and
	// restoreCharacter()... rather dubiously (and also meant that
	// destroyed players could be restored).

	// TBD: implement other player lists if needed. Otherwise
	// this is identical to destroyPlayer() if destroyPlayer() does
	// not free stats (and then destroyed players can be restored too).
	destroyplayer(params);
}

/*
 * void restorePlayer(string filename)
 * 
 * Restore a player who was previously on the team.
 */
void restoreplayer(CALL_DATA &params)
{
	extern std::vector<CPlayer *> g_players;
	extern STRING g_projectPath;

	if (params.params != 1)
	{
		throw CError(_T("RestorePlayer() requires one parameter."));
	}

	const STRING file = g_projectPath + TEM_PATH + params[0].getLit();

	if (CFile::fileExists(file))
	{
		// Do not create global variables - these should already
		// exist if the player was previously removed.
		CPlayer *p = new CPlayer(file, false, false);
		g_players.push_back(p);
		p->restore(true);
	}
}

/*
 * void newPlayer(string file)
 * 
 * Change the graphics of the main player to that of the
 * file passed in. The file must be a character file (*.tem)
 */
void newPlayer(CALL_DATA &params)
{
	extern CPlayer *g_pSelectedPlayer;
	extern STRING g_projectPath;

	if (params.params != 1)
	{
		throw CError(_T("newPlayer() requires one parameter."));
	}
	STRING ext = getExtension(params[0].getLit());

	if (_ftcsicmp(ext.c_str(), _T("TEM")) != 0)
	{
		throw CError(_T("newPlayer() requires a tem file."));
	}
	// Load new sprite graphics from this character.
	g_pSelectedPlayer->swapGraphics(params[0].getLit());
}

/*
 * int onBoard(variant handle)
 *
 * Return whether a player is being shown on the board.
 */
void onboard(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("OnBoard() requires one parameter."));
	}
	
	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("OnBoard(): player not found"));

	params.ret().udt = UDT_NUM;
	params.ret().num = p->isActive() ? 1 : 0;
}

/*
 * int createItem(string filename[, int &pos])
 * 
 * Load an item and return the slot into which it was loaded.
 */
void createitem(CALL_DATA &params)
{
	/*
	 * In the beginning, CreateItem() loaded the item into
	 * the first available position and then returned the
	 * number of that position so that the user could use it.
	 *
	 * Because of poor documentation, people sometimes passed
	 * numbers into the second parameter, and then used only
	 * numbers to refer to the item. This generally worked because
	 * the coder would pick the first free number (thinking it
	 * would be loaded into it) and the interpreter would report
	 * no error when it failed to set the variable (which was
	 * not a variable but a number).
	 *
	 * In 3.0.4, I rewrote CreateItem() without a full understanding
	 * of its history and made it actually load the item into
	 * the slot that was passed in. This enabled code that had
	 * passed in numbers to continue to work but effectively
	 * broke code that was passing in a variable to be set.
	 *
	 * Thus, to preserve backwards compatibility with both systems,
	 * and provide predictable behaviour, 3.1.0 must support both
	 * methods in a way that does not break any code. The solution
	 * is to check whether a var has been passed for the second
	 * parameter, if a second parameter has been given. If the
	 * parameter is a var, it is safe to set its value to the
	 * first open slot and load the item into the first slot.
	 *
	 * There are two scenarios: either the user intended for that
	 * var to be set (historical code); or the variable contains
	 * the position that the user intends for the item to be loaded
	 * into. In the second case, it is highly likely that the
	 * user will proceed to use that var, rather than the constant
	 * number, to refer to the position; it is also unlikely that
	 * the user intends to overwrite an existing item in that spot.
	 * If, however, the user is attempting to do one of those two
	 * things, his code will break -- but it is a negligible worry.
	 *
	 * If the second parameter is a constant, we will simply load
	 * the item into that spot, as that is the only predictable action.
	 *
	 * Though this system is not fool proof, it shall suffice.
	 *
	 * --Colin
	 */

	extern STRING g_projectPath;
	extern LPBOARD g_pBoard;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("CreateItem() requires one or two parameters."));
	}

	CItem *p = NULL;
	try
	{
		p = new CItem(g_projectPath + ITM_PATH + params[0].getLit(), false);
	}
	catch (CInvalidItem) { return; }

	// If two parameters were provided and the second parameter is
	// a constant, load the item into that position.
	if ((params.params == 2) && !(params[1].udt & UDT_ID))
	{
		const int i = params[1].getNum();

		// Is the board item array large enough?
		while (g_pBoard->items.size() <= i)
		{
			g_pBoard->items.push_back(NULL);
		}

		// Erase the item at this position.
		delete g_pBoard->items[i];
		g_pBoard->items[i] = p;

		return;
	}

	// Search for an open spot.
	std::vector<CItem *>::iterator i = g_pBoard->items.begin();
	for (; i != g_pBoard->items.end(); ++i)
	{
		if (*i == NULL)
		{
			// Insert the item here.
			*i = p;
			break;
		}
	}

	if (i == g_pBoard->items.end())
	{
		// Create a new spot for the item.
		g_pBoard->items.push_back(p);
		i = g_pBoard->items.end() - 1; // Not redundant.
	}

	params.ret().udt = UDT_NUM;
	params.ret().num = double(i - g_pBoard->items.begin());

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void putitem(variant handle, int x, int y, int layer)
 * 
 * Place the item on the board at the given location.
 */
void putitem(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern RECT g_screen;
	extern ZO_VECTOR g_sprites;

	if (params.params != 4)
	{
		throw CError(_T("PutItem() requires four parameters."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("PutItem(): item not found"));

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	const int l = int(params[3].getNum());

	p->setActive(true);
    p->setPosition(int(params[1].getNum()), 
		int(params[2].getNum()), 
		int(params[3].getNum()), 
		g_pBoard->coordType);

	// Insert the pointer into the z-ordered vector.
	g_sprites.zOrder();
    
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void eraseitem(variant handle)
 *
 * Erase an item from the screen, but keep it in memory.
 * Warning: erasing an item in it's own multitasking thread will pause the thread.
 */
void eraseitem(CALL_DATA &params)
{
	extern ZO_VECTOR g_sprites;

	if (params.params != 1)
	{
		throw CError(_T("EraseItem() requires one parameter."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("EraseItem(): item not found"));

	// Remove the item from the z-ordered vector.
	g_sprites.remove(p);
	p->setActive(false);

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void destroyitem(variant handle)
 * 
 * Remove an item from memory. 
 * Warning: do not destroy an item through it's own multitasking thread.
 */
void destroyitem(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (params.params != 1)
	{
		throw CError(_T("DestroyItem() requires one parameter."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("DestroyItem(): item not found"));
	
	std::vector<CItem *>::iterator i = g_pBoard->items.begin();
	for (; i != g_pBoard->items.end(); ++i)
	{
		if (*i == p)
		{
			g_sprites.remove(*i);
			delete *i;
			*i = NULL;
			return;
		}
	}
}

/*
 * void gamespeed(int speed)
 * 
 * Set the overall walking speed. Changes the walking speed proportionally.
 * +ve values increase speed, -ve decrease, by a factor of 10% per increment.
 * Allowed values range from -MAX_GAMESPEED to +MAX_GAMESPEED.
 */
void gamespeed(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("GameSpeed() requires one parameter."));
	}
	CSprite::setLoopOffset(params[0].getNum());
}

/*
 * void playerspeed(string handle, int speed)
 * 
 * Set the delay in seconds between a player's steps.
 */
void playerspeed(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("PlayerSpeed() requires two parameters."));
	}
	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerSpeed(): player not found"));

	p->setSpeed(params[1].getNum());
}

/*
 * void itemspeed(variant handle, int speed)
 * 
 * Set the delay in seconds between an item's steps.
 */
void itemspeed(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("ItemSpeed() requires two parameters."));
	}
	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemSpeed(): item not found"));

	p->setSpeed(params[1].getNum());
}

/*
 * void walkSpeed()
 * 
 * Obsolete.
 */
void walkSpeed(CALL_DATA &params)
{
	throw CError(_T("WalkSpeed() is obsolete."));
}

/*
 * void itemWalkSpeed()
 * 
 * Obsolete.
 */
void itemWalkSpeed(CALL_DATA &params)
{
	throw CError(_T("ItemWalkSpeed() is obsolete."));
}

/*
 * void characterSpeed()
 * 
 * Obsolete.
 */
void characterSpeed(CALL_DATA &params)
{
	CProgram::debugger(_T("CharacterSpeed() has depreciated into GameSpeed()."));
	gamespeed(params);
}

/*
 * void itemlocation(variant handle, int &x, int &y, int &layer)
 * 
 * Get the location of an item.
 */
void itemlocation(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 4)
	{
		throw CError(_T("ItemLocation() requires four parameters."));
	}
	
	LPSTACK_FRAME x = params.prg->getVar(params[1].lit),
				  y = params.prg->getVar(params[2].lit),
				  l = params.prg->getVar(params[3].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;
	l->udt = UDT_NUM;

	const CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemLocation(): item not found"));

	const SPRITE_POSITION s = p->getPosition();

	// Transform from pixel to board type (e.g. tile).
	int dx = int(s.x), dy = int(s.y);
	coords::pixelToTile(dx, dy, g_pBoard->coordType, false, g_pBoard->sizeX);

	x->num = dx;
	y->num = dy;
	l->num = s.l;
}

/*
 * void playerlocation(variant handle, int &x, int &y, int &layer)
 * 
 * Get the location of a player.
 */
void playerlocation(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 4)
	{
		throw CError(_T("PlayerLocation() requires four parameters."));
	}
	
	LPSTACK_FRAME x = params.prg->getVar(params[1].lit),
				  y = params.prg->getVar(params[2].lit),
				  l = params.prg->getVar(params[3].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;
	l->udt = UDT_NUM;

	const CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerLocation(): player not found"));

	const SPRITE_POSITION s = p->getPosition();

	// Transform from pixel to board type (e.g. tile).
	int dx = int(s.x), dy = int(s.y);
	coords::pixelToTile(dx, dy, g_pBoard->coordType, false, g_pBoard->sizeX);

	x->num = dx;
	y->num = dy;
	l->num = s.l;
}

/*
 * void sourcelocation(int &x, &int y)
 * 
 * Get the location of the source object.
 */
void sourcelocation(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern IPlugin *g_pFightPlugin;

	if (params.params != 2)
	{
		throw CError(_T("SourceLocation() requires two parameters."));
	}

	LPSTACK_FRAME x = params.prg->getVar(params[0].lit),
				  y = params.prg->getVar(params[1].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;

	int dx = 0, dy = 0;

	if (isFighting())
	{
		IFighter *pFighter = (IFighter *)g_source.p;
		int party = -1, idx = -1;
		getFighterIndices(pFighter, party, idx);
		if (!g_pFightPlugin->getFighterLocation(party, idx, dx, dy))
		{
			// This call is only supported in the 3.1.0 version of the default
			// battle system. The readme will explain how to copy in the new
			// dll from the "basic" folder. If for some reason the call does
			// not succeed, we return -1 for both coords.
			dx = dy = -1;
		}
	}
	else if (g_source.type != ET_ENEMY)
	{
		// Player or item.
		const CSprite *p = (CSprite *)g_source.p;
		const SPRITE_POSITION s = p->getPosition();
		dx = int(s.x);
		dy = int(s.y);
		// Transform from pixel to board type (e.g. tile).
		coords::pixelToTile(dx, dy, g_pBoard->coordType, false, g_pBoard->sizeX);
	}
	x->num = dx;
	y->num = dy;
}

/*
 * void targetlocation(int &x, &int y)
 * 
 * Get the location of the target object.
 */
void targetlocation(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern IPlugin *g_pFightPlugin;

	if (params.params != 2)
	{
		throw CError(_T("TargetLocation() requires two parameters."));
	}
	
	LPSTACK_FRAME x = params.prg->getVar(params[0].lit),
				  y = params.prg->getVar(params[1].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;

	int dx = 0, dy = 0;

	if (isFighting())
	{
		IFighter *pFighter = (IFighter *)g_target.p;
		int party = -1, idx = -1;
		getFighterIndices(pFighter, party, idx);
		if (!g_pFightPlugin->getFighterLocation(party, idx, dx, dy))
		{
			// This call is only supported in the 3.1.0 version of the default
			// battle system. The readme will explain how to copy in the new
			// dll from the "basic" folder. If for some reason the call does
			// not succeed, we return -1 for both coords.
			dx = dy = -1;
		}
	}
	else if (g_target.type != ET_ENEMY)
	{
		// Player or item.
		const CSprite *p = (CSprite *)g_target.p;
		const SPRITE_POSITION s = p->getPosition();
		dx = int(s.x);
		dy = int(s.y);
		// Transform from pixel to board type (e.g. tile).
		coords::pixelToTile(dx, dy, g_pBoard->coordType, false, g_pBoard->sizeX);
	}

	x->num = dx;
	y->num = dy;
}

/*
 * string sourcehandle([string &ret])
 * 
 * Get the handle of the source object.
 */
void sourcehandle(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	STRING str;
	if (g_source.type == ET_PLAYER)
	{
		IFighter *p = (IFighter *)g_source.p;
		str = p->name();
	}
	else if (g_source.type == ET_ITEM)
	{
		// Return the item index...(!)
		int i = 0;
		str = _T("ITEM");
		CItem *p = (CItem *)g_source.p;
		std::vector<CItem *>::iterator j = g_pBoard->items.begin();
		for (; j != g_pBoard->items.end(); ++j)
		{
			if (p == *j) i = j - g_pBoard->items.begin();
		}
		char c[8];
		str += itoa(i, c, 10);
	}
	else if (g_source.type == ET_ENEMY)
	{
		// Return the enemy name rather than its index.
		// Note: Users can no longer determine the enemy index, but
		//		 I doubt anyone used this string for that before.
		//			- Colin
		if (g_source.p)
		{
			str = LPENEMY(g_source.p)->name();
		}
	}

	params.ret().udt = UDT_LIT;
	params.ret().lit = str;
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
	else if (params.params != 0)
	{
		throw CError(_T("SourceHandle() requires zero or one parameter(s)."));
	}
}

/*
 * string targethandle([string &ret])
 * 
 * Get the handle of the target object.
 */
void targethandle(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	STRING str;
	if (g_target.type == ET_PLAYER)
	{
		IFighter *p = (IFighter *)g_target.p;
		str = p->name();
	}
	else if (g_target.type == ET_ITEM)
	{
		// Return the item index...(!)
		int i = 0;
		str = _T("ITEM");
		CItem *p = (CItem *)g_target.p;
		std::vector<CItem *>::iterator j = g_pBoard->items.begin();
		for (; j != g_pBoard->items.end(); ++j)
		{
			if (p == *j) i = j - g_pBoard->items.begin();
		}
		char c[8];
		str += itoa(i, c, 10);
	}
	else if (g_target.type == ET_ENEMY)
	{
		// Return the enemy name rather than its index.
		// Note: Users can no longer determine the enemy index, but
		//		 I doubt anyone used this string for that before.
		//			- Colin
		if (g_target.p)
		{
			str = LPENEMY(g_target.p)->name();
		}
	}

	params.ret().udt = UDT_LIT;
	params.ret().lit = str;
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
	else if (params.params != 0)
	{
		throw CError(_T("TargetHandle() requires zero or one parameter(s)."));
	}
}

/*
 * void bitmap(string file, [canvas cnv])
 * 
 * Fill a surface with an image.
 */
void bitmap(CALL_DATA &params)
{
	CCanvas *cnv = NULL;
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
		throw CError(_T("Bitmap() requires one or two parameters."));
	}
	if (cnv)
	{
		extern STRING g_projectPath;
		extern int g_resX, g_resY;
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), cnv, 0, 0, g_resX, g_resY);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
}

/*
 * void mainFile(string gam)
 * 
 * Load a new main file.
 */
void mainFile(CALL_DATA &params)
{
	extern MAIN_FILE g_mainFile;
	extern void reset();

	if (params.params != 1)
	{
		throw CError(_T("MainFile() requires one parameter."));
	}
	if (g_mainFile.open(GAM_PATH + params[0].getLit()))
	{
		reset();
	}
}

/*
 * string dirSav(string title, bool allowNewFile, int textColor, int backColor, string image)
 * 
 * Allow the user to choose a *.sav file from the "Saved"
 * directory. For historical reasons, returns "CANCEL" if
 * no file is chosen, not "".
 */
void dirSav(CALL_DATA &params)
{
	extern STRING g_savePath;

	STRING file;
	if (params.params == 5)
	{
		file = fileDialog(
			g_savePath,
			_T("*.sav"),
			params[0].getLit(),
			params[1].getBool(),
			long(params[2].getNum()),
			long(params[3].getNum()),
			params[4].getLit()
		);
	}
	else
	{
		file = fileDialog(
			g_savePath, 
			_T("*.sav"), 
			_T("Save / Load A Game"), 
			true, 
			RGB(255, 255, 255), 
			0, 
			STRING()
		);
	}

	params.ret().udt = UDT_LIT;
	params.ret().lit = (file.empty() ? _T("CANCEL") : file);
	
	if (params.params == 1) 
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * void save(string file)
 * 
 * Save the current game state to a file.
 */
void save(CALL_DATA &params)
{
	extern STRING g_savePath;
	if (params.params != 1)
	{
		throw CError(_T("Save() requires one parameter."));
	}
	saveSaveState(g_savePath + addExtension(params[0].getLit(), _T("sav")));
}

/*
 * void load(string file)
 * 
 * Load the game state from a file.
 */
void load(CALL_DATA &params)
{
	extern STRING g_savePath;
	extern bool g_loadFromStartPrg;
	if (params.params != 1)
	{
		throw CError(_T("Load() requires one parameter."));
	}
	loadSaveState(g_savePath + addExtension(params[0].getLit(), _T("sav")));
	g_loadFromStartPrg = true;
}

/*
 * void scan(int x, int y, int pos)
 * 
 * Save the tile specified to a buffer identified by
 * pos. There is no particular number to pick for pos;
 * any will do.
 * @deprecated
 */
void scan(CALL_DATA &params)
{
	extern std::vector<CCanvas *> g_cnvRpgScans;
	extern LPBOARD g_pBoard;

	if (params.params != 3)
	{
		throw CError(_T("Scan() requires three parameters."));
	}
	
	const int i = int(params[2].getNum());
	int x = int(params[0].getNum()), y = int(params[1].getNum());
	coords::tileToPixel(x, y, g_pBoard->coordType, false, g_pBoard->sizeX);

	while (i >= g_cnvRpgScans.size())
	{
		g_cnvRpgScans.push_back(NULL);
	}
	
	if (!g_cnvRpgScans[i])
	{
		g_cnvRpgScans[i] = new CCanvas();
		g_cnvRpgScans[i]->CreateBlank(NULL, 32, 32, TRUE);
	}
	g_cnvRpgScans[i]->ClearScreen(TRANSP_COLOR);

	g_cnvRpgCode->BltPart(
		g_cnvRpgScans[i],
		0, 0,
		x, y,
		32, 32,
		SRCCOPY);
}

/*
 * void mem(int x, int y, int pos)
 * 
 * Lay a scanned tile on the screen at the specified position.
 * @deprecated
 */
void mem(CALL_DATA &params)
{
	extern std::vector<CCanvas *> g_cnvRpgScans;
	extern LPBOARD g_pBoard;

	if (params.params != 3)
	{
		throw CError(_T("Mem() requires three parameters."));
	}

	const int i = int(params[2].getNum());
	int x = int(params[0].getNum()), y = int(params[1].getNum());
	coords::tileToPixel(x, y, g_pBoard->coordType, false, g_pBoard->sizeX);

	if (i < g_cnvRpgScans.size() && g_cnvRpgScans[i])
	{
		// The canvas exists.
		g_cnvRpgScans[i]->BltPart(
			g_cnvRpgCode,
			x, y,
			0, 0,
			32, 32,
			SRCCOPY);
	}
	else throw CError(_T("Mem(): canvas not found."));

	renderRpgCodeScreen();
}

/*
 * void print(string text)
 * 
 * Write the specified string one line down from the last call
 * to text().
 */
void print(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Print() requires one parameter."));
	}
	g_textY += 1.0;
	g_cnvRpgCode->DrawText(g_textX * g_fontSize - g_fontSize, g_textY * g_fontSize - g_fontSize, params[0].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	renderRpgCodeScreen();
}

/*
 * void rpgCode(string line)
 * 
 * Independently run a line of RPGCode.
 */
void rpgCode(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("RPGCode() requires one parameter."));
	}
	CProgramChild prg(*params.prg);
	prg.loadFromString(params[0].getLit());
	prg.run();
}

/*
 * string charAt(string str, int pos, [string &ret])
 * 
 * Get a character from a string. The first character is one.
 * The value of the <b>pos</b> parameter must be in the closed
 * interval [1, length].
 */
void charAt(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("CharAt() requires two or three parameters."));
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = params[0].getLit().substr(int(params[1].getNum()) - 1, 1);
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * void equip(variant handle, int location, string item)
 * 
 * Equip an item from the inventory (by handle or filename) 
 * to a location on the player's body.
 *
 * <ul><li>1 - Head</li>
 * <li>2 - Neck accessory</li>
 * <li>3 - Right hand</li>
 * <li>4 - Left hand</li>
 * <li>5 - Body</li>
 * <li>6 - Legs</li>
 * <li>7+ - Custom accessories</li></ul>
 */
void equip(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 3)
	{
		throw CError(_T("Equip() requires three parameters."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("Equip(): player not found."));

	const unsigned int i = abs(params[1].getNum());
	const STRING str = g_projectPath + ITM_PATH + params[2].getLit();

	// Try to take the item.
	if (g_inv.take(str))
	{
		// Remove any item that may be equipped.
		p->removeEquipment(i);
		p->addEquipment(i, str); 
	}
	else throw CError(_T("Equip(): item not in inventory."));
}

/*
 * void remove(variant handle, int location)
 * 
 * Remove an equipped item and return it to the inventory.
 */
void remove(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("Remove() requires two parameters."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("Remove(): player not found."));

	unsigned int i = abs(params[1].getNum());

	p->removeEquipment(i);
}

/*
 * void kill(variant &var, ...)
 * 
 * Delete variables.
 */
void kill(CALL_DATA &params)
{
	for (unsigned int i = 0; i < params.params; ++i)
	{
		params.prg->freeVar(params[i].lit);
	}
}

/*
 * void giveGp(int gp)
 * 
 * Give gold pieces.
 */
void giveGp(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("GiveGP() requires one parameter."));
	}
	g_gp += params[0].getNum();
}

/*
 * void takeGp(int gp)
 * 
 * Take gold pieces.
 */
void takeGp(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("TakeGP() requires one parameter."));
	}
	g_gp -= params[0].getNum();
}

/*
 * int getGp([int &ret])
 * 
 * Return the amount of gold pieces held.
 */
void getGp(CALL_DATA &params)
{
	params.ret().udt = UDT_NUM;
	params.ret().num = double(g_gp);
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * void borderColor(int r, int g, int b)
 * 
 * Obsolete.
 */
void borderColor(CALL_DATA &params)
{
	throw CError(_T("BorderColor() is obsolete."));
}

/*
 * void fightEnemy(string enemy, string enemy, ... string background)
 * 
 * Start a fight.
 */
void fightEnemy(CALL_DATA &params)
{
	if (params.params < 2)
	{
		throw CError(_T("FightEnemy() requires at least two parameters."));
	}
	std::vector<STRING> enemies;
	for (unsigned int i = 0; i < (params.params - 1); ++i)
	{
		enemies.push_back(params[i].getLit());
	}
	runFight(enemies, params[params.params - 1].getLit());
}

/*
 * void callshop(string item1, string item2, string item3, ...)
 * 
 * Displays a basic shop interface that allows the buying of the items
 * given as parameters and the selling of items in the player's inventory.
 */
void callshop(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params == 0)
	{
		throw CError(_T("CallShop() requires at least one parameter."));
	}

	CInventory shopInv;

	for (unsigned int i = 0; i != params.params; ++i)
	{
		const STRING item = addExtension(params[i].getLit(), _T("itm"));
		if (CFile::fileExists(g_projectPath + ITM_PATH + item))
		{
			shopInv.give(g_projectPath + ITM_PATH + item);
		}
		else
		{
			throw CWarning(_T("CallShop() item not found: " + item));
		}
	}

	CShop shop(&shopInv, &g_inv, &g_gp, STRING());
}

/*
 * void clearBuffer()
 * 
 * Clear the keyboard buffer.
 */
void clearBuffer(CALL_DATA &params)
{
	extern std::vector<char> g_keys;
	g_keys.clear();
}

/*
 * void attackAll(int fp)
 * 
 * Deal the specified amount in HP to all the members
 * of the target's party.
 */
void attackall(CALL_DATA &params)
{
	extern IPlugin *g_pFightPlugin;

	if (params.params != 1)
	{
		throw CError(_T("AttackAll() requires one parameter."));
	}

	if (!isFighting())
	{
		throw CError(_T("AttackAll() cannot be used outside of a battle."));
	}

	// Get the target party.
	int party = -1;
	if (g_target.type == ET_ENEMY) party = ENEMY_PARTY;
	else if (g_target.type == ET_PLAYER) party = PLAYER_PARTY;
	else
	{
		throw CError(_T("AttackAll(): inappropriate target."));
	}

	const int damage = int(params[0].getNum());

	int idx = -1;
	LPFIGHTER pFighter = NULL;
	while (pFighter = getFighter(party, ++idx))
	{
		// Deal the damage to this fighter.
		int hp = pFighter->pFighter->health() - damage;
		if (hp < 0) hp = 0;
		pFighter->pFighter->health(hp);

		// Inform the plugin.
		g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, damage, 0, _T(""), INFORM_REMOVE_HP);
	}
}

/*
 * void drainAll(int fp)
 * 
 * Deal the specified amount in SMP to all the members
 * of the target's party.
 */
void drainall(CALL_DATA &params)
{
	extern IPlugin *g_pFightPlugin;

	if (params.params != 1)
	{
		throw CError(_T("DrainAll() requires one parameter."));
	}

	if (!isFighting())
	{
		throw CError(_T("DrainAll() cannot be used outside of a battle."));
	}

	// Get the target party.
	int party = -1;
	if (g_target.type == ET_ENEMY) party = ENEMY_PARTY;
	else if (g_target.type == ET_PLAYER) party = PLAYER_PARTY;
	else
	{
		throw CError(_T("DrainAll(): inappropriate target."));
	}

	const int damage = int(params[0].getNum());

	int idx = -1;
	LPFIGHTER pFighter = NULL;
	while (pFighter = getFighter(party, ++idx))
	{
		// Deal the damage to this fighter.
		int smp = pFighter->pFighter->smp() - damage;
		if (smp < 0) smp = 0;
		pFighter->pFighter->smp(smp);

		// Inform the plugin.
		g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, 0, damage, _T(""), INFORM_REMOVE_SMP);
	}
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
 * setbutton(string file, int slot, int x, int y, int width, int height)
 * 
 * Create and draw a clickable button at screen pixel co-ords x, y 
 * that persists until clearButtons() is called.
 */
void setbutton(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 6)
	{
		throw CError(_T("SetButton() requires six parameters."));
	}

	const int slot = int(params[1].getNum()),
		x = int(params[2].getNum()), 
		y = int(params[3].getNum()),
		w = int(params[4].getNum()), 
		h = int(params[5].getNum());
	RECT r = {x, y, x + w, y + h};
	const STRING file = params[0].getLit();

	g_buttons[slot] = RPG_BUTTON(file, r);

	// Draw. This image will not persist though!
	if (CFile::fileExists(g_projectPath + BMP_PATH + file))
	{
		drawImage(g_projectPath + BMP_PATH + file, g_cnvRpgCode, x, y, w, h);
		renderRpgCodeScreen();
	}
}

/*
 * int = checkbutton(int x, int y)
 * 
 * Check if any SetButton()s were clicked at screen pixel co-ords x, y.
 * If two buttons exist at x,y, the lower slot number is returned.
 * If no button exists at x,y, -1 is returned. 
 */
void checkbutton(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("CheckButton() requires two parameters."));
	}
	const int x = int(params[0].getNum()), y = int(params[1].getNum()); 

	params.ret().udt = UDT_NUM;

	std::map<int, RPG_BUTTON>::iterator i = g_buttons.begin();
	for(; i != g_buttons.end(); ++i)
	{
		const RECT r = i->second.second;
		if (x >= r.left && x <= r.right && y >= r.top && y <= r.bottom)
		{
			params.ret().num = double(i->first);
			return;
		}
	}
	params.ret().num = -1.0;
}

/*
 * clearbuttons([int slot1, int slot2...])
 * 
 * Clear buttons set by SetButton(). Clear specific slot(s) if supplied,
 * else clear all slots.
 */
void clearbuttons(CALL_DATA &params)
{
	if (params.params)
	{
		for (unsigned int i = 0; i != params.params; ++i)
		{
			std::map<int, RPG_BUTTON>::iterator j = g_buttons.find(int(params[i].getNum()));
			if (j != g_buttons.end()) g_buttons.erase(j);
		}
		return;
	}
	g_buttons.clear();
}

/*
 * mouseclick(int &x, int &y [, bool noWait])
 * 
 * Wait for a mouseclick or immediately retrieve the last and
 * return the x, y location (pixel values relative to the window).
 */
void mouseclick(CALL_DATA &params)
{
	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("MouseClick() requires two or three parameters."));
	}
	CONST POINT p = getMouseClick(params.params == 3 ? !(params[2].getBool()) : true);
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = p.x;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = p.y;
	}
}

/*
 * mousemove(int &x, int &y)
 * 
 * Wait for the mouse to move and return the x,y location in pixels
 * from the window corner.
 */
void mousemove(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("MouseMove() requires two parameters."));
	}

	CONST POINT p = getMouseMove();
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = p.x;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = p.y;
	}
}

/*
 * void fade(int type)
 * 
 * Perform a fade using the current colour. There are several
 * different types of fades.
 *
 * <ul><li>0 - the screen is blotted out by a growing and shrinking box</li>
 * <li>2 - fades from white to black</li>
 * <li>3 - line sweeps across the screen</li>
 * <li>4 - black circle swallows the player</li>
 * <li>5 - image fade to black</li></ul>
 */
void fade(CALL_DATA &params)
{
	extern RECT g_screen;

	const int type = (!params.params ? 0 : int(params[0].getNum())), 
			  width = g_cnvRpgCode->GetWidth(),
			  height = g_cnvRpgCode->GetHeight();
	
	// TBD: delays?

	switch (type)
	{
	case 0:
		{
			// Box grows from centre to fill screen.
			const int pxStep = 5;

			for (unsigned int i = 0; i != width / 2; i += pxStep)
			{
				int y1 = height / 2 - i, y2 = height / 2 + i;

				g_cnvRpgCode->DrawFilledRect(
					width / 2 - i, (y1 < 0 ? 0 : y1),
					width / 2 + i, (y2 > height ? height : y2),
					g_color);
				renderRpgCodeScreen();
			}
			// Shrink box back to centre on a black background.
			for (; i != 0; i -= pxStep)
			{
				g_cnvRpgCode->ClearScreen(0);
				int y1 = height / 2 - i, y2 = height / 2 + i;

				g_cnvRpgCode->DrawFilledRect(
					width / 2 - i, (y1 < 0 ? 0 : y1),
					width / 2 + i, (y2 > height ? height : y2),
					g_color);
				processEvent();
				renderRpgCodeScreen();
			}
		} break;
	case 1:
		{
			// Vertical lines sweep across screen.
			const int pxStep = 5;
			int color = g_color;

			for (int j = 0; j != 2; ++j)
			{
				// First sweep.
				for (unsigned int i = 0; i != width / 2; i += pxStep * 2)
				{
					g_cnvRpgCode->DrawFilledRect(i, 0, i + pxStep, height, color);
					g_cnvRpgCode->DrawFilledRect(width / 2 + i, 0, width / 2 + i + pxStep, height, color);
					processEvent();
					renderRpgCodeScreen();
				}
				// Fill in gaps.
				for (i = pxStep; i < width / 2; i += pxStep * 2)
				{
					g_cnvRpgCode->DrawFilledRect(i, 0, i + pxStep, height, color);
					g_cnvRpgCode->DrawFilledRect(width / 2 + i, 0, width / 2 + i + pxStep, height, color);
					processEvent();
					renderRpgCodeScreen();
				}
				// Repeat once with black.
				color = 0;
			}
			g_cnvRpgCode->ClearScreen(g_color);
			processEvent();
			renderRpgCodeScreen();
		} break;
	case 2:
		{
			// "Fade" from solid grey to solid black.
			for (int i = 128; i >= 0; i -= 4)
			{
				g_cnvRpgCode->ClearScreen(RGB(i,i,i));
				processEvent();
				renderRpgCodeScreen();
			}
		} break;
	case 3:
		{
			// Swipe left to right.
			const int pxStep = 4;

			// Create a gradient for the leading edge.
			CCanvas cnv;
			cnv.CreateBlank(NULL, 128, height, TRUE);
			cnv.ClearScreen(0);
			for (int i = 0; i != 128; i += pxStep)
			{
				cnv.DrawFilledRect(i, 0, i + pxStep, height, RGB(i,i,i));
			}
			// Copy over the gradient, shifting it right.
			for (i = -128; i != width; i += pxStep)
			{
				// Overflow handled in BltPart().
				cnv.Blt(g_cnvRpgCode, i, 0, SRCCOPY);
				processEvent();
				renderRpgCodeScreen();
			}
		} break;
	case 4:
		{
			// Circle in on player.
			extern CPlayer *g_pSelectedPlayer;
			const SPRITE_POSITION p = g_pSelectedPlayer->getPosition();
			const int x = int(p.x) - g_screen.left,// - 16,
					  y = int(p.y) - g_screen.top - 16;
			// Use the longest diagonal as the radius.
			const int rX = (width - x > x ? width - x: x),
					  rY = (height - y > y ? height - y: y);
			int radius = sqrt(rX * rX + rY * rY);

			for (; radius > 0; radius -= 1)
			{
				g_cnvRpgCode->DrawEllipse(x - radius, y - radius, x + radius, y + radius, 0);
				processEvent();
                renderRpgCodeScreen();
			}
		} break;
	case 5:
		{
			// Image fade.
			CCanvas cnv;
			cnv.CreateBlank(NULL, width, height, TRUE);
			cnv.ClearScreen(g_color);

			CCanvas cnvScr = *g_cnvRpgCode;

			for (double i = 0.1; i <= 1.0; i += 0.1)
			{
				cnvScr.Blt(g_cnvRpgCode, 0, 0, SRCCOPY);
				cnv.BltTranslucent(g_cnvRpgCode, 0, 0, i, -1, -1);
				processEvent();
                renderRpgCodeScreen();
			}
		} break;

	}
}

/*
 * zoom(int percent)
 * 
 * Zoom into the centre of the board by the specified percent.
 */
void zoom(CALL_DATA &params)
{
	extern RECT g_screen;
	extern double g_fpms;

	const int width = g_screen.right - g_screen.left,
			  height = g_screen.bottom - g_screen.top;

	if (params.params != 1)
	{
		throw CError(_T("Zoom() requires one parameter."));
	}
	CCanvas cnv(*g_cnvRpgCode);
	const double percent = 1.0 - params[0].getNum() / 100;
	const double speed = g_fpms * 0.05;

	for (double i = 1.0; i > percent; i -= 0.01 * speed)
	{
		const int w = width * i, h = height * i;

		cnv.BltStretch(
			g_cnvRpgCode,
			0, 0,
			(width - w) * 0.5, (height - h) * 0.5,
			w, h,
			width, height,
			SRCCOPY);

		renderRpgCodeScreen();
		Sleep(MISC_DELAY);
		processEvent();
	}
}

/*
 * earthquake(int intensity)
 * 
 * Shake the screen.
 */
void earthquake(CALL_DATA &params)
{
	extern RECT g_screen;
	extern LPBOARD g_pBoard;

	const int width = g_screen.right - g_screen.left,
			  height = g_screen.bottom - g_screen.top;

	if (params.params != 1)
	{
		throw CError(_T("Earthquake() requires one parameter."));
	}
	const CCanvas cnv(*g_cnvRpgCode);
	const int intensity = int(params[0].getNum());

	for (int i = 1; i <= intensity; ++i)
	{
		g_cnvRpgCode->ClearScreen(g_pBoard->bkgColor);
		cnv.BltPart(g_cnvRpgCode, 0, 0, i, i, width - i, height - i, SRCCOPY);
		renderRpgCodeScreen();
		Sleep(MISC_DELAY);

		g_cnvRpgCode->ClearScreen(g_pBoard->bkgColor);
		cnv.BltPart(g_cnvRpgCode, i, 0, 0, i, width - i, height - i, SRCCOPY);
		renderRpgCodeScreen();
		Sleep(MISC_DELAY);

		g_cnvRpgCode->ClearScreen(g_pBoard->bkgColor);
		cnv.BltPart(g_cnvRpgCode, 0, i, i, 0, width - i, height - i, SRCCOPY);
		renderRpgCodeScreen();
		Sleep(MISC_DELAY);

		g_cnvRpgCode->ClearScreen(g_pBoard->bkgColor);
		cnv.BltPart(g_cnvRpgCode, i, i, 0, 0, width - i, height - i, SRCCOPY);
		renderRpgCodeScreen();
		Sleep(MISC_DELAY);

		processEvent();
	}
	cnv.Blt(g_cnvRpgCode, 0, 0, SRCCOPY);
	renderRpgCodeScreen();
}

/*
 * wipe(string file, int effect [, int speed])
 * 
 *'Wipe' a graphic to the screen.<br />
 * file: filename of the image to wipe to.<br />
 * effect: numeric value between 1 and 12. The valid types are:<ul>
 * <li>1  - Right</li>
 * <li>2  - Left</li>
 * <li>3  - Down</li>
 * <li>4  - Up</li>
 * <li>5  - NW to SE</li>
 * <li>6  - NE to SW</li>
 * <li>7  - SW to NE</li>
 * <li>8  - SE to NW</li>
 * <li>9  - Right 'zelda' style</li>
 * <li>10 - Left 'zelda' style</li>
 * <li>11 - Down 'zelda' style</li>
 * <li>12 - Up 'zelda' style</li></ul>
 * speed: default is 1, set higher to increase wipe speed.
 */
void wipe(CALL_DATA &params)
{
	extern RECT g_screen;
	extern STRING g_projectPath;
	extern double g_fpms;

	const int width = g_screen.right - g_screen.left,
			  height = g_screen.bottom - g_screen.top;

	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("Wipe() requires two or three parameters."));
	}
	CCanvas cnv, cnvScr(*g_cnvRpgCode);
	cnv.CreateBlank(NULL, width, height, TRUE);
	drawImage(g_projectPath + BMP_PATH + params[0].getLit(), &cnv, 0, 0, width, height);

	int speed = (params.params == 3 ? abs(params[2].getNum()) : 1);

	// Skip pixels for low fps. Factor by 20th of millisecond frametime.
	const int factor = round(g_fpms * 0.05);
	speed *= (!factor ? 1 : factor);

	int x = 0, y = 0;
	double dy = 0.0;
	const double dspeed = double(speed * height) / double(width);

	switch(int(params[1].getNum()))
	{
	case 1:	// Right
		for (x = 0; x < width; x += speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, x, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, x, 0, 0, 0, width - x, height, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 2:	// Left
		for (x = width; x > 0; x -= speed)
		{
			cnv.BltPart(g_cnvRpgCode, x, 0, x, 0, width - x, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, 0, width - x, 0, x, height, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 3:	// Down
		for (y = 0; y < height; y += speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, width, y, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, y, 0, 0, width, height - y, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 4:	// Up
		for (y = height; y > 0; y -= speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, y, 0, y, width, height - y, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, 0, 0,  height - y, width, y, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 5:	// Down-right
		for (; x < width; x += speed, dy += dspeed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, width, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, x, round(dy), 0, 0, width - x, height - round(dy), SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 6:	// Down-left
		for (x = width; x > 0; x -= speed, dy += dspeed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, width, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, round(dy), width - x, 0, x, height - round(dy), SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 7:	// Up-right
		for (dy = double(height); x < width; x += speed, dy -= dspeed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, width, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, x, 0, 0, height - round(dy), width - x, round(dy), SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 8:	// Up-left
		for (dy = double(height), x = width; x > 0; x -= speed, dy -= dspeed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, 0, width, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, 0, width - x, height - round(dy), x, round(dy), SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 9:	// Right / Zelda
		for (x = 0; x < width; x += speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, width - x, 0, x, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, x, 0, 0, 0, width - x, height, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 10:// Left / Zelda
		for (x = width; x > 0; x -= speed)
		{
			cnv.BltPart(g_cnvRpgCode, x, 0, 0, 0, width - x, height, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, 0, width - x, 0, x, height, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 11:// Down / Zelda
		for (y = 0; y < height; y += speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, 0, 0, height - y, width, y, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, y, 0, 0, width, height - y, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;
	case 12:// Up / Zelda
		for (y = height; y > 0; y -= speed)
		{
			cnv.BltPart(g_cnvRpgCode, 0, y, 0, 0, width, height - y, SRCCOPY);
			cnvScr.BltPart(g_cnvRpgCode, 0, 0, 0,  height - y, width, y, SRCCOPY);
			renderRpgCodeScreen();
			processEvent();
		} break;

	}
}

/*
 * int itemCount(string fileName[, int &ret])
 * 
 * Count the number of a certain item in the inventory.
 */
void itemcount(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("ItemCount() requires one or two parameters."));
	}

	const STRING file = g_projectPath + ITM_PATH + params[0].getLit();
	if (!CFile::fileExists(file)) return;

	params.ret().udt = UDT_NUM;
	params.ret().num = g_inv.getQuantity(file);

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * callplayerswap(...)
 * 
 * Unimplemented in 3.1.0.
 */
void callplayerswap(CALL_DATA &params)
{
// TBD
}

/*
 * void playAvi(string movie)
 * 
 * Play a movie full screen.<br />
 * Supported types are *.avi, *.mpg, and *.mov.
 */
void playavi(CALL_DATA &params)
{
	extern STRING g_projectPath;
	extern CAudioSegment *g_bkgMusic;
	extern HWND g_hHostWnd;
	extern int g_resX, g_resY;

	if (params.params != 1)
	{
		throw CError(_T("PlayAvi() requires one parameter."));
	}

	const STRING file = g_projectPath + MEDIA_PATH + params[0].getLit();
	if (!CFile::fileExists(file))
	{
		throw CError(_T("PlayAvi(): could not find ") + params[0].getLit() + _T("."));
	}

	// Stop music.
	g_bkgMusic->stop();

	// Don't bother checking extension, in case it doesn't match
	// the actual type of movie. Playing an invalid file will do
	// no harm.
	CVideo vid;
	vid.renderFile(file);
	vid.setWindow(long(g_hHostWnd));
	vid.setPosition(0, 0, g_resX, g_resY);
	vid.play();

	// Resume music.
	g_bkgMusic->play(true);
}

/*
 * playAviSmall(string movie)
 * 
 * Play a movie at actual size, centred.
 * Supported types are *.avi, *.mpg, and *.mov.
 */
void playavismall(CALL_DATA &params)
{
	extern STRING g_projectPath;
	extern CAudioSegment *g_bkgMusic;
	extern HWND g_hHostWnd;
	extern int g_resX, g_resY;

	if (params.params != 1)
	{
		throw CError(_T("PlayAviSmall() requires one parameter."));
	}

	const STRING file = g_projectPath + MEDIA_PATH + params[0].getLit();
	if (!CFile::fileExists(file))
	{
		throw CError(_T("PlayAviSmall(): could not find ") + params[0].getLit() + _T("."));
	}

	// Stop music.
	g_bkgMusic->stop();

	// Don't bother checking extension, in case it doesn't match
	// the actual type of movie. Playing an invalid file will do
	// no harm.
	CVideo vid;
	vid.renderFile(file);
	vid.setWindow(long(g_hHostWnd));
	const int width = vid.getWidth(), height = vid.getHeight();
	if ((g_resX >= width) && (g_resY >= height))
	{
		// Centre the video.
		vid.setPosition((g_resX - width) / 2, (g_resY - height) / 2, width, height);
	}
	else
	{
		// Larger than the screen.
		vid.setPosition(0, 0, g_resX, g_resY);
	}
	vid.play();

	// Resume music.
	g_bkgMusic->play(true);
}

/*
 * void getCorner(int &topX, int &topY)
 * 
 * Get the corner of the currently shown portion of the board.
 */
void getCorner(CALL_DATA &params)
{
	extern RECT g_screen;

	if (params.params != 2)
	{
		throw CError(_T("GetCorner() requires two parameters."));
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = g_screen.left;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = g_screen.top;
	}
}

/*
 * void underArrow()
 * 
 * Toggle the under arrow.
 */
void underArrow(CALL_DATA &params)
{
	throw CError(_T("UnderArrow() is obsolete."));
}

/*
 * int getLevel(string handle[, int &ret])
 * 
 * Get the level of a player.
 */
void getlevel(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("GetLevel() requires one or two parameters."));
	}

	CPlayer *pPlayer = (CPlayer *)(getFighter(params[0].getLit()));
	if (!pPlayer)
	{
		throw CError(_T("GetLevel(): player not found."));
	}

	params.ret().udt = UDT_NUM;
	params.ret().num = double(pPlayer->level());

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void ai(int level)
 * 
 * Have the source enemy use the internal AI.
 */
void ai(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("AI() requires one parameter."));
	}

	if (!isFighting())
	{
		throw CError(_T("AI() cannot be used outside of a battle."));
	}

	if (g_source.type != ET_ENEMY)
	{
		throw CError(_T("AI(): inappropriate source."));
	}

	const int level = int(params[0].getNum());
	if ((level < 0) || (level > 3))
	{
		throw CError(_T("AI(): level must be from zero to three."));
	}

	LPENEMY pEnemy = LPENEMY(g_source.p);
	int party = -1, idx = -1;
	getFighterIndices(pEnemy, party, idx);
	if ((party != -1) && (idx != -1))
	{
		// Use the AI.
		performFightAi(level, idx);
	}
}

/*
 * void menuGraphic(string image)
 * 
 * Choose an image for the menu.
 */
void menugraphic(CALL_DATA &params)
{
	extern STRING g_menuGraphic;

	if (params.params != 1)
	{
		throw CError(_T("MenuGraphic() requires one parameter."));
	}
	g_menuGraphic = params[0].getLit();
}

/*
 * void fightMenuGraphic(string image)
 * 
 * Choose an image for the fight menu graphic.
 */
void fightMenuGraphic(CALL_DATA &params)
{
	extern STRING g_fightMenuGraphic;

	if (params.params != 1)
	{
		throw CError(_T("FightMenuGraphic() requires one parameter."));
	}
	g_fightMenuGraphic = params[0].getLit();
}

/*
 * void fightStyle()
 * 
 * Obsolete.
 */
void fightStyle(CALL_DATA &params)
{
	throw CError(_T("FightStyle() is obsolete."));
}

/*
 * void battleSpeed(int speed)
 * 
 * Obsolete.
 */
void battleSpeed(CALL_DATA &params)
{
	throw CError(_T("BattleSpeed() is obsolete."));
}

/*
 * void textSpeed(int speed)
 * 
 * Obsolete.
 */
void textSpeed(CALL_DATA &params)
{
	throw CError(_T("TextSpeed() is obsolete."));
}

/*
 * mwinsize(int percent)
 * 
 * Obsolete.
 */
void mwinsize(CALL_DATA &params)
{
	throw CError(_T("MWinSize() is obsolete."));
}

/*
 * int getDp(string handle, [int &ret])
 * 
 * Get a fighter's dp.
 */
void getDp(CALL_DATA &params)
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
		throw CError(_T("GetDP() requires one or two parameters."));
	}
}

/*
 * int getFp(string handle, [int &ret])
 * 
 * Get a fighter's fp.
 */
void getFp(CALL_DATA &params)
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
		throw CError(_T("GetFP() requires one or two parameters."));
	}
}

/*
 * void internalMenu(int menu)
 * 
 * Show a menu using the menu plugin.<ul>
 * <li>0 - main menu</li>
 * <li>1 - item menu</li>
 * <li>2 - equip menu</li>
 * <li>4 (sic) - abilities menu</li></ul>
 */
void internalmenu(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("InternalMenu() requires one parameter."));
	}

	extern IPlugin *g_pMenuPlugin;
	if (!g_pMenuPlugin)
	{
		throw CError(_T("InternalMenu(): no menu plugin set."));
	}

	int menu = int(params[0].getNum());
	if (menu == 0) menu = MNU_MAIN;
	else if (menu == 1) menu = MNU_INVENTORY;
	else if (menu == 2) menu = MNU_EQUIP;
	else if (menu == 4) menu = MNU_ABILITIES;
	else
	{
		throw CError(_T("InternalMenu(): invalid menu specified."));
	}

	g_pMenuPlugin->menu(menu);
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void applyStatus(string target, string file)
 * 
 * Apply a status effect to a fighter.
 */
void applystatus(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("ApplyStatus() requires two parameters."));
	}

	if (!isFighting()) return;

	IFighter *pInnerFighter = getFighter(params[0].getLit());

	// Get the fighter's indices.
	int party = -1, idx = -1;
	getFighterIndices(pInnerFighter, party, idx);

	if ((party == -1) || (idx == -1))
	{
		throw CError(_T("ApplyStatus(): target not found."));
	}

	// Get the outer fighter.
	LPFIGHTER pFighter = getFighter(party, idx);

	// Apply the status effect.
	applyStatusEffect(params[1].getLit(), pFighter);
}

/*
 * void removeStatus(string target, string file)
 * 
 * Remove a status effect from a fighter.
 */
void removestatus(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("RemoveStatus() requires two parameters."));
	}

	if (!isFighting()) return;

	IFighter *pInnerFighter = getFighter(params[0].getLit());

	// Get the fighter's indices.
	int party = -1, idx = -1;
	getFighterIndices(pInnerFighter, party, idx);

	if ((party == -1) || (idx == -1))
	{
		throw CError(_T("RemoveStatus(): target not found."));
	}

	// Get the outer fighter.
	LPFIGHTER pFighter = getFighter(party, idx);

	// Remove the status effect.
	std::map<STRING, STATUS_EFFECT>::iterator i =
		pFighter->statuses.find(parser::uppercase(params[1].getLit()));

	if (i != pFighter->statuses.end())
	{
		removeStatusEffect(&i->second, pFighter);
		pFighter->statuses.erase(i);
	}
}

/*
 * void setImage(string str, int x, int y, int width, int height, [canvas cnv])
 * 
 * Set an image.
 */
void setImage(CALL_DATA &params)
{
	CCanvas *cnv = NULL;
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
		throw CError(_T("SetImage() requires five or six parameters."));
	}
	if (cnv)
	{
		extern STRING g_projectPath;
		drawImage(g_projectPath + BMP_PATH + params[0].getLit(), cnv, params[1].getNum(), params[2].getNum(), params[3].getNum(), params[4].getNum());
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}

}

/*
 * void DrawCircle(int x, int y, int radius [, int canvas])
 * 
 * Draw a circle at x,y, optionally to a canvas. Previously an arc
 * could be defined but this never worked, so the two parameters have
 * been cut and the optional canvas is now the fourth parameter.
 */
void drawcircle(CALL_DATA &params)
{
	CCanvas *cnv = g_cnvRpgCode;
	if (params.params == 4)
	{
		cnv = g_canvases.cast(int(params[3].getNum()));
		if (!cnv) return;
	}
	else if (params.params != 3)
	{
		throw CError(_T("DrawCircle() requires three or four parameters."));
	}
	
	const int x = int(params[0].getNum()),
			  y = int(params[1].getNum()),
			  r = int(params[2].getNum());

	cnv->DrawEllipse(x - r, y - r, x + r, y + r, g_color);
	if (params.params == 3)
	{
		renderRpgCodeScreen();
	}
}

/*
 * void FillCircle(int x, int y, int radius [, int canvas])
 * 
 * Draw a filled circle at x, y, to screen or canvas.
 */
void fillcircle(CALL_DATA &params)
{
	CCanvas *cnv = g_cnvRpgCode;
	if (params.params == 4)
	{
		cnv = g_canvases.cast(int(params[3].getNum()));
		if (!cnv) return;
	}
	else if (params.params != 3)
	{
		throw CError(_T("FillCircle() requires three or four parameters."));
	}
	
	const int x = int(params[0].getNum()),
			  y = int(params[1].getNum()),
			  r = int(params[2].getNum());

	cnv->DrawFilledEllipse(x - r, y - r, x + r, y + r, g_color);
	if (params.params == 3)
	{
		renderRpgCodeScreen();
	}
}

/*
 * void savescreen([int position = 0])
 * 
 * Save the current screen onto a canvas that can be restored at a
 * later time.
 */
void savescreen(CALL_DATA &params)
{
	extern std::vector<CCanvas *> g_cnvRpgScreens;
	extern CCanvas *g_cnvRpgCode;
	extern RECT g_screen;

	if (params.params != 0 && params.params != 1)
	{
		throw CError(_T("RestoreScreen() requires zero or one parameter(s)."));
	}

	const int i = (params.params == 0 ? 0 : int(params[0].getNum())),
			  width = g_screen.right - g_screen.left, 
			  height = g_screen.bottom - g_screen.top;

	while (i >= g_cnvRpgScreens.size())
	{
		g_cnvRpgScreens.push_back(NULL);
	}
	
	if (!g_cnvRpgScreens[i])
	{
		g_cnvRpgScreens[i] = new CCanvas();
		g_cnvRpgScreens[i]->CreateBlank(NULL, width, height, TRUE);
	}
	g_cnvRpgScreens[i]->ClearScreen(TRANSP_COLOR);

	g_cnvRpgCode->BltPart(
		g_cnvRpgScreens[i],
		0, 0,
		0, 0,
		width, height,
		SRCCOPY);
}

/*
 * void restorescreen([int x1, int y1, int x2, int y2, int xdest, int ydest])
 * 
 * Draw a buffered screen capture to the screen. The canvas
 * drawn is the first in the screen array. x1, x2 specify the bottom-
 * right corner of the screen, so that width = x2 - x1, etc.
 */
void restorescreen(CALL_DATA &params)
{
	extern std::vector<CCanvas *> g_cnvRpgScreens;
	extern CCanvas *g_cnvRpgCode;
	extern RECT g_screen;

	if (params.params != 0 && params.params != 6)
	{
		throw CError(_T("RestoreScreen() requires zero or six parameters."));
	}

	int xSrc = 0, ySrc = 0, 
		width = g_screen.right - g_screen.left, 
		height = g_screen.bottom - g_screen.top, 
		xDest = 0, yDest = 0;

	if (params.params == 6)
	{
		xSrc = int(params[0].getNum());
		ySrc = int(params[1].getNum());
		width = int(params[2].getNum()) - xSrc;
		height = int(params[3].getNum()) - ySrc;
		xDest = int(params[4].getNum());
		yDest = int(params[5].getNum());
	}
	
	if (g_cnvRpgScreens.size() && g_cnvRpgScreens.front())
	{
		// The first canvas exists.
		g_cnvRpgScreens.front()->BltPart(
			g_cnvRpgCode,
			xDest, yDest,
			xSrc, ySrc,
			width, height,
			SRCCOPY);
	}
	else throw CError(_T("RestoreScreen(): canvas not found."));

	renderRpgCodeScreen();
}

/*
 * void restorescreenarray(int pos [,int x1, int y1, int x2, int y2, int xdest, int ydest])
 * 
 * Draw a buffered screen capture to the screen. 
 * x1, x2 specify the bottom-right corner of the screen, 
 * so that width = x2 - x1, etc.
 */
void restorescreenarray(CALL_DATA &params)
{
	extern std::vector<CCanvas *> g_cnvRpgScreens;
	extern CCanvas *g_cnvRpgCode;

	if (params.params != 1 && params.params != 7)
	{
		throw CError(_T("RestoreScreen() requires one or seven parameters."));
	}

	const int i = int(params[0].getNum());
	if (i < g_cnvRpgScreens.size() && g_cnvRpgScreens[i])
	{
		// Temporarily switch the pointers for
		// RestoreScreen() to use the first.
		CCanvas *pCnv = g_cnvRpgScreens[0];
		g_cnvRpgScreens[0] = g_cnvRpgScreens[i];

		// Send the last 6 parameters to RestoreScreen();
		--params.params;
		++params.p;
		restorescreen(params);

		g_cnvRpgScreens[0] = pCnv;
	}
	else throw CError(_T("RestoreScreenArray(): canvas not found."));
}

/*
 * double sin(double x, [double &ret])
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
 * double cos(double x, [double &ret])
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
 * double tan(double x, [double &ret])
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
 * double sqrt(double x, [double &ret])
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
 * double log(double x, [double &ret])
 * 
 * Returns <b>n</b> such that <b>e</b><sup><b>n</b></sup> = <b>x</b>.
 */
void log(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Log() requires one or two parameters."));
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = log(params[0].getNum());
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void getPixel(int x, int y, int &r, int &g, int &b, [canvas cnv])
 * 
 * Get the colour of the pixel at (x, y).
 */
void getPixel(CALL_DATA &params)
{
	COLORREF color = 0;
	if (params.params == 5)
	{
		color = g_cnvRpgCode->GetPixel(params[0].getNum(), params[1].getNum());
	}
	else if (params.params == 6)
	{
		CCanvas *cnv = g_canvases.cast(int(params[5].getNum()));
		if (cnv)
		{
			color = cnv->GetPixel(params[0].getNum(), params[1].getNum());
		}
	}
	else
	{
		throw CError(_T("GetPixel() requires five or six parameters."));
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
 * void getColor(int &r, int &g, int &b)
 * 
 * Get the current colour.
 */
void getColor(CALL_DATA &params)
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
		throw CError(_T("GetColor() requires three parameters."));
	}
}

/*
 * int getFontSize([int &ret])
 * 
 * Get the current font size.
 */
void getFontSize(CALL_DATA &params)
{
	params.ret().udt = UDT_NUM;
	params.ret().num = double(g_fontSize);
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * void setImageTransparent(string file, int x, int y, int width, int height, int r, int g, int b, [canvas cnv])
 * 
 * Set an image with a transparent colour.
 */
void setImageTransparent(CALL_DATA &params)
{
	CCanvas *cnv = NULL;
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
		throw CError(_T("SetImageTransparent() requires eight or nine parameters."));
	}
	if (cnv)
	{
		extern STRING g_projectPath;
		CCanvas intermediate;
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
 * void setImageTranslucent(string file, int x, int y, int width, int height, [canvas cnv])
 * 
 * Set an image translucently.
 */
void setImageTranslucent(CALL_DATA &params)
{
	CCanvas *cnv = NULL;
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
		throw CError(_T("SetImageTransparent() requires five or six parameters."));
	}
	if (cnv)
	{
		extern STRING g_projectPath;
		CCanvas intermediate;
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
 * void drawEnemy(string file, int x, int y, [canvas cnv])
 * 
 * Draw an enemy.
 */
void drawEnemy(CALL_DATA &params)
{
	extern STRING g_projectPath;

	CCanvas *cnv = NULL;
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
		throw CError(_T("DrawEnemy() requires three or four parameters."));
	}
	ENEMY enemy;
	if (enemy.open(g_projectPath + ENE_PATH + params[0].getLit()))
	{
		CAnimation anm(enemy.gfx[EN_REST]);
		CCanvas *p = anm.getFrame(0);
		if (p) p->BltTransparent(cnv, int(params[1].getNum()), int(params[2].getNum()), TRANSP_COLOR);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
	}
}

/*
 * void layerput(int x, int y, int layer, string tile)
 * 
 * Place a tile on the board for the duration the player is on the board.
 */
void layerput(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern SCROLL_CACHE g_scrollCache;

	if (params.params != 4)
	{
		throw CError(_T("LayerPut() requires four parameters."));
	}
	
	// Instead of drawing onto the scrollcache (which seems quite
	// useless), enter the tile into the tile lookup table.
	const int x = int(params[0].getNum()), y = int(params[1].getNum()), z = int(params[2].getNum());
	if (!g_pBoard->insertTile(params[3].getLit(), x, y,	z))
	{
		throw CError(_T("LayerPut(): tile co-ordinates out of bounds."));
	}

	// Redraw the board at this location.
	g_pBoard->renderStack(g_scrollCache, x, y, 1, g_pBoard->sizeL);
    renderNow(g_cnvRpgCode, true);
    renderRpgCodeScreen();
}

/*
 * string getBoardTile(int x, int y, int z, [string &ret])
 * 
 * Get the file name of the tile at x, y, z.
 */
void getBoardTile(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if ((params.params != 3) && (params.params != 4))
	{
		throw CError(_T("GetBoardTile() requires three or four parameters."));
	}

	params.ret().udt = UDT_LIT;
	try
	{
		params.ret().lit = g_pBoard->tileIndex[g_pBoard->board[int(params[2].getNum())][int(params[1].getNum())][int(params[0].getNum())]];
	}
	catch (...)
	{
		throw CError(_T("Out of bounds."));
	}

	if (params.params == 4)
	{
		*params.prg->getVar(params[3].lit) = params.ret();
	}
}

/*
 * string getBoardTileType(int x, int y, int z[, string &ret])
 * 
 * Get the type of a tile.
 */
void getBoardTileType(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if ((params.params != 3) && (params.params != 4))
	{
		throw CError(_T("GetBoardTypeType() requires three or four parameters."));
	}

	// Get the vector that contains the tile.
	const BRD_VECTOR *p = g_pBoard->getVectorFromTile(
		int(params[0].getNum()),
		int(params[1].getNum()),
		int(params[2].getNum())
	);

	STRING type;
	if (!p)
	{
		type = _T("NORMAL");
	}
	else
	{
		// Convert the type to a string.
		switch (p->type)
		{
			case TT_NORMAL:
				type = _T("NORMAL");
				break;

			case TT_SOLID:
				type = _T("SOLID");
				break;

			case TT_UNDER:
				type = _T("UNDER");
				break;

			case NORTH_SOUTH:
				type = _T("NS");
				break;

			case EAST_WEST:
				type = _T("EW");
				break;

			case TT_STAIRS:
				char str[255]; itoa(p->attributes, str, 10);
				type = STRING(_T("STAIRS")) + str;
				break;
		}
	}

	params.ret().udt = UDT_LIT;
	params.ret().lit = type;

	if (params.params == 4)
	{
		*params.prg->getVar(params[3].lit) = params.ret();
	}
}

/*
 * void setImageAdditive(string file, int x, int y, int width, int height, double percent[, canvas cnv])
 * 
 * Set an image with a tint of the specified percent.
 */
void setimageadditive(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 6) && (params.params != 7))
	{
		throw CError(_T("SetImageAdditive() requires six or seven parameters."));
	}
	CCanvas *pTarget = g_cnvRpgCode;
	if (params.params == 7)
	{
		if (!(pTarget = g_canvases.cast(int(params[6].getNum()))))
		{
			pTarget = g_cnvRpgCode;
		}
	}

	const int w = int(params[3].getNum()), h = int(params[4].getNum());

	CCanvas cnv;
	cnv.CreateBlank(NULL, w, h, TRUE);

	CONST STRING strFile = g_projectPath + BMP_PATH + params[0].getLit();

	drawImage(strFile, &cnv, 0, 0, w, h);

	cnv.BltAdditivePart(pTarget->GetDXSurface(), int(params[1].getNum()), int(params[2].getNum()), 0, 0, w, h, params[5].getNum() / 100.0, -1, -1);

	if (pTarget == g_cnvRpgCode) renderRpgCodeScreen();
}

/*
 * int id = animation(string file, int x, int y [, bool loop])
 * 
 * Play an animation at pixel x,y. If animation() is called in a 
 * thread, it may be looped using the last parameter and returns
 * an id that can be used to end the animation.
 */
void animation(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 3) && (params.params != 4))
	{
		throw CError(_T("Animation() requires three or four parameters."));
	}

	if (params.prg->isThread())
	{
		// Multitask the animation.
		// TBD: update for pausethread?
		CThreadAnimation *p = CThreadAnimation::create(
			params[0].getLit(),
			int(params[1].getNum()), 
			int(params[2].getNum()),
			0, 0,
			(params.params == 4 ? params[3].getBool() : false));

		params.ret().udt = UDT_NUM;
		params.ret().num = int(p);
	}
	else
	{
		// Run the animation immediately.
		CAnimation anm(params[0].getLit());
		anm.render();
		anm.animate(int(params[1].getNum()), int(params[2].getNum()));
	}
}

/*
 * int id = sizedAnimation(string file, int x, int y, int height, int width [, bool loop])
 * 
 * Play a resized animation at pixel x,y. If sizedAnimation() is 
 * called  in a thread, it may be looped using the last parameter
 * and returns an id that can be used to end the animation.
 */
void sizedanimation(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 5) && (params.params != 6))
	{
		throw CError(_T("SizedAnimation() requires five or six parameters."));
	}

	if (params.prg->isThread())
	{
		// Multitask the animation.
		// TBD: update for pausethread?
		CThreadAnimation *p = CThreadAnimation::create(
			params[0].getLit(),
			int(params[1].getNum()), 
			int(params[2].getNum()), 
			int(params[3].getNum()), 
			int(params[4].getNum()),
			(params.params == 6 ? params[5].getBool() : false));

		params.ret().udt = UDT_NUM;
		params.ret().num = int(p);
	}
	else
	{
		// Run the animation immediately.
		CAnimation anm(params[0].getLit());
		anm.resize(int(params[3].getNum()), int(params[4].getNum()));
		anm.render();
		anm.animate(int(params[1].getNum()), int(params[2].getNum()));
	}

}

/*
 * endAnimation(int animationID)
 * 
 * End a multitasking animation.
 */
void endanimation(CALL_DATA &params)
{
	if (params.params == 1)
	{
		CThreadAnimation::destroy((CThreadAnimation *)int(params[0].getNum()));
	}
}

/*
 * itemstance(handle item, string stance [, int flags])
 * 
 * Animate an item's custom stance.
 *
 * Possible flags
 *		tkMV_PAUSE_THREAD:	Hold thread execution until animation ends.
 */
void itemstance(CALL_DATA &params)
{
	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("ItemStance() requires two or three parameters."));
	}

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemStance(): item not found"));

	const unsigned int flags = (params.params > 2 ? (unsigned int)params[2].getNum() : 0);

	p->customStance(params[1].getLit(), params.prg, flags & tkMV_PAUSE_THREAD);
}

/*
 * playerstance(handle player, string stance [, int flags])
 * 
 * Animate a player's custom stance.
 *
 * Possible flags
 *		tkMV_PAUSE_THREAD:	Hold thread execution until animation ends.
 */
void playerstance(CALL_DATA &params)
{
	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("PlayerStance() requires two or three parameters."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerStance(): player not found"));

	const unsigned int flags = (params.params > 2 ? (unsigned int)params[2].getNum() : 0);

	p->customStance(params[1].getLit(), params.prg, flags & tkMV_PAUSE_THREAD);
}

/*
 * posture(int id [, handle player])
 * 
 * Show a custom player animation named "Custom" + str(id) (e.g. "Custom1")
 * This command is obsolete - use playerStance() instead.
 */
void posture(CALL_DATA &params)
{
	extern CPlayer *g_pSelectedPlayer;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Posture() requires one or two parameters."));
	}

	CSprite *p = (params.params == 2 ? getPlayerPointer(params[1]) : g_pSelectedPlayer);
	if (!p) throw CError(_T("Posture(): player not found"));

	STRING str = _T("Custom");
	char ch[255]; itoa(params[0].getNum(), ch, 10);
	p->customStance(str + ch, params.prg, false);
}

/*
 * stance(int id [, handle player])
 * 
 * Show a player stance.
 * This command is obsolete - use playerStance() instead.
 */
void stance(CALL_DATA &params)
{
	throw CWarning(_T("Stance() is obsolete - use playerStance() instead."));
}

/*
 * void forceRedraw()
 * 
 * Force a redrawing of the screen.
 */
void forceRedraw(CALL_DATA &params)
{
	extern SCROLL_CACHE g_scrollCache;
	extern LPBOARD g_pBoard;
	if (g_pBoard->bLayerOccupied.size())
	{
		setAmbientLevel();
		g_scrollCache.render(true);
		renderNow(g_cnvRpgCode, true);
	}
	else
	{
		g_cnvRpgCode->ClearScreen(0);
	}
	renderRpgCodeScreen();
}

/*
 * void getRes(int &x, int &y)
 * 
 * Get the screen's resolution.
 */
void getRes(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("GetRes() requires two parameters."));
	}
	extern RECT g_screen;
	{
		LPSTACK_FRAME var = params.prg->getVar(params[0].lit);
		var->udt = UDT_NUM;
		var->num = g_screen.right - g_screen.left;
	}
	{
		LPSTACK_FRAME var = params.prg->getVar(params[1].lit);
		var->udt = UDT_NUM;
		var->num = g_screen.bottom - g_screen.top;
	}
}

/*
 * void staticText()
 * 
 * obsolete.
 */
void staticText(CALL_DATA &params)
{
	throw CError(_T("StaticText() is obsolete."));
}

/*
 * parallax(int setting)
 * 
 * obsolete.
 */
void parallax(CALL_DATA &params)
{
	throw CError(_T("Parallax() is obsolete."));
}

/*
 * void giveExp(string handle, int amount)
 * 
 * Give experience to a player.
 */
void giveexp(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("GiveExp() requires two parameters."));
	}

	CPlayer *p = getPlayerPointer(params[0]);
	if (p)
	{
		p->giveExperience(int(params[1].getNum()));
	}
}

/*
 * void animatedTiles()
 * 
 * Toggle animated tiles.
 */
void animatedTiles(CALL_DATA &params)
{
	throw CError(_T("AnimatedTiles() is obsolete."));
}

/*
 * void smartStep()
 * 
 * Toggle "smart" stepping.
 */
void smartStep(CALL_DATA &params)
{
	throw CError(_T("SmartStep() is obsolete."));
}

/*
 * thread thread(string file, bool persist, [thread &ret])
 * 
 * Start a thread.
 */
void thread(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("Thread() requires two or three parameters."));
	}
	CThread *p = CThread::create(params[0].getLit());
	if (!params[1].getBool())
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
 * void killThread(thread id)
 * 
 * Kill a thread.
 */
void killThread(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("KillThread() requires one parameter."));
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError(_T("Invalid thread ID for KillThread()."));
	}
	CThread::destroy(p); // Innocuous.
}

/*
 * thread getThreadId([thread &ret])
 * 
 * Get the ID of this thread.
 */
void getThreadId(CALL_DATA &params)
{
	if (!params.prg->isThread())
	{
		throw CError(_T("GetThreadID() is invalid outside of threads."));
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(int(params.prg));
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
	else if (params.params != 0)
	{
		throw CError(_T("GetThreadID() requires zero or one parameters."));
	}
}

/*
 * void threadSleep(thread id, double seconds)
 * 
 * Put a thread to sleep.
 */
void threadSleep(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("ThreadSleep() requires one parameter."));
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError(_T("Invalid thread ID for ThreadSleep()."));
	}
	p->sleep((unsigned long)(params[1].getNum() * 1000.0));
}

/*
 * variant tellThread(thread id, string code)
 * 
 * Execute code in the context of a thread (e.g., to run
 * a method located in another thread). TellThread() returns
 * the value returned by the function called in the thread.
 */
void tellThread(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("TellThread() requires two parameters."));
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError(_T("Invalid thread ID for TellThread()."));
	}

	CProgramChild prg(*p);
	prg.loadFromString(params[1].getLit());
	params.ret() = prg.run();
}

/*
 * void threadWake(thread id)
 * 
 * Wake up a thread.
 */
void threadWake(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("ThreadWake() requires one parameter."));
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError(_T("Invalid thread ID for ThreadWake()."));
	}
	p->wakeUp();
}

/*
 * double threadSleepRemaining(thread id, [double &ret])
 * 
 * Check how much sleep remains for a thread.
 */
void threadSleepRemaining(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("ThreadSleepRemaining() requires one or two parameters."));
	}
	CThread *p = (CThread *)int(params[0].getNum());
	if (!CThread::isThread(p))
	{
		throw CError(_T("Invalid thread ID for ThreadSleepRemaining()."));
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = p->sleepRemaining() / 1000.0;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * variant &local(variant &var, [variant &ret])
 * 
 * Allocates a variable off the stack and returns a reference to it.
 */
void local(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Local() requires one or two parameters."));
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
 * variant &global(variant &var, [variant &ret])
 * 
 * Allocates a variable on the heap and returns a reference to it.
 *
 * <pre>x = 1;
 * method func()
 * {
 *    local(x) = 2;
 *    mwin(global(x));
 *    mwin(x);
 * }</pre>
 *
 * Given the above code, the values of the message windows,
 * should func() be called, would be 1 and 2 respectively
 * because variables off the stack are preferred to ones
 * on the heap. The call to global() explictly requests
 * the variable <b>x</b> from the heap.
 */
void global(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Global() requires one or two parameters."));
	}
	CProgram::getGlobal(params[0].lit); // Allocates a var if it does not exist.
	params.ret().udt = UDT_ID;
	params.ret().lit = _T(":") + params[0].lit;
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void autoCommand()
 * 
 * Obsolete.
 */
void autoCommand(CALL_DATA &params)
{
	throw CWarning(_T("AutoCommand() is obsolete."));
}

/*
 * cursor_map createCursorMap([cursor_map &ret])
 * 
 * Create a cursor map.
 */
void createCursorMap(CALL_DATA &params)
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
		throw CError(_T("CreateCursorMap() requires zero or one parameters."));
	}
}

/*
 * void killCursorMap(cursor_map map)
 * 
 * Kill a cursor map.
 */
void killCursorMap(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("KillCursorMap() requires one parameter."));
	}
	g_cursorMaps.free((CCursorMap *)(int)params[0].getNum());
}

/*
 * void cursorMapAdd(int x, int y, cursor_map map)
 * 
 * Add a point to a cursor map.
 */
void cursorMapAdd(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("CursorMapAdd() requires three parameters."));
	}
	CCursorMap *p = g_cursorMaps.cast((int)params[2].getNum());
	if (p)
	{
		p->add(int(params[0].getNum()), int(params[1].getNum()));
	}
}

/*
 * int cursorMapRun(cursor_map map, [int &ret])
 * 
 * Run a cursor map.
 */
void cursorMapRun(CALL_DATA &params)
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
		throw CError(_T("CursorMapRun() requires one or two parameters."));
	}
}

/*
 * canvas createCanvas(int width, int height, [canvas &cnv])
 * 
 * Create a canvas.
 */
void createCanvas(CALL_DATA &params)
{
	if (params.params != 2 && params.params != 3)
	{
		throw CError(_T("CreateCanvas() requires two or three parameters."));
	}
	CCanvas *p = g_canvases.allocate();
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
 * void killCanvas(canvas cnv)
 * 
 * Kill a canvas.
 */
void killCanvas(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("KillCanvas() requires one parameter."));
	}
	CCanvas *p = (CCanvas *)(int)params[0].getNum();
	g_canvases.free(p);
}

/*
 * void drawCanvas(canvas cnv, int x, int y, [int width, int height, [canvas dest]])
 * 
 * Blit a canvas forward.
 */
void drawCanvas(CALL_DATA &params)
{
	if (params.params == 3)
	{
		CCanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->Blt(g_cnvRpgCode, params[1].getNum(), params[2].getNum());
			renderRpgCodeScreen();
		}
	}
	else if (params.params == 5)
	{
		CCanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			p->BltStretch(g_cnvRpgCode, params[1].getNum(), params[2].getNum(), 0, 0, p->GetWidth(), p->GetHeight(), params[3].getNum(), params[4].getNum(), SRCCOPY);
			renderRpgCodeScreen();
		}
	}
	else if (params.params == 6)
	{
		CCanvas *p = g_canvases.cast((int)params[0].getNum());
		if (p)
		{
			CCanvas *pDest = g_canvases.cast((int)params[5].getNum());
			if (pDest)
			{
				p->BltStretch(pDest, params[1].getNum(), params[2].getNum(), 0, 0, p->GetWidth(), p->GetHeight(), params[3].getNum(), params[4].getNum(), SRCCOPY);
			}
		}
	}
	else
	{
		throw CError(_T("DrawCanvas() requires three, five, or six parameters."));
	}
}

/*
 * 3.0.6 made exception for "Saved" directory outside of g_projectPath.
 */
STRING getFolderPath(STRING folder)
{
	extern STRING g_projectPath;
	return (_ftcsicmp(folder.c_str(), _T("Saved")) == 0 ? folder : g_projectPath + folder);
}

/*
 * void openFileInput(string file, string folder)
 * 
 * Open a file in input mode.
 */
void openFileInput(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("OpenFileInput() requires two parameters."));
	}
	CFile &file = g_files[parser::uppercase(params[0].getLit())];
	file.open(getFolderPath(params[1].getLit()) + _T('\\') + params[0].getLit(), OF_READ);
	if (!file.isOpen())
	{
		throw CError(_T("OpenFileInput(): file does not exist."));
	}
}

/*
 * void openFileOutput(string file, string folder)
 * 
 * Open a file in output mode.
 */
void openFileOutput(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("OpenFileOutput() requires two parameters."));
	}
	g_files[parser::uppercase(params[0].getLit())].open(getFolderPath(params[1].getLit()) + _T('\\') + params[0].getLit(), OF_CREATE | OF_WRITE);
}

/*
 * void openFileAppend(string file, string folder)
 * 
 * Open a file for appending.
 */
void openFileAppend(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("OpenFileOutput() requires two parameters."));
	}
	CFile &file = g_files[parser::uppercase(params[0].getLit())];
	CONST STRING filename = getFolderPath(params[1].getLit()) + _T('\\') + params[0].getLit();
	
	// Create the file if it doesn't exist.
	file.open(filename, OF_WRITE);
	if (!file.isOpen())
	{
		file.open(filename, OF_CREATE | OF_WRITE);
	}
	file.seek(file.size());
}

/*
 * void openFileBinary(string file, string folder)
 * 
 * Obsolete.
 */
void openFileBinary(CALL_DATA &params)
{
	CProgram::debugger(_T("OpenFileBinary() is obsolete. Use OpenFileInput() instead."));
	openFileInput(params);
}

/*
 * void closeFile(string file)
 * 
 * Close a file.
 */
void closeFile(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("CloseFile() requires one parameter."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (i != g_files.end())
	{
		g_files.erase(i);
	}
}

/*
 * string fileInput(string file, [string &ret])
 * 
 * Read a line from a line.
 */
void fileInput(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("FileInput() requires one or two parameters."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	params.ret().udt = UDT_LIT;
	params.ret().lit = i->second.line();
	params.ret().lit = params.ret().lit.substr(0, params.ret().lit.length() - 1);
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * void filePrint(string file, string line)
 * 
 * Write a line to a file.
 */
void filePrint(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("FilePrint() requires two parameters."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	const STRING str = params[1].getLit();
	for (STRING::const_iterator j = str.begin(); j != str.end(); ++j)
	{
		i->second << *j;
	}
	i->second << _T('\r') << _T('\n');
}

/*
 * string fileGet(string file, [string &ret])
 * 
 * Get a byte from a file.
 */
void fileGet(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("FileGet() requires one or two parameters."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
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
 * void filePut(string file, string byte)
 * 
 * Write a byte to a file.
 */
void filePut(CALL_DATA &params)
{
	if (params.params != 2)
	{
		throw CError(_T("FilePut() requires two parameters."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	i->second << params[1].getLit()[0];
}

/*
 * bool fileEof(string file, [bool &ret])
 * 
 * Check whether the end of a file has been reached.
 */
void fileEof(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("FileEOF() requires one or two parameters."));
	}
	std::map<STRING, CFile>::iterator i = g_files.find(parser::uppercase(params[0].getLit()));
	if (!((i != g_files.end()) && i->second.isOpen())) return;
	params.ret().udt = UDT_NUM;
	params.ret().num = double(i->second.isEof());
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * int len(string str[, int &ret])
 * 
 * Get the length of a string.
 */
void len(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Len() requires one or two parameters."));
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = params[0].getLit().length();
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * int inStr(string haystack, string needle[, int offset])
 * 
 * Returns the first occurence of needle within haystack,
 * optionally starting from an offset. Both the return
 * value and the offset are one-based.
 */
void instr(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("InStr() requires two or three parameters."));
	}

	const STRING haystack = params[0].getLit();
	unsigned int offset = (params.params == 3) ? (int(params[2].getNum()) - 1) : 0;
	if (offset < 0) offset = 0;

	const unsigned int pos = haystack.find(params[1].getLit(), offset) + 1;

	params.ret().udt = UDT_NUM;
	params.ret().num = double(pos);
}

/*
 * string getItemName(string fileName[, string &ret])
 * 
 * Get an item's handle.
 */
void getitemname(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("GetItemName() requires one or two parameters."));
	}

	const STRING file = g_projectPath + ITM_PATH + params[0].getLit();
	if (!CFile::fileExists(file)) return;

	ITEM itm;
	itm.open(file, NULL);

	params.ret().udt = UDT_LIT;
	params.ret().lit = itm.itemName;

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string getItemDesc(string fileName[, string &ret])
 * 
 * Get an item's description.
 */
void getitemdesc(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("GetItemDesc() requires one or two parameters."));
	}

	const STRING file = g_projectPath + ITM_PATH + params[0].getLit();
	if (!CFile::fileExists(file)) return;

	ITEM itm;
	itm.open(file, NULL);

	params.ret().udt = UDT_LIT;
	params.ret().lit = itm.itmDescription;

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * int getItemCost(string fileName[, int &ret])
 * 
 * Get an item's cost.
 */
void getitemcost(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("GetItemCost() requires one or two parameters."));
	}

	const STRING file = g_projectPath + ITM_PATH + params[0].getLit();
	if (!CFile::fileExists(file)) return;

	ITEM itm;
	itm.open(file, NULL);

	params.ret().udt = UDT_NUM;
	params.ret().num = itm.buyPrice;

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * int getItemSellPrice(string fileName[, int &ret])
 * 
 * Get the price for which an item sells.
 */
void getitemsellprice(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("GetItemSellPrice() requires one or two parameters."));
	}

	const STRING file = g_projectPath + ITM_PATH + params[0].getLit();
	if (!CFile::fileExists(file)) return;

	ITEM itm;
	itm.open(file, NULL);

	params.ret().udt = UDT_NUM;
	params.ret().num = itm.sellPrice;

	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string spliceVariables(string str)
 * 
 * Replaces substrings within angle brackets by the value of
 * variables with respective names.
 *
 * e.g. "&lt;x&gt;" would be replaced by the value of "x".
 */
void splicevariables(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError("SpliceVariables() requires one parameter.");
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = spliceVariables(params.prg, params[0].getLit());
}

/*
 * int split(string str, string delimiter, array arr)
 * 
 * Splits a string at a delimiter. Returns the number of
 * upper bound of the array (i.e. the index of the last
 * set element).
 */
void split(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("Split() requires three parameters."));
	}

	std::vector<STRING> parts;
	split(params[0].getLit(), params[1].getLit(), parts);

	// Strip '[]' off the array name.
	STRING array = params[2].lit;
	replace(array, _T("[]"), _T(""));

	if (params[2].udt & UDT_LIT)
	{
		// The array name was passed in quotes, so a $ or !
		// may have eluded the parser's stripping of them.
		char &c = array[array.length() - 1];
		if ((c == _T('$')) || (c == _T('!')))
		{
			array = array.substr(0, array.length() - 1);
		}
	}

	std::vector<STRING>::const_iterator i = parts.begin();
	for (unsigned int j = 0; i != parts.end(); ++i, ++j)
	{
		char str[255]; itoa(j, str, 10);
		LPSTACK_FRAME var = params.prg->getVar(array + _T('[') + str + _T(']'));
		var->udt = UDT_LIT;
		var->lit = *i;
	}

	params.ret().udt = UDT_NUM;
	params.ret().num = double(parts.size()) + 1.0;
}

/*
 * int asc(string chr[, int &ret])
 * 
 * Get the ASCII value of a character.
 */
void asc(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Asc() requires one or two parameters."));
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = (double)params[0].getLit()[0];
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string chr(int asc, [string &ret])
 * 
 * Get the character represented by the ASCII code passed in.
 */
void chr(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Chr() requires one or two parameters."));
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = (char)params[0].getNum();
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string trim(string str, [string &ret])
 * 
 * Trim whitespace from a string.
 */
void trim(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Trim() requires one or two parameters."));
	}
	params.ret().udt = UDT_LIT;
	params.ret().lit = parser::trim(params[0].getLit());
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string right(string str, int amount, [string &ret])
 * 
 * Get characters from the right of a string.
 */
void right(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("Right() requires two or three parameters."));
	}
	params.ret().udt = UDT_LIT;
	try
	{
		params.ret().lit = params[0].getLit().substr(params[0].getLit().length() - int(params[1].getNum()), int(params[1].getNum()));
	}
	catch (...) { }
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * string left(string str, int amount[, string &ret])
 * 
 * Get characters from the left of a string.
 */
void left(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("Left() requires two or three parameters."));
	}
	params.ret().udt = UDT_LIT;
	try
	{
		params.ret().lit = params[0].getLit().substr(0, int(params[1].getNum()));
	}
	catch (...) { }
	if (params.params == 3)
	{
		*params.prg->getVar(params[2].lit) = params.ret();
	}
}

/*
 * void cursorMapHand(string cursor[, bool stretch = true])
 * 
 * Change the cursor used everywhere cursors are used
 * (e.g. cursor maps, the menu, the battle system), optionally
 * not stretching it to 32 by 32 pixels.
 *
 * The string "default" restores the default image.
 */
void cursormaphand(CALL_DATA &params)
{
	extern STRING g_projectPath;
	extern CCanvas *g_cnvCursor;
	extern HINSTANCE g_hInstance;

	bool stretch = true;
	if (params.params == 2)
	{
		stretch = params[1].getBool();
	}
	else if (params.params != 1)
	{
		throw CError(_T("CursorMapHand() requires one or two parameters."));
	}

	STRING strFile = params[0].getLit();

	if (_tcsicmp(strFile.c_str(), _T("default")) == 0)
	{
		g_cnvCursor->Resize(NULL, 32, 32);

		const HDC hdc = g_cnvCursor->OpenDC();
		const HDC compat = CreateCompatibleDC(hdc);
		HBITMAP bmp = LoadBitmap(g_hInstance, MAKEINTRESOURCE(IDB_BITMAP1));
		HGDIOBJ obj = SelectObject(compat, bmp);
		BitBlt(hdc, 0, 0, 32, 32, compat, 0, 0, SRCCOPY);
		g_cnvCursor->CloseDC(hdc);
		SelectObject(compat, obj);
		DeleteObject(bmp);
		DeleteDC(compat);
		return;
	}

	strFile = g_projectPath + BMP_PATH + strFile;

	if (!stretch)
	{
		STRING prFile = getAsciiString(resolve(strFile)).c_str();

		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(prFile.c_str(), 16), prFile.c_str());

		if (bmp)
		{
			g_cnvCursor->Resize(NULL, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp));

			HDC hdc = g_cnvCursor->OpenDC();
			StretchDIBits(hdc, 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
			g_cnvCursor->CloseDC(hdc);

			FreeImage_Unload(bmp);
		}
	}
	else
	{
		g_cnvCursor->Resize(NULL, 32, 32);
		drawImage(strFile, g_cnvCursor, 0, 0, 32, 32);
	}
}

/*
 * void debugger(string message)
 * 
 * Show a debug message.
 */
void debugger(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("Debugger() requires one parameter."));
	}
	CProgram::debugger(params[0].getLit());
}

/*
 * void resumeNext()
 * 
 * Return to the statement after the statement where an error occurred.
 */
void resumeNext(CALL_DATA &params)
{
	if (params.params != 0)
	{
		throw CError(_T("ResumeNext() requires zero parameters."));
	}

	params.prg->resumeFromErrorHandler();
}

/*
 * int msgBox(string text [,string title [, int style [, int textColor [, int backColor [, string bitmap]]]]])
 * 
 * Display a message box containing one or two buttons, handled using
 * a cursor map (keyboard input only). 
 * The background is drawn translucently using the MWin() translucency value.
 * Any background image supplied is stretched to the size of the box.
 *
 * <ul><li>style = 0: 'OK' button; function returns 1.</li>
 * <li>style = 1: 'Yes' and 'No' buttons: 'Yes' returns 6 and 'No' returns 7.</li></ul>
 */
void msgbox(CALL_DATA &params)
{
	if (params.params < 1 || params.params > 6)
	{
		throw CError(_T("MsgBox() requires one to six parameters."));
	}

	STRING text = params[0].getLit();

	if (params.params > 1)
	{
		const STRING title = params[1].getLit();
		if (!title.empty()) text = title + _T('\n') + text;
	}
	int buttons = params.params > 2 ? (params[2].getBool() ? 2 : 1) : 1;
	const long textColor = params.params > 3 ? long(params[3].getNum()) : RGB(255, 255, 255);
	const long backColor = params.params > 4 ? long(params[4].getNum()) : 0;
	const STRING image = params.params > 5 ? params[5].getLit() : _T("");

	params.ret().udt = UDT_NUM;
	params.ret().num = rpgcodeMsgBox(text, buttons, textColor, backColor, image);
}

/*
 * setconstants(...)
 * 
 * Description.
 */
void setconstants(CALL_DATA &params)
{
	throw CError(_T("SetConstants() is obsolete."));
}

/*
 * void autoLocal(bool bEnabled)
 * 
 * Set the default scope for variable resolution. When autolocal()
 * is not enabled, variables are assumed to be global unless a local
 * variable has been defined. When autolocal() is enabled, variabes
 * are assumed to be local unless a global variable has been defined.
 *
 * Note that if autolocal() is enabled and variables that are not global
 * are referenced outside of any function, these variables are local to
 * the program. When the program ends, they will be deleted.
 */
void autolocal(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("AutoLocal() requires one parameter."));
	}
	params.prg->setDefaultScope(params[0].getBool() ? VS_LOCAL : VS_GLOBAL);
}

/*
 * string GetBoardName([string ret])
 * 
 * Get the current board's file name.
 */
void getBoardName(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	params.ret().udt = UDT_LIT;
	params.ret().lit = g_pBoard->filename;
	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * string lcase(string str, [string &ret])
 * 
 * Convert a string to lowercase.
 */
void lcase(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("LCase() requires one or two parameters."));
	}
	char *const str = _strlwr(_strdup(params[0].getLit().c_str()));
	params.ret().udt = UDT_LIT;
	params.ret().lit = str;
	free(str);
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string ucase(string str, [string &ret])
 * 
 * Convert a string to uppercase.
 */
void ucase(CALL_DATA &params)
{
	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("UCase() requires one or two parameters."));
	}
	char *const str = _strupr(_strdup(params[0].getLit().c_str()));
	params.ret().udt = UDT_LIT;
	params.ret().lit = str;
	free(str);
	if (params.params == 2)
	{
		*params.prg->getVar(params[1].lit) = params.ret();
	}
}

/*
 * string appPath([string &dest])
 * 
 * Retrieve the path of trans3.exe, without the final backslash.
 */
void apppath(CALL_DATA &params)
{
	extern HINSTANCE g_hInstance;

	TCHAR path[MAX_PATH];
	GetModuleFileName(g_hInstance, path, MAX_PATH);

	// Path is fully qualified, but we want only the directory.
	STRING strPath = path;
	strPath = strPath.substr(0, strPath.find_last_of(_T('\\')));

	params.ret().udt = UDT_LIT;
	params.ret().lit = strPath;

	if (params.params == 1)
	{
		*params.prg->getVar(params[0].lit) = params.ret();
	}
}

/*
 * string mid(string str, int start, int length[, string &dest])
 * 
 * Obtain a substring. The offset is one-based.
 */
void mid(CALL_DATA &params)
{
	if ((params.params != 3) && (params.params != 4))
	{
		throw CError(_T("Mid() requires three or four parameters."));
	}

	unsigned int start = int(params[1].getNum()) - 1;
	unsigned int length = int(params[2].getNum());

	params.ret().udt = UDT_LIT;
	params.ret().lit = params[0].getLit().substr(start, length);

	if (params.params == 4)
	{
		*params.prg->getVar(params[3].lit) = params.ret();
	}
}

/*
 * string replace(string str, string find, string replace[, string &dest])
 * 
 * Replace within a string.
 */
void replace(CALL_DATA &params)
{
	if ((params.params != 3) && (params.params != 4))
	{
		throw CError(_T("Replace() requires three or four parameters."));
	}

	STRING str = params[0].getLit();
	replace(str, params[1].getLit(), params[2].getLit());

	params.ret().udt = UDT_LIT;
	params.ret().lit = str;

	if (params.params == 4)
	{
		*params.prg->getVar(params[3].lit) = params.ret();
	}
}

/*
 * void rendernow(bool draw)
 * 
 * Controls rendering of the cnvRenderNow reserved canvas. The canvas
 * is drawn every frame above all board elements (e.g. tiles, sprites, animations).
 * Access the canvas by passing 'cnvRenderNow' to the drawing functions.
 * Do not call CreateCanvas() or KillCanvas() on cnvRenderNow.
 */
void rendernow(CALL_DATA &params)
{
	extern RENDER_OVERLAY g_renderNow;

	if (params.params != 1)
	{
		throw CError(_T("RenderNow() requires one parameter."));
	}

	g_renderNow.draw = params[0].getBool();	
}

/*
 * multirun()
 * 
 * Multirun()'s behaviour depends on the program's context.
 * In a thread: No action.<br />
 * In a program (non-thread): All sprite movements called
 * are queued up and movement begins after the closing brace
 * of the function, thereby allowing simultaneous movement.
 * Previously occurring movements are cleared.
 */
void multiRunBegin(CALL_DATA &params)
{
	extern ZO_VECTOR g_sprites;
	extern CPlayer *g_pSelectedPlayer;

	if (!params.prg->isThread())
	{
		g_multirunning = true;

		// Clear pending movements (TBD: do we really want to do this?)
		std::vector<CSprite *>::const_iterator i = g_sprites.v.begin();
		for (; i != g_sprites.v.end(); ++i)
		{
			(*i)->clearQueue();
		}
	}
}
void multiRunEnd(CProgram *prg)
{
	extern ZO_VECTOR g_sprites;
	extern CPlayer *g_pSelectedPlayer;

	g_multirunning = false;
	if (!prg->isThread())
	{
		// Run all sprite movements until all sprites have finished moving. 
		bool moving = true;
		while (moving)
		{
			moving = false;
			std::vector<CSprite *>::const_iterator i = g_sprites.v.begin();
			for (; i != g_sprites.v.end(); ++i)
			{
				if ((*i)->move(g_pSelectedPlayer, true)) moving = true;
			}
			renderNow(g_cnvRpgCode, true);
			renderRpgCodeScreen();
		}
	}
}

/*
 * shopcolors(int index, int r, int g, int b)
 * 
 * Set the colors used in CallShop(). This function is obsolete from 3.1.0.
 */
void shopcolors(CALL_DATA &params)
{
	throw CWarning(_T("ShopColors() is obsolete."));
}

/*
 * void mouseCursor(string file, int x, int y, int red, int green. int blue)
 * 
 * Change the mouse cursor. "TK DEFAULT" or "" restores
 * the default cursor.
 */
void mousecursor(CALL_DATA &params)
{
	extern MAIN_FILE g_mainFile;
	extern STRING g_projectPath;

	if (params.params != 6)
	{
		throw CError(_T("MouseCursor() requires six parameters."));
	}
	g_mainFile.hotSpotX = int(params[1].getNum());
	g_mainFile.hotSpotY = int(params[2].getNum());
	g_mainFile.transpColor = RGB(
		int(params[3].getNum()),
		int(params[4].getNum()),
		int(params[5].getNum())
	);
	const STRING ext = parser::uppercase(getExtension(params[0].getLit()).substr(0, 3));
	STRING tempFile;
	STRING file = params[0].getLit();
	if (file.empty()) file = _T("TK DEFAULT");
	if ((ext == _T("TST")) || (ext == _T("GPH")))
	{
		TILE_BITMAP tbm;
		tempFile = _T("mouse_cursor_tile_temp_bitmap_cursor_.tbm");
		tbm.resize(1, 1);
		tbm.tiles[0][0] = file;
		tbm.save(g_projectPath + BMP_PATH + tempFile);
		file = tempFile;
	}
	changeCursor(file);
	if (!tempFile.empty()) unlink(tempFile.c_str());
}

/*
 * int gettextwidth(string text)
 * 
 * Get the width of a string of text in pixels, 
 * relative to the current font and size.
 */
void gettextwidth(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("GetTextWidth() requires one parameter."));
	}

	CONST SIZE size = g_cnvRpgCode->GetTextSize(
		params[0].getLit(),
		g_fontFace,
		g_fontSize,
		g_bold,
		g_italic);

	params.ret().udt = UDT_NUM;
	params.ret().num = size.cx;
}

/*
 * int gettextheight(string text)
 * 
 * Get the height of a string of text in pixels, 
 * relative to the current font and size.
 */
void gettextheight(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("GetTextHeight() requires one parameter."));
	}

	CONST SIZE size = g_cnvRpgCode->GetTextSize(
		params[0].getLit(),
		g_fontFace,
		g_fontSize,
		g_bold,
		g_italic);

	params.ret().udt = UDT_NUM;
	params.ret().num = size.cy;
}

/*
 * iif(condition, true, false)
 * 
 * Obsolete. Use the tertiary operator result = (expression ? true part : false part)
 */
void iif(CALL_DATA &params)
{
	operators::tertiary(params);
	throw CWarning(_T("IIf() is obsolete. Use the ?: operator."));
}

/*
 * void drawCanvasTransparent(canvas cnv, int x, int y, int r, int g, int b[, int width, int height[, canvas dest]])
 * 
 * Blit a canvas forward, but don't blit one colour (the
 * transparent colour).
 */
void drawcanvastransparent(CALL_DATA &params)
{
	if ((params.params != 6) && (params.params != 8) && (params.params != 9))
	{
		throw CError(_T("DrawCanvasTransparent() requires six, eight, or nine parameters."));
	}
	CCanvas *pCanvas = g_canvases.cast(int(params[0].getNum()));
	if (!pCanvas) return;

	COLORREF colour = RGB(int(params[3].getNum()), int(params[4].getNum()), int(params[5].getNum()));
	CCanvas *pDest = (params.params == 9) ? g_canvases.cast(int(params[8].getNum())) : g_cnvRpgCode;
	if (!pDest) return;

	const int x = int(params[1].getNum());
	const int y = int(params[2].getNum());

	if (params.params > 6)
	{
		const int width = int(params[6].getNum());
		const int height = int(params[7].getNum());
		CCanvas temp;
		temp.CreateBlank(NULL, width, height, TRUE);
		pCanvas->BltStretch(
			&temp,
			0, 0,
			0, 0,
			pCanvas->GetWidth(), pCanvas->GetHeight(),
			width, height,
			SRCCOPY
		);
		temp.BltTransparent(pDest, x, y, colour);
	}
	else
	{
		pCanvas->BltTransparent(pDest, x, y, colour);
	}

	if (pDest == g_cnvRpgCode)
	{
		renderRpgCodeScreen();
	}
}

/*
 * int getTickCount()
 * 
 * Get the number of milliseconds since Windows started.
 */
void getTickCount(CALL_DATA &params)
{
	params.ret().udt = UDT_NUM;
	params.ret().num = GetTickCount();
}

/*
 * void setvolume(int percent)
 * 
 * Set the volume of all music and sound using a value between 0 and 100.
 */
void setvolume(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("SetVolume() requires one parameter."));
	}	
	CAudioSegment::setMasterVolume(int(params[0].getNum()));
}

/*
 * void canvasDrawPart(int cnv, int x, int y, int xSrc, int ySrc, int width, int height[, canvas cnvDest])
 *
 * Draw part of a canvas.
 */
void canvasDrawPart(CALL_DATA &params)
{
	if ((params.params != 7) && (params.params != 8))
	{
		throw CError(_T("CanvasDrawPart() requires seven or eight parameters."));
	}

	CCanvas *pDest = g_cnvRpgCode;
	if (params.params == 8)
	{
		pDest = g_canvases.cast(int(params[7].getNum()));
		if (!pDest) pDest = g_cnvRpgCode;
	}

	CCanvas *pSrc = g_canvases.cast(int(params[0].getNum()));
	if (!pSrc) return;

	pSrc->BltPart(pDest, int(params[1].getNum()), int(params[2].getNum()), int(params[3].getNum()), int(params[4].getNum()), int(params[5].getNum()), int(params[6].getNum()));
	if (pDest == g_cnvRpgCode)
	{
		renderRpgCodeScreen();
	}
}

/*
 * void canvasGetScreen(canvas cnvDest)
 *
 * Copy the screen onto a canvas.
 */
void canvasGetScreen(CALL_DATA &params)
{
	extern CDirectDraw *g_pDirectDraw;

	if (params.params != 1)
	{
		throw CError(_T("CanvasGetScreen() requires one parameter."));
	}

	CCanvas *pDest = g_canvases.cast(int(params[0].getNum()));
	if (!pDest) return;

	g_pDirectDraw->CopyScreenToCanvas(pDest);
}

/*
 * void setMwinTranslucency(int percent)
 * 
 * Set the translucency of the message window.<br />
 * 0% is invisible; 100% is opaque.
 */
void setmwintranslucency(CALL_DATA &params)
{
	extern MESSAGE_WINDOW g_mwin;

	if (params.params != 1)
	{
		throw CError(_T("SetMwinTranslucency() requires one parameter."));
	}
	g_mwin.translucency = params[0].getNum() / 100.0;
}

/*
 * string regExpReplace(string subject, string pattern, string replace)
 *
 * Replace using a regular expression.
 */
void regExpReplace(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("RegExpReplace() requires three parameters."));
	}

	// Create a RegExp object.
	IDispatch *pRegExp = NULL;
	HRESULT res = CoCreateInstance(CLSID_REGEXP, NULL, CLSCTX_INPROC_SERVER, IID_IDispatch, (void **)&pRegExp);

	if (FAILED(res))
	{
		throw CError(_T("RegExpReplace(): Internet Explorer 4 or higher is required for regular expression support."));
	}

	CComDispatchDriver regexp = pRegExp;
	pRegExp->Release();

	// Set to replace all instances, not just the first.
	CComVariant global(true);
	regexp.PutPropertyByName(L"Global", &global);

	// Set the pattern to be used.
	CComVariant pattern(params[1].getLit().c_str());
	regexp.PutPropertyByName(L"Pattern", &pattern);

	// Execute the replace.
	CComVariant search(params[0].getLit().c_str());
	CComVariant replace(params[2].getLit().c_str());
	CComVariant ret;
	regexp.Invoke2(L"Replace", &search, &replace, &ret);

	// Return the result.
	params.ret().udt = UDT_LIT;
	params.ret().lit = getString(ret.bstrVal);
}

/*
 * Common itempath/playerPath code.
 */
void spritepath(CALL_DATA &params, CSprite *p)
{
	extern LPBOARD g_pBoard;

	const unsigned int flags = (unsigned int)params[1].getNum();

	if (flags & tkMV_CLEAR_QUEUE) p->clearQueue();

	if (flags & tkMV_PATHFIND)
	{
		int x = int(params[2].getNum()), y = int(params[3].getNum());
		coords::tileToPixel(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);

		PF_PATH path = p->pathFind(x, y, PF_PREVIOUS, 0);
		if (!path.empty())
		{
			// Initiate movement by program type.
			p->setQueuedPath(path, flags & tkMV_CLEAR_QUEUE);
			p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
		}
	}
	else if (flags & (tkMV_WAYPOINT_PATH | tkMV_WAYPOINT_LINK))
	{
		const LPBRD_VECTOR brd = g_pBoard->getVector(&params[2]);
		const int cycles = int(params[3].getNum());

		if (!brd)
		{
			if (flags & tkMV_WAYPOINT_LINK) p->setBoardPath(NULL, 0, tkMV_WAYPOINT_LINK);
		}
		else
		{
			// Pathfind to start of vector.
			PF_PATH path = p->pathFind((*brd->pV)[0].x, (*brd->pV)[0].y, PF_PREVIOUS, 0);
			if (!path.empty())
			{
				// The last point is the same as the first of the waypoint vector.
				path.pop_back();
				p->setQueuedPath(path, flags & tkMV_CLEAR_QUEUE);
			}
			p->setBoardPath(brd->pV, cycles, flags);
			p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
		}
	}
	else
	{
		for (int i = 2; i < params.params; ++i)
		{
			int x = int(params[i].getNum()), y = int(params[++i].getNum());
			coords::tileToPixel(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);
			const DB_POINT pt = {double(x), double(y)};
			p->setQueuedPoint(pt, false);
		}
		p->doMovement(params.prg, flags & tkMV_PAUSE_THREAD);
	}
}

/*
 * void itemPath(variant handle, int flags, int x1, int y1, ... , int xn, int yn)
 * void itemPath(variant handle, int flags | tkMV_PATHFIND, int x1, int y1)
 * void itemPath(variant handle, int flags | tkMV_WAYPOINT_PATH, variant boardpath, int cycles)
 * void itemPath(variant handle, int flags | tkMV_WAYPOINT_LINK, variant boardpath, int cycles)
 *
 * Causes the sprite to walk a path between a given set of co-ordinates,
 * depending on the flags parameter. 'handle' must be a board index value
 * or 'target' or 'source', not the item's internal handle.
 *
 * <ol><li>Sprite walks the explicit path given by x1, y1 to xn, yn.<br />
 *		Required flag: none.</li>
 * <li>Sprite walks to x1, y1 via the shortest route (by pathfinding).<br />
 *		Required flag: tkMV_PATHFIND.</li>
 * <li>Sprite walks a board-set waypoint vector.<br />
 *		Required flag: tkMV_WAYPOINT_PATH.<br />
 *		The points of the vector are added to the sprite's queue.</li>
 * <li>A link is made between sprite and waypoint vector.<br />
 *		Required flag: tkMV_WAYPOINT_LINK.<br />
 *		Set cycles = 0 to walk infinitely.<br />
 *		Set boardpath = -1 to clear link to waypoint vector before cycles expires.<br />
 *      The sprite will resume the the path if other movement commands
 *		are given to it, after completion.</li></ol>
 *
 * Possible flags for all options:<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void itempath(CALL_DATA &params)
{
	if (params.params < 4)
		throw CError(_T("ItemPath() requires at least four parameters."));
	else if (params.params % 2)
		throw CError(_T("ItemPath() requires an even number of parameters."));

	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemPath(): item not found"));
	spritepath(params, p);
}

/*
 * void playerPath(variant handle, int flags, int x1, int y1, ... , int xn, int yn)
 * void playerPath(variant handle, int flags | tkMV_PATHFIND, int x1, int y1)
 * void playerPath(variant handle, int flags | tkMV_WAYPOINT_PATH, variant boardpath, int cycles)
 * void playerPath(variant handle, int flags | tkMV_WAYPOINT_LINK, variant boardpath, int cycles)
 *
 * Causes the sprite to walk a path between a given set of co-ordinates,
 * depending on the flags parameter.
 *
 * <ol><li>Sprite walks the explicit path given by x1, y1 to xn, yn.<br />
 *		Required flag: none.</li>
 * <li>Sprite walks to x1, y1 via the shortest route (by pathfinding).<br />
 *		Required flag: tkMV_PATHFIND.</li>
 * <li>Sprite walks a board-set waypoint vector.<br />
 *		Required flag: tkMV_WAYPOINT_PATH.<br />
 *		The points of the vector are added to the sprite's queue.</li>
 * <li>A link is made between sprite and waypoint vector.<br />
 *		Required flag: tkMV_WAYPOINT_LINK.<br />
 *		Set cycles = 0 to walk infinitely.<br />
 *		Set boardpath = -1 to clear link to waypoint vector before cycles expires.<br />
 *      The sprite will resume the the path if other movement commands
 *		are given to it, after completion.</li></ol>
 *
 * Possible flags for all options:<ul>
 *		<li>tkMV_PAUSE_THREAD:	Hold thread execution until movement ends.</li>
 *		<li>tkMV_CLEAR_QUEUE:	Clear any previously queued movements.</li></ul>
 */
void playerpath(CALL_DATA &params)
{
	if (params.params < 4)
		throw CError(_T("PlayerPath() requires at least four parameters."));
	else if (params.params % 2)
		throw CError(_T("PlayerPath() requires an even number of parameters."));

	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerPath(): player not found"));
	spritepath(params, p);
}

/* 
 * int boardGetVector()
 * void boardGetVector(variant vector, int &type, int &pointCount, int &layer, bool &isClosed, int &attributes)
 * 
 * <ol><li>Returns the number of vectors on the board.</li>
 * <li>Returns the properties of a given vector.</li></ol>
 */
void boardgetvector(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params == 0)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(g_pBoard->vectors.size());
		return;
	}

	if (params.params != 6)
	{
		throw CError(_T("BoardGetVector() requires six parameters."));
	}
	
	const LPBRD_VECTOR brd = g_pBoard->getVector(&params[0]);
	if (brd)
	{
		LPSTACK_FRAME pSf = NULL;
		const bool bClosed = brd->pV->closed();

		pSf = params.prg->getVar(params[1].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(brd->type);

		// The first point is added to the back of closed vectors.
		pSf = params.prg->getVar(params[2].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(brd->pV->size() - (bClosed ? 1 : 0));

		pSf = params.prg->getVar(params[3].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(brd->layer);

		pSf = params.prg->getVar(params[4].lit);
		pSf->udt = UDT_NUM;
		pSf->num = bClosed ? 1.0 : 0.0;

		pSf = params.prg->getVar(params[5].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(brd->attributes);
	}
}

/* 
 * void boardSetVector(variant vector, int type, int pointCount, int layer, bool isClosed, int attributes)
 *
 * Sets the properties of a given vector.
 * Creates a new vector if an existing one is not found - if a numeric variable
 * is supplied, it will be set to the new index (one-past-end).
 *
 * <ul><li>Possible types are:  tkVT_SOLID, tkVT_UNDER, tkVT_STAIRS, tkVT_WAYPOINT.</li>
 * <li>Possible attributes: tkVT_BKGIMAGE, tkVT_ALL_LAYERS_BELOW, tkVT_FRAME_INTERSECT.</li></ul>
 */
void boardsetvector(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (params.params != 6)
	{
		throw CError(_T("BoardSetVector() requires six parameters."));
	}

	LPBRD_VECTOR brd = g_pBoard->getVector(&params[0]);
	if (!brd)
	{
		// Create a new vector.
		g_pBoard->vectors.push_back(BRD_VECTOR());
		g_pBoard->vectors.back().pV = new CVector(0.0, 0.0);
		if (params[0].getType() & UDT_LIT)
			g_pBoard->vectors.back().handle = params[0].getLit();
		else
		{
			// Try to set the first parameter to the index.
			(*params.prg->getVar(params[0].lit)).udt = UDT_NUM;
			(*params.prg->getVar(params[0].lit)).num = g_pBoard->vectors.size() - 1;
		}
		brd = g_pBoard->getVector(&params[0]);
	}

	if (brd)
	{
		brd->pV->resize((unsigned int)params[2].getNum());
		brd->layer = int(params[3].getNum());
		brd->pV->close(params[4].getBool());
		brd->attributes = int(params[5].getNum());

		// Redraw the 'under' canvas.
		TILE_TYPE tt = TILE_TYPE(int(params[1].getNum()));
		if (~tt & TT_UNDER)
		{
			delete brd->pCnv;
			brd->pCnv = NULL;
		}
		brd->type = tt;
		if (tt & TT_UNDER) 
		{
			brd->createCanvas(*g_pBoard);
		}

		// Reset pathfinding as the collision landscape has changed.
		CPathFind::freeAllData();

		/* Unneeded: useful for debugging only.
#ifdef DEBUG_VECTORS
		extern SCROLL_CACHE g_scrollCache;
		g_scrollCache.render(true);
#endif 
		*/
	}
}

/* 
 * void boardGetVectorPoint(variant vector, int pointIndex, int &x, int &y)
 *
 * Get a single point on a board vector. x, y are always pixel values.
 */
void boardgetvectorpoint(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 4)
	{
		throw CError(_T("BoardGetVectorPoint() requires four parameters."));
	}
	
	const LPBRD_VECTOR brd = g_pBoard->getVector(&params[0]);
	if (brd)
	{
		const DB_POINT pt = (*brd->pV)[(unsigned int)params[1].getNum()];

		LPSTACK_FRAME pSf = NULL;
		pSf = params.prg->getVar(params[2].lit);
		pSf->udt = UDT_NUM;
		pSf->num = pt.x;

		pSf = params.prg->getVar(params[3].lit);
		pSf->udt = UDT_NUM;
		pSf->num = pt.y;
	}
}

/* 
 * void boardSetVectorPoint(variant vector, int pointIndex, int x, int y, bool apply)
 *
 * Set/move a single point on a board vector. x, y are always pixel values.
 * Set apply = true for last change, to improve speed.
 */
void boardsetvectorpoint(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (params.params != 5)
	{
		throw CError(_T("BoardSetVectorPoint() requires five parameters."));
	}
	
	LPBRD_VECTOR brd = g_pBoard->getVector(&params[0]);
	if (brd)
	{
		brd->pV->setPoint((unsigned int)params[1].getNum(), params[2].getNum(), params[3].getNum());
		if (params[4].getBool())
		{
			// Redraw the 'under' canvas.
			if (brd->type & TT_UNDER) brd->createCanvas(*g_pBoard);

			// Reset pathfinding as the collision landscape has changed.
			CPathFind::freeAllData();

			/* Unneeded: useful for debugging only.
#ifdef DEBUG_VECTORS
			extern SCROLL_CACHE g_scrollCache;
			g_scrollCache.render(true);
#endif		
			*/
		}
	}
}

/*
 * void boardGetProgram(int programIndex, string &program, int &pointCount, int &layer, bool &isClosed, int &attributes, int &distanceRepeat)
 * int boardGetProgram()
 *
 * <ol><li>Returns the properties of a given program.</li>
 * <li>Returns the number of programs on the board.</li></ol>
 */
void boardgetprogram(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params == 0)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(g_pBoard->programs.size());
		return;
	}

	if (params.params != 7)
	{
		throw CError(_T("BoardGetProgram() requires seven parameters."));
	}
	
	const LPBRD_PROGRAM prg = g_pBoard->getProgram((unsigned int)params[0].getNum());
	if (prg)
	{
		LPSTACK_FRAME pSf = NULL;
		const bool bClosed = prg->vBase.closed();

		pSf = params.prg->getVar(params[1].lit);
		pSf->udt = UDT_LIT;
		pSf->lit = prg->fileName;

		// The first point is added to the back of closed vectors.
		pSf = params.prg->getVar(params[2].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(prg->vBase.size() - (bClosed ? 1 : 0));

		pSf = params.prg->getVar(params[3].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(prg->layer);

		pSf = params.prg->getVar(params[4].lit);
		pSf->udt = UDT_NUM;
		pSf->num = bClosed ? 1.0 : 0.0;

		// PRG_STEP, PRG_KEYPRESS etc...
		pSf = params.prg->getVar(params[5].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(prg->activationType);

		pSf = params.prg->getVar(params[6].lit);
		pSf->udt = UDT_NUM;
		pSf->num = double(prg->distanceRepeat);
	}
}

/* 
 * void boardSetProgram(int programIndex, string program, int pointCount, int layer, bool isClosed, int attributes, int distanceRepeat)
 *
 * Sets the properties of a given program; creates a new program if one-past-the-end index is given.
 * Use val = boardGetProgram() to get the next index. 
 * distanceRepeat in pixels always.
 *
 * Possible flags: tkPRG_STEP, tkPRG_KEYPRESS, tkPRG_REPEAT, tkPRG_STOPS_MOVEMENT.
 */
void boardsetprogram(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 7)
	{
		throw CError(_T("BoardSetProgram() requires seven parameters."));
	}

	// If one-past-end index is given, create a new program.
	const unsigned int id = (unsigned int)params[0].getNum();
	if (id == g_pBoard->programs.size())
	{
		g_pBoard->programs.push_back(new BRD_PROGRAM());
		g_pBoard->programs.back()->vBase.push_back(0.0, 0.0);
	}

	LPBRD_PROGRAM prg = g_pBoard->getProgram(id);
	if (prg)
	{
		prg->fileName = params[1].getLit();
		prg->vBase.resize((unsigned int)params[2].getNum());
		prg->layer = int(params[3].getNum());
		prg->vBase.close(params[4].getBool());
		prg->activationType = int(params[5].getNum());
		prg->distanceRepeat = int(params[6].getNum());

		/* Unneeded: useful for debugging only.
#ifdef DEBUG_VECTORS
		extern SCROLL_CACHE g_scrollCache;
		g_scrollCache.render(true);
#endif	
		*/
	}
}

/* 
 * void boardGetProgramPoint(int programIndex, int pointIndex, int &x, int &y)
 *
 * Get a single point on a board program. x, y are always pixel values.
 */
void boardgetprogrampoint(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 4)
	{
		throw CError(_T("BoardGetProgramPoint() requires four parameters."));
	}
	
	const LPBRD_PROGRAM prg = g_pBoard->getProgram((unsigned int)params[0].getNum());
	if (prg)
	{
		const DB_POINT pt = prg->vBase[(unsigned int)params[1].getNum()];

		LPSTACK_FRAME pSf = NULL;
		pSf = params.prg->getVar(params[2].lit);
		pSf->udt = UDT_NUM;
		pSf->num = pt.x;

		pSf = params.prg->getVar(params[3].lit);
		pSf->udt = UDT_NUM;
		pSf->num = pt.y;
	}
}

/* 
 * void boardSetProgramPoint(int programIndex, int pointIndex, int x, int y)
 *
 * Set/move a single point on a board program. x, y are always pixel values.
 */
void boardsetprogrampoint(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 4)
	{
		throw CError(_T("BoardSetProgramPoint() requires four parameters."));
	}
	
	LPBRD_PROGRAM prg = g_pBoard->getProgram((unsigned int)params[0].getNum());
	if (prg)
	{
		prg->vBase.setPoint((unsigned int)params[1].getNum(), params[2].getNum(), params[3].getNum());

		/* Unneeded: useful for debugging only.
#ifdef DEBUG_VECTORS
		extern SCROLL_CACHE g_scrollCache;
		g_scrollCache.render(true);
#endif
		*/
	}
}

/* 
 * void setAmbientLevel(int red, int green, int blue)
 *
 * Set the global ambient level. Valid values range from -255 to + 255.
 */
void setambientlevel(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("SetAmbientLevel() requires three parameters."));
	}

	// Set the old RPGCode variables.
	LPSTACK_FRAME pVar = CProgram::getGlobal(_T("ambientred"));
	pVar->num = params[0].getNum();
	pVar->udt = UDT_NUM;
	pVar = CProgram::getGlobal(_T("ambientgreen"));
	pVar->num = params[1].getNum();
	pVar->udt = UDT_NUM;
	pVar = CProgram::getGlobal(_T("ambientblue"));
	pVar->num = params[2].getNum();
	pVar->udt = UDT_NUM;

	forceRedraw(params);
}

/*
 * int playerDirection(variant handle)
 * void playerDirection(variant handle, int dir)
 *
 * <ol><li>Returns the player direction.</li>
 * <li>Sets the player direction.</li></ol>
 *
 * Directions are assigned the following constants:<ul>
 * <li>East: tkDIR_E</li>
 * <li>Southeast: tkDIR_SE</li>
 * <li>South: tkDIR_S</li>
 * <li>Southwest: tkDIR_SW</li>
 * <li>West: tkDIR_W</li>
 * <li>Northwest: tkDIR_NW</li>
 * <li>North: tkDIR_N</li>
 * <li>Northeast: tkDIR_NE</li></ul>
 */
void playerdirection(CALL_DATA &params)
{
	if (params.params < 1 || params.params > 2)
	{
		throw CError(_T("PlayerDirection() requires one or two parameters."));
	}
	
	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerDirection(): player not found."));
	CSprite::CFacing *face = p->getFacing();

	if (params.params == 2)
	{
		const int dir = int(params[1].getNum());
		face->assign(dir < MV_MIN ? MV_MIN : (dir > MV_MAX ? MV_MAX : MV_ENUM(dir)));
		renderNow(g_cnvRpgCode, true);
		renderRpgCodeScreen();
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(face->dir());
}

/*
 * int itemDirection(variant handle)
 * void itemDirection(variant handle, int dir)
 *
 * <ol><li>Returns the item direction.</li>
 * <li>Sets the item direction.</li></ol>
 *
 * See playerDirection() for direction indices.
 */
void itemdirection(CALL_DATA &params)
{
	if (params.params < 1 || params.params > 2)
	{
		throw CError(_T("ItemDirection() requires one or two parameters."));
	}
	
	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemDirection(): player not found."));
	CSprite::CFacing *face = p->getFacing();

	if (params.params == 2)
	{
		const int dir = int(params[1].getNum());
		face->assign(dir < MV_MIN ? MV_MIN : (dir > MV_MAX ? MV_MAX : MV_ENUM(dir)));
		renderNow(g_cnvRpgCode, true);
		renderRpgCodeScreen();
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = double(face->dir());
}

void spritegetpath(const CSprite *spr, CALL_DATA &params)
{
	const SPRITE_POSITION pos = spr->getPosition();

	if (params.params == 1)
	{
		params.ret().udt = UDT_NUM;
		params.ret().num = double(pos.path.size());
	}
	else
	{
		const unsigned int i = (unsigned int)params[1].getNum();
		if (i < pos.path.size())
		{
			const DB_POINT pt = pos.path[i];
			LPSTACK_FRAME pSf = NULL;
			pSf = params.prg->getVar(params[2].lit);
			pSf->udt = UDT_NUM;
			pSf->num = floor(pt.x + 0.5);

			pSf = params.prg->getVar(params[3].lit);
			pSf->udt = UDT_NUM;
			pSf->num = floor(pt.y + 0.5);
		}
	}
}

/* 
 * int playerGetPath(variant handle)
 * void playerGetPath(variant handle, int index, int &x, int &y)
 *
 * <ol><li>Get the number of points in the sprite's path.</li>
 * <li>Get the coordinates of a point in the sprite's path.</li></ol>
 */
void playergetpath(CALL_DATA &params)
{
	if (params.params != 1 && params.params != 4)
	{
		throw CError(_T("PlayerGetPath() requires one or four parameters."));
	}
	
	CPlayer *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerGetPath(): player not found."));

	spritegetpath(p, params);
}

/* 
 * int itemGetPath(variant handle)
 * void itemGetPath(variant handle, int index, int &x, int &y)
 *
 * <ol><li>Get the number of points in the sprite's path.</li>
 * <li>Get the coordinates of a point in the sprite's path.</li></ol>
 */
void itemgetpath(CALL_DATA &params)
{
	if (params.params != 1 && params.params != 4)
	{
		throw CError(_T("ItemGetPath() requires one or four parameters."));
	}
	
	CItem *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemGetPath(): player not found."));

	spritegetpath(p, params);
}

/* 
 * void spriteTranslucency(int percent)
 * int spriteTranslucency(void)
 *
 * Set the degree to which sprites drawn underneath other objects are visible.
 * Specify a value between 0 (invisible) and 100 (opaque).
 */
void spriteTranslucency(CALL_DATA &params)
{
	if (params.params == 1)
	{
		g_spriteTranslucency = params[0].getNum() / 100.0;
	}
	params.ret().udt = UDT_NUM;
	params.ret().num = g_spriteTranslucency * 100.0;
}

/* 
 * void activePlayer(variant handle)
 * handle activePlayer(void)
 *
 * Set or get the active player, by handle.
 */
void activePlayer(CALL_DATA &params)
{
	extern int g_selectedPlayer;
	extern CPlayer *g_pSelectedPlayer;
	extern std::vector<CPlayer *> g_players;

	if (params.params == 1)
	{
		CPlayer *p = getPlayerPointer(params[0]);
		if (!p) throw CError(_T("activePlayer(): player not found."));

		g_pSelectedPlayer = p;
		for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); ++i)
		{
			if (*i == p) g_selectedPlayer = int(i - g_players.begin());
		}
	}

	params.ret().udt = UDT_LIT;
	params.ret().lit = g_pSelectedPlayer->name();
}

// Get a numerical stack frame.
inline STACK_FRAME makeNumStackFrame(const double num)
{
	STACK_FRAME ret;
	ret.num = num;
	ret.udt = UDT_NUM;
	return ret;
}

/*
 * Initialize RPGCode functions.
 */
void initRpgCode()
{
	// List of functions.
	CProgram::addFunction(_T("mwin"), mwin);
	CProgram::addFunction(_T("wait"), wait);
	CProgram::addFunction(_T("mwincls"), mwinCls);
	CProgram::addFunction(_T("send"), send);
	CProgram::addFunction(_T("text"), text);
	CProgram::addFunction(_T("pixeltext"), pixelText);
	CProgram::addFunction(_T("mbox"), mwin);
	CProgram::addFunction(_T("branch"), branch);
	CProgram::addFunction(_T("change"), change);
	CProgram::addFunction(_T("clear"), clear);
	CProgram::addFunction(_T("done"), done);
	CProgram::addFunction(_T("dos"), windows);
	CProgram::addFunction(_T("windows"), windows);
	CProgram::addFunction(_T("empty"), empty);
	CProgram::addFunction(_T("end"), end);
	CProgram::addFunction(_T("font"), font);
	CProgram::addFunction(_T("fontsize"), fontSize);
	CProgram::addFunction(_T("fade"), fade);
	CProgram::addFunction(_T("fbranch"), branch);
	CProgram::addFunction(_T("fight"), fight);
	CProgram::addFunction(_T("get"), get);
	CProgram::addFunction(_T("gone"), gone);
	CProgram::addFunction(_T("viewbrd"), viewbrd);
	CProgram::addFunction(_T("bold"), bold);
	CProgram::addFunction(_T("italics"), italics);
	CProgram::addFunction(_T("underline"), underline);
	CProgram::addFunction(_T("wingraphic"), winGraphic);
	CProgram::addFunction(_T("wincolor"), winColor);
	CProgram::addFunction(_T("wincolorrgb"), winColorRgb);
	CProgram::addFunction(_T("color"), color);
	CProgram::addFunction(_T("colorrgb"), colorRgb);
	CProgram::addFunction(_T("move"), move);
	CProgram::addFunction(_T("newplyr"), newPlayer);
	CProgram::addFunction(_T("newplayer"), newPlayer);
	CProgram::addFunction(_T("over"), over);
	CProgram::addFunction(_T("prg"), prg);
	CProgram::addFunction(_T("prompt"), prompt);
	CProgram::addFunction(_T("put"), put);
	CProgram::addFunction(_T("reset"), reset);
	CProgram::addFunction(_T("run"), run);
	CProgram::addFunction(_T("show"), mwin);
	CProgram::addFunction(_T("sound"), sound);
	CProgram::addFunction(_T("win"), win);
	CProgram::addFunction(_T("hp"), hp);
	CProgram::addFunction(_T("givehp"), giveHp);
	CProgram::addFunction(_T("gethp"), getHp);
	CProgram::addFunction(_T("maxhp"), maxHp);
	CProgram::addFunction(_T("getmaxhp"), getMaxHp);
	CProgram::addFunction(_T("smp"), smp);
	CProgram::addFunction(_T("givesmp"), giveSmp);
	CProgram::addFunction(_T("getsmp"), getSmp);
	CProgram::addFunction(_T("maxsmp"), maxSmp);
	CProgram::addFunction(_T("getmaxsmp"), getMaxSmp);
	CProgram::addFunction(_T("start"), start);
	CProgram::addFunction(_T("giveitem"), giveItem);
	CProgram::addFunction(_T("takeitem"), takeItem);
	CProgram::addFunction(_T("wav"), wav);
	CProgram::addFunction(_T("delay"), delay);
	CProgram::addFunction(_T("random"), random);
	CProgram::addFunction(_T("push"), push);
	CProgram::addFunction(_T("tiletype"), tileType);
	CProgram::addFunction(_T("midiplay"), mediaPlay);
	CProgram::addFunction(_T("playmidi"), mediaPlay);
	CProgram::addFunction(_T("mediaplay"), mediaPlay);
	CProgram::addFunction(_T("mediastop"), mediaStop);
	CProgram::addFunction(_T("mediarest"), mediaStop);
	CProgram::addFunction(_T("midirest"), mediaStop);
	CProgram::addFunction(_T("godos"), goDos);
	CProgram::addFunction(_T("addplayer"), addPlayer);
	CProgram::addFunction(_T("removeplayer"), removePlayer);
	CProgram::addFunction(_T("setpixel"), setPixel);
	CProgram::addFunction(_T("drawline"), drawLine);
	CProgram::addFunction(_T("drawrect"), drawRect);
	CProgram::addFunction(_T("fillrect"), fillRect);
	CProgram::addFunction(_T("debug"), debug);
	CProgram::addFunction(_T("castnum"), castNum);
	CProgram::addFunction(_T("castlit"), castLit);
	CProgram::addFunction(_T("castint"), castInt);
	CProgram::addFunction(_T("pushitem"), pushItem);
	CProgram::addFunction(_T("wander"), wander);
	CProgram::addFunction(_T("bitmap"), bitmap);
	CProgram::addFunction(_T("mainfile"), mainFile);
	CProgram::addFunction(_T("dirsav"), dirSav);
	CProgram::addFunction(_T("save"), save);
	CProgram::addFunction(_T("load"), load);
	CProgram::addFunction(_T("scan"), scan);
	CProgram::addFunction(_T("mem"), mem);
	CProgram::addFunction(_T("print"), print);
	CProgram::addFunction(_T("rpgcode"), rpgCode);
	CProgram::addFunction(_T("charat"), charAt);
	CProgram::addFunction(_T("equip"), equip);
	CProgram::addFunction(_T("remove"), remove);
	CProgram::addFunction(_T("putplayer"), putplayer);
	CProgram::addFunction(_T("eraseplayer"), eraseplayer);
	CProgram::addFunction(_T("kill"), kill);
	CProgram::addFunction(_T("givegp"), giveGp);
	CProgram::addFunction(_T("takegp"), takeGp);
	CProgram::addFunction(_T("getgp"), getGp);
	CProgram::addFunction(_T("wavstop"), wavstop);
	CProgram::addFunction(_T("bordercolor"), borderColor);
	CProgram::addFunction(_T("fightenemy"), fightEnemy);
	CProgram::addFunction(_T("restoreplayer"), restoreplayer);
	CProgram::addFunction(_T("callshop"), callshop);
	CProgram::addFunction(_T("clearbuffer"), clearBuffer);
	CProgram::addFunction(_T("attackall"), attackall);
	CProgram::addFunction(_T("drainall"), drainall);
	CProgram::addFunction(_T("inn"), inn);
	CProgram::addFunction(_T("targetlocation"), targetlocation);
	CProgram::addFunction(_T("eraseitem"), eraseitem);
	CProgram::addFunction(_T("putitem"), putitem);
	CProgram::addFunction(_T("createitem"), createitem);
	CProgram::addFunction(_T("destroyitem"), destroyitem);
	CProgram::addFunction(_T("walkspeed"), walkSpeed);
	CProgram::addFunction(_T("itemwalkspeed"), itemWalkSpeed);
	CProgram::addFunction(_T("posture"), posture);
	CProgram::addFunction(_T("setbutton"), setbutton);
	CProgram::addFunction(_T("checkbutton"), checkbutton);
	CProgram::addFunction(_T("clearbuttons"), clearbuttons);
	CProgram::addFunction(_T("mouseclick"), mouseclick);
	CProgram::addFunction(_T("mousemove"), mousemove);
	CProgram::addFunction(_T("zoom"), zoom);
	CProgram::addFunction(_T("earthquake"), earthquake);
	CProgram::addFunction(_T("itemcount"), itemcount);
	CProgram::addFunction(_T("destroyplayer"), destroyplayer);
	CProgram::addFunction(_T("callplayerswap"), callplayerswap);
	CProgram::addFunction(_T("playavi"), playavi);
	CProgram::addFunction(_T("playavismall"), playavismall);
	CProgram::addFunction(_T("getcorner"), getCorner);
	CProgram::addFunction(_T("underarrow"), underArrow);
	CProgram::addFunction(_T("getlevel"), getlevel);
	CProgram::addFunction(_T("ai"), ai);
	CProgram::addFunction(_T("menugraphic"), menugraphic);
	CProgram::addFunction(_T("fightmenugraphic"), fightMenuGraphic);
	CProgram::addFunction(_T("fightstyle"), fightStyle);
	CProgram::addFunction(_T("stance"), stance);
	CProgram::addFunction(_T("battlespeed"), battleSpeed);
	CProgram::addFunction(_T("textspeed"), textSpeed);
	CProgram::addFunction(_T("characterspeed"), characterSpeed);
	CProgram::addFunction(_T("mwinsize"), mwinsize);
	CProgram::addFunction(_T("getdp"), getDp);
	CProgram::addFunction(_T("getfp"), getFp);
	CProgram::addFunction(_T("internalmenu"), internalmenu);
	CProgram::addFunction(_T("applystatus"), applystatus);
	CProgram::addFunction(_T("removestatus"), removestatus);
	CProgram::addFunction(_T("setimage"), setImage);
	CProgram::addFunction(_T("drawcircle"), drawcircle);
	CProgram::addFunction(_T("fillcircle"), fillcircle);
	CProgram::addFunction(_T("savescreen"), savescreen);
	CProgram::addFunction(_T("restorescreen"), restorescreen);
	CProgram::addFunction(_T("sin"), sin);
	CProgram::addFunction(_T("cos"), cos);
	CProgram::addFunction(_T("tan"), tan);
	CProgram::addFunction(_T("getpixel"), getPixel);
	CProgram::addFunction(_T("getcolor"), getColor);
	CProgram::addFunction(_T("getfontsize"), getFontSize);
	CProgram::addFunction(_T("setimagetransparent"), setImageTransparent);
	CProgram::addFunction(_T("setimagetranslucent"), setImageTranslucent);
	CProgram::addFunction(_T("mp3"), wav);
	CProgram::addFunction(_T("sourcelocation"), sourcelocation);
	CProgram::addFunction(_T("targethandle"), targethandle);
	CProgram::addFunction(_T("sourcehandle"), sourcehandle);
	CProgram::addFunction(_T("drawenemy"), drawEnemy);
	CProgram::addFunction(_T("mp3pause"), mp3pause);
	CProgram::addFunction(_T("layerput"), layerput);
	CProgram::addFunction(_T("getboardtile"), getBoardTile);
	CProgram::addFunction(_T("boardgettile"), getBoardTile);
	CProgram::addFunction(_T("sqrt"), sqrt);
	CProgram::addFunction(_T("getboardtiletype"), getBoardTileType);
	CProgram::addFunction(_T("setimageadditive"), setimageadditive);
	CProgram::addFunction(_T("animation"), animation);
	CProgram::addFunction(_T("sizedanimation"), sizedanimation);
	CProgram::addFunction(_T("forceredraw"), forceRedraw);
	CProgram::addFunction(_T("itemlocation"), itemlocation);
	CProgram::addFunction(_T("wipe"), wipe);
	CProgram::addFunction(_T("getres"), getRes);
	CProgram::addFunction(_T("statictext"), staticText);
	CProgram::addFunction(_T("pathfind"), pathfind);
	CProgram::addFunction(_T("itemstep"), itemstep);
	CProgram::addFunction(_T("playerstep"), playerstep);
	CProgram::addFunction(_T("parallax"), parallax);
	CProgram::addFunction(_T("giveexp"), giveexp);
	CProgram::addFunction(_T("animatedtiles"), animatedTiles);
	CProgram::addFunction(_T("smartstep"), smartStep);
	CProgram::addFunction(_T("gamespeed"), gamespeed);
	CProgram::addFunction(_T("thread"), thread);
	CProgram::addFunction(_T("killthread"), killThread);
	CProgram::addFunction(_T("getthreadid"), getThreadId);
	CProgram::addFunction(_T("threadsleep"), threadSleep);
	CProgram::addFunction(_T("tellthread"), tellThread);
	CProgram::addFunction(_T("threadwake"), threadWake);
	CProgram::addFunction(_T("threadsleepremaining"), threadSleepRemaining);
	CProgram::addFunction(_T("local"), local);
	CProgram::addFunction(_T("global"), global);
	CProgram::addFunction(_T("autocommand"), autoCommand);
	CProgram::addFunction(_T("createcursormap"), createCursorMap);
	CProgram::addFunction(_T("killcursormap"), killCursorMap);
	CProgram::addFunction(_T("cursormapadd"), cursorMapAdd);
	CProgram::addFunction(_T("cursormaprun"), cursorMapRun);
	CProgram::addFunction(_T("createcanvas"), createCanvas);
	CProgram::addFunction(_T("killcanvas"), killCanvas);
	CProgram::addFunction(_T("drawcanvas"), drawCanvas);
	CProgram::addFunction(_T("openfileinput"), openFileInput);
	CProgram::addFunction(_T("openfileoutput"), openFileOutput);
	CProgram::addFunction(_T("openfileappend"), openFileAppend);
	CProgram::addFunction(_T("openfilebinary"), openFileBinary);
	CProgram::addFunction(_T("closefile"), closeFile);
	CProgram::addFunction(_T("fileinput"), fileInput);
	CProgram::addFunction(_T("fileprint"), filePrint);
	CProgram::addFunction(_T("fileget"), fileGet);
	CProgram::addFunction(_T("fileput"), filePut);
	CProgram::addFunction(_T("fileeof"), fileEof);
	CProgram::addFunction(_T("length"), len);
	CProgram::addFunction(_T("len"), len);
	CProgram::addFunction(_T("instr"), instr);
	CProgram::addFunction(_T("getitemname"), getitemname);
	CProgram::addFunction(_T("getitemdesc"), getitemdesc);
	CProgram::addFunction(_T("getitemcost"), getitemcost);
	CProgram::addFunction(_T("getitemsellprice"), getitemsellprice);
	CProgram::addFunction(_T("stop"), end);
	CProgram::addFunction(_T("restorescreenarray"), restorescreenarray);
	CProgram::addFunction(_T("restorearrayscreen"), restorescreenarray);
	CProgram::addFunction(_T("splicevariables"), splicevariables);
	CProgram::addFunction(_T("split"), split);
	CProgram::addFunction(_T("asc"), asc);
	CProgram::addFunction(_T("chr"), chr);
	CProgram::addFunction(_T("trim"), trim);
	CProgram::addFunction(_T("right"), right);
	CProgram::addFunction(_T("left"), left);
	CProgram::addFunction(_T("cursormaphand"), cursormaphand);
	CProgram::addFunction(_T("debugger"), debugger);
	CProgram::addFunction(_T("msgbox"), msgbox);
	CProgram::addFunction(_T("setconstants"), setconstants);
	CProgram::addFunction(_T("log"), log);
	CProgram::addFunction(_T("onboard"), onboard);
	CProgram::addFunction(_T("autolocal"), autolocal);
	CProgram::addFunction(_T("getboardname"), getBoardName);
	CProgram::addFunction(_T("pixelmovement"), pixelmovement);
	CProgram::addFunction(_T("lcase"), lcase);
	CProgram::addFunction(_T("ucase"), ucase);
	CProgram::addFunction(_T("apppath"), apppath);
	CProgram::addFunction(_T("mid"), mid);
	CProgram::addFunction(_T("replace"), replace);
	CProgram::addFunction(_T("endanimation"), endanimation);
	CProgram::addFunction(_T("rendernow"), rendernow);
	CProgram::addFunction(_T("multirun"), multiRunBegin);
	CProgram::addFunction(_T("shopcolors"), shopcolors);
	CProgram::addFunction(_T("itemspeed"), itemspeed);
	CProgram::addFunction(_T("playerspeed"), playerspeed);
	CProgram::addFunction(_T("mousecursor"), mousecursor);
	CProgram::addFunction(_T("gettextwidth"), gettextwidth);
	CProgram::addFunction(_T("gettextheight"), gettextheight);
	CProgram::addFunction(_T("iif"), iif);
	CProgram::addFunction(_T("itemstance"), itemstance);
	CProgram::addFunction(_T("playerstance"), playerstance);
	CProgram::addFunction(_T("drawcanvastransparent"), drawcanvastransparent);
	CProgram::addFunction(_T("gettickcount"), getTickCount);
	CProgram::addFunction(_T("setvolume"), setvolume);
	CProgram::addFunction(_T("setmwintranslucency"), setmwintranslucency);
	CProgram::addFunction(_T("regexpreplace"), regExpReplace);
	CProgram::addFunction(_T("playerlocation"), playerlocation);
	CProgram::addFunction(_T("canvasdrawpart"), canvasDrawPart);
	CProgram::addFunction(_T("canvasgetscreen"), canvasGetScreen);
	CProgram::addFunction(_T("setambientlevel"), setambientlevel);
	CProgram::addFunction(_T("spritetranslucency"), spriteTranslucency);
	CProgram::addFunction(_T("activeplayer"), activePlayer);

	// Vector movement functions.
	CProgram::addFunction(_T("itempath"), itempath);
	CProgram::addFunction(_T("playerpath"), playerpath);
	CProgram::addFunction(_T("itemgetpath"), itemgetpath);
	CProgram::addFunction(_T("playergetpath"), playergetpath);
	CProgram::addFunction(_T("playerdirection"), playerdirection);
	CProgram::addFunction(_T("itemdirection"), itemdirection);

	// Vector functions.
	CProgram::addFunction(_T("boardgetvector"), boardgetvector);
	CProgram::addFunction(_T("boardsetvector"), boardsetvector);
	CProgram::addFunction(_T("boardgetvectorpoint"), boardgetvectorpoint);
	CProgram::addFunction(_T("boardsetvectorpoint"), boardsetvectorpoint);
	CProgram::addFunction(_T("boardgetprogram"), boardgetprogram);
	CProgram::addFunction(_T("boardsetprogram"), boardsetprogram);
	CProgram::addFunction(_T("boardgetprogrampoint"), boardgetprogrampoint);
	CProgram::addFunction(_T("boardsetprogrampoint"), boardsetprogrampoint);

	// Movement constants.
	CProgram::addConstant(_T("tkMV_PAUSE_THREAD"), makeNumStackFrame(tkMV_PAUSE_THREAD));
	CProgram::addConstant(_T("tkMV_CLEAR_QUEUE"), makeNumStackFrame(tkMV_CLEAR_QUEUE));
	CProgram::addConstant(_T("tkMV_PATHFIND"), makeNumStackFrame(tkMV_PATHFIND));
	CProgram::addConstant(_T("tkMV_WAYPOINT_PATH"), makeNumStackFrame(tkMV_WAYPOINT_PATH));
	CProgram::addConstant(_T("tkMV_WAYPOINT_LINK"), makeNumStackFrame(tkMV_WAYPOINT_LINK));

	// Vector type constants/attributes.
	CProgram::addConstant(_T("tkVT_SOLID"), makeNumStackFrame(tkVT_SOLID));
	CProgram::addConstant(_T("tkVT_UNDER"), makeNumStackFrame(tkVT_UNDER));
	CProgram::addConstant(_T("tkVT_STAIRS"), makeNumStackFrame(tkVT_STAIRS));
	CProgram::addConstant(_T("tkVT_WAYPOINT"), makeNumStackFrame(tkVT_WAYPOINT));
	CProgram::addConstant(_T("tkVT_BKGIMAGE"), makeNumStackFrame(tkVT_BKGIMAGE));
	CProgram::addConstant(_T("tkVT_ALL_LAYERS_BELOW"), makeNumStackFrame(tkVT_ALL_LAYERS_BELOW));
	CProgram::addConstant(_T("tkVT_FRAME_INTERSECT"), makeNumStackFrame(tkVT_FRAME_INTERSECT));

	// Program-related board constants.
	CProgram::addConstant(_T("tkPRG_STEP"), makeNumStackFrame(tkPRG_STEP));
	CProgram::addConstant(_T("tkPRG_KEYPRESS"), makeNumStackFrame(tkPRG_KEYPRESS));
	CProgram::addConstant(_T("tkPRG_REPEAT"), makeNumStackFrame(tkPRG_REPEAT));
	CProgram::addConstant(_T("tkPRG_STOPS_MOVEMENT"), makeNumStackFrame(tkPRG_STOPS_MOVEMENT));

	// Direction constants.
	CProgram::addConstant(_T("tkDIR_E"),  makeNumStackFrame(MV_E));
	CProgram::addConstant(_T("tkDIR_SE"), makeNumStackFrame(MV_SE));
	CProgram::addConstant(_T("tkDIR_S"),  makeNumStackFrame(MV_S));
	CProgram::addConstant(_T("tkDIR_SW"), makeNumStackFrame(MV_SW));
	CProgram::addConstant(_T("tkDIR_W"),  makeNumStackFrame(MV_W));
	CProgram::addConstant(_T("tkDIR_NW"), makeNumStackFrame(MV_NW));
	CProgram::addConstant(_T("tkDIR_N"),  makeNumStackFrame(MV_N));
	CProgram::addConstant(_T("tkDIR_NE"), makeNumStackFrame(MV_NE));

	// Error handling.
	CProgram::addFunction(_T("resumeNext"), resumeNext);
	CProgram::addFunction(_T("setErrorHandler"), setErrorHandler);
	CProgram::addFunction(_T("setResumeNextHandler"), setResumeNextHandler);
}
