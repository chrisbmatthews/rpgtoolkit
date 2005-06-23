/* this ALWAYS GENERATED file contains the definitions for the interfaces */


/* File created by MIDL compiler version 5.01.0164 */
/* at Wed Jun 22 22:34:49 2005
 */
/* Compiler settings for C:\Program Files\GNU\WinCvs 2.0\tk3\vc\trans3\trans3.idl:
    Oicf (OptLev=i2), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __trans3_h__
#define __trans3_h__

#ifdef __cplusplus
extern "C"{
#endif 

/* Forward Declarations */ 

#ifndef __ICallbacks_FWD_DEFINED__
#define __ICallbacks_FWD_DEFINED__
typedef interface ICallbacks ICallbacks;
#endif 	/* __ICallbacks_FWD_DEFINED__ */


#ifndef __Callbacks_FWD_DEFINED__
#define __Callbacks_FWD_DEFINED__

#ifdef __cplusplus
typedef class Callbacks Callbacks;
#else
typedef struct Callbacks Callbacks;
#endif /* __cplusplus */

#endif 	/* __Callbacks_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

void __RPC_FAR * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void __RPC_FAR * ); 

#ifndef __ICallbacks_INTERFACE_DEFINED__
#define __ICallbacks_INTERFACE_DEFINED__

/* interface ICallbacks */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_ICallbacks;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("C146901F-ABFA-4D24-A4F2-D83C961D37B9")
    ICallbacks : public IDispatch
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE test( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ICallbacksVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            ICallbacks __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            ICallbacks __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            ICallbacks __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            ICallbacks __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            ICallbacks __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            ICallbacks __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            ICallbacks __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *test )( 
            ICallbacks __RPC_FAR * This);
        
        END_INTERFACE
    } ICallbacksVtbl;

    interface ICallbacks
    {
        CONST_VTBL struct ICallbacksVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ICallbacks_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define ICallbacks_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define ICallbacks_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define ICallbacks_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define ICallbacks_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define ICallbacks_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define ICallbacks_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define ICallbacks_test(This)	\
    (This)->lpVtbl -> test(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ICallbacks_test_Proxy( 
    ICallbacks __RPC_FAR * This);


void __RPC_STUB ICallbacks_test_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __ICallbacks_INTERFACE_DEFINED__ */



#ifndef __TRANS3Lib_LIBRARY_DEFINED__
#define __TRANS3Lib_LIBRARY_DEFINED__

/* library TRANS3Lib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_TRANS3Lib;

EXTERN_C const CLSID CLSID_Callbacks;

#ifdef __cplusplus

class DECLSPEC_UUID("6FD78CD3-F15B-4092-B549-EB07DEC99432")
Callbacks;
#endif
#endif /* __TRANS3Lib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif
