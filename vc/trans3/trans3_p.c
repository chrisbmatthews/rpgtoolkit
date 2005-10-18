/* this ALWAYS GENERATED file contains the proxy stub code */


/* File created by MIDL compiler version 5.01.0164 */
/* at Tue Oct 18 17:13:38 2005
 */
/* Compiler settings for C:\Program Files\GNU\WinCvs 2.0\tk3\vc\trans3\trans3.idl:
    Oicf (OptLev=i2), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 440
#endif


#include "rpcproxy.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif // __RPCPROXY_H_VERSION__


#include "trans3.h"

#define TYPE_FORMAT_STRING_SIZE   67                                
#define PROC_FORMAT_STRING_SIZE   5629                              

typedef struct _MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } MIDL_TYPE_FORMAT_STRING;

typedef struct _MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } MIDL_PROC_FORMAT_STRING;


extern const MIDL_TYPE_FORMAT_STRING __MIDL_TypeFormatString;
extern const MIDL_PROC_FORMAT_STRING __MIDL_ProcFormatString;


/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IDispatch, ver. 0.0,
   GUID={0x00020400,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: ICallbacks, ver. 0.0,
   GUID={0xC146901F,0xABFA,0x4D24,{0xA4,0xF2,0xD8,0x3C,0x96,0x1D,0x37,0xB9}} */


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO ICallbacks_ServerInfo;

#pragma code_seg(".orpc")
HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBrackets_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[928],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[928],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[928],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCountBracketElements_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[962],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[962],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[962],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBracketElement_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    int elemNum,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[996],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[996],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&elemNum,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[996],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetStringElementValue_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1036],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1036],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1036],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetNumElementValue_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1070],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1070],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1070],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetElementType_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1104],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1104],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&rpgcodeCommand,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1104],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDebugMessage_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR message)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,message);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1138],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1138],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&message);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1138],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPathString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1166],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1166],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1166],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadSpecialMove_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,file);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1200],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1200],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&file);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1200],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1228],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1228],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1228],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1262],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1262],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1262],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadItem_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file,
    int itmSlot)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,itmSlot);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1296],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1296],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&file,
                  ( unsigned char __RPC_FAR * )&itmSlot);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1296],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetItemString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int itmSlot,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1330],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1330],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos,
                  ( unsigned char __RPC_FAR * )&itmSlot,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1330],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetItemNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int itmSlot,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1376],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1376],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos,
                  ( unsigned char __RPC_FAR * )&itmSlot,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1376],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBoardNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1422],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1422],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos1,
                  ( unsigned char __RPC_FAR * )&arrayPos2,
                  ( unsigned char __RPC_FAR * )&arrayPos3,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1422],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBoardString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1474],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1474],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos1,
                  ( unsigned char __RPC_FAR * )&arrayPos2,
                  ( unsigned char __RPC_FAR * )&arrayPos3,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1474],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetBoardNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    int nValue)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,nValue);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1526],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1526],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos1,
                  ( unsigned char __RPC_FAR * )&arrayPos2,
                  ( unsigned char __RPC_FAR * )&arrayPos3,
                  ( unsigned char __RPC_FAR * )&nValue);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1526],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetBoardString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [string] */ BSTR newVal)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,newVal);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1578],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1578],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&infoCode,
                  ( unsigned char __RPC_FAR * )&arrayPos1,
                  ( unsigned char __RPC_FAR * )&arrayPos2,
                  ( unsigned char __RPC_FAR * )&arrayPos3,
                  ( unsigned char __RPC_FAR * )&newVal);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1578],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetHwnd_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1630],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1630],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1630],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBRefreshScreen_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1658],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1658],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1658],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCreateCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1686],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1686],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1686],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDestroyCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1726],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1726],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1726],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1760],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1760],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1760],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasPartial_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int xDest,
    int yDest,
    int xsrc,
    int ysrc,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1806],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1806],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&xsrc,
                  ( unsigned char __RPC_FAR * )&ysrc,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1806],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasTransparent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1876],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1876],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1876],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasTransparentPartial_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int xDest,
    int yDest,
    int xsrc,
    int ysrc,
    int width,
    int height,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1928],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1928],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&xsrc,
                  ( unsigned char __RPC_FAR * )&ysrc,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[1928],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasTranslucent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    double dIntensity,
    int crUnaffectedColor,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2004],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2004],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&dIntensity,
                  ( unsigned char __RPC_FAR * )&crUnaffectedColor,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2004],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLoadImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR filename,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2068],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2068],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&filename,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2068],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLoadSizedImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR filename,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2108],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2108],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&filename,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2108],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasFill_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2148],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2148],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2148],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasResize_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2188],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2188],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2188],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBlt_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2234],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2234],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvSrc,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2234],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltPartial_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    int xsrc,
    int ysrc,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2286],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2286],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvSrc,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&xsrc,
                  ( unsigned char __RPC_FAR * )&ysrc,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2286],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltTransparent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2362],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2362],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvSrc,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2362],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltTransparentPartial_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    int xsrc,
    int ysrc,
    int width,
    int height,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2420],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2420],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvSrc,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&xDest,
                  ( unsigned char __RPC_FAR * )&yDest,
                  ( unsigned char __RPC_FAR * )&xsrc,
                  ( unsigned char __RPC_FAR * )&ysrc,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2420],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltTranslucent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int destX,
    int destY,
    double dIntensity,
    int crUnaffectedColor,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2502],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2502],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvSrc,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&destX,
                  ( unsigned char __RPC_FAR * )&destY,
                  ( unsigned char __RPC_FAR * )&dIntensity,
                  ( unsigned char __RPC_FAR * )&crUnaffectedColor,
                  ( unsigned char __RPC_FAR * )&crTransparentColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2502],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasGetScreen_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvDest,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2572],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2572],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnvDest,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2572],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int id,
    /* [string] */ BSTR defaultString,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2606],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2606],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&id,
                  ( unsigned char __RPC_FAR * )&defaultString,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2606],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawText_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR text,
    /* [string] */ BSTR font,
    int size,
    double x,
    double y,
    int crColor,
    int isBold,
    int isItalics,
    int isUnderline,
    int isCentred,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2646],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2646],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&text,
                  ( unsigned char __RPC_FAR * )&font,
                  ( unsigned char __RPC_FAR * )&size,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&isBold,
                  ( unsigned char __RPC_FAR * )&isItalics,
                  ( unsigned char __RPC_FAR * )&isUnderline,
                  ( unsigned char __RPC_FAR * )&isCentred,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2646],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasPopup_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    int stepSize,
    int popupType,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2740],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2740],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&stepSize,
                  ( unsigned char __RPC_FAR * )&popupType,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2740],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasWidth_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2798],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2798],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2798],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasHeight_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2832],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2832],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2832],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawLine_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2866],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2866],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x1,
                  ( unsigned char __RPC_FAR * )&y1,
                  ( unsigned char __RPC_FAR * )&x2,
                  ( unsigned char __RPC_FAR * )&y2,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2866],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawRect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2930],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2930],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x1,
                  ( unsigned char __RPC_FAR * )&y1,
                  ( unsigned char __RPC_FAR * )&x2,
                  ( unsigned char __RPC_FAR * )&y2,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2930],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasFillRect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2994],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2994],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&x1,
                  ( unsigned char __RPC_FAR * )&y1,
                  ( unsigned char __RPC_FAR * )&x2,
                  ( unsigned char __RPC_FAR * )&y2,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[2994],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawHand_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int pointx,
    int pointy,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3058],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3058],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&pointx,
                  ( unsigned char __RPC_FAR * )&pointy,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3058],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawHand_Proxy( 
    ICallbacks __RPC_FAR * This,
    int pointx,
    int pointy,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3104],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3104],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&pointx,
                  ( unsigned char __RPC_FAR * )&pointy,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3104],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckKey_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR keyPressed,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3144],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3144],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&keyPressed,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3144],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBPlaySound_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR soundFile,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3178],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3178],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&soundFile,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3178],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBMessageWindow_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR text,
    int textColor,
    int bgColor,
    /* [string] */ BSTR bgPic,
    int mbtype,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3212],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3212],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&text,
                  ( unsigned char __RPC_FAR * )&textColor,
                  ( unsigned char __RPC_FAR * )&bgColor,
                  ( unsigned char __RPC_FAR * )&bgPic,
                  ( unsigned char __RPC_FAR * )&mbtype,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3212],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFileDialog_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR initialPath,
    /* [string] */ BSTR fileFilter,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3270],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3270],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&initialPath,
                  ( unsigned char __RPC_FAR * )&fileFilter,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3270],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDetermineSpecialMoves_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR playerHandle,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3310],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3310],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerHandle,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3310],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveListEntry_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3344],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3344],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3344],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBRunProgram_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR prgFile)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,prgFile);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3378],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3378],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&prgFile);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3378],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetTarget_Proxy( 
    ICallbacks __RPC_FAR * This,
    int targetIdx,
    int ttype)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,ttype);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3406],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3406],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&targetIdx,
                  ( unsigned char __RPC_FAR * )&ttype);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3406],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetSource_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourceIdx,
    int sType)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,sType);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3440],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3440],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&sourceIdx,
                  ( unsigned char __RPC_FAR * )&sType);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3440],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3474],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3474],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3474],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3508],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3508],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3508],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3542],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3542],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3542],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3576],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3576],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3576],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3610],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3610],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3610],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3644],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3644],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3644],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerName_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3678],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3678],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&playerIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3678],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAddPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3712],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3712],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3712],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAddPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3746],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3746],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3746],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3780],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3780],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3780],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3814],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3814],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3814],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3848],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3848],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3848],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,playerIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3882],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3882],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&playerIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3882],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3916],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3916],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3916],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3950],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3950],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3950],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3984],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3984],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[3984],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4018],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4018],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4018],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4052],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4052],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4052],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4086],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4086],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&eneIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4086],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAddEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,eneIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4120],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4120],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&eneIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4120],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAddEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,eneIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4154],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4154],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&eneIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4154],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,eneIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4188],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4188],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&eneIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4188],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,eneIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4222],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4222],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&eneIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4222],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawBackground_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR bkgFile,
    int x,
    int y,
    int width,
    int height)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,height);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4256],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4256],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&bkgFile,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&width,
                  ( unsigned char __RPC_FAR * )&height);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4256],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCreateAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4314],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4314],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&file,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4314],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDestroyAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,idx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4348],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4348],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4348],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int idx,
    int x,
    int y,
    int forceDraw,
    int forceTransp)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,forceTransp);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4376],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4376],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&forceDraw,
                  ( unsigned char __RPC_FAR * )&forceTransp);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4376],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawAnimationFrame_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int idx,
    int frame,
    int x,
    int y,
    int forceTranspFill)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,forceTranspFill);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4434],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4434],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&canvasID,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&frame,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&forceTranspFill);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4434],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationCurrentFrame_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4492],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4492],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4492],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationMaxFrames_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4526],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4526],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4526],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationSizeX_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4560],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4560],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4560],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationSizeY_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4594],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4594],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4594],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationFrameImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    int frame,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4628],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4628],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&idx,
                  ( unsigned char __RPC_FAR * )&frame,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4628],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPartySize_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4668],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4668],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4668],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4702],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4702],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4702],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4742],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4742],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4742],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4782],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4782],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4782],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4822],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4822],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4822],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4862],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4862],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4862],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4902],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4902],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4902],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterName_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4942],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4942],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4942],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [string] */ BSTR animationName,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4982],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4982],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&animationName,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[4982],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterChargePercent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5028],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5028],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5028],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightTick_Proxy( 
    ICallbacks __RPC_FAR * This)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,This);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5068],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5068],
                  ( unsigned char __RPC_FAR * )&This);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5068],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawTextAbsolute_Proxy( 
    ICallbacks __RPC_FAR * This,
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
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5090],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5090],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&text,
                  ( unsigned char __RPC_FAR * )&font,
                  ( unsigned char __RPC_FAR * )&size,
                  ( unsigned char __RPC_FAR * )&x,
                  ( unsigned char __RPC_FAR * )&y,
                  ( unsigned char __RPC_FAR * )&crColor,
                  ( unsigned char __RPC_FAR * )&isBold,
                  ( unsigned char __RPC_FAR * )&isItalics,
                  ( unsigned char __RPC_FAR * )&isUnderline,
                  ( unsigned char __RPC_FAR * )&isCentred,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5090],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseFighterCharge_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,fighterIdx);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5178],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5178],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fighterIdx);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5178],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightDoAttack_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    int amount,
    int toSMP,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5212],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5212],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&sourcePartyIdx,
                  ( unsigned char __RPC_FAR * )&sourceFightIdx,
                  ( unsigned char __RPC_FAR * )&targetPartyIdx,
                  ( unsigned char __RPC_FAR * )&targetFightIdx,
                  ( unsigned char __RPC_FAR * )&amount,
                  ( unsigned char __RPC_FAR * )&toSMP,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5212],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseItem_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR itemFile)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,itemFile);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5276],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5276],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&sourcePartyIdx,
                  ( unsigned char __RPC_FAR * )&sourceFightIdx,
                  ( unsigned char __RPC_FAR * )&targetPartyIdx,
                  ( unsigned char __RPC_FAR * )&targetFightIdx,
                  ( unsigned char __RPC_FAR * )&itemFile);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5276],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseSpecialMove_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR moveFile)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,moveFile);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5328],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5328],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&sourcePartyIdx,
                  ( unsigned char __RPC_FAR * )&sourceFightIdx,
                  ( unsigned char __RPC_FAR * )&targetPartyIdx,
                  ( unsigned char __RPC_FAR * )&targetFightIdx,
                  ( unsigned char __RPC_FAR * )&moveFile);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5328],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBDoEvents_Proxy( 
    ICallbacks __RPC_FAR * This)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,This);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5380],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5380],
                  ( unsigned char __RPC_FAR * )&This);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5380],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterAddStatusEffect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,statusFile);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5402],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5402],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fightIdx,
                  ( unsigned char __RPC_FAR * )&statusFile);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5402],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterRemoveStatusEffect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,statusFile);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5442],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5442],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&partyIdx,
                  ( unsigned char __RPC_FAR * )&fightIdx,
                  ( unsigned char __RPC_FAR * )&statusFile);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5442],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckMusic_Proxy( 
    ICallbacks __RPC_FAR * This)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,This);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5482],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5482],
                  ( unsigned char __RPC_FAR * )&This);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5482],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseScreenDC_Proxy( 
    ICallbacks __RPC_FAR * This)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,This);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5504],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5504],
                  ( unsigned char __RPC_FAR * )&This);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5504],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasOpenHdc_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv,
    /* [retval][out] */ int __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5526],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5526],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnv,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5526],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasCloseHdc_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv,
    int hdc)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,hdc);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5560],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5560],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&cnv,
                  ( unsigned char __RPC_FAR * )&hdc);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5560],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

