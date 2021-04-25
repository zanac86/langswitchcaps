@echo off

call "d:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" amd64

set PROJECT=langswitchcaps

set BUILD_DIR=release
rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%
pushd %BUILD_DIR%

::cl langswitchcaps.c /MT /link user32.lib
cl /c /O1 ..\%PROJECT%.c
link /ENTRY:main /NODEFAULTLIB /SUBSYSTEM:WINDOWS %PROJECT%.obj kernel32.lib user32.lib

:: Nullsoft Scriptable Install System
:: http://portableapps.com/apps/development/nsis_portable
if exist %PROJECT%.exe C:\MyPrograms\nsis\makensis.exe ..\%PROJECT%.nsi

popd
                        