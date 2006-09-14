/* this ALWAYS GENERATED file contains the definitions for the interfaces */


/* File created by MIDL compiler version 5.01.0164 */
/* at Wed Sep 13 22:18:18 2006
 */
/* Compiler settings for C:\cvs\vc\trans3\trans3.idl:
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
/* [unique][helpstring][dual][uuid][oleautomation][object] */ 


EXTERN_C const IID IID_ICallbacks;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("C146901F-ABFA-4D24-A4F2-D83C961D37B9")
    ICallbacks : public IDispatch
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE CBRpgCode( 
            /* [string] */ BSTR rpgcodeCommand) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetString( 
            /* [string] */ BSTR varname,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetNumerical( 
            /* [string] */ BSTR varname,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetString( 
            /* [string] */ BSTR varname,
            /* [string] */ BSTR newValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetNumerical( 
            /* [string] */ BSTR varname,
            double newValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScreenDC( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScratch1DC( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScratch2DC( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetMwinDC( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBPopupMwin( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBHideMwin( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadEnemy( 
            /* [string] */ BSTR file,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyNum( 
            int infoCode,
            int eneSlot,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyString( 
            int infoCode,
            int eneSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyNum( 
            int infoCode,
            int newValue,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyString( 
            int infoCode,
            /* [string] */ BSTR newValue,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerNum( 
            int infoCode,
            int arrayPos,
            int newVal,
            int playerSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerString( 
            int infoCode,
            int arrayPos,
            /* [string] */ BSTR newVal,
            int playerSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetGeneralString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetGeneralNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetGeneralString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string] */ BSTR newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetGeneralNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            int newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetCommandName( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBrackets( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCountBracketElements( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBracketElement( 
            /* [string] */ BSTR rpgcodeCommand,
            int elemNum,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetStringElementValue( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetNumElementValue( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetElementType( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDebugMessage( 
            /* [string] */ BSTR message) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPathString( 
            int infoCode,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadSpecialMove( 
            /* [string] */ BSTR file) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveString( 
            int infoCode,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveNum( 
            int infoCode,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadItem( 
            /* [string] */ BSTR file,
            int itmSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetItemString( 
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetItemNum( 
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBoardNum( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBoardString( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetBoardNum( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            int nValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetBoardString( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string] */ BSTR newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetHwnd( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBRefreshScreen( 
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCreateCanvas( 
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDestroyCanvas( 
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvas( 
            int canvasID,
            int x,
            int y,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasPartial( 
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTransparent( 
            int canvasID,
            int x,
            int y,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTransparentPartial( 
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTranslucent( 
            int canvasID,
            int x,
            int y,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLoadImage( 
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLoadSizedImage( 
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasFill( 
            int canvasID,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasResize( 
            int canvasID,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBlt( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltPartial( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTransparent( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTransparentPartial( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTranslucent( 
            int cnvSrc,
            int cnvDest,
            int destX,
            int destY,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasGetScreen( 
            int cnvDest,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadString( 
            int id,
            /* [string] */ BSTR defaultString,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawText( 
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
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasPopup( 
            int canvasID,
            int x,
            int y,
            int stepSize,
            int popupType,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasWidth( 
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasHeight( 
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawLine( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawRect( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasFillRect( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawHand( 
            int canvasID,
            int pointx,
            int pointy,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawHand( 
            int pointx,
            int pointy,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCheckKey( 
            /* [string] */ BSTR keyPressed,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBPlaySound( 
            /* [string] */ BSTR soundFile,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBMessageWindow( 
            /* [string] */ BSTR text,
            int textColor,
            int bgColor,
            /* [string] */ BSTR bgPic,
            int mbtype,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFileDialog( 
            /* [string] */ BSTR initialPath,
            /* [string] */ BSTR fileFilter,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDetermineSpecialMoves( 
            /* [string] */ BSTR playerHandle,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveListEntry( 
            int idx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBRunProgram( 
            /* [string] */ BSTR prgFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetTarget( 
            int targetIdx,
            int ttype) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetSource( 
            int sourceIdx,
            int sType) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerHP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerMaxHP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerSMP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerMaxSMP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerFP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerDP( 
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerName( 
            int playerIdx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddPlayerHP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddPlayerSMP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerHP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerSMP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerFP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerDP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyHP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyMaxHP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemySMP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyMaxSMP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyFP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyDP( 
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddEnemyHP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddEnemySMP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyHP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemySMP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawBackground( 
            int canvasID,
            /* [string] */ BSTR bkgFile,
            int x,
            int y,
            int width,
            int height) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCreateAnimation( 
            /* [string] */ BSTR file,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDestroyAnimation( 
            int idx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawAnimation( 
            int canvasID,
            int idx,
            int x,
            int y,
            int forceDraw,
            int forceTransp) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawAnimationFrame( 
            int canvasID,
            int idx,
            int frame,
            int x,
            int y,
            int forceTranspFill) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationCurrentFrame( 
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationMaxFrames( 
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationSizeX( 
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationSizeY( 
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationFrameImage( 
            int idx,
            int frame,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPartySize( 
            int partyIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterHP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterMaxHP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterSMP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterMaxSMP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterFP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterDP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterName( 
            int partyIdx,
            int fighterIdx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterAnimation( 
            int partyIdx,
            int fighterIdx,
            /* [string] */ BSTR animationName,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterChargePercent( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightTick( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawTextAbsolute( 
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
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBReleaseFighterCharge( 
            int partyIdx,
            int fighterIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightDoAttack( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            int amount,
            int toSMP,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightUseItem( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR itemFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightUseSpecialMove( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR moveFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDoEvents( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFighterAddStatusEffect( 
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFighterRemoveStatusEffect( 
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCheckMusic( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBReleaseScreenDC( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasOpenHdc( 
            int cnv,
            /* [retval][out] */ int __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasCloseHdc( 
            int cnv,
            int hdc) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFileExists( 
            /* [string] */ BSTR strFile,
            /* [retval][out] */ short __RPC_FAR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLock( 
            int cnv) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasUnlock( 
            int cnv) = 0;
        
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
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBRpgCode )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetString )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR varname,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetNumerical )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR varname,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetString )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR varname,
            /* [string] */ BSTR newValue);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetNumerical )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR varname,
            double newValue);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetScreenDC )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetScratch1DC )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetScratch2DC )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetMwinDC )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBPopupMwin )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBHideMwin )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBLoadEnemy )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR file,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int eneSlot,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int eneSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetEnemyNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int newValue,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetEnemyString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            /* [string] */ BSTR newValue,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int newVal,
            int playerSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            /* [string] */ BSTR newVal,
            int playerSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetGeneralString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetGeneralNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetGeneralString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string] */ BSTR newVal);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetGeneralNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            int newVal);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetCommandName )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetBrackets )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCountBracketElements )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetBracketElement )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            int elemNum,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetStringElementValue )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetNumElementValue )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetElementType )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDebugMessage )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR message);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPathString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBLoadSpecialMove )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR file);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetSpecialMoveString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetSpecialMoveNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBLoadItem )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR file,
            int itmSlot);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetItemString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetItemNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetBoardNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetBoardString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetBoardNum )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            int nValue);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetBoardString )( 
            ICallbacks __RPC_FAR * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string] */ BSTR newVal);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetHwnd )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBRefreshScreen )( 
            ICallbacks __RPC_FAR * This,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCreateCanvas )( 
            ICallbacks __RPC_FAR * This,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDestroyCanvas )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawCanvas )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x,
            int y,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawCanvasPartial )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawCanvasTransparent )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x,
            int y,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawCanvasTransparentPartial )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawCanvasTranslucent )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x,
            int y,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasLoadImage )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasLoadSizedImage )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasFill )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasResize )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvas2CanvasBlt )( 
            ICallbacks __RPC_FAR * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvas2CanvasBltPartial )( 
            ICallbacks __RPC_FAR * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvas2CanvasBltTransparent )( 
            ICallbacks __RPC_FAR * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvas2CanvasBltTransparentPartial )( 
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
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvas2CanvasBltTranslucent )( 
            ICallbacks __RPC_FAR * This,
            int cnvSrc,
            int cnvDest,
            int destX,
            int destY,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasGetScreen )( 
            ICallbacks __RPC_FAR * This,
            int cnvDest,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBLoadString )( 
            ICallbacks __RPC_FAR * This,
            int id,
            /* [string] */ BSTR defaultString,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawText )( 
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
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasPopup )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x,
            int y,
            int stepSize,
            int popupType,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasWidth )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasHeight )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawLine )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawRect )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasFillRect )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawHand )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int pointx,
            int pointy,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawHand )( 
            ICallbacks __RPC_FAR * This,
            int pointx,
            int pointy,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCheckKey )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR keyPressed,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBPlaySound )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR soundFile,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBMessageWindow )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR text,
            int textColor,
            int bgColor,
            /* [string] */ BSTR bgPic,
            int mbtype,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFileDialog )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR initialPath,
            /* [string] */ BSTR fileFilter,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDetermineSpecialMoves )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR playerHandle,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetSpecialMoveListEntry )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBRunProgram )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR prgFile);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetTarget )( 
            ICallbacks __RPC_FAR * This,
            int targetIdx,
            int ttype);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetSource )( 
            ICallbacks __RPC_FAR * This,
            int sourceIdx,
            int sType);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerHP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerMaxHP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerSMP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerMaxSMP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerFP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerDP )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [retval][out] */ double __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPlayerName )( 
            ICallbacks __RPC_FAR * This,
            int playerIdx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAddPlayerHP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAddPlayerSMP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerHP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerSMP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerFP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetPlayerDP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyHP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyMaxHP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemySMP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyMaxSMP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyFP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetEnemyDP )( 
            ICallbacks __RPC_FAR * This,
            int eneIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAddEnemyHP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAddEnemySMP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetEnemyHP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBSetEnemySMP )( 
            ICallbacks __RPC_FAR * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawBackground )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            /* [string] */ BSTR bkgFile,
            int x,
            int y,
            int width,
            int height);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCreateAnimation )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR file,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDestroyAnimation )( 
            ICallbacks __RPC_FAR * This,
            int idx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawAnimation )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int idx,
            int x,
            int y,
            int forceDraw,
            int forceTransp);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasDrawAnimationFrame )( 
            ICallbacks __RPC_FAR * This,
            int canvasID,
            int idx,
            int frame,
            int x,
            int y,
            int forceTranspFill);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAnimationCurrentFrame )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAnimationMaxFrames )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAnimationSizeX )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAnimationSizeY )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBAnimationFrameImage )( 
            ICallbacks __RPC_FAR * This,
            int idx,
            int frame,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetPartySize )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterHP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterMaxHP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterSMP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterMaxSMP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterFP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterDP )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterName )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterAnimation )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [string] */ BSTR animationName,
            /* [string][retval][out] */ BSTR __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBGetFighterChargePercent )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFightTick )( 
            ICallbacks __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDrawTextAbsolute )( 
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
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBReleaseFighterCharge )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fighterIdx);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFightDoAttack )( 
            ICallbacks __RPC_FAR * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            int amount,
            int toSMP,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFightUseItem )( 
            ICallbacks __RPC_FAR * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR itemFile);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFightUseSpecialMove )( 
            ICallbacks __RPC_FAR * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR moveFile);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBDoEvents )( 
            ICallbacks __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFighterAddStatusEffect )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFighterRemoveStatusEffect )( 
            ICallbacks __RPC_FAR * This,
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCheckMusic )( 
            ICallbacks __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBReleaseScreenDC )( 
            ICallbacks __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasOpenHdc )( 
            ICallbacks __RPC_FAR * This,
            int cnv,
            /* [retval][out] */ int __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasCloseHdc )( 
            ICallbacks __RPC_FAR * This,
            int cnv,
            int hdc);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBFileExists )( 
            ICallbacks __RPC_FAR * This,
            /* [string] */ BSTR strFile,
            /* [retval][out] */ short __RPC_FAR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasLock )( 
            ICallbacks __RPC_FAR * This,
            int cnv);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *CBCanvasUnlock )( 
            ICallbacks __RPC_FAR * This,
            int cnv);
        
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


#define ICallbacks_CBRpgCode(This,rpgcodeCommand)	\
    (This)->lpVtbl -> CBRpgCode(This,rpgcodeCommand)

#define ICallbacks_CBGetString(This,varname,pRet)	\
    (This)->lpVtbl -> CBGetString(This,varname,pRet)

#define ICallbacks_CBGetNumerical(This,varname,pRet)	\
    (This)->lpVtbl -> CBGetNumerical(This,varname,pRet)

#define ICallbacks_CBSetString(This,varname,newValue)	\
    (This)->lpVtbl -> CBSetString(This,varname,newValue)

#define ICallbacks_CBSetNumerical(This,varname,newValue)	\
    (This)->lpVtbl -> CBSetNumerical(This,varname,newValue)

#define ICallbacks_CBGetScreenDC(This,pRet)	\
    (This)->lpVtbl -> CBGetScreenDC(This,pRet)

#define ICallbacks_CBGetScratch1DC(This,pRet)	\
    (This)->lpVtbl -> CBGetScratch1DC(This,pRet)

#define ICallbacks_CBGetScratch2DC(This,pRet)	\
    (This)->lpVtbl -> CBGetScratch2DC(This,pRet)

#define ICallbacks_CBGetMwinDC(This,pRet)	\
    (This)->lpVtbl -> CBGetMwinDC(This,pRet)

#define ICallbacks_CBPopupMwin(This,pRet)	\
    (This)->lpVtbl -> CBPopupMwin(This,pRet)

#define ICallbacks_CBHideMwin(This,pRet)	\
    (This)->lpVtbl -> CBHideMwin(This,pRet)

#define ICallbacks_CBLoadEnemy(This,file,eneSlot)	\
    (This)->lpVtbl -> CBLoadEnemy(This,file,eneSlot)

#define ICallbacks_CBGetEnemyNum(This,infoCode,eneSlot,pRet)	\
    (This)->lpVtbl -> CBGetEnemyNum(This,infoCode,eneSlot,pRet)

#define ICallbacks_CBGetEnemyString(This,infoCode,eneSlot,pRet)	\
    (This)->lpVtbl -> CBGetEnemyString(This,infoCode,eneSlot,pRet)

#define ICallbacks_CBSetEnemyNum(This,infoCode,newValue,eneSlot)	\
    (This)->lpVtbl -> CBSetEnemyNum(This,infoCode,newValue,eneSlot)

#define ICallbacks_CBSetEnemyString(This,infoCode,newValue,eneSlot)	\
    (This)->lpVtbl -> CBSetEnemyString(This,infoCode,newValue,eneSlot)

#define ICallbacks_CBGetPlayerNum(This,infoCode,arrayPos,playerSlot,pRet)	\
    (This)->lpVtbl -> CBGetPlayerNum(This,infoCode,arrayPos,playerSlot,pRet)

#define ICallbacks_CBGetPlayerString(This,infoCode,arrayPos,playerSlot,pRet)	\
    (This)->lpVtbl -> CBGetPlayerString(This,infoCode,arrayPos,playerSlot,pRet)

#define ICallbacks_CBSetPlayerNum(This,infoCode,arrayPos,newVal,playerSlot)	\
    (This)->lpVtbl -> CBSetPlayerNum(This,infoCode,arrayPos,newVal,playerSlot)

#define ICallbacks_CBSetPlayerString(This,infoCode,arrayPos,newVal,playerSlot)	\
    (This)->lpVtbl -> CBSetPlayerString(This,infoCode,arrayPos,newVal,playerSlot)

#define ICallbacks_CBGetGeneralString(This,infoCode,arrayPos,playerSlot,pRet)	\
    (This)->lpVtbl -> CBGetGeneralString(This,infoCode,arrayPos,playerSlot,pRet)

#define ICallbacks_CBGetGeneralNum(This,infoCode,arrayPos,playerSlot,pRet)	\
    (This)->lpVtbl -> CBGetGeneralNum(This,infoCode,arrayPos,playerSlot,pRet)

#define ICallbacks_CBSetGeneralString(This,infoCode,arrayPos,playerSlot,newVal)	\
    (This)->lpVtbl -> CBSetGeneralString(This,infoCode,arrayPos,playerSlot,newVal)

#define ICallbacks_CBSetGeneralNum(This,infoCode,arrayPos,playerSlot,newVal)	\
    (This)->lpVtbl -> CBSetGeneralNum(This,infoCode,arrayPos,playerSlot,newVal)

#define ICallbacks_CBGetCommandName(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBGetCommandName(This,rpgcodeCommand,pRet)

#define ICallbacks_CBGetBrackets(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBGetBrackets(This,rpgcodeCommand,pRet)

#define ICallbacks_CBCountBracketElements(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBCountBracketElements(This,rpgcodeCommand,pRet)

#define ICallbacks_CBGetBracketElement(This,rpgcodeCommand,elemNum,pRet)	\
    (This)->lpVtbl -> CBGetBracketElement(This,rpgcodeCommand,elemNum,pRet)

#define ICallbacks_CBGetStringElementValue(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBGetStringElementValue(This,rpgcodeCommand,pRet)

#define ICallbacks_CBGetNumElementValue(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBGetNumElementValue(This,rpgcodeCommand,pRet)

#define ICallbacks_CBGetElementType(This,rpgcodeCommand,pRet)	\
    (This)->lpVtbl -> CBGetElementType(This,rpgcodeCommand,pRet)

#define ICallbacks_CBDebugMessage(This,message)	\
    (This)->lpVtbl -> CBDebugMessage(This,message)

#define ICallbacks_CBGetPathString(This,infoCode,pRet)	\
    (This)->lpVtbl -> CBGetPathString(This,infoCode,pRet)

#define ICallbacks_CBLoadSpecialMove(This,file)	\
    (This)->lpVtbl -> CBLoadSpecialMove(This,file)

#define ICallbacks_CBGetSpecialMoveString(This,infoCode,pRet)	\
    (This)->lpVtbl -> CBGetSpecialMoveString(This,infoCode,pRet)

#define ICallbacks_CBGetSpecialMoveNum(This,infoCode,pRet)	\
    (This)->lpVtbl -> CBGetSpecialMoveNum(This,infoCode,pRet)

#define ICallbacks_CBLoadItem(This,file,itmSlot)	\
    (This)->lpVtbl -> CBLoadItem(This,file,itmSlot)

#define ICallbacks_CBGetItemString(This,infoCode,arrayPos,itmSlot,pRet)	\
    (This)->lpVtbl -> CBGetItemString(This,infoCode,arrayPos,itmSlot,pRet)

#define ICallbacks_CBGetItemNum(This,infoCode,arrayPos,itmSlot,pRet)	\
    (This)->lpVtbl -> CBGetItemNum(This,infoCode,arrayPos,itmSlot,pRet)

#define ICallbacks_CBGetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)	\
    (This)->lpVtbl -> CBGetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)

#define ICallbacks_CBGetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)	\
    (This)->lpVtbl -> CBGetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)

#define ICallbacks_CBSetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,nValue)	\
    (This)->lpVtbl -> CBSetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,nValue)

#define ICallbacks_CBSetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,newVal)	\
    (This)->lpVtbl -> CBSetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,newVal)

#define ICallbacks_CBGetHwnd(This,pRet)	\
    (This)->lpVtbl -> CBGetHwnd(This,pRet)

#define ICallbacks_CBRefreshScreen(This,pRet)	\
    (This)->lpVtbl -> CBRefreshScreen(This,pRet)

#define ICallbacks_CBCreateCanvas(This,width,height,pRet)	\
    (This)->lpVtbl -> CBCreateCanvas(This,width,height,pRet)

#define ICallbacks_CBDestroyCanvas(This,canvasID,pRet)	\
    (This)->lpVtbl -> CBDestroyCanvas(This,canvasID,pRet)

#define ICallbacks_CBDrawCanvas(This,canvasID,x,y,pRet)	\
    (This)->lpVtbl -> CBDrawCanvas(This,canvasID,x,y,pRet)

#define ICallbacks_CBDrawCanvasPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,pRet)	\
    (This)->lpVtbl -> CBDrawCanvasPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,pRet)

#define ICallbacks_CBDrawCanvasTransparent(This,canvasID,x,y,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBDrawCanvasTransparent(This,canvasID,x,y,crTransparentColor,pRet)

#define ICallbacks_CBDrawCanvasTransparentPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBDrawCanvasTransparentPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)

#define ICallbacks_CBDrawCanvasTranslucent(This,canvasID,x,y,dIntensity,crUnaffectedColor,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBDrawCanvasTranslucent(This,canvasID,x,y,dIntensity,crUnaffectedColor,crTransparentColor,pRet)

#define ICallbacks_CBCanvasLoadImage(This,canvasID,filename,pRet)	\
    (This)->lpVtbl -> CBCanvasLoadImage(This,canvasID,filename,pRet)

#define ICallbacks_CBCanvasLoadSizedImage(This,canvasID,filename,pRet)	\
    (This)->lpVtbl -> CBCanvasLoadSizedImage(This,canvasID,filename,pRet)

#define ICallbacks_CBCanvasFill(This,canvasID,crColor,pRet)	\
    (This)->lpVtbl -> CBCanvasFill(This,canvasID,crColor,pRet)

#define ICallbacks_CBCanvasResize(This,canvasID,width,height,pRet)	\
    (This)->lpVtbl -> CBCanvasResize(This,canvasID,width,height,pRet)

#define ICallbacks_CBCanvas2CanvasBlt(This,cnvSrc,cnvDest,xDest,yDest,pRet)	\
    (This)->lpVtbl -> CBCanvas2CanvasBlt(This,cnvSrc,cnvDest,xDest,yDest,pRet)

#define ICallbacks_CBCanvas2CanvasBltPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,pRet)	\
    (This)->lpVtbl -> CBCanvas2CanvasBltPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,pRet)

#define ICallbacks_CBCanvas2CanvasBltTransparent(This,cnvSrc,cnvDest,xDest,yDest,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBCanvas2CanvasBltTransparent(This,cnvSrc,cnvDest,xDest,yDest,crTransparentColor,pRet)

#define ICallbacks_CBCanvas2CanvasBltTransparentPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBCanvas2CanvasBltTransparentPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)

#define ICallbacks_CBCanvas2CanvasBltTranslucent(This,cnvSrc,cnvDest,destX,destY,dIntensity,crUnaffectedColor,crTransparentColor,pRet)	\
    (This)->lpVtbl -> CBCanvas2CanvasBltTranslucent(This,cnvSrc,cnvDest,destX,destY,dIntensity,crUnaffectedColor,crTransparentColor,pRet)

#define ICallbacks_CBCanvasGetScreen(This,cnvDest,pRet)	\
    (This)->lpVtbl -> CBCanvasGetScreen(This,cnvDest,pRet)

#define ICallbacks_CBLoadString(This,id,defaultString,pRet)	\
    (This)->lpVtbl -> CBLoadString(This,id,defaultString,pRet)

#define ICallbacks_CBCanvasDrawText(This,canvasID,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)	\
    (This)->lpVtbl -> CBCanvasDrawText(This,canvasID,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)

#define ICallbacks_CBCanvasPopup(This,canvasID,x,y,stepSize,popupType,pRet)	\
    (This)->lpVtbl -> CBCanvasPopup(This,canvasID,x,y,stepSize,popupType,pRet)

#define ICallbacks_CBCanvasWidth(This,canvasID,pRet)	\
    (This)->lpVtbl -> CBCanvasWidth(This,canvasID,pRet)

#define ICallbacks_CBCanvasHeight(This,canvasID,pRet)	\
    (This)->lpVtbl -> CBCanvasHeight(This,canvasID,pRet)

#define ICallbacks_CBCanvasDrawLine(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    (This)->lpVtbl -> CBCanvasDrawLine(This,canvasID,x1,y1,x2,y2,crColor,pRet)

#define ICallbacks_CBCanvasDrawRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    (This)->lpVtbl -> CBCanvasDrawRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)

#define ICallbacks_CBCanvasFillRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    (This)->lpVtbl -> CBCanvasFillRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)

#define ICallbacks_CBCanvasDrawHand(This,canvasID,pointx,pointy,pRet)	\
    (This)->lpVtbl -> CBCanvasDrawHand(This,canvasID,pointx,pointy,pRet)

#define ICallbacks_CBDrawHand(This,pointx,pointy,pRet)	\
    (This)->lpVtbl -> CBDrawHand(This,pointx,pointy,pRet)

#define ICallbacks_CBCheckKey(This,keyPressed,pRet)	\
    (This)->lpVtbl -> CBCheckKey(This,keyPressed,pRet)

#define ICallbacks_CBPlaySound(This,soundFile,pRet)	\
    (This)->lpVtbl -> CBPlaySound(This,soundFile,pRet)

#define ICallbacks_CBMessageWindow(This,text,textColor,bgColor,bgPic,mbtype,pRet)	\
    (This)->lpVtbl -> CBMessageWindow(This,text,textColor,bgColor,bgPic,mbtype,pRet)

#define ICallbacks_CBFileDialog(This,initialPath,fileFilter,pRet)	\
    (This)->lpVtbl -> CBFileDialog(This,initialPath,fileFilter,pRet)

#define ICallbacks_CBDetermineSpecialMoves(This,playerHandle,pRet)	\
    (This)->lpVtbl -> CBDetermineSpecialMoves(This,playerHandle,pRet)

#define ICallbacks_CBGetSpecialMoveListEntry(This,idx,pRet)	\
    (This)->lpVtbl -> CBGetSpecialMoveListEntry(This,idx,pRet)

#define ICallbacks_CBRunProgram(This,prgFile)	\
    (This)->lpVtbl -> CBRunProgram(This,prgFile)

#define ICallbacks_CBSetTarget(This,targetIdx,ttype)	\
    (This)->lpVtbl -> CBSetTarget(This,targetIdx,ttype)

#define ICallbacks_CBSetSource(This,sourceIdx,sType)	\
    (This)->lpVtbl -> CBSetSource(This,sourceIdx,sType)

#define ICallbacks_CBGetPlayerHP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerHP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerMaxHP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerMaxHP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerSMP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerSMP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerMaxSMP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerMaxSMP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerFP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerFP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerDP(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerDP(This,playerIdx,pRet)

#define ICallbacks_CBGetPlayerName(This,playerIdx,pRet)	\
    (This)->lpVtbl -> CBGetPlayerName(This,playerIdx,pRet)

#define ICallbacks_CBAddPlayerHP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBAddPlayerHP(This,amount,playerIdx)

#define ICallbacks_CBAddPlayerSMP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBAddPlayerSMP(This,amount,playerIdx)

#define ICallbacks_CBSetPlayerHP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBSetPlayerHP(This,amount,playerIdx)

#define ICallbacks_CBSetPlayerSMP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBSetPlayerSMP(This,amount,playerIdx)

#define ICallbacks_CBSetPlayerFP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBSetPlayerFP(This,amount,playerIdx)

#define ICallbacks_CBSetPlayerDP(This,amount,playerIdx)	\
    (This)->lpVtbl -> CBSetPlayerDP(This,amount,playerIdx)

#define ICallbacks_CBGetEnemyHP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemyHP(This,eneIdx,pRet)

#define ICallbacks_CBGetEnemyMaxHP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemyMaxHP(This,eneIdx,pRet)

#define ICallbacks_CBGetEnemySMP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemySMP(This,eneIdx,pRet)

#define ICallbacks_CBGetEnemyMaxSMP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemyMaxSMP(This,eneIdx,pRet)

#define ICallbacks_CBGetEnemyFP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemyFP(This,eneIdx,pRet)

#define ICallbacks_CBGetEnemyDP(This,eneIdx,pRet)	\
    (This)->lpVtbl -> CBGetEnemyDP(This,eneIdx,pRet)

#define ICallbacks_CBAddEnemyHP(This,amount,eneIdx)	\
    (This)->lpVtbl -> CBAddEnemyHP(This,amount,eneIdx)

#define ICallbacks_CBAddEnemySMP(This,amount,eneIdx)	\
    (This)->lpVtbl -> CBAddEnemySMP(This,amount,eneIdx)

#define ICallbacks_CBSetEnemyHP(This,amount,eneIdx)	\
    (This)->lpVtbl -> CBSetEnemyHP(This,amount,eneIdx)

#define ICallbacks_CBSetEnemySMP(This,amount,eneIdx)	\
    (This)->lpVtbl -> CBSetEnemySMP(This,amount,eneIdx)

#define ICallbacks_CBCanvasDrawBackground(This,canvasID,bkgFile,x,y,width,height)	\
    (This)->lpVtbl -> CBCanvasDrawBackground(This,canvasID,bkgFile,x,y,width,height)

#define ICallbacks_CBCreateAnimation(This,file,pRet)	\
    (This)->lpVtbl -> CBCreateAnimation(This,file,pRet)

#define ICallbacks_CBDestroyAnimation(This,idx)	\
    (This)->lpVtbl -> CBDestroyAnimation(This,idx)

#define ICallbacks_CBCanvasDrawAnimation(This,canvasID,idx,x,y,forceDraw,forceTransp)	\
    (This)->lpVtbl -> CBCanvasDrawAnimation(This,canvasID,idx,x,y,forceDraw,forceTransp)

#define ICallbacks_CBCanvasDrawAnimationFrame(This,canvasID,idx,frame,x,y,forceTranspFill)	\
    (This)->lpVtbl -> CBCanvasDrawAnimationFrame(This,canvasID,idx,frame,x,y,forceTranspFill)

#define ICallbacks_CBAnimationCurrentFrame(This,idx,pRet)	\
    (This)->lpVtbl -> CBAnimationCurrentFrame(This,idx,pRet)

#define ICallbacks_CBAnimationMaxFrames(This,idx,pRet)	\
    (This)->lpVtbl -> CBAnimationMaxFrames(This,idx,pRet)

#define ICallbacks_CBAnimationSizeX(This,idx,pRet)	\
    (This)->lpVtbl -> CBAnimationSizeX(This,idx,pRet)

#define ICallbacks_CBAnimationSizeY(This,idx,pRet)	\
    (This)->lpVtbl -> CBAnimationSizeY(This,idx,pRet)

#define ICallbacks_CBAnimationFrameImage(This,idx,frame,pRet)	\
    (This)->lpVtbl -> CBAnimationFrameImage(This,idx,frame,pRet)

#define ICallbacks_CBGetPartySize(This,partyIdx,pRet)	\
    (This)->lpVtbl -> CBGetPartySize(This,partyIdx,pRet)

#define ICallbacks_CBGetFighterHP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterHP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterMaxHP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterMaxHP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterSMP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterSMP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterMaxSMP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterMaxSMP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterFP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterFP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterDP(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterDP(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterName(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterName(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBGetFighterAnimation(This,partyIdx,fighterIdx,animationName,pRet)	\
    (This)->lpVtbl -> CBGetFighterAnimation(This,partyIdx,fighterIdx,animationName,pRet)

#define ICallbacks_CBGetFighterChargePercent(This,partyIdx,fighterIdx,pRet)	\
    (This)->lpVtbl -> CBGetFighterChargePercent(This,partyIdx,fighterIdx,pRet)

#define ICallbacks_CBFightTick(This)	\
    (This)->lpVtbl -> CBFightTick(This)

#define ICallbacks_CBDrawTextAbsolute(This,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)	\
    (This)->lpVtbl -> CBDrawTextAbsolute(This,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)

#define ICallbacks_CBReleaseFighterCharge(This,partyIdx,fighterIdx)	\
    (This)->lpVtbl -> CBReleaseFighterCharge(This,partyIdx,fighterIdx)

#define ICallbacks_CBFightDoAttack(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,amount,toSMP,pRet)	\
    (This)->lpVtbl -> CBFightDoAttack(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,amount,toSMP,pRet)

#define ICallbacks_CBFightUseItem(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,itemFile)	\
    (This)->lpVtbl -> CBFightUseItem(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,itemFile)

#define ICallbacks_CBFightUseSpecialMove(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,moveFile)	\
    (This)->lpVtbl -> CBFightUseSpecialMove(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,moveFile)

#define ICallbacks_CBDoEvents(This)	\
    (This)->lpVtbl -> CBDoEvents(This)

#define ICallbacks_CBFighterAddStatusEffect(This,partyIdx,fightIdx,statusFile)	\
    (This)->lpVtbl -> CBFighterAddStatusEffect(This,partyIdx,fightIdx,statusFile)

#define ICallbacks_CBFighterRemoveStatusEffect(This,partyIdx,fightIdx,statusFile)	\
    (This)->lpVtbl -> CBFighterRemoveStatusEffect(This,partyIdx,fightIdx,statusFile)

#define ICallbacks_CBCheckMusic(This)	\
    (This)->lpVtbl -> CBCheckMusic(This)

#define ICallbacks_CBReleaseScreenDC(This)	\
    (This)->lpVtbl -> CBReleaseScreenDC(This)

#define ICallbacks_CBCanvasOpenHdc(This,cnv,pRet)	\
    (This)->lpVtbl -> CBCanvasOpenHdc(This,cnv,pRet)

#define ICallbacks_CBCanvasCloseHdc(This,cnv,hdc)	\
    (This)->lpVtbl -> CBCanvasCloseHdc(This,cnv,hdc)

#define ICallbacks_CBFileExists(This,strFile,pRet)	\
    (This)->lpVtbl -> CBFileExists(This,strFile,pRet)

#define ICallbacks_CBCanvasLock(This,cnv)	\
    (This)->lpVtbl -> CBCanvasLock(This,cnv)

#define ICallbacks_CBCanvasUnlock(This,cnv)	\
    (This)->lpVtbl -> CBCanvasUnlock(This,cnv)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE ICallbacks_CBRpgCode_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand);


void __RPC_STUB ICallbacks_CBRpgCode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetString_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR varname,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetNumerical_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR varname,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetNumerical_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetString_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR varname,
    /* [string] */ BSTR newValue);


void __RPC_STUB ICallbacks_CBSetString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetNumerical_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR varname,
    double newValue);


