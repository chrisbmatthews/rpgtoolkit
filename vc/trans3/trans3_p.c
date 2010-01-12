

/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 7.00.0500 */
/* at Mon Jan 11 22:59:18 2010
 */
/* Compiler settings for .\trans3.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#if !defined(_M_IA64) && !defined(_M_AMD64)


#pragma warning( disable: 4049 )  /* more than 64k source lines */
#if _MSC_VER >= 1200
#pragma warning(push)
#endif

#pragma warning( disable: 4211 )  /* redefine extern to static */
#pragma warning( disable: 4232 )  /* dllimport identity*/
#pragma warning( disable: 4024 )  /* array to pointer mapping*/
#pragma warning( disable: 4152 )  /* function/data pointer conversion in expression */
#pragma warning( disable: 4100 ) /* unreferenced arguments in x86 call */

#pragma optimize("", off ) 

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 475
#endif


#include "rpcproxy.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif // __RPCPROXY_H_VERSION__


#include "trans3.h"

#define TYPE_FORMAT_STRING_SIZE   69                                
#define PROC_FORMAT_STRING_SIZE   6817                              
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   1            

typedef struct _trans3_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } trans3_MIDL_TYPE_FORMAT_STRING;

typedef struct _trans3_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } trans3_MIDL_PROC_FORMAT_STRING;

typedef struct _trans3_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } trans3_MIDL_EXPR_FORMAT_STRING;


static RPC_SYNTAX_IDENTIFIER  _RpcTransferSyntax = 
{{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}};


extern const trans3_MIDL_TYPE_FORMAT_STRING trans3__MIDL_TypeFormatString;
extern const trans3_MIDL_PROC_FORMAT_STRING trans3__MIDL_ProcFormatString;
extern const trans3_MIDL_EXPR_FORMAT_STRING trans3__MIDL_ExprFormatString;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO ICallbacks_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO ICallbacks_ProxyInfo;

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterName_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [string][retval][out] */ BSTR *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[5916],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterAnimation_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [string] */ BSTR animationName,
    /* [string][retval][out] */ BSTR *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[5964],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterChargePercent_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6018],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightTick_Proxy( 
    ICallbacks * This)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6066],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawTextAbsolute_Proxy( 
    ICallbacks * This,
    /* [string] */ BSTR text,
    /* [string] */ BSTR font,
    int size,
    int x,
    int y,
    int crColor,
    int isBold,
    int isItalics,
    int isUnderline,
    int isCentred,
    /* [defaultvalue][in] */ int isOutlined,
    /* [retval][out] */ int *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6096],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseFighterCharge_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6198],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightDoAttack_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    int amount,
    int toSMP,
    /* [retval][out] */ int *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6240],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseItem_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR itemFile)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6312],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseSpecialMove_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR moveFile)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6372],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDoEvents_Proxy( 
    ICallbacks * This)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6432],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterAddStatusEffect_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6462],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterRemoveStatusEffect_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6510],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckMusic_Proxy( 
    ICallbacks * This)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6558],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseScreenDC_Proxy( 
    ICallbacks * This)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6588],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasOpenHdc_Proxy( 
    ICallbacks * This,
    int cnv,
    /* [retval][out] */ int *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6618],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasCloseHdc_Proxy( 
    ICallbacks * This,
    int cnv,
    int hdc)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6660],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFileExists_Proxy( 
    ICallbacks * This,
    /* [string] */ BSTR strFile,
    /* [retval][out] */ short *pRet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6702],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLock_Proxy( 
    ICallbacks * This,
    int cnv)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6744],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasUnlock_Proxy( 
    ICallbacks * This,
    int cnv)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &trans3__MIDL_ProcFormatString.Format[6780],
                  ( unsigned char * )&This);
return ( HRESULT  )_RetVal.Simple;

}


extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN32__)
#error  Invalid build platform for this stub.
#endif

#if !(TARGET_IS_NT50_OR_LATER)
#error You need a Windows 2000 or later to run this stub because it uses these features:
#error   /robust command line switch.
#error However, your C/C++ compilation flags indicate you intend to run this app on earlier systems.
#error This app will fail with the RPC_X_WRONG_STUB_VERSION error.
#endif


static const trans3_MIDL_PROC_FORMAT_STRING trans3__MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure CBRpgCode */

			0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/*  2 */	NdrFcLong( 0x0 ),	/* 0 */
/*  6 */	NdrFcShort( 0x7 ),	/* 7 */
/*  8 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 10 */	NdrFcShort( 0x0 ),	/* 0 */
/* 12 */	NdrFcShort( 0x8 ),	/* 8 */
/* 14 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x2,		/* 2 */
/* 16 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 18 */	NdrFcShort( 0x0 ),	/* 0 */
/* 20 */	NdrFcShort( 0x1 ),	/* 1 */
/* 22 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 24 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 26 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 28 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 30 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 32 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 34 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetString */

/* 36 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 38 */	NdrFcLong( 0x0 ),	/* 0 */
/* 42 */	NdrFcShort( 0x8 ),	/* 8 */
/* 44 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 46 */	NdrFcShort( 0x0 ),	/* 0 */
/* 48 */	NdrFcShort( 0x8 ),	/* 8 */
/* 50 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 52 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 54 */	NdrFcShort( 0x1 ),	/* 1 */
/* 56 */	NdrFcShort( 0x4 ),	/* 4 */
/* 58 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter varname */

/* 60 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 62 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 64 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 66 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 68 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 70 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 72 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 74 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 76 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetNumerical */

/* 78 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 80 */	NdrFcLong( 0x0 ),	/* 0 */
/* 84 */	NdrFcShort( 0x9 ),	/* 9 */
/* 86 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 88 */	NdrFcShort( 0x0 ),	/* 0 */
/* 90 */	NdrFcShort( 0x2c ),	/* 44 */
/* 92 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 94 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 96 */	NdrFcShort( 0x0 ),	/* 0 */
/* 98 */	NdrFcShort( 0x1 ),	/* 1 */
/* 100 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter varname */

/* 102 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 104 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 106 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 108 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 110 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 112 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 114 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 116 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 118 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetString */

/* 120 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 122 */	NdrFcLong( 0x0 ),	/* 0 */
/* 126 */	NdrFcShort( 0xa ),	/* 10 */
/* 128 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 130 */	NdrFcShort( 0x0 ),	/* 0 */
/* 132 */	NdrFcShort( 0x8 ),	/* 8 */
/* 134 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 136 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 138 */	NdrFcShort( 0x0 ),	/* 0 */
/* 140 */	NdrFcShort( 0xc ),	/* 12 */
/* 142 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter varname */

/* 144 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 146 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 148 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter newValue */

/* 150 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 152 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 154 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 156 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 158 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 160 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetNumerical */

/* 162 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 164 */	NdrFcLong( 0x0 ),	/* 0 */
/* 168 */	NdrFcShort( 0xb ),	/* 11 */
/* 170 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 172 */	NdrFcShort( 0x10 ),	/* 16 */
/* 174 */	NdrFcShort( 0x8 ),	/* 8 */
/* 176 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 178 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 180 */	NdrFcShort( 0x0 ),	/* 0 */
/* 182 */	NdrFcShort( 0x6 ),	/* 6 */
/* 184 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter varname */

/* 186 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 188 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 190 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter newValue */

/* 192 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 194 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 196 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 198 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 200 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 202 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScreenDC */

/* 204 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 206 */	NdrFcLong( 0x0 ),	/* 0 */
/* 210 */	NdrFcShort( 0xc ),	/* 12 */
/* 212 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 214 */	NdrFcShort( 0x0 ),	/* 0 */
/* 216 */	NdrFcShort( 0x24 ),	/* 36 */
/* 218 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 220 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 222 */	NdrFcShort( 0x0 ),	/* 0 */
/* 224 */	NdrFcShort( 0x0 ),	/* 0 */
/* 226 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 228 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 230 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 232 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 234 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 236 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScratch1DC */

/* 240 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 242 */	NdrFcLong( 0x0 ),	/* 0 */
/* 246 */	NdrFcShort( 0xd ),	/* 13 */
/* 248 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 250 */	NdrFcShort( 0x0 ),	/* 0 */
/* 252 */	NdrFcShort( 0x24 ),	/* 36 */
/* 254 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 256 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 260 */	NdrFcShort( 0x0 ),	/* 0 */
/* 262 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 264 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 266 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 270 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 272 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScratch2DC */

/* 276 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 278 */	NdrFcLong( 0x0 ),	/* 0 */
/* 282 */	NdrFcShort( 0xe ),	/* 14 */
/* 284 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 286 */	NdrFcShort( 0x0 ),	/* 0 */
/* 288 */	NdrFcShort( 0x24 ),	/* 36 */
/* 290 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 292 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 294 */	NdrFcShort( 0x0 ),	/* 0 */
/* 296 */	NdrFcShort( 0x0 ),	/* 0 */
/* 298 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 300 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 302 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 304 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 306 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 308 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 310 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetMwinDC */

/* 312 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 314 */	NdrFcLong( 0x0 ),	/* 0 */
/* 318 */	NdrFcShort( 0xf ),	/* 15 */
/* 320 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 322 */	NdrFcShort( 0x0 ),	/* 0 */
/* 324 */	NdrFcShort( 0x24 ),	/* 36 */
/* 326 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 328 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 332 */	NdrFcShort( 0x0 ),	/* 0 */
/* 334 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 336 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 338 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 340 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 342 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 344 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 346 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBPopupMwin */

