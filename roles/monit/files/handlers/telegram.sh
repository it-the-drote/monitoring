#!/usr/bin/env bash

source /etc/monit/handlers/tickets.sh

login_url=`cat /etc/datasources/http2ssh_login.txt`
text=""
tail="\\\\nCheck name: $MONIT_SERVICE\\\\nDescription: $MONIT_DESCRIPTION"

case $MONIT_PROGRAM_STATUS in
  "0")
    text="✅✅✅\\\\n$tail"
    ;;
  "1")
    text="⚠️⚠️⚠️\\\\n$tail\\\\n\\\\nLogin: $login_url"
    ;;
  "2")
    text="❌❌❌\\\\n$tail\\\\n\\\\nLogin: $login_url"
esac

echo -e '{ "actionType": "SendMessage", "actionSettings": {"chatID": '`cat /etc/datasources/pisun-default-chat`', "replyToMessageID": 0, "text": "'"$text"'", "disableWebPagePreview": true }}' | socat stdio unix-connect:/var/run/apps/pisun.socket
exit 0
