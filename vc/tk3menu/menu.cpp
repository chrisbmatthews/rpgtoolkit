////////////////////////////////////////////////////////////////
//
// RPG Toolkit Development System, Version 3
// Menu System
// Developed by Christopher B. Matthews (Copyright 2003)
//
// This file is released under the AC Open License Derivative v 1.0
// See "AC Open License Derivative.txt"
//
////////////////////////////////////////////////////////////////
/////////////////////////////////////
// Menu System

#include "stdafx.h"
#include "menu.h"

CNVID g_cnvMenu;							//canvas of menu
long g_crTranspColor;						//transparent color
long g_crTextColor = rgb(255, 240, 230);	//text color to use

long g_nButton;		//button we're pointing at right now...

long g_nItemPage;	//item page we're on

long g_nEquipTop;	//top of equip list

std::string g_strList[501];	//lists for item selection in equip
int g_nMap[501];

long g_nSpecialMoveCount;	//number of special moves the player can do.
long g_nAbilitiesTop;		//top of equip list

int g_nOffsetX;				// Offset of the menu on the screen.
int g_nOffsetY;

#define SIZEX 640			// Dimensions of this menu.
#define SIZEY 480

void BeginMenu(void)
{
	//get transparent color...
	g_crTranspColor = CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0);

	g_cnvMenu = CBCreateCanvas(SIZEX, SIZEY);
}


void EndMenu(void)
{
	if (g_cnvMenu)
	{
		CBDestroyCanvas(g_cnvMenu);
		g_cnvMenu = 0;
	}	
}


//Launch the main menu!
void MainMenu(void)
{
	// Calculate the offsets.
	g_nOffsetX = (CBGetGeneralNum(GEN_RESX, 0, 0) - SIZEX) / 2;
	g_nOffsetY = (CBGetGeneralNum(GEN_RESY, 0, 0) - SIZEY) / 2;

	RenderMainMenu();
	g_nButton = 0;
	DrawCursor();
	CBRpgCode("#ClearBuffer()");
	MainMenuScanKeys();
	//flush keyboard...
	CBRpgCode("#ClearBuffer()");
}

void RenderMainMenu(void)
{
	CBCanvasLoadSizedImage(g_cnvMenu, CBGetGeneralString(GEN_MENUGRAPHIC, 0, 0));

	//Main Menu text
	CBCanvasDrawText(g_cnvMenu, CBLoadString(1965, "Main Menu"), "Arial", 24, 5.75, 1.75, g_crTextColor, true, false, false, true);

	RenderMainMenuPlayers(g_cnvMenu);

	//create time, GP, etc...
	RenderMainMenuStats(g_cnvMenu);

	//create options buttons...
	RenderMainMenuOptions(g_cnvMenu);

	CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);
	CBRefreshScreen();
}

//render the options menu
void RenderMainMenuOptions(CNVID cnv)
{
	std::string strItems = " " + CBLoadString(1973, "Items");
	std::string strEquip = " " + CBLoadString(1914, "Equip");
	std::string strAbilities = " " + CBLoadString(1971, "Abilities");

	std::string strSaveGame = " " + CBLoadString(950, "Save");
	std::string strLoadGame = " " + CBLoadString(2067, "Load");
	std::string strReturn = " " + CBLoadString(2068, "Return");
	std::string strExit = " " + CBLoadString(2069, "Quit");

	CNVID cnvButton = CBCreateCanvas(92, 30);
	
	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strItems, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 36, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strEquip, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 143, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strAbilities, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 250, 97);


	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strReturn, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 53, 434);

	// Save game - disable (grey) if progressive saving disabled.
	CBCanvasFill(cnvButton, 0);
	if (CBGetBoardNum(BRD_SAVING_DISABLED, 0, 0, 0) == 1)
		CBCanvasDrawText(cnvButton, strSaveGame, "Times New Roman", 20, 3.3, 1.25, rgb(128, 128, 128), 1, 0, 0, true);
	else
		CBCanvasDrawText(cnvButton, strSaveGame, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 200, 434);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strLoadGame, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 347, 434);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strExit, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 494, 434);

	CBDestroyCanvas(cnvButton);
}


//check for key presses on the main menu...
int MainMenuScanKeys(void)
{
	bool bDone = false;
	std::string strFile = "";
	int nPlayerID = 0;
	while (!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			bDone = true;
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			switch(g_nButton)
			{
				case 0:
					//Inventory
					g_nItemPage = 0;
					ItemMenu();
					//After returning from the inventory, go to the main menu...
					RenderMainMenu();
					DrawCursor();
					break;

				case 1:
					//Equip
					//first choose a player...
					nPlayerID = SelectPlayer(false);
					if (nPlayerID != -1)
					{
						//open equip menu for this player...
						EquipMenu(nPlayerID);
					}
					//After returning from the equip menu, go to the main menu...
					RenderMainMenu();
					DrawCursor();
					break;

				case 2:
					//Abilities
					//first choose a player...
					nPlayerID = SelectPlayer(false);
					if (nPlayerID != -1)
					{
						//open abilities menu for this player...
						AbilitiesMenu(nPlayerID);
					}
					//After returning from the abilities menu, go to the main menu...
					RenderMainMenu();
					DrawCursor();
					break;

				case 3:
					//Return
					bDone = true;
					break;

				case 4:
					//Save
					if (CBGetBoardNum(BRD_SAVING_DISABLED, 0, 0, 0) == 0)
					{
						// If saving is enabled on this board.
						strFile = CBFileDialog(CBGetPathString(PATH_SAVE), "*.sav");

						if (strFile.compare("") != 0)
						{
							// If a file was chosen.
							CBRpgCode("#Save("+strFile+")");
							CBMessageWindow(CBLoadString(834, "Save Complete!"), rgb(255, 255, 255), rgb(0,0,0), "", MW_OK);
						}
					}

					RenderMainMenu();
					DrawCursor();

					// Clear the queue to prevent sticking.
					Sleep(90);
					FlushInputEvents();

					break;

				case 5:
					//Load
					strFile = CBFileDialog(CBGetPathString(PATH_SAVE), "*.sav");
					if (strFile.compare("") != 0)
					{
						strFile = CBFileDialog(CBGetPathString(PATH_SAVE), "*.sav");
						CBRpgCode("#Load("+strFile+")");
						bDone = true;
					}
					break;

				case 6:
					//Quit
					//remove cursor...
					CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);
					int nRet = CBMessageWindow(CBLoadString(835, "Exit to Windows.  Are You Sure?"), rgb(255, 255, 255), 0, "", MW_YESNO);
					
					// Clear the queue to prevent sticking.
					Sleep(90);
					FlushInputEvents();
					
					if (nRet == MWR_YES)
					{
						CBRpgCode("#Dos()");
						bDone = true;
					}
					DrawCursor();
					break;
			}
		}
		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			if (g_nButton == 2)
				g_nButton = 0;
			else if (g_nButton == 6)
				g_nButton = 3;
			else
				g_nButton++;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			if (g_nButton == 0)
				g_nButton = 2;
			else if (g_nButton == 3)
				g_nButton = 6;
			else
				g_nButton--;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			if (g_nButton >= 0 && g_nButton <= 2)
				g_nButton = 3;
			else 
				g_nButton = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			if (g_nButton >= 3 && g_nButton <= 6)
				g_nButton = 0;
			else 
				g_nButton = 3;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
	}
	return 1;
}


