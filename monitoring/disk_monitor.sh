#!/bin/bash

SMTP_SERVER="smtp.gmail.com"
SMTP_PORT=587
EMAIL_FROM="example@gmail.com"
EMAIL_TO="example@gmail.com"
SMTP_PASSWORD="example"
ALERT_THRESHOLD=70

if ! command -v swaks &> /dev/null; then
    echo "Установка swaks..."
    sudo apt install -y swaks || { echo "Ошибка установки swaks"; exit 1; }
fi

DISK_USAGE=$(df --output=pcent / | tail -1 | tr -d '% ')

echo "[$(date)] Проверка диска: занято ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge "$ALERT_THRESHOLD" ]; then
    echo "Внимание! Диск заполнен на ${DISK_USAGE}% (порог: ${ALERT_THRESHOLD}%). Отправка уведомления..."
    
    swaks --to $EMAIL_TO \
          --from $EMAIL_FROM \
          --server $SMTP_SERVER:$SMTP_PORT \
          --auth LOGIN \
          --auth-user $EMAIL_FROM \
          --auth-password "$SMTP_PASSWORD" \
          -tls \
          --header "Subject: Дисковое пространство на сервере" \
          --body "Занято ${DISK_USAGE}% на диске. Требуется очистка!"
fi