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
echo [1/3] Removing Chromium-based restrictions...
for %%B in (Google\Chrome Microsoft\Edge BraveSoftware\Brave Chromium Vivaldi YandexBrowser OperaSoftware\Opera) do (
    reg delete "HKLM\SOFTWARE\Policies\%%B" /v AlwaysOpenPdfExternally /f >nul 2>&1
)
echo    - Success: Chromium policies removed.

echo.
echo [2/3] Removing Mozilla Firefox restrictions...
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\PDFjs" /v Enabled /f >nul 2>&1
:: Also clean up old JSON policy if it exists
if exist "C:\Program Files\Mozilla Firefox\distribution\policies.json" del /f /q "C:\Program Files\Mozilla Firefox\distribution\policies.json" >nul 2>&1
if exist "C:\Program Files (x86)\Mozilla Firefox\distribution\policies.json" del /f /q "C:\Program Files (x86)\Mozilla Firefox\distribution\policies.json" >nul 2>&1
echo    - Success: Firefox policies removed.

echo.
echo [3/3] Closing running browsers to apply changes...
for %%E in (chrome.exe msedge.exe brave.exe firefox.exe vivaldi.exe browser.exe opera.exe yandex.exe) do (
    taskkill /F /IM %%E /T >nul 2>&1
)

echo.
echo ========================================================
echo DONE. Browsers will now open PDFs normally.
echo ========================================================
pause