//Show the inventory menu...
void ItemMenu(void)
{
	RenderItemMenu();
	g_nButton = 0;
	DrawCursor();
	CBRpgCode("#ClearBuffer()");
	ItemMenuScanKeys();
	//flush keyboard...
	CBRpgCode("#ClearBuffer()");
}

void RenderItemMenu(bool bShowContent)
{
	CBCanvasLoadSizedImage(g_cnvMenu, CBGetGeneralString(GEN_MENUGRAPHIC, 0, 0));

	//Main Menu text
	CBCanvasDrawText(g_cnvMenu, CBLoadString(1961, "Inventory"), "Arial", 24, 5.75, 1.75, g_crTextColor, true, false, false, true);

	//create time, GP, etc...
	RenderMainMenuStats(g_cnvMenu);

	if (bShowContent)
		RenderItemList(g_cnvMenu, g_nItemPage);

	RenderItemOptions(g_cnvMenu);

	//show the item page...
	CBCanvasDrawText(g_cnvMenu, Int2String(g_nItemPage+1), "Arial", 18, 1.5, 23, g_crTextColor, 0, 0, 0, 0);

	CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);
	CBRefreshScreen();

}


//Show list of items in inventory...
void RenderItemList(CNVID cnv, int nPage)
{
	CNVID cnvItem = CBCreateCanvas(112, 250);
	int nX = 25;
	for (int i = 0; i < 5; i++)
	{
		std::string strPlayerFile = CBGetGeneralString(GEN_PLAYERFILES, 0, i);
		if (strPlayerFile.compare("") != 0)
		{
			//this player is loaded...
			CBCanvasFill(cnvItem, g_crTranspColor);

			RenderItemSublist(nPage /* * 4*/ + i, cnvItem);

			CBCanvas2CanvasBltTransparent(cnvItem, cnv, nX, 175, g_crTranspColor);
			nX += 120;

		}
	}
	CBDestroyCanvas(cnvItem);
}

//render item sublist...
//12 items per sublist...
void RenderItemSublist(int nSublistNumber, CNVID cnv)
{
	//first item in the list...
	int nItemsPerList = CBCanvasHeight(cnv) / 20;

	int nFirstItem = nSublistNumber * nItemsPerList;
	
	//get item handles from trans3...
	std::string strItems[501];
	int i;
	for (i = 0; i < 500; i++)
	{
		strItems[i] = CBGetGeneralString(GEN_INVENTORY_HANDLES, i, 0);
	}

	int c = 0;
	//find that first item...
	for (i = 0; i < 500; i++)
	{
		if (strItems[i].compare("") != 0)
		{
			if (c == nFirstItem)
			{
				break;
			}
			else
			{
				c++;
			}
		}
	}

	//first item is in index 'c'...
	int y = 0;
	int idx = i;
	while(true)
	{
		if (strItems[idx].compare("") != 0)
		{
			//found one...
			std::string strText = Int2String(CBGetGeneralNum(GEN_INVENTORY_NUM, idx, 0)) + " " + strItems[idx];
			CBCanvasDrawText(cnv, strText, "Arial", 20, 1.5, y+1, g_crTextColor, 1, 0, 0, false);

			y++;
			if (y>=nItemsPerList)
				break;
		}
		idx++;
		if (idx > 500)
			break;
	}
}


//render the item options menu
void RenderItemOptions(CNVID cnv)
{
	std::string strUse = " " + CBLoadString(1896, "Use");
	std::string strInfo = " " + CBLoadString(1895, "Info");
	std::string strDrop = " " + CBLoadString(1962, "Drop");

	std::string strBack = " " + CBLoadString(2070, "Back");

	CNVID cnvButton = CBCreateCanvas(92, 30);
	
	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strUse, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 36, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strInfo, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 143, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strDrop, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 250, 97);


	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strBack, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 53, 434);

	CBDestroyCanvas(cnvButton);
}


//select an item off the item list...
//return array index of the selected item...
//return -1 if cancelled
int SelectItem(void)
{
	int nCursorX = 0;
	int nCursorY = 0;
	int nRet = 0;
	bool bDone = false;
	while(!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		//draw cursor on the item list...
		int x, y;
		x = y = 0;
		x = 45 + 120 * nCursorX;
		y = 185 + 20 * nCursorY;
		CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
		CBRefreshScreen();

		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			nCursorY++;
			if (nCursorY > 11)
				nCursorY = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			nCursorY--;
			if (nCursorY < 0)
				nCursorY = 11;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			nCursorX--;
			if (nCursorX < 0)
			{
				nCursorX = 0;
				g_nItemPage--;
				if (g_nItemPage < 0)
					g_nItemPage = 0;
				RenderItemMenu();
			}
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			nCursorX++;
			if (nCursorX > 4)
			{
				nCursorX = 4;
				g_nItemPage++;
				RenderItemMenu();
			}
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}

		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			DrawCursor();
			bDone = true;
		}
		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			DrawCursor();
			return -1;
		}
	}

	//when we exit the loop, we have selected the item at nCursorX, nCursorY
	int nScreenIndex = (g_nItemPage * 12) + (nCursorX * 12 + nCursorY);
	
	//nScreenIndex indicates the index of the object as if it were mapped directly to te screen list.
	//let's match this up with the item list array...
	//get item handles from trans3...
	std::string strItems[501];
	int i;
	for (i = 0; i < 500; i++)
	{
		strItems[i] = CBGetGeneralString(GEN_INVENTORY_HANDLES, i, 0);
	}

	int c = 0;
	//find that item...
	for (i = 0; i < 500; i++)
	{
		if (strItems[i].compare("") != 0)
		{
			if (c == nScreenIndex)
			{
				break;
			}
			else
			{
				c++;
			}
		}
	}
	nRet = i;

	return nRet;
}