HRESULT STDMETHODCALLTYPE ICallbacks_CBFileExists_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR strFile,
    /* [retval][out] */ short __RPC_FAR *pRet)
{
CLIENT_CALL_RETURN _RetVal;


#if defined( _ALPHA_ )
    va_list vlist;
#endif
    
#if defined( _ALPHA_ )
    va_start(vlist,pRet);
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5594],
                  vlist.a0);
#elif defined( _PPC_ ) || defined( _MIPS_ )

    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5594],
                  ( unsigned char __RPC_FAR * )&This,
                  ( unsigned char __RPC_FAR * )&strFile,
                  ( unsigned char __RPC_FAR * )&pRet);
#else
    _RetVal = NdrClientCall2(
                  ( PMIDL_STUB_DESC  )&Object_StubDesc,
                  (PFORMAT_STRING) &__MIDL_ProcFormatString.Format[5594],
                  ( unsigned char __RPC_FAR * )&This);
#endif
    return ( HRESULT  )_RetVal.Simple;
    
}

extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[1];

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
    __MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x20000, /* Ndr library version */
    0,
    0x50100a4, /* MIDL Version 5.1.164 */
    0,
    UserMarshalRoutines,
    0,  /* notify & notify_flag routine table */
    1,  /* Flags */
    0,  /* Reserved3 */
    0,  /* Reserved4 */
    0   /* Reserved5 */
    };

static const unsigned short ICallbacks_FormatStringOffsetTable[] = 
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    28,
    62,
    96,
    130,
    164,
    192,
    220,
    248,
    276,
    304,
    332,
    366,
    406,
    446,
    486,
    526,
    572,
    618,
    664,
    710,
    756,
    802,
    848,
    894,
    928,
    962,
    996,
    1036,
    1070,
    1104,
    1138,
    1166,
    1200,
    1228,
    1262,
    1296,
    1330,
    1376,
    1422,
    1474,
    1526,
    1578,
    1630,
    1658,
    1686,
    1726,
    1760,
    1806,
    1876,
    1928,
    2004,
    2068,
    2108,
    2148,
    2188,
    2234,
    2286,
    2362,
    2420,
    2502,
    2572,
    2606,
    2646,
    2740,
    2798,
    2832,
    2866,
    2930,
    2994,
    3058,
    3104,
    3144,
    3178,
    3212,
    3270,
    3310,
    3344,
    3378,
    3406,
    3440,
    3474,
    3508,
    3542,
    3576,
    3610,
    3644,
    3678,
    3712,
    3746,
    3780,
    3814,
    3848,
    3882,
    3916,
    3950,
    3984,
    4018,
    4052,
    4086,
    4120,
    4154,
    4188,
    4222,
    4256,
    4314,
    4348,
    4376,
    4434,
    4492,
    4526,
    4560,
    4594,
    4628,
    4668,
    4702,
    4742,
    4782,
    4822,
    4862,
    4902,
    4942,
    4982,
    5028,
    5068,
    5090,
    5178,
    5212,
    5276,
    5328,
    5380,
    5402,
    5442,
    5482,
    5504,
    5526,
    5560,
    5594
    };

static const MIDL_SERVER_INFO ICallbacks_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    __MIDL_ProcFormatString.Format,
    &ICallbacks_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO ICallbacks_ProxyInfo =
    {
    &Object_StubDesc,
    __MIDL_ProcFormatString.Format,
    &ICallbacks_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };

CINTERFACE_PROXY_VTABLE(145) _ICallbacksProxyVtbl = 
{
    &ICallbacks_ProxyInfo,
    &IID_ICallbacks,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *)-1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *)-1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *)-1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *)-1 /* ICallbacks::CBRpgCode */ ,
    (void *)-1 /* ICallbacks::CBGetString */ ,
    (void *)-1 /* ICallbacks::CBGetNumerical */ ,
    (void *)-1 /* ICallbacks::CBSetString */ ,
    (void *)-1 /* ICallbacks::CBSetNumerical */ ,
    (void *)-1 /* ICallbacks::CBGetScreenDC */ ,
    (void *)-1 /* ICallbacks::CBGetScratch1DC */ ,
    (void *)-1 /* ICallbacks::CBGetScratch2DC */ ,
    (void *)-1 /* ICallbacks::CBGetMwinDC */ ,
    (void *)-1 /* ICallbacks::CBPopupMwin */ ,
    (void *)-1 /* ICallbacks::CBHideMwin */ ,
    (void *)-1 /* ICallbacks::CBLoadEnemy */ ,
    (void *)-1 /* ICallbacks::CBGetEnemyNum */ ,
    (void *)-1 /* ICallbacks::CBGetEnemyString */ ,
    (void *)-1 /* ICallbacks::CBSetEnemyNum */ ,
    (void *)-1 /* ICallbacks::CBSetEnemyString */ ,
    (void *)-1 /* ICallbacks::CBGetPlayerNum */ ,
    (void *)-1 /* ICallbacks::CBGetPlayerString */ ,
    (void *)-1 /* ICallbacks::CBSetPlayerNum */ ,
    (void *)-1 /* ICallbacks::CBSetPlayerString */ ,
    (void *)-1 /* ICallbacks::CBGetGeneralString */ ,
    (void *)-1 /* ICallbacks::CBGetGeneralNum */ ,
    (void *)-1 /* ICallbacks::CBSetGeneralString */ ,
    (void *)-1 /* ICallbacks::CBSetGeneralNum */ ,
    (void *)-1 /* ICallbacks::CBGetCommandName */ ,
    ICallbacks_CBGetBrackets_Proxy ,
    ICallbacks_CBCountBracketElements_Proxy ,
    ICallbacks_CBGetBracketElement_Proxy ,
    ICallbacks_CBGetStringElementValue_Proxy ,
    ICallbacks_CBGetNumElementValue_Proxy ,
    ICallbacks_CBGetElementType_Proxy ,
    ICallbacks_CBDebugMessage_Proxy ,
    ICallbacks_CBGetPathString_Proxy ,
    ICallbacks_CBLoadSpecialMove_Proxy ,
    ICallbacks_CBGetSpecialMoveString_Proxy ,
    ICallbacks_CBGetSpecialMoveNum_Proxy ,
    ICallbacks_CBLoadItem_Proxy ,
    ICallbacks_CBGetItemString_Proxy ,
    ICallbacks_CBGetItemNum_Proxy ,
    ICallbacks_CBGetBoardNum_Proxy ,
    ICallbacks_CBGetBoardString_Proxy ,
    ICallbacks_CBSetBoardNum_Proxy ,
    ICallbacks_CBSetBoardString_Proxy ,
    ICallbacks_CBGetHwnd_Proxy ,
    ICallbacks_CBRefreshScreen_Proxy ,
    ICallbacks_CBCreateCanvas_Proxy ,
    ICallbacks_CBDestroyCanvas_Proxy ,
    ICallbacks_CBDrawCanvas_Proxy ,
    ICallbacks_CBDrawCanvasPartial_Proxy ,
    ICallbacks_CBDrawCanvasTransparent_Proxy ,
    ICallbacks_CBDrawCanvasTransparentPartial_Proxy ,
    ICallbacks_CBDrawCanvasTranslucent_Proxy ,
    ICallbacks_CBCanvasLoadImage_Proxy ,
    ICallbacks_CBCanvasLoadSizedImage_Proxy ,
    ICallbacks_CBCanvasFill_Proxy ,
    ICallbacks_CBCanvasResize_Proxy ,
    ICallbacks_CBCanvas2CanvasBlt_Proxy ,
    ICallbacks_CBCanvas2CanvasBltPartial_Proxy ,
    ICallbacks_CBCanvas2CanvasBltTransparent_Proxy ,
    ICallbacks_CBCanvas2CanvasBltTransparentPartial_Proxy ,
    ICallbacks_CBCanvas2CanvasBltTranslucent_Proxy ,
    ICallbacks_CBCanvasGetScreen_Proxy ,
    ICallbacks_CBLoadString_Proxy ,
    ICallbacks_CBCanvasDrawText_Proxy ,
    ICallbacks_CBCanvasPopup_Proxy ,
    ICallbacks_CBCanvasWidth_Proxy ,
    ICallbacks_CBCanvasHeight_Proxy ,
    ICallbacks_CBCanvasDrawLine_Proxy ,
    ICallbacks_CBCanvasDrawRect_Proxy ,
    ICallbacks_CBCanvasFillRect_Proxy ,
    ICallbacks_CBCanvasDrawHand_Proxy ,
    ICallbacks_CBDrawHand_Proxy ,
    ICallbacks_CBCheckKey_Proxy ,
    ICallbacks_CBPlaySound_Proxy ,
    ICallbacks_CBMessageWindow_Proxy ,
    ICallbacks_CBFileDialog_Proxy ,
    ICallbacks_CBDetermineSpecialMoves_Proxy ,
    ICallbacks_CBGetSpecialMoveListEntry_Proxy ,
    ICallbacks_CBRunProgram_Proxy ,
    ICallbacks_CBSetTarget_Proxy ,
    ICallbacks_CBSetSource_Proxy ,
    ICallbacks_CBGetPlayerHP_Proxy ,
    ICallbacks_CBGetPlayerMaxHP_Proxy ,
    ICallbacks_CBGetPlayerSMP_Proxy ,
    ICallbacks_CBGetPlayerMaxSMP_Proxy ,
    ICallbacks_CBGetPlayerFP_Proxy ,
    ICallbacks_CBGetPlayerDP_Proxy ,
    ICallbacks_CBGetPlayerName_Proxy ,
    ICallbacks_CBAddPlayerHP_Proxy ,
    ICallbacks_CBAddPlayerSMP_Proxy ,
    ICallbacks_CBSetPlayerHP_Proxy ,
    ICallbacks_CBSetPlayerSMP_Proxy ,
    ICallbacks_CBSetPlayerFP_Proxy ,
    ICallbacks_CBSetPlayerDP_Proxy ,
    ICallbacks_CBGetEnemyHP_Proxy ,
    ICallbacks_CBGetEnemyMaxHP_Proxy ,
    ICallbacks_CBGetEnemySMP_Proxy ,
    ICallbacks_CBGetEnemyMaxSMP_Proxy ,
    ICallbacks_CBGetEnemyFP_Proxy ,
    ICallbacks_CBGetEnemyDP_Proxy ,
    ICallbacks_CBAddEnemyHP_Proxy ,
    ICallbacks_CBAddEnemySMP_Proxy ,
    ICallbacks_CBSetEnemyHP_Proxy ,
    ICallbacks_CBSetEnemySMP_Proxy ,
    ICallbacks_CBCanvasDrawBackground_Proxy ,
    ICallbacks_CBCreateAnimation_Proxy ,
    ICallbacks_CBDestroyAnimation_Proxy ,
    ICallbacks_CBCanvasDrawAnimation_Proxy ,
    ICallbacks_CBCanvasDrawAnimationFrame_Proxy ,
    ICallbacks_CBAnimationCurrentFrame_Proxy ,
    ICallbacks_CBAnimationMaxFrames_Proxy ,
    ICallbacks_CBAnimationSizeX_Proxy ,
    ICallbacks_CBAnimationSizeY_Proxy ,
    ICallbacks_CBAnimationFrameImage_Proxy ,
    ICallbacks_CBGetPartySize_Proxy ,
    ICallbacks_CBGetFighterHP_Proxy ,
    ICallbacks_CBGetFighterMaxHP_Proxy ,
    ICallbacks_CBGetFighterSMP_Proxy ,
    ICallbacks_CBGetFighterMaxSMP_Proxy ,
    ICallbacks_CBGetFighterFP_Proxy ,
    ICallbacks_CBGetFighterDP_Proxy ,
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
    ICallbacks_CBFileExists_Proxy
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
    NdrStubCall2
};

