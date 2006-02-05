/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _PLUGINS_H_
#define _PLUGINS_H_

#include "../../tkCommon/strings.h"

/*
 * Definitions.
 */

// Plugin types.
#define PT_RPGCODE 1		// RPGCode plugin.
#define PT_MENU 2			// Menu plugin.
#define PT_FIGHT 4			// Fight plugin.

// Input types.
#define INPUT_KB 0			// Keyboard input.
#define INPUT_MOUSEDOWN 1	// Mouse down.

/*
 * An RPGToolkit plugin.
 */
class IPlugin
{
public:
	virtual void initialize() = 0;
	virtual void terminate() = 0;
	virtual bool query(const STRING function) = 0;
	virtual bool execute(const STRING line, int &retValDt, STRING &retValLit, double &retValNum, const short usingReturn) = 0;
	virtual int fight(const int enemyCount, const int skillLevel, const STRING background, const bool canRun) = 0;
	virtual int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const STRING strMessage, const int attackCode) = 0;
	virtual int menu(const int request) = 0;
	virtual bool plugType(const int request) = 0;
	virtual ~IPlugin() { }
};

/*
 * Initialize the plugin system.
 */
void initPluginSystem();

/*
 * Shut down the plugin system.
 */
void freePluginSystem();

/*
 * Load a plugin.
 */
IPlugin *loadPlugin(const STRING file);

/*
 * Inform applicable plugins of an event.
 */
void informPluginEvent(const int keyCode, const int x, const int y, const int button, const int shift, const STRING key, const int type);

#endif
