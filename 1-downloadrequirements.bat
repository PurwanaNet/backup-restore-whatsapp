@echo off
if exist ./platform-tools/ (
goto :CheckCountPlatforms
) else (
goto :DownloadAndUnZipFile
)

:CheckCountPlatforms
dir /a:-d /s /b "./platform-tools"> tmp
set "NUM=0"
for /F %%N in ('find /C ":" ^< tmp') do (set "NUM=%%N")
del tmp
set expectedsz=1700
if /i %NUM% LSS %expectedsz% (
	echo unexpected number of file
 	goto :DownloadAndUnZipFile
) else (
	echo skip download
	pause
	goto :Ending
)

:DownloadAndUnZipFile
echo DownloadAndUnZipFile
setlocal
set "dnld=bitsadmin /transfer myDownloadJob /download /priority normal"
%dnld% "https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip" %cd%\platform-tools_r31.0.3-windows.zip
cd /d %~dp0
Call :UnZipFile "%cd%" "%cd%\platform-tools_r31.0.3-windows.zip"
pause
goto :Ending


:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%

:Ending
@cmd