CInterfaceStubVtbl _ICallbacksStubVtbl =
{
    &IID_ICallbacks,
    &ICallbacks_ServerInfo,
    145,
    &ICallbacks_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};

#pragma data_seg(".rdata")

static const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[1] = 
        {
            
            {
            BSTR_UserSize
            ,BSTR_UserMarshal
            ,BSTR_UserUnmarshal
            ,BSTR_UserFree
            }

        };


#if !defined(__RPC_WIN32__)
#error  Invalid build platform for this stub.
#endif

#if !(TARGET_IS_NT40_OR_LATER)
#error You need a Windows NT 4.0 or later to run this stub because it uses these features:
#error   -Oif or -Oicf, [wire_marshal] or [user_marshal] attribute, more than 32 methods in the interface.
#error However, your C/C++ compilation flags indicate you intend to run this app on earlier systems.
#error This app will die there with the RPC_X_WRONG_STUB_VERSION error.
#endif


static const MIDL_PROC_FORMAT_STRING __MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure CBRpgCode */

			0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/*  2 */	NdrFcLong( 0x0 ),	/* 0 */
/*  6 */	NdrFcShort( 0x7 ),	/* 7 */
#ifndef _ALPHA_
/*  8 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 10 */	NdrFcShort( 0x0 ),	/* 0 */
/* 12 */	NdrFcShort( 0x8 ),	/* 8 */
/* 14 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x2,		/* 2 */

	/* Parameter rpgcodeCommand */

/* 16 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 18 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 20 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 22 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 24 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 26 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetString */

/* 28 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 30 */	NdrFcLong( 0x0 ),	/* 0 */
/* 34 */	NdrFcShort( 0x8 ),	/* 8 */
#ifndef _ALPHA_
/* 36 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 38 */	NdrFcShort( 0x0 ),	/* 0 */
/* 40 */	NdrFcShort( 0x8 ),	/* 8 */
/* 42 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter varname */

/* 44 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 46 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 48 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 50 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 52 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 54 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 56 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 58 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 60 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetNumerical */

/* 62 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 64 */	NdrFcLong( 0x0 ),	/* 0 */
/* 68 */	NdrFcShort( 0x9 ),	/* 9 */
#ifndef _ALPHA_
/* 70 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 72 */	NdrFcShort( 0x0 ),	/* 0 */
/* 74 */	NdrFcShort( 0x18 ),	/* 24 */
/* 76 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter varname */

/* 78 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 80 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 82 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 84 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 86 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 88 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 90 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 92 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 94 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetString */

/* 96 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 98 */	NdrFcLong( 0x0 ),	/* 0 */
/* 102 */	NdrFcShort( 0xa ),	/* 10 */
#ifndef _ALPHA_
/* 104 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 106 */	NdrFcShort( 0x0 ),	/* 0 */
/* 108 */	NdrFcShort( 0x8 ),	/* 8 */
/* 110 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter varname */

/* 112 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 114 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 116 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter newValue */

/* 118 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 120 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 122 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 124 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 126 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 128 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetNumerical */

/* 130 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 132 */	NdrFcLong( 0x0 ),	/* 0 */
/* 136 */	NdrFcShort( 0xb ),	/* 11 */
#ifndef _ALPHA_
/* 138 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 140 */	NdrFcShort( 0x10 ),	/* 16 */
/* 142 */	NdrFcShort( 0x8 ),	/* 8 */
/* 144 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter varname */

/* 146 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 148 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 150 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter newValue */

/* 152 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 154 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 156 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 158 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 160 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 162 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScreenDC */

/* 164 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 166 */	NdrFcLong( 0x0 ),	/* 0 */
/* 170 */	NdrFcShort( 0xc ),	/* 12 */
#ifndef _ALPHA_
/* 172 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 174 */	NdrFcShort( 0x0 ),	/* 0 */
/* 176 */	NdrFcShort( 0x10 ),	/* 16 */
/* 178 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 180 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 182 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 184 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 186 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 188 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 190 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScratch1DC */

/* 192 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 194 */	NdrFcLong( 0x0 ),	/* 0 */
/* 198 */	NdrFcShort( 0xd ),	/* 13 */
#ifndef _ALPHA_
/* 200 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 202 */	NdrFcShort( 0x0 ),	/* 0 */
/* 204 */	NdrFcShort( 0x10 ),	/* 16 */
/* 206 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 208 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 210 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 212 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 214 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 216 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 218 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetScratch2DC */

/* 220 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 222 */	NdrFcLong( 0x0 ),	/* 0 */
/* 226 */	NdrFcShort( 0xe ),	/* 14 */
#ifndef _ALPHA_
/* 228 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 230 */	NdrFcShort( 0x0 ),	/* 0 */
/* 232 */	NdrFcShort( 0x10 ),	/* 16 */
/* 234 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 236 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 238 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 240 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 242 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 244 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 246 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetMwinDC */

/* 248 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 250 */	NdrFcLong( 0x0 ),	/* 0 */
/* 254 */	NdrFcShort( 0xf ),	/* 15 */
#ifndef _ALPHA_
/* 256 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 260 */	NdrFcShort( 0x10 ),	/* 16 */
/* 262 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 264 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 266 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 270 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 272 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBPopupMwin */

/* 276 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 278 */	NdrFcLong( 0x0 ),	/* 0 */
/* 282 */	NdrFcShort( 0x10 ),	/* 16 */
#ifndef _ALPHA_
/* 284 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 286 */	NdrFcShort( 0x0 ),	/* 0 */
/* 288 */	NdrFcShort( 0x10 ),	/* 16 */
/* 290 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 292 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 294 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 296 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 298 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 300 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 302 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBHideMwin */

/* 304 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 306 */	NdrFcLong( 0x0 ),	/* 0 */
/* 310 */	NdrFcShort( 0x11 ),	/* 17 */
#ifndef _ALPHA_
/* 312 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 314 */	NdrFcShort( 0x0 ),	/* 0 */
/* 316 */	NdrFcShort( 0x10 ),	/* 16 */
/* 318 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 320 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 322 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 324 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 326 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 328 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 330 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadEnemy */

/* 332 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 334 */	NdrFcLong( 0x0 ),	/* 0 */
/* 338 */	NdrFcShort( 0x12 ),	/* 18 */
#ifndef _ALPHA_
/* 340 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 342 */	NdrFcShort( 0x8 ),	/* 8 */
/* 344 */	NdrFcShort( 0x8 ),	/* 8 */
/* 346 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter file */

/* 348 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 350 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 352 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter eneSlot */

/* 354 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 356 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 358 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 360 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 362 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 364 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyNum */

/* 366 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 368 */	NdrFcLong( 0x0 ),	/* 0 */
/* 372 */	NdrFcShort( 0x13 ),	/* 19 */
#ifndef _ALPHA_
/* 374 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 376 */	NdrFcShort( 0x10 ),	/* 16 */
/* 378 */	NdrFcShort( 0x10 ),	/* 16 */
/* 380 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter infoCode */

/* 382 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 384 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 386 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 388 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 390 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 392 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 394 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 396 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 398 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 400 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 402 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 404 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyString */

/* 406 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 408 */	NdrFcLong( 0x0 ),	/* 0 */
/* 412 */	NdrFcShort( 0x14 ),	/* 20 */
#ifndef _ALPHA_
/* 414 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 416 */	NdrFcShort( 0x10 ),	/* 16 */
/* 418 */	NdrFcShort( 0x8 ),	/* 8 */
/* 420 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x4,		/* 4 */

	/* Parameter infoCode */

/* 422 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 424 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 426 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 428 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 430 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 432 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 434 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 436 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 438 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 440 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 442 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 444 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyNum */

/* 446 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 448 */	NdrFcLong( 0x0 ),	/* 0 */
/* 452 */	NdrFcShort( 0x15 ),	/* 21 */
#ifndef _ALPHA_
/* 454 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 456 */	NdrFcShort( 0x18 ),	/* 24 */
/* 458 */	NdrFcShort( 0x8 ),	/* 8 */
/* 460 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter infoCode */

/* 462 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 464 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 466 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newValue */

/* 468 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 470 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneSlot */

/* 474 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 476 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 478 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 480 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 482 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 484 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyString */

/* 486 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 488 */	NdrFcLong( 0x0 ),	/* 0 */
/* 492 */	NdrFcShort( 0x16 ),	/* 22 */
#ifndef _ALPHA_
/* 494 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 496 */	NdrFcShort( 0x10 ),	/* 16 */
/* 498 */	NdrFcShort( 0x8 ),	/* 8 */
/* 500 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter infoCode */

/* 502 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 504 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 506 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newValue */

/* 508 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 510 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 512 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter eneSlot */

/* 514 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 516 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 518 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 520 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 522 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerNum */

/* 526 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 528 */	NdrFcLong( 0x0 ),	/* 0 */
/* 532 */	NdrFcShort( 0x17 ),	/* 23 */
#ifndef _ALPHA_
/* 534 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 536 */	NdrFcShort( 0x18 ),	/* 24 */
/* 538 */	NdrFcShort( 0x10 ),	/* 16 */
/* 540 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 542 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 544 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 548 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 550 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 552 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 554 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 556 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 558 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 560 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 562 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 564 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 566 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 568 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerString */

/* 572 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 574 */	NdrFcLong( 0x0 ),	/* 0 */
/* 578 */	NdrFcShort( 0x18 ),	/* 24 */
#ifndef _ALPHA_
/* 580 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 582 */	NdrFcShort( 0x18 ),	/* 24 */
/* 584 */	NdrFcShort( 0x8 ),	/* 8 */
/* 586 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 588 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 590 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 594 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 596 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 600 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 602 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 604 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 606 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 608 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 610 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 612 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 614 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 616 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerNum */

/* 618 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 620 */	NdrFcLong( 0x0 ),	/* 0 */
/* 624 */	NdrFcShort( 0x19 ),	/* 25 */
#ifndef _ALPHA_
/* 626 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 628 */	NdrFcShort( 0x20 ),	/* 32 */
/* 630 */	NdrFcShort( 0x8 ),	/* 8 */
/* 632 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 634 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 636 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 638 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 640 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 642 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 644 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 646 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 648 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 650 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 652 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 654 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 656 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 658 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 660 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 662 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerString */

/* 664 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 666 */	NdrFcLong( 0x0 ),	/* 0 */
/* 670 */	NdrFcShort( 0x1a ),	/* 26 */
#ifndef _ALPHA_
/* 672 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 674 */	NdrFcShort( 0x18 ),	/* 24 */
/* 676 */	NdrFcShort( 0x8 ),	/* 8 */
/* 678 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 680 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 682 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 684 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 686 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 688 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 690 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 692 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 694 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 696 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter playerSlot */

/* 698 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 700 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 702 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 704 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 706 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 708 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetGeneralString */

/* 710 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 712 */	NdrFcLong( 0x0 ),	/* 0 */
/* 716 */	NdrFcShort( 0x1b ),	/* 27 */
#ifndef _ALPHA_
/* 718 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 720 */	NdrFcShort( 0x18 ),	/* 24 */
/* 722 */	NdrFcShort( 0x8 ),	/* 8 */
/* 724 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 726 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 728 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 730 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 732 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 734 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 736 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 738 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 740 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 742 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 744 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 746 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 748 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 750 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 752 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 754 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetGeneralNum */

/* 756 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 758 */	NdrFcLong( 0x0 ),	/* 0 */
/* 762 */	NdrFcShort( 0x1c ),	/* 28 */
#ifndef _ALPHA_
/* 764 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 766 */	NdrFcShort( 0x18 ),	/* 24 */
/* 768 */	NdrFcShort( 0x10 ),	/* 16 */
/* 770 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 772 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 774 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 776 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 778 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 780 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 782 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 784 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 786 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 790 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 792 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 794 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 796 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 798 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 800 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetGeneralString */

/* 802 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 804 */	NdrFcLong( 0x0 ),	/* 0 */
/* 808 */	NdrFcShort( 0x1d ),	/* 29 */
#ifndef _ALPHA_
/* 810 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 812 */	NdrFcShort( 0x18 ),	/* 24 */
/* 814 */	NdrFcShort( 0x8 ),	/* 8 */
/* 816 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 818 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 820 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 822 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 824 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 826 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 828 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 830 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 832 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 834 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 836 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 838 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 840 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 842 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 844 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 846 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetGeneralNum */

/* 848 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 850 */	NdrFcLong( 0x0 ),	/* 0 */
/* 854 */	NdrFcShort( 0x1e ),	/* 30 */
#ifndef _ALPHA_
/* 856 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 858 */	NdrFcShort( 0x20 ),	/* 32 */
/* 860 */	NdrFcShort( 0x8 ),	/* 8 */
/* 862 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 864 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 866 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 870 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 872 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 874 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerSlot */

/* 876 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 878 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 880 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 882 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 884 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 886 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 888 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 890 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 892 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetCommandName */

/* 894 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 896 */	NdrFcLong( 0x0 ),	/* 0 */
/* 900 */	NdrFcShort( 0x1f ),	/* 31 */
#ifndef _ALPHA_
/* 902 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 904 */	NdrFcShort( 0x0 ),	/* 0 */
/* 906 */	NdrFcShort( 0x8 ),	/* 8 */
/* 908 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 910 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 912 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 914 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 916 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 918 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 920 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 922 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 924 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 926 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBrackets */

/* 928 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 930 */	NdrFcLong( 0x0 ),	/* 0 */
/* 934 */	NdrFcShort( 0x20 ),	/* 32 */
#ifndef _ALPHA_
/* 936 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 938 */	NdrFcShort( 0x0 ),	/* 0 */
/* 940 */	NdrFcShort( 0x8 ),	/* 8 */
/* 942 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 944 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 946 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 948 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 950 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 952 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 954 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 956 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 958 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 960 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCountBracketElements */

/* 962 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 964 */	NdrFcLong( 0x0 ),	/* 0 */
/* 968 */	NdrFcShort( 0x21 ),	/* 33 */
#ifndef _ALPHA_
/* 970 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 972 */	NdrFcShort( 0x0 ),	/* 0 */
/* 974 */	NdrFcShort( 0x10 ),	/* 16 */
/* 976 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 978 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 980 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 982 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 984 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 986 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 988 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 990 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 992 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 994 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBracketElement */

/* 996 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 998 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1002 */	NdrFcShort( 0x22 ),	/* 34 */
#ifndef _ALPHA_
/* 1004 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1006 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1008 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1010 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter rpgcodeCommand */

/* 1012 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1014 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1016 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter elemNum */

/* 1018 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1020 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1022 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1024 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1026 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1028 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1030 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1032 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1034 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetStringElementValue */

/* 1036 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1038 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1042 */	NdrFcShort( 0x23 ),	/* 35 */
#ifndef _ALPHA_
/* 1044 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1046 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1048 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1050 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 1052 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1054 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1056 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 1058 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1060 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1062 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1064 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1066 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1068 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetNumElementValue */

/* 1070 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1072 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1076 */	NdrFcShort( 0x24 ),	/* 36 */
#ifndef _ALPHA_
/* 1078 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1080 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1082 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1084 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 1086 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1088 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1090 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 1092 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1094 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1096 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 1098 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1100 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1102 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetElementType */

/* 1104 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1106 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1110 */	NdrFcShort( 0x25 ),	/* 37 */
#ifndef _ALPHA_
/* 1112 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1114 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1116 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1118 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter rpgcodeCommand */

/* 1120 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1122 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1124 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 1126 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1128 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1132 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1134 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDebugMessage */

/* 1138 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1140 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1144 */	NdrFcShort( 0x26 ),	/* 38 */
#ifndef _ALPHA_
/* 1146 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1148 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1150 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1152 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x2,		/* 2 */

	/* Parameter message */

/* 1154 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1156 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1158 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 1160 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1162 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1164 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPathString */

/* 1166 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1168 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1172 */	NdrFcShort( 0x27 ),	/* 39 */
#ifndef _ALPHA_
/* 1174 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1176 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1178 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1180 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x3,		/* 3 */

	/* Parameter infoCode */

/* 1182 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1184 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1186 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1188 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1190 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1192 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1194 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1196 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1198 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadSpecialMove */

/* 1200 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1202 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1206 */	NdrFcShort( 0x28 ),	/* 40 */
#ifndef _ALPHA_
/* 1208 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1210 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1212 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1214 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x2,		/* 2 */

	/* Parameter file */

/* 1216 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1218 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1220 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 1222 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1224 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1226 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveString */

/* 1228 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1230 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1234 */	NdrFcShort( 0x29 ),	/* 41 */
#ifndef _ALPHA_
/* 1236 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1238 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1240 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1242 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x3,		/* 3 */

	/* Parameter infoCode */

/* 1244 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1246 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1248 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1250 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1252 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1254 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1256 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1258 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1260 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveNum */

/* 1262 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1264 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1268 */	NdrFcShort( 0x2a ),	/* 42 */
#ifndef _ALPHA_
/* 1270 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1272 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1274 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1276 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter infoCode */

/* 1278 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1280 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1282 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1284 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1286 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1288 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1290 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1292 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadItem */

/* 1296 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1298 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1302 */	NdrFcShort( 0x2b ),	/* 43 */
#ifndef _ALPHA_
/* 1304 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1306 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1308 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1310 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter file */

/* 1312 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1314 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1316 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter itmSlot */

/* 1318 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1320 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1322 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1324 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1326 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1328 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetItemString */

/* 1330 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1332 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1336 */	NdrFcShort( 0x2c ),	/* 44 */
#ifndef _ALPHA_
/* 1338 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1340 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1342 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1344 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 1346 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1348 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1350 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1352 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1354 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1356 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itmSlot */

/* 1358 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1360 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1362 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1364 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1366 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1368 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1370 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1372 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1374 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetItemNum */

/* 1376 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1378 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1382 */	NdrFcShort( 0x2d ),	/* 45 */
#ifndef _ALPHA_
/* 1384 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1386 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1388 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1390 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter infoCode */

/* 1392 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1394 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1396 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos */

/* 1398 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1400 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1402 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itmSlot */

/* 1404 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1406 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1410 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1412 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1414 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1416 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1418 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1420 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBoardNum */

/* 1422 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1424 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1428 */	NdrFcShort( 0x2e ),	/* 46 */
#ifndef _ALPHA_
/* 1430 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1432 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1434 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1436 */	0x4,		/* Oi2 Flags:  has return, */
			0x6,		/* 6 */

	/* Parameter infoCode */

/* 1438 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1440 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1442 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1444 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1446 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1448 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1450 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1452 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1454 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1456 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1458 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1462 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1464 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1466 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1468 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1470 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetBoardString */

/* 1474 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1476 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1480 */	NdrFcShort( 0x2f ),	/* 47 */
#ifndef _ALPHA_
/* 1482 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1484 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1486 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1488 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x6,		/* 6 */

	/* Parameter infoCode */

/* 1490 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1492 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1496 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1498 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1500 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1502 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1504 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1506 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1508 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1510 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1512 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1514 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1516 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1518 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 1520 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1522 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetBoardNum */

/* 1526 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1528 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1532 */	NdrFcShort( 0x30 ),	/* 48 */
#ifndef _ALPHA_
/* 1534 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1536 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1538 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1540 */	0x4,		/* Oi2 Flags:  has return, */
			0x6,		/* 6 */

	/* Parameter infoCode */

/* 1542 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1544 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1548 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1550 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1552 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1554 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1556 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1558 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1560 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1562 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1564 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter nValue */

/* 1566 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1568 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1572 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1574 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1576 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetBoardString */

/* 1578 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1580 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1584 */	NdrFcShort( 0x31 ),	/* 49 */
#ifndef _ALPHA_
/* 1586 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1588 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1590 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1592 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x6,		/* 6 */

	/* Parameter infoCode */

/* 1594 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1596 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos1 */

/* 1600 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1602 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1604 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos2 */

/* 1606 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1608 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1610 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter arrayPos3 */

/* 1612 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1614 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1616 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter newVal */

/* 1618 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 1620 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1622 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 1624 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1626 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1628 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetHwnd */

/* 1630 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1632 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1636 */	NdrFcShort( 0x32 ),	/* 50 */
#ifndef _ALPHA_
/* 1638 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1640 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1642 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1644 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 1646 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1648 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1650 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1652 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1654 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1656 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBRefreshScreen */

/* 1658 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1660 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1664 */	NdrFcShort( 0x33 ),	/* 51 */
#ifndef _ALPHA_
/* 1666 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1668 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1670 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1672 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter pRet */

/* 1674 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1676 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1678 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1680 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1682 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1684 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCreateCanvas */

/* 1686 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1688 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1692 */	NdrFcShort( 0x34 ),	/* 52 */
#ifndef _ALPHA_
/* 1694 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1696 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1698 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1700 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter width */

/* 1702 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1704 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 1708 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1710 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1714 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1716 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1718 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1720 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1722 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1724 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDestroyCanvas */

/* 1726 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1728 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1732 */	NdrFcShort( 0x35 ),	/* 53 */
#ifndef _ALPHA_
/* 1734 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1736 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1738 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1740 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter canvasID */

