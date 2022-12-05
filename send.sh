#!/bin/bash
TMP=$(mktemp)
FROM_EMAIL_ADDRESS="teh@test.ru"
TO_EMAIL_ADDRESS="to@test.ru"
SMTP="smtp.test.ru:25"
FRIENDLY_NAME="test_from"
EMAIL_ACCOUNT_PASSWORD="pa$$w0rd"

DATA=$(echo -e "DO NOT REPLY TO THIS EMAIL !!!\n\nРаботающие по ночам компьютеры:\n--------------------------------------------" && nmap -sP 192.168.100.0/24 |grep "test.ru" | awk '{print $5}'| grep -Ev "gitlab|peregovor")
DATE=$(date +%A" "%d-%m-%Y" "%H:%M)

cat > $TMP << EOF
EOF

cat $TMP | \
        echo "${DATA}"| iconv -t UTF-8 | s-nail -v \
        -s "$DATE Включенные компьютеры:" \
        -S smtp-auth=login \
        -S smtp=${SMTP} \
        -S from="${FROM_EMAIL_ADDRESS}(${FRIENDLY_NAME})" \
        -S smtp-auth-user=$FROM_EMAIL_ADDRESS \
        -S smtp-auth-password=$EMAIL_ACCOUNT_PASSWORD \
        -S stealthmua=noagent \
        $TO_EMAIL_ADDRESS

[ -e $TMP ] && rm $TM
