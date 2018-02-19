#!/usr/bin/env bash

source /etc/monit/plugins/okfail.sh

if curl --fail -A "monit-ping-check" -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 5 "file://${1}/health.json"; then
    ok "Remote filesystem at ${1} is accessible"
else
    fail "Remote filesystem at ${1} is inaccessible!"
fi
