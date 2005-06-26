/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CALLOCATION_HEAP_H_
#define _CALLOCATION_HEAP_H_

#include <vector>

// An allocation heap.
//////////////////////////////////////////////////
template <class T>
class CAllocationHeap
{
public:
	CAllocationHeap(void) { }
	T *allocate(void)
	{
		T *toRet = new T();
		m_contents.push_back(toRet);
		return toRet;
	}
	bool free(T *const p)
	{
		std::vector<T *>::iterator i = m_contents.begin();
		for (; i != m_contents.end(); ++i) 
		{
			if ((*i) == p)
			{
				delete *i;
				m_contents.erase(i);
				return true;
			}
		}
		return false;
	}
	template <class _T>
	T *cast(const _T num)
	{
		T *toRet = (T *)num;
		std::vector<T *>::iterator i = m_contents.begin();
		for (; i != m_contents.end(); ++i) 
		{
			if ((*i) == toRet)
			{
				return toRet;
			}
		}
		return NULL;
	}
	~CAllocationHeap(void)
	{
		std::vector<T *>::iterator i = m_contents.begin();
		for (; i != m_contents.end(); ++i) delete *i;
	}
private:
	CAllocationHeap(CAllocationHeap &rhs);
	CAllocationHeap &operator=(CAllocationHeap &rhs);
	std::vector<T *> m_contents;
};

#endif
