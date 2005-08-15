/* this file contains the actual definitions of */
/* the IIDs and CLSIDs */

/* link this file in with the server and any clients */


/* File created by MIDL compiler version 5.01.0164 */
/* at Mon Aug 15 00:27:14 2005
 */
/* Compiler settings for C:\Program Files\GNU\WinCvs 2.0\tk3\vc\trans3\trans3.idl:
    Oicf (OptLev=i2), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )
#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

const IID IID_ICallbacks = {0xC146901F,0xABFA,0x4D24,{0xA4,0xF2,0xD8,0x3C,0x96,0x1D,0x37,0xB9}};


const IID LIBID_TRANS3Lib = {0xE3916E35,0x68ED,0x4C43,{0x88,0xEE,0x03,0xC4,0xAA,0xA5,0x69,0xB8}};


const CLSID CLSID_Callbacks = {0x6FD78CD3,0xF15B,0x4092,{0xB5,0x49,0xEB,0x07,0xDE,0xC9,0x94,0x32}};


#ifdef __cplusplus
}
#endif