/* 1742 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1744 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1746 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1748 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1750 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1752 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1754 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1756 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1758 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvas */

/* 1760 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1762 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1766 */	NdrFcShort( 0x36 ),	/* 54 */
#ifndef _ALPHA_
/* 1768 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1770 */	NdrFcShort( 0x18 ),	/* 24 */
/* 1772 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1774 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter canvasID */

/* 1776 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1778 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1780 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 1782 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1784 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1786 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 1788 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1790 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1792 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1794 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1796 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1798 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1800 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1802 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1804 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasPartial */

/* 1806 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1808 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1812 */	NdrFcShort( 0x37 ),	/* 55 */
#ifndef _ALPHA_
/* 1814 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 1816 */	NdrFcShort( 0x38 ),	/* 56 */
/* 1818 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1820 */	0x4,		/* Oi2 Flags:  has return, */
			0x9,		/* 9 */

	/* Parameter canvasID */

/* 1822 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1824 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1826 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 1828 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1830 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1832 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 1834 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1836 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1838 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 1840 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1842 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1844 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 1846 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1848 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1850 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 1852 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1854 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1856 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 1858 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1860 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1862 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1864 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1866 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 1868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1870 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1872 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 1874 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTransparent */

/* 1876 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1878 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1882 */	NdrFcShort( 0x38 ),	/* 56 */
#ifndef _ALPHA_
/* 1884 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1886 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1888 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1890 */	0x4,		/* Oi2 Flags:  has return, */
			0x6,		/* 6 */

	/* Parameter canvasID */

/* 1892 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1894 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1896 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 1898 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1900 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 1904 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1906 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1908 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 1910 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1912 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1914 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1916 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1918 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1920 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1922 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 1924 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1926 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTransparentPartial */

/* 1928 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1930 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1934 */	NdrFcShort( 0x39 ),	/* 57 */
#ifndef _ALPHA_
/* 1936 */	NdrFcShort( 0x2c ),	/* x86, MIPS, PPC Stack size/offset = 44 */
#else
			NdrFcShort( 0x58 ),	/* Alpha Stack size/offset = 88 */
#endif
/* 1938 */	NdrFcShort( 0x40 ),	/* 64 */
/* 1940 */	NdrFcShort( 0x10 ),	/* 16 */
/* 1942 */	0x4,		/* Oi2 Flags:  has return, */
			0xa,		/* 10 */

	/* Parameter canvasID */

/* 1944 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1946 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 1948 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 1950 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1952 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 1954 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 1956 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1958 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 1960 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 1962 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1964 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 1966 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 1968 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1970 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 1972 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 1974 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1976 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 1978 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 1980 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1982 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 1984 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 1986 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 1988 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 1990 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 1992 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 1994 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 1996 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1998 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2000 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 2002 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawCanvasTranslucent */

/* 2004 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2006 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2010 */	NdrFcShort( 0x3a ),	/* 58 */
#ifndef _ALPHA_
/* 2012 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2014 */	NdrFcShort( 0x38 ),	/* 56 */
/* 2016 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2018 */	0x4,		/* Oi2 Flags:  has return, */
			0x8,		/* 8 */

	/* Parameter canvasID */

/* 2020 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2022 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2024 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2026 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2028 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2030 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 2032 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2034 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2036 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter dIntensity */

/* 2038 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2040 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2042 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crUnaffectedColor */

/* 2044 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2046 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2048 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2050 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2052 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2054 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2056 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2058 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2060 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2062 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2064 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2066 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasLoadImage */

/* 2068 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2070 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2074 */	NdrFcShort( 0x3b ),	/* 59 */
#ifndef _ALPHA_
/* 2076 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2078 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2080 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2082 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter canvasID */

/* 2084 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2086 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2088 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter filename */

/* 2090 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 2092 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2094 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 2096 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2098 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2100 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2102 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2104 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2106 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasLoadSizedImage */

/* 2108 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2110 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2114 */	NdrFcShort( 0x3c ),	/* 60 */
#ifndef _ALPHA_
/* 2116 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2118 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2120 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2122 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter canvasID */

/* 2124 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2126 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2128 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter filename */

/* 2130 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 2132 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2134 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 2136 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2138 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2142 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2144 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasFill */

/* 2148 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2150 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2154 */	NdrFcShort( 0x3d ),	/* 61 */
#ifndef _ALPHA_
/* 2156 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2158 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2160 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2162 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter canvasID */

/* 2164 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2166 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2168 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 2170 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2172 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2174 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2176 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2178 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2180 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2182 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2184 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2186 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasResize */

/* 2188 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2190 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2194 */	NdrFcShort( 0x3e ),	/* 62 */
#ifndef _ALPHA_
/* 2196 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2198 */	NdrFcShort( 0x18 ),	/* 24 */
/* 2200 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2202 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter canvasID */

/* 2204 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2206 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2208 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2210 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2212 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2214 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2216 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2218 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2220 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2222 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2224 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2226 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2228 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2230 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2232 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBlt */

/* 2234 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2236 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2240 */	NdrFcShort( 0x3f ),	/* 63 */
#ifndef _ALPHA_
/* 2242 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2244 */	NdrFcShort( 0x20 ),	/* 32 */
/* 2246 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2248 */	0x4,		/* Oi2 Flags:  has return, */
			0x6,		/* 6 */

	/* Parameter cnvSrc */

/* 2250 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2252 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2254 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2256 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2258 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2260 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2262 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2264 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2266 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2268 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2270 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2272 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2274 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2276 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2278 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2280 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2282 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2284 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltPartial */

/* 2286 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2288 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2292 */	NdrFcShort( 0x40 ),	/* 64 */
#ifndef _ALPHA_
/* 2294 */	NdrFcShort( 0x2c ),	/* x86, MIPS, PPC Stack size/offset = 44 */
#else
			NdrFcShort( 0x58 ),	/* Alpha Stack size/offset = 88 */
#endif
/* 2296 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2298 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2300 */	0x4,		/* Oi2 Flags:  has return, */
			0xa,		/* 10 */

	/* Parameter cnvSrc */

/* 2302 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2304 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2306 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2308 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2310 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2312 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2314 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2316 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2318 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2320 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2322 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2324 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2326 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2328 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2330 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2332 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2334 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2336 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2338 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2340 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2342 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2344 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2346 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2348 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2350 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2352 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2354 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2356 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2358 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 2360 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTransparent */

/* 2362 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2364 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2368 */	NdrFcShort( 0x41 ),	/* 65 */
#ifndef _ALPHA_
/* 2370 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2372 */	NdrFcShort( 0x28 ),	/* 40 */
/* 2374 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2376 */	0x4,		/* Oi2 Flags:  has return, */
			0x7,		/* 7 */

	/* Parameter cnvSrc */

/* 2378 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2380 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2382 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2384 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2386 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2388 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2390 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2392 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2394 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2396 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2398 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2400 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2402 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2404 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2406 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2408 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2410 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2412 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2414 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2416 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2418 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTransparentPartial */

/* 2420 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2422 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2426 */	NdrFcShort( 0x42 ),	/* 66 */
#ifndef _ALPHA_
/* 2428 */	NdrFcShort( 0x30 ),	/* x86, MIPS, PPC Stack size/offset = 48 */
#else
			NdrFcShort( 0x60 ),	/* Alpha Stack size/offset = 96 */
#endif
/* 2430 */	NdrFcShort( 0x48 ),	/* 72 */
/* 2432 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2434 */	0x4,		/* Oi2 Flags:  has return, */
			0xb,		/* 11 */

	/* Parameter cnvSrc */

/* 2436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2438 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2440 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2442 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2444 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xDest */

/* 2448 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2450 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2452 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter yDest */

/* 2454 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2456 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2458 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter xsrc */

/* 2460 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2462 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2464 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ysrc */

/* 2466 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2468 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2470 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 2472 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2474 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2476 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 2478 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2480 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2482 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2484 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2486 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2488 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2490 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2492 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 2494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2496 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2498 */	NdrFcShort( 0x2c ),	/* x86, MIPS, PPC Stack size/offset = 44 */
#else
			NdrFcShort( 0x58 ),	/* Alpha Stack size/offset = 88 */
#endif
/* 2500 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvas2CanvasBltTranslucent */

/* 2502 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2504 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2508 */	NdrFcShort( 0x43 ),	/* 67 */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2510 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
#else
			NdrFcShort( 0x30 ),	/* MIPS & PPC Stack size/offset = 48 */
#endif
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 2512 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2514 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2516 */	0x4,		/* Oi2 Flags:  has return, */
			0x9,		/* 9 */

	/* Parameter cnvSrc */

/* 2518 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2520 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2522 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter cnvDest */

/* 2524 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2526 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2528 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter destX */

/* 2530 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2532 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2534 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter destY */

/* 2536 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2538 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2540 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter dIntensity */

/* 2542 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2544 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
#else
			NdrFcShort( 0x18 ),	/* MIPS & PPC Stack size/offset = 24 */
#endif
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2546 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crUnaffectedColor */

/* 2548 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2550 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
#else
			NdrFcShort( 0x20 ),	/* MIPS & PPC Stack size/offset = 32 */
#endif
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2552 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crTransparentColor */

/* 2554 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2556 */	NdrFcShort( 0x20 ),	/* x86 Stack size/offset = 32 */
#else
			NdrFcShort( 0x24 ),	/* MIPS & PPC Stack size/offset = 36 */
#endif
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2558 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2560 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2562 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
#else
			NdrFcShort( 0x28 ),	/* MIPS & PPC Stack size/offset = 40 */
#endif
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2564 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2566 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2568 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
#else
			NdrFcShort( 0x2c ),	/* MIPS & PPC Stack size/offset = 44 */
#endif
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasGetScreen */

/* 2572 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2574 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2578 */	NdrFcShort( 0x44 ),	/* 68 */
#ifndef _ALPHA_
/* 2580 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2582 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2584 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2586 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter cnvDest */

/* 2588 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2590 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2594 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2596 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2600 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2602 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2604 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBLoadString */

/* 2606 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2608 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2612 */	NdrFcShort( 0x45 ),	/* 69 */
#ifndef _ALPHA_
/* 2614 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2616 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2618 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2620 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter id */

/* 2622 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2624 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter defaultString */

/* 2628 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 2630 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2632 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 2634 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2636 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2638 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 2640 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2642 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2644 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawText */

/* 2646 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2648 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2652 */	NdrFcShort( 0x46 ),	/* 70 */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2654 */	NdrFcShort( 0x40 ),	/* x86 Stack size/offset = 64 */
#else
			NdrFcShort( 0x44 ),	/* MIPS & PPC Stack size/offset = 68 */
#endif
#else
			NdrFcShort( 0x70 ),	/* Alpha Stack size/offset = 112 */
#endif
/* 2656 */	NdrFcShort( 0x58 ),	/* 88 */
/* 2658 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2660 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0xd,		/* 13 */

	/* Parameter canvasID */

/* 2662 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2664 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter text */

/* 2668 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 2670 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2672 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter font */

/* 2674 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 2676 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2678 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter size */

/* 2680 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2682 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2684 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2686 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2688 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
#else
			NdrFcShort( 0x18 ),	/* MIPS & PPC Stack size/offset = 24 */
#endif
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2690 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter y */

/* 2692 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2694 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
#else
			NdrFcShort( 0x20 ),	/* MIPS & PPC Stack size/offset = 32 */
#endif
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2696 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 2698 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2700 */	NdrFcShort( 0x24 ),	/* x86 Stack size/offset = 36 */
#else
			NdrFcShort( 0x28 ),	/* MIPS & PPC Stack size/offset = 40 */
#endif
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2702 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isBold */

/* 2704 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2706 */	NdrFcShort( 0x28 ),	/* x86 Stack size/offset = 40 */
#else
			NdrFcShort( 0x2c ),	/* MIPS & PPC Stack size/offset = 44 */
#endif
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2708 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isItalics */

