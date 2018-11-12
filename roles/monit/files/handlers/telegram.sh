#!/usr/bin/env bash

text=""
tail="\\\\nCheck name: $MONIT_SERVICE\\\\nDescription: $MONIT_DESCRIPTION"

case $MONIT_PROGRAM_STATUS in
  "0")
    text="✅✅✅\\\\n$tail"
    ;;
  "1")
    text="⚠️⚠️⚠️\\\\n$tail"
    ;;
  "2")
    text="❌❌❌\\\\n$tail"
esac

echo -e '{ "actionType": "SendMessage", "actionSettings": {"chatID": '`cat /etc/datasources/pisun-default-chat`', "replyToMessageID": 0, "text": "'"$text"'", "disableWebPagePreview": true }}' | socat stdio unix-connect:/var/run/apps/pisun.socket
exit 0
