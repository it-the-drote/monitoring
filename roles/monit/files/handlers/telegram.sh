#!/usr/bin/env bash

source /usr/lib/leicht/leicht.sh

text=""

case $MONIT_PROGRAM_STATUS in
  "0")
    text="✅✅✅ $MONIT_DESCRIPTION"
    ;;
  "1")
    text="⚠️⚠️⚠️ $MONIT_DESCRIPTION"
    ;;
  "2")
    text="❌❌❌ $MONIT_DESCRIPTION"
esac

leicht_send_message `cat /etc/datasources/pisun-default-chat` "0" "[sensu] $text" "false" /tmp/pisun.socket
exit 0
