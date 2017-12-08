#!/usr/bin/env bash

ENV_FILE='/etc/datasources/backups.env'
BACKUP_DIRECTORY='/var/storage/yandex-disk/waste/server/backups/databases/'
MYSQL_BACKUPS='nextcloud'

source $ENV_FILE

for i in $MYSQL_BACKUPS; do
  DUMP_FILE="${i}-`date '+%Y_%m_%d'`.sql"
  cd /tmp && mysqldump -u $MYSQL_USERNAME -p$MYSQL_PASSWORD $i > $DUMP_FILE && echo "MySQLdump OK"
  mcrypt $DUMP_FILE -k $ENCRYPTION_PASSWORD -z && echo "Mcrypt OK"
  mv "${DUMP_FILE}.gz.nc" "${BACKUP_DIRECTORY}/${i}" && "Uploading ${DUMP_FILE} to Disk OK"
  rm $DUMP_FILE
  sync
  OLD_FILE="${i}-`date --date='7 days ago' '+%Y_%m_%d'`.sql"
  rm "${BACKUP_DIRECTORY}/${OLD_FILE}" && "Old backups rotation OK"
done