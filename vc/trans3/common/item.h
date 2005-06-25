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
#include <string>
#include "sprite.h"

/*
 * An item.
 */
typedef struct tagItem
{
	std::string itemName;						// Item name (handle).
	std::string itmDescription;					// Description of item (one-line string).
	char EquipYN;								// Equipable item? 0- No, 1- yes.
	char MenuYN;								// Menu item? 0-No, 1-Y.
	char BoardYN;								// Board item? 0-N, 1-Y.
	char FightYN;								// Battle item? 0-N, 1-Y.
	char usedBy;								// Item used by 0-all 1-defined.
	std::vector<std::string> itmChars;			// 50 characters who can use the item.
	int buyPrice;								// Price to buy at.
	int sellPrice;								// Price to sell at.
	char keyItem;								// Is it a key item (0-no, 1-yes).
	std::vector<char> itemArmor;				// Equip on what body locations? 1-7 (head->accessory).
	std::string accessory;						// Accessory name.
	int equipHP;								// Hp increase when equipped.
	int equipDP;								// Dp increase when equipped.
	int equipFP;								// Fp increase when equipped.
	int equipSM;								// Sm increase when equipped.
	std::string prgEquip;						// Prg to run when equipped.
	std::string prgRemove;						// Prg to run when remobed.
	int mnuHPup;								// HP increase when used from menu.
	int mnuSMup;								// SMP increase wjen used from menu.
	std::string mnuUse;							// Program to run when used from menu.
	int fgtHPup;								// HP increase when used from fight.
	int fgtSMup;								// SMP increase wjen used from fight.
	std::string fgtUse;							// Program to run when used from fight.
	std::string itmAnimation;					// Animation for battle.
	std::string itmPrgOnBoard;					// Program to run while item is on board.
	std::string itmPrgPickUp;					// Program to run when picked up.
	char itmSizeType;							// Graphics size type 0=32x32, 1=64x32.

	SPRITE_ATTR spriteAttributes;

//	std::vector<std::string> gfx;
//	std::string gfx[10];						// common // Filenames of standard animations for graphics.
	std::vector<std::string> customGfx;			// common // Customized animations.
	std::vector<std::string> customGfxNames;	// common // Customized animations (handles).
//	std::vector<std::string> standingGfx;
	std::string standingGfx[8];					// common // Filenames of the standing animations/graphics.
	double idleTime;							// common // Seconds to wait proir to switching to STAND_ graphics.
	double speed;								// common // Speed of this item.
	int loopSpeed;								// common // .speed converted to loops (3.0.5).

	short bIsActive;							// Is item active?

	short open(const std::string fileName, SPRITE_ATTR &spriteAttr);
} ITEM;

#endif
