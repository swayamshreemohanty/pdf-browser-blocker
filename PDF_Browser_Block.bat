@echo off
setlocal
title PDF Browser Blocker Tool

echo ========================================================
echo      BROWSER PDF RESTRICTION TOOL
echo      Forces all Chromium/Firefox browsers
echo      to download PDFs instead of opening them.
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
echo [1/3] Applying Chromium-based restrictions (Chrome, Edge, Brave, etc.)...
for %%B in (Google\Chrome Microsoft\Edge BraveSoftware\Brave Chromium Vivaldi YandexBrowser OperaSoftware\Opera) do (
    reg add "HKLM\SOFTWARE\Policies\%%B" /v AlwaysOpenPdfExternally /t REG_DWORD /d 1 /f >nul 2>&1
)
echo    - Success: Chromium policies applied.

echo.
echo [2/3] Applying Mozilla Firefox restrictions...
:: Using Registry for Firefox Enterprise Policies 
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\PDFjs" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
echo    - Success: Firefox policy applied via registry.

echo.
echo [3/3] Closing running browsers to apply settings...
for %%E in (chrome.exe msedge.exe brave.exe firefox.exe vivaldi.exe browser.exe opera.exe yandex.exe) do (
    taskkill /F /IM %%E /T >nul 2>&1
)

echo.
echo ========================================================
echo DONE. All browsers are now forced to download PDFs.
echo You can now use your Offline PDF Reader to open them.
echo ========================================================
pause
