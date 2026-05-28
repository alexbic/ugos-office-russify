#!/bin/bash
# ============================================================
# Русификация UGREEN NAS Online Office (UGOS Pro)
# Автор: Alexander Bikmukhametov | alexbic.net
# Тестировано: DXP4800PLUS, UGOS Pro 6.x
# ============================================================
# Запуск: sudo bash install.sh
# ============================================================

set -e

LOCALE_DIR="/volume1/@appstore/com.ugreen.office/www/locale"
OFFICE_CONFIG="/volume1/@appstore/com.ugreen.office/config.json"
API_JS="/volume1/@appstore/com.ugreen.office/onlyoffice/documentserver/web-apps/apps/api/documents/api.js"

echo "=== Русификация UGOS Online Office ==="
echo ""

# --- Шаг 1: Создаём ru-RU.json ---
echo "[1/6] Создаём файл локализации ru-RU.json..."

python3 - << 'PYEOF'
import json, gzip, os

locale_dir = "/volume1/@appstore/com.ugreen.office/www/locale"

ru_locale = {
    "files": {
        "document": "Документ", "recentOpen": "Недавно открытые",
        "recentEdit": "Недавно редактированные", "operate": "Действия",
        "openEmpty": "Файл не открыт", "collectEmpty": "Нет документов",
        "inputPlaceholder": "Введите", "position": "Расположение",
        "fileSize": "Размер", "editTime": "Дата изменения",
        "createTime": "Дата создания", "open": "Открыть",
        "collect": "В избранное", "cancelCollect": "Убрать из избранного",
        "rename": "Переименовать", "download": "Скачать",
        "nameExist": "Имя уже существует",
        "required": "Имя файла не может быть пустым",
        "deleteRecord": "Удалить записи", "deleteFile": "Удалить файл",
        "information": "Информация",
        "cannotOperate": "Документ не найден или доступ запрещён",
        "clearFromList": "Убрать из списка", "complete": "Готово",
        "fileNameErr": "Имя файла не может содержать: /\\\"|:*?<>",
        "close": "Закрыть",
        "editTips": "Online Office не синхронизирует изменения из других приложений в реальном времени.",
        "deleteRecordTips": "Удалить выбранные записи?",
        "deleteFromNAS": "Удалить исходные файлы с NAS",
        "deleteFromNASConfirm": "Удалить этот файл с NAS?",
        "openFailTips": "Не удалось открыть. Проверьте права доступа."
    },
    "layout": {
        "recentOpen": "Недавно открытые", "collect": "Избранное",
        "createBtn": "Новый документ", "open": "Открыть",
        "setting": "Настройки", "document": "Документ",
        "xlsx": "Таблица", "ppt": "Презентация",
        "formTemplates": "Шаблоны", "fromNas": "С NAS",
        "fromLocalDevice": "С локального устройства",
        "fromLocalTip": "Открыть файл после загрузки с устройства",
        "searchPlaceholder": "Поиск", "loading": "Загрузка...",
        "fileSizeLimit": "Файл слишком большой. Ограничение: {size} МБ",
        "uploadFileError": "Не удалось загрузить",
        "selectDefaultPathPlaceholder": "Выберите",
        "defaultSavePathIsInvalid": "Недопустимый путь",
        "tips": "Подсказки",
        "defaultSavePath": "Путь сохранения по умолчанию",
        "pleaseConfigDefaultSavePath": "Сначала настройте путь сохранения",
        "operateSuccess": "Операция выполнена успешно",
        "selfFolder": "Личная папка", "shareFolder": "Общая папка",
        "userFolder": "Папка пользователя",
        "exceedLimit": "Превышено максимальное количество: {limit}",
        "typeError": "Формат не поддерживается",
        "ignoreErrorFile": "Пропущены файлы неподдерживаемых форматов",
        "openConfirm": "Открыть документ в браузере",
        "doNotShow": "Больше не показывать",
        "invalidSkipped": "Недопустимые файлы пропущены",
        "selectFile": "Выбрать файл",
        "selectPath": "Выбрать расположение",
        "modal": {"okText": "ОК"}
    },
    "setting": {
        "delete": "Удалить",
        "deleteLoadingTips": "Удаление выполняется, не закрывайте приложение",
        "deleteTips": "После удаления шрифтов будет использоваться шрифт по умолчанию",
        "exceedLimit": "Превышено максимальное количество пакетов шрифтов: {0}",
        "exceedSize": "Ограничение размера пакета шрифтов: {0} МБ",
        "fontAccept": "Поддерживается импорт шрифтов: otf, otc, ttc, ttf",
        "fontImport": "Импорт шрифта",
        "fontListHeadTitle": "Название шрифта ({0})",
        "importFail": "Не удалось импортировать",
        "importFailDetail": "Не удалось импортировать следующие шрифты:",
        "importFinish": "Импорт завершён",
        "importFontAgree": "Я согласен с «{0}» и гарантирую наличие прав на использование шрифтов",
        "importTips": "Не открывайте документы в процессе импорта шрифтов",
        "invalidFile": "Недопустимый файл",
        "localUpload": "С компьютера", "nasUpload": "С NAS",
        "uploading": "Загрузка",
        "uploadingTips": "Импорт выполняется, не закрывайте приложение",
        "userAgreement": "Пользовательское соглашение",
        "importApiFail": "Превышено время ожидания сети",
        "deleteError": "Превышено время ожидания при удалении"
    },
    "fileSelect": {
        "cancel": "Отмена", "createFolder": "Создать папку",
        "file": "Файл", "folder": "Папка",
        "available": "Доступно", "refresh": "Обновить",
        "inputError": "Ошибка ввода",
        "fileRootMenu": {
            "selfFolder": "Личная папка", "shareFolder": "Общая папка",
            "userFolder": "Папки пользователей", "labelFolder": "Метки",
            "collectFolder": "Избранное", "deviceFolder": "Устройства",
            "isoFolder": "ISO образы", "netFolder": "Сетевые диски",
            "safeBox": "Хранилище", "shareItems": "Доступ", "usbFolder": "USB"
        },
        "fileList": {"folderIsEmpty": "Папка пуста"},
        "fileTableHeader": {
            "name": "Имя", "size": "Размер", "type": "Тип",
            "modifyTime": "Изменён", "createTime": "Создан", "lastVisitTime": "Открыт"
        },
        "fileTools": {
            "sort": "Сортировка", "view": "Вид",
            "sortName": "По имени", "sortSize": "По размеру",
            "sortType": "По типу", "sortAlterDate": "По дате изменения",
            "sortCreateDate": "По дате создания", "lastVisitTime": "По дате открытия",
            "fromBigToSmall": "По убыванию", "fromSmallToBig": "По возрастанию",
            "viewList": "Список", "viewLargeIcon": "Крупные значки"
        },
        "folderCreate": {
            "title": "Создать папку", "okText": "Создать",
            "placeholder": "Введите имя папки",
            "fileExist": "Папка уже существует",
            "failCreate": "Не удалось создать папку",
            "longName": "Слишком длинное имя",
            "noFreeSpace": "Недостаточно места",
            "fileNameErr": "Недопустимые символы в имени"
        },
        "layout": {"fileTotal": "Всего: {0}", "selectedCount": "Выбрано: {0}"},
        "noStorage": {
            "tips": "Нет доступных хранилищ",
            "content": "Пожалуйста, подключите хранилище",
            "userTips": "Нет доступных папок"
        },
        "from": {"text": "Из"},
        "directoryType": {"recycle": "Корзина"},
        "supplement": {
            "connectError": "Ошибка подключения",
            "connectIsRefused": "Подключение отклонено",
            "emptyMounted": "Нет подключённых дисков",
            "filenameNotEmpty": "Имя файла не может быть пустым"
        },
        "folderSettingByAuthority": {
            "hideSpecifiedFileTip": "Некоторые файлы скрыты"
        }
    }
}