/* 348 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 350 */	NdrFcLong( 0x0 ),	/* 0 */
/* 354 */	NdrFcShort( 0x10 ),	/* 16 */
/* 356 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 358 */	NdrFcShort( 0x0 ),	/* 0 */
/* 360 */	NdrFcShort( 0x24 ),	/* 36 */
/* 362 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 364 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 366 */	NdrFcShort( 0x0 ),	/* 0 */
/* 368 */	NdrFcShort( 0x0 ),	/* 0 */
/* 370 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 372 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 374 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 376 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 378 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 380 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 382 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBHideMwin */

/* 384 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 386 */	NdrFcLong( 0x0 ),	/* 0 */
/* 390 */	NdrFcShort( 0x11 ),	/* 17 */
/* 392 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 394 */	NdrFcShort( 0x0 ),	/* 0 */
/* 396 */	NdrFcShort( 0x24 ),	/* 36 */
/* 398 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 400 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 402 */	NdrFcShort( 0x0 ),	/* 0 */
/* 404 */	NdrFcShort( 0x0 ),	/* 0 */
/* 406 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 408 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 410 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 412 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 414 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 416 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 418 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadEnemy */

/* 420 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 422 */	NdrFcLong( 0x0 ),	/* 0 */
/* 426 */	NdrFcShort( 0x12 ),	/* 18 */
/* 428 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 430 */	NdrFcShort( 0x8 ),	/* 8 */
/* 432 */	NdrFcShort( 0x8 ),	/* 8 */
/* 434 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 436 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 438 */	NdrFcShort( 0x0 ),	/* 0 */
/* 440 */	NdrFcShort( 0x6 ),	/* 6 */
/* 442 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter file */

/* 444 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 446 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 448 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter eneSlot */

/* 450 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 452 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 454 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 456 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 458 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyNum */

/* 462 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 464 */	NdrFcLong( 0x0 ),	/* 0 */
/* 468 */	NdrFcShort( 0x13 ),	/* 19 */
/* 470 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 472 */	NdrFcShort( 0x10 ),	/* 16 */
/* 474 */	NdrFcShort( 0x24 ),	/* 36 */
/* 476 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 478 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 480 */	NdrFcShort( 0x0 ),	/* 0 */
/* 482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 484 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 486 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 488 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 490 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 492 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 494 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 496 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 498 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 500 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 502 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 504 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 506 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 508 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyString */

/* 510 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 512 */	NdrFcLong( 0x0 ),	/* 0 */
/* 516 */	NdrFcShort( 0x14 ),	/* 20 */
/* 518 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 520 */	NdrFcShort( 0x10 ),	/* 16 */
/* 522 */	NdrFcShort( 0x8 ),	/* 8 */
/* 524 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x4,		/* 4 */
/* 526 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 528 */	NdrFcShort( 0x1 ),	/* 1 */
/* 530 */	NdrFcShort( 0x0 ),	/* 0 */
/* 532 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 534 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 536 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 538 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 540 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 542 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 544 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 546 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 548 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 550 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 552 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 554 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 556 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyNum */

/* 558 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 560 */	NdrFcLong( 0x0 ),	/* 0 */
/* 564 */	NdrFcShort( 0x15 ),	/* 21 */
/* 566 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 568 */	NdrFcShort( 0x18 ),	/* 24 */
/* 570 */	NdrFcShort( 0x8 ),	/* 8 */
/* 572 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 574 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 576 */	NdrFcShort( 0x0 ),	/* 0 */
/* 578 */	NdrFcShort( 0x0 ),	/* 0 */
/* 580 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 582 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 584 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newValue */

/* 588 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 590 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 594 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 596 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 600 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 602 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 604 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyString */

/* 606 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 608 */	NdrFcLong( 0x0 ),	/* 0 */
/* 612 */	NdrFcShort( 0x16 ),	/* 22 */
/* 614 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 616 */	NdrFcShort( 0x10 ),	/* 16 */
/* 618 */	NdrFcShort( 0x8 ),	/* 8 */
/* 620 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 622 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 624 */	NdrFcShort( 0x0 ),	/* 0 */
/* 626 */	NdrFcShort( 0x1 ),	/* 1 */
/* 628 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 630 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 632 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 634 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newValue */

/* 636 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 638 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 640 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter eneSlot */

/* 642 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 644 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 646 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 648 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 650 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 652 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerNum */

/* 654 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 656 */	NdrFcLong( 0x0 ),	/* 0 */
/* 660 */	NdrFcShort( 0x17 ),	/* 23 */
/* 662 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 664 */	NdrFcShort( 0x18 ),	/* 24 */
/* 666 */	NdrFcShort( 0x24 ),	/* 36 */
/* 668 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 670 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 672 */	NdrFcShort( 0x0 ),	/* 0 */
/* 674 */	NdrFcShort( 0x0 ),	/* 0 */
/* 676 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 678 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 680 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 682 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 684 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 686 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 688 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 690 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 692 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 694 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 696 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 698 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 700 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 702 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 704 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerString */

/* 708 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 710 */	NdrFcLong( 0x0 ),	/* 0 */
/* 714 */	NdrFcShort( 0x18 ),	/* 24 */
/* 716 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 718 */	NdrFcShort( 0x18 ),	/* 24 */
/* 720 */	NdrFcShort( 0x8 ),	/* 8 */
/* 722 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x5,		/* 5 */
/* 724 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 726 */	NdrFcShort( 0x1 ),	/* 1 */
/* 728 */	NdrFcShort( 0x0 ),	/* 0 */
/* 730 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 732 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 734 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 736 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 738 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 740 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 742 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 744 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 746 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 748 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 750 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 752 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 754 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 756 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 758 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 760 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerNum */

/* 762 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 764 */	NdrFcLong( 0x0 ),	/* 0 */
/* 768 */	NdrFcShort( 0x19 ),	/* 25 */
/* 770 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 772 */	NdrFcShort( 0x20 ),	/* 32 */
/* 774 */	NdrFcShort( 0x8 ),	/* 8 */
/* 776 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 778 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 780 */	NdrFcShort( 0x0 ),	/* 0 */
/* 782 */	NdrFcShort( 0x0 ),	/* 0 */
/* 784 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 786 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 788 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 790 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 792 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 794 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 796 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 798 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 800 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 802 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 804 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 806 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 808 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 810 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 812 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 814 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerString */

/* 816 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 818 */	NdrFcLong( 0x0 ),	/* 0 */
/* 822 */	NdrFcShort( 0x1a ),	/* 26 */
/* 824 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 826 */	NdrFcShort( 0x18 ),	/* 24 */
/* 828 */	NdrFcShort( 0x8 ),	/* 8 */
/* 830 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 832 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 834 */	NdrFcShort( 0x0 ),	/* 0 */
/* 836 */	NdrFcShort( 0x1 ),	/* 1 */
/* 838 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 840 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 842 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 844 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 846 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 848 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 850 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 852 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 854 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 856 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter playerSlot */

/* 858 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 860 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 862 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 864 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 866 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetGeneralString */

/* 870 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 872 */	NdrFcLong( 0x0 ),	/* 0 */
/* 876 */	NdrFcShort( 0x1b ),	/* 27 */
/* 878 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 880 */	NdrFcShort( 0x18 ),	/* 24 */
/* 882 */	NdrFcShort( 0x8 ),	/* 8 */
/* 884 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x5,		/* 5 */
/* 886 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 888 */	NdrFcShort( 0x1 ),	/* 1 */
/* 890 */	NdrFcShort( 0x0 ),	/* 0 */
/* 892 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 894 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 896 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 898 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 900 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 902 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 904 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 906 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 908 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 910 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 912 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 914 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 916 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 918 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 920 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 922 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetGeneralNum */

/* 924 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 926 */	NdrFcLong( 0x0 ),	/* 0 */
/* 930 */	NdrFcShort( 0x1c ),	/* 28 */
/* 932 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 934 */	NdrFcShort( 0x18 ),	/* 24 */
/* 936 */	NdrFcShort( 0x24 ),	/* 36 */
/* 938 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 940 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 942 */	NdrFcShort( 0x0 ),	/* 0 */
/* 944 */	NdrFcShort( 0x0 ),	/* 0 */
/* 946 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 948 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 950 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 952 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 954 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 956 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 958 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 960 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 962 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 964 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 966 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 968 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 970 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 972 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 974 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 976 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetGeneralString */

/* 978 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 980 */	NdrFcLong( 0x0 ),	/* 0 */
/* 984 */	NdrFcShort( 0x1d ),	/* 29 */
/* 986 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 988 */	NdrFcShort( 0x18 ),	/* 24 */
/* 990 */	NdrFcShort( 0x8 ),	/* 8 */
/* 992 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 994 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 996 */	NdrFcShort( 0x0 ),	/* 0 */
/* 998 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1000 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1002 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1004 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1006 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1008 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1010 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1012 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 1014 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1016 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1018 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 1020 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1022 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1024 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 1026 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1028 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1030 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetGeneralNum */

/* 1032 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1034 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1038 */	NdrFcShort( 0x1e ),	/* 30 */
/* 1040 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1042 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1044 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1046 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 1048 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1050 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1054 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1056 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1058 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1060 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1062 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1064 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1066 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 1068 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1070 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1072 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 1074 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1076 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1078 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1080 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1082 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1084 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetCommandName */

