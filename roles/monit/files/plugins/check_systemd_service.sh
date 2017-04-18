#!/usr/bin/env bash

source /etc/monit/plugins/okfail.sh

service_status=`systemctl is-active $1`

if [[ $service_status == 'active' ]]; then
    ok "Unit $1 is alive."
else
    fail "Unit $1 is down!"
fi