//show info about an item.
//nItemIndex is the array index of the item in trans3
void ItemShowInfo(int nItemIndex)
{
	//obtain item filename...
	std::string strFile = CBGetGeneralString(GEN_INVENTORY_FILES, nItemIndex, 0);
	if (strFile.compare("") != 0)
	{
		//load this item (by convention, item 11 is a 'free' slot...
		CBLoadItem(strFile, 11);

		std::string strText = "";
		
		std::string strDescr = CBGetItemString(ITM_DESCRIPTION, 0, 11);
		
		strText = strText + strDescr + "\n";

		if (CBGetItemNum(ITM_EQUIP_YN, 0, 11) == 1)
		{
			strText = strText + CBLoadString(877, "Item is equippable.") + "\n";
			if (CBGetItemNum(ITM_EQUIP_HPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(878, "   Increases Max HP by") + " " + Int2String(CBGetItemNum(ITM_EQUIP_HPUP, 0, 11)) + "\n";
			}
			if (CBGetItemNum(ITM_EQUIP_DPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(879, "   Increases Max DP by") + " " + Int2String(CBGetItemNum(ITM_EQUIP_DPUP, 0, 11)) + "\n";
			}
			if (CBGetItemNum(ITM_EQUIP_FPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(880, "   Increases Max FP by") + " " + Int2String(CBGetItemNum(ITM_EQUIP_FPUP, 0, 11)) + "\n";
			}
			if (CBGetItemNum(ITM_EQUIP_SMPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(881, "   Increases Max SMP by") + " " + Int2String(CBGetItemNum(ITM_EQUIP_SMPUP, 0, 11)) + "\n";
			}
		}
		if (CBGetItemNum(ITM_MENU_YN, 0, 11) == 1)
		{
			strText = strText + CBLoadString(882, "Item can be used from the menu.") + "\n";
			if (CBGetItemNum(ITM_MENU_HPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(878, "   Increases Max HP by") + " " + Int2String(CBGetItemNum(ITM_MENU_HPUP, 0, 11)) + "\n";
			}
			if (CBGetItemNum(ITM_MENU_SMPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(881, "   Increases Max SMP by") + " " + Int2String(CBGetItemNum(ITM_MENU_SMPUP, 0, 11)) + "\n";
			}
		}
		if (CBGetItemNum(ITM_FIGHT_YN, 0, 11) == 1)
		{
			strText = strText + CBLoadString(885, "Item can be used in battles.") + "\n";
			if (CBGetItemNum(ITM_FIGHT_HPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(878, "   Increases Max HP by") + " " + Int2String(CBGetItemNum(ITM_FIGHT_HPUP, 0, 11)) + "\n";
			}
			if (CBGetItemNum(ITM_FIGHT_SMPUP, 0, 11) != 0)
			{
				strText = strText + CBLoadString(881, "   Increases Max SMP by") + " " + Int2String(CBGetItemNum(ITM_FIGHT_SMPUP, 0, 11)) + "\n";
			}
		}
		CBMessageWindow(strText, RGB(255, 255, 255), 0, "", MW_OK);
	}
}


//drop an item...
void ItemDrop(int nItemIndex)
{
	//obtain item filename...
	std::string strFile = CBGetGeneralString(GEN_INVENTORY_FILES, nItemIndex, 0);
	if (strFile.compare("") != 0)
	{
		//load this item (by convention, item 11 is a 'free' slot...
		CBLoadItem(strFile, 11);
		if (CBGetItemNum(ITM_KEYITEM, 0, 11) == 1)
		{
			//canot drop a key item...
			CBMessageWindow(CBLoadString(838, "You cannot drop this item!"), RGB(255, 255, 255), 0, "", MW_OK);
		}
		else
		{
			//item is not a key item, so we can drop it...
			int nAsk = CBMessageWindow(CBLoadString(840, "Are you sure you want to drop this") + " " + CBGetGeneralString(GEN_INVENTORY_HANDLES, nItemIndex, 0) + "?", RGB(255, 255, 255), 0, "", MW_YESNO);
			if (nAsk == MWR_YES)
			{
				//the user really wants to drop it...
				CBRpgCode("#TakeItem(\"" + CBGetGeneralString(GEN_INVENTORY_HANDLES, nItemIndex, 0) + "\")");
			}
		}
	}
}

//Use an item on a player
//the id's are the indices into the arrays in trans3.
void ItemUse(int nItemID, int nPlayerID)
{
	std::string strFile = CBGetGeneralString(GEN_INVENTORY_FILES, nItemID, 0);
	std::string strPlayer = CBGetGeneralString(GEN_PLAYERHANDLES, 0, nPlayerID);
	if ((strFile.compare("") != 0) && (strPlayer.compare("") != 0))
	{
		//load this item (by convention, item 11 is a 'free' slot...
		CBLoadItem(strFile, 11);

		//get amounts to add...
		int nHP = CBGetItemNum(ITM_MENU_HPUP, 0, 11);
		int nSMP = CBGetItemNum(ITM_MENU_SMPUP, 0, 11);

		CBRpgCode("#GiveHP(\"" + strPlayer + "\", " + Int2String(nHP) + ")");
		CBRpgCode("#GiveSMP(\"" + strPlayer + "\", " + Int2String(nSMP) + ")");

		//Now run the associated program...
		std::string strPrg = CBGetItemString(ITM_MENU_PRG, 0, 11);
		if (strPrg.compare("") != 0)
		{
			CBSetSource(nPlayerID, TYPE_PLAYER);
			CBSetTarget(nPlayerID, TYPE_PLAYER);
			CBRunProgram(strPrg);
		}

		//Now remove the item...
		CBRpgCode("#TakeItem(\"" + CBGetGeneralString(GEN_INVENTORY_HANDLES, nItemID, 0) + "\")");
	}
}


//check for key presses on the item menu...
int ItemMenuScanKeys(void)
{
	bool bDone = false;
	int nItemID = 0;
	int nPlayerID = 0;
	std::string strFile = "";
	while (!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			bDone = true;
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			switch(g_nButton)
			{
				case 0:
					//Use
					nItemID = SelectItem();
					if (nItemID != -1)
					{
						//check if we can use this item from the menu...
						strFile = CBGetGeneralString(GEN_INVENTORY_FILES, nItemID, 0);
						if (strFile.compare("") != 0)
						{
							//load this item (by convention, item 11 is a 'free' slot...
							CBLoadItem(strFile, 11);
							if (CBGetItemNum(ITM_MENU_YN, 0, 11) == 1)
							{
								//can use the item from the menu...
								//select player to use it on...
								RenderItemMenu(false);
								nPlayerID = SelectPlayer(true);
								if (nPlayerID != -1)
								{
									//ok, use the item on a player...
									ItemUse(nItemID, nPlayerID);
								}
								RenderItemMenu(true);
							}
							else
							{
								//cannot use the item from the menu...
								CBMessageWindow(CBLoadString(837, "You cannot use this item from the menu!"), RGB(255, 255, 255), 0, "", MW_OK);
							}
						}
					}
					break;

				case 1:
					//Info
					nItemID = SelectItem();
					if (nItemID != -1)
					{
						//show the item info...
						ItemShowInfo(nItemID);
					}
					break;

				case 2:
					//Drop
					nItemID = SelectItem();
					if (nItemID != -1)
					{
						//drop item...
						ItemDrop(nItemID);
						RenderItemMenu();
						DrawCursor();
					}
					break;

				case 3:
					//Return
					bDone = true;
					break;
			}
		}
		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			if (g_nButton == 2)
				g_nButton = 0;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton++;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			if (g_nButton == 0)
				g_nButton = 2;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton--;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			if (g_nButton >= 0 && g_nButton <= 2)
				g_nButton = 3;
			else 
				g_nButton = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			if (g_nButton >= 3 && g_nButton <= 6)
				g_nButton = 0;
			else 
				g_nButton = 3;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
	}
	return 1;
}


//Abilities menu
void AbilitiesMenu(int nPlayerID)
{
	std::string strName = CBGetPlayerName(nPlayerID);
	g_nSpecialMoveCount = CBDetermineSpecialMoves(strName);

	RenderAbilitiesMenu(nPlayerID, true);
	g_nButton = 0;
	g_nAbilitiesTop = 0;
	DrawCursor();
	CBRpgCode("#ClearBuffer()");
	AbilitiesMenuScanKeys(nPlayerID);
	//flush keyboard...
	CBRpgCode("#ClearBuffer()");
}


//render the equip menu
void RenderAbilitiesMenu(int nPlayerID, bool bRenderInfo)
{
	CBCanvasLoadSizedImage(g_cnvMenu, CBGetGeneralString(GEN_MENUGRAPHIC, 0, 0));

	//Main Menu text
	CBCanvasDrawText(g_cnvMenu, CBLoadString(1001, "Player Abilities"), "Arial", 24, 5.75, 1.75, g_crTextColor, true, false, false, true);

	//create time, GP, etc...
	RenderMainMenuStats(g_cnvMenu);

	if (bRenderInfo)
	{
		//put selected player there...
		CNVID cnvPlayer = CBCreateCanvas(112, 250);
		CBCanvasFill(cnvPlayer, g_crTranspColor);
		RenderPlayerInfo(nPlayerID, cnvPlayer);
		CBCanvas2CanvasBltTransparent(cnvPlayer, g_cnvMenu, 25, 175, g_crTranspColor);
		CBDestroyCanvas(cnvPlayer);


		//put abilities list
		RenderAbilitiesList(g_cnvMenu, nPlayerID, g_nEquipTop);
	}

	//options
	RenderAbilitiesOptions(g_cnvMenu);

	CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);
	CBRefreshScreen();
}


//Render list of abiltiies...
void RenderAbilitiesList(CNVID cnv, int nPlayerID, int nStartPos)
{
	CNVID cnvEquip = CBCreateCanvas(445, 240);
	CBCanvasFill(cnvEquip, 0);
	
	std::string abilitiesList[500];

	for (int i = 0; i < g_nSpecialMoveCount; i++)
	{
		std::string strFile = CBGetSpecialMoveListEntry(i);
		if (strFile.compare("") != 0)
		{
			//ok, we have a special move... load it...
			CBLoadSpecialMove(strFile);
			abilitiesList[i] = CBGetSpecialMoveString(SPC_NAME) + ": " + Int2String(CBGetSpecialMoveNum(SPC_SMP));
		}
	}

	int idx = nStartPos + 12;
	if (idx > g_nSpecialMoveCount)
		idx = g_nSpecialMoveCount;

	//now add the list to the canvas...
	for (i=nStartPos; i < idx; i++)
	{
		CBCanvasDrawText(cnvEquip, abilitiesList[i], "Arial", 20, 1, i-nStartPos+1, g_crTextColor, 1, 0, 0, false);
	}


	//now draw the canvas...
	CBCanvas2CanvasBlt(cnvEquip, cnv, 147, 175);

	CBDestroyCanvas(cnvEquip);
}


//render abilities menu options
void RenderAbilitiesOptions(CNVID cnv)
{
	std::string strEquip = " " + CBLoadString(1896, "Use");
	std::string strRemove = " " + CBLoadString(1895, "Info");

	std::string strBack = " " + CBLoadString(2070, "Back");

	CNVID cnvButton = CBCreateCanvas(92, 30);
	
	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strEquip, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 36, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strRemove, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 143, 97);


	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strBack, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 53, 434);

	CBDestroyCanvas(cnvButton);
}


//check for key presses on the Equip menu...
int AbilitiesMenuScanKeys(int nPlayerID)
{
	bool bDone = false;
	int nAbilityID = 0;
	int nSelectedPlayerID = 0;
	std::string strFile = "";
	while (!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			bDone = true;
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			switch(g_nButton)
			{
				case 0:
					//Equip
					nAbilityID = SelectAbility(nPlayerID);
					if (nAbilityID != -1)
					{
						//load the special move...
						CBLoadSpecialMove(CBGetSpecialMoveListEntry(nAbilityID));
						if (CBGetSpecialMoveNum(SPC_MENUDRIVEN) == 0)
						{
							//useable from the menu...
							//select a player to use the move on...
							RenderAbilitiesMenu(nPlayerID, false);
							nSelectedPlayerID = SelectPlayer(true);
							if (nSelectedPlayerID != -1)
							{
								//ok, use the item on a player...
								AbilityUse(nPlayerID, nAbilityID, nSelectedPlayerID);
							}
							RenderAbilitiesMenu(nPlayerID, true);
						}
						else
						{
							//can't use from menu!
							CBMessageWindow(CBLoadString(844, "You cannot use this move from the menu!"), g_crTextColor, 0, "", MW_OK);
						}
						RenderAbilitiesMenu(nPlayerID, true);
						DrawCursor();
					}
					break;

				case 1:
					//Info...
					nAbilityID = SelectAbility(nPlayerID);
					if (nAbilityID != -1)
					{
						AbilityInfo(nPlayerID, nAbilityID);
						RenderAbilitiesMenu(nPlayerID, true);
						DrawCursor();
					}
					break;

				case 2:
					break;

				case 3:
					//Return
					bDone = true;
					break;
			}
		}
		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			if (g_nButton == 1)
				g_nButton = 0;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton++;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			if (g_nButton == 0)
				g_nButton = 1;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton--;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			if (g_nButton >= 0 && g_nButton <= 2)
				g_nButton = 3;
			else 
				g_nButton = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			if (g_nButton >= 3 && g_nButton <= 6)
				g_nButton = 0;
			else 
				g_nButton = 3;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
	}
	return 1;
}


//Use an abiloity
//nPlayerID - player using the special move, nAbilityID - ability to use
//nSelectedPlayer - player to use it on.
//assumes special move has already been loaded.
void AbilityUse(int nPlayerID, int nAbilityID, int nSelectedPlayer)
{
	//check if player has enough smp to use it...
	int nSMPRequired = CBGetSpecialMoveNum(SPC_SMP);
	double dSMPOfPlayer = CBGetPlayerSMP(nPlayerID);
	if (nSMPRequired > dSMPOfPlayer)
	{
		CBMessageWindow(CBLoadString(826, "You do not have enought SMP to use this move!"), g_crTextColor, 0, "", MW_OK);
	}
	else
	{
		//ok, we can use this move...
		//remove SMP...
		dSMPOfPlayer-=nSMPRequired;
		CBSetPlayerSMP((int)dSMPOfPlayer, nPlayerID);

		//get special move data...
		int nSpcFP = CBGetSpecialMoveNum(SPC_FP);
		int nSpcSMP = CBGetSpecialMoveNum(SPC_TARGET_SMP);
		std::string strPrg = CBGetSpecialMoveString(SPC_PRG_FILE);

		//adjust target's hp...
		CBAddPlayerHP(nSpcFP * -1, nSelectedPlayer);

		//adjust target's SMP...
		CBAddPlayerSMP(nSpcSMP * -1, nSelectedPlayer);

		//run rpgcode program...
		if (strPrg.compare("") != 0)
		{
			CBSetTarget(nSelectedPlayer, TYPE_PLAYER);
			CBSetSource(nPlayerID, TYPE_PLAYER);
			CBRunProgram(strPrg);
		}
	}
}

//show the info for an ability...
void AbilityInfo(int nPlayerID, int nAbilityID)
{
	//assumes CBDetermineSpecialMoves is already called.
	std::string strFile = CBGetSpecialMoveListEntry(nAbilityID);
	if (strFile.compare("") != 0)
	{
		//ok, we have a special move... load it...
		CBLoadSpecialMove(strFile);
		std::string strDescription = CBGetSpecialMoveString(SPC_DESCRIPTION);
		if (strDescription.compare("") != 0)
		{
			CBMessageWindow(strDescription, g_crTextColor, 0, "", MW_OK);
		}
	}
}


//select an ability slot.
//return the index selected 
//return -1 if cancelled
int SelectAbility(int nPlayerID)
{
	int nCursor = 0;
	int nRet = 0;
	std::string strMove = CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0);
	bool bDone = false;
	while(!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		//draw cursor on the item list...
		int x, y;
		x = y = 0;
		x = 145;
		y = 185 + 20 * nCursor;
		CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
		CBRefreshScreen();

		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			nCursor++;
			if (nCursor > 11)
			{
				g_nAbilitiesTop++;
				RenderAbilitiesList(g_cnvMenu, nPlayerID, g_nAbilitiesTop);
				nCursor = 11;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			nCursor--;
			if (nCursor < 0)
			{
				g_nAbilitiesTop--;
				if (g_nAbilitiesTop >= 0)
				{
					RenderAbilitiesList(g_cnvMenu, nPlayerID, g_nAbilitiesTop);
				}
				else
				{
					g_nAbilitiesTop = 0;
				}
				//nCursor = 11;
				nCursor = 0;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			DrawCursor();
			bDone = true;
		}
		if (ie.strKey.compare("ESC") == 0 ||  CBCheckKey("BUTTON2"))
		{
			DrawCursor();
			return -1;
		}
	}

	nRet = nCursor + g_nAbilitiesTop;
	return nRet;
}




//Equip menu
void EquipMenu(int nPlayerID)
{
	RenderEquipMenu(nPlayerID);
	g_nButton = 0;
	g_nEquipTop = 0;
	DrawCursor();
	CBRpgCode("#ClearBuffer()");
	EquipMenuScanKeys(nPlayerID);
	//flush keyboard...
	CBRpgCode("#ClearBuffer()");
}


//render the equip menu
void RenderEquipMenu(int nPlayerID)
{
	CBCanvasLoadSizedImage(g_cnvMenu, CBGetGeneralString(GEN_MENUGRAPHIC, 0, 0));

	//Main Menu text
	CBCanvasDrawText(g_cnvMenu, CBLoadString(1913, "Equip Player"), "Arial", 24, 5.75, 1.75, g_crTextColor, true, false, false, true);

	//create time, GP, etc...
	RenderMainMenuStats(g_cnvMenu);

	//put selected player there...
	CNVID cnvPlayer = CBCreateCanvas(112, 250);
	CBCanvasFill(cnvPlayer, g_crTranspColor);
	RenderPlayerInfo(nPlayerID, cnvPlayer);
	CBCanvas2CanvasBltTransparent(cnvPlayer, g_cnvMenu, 25, 175, g_crTranspColor);
	CBDestroyCanvas(cnvPlayer);


	//put equip list
	RenderEquipList(g_cnvMenu, nPlayerID, g_nEquipTop);

	//options
	RenderEquipOptions(g_cnvMenu);

	CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);
	CBRefreshScreen();
}


//Render list of equipped items...
void RenderEquipList(CNVID cnv, int nPlayerID, int nStartPos)
{
	CNVID cnvEquip = CBCreateCanvas(445, 240);
	CBCanvasFill(cnvEquip, 0);
	
	//create list of equipment...
	std::string strEquipList[20];
	int idx = 0;

	for (int i = 1; i <=6; i++)
	{
		if (CBGetPlayerNum(PLAYER_ARMOURS, i, nPlayerID) == 1)
		{
			//this armour type is supported...
			std::string strEquipped = "";
			switch(i)
			{
				case 1:
					strEquipList[idx] = CBLoadString(896, "Head");
					break;
				case 2:
					strEquipList[idx] = CBLoadString(897, "Neck Accessory");
					break;
				case 3:
					strEquipList[idx] = CBLoadString(898, "Left Hand");
					break;
				case 4:
					strEquipList[idx] = CBLoadString(899, "Right Hand");
					break;
				case 5:
					strEquipList[idx] = CBLoadString(900, "Body");
					break;
				case 6:
					strEquipList[idx] = CBLoadString(901, "Legs");
					break;
			}
			strEquipped = CBGetGeneralString(GEN_EQUIP_HANDLES, i, nPlayerID);
			if (strEquipped.compare("") == 0)
				strEquipList[idx] += ": " + CBLoadString(1010, "None");
			else
				strEquipList[idx] += ": " + strEquipped;
			idx++;
		}
	}

	for (i = 1; i <=10; i++)
	{
		std::string strAccessory = CBGetPlayerString(PLAYER_ACCESSORIES, i, nPlayerID);
		if (strAccessory.compare("") != 0)
		{
			strEquipList[idx] = strAccessory;

			std::string strEquipped = CBGetGeneralString(GEN_EQUIP_HANDLES, i+6, nPlayerID);
			if (strEquipped.compare("") == 0)
				strEquipList[idx] += ": " + CBLoadString(1010, "None");
			else
				strEquipList[idx] += ": " + strEquipped;

			idx++;
		}
	}

	//now add the list to the canvas...
	for (i=nStartPos; i < idx; i++)
	{
		CBCanvasDrawText(cnvEquip, strEquipList[i], "Arial", 20, 1, i-nStartPos+1, g_crTextColor, 1, 0, 0, false);
	}


	//now draw the canvas...
	CBCanvas2CanvasBlt(cnvEquip, cnv, 147, 175);

	CBDestroyCanvas(cnvEquip);
}

//render equip menu options
void RenderEquipOptions(CNVID cnv)
{
	std::string strEquip = " " + CBLoadString(1914, "Equip");
	std::string strRemove = " " + CBLoadString(1096, "Remove");

	std::string strBack = " " + CBLoadString(2070, "Back");

	CNVID cnvButton = CBCreateCanvas(92, 30);
	
	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strEquip, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 36, 97);

	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strRemove, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 143, 97);


	CBCanvasFill(cnvButton, 0);
	CBCanvasDrawText(cnvButton, strBack, "Times New Roman", 20, 3.3, 1.25, rgb(255, 0, 0), 1, 0, 0, true);
	CBCanvas2CanvasBlt(cnvButton, cnv, 53, 434);

	CBDestroyCanvas(cnvButton);
}