/* 1086 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1088 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1092 */	NdrFcShort( 0x1f ),	/* 31 */
/* 1094 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1096 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1098 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1100 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1102 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 1104 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1106 */	NdrFcShort( 0xc ),	/* 12 */
/* 1108 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1110 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1112 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1114 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1116 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1118 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1120 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1122 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1124 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1126 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBrackets */

/* 1128 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1130 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1134 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1136 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1138 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1140 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1142 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1144 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 1146 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1148 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1150 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1152 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1154 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1156 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1158 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1160 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1162 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1164 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1166 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1168 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCountBracketElements */

/* 1170 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1172 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1176 */	NdrFcShort( 0x21 ),	/* 33 */
/* 1178 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1180 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1182 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1184 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1186 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1190 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1192 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1194 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1196 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1198 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1200 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1202 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1206 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1208 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1210 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBracketElement */

/* 1212 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1214 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1218 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1220 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1222 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1224 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1226 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 1228 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 1230 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1232 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1234 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1236 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1238 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1240 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter elemNum */

/* 1242 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1244 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1246 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1248 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1250 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1252 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1254 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1256 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1258 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetStringElementValue */

/* 1260 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1262 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1266 */	NdrFcShort( 0x23 ),	/* 35 */
/* 1268 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1270 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1272 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1274 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1276 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 1278 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1280 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1282 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1284 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1286 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1288 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1290 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1292 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1294 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1296 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1298 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1300 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetNumElementValue */

/* 1302 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1304 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1308 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1310 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1312 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1314 */	NdrFcShort( 0x2c ),	/* 44 */
/* 1316 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1318 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1320 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1322 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1324 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1326 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1328 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1330 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1332 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1334 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1336 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 1338 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1340 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1342 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetElementType */

/* 1344 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1346 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1350 */	NdrFcShort( 0x25 ),	/* 37 */
/* 1352 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1354 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1356 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1358 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1360 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1362 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1364 */	NdrFcShort( 0x14 ),	/* 20 */
/* 1366 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter rpgcodeCommand */

/* 1368 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1370 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1372 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 1374 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1376 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1378 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1380 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1382 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1384 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDebugMessage */

/* 1386 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1388 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1392 */	NdrFcShort( 0x26 ),	/* 38 */
/* 1394 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1396 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1398 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1400 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x2,		/* 2 */
/* 1402 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1404 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1406 */	NdrFcShort( 0x14 ),	/* 20 */
/* 1408 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter message */

/* 1410 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1412 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1414 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 1416 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1418 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1420 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPathString */

/* 1422 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1424 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1428 */	NdrFcShort( 0x27 ),	/* 39 */
/* 1430 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1432 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1434 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1436 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x3,		/* 3 */
/* 1438 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 1440 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1442 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1444 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1446 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1448 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1450 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1452 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1454 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1456 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1458 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1460 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1462 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadSpecialMove */

/* 1464 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1466 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1470 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1472 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1474 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1476 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1478 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x2,		/* 2 */
/* 1480 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1484 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1486 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter file */

/* 1488 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1490 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1492 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 1494 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1496 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1498 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveString */

/* 1500 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1502 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1506 */	NdrFcShort( 0x29 ),	/* 41 */
/* 1508 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1510 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1512 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1514 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x3,		/* 3 */
/* 1516 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 1518 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1522 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1524 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1526 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1528 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1530 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1532 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1534 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1536 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1538 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1540 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveNum */

/* 1542 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1544 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1548 */	NdrFcShort( 0x2a ),	/* 42 */
/* 1550 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1552 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1554 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1556 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 1558 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1560 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1562 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1564 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1566 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1568 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1572 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1574 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1576 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1578 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1580 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1582 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadItem */

/* 1584 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1586 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1590 */	NdrFcShort( 0x2b ),	/* 43 */
/* 1592 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1594 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1596 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1598 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1600 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1602 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1604 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1606 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter file */

/* 1608 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1610 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1612 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter itmSlot */

/* 1614 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1616 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1618 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1620 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1622 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1624 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetItemString */

/* 1626 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1628 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1632 */	NdrFcShort( 0x2c ),	/* 44 */
/* 1634 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1636 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1638 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1640 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x5,		/* 5 */
/* 1642 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 1644 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1648 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1650 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1652 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1654 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1656 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1658 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itmSlot */

/* 1662 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1664 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1668 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1670 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1672 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1674 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1676 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1678 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetItemNum */

/* 1680 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1682 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1686 */	NdrFcShort( 0x2d ),	/* 45 */
/* 1688 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1690 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1692 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1694 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 1696 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1700 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1702 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1704 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1706 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1708 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1710 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1712 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1714 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itmSlot */

/* 1716 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1718 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1720 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1722 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1724 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1726 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1728 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1730 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1732 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBoardNum */

/* 1734 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1736 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1740 */	NdrFcShort( 0x2e ),	/* 46 */
/* 1742 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 1744 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1746 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1748 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x6,		/* 6 */
/* 1750 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1752 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1754 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1756 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1758 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1760 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1762 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1764 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1766 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1768 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1770 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1772 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1774 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1776 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1778 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1780 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1782 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1784 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1786 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1788 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1790 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1792 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBoardString */

/* 1794 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1796 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1800 */	NdrFcShort( 0x2f ),	/* 47 */
/* 1802 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 1804 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1806 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1808 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x6,		/* 6 */
/* 1810 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 1812 */	NdrFcShort( 0x19 ),	/* 25 */
/* 1814 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1816 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1818 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1820 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1822 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1824 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1826 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1828 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1830 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1832 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1834 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1836 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1838 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1840 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1842 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 1844 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1846 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 1848 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1850 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1852 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetBoardNum */

/* 1854 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1856 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1860 */	NdrFcShort( 0x30 ),	/* 48 */
/* 1862 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 1864 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1866 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1868 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x6,		/* 6 */
/* 1870 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1872 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1874 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1876 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1878 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1880 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1882 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1884 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1886 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1888 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1890 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1892 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1894 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1896 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1898 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1900 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter nValue */

/* 1902 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1904 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1906 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1908 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1910 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1912 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetBoardString */

/* 1914 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1916 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1920 */	NdrFcShort( 0x31 ),	/* 49 */
/* 1922 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 1924 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1926 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1928 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x6,		/* 6 */
/* 1930 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 1932 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1934 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1936 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter infoCode */

/* 1938 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1940 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 1942 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1944 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1946 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 1948 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1950 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1952 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1954 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1956 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1958 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 1960 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 1962 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1964 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 1966 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 1968 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1970 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 1972 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetHwnd */

/* 1974 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1976 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1980 */	NdrFcShort( 0x32 ),	/* 50 */
/* 1982 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 1984 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1986 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1988 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1990 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 1992 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1994 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1996 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 1998 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2000 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2002 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2004 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2006 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2008 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBRefreshScreen */

/* 2010 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2012 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2016 */	NdrFcShort( 0x33 ),	/* 51 */
/* 2018 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2020 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2022 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2024 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2026 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2028 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2030 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2032 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRet */

/* 2034 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2036 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2038 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2040 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2042 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2044 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCreateCanvas */

/* 2046 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2048 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2052 */	NdrFcShort( 0x34 ),	/* 52 */
/* 2054 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2056 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2058 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2060 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 2062 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2064 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2066 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2068 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter width */

/* 2070 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2072 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2074 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2076 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2078 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2080 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2082 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2084 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2086 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2088 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2090 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2092 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDestroyCanvas */

/* 2094 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2096 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2100 */	NdrFcShort( 0x35 ),	/* 53 */
/* 2102 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2104 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2106 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2108 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 2110 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2112 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2114 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2116 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2118 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2120 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2122 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2124 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2126 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2128 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2130 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2132 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2134 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvas */

/* 2136 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2138 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2142 */	NdrFcShort( 0x36 ),	/* 54 */
/* 2144 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2146 */	NdrFcShort( 0x18 ),	/* 24 */
/* 2148 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2150 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 2152 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2154 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2156 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2158 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2160 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2162 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2164 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2166 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2168 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2170 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 2172 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2174 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2176 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2178 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2180 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2182 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2184 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2186 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2188 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasPartial */

/* 2190 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2192 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2196 */	NdrFcShort( 0x37 ),	/* 55 */
/* 2198 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 2200 */	NdrFcShort( 0x38 ),	/* 56 */
/* 2202 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2204 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x9,		/* 9 */
/* 2206 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2208 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2210 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2212 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2214 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2216 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2218 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2220 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2222 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2224 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2226 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2228 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2230 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2232 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2234 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2236 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2238 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2240 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2242 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2244 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2246 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2248 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2250 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2252 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2254 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2256 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2258 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2260 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2262 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2264 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 2266 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTransparent */

/* 2268 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2270 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2274 */	NdrFcShort( 0x38 ),	/* 56 */
/* 2276 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2278 */	NdrFcShort( 0x20 ),	/* 32 */
/* 2280 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2282 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x6,		/* 6 */
/* 2284 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2286 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2288 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2290 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2292 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2294 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2296 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2298 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2300 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2302 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 2304 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2306 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2308 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2310 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2312 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2314 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2316 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2318 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2320 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2322 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2324 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2326 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTransparentPartial */

/* 2328 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2330 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2334 */	NdrFcShort( 0x39 ),	/* 57 */
/* 2336 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 2338 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2340 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2342 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0xa,		/* 10 */
/* 2344 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2346 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2348 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2350 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2352 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2354 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2356 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2358 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2360 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2362 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2364 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2366 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2368 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2370 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2372 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2374 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2376 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2378 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2380 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2382 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2384 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2386 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2388 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2390 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2392 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2394 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2396 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2398 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2400 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2402 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 2404 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2406 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2408 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 2410 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTranslucent */

/* 2412 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2414 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2418 */	NdrFcShort( 0x3a ),	/* 58 */
/* 2420 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 2422 */	NdrFcShort( 0x38 ),	/* 56 */
/* 2424 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2426 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x8,		/* 8 */
/* 2428 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2434 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2438 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2440 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2442 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2444 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 2448 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2450 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2452 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter dIntensity */

/* 2454 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2456 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2458 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crUnaffectedColor */

/* 2460 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2462 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2464 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2466 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2468 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2470 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2472 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2474 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2476 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2478 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2480 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 2482 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasLoadImage */

/* 2484 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2486 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2490 */	NdrFcShort( 0x3b ),	/* 59 */
/* 2492 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2494 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2496 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2498 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 2500 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 2502 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2504 */	NdrFcShort( 0x1a ),	/* 26 */
/* 2506 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2508 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2510 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2512 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter filename */

/* 2514 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 2516 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2518 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 2520 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2522 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2526 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2528 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2530 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasLoadSizedImage */

/* 2532 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2534 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2538 */	NdrFcShort( 0x3c ),	/* 60 */
/* 2540 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2542 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2544 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2546 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 2548 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 2550 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2552 */	NdrFcShort( 0x1a ),	/* 26 */
/* 2554 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2556 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2558 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter filename */

/* 2562 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 2564 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2566 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 2568 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2570 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2572 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2574 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2576 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2578 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasFill */

/* 2580 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2582 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2586 */	NdrFcShort( 0x3d ),	/* 61 */
/* 2588 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2590 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2592 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2594 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 2596 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2598 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2600 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2602 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2604 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2606 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2608 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 2610 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2612 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2614 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2616 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2618 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2620 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2622 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2624 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasResize */

/* 2628 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2630 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2634 */	NdrFcShort( 0x3e ),	/* 62 */
/* 2636 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2638 */	NdrFcShort( 0x18 ),	/* 24 */
/* 2640 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2642 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 2644 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2650 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 2652 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2654 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2656 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2658 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2660 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2662 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2664 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2666 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2668 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2670 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2672 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2676 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2678 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2680 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBlt */

/* 2682 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2684 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2688 */	NdrFcShort( 0x3f ),	/* 63 */
/* 2690 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2692 */	NdrFcShort( 0x20 ),	/* 32 */
/* 2694 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2696 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x6,		/* 6 */
/* 2698 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2700 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2702 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2704 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvSrc */

/* 2706 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2708 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2710 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2712 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2714 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2716 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2718 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2720 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2722 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2724 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2726 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2728 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2730 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2732 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2734 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2736 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2738 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2740 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltPartial */

/* 2742 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2744 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2748 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2750 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 2752 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2754 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2756 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0xa,		/* 10 */
/* 2758 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2760 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2764 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvSrc */

/* 2766 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2768 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2770 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2772 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2774 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2776 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2778 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2780 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2782 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2784 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2786 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2790 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2792 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2794 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2796 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2798 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2800 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2802 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2804 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2806 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2808 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2810 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2812 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2814 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2816 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 2818 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2820 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2822 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 2824 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTransparent */

/* 2826 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2828 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2832 */	NdrFcShort( 0x41 ),	/* 65 */
/* 2834 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2836 */	NdrFcShort( 0x28 ),	/* 40 */
/* 2838 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2840 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x7,		/* 7 */
/* 2842 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2844 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2846 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2848 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvSrc */

/* 2850 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2852 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2854 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2856 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2858 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2860 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2862 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2864 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2866 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2868 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2870 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2872 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2874 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2876 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2878 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2880 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2882 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2884 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2886 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2888 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2890 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTransparentPartial */

/* 2892 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2894 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2898 */	NdrFcShort( 0x42 ),	/* 66 */
/* 2900 */	NdrFcShort( 0x30 ),	/* x86 Stack size/offset = 48 */
/* 2902 */	NdrFcShort( 0x48 ),	/* 72 */
/* 2904 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2906 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0xb,		/* 11 */
/* 2908 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 2910 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2912 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2914 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvSrc */

/* 2916 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2918 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 2920 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2922 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2924 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 2926 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2928 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2930 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 2932 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2934 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2936 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 2938 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2940 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2942 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 2944 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2946 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2948 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 2950 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2952 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2954 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 2956 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2958 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2960 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 2962 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2964 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 2966 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 2968 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2970 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2972 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 2974 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2976 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2978 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 2980 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTranslucent */

/* 2982 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2984 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2988 */	NdrFcShort( 0x43 ),	/* 67 */
/* 2990 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 2992 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2994 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2996 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x9,		/* 9 */
/* 2998 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3000 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3004 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvSrc */

/* 3006 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3008 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3010 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 3012 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3014 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3016 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter destX */

/* 3018 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3020 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3022 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter destY */

/* 3024 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3026 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3028 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter dIntensity */

/* 3030 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3032 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3034 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crUnaffectedColor */

/* 3036 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3038 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3040 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 3042 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3044 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3046 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3048 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3050 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 3052 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3054 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3056 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 3058 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasGetScreen */

/* 3060 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3062 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3066 */	NdrFcShort( 0x44 ),	/* 68 */
/* 3068 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3070 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3072 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3074 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 3076 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3080 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3082 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnvDest */

/* 3084 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3086 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3088 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3090 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3092 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3094 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3096 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3098 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3100 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadString */

/* 3102 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3104 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3108 */	NdrFcShort( 0x45 ),	/* 69 */
/* 3110 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3112 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3114 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3116 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 3118 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 3120 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3122 */	NdrFcShort( 0x1a ),	/* 26 */
/* 3124 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter id */

/* 3126 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3128 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter defaultString */

/* 3132 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3134 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3136 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 3138 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 3140 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3142 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 3144 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3146 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3148 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawText */

/* 3150 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3152 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3156 */	NdrFcShort( 0x46 ),	/* 70 */
/* 3158 */	NdrFcShort( 0x44 ),	/* x86 Stack size/offset = 68 */
/* 3160 */	NdrFcShort( 0x60 ),	/* 96 */
/* 3162 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3164 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0xe,		/* 14 */
/* 3166 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 3168 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3170 */	NdrFcShort( 0x1d ),	/* 29 */
/* 3172 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3174 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3176 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3178 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter text */

/* 3180 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3182 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3184 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter font */

/* 3186 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3188 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3190 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter size */

/* 3192 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3194 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3196 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 3198 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3200 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3202 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter y */

/* 3204 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3206 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3208 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 3210 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3212 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 3214 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isBold */

/* 3216 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3218 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 3220 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isItalics */

/* 3222 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3224 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 3226 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isUnderline */

/* 3228 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3230 */	NdrFcShort( 0x30 ),	/* x86 Stack size/offset = 48 */
/* 3232 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isCentred */

/* 3234 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3236 */	NdrFcShort( 0x34 ),	/* x86 Stack size/offset = 52 */
/* 3238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isOutlined */

/* 3240 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3242 */	NdrFcShort( 0x38 ),	/* x86 Stack size/offset = 56 */
/* 3244 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3246 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3248 */	NdrFcShort( 0x3c ),	/* x86 Stack size/offset = 60 */
/* 3250 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3252 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3254 */	NdrFcShort( 0x40 ),	/* x86 Stack size/offset = 64 */
/* 3256 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasPopup */

/* 3258 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3260 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3264 */	NdrFcShort( 0x47 ),	/* 71 */
/* 3266 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3268 */	NdrFcShort( 0x28 ),	/* 40 */
/* 3270 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3272 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x7,		/* 7 */
/* 3274 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3276 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3278 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3280 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3282 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3284 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3286 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 3288 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3290 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3292 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 3294 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3296 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3298 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter stepSize */

/* 3300 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3302 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3304 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter popupType */

/* 3306 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3308 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3310 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3312 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3314 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3316 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3318 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3320 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3322 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasWidth */

/* 3324 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3326 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3330 */	NdrFcShort( 0x48 ),	/* 72 */
/* 3332 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3334 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3336 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3338 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 3340 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3342 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3344 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3346 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3348 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3350 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3352 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3354 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3356 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3358 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3360 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3362 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3364 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasHeight */

/* 3366 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3368 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3372 */	NdrFcShort( 0x49 ),	/* 73 */
/* 3374 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3376 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3378 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3380 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 3382 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3384 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3386 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3388 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3390 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3392 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3394 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3396 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3398 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3400 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3402 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3404 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3406 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawLine */

/* 3408 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3410 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3414 */	NdrFcShort( 0x4a ),	/* 74 */
/* 3416 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 3418 */	NdrFcShort( 0x30 ),	/* 48 */
/* 3420 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3422 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x8,		/* 8 */
/* 3424 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3426 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3428 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3430 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3432 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3434 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3436 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 3438 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3440 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3442 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 3444 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3446 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3448 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 3450 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3452 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3454 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 3456 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3458 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 3462 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3464 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3466 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3468 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3470 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3474 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3476 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3478 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawRect */

/* 3480 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3482 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3486 */	NdrFcShort( 0x4b ),	/* 75 */
/* 3488 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 3490 */	NdrFcShort( 0x30 ),	/* 48 */
/* 3492 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3494 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x8,		/* 8 */
/* 3496 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3498 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3500 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3502 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3504 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3506 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3508 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 3510 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3512 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3514 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 3516 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3518 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3520 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 3522 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3524 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3526 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 3528 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3530 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3532 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 3534 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3536 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3538 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3540 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3542 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3544 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3546 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3548 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3550 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasFillRect */

/* 3552 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3554 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3558 */	NdrFcShort( 0x4c ),	/* 76 */
/* 3560 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 3562 */	NdrFcShort( 0x30 ),	/* 48 */
/* 3564 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3566 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x8,		/* 8 */
/* 3568 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3570 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3574 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3576 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3578 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3580 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 3582 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3584 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 3588 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3590 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 3594 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3596 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 3600 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3602 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3604 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 3606 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3608 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3610 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3612 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3614 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3616 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3618 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3620 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3622 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawHand */

/* 3624 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3626 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3630 */	NdrFcShort( 0x4d ),	/* 77 */
/* 3632 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3634 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3636 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3638 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 3640 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3642 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3644 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3646 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 3648 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3650 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3652 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointx */

/* 3654 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3656 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3658 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointy */

/* 3660 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3662 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3664 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3666 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3668 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3670 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3672 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3674 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3676 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawHand */

/* 3678 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3680 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3684 */	NdrFcShort( 0x4e ),	/* 78 */
/* 3686 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3688 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3690 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3692 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 3694 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 3696 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3700 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pointx */

/* 3702 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3704 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointy */

/* 3708 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3710 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3714 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3716 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3718 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3720 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3722 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3724 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCheckKey */

/* 3726 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3728 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3732 */	NdrFcShort( 0x4f ),	/* 79 */
/* 3734 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3738 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3740 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 3742 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 3744 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3746 */	NdrFcShort( 0x1c ),	/* 28 */
/* 3748 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter keyPressed */

/* 3750 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3752 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3754 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 3756 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3758 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3760 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3762 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3764 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3766 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBPlaySound */

/* 3768 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3770 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3774 */	NdrFcShort( 0x50 ),	/* 80 */
/* 3776 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3778 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3780 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3782 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 3784 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 3786 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3788 */	NdrFcShort( 0x1c ),	/* 28 */
/* 3790 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter soundFile */

/* 3792 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3794 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3796 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 3798 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3800 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3802 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3804 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3806 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3808 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBMessageWindow */

/* 3810 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3812 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3816 */	NdrFcShort( 0x51 ),	/* 81 */
/* 3818 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 3820 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3822 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3824 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x7,		/* 7 */
/* 3826 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 3828 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3830 */	NdrFcShort( 0x38 ),	/* 56 */
/* 3832 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter text */

/* 3834 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3836 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3838 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter textColor */

/* 3840 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3842 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3844 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bgColor */

/* 3846 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3848 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3850 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bgPic */

/* 3852 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3854 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3856 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter mbtype */

/* 3858 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3860 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3862 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3864 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3866 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 3868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3870 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3872 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 3874 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFileDialog */

/* 3876 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3878 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3882 */	NdrFcShort( 0x52 ),	/* 82 */
/* 3884 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 3886 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3888 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3890 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 3892 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 3894 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3896 */	NdrFcShort( 0x38 ),	/* 56 */
/* 3898 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter initialPath */

/* 3900 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3902 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3904 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter fileFilter */

/* 3906 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3908 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3910 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 3912 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 3914 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3916 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 3918 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3920 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3922 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDetermineSpecialMoves */

/* 3924 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3926 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3930 */	NdrFcShort( 0x53 ),	/* 83 */
/* 3932 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3934 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3936 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3938 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 3940 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 3942 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3944 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3946 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerHandle */

/* 3948 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 3950 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3952 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 3954 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3956 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 3958 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3960 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3962 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 3964 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveListEntry */

/* 3966 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3968 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3972 */	NdrFcShort( 0x54 ),	/* 84 */
/* 3974 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 3976 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3978 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3980 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x3,		/* 3 */
/* 3982 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 3984 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3986 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3988 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 3990 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3992 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 3994 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3996 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 3998 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4000 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 4002 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4004 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4006 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBRunProgram */

/* 4008 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4010 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4014 */	NdrFcShort( 0x55 ),	/* 85 */
/* 4016 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4018 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4020 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4022 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x2,		/* 2 */
/* 4024 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 4026 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4028 */	NdrFcShort( 0x1 ),	/* 1 */
/* 4030 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter prgFile */

/* 4032 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 4034 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4036 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 4038 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4040 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4042 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetTarget */

/* 4044 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4046 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4050 */	NdrFcShort( 0x56 ),	/* 86 */
/* 4052 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4054 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4056 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4058 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4060 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4062 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4064 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4066 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter targetIdx */

/* 4068 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4070 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4072 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ttype */

/* 4074 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4076 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4078 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4080 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4082 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4084 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetSource */

/* 4086 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4088 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4092 */	NdrFcShort( 0x57 ),	/* 87 */
/* 4094 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4096 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4098 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4100 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4102 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4104 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4106 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4108 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter sourceIdx */

/* 4110 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4112 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4114 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sType */

/* 4116 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4118 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4120 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4122 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4124 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4126 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerHP */

/* 4128 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4130 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4134 */	NdrFcShort( 0x58 ),	/* 88 */
/* 4136 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4138 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4140 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4142 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4144 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4146 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4148 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4150 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4152 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4154 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4156 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4158 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4160 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4162 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4164 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4166 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4168 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerMaxHP */

/* 4170 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4172 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4176 */	NdrFcShort( 0x59 ),	/* 89 */
/* 4178 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4180 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4182 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4184 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4186 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4190 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4192 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4194 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4196 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4198 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4200 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4202 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4204 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4206 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4208 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4210 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerSMP */

/* 4212 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4214 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4218 */	NdrFcShort( 0x5a ),	/* 90 */
/* 4220 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4222 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4224 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4226 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4228 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4230 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4232 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4234 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4236 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4238 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4240 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4242 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4244 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4246 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4248 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4250 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4252 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerMaxSMP */

/* 4254 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4256 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4260 */	NdrFcShort( 0x5b ),	/* 91 */
/* 4262 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4264 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4266 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4268 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4270 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4272 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4274 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4276 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4278 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4280 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4282 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4284 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4286 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4288 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4290 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4292 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerFP */

/* 4296 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4298 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4302 */	NdrFcShort( 0x5c ),	/* 92 */
/* 4304 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4306 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4308 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4310 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4312 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4314 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4316 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4318 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4320 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4322 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4324 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4326 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4328 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4330 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4332 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4334 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4336 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerDP */

/* 4338 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4340 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4344 */	NdrFcShort( 0x5d ),	/* 93 */
/* 4346 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4348 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4350 */	NdrFcShort( 0x2c ),	/* 44 */
/* 4352 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4354 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4356 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4358 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4360 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4362 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4364 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4366 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4368 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4370 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4372 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 4374 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4376 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4378 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerName */

/* 4380 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4382 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4386 */	NdrFcShort( 0x5e ),	/* 94 */
/* 4388 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4390 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4392 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4394 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x3,		/* 3 */
/* 4396 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 4398 */	NdrFcShort( 0x1 ),	/* 1 */
/* 4400 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4402 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter playerIdx */

/* 4404 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4406 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4410 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 4412 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4414 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 4416 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4418 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4420 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddPlayerHP */

/* 4422 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4424 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4428 */	NdrFcShort( 0x5f ),	/* 95 */
/* 4430 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4432 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4434 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4436 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4438 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4440 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4442 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4444 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4446 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4448 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4450 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4452 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4454 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4456 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4458 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4460 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4462 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddPlayerSMP */

/* 4464 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4466 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4470 */	NdrFcShort( 0x60 ),	/* 96 */
/* 4472 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4474 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4476 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4478 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4480 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4484 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4486 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4488 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4490 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4492 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4494 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4496 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4498 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4500 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4502 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4504 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerHP */

/* 4506 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4508 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4512 */	NdrFcShort( 0x61 ),	/* 97 */
/* 4514 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4516 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4518 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4520 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4522 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4524 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4526 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4528 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4530 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4532 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4534 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4536 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4538 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4540 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4542 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4544 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerSMP */

/* 4548 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4550 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4554 */	NdrFcShort( 0x62 ),	/* 98 */
/* 4556 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4558 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4560 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4562 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4564 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4566 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4570 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4572 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4574 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4576 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4578 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4580 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4582 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4584 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4586 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4588 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerFP */

/* 4590 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4592 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4596 */	NdrFcShort( 0x63 ),	/* 99 */
/* 4598 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4600 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4602 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4604 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4606 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4610 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4612 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4614 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4616 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4618 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4620 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4622 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4624 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4626 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4628 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerDP */

/* 4632 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4634 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4638 */	NdrFcShort( 0x64 ),	/* 100 */
/* 4640 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4642 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4644 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4646 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4648 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4650 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4652 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4654 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4656 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4658 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 4662 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4664 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4668 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4670 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4672 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyHP */

