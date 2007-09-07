/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

#ifndef _CALLOCATION_HEAP_H_
#define _CALLOCATION_HEAP_H_

#include <set>

// An allocation heap.
//////////////////////////////////////////////////
template <class T>
class CAllocationHeap
{
public:
	CAllocationHeap() { }
	T *allocate()
	{
		T *toRet = new T();
		m_contents.insert(toRet);
		return toRet;
	}
	bool free(T *const p)
	{
		std::set<T *>::iterator i = m_contents.find(p);
		if (i == m_contents.end()) return false;
		delete p;
		m_contents.erase(i);
		return true;
	}
	template <class _T>
	T *cast(const _T num)
	{
		T *p = (T *)num;
		if (m_contents.find(p) != m_contents.end()) return p;
		return NULL;
	}
	~CAllocationHeap()
	{
		std::set<T *>::const_iterator i = m_contents.begin();
		for (; i != m_contents.end(); ++i) delete *i;
	}
private:
	CAllocationHeap(CAllocationHeap &rhs);
	CAllocationHeap &operator=(CAllocationHeap &rhs);
	std::set<T *> m_contents;
};

#endif
