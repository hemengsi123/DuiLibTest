@echo off
@rem By simon 2014.12.31 文件格式不可以为UTF8
@rem to make Makefile depend list
:main
REM 源文件目录
set SRCDIRS=.

REM set OUTDIR=.\bin
set curdate=%date:~0,4%-%date:~5,2%-%date:~8,2%[%time:~0,2%:%time:~3,2%]
REM 生成依赖
call:makeDeplist
REM 编译
REM set TAG=%1

REM nmake.exe /nologo /f Makefile.mak %TAG%

goto:eof

:makeDeplist
set CPPSRCS=
set CSRCS=
set HSRCS=
set EXTS=.H .CPP .C
set OBJS=
set srcfile=msrcfile.lst
set depfile=mdepfile.lst
REM H%SUFFIX% 后缀
set SUFFIX=SRCS
echo # >%srcfile%
echo # %curdate% >>%srcfile%
echo # >>%srcfile%

echo # %curdate% >%depfile%
SETLOCAL enabledelayedexpansion
rem 支持的 扩展名文件
for %%x in (%EXTS%) do (
	REM 源文件目录
	for %%i in (%SRCDIRS%) do (
		if exist %%i (
			REM echo %%i\*%%x
			if exist "%%i\*%%x" (
				set /a oneTime=1
				rem 列举 /s 子目录
				for /f "delims=" %%j in ('dir /b %%i\*%%x') do (
					if "!oneTime!" == "1" (
						rem =============== make srcfile =============
						rem 去掉'.'
						set ddot=%%x
						REM echo !ddot:~1!
						echo.>>%srcfile%
						echo !ddot:~1!%SUFFIX% = ^$^(!ddot:~1!%SUFFIX%^) \>>%srcfile%
					)
					REM echo %%i\%%j \
					echo.			%%i\%%j \>>%srcfile%
					rem *.obj 排除 *.h 文件
					if "%%x" neq ".H" (
						set OBJS=!OBJS! ^$^(OUTDIR^)\%%~nj.obj
						rem == make depfile ==
						if "!oneTime!" == "1" (
							echo.>>%depfile%
							echo {%%i}%%x{^$^(OUTDIR^)}.obj:>>%depfile%
							echo.	^$^(CC^) ^$^(CFLAGS^) ^$^(DEFINE^) ^$^(ENCODE^) ^$^(INCDIRS^) /Fo"$(OUTDIR)\\" ^$^(CDBGFLAGS^) ^$^< >>%depfile%
						)
					)
					rem *.h
					if "%%x" equ ".H" (
						set HSRCS=!HSRCS! %%i\%%j
					)
					rem *.c *.obj
					if "%%x" equ ".C" (
						set CSRCS=!CSRCS! %%i\%%j
						rem *.obj
						REM set OBJS=!OBJS! ^$^(OUTDIR^)\%%~nj.obj
					)
					rem *.cpp *.obj
					if "%%x" equ ".CPP" (
						set CPPSRCS=!CPPSRCS! %%i\%%j
						rem *.obj
						REM set OBJS=!OBJS! ^$^(OUTDIR^)\%%~nj.obj
					)
					if "!oneTime!" == "1" (
						set /a oneTime=0
					)
				)
			)
		)
	)
)
if "%HSRCS%" neq "" (
	echo %HSRCS%
	REM echo.>>%srcfile%
	REM echo HSRCS = ^$^(HSRCS^) \>>%srcfile%
	REM echo.			%HSRCS%>>%srcfile%
)
if "%CSRCS%" neq "" (
	echo %CSRCS%
	REM echo.>>%srcfile%
	REM echo CSRCS = ^$^(CSRCS^) \>>%srcfile%
	REM echo.			%CSRCS%>>%srcfile%
)
if "%CPPSRCS%" neq "" (
	echo %CPPSRCS%
	REM echo.>>%srcfile%
	REM echo CPPSRCS = ^$^(CPPSRCS^) \>>%srcfile%
	REM echo.			%CPPSRCS%>>%srcfile%
)
REM *.obj
REM if "%OBJS%" neq "" (
	REM echo %OBJS%
	echo.>>%srcfile%
	echo OBJS = ^$^(OBJS^) \>>%srcfile%
	echo.			%OBJS%>>%srcfile%
REM )
echo.>>%srcfile%

