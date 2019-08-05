@echo off

:: build with Microsoft Visual C++ Compiler for Python 2.7
:: https://www.microsoft.com/en-us/download/details.aspx?id=44266
::call "%LOCALAPPDATA%\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" amd64

:: build with Microsoft Visual Studio Community 2019
:: https://www.microsoft.com/ru-ru/download/details.aspx?id=48146
call "D:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

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
if exist %PROJECT%.exe C:\MyPrograms\NSISPortable\App\NSIS\makensis.exe ..\%PROJECT%.nsi

popd
                        