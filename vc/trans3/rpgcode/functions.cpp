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
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../../tkCommon/strings.h"
#include "../input/input.h"
#include "../render/render.h"
#include "../audio/CAudioSegment.h"
#include "../common/animation.h"
#include "../common/board.h"
#include "../common/mainfile.h"
#include "../common/paths.h"
#include "../common/CAllocationHeap.h"
#include "../common/CInventory.h"
#include "../common/CFile.h"
#include "../common/mbox.h"
#include "../movement/locate.h"
#include "../movement/CSprite/CSprite.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/CPathFind/CPathFind.h"
#include "../images/FreeImage.h"
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
unsigned long g_mwinY = 0;					// MWin() y position.
STRING g_mwinBkg;						// MWin() background image.
COLORREF g_mwinColor = 0;					// Mwin() background colour.
CAllocationHeap<CCanvas> g_canvases;		// Allocated canvases.
CAllocationHeap<CCursorMap> g_cursorMaps;	// Cursor maps.
ENTITY g_target, g_source;					// Target and source.
CInventory g_inv;							// Inventory.
unsigned long g_gp = 0;						// Amount of gold.
std::map<STRING, CFile> g_files;		// Files opened using RPGCode.

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
		return dynamic_cast<CPlayer *>(getFighter(param.getLit()));
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
 * void mwin(string str)
 * 
 * Show the message window.
 */
void mwin(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("MWin() requires one parameter."));
	}
	extern CCanvas *g_cnvMessageWindow;
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
	params.ret().lit = waitForKey();
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
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
	g_mwinY = 0;
	renderRpgCodeScreen();
}

