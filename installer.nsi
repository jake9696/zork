!include "MUI2.nsh"

; General
Name "Zork"
OutFile "zork_setup.exe"
InstallDir "$LOCALAPPDATA\Zork"
RequestExecutionLevel user

; Interface Settings
!define MUI_ABORTWARNING

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Languages
!insertmacro MUI_LANGUAGE "English"

; Installer Section
Section "Install"
    SetOutPath "$INSTDIR"
    
    ; Files to install
    File "zork.exe"
    File "dtextc.dat"
    
    ; Uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
    
    ; Shortcuts
    CreateShortcut "$DESKTOP\Zork.lnk" "$INSTDIR\zork.exe"
    CreateDirectory "$SMPROGRAMS\Zork"
    CreateShortcut "$SMPROGRAMS\Zork\Zork.lnk" "$INSTDIR\zork.exe"
    CreateShortcut "$SMPROGRAMS\Zork\Uninstall.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

; Uninstaller Section
Section "Uninstall"
    Delete "$INSTDIR\zork.exe"
    Delete "$INSTDIR\dtextc.dat"
    Delete "$INSTDIR\uninstall.exe"
    Delete "$DESKTOP\Zork.lnk"
    Delete "$SMPROGRAMS\Zork\Zork.lnk"
    Delete "$SMPROGRAMS\Zork\Uninstall.lnk"
    RMDir "$SMPROGRAMS\Zork"
    RMDir "$INSTDIR"
SectionEnd
