@echo off
chcp 65001 >nul
title Device Tool V2.0
color 0A
cls

:menu
cls
type lang\en.txt
set /p choice=

if "%choice%"=="0" exit
if "%choice%"=="1" goto find
if "%choice%"=="2" goto reflash
if "%choice%"=="3" goto update
if "%choice%"=="4" goto unlock
if "%choice%"=="5" goto lock
if "%choice%"=="6" goto reset
if "%choice%"=="7" goto wipecache
if "%choice%"=="8" goto bootloader
if "%choice%"=="9" goto recovery
if "%choice%"=="10" goto rebootsys
if "%choice%"=="11" goto status
if "%choice%"=="12" goto info
if "%choice%"=="13" goto battery
if "%choice%"=="14" goto pull
if "%choice%"=="15" goto push
if "%choice%"=="16" goto backup
if "%choice%"=="17" goto restore
if "%choice%"=="18" goto logcat
if "%choice%"=="19" goto root
if "%choice%"=="20" goto enableusb
if "%choice%"=="21" goto disableusb
if "%choice%"=="22" goto uninstall
if "%choice%"=="23" goto connected
if "%choice%"=="24" goto storage
if "%choice%"=="25" goto off
if "%choice%"=="26" goto androidver
if "%choice%"=="27" goto security
if "%choice%"=="28" goto sysinfo
if "%choice%"=="29" goto opencmd
if "%choice%"=="30" goto adbserver
if "%choice%"=="31" goto listapps
if "%choice%"=="32" goto sysinfofull
if "%choice%"=="33" goto browsefiles
if "%choice%"=="34" goto deletefile
if "%choice%"=="35" goto renamefile
if "%choice%"=="36" goto createfolder
if "%choice%"=="37" goto fastbootd
if "%choice%"=="38" goto downloadmode
if "%choice%"=="39" goto launchscrcpy
if "%choice%"=="40" goto restart
if "%choice%"=="41" goto diagnostics
goto menu

:find
cls
echo.
echo Searching for devices...
echo.
echo [15 seconds timeout]
echo.
adb\adb devices > temp\devices.txt
set /a count=0
:loop
cls
echo.
echo Searching for devices...
echo.
set /a remaining=15-%count%
echo Time remaining: %remaining% seconds
echo.
type temp\devices.txt
findstr /R /C:"	device$" temp\devices.txt >nul
if errorlevel 1 (
    set /a count+=1
    if %count% GEQ 15 (
        cls
        echo.
        echo =============================================
        echo          DEVICE NOT FOUND!
        echo =============================================
        echo.
        echo Error: No devices/emulators found.
        echo.
        echo Possible reasons:
        echo - USB cable not connected
        echo - USB debugging not enabled
        echo - Driver not installed
        echo - Device not authorized
        echo.
        echo Try again or check connection.
        echo.
        del temp\devices.txt >nul 2>nul
        pause
        goto menu
    )
    timeout /t 1 /nobreak >nul
    goto loop
) else (
    cls
    echo.
    echo =============================================
    echo          DEVICE FOUND!
    echo =============================================
    echo.
    type temp\devices.txt
    echo.
    del temp\devices.txt >nul 2>nul
    pause
    goto menu
)

:reflash
cls
echo.
echo =============================================
echo          REFLASHING DEVICE
echo =============================================
echo.
echo WARNING: This will completely overwrite the system!
echo Make sure you have a valid firmware.zip in files/
echo.
set /p confirm=Type YES to continue: 
if /i not "%confirm%"=="YES" goto menu
echo.
echo Reflashing device...
adb\fastboot flash all files\firmware.zip
echo.
pause
goto menu

:update
cls
echo.
echo Updating firmware...
adb\adb sideload files\firmware.zip
echo.
pause
goto menu

:unlock
cls
echo.
echo =============================================
echo          UNLOCK BOOTLOADER
echo =============================================
echo.
echo WARNING: This will FACTORY RESET your device!
echo All data will be erased.
echo.
set /p confirm=Type YES to continue: 
if /i not "%confirm%"=="YES" goto menu
echo.
echo Unlocking bootloader...
adb\fastboot oem unlock
echo.
pause
goto menu

