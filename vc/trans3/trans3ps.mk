
trans3ps.dll: dlldata.obj trans3_p.obj trans3_i.obj
	link /dll /out:trans3ps.dll /def:trans3ps.def /entry:DllMain dlldata.obj trans3_p.obj trans3_i.obj \
		kernel32.lib rpcndr.lib rpcns4.lib rpcrt4.lib oleaut32.lib uuid.lib \

.c.obj:
	cl /c /Ox /DWIN32 /D_WIN32_WINNT=0x0400 /DREGISTER_PROXY_DLL \
		$<

clean:
	@del trans3ps.dll
	@del trans3ps.lib
	@del trans3ps.exp
	@del dlldata.obj
	@del trans3_p.obj
	@del trans3_i.obj
