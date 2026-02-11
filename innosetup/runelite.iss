[Setup]
AppName=DeadMoore Launcher
AppPublisher=DeadMoore
UninstallDisplayName=DeadMoore
AppVersion=${project.version}
AppSupportURL=https://deadmoore.info
DefaultDirName={localappdata}\DeadMoore

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\DeadMoore.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=DeadMooreSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\DeadMoore.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\DeadMoore.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\DeadMoore\DeadMoore"; Filename: "{app}\DeadMoore.exe"
Name: "{userprograms}\DeadMoore\DeadMoore (configure)"; Filename: "{app}\DeadMoore.exe"; Parameters: "--configure"
Name: "{userprograms}\DeadMoore\DeadMoore (safe mode)"; Filename: "{app}\DeadMoore.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\DeadMoore"; Filename: "{app}\DeadMoore.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\DeadMoore.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\DeadMoore.exe"; Description: "&Open DeadMoore"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\DeadMoore.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.deadmoore\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\DeadMoore.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"