#!/usr/bin/env bash

source /etc/datasources/squadcast.env

severity="low"

case $MONIT_PROGRAM_STATUS in
  "1")
    severity="medium"
    ;;
  "2")
    severity="high"
    ;;
esac

curl -X POST "https://api.squadcast.com/v2/incidents/api/${SQUADCAST_TOKEN}" \
    -H 'Content-Type: application/json' \
    -d "{ \"message\": \"${MONIT_SERVICE}\", \"description\": \"${MONIT_DESCRIPTION}\" }"

exit 0