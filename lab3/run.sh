#!/bin/bash

# === Переменные ===
TARGET_HOST="192.168.3.105"  # IP или хост удаленного сервера
PORTS=(21 23 22)            # Порты FTP, TELNET, SSH

# Проверка доступности хоста
ping -c 1 "$TARGET_HOST" > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "❌ Хост $TARGET_HOST недоступен!"
    exit 1
fi

# Функция для получения баннера
get_banner() {
    local port=$1
    echo -e "\n🔍 Проверка порта $port..."
    (echo; sleep 1) | nc -v -w 3 "$TARGET_HOST" "$port" 2>&1 | tee "banner_$port.txt"
}

# Извлечение баннеров
for port in "${PORTS[@]}"; do
    get_banner "$port"
done

echo "✅ Извлечение баннеров завершено!"