//select an equip slot.
//return the index selected (corrected to the list)
//return -1 if cancelled
int SelectEquip(int nPlayerID)
{
	int nCursor = 0;
	int nRet = 0;
	std::string strMove = CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0);
	bool bDone = false;
	while(!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		//draw cursor on the item list...
		int x, y;
		x = y = 0;
		x = 145;
		y = 185 + 20 * nCursor;
		CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
		CBRefreshScreen();

		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			nCursor++;
			if (nCursor > 11)
			{
				g_nEquipTop++;
				RenderEquipList(g_cnvMenu, nPlayerID, g_nEquipTop);
				nCursor = 11;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			nCursor--;
			if (nCursor < 0)
			{
				g_nEquipTop--;
				if (g_nEquipTop >= 0)
				{
					RenderEquipList(g_cnvMenu, nPlayerID, g_nEquipTop);
				}
				else
				{
					g_nEquipTop = 0;
				}
				//nCursor = 11;
				nCursor = 0;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			DrawCursor();
			bDone = true;
		}
		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			DrawCursor();
			return -1;
		}
	}

	nRet = nCursor + g_nEquipTop;

	//selected in list is in nRet--
	//correspond that to a positionin the equip array (1-16)
	int nCount = 0;
	for (int i = 1; i <=6; i++)
	{
		if (CBGetPlayerNum(PLAYER_ARMOURS, i, nPlayerID) == 1)
		{
			if (nCount == nRet)
			{
				return i;
			}
			nCount++;
		}
	}

	for (i = 1; i <=10; i++)
	{
		std::string strAccessory = CBGetPlayerString(PLAYER_ACCESSORIES, i, nPlayerID);
		if (strAccessory.compare("") != 0)
		{
			if (nCount == nRet)
			{
				return i+6;
			}
			nCount++;
		}
	}


	return nRet;
}


