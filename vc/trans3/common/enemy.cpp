/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#include "CFile.h"
#include "paths.h"
#include "../misc/misc.h"
#include "../rpgcode/parser/parser.h"
#include "enemy.h"
#include "tilebitmap.h"
#include "animation.h"
#include "mbox.h"

bool tagEnemy::open(const STRING strFile)
{
	CFile file(strFile);
	if (!file.isOpen()) return false;

	file.seek(14);
	char c;
	file >> c;
	file.seek(0);
	if (!c)
	{
		STRING header;
		file >> header;
		if (header != _T("RPGTLKIT ENEMY"))
		{
			messageBox(_T("Unrecognised File Format! ") + strFile);
			return false;
		}
		short majorVer, minorVer;
		file >> majorVer >> minorVer;
		file >> strName;
		file >> iHp; iMaxHp = iHp;
		file >> iSmp; iMaxSmp = iSmp;
		file >> fp;
		file >> dp;
		file >> run;
		file >> takeCrit;
		file >> giveCrit;
		short count;
		file >> count;
		specials.clear();
		unsigned int i;
		for (i = 0; i <= count; i++)
		{
			STRING str;
			file >> str;
			specials.push_back(str);
		}
		file >> count;
		weaknesses.clear();
		for (i = 0; i <= count; i++)
		{
			STRING str;
			file >> str;
			weaknesses.push_back(str);
		}
		file >> count;
		strengths.clear();
		for (i = 0; i <= count; i++)
		{
			STRING str;
			file >> str;
			strengths.push_back(str);
		}
		file >> ai;
		file >> useCode;
		file >> prg;
		file >> exp;
		file >> gp;
		file >> winPrg;
		file >> runPrg;
		file >> count;
		gfx.clear();
		for (i = 0; i <= count; i++)
		{
			STRING str;
			file >> str;
			gfx.push_back(str);
		}
		file >> count;
		customAnims.clear();
		for (i = 0; i <= count; i++)
		{
			STRING str;
			file >> str;
			file >> customAnims[str];
		}
	}
	else
	{

		if (file.line() != _T("RPGTLKIT ENEMY"))
		{
			messageBox(_T("Unrecognised File Format! ") + strFile);
			return false;
		}

		const short majorVer = _ttoi(file.line().c_str());
		const short minorVer = _ttoi(file.line().c_str());

		strName = file.line();
		iMaxHp = iHp = _ttoi(file.line().c_str());
		iMaxSmp = iSmp = _ttoi(file.line().c_str());
		fp = _ttoi(file.line().c_str());
		dp = _ttoi(file.line().c_str());
		run = _ttoi(file.line().c_str());
		takeCrit = _ttoi(file.line().c_str());
		giveCrit = _ttoi(file.line().c_str());

		const int width = _ttoi(file.line().c_str());
		const int height = _ttoi(file.line().c_str());

		TILE_BITMAP tbm;
		tbm.resize(width, height);
		unsigned int i, j;
		for (i = 0; i < width; i++)
		{
			for (j = 0; j < height; j++)
			{
				tbm.tiles[i][j] = file.line();
			}
		}

		extern STRING g_projectPath;

		const STRING tbmFile = replace(removePath(strFile), _T('.'), _T('_')) + _T("_rest.tbm");
		tbm.save(g_projectPath + BMP_PATH + tbmFile);

		ANIMATION anm;
		anm.animSizeX = width * 32;
		anm.animSizeY = height * 32;
		anm.animPause = 0.167;
		anm.animFrame.push_back(tbmFile);
		anm.animTransp.push_back(RGB(255, 255, 255));
		anm.animSound.push_back(_T(""));
		anm.animFrames = 1;
		const STRING anmFile = replace(removePath(strFile), _T('.'), _T('_')) + _T("_rest.anm");
		anm.save(g_projectPath + MISC_PATH + anmFile);

		gfx.clear();
		gfx.push_back(anmFile);

		specials.clear();
		weaknesses.clear();
		for (i = 0; i < 101; i++)
		{
			specials.push_back(file.line());
			weaknesses.push_back(file.line());
		}

		ai = _ttoi(file.line().c_str());
		useCode = _ttoi(file.line().c_str());
		prg = file.line();
		exp = _ttoi(file.line().c_str());
		gp = _ttoi(file.line().c_str());
		winPrg = file.line();
		runPrg = file.line();

		file.line();
		file.line();
		file.line();
		file.line();

		gfx.push_back(file.line());
		gfx.push_back(file.line());
		gfx.push_back(file.line());
		gfx.push_back(file.line());

		customAnims.clear();

	}

	return true;
}

STRING tagEnemy::getStanceAnimation(const STRING anim)
{
	const STRING stance = anim.empty() ? _T("REST") : parser::uppercase(anim);
	if (stance == _T("FIGHT") || stance == _T("ATTACK"))
	{
		return gfx[EN_FIGHT];
	}
	else if (stance == _T("DEFEND"))
	{
		return gfx[EN_DEFEND];
	}
	else if (stance == _T("SPC") || stance == _T("SPECIAL MOVE"))
	{
		return gfx[EN_SPECIAL];
	}
	else if (stance == _T("DIE"))
	{
		return gfx[EN_DIE];
	}
	else if (stance == _T("REST"))
	{
		return gfx[EN_REST];
	}
	if (customAnims.count(stance))
	{
		return customAnims[stance];
	}
	return _T("");
}
