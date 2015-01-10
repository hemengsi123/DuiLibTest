#
# VC++ nmake Makefile
# by Simon 2014.12.31
#

# .SUFFIXES: .cpp

TARGET  = test1
# OBJS    = test1.obj
OUTDIR  = .\bin
LIBS    = user32.lib kernel32.lib
DEBUG   = debug
INCDIRS = /I"D:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include" /I"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Include" \
			/I"D:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\atlmfc\include" /I.

LIBDIRS = /LIBPATH:"D:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib" /LIBPATH:"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Lib" \
			/LIBPATH:"D:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\atlmfc\lib"
# 编译 /Zs : 只检查语法, /link : 将指定的选项传递给 LINK
CC      = cl.exe
# /D UNICODE /D _UNICODE 用Unicode编码方式(*.cpp 文件需要ANSI编码方式，若是UTF8就会有乱码; 产生4819 警告，可能是*.cpp 文件用的是UTF8编码方式)
# /Zc:forScope 强制 for 循环范围中的一致性 /Zc:wchar_t（wchar_t 是本机类型）
# /GZ 使用   __stdcall 调用约定, /Gd:指定使用__cdecl的函数调用规则, /Zi 生成完整的调试信息 , /FD:生成文件的相互依赖信息
# /GX:允许同步异常处理 /Yu"stdafx.h"  /errorReport:prompt /Fo 目标文件路径, /Fd 调试数据库文件 /Fa"$*.asm"
DEFINE    = /D WIN32  /D _WINDOWS /D UILIB_EXPORTS /D _WINDLL
CFLAGS    = /c /nologo /Zi /W3 /Od /FD /Gm /EHsc /MTd /GS /fp:precise /Zc:wchar_t /Zc:forScope
CDBGFLAGS = /D _DEBUG /Fd"$(OUTDIR)\\vc100.pdb"
LOGFILE   = >> $(OUTDIR)\make.log 2>&1
# 生成 asm 文件
ASMFLAGS  = /Fa"$*.asm"
ENCODE    = /D UNICODE /D _UNICODE
# 编译资源 0x804 中国,0x409 美国
RC   = rc.exe
RCFLAGS =  /v /l 0x804
# RESRCS  = $(OUTDIR)\test1.res
RESRCS  = 
# 连接
LD        = link.exe
# LDFLAGS = /nologo /Machine:x86 /OUT:"$(OUTDIR)\\$@.exe"
# /OPT（优化）, /OPT:REF 清除从未引用的函数和数据;使用 /OPT:ICF[=iterations] 执行相同的 COMDAT 折叠
LDFLAGS   = /nologo /Machine:x86 /OPT:REF /OPT:ICF
LDFLAGS   = $(LDFLAGS) /OUT:"$(OUTDIR)\\$@.exe"
# LDFLAGS   = $(LDFLAGS) /debug  /pdb:"$(OUTDIR)\\$(TARGET).pdb"
LDBGFLAGS = /debug  /pdb:"$(OUTDIR)\\$(TARGET).pdb"

# DLLFLAGS  = /BASE:"0x11000000" /DYNAMICBASE /NXCOMPAT /DLL /OUT:"$(OUTDIR)\\$@.dll" /IMPLIB:"$(OUTDIR)\\$@.lib"

# 通过 makedep.bat 生成依赖文件 (msrcfile.lst 不存在,则执行makedep.bat)
MAKEDEP = true
# MAKEDEP = false
!IF "$(MAKEDEP)" == "true"
!IF [dir /b | findstr /x "msrcfile.lst" >nul:]
!MESSAGE to make depend list...
!IF [makedep.bat >nul:]
!MESSAGE makedep.bat is not available
!ENDIF
!ENDIF
!INCLUDE "msrcfile.lst"
!ENDIF
# ALL: clean pre_handle $(TARGET)
ALL: pre_handle $(TARGET)
	@echo Build Successs...$(DEBUG)
.PHONY: ALL
# $@ 目标名(包括扩展名), $* 目标名(不包括扩展名), $** 所有依赖文件(包括扩展名)
# target: objs res $(OUTDIR)\
$(TARGET): $(OBJS) $(RESRCS)
	$(LD) $(LDFLAGS) $(LDBGFLAGS) $(LIBDIRS) $(LIBS) $(DLLFLAGS) $(OBJS) $(RESRCS)


# {Control}.cpp{$(OUTDIR)}.obj:
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<

# {Core}.cpp{$(OUTDIR)}.obj:
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<

# "$(OUTDIR)\\$(RESRCS).res" $(RESRCS).rc
# $(OUTDIR)\$(RESRCS).res: $(RESRCS).rc
#	$(RC) $(RCFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo$@ $**
# .PHONY: $(OUTDIR)\$(RESRCS).res
.rc{$(OUTDIR)}.res:
	$(RC) $(RCFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$@" $(@B).rc
# @echo $(CSRCS)
pre_handle:
	@if not exist $(OUTDIR) md $(OUTDIR)
	@echo beging compile...
.PHONY: pre_handle
lib:
	lib.exe $(OBJS) /OUT:$(OUTDIR)\\$(TARGET).lib
.PHONY: lib
clean:
	@if exist "$(OUTDIR)\\*.obj" del /f $(OUTDIR)\\*.obj
	@if exist "$(OUTDIR)\\*.exe" del /f $(OUTDIR)\\*.exe
	@if exist "$(OUTDIR)\\*.pdb" del /f $(OUTDIR)\\*.pdb
	@if exist "$(OUTDIR)\\*.ilk" del /f $(OUTDIR)\\*.ilk
	@if exist "$(OUTDIR)\\*.res" del /f $(OUTDIR)\\*.res
	@if exist "$(OUTDIR)\\*.lib" del /f $(OUTDIR)\\*.lib
	@if exist "$(OUTDIR)\\*.asm" del /f $(OUTDIR)\\*.asm
	@if exist "$(OUTDIR)\\*.idb" del /f $(OUTDIR)\\*.idb
.PHONY: clean
#error:
#	@type $(OUTDIR)\\make.log
#.PHONY: error
# #pragma warning(disable:4005) 忽略4005警告
# #pragma warning(default:4005) 打开4005警告
!IF "$(MAKEDEP)" == "true"
!INCLUDE "mdepfile.lst"
!ENDIF
