/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CITEM_H_
#define _CITEM_H_

#include "../../common/item.h";
#include "../CSprite/CSprite.h"

class CItem : public CSprite
{
public:
	CItem();
	~CItem();

private:
	ITEM m_itemMem;

};

#endif
