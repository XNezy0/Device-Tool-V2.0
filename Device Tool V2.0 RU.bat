@echo off
chcp 65001 >nul
title Device Tool V2.0
color 0A
cls

:menu
cls
type lang\ru.txt
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
echo Поиск устройств...
echo.
echo [15 секунд]
echo.
adb\adb devices > temp\devices.txt
set /a count=0
:loop
cls
echo.
echo Поиск устройств...
echo.
set /a remaining=15-%count%
echo Осталось: %remaining% секунд
echo.
type temp\devices.txt
findstr /R /C:"	device$" temp\devices.txt >nul
if errorlevel 1 (
    set /a count+=1
    if %count% GEQ 15 (
        cls
        echo.
        echo =============================================
        echo          УСТРОЙСТВО НЕ НАЙДЕНО!
        echo =============================================
        echo.
        echo Ошибка: Нет подключённых устройств.
        echo.
        echo Возможные причины:
        echo - USB-кабель не подключён
        echo - USB-отладка не включена
        echo - Драйвер не установлен
        echo - Устройство не авторизовано
        echo.
        echo Попробуйте снова или проверьте подключение.
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
    echo          УСТРОЙСТВО НАЙДЕНО!
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
echo          ПЕРЕПРОШИВКА УСТРОЙСТВА
echo =============================================
echo.
echo ВНИМАНИЕ: Это полностью перезапишет систему!
echo Убедитесь, что у вас есть правильный firmware.zip в папке files/
echo.
set /p confirm=Введите ДА для продолжения: 
if /i not "%confirm%"=="ДА" goto menu
echo.
echo Перепрошивка...
adb\fastboot flash all files\firmware.zip
echo.
pause
goto menu

:update
cls
echo.
echo Обновление прошивки...
adb\adb sideload files\firmware.zip
echo.
pause
goto menu

:unlock
cls
echo.
echo =============================================
echo          РАЗБЛОКИРОВКА ЗАГРУЗЧИКА
echo =============================================
echo.
echo ВНИМАНИЕ: Это СБРОСИТ телефон до заводских!
echo Все данные будут стёрты.
echo.
set /p confirm=Введите ДА для продолжения: 
if /i not "%confirm%"=="ДА" goto menu
echo.
echo Разблокировка загрузчика...
adb\fastboot oem unlock
echo.
pause
goto menu

:lock
cls
echo.
echo =============================================
echo          БЛОКИРОВКА ЗАГРУЗЧИКА
echo =============================================
echo.
echo ВНИМАНИЕ: Это СБРОСИТ телефон до заводских!
echo Все данные будут стёрты.
echo.
set /p confirm=Введите ДА для продолжения: 
if /i not "%confirm%"=="ДА" goto menu
echo.
echo Блокировка загрузчика...
adb\fastboot oem lock
echo.
pause
goto menu

:reset
cls
echo.
echo =============================================
echo          СБРОС ДО ЗАВОДСКИХ
echo =============================================
echo.
echo ВНИМАНИЕ: Это удалит ВСЕ данные на устройстве!
echo.
set /p confirm=Введите ДА для продолжения: 
if /i not "%confirm%"=="ДА" goto menu
echo.
echo Сброс...
adb\fastboot -w
echo.
pause
goto menu

:wipecache
cls
echo.
echo Очистка раздела кэша...
adb\fastboot erase cache
echo.
pause
goto menu

:bootloader
cls
echo.
echo Перезагрузка в bootloader...
adb\adb reboot bootloader
echo.
pause
goto menu

:recovery
cls
echo.
echo Перезагрузка в recovery...
adb\adb reboot recovery
echo.
pause
goto menu

:rebootsys
cls
echo.
echo Перезагрузка системы...
adb\adb reboot
echo.
pause
goto menu

:status
cls
echo.
echo Проверка статуса устройства...
adb\fastboot oem device-info
echo.
pause
goto menu

:info
cls
echo.
echo Информация об устройстве:
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
echo Статус батареи:
echo.
adb\adb shell dumpsys battery
echo.
pause
goto menu

:pull
cls
echo.
echo Вытащить файл с устройства...
echo.
set /p filepath=Введите путь к файлу (например /sdcard/Download/file.txt): 
adb\adb pull "%filepath%" files\
echo.
pause
goto menu

:push
cls
echo.
echo Закинуть файл на устройство...
echo.
set /p filename=Введите имя файла из папки files: 
adb\adb push files\%filename% /sdcard/
echo.
pause
goto menu

:backup
cls
echo.
echo Создание бэкапа...
echo.
adb\adb backup -apk -shared -all -system -f files\backup.ab
echo.
pause
goto menu

:restore
cls
echo.
echo Восстановление бэкапа...
adb\adb restore files\backup.ab
echo.
pause
goto menu

:logcat
cls
echo.
echo Сохранение логов...
adb\adb logcat -d > logs\logcat.txt
type logs\logcat.txt
echo.
pause
goto menu

:root
cls
echo.
echo Проверка root...
adb\adb shell su -c "echo Root access available" 2>nul
if errorlevel 1 echo Нет root доступа
echo.
pause
goto menu

:enableusb
cls
echo.
echo Включение USB-отладки...
adb\adb shell settings put global adb_enabled 1
echo.
pause
goto menu

:disableusb
cls
echo.
echo Выключение USB-отладки...
adb\adb shell settings put global adb_enabled 0
echo.
pause
goto menu

:uninstall
cls
echo.
echo Удаление приложения...
echo.
set /p package=Введите имя пакета (например com.example.app): 
adb\adb uninstall %package%
echo.
pause
goto menu

:connected
cls
echo.
echo Подключённые устройства:
adb\adb devices
echo.
pause
goto menu

:storage
cls
echo.
echo Свободное место:
adb\adb shell df -h
echo.
pause
goto menu

:off
cls
echo.
echo Выключение устройства...
adb\adb shell reboot -p
echo.
pause
goto menu

:androidver
cls
echo.
echo Версия Android:
adb\adb shell getprop ro.build.version.release
echo.
pause
goto menu

:security
cls
echo.
echo Патч безопасности:
adb\adb shell getprop ro.build.version.security_patch
echo.
pause
goto menu

:sysinfo
cls
echo.
echo Информация о системе:
adb\adb shell getprop
echo.
pause
goto menu

:opencmd
cls
echo.
echo Открытие CMD от имени Администратора...
powershell -Command "Start-Process cmd -Verb RunAs"
echo.
pause
goto menu

:adbserver
cls
echo.
echo =============================================
echo          УПРАВЛЕНИЕ ADB СЕРВЕРОМ
echo =============================================
echo.
echo [1] Остановить ADB сервер
echo [2] Запустить ADB сервер
echo.
set /p adbchoice=Выберите опцию: 
if "%adbchoice%"=="1" (
    echo.
    echo Остановка ADB сервера...
    adb\adb kill-server
    echo.
    pause
)
if "%adbchoice%"=="2" (
    echo.
    echo Запуск ADB сервера...
    adb\adb start-server
    echo.
    pause
)
goto menu

:listapps
cls
echo.
echo =============================================
echo          СПИСОК УСТАНОВЛЕННЫХ ПРИЛОЖЕНИЙ
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
echo          ПОЛНАЯ ИНФОРМАЦИЯ ОБ УСТРОЙСТВЕ
echo =============================================
echo.
echo --- Информация об устройстве ---
adb\adb shell getprop ro.product.model
adb\adb shell getprop ro.product.manufacturer
adb\adb shell getprop ro.build.version.release
adb\adb shell getprop ro.build.version.security_patch
adb\adb shell getprop ro.serialno
echo.
echo --- IMEI ---
adb\adb shell service call iphonesubinfo 1
echo.
echo --- MAC-адрес ---
adb\adb shell cat /sys/class/net/wlan0/address
echo.
echo --- Статус загрузчика ---
adb\adb shell getprop ro.boot.flash.locked
echo.
pause
goto menu

:browsefiles
cls
echo.
echo =============================================
echo          ПРОСМОТР ФАЙЛОВ
echo =============================================
echo.
set /p dirpath=Введите путь к папке (например /sdcard/Download/): 
echo.
echo Список файлов в %dirpath%:
adb\adb shell ls -la "%dirpath%"
echo.
pause
goto menu

:deletefile
cls
echo.
echo =============================================
echo          УДАЛЕНИЕ ФАЙЛА
echo =============================================
echo.
set /p filepath=Введите полный путь к файлу: 
echo.
echo Удаление %filepath%...
adb\adb shell rm "%filepath%"
if errorlevel 1 (
    echo Ошибка при удалении файла.
) else (
    echo Файл успешно удалён.
)
echo.
pause
goto menu

:renamefile
cls
echo.
echo =============================================
echo          ПЕРЕИМЕНОВАНИЕ ФАЙЛА
echo =============================================
echo.
set /p oldpath=Введите текущий полный путь: 
set /p newpath=Введите новый полный путь: 
echo.
echo Переименование...
adb\adb shell mv "%oldpath%" "%newpath%"
if errorlevel 1 (
    echo Ошибка при переименовании.
) else (
    echo Успешно переименован.
)
echo.
pause
goto menu

:createfolder
cls
echo.
echo =============================================
echo          СОЗДАНИЕ ПАПКИ
echo =============================================
echo.
set /p folderpath=Введите полный путь для новой папки: 
echo.
echo Создание %folderpath%...
adb\adb shell mkdir "%folderpath%"
if errorlevel 1 (
    echo Ошибка при создании папки.
) else (
    echo Папка успешно создана.
)
echo.
pause
goto menu

:fastbootd
cls
echo.
echo Перезагрузка в fastbootd...
adb\adb reboot fastboot
echo.
pause
goto menu

:downloadmode
cls
echo.
echo Перезагрузка в режим загрузки...
adb\adb reboot download
echo.
pause
goto menu

:launchscrcpy
cls
echo.
echo =============================================
echo          ЗАПУСК SCRCPY
echo =============================================
echo.
echo Запуск scrcpy... Убедитесь, что устройство подключено по USB и разблокировано.
echo.
if exist "scrcpy\scrcpy.exe" (
    scrcpy\scrcpy.exe --turn-screen-off --stay-awake
) else (
    echo ОШИБКА: scrcpy не найден в папке scrcpy!
    echo Скачайте scrcpy и поместите его в папку scrcpy.
    echo Скачать: https://github.com/Genymobile/scrcpy/releases
)
echo.
pause
goto menu

:restart
cls
echo.
echo =============================================
echo          ПЕРЕЗАПУСК ПРОГРАММЫ
echo =============================================
echo.
echo Перезапуск Device Tool V2.0...
timeout /t 2 >nul
start "" "%~f0"
exit

:diagnostics
cls
echo.
echo =============================================
echo          ПОЛНАЯ ДИАГНОСТИКА УСТРОЙСТВА
echo =============================================
echo.
echo Выполняется полная диагностика...
echo.

echo --- ИНФОРМАЦИЯ ОБ УСТРОЙСТВЕ ---
echo Модель:
adb\adb shell getprop ro.product.model
echo Производитель:
adb\adb shell getprop ro.product.manufacturer
echo Версия Android:
adb\adb shell getprop ro.build.version.release
echo Патч безопасности:
adb\adb shell getprop ro.build.version.security_patch
echo Серийный номер:
adb\adb shell getprop ro.serialno
echo.

echo --- ИНФОРМАЦИЯ О ПРОЦЕССОРЕ ---
echo Архитектура:
adb\adb shell getprop ro.product.cpu.abi
echo Ядра:
adb\adb shell cat /sys/devices/system/cpu/present
echo Губернатор:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo Текущая частота:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo Минимальная частота:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
echo Максимальная частота:
adb\adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
echo.

echo --- ТЕМПЕРАТУРА ---
echo Температура батареи:
adb\adb shell dumpsys battery | findstr "temperature"
echo Температура процессора:
adb\adb shell cat /sys/class/thermal/thermal_zone0/temp 2>nul
adb\adb shell cat /sys/class/thermal/thermal_zone1/temp 2>nul
adb\adb shell cat /sys/class/thermal/thermal_zone2/temp 2>nul
echo.

echo --- ИНФОРМАЦИЯ О БАТАРЕЕ ---
echo Уровень:
adb\adb shell dumpsys battery | findstr "level"
echo Максимальный уровень:
adb\adb shell dumpsys battery | findstr "scale"
echo Статус:
adb\adb shell dumpsys battery | findstr "status"
echo Здоровье:
adb\adb shell dumpsys battery | findstr "health"
echo Наличие:
adb\adb shell dumpsys battery | findstr "present"
echo Напряжение:
adb\adb shell dumpsys battery | findstr "voltage"
echo Технология:
adb\adb shell dumpsys battery | findstr "technology"
echo Зарядка от сети:
adb\adb shell dumpsys battery | findstr "AC powered"
echo Зарядка от USB:
adb\adb shell dumpsys battery | findstr "USB powered"
echo Беспроводная зарядка:
adb\adb shell dumpsys battery | findstr "Wireless powered"
echo.

echo --- ИНФОРМАЦИЯ О ПАМЯТИ (RAM) ---
echo Всего RAM:
adb\adb shell free -h | findstr "Mem:"
adb\adb shell dumpsys meminfo | findstr "Total RAM"
echo Доступно RAM:
adb\adb shell dumpsys meminfo | findstr "Free RAM"
echo.

echo --- ИНФОРМАЦИЯ О ХРАНИЛИЩЕ ---
echo Внутренняя память:
adb\adb shell df -h /data
echo Системная память:
adb\adb shell df -h /system
echo Кэш:
adb\adb shell df -h /cache
echo.

echo --- ИНФОРМАЦИЯ О ДИСПЛЕЕ ---
echo Разрешение:
adb\adb shell wm size
echo Плотность:
adb\adb shell wm density
echo.

echo --- ИНФОРМАЦИЯ О СЕТИ ---
echo Wi-Fi SSID:
adb\adb shell dumpsys wifi | findstr "SSID"
echo Сигнал Wi-Fi:
adb\adb shell dumpsys wifi | findstr "signalStrength"
echo IP-адрес:
adb\adb shell ip -f inet addr show wlan0
echo MAC-адрес:
adb\adb shell cat /sys/class/net/wlan0/address
echo.

echo --- ИНФОРМАЦИЯ О BLUETOOTH ---
echo Статус Bluetooth:
adb\adb shell settings get global bluetooth_on
echo.

echo --- СТАТУС СИСТЕМЫ ---
echo Статус загрузчика:
adb\adb shell getprop ro.boot.flash.locked
echo USB-отладка:
adb\adb shell settings get global adb_enabled
echo Root доступ:
adb\adb shell su -c "echo Root доступен" 2>nul
if errorlevel 1 echo Нет root доступа
echo.

echo --- ДАТЧИКИ ---
echo Акселерометр:
adb\adb shell dumpsys sensorservice | findstr "Accelerometer"
echo Гироскоп:
adb\adb shell dumpsys sensorservice | findstr "Gyroscope"
echo.

echo --- ИНФОРМАЦИЯ О КАМЕРЕ ---
echo Количество камер:
adb\adb shell dumpsys media.camera | findstr "Number of cameras"
echo.

echo --- ИНФОРМАЦИЯ О ЗВУКЕ ---
echo Статус аудио:
adb\adb shell dumpsys audio | findstr "mIsConnected"
echo.

echo =============================================
echo          ДИАГНОСТИКА ЗАВЕРШЕНА
echo =============================================
echo.
pause
goto menu