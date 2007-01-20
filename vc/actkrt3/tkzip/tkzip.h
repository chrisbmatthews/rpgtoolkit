/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Christopher Matthews & contributors
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
 */

#include "stdafx.h"

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