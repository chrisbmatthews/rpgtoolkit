/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews
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

#pragma once

int APIENTRY ZIPTest();

int APIENTRY ZIPCreate(char* pstrZipToCreate, int nTackOntoEndYN);

int APIENTRY ZIPCloseNew();

int APIENTRY ZIPAdd(char* pstrToAdd, char* pstrAddAs);

int APIENTRY ZIPOpen(char* pstrZipToOpen);

int APIENTRY ZIPClose();

int APIENTRY ZIPExtract(char* pstrToExt, char* pstrSaveAs);

int APIENTRY ZIPGetFileCount();

int APIENTRY ZIPGetFile(int nFileNum, char* pstrFileOut);

int APIENTRY ZIPFileExist(char* pstrFileToCheck);

int APIENTRY ZIPCreateCompoundFile(char* pstrOrigFile, char* pstrExtendedFile);

int APIENTRY ZIPIsCompoundFile(char* pstrFileToCheck);

int APIENTRY ZIPExtractCompoundFile(char* pstrOrigFile, char* pstrSaveTo);
