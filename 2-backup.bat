@echo off
echo %cd%
mkdir .\whatsapp-files\shared\
echo preparing backup.. 
echo pastikan sudah terhubung dgn smartphone mode developer + usb debugging = on
pause
echo backup internal data...
"./platform-tools/adb.exe" backup -v -f ./whatsapp-files/mywabkp.ab -apk com.whatsapp
echo backup shared data...
"./platform-tools/adb.exe" pull -a -Z /sdcard/WhatsApp/ ./whatsapp-files/shared/WhatsApp/
echo backup end
@cmd