/* 2710 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2712 */	NdrFcShort( 0x2c ),	/* x86 Stack size/offset = 44 */
#else
			NdrFcShort( 0x30 ),	/* MIPS & PPC Stack size/offset = 48 */
#endif
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2714 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isUnderline */

/* 2716 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2718 */	NdrFcShort( 0x30 ),	/* x86 Stack size/offset = 48 */
#else
			NdrFcShort( 0x34 ),	/* MIPS & PPC Stack size/offset = 52 */
#endif
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 2720 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isCentred */

/* 2722 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2724 */	NdrFcShort( 0x34 ),	/* x86 Stack size/offset = 52 */
#else
			NdrFcShort( 0x38 ),	/* MIPS & PPC Stack size/offset = 56 */
#endif
#else
			NdrFcShort( 0x58 ),	/* Alpha Stack size/offset = 88 */
#endif
/* 2726 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2728 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2730 */	NdrFcShort( 0x38 ),	/* x86 Stack size/offset = 56 */
#else
			NdrFcShort( 0x3c ),	/* MIPS & PPC Stack size/offset = 60 */
#endif
#else
			NdrFcShort( 0x60 ),	/* Alpha Stack size/offset = 96 */
#endif
/* 2732 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2734 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
#if !defined(_MIPS_) && !defined(_PPC_)
/* 2736 */	NdrFcShort( 0x3c ),	/* x86 Stack size/offset = 60 */
#else
			NdrFcShort( 0x40 ),	/* MIPS & PPC Stack size/offset = 64 */
#endif
#else
			NdrFcShort( 0x68 ),	/* Alpha Stack size/offset = 104 */
#endif
/* 2738 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasPopup */

/* 2740 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2742 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2746 */	NdrFcShort( 0x47 ),	/* 71 */
#ifndef _ALPHA_
/* 2748 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2750 */	NdrFcShort( 0x28 ),	/* 40 */
/* 2752 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2754 */	0x4,		/* Oi2 Flags:  has return, */
			0x7,		/* 7 */

	/* Parameter canvasID */

/* 2756 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2758 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2760 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 2762 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2764 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2766 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 2768 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2770 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2772 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter stepSize */

/* 2774 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2776 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2778 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter popupType */

/* 2780 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2782 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2784 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2786 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2788 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2790 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2792 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2794 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2796 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasWidth */

/* 2798 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2800 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2804 */	NdrFcShort( 0x48 ),	/* 72 */
#ifndef _ALPHA_
/* 2806 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2808 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2810 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2812 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter canvasID */

/* 2814 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2816 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2818 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2820 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2822 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2824 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2826 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2828 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2830 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasHeight */

/* 2832 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2834 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2838 */	NdrFcShort( 0x49 ),	/* 73 */
#ifndef _ALPHA_
/* 2840 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2842 */	NdrFcShort( 0x8 ),	/* 8 */
/* 2844 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2846 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter canvasID */

/* 2848 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2850 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2852 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2854 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2856 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2858 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2860 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2862 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2864 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawLine */

/* 2866 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2868 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2872 */	NdrFcShort( 0x4a ),	/* 74 */
#ifndef _ALPHA_
/* 2874 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2876 */	NdrFcShort( 0x30 ),	/* 48 */
/* 2878 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2880 */	0x4,		/* Oi2 Flags:  has return, */
			0x8,		/* 8 */

	/* Parameter canvasID */

/* 2882 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2884 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2886 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 2888 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2890 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2892 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 2894 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2896 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2898 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 2900 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2902 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2904 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 2906 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2908 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2910 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 2912 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2914 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2916 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2918 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2920 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2922 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2924 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2926 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2928 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawRect */

/* 2930 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2932 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2936 */	NdrFcShort( 0x4b ),	/* 75 */
#ifndef _ALPHA_
/* 2938 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 2940 */	NdrFcShort( 0x30 ),	/* 48 */
/* 2942 */	NdrFcShort( 0x10 ),	/* 16 */
/* 2944 */	0x4,		/* Oi2 Flags:  has return, */
			0x8,		/* 8 */

	/* Parameter canvasID */

/* 2946 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2948 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 2950 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 2952 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2954 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 2956 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 2958 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2960 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 2962 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 2964 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2966 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 2968 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 2970 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2972 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 2974 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 2976 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 2978 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 2980 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 2982 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 2984 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 2986 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2988 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 2990 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 2992 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasFillRect */

/* 2994 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2996 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3000 */	NdrFcShort( 0x4c ),	/* 76 */
#ifndef _ALPHA_
/* 3002 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 3004 */	NdrFcShort( 0x30 ),	/* 48 */
/* 3006 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3008 */	0x4,		/* Oi2 Flags:  has return, */
			0x8,		/* 8 */

	/* Parameter canvasID */

/* 3010 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3012 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3014 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x1 */

/* 3016 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3018 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3020 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y1 */

/* 3022 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3024 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3026 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x2 */

/* 3028 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3030 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3032 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y2 */

/* 3034 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3036 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 3038 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 3040 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3042 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 3044 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3046 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3048 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 3050 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3052 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3054 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 3056 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawHand */

/* 3058 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3060 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3064 */	NdrFcShort( 0x4d ),	/* 77 */
#ifndef _ALPHA_
/* 3066 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 3068 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3070 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3072 */	0x4,		/* Oi2 Flags:  has return, */
			0x5,		/* 5 */

	/* Parameter canvasID */

/* 3074 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3076 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3078 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointx */

/* 3080 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3082 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3084 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointy */

/* 3086 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3088 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3090 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3092 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3094 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3096 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3098 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3100 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 3102 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawHand */

/* 3104 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3106 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3110 */	NdrFcShort( 0x4e ),	/* 78 */
#ifndef _ALPHA_
/* 3112 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 3114 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3116 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3118 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter pointx */

/* 3120 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3122 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3124 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pointy */

/* 3126 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3128 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3132 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3134 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3138 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3140 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCheckKey */

/* 3144 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3146 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3150 */	NdrFcShort( 0x4f ),	/* 79 */
#ifndef _ALPHA_
/* 3152 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3154 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3156 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3158 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter keyPressed */

/* 3160 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3162 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3164 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 3166 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3168 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3170 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3172 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3174 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3176 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBPlaySound */

/* 3178 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3180 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3184 */	NdrFcShort( 0x50 ),	/* 80 */
#ifndef _ALPHA_
/* 3186 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3190 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3192 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter soundFile */

/* 3194 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3196 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3198 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 3200 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3202 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3206 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3208 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3210 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBMessageWindow */

/* 3212 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3214 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3218 */	NdrFcShort( 0x51 ),	/* 81 */
#ifndef _ALPHA_
/* 3220 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 3222 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3224 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3226 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x7,		/* 7 */

	/* Parameter text */

/* 3228 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3230 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3232 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter textColor */

/* 3234 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3236 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bgColor */

/* 3240 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3242 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3244 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bgPic */

/* 3246 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3248 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3250 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter mbtype */

/* 3252 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3254 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 3256 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3258 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3260 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 3262 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3264 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3266 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 3268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFileDialog */

/* 3270 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3272 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3276 */	NdrFcShort( 0x52 ),	/* 82 */
#ifndef _ALPHA_
/* 3278 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 3280 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3282 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3284 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter initialPath */

/* 3286 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3288 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3290 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter fileFilter */

/* 3292 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3294 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3296 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 3298 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3300 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3302 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 3304 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3306 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3308 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDetermineSpecialMoves */

/* 3310 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3312 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3316 */	NdrFcShort( 0x53 ),	/* 83 */
#ifndef _ALPHA_
/* 3318 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3320 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3322 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3324 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter playerHandle */

/* 3326 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3328 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3330 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 3332 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3334 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3336 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3338 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3340 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3342 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetSpecialMoveListEntry */

/* 3344 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3346 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3350 */	NdrFcShort( 0x54 ),	/* 84 */
#ifndef _ALPHA_
/* 3352 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3354 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3356 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3358 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x3,		/* 3 */

	/* Parameter idx */

/* 3360 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3362 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3364 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3366 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3368 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3370 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 3372 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3374 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3376 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBRunProgram */

/* 3378 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3380 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3384 */	NdrFcShort( 0x55 ),	/* 85 */
#ifndef _ALPHA_
/* 3386 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3388 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3390 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3392 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x2,		/* 2 */

	/* Parameter prgFile */

/* 3394 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 3396 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3398 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 3400 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3402 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3404 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetTarget */

/* 3406 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3408 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3412 */	NdrFcShort( 0x56 ),	/* 86 */
#ifndef _ALPHA_
/* 3414 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3416 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3418 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3420 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter targetIdx */

/* 3422 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3424 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3426 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ttype */

/* 3428 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3430 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3432 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3434 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3436 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3438 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetSource */

/* 3440 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3442 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3446 */	NdrFcShort( 0x57 ),	/* 87 */
#ifndef _ALPHA_
/* 3448 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3450 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3452 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3454 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter sourceIdx */

/* 3456 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3458 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sType */

/* 3462 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3464 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3466 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3468 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3470 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerHP */

/* 3474 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3476 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3480 */	NdrFcShort( 0x58 ),	/* 88 */
#ifndef _ALPHA_
/* 3482 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3484 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3486 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3488 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3490 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3492 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3496 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3498 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3500 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3502 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3504 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3506 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerMaxHP */

/* 3508 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3510 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3514 */	NdrFcShort( 0x59 ),	/* 89 */
#ifndef _ALPHA_
/* 3516 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3518 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3520 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3522 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3524 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3526 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3528 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3530 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3532 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3534 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3536 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3538 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3540 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerSMP */

/* 3542 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3544 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3548 */	NdrFcShort( 0x5a ),	/* 90 */
#ifndef _ALPHA_
/* 3550 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3552 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3554 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3556 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3558 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3560 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3562 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3564 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3566 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3568 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3570 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3572 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3574 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerMaxSMP */

/* 3576 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3578 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3582 */	NdrFcShort( 0x5b ),	/* 91 */
#ifndef _ALPHA_
/* 3584 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3586 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3588 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3590 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3592 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3594 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3596 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3598 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3600 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3602 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3604 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3606 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3608 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerFP */

/* 3610 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3612 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3616 */	NdrFcShort( 0x5c ),	/* 92 */
#ifndef _ALPHA_
/* 3618 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3620 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3622 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3624 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3626 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3628 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3632 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3634 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3636 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3638 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3640 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3642 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerDP */

/* 3644 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3646 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3650 */	NdrFcShort( 0x5d ),	/* 93 */
#ifndef _ALPHA_
/* 3652 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3654 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3656 */	NdrFcShort( 0x18 ),	/* 24 */
/* 3658 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3660 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3662 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3664 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3666 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3668 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3670 */	0xc,		/* FC_DOUBLE */
			0x0,		/* 0 */

	/* Return value */

/* 3672 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3674 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3676 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPlayerName */

/* 3678 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3680 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3684 */	NdrFcShort( 0x5e ),	/* 94 */
#ifndef _ALPHA_
/* 3686 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3688 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3690 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3692 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x3,		/* 3 */

	/* Parameter playerIdx */

/* 3694 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3696 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3698 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3700 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3702 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3704 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 3706 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3708 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3710 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddPlayerHP */

/* 3712 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3714 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3718 */	NdrFcShort( 0x5f ),	/* 95 */
#ifndef _ALPHA_
/* 3720 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3722 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3724 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3726 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3728 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3730 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3732 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3734 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3736 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3738 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3740 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3742 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3744 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddPlayerSMP */

/* 3746 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3748 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3752 */	NdrFcShort( 0x60 ),	/* 96 */
#ifndef _ALPHA_
/* 3754 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3756 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3758 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3760 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3762 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3764 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3766 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3768 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3770 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3772 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3774 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3776 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3778 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerHP */

/* 3780 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3782 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3786 */	NdrFcShort( 0x61 ),	/* 97 */
#ifndef _ALPHA_
/* 3788 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3790 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3792 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3794 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3796 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3798 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3800 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3802 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3804 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3806 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3808 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3810 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3812 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerSMP */

