/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#include "spcmove.h"
#include "mbox.h"
#include "CFile.h"

// Open a special move.
bool tagSpcMove::open(const STRING strFile)
{
	CFile file(strFile);

	if (!file.isOpen())
	{
		messageBox(_T("File not found: ") + strFile);
		return false;
	}

	file.seek(16);
	char check;
	file >> check;
	file.seek(0);

	if (!check)
	{
		std::string header;
		file >> header;
		if (header != _T("RPGTLKIT SPLMOVE"))
		{
			messageBox(_T("Invalid special move: ") + strFile);
			return false;
		}

		short majorVer, minorVer;
		file >> majorVer >> minorVer;

		file >> name;
		file >> fp;
		file >> smp;
		file >> prg;
		file >> targSmp;
		file >> battle;
		file >> menu;
		file >> status;
		file >> animation;
		file >> description;
		return true;
	}

	std::string header = file.line();
	if (header != _T("RPGTLKIT SPLMOVE"))
	{
		messageBox(_T("Invalid special move: ") + strFile);
		return false;
	}

	file.line(); // majorVer
	file.line(); // minorVer

	name = file.line();
	fp = _ttoi(file.line().c_str());
	smp = _ttoi(file.line().c_str());
	prg = file.line();
	targSmp = _ttoi(file.line().c_str());
	battle = _ttoi(file.line().c_str());
	menu = _ttoi(file.line().c_str());
	status = file.line();
	animation = file.line();
	description = file.line();

	return true;
}
