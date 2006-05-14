/*
 * All contents copyright 2006, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "CProgram.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../common/board.h"
#include <sstream>

// These classes cannot have any of their own members, as their
// deconstructors are never called.

// Virtual numerical variable.
class CVirtualNum : public tagStackFrame
{
public:
	double getNum() const { return *getPtr(); }
	STRING getLit() const;
	UNIT_DATA_TYPE getType() const { return UDT_NUM; }

private:
	double *getPtr() const { return (double *)tag; }
};

// Virtual literal variable.
class CVirtualLit : public tagStackFrame
{
public:
	double getNum() const { return atof(getPtr()->c_str()); }
	STRING getLit() const { return *getPtr(); }
	UNIT_DATA_TYPE getType() const { return UDT_LIT; }

private:
	STRING *getPtr() const { return (STRING *)tag; }
};

inline STRING getLit(const double num)
{
	// Just cast the number to a string.
	std::stringstream ss;
	ss << num;
	return ss.str();
}

STRING CVirtualNum::getLit() const
{
	return ::getLit(*getPtr());
}

std::pair<int, int> getPlayerLocation(int tag)
{
	extern std::vector<CPlayer *> g_players;
	extern LPBOARD g_pBoard;

	try
	{
		CPlayer *pPlayer = g_players[tag];
	}
	catch (...)
	{
		return std::pair<int, int>(0.0, 0.0);
	}

	const SPRITE_POSITION s = g_players[tag]->getPosition();

	// Transform from pixel to board type (e.g. tile).
	int dx = int(s.x), dy = int(s.y);
	coords::pixelToTile(dx, dy, g_pBoard->coordType, g_pBoard->bSizeX);

	return std::pair<int, int>(dx, dy);
}

// Reserved variable: int playerX[idx]
class CPlayerLocationX : public tagStackFrame
{
public:
	CPlayerLocationX(int idx) { tag = (void *)idx; }
	double getNum() const { return getPlayerLocation(int(tag)).first; }
	STRING getLit() const { return ::getLit(getNum()); }
	UNIT_DATA_TYPE getType() const { return UDT_NUM; }
};

// Reserved variable: int playerY[idx]
class CPlayerLocationY : public tagStackFrame
{
public:
	CPlayerLocationY(int idx) { tag = (void *)idx; }
	double getNum() const { return getPlayerLocation(int(tag)).second; }
	STRING getLit() const { return ::getLit(getNum()); }
	UNIT_DATA_TYPE getType() const { return UDT_NUM; }
};

/*
 * Set a virtual numerical variable.
 */
void setVirtualNum(const STRING name, double *pNum)
{
	CPtrData<STACK_FRAME> &pFrame = CProgram::getGlobal(name);
	pFrame = new CVirtualNum();
	pFrame->tag = pNum;
}

/*
 * Set a virtual literal variable.
 */
void setVirtualLit(const STRING name, STRING *pLit)
{
	CPtrData<STACK_FRAME> &pFrame = CProgram::getGlobal(name);
	pFrame = new CVirtualLit();
	pFrame->tag = pLit;
}

void initVirtualVars()
{
	for (int i = 0; i < 5; ++i)
	{
		CProgram::getGlobal("playerx[" + getLit(i) + "]") = new CPlayerLocationX(i);
		CProgram::getGlobal("playery[" + getLit(i) + "]") = new CPlayerLocationY(i);
	}
}
