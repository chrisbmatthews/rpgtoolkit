/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Colin James Fitzpatrick & Jonathan D. Hughes
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

#ifndef _CINVENTORY_H_
#define _CINVENTORY_H_

#include <map>
#include "item.h"
#include "../../tkCommon/strings.h"
#include "../rpgcode/parser/parser.h"

class CInventory
{
public:
	typedef std::pair<STRING, unsigned int> DATA_PAIR, *LPDATA_PAIR;
	void give(const STRING file, const int number = 1)
	{
		// file contains complete path.
		LPDATA_PAIR p = &m_data[parser::uppercase(removePath(file, ITM_PATH))];
		if (p->first.empty())
		{
			ITEM itm;
			if (!itm.open(file, NULL)) return;
			p->first = itm.itemName;
			p->second = number;
		}
		else
		{
			p->second += number;
		}
	}
	unsigned int getQuantity(const STRING file)
	{
		LPDATA_PAIR p = &m_data[parser::uppercase(removePath(file, ITM_PATH))];
		if (p->first.empty()) return 0;
		return p->second;
	}
	STRING getHandle(const STRING file)
	{
		return m_data[parser::uppercase(removePath(file, ITM_PATH))].first;
	}
	bool take(const STRING file)
	{
		const STRING ucase = parser::uppercase(removePath(file, ITM_PATH));
		int doneByHandle;
		doneByHandle = 0;

		LPDATA_PAIR p = &m_data[ucase];
		if (p->first.empty())
		{
			// Could be a handle.
			p = byHandle(removePath(file, ITM_PATH));
			doneByHandle = 1;
			if (!p) return false;
		}
		if (--p->second == 0)
		{
			if(doneByHandle==1){
				m_data.erase(fileByHandle(removePath(file, ITM_PATH)));
			}
			else{
				m_data.erase(ucase);
			}
		}
		return true;
	}
	void clear()
	{
		m_data.clear();
	}
	STRING fileAt(const int i)
	{
		return (m_data.size() > i ? at(i)->first : _T(""));
	}
	void fileAt(const int i, const STRING value)
	{
		// Problems changing the key since it is const in a map.
		if (m_data.size() > i)
		{
			std::map<STRING, DATA_PAIR>::iterator j = at(i);	
			DATA_PAIR p = j->second;
			m_data.erase(j);
			m_data[parser::uppercase(removePath(value, ITM_PATH))] = p;
		}
	}
	STRING handleAt(const int i)
	{
		return (m_data.size() > i ? at(i)->second.first : _T(""));
	}
	void handleAt(const int i, const STRING value)
	{
		if (m_data.size() > i) at(i)->second.first = value;
	}
	unsigned int quantityAt(const int i)
	{
		return (m_data.size() > i ? at(i)->second.second : 0);
	}
	void quantityAt(const int i, const unsigned int value)
	{
		if (m_data.size() > i) at(i)->second.second = value;
	}
	unsigned int size(void) const
	{
		return m_data.size();
	}
	STRING fileByHandle(const STRING file)
	{
		std::map<STRING, DATA_PAIR>::iterator i = m_data.begin();
		for(; i != m_data.end(); ++i)
		{
			if (file == i->second.first) break;
		}
		return (i == m_data.end() ? NULL : i->first);
	}
private:
	std::map<STRING, DATA_PAIR>::iterator at(const int j)
	{
		std::map<STRING, DATA_PAIR>::iterator i = m_data.begin();
		for (int k = 0; k < j; ++k, ++i);
		return i;
	}
	LPDATA_PAIR byHandle(const STRING file)
	{
		std::map<STRING, DATA_PAIR>::iterator i = m_data.begin();
		for(; i != m_data.end(); ++i)
		{
			if (file == i->second.first) break;
		}
		return (i == m_data.end() ? NULL : &i->second);
	}
	std::map<STRING, DATA_PAIR> m_data;
};

#endif