/* 4674 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4676 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4680 */	NdrFcShort( 0x65 ),	/* 101 */
/* 4682 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4684 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4686 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4688 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4690 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4692 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4694 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4696 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4698 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4700 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4702 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4704 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4706 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4708 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4710 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4712 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4714 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyMaxHP */

/* 4716 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4718 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4722 */	NdrFcShort( 0x66 ),	/* 102 */
/* 4724 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4726 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4728 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4730 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4732 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4734 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4738 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4740 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4742 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4744 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4746 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4748 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4750 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4752 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4754 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4756 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemySMP */

/* 4758 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4760 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4764 */	NdrFcShort( 0x67 ),	/* 103 */
/* 4766 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4768 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4770 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4772 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4774 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4776 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4778 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4780 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4782 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4784 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4786 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4788 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4790 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4792 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4794 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4796 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4798 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyMaxSMP */

/* 4800 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4802 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4806 */	NdrFcShort( 0x68 ),	/* 104 */
/* 4808 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4810 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4812 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4814 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4816 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4818 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4820 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4822 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4824 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4826 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4828 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4830 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4832 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4834 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4836 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4838 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4840 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyFP */

/* 4842 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4844 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4848 */	NdrFcShort( 0x69 ),	/* 105 */
/* 4850 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4852 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4854 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4856 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4858 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4860 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4864 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4866 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4868 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4870 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4872 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4874 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4876 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4878 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4880 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4882 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyDP */

/* 4884 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4886 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4890 */	NdrFcShort( 0x6a ),	/* 106 */
/* 4892 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4894 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4896 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4898 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4900 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4902 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4904 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4906 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter eneIdx */

/* 4908 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4910 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4912 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4914 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4916 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4918 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4920 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4922 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4924 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddEnemyHP */

/* 4926 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4928 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4932 */	NdrFcShort( 0x6b ),	/* 107 */
/* 4934 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4936 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4938 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4940 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4942 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4944 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4946 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4948 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4950 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4952 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4954 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4956 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4958 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 4960 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4962 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4964 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 4966 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddEnemySMP */

/* 4968 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4970 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4974 */	NdrFcShort( 0x6c ),	/* 108 */
/* 4976 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 4978 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4980 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4982 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 4984 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 4986 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4988 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4990 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 4992 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4994 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 4996 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4998 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5000 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5002 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5004 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5006 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5008 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyHP */

/* 5010 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5012 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5016 */	NdrFcShort( 0x6d ),	/* 109 */
/* 5018 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5020 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5022 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5024 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5026 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5028 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5030 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5032 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 5034 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5036 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5038 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 5040 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5042 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5044 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5046 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5048 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5050 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemySMP */

/* 5052 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5054 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5058 */	NdrFcShort( 0x6e ),	/* 110 */
/* 5060 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5062 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5064 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5066 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5068 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5070 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5072 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5074 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter amount */

/* 5076 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5078 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5080 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 5082 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5084 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5086 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5088 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5090 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5092 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawBackground */

/* 5094 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5096 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5100 */	NdrFcShort( 0x6f ),	/* 111 */
/* 5102 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 5104 */	NdrFcShort( 0x28 ),	/* 40 */
/* 5106 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5108 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x7,		/* 7 */
/* 5110 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 5112 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5114 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5116 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 5118 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5120 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5122 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bkgFile */

/* 5124 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5126 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5128 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter x */

/* 5130 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5132 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5134 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 5136 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5138 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 5142 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5144 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 5148 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5150 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 5152 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5154 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5156 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 5158 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCreateAnimation */

/* 5160 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5162 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5166 */	NdrFcShort( 0x70 ),	/* 112 */
/* 5168 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5170 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5172 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5174 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 5176 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 5178 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5180 */	NdrFcShort( 0x22 ),	/* 34 */
/* 5182 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter file */

/* 5184 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5186 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5188 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 5190 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5192 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5194 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5196 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5198 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5200 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDestroyAnimation */

/* 5202 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5204 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5208 */	NdrFcShort( 0x71 ),	/* 113 */
/* 5210 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5212 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5214 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5216 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5218 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5220 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5222 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5224 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5226 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5228 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5230 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5232 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5234 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5236 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawAnimation */

/* 5238 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5240 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5244 */	NdrFcShort( 0x72 ),	/* 114 */
/* 5246 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 5248 */	NdrFcShort( 0x30 ),	/* 48 */
/* 5250 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5252 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x7,		/* 7 */
/* 5254 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5256 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5260 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 5262 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5264 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5266 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter idx */

/* 5268 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5270 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5272 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 5274 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5276 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5278 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 5280 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5282 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5284 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceDraw */

/* 5286 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5288 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5290 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceTransp */

/* 5292 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5294 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 5296 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5298 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5300 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 5302 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawAnimationFrame */

/* 5304 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5306 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5310 */	NdrFcShort( 0x73 ),	/* 115 */
/* 5312 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 5314 */	NdrFcShort( 0x30 ),	/* 48 */
/* 5316 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5318 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x7,		/* 7 */
/* 5320 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5322 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5324 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5326 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter canvasID */

/* 5328 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5330 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5332 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter idx */

/* 5334 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5336 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5338 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter frame */

/* 5340 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5342 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5344 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 5346 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5348 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5350 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 5352 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5354 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5356 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceTranspFill */

/* 5358 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5360 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 5362 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5364 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5366 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 5368 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationCurrentFrame */

/* 5370 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5372 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5376 */	NdrFcShort( 0x74 ),	/* 116 */
/* 5378 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5380 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5382 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5384 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5386 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5388 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5390 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5392 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5394 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5396 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5398 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5400 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5402 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5404 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5406 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5408 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5410 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationMaxFrames */

/* 5412 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5414 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5418 */	NdrFcShort( 0x75 ),	/* 117 */
/* 5420 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5422 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5424 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5426 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5428 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5434 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5438 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5440 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5442 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5444 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5448 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5450 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5452 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationSizeX */

/* 5454 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5456 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5460 */	NdrFcShort( 0x76 ),	/* 118 */
/* 5462 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5464 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5466 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5468 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5470 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5472 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5474 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5476 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5478 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5480 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5482 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5484 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5486 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5488 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5490 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5492 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationSizeY */

/* 5496 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5498 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5502 */	NdrFcShort( 0x77 ),	/* 119 */
/* 5504 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5506 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5508 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5510 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5512 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5514 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5516 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5518 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5520 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5522 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5526 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5528 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5530 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5532 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5534 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5536 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationFrameImage */

/* 5538 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5540 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5544 */	NdrFcShort( 0x78 ),	/* 120 */
/* 5546 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5548 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5550 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5552 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x4,		/* 4 */
/* 5554 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 5556 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5558 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5560 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter idx */

/* 5562 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5564 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5566 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter frame */

/* 5568 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5570 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5572 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5574 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 5576 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5578 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 5580 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5582 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5584 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPartySize */

/* 5586 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5588 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5592 */	NdrFcShort( 0x79 ),	/* 121 */
/* 5594 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5596 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5598 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5600 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5602 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5604 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5606 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5608 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5610 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5612 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5614 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5616 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5618 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5620 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5622 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5624 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterHP */

/* 5628 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5630 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5634 */	NdrFcShort( 0x7a ),	/* 122 */
/* 5636 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5638 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5640 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5642 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5644 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5650 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5652 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5654 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5656 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5658 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5660 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5662 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5664 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5666 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5668 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5670 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5672 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterMaxHP */

/* 5676 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5678 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5682 */	NdrFcShort( 0x7b ),	/* 123 */
/* 5684 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5686 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5688 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5690 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5692 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5694 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5696 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5698 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5700 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5702 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5704 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5706 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5708 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5710 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5712 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5714 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5716 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5718 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5720 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5722 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterSMP */

/* 5724 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5726 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5730 */	NdrFcShort( 0x7c ),	/* 124 */
/* 5732 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5734 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5736 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5738 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5740 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5742 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5744 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5746 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5748 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5750 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5752 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5754 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5756 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5758 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5760 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5762 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5764 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5766 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5768 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5770 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterMaxSMP */

/* 5772 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5774 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5778 */	NdrFcShort( 0x7d ),	/* 125 */
/* 5780 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5782 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5784 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5786 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5788 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5790 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5792 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5794 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5796 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5798 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5800 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5802 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5804 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5806 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5808 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5810 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5812 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5814 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5816 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5818 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterFP */

/* 5820 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5822 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5826 */	NdrFcShort( 0x7e ),	/* 126 */
/* 5828 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5830 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5832 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5834 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5836 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5838 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5840 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5842 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5844 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5846 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5848 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5850 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5852 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5854 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5856 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5858 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5860 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5862 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5864 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5866 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterDP */

/* 5868 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5870 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5874 */	NdrFcShort( 0x7f ),	/* 127 */
/* 5876 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5878 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5880 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5882 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5884 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 5886 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5888 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5890 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5892 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5894 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5896 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5898 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5900 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5904 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5906 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5908 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5910 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5912 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5914 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterName */

/* 5916 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5918 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5922 */	NdrFcShort( 0x80 ),	/* 128 */
/* 5924 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 5926 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5928 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5930 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x4,		/* 4 */
/* 5932 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 5934 */	NdrFcShort( 0x23 ),	/* 35 */
/* 5936 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5938 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5940 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5942 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5944 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5946 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5948 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5950 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5952 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 5954 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 5956 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 5958 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5960 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 5962 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterAnimation */

/* 5964 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5966 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5970 */	NdrFcShort( 0x81 ),	/* 129 */
/* 5972 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 5974 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5976 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5978 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 5980 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 5982 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5984 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5986 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 5988 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5990 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 5992 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5994 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5996 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 5998 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter animationName */

/* 6000 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6002 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6004 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 6006 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 6008 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6010 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 6012 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6014 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6016 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterChargePercent */

/* 6018 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6020 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6024 */	NdrFcShort( 0x82 ),	/* 130 */
/* 6026 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6028 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6030 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6032 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 6034 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6036 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6038 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6040 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 6042 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6044 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6046 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 6048 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6050 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6052 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 6054 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6056 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6058 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6060 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6062 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6064 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightTick */

/* 6066 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6068 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6072 */	NdrFcShort( 0x83 ),	/* 131 */
/* 6074 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6076 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6078 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6080 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x1,		/* 1 */
/* 6082 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6084 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6086 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6088 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Return value */

/* 6090 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6092 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6094 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawTextAbsolute */

/* 6096 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6098 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6102 */	NdrFcShort( 0x84 ),	/* 132 */
/* 6104 */	NdrFcShort( 0x38 ),	/* x86 Stack size/offset = 56 */
/* 6106 */	NdrFcShort( 0x48 ),	/* 72 */
/* 6108 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6110 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0xd,		/* 13 */
/* 6112 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6114 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6116 */	NdrFcShort( 0x27 ),	/* 39 */
/* 6118 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter text */

/* 6120 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6122 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6124 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter font */

/* 6126 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6128 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6130 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter size */

/* 6132 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6134 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 6138 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6140 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 6144 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6146 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6148 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 6150 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6152 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 6154 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isBold */

/* 6156 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6158 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 6160 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isItalics */

/* 6162 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6164 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 6166 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isUnderline */

/* 6168 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6170 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 6172 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isCentred */

/* 6174 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6176 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
/* 6178 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isOutlined */

/* 6180 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6182 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
/* 6184 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 6186 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6188 */	NdrFcShort( 0x30 ),	/* x86 Stack size/offset = 48 */
/* 6190 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6192 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6194 */	NdrFcShort( 0x34 ),	/* x86 Stack size/offset = 52 */
/* 6196 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBReleaseFighterCharge */

/* 6198 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6200 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6204 */	NdrFcShort( 0x85 ),	/* 133 */
/* 6206 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6208 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6210 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6212 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 6214 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6216 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6218 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6220 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 6222 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6224 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6226 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 6228 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6230 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6232 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6234 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6236 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightDoAttack */

/* 6240 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6242 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6246 */	NdrFcShort( 0x86 ),	/* 134 */
/* 6248 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
/* 6250 */	NdrFcShort( 0x30 ),	/* 48 */
/* 6252 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6254 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x8,		/* 8 */
/* 6256 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6260 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6262 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter sourcePartyIdx */

/* 6264 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6266 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 6270 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6272 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 6276 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6278 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6280 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 6282 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6284 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6286 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter amount */

/* 6288 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6290 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6292 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter toSMP */

/* 6294 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6296 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 6298 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 6300 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6302 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 6304 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6306 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6308 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
/* 6310 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightUseItem */

/* 6312 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6314 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6318 */	NdrFcShort( 0x87 ),	/* 135 */
/* 6320 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 6322 */	NdrFcShort( 0x20 ),	/* 32 */
/* 6324 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6326 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x6,		/* 6 */
/* 6328 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6332 */	NdrFcShort( 0x26 ),	/* 38 */
/* 6334 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter sourcePartyIdx */

/* 6336 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6338 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6340 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 6342 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6344 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6346 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 6348 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6350 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6352 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 6354 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6356 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6358 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itemFile */

/* 6360 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6362 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6364 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 6366 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6368 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 6370 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightUseSpecialMove */

/* 6372 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6374 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6378 */	NdrFcShort( 0x88 ),	/* 136 */
/* 6380 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 6382 */	NdrFcShort( 0x20 ),	/* 32 */
/* 6384 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6386 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x6,		/* 6 */
/* 6388 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6390 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6392 */	NdrFcShort( 0x26 ),	/* 38 */
/* 6394 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter sourcePartyIdx */

/* 6396 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6398 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6400 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 6402 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6404 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6406 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 6408 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6410 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6412 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 6414 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6416 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6418 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter moveFile */

/* 6420 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6422 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6424 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 6426 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6428 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 6430 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDoEvents */

/* 6432 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6434 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6438 */	NdrFcShort( 0x89 ),	/* 137 */
/* 6440 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6442 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6444 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6446 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x1,		/* 1 */
/* 6448 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6450 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6452 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6454 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Return value */

/* 6456 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6458 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFighterAddStatusEffect */

/* 6462 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6464 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6468 */	NdrFcShort( 0x8a ),	/* 138 */
/* 6470 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6472 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6474 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6476 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 6478 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6480 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6482 */	NdrFcShort( 0x26 ),	/* 38 */
/* 6484 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 6486 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6488 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6490 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fightIdx */

/* 6492 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6494 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6496 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter statusFile */

/* 6498 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6500 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6502 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 6504 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6506 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6508 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFighterRemoveStatusEffect */

/* 6510 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6512 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6516 */	NdrFcShort( 0x8b ),	/* 139 */
/* 6518 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 6520 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6522 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6524 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 6526 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6528 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6530 */	NdrFcShort( 0x26 ),	/* 38 */
/* 6532 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter partyIdx */

/* 6534 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6536 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6538 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fightIdx */

/* 6540 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6542 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6544 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter statusFile */

/* 6546 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6548 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6550 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Return value */

/* 6552 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6554 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6556 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCheckMusic */

/* 6558 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6560 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6564 */	NdrFcShort( 0x8c ),	/* 140 */
/* 6566 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6570 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6572 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x1,		/* 1 */
/* 6574 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6576 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6578 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6580 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Return value */

/* 6582 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6584 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBReleaseScreenDC */

/* 6588 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6590 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6594 */	NdrFcShort( 0x8d ),	/* 141 */
/* 6596 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6598 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6600 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6602 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x1,		/* 1 */
/* 6604 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6606 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6610 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Return value */

/* 6612 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6614 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6616 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasOpenHdc */

/* 6618 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6620 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6624 */	NdrFcShort( 0x8e ),	/* 142 */
/* 6626 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6628 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6630 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6632 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 6634 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6636 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6638 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6640 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnv */

/* 6642 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6644 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6646 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 6648 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6650 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6652 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6654 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6656 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6658 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasCloseHdc */

/* 6660 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6662 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6666 */	NdrFcShort( 0x8f ),	/* 143 */
/* 6668 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6670 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6672 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6674 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 6676 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6678 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6680 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6682 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnv */

/* 6684 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6686 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6688 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter hdc */

/* 6690 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6692 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6694 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6696 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6698 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6700 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFileExists */

/* 6702 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6704 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6708 */	NdrFcShort( 0x90 ),	/* 144 */
/* 6710 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 6712 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6714 */	NdrFcShort( 0x22 ),	/* 34 */
/* 6716 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 6718 */	0x8,		/* 8 */
			0x5,		/* Ext Flags:  new corr desc, srv corr check, */
/* 6720 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6722 */	NdrFcShort( 0x26 ),	/* 38 */
/* 6724 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter strFile */

/* 6726 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6728 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6730 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter pRet */

/* 6732 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6734 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6736 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 6738 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6740 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6742 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasLock */

/* 6744 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6746 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6750 */	NdrFcShort( 0x91 ),	/* 145 */
/* 6752 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6754 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6756 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6758 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6760 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6764 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6766 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnv */

/* 6768 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6770 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6772 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6774 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6776 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6778 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasUnlock */

/* 6780 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6782 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6786 */	NdrFcShort( 0x92 ),	/* 146 */
/* 6788 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 6790 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6792 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6794 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6796 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 6798 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6802 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter cnv */

/* 6804 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6806 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 6808 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6810 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6812 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 6814 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const trans3_MIDL_TYPE_FORMAT_STRING trans3__MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */
/*  2 */	
			0x12, 0x0,	/* FC_UP */
/*  4 */	NdrFcShort( 0xe ),	/* Offset= 14 (18) */
/*  6 */	
			0x1b,		/* FC_CARRAY */
			0x1,		/* 1 */
/*  8 */	NdrFcShort( 0x2 ),	/* 2 */
/* 10 */	0x9,		/* Corr desc: FC_ULONG */
			0x0,		/*  */
/* 12 */	NdrFcShort( 0xfffc ),	/* -4 */
/* 14 */	NdrFcShort( 0x1 ),	/* Corr flags:  early, */
/* 16 */	0x6,		/* FC_SHORT */
			0x5b,		/* FC_END */
/* 18 */	
			0x17,		/* FC_CSTRUCT */
			0x3,		/* 3 */
/* 20 */	NdrFcShort( 0x8 ),	/* 8 */
/* 22 */	NdrFcShort( 0xfff0 ),	/* Offset= -16 (6) */
/* 24 */	0x8,		/* FC_LONG */
			0x8,		/* FC_LONG */
/* 26 */	0x5c,		/* FC_PAD */
			0x5b,		/* FC_END */