void __RPC_STUB ICallbacks_CBSetNumerical_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetScreenDC_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetScreenDC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetScratch1DC_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetScratch1DC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetScratch2DC_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetScratch2DC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetMwinDC_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetMwinDC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBPopupMwin_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBPopupMwin_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBHideMwin_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBHideMwin_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadEnemy_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file,
    int eneSlot);


void __RPC_STUB ICallbacks_CBLoadEnemy_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int eneSlot,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int eneSlot,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemyNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int newValue,
    int eneSlot);


void __RPC_STUB ICallbacks_CBSetEnemyNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemyString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [string] */ BSTR newValue,
    int eneSlot);


void __RPC_STUB ICallbacks_CBSetEnemyString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int newVal,
    int playerSlot);


void __RPC_STUB ICallbacks_CBSetPlayerNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    /* [string] */ BSTR newVal,
    int playerSlot);


void __RPC_STUB ICallbacks_CBSetPlayerString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetGeneralString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetGeneralString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetGeneralNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetGeneralNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetGeneralString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    /* [string] */ BSTR newVal);


void __RPC_STUB ICallbacks_CBSetGeneralString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetGeneralNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int playerSlot,
    int newVal);


void __RPC_STUB ICallbacks_CBSetGeneralNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetCommandName_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetCommandName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBrackets_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetBrackets_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCountBracketElements_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCountBracketElements_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBracketElement_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    int elemNum,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetBracketElement_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetStringElementValue_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetStringElementValue_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetNumElementValue_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetNumElementValue_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetElementType_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR rpgcodeCommand,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetElementType_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDebugMessage_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR message);


