# Builds the Windows application and an installer.
#
# MUST be run on a Windows machine — Flutter cannot cross-compile desktop
# targets, so a .exe cannot be produced from Linux or macOS.
#
# Requirements on that machine:
#   * Flutter SDK on PATH            https://docs.flutter.dev/get-started
#   * Visual Studio 2022 with the
#     "Desktop development with C++" workload
#   * (optional) Inno Setup 6, for a single-file installer
#                                    https://jrsoftware.org/isdl.php
#
# Usage, from the project root:
#   powershell -ExecutionPolicy Bypass -File packaging\build-windows.ps1

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

Write-Host 'Checking toolchain…' -ForegroundColor Cyan
flutter --version | Select-Object -First 1
flutter doctor -v | Select-String -Pattern 'Visual Studio' -Context 0,2

Write-Host ''
Write-Host 'Enabling the Windows target…' -ForegroundColor Cyan
flutter config --enable-windows-desktop | Out-Null
if (-not (Test-Path "$root\windows")) {
  flutter create --platforms=windows .
}

Write-Host 'Fetching packages…' -ForegroundColor Cyan
flutter pub get

Write-Host 'Generating database code…' -ForegroundColor Cyan
dart run build_runner build

Write-Host 'Building release…' -ForegroundColor Cyan
flutter build windows --release

$bundle = "$root\build\windows\x64\runner\Release"
if (-not (Test-Path "$bundle\churchms.exe")) {
  throw "Build did not produce churchms.exe in $bundle"
}

Write-Host ''
Write-Host "Built: $bundle\churchms.exe" -ForegroundColor Green
Write-Host 'The whole Release folder must be kept together — the .exe needs the'
Write-Host 'DLLs and data/ folder beside it.'

# Optional single-file installer, if Inno Setup is available.
$iscc = Get-Command iscc.exe -ErrorAction SilentlyContinue
if (-not $iscc) {
  $guess = 'C:\Program Files (x86)\Inno Setup 6\ISCC.exe'
  if (Test-Path $guess) { $iscc = $guess }
}

if ($iscc) {
  Write-Host ''
  Write-Host 'Building installer with Inno Setup…' -ForegroundColor Cyan
  & $iscc "$root\packaging\windows-installer.iss"
  Write-Host "Installer written to $root\dist" -ForegroundColor Green
} else {
  Write-Host ''
  Write-Host 'Inno Setup not found — skipping the installer step.' -ForegroundColor Yellow
  Write-Host 'To share as-is, zip the Release folder.'
  Write-Host 'For a proper installer, install Inno Setup 6 and re-run this script.'
}
