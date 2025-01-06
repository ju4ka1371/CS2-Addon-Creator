@ECHO OFF
chcp 65001
title [CS2 Addon Creator] - Hello... 
color 03
mode con:cols=90 lines=20
@cls
echo.
echo.
@echo          a88888b. .d88888b  d8888b.     .d888888        dP       dP                   
@echo         d8'   `88 88.    "'     `88    d8'    88        88       88                   
@echo         88        `Y88888b. .aaadP'    88aaaaa88a .d888b88 .d888b88 .d8888b. 88d888b. 
@echo         88              `8b 88'        88     88  88'  `88 88'  `88 88'  `88 88'  `88 
@echo         Y8.   .88 d8'   .8P 88.        88     88  88.  .88 88.  .88 88.  .88 88    88 
@echo          Y88888P'  Y88888P  Y88888P    88     88  `88888P8 `88888P8 `88888P' dP    dP 
@echo.                                                                                       
@echo.                                                                                       
@echo          a88888b.                              dP                     
@echo         d8'   `88                              88                     
@echo         88        88d888b. .d8888b. .d8888b. d8888P .d8888b. 88d888b. 
@echo         88        88'  `88 88ooood8 88'  `88   88   88'  `88 88'  `88 
@echo         Y8.   .88 88       88.  ... 88.  .88   88   88.  .88 88       
@echo          Y88888P' dP       `88888P' `88888P8   dP   `88888P' dP       
@echo.  
@echo. 
@echo                             by Ju4qa from Ukraine...
echo.
timeout /t 3 >nul

cls
del /q "%CD%\workshop.vdf" > nul
del /q "%CD%\arc.zip" > nul
del /q "%CD%\workshop.txt" > nul
del /q "%CD%\csgo_addons\temp" > nul
cls
color 0F

title [CS2 Addon Creator] - Archive creation... 

@echo Did you put the files in the "csgo_addons" folder?
echo.
echo 1. Yes. Files in the folder.
echo 2. No.
echo.
choice /c 12 /m "Select an option"
if errorlevel 2 goto errlvl1
if errorlevel 1 goto errlvl2

:errlvl1
@cls
echo Place the files in the "csgo_addons" folder and restart the program. 
@Echo off
timeout /t 5 && exit

:errlvl2
cls
Echo Please wait. Archive creation in progress...
"%CD%/7z/7za.exe" a arc.zip "%CD%\csgo_addons\*" 
timeout /t 3 >nul
cls
echo Archive successfully created!
timeout /t 3 >nul
cls
title [CS2 Addon Creator] - Creating a workshop.vdf... 
set contentfolder=%CD%\arc.zip
Echo Select the addon image.
Echo ONLY .png / .jpg / .bmp !!!
Echo Valve recommends resolution: 555x312.
Echo (I don't know why it's so weird...)
timeout /t 5 >nul
for /f "usebackq delims=" %%i in (
 `@"%systemroot%\system32\mshta.exe" "about:<FORM><INPUT type='file' name='qq'></FORM><script>document.forms[0].elements[0].click();var F=document.forms[0].elements[0].value;try {new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(F)};catch (e){};close();</script>" ^
 1^|more`
) do set sFileName=%%i
chcp %sPrevCP% >nul
if defined sFileName (
  goto SelectImg   
) else (
  goto noSelectImg 
)

:noSelectImg
cls
Echo You have not selected an image.
timeout /t 5 && exit

:SelectImg 
cls
echo The path to the image is saved! 
timeout /t 2 >nul


cls

set /p addonName=Set the addon name: 
Echo Done!
timeout /t 2 >nul

cls

set /p addonDescription=Set the addon description (DO NOT USE ANY LINKS!): 
Echo Done!
timeout /t 2 >nul

cls

Echo Generating workshop.vdf...
timeout /t 1 >nul
(
echo "workshopitem"
echo {
echo   "appid" "730"  
echo   "contentfolder" "%contentfolder%"
echo   "previewfile" "%sFileName%"
echo   "visibility" "2"  
echo   "title" "%addonName%"
echo   "description" "%addonDescription%"
echo }
) > workshop.txt
ren workshop.txt workshop.vdf
Echo Done!
timeout /t 2 >nul

cls
title [CS2 Addon Creator] - Uploading addon to workshop...
set /p steamLogin=Set the Steam login: 
"%cd%/steamcmd/steamcmd.exe" +login %steamLogin% +workshop_build_item "%CD%/workshop.vdf"






