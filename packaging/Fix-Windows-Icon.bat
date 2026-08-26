@echo off
REM Clears the Windows icon cache.
REM
REM Windows caches shortcut icons and often keeps showing the previous one after
REM an app is upgraded. An earlier build of this app shipped Flutter's default
REM icon, so upgrading from it can leave that icon on the desktop even though the
REM installed program carries the correct one.
REM
REM Nothing here touches the app or its records - it only rebuilds the cache.

echo.
echo  Refreshing Windows icon cache
echo  =============================
echo.

echo  1/3  asking Windows to rebuild its icon cache...
ie4uinit.exe -show 2>nul
ie4uinit.exe -ClearIconCache 2>nul

echo  2/3  deleting the cache files...
taskkill /f /im explorer.exe >nul 2>&1
del /a /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /a /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1

echo  3/3  restarting Explorer...
start explorer.exe

echo.
echo  Done. The desktop icon should now show the cross.
echo.
echo  If it still does not, sign out of Windows and back in.
echo.
pause
