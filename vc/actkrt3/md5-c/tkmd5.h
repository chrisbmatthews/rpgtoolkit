///////////////////////////////////
// TKMd5.h
// Interface with md5 checksumming system


#ifndef TKMD5_H
#define TKMD5_H

#include "global.h"
//#include "md5.h"

typedef struct {
  UINT4 state[4];                                   /* state (ABCD) */
  UINT4 count[2];        /* number of bits, modulo 2^64 (lsb first) */
  unsigned char buffer[64];                         /* input buffer */
} MD5_CTX;

extern "C" void MD5Init(MD5_CTX *);
extern "C" void MD5Update(MD5_CTX *, unsigned char *, unsigned int);
extern "C" void MD5Final(unsigned char [16], MD5_CTX *);


int APIENTRY MD5String(char* pstrString, char* pstrReturnBuffer);

int APIENTRY MD5File(char* pstrString, char* pstrReturnBuffer);

#endif