//remove equipment from player
//put it back in inventory...
//nEquipID is the equipment id 1-16
void EquipRemove(int nPlayerID, int nEquipID)
{
	//get equip filesname...
	std::string strEquipFile = CBGetGeneralString(GEN_EQUIP_FILES, nEquipID, nPlayerID);
	std::string strEquipHandle = CBGetGeneralString(GEN_EQUIP_HANDLES, nEquipID, nPlayerID);
	std::string strPlayerHandle = CBGetGeneralString(GEN_PLAYERHANDLES, 0, nPlayerID);
	//remove it from the body location...
	CBRpgCode("#Remove(\"" + strPlayerHandle + "\", " + Int2String(nEquipID) + ")");
}

//equip an item to the player at nPlayerID
//at his equip loaction at nEquipID
//using the item at nItemID
void EquipToPlayer(int nPlayerID, int nEquipID, int nItemID)
{
	//get equip filesname...
	std::string strEquipHandle = CBGetGeneralString(GEN_INVENTORY_HANDLES, nItemID, 0);
	std::string strPlayerHandle = CBGetGeneralString(GEN_PLAYERHANDLES, 0, nPlayerID);
	//remove it from the body location...
	CBRpgCode("#Equip(\"" + strPlayerHandle + "\", " + Int2String(nEquipID) + ", " + "\"" + strEquipHandle +  "\")");
}


