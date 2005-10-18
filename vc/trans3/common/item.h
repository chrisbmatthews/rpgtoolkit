/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _ITEM_H_
#define _ITEM_H_

/*
 * Definitions.
 */
#define PRE_VECTOR_ITEM 6						// Last file version before vectors.

/*
 * Inclusions.
 */
#include <vector>
#include "../../tkCommon/strings.h"
#include "sprite.h"

/*
 * An item.
 */
typedef struct tagItem
{
	STRING itemName;						// Item name (handle).
	STRING itmDescription;					// Description of item (one-line string).
	char equipYN;								// Equipable item? 0- No, 1- yes.
	char menuYN;								// Menu item? 0-No, 1-Y.
	char boardYN;								// Board item? 0-N, 1-Y.
	char fightYN;								// Battle item? 0-N, 1-Y.
	char usedBy;								// Item used by 0-all 1-defined.
	std::vector<STRING> itmChars;			// 50 characters who can use the item.
	int buyPrice;								// Price to buy at.
	int sellPrice;								// Price to sell at.
	char keyItem;								// Is it a key item (0-no, 1-yes).
	std::vector<char> itemArmor;				// Equip on what body locations? 1-7 (head->accessory).
	STRING accessory;						// Accessory name.
	int equipHP;								// Hp increase when equipped.
	int equipDP;								// Dp increase when equipped.
	int equipFP;								// Fp increase when equipped.
	int equipSM;								// Sm increase when equipped.
	STRING prgEquip;						// Prg to run when equipped.
	STRING prgRemove;						// Prg to run when remobed.
	int mnuHPup;								// HP increase when used from menu.
	int mnuSMup;								// SMP increase wjen used from menu.
	STRING mnuUse;							// Program to run when used from menu.
	int fgtHPup;								// HP increase when used from fight.
	int fgtSMup;								// SMP increase when used from fight.
	STRING fgtUse;							// Program to run when used from fight.
	STRING itmAnimation;					// Animation for battle.
	STRING itmPrgOnBoard;					// Program to run while item is on board.
	STRING itmPrgPickUp;					// Program to run when picked up.

	short open(const STRING fileName, SPRITE_ATTR *pAttr);
} ITEM;

#endif