void __RPC_STUB ICallbacks_CBDebugMessage_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPathString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPathString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadSpecialMove_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file);


void __RPC_STUB ICallbacks_CBLoadSpecialMove_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetSpecialMoveString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetSpecialMoveNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadItem_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file,
    int itmSlot);


void __RPC_STUB ICallbacks_CBLoadItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetItemString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int itmSlot,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetItemString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetItemNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos,
    int itmSlot,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetItemNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBoardNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetBoardNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetBoardString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetBoardString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetBoardNum_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    int nValue);


void __RPC_STUB ICallbacks_CBSetBoardNum_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetBoardString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int infoCode,
    int arrayPos1,
    int arrayPos2,
    int arrayPos3,
    /* [string] */ BSTR newVal);


void __RPC_STUB ICallbacks_CBSetBoardString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetHwnd_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetHwnd_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBRefreshScreen_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBRefreshScreen_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCreateCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCreateCanvas_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDestroyCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDestroyCanvas_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvas_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawCanvas_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasPartial_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int xDest,
    int yDest,
    int xsrc,
    int ysrc,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawCanvasPartial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasTransparent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawCanvasTransparent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


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
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawCanvasTransparentPartial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawCanvasTranslucent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    double dIntensity,
    int crUnaffectedColor,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawCanvasTranslucent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLoadImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR filename,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasLoadImage_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLoadSizedImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR filename,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasLoadSizedImage_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasFill_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasFill_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasResize_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int width,
    int height,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasResize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBlt_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvas2CanvasBlt_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


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
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvas2CanvasBltPartial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltTransparent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int xDest,
    int yDest,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvas2CanvasBltTransparent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


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
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvas2CanvasBltTransparentPartial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvas2CanvasBltTranslucent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvSrc,
    int cnvDest,
    int destX,
    int destY,
    double dIntensity,
    int crUnaffectedColor,
    int crTransparentColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvas2CanvasBltTranslucent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasGetScreen_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnvDest,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasGetScreen_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBLoadString_Proxy( 
    ICallbacks __RPC_FAR * This,
    int id,
    /* [string] */ BSTR defaultString,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBLoadString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


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
    /* [defaultvalue][in] */ int isOutlined,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasDrawText_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasPopup_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x,
    int y,
    int stepSize,
    int popupType,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasPopup_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasWidth_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasWidth_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasHeight_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasHeight_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawLine_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasDrawLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawRect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasDrawRect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasFillRect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int x1,
    int y1,
    int x2,
    int y2,
    int crColor,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasFillRect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawHand_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int pointx,
    int pointy,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasDrawHand_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawHand_Proxy( 
    ICallbacks __RPC_FAR * This,
    int pointx,
    int pointy,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawHand_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckKey_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR keyPressed,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCheckKey_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBPlaySound_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR soundFile,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBPlaySound_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBMessageWindow_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR text,
    int textColor,
    int bgColor,
    /* [string] */ BSTR bgPic,
    int mbtype,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBMessageWindow_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFileDialog_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR initialPath,
    /* [string] */ BSTR fileFilter,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBFileDialog_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDetermineSpecialMoves_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR playerHandle,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDetermineSpecialMoves_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetSpecialMoveListEntry_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetSpecialMoveListEntry_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBRunProgram_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR prgFile);


void __RPC_STUB ICallbacks_CBRunProgram_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetTarget_Proxy( 
    ICallbacks __RPC_FAR * This,
    int targetIdx,
    int ttype);


void __RPC_STUB ICallbacks_CBSetTarget_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetSource_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourceIdx,
    int sType);


void __RPC_STUB ICallbacks_CBSetSource_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerMaxHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerMaxSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerFP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [retval][out] */ double __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerDP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPlayerName_Proxy( 
    ICallbacks __RPC_FAR * This,
    int playerIdx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPlayerName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAddPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBAddPlayerHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAddPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBAddPlayerSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBSetPlayerHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBSetPlayerSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBSetPlayerFP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetPlayerDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int playerIdx);


void __RPC_STUB ICallbacks_CBSetPlayerDP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyMaxHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemySMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyMaxSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyFP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetEnemyDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int eneIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetEnemyDP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAddEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx);


void __RPC_STUB ICallbacks_CBAddEnemyHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAddEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx);


void __RPC_STUB ICallbacks_CBAddEnemySMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemyHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx);


void __RPC_STUB ICallbacks_CBSetEnemyHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBSetEnemySMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int amount,
    int eneIdx);


void __RPC_STUB ICallbacks_CBSetEnemySMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawBackground_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    /* [string] */ BSTR bkgFile,
    int x,
    int y,
    int width,
    int height);


void __RPC_STUB ICallbacks_CBCanvasDrawBackground_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCreateAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR file,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCreateAnimation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDestroyAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx);


void __RPC_STUB ICallbacks_CBDestroyAnimation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int idx,
    int x,
    int y,
    int forceDraw,
    int forceTransp);


void __RPC_STUB ICallbacks_CBCanvasDrawAnimation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasDrawAnimationFrame_Proxy( 
    ICallbacks __RPC_FAR * This,
    int canvasID,
    int idx,
    int frame,
    int x,
    int y,
    int forceTranspFill);


void __RPC_STUB ICallbacks_CBCanvasDrawAnimationFrame_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationCurrentFrame_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBAnimationCurrentFrame_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationMaxFrames_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBAnimationMaxFrames_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationSizeX_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBAnimationSizeX_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationSizeY_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBAnimationSizeY_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBAnimationFrameImage_Proxy( 
    ICallbacks __RPC_FAR * This,
    int idx,
    int frame,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBAnimationFrameImage_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetPartySize_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetPartySize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterMaxHP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterMaxHP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterMaxSMP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterMaxSMP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterFP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterFP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterDP_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterDP_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterName_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterAnimation_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [string] */ BSTR animationName,
    /* [string][retval][out] */ BSTR __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterAnimation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterChargePercent_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterChargePercent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightTick_Proxy( 
    ICallbacks __RPC_FAR * This);


void __RPC_STUB ICallbacks_CBFightTick_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


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
    /* [defaultvalue][in] */ int isOutlined,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBDrawTextAbsolute_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseFighterCharge_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fighterIdx);


void __RPC_STUB ICallbacks_CBReleaseFighterCharge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightDoAttack_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    int amount,
    int toSMP,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBFightDoAttack_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseItem_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR itemFile);


void __RPC_STUB ICallbacks_CBFightUseItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseSpecialMove_Proxy( 
    ICallbacks __RPC_FAR * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR moveFile);


void __RPC_STUB ICallbacks_CBFightUseSpecialMove_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDoEvents_Proxy( 
    ICallbacks __RPC_FAR * This);


void __RPC_STUB ICallbacks_CBDoEvents_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterAddStatusEffect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile);


void __RPC_STUB ICallbacks_CBFighterAddStatusEffect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterRemoveStatusEffect_Proxy( 
    ICallbacks __RPC_FAR * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile);


void __RPC_STUB ICallbacks_CBFighterRemoveStatusEffect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckMusic_Proxy( 
    ICallbacks __RPC_FAR * This);


void __RPC_STUB ICallbacks_CBCheckMusic_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseScreenDC_Proxy( 
    ICallbacks __RPC_FAR * This);


void __RPC_STUB ICallbacks_CBReleaseScreenDC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasOpenHdc_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv,
    /* [retval][out] */ int __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBCanvasOpenHdc_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasCloseHdc_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv,
    int hdc);


void __RPC_STUB ICallbacks_CBCanvasCloseHdc_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFileExists_Proxy( 
    ICallbacks __RPC_FAR * This,
    /* [string] */ BSTR strFile,
    /* [retval][out] */ short __RPC_FAR *pRet);


void __RPC_STUB ICallbacks_CBFileExists_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLock_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv);


void __RPC_STUB ICallbacks_CBCanvasLock_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasUnlock_Proxy( 
    ICallbacks __RPC_FAR * This,
    int cnv);


void __RPC_STUB ICallbacks_CBCanvasUnlock_Stub(
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

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long __RPC_FAR *, unsigned long            , BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserMarshal(  unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserUnmarshal(unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long __RPC_FAR *, BSTR __RPC_FAR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif
