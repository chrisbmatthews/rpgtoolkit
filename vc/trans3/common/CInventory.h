/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CINVENTORY_H_
#define _CINVENTORY_H_

#include <map>
#include <string>
#include "item.h"
#include "../rpgcode/parser/parser.h"

class CInventory
{
public:
	typedef std::pair<std::string, unsigned int> DATA_PAIR, *LPDATA_PAIR;
	void give(const std::string file)
	{
		// file contains complete path.
		LPDATA_PAIR p = &m_data[parser::uppercase(file)];
		if (p->first.empty())
		{
			ITEM itm;
			SPRITE_ATTR attr;
			if (!itm.open(file, NULL)) return;
			p->first = itm.itemName;
			p->second = 1;
		}
		else
		{
			p->second++;
		}
	}
	unsigned int getQuantity(const std::string file)
	{
		LPDATA_PAIR p = &m_data[parser::uppercase(file)];
		if (p->first.empty()) return 0;
		return p->second;
	}
	std::string getHandle(const std::string file)
	{
		return m_data[parser::uppercase(file)].first;
	}
	bool take(const std::string file)
	{
		const std::string ucase = parser::uppercase(file);
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

	std::string getFileAt(const int i)
	{
		if (m_data.size() > i)
		{
			return at(i)->first;
		}
		return "";
	}
	std::string getHandleAt(const int i)
	{
		if (m_data.size() > i)
		{
			return at(i)->second.first;
		}
		return "";
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
	std::map<std::string, DATA_PAIR>::iterator at(const int j)
	{
		std::map<std::string, DATA_PAIR>::iterator i = m_data.begin();
		for (int k = 0; k < j; ++k, ++i);
		return i;
	}
	LPDATA_PAIR byHandle(const std::string file)
	{
		std::map<std::string, DATA_PAIR>::iterator i = m_data.begin();
		for(; i != m_data.end(); ++i)
		{
			if (file == i->second.first) break;
		}
		return (i == m_data.end() ? NULL : &i->second);
	}

	std::map<std::string, DATA_PAIR> m_data;
};

#endif
