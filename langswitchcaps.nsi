SetCompressor /SOLID lzma

Name "LangSwitchCaps"

!define PROG "LangSwitchCaps"

OutFile "release\Setup_${PROG}.exe"
InstallDir "$PROGRAMFILES\${PROG}"
ShowInstDetails hide
ShowUninstDetails show

VIAddVersionKey  "ProductName" "${PROG}"
VIAddVersionKey  "Comments" "Tiny keyboard layout switcher on caps"
VIAddVersionKey  "CompanyName" "VB Lab"
VIAddVersionKey  "LegalCopyright" "VB Lab"
VIAddVersionKey  "FileDescription" "${PROG} installer"
VIAddVersionKey  "FileVersion" "1.0.0.0"
VIProductVersion "1.0.0.0"

RequestExecutionLevel highest

Page directory
Page components
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;-------------------------------------------------------------------------------
Section "-Main"
  ExecWait '"taskkill.exe" /F /IM ${PROG}.exe'
  SetOutPath '$INSTDIR'
  File '.\release\${PROG}.exe'
  WriteUninstaller "uninstall.exe"
  DeleteRegKey HKCU "Software\vb_lab\${PROG}"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROG}" "DisplayName"     "CpuMeter (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROG}" "UninstallString" '"$INSTDIR\uninstall.exe"'
SectionEnd

Section "Shortcut in Startup folder"
  CreateShortCut  "$SMSTARTUP\${PROG}.lnk" "$INSTDIR\${PROG}.exe"
SectionEnd

Section "Run LangSwitchCaps after install"
  Exec '$INSTDIR\${PROG}'
SectionEnd

;-------------------------------------------------------------------------------
Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROG}"
  ExecWait '"taskkill.exe" /F /IM ${PROG}.exe'
  DeleteRegKey HKCU "Software\vb_lab\${PROG}"
  Delete "$INSTDIR\${PROG}.exe"
  Delete "$INSTDIR\uninstall.exe"
  Delete "$INSTDIR\*.*"
  RMDir  "$INSTDIR"
SectionEnd

