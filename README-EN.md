# Device Tool V2.0

**Device Tool V2.0** is a convenient tool for managing Android devices via ADB and Fastboot. It allows you to perform various operations, from device detection to flashing and file management.
---
## ❗ DISCLAIMER

The developer of Device Tool V2.0 is NOT LIABLE for any damage, data loss, device failure, or other consequences resulting from the use of this software.

You use the program AT YOUR OWN RISK. Before executing any commands, ensure you understand their purpose and the potential risks.
---

## 📁 Project Structure

```
Device Tool V2.0/
│
├── Device Tool V2.0 EN.bat # English version
├── Device Tool V2.0 RU.bat # Russian version
│
├── adb/ # ADB and Fastboot
│ ├── adb.exe
│ ├── AdbWinApi.dll
│ ├── AdbWinUsbApi.dll
│ └── fastboot.exe
│
├── scrcpy/ # Scrcpy (PC control)
│ └── scrcpy.exe
│
├── files/ # Firmware and backups
│ ├── firmware.zip
│ └── backup.ab
│
├── logs/ # Logs
│ └── logcat.txt
│
├── temp/ # Temporary files
│
└── lang/ # Menu files
├── en.txt
└── ru.txt
```

---

## 🚀 Launch

Run the desired version:
- **Device Tool V2.0 EN.bat** — for English
- **Device Tool V2.0 RU.bat** — for Russian Language

---

## 📋 Commands

| # | Command | Description |
|---|---------|-------------|
| 1 | Find device | Find connected device |
| 2 | Reflashing | Full system reflash (dangerous!) |
| 3 | Firmware update | Update firmware via sideload |
| 4 | Unlock bootloader | Unlock bootloader (wipes data!) |
| 5 | Lock bootloader | Lock bootloader (wipes data!) |
| 6 | Factory reset | Factory reset (erases everything!) |
| 7 | Wipe cache partition | Clear cache partition |
| 8 | Reboot to bootloader | Reboot to bootloader mode |
| 9 | Reboot to recovery | Reboot to recovery mode |
| 10 | Reboot system | Normal device reboot |
| 11 | Check device status | Check lock/unlock status |
| 12 | Show device info | Basic device information |
| 13 | Battery status | Battery status and health |
| 14 | Pull file from device | Pull file from device |
| 15 | Push file to device | Push file to device |
| 16 | Backup data | Create full backup |
| 17 | Restore data | Restore from backup |
| 18 | Show logcat | Show system logs |
| 19 | Check root status | Check root access |
| 20 | Enable USB debugging | Enable USB debugging |
| 21 | Disable USB debugging | Disable USB debugging |
| 22 | Uninstall app | Uninstall app by package name |
| 23 | Show connected devices | List connected devices |
| 24 | Check storage space | Free storage space |
| 25 | Turn off device | Power off the device |
| 26 | Check Android version | Android version |
| 27 | Check security patch | Security patch date |
| 28 | Dump system info | Full system property dump |
| 29 | Open CMD (Admin) | Open Command Prompt as Admin |
| 30 | ADB Server Control | ADB server management (Kill/Start) |
| 31 | Show installed apps list | List all installed apps |
| 32 | Show system info full | Extended device information |
| 33 | Browse files (list) | Browse files in a folder |
| 34 | Delete file on device | Delete file on device |
| 35 | Rename file on device | Rename file on device |
| 36 | Create folder on device | Create folder on device |
| 37 | Reboot to fastbootd | Reboot to fastbootd |
| 38 | Reboot to download mode | Reboot to download mode |
| 39 | Launch scrcpy | Launch scrcpy (PC control) |
| 40 | Restart program | Restart the program |
| 41 | Device diagnostics | **Full device diagnostics** |

---

## ⚠️ IMPORTANT WARNINGS

| Command | Risk |
|---------|------|
| **2** (Reflashing) | Complete system reflash - high risk of bricking |
| **4** (Unlock bootloader) | Resets the phone to factory settings, voids the warranty |
| **5** (Lock bootloader) | Resets the phone to factory settings |
| **6** (Factory reset) | Erases all data from the phone |

**Before using these commands, make sure you know what you're doing!**

---

## 🔧 Requirements

- Windows 7 / 8 / 10 / 11
- A connected Android device with USB debugging enabled

---

## 🛠 How to enable USB debugging

1. Go to **Settings → About phone**
2. Tap **Build number** 7 times
3. Return to **Settings → Developer options**
4. Enable **USB debugging**

---

## ❗ DISCLAIMER

The developer of Device Tool V2.0 is NOT LIABLE for any damage, data loss, device failure, or other consequences resulting from the use of this software.

You use the program AT YOUR OWN RISK. Before executing any commands, make sure you understand their purpose and possible risks.