; Inno Setup script for Church Management System.
;
; Compiled by packaging\build-windows.ps1 after a successful Flutter build.
; Produces a single setup .exe that installs to Program Files, adds Start Menu
; and optional desktop shortcuts, and registers a proper uninstaller.

#define AppName "Church Management"
#define AppId "org.gracechapel.churchms"
#define AppVersion "1.0.0"
#define AppPublisher "Kingdom Grace Chapel"
#define AppExe "churchms.exe"

[Setup]
AppId={{8F3C1A94-2E77-4B65-9D3A-1C0B7E5A6D42}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
OutputDir=..\dist
OutputBaseFilename=church-management-{#AppVersion}-setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; Per-machine install when run as admin, per-user otherwise.
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\{#AppExe}
; The setup .exe's own icon, and the one in Add/Remove Programs. Without this
; the installer ships with Inno Setup's generic icon even though the installed
; app is branded correctly.
SetupIconFile=..\windows\runner\resources\app_icon.ico
VersionInfoDescription={#AppName} installer
VersionInfoProductName={#AppName}
VersionInfoVersion={#AppVersion}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; \
  GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Files]
; The entire Release folder: the .exe alone will not run without the DLLs
; and the data/ directory that sit beside it.
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; \
  Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "Start {#AppName}"; \
  Flags: nowait postinstall skipifsilent

; The database lives in %APPDATA%\{#AppId} and is deliberately NOT removed on
; uninstall — uninstalling the program must not destroy the church's records.
