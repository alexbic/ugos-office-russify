# Русификация Online Office — UGREEN NAS (UGOS Pro)

**English version below** ↓

---

## Описание

**Online Office** на UGREEN NAS — это обёртка над **OnlyOffice**. Русский язык в OnlyOffice встроен изначально, но по умолчанию недоступен на устройствах, где русский не предусмотрен как язык интерфейса. Скрипт активирует уже существующую локализацию.

После установки:
- Интерфейс обёртки Online Office — на русском
- Редактор документов, таблиц и презентаций OnlyOffice — на русском

**Тестировалось на:** DXP4800PLUS, UGOS Pro 1.15.1.0127, приложение Mac 1.15.0.77685

## Установка

### 1. Установить Online Office

Откройте App Center в UGOS → найдите **Online Office** → установите.

### 2. Запустить скрипт на NAS

Скачайте `install.sh` и загрузите на NAS:

```bash
# На Mac — загрузка скрипта на NAS
ssh admin@ваш-nas.local 'cat > ~/install.sh' < install.sh

# В SSH-сессии на NAS
sudo bash ~/install.sh
```

### 3. Очистить кеш на Mac

```bash
rm -rf "$HOME/Library/UGREEN_Nas_Pro/.cache/office/"
rm -rf "$HOME/Library/Application Support/com.ugreen.desktop/Cache/Cache_Data/"
```

### 4. Перезапустить приложение UGREEN NAS

Полностью закройте и откройте снова.

## Важно

> Скрипт изменяет файлы приложения. После обновления Online Office русификацию потребуется применить заново. Все изменённые файлы сохраняются с резервной копией `.bak`.

## Файлы

| Файл | Описание |
|------|----------|
| `install.sh` | Скрипт русификации (запускать на NAS с sudo) |
| `locale/ru-RU.json` | Файл локализации (создаётся скриптом автоматически) |

## Подробная инструкция

[alexbic.net/ugos-office-ru](https://alexbic.net/ugos-office-ru)

---

## Description (English)

**Online Office** on UGREEN NAS is a wrapper around **OnlyOffice**. Russian localization is built into OnlyOffice but disabled by default on devices where Russian is not a system language. This script enables the existing localization.

After installation:
- Online Office wrapper UI — in Russian
- OnlyOffice document, spreadsheet, and presentation editor — in Russian

**Tested on:** DXP4800PLUS, UGOS Pro 1.15.1.0127, Mac app 1.15.0.77685

## Installation

### 1. Install Online Office

Open App Center in UGOS → find **Online Office** → install it.

### 2. Run the script on NAS

Download `install.sh` and upload it to NAS:

```bash
# On Mac — upload script to NAS
ssh admin@your-nas.local 'cat > ~/install.sh' < install.sh

# In your SSH session on NAS
sudo bash ~/install.sh
```

### 3. Clear cache on Mac

```bash
rm -rf "$HOME/Library/UGREEN_Nas_Pro/.cache/office/"
rm -rf "$HOME/Library/Application Support/com.ugreen.desktop/Cache/Cache_Data/"
```

### 4. Restart the UGREEN NAS app

Quit and reopen.

## Important

> The script modifies app files. After updating Online Office, you will need to re-apply the russification. All modified files are backed up with the `.bak` extension.

## Detailed guide

[alexbic.net/ugos-office-ru](https://alexbic.net/ugos-office-ru)
