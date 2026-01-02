@echo off
setlocal
title PDF Browser Restriction - RESET TOOL

echo ========================================================
echo      BROWSER PDF RESTRICTION - RESET TOOL
echo      Restores default behavior (Browsers will open PDFs).
echo ========================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Admin privileges confirmed.
) else (
    echo [ERROR] This script requires Administrator privileges.
    echo Please right-click and select "Run as Administrator".
    pause
    exit
)

echo.
echo [1/4] Removing Google Chrome restrictions...
reg delete "HKLM\SOFTWARE\Policies\Google\Chrome" /v AlwaysOpenPdfExternally /f >nul 2>&1
if %errorlevel%==0 (echo    - Success: Restriction removed) else (echo    - Key not found or already removed)

echo.
echo [2/4] Removing Microsoft Edge restrictions...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AlwaysOpenPdfExternally /f >nul 2>&1
if %errorlevel%==0 (echo    - Success: Restriction removed) else (echo    - Key not found or already removed)

echo.
echo [3/4] Removing Brave Browser restrictions...
reg delete "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v AlwaysOpenPdfExternally /f >nul 2>&1
if %errorlevel%==0 (echo    - Success: Restriction removed) else (echo    - Key not found or already removed)

echo.
echo [4/4] Removing Mozilla Firefox restrictions...
set "FF_JSON=C:\Program Files\Mozilla Firefox\distribution\policies.json"
if exist "%FF_JSON%" (
    del /f /q "%FF_JSON%"
    echo    - Success: Firefox policy file deleted.
) else (
    echo    - Firefox policy file not found.
)

echo.
echo ========================================================
echo Closing running browsers to apply changes...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
echo.
echo DONE. Browsers will now open PDFs normally.
echo ========================================================
pause
