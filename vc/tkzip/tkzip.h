//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

#include "stdafx.h"

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