/* 28 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 30 */	NdrFcShort( 0x0 ),	/* 0 */
/* 32 */	NdrFcShort( 0x4 ),	/* 4 */
/* 34 */	NdrFcShort( 0x0 ),	/* 0 */
/* 36 */	NdrFcShort( 0xffde ),	/* Offset= -34 (2) */
/* 38 */	
			0x11, 0x4,	/* FC_RP [alloced_on_stack] */
/* 40 */	NdrFcShort( 0x6 ),	/* Offset= 6 (46) */
/* 42 */	
			0x13, 0x0,	/* FC_OP */
/* 44 */	NdrFcShort( 0xffe6 ),	/* Offset= -26 (18) */
/* 46 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 48 */	NdrFcShort( 0x0 ),	/* 0 */
/* 50 */	NdrFcShort( 0x4 ),	/* 4 */
/* 52 */	NdrFcShort( 0x0 ),	/* 0 */
/* 54 */	NdrFcShort( 0xfff4 ),	/* Offset= -12 (42) */
/* 56 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 58 */	0xc,		/* FC_DOUBLE */
			0x5c,		/* FC_PAD */
/* 60 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 62 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */
/* 64 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 66 */	0x6,		/* FC_SHORT */
			0x5c,		/* FC_PAD */

			0x0
        }
    };

static const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ] = 
        {
            
            {
            BSTR_UserSize
            ,BSTR_UserMarshal
            ,BSTR_UserUnmarshal
            ,BSTR_UserFree
            }

        };



/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IDispatch, ver. 0.0,
   GUID={0x00020400,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: ICallbacks, ver. 0.0,
   GUID={0xC146901F,0xABFA,0x4D24,{0xA4,0xF2,0xD8,0x3C,0x96,0x1D,0x37,0xB9}} */

#pragma code_seg(".orpc")
static const unsigned short ICallbacks_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    36,
    78,
    120,
    162,
    204,
    240,
    276,
    312,
    348,
    384,
    420,
    462,
    510,
    558,
    606,
    654,
    708,
    762,
    816,
    870,
    924,
    978,
    1032,
    1086,
    1128,
    1170,
    1212,
    1260,
    1302,
    1344,
    1386,
    1422,
    1464,
    1500,
    1542,
    1584,
    1626,
    1680,
    1734,
    1794,
    1854,
    1914,
    1974,
    2010,
    2046,
    2094,
    2136,
    2190,
    2268,
    2328,
    2412,
    2484,
    2532,
    2580,
    2628,
    2682,
    2742,
    2826,
    2892,
    2982,
    3060,
    3102,
    3150,
    3258,
    3324,
    3366,
    3408,
    3480,
    3552,
    3624,
    3678,
    3726,
    3768,
    3810,
    3876,
    3924,
    3966,
    4008,
    4044,
    4086,
    4128,
    4170,
    4212,
    4254,
    4296,
    4338,
    4380,
    4422,
    4464,
    4506,
    4548,
    4590,
    4632,
    4674,
    4716,
    4758,
    4800,
    4842,
    4884,
    4926,
    4968,
    5010,
    5052,
    5094,
    5160,
    5202,
    5238,
    5304,
    5370,
    5412,
    5454,
    5496,
    5538,
    5586,
    5628,
    5676,
    5724,
    5772,
    5820,
    5868,
    5916,
    5964,
    6018,
    6066,
    6096,
    6198,
    6240,
    6312,
    6372,
    6432,
    6462,
    6510,
    6558,
    6588,
    6618,
    6660,
    6702,
    6744,
    6780
    };

static const MIDL_STUBLESS_PROXY_INFO ICallbacks_ProxyInfo =
    {
    &Object_StubDesc,
    trans3__MIDL_ProcFormatString.Format,
    &ICallbacks_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO ICallbacks_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    trans3__MIDL_ProcFormatString.Format,
    &ICallbacks_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(147) _ICallbacksProxyVtbl = 
{
    &ICallbacks_ProxyInfo,
    &IID_ICallbacks,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBRpgCode */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetNumerical */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetNumerical */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetScreenDC */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetScratch1DC */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetScratch2DC */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetMwinDC */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBPopupMwin */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBHideMwin */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBLoadEnemy */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetEnemyNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetEnemyString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetGeneralString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetGeneralNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetGeneralString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetGeneralNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetCommandName */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetBrackets */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCountBracketElements */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetBracketElement */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetStringElementValue */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetNumElementValue */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetElementType */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDebugMessage */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPathString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBLoadSpecialMove */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetSpecialMoveString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetSpecialMoveNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBLoadItem */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetItemString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetItemNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetBoardNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetBoardString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetBoardNum */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetBoardString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetHwnd */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBRefreshScreen */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCreateCanvas */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDestroyCanvas */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawCanvas */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawCanvasPartial */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawCanvasTransparent */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawCanvasTransparentPartial */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawCanvasTranslucent */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasLoadImage */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasLoadSizedImage */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasFill */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasResize */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvas2CanvasBlt */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvas2CanvasBltPartial */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvas2CanvasBltTransparent */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvas2CanvasBltTransparentPartial */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvas2CanvasBltTranslucent */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasGetScreen */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBLoadString */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawText */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasPopup */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasWidth */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasHeight */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawLine */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawRect */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasFillRect */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawHand */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDrawHand */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCheckKey */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBPlaySound */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBMessageWindow */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBFileDialog */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDetermineSpecialMoves */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetSpecialMoveListEntry */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBRunProgram */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetTarget */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetSource */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerMaxHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerMaxSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerFP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerDP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPlayerName */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAddPlayerHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAddPlayerSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerFP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetPlayerDP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyMaxHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemySMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyMaxSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyFP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetEnemyDP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAddEnemyHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAddEnemySMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetEnemyHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBSetEnemySMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawBackground */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCreateAnimation */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBDestroyAnimation */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawAnimation */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBCanvasDrawAnimationFrame */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAnimationCurrentFrame */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAnimationMaxFrames */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAnimationSizeX */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAnimationSizeY */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBAnimationFrameImage */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetPartySize */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterMaxHP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterMaxSMP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterFP */ ,
    (void *) (INT_PTR) -1 /* ICallbacks::CBGetFighterDP */ ,
    ICallbacks_CBGetFighterName_Proxy ,
    ICallbacks_CBGetFighterAnimation_Proxy ,
    ICallbacks_CBGetFighterChargePercent_Proxy ,
    ICallbacks_CBFightTick_Proxy ,
    ICallbacks_CBDrawTextAbsolute_Proxy ,
    ICallbacks_CBReleaseFighterCharge_Proxy ,
    ICallbacks_CBFightDoAttack_Proxy ,
    ICallbacks_CBFightUseItem_Proxy ,
    ICallbacks_CBFightUseSpecialMove_Proxy ,
    ICallbacks_CBDoEvents_Proxy ,
    ICallbacks_CBFighterAddStatusEffect_Proxy ,
    ICallbacks_CBFighterRemoveStatusEffect_Proxy ,
    ICallbacks_CBCheckMusic_Proxy ,
    ICallbacks_CBReleaseScreenDC_Proxy ,
    ICallbacks_CBCanvasOpenHdc_Proxy ,
    ICallbacks_CBCanvasCloseHdc_Proxy ,
    ICallbacks_CBFileExists_Proxy ,
    ICallbacks_CBCanvasLock_Proxy ,
    ICallbacks_CBCanvasUnlock_Proxy
};


static const PRPC_STUB_FUNCTION ICallbacks_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2,
    NdrStubCall2
};

CInterfaceStubVtbl _ICallbacksStubVtbl =
{
    &IID_ICallbacks,
    &ICallbacks_ServerInfo,
    147,
    &ICallbacks_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};

static const MIDL_STUB_DESC Object_StubDesc = 
    {
    0,
    NdrOleAllocate,
    NdrOleFree,
    0,
    0,
    0,
    0,
    0,
    trans3__MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x50002, /* Ndr library version */
    0,
    0x70001f4, /* MIDL Version 7.0.500 */
    0,
    UserMarshalRoutines,
    0,  /* notify & notify_flag routine table */
    0x1, /* MIDL flag */
    0, /* cs routines */
    0,   /* proxy/server info */
    0
    };

const CInterfaceProxyVtbl * _trans3_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_ICallbacksProxyVtbl,
    0
};

const CInterfaceStubVtbl * _trans3_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_ICallbacksStubVtbl,
    0
};

PCInterfaceName const _trans3_InterfaceNamesList[] = 
{
    "ICallbacks",
    0
};

const IID *  _trans3_BaseIIDList[] = 
{
    &IID_IDispatch,
    0
};


#define _trans3_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _trans3, pIID, n)

int __stdcall _trans3_IID_Lookup( const IID * pIID, int * pIndex )
{
    
    if(!_trans3_CHECK_IID(0))
        {
        *pIndex = 0;
        return 1;
        }

    return 0;
}

const ExtendedProxyFileInfo trans3_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _trans3_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _trans3_StubVtblList,
    (const PCInterfaceName * ) & _trans3_InterfaceNamesList,
    (const IID ** ) & _trans3_BaseIIDList,
    & _trans3_IID_Lookup, 
    1,
    2,
    0, /* table of [async_uuid] interfaces */
    0, /* Filler1 */
    0, /* Filler2 */
    0  /* Filler3 */
};
#pragma optimize("", on )
#if _MSC_VER >= 1200
#pragma warning(pop)
#endif


#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/