/*
 * void send(string file, int x, int y, [int z = 1])
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
			throw CError(_T("Send() requires three or four parameters."));
		}
		layer = params[3].getNum();
	}

	extern STRING g_projectPath;
	extern LPBOARD g_pBoard;
	g_pBoard->open(g_projectPath + BRD_PATH + params[0].getLit());

	unsigned int x = params[1].getNum(), y = params[2].getNum();

	/* Co-ordinate system stuff... */
	if (x > g_pBoard->bSizeX)
	{
		CProgram::debugger(_T("Send() location exceeds target board x-dimension."));
		x = g_pBoard->bSizeX;
	}
	if (x < 1)
	{
		CProgram::debugger(_T("Send() x location is less than one."));
		x = 1;
	}
	if (y > g_pBoard->bSizeY)
	{
		CProgram::debugger(_T("Send() location exceeds target board y-dimension."));
		y = g_pBoard->bSizeY;
	}
	if (y < 1)
	{
		CProgram::debugger(_T("Send() y location is less than one."));
		y = 1;
	}

	extern CSprite *g_pSelectedPlayer;

	g_pSelectedPlayer->setPosition(x, y, layer, g_pBoard->coordType);

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
		cnv->DrawText(params[0].getNum() * g_fontSize - g_fontSize, params[1].getNum() * g_fontSize - g_fontSize, params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
	}
	if (count == 3)
	{
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
		cnv->DrawText(int(params[0].getNum()), int(params[1].getNum()), params[2].getLit(), g_fontFace, g_fontSize, g_color, g_bold, g_italic, g_underline);
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
	params.prg->jump((params[0].lit[0] == _T(':')) ? params[0].lit : params[0].getLit());
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
 * Clear a surface.
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
 * Load a font, either true type or TK2.
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
 * void fade(int type)
 * 
 * Perform a fade using the current colour. There are several
 * different types of fades.
 *
 * 0 - the screen is blotted out by a growing and shrinking box
 * 1 - blots out with vertical lines
 * 2 - fades from white to black
 * 3 - line sweeps across the screen
 * 4 - black circle swallows the player
 * 5 - image fade to black
 */
void fade(CALL_DATA &params)
{
	extern RECT g_screen;

	const int type = (!params.params ? 0 : int(params[0].getNum())), 
			  width = g_cnvRpgCode->GetWidth(),
			  height = g_cnvRpgCode->GetHeight();
	
	// TBD: delays?

	// Colin:	This function is terrible -- just terrible.
	//			I was going to do something different, but I suppose
	//			I don't feel like it anymore.

	// I don't know why I fucking bother if that's your attitude.

	// If it's not terrible, how would you describe it? It takes
	// almost a minute for these fades to run and none of them is
	// actually a fade. It's CBM's fault, not yours; we shouldn't
	// have reproduced it exactly.

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
			extern CSprite *g_pSelectedPlayer;
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
	const STRING toRet = getName(chr);
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
 * void viewbrd(string filename [, int x, int y [, canvas cnv])
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
		pixelCoordinate(x, y, pBoard->coordType, false);
		if (pBoard->coordType == TILE_NORMAL)
		{
			// pixelCoordinate(,,,false) returns at top-left for 2D.
			x += 32;
			y += 32;
		}
	}

	pCnv->ClearScreen(pBoard->brdColor);
	pBoard->render(
		pCnv, 
		0, 0, 
		1, pBoard->bSizeL,
		x, y, 
		pCnv->GetWidth(), 
		pCnv->GetHeight(), 
		0, 0, 0); 
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
	if (params.params == 1)
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
	if (params.params != 1)
	{
		throw CError(_T("WinGraphic() requires one parameter."));
	}
	extern STRING g_projectPath;
	g_mwinBkg = g_projectPath + BMP_PATH + params[0].getLit();
	g_mwinColor = 0;
}

/*
 * void winColor(int dos)
 * 
 * Set the message window's colour using a DOS code.
 */
void winColor(CALL_DATA &params)
{
	if (params.params != 1)
	{
		throw CError(_T("WinColor() requires one parameter."));
	}
	g_mwinBkg = _T("");
	int color = int(params[0].getNum());
	if (color < 0) color = 0;
	else if (color > 255) color = 255;
	g_mwinColor = CTile::getDOSColor(color);
}

/*
 * void winColorRgb(int r, int g, int b)
 * 
 * Set the message window's colour.
 */
void winColorRgb(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("WinColorRGB() requires three parameters."));
	}
	g_mwinBkg = _T("");
	g_mwinColor = RGB(int(params[0].getNum()), int(params[1].getNum()), int(params[2].getNum()));
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
	pixelCoordinate(x, y, g_pBoard->coordType, false);
	if (g_pBoard->isIsometric() && !(g_pBoard->coordType & PX_ABSOLUTE))
	{
		// pixelCoordinate() returns the centrepoint of isometric tiles.
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
	pixelCoordinate(x, y, g_pBoard->coordType, false);
	if (g_pBoard->isIsometric() && !(g_pBoard->coordType & PX_ABSOLUTE))
	{
		// pixelCoordinate() returns the centrepoint of isometric tiles.
		// If PX_ABSOLUTE is not set, assume programs are tile-based and
		// require an additional offset.
		// These programs start on the left of the diamond (see board.cpp)
		x -= 32;
	}

	std::vector<LPBRD_PROGRAM>::iterator i = g_pBoard->programs.begin();
	for (; i != g_pBoard->programs.end(); ++i)
	{
		if (_tcsicmp((*i)->fileName.c_str(), params[0].getLit().c_str()) == 0)
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
 * Ask the player a question, and return the result.
 */
void prompt(CALL_DATA &params)
{

}

/*
 * void put(int x, int y, string tile)
 * 
 * Puts a tile at the specified location on the board.
 */
void put(CALL_DATA &params)
{
	if (params.params != 3)
	{
		throw CError(_T("Put() requires three parameters."));
	}
	// TBD: getAmbientLevel();
	drawTileCnv(g_cnvRpgCode, params[2].getLit(), params[0].getNum(), params[1].getNum(), 0, 0, 0, false, true, false, false);
	renderRpgCodeScreen();
}

/*
 * void reset()
 * 
 * Reset the game.
 */
void reset(CALL_DATA &params)
{

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

	if (g_mainFile.gameOverPrg.empty())
	{
		messageBox(_T("Game over."));
		reset(params);
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
	CAudioSegment::playSoundEffect(params[0].getLit());
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
	params.ret().udt = UDT_NUM;
	params.ret().num = (rand() % int(params[0].getNum())) + 1;
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
 */
void tileType(CALL_DATA &params)
{
	/* Better solution: regenerate vectors from tagBoard.tiletype */

	extern LPBOARD g_pBoard;

	#define NORTH_SOUTH 3
	#define EAST_WEST 4
	#define STAIRS1 11
	#define STAIRS8 18

	if (params.params != 3 && params.params != 4)
	{
		throw CError(_T("TileType() requires three or four parameters."));
	}

	const int x = int(params[0].getNum()), 
			  y = int(params[1].getNum()),
			  z = (params.params == 4 ? int(params[3].getNum()) : 1);

	const STRING type = params[2].getLit();
	int tile = TT_NORMAL;

	// "tile" to be recognised in tagBoard::vectorize()
	if (_ftcsicmp(type.c_str(), _T("SOLID")) == 0) tile = TT_SOLID;
	else if (_ftcsicmp(type.c_str(), _T("UNDER")) == 0) tile = TT_UNDER;
	else if (_ftcsicmp(type.substr(0, 6).c_str(), _T("STAIRS")) == 0)
	{
		tile = 10 + atoi(type.substr(6).c_str());
	}
	else if (_ftcsicmp(type.c_str(), _T("NS")) == 0) tile = NORTH_SOUTH;
	else if (_ftcsicmp(type.c_str(), _T("EW")) == 0) tile = EAST_WEST;

	// Enter the tiletype into the table.
	try
	{
		g_pBoard->tiletype[x][y][z] = tile;
	}
	catch (...)
	{
		throw CError(_T("TileType(): tile co-ordinates out of bounds."));
	}

	// Delete the vectors of this layer and re-generate.
	g_pBoard->freeVectors(z);
	g_pBoard->vectorize(z);
}

#if(0)
/*
 * Old method: vector brute force.
 *
 * Using vector collision, square vectors are added to the board with 
 * corresponding types. If an identical vector exists at the point,
 * alter its type rather than adding another.
 * Note: Overriding with "normal" may now not work as intended - users
 * should use vector tools instead.
 */
void tileType(CALL_DATA &params)
{
	// TBD: unidirectionals
	extern LPBOARD g_pBoard;

	if (params.params != 3 && params.params != 4)
	{
		throw CError(_T("TileType() requires three or four parameters."));
	}

	// Construct new vector. v.type defaults to TT_SOLID.
	BRD_VECTOR v;
	v.pV = new CVector();

	const STRING type = params[2].getLit();
	if (_ftcsicmp(type.c_str(), _T("NORMAL")) == 0) v.type = TT_N_OVERRIDE;
	else if (_ftcsicmp(type.c_str(), _T("UNDER")) == 0) v.type = TT_UNDER;
	else if (_ftcsicmp(type.substr(0, 6).c_str(), _T("STAIRS")) == 0)
	{
		v.type = TT_STAIRS;
		v.attributes = atoi(type.substr(6).c_str());
	}
	else if (_ftcsicmp(type.c_str(), _T("NS")) == 0) v.type = TT_UNIDIRECTIONAL;
	else if (_ftcsicmp(type.c_str(), _T("EW")) == 0) v.type = TT_UNIDIRECTIONAL;

	// Transform to pixel co-ordinates.
	int x = params[0].getNum(), y = params[1].getNum();
	pixelCoordinate(x, y, g_pBoard->coordType, false);

	if (g_pBoard->isIsometric())
	{
		// Isometric diamond. See tagBoard::vectorize() for order.
		DB_POINT p[] = {{x, y - 16}, {x - 32, y}, {x, y + 16}, {x + 32, y}};
		v.pV->push_back(p, 4);
	}
	else
	{
		// 2D square. See tagBoard::vectorize() for order.
		DB_POINT p[] = {{x, y}, {x, y + 32}, {x + 32, y + 32}, {x + 32, y}};
		v.pV->push_back(p, 4);
	}
	v.pV->close(true);
	v.layer = (params.params == 4 ? params[3].getNum() : 1);

	std::vector<BRD_VECTOR>::iterator i = g_pBoard->vectors.begin();
	for (; i != g_pBoard->vectors.end(); ++i)
	{
		if (i->layer != v.layer) continue;
		if (i->pV->compare(*v.pV))
		{
			// Found a matching vector.
			if (v.type == TT_N_OVERRIDE)
			{
				// Delete this vector.
				delete i->pV;
				delete i->pCnv;
				g_pBoard->vectors.erase(i);
			}
			else
			{
				i->type = v.type;
				i->attributes = v.attributes;
				if (v.type == TT_UNDER) i->createCanvas(*g_pBoard);
			}
			return;
		}
	}

	// Didn't find a match.
	g_pBoard->vectors.push_back(v);
	if (v.type == TT_UNDER) g_pBoard->vectors.back().createCanvas(*g_pBoard);
}
#endif

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
 * Toggle debug mode.
 */
void debug(CALL_DATA &params)
{

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
	extern CSprite *g_pSelectedPlayer;
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
	pixelCoordinate(x1, y1, g_pBoard->coordType, true);
	pixelCoordinate(x2, y2, g_pBoard->coordType, true);

	// Parameters. r is unneeded for tile pathfinding.
	const DB_POINT start = {x1, y1}, goal = {x2, y2};
	const RECT r = {0, 0, 0, 0};
	STRING s;

	// Pre C++, PathFind() was implemented axially only.
	CPathFind path;
	path.pathFind(start, goal, layer, r, PF_AXIAL, NULL); 
	std::vector<MV_ENUM> p = path.directionalPath();

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
 * void playerstep(string handle, int x, int y)
 * 
 * Causes the player to take one step in the direction of x, y
 * following a route determined by pathFind.
 */
void playerstep(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 3)
	{
		throw CError(_T("PlayerStep() requires three parameters."));
	}

	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PlayerStep(): player not found"));

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	pixelCoordinate(x, y, g_pBoard->coordType, true);

	PF_PATH path = p->pathFind(x, y, PF_AXIAL);
	if (!path.empty())
	{
		// Prune to the last element.
		path.front() = path.back();		
		path.resize(1);
		p->setQueuedPath(path);

		if (!params.prg->isThread())
		{
			// If not a thread, move now.
			p->runQueuedMovements();
		}
	}
}

/*
 * void itemstep(variant handle, int x, int y)
 * 
 * Causes the item to take one step in the direction of x, y
 * following a route determined by pathFind.
 */
void itemstep(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;

	if (params.params != 3)
	{
		throw CError(_T("ItemStep() requires three parameters."));
	}

	CSprite *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemStep(): item not found"));

	int x = int(params[1].getNum()), y = int(params[2].getNum());
	pixelCoordinate(x, y, g_pBoard->coordType, true);

	PF_PATH path = p->pathFind(x, y, PF_AXIAL);
	if (!path.empty())
	{
		// Prune to the last element.
		path.front() = path.back();		
		path.resize(1);
		p->setQueuedPath(path);

		if (!params.prg->isThread())
		{
			// If not a thread, move now.
			p->runQueuedMovements();
		}
	}
}

/*
 * void push(string direction[, string handle])
 * 
 * Push the player with the specified handle, or the default player
 * if no handle is specified, along the given directions. The direction
 * should be a comma delimited, but if it is not, it will be delimited
 * for backward compatibility. These styles are accepted, and can be
 * mixed even within the same directonal string:
 *
 * - N, S, E, W, NE, NW, SE, SW
 * - NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST
 * - 1, 2, 3, 4, 5, 6, 7, 8
 */
void push(CALL_DATA &params)
{
	extern CSprite *g_pSelectedPlayer;
	extern std::vector<CPlayer *> g_players;

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Push() requires one or two parameters."));
	}

	CSprite *p = NULL;

	if (params.params == 2)
	{
		p = getPlayerPointer(params[1]);
	}
	else
	{
		p = g_pSelectedPlayer;
	}
	if (!p) throw CError(_T("Push(): player not found"));

	// Backwards compatibility.
	STRING str = formatDirectionString(params[0].getLit());

	// Parse and set queued movements.
	p->parseQueuedMovements(str);

	if (!params.prg->isThread())
	{
		// If not a thread, move now.
		p->runQueuedMovements();
	}
}

/*
 * void pushItem(variant item, string direction)
 * 
 * The first parameter accepts either a string that can be either
 * "target" or "source" direction or the number of an item. The
 * syntax of the directional string is the same as for [[push()]].
 */
void pushItem(CALL_DATA &params)
{
	extern CSprite *g_pSelectedPlayer;

	if (params.params != 2)
	{
		throw CError(_T("PushItem() requires two parameters."));
	}

	CSprite *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("PushItem(): item not found"));

	// Backwards compatibility.
	STRING str = formatDirectionString(params[1].getLit());

	// Parse and set queued movements.
	p->parseQueuedMovements(str);

	if (!params.prg->isThread())
	{
		// If not a thread, move now.
		p->runQueuedMovements();
	}
}

/*
 * void wander(variant target, [int restrict = 0])
 * 
 * The first parameter accepts either a string that can be either
 * "target" or "source" or the number of an item. The selected item
 * will take a step in a random direction, or as restricted by the
 * optional parameter. The allowed values for said parameter are:
 *
 * 0 - only north, south, east, and west on normal boards, only
 *     diagonals on isometric boards (default)
 * 1 - only north, south, east, and west
 * 2 - only diagonals
 * 3 - all directions
 */
void wander(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern const double g_directions[2][9][2];

	if ((params.params != 1) && (params.params != 2))
	{
		throw CError(_T("Wander() requires one or two parameters."));
	}

	CSprite *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("Wander(): item not found"));

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

	int direction = 0;

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
	}

	DB_POINT d;
	p->getDestination(d);

	DB_POINT pt = {d.x + g_directions[isIso][direction][0] * 32, d.y + g_directions[isIso][direction][1] * 32};
	p->setQueuedPoint(pt);

	if (!params.prg->isThread())
	{
		// If not a thread, move now.
		p->runQueuedMovements();
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

	if (params.params != 1)
	{
		throw CError(_T("AddPlayer() requires one parameter."));
	}

	const STRING file = g_projectPath + TEM_PATH + params[0].getLit();

	if (CFile::fileExists(file))
	{
		CPlayer *p = new CPlayer(file, false);
		g_players.push_back(p);
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

	if (params.params != 4)
	{
		throw CError(_T("PutPlayer() requires four parameters."));
	}

	CSprite *p = getPlayerPointer(params[0]);
	if (!p) throw CError(_T("PutPlayer(): player not found"));

	p->setActive(true);
    p->setPosition(int(params[1].getNum()), 
		int(params[2].getNum()), 
		int(params[3].getNum()), 
		g_pBoard->coordType);

	// Insert the pointer into the z-ordered vector.
	g_sprites.zOrder();
    
	/** TBD: do not "auto align" ?
	p->alignBoard(g_screen, true); **/
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
 * void removePlayer(string handle)
 * 
 * Remove a player from the party to an old player list.
 */
void removePlayer(CALL_DATA &params)
{

}

/*
 * void newPlyr(string file)
 * 
 * Change the graphics of the main player to that of the
 * file passed in. The file can be a character file (*.tem)
 * or that of a tile (*.gph, *.tstxxx, *.tbm).
 */
void newPlyr(CALL_DATA &params)
{
	extern CSprite *g_pSelectedPlayer;
	extern STRING g_projectPath;

	if (params.params != 1)
	{
		throw CError(_T("newPlyr() requires one parameter."));
	}
	STRING ext = getExtension(params[0].getLit());

	if (_ftcsicmp(ext.c_str(), _T("TEM")) == 0)
	{
		// Load new sprite graphics from this character.
		CPlayer p(g_projectPath + TEM_PATH + params[0].getLit(), false);
		g_pSelectedPlayer->swapGraphics(&p);
	}
	else if (_ftcsicmp(ext.c_str(), _T("GPH")) == 0)
	{
		/** TBD: Construct anm... / depreciate **/
	}
	else if (_ftcsicmp(ext.substr(0, 3).c_str(), _T("TST")) == 0)
	{
		/** TBD: Construct anm... / not in 3.0.6 **/
	}
	else if (_ftcsicmp(ext.c_str(), _T("TBM")) == 0)
	{
		/** TBD: Construct anm... / not in 3.0.6 **/
	}
	else
	{
		throw CError(_T("newPlyr() requires a tem, tst or tbm file."));
	}
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
	 * and provide predictable behaviour, 3.0.7 must support both
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
	// a cosntant, load the item into that position.
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

	CSprite *p = getItemPointer(params[0]);
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
 */
void eraseitem(CALL_DATA &params)
{
	extern ZO_VECTOR g_sprites;

	if (params.params != 1)
	{
		throw CError(_T("EraseItem() requires one parameter."));
	}

	CSprite *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("EraseItem(): item not found"));

	// Remove the item from the z-ordered vector.
	g_sprites.remove(p);
	p->setActive(false);

	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
}

/*
 * void destroyitem(int slot)
 * 
 * Remove an item from memory.
 */
void destroyitem(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	extern ZO_VECTOR g_sprites;

	if (params.params != 1)
	{
		throw CError(_T("DestroyItem() requires one parameter."));
	}

	unsigned int i = (unsigned int)params[0].getNum();

	// Only accept slot numbers, not source or target handles.
	if (i < g_pBoard->items.size())
	{
		g_sprites.remove(g_pBoard->items[i]);
		delete g_pBoard->items[i];
		g_pBoard->items[i] = NULL;
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
	CSprite *p = getItemPointer(params[0]);
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
 * void itemlocation(int slot, int &x, int &y, int &layer)
 * 
 * Get the location of an item. Take board slot numbers only;
 * use SourceLocation() and TargetLocation() otherwise.
 */
void itemlocation(CALL_DATA &params)
{
	extern LPBOARD g_pBoard;
	/** TBD: Multitasking considerations **/

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

	const CSprite *p = getItemPointer(params[0]);
	if (!p) throw CError(_T("ItemLocation(): item not found"));

	const SPRITE_POSITION s = p->getPosition();

	// Transform from pixel to board type (e.g. tile).
	int dx = int(s.x), dy = int(s.y);
	tileCoordinate(dx, dy, g_pBoard->coordType);

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
	/** TBD: Multitasking considerations **/

	if (params.params != 2)
	{
		throw CError(_T("SourceLocation() requires two parameters."));
	}
	
	LPSTACK_FRAME x = params.prg->getVar(params[0].lit),
				  y = params.prg->getVar(params[1].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;

	int dx = 0, dy = 0;

	if (g_source.type == ET_ENEMY)
	{
		/** TBD: get enemy location. **/
	}
	else
	{
		// Player or item.
		/** TBD:
		if (fighting)
		{
			// Get location from plugin...
		}
		else
		**/
		{
			const CSprite *p = (CSprite *)g_source.p;
			const SPRITE_POSITION s = p->getPosition();
			dx = int(s.x);
			dy = int(s.y);
		}
	}
	// Transform from pixel to board type (e.g. tile).
	tileCoordinate(dx, dy, g_pBoard->coordType);
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
	/** TBD: Multitasking considerations **/

	if (params.params != 2)
	{
		throw CError(_T("TargetLocation() requires two parameters."));
	}
	
	LPSTACK_FRAME x = params.prg->getVar(params[0].lit),
				  y = params.prg->getVar(params[1].lit);
	x->udt = UDT_NUM;
	y->udt = UDT_NUM;

	int dx = 0, dy = 0;

	if (g_target.type == ET_ENEMY)
	{
		/** TBD: get enemy location. **/
	}
	else
	{
		// Player or item.
		/** TBD:
		if (fighting)
		{
			// Get location from plugin...
		}
		else
		**/
		{
			const CSprite *p = (CSprite *)g_target.p;
			const SPRITE_POSITION s = p->getPosition();
			dx = int(s.x);
			dy = int(s.y);
		}
	}
	// Transform from pixel to board type (e.g. tile).
	tileCoordinate(dx, dy, g_pBoard->coordType);
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
		CPlayer *p = (CPlayer *)g_source.p;
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
		str += itoa(i, c, 8);
	}
	else if (g_source.type == ET_ENEMY)
	{
		/** TBD: return enemy index... (?) 
		str = _T("ENEMY") + i; **/
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
		CPlayer *p = (CPlayer *)g_target.p;
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
		str += itoa(i, c, 8);
	}
	else if (g_target.type == ET_ENEMY)
	{
		/** TBD: return enemy index... (?) 
		str = _T("ENEMY") + i; **/
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

}

/*
 * string dirSav([string &ret])
 * 
 * Allow the user to choose a *.sav file from the "Saved"
 * directory. For historical reasons, returns "CANCEL" if
 * no file is chosen, not "".
 */
void dirSav(CALL_DATA &params)
{

}

/*
 * void save(string file)
 * 
 * Save the current game state to a file.
 */
void save(CALL_DATA &params)
{

}

/*
 * void load(string file)
 * 
 * Load the game state from a file.
 */
void load(CALL_DATA &params)
{

}

/*
 * void scan(int x, int y, int pos)
 * 
 * Save the tile specified to a buffer identified by
 * pos. There is no particular number to pick for pos;
 * any will do.
 * ** Flag for depreciation **
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
	pixelCoordinate(x, y, g_pBoard->coordType, false);

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
 * ** Flag for depreciation **
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
	pixelCoordinate(x, y, g_pBoard->coordType, false);

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
 * to [[text()]].
 */
void print(CALL_DATA &params)
{

}

/*
 * void rpgCode(string line)
 * 
 * Independently run a line of RPGCode.
 */
void rpgCode(CALL_DATA &params)
{
	if (params.params == 1)
	{
		CProgramChild prg(*params.prg);
		prg.loadFromString(params[0].getLit());
		prg.run();
	}
	else
	{
		throw CError(_T("RPGCode() requires one parameter."));
	}
}

/*
 * string charAt(string str, int pos, [string &ret])
 * 
 * Get a character from a string. The first character is one.
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
 * 1 - Head
 * 2 - Neck accessory
 * 3 - Right hand
 * 4 - Left hand
 * 5 - Body
 * 6 - Legs
 * 7+ - Custom accessories
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
 * wavstop(...)
 * 
 * Description.
 */
void wavstop(CALL_DATA &params)
{

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
 * void playAvi(string movie)
 * 
 * Play a movie full screen.
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

	CPlayer *pPlayer = dynamic_cast<CPlayer *>(getFighter(params[0].getLit()));
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
 * stance(...)
 * 
 * Description.
 */
void stance(CALL_DATA &params)
{

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
 * mwinsize(...)
 * 
 * Description.
 */
void mwinsize(CALL_DATA &params)
{

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
 * Show a menu using the menu plugin.
 * 0 - main menu
 * 1 - item menu
 * 2 - equip menu
 * 4 (sic) - abilities menu
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
 * Get the natural log of x.
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
 * Get the colour of the pixel at x, y.
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
		CCanvas c;
		c.CreateBlank(NULL, 1, 1, TRUE);
		renderAnimationFrame(&c, enemy.gfx[EN_REST], 0, 0, 0);
		c.BltTransparent(cnv, int(params[1].getNum()), int(params[2].getNum()), TRANSP_COLOR);
		if (cnv == g_cnvRpgCode)
		{
			renderRpgCodeScreen();
		}
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
	const int x = int(params[0].getNum()), 
			  y = int(params[1].getNum()),
			  l = int(params[2].getNum());
	const STRING tile = params[3].getLit();
	int index = 0;

	// Search the table for the tile.
	std::vector<STRING>::iterator i = g_pBoard->tileIndex.begin(),
									   j = i;
	for (; i != g_pBoard->tileIndex.end(); ++i)
	{
		if (_ftcsicmp(tile.c_str(), i->c_str()) == 0)
		{
			index = i - j;
			break;
		}
	}
	if (!index)
	{
		// Insert it onto the end.
		index = g_pBoard->tileIndex.size();
		g_pBoard->tileIndex.push_back(tile);
	}

	try
	{
		g_pBoard->board[x][y][l] = index;
		g_pBoard->bLayerOccupied[l] = true;
		g_pBoard->bLayerOccupied[0] = true;			// Any layer occupied.
	}
	catch (...)
	{
		throw CError(_T("LayerPut(): tile co-ordinates out of bounds."));
	}

	// Redraw the scrollcache.
	g_scrollCache.render(true);
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
		params.ret().lit = g_pBoard->tileIndex[g_pBoard->board[params[0].getNum()][params[1].getNum()][params[2].getNum()]];
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
			case TT_N_OVERRIDE:
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
 * void forceRedraw()
 * 
 * Force a redrawing of the screen.
 */
void forceRedraw(CALL_DATA &params)
{
	renderNow(g_cnvRpgCode, true);
	renderRpgCodeScreen();
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
 * Toggle antialiasing.
 */
void staticText(CALL_DATA &params)
{
	throw CError(_T("StaticText() is obsolete."));
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
 * thread thread(string file, bool presist, [thread &ret])
 * 
 * Start a thread.
 */
void thread(CALL_DATA &params)
{
	if ((params.params != 2) && (params.params != 3))
	{
		throw CError(_T("Thread() requires two or three parameters."));
	}
	extern STRING g_projectPath;
	const STRING file = g_projectPath + PRG_PATH + params[0].getLit();
	if (!CFile::fileExists(file))
	{
		throw CError(_T("Could not find ") + params[0].getLit() + _T(" for Thread()."));
	}
	CThread *p = CThread::create(file);
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
 * tellthread(...)
 * 
 * Description.
 */
void tellthread(CALL_DATA &params)
{

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
 * void openFileInput(string file, string folder)
 * 
 * Open a file in input mode.
 */
void openFileInput(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 2)
	{
		throw CError(_T("OpenFileInput() requires two parameters."));
	}
	g_files[parser::uppercase(params[0].getLit())].open(g_projectPath + params[1].getLit() + _T('\\') + params[0].getLit(), OF_READ);
}

/*
 * void openFileOutput(string file, string folder)
 * 
 * Open a file in output mode.
 */
void openFileOutput(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 2)
	{
		throw CError(_T("OpenFileOutput() requires two parameters."));
	}
	g_files[parser::uppercase(params[0].getLit())].open(g_projectPath + params[1].getLit() + _T('\\') + params[0].getLit(), OF_CREATE | OF_WRITE);
}

/*
 * void openFileAppend(string file, string folder)
 * 
 * Open a file for appending.
 */
void openFileAppend(CALL_DATA &params)
{
	extern STRING g_projectPath;

	if (params.params != 2)
	{
		throw CError(_T("OpenFileOutput() requires two parameters."));
	}
	CFile &file = g_files[parser::uppercase(params[0].getLit())];
	file.open(g_projectPath + params[1].getLit() + _T('\\') + params[0].getLit(), OF_WRITE);
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
		throw CError(_T("GetItemDesc() requires one or two parameters."));
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
		throw CError(_T("GetItemDesc() requires one or two parameters."));
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
 * splicevariables(...)
 * 
 * Description.
 */
void splicevariables(CALL_DATA &params)
{

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
		FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(getAsciiString(strFile).c_str(), 16), getAsciiString(strFile).c_str());

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
 * onError(label lbl)
 * 
 * Obsolete.
 */
void onError(CALL_DATA &params)
{
	throw CError(_T("OnError() is obsolete."));
}

/*
 * ResumeNext()
 * 
 * Obsolete.
 */
void resumeNext(CALL_DATA &params)
{
	throw CError(_T("ResumeNext() is obsolete."));
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
 * autolocal(...)
 * 
 * Description.
 */
void autolocal(CALL_DATA &params)
{

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
	params.ret().lit = g_pBoard->strFilename;
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
	operators::tertiary(params);
	throw CWarning(_T("IIf() is obsolete. Use the ?: operator."));
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
 * void setMwinTranslucency(int percent)
 * 
 * Set the translucency of the message window.
 * 0% is invisible; 100% is opaque.
 */
void setmwintranslucency(CALL_DATA &params)
{
	extern double g_messageWindowTranslucency;

	if (params.params != 1)
	{
		throw CError(_T("SetMwinTranslucency() requires one parameter."));
	}
	g_messageWindowTranslucency = params[0].getNum();
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
	CLSID clsid = {0x3F4DACA4, 0x160D, 0x11D2, {0xA8, 0xE9, 0x00, 0x10, 0x4B, 0x36, 0x5C, 0x9F}};
	HRESULT res = CoCreateInstance(clsid, NULL, CLSCTX_INPROC_SERVER, IID_IDispatch, (void **)&pRegExp);

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
 * Initialize RPGCode.
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
	CProgram::addFunction(_T("newplyr"), newPlyr);
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
	CProgram::addFunction(_T("redirect"), redirect);
	CProgram::addFunction(_T("killredirect"), killredirect);
	CProgram::addFunction(_T("killallredirects"), killallredirects);
	CProgram::addFunction(_T("parallax"), parallax);
	CProgram::addFunction(_T("giveexp"), giveexp);
	CProgram::addFunction(_T("animatedtiles"), animatedTiles);
	CProgram::addFunction(_T("smartstep"), smartStep);
	CProgram::addFunction(_T("gamespeed"), gamespeed);
	CProgram::addFunction(_T("thread"), thread);
	CProgram::addFunction(_T("killthread"), killThread);
	CProgram::addFunction(_T("getthreadid"), getThreadId);
	CProgram::addFunction(_T("threadsleep"), threadSleep);
	CProgram::addFunction(_T("tellthread"), tellthread);
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
	CProgram::addFunction(_T("onerror"), onError);
	CProgram::addFunction(_T("resumenext"), resumeNext);
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
	CProgram::addFunction(_T("multirun"), multirun);
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
	CProgram::addFunction(_T("createtimer"), createtimer);
	CProgram::addFunction(_T("killtimer"), killtimer);
	CProgram::addFunction(_T("setmwintranslucency"), setmwintranslucency);
	CProgram::addFunction(_T("regexpreplace"), regExpReplace);
}
