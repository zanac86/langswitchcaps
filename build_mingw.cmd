set path=D:\Qt\qt-5.5.0-x64-mingw510r0-seh-rev0\mingw64\bin;%path%

set PROJECT=langswitchcaps

set BUILD_DIR=release
rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%
pushd %BUILD_DIR%

gcc ..\%PROJECT%.c -s -mwindows  -o %PROJECT%.exe

if exist %PROJECT%.exe C:\MyPrograms\NSISPortable\App\NSIS\makensis.exe ..\%PROJECT%.nsi

popd
