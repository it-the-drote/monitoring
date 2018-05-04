#!/usr/bin/env bash

IFS=$'\n'
ENV_FILE='/etc/datasources/backups.env'
BACKUP_DIRECTORY='/var/storage/yandex-disk/waste/server/backups/databases/'
LOG_FILE='/var/log/apps/database-backups.log'
PREFIX="[ `date` ] "

MYSQL_BACKUPS='nextcloud
xmpp'

source $ENV_FILE

for i in $MYSQL_BACKUPS; do
  DUMP_FILE="${i}-`date '+%Y_%m_%d'`.sql"
  cd /tmp && mysqldump -u $MYSQL_USERNAME -p$MYSQL_PASSWORD $i > $DUMP_FILE && echo "${PREFIX}MySQLdump OK" >> $LOG_FILE
  mcrypt $DUMP_FILE -k $ENCRYPTION_PASSWORD -z && echo "Mcrypt OK"
  mv "${DUMP_FILE}.gz.nc" "${BACKUP_DIRECTORY}/${i}" && echo "${PREFIX}Uploading ${DUMP_FILE} to Disk OK" >> $LOG_FILE
  rm $DUMP_FILE
  sync
  OLD_FILE="${i}-`date --date='7 days ago' '+%Y_%m_%d'`.sql"
  rm "${BACKUP_DIRECTORY}/${OLD_FILE}" && echo "${PREFIX}Old backups rotation OK" >> $LOG_FILE
done