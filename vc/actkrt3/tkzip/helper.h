//helper.h
//helper functions

#include "stdafx.h"

#include <iostream.h>
#include <direct.h>

#include "zip.h"
#include "unzip.h"

/*void AddFiles(zipFile zf,
							char* pstrSearchParam, 
							char* pstrSourceDir, 
							bool bRecurse = true);*/

void CreateDir(char* pstrPathName);

/*
//////////////////////////////////
// AddFiles
//
// Add files in directory and subdir
//
// zf- zip file to add to.
// pstrExcludeFile - file to exclude.
// pstrSearchParam - wildcard, like *.*
// pstrSourceDir - just a dir that is tacked onto the front
//								of the file.
// bRecurse - recurse subdir?
void AddFiles(zipFile zf,
							char* pstrExcludeFile, 
							char* pstrSearchParam, 
							char* pstrSourceDir, 
							bool bRecurse)
{
	WIN32_FIND_DATA fd;
	HANDLE hFindFile = FindFirstFile(pstrSearchParam, &fd);
	int nGood = 1;
	while (nGood)
	{
		if (nGood)
		{
			//check if it's a dir...
			if (fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY)
			{
				if (bRecurse)
				{
					if (strcmp(fd.cFileName, ".") && strcmp(fd.cFileName, ".."))
					{
						char strCurDir[MAX_PATH];
						char strSource[MAX_PATH];
						getcwd(strCurDir, MAX_PATH);
						chdir(fd.cFileName);
						strcpy(strSource, fd.cFileName);
						strcat(strSource, "\\");
						AddFiles(zf, pstrExcludeFile, pstrSearchParam, strSource, bRecurse);
						chdir(strCurDir);
					}
				}
			}
			else
			{
				if (strcmpi(pstrExcludeFile, fd.cFileName))
				{
					char strCurDir[MAX_PATH];
					strcpy(strCurDir, pstrSourceDir);
					strcat(strCurDir, fd.cFileName);
					cout << "Adding " << strCurDir << endl;
					Add(fd.cFileName, strCurDir, zf);
				}
			}
		}
		nGood = FindNextFile(hFindFile, &fd);
	}
	FindClose(hFindFile);
}
*/


//////////////////////////////////
// ExtractFiles
//
// Extract pakfile 
//
// uf - unzip file
// pstrExpandDir - dir to expand into
void ExtractFiles(unzFile uf, char* pstrExpandDir)
{
	mkdir(pstrExpandDir);
	for (int i=0; i<FilesInZip(uf); i++)
	{
		char thisFile[MAX_PATH];
		GetFile(thisFile, i, uf);
		//cout << "Extracting " << thisFile << endl; 
		char strPath[MAX_PATH];
		strcpy(strPath, pstrExpandDir);
		strcat(strPath, thisFile);
		CreateDir(strPath);
		Extract(thisFile, strPath, uf); 
	}
}