/* 3814 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3816 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3820 */	NdrFcShort( 0x62 ),	/* 98 */
#ifndef _ALPHA_
/* 3822 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3824 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3826 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3828 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3830 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3832 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3834 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3836 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3838 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3840 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3842 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3844 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3846 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerFP */

/* 3848 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3850 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3854 */	NdrFcShort( 0x63 ),	/* 99 */
#ifndef _ALPHA_
/* 3856 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3858 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3860 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3862 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3864 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3866 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3870 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3872 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3874 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3876 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3878 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3880 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetPlayerDP */

/* 3882 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3884 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3888 */	NdrFcShort( 0x64 ),	/* 100 */
#ifndef _ALPHA_
/* 3890 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3892 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3894 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3896 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 3898 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3900 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter playerIdx */

/* 3904 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3906 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3908 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3910 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3912 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3914 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyHP */

/* 3916 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3918 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3922 */	NdrFcShort( 0x65 ),	/* 101 */
#ifndef _ALPHA_
/* 3924 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3926 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3928 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3930 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 3932 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3934 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3936 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3938 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3940 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3942 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3944 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3946 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3948 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyMaxHP */

/* 3950 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3952 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3956 */	NdrFcShort( 0x66 ),	/* 102 */
#ifndef _ALPHA_
/* 3958 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3960 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3962 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3964 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 3966 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 3968 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 3970 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 3972 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 3974 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 3976 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3978 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 3980 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 3982 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemySMP */

/* 3984 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3986 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3990 */	NdrFcShort( 0x67 ),	/* 103 */
#ifndef _ALPHA_
/* 3992 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 3994 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3996 */	NdrFcShort( 0x10 ),	/* 16 */
/* 3998 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 4000 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4002 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4004 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4006 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4008 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4010 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4012 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4014 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4016 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyMaxSMP */

/* 4018 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4020 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4024 */	NdrFcShort( 0x68 ),	/* 104 */
#ifndef _ALPHA_
/* 4026 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4028 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4030 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4032 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 4034 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4036 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4038 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4040 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4042 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4044 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4046 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4048 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4050 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyFP */

/* 4052 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4054 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4058 */	NdrFcShort( 0x69 ),	/* 105 */
#ifndef _ALPHA_
/* 4060 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4062 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4064 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4066 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 4068 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4070 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4072 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4074 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4076 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4078 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4080 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4082 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4084 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetEnemyDP */

/* 4086 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4088 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4092 */	NdrFcShort( 0x6a ),	/* 106 */
#ifndef _ALPHA_
/* 4094 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4096 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4098 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4100 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter eneIdx */

/* 4102 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4104 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4106 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4108 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4110 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4112 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4114 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4116 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4118 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddEnemyHP */

/* 4120 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4122 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4126 */	NdrFcShort( 0x6b ),	/* 107 */
#ifndef _ALPHA_
/* 4128 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4130 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4132 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4134 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 4136 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4138 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4142 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4144 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4148 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4150 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4152 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAddEnemySMP */

/* 4154 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4156 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4160 */	NdrFcShort( 0x6c ),	/* 108 */
#ifndef _ALPHA_
/* 4162 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4164 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4166 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4168 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 4170 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4172 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4174 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4176 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4178 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4180 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4182 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4184 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4186 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemyHP */

/* 4188 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4190 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4194 */	NdrFcShort( 0x6d ),	/* 109 */
#ifndef _ALPHA_
/* 4196 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4198 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4200 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4202 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 4204 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4206 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4208 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4210 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4212 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4214 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4216 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4218 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4220 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBSetEnemySMP */

/* 4222 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4224 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4228 */	NdrFcShort( 0x6e ),	/* 110 */
#ifndef _ALPHA_
/* 4230 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4232 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4234 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4236 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter amount */

/* 4238 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4240 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4242 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter eneIdx */

/* 4244 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4246 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4248 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4250 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4252 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4254 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawBackground */

/* 4256 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4258 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4262 */	NdrFcShort( 0x6f ),	/* 111 */
#ifndef _ALPHA_
/* 4264 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 4266 */	NdrFcShort( 0x28 ),	/* 40 */
/* 4268 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4270 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x7,		/* 7 */

	/* Parameter canvasID */

/* 4272 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4274 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4276 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter bkgFile */

/* 4278 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 4280 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4282 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter x */

/* 4284 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4286 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4288 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 4290 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4292 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter width */

/* 4296 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4298 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4300 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter height */

/* 4302 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4304 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 4306 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4308 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4310 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 4312 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCreateAnimation */

/* 4314 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4316 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4320 */	NdrFcShort( 0x70 ),	/* 112 */
#ifndef _ALPHA_
/* 4322 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4324 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4326 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4328 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter file */

/* 4330 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 4332 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4334 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 4336 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4338 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4340 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4342 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4344 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4346 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDestroyAnimation */

/* 4348 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4350 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4354 */	NdrFcShort( 0x71 ),	/* 113 */
#ifndef _ALPHA_
/* 4356 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4358 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4360 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4362 */	0x4,		/* Oi2 Flags:  has return, */
			0x2,		/* 2 */

	/* Parameter idx */

/* 4364 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4366 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4368 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4370 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4372 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4374 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawAnimation */

/* 4376 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4378 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4382 */	NdrFcShort( 0x72 ),	/* 114 */
#ifndef _ALPHA_
/* 4384 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 4386 */	NdrFcShort( 0x30 ),	/* 48 */
/* 4388 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4390 */	0x4,		/* Oi2 Flags:  has return, */
			0x7,		/* 7 */

	/* Parameter canvasID */

/* 4392 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4394 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4396 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter idx */

/* 4398 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4400 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4402 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 4404 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4406 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 4410 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4412 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4414 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceDraw */

/* 4416 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4418 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4420 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceTransp */

/* 4422 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4424 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 4426 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4428 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4430 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 4432 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasDrawAnimationFrame */

/* 4434 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4436 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4440 */	NdrFcShort( 0x73 ),	/* 115 */
#ifndef _ALPHA_
/* 4442 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 4444 */	NdrFcShort( 0x30 ),	/* 48 */
/* 4446 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4448 */	0x4,		/* Oi2 Flags:  has return, */
			0x7,		/* 7 */

	/* Parameter canvasID */

/* 4450 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4452 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4454 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter idx */

/* 4456 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4458 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4460 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter frame */

/* 4462 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4464 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4466 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 4468 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4470 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 4474 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4476 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4478 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter forceTranspFill */

/* 4480 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4482 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 4484 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4486 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4488 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 4490 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationCurrentFrame */

/* 4492 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4494 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4498 */	NdrFcShort( 0x74 ),	/* 116 */
#ifndef _ALPHA_
/* 4500 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4502 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4504 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4506 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter idx */

/* 4508 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4510 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4512 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4514 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4516 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4518 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4520 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4522 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationMaxFrames */

/* 4526 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4528 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4532 */	NdrFcShort( 0x75 ),	/* 117 */
#ifndef _ALPHA_
/* 4534 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4536 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4538 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4540 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter idx */

/* 4542 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4544 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4548 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4550 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4552 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4554 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4556 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4558 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationSizeX */

/* 4560 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4562 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4566 */	NdrFcShort( 0x76 ),	/* 118 */
#ifndef _ALPHA_
/* 4568 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4570 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4572 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4574 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter idx */

/* 4576 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4578 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4580 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4582 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4584 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4588 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4590 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationSizeY */

/* 4594 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4596 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4600 */	NdrFcShort( 0x77 ),	/* 119 */
#ifndef _ALPHA_
/* 4602 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4604 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4606 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4608 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter idx */

/* 4610 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4612 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4614 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4616 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4618 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4620 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4622 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4624 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBAnimationFrameImage */

/* 4628 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4630 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4634 */	NdrFcShort( 0x78 ),	/* 120 */
#ifndef _ALPHA_
/* 4636 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4638 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4640 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4642 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x4,		/* 4 */

	/* Parameter idx */

/* 4644 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4646 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4648 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter frame */

/* 4650 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4652 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4654 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4656 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4658 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4660 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 4662 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4664 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetPartySize */

/* 4668 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4670 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4674 */	NdrFcShort( 0x79 ),	/* 121 */
#ifndef _ALPHA_
/* 4676 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4678 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4680 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4682 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter partyIdx */

/* 4684 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4686 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4688 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4690 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4692 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4694 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4696 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4698 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4700 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterHP */

/* 4702 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4704 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4708 */	NdrFcShort( 0x7a ),	/* 122 */
#ifndef _ALPHA_
/* 4710 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4712 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4714 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4716 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4718 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4720 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4722 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4724 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4726 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4728 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4730 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4732 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4734 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4736 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4738 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4740 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterMaxHP */

/* 4742 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4744 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4748 */	NdrFcShort( 0x7b ),	/* 123 */
#ifndef _ALPHA_
/* 4750 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4752 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4754 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4756 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4758 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4760 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4762 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4764 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4766 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4768 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4770 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4772 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4774 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4776 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4778 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4780 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterSMP */

/* 4782 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4784 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4788 */	NdrFcShort( 0x7c ),	/* 124 */
#ifndef _ALPHA_
/* 4790 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4792 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4794 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4796 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4798 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4800 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4802 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4804 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4806 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4808 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4810 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4812 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4814 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4816 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4818 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4820 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterMaxSMP */

/* 4822 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4824 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4828 */	NdrFcShort( 0x7d ),	/* 125 */
#ifndef _ALPHA_
/* 4830 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4832 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4834 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4836 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4838 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4840 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4842 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4844 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4846 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4848 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4850 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4852 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4854 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4856 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4858 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4860 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterFP */

/* 4862 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4864 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4868 */	NdrFcShort( 0x7e ),	/* 126 */
#ifndef _ALPHA_
/* 4870 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4872 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4874 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4876 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4878 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4880 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4882 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4884 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4886 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4888 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4890 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4892 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4894 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4896 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4898 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4900 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterDP */

/* 4902 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4904 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4908 */	NdrFcShort( 0x7f ),	/* 127 */
#ifndef _ALPHA_
/* 4910 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4912 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4914 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4916 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4918 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4920 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4922 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4924 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4926 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4928 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4930 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4932 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4934 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4936 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4938 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4940 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterName */

/* 4942 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4944 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4948 */	NdrFcShort( 0x80 ),	/* 128 */
#ifndef _ALPHA_
/* 4950 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 4952 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4954 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4956 */	0x5,		/* Oi2 Flags:  srv must size, has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 4958 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4960 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 4962 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 4964 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 4966 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 4968 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 4970 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 4972 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 4974 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 4976 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 4978 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 4980 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterAnimation */

/* 4982 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4984 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4988 */	NdrFcShort( 0x81 ),	/* 129 */
#ifndef _ALPHA_
/* 4990 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 4992 */	NdrFcShort( 0x10 ),	/* 16 */
/* 4994 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4996 */	0x7,		/* Oi2 Flags:  srv must size, clt must size, has return, */
			0x5,		/* 5 */

	/* Parameter partyIdx */

/* 4998 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5000 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5002 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5004 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5006 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5008 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter animationName */

/* 5010 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5012 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5014 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 5016 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5018 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5020 */	NdrFcShort( 0x2c ),	/* Type Offset=44 */

	/* Return value */

/* 5022 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5024 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5026 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBGetFighterChargePercent */

/* 5028 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5030 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5034 */	NdrFcShort( 0x82 ),	/* 130 */
#ifndef _ALPHA_
/* 5036 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5038 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5040 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5042 */	0x4,		/* Oi2 Flags:  has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 5044 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5046 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5048 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5050 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5052 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5054 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5056 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5058 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5060 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5062 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5064 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5066 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightTick */

/* 5068 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5070 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5074 */	NdrFcShort( 0x83 ),	/* 131 */
#ifndef _ALPHA_
/* 5076 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5080 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5082 */	0x4,		/* Oi2 Flags:  has return, */
			0x1,		/* 1 */

	/* Return value */

/* 5084 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5086 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5088 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDrawTextAbsolute */

/* 5090 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5092 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5096 */	NdrFcShort( 0x84 ),	/* 132 */
#ifndef _ALPHA_
/* 5098 */	NdrFcShort( 0x34 ),	/* x86, MIPS, PPC Stack size/offset = 52 */
#else
			NdrFcShort( 0x68 ),	/* Alpha Stack size/offset = 104 */
#endif
/* 5100 */	NdrFcShort( 0x40 ),	/* 64 */
/* 5102 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5104 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0xc,		/* 12 */

	/* Parameter text */

/* 5106 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5108 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5110 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter font */

/* 5112 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5114 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5116 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter size */

/* 5118 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5120 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5122 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter x */

/* 5124 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5126 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5128 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter y */

/* 5130 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5132 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5134 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter crColor */

/* 5136 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5138 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 5140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isBold */

/* 5142 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5144 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 5146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isItalics */

/* 5148 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5150 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 5152 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isUnderline */

/* 5154 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5156 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 5158 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter isCentred */

/* 5160 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5162 */	NdrFcShort( 0x28 ),	/* x86, MIPS, PPC Stack size/offset = 40 */
#else
			NdrFcShort( 0x50 ),	/* Alpha Stack size/offset = 80 */
#endif
/* 5164 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5166 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5168 */	NdrFcShort( 0x2c ),	/* x86, MIPS, PPC Stack size/offset = 44 */
#else
			NdrFcShort( 0x58 ),	/* Alpha Stack size/offset = 88 */
#endif
/* 5170 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5172 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5174 */	NdrFcShort( 0x30 ),	/* x86, MIPS, PPC Stack size/offset = 48 */
#else
			NdrFcShort( 0x60 ),	/* Alpha Stack size/offset = 96 */
#endif
/* 5176 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBReleaseFighterCharge */

/* 5178 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5180 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5184 */	NdrFcShort( 0x85 ),	/* 133 */
#ifndef _ALPHA_
/* 5186 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5188 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5190 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5192 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter partyIdx */

/* 5194 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5196 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5198 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fighterIdx */

/* 5200 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5202 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5206 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5208 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5210 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightDoAttack */

/* 5212 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5214 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5218 */	NdrFcShort( 0x86 ),	/* 134 */
#ifndef _ALPHA_
/* 5220 */	NdrFcShort( 0x24 ),	/* x86, MIPS, PPC Stack size/offset = 36 */
#else
			NdrFcShort( 0x48 ),	/* Alpha Stack size/offset = 72 */
#endif
/* 5222 */	NdrFcShort( 0x30 ),	/* 48 */
/* 5224 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5226 */	0x4,		/* Oi2 Flags:  has return, */
			0x8,		/* 8 */

	/* Parameter sourcePartyIdx */

/* 5228 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5230 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5232 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 5234 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5236 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 5240 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5242 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5244 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 5246 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5248 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5250 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter amount */

/* 5252 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5254 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5256 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter toSMP */

/* 5258 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5260 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 5262 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5264 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5266 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 5268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5270 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5272 */	NdrFcShort( 0x20 ),	/* x86, MIPS, PPC Stack size/offset = 32 */
#else
			NdrFcShort( 0x40 ),	/* Alpha Stack size/offset = 64 */
#endif
/* 5274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightUseItem */

/* 5276 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5278 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5282 */	NdrFcShort( 0x87 ),	/* 135 */
#ifndef _ALPHA_
/* 5284 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 5286 */	NdrFcShort( 0x20 ),	/* 32 */
/* 5288 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5290 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x6,		/* 6 */

	/* Parameter sourcePartyIdx */

/* 5292 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5294 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5296 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 5298 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5300 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5302 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 5304 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5306 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5308 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 5310 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5312 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5314 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter itemFile */

/* 5316 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5318 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5320 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 5322 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5324 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 5326 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFightUseSpecialMove */

/* 5328 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5330 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5334 */	NdrFcShort( 0x88 ),	/* 136 */
#ifndef _ALPHA_
/* 5336 */	NdrFcShort( 0x1c ),	/* x86, MIPS, PPC Stack size/offset = 28 */
#else
			NdrFcShort( 0x38 ),	/* Alpha Stack size/offset = 56 */
#endif
/* 5338 */	NdrFcShort( 0x20 ),	/* 32 */
/* 5340 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5342 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x6,		/* 6 */

	/* Parameter sourcePartyIdx */

/* 5344 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5346 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5348 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter sourceFightIdx */

/* 5350 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5352 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5354 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetPartyIdx */

/* 5356 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5358 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5360 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter targetFightIdx */

/* 5362 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5364 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5366 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter moveFile */

/* 5368 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5370 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5372 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 5374 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5376 */	NdrFcShort( 0x18 ),	/* x86, MIPS, PPC Stack size/offset = 24 */
#else
			NdrFcShort( 0x30 ),	/* Alpha Stack size/offset = 48 */
#endif
/* 5378 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBDoEvents */

/* 5380 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5382 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5386 */	NdrFcShort( 0x89 ),	/* 137 */
#ifndef _ALPHA_
/* 5388 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5390 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5392 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5394 */	0x4,		/* Oi2 Flags:  has return, */
			0x1,		/* 1 */

	/* Return value */

/* 5396 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5398 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5400 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFighterAddStatusEffect */

/* 5402 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5404 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5408 */	NdrFcShort( 0x8a ),	/* 138 */
#ifndef _ALPHA_
/* 5410 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5412 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5414 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5416 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 5418 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5420 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5422 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fightIdx */

/* 5424 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5426 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5428 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter statusFile */

/* 5430 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5432 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5434 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 5436 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5438 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5440 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFighterRemoveStatusEffect */

/* 5442 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5444 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5448 */	NdrFcShort( 0x8b ),	/* 139 */
#ifndef _ALPHA_
/* 5450 */	NdrFcShort( 0x14 ),	/* x86, MIPS, PPC Stack size/offset = 20 */
#else
			NdrFcShort( 0x28 ),	/* Alpha Stack size/offset = 40 */
#endif
/* 5452 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5454 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5456 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x4,		/* 4 */

	/* Parameter partyIdx */

/* 5458 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5460 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5462 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter fightIdx */

/* 5464 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5466 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5468 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter statusFile */

/* 5470 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5472 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5474 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Return value */

/* 5476 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5478 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5480 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCheckMusic */

/* 5482 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5484 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5488 */	NdrFcShort( 0x8c ),	/* 140 */
#ifndef _ALPHA_
/* 5490 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5492 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5494 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5496 */	0x4,		/* Oi2 Flags:  has return, */
			0x1,		/* 1 */

	/* Return value */

/* 5498 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5500 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5502 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBReleaseScreenDC */

/* 5504 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5506 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5510 */	NdrFcShort( 0x8d ),	/* 141 */
#ifndef _ALPHA_
/* 5512 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5514 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5516 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5518 */	0x4,		/* Oi2 Flags:  has return, */
			0x1,		/* 1 */

	/* Return value */

/* 5520 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5522 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasOpenHdc */

/* 5526 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5528 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5532 */	NdrFcShort( 0x8e ),	/* 142 */
#ifndef _ALPHA_
/* 5534 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5536 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5538 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5540 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter cnv */

/* 5542 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5544 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRet */

/* 5548 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5550 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5552 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5554 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5556 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5558 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBCanvasCloseHdc */

/* 5560 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5562 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5566 */	NdrFcShort( 0x8f ),	/* 143 */
#ifndef _ALPHA_
/* 5568 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5570 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5572 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5574 */	0x4,		/* Oi2 Flags:  has return, */
			0x3,		/* 3 */

	/* Parameter cnv */

/* 5576 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5578 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5580 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter hdc */

/* 5582 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
#ifndef _ALPHA_
/* 5584 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5588 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5590 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CBFileExists */

/* 5594 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5596 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5600 */	NdrFcShort( 0x90 ),	/* 144 */
#ifndef _ALPHA_
/* 5602 */	NdrFcShort( 0x10 ),	/* x86, MIPS, PPC Stack size/offset = 16 */
#else
			NdrFcShort( 0x20 ),	/* Alpha Stack size/offset = 32 */
#endif
/* 5604 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5606 */	NdrFcShort( 0xe ),	/* 14 */
/* 5608 */	0x6,		/* Oi2 Flags:  clt must size, has return, */
			0x3,		/* 3 */

	/* Parameter strFile */

/* 5610 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
#ifndef _ALPHA_
/* 5612 */	NdrFcShort( 0x4 ),	/* x86, MIPS, PPC Stack size/offset = 4 */
#else
			NdrFcShort( 0x8 ),	/* Alpha Stack size/offset = 8 */
#endif
/* 5614 */	NdrFcShort( 0x1a ),	/* Type Offset=26 */

	/* Parameter pRet */

/* 5616 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
#ifndef _ALPHA_
/* 5618 */	NdrFcShort( 0x8 ),	/* x86, MIPS, PPC Stack size/offset = 8 */
#else
			NdrFcShort( 0x10 ),	/* Alpha Stack size/offset = 16 */
#endif
/* 5620 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 5622 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
#ifndef _ALPHA_
/* 5624 */	NdrFcShort( 0xc ),	/* x86, MIPS, PPC Stack size/offset = 12 */
#else
			NdrFcShort( 0x18 ),	/* Alpha Stack size/offset = 24 */
#endif
/* 5626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const MIDL_TYPE_FORMAT_STRING __MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */
/*  2 */	
			0x12, 0x0,	/* FC_UP */
/*  4 */	NdrFcShort( 0xc ),	/* Offset= 12 (16) */
/*  6 */	
			0x1b,		/* FC_CARRAY */
			0x1,		/* 1 */
/*  8 */	NdrFcShort( 0x2 ),	/* 2 */
/* 10 */	0x9,		/* Corr desc: FC_ULONG */
			0x0,		/*  */
/* 12 */	NdrFcShort( 0xfffc ),	/* -4 */
/* 14 */	0x6,		/* FC_SHORT */
			0x5b,		/* FC_END */
/* 16 */	
			0x17,		/* FC_CSTRUCT */
			0x3,		/* 3 */
/* 18 */	NdrFcShort( 0x8 ),	/* 8 */
/* 20 */	NdrFcShort( 0xfffffff2 ),	/* Offset= -14 (6) */
/* 22 */	0x8,		/* FC_LONG */
			0x8,		/* FC_LONG */
/* 24 */	0x5c,		/* FC_PAD */
			0x5b,		/* FC_END */
/* 26 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 28 */	NdrFcShort( 0x0 ),	/* 0 */
/* 30 */	NdrFcShort( 0x4 ),	/* 4 */
/* 32 */	NdrFcShort( 0x0 ),	/* 0 */
/* 34 */	NdrFcShort( 0xffffffe0 ),	/* Offset= -32 (2) */
/* 36 */	
			0x11, 0x4,	/* FC_RP [alloced_on_stack] */
/* 38 */	NdrFcShort( 0x6 ),	/* Offset= 6 (44) */
/* 40 */	
			0x13, 0x0,	/* FC_OP */
/* 42 */	NdrFcShort( 0xffffffe6 ),	/* Offset= -26 (16) */
/* 44 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 46 */	NdrFcShort( 0x0 ),	/* 0 */
/* 48 */	NdrFcShort( 0x4 ),	/* 4 */
/* 50 */	NdrFcShort( 0x0 ),	/* 0 */
/* 52 */	NdrFcShort( 0xfffffff4 ),	/* Offset= -12 (40) */
/* 54 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 56 */	0xc,		/* FC_DOUBLE */
			0x5c,		/* FC_PAD */
/* 58 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 60 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */
/* 62 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 64 */	0x6,		/* FC_SHORT */
			0x5c,		/* FC_PAD */

			0x0
        }
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
