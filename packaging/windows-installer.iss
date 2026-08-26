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
UninstallDisplayName={#AppName}
AppVerName={#AppName} {#AppVersion}
; A visible install directory page, so it is obvious the app is being installed
; to the machine rather than just run.
DisableDirPage=no
DisableProgramGroupPage=yes
; Warn rather than silently fail if an older copy is running.
CloseApplications=yes
RestartApplications=no
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
; Ticked by default. This was `unchecked`, so anyone clicking straight through
; setup ended up with no desktop icon and assumed nothing had been installed.
Name: "desktopicon"; Description: "Create a &desktop shortcut"; \
  GroupDescription: "Shortcuts:"

[Files]
; The entire Release folder: the .exe alone will not run without the DLLs
; and the data/ directory that sit beside it.
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; \
  Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; WorkingDir matters: without it the app inherits whatever directory the
; shortcut was launched from, which can break relative asset lookups.
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"; \
  WorkingDir: "{app}"; IconFilename: "{app}\{#AppExe}"; \
  Comment: "Kingdom Grace Chapel management console"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; \
  WorkingDir: "{app}"; IconFilename: "{app}\{#AppExe}"; \
  Comment: "Kingdom Grace Chapel management console"; Tasks: desktopicon

[Run]
; Windows caches shortcut icons aggressively and keeps showing the previous one
; after an upgrade — an earlier build of this app shipped Flutter's default
; icon, so anyone upgrading sees that until the cache is rebuilt. ie4uinit is
; the documented way to force it, and is present on every supported Windows.
Filename: "{sys}\ie4uinit.exe"; Parameters: "-show"; \
  Flags: runhidden skipifdoesntexist; StatusMsg: "Refreshing icons..."

Filename: "{app}\{#AppExe}"; Description: "Start {#AppName}"; \
  Flags: nowait postinstall skipifsilent

; The database lives in %APPDATA%\{#AppId} and is deliberately NOT removed on
; uninstall — uninstalling the program must not destroy the church's records.
