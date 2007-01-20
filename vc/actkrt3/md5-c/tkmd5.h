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