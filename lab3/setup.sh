#!/bin/bash

# === Обновление пакетов и установка необходимых утилит ===
echo "⚙️ Обновляем список пакетов..."
sudo apt update

echo "⚙️ Устанавливаем необходимые компоненты..."
sudo apt install -y ftp telnet openssh-client openssh-server vsftpd inetutils-telnetd xinetd net-tools ufw

# === Запуск и проверка служб ===
echo "🔄 Проверяем и запускаем службы..."

# SSH
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
echo "✅ SSH-сервер запущен!"

# FTP (vsftpd)
sudo systemctl enable --now vsftpd
sudo systemctl status vsftpd --no-pager
echo "✅ FTP-сервер запущен!"

# Telnet
sudo systemctl enable --now inetutils-telnetd
sudo systemctl status inetutils-telnetd --no-pager
echo "✅ Telnet-сервер запущен!"

# Настройка xinetd для Telnet
echo "🔧 Настраиваем xinetd для Telnet..."
echo "service telnet
{
    disable = no
    flags = REUSE
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/telnetd
    log_on_failure += USERID
}" | sudo tee /etc/xinetd.d/telnet

# Перезапуск xinetd
sudo systemctl restart xinetd

echo "✅ Конфигурация Telnet обновлена и сервис перезапущен!"

# === Проверка доступности портов ===
echo "🔍 Проверяем открытые порты..."
sudo netstat -tulnp | grep -E ':(21|22|23)'

# === Открытие портов в Firewall ===
echo "🔓 Открываем порты в firewall..."
sudo ufw allow 21/tcp
sudo ufw allow 22/tcp
sudo ufw allow 23/tcp
sudo ufw reload

# Открытие порта 23 в iptables (если ufw не используется)
echo "🔓 Открываем порт 23 в iptables..."
sudo iptables -A INPUT -p tcp --dport 23 -j ACCEPT
sudo iptables-save | sudo tee /etc/iptables/rules.v4

echo "✅ Установка, запуск и настройка завершены!"
