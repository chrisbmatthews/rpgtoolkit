/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
