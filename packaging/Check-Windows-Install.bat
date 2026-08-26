@echo off
REM Tells you WHICH copy of the app your desktop icon actually points at.
REM
REM The usual cause of a Flutter icon on the desktop is a shortcut left over
REM from an older build, or one pointing at an extracted folder rather than the
REM installed program. This prints both so the difference is obvious.

setlocal
echo.
echo  Church Management - install check
echo  =================================
echo.

set "INSTALLED=%ProgramFiles%\Church Management\churchms.exe"

echo  Installed program:
if exist "%INSTALLED%" (
  echo    FOUND    %INSTALLED%
  for %%F in ("%INSTALLED%") do echo    built    %%~tF
) else (
  echo    NOT INSTALLED - run church-management-1.0.0-setup.exe
)
echo.

echo  Desktop shortcuts named "Church Management":
for %%D in ("%USERPROFILE%\Desktop" "%PUBLIC%\Desktop") do (
  if exist "%%~D\Church Management.lnk" (
    echo    %%~D\Church Management.lnk
    powershell -NoProfile -Command ^
      "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%%~D\Church Management.lnk'); ^
       Write-Host '      points at :' $s.TargetPath; ^
       Write-Host '      icon      :' $s.IconLocation; ^
       if ($s.TargetPath -ne '%INSTALLED%') { ^
         Write-Host '      >>> WRONG TARGET - this is not the installed program' ^
       } else { Write-Host '      OK - points at the installed program' }"
  )
)
echo.

echo  Other copies of churchms.exe on this machine:
where /r "%USERPROFILE%" churchms.exe 2>nul
echo.
echo  Any listed above that is NOT in Program Files is an extracted copy.
echo  Those still carry whatever icon that build shipped with.
echo.
pause
