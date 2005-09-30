/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CITEM_H_
#define _CITEM_H_

#include "../../common/item.h"
#include "../../rpgcode/CProgram.h"
#include "../CSprite/CSprite.h"

class CInvalidItem { };

class CItemThread;

class CItem : public CSprite
{
public:

	// Empty constructor.
	CItem(void): CSprite(false), m_pThread(NULL) {};

	// Default constructor.
	CItem(const std::string file, const bool show);

	// Board constructor.
	CItem(const std::string file, const BRD_SPRITE spr, short &version);

	// Open the item's file.
	short open(const std::string file) throw(CInvalidItem);

	~CItem();

private:
	ITEM m_itemMem;
	CItemThread *m_pThread;
};

class CItemThread : public CThread
{
public:
	static CItemThread *create(const std::string str, CItem *pItem);
	bool execute();
private:
	CItemThread(const std::string str): CThread(str) { }
	CItem *m_pItem;
};

#endif
