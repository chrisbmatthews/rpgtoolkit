//------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Exportable interface to tkDirectX
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Protect the header
//------------------------------------------------------------------------
#if !defined(_TK_DIRECTX_H_)
#define _TK_DIRECTX_H_
#if defined(_MSC_VER)
#	pragma once
#endif

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN			// Flag lean version of Windows
#include <windows.h>				// The Windows API
#include "platform.h"				// DirectX platform

//------------------------------------------------------------------------
// Definitions
//------------------------------------------------------------------------
#if !defined(DOUBLE)
typedef double DOUBLE;
#endif
#if !defined(CNV_HANDLE)
typedef INT CNV_HANDLE;
#endif

//------------------------------------------------------------------------
// Prototypes
//------------------------------------------------------------------------

BOOL APIENTRY DXInitGfxMode(
	CONST INT hostHwnd,
	CONST INT nScreenX,
	CONST INT nScreenY,
	CONST BOOL nUseDirectX,
	CONST INT nColorDepth,
	CONST BOOL nFullScreen
);

BOOL APIENTRY DXKillGfxMode(
	VOID
);

BOOL APIENTRY DXDrawPixel(
	CONST INT x,
	CONST INT y,
	CONST INT clr
);

BOOL APIENTRY DXRefresh(
	CONST CNV_HANDLE cnvHandle = NULL
);

BOOL APIENTRY DXLockScreen(
	VOID
);

BOOL APIENTRY DXUnlockScreen(
	VOID
);

BOOL APIENTRY DXDrawCanvas(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT lRasterOp = SRCCOPY
);

BOOL APIENTRY DXDrawCanvasTransparent(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT crTransparentColor
);

BOOL APIENTRY DXDrawCanvasTranslucent(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
);

BOOL APIENTRY DXClearScreen(
	CONST INT crColor
);

BOOL APIENTRY DXDrawText(
	CONST INT x,
	CONST INT y,
	CONST LPSTR strText,
	CONST LPSTR strTypeFace,
	CONST INT size,
	CONST INT clr,
	CONST BOOL bold = FALSE,
	CONST BOOL italics = FALSE,
	CONST BOOL underline = FALSE,
	CONST BOOL centred = FALSE,
	CONST BOOL outlined = FALSE
);

BOOL APIENTRY DXDrawCanvasPartial(
	CONST CNV_HANDLE cnv,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST INT lRasterOp = SRCCOPY
);

BOOL APIENTRY DXDrawCanvasTransparentPartial(
	CONST CNV_HANDLE cnv,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST INT crTransparentColor
);

BOOL APIENTRY DXCopyScreenToCanvas(
	CONST CNV_HANDLE cnv
);

BOOL APIENTRY DXDrawCanvasTranslucentPartial(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
);

//------------------------------------------------------------------------
// End of the header
//------------------------------------------------------------------------
#endif
