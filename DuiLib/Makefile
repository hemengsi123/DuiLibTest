#
# VC++ nmake Makefile
# by Simon 2014.12.31
#

TARGET  = DuiLib
SRCDIRS = . Control Utils CORE Layout
OUTDIR  = .\bin
DEBUG   = Debug
MAKEDEP = true
# OBJS    = test1.obj
LIBS    = user32.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib
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
LOGFILE   = >> $(OUTDIR)\make.log 2>&1
# 生成 asm 文件
ASMFLAGS    = /Fa"$*.asm"
ENCODE    = /D UNICODE /D _UNICODE
# 编译资源 0x804 中国,0x409 美国
RC   = rc.exe
RCFLAGS =  /v /l 0x804
# RESRCS  = $(OUTDIR)\test1.res
RESRCS  = 
# 连接
LD        = link.exe
# LDFLAGS = /nologo /Machine:x86 /OUT:"$(OUTDIR)\\$@.exe"
LDFLAGS   = /nologo /Machine:x86 
!IF "$(DEBUG)" == "Debug"
CDBGFLAGS = /D _DEBUG /Fd"$(OUTDIR)\\vc100.pdb" /FD
LDBGFLAGS = /debug  /pdb:"$(OUTDIR)\\$(TARGET).pdb"
!ELSE
DEBUG     = Release
!ENDIF
DLLFLAGS  = /BASE:"0x11000000" /DYNAMICBASE /NXCOMPAT /DLL /OUT:"$(OUTDIR)\\$@.dll" /IMPLIB:"$(OUTDIR)\\$@.lib"
# 通过 makedep.bat 生成依赖文件 (msrcfile.lst 不存在,则执行makedep.bat)
# MAKEDEP = false
# or -> || ; and -> && ; !IF EXISTS("msrcfile.lst")
!IF "$(MAKEDEP)" == "true"
!IF [dir /b | findstr /x "msrcfile.lst" >nul:] || [dir /b | findstr /x "mdepfile.lst" >nul:]
!MESSAGE to make depend list...
!IF [..\makedep.bat "" "." "$(SRCDIRS)"]
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

!IF "$(MAKEDEP)" == "true"
!INCLUDE "mdepfile.lst"
!ENDIF
# {Control}.cpp{$(OUTDIR)}.obj:
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<

# {Core}.cpp{$(OUTDIR)}.obj:
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<
# $(CC) $(CFLAGS) $(DEFINE) $(ENCODE) $(INCDIRS) /Fo"$(OUTDIR)\\" $(CDBGFLAGS) $<

# "$(OUTDIR)\\$(RESRCS).res" $(RESRCS).rc
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
	@if exist ".\\mdepfile.lst"  del /f .\\mdepfile.lst
	@if exist ".\\msrcfile.lst"  del /f .\\msrcfile.lst
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


# ----------------------------------- Makefile ---------------------
# #pragma warning(disable:4005) 忽略4005警告
# #pragma warning(default:4005) 打开4005警告
# --------------------
# $@   // 表示所有目标全名（路径+文件名称+扩展名）的挨个值
# $$@  // 与$@用法含义一致，但仅在作为依赖项中的依赖项时有效
# $<   // 表示所有依赖目标的挨个值，仅在推理规则的命令中有效
# $^   // 表示所有依赖目标的集合，以空格分隔，若有重复，会被去重；
# $+   // 与$^含义一致，只是不进行去重处理。
# $?    // 表示所有比目标心的依赖目标的集合，以空格分隔
# $*    // 当前目标的路径和文件名称，没有文件扩展名
# $**  // 当前目标的所有依赖项
# -------------------------------------
# 修饰符     说明  $(@B)
# D         驱动器和目录  
# B         文件名称  
# F         文件名称和扩展名  
# R         驱动器、目录和文件名称
# -----------------------------------------
# /D UNICODE /D _UNICODE 用Unicode编码方式(*.cpp 文件需要ANSI编码方式，若是UTF8就会有乱码; 产生4819 警告，可能是*.cpp 文件用的是UTF8编码方式)
# /Zc:forScope 强制 for 循环范围中的一致性 /Zc:wchar_t（wchar_t 是本机类型）
# /RTC1 or /GZ 使用   __stdcall 调用约定, /Gd:指定使用__cdecl的函数调用规则, /Zi 生成完整的调试信息 , /FD:生成文件的相互依赖信息
# /GX:允许同步异常处理 /Yu"stdafx.h"  /errorReport:prompt /Fo 目标文件路径, /Fd 调试数据库文件 /Fa"$*.asm"

