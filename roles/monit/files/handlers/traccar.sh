#!/usr/bin/env bash

bot_token=`cat /etc/datasources/pisun.json | jq -r .token`
chat_id="tiredsysadmin"

text="$MONIT_DESCRIPTION"

case $MONIT_PROGRAM_STATUS in
  "0")
    break
    ;;
  "2")
    curl -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" \
        -H 'Content-Type: application/json' \
        -d "{ \"chat_id\": \"${chat_id}\", \"text\": \"${text}\" }"
    ;;
esac

#echo -e '{ "actionType": "SendMessage", "actionSettings": {"chatID": '`cat /etc/datasources/pisun-default-chat`', "replyToMessageID": 0, "text": "'"$text"'", "disableWebPagePreview": true }}' | socat stdio unix-connect:/var/run/apps/pisun.sock

exit 0