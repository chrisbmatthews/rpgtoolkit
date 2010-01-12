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

#include "zip.h"
#include "unzip.h"

#include <direct.h>

//////////////////////////////////
// CreateDir
//
// Create a directory, with all
// required subpaths
//
// pstrPathName - path to create
void CreateDir(char* pstrPathName)
{
	char strPath[MAX_PATH];
	int nLen = strlen(pstrPathName);
	for (int i=0; i< nLen; i++)
	{
		strPath[i] = pstrPathName[i];
		strPath[i+1]=0;
		if (strPath[i] == '\\' || strPath[i] == '/')
		{
			mkdir(strPath);
		}
	}
}

//////////////////////////////////////
//creating zip files...

zipFile CreateZip(char* pstrZipFile, int nTackOntoEndYN)
{
	return zipOpen(pstrZipFile, nTackOntoEndYN);
}


int CloseCreatedZip(zipFile zf)
{
	return zipClose(zf, NULL);
}


int Add(char* pstrFileToAdd, char* pstrAddAs, zipFile zf)
{
	FILE* f = fopen(pstrFileToAdd, "rb");
	if (f)
	{
		zipOpenNewFileInZip(zf, pstrAddAs, NULL, NULL, 0, NULL, 0, NULL, Z_DEFLATED, Z_DEFAULT_COMPRESSION);

		fseek(f, 0, SEEK_END);
		int nLen = ftell(f);
		fseek(f, 0, SEEK_SET);

		for (int i=0; i<nLen; i++)
		{
			unsigned char c;
			fread(&c, 1, sizeof(c), f);
			zipWriteInFileInZip(zf, &c, 1);
		}
		zipCloseFileInZip(zf);
		fclose (f);
		return 1;
	}
	else
	{
		return 0;
	}
}


//////////////////////////////////////
//working with existing zip files...

unzFile OpenZip(char* pstrZipFile)
{
	return unzOpen(pstrZipFile);
}


int CloseZip(unzFile uf)
{
	return unzClose(uf);
}
	

int Extract(char* pstrFileToExtract, char* pstrSaveAs, unzFile uf)
{
	//search for file...
	int a = unzLocateFile(uf, pstrFileToExtract, 2);
	if (a == UNZ_OK)
	{
		//found it!
		FILE* f = fopen(pstrSaveAs, "wb");

		unzOpenCurrentFile(uf);

		while(!unzeof(uf))
		{
			unsigned char c;
			unzReadCurrentFile(uf, &c, 1);
			fwrite(&c, 1, sizeof(c), f);
		}
		unzCloseCurrentFile(uf);		
		fclose(f);
		return 1;
	}
	return 0;
}


bool FileExists(char* pstrFileToFind, unzFile uf)
{
	//search for file...
	int a = unzLocateFile(uf, pstrFileToFind, 2);
	if (a == UNZ_OK)
	{
		return true;
	}
	return false;
}


//count files in zip...
int FilesInZip(unzFile uf)
{
	int nCount = 0;
	int a = unzGoToFirstFile(uf);
	while (a == UNZ_OK)
	{
		nCount ++;
		a = unzGoToNextFile(uf);
	}
	return nCount;
}


//get filename...
//if the i-th file in the zip
//return thru an allocated filename pointer
void GetFile(char* pstrToSaveTo, int nFileNum, unzFile uf)
{
	int nCount = -1;
	int a = unzGoToFirstFile(uf);
	while (a == UNZ_OK)
	{
		nCount ++;
		if (nCount == nFileNum)
		{
			//found it!
			char fileName[MAX_PATH];
			unzGetCurrentFileInfo(uf, NULL, fileName, MAX_PATH, NULL, 0, NULL, 0);
			strcpy(pstrToSaveTo, fileName);
			return;
		}
		a = unzGoToNextFile(uf);
	}
	strcpy(pstrToSaveTo, "");
}

