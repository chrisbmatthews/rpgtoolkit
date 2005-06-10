// plugins/Callbacks.h : Declaration of the CCallbacks

#ifndef __CALLBACKS_H_
#define __CALLBACKS_H_

#include "../resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CCallbacks
class ATL_NO_VTABLE CCallbacks : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CCallbacks, &CLSID_Callbacks>,
	public IDispatchImpl<ICallbacks, &IID_ICallbacks, &LIBID_TRANS3Lib>
{
public:

	DECLARE_REGISTRY_RESOURCEID(IDR_CALLBACKS)
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	BEGIN_COM_MAP(CCallbacks)
		COM_INTERFACE_ENTRY(ICallbacks)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

// ICallbacks
public:
	STDMETHOD(test)(void);
};

#endif //__CALLBACKS_H_
