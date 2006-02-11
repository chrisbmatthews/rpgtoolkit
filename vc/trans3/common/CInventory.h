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
			m_data[parser::uppercase(value)] = p;
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
