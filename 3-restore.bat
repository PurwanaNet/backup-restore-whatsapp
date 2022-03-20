@echo off
echo %cd%
echo preparing restore.. 
echo pindahkan sim card dan sd card ke device baru
echo pastikan sudah terhubung dgn smartphone mode developer + usb debugging = on
pause
echo restore internal data
"./platform-tools/adb.exe" restore ./whatsapp-files/mywabkp.ab
echo restore shared data
"./platform-tools/adb.exe" push -Z ./whatsapp-files/shared/WhatsApp/ /sdcard/
echo restore end
@cmd
