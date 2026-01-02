@echo off
setlocal
title PDF Browser Blocker Tool

echo ========================================================
echo      BROWSER PDF RESTRICTION TOOL
echo      Forces Chrome, Edge, Brave, and Firefox
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
echo [1/4] Applying Google Chrome restrictions...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v AlwaysOpenPdfExternally /t REG_DWORD /d 1 /f >nul
if %errorlevel%==0 (echo    - Success) else (echo    - Failed)

echo.
echo [2/4] Applying Microsoft Edge restrictions...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AlwaysOpenPdfExternally /t REG_DWORD /d 1 /f >nul
if %errorlevel%==0 (echo    - Success) else (echo    - Failed)

echo.
echo [3/4] Applying Brave Browser restrictions...
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v AlwaysOpenPdfExternally /t REG_DWORD /d 1 /f >nul
if %errorlevel%==0 (echo    - Success) else (echo    - Failed or Brave not installed)

echo.
echo [4/4] Applying Mozilla Firefox restrictions...
:: Define Firefox path
set "FF_PATH=C:\Program Files\Mozilla Firefox"
set "FF_DIST=%FF_PATH%\distribution"
set "FF_JSON=%FF_DIST%\policies.json"

if exist "%FF_PATH%" (
    if not exist "%FF_DIST%" mkdir "%FF_DIST%"
    (
        echo {
        echo   "policies": {
        echo     "PDFjs": {
        echo       "Enabled": false
        echo     }
        echo   }
        echo }
    ) > "%FF_JSON%"
    echo    - Success: Firefox policy created.
) else (
    echo    - Firefox not found in default location. Skipping.
)

echo.
echo ========================================================
echo Closing running browsers to apply settings...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
echo Browsers restarted.
echo.
echo DONE. All browsers are now forced to download PDFs.
echo You can now use your Offline Adobe Reader to open them.
echo ========================================================
pause
