/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Jonathan D. Hughes
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

#ifndef _CSHOP_H_
#define _CSHOP_H_

#include "../../tkCommon/strings.h"
#include "item.h"
#include <map>

class CCanvas;
class CCursorMap;
class CInventory;

class CShop 
{
public:
	CShop(CInventory *shopInv, CInventory *playerInv, ULONG *money, STRING image);
	~CShop();
	VOID run();

	typedef struct tagShopColors
	{
		LONG text, main, line;
		tagShopColors() 
		{ 
			text = RGB(255, 255, 255); 
			line = RGB(255, 255, 255);
			main = 0; 
		}
	} SHOP_COLORS;

private:
	typedef enum tagShopOption			// Main menu options.
	{
		SHOP_BUY,
		SHOP_SELL,
		SHOP_EXIT
	} SHOP_OPTION;

	CCursorMap drawMainMenu(CONST CCanvas &backup, RECT &items);
	BOOL itemMenu(CONST CCanvas &backup, CONST SHOP_OPTION type, CONST RECT bounds);
	BOOL transaction(CONST SHOP_OPTION type, CONST STRING file);

	CInventory *m_shopInv;
	CInventory *m_playerInv;			// Pointer to g_inv.
	ULONG *m_money;						// Pointer to g_gp.
	INT m_fontSize;
	STRING m_fontFace;
	SHOP_COLORS m_colors;
	STRING m_image;						// Background image.

	typedef std::map<STRING, LPITEM> SHOP_ITEMS;
	SHOP_ITEMS m_items;

};

#endif