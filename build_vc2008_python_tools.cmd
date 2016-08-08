call "%LOCALAPPDATA%\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" amd64
cl langswitchcaps.c /MT /link user32.lib 