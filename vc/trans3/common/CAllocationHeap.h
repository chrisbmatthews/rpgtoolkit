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
