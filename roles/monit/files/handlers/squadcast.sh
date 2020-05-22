#!/usr/bin/env bash

source /etc/datasources/squadcast.env

severity="low"

case $MONIT_PROGRAM_STATUS in
  "1")
    severity="#FFFF00"
    ;;
  "2")
    severity="#FF0000"
    ;;
esac

curl -X POST "https://api.squadcast.com/v2/incidents/api/${SQUADCAST_TOKEN}" \
    -H 'Content-Type: application/json' \
    -d "{ \"message\": \"${MONIT_SERVICE}\", \"description\": \"${MONIT_DESCRIPTION}\", \"severity\": {\"colour\": \"${severity}\"} }"

exit 0