:lock
cls
echo.
echo =============================================
echo          LOCK BOOTLOADER
echo =============================================
echo.
echo WARNING: This will FACTORY RESET your device!
echo All data will be erased.
echo.
set /p confirm=Type YES to continue: 
if /i not "%confirm%"=="YES" goto menu
echo.
echo Locking bootloader...
adb\fastboot oem lock
echo.
pause
goto menu

:reset
cls
echo.
echo =============================================
echo          FACTORY RESET
echo =============================================
echo.
echo WARNING: This will erase ALL data on the device!
echo.
set /p confirm=Type YES to continue: 
if /i not "%confirm%"=="YES" goto menu
echo.
echo Factory resetting...
adb\fastboot -w
echo.
pause
goto menu

:wipecache
cls
echo.
echo Wiping cache partition...
adb\fastboot erase cache
echo.
pause
goto menu

:bootloader
cls
echo.
echo Rebooting to bootloader...
adb\adb reboot bootloader
echo.
pause
goto menu

:recovery
cls
echo.
echo Rebooting to recovery...
adb\adb reboot recovery
echo.
pause
goto menu

:rebootsys
cls
echo.
echo Rebooting system...
adb\adb reboot
echo.
pause
goto menu

:status
cls
echo.
echo Checking device status...
adb\fastboot oem device-info
echo.
pause
goto menu

:info
cls
echo.
echo Device info:
echo.
adb\adb shell getprop ro.product.model
adb\adb shell getprop ro.product.manufacturer
adb\adb shell getprop ro.build.version.release
adb\adb shell getprop ro.serialno
echo.
pause
goto menu

:battery
cls
echo.
echo Battery status:
echo.
adb\adb shell dumpsys battery
echo.
pause
goto menu

:pull
cls
echo.
echo Pulling file from device...
echo.
set /p filepath=Enter file path on device (e.g. /sdcard/Download/file.txt): 
adb\adb pull "%filepath%" files\
echo.
pause
goto menu

:push
cls
echo.
echo Pushing file to device...
echo.
set /p filename=Enter filename from files folder: 
adb\adb push files\%filename% /sdcard/
echo.
pause
goto menu

:backup
cls
echo.
echo Creating backup...
echo.
adb\adb backup -apk -shared -all -system -f files\backup.ab
echo.
pause
goto menu

:restore
cls
echo.
echo Restoring backup...
adb\adb restore files\backup.ab
echo.
pause
goto menu

:logcat
cls
echo.
echo Saving logcat...
adb\adb logcat -d > logs\logcat.txt
type logs\logcat.txt
echo.
pause
goto menu

:root
cls
echo.
echo Checking root status...
adb\adb shell su -c "echo Root access available" 2>nul
if errorlevel 1 echo No root access
echo.
pause
goto menu

:enableusb
cls
echo.
echo Enabling USB debugging...
adb\adb shell settings put global adb_enabled 1
echo.
pause
goto menu

:disableusb
cls
echo.
echo Disabling USB debugging...
adb\adb shell settings put global adb_enabled 0
echo.
pause
goto menu

:uninstall
cls
echo.
echo Uninstalling app...
echo.
set /p package=Enter package name (e.g. com.example.app): 
adb\adb uninstall %package%
echo.
pause
goto menu

:connected
cls
echo.
echo Connected devices:
adb\adb devices
echo.
pause
goto menu

:storage
cls
echo.
echo Storage space:
adb\adb shell df -h
echo.
pause
goto menu

:off
cls
echo.
echo Turning off device...
adb\adb shell reboot -p
echo.
pause
goto menu

:androidver
cls
echo.
echo Android version:
adb\adb shell getprop ro.build.version.release
echo.
pause
goto menu

:security
cls
echo.
echo Security patch:
adb\adb shell getprop ro.build.version.security_patch
echo.
pause
goto menu

:sysinfo
cls
echo.
echo System info:
adb\adb shell getprop
echo.
pause
goto menu

:opencmd
cls
echo.
echo Opening CMD as Administrator...
powershell -Command "Start-Process cmd -Verb RunAs"
echo.
pause
goto menu

