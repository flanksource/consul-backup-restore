#!/bin/bash

set -ex

BACKUP_FILE=$(mktemp /tmp/consul-backup.XXXXXX)
rm $BACKUP_FILE

SSL_OPTS=""

if [[ "$AWS_ENDPOINT" =~ ^http\:\/\/ ]]; then
  SSL_OPTS="--no-ssl"
fi

s3cmd --host=$AWS_ENDPOINT \
      --host-bucket=$AWS_ENDPOINT/$BACKUP_BUCKET $SSL_OPTS \
      --acl-private \
      get s3://$BACKUP_BUCKET/$BACKUP_PATH$RESTORE_FILENAME $BACKUP_FILE

consul snapshot restore -http-addr=$CONSUL_ADDR $BACKUP_FILE

rm $BACKUP_FILE