path = os.path.join(locale_dir, "ru-RU.json")
with open(path, 'w') as f:
    json.dump(ru_locale, f, ensure_ascii=False)
with open(path, 'rb') as fin:
    with gzip.open(path + '.gz', 'wb') as fout:
        fout.write(fin.read())
print("  ru-RU.json создан")
PYEOF

# --- Шаг 2: Скрываем en-US locale ---
echo "[2/6] Скрываем en-US locale..."
[ -f "$LOCALE_DIR/en-US.json" ] && mv "$LOCALE_DIR/en-US.json" "$LOCALE_DIR/en-US.json.bak"
[ -f "$LOCALE_DIR/en-US.json.gz" ] && mv "$LOCALE_DIR/en-US.json.gz" "$LOCALE_DIR/en-US.json.gz.bak"
echo "  Готово"

# --- Шаг 3: Патч ugos-framework ---
echo "[3/6] Патч ugos-framework..."

python3 - << 'PYEOF'
import gzip, glob, shutil

fw_files = glob.glob("/volume1/@appstore/com.ugreen.office/www/assets/ugos-framework-*.js.gz")
fw_files = [f for f in fw_files if not f.endswith('.bak')]

if not fw_files:
    print("  ОШИБКА: ugos-framework не найден!")
    exit(1)

fw_path = fw_files[0]
print(f"  Файл: {fw_path}")

if not fw_path.endswith('.bak.gz'):
    shutil.copy2(fw_path, fw_path + '.bak')

data = gzip.open(fw_path).read().decode()

# Патч 1: fallback язык (переменная может отличаться в разных версиях)
patched = False
for var in ['xn', 'et', 'nt', 'tt', 'lt', 'rt']:
    old = f'{var}="en-US"'
    if data.count(old) == 1:
        data = data.replace(old, f'{var}="ru-RU"', 1)
        print(f"  Патч 1 (fallback): {old} → {var}=\"ru-RU\"")
        patched = True
        break
if not patched:
    print("  ВНИМАНИЕ: fallback переменная не найдена, пропускаем")

# Патч 2: функция ready() — принудительно отдавать ru-RU родительскому окну
old2 = '"ugos:locale-sync-parent",{detail:{locale:e.locale}}'
new2 = '"ugos:locale-sync-parent",{detail:{locale:"ru-RU"}}'
if old2 in data:
    data = data.replace(old2, new2, 1)
    print("  Патч 2 (ready): locale:e.locale → locale:\"ru-RU\"")
else:
    print("  ВНИМАНИЕ: ready() паттерн не найден, пропускаем")

with gzip.open(fw_path, 'wb') as f:
    f.write(data.encode())
print("  ugos-framework пропатчен")
PYEOF

# --- Шаг 4: Добавляем ru-RU в config.json Office ---
echo "[4/6] Добавляем ru-RU в config.json..."

python3 - << 'PYEOF'
import json

path = "/volume1/@appstore/com.ugreen.office/config.json"
with open(path) as f:
    c = json.load(f)
if "ru-RU" not in c.get("languageList", []):
    c["languageList"].append("ru-RU")
    with open(path, 'w') as f:
        json.dump(c, f, indent=2)
    print("  ru-RU добавлен в languageList")
else:
    print("  ru-RU уже в списке")
PYEOF

# --- Шаг 5: Патч api.js OnlyOffice ---
echo "[5/6] Патч api.js (язык редактора OnlyOffice)..."

python3 - << 'PYEOF'
import gzip, shutil

api_path = "/volume1/@appstore/com.ugreen.office/onlyoffice/documentserver/web-apps/apps/api/documents/api.js"

shutil.copy2(api_path, api_path + '.bak')

with open(api_path) as f:
    data = f.read()

old = 'if (config.editorConfig && config.editorConfig.lang)\n            params += "&lang=" + config.editorConfig.lang;'
new = 'params += "&lang=ru";'

if old in data:
    data = data.replace(old, new)
    with open(api_path, 'w') as f:
        f.write(data)
    with open(api_path, 'rb') as fin:
        with gzip.open(api_path + '.gz', 'wb') as fout:
            fout.write(fin.read())
    print("  api.js пропатчен: lang=ru")
else:
    print("  ВНИМАНИЕ: паттерн в api.js не найден (возможно уже пропатчен)")
PYEOF

# --- Шаг 6: Перезапуск сервиса ---
echo "[6/6] Перезапуск office_serv..."
systemctl restart office_serv
sleep 3
if systemctl is-active --quiet office_serv; then
    echo "  Сервис запущен успешно"
else
    echo "  ОШИБКА: сервис не запустился"
    systemctl status office_serv --no-pager
fi

echo ""
echo "=== Готово! ==="
echo ""
echo "Действия на Mac:"
echo "  1. Закрыть приложение UGREEN NAS"
echo '  2. rm -rf "$HOME/Library/UGREEN_Nas_Pro/.cache/office/"'
echo '  3. rm -rf "$HOME/Library/Application Support/com.ugreen.desktop/Cache/Cache_Data/"'
echo "  4. Открыть приложение UGREEN NAS"