//draw a list of items equippable to nPlayerID at 
//body location nEquipID
//then allow the player to select it
//automatically corrects to item index
//return -1 if cancelled
int SelectEquippableItem(int nPlayerID, int nEquipID)
{
	//first draw a list of items equippable on this player
	//and body location...
	int nCount = DetermineEquippableItems(nPlayerID, nEquipID);
	if (nCount == 0)
	{
		CBMessageWindow(CBLoadString(2073, "You have no items to equip there"), g_crTextColor, 0, "", MW_OK);
		return -1;
	}
	RenderEquipItems(g_cnvMenu, nCount, 0);
	DrawCursor();

	//now allow us to select...
	int nCursor = 0;
	int nRet = 0;
	int nTop = 0;
	std::string strMove = CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0);
	bool bDone = false;
	while(!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		//draw cursor on the item list...
		int x, y;
		x = y = 0;
		x = 145;
		y = 185 + 20 * nCursor;
		CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
		CBRefreshScreen();

		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			nCursor++;
			if (nCursor > 11)
			{
				nTop++;
				RenderEquipItems(g_cnvMenu, nCount, nTop);
				nCursor = 11;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			nCursor--;
			if (nCursor < 0)
			{
				nTop--;
				if (nTop >= 0)
				{
					RenderEquipItems(g_cnvMenu, nCount, nTop);
				}
				else
				{
					nTop = 0;
				}
				//nCursor = 11;
				nCursor = 0;
			}
			CBPlaySound(strMove);
			//Sleep(90);
			//draw previous hand cursor...
			DrawCursor();
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			DrawCursor();
			bDone = true;
		}
		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			DrawCursor();
			return -1;
		}
	}

	nRet = nCursor + nTop;

	return g_nMap[nRet];
}


//populate g_strList and g_nMap with a list
//of equippable items for this player
//and equip slot
//returns count of equippable items
int DetermineEquippableItems(int nPlayerID, int nEquipID)
{
	int idx = 0;

	std::string strPlayerHandle = CBGetGeneralString(GEN_PLAYERHANDLES, 0, nPlayerID);
	
	for(idx = 0; idx <=500; idx++)
	{
		g_strList[idx]="";
		g_nMap[idx] = 0;
	}

	int nListIdx = 0;
	for(idx = 0; idx <=500; idx++)
	{
		if(CBGetGeneralString(GEN_INVENTORY_HANDLES, idx, 0).compare("") != 0)
		{
			if (CBGetGeneralNum(GEN_INVENTORY_NUM, idx, 0) > 0)
			{
				//check if the item is equippable...
				CBLoadItem(CBGetGeneralString(GEN_INVENTORY_FILES, idx, 0), 11);
				if (CBGetItemNum(ITM_EQUIP_YN, 0, 11) == 1)
				{
					//yes, this item is equippable...
					//can our player equip the item?
					bool bUse = false;
					if (CBGetItemNum(ITM_USEDBY, 0, 11) == 0)
					{
						//item is usable by all
						bUse = true;
					}
					else
					{
						//is our player among those that can equip the item?
						for (int i = 0; i <= 50; i++)
						{
							std::string strPlayer = CBGetItemString(ITM_CHARACTERS, i, 11);
							if (strPlayer.compare(strPlayerHandle) == 0)
							{
								bUse = true;
								break;
							}
						}
					}

					if (bUse)
					{
						bool bUseLocation = false;
						//out player can use this item!
						//check if it can be equipped to this body location...
						int nLocation = nEquipID;
						if (nLocation > 6)
							nLocation = 7;
						if (CBGetItemNum(ITM_EQUIP_LOCATION, nLocation, 11) == 1)
						{
							if (nLocation != 7)
							{
								bUseLocation = true;
							}
							else
							{
								nLocation-=6;
								std::string strAccessoryName = CBGetPlayerString(PLAYER_ACCESSORIES, nLocation, nPlayerID);
								if (strAccessoryName.compare(CBGetItemString(ITM_ACCESSORY, 0, 11)) == 0)
								{
									bUseLocation = true;
								}
							}		
						}

						if (bUseLocation)
						{
							g_strList[nListIdx] = Int2String(CBGetGeneralNum(GEN_INVENTORY_NUM, idx, 0)) + " " +
																		CBGetGeneralString(GEN_INVENTORY_HANDLES, idx, 0);
							g_nMap[nListIdx] = idx;
							nListIdx++;
							
						} //bUseLocation
					} //bUse
				} //item equippable
			} //more than 0 items
		} //item handle exists
	} //for
	return nListIdx;
}

