/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "animation.h"
#include "paths.h"
#include "CFile.h"

/*
 * Open an animation.
 *
 * fileName (in) - file to open
 */
void tagAnimation::open(const std::string fileName)
{

	CFile file(fileName);

	std::string fileHeader;
	file >> fileHeader;
	if (fileHeader == "RPGTLKIT ANIM")
	{
		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;
		if (minorVer == 3)
		{
			file >> animSizeX;
			file >> animSizeY;
			file >> animFrames;
			animFrame.clear();
			animTransp.clear();
			animSound.clear();
			for (unsigned int i = 0; i <= animFrames; i++)
			{
				std::string str;
				int num;
				file >> str;
				animFrame.push_back(str);
				file >> num;
				animTransp.push_back(num);
				file >> str;
				animSound.push_back(str);
			}
			file >> animPause;
		}
		else
		{
			MessageBox(NULL, ("This is not a valid animaton file. " + fileName).c_str(), NULL, 0);
		}
 	}
	else
	{
		file.seek(0);
		if (file.line() != "RPGTLKIT ANIM")
		{
			MessageBox(NULL, ("This is not a valid animaton file. " + fileName).c_str(), NULL, 0);
			return;
		}
		file.line();
		file.line();
		animSizeX = atoi(file.line().c_str());
		animSizeY = atoi(file.line().c_str());
		animFrames = atoi(file.line().c_str());
		animFrame.clear();
		animTransp.clear();
		animSound.clear();
		for (unsigned int i = 0; i <= animFrames; i++)
		{
			animFrame.push_back(file.line());
			animTransp.push_back(atoi(file.line().c_str()));
			animSound.push_back(file.line());
		}
		animPause = atof(file.line().c_str());
	}

	animFile = removePath(fileName);

}

/*
 * Save an animation.
 *
 * fileName (in) - file to save to
 */
void tagAnimation::save(const std::string fileName) const
{

	CFile file(fileName, OF_CREATE | OF_WRITE);

	file << "RPGTLKIT ANIM";
	file << short(2);
	file << short(3);
	file << animSizeX;
	file << animSizeY;

	const int frames = animFrame.size() - 1;
	file << frames;
	for (unsigned int i = 0; i <= frames; i++)
	{
		file << animFrame[i];
		file << animTransp[i];
		file << animSound[i];
	}

	file << animPause;

}
