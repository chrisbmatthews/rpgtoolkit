/*
 ********************************************************************
 * The RPG Toolkit Version 3 Menu System
 * This file copyright (C) 2003-2007  Christopher B. Matthews
 ********************************************************************
 *
 * This file is released under the AC Open License Derivative v 1.0
 * See "AC Open License Derivative.txt" for details
 */

#include "sdk\tkplugin.h"

#ifndef MENU_H
#define MENU_H

void BeginMenu(void);

void EndMenu(void);

void MainMenu(void);
void RenderMainMenu(void);
void ObtainOtherInfo(std::string* pstrArray);
void RenderMainMenuStats(CNVID cnv);
void RenderMainMenuPlayers(CNVID cnv, bool bTransparent = true);
void RenderMainMenuOptions(CNVID cnv);
int MainMenuScanKeys(void);

void ItemMenu(void);
void RenderItemMenu(bool bShowContent = true);
void RenderItemList(CNVID cnv, int nPage);
void RenderItemSublist(int nSublistNumber, CNVID cnv);
void RenderItemOptions(CNVID cnv);
int SelectItem(void);
void ItemShowInfo(int nItemIndex);
void ItemDrop(int nItemIndex);
void ItemUse(int nItemID, int nPlayerID);
int ItemMenuScanKeys(void);

void EquipMenu(int nPlayerID);
int EquipMenuScanKeys(int nPlayerID);
void RenderEquipMenu(int nPlayerID);
void RenderEquipList(CNVID cnv, int nPlayerID, int nStartPos);
void RenderEquipOptions(CNVID cnv);
int SelectEquip(int nPlayerID);
void EquipRemove(int nPlayerID, int nEquipID);
int SelectEquippableItem(int nPlayerID, int nEquipID);
int DetermineEquippableItems(int nPlayerID, int nEquipID);
void RenderEquipItems(CNVID cnv, int nCount, int nStartPos);
void EquipToPlayer(int nPlayerID, int nEquipID, int nItemID);

void AbilitiesMenu(int nPlayerID);
void RenderAbilitiesMenu(int nPlayerID, bool bRenderInfo);
void RenderAbilitiesList(CNVID cnv, int nPlayerID, int nStartPos);
void RenderAbilitiesOptions(CNVID cnv);
int AbilitiesMenuScanKeys(int nPlayerID);
int SelectAbility(int nPlayerID);
void AbilityInfo(int nPlayerID, int nAbilityID);
void AbilityUse(int nPlayerID, int nAbilityID, int nSelectedPlayer);

void RenderPlayerInfo(int nSlot, CNVID cnv);
void RenderPlayerProfile(CNVID cnvPlayer, int nSlot);
void ObtainPlayerInfo(std::string* pstrArray, int nSlot);

int SelectPlayer(bool bDrawPlayers);

void FrameCanvas(CNVID cnv);

void DrawCursor(void);

#endif