//render a list of items equippable to nPlayerID at body location nEquipID
//nStartPos is the index of the top item to render
//assumes info is in g_strList and g_nMap
//nCount is the number of items in the list array
//thus, DetermineEquippableItems must have been called first
void RenderEquipItems(CNVID cnv, int nCount, int nStartPos)
{
	CNVID cnvEquip = CBCreateCanvas(445, 240);
	CBCanvasFill(cnvEquip, 0);
	

	//Alright, list of items is in strItemList array...
	//now draw the list...
	//now add the list to the canvas...
	for (int i=nStartPos; i < nCount; i++)
	{
		CBCanvasDrawText(cnvEquip, g_strList[i], "Arial", 20, 1, i-nStartPos+1, g_crTextColor, 1, 0, 0, false);
	}


	//now draw the canvas...
	CBCanvas2CanvasBlt(cnvEquip, cnv, 147, 175);
	CBDestroyCanvas(cnvEquip);
}


//check for key presses on the Equip menu...
int EquipMenuScanKeys(int nPlayerID)
{
	bool bDone = false;
	int nEquipID = 0;
	int nItemID = 0;
	std::string strFile = "";
	while (!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			bDone = true;
		}
		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			switch(g_nButton)
			{
				case 0:
					//Equip
					nEquipID = SelectEquip(nPlayerID);
					if (nEquipID != -1)
					{
						nItemID = SelectEquippableItem(nPlayerID, nEquipID);
						if (nItemID != -1)
						{
							//alright!
							//equip to the player...
							EquipToPlayer(nPlayerID, nEquipID, nItemID);
						}
						RenderEquipMenu(nPlayerID);
						DrawCursor();
					}
					break;

				case 1:
					//Remove
					nEquipID = SelectEquip(nPlayerID);
					if (nEquipID != -1)
					{
						EquipRemove(nPlayerID, nEquipID);
						RenderEquipMenu(nPlayerID);
						DrawCursor();
					}
					break;

				case 2:
					break;

				case 3:
					//Return
					bDone = true;
					break;
			}
		}
		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			if (g_nButton == 1)
				g_nButton = 0;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton++;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			if (g_nButton == 0)
				g_nButton = 1;
			else if (g_nButton == 3)
				g_nButton = 3;
			else
				g_nButton--;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN"))
		{
			if (g_nButton >= 0 && g_nButton <= 2)
				g_nButton = 3;
			else 
				g_nButton = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
		if (ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP"))
		{
			if (g_nButton >= 3 && g_nButton <= 6)
				g_nButton = 0;
			else 
				g_nButton = 3;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
			Sleep(90);
		}
	}
	return 1;
}



//draw the cursor based on the button we're pointing at (g_nButton)
void DrawCursor(void)
{
	CBDrawCanvas(g_cnvMenu, g_nOffsetX, g_nOffsetY);

	int x = 0, y = 0;

	switch(g_nButton)
	{
		case 0: // Inventory
			x = 46;
			y = 108;
			break;
		case 1: // Equipment
			x = 153;
			y = 108;
			break;
		case 2: // Abilities
			x = 260;
			y = 108;
			break;
		case 3: // Return
			x = 63;
			y = 445;
			break;
		case 4: // Save
			x = 210;
			y = 445;
			break;
		case 5: // Load
			x = 357;
			y = 445;
			break;
		case 6: // Quit
			x = 504;
			y = 445;
			break;
	}

	CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
	CBRefreshScreen();
}


//render GP, etc
void RenderMainMenuStats(CNVID cnv)
{
	//obtain info...
	std::string strLine[6];
	ObtainOtherInfo(strLine);

	//gp and steps
	CBCanvasDrawText(cnv, strLine[0], "Arial", 18, 22, 5, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[1], "Arial", 18, 22, 6, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[2], "Arial", 18, 22, 7, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[3], "Arial", 18, 22, 8, g_crTextColor, 1, 0, 0, false);

	//time
	CBCanvasDrawText(cnv, strLine[4], "Arial", 18, 28, 5, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[5], "Arial", 18, 28, 6, g_crTextColor, 1, 0, 0, false);
}


//obtain the GP, game time, etc in strings.
void ObtainOtherInfo(std::string* pstrArray)
{
	pstrArray[0] = CBLoadString(1374, "GP") + ":";
	pstrArray[1] = Int2String(CBGetGeneralNum(GEN_GP, 0, 0));
	pstrArray[2] = CBLoadString(2043, "Steps:");
	pstrArray[3] = Int2String(CBGetGeneralNum(GEN_STEPS, 0, 0));
	pstrArray[4] = CBLoadString(2066, "Time:");

	int nGameTime = CBGetGeneralNum(GEN_GAME_TIME, 0, 0);
	int nHrs = nGameTime / 3600;
	int n = nGameTime - nHrs * 3600;
	int nMins = n / 60;
	int nSecs = n - nMins * 60; 
	std::string strHrs = Int2String(nHrs);
	std::string strMins = Int2String(nMins);
	std::string strSecs = Int2String(nSecs);
	if (nHrs < 10)
		strHrs = "0" + strHrs;
	if (nMins < 10)
		strMins = "0" + strMins;
	if (nSecs < 10)
		strSecs = "0" + strSecs;

	pstrArray[5] = strHrs + ":" + strMins + ":" + strSecs;
}


//render player info for main menu
void RenderMainMenuPlayers(CNVID cnv, bool bTransparent)
{
	CNVID cnvPlayer = CBCreateCanvas(112, 250);
	int nX = 25;
	for (int i = 0; i < 5; i++)
	{
		std::string strPlayerFile = CBGetGeneralString(GEN_PLAYERFILES, 0, i);
		if (strPlayerFile.compare("") != 0)
		{
			//this player is loaded...
			if (bTransparent)
				CBCanvasFill(cnvPlayer, g_crTranspColor);
			else
				CBCanvasFill(cnvPlayer, 0);

			RenderPlayerInfo(i, cnvPlayer);

			if (bTransparent)
				CBCanvas2CanvasBltTransparent(cnvPlayer, cnv, nX, 175, g_crTranspColor);
			else
				CBCanvas2CanvasBlt(cnvPlayer, cnv, nX, 175);

			nX += 120;

		}
	}
	CBDestroyCanvas(cnvPlayer);
}