:adbserver
cls
echo.
echo =============================================
echo          ADB SERVER CONTROL
echo =============================================
echo.
echo [1] Kill ADB Server
echo [2] Start ADB Server
echo.
set /p adbchoice=Select option: 
if "%adbchoice%"=="1" (
    echo.
    echo Killing ADB server...
    adb\adb kill-server
    echo.
    pause
)
if "%adbchoice%"=="2" (
    echo.
    echo Starting ADB server...
    adb\adb start-server
    echo.
    pause
)
goto menu

:listapps
cls
echo.
echo =============================================
echo          INSTALLED APPS LIST
echo =============================================
echo.
adb\adb shell pm list packages
echo.
pause
goto menu

:sysinfofull
cls
echo.
echo =============================================
echo          FULL SYSTEM INFO
echo =============================================
echo.
echo --- Device Info ---
adb\adb shell getprop ro.product.model
adb\adb shell getprop ro.product.manufacturer
adb\adb shell getprop ro.build.version.release
adb\adb shell getprop ro.build.version.security_patch
adb\adb shell getprop ro.serialno
echo.
echo --- IMEI ---
adb\adb shell service call iphonesubinfo 1
echo.
echo --- MAC Address ---
adb\adb shell cat /sys/class/net/wlan0/address
echo.
echo --- Bootloader Status ---
adb\adb shell getprop ro.boot.flash.locked
echo.
pause
goto menu

:browsefiles
cls
echo.
echo =============================================
echo          BROWSE FILES
echo =============================================
echo.
set /p dirpath=Enter folder path (e.g. /sdcard/Download/): 
echo.
echo Listing files in %dirpath%:
adb\adb shell ls -la "%dirpath%"
echo.
pause
goto menu

:deletefile
cls
echo.
echo =============================================
echo          DELETE FILE
echo =============================================
echo.
set /p filepath=Enter full path to file: 
echo.
echo Deleting %filepath%...
adb\adb shell rm "%filepath%"
if errorlevel 1 (
    echo Error deleting file.
) else (
    echo File deleted successfully.
)
echo.
pause
goto menu

:renamefile
cls
echo.
echo =============================================
echo          RENAME FILE
echo =============================================
echo.
set /p oldpath=Enter current full path: 
set /p newpath=Enter new full path: 
echo.
echo Renaming...
adb\adb shell mv "%oldpath%" "%newpath%"
if errorlevel 1 (
    echo Error renaming.
) else (
    echo Successfully renamed.
)
echo.
pause
goto menu

:createfolder
cls
echo.
echo =============================================
echo          CREATE FOLDER
echo =============================================
echo.
set /p folderpath=Enter full path for new folder: 
echo.
echo Creating %folderpath%...
adb\adb shell mkdir "%folderpath%"
if errorlevel 1 (
    echo Error creating folder.
) else (
    echo Folder created successfully.
)
echo.
pause
goto menu

:fastbootd
cls
echo.
echo Rebooting to fastbootd...
adb\adb reboot fastboot
echo.
pause
goto menu

:downloadmode
cls
echo.
echo Rebooting to Download Mode...
adb\adb reboot download
echo.
pause
goto menu

:launchscrcpy
cls
echo.
echo =============================================
echo          LAUNCHING SCRCPY
echo =============================================
echo.
echo Starting scrcpy... Make sure your device is connected via USB and unlocked.
echo.
if exist "scrcpy\scrcpy.exe" (
    scrcpy\scrcpy.exe --turn-screen-off --stay-awake
) else (
    echo ERROR: scrcpy not found in scrcpy folder!
    echo Please download scrcpy and place it in the scrcpy folder.
    echo Download: https://github.com/Genymobile/scrcpy/releases
)
echo.
pause
goto menu

:restart
cls
echo.
echo =============================================
echo          RESTARTING PROGRAM
echo =============================================
echo.
echo Restarting Device Tool V2.0...
timeout /t 2 >nul
start "" "%~f0"
exit

:diagnostics
cls
echo.
echo =============================================
echo          FULL DEVICE DIAGNOSTICS
echo =============================================
echo.
echo Running comprehensive diagnostics...
echo.

echo --- DEVICE INFO ---
echo Model:
adb\adb shell getprop ro.product.model
echo Manufacturer:
adb\adb shell getprop ro.product.manufacturer
echo Android Version:
adb\adb shell getprop ro.build.version.release
echo Security Patch:
adb\adb shell getprop ro.build.version.security_patch
echo Serial Number:
adb\adb shell getprop ro.serialno
echo.

echo --- CPU INFO ---
echo CPU Architecture:
adb\adb shell getprop ro.product.cpu.abi
echo CPU Cores:
adb\adb shell cat /sys/devices/system/cpu/present
echo CPU Governor:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo CPU Current Frequency:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo CPU Min Frequency:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
echo CPU Max Frequency:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
echo.

echo --- TEMPERATURE ---
echo Battery Temperature:
adb\adb shell dumpsys battery | findstr "temperature"
echo CPU Temperature:
adb\adb shell cat /sys/class/thermal/thermal_zone0/temp 2>nul
adb\adb shell cat /sys/class/thermal/thermal_zone1/temp 2>nul
adb\adb shell cat /sys/class/thermal/thermal_zone2/temp 2>nul
echo.

echo --- BATTERY INFO ---
echo Level:
adb\adb shell dumpsys battery | findstr "level"
echo Scale:
adb\adb shell dumpsys battery | findstr "scale"
echo Status:
adb\adb shell dumpsys battery | findstr "status"
echo Health:
adb\adb shell dumpsys battery | findstr "health"
echo Present:
adb\adb shell dumpsys battery | findstr "present"
echo Voltage:
adb\adb shell dumpsys battery | findstr "voltage"
echo Technology:
adb\adb shell dumpsys battery | findstr "technology"
echo AC Powered:
adb\adb shell dumpsys battery | findstr "AC powered"
echo USB Powered:
adb\adb shell dumpsys battery | findstr "USB powered"
echo Wireless Powered:
adb\adb shell dumpsys battery | findstr "Wireless powered"
echo.

echo --- MEMORY (RAM) INFO ---
echo Total RAM:
adb\adb shell free -h | findstr "Mem:"
adb\adb shell dumpsys meminfo | findstr "Total RAM"
echo Available RAM:
adb\adb shell dumpsys meminfo | findstr "Free RAM"
echo.

echo --- STORAGE INFO ---
echo Internal Storage:
adb\adb shell df -h /data
echo System Storage:
adb\adb shell df -h /system
echo Cache Storage:
adb\adb shell df -h /cache
echo.

echo --- DISPLAY INFO ---
echo Resolution:
adb\adb shell wm size
echo Density:
adb\adb shell wm density
echo.

echo --- NETWORK INFO ---
echo Wi-Fi SSID:
adb\adb shell dumpsys wifi | findstr "SSID"
echo Wi-Fi Signal:
adb\adb shell dumpsys wifi | findstr "signalStrength"
echo IP Address:
adb\adb shell ip -f inet addr show wlan0
echo MAC Address:
adb\adb shell cat /sys/class/net/wlan0/address
echo.

echo --- BLUETOOTH INFO ---
echo Bluetooth Status:
adb\adb shell settings get global bluetooth_on
echo.

echo --- SYSTEM STATUS ---
echo Bootloader Status:
adb\adb shell getprop ro.boot.flash.locked
echo USB Debugging:
adb\adb shell settings get global adb_enabled
echo Root Status:
adb\adb shell su -c "echo Root available" 2>nul
if errorlevel 1 echo No root access
echo.

echo --- SENSORS ---
echo Accelerometer:
adb\adb shell dumpsys sensorservice | findstr "Accelerometer"
echo Gyroscope:
adb\adb shell dumpsys sensorservice | findstr "Gyroscope"
echo.

echo --- CAMERA INFO ---
echo Camera Count:
adb\adb shell dumpsys media.camera | findstr "Number of cameras"
echo.

echo --- AUDIO INFO ---
echo Audio Status:
adb\adb shell dumpsys audio | findstr "mIsConnected"
echo.

echo =============================================
echo          DIAGNOSTICS COMPLETE
echo =============================================
echo.
pause
goto menu