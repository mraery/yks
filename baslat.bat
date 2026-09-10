@echo off
title YKS Patika - TYT & AYT Hazirlik Uygulamasi
echo ===================================================
echo       YKS Patika: TYT & AYT Hazirlik Baslatiliyor
echo ===================================================
echo.
cd /d "C:\Users\roy\.gemini\antigravity\scratch\ykslingo"

echo 1. Yerel web sunucusu calistiriliyor...
start "YKS Patika Web Sunucusu" /min python -m http.server 8080 --directory build\web

echo 2. Tarayiciniz aciliyor...
timeout /t 2 >nul
start http://localhost:8080

echo.
echo ===================================================
echo   Uygulama tarayicinizda acildi!
echo   Adres: http://localhost:8080
echo ===================================================
echo.
echo Kapatmak istediginizde bu pencereyi kapatabilirsiniz.
pause
