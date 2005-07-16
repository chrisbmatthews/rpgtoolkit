/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CITEM_H_
#define _CITEM_H_

#include "../../common/item.h"
#include "../CSprite/CSprite.h"

class CInvalidItem { };

class CItem : public CSprite
{
public:

	CItem(const std::string file, const bool show);

	CItem(const std::string file, const BRD_SPRITE spr);

	void open(const std::string file) throw(CInvalidItem);

private:
	ITEM m_itemMem;

};

#endif