//Put player info into a canvas...
void RenderPlayerInfo(int nSlot, CNVID cnv)
{
	//Get stats...
	std::string strLine[7];
	ObtainPlayerInfo(strLine, nSlot);

	//Print name...
	CBCanvasDrawText(cnv, strLine[0], "Arial", 22, 3.55, 1, g_crTextColor, 1, 0, 0, true);


	//load profile image...
	CNVID cnvPlayer = CBCreateCanvas(96, 96);
	CBCanvasFill(cnvPlayer, g_crTranspColor);
	RenderPlayerProfile(cnvPlayer, nSlot);
	CBCanvas2CanvasBlt(cnvPlayer, cnv, 8, 30);
	CBDestroyCanvas(cnvPlayer);


	CBCanvasDrawText(cnv, strLine[1], "Arial", 16, 1.5, 9, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[2], "Arial", 16, 1.5, 10, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[3], "Arial", 16, 1.5, 11, g_crTextColor, 1, 0, 0, false);

	CBCanvasDrawText(cnv, strLine[4], "Arial", 16, 1.5, 12, g_crTextColor, 1, 0, 0, false);
	CBCanvasDrawText(cnv, strLine[5], "Arial", 16, 1.5, 13, g_crTextColor, 1, 0, 0, false);

	CBCanvasDrawText(cnv, strLine[6], "Arial", 16, 1.5, 14, g_crTextColor, 1, 0, 0, false);

	//Next level box...
	CBCanvasFillRect(cnv, 6, 223, 106, 235, 0);
	CBCanvasFillRect(cnv, 7, 224, 6 + CBGetPlayerNum(PLAYER_NEXTLEVEL, 0, nSlot), 234, rgb(255, 0, 0));
}


//render player profile to a canvas
void RenderPlayerProfile(CNVID cnvPlayer, int nSlot)
{
	std::string strProfile = CBGetPlayerString(PLAYER_PROFILE, 0, nSlot);
	CBCanvasLoadSizedImage(cnvPlayer, strProfile);
}


//Obtain player info.
//assumes pstrArray is already initialized.
void ObtainPlayerInfo(std::string* pstrArray, int nSlot)
{
	//Name...
	std::string strName = CBGetPlayerName(nSlot);
	pstrArray[0] = strName;

	//Level...
	std::string strLevel = Int2String((int)CBGetNumerical(CBGetPlayerString(PLAYER_LEVEL_VAR, 0, nSlot)));
	std::string strText = CBLoadString(886, "Level:") + " " + strLevel;	
	pstrArray[1] = strText;

	//HP...
	std::string strHP = Int2String((int)CBGetPlayerHP(nSlot));
	std::string strMaxHP = Int2String((int)CBGetPlayerMaxHP(nSlot));
	strText = CBLoadString(887, "HP:") + " " + strHP + "/" + strMaxHP;
	pstrArray[2] = strText;

	//SMP
	std::string strSMP = Int2String((int)CBGetPlayerSMP(nSlot));
	std::string strMaxSMP = Int2String((int)CBGetPlayerMaxSMP(nSlot));
	strText = CBLoadString(888, "SMP:") + " " + strSMP + "/" + strMaxSMP;
	pstrArray[3] = strText;

	//FP
	std::string strFP = Int2String((int)CBGetPlayerFP(nSlot));
	strText = CBLoadString(2071, "FP:") + " " + strFP;
	pstrArray[4] = strText;

	//DP
	std::string strDP = Int2String((int)CBGetPlayerDP(nSlot));
	strText = CBLoadString(2072, "DP:") + " " + strDP;
	pstrArray[5] = strText;

	//Next level
	strText = CBLoadString(891, "Next Level:");
	pstrArray[6] = strText;

}


//Allow user to select a player-- return player ID selected
//or -1 if cancelled
int SelectPlayer(bool bDrawPlayers)
{
	if (bDrawPlayers)
		RenderMainMenuPlayers(g_cnvMenu);
	DrawCursor();

	int nMaxPlayers = -1;
	for (int i = 0; i < 5; i++)
	{
		std::string strPlayerFile = CBGetGeneralString(GEN_PLAYERFILES, 0, i);
		if (strPlayerFile.compare("") != 0)
		{
			nMaxPlayers++;
		}
	}

	int nCursor = 0;
	bool bDone = false;
	while(!bDone)
	{
		CBDoEvents();
		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		//draw cursor...
		int x, y;
		x = 45 + 120 * nCursor;
		y = 185;
		CBDrawHand(x + g_nOffsetX, y + g_nOffsetY);
		CBRefreshScreen();

		if (ie.strKey.compare("RIGHT") == 0 || CBCheckKey("JOYRIGHT"))
		{
			nCursor++;
			if (nCursor > nMaxPlayers)
				nCursor = 0;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
		}

		if (ie.strKey.compare("LEFT") == 0 || CBCheckKey("JOYLEFT"))
		{
			nCursor--;
			if (nCursor < 0)
				nCursor = nMaxPlayers;
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
			DrawCursor();
		}

		if (ie.strKey.compare("ENTER") == 0 || CBCheckKey("BUTTON1"))
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			DrawCursor();
			bDone = true;
		}
		if (ie.strKey.compare("ESC") == 0 || CBCheckKey("BUTTON2"))
		{
			DrawCursor();
			return -1;
		}
	}

	//Map the selection to the player array index...
	int cnt = 0;
	for (i = 0; i < 5; i++)
	{
		std::string strPlayerFile = CBGetGeneralString(GEN_PLAYERFILES, 0, i);
		if (strPlayerFile.compare("") != 0)
		{
			if (cnt == nCursor)
			{
				return i;
			}
			cnt++;
		}
	}

	return -1;
}


//put a border around a canvas...
void FrameCanvas(CNVID cnv)
{
	int w = CBCanvasWidth(cnv)-1;
	int h = CBCanvasHeight(cnv)-1;
	CBCanvasDrawLine(cnv, 0, 0, w, 0, rgb(200, 200, 200));
	CBCanvasDrawLine(cnv, 0, 0, 0, h, rgb(200, 200, 200));
	CBCanvasDrawLine(cnv, w, 0, w, h, rgb(200, 200, 200));
	CBCanvasDrawLine(cnv, 0, h, w, h, rgb(200, 200, 200));

	CBCanvasDrawLine(cnv, 1, 1, w-1, 1, rgb(100, 100, 100));
	CBCanvasDrawLine(cnv, 1, 1, 1, h-1, rgb(100, 100, 100));
	CBCanvasDrawLine(cnv, w-1, 1, w-1, h-1, rgb(100, 100, 100));
	CBCanvasDrawLine(cnv, 1, h-1, w-1, h-1, rgb(100, 100, 100));
}