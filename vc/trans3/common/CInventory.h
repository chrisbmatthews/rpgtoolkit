/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
		LPDATA_PAIR p = &m_data[parser::uppercase(file)];
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
		LPDATA_PAIR p = &m_data[parser::uppercase(file)];
		if (p->first.empty()) return 0;
		return p->second;
	}
	STRING getHandle(const STRING file)
	{
		return m_data[parser::uppercase(file)].first;
	}
	bool take(const STRING file)
	{
		const STRING ucase = parser::uppercase(file);
		LPDATA_PAIR p = &m_data[ucase];
		if (p->first.empty())
		{
			// Could be a handle.
			p = byHandle(file);
			if (!p) return false;
		}
		if (--p->second == 0)
		{
			m_data.erase(ucase);
		}
		return true;
	}
	void clear()
	{
		m_data.clear();
	}

	STRING getFileAt(const int i)
	{
		if (m_data.size() > i)
		{
			return at(i)->first;
		}
		return _T("");
	}
	STRING getHandleAt(const int i)
	{
		if (m_data.size() > i)
		{
			return at(i)->second.first;
		}
		return _T("");
	}
	unsigned int getQuantityAt(const int i)
	{
		if (m_data.size() > i)
		{
			return at(i)->second.second;
		}
		return 0;
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
