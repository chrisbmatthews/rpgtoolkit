///////////////////////////
// tkmd5.cpp
// Implementation of md5 interface routines.

#include "..\stdafx.h"
#include "tkmd5.h"


//assumes digest is 16 chars long...
void convertHexString(unsigned char* digest, char* pstrString)
{
	for (int i = 0; i < 16; i++)
	{
		unsigned char c = digest[i];
		char c1 = c / 16;
		char c2 = c % 16;
		if (c1 < 10)
		{
			c1 = c1 + 48;
		}
		else
		{
			c1 = c1 + 87;
		}
		if (c2 < 10)
		{
			c2 = c2 + 48;
		}
		else
		{
			c2 = c2 + 87;
		}
		pstrString[i*2] = c1;
		pstrString[i*2 + 1] = c2;
		pstrString[i*2 + 2] = 0;
	}
}


int APIENTRY MD5String(char* pstrString, char* pstrReturnBuffer)
{
	MD5_CTX context;
	unsigned char digest[16];
	unsigned int len = strlen (pstrString);

	MD5Init (&context);
	MD5Update (&context, (unsigned char*)pstrString, len);
	MD5Final (digest, &context);

	convertHexString(digest, pstrReturnBuffer);
	return strlen(pstrReturnBuffer);
}


int APIENTRY MD5File(char* pstrFile, char* pstrReturnBuffer)
{
	FILE *file;
	MD5_CTX context;
	int len;
	unsigned char buffer[1024], digest[16];

	if ((file = fopen (pstrFile, "rb")) == NULL)
		return MD5String("", pstrReturnBuffer);
	else 
	{
		MD5Init (&context);
		while (len = fread (buffer, 1, 1024, file))
			MD5Update (&context, buffer, len);
		MD5Final (digest, &context);

		fclose (file);

		convertHexString(digest, pstrReturnBuffer);
		return strlen(pstrReturnBuffer);
	}
}