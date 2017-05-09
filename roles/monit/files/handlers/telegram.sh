#!/usr/bin/env bash

source /etc/monit/handlers/tickets.sh

text=""
tail="\\\\nCheck name: $MONIT_SERVICE\\\\nDescription: $MONIT_DESCRIPTION"

case $MONIT_PROGRAM_STATUS in
  "0")
    text="✅✅✅"
    ;;
  "1")
    text="⚠️⚠️⚠️"
    ;;
  "2")
    text="❌❌❌"
esac

echo -e '{ "actionType": "SendMessage", "actionSettings": {"chatID": '`cat /etc/datasources/pisun-default-chat`', "replyToMessageID": 0, "text": "'"$text$tail"'", "disableWebPagePreview": true }}' | socat stdio unix-connect:/tmp/pisun.socket
exit 0
