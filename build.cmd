call C:\MinGW\set_distro_paths.bat
erase /q /s *.bak *.orig *.exe *.o
gcc langswitchcaps.c -s -mwindows  -o langswitchcaps.exe
if exist langswitchcaps.exe C:\MyPrograms\NSISPortable\NSISPortable.exe langswitchcaps.nsi