ENDLOCAL
goto:eof

rem 逐个类型生成
:makeDeplistByOne
rem ======= to make *.cpp ===========
set CPPSRCS=
set CSRCS=
set HSRCS=
REM set OBJS=
set EXTS=.H .C .CPP
set tmpfile=temp.txt
echo.>%tmpfile%
SETLOCAL enabledelayedexpansion
for %%i in (%SRCDIRS%) do (
	if exist %%i (
		if exist "%%i\*.cpp" (
			echo.>>%tmpfile%
			echo CPPSRCS = ^$^(CPPSRCS^) \>>%tmpfile%
			for /f "delims=" %%j in ('dir /b %%i\*.cpp') do (
				REM echo %%i\%%j \
				set CPPSRCS=!CPPSRCS! %%i\%%j
				set OBJS=!OBJS! ^$^(OUTDIR^)\%%~nj.obj
				echo.		%%i\%%j \>>%tmpfile%
			)
		)
	)
)
if "%CPPSRCS%" neq "" (echo %CPPSRCS%)
rem ========= to make *.c ===========
for %%i in (%SRCDIRS%) do (
	if exist %%i (
		if exist "%%i\*.c" (
			echo.>>%tmpfile%
			echo CSRCS = ^$^(CSRCS^) \>>%tmpfile%
			for /f "delims=" %%j in ('dir /b %%i\*.c') do (
				REM echo %%i\%%j \
				set CSRCS=!CSRCS! %%i\%%j
				set OBJS=!OBJS! ^$^(OUTDIR^)\%%~nj.obj
				echo.		%%i\%%j \>>%tmpfile%
			)
		)
	)
)
if "%CSRCS%" neq "" echo %CSRCS%
rem ========= to make *.h ============
for %%i in (%SRCDIRS%) do (
	if exist %%i (
		if exist "%%i\*.h" (
			echo.>>%tmpfile%
			echo HSRCS = ^$^(HSRCS^) \>>%tmpfile%
			for /f "delims=" %%j in ('dir /b %%i\*.h') do (
				REM echo %%i\%%j \
				set HSRCS=!HSRCS! %%i\%%j
				echo.		%%i\%%j \>>%tmpfile%
			)
		)
	)
)
echo %OBJS%

if "%HSRCS%" neq "" echo %HSRCS%
if "%CPPSRCS%" neq "" (
	echo.>>%tmpfile%
	echo # to compile *.cpp>>%tmpfile%
	for %%i in (%CPPSRCS%) do (
		echo ^$^(OUTDIR^)\%%~ni.obj: %%i>>%tmpfile%
		echo.	^$^(CC^) ^$^(CFLAGS^) ^$^(DEFINE^) ^$^(ENCODE^) ^$^(INCDIRS^) /Fo"$(OUTDIR)\\" ^$^(CDBGFLAGS^) ^$^?>>%tmpfile%
	)
)
if "%CSRCS%" neq "" (
	echo.>>%tmpfile%
	echo # to compile *.c>>%tmpfile%
	for %%i in (%CSRCS%) do (
		echo ^$^(OUTDIR^)\%%~ni.obj: %%i>>%tmpfile%
		echo.	^$^(CC^) ^$^(CFLAGS^) ^$^(DEFINE^) ^$^(ENCODE^) ^$^(INCDIRS^) /Fo"$(OUTDIR)\\" ^$^(CDBGFLAGS^) ^$^?>>%tmpfile%
	)
)
echo.>>%tmpfile%
ENDLOCAL
goto:eof
