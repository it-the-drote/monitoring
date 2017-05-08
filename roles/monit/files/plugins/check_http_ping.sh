#!/usr/bin/env bash

source /etc/sensu/lib/okfail.sh

status=`curl -k -s --connect-timeout 10 --max-time 10 $1`

if [[ $status == "OK" ]]; then
    ok "Web-interface is OK"
else
    fail "Web-interface is down"
fi
