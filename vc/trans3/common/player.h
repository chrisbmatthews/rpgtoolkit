/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _PLAYER_H_
#define _PLAYER_H_

/*
 * Inclusions.
 */
#include <string>
#include <vector>

/*
 * Definitions.
 */
#define UBOUND_GFX 13
#define UBOUND_STANDING_GFX 7

/*
 * A player.
 */
typedef struct tagPlayer
{
	std::string charname;						// Character name.
	std::string experienceVar;					// Experience variable.
	std::string defenseVar;						// DP variable.
	std::string fightVar;						// FP variable.
	std::string healthVar;						// HP variable.
	std::string maxHealthVar;					// Max HP var.
	std::string nameVar;						// Character name variable.
	std::string smVar;							// Special Move power variable.
	std::string smMaxVar;						// Special Move maximum variable.
	std::string leVar;							// Level variable.
	int initExperience;							// Initial Experience Level.
	int initHealth;								// Initial health level.
	int initMaxHealth;							// Initial maximum health level.
	int initDefense;							// Initial DP.
	int initFight;								// Initial FP.
	int initSm;									// Initial SM power.
	int initSmMax;								// Initial Max SM power.
	int initLevel;								// Initial level.
	std::string profilePic;						// Profile picture.
	std::vector<std::string> smlist;			// Special Move list (200 in total!).
	std::vector<int> spcMinExp;					// Minimum experience for each move.
	std::vector<int> spcMinLevel;				// Min level for each move.
	std::vector<std::string> spcVar;			// Conditional variable for each special move.
	std::vector<std::string> spcEquals;			// Condition of variable for each special move.
	std::string specialMoveName;				// Name of special move.
	char smYN;									// Does he do special moves? 0-Y, 1-N.
	std::vector<std::string> accessoryName;		// Names of 10 accessories.
	std::vector<char> armorType;				// Is ARMOURTYPE used (0-N,1-Y).  Armour types are: 1-head,2-neck,3-lh,4-rh,5-body,6-legs.
	int levelType;								// Initial Level progression.
	short experienceIncrease;					// Experience increase Factor.
	int maxLevel;								// Maximum level.
	short levelHp;								// HP incrase by % when level increaes.
	short levelDp;								// DP incrase by % when level increaes.
	short levelFp;								// FP incrase by % when level increaes.
	short levelSm;								// SMP incrase by % when level increaes.
	std::string charLevelUpRPGCode;				// Rpgcode program to run on level up.
	char charLevelUpType;						// Level up type 0- exponential, 1-linear.
	char charSizeType;							// Size type: 0- 32x32, 1 - 64x32.
	std::string gfx[14];						// Filenames of standard animations for graphics.
	std::vector<std::string> customGfx;			// Customized animations.
	std::vector<std::string> customGfxNames;	// Customized animations (handles).
	std::string standingGfx[8];					// Filenames of the standing animations/graphics.
	double idleTime;							// Seconds to wait proir to switching toSTAND_ graphics.
	double speed;								// Seconds between each frame increase.
	int loopSpeed;								// .speed converted to loops.
	// std::vector<FIGHTER_STATUS> status;			// Status effects applied to player.
	short nextLevel;							// Exp value at which level up occurs.
	short levelProgression;						// Exp required until level up.
	std::vector<double> levelStarts;			// Exp values at which all levels start.
	void open(const std::string fileName);
} PLAYER;

#endif
