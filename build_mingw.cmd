set path=F:\Qt5\Tools\mingw810_64\bin;%path%

set PROJECT=langswitchcaps

set BUILD_DIR=release
rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%
pushd %BUILD_DIR%

gcc ..\%PROJECT%.c -s -mwindows  -o %PROJECT%.exe

if exist %PROJECT%.exe C:\MyPrograms\NSISPortable\App\NSIS\makensis.exe ..\%PROJECT%.nsi